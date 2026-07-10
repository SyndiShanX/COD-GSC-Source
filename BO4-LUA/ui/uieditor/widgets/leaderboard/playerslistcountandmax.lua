require("x64:a9255c570c68aa8")
CoD.PlayersListCountandMax = InheritFrom(LUI.UIElement)
CoD.PlayersListCountandMax.__defaultWidth = 298
CoD.PlayersListCountandMax.__defaultHeight = 21
CoD.PlayersListCountandMax.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayersListCountandMax)
	self.id = "PlayersListCountandMax"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayersListCountAndMax = LUI.UIText.new(0, 0, 4, 302, 0, 0, 0, 21)
	PlayersListCountAndMax.__String_Reference = function()
		PlayersListCountAndMax:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.LeaderboardUtility.PlayerListCountAndMax(@"hash_6F5CB6FA437BAEF")))
	end
	PlayersListCountAndMax.__String_Reference()
	PlayersListCountAndMax:setTTF("ttmussels_regular")
	PlayersListCountAndMax:setLineSpacing(4)
	PlayersListCountAndMax:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayersListCountAndMax:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayersListCountAndMax)
	self.PlayersListCountAndMax = PlayersListCountAndMax
	local PlayerNumberFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 298, 1, 1, 0, 26)
	PlayerNumberFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerNumberFrame:setAlpha(0.02)
	self:addElement(PlayerNumberFrame)
	self.PlayerNumberFrame = PlayerNumberFrame
	local f1_local3 = PlayersListCountAndMax
	local f1_local4 = PlayersListCountAndMax.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["socialRoot.playersListCount"], PlayersListCountAndMax.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayersListCountandMax.__resetProperties = function(f4_arg0)
	f4_arg0.PlayersListCountAndMax:completeAnimation()
	f4_arg0.PlayerNumberFrame:completeAnimation()
	f4_arg0.PlayersListCountAndMax:setTopBottom(0, 0, 0, 21)
	f4_arg0.PlayersListCountAndMax:setLineSpacing(4)
	f4_arg0.PlayerNumberFrame:setTopBottom(1, 1, 0, 26)
end
CoD.PlayersListCountandMax.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.PlayersListCountAndMax:completeAnimation()
			f6_arg0.PlayersListCountAndMax:setTopBottom(0, 0, 0, 15)
			f6_arg0.PlayersListCountAndMax:setLineSpacing(13)
			f6_arg0.clipFinished(f6_arg0.PlayersListCountAndMax)
			f6_arg0.PlayerNumberFrame:completeAnimation()
			f6_arg0.PlayerNumberFrame:setTopBottom(1, 1, -2, 28)
			f6_arg0.clipFinished(f6_arg0.PlayerNumberFrame)
		end,
	},
}
CoD.PlayersListCountandMax.__onClose = function(f7_arg0)
	f7_arg0.PlayersListCountAndMax:close()
	f7_arg0.PlayerNumberFrame:close()
end
