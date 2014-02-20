
package com.postite.mob.command;
import msignal.Signal;


import com.postite.mob.Api;
class InsertCommand extends mmvc.impl.Command{

	@inject public var mod:IModel;
	
	@inject public var field:String;
	@inject public var value:Bus<Dynamic>;
	override public function execute()
	{
		trace("execute");

		
		mod.assign(field,value.stock);
		
	}
}