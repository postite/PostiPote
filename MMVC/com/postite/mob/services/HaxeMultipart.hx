package com.postite.mob.services; 
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import haxe.Http;
	import haxe.io.Bytes;
	import haxe.io.BytesData;
	import postite.benchmark.Timely;

	typedef HMField={
		name:String,
		value:String

	}

	typedef HMFile={
		name:String, 
		byteArray:BytesData,
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
	 class HaxeMultipart 
	{
		private var _url:String;
		private var _fields:Array<HMField>;
		private var _files:Array<HMFile>;
		private var _data:BytesData;
		public var request(get,null):Http;
		public static var time:Timely;
		public function  new(url:String = null) {
			_url = url;
			_fields= [];
			_files= [];
			_data=new BytesData();
			time= new Timely(true);
		}
		
		public function addField(name:String, value:String):Void {
			_fields.push(cast {name:name, value:value});
		}
		
		public function addFile(name:String, byteArray:BytesData, mimeType:String, fileName:String):Void {
			_files.push(cast {name:name, byteArray:byteArray, mimeType:mimeType, fileName:fileName});
		}
		
		public function clear():Void {
			_data = new BytesData();
			_fields = [];
			_files = [];
		}
		
		public function get_request():Http 
		{
			trace("request");
			//time.begin();	
			

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
			
			
			
			// var r: URLRequest = new URLRequest(_url);

			// r.data = _data;

			// r.method = URLRequestMethod.POST;
	
			// r.contentType = "multipart/form-data; boundary=" + boundary;
			// //trace( time.end());
			// clear();	
			// trace("request build");
			//  return r;
			
			var t = new haxe.Http(_url);
			var dat=haxe.Serializer.run(Bytes.ofData(_data));
			t.setHeader("Content-Type","multipart/form-data; boundary=" + boundary);
			trace(dat);
			t.onError = function(e)trace("error"+e);
			t.onData = function(e)trace("cool"+e);
			t.setPostData(dat);
			return t;

			
			
		}
		
		private function _writeString(value:String):Void {
			
			var b:BytesData = new BytesData();
			#if flash
			b.writeMultiByte(value, "ascii");
			#else
			b.writeUTFBytes(value);
			#end
			_data.writeBytes(b, 0, b.length);

		}
		
		private function _writeBytes(value:BytesData):Void {
			//_writeString("....FILE....");
			
			
			value.position = 0;
			_data.writeBytes(value, 0, value.length);

		}


		
	}
