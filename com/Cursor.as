package com
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import com.Hand_tool;

	public class Cursor extends MovieClip
	{
		// Refrence to stage
		var stageRef:Stage;
		
		// Cursor Icon
		var hand:Hand_tool = new Hand_tool();
		
		/*
		* Constructor
		*/
		public function Cursor(SR:Stage)
		{
			stageRef = SR;
			stageRef.addChild(hand);
			
			Mouse.hide();
			hand.stop();
			hand.mouseEnabled = false;
			hand.mouseChildren = false;
			hand.x = stageRef.mouseX;
			hand.y = stageRef.mouseY;
			stageRef.addEventListener(MouseEvent.MOUSE_MOVE, handMove);
			stageRef.addEventListener(Event.MOUSE_LEAVE , handLeave);
			stageRef.addEventListener(MouseEvent.MOUSE_DOWN , handDown);
			stageRef.addEventListener(MouseEvent.MOUSE_UP , handUp);
		}
		/*
		* Event Handlers
		*/
		private function handMove(e:MouseEvent):void
		{
			hand.visible = true;
			hand.x = stageRef.mouseX;
			hand.y = stageRef.mouseY;

			///e.updateAfterEvent();
		}
		private function handLeave(e:Event):void
		{
			hand.visible = false;
		}
		private function handDown(e:MouseEvent):void{
			hand.gotoAndStop(2);
			
		}
		private function handUp(e:MouseEvent):void{
			hand.gotoAndStop(1);
		}
	}
}