CoD.WZAARBlur = InheritFrom(LUI.UIElement)
CoD.WZAARBlur.__defaultWidth = 1920
CoD.WZAARBlur.__defaultHeight = 1080
CoD.WZAARBlur.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.warzone.aarVisible", false)
	self:setClass(CoD.WZAARBlur)
	self.id = "WZAARBlur"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurWZAAR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurWZAAR:setAlpha(0)
	BlurWZAAR:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurWZAAR:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurWZAAR)
	self.BlurWZAAR = BlurWZAAR
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.warzone.aarVisible")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.warzone.aarVisible"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.warzone.aarVisible",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAARBlur.__resetProperties = function(f4_arg0)
	f4_arg0.BlurWZAAR:completeAnimation()
	f4_arg0.BlurWZAAR:setAlpha(0)
end
CoD.WZAARBlur.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Visible = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.BlurWZAAR:beginAnimation(200)
				f6_arg0.BlurWZAAR:setAlpha(1)
				f6_arg0.BlurWZAAR:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.BlurWZAAR:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.BlurWZAAR:completeAnimation()
			f6_arg0.BlurWZAAR:setAlpha(0)
			f6_local0(f6_arg0.BlurWZAAR)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.BlurWZAAR:completeAnimation()
			f8_arg0.BlurWZAAR:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.BlurWZAAR)
		end,
		DefaultState = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.BlurWZAAR:beginAnimation(200)
				f9_arg0.BlurWZAAR:setAlpha(0)
				f9_arg0.BlurWZAAR:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.BlurWZAAR:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.BlurWZAAR:completeAnimation()
			f9_arg0.BlurWZAAR:setAlpha(1)
			f9_local0(f9_arg0.BlurWZAAR)
		end,
	},
}
