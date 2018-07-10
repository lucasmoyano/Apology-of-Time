package classes 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Lucas Moyano
	 */
	public class OldCharacter extends Character
	{
		
		public function OldCharacter(id:int = 0) 
		{
			super(id);
			removeChild(mc);
			mc = new MCOldCharacter();
			addChild(mc);
		}
		
	}

}