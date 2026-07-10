require("x64:792ba00b5100c37")
require("x64:97f230a5a1a43f8")
require("x64:21d6535d40a8875")
require("x64:aff459c6d2a75c9")
require("x64:fbc37d5639d4910")
require("x64:29187ea00d726c3")
CoD.AARChallengeReward = InheritFrom(LUI.UIElement)
CoD.AARChallengeReward.__defaultWidth = 412
CoD.AARChallengeReward.__defaultHeight = 772
CoD.AARChallengeReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARChallengeReward)
	self.id = "AARChallengeReward"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.AARRewardBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 0, 19)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local AARRewardHeader = CoD.AARRewardHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0, 0, 19, 229)
	AARRewardHeader.Pointer:setRGB(1, 0.82, 0.25)
	AARRewardHeader.Pointer:setAlpha(0.5)
	AARRewardHeader.headerBacking:setRGB(0.47, 0.39, 0.18)
	AARRewardHeader.headerBacking:setAlpha(0.25)
	AARRewardHeader.TopStripBase:setRGB(0.86, 0.73, 0.14)
	AARRewardHeader.mainTitle:setRGB(0.89, 0.78, 0.25)
	AARRewardHeader:linkToElementModel(self, "levelText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AARRewardHeader.levelText:setText(f2_local0)
		end
	end)
	AARRewardHeader:linkToElementModel(self, "mainTitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AARRewardHeader.mainTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	AARRewardHeader:linkToElementModel(self, "mainIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			AARRewardHeader.mainIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(AARRewardHeader)
	self.AARRewardHeader = AARRewardHeader
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local ChallengeItem = CoD.AARChallengeItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 475)
	ChallengeItem:mergeStateConditions({
		{
			stateName = "RotatedLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "challengeRewardLocked") and CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "rotateChallengeRewardIcon")
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
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "rotateChallengeRewardIcon")
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
	ChallengeItem:linkToElementModel(ChallengeItem, "rotateChallengeRewardIcon", true, function(model)
		f1_arg0:updateElementState(ChallengeItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rotateChallengeRewardIcon",
		})
	end)
	ChallengeItem.Corner:setRGB(1, 0.82, 0.25)
	ChallengeItem:linkToElementModel(self, "challengeImage", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ChallengeItem.Image:setImage(RegisterImage(f10_local0))
		end
	end)
	ChallengeItem:linkToElementModel(self, "challengeImage", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ChallengeItem.rotatedImage:setImage(RegisterImage(f11_local0))
		end
	end)
	ChallengeItem:linkToElementModel(self, "challengeDesc", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ChallengeItem.Description:setText(f12_local0)
		end
	end)
	ChallengeItem:linkToElementModel(self, "challengeName", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ChallengeItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f13_local0))
		end
	end)
	self:addElement(ChallengeItem)
	self.ChallengeItem = ChallengeItem
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 475, 491)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -196, 184, 0, 0, 491, 495)
	InfoDotline2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_dotline"))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local XPReward = CoD.AARRewardsXP.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 495, 589)
	XPReward:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "totalXP")
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1)
			end,
		},
		{
			stateName = "Merit",
			condition = function(menu, element, event)
				return IsWarzone()
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
	local VerticalListSpacer5 = XPReward
	local VerticalListSpacer4 = XPReward.subscribeToModel
	local AARTierItem = Engine[@"getglobalmodel"]()
	VerticalListSpacer4(VerticalListSpacer5, AARTierItem["lobbyRoot.lobbyNav"], function(f18_arg0)
		f1_arg0:updateElementState(XPReward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	XPReward:linkToElementModel(self, "totalXP", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			XPReward.XP:setText(f19_local0)
		end
	end)
	self:addElement(XPReward)
	self.XPReward = XPReward
	VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 589, 605)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 10, 422, 0, 0, 605, 621)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	AARTierItem = CoD.AARTierItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 621, 721)
	AARTierItem:linkToElementModel(self, nil, false, function(model)
		AARTierItem:setModel(model, f1_arg1)
	end)
	self:addElement(AARTierItem)
	self.AARTierItem = AARTierItem
	local VerticalListSpacer6 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 721, 737)
	self:addElement(VerticalListSpacer6)
	self.VerticalListSpacer6 = VerticalListSpacer6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARChallengeReward.__resetProperties = function(f21_arg0)
	f21_arg0.VerticalListSpacer4:completeAnimation()
	f21_arg0.VerticalListSpacer5:completeAnimation()
	f21_arg0.InfoDotline2:completeAnimation()
	f21_arg0.VerticalListSpacer3:completeAnimation()
	f21_arg0.VerticalListSpacer:completeAnimation()
	f21_arg0.VerticalListSpacer4:setTopBottom(0, 0, 589, 605)
	f21_arg0.VerticalListSpacer4:setAlpha(1)
	f21_arg0.VerticalListSpacer5:setTopBottom(0, 0, 605, 621)
	f21_arg0.VerticalListSpacer5:setAlpha(1)
	f21_arg0.InfoDotline2:setAlpha(1)
	f21_arg0.VerticalListSpacer3:setLeftRight(0, 0, 0.5, 412.5)
	f21_arg0.VerticalListSpacer3:setTopBottom(0, 0, 475, 491)
	f21_arg0.VerticalListSpacer:setTopBottom(0, 0, 229, 245)
end
CoD.AARChallengeReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.VerticalListSpacer:completeAnimation()
			f22_arg0.VerticalListSpacer:setTopBottom(0, 0, 221, 237)
			f22_arg0.clipFinished(f22_arg0.VerticalListSpacer)
			f22_arg0.VerticalListSpacer3:completeAnimation()
			f22_arg0.VerticalListSpacer3:setLeftRight(0, 0, 0, 412)
			f22_arg0.VerticalListSpacer3:setTopBottom(0, 0, 221, 237)
			f22_arg0.clipFinished(f22_arg0.VerticalListSpacer3)
			f22_arg0.InfoDotline2:completeAnimation()
			f22_arg0.InfoDotline2:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.InfoDotline2)
			f22_arg0.VerticalListSpacer4:completeAnimation()
			f22_arg0.VerticalListSpacer4:setTopBottom(0, 0, 565, 581)
			f22_arg0.VerticalListSpacer4:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.VerticalListSpacer4)
			f22_arg0.VerticalListSpacer5:completeAnimation()
			f22_arg0.VerticalListSpacer5:setTopBottom(0, 0, 581, 597)
			f22_arg0.VerticalListSpacer5:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.VerticalListSpacer5)
		end,
	},
}
CoD.AARChallengeReward.__onClose = function(f23_arg0)
	f23_arg0.Backer:close()
	f23_arg0.VerticalListSpacer2:close()
	f23_arg0.AARRewardHeader:close()
	f23_arg0.VerticalListSpacer:close()
	f23_arg0.ChallengeItem:close()
	f23_arg0.VerticalListSpacer3:close()
	f23_arg0.XPReward:close()
	f23_arg0.VerticalListSpacer4:close()
	f23_arg0.VerticalListSpacer5:close()
	f23_arg0.AARTierItem:close()
	f23_arg0.VerticalListSpacer6:close()
end
