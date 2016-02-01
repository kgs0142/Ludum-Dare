package 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.InterpolationMethod;
    import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
    import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Husky
	 */
	public class GradientFG extends Sprite 
	{
        [Embed(source="../bin/1370930471_shaaarks__by_lilamiez-d679w13.jpg")]
        private static const PIC_CLS:Class;
        
		public function GradientFG():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            
            var bmp:Bitmap = new PIC_CLS();
            this.addChild(bmp);
            
            var m:Matrix = new Matrix();
            m.createGradientBox(stage.width, stage.height, Math.PI/2, 0, 50);
            //Math.PI/2, 0,50
            
            var gradient:Sprite = new Sprite();
            gradient.graphics.beginGradientFill(GradientType.LINEAR, [0x3A4056, 0x0A0B0E], [0, 1], [0, 255], m);
            gradient.graphics.drawRect(0, 0, stage.width, stage.height);
            gradient.graphics.endFill();
            
            var fgBmpd:BitmapData = new BitmapData(gradient.width, gradient.height, true, 0xFFFFFF);
            fgBmpd.draw(gradient);
            var fg:Bitmap = new Bitmap(fgBmpd);
            this.addChild(fg);
            //this.addChild(gradient);
		}
		
	}
	
}