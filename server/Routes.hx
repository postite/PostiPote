package server;
import haxe.web.Dispatch;
// import server.controllers.*;
// import server.baz.Controller;

// import haxe.macro.Expr.ComplexType;
// import haxe.macro.Context;
// import haxe.macro.Expr.Field;



class Routes
{
	public function new()
	{
		
	}
	// function doDefault()
	// {
		
	// }
	//TODO generate that with macro !
	function doFront( d:Dispatch ) {
		d.dispatch( new Front() );
	}

	function doUp(d:Dispatch)
	{
		d.dispatch( new Up() );
	}
	

	// function doTest(d:Dispatch){
	// 	d.dispatch( new Test());
	// }

	// function doApi(d:Dispatch)
	// {
	// 	d.dispatch( new Api());
	// }

	// function doDb(d:Dispatch)
	// {
	// 	sys.db.Admin.handler();
	// }
	// function doFront(d:Dispatch)
	// {
	// 	d.dispatch(new Front());
	// }
	// function doAmibe(d:Dispatch)
	// {
	// 	d.dispatch(new Amibe());
	// }

}