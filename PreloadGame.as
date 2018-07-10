package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Lucas Moyano
	 */
	public class PreloadGame extends MovieClip
	{
		public var preload:MovieClip;
		
		public function PreloadGame() 
		{
			var request:URLRequest = new URLRequest("game.swf");
			var loader:Loader = new Loader()
			preload.btnWeb.addEventListener(MouseEvent.CLICK, onClickWeb);
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoading);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);  
			loader.load(request);
			addChild(loader);
		}
		
		private function onClickWeb(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.lucasmoyano.com/"));
		}
		
		private function onLoadComplete(e:Event):void 
		{
			removeChild(preload);
		}
		
		private function onLoading(e:ProgressEvent):void 
		{
			var porc:int;
			porc =(e.bytesLoaded/e.bytesTotal)*100
			preload.loaded.text = String(Math.round(porc)) + "%"
		}
		
	}

}