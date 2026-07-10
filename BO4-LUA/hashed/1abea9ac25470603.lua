require("x64:6cfb14ab0b137a5")
require("x64:43e711b632bac8d")
require("x64:9bf4161fe672a21")
require("x64:b757afc5f54b586")
CoD.WZAAR_Challenge = InheritFrom(LUI.UIElement)
CoD.WZAAR_Challenge.__defaultWidth = 471
CoD.WZAAR_Challenge.__defaultHeight = 162
CoD.WZAAR_Challenge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_Challenge)
	self.id = "WZAAR_Challenge"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Box = LUI.UIImage.new(0, 0, 0, 472, 0, 0, 24, 164)
	Box:setImage(RegisterImage(0x5EBDC43AA483174))
	self:addElement(Box)
	self.Box = Box
	local ProgressCount = LUI.UIText.new(1, 1, -115, -10, 0, 0, 92, 114)
	ProgressCount:setTTF("ttmussels_regular")
	ProgressCount:setLetterSpacing(2)
	ProgressCount:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ProgressCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ProgressCount:linkToElementModel(self, "statFractionText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressCount:setText(f2_local0)
		end
	end)
	self:addElement(ProgressCount)
	self.ProgressCount = ProgressCount
	local Completed = LUI.UIText.new(1, 1, -107, -10, 0, 0, 92, 114)
	Completed:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Completed:setAlpha(0)
	Completed:setText(Engine[0xF9F1239CFD921FE](0xC249C368451D708))
	Completed:setTTF("ttmussels_regular")
	Completed:setLetterSpacing(2)
	Completed:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Completed:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Completed)
	self.Completed = Completed
	local ProgressBar = CoD.WZAAR_MeritProgressBar.new(f1_arg0, f1_arg1, 0, 0, 10, 461, 0, 0, 71, 91)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local Description = LUI.UIText.new(0, 0, 44, 356, 0, 0, 43, 60)
	Description:setRGB(0.81, 0.81, 0.81)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	Description:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description:setText(f3_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local XpEarned = LUI.UIText.new(0, 0, 362, 462, 0, 0, 43, 60)
	XpEarned:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	XpEarned:setTTF("ttmussels_demibold")
	XpEarned:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	XpEarned:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	XpEarned:linkToElementModel(self, "xp", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			XpEarned:setText(LocalizeIntoString(0x5B30C9471AAF95D, f4_local0))
		end
	end)
	self:addElement(XpEarned)
	self.XpEarned = XpEarned
	local Title = LUI.UIText.new(0, 1, 0, 0, 0, 0, -3, 23)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	Title:linkToElementModel(self, "title", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Icon = CoD.WZAARChallengeReward.new(f1_arg0, f1_arg1, 0, 0, 10.5, 355.5, 0, 0, 95, 151)
	Icon:linkToElementModel(self, nil, false, function(model)
		Icon:setModel(model, f1_arg1)
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local LockedTier = CoD.WZAARTierLock.new(f1_arg0, f1_arg1, 0, 0, 69, 297, 0, 0, 104.5, 141.5)
	LockedTier:linkToElementModel(self, nil, false, function(model)
		LockedTier:setModel(model, f1_arg1)
	end)
	self:addElement(LockedTier)
	self.LockedTier = LockedTier
	local ContractOrChallenge = CoD.WZAARChallengeOrContract.new(f1_arg0, f1_arg1, 0, 0, 4, 40, 0, 0, 34, 70)
	ContractOrChallenge:linkToElementModel(self, nil, false, function(model)
		ContractOrChallenge:setModel(model, f1_arg1)
	end)
	self:addElement(ContractOrChallenge)
	self.ContractOrChallenge = ContractOrChallenge
	self:mergeStateConditions({
		{
			stateName = "TierCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "tierCompleted")
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "statPercent", 1)
			end,
		},
	})
	self:linkToElementModel(self, "tierCompleted", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tierCompleted",
		})
	end)
	self:linkToElementModel(self, "statPercent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "statPercent",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.WZUtility.WZAARConvertChallengeProgressForBar(self, controller, f1_arg1, self.ProgressBar)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	SetElementProperty(self.ProgressBar, "_progressDelay", 650)
	return self
end
CoD.WZAAR_Challenge.__resetProperties = function(f14_arg0)
	f14_arg0.ProgressCount:completeAnimation()
	f14_arg0.Completed:completeAnimation()
	f14_arg0.XpEarned:completeAnimation()
	f14_arg0.LockedTier:completeAnimation()
	f14_arg0.ProgressCount:setAlpha(1)
	f14_arg0.Completed:setAlpha(0)
	f14_arg0.XpEarned:setAlpha(1)
	f14_arg0.LockedTier:setAlpha(1)
end
CoD.WZAAR_Challenge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	TierCompleted = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.ProgressCount:completeAnimation()
			f16_arg0.ProgressCount:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ProgressCount)
			f16_arg0.Completed:completeAnimation()
			f16_arg0.Completed:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.Completed)
			f16_arg0.XpEarned:completeAnimation()
			f16_arg0.XpEarned:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.XpEarned)
		end,
	},
	Completed = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.ProgressCount:completeAnimation()
			f17_arg0.ProgressCount:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ProgressCount)
			f17_arg0.Completed:completeAnimation()
			f17_arg0.Completed:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.Completed)
			f17_arg0.XpEarned:completeAnimation()
			f17_arg0.XpEarned:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.XpEarned)
			f17_arg0.LockedTier:completeAnimation()
			f17_arg0.LockedTier:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.LockedTier)
		end,
	},
}
CoD.WZAAR_Challenge.__onClose = function(f18_arg0)
	f18_arg0.ProgressCount:close()
	f18_arg0.ProgressBar:close()
	f18_arg0.Description:close()
	f18_arg0.XpEarned:close()
	f18_arg0.Title:close()
	f18_arg0.Icon:close()
	f18_arg0.LockedTier:close()
	f18_arg0.ContractOrChallenge:close()
end
