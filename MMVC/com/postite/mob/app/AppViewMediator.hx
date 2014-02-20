package com.postite.mob.app;
import com.postite.mob.model.StateModel;
import com.postite.mob.view.Notif;
import com.postite.mob.signal.NoteSignal.Note;
import com.postite.mob.Api;
class AppViewMediator extends mmvc.impl.Mediator<AppView>{

	@inject public var note:com.postite.mob.signal.NoteSignal; 
	@inject public var init:com.postite.mob.signal.InitSignal; 
	@inject public var stateModel:IStateModel;
	public function new()
	{
		super();
	}
	/*
	Context has now been initialized. Time to create the rest of the main views in the application
	@see mmvc.impl.Mediator.onRegister()
	*/
	override function onRegister()
	{
		super.onRegister();
		view.createViews();

		mediate(note.add(onNote));
		mediate(note.complete.add(onNoteComplete) );
		mediate(stateModel.changed.add(onState));

		init.dispatch();
	}

	/**
	@see mmvc.impl.Mediator
	*/
	function onNote(n:Note)
	{
		note.ref=new Notif(view.parent,n.message,n.autoKill,n.type);
	}
	function onNoteComplete()
	{
		note.ref.kill();
	}
	override public function onRemove():Void
	{
		super.onRemove();
	}
	function onState(s:IState)
	{
		view.switchState(s,StateModel.lastState);
	}
}