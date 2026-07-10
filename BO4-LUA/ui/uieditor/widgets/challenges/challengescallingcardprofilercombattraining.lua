CoD.ChallengesCallingCardProfilerCombatTraining = InheritFrom(LUI.UIElement)
CoD.ChallengesCallingCardProfilerCombatTraining.__defaultWidth = 525
CoD.ChallengesCallingCardProfilerCombatTraining.__defaultHeight = 732
CoD.ChallengesCallingCardProfilerCombatTraining.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesCallingCardProfilerCombatTraining)
	self.id = "ChallengesCallingCardProfilerCombatTraining"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIconBorder = LUI.UIImage.new(0.5, 0.5, -262.5, 262.5, 0, 0, 0, 129)
	CardIconBorder:setAlpha(0.15)
	CardIconBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	CardIconBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	CardIconBorder:setShaderVector(0, 0, 0, 0, 0)
	CardIconBorder:setupNineSliceShader(12, 12)
	self:addElement(CardIconBorder)
	self.CardIconBorder = CardIconBorder
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 129)
	CardIcon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CardIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local CardIconClassifiedOverlay = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 0, 129)
	CardIconClassifiedOverlay:setAlpha(0)
	CardIconClassifiedOverlay:setImage(RegisterImage(0x2746D911ABDE62E))
	self:addElement(CardIconClassifiedOverlay)
	self.CardIconClassifiedOverlay = CardIconClassifiedOverlay
	local ChallengeDescription = LUI.UIText.new(0, 1, 18, -18, 0, 0, 206, 224)
	ChallengeDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ChallengeDescription:setTTF("dinnext_regular")
	ChallengeDescription:setLetterSpacing(0.5)
	ChallengeDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ChallengeDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ChallengeDescription:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ChallengeDescription:setText(LocalizeHash(f3_local0))
		end
	end)
	self:addElement(ChallengeDescription)
	self.ChallengeDescription = ChallengeDescription
	local ChallengeName = LUI.UIText.new(0, 1, 16, -16, 0, 0, 152.5, 188.5)
	ChallengeName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ChallengeName:setTTF("ttmussels_regular")
	ChallengeName:setLetterSpacing(4)
	ChallengeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ChallengeName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ChallengeName:linkToElementModel(self, "title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ChallengeName:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(ChallengeName)
	self.ChallengeName = ChallengeName
	local MasterBarBase = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 295, 318)
	MasterBarBase:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	MasterBarBase:setAlpha(0.02)
	self:addElement(MasterBarBase)
	self.MasterBarBase = MasterBarBase
	local MasterBarBorder = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 294, 317)
	MasterBarBorder:setAlpha(0.1)
	MasterBarBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	MasterBarBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	MasterBarBorder:setShaderVector(0, 0, 0, 0, 0)
	MasterBarBorder:setupNineSliceShader(12, 12)
	self:addElement(MasterBarBorder)
	self.MasterBarBorder = MasterBarBorder
	local MasterBar = LUI.UIImage.new(0.03, 0.97, 1, -1, 0, 0.03, 296, 294)
	MasterBar:setRGB(1, 0.36, 0)
	MasterBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	MasterBar:setShaderVector(1, 0, 0, 0, 0)
	MasterBar:setShaderVector(2, 1, 0, 0, 0)
	MasterBar:setShaderVector(3, 0, 0, 0, 0)
	MasterBar:setShaderVector(4, 0, 0, 0, 0)
	MasterBar:linkToElementModel(self, "statPercent", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MasterBar:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(MasterBar)
	self.MasterBar = MasterBar
	local MasterFraction = LUI.UIText.new(1, 1, -58, -19, 0, 0, 298, 316)
	MasterFraction:setTTF("default")
	MasterFraction:setLetterSpacing(2)
	MasterFraction:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	MasterFraction:linkToElementModel(self, "statFractionText", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MasterFraction:setText(f6_local0)
		end
	end)
	self:addElement(MasterFraction)
	self.MasterFraction = MasterFraction
	self:mergeStateConditions({
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
	})
	self:linkToElementModel(self, "isLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesCallingCardProfilerCombatTraining.__resetProperties = function(f9_arg0)
	f9_arg0.CardIconClassifiedOverlay:completeAnimation()
	f9_arg0.CardIconClassifiedOverlay:setAlpha(0)
end
CoD.ChallengesCallingCardProfilerCombatTraining.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Classified = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.CardIconClassifiedOverlay:completeAnimation()
			f11_arg0.CardIconClassifiedOverlay:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.CardIconClassifiedOverlay)
		end,
	},
}
CoD.ChallengesCallingCardProfilerCombatTraining.__onClose = function(f12_arg0)
	f12_arg0.CardIcon:close()
	f12_arg0.ChallengeDescription:close()
	f12_arg0.ChallengeName:close()
	f12_arg0.MasterBar:close()
	f12_arg0.MasterFraction:close()
end
