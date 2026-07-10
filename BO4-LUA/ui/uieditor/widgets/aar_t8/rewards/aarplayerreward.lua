require("x64:97f230a5a1a43f8")
require("x64:21d6535d40a8875")
require("x64:3cb9c7a5d216d8f")
require("x64:aff459c6d2a75c9")
require("x64:29187ea00d726c3")
CoD.AARPlayerReward = InheritFrom(LUI.UIElement)
CoD.AARPlayerReward.__defaultWidth = 412
CoD.AARPlayerReward.__defaultHeight = 772
CoD.AARPlayerReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARPlayerReward)
	self.id = "AARPlayerReward"
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
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local Reward1 = CoD.AARRewardItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 427)
	Reward1.Corner:setRGB(0.82, 0.89, 0.26)
	Reward1:linkToElementModel(self, "reward1Icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Reward1.Image:setImage(RegisterImage(f5_local0))
		end
	end)
	Reward1:linkToElementModel(self, "reward1Desc", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Reward1.Description:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	Reward1:linkToElementModel(self, "reward1Title", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Reward1.Title:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(Reward1)
	self.Reward1 = Reward1
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 427, 443)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local Reward2 = CoD.AARRewardItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 443, 625)
	Reward2.Corner:setRGB(0.82, 0.89, 0.26)
	Reward2:linkToElementModel(self, "reward2Icon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Reward2.Image:setImage(RegisterImage(f8_local0))
		end
	end)
	Reward2:linkToElementModel(self, "reward2Desc", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Reward2.Description:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	Reward2:linkToElementModel(self, "reward2Title", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Reward2.Title:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	self:addElement(Reward2)
	self.Reward2 = Reward2
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 625, 641)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -196, 184, 0, 0, 641, 645)
	InfoDotline2:setImage(RegisterImage(0x805FC715189E506))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 645, 661)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	local XPReward = CoD.AARRewardsXP.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 661, 755)
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
	XPReward:linkToElementModel(self, "totalXP", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			XPReward.XP:setText(f13_local0)
		end
	end)
	self:addElement(XPReward)
	self.XPReward = XPReward
	self:mergeStateConditions({
		{
			stateName = "MultiItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "multiItem")
			end,
		},
	})
	self:linkToElementModel(self, "multiItem", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "multiItem",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARPlayerReward.__resetProperties = function(f16_arg0)
	f16_arg0.Reward2:completeAnimation()
	f16_arg0.VerticalListSpacer4:completeAnimation()
	f16_arg0.VerticalListSpacer5:completeAnimation()
	f16_arg0.InfoDotline2:completeAnimation()
	f16_arg0.XPReward:completeAnimation()
	f16_arg0.Reward2:setAlpha(1)
	f16_arg0.VerticalListSpacer4:setAlpha(1)
	f16_arg0.VerticalListSpacer5:setAlpha(1)
	f16_arg0.InfoDotline2:setAlpha(1)
	f16_arg0.XPReward:setAlpha(1)
end
CoD.AARPlayerReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			f17_arg0.Reward2:completeAnimation()
			f17_arg0.Reward2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Reward2)
			f17_arg0.VerticalListSpacer4:completeAnimation()
			f17_arg0.VerticalListSpacer4:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.VerticalListSpacer4)
			f17_arg0.InfoDotline2:completeAnimation()
			f17_arg0.InfoDotline2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.InfoDotline2)
			f17_arg0.VerticalListSpacer5:completeAnimation()
			f17_arg0.VerticalListSpacer5:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.VerticalListSpacer5)
			f17_arg0.XPReward:completeAnimation()
			f17_arg0.XPReward:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.XPReward)
		end,
	},
	MultiItem = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.Reward2:completeAnimation()
			f18_arg0.Reward2:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Reward2)
			f18_arg0.VerticalListSpacer4:completeAnimation()
			f18_arg0.VerticalListSpacer4:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.VerticalListSpacer4)
			f18_arg0.InfoDotline2:completeAnimation()
			f18_arg0.InfoDotline2:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.InfoDotline2)
			f18_arg0.XPReward:completeAnimation()
			f18_arg0.XPReward:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.XPReward)
		end,
	},
}
CoD.AARPlayerReward.__onClose = function(f19_arg0)
	f19_arg0.Backer:close()
	f19_arg0.VerticalListSpacer2:close()
	f19_arg0.AARRewardHeader:close()
	f19_arg0.VerticalListSpacer:close()
	f19_arg0.Reward1:close()
	f19_arg0.VerticalListSpacer3:close()
	f19_arg0.Reward2:close()
	f19_arg0.VerticalListSpacer4:close()
	f19_arg0.VerticalListSpacer5:close()
	f19_arg0.XPReward:close()
end
