require("x64:41c9011e64b1ca0")
require("x64:151a9f89b614c73")
require("x64:aff459c6d2a75c9")
require("x64:551bad30d5d02a9")
require("x64:3d814452510a1d6")
require("x64:29187ea00d726c3")
CoD.AARSpecialEventReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARSpecialEventReward_ZM.__defaultWidth = 412
CoD.AARSpecialEventReward_ZM.__defaultHeight = 772
CoD.AARSpecialEventReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARSpecialEventReward_ZM)
	self.id = "AARSpecialEventReward_ZM"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackerZM = CoD.AARRewardBacker_ZM.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 19, 791)
	self:addElement(BackerZM)
	self.BackerZM = BackerZM
	local VerticalListSpace = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 0, 19)
	self:addElement(VerticalListSpace)
	self.VerticalListSpace = VerticalListSpace
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
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local SpecialEventItem = CoD.AARSpecialEventItem.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 245, 445)
	SpecialEventItem.Backing:setRGB(0.64, 0.24, 0.24)
	SpecialEventItem.Corner:setRGB(1, 0.74, 0.28)
	SpecialEventItem:linkToElementModel(self, "reward1Icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SpecialEventItem.MainReward.FixedAspectRatioImage:setImage(RegisterImage(f5_local0))
		end
	end)
	SpecialEventItem:linkToElementModel(self, "reward1Title", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			SpecialEventItem.Title:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(SpecialEventItem)
	self.SpecialEventItem = SpecialEventItem
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 445, 461)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local InfoDotline = LUI.UIImage.new(0.5, 0.5, -190, 190, 0, 0, 461, 465)
	InfoDotline:setRGB(0.61, 0.1, 0.11)
	InfoDotline:setImage(RegisterImage(0x805FC715189E506))
	self:addElement(InfoDotline)
	self.InfoDotline = InfoDotline
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 465, 481)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local XPReward = CoD.AARRewardsXP.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 481, 575)
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
	XPReward:linkToElementModel(self, nil, false, function(model)
		XPReward:setModel(model, f1_arg1)
	end)
	XPReward:linkToElementModel(self, "totalXP", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			XPReward.XP:setText(f10_local0)
		end
	end)
	self:addElement(XPReward)
	self.XPReward = XPReward
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 575, 591)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -190, 190, 0, 0, 591, 595)
	InfoDotline2:setRGB(0.61, 0.1, 0.11)
	InfoDotline2:setImage(RegisterImage(0x805FC715189E506))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local VerticalListSpacer6 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 595, 611)
	self:addElement(VerticalListSpacer6)
	self.VerticalListSpacer6 = VerticalListSpacer6
	local AARStepItem = CoD.AARStepItem.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 611, 711)
	AARStepItem:linkToElementModel(self, nil, false, function(model)
		AARStepItem:setModel(model, f1_arg1)
	end)
	self:addElement(AARStepItem)
	self.AARStepItem = AARStepItem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSpecialEventReward_ZM.__resetProperties = function(f12_arg0)
	f12_arg0.AARRewardHeaderZM:completeAnimation()
	f12_arg0.AARRewardHeaderZM:setAlpha(1)
end
CoD.AARSpecialEventReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f13_arg0.AARRewardHeaderZM:setAlpha(1)
				f13_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AARRewardHeaderZM:completeAnimation()
			f13_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f13_local0(f13_arg0.AARRewardHeaderZM)
		end,
	},
}
CoD.AARSpecialEventReward_ZM.__onClose = function(f15_arg0)
	f15_arg0.BackerZM:close()
	f15_arg0.VerticalListSpace:close()
	f15_arg0.AARRewardHeaderZM:close()
	f15_arg0.VerticalListSpacer2:close()
	f15_arg0.SpecialEventItem:close()
	f15_arg0.VerticalListSpacer3:close()
	f15_arg0.VerticalListSpacer4:close()
	f15_arg0.XPReward:close()
	f15_arg0.VerticalListSpacer5:close()
	f15_arg0.VerticalListSpacer6:close()
	f15_arg0.AARStepItem:close()
end
