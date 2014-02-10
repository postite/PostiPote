i can't give you a working extension nor i can share my code directly
(it has critical code that i can't share for security), but i can tell
you how to do it:

1) create a main java file like this and define a static function that
receives the haxe object:

public class MainApp extends org.haxe.lime.GameActivity {
public static HaxeObject callback;

public static void main(String[] args) {
// TODO Auto-generated method stub

}
public static void filesIntent(HaxeObject cb){
callback = cb;
getInstance().startActivityForResult(new
Intent(getInstance().getContext(),IntentManagerZ.class).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK),1);
}

}

this uses getInstance() that is defined by GameActivity. and start a
new activity (a must to show the camera), this code specifically uses
an Intent as activity but you can pass directly the activity of the
camera. see that also we are setting up the callback passed in a
member static variable.

2) create a class that is the activity itself:

public class IntentManagerZ  extends Activity {

public static IntentManagerZ instance = null;
private static final int CAMERA_REQUEST = 1888;
public static final int VIEW_NUM = 6;
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
  c = getApplicationContext();
  instance = this;
  LinearLayout ll = new LinearLayout(c);
  LayoutParams lp = new LayoutParams(LayoutParams.FILL_PARENT,
               LayoutParams.FILL_PARENT);
  ll.setLayoutParams(lp);
  ll.setOrientation(LinearLayout.VERTICAL);
  ll.setGravity(Gravity.CENTER_HORIZONTAL);
  ll.setVerticalGravity(Gravity.CENTER_VERTICAL);
  ProgressBar bar = new
ProgressBar(c,null,android.R.attr.progressBarStyleInverse);
  ll.addView(bar);
  setContentView(ll);
  makeIntent(MainApp.callback);
  // TODO Auto-generated method stub
}

public void makeIntent(HaxeObject cb){
Log.d("starting intent", "init intent 1");
callback=cb;
  final List<Intent> cameraIntents = new ArrayList<Intent>();
  //final Intent captureIntent = new
Intent(c,android.provider.MediaStore.class);
  //captureIntent.setAction(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
  final Intent captureIntent = new
Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
  tmpFILE = filemanager.getTmpFile();

  tmpURI = Uri.fromFile(tmpFILE);
  captureIntent.putExtra(MediaStore.EXTRA_OUTPUT, tmpURI);
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

protected void onActivityResult(int requestCode, int resultCode, Intent data) {
Log.e("onResult 1", "on result = 1");
super.onActivityResult(requestCode, resultCode, data);
Log.e("onResult 1", "on result = 2");
if (requestCode == CAMERA_REQUEST && resultCode == RESULT_OK) {
Log.e("onResult 1", "on result = 3");

       final String action = data.getAction();
       if(action!=null){
       /*try{
       tmpURI = data.getData();
       //resultPhoto =
Bitmap.createScaledBitmap(MediaStore.Images.Media.getBitmap(this.getContentResolver(),
tmpURI), resizeW, resizeH, false);
      /// setTittleAct("is2 "+"w = "+photo.getWidth()+" h =
"+photo.getHeight());
       imageView.setImageOnElem(photo,getFileOrientation(tmpFILE));
 }catch (FileNotFoundException ex){
 }catch (IOException ex){
 }*/

       resultOrientation =  getFileOrientation(tmpFILE.getAbsolutePath());
       Log.d("activityres 1 =
",""+tmpFILE.getAbsolutePath()+";"+resultOrientation);
       callback.call("deviceGalleryFileSelectCallback", new Object[]
{""+tmpFILE.getAbsolutePath()+";"+resultOrientation});

finish();
}

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

}

this code, more or less should work (fix some typos, or something that
maybe is missing from my propiertary code, but should show you the
Intent with the code and return the file path). i only included the
code for the camera, if you select gallery or something else, this
will not know how to handle and it will not work. it also resize it to
800x600

makeIntent() = does the show of the intent
onActivityResult() = this will receive the data from the camera and
call the callback

callback.call("deviceGalleryFileSelectCallback", new Object[]
{""+tmpFILE.getAbsolutePath()+";"+resultOrientation});
this calls your callback (function name:
deviceGalleryFileSelectCallback in haxe) and return a String with the
filepath;orientation

3) call it from haxe and define the callback:

//getting the function from JNI
filesIntentFunc:Dynamic =
JNI.createStaticMethod("com/ipsilondev/tryoutonme/MainApp",
"filesIntent", "(Lorg/haxe/lime/HaxeObject;)V",true);

//calling the function
//instance = this in Main.hx
#if android
openfl.flash.Lib.postUICallback( function()
{
var ar:Array<Dynamic> = [instance];
filesIntentFunc(ar);
} );
#end
//declaring callback
public function deviceGalleryFileSelectCallback(i:String) {

}

4) be sure to include it in the app .xml where the java source are

<java path="lib/jn/src" if="android"></java>

5) use a modified manifest:

<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
android:installLocation="::ANDROID_INSTALL_LOCATION::"
android:versionCode="::APP_BUILD_NUMBER::"
android:versionName="::APP_VERSION::" package="::APP_PACKAGE::">

<application android:label="::APP_TITLE::"
android:debuggable="true"::if (HAS_ICON)::
android:icon="@drawable/icon"::end::>
::if WIN_REQUIRE_SHADERS::<uses-feature
android:glEsVersion="0x00020000" android:required="true" />::elseif
WIN_ALLOW_SHADERS::<uses-feature android:glEsVersion="0x00020000"
android:required="false" />::end::
<activity android:name="IntentManagerZ"
android:screenOrientation="portrait"
android:configChanges="locale"></activity>
<activity android:name="MainActivity" android:label="::APP_TITLE::"
android:screenOrientation="portrait">
<intent-filter>
<action android:name="android.intent.action.MAIN" />
<category android:name="android.intent.category.LAUNCHER" />
</intent-filter>
</activity>
</application>

<uses-sdk android:minSdkVersion="8"/>
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-feature android:name="android.hardware.camera"></uses-feature>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

</manifest>

this is a must to start a new activity and use things like external
storage and the camera, also, in the app .xml include this to use this
manifest and not the one in the openfl build

<template path="AndroidManifest.xml" if="android" />

all of this should get you a working extension more or less, is not an
easy task, it took me like 2 weeks to have all of this stuff working,
plus another week to have it done on iOS with objetive-c

good luck ! :)

Regards.

2014-02-09 david@postite.com <ronpish@gmail.com>:
don't take me wrong.
i have nothing at all on the java side at the moment.
i thought you could eventually willing share the extension you were talking about in your post.

But i guess i have to try a bit by myself :)
i'll do that and eventually come back to you if i can dare.

thx for your time.

David