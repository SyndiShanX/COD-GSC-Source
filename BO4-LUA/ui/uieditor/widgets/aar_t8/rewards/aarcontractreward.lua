require("x64:97f230a5a1a43f8")
require("x64:964f98242e1c7b3")
require("x64:21d6535d40a8875")
require("x64:814c085d0bdb54a")
require("x64:78b521390453e28")
require("x64:29187ea00d726c3")
CoD.AARContractReward = InheritFrom(LUI.UIElement)
CoD.AARContractReward.__defaultWidth = 412
CoD.AARContractReward.__defaultHeight = 772
CoD.AARContractReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARContractReward)
	self.id = "AARContractReward"
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
	local VerticalListSpacer6 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 553, 569)
	self:addElement(VerticalListSpacer6)
	self.VerticalListSpacer6 = VerticalListSpacer6
	local AARRewardsVariableContractReward = CoD.AARRewardsVariableContractReward.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 569, 663)
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
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 663, 679)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -196, 184, 0, 0, 679, 683)
	InfoDotline2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_dotline"))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
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
CoD.AARContractReward.__resetProperties = function(f12_arg0)
	f12_arg0.VerticalListSpacer4:completeAnimation()
	f12_arg0.VerticalListSpacer5:completeAnimation()
	f12_arg0.InfoDotline2:completeAnimation()
	f12_arg0.AARRewardsVariableContractReward:completeAnimation()
	f12_arg0.VerticalListSpacer4:setAlpha(1)
	f12_arg0.VerticalListSpacer5:setAlpha(1)
	f12_arg0.InfoDotline2:setAlpha(1)
	f12_arg0.AARRewardsVariableContractReward:setAlpha(1)
end
CoD.AARContractReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.VerticalListSpacer4:completeAnimation()
			f13_arg0.VerticalListSpacer4:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer4)
			f13_arg0.VerticalListSpacer5:completeAnimation()
			f13_arg0.VerticalListSpacer5:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer5)
			f13_arg0.InfoDotline2:completeAnimation()
			f13_arg0.InfoDotline2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.InfoDotline2)
		end,
	},
	NoReward = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.AARRewardsVariableContractReward:completeAnimation()
			f14_arg0.AARRewardsVariableContractReward:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.AARRewardsVariableContractReward)
		end,
	},
}
CoD.AARContractReward.__onClose = function(f15_arg0)
	f15_arg0.Backer:close()
	f15_arg0.VerticalListSpacer2:close()
	f15_arg0.AARRewardHeader:close()
	f15_arg0.VerticalListSpacer:close()
	f15_arg0.AARRewardContractDesc:close()
	f15_arg0.VerticalListSpacer3:close()
	f15_arg0.AARRewardsDynamicXP:close()
	f15_arg0.VerticalListSpacer4:close()
	f15_arg0.VerticalListSpacer6:close()
	f15_arg0.AARRewardsVariableContractReward:close()
	f15_arg0.VerticalListSpacer5:close()
end
