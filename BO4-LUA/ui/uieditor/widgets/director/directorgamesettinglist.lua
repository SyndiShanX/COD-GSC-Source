require("x64:99852387867c4f4")
require("x64:41b4f8e8fb49420")
require("x64:26a07cda52826ea")
CoD.DirectorGameSettingList = InheritFrom(LUI.UIElement)
CoD.DirectorGameSettingList.__defaultWidth = 356
CoD.DirectorGameSettingList.__defaultHeight = 420
CoD.DirectorGameSettingList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 53, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.DirectorGameSettingList)
	self.id = "DirectorGameSettingList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapImage = CoD.DirectorMapAndGameType.new(f1_arg0, f1_arg1, 0, 0, 0, 356, 0, 0, 0, 200)
	MapImage.MapImage.DirectorMapAndGameInternal.PlaylistHeaderBacking:setAlpha(0)
	MapImage.MapImage.DirectorMapAndGameInternal.PlaylistHeader:setAlpha(0)
	MapImage:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage.MapImage.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f2_local0)))
		end
	end)
	MapImage:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	MapImage:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = MapImage
	local GameRules = MapImage.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	GameRules(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = MapImage
	GameRules = MapImage.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	GameRules(f1_local2, f1_local4["lobbyRoot.gameClient.update"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = MapImage
	GameRules = MapImage.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	GameRules(f1_local2, f1_local4["lobbyRoot.privateClient.update"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	MapImage:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapImage, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsPC() and IsLobbyHostOfCurrentMenu() then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			CoD.LobbyUtility.SetLeaderActivityAndOpenOverlay(self, controller, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP, "DirectorChooseMapAndGameType")
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsPC() and IsLobbyHostOfCurrentMenu() then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			CoD.LobbyUtility.SetLeaderActivityAndOpenOverlay(self, controller, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP, "DirectorChooseMapAndGameType")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsPC() and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(MapImage)
	self.MapImage = MapImage
	GameRules = CoD.DirectorGameRules.new(f1_arg0, f1_arg1, 0, 0, 0, 356, 0, 0, 253, 453)
	GameRules:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsLobbyMenu(f1_arg1, LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY)
			end,
		},
	})
	f1_local4 = GameRules
	f1_local2 = GameRules.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(GameRules, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	GameRules:appendEventHandler("on_session_start", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	GameRules:appendEventHandler("on_session_end", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local4 = GameRules
	f1_local2 = GameRules.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = GameRules
	f1_local2 = GameRules.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.gameClient.update"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = GameRules
	f1_local2 = GameRules.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.privateClient.update"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	GameRules:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f18_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameRules, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsPC() and IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			CoD.LobbyUtility.OpenEditGameRules(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsPC() and IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			CoD.LobbyUtility.OpenEditGameRules(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsPC() and IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(GameRules)
	self.GameRules = GameRules
	self:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	MapImage.id = "MapImage"
	GameRules.id = "GameRules"
	self.__defaultFocus = MapImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorGameSettingList.__resetProperties = function(f23_arg0)
	f23_arg0.GameRules:completeAnimation()
	f23_arg0.GameRules:setAlpha(1)
end
CoD.DirectorGameSettingList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.GameRules:completeAnimation()
			f25_arg0.GameRules:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.GameRules)
		end,
	},
}
CoD.DirectorGameSettingList.__onClose = function(f26_arg0)
	f26_arg0.MapImage:close()
	f26_arg0.GameRules:close()
end
