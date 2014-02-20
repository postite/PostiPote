package com.postite.mob.view;

import com.postite.mob.signal.*;
class EndStateMediator extends mmvc.base.MediatorBase<EndState>
{

	
	@inject public var browsingSignal:ImageRequestSignal;
	@inject public var serverSignal:ServerRequestSignal;
	@inject public var switchState:SwitchStateSignal;
	function new()
	{
		super();
		
	}
	
	override function onRegister()
	{
		
		mediate(serverSignal.complete.add(afterServer));
		
		mediate(view.stateTrigger.addOnce(retour));
		mediate(view.valide.addOnce(swap));
		trace( "onregister");

		view.active();
	}
	/*
	Override onRemove to remove any unmediated listeners
	@see mmvc.impl.Mediator
	*/
	override public function onRemove():Void
	{
		super.onRemove();
		//remove un mediated listeners
	}
	function afterServer(s)
	{
		trace("recorded");
	}
	function retour()
	{
		switchState.dispatch(view,-2);
	}
	function swap()
	{
		//
		serverSignal.dispatch();
	}
	
}