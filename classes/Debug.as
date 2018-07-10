package classes 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Lucas Moyano
	 */
	public class Debug 
	{
		public static var objects:Dictionary;
		private static var count:int = 0;
		
		public static function add(object:*, reference:String):void
		{
			if (!objects)
				objects = new Dictionary(true);
				
			objects[object] = reference + "_" + count;
			count++;
		}
		
		public static function removeAllChildrens(mc:DisplayObjectContainer):void
		{
			if (!mc) return;
			
			if (mc.numChildren != 0)
			{
				var k:int = mc.numChildren;
				
				while( k -- )
				{
					removeAllChildrens(mc.getChildAt(k) as DisplayObjectContainer);
					mc.removeChildAt( k );
				}
			}
		}
		
	}

}