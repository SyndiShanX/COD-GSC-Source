require("x64:acbf06924421e35")
require("x64:2d361ac3553c22a")
CoD.TrialCountdownSmallWidget = InheritFrom(LUI.UIElement)
CoD.TrialCountdownSmallWidget.__defaultWidth = 282
CoD.TrialCountdownSmallWidget.__defaultHeight = 45
CoD.TrialCountdownSmallWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialCountdownSmallWidget)
	self.id = "TrialCountdownSmallWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NineSliceShaderImage = LUI.UIImage.new(0, 0, 0, 282, 0, 0, 0, 45)
	NineSliceShaderImage:setRGB(0.13, 0.13, 0.13)
	NineSliceShaderImage:setAlpha(0.8)
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(6, 6)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 0, 282, 0, 0, 0, 45)
	CommonCornerPips:setAlpha(0.5)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 2.5, 38.5, 0, 0, 5, 41)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local TrialText = LUI.UIText.new(0, 0, 42, 238, 0, 0, 4.5, 22.5)
	TrialText:setText(LocalizeToUpperString(0xF16F4088C060F3A))
	TrialText:setTTF("ttmussels_demibold")
	TrialText:setLetterSpacing(2)
	TrialText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TrialText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(TrialText)
	self.TrialText = TrialText
	local TrialCountdownText = LUI.UIText.new(0, 0, 42, 268, 0, 0, 26, 41)
	TrialCountdownText:setRGB(ColorSet.CoreControl.r, ColorSet.CoreControl.g, ColorSet.CoreControl.b)
	TrialCountdownText:setTTF("ttmussels_demibold")
	TrialCountdownText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TrialCountdownText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	TrialCountdownText:subscribeToGlobalModel(f1_arg1, "WarzoneTrialInfo", "countdown_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TrialCountdownText:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f2_local0))
		end
	end)
	self:addElement(TrialCountdownText)
	self.TrialCountdownText = TrialCountdownText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsGameTrial()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	CoD.DirectorUtility.EnableTrialTick(self)
	return self
end
CoD.TrialCountdownSmallWidget.__resetProperties = function(f4_arg0)
	f4_arg0.NineSliceShaderImage:completeAnimation()
	f4_arg0.TrialCountdownText:completeAnimation()
	f4_arg0.TrialText:completeAnimation()
	f4_arg0.TrialWidget:completeAnimation()
	f4_arg0.CommonCornerPips:completeAnimation()
	f4_arg0.NineSliceShaderImage:setAlpha(0.8)
	f4_arg0.TrialCountdownText:setLeftRight(0, 0, 42, 268)
	f4_arg0.TrialCountdownText:setAlpha(1)
	f4_arg0.TrialText:setAlpha(1)
	f4_arg0.TrialWidget:setAlpha(1)
	f4_arg0.CommonCornerPips:setAlpha(0.5)
end
CoD.TrialCountdownSmallWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.NineSliceShaderImage:completeAnimation()
			f5_arg0.NineSliceShaderImage:setAlpha(0.8)
			f5_arg0.clipFinished(f5_arg0.NineSliceShaderImage)
			f5_arg0.TrialCountdownText:completeAnimation()
			f5_arg0.TrialCountdownText:setLeftRight(0, 0.98, 42, 42)
			f5_arg0.clipFinished(f5_arg0.TrialCountdownText)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.NineSliceShaderImage:completeAnimation()
			f6_arg0.NineSliceShaderImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NineSliceShaderImage)
			f6_arg0.CommonCornerPips:completeAnimation()
			f6_arg0.CommonCornerPips:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CommonCornerPips)
			f6_arg0.TrialWidget:completeAnimation()
			f6_arg0.TrialWidget:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TrialWidget)
			f6_arg0.TrialText:completeAnimation()
			f6_arg0.TrialText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TrialText)
			f6_arg0.TrialCountdownText:completeAnimation()
			f6_arg0.TrialCountdownText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TrialCountdownText)
		end,
	},
}
CoD.TrialCountdownSmallWidget.__onClose = function(f7_arg0)
	f7_arg0.CommonCornerPips:close()
	f7_arg0.TrialWidget:close()
	f7_arg0.TrialCountdownText:close()
end
