require("x64:c40fd7a193ee6d2")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.Challenges_FrameWidget_Scorestreaks = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_Scorestreaks.__defaultWidth = 1560
CoD.Challenges_FrameWidget_Scorestreaks.__defaultHeight = 780
CoD.Challenges_FrameWidget_Scorestreaks.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_Scorestreaks)
	self.id = "Challenges_FrameWidget_Scorestreaks"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/scorestreaks"))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(@"ui_icon_challenges_mpscorestreaks_large"))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "scorestreaks", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local AirAssault = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 3, 103)
	AirAssault.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_497BD69827609591"))
	AirAssault:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "airassault", function(model)
		AirAssault:setModel(model, f1_arg1)
	end)
	AirAssault:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AirAssault, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "airassault")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Scorestreaks", controller, nil)
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
	self:addElement(AirAssault)
	self.AirAssault = AirAssault
	local GroundAssault = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	GroundAssault.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5582B8AD278256C0"))
	GroundAssault:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "groundassault", function(model)
		GroundAssault:setModel(model, f1_arg1)
	end)
	GroundAssault:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GroundAssault, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "groundassault")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Scorestreaks", controller, nil)
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
	self:addElement(GroundAssault)
	self.GroundAssault = GroundAssault
	local Support = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 227, 327)
	Support.ChallengesCategoryButtonInternal.Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/support"))
	Support:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "support", function(model)
		Support:setModel(model, f1_arg1)
	end)
	Support:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Support, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "support")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Scorestreaks", controller, nil)
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
	self:addElement(Support)
	self.Support = Support
	AirAssault.id = "AirAssault"
	GroundAssault.id = "GroundAssault"
	Support.id = "Support"
	self.__defaultFocus = AirAssault
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_Scorestreaks.__onClose = function(f15_arg0)
	f15_arg0.TitleBG:close()
	f15_arg0.Title:close()
	f15_arg0.AirAssault:close()
	f15_arg0.GroundAssault:close()
	f15_arg0.Support:close()
end
