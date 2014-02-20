package com.postite.mob.app;


import tweenx909.TweenX;
import tweenx909.EaseX;
import flash.display.Sprite;
import com.postite.mob.view.*;
import com.postite.mob.Api.IState;


class AppView  extends Sprite implements mmvc.api.IViewContainer
{
	public function new()
	{
		super();
		
	}
	public var viewAdded:Dynamic -> Void;
	public var viewRemoved:Dynamic -> Void;

	/**
	Required by IViewContainer
	*/


	public function isAdded(view:Dynamic):Bool
	{

		return true;
	}

	/**
	Called by ApplicationViewMediator once application is wired up to the context
	@see ApplicationViewMediator.onRegister;
	*/
	public function createViews()
	{
		trace( "createViews");
		// var state0 = new State0();
		// addChild(state0);
		// viewAdded(state0);
		

	}
	
	public function switchState(state:IState,last:IState)
	{
		if( last!=null){
		//removeChild(cast last);
		this.viewRemoved(last);
		}
		addChild(cast state);
		trace( "statex="+state.x);
		//state.x=stage.stageWidth;
		var time = new postite.benchmark.Timely();
		time.begin();
		TweenX.to(this,{x:-state.x}).time(1).ease(EaseX.bounceOut).onFinish(onState,[state]); // warn parameters are a mod of tweenx
		trace( time.end());
	
	}
	function onState(s)
	{	
		trace( "onState"+this.x);
		viewAdded(s[0]);
	}



}