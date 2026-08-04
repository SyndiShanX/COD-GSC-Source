CoD.ButtonProgressRing = InheritFrom(LUI.UIElement)
CoD.ButtonProgressRing.__defaultWidth = 42
CoD.ButtonProgressRing.__defaultHeight = 42
CoD.ButtonProgressRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonProgressRing)
	self.id = "ButtonProgressRing"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.5, 0.5, -23.5, 23.5, 0.5, 0.5, -23, 24)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.7)
	Backing:setImage(RegisterImage("uie_ui_icon_controller_radial_backer_hud"))
	self:addElement(Backing)
	self.Backing = Backing
	local progressRing = LUI.UIImage.new(0.5, 0.5, -23, 21, 0.5, 0.5, -22, 22)
	progressRing:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	progressRing:setImage(RegisterImage("uie_ui_icon_controller_radial_fill_hud"))
	progressRing:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	progressRing:setShaderVector(1, 0.5, 0, 0, 0)
	progressRing:setShaderVector(2, 0.5, 0, 0, 0)
	progressRing:setShaderVector(3, 0, 1, 0, 0)
	progressRing:setShaderVector(4, 0, 0, 0, 0)
	progressRing:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local carrot = LUI.UIImage.new(0, 0, 18, 24, 0, 0, -4, 6)
	carrot:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	carrot:setZRot(270)
	carrot:setImage(RegisterImage("uie_ui_hud_common_triangle"))
	self:addElement(carrot)
	self.carrot = carrot
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "progress")
			end,
		},
	})
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonProgressRing.__resetProperties = function(f5_arg0)
	f5_arg0.progressRing:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.progressRing:setAlpha(1)
	f5_arg0.Backing:setAlpha(0.7)
end
CoD.ButtonProgressRing.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.progressRing:completeAnimation()
			f6_arg0.progressRing:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.progressRing)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setAlpha(0.6)
			f7_arg0.clipFinished(f7_arg0.Backing)
		end,
	},
}
CoD.ButtonProgressRing.__onClose = function(f8_arg0)
	f8_arg0.progressRing:close()
end
