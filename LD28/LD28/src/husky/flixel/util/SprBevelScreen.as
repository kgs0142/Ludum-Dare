package husky.flixel.util
{
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
     * ...
     * @author Husky
     */
    public class SprBevelScreen extends FlxSprite 
    {
        
        public function SprBevelScreen()
        {
        }
        
        public function Create() : void
        {
            this.blend = BlendMode.OVERLAY;
            
            var uiWidth:uint = FlxG.width*FlxCamera.defaultZoom;
            var uiHeight:uint = FlxG.height*FlxCamera.defaultZoom;
            
            this.width = uiWidth;
            this.height = uiHeight;
            
            this.framePixels = new BitmapData(uiWidth, uiHeight, false);
            
            var uiColor:uint;
            for (var uiX:uint = 0; uiX < uiWidth; uiX++)
            {
                for (var uiY:uint = 0; uiY < uiHeight; uiY++)
                {
                    var uiRemainderX:uint = uiX%3;
                    var uiRemainderY:uint = uiY%3;
                    
                    uiColor = (uiRemainderY < uiRemainderX) ? 
                               0XB0B0B0 : 0X909090;
                    
                    this.framePixels.setPixel(uiX, uiY, uiColor);
                }
            }
        }
        
        //override public function draw():void 
        //{			
            //if(cameras == null)
				//cameras = FlxG.cameras;
                //
			//var camera:FlxCamera;
            //var i:uint = 0;
			//var l:uint = cameras.length;
			//while(i < l)
			//{
                //camera = cameras[i++];
                                //
                //_matrix.identity();
                //_matrix.translate(-origin.x,-origin.y);
                //_matrix.scale(scale.x,scale.y);
                //if((angle != 0) && (_bakedRotation <= 0))
                    //_matrix.rotate(angle * 0.017453293);
                //_matrix.translate(_point.x+origin.x,_point.y+origin.y);
                //camera.buffer.draw(framePixels, _matrix, null, blend, null, antialiasing);
            //}
        //}
    }
}