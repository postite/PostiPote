package com.postite.mob.signal;

import msignal.Signal;
import com.postite.mob.Api;

class InsertSignal extends Signal2<String,Bus<Dynamic>>{


	public var complete:Signal1<String>;
	
	public function new(){
		complete= new Signal1();
		super(String,Bus);
	}

}