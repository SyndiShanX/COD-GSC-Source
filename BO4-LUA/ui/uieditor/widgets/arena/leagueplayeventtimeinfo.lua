require("x64:6650e87e9320a69")
CoD.LeaguePlayEventTimeInfo = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEventTimeInfo.__defaultWidth = 800
CoD.LeaguePlayEventTimeInfo.__defaultHeight = 240
CoD.LeaguePlayEventTimeInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEventTimeInfo)
	self.id = "LeaguePlayEventTimeInfo"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EventName = LUI.UIText.new(0, 0, 189, 784, 0, 0, 35, 107)
	EventName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	EventName:setTTF("ttmussels_demibold")
	EventName:setLetterSpacing(6)
	EventName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	EventName:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EventName:setText(ToUpper(f2_local0))
		end
	end)
	self:addElement(EventName)
	self.EventName = EventName
	local Description = LUI.UIText.new(0, 0, 192, 787, 0, 0, 110.5, 131.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2754C899A05E0C7D"))
	Description:setTTF("ttmussels_regular")
	Description:setLetterSpacing(2)
	Description:setLineSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local LeaguePlayIcon = LUI.UIImage.new(0, 0, -58, 222, 0, 0, -48, 232)
	LeaguePlayIcon:setImage(RegisterImage(@"uie_ui_icon_gamemode_wl_league"))
	self:addElement(LeaguePlayIcon)
	self.LeaguePlayIcon = LeaguePlayIcon
	local ArenaLeagueEventTimer = CoD.ArenaLeagueEventTimer.new(f1_arg0, f1_arg1, 0, 0, 192, 787, 0, 0, 15, 35)
	ArenaLeagueEventTimer.event:setText(LocalizeToUpperString(@"hash_6FB561925D7F1E7E"))
	self:addElement(ArenaLeagueEventTimer)
	self.ArenaLeagueEventTimer = ArenaLeagueEventTimer
	self:mergeStateConditions({
		{
			stateName = "NextEvent",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Scrims",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"])
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyPlaylist.name"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEventTimeInfo.__resetProperties = function(f7_arg0)
	f7_arg0.ArenaLeagueEventTimer:completeAnimation()
	f7_arg0.Description:completeAnimation()
	f7_arg0.LeaguePlayIcon:completeAnimation()
	f7_arg0.EventName:completeAnimation()
	f7_arg0.ArenaLeagueEventTimer:setLeftRight(0, 0, 192, 787)
	f7_arg0.ArenaLeagueEventTimer:setTopBottom(0, 0, 15, 35)
	f7_arg0.ArenaLeagueEventTimer:setAlpha(1)
	f7_arg0.ArenaLeagueEventTimer:setScale(1, 1)
	f7_arg0.ArenaLeagueEventTimer.event:setText(LocalizeToUpperString(@"hash_6FB561925D7F1E7E"))
	f7_arg0.Description:setAlpha(1)
	f7_arg0.Description:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2754C899A05E0C7D"))
	f7_arg0.LeaguePlayIcon:setLeftRight(0, 0, -58, 222)
	f7_arg0.LeaguePlayIcon:setTopBottom(0, 0, -48, 232)
	f7_arg0.LeaguePlayIcon:setAlpha(1)
	f7_arg0.EventName:setLeftRight(0, 0, 189, 784)
	f7_arg0.EventName:setTopBottom(0, 0, 35, 107)
	f7_arg0.EventName:setAlpha(1)
end
CoD.LeaguePlayEventTimeInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ArenaLeagueEventTimer:completeAnimation()
			f8_arg0.ArenaLeagueEventTimer.event:completeAnimation()
			f8_arg0.ArenaLeagueEventTimer.event:setText(LocalizeToUpperString(@"hash_24567DF5804DC2CC"))
			f8_arg0.clipFinished(f8_arg0.ArenaLeagueEventTimer)
		end,
	},
	NextEvent = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.EventName:completeAnimation()
			f9_arg0.EventName:setLeftRight(0, 0, 140, 735)
			f9_arg0.EventName:setTopBottom(0, 0, 93, 138)
			f9_arg0.EventName:setAlpha(0.5)
			f9_arg0.clipFinished(f9_arg0.EventName)
			f9_arg0.Description:completeAnimation()
			f9_arg0.Description:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Description)
			f9_arg0.LeaguePlayIcon:completeAnimation()
			f9_arg0.LeaguePlayIcon:setLeftRight(0, 0, 20, 140)
			f9_arg0.LeaguePlayIcon:setTopBottom(0, 0, 50.5, 170.5)
			f9_arg0.LeaguePlayIcon:setAlpha(0.5)
			f9_arg0.clipFinished(f9_arg0.LeaguePlayIcon)
			f9_arg0.ArenaLeagueEventTimer:completeAnimation()
			f9_arg0.ArenaLeagueEventTimer.event:completeAnimation()
			f9_arg0.ArenaLeagueEventTimer:setLeftRight(0, 0, 140, 540)
			f9_arg0.ArenaLeagueEventTimer:setTopBottom(0, 0, 72, 93)
			f9_arg0.ArenaLeagueEventTimer:setScale(1, 1)
			f9_arg0.ArenaLeagueEventTimer.event:setText(LocalizeToUpperString(@"hash_269234CC3988500E"))
			f9_arg0.clipFinished(f9_arg0.ArenaLeagueEventTimer)
		end,
	},
	Scrims = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Description:completeAnimation()
			f10_arg0.Description:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_C545762E42A3DBE"))
			f10_arg0.clipFinished(f10_arg0.Description)
			f10_arg0.ArenaLeagueEventTimer:completeAnimation()
			f10_arg0.ArenaLeagueEventTimer:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.ArenaLeagueEventTimer)
		end,
	},
}
CoD.LeaguePlayEventTimeInfo.__onClose = function(f11_arg0)
	f11_arg0.EventName:close()
	f11_arg0.ArenaLeagueEventTimer:close()
end
