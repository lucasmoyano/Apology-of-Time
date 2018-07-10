package  
{
	import classes.Debug;
	import classes.Game;
	import classes.Sounds;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Lucas Moyano
	 */
	public class Main extends MovieClip
	{
		public var list:TextField;
		
		private var end:MovieClip;
		private var game:Game;
		private var menu:MovieClip;
		
		private var layer1:Sprite;
		private var mouse:MovieClip;
		
		private var gcTimer:Timer;
		
		public function Main() 
		{					
			gcTimer = new Timer(5000);
			gcTimer.start();
			gcTimer.addEventListener(TimerEvent.TIMER, onTickTimer);
			layer1 = new Sprite();
			addChild(layer1);
			makeMouse();
			init();
		}
		
		private function onTickTimer(e:TimerEvent):void 
		{
			System.gc();
		}
		
		private function init():void 
		{
			Sounds.init();
			
			menu = new Menu();
			layer1.addChild(menu);
			
			menu.btnWeb.addEventListener(MouseEvent.CLICK, onClickWeb);
			menu.btnPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
			
			list.visible = false;
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); // debug
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var object:*;
			var reference:String;
			
			list.visible = !list.visible;
			
			addChild(list);
			if (list.visible)
			{
				list.text = "";
				for (object in Debug.objects)
				{
					reference = Debug.objects[object];
					list.text += reference + ": " + object + "\n";
				}
			}
		}
		
		private function onClickPlay(e:MouseEvent):void 
		{
			game = new Game();
			game.addEventListener(Event.COMPLETE, onGameOverGame);
			game.addEventListener("final", onEndGame);
			layer1.addChild(game);
			layer1.removeChild(menu);
			
			
			Debug.add(game, "game");
		}
		
		private function onClickWeb(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.lucasmoyano.com/"));
		}
		
		private function makeMouse():void 
		{
			Mouse.hide();
			mouse = new OldMouse();
			mouse.startDrag(true);
			addChild(mouse);
		}
		
		private function onEndGame(e:Event):void 
		{
			game.removeEventListener("final", onEndGame);
			layer1.removeChild(game);
			end = new End();
			layer1.addChild(end);
			game = null;
			stage.addEventListener(Event.COMPLETE, onCompleteEnd);
			System.gc();
		}
		
		private function onCompleteEnd(e:Event):void 
		{
			stage.removeEventListener(Event.COMPLETE, onCompleteEnd);
			layer1.removeChild(end);
			layer1.addChild(menu);
			end = null;
			Debug.removeAllChildrens(end);
			Sounds.stopAllSounds();
			System.gc();
		}
		
		private function onGameOverGame(e:Event):void 
		{
			game.removeEventListener(Event.COMPLETE, onGameOverGame);
			layer1.removeChild(game);
			layer1.addChild(menu);
			game = null;
			System.gc();
		}
		
	}

}