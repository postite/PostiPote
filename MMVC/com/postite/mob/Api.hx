package com.postite.mob;

import msignal.Signal;
import com.postite.mob.model.Postite;

//typedef TIModel=IModel
class Api{}

///interfaces
interface IModel{
	public var changed:Signal0;
	public var postite(get,set):Postite;
	public function assign(field:String,val:Dynamic):Void;
	
}
interface IStateModel{
	public var changed:Signal1<IState>;
	public var activeState(default,set):IState;
	public function getStatefordir(state:IState,dir:Int):Void;
}
interface IState {
	public var x:Float;
	public var width:Float;
}

//used to tronsport in Signals... should be core
class Bus<T>{
	public var stock:T;
	public function new(t:T)
	{
		stock=t;
	}
}

