require("x64:72e754310d35e92")
require("x64:715c17feb5d981e")
require("x64:f2b682f28d27631")
require("x64:4f2b91f8688c47b")
CoD.ChallengesSummaryCategoryList_WZ = InheritFrom(LUI.UIElement)
CoD.ChallengesSummaryCategoryList_WZ.__defaultWidth = 1175
CoD.ChallengesSummaryCategoryList_WZ.__defaultHeight = 225
CoD.ChallengesSummaryCategoryList_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 44, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ChallengesSummaryCategoryList_WZ)
	self.id = "ChallengesSummaryCategoryList_WZ"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Career = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0, 0, 0, 363, 0.5, 0.5, -112.5, 112.5)
	Career.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_wzcareer"))
	Career.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_51BEB13BCC1D1E4E"))
	Career:subscribeToGlobalModel(f1_arg1, "ChallengesWZCategoryStats", "career", function(model)
		Career:setModel(model, f1_arg1)
	end)
	Career:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Career, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("defaultChallengeTab", "career")
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Challenges", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Career)
	self.Career = Career
	local Operations = CoD.ChallengesSummaryCategory.new(f1_arg0, f1_arg1, 0, 0, 407, 770, 0.5, 0.5, -112.5, 112.5)
	Operations.SummaryCategory.Icon:setImage(RegisterImage(@"ui_icon_challenges_wzoperations"))
	Operations.SummaryCategory.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_12177A3C9161B05A"))
	Operations:subscribeToGlobalModel(f1_arg1, "ChallengesWZCategoryStats", "operations", function(model)
		Operations:setModel(model, f1_arg1)
	end)
	Operations:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Operations, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("defaultChallengeTab", "operations")
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Challenges", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Operations)
	self.Operations = Operations
	local DarkOps = CoD.ChallengesSummaryDarkOps.new(f1_arg0, f1_arg1, 0, 0, 814, 1177, 0.5, 0.5, -112.5, 112.5)
	DarkOps:mergeStateConditions({
		{
			stateName = "Zombie",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DarkOps.SummaryCategoryBlackOps.Icon:setImage(RegisterImage(@"ui_icon_challenges_wzdarkops"))
	DarkOps:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DarkOps, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "ChallengesDarkOps", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(DarkOps)
	self.DarkOps = DarkOps
	Career.id = "Career"
	Operations.id = "Operations"
	DarkOps.id = "DarkOps"
	self.__defaultFocus = Career
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesSummaryCategoryList_WZ.__onClose = function(f14_arg0)
	f14_arg0.Career:close()
	f14_arg0.Operations:close()
	f14_arg0.DarkOps:close()
end
