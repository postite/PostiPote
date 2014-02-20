package com.postite.mob.services;
import flash.net.URLLoader;
import flash.utils.ByteArray;
import com.postite.mob.services.HaxeMultipart;
import msignal.Signal;
import flash.events.*;
import com.postite.mob.model.Postite;
class CrossSend  extends mmvc.impl.Actor{

	#if local
	static var serverBase="http://localhost:8888";
	#else
	static var serverBase="http://postite.alwaysdata.net";
	#end
	static var upScript=serverBase+"/up/multi";
	public var recorded:Signal0= new Signal0();
	public var error:Signal0= new Signal0();

	public function upM(_vo:Postite):Void
	{
		

		var MP=new HaxeMultipart(upScript);

		MP.addField("titre",_vo.titre);
		//MP.addField("date",_vo.date.toString());
		//MP.addFile("file1",_vo.src,"application/octet-stream",'postite_${_vo.date}.jpg');




		trace( "after fields");
		//move that to Multipart
		
			
			try {

				trace( "go request");
				
				 MP.request.request(true);

				 
				
			} catch (error: Dynamic) {
				trace( "Unable to load requested document : "+error.message);
			}
			/// there 's a freeze before requets returns
		trace("request sent");
	}
	
	function err(e:Event)
	{
		trace (e.type);
		switch (e.type){
			case "IO_ERROR": trace("verifier connexion internet");
		}
		error.dispatch();
	}
	 function onComplete (e: Event):Void {
	 	trace("complete");

	 	//signal
	 	//note.kill();
		trace (untyped e.target.data);
		
		recorded.dispatch();
	}
}