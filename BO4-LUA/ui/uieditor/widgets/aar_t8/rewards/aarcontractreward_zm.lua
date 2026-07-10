require("x64:41c9011e64b1ca0")
require("x64:964f98242e1c7b3")
require("x64:151a9f89b614c73")
require("x64:814c085d0bdb54a")
require("x64:78b521390453e28")
require("x64:29187ea00d726c3")
CoD.AARContractReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARContractReward_ZM.__defaultWidth = 412
CoD.AARContractReward_ZM.__defaultHeight = 772
CoD.AARContractReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARContractReward_ZM)
	self.id = "AARContractReward_ZM"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackerZM = CoD.AARRewardBacker_ZM.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 18.5, 790.5)
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
	local AARRewardContractDesc = CoD.AARRewardContractDesc.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 427)
	AARRewardContractDesc:linkToElementModel(self, "contractDesc", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			AARRewardContractDesc.Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	AARRewardContractDesc:linkToElementModel(self, "contractName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			AARRewardContractDesc.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(AARRewardContractDesc)
	self.AARRewardContractDesc = AARRewardContractDesc
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 427, 443)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local AARRewardsDynamicXP = CoD.AARRewardsDynamicXP.new(f1_arg0, f1_arg1, 0.5, 0.5, -190, 190, 0, 0, 443, 537)
	AARRewardsDynamicXP:linkToElementModel(self, "contractXPAmount", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			AARRewardsDynamicXP.XP:setText(f7_local0)
		end
	end)
	self:addElement(AARRewardsDynamicXP)
	self.AARRewardsDynamicXP = AARRewardsDynamicXP
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 537, 553)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local AARRewardsVariableContractReward = CoD.AARRewardsVariableContractReward.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 553, 647)
	AARRewardsVariableContractReward:linkToElementModel(self, "contractRewardIcon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			AARRewardsVariableContractReward.RewardIcon:setImage(RegisterImage(f8_local0))
		end
	end)
	AARRewardsVariableContractReward:linkToElementModel(self, "contractRewardAmount", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			AARRewardsVariableContractReward.XP:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	self:addElement(AARRewardsVariableContractReward)
	self.AARRewardsVariableContractReward = AARRewardsVariableContractReward
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -196, 184, 0, 0, 647, 651)
	InfoDotline2:setRGB(0.61, 0.1, 0.11)
	InfoDotline2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_dotline"))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 651, 667)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	self:mergeStateConditions({
		{
			stateName = "NoReward",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "contractRewardAmount")
			end,
		},
	})
	self:linkToElementModel(self, "contractRewardAmount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "contractRewardAmount",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARContractReward_ZM.__resetProperties = function(f12_arg0)
	f12_arg0.VerticalListSpacer4:completeAnimation()
	f12_arg0.VerticalListSpacer5:completeAnimation()
	f12_arg0.InfoDotline2:completeAnimation()
	f12_arg0.AARRewardHeaderZM:completeAnimation()
	f12_arg0.AARRewardsVariableContractReward:completeAnimation()
	f12_arg0.VerticalListSpacer4:setAlpha(1)
	f12_arg0.VerticalListSpacer5:setAlpha(1)
	f12_arg0.InfoDotline2:setAlpha(1)
	f12_arg0.AARRewardHeaderZM:setAlpha(1)
	f12_arg0.AARRewardsVariableContractReward:setAlpha(1)
end
CoD.AARContractReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				f13_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f13_arg0.AARRewardHeaderZM:setAlpha(1)
				f13_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AARRewardHeaderZM:completeAnimation()
			f13_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f13_local0(f13_arg0.AARRewardHeaderZM)
			f13_arg0.VerticalListSpacer4:completeAnimation()
			f13_arg0.VerticalListSpacer4:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer4)
			f13_arg0.InfoDotline2:completeAnimation()
			f13_arg0.InfoDotline2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.InfoDotline2)
			f13_arg0.VerticalListSpacer5:completeAnimation()
			f13_arg0.VerticalListSpacer5:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer5)
		end,
	},
	NoReward = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.AARRewardsVariableContractReward:completeAnimation()
			f15_arg0.AARRewardsVariableContractReward:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.AARRewardsVariableContractReward)
		end,
	},
}
CoD.AARContractReward_ZM.__onClose = function(f16_arg0)
	f16_arg0.BackerZM:close()
	f16_arg0.VerticalListSpacer2:close()
	f16_arg0.AARRewardHeaderZM:close()
	f16_arg0.VerticalListSpacer:close()
	f16_arg0.AARRewardContractDesc:close()
	f16_arg0.VerticalListSpacer3:close()
	f16_arg0.AARRewardsDynamicXP:close()
	f16_arg0.VerticalListSpacer4:close()
	f16_arg0.AARRewardsVariableContractReward:close()
	f16_arg0.VerticalListSpacer5:close()
end
