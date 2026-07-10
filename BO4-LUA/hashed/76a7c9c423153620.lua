require("x64:228a7baa572b047")
require("x64:5f8cf56752aa71b")
CoD.InspectCallingCardWidgetInternal = InheritFrom(LUI.UIElement)
CoD.InspectCallingCardWidgetInternal.__defaultWidth = 348
CoD.InspectCallingCardWidgetInternal.__defaultHeight = 87
CoD.InspectCallingCardWidgetInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectCallingCardWidgetInternal)
	self.id = "InspectCallingCardWidgetInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledBackingImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBackingImage:setAlpha(0.5)
	TiledBackingImage:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingImage:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingImage:setupNineSliceShader(64, 64)
	self:addElement(TiledBackingImage)
	self.TiledBackingImage = TiledBackingImage
	local ButtonPlusImage = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	ButtonPlusImage:setImage(RegisterImage(@"uie_ui_menu_cac_button_add_plus"))
	self:addElement(ButtonPlusImage)
	self.ButtonPlusImage = ButtonPlusImage
	local ButtonPlusImageFocused = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	ButtonPlusImageFocused:setAlpha(0)
	ButtonPlusImageFocused:setImage(RegisterImage(@"uie_ui_menu_cac_button_add_plus_highlighted"))
	ButtonPlusImageFocused:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ButtonPlusImageFocused:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ButtonPlusImageFocused)
	self.ButtonPlusImageFocused = ButtonPlusImageFocused
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CallingCardsFrameWidget:linkToElementModel(self, "callingCard", false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local CallingCardName = LUI.UIText.new(0, 0, 6.5, 343.5, 0, 0, 68, 83)
	CallingCardName:setTTF("ttmussels_regular")
	CallingCardName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	CallingCardName:setBackingType(2)
	CallingCardName:setBackingColor(0, 0, 0)
	CallingCardName:setBackingAlpha(0.7)
	CallingCardName:setBackingXPadding(2)
	CallingCardName:setBackingYPadding(2)
	CallingCardName:linkToElementModel(self, "callingCard.title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CallingCardName:setText(f3_local0)
		end
	end)
	self:addElement(CallingCardName)
	self.CallingCardName = CallingCardName
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "callingCard.iconId", 0)
			end,
		},
	})
	self:linkToElementModel(self, "callingCard.iconId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "callingCard.iconId",
		})
	end)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectCallingCardWidgetInternal.__resetProperties = function(f6_arg0)
	f6_arg0.ButtonPlusImage:completeAnimation()
	f6_arg0.CallingCardsFrameWidget:completeAnimation()
	f6_arg0.CallingCardName:completeAnimation()
	f6_arg0.ButtonPlusImageFocused:completeAnimation()
	f6_arg0.ButtonPlusImage:setAlpha(1)
	f6_arg0.CallingCardsFrameWidget:setAlpha(1)
	f6_arg0.CallingCardName:setAlpha(1)
	f6_arg0.ButtonPlusImageFocused:setAlpha(0)
end
CoD.InspectCallingCardWidgetInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ButtonPlusImage:completeAnimation()
			f7_arg0.ButtonPlusImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ButtonPlusImage)
		end,
	},
	Empty = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.CallingCardsFrameWidget:completeAnimation()
			f8_arg0.CallingCardsFrameWidget:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CallingCardsFrameWidget)
			f8_arg0.CallingCardName:completeAnimation()
			f8_arg0.CallingCardName:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CallingCardName)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.ButtonPlusImageFocused:completeAnimation()
			f9_arg0.ButtonPlusImageFocused:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ButtonPlusImageFocused)
			f9_arg0.CallingCardsFrameWidget:completeAnimation()
			f9_arg0.CallingCardsFrameWidget:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CallingCardsFrameWidget)
			f9_arg0.CallingCardName:completeAnimation()
			f9_arg0.CallingCardName:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CallingCardName)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				f10_arg0.ButtonPlusImageFocused:beginAnimation(150)
				f10_arg0.ButtonPlusImageFocused:setAlpha(1)
				f10_arg0.ButtonPlusImageFocused:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ButtonPlusImageFocused:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ButtonPlusImageFocused:completeAnimation()
			f10_arg0.ButtonPlusImageFocused:setAlpha(0)
			f10_local0(f10_arg0.ButtonPlusImageFocused)
			f10_arg0.CallingCardsFrameWidget:completeAnimation()
			f10_arg0.CallingCardsFrameWidget:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CallingCardsFrameWidget)
			f10_arg0.CallingCardName:completeAnimation()
			f10_arg0.CallingCardName:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CallingCardName)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ButtonPlusImageFocused:beginAnimation(100)
				f12_arg0.ButtonPlusImageFocused:setAlpha(0)
				f12_arg0.ButtonPlusImageFocused:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ButtonPlusImageFocused:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ButtonPlusImageFocused:completeAnimation()
			f12_arg0.ButtonPlusImageFocused:setAlpha(1)
			f12_local0(f12_arg0.ButtonPlusImageFocused)
			f12_arg0.CallingCardsFrameWidget:completeAnimation()
			f12_arg0.CallingCardsFrameWidget:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CallingCardsFrameWidget)
			f12_arg0.CallingCardName:completeAnimation()
			f12_arg0.CallingCardName:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CallingCardName)
		end,
	},
}
CoD.InspectCallingCardWidgetInternal.__onClose = function(f14_arg0)
	f14_arg0.CallingCardsFrameWidget:close()
	f14_arg0.CallingCardName:close()
	f14_arg0.CommonButtonOutline:close()
end
