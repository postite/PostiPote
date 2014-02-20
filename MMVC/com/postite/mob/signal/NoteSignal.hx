package com.postite.mob.signal;

import flash.display.DisplayObject;
import msignal.Signal;

class NoteSignal extends Signal1<Note>{

	public var ref:INotif;
	public var complete:Signal0;
	
	public function new(){
		complete= new Signal0();
		super(Note);
	}

}
interface INotif{
	public function kill():Void;
	
}
enum NoteType{
	INFO;
	ERROR;
	WAIT;
}
@:publicFields
class Note{
	var message:String;
	var type:NoteType;
	var autoKill:Bool;
	var display:DisplayObject;
	public function new (_message:String,_type:NoteType,?_autoKill:Bool=true,?_display:DisplayObject):Void{
		message=_message;
		type=_type;
		autoKill= _autoKill;
		display=_display;
	}
	function toString():String
	{
		return ('$message \n $type \n $autoKill \n $display');
	}

}