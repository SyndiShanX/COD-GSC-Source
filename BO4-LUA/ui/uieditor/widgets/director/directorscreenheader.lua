require("x64:74bc54d99844536")
CoD.DirectorScreenHeader = InheritFrom(LUI.UIElement)
CoD.DirectorScreenHeader.__defaultWidth = 643
CoD.DirectorScreenHeader.__defaultHeight = 100
CoD.DirectorScreenHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorScreenHeader)
	self.id = "DirectorScreenHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Header = LUI.UIText.new(0, 0, 103, 643, 0, 0, 35, 65)
	Header:setRGB(0.86, 0.74, 0.25)
	Header:setText(LocalizeToUpperString(0xDDDA371285672BD))
	Header:setTTF("ttmussels_regular")
	Header:setLetterSpacing(14)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Header)
	self.Header = Header
	local DirectorLeaderActivityMain = CoD.DirectorLeaderActivityMain.new(f1_arg0, f1_arg1, 0, 0, 0, 888, 0, 0, 50, 102)
	DirectorLeaderActivityMain:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	DirectorLeaderActivityMain:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorLeaderActivityMain, f3_arg1)
	end)
	DirectorLeaderActivityMain:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorLeaderActivityMain, f4_arg1)
	end)
	local f1_local3 = DirectorLeaderActivityMain
	local f1_local4 = DirectorLeaderActivityMain.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivityMain, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = DirectorLeaderActivityMain
	f1_local4 = DirectorLeaderActivityMain.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.gameClient.update"], function(f6_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivityMain, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local3 = DirectorLeaderActivityMain
	f1_local4 = DirectorLeaderActivityMain.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.privateClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivityMain, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorLeaderActivityMain:setAlpha(0)
	self:addElement(DirectorLeaderActivityMain)
	self.DirectorLeaderActivityMain = DirectorLeaderActivityMain
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorScreenHeader.__onClose = function(f8_arg0)
	f8_arg0.DirectorLeaderActivityMain:close()
end
