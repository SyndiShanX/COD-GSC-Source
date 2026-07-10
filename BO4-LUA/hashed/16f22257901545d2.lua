CoD.ZMPowerUpIcon = InheritFrom(LUI.UIElement)
CoD.ZMPowerUpIcon.__defaultWidth = 72
CoD.ZMPowerUpIcon.__defaultHeight = 72
CoD.ZMPowerUpIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMPowerUpIcon)
	self.id = "ZMPowerUpIcon"
	self.soundSet = "FriendsMenu"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local icon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	icon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(icon)
	self.icon = icon
	self:mergeStateConditions({
		{
			stateName = "FlashingOff",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "state", CoD.ZombieUtility.PowerUps.STATE_FLASHING_OFF)
			end,
		},
		{
			stateName = "FlashingOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "state", CoD.ZombieUtility.PowerUps.STATE_FLASHING_ON)
			end,
		},
	})
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMPowerUpIcon.__resetProperties = function(f6_arg0)
	f6_arg0.icon:completeAnimation()
	f6_arg0.icon:setAlpha(1)
end
CoD.ZMPowerUpIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		FlashingOff = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.icon:beginAnimation(500)
				f8_arg0.icon:setAlpha(0)
				f8_arg0.icon:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.icon:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.icon:completeAnimation()
			f8_arg0.icon:setAlpha(1)
			f8_local0(f8_arg0.icon)
		end,
	},
	FlashingOff = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.icon:completeAnimation()
			f10_arg0.icon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.icon)
		end,
		FlashingOn = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.icon:beginAnimation(100)
				f11_arg0.icon:setAlpha(1)
				f11_arg0.icon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.icon:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.icon:completeAnimation()
			f11_arg0.icon:setAlpha(0)
			f11_local0(f11_arg0.icon)
		end,
	},
	FlashingOn = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		FlashingOff = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.icon:beginAnimation(100)
				f14_arg0.icon:setAlpha(0)
				f14_arg0.icon:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.icon:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.icon:completeAnimation()
			f14_arg0.icon:setAlpha(1)
			f14_local0(f14_arg0.icon)
		end,
	},
}
CoD.ZMPowerUpIcon.__onClose = function(f16_arg0)
	f16_arg0.icon:close()
end
