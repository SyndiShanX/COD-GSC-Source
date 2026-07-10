CoD.WZCompassCardinal = InheritFrom(LUI.UIElement)
CoD.WZCompassCardinal.__defaultWidth = 62
CoD.WZCompassCardinal.__defaultHeight = 37
CoD.WZCompassCardinal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCompassCardinal)
	self.id = "WZCompassCardinal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0.5, 0.5, -31, 31, 0, 0, -11, 26)
	Text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Text:setTTF("0arame_mono_stencil")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Text:setShaderVector(0, 0.8, 0, 0, 0)
	Text:setShaderVector(1, 0, 0, 0, 0)
	Text:setShaderVector(2, 1, 1, 1, 0.35)
	Text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Text:linkToElementModel(self, "alpha", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Text:setAlpha(f2_local0)
		end
	end)
	Text:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Text:setText(f3_local0)
		end
	end)
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "North",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "degrees", 0)
			end,
		},
	})
	self:linkToElementModel(self, "degrees", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "degrees",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCompassCardinal.__resetProperties = function(f6_arg0)
	f6_arg0.Text:completeAnimation()
	f6_arg0.Text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f6_arg0.Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	f6_arg0.Text:setShaderVector(0, 0.8, 0, 0, 0)
	f6_arg0.Text:setShaderVector(1, 0, 0, 0, 0)
	f6_arg0.Text:setShaderVector(2, 1, 1, 1, 0.35)
	f6_arg0.Text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	f6_arg0.Text:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f6_arg0.Text:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
end
CoD.WZCompassCardinal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	North = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setRGB(1, 0.78, 0)
			f8_arg0.Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
			f8_arg0.Text:setShaderVector(0, 0.8, 0, 0, 0)
			f8_arg0.Text:setShaderVector(1, 0, 0, 0, 0)
			f8_arg0.Text:setShaderVector(2, 1, 0.2, 0, 0.35)
			f8_arg0.Text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f8_arg0.Text:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f8_arg0.Text:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
			f8_arg0.clipFinished(f8_arg0.Text)
		end,
	},
}
CoD.WZCompassCardinal.__onClose = function(f9_arg0)
	f9_arg0.Text:close()
end
