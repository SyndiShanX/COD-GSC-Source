require("x64:319e77b44d21cc1")
require("x64:8d904e1e00a279d")
require("x64:79fe6ac43673588")
require("x64:83b9fa839e546ff")
CoD.ChallengesFramewidgetOperationsWZ = InheritFrom(LUI.UIElement)
CoD.ChallengesFramewidgetOperationsWZ.__defaultWidth = 1560
CoD.ChallengesFramewidgetOperationsWZ.__defaultHeight = 780
CoD.ChallengesFramewidgetOperationsWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesFramewidgetOperationsWZ)
	self.id = "ChallengesFramewidgetOperationsWZ"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 525, 0.5, 0.5, -406, 406)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Title = CoD.Challenges_Category_Title.new(f1_arg0, f1_arg1, 0, 0, 112.5, 412.5, 0.5, 0.5, -300, 300)
	Title.ChallengesPercentCompleteWidgetLG.Name:setText(Engine[0xF9F1239CFD921FE](0x2177A3C9161B05A))
	Title.ChallengesPercentCompleteWidgetLG.Icon:setImage(RegisterImage(0xD3082D5670F5A86))
	Title:subscribeToGlobalModel(f1_arg1, "ChallengesWZCategoryStats", "operations", function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local Vehicular = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 115, 215)
	Vehicular.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0xD30385BBBC1DD9D))
	Vehicular:subscribeToGlobalModel(f1_arg1, "ChallengesWZCategoryStats", "vehicular", function(model)
		Vehicular:setModel(model, f1_arg1)
	end)
	Vehicular:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Vehicular, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "vehicular")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "ChallengesOperationsWZ", controller, nil)
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
	self:addElement(Vehicular)
	self.Vehicular = Vehicular
	local Heroics = CoD.ChallengesCategoryButton.new(f1_arg0, f1_arg1, 0, 0, 555, 1555, 0, 0, 0, 100)
	Heroics.ChallengesCategoryButtonInternal.Name:setText(Engine[0xF9F1239CFD921FE](0x6074D9A1B1A097D))
	Heroics:subscribeToGlobalModel(f1_arg1, "ChallengesWZCategoryStats", "heroics", function(model)
		Heroics:setModel(model, f1_arg1)
	end)
	Heroics:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Heroics, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Disabled") then
			SetGlobalModelValue("challengeCategory", "heroics")
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "ChallengesOperationsWZ", controller, nil)
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
	self:addElement(Heroics)
	self.Heroics = Heroics
	Vehicular.id = "Vehicular"
	Heroics.id = "Heroics"
	self.__defaultFocus = Heroics
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesFramewidgetOperationsWZ.__resetProperties = function(f11_arg0)
	f11_arg0.TitleBG:completeAnimation()
	f11_arg0.Title:completeAnimation()
	f11_arg0.Vehicular:completeAnimation()
	f11_arg0.Heroics:completeAnimation()
	f11_arg0.TitleBG:setAlpha(1)
	f11_arg0.Title:setAlpha(1)
	f11_arg0.Vehicular:setAlpha(1)
	f11_arg0.Heroics:setAlpha(1)
end
CoD.ChallengesFramewidgetOperationsWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.TitleBG:beginAnimation(100)
				f12_arg0.TitleBG:setAlpha(1)
				f12_arg0.TitleBG:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.TitleBG:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.TitleBG:completeAnimation()
			f12_arg0.TitleBG:setAlpha(0)
			f12_local0(f12_arg0.TitleBG)
			local f12_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(100)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.Title:beginAnimation(50)
				f12_arg0.Title:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Title:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f12_arg0.Title:completeAnimation()
			f12_arg0.Title:setAlpha(0)
			f12_local1(f12_arg0.Title)
			local f12_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(100)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.Vehicular:beginAnimation(200)
				f12_arg0.Vehicular:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Vehicular:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f12_arg0.Vehicular:completeAnimation()
			f12_arg0.Vehicular:setAlpha(0)
			f12_local2(f12_arg0.Vehicular)
			local f12_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(99)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.Heroics:beginAnimation(150)
				f12_arg0.Heroics:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Heroics:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f12_arg0.Heroics:completeAnimation()
			f12_arg0.Heroics:setAlpha(0)
			f12_local3(f12_arg0.Heroics)
		end,
	},
}
CoD.ChallengesFramewidgetOperationsWZ.__onClose = function(f20_arg0)
	f20_arg0.TitleBG:close()
	f20_arg0.Title:close()
	f20_arg0.Vehicular:close()
	f20_arg0.Heroics:close()
end
