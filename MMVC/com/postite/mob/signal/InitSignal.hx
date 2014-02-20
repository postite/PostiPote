
package com.postite.mob.signal;

import msignal.Signal;

class InitSignal extends Signal0{


	public var complete:Signal1<String>;
	
	public function new(){
		complete= new Signal1();
		super();
	}

}