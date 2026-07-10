require("x64:fd51e83e2e6dbd1")
CoD.AmmoWidget_SingleShotPip = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_SingleShotPip.__defaultWidth = 14
CoD.AmmoWidget_SingleShotPip.__defaultHeight = 7
CoD.AmmoWidget_SingleShotPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_SingleShotPip)
	self.id = "AmmoWidget_SingleShotPip"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local base2 = LUI.UIImage.new(0.2, 0.2, -2, 10, -0.3, -0.3, -3, 13)
	base2:setRGB(0.92, 0.89, 0.72)
	base2:setZRot(90)
	base2:setImage(RegisterImage(0xCEDA89781162E4B))
	self:addElement(base2)
	self.base2 = base2
	local GlowOuter = LUI.UIImage.new(0, 0, 1, 13, 0, 0, -5, 11)
	GlowOuter:setRGB(0.92, 0.89, 0.72)
	GlowOuter:setAlpha(0.35)
	GlowOuter:setZRot(90)
	GlowOuter:setImage(RegisterImage(0xE48B57FD16FAD2D))
	GlowOuter:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowOuter)
	self.GlowOuter = GlowOuter
	local plusIcon = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, 0, 16, 0, 0, -5, 12)
	plusIcon:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasExtra") and IsLastItem(self)
			end,
		},
	})
	plusIcon:linkToElementModel(plusIcon, "hasExtra", true, function(model)
		f1_arg0:updateElementState(plusIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasExtra",
		})
	end)
	plusIcon:setScale(2, 2)
	plusIcon:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	plusIcon:setShaderVector(0, 0, 0, 0, 0)
	plusIcon.image:setImage(RegisterImage(0x1CCD6B7B2BDAC2))
	plusIcon:linkToElementModel(self, nil, false, function(model)
		plusIcon:setModel(model, f1_arg1)
	end)
	self:addElement(plusIcon)
	self.plusIcon = plusIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hidden")
			end,
		},
	})
	self:linkToElementModel(self, "hidden", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hidden",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_SingleShotPip.__resetProperties = function(f7_arg0)
	f7_arg0.plusIcon:completeAnimation()
	f7_arg0.base2:completeAnimation()
	f7_arg0.GlowOuter:completeAnimation()
	f7_arg0.plusIcon:setAlpha(1)
	f7_arg0.base2:setAlpha(1)
	f7_arg0.GlowOuter:setAlpha(0.35)
end
CoD.AmmoWidget_SingleShotPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.base2:completeAnimation()
			f9_arg0.base2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.base2)
			f9_arg0.GlowOuter:completeAnimation()
			f9_arg0.GlowOuter:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.GlowOuter)
			f9_arg0.plusIcon:completeAnimation()
			f9_arg0.plusIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.plusIcon)
		end,
	},
}
CoD.AmmoWidget_SingleShotPip.__onClose = function(f10_arg0)
	f10_arg0.plusIcon:close()
end
