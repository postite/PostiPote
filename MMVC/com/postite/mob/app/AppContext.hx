package com.postite.mob.app;

import mmvc.api.IViewContainer;

import com.postite.mob.view.*;
import com.postite.mob.model.*;
import com.postite.mob.signal.*;
import com.postite.mob.command.*;
import com.postite.mob.Api;
class AppContext extends mmvc.impl.Context
{
	public function new(contextView:IViewContainer=null)
	{
		super(contextView);
	}
	/**
	Overrides startup to configure all context commands, models and mediators
	@see mmvc.impl.Context
	*/
	override public function startup()
	{
		// wiring for todo model

		commandMap.mapSignalClass(ServerRequestSignal,ServerRequestCommand);
		commandMap.mapSignalClass(ImageRequestSignal,ImageRequestCommand);
		commandMap.mapSignalClass(NoteSignal,NoteCommand);
		commandMap.mapSignalClass(SwitchStateSignal,SwitchStateCommand);
		commandMap.mapSignalClass(InsertSignal,InsertCommand);
		commandMap.mapSignalClass(InitSignal,InitCommand);
//
		//injector.mapSingletonOf(IModel,Model);
		injector.mapSingleton(StateModel);
		injector.mapSingleton(Model);
		injector.mapValue(IModel, injector.getInstance(Model));
		injector.mapValue(IStateModel, injector.getInstance(StateModel));
//
		//// wiring for main application module

		
		mediatorMap.mapView(State0,State0Mediator);
		mediatorMap.mapView(State1,State1Mediator);
		mediatorMap.mapView(EndState,EndStateMediator);
		mediatorMap.mapView(AppView, AppViewMediator); 

	}

	/**
	Overrides shutdown to remove/cleanup mappings
	@see mmvc.impl.Context
	*/
	override public function shutdown()
	{

	}
}