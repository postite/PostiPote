package server;
import haxe.web.Dispatch;
#if neko import neko.Web;#end
#if php import php.Web;#end
import haxe.ds.StringMap;

import cross.CrossConfig.*;
class Server
{


	// #if local
	// static var params={ user : "root", port :8889, pass : "root", host : "localhost", database :"postite" }
	// #else
	// static var params={ user : "postite", port :3306, pass : "paglop", host : "mysql1.alwaysdata.com", database :"postite_it" }
	// #end
	// public static var uploadPath="uploads";

	function new()
	{
		
		connect();
		var uri = Web.getURI();
		try {
				Dispatch.run( uri, new StringMap(), new Routes() );
			} 
			catch (e:DispatchError) {
				Dispatch.run( uri, new StringMap(), this);
			}


	}
	

	static public function main()
	{
		var app = new Server();
	}

	function  doDefault()
	{
		trace( "yeap");
		Dispatch.run( "/front", new StringMap(), new Routes());
	}
	function doInstall()
	{
		sys.db.TableCreate.create(Postite.manager);
	}

	function connect()
	{
		try{

		var cnx= sys.db.Mysql.connect(params);
		//var cnx = sys.db.Sqlite.open("bazlite.db");
		sys.db.Manager.cnx = cnx;
		sys.db.Manager.initialize();
		
		
		
		#if neko
		//sys.db.Admin.initializeDatabase(true, true);
		#end
		
		}catch(e:Dynamic){
			//trace( "oloé");
			
			//Web.setReturnCode(522);
			throw "pas cool" +e;
			

		}
	}
}