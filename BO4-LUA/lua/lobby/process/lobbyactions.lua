require("x64:53e8db3768fb02a")
require("x64:c6e3b538b3d95e3")
Lobby.Interrupt = {}
Lobby.Interrupt.NONE = nil
Lobby.Interrupt.BACK = 1
Lobby.Interrupt.FAILED_ACTION = 2
Lobby.Interrupt.ERROR_MSG = 3
Lobby.Interrupt.ERROR_OVERLAY = 4
Lobby.Interrupt.Back = function(f1_arg0, f1_arg1)
	return {
		isInterrupt = true,
		name = "InterruptBack",
		interruptFuncPtr = f1_arg0,
		params = f1_arg1,
		createFuncPtr = function(f2_arg0, f2_arg1)
			return f2_arg0.interruptFuncPtr(Lobby.Interrupt.BACK, f2_arg0.params, {
				action = nil,
				errorMsg = nil,
			})
		end,
	}
end
Lobby.Interrupt.FailedAction = function(f3_arg0, f3_arg1)
	return {
		isInterrupt = true,
		name = "InterruptFailedAction",
		interruptFuncPtr = f3_arg0,
		params = f3_arg1,
		createFuncPtr = function(f4_arg0, f4_arg1)
			return f4_arg0.interruptFuncPtr(Lobby.Interrupt.FAILED_ACTION, f4_arg0.params, {
				action = f4_arg1,
				errorMsg = nil,
			})
		end,
	}
end
Lobby.Interrupt.ErrorMsg = function(f5_arg0, f5_arg1, f5_arg2)
	return {
		isInterrupt = true,
		name = "InterruptErrorMsg",
		interruptFuncPtr = f5_arg0,
		params = f5_arg1,
		errorMsg = f5_arg2,
		createFuncPtr = function(f6_arg0, f6_arg1)
			return f6_arg0.interruptFuncPtr(Lobby.Interrupt.ERROR_MSG, f6_arg0.params, {
				action = f6_arg1,
				errorMsg = f6_arg0.errorMsg,
			})
		end,
	}
end
Lobby.Actions = {}
Lobby.Actions.EmptyAction = function()
	return {
		name = "EmptyAction",
		startFuncPtr = function(f8_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f8_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ExecuteScript = function(f9_arg0, f9_arg1)
	return {
		name = "ExecuteScript",
		inlineFunction = f9_arg0,
		functionParam = f9_arg1,
		startFuncPtr = function(f10_arg0)
			f10_arg0.inlineFunction(f10_arg0.functionParam)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f10_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ExecuteScriptWithReturn = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	return {
		name = "ExecuteScript",
		inlineFunction = f11_arg0,
		startFuncPtr = function(f12_arg0)
			local f12_local0 = f12_arg0.inlineFunction()
			if f12_local0 == f11_arg1 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f12_arg0.actionId,
				})
				return
			elseif f12_local0 == f11_arg2 then
				LobbyVM.ProcessCompleteFailure({
					actionId = f12_arg0.actionId,
				})
				return
			elseif f12_local0 == f11_arg3 then
				LobbyVM.ProcessCompleteError({
					actionId = f12_arg0.actionId,
				})
				return
			else
				LobbyVM.ProcessCompleteError({
					actionId = f12_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.LuiEvent = function(f13_arg0, f13_arg1)
	return {
		name = "LuiEvent: " .. f13_arg0,
		event = f13_arg0,
		data = f13_arg1,
		startFuncPtr = function(f14_arg0)
			f14_arg0.data.actionId = f14_arg0.actionId
			Engine[0xE1789115A2356E7](f14_arg0.event, f14_arg0.data)
		end,
	}
end
Lobby.Actions.LobbyVMCall = function(f15_arg0, f15_arg1)
	return {
		name = "LobbyVMCall",
		lobbyVMFunc = f15_arg0,
		data = f15_arg1,
		startFuncPtr = function(f16_arg0)
			f16_arg0.lobbyVMFunc(f16_arg0.data)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f16_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.LobbyVMCallRetVal = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
	return {
		name = "LobbyVMCallRetVal",
		lobbyVMFunc = f17_arg0,
		data = f17_arg1,
		successVal = f17_arg2,
		failureVal = f17_arg3,
		errorVal = f17_arg4,
		startFuncPtr = function(f18_arg0)
			local f18_local0 = f18_arg0.lobbyVMFunc(f18_arg0.data)
			if f18_local0 == f18_arg0.successVal then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f18_arg0.actionId,
				})
				return
			elseif f18_local0 == f18_arg0.failureVal then
				LobbyVM.ProcessCompleteFailure({
					actionId = f18_arg0.actionId,
				})
				return
			elseif f18_local0 == f18_arg0.errorVal then
				LobbyVM.ProcessCompleteError({
					actionId = f18_arg0.actionId,
				})
				return
			else
				LobbyVM.ProcessCompleteError({
					actionId = f18_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.TimeDelay = function(f19_arg0)
	return {
		name = "TimeDelay(" .. f19_arg0 .. "ms)",
		timeDelayMilliseconds = f19_arg0,
		endTime = nil,
		startFuncPtr = function(f20_arg0)
			if f20_arg0.timeDelayMilliseconds == 0 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f20_arg0.actionId,
				})
				return
			else
				f20_arg0.endTime = f20_arg0.timeDelayMilliseconds + Engine[0x9D33D652B9B0F3B]()
			end
		end,
		pumpFuncPtr = function(f21_arg0, f21_arg1)
			if f21_arg0.endTime < Engine[0x9D33D652B9B0F3B]() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f21_arg0.actionId,
				})
				return
			else
			end
		end,
		cancelFuncPtr = function(f22_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f22_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.OpenSpinner = function(f23_arg0, f23_arg1)
	return {
		name = "OpenSpinner",
		showCancelButton = f23_arg0,
		closeAllPopups = f23_arg1,
		startFuncPtr = function(f24_arg0)
			if f24_arg0.showCancelButton == nil then
				f24_arg0.showCancelButton = false
			end
			if f24_arg0.closeAllPopups then
				Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"))
			end
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
		end,
		pumpFuncPtr = function(f25_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f25_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.CloseSpinner = function()
	return {
		name = "CloseSpinner",
		startFuncPtr = function(f27_arg0)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), false)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f27_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.CloseSpinnerAllowJoining = function()
	return {
		name = "CloseSpinnerAllowJoining",
		startFuncPtr = function(f29_arg0)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), false)
			Engine[0xF56FEF6357B5097](Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x5A046D0646801][0x4787E42BE26EFCD])
			LobbyVM.ProcessCompleteSuccess({
				actionId = f29_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.IsConditionTrue = function(f30_arg0)
	return {
		name = "IsConditionTrue(value: " .. tostring(f30_arg0) .. ")",
		condition = f30_arg0,
		startFuncPtr = function(f31_arg0)
			if f31_arg0.condition then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f31_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f31_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.EvaluateFunction = function(f32_arg0)
	return {
		name = "EvaluateFunction()",
		func = f32_arg0,
		startFuncPtr = function(f33_arg0)
			if f33_arg0.func() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f33_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f33_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.WaitTillOutOfGame = function()
	return {
		name = "WaitTillOutOfGame",
		startFuncPtr = function(f35_arg0)
			if Engine[0x7B48C1ABFF0F764]() == false then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f35_arg0.actionId,
				})
			end
		end,
		pumpFuncPtr = function(f36_arg0, f36_arg1)
			if Engine[0x7B48C1ABFF0F764]() == false then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f36_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.CanAcceptPlatformInvite = function(f37_arg0)
	return {
		name = "CanAcceptPlatformInvite(controller: " .. tostring(f37_arg0) .. ")",
		controller = f37_arg0,
		startFuncPtr = function(f38_arg0)
			local f38_local0 = true
			if LuaUtils.IsSkuOfflineOnly() then
				f38_local0 = false
			end
			if f38_local0 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f38_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f38_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.SendPlatformInvite = function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
	return {
		name = "SendPlatformInvite(controller: " .. tostring(f39_arg0) .. ")",
		controller = f39_arg0,
		lobbyType = f39_arg1,
		xuids = f39_arg2,
		sessionId = f39_arg3,
		startFuncPtr = function(f40_arg0)
			if Engine[0xF62802472E955C9](f40_arg0.actionId, f40_arg0.controller, f40_arg0.lobbyType, f39_arg2, Lobby.Platform.PS4GetSessionId(f39_arg0)) == false then
				LobbyVM.ProcessCompleteFailure({
					actionId = f40_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.CanPlayOnline = function(f41_arg0)
	return {
		name = "CanPlayOnline(controller: " .. tostring(f41_arg0) .. ")",
		controller = f41_arg0,
		checkPlusEndTime = 0,
		startFuncPtr = function(f42_arg0)
			local f42_local0 = f42_arg0.controller
			local f42_local1 = true
			if LuaDefine.isPS4 then
				if not Engine[0xB9F55DAB26B92A0](f42_local0) then
					Engine[0x4D6E7FCDEEE1CEB](f42_local0, "-2141913082")
					f42_local1 = false
				elseif Engine[0xC58A63F57534B83](f42_local0) then
					f42_local1 = false
				elseif LuaUtils.RequirePaidSubscriptionForOnlinePlay() then
					local f42_local2, f42_local3 = Engine[0x1F3727F7007C506](f42_local0)
					if f42_local2 == true then
						if f42_local3 == false then
							f42_local1 = LuaUtils.PlayStationPlusUpsell(f42_local0)
						else
							f42_local1 = true
						end
					else
						f42_arg0.checkPlusEndTime = Engine[0x9D33D652B9B0F3B]() + LuaDefine.PS_PLUS_CHECK_TIME
						return
					end
				else
					f42_local1 = true
				end
				Engine[0xD4D05ACED1A0F3](f42_local0)
			elseif LuaDefine.isXbox then
				if Dvar[0x1DC1D441B7221C3]:get() then
					f42_local1 = true
				elseif not Engine[0xEFC616F1C8F84F6](f42_local0) then
					Engine[0x12AA42031FA6D11](f42_local0, 254, true)
					f42_local1 = false
				elseif LuaUtils.RequirePaidSubscriptionForOnlinePlay() then
					Engine[0x12AA42031FA6D11](f42_local0, 214, true)
					f42_local1 = Engine[0xA6B4E61CE019B5C](f42_local0)
				else
					f42_local1 = true
				end
			end
			if f42_local1 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f42_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f42_arg0.actionId,
				})
			end
		end,
		pumpFuncPtr = function(f43_arg0)
			local f43_local0 = false
			if LuaDefine.isPS4 then
				if LuaUtils.RequirePaidSubscriptionForOnlinePlay() then
					local f43_local1, f43_local2 = Engine[0x1F3727F7007C506](f41_arg0)
					if f43_local1 == false and f43_arg0.checkPlusEndTime > Engine[0x9D33D652B9B0F3B]() then
						return
					elseif f43_local2 == true then
						f43_local0 = true
					else
						f43_local0 = LuaUtils.PlayStationPlusUpsell(f41_arg0)
					end
				else
					f43_local0 = true
				end
			end
			if f43_local0 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f43_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f43_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.DisconnectFromDemonware = function(f44_arg0, f44_arg1)
	return {
		name = "DisconnectFromDemonware",
		controller = f44_arg0,
		connectMode = f44_arg1,
		startFuncPtr = function(f45_arg0)
			if f45_arg0.connectMode ~= nil then
				Dvar[0xC851E2925BC63E4]:set(f44_arg1)
			end
			if Engine[0xD7913D0F914DE47](f45_arg0.controller) then
				Engine[0x1F31752A6251831](f45_arg0.controller)
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f45_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.DisableConnectingToDemonware = function(f46_arg0)
	return {
		name = "DisableConnectingToDemonware",
		controller = f46_arg0,
		startFuncPtr = function(f47_arg0)
			if Engine[0xD7913D0F914DE47](f47_arg0.controller) and not Engine[0x3CD0351DA0D371](f46_arg0) then
				Engine[0x1F31752A6251831](f47_arg0.controller)
			end
			Engine[0x70C96EC38A34E49]()
			LobbyVM.ProcessCompleteSuccess({
				actionId = f47_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.EnableConnectingToDemonware = function(f48_arg0)
	return {
		name = "EnableConnectingToDemonware",
		controller = f48_arg0,
		startFuncPtr = function(f49_arg0)
			Engine[0x4B71A3DA353ACF0]()
			LobbyVM.ProcessCompleteSuccess({
				actionId = f49_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ConnectingToDemonware = function(f50_arg0, f50_arg1, f50_arg2)
	return {
		name = "ConnectingToDemonware(check for " .. f50_arg1 .. "ms)",
		controller = f50_arg0,
		waitMilliseconds = f50_arg1,
		invite = f50_arg2,
		endTime = nil,
		checkInterval = 100,
		checkTime = nil,
		startFuncPtr = function(f51_arg0)
			if f51_arg0.waitMilliseconds == 0 and Engine[0x3CD0351DA0D371](f51_arg0.controller) then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f51_arg0.actionId,
				})
				return
			elseif f50_arg2 == true or Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
				Engine[0xEF56B086D9D2C36](Enum[0xC84D3E505F1444][0xE99F41098B71960])
			end
			Dvar[0xC851E2925BC63E4]:set(1)
			Engine[0x4B71A3DA353ACF0]()
			f51_arg0.endTime = f51_arg0.waitMilliseconds + Engine[0x9D33D652B9B0F3B]()
			f51_arg0.checkTime = f51_arg0.checkInterval + Engine[0x9D33D652B9B0F3B]()
		end,
		pumpFuncPtr = function(f52_arg0, f52_arg1)
			if f52_arg0.checkTime > Engine[0x9D33D652B9B0F3B]() then
				return
			else
				f52_arg0.checkTime = f52_arg0.checkInterval + Engine[0x9D33D652B9B0F3B]()
				if Engine[0x3CD0351DA0D371](f52_arg0.controller) == true then
					if true == LuaDefine.isPS4 then
						if Engine[0xC58A63F57534B83](f50_arg0) then
							LobbyVM.ProcessCompleteFailure({
								actionId = f52_arg0.actionId,
							})
							return
						elseif not LuaUtils.PlayStationPlusUpsell(f52_arg0.controller) then
							LobbyVM.ProcessCompleteFailure({
								actionId = f52_arg0.actionId,
							})
							return
						end
					end
					LobbyVM.ProcessCompleteSuccess({
						actionId = f52_arg0.actionId,
					})
					return
				elseif f52_arg0.endTime < Engine[0x9D33D652B9B0F3B]() then
					local f52_local0, f52_local1 = Engine[0x50D07ABC7D13586](f50_arg0, Enum[0x13520493EA3E4E6][0x97F7B44378BF205])
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "Failed to connect to Demonware: " .. f52_local0 .. "\nDEBUG INFO:\n" .. f52_local1 .. ".\n")
					LobbyVM.ProcessCompleteFailure({
						actionId = f52_arg0.actionId,
					})
					return
				else
				end
			end
		end,
		cancelFuncPtr = function(f53_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f53_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.IsButtonPressed = function(f54_arg0, f54_arg1)
	return {
		name = "IsButtonPressed",
		controller = f54_arg0,
		button = f54_arg1,
		startFuncPtr = function(f55_arg0)
			if not Engine[0x2DA54CF5D6B7F02]() then
				LobbyVM.ProcessCompleteFailure({
					actionId = f55_arg0.actionId,
				})
				return
			elseif Engine[0x15B20FC3974D161](f55_arg0.controller, f55_arg0.button) then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f55_arg0.actionId,
				})
				return
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f55_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.IsDvarSet = function(f56_arg0, f56_arg1)
	return {
		name = "IsDvarSet(dvar: " .. f56_arg0 .. ", check for value: " .. tostring(f56_arg1) .. ")",
		dvarName = f56_arg0,
		dvarValue = f56_arg1,
		startFuncPtr = function(f57_arg0)
			local f57_local0 = f57_arg0.dvarName
			local f57_local1 = f57_arg0.dvarValue
			local f57_local2 = Engine[0xBA3D5F4206FB752](f57_local0)
			local f57_local3 = false
			if f57_local2 == Enum[0xD7F642528F471CB][0x99B565B2B631475] then
				LobbyVM.ProcessCompleteFailure({
					actionId = f57_arg0.actionId,
				})
			elseif f57_local2 == Enum[0xD7F642528F471CB][0xFBBB888D593ECDA] then
				f57_local3 = f57_local1 == Engine[0x9E5BE3B4BBA4E0E](f57_local0)
			elseif f57_local2 == Enum[0xD7F642528F471CB][0x78BCA5D1F0452BC] then
				f57_local3 = f57_local1 == Engine[0xEDCFC612B39E0C0](f57_local0)
			elseif f57_local2 == Enum[0xD7F642528F471CB][0xFAE21328AED1937] then
				f57_local3 = f57_local1 == Engine[0x22EAAB59AA27E9B](f57_local0)
			elseif f57_local2 == Enum[0xD7F642528F471CB][0xC2F7E0A95FCCDA7] then
				f57_local3 = f57_local1 == Engine[0x54084D7CA2317BB](f57_local0)
			end
			if f57_local3 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f57_arg0.actionId,
				})
				return
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f57_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.ErrorOverlay = function(f58_arg0, f58_arg1)
	return {
		name = "ErrorOverlay:" .. f58_arg1,
		controller = f58_arg0,
		overlay = f58_arg1,
		startFuncPtr = function(f59_arg0)
			LobbyVM.ExecuteLobbyVMCreateOverlay(f58_arg0, f58_arg1)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f59_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ErrorPopupMsg = function(f60_arg0, f60_arg1)
	return {
		name = "ErrorPopupMsg",
		message = f60_arg0,
		title = f60_arg1,
		startFuncPtr = function(f61_arg0)
			LuaUtils.UI_ShowErrorMessageDialog(nil, f61_arg0.message, f61_arg0.title)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f61_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.WarningPopupMsg = function(f62_arg0, f62_arg1)
	return {
		name = "WarningPopupMsg",
		message = f62_arg0,
		title = f62_arg1,
		startFuncPtr = function(f63_arg0)
			LuaUtils.UI_ShowWarningMessageDialog(nil, f63_arg0.message, f63_arg0.title)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f63_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ErrorPopup = function(f64_arg0)
	if f64_arg0.errorFuncPtr == nil then
		error("Lobby.Actions.ErrorPopup: An action: " .. f64_arg0.name .. " with no errorFuncPtr has been used.")
	end
	return {
		name = "ErrorPopup: " .. f64_arg0.name,
		actionRef = f64_arg0,
		startFuncPtr = function(f65_arg0)
			local f65_local0 = "UNHANDLED ERROR OCCURRED (" .. f64_arg0.name .. " action)"
			local f65_local1 = false
			if f64_arg0.errorFuncPtr ~= nil then
				f65_local0, f65_local1 = f65_arg0.actionRef:errorFuncPtr()
			end
			if f65_local1 then
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.trialOverlayDescription"), f65_local0)
				LobbyVM.ExecuteLobbyVMCreateOverlay(f64_arg0.controller, "TrialVersionUpsell")
			else
				LuaUtils.UI_ShowErrorMessageDialog(nil, f65_local0)
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f65_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ConnectToDW = function(f66_arg0)
	return {
		name = "ConnectToDW",
		controller = f66_arg0,
		startFuncPtr = function(f67_arg0) end,
	}
end
Lobby.Actions.SetDefaultArenaPlaylist = function(f68_arg0)
	return {
		name = "SetDefaultPlaylist",
		controller = f68_arg0,
		startFuncPtr = function(f69_arg0)
			local f69_local0 = Engine[0xB72F603CAC75B3A](f68_arg0, "playlist_arena")
			local f69_local1 = nil
			if f69_local0 <= 0 then
				if Dvar[0xD60181470E5E8E8]:exists() then
					f69_local1 = Dvar[0xD60181470E5E8E8]:get()
				else
					f69_local1 = 451
				end
			else
				f69_local1 = f69_local0
			end
			local f69_local2 = nil
			local f69_local3 = LuaUtils.GetArenaPlaylistInfo()
			for f69_local7, f69_local8 in ipairs(f69_local3) do
				if f69_local8.id == f69_local1 then
					f69_local2 = f69_local8
					break
				end
			end
			if not f69_local2 then
				f69_local2 = f69_local3[1]
			end
			if f69_local2 then
				Engine[0xCE25A90DC553200](f69_local2.id)
				LuaUtils.SetQuickplayPlaylistID(f69_local2.id)
				Engine[0x280E4C1191CC53D](f68_arg0, "playlist_arena", tostring(f69_local2.id))
				f69_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyPlaylist")
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f69_local4, "name"), Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f69_local2.name)))
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f69_local4, "kickerText"), 0x0)
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f69_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ArenaErrorShutdown = function(f70_arg0)
	return {
		name = "ArenaErrorShutdown",
		controller = f70_arg0,
		startFuncPtr = function(f71_arg0)
			Lobby.Pregame.Shutdown(f70_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f71_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.RunPlaylistSettings = function(f72_arg0)
	return {
		name = "RunPlaylistSettings",
		require = "LobbySettings",
		controller = f72_arg0,
		startFuncPtr = function(f73_arg0)
			Engine[0xCB6D7D39AF67BC1](f73_arg0.controller, Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
			LobbyVM.ProcessCompleteSuccess({
				actionId = f73_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.RunPlaylistRules = function(f74_arg0)
	return {
		name = "RunPlaylistRules",
		require = "LobbySettings",
		controller = f74_arg0,
		startFuncPtr = function(f75_arg0)
			Engine[0x95FA783443EBEC3](f75_arg0.controller)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f75_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.SwitchMode = function(f76_arg0, f76_arg1)
	return {
		name = "SwitchMode",
		controller = f76_arg0,
		toMode = f76_arg1,
		timeoutTime = Engine[0x9D33D652B9B0F3B]() + 45000,
		startFuncPtr = function(f77_arg0)
			if Engine[0xCB675CA7856DA25]() and (f76_arg1 == "mp" or f76_arg1 == "zm") then
				LobbyVM.ProcessCompleteFailure({
					actionId = f77_arg0.actionId,
				})
			end
			if (Engine[0xA8FBC7AC4C3F3A6]() or Engine[0x5405A6484A88367]()) and f76_arg1 == "zm" then
				LobbyVM.ProcessCompleteFailure({
					actionId = f77_arg0.actionId,
				})
			end
			if Dvar[0xA3900525DBB36AF]:exists() then
				assert(tonumber(Dvar[0xA3900525DBB36AF]:get()) > 15000)
				timeoutTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0xA3900525DBB36AF]:get()
			end
			if Engine[0x4967D1FBE8D3CB5](Engine[0x3EAC408F958FF05]()) ~= f76_arg1 then
				Engine[0x39A49F8F53E0E89]()
			end
		end,
		pumpFuncPtr = function(f78_arg0)
			if Engine[0xC9582371E0757C8]() or f78_arg0.timeoutTime < Engine[0x9D33D652B9B0F3B]() then
				Engine[0xA47E6B48AB89F8E](f78_arg0.controller, f78_arg0.toMode)
				LobbyVM.ProcessCompleteSuccess({
					actionId = f78_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.OpenSurvey = function(f79_arg0, f79_arg1)
	return {
		name = "OpenSurvey",
		controller = f79_arg0,
		fromTarget = f79_arg1,
		startFuncPtr = function(f80_arg0)
			if f79_arg1[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] then
				LobbyVM.ExecuteLobbyVMOpenSurvey(f80_arg0.controller)
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f80_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ForceLobbyUIScreen = function(f81_arg0, f81_arg1)
	return {
		name = "ForceLobbyUIScreen",
		controller = f81_arg0,
		screenId = f81_arg1,
		startFuncPtr = function(f82_arg0)
			Engine[0xBFFECE7B49BC12](f82_arg0.screenId)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f82_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.LobbyHostStart = function(f83_arg0, f83_arg1, f83_arg2, f83_arg3, f83_arg4, f83_arg5, f83_arg6, f83_arg7)
	return {
		name = "LobbyHostStart(" .. Engine[0xD7C141D0C4A4FBE](f83_arg2) .. ")",
		controller = f83_arg0,
		mainMode = f83_arg1,
		lobbyType = f83_arg2,
		lobbyMode = f83_arg3,
		maxClients = f83_arg4,
		mapname = f83_arg5,
		gametype = f83_arg6,
		secIdKey = f83_arg7,
		startFuncPtr = function(f84_arg0)
			if f84_arg0.secIdKey ~= nil then
				f84_arg0.secId = f84_arg0.secIdKey.secId
				f84_arg0.secKey = f84_arg0.secIdKey.secKey
			end
			if f84_arg0.secId == nil or f84_arg0.secKey == nil then
				local f84_local0 = Engine[0x16FF58A0A7C0C65]()
				f84_arg0.secId = f84_local0.secId
				f84_arg0.secKey = f84_local0.secKey
			end
			Engine[0xB0715A3AC4691F4](f84_arg0.actionId, f84_arg0.controller, f84_arg0.mainMode, f84_arg0.lobbyType, f84_arg0.lobbyMode, f84_arg0.maxClients, f84_arg0.mapname, f84_arg0.gametype, f84_arg0.secId, f84_arg0.secKey)
		end,
		errorFuncPtr = function(f85_arg0)
			return "Failed to host a lobby"
		end,
	}
end
Lobby.Actions.LobbyHostStartMigratedInfo = function(f86_arg0, f86_arg1, f86_arg2, f86_arg3, f86_arg4, f86_arg5, f86_arg6, f86_arg7)
	return {
		name = "LobbyHostStartMigrate(" .. Engine[0xD7C141D0C4A4FBE](f86_arg2) .. ")",
		controller = f86_arg0,
		mainMode = f86_arg1,
		lobbyType = f86_arg2,
		lobbyMode = f86_arg3,
		maxClients = f86_arg4,
		mapname = f86_arg5,
		gametype = f86_arg6,
		hostInfo = f86_arg7,
		startFuncPtr = function(f87_arg0)
			Engine[0x715B893089BB666](f87_arg0.actionId, f87_arg0.controller, f87_arg0.mainMode, f87_arg0.lobbyType, f87_arg0.lobbyMode, f87_arg0.maxClients, f87_arg0.mapname, f87_arg0.gametype, f87_arg0.hostInfo)
		end,
	}
end
Lobby.Actions.LobbyHostEnd = function(f88_arg0)
	return {
		name = "LobbyHostEnd(" .. Engine[0xD7C141D0C4A4FBE](f88_arg0) .. ")",
		lobbyType = f88_arg0,
		startFuncPtr = function(f89_arg0)
			Engine[0x75EF579598B31A2](f89_arg0.actionId, f89_arg0.lobbyType)
		end,
		errorFuncPtr = function(f90_arg0)
			return "Failed to end lobby"
		end,
	}
end
Lobby.Actions.LobbyHostAddPrimary = function(f91_arg0)
	return {
		name = "LobbyHostAddPrimary(" .. Engine[0xD7C141D0C4A4FBE](f91_arg0) .. ")",
		lobbyType = f91_arg0,
		startFuncPtr = function(f92_arg0)
			Engine[0xFF2C18AAF0917FA](f92_arg0.actionId, f92_arg0.lobbyType)
		end,
	}
end
Lobby.Actions.LobbyHostAddLocal = function(f93_arg0, f93_arg1)
	return {
		name = "LobbyHostAddLocal(" .. Engine[0xD7C141D0C4A4FBE](f93_arg1) .. ")",
		controller = f93_arg0,
		lobbyType = f93_arg1,
		startFuncPtr = function(f94_arg0)
			Engine[0xBBF8E204B678A67](f94_arg0.actionId, f94_arg0.controller, f94_arg0.lobbyType)
		end,
	}
end
Lobby.Actions.LobbyClientStart = function(f95_arg0)
	return {
		name = "LobbyClientStart(" .. Engine[0xD7C141D0C4A4FBE](f95_arg0) .. ")",
		lobbyType = f95_arg0,
		startFuncPtr = function(f96_arg0)
			Engine[0x91D6FA18AE301C8](f96_arg0.actionId, f96_arg0.lobbyType)
		end,
	}
end
Lobby.Actions.LobbyClientEnd = function(f97_arg0)
	return {
		name = "LobbyClientEnd(" .. Engine[0xD7C141D0C4A4FBE](f97_arg0) .. ")",
		lobbyType = f97_arg0,
		startFuncPtr = function(f98_arg0)
			Engine[0xC37C48636DE06D9](f98_arg0.actionId, f98_arg0.lobbyType)
			if f98_arg0.lobbyType == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
				Lobby.MatchmakingAsync.EmptyEventQueue()
			end
			Lobby.MatchmakingAsync.LobbyClientEnd(f98_arg0.lobbyType)
		end,
	}
end
Lobby.Actions.LobbyLocalClientLeave = function(f99_arg0, f99_arg1, f99_arg2)
	return {
		name = "LobbyLocalClientLeave(" .. Engine[0xD7C141D0C4A4FBE](f99_arg0) .. ")",
		lobbyType = f99_arg0,
		controller = f99_arg1,
		xuid = f99_arg2,
		startFuncPtr = function(f100_arg0)
			Engine[0xC7D0C6422240224](f100_arg0.actionId, f100_arg0.lobbyType, f100_arg0.controller, f100_arg0.xuid)
		end,
	}
end
Lobby.Actions.LeaveWithParty = function(f101_arg0)
	return {
		name = "LeaveWithParty(wait for " .. f101_arg0 .. "ms)",
		waitMilliseconds = f101_arg0,
		endTime = nil,
		startFuncPtr = function(f102_arg0)
			if Engine[0x47928339DC88872](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) == false then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f102_arg0.name .. ", we a loner in a private party, time to split, sweet!\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f102_arg0.actionId,
				})
				return
			elseif Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) == false then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f102_arg0.name .. ", we are not the host of our private party.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f102_arg0.actionId,
				})
				return
			end
			local f102_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
			local f102_local1 = Engine[0x44FC97037CE42ED](f102_local0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
			if f102_local1 == 1 or f102_local1 == Engine[0x44FC97037CE42ED](f102_local0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x8A42AF1547AB4DF]) then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f102_arg0.actionId,
				})
				return
			end
			local f102_local2 = Engine[0xE42CF04B7DDD5DE](LobbyMsg.EncodeToLobbyMsgType(LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_CLIENT_LEAVEWITHPARTY), Enum[0x7CA2DE5266A94BF][0xF90DB2D4085A3E0], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			local f102_local3 = true
			local f102_local4 = {}
			local f102_local5, f102_local6 = LobbyMsg.PackageHostLeaveWithPary(f102_local2, Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			f102_local4 = f102_local6
			if not f102_local5 then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f102_arg0.name .. ", we could not package the message.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f102_arg0.actionId,
				})
			end
			f102_local5 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			for f102_local9, f102_local10 in ipairs(f102_local5.sessionClients) do
				if f102_local10.isLocal == 0 and not f102_local2:sendToRelyableToClient(0, Enum[0x7CA2DE5266A94BF][0xDAA8D01F295C885], Enum[0x4540F9BC7F3047A][0x3E2EFA066BA7E1E], f102_local10.xuid) then
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f102_arg0.name .. ", Could not send to client " .. f102_local10.xuid .. ".\n")
				end
			end
			f102_local2:free()
			if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) == false then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f102_arg0.name .. ", we are not the host of the game lobby, it is safe to leave now.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f102_arg0.actionId,
				})
			end
			f102_arg0.endTime = f102_arg0.waitMilliseconds + Engine[0x9D33D652B9B0F3B]()
		end,
		pumpFuncPtr = function(f103_arg0, f103_arg1)
			local f103_local0 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			local f103_local1 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
			local f103_local2 = false
			for f103_local9, f103_local10 in ipairs(f103_local0.sessionClients) do
				for f103_local6, f103_local7 in ipairs(f103_local1.sessionClients) do
					if f103_local10.isHost == false and f103_local10.xuid == f103_local7.xuid then
						f103_local2 = true
					end
				end
			end
			if f103_local2 == false then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f103_arg0.name .. ", all clients have left the game lobby, we can now leave.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f103_arg0.actionId,
				})
				return
			elseif f103_arg0.endTime < Engine[0x9D33D652B9B0F3B]() then
				Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f103_arg0.name .. ", not all clients have left the game lobby, time to move on.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f103_arg0.actionId,
				})
				return
			else
			end
		end,
		cancelFuncPtr = function(f104_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f104_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.WaitForParty = function(f105_arg0, f105_arg1)
	return {
		name = "WaitForParty(wait for " .. f105_arg1 .. "ms)",
		joinResults = f105_arg0,
		waitMilliseconds = f105_arg1,
		endTime = nil,
		startFuncPtr = function(f106_arg0)
			if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xBC48855DCB4BE0E]) == true then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyAction: " .. f106_arg0.name .. ", we are not the host of our transition lobby.\n")
				LobbyVM.ProcessCompleteFailure({
					actionId = f106_arg0.actionId,
				})
				return
			else
				local f106_local0 = f106_arg0.joinResults[1].sourceLobbyType
				local f106_local1 = f106_arg0.joinResults[1].targetLobbyType
				if Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f106_local0, Enum[0x575E471C039DBD6][0x92BC25E18D296F]) - Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f106_local0, Enum[0x575E471C039DBD6][0x8A42AF1547AB4DF]) == 0 then
					LobbyVM.ProcessCompleteSuccess({
						actionId = f106_arg0.actionId,
					})
					return
				else
					f106_arg0.endTime = f106_arg0.waitMilliseconds + Engine[0x9D33D652B9B0F3B]()
				end
			end
		end,
		pumpFuncPtr = function(f107_arg0, f107_arg1)
			local f107_local0 = f107_arg0.joinResults[1].sourceLobbyType
			local f107_local1 = f107_arg0.joinResults[1].targetLobbyType
			local f107_local2 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			local f107_local3 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f107_local1)
			local f107_local4 = false
			for f107_local11, f107_local12 in ipairs(f107_local2.sessionClients) do
				f107_local4 = false
				for f107_local8, f107_local9 in ipairs(f107_local3.sessionClients) do
					if f107_local12.xuid == f107_local9.xuid then
						f107_local4 = true
						break
					end
				end
				if f107_local4 == false then
				end
			end
			if f107_local4 == true then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f107_arg0.actionId,
				})
				return
			elseif f107_arg0.endTime < Engine[0x9D33D652B9B0F3B]() then
				LobbyVM.ProcessCompleteFailure({
					actionId = f107_arg0.actionId,
				})
				return
			else
			end
		end,
		cancelFuncPtr = function(f108_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f108_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.MoveLobbySession = function(f109_arg0, f109_arg1)
	return {
		name = "MoveLobbySession",
		controller = f109_arg0,
		joinResults = f109_arg1,
		startFuncPtr = function(f110_arg0)
			local f110_local0 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
			local f110_local1 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x8A42AF1547AB4DF])
			local f110_local2 = Engine[0xA33D06620AC0D6B](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			local f110_local3 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			local f110_local4 = {}
			if f110_local0 - f110_local1 ~= 0 then
				local f110_local5 = 1
				for f110_local9, f110_local10 in ipairs(f110_local3.sessionClients) do
					if f110_local2.xuid ~= f110_local10.xuid then
						f110_local4[f110_local5] = f110_local10.xuid
						f110_local5 = f110_local5 + 1
					end
				end
				if #f110_local4 > 0 then
					Engine[0xCC2919D8D7087E4](0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0xBF54BE1BB3D618B][0xBC48855DCB4BE0E], f110_local4)
				end
			end
			local f110_local5 = f110_arg0.joinResults[1].sourceLobbyType
			local f110_local6 = f110_arg0.joinResults[1].targetLobbyType
			Engine[0xC31C302EB4FEC60](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f110_local5, f110_local6)
			Engine[0xBB840C7E3D32BD6](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f110_local6)
			Engine[0xBB840C7E3D32BD6](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f110_local5)
			Engine[0xBB840C7E3D32BD6](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f110_local5)
			Lobby.Timer.HostingLobbyEnd({
				lobbyType = f110_local6,
			})
			Engine[0xC14588B2A2D6111](f110_arg0.controller, f110_local6)
			f110_local3 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f110_local6)
			for f110_local10, f110_local11 in ipairs(f110_local3.sessionClients) do
				Engine[0x5D28F97B2C14CD7](f110_arg0.controller, f110_local6, f110_local11.xuid)
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f110_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.LobbyInRecovery = function()
	return {
		name = "LobbyInRecovery",
		startFuncPtr = function(f112_arg0)
			if Engine[0xD42CEC406A76DA7] then
				Engine[0xD42CEC406A76DA7]()
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f112_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.CanHostServer = function(f113_arg0, f113_arg1)
	return {
		name = "CanHostServer",
		controller = f113_arg0,
		toTarget = f113_arg1,
		failureReason = nil,
		startFuncPtr = function(f114_arg0)
			local f114_local0 = Engine[0x29B25E8DA873863](Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
			if f114_arg0.toTarget[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
				if Engine[0x48BF994ADFE1D81] and Engine[0x48BF994ADFE1D81](f114_arg0.controller, LuaEnum.FEATURE_BAN.MP_HOSTING) == true then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "CANNOT HOST A SERVER: HOST_SERVER_BANNED_FROM_HOSTING.\n")
					LobbyVM.ProcessCompleteFailure({
						actionId = f114_arg0.actionId,
					})
					return
				elseif not Lobby.MatchmakingMP.AllowListenSearch(Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F])) then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "CANNOT HOST A SERVER: MATCHMAKING_ALLOW_LISTEN_SERVER_FAIL.\n")
					LobbyVM.ProcessCompleteFailure({
						actionId = f114_arg0.actionId,
					})
					return
				end
			end
			local f114_local1, f114_local2 = Engine[0x220DEED3D168B64](f114_arg0.controller, f114_local0)
			if LuaUtils.IsArenaPublicGame() and Lobby.MatchmakingArena.CanHostAnyLobby() == false then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "CANNOT HOST A SERVER: ARENA MATCHMAKING DENIED HOST REQUEST\n")
				LobbyVM.ProcessCompleteFailure({
					actionId = f114_arg0.actionId,
				})
				return
			elseif f114_local1 == true then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Can host server.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f114_arg0.actionId,
				})
				return
			end
			f114_arg0.failureReason = f114_local2
			local f114_local3 = "HOST_SERVER_UNKNOWN"
			if f114_local2 == Enum[0x9ED646D0DDCBDC4][0xCFDE86B838BEE5E] then
				f114_local3 = "HOST_SERVER_BANDWIDTH_TEST_IN_PROGRESS"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x6EDB62EDB55B59F] then
				f114_local3 = "HOST_SERVER_NOT_HOST_OF_PARTY"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x3368DF8DA839A28] then
				f114_local3 = "HOST_SERVER_DEDICATED_ONLY"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x94CC25CBCE98CB5] then
				f114_local3 = "HOST_SERVER_NAT_TYPE_NOT_ALLOWED"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x6A6ED0A5094337B] then
				f114_local3 = "HOST_SERVER_WE_SHOULD_NOT_HOST"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x25AD7617B5EAD7D] then
				f114_local3 = "HOST_SERVER_IS_NOT_GOOD_CITIZEN"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0xE1BF17C3F2FC884] then
				f114_local3 = "HOST_SERVER_HAS_NOT_NECESSARY_BANDWIDTH"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x3FACF1A8F1C6386] then
				f114_local3 = "HOST_SERVER_NET_ENGINE_NOT_STARTED"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x8903CB12523ADA5] then
				f114_local3 = "HOST_SERVER_LIVE_STREAMING"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0x75591E2EF3FEEA8] then
				f114_local3 = "HOST_SERVER_BANNED_FROM_HOSTING"
			elseif f114_local2 == Enum[0x9ED646D0DDCBDC4][0xBE54A516F10DEE9] then
				f114_local3 = "HOST_SERVER_IS_IN_SHARE_PLAY"
			end
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "CANNOT HOST A SERVER: " .. f114_local3 .. ".\n")
			LobbyVM.ProcessCompleteFailure({
				actionId = f114_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.GeoMinCheck = function(f115_arg0, f115_arg1)
	local f115_local0 = Dvar[0xE01BF4D20878528]:get()
	if f115_local0 == 0 then
		return true
	end
	local f115_local1 = 0
	if f115_arg0.geo_1 == f115_arg1.geo_1 then
		f115_local1 = f115_local1 + 1
		if f115_arg0.geo_2 == f115_arg1.geo_2 then
			f115_local1 = f115_local1 + 1
			if f115_arg0.geo_3 == f115_arg1.geo_3 then
				f115_local1 = f115_local1 + 1
				if f115_arg0.geo_4 == f115_arg1.geo_4 then
					f115_local1 = f115_local1 + 1
				end
			end
		end
	end
	return f115_local0 <= f115_local1
end
Lobby.Actions.SkillCheck = function(f116_arg0, f116_arg1)
	if LuaUtils.IsArenaPublicGame() then
		return true
	elseif f116_arg1.isEmpty ~= 0 then
		return true
	elseif f116_arg1.serverType ~= Lobby.Matchmaking.ServerType.DEDICATED_SERVER then
		return true
	else
		local f116_local0 = math.abs(f116_arg0 - f116_arg1.skill)
		local f116_local1 = Engine[0xEDCFC612B39E0C0]("lobbySearchBaseSkillRange") + Lobby.Matchmaking.SearchParams.retry * Engine[0xEDCFC612B39E0C0]("lobbySearchSkillRangeMultiplier")
		if f116_local1 <= 0 then
			return true
		else
			return f116_local0 < f116_local1
		end
	end
end
Lobby.Actions.SearchForLobby = function(f117_arg0, f117_arg1)
	return {
		name = "LobbySearch",
		controller = f117_arg0,
		lobbyType = f117_arg1,
		filteredResult = {},
		startFuncPtr = function(f118_arg0)
			Lobby.Matchmaking.SetupMatchmakingStage(f118_arg0.controller)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "SearchForLobby, begin search.\n")
			Engine[0x6B0CDE5EAB90C2C](f118_arg0.actionId, f118_arg0.lobbyType)
		end,
		endFuncPtr = function(f119_arg0)
			local f119_local0 = Engine[0xFB8EB10109D195D]()
			local f119_local1 = Engine[0x69C1EA76FF06067](f119_arg0.lobbyType)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "SearchForLobby, number of results found " .. f119_local1.numResults .. ".\n")
			local f119_local2 = f119_local1.errorCode
			local f119_local3 = f119_local1.numResults
			Lobby.Debug.SessionSQJSearchResults(f119_local1)
			if f119_local3 == 0 then
				return
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------SEARCH RESULTS----------------------------\n")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "xuid, gameSecurityId, gameType, maxPlayers, numPlayers, serverType, showInMatchmaking, netcodeVersion, mapPacks, playlistVersion, playlistNumber, isEmpty, teamSizeMax, skill, serverLocation, latencyBand, geo_1, geo_2, geo_3, geo_4\n")
			for f119_local7, f119_local8 in ipairs(f119_local1.remoteHosts) do
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], tostring(f119_local8.xuid) .. ", " .. Engine[0x4C599F1694E23EF](f119_local8.gameSecurityId) .. ", " .. f119_local8.gameType .. ", " .. f119_local8.maxPlayers .. ", " .. f119_local8.numPlayers .. ", " .. f119_local8.serverType .. ", " .. f119_local8.showInMatchmaking .. ", " .. f119_local8.netcodeVersion .. ", " .. f119_local8.mapPacks .. ", " .. f119_local8.playlistVersion .. ", " .. f119_local8.playlistNumber .. ", " .. f119_local8.isEmpty .. ", " .. f119_local8.teamSizeMax .. ", " .. f119_local8.skill .. ", " .. f119_local8.serverLocation .. ", " .. f119_local8.latencyBand .. ", " .. Engine[0x4C599F1694E23EF](f119_local8.geo_1) .. ", " .. Engine[0x4C599F1694E23EF](f119_local8.geo_2) .. ", " .. Engine[0x4C599F1694E23EF](f119_local8.geo_3) .. ", " .. Engine[0x4C599F1694E23EF](f119_local8.geo_4) .. ".\n")
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "-----------------------------------------------------------------------\n")
			f119_arg0.filteredResult = {}
			f119_local4 = Engine[0xA8F2AC61C57D927]()
			f119_local5 = Engine[0x19F19E9171B560D](f119_arg0.lobbyType)
			f119_local6 = 1
			for f119_local12, f119_local13 in ipairs(f119_local1.remoteHosts) do
				if f119_local5 == f119_local13.xuid then
				end
				hostOK = false
				if f119_local13.serverType == Lobby.Matchmaking.ServerType.DEDICATED_SERVER then
					if Engine[0xE39F1F30B306065]() == true then
						hostOK = true
					else
						latencytoserverlocation = Engine[0xA42AA434AE31122](f119_local13.serverLocation)
						if f119_local13.latencyBand == 0 then
							hostOK = true
						elseif math.abs(f119_local13.latencyBand - latencytoserverlocation) > Dvar[0xC37AB5C77EECFBB]:get() then
							Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Rejecting result from serverlocation " .. f119_local13.serverLocation .. ", the latencyband is " .. f119_local13.latencyBand .. "ms and our latency is " .. latencytoserverlocation .. "\n")
						else
							hostOK = true
						end
					end
				elseif Lobby.Actions.GeoMinCheck(f119_local4, f119_local13) then
					hostOK = true
				end
				if hostOK then
					hostOK = Lobby.Actions.SkillCheck(Dvar[0xD4F5D5C347C308]:get(), f119_local13)
				end
				if hostOK then
					local f119_local10 = Dvar[0xC7745FD758DB978]:get()
					if f119_local10 ~= nil and f119_local10 ~= Engine[0x2B3D98DC8F66DEE]() then
						local f119_local11 = hostOK
						if f119_local11 then
							f119_local11 = f119_local10 == f119_local13.xuid
						end
						hostOK = f119_local11
					end
				end
				if hostOK then
					hostOK = not Lobby.MatchmakingPriority.IgnoreSearchResult(f119_local13.gameSecurityId)
					if hostOK == false then
						Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Matchmaking priority, ignoring host...\n")
						Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], tostring(f119_local13.xuid) .. ", " .. Engine[0x4C599F1694E23EF](f119_local13.gameSecurityId) .. ", " .. f119_local13.gameType .. ", " .. f119_local13.maxPlayers .. ", " .. f119_local13.numPlayers .. ", " .. f119_local13.serverType .. ", " .. f119_local13.showInMatchmaking .. ", " .. f119_local13.netcodeVersion .. ", " .. f119_local13.mapPacks .. ", " .. f119_local13.playlistVersion .. ", " .. f119_local13.playlistNumber .. ", " .. f119_local13.isEmpty .. ", " .. f119_local13.teamSizeMax .. ", " .. f119_local13.skill .. ", " .. f119_local13.serverLocation .. ", " .. f119_local13.latencyBand .. ", " .. Engine[0x4C599F1694E23EF](f119_local13.geo_1) .. ", " .. Engine[0x4C599F1694E23EF](f119_local13.geo_2) .. ", " .. Engine[0x4C599F1694E23EF](f119_local13.geo_3) .. ", " .. Engine[0x4C599F1694E23EF](f119_local13.geo_4) .. ".\n")
					end
				end
				if hostOK then
					f119_arg0.filteredResult[f119_local6] = {
						xuid = f119_local13.xuid,
						gameSecurityId = f119_local13.gameSecurityId,
						gameSecurityKey = f119_local13.gameSecurityKey,
						hostAddress = f119_local13.hostAddress,
						isDedicated = f119_local13.serverType == Lobby.Matchmaking.ServerType.DEDICATED_SERVER,
					}
					f119_local6 = f119_local6 + 1
				end
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "SearchForLobby, number of filtered results " .. #f119_arg0.filteredResult .. ".\n")
		end,
		errorFuncPtr = function()
			return Engine[0xF9F1239CFD921FE](0x72F63694AEE31E0)
		end,
		cancelFuncPtr = function(f121_arg0)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "SearchForLobby LobbyAction: canceling search.\n")
			Engine[0xFEFD627D17150A9]()
			LobbyVM.ProcessCompleteSuccess({
				actionId = f121_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.JOIN_STATUS = {
	BEGIN = 1,
	ADD = 2,
	FINALIZE = 3,
}
Lobby.Actions.QoSJoinSearchResults = function(f122_arg0, f122_arg1, f122_arg2)
	return {
		name = "QoSJoinSearchResults",
		controller = f122_arg0,
		searchAction = f122_arg1,
		sourceLobbyType = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]),
		targetLobbyType = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43],
		joinStatusCur = Lobby.Actions.JOIN_STATUS.BEGIN,
		minInitialCount = 0,
		updateTime = nil,
		firstResultTime = nil,
		searchTime = nil,
		qosResultsValid = {},
		qosResultsInvalid = {},
		joiningNumHosts = 0,
		joiningCurHost = 1,
		sendCustomInfo = f122_arg2,
		startFuncPtr = function(f123_arg0)
			f123_arg0.sourceLobbyType = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
			f123_arg0.targetLobbyType = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
			f123_arg0.joinStatusCur = Lobby.Actions.JOIN_STATUS.BEGIN
			f123_arg0.minInitialCount = 0
			f123_arg0.updateTime = nil
			f123_arg0.firstResultTime = nil
			f123_arg0.searchTime = nil
			f123_arg0.qosResultsValid = {}
			f123_arg0.qosResultsInvalid = {}
			f123_arg0.joiningNumHosts = 0
			f123_arg0.joiningCurHost = 1
			local f123_local0 = f123_arg0.searchAction.filteredResult
			if f123_local0 == nil then
				error("QoSJoinSearchResults: self.searchAction.filteredResult should not be nil")
				f123_local0 = {}
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, num of search results passed " .. #f123_local0 .. " for QoS.\n")
			if #f123_local0 == 0 then
				LobbyVM.ProcessCompleteFailure({
					actionId = f123_arg0.actionId,
				})
				return
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, starting probes.\n")
			if Engine[0x389324C453AD05B](f123_arg0.actionId, f123_local0) == false then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, QoSProbeInitiate failed.\n")
				LobbyVM.ProcessCompleteFailure({
					actionId = f123_arg0.actionId,
				})
			end
			f123_arg0.minInitialCount = #f123_local0 * Dvar[0xBF3D51224EADDAA]:get() / 100
			f123_arg0.minInitialCount = math.max(f123_arg0.minInitialCount, Dvar[0xF123BB720024336]:get())
			f123_arg0.joinStatusCur = Lobby.Actions.JOIN_STATUS.BEGIN
			f123_arg0.firstResultTime = Engine[0x9D33D652B9B0F3B]()
			f123_arg0.updateTime = Engine[0x9D33D652B9B0F3B]()
			f123_arg0.searchTime = Engine[0x9D33D652B9B0F3B]()
		end,
		pumpFuncPtr = function(f124_arg0)
			if f124_arg0.joinStatusCur == Lobby.Actions.JOIN_STATUS.BEGIN then
				local f124_local0 = Engine[0x9D33D652B9B0F3B]()
				if f124_local0 < f124_arg0.searchTime then
					return
				elseif #f124_arg0.qosResultsValid == 0 and #f124_arg0.searchAction.filteredResult <= #f124_arg0.qosResultsInvalid then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults::pumpFuncPtr, Not expecting any results to join, QoSJoinSearchResults failed.\n")
					LobbyVM.ProcessCompleteFailure({
						actionId = f124_arg0.actionId,
					})
					return
				end
				local f124_local1 = false
				if f124_arg0.minInitialCount <= #f124_arg0.qosResultsValid then
					if f124_local0 - f124_arg0.firstResultTime > Dvar[0x95ED89C6C609D26]:get() then
						if f124_local0 - f124_arg0.updateTime > Dvar[0x127D354AE4B1E8A]:get() then
							f124_local1 = true
						else
							Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, waiting for last update to settle.\n")
						end
					else
						Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, waiting for first update to settle.\n")
					end
				else
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, waiting for " .. f124_arg0.minInitialCount .. " initial results. Current: " .. #f124_arg0.qosResultsValid .. ".\n")
				end
				if #f124_arg0.searchAction.filteredResult <= #f124_arg0.qosResultsInvalid + #f124_arg0.qosResultsValid then
					f124_local1 = true
				end
				if f124_local1 then
					local f124_local2 = function(f125_arg0, f125_arg1)
						if f125_arg0.priorityLow ~= f125_arg1.priorityLow then
							return not f125_arg0.priorityLow
						else
							local f125_local0 = math.floor(f125_arg0.latency / 25)
							local f125_local1 = math.floor(f125_arg1.latency / 25)
							if f125_local0 == f125_local1 then
								if f125_arg0.isMatchEndingSoon == f125_arg1.isMatchEndingSoon then
									return f125_arg0.numAvailableSlots < f125_arg1.numAvailableSlots
								else
									return f125_arg1.isMatchEndingSoon
								end
							else
								return f125_local0 < f125_local1
							end
						end
					end
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, num of initial results returned " .. #f124_arg0.qosResultsValid .. ".\n")
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, begin join.\n")
					Engine[0xBDB9B9ECAA1F594](f124_arg0.actionId, f124_arg0.controller, f124_arg0.sourceLobbyType, f124_arg0.targetLobbyType)
					table.sort(f124_arg0.qosResultsValid, f124_local2)
					for f124_local6, f124_local7 in ipairs(f124_arg0.qosResultsValid) do
						Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Attempting to join xuid: " .. f124_local7.xuidstr .. ".\n")
						f124_arg0.joiningNumHosts = f124_arg0.joiningNumHosts + 1
						Engine[0xB5CD3D18BEBD916](f124_local7.xuid, f124_local7.gameSecurityId, f124_local7.gameSecurityKey, f124_local7.hostAddress, f124_local7.isDedicated, f124_arg0.sendCustomInfo ~= nil)
						Lobby.Debug.SessionSQJJoinInitiate(f124_local7.xuid)
					end
					f124_arg0.joinStatusCur = Lobby.Actions.JOIN_STATUS.ADD
				end
			elseif f124_arg0.joinStatusCur == Lobby.Actions.JOIN_STATUS.ADD then
				if #f124_arg0.qosResultsValid < #f124_arg0.searchAction.filteredResult and Engine[0x9D33D652B9B0F3B]() - f124_arg0.firstResultTime < Dvar[0x1188DC24F4B9776]:get() then
					return
				end
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "QoSJoinSearchResults, finalize join.\n")
				f124_arg0.joinStatusCur = Lobby.Actions.JOIN_STATUS.FINALIZE
				Engine[0x2CDB8071B68C0E1]()
			end
		end,
		updateFuncPtr = function(f126_arg0, f126_arg1)
			if f126_arg1.joinResult then
				Lobby.Debug.SessionSQJJoinResult(f126_arg1)
				f126_arg0.joiningCurHost = math.min(f126_arg0.joiningCurHost + 1, f126_arg0.joiningNumHosts)
				return
			end
			Lobby.Debug.SessionSQJQoSResult(f126_arg1)
			local f126_local0 = nil
			if f126_arg1.validResult == false then
				f126_arg0.qosResultsInvalid[#f126_arg0.qosResultsInvalid + 1] = {
					validResult = f126_arg1.validResult,
					xuid = f126_arg1.xuid,
					xuidstr = f126_arg1.xuidstr,
				}
				Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x69BB0F061EE9FE5, {
					[0x4D5696D6CC12C2F] = "invalid qos",
					[0xC301327501D1E33] = f126_arg1.validResult,
					[0xB5C735486FC7CCB] = f126_arg1.xuid,
				})
				return
			end
			f126_local0 = {
				validResult = f126_arg1.validResult,
				xuid = f126_arg1.xuid,
				xuidstr = f126_arg1.xuidstr,
				gameSecurityId = f126_arg1.gameSecurityId,
				gameSecurityKey = f126_arg1.gameSecurityKey,
				hostAddress = f126_arg1.hostAddress,
				protocol = f126_arg1.protocol,
				isMP = f126_arg1.isMP,
				isMigrating = f126_arg1.isMigrating,
				numAvailableSlots = f126_arg1.numAvailableSlots,
				maxLocalPlayersAllowed = f126_arg1.maxLocalPlayersAllowed,
				allowGuests = f126_arg1.allowGuests,
				isMatchEndingSoon = f126_arg1.isMatchEndingSoon,
				isMatchLoading = f126_arg1.isMatchLoading,
				isDedicated = f126_arg1.isDedicated,
				hostXuid = f126_arg1.hostXuid,
				skill = f126_arg1.skill,
				largestParty = f126_arg1.largestParty,
				latency = f126_arg1.latency,
				minLatency = f126_arg1.minLatency,
				realAddr = f126_arg1.realAddr,
			}
			if f126_arg1.numAvailableSlots <= 0 then
				table.insert(f126_arg0.qosResultsInvalid, f126_local0)
				Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x69BB0F061EE9FE5, {
					[0x4D5696D6CC12C2F] = "ignore qos full",
					[0xC301327501D1E33] = f126_local0.validResult,
					[0xB5C735486FC7CCB] = f126_local0.xuid,
					[0x4F06C6EEDA8117E] = f126_local0.gameSecurityId,
					[0xDF1F57DCD0A3E0A] = f126_local0.gameSecurityKey,
					[0x531894BFD7141D0] = f126_local0.hostAddress,
					[0x2B41998FA3BFFF5] = f126_local0.protocol,
					[0x73E75F9F7CD05DB] = f126_local0.isMP,
					[0x79084C2D9930E90] = f126_local0.isMigrating,
					[0xC83AAF4B52386C5] = f126_local0.numAvailableSlots,
					[0x71438D91EE14A83] = f126_local0.maxLocalPlayersAllowed,
					[0x56C01933E1C7B2E] = f126_local0.allowGuests,
					[0x60665EBC12305D7] = f126_local0.isMatchEndingSoon,
					[0xFF95C0713324A4] = f126_local0.isMatchLoading,
					[0x5C78C17E110A17] = f126_local0.isDedicated,
					[0xF1F610DEC910DA] = f126_local0.hostXuid,
					[0x452F941EF87D736] = f126_local0.skill,
					[0x9B84710151BAF78] = f126_local0.largestParty,
					[0xF0C611526EAB2B9] = f126_local0.latency,
					[0x155D04EDC797A1A] = f126_local0.minLatency,
					[0x259F4FBB3F7A05] = f126_local0.realAddr,
				})
				return
			end
			local f126_local1 = f126_arg1.isDedicated
			if f126_local1 then
				f126_local1 = f126_arg1.largestParty == 0
			end
			if LuaUtils.IsArenaPublicGame() and not f126_local1 and math.floor(math.abs(f126_local0.skill - Engine[0x130B239B214E881](f122_arg0, Engine[0xEF39E16C566439B]()))) > Lobby.MatchmakingArena.GetArenaSkillRange(true) then
				table.insert(f126_arg0.qosResultsInvalid, f126_local0)
				Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x69BB0F061EE9FE5, {
					[0x4D5696D6CC12C2F] = "ignore qos skill",
					[0xC301327501D1E33] = f126_local0.validResult,
					[0xB5C735486FC7CCB] = f126_local0.xuid,
					[0x4F06C6EEDA8117E] = f126_local0.gameSecurityId,
					[0xDF1F57DCD0A3E0A] = f126_local0.gameSecurityKey,
					[0x531894BFD7141D0] = f126_local0.hostAddress,
					[0x2B41998FA3BFFF5] = f126_local0.protocol,
					[0x73E75F9F7CD05DB] = f126_local0.isMP,
					[0x79084C2D9930E90] = f126_local0.isMigrating,
					[0xC83AAF4B52386C5] = f126_local0.numAvailableSlots,
					[0x71438D91EE14A83] = f126_local0.maxLocalPlayersAllowed,
					[0x56C01933E1C7B2E] = f126_local0.allowGuests,
					[0x60665EBC12305D7] = f126_local0.isMatchEndingSoon,
					[0xFF95C0713324A4] = f126_local0.isMatchLoading,
					[0x5C78C17E110A17] = f126_local0.isDedicated,
					[0xF1F610DEC910DA] = f126_local0.hostXuid,
					[0x452F941EF87D736] = f126_local0.skill,
					[0x9B84710151BAF78] = f126_local0.largestParty,
					[0xF0C611526EAB2B9] = f126_local0.latency,
					[0x155D04EDC797A1A] = f126_local0.minLatency,
					[0x259F4FBB3F7A05] = f126_local0.realAddr,
				})
				return
			elseif f126_local0.isDedicated == true then
				if f126_local0.latency * 1000 > Dvar[0x39E15BDB813DCCB]:get() then
					table.insert(f126_arg0.qosResultsInvalid, f126_local0)
					Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x69BB0F061EE9FE5, {
						[0x4D5696D6CC12C2F] = "ignore qos latency",
						[0xC301327501D1E33] = f126_local0.validResult,
						[0xB5C735486FC7CCB] = f126_local0.xuid,
						[0x4F06C6EEDA8117E] = f126_local0.gameSecurityId,
						[0xDF1F57DCD0A3E0A] = f126_local0.gameSecurityKey,
						[0x531894BFD7141D0] = f126_local0.hostAddress,
						[0x2B41998FA3BFFF5] = f126_local0.protocol,
						[0x73E75F9F7CD05DB] = f126_local0.isMP,
						[0x79084C2D9930E90] = f126_local0.isMigrating,
						[0xC83AAF4B52386C5] = f126_local0.numAvailableSlots,
						[0x71438D91EE14A83] = f126_local0.maxLocalPlayersAllowed,
						[0x56C01933E1C7B2E] = f126_local0.allowGuests,
						[0x60665EBC12305D7] = f126_local0.isMatchEndingSoon,
						[0xFF95C0713324A4] = f126_local0.isMatchLoading,
						[0x5C78C17E110A17] = f126_local0.isDedicated,
						[0xF1F610DEC910DA] = f126_local0.hostXuid,
						[0x452F941EF87D736] = f126_local0.skill,
						[0x9B84710151BAF78] = f126_local0.largestParty,
						[0xF0C611526EAB2B9] = f126_local0.latency,
						[0x155D04EDC797A1A] = f126_local0.minLatency,
						[0x259F4FBB3F7A05] = f126_local0.realAddr,
					})
					return
				end
			elseif f126_local0.latency * 1000 > Dvar[0xD12B3AE4A4BEBB8]:get() then
				table.insert(f126_arg0.qosResultsInvalid, f126_local0)
				Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x69BB0F061EE9FE5, {
					[0x4D5696D6CC12C2F] = "ignore qos latency",
					[0xC301327501D1E33] = f126_local0.validResult,
					[0xB5C735486FC7CCB] = f126_local0.xuid,
					[0x4F06C6EEDA8117E] = f126_local0.gameSecurityId,
					[0xDF1F57DCD0A3E0A] = f126_local0.gameSecurityKey,
					[0x531894BFD7141D0] = f126_local0.hostAddress,
					[0x2B41998FA3BFFF5] = f126_local0.protocol,
					[0x73E75F9F7CD05DB] = f126_local0.isMP,
					[0x79084C2D9930E90] = f126_local0.isMigrating,
					[0xC83AAF4B52386C5] = f126_local0.numAvailableSlots,
					[0x71438D91EE14A83] = f126_local0.maxLocalPlayersAllowed,
					[0x56C01933E1C7B2E] = f126_local0.allowGuests,
					[0x60665EBC12305D7] = f126_local0.isMatchEndingSoon,
					[0xFF95C0713324A4] = f126_local0.isMatchLoading,
					[0x5C78C17E110A17] = f126_local0.isDedicated,
					[0xF1F610DEC910DA] = f126_local0.hostXuid,
					[0x452F941EF87D736] = f126_local0.skill,
					[0x9B84710151BAF78] = f126_local0.largestParty,
					[0xF0C611526EAB2B9] = f126_local0.latency,
					[0x155D04EDC797A1A] = f126_local0.minLatency,
					[0x259F4FBB3F7A05] = f126_local0.realAddr,
				})
				return
			end
			Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x69BB0F061EE9FE5, {
				[0x4D5696D6CC12C2F] = "valid qos",
				[0xC301327501D1E33] = f126_local0.validResult,
				[0xB5C735486FC7CCB] = f126_local0.xuid,
				[0x4F06C6EEDA8117E] = f126_local0.gameSecurityId,
				[0xDF1F57DCD0A3E0A] = f126_local0.gameSecurityKey,
				[0x531894BFD7141D0] = f126_local0.hostAddress,
				[0x2B41998FA3BFFF5] = f126_local0.protocol,
				[0x73E75F9F7CD05DB] = f126_local0.isMP,
				[0x79084C2D9930E90] = f126_local0.isMigrating,
				[0xC83AAF4B52386C5] = f126_local0.numAvailableSlots,
				[0x71438D91EE14A83] = f126_local0.maxLocalPlayersAllowed,
				[0x56C01933E1C7B2E] = f126_local0.allowGuests,
				[0x60665EBC12305D7] = f126_local0.isMatchEndingSoon,
				[0xFF95C0713324A4] = f126_local0.isMatchLoading,
				[0x5C78C17E110A17] = f126_local0.isDedicated,
				[0xF1F610DEC910DA] = f126_local0.hostXuid,
				[0x452F941EF87D736] = f126_local0.skill,
				[0x9B84710151BAF78] = f126_local0.largestParty,
				[0xF0C611526EAB2B9] = f126_local0.latency,
				[0x155D04EDC797A1A] = f126_local0.minLatency,
				[0x259F4FBB3F7A05] = f126_local0.realAddr,
			})
			f126_arg0.updateTime = Engine[0x9D33D652B9B0F3B]()
			if #f126_arg0.qosResultsValid == 0 then
				f126_arg0.firstResultTime = f126_arg0.updateTime
			end
			f126_local0.priorityLow = Lobby.MatchmakingPriority.IsPriorityLow(f126_local0.gameSecurityId)
			f126_arg0.qosResultsValid[#f126_arg0.qosResultsValid + 1] = f126_local0
			if f126_arg0.joinStatusCur == Lobby.Actions.JOIN_STATUS.START then
			elseif f126_arg0.joinStatusCur == Lobby.Actions.JOIN_STATUS.ADD then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Attempting to join xuid: " .. f126_local0.xuidstr .. ".\n")
				f126_arg0.joiningNumHosts = f126_arg0.joiningNumHosts + 1
				Engine[0xB5CD3D18BEBD916](f126_local0.xuid, f126_local0.gameSecurityId, f126_local0.gameSecurityKey, f126_local0.hostAddress, f126_local0.isDedicated, f126_arg0.sendCustomInfo ~= nil)
			elseif f126_arg0.joinStatusCur == Lobby.Actions.JOIN_STATUS.FINALIZE then
			else
			end
		end,
		endFuncPtr = function(f127_arg0)
			Engine[0x1DD0A5CE833568F]()
			Engine[0xA6B364A77D75A61]()
		end,
		cancelFuncPtr = function(f128_arg0)
			Engine[0x1DD0A5CE833568F]()
			Engine[0xA6B364A77D75A61]()
			LobbyVM.ProcessCompleteSuccess({
				actionId = f128_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.AdvertiseLobby = function(f129_arg0)
	return {
		name = "AdvertiseLobby",
		onOff = f129_arg0,
		lobbyType = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43],
		startFuncPtr = function(f130_arg0)
			Lobby.Matchmaking.SetupAdvertising()
			Engine[0x20B50CDD594E8C6](f130_arg0.actionId, f130_arg0.lobbyType, f130_arg0.onOff)
		end,
		errorFuncPtr = function(f131_arg0)
			local f131_local0 = ""
			local f131_local1 = ""
			if f131_arg0.onOff == true then
				f131_local0 = Engine[0xF9F1239CFD921FE](0x72F63694AEE31E0)
				f131_local1 = "Failed to turn on lobby advertising"
			else
				f131_local1 = "Failed to turn off lobby advertising"
			end
			if not Engine[0x2DA54CF5D6B7F02]() then
				return f131_local0
			else
				return f131_local0 .. "\n\nDEBUG INFO: AdvertiseLobby( " .. f131_local1 .. " )\n"
			end
		end,
	}
end
Lobby.Actions.LobbyInfoProbe = function(f132_arg0, f132_arg1)
	return {
		name = "InfoProbe",
		controller = f132_arg0,
		info = f132_arg1,
		probeResult = nil,
		startFuncPtr = function(f133_arg0)
			Engine[0x40A76E1BC90F8E3](f133_arg0.actionId, f133_arg0.controller, f133_arg0.info.xuid)
		end,
		endFuncPtr = function(f134_arg0)
			f134_arg0.probeResult = f134_arg0.retData
			f134_arg0.probeResult.probedXuid = f134_arg0.info.xuid
		end,
	}
end
Lobby.Actions.CheckRestrictedClients = function(f135_arg0, f135_arg1, f135_arg2)
	return {
		name = "CheckRestrictedClients",
		controller = f135_arg0,
		infoProbe = f135_arg1,
		targetMainMode = f135_arg2,
		trialMembersRemoved = 0,
		koreanUnderageMembersRemoved = 0,
		limitedNoZMMembersRemoved = 0,
		directMode = f135_arg2,
		waitTill = Engine[0x9D33D652B9B0F3B]() + Dvar[0x619CBA0E2C06E32]:get(),
		startFuncPtr = function(f136_arg0)
			if f136_arg0.infoProbe ~= nil then
				f136_arg0.targetMainMode = f136_arg0.infoProbe.probeResult.mainMode
			end
			assert(f136_arg0.targetMainMode ~= nil)
			local f136_local0 = true
			if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
				if f136_arg0.targetMainMode ~= Enum[0x89C1455C5032969][0x78C124999125C42] and f136_arg0.targetMainMode ~= Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] and Engine[0xAEF2B6FA8A0BE77]() then
					f136_arg0.trialMembersRemoved = Engine[0x4DAF7B02664BF69](f136_arg0.controller)
					f136_local0 = false
				end
				if f136_arg0.targetMainMode == Enum[0x89C1455C5032969][0x79D01499920B292] then
					if Engine[0x7567E8691BA45BA]() then
						f136_arg0.koreanUnderageMembersRemoved = Engine[0xA31028790AF1818](f136_arg0.controller)
						f136_local0 = false
					end
					if Engine[0xEE3E4DCDA4DB3F]() then
						f136_arg0.limitedNoZMMembersRemoved = Engine[0x3A15B7FFA141651](f136_arg0.controller)
						f136_local0 = false
					end
				end
			end
			if f136_local0 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f136_arg0.actionId,
				})
			end
		end,
		pumpFuncPtr = function(f137_arg0)
			local f137_local0 = true
			if f137_arg0.trialMembersRemoved and Engine[0xAEF2B6FA8A0BE77]() then
				f137_local0 = false
			end
			if f137_arg0.koreanUnderageMembersRemoved and Engine[0x7567E8691BA45BA]() then
				f137_local0 = false
			end
			if f137_arg0.limitedNoZMMembersRemoved and Engine[0xEE3E4DCDA4DB3F]() then
				f137_local0 = false
			end
			if f137_local0 or f137_arg0.waitTill < Engine[0x9D33D652B9B0F3B]() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f137_arg0.actionId,
				})
			end
		end,
		endFuncPtr = function(f138_arg0)
			if f138_arg0.trialMembersRemoved > 0 or f138_arg0.koreanUnderageMembersRemoved > 0 or f138_arg0.limitedNoZMMembersRemoved > 0 then
				Engine[0xE1789115A2356E7]("open_toaster_popup", {
					toastType = "trial_clients_kicked",
					isError = false,
					controller = f138_arg0.controller,
					immediate = true,
					trialMembersRemoved = f138_arg0.trialMembersRemoved,
					koreanUnderageMembersRemoved = f138_arg0.koreanUnderageMembersRemoved,
					limitedNoZMMembersRemoved = f138_arg0.limitedNoZMMembersRemoved,
				})
			end
		end,
	}
end
Lobby.Actions.CheckGlobalFirstTimeFlowRequirements = function(f139_arg0)
	return {
		name = "CheckfirstTimeFlow",
		controller = f139_arg0,
		info = infoProbe,
		mainMode = nil,
		startFuncPtr = function(f140_arg0)
			if Dvar[0x2BE8FB76AD6AEA3]:get() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f140_arg0.actionId,
				})
				return
			elseif CoDShared.IsMainFirstTimeSetup(f139_arg0) then
				LobbyVM.ProcessCompleteError({
					actionId = f140_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteSuccess({
					actionId = f140_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.ShowFirstTimeFlowError = function(f141_arg0, f141_arg1)
	return {
		name = "ErrorPopupMsg",
		controller = f141_arg0,
		info = f141_arg1,
		startFuncPtr = function(f142_arg0)
			LobbyVM.ExecuteLobbyVMCreateOverlay(f141_arg0, "EULA")
			LobbyVM.ProcessCompleteSuccess({
				actionId = f142_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.CheckFirstTimeFlowRequirements = function(f143_arg0, f143_arg1)
	return {
		name = "CheckfirstTimeFlow",
		controller = f143_arg0,
		info = f143_arg1,
		mainMode = nil,
		startFuncPtr = function(f144_arg0)
			if CoDShared.IsMainFirstTimeSetup(f143_arg0) then
				LobbyVM.ProcessCompleteError({
					actionId = f144_arg0.actionId,
				})
			else
				LobbyVM.ProcessCompleteSuccess({
					actionId = f144_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.JoinHost = function(f145_arg0, f145_arg1, f145_arg2, f145_arg3, f145_arg4, f145_arg5, f145_arg6)
	return {
		name = "LobbyJoinHost",
		controller = f145_arg0,
		mainMode = f145_arg1,
		networkMode = f145_arg2,
		hostXuid = f145_arg3,
		hostInfo = f145_arg4,
		joinResults = {},
		startFuncPtr = function(f146_arg0)
			Engine[0x24003824075FD13](f146_arg0.actionId, f146_arg0.controller, f145_arg5, f145_arg6, f146_arg0.hostXuid, f146_arg0.hostInfo)
		end,
		updateFuncPtr = function(f147_arg0, f147_arg1)
			f147_arg0.joinResults[#f147_arg0.joinResults + 1] = f147_arg1
		end,
		errorFuncPtr = function(f148_arg0)
			local f148_local0 = Engine[0xF9F1239CFD921FE](0xA26AA910A2D8FD8)
			if f148_arg0.joinResult == nil and #f148_arg0.joinResults == 0 then
				return f148_local0
			end
			local f148_local1 = f148_arg0.joinResults[#f148_arg0.joinResults].joinResult
			local f148_local2, f148_local3 = Lobby.Join.JoinResultToString(f148_local1, true)
			if f148_local3 then
				local f148_local4 = Engine[0xF9F1239CFD921FE](0xDA680012C01968D)
				local f148_local5 = 0x0
				if f148_local1 == Enum[0x2E4144AA1C3ABB8][0x190D2DCFDB65D5] then
					f148_local5 = 0x55D96CC762EABDD
				elseif f148_local1 == Enum[0x2E4144AA1C3ABB8][0xFD8202DCFA3EF29] then
					f148_local5 = 0xB06081B8B4567F2
				end
				f148_local0 = Engine[0xF9F1239CFD921FE](f148_local2.errorMsg, f148_local4, f148_local5)
			else
				f148_local0 = Engine[0xF9F1239CFD921FE](f148_local2.errorMsg)
			end
			if not Engine[0x2DA54CF5D6B7F02]() then
				return f148_local0
			end
			return f148_local0 .. "\n\nDEBUG INFO: JoinResult( " .. tostring(f148_local1) .. " )\n" .. f148_local2.debug
		end,
	}
end
Lobby.Actions.LobbyJoinXUID = function(f149_arg0, f149_arg1, f149_arg2)
	return {
		name = "LobbyJoinXUID",
		controller = f149_arg0,
		info = f149_arg1,
		joinType = f149_arg2,
		joinResults = {},
		startFuncPtr = function(f150_arg0)
			Engine[0xF258CF9FD0EB1BF](f150_arg0.actionId, f150_arg0.controller, f150_arg0.info.xuid, f150_arg0.joinType)
		end,
		updateFuncPtr = function(f151_arg0, f151_arg1)
			f151_arg0.joinResults[#f151_arg0.joinResults + 1] = f151_arg1
		end,
		endFuncPtr = function(f152_arg0) end,
		errorFuncPtr = function(f153_arg0)
			local f153_local0 = Engine[0xF9F1239CFD921FE](0xA26AA910A2D8FD8)
			if #f153_arg0.joinResults == 0 then
				return f153_local0
			else
				local f153_local1 = f153_arg0.joinResults[#f153_arg0.joinResults].joinResult
				local f153_local2 = Lobby.Join.JoinResultToString(f153_local1, true)
				f153_local0 = Engine[0xF9F1239CFD921FE](f153_local2.errorMsg)
				if not Engine[0x2DA54CF5D6B7F02]() then
					return f153_local0
				else
					return f153_local0 .. "\n\nDEBUG INFO: JoinResult( " .. tostring(f153_local1) .. " )\n" .. f153_local2.debug
				end
			end
		end,
	}
end
Lobby.Actions.LobbyJoinXUIDExt = function(f154_arg0, f154_arg1, f154_arg2, f154_arg3)
	return {
		name = "LobbyJoinXUIDExt",
		controller = f154_arg0,
		joinType = f154_arg1,
		infoProbe = f154_arg2,
		destinationLobby = f154_arg3,
		joinResults = {},
		startFuncPtr = function(f155_arg0)
			local f155_local0 = f155_arg0.infoProbe.probeResult
			local f155_local1 = f155_local0.probedXuid
			local f155_local2 = f155_arg0.destinationLobby
			local f155_local3 = nil
			if f155_local2 == Enum[0xBF54BE1BB3D618B][0x743687BBDF0B150] then
				if f155_local0.gameLobby.isValid == true then
					f155_local2 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
					f155_local3 = f155_local0.gameLobby
				else
					f155_local2 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
					f155_local3 = f155_local0.privateLobby
				end
			elseif f155_local2 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
				f155_local3 = f155_local0.gameLobby
			else
				f155_local3 = f155_local0.privateLobby
			end
			if LuaDefine.isPC and f155_local2 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and Engine[0xD3DDFE2224597C2](f155_arg0.controller, f155_local3.hostXuid) then
				Engine[0xE7B086418037B6F](f155_arg0.controller, f155_local3.hostXuid, Enum[0x2E338C10A793F0C][0x8B7FB4BFD13E7FD])
				local f155_local4 = Engine[0x92F1FB0C7454E9C](f155_arg0.controller)
				if #f155_local4 > 0 then
					for f155_local8, f155_local9 in pairs(f155_local4) do
						Engine[0xAA762AFC32A0F8D](f155_arg0.controller, f155_local9.xuid)
					end
				end
			end
			if Engine[0x4AF291A7FFE8162](f155_arg0.actionId, f155_arg0.controller, f155_local3.isValid, f155_local3.hostXuid, f155_local3.hostName, f155_local2, f155_local3.secId, f155_local3.secKey, f155_local3.serializedAdr, f155_arg0.joinType, f155_local1) == false then
				LobbyVM.ProcessCompleteError({
					actionId = f155_arg0.actionId,
				})
			end
		end,
		updateFuncPtr = function(f156_arg0, f156_arg1)
			f156_arg0.joinResults[#f156_arg0.joinResults + 1] = f156_arg1
		end,
		endFuncPtr = function(f157_arg0) end,
		errorFuncPtr = function(f158_arg0)
			local f158_local0 = Enum[0x50236A3452F3A49][0x9571467DC6166AD]
			if f158_arg0.infoProbe ~= nil and f158_arg0.infoProbe.probeResult ~= nil and f158_arg0.infoProbe.probeResult.natType ~= nil then
				f158_local0 = f158_arg0.infoProbe.probeResult.natType
			end
			local f158_local1 = LuaUtils.IsCompatibleNatConnection(f158_local0)
			local f158_local2 = Engine[0xF9F1239CFD921FE](0xA26AA910A2D8FD8)
			if #f158_arg0.joinResults == 0 then
				if f158_local1 == false then
					f158_local2 = Engine[0xF9F1239CFD921FE](0xF537235B7DCCDA1)
				end
				return f158_local2
			end
			local f158_local3 = f158_arg0.joinResults[#f158_arg0.joinResults].joinResult
			local f158_local4, f158_local5 = Lobby.Join.JoinResultToString(f158_local3, true)
			if f158_local1 == false and (f158_local3 == Enum[0x2E4144AA1C3ABB8][0xB4F111D99295074] or f158_local3 == Enum[0x2E4144AA1C3ABB8][0x5C738AF2ADFCAEF]) then
				f158_local2 = Engine[0xF9F1239CFD921FE](0xF537235B7DCCDA1)
			else
				if f158_local5 == true then
					f158_local4.errorMsg = Lobby.Join.GetRestrictedJoinFailedMessage(f158_arg0.infoProbe, true)
				elseif f158_local3 == Enum[0x2E4144AA1C3ABB8][0xE1121BBA975AA40] then
					f158_local4.errorMsg = Lobby.Join.GetRestrictedJoinFailedMessage(f158_arg0.infoProbe, false)
				end
				f158_local2 = Engine[0xF9F1239CFD921FE](f158_local4.errorMsg)
			end
			if not Engine[0x2DA54CF5D6B7F02]() then
				return f158_local2, f158_local5
			end
			return f158_local2 .. "\n\nDEBUG INFO: JoinResult( " .. tostring(f158_local3) .. " )\n" .. f158_local4.debug, f158_local5
		end,
	}
end
Lobby.Actions.LobbyJoinSession = function(f159_arg0, f159_arg1, f159_arg2)
	return {
		name = "LobbyJoinSession",
		controller = f159_arg0,
		destinationLobby = f159_arg1,
		joinType = f159_arg2,
		joinResults = {},
		startFuncPtr = function(f160_arg0)
			local f160_local0 = Engine[0xA33D06620AC0D6B](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f160_arg0.destinationLobby)
			if f160_local0 == nil then
				LobbyVM.ProcessCompleteError({
					actionId = f160_arg0.actionId,
				})
				return
			elseif Engine[0x4AF291A7FFE8162](f160_arg0.actionId, f160_arg0.controller, true, f160_local0.xuid, f160_local0.name, f159_arg1, f160_local0.secIdint, f160_local0.secKey, f160_local0.serializedAdr, f160_arg0.joinType, f160_local0.xuid) == false then
				LobbyVM.ProcessCompleteError({
					actionId = f160_arg0.actionId,
				})
				return
			else
			end
		end,
		updateFuncPtr = function(f161_arg0, f161_arg1)
			f161_arg0.joinResults[#f161_arg0.joinResults + 1] = f161_arg1
		end,
		endFuncPtr = function(f162_arg0) end,
		errorFuncPtr = function(f163_arg0)
			local f163_local0 = Enum[0x50236A3452F3A49][0x9571467DC6166AD]
			if f163_arg0.infoProbe ~= nil and f163_arg0.infoProbe.probeResult ~= nil and f163_arg0.infoProbe.probeResult.natType ~= nil then
				f163_local0 = f163_arg0.infoProbe.probeResult.natType
			end
			local f163_local1 = LuaUtils.IsCompatibleNatConnection(f163_local0)
			local f163_local2 = Engine[0xF9F1239CFD921FE](0xA26AA910A2D8FD8)
			if #f163_arg0.joinResults == 0 then
				if f163_local1 == false then
					f163_local2 = Engine[0xF9F1239CFD921FE](0xF537235B7DCCDA1)
				end
				return f163_local2
			end
			local f163_local3 = f163_arg0.joinResults[#f163_arg0.joinResults].joinResult
			local f163_local4 = Lobby.Join.JoinResultToString(f163_local3, true)
			if f163_local1 == false and (f163_local3 == Enum[0x2E4144AA1C3ABB8][0xB4F111D99295074] or f163_local3 == Enum[0x2E4144AA1C3ABB8][0x5C738AF2ADFCAEF]) then
				f163_local2 = Engine[0xF9F1239CFD921FE](0xF537235B7DCCDA1)
			else
				f163_local2 = Engine[0xF9F1239CFD921FE](f163_local4.errorMsg)
			end
			if not Engine[0x2DA54CF5D6B7F02]() then
				return f163_local2
			end
			return f163_local2 .. "\n\nDEBUG INFO: JoinResult( " .. tostring(f163_local3) .. " )\n" .. f163_local4.debug
		end,
	}
end
Lobby.Actions.WaitForJoiningClients = function(f164_arg0)
	return {
		name = "WaitForJoiningClients",
		waitMilliseconds = f164_arg0,
		endWaitTime = nil,
		startFuncPtr = function(f165_arg0)
			f165_arg0.endWaitTime = f165_arg0.waitMilliseconds + Engine[0x9D33D652B9B0F3B]()
			local f165_local0 = Engine[0xC9190AFD905AC12]()
			if f165_local0 == 0 then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f165_arg0.actionId,
				})
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "WaitForJoiningClients start, number of joining clients: " .. f165_local0 .. ". Waiting " .. f165_arg0.waitMilliseconds .. "ms for clients to join.\n")
		end,
		pumpFuncPtr = function(f166_arg0)
			local f166_local0 = Engine[0xC9190AFD905AC12]()
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "WaitForJoiningClients pump, number of clients still joining: " .. f166_local0 .. ". Waiting for " .. f166_arg0.endWaitTime - Engine[0x9D33D652B9B0F3B]() .. "ms\n")
			if f166_arg0.endWaitTime < Engine[0x9D33D652B9B0F3B]() then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "WaitForJoiningClients pump stop, number of clients still joining: " .. f166_local0 .. ". Clients took to long to join.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f166_arg0.actionId,
				})
				return
			elseif f166_local0 == 0 then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "WaitForJoiningClients pump stop, All clients have joined.\n")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f166_arg0.actionId,
				})
				return
			else
			end
		end,
		cancelFuncPtr = function(f167_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f167_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.LobbySettings = function(f168_arg0, f168_arg1, f168_arg2, f168_arg3)
	return {
		name = "LobbySettings",
		controller = f168_arg0,
		toTarget = f168_arg1,
		skipSwitchMode = f168_arg2,
		isDevMap = f168_arg3,
		startFuncPtr = function(f169_arg0)
			LobbyVM.OnLobbySettings({
				controller = f168_arg0,
				toTarget = f168_arg1,
				skipSwitchMode = f168_arg2,
				isDevMap = f168_arg3,
			})
			LobbyVM.ProcessCompleteSuccess({
				actionId = f169_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.SetQueueCancellable = function(f170_arg0)
	return {
		name = "SetQueueCancellable",
		startFuncPtr = function(f171_arg0)
			Lobby.ProcessQueue.SetCancellable(f170_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f171_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.UpdateUI = function(f172_arg0, f172_arg1)
	return {
		name = "UpdateUI",
		require = "LobbySettings",
		controller = f172_arg0,
		toTarget = f172_arg1,
		startFuncPtr = function(f173_arg0)
			if LuaUtils.SkipDirectorOnlineMenu() and f172_arg1[0x4BCADBA8E631B86] == "director_online" then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f173_arg0.actionId,
				})
				return
			else
				LobbyVM.OnUpdateUI({
					controller = f172_arg0,
					toTarget = f172_arg1,
				})
				LobbyVM.ProcessCompleteSuccess({
					actionId = f173_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.SetNetworkMode = function(f174_arg0, f174_arg1)
	return {
		name = "SetNetworkMode",
		controller = f174_arg0,
		networkMode = f174_arg1,
		startFuncPtr = function(f175_arg0)
			Engine[0xEF56B086D9D2C36](f175_arg0.networkMode)
			Engine[0x7C75E608EA39B5C](f175_arg0.controller, "savegameRestore")
			Engine[0xB81A5136C5503E4](f175_arg0.controller, "invalidateEmblemComponent")
			LobbyVM.ProcessCompleteSuccess({
				actionId = f175_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.PromoteToHostDone = function(f176_arg0, f176_arg1, f176_arg2, f176_arg3)
	return {
		name = "promoteToHostDone",
		controller = f176_arg0,
		lobbyType = f176_arg1,
		migrateIndexBits = f176_arg2,
		isInGame = f176_arg3,
		startFuncPtr = function(f177_arg0)
			Engine[0xB3B5C056731105A](f177_arg0.lobbyType, f177_arg0.migrateIndexBits)
			Engine[0x9DB4788AE93C72D](f177_arg0.lobbyType, Engine[0xE67E7253CC272C9]())
			Engine[0x1673E80DCB5CEA3](f177_arg0.lobbyType, Engine[0x69811927938FCD7]())
			Engine[0x736BCA4DB2384D0](f177_arg0.controller, f177_arg0.lobbyType, f177_arg0.isInGame)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f177_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.SignUserInToLive = function(f178_arg0)
	return {
		name = "SignUserInToLive",
		controller = f178_arg0,
		startFuncPtr = function(f179_arg0)
			Engine[0x67D3EF8A6745CF](f179_arg0.controller)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f179_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.SignUserOutOfLive = function(f180_arg0, f180_arg1)
	return {
		name = "SignUserOutOfLive",
		controller = f180_arg0,
		networkMode = f180_arg1,
		startFuncPtr = function(f181_arg0)
			Engine[0xFFC43E7E09D84E6](f181_arg0.controller)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f181_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.PlatformSessionGetSessionInfo = function(f182_arg0, f182_arg1, f182_arg2, f182_arg3, f182_arg4)
	return {
		name = "PlatformSessionGetSessionInfo",
		controller = f182_arg0,
		lobbyType = f182_arg2,
		xuid = f182_arg1,
		sessionId = f182_arg3,
		invitation = f182_arg4,
		info = {},
		gamertag = nil,
		gamertags = nil,
		startFuncPtr = function(f183_arg0)
			if f183_arg0.invitation ~= nil and f183_arg0.invitation.sessionId ~= nil then
				f183_arg0.sessionId = f183_arg0.invitation.sessionId
			end
			if Lobby.Platform.PlatformSessionOrbisEnabled() == false or Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f183_arg0.actionId,
				})
				return
			else
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "PlatformSession - get info for sessionId:" .. f183_arg0.sessionId .. "\n")
				if Engine[0x781BEE514AE7ACA](f183_arg0.actionId, f183_arg0.controller, f183_arg0.xuid, f183_arg0.lobbyType, f183_arg0.sessionId) == false then
					LobbyVM.ProcessCompleteFailure({
						actionId = f183_arg0.actionId,
					})
					return
				else
				end
			end
		end,
		endFuncPtr = function(f184_arg0)
			if Lobby.Platform.PlatformSessionOrbisEnabled() == false or Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] then
				return
			elseif f184_arg0.retData.isError == true then
				return
			end
			f184_arg0.info = {
				sessionId = f184_arg0.retData.sessionId,
				sessionName = f184_arg0.retData.sessionName,
				sessionStatus = f184_arg0.retData.sessionStatus,
				sessionType = f184_arg0.retData.sessionType,
				sessionPrivacy = f184_arg0.retData.sessionPrivacy,
				locked = f184_arg0.retData.locked,
				maxSlots = f184_arg0.retData.maxSlots,
				creationTime = f184_arg0.retData.creationTime,
				sessionCreatorGamertag = f184_arg0.retData.sessionCreatorGamertag,
				sessionCreatorPlatform = f184_arg0.retData.sessionCreatorPlatform,
				members = f184_arg0.retData.members,
			}
			if f184_arg0.info.members ~= nil and #f184_arg0.info.members > 0 then
				f184_arg0.gamertag = f184_arg0.info.members[#f184_arg0.info.members].gamertag
				f184_arg0.gamertags = {}
				for f184_local0 = 1, #f184_arg0.info.members, 1 do
					f184_arg0.gamertags[f184_local0] = f184_arg0.info.members[f184_local0].gamertag
				end
			end
		end,
	}
end
Lobby.Actions.PlatformSessionGetReceivedInvitation = function(f185_arg0, f185_arg1, f185_arg2, f185_arg3)
	return {
		name = "PlatformSessionGetReceivedInvitation",
		controller = f185_arg0,
		lobbyType = f185_arg2,
		xuid = f185_arg1,
		invitationId = f185_arg3,
		info = {},
		startFuncPtr = function(f186_arg0)
			if Lobby.Platform.PlatformSessionOrbisEnabled() == false or Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f186_arg0.actionId,
				})
				return
			else
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "PlatformSession - get details info for invitationId:" .. f186_arg0.invitationId .. "\n")
				if Engine[0xDDB87FEBDF6EC3](f186_arg0.actionId, f186_arg0.controller, f186_arg0.xuid, f186_arg0.lobbyType, f186_arg0.invitationId) == false then
					LobbyVM.ProcessCompleteFailure({
						actionId = f186_arg0.actionId,
					})
					return
				else
				end
			end
		end,
		endFuncPtr = function(f187_arg0)
			if Lobby.Platform.PlatformSessionOrbisEnabled() == false or Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] then
				return
			elseif f187_arg0.retData.isError == true then
				return
			else
				f187_arg0.info.invitationId = f187_arg0.retData.invitationId
				f187_arg0.info.sessionId = f187_arg0.retData.sessionId
				f187_arg0.info.isUsed = f187_arg0.retData.isUsed
				f187_arg0.info.isExpired = f187_arg0.retData.isExpired
				f187_arg0.info.isExpired = f187_arg0.retData.isExpired
				f187_arg0.info.sessionPrivacy = f187_arg0.retData.sessionPrivacy
				f187_arg0.info.fromUser = f187_arg0.retData.fromUser
			end
		end,
	}
end
Lobby.Actions.PlatformSessionGetInviteInfo = function(f188_arg0, f188_arg1, f188_arg2, f188_arg3)
	return {
		name = "PlatformSessionGetInviteInfo",
		controller = f188_arg0,
		xuid = f188_arg1,
		lobbyType = f188_arg2,
		invitationId = f188_arg3,
		info = {},
		gamertag = nil,
		gamertags = nil,
		startFuncPtr = function(f189_arg0)
			if Lobby.Platform.PlatformSessionOrbisEnabled() == false or Engine[0x3CD0351DA0D371](f188_arg0) == false then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f189_arg0.actionId,
				})
				return
			else
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "PlatformSession - get invite info for invitationId:" .. f189_arg0.invitationId .. " sessionId:" .. f189_arg0.sessionId .. "\n")
				if Engine[0x781BEE514AE7ACA](f189_arg0.actionId, f189_arg0.controller, f189_arg0.xuid, f189_arg0.lobbyType, f189_arg0.invitationId) == false then
					LobbyVM.ProcessCompleteFailure({
						actionId = f189_arg0.actionId,
					})
					return
				else
				end
			end
		end,
		endFuncPtr = function(f190_arg0)
			if Lobby.Platform.PlatformSessionOrbisEnabled() == false or Engine[0x3CD0351DA0D371](f190_arg0.controller) == false then
				return
			elseif f190_arg0.retData.isError == true then
				return
			else
				f190_arg0.info.receivedDate = f190_arg0.retData.receivedDate
				f190_arg0.info.usedFlag = f190_arg0.retData.usedFlag
				f190_arg0.info.expired = f190_arg0.retData.expired
				f190_arg0.info.message = f190_arg0.retData.message
				f190_arg0.info.fromGamertag = f190_arg0.retData.fromGamertag
				f190_arg0.info.invitationId = f190_arg0.retData.invitationId
				f190_arg0.info.sessionId = f190_arg0.retData.sessionId
				f190_arg0.gamertag = f190_arg0.retData.fromGamertag
				f190_arg0.gamertags = {}
				f190_arg0.gamertags[1] = f190_arg0.gamertag
			end
		end,
	}
end
Lobby.Actions.GamertagsToXuids = function(f191_arg0, f191_arg1)
	return {
		name = "PlatformSessionJoin",
		controller = f191_arg0,
		info = f191_arg1,
		startFuncPtr = function(f192_arg0)
			if f191_arg1.gamertags == nil or #f191_arg1.gamertags == 0 then
				LobbyVM.ProcessCompleteFailure({
					actionId = f192_arg0.actionId,
				})
				return
			elseif Engine[0x2F0F3BDC96B3342](f192_arg0.actionId, f192_arg0.controller, f192_arg0.info.gamertags) == false then
				LobbyVM.ProcessCompleteFailure({
					actionId = f192_arg0.actionId,
				})
				return
			else
			end
		end,
		endFuncPtr = function(f193_arg0)
			if f193_arg0.retData.isError == true then
				return
			elseif f193_arg0.retData.userInfo == nil or #f193_arg0.retData.userInfo == 0 then
				f193_arg0.gamertag = ""
				f193_arg0.xuid = 0
				return
			else
				f193_arg0.gamertag = f193_arg0.retData.userInfo[1].gamertag
				f193_arg0.xuid = f193_arg0.retData.userInfo[1].xuid
			end
		end,
	}
end
Lobby.Actions.SetGameAndTypeMapName = function(f194_arg0, f194_arg1, f194_arg2, f194_arg3)
	return {
		name = "SetGameAndTypeMapName",
		controller = f194_arg0,
		lobbyType = f194_arg1,
		gameType = f194_arg2,
		mapName = f194_arg3,
		startFuncPtr = function(f195_arg0)
			Engine[0x9DB4788AE93C72D](f195_arg0.lobbyType, f195_arg0.mapName)
			Engine[0x1673E80DCB5CEA3](f195_arg0.lobbyType, f195_arg0.gameType)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f195_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.SetSavedOrDefaultMap = function(f196_arg0, f196_arg1)
	return {
		name = "SetSavedOrDefaultMap",
		controller = f196_arg0,
		startFuncPtr = function(f197_arg0)
			local f197_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
			if Engine[0x293941FE17453F1]() then
				if f196_arg1[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
					local f197_local1 = Engine[0x19D51F845CA3D3C]("story")
					if string.len(f197_local1) == 0 then
						f197_local1 = LuaUtils.GetDefaultMap(f196_arg1)
					end
					Dvar[0x8D438D99BE5C86F]:set(Engine[0x97AA1D541BB8501]())
					Engine[0x9DB4788AE93C72D](f197_local0, f197_local1)
				else
					local f197_local1 = Dvar[0x8D438D99BE5C86F]:get()
					if f197_local1 == nil or f197_local1 == "" then
						f197_local1 = LuaUtils.GetDefaultMap(f196_arg1)
					end
					Engine[0x9DB4788AE93C72D](f197_local0, f197_local1)
				end
			end
			if f196_arg1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f196_arg1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) then
				Engine[0xB4A27DBBE6D51CF](f197_local0, true)
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f197_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.PlayTogetherBeginPlayWait = function(f198_arg0)
	return {
		name = "PlayTogetherBeginPlayWait",
		controller = f198_arg0,
		startFuncPtr = function(f199_arg0) end,
		pumpFuncPtr = function(f200_arg0, f200_arg1)
			local f200_local0 = Engine[0x9882F293C327557]()
			if f200_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f200_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f200_arg0.actionId,
				})
				return
			elseif Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f200_arg0.controller), "SystemOverlay_MessageDialog.buttonPrompts") ~= nil then
				LobbyVM.ProcessCompleteFailure({
					actionId = f200_arg0.actionId,
				})
			end
		end,
		cancelFuncPtr = function(f201_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f201_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.PlayTogetherPSNSessionWait = function(f202_arg0, f202_arg1)
	return {
		name = "PlayTogetherPSNSessionWait( old session id: " .. f202_arg1 .. ")",
		nonPSNSessionBlocking = true,
		controller = f202_arg0,
		oldSessionId = f202_arg1,
		startFuncPtr = function(f203_arg0) end,
		pumpFuncPtr = function(f204_arg0, f204_arg1)
			if Lobby.Platform.PS4.taskInProgress == true then
				return
			else
				local f204_local0 = Lobby.Platform.PS4GetSessionId(f202_arg0)
				if string.len(f204_local0) > 0 and f204_arg0.oldSessionId ~= f204_local0 then
					LobbyVM.ProcessCompleteSuccess({
						actionId = f204_arg0.actionId,
					})
					return
				else
				end
			end
		end,
		cancelFuncPtr = function(f205_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f205_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ChangeTimerStatus = function(f206_arg0)
	return {
		name = "ChangeTimerStatus",
		status = f206_arg0,
		startFuncPtr = function(f207_arg0)
			Lobby.Timer.SetManualStatusTo(f206_arg0)
			LobbyVM.ProcessCompleteSuccess({
				actionId = f207_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.ForceNotifyGlobalModel = function(f208_arg0)
	return {
		name = "ForceNotifyGlobalModel",
		model = f208_arg0,
		startFuncPtr = function(f209_arg0)
			Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f208_arg0))
			LobbyVM.ProcessCompleteSuccess({
				actionId = f209_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.AsyncMatchmakingWaitTillHostHasAllTokens = function(f210_arg0)
	return {
		name = "AsyncMatchmakingWaitTillHostHasAllTokens",
		waitMilliseconds = f210_arg0,
		checkInterval = 100,
		startFuncPtr = function(f211_arg0)
			f211_arg0.endTime = f211_arg0.waitMilliseconds + Engine[0x9D33D652B9B0F3B]()
			f211_arg0.checkTime = f211_arg0.checkInterval + Engine[0x9D33D652B9B0F3B]()
		end,
		pumpFuncPtr = function(f212_arg0, f212_arg1)
			if f212_arg0.checkTime > Engine[0x9D33D652B9B0F3B]() then
				return
			end
			f212_arg0.checkTime = f212_arg0.checkInterval + Engine[0x9D33D652B9B0F3B]()
			local f212_local0 = false
			local f212_local1 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
			for f212_local5, f212_local6 in ipairs(f212_local1.sessionClients) do
				if f212_local6.asyncMatchmakingToken == LuaDefine.ZERO_X64 then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f212_arg0.name .. ", Client: " .. f212_local6.gamertag .. " XUID: " .. f212_local6.xuidstr .. " didn't have an asyncMatchmakingToken.\n")
					f212_local0 = true
				end
			end
			if f212_local0 == false then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f212_arg0.actionId,
				})
				return
			elseif f212_arg0.endTime < Engine[0x9D33D652B9B0F3B]() then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f212_arg0.name .. ", waited for tokens too long.\n")
				LobbyVM.ProcessCompleteError({
					actionId = f212_arg0.actionId,
				})
				return
			end
		end,
	}
end
Lobby.Actions.WaitForDSPingsToBeDone = function(f213_arg0)
	return {
		name = "WaitForDSPingsToBeDone",
		controller = f213_arg0,
		timeoutTime = Engine[0x9D33D652B9B0F3B]() + 12000,
		startFuncPtr = function(f214_arg0)
			if Dvar[0x458DCD5CEE10FC9]:exists() then
				f214_arg0.timeoutTime = Engine[0x9D33D652B9B0F3B]() + Dvar[0x458DCD5CEE10FC9]:get() * 1000
			end
			local f214_local0 = Lobby.MatchmakingAsync.GetLocalUserInfo(f214_arg0.controller)
			if f214_local0.completedDCQoS == true then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f214_arg0.actionId,
				})
			end
		end,
		pumpFuncPtr = function(f215_arg0, f215_arg1)
			local f215_local0 = Lobby.MatchmakingAsync.GetLocalUserInfo(f215_arg0.controller)
			if f215_local0.completedDCQoS == true then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f215_arg0.actionId,
				})
			end
			if f215_arg0.timeoutTime < Engine[0x9D33D652B9B0F3B]() then
				LobbyVM.ProcessCompleteFailure({
					actionId = f215_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.AsyncMatchmakingStartSearch = function(f216_arg0, f216_arg1, f216_arg2)
	return {
		name = "AsyncMatchmakingStartSearch",
		controller = Engine[0xA5B9C0111291A8B](),
		timeout = f216_arg1,
		presenceJoinInfo = f216_arg2,
		msgOverride = 0x0,
		errorDebugMsg = "Unknown Error",
		startFuncPtr = function(f217_arg0)
			local f217_local0 = nil
			if f217_arg0.presenceJoinInfo ~= nil and f217_arg0.presenceJoinInfo.probeResult.probedXuid ~= nil then
				f217_local0 = f217_arg0.presenceJoinInfo.probeResult.probedXuid
			end
			Lobby.MatchmakingAsync.EmptyEventQueue()
			local f217_local1 = Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog
			local f217_local2 = Lobby.MatchmakingAsync.GetLocalUserInfo(f217_arg0.controller)
			f217_local1[0x48ADCCF3C622ADC] = f217_local2.xuid
			f217_local1 = Lobby.MatchmakingAsync.PartyToMatchSummary
			f217_local2 = Lobby.MatchmakingAsync.GetLocalUserInfo(f217_arg0.controller)
			f217_local1[0x48ADCCF3C622ADC] = f217_local2.xuid
			f217_local1, f217_local2 = Lobby.JSON.CreateStartSearchParamDoc(f217_local0)
			if f217_local1 == nil then
				LobbyVM.ProcessCompleteError({
					actionId = f217_arg0.actionId,
				})
				return
			end
			Lobby.MMAsync.lastUpdateTime = Engine[0x9D33D652B9B0F3B]()
			f217_arg0.xuidList = f217_local2
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.Actions.AsyncMatchmakingStartSearch(start): LobbyMatchmakingStartMatchMaking( asyncMatchmakingStartDoc )" .. "\n asyncMatchmakingStartDoc: " .. f217_local1 .. "\n")
			if Engine[0x6963F87F5AF8293](f217_arg0.actionId, f217_arg0.controller, f217_arg0.timeout, f217_local1 .. " ") == false then
				LobbyVM.ProcessCompleteError({
					actionId = f217_arg0.actionId,
				})
				if Dvar[0x102D263505BECD9]:get() then
					Lobby.Debug.SessionSQJLogBDEvent({
						message = "AsyncMatchmakingStartSearch: FAILED",
					})
				end
				return
			elseif Dvar[0x102D263505BECD9]:get() then
				Lobby.Debug.SessionSQJLogBDEvent({
					message = "AsyncMatchmakingStartSearch: STARTED",
				})
			end
			local f217_local3 = Engine[0x786FFC9E621CAB7]()
			Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[0x6A1B6D783AA7A25] = f217_local3
			Lobby.MatchmakingAsync.PartyToMatchSummary.last_sent_timestamp = f217_local3
		end,
		endFuncPtr = function(f218_arg0)
			if f218_arg0.retData ~= nil and f218_arg0.retData.startMatchMaking ~= nil then
				Lobby.MatchmakingAsync.AsyncMatchmakingRunning(true)
				local f218_local0 = Lobby.JSON.ParseAsyncMatchmakingStartDoc(f218_arg0.retData.startMatchMaking)
				if f218_local0.estimatedWaitTime ~= nil then
					Lobby.Matchmaking.PublicLobby.estimatedTime = f218_local0.estimatedWaitTime
				end
				Lobby.MMAsync.Info.matchmakingID = f218_local0.mm_id
				Lobby.MatchmakingAsync.AddSearch()
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.Actions.AsyncMatchmakingStart(complete) \n")
				if Dvar[0x102D263505BECD9]:get() then
					Lobby.Debug.SessionSQJLogBDEvent({
						message = string.format("AsyncMatchmakingStartSearch: COMPLETE, MMID: %s", Engine[0x4C599F1694E23EF](f218_local0.mm_id)),
					})
				end
			elseif f218_arg0.retData ~= nil and f218_arg0.retData.errorCode == Lobby.MatchmakingAsync.ErrorCodes.BD_AMM_BACKOFF_REQUESTED then
				f218_arg0.errorDebugMsg = "Back Off requested"
				f218_arg0.msgOverride = 0xCB0D4A1DA707592
			end
		end,
		cancelFuncPtr = function(f219_arg0)
			local f219_local0 = 12345
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f219_arg0.name .. ", Interupted so Canceling search \n")
			Engine[0x10EF551A4AE56C2]()
			if Engine[0xC3DAFC9624723BB](Engine[0xA5B9C0111291A8B](), Enum[0x253E52758902088][0xFEBF576B1308210]) == false then
				Lobby.MatchmakingAsync.AsyncMatchmakingRunning(false)
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f219_arg0.name .. ", started Cancel task \n")
				local f219_local1 = Lobby.ProcessQueue.RegisterEventHandler(function()
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyMatchmakingCancelMatchMaking done!\n")
				end, nil)
				if Engine[0x948895AE79A45AD](f219_local1, Engine[0xA5B9C0111291A8B](), 0, f219_local0) == false then
					Lobby.ProcessQueue.UnRegisterEventHandler(f219_local1)
				end
			end
			Lobby.MatchmakingAsync.EmptyEventQueue()
			LobbyVM.ProcessCompleteSuccess({
				actionId = f219_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.CaptureStartSearchErrorAndAct = function(f221_arg0)
	return {
		name = "CaptureStartSearchErrorAndAct",
		startSearchAction = f221_arg0,
		startFuncPtr = function(f222_arg0) end,
		pumpFuncPtr = function(f223_arg0, f223_arg1)
			if f223_arg0.startSearchAction.retData ~= nil and f223_arg0.startSearchAction.retData.errorCode == Lobby.MatchmakingAsync.ErrorCodes.BD_AMM_BACKOFF_REQUESTED then
				if Engine[0x56B4618D857143D]() then
				else
				end
				LobbyVM.ProcessCompleteError({
					actionId = f223_arg0.actionId,
				})
				return
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f223_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.AsyncMatchmakingCancel = function(f224_arg0, f224_arg1, f224_arg2)
	return {
		name = "AsyncMatchmakingCancel",
		controller = f224_arg0,
		timeout = f224_arg1,
		tableWithMatchmakingID = f224_arg2,
		startFuncPtr = function(f225_arg0)
			local f225_local0 = nil
			if f225_arg0.tableWithMatchmakingID ~= nil and f225_arg0.tableWithMatchmakingID.matchmakingID then
				f225_local0 = f225_arg0.tableWithMatchmakingID.matchmakingID
			end
			Lobby.MatchmakingAsync.EmptyEventQueue()
			if Lobby.MatchmakingAsync.IsAsyncMatchmakingRunning() == false or f225_local0 == nil then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f225_arg0.actionId,
				})
				Lobby.MatchmakingAsync.MatchmakingSearchSummaryLogSendDLogEvent(Lobby.MatchmakingAsync.LeaveReason.CLIENT_CANCEL)
				if f225_local0 ~= nil then
					local f225_local1 = Lobby.MatchmakingAsync.PartyToMatchSummary[0xED6FB1B5DCCC095][tostring(f225_local0)]
					if f225_local1 ~= nil then
						f225_local1[0xA14A466674314B6] = Lobby.MatchmakingAsync.SearchOutcome.SEARCH_CANCEL
						f225_local1[0x3088D1189C30C01] = Engine[0x786FFC9E621CAB7]()
					end
				end
				if nil ~= Lobby.MatchmakingAsync.LobbyIntermissionSummary then
					if Lobby.MatchmakingAsync.LobbyMembersTelemetry[0x2623BA80A26AD5A] > 1 then
						Lobby.MatchmakingAsync.HardResetIntermissionSummary()
					else
						Lobby.MatchmakingAsync.LobbyIntermissionSummarySendDLogEvent({
							reasonIntermissionEnded = Lobby.MatchmakingAsync.ReasonIntermissionEnded.LOBBY_DISBANDED,
						})
					end
				end
				return
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f225_arg0.name .. ", Canceling Matchmaking ID: " .. tostring(f225_local0) .. "\n")
			if Engine[0xC3DAFC9624723BB](f225_arg0.controller, Enum[0x253E52758902088][0xFEBF576B1308210]) == false then
				if Engine[0x948895AE79A45AD](f225_arg0.actionId, f225_arg0.controller, f225_arg0.timeout, f225_local0) == false then
					LobbyVM.ProcessCompleteError({
						actionId = f225_arg0.actionId,
					})
				end
			else
				LobbyVM.ProcessCompleteSuccess({
					actionId = f225_arg0.actionId,
				})
			end
		end,
		endFuncPtr = function(f226_arg0)
			if f226_arg0.retData ~= nil and f226_arg0.retData.cancelMatchMaking ~= nil then
				f226_arg0.cancelMatchMaking = f226_arg0.retData.cancelMatchMaking
				if f226_arg0.cancelMatchMaking == true then
					Lobby.MatchmakingAsync.AsyncMatchmakingRunning(false)
				end
			end
		end,
	}
end
Lobby.Actions.AsyncMatchmakingDisbandLobby = function(f227_arg0, f227_arg1, f227_arg2)
	return {
		name = "AsyncMatchmakingDisbandLobby",
		controller = f227_arg0,
		timeout = f227_arg1,
		lobbyID = f227_arg2,
		startFuncPtr = function(f228_arg0)
			if f228_arg0.lobbyID == nil then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f228_arg0.actionId,
				})
				return
			end
			Lobby.MatchmakingAsync.EmptyEventQueue()
			Lobby.MatchmakingAsync.ClearCacheAsyncInfo()
			if Engine[0xF3E87C8D384C2E3](f228_arg0.actionId, f228_arg0.controller, f228_arg0.timeout, f228_arg0.lobbyID) == false then
				LobbyVM.ProcessCompleteError({
					actionId = f228_arg0.actionId,
				})
			else
				Lobby.MatchmakingAsync.MatchmakingSearchSummaryLogSendDLogEvent(Lobby.MatchmakingAsync.LeaveReason.LOBBY_DISBANDED)
			end
		end,
		endFuncPtr = function(f229_arg0) end,
	}
end
Lobby.Actions.AsyncMatchmakingWaitToComplete = function(f230_arg0)
	return {
		name = "AsyncMatchmakingWaitToComplete",
		eventsEnabled = true,
		actionWithXuidList = f230_arg0,
		checkInterval = 20,
		lobbyNotFoundCauseErrorCount = 0,
		errorDebugMsg = "Unknown Error",
		updateInterval = 10000,
		updateTime = 0,
		updateMessage = 0,
		msgOverride = 0x0,
		msgOverrideTitle = 0x0,
		failAndRestart = function(f231_arg0)
			f231_arg0.actionWithXuidList.xuidList = nil
			f231_arg0.msgOverride = 0x8E8D699F2706C4C
			LobbyVM.ProcessCompleteFailure({
				actionId = f231_arg0.actionId,
			})
			return nil
		end,
		startFuncPtr = function(f232_arg0)
			f232_arg0.checkTime = f232_arg0.checkInterval + Engine[0x9D33D652B9B0F3B]()
			Lobby.MMAsync.lastUpdateTime = Engine[0x9D33D652B9B0F3B]()
			f232_arg0.updateTime = f232_arg0.updateInterval + Engine[0x9D33D652B9B0F3B]()
		end,
		pumpFuncPtr = function(f233_arg0, f233_arg1)
			if f233_arg0.checkTime > Engine[0x9D33D652B9B0F3B]() then
				return
			elseif f233_arg0.actionWithXuidList == nil or f233_arg0.actionWithXuidList.xuidList == nil then
				return
			elseif #f233_arg0.actionWithXuidList.xuidList ~= Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F]) then
				return f233_arg0:failAndRestart()
			end
			local f233_local0 = Lobby.MatchmakingAsync.EventQueuePeek()
			if f233_local0 ~= nil then
				f233_arg0:checkEvent(f233_local0)
			end
			if LuaUtils.IsArenaMode() and Lobby.Arena.EventHasEnded() then
				f233_arg0.errorOverlay = "ArenaEventDone"
				LobbyVM.ProcessCompleteError({
					actionId = f233_arg0.actionId,
				})
				return
			end
			local f233_local1 = LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_2_DESCRIPTION_1
			if f233_arg0.updateTime < Engine[0x9D33D652B9B0F3B]() then
				if f233_arg0.updateMessage == 0 then
					f233_arg0.updateTime = Engine[0x9D33D652B9B0F3B]() + 1000
					f233_arg0.updateMessage = 1
					f233_local1 = LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_2_DESCRIPTION_3
				else
					f233_arg0.updateTime = Engine[0x9D33D652B9B0F3B]() + f233_arg0.updateInterval
					f233_arg0.updateMessage = 0
				end
				Lobby.Matchmaking.UpdateSearchStatus(Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_2, f233_local1)
			end
		end,
		checkEvent = function(f234_arg0, f234_arg1)
			local f234_local0 = f234_arg1.eventType
			if f234_arg1.matchMakingID ~= Lobby.MMAsync.Info.matchmakingID then
				Lobby.MatchmakingAsync.EventQueuePop()
				return
			elseif f234_local0 == LuaEnum.bdEventType.BD_JOIN_LOBBY then
				if f234_arg0.actionWithXuidList.presenceJoinInfo ~= nil and f234_arg0.actionWithXuidList.presenceJoinInfo.probeResult.probedXuid ~= nil then
					f234_arg1.joinPrivateXUID = f234_arg0.actionWithXuidList.presenceJoinInfo.probeResult.probedXuid
					Lobby.MatchmakingAsync.EventQueueOverwriteTop(f234_arg1)
				end
				LobbyVM.ProcessCompleteSuccess({
					actionId = f234_arg0.actionId,
				})
			elseif f234_local0 == LuaEnum.bdEventType.BD_CREATE_NEW_LOBBY then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f234_arg0.actionId,
				})
			elseif f234_local0 == LuaEnum.bdEventType.BD_LOBBY_NOT_FOUND then
				local f234_local1 = f234_arg1.controller
				local f234_local2 = f234_arg1.matchMakingID
				local f234_local3 = f234_arg1.lobbyNotFoundCause
				f234_arg0.lobbyNotFoundCause = f234_local3
				if f234_arg0.lobbyNotFoundCauseErrorCount > 0 then
					return LobbyVM.ProcessCompleteError({
						actionId = f234_arg0.actionId,
					})
				end
				f234_arg0.lobbyNotFoundCauseErrorCount = f234_arg0.lobbyNotFoundCauseErrorCount + 1
				f234_arg0.msgOverrideTitle = 0xF43B66193E8983D
				if f234_local3 == LuaEnum.LobbyNotFoundCause.BD_ILLEGAL_MAP_PACK then
					f234_arg0.errorDebugMsg = LuaEnum.LobbyNotFoundCauseString[f234_local3]
					f234_arg0.msgOverride = 0x609344F0F879051
					return LobbyVM.ProcessCompleteFailure({
						actionId = f234_arg0.actionId,
					})
				elseif f234_local3 <= LuaEnum.LobbyNotFoundCause.BD_LAST then
					f234_arg0.errorDebugMsg = LuaEnum.LobbyNotFoundCauseString[f234_local3]
					return LobbyVM.ProcessCompleteFailure({
						actionId = f234_arg0.actionId,
					})
				end
				f234_arg0.errorDebugMsg = "Unknown Error!!!!!"
				LobbyVM.ProcessCompleteError({
					actionId = f234_arg0.actionId,
				})
			end
		end,
		cancelFuncPtr = function(f235_arg0)
			local f235_local0 = Lobby.MMAsync.Info.matchmakingID
			Lobby.MMAsync.Info.matchmakingID = 0
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f235_arg0.name .. ", Interupted so Canceling search \n")
			Lobby.MatchmakingAsync.EmptyEventQueue()
			if Engine[0xC3DAFC9624723BB](Engine[0xA5B9C0111291A8B](), Enum[0x253E52758902088][0xFEBF576B1308210]) == false then
				Lobby.MatchmakingAsync.AsyncMatchmakingRunning(false)
				local f235_local1 = Lobby.ProcessQueue.RegisterEventHandler(function()
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyMatchmakingCancelMatchMaking done!\n")
				end, nil)
				if Engine[0x948895AE79A45AD](f235_local1, Engine[0xA5B9C0111291A8B](), 0, f235_local0) == false then
					Lobby.ProcessQueue.UnRegisterEventHandler(f235_local1)
				end
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f235_arg0.actionId,
			})
		end,
		errorFuncPtr = function(f237_arg0)
			local f237_local0 = 0xA26AA910A2D8FD8
			if f237_arg0.msgOverride ~= 0x0 then
				f237_local0 = f237_arg0.msgOverride
			end
			if not Engine[0x2DA54CF5D6B7F02]() then
				return f237_local0
			else
				return Engine[0xF9F1239CFD921FE](f237_local0) .. "\n\nDEBUG INFO: Matchmaker Error( " .. f237_arg0.errorDebugMsg .. " )\n"
			end
		end,
	}
end
Lobby.Interrupt.AsyncMatchmakingErrorMsg = function(f238_arg0, f238_arg1, f238_arg2, f238_arg3)
	return {
		isInterrupt = true,
		name = "InterruptErrorMsg",
		interruptFuncPtr = f238_arg0,
		params = f238_arg1,
		errorMsg = f238_arg2,
		erroredAction = f238_arg3,
		errorOverlay = nil,
		interruptType = Lobby.Interrupt.ERROR_MSG,
		createFuncPtr = function(f239_arg0, f239_arg1)
			local f239_local0 = nil
			if f239_arg0.erroredAction ~= nil then
				if Engine[0x2DA54CF5D6B7F02]() then
					local f239_local1 = "Unknown Error"
					if f239_arg0.erroredAction.errorDebugMsg ~= nil then
						f239_local1 = f239_arg0.erroredAction.errorDebugMsg
					end
					f239_arg0.errorMsg = f239_arg0.errorMsg .. "\n\nDEBUG: " .. f239_local1
				end
				if f239_arg0.erroredAction.msgOverride ~= nil and f239_arg0.erroredAction.msgOverride ~= 0x0 then
					f239_arg0.errorMsg = Engine[0xF9F1239CFD921FE](f239_arg0.erroredAction.msgOverride)
				end
				if f239_arg0.erroredAction.msgOverrideTitle ~= nil and f239_arg0.erroredAction.msgOverrideTitle ~= 0x0 then
					f239_local0 = Engine[0xF9F1239CFD921FE](f239_arg0.erroredAction.msgOverrideTitle)
				end
				if f239_arg0.erroredAction.errorOverlay ~= nil then
					f239_arg0.errorOverlay = f239_arg0.erroredAction.errorOverlay
					f239_arg0.interruptType = Lobby.Interrupt.ERROR_OVERLAY
				end
			end
			return f239_arg0.interruptFuncPtr(f239_arg0.interruptType, f239_arg0.params, {
				action = f239_arg1,
				errorMsg = f239_arg0.errorMsg,
				errorTitle = f239_local0,
				errorOverlay = f239_arg0.errorOverlay,
			}, f239_arg0.erroredAction)
		end,
	}
end
Lobby.Actions.SyncLobbyHostDoc = function(f240_arg0, f240_arg1, f240_arg2, f240_arg3)
	return {
		name = "SyncLobbyHostDoc",
		controller = f240_arg0,
		timeout = f240_arg1,
		matchmakerInfo = f240_arg2,
		forceSync = f240_arg3,
		startFuncPtr = function(f241_arg0)
			local f241_local0 = f241_arg0.matchmakerInfo.lobbyID
			local f241_local1 = f241_arg0.matchmakerInfo.lobbyBackendDocTable
			local f241_local2 = f241_arg0.matchmakerInfo.lobbyHostDocTable
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.Actions.SyncLobbyHostDoc():\n")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "controller: " .. tostring(f241_arg0.controller) .. "\n")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "lobbyID: " .. Engine[0x4C599F1694E23EF](f241_local0) .. "\n")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "updateID: " .. Engine[0x4C599F1694E23EF](f241_local1.update_id) .. "\n")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "lobbyHostDoc: " .. f241_local2.lobbyDoc .. "\n")
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "lobbyBackendDoc: " .. f241_local1.lobbyDoc .. "\n")
			local f241_local3 = Lobby.MatchmakingAsync.SyncHostDocs(nil, f241_arg0.controller, f241_arg0.timeout, f241_local0, f241_local1.update_id, f241_local2.lobbyDoc, f241_arg0.actionId)
			if Dvar[0x102D263505BECD9]:get() then
				Lobby.Debug.SessionSQJLogBDEvent({
					message = string.format("SyncLobbyHostDoc: LobbyID: %s, UpdateID: %s", Engine[0x4C599F1694E23EF](f241_local0), Engine[0x4C599F1694E23EF](f241_local1.update_id)),
				})
			end
			if f241_local3 == false then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.Actions.SyncLobbyHostDoc(): LobbyMatchmakingSyncLobbyDocuments failed.\n")
				LobbyVM.ProcessCompleteError({
					actionId = f241_arg0.actionId,
				})
			end
		end,
		endFuncPtr = function(f242_arg0)
			Lobby.Matchmaking.UpdateSearchStatus(Enum[0xBF54BE1BB3D618B][0xA1647599284110], LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
		end,
	}
end
Lobby.Actions.CheckLobbySessionStatus = function(f243_arg0, f243_arg1, f243_arg2)
	return {
		name = "CheckLobbySessionStatus",
		lobbyType = f243_arg0,
		sessionStatus = f243_arg1,
		infoProbe = f243_arg2,
		startFuncPtr = function(f244_arg0)
			if f244_arg0.infoProbe == nil or f244_arg0.infoProbe.probeResult == nil then
				LobbyVM.ProcessCompleteError({
					actionId = f244_arg0.actionId,
				})
				return
			end
			local f244_local0 = f244_arg0.infoProbe.probeResult
			local f244_local1 = nil
			if f244_arg0.lobbyType == Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
				f244_local1 = f244_local0.privateLobby
			elseif f244_arg0.lobbyType == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
				f244_local1 = f244_local0.gameLobby
			else
				LobbyVM.ProcessCompleteError({
					actionId = f244_arg0.actionId,
				})
				return
			end
			if f244_local1 == nil or f244_local1.status == nil then
				LobbyVM.ProcessCompleteError({
					actionId = f244_arg0.actionId,
				})
				return
			elseif f244_local0.privateLobby.status == f244_arg0.sessionStatus then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f244_arg0.actionId,
				})
				return
			end
			LobbyVM.ProcessCompleteFailure({
				actionId = f244_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.AsyncMatchmakingJoinCheck = function(f245_arg0)
	return {
		name = "AsyncMatchmakingJoinCheck",
		infoProbe = f245_arg0,
		xuid = LuaDefine.INVALID_XUID_X64,
		startFuncPtr = function(f246_arg0)
			local f246_local0 = f246_arg0.infoProbe.probeResult
			if f246_local0.gameLobby.isValid == true then
				if f246_local0.uiScreen == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f246_local0.uiScreen == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) or f246_local0.uiScreen == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING) then
					f246_arg0.xuid = f246_arg0.infoProbe.probeResult.probedXuid
					LobbyVM.ProcessCompleteSuccess({
						actionId = f246_arg0.actionId,
					})
				elseif f246_local0.uiScreen == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
					if Dvar[0xD6B7833ECC9D286]:exists() then
						f246_arg0.xuid = f246_arg0.infoProbe.probeResult.probedXuid
						LobbyVM.ProcessCompleteSuccess({
							actionId = f246_arg0.actionId,
						})
					else
						LobbyVM.ProcessCompleteFailure({
							actionId = f246_arg0.actionId,
						})
					end
				elseif f246_local0.uiScreen == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
					LobbyVM.ProcessCompleteError({
						actionId = f246_arg0.actionId,
					})
				else
					LobbyVM.ProcessCompleteError({
						actionId = f246_arg0.actionId,
					})
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA1C4971DA015C84], "Lobby.Actions.AsyncMatchmakingJoinCheck unknown game lobby ID: " .. tostring(f246_local0.uiScreen) .. "\n")
				end
			else
				LobbyVM.ProcessCompleteFailure({
					actionId = f246_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.AsyncMatchmakingJoin = function(f247_arg0, f247_arg1)
	return {
		name = "AsyncMatchmakingJoin",
		controller = f247_arg0.controller,
		hostAddress = f247_arg0.hostAddress.serializedAdr,
		secId = f247_arg0.secIdKey.secId,
		secKey = f247_arg0.secIdKey.secKey,
		lobbyHostXuid = f247_arg0.lobbyHostXuid,
		hostName = f247_arg0.hostName,
		toTarget = f247_arg1,
		joinResults = {},
		startFuncPtr = function(f248_arg0)
			Engine[0xBDB9B9ECAA1F594](f248_arg0.actionId, f248_arg0.controller, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]), f248_arg0.toTarget[0xBF54BE1BB3D618B])
			Engine[0xB5660669F1C418B](f248_arg0.hostName, f248_arg0.lobbyHostXuid, f248_arg0.secId, f248_arg0.secKey, f248_arg0.hostAddress, false, false)
			Engine[0x2CDB8071B68C0E1]()
		end,
		updateFuncPtr = function(f249_arg0, f249_arg1)
			f249_arg0.joinResults[#f249_arg0.joinResults + 1] = f249_arg1
			Lobby.Debug.SessionSQJJoinResult(f249_arg1)
		end,
		errorFuncPtr = function(f250_arg0)
			local f250_local0 = Engine[0xF9F1239CFD921FE](0xA26AA910A2D8FD8)
			if #f250_arg0.joinResults == 0 then
				return f250_local0
			end
			local f250_local1 = f250_arg0.joinResults[#f250_arg0.joinResults].joinResult
			local f250_local2, f250_local3 = Lobby.Join.JoinResultToString(f250_local1, true)
			if f250_local3 then
				local f250_local4 = 0x0
				if f250_local1 == Enum[0x2E4144AA1C3ABB8][0x190D2DCFDB65D5] then
					f250_local4 = 0x55D96CC762EABDD
				elseif f250_local1 == Enum[0x2E4144AA1C3ABB8][0xFD8202DCFA3EF29] then
					f250_local4 = 0xB06081B8B4567F2
				end
				f250_local0 = Engine[0xF9F1239CFD921FE](f250_local2.errorMsg, f250_arg0.hostName, f250_local4)
			else
				f250_local0 = Engine[0xF9F1239CFD921FE](f250_local2.errorMsg)
			end
			if not Engine[0x2DA54CF5D6B7F02]() then
				return f250_local0
			end
			return f250_local0 .. "\n\nDEBUG INFO: JoinResult( " .. tostring(f250_local1) .. " )\n" .. f250_local2.debug
		end,
		endFuncPtr = function(f251_arg0)
			Lobby.Matchmaking.UpdateSearchStatus(Enum[0xBF54BE1BB3D618B][0xA1647599284110], LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
			Engine[0xA6B364A77D75A61]()
		end,
		cancelFuncPtr = function(f252_arg0)
			Engine[0xA6B364A77D75A61]()
			LobbyVM.ProcessCompleteSuccess({
				actionId = f252_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.RegisterDedicatedServerInContext = function(f253_arg0, f253_arg1, f253_arg2, f253_arg3)
	return {
		name = "RegisterDedicatedServerInContext",
		controller = f253_arg0,
		timeout = f253_arg1,
		secIdKey = f253_arg2,
		registrationTimeout = f253_arg3,
		waitingForTask = false,
		startFuncPtr = function(f254_arg0) end,
		pumpFuncPtr = function(f255_arg0, f255_arg1)
			local f255_local0 = Engine[0xAA253936E744305]()
			if f255_local0.valid == false or f255_arg0.waitingForTask == true then
				return
			end
			f255_arg0.waitingForTask = true
			local f255_local1 = Dvar[0x865091C89C1F37C]:get()
			local f255_local2 = ""
			local f255_local3 = Dvar[0x75A9B5FFE98CD02]:get()
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "LobbyAction: " .. f255_arg0.name .. ", Registering Dedicated in data center [" .. f255_local1 .. "] Context '" .. f255_local3 .. "'.\n")
			if Engine[0x52655E85F23B1FC](f255_arg0.actionId, f255_arg0.controller, f255_arg0.timeout, Lobby.MatchmakingAsync.GetFullBuildName(), f255_local1, f255_local0.serializedAdr, f255_arg0.secIdKey.secId, f255_arg0.secIdKey.secKey, f255_arg0.registrationTimeout, f255_local2, f255_local3) == false then
				LobbyVM.ProcessCompleteError({
					actionId = f255_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.WaitTillBDNetIsDone = function()
	return {
		name = "WaitTillBDNetIsDone",
		startFuncPtr = function(f257_arg0)
			if Engine[0x34FF60D3B0DE387]() == Enum[0x476B2E7504B0B41][0xF53677B848C2438] then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f257_arg0.actionId,
				})
			end
		end,
		pumpFuncPtr = function(f258_arg0, f258_arg1)
			if Engine[0x34FF60D3B0DE387]() == Enum[0x476B2E7504B0B41][0xF53677B848C2438] then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f258_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.WaitTillXSRestIsDone = function(f259_arg0)
	return {
		name = "WaitTillXSRestIsDone",
		timeoutTime = Engine[0x9D33D652B9B0F3B]() + f259_arg0,
		startFuncPtr = function(f260_arg0)
			if not Lobby.Platform.PlatformSessionDurangoS2SBusy() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f260_arg0.actionId,
				})
			end
		end,
		pumpFuncPtr = function(f261_arg0, f261_arg1)
			if not Lobby.Platform.PlatformSessionDurangoS2SBusy() or f261_arg0.timeoutTime < Engine[0x9D33D652B9B0F3B]() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f261_arg0.actionId,
				})
			end
		end,
	}
end
Lobby.Actions.DirectTelemetryStart = function(f262_arg0, f262_arg1)
	return {
		name = "DirectTelemetryStart",
		controller = f262_arg0,
		toTarget = f262_arg1,
		startFuncPtr = function(f263_arg0)
			if f263_arg0.toTarget[0xBDB8620451D6112] == Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
				Engine[0x7778612F9CB9B0D]()
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f263_arg0.actionId,
			})
		end,
	}
end
Lobby.Actions.OpenMOTD = function(f264_arg0)
	return {
		name = "OpenMOTD",
		controller = f264_arg0,
		startFuncPtr = function(f265_arg0)
			if not Dvar[0x4FF2012C26D8FB]:get() then
				LobbyVM.ProcessCompleteSuccess({
					actionId = f265_arg0.actionId,
				})
				return
			elseif Dvar[0x61B37B5CD0C5CC1]:get() then
				LobbyVM.ExecuteLobbyVMCreateOverlay(f264_arg0, "MOTD")
				LobbyVM.ProcessCompleteSuccess({
					actionId = f265_arg0.actionId,
				})
				return
			elseif Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.motdOpened") == nil then
				local f265_local0 = Engine[0xD30724405ED0D69](CoD.MOTDUtility.MOTD_GetMOTDChannel())
				for f265_local1 = 1, f265_local0, 1 do
					local f265_local4 = Engine[0x5451F941503DA5A](f264_arg0, CoD.MOTDUtility.MOTD_GetMOTDChannel(), f265_local1 - 1)
					if f265_local4 ~= nil and f265_local4.messageID > 0 and Engine[0xCF9DD4167E9CE89](f265_local4.locationID) and (CoDShared.IsERegEnabled(f264_arg0) or f265_local4.action == nil or f265_local4.action ~= "registration") then
						LobbyVM.ExecuteLobbyVMCreateOverlay(f264_arg0, "MOTD")
						LobbyVM.ProcessCompleteSuccess({
							actionId = f265_arg0.actionId,
						})
						return
					end
				end
			end
			LobbyVM.ProcessCompleteSuccess({
				actionId = f265_arg0.actionId,
			})
		end,
	}
end
