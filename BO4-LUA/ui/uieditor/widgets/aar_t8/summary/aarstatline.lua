require("x64:29187ea00d726c3")
CoD.AARStatLine = InheritFrom(LUI.UIElement)
CoD.AARStatLine.__defaultWidth = 243
CoD.AARStatLine.__defaultHeight = 21
CoD.AARStatLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARStatLine)
	self.id = "AARStatLine"
	self.soundSet = "default"
	local RatioLabel = LUI.UIText.new(0, 0, 0, 240, 0, 0, 0, 21)
	RatioLabel:setRGB(0.9, 0.89, 0.78)
	RatioLabel:setAlpha(0.25)
	RatioLabel:setText(Engine[0xF9F1239CFD921FE](0xC6FCD3D2BEA972))
	RatioLabel:setTTF("dinnext_regular")
	RatioLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(RatioLabel)
	self.RatioLabel = RatioLabel
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 240, 248, 0, 0, -15, 36)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local KDRatio = LUI.UIText.new(0, 0, 248, 426, 0, 0, 0, 21)
	KDRatio:setRGB(0.9, 0.89, 0.78)
	KDRatio:setAlpha(0.25)
	KDRatio:setTTF("dinnext_regular")
	KDRatio:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	KDRatio:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	KDRatio:linkToElementModel(self, "kdRatio", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			KDRatio:setText(f2_local0)
		end
	end)
	self:addElement(KDRatio)
	self.KDRatio = KDRatio
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARStatLine.__onClose = function(f3_arg0)
	f3_arg0.VerticalListSpacer:close()
	f3_arg0.KDRatio:close()
end
