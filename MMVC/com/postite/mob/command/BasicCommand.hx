
package com.postite.mob.command;
import msignal.Signal;

class BasicCommand extends mmvc.impl.Command{

	@inject public var mod:IModel;
	//@inject public var sign:com.postite.signal.BasicSignal;
	//@inject public var payload:String;
	override public function execute()
	{
		
		//mod.message=payload.toUpperCase();
		//trace("execute"+payload);
		//untyped this.signal.complete.dispatch('le retour de $payload  ! et le model = ${mod.message}' );
	}
}