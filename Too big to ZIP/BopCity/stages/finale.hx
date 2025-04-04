import objects.VideoSprite;
import flixel.sound.FlxSound;
import backend.Conductor;
import flixel.FlxSprite;
import flixel.math.FlxBasePoint;
import flixel.FlxG;

var targetY = 0;
var isMenuItem = false;
var changeX = true;
var changeY = true;
var distancePerItem = new FlxBasePoint(20, 120);
var startPosition = new FlxBasePoint(0, 0); //for the calculations
var sc = 1;
function new(x=0,y=0,e = '') {
    super(x,y,0,e,48);
    font = Paths.font('papyrus.ttf');
    updateHitbox();
    startPosition.set(x,y);
}
function update(elapsed)
{
     var lerpVal = Math.exp(-elapsed * 9.6);
    if (isMenuItem) {

        if (changeX)
        x = FlxMath.lerp((targetY * distancePerItem.x) + startPosition.x, x, lerpVal);
        if (changeY)
        y = FlxMath.lerp((targetY * 1.3 * distancePerItem.y) + startPosition.y, y, lerpVal);
    }
    final s = FlxMath.lerp(sc,scale.x, lerpVal);
    scale.set(s,s);
}
function snapToPosition()
{
    if (isMenuItem) {
        if (changeX)
            x = (targetY * distancePerItem.x) + startPosition.x;
        if (changeY)
            y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
    }
}

var video;
var head;
function onCreate()
{
	camGame.targetOffset.set(15,15);
}

function onCreatePost() {
	cenatGhoul = new FlxSprite();
	cenatGhoul.frames = Paths.getSparrowAtlas("something/kaighoul");
	cenatGhoul.animation.addByPrefix("die","die",24,false);
	cenatGhoul.animation.addByPrefix("grab","grab",24,false);
	cenatGhoul.animation.addByPrefix("drag","drag",24,true);
	cenatGhoul.animation.addByPrefix("spawn","spawn",24,false);
	cenatGhoul.antialiasing = ClientPrefs.data.antialiasing;
	cenatGhoul.cameras = [camHUD];
	add(cenatGhoul);
	cenatGhoul.scale.set(0.5,0.5);
	cenatGhoul.updateHitbox();
	cenatGhoul.visible = false;
	
	head = new FlxSprite(900,800);
	head.frames = Paths.getSparrowAtlas('bg/finale/headkai');
	head.animation.addByPrefix('i','idle',24);
	head.animation.addByPrefix('charge','charge0',24);
	head.animation.addByPrefix('chargeup','chargeup',24,false);
	head.animation.addByPrefix('appear','appearhead',24,false);
	head.animation.play('i');
	head.scale.set(0.9,0.9);
	head.updateHitbox();
	insert(members.indexOf(game.getLuaObject('memes'))+1,head);
	head.alpha = 0;


	head.animation.finishCallback = (s)->{
		if (s == 'appear') {
			head.animation.play('i');
		}
		if (s == 'chargeup') {
			head.animation.play('charge');
		}
	}
}

function initHead() {
	head.animation.play('appear');
	head.alpha = 1;
}

function onEvent(ev,v1,v2) {
    if (ev == '') {
        switch (v1) {
			case 'endeee':
				game.uiGroup.visible = false;
				for (i in game.playerStrums) i.x = -1000;

			case 'headpp':initHead();
		
			case 'headCharge': head.animation.play('chargeup');

			case 'myworld':
				FlxG.camera.shake(0.01,101.58 - 100.77);
			case 'zoomin':
				var time = 0.7;
				game.isCameraOnForcedPos = true;
				var x = boyfriend.getMidpoint().x - 100;
				x -=boyfriend.cameraPosition[0] - game.boyfriendCameraOffset[0];
				var y = boyfriend.getMidpoint().y - 100;
				y += boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1];
				
				game.camFollow.setPosition(x + 300,y + 200);

				FlxTween.num(game.defaultCamZoom, game.defaultCamZoom + 0.3,time,{ease: FlxEase.cubeOut},(f)->{
					FlxG.camera.zoom = f;
					game.defaultCamZoom = f;
				});
				case "Cenat Health Drain":
					//horribly coded blame daniel not me
					if (cenatGhoul == null || cenatDrainTween?.active) return;
					cenatGhoul.setPosition(healthBar.x + healthBar.width + 100,healthBar.y - 120);
					cenatGhoul.visible = true;
					disableHealthGain = true;
					healthLoss = 0;

					var drainAmt:Float = Std.parseFloat(value1);
					var time:Float = Std.parseFloat(value2);

					if (Math.isNaN(drainAmt))
						drainAmt = 0.5;
					if (Math.isNaN(time))
						time = 5;


					cenatGhoul.animation.play("spawn");
					cenatGhoul.animation.finishCallback = function(name)
					{
						switch (name)
						{
						case "spawn":
							cenatGhoul.animation.play("grab");
							FlxTween.tween(cenatGhoul,{x:healthBar.barCenter - 30},0.3);
						case "grab":	
							cenatGhoul.animation.play("drag");
							#if !debug
							cenatDrainTween = FlxTween.tween(this,{health:health - drainAmt},time,{onComplete: function(_)
							{
								cenatGhoul.animation.play("die");
								disableHealthGain = false;
				
								healthLoss = 1;


							}});
							#end

						}
					}
        }
    }
}