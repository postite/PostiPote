package com.postite.mob.view;

import flash.utils.ByteArray;
import com.postite.mob.Api;
import com.postite.mob.signal.*;
class State0Mediator extends mmvc.base.MediatorBase<State0>
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
		mediate(browsingSignal.complete.add(view.loadImage));
		mediate(view.browsing.add(browsingSignal.dispatch));
		mediate(view.sending.add(sendAction));
		mediate(view.valide.add(onValide));
		mediate(serverSignal.complete.add(afterServer));
		view.reset();
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

	function afterServer(s:String)
	{
		trace("opa"+s);
		
	}
	function onValide(ba:ByteArray)
	{
		insertSignal.dispatch("src",new Bus(ba));

	}
	function sendAction()
	{
		//trace("sendAction+"+view.BA);
		switchState.dispatch(this.view,1);
		//serverSignal.dispatch(view.BA);
	}
}