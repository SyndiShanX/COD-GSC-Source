CoD.ArmorBarKillCam = InheritFrom(LUI.UIElement)
CoD.ArmorBarKillCam.__defaultWidth = 300
CoD.ArmorBarKillCam.__defaultHeight = 4
CoD.ArmorBarKillCam.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArmorBarKillCam)
	self.id = "ArmorBarKillCam"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = LUI.UIImage.new(-0.01, 1.01, 0, 0, 0, 0, -3, 7)
	Border:setRGB(0.14, 0.14, 0.14)
	Border:setAlpha(0.96)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Border:setShaderVector(0, 0, 0.1, 0, 0.1)
	self:addElement(Border)
	self.Border = Border
	local ArmorBarBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -2, 6)
	ArmorBarBackground:setRGB(0.37, 0.4, 0.44)
	ArmorBarBackground:setImage(RegisterImage(@"uie_ui_hud_core_armor_bar_empty_long"))
	self:addElement(ArmorBarBackground)
	self.ArmorBarBackground = ArmorBarBackground
	local ArmorBarImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -2, 6)
	ArmorBarImage:setImage(RegisterImage(@"uie_ui_hud_core_armor_bar_fill_long"))
	ArmorBarImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	ArmorBarImage:setShaderVector(1, 0, 0, 0, 0)
	ArmorBarImage:setShaderVector(2, 0, 1, 0, 0)
	ArmorBarImage:setShaderVector(3, 0, 0, 0, 0)
	ArmorBarImage:setShaderVector(4, 0, 0, 0, 0)
	ArmorBarImage.__X_Start___X_End = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			ArmorBarImage:setShaderVector(0, CoD.HUDUtility.GetArmorBarWipe(self:getModel(), f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end
	ArmorBarImage:linkToElementModel(self, "armor", true, ArmorBarImage.__X_Start___X_End)
	ArmorBarImage.__X_Start___X_End_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.armor
		end
		if f3_local0 then
			ArmorBarImage.__X_Start___X_End(f3_local0)
		end
	end
	self:addElement(ArmorBarImage)
	self.ArmorBarImage = ArmorBarImage
	ArmorBarImage:linkToElementModel(self, "armorMax", true, ArmorBarImage.__X_Start___X_End_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "armor", 0)
			end,
		},
	})
	self:linkToElementModel(self, "armor", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "armor",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArmorBarKillCam.__resetProperties = function(f6_arg0)
	f6_arg0.ArmorBarBackground:completeAnimation()
	f6_arg0.ArmorBarImage:completeAnimation()
	f6_arg0.Border:completeAnimation()
	f6_arg0.ArmorBarBackground:setAlpha(1)
	f6_arg0.ArmorBarImage:setAlpha(1)
	f6_arg0.Border:setAlpha(0.96)
end
CoD.ArmorBarKillCam.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.Border:completeAnimation()
			f7_arg0.Border:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Border)
			f7_arg0.ArmorBarBackground:completeAnimation()
			f7_arg0.ArmorBarBackground:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ArmorBarBackground)
			f7_arg0.ArmorBarImage:completeAnimation()
			f7_arg0.ArmorBarImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ArmorBarImage)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ArmorBarKillCam.__onClose = function(f9_arg0)
	f9_arg0.ArmorBarImage:close()
end
