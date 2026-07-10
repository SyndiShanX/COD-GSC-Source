CoD.rocketLauncherLockon_Internal = InheritFrom(LUI.UIElement)
CoD.rocketLauncherLockon_Internal.__defaultWidth = 105
CoD.rocketLauncherLockon_Internal.__defaultHeight = 105
CoD.rocketLauncherLockon_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.rocketLauncherLockon_Internal)
	self.id = "rocketLauncherLockon_Internal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0.5, 0.5, -52.5, 52.5, 0.5, 0.5, -52.5, 52.5)
	Image0:setRGB(0.64, 1, 0.81)
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_rocket_launcher_lockon"))
	Image0:setShaderVector(0, 3, 4, 0.07, 0.85)
	Image0:setShaderVector(1, 3, 4.35, 0.4, 1)
	Image0:setShaderVector(2, 1.5, 0.09, 180, 0)
	Image0:setShaderVector(4, 70, 70, 0, 0)
	Image0:linkToElementModel(self, "lockOnPercent", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image0:setShaderVector(3, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(Image0)
	self.Image0 = Image0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.rocketLauncherLockon_Internal.__resetProperties = function(f3_arg0)
	f3_arg0.Image0:completeAnimation()
	f3_arg0.Image0:setRGB(0.64, 1, 0.81)
end
CoD.rocketLauncherLockon_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	LockedOn = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image0:completeAnimation()
			f5_arg0.Image0:setRGB(0.79, 0.09, 0.12)
			f5_arg0.clipFinished(f5_arg0.Image0)
		end,
	},
	AcquiringLock = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.rocketLauncherLockon_Internal.__onClose = function(f7_arg0)
	f7_arg0.Image0:close()
end
