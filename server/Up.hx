package server;
import haxe.web.Dispatch;
#if neko import neko.Web;#end
#if php import php.Web;#end

import sys.io.File;
import sys.io.FileOutput;
import cross.CrossConfig.*;
class Up
{
	public function new()
	{
		
	}


	
	// function doUp(args:{popi:String,id:Null<Int>})
	// {
	// 	untyped Sys.print("hop" +args.popi + args.id*2);
	// }
	function doTest()
	{
		Sys.print("olé");
	}
	
	
	function doMulti()
	{
		currentVO= new Postite();
		currentVO.date= Date.now();
		Web.parseMultipart( onInfo,onData);
		trace( "insert vo");
		Web.getPos
		currentVO.insert();
	}
	private var currentVO:Postite;
	private var currentFile : FileOutput;
    private var currentFileName : String;
    private var currentFieldName : String;
    private var currentFileFieldName : String;
    private var currentIsFile : Bool;
    private var currentWrittenByte : Int;
	function onInfo(fieldName : String, fileName : String):Void
	{
		trace( "info");
		if (fileName != "") //That's a file
		{
            currentIsFile = true;
            trace( fileName);
            trace( fieldName);
            if (currentFile != null) //This is not the first file
            {
				currentFile.close();
				if (currentWrittenByte == 0)
				{
					//hashFile.remove(currentFileFieldName);
				}
            }
            
            currentWrittenByte = 0;
            currentFileFieldName = fieldName;
            currentFileName=fileName;
			//FIXME : Maybe make a config entry for temp directory ?



			//var tmpPath = Path.directory(Web.getCwd())+"/www/runtime/cache/igni-"+haxe.Md5.encode(Std.string(Math.random() + Math.random()));
			//hashFile.set(fieldName, new FileInfo(fileName, tmpPath));

			currentFile = File.write(uploadPath+"/"+fileName, true);

		}
        else //That's a regular field
        {
            currentFieldName = fieldName;
            Sys.print("currentFieldName"+currentFieldName);
            currentIsFile = false;
        }
		//Sys.print("onPart"+fileName +"field="+fieldName );
	}
	function onData(data : haxe.io.Bytes, pos : Int, length : Int):Void
	{
		trace( "yi");
		 if (currentIsFile)
        {
        	trace( "isFile");
        	currentVO.src=currentFileName;
            currentFile.writeBytes(data, pos, length);
            currentWrittenByte += length;
        }
        else
        {
        	trace( "isField");
        	//currentVO.titre=data.readString(pos, length);
        	Reflect.setProperty(currentVO,currentFieldName,data.readString(pos, length));
        	Sys.print("currentFieldName"+currentFieldName);
        	Sys.print("currentFieldvalue"+data.readString(pos, length));
        	//File.saveContent('$currentFieldName.txt',data.readString(pos, length));
            // if (fields.exists(currentFieldName))
            // {
            //     fields.set(currentFieldName, fields.get(currentFieldName) + data.readString(pos, length));
            // }
            // else
            // {
            //     fields.set(currentFieldName, data.readString(pos, length));
            // }
        }
        // if(currentVO.id==null)
        // currentVO.insert();
        // else
        // currentVO.update();

		Sys.print("ondata" );
	}
}