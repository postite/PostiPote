package com.example.androidshare;
import org.haxe.lime.HaxeObject;
import android.os.Bundle;
import  android.util.Log;
import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import java.util.ArrayList;
import java.util.List;
import android.net.Uri;
import  java.io.File;
import android.content.pm.PackageManager;
import android.provider.MediaStore;
import android.content.pm.ResolveInfo;
import  android.content.ComponentName;
import android.os.Parcelable;
import  android.graphics.Bitmap;
import java.io.FileNotFoundException;
import  java.io.IOException;
import android.database.Cursor;
public class IntentManagerZ  extends Activity {

  public static IntentManagerZ instance = null;
  private static final int CAMERA_REQUEST = 1888;
  public static final int VIEW_NUM = 6;
  private static final int SELECT_PICTURE = 1;
  private static Uri tmpURI;
  private static File tmpFILE;
  public int resultInt = 0;
  public int resultOrientation = 0;
  static HaxeObject callback;
  public Context c;


  public void main(String[] args) {
// TODO Auto-generated method stub
  }
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Log.e("hop","hip");
    c = getApplicationContext();
    instance = this;
//   LinearLayout ll = new LinearLayout(c);
//   LayoutParams lp = new LayoutParams(LayoutParams.FILL_PARENT,
//                LayoutParams.FILL_PARENT);
//   ll.setLayoutParams(lp);
//   ll.setOrientation(LinearLayout.VERTICAL);
//   ll.setGravity(Gravity.CENTER_HORIZONTAL);
//   ll.setVerticalGravity(Gravity.CENTER_VERTICAL);
//   ProgressBar bar = new
// ProgressBar(c,null,android.R.attr.progressBarStyleInverse);
//   ll.addView(bar);
//   setContentView(ll);
    makeIntent(MainApp.callback);
 // TODO Auto-generated method stub
  }


  public void makeIntent(HaxeObject cb){
    Log.d("starting intent", "init intent 1");
    callback=cb;
    final List<Intent> cameraIntents = new ArrayList<Intent>();
  // final Intent captureIntent = new Intent(c,android.provider.MediaStore.class);
  // captureIntent.setAction(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
    final Intent captureIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
  //tmpFILE = filemanager.getTmpFile();

//tmpURI = Uri.fromFile(tmpFILE);
  //captureIntent.putExtra(MediaStore.EXTRA_OUTPUT, tmpURI);
    final PackageManager packageManager = c.getPackageManager();
    final List<ResolveInfo> listCam =
    packageManager.queryIntentActivities(captureIntent, 0);
    for(ResolveInfo res : listCam) {
      final String packageName = res.activityInfo.packageName;
      final Intent intent = new Intent(captureIntent);
      intent.setComponent(new
        ComponentName(res.activityInfo.packageName, res.activityInfo.name));
      intent.setPackage(packageName);
      cameraIntents.add(intent);
    }

  // Filesystem.
    final Intent galleryIntent = new Intent();
    galleryIntent.setType("image/*");
    galleryIntent.setAction(Intent.ACTION_GET_CONTENT);

  // Chooser of filesystem options.
    final Intent chooserIntent = Intent.createChooser(galleryIntent,
      "Select Source");

  // Add the camera options.
    chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS,
      cameraIntents.toArray(new Parcelable[]{}));
  //resultInt = 0;
    instance.startActivityForResult(chooserIntent, CAMERA_REQUEST);
    Log.d("starting intent", "init intent 2");
  }
/*
*/
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
  Log.e("onResult 1", "on result = 1");
  super.onActivityResult(requestCode, resultCode, data);
  Log.e("onResult 1", "on result = 2");
  if (requestCode == CAMERA_REQUEST && resultCode == RESULT_OK) {
   Log.e("onResult 1", "on result = 3");

   final String action = data.getAction();
   if(action!=null){
     Log.e("onResult 1", "on result = 4");
     try{
       Log.e("onResult 1", "on result = 5");
       tmpURI = data.getData();
       Bitmap resultPhoto =  Bitmap.createScaledBitmap(MediaStore.Images.Media.getBitmap(this.getContentResolver(),
        tmpURI), 200, 200, false);
       Log.e("photo",resultPhoto.getWidth()+"px");
          // setTittleAct("is2 "+"w = "+photo.getWidth()+" h ="+photo.getHeight());
           //imageView.setImageOnElem(photo,getFileOrientation(tmpFILE));
     }catch (FileNotFoundException ex){
      Log.e("err", "error1");
    }catch (IOException ex){
      Log.e("err", "error1");
    }
  }
  Log.e("onResult 1", "on result = 6");
      //resultOrientation =  getFileOrientation(tmpFILE.getAbsolutePath());
     // Log.d("activityres 1 =",""+tmpFILE.getAbsolutePath()+";");
//        callback.call("deviceGalleryFileSelectCallback", new Object[]
// {""+tmpFILE.getAbsolutePath()+";"+resultOrientation});
}
if (resultCode == RESULT_OK) {
  Log.e("onResult 1", "on result = 7request code="+requestCode);
  if (requestCode == 1888) {
    Log.e("onResult 1", "on result = 8 request code="+requestCode);
    Uri selectedImageUri = data.getData();
    String selectedImagePath = getPath(selectedImageUri);
    Log.e("selct",selectedImagePath);
    // callback.call("deviceGalleryFileSelectCallback", new Object[]
    //   {""+selectedImagePath});
    callback.call("deviceGalleryFileSelectCallback",new Object[]{""+selectedImagePath+""});
  }
}
 finish();
//}

}
/*

public int getFileOrientation(Uri l){
ExifInterface exif;
String[] proj = { MediaStore.Images.Media.DATA };
     Cursor cursor = getContentResolver().query(l, proj, null, null, null);
  int column_index =
cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
      cursor.moveToFirst();
      String fileOrient = "";
      int degreesOrient = 0;
      try{
       exif = new ExifInterface(cursor.getString(column_index));
       fileOrient = exif.getAttribute(ExifInterface.TAG_ORIENTATION);
      }catch (IOException ex){

      }
      if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_90){
       degreesOrient = 90;
     }
      else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_180){
      degreesOrient = 180;
     }else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_270){
       degreesOrient = 270;
      }
      return degreesOrient;
}

public int getFileOrientation(File l){
ExifInterface exif;
      String fileOrient = "";
      int degreesOrient = 0;
      try{
       exif = new ExifInterface(l.getAbsolutePath());
       fileOrient = exif.getAttribute(ExifInterface.TAG_ORIENTATION);
      }catch (IOException ex){

      }
      if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_90){
       degreesOrient = 90;
     }
      else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_180){
      degreesOrient = 180;
     }else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_270){
       degreesOrient = 270;
      }
      return degreesOrient;
}

public int getFileOrientation(String q){
ExifInterface exif;
      String fileOrient = "";
      int degreesOrient = 0;
      try{
       exif = new ExifInterface(q);
       fileOrient = exif.getAttribute(ExifInterface.TAG_ORIENTATION);
      }catch (IOException ex){

      }
      if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_90){
       degreesOrient = 90;
     }
      else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_180){
      degreesOrient = 180;
     }else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_270){
       degreesOrient = 270;
      }
      return degreesOrient;
}
public String getFullPathUri(Uri l){
String[] proj = { MediaStore.Images.Media.DATA };
     Cursor cursor = getContentResolver().query(l, proj, null, null, null);
  int column_index =
cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
      cursor.moveToFirst();
      return cursor.getString(column_index);
}
*/


public String getPath(Uri uri) {
            // just some safety built in 
  if( uri == null ) {
                // TODO perform some logging or show user feedback
    return null;
  }
            // try to retrieve the image from the media store first
            // this will only work for images selected from gallery
  String[] projection = { MediaStore.Images.Media.DATA };
  Cursor cursor = managedQuery(uri, projection, null, null, null);
  if( cursor != null ){
    int column_index = cursor
    .getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
    cursor.moveToFirst();
    return cursor.getString(column_index);
  }
            // this is our fallback here
  return uri.getPath();
}
}