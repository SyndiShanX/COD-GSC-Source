require("x64:fda45231af81f63")
require("x64:46349b7589a5cf8")
CoD.MapVoteZM = InheritFrom(LUI.UIElement)
CoD.MapVoteZM.__defaultWidth = 394
CoD.MapVoteZM.__defaultHeight = 355
CoD.MapVoteZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MapVoteZM)
	self.id = "MapVoteZM"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorMapGameTypeAndDifficulty = CoD.DirectorMapGameTypeAndDifficulty.new(f1_arg0, f1_arg1, 0, 0, 6, 388, 0, 0, 37, 143)
	DirectorMapGameTypeAndDifficulty:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorMapGameTypeAndDifficulty:setAlpha(0)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C95DCE378B96DFF"))
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C95DCE378B96DFF"))
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(MapNameToMapImage(f3_local0)))
		end
	end)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(CoD.ZombieUtility.GetLocalZMDifficultyImage(f4_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath = function()
		local f5_local0 = DataSources.MapVote.getModel(f1_arg1)
		f5_local0 = f5_local0.mapVoteGameModeNext
		if f5_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image(f5_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(CoD.ZombieUtility.MapNameToZMOfflineLocalizedMapName(f6_local0))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath = function()
		local f7_local0 = DataSources.MapVote.getModel(f1_arg1)
		f7_local0 = f7_local0.mapVoteMapNext
		if f7_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc(f7_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f8_local0))
		end
	end)
	self:addElement(DirectorMapGameTypeAndDifficulty)
	self.DirectorMapGameTypeAndDifficulty = DirectorMapGameTypeAndDifficulty
	local MapVoteItemRandomZM = CoD.MapVoteItemZM.new(f1_arg0, f1_arg1, 0, 0, 0, 394, 0, 0, 249, 355)
	MapVoteItemRandomZM.MapImage:setImage(RegisterImage(@"uie_lui_random_map_vote"))
	MapVoteItemRandomZM.GameMode:setText(LocalizeToUpperString(@"menu/mode_classified"))
	MapVoteItemRandomZM.MapName:setText(LocalizeToUpperString(@"menu/classified"))
	MapVoteItemRandomZM.GameModeIcon:setImage(RegisterImage(@"blacktransparent"))
	MapVoteItemRandomZM.VoteType:setText(LocalizeToUpperString(@"menu/random"))
	MapVoteItemRandomZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteCountRandom", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			MapVoteItemRandomZM.voteCount:setText(f9_local0)
		end
	end)
	MapVoteItemRandomZM:registerEventHandler("lobby_map_vote_random_chosen", function(element, event)
		local f10_local0 = nil
		PlayClip(self, "MapVoteChosenRandom", f1_arg1)
		if not f10_local0 then
			f10_local0 = element:dispatchEventToChildren(event)
		end
		return f10_local0
	end)
	MapVoteItemRandomZM:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapVoteItemRandomZM, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.LobbyMapVoteSelectRandom(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(MapVoteItemRandomZM)
	self.MapVoteItemRandomZM = MapVoteItemRandomZM
	local MapVoteItemPreviousZM = CoD.MapVoteItemZM.new(f1_arg0, f1_arg1, 0, 0, 0, 394, 0, 0, 143, 249)
	MapVoteItemPreviousZM:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return not CoD.LobbyUtility.MapVotePreviousSelectable()
			end,
		},
	})
	local LobbyStatus = MapVoteItemPreviousZM
	local MapVoteItemNextZM = MapVoteItemPreviousZM.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	MapVoteItemNextZM(LobbyStatus, f1_local6["lobbyRoot.mapVote"], function(f15_arg0)
		f1_arg0:updateElementState(MapVoteItemPreviousZM, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.mapVote",
		})
	end, false)
	LobbyStatus = MapVoteItemPreviousZM
	MapVoteItemNextZM = MapVoteItemPreviousZM.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	MapVoteItemNextZM(LobbyStatus, f1_local6["lobbyRoot.lobbyNav"], function(f16_arg0)
		f1_arg0:updateElementState(MapVoteItemPreviousZM, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	MapVoteItemPreviousZM.VoteType:setText(LocalizeToUpperString(@"menu/prev"))
	MapVoteItemPreviousZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapPrevious", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			MapVoteItemPreviousZM.MapImage:setImage(RegisterImage(MapNameToMapImage(f17_local0)))
		end
	end)
	MapVoteItemPreviousZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModePrevious", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			MapVoteItemPreviousZM.GameMode:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f18_local0))
		end
	end)
	MapVoteItemPreviousZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapPrevious", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			MapVoteItemPreviousZM.MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperName(f19_local0))
		end
	end)
	MapVoteItemPreviousZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModePrevious", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			MapVoteItemPreviousZM.GameModeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f20_local0)))
		end
	end)
	MapVoteItemPreviousZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteCountPrevious", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			MapVoteItemPreviousZM.voteCount:setText(f21_local0)
		end
	end)
	MapVoteItemPreviousZM:registerEventHandler("lobby_map_vote_previous_chosen", function(element, event)
		local f22_local0 = nil
		PlayClip(self, "MapVoteChosenPrevious", f1_arg1)
		if not f22_local0 then
			f22_local0 = element:dispatchEventToChildren(event)
		end
		return f22_local0
	end)
	MapVoteItemPreviousZM:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f23_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapVoteItemPreviousZM, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.LobbyMapVoteSelectPrevious(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(MapVoteItemPreviousZM)
	self.MapVoteItemPreviousZM = MapVoteItemPreviousZM
	MapVoteItemNextZM = CoD.MapVoteItemZM.new(f1_arg0, f1_arg1, 0, 0, 0, 394, 0, 0, 37, 143)
	MapVoteItemNextZM.VoteType:setText(LocalizeToUpperString(@"menu/next"))
	MapVoteItemNextZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			MapVoteItemNextZM.MapImage:setImage(RegisterImage(MapNameToMapImage(f26_local0)))
		end
	end)
	MapVoteItemNextZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			MapVoteItemNextZM.GameMode:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f27_local0))
		end
	end)
	MapVoteItemNextZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			MapVoteItemNextZM.MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperName(f28_local0))
		end
	end)
	MapVoteItemNextZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			MapVoteItemNextZM.GameModeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f29_local0)))
		end
	end)
	MapVoteItemNextZM:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteCountNext", function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			MapVoteItemNextZM.voteCount:setText(f30_local0)
		end
	end)
	MapVoteItemNextZM:registerEventHandler("lobby_map_vote_next_chosen", function(element, event)
		local f31_local0 = nil
		PlayClip(self, "MapVoteChosenNext", f1_arg1)
		if not f31_local0 then
			f31_local0 = element:dispatchEventToChildren(event)
		end
		return f31_local0
	end)
	MapVoteItemNextZM:registerEventHandler("gain_focus", function(element, event)
		local f32_local0 = nil
		if element.gainFocus then
			f32_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f32_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f32_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapVoteItemNextZM, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.LobbyMapVoteSelectNext(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(MapVoteItemNextZM)
	self.MapVoteItemNextZM = MapVoteItemNextZM
	LobbyStatus = LUI.UIText.new(0, 0, 5, 384, 0, 0, 12, 32)
	LobbyStatus:setRGB(0.63, 0.62, 0.61)
	LobbyStatus:setTTF("ttmussels_regular")
	LobbyStatus:setLetterSpacing(6)
	LobbyStatus:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LobbyStatus:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LobbyStatus:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyStatus", function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			LobbyStatus:setText(ToUpper(f35_local0))
		end
	end)
	self:addElement(LobbyStatus)
	self.LobbyStatus = LobbyStatus
	local f1_local7 = DirectorMapGameTypeAndDifficulty
	f1_local6 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8.localZMDifficulty, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath)
	f1_local7 = DirectorMapGameTypeAndDifficulty
	f1_local6 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8.offlineScreenState, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath)
	f1_local7 = DirectorMapGameTypeAndDifficulty
	f1_local6 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8.localZMDifficulty, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	f1_local7 = DirectorMapGameTypeAndDifficulty
	f1_local6 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8.localZMTrialVariant, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	f1_local7 = DirectorMapGameTypeAndDifficulty
	f1_local6 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["MapVote.mapVoteGameModeNext"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	self:mergeStateConditions({
		{
			stateName = "MapVote",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.VOTING)
			end,
		},
		{
			stateName = "MapVoteChosenNext",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN) and CoD.ModelUtility.IsGlobalModelValueEqualToEnum("MapVote.lobbyMapVoteType", Enum[@"lobbymapvote"][@"lobby_mapvote_next"])
			end,
		},
		{
			stateName = "MapVoteChosenPrevious",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN) and CoD.ModelUtility.IsGlobalModelValueEqualToEnum("MapVote.lobbyMapVoteType", Enum[@"lobbymapvote"][@"lobby_mapvote_previous"])
			end,
		},
		{
			stateName = "MapVoteChosenRandom",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN) and CoD.ModelUtility.IsGlobalModelValueEqualToEnum("MapVote.lobbyMapVoteType", Enum[@"lobbymapvote"][@"lobby_mapvote_random"])
			end,
		},
		{
			stateName = "SelectedMap",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN)
			end,
		},
	})
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.mapVote"], function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "lobbyRoot.mapVote",
		})
	end, false)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.lobbyNav"], function(f42_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local7, f1_local8["MapVote.lobbyMapVoteType"], function(f43_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "MapVote.lobbyMapVoteType",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f44_arg2, f44_arg3, f44_arg4)
		if CoD.LobbyUtility.ShouldSetMapVoteStateToSelectedMap(self) then
			CoD.LobbyUtility.SetMapVoteSelectedStateOnClipOver(self, controller, "SelectedMap")
		end
	end)
	DirectorMapGameTypeAndDifficulty.id = "DirectorMapGameTypeAndDifficulty"
	MapVoteItemRandomZM.id = "MapVoteItemRandomZM"
	MapVoteItemPreviousZM.id = "MapVoteItemPreviousZM"
	MapVoteItemNextZM.id = "MapVoteItemNextZM"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MapVoteZM.__resetProperties = function(f45_arg0)
	f45_arg0.LobbyStatus:completeAnimation()
	f45_arg0.MapVoteItemNextZM:completeAnimation()
	f45_arg0.MapVoteItemPreviousZM:completeAnimation()
	f45_arg0.MapVoteItemRandomZM:completeAnimation()
	f45_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
	f45_arg0.LobbyStatus:setTopBottom(0, 0, 12, 32)
	f45_arg0.LobbyStatus:setAlpha(1)
	f45_arg0.MapVoteItemNextZM:setAlpha(1)
	f45_arg0.MapVoteItemPreviousZM:setTopBottom(0, 0, 143, 249)
	f45_arg0.MapVoteItemPreviousZM:setAlpha(1)
	f45_arg0.MapVoteItemRandomZM:setTopBottom(0, 0, 249, 355)
	f45_arg0.MapVoteItemRandomZM:setAlpha(1)
	f45_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(0, 0, 37, 143)
	f45_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(0)
end
CoD.MapVoteZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(4)
			f46_arg0.MapVoteItemRandomZM:completeAnimation()
			f46_arg0.MapVoteItemRandomZM:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.MapVoteItemRandomZM)
			f46_arg0.MapVoteItemPreviousZM:completeAnimation()
			f46_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.MapVoteItemPreviousZM)
			f46_arg0.MapVoteItemNextZM:completeAnimation()
			f46_arg0.MapVoteItemNextZM:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.MapVoteItemNextZM)
			f46_arg0.LobbyStatus:completeAnimation()
			f46_arg0.LobbyStatus:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.LobbyStatus)
		end,
		MapVote = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			local f47_local0 = function(f48_arg0)
				f47_arg0.MapVoteItemRandomZM:beginAnimation(250)
				f47_arg0.MapVoteItemRandomZM:setAlpha(1)
				f47_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MapVoteItemRandomZM:completeAnimation()
			f47_arg0.MapVoteItemRandomZM:setAlpha(0)
			f47_local0(f47_arg0.MapVoteItemRandomZM)
			local f47_local1 = function(f49_arg0)
				f47_arg0.MapVoteItemPreviousZM:beginAnimation(250)
				f47_arg0.MapVoteItemPreviousZM:setAlpha(1)
				f47_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MapVoteItemPreviousZM:completeAnimation()
			f47_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f47_local1(f47_arg0.MapVoteItemPreviousZM)
			local f47_local2 = function(f50_arg0)
				f47_arg0.MapVoteItemNextZM:beginAnimation(250)
				f47_arg0.MapVoteItemNextZM:setAlpha(1)
				f47_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MapVoteItemNextZM:completeAnimation()
			f47_arg0.MapVoteItemNextZM:setAlpha(0)
			f47_local2(f47_arg0.MapVoteItemNextZM)
			local f47_local3 = function(f51_arg0)
				f47_arg0.LobbyStatus:beginAnimation(250)
				f47_arg0.LobbyStatus:setAlpha(1)
				f47_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.LobbyStatus:completeAnimation()
			f47_arg0.LobbyStatus:setAlpha(0)
			f47_local3(f47_arg0.LobbyStatus)
		end,
		MapSelected = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(4)
			local f52_local0 = function(f53_arg0)
				f52_arg0.MapVoteItemRandomZM:beginAnimation(400)
				f52_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.MapVoteItemRandomZM:completeAnimation()
			f52_arg0.MapVoteItemRandomZM:setAlpha(0)
			f52_local0(f52_arg0.MapVoteItemRandomZM)
			local f52_local1 = function(f54_arg0)
				f52_arg0.MapVoteItemPreviousZM:beginAnimation(400)
				f52_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.MapVoteItemPreviousZM:completeAnimation()
			f52_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f52_local1(f52_arg0.MapVoteItemPreviousZM)
			local f52_local2 = function(f55_arg0)
				f52_arg0.MapVoteItemNextZM:beginAnimation(400)
				f52_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.MapVoteItemNextZM:completeAnimation()
			f52_arg0.MapVoteItemNextZM:setAlpha(0)
			f52_local2(f52_arg0.MapVoteItemNextZM)
			local f52_local3 = function(f56_arg0)
				f52_arg0.LobbyStatus:beginAnimation(400)
				f52_arg0.LobbyStatus:setAlpha(1)
				f52_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.LobbyStatus:completeAnimation()
			f52_arg0.LobbyStatus:setAlpha(0)
			f52_local3(f52_arg0.LobbyStatus)
		end,
		MapVoteChosenNext = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(4)
			local f57_local0 = function(f58_arg0)
				f57_arg0.MapVoteItemRandomZM:beginAnimation(400)
				f57_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.MapVoteItemRandomZM:completeAnimation()
			f57_arg0.MapVoteItemRandomZM:setAlpha(0)
			f57_local0(f57_arg0.MapVoteItemRandomZM)
			local f57_local1 = function(f59_arg0)
				f57_arg0.MapVoteItemPreviousZM:beginAnimation(400)
				f57_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.MapVoteItemPreviousZM:completeAnimation()
			f57_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f57_local1(f57_arg0.MapVoteItemPreviousZM)
			local f57_local2 = function(f60_arg0)
				f57_arg0.MapVoteItemNextZM:beginAnimation(400)
				f57_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.MapVoteItemNextZM:completeAnimation()
			f57_arg0.MapVoteItemNextZM:setAlpha(0)
			f57_local2(f57_arg0.MapVoteItemNextZM)
			local f57_local3 = function(f61_arg0)
				f57_arg0.LobbyStatus:beginAnimation(400)
				f57_arg0.LobbyStatus:setAlpha(1)
				f57_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.LobbyStatus:completeAnimation()
			f57_arg0.LobbyStatus:setAlpha(0)
			f57_local3(f57_arg0.LobbyStatus)
		end,
		MapVoteChosenPrevious = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(4)
			local f62_local0 = function(f63_arg0)
				f62_arg0.MapVoteItemRandomZM:beginAnimation(400)
				f62_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MapVoteItemRandomZM:completeAnimation()
			f62_arg0.MapVoteItemRandomZM:setAlpha(0)
			f62_local0(f62_arg0.MapVoteItemRandomZM)
			local f62_local1 = function(f64_arg0)
				f62_arg0.MapVoteItemPreviousZM:beginAnimation(400)
				f62_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MapVoteItemPreviousZM:completeAnimation()
			f62_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f62_local1(f62_arg0.MapVoteItemPreviousZM)
			local f62_local2 = function(f65_arg0)
				f62_arg0.MapVoteItemNextZM:beginAnimation(400)
				f62_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MapVoteItemNextZM:completeAnimation()
			f62_arg0.MapVoteItemNextZM:setAlpha(0)
			f62_local2(f62_arg0.MapVoteItemNextZM)
			local f62_local3 = function(f66_arg0)
				f62_arg0.LobbyStatus:beginAnimation(400)
				f62_arg0.LobbyStatus:setAlpha(1)
				f62_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.LobbyStatus:completeAnimation()
			f62_arg0.LobbyStatus:setAlpha(0)
			f62_local3(f62_arg0.LobbyStatus)
		end,
		MapVoteChosenRandom = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(4)
			local f67_local0 = function(f68_arg0)
				f67_arg0.MapVoteItemRandomZM:beginAnimation(400)
				f67_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.MapVoteItemRandomZM:completeAnimation()
			f67_arg0.MapVoteItemRandomZM:setAlpha(0)
			f67_local0(f67_arg0.MapVoteItemRandomZM)
			local f67_local1 = function(f69_arg0)
				f67_arg0.MapVoteItemPreviousZM:beginAnimation(400)
				f67_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.MapVoteItemPreviousZM:completeAnimation()
			f67_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f67_local1(f67_arg0.MapVoteItemPreviousZM)
			local f67_local2 = function(f70_arg0)
				f67_arg0.MapVoteItemNextZM:beginAnimation(400)
				f67_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.MapVoteItemNextZM:completeAnimation()
			f67_arg0.MapVoteItemNextZM:setAlpha(0)
			f67_local2(f67_arg0.MapVoteItemNextZM)
			local f67_local3 = function(f71_arg0)
				f67_arg0.LobbyStatus:beginAnimation(400)
				f67_arg0.LobbyStatus:setAlpha(1)
				f67_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.LobbyStatus:completeAnimation()
			f67_arg0.LobbyStatus:setAlpha(0)
			f67_local3(f67_arg0.LobbyStatus)
		end,
	},
	MapVote = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(3)
			f72_arg0.MapVoteItemRandomZM:completeAnimation()
			f72_arg0.MapVoteItemRandomZM:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.MapVoteItemRandomZM)
			f72_arg0.MapVoteItemPreviousZM:completeAnimation()
			f72_arg0.MapVoteItemPreviousZM:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.MapVoteItemPreviousZM)
			f72_arg0.MapVoteItemNextZM:completeAnimation()
			f72_arg0.MapVoteItemNextZM:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.MapVoteItemNextZM)
		end,
		MapVoteChosenNext = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(4)
			f73_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f73_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.DirectorMapGameTypeAndDifficulty)
			local f73_local0 = function(f74_arg0)
				f73_arg0.MapVoteItemRandomZM:beginAnimation(400)
				f73_arg0.MapVoteItemRandomZM:setAlpha(0)
				f73_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.MapVoteItemRandomZM:completeAnimation()
			f73_arg0.MapVoteItemRandomZM:setAlpha(1)
			f73_local0(f73_arg0.MapVoteItemRandomZM)
			local f73_local1 = function(f75_arg0)
				f73_arg0.MapVoteItemPreviousZM:beginAnimation(400)
				f73_arg0.MapVoteItemPreviousZM:setAlpha(0)
				f73_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.MapVoteItemPreviousZM:completeAnimation()
			f73_arg0.MapVoteItemPreviousZM:setAlpha(1)
			f73_local1(f73_arg0.MapVoteItemPreviousZM)
			local f73_local2 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					f77_arg0:beginAnimation(200)
					f77_arg0:setAlpha(0)
					f77_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.MapVoteItemNextZM:beginAnimation(200)
				f73_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f73_arg0.MapVoteItemNextZM:completeAnimation()
			f73_arg0.MapVoteItemNextZM:setAlpha(1)
			f73_local2(f73_arg0.MapVoteItemNextZM)
		end,
		MapVoteChosenPrevious = function(f78_arg0, f78_arg1)
			f78_arg0:__resetProperties()
			f78_arg0:setupElementClipCounter(4)
			local f78_local0 = function(f79_arg0)
				local f79_local0 = function(f80_arg0)
					f80_arg0:beginAnimation(99)
					f80_arg0:setAlpha(1)
					f80_arg0:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
				end
				f78_arg0.DirectorMapGameTypeAndDifficulty:beginAnimation(400)
				f78_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("transition_complete_keyframe", f79_local0)
			end
			f78_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f78_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(0)
			f78_local0(f78_arg0.DirectorMapGameTypeAndDifficulty)
			local f78_local1 = function(f81_arg0)
				f78_arg0.MapVoteItemRandomZM:beginAnimation(200)
				f78_arg0.MapVoteItemRandomZM:setAlpha(0)
				f78_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
			end
			f78_arg0.MapVoteItemRandomZM:completeAnimation()
			f78_arg0.MapVoteItemRandomZM:setAlpha(1)
			f78_local1(f78_arg0.MapVoteItemRandomZM)
			local f78_local2 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					local f83_local0 = function(f84_arg0)
						f84_arg0:beginAnimation(99)
						f84_arg0:setAlpha(0)
						f84_arg0:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
					end
					f83_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f83_arg0:setTopBottom(0, 0, 37, 143)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
				end
				f78_arg0.MapVoteItemPreviousZM:beginAnimation(200)
				f78_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f78_arg0.MapVoteItemPreviousZM:completeAnimation()
			f78_arg0.MapVoteItemPreviousZM:setTopBottom(0, 0, 143, 249)
			f78_arg0.MapVoteItemPreviousZM:setAlpha(1)
			f78_local2(f78_arg0.MapVoteItemPreviousZM)
			local f78_local3 = function(f85_arg0)
				f78_arg0.MapVoteItemNextZM:beginAnimation(200)
				f78_arg0.MapVoteItemNextZM:setAlpha(0)
				f78_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
			end
			f78_arg0.MapVoteItemNextZM:completeAnimation()
			f78_arg0.MapVoteItemNextZM:setAlpha(1)
			f78_local3(f78_arg0.MapVoteItemNextZM)
		end,
		MapVoteChosenRandom = function(f86_arg0, f86_arg1)
			f86_arg0:__resetProperties()
			f86_arg0:setupElementClipCounter(4)
			local f86_local0 = function(f87_arg0)
				local f87_local0 = function(f88_arg0)
					f88_arg0:beginAnimation(99)
					f88_arg0:setAlpha(1)
					f88_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
				end
				f86_arg0.DirectorMapGameTypeAndDifficulty:beginAnimation(400)
				f86_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f86_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f86_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(0)
			f86_local0(f86_arg0.DirectorMapGameTypeAndDifficulty)
			local f86_local1 = function(f89_arg0)
				local f89_local0 = function(f90_arg0)
					local f90_local0 = function(f91_arg0)
						f91_arg0:beginAnimation(99)
						f91_arg0:setAlpha(0)
						f91_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
					end
					f90_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f90_arg0:setTopBottom(0, 0, 37, 143)
					f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
				end
				f86_arg0.MapVoteItemRandomZM:beginAnimation(200)
				f86_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f89_local0)
			end
			f86_arg0.MapVoteItemRandomZM:completeAnimation()
			f86_arg0.MapVoteItemRandomZM:setTopBottom(0, 0, 249, 355)
			f86_arg0.MapVoteItemRandomZM:setAlpha(1)
			f86_local1(f86_arg0.MapVoteItemRandomZM)
			local f86_local2 = function(f92_arg0)
				f86_arg0.MapVoteItemPreviousZM:beginAnimation(200)
				f86_arg0.MapVoteItemPreviousZM:setAlpha(0)
				f86_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.MapVoteItemPreviousZM:completeAnimation()
			f86_arg0.MapVoteItemPreviousZM:setAlpha(1)
			f86_local2(f86_arg0.MapVoteItemPreviousZM)
			local f86_local3 = function(f93_arg0)
				f86_arg0.MapVoteItemNextZM:beginAnimation(200)
				f86_arg0.MapVoteItemNextZM:setAlpha(0)
				f86_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.MapVoteItemNextZM:completeAnimation()
			f86_arg0.MapVoteItemNextZM:setAlpha(1)
			f86_local3(f86_arg0.MapVoteItemNextZM)
		end,
		DefaultState = function(f94_arg0, f94_arg1)
			f94_arg0:__resetProperties()
			f94_arg0:setupElementClipCounter(4)
			local f94_local0 = function(f95_arg0)
				f94_arg0.MapVoteItemRandomZM:beginAnimation(400)
				f94_arg0.MapVoteItemRandomZM:setAlpha(0)
				f94_arg0.MapVoteItemRandomZM:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.MapVoteItemRandomZM:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.MapVoteItemRandomZM:completeAnimation()
			f94_arg0.MapVoteItemRandomZM:setAlpha(1)
			f94_local0(f94_arg0.MapVoteItemRandomZM)
			local f94_local1 = function(f96_arg0)
				f94_arg0.MapVoteItemPreviousZM:beginAnimation(400)
				f94_arg0.MapVoteItemPreviousZM:setAlpha(0)
				f94_arg0.MapVoteItemPreviousZM:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.MapVoteItemPreviousZM:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.MapVoteItemPreviousZM:completeAnimation()
			f94_arg0.MapVoteItemPreviousZM:setAlpha(1)
			f94_local1(f94_arg0.MapVoteItemPreviousZM)
			local f94_local2 = function(f97_arg0)
				f94_arg0.MapVoteItemNextZM:beginAnimation(400)
				f94_arg0.MapVoteItemNextZM:setAlpha(0)
				f94_arg0.MapVoteItemNextZM:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.MapVoteItemNextZM:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.MapVoteItemNextZM:completeAnimation()
			f94_arg0.MapVoteItemNextZM:setAlpha(1)
			f94_local2(f94_arg0.MapVoteItemNextZM)
			local f94_local3 = function(f98_arg0)
				f94_arg0.LobbyStatus:beginAnimation(400)
				f94_arg0.LobbyStatus:setAlpha(0)
				f94_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.LobbyStatus:completeAnimation()
			f94_arg0.LobbyStatus:setAlpha(1)
			f94_local3(f94_arg0.LobbyStatus)
		end,
	},
	MapVoteChosenNext = {
		DefaultClip = function(f99_arg0, f99_arg1)
			f99_arg0:__resetProperties()
			f99_arg0:setupElementClipCounter(4)
			f99_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f99_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.DirectorMapGameTypeAndDifficulty)
			f99_arg0.MapVoteItemRandomZM:completeAnimation()
			f99_arg0.MapVoteItemRandomZM:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemRandomZM)
			f99_arg0.MapVoteItemPreviousZM:completeAnimation()
			f99_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemPreviousZM)
			f99_arg0.MapVoteItemNextZM:completeAnimation()
			f99_arg0.MapVoteItemNextZM:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemNextZM)
		end,
	},
	MapVoteChosenPrevious = {
		DefaultClip = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(4)
			f100_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f100_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.DirectorMapGameTypeAndDifficulty)
			f100_arg0.MapVoteItemRandomZM:completeAnimation()
			f100_arg0.MapVoteItemRandomZM:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemRandomZM)
			f100_arg0.MapVoteItemPreviousZM:completeAnimation()
			f100_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemPreviousZM)
			f100_arg0.MapVoteItemNextZM:completeAnimation()
			f100_arg0.MapVoteItemNextZM:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemNextZM)
		end,
	},
	MapVoteChosenRandom = {
		DefaultClip = function(f101_arg0, f101_arg1)
			f101_arg0:__resetProperties()
			f101_arg0:setupElementClipCounter(4)
			f101_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f101_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f101_arg0.clipFinished(f101_arg0.DirectorMapGameTypeAndDifficulty)
			f101_arg0.MapVoteItemRandomZM:completeAnimation()
			f101_arg0.MapVoteItemRandomZM:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemRandomZM)
			f101_arg0.MapVoteItemPreviousZM:completeAnimation()
			f101_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemPreviousZM)
			f101_arg0.MapVoteItemNextZM:completeAnimation()
			f101_arg0.MapVoteItemNextZM:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemNextZM)
		end,
	},
	SelectedMap = {
		DefaultClip = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(5)
			local f102_local0 = function(f103_arg0)
				f102_arg0.DirectorMapGameTypeAndDifficulty:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
				f102_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(0, 0, 175, 355)
				f102_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
				f102_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
			end
			f102_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f102_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(0, 0, 37, 143)
			f102_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f102_local0(f102_arg0.DirectorMapGameTypeAndDifficulty)
			f102_arg0.MapVoteItemRandomZM:completeAnimation()
			f102_arg0.MapVoteItemRandomZM:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.MapVoteItemRandomZM)
			f102_arg0.MapVoteItemPreviousZM:completeAnimation()
			f102_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.MapVoteItemPreviousZM)
			f102_arg0.MapVoteItemNextZM:completeAnimation()
			f102_arg0.MapVoteItemNextZM:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.MapVoteItemNextZM)
			local f102_local1 = function(f104_arg0)
				f102_arg0.LobbyStatus:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
				f102_arg0.LobbyStatus:setTopBottom(0, 0, 150, 170)
				f102_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
				f102_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
			end
			f102_arg0.LobbyStatus:completeAnimation()
			f102_arg0.LobbyStatus:setTopBottom(0, 0, 12, 32)
			f102_local1(f102_arg0.LobbyStatus)
		end,
		DefaultState = function(f105_arg0, f105_arg1)
			f105_arg0:__resetProperties()
			f105_arg0:setupElementClipCounter(5)
			local f105_local0 = function(f106_arg0)
				f105_arg0.DirectorMapGameTypeAndDifficulty:beginAnimation(400)
				f105_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(0)
				f105_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("interrupted_keyframe", f105_arg0.clipInterrupted)
				f105_arg0.DirectorMapGameTypeAndDifficulty:registerEventHandler("transition_complete_keyframe", f105_arg0.clipFinished)
			end
			f105_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f105_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(0, 0, 175, 355)
			f105_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f105_local0(f105_arg0.DirectorMapGameTypeAndDifficulty)
			f105_arg0.MapVoteItemRandomZM:completeAnimation()
			f105_arg0.MapVoteItemRandomZM:setAlpha(0)
			f105_arg0.clipFinished(f105_arg0.MapVoteItemRandomZM)
			f105_arg0.MapVoteItemPreviousZM:completeAnimation()
			f105_arg0.MapVoteItemPreviousZM:setAlpha(0)
			f105_arg0.clipFinished(f105_arg0.MapVoteItemPreviousZM)
			f105_arg0.MapVoteItemNextZM:completeAnimation()
			f105_arg0.MapVoteItemNextZM:setAlpha(0)
			f105_arg0.clipFinished(f105_arg0.MapVoteItemNextZM)
			local f105_local1 = function(f107_arg0)
				f105_arg0.LobbyStatus:beginAnimation(400)
				f105_arg0.LobbyStatus:setAlpha(0)
				f105_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f105_arg0.clipInterrupted)
				f105_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f105_arg0.clipFinished)
			end
			f105_arg0.LobbyStatus:completeAnimation()
			f105_arg0.LobbyStatus:setTopBottom(0, 0, 150, 170)
			f105_arg0.LobbyStatus:setAlpha(1)
			f105_local1(f105_arg0.LobbyStatus)
		end,
	},
}
CoD.MapVoteZM.__onClose = function(f108_arg0)
	f108_arg0.DirectorMapGameTypeAndDifficulty:close()
	f108_arg0.MapVoteItemRandomZM:close()
	f108_arg0.MapVoteItemPreviousZM:close()
	f108_arg0.MapVoteItemNextZM:close()
	f108_arg0.LobbyStatus:close()
end
