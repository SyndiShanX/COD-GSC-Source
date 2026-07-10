require("x64:e272191e46af824")
require("x64:3c21aa1a96202c9")
require("x64:95553e1dbf377f6")
CoD.ReservesMeterInternal = InheritFrom(LUI.UIElement)
CoD.ReservesMeterInternal.__defaultWidth = 684
CoD.ReservesMeterInternal.__defaultHeight = 67
CoD.ReservesMeterInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesMeterInternal)
	self.id = "ReservesMeterInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Title = LUI.UIText.new(0, 0, 21, 456, 0, 0, 13.5, 33.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText(LocalizeToUpperString(0x4112D432F3F5906))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local RewardName = LUI.UIText.new(0, 0, 188.5, 433.5, 0, 0, 15.5, 33.5)
	RewardName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	RewardName:setAlpha(0)
	RewardName:setText(LocalizeToUpperString(0x0))
	RewardName:setTTF("ttmussels_demibold")
	RewardName:setLetterSpacing(4)
	RewardName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RewardName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(RewardName)
	self.RewardName = RewardName
	local ProgressBar = CoD.ReservesSpecialContractProgressBar.new(f1_arg0, f1_arg1, 0, 0, 12, 503, 0, 0, 33.5, 51.5)
	ProgressBar:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ProgressBar.Progress:setImage(RegisterImage(0x6D2FBF31F53910C))
	ProgressBar.ProgressGlow:setImage(RegisterImage(0xA7D61A3302B55D0))
	ProgressBar:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "reservesRngPercentage", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressBar.Progress:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	ProgressBar:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "reservesRngPercentage", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ProgressBar.ProgressGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	ProgressBar:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "reservesRngPercentage", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ProgressBar.ProgressFraction:setText(NumberAsPercent(CoD.BaseUtility.FloorFraction(0, StringMultiply(100, f6_local0))))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local CompleteBanner = CoD.ContractCompleteBanner.new(f1_arg0, f1_arg1, 0, 0, 283.5, 433.5, 1, 1, -55.5, -30.5)
	CompleteBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	CompleteBanner:setAlpha(0)
	self:addElement(CompleteBanner)
	self.CompleteBanner = CompleteBanner
	local ItemHintText = CoD.CommonToolTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -342, 342, 1, 1, 0, 45)
	ItemHintText:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "toolTip")
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemHintText:linkToElementModel(ItemHintText, "toolTip", true, function(model)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "toolTip",
		})
	end)
	ItemHintText:setAlpha(0)
	ItemHintText:linkToElementModel(self, "toolTip", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](f12_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allRngUnlocked")
			end,
		},
	})
	self:linkToElementModel(self, "allRngUnlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allRngUnlocked",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesMeterInternal.__resetProperties = function(f15_arg0)
	f15_arg0.CompleteBanner:completeAnimation()
	f15_arg0.ProgressBar:completeAnimation()
	f15_arg0.CompleteBanner:setAlpha(0)
	f15_arg0.ProgressBar:setAlpha(1)
end
CoD.ReservesMeterInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.ProgressBar:completeAnimation()
			f17_arg0.ProgressBar:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ProgressBar)
			f17_arg0.CompleteBanner:completeAnimation()
			f17_arg0.CompleteBanner:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CompleteBanner)
		end,
	},
}
CoD.ReservesMeterInternal.__onClose = function(f18_arg0)
	f18_arg0.ProgressBar:close()
	f18_arg0.CompleteBanner:close()
	f18_arg0.ItemHintText:close()
end
