require("x64:6a866391524bb19")
require("x64:2090633bd0ef906")
require("x64:382df5efc337f5e")
require("x64:c39acda87d5a335")
CoD.LoadoutClassItem = InheritFrom(LUI.UIElement)
CoD.LoadoutClassItem.__defaultWidth = 356
CoD.LoadoutClassItem.__defaultHeight = 204
CoD.LoadoutClassItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadoutClassItem)
	self.id = "LoadoutClassItem"
	self.soundSet = "CAC"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrimaryHeader = CoD.CategoryHeader.new(f1_arg0, f1_arg1, 0, 0, 1, 126, 0, 0, -22, -6)
	PrimaryHeader:linkToElementModel(self, nil, false, function(model)
		PrimaryHeader:setModel(model, f1_arg1)
	end)
	self:addElement(PrimaryHeader)
	self.PrimaryHeader = PrimaryHeader
	local WildcardHighlightBottom = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 0, 3, 352, 0, 0, 170, 222)
	WildcardHighlightBottom:setAlpha(0)
	self:addElement(WildcardHighlightBottom)
	self.WildcardHighlightBottom = WildcardHighlightBottom
	local LoadoutClassItemContainer = CoD.LoadoutClassItemContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 204)
	LoadoutClassItemContainer:linkToElementModel(self, nil, false, function(model)
		LoadoutClassItemContainer:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LoadoutClassItemContainer, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		UpdateSelfState(self, controller)
	end)
	self:addElement(LoadoutClassItemContainer)
	self.LoadoutClassItemContainer = LoadoutClassItemContainer
	local WildcardSelectionAnimPrimary = CoD.CACWildcardSelectionAnimationPrimary.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, -34)
	WildcardSelectionAnimPrimary:setAlpha(0)
	self:addElement(WildcardSelectionAnimPrimary)
	self.WildcardSelectionAnimPrimary = WildcardSelectionAnimPrimary
	local WildcardHighlightTop = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 0, 3, 352, 0, 0, 170, 222)
	WildcardHighlightTop:setAlpha(0)
	WildcardHighlightTop:setZoom(10)
	self:addElement(WildcardHighlightTop)
	self.WildcardHighlightTop = WildcardHighlightTop
	self:mergeStateConditions({
		{
			stateName = "WildcardHighlightHasVariants",
			condition = function(menu, element, event)
				local f5_local0
				if not IsChildElementInState(self, "LoadoutClassItemContainer", "NoVariants") then
					f5_local0 = CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(element, f1_arg1, "BonuscardModifiedSlotEnum", "bonuscardModifier")
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "WildcardHighlight",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(element, f1_arg1, "BonuscardModifiedSlotEnum", "bonuscardModifier")
			end,
		},
		{
			stateName = "HasVariants",
			condition = function(menu, element, event)
				return not IsChildElementInState(self, "LoadoutClassItemContainer", "NoVariants")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8.BonuscardModifiedSlotEnum, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "BonuscardModifiedSlotEnum",
		})
	end, false)
	self:linkToElementModel(self, "bonuscardModifier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bonuscardModifier",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_arg0, element, f1_arg1)
	end)
	LoadoutClassItemContainer.id = "LoadoutClassItemContainer"
	self.__defaultFocus = LoadoutClassItemContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadoutClassItem.__resetProperties = function(f11_arg0)
	f11_arg0.LoadoutClassItemContainer:completeAnimation()
	f11_arg0.WildcardSelectionAnimPrimary:completeAnimation()
	f11_arg0.WildcardHighlightBottom:completeAnimation()
	f11_arg0.WildcardHighlightTop:completeAnimation()
	f11_arg0.PrimaryHeader:completeAnimation()
	f11_arg0.LoadoutClassItemContainer:setScale(1, 1)
	f11_arg0.WildcardSelectionAnimPrimary:setAlpha(0)
	f11_arg0.WildcardHighlightBottom:setAlpha(0)
	f11_arg0.WildcardHighlightTop:setAlpha(0)
	f11_arg0.PrimaryHeader:setTopBottom(0, 0, -22, -6)
end
CoD.LoadoutClassItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.LoadoutClassItemContainer:completeAnimation()
			f13_arg0.LoadoutClassItemContainer:setScale(1.02, 1.02)
			f13_arg0.clipFinished(f13_arg0.LoadoutClassItemContainer)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.LoadoutClassItemContainer:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f14_arg0.LoadoutClassItemContainer:setScale(1.02, 1.02)
				f14_arg0.LoadoutClassItemContainer:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.LoadoutClassItemContainer:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.LoadoutClassItemContainer:completeAnimation()
			f14_arg0.LoadoutClassItemContainer:setScale(1, 1)
			f14_local0(f14_arg0.LoadoutClassItemContainer)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.LoadoutClassItemContainer:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f16_arg0.LoadoutClassItemContainer:setScale(1, 1)
				f16_arg0.LoadoutClassItemContainer:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.LoadoutClassItemContainer:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.LoadoutClassItemContainer:completeAnimation()
			f16_arg0.LoadoutClassItemContainer:setScale(1.02, 1.02)
			f16_local0(f16_arg0.LoadoutClassItemContainer)
		end,
	},
	WildcardHighlightHasVariants = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.WildcardHighlightBottom:completeAnimation()
			f18_arg0.WildcardHighlightBottom:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.WildcardHighlightBottom)
			f18_arg0.WildcardSelectionAnimPrimary:completeAnimation()
			f18_arg0.WildcardSelectionAnimPrimary:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.WildcardSelectionAnimPrimary)
			f18_arg0.WildcardHighlightTop:completeAnimation()
			f18_arg0.WildcardHighlightTop:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.WildcardHighlightTop)
		end,
	},
	WildcardHighlight = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.WildcardHighlightBottom:completeAnimation()
			f19_arg0.WildcardHighlightBottom:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.WildcardHighlightBottom)
			f19_arg0.WildcardSelectionAnimPrimary:completeAnimation()
			f19_arg0.WildcardSelectionAnimPrimary:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.WildcardSelectionAnimPrimary)
			f19_arg0.WildcardHighlightTop:completeAnimation()
			f19_arg0.WildcardHighlightTop:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.WildcardHighlightTop)
		end,
	},
	HasVariants = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.PrimaryHeader:completeAnimation()
			f20_arg0.PrimaryHeader:setTopBottom(0, 0, -22, -6)
			f20_arg0.clipFinished(f20_arg0.PrimaryHeader)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.LoadoutClassItemContainer:completeAnimation()
			f21_arg0.LoadoutClassItemContainer:setScale(1.02, 1.02)
			f21_arg0.clipFinished(f21_arg0.LoadoutClassItemContainer)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.LoadoutClassItemContainer:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f22_arg0.LoadoutClassItemContainer:setScale(1.02, 1.02)
				f22_arg0.LoadoutClassItemContainer:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.LoadoutClassItemContainer:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.LoadoutClassItemContainer:completeAnimation()
			f22_arg0.LoadoutClassItemContainer:setScale(1, 1)
			f22_local0(f22_arg0.LoadoutClassItemContainer)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.LoadoutClassItemContainer:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f24_arg0.LoadoutClassItemContainer:setScale(1, 1)
				f24_arg0.LoadoutClassItemContainer:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.LoadoutClassItemContainer:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.LoadoutClassItemContainer:completeAnimation()
			f24_arg0.LoadoutClassItemContainer:setScale(1.02, 1.02)
			f24_local0(f24_arg0.LoadoutClassItemContainer)
		end,
	},
}
CoD.LoadoutClassItem.__onClose = function(f26_arg0)
	f26_arg0.PrimaryHeader:close()
	f26_arg0.WildcardHighlightBottom:close()
	f26_arg0.LoadoutClassItemContainer:close()
	f26_arg0.WildcardSelectionAnimPrimary:close()
	f26_arg0.WildcardHighlightTop:close()
end
