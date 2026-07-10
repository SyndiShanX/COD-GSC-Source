CoD.Hud_ZM_Flare_Multiplier = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Flare_Multiplier.__defaultWidth = 912
CoD.Hud_ZM_Flare_Multiplier.__defaultHeight = 561
CoD.Hud_ZM_Flare_Multiplier.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_Flare_Multiplier)
	self.id = "Hud_ZM_Flare_Multiplier"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local flare12 = LUI.UIImage.new(0, 0, -253, 984, 0, 0, -190, 571)
	flare12:setImage(RegisterImage(@"blacktransparent"))
	flare12:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_animated_add"))
	flare12:setShaderVector(0, 24, 0, 0, 0)
	flare12:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(flare12)
	self.flare12 = flare12
	self:mergeStateConditions({
		{
			stateName = "Multiplier100",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 100)
			end,
		},
		{
			stateName = "Multiplier75",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 75)
			end,
		},
		{
			stateName = "Multiplier50",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 50)
			end,
		},
		{
			stateName = "Multiplier25",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 25)
			end,
		},
		{
			stateName = "Multiplier0",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 2)
			end,
		},
	})
	self:linkToElementModel(self, "multiplier_count", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "multiplier_count",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_Flare_Multiplier.__resetProperties = function(f8_arg0)
	f8_arg0.flare12:completeAnimation()
	f8_arg0.flare12:setAlpha(1)
	f8_arg0.flare12:setImage(RegisterImage(@"blacktransparent"))
	f8_arg0.flare12:setShaderVector(0, 24, 0, 0, 0)
	f8_arg0.flare12:setShaderVector(1, 0, 0, 0, 0)
end
CoD.Hud_ZM_Flare_Multiplier.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.flare12:completeAnimation()
			f9_arg0.flare12:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.flare12)
		end,
	},
	Multiplier100 = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.flare12:completeAnimation()
			f10_arg0.flare12:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.flare12)
		end,
	},
	Multiplier75 = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.flare12:completeAnimation()
			f11_arg0.flare12:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.flare12)
		end,
		Multiplier100 = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.flare12:beginAnimation(1000)
				f12_arg0.flare12:setShaderVector(1, 24, 0, 0, 0)
				f12_arg0.flare12:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.flare12:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.flare12:completeAnimation()
			f12_arg0.flare12:setImage(RegisterImage(@"blacktransparent"))
			f12_arg0.flare12:setShaderVector(0, 24, 0, 0, 0)
			f12_arg0.flare12:setShaderVector(1, 0, 0, 0, 0)
			f12_local0(f12_arg0.flare12)
		end,
	},
	Multiplier50 = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.flare12:completeAnimation()
			f14_arg0.flare12:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.flare12)
		end,
		Multiplier75 = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.flare12:beginAnimation(1000)
				f15_arg0.flare12:setShaderVector(1, 24, 0, 0, 0)
				f15_arg0.flare12:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.flare12:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.flare12:completeAnimation()
			f15_arg0.flare12:setShaderVector(0, 24, 0, 0, 0)
			f15_arg0.flare12:setShaderVector(1, 0, 0, 0, 0)
			f15_local0(f15_arg0.flare12)
		end,
	},
	Multiplier25 = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.flare12:completeAnimation()
			f17_arg0.flare12:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.flare12)
		end,
		Multiplier50 = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.flare12:beginAnimation(1000)
				f18_arg0.flare12:setShaderVector(1, 24, 0, 0, 0)
				f18_arg0.flare12:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.flare12:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.flare12:completeAnimation()
			f18_arg0.flare12:setShaderVector(0, 24, 0, 0, 0)
			f18_arg0.flare12:setShaderVector(1, 0, 0, 0, 0)
			f18_local0(f18_arg0.flare12)
		end,
	},
	Multiplier0 = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.flare12:completeAnimation()
			f20_arg0.flare12:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.flare12)
		end,
		Multiplier25 = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.flare12:beginAnimation(1000)
				f21_arg0.flare12:setShaderVector(1, 24, 0, 0, 0)
				f21_arg0.flare12:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.flare12:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.flare12:completeAnimation()
			f21_arg0.flare12:setShaderVector(0, 24, 0, 0, 0)
			f21_arg0.flare12:setShaderVector(1, 0, 0, 0, 0)
			f21_local0(f21_arg0.flare12)
		end,
	},
}
