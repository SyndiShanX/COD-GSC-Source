require("x64:b3216c1e0be9717")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.Challenges_FrameWidget_Expert = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_Expert.__defaultWidth = 1560
CoD.Challenges_FrameWidget_Expert.__defaultHeight = 780
CoD.Challenges_FrameWidget_Expert.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_Expert)
	self.id = "Challenges_FrameWidget_Expert"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[0xF9F1239CFD921FE](0x892ED10E8BF4877))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(0xED0FBCBD4D7A1A8))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "expert", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local Strategist = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 227, 327)
	Strategist.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x9ADE67A378FCCC2))
	Strategist:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "strategist", function(model)
		Strategist:setModel(model, f1_arg1)
	end)
	Strategist:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Strategist, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "strategist")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Expert", controller, nil)
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
	self:addElement(Strategist)
	self.Strategist = Strategist
	local Survivalist = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	Survivalist.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0xD818E0F459A2CFA))
	Survivalist:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "survivalist", function(model)
		Survivalist:setModel(model, f1_arg1)
	end)
	Survivalist:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Survivalist, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "survivalist")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Expert", controller, nil)
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
	self:addElement(Survivalist)
	self.Survivalist = Survivalist
	local Hunter = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 3, 103)
	Hunter.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0xB31D6069443FEFE))
	Hunter:subscribeToGlobalModel(f1_arg1, "ChallengesZMCategoryStats", "hunter", function(model)
		Hunter:setModel(model, f1_arg1)
	end)
	Hunter:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Hunter, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "hunter")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_Expert", controller, nil)
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
	self:addElement(Hunter)
	self.Hunter = Hunter
	Strategist.id = "Strategist"
	Survivalist.id = "Survivalist"
	Hunter.id = "Hunter"
	self.__defaultFocus = Hunter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_Expert.__onClose = function(f15_arg0)
	f15_arg0.TitleBG:close()
	f15_arg0.Title:close()
	f15_arg0.Strategist:close()
	f15_arg0.Survivalist:close()
	f15_arg0.Hunter:close()
end
