require("x64:58c2602dc8123da")
require("x64:b1c07471dee89f6")
CoD.BountyHunterPackageTier = InheritFrom(LUI.UIElement)
CoD.BountyHunterPackageTier.__defaultWidth = 345
CoD.BountyHunterPackageTier.__defaultHeight = 127
CoD.BountyHunterPackageTier.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPackageTier)
	self.id = "BountyHunterPackageTier"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Separator = CoD.BountyHunterPackageTierSeparator.new(f1_arg0, f1_arg1, 0, 0, -28, -3, 0.5, 0.5, -57.5, 57.5)
	Separator:linkToElementModel(self, nil, false, function(model)
		Separator:setModel(model, f1_arg1)
	end)
	self:addElement(Separator)
	self.Separator = Separator
	local sizeElement = CoD.BountyHunterPackageTierInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 345, 0, 0, 0, 127)
	sizeElement:linkToElementModel(self, nil, false, function(model)
		sizeElement:setModel(model, f1_arg1)
	end)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	self:mergeStateConditions({
		{
			stateName = "OneItem",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "item3.trackTier", 0) then
					f4_local0 = not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "item2.trackTier", 0)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "TwoItems",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "item3.trackTier", 0)
			end,
		},
		{
			stateName = "ThreeItems",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "item3.trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item3.trackTier",
		})
	end)
	self:linkToElementModel(self, "item2.trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item2.trackTier",
		})
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.BountyHunterUtility.BuyBountyTierPackage(controller, menu, self)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.BountyHunterUtility.SetCurrentPreviewedPackage(self, f1_arg0)
	end)
	sizeElement.id = "sizeElement"
	self.__defaultFocus = sizeElement
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPackageTier.__resetProperties = function(f12_arg0)
	f12_arg0.sizeElement:completeAnimation()
	f12_arg0.sizeElement:setLeftRight(0, 0, 0, 345)
	f12_arg0.sizeElement:setScale(1, 1)
end
CoD.BountyHunterPackageTier.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	OneItem = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.sizeElement:completeAnimation()
			f14_arg0.sizeElement:setLeftRight(0, 0, 0, 127)
			f14_arg0.clipFinished(f14_arg0.sizeElement)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.sizeElement:completeAnimation()
			f15_arg0.sizeElement:setLeftRight(0, 0, 0, 127)
			f15_arg0.sizeElement:setScale(1.05, 1.05)
			f15_arg0.clipFinished(f15_arg0.sizeElement)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.sizeElement:beginAnimation(200)
				f16_arg0.sizeElement:setScale(1.05, 1.05)
				f16_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.sizeElement:completeAnimation()
			f16_arg0.sizeElement:setLeftRight(0, 0, 0, 127)
			f16_arg0.sizeElement:setScale(1, 1)
			f16_local0(f16_arg0.sizeElement)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.sizeElement:beginAnimation(200)
				f18_arg0.sizeElement:setScale(1, 1)
				f18_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.sizeElement:completeAnimation()
			f18_arg0.sizeElement:setLeftRight(0, 0, 0, 127)
			f18_arg0.sizeElement:setScale(1.05, 1.05)
			f18_local0(f18_arg0.sizeElement)
		end,
	},
	TwoItems = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.sizeElement:completeAnimation()
			f20_arg0.sizeElement:setLeftRight(0, 0, 0, 254)
			f20_arg0.clipFinished(f20_arg0.sizeElement)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.sizeElement:completeAnimation()
			f21_arg0.sizeElement:setLeftRight(0, 0, 0, 254)
			f21_arg0.sizeElement:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.sizeElement)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.sizeElement:beginAnimation(200)
				f22_arg0.sizeElement:setScale(1.05, 1.05)
				f22_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.sizeElement:completeAnimation()
			f22_arg0.sizeElement:setLeftRight(0, 0, 0, 254)
			f22_arg0.sizeElement:setScale(1, 1)
			f22_local0(f22_arg0.sizeElement)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.sizeElement:beginAnimation(200)
				f24_arg0.sizeElement:setScale(1, 1)
				f24_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.sizeElement:completeAnimation()
			f24_arg0.sizeElement:setLeftRight(0, 0, 0, 254)
			f24_arg0.sizeElement:setScale(1.05, 1.05)
			f24_local0(f24_arg0.sizeElement)
		end,
	},
	ThreeItems = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.sizeElement:completeAnimation()
			f27_arg0.sizeElement:setScale(1.05, 1.05)
			f27_arg0.clipFinished(f27_arg0.sizeElement)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.sizeElement:beginAnimation(200)
				f28_arg0.sizeElement:setScale(1.05, 1.05)
				f28_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.sizeElement:completeAnimation()
			f28_arg0.sizeElement:setScale(1, 1)
			f28_local0(f28_arg0.sizeElement)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.sizeElement:beginAnimation(200)
				f30_arg0.sizeElement:setScale(1, 1)
				f30_arg0.sizeElement:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.sizeElement:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.sizeElement:completeAnimation()
			f30_arg0.sizeElement:setScale(1.05, 1.05)
			f30_local0(f30_arg0.sizeElement)
		end,
	},
}
CoD.BountyHunterPackageTier.__onClose = function(f32_arg0)
	f32_arg0.Separator:close()
	f32_arg0.sizeElement:close()
end
