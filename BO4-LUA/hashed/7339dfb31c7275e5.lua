CoD.WZCompassIntercardinalInternal = InheritFrom(LUI.UIElement)
CoD.WZCompassIntercardinalInternal.__defaultWidth = 62
CoD.WZCompassIntercardinalInternal.__defaultHeight = 43
CoD.WZCompassIntercardinalInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCompassIntercardinalInternal)
	self.id = "WZCompassIntercardinalInternal"
	self.soundSet = "default"
	local Text = LUI.UIText.new(0.5, 0.5, -31, 31, 0, 0, 6.5, 30.5)
	Text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Text:setTTF("dinnext_regular")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Text:setShaderVector(0, 0.8, 0, 0, 0)
	Text:setShaderVector(1, 0, 0, 0, 0)
	Text:setShaderVector(2, 1, 1, 1, 0.35)
	Text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	Text:setLetterSpacing(1)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Text:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Text:setText(f2_local0)
		end
	end)
	self:addElement(Text)
	self.Text = Text
	local Image = LUI.UIImage.new(0.5, 0.5, -7, 9, 0, 0, -8, 8)
	Image:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_compass_hash"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Image)
	self.Image = Image
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCompassIntercardinalInternal.__onClose = function(f3_arg0)
	f3_arg0.Text:close()
end
