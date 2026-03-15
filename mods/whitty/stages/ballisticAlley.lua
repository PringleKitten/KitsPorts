local aggression = 0

function onCreate()
	makeAnimatedLuaSprite('whittyback', 'BallisticBackground', -600, -200);
	addAnimationByPrefix('whittyback', 'Moving', 'Background Whitty Moving', 12, true);
	addAnimationByPrefix('whittyback', 'Startup', 'Background Whitty Startup', 24, false);
	addAnimationByPrefix('whittyback', 'Start', 'Background Whitty Start0', 24, false);
	setScrollFactor('whittyback', 0.9, 0.9);
	playAnim('whittyback', 'Moving')

	makeLuaSprite('thefunnyeffect', 'thefunnyeffect', 0, 0);
	setObjectCamera('thefunnyeffect', 'other');
	scaleObject('thefunnyeffect', 0.53, 0.52);
	setProperty('thefunnyeffect.alpha', 0);

	addLuaSprite('whittyback', false);
	addLuaSprite('thefunnyeffect', false);
end

function onBeatHit()
	triggerEvent('Alt Idle Animation', 'Gf', '-scared')
end

function onSectionHit()
	setProperty('thefunnyeffect.alpha', aggression)
	doTweenAlpha('thefunnyeffectalpha', 'thefunnyeffect', aggression/2, 1, 'expoOut');
	setProperty('thefunnyeffect.scale.x', 0.55)
	setProperty('thefunnyeffect.scale.y', 0.54)
	doTweenX('thefunnyeffectX', 'thefunnyeffect.scale', 0.53, 1, 'expoOut');
	doTweenY('thefunnyeffectY', 'thefunnyeffect.scale', 0.52, 1, 'expoOut');
	if aggression < 1 then
		aggression = aggression + 0.01
	else
		aggression = 1
	end
end