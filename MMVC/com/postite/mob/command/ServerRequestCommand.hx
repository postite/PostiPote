package com.postite.mob.command;

import msignal.Signal;
import com.postite.mob.services.Send;
import com.postite.mob.services.CrossSend;
import com.postite.mob.signal.NoteSignal.Note;

import com.postite.mob.Api;
class ServerRequestCommand extends mmvc.impl.Command {

	@inject public var mod:IModel;
	@inject public var switchState:com.postite.mob.signal.SwitchStateSignal;
	//@inject public var sign:com.postite.signal.BasicSignal;
	//@inject public var BA:flash.utils.ByteArray;
	@inject public var note:com.postite.mob.signal.NoteSignal;
	override public function execute()
	{
		trace("execute server request");
		note.dispatch(new Note("loading",WAIT,false));
		

		//TODO prod only
		// var sender=new Send();
		 var sender=new Send();
		 sender.recorded.add(complete);
		 sender.error.add(complete);
		 sender.upM(mod.postite);

		//complete();
	}

	function complete(){
		//note.kill();
		trace( "complete");
		note.complete.dispatch();
		//switchState.dispatch(null);
		//note.complete.dispatch();
		//note=new Note(this,"done",true,INFO);
		untyped(this.signal).complete.dispatch("vo recorded");
	}
	function error(){
		//note.kill();

		note.complete.dispatch();
		//switchState.dispatch(null);
		//note.complete.dispatch();
		//note=new Note(this,"done",true,INFO);
		untyped(this.signal).complete.dispatch("error");
	}

}