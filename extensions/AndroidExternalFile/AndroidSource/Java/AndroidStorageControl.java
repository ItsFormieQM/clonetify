package com.formerhyde.clonetify;
import android.os.Build;
import android.os.Environment;
import android.os.PowerManager;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;
import android.app.Activity;
import android.media.MediaPlayer;
public class AndroidStorageControl {
    public static MediaPlayer mediaPlayer = null;
    private static Activity getActivityContext() {
        try {
            Class<?> c = Class.forName("android.app.ActivityThread");
            Object o = c.getMethod("currentActivityThread").invoke(null);
            java.lang.reflect.Field f = c.getDeclaredField("mActivities");
            f.setAccessible(true);
            for (Object r : ((java.util.Map<?,?>)f.get(o)).values()) {
                java.lang.reflect.Field p = r.getClass().getDeclaredField("paused");
                p.setAccessible(true);
                if (!p.getBoolean(r)) {
                    java.lang.reflect.Field a = r.getClass().getDeclaredField("activity");
                    a.setAccessible(true);
                    return (Activity) a.get(r);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
    public double checkFullStoragePermission() {
        return (Build.VERSION.SDK_INT >= 30) ? (Environment.isExternalStorageManager() ? 1.0 : 0.0) : 1.0;
    }
    public void requestFullStoragePermission() {
        Activity a = getActivityContext();
        if (a == null || Build.VERSION.SDK_INT < 30) return;
        try {
            Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
            intent.setData(Uri.fromParts("package", a.getPackageName(), null));
            a.startActivity(intent);
        } catch (Exception e) {
            Intent intent = new Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
            a.startActivity(intent);
        }
    }
    public static void playExternalTrack(final Context context, final String absolutePath) {
        try {
            if (mediaPlayer != null) {
                mediaPlayer.stop();
                mediaPlayer.release();
                mediaPlayer = null;
            }

            mediaPlayer = new MediaPlayer();
            
            // ✅ FORCE TRACK LOOPING: Automatically repeat the audio when it finishes playing
            mediaPlayer.setLooping(true);
            
            // ✅ SAFELY SECURE PRIVILEGES: Open a native streaming byte connection to the file
            java.io.File file = new java.io.File(absolutePath);
            if (file.exists()) {
                java.io.FileInputStream fis = new java.io.FileInputStream(file);
                // Extract the low-level hardware file descriptor to bypass Android path blocks
                mediaPlayer.setDataSource(fis.getFD());
                fis.close(); // Safely release the loose hook pointer reference
            } else {
                android.util.Log.e("Clonetify", "File does not exist on disk: " + absolutePath);
                return;
            }

            mediaPlayer.setWakeMode(context, PowerManager.PARTIAL_WAKE_LOCK);
            
            mediaPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer mp) {
                    mp.start();
                }
            });
            
            mediaPlayer.prepareAsync(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void stopExternalTrack() { if (mediaPlayer != null) { mediaPlayer.stop(); mediaPlayer.release(); mediaPlayer = null; } }
    public static void pauseExternalTrack() { if (mediaPlayer != null && mediaPlayer.isPlaying()) mediaPlayer.pause(); }
    public static void resumeExternalTrack() { if (mediaPlayer != null && !mediaPlayer.isPlaying()) mediaPlayer.start(); }
    public static double checkBackground(Activity a, Context c) {
        if (Build.VERSION.SDK_INT >= 23) {
            PowerManager pm = (PowerManager) a.getSystemService(Context.POWER_SERVICE);
            return pm.isIgnoringBatteryOptimizations(c.getPackageName()) ? 1.0 : 0.0;
        }
        return 1.0;
    }
    public static void requestBackground(Activity a, Context c) {
        if (Build.VERSION.SDK_INT < 23) return;
        try {
            Intent intent = new Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, Uri.parse("package:" + c.getPackageName()));
            a.startActivity(intent);
        } catch (Exception e) {
            a.startActivity(new Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS));
        }
    }
	public static double isExternalTrackPlaying() {
        if (mediaPlayer != null) {
            try {
                return mediaPlayer.isPlaying() ? 1.0 : 0.0;
            } catch (Exception e) {
                return 0.0; // Returns 0 if the player is in an uninitialized/error state
            }
        }
        return 0.0;
    }
	public static void scanDirectoryAsync(final String targetPath) {
        // Spawns a completely separate CPU thread to keep GameMaker at 60 FPS
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    java.io.File dir = new java.io.File(targetPath);
                    if (dir.exists() && dir.isDirectory()) {
                        java.io.File[] files = dir.listFiles();
                        if (files != null) {
                            StringBuilder sb = new StringBuilder();
                            for (java.io.File file : files) {
                                if (file.isFile()) {
                                    String name = file.getName().toLowerCase();
                                    // Ultra-fast format stream filter checks
                                    if (name.endsWith(".mp3") || name.endsWith(".ogg") || name.endsWith(".wav") || name.endsWith(".m4a") || name.endsWith(".mp4") || name.endsWith(".flac")) {
                                        sb.append(file.getAbsolutePath()).append("|");
                                    }
                                }
                            }

                            // Package the string payload into a GameMaker data slot map
                            int dsMap = com.yoyogames.runner.RunnerJNILib.jCreateDsMap(null, null, null);
                            com.yoyogames.runner.RunnerJNILib.DsMapAddString(dsMap, "type", "clonetify_scan_complete");
                            com.yoyogames.runner.RunnerJNILib.DsMapAddString(dsMap, "raw_data", sb.toString());
                            
                            // Broadcast the data map directly to GML's Async Social Event handler (Code ID 70)
                            com.yoyogames.runner.RunnerJNILib.CreateAsynEventWithDSMap(dsMap, 70);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start(); // Detaches the execution layer immediately from the main game loop
    }

}
