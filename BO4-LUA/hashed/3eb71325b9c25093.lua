CoD.MultiItemPickupItemBacking = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupItemBacking.__defaultWidth = 112
CoD.MultiItemPickupItemBacking.__defaultHeight = 112
CoD.MultiItemPickupItemBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MultiItemPickupItemBacking)
	self.id = "MultiItemPickupItemBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blurPC = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.02, 0.98, 0, 0)
	blurPC:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blurPC:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurPC)
	self.blurPC = blurPC
	local Backing = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.02, 0.98, 0, 0)
	Backing:setRGB(0.04, 0.04, 0.04)
	Backing:setAlpha(0.75)
	self:addElement(Backing)
	self.Backing = Backing
	local TiledBacking = LUI.UIImage.new(0.02, 0.98, 0, 0, 0.02, 0.98, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local FrameSelected = LUI.UIImage.new(0.08, 0.92, -10, 10, 0.08, 0.92, -10, 10)
	FrameSelected:setAlpha(0)
	FrameSelected:setScale(0.96, 0.96)
	FrameSelected:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrameSelected:setupNineSliceShader(4, 4)
	self:addElement(FrameSelected)
	self.FrameSelected = FrameSelected
	local FrontendFrame = LUI.UIImage.new(0.02, 0.98, -1, 1, 0.02, 0.98, -1, 1)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local FrameSelectedCorner = LUI.UIImage.new(0.04, 0.96, -10, 10, 0.04, 0.96, -10, 10)
	FrameSelectedCorner:setAlpha(0)
	FrameSelectedCorner:setImage(RegisterImage(0x793C73633F620BB))
	FrameSelectedCorner:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameSelectedCorner:setShaderVector(0, 0, 0, 0, 0)
	FrameSelectedCorner:setupNineSliceShader(22, 22)
	self:addElement(FrameSelectedCorner)
	self.FrameSelectedCorner = FrameSelectedCorner
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDummy")
			end,
		},
		{
			stateName = "Outer",
			condition = function(menu, element, event)
				return not CoD.GridAndListUtility.IsElementWithinIndexOfActiveElement(element, 1)
			end,
		},
		{
			stateName = "Inner",
			condition = function(menu, element, event)
				return not CoD.GridAndListUtility.IsElementWithinIndexOfActiveElement(element, 0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "isDummy", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDummy",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MultiItemPickupItemBacking.__resetProperties = function(f9_arg0)
	f9_arg0.FrameSelectedCorner:completeAnimation()
	f9_arg0.Backing:completeAnimation()
	f9_arg0.FrameSelected:completeAnimation()
	f9_arg0.FrameSelectedCorner:setAlpha(0)
	f9_arg0.FrameSelectedCorner:setScale(1, 1)
	f9_arg0.Backing:setRGB(0.04, 0.04, 0.04)
	f9_arg0.Backing:setAlpha(0.75)
	f9_arg0.FrameSelected:setAlpha(0)
end
CoD.MultiItemPickupItemBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f11_arg0.Backing:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.FrameSelected:completeAnimation()
			f11_arg0.FrameSelected:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FrameSelected)
			f11_arg0.FrameSelectedCorner:completeAnimation()
			f11_arg0.FrameSelectedCorner:setAlpha(1)
			f11_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f11_arg0.clipFinished(f11_arg0.FrameSelectedCorner)
		end,
		GainFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Backing:beginAnimation(140)
				f12_arg0.Backing:setRGB(0.65, 0.64, 0.61)
				f12_arg0.Backing:setAlpha(0.1)
				f12_arg0.Backing:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Backing:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setRGB(0.11, 0.11, 0.11)
			f12_arg0.Backing:setAlpha(0.9)
			f12_local0(f12_arg0.Backing)
			local f12_local1 = function(f14_arg0)
				f12_arg0.FrameSelected:beginAnimation(140)
				f12_arg0.FrameSelected:setAlpha(1)
				f12_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrameSelected:completeAnimation()
			f12_arg0.FrameSelected:setAlpha(0)
			f12_local1(f12_arg0.FrameSelected)
			local f12_local2 = function(f15_arg0)
				f12_arg0.FrameSelectedCorner:beginAnimation(140)
				f12_arg0.FrameSelectedCorner:setAlpha(1)
				f12_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
				f12_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrameSelectedCorner:completeAnimation()
			f12_arg0.FrameSelectedCorner:setAlpha(0)
			f12_arg0.FrameSelectedCorner:setScale(1, 1)
			f12_local2(f12_arg0.FrameSelectedCorner)
		end,
		LoseFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Backing:beginAnimation(140)
				f16_arg0.Backing:setRGB(0.11, 0.11, 0.11)
				f16_arg0.Backing:setAlpha(0.9)
				f16_arg0.Backing:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Backing:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f16_arg0.Backing:setAlpha(0.1)
			f16_local0(f16_arg0.Backing)
			local f16_local1 = function(f18_arg0)
				f16_arg0.FrameSelected:beginAnimation(140)
				f16_arg0.FrameSelected:setAlpha(0)
				f16_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.FrameSelected:completeAnimation()
			f16_arg0.FrameSelected:setAlpha(1)
			f16_local1(f16_arg0.FrameSelected)
			local f16_local2 = function(f19_arg0)
				f16_arg0.FrameSelectedCorner:beginAnimation(140)
				f16_arg0.FrameSelectedCorner:setAlpha(0)
				f16_arg0.FrameSelectedCorner:setScale(1, 1)
				f16_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.FrameSelectedCorner:completeAnimation()
			f16_arg0.FrameSelectedCorner:setAlpha(1)
			f16_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f16_local2(f16_arg0.FrameSelectedCorner)
		end,
	},
	KBM = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.Backing:completeAnimation()
			f21_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f21_arg0.Backing:setAlpha(0.1)
			f21_arg0.clipFinished(f21_arg0.Backing)
			f21_arg0.FrameSelected:completeAnimation()
			f21_arg0.FrameSelected:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FrameSelected)
			f21_arg0.FrameSelectedCorner:completeAnimation()
			f21_arg0.FrameSelectedCorner:setAlpha(1)
			f21_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f21_arg0.clipFinished(f21_arg0.FrameSelectedCorner)
		end,
		GainFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.Backing:beginAnimation(140)
				f22_arg0.Backing:setRGB(0.65, 0.64, 0.61)
				f22_arg0.Backing:setAlpha(0.1)
				f22_arg0.Backing:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Backing:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Backing:completeAnimation()
			f22_arg0.Backing:setRGB(0.04, 0.04, 0.04)
			f22_arg0.Backing:setAlpha(0.7)
			f22_local0(f22_arg0.Backing)
			local f22_local1 = function(f24_arg0)
				f22_arg0.FrameSelected:beginAnimation(140)
				f22_arg0.FrameSelected:setAlpha(1)
				f22_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrameSelected:completeAnimation()
			f22_arg0.FrameSelected:setAlpha(0)
			f22_local1(f22_arg0.FrameSelected)
			local f22_local2 = function(f25_arg0)
				f22_arg0.FrameSelectedCorner:beginAnimation(140)
				f22_arg0.FrameSelectedCorner:setAlpha(1)
				f22_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
				f22_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FrameSelectedCorner:completeAnimation()
			f22_arg0.FrameSelectedCorner:setAlpha(0)
			f22_arg0.FrameSelectedCorner:setScale(1, 1)
			f22_local2(f22_arg0.FrameSelectedCorner)
		end,
		LoseFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			local f26_local0 = function(f27_arg0)
				f26_arg0.Backing:beginAnimation(140)
				f26_arg0.Backing:setRGB(0.04, 0.04, 0.04)
				f26_arg0.Backing:setAlpha(0.7)
				f26_arg0.Backing:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Backing:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Backing:completeAnimation()
			f26_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f26_arg0.Backing:setAlpha(0.1)
			f26_local0(f26_arg0.Backing)
			local f26_local1 = function(f28_arg0)
				f26_arg0.FrameSelected:beginAnimation(140)
				f26_arg0.FrameSelected:setAlpha(0)
				f26_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FrameSelected:completeAnimation()
			f26_arg0.FrameSelected:setAlpha(1)
			f26_local1(f26_arg0.FrameSelected)
			local f26_local2 = function(f29_arg0)
				f26_arg0.FrameSelectedCorner:beginAnimation(140)
				f26_arg0.FrameSelectedCorner:setAlpha(0)
				f26_arg0.FrameSelectedCorner:setScale(1, 1)
				f26_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FrameSelectedCorner:completeAnimation()
			f26_arg0.FrameSelectedCorner:setAlpha(1)
			f26_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f26_local2(f26_arg0.FrameSelectedCorner)
		end,
	},
	Disabled = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	Outer = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
	Inner = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
}
