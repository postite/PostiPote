package com.postite.mob.command;
import msignal.Signal;
import com.postite.mob.services.ImageProvider;
class ImageRequestCommand extends mmvc.impl.Command {

	
	override public function execute()
	{
		
	 trace( "execute");
	 var prov=new ImageProvider();
	 prov.onPath.addOnce(onPath);
	 prov.browse();

		
		// mod.message=payload.toUpperCase();
		// trace("execute"+payload);
		// untyped this.signal.complete.dispatch('le retour de $payload  ! et le model = ${mod.message}');


	}
	function onPath(path:String)
	{
		untyped (this.signal).complete.dispatch(path);
	}
}