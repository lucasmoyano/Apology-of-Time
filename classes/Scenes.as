package classes 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Lucas Moyano
	 */
	public class Scenes extends MovieClip
	{
		public var s1:Sprite;
		public var s2:Sprite;
		public var s3:Sprite;
		public var s4:Sprite;
		public var s5:Sprite;
		public var s6:Sprite;
		
		public var scene:int;
		public var last:MovieClip;
		private var elements:Array;
		
		
		// Scene 1
		public var mainClock:MovieClip;
		public var pendulum:MovieClip;
		public var keyPaint:MovieClip;
		
		// Scene 2
		public var door:MovieClip;
		public var tree:MovieClip;
		public var rareClock:MovieClip;
		public var brands:MovieClip;
		public var metalDoor:MovieClip;
		
		
		// Scene 3
		private var game:Game;
		private var timer:Timer;
		private var timerBinary:Timer;
		
		public var tileA:MovieClip;
		public var tileB:MovieClip;
		public var circleDoor:MovieClip;
		public var binaryClock:MovieClip;
		public var tentacle:MovieClip;
		public var doorS3:MovieClip;
		
		// Scene 4
		public var pyramid:MovieClip;
		public var doorS4:MovieClip;
		public var skull:MovieClip;
		public var sarcophagus:MovieClip;
		public var sunClock:MovieClip;
		public var secretDoor:MovieClip;
		public var keySecretDoor:MovieClip;
		
		// Scene 5
		public var handBlue:MovieClip;
		public var handRed:MovieClip;
		public var cave:MovieClip;
		
		// Scene 6
		public var jail:MovieClip;
		
		public function Scenes() 
		{
			elements = [s1, s2, s3, s4, s5, s6];
			
			mainClock 		= s1["mainClock"];
			pendulum 			= s1["pendulum"];
			keyPaint 			= s1["keyPaint"];
			
			door 					= s3["door"];
			metalDoor 		= s3["metal_door"];
			
			tileA 				= s2["tileA"];
			tileB 				= s2["tileB"];
			circleDoor 		= s2["circleDoor"];
			binaryClock 		= s2["binaryClock"];
			tentacle 			= s2["tentacle"];
			doorS3 				= s2["doorS3"];
			
			pyramid 			= s4["pyramid"];
			doorS4 				= s4["doorS4"];
			skull 				= s4["skull"];
			sarcophagus 	= s4["sarcophagus"];
			sunClock 			= s4["sunClock"];
			secretDoor 		= s4["secretDoor"];
			keySecretDoor	= s4["keySecretDoor"];
			
			handBlue			= s5["handBlue"];
			handRed			= s5["handRed"];
			cave					= s5["cave"];
			
			jail					= s6["jail"];
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			test();
		}
		
		private function test():void 
		{
			addEventListener(MouseEvent.CLICK, function(e:Event) { trace("x:" + stage.mouseX + " ; y:" + stage.mouseY); },false, 0, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			mainClock.stop();
			init();
			makeSscene3();
			createBinaryClock();
		}
		
		private function createBinaryClock():void 
		{
			timerBinary = new Timer(1000);
			timerBinary.start();
			timerBinary.addEventListener(TimerEvent.TIMER, onTickTimer,false, 0, true);
			binaryClock.d1.stop();
			binaryClock.d2.stop();
			binaryClock.d3.stop();
			binaryClock.d4.stop();
			binaryClock.d5.stop();
			binaryClock.d6.stop();
			binaryClock.d1.child = binaryClock.d2;
			binaryClock.d2.child = binaryClock.d3;
			binaryClock.d3.child = binaryClock.d4;
			binaryClock.d4.child = binaryClock.d5;
			binaryClock.d5.child = binaryClock.d6;
			binaryClock.d1.capacity = 10;
			binaryClock.d2.capacity = 5;
			binaryClock.d3.capacity = 10;
			binaryClock.d4.capacity = 5;
			binaryClock.d5.capacity = 10;
			binaryClock.d6.capacity = 2;
			binaryClock.d6.nextFrame();
			binaryClock.d5.gotoAndStop(3);
		}
		
		private function calculeBinaryClock(element:MovieClip):void
		{
			if (element.currentFrame == element.capacity)
			{
				element.gotoAndStop(1);
				if (element.child)
					calculeBinaryClock(element.child);
				return;
			}
			element.nextFrame();
		}
		
		private function onTickTimer(e:TimerEvent):void 
		{
			if (!binaryClock)
				return;
			calculeBinaryClock(binaryClock.d1);
		}
		
		private function makeSscene3():void 
		{
			game = parent.parent as Game;
			timer =  new Timer(300);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onCompleteTimer,false, 0, true);
		}
		
		private function onCompleteTimer(e:TimerEvent):void 
		{
			var i:uint, length:uint;
			var character:Character;
			var flag:Boolean;
			
			var parentTileAFlag:Boolean;
			var parentTileBFlag:Boolean;
			
			parentTileAFlag = tileA.currentFrame == 2;
			parentTileBFlag = tileB.currentFrame == 2;
			
			if (Keys.id(Keys.S3_TILE_A))
			{
				tileA.gotoAndStop(1);
				Keys.setId(Keys.S3_TILE_A, false);
			}
			if (Keys.id(Keys.S3_TILE_B))
			{
				tileB.gotoAndStop(1);
				Keys.setId(Keys.S3_TILE_B, false);
			}
			
			if (!game.characters) return;
			
			length = game.characters.length;
			for (i = 0; i < length; i++)
			{
				character = game.characters[i] as Character;
				if (character.scene == 1) {
					if (hitTestTile(tileA, character))//if (tileA.hitTestObject(character))
					{
						if (!parentTileAFlag && s2.visible)
							Sounds.play(Sounds.tileSound);
						tileA.gotoAndStop(2);
						Keys.setId(Keys.S3_TILE_A, true);
						continue;
					}
					else if (hitTestTile(tileB, character))//else if (tileB.hitTestObject(character))
					{
						if (!parentTileBFlag && s2.visible)
							Sounds.play(Sounds.tileSound);
						tileB.gotoAndStop(2);
						Keys.setId(Keys.S3_TILE_B, true);
					}
				}
			}
			
			if (Keys.id(Keys.S3_TILE_A) && Keys.id(Keys.S3_TILE_B))
			{
				if (circleDoor.currentFrame == 1)
				{
					circleDoor.gotoAndPlay(1);
					Keys.setId(Keys.S3_CIRCLE_DOOR, true);
					if (s2.visible)
						Sounds.play(Sounds.circleDoor);
				}
			}
			else
			{
				if (circleDoor.currentFrame != 1 && circleDoor.currentFrame < 36)
				{
					circleDoor.gotoAndPlay("close");
					Keys.setId(Keys.S3_CIRCLE_DOOR, false);
					if (s2.visible)
						Sounds.play(Sounds.circleDoor);
				}
				
			}
			
		}
		
		private function hitTestTile(tile:MovieClip, character:Character):Boolean
		{
			var flag:Boolean;
			
			flag = false;
			if (tile.x - 30 < character.x && tile.x + 30 > character.x)
			{
				if (tile.y - 30 < character.y && tile.y + 30 > character.y)
				{
					flag = true;
				}
			}
			return flag;
		}
		
		public function show(value:int):void
		{
			var i:uint, length:uint;
			length = elements.length;
			for (i = 0; i < length; i++)
			{
				elements[i].visible = false;
				elements[i].soundTransform = new SoundTransform(0);

			}
			
			scene = value;
			last = elements[value];
			last.visible = true;
			last.soundTransform = new SoundTransform(1);
		}
		
		public function init():void
		{
			
			// SCENE 1
			setLabel(s1["cuadro"], "Cuadro",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:410, y:206},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"<br/><br/><br/>Por Dios... que cuadro más feo." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(keyPaint, "Manecillas",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:440, y:206},
					{ name:"rotate", value:1 },
					
					{ name:"if not", value:Keys.S1_KEY },
						{ name:"talk", value:"<br/><br/><br/>Creo que me llevaré esto." },
						{ name:"setKey", id:Keys.S1_KEY, value:true },
						{ name:"takeKey", keyPaint:keyPaint },
						{ name:"open" },
						{ name:"setOccupation", value:false },
					{ name:"end" },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(pendulum, "Péndulo",
				[	
					{ name:"setOccupation", value:true },
					{ name:"walk", x:170, y:210, rX:20, rY:10 },
					{ name:"rotate", value:1 },	
					
					
						
					{ checkBefore:"if not", value:Keys.S1_PENDULUM },
					
					/*	{ name:"if", value:Keys.S1_PENDULUM },
							{ name:"wait", value:1.1 },
						{ name:"end" },*/
						
						{ name:"if not", value:Keys.S1_PENDULUM },
							{ name:"setKey", id:Keys.S1_PENDULUM, value:true },
							{ name:"open" },
							{ name:"changeObject", obj:pendulum, action:"gotoAndStop", value:"open" },
							{ name:"talk", value:"<br/><br/>Típico..." },
							{ name:"setOccupation", value:false },
						{ name:"end" },
						{ name:"setOccupation", value:false },
					{ checkBefore:"end" },
					
					{ checkBefore:"if", value:Keys.S1_PENDULUM },
						{ name:"walk", x:181, y:200, rX:5, rY:5 },
						{ name:"changeScene", value:1 },
						{ name:"moveTo", x:41, y:256, rX:25, rY:25 },
						{ name:"directionTo", value:3 },
						{ name:"setOccupation", value:false },
					{ checkBefore:"end" }
					
					
				]
			);
			
			setLabel(s1["agujero"], "Agujero",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:650, y:305},
					{ name:"rotate", value:3 },
					{ name:"talk", value:"No pienso meter <br />mis manos ahí..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			// SCENE 3
			
			
			setLabel(s3["door"], "Puerta",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:666, y:345, rX:25, rY:25},
					
					{ checkBefore:"if not", value:Keys.S3_CIRCLE_DOOR },
						{ name:"if not", value:Keys.S3_CIRCLE_DOOR },			
							{ name:"talk", value:"La puerta al final del pasadizo se ha cerrado." },
							{ name:"setOccupation", value:false },
						{ name:"end" },
					{ checkBefore:"end" },
					
					{ checkBefore:"if", value:Keys.S3_CIRCLE_DOOR },	
						{ name:"changeScene", value:1 },
						{ name:"moveTo", x:548, y:260, rX:25, rY:25 },
						{ name:"directionTo", value:3 },	
						{ name:"setOccupation", value:false },	
					{ checkBefore:"end" },
					
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(s3["tree"], "Árbol",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:372, y:265},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"¿Qué hace un árbol en medio de la sala?" },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(s3["rareClock"], "Reloj Derretido",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:512, y:288},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"Es como esa pintura..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(s3["brands"], "Marcas",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:550, y:289},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"Parece que alguien estuvo <br/>mucho tiempo aquí..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(metalDoor, "Portón",
				[
					{ name:"setOccupation", value:true },
					
						//{ name:"walk", x:165, y:271 },
					
						
						{ name:"walk", x:118, y:278},
						{ name:"rotate", value:1 },
						
						{ checkBefore:"if", value:Keys.S2_METAL_DOOR },
							{ name:"changeScene", value:3 },
							{ name:"directionTo", value:3 },
							{ name:"moveTo", x:408, y:246, rX:25, rY:25 },
							{ name:"setOccupation", value:false },
						{ checkBefore:"end" },
						
						
						//	{ name:"setKey", id:Keys.S2_TRY_METAL_DOOR, value:true },
						
						{ name:"if not", value:Keys.S2_METAL_DOOR },
							
							{ name:"if", value:Keys.S2_TRY_METAL_DOOR },
								{ name:"walk", x:77, y:305 },
								{ name:"rotate", value:1 },
								{ name:"tryOpenMetalDoor", door:metalDoor },
								{ name:"setKey", id:Keys.S2_METAL_DOOR, value:true },
							{ name:"end" },
						
							{ name:"if not", value:Keys.S2_TRY_METAL_DOOR },
								{ name:"setKey", id:Keys.S2_TRY_METAL_DOOR, value:true },
								{ name:"walk", x:165, y:271 },
								{ name:"rotate", value:1 },
								{ name:"tryOpenMetalDoor" },
							{ name:"end" },
							
						{ name:"end" },
					
					{ name:"setOccupation", value:false }
				
				/*
					{ name:"setOccupation", value:true },
					
					
					{ checkBefore:"if not", value:Keys.S2_METAL_DOOR },
					
						{ name:"walk", x:63, y:295, rX:70},
						{ name:"rotate", value:1 },
						
						{ name:"if", value:Keys.S2_TRY_METAL_DOOR },
							{ name:"setKey", id:Keys.S2_METAL_DOOR, value:true },
							{ name:"tryOpenMetalDoor" },
							{ name:"openMetalDoor", door:metalDoor },
						{ name:"end" },
						
						{ name:"if not", value:Keys.S2_METAL_DOOR },
							{ name:"setKey", id:Keys.S2_TRY_METAL_DOOR, value:true },
							{ name:"tryOpenMetalDoor" },
							{ name:"setKey", id:Keys.S2_TRY_METAL_DOOR, value:false },
							
							{ name:"backMetalDoor" },
							{ name:"talk", value:"No puedo moverla." },
						{ name:"end" },
					
					{ checkBefore:"end" },
					
					{ checkBefore:"if", value:Keys.S2_METAL_DOOR },
						{ name:"walk", x:117, y:266, rX:30, rY:30},
						{ name:"changeScene", value:3 },
						{ name:"directionTo", value:3 },
						{ name:"moveTo", x:408, y:246, rX:25, rY:25 },
					{ checkBefore:"end" },
					
					{ name:"setOccupation", value:false }
					*/
				]
			);
			
			
			// SCENE 2
			
			setLabel(binaryClock, "Reloj Binario",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:130, y:254},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"mmmmm..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(tentacle, "Tentáculo",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:257, y:190},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"<br/><br/>Es un tentáculo congelado lleno de maldad." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(doorS3, "Puerta",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:20, y:254, rX:20, rY:20},
					{ name:"rotate", value:1 },
					{ name:"changeScene", value:0 },
					{ name:"directionTo", value:3 },
					{ name:"moveTo", x:171, y:207 },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(circleDoor, "Puerta Futurista",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:543, y:280},
					{ name:"rotate", value:1 },
					
					{ checkBefore:"if", value:Keys.S3_CIRCLE_DOOR },
					//{ name:"if", value:Keys.S3_CIRCLE_DOOR },
						{ name:"walk", x:543, y:270, rX:25, rY:25},
						{ name:"changeScene", value:2 },
						{ name:"directionTo", value:4 },
						{ name:"moveTo", x:666, y:340, rX:25, rY:25 },
				//	{ name:"end" },
					{ checkBefore:"end" },
					
					{ checkBefore:"if not", value:Keys.S3_CIRCLE_DOOR },
					//{ name:"if not", value:Keys.S3_CIRCLE_DOOR },
						{ name:"talk", value:"No se como abrir esto." },
				//	{ name:"end" },
					{ checkBefore:"end" },
					
					{ name:"setOccupation", value:false }
				]
			);
			
			
			// SCENE 4
			
			setLabel(pyramid, "Pirámide",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:181, y:383},
					{ name:"rotate", value:3 },
					{ name:"talk", value:"mmmmm..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(doorS4, "Pasadizo",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:414, y:248, rX:25, rY:25},
					{ name:"rotate", value:1 },
								
					{ name:"walk", x:414, y:230, rX:25, rY:25},
					{ name:"changeScene", value:2 },
					{ name:"moveTo", x:125, y:268, rX:25, rY:25 },
					{ name:"directionTo", value:3 },
					{ name:"setOccupation", value:false }
					
				]
			);
			
			setLabel(sunClock, "Reloj",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:388, y:334},
					{ name:"rotate", value:3 },
					
					{ name:"if not", value:Keys.S4_SECRET_DOOR},	
						{ name:"openSecretDoor", secretDoor:secretDoor, keySecretDoor:keySecretDoor },
					{ name:"end" },
					
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(sarcophagus, "Sarcófago",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:590, y:266},
					{ name:"rotate", value:1 },
					{ name:"talk", value:"No se abre..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(skull, "Calavera",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:660, y:338},
					{ name:"rotate", value:2 },
					{ name:"talk", value:"No voy a tocar eso..." },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(secretDoor, "",
				[
					{ checkBefore:"if", value:Keys.S4_SECRET_DOOR},	
						{ name:"setOccupation", value:true },
						{ name:"walk", x:258, y:245},
						{ name:"rotate", value:1 },
						{ name:"walk", x:258, y:230, rX:25, rY:25 },
						{ name:"changeScene", value:4 },
						{ name:"moveTo", x:371, y:294, rX:25, rY:25 },
						{ name:"directionTo", value:3 },
						{ name:"setOccupation", value:false },
					{ checkBefore:"end" },
					
				]
			);
			
			
			// SCENE 5
			
			setLabel(cave, "Salida",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:377, y:304},
					{ name:"rotate", value:1 },
					{ name:"walk", x:377, y:290, rX:25, rY:25},
					{ name:"changeScene", value:3 },
					{ name:"moveTo", x:250, y:245, rX:25, rY:25 },
					{ name:"directionTo", value:3 },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(handBlue, "Mano Azul",
				[
					{ name:"setOccupation", value:true },
					
					
					{ name:"if not", value:Keys.S5_HAND_BLUE },
						{ name:"walk", x:129, y:356},
						{ name:"rotate", value:4 },
						
						{ name:"if not", value:Keys.S5_TEMP_HAND_BLUE },
							{ name:"setKey", id:Keys.S5_TEMP_HAND_BLUE, value:true },						
							{ name:"push", isBlue:true },
						{ name:"end" },
						
					{ name:"end" },
					{ name:"setOccupation", value:false }
				]
			);
			
			setLabel(handRed, "Mano Roja",
				[
					{ name:"setOccupation", value:true },
					
					
					//{ name:"if not", value:Keys.S5_HAND_RED },
					{ name:"walk", x:610, y:378},
						{ name:"rotate", value:2 },
						
					//	{ name:"if not", value:Keys.S5_HAND_RED },
						//	{ name:"setKey", id:Keys.S5_HAND_RED, value:true },						
							{ name:"push", isBlue:false },
						//	{ name:"setKey", id:Keys.S5_HAND_RED, value:false },
						//{ name:"end" },
						
					//	{ name:"if", value:Keys.S5_HAND_RED },
						//	{ name:"setOccupation", value:false },
					//	{ name:"end" },
					//{ name:"end" }
				]
			);
			
			
			// SCENE 6
			
			setLabel(jail, "Reloj de Arena",
				[
					{ name:"setOccupation", value:true },
					{ name:"walk", x:267, y:350, rX:90 },
					{ name:"rotate", value:1 },
					{ name:"kick" },
					{ name:"setOccupation", value:false }
				]
			);
		}
		
		public function setLabel(object:MovieClip, label:String, actions:Array = null):void
		{
			object.label = label;
			object.mouseChildren = false;
			if (actions)
			{
				object.actions = actions;
			}
		}
		
		public function reset():void 
		{
			pendulum.gotoAndPlay(1);
			metalDoor.gotoAndStop(1);
			tileA.gotoAndStop(1);
			tileB.gotoAndStop(1);
			circleDoor.gotoAndStop(1);
			secretDoor.gotoAndStop(1);
			keySecretDoor.gotoAndStop(1);
			keyPaint.gotoAndStop(1);
			secretDoor.label = "";
		}
		
		public function kill():void 
		{
			timer.removeEventListener(TimerEvent.TIMER, onTickTimer);
			timer.reset();
			timer.stop();
			
			timerBinary.removeEventListener(TimerEvent.TIMER, onTickTimer);
			timerBinary.reset();
			timerBinary.stop();
			
			timerBinary = null;
			s1 = null;
			s2 = null;
			s3 = null;
			s4 = null;
			s5 = null;
			s6 = null;
			last = null;
			elements = null;
			mainClock = null;
			pendulum = null;
			keyPaint = null;
			door = null;
			tree = null;
			rareClock = null;
			brands = null;
			metalDoor = null;
			game = null;
			timer = null;
			tileA = null;
			tileB = null;
			circleDoor = null;
			binaryClock = null;
			tentacle = null;
			doorS3 = null;
			pyramid = null;
			doorS4 = null;
			skull = null;
			sarcophagus = null;
			sunClock = null;
			secretDoor = null;
			keySecretDoor = null;
			handBlue = null;
			handRed = null;
			cave = null;
			jail = null;
		}
		
	}

}