CoD.FooterButton_PartyCount = InheritFrom(LUI.UIElement)
CoD.FooterButton_PartyCount.__defaultWidth = 240
CoD.FooterButton_PartyCount.__defaultHeight = 38
CoD.FooterButton_PartyCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.FooterButton_PartyCount)
	self.id = "FooterButton_PartyCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Label = LUI.UIText.new(0, 0, 0, 52, 0, 0, 9, 29)
	Label:setRGB(0.49, 0.49, 0.49)
	Label:setText(LocalizeToUpperString(0x56004A0B4E33CD8))
	Label:setTTF("ttmussels_regular")
	Label:setLetterSpacing(6)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Label)
	self.Label = Label
	local Spacer2 = LUI.UIImage.new(0, 0, 58, 64, 0, 0, -4, 44)
	Spacer2:setRGB(0, 0, 0)
	Spacer2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	local Spacer = LUI.UIImage.new(0, 0, 52, 58, 0, 0, 1, 49)
	Spacer:setRGB(0, 0, 0)
	Spacer:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Spacer)
	self.Spacer = Spacer
	local PartyCount = LUI.UIText.new(0, 0, 64, 153, 0, 0, 9, 29)
	PartyCount.__String_Reference = function()
		PartyCount:setText(ToUpper(CoD.DirectorUtility.PrivateLobbyListPlayerCountAndMax()))
	end
	PartyCount.__String_Reference()
	PartyCount:setTTF("ttmussels_regular")
	PartyCount:setLetterSpacing(6)
	PartyCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(PartyCount)
	self.PartyCount = PartyCount
	local MatchmakingCount = LUI.UIText.new(0, 0, 64, 153, 0, 0, 9, 29)
	MatchmakingCount:setAlpha(0)
	MatchmakingCount.__String_Reference = function()
		MatchmakingCount:setText(CoD.DirectorUtility.LobbyListPlayerCountAndMax())
	end
	MatchmakingCount.__String_Reference()
	MatchmakingCount:setTTF("ttmussels_regular")
	MatchmakingCount:setLetterSpacing(6)
	MatchmakingCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(MatchmakingCount)
	self.MatchmakingCount = MatchmakingCount
	local f1_local6 = PartyCount
	local f1_local7 = PartyCount.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.privateClient.update"], PartyCount.__String_Reference)
	f1_local6 = PartyCount
	f1_local7 = PartyCount.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.gameClient.update"], PartyCount.__String_Reference)
	f1_local6 = MatchmakingCount
	f1_local7 = MatchmakingCount.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.privateClient.update"], MatchmakingCount.__String_Reference)
	f1_local6 = MatchmakingCount
	f1_local7 = MatchmakingCount.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.gameClient.update"], MatchmakingCount.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "Matchmaking",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
			end,
		},
	})
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.publicLobby.stage"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_PartyCount.__resetProperties = function(f6_arg0)
	f6_arg0.Label:completeAnimation()
	f6_arg0.MatchmakingCount:completeAnimation()
	f6_arg0.PartyCount:completeAnimation()
	f6_arg0.Label:setText(LocalizeToUpperString(0x56004A0B4E33CD8))
	f6_arg0.MatchmakingCount:setAlpha(0)
	f6_arg0.PartyCount:setAlpha(1)
end
CoD.FooterButton_PartyCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Matchmaking = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.Label:completeAnimation()
			f8_arg0.Label:setText(LocalizeToUpperString(0xE20D5225108123D))
			f8_arg0.clipFinished(f8_arg0.Label)
			f8_arg0.PartyCount:completeAnimation()
			f8_arg0.PartyCount:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PartyCount)
			f8_arg0.MatchmakingCount:completeAnimation()
			f8_arg0.MatchmakingCount:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.MatchmakingCount)
		end,
	},
}
CoD.FooterButton_PartyCount.__onClose = function(f9_arg0)
	f9_arg0.PartyCount:close()
	f9_arg0.MatchmakingCount:close()
end
