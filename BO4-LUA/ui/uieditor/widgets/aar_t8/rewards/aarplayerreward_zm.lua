require("x64:41c9011e64b1ca0")
require("x64:151a9f89b614c73")
require("x64:6d95e04b5d181c9")
require("x64:aff459c6d2a75c9")
require("x64:29187ea00d726c3")
CoD.AARPlayerReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARPlayerReward_ZM.__defaultWidth = 412
CoD.AARPlayerReward_ZM.__defaultHeight = 772
CoD.AARPlayerReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARPlayerReward_ZM)
	self.id = "AARPlayerReward_ZM"
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
	local ZMReward01 = CoD.AARRewardItem_ZM.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 427)
	ZMReward01.Corner:setRGB(1, 0.74, 0.28)
	ZMReward01:linkToElementModel(self, "reward1Icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ZMReward01.Image:setImage(RegisterImage(f5_local0))
		end
	end)
	ZMReward01:linkToElementModel(self, "reward1Desc", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ZMReward01.Description:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	ZMReward01:linkToElementModel(self, "reward1Title", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ZMReward01.Title:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(ZMReward01)
	self.ZMReward01 = ZMReward01
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 427, 443)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local ZMReward02 = CoD.AARRewardItem_ZM.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 443, 625)
	ZMReward02.Corner:setRGB(1, 0.74, 0.28)
	ZMReward02:linkToElementModel(self, "reward2Icon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ZMReward02.Image:setImage(RegisterImage(f8_local0))
		end
	end)
	ZMReward02:linkToElementModel(self, "reward2Desc", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ZMReward02.Description:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	ZMReward02:linkToElementModel(self, "reward2Title", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ZMReward02.Title:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	self:addElement(ZMReward02)
	self.ZMReward02 = ZMReward02
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0.5, 412.5, 0, 0, 625, 641)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -196, 184, 0, 0, 641, 645)
	InfoDotline2:setRGB(0.61, 0.1, 0.11)
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
	XPReward.Backing:setRGB(0.64, 0.24, 0.24)
	XPReward.Corner:setRGB(1, 0.74, 0.28)
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
CoD.AARPlayerReward_ZM.__resetProperties = function(f16_arg0)
	f16_arg0.VerticalListSpacer4:completeAnimation()
	f16_arg0.VerticalListSpacer5:completeAnimation()
	f16_arg0.InfoDotline2:completeAnimation()
	f16_arg0.XPReward:completeAnimation()
	f16_arg0.AARRewardHeaderZM:completeAnimation()
	f16_arg0.ZMReward01:completeAnimation()
	f16_arg0.ZMReward02:completeAnimation()
	f16_arg0.VerticalListSpacer4:setAlpha(1)
	f16_arg0.VerticalListSpacer5:setAlpha(1)
	f16_arg0.InfoDotline2:setAlpha(1)
	f16_arg0.XPReward:setAlpha(1)
	f16_arg0.AARRewardHeaderZM:setAlpha(1)
	f16_arg0.ZMReward01:setAlpha(1)
	f16_arg0.ZMReward02:setAlpha(1)
end
CoD.AARPlayerReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(7)
			local f17_local0 = function(f18_arg0)
				f17_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f17_arg0.AARRewardHeaderZM:setAlpha(1)
				f17_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AARRewardHeaderZM:completeAnimation()
			f17_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f17_local0(f17_arg0.AARRewardHeaderZM)
			local f17_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.ZMReward01:beginAnimation(100)
				f17_arg0.ZMReward01:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ZMReward01:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f17_arg0.ZMReward01:completeAnimation()
			f17_arg0.ZMReward01:setAlpha(0.05)
			f17_local1(f17_arg0.ZMReward01)
			f17_arg0.ZMReward02:completeAnimation()
			f17_arg0.ZMReward02:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ZMReward02)
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
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			local f21_local0 = function(f22_arg0)
				f21_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f21_arg0.AARRewardHeaderZM:setAlpha(1)
				f21_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.AARRewardHeaderZM:completeAnimation()
			f21_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f21_local0(f21_arg0.AARRewardHeaderZM)
			local f21_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.ZMReward01:beginAnimation(100)
				f21_arg0.ZMReward01:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ZMReward01:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f21_arg0.ZMReward01:completeAnimation()
			f21_arg0.ZMReward01:setAlpha(0.05)
			f21_local1(f21_arg0.ZMReward01)
			local f21_local2 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.ZMReward02:beginAnimation(200)
				f21_arg0.ZMReward02:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ZMReward02:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f21_arg0.ZMReward02:completeAnimation()
			f21_arg0.ZMReward02:setAlpha(0.05)
			f21_local2(f21_arg0.ZMReward02)
			f21_arg0.VerticalListSpacer4:completeAnimation()
			f21_arg0.VerticalListSpacer4:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VerticalListSpacer4)
			f21_arg0.InfoDotline2:completeAnimation()
			f21_arg0.InfoDotline2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.InfoDotline2)
			f21_arg0.XPReward:completeAnimation()
			f21_arg0.XPReward:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.XPReward)
		end,
	},
}
CoD.AARPlayerReward_ZM.__onClose = function(f27_arg0)
	f27_arg0.BackerZM:close()
	f27_arg0.VerticalListSpacer2:close()
	f27_arg0.AARRewardHeaderZM:close()
	f27_arg0.VerticalListSpacer:close()
	f27_arg0.ZMReward01:close()
	f27_arg0.VerticalListSpacer3:close()
	f27_arg0.ZMReward02:close()
	f27_arg0.VerticalListSpacer4:close()
	f27_arg0.VerticalListSpacer5:close()
	f27_arg0.XPReward:close()
end
