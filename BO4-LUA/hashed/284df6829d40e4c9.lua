require("x64:c1fb01b47dac728")
CoD.BM_ContractProgress = InheritFrom(LUI.UIElement)
CoD.BM_ContractProgress.__defaultWidth = 400
CoD.BM_ContractProgress.__defaultHeight = 400
CoD.BM_ContractProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ContractProgress)
	self.id = "BM_ContractProgress"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MeterGlowComplete = LUI.UIImage.new(0.5, 0.5, -134, 134, 0.5, 0.5, -180, 88)
	MeterGlowComplete:setAlpha(0)
	MeterGlowComplete:setImage(RegisterImage(0x34F2CCA3975B1DE))
	MeterGlowComplete:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	MeterGlowComplete:setShaderVector(0, 1, 0, 0, 0)
	MeterGlowComplete:setShaderVector(1, 0.5, 0, 0, 0)
	MeterGlowComplete:setShaderVector(2, 0.5, 0, 0, 0)
	MeterGlowComplete:setShaderVector(3, 0, 0, 0, 0)
	MeterGlowComplete:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MeterGlowComplete)
	self.MeterGlowComplete = MeterGlowComplete
	local MeterGlow = LUI.UIImage.new(0.5, 0.5, -133, 135, 0.5, 0.5, -180, 88)
	MeterGlow:setImage(RegisterImage(0x2097AB9046A99C4))
	MeterGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	MeterGlow:setShaderVector(1, 0.5, 0, 0, 0)
	MeterGlow:setShaderVector(2, 0.5, 0, 0, 0)
	MeterGlow:setShaderVector(3, 0, 0, 0, 0)
	MeterGlow:setShaderVector(4, 0, 0, 0, 0)
	MeterGlow:linkToElementModel(self, "progressRatio", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(MeterGlow)
	self.MeterGlow = MeterGlow
	local MeterBack = LUI.UIImage.new(0.5, 0.5, -116, 116, 0.5, 0.5, -162, 70)
	MeterBack:setRGB(0.45, 0.45, 0.45)
	MeterBack:setAlpha(0.96)
	MeterBack:setImage(RegisterImage(0xE30D845B50DC8C6))
	MeterBack:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(MeterBack)
	self.MeterBack = MeterBack
	local MeterFrontIngame = LUI.UIImage.new(0.5, 0.5, -116, 116, 0.5, 0.5, -162, 70)
	MeterFrontIngame:setImage(RegisterImage(0xC43B5C942D23F49))
	MeterFrontIngame:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	MeterFrontIngame:setShaderVector(1, 0.5, 0, 0, 0)
	MeterFrontIngame:setShaderVector(2, 0.5, 0, 0, 0)
	MeterFrontIngame:setShaderVector(3, 0, 0, 0, 0)
	MeterFrontIngame:setShaderVector(4, 0, 0, 0, 0)
	MeterFrontIngame:linkToElementModel(self, "progressRatioIngame", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MeterFrontIngame:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(MeterFrontIngame)
	self.MeterFrontIngame = MeterFrontIngame
	local MeterFront = LUI.UIImage.new(0.5, 0.5, -116, 116, 0.5, 0.5, -162, 70)
	MeterFront:setImage(RegisterImage(0x1C340BF43C52340))
	MeterFront:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	MeterFront:setShaderVector(1, 0.5, 0, 0, 0)
	MeterFront:setShaderVector(2, 0.5, 0, 0, 0)
	MeterFront:setShaderVector(3, 0, 0, 0, 0)
	MeterFront:setShaderVector(4, 0, 0, 0, 0)
	MeterFront:linkToElementModel(self, "progressRatio", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MeterFront:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(MeterFront)
	self.MeterFront = MeterFront
	local MeterFrontComplete = LUI.UIImage.new(0.5, 0.5, -116, 116, 0.5, 0.5, -162, 70)
	MeterFrontComplete:setAlpha(0)
	MeterFrontComplete:setImage(RegisterImage(0xA0C36633D1572BA))
	MeterFrontComplete:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	MeterFrontComplete:setShaderVector(0, 1, 0, 0, 0)
	MeterFrontComplete:setShaderVector(1, 0.5, 0, 0, 0)
	MeterFrontComplete:setShaderVector(2, 0.5, 0, 0, 0)
	MeterFrontComplete:setShaderVector(3, 0, 0, 0, 0)
	MeterFrontComplete:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MeterFrontComplete)
	self.MeterFrontComplete = MeterFrontComplete
	local Icon = LUI.UIImage.new(0.5, 0.5, -75, 75, 0.5, 0.5, -119, 31)
	Icon:linkToElementModel(self, "contractIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Icon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local NumericProgress = LUI.UIText.new(0.5, 0.5, -200, 200, 1, 1, -120, -68)
	NumericProgress:setTTF("ttmussels_regular")
	NumericProgress:setLetterSpacing(4)
	NumericProgress:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NumericProgress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NumericProgress:linkToElementModel(self, "progressRatioText", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NumericProgress:setText(f6_local0)
		end
	end)
	self:addElement(NumericProgress)
	self.NumericProgress = NumericProgress
	local Difficulty = CoD.BM_ContractDifficultyIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0.5, 0.5, -200, 200)
	Difficulty:mergeStateConditions({
		{
			stateName = "Hard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "difficulty", 1)
			end,
		},
	})
	Difficulty:linkToElementModel(Difficulty, "difficulty", true, function(model)
		f1_arg0:updateElementState(Difficulty, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "difficulty",
		})
	end)
	Difficulty:linkToElementModel(self, nil, false, function(model)
		Difficulty:setModel(model, f1_arg1)
	end)
	self:addElement(Difficulty)
	self.Difficulty = Difficulty
	local Completed = LUI.UIText.new(0.5, 0.5, -200, 200, 1, 1, -108, -78)
	Completed:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	Completed:setAlpha(0)
	Completed:setText(LocalizeToUpperString(0xC249C368451D708))
	Completed:setTTF("ttmussels_demibold")
	Completed:setLetterSpacing(2)
	Completed:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Completed:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Completed)
	self.Completed = Completed
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractProgress.__resetProperties = function(f10_arg0)
	f10_arg0.NumericProgress:completeAnimation()
	f10_arg0.Completed:completeAnimation()
	f10_arg0.MeterFront:completeAnimation()
	f10_arg0.MeterFrontComplete:completeAnimation()
	f10_arg0.MeterGlow:completeAnimation()
	f10_arg0.MeterGlowComplete:completeAnimation()
	f10_arg0.MeterFrontIngame:completeAnimation()
	f10_arg0.NumericProgress:setAlpha(1)
	f10_arg0.Completed:setAlpha(0)
	f10_arg0.MeterFront:setRGB(1, 1, 1)
	f10_arg0.MeterFront:setAlpha(1)
	f10_arg0.MeterFrontComplete:setAlpha(0)
	f10_arg0.MeterGlow:setAlpha(1)
	f10_arg0.MeterGlowComplete:setRGB(1, 1, 1)
	f10_arg0.MeterGlowComplete:setAlpha(0)
	f10_arg0.MeterFrontIngame:setAlpha(1)
end
CoD.BM_ContractProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Completed = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(7)
			f12_arg0.MeterGlowComplete:completeAnimation()
			f12_arg0.MeterGlowComplete:setRGB(0.54, 1, 0)
			f12_arg0.MeterGlowComplete:setAlpha(0.6)
			f12_arg0.clipFinished(f12_arg0.MeterGlowComplete)
			f12_arg0.MeterGlow:completeAnimation()
			f12_arg0.MeterGlow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.MeterGlow)
			f12_arg0.MeterFrontIngame:completeAnimation()
			f12_arg0.MeterFrontIngame:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.MeterFrontIngame)
			f12_arg0.MeterFront:completeAnimation()
			f12_arg0.MeterFront:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
			f12_arg0.MeterFront:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.MeterFront)
			f12_arg0.MeterFrontComplete:completeAnimation()
			f12_arg0.MeterFrontComplete:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.MeterFrontComplete)
			f12_arg0.NumericProgress:completeAnimation()
			f12_arg0.NumericProgress:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NumericProgress)
			f12_arg0.Completed:completeAnimation()
			f12_arg0.Completed:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Completed)
		end,
	},
}
CoD.BM_ContractProgress.__onClose = function(f13_arg0)
	f13_arg0.MeterGlow:close()
	f13_arg0.MeterFrontIngame:close()
	f13_arg0.MeterFront:close()
	f13_arg0.Icon:close()
	f13_arg0.NumericProgress:close()
	f13_arg0.Difficulty:close()
end
