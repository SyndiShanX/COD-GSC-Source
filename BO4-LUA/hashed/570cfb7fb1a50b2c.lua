CoD.JobFeedItemBackground = InheritFrom(LUI.UIElement)
CoD.JobFeedItemBackground.__defaultWidth = 128
CoD.JobFeedItemBackground.__defaultHeight = 128
CoD.JobFeedItemBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.JobFeedItemBackground)
	self.id = "JobFeedItemBackground"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	Glow:setScale(1.2, 1.2)
	Glow:setImage(RegisterImage(0xC3CC344D703240E))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	self:mergeStateConditions({
		{
			stateName = "IsActiveMultiKill",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isActiveMultiKill")
			end,
		},
	})
	self:linkToElementModel(self, "isActiveMultiKill", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isActiveMultiKill",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.JobFeedItemBackground.__resetProperties = function(f4_arg0)
	f4_arg0.Glow:completeAnimation()
	f4_arg0.Glow:setAlpha(1)
end
CoD.JobFeedItemBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Glow:completeAnimation()
			f5_arg0.Glow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Glow)
		end,
		IsActiveMultiKill = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Glow:beginAnimation(200)
				f6_arg0.Glow:setAlpha(1)
				f6_arg0.Glow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Glow:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Glow:completeAnimation()
			f6_arg0.Glow:setAlpha(0)
			f6_local0(f6_arg0.Glow)
		end,
	},
	IsActiveMultiKill = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Glow:completeAnimation()
			f8_arg0.Glow:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Glow)
		end,
		DefaultState = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Glow:beginAnimation(200)
				f9_arg0.Glow:setAlpha(0)
				f9_arg0.Glow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Glow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Glow:completeAnimation()
			f9_arg0.Glow:setAlpha(1)
			f9_local0(f9_arg0.Glow)
		end,
	},
}
