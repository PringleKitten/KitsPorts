playCutscene = true;
local canSkipAll = true
local skippingHold = 0
local canSkipDialogue = false
local letter = 0
local dialoguePosition = 0
local canEnter = false
local canX = false

dialog = ""
dialogSound = ""

local defaultDADx = getProperty('dad.x')
local defaultDADy = getProperty('dad.y')

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playCutscene then
			playCutscene = false
			setProperty('vocals.volume', 0)
			setProperty('healthBar.visible', false);
			setProperty('iconP1.visible', false);
			setProperty('iconP2.visible', false);
			setProperty('scoreTxt.visible', false);
			setProperty('dad.visible', false);
			setProperty('dad.x', defaultDADx - 200)
			setProperty('dad.y', defaultDADy + 100)
			cameraSetTarget('dad');
			playMusic('windLmao', 1, true);
			playAnim('whittyback', 'Start')
			playAnim('gf', 'scared')
			
			makeAnimatedLuaSprite('whittyCutscene', 'cuttinDeezeBalls', -600, -80);
			addAnimationByPrefix('whittyCutscene', 'Cutscene', 'Whitty Ballistic Cutscene', 24, false);
			playAnim('whittyCutscene', 'Cutscene')
			setObjectOrder('whittyCutscene', getObjectOrder('dadGroup'))
			
			makeLuaSprite('blackCutscene', 'empty', 0, 0);
			makeGraphic('blackCutscene', screenWidth, screenHeight, 'FFFFFF');
			setObjectCamera('blackCutscene', 'other');
			setProperty('blackCutscene.alpha', 0);
			
			makeAnimatedLuaSprite('skip', 'skip', screenWidth-160, screenHeight-152);
			addAnimationByPrefix('skip', 'hold0.125', 'hold0000', 8, false);
			addAnimationByPrefix('skip', 'hold0.25', 'hold0001', 8, false);
			addAnimationByPrefix('skip', 'hold0.375', 'hold0002', 8, false);
			addAnimationByPrefix('skip', 'hold0.5', 'hold0003', 8, false);
			addAnimationByPrefix('skip', 'hold0.625', 'hold0004', 8, false);
			addAnimationByPrefix('skip', 'hold0.75', 'hold0005', 8, false);
			addAnimationByPrefix('skip', 'hold0.875', 'hold0006', 8, false);
			addAnimationByPrefix('skip', 'hold1', 'hold0007', 8, false);
			setObjectCamera('skip', 'other');
			setProperty('skip.alpha', 0);
			
			addLuaSprite('whittyCutscene', false);
			addLuaSprite('boyfriendCutscene', false);
			addLuaSprite('blackCutscene', false);
			addLuaSprite('skip', false);
			
			runTimer('micBreak', 1.9);
			runTimer('micThrow', 3.7);
			runTimer('micCrack', 4.6);
			runTimer('ouchMyToe', 6.5);
			runTimer('stopCutscene', 9.7);
			return Function_Stop;
		end
	end
	if not playCutscene then
		if getProperty('cpuControlled', true) then
			setProperty('botplayTxt.visible', true);
		end
		setProperty('vocals.volume', 1)
		return Function_Continue;
	end
end

function dialogueFunc(text, sound)
	dialog = text
	dialogSound = sound
	canX = true
	canEnter = false
	runTimer('letter', 0.04, string.len(dialog));
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'letter' and canX then
		setTextString('textLine', string.sub(dialog, 0, (loops - loopsLeft)));
		setTextString('textLineBack', string.sub(dialog, 0, (loops - loopsLeft)));
		playSound(dialogSound, 0.8);
		if loopsLeft == 0 then
			canX = false
			canEnter = true
		end
	end
	if tag == 'micBreak' then
		playSound('micBreak');
	end
	if tag == 'micThrow' then
		playSound('micThrow');
		playSound('souljaboyCrank');
	end
	if tag == 'micCrack' then
		playSound('micCrack');
		runTimer('StartupTimer', 0.5);
	end
	if tag == 'StartupTimer' then
		playAnim('whittyback', 'Startup');
		cameraShake('camGame', 0.01, 0.1);
	end
	if tag == 'ouchMyToe' then
		playSound('ouchMyToe');
		cameraShake('camGame', 0.03, 3.6);
	end
	if tag == 'stopCutscene' then
		doTweenAlpha('blackCutsceneAlpha', 'blackCutscene', 1, 0.5, 'leaner');
	end
	if tag == 'speech bubble idle' then
		letter = 0
		canSkipAll = false
		canSkipDialogue = true
		playAnim('speech_bubble', 'idle');
		setProperty('speech_bubble.x', 50);
		setProperty('speech_bubble.y', 400);
		setProperty('whittyPort.visible', true);
		setProperty('boyfriendPort.visible', false);
		runTimer('textBox1timer', 0.05);

		removeLuaSprite('skip');
		makeLuaText('skipText', 'Press BACK/PAUSE to Skip', 770, screenWidth-780, screenHeight-30);
		setObjectCamera('skipText', 'other');
		setTextAlignment('skipText', 'right');
		setTextSize('skipText', 20);
		setTextFont('skipText', 'vcr.ttf');

		addLuaText('skipText');
	end
	if tag == 'textBox1timer' then
		dialogueFunc('ENOUGH.', 'ballistic')
	end
	if tag == 'textBox2timer' then
		dialogueFunc("THEY'VE TAKEN ALL I EVER HAD.", 'ballistic')
	end
	if tag == 'textBox3timer' then
		dialogueFunc("I'VE BEEN DOOMED INTO AN ENDLESS CYCLE \nOF RUNNING AND HIDING FROM THINGS I \nCANNOT CONTROL.", 'ballistic')
	end
	if tag == 'textBox4timer' then
		dialogueFunc("CURSE YOU, CURSE YOU AND THE FILTH THAT BROUGHT YOU INTO THIS WORLD.", 'ballistic')
	end
	if tag == 'textBox5timer' then
		dialogueFunc('baboop peebo', 'pixelText')
	end
	if tag == 'skippingTimer' then
		if skippingHold < 1 then
			skippingHold = skippingHold + (1/8);
			setProperty('skip.alpha', skippingHold);
			playAnim('skip', 'hold'..skippingHold);
			runTimer('skippingTimer', (1/8));
		elseif skippingHold == 1 then
			cancelTimer('micBreak', 1.9);
			cancelTimer('micThrow', 3.7);
			cancelTimer('micCrack', 4.6);
			cancelTimer('StartupTimer', 0.5);
			cancelTimer('ouchMyToe', 6.5);
			cancelTimer('stopCutscene', 9.7);
			cancelTimer('stopCutscene');
			cancelTimer('textBox1timer');
			cancelTimer('textBox2timer');
			cancelTimer('textBox3timer');
			cancelTimer('textBox4timer');
			cancelTimer('textBox5timer');
			cancelTimer('textBox6timer');
			cancelTimer('textBox7timer');
			cancelTimer('textBox8timer');
			cancelTimer('letter');
			setProperty('blackCutscene.alpha', 1);
			removeLuaSprite('boyfriendCutscene');
			removeLuaSprite('whittyCutscene');
			removeLuaSprite('skip');
			doTweenAlpha('blackCutsceneAlphaSkip', 'blackCutscene', 0, 0.5, 'leaner');
			setProperty('boyfriend.visible', true);
			setProperty('dad.visible', true);
			setProperty('gf.visible', true);
			stopSound('micBreak');
			stopSound('micThrow');
			stopSound('micCrack');
			stopSound('souljaboyCrank');
			playAnim('whittyback', 'Moving');
			setProperty('dad.x', defaultDADx)
			setProperty('dad.y', defaultDADy)
		end
	end
end

function onUpdate()
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') or ((mobileChoice == 1 or buildTarget == 'android') and getPropertyFromClass('flixel.FlxG', 'android.justPressed.BACK')) and canSkipDialogue or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.BACKSPACE') and canSkipDialogue then
			dialoguePosition = 8
			canSkipDialogue = false
			canEnter = false
			letter = 0
			runTimer('endDialogue', 0.05);
			cancelTimer('textBox1timer');
			cancelTimer('textBox2timer');
			cancelTimer('textBox3timer');
			cancelTimer('textBox4timer');
			cancelTimer('textBox5timer');
			cancelTimer('textBox6timer');
			cancelTimer('textBox7timer');
			cancelTimer('textBox8timer');
			cancelTimer('letter');
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
			doTweenAlpha('whiteBGAlpha', 'whiteBG', 0, 1, 'leaner');
			doTweenAlpha('speech_bubbleAlpha', 'speech_bubble', 0, 1, 'leaner');
			soundFadeOut('city', 1, 0)
			removeLuaText('skipText')
			removeLuaText('textLineBack')
			removeLuaText('textLine')
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or ((mobileChoice == 1 or buildTarget == 'android') and mouseClicked("left")) and canSkipAll and skippingHold == 0 or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canSkipAll and skippingHold == 0 then
		skippingHold = skippingHold + (1/8)
		setProperty('skip.alpha', skippingHold)
		playAnim('skip', 'hold'..skippingHold)
		runTimer('skippingTimer', (1/8))
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justReleased.ENTER') or ((mobileChoice == 1 or buildTarget == 'android') and mouseClicked("left")) and canSkipAll and skippingHold > 0 or getPropertyFromClass('flixel.FlxG', 'keys.justReleased.SPACE') and canSkipAll and skippingHold > 0 then
		skippingHold = 0
		cancelTimer('skippingTimer')
		setProperty('skip.alpha', 0)
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or ((mobileChoice == 1 or buildTarget == 'android') and mouseClicked("left")) and canX or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canX then
		if dialoguePosition == 0 then
			cancelTimer('textBox1timer')
			letter = 100
			canX = false
			setTextString('textLine', 'ENOUGH.')
			setTextString('textLineBack', 'ENOUGH.')
			cancelTimer('letter');
			playSound('ballistic')
			canEnter = true
		end
		if dialoguePosition == 1 then
			cancelTimer('textBox2timer')
			letter = 100
			canX = false
			setTextString('textLine', "THEY'VE TAKEN ALL I EVER HAD.")
			setTextString('textLineBack', "THEY'VE TAKEN ALL I EVER HAD.")
			cancelTimer('letter');
			playSound('pixelText')
			canEnter = true
		end
		if dialoguePosition == 2 then
			cancelTimer('textBox3timer')
			letter = 100
			canX = false
			setTextString('textLine', "I'VE BEEN DOOMED INTO AN ENDLESS CYCLE OF RUNNING AND HIDING FROM THINGS I CANNOT CONTROL.")
			setTextString('textLineBack', "I'VE BEEN DOOMED INTO AN ENDLESS CYCLE OF RUNNING AND HIDING FROM THINGS I CANNOT CONTROL.")
			cancelTimer('letter');
			playSound('ballistic')
			canEnter = true
		end
		if dialoguePosition == 3 then
			cancelTimer('textBox4timer')
			letter = 100
			canX = false
			setTextString('textLine', "CURSE YOU, CURSE YOU AND THE FILTH THAT BROUGHT YOU INTO THIS WORLD.")
			setTextString('textLineBack', "CURSE YOU, CURSE YOU AND THE FILTH THAT BROUGHT YOU INTO THIS WORLD.")
			cancelTimer('letter');
			playSound('ballistic')
			canEnter = true
		end
		if dialoguePosition == 4 then
			cancelTimer('textBox5timer')
			letter = 100
			canX = false
			setTextString('textLine', 'baboop peebo')
			setTextString('textLineBack', 'baboop peebo')
			cancelTimer('letter');
			playSound('pixelText')
			canEnter = true
		end
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or ((mobileChoice == 1 or buildTarget == 'android') and mouseClicked("left")) and canEnter or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canX then
		if dialoguePosition == 0 then
			dialoguePosition = 1
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox2timer', 0.05);
			setProperty('whittyPort.visible', true);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 1 then
			dialoguePosition = 2
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox3timer', 0.05);
			setProperty('whittyPort.visible', true);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 2 then
			dialoguePosition = 3
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox4timer', 0.05);
			setProperty('whittyPort.visible', true);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 3 then
			dialoguePosition = 4
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox5timer', 0.05);
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', true);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 4 then
			dialoguePosition = 5
			canEnter = false
			letter = 0
			runTimer('endDialogue', 0.05);
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
			doTweenAlpha('whiteBGAlpha', 'whiteBG', 0, 1, 'leaner');
			doTweenAlpha('speech_bubbleAlpha', 'speech_bubble', 0, 1, 'leaner');
			soundFadeOut('city', 1, 0)
			removeLuaText('skipText')
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'blackCutsceneAlpha' then
		doTweenAlpha('blackCutsceneAlpha1', 'blackCutscene', 0, 0.5, 'leaner');
		setProperty('boyfriend.visible', true);
		setProperty('dad.visible', true);
		setProperty('gf.visible', true);
		setProperty('dad.x', defaultDADx)
		setProperty('dad.y', defaultDADy)
		removeLuaSprite('boyfriendCutscene');
		removeLuaSprite('whittyCutscene');
		playAnim('whittyback', 'Moving')
	end
	if tag == 'blackCutsceneAlpha1' then
		makeLuaSprite('whiteBG', 'empty', 0, 0);
		makeGraphic('whiteBG', screenWidth, screenHeight, 'FFFFFF');
		setObjectCamera('whiteBG', 'other');
		setProperty('whiteBG.alpha', 0.5);
			
		makeAnimatedLuaSprite('whittyPort', 'whittyPort', 200, 190);
		addAnimationByPrefix('whittyPort', 'whittyPort', 'Whitty Portrait Crazy instance 1', 24, true);
		setObjectCamera('whittyPort', 'other');
		setProperty('whittyPort.visible', false);
		scaleObject('whittyPort', 0.8, 0.8);
		playAnim('whittyPort', 'whittyPort')
			
		makeLuaSprite('boyfriendPort', 'boyfriendPort', 820, 222);
		setObjectCamera('boyfriendPort', 'other');
		setProperty('boyfriendPort.visible', false);
		scaleObject('boyfriendPort', 0.8, 0.8);
			
		makeAnimatedLuaSprite('speech_bubble', 'speech_bubble_talking', 10, 320);
		addAnimationByPrefix('speech_bubble', 'idle', 'speech bubble normal', 24, true);
		addAnimationByPrefix('speech_bubble', 'open', 'Speech Bubble Normal Open', 24, false);
		setObjectCamera('speech_bubble', 'other');
		playAnim('speech_bubble', 'open')

		makeLuaText('textLineBack', '', 770, 252, 462);
		setObjectCamera('textLineBack', 'other');
		setTextAlignment('textLineBack', 'left');
		setTextSize('textLineBack', 32);
		setTextFont('textLineBack', 'vcr.ttf');
		setTextBorder('textLineBack', 0, FFFFFF);
		setTextColor('textLineBack', 'FF0000');
		
		makeLuaText('textLine', '', 770, 250, 460);
		setObjectCamera('textLine', 'other');
		setTextAlignment('textLine', 'left');
		setTextSize('textLine', 32);
		setTextFont('textLine', 'vcr.ttf');
		setTextBorder('textLine', 0, FFFFFF);
		setTextColor('textLine', '000000');

		addLuaSprite('whiteBG', false);
		addLuaSprite('whittyPort', false);
		addLuaSprite('boyfriendPort', false);
		addLuaSprite('speech_bubble', false);
		addLuaText('textLineBack');
		addLuaText('textLine');

		runTimer('speech bubble idle', 0.3);
	end
	if tag == 'speech_bubbleAlpha' or tag == 'blackCutsceneAlphaSkip' then
		playCutscene = false
		canSkipAll = false
		canSkipDialogue = false
		startCountdown()
		setProperty('healthBar.visible', true);
		setProperty('iconP1.visible', true);
		setProperty('iconP2.visible', true);
		setProperty('scoreTxt.visible', true);
		removeLuaSprite('whiteBG');
		removeLuaSprite('whittyPort');
		removeLuaSprite('boyfriendPort');
		removeLuaSprite('speech_bubble');
		removeLuaText('textLineBack')
		removeLuaText('textLine')
	end
end