package com.postite.mob.signal;
import msignal.Signal;

class ServerRequestSignal extends Signal0{

	public var complete:Signal1<String>;
	
	public function new(){
		complete= new Signal1();
		super();
	}

}