require("x64:b99cf3e07b13338")
CoD.DirectorLeaderActivitySelect = InheritFrom(LUI.UIElement)
CoD.DirectorLeaderActivitySelect.__defaultWidth = 305
CoD.DirectorLeaderActivitySelect.__defaultHeight = 50
CoD.DirectorLeaderActivitySelect.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLeaderActivitySelect)
	self.id = "DirectorLeaderActivitySelect"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundWidget = CoD.DirectorLeaderActivityBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BackgroundWidget)
	self.BackgroundWidget = BackgroundWidget
	local LeaderActivityText = LUI.UIText.new(0, 0, 8, 298, 0, 0, 25, 43)
	LeaderActivityText:setRGB(0.63, 0.62, 0.61)
	LeaderActivityText:setTTF("ttmussels_regular")
	LeaderActivityText:setLetterSpacing(4)
	LeaderActivityText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LeaderActivityText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LeaderActivityText:setBackingType(2)
	LeaderActivityText:setBackingColor(0, 0, 0)
	LeaderActivityText:setBackingXPadding(8)
	LeaderActivityText:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	LeaderActivityText:setBackingShaderVector(0, 0, 0.8, 0, 0)
	LeaderActivityText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "leaderActivity", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LeaderActivityText:setText(f2_local0)
		end
	end)
	self:addElement(LeaderActivityText)
	self.LeaderActivityText = LeaderActivityText
	local Header = LUI.UIText.new(0, 0, 8, 298, 0, 0, 6, 24)
	Header:setRGB(0.86, 0.74, 0.25)
	Header:setText(LocalizeToUpperString(0xA43B10D9DA121A))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(6)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Header)
	self.Header = Header
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLeaderActivitySelect.__resetProperties = function(f3_arg0)
	f3_arg0.LeaderActivityText:completeAnimation()
	f3_arg0.Header:completeAnimation()
	f3_arg0.BackgroundWidget:completeAnimation()
	f3_arg0.LeaderActivityText:setLeftRight(0, 0, 8, 298)
	f3_arg0.LeaderActivityText:setTopBottom(0, 0, 25, 43)
	f3_arg0.LeaderActivityText:setAlpha(1)
	f3_arg0.Header:setAlpha(1)
	f3_arg0.BackgroundWidget:setAlpha(1)
end
CoD.DirectorLeaderActivitySelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.LeaderActivityText:completeAnimation()
			f4_arg0.LeaderActivityText:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.LeaderActivityText)
			f4_arg0.Header:completeAnimation()
			f4_arg0.Header:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Header)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.BackgroundWidget:completeAnimation()
			f5_arg0.BackgroundWidget:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BackgroundWidget)
			f5_arg0.LeaderActivityText:completeAnimation()
			f5_arg0.LeaderActivityText:setLeftRight(0, 0, 0, 176)
			f5_arg0.LeaderActivityText:setTopBottom(0, 0, 0, 30)
			f5_arg0.LeaderActivityText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.LeaderActivityText)
			f5_arg0.Header:completeAnimation()
			f5_arg0.Header:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Header)
		end,
	},
}
CoD.DirectorLeaderActivitySelect.__onClose = function(f6_arg0)
	f6_arg0.BackgroundWidget:close()
	f6_arg0.LeaderActivityText:close()
end
