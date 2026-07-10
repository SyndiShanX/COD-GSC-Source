require("x64:19c1945d2e472b0")
CoD.ArenaLobbyButtonText = InheritFrom(LUI.UIElement)
CoD.ArenaLobbyButtonText.__defaultWidth = 325
CoD.ArenaLobbyButtonText.__defaultHeight = 37
CoD.ArenaLobbyButtonText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaLobbyButtonText)
	self.id = "ArenaLobbyButtonText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonText = LUI.UIText.new(0.5, 0.5, -101.5, 101.5, 0.5, 0.5, -12, 12)
	ButtonText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ButtonText:setText(LocalizeToUpperString(0xCBB14C4892283F2))
	ButtonText:setTTF("ttmussels_regular")
	ButtonText:setLetterSpacing(3)
	ButtonText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ButtonText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(ButtonText)
	self.ButtonText = ButtonText
	self:mergeStateConditions({
		{
			stateName = "LeaguePlay",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.IsArenaLeaguePlay(false)
			end,
		},
		{
			stateName = "Unranked",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0x185075D2D3D8497])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyPlaylist.name"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaLobbyButtonText.__resetProperties = function(f6_arg0)
	f6_arg0.ButtonText:completeAnimation()
	f6_arg0.ButtonText:setText(LocalizeToUpperString(0xCBB14C4892283F2))
end
CoD.ArenaLobbyButtonText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	LeaguePlay = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ButtonText:completeAnimation()
			f8_arg0.ButtonText:setText(LocalizeToUpperString(0x3E56959987630DF))
			f8_arg0.clipFinished(f8_arg0.ButtonText)
		end,
	},
	Unranked = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ButtonText:completeAnimation()
			f9_arg0.ButtonText:setText(LocalizeToUpperString(0x457699E1F8C73C))
			f9_arg0.clipFinished(f9_arg0.ButtonText)
		end,
	},
}
