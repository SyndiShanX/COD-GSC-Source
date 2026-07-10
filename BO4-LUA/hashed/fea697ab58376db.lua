require("x64:1adb7a039c010da")
require("x64:3bd63addca7d158")
require("x64:f00a10fc8301da2")
require("x64:8540c1029b806a7")
require("x64:38c11a77e96e48c")
CoD.MedalsTabInternal = InheritFrom(LUI.UIElement)
CoD.MedalsTabInternal.__defaultWidth = 1920
CoD.MedalsTabInternal.__defaultHeight = 772
CoD.MedalsTabInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MedalsTabInternal)
	self.id = "MedalsTabInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0, 0, -40, 1960, 0.5, 0.5, -409, 427)
	AarMpBacking.Backer:setRGB(0, 0, 0)
	AarMpBacking.Backer:setAlpha(0.5)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local MedalPreviewWidget = CoD.MedalPreviewWidget.new(f1_arg0, f1_arg1, 0, 0, 86, 636, 0, 0, 25, 739)
	self:addElement(MedalPreviewWidget)
	self.MedalPreviewWidget = MedalPreviewWidget
	local Line = LUI.UIImage.new(0, 0, 670.5, 672.5, 0, 0, 23.5, 740.5)
	Line:setAlpha(0.05)
	Line:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Line:setShaderVector(0, 0, 0, 0, 0)
	Line:setupNineSliceShader(4, 8)
	self:addElement(Line)
	self.Line = Line
	local EmptyMedalRow3 = CoD.EmptyMedalRow.new(f1_arg0, f1_arg1, 0, 0, 708, 1826, 0, 0, 512, 739)
	EmptyMedalRow3:setAlpha(0.5)
	self:addElement(EmptyMedalRow3)
	self.EmptyMedalRow3 = EmptyMedalRow3
	local EmptyMedalRow2 = CoD.EmptyMedalRow.new(f1_arg0, f1_arg1, 0, 0, 708, 1826, 0, 0, 270, 497)
	EmptyMedalRow2:setAlpha(0.5)
	self:addElement(EmptyMedalRow2)
	self.EmptyMedalRow2 = EmptyMedalRow2
	local EmptyMedalRow1 = CoD.EmptyMedalRow.new(f1_arg0, f1_arg1, 0, 0, 708, 1826, 0, 0, 26, 253)
	EmptyMedalRow1:setAlpha(0.5)
	self:addElement(EmptyMedalRow1)
	self.EmptyMedalRow1 = EmptyMedalRow1
	local MedalsGrid = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, false, false, false, false)
	MedalsGrid:setLeftRight(0, 0, 708, 1822)
	MedalsGrid:setTopBottom(0, 0, 26.5, 737.5)
	MedalsGrid:setWidgetType(CoD.MedalsGridItem)
	MedalsGrid:setHorizontalCount(4)
	MedalsGrid:setVerticalCount(3)
	MedalsGrid:setSpacing(18)
	MedalsGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MedalsGrid:setVerticalCounter(CoD.verticalCounter)
	MedalsGrid:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MedalsGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsCurrentMenu(menu, "Barracks_Medals") then
			CoD.PlayerStatsUtility.SetShowcaseMedal(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsCurrentMenu(menu, "Barracks_Medals") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(MedalsGrid)
	self.MedalsGrid = MedalsGrid
	self:mergeStateConditions({
		{
			stateName = "NoMedals",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.MedalsGrid)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	MedalsGrid.id = "MedalsGrid"
	self.__defaultFocus = MedalsGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MedalsTabInternal.__resetProperties = function(f7_arg0)
	f7_arg0.MedalsGrid:completeAnimation()
	f7_arg0.Line:completeAnimation()
	f7_arg0.EmptyMedalRow1:completeAnimation()
	f7_arg0.EmptyMedalRow2:completeAnimation()
	f7_arg0.EmptyMedalRow3:completeAnimation()
	f7_arg0.MedalPreviewWidget:completeAnimation()
	f7_arg0.MedalsGrid:setAlpha(1)
	f7_arg0.Line:setAlpha(0.05)
	f7_arg0.EmptyMedalRow1:setAlpha(0.5)
	f7_arg0.EmptyMedalRow2:setAlpha(0.5)
	f7_arg0.EmptyMedalRow3:setAlpha(0.5)
	f7_arg0.MedalPreviewWidget:setAlpha(1)
end
CoD.MedalsTabInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(140, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.MedalPreviewWidget:beginAnimation(220)
				f8_arg0.MedalPreviewWidget:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.MedalPreviewWidget:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.MedalPreviewWidget:completeAnimation()
			f8_arg0.MedalPreviewWidget:setAlpha(0)
			f8_local0(f8_arg0.MedalPreviewWidget)
			local f8_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(99)
					f12_arg0:setAlpha(0.18)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.Line:beginAnimation(150)
				f8_arg0.Line:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Line:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f8_arg0.Line:completeAnimation()
			f8_arg0.Line:setAlpha(0)
			f8_local1(f8_arg0.Line)
			local f8_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(100)
					f14_arg0:setAlpha(0.5)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.EmptyMedalRow3:beginAnimation(170)
				f8_arg0.EmptyMedalRow3:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.EmptyMedalRow3:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f8_arg0.EmptyMedalRow3:completeAnimation()
			f8_arg0.EmptyMedalRow3:setAlpha(0)
			f8_local2(f8_arg0.EmptyMedalRow3)
			local f8_local3 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(99)
					f16_arg0:setAlpha(0.5)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.EmptyMedalRow2:beginAnimation(150)
				f8_arg0.EmptyMedalRow2:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.EmptyMedalRow2:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f8_arg0.EmptyMedalRow2:completeAnimation()
			f8_arg0.EmptyMedalRow2:setAlpha(0)
			f8_local3(f8_arg0.EmptyMedalRow2)
			local f8_local4 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(100)
					f18_arg0:setAlpha(0.5)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.EmptyMedalRow1:beginAnimation(130)
				f8_arg0.EmptyMedalRow1:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.EmptyMedalRow1:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f8_arg0.EmptyMedalRow1:completeAnimation()
			f8_arg0.EmptyMedalRow1:setAlpha(0)
			f8_local4(f8_arg0.EmptyMedalRow1)
			local f8_local5 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.MedalsGrid:beginAnimation(330)
				f8_arg0.MedalsGrid:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.MedalsGrid:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f8_arg0.MedalsGrid:completeAnimation()
			f8_arg0.MedalsGrid:setAlpha(0)
			f8_local5(f8_arg0.MedalsGrid)
		end,
	},
	NoMedals = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			f21_arg0.MedalPreviewWidget:completeAnimation()
			f21_arg0.MedalPreviewWidget:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MedalPreviewWidget)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(99)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.Line:beginAnimation(150)
				f21_arg0.Line:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Line:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.Line:completeAnimation()
			f21_arg0.Line:setAlpha(0.18)
			f21_local0(f21_arg0.Line)
			local f21_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(100)
					f25_arg0:setAlpha(0.5)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.EmptyMedalRow3:beginAnimation(170)
				f21_arg0.EmptyMedalRow3:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.EmptyMedalRow3:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.EmptyMedalRow3:completeAnimation()
			f21_arg0.EmptyMedalRow3:setAlpha(0)
			f21_local1(f21_arg0.EmptyMedalRow3)
			local f21_local2 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(99)
					f27_arg0:setAlpha(0.5)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.EmptyMedalRow2:beginAnimation(150)
				f21_arg0.EmptyMedalRow2:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.EmptyMedalRow2:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f21_arg0.EmptyMedalRow2:completeAnimation()
			f21_arg0.EmptyMedalRow2:setAlpha(0)
			f21_local2(f21_arg0.EmptyMedalRow2)
			local f21_local3 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(100)
					f29_arg0:setAlpha(0.5)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.EmptyMedalRow1:beginAnimation(130)
				f21_arg0.EmptyMedalRow1:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.EmptyMedalRow1:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f21_arg0.EmptyMedalRow1:completeAnimation()
			f21_arg0.EmptyMedalRow1:setAlpha(0)
			f21_local3(f21_arg0.EmptyMedalRow1)
			f21_arg0.MedalsGrid:completeAnimation()
			f21_arg0.MedalsGrid:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MedalsGrid)
		end,
	},
}
CoD.MedalsTabInternal.__onClose = function(f30_arg0)
	f30_arg0.AarMpBacking:close()
	f30_arg0.MedalPreviewWidget:close()
	f30_arg0.EmptyMedalRow3:close()
	f30_arg0.EmptyMedalRow2:close()
	f30_arg0.EmptyMedalRow1:close()
	f30_arg0.MedalsGrid:close()
end
