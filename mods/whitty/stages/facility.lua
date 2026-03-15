function onCreate()
	makeLuaSprite('wallbg', 'wallbg', -670, -200);
	setProperty('wallbg.visible', true);

	makeLuaSprite('light', 'light', 330, 80);
	setBlendMode('light','add');
	setProperty('light.visible', true);

	makeLuaSprite('wallbgblack', 'wallbg', -3452, -200);
	setProperty('wallbgblack.visible', false);
	
	addLuaSprite('wallbg', false);
	addLuaSprite('light', false);
	addLuaSprite('wallbgblack', false);

	runTimer('lightBlinkInit', getRandomInt(1,5), getRandomInt(1,10));
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'lightBlinkInit' then
		runTimer('lightBlink', 0.1, getRandomInt(1,10));
	end
	if tag == 'lightBlink' then
		setProperty('light.visible', false);
		runTimer('lightBlinkBack', 0.01);
	end
	if tag == 'lightBlinkBack' then
		setProperty('light.visible', true);
		runTimer('lightBlinkInit', getRandomInt(1,5), getRandomInt(1,10));
	end
end


function onStepHit()
	if curStep == 896 then
		setProperty('wallbg.visible', false);
		setProperty('light.visible', false);
		setProperty('wallbgblack.visible', true);
		triggerEvent('Alt Idle Animation', 'boyfriend', '-alt')
		triggerEvent('Alt Idle Animation', 'dad', '-alt')
		triggerEvent('Alt Idle Animation', 'gf', '-alt')
		playAnim('gf', 'danceLeft-alt')
		playAnim('boyfriend', 'idle-alt')
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
		setProperty('gf.specialAnim', true);
	end
	if curStep == 1024 then
		setProperty('wallbg.visible', true);
		setProperty('light.visible', true);
		setProperty('wallbgblack.visible', false);
		triggerEvent('Alt Idle Animation', 'boyfriend', '')
		triggerEvent('Alt Idle Animation', 'dad', '')
		triggerEvent('Alt Idle Animation', 'gf', '')
		playAnim('gf', 'danceLeft')
		playAnim('boyfriend', 'idle')
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
		setProperty('gf.specialAnim', true);
	end
end