package server.vo;
import haxe.ds.StringMap;
import sys.db.Types;
//import ufront.db.Object;


@:table("postite")
@:id(id) // missing autoincrement
class Postite extends sys.db.Object 
{

	// @:validate( _.length>6, "titre must be at least 6 characters long" )
	public var id:SInt;
	public var titre:Null<SString<255>>;
	public var date:SDate;
	public var src:SString<255>;
	
	//public static var manager:Manager<Eleveur>= new Manager(Eleveur);
} 