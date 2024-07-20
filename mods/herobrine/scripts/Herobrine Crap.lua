function onCreate()
    if difficultyName == "Hardcore" then
        setPropertyFromClass('ClientPrefs', 'middleScroll', true)
        setPropertyFromClass('ClientPrefs', 'opponentStrums', false)
    elseif difficultyName == "Hard" then
        setPropertyFromClass('ClientPrefs', 'middleScroll', false)
        setPropertyFromClass('ClientPrefs', 'opponentStrums', true)
    end
end
function opponentNoteHit(noteData, noteType, isSustainNote)
    if misses > 0 then
        if getProperty("health") > 0.02 then
            setProperty('health', getProperty("health")-0.02)
        end
    end
end
function noteMiss(noteData, noteType, isSustainNote)
    if difficultyName == "Hardcore" then
        os.exit()
    end
end
function onUpdate()
    if keyJustPressed("space") then
        characterPlayAnim("boyfriend", "dodge", false)
        setProperty("boyfriend.specialAnim", true)
    end
end
function onSongStart()
    triggerEvent("Screen Shake", "9999, 0.002", "9999, 0.002")
end