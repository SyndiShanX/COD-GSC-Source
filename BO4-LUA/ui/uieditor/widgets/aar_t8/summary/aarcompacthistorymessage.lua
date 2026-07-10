CoD.AARCompactHistoryMessage = InheritFrom(LUI.UIElement)
CoD.AARCompactHistoryMessage.__defaultWidth = 800
CoD.AARCompactHistoryMessage.__defaultHeight = 38
CoD.AARCompactHistoryMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.AARCompactHistoryMessage)
	self.id = "AARCompactHistoryMessage"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AverageLabel = LUI.UIText.new(0, 0, 54.5, 554.5, 0, 0, 10, 29)
	AverageLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	AverageLabel:setAlpha(0.3)
	AverageLabel:setText(Engine[0xF9F1239CFD921FE](0x73D09C07F4B5680))
	AverageLabel:setTTF("ttmussels_regular")
	AverageLabel:setLetterSpacing(4)
	AverageLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AverageLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AverageLabel)
	self.AverageLabel = AverageLabel
	local Average = LUI.UIText.new(0, 0, 564.5, 745.5, 0, 0, 3, 34)
	Average:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Average:setAlpha(0.5)
	Average:setTTF("0arame_mono_stencil")
	Average:setLetterSpacing(1)
	Average:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Average:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Average:linkToElementModel(self, "averageStat", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Average:setText(f2_local0)
		end
	end)
	self:addElement(Average)
	self.Average = Average
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARCompactHistoryMessage.__resetProperties = function(f3_arg0)
	f3_arg0.Average:completeAnimation()
	f3_arg0.AverageLabel:completeAnimation()
	f3_arg0.Average:setAlpha(0.5)
	f3_arg0.AverageLabel:setAlpha(0.3)
end
CoD.AARCompactHistoryMessage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.AverageLabel:completeAnimation()
			f5_arg0.AverageLabel:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.AverageLabel)
			f5_arg0.Average:completeAnimation()
			f5_arg0.Average:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Average)
		end,
	},
}
CoD.AARCompactHistoryMessage.__onClose = function(f6_arg0)
	f6_arg0.Average:close()
end
