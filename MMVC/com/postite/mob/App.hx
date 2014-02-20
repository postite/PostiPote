package com.postite.mob;


class App {
	
	
	

	
	



	/**
	Instanciates the main ApplicationView and the ApplicationContext.
	This will trigger the ApplicationViewMediator and kick the application off.
	*/
	public static function main()
	{
		var view = new com.postite.mob.app.AppView();
		flash.Lib.current.addChild(view);
		var context = new com.postite.mob.app.AppContext(view);
		
		
	}
}
