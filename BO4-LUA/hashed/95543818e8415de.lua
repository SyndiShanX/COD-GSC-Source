CoD.SupplyChainDetailImage3d = InheritFrom(LUI.UIElement)
CoD.SupplyChainDetailImage3d.__defaultWidth = 444
CoD.SupplyChainDetailImage3d.__defaultHeight = 444
CoD.SupplyChainDetailImage3d.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainDetailImage3d)
	self.id = "SupplyChainDetailImage3d"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 444, 0, 0, 0, 444)
	FixedAspectRatioImage:setStretchedDimension(6)
	FixedAspectRatioImage:linkToElementModel(self, "popupImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local DecalImage = LUI.UIFixedAspectRatioImage.new(0, 0, 92, 352, 0, 0, 92, 352)
	DecalImage:setAlpha(0)
	DecalImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_5146ECDAC27D1842"))
	DecalImage:setShaderVector(0, 1, 0, 0, 0)
	DecalImage:setShaderVector(1, 200, 200, 0, 0)
	DecalImage:setStretchedDimension(6)
	DecalImage:linkToElementModel(self, "popupImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DecalImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(DecalImage)
	self.DecalImage = DecalImage
	self:mergeStateConditions({
		{
			stateName = "Show3DModel",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "characterRef")
			end,
		},
		{
			stateName = "Decal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", @"decal")
			end,
		},
	})
	self:linkToElementModel(self, "characterRef", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterRef",
		})
	end)
	self:linkToElementModel(self, "itemCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainDetailImage3d.__resetProperties = function(f8_arg0)
	f8_arg0.FixedAspectRatioImage:completeAnimation()
	f8_arg0.DecalImage:completeAnimation()
	f8_arg0.FixedAspectRatioImage:setAlpha(1)
	f8_arg0.DecalImage:setAlpha(0)
end
CoD.SupplyChainDetailImage3d.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.FixedAspectRatioImage:completeAnimation()
			f9_arg0.FixedAspectRatioImage:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FixedAspectRatioImage)
		end,
		reveal_common = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(1000)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.FixedAspectRatioImage:beginAnimation(500)
				f10_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.FixedAspectRatioImage:completeAnimation()
			f10_arg0.FixedAspectRatioImage:setAlpha(0)
			f10_local0(f10_arg0.FixedAspectRatioImage)
		end,
		reveal_rare = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(1000)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.FixedAspectRatioImage:beginAnimation(500)
				f13_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.FixedAspectRatioImage:completeAnimation()
			f13_arg0.FixedAspectRatioImage:setAlpha(0)
			f13_local0(f13_arg0.FixedAspectRatioImage)
		end,
		reveal_legend = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(1000)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.FixedAspectRatioImage:beginAnimation(500)
				f16_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.FixedAspectRatioImage:completeAnimation()
			f16_arg0.FixedAspectRatioImage:setAlpha(0)
			f16_local0(f16_arg0.FixedAspectRatioImage)
		end,
		reveal_epic = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(1000)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.FixedAspectRatioImage:beginAnimation(500)
				f19_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.FixedAspectRatioImage:completeAnimation()
			f19_arg0.FixedAspectRatioImage:setAlpha(0)
			f19_local0(f19_arg0.FixedAspectRatioImage)
		end,
		reveal_ultra = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.FixedAspectRatioImage:beginAnimation(500)
				f22_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.FixedAspectRatioImage:completeAnimation()
			f22_arg0.FixedAspectRatioImage:setAlpha(0)
			f22_local0(f22_arg0.FixedAspectRatioImage)
		end,
	},
	Show3DModel = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.FixedAspectRatioImage:completeAnimation()
			f25_arg0.FixedAspectRatioImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FixedAspectRatioImage)
		end,
	},
	Decal = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.FixedAspectRatioImage:completeAnimation()
			f26_arg0.FixedAspectRatioImage:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FixedAspectRatioImage)
			f26_arg0.DecalImage:completeAnimation()
			f26_arg0.DecalImage:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.DecalImage)
		end,
		reveal_common = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.FixedAspectRatioImage:completeAnimation()
			f27_arg0.FixedAspectRatioImage:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.FixedAspectRatioImage)
			local f27_local0 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(1000)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.DecalImage:beginAnimation(500)
				f27_arg0.DecalImage:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DecalImage:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f27_arg0.DecalImage:completeAnimation()
			f27_arg0.DecalImage:setAlpha(0)
			f27_local0(f27_arg0.DecalImage)
		end,
		reveal_rare = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.FixedAspectRatioImage:completeAnimation()
			f30_arg0.FixedAspectRatioImage:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.FixedAspectRatioImage)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(1000)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.DecalImage:beginAnimation(500)
				f30_arg0.DecalImage:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.DecalImage:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.DecalImage:completeAnimation()
			f30_arg0.DecalImage:setAlpha(0)
			f30_local0(f30_arg0.DecalImage)
		end,
		reveal_legend = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.FixedAspectRatioImage:completeAnimation()
			f33_arg0.FixedAspectRatioImage:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.FixedAspectRatioImage)
			local f33_local0 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(1000)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.DecalImage:beginAnimation(500)
				f33_arg0.DecalImage:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.DecalImage:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f33_arg0.DecalImage:completeAnimation()
			f33_arg0.DecalImage:setAlpha(0)
			f33_local0(f33_arg0.DecalImage)
		end,
		reveal_epic = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.FixedAspectRatioImage:completeAnimation()
			f36_arg0.FixedAspectRatioImage:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.FixedAspectRatioImage)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(1000)
					f38_arg0:setAlpha(1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.DecalImage:beginAnimation(500)
				f36_arg0.DecalImage:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.DecalImage:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.DecalImage:completeAnimation()
			f36_arg0.DecalImage:setAlpha(0)
			f36_local0(f36_arg0.DecalImage)
		end,
		reveal_ultra = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.FixedAspectRatioImage:completeAnimation()
			f39_arg0.FixedAspectRatioImage:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.FixedAspectRatioImage)
			local f39_local0 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f41_arg0:setAlpha(1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.DecalImage:beginAnimation(500)
				f39_arg0.DecalImage:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.DecalImage:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f39_arg0.DecalImage:completeAnimation()
			f39_arg0.DecalImage:setAlpha(0)
			f39_local0(f39_arg0.DecalImage)
		end,
	},
}
CoD.SupplyChainDetailImage3d.__onClose = function(f42_arg0)
	f42_arg0.FixedAspectRatioImage:close()
	f42_arg0.DecalImage:close()
end
