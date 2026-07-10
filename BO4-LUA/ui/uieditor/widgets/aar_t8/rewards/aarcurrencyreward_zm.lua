require("x64:207aa5a07da04b3")
require("x64:41c9011e64b1ca0")
require("x64:151a9f89b614c73")
require("x64:29187ea00d726c3")
CoD.AARCurrencyReward_ZM = InheritFrom(LUI.UIElement)
CoD.AARCurrencyReward_ZM.__defaultWidth = 412
CoD.AARCurrencyReward_ZM.__defaultHeight = 772
CoD.AARCurrencyReward_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARCurrencyReward_ZM)
	self.id = "AARCurrencyReward_ZM"
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
	local AARCurrencyItem = CoD.AARCurrencyItem.new(f1_arg0, f1_arg1, 0, 0, 16.5, 396.5, 0, 0, 245, 475)
	AARCurrencyItem:linkToElementModel(self, "reward1Icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			AARCurrencyItem.Image:setImage(RegisterImage(f5_local0))
		end
	end)
	AARCurrencyItem:linkToElementModel(self, "reward1Desc", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			AARCurrencyItem.Title:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	self:addElement(AARCurrencyItem)
	self.AARCurrencyItem = AARCurrencyItem
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 475, 491)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	local InfoDotline2 = LUI.UIImage.new(0.5, 0.5, -197, 183, 0, 0, 491, 495)
	InfoDotline2:setRGB(0.61, 0.1, 0.11)
	InfoDotline2:setImage(RegisterImage(0x805FC715189E506))
	self:addElement(InfoDotline2)
	self.InfoDotline2 = InfoDotline2
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 495, 511)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	self:mergeStateConditions({
		{
			stateName = "DoubleNP",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsDoubleNP(f1_arg1)
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.cycled, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARCurrencyReward_ZM.__resetProperties = function(f9_arg0)
	f9_arg0.VerticalListSpacer4:completeAnimation()
	f9_arg0.VerticalListSpacer5:completeAnimation()
	f9_arg0.InfoDotline2:completeAnimation()
	f9_arg0.AARRewardHeaderZM:completeAnimation()
	f9_arg0.VerticalListSpacer4:setAlpha(1)
	f9_arg0.VerticalListSpacer5:setAlpha(1)
	f9_arg0.InfoDotline2:setAlpha(1)
	f9_arg0.AARRewardHeaderZM:setAlpha(1)
end
CoD.AARCurrencyReward_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			local f10_local0 = function(f11_arg0)
				f10_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f10_arg0.AARRewardHeaderZM:setAlpha(1)
				f10_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.AARRewardHeaderZM:completeAnimation()
			f10_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f10_local0(f10_arg0.AARRewardHeaderZM)
			f10_arg0.VerticalListSpacer4:completeAnimation()
			f10_arg0.VerticalListSpacer4:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer4)
			f10_arg0.InfoDotline2:completeAnimation()
			f10_arg0.InfoDotline2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.InfoDotline2)
			f10_arg0.VerticalListSpacer5:completeAnimation()
			f10_arg0.VerticalListSpacer5:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer5)
		end,
	},
	DoubleNP = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.AARRewardHeaderZM:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f12_arg0.AARRewardHeaderZM:setAlpha(1)
				f12_arg0.AARRewardHeaderZM:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.AARRewardHeaderZM:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.AARRewardHeaderZM:completeAnimation()
			f12_arg0.AARRewardHeaderZM:setAlpha(0.05)
			f12_local0(f12_arg0.AARRewardHeaderZM)
			f12_arg0.VerticalListSpacer4:completeAnimation()
			f12_arg0.VerticalListSpacer4:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.VerticalListSpacer4)
			f12_arg0.InfoDotline2:completeAnimation()
			f12_arg0.InfoDotline2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.InfoDotline2)
			f12_arg0.VerticalListSpacer5:completeAnimation()
			f12_arg0.VerticalListSpacer5:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.VerticalListSpacer5)
		end,
	},
}
CoD.AARCurrencyReward_ZM.__onClose = function(f14_arg0)
	f14_arg0.BackerZM:close()
	f14_arg0.VerticalListSpacer2:close()
	f14_arg0.AARRewardHeaderZM:close()
	f14_arg0.VerticalListSpacer:close()
	f14_arg0.AARCurrencyItem:close()
	f14_arg0.VerticalListSpacer4:close()
	f14_arg0.VerticalListSpacer5:close()
end
