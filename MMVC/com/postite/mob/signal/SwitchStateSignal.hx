package com.postite.mob.signal;

import msignal.Signal;
import com.postite.mob.Api;
class SwitchStateSignal extends Signal2<Null<IState>,Int>{


	public var changed:Signal1<String>;
	
	public function new(){
		changed= new Signal1();
		super(IState,Int);
	}

}