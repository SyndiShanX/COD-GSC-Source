require("x64:97f230a5a1a43f8")
require("x64:21d6535d40a8875")
require("x64:aff459c6d2a75c9")
require("x64:551bad30d5d02a9")
require("x64:fbc37d5639d4910")
require("x64:29187ea00d726c3")
CoD.AARSpecialEventReward = InheritFrom(LUI.UIElement)
CoD.AARSpecialEventReward.__defaultWidth = 412
CoD.AARSpecialEventReward.__defaultHeight = 772
CoD.AARSpecialEventReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARSpecialEventReward)
	self.id = "AARSpecialEventReward"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backer = CoD.AARRewardBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local VerticalListSpace = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 0, 19)
	self:addElement(VerticalListSpace)
	self.VerticalListSpace = VerticalListSpace
	local AARRewardHeader = CoD.AARRewardHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0, 0, 19, 229)
	AARRewardHeader.Pointer:setRGB(0.43, 0.45, 0.18)
	AARRewardHeader.headerBacking:setRGB(0.43, 0.45, 0.18)
	AARRewardHeader.TopStripBase:setRGB(0.43, 0.45, 0.18)
	AARRewardHeader.mainTitle:setRGB(0.82, 0.89, 0.26)
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
	local AARTierItem = CoD.AARTierItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 621, 721)
	AARTierItem:linkToElementModel(self, nil, false, function(model)
		AARTierItem:setModel(model, f1_arg1)
	end)
	self:addElement(AARTierItem)
	self.AARTierItem = AARTierItem
	local VerticalListSpacer7 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 721, 737)
	self:addElement(VerticalListSpacer7)
	self.VerticalListSpacer7 = VerticalListSpacer7
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSpecialEventReward.__onClose = function(f12_arg0)
	f12_arg0.Backer:close()
	f12_arg0.VerticalListSpace:close()
	f12_arg0.AARRewardHeader:close()
	f12_arg0.VerticalListSpacer2:close()
	f12_arg0.SpecialEventItem:close()
	f12_arg0.VerticalListSpacer3:close()
	f12_arg0.VerticalListSpacer4:close()
	f12_arg0.XPReward:close()
	f12_arg0.VerticalListSpacer5:close()
	f12_arg0.VerticalListSpacer6:close()
	f12_arg0.AARTierItem:close()
	f12_arg0.VerticalListSpacer7:close()
end
