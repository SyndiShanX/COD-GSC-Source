CoD.grenadeWarningImage = InheritFrom(LUI.UIElement)
CoD.grenadeWarningImage.__defaultWidth = 105
CoD.grenadeWarningImage.__defaultHeight = 105
CoD.grenadeWarningImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.grenadeWarningImage)
	self.id = "grenadeWarningImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			image:setImage(f2_local0)
		end
	end)
	self:addElement(image)
	self.image = image
	self:mergeStateConditions({
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "timeLeftPercent", 0.9)
			end,
		},
	})
	self:linkToElementModel(self, "timeLeftPercent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "timeLeftPercent",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.grenadeWarningImage.__resetProperties = function(f5_arg0)
	f5_arg0.image:completeAnimation()
	f5_arg0.image:setLeftRight(0, 1, 0, 0)
	f5_arg0.image:setTopBottom(0, 1, 0, 0)
	f5_arg0.image:setRGB(1, 1, 1)
	f5_arg0.image:setAlpha(1)
end
CoD.grenadeWarningImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(400)
					f8_arg0:setAlpha(0.6)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.image:beginAnimation(400)
				f6_arg0.image:setAlpha(1)
				f6_arg0.image:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.image:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.image:completeAnimation()
			f6_arg0.image:setAlpha(0.6)
			f6_local0(f6_arg0.image)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
	Warning = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(119)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.image:beginAnimation(200)
				f9_arg0.image:setAlpha(0.8)
				f9_arg0.image:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.image:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.image:completeAnimation()
			f9_arg0.image:setLeftRight(0, 1, 0, 0)
			f9_arg0.image:setTopBottom(0, 1, 0, 0)
			f9_arg0.image:setRGB(1, 0, 0)
			f9_arg0.image:setAlpha(1)
			f9_local0(f9_arg0.image)
		end,
	},
}
CoD.grenadeWarningImage.__onClose = function(f12_arg0)
	f12_arg0.image:close()
end
