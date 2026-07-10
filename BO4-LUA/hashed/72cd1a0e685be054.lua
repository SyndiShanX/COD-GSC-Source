CoD.PlayerWidgetWZHealth = InheritFrom(LUI.UIElement)
CoD.PlayerWidgetWZHealth.__defaultWidth = 88
CoD.PlayerWidgetWZHealth.__defaultHeight = 72
CoD.PlayerWidgetWZHealth.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerWidgetWZHealth)
	self.id = "PlayerWidgetWZHealth"
	self.soundSet = "default"
	local HealthValue = LUI.UIText.new(0, 0, 0, 88, 0, 0, 19, 49)
	HealthValue:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HealthValue:setTTF("0arame_mono_stencil")
	HealthValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_593F361CC41C94AF"))
	HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
	HealthValue:setShaderVector(1, 0, 0, 0, 0)
	HealthValue:setShaderVector(2, 1, 1, 1, 0.25)
	HealthValue:setLetterSpacing(2)
	HealthValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	HealthValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerWidgetWZHealth.__onClose = function(f3_arg0)
	f3_arg0.HealthValue:close()
end
