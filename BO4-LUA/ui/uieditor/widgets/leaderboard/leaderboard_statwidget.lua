require("x64:a9255c570c68aa8")
CoD.Leaderboard_StatWidget = InheritFrom(LUI.UIElement)
CoD.Leaderboard_StatWidget.__defaultWidth = 119
CoD.Leaderboard_StatWidget.__defaultHeight = 127
CoD.Leaderboard_StatWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard_StatWidget)
	self.id = "Leaderboard_StatWidget"
	self.soundSet = "CAC_PrimaryWeapon"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatText = LUI.UIText.new(0.5, 0.5, -53, 53, 0, 0, 72, 110)
	StatText:setRGB(0.58, 0.64, 0.65)
	StatText:setText("")
	StatText:setTTF("ttmussels_demibold")
	StatText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	StatText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(StatText)
	self.StatText = StatText
	local btnDisplayTextStroke = LUI.UIText.new(0, 0, 0, 119, 0, 0, 17, 35)
	btnDisplayTextStroke:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	btnDisplayTextStroke:setText("")
	btnDisplayTextStroke:setTTF("ttmussels_regular")
	btnDisplayTextStroke:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	btnDisplayTextStroke:setShaderVector(0, 0.06, 0, 0, 0)
	btnDisplayTextStroke:setShaderVector(1, 0.02, 0, 0, 0)
	btnDisplayTextStroke:setShaderVector(2, 1, 0, 0, 0)
	btnDisplayTextStroke:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	btnDisplayTextStroke:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(btnDisplayTextStroke)
	self.btnDisplayTextStroke = btnDisplayTextStroke
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 119, 0, 0, 55, 127)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.02)
	self:addElement(Frame)
	self.Frame = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Leaderboard_StatWidget.__resetProperties = function(f2_arg0)
	f2_arg0.btnDisplayTextStroke:completeAnimation()
	f2_arg0.StatText:completeAnimation()
	f2_arg0.btnDisplayTextStroke:setAlpha(1)
	f2_arg0.StatText:setAlpha(1)
end
CoD.Leaderboard_StatWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.StatText:completeAnimation()
			f4_arg0.StatText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.StatText)
			f4_arg0.btnDisplayTextStroke:completeAnimation()
			f4_arg0.btnDisplayTextStroke:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.btnDisplayTextStroke)
		end,
	},
}
CoD.Leaderboard_StatWidget.__onClose = function(f5_arg0)
	f5_arg0.Frame:close()
end
