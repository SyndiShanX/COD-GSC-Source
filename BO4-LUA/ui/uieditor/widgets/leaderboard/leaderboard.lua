require("x64:60a9abf9563aa00")
require("x64:5ab2d47ad5fd1bb")
CoD.Leaderboard = InheritFrom(LUI.UIElement)
CoD.Leaderboard.__defaultWidth = 1170
CoD.Leaderboard.__defaultHeight = 690
CoD.Leaderboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard)
	self.id = "Leaderboard"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaderboardRows = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	LeaderboardRows:setLeftRight(0, 0, 0, 1170)
	LeaderboardRows:setTopBottom(0, 0, 42, 758)
	LeaderboardRows:setWidgetType(CoD.LeaderboardRow)
	LeaderboardRows:setVerticalCount(18)
	LeaderboardRows:setSpacing(4)
	LeaderboardRows:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LeaderboardRows:setDataSource("LeaderboardRows")
	LeaderboardRows:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local LoadingText = LeaderboardRows
	local LeaderboardHeader = LeaderboardRows.subscribeToModel
	local LeaderboardEmptyText = Engine[0x4DF5CFBC1771947](f1_arg1)
	LeaderboardHeader(LoadingText, LeaderboardEmptyText.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	LeaderboardRows:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.LeaderboardUtility.LeaderboardEnablePCacheBuffer(self, element, f1_arg1)
		return f4_local0
	end)
	LeaderboardRows:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		CoD.LeaderboardUtility.LeaderboardDisablePCacheBuffer(self, element, f1_arg1)
		return f5_local0
	end)
	LeaderboardRows:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeaderboardRows, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], nil, function(element, menu, controller, model)
		if IsSelfInState(self, "DefaultState") and not IsRepeatButtonPress(model) then
			PlaySoundAlias("uin_paint_decal_nav")
			CoD.LeaderboardUtility.LeaderboardPageUp(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "DefaultState") and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x7630B08CE7BF317, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(LeaderboardRows, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], nil, function(element, menu, controller, model)
		if IsSelfInState(self, "DefaultState") and not IsRepeatButtonPress(model) then
			PlaySoundAlias("uin_paint_decal_nav")
			CoD.LeaderboardUtility.LeaderboardPageDown(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "DefaultState") and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x35B6BF6242A52D2, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(LeaderboardRows, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsSelfInState(self, "DefaultState") then
			PlaySoundAlias("uin_paint_decal_nav")
			CoD.LeaderboardUtility.LeaderboardGoToTopOfList(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x973DD79B6545E80, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(LeaderboardRows, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsSelfInState(self, "DefaultState") and IsGamepad(controller) then
			CoD.LeaderboardUtility.LeaderboardOpenPlayerDetails(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "DefaultState") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(LeaderboardRows)
	self.LeaderboardRows = LeaderboardRows
	LeaderboardHeader = CoD.LeaderboardHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 1170, 0, 0, 0, 36)
	LeaderboardHeader:subscribeToGlobalModel(f1_arg1, "LeaderboardHeader", nil, function(model)
		LeaderboardHeader:setModel(model, f1_arg1)
	end)
	self:addElement(LeaderboardHeader)
	self.LeaderboardHeader = LeaderboardHeader
	LoadingText = LUI.UIText.new(0.5, 0.5, -82.5, 82.5, 0.5, 0.5, -14, 14)
	LoadingText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LoadingText:setText(Engine[0xF9F1239CFD921FE](0x6A50DC52864D7AE))
	LoadingText:setTTF("dinnext_regular")
	LoadingText:setLetterSpacing(2)
	LoadingText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LoadingText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LoadingText)
	self.LoadingText = LoadingText
	LeaderboardEmptyText = LUI.UIText.new(0.5, 0.5, -331, 331, 0.5, 0.5, -14, 14)
	LeaderboardEmptyText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LeaderboardEmptyText:setText(Engine[0xF9F1239CFD921FE](0x1BBC59F370DA3F))
	LeaderboardEmptyText:setTTF("dinnext_regular")
	LeaderboardEmptyText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LeaderboardEmptyText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LeaderboardEmptyText)
	self.LeaderboardEmptyText = LeaderboardEmptyText
	self:mergeStateConditions({
		{
			stateName = "UpdatingLeaderboard",
			condition = function(menu, element, event)
				return CoD.LeaderboardUtility.IsLeaderboardUpdating()
			end,
		},
		{
			stateName = "EmptyLeaderboard",
			condition = function(menu, element, event)
				return CoD.LeaderboardUtility.IsLeaderboardEmpty()
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.LeaderboardRows.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.status, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.LeaderboardRows.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.totalCount, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "totalCount",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f20_arg2, f20_arg3, f20_arg4)
		if IsInDefaultState(element) then
			CoD.LeaderboardUtility.LeaderboardUpdateHeaderModel(self, controller)
			UpdateAllMenuButtonPrompts(f1_arg0, controller)
		else
			UpdateAllMenuButtonPrompts(f1_arg0, controller)
		end
	end)
	LeaderboardRows.id = "LeaderboardRows"
	self.__defaultFocus = LeaderboardRows
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.LeaderboardUtility.LeaderboardListGridUpdated(self, f1_arg1)
	return self
end
CoD.Leaderboard.__resetProperties = function(f21_arg0)
	f21_arg0.LoadingText:completeAnimation()
	f21_arg0.LeaderboardEmptyText:completeAnimation()
	f21_arg0.LeaderboardRows:completeAnimation()
	f21_arg0.LoadingText:setAlpha(1)
	f21_arg0.LeaderboardEmptyText:setAlpha(1)
	f21_arg0.LeaderboardRows:setAlpha(1)
end
CoD.Leaderboard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.LoadingText:completeAnimation()
			f22_arg0.LoadingText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LoadingText)
			f22_arg0.LeaderboardEmptyText:completeAnimation()
			f22_arg0.LeaderboardEmptyText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LeaderboardEmptyText)
		end,
	},
	UpdatingLeaderboard = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.LeaderboardRows:completeAnimation()
			f23_arg0.LeaderboardRows:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.LeaderboardRows)
			f23_arg0.LeaderboardEmptyText:completeAnimation()
			f23_arg0.LeaderboardEmptyText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.LeaderboardEmptyText)
		end,
	},
	EmptyLeaderboard = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.LeaderboardRows:completeAnimation()
			f24_arg0.LeaderboardRows:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.LeaderboardRows)
			f24_arg0.LoadingText:completeAnimation()
			f24_arg0.LoadingText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.LoadingText)
		end,
	},
}
CoD.Leaderboard.__onClose = function(f25_arg0)
	f25_arg0.LeaderboardRows:close()
	f25_arg0.LeaderboardHeader:close()
end
