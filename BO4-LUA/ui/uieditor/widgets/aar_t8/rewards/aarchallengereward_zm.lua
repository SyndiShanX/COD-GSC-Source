require("x64:792ba00b5100c37")
require("x64:41c9011e64b1ca0")
require("x64:151a9f89b614c73")
require("x64:aff459c6d2a75c9")
require("x64:fbc37d5639d4910")
require("x64:29187ea00d726c3")
CoD.AARChallengeReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARChallengeReward_ZM.__defaultWidth = 412
CoD.AARChallengeReward_ZM.__defaultHeight = 772
CoD.AARChallengeReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARChallengeReward_ZM)
	self.id = "AARChallengeReward_ZM"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackerZM = CoD.AARRewardBacker_ZM.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 19, 791)
	self:addElement(BackerZM)
	self.BackerZM = BackerZM
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 0, 19)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local AARRewardHeaderZM = CoD.AARRewardHeader_ZM.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0, 0, 19, 229)
	AARRewardHeaderZM.Pointer:setRGB(0.61, 0.1, 0.11)
	AARRewardHeaderZM.mainTitle:setRGB(1, 0.74, 0.28)
	AARRewardHeaderZM:linkToElementModel(self, "mainTitle", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AARRewardHeaderZM.mainTitle:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	AARRewardHeaderZM:linkToElementModel(self, "levelText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AARRewardHeaderZM.levelText:setText(f3_local0)
		end
	end)
	AARRewardHeaderZM:linkToElementModel(self, "mainIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			AARRewardHeaderZM.mainIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(AARRewardHeaderZM)
	self.AARRewardHeaderZM = AARRewardHeaderZM
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local ChallengeItem = CoD.AARChallengeItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 475)
	ChallengeItem:mergeStateConditions({
		{
			stateName = "RotatedLocked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "challengeRewardLocked")
			end,
		},
		{
			stateName = "Rotated",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ChallengeItem:linkToElementModel(ChallengeItem, "challengeRewardLocked", true, function(model)
		f1_arg0:updateElementState(ChallengeItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "challengeRewardLocked",
		})
	end)
	ChallengeItem.Corner:setRGB(0.82, 0.89, 0.26)
	ChallengeItem:linkToElementModel(self, "challengeImage", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ChallengeItem.Image:setImage(RegisterImage(f9_local0))
		end
	end)
	ChallengeItem:linkToElementModel(self, "challengeDesc", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ChallengeItem.Description:setText(f10_local0)
		end
	end)
	ChallengeItem:linkToElementModel(self, "challengeName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ChallengeItem.Title:setText(Engine[0xF9F1239CFD921FE](f11_local0))
		end
	end)
	self:addElement(ChallengeItem)
	self.ChallengeItem = ChallengeItem
	local XPReward = CoD.AARRewardsXP.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 435, 529)
	XPReward:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "totalXP")
			end,
		},
	})
	XPReward:linkToElementModel(XPReward, "totalXP", true, function(model)
		f1_arg0:updateElementState(XPReward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalXP",
		})
	end)
	XPReward.Backing:setRGB(0.64, 0.24, 0.24)
	XPReward.Corner:setRGB(1, 0.74, 0.28)
	XPReward:linkToElementModel(self, "totalXP", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			XPReward.XP:setText(f14_local0)
		end
	end)
	self:addElement(XPReward)
	self.XPReward = XPReward
	local AARTierItem = CoD.AARTierItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 529, 629)
	AARTierItem:linkToElementModel(self, nil, false, function(model)
		AARTierItem:setModel(model, f1_arg1)
	end)
	self:addElement(AARTierItem)
	self.AARTierItem = AARTierItem
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 629, 645)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -196, 184, 0, 0, 645, 649)
	InfoDotline2:setRGB(0.61, 0.1, 0.11)
	InfoDotline2:setImage(RegisterImage(0x805FC715189E506))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 649, 665)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARChallengeReward_ZM.__resetProperties = function(f16_arg0)
	f16_arg0.VerticalListSpacer4:completeAnimation()
	f16_arg0.VerticalListSpacer5:completeAnimation()
	f16_arg0.InfoDotline2:completeAnimation()
	f16_arg0.XPReward:completeAnimation()
	f16_arg0.AARRewardHeaderZM:completeAnimation()
	f16_arg0.VerticalListSpacer4:setAlpha(1)
	f16_arg0.VerticalListSpacer5:setAlpha(1)
	f16_arg0.InfoDotline2:setAlpha(1)
	f16_arg0.XPReward:setAlpha(1)
	f16_arg0.AARRewardHeaderZM:setAlpha(1)
end
CoD.AARChallengeReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			local f17_local0 = function(f18_arg0)
				f17_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f17_arg0.AARRewardHeaderZM:setAlpha(1)
				f17_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AARRewardHeaderZM:completeAnimation()
			f17_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f17_local0(f17_arg0.AARRewardHeaderZM)
			f17_arg0.XPReward:completeAnimation()
			f17_arg0.XPReward:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.XPReward)
			f17_arg0.VerticalListSpacer4:completeAnimation()
			f17_arg0.VerticalListSpacer4:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.VerticalListSpacer4)
			f17_arg0.InfoDotline2:completeAnimation()
			f17_arg0.InfoDotline2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.InfoDotline2)
			f17_arg0.VerticalListSpacer5:completeAnimation()
			f17_arg0.VerticalListSpacer5:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.VerticalListSpacer5)
		end,
	},
}
CoD.AARChallengeReward_ZM.__onClose = function(f19_arg0)
	f19_arg0.BackerZM:close()
	f19_arg0.VerticalListSpacer2:close()
	f19_arg0.AARRewardHeaderZM:close()
	f19_arg0.VerticalListSpacer:close()
	f19_arg0.ChallengeItem:close()
	f19_arg0.XPReward:close()
	f19_arg0.AARTierItem:close()
	f19_arg0.VerticalListSpacer4:close()
	f19_arg0.VerticalListSpacer5:close()
end
