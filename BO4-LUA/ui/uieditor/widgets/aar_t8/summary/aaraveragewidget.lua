require("x64:29187ea00d726c3")
CoD.AARAverageWidget = InheritFrom(LUI.UIElement)
CoD.AARAverageWidget.__defaultWidth = 1500
CoD.AARAverageWidget.__defaultHeight = 38
CoD.AARAverageWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARAverageWidget)
	self.id = "AARAverageWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GametypeLabel = LUI.UIText.new(0, 0, 0, 500, 0, 0, 8.5, 29.5)
	GametypeLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	GametypeLabel:setAlpha(0.3)
	GametypeLabel:setTTF("ttmussels_regular")
	GametypeLabel:setLetterSpacing(4)
	GametypeLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GametypeLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	GametypeLabel:linkToElementModel(self, "gametype", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GametypeLabel:setText(LocalizeToUpperString(CoD.GameTypeUtility.GameTypeToLocalizeName(f2_local0)))
		end
	end)
	self:addElement(GametypeLabel)
	self.GametypeLabel = GametypeLabel
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 500, 515, 0, 0, 0, 38)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local DamageLabel = LUI.UIText.new(0, 0, 530, 1030, 0, 0, 9, 30)
	DamageLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	DamageLabel:setAlpha(0.3)
	DamageLabel:setText(Engine[0xF9F1239CFD921FE](0x73D09C07F4B5680))
	DamageLabel:setTTF("ttmussels_regular")
	DamageLabel:setLetterSpacing(4)
	DamageLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DamageLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DamageLabel)
	self.DamageLabel = DamageLabel
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 1030, 1050, 0, 0, 0, 38)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local Average = LUI.UIText.new(0, 0, 1060, 1241, 0, 0, 4, 35)
	Average:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Average:setAlpha(0.5)
	Average:setTTF("0arame_mono_stencil")
	Average:setLetterSpacing(1)
	Average:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Average:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Average:linkToElementModel(self, "averageStat", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Average:setText(f3_local0)
		end
	end)
	self:addElement(Average)
	self.Average = Average
	self:mergeStateConditions({
		{
			stateName = "WinLose",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsWinLoseStat(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["AAR.activeStat"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "AAR.activeStat",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARAverageWidget.__resetProperties = function(f6_arg0)
	f6_arg0.Average:completeAnimation()
	f6_arg0.DamageLabel:completeAnimation()
	f6_arg0.GametypeLabel:completeAnimation()
	f6_arg0.Average:setAlpha(0.5)
	f6_arg0.DamageLabel:setAlpha(0.3)
	f6_arg0.GametypeLabel:setAlpha(0.3)
end
CoD.AARAverageWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Average:completeAnimation()
			f7_arg0.Average:setAlpha(0.5)
			f7_arg0.clipFinished(f7_arg0.Average)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
	WinLose = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.GametypeLabel:completeAnimation()
			f8_arg0.GametypeLabel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GametypeLabel)
			f8_arg0.DamageLabel:completeAnimation()
			f8_arg0.DamageLabel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DamageLabel)
			f8_arg0.Average:completeAnimation()
			f8_arg0.Average:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Average)
		end,
	},
}
CoD.AARAverageWidget.__onClose = function(f9_arg0)
	f9_arg0.GametypeLabel:close()
	f9_arg0.VerticalListSpacer2:close()
	f9_arg0.VerticalListSpacer:close()
	f9_arg0.Average:close()
end
