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
    public static void playExternalTrack(Context c, String p) {
        try {
            if (mediaPlayer != null) { mediaPlayer.stop(); mediaPlayer.release(); }
            mediaPlayer = new MediaPlayer();
            mediaPlayer.setDataSource(p);
            mediaPlayer.setWakeMode(c, PowerManager.PARTIAL_WAKE_LOCK);
            mediaPlayer.prepare();
            mediaPlayer.start();
        } catch (Exception e) { e.printStackTrace(); }
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
}
