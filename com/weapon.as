/**
* Game Engine - Shooting Missiles, Rockets & Torpedoes
*
* Version: 1.0
* Author: Philip Radvan
* URL: http://www.freeactionscript.com
*/

/**
*
* Fire Weapon
*
*/
//Settings
var reloadSpeed:Number = 75; //ms 1000 = 1 second
var missileSpeed:Number = 4;
var turnRate:Number = .7;
var reloadTimer:Number;
var reloadComplete:Boolean = true;

function fireWeapon(target):Void
{
	//check if weapon is reloaded, if true, fire bullet
	if(reloadComplete == true)
	{
		//attach missile
		var tempMissile = _root.attachMovie("missile", "missile"+_root.getNextHighestDepth(), _root.getNextHighestDepth());
		
		//set missile position
		tempMissile._x = player_mc._x;
		tempMissile._y = player_mc._y;
		tempMissile._rotation = player_mc._rotation;
		
		//set missle target positions
		tempMissile.targetX = target._x;
		tempMissile.targetY = target._y;

		//set missle move speed
		tempMissile.moveX = 0;
		tempMissile.moveY = 0;		
		
		//make missle move with onEnterFrame
		tempMissile.onEnterFrame = function(){
			doFollow(this, target);
		}
		//play attack sound
		missile_attack_snd.start();
		
		//start reloading gun
		startReloading();
	}
}

//start reloading weapon 
function startReloading()
{
	reloadComplete = false;
	//set a timer that will call the gunReloaded function after "reloadSpeed" time passes
	reloadTimer = setInterval(this, "gunReloaded", reloadSpeed);
}
//gun reloaded function - clears timers and sets reloaded to true
function gunReloaded()
{
	clearInterval(reloadTimer);
	reloadComplete = true;
	
}

/**
*
* Follow
*
*/
function doFollow(follower, target):Void
{
	//get distance between follower and target
	follower.distanceX = target._x - follower._x;
	follower.distanceY = target._y - follower._y;
	
	//get total distance as one number
	follower.distanceTotal = Math.sqrt(follower.distanceX * follower.distanceX + follower.distanceY * follower.distanceY);
	
	//calculate how much to move
	follower.moveDistanceX = turnRate * follower.distanceX / follower.distanceTotal;
	follower.moveDistanceY = turnRate * follower.distanceY / follower.distanceTotal;
	
	//increase current speed
	follower.moveX += follower.moveDistanceX;
	follower.moveY += follower.moveDistanceY;
		
	//get total move distance
	follower.totalmove = Math.sqrt(follower.moveX * follower.moveX + follower.moveY * follower.moveY);
	
	//apply easing
	follower.moveX = missileSpeed*follower.moveX/follower.totalmove;
	follower.moveY = missileSpeed*follower.moveY/follower.totalmove;
	
	//move follower
	follower._x += follower.moveX;
	follower._y += follower.moveY;
	
	//rotate follower toward target
	follower._rotation = 180 * Math.atan2(follower.moveY, follower.moveX)/Math.PI;
	
	//add smoke
	doTrail(follower._x, follower._y, "particle_smoke_clear");
	
	//check if we hit the target
	if(follower.hitTest(target))
	{
		//add explosion
		addExplosion(target._x, target._y, explosionParticleAmount, explosionDistance, explosionSize, explosionAlpha)
		//remove target and follower
		removeMovieClip(target);			
		removeMovieClip(follower);
	}

}

//Rotate Player
var rotationDirection:Number;

function rotatePlayer()
{
	//calculate player_mc rotation, based on player position & mouse position 
	rotationDirection = Math.round(180 - ((Math.atan2(_root._xmouse - player_mc._x, _root._ymouse - player_mc._y)) * 180/Math.PI));
	
	//set rotation
	player_mc._rotation = rotationDirection;	
}

/**
* doTrail - This function creates a smoke particle and sets all its parameters (settings)
*
* Params:
*	targetX		The x position of the particle
*	targetY		The y position of the particle
*	type		The type of particle you want to use. Named/attached directly from the library
*	
**/
function doTrail(targetX:Number, targetY:Number, type:String):Void
{
	//set a reference for a new particle and attach a movieclip from the library to that reference
	var _particle:MovieClip = _root.attachMovie(type, type + _root.getNextHighestDepth(), _root.getNextHighestDepth());
	//set the particle's x & y position based on the target x & y. Offset the particle by a few pixels
	_particle._x = targetX
	_particle._y = targetY
	//randomly rotate the particle 360 degrees
	_particle._rotation = random(360);
	//give the particle a random scale, between 50% and 100%
	randomScale = random(75)+25;
	_particle._xscale = randomScale;
	randomScale = random(75)+25;
	_particle._yscale = randomScale;
	//give each particle its own speed
	_particle.speed = random(10)+5;
	//
	updateAfterEvent();
	//make it move
	_particle.onEnterFrame = function ()
	{
		//increase scale and alpha
		this._xscale += this.speed;
		this._yscale += this.speed;
		this._alpha -= this.speed;
		//check if particle is invisible, and remove it
		if(this._alpha <= 0)
		{
			delete this.onEnterFrame;
			removeMovieClip(this);			
		}
	}
}

/**
*
* Create Enemy
*
*/

//Settings
var enemyArray:Array = [];
var enemySpeed:Number = 3;

//we will be creating new enemies in map_mc
//so we set the walk boundry by using map_mc's dementions
var topBorder:Number = 0
var leftBorder:Number = 0
var botBorder:Number = map_mc._height;
var rightBorder:Number = map_mc._width;


function createEnemy():MovieClip 
{
	//attach a new enemy movieclip from the library
	var tempEnemy = map_mc.attachMovie("enemy", "enemy"+map_mc.getNextHighestDepth(), map_mc.getNextHighestDepth());
	
	//set new enemy position to the mouse position
	tempEnemy._x = map_mc._xmouse;
	tempEnemy._y = map_mc._ymouse;
	
	//get random action for the X axis 
	var randomAction = random(2);
	switch (randomAction) { 
	case 0 : 
		// move right (xSpeed is positive)
		tempEnemy.xSpeed = Math.random(enemySpeed)*enemySpeed;
		break; 
	case 1 : 
		// move left (xSpeed is negative)
		tempEnemy.xSpeed = -(Math.random(enemySpeed))*enemySpeed;	
		break; 
	default : 
		//
		break; 
	} 
	
	//get random action for the Y axis 
	var randomAction = random(2);
	
	switch (randomAction) { 
	case 0 : 
		// move down (ySpeed is positive)
		tempEnemy.ySpeed = Math.random(enemySpeed)*enemySpeed;
		break; 
	case 1 : 
		// move up (ySpeed is negative)
		tempEnemy.ySpeed = -(Math.random(enemySpeed))*enemySpeed;	
		break; 
	default : 
		//
		break; 
	}
	//give each enemy its own onEnterFrame to make it move
	tempEnemy.onEnterFrame = function()
	{
		//check if enemy is within the preset boundry on the X axis, if not, invert xSpeed to go in opposite direction
		if(tempEnemy._x <= leftBorder){
			tempEnemy.xSpeed = Math.abs(tempEnemy.xSpeed);
		}else if(tempEnemy._x >= rightBorder){
			tempEnemy.xSpeed = -tempEnemy.xSpeed;
		}
		//update enemy X position by adding the calculated distance
		tempEnemy._x += tempEnemy.xSpeed;
			
		
		//check if enemy is within the preset boundry on the Y axis, if not, invert ySpeed to go in opposite direction
		if(tempEnemy._y <= topBorder){
			tempEnemy.ySpeed = Math.abs(tempEnemy.ySpeed);
		}else if(tempEnemy._y >= botBorder){
			tempEnemy.ySpeed = -tempEnemy.ySpeed;
		}
		//update enemy Y position by adding the calculated distance
		tempEnemy._y += tempEnemy.ySpeed;
	}
	
	return tempEnemy;
}

/**
*
* Explosion
*
*/

//Settings
var explosionParticleAmount:Number = 15;
var explosionDistance:Number = 25;
var explosionSize:Number = 100;
var explosionAlpha:Number = 75;

function addExplosion(_targetX:Number, _targetY:Number, _explosionParticleAmount:Number, _explosionDistance:Number, _explosionSize:Number, _explosionAlpha:Number):Void
{
	//run a for loop based on the amount of explosion particles
	for(var i = 0; i < _explosionParticleAmount; i++)
	{
		//create particle
		var _tempClip2 = map_mc.attachMovie("explosion2", "explosion2_" + map_mc.getNextHighestDepth(), map_mc.getNextHighestDepth());
		var _tempClip = map_mc.attachMovie("explosion", "explosion" + map_mc.getNextHighestDepth(), map_mc.getNextHighestDepth());
		
		//set particle position
		_tempClip._x = _targetX+random(_explosionDistance)-(_explosionDistance/2);
		_tempClip._y = _targetY+random(_explosionDistance)-(_explosionDistance/2);		
		_tempClip2._x = _targetX+random(_explosionDistance)-(_explosionDistance/2);
		_tempClip2._y = _targetY+random(_explosionDistance)-(_explosionDistance/2);

		//get random particle scale
		var tempRandomSize = random(_explosionSize)+_explosionSize/2;
		//set particle scale
		_tempClip._xscale = tempRandomSize;
		_tempClip._yscale = tempRandomSize;
		//get random particle scale
		var tempRandomSize = random(_explosionSize)+_explosionSize/2;
		//set particle scale
		_tempClip2._xscale = tempRandomSize;
		_tempClip2._yscale = tempRandomSize;
		
		//set particle rotation
		_tempClip2._rotation = random(359);
		
		//set particle alpha
		_tempClip._alpha = random(explosionAlpha)+explosionAlpha/4;
		_tempClip2._alpha = random(explosionAlpha)+explosionAlpha/4;
	}
}