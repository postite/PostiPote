package server;
import erazor.macro.Template;
import cross.CrossConfig.*;
class Front
{
	public function new()
	{
		
	}
	public function doDefault()
	{

		var postites=Postite.manager.search(true,{orderBy:-date});
		var view= new FrontView();
		view.upPath=uploadPath;
		view.postites=postites;
		Sys.print (view.execute());
	}
}

@:template('<!doctype html><html lang="fr"><head><meta charset="UTF-8"/><title>Postite adventures</title>
	<link rel="stylesheet" href="/css/front.css" />
	</head><body>
	<div class="global">
		<h1>Postite Adventures</h1>
		@for(p in postites){
			<div class="postite">
					<img src="/@upPath/@p.src"/>
					<caption>@p.titre</caption>
			</div>
		}
	</div>
	</body>
	<script src="/js/postite.js"></script>
	</html>')
class FrontView extends erazor.macro.Template{
	public var upPath:String;
	public var postites:List<Postite>;
}