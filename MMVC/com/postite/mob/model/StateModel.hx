package com.postite.mob.model;
import com.postite.mob.Api;
import msignal.Signal.Signal1;
import com.postite.mob.view.*;
import de.polygonal.ds.DLL;
class StateModel extends mmvc.impl.Actor implements IStateModel
{
	public var changed:Signal1<IState>=new Signal1();
	public  var states:DLL<IState>;
	@:isVar public var activeState(default,set):IState;
	public static var lastState:IState;
	public function new()
	{
		super();
		states= new DLL();
		states.append(new State0());
		states.append( new State1());
		states.append( new EndState());

		var cur=states.head;
		for (a in 0...states.size()){
			if(cur.hasPrev())
			cur.val.x=cur.prev.val.x+600;
			trace( "----------------"+cur.val.x +cur.val);
			cur=cur.next;
		}
	}

	function set_activeState(s:IState):IState
	{
		trace( "stateChanged"+s);
		lastState=activeState;
		activeState=s;
		changed.dispatch(s);
		return s;
	}

	public function getStatefordir(state:IState,dir:Int)
	{
		activeState=switch (dir) {
			case 1: 
			states.nodeOf(state).next.val;
			case -1: 
			states.nodeOf(state).prev.val;
			case (a) if (a <-1):
			 states.nodeOf(state).prev.prev.val; //todo incrr
			case _:
			throw("olalala");
		}
	}

}