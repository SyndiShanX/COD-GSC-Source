require("x64:7021fe3cd1ed559")
CoD.ZMAARTrialTabRoundList = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTabRoundList.__defaultWidth = 388
CoD.ZMAARTrialTabRoundList.__defaultHeight = 635
CoD.ZMAARTrialTabRoundList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTabRoundList)
	self.id = "ZMAARTrialTabRoundList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMAARTrialTabRoundListInternal = CoD.ZMAARTrialTabRoundListInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -194, 194, 0.5, 0.5, -317.5, 317.5)
	ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x4F2A2FD2DB27D84))
	ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0x77E29E95B5D6719))
	ZMAARTrialTabRoundListInternal:linkToElementModel(self, nil, false, function(model)
		ZMAARTrialTabRoundListInternal:setModel(model, f1_arg1)
	end)
	self:addElement(ZMAARTrialTabRoundListInternal)
	self.ZMAARTrialTabRoundListInternal = ZMAARTrialTabRoundListInternal
	self:mergeStateConditions({
		{
			stateName = "BronzeMedal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "roundCompleteRequirement", 10) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "AAR.trialStats.zmTrialsVariant", 0)
			end,
		},
		{
			stateName = "SilverMedal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "roundCompleteRequirement", 20) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "AAR.trialStats.zmTrialsVariant", 0)
			end,
		},
		{
			stateName = "GoldMedal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "roundCompleteRequirement", 30) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "AAR.trialStats.zmTrialsVariant", 0)
			end,
		},
		{
			stateName = "PlatinumMedal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "roundCompleteRequirement", 10) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "AAR.trialStats.zmTrialsVariant", 1)
			end,
		},
		{
			stateName = "DiamondMedal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "roundCompleteRequirement", 20) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "AAR.trialStats.zmTrialsVariant", 1)
			end,
		},
		{
			stateName = "DarkMatterMedal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "roundCompleteRequirement", 30) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "AAR.trialStats.zmTrialsVariant", 1)
			end,
		},
	})
	self:linkToElementModel(self, "roundCompleteRequirement", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "roundCompleteRequirement",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["AAR.trialStats.zmTrialsVariant"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "AAR.trialStats.zmTrialsVariant",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTrialTabRoundList.__resetProperties = function(f11_arg0)
	f11_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
	f11_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0xDCF1B07E0539E4A))
	f11_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0x7775EF99258EEEC))
	f11_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(1, 1, 1)
	f11_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x4F2A2FD2DB27D84))
	f11_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(1, 1, 1)
	f11_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0x77E29E95B5D6719))
end
CoD.ZMAARTrialTabRoundList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	BronzeMedal = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
			f13_arg0.ZMAARTrialTabRoundListInternal.ListBg:completeAnimation()
			f13_arg0.ZMAARTrialTabRoundListInternal.Medal:completeAnimation()
			f13_arg0.ZMAARTrialTabRoundListInternal.MedalText:completeAnimation()
			f13_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:completeAnimation()
			f13_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0xA703FE14F98C63C))
			f13_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0x2638A7737E9BD02))
			f13_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(0.66, 0.3, 0.2)
			f13_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0xF90209F61BD41EA))
			f13_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(0.66, 0.3, 0.2)
			f13_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0xC951B199209617A))
			f13_arg0.clipFinished(f13_arg0.ZMAARTrialTabRoundListInternal)
		end,
	},
	SilverMedal = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
			f14_arg0.ZMAARTrialTabRoundListInternal.ListBg:completeAnimation()
			f14_arg0.ZMAARTrialTabRoundListInternal.Medal:completeAnimation()
			f14_arg0.ZMAARTrialTabRoundListInternal.MedalText:completeAnimation()
			f14_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:completeAnimation()
			f14_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0xD2773BA8C6EFDB))
			f14_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0xD56A5FDBB9721FB))
			f14_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(0.79, 0.79, 0.79)
			f14_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x56AFC9EB0C32053))
			f14_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(0.79, 0.79, 0.79)
			f14_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0xFE924858B948E51))
			f14_arg0.clipFinished(f14_arg0.ZMAARTrialTabRoundListInternal)
		end,
	},
	GoldMedal = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
			f15_arg0.ZMAARTrialTabRoundListInternal.ListBg:completeAnimation()
			f15_arg0.ZMAARTrialTabRoundListInternal.Medal:completeAnimation()
			f15_arg0.ZMAARTrialTabRoundListInternal.MedalText:completeAnimation()
			f15_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:completeAnimation()
			f15_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0xDCF1B07E0539E4A))
			f15_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0x7775EF99258EEEC))
			f15_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(1, 0.74, 0.28)
			f15_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x4F2A2FD2DB27D84))
			f15_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(1, 0.74, 0.28)
			f15_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0x77E29E95B5D6719))
			f15_arg0.clipFinished(f15_arg0.ZMAARTrialTabRoundListInternal)
		end,
	},
	PlatinumMedal = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
			f16_arg0.ZMAARTrialTabRoundListInternal.ListBg:completeAnimation()
			f16_arg0.ZMAARTrialTabRoundListInternal.Medal:completeAnimation()
			f16_arg0.ZMAARTrialTabRoundListInternal.MedalText:completeAnimation()
			f16_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:completeAnimation()
			f16_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0xBD93EB9B6EAD186))
			f16_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0x772C55AAA62BD0))
			f16_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(0.79, 0.79, 0.79)
			f16_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x74B40DC9E8748CA))
			f16_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(0.79, 0.79, 0.79)
			f16_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0xE964B7C1F487D1A))
			f16_arg0.clipFinished(f16_arg0.ZMAARTrialTabRoundListInternal)
		end,
	},
	DiamondMedal = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
			f17_arg0.ZMAARTrialTabRoundListInternal.ListBg:completeAnimation()
			f17_arg0.ZMAARTrialTabRoundListInternal.Medal:completeAnimation()
			f17_arg0.ZMAARTrialTabRoundListInternal.MedalText:completeAnimation()
			f17_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:completeAnimation()
			f17_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0x4230D3A2AA576B2))
			f17_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0xFD6B3DF8A0BA964))
			f17_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(0.84, 0.84, 0.84)
			f17_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x6C5F4DF36C73F36))
			f17_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(0.84, 0.84, 0.84)
			f17_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0x869344F2E6672B6))
			f17_arg0.clipFinished(f17_arg0.ZMAARTrialTabRoundListInternal)
		end,
	},
	DarkMatterMedal = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.ZMAARTrialTabRoundListInternal:completeAnimation()
			f18_arg0.ZMAARTrialTabRoundListInternal.ListBg:completeAnimation()
			f18_arg0.ZMAARTrialTabRoundListInternal.Medal:completeAnimation()
			f18_arg0.ZMAARTrialTabRoundListInternal.MedalText:completeAnimation()
			f18_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:completeAnimation()
			f18_arg0.ZMAARTrialTabRoundListInternal.ListBg:setImage(RegisterImage(0xC026AC93C711B7D))
			f18_arg0.ZMAARTrialTabRoundListInternal.Medal:setImage(RegisterImage(0x8F9261A2CAA7739))
			f18_arg0.ZMAARTrialTabRoundListInternal.MedalText:setRGB(0.66, 0.28, 1)
			f18_arg0.ZMAARTrialTabRoundListInternal.MedalText:setText(LocalizeToUpperString(0x254131A56580416))
			f18_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setRGB(0.66, 0.28, 1)
			f18_arg0.ZMAARTrialTabRoundListInternal.MedalAchievedText:setText(LocalizeToUpperString(0x2AB6C638ED90856))
			f18_arg0.clipFinished(f18_arg0.ZMAARTrialTabRoundListInternal)
		end,
	},
}
CoD.ZMAARTrialTabRoundList.__onClose = function(f19_arg0)
	f19_arg0.ZMAARTrialTabRoundListInternal:close()
end
