require("x64:3b9fcb643fbe613")
require("x64:46728994d8c06c0")
require("x64:31319dd92d58d3b")
require("x64:c049b7a5f07c1e")
CoD.ZMSpecialEventWidget = InheritFrom(LUI.UIElement)
CoD.ZMSpecialEventWidget.__defaultWidth = 477
CoD.ZMSpecialEventWidget.__defaultHeight = 382
CoD.ZMSpecialEventWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("AutoEvents.cycled")
	self:setClass(CoD.ZMSpecialEventWidget)
	self.id = "ZMSpecialEventWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 382)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local SpecialEventWidget = CoD.SpecialEventWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 0, 0, 382)
	SpecialEventWidget.RewardQuantityText.RewardGrid:setDataSource("SpecialEventRewards")
	SpecialEventWidget:subscribeToGlobalModel(f1_arg1, "SpecialEventCurrentStepInfo", nil, function(model)
		SpecialEventWidget:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialEventWidget)
	self.SpecialEventWidget = SpecialEventWidget
	local FactionRewards = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0, 0, 302, 477, 0, 0, 0, 269)
	FactionRewards:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("faction_callings_enabled_zm")
			end,
		},
		{
			stateName = "OnlineOnly",
			condition = function(menu, element, event)
				return not CoD.ZombieUtility.IsZombieFactionRewardsAvailable(f1_arg1)
			end,
		},
	})
	FactionRewards.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_small_grid"))
	FactionRewards.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeToUpperString(@"menu/rewards"))
	FactionRewards:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FactionRewards, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.StartMenuUtility.OpenStartMenuOverlay(self, menu, controller, "FactionRewards")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(FactionRewards)
	self.FactionRewards = FactionRewards
	local FactionCallings = CoD.StartMenu_Barracks_FactionCalling_Button.new(f1_arg0, f1_arg1, 0, 0, 0, 275, 0, 0, 0, 269)
	FactionCallings:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FactionCallings, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.StartMenuUtility.OpenStartMenuOverlay(self, menu, controller, "FactionCalling")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(FactionCallings)
	self.FactionCallings = FactionCallings
	self:mergeStateConditions({
		{
			stateName = "SpecialEvent",
			condition = function(menu, element, event)
				return IsIntDvarNonZero("zm_active_event_calling")
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "AutoEvents.cycled", function(model)
		local f12_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	SpecialEventWidget.id = "SpecialEventWidget"
	FactionRewards.id = "FactionRewards"
	FactionCallings.id = "FactionCallings"
	self.__defaultFocus = FactionCallings
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMSpecialEventWidget.__resetProperties = function(f13_arg0)
	f13_arg0.SpecialEventWidget:completeAnimation()
	f13_arg0.CommonDetailPanel2:completeAnimation()
	f13_arg0.FactionRewards:completeAnimation()
	f13_arg0.FactionCallings:completeAnimation()
	f13_arg0.SpecialEventWidget:setAlpha(1)
	f13_arg0.CommonDetailPanel2:setAlpha(1)
	f13_arg0.FactionRewards:setAlpha(1)
	f13_arg0.FactionCallings:setAlpha(1)
end
CoD.ZMSpecialEventWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CommonDetailPanel2:completeAnimation()
			f14_arg0.CommonDetailPanel2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CommonDetailPanel2)
			f14_arg0.SpecialEventWidget:completeAnimation()
			f14_arg0.SpecialEventWidget:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.SpecialEventWidget)
		end,
	},
	SpecialEvent = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.SpecialEventWidget:completeAnimation()
			f15_arg0.SpecialEventWidget:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.SpecialEventWidget)
			f15_arg0.FactionRewards:completeAnimation()
			f15_arg0.FactionRewards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f15_arg0.FactionRewards:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.FactionRewards)
			f15_arg0.FactionCallings:completeAnimation()
			f15_arg0.FactionCallings:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.FactionCallings)
		end,
	},
}
CoD.ZMSpecialEventWidget.__onClose = function(f16_arg0)
	f16_arg0.CommonDetailPanel2:close()
	f16_arg0.SpecialEventWidget:close()
	f16_arg0.FactionRewards:close()
	f16_arg0.FactionCallings:close()
end
