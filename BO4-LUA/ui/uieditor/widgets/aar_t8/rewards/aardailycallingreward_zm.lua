require("x64:207aa5a07da04b3")
require("x64:41c9011e64b1ca0")
require("x64:151a9f89b614c73")
require("x64:aff459c6d2a75c9")
require("x64:29187ea00d726c3")
CoD.AARDailyCallingReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARDailyCallingReward_ZM.__defaultWidth = 412
CoD.AARDailyCallingReward_ZM.__defaultHeight = 772
CoD.AARDailyCallingReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARDailyCallingReward_ZM)
	self.id = "AARDailyCallingReward_ZM"
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
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local XPReward = CoD.AARRewardsXP.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 339)
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
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			XPReward.XP:setText(f7_local0)
		end
	end)
	self:addElement(XPReward)
	self.XPReward = XPReward
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 339, 355)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -197, 183, 0, 0, 355, 359)
	InfoDotline2:setRGB(0.61, 0.1, 0.11)
	InfoDotline2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_dotline"))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 359, 375)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	local AARCurrencyItem = CoD.AARCurrencyItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 375, 605)
	AARCurrencyItem:linkToElementModel(self, "reward1Icon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			AARCurrencyItem.Image:setImage(RegisterImage(f8_local0))
		end
	end)
	AARCurrencyItem:linkToElementModel(self, "reward1Desc", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			AARCurrencyItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	self:addElement(AARCurrencyItem)
	self.AARCurrencyItem = AARCurrencyItem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARDailyCallingReward_ZM.__resetProperties = function(f10_arg0)
	f10_arg0.AARRewardHeaderZM:completeAnimation()
	f10_arg0.AARRewardHeaderZM:setAlpha(1)
end
CoD.AARDailyCallingReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f11_arg0.AARRewardHeaderZM:setAlpha(1)
				f11_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.AARRewardHeaderZM:completeAnimation()
			f11_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f11_local0(f11_arg0.AARRewardHeaderZM)
		end,
	},
}
CoD.AARDailyCallingReward_ZM.__onClose = function(f13_arg0)
	f13_arg0.BackerZM:close()
	f13_arg0.VerticalListSpacer2:close()
	f13_arg0.AARRewardHeaderZM:close()
	f13_arg0.VerticalListSpacer:close()
	f13_arg0.XPReward:close()
	f13_arg0.VerticalListSpacer4:close()
	f13_arg0.VerticalListSpacer5:close()
	f13_arg0.AARCurrencyItem:close()
end
