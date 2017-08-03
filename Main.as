package 
{
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.system.fscommand;
	import fl.motion.MotionEvent;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import com.freeactionscript.SimplePhysics;
	import com.Cursor;
	import flash.display.Stage;
	public class Main extends MovieClip
	{
		var tester:uint = 0;
		public static var score:uint = 0;
		static var current_level:uint;
		private var _physics:SimplePhysics;
		private var hand:Cursor;
		/*
		el function deh zay el main bta3t el c++ hea 2awel function btetndeh 
		fa 2hna 3mlna 3 3lmyet feha kol w7da el comment bt3ha gnbha 
		*/
		public function Main()
		{
			// constructor code
			stop(); // dah 3l4an ehna fe frame one law  dah pas 3l4an no2af el frames (me4 mohem nw)
			hand = new Cursor(stage); // dah el be 7`aly el mouse 3la 4akl hand 
			mainScene(); // deh el function bta3t 2awl 4a4a btzher 4r7ha  t7t
		}
		function mainScene():void
		{
			score = 0;
			gotoAndStop(1); // el satr dah hena malo4 lazma we momken n4elo 
			// pas howa ma3nah yro7 lel frame rakam (n) gotoAndStop(n) we yo2af 3laeha 
			new_game_bt.addEventListener(MouseEvent.CLICK , newGame); //el satr dah l 2ay button 
			// button_name.addEventListener( no3 el event, el function el hat4ta3`l lma el event ye7ssal
			// deh ml7a4 3elka pel flash deh concept g=hanhtagoh fe 2ay lang zay java , c#
			// el link dah 4ar7oh 7elw :
			// http://goo.gl/KF9lh
			HowToPlay.addEventListener(MouseEvent.CLICK , tutorial);
			exit_bt.addEventListener(MouseEvent.CLICK , exit);
		}
		/*
		deh function bta3t select el level ba3d el link el fo2 keda el modo3 sahl :D
		*/
		function selScene():void
		{
			gotoAndStop(2);
			level_1.addEventListener(MouseEvent.CLICK , selectLevel);
			level_2.addEventListener(MouseEvent.CLICK , selectLevel);
			level_3.addEventListener(MouseEvent.CLICK , selectLevel);
			level_4.addEventListener(MouseEvent.CLICK , selectLevel);
			level_5.addEventListener(MouseEvent.CLICK , selectLevel);
			level_6.addEventListener(MouseEvent.CLICK , selectLevel);
			level_7.addEventListener(MouseEvent.CLICK , selectLevel);
			level_8.addEventListener(MouseEvent.CLICK , selectLevel);
			level_9.addEventListener(MouseEvent.CLICK , selectLevel);
			level_10.addEventListener(MouseEvent.CLICK , selectLevel);
			level_11.addEventListener(MouseEvent.CLICK , selectLevel);
			level_12.addEventListener(MouseEvent.CLICK , selectLevel);
			back_bt.addEventListener(MouseEvent.CLICK , selectLevel);
		}
		 /*
		 del el function bta3t zorar newgame
		 */
		function newGame(evt:MouseEvent):void 
		{
			new_game_bt.removeEventListener(MouseEvent.CLICK , newGame);
			selScene();
		}
		 /*
		 del el function bta3t zorar exit
		 */
		function exit(evt:MouseEvent):void
		{
			fscommand("quit");
		}
		 /*
		 del el function bta3t zorar select level
		 */
		function selectLevel(evt:MouseEvent):void
		{
			if (evt.currentTarget.name == "back_bt")
			{
				mainScene();
			}
			else
			{
				score = 0;
				current_level = int(evt.currentTarget.name.substr(evt.currentTarget.name.lastIndexOf("_") + 1));
				playScene();
			}
		}
		/*
		 del el function bta3t el game nafso
		*/
		function playScene():void
		{
			gotoAndStop(3); // dah 7`las ba2ena 3arfeno
			level_screen.text = String(current_level); // dah el bektb rakm el level el 2ana feh now 
			score_screen.text = String(score); // dah score
			/*
			el 2 satr el ta7t dool bto3 el ene el kora t7`bat fe ba3d
			be7`aly ma benhom kwanen el tasadom deh library gahza ehna mst7`dmnha
			pas sahl tfhmha  hea  7abet kwanen physics : dah el file bta3hoa :
			com/freeactionscript/SimplePhysics.as
			*/
			_physics = new SimplePhysics(container); 
			_physics.enable();
			_physics.createBalls(10,stage,current_level); //dah el mas2ol 3ala generate lel balls 
			back_sel.addEventListener(MouseEvent.CLICK , backSel);
			addEventListener(Event.ENTER_FRAME , updateScore);
		}
		function updateScore(evt:Event):void
		{
			if (currentFrame == 3)
			{
				score_screen.text = String(score);
			}
		}
		function backSel(evt:MouseEvent):void
		{
			if (evt.currentTarget.name == "back_sel")
			{
				back_sel.removeEventListener(MouseEvent.CLICK , backSel);
				selScene();
			}
		}
		function tutorial(evt:MouseEvent):void
		{
			if (evt.currentTarget.name == "back_main")
			{
				mainScene();
			}
			else
			{
				gotoAndStop(4);
				back_main.addEventListener(MouseEvent.CLICK , tutorial);
			}
		}
	}

}
/*
var transitions:Array = [
   [Back.easeIn, Bounce.easeIn, Elastic.easeIn, None.easeNone, Regular.easeIn, Strong.easeIn],
   [Back.easeOut, Bounce.easeOut, Elastic.easeOut, None.easeNone, Regular.easeOut, Strong.easeOut],
   [Back.easeInOut, Bounce.easeInOut, Elastic.easeInOut, None.easeNone, Regular.easeInOut, Strong.easeInOut]
   ];
   */