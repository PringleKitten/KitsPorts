function onCreate()
	makeLuaSprite('whittyback', 'whittyBack', -600, -200);
	setScrollFactor('whittyback', 0.9, 0.9);
	
	makeLuaSprite('whittyfront', 'whittyFront', -650, 600);
	setScrollFactor('whittyfront', 0.9, 0.9);
	scaleObject('whittyfront', 1.1, 1.1);

	addLuaSprite('whittyback', false);
	addLuaSprite('whittyfront', false);
end