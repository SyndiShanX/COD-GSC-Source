require("x64:72e754310d35e92")
require("x64:715c17feb5d981e")
require("x64:f2b682f28d27631")
require("x64:4f2b91f8688c47b")
CoD.ChallengesSummaryCategoryList = InheritFrom(LUI.UIElement)
CoD.ChallengesSummaryCategoryList.__defaultWidth = 1175
CoD.ChallengesSummaryCategoryList.__defaultHeight = 225
CoD.ChallengesSummaryCategoryList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 44, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ChallengesSummaryCategoryList)
	self.id = "ChallengesSummaryCategoryList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Operations = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, -387.5, 0.5, 0.5, -112.5, 112.5)
	Operations.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpoperations"))
	Operations:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "operations", function(model)
		Operations:setModel(model, f1_arg1)
	end)
	Operations:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Operations, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			SetGlobalModelValue("defaultChallengeTab", "operations")
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
	self:addElement(Operations)
	self.Operations = Operations
	local Career = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0.5, 0.5, -343.5, -143.5, 0.5, 0.5, -112.5, 112.5)
	Career.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpcareer"))
	Career.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/career"))
	Career:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "career", function(model)
		Career:setModel(model, f1_arg1)
	end)
	Career:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Career, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			SetGlobalModelValue("defaultChallengeTab", "career")
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
	self:addElement(Career)
	self.Career = Career
	local Scorestreaks = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0.5, 0.5, -99.5, 100.5, 0.5, 0.5, -112.5, 112.5)
	Scorestreaks.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpscorestreaks"))
	Scorestreaks.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/scorestreaks"))
	Scorestreaks:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "scorestreaks", function(model)
		Scorestreaks:setModel(model, f1_arg1)
	end)
	Scorestreaks:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Scorestreaks, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			SetGlobalModelValue("defaultChallengeTab", "scorestreaks")
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
	self:addElement(Scorestreaks)
	self.Scorestreaks = Scorestreaks
	local Prestige = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0.5, 0.5, 144.5, 344.5, 0.5, 0.5, -112.5, 112.5)
	Prestige.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpprestige"))
	Prestige.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/prestige"))
	Prestige:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "prestige", function(model)
		Prestige:setModel(model, f1_arg1)
	end)
	Prestige:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Prestige, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			SetGlobalModelValue("defaultChallengeTab", "prestige")
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
	self:addElement(Prestige)
	self.Prestige = Prestige
	local DarkOps = CoD.ChallengesSummaryDarkOps.new(f1_arg0, f1_arg1, 0.5, 0.5, 388.5, 588.5, 0.5, 0.5, -112.5, 112.5)
	DarkOps.SummaryCategoryBlackOps.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpdarkops"))
	DarkOps:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f18_local0
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
	Operations.id = "Operations"
	Career.id = "Career"
	Scorestreaks.id = "Scorestreaks"
	Prestige.id = "Prestige"
	DarkOps.id = "DarkOps"
	self.__defaultFocus = Operations
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesSummaryCategoryList.__onClose = function(f21_arg0)
	f21_arg0.Operations:close()
	f21_arg0.Career:close()
	f21_arg0.Scorestreaks:close()
	f21_arg0.Prestige:close()
	f21_arg0.DarkOps:close()
end
