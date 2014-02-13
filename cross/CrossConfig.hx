package cross;
@:publicFields
class CrossConfig
{

	#if local
	static var params={ user : "root", port :8889, pass : "root", host : "localhost", database :"postite" }
	#else
	static var params={ user : "postite", port :3306, pass : "paglop", host : "mysql1.alwaysdata.com", database :"postite_it" }
	#end
	static var uploadPath="uploads";

}