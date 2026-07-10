require("x64:d38b2f0473892c6")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.Challenges_FrameWidget_Prestige = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_Prestige.__defaultWidth = 1560
CoD.Challenges_FrameWidget_Prestige.__defaultHeight = 780
CoD.Challenges_FrameWidget_Prestige.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_Prestige)
	self.id = "Challenges_FrameWidget_Prestige"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/prestige"))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpprestige_large"))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "prestige", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local Handling = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 3, 103)
	Handling.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/handling"))
	Handling:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "handling", function(model)
		Handling:setModel(model, f1_arg1)
	end)
	Handling:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Handling, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "handling")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(Handling)
	self.Handling = Handling
	local Efficiency = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	Efficiency.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/efficiency"))
	Efficiency:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "efficiency", function(model)
		Efficiency:setModel(model, f1_arg1)
	end)
	Efficiency:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Efficiency, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "efficiency")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(Efficiency)
	self.Efficiency = Efficiency
	local TacticalKits = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 227, 327)
	TacticalKits.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_780013311B8CB58F"))
	TacticalKits:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "tacticalkits", function(model)
		TacticalKits:setModel(model, f1_arg1)
	end)
	TacticalKits:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TacticalKits, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "tacticalkits")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(TacticalKits)
	self.TacticalKits = TacticalKits
	local Gear = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 340, 440)
	Gear.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/gear"))
	Gear:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "gear", function(model)
		Gear:setModel(model, f1_arg1)
	end)
	Gear:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Gear, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "gear")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(Gear)
	self.Gear = Gear
	local Perks = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 451, 551)
	Perks.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/perks"))
	Perks:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "perks", function(model)
		Perks:setModel(model, f1_arg1)
	end)
	Perks:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Perks, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "perks")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(Perks)
	self.Perks = Perks
	local Equipmen = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 563, 663)
	Equipmen.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/equipment"))
	Equipmen:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "equipment", function(model)
		Equipmen:setModel(model, f1_arg1)
	end)
	Equipmen:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f24_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Equipmen, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "equipment")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(Equipmen)
	self.Equipmen = Equipmen
	local Wildcards = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 675, 775)
	Wildcards.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/wildcards"))
	Wildcards:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "wildcards", function(model)
		Wildcards:setModel(model, f1_arg1)
	end)
	Wildcards:registerEventHandler("gain_focus", function(element, event)
		local f28_local0 = nil
		if element.gainFocus then
			f28_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f28_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f28_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Wildcards, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "wildcards")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Prestige", controller, nil)
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
	self:addElement(Wildcards)
	self.Wildcards = Wildcards
	Handling.id = "Handling"
	Efficiency.id = "Efficiency"
	TacticalKits.id = "TacticalKits"
	Gear.id = "Gear"
	Perks.id = "Perks"
	Equipmen.id = "Equipmen"
	Wildcards.id = "Wildcards"
	self.__defaultFocus = Handling
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_Prestige.__onClose = function(f31_arg0)
	f31_arg0.TitleBG:close()
	f31_arg0.Title:close()
	f31_arg0.Handling:close()
	f31_arg0.Efficiency:close()
	f31_arg0.TacticalKits:close()
	f31_arg0.Gear:close()
	f31_arg0.Perks:close()
	f31_arg0.Equipmen:close()
	f31_arg0.Wildcards:close()
end
