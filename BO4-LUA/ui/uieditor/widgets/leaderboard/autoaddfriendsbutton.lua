require("x64:46897811dbbcd6f")
CoD.AutoAddFriendsButton = InheritFrom(LUI.UIElement)
CoD.AutoAddFriendsButton.__defaultWidth = 303
CoD.AutoAddFriendsButton.__defaultHeight = 92
CoD.AutoAddFriendsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AutoAddFriendsButton)
	self.id = "AutoAddFriendsButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AutoAddFriendsButton = CoD.CommonListButtonShort_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 303, 0, 0, 0, 92)
	AutoAddFriendsButton:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.LeaderboardUtility.AutoAddFriendsCheckboxDisabled(f1_arg1)
			end,
		},
	})
	local f1_local2 = AutoAddFriendsButton
	local TextBox = AutoAddFriendsButton.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	TextBox(f1_local2, f1_local4["socialRoot.showPlayersList"], function(f3_arg0)
		f1_arg0:updateElementState(AutoAddFriendsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "socialRoot.showPlayersList",
		})
	end, false)
	AutoAddFriendsButton.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_283B7C8E45BB59D2"))
	f1_local2 = AutoAddFriendsButton
	TextBox = AutoAddFriendsButton.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	TextBox(f1_local2, f1_local4["socialRoot.showPlayersList"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	AutoAddFriendsButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AutoAddFriendsButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.LeaderboardUtility.GetAutoAddFriends(controller) then
			PlaySoundSetSound(self, "tab_changed")
			CoD.LeaderboardUtility.SetAutoAddFriendsFalse(controller)
			ForceNotifyGlobalModel(controller, "socialRoot.tab")
			ForceNotifyGlobalModel(controller, "socialRoot.showPlayersList")
			return true
		elseif not CoD.LeaderboardUtility.GetAutoAddFriends(controller) then
			PlaySoundSetSound(self, "tab_changed")
			CoD.LeaderboardUtility.SetAutoAddFriendsTrue(controller)
			CoD.LeaderboardUtility.AutoAddFriends(controller)
			ForceNotifyGlobalModel(controller, "socialRoot.tab")
			ForceNotifyGlobalModel(controller, "socialRoot.showPlayersList")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.LeaderboardUtility.GetAutoAddFriends(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ui_confirm")
			return true
		elseif not CoD.LeaderboardUtility.GetAutoAddFriends(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(AutoAddFriendsButton)
	self.AutoAddFriendsButton = AutoAddFriendsButton
	TextBox = LUI.UIText.new(0, 0, 0, 303, 0, 0, 113.5, 146.5)
	TextBox:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
	TextBox:setAlpha(0)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1DDD4B3AA4AA58B0"))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.LeaderboardUtility.AutoAddFriendsCheckboxDisabled(f1_arg1)
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.LeaderboardUtility.GetAutoAddFriends(f1_arg1)
			end,
		},
		{
			stateName = "Unchecked",
			condition = function(menu, element, event)
				return not CoD.LeaderboardUtility.GetAutoAddFriends(f1_arg1)
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["socialRoot.showPlayersList"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "socialRoot.showPlayersList",
		})
	end, false)
	AutoAddFriendsButton.id = "AutoAddFriendsButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AutoAddFriendsButton.__resetProperties = function(f12_arg0)
	f12_arg0.AutoAddFriendsButton:completeAnimation()
	f12_arg0.TextBox:completeAnimation()
	f12_arg0.AutoAddFriendsButton:setRGB(1, 1, 1)
	f12_arg0.AutoAddFriendsButton:setAlpha(1)
	f12_arg0.TextBox:setAlpha(0)
end
CoD.AutoAddFriendsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.AutoAddFriendsButton:completeAnimation()
			f14_arg0.AutoAddFriendsButton:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f14_arg0.AutoAddFriendsButton:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.AutoAddFriendsButton)
			f14_arg0.TextBox:completeAnimation()
			f14_arg0.TextBox:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.TextBox)
		end,
	},
	Checked = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.AutoAddFriendsButton:completeAnimation()
			f15_arg0.AutoAddFriendsButton:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.AutoAddFriendsButton)
		end,
	},
	Unchecked = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.AutoAddFriendsButton:completeAnimation()
			f16_arg0.AutoAddFriendsButton:setRGB(ColorSet.T8__BUTTON__UNSELECTED__HEADER.r, ColorSet.T8__BUTTON__UNSELECTED__HEADER.g, ColorSet.T8__BUTTON__UNSELECTED__HEADER.b)
			f16_arg0.AutoAddFriendsButton:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.AutoAddFriendsButton)
		end,
	},
}
CoD.AutoAddFriendsButton.__onClose = function(f17_arg0)
	f17_arg0.AutoAddFriendsButton:close()
end
