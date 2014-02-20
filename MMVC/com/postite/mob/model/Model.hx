
package com.postite.mob.model;

import msignal.Signal;
using Reflect;
import com.postite.mob.Api.IModel;
class Model extends mmvc.impl.Actor  implements IModel {

	public var changed:Signal0= new Signal0();

	@:isVar public var postite(get,set):Postite;
	private var _postite:Postite;
	
	function get_postite():Postite { return _postite; }
	function set_postite(value:Postite):Postite
	{
		return _postite = value;
	}
	public function new()
	{
		super();
		postite=new Postite();
		postite.date= Date.now();

	}

	public function assign(field:String,val:Dynamic)
	{
		postite.setField(field,val);
		changed.dispatch();
		trace('changed with $field ='+Type.typeof(val));
	}
	


}