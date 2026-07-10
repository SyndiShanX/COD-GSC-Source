require("x64:fd01a46a0e352c9")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.Challenges_FrameWidget_Career = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_Career.__defaultWidth = 1560
CoD.Challenges_FrameWidget_Career.__defaultHeight = 780
CoD.Challenges_FrameWidget_Career.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_Career)
	self.id = "Challenges_FrameWidget_Career"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[0xF9F1239CFD921FE](0x70C18F2AE62C195))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(0x64348118754B76))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "career", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local GameVictories = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 0, 100)
	GameVictories.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x832B872C3810A1D))
	GameVictories:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "gamevictories", function(model)
		GameVictories:setModel(model, f1_arg1)
	end)
	GameVictories:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameVictories, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "gamevictories")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Career", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(GameVictories)
	self.GameVictories = GameVictories
	local TourOfDuty = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	TourOfDuty.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0xCBFC431FF389F30))
	TourOfDuty:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "tourofduty", function(model)
		TourOfDuty:setModel(model, f1_arg1)
	end)
	TourOfDuty:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TourOfDuty, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "tourofduty")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Career", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(TourOfDuty)
	self.TourOfDuty = TourOfDuty
	local GameHeroics = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 227, 327)
	GameHeroics.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x1DE917BC6765D92))
	GameHeroics:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "gameheroics", function(model)
		GameHeroics:setModel(model, f1_arg1)
	end)
	GameHeroics:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameHeroics, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "gameheroics")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Career", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(GameHeroics)
	self.GameHeroics = GameHeroics
	local Specialized = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 563, 663)
	Specialized.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x24F78410BB18BC0))
	Specialized:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "specialized", function(model)
		Specialized:setModel(model, f1_arg1)
	end)
	Specialized:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Specialized, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "specialized")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Career", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Specialized)
	self.Specialized = Specialized
	local WeaponProficiency = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 340, 440)
	WeaponProficiency.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x8AD60D04B9DC260))
	WeaponProficiency:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "weaponproficiency", function(model)
		WeaponProficiency:setModel(model, f1_arg1)
	end)
	WeaponProficiency:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponProficiency, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "weaponproficiency")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Career", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(WeaponProficiency)
	self.WeaponProficiency = WeaponProficiency
	local Marksman = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 451, 551)
	Marksman.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x6DFABEBE8C8B1E1))
	Marksman:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "marksman", function(model)
		Marksman:setModel(model, f1_arg1)
	end)
	Marksman:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f24_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Marksman, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "marksman")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Career", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Marksman)
	self.Marksman = Marksman
	GameVictories.id = "GameVictories"
	TourOfDuty.id = "TourOfDuty"
	GameHeroics.id = "GameHeroics"
	Specialized.id = "Specialized"
	WeaponProficiency.id = "WeaponProficiency"
	Marksman.id = "Marksman"
	self.__defaultFocus = GameVictories
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_Career.__onClose = function(f27_arg0)
	f27_arg0.TitleBG:close()
	f27_arg0.Title:close()
	f27_arg0.GameVictories:close()
	f27_arg0.TourOfDuty:close()
	f27_arg0.GameHeroics:close()
	f27_arg0.Specialized:close()
	f27_arg0.WeaponProficiency:close()
	f27_arg0.Marksman:close()
end
