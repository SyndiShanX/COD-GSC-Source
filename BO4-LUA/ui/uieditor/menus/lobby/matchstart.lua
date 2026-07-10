CoD.MatchStart = InheritFrom(CoD.Menu)
LUI.createMenu.MatchStart = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MatchStart", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.MatchStart)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local FullBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FullBlack:setRGB(0, 0, 0)
	FullBlack:setAlpha(0)
	self:addElement(FullBlack)
	self.FullBlack = FullBlack
	local MapImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapImage:setAlpha(0)
	MapImage:subscribeToGlobalModel(f1_arg0, "MapInfo", "mapImage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage:setImage(RegisterImage(f2_local0))
		end
	end)
	MapImage:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "publicLobby.stage", function(model)
		local f3_local0 = MapImage
		if CoD.ModelUtility.IsGlobalModelValueLessThanOrEqualToEnum(f1_arg0, "lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4) then
			GoBack(self, f1_arg0)
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local GametypeText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -18.5, 41.5)
	GametypeText:setRGB(0.76, 0.76, 0.76)
	GametypeText:setAlpha(0)
	GametypeText:setTTF("ttmussels_demibold")
	GametypeText:setLetterSpacing(14)
	GametypeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GametypeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	GametypeText:subscribeToGlobalModel(f1_arg0, "MapVote", "mapVoteGameModeNext", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GametypeText:setText(GameTypeToLocalizedGameType(f4_local0))
		end
	end)
	self:addElement(GametypeText)
	self.GametypeText = GametypeText
	local MapName = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, 66.5, 103.5)
	MapName:setRGB(0.75, 0.71, 0.19)
	MapName:setAlpha(0)
	MapName:setTTF("ttmussels_regular")
	MapName:setLetterSpacing(14)
	MapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MapName:subscribeToGlobalModel(f1_arg0, "MapVote", "mapVoteMapNext", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MapName:setText(MapNameToLocalizedMapName(f5_local0))
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	local GametypeImage = LUI.UIImage.new(0.5, 0.5, -80, 80, 0.5, 0.5, -185, -25)
	GametypeImage:setAlpha(0)
	GametypeImage:subscribeToGlobalModel(f1_arg0, "MapInfo", "gameTypeIcon", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			GametypeImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.MatchStart.__resetProperties = function(f7_arg0)
	f7_arg0.FullBlack:completeAnimation()
	f7_arg0.MapImage:completeAnimation()
	f7_arg0.GametypeText:completeAnimation()
	f7_arg0.GametypeImage:completeAnimation()
	f7_arg0.MapName:completeAnimation()
	f7_arg0.FullBlack:setAlpha(0)
	f7_arg0.MapImage:setLeftRight(0, 1, 0, 0)
	f7_arg0.MapImage:setTopBottom(0, 1, 0, 0)
	f7_arg0.MapImage:setAlpha(0)
	f7_arg0.GametypeText:setAlpha(0)
	f7_arg0.GametypeImage:setAlpha(0)
	f7_arg0.MapName:setLeftRight(0, 1, 0, 0)
	f7_arg0.MapName:setTopBottom(0.5, 0.5, 66.5, 103.5)
	f7_arg0.MapName:setAlpha(0)
end
CoD.MatchStart.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FullBlack:beginAnimation(500)
				f8_arg0.FullBlack:setAlpha(1)
				f8_arg0.FullBlack:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FullBlack:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FullBlack:completeAnimation()
			f8_arg0.FullBlack:setAlpha(0)
			f8_local0(f8_arg0.FullBlack)
			local f8_local1 = function(f10_arg0)
				f10_arg0:beginAnimation(500)
				f10_arg0:setAlpha(1)
				f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.MapImage:beginAnimation(500)
			f8_arg0.MapImage:setLeftRight(0, 1, 0, 0)
			f8_arg0.MapImage:setTopBottom(0, 1, 0, 0)
			f8_arg0.MapImage:setAlpha(0)
			f8_arg0.MapImage:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
			f8_arg0.MapImage:registerEventHandler("transition_complete_keyframe", f8_local1)
			local f8_local2 = function(f11_arg0)
				f11_arg0:beginAnimation(500)
				f11_arg0:setAlpha(1)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.GametypeText:beginAnimation(500)
			f8_arg0.GametypeText:setAlpha(0)
			f8_arg0.GametypeText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
			f8_arg0.GametypeText:registerEventHandler("transition_complete_keyframe", f8_local2)
			local f8_local3 = function(f12_arg0)
				f12_arg0:beginAnimation(500)
				f12_arg0:setAlpha(1)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.MapName:beginAnimation(500)
			f8_arg0.MapName:setLeftRight(0, 1, 0, 0)
			f8_arg0.MapName:setTopBottom(0.5, 0.5, 66.5, 103.5)
			f8_arg0.MapName:setAlpha(0)
			f8_arg0.MapName:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
			f8_arg0.MapName:registerEventHandler("transition_complete_keyframe", f8_local3)
			local f8_local4 = function(f13_arg0)
				f13_arg0:beginAnimation(500)
				f13_arg0:setAlpha(1)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.GametypeImage:beginAnimation(500)
			f8_arg0.GametypeImage:setAlpha(0)
			f8_arg0.GametypeImage:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
			f8_arg0.GametypeImage:registerEventHandler("transition_complete_keyframe", f8_local4)
		end,
	},
}
CoD.MatchStart.__onClose = function(f14_arg0)
	f14_arg0.MapImage:close()
	f14_arg0.GametypeText:close()
	f14_arg0.MapName:close()
	f14_arg0.GametypeImage:close()
end
