CoD.AARStatTypeTabHeader = InheritFrom(LUI.UIElement)
CoD.AARStatTypeTabHeader.__defaultWidth = 200
CoD.AARStatTypeTabHeader.__defaultHeight = 18
CoD.AARStatTypeTabHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "_useLocalSize", true)
	self:setClass(CoD.AARStatTypeTabHeader)
	self.id = "AARStatTypeTabHeader"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatName = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 0.5, 18.5)
	StatName:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	StatName:setTTF("ttmussels_regular")
	StatName:setLetterSpacing(3)
	StatName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	StatName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	StatName:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StatName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(StatName, "setText", function(element, controller)
		ScaleWidgetToLabelCentered(self, element, 30)
	end)
	self:addElement(StatName)
	self.StatName = StatName
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.PCUtility.ActiveParentElementGrid(self, menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARStatTypeTabHeader.__resetProperties = function(f6_arg0)
	f6_arg0.StatName:completeAnimation()
	f6_arg0.StatName:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	f6_arg0.StatName:setAlpha(1)
end
CoD.AARStatTypeTabHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.StatName:completeAnimation()
			f7_arg0.StatName:setAlpha(0.25)
			f7_arg0.clipFinished(f7_arg0.StatName)
		end,
		StaggeredIntro = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(200)
					f10_arg0:setAlpha(0.25)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.StatName:beginAnimation(200)
				f8_arg0.StatName:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StatName:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.StatName:completeAnimation()
			f8_arg0.StatName:setAlpha(0)
			f8_local0(f8_arg0.StatName)
		end,
		StaggeredIntroActive = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(200)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.StatName:beginAnimation(200)
				f11_arg0.StatName:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.StatName:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.StatName:completeAnimation()
			f11_arg0.StatName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f11_arg0.StatName:setAlpha(0)
			f11_local0(f11_arg0.StatName)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.StatName:beginAnimation(150)
				f14_arg0.StatName:setAlpha(1)
				f14_arg0.StatName:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.StatName:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.StatName:completeAnimation()
			f14_arg0.StatName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f14_arg0.StatName:setAlpha(0.25)
			f14_local0(f14_arg0.StatName)
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.StatName:beginAnimation(200)
				f16_arg0.StatName:setAlpha(1)
				f16_arg0.StatName:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.StatName:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.StatName:completeAnimation()
			f16_arg0.StatName:setAlpha(0.25)
			f16_local0(f16_arg0.StatName)
		end,
	},
}
if not CoD.isPC then
	CoD.AARStatTypeTabHeader.__clipsPerState.DefaultState.Focus = nil
end
CoD.AARStatTypeTabHeader.__onClose = function(f18_arg0)
	f18_arg0.StatName:close()
end
