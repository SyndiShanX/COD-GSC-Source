require("x64:97f230a5a1a43f8")
require("x64:21d6535d40a8875")
require("x64:3cb9c7a5d216d8f")
require("x64:aff459c6d2a75c9")
require("x64:29187ea00d726c3")
CoD.AARWeaponReward = InheritFrom(LUI.UIElement)
CoD.AARWeaponReward.__defaultWidth = 412
CoD.AARWeaponReward.__defaultHeight = 772
CoD.AARWeaponReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARWeaponReward)
	self.id = "AARWeaponReward"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.AARRewardBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 0, 19)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local AARRewardHeader = CoD.AARRewardHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -205.5, 206.5, 0, 0, 19, 229)
	AARRewardHeader.Pointer:setRGB(0.39, 0.19, 0.49)
	AARRewardHeader.headerBacking:setRGB(0.39, 0.19, 0.49)
	AARRewardHeader.TopStripBase:setRGB(0.39, 0.19, 0.49)
	AARRewardHeader.mainTitle:setRGB(0.7, 0.42, 1)
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
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local Reward1 = CoD.AARRewardItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 427)
	Reward1.Corner:setRGB(0.7, 0.42, 1)
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
	Reward2.Corner:setRGB(0.7, 0.42, 1)
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
	local VerticalListSpacer6 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 645, 661)
	self:addElement(VerticalListSpacer6)
	self.VerticalListSpacer6 = VerticalListSpacer6
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
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 755, 771)
	VerticalListSpacer5:setAlpha(0)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	self:mergeStateConditions({
		{
			stateName = "MultiItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "multiItem")
			end,
		},
		{
			stateName = "IsArena",
			condition = function(menu, element, event)
				return IsArenaMode()
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
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local13, f1_local15["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARWeaponReward.__resetProperties = function(f18_arg0)
	f18_arg0.Reward2:completeAnimation()
	f18_arg0.VerticalListSpacer4:completeAnimation()
	f18_arg0.InfoDotline2:completeAnimation()
	f18_arg0.VerticalListSpacer5:completeAnimation()
	f18_arg0.XPReward:completeAnimation()
	f18_arg0.VerticalListSpacer6:completeAnimation()
	f18_arg0.VerticalListSpacer3:completeAnimation()
	f18_arg0.Reward1:completeAnimation()
	f18_arg0.VerticalListSpacer2:completeAnimation()
	f18_arg0.AARRewardHeader:completeAnimation()
	f18_arg0.VerticalListSpacer:completeAnimation()
	f18_arg0.Backer:completeAnimation()
	f18_arg0.Reward2:setAlpha(1)
	f18_arg0.VerticalListSpacer4:setAlpha(1)
	f18_arg0.InfoDotline2:setLeftRight(0.5, 0.5, -196, 184)
	f18_arg0.InfoDotline2:setAlpha(1)
	f18_arg0.VerticalListSpacer5:setAlpha(0)
	f18_arg0.XPReward:setAlpha(1)
	f18_arg0.VerticalListSpacer6:setAlpha(1)
	f18_arg0.VerticalListSpacer3:setAlpha(1)
	f18_arg0.Reward1:setAlpha(1)
	f18_arg0.VerticalListSpacer2:setAlpha(1)
	f18_arg0.AARRewardHeader:setAlpha(1)
	f18_arg0.VerticalListSpacer:setAlpha(1)
	f18_arg0.Backer:setAlpha(1)
end
CoD.AARWeaponReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.Reward2:completeAnimation()
			f19_arg0.Reward2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Reward2)
			f19_arg0.VerticalListSpacer4:completeAnimation()
			f19_arg0.VerticalListSpacer4:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.VerticalListSpacer4)
			f19_arg0.InfoDotline2:completeAnimation()
			f19_arg0.InfoDotline2:setLeftRight(0.5, 0.5, -190, 190)
			f19_arg0.InfoDotline2:setAlpha(0.8)
			f19_arg0.clipFinished(f19_arg0.InfoDotline2)
			f19_arg0.VerticalListSpacer5:completeAnimation()
			f19_arg0.VerticalListSpacer5:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.VerticalListSpacer5)
		end,
	},
	MultiItem = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.Reward2:completeAnimation()
			f20_arg0.Reward2:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Reward2)
			f20_arg0.VerticalListSpacer4:completeAnimation()
			f20_arg0.VerticalListSpacer4:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.VerticalListSpacer4)
			f20_arg0.InfoDotline2:completeAnimation()
			f20_arg0.InfoDotline2:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.InfoDotline2)
			f20_arg0.XPReward:completeAnimation()
			f20_arg0.XPReward:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.XPReward)
			f20_arg0.VerticalListSpacer5:completeAnimation()
			f20_arg0.VerticalListSpacer5:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.VerticalListSpacer5)
		end,
	},
	IsArena = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(11)
			f21_arg0.Backer:completeAnimation()
			f21_arg0.Backer:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Backer)
			f21_arg0.VerticalListSpacer:completeAnimation()
			f21_arg0.VerticalListSpacer:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VerticalListSpacer)
			f21_arg0.AARRewardHeader:completeAnimation()
			f21_arg0.AARRewardHeader:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.AARRewardHeader)
			f21_arg0.VerticalListSpacer2:completeAnimation()
			f21_arg0.VerticalListSpacer2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VerticalListSpacer2)
			f21_arg0.Reward1:completeAnimation()
			f21_arg0.Reward1:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Reward1)
			f21_arg0.VerticalListSpacer3:completeAnimation()
			f21_arg0.VerticalListSpacer3:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VerticalListSpacer3)
			f21_arg0.Reward2:completeAnimation()
			f21_arg0.Reward2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Reward2)
			f21_arg0.VerticalListSpacer4:completeAnimation()
			f21_arg0.VerticalListSpacer4:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VerticalListSpacer4)
			f21_arg0.InfoDotline2:completeAnimation()
			f21_arg0.InfoDotline2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.InfoDotline2)
			f21_arg0.VerticalListSpacer6:completeAnimation()
			f21_arg0.VerticalListSpacer6:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VerticalListSpacer6)
			f21_arg0.XPReward:completeAnimation()
			f21_arg0.XPReward:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.XPReward)
		end,
	},
}
CoD.AARWeaponReward.__onClose = function(f22_arg0)
	f22_arg0.Backer:close()
	f22_arg0.VerticalListSpacer:close()
	f22_arg0.AARRewardHeader:close()
	f22_arg0.VerticalListSpacer2:close()
	f22_arg0.Reward1:close()
	f22_arg0.VerticalListSpacer3:close()
	f22_arg0.Reward2:close()
	f22_arg0.VerticalListSpacer4:close()
	f22_arg0.VerticalListSpacer6:close()
	f22_arg0.XPReward:close()
	f22_arg0.VerticalListSpacer5:close()
end
