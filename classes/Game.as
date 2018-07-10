package classes 
{
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundMixer;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Lucas Moyano
	 */
	public class Game extends Sprite
	{		
		public var scenes		:Scenes;
		public var txtTime		:TextField;
		public var description	:MovieClip;
		public var shadows		:MovieClip;
		public var btnNext		:MovieClip;
		public var btnPause	:MovieClip;
		public var btnHelp		:MovieClip;
		
		
		private var flash			:Flash;
		
		private var layer1		:Sprite;
		private var layer2		:Sprite;
		
		
		private var timer			:Timer;
		private var stopwatch	:int;
		
		public var characters	:Array;
		private var lastChar		:Character;
		
		private var isEnd		:Boolean;
		private var isPaused	:Boolean;
		private var isHelp:Boolean;
		
		public function Game() 
		{
			var object:MovieClip;
			Keys.resetFlags();
			Sounds.play(Sounds.music, 0, true);
			
			isPaused = false;
			isHelp = false;
			scenes.show(0);
			
			stopwatch = 770;
			timer = new Timer(100);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTickTimer);
			
			description.visible = false;
			shadows.mouseEnabled = false;
				
			characters = [];
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.CLICK, onClick);
						
			layer1 = new Sprite();
			layer2 = new Sprite();
			addChild(layer1);
			addChild(layer2);
			
			shadows.mouseEnabled = false;
			addChild(shadows);
			
			layer1.addChild(scenes);
			layer2.addChild(description);
			layer2.addChild(txtTime);
			layer2.addChild(btnNext);
			layer2.addChild(btnHelp);
			layer2.addChild(btnPause);
			flash = new Flash();
			flash.mouseEnabled = false;
			layer2.addChild(flash);
			
			addCharacter();
			
			btnNext.visible = false;
			
			btnPause.addEventListener(MouseEvent.CLICK, onClickPause);
			btnHelp.addEventListener(MouseEvent.CLICK, onClickHelp);
			
			Debug.add(timer,"timer");
			Debug.add(btnNext,"btnNext");
			Debug.add(btnHelp,"btnHelp");
			Debug.add(btnPause,"btnPause");
			Debug.add(layer1,"layer1");
			Debug.add(layer2, "layer2");
			Debug.add(characters, "characters");
			Debug.add(scenes, "scenes");
			Debug.add(lastChar, "lastChar");
			Debug.add(flash, "flash");
			Debug.add(shadows, "shadows");
			Debug.add(description, "description");
			Debug.add(txtTime, "txtTime");
		}
		
		private function onClickHelp(e:MouseEvent):void 
		{
			var i:uint, length:uint;
			var character:Character;
			
			if (e.target.name == "btnYes")
			{
				btnHelp.help.play();
				return;
			}
			
			length = characters.length;
			if (isHelp)
			{
				btnHelp.help.addEventListener(Event.COMPLETE, function()
				{
					btnHelp.gotoAndStop(1);
					timer.start();
					
					for (i = 0; i < length; i++)
					{
						character = characters[i] as Character;
						if (character)
						{
							character.start();
							character.visible = character.scene == scenes.scene;
						}
					}
				},false, 0, true);
				btnHelp.help.gotoAndPlay("close");
			}
			else
			{
				btnHelp.gotoAndStop(2);
				timer.stop();
				
				for (i = 0; i < length; i++)
				{
					character = characters[i] as Character;
					if (character)
					{
						character.pause();
						character.visible = false;
					}
				}
			}
			
			isHelp = !isHelp;
		}
		
		private function onClickPause(e:MouseEvent):void 
		{
			var i:uint, length:uint;
			var character:Character;
			
			if (e.target.name == "btnPlayAgain")
			{
				kill();
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			
			
			length = characters.length;
			if (isPaused)
			{
				btnPause.gotoAndStop(1);
				timer.start();
				
				for (i = 0; i < length; i++)
				{
					character = characters[i] as Character;
					if (character)
					{
						character.start();
						character.visible = character.scene == scenes.scene;
					}
				}
			}
			else
			{
				btnPause.gotoAndStop(2);
				timer.stop();
				
				for (i = 0; i < length; i++)
				{
					character = characters[i] as Character;
					if (character)
					{
						character.pause();
						character.visible = false;
					}
				}
			}
			
			isPaused = !isPaused;
		}
		
		private function kill():void 
		{
			var i:int, length:int;
			var character:Character;
			Sounds.stopAllSounds();
			length = characters.length;
			
			var oThis:Game = this;
			TweenLite.to(this, 1.5, { onComplete:function()
			{
				
				timer.removeEventListener(TimerEvent.TIMER, onTickTimer);
				timer.reset();
				timer.stop();
				
				for ( i = 0; i < length; i++ )
				{
					character = characters[i] as Character;
					character.kill();
				}
				
				scenes.kill();
				
				Debug.removeAllChildrens(oThis);
				
				scenes = null;
				txtTime = null;
				description = null;
				shadows = null;
				btnNext = null;
				btnHelp = null;
				btnPause = null;
				flash = null;
				layer1 = null;
				layer2 = null;
				timer = null;
				lastChar = null;
				characters = null;
				
				if (isEnd)
					dispatchEvent(new Event("final"));
				
			}});
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var isWalk:Boolean;
			var posX:int, posY:int;
			var aux:MovieClip;
			
			if (e.target == btnNext)
			{
				onTickComplete();
			}
			else if (e.target == scenes.last["hit"])
			{
				isWalk = true;
				posX = mouseX;
				posY = mouseY;
			}
			else if (e.target is Character)
			{
				isWalk = true;
				posX = e.target.x + 5;
				posY = e.target.y + 5;
			}
			else if (e.target is MovieClip)
			{
				aux = e.target as MovieClip;
				if (aux["actions"])
				{
					lastChar.addActions(aux["actions"]);
				}
			}
			
			if (isWalk)
				lastChar.addAction( { name:"walk" , x:posX, y:posY } );
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			var label:String;
			
			description.visible = false;
			if (e.target is DisplayObjectContainer)
			{
				try {
					if (e.target["label"])
					{
						label = e.target["label"];
						description.visible = true;
						description["txt"].text = label;
					}
				}
				catch(e:Error) { }
			}
		}
		
		private function addCharacter():void 
		{
			var aux:int;
			var character:Character;
			
			aux = characters.length + 1;
			
			trace("POR ACA BAMOS: " +aux);
			
			character = new Character( aux);
			Debug.add(character, "character");
			
			characters.push(character);
			layer1.addChild(character);
			
			if (aux == 1)
				character.setName("Duke de la 1");
			else
				character.setName("Duke de las " + aux);
			
			scenes.mainClock.gotoAndStop(aux);
			
			flash.play();
			lastChar = character;
		}
		
		private function onTickTimer(e:TimerEvent):void 
		{
			var aux:int;
			stopwatch -= 1;
			aux = int(stopwatch / 10);
			txtTime.text = "" +aux;
			aux = (int(stopwatch * 0.1) - stopwatch * 0.1) * (-10);
			txtTime.appendText( "." + aux);
			if (stopwatch == 0)
			{
				onTickComplete();
			}
			if (stopwatch % 5)
				sortCharacters();
				
			if (stopwatch == 600)
				btnNext.visible = true;
		}
		
		private function sortCharacters():void 
		{
			var i:int, j:int, length:int;
			var charA:Character, charB:Character;
			
			length = characters.length;
			for ( i = 0; i < length; i++ )
			{
				charA = characters[i] as Character;
				
				for ( j = 0; j < length; j++ )
				{
					charB = characters[j] as Character;
					if (charA.y > charB.y)
					{
						if (layer1.contains(charA)) 
						{
							if (layer1.contains(charB))
							{
								if (layer1.getChildIndex(charA) < layer1.getChildIndex(charB))
									layer1.swapChildren(charA, charB);
							}
						}
					}
				}
			}
		}
		
		private function onDeadCharacter(e:Event):void 
		{
				var dark:MovieClip;
				lastChar.mc["character"].removeEventListener("dead", onDeadCharacter);
				dark = new Dark();
				addChild(dark);
				dark.addEventListener(Event.COMPLETE, onCompleteDark);
		}
		
		private function onCompleteDark(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, onCompleteDark);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onTickComplete():void 
		{
			var i:int, length:int;
			var character:Character;
			
			if (characters.length >= 12)
			{
				btnNext.visible = false;
				SoundMixer.stopAll();
				lastChar.mc.gotoAndStop(3);
				lastChar.removeDialogue();
				lastChar.mc["character"].gotoAndPlay("dead");
				lastChar.mc["character"].addEventListener("dead", onDeadCharacter);
				return;
			}
			
			stopwatch = 770;
			btnNext.visible = false;
			length = characters.length;
			for ( i = 0; i < length; i++ )
			{
				character = characters[i] as Character;
				character.reset();
				character.setBlackAndWhite();
			}
			addCharacter();
			flash.play();
			
			scenes.reset();
			Keys.resetFlags();
			scenes.show(0);
		}
		
		public function changeScene(value:int, character:Character):void
		{
			var character:Character;
			var i:uint, length:uint;
			
			if (isEnd) return;
			
			if (value == 4)
			{
				if (!Sounds.flagSpecialMusic)
				{
					Sounds.flagSpecialMusic = true;
					Sounds.stopAllSounds();
					Sounds.play(Sounds.musicB, 0, true);
				}
			}
			
			if (character == lastChar)
			{
				scenes.show(value);
				
				length = characters.length;
				for (i = 0; i < length; i++)
				{
					character = characters[i] as Character;
					character.visible = character.scene == scenes.scene;
				}				
			}
			else
			{
				character.visible = character.scene == scenes.scene;
			}
		}
		
		public function endGame():void 
		{
			kill();
			Sounds.play(Sounds.crash);
			isEnd = true;
			
			flash.play();
			removeChild(layer1);
			layer2.removeChild(txtTime);
			layer2.removeChild(btnNext);
			layer2.removeChild(btnHelp);
			layer2.removeChild(btnPause);
		}
		
	}

}