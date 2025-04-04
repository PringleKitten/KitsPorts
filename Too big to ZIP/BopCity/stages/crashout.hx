import flixel.FlxG;

import flixel.graphics.tile.FlxGraphicsShader;
import flixel.ui.FlxBar;

var bar;
var crashOutValue = 0;
var crashOutTween;
var lineBG;
var bar;
var ok;
var mild;
var kys;

function onCreatePost() {
    lineBG = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/bar"));
	add(lineBG);
	lineBG.antialiasing = ClientPrefs.data.antialiasing;
    lineBG.y = 600;
    lineBG.x = 220;
    lineBG.cameras = [camHUD];

	bar = new FlxBar(0, 0, 0, 796, 111, null, "", 0, 2,
    false).createImageBar(null, Paths.image("crashoutMeter/gradiant"), FlxColor.TRANSPARENT);
	add(bar);
	bar.setPosition(12, 4);
	bar.setRange(0,1);
	bar.antialiasing = ClientPrefs.data.antialiasing;
    bar.x = lineBG.x+11;
    bar.y = lineBG.y+4;
    bar.cameras = [camHUD];

	ok = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/okiedokie"));
	add(ok);
	ok.antialiasing = ClientPrefs.data.antialiasing;
	ok.y = lineBG.y-100;
    ok.x = lineBG.x;
    ok.cameras = [camHUD];

	mild = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/mild"));
	add(mild);
	mild.antialiasing = ClientPrefs.data.antialiasing;
	mild.x = (lineBG.width / 2) - (mild.width / 2) + lineBG.x;
	mild.y = lineBG.y-50;
    mild.cameras = [camHUD];

	kys = new FlxSprite().loadGraphic(Paths.image("crashoutMeter/crashout"));
	add(kys);
	kys.x = lineBG.width;
	kys.y = lineBG.y - kys.height / 2;
	kys.antialiasing = ClientPrefs.data.antialiasing;
    kys.cameras = [camHUD];

    healthBar.visible = false;
    iconP1.visible = false;
    iconP2.visible = false;
    scoreTxt.visible = false;
}

function lerp(start, end, alpha) {
    return start + (end - start) * alpha;
}

var targetCrashOutValue = 1;
var currentCrashOutValue = crashOutValue;
var tweenTime = 1;
var elapsedTime = 0;
var isTweening = false;

function onUpdate(elapsed) {
    if (bar != null) {
        crashOutValue = Std.parseFloat(crashOutValue);
        bar.value = crashOutValue;
    }

    if (isTweening) {
        elapsedTime += elapsed;
        if (elapsedTime < tweenTime) {
            crashOutValue = lerp(currentCrashOutValue, targetCrashOutValue, elapsedTime / tweenTime);
            if (bar != null) {
                bar.value = crashOutValue;
            }
        } else {
            crashOutValue = targetCrashOutValue;
            if (bar != null) {
                bar.value = crashOutValue;
            }
            isTweening = false;
        }
    }
}

function onEvent(e, value1, value2) {
    switch (e) {
        case "Crashout Meter":
            var to = Std.parseFloat(value1);
            var time = Std.parseFloat(value2);

            targetCrashOutValue = to;
            tweenTime = time;
            elapsedTime = 0;
            currentCrashOutValue = crashOutValue;

            isTweening = true;
        
        case "Toggle Crashout Meter":
            kys.visible = false;
            mild.visible = false;
            ok.visible = false;
            bar.visible = false;
            lineBG.visible = false;
            scoreTxt.visible = true;
            iconP1.visible = true;
            healthBar.visible = true;
    }
}    