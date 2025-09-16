function onCreate()
	makeLuaSprite('bg', 'finn/bg', 900, 525);
	setProperty('defaultCamZoom', 0.9)
	scaleObject('bg', 1.3, 1.3);

	addLuaSprite('bg', false);

    makeLuaSprite('dark', 'finn/dark', 800, 425);
	scaleObject('dark', 1.4, 1.4);

	addLuaSprite('dark', true);

    makeLuaSprite('light', 'finn/light', 800, 425);
	scaleObject('light', 1.4, 1.4);

	addLuaSprite('light', true);
    
    makeLuaSprite('bulb', 'finn/bulb', 150, 200);
	scaleObject('bulb', 1.3, 1.3);

	addLuaSprite('bulb', true);
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end