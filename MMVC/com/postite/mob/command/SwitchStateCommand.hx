package com.postite.mob.command;

import com.postite.mob.Api;
//import com.postite.mob.model.StateModel;
class SwitchStateCommand extends mmvc.impl.Command{

	@inject public var stateModel:IStateModel;
	@inject public var state:IState;
	@inject public var dir:Int;
	override public function execute()
	{
		trace( "execute"+state);
		stateModel.getStatefordir(state,dir);
		
		//untyped(this.signal).changed.dispatch("hop");

	}
}