require("x64:eb2be6535e5c73b")
require("x64:378659febfa9fa6")
require("x64:41c9011e64b1ca0")
require("x64:151a9f89b614c73")
require("x64:29187ea00d726c3")
CoD.AARClassReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARClassReward_ZM.__defaultWidth = 412
CoD.AARClassReward_ZM.__defaultHeight = 772
CoD.AARClassReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARClassReward_ZM)
	self.id = "AARClassReward_ZM"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackerZM = CoD.AARRewardBacker_ZM.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 19, 791)
	self:addElement(BackerZM)
	self.BackerZM = BackerZM
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 0, 19)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
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
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local RewardTitleZM = CoD.AARClassRewardCACPreview_ZM.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 245, 427)
	RewardTitleZM.Corner:setRGB(1, 0.74, 0.28)
	RewardTitleZM:linkToElementModel(self, nil, false, function(model)
		RewardTitleZM:setModel(model, f1_arg1)
	end)
	self:addElement(RewardTitleZM)
	self.RewardTitleZM = RewardTitleZM
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 427, 443)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local ClassPreviewZM = CoD.AARClassRewardPreview_ZM.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 443, 883)
	ClassPreviewZM:setAlpha(0)
	ClassPreviewZM.Corner:setRGB(1, 0.74, 0.28)
	self:addElement(ClassPreviewZM)
	self.ClassPreviewZM = ClassPreviewZM
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 883, 899)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 899, 915)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	self:mergeStateConditions({
		{
			stateName = "ClassReward",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "featureType", CoD.AARUtility.AARFeatureRewardType.CAC)
			end,
		},
	})
	self:linkToElementModel(self, "featureType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureType",
		})
	end)
	ClassPreviewZM.id = "ClassPreviewZM"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARClassReward_ZM.__resetProperties = function(f8_arg0)
	f8_arg0.VerticalListSpacer5:completeAnimation()
	f8_arg0.VerticalListSpacer4:completeAnimation()
	f8_arg0.AARRewardHeaderZM:completeAnimation()
	f8_arg0.RewardTitleZM:completeAnimation()
	f8_arg0.VerticalListSpacer3:completeAnimation()
	f8_arg0.VerticalListSpacer5:setTopBottom(0, 0, 883, 899)
	f8_arg0.VerticalListSpacer5:setAlpha(1)
	f8_arg0.VerticalListSpacer4:setLeftRight(0, 0, 0, 412)
	f8_arg0.VerticalListSpacer4:setTopBottom(0, 0, 899, 915)
	f8_arg0.VerticalListSpacer4:setAlpha(1)
	f8_arg0.AARRewardHeaderZM:setAlpha(1)
	f8_arg0.RewardTitleZM:setAlpha(1)
	f8_arg0.VerticalListSpacer3:setTopBottom(0, 0, 427, 443)
	f8_arg0.VerticalListSpacer3:setAlpha(1)
end
CoD.AARClassReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			local f9_local0 = function(f10_arg0)
				f9_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f9_arg0.AARRewardHeaderZM:setAlpha(1)
				f9_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.AARRewardHeaderZM:completeAnimation()
			f9_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f9_local0(f9_arg0.AARRewardHeaderZM)
			local f9_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.RewardTitleZM:beginAnimation(200)
				f9_arg0.RewardTitleZM:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.RewardTitleZM:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f9_arg0.RewardTitleZM:completeAnimation()
			f9_arg0.RewardTitleZM:setAlpha(0.05)
			f9_local1(f9_arg0.RewardTitleZM)
			f9_arg0.VerticalListSpacer5:completeAnimation()
			f9_arg0.VerticalListSpacer5:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.VerticalListSpacer5)
			f9_arg0.VerticalListSpacer4:completeAnimation()
			f9_arg0.VerticalListSpacer4:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.VerticalListSpacer4)
		end,
	},
	ClassReward = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			local f13_local0 = function(f14_arg0)
				f13_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f13_arg0.AARRewardHeaderZM:setAlpha(1)
				f13_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AARRewardHeaderZM:completeAnimation()
			f13_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f13_local0(f13_arg0.AARRewardHeaderZM)
			local f13_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.RewardTitleZM:beginAnimation(200)
				f13_arg0.RewardTitleZM:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.RewardTitleZM:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f13_arg0.RewardTitleZM:completeAnimation()
			f13_arg0.RewardTitleZM:setAlpha(0.05)
			f13_local1(f13_arg0.RewardTitleZM)
			f13_arg0.VerticalListSpacer3:completeAnimation()
			f13_arg0.VerticalListSpacer3:setTopBottom(0, 0, 720, 736)
			f13_arg0.VerticalListSpacer3:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer3)
			f13_arg0.VerticalListSpacer5:completeAnimation()
			f13_arg0.VerticalListSpacer5:setTopBottom(0, 0, 704, 720)
			f13_arg0.VerticalListSpacer5:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer5)
			f13_arg0.VerticalListSpacer4:completeAnimation()
			f13_arg0.VerticalListSpacer4:setLeftRight(0, 0, 0, 412)
			f13_arg0.VerticalListSpacer4:setTopBottom(0, 0, 688, 704)
			f13_arg0.VerticalListSpacer4:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.VerticalListSpacer4)
		end,
	},
}
CoD.AARClassReward_ZM.__onClose = function(f17_arg0)
	f17_arg0.BackerZM:close()
	f17_arg0.VerticalListSpacer:close()
	f17_arg0.AARRewardHeaderZM:close()
	f17_arg0.VerticalListSpacer2:close()
	f17_arg0.RewardTitleZM:close()
	f17_arg0.VerticalListSpacer3:close()
	f17_arg0.ClassPreviewZM:close()
	f17_arg0.VerticalListSpacer5:close()
	f17_arg0.VerticalListSpacer4:close()
end
