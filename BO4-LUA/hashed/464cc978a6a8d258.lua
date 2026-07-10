require("x64:a9255c570c68aa8")
CoD.ArmorBarWZ = InheritFrom(LUI.UIElement)
CoD.ArmorBarWZ.__defaultWidth = 150
CoD.ArmorBarWZ.__defaultHeight = 8
CoD.ArmorBarWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArmorBarWZ)
	self.id = "ArmorBarWZ"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = LUI.UIImage.new(-0.01, 1.01, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.17, 0.17, 0.17)
	Border:setAlpha(0.9)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Border:setShaderVector(0, 0, 0.1, 0, 0.1)
	self:addElement(Border)
	self.Border = Border
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, -0.01, 1.01, 0, 0, -0.03, 1.03, 0, 0)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.01)
	self:addElement(Frame)
	self.Frame = Frame
	local ArmorBackground = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -3, 3)
	ArmorBackground:setRGB(0.07, 0.07, 0.07)
	ArmorBackground:setAlpha(0.6)
	ArmorBackground:setImage(RegisterImage(@"hash_75CDE8BCCBD6F24"))
	ArmorBackground:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17E89392B94A41DE"))
	ArmorBackground:setShaderVector(0, 0, 0, 0, 0)
	ArmorBackground:setShaderVector(2, 0, 1, 0, 1)
	ArmorBackground:setupNineSliceShader(4, 6)
	ArmorBackground:linkToElementModel(self, "armorTier", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArmorBackground:setShaderVector(1, CoD.WZUtility.GetArmorShardPips(CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(ArmorBackground)
	self.ArmorBackground = ArmorBackground
	local ArmorImage = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -3, 3)
	ArmorImage:setRGB(0.22, 0.56, 0.78)
	ArmorImage:setImage(RegisterImage(@"hash_5700B275CC09FEF2"))
	ArmorImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17E89392B94A41DE"))
	ArmorImage:setShaderVector(0, 0, 0, 0, 0)
	ArmorImage:setupNineSliceShader(4, 6)
	ArmorImage:linkToElementModel(self, "armorTier", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArmorImage:setShaderVector(1, CoD.WZUtility.GetArmorShardPips(CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	ArmorImage.__Wipe_X_Start_X_End_Y_Start_Y_End = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			ArmorImage:setShaderVector(2, CoD.HUDUtility.GetArmorBarWipe(self:getModel(), f1_arg1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end
	ArmorImage:linkToElementModel(self, "armor", true, ArmorImage.__Wipe_X_Start_X_End_Y_Start_Y_End)
	ArmorImage.__Wipe_X_Start_X_End_Y_Start_Y_End_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.armor
		end
		if f5_local0 then
			ArmorImage.__Wipe_X_Start_X_End_Y_Start_Y_End(f5_local0)
		end
	end
	self:addElement(ArmorImage)
	self.ArmorImage = ArmorImage
	local ArmorFrame = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -3, 3)
	ArmorFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ArmorFrame:setAlpha(0.2)
	ArmorFrame:setImage(RegisterImage(@"hash_475961ABECF3E11A"))
	ArmorFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17E89392B94A41DE"))
	ArmorFrame:setShaderVector(0, 0, 0, 0, 0)
	ArmorFrame:setupNineSliceShader(4, 6)
	ArmorFrame:linkToElementModel(self, "armorTier", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ArmorFrame:setShaderVector(1, CoD.WZUtility.GetArmorShardPips(CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	ArmorFrame.__Wipe_X_Start_X_End_Y_Start_Y_End = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			ArmorFrame:setShaderVector(2, CoD.HUDUtility.GetArmorBarWipe(self:getModel(), f1_arg1, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4)))
		end
	end
	ArmorFrame:linkToElementModel(self, "armor", true, ArmorFrame.__Wipe_X_Start_X_End_Y_Start_Y_End)
	ArmorFrame.__Wipe_X_Start_X_End_Y_Start_Y_End_FullPath = function()
		local f8_local0 = self:getModel()
		if f8_local0 then
			f8_local0 = self:getModel()
			f8_local0 = f8_local0.armor
		end
		if f8_local0 then
			ArmorFrame.__Wipe_X_Start_X_End_Y_Start_Y_End(f8_local0)
		end
	end
	self:addElement(ArmorFrame)
	self.ArmorFrame = ArmorFrame
	ArmorImage:linkToElementModel(self, "armorMax", true, ArmorImage.__Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	ArmorFrame:linkToElementModel(self, "armorMax", true, ArmorFrame.__Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "armor", 0)
			end,
		},
		{
			stateName = "VisibleWithoutBacking",
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
CoD.ArmorBarWZ.__resetProperties = function(f12_arg0)
	f12_arg0.Border:completeAnimation()
	f12_arg0.ArmorBackground:completeAnimation()
	f12_arg0.ArmorImage:completeAnimation()
	f12_arg0.Frame:completeAnimation()
	f12_arg0.ArmorFrame:completeAnimation()
	f12_arg0.Border:setAlpha(0.9)
	f12_arg0.ArmorBackground:setAlpha(0.6)
	f12_arg0.ArmorImage:setAlpha(1)
	f12_arg0.Frame:setAlpha(0.01)
	f12_arg0.ArmorFrame:setAlpha(0.2)
end
CoD.ArmorBarWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.Border:completeAnimation()
			f13_arg0.Border:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Border)
			f13_arg0.Frame:completeAnimation()
			f13_arg0.Frame:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Frame)
			f13_arg0.ArmorBackground:completeAnimation()
			f13_arg0.ArmorBackground:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ArmorBackground)
			f13_arg0.ArmorImage:completeAnimation()
			f13_arg0.ArmorImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ArmorImage)
			f13_arg0.ArmorFrame:completeAnimation()
			f13_arg0.ArmorFrame:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ArmorFrame)
		end,
	},
	Visible = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Frame:completeAnimation()
			f14_arg0.Frame:setAlpha(0.01)
			f14_arg0.clipFinished(f14_arg0.Frame)
		end,
	},
	VisibleWithoutBacking = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Border:completeAnimation()
			f15_arg0.Border:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Border)
			f15_arg0.Frame:completeAnimation()
			f15_arg0.Frame:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Frame)
		end,
	},
}
CoD.ArmorBarWZ.__onClose = function(f16_arg0)
	f16_arg0.Frame:close()
	f16_arg0.ArmorBackground:close()
	f16_arg0.ArmorImage:close()
	f16_arg0.ArmorFrame:close()
end
