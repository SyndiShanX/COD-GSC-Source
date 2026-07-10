require("x64:22cf74f6000102a")
CoD.Prestige_DetailsUnlockedIndicator = InheritFrom(LUI.UIElement)
CoD.Prestige_DetailsUnlockedIndicator.__defaultWidth = 400
CoD.Prestige_DetailsUnlockedIndicator.__defaultHeight = 52
CoD.Prestige_DetailsUnlockedIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_DetailsUnlockedIndicator)
	self.id = "Prestige_DetailsUnlockedIndicator"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrestigeUnlockTokenIndicator = CoD.Prestige_UnlockTokenIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 0, 0, 16.5, 48.5)
	self:addElement(PrestigeUnlockTokenIndicator)
	self.PrestigeUnlockTokenIndicator = PrestigeUnlockTokenIndicator
	local RankUnlockRequirementText = LUI.UIText.new(0.5, 0.5, -200, 200, 0, 0, 2, 20)
	RankUnlockRequirementText:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	RankUnlockRequirementText:setAlpha(0)
	RankUnlockRequirementText:setTTF("ttmussels_regular")
	RankUnlockRequirementText:setLetterSpacing(2)
	RankUnlockRequirementText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RankUnlockRequirementText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RankUnlockRequirementText:linkToElementModel(self, "itemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankUnlockRequirementText:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PrestigeUtility.GetUnlockedIndicatorString(self:getModel(), f1_arg1, f2_local0)))
		end
	end)
	self:addElement(RankUnlockRequirementText)
	self.RankUnlockRequirementText = RankUnlockRequirementText
	local PermanentUnlockText = LUI.UIText.new(0.5, 0.5, -200, 200, 0, 0, -2, 16)
	PermanentUnlockText:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	PermanentUnlockText:setText(LocalizeToUpperString(@"hash_58539BFDAD37E114"))
	PermanentUnlockText:setTTF("ttmussels_regular")
	PermanentUnlockText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PermanentUnlockText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(PermanentUnlockText)
	self.PermanentUnlockText = PermanentUnlockText
	self:mergeStateConditions({
		{
			stateName = "Unlocked",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPermanentlyUnlocked")
				if f3_local0 then
					if not IsMaxPrestigeLevel(f1_arg1) then
						f3_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "useWideLayout")
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "SpendToken",
			condition = function(menu, element, event)
				local f4_local0 = IsUnlockTokenButtonAvailable(f1_arg1)
				if f4_local0 then
					if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPermanentlyUnlocked") then
						f4_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "useWideLayout")
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "ShowUnlockRequirement",
			condition = function(menu, element, event)
				local f5_local0
				if not IsUnlockTokenButtonAvailable(f1_arg1) and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "rewardEarned") then
					f5_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPermanentlyUnlocked")
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	self:linkToElementModel(self, "isPermanentlyUnlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPermanentlyUnlocked",
		})
	end)
	self:linkToElementModel(self, "useWideLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "useWideLayout",
		})
	end)
	self:linkToElementModel(self, "rewardEarned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardEarned",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_DetailsUnlockedIndicator.__resetProperties = function(f9_arg0)
	f9_arg0.PermanentUnlockText:completeAnimation()
	f9_arg0.PrestigeUnlockTokenIndicator:completeAnimation()
	f9_arg0.RankUnlockRequirementText:completeAnimation()
	f9_arg0.PermanentUnlockText:setAlpha(1)
	f9_arg0.PermanentUnlockText:setText(LocalizeToUpperString(@"hash_58539BFDAD37E114"))
	f9_arg0.PrestigeUnlockTokenIndicator:setAlpha(1)
	f9_arg0.PrestigeUnlockTokenIndicator.UnlockImage:setAlpha(1)
	f9_arg0.RankUnlockRequirementText:setAlpha(0)
end
CoD.Prestige_DetailsUnlockedIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.PrestigeUnlockTokenIndicator:completeAnimation()
			f10_arg0.PrestigeUnlockTokenIndicator:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PrestigeUnlockTokenIndicator)
			f10_arg0.RankUnlockRequirementText:completeAnimation()
			f10_arg0.RankUnlockRequirementText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RankUnlockRequirementText)
			f10_arg0.PermanentUnlockText:completeAnimation()
			f10_arg0.PermanentUnlockText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PermanentUnlockText)
		end,
	},
	Unlocked = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.PrestigeUnlockTokenIndicator:completeAnimation()
			f11_arg0.PrestigeUnlockTokenIndicator.UnlockImage:completeAnimation()
			f11_arg0.PrestigeUnlockTokenIndicator:setAlpha(1)
			f11_arg0.PrestigeUnlockTokenIndicator.UnlockImage:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.PrestigeUnlockTokenIndicator)
			f11_arg0.PermanentUnlockText:completeAnimation()
			f11_arg0.PermanentUnlockText:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.PermanentUnlockText)
		end,
	},
	SpendToken = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.PrestigeUnlockTokenIndicator:completeAnimation()
			f12_arg0.PrestigeUnlockTokenIndicator.UnlockImage:completeAnimation()
			f12_arg0.PrestigeUnlockTokenIndicator:setAlpha(1)
			f12_arg0.PrestigeUnlockTokenIndicator.UnlockImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PrestigeUnlockTokenIndicator)
			f12_arg0.PermanentUnlockText:completeAnimation()
			f12_arg0.PermanentUnlockText:setText(LocalizeToUpperString(@"hash_3D5A696D6B841CE6"))
			f12_arg0.clipFinished(f12_arg0.PermanentUnlockText)
		end,
	},
	ShowUnlockRequirement = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.PrestigeUnlockTokenIndicator:completeAnimation()
			f13_arg0.PrestigeUnlockTokenIndicator:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PrestigeUnlockTokenIndicator)
			f13_arg0.RankUnlockRequirementText:completeAnimation()
			f13_arg0.RankUnlockRequirementText:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.RankUnlockRequirementText)
			f13_arg0.PermanentUnlockText:completeAnimation()
			f13_arg0.PermanentUnlockText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PermanentUnlockText)
		end,
	},
}
CoD.Prestige_DetailsUnlockedIndicator.__onClose = function(f14_arg0)
	f14_arg0.PrestigeUnlockTokenIndicator:close()
	f14_arg0.RankUnlockRequirementText:close()
end
