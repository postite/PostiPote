package com.postite.mob.view;

import com.postite.mob.Api;
import com.postite.mob.signal.*;

class State1Mediator extends mmvc.base.MediatorBase<State1>
{

	
	@inject public var browsingSignal:ImageRequestSignal;
	@inject public var serverSignal:ServerRequestSignal;
	@inject public var switchState:SwitchStateSignal;
	@inject public var insertSignal:InsertSignal;
	function new()
	{
		super();
		
	}
	
	override function onRegister()
	{
		
		mediate(view.stateTrigger.addOnce(swap));
		mediate(view.valide.addOnce(insert));
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
	function swap()
	{
		switchState.dispatch(view,1);
	}
	function insert(s:String)
	{
		insertSignal.dispatch("titre",new Bus(s));
		switchState.dispatch(view,1);
	}
	
}