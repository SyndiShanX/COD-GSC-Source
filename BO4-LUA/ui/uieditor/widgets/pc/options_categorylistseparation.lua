CoD.Options_CategoryListSeparation = InheritFrom(LUI.UIElement)
CoD.Options_CategoryListSeparation.__defaultWidth = 673
CoD.Options_CategoryListSeparation.__defaultHeight = 50
CoD.Options_CategoryListSeparation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Options_CategoryListSeparation)
	self.id = "Options_CategoryListSeparation"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CategoryName = LUI.UIText.new(0, 0, 56, 256, 1, 1, -25, 0)
	CategoryName:setRGB(0.76, 0.76, 0.76)
	CategoryName:setAlpha(0.3)
	CategoryName:setTTF("ttmussels_regular")
	CategoryName:setLetterSpacing(5)
	CategoryName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(CategoryName)
	self.CategoryName = CategoryName
	local Number = LUI.UIText.new(0, 0, 34, 79, 1, 1, -25, 0)
	Number:setRGB(0.47, 0.47, 0.47)
	Number:setAlpha(0.3)
	Number:setTTF("ttmussels_regular")
	Number:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Number:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Number:linkToElementModel(self, "categoryId", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Number:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	self:addElement(Number)
	self.Number = Number
	self.CategoryName:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CategoryName:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Highlight",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(self, f1_arg1, "PC.CurrentCategory", "categoryId")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["PC.CurrentCategory"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "PC.CurrentCategory",
		})
	end, false)
	self:linkToElementModel(self, "categoryId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "categoryId",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	DisableKeyboardNavigationByElement(self)
	return self
end
CoD.Options_CategoryListSeparation.__resetProperties = function(f7_arg0)
	f7_arg0.CategoryName:completeAnimation()
	f7_arg0.Number:completeAnimation()
	f7_arg0.CategoryName:setRGB(0.76, 0.76, 0.76)
	f7_arg0.CategoryName:setAlpha(0.3)
	f7_arg0.Number:setAlpha(0.3)
end
CoD.Options_CategoryListSeparation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.CategoryName:completeAnimation()
			f8_arg0.CategoryName:setAlpha(0.3)
			f8_arg0.clipFinished(f8_arg0.CategoryName)
			f8_arg0.Number:completeAnimation()
			f8_arg0.Number:setAlpha(0.3)
			f8_arg0.clipFinished(f8_arg0.Number)
		end,
		Highlight = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.CategoryName:beginAnimation(150)
				f9_arg0.CategoryName:setAlpha(1)
				f9_arg0.CategoryName:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.CategoryName:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.CategoryName:completeAnimation()
			f9_arg0.CategoryName:setRGB(0.76, 0.76, 0.76)
			f9_arg0.CategoryName:setAlpha(0.3)
			f9_local0(f9_arg0.CategoryName)
			local f9_local1 = function(f11_arg0)
				f9_arg0.Number:beginAnimation(150)
				f9_arg0.Number:setAlpha(1)
				f9_arg0.Number:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Number:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Number:completeAnimation()
			f9_arg0.Number:setAlpha(0.3)
			f9_local1(f9_arg0.Number)
		end,
	},
	Highlight = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.CategoryName:completeAnimation()
			f12_arg0.CategoryName:setRGB(0.76, 0.76, 0.76)
			f12_arg0.CategoryName:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CategoryName)
			f12_arg0.Number:completeAnimation()
			f12_arg0.Number:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Number)
		end,
		DefaultState = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CategoryName:beginAnimation(150)
				f13_arg0.CategoryName:setAlpha(0.3)
				f13_arg0.CategoryName:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CategoryName:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CategoryName:completeAnimation()
			f13_arg0.CategoryName:setRGB(0.76, 0.76, 0.76)
			f13_arg0.CategoryName:setAlpha(1)
			f13_local0(f13_arg0.CategoryName)
			local f13_local1 = function(f15_arg0)
				f13_arg0.Number:beginAnimation(150)
				f13_arg0.Number:setAlpha(0.3)
				f13_arg0.Number:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Number:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Number:completeAnimation()
			f13_arg0.Number:setAlpha(1)
			f13_local1(f13_arg0.Number)
		end,
	},
}
CoD.Options_CategoryListSeparation.__onClose = function(f16_arg0)
	f16_arg0.CategoryName:close()
	f16_arg0.Number:close()
end
