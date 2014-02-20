package com.postite.mob.command;
import msignal.Signal;
import com.postite.mob.Api;
class InitCommand extends mmvc.impl.Command{

	@inject public var mod:IModel;
	@inject public var stateModel:com.postite.mob.model.StateModel;
	
	override public function execute()
	{
		trace( "execute");
		stateModel.activeState=stateModel.states.head.val;

		//mod.message=payload.toUpperCase();
		//trace("execute"+payload);
		//untyped this.signal.complete.dispatch('le retour de $payload  ! et le model = ${mod.message}' );
	}
}