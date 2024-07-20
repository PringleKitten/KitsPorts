function onCreate()
	makeLuaSprite('sky', 'background/woods/sky');
    scaleObject('sky', 1.5, 1.5);
    setScrollFactor('sky', 0, 0);
	screenCenter('sky', 'xy')
    addLuaSprite('sky', false);

    makeLuaSprite('woods', 'background/woods/woods');
    screenCenter('woods', 'xy')
	addLuaSprite('woods', false);

    makeLuaSprite('dark', 'background/woods/dark');
    doTweenAlpha('darkbg', 'dark', 0.2, 0.0000001, 'linear')
    screenCenter('dark', 'xy')
	addLuaSprite('dark', true);

    setProperty('boyfriendCameraOffset[0]', -240)
    setProperty('boyfriendCameraOffset[1]', -80)
end


colors = {'31A2FD', '31FD8C', 'F794F7', 'F96D63', 'FBA633'}

local curLightEvent = 0
function onEvent(name, value1, value2, strumTime)
    if name == "rgb toggle" then
        if doRGB then
            doRGB = false
            doTweenAlpha("hp", "healthBar", 0, 5.5, "linear")
            doTweenAlpha("hpbg", "healthBarBG", 0, 5.5, "linear")
            doTweenAlpha("i1", "iconP1", 0, 5.5, "linear")
            doTweenAlpha("i2", "iconP2", 0, 5.5, "linear")
            doTweenAlpha("sc", "scoreTxt", 0, 5.5, "linear")
            doTweenAlpha("tb", "timeBar", 0, 5.5, "linear")
            doTweenAlpha("tt", "timeTxt", 0, 5.5, "linear")
			noteTweenAlpha("o1",0,0, 5.5,"quartInOut");
            noteTweenAlpha("o2",1,0, 5.5,"quartInOut");
            noteTweenAlpha("o3",2,0, 5.5,"quartInOut");
            noteTweenAlpha("o4",3,0, 5.5,"quartInOut");
			noteTweenAlpha("o5",4,0, 5.5,"quartInOut");
            noteTweenAlpha("o6",5,0, 5.5,"quartInOut");
            noteTweenAlpha("o7",6,0, 5.5,"quartInOut");
            noteTweenAlpha("o8",7,0, 5.5,"quartInOut");
        else
            doRGB = true
        end
    end
end

function onBeatHit()
    if doRGB then
		triggerEvent("Add Camera Zoom", 0.08, 0.06)
		lightId = getRandomInt(1, #colors, tostring(curLightEvent))
		doTweenColor('boyfriendColorTween', 'boyfriend', colors[lightId], 0.00000001, 'quadInOut')
		doTweenColor('dadColorTween', 'dad', colors[lightId], 0.00000001, 'quadInOut')
		doTweenColor('gfColorTween', 'gf', colors[lightId], 0.00000001, 'quadInOut')
		doTweenColor('skyColorTween', 'sky', colors[lightId], 0.00000001, 'quadInOut')
		doTweenColor('woodsColorTween', 'woods', colors[lightId], 0.00000001, 'quadInOut')
		curLightEvent = lightId
    else
        doTweenColor('boyfriendColorTween', 'boyfriend', '0xffffffff', 0.00000001, 'quadInOut')
        doTweenColor('dadColorTween', 'dad', '0xffffffff', 0.00000001, 'quadInOut')
        doTweenColor('gfColorTween', 'gf', '0xffffffff', 0.00000001, 'quadInOut')
		doTweenColor('skyColorTween', 'sky', '0xffffffff', 0.00000001, 'quadInOut')
		doTweenColor('woodsColorTween', 'woods', '0xffffffff', 0.00000001, 'quadInOut')
        curLightEvent = 0
	end
    scaleObject('sky', 1.75, 1.75, false)
    doTweenX('bop', 'sky.scale', 1.5, 0.15, 'linear')
    doTweenY('bop2', 'sky.scale', 1.5, 0.15, 'linear')
end