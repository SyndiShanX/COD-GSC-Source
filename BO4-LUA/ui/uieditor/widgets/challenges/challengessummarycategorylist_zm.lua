require("x64:72e754310d35e92")
require("x64:715c17feb5d981e")
require("x64:f2b682f28d27631")
require("x64:4f2b91f8688c47b")
CoD.ChallengesSummaryCategoryList_ZM = InheritFrom(LUI.UIElement)
CoD.ChallengesSummaryCategoryList_ZM.__defaultWidth = 1175
CoD.ChallengesSummaryCategoryList_ZM.__defaultHeight = 225
CoD.ChallengesSummaryCategoryList_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 44, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ChallengesSummaryCategoryList_ZM)
	self.id = "ChallengesSummaryCategoryList_ZM"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Toolkit = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0, 0, 0, 363, 0.5, 0.5, -112.5, 112.5)
	Toolkit.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_zmexpert"))
	Toolkit.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6892ED10E8BF4877"))
	Toolkit:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "expert", function(model)
		Toolkit:setModel(model, f1_arg1)
	end)
	Toolkit:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Toolkit, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			SetGlobalModelValue("defaultChallengeTab", "expert")
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Challenges", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Toolkit)
	self.Toolkit = Toolkit
	local Expert = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0, 0, 407, 770, 0.5, 0.5, -112.5, 112.5)
	Expert.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_zmtoolkit"))
	Expert.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1677D363E896D453"))
	Expert:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "toolkit", function(model)
		Expert:setModel(model, f1_arg1)
	end)
	Expert:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Expert, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			SetGlobalModelValue("defaultChallengeTab", "toolkit")
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Challenges", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Expert)
	self.Expert = Expert
	local DarkOps = CoD.ChallengesSummaryDarkOps.new(f1_arg0, f1_arg1, 0, 0, 814, 1177, 0.5, 0.5, -112.5, 112.5)
	DarkOps:mergeStateConditions({
		{
			stateName = "Zombie",
			condition = function(menu, element, event)
				return IsZombies() and AlwaysTrue()
			end,
		},
	})
	local f1_local4 = DarkOps
	local f1_local5 = DarkOps.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(DarkOps, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DarkOps.SummaryCategoryBlackOps.Icon:setImage(RegisterImage(@"ui_icon_challenges_zmdarkops"))
	DarkOps:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DarkOps, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "ChallengesDarkOps", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(DarkOps)
	self.DarkOps = DarkOps
	Toolkit.id = "Toolkit"
	Expert.id = "Expert"
	DarkOps.id = "DarkOps"
	self.__defaultFocus = Toolkit
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesSummaryCategoryList_ZM.__onClose = function(f15_arg0)
	f15_arg0.Toolkit:close()
	f15_arg0.Expert:close()
	f15_arg0.DarkOps:close()
end
