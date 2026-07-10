require("x64:9590c0895bbcb95")
require("x64:eec04ec8cdb9467")
CoD.ArenaMapAndGameType = InheritFrom(LUI.UIElement)
CoD.ArenaMapAndGameType.__defaultWidth = 382
CoD.ArenaMapAndGameType.__defaultHeight = 150
CoD.ArenaMapAndGameType.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaMapAndGameType)
	self.id = "ArenaMapAndGameType"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaMapAndGameType = CoD.ArenaMapAndGameTypeContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 382, 0, 0, 0, 150)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.GamemodeIcon:setAlpha(0)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.PlaylistHeaderBacking:setAlpha(0)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.PlaylistHeader:setAlpha(0)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.PlaylistHeaderNonHost:setAlpha(0)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.MapImage.__MapImage_Image = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			ArenaMapAndGameType.ArenaMapAndGameTypeInternal.MapImage:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToPlaylistImageTileSmall(f2_local0)))
		end
	end
	ArenaMapAndGameType:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", ArenaMapAndGameType.ArenaMapAndGameTypeInternal.MapImage.__MapImage_Image)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.MapImage.__MapImage_Image_FullPath = function()
		local f3_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f3_local0 = f3_local0.playlistId
		if f3_local0 then
			ArenaMapAndGameType.ArenaMapAndGameTypeInternal.MapImage.__MapImage_Image(f3_local0)
		end
	end
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label.__Lable_Desc = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(ToUpper(CoD.DirectorUtility.PlaylistIDToPlaylistDesc(f4_local0)))
		end
	end
	ArenaMapAndGameType:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label.__Lable_Desc)
	ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label.__Lable_Desc_FullPath = function()
		local f5_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f5_local0 = f5_local0.playlistId
		if f5_local0 then
			ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label.__Lable_Desc(f5_local0)
		end
	end
	ArenaMapAndGameType:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventName", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(ToUpper(f6_local0))
		end
	end)
	ArenaMapAndGameType:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ArenaMapAndGameType, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.DirectorUtility.DirectorOpenOverlayWithCurrentMenuMode(menu, controller, "LeaguePlayOverview")
		PlaySoundAlias("uin_press_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(ArenaMapAndGameType)
	self.ArenaMapAndGameType = ArenaMapAndGameType
	local f1_local2 = ArenaMapAndGameType
	local f1_local3 = ArenaMapAndGameType.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNetworkMode"], ArenaMapAndGameType.ArenaMapAndGameTypeInternal.MapImage.__MapImage_Image_FullPath)
	f1_local2 = ArenaMapAndGameType
	f1_local3 = ArenaMapAndGameType.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNetworkMode"], ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label.__Lable_Desc_FullPath)
	f1_local2 = ArenaMapAndGameType
	f1_local3 = ArenaMapAndGameType.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4["privateClient.count"], ArenaMapAndGameType.ArenaMapAndGameTypeInternal.DirectorMapAndGameTypeInternalTitles.Label.__Lable_Desc_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Event",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730])
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyPlaylist.name"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ArenaMapAndGameType.id = "ArenaMapAndGameType"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaMapAndGameType.__onClose = function(f13_arg0)
	f13_arg0.ArenaMapAndGameType:close()
end
