CoD.ChatClientUtility = {}
CoD.ChatClientUtility.MaxWhisperPickerNames = 5
CoD.ChatClientUtility.Properties = {}
CoD.ChatClientUtility.GetChatGlobalModel = function(f1_arg0)
	return Engine.GetModel(Engine.GetModelForController(f1_arg0), "ChatGlobal")
end
CoD.ChatClientUtility.GetChatClientGlobalModel = function()
	return Engine.CreateModel(Engine.GetGlobalModel(), "ChatClientGlobal")
end
CoD.ChatClientUtility.GetEventModel = function(f3_arg0)
	return Engine.GetModel(CoD.ChatClientUtility.GetChatGlobalModel(f3_arg0), "Event")
end
CoD.ChatClientUtility.GetChatEntriesListModel = function(f4_arg0)
	return Engine.CreateModel(CoD.ChatClientUtility.GetChatGlobalModel(f4_arg0), "ChatClientEntriesList")
end
CoD.ChatClientUtility.GetInputChannelModel = function(f5_arg0)
	return Engine.CreateModel(CoD.ChatClientUtility.GetChatGlobalModel(f5_arg0), "InputChannel")
end
CoD.ChatClientUtility.GetInputTextModel = function(f6_arg0)
	return Engine.CreateModel(CoD.ChatClientUtility.GetChatGlobalModel(f6_arg0), "InputText")
end
CoD.ChatClientUtility.GetCurrentChattingModel = function(f7_arg0)
	if CoD.isFrontend then
		return CoD.ChatClientUtility.GetMenuChatActiveModeModel(f7_arg0)
	else
		return CoD.ChatClientUtility.GetInGameChattingModel(f7_arg0)
	end
end
CoD.ChatClientUtility.GetInGameChattingModel = function(f8_arg0)
	return Engine.CreateModel(CoD.ChatClientUtility.GetChatGlobalModel(f8_arg0), "inGameChatActive")
end
CoD.ChatClientUtility.GetMenuChatActiveModeModel = function(f9_arg0)
	return Engine.CreateModel(CoD.ChatClientUtility.GetChatGlobalModel(f9_arg0), "MenuChatInActiveMode")
end
CoD.ChatClientUtility.GetStaticChatAllowedModel = function(f10_arg0)
	return Engine.CreateModel(CoD.ChatClientUtility.GetChatGlobalModel(f10_arg0), "StaticChatAllowed")
end
CoD.ChatClientUtility.ResetMenuShow = function() end
CoD.ChatClientUtility.ResetSettingsModels = function(f12_arg0)
	local f12_local0 = CoD.ChatClientUtility.GetChatGlobalModel(f12_arg0)
	local f12_local1 = nil
end
CoD.ChatClientUtility.ResetAllModels = function(f13_arg0)
	local f13_local0 = CoD.ChatClientUtility.GetChatGlobalModel(f13_arg0)
	local f13_local1 = CoD.ChatClientUtility.GetInputChannelModel(f13_arg0)
	f13_local1 = f13_local1:get()
	local f13_local2 = Engine[@"hash_6D4866B78C88BFD1"](f13_local1)
	local f13_local3 = "255 255 255"
	if f13_local2 then
		f13_local3 = CoD.ChatClientUtility.ColorToString(CoD.ChatClientUtility.GetColorForChannelType(Engine[@"hash_5884871F4FF3ACA"](f13_local1)))
	end
	Engine.SetModelValue(CoD.ChatClientUtility.GetInputTextModel(f13_arg0), "")
	CoD.ChatClientUtility.ResetMenuShow()
	CoD.ChatClientUtility.ResetSettingsModels(f13_arg0)
	return f13_local0
end
CoD.ChatClientUtility.UpdateOptionsModels = function(f14_arg0)
	Engine[@"hash_37186ADD46E1FE57"]()
	CoD.ChatClientUtility.ResetMenuShow()
	CoD.ChatClientUtility.ResetSettingsModels(f14_arg0)
	Engine.exec(f14_arg0, "chatClientUpdate")
end
CoD.ChatClientUtility.SetChannelTo = function(f15_arg0, f15_arg1)
	if Engine[@"hash_6D4866B78C88BFD1"](f15_arg1) then
		Engine.SetModelValue(CoD.ChatClientUtility.GetInputChannelModel(f15_arg0), f15_arg1)
	end
	return false
end
CoD.ChatClientUtility.SetChannelToAll = function(f16_arg0, f16_arg1)
	CoD.ChatClientUtility.SetChannelTo(f16_arg0, Engine[@"hash_5F4AC963487AA68C"](Enum[@"hash_7F6296F5D7A38AD2"][@"hash_18AE60B993F07980"]))
	return f16_arg1, f16_arg1 == nil, f16_arg1 ~= nil
end
CoD.ChatClientUtility.SetChannelToTeam = function(f17_arg0, f17_arg1)
	CoD.ChatClientUtility.SetChannelTo(f17_arg0, Engine[@"hash_5F4AC963487AA68C"](Enum[@"hash_7F6296F5D7A38AD2"][@"hash_6EB1743CA5B28F23"]))
	return f17_arg1, f17_arg1 == nil, f17_arg1 ~= nil
end
CoD.ChatClientUtility.SetChannelToParty = function(f18_arg0, f18_arg1)
	CoD.ChatClientUtility.SetChannelTo(f18_arg0, Engine[@"hash_5F4AC963487AA68C"](Enum[@"hash_7F6296F5D7A38AD2"][@"hash_127F47164723263E"]))
	return f18_arg1, f18_arg1 == nil, f18_arg1 ~= nil
end
CoD.ChatClientUtility.SetChannelToReply = function(f19_arg0, f19_arg1)
	local f19_local0 = Engine[@"hash_5D565928AFAD7A09"]()
	if f19_local0 then
		CoD.ChatClientUtility.SetChannelTo(f19_arg0, f19_local0)
	end
	local f19_local1 = f19_arg1
	local f19_local2
	if f19_arg1 ~= nil and f19_local0 ~= nil then
		f19_local2 = false
	else
		f19_local2 = true
	end
	return f19_local1, f19_local2, f19_local0 == nil
end
local f0_local0 = function(f20_arg0, f20_arg1)
	f20_arg1 = string.lower(f20_arg1)
	for f20_local4, f20_local5 in pairs(Engine[@"hash_2E40639D3AA297FB"]()) do
		if f20_local5.type == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_75E57997D82BCBD1"] and string.lower(CoD.PCBattlenetUtility.StripBattleTagNumber(f20_local5.name)) == f20_arg1 then
			local f20_local3 = Engine[@"hash_3E6407C28FDBDF2C"](f20_local5.chatid)
			return f20_local3[1].xuid
		end
	end
	for f20_local5, f20_local6 in pairs(Engine.GetFriends(f20_arg0)) do
		if string.lower(CoD.PCBattlenetUtility.StripBattleTagNumber(f20_local6.gamertag)) == f20_arg1 then
			return f20_local6.xuid
		end
	end
	return nil
end
local f0_local1 = function(f21_arg0)
	local f21_local0 = {}
	for f21_local6, f21_local7 in pairs(Engine[@"hash_2E40639D3AA297FB"]()) do
		if f21_local7.type == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_75E57997D82BCBD1"] then
			local f21_local4 = Engine[@"hash_3E6407C28FDBDF2C"](f21_local7.chatid)
			local f21_local5 = CoD.PCBattlenetUtility.StripBattleTagNumber(f21_local7.name)
			f21_local0[f21_local5] = {
				actionName = f21_local5,
				getActionFunction = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
					return function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
						local f23_local0 = CoD.ChatClientUtility.GetAndJoinWhisperChannelIdByXuid(f23_arg2, f21_local4[1].xuid)
						if f23_local0 then
							CoD.ChatClientUtility.SetChannelTo(f23_arg2, f23_local0)
							Engine[@"hash_6DB3C4FD727ED616"](f23_arg2)
						end
					end
				end,
			}
		end
	end
	for f21_local7, f21_local4 in pairs(Engine.GetFriends(f21_arg0)) do
		local f21_local5 = CoD.PCBattlenetUtility.StripBattleTagNumber(f21_local4.gamertag)
		if f21_local0[f21_local5] == nil then
			f21_local0[f21_local5] = {
				actionName = f21_local5,
				getActionFunction = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
					return function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
						local f25_local0 = CoD.ChatClientUtility.GetAndJoinWhisperChannelIdByXuid(f25_arg2, f21_local4.xuid)
						if f25_local0 then
							CoD.ChatClientUtility.SetChannelTo(f25_arg2, f25_local0)
							Engine[@"hash_6DB3C4FD727ED616"](f25_arg2)
						end
					end
				end,
			}
		end
	end
	return f21_local0
end
local f0_local2 = function(f26_arg0, f26_arg1)
	local f26_local0 = function(f27_arg0, f27_arg1, f27_arg2)
		local f27_local0, f27_local1, f27_local2, f27_local3 = f27_arg0:getLocalRect()
		local f27_local4 = 1
		local f27_local5 = 1
		local f27_local6, f27_local7 = Engine[@"getscreensize"](f27_arg2)
		local f27_local8, f27_local9, f27_local10, f27_local11 = f27_arg1:getRect()
		if f27_local8 ~= nil then
			f27_local4 = f27_local6 / (f27_local10 - f27_local8)
			f27_local5 = f27_local7 / (f27_local11 - f27_local9)
		end
		local f27_local12 = CoD.ChatClientUtility.ChatWidget:getFirstChild()
		local f27_local12, f27_local13, f27_local14, f27_local15 = f27_local12.InputText:getRect()
		local f27_local16 = f27_local12 * f27_local4
		local f27_local17 = f27_local13 * f27_local5
		local f27_local18 = math.max(CoD.ChatAutoComplete.__defaultWidth, f27_arg1.ContextualMenu:GetLargestTextWidth() + 20)
		local f27_local19 = math.max(f27_arg0.height, CoD.ChatAutoCompleteAction.__defaultHeight)
		local f27_local20 = f27_local16 + f27_local18
		if f27_local6 < f27_local20 then
			local f27_local21 = math.min(f27_local20 - f27_local6, f27_local16)
			f27_local16 = f27_local16 - f27_local21
			f27_local20 = f27_local20 - f27_local21
		end
		local f27_local21 = f27_local17 - f27_local19
		if f27_local21 < 0 then
			local f27_local22 = math.max(f27_local21 + f27_local7, f27_local17)
			f27_local17 = f27_local17 + f27_local22
			f27_local21 = f27_local21 + f27_local22
		end
		f27_arg1.ContextualMenu:setLeftRight(0, 0, f27_local16, f27_local20)
		f27_arg1.ContextualMenu:setTopBottom(0, 0, f27_local21, f27_local17)
	end
	CoD.PCWidgetUtility.CloseContextualMenu(f26_arg0, f26_arg1)
	CoD.PCWidgetUtility.ContextualMenuTitleModel = nil
	CoD.PCWidgetUtility.PrepareContextualMenuActions(CoD.ChatClientUtility.ChatWidget, f26_arg0, f26_arg1, nil, f0_local1(f26_arg1))
	if #CoD.PCWidgetUtility.ContextualMenuActions == 0 then
		return false
	end
	f26_arg0.ContextualMenu = CoD.ChatAutoComplete.new(f26_arg0, f26_arg1, 0, 0, 0, 0, 0, 0, 0, 0)
	f26_arg0.ContextualMenu.initDone = false
	f26_arg0.ContextualMenu:setPriority(2000)
	f26_arg0.ChatAutoComplete = f26_arg0.ContextualMenu
	f26_arg0:addElement(f26_arg0.ContextualMenu)
	local f26_local1 = f26_arg0.ContextualMenu.ActionList
	f26_local1:setVerticalCount(math.min(#CoD.PCWidgetUtility.ContextualMenuActions, CoD.ChatClientUtility.MaxWhisperPickerNames))
	f26_local1:setAutoScaleContentHeight(false)
	f26_arg0:sendInitializationEvents(f26_arg1, f26_arg0.ContextualMenu)
	LUI.GridLayout.menuOpened(f26_local1)
	f26_local0(f26_local1, f26_arg0, f26_arg1)
	local f26_local2 = function()
		for f28_local3, f28_local4, f28_local5 in f26_local1:forEachElement() do
			if CoD.SafeGetModelValue(f28_local5:getModel(), "getActionFunction") then
				f26_arg0:AddButtonCallbackFunction(f28_local5, f26_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
					local f29_local0 = f29_arg0:getModel()
					if f29_local0 and f29_local0.getActionFunction then
						local f29_local1 = f29_local0.getActionFunction:get()
						f29_local1 = f29_local1(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
						if f29_local1 then
							f29_local1(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
						end
					end
					CoD.PCWidgetUtility.CloseContextualMenu(f26_arg0, f26_arg1)
					return true
				end, nil, false)
			end
		end
	end
	f26_local2()
	f26_arg0.ContextualMenu:registerEventHandler("input_source_changed", function(element, event)
		CoD.PCWidgetUtility.CloseContextualMenu(f26_arg0, f26_arg1)
		return true
	end)
	if f26_arg0.lastPCInputFocusElemEvent then
		f26_arg0.letMouse1Through = true
	end
	CoD.BaseUtility.InitControllerModelIfNotSet(f26_arg1, "EditBoxGlobal.ChatWhisperName", "")
	local f26_local3 = f26_arg0.ContextualMenu
	local f26_local4 = f26_local3
	f26_local3 = f26_local3.subscribeToModel
	local f26_local5 = Engine.GetModelForController(f26_arg1)
	f26_local3(f26_local4, f26_local5["EditBoxGlobal.ChatWhisperName"], function(f31_arg0)
		f26_local1:setVerticalCount(math.min(f26_local1.itemCount, CoD.ChatClientUtility.MaxWhisperPickerNames))
		f26_local0(f26_local1, f26_arg0, f26_arg1)
		local f31_local0 = f26_local1:getFirstChild()
		f31_local0 = f31_local0:getFirstChild()
		while f31_local0 do
			f31_local0.keepOldInputFocusOnClick = false
			f31_local0 = f31_local0:getNextSibling()
		end
		f26_local2()
		return true
	end)
	f26_local3 = f26_arg0.ContextualMenu
	f26_local4 = f26_local3
	f26_local3 = f26_local3.subscribeToModel
	f26_local5 = Engine.GetModelForController(f26_arg1)
	f26_local3(f26_local4, f26_local5["EditBoxGlobal.CurrentChatTextRealTime"], function(f32_arg0)
		if f26_arg0.ContextualMenu.initDone then
			if string.match(f32_arg0:get(), "(%a+) ") ~= "w" then
				CoD.PCWidgetUtility.CloseContextualMenu(f26_arg0, f26_arg1)
			else
				local f32_local0, f32_local1 = string.match(f32_arg0:get(), "(%a+) (.+)")
				if not f32_local1 then
					f32_local1 = ""
				end
				local f32_local2 = Engine.GetModelForController(f26_arg1)
				f32_local2["EditBoxGlobal.ChatWhisperName"].set(f32_local2["EditBoxGlobal.ChatWhisperName"], f32_local1)
			end
		end
		return true
	end)
	LUI.OverrideFunction_CallOriginalSecond(f26_arg0.ContextualMenu, "close", function(element, f33_arg1)
		if f26_arg0.lastPCInputFocusElemEvent then
			f26_arg0.letMouse1Through = nil
		end
		f26_arg0.ChatAutoComplete = nil
	end)
	CoD.PCUtility.SetFilterUsingControllerModel(f26_arg0.ContextualMenu, f26_arg1, "ActionList", "name", "EditBoxGlobal.ChatWhisperName", "", "1")
	f26_arg0.ContextualMenu.initDone = true
	return true
end
CoD.ChatClientUtility.StartWhisperPicker = function(f34_arg0, f34_arg1, f34_arg2)
	if f34_arg1 == nil and CoD.ChatClientUtility.ChatWidget then
		f0_local2(CoD.ChatClientUtility.ChatWidget:getMenu(), f34_arg0)
		return false, false, false
	elseif f34_arg1 then
		local f34_local0 = f34_arg1
		local f34_local1 = nil
		local f34_local2, f34_local3 = string.find(f34_arg1, " ")
		if f34_local2 then
			f34_local0 = string.sub(f34_arg1, 1, f34_local2 - 1)
			f34_local1 = string.sub(f34_arg1, f34_local3)
		end
		local f34_local4 = f0_local0(f34_arg0, f34_local0)
		if f34_local4 then
			local f34_local5 = CoD.ChatClientUtility.GetAndJoinWhisperChannelIdByXuid(f34_arg0, f34_local4)
			if f34_local5 then
				CoD.ChatClientUtility.SetChannelTo(f34_arg0, f34_local5)
				return f34_local1, true, false
			else
				return false, true, false, "Error whispering the user"
			end
		end
	end
	return false, not f34_arg2, false, @"hash_5B950673374050CC"
end
CoD.ChatClientUtility.TryFunction = function(f35_arg0)
	local f35_local0, f35_local1, f35_local2 = CoD.ChatClientUtility.GetCommand(f35_arg0.controller, f35_arg0.currentText)
	local f35_local3, f35_local4 = false
	if f35_local0 then
		f35_local4, f35_local3, f35_local4, f35_local4 = f35_local0.fct(f35_arg0.controller, f35_local1, true)
	end
	return f35_local3
end
CoD.ChatClientUtility.IsInBountyHunterMenu = false
CoD.ChatClientUtility.SetIsInBountyHunterMenu = function(f36_arg0)
	CoD.ChatClientUtility.IsInBountyHunterMenu = f36_arg0
end
CoD.ChatClientUtility.ChatCommands = {
	{
		strings = {
			"a",
			"all",
			"s",
			"say",
			"g",
			"general",
			"global",
			"m",
			"match",
		},
		fct = CoD.ChatClientUtility.SetChannelToAll,
	},
	{
		strings = {
			"t",
			"team",
		},
		fct = CoD.ChatClientUtility.SetChannelToTeam,
	},
	{
		strings = {
			"p",
			"party",
		},
		fct = CoD.ChatClientUtility.SetChannelToParty,
	},
	{
		strings = {
			"r",
			"reply",
		},
		fct = CoD.ChatClientUtility.SetChannelToReply,
	},
	{
		strings = {
			"w",
			"whisper",
		},
		fct = CoD.ChatClientUtility.StartWhisperPicker,
	},
}
CoD.ChatClientUtility.ColorToString = function(f37_arg0)
	return string.format("%i %i %i", f37_arg0.r * 255, f37_arg0.g * 255, f37_arg0.b * 255)
end
CoD.ChatClientUtility.ChatTypeToColor = function(f38_arg0)
	return CoD.ChatClientUtility.ColorToString(CoD.ChatClientUtility.GetColorForChannelType(f38_arg0))
end
CoD.ChatClientUtility.GetColorForChannelType = function(f39_arg0)
	if f39_arg0 == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_127F47164723263E"] then
		return ColorSet.T8_PC_CHAT_PARTY
	elseif f39_arg0 == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_18AE60B993F07980"] then
		return ColorSet.T8_PC_CHAT_MATCH
	elseif f39_arg0 == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_6EB1743CA5B28F23"] then
		return ColorSet.T8_PC_CHAT_TEAM
	elseif f39_arg0 == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_75E57997D82BCBD1"] then
		return ColorSet.T8_PC_CHAT_WHISPER
	else
		return ColorSet.T8_PC_CHAT_GAME_EVENT
	end
end
CoD.ChatClientUtility.GetColorForGameEventType = function(f40_arg0)
	if f40_arg0 == Enum[@"cacheduicolors"][@"cached_ui_color_enemy"] then
		return ColorSet.T8_PC_CHAT_EVENT_ENEMY
	elseif f40_arg0 == Enum[@"cacheduicolors"][@"cached_ui_color_friendly"] then
		return ColorSet.T8_PC_CHAT_EVENT_ALLY
	elseif f40_arg0 ~= Enum[@"cacheduicolors"][@"cached_ui_color_invalid"] then
		return ColorSet.T8_PC_CHAT_EVENT_SELF
	else
		return ColorSet.White
	end
end
CoD.ChatClientUtility.TrySendLine = function(f41_arg0, f41_arg1)
	local f41_local0 = f41_arg1
	local f41_local1 = true
	local f41_local2 = true
	local f41_local3 = true
	local f41_local4 = nil
	local f41_local5, f41_local6, f41_local7 = CoD.ChatClientUtility.GetCommand(f41_arg0, f41_arg1)
	if f41_local7 then
		f41_local1 = true
		f41_local2, f41_local0 = false
		f41_local4 = @"hash_256696C428AB2A8B"
	elseif f41_local5 then
		f41_local0, f41_local1, f41_local3, f41_local4 = f41_local5.fct(f41_arg0, f41_local6)
	end
	if f41_local0 then
		f41_local2 = f41_local0 == ""
		if not f41_local2 then
			local f41_local8 = CoD.ChatClientUtility.GetInputChannelModel(f41_arg0)
			if table.getn(Engine[@"hash_2E40639D3AA297FB"]()) > 0 then
				local f41_local9 = f41_local8:get()
				if Engine[@"hash_5884871F4FF3ACA"](f41_local9) ~= Enum[@"hash_7F6296F5D7A38AD2"][@"hash_268378D638FECA19"] then
					Engine[@"hash_19B57C0F0680848E"](f41_local9, f41_local0)
					if Engine[@"hash_3CA0ADE9B4DA235D"](f41_local9) then
						Engine[@"hash_6D1DD5DBCA5778EA"](f41_local9)
					end
				end
				f41_local1 = true
			end
		end
	end
	if f41_local4 then
		CoD.PCUtility.ShowGameEvent(Engine[@"hash_4F9F1239CFD921FE"](f41_local4))
	end
	local f41_local8
	if not CoD.isFrontend then
		f41_local8 = not CoD.PCWidgetUtility.CanShowMenuStyleChat(f41_arg0)
	else
		f41_local8 = false
	end
	return f41_local8 or f41_local3 and f41_local2, f41_local1, f41_local2 and f41_local3
end
CoD.ChatClientUtility.GetCommand = function(f42_arg0, f42_arg1)
	local f42_local0, f42_local1, f42_local2 = nil
	local f42_local3 = {}
	if string.sub(f42_arg1, 1, 1) == "/" then
		local f42_local4, f42_local5 = string.match(f42_arg1, "(%a+) (.+)")
		if f42_local4 == nil then
			f42_local4 = string.match(f42_arg1, "(%a+)")
		end
		for f42_local12, f42_local13 in ipairs(CoD.ChatClientUtility.ChatCommands) do
			for f42_local9, f42_local10 in ipairs(f42_local13.strings) do
				if f42_local10 == f42_local4 then
					f42_local2 = f42_local13
					f42_local1 = f42_local5
					break
				end
			end
			if f42_local2 ~= nil then
			end
		end
		if f42_local2 then
			return f42_local2, f42_local1, false
		else
			return nil, nil, true
		end
	else
		return nil, nil, false
	end
end
CoD.ChatClientUtility.GetAndJoinWhisperChannelIdByXuid = function(f43_arg0, f43_arg1)
	if Engine.GetXUID64(f43_arg0) == f43_arg1 then
		return nil
	end
	local f43_local0 = Engine[@"hash_327ED8F37B54D639"](Enum[@"hash_7F6296F5D7A38AD2"][@"hash_75E57997D82BCBD1"], f43_arg1)
	if not f43_local0 then
		local f43_local1 = Engine.GetPlayerInfo(f43_arg0, f43_arg1)
		local f43_local2 = nil
		if f43_local1 and f43_local1.info and f43_local1.info.gamertag then
			f43_local2 = CoD.PCBattlenetUtility.StripBattleTagNumber(f43_local1.info.gamertag)
			if f43_local2 == "" then
				f43_local2 = nil
			end
		end
		f43_local0 = Engine[@"hash_28BD5FE4F0D70F23"](f43_arg1, f43_local2)
	end
	if f43_local0 then
		return Engine[@"hash_5F4AC963487AA68C"](Enum[@"hash_7F6296F5D7A38AD2"][@"hash_75E57997D82BCBD1"], f43_arg1)
	end
	return nil
end
