CoD.MOTD_BannerRender = InheritFrom(LUI.UIElement)
CoD.MOTD_BannerRender.__defaultWidth = 328
CoD.MOTD_BannerRender.__defaultHeight = 160
CoD.MOTD_BannerRender.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_BannerRender)
	self.id = "MOTD_BannerRender"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EngineRefImage = LUI.UIImage.new(0, 0, 0, 328, 0, 0, 0, 160)
	EngineRefImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	EngineRefImage:setShaderVector(0, 0.5, 0.5, 0, 0)
	EngineRefImage:setShaderVector(1, 1, 1, 0, 0)
	EngineRefImage:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(EngineRefImage)
	self.EngineRefImage = EngineRefImage
	local LibPNGImage = LUI.UIElement.new(0, 0, 0, 328, 0, 0, 0, 160)
	LibPNGImage:setAlpha(0)
	self:addElement(LibPNGImage)
	self.LibPNGImage = LibPNGImage
	self.EngineRefImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EngineRefImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self.LibPNGImage:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LibPNGImage:setupLibPNGImage(f3_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "LibPNGImage",
			condition = function(menu, element, event)
				return CoD.MOTDUtility.IsLibPNGImage(self, f1_arg1, element)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_BannerRender.__resetProperties = function(f5_arg0)
	f5_arg0.LibPNGImage:completeAnimation()
	f5_arg0.EngineRefImage:completeAnimation()
	f5_arg0.LibPNGImage:setAlpha(0)
	f5_arg0.EngineRefImage:setAlpha(1)
end
CoD.MOTD_BannerRender.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	LibPNGImage = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.EngineRefImage:completeAnimation()
			f7_arg0.EngineRefImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.EngineRefImage)
			f7_arg0.LibPNGImage:completeAnimation()
			f7_arg0.LibPNGImage:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.LibPNGImage)
		end,
	},
}
CoD.MOTD_BannerRender.__onClose = function(f8_arg0)
	f8_arg0.EngineRefImage:close()
	f8_arg0.LibPNGImage:close()
end
