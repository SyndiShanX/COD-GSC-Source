CoD.DirectorLeaderActivityMain = InheritFrom(LUI.UIElement)
CoD.DirectorLeaderActivityMain.__defaultWidth = 888
CoD.DirectorLeaderActivityMain.__defaultHeight = 52
CoD.DirectorLeaderActivityMain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLeaderActivityMain)
	self.id = "DirectorLeaderActivityMain"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaderActivityText = LUI.UIText.new(0, 0, 131, 888, 0, 0, 0, 20)
	LeaderActivityText:setRGB(0.63, 0.62, 0.61)
	LeaderActivityText:setTTF("ttmussels_regular")
	LeaderActivityText:setLetterSpacing(6)
	LeaderActivityText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LeaderActivityText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LeaderActivityText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "leaderActivity", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LeaderActivityText:setText(ConvertToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(LeaderActivityText, "setText", function(element, controller)
		ScaleWidgetToLabelWrapped(self, element, 2, 0)
	end)
	self:addElement(LeaderActivityText)
	self.LeaderActivityText = LeaderActivityText
	local Waiting = LUI.UIText.new(0, 0, 0, 178, 0, 0, 0, 20)
	Waiting:setRGB(0.86, 0.74, 0.25)
	Waiting:setText(LocalizeToUpperString(0xA43B10D9DA121A))
	Waiting:setTTF("ttmussels_demibold")
	Waiting:setLetterSpacing(6)
	Waiting:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Waiting:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Waiting)
	self.Waiting = Waiting
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLeaderActivityMain.__resetProperties = function(f4_arg0)
	f4_arg0.LeaderActivityText:completeAnimation()
	f4_arg0.Waiting:completeAnimation()
	f4_arg0.LeaderActivityText:setLeftRight(0, 0, 131, 888)
	f4_arg0.LeaderActivityText:setTopBottom(0, 0, 0, 20)
	f4_arg0.LeaderActivityText:setAlpha(1)
	f4_arg0.Waiting:setAlpha(1)
end
CoD.DirectorLeaderActivityMain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.LeaderActivityText:completeAnimation()
			f5_arg0.LeaderActivityText:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.LeaderActivityText)
			f5_arg0.Waiting:completeAnimation()
			f5_arg0.Waiting:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Waiting)
		end,
	},
	Invisible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.LeaderActivityText:completeAnimation()
			f6_arg0.LeaderActivityText:setLeftRight(0, 0, 0, 458)
			f6_arg0.LeaderActivityText:setTopBottom(0, 0, 0, 30)
			f6_arg0.LeaderActivityText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.LeaderActivityText)
			f6_arg0.Waiting:completeAnimation()
			f6_arg0.Waiting:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Waiting)
		end,
	},
}
CoD.DirectorLeaderActivityMain.__onClose = function(f7_arg0)
	f7_arg0.LeaderActivityText:close()
end
