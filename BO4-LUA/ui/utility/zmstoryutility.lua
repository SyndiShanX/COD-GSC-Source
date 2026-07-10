CoD.ZMStoryUtility = {}
CoD.ZMStoryUtility.StoryIndex = LuaEnum.createEnum("STORY_1", "STORY_2", "STORY_INDEX_COUNT")
CoD.ZMStoryUtility.StoryNames = {
	[CoD.ZMStoryUtility.StoryIndex.STORY_1] = 0x6D26560889B0C05,
	[CoD.ZMStoryUtility.StoryIndex.STORY_2] = 0xAAA6B748B1B361A,
}
CoD.ZMStoryUtility.CharacterIndexToStory = {}
DataSources.ZMStoryLoadouts = ListHelper_SetupDataSource("ZMStoryLoadouts", function(f1_arg0, f1_arg1)
	local f1_local0 = {}
	local f1_local1 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local1 = f1_local1.selectedZMStory
	local f1_local2 = f1_local1 and f1_local1:get()
	for f1_local3 = CoD.ZMStoryUtility.StoryIndex.STORY_1, CoD.ZMStoryUtility.StoryIndex.STORY_INDEX_COUNT - 1, 1 do
		table.insert(f1_local0, {
			models = {
				storyIndex = f1_local3,
				storyName = CoD.ZMStoryUtility.StoryNames[f1_local3],
			},
			properties = {
				selectIndex = f1_local3 == f1_local2,
			},
		})
	end
	return f1_local0
end)
CoD.ZMStoryUtility.GetCurrentMapStory = function()
	local f2_local0 = function(f3_arg0)
		if f3_arg0 and CoD.mapsTable[f3_arg0] then
			return CoD.mapsTable[f3_arg0][0xA3627D705B66CDE] or 0
		else
		end
	end
	local f2_local1 = nil
	if InFrontend() then
		local f2_local2 = Engine[0x8DF2E5447F384B9]()
		f2_local2 = f2_local2:create("MapVote.mapVoteMapNext")
		f2_local1 = f2_local2:get()
		if not f2_local1 or f2_local1 == 0x0 then
			local f2_local3 = Engine[0x8DF2E5447F384B9]()
			f2_local3 = f2_local3:create("lobbyRoot.selectedMapId")
			f2_local1 = f2_local3:get()
			if not f2_local1 or f2_local1 == 0x0 then
				f2_local1 = Engine[0xC53F8D38DF9042B](Engine[0xE67E7253CC272C9]())
			end
		end
	else
		f2_local1 = Engine[0xC53F8D38DF9042B](Engine[0xE67E7253CC272C9]())
	end
	local f2_local2 = f2_local0(f2_local1)
	if f2_local2 then
		return f2_local2
	else
		return 0
	end
end
CoD.ZMStoryUtility.IsUnlockableItemAvailableInSelectedStory = function(f4_arg0, f4_arg1)
	local f4_local0 = Engine[0x4DF5CFBC1771947](f4_arg0)
	f4_local0 = f4_local0.selectedZMStory
	local f4_local1 = f4_local0 and f4_local0:get()
	if f4_local1 == CoD.ZMStoryUtility.StoryIndex.STORY_1 and f4_arg1[0x72DDE61F5350E2C] == 1 then
		return true
	elseif f4_local1 == CoD.ZMStoryUtility.StoryIndex.STORY_2 and f4_arg1[0x72DE161F5351345] == 1 then
		return true
	else
		return false
	end
end
CoD.ZMStoryUtility.SetSelectedStoryOnLoad = function()
	local f5_local0 = CoD.BaseUtility.GetMapValue(Engine[0xB87231BF773995E](), 0xA3627D705B66CDE)
	if f5_local0 then
		Engine[0x337129162C820FB](f5_local0)
	end
end
CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory = function(f6_arg0)
	local f6_local0 = CoD.ZMStoryUtility.GetCurrentMapStory()
	Engine[0x337129162C820FB](f6_local0)
	local f6_local1 = Engine[0x4DF5CFBC1771947](f6_arg0)
	f6_local1 = f6_local1:create("selectedZMStory")
	f6_local1:set(f6_local0)
end
CoD.ZMStoryUtility.UpdateSelectedStory = function(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0:getModel()
	f7_local0 = f7_local0.storyIndex:get()
	Engine[0x337129162C820FB](f7_local0)
	local f7_local1 = Engine[0x4DF5CFBC1771947](f7_arg1)
	f7_local1 = f7_local1:create("selectedZMStory")
	f7_local1:set(f7_local0)
end
CoD.ZMStoryUtility.UpdateSelectedCharacterStory = function(f8_arg0, f8_arg1)
	local f8_local0 = CoD.SafeGetModelValue(f8_arg0:getModel(), "characterIndex")
	if not f8_local0 then
		return
	elseif not CoD.ZMStoryUtility.CharacterIndexToStory[f8_local0] then
		CoD.ZMStoryUtility.GenerateCharacterToStoryTable()
	end
	local f8_local1 = CoD.ZMStoryUtility.CharacterIndexToStory[f8_local0]
	if f8_local1 then
		Engine[0x337129162C820FB](f8_local1)
		local f8_local2 = Engine[0x4DF5CFBC1771947](f8_arg1)
		f8_local2 = f8_local2:create("selectedZMStory")
		f8_local2:set(f8_local1)
	end
end
CoD.ZMStoryUtility.GenerateCharacterToStoryTable = function()
	if not CoD.MapUtility.MapsTable then
		return
	end
	for f9_local8, f9_local9 in pairs(CoD.MapUtility.MapsTable) do
		if f9_local9.session_mode == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and f9_local9[0xA3627D705B66CDE] and f9_local9.zmCharacters then
			for f9_local6, f9_local7 in ipairs(f9_local9.zmCharacters) do
				if f9_local7.characterIndex then
					CoD.ZMStoryUtility.CharacterIndexToStory[f9_local7.characterIndex] = f9_local9[0xA3627D705B66CDE]
				end
			end
		end
	end
end
