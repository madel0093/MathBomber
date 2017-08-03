/**
 * Simple Physics
 * ---------------------
 * VERSION: 1.1
 * DATE: 07/31/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript 
{
	import flash.display.MovieClip;
	import flash.text.*; 
	import flash.sampler.NewObjectSample;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	public class Ball extends MovieClip
	{
		// data
		private var _velocityX:Number = 0;
		private var _velocityY:Number = 0;
		private var _speed:Number;
		private var _mass:Number;
		private var _radius:Number;
		private var _radians:Number;
		private var _rotation:Number;
		private var _id:Number;
		private var _father:SimplePhysics;
		public var  _txt:Number;
		public var  _level:Number;
		public var _sr:Stage;
		/**
		 * Ball Constructor
		 * @param	x
		 * @param	y
		 * @param	rotation
		 * @param	speed
		 * @param	radius
		 * @param	mass
		 */
		public function Ball(x:Number, y:Number, radius:Number, rotation:Number, speed:Number, mass:Number,SR:Stage,id2:Number,father:SimplePhysics,level:Number) 
		{
			// set parameters
			_sr=SR;
			this.x = x;
			this.y = y;
			this.radius = radius;
			this.speed = speed;
			this.mass = mass;
			_father=father;
			// calculate the other vars
			this.radians = rotation * Math.PI / 180;
			this.velocityX = Math.cos(rotation) * this.speed;
			this.velocityY = Math.sin(rotation) * this.speed;
			_level=level
			// draw ball
			if(_father.winning_balls<3){
				_txt=generate(1,level);
				_father.winning_balls++;
			}else{
				_txt=generate(0,level);
			}
			_id=id2;
			txt.text=String(_txt);
			this.addEventListener(MouseEvent.CLICK, on_click);
		}
		
		//////////////////////////////////////
		// Getters & Setters
		//////////////////////////////////////
		private function on_click(e:MouseEvent):void{
			txt.text="2"
			this.gotoAndStop(2);
			removeit(_id);
			if(_txt%_level==0){
			Main.score+=100;
			_father.winning_balls--;
			}
			_father.createBall(_sr,_level);
		}
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		public function get id():Number 
		{
			return _id;
		}
		
		public function set id(value:Number):void 
		{
			_id = value;
		}
		public function get mass():Number 
		{
			return _mass;
		}
		
		public function set mass(value:Number):void 
		{
			_mass = value;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function get radians():Number 
		{
			return _radians;
		}
		
		public function set radians(value:Number):void 
		{
			_radians = value;
		}
		
		public function get velocityX():Number
		{
			return _velocityX;
		}
		
		public function set velocityX(value:Number):void 
		{
			_velocityX = value;
		}
		
		public function get velocityY():Number
		{
			return _velocityY;
		}
		
		public function set velocityY(value:Number):void 
		{
			_velocityY = value;
		}
		
		public function removeit(myindex):void
		{
			_father._ballArray.splice(myindex, 1);
			for (var i:int = 0; i < _father._ballArray.length; i++)
			{
				_father._ballArray[i].id=i;
			}
		}
		public function generate(mode:int,current_level:int):int{
				var temp:int;
				var max:int;
				var coun:int; 
				var repeat:Boolean;
				repeat = true;
				max=114;
				if(mode==1)
				{
					temp = ( Math.floor(Math.random() * (1 + 12 - 1) + 1)) * (current_level) ;
				}else{
					temp=1 + (max - 1) * Math.random();
				}
				return temp;
		}
	}
	
}