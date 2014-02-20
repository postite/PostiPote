package com.postite.mob.command;
import msignal.Signal;
import com.postite.mob.signal.NoteSignal.Note;
class NoteCommand extends mmvc.impl.Command{

	@inject public var note:Note;
	override public function execute()
	{
		trace( "execute"+note);
		// var note= untyped signal.note;
		// trace(note.message);
		// mod.message=payload.toUpperCase();
		// trace("execute"+payload);
		// untyped this.signal.complete.dispatch('le retour de $payload  ! et le model = ${mod.message}');


	}
}