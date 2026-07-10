CoD.SupplyChainItemUnlockedRecently = InheritFrom(LUI.UIElement)
CoD.SupplyChainItemUnlockedRecently.__defaultWidth = 140
CoD.SupplyChainItemUnlockedRecently.__defaultHeight = 158
CoD.SupplyChainItemUnlockedRecently.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainItemUnlockedRecently)
	self.id = "SupplyChainItemUnlockedRecently"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusBorder = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FocusBorder:setRGB(0.78, 0.91, 1)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local GlowBorder = LUI.UIImage.new(0.02, 0.98, -34, 34, 0.06, 0.94, -34, 34)
	GlowBorder:setRGB(0.29, 0.48, 0.62)
	GlowBorder:setAlpha(0)
	GlowBorder:setImage(RegisterImage(0x254D6690EDE327D))
	GlowBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	GlowBorder:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder:setupNineSliceShader(70, 70)
	self:addElement(GlowBorder)
	self.GlowBorder = GlowBorder
	local GlowBorder2 = LUI.UIImage.new(0, 1, -4.5, 3.5, 0, 1, -4, 4)
	GlowBorder2:setRGB(0.89, 0.98, 0.99)
	GlowBorder2:setAlpha(0)
	GlowBorder2:setImage(RegisterImage(0x254D6690EDE327D))
	GlowBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	GlowBorder2:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder2:setupNineSliceShader(12, 12)
	self:addElement(GlowBorder2)
	self.GlowBorder2 = GlowBorder2
	self:mergeStateConditions({
		{
			stateName = "RecentlyUnlocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "recentlyUnlocked")
			end,
		},
	})
	self:linkToElementModel(self, "recentlyUnlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "recentlyUnlocked",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainItemUnlockedRecently.__resetProperties = function(f4_arg0)
	f4_arg0.FocusBorder:completeAnimation()
	f4_arg0.GlowBorder2:completeAnimation()
	f4_arg0.GlowBorder:completeAnimation()
	f4_arg0.FocusBorder:setAlpha(0)
	f4_arg0.GlowBorder2:setAlpha(0)
	f4_arg0.GlowBorder:setAlpha(0)
end
CoD.SupplyChainItemUnlockedRecently.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.FocusBorder:completeAnimation()
			f5_arg0.FocusBorder:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FocusBorder)
		end,
	},
	RecentlyUnlocked = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.FocusBorder:completeAnimation()
			f6_arg0.FocusBorder:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FocusBorder)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1500)
					f8_arg0:setAlpha(0.2)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.GlowBorder:beginAnimation(1500)
				f6_arg0.GlowBorder:setAlpha(1)
				f6_arg0.GlowBorder:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.GlowBorder:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.GlowBorder:completeAnimation()
			f6_arg0.GlowBorder:setAlpha(0.2)
			f6_local0(f6_arg0.GlowBorder)
			local f6_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1500)
					f10_arg0:setAlpha(0.2)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.GlowBorder2:beginAnimation(1500)
				f6_arg0.GlowBorder2:setAlpha(1)
				f6_arg0.GlowBorder2:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.GlowBorder2:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f6_arg0.GlowBorder2:completeAnimation()
			f6_arg0.GlowBorder2:setAlpha(0.2)
			f6_local1(f6_arg0.GlowBorder2)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
}
