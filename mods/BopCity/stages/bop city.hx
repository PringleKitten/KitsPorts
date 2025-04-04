import flixel.effects.FlxFlicker;
import flixel.FlxG;

var fanumTaxed = false;
var fanumTaxing = false;
function onCreate() {
    Paths.sound("fanumtax");
    Paths.image("tax");
    Paths.sound("slap");
    Paths.sound("fanumDead");
    fanumWarning = new FlxSprite().loadGraphic(Paths.image("tax"));
    fanumWarning.cameras = [camHUD];
    fanumWarning.screenCenter('y');
    fanumWarning.alpha = 0;
    add(fanumWarning);
}
function onUpdate() {
    if (game.songName == "fanum-tax" && fanumTaxing && FlxG.keys.justPressed.SPACE)
    {    
        dad.animation.finishCallback = null;
        dad.animation.stop();
        dad.playAnim("ouch",true);
    
        boyfriend.animation.stop();
        boyfriend.playAnim("smack",true);
        boyfriend.specialAnim = true;
        boyfriend.animation.finishCallback = (s:String)->{if (s == 'smack') {boyfriend.specialAnim=false;}}

        FlxG.sound.play(Paths.sound("slap"));
        dad.specialAnim = false;
        fanumTaxing = false;
        FlxFlicker.stopFlickering(fanumWarning);
        fanumWarning.alpha = 0;
        taxSound.stop();
        game.canPause = true;
    }

    if (game.songName == "fanum-tax") {
        dad.animation.finishCallback = function(name) {
            switch(name)
            {
                case "reach":
                    game.canPause = false;
                    fanumTaxing = false;
                    taxSound.stop();
                    camHUD.visible = false;
                    trace(Paths.sound("fanumDead"));
                    var fuck = FlxG.sound.play(Paths.sound("fanumDead"),1);
                    FlxFlicker.stopFlickering(fanumWarning);
                    fanumWarning.alpha = 0;
                    dad.playAnim("reach2",true,true);
                    dad.specialAnim = true;
                    FlxTween.tween(boyfriend,{x:dad.x},1.2);
                    FlxTween.tween(boyfriend.scale,{x:0, y:0},1.2);
                    if(FlxG.sound.music != null) {
                        FlxG.sound.music.pause();
                        vocals.pause();
                        opponentVocals.pause();
                    }

                case "reach2":
                    dad.playAnim("eat",true);
                    dad.specialAnim = true;
                    
                case "eat":
                    fanumTaxed = true;
                    game.health = 0;
            }
        }
    }
}

function onEvent(event, value1, value2) {
    switch(event) {
        case "Crashout Meter":
            if (crashOutMeter == null) return;

            if (crashOutTween != null)
                crashOutTween.cancel();

            var to:Float = Std.parseFloat(value1);
            var time:Float = Std.parseFloat(value2);
            if (Math.isNaN(to))
                to = 1;

            if (Math.isNaN(time))
                time = 1;

            crashOutTween = FlxTween.tween(this,{crashOutValue:to},time);

        case "Toggle Crashout Meter":

            if (crashOutMeter == null) return;

            crashOutMeter.visible  = !crashOutMeter.visible;					
            
            scoreTxt.visible = !scoreTxt.visible;
            iconP1.visible = !iconP1.visible;
            healthBar.visible = !healthBar.visible;
        
        case "Fanum Tax":
			camGame.flash(FlxColor.RED,1);
            game.canPause = false;
			fanumTaxing = true;
			
			taxSound = FlxG.sound.play(Paths.sound("fanumtax"));
			dad.playAnim("reach",true);
			dad.specialAnim = true;
			fanumWarning.alpha = 1;
			FlxFlicker.flicker(fanumWarning,6,0.3);
    }
}