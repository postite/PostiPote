package; 
	
	import flash.events.Event;
	 import flash.net.URLLoader;
	 import flash.net.URLRequest;
	 import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import haxe.Http;
	import haxe.io.Bytes;

	typedef MField={
		name:String,
		value:String

	}

	typedef MFile={
		name:String, 
		byteArray:ByteArray,
		 mimeType:String, 
		 fileName:String
	}
	/**
	 * 
	 * Based on RFC 1867 + real case observation
	 * 
	 * RFC 1867
	 * https://tools.ietf.org/html/rfc1867
	 * 
	 */
	 class Multipart 
	{
		private var _url:String;
		private var _fields:Array<MField>;
		private var _files:Array<MFile>;
		private var _data:ByteArray;
		public var request(get,null):URLRequest;
		
		public function  new(url:String = null) {
			_url = url;
			_fields= [];
			_files= [];
			_data=new ByteArray();
		}
		
		public function addField(name:String, value:String):Void {
			_fields.push(cast {name:name, value:value});
		}
		
		public function addFile(name:String, byteArray:ByteArray, mimeType:String, fileName:String):Void {
			_files.push(cast {name:name, byteArray:byteArray, mimeType:mimeType, fileName:fileName});
		}
		
		public function clear():Void {
			_data = new ByteArray();
			_fields = [];
			_files = [];
		}
		
		public function get_request():URLRequest 
		{
			trace("request");
			var boundary: String = Std.string ((Math.round(Math.random()*100000000)));
			
			var n:Int;
			var i:Int;
			
			// Add fields
			n = _fields.length;
			for(i in 0...n){
				_writeString('--' + boundary + '\r\n'
					+'Content-Disposition: form-data; name="'+_fields[i].name+'"\r\n\r\n'
					+_fields[i].value+'\r\n');
			}
			
			// Add files
			n = _files.length;
			for(i in 0...n){
				_writeString('--'+boundary + '\r\n'
					+'Content-Disposition: form-data; name="'+_files[i].name+'"; filename="'+_files[i].fileName+'"\r\n'
					+'Content-Type: '+_files[i].mimeType+'\r\n\r\n');
				
				_writeBytes(_files[i].byteArray);
				_writeString('\r\n');
			}
			
			// Close
			_writeString('--' + boundary + '--\r\n');
			


			var r: URLRequest = new URLRequest(_url);
			r.data = _data;
			r.method = URLRequestMethod.POST;
			r.contentType = "multipart/form-data; boundary=" + boundary;
			trace( "go request");
			// var r:Http = new Http(_url);
			// r.onData= function(r)trace("cool="+r);
			// r.onError= function(r)trace("err="+r);
			// r.setPostData("opppp" );
			// r.setHeader( "Content-Type", "multipart/form-data; boundary=" + boundary );
			 return r;
			
		}
		
		private function _writeString(value:String):Void {
			var b:ByteArray = new ByteArray();
			#if flash
			b.writeMultiByte(value, "ascii");
			#else
			b.writeUTFBytes(value);
			#end
			_data.writeBytes(b, 0, b.length);
		}
		
		private function _writeBytes(value:ByteArray):Void {
			//_writeString("....FILE....");
			value.position = 0;
			_data.writeBytes(value, 0, value.length);
		}

		
	}
