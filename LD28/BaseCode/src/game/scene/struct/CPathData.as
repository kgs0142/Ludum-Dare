package game.scene.struct 
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
	/**
     * ...
     * @author Husky
     */
    public class CPathData 
    {
        public var nodes:Vector.<CPathNode>;
		public var isClosed:Boolean;
		public var isSpline:Boolean;
		public var layer:FlxGroup;

		// These values are only set if there is an attachment.
		public var childSprite:FlxSprite = null;
		public var childAttachNode:int = 0;
		public var childAttachT:Number = 0;	// position of child between attachNode and next node.(0-1)

        public function CPathData(vNodes:Vector.<CPathNode>, bClosed:Boolean, 
                                  bSpline:Boolean, gLayer:FlxGroup)
		{
			nodes = vNodes;
			isClosed = bClosed;
			isSpline = bSpline;
			layer = gLayer;
		}
        
        public function Release() : void
        {
            layer = null;
			childSprite = null;
			nodes = null;
        }
    }
}