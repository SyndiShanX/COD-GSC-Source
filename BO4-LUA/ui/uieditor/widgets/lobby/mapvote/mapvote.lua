require("x64:affae0b14c3bb5d")
CoD.MapVote = InheritFrom(LUI.UIElement)
CoD.MapVote.__defaultWidth = 911
CoD.MapVote.__defaultHeight = 215
CoD.MapVote.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MapVote)
	self.id = "MapVote"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapVoteItemVoteDecided = CoD.MapVoteItem.new(f1_arg0, f1_arg1, 0, 0, 0, 263, 0, 0, 37, 217)
	MapVoteItemVoteDecided:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	MapVoteItemVoteDecided:setAlpha(0)
	MapVoteItemVoteDecided.VoteType:setAlpha(0)
	MapVoteItemVoteDecided.VoteType:setText("")
	MapVoteItemVoteDecided.voteCount:setText("")
	MapVoteItemVoteDecided:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MapVoteItemVoteDecided.MapImage:setImage(RegisterImage(MapNameToMapLoadingImage(f1_arg1, f3_local0)))
		end
	end)
	MapVoteItemVoteDecided:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MapVoteItemVoteDecided.MapVoteMapNameGameModeLayout.MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperName(f4_local0))
		end
	end)
	MapVoteItemVoteDecided:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MapVoteItemVoteDecided.MapVoteMapNameGameModeLayout.GameMode:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f5_local0))
		end
	end)
	MapVoteItemVoteDecided:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MapVoteItemVoteDecided.GameModeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f6_local0)))
		end
	end)
	self:addElement(MapVoteItemVoteDecided)
	self.MapVoteItemVoteDecided = MapVoteItemVoteDecided
	local MapVoteItemRandom = CoD.MapVoteItem.new(f1_arg0, f1_arg1, 0, 0, 538, 801, 0, 0, 37, 217)
	MapVoteItemRandom.MapImage:setImage(RegisterImage(@"uie_lui_random_map_vote"))
	MapVoteItemRandom.MapVoteMapNameGameModeLayout.MapName:setText(LocalizeToUpperString(@"menu/classified"))
	MapVoteItemRandom.MapVoteMapNameGameModeLayout.GameMode:setText(LocalizeToUpperString(@"menu/mode_classified"))
	MapVoteItemRandom.GameModeIcon:setImage(RegisterImage(@"blacktransparent"))
	MapVoteItemRandom.VoteType:setText(LocalizeToUpperString(@"menu/random"))
	MapVoteItemRandom:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteCountRandom", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MapVoteItemRandom.voteCount:setText(f7_local0)
		end
	end)
	MapVoteItemRandom:registerEventHandler("lobby_map_vote_random_chosen", function(element, event)
		local f8_local0 = nil
		PlayClip(self, "MapVoteChosenRandom", f1_arg1)
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	MapVoteItemRandom:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapVoteItemRandom, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.LobbyMapVoteSelectRandom(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(MapVoteItemRandom)
	self.MapVoteItemRandom = MapVoteItemRandom
	local MapVoteItemPrevious = CoD.MapVoteItem.new(f1_arg0, f1_arg1, 0, 0, 269, 532, 0, 0, 37, 217)
	MapVoteItemPrevious:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return not CoD.LobbyUtility.MapVotePreviousSelectable()
			end,
		},
	})
	local LobbyStatus = MapVoteItemPrevious
	local MapVoteItemNext = MapVoteItemPrevious.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	MapVoteItemNext(LobbyStatus, f1_local6["lobbyRoot.mapVote"], function(f13_arg0)
		f1_arg0:updateElementState(MapVoteItemPrevious, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.mapVote",
		})
	end, false)
	LobbyStatus = MapVoteItemPrevious
	MapVoteItemNext = MapVoteItemPrevious.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	MapVoteItemNext(LobbyStatus, f1_local6["lobbyRoot.lobbyNav"], function(f14_arg0)
		f1_arg0:updateElementState(MapVoteItemPrevious, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	MapVoteItemPrevious.VoteType:setText(LocalizeToUpperString(@"menu/prev"))
	MapVoteItemPrevious:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapPrevious", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			MapVoteItemPrevious.MapImage:setImage(RegisterImage(CoD.MapUtility.MapNameToMapImage(f15_local0)))
		end
	end)
	MapVoteItemPrevious:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapPrevious", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			MapVoteItemPrevious.MapVoteMapNameGameModeLayout.MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperNameShort(f16_local0))
		end
	end)
	MapVoteItemPrevious:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModePrevious", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			MapVoteItemPrevious.MapVoteMapNameGameModeLayout.GameMode:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f17_local0))
		end
	end)
	MapVoteItemPrevious:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModePrevious", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			MapVoteItemPrevious.GameModeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f18_local0)))
		end
	end)
	MapVoteItemPrevious:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteCountPrevious", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			MapVoteItemPrevious.voteCount:setText(f19_local0)
		end
	end)
	LobbyStatus = MapVoteItemPrevious
	MapVoteItemNext = MapVoteItemPrevious.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	MapVoteItemNext(LobbyStatus, f1_local6["lobbyRoot.mapVote"], function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LobbyStatus = MapVoteItemPrevious
	MapVoteItemNext = MapVoteItemPrevious.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	MapVoteItemNext(LobbyStatus, f1_local6["lobbyRoot.lobbyNav"], function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	MapVoteItemPrevious:registerEventHandler("lobby_map_vote_previous_chosen", function(element, event)
		local f22_local0 = nil
		PlayClip(self, "MapVoteChosenPrevious", f1_arg1)
		if not f22_local0 then
			f22_local0 = element:dispatchEventToChildren(event)
		end
		return f22_local0
	end)
	MapVoteItemPrevious:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f23_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapVoteItemPrevious, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.LobbyUtility.MapVotePreviousSelectable() then
			CoD.LobbyUtility.LobbyMapVoteSelectPrevious(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.LobbyUtility.MapVotePreviousSelectable() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(MapVoteItemPrevious)
	self.MapVoteItemPrevious = MapVoteItemPrevious
	MapVoteItemNext = CoD.MapVoteItem.new(f1_arg0, f1_arg1, 0, 0, 0, 263, 0, 0, 37, 217)
	MapVoteItemNext.VoteType:setText(LocalizeToUpperString(@"menu/next"))
	MapVoteItemNext:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			MapVoteItemNext.MapImage:setImage(RegisterImage(CoD.MapUtility.MapNameToMapImage(f26_local0)))
		end
	end)
	MapVoteItemNext:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			MapVoteItemNext.MapVoteMapNameGameModeLayout.MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperNameShort(f27_local0))
		end
	end)
	MapVoteItemNext:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			MapVoteItemNext.MapVoteMapNameGameModeLayout.GameMode:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f28_local0))
		end
	end)
	MapVoteItemNext:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			MapVoteItemNext.GameModeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f29_local0)))
		end
	end)
	MapVoteItemNext:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteCountNext", function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			MapVoteItemNext.voteCount:setText(f30_local0)
		end
	end)
	MapVoteItemNext:registerEventHandler("lobby_map_vote_next_chosen", function(element, event)
		local f31_local0 = nil
		PlayClip(self, "MapVoteChosenNext", f1_arg1)
		if not f31_local0 then
			f31_local0 = element:dispatchEventToChildren(event)
		end
		return f31_local0
	end)
	MapVoteItemNext:registerEventHandler("gain_focus", function(element, event)
		local f32_local0 = nil
		if element.gainFocus then
			f32_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f32_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f32_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapVoteItemNext, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.LobbyMapVoteSelectNext(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(MapVoteItemNext)
	self.MapVoteItemNext = MapVoteItemNext
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
	local f1_local7 = self
	f1_local6 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
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
	MapVoteItemVoteDecided.id = "MapVoteItemVoteDecided"
	MapVoteItemRandom.id = "MapVoteItemRandom"
	MapVoteItemPrevious.id = "MapVoteItemPrevious"
	MapVoteItemNext.id = "MapVoteItemNext"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MapVote.__resetProperties = function(f45_arg0)
	f45_arg0.MapVoteItemRandom:completeAnimation()
	f45_arg0.MapVoteItemPrevious:completeAnimation()
	f45_arg0.MapVoteItemNext:completeAnimation()
	f45_arg0.LobbyStatus:completeAnimation()
	f45_arg0.MapVoteItemVoteDecided:completeAnimation()
	f45_arg0.MapVoteItemRandom:setLeftRight(0, 0, 538, 801)
	f45_arg0.MapVoteItemRandom:setAlpha(1)
	f45_arg0.MapVoteItemPrevious:setLeftRight(0, 0, 269, 532)
	f45_arg0.MapVoteItemPrevious:setAlpha(1)
	f45_arg0.MapVoteItemNext:setAlpha(1)
	f45_arg0.MapVoteItemNext.VoteType:setAlpha(0.95)
	f45_arg0.LobbyStatus:setAlpha(1)
	f45_arg0.MapVoteItemVoteDecided:setLeftRight(0, 0, 0, 263)
	f45_arg0.MapVoteItemVoteDecided:setAlpha(0)
	f45_arg0.MapVoteItemVoteDecided.MapImage:setShaderVector(0, 0, 0, 0, 0)
	f45_arg0.MapVoteItemVoteDecided.MapImage:setShaderVector(1, 1, 1, 0, 0)
	f45_arg0.MapVoteItemVoteDecided.GameModeIcon:setAlpha(0)
	f45_arg0.MapVoteItemVoteDecided.CommonButtonOutlineThin:setAlpha(1)
end
CoD.MapVote.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(4)
			f46_arg0.MapVoteItemRandom:completeAnimation()
			f46_arg0.MapVoteItemRandom:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.MapVoteItemRandom)
			f46_arg0.MapVoteItemPrevious:completeAnimation()
			f46_arg0.MapVoteItemPrevious:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.MapVoteItemPrevious)
			f46_arg0.MapVoteItemNext:completeAnimation()
			f46_arg0.MapVoteItemNext:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.MapVoteItemNext)
			f46_arg0.LobbyStatus:completeAnimation()
			f46_arg0.LobbyStatus:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.LobbyStatus)
		end,
		MapVote = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			local f47_local0 = function(f48_arg0)
				f47_arg0.MapVoteItemRandom:beginAnimation(250)
				f47_arg0.MapVoteItemRandom:setAlpha(1)
				f47_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MapVoteItemRandom:completeAnimation()
			f47_arg0.MapVoteItemRandom:setAlpha(0)
			f47_local0(f47_arg0.MapVoteItemRandom)
			local f47_local1 = function(f49_arg0)
				f47_arg0.MapVoteItemPrevious:beginAnimation(250)
				f47_arg0.MapVoteItemPrevious:setAlpha(1)
				f47_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MapVoteItemPrevious:completeAnimation()
			f47_arg0.MapVoteItemPrevious:setAlpha(0)
			f47_local1(f47_arg0.MapVoteItemPrevious)
			local f47_local2 = function(f50_arg0)
				f47_arg0.MapVoteItemNext:beginAnimation(250)
				f47_arg0.MapVoteItemNext:setAlpha(1)
				f47_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.MapVoteItemNext:completeAnimation()
			f47_arg0.MapVoteItemNext:setAlpha(0)
			f47_local2(f47_arg0.MapVoteItemNext)
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
			f52_arg0:setupElementClipCounter(5)
			f52_arg0.MapVoteItemVoteDecided:completeAnimation()
			f52_arg0.MapVoteItemVoteDecided:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.MapVoteItemVoteDecided)
			local f52_local0 = function(f53_arg0)
				f52_arg0.MapVoteItemRandom:beginAnimation(400)
				f52_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.MapVoteItemRandom:completeAnimation()
			f52_arg0.MapVoteItemRandom:setAlpha(0)
			f52_local0(f52_arg0.MapVoteItemRandom)
			local f52_local1 = function(f54_arg0)
				f52_arg0.MapVoteItemPrevious:beginAnimation(400)
				f52_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.MapVoteItemPrevious:completeAnimation()
			f52_arg0.MapVoteItemPrevious:setAlpha(0)
			f52_local1(f52_arg0.MapVoteItemPrevious)
			local f52_local2 = function(f55_arg0)
				f52_arg0.MapVoteItemNext:beginAnimation(400)
				f52_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.MapVoteItemNext:completeAnimation()
			f52_arg0.MapVoteItemNext:setAlpha(0)
			f52_local2(f52_arg0.MapVoteItemNext)
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
			f57_arg0:setupElementClipCounter(5)
			f57_arg0.MapVoteItemVoteDecided:completeAnimation()
			f57_arg0.MapVoteItemVoteDecided:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.MapVoteItemVoteDecided)
			local f57_local0 = function(f58_arg0)
				f57_arg0.MapVoteItemRandom:beginAnimation(400)
				f57_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.MapVoteItemRandom:completeAnimation()
			f57_arg0.MapVoteItemRandom:setAlpha(0)
			f57_local0(f57_arg0.MapVoteItemRandom)
			local f57_local1 = function(f59_arg0)
				f57_arg0.MapVoteItemPrevious:beginAnimation(400)
				f57_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.MapVoteItemPrevious:completeAnimation()
			f57_arg0.MapVoteItemPrevious:setAlpha(0)
			f57_local1(f57_arg0.MapVoteItemPrevious)
			local f57_local2 = function(f60_arg0)
				f57_arg0.MapVoteItemNext:beginAnimation(400)
				f57_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.MapVoteItemNext:completeAnimation()
			f57_arg0.MapVoteItemNext:setAlpha(0)
			f57_local2(f57_arg0.MapVoteItemNext)
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
			f62_arg0:setupElementClipCounter(5)
			f62_arg0.MapVoteItemVoteDecided:completeAnimation()
			f62_arg0.MapVoteItemVoteDecided:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.MapVoteItemVoteDecided)
			local f62_local0 = function(f63_arg0)
				f62_arg0.MapVoteItemRandom:beginAnimation(400)
				f62_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MapVoteItemRandom:completeAnimation()
			f62_arg0.MapVoteItemRandom:setAlpha(0)
			f62_local0(f62_arg0.MapVoteItemRandom)
			local f62_local1 = function(f64_arg0)
				f62_arg0.MapVoteItemPrevious:beginAnimation(400)
				f62_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MapVoteItemPrevious:completeAnimation()
			f62_arg0.MapVoteItemPrevious:setAlpha(0)
			f62_local1(f62_arg0.MapVoteItemPrevious)
			local f62_local2 = function(f65_arg0)
				f62_arg0.MapVoteItemNext:beginAnimation(400)
				f62_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MapVoteItemNext:completeAnimation()
			f62_arg0.MapVoteItemNext:setAlpha(0)
			f62_local2(f62_arg0.MapVoteItemNext)
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
			f67_arg0:setupElementClipCounter(5)
			f67_arg0.MapVoteItemVoteDecided:completeAnimation()
			f67_arg0.MapVoteItemVoteDecided:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.MapVoteItemVoteDecided)
			local f67_local0 = function(f68_arg0)
				f67_arg0.MapVoteItemRandom:beginAnimation(400)
				f67_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.MapVoteItemRandom:completeAnimation()
			f67_arg0.MapVoteItemRandom:setAlpha(0)
			f67_local0(f67_arg0.MapVoteItemRandom)
			local f67_local1 = function(f69_arg0)
				f67_arg0.MapVoteItemPrevious:beginAnimation(400)
				f67_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.MapVoteItemPrevious:completeAnimation()
			f67_arg0.MapVoteItemPrevious:setAlpha(0)
			f67_local1(f67_arg0.MapVoteItemPrevious)
			local f67_local2 = function(f70_arg0)
				f67_arg0.MapVoteItemNext:beginAnimation(400)
				f67_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.MapVoteItemNext:completeAnimation()
			f67_arg0.MapVoteItemNext:setAlpha(0)
			f67_local2(f67_arg0.MapVoteItemNext)
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
			f72_arg0.MapVoteItemRandom:completeAnimation()
			f72_arg0.MapVoteItemRandom:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.MapVoteItemRandom)
			f72_arg0.MapVoteItemPrevious:completeAnimation()
			f72_arg0.MapVoteItemPrevious:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.MapVoteItemPrevious)
			f72_arg0.MapVoteItemNext:completeAnimation()
			f72_arg0.MapVoteItemNext:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.MapVoteItemNext)
		end,
		MapVoteChosenNext = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(4)
			f73_arg0.MapVoteItemVoteDecided:completeAnimation()
			f73_arg0.MapVoteItemVoteDecided:setAlpha(1)
			f73_arg0.clipFinished(f73_arg0.MapVoteItemVoteDecided)
			local f73_local0 = function(f74_arg0)
				f73_arg0.MapVoteItemRandom:beginAnimation(400)
				f73_arg0.MapVoteItemRandom:setAlpha(0)
				f73_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.MapVoteItemRandom:completeAnimation()
			f73_arg0.MapVoteItemRandom:setAlpha(1)
			f73_local0(f73_arg0.MapVoteItemRandom)
			local f73_local1 = function(f75_arg0)
				f73_arg0.MapVoteItemPrevious:beginAnimation(400)
				f73_arg0.MapVoteItemPrevious:setAlpha(0)
				f73_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.MapVoteItemPrevious:completeAnimation()
			f73_arg0.MapVoteItemPrevious:setAlpha(1)
			f73_local1(f73_arg0.MapVoteItemPrevious)
			local f73_local2 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					f77_arg0:beginAnimation(200)
					f77_arg0:setAlpha(0)
					f77_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.MapVoteItemNext:beginAnimation(200)
				f73_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f73_arg0.MapVoteItemNext:completeAnimation()
			f73_arg0.MapVoteItemNext:setAlpha(1)
			f73_local2(f73_arg0.MapVoteItemNext)
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
				f78_arg0.MapVoteItemVoteDecided:beginAnimation(400)
				f78_arg0.MapVoteItemVoteDecided:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemVoteDecided:registerEventHandler("transition_complete_keyframe", f79_local0)
			end
			f78_arg0.MapVoteItemVoteDecided:completeAnimation()
			f78_arg0.MapVoteItemVoteDecided:setAlpha(0)
			f78_local0(f78_arg0.MapVoteItemVoteDecided)
			local f78_local1 = function(f81_arg0)
				f78_arg0.MapVoteItemRandom:beginAnimation(200)
				f78_arg0.MapVoteItemRandom:setAlpha(0)
				f78_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
			end
			f78_arg0.MapVoteItemRandom:completeAnimation()
			f78_arg0.MapVoteItemRandom:setAlpha(1)
			f78_local1(f78_arg0.MapVoteItemRandom)
			local f78_local2 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					local f83_local0 = function(f84_arg0)
						f84_arg0:beginAnimation(99)
						f84_arg0:setAlpha(0)
						f84_arg0:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
					end
					f83_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f83_arg0:setLeftRight(0, 0, 0, 263)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
				end
				f78_arg0.MapVoteItemPrevious:beginAnimation(200)
				f78_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f78_arg0.MapVoteItemPrevious:completeAnimation()
			f78_arg0.MapVoteItemPrevious:setLeftRight(0, 0, 271, 534)
			f78_arg0.MapVoteItemPrevious:setAlpha(1)
			f78_local2(f78_arg0.MapVoteItemPrevious)
			local f78_local3 = function(f85_arg0)
				f78_arg0.MapVoteItemNext:beginAnimation(200)
				f78_arg0.MapVoteItemNext:setAlpha(0)
				f78_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f78_arg0.clipInterrupted)
				f78_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f78_arg0.clipFinished)
			end
			f78_arg0.MapVoteItemNext:completeAnimation()
			f78_arg0.MapVoteItemNext:setAlpha(1)
			f78_local3(f78_arg0.MapVoteItemNext)
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
				f86_arg0.MapVoteItemVoteDecided:beginAnimation(400)
				f86_arg0.MapVoteItemVoteDecided:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemVoteDecided:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f86_arg0.MapVoteItemVoteDecided:completeAnimation()
			f86_arg0.MapVoteItemVoteDecided:setAlpha(0)
			f86_local0(f86_arg0.MapVoteItemVoteDecided)
			local f86_local1 = function(f89_arg0)
				local f89_local0 = function(f90_arg0)
					local f90_local0 = function(f91_arg0)
						f91_arg0:beginAnimation(99)
						f91_arg0:setAlpha(0)
						f91_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
					end
					f90_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f90_arg0:setLeftRight(0, 0, 0, 263)
					f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
				end
				f86_arg0.MapVoteItemRandom:beginAnimation(200)
				f86_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f89_local0)
			end
			f86_arg0.MapVoteItemRandom:completeAnimation()
			f86_arg0.MapVoteItemRandom:setLeftRight(0, 0, 538, 801)
			f86_arg0.MapVoteItemRandom:setAlpha(1)
			f86_local1(f86_arg0.MapVoteItemRandom)
			local f86_local2 = function(f92_arg0)
				f86_arg0.MapVoteItemPrevious:beginAnimation(200)
				f86_arg0.MapVoteItemPrevious:setAlpha(0)
				f86_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.MapVoteItemPrevious:completeAnimation()
			f86_arg0.MapVoteItemPrevious:setAlpha(1)
			f86_local2(f86_arg0.MapVoteItemPrevious)
			local f86_local3 = function(f93_arg0)
				f86_arg0.MapVoteItemNext:beginAnimation(200)
				f86_arg0.MapVoteItemNext:setAlpha(0)
				f86_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.MapVoteItemNext:completeAnimation()
			f86_arg0.MapVoteItemNext:setAlpha(1)
			f86_local3(f86_arg0.MapVoteItemNext)
		end,
		DefaultState = function(f94_arg0, f94_arg1)
			f94_arg0:__resetProperties()
			f94_arg0:setupElementClipCounter(4)
			local f94_local0 = function(f95_arg0)
				f94_arg0.MapVoteItemRandom:beginAnimation(400)
				f94_arg0.MapVoteItemRandom:setAlpha(0)
				f94_arg0.MapVoteItemRandom:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.MapVoteItemRandom:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.MapVoteItemRandom:completeAnimation()
			f94_arg0.MapVoteItemRandom:setAlpha(1)
			f94_local0(f94_arg0.MapVoteItemRandom)
			local f94_local1 = function(f96_arg0)
				f94_arg0.MapVoteItemPrevious:beginAnimation(400)
				f94_arg0.MapVoteItemPrevious:setAlpha(0)
				f94_arg0.MapVoteItemPrevious:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.MapVoteItemPrevious:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.MapVoteItemPrevious:completeAnimation()
			f94_arg0.MapVoteItemPrevious:setAlpha(1)
			f94_local1(f94_arg0.MapVoteItemPrevious)
			local f94_local2 = function(f97_arg0)
				f94_arg0.MapVoteItemNext:beginAnimation(400)
				f94_arg0.MapVoteItemNext:setAlpha(0)
				f94_arg0.MapVoteItemNext:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.MapVoteItemNext:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.MapVoteItemNext:completeAnimation()
			f94_arg0.MapVoteItemNext:setAlpha(1)
			f94_local2(f94_arg0.MapVoteItemNext)
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
			f99_arg0.MapVoteItemVoteDecided:completeAnimation()
			f99_arg0.MapVoteItemVoteDecided:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemVoteDecided)
			f99_arg0.MapVoteItemRandom:completeAnimation()
			f99_arg0.MapVoteItemRandom:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemRandom)
			f99_arg0.MapVoteItemPrevious:completeAnimation()
			f99_arg0.MapVoteItemPrevious:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemPrevious)
			f99_arg0.MapVoteItemNext:completeAnimation()
			f99_arg0.MapVoteItemNext:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.MapVoteItemNext)
		end,
	},
	MapVoteChosenPrevious = {
		DefaultClip = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(4)
			f100_arg0.MapVoteItemVoteDecided:completeAnimation()
			f100_arg0.MapVoteItemVoteDecided:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemVoteDecided)
			f100_arg0.MapVoteItemRandom:completeAnimation()
			f100_arg0.MapVoteItemRandom:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemRandom)
			f100_arg0.MapVoteItemPrevious:completeAnimation()
			f100_arg0.MapVoteItemPrevious:setLeftRight(0, 0, 0, 250)
			f100_arg0.MapVoteItemPrevious:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemPrevious)
			f100_arg0.MapVoteItemNext:completeAnimation()
			f100_arg0.MapVoteItemNext:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.MapVoteItemNext)
		end,
	},
	MapVoteChosenRandom = {
		DefaultClip = function(f101_arg0, f101_arg1)
			f101_arg0:__resetProperties()
			f101_arg0:setupElementClipCounter(4)
			f101_arg0.MapVoteItemVoteDecided:completeAnimation()
			f101_arg0.MapVoteItemVoteDecided:setAlpha(1)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemVoteDecided)
			f101_arg0.MapVoteItemRandom:completeAnimation()
			f101_arg0.MapVoteItemRandom:setLeftRight(0, 0, 0, 250)
			f101_arg0.MapVoteItemRandom:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemRandom)
			f101_arg0.MapVoteItemPrevious:completeAnimation()
			f101_arg0.MapVoteItemPrevious:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemPrevious)
			f101_arg0.MapVoteItemNext:completeAnimation()
			f101_arg0.MapVoteItemNext:setAlpha(0)
			f101_arg0.clipFinished(f101_arg0.MapVoteItemNext)
		end,
	},
	SelectedMap = {
		DefaultClip = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(4)
			local f102_local0 = function(f103_arg0)
				f102_arg0.MapVoteItemVoteDecided:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
				f102_arg0.MapVoteItemVoteDecided:setLeftRight(0, 0, 0, 632)
				f102_arg0.MapVoteItemVoteDecided:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
				f102_arg0.MapVoteItemVoteDecided:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
			end
			f102_arg0.MapVoteItemVoteDecided:completeAnimation()
			f102_arg0.MapVoteItemVoteDecided.MapImage:completeAnimation()
			f102_arg0.MapVoteItemVoteDecided.GameModeIcon:completeAnimation()
			f102_arg0.MapVoteItemVoteDecided.CommonButtonOutlineThin:completeAnimation()
			f102_arg0.MapVoteItemVoteDecided:setLeftRight(0, 0, 0, 263)
			f102_arg0.MapVoteItemVoteDecided:setAlpha(1)
			f102_arg0.MapVoteItemVoteDecided.MapImage:setShaderVector(0, 0, 0.5, 0, 0)
			f102_arg0.MapVoteItemVoteDecided.MapImage:setShaderVector(1, 1, 1, 0, 0)
			f102_arg0.MapVoteItemVoteDecided.GameModeIcon:setAlpha(1)
			f102_arg0.MapVoteItemVoteDecided.CommonButtonOutlineThin:setAlpha(0)
			f102_local0(f102_arg0.MapVoteItemVoteDecided)
			f102_arg0.MapVoteItemRandom:completeAnimation()
			f102_arg0.MapVoteItemRandom:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.MapVoteItemRandom)
			f102_arg0.MapVoteItemPrevious:completeAnimation()
			f102_arg0.MapVoteItemPrevious:setAlpha(0)
			f102_arg0.clipFinished(f102_arg0.MapVoteItemPrevious)
			f102_arg0.MapVoteItemNext:completeAnimation()
			f102_arg0.MapVoteItemNext.VoteType:completeAnimation()
			f102_arg0.MapVoteItemNext:setAlpha(0)
			f102_arg0.MapVoteItemNext.VoteType:setAlpha(0.95)
			f102_arg0.clipFinished(f102_arg0.MapVoteItemNext)
		end,
		DefaultState = function(f104_arg0, f104_arg1)
			f104_arg0:__resetProperties()
			f104_arg0:setupElementClipCounter(5)
			local f104_local0 = function(f105_arg0)
				f104_arg0.MapVoteItemVoteDecided:beginAnimation(400)
				f104_arg0.MapVoteItemVoteDecided.GameModeIcon:beginAnimation(400)
				f104_arg0.MapVoteItemVoteDecided:setAlpha(0)
				f104_arg0.MapVoteItemVoteDecided.GameModeIcon:setAlpha(0)
				f104_arg0.MapVoteItemVoteDecided:registerEventHandler("interrupted_keyframe", f104_arg0.clipInterrupted)
				f104_arg0.MapVoteItemVoteDecided:registerEventHandler("transition_complete_keyframe", f104_arg0.clipFinished)
			end
			f104_arg0.MapVoteItemVoteDecided:completeAnimation()
			f104_arg0.MapVoteItemVoteDecided.MapImage:completeAnimation()
			f104_arg0.MapVoteItemVoteDecided.GameModeIcon:completeAnimation()
			f104_arg0.MapVoteItemVoteDecided.CommonButtonOutlineThin:completeAnimation()
			f104_arg0.MapVoteItemVoteDecided:setLeftRight(0, 0, 0, 805)
			f104_arg0.MapVoteItemVoteDecided:setAlpha(1)
			f104_arg0.MapVoteItemVoteDecided.MapImage:setShaderVector(0, 0, 0.39, 0, 0)
			f104_arg0.MapVoteItemVoteDecided.GameModeIcon:setAlpha(1)
			f104_arg0.MapVoteItemVoteDecided.CommonButtonOutlineThin:setAlpha(0)
			f104_local0(f104_arg0.MapVoteItemVoteDecided)
			f104_arg0.MapVoteItemRandom:completeAnimation()
			f104_arg0.MapVoteItemRandom:setAlpha(0)
			f104_arg0.clipFinished(f104_arg0.MapVoteItemRandom)
			f104_arg0.MapVoteItemPrevious:completeAnimation()
			f104_arg0.MapVoteItemPrevious:setAlpha(0)
			f104_arg0.clipFinished(f104_arg0.MapVoteItemPrevious)
			f104_arg0.MapVoteItemNext:completeAnimation()
			f104_arg0.MapVoteItemNext:setAlpha(0)
			f104_arg0.clipFinished(f104_arg0.MapVoteItemNext)
			local f104_local1 = function(f106_arg0)
				f104_arg0.LobbyStatus:beginAnimation(400)
				f104_arg0.LobbyStatus:setAlpha(0)
				f104_arg0.LobbyStatus:registerEventHandler("interrupted_keyframe", f104_arg0.clipInterrupted)
				f104_arg0.LobbyStatus:registerEventHandler("transition_complete_keyframe", f104_arg0.clipFinished)
			end
			f104_arg0.LobbyStatus:completeAnimation()
			f104_arg0.LobbyStatus:setAlpha(1)
			f104_local1(f104_arg0.LobbyStatus)
		end,
	},
}
CoD.MapVote.__onClose = function(f107_arg0)
	f107_arg0.MapVoteItemVoteDecided:close()
	f107_arg0.MapVoteItemRandom:close()
	f107_arg0.MapVoteItemPrevious:close()
	f107_arg0.MapVoteItemNext:close()
	f107_arg0.LobbyStatus:close()
end
