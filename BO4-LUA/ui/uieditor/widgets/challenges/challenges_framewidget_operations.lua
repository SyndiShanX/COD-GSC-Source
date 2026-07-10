require("x64:a66b25a146b0455")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.Challenges_FrameWidget_Operations = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_Operations.__defaultWidth = 1560
CoD.Challenges_FrameWidget_Operations.__defaultHeight = 780
CoD.Challenges_FrameWidget_Operations.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_Operations)
	self.id = "Challenges_FrameWidget_Operations"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[0xF9F1239CFD921FE](0xCE9A53873255D09))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(0xF3BDA8DE58310D2))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "operations", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local Bootcamp = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 0, 100)
	Bootcamp.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x77600252B55C452))
	Bootcamp:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "bootcamp", function(model)
		Bootcamp:setModel(model, f1_arg1)
	end)
	Bootcamp:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Bootcamp, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "bootcamp")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Operations", controller, nil)
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
	self:addElement(Bootcamp)
	self.Bootcamp = Bootcamp
	local Killer = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	Killer.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x65DA104E9465AC0))
	Killer:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "killer", function(model)
		Killer:setModel(model, f1_arg1)
	end)
	Killer:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Killer, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "killer")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Operations", controller, nil)
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
	self:addElement(Killer)
	self.Killer = Killer
	local Humiliation = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 227, 327)
	Humiliation.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0xAB782700D73E766))
	Humiliation:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "humiliation", function(model)
		Humiliation:setModel(model, f1_arg1)
	end)
	Humiliation:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Humiliation, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "humiliation")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Operations", controller, nil)
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
	self:addElement(Humiliation)
	self.Humiliation = Humiliation
	local Precision = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 340, 440)
	Precision:setAlpha(0.8)
	Precision.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x86884AAE31003E5))
	Precision:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "precision", function(model)
		Precision:setModel(model, f1_arg1)
	end)
	Precision:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Precision, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "precision")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Operations", controller, nil)
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
	self:addElement(Precision)
	self.Precision = Precision
	local Killjoys = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 451, 551)
	Killjoys.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0xA9D0747734C1994))
	Killjoys:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "killjoys", function(model)
		Killjoys:setModel(model, f1_arg1)
	end)
	Killjoys:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Killjoys, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "killjoys")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Operations", controller, nil)
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
	self:addElement(Killjoys)
	self.Killjoys = Killjoys
	Bootcamp.id = "Bootcamp"
	Killer.id = "Killer"
	Humiliation.id = "Humiliation"
	Precision.id = "Precision"
	Killjoys.id = "Killjoys"
	self.__defaultFocus = Bootcamp
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_Operations.__onClose = function(f23_arg0)
	f23_arg0.TitleBG:close()
	f23_arg0.Title:close()
	f23_arg0.Bootcamp:close()
	f23_arg0.Killer:close()
	f23_arg0.Humiliation:close()
	f23_arg0.Precision:close()
	f23_arg0.Killjoys:close()
end
