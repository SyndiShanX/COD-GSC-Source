require("x64:71b0b1e3a4ad573")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.Challenges_FrameWidget_Toolkit = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_Toolkit.__defaultWidth = 1560
CoD.Challenges_FrameWidget_Toolkit.__defaultHeight = 780
CoD.Challenges_FrameWidget_Toolkit.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_Toolkit)
	self.id = "Challenges_FrameWidget_Toolkit"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1677D363E896D453"))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(@"ui_icon_challenges_zmtoolkit_large"))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "toolkit", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local Prestigious = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 227, 327)
	Prestigious.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_16A1754117AB845E"))
	Prestigious:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "prestigious", function(model)
		Prestigious:setModel(model, f1_arg1)
	end)
	Prestigious:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Prestigious, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "prestigious")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Toolkit", controller, nil)
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
	self:addElement(Prestigious)
	self.Prestigious = Prestigious
	local WeaponsAndEquipment = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	WeaponsAndEquipment.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_126CD93E46733780"))
	WeaponsAndEquipment:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "weapons_and_equipment", function(model)
		WeaponsAndEquipment:setModel(model, f1_arg1)
	end)
	WeaponsAndEquipment:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponsAndEquipment, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "weapons_and_equipment")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Toolkit", controller, nil)
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
	self:addElement(WeaponsAndEquipment)
	self.WeaponsAndEquipment = WeaponsAndEquipment
	local ElixersAndTalismans = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 3, 103)
	ElixersAndTalismans.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_221B7E9D719708D1"))
	ElixersAndTalismans:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "elixirs_and_talismans", function(model)
		ElixersAndTalismans:setModel(model, f1_arg1)
	end)
	ElixersAndTalismans:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ElixersAndTalismans, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "elixirs_and_talismans")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Toolkit", controller, nil)
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
	self:addElement(ElixersAndTalismans)
	self.ElixersAndTalismans = ElixersAndTalismans
	Prestigious.id = "Prestigious"
	WeaponsAndEquipment.id = "WeaponsAndEquipment"
	ElixersAndTalismans.id = "ElixersAndTalismans"
	self.__defaultFocus = Prestigious
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_Toolkit.__onClose = function(f15_arg0)
	f15_arg0.TitleBG:close()
	f15_arg0.Title:close()
	f15_arg0.Prestigious:close()
	f15_arg0.WeaponsAndEquipment:close()
	f15_arg0.ElixersAndTalismans:close()
end
