require("x64:b5d5f7ffe97a9a7")
if not CoD.OverlayUtility then
	CoD.OverlayUtility = {}
end
CoD.OverlayUtility.OpenMethods = LuaEnum.createEnum("Popup", "Overlay")
CoD.OverlayUtility.OverlayTypes = LuaEnum.createEnum("GenericMessage", "Connection", "Settings", "Unlock", "Save", "Quit", "Alert", "Error", "Info", "Notice", "CODPoints", "CustomGames")
CoD.OverlayUtility.GenericPopupSizes = LuaEnum.createEnum("Small", "Large")
CoD.OverlayUtility.LOCAL_FILES_FETCH_WAIT_TIME = 20000
CoD.OverlayUtility.callFnOrGetValue = function(f1_arg0, f1_arg1)
	if type(f1_arg0) == "function" then
		return f1_arg0(unpack(f1_arg1))
	else
		return f1_arg0
	end
end
CoD.OverlayUtility.aCrossPromptFn = "aCrossFn"
CoD.OverlayUtility.aCrossPromptText = "aCrossPrompt"
CoD.OverlayUtility.bCirclePromptFn = "bCircleFn"
CoD.OverlayUtility.bCirclePromptText = "bCirclePrompt"
CoD.OverlayUtility.xSquarePromptFn = "xSquareFn"
CoD.OverlayUtility.xSquarePromptText = "xSquarePrompt"
CoD.OverlayUtility.yTrianglePromptFn = "yTriangleFn"
CoD.OverlayUtility.yTrianglePromptText = "yTrianglePrompt"
CoD.OverlayUtility.OverlayModelFields = {
	"title",
	"image",
	"description",
	"supportText",
	"categoryType",
	"listDatasource",
	"frameWidget",
	"state",
	"cryptoKeyType.rarity",
	"cost",
	"codpointcost",
	"codpointcostString",
	"totalDuplicates",
	"commonDuplicates",
	"rareDuplicates",
	"legendaryDuplicates",
	"epicDuplicates",
	"vials",
	"variantName",
	"weaponName",
	"inputText",
	"backgroundId",
	"xuid",
	"gamertag",
	"clantag",
	"emblemBacking",
	"fractionText",
	"progressPercentage",
	"rewardText",
	"emblem",
	"iconId",
	"subtitle",
	"prestigeItemName",
	"prestigeLayout",
	"weaponName",
	"weaponImage",
	"weaponPrestigeReward",
	"weaponPrestigeRewardPreview",
	"weaponPrestigeRewardIcon",
	"weaponPrestigeLevel",
	"groupName",
	"groupId",
}
CoD.OverlayUtility.GoBackPropertyName = "backButtonFn"
CoD.OverlayUtility.ContinuePropertyName = "continueButtonFn"
CoD.OverlayUtility.ProcessActionPropertyName = "actionButtonFn"
CoD.OverlayUtility.ProcessActionKeyboardComplete = "keyboardCompleteFn"
CoD.OverlayUtility.OverlayPropertyFields = {
	CoD.OverlayUtility.GoBackPropertyName,
	CoD.OverlayUtility.ContinuePropertyName,
	CoD.OverlayUtility.ProcessActionPropertyName,
	CoD.OverlayUtility.ProcessActionKeyboardComplete,
	CoD.OverlayUtility.aCrossPromptFn,
	CoD.OverlayUtility.bCirclePromptFn,
	CoD.OverlayUtility.xSquarePromptFn,
	CoD.OverlayUtility.yTrianglePromptFn,
}
CoD.OverlayUtility.ButtonPromptsFields = {
	[Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F]] = CoD.OverlayUtility.aCrossPromptText,
	[Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A]] = CoD.OverlayUtility.bCirclePromptText,
	[Enum[0x3DD78803F918E9D][0xC083113BC81F23F]] = CoD.OverlayUtility.xSquarePromptText,
	[Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09]] = CoD.OverlayUtility.yTrianglePromptText,
}
CoD.OverlayUtility.DefaultModelFields = {
	image = function(f2_arg0, f2_arg1)
		local f2_local0 = CoD.OverlayUtility.callFnOrGetValue(f2_arg0.categoryType, f2_arg1)
		if f2_local0 == CoD.OverlayUtility.OverlayTypes.Connection then
			return "t7_icon_connect_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Error then
			return "t7_icon_error_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Quit then
			return "t7_icon_quit_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Unlock then
			return "t7_icon_unlock_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Save then
			return "t7_icon_save_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Settings then
			return "t7_icon_options_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Info or f2_local0 == CoD.OverlayUtility.OverlayTypes.GenericMessage then
			return "t7_icon_info_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.Notice then
			return "t7_icon_notice_overlays_bkg"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.CODPoints then
			return "uie_t7_menu_blackmarket_codpoints_large"
		elseif f2_local0 == CoD.OverlayUtility.OverlayTypes.CustomGames then
			return "t7_icon_options_overlays_bkg"
		else
			return "blacktransparent"
		end
	end,
	frameWidget = function(f3_arg0, f3_arg1)
		local f3_local0 = CoD.OverlayUtility.callFnOrGetValue(f3_arg0.menuName, f3_arg1)
		if f3_local0 == "SystemOverlay_Compact" or f3_local0 == "SystemOverlay_NoBG" then
			return "CoD.systemOverlay_Compact_BasicFrame"
		elseif f3_local0 == "SystemOverlay_Full" then
			return "CoD.systemOverlay_Full_BasicFrame"
		elseif f3_local0 == "SystemOverlay_FreeCursor" or f3_local0 == "SystemOverlay_MessageDialog" then
			return "CoD.systemOverlay_FreeCursor_BasicFrame"
		elseif f3_local0 == "SystemOverlay_FreeCursor_Full" or f3_local0 == "SystemOverlay_MessageDialogFull" then
			return "CoD.systemOverlay_FreeCursor_Full_BasicFrame"
		else
		end
	end,
}
CoD.OverlayUtility.DefaultPropertyFields = {}
CoD.OverlayUtility.DefaultGoBack = function()
	return function(f5_arg0, f5_arg1)
		GoBack(f5_arg0, f5_arg1)
	end
end
CoD.OverlayUtility.DefaultButtonAction = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	GoBack(f6_arg4, f6_arg2)
end
CoD.OverlayUtility.QueueGoBack = function()
	return function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		Engine[0x4ED0477E4FACDCF](f8_arg2)
		GoBack(f8_arg3, f8_arg2)
	end
end
CoD.OverlayUtility.DefaultScriptDialogGoBack = function(f9_arg0)
	return function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		SendMenuResponse(f10_arg3, f9_arg0, "close", f10_arg2)
		Engine[0x10BF7D7C03EECE6](f10_arg2, false)
		Close(f10_arg3, f10_arg2)
	end
end
CoD.OverlayUtility.AutoSizeMenuFromDescription = function(f11_arg0, f11_arg1, f11_arg2)
	return function(...)
		if Engine[0x3B05D20FBBC1325](
			CoD.BaseUtility.LocalizeIfXHash(CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f11_arg0].description, {
				n = select("#", ...),
				...,
			})),
			CoD.fonts.Default,
			20,
			660
		) > 3 then
			return f11_arg2 or "SystemOverlay_Full"
		else
			return f11_arg1 or "SystemOverlay_Compact"
		end
	end
end
CoD.OverlayUtility.FreeCursorAutoSizeMenuFromDescription = function(f13_arg0, f13_arg1, f13_arg2)
	return function(...)
		local f14_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f13_arg0].description, {
			n = select("#", ...),
			...,
		})
		if type(f14_local0) == "xhash" then
			f14_local0 = Engine[0xF9F1239CFD921FE](f14_local0)
		end
		if Engine[0x3B05D20FBBC1325](f14_local0, CoD.fonts.Default, 20, 660) > 6 then
			return f13_arg2 or "SystemOverlay_FreeCursor_Full"
		else
			return f13_arg1 or "SystemOverlay_FreeCursor"
		end
	end
end
CoD.OverlayUtility.ShouldOverlayUseFreeCursor = function(f15_arg0, ...)
	local f15_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f15_arg0].options, {
		n = select("#", ...),
		...,
	})
	if not f15_local0 then
		return false
	end
	local f15_local1 = 0
	for f15_local5, f15_local6 in ipairs(f15_local0) do
		if not f15_local6.isCancelOption then
			f15_local1 = f15_local1 + 1
		end
	end
	return f15_local1 <= 1
end
CoD.OverlayUtility.ShouldOverlayUseFullVersion = function(f16_arg0, ...)
	local f16_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f16_arg0].description, {
		n = select("#", ...),
		...,
	})
	if type(f16_local0) == "xhash" then
		f16_local0 = Engine[0xF9F1239CFD921FE](f16_local0)
	end
	return Engine[0x3B05D20FBBC1325](f16_local0, CoD.fonts.Default, 20, 660) > 6
end
CoD.OverlayUtility.AutoDetectOverlayMenu = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
	return function(...)
		local f18_local0 = {
			n = select("#", ...),
			...,
		}
		local f18_local1 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f17_arg0].description, f18_local0)
		local f18_local2 = CoD.OverlayUtility.ShouldOverlayUseFreeCursor(f17_arg0, unpack(f18_local0))
		local f18_local3 = CoD.OverlayUtility.ShouldOverlayUseFullVersion(f17_arg0, unpack(f18_local0))
		if f18_local2 and f18_local3 then
			return f17_arg4 or "SystemOverlay_FreeCursor_Full"
		elseif f18_local2 then
			return f17_arg2 or "SystemOverlay_FreeCursor"
		elseif f18_local3 then
			return f17_arg3 or "SystemOverlay_Full"
		else
			return f17_arg1 or "SystemOverlay_Compact"
		end
	end
end
CoD.OverlayUtility.CreateOverlayDataSourceFromOptions = function(f19_arg0)
	return function(...)
		local f20_local0 = {
			n = select("#", ...),
			...,
		}
		local f20_local1 = "_overlay_" .. f19_arg0
		local f20_local2 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f19_arg0].options, f20_local0)
		DataSources[f20_local1] = DataSourceHelpers.ListSetup(f20_local1, function(f21_arg0)
			local f21_local0 = {}
			for f21_local4, f21_local5 in ipairs(f20_local2) do
				table.insert(f21_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](f21_local5.text or 0x0),
					},
					properties = {
						action = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
							f21_local5.action(f22_arg4, f22_arg2)
						end,
						selectIndex = f21_local5.isDefaultListOption,
					},
				})
			end
			return f21_local0
		end)
		return f20_local1
	end
end
CoD.OverlayUtility.CreateOverlayGoBackFromOptions = function(f23_arg0)
	return function(...)
		for f24_local3, f24_local4 in
			ipairs(CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays[f23_arg0].options, {
				n = select("#", ...),
				...,
			}))
		do
			if f24_local4.isCancelOption then
				return f24_local4.action
			end
		end
		return CoD.OverlayUtility.DefaultGoBack()
	end
end
CoD.OverlayUtility.AddAutoDetectOverlay = function(f25_arg0, f25_arg1)
	local f25_local0 = f25_arg1.menuName
	if not f25_local0 then
		f25_local0 = CoD.OverlayUtility.AutoDetectOverlayMenu(f25_arg0)
	end
	f25_arg1.menuName = f25_local0
	f25_arg1.listDatasource = CoD.OverlayUtility.CreateOverlayDataSourceFromOptions(f25_arg0)
	if not f25_arg1[CoD.OverlayUtility.GoBackPropertyName] then
		f25_arg1[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.CreateOverlayGoBackFromOptions(f25_arg0)
	end
	f25_arg1[CoD.OverlayUtility.aCrossPromptText] = function(...)
		local f26_local0 = CoD.OverlayUtility.callFnOrGetValue(f25_arg1.options, {
			n = select("#", ...),
			...,
		})
		if f26_local0 then
			local f26_local1 = f26_local0[1]
			if f26_local1 and f26_local1.isCancelOption then
				f26_local1 = f26_local0[2]
			end
			if f26_local1 then
				return f26_local1.text
			end
		end
		return 0x0
	end
	f25_arg1[CoD.OverlayUtility.aCrossPromptFn] = function(...)
		local f27_local0 = CoD.OverlayUtility.callFnOrGetValue(f25_arg1.options, {
			n = select("#", ...),
			...,
		})
		if f27_local0 then
			local f27_local1 = f27_local0[1]
			if f27_local1 and f27_local1.isCancelOption then
				f27_local1 = f27_local0[2]
			end
			if f27_local1 then
				return function(f28_arg0, f28_arg1)
					f27_local1.action(f28_arg0, f28_arg1)
				end
			end
		end
		return nil
	end
	f25_arg1[CoD.OverlayUtility.bCirclePromptText] = function(...)
		local f29_local0 = CoD.OverlayUtility.callFnOrGetValue(f25_arg1.options, {
			n = select("#", ...),
			...,
		})
		if f29_local0 then
			local f29_local1 = f29_local0[2]
			if f29_local1 and not f29_local1.isCancelOption then
				f29_local1 = f29_local0[1]
			end
			if f29_local1 then
				return f29_local1.text
			end
		end
		return 0x0
	end
	f25_arg1[CoD.OverlayUtility.bCirclePromptFn] = function(...)
		local f30_local0 = CoD.OverlayUtility.callFnOrGetValue(f25_arg1.options, {
			n = select("#", ...),
			...,
		})
		if f30_local0 then
			local f30_local1 = f30_local0[2]
			if f30_local1 and not f30_local1.isCancelOption then
				f30_local1 = f30_local0[1]
			end
			if f30_local1 then
				return function(f31_arg0, f31_arg1)
					f30_local1.action(f31_arg0, f31_arg1)
				end
			end
		end
		return nil
	end
	CoD.OverlayUtility.Overlays[f25_arg0] = f25_arg1
end
if not CoD.OverlayUtility.Overlays then
	CoD.OverlayUtility.Overlays = {}
end
CoD.OverlayUtility.Overlays = LuaUtils.OverrideTable(CoD.OverlayUtility.Overlays, {
	SaveAndQuitGamePopup = {
		menuName = "SystemOverlay_FreeCursor",
		title = Engine[0xF9F1239CFD921FE](0x89E88D593CFB09),
		description = function()
			if not Engine[0x9E5BE3B4BBA4E0E]("ui_blocksaves") then
				return Engine[0xF9F1239CFD921FE](0x42D6867D072433A)
			else
				return ""
			end
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f33_arg0)
			return function(f34_arg0, f34_arg1)
				Engine[0x7C75E608EA39B5C](f34_arg1, "updategamerprofile")
				f34_arg0:close()
				CloseStartMenu(f34_arg0, f34_arg1)
				Engine[0xC554A8C36EF7EFF](f34_arg1, "popup_leavegame", "endround", 0)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0x76FE10547721876,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f35_arg0)
			return function(f36_arg0, f36_arg1)
				Engine[0xB177D654FFB67BE]("cl_paused", 0)
				Engine[0x10BF7D7C03EECE6](f36_arg1, false)
				CloseStartMenu(f36_arg0, f36_arg1)
				f36_arg0:processEvent({
					name = "close_all_ingame_menus",
					controller = f36_arg1,
				})
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0x21A0365016C8C6E,
	},
	QuitGamePopup = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0x68FF0AAC469D76F),
		description = Engine[0xF9F1239CFD921FE](0x719B1EEC54B1C06),
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.QuitGamePopup_List = DataSourceHelpers.ListSetup("QuitGamePopup_List", function(f38_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x21A0365016C8C6E),
						},
						properties = {
							action = function(f39_arg0, f39_arg1, f39_arg2, f39_arg3, f39_arg4)
								Engine[0xB177D654FFB67BE]("cl_paused", 0)
								f39_arg4:processEvent({
									name = "close_all_ingame_menus",
									controller = f39_arg2,
								})
								CloseStartMenu(f39_arg4, f39_arg2)
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x19AFCE2E7ACFB20),
						},
						properties = {
							action = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4)
								f40_arg4:processEvent({
									name = "close_all_ingame_menus",
									controller = f40_arg2,
								})
								Engine[0xB177D654FFB67BE]("cl_paused", 0)
								Engine[0xC554A8C36EF7EFF](f40_arg2, "popup_leavegame", "endround", 0)
								local f40_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
								if IsGameTypeDOA() then
									if not f40_local0 then
										Engine[0x7C75E608EA39B5C](f40_arg2, "disconnect")
									end
								else
									Engine[0x7C75E608EA39B5C](f40_arg2, "disconnect")
								end
							end,
						},
					},
				}
			end, true, nil)
			return "QuitGamePopup_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	RestartCheckpointPopup = {
		menuName = "SystemOverlay_FreeCursor",
		title = Engine[0xF9F1239CFD921FE](0xF9AE6D0C0376015),
		description = Engine[0xF9F1239CFD921FE](0x276F9228BA5B6B9),
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f41_arg0)
			return function(f42_arg0, f42_arg1)
				Dvar[0x4488B7C651BD0EC]:set(1)
				f42_arg0:dispatchEventToRoot({
					name = "flush_dynamic_hud",
				})
				f42_arg0:processEvent({
					name = "close_all_ingame_menus",
					controller = f42_arg1,
				})
				Engine[0xB177D654FFB67BE]("cl_paused", 0)
				CloseStartMenu(f42_arg0, f42_arg1)
				Engine[0x7C75E608EA39B5C](f42_arg1, "fade 0 0 0 255 0 0 1")
				Engine[0x7C75E608EA39B5C](f42_arg1, "stopControllerRumble")
				Engine[0x7C75E608EA39B5C](f42_arg1, "silence")
				Engine[0x7C75E608EA39B5C](f42_arg1, "checkpoint_restart")
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xCC22946A4401603,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f43_arg0)
			return function(f44_arg0, f44_arg1)
				Engine[0xB177D654FFB67BE]("cl_paused", 0)
				Engine[0x10BF7D7C03EECE6](f44_arg1, false)
				CloseStartMenu(f44_arg0, f44_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0x21A0365016C8C6E,
	},
	RestartGamePopup = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0xB0660C067FEB8B2),
		description = Engine[0xF9F1239CFD921FE](0x6E41AC9D5FFDEB),
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.RestartGamePopup_List = DataSourceHelpers.ListSetup("RestartGamePopup_List", function(f46_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x5C16E02B211A4F4),
						},
						properties = {
							action = function(f47_arg0, f47_arg1, f47_arg2, f47_arg3, f47_arg4)
								GoBack(f47_arg4, f47_arg2)
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
						},
						properties = {
							action = function(f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4)
								CloseStartMenu(f48_arg4, f48_arg2)
								RestartGameImmediate(f48_arg4, f48_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "RestartGamePopup_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	RestartGameAfterPurchasePopup = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0x92D0FAA04C71016),
		description = Engine[0xF9F1239CFD921FE](0x17F2B3FF653855F),
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.RestartGameAfterPurchasePopup_List = DataSourceHelpers.ListSetup("RestartGameAfterPurchasePopup_List", function(f50_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x7ED5E24F12CBE58),
						},
						properties = {
							action = function(f51_arg0, f51_arg1, f51_arg2, f51_arg3, f51_arg4)
								Engine[0x7C75E608EA39B5C](f51_arg2, "quit")
							end,
						},
					},
				}
			end, true, nil)
			return "RestartGameAfterPurchasePopup_List"
		end,
	},
	RestartMissionPopup = {
		menuName = "SystemOverlay_FreeCursor",
		title = Engine[0xF9F1239CFD921FE](0xB0660C067FEB8B2),
		description = Engine[0xF9F1239CFD921FE](0xA4142654C681BBB),
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f52_arg0)
			return function(f53_arg0, f53_arg1)
				Dvar[0x4488B7C651BD0EC]:set(1)
				f53_arg0:processEvent({
					name = "close_all_ingame_menus",
					controller = f53_arg1,
				})
				Engine[0xB177D654FFB67BE]("cl_paused", 0)
				Engine[0xC554A8C36EF7EFF](f53_arg1, "StartMenu_Main", "restartmission", 0)
				CloseStartMenu(f53_arg0, f53_arg1)
				Engine[0x39E704619FEB20F]("death")
				Engine[0x7C75E608EA39B5C](f53_arg1, "stopControllerRumble")
				Engine[0x7C75E608EA39B5C](f53_arg1, "fade 0 0 0 255 0 0 1")
				Engine[0x7C75E608EA39B5C](f53_arg1, "silence")
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xD06CC23B526BABD,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f54_arg0)
			return function(f55_arg0, f55_arg1)
				Engine[0xB177D654FFB67BE]("cl_paused", 0)
				Engine[0x10BF7D7C03EECE6](f55_arg1, false)
				CloseStartMenu(f55_arg0, f55_arg1)
				f55_arg0:processEvent({
					name = "close_all_ingame_menus",
					controller = f55_arg1,
				})
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0x21A0365016C8C6E,
	},
	RetryMissionPopup = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0xDBA1F53349424E4),
		description = 0x0,
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.RetryMissionPopup_List = DataSourceHelpers.ListSetup("RetryMissionPopup_List", function(f57_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x72F4B44486D7CB4),
						},
						properties = {
							action = function(f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4)
								Dvar[0x4488B7C651BD0EC]:set(1)
								f58_arg4:processEvent({
									name = "close_all_ingame_menus",
									controller = f58_arg2,
								})
								Engine[0xB177D654FFB67BE]("cl_paused", 0)
								Engine[0xC554A8C36EF7EFF](f58_arg2, "StartMenu_Main", "restartmission", 0)
								CloseStartMenu(f58_arg4, f58_arg2)
								Engine[0x39E704619FEB20F]("death")
								Engine[0x7C75E608EA39B5C](f58_arg2, "stopControllerRumble")
								Engine[0x7C75E608EA39B5C](f58_arg2, "fade 0 0 0 255 0 0 1")
								Engine[0x7C75E608EA39B5C](f58_arg2, "silence")
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x19AFCE2E7ACFB20),
						},
						properties = {
							action = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3, f59_arg4)
								f59_arg4:processEvent({
									name = "close_all_ingame_menus",
									controller = f59_arg2,
								})
								Engine[0xB177D654FFB67BE]("cl_paused", 0)
								Engine[0xC554A8C36EF7EFF](f59_arg2, "popup_leavegame", "endround", 0)
								local f59_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
								if IsGameTypeDOA() then
									if not f59_local0 then
										Engine[0x7C75E608EA39B5C](f59_arg2, "disconnect")
									end
								else
									Engine[0x7C75E608EA39B5C](f59_arg2, "disconnect")
								end
							end,
						},
					},
				}
			end, true, nil)
			return "RetryMissionPopup_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	MessageDialogBox = {
		menuName = CoD.OverlayUtility.FreeCursorAutoSizeMenuFromDescription("MessageDialogBox", "SystemOverlay_MessageDialog", "SystemOverlay_MessageDialogFull"),
		getStringRef = function(f60_arg0)
			return Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.MessageDialog.getModel(f60_arg0), "message")) or ""
		end,
		getTitleRef = function(f61_arg0)
			local f61_local0 = DataSources.MessageDialog.getModel(f61_arg0)
			return f61_local0.message:get() or ""
		end,
		postCreateStep = function(f62_arg0, f62_arg1)
			if CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f62_arg1) == 0x32BCFB6BE83EB58 then
				f62_arg0.ignoreForcedClose = true
			end
		end,
		title = function(f63_arg0)
			local f63_local0 = DataSources.MessageDialog.getModel(f63_arg0)
			local f63_local1 = CoD.BaseUtility.LocalizeIfXHash(CoD.SafeGetModelValue(f63_local0, "messageTitle"))
			if f63_local1 == nil or f63_local1 == "" or f63_local1 == 0x0 then
				local f63_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f63_local0, "messageType"))
				if f63_local2 == Enum[0xEE23F7D18EF525C][0x296CBAC6039D717] then
					f63_local1 = 0xA63CCA126DA271B
				elseif f63_local2 == Enum[0xEE23F7D18EF525C][0x8D00D07404A3DE5] then
					f63_local1 = 0xD0CB6ADB37BED49
				elseif f63_local2 == Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B] then
					f63_local1 = 0xED7AAC4B721DBBF
				elseif f63_local2 == Enum[0xEE23F7D18EF525C][0x7D5357A311F6CEB] then
					if CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f63_arg0) == Engine[0x5C7590F54ABD40](0xEED560597ED4A25) then
						f63_local1 = 0xF6A1C64397DF8F7
					else
						f63_local1 = 0xA009F37E1567367
					end
				end
			end
			return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f63_local1))
		end,
		description = function(f64_arg0)
			return CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f64_arg0)
		end,
		image = function(f65_arg0)
			local f65_local0 = CoD.SafeGetModelValue(DataSources.MessageDialog.getModel(f65_arg0), "messageImage")
			if f65_local0 ~= nil and f65_local0 ~= "" then
				return f65_local0
			else
				return nil
			end
		end,
		categoryType = function(f66_arg0)
			local f66_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.MessageDialog.getModel(f66_arg0), "messageType"))
			local f66_local1 = CoD.OverlayUtility.OverlayTypes.GenericMessage
			if f66_local0 == Enum[0xEE23F7D18EF525C][0x8D00D07404A3DE5] then
				f66_local1 = CoD.OverlayUtility.OverlayTypes.Alert
			elseif f66_local0 == Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B] then
				f66_local1 = CoD.OverlayUtility.OverlayTypes.Error
			elseif f66_local0 == Enum[0xEE23F7D18EF525C][0x296CBAC6039D717] then
				f66_local1 = CoD.OverlayUtility.OverlayTypes.Info
			elseif f66_local0 == Enum[0xEE23F7D18EF525C][0x7D5357A311F6CEB] then
				f66_local1 = CoD.OverlayUtility.OverlayTypes.Notice
			end
			return f66_local1
		end,
		listDatasource = function()
			if CoD.isPC then
				DataSources.MessageDialogBox_List = DataSourceHelpers.ListSetup("MessageDialogBox_List", function(f68_arg0)
					return {
						{
							models = {
								displayText = 0xE209447B4A40C7B,
							},
							properties = {
								action = function(f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4)
									LuaUtils.UI_ClearErrorMessageDialog()
									GoBack(f69_arg4, f69_arg2)
								end,
							},
						},
					}
				end, true, nil)
				return "MessageDialogBox_List"
			else
			end
		end,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f70_arg0)
			local f70_local0 = CoD.OverlayUtility.Overlays.MessageDialogBox.getTitleRef(f70_arg0)
			if CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f70_arg0) == Engine[0x5C7590F54ABD40](0xEED560597ED4A25) then
				return function(f71_arg0, f71_arg1)
					Engine[0x4DECC2B7654EAB1](f71_arg1)
					LuaUtils.UI_ClearErrorMessageDialog()
					GoBack(f71_arg0, f71_arg1)
				end
			elseif f70_local0 == 0xD8301725C955017 then
				return function(f72_arg0, f72_arg1)
					LuaUtils.UI_ClearErrorMessageDialog()
					GoBack(f72_arg0, f72_arg1)
					LobbyBeginPlay(GoBack(f72_arg0, f72_arg1), f72_arg1)
				end
			else
				return function(f73_arg0, f73_arg1)
					LuaUtils.UI_ClearErrorMessageDialog()
					GoBack(f73_arg0, f73_arg1)
				end
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = function(f74_arg0)
			local f74_local0 = CoD.OverlayUtility.Overlays.MessageDialogBox.getTitleRef(f74_arg0)
			if CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f74_arg0) == Engine[0x5C7590F54ABD40](0xEED560597ED4A25) then
				return 0xAA302CCFB49082B
			elseif f74_local0 == 0xD8301725C955017 then
				return 0x968A794E7F44FAD
			else
				return 0x5BE4A02B20F31F1
			end
		end,
		[CoD.OverlayUtility.xSquarePromptFn] = function(f75_arg0)
			local f75_local0 = CoD.OverlayUtility.Overlays.MessageDialogBox.getTitleRef(f75_arg0)
			if CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f75_arg0) == Engine[0x5C7590F54ABD40](0xEED560597ED4A25) then
				return function(f76_arg0, f76_arg1)
					LuaUtils.UI_ClearErrorMessageDialog()
					LuaUtils.UI_SetSignedInGamertagModel(Engine[0x2BBB49889896DFE]())
					GoBack(f76_arg0, f76_arg1)
					Engine[0x3A6780CF4E0EC0B]()
					Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92], "")
				end
			elseif f75_local0 == 0xD8301725C955017 then
				return function(f77_arg0, f77_arg1)
					LuaUtils.UI_ClearErrorMessageDialog()
					local f77_local0 = GoBack(f77_arg0, f77_arg1)
					CoD.LobbyUtility.FailedDWConnection = false
					Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), false)
					LobbyBeginPlay(f77_local0, f77_arg1)
				end
			else
				return nil
			end
		end,
		[CoD.OverlayUtility.xSquarePromptText] = function(f78_arg0)
			local f78_local0 = CoD.OverlayUtility.Overlays.MessageDialogBox.getTitleRef(f78_arg0)
			if CoD.OverlayUtility.Overlays.MessageDialogBox.getStringRef(f78_arg0) == Engine[0x5C7590F54ABD40](0xEED560597ED4A25) then
				return Engine[0xF9F1239CFD921FE](0x6AB75339FD90608, Engine[0x2BBB49889896DFE]())
			elseif f78_local0 == 0xD8301725C955017 then
				return 0x142813F0B0882F
			else
				return ""
			end
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f79_arg0)
			local f79_local0 = CoD.OverlayUtility.Overlays.MessageDialogBox.getTitleRef(f79_arg0)
			if CoD.isPC then
				if f79_local0 == 0xD8301725C955017 then
					return function(f80_arg0, f80_arg1)
						LuaUtils.UI_ClearErrorMessageDialog()
						local f80_local0 = GoBack(f80_arg0, f80_arg1)
						CoD.LobbyUtility.FailedDWConnection = false
						Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), false)
						LobbyBeginPlay(f80_local0, f80_arg1)
					end
				else
					return function(f81_arg0, f81_arg1)
						LuaUtils.UI_ClearErrorMessageDialog()
						GoBack(f81_arg0, f81_arg1)
					end
				end
			else
				return nil
			end
		end,
	},
	DownloadingDemoFile = {
		menuName = "SystemOverlay_Compact",
		frameWidget = "CoD.systemOverlay_Compact_BasicFrame_Loading",
		postCreateStep = function(f82_arg0, f82_arg1)
			f82_arg0.unusedControllerAllowed = true
			local f82_local0 = 0
			local f82_local1 = false
			CoD.OverlayUtility.Overlays[f82_arg0.menuName].title = 0xEF6E3D97714C03E
			CoD.OverlayUtility.Overlays[f82_arg0.menuName].description = ""
			f82_arg0:addElement(LUI.UITimer.newElementTimer(400, false, function(f83_arg0)
				if f82_local1 ~= true then
					local f83_local0 = Engine[0x8DF2E5447F384B9]()
					f83_local0 = f83_local0.lobbyRoot.theaterDownloadPercent:get()
					local f83_local1 = CoD.FileshareUtility.GetSelectedItemProperty("mainMode")
					local f83_local2 = CoD.FileshareUtility.GetSelectedItemProperty("mapName")
					local f83_local3 = CoD.FileshareUtility.GetSelectedItemProperty("gameTypeName")
					local f83_local4 = CoD.FileshareUtility.GetSelectedItemProperty("demoVersion")
					local f83_local5 = false
					local f83_local6 = 0xEF6E3D97714C03E
					local f83_local7 = ""
					if f83_local4 < 32 then
						f83_local6 = 0xED7AAC4B721DBBF
						f83_local7 = Engine[0xF9F1239CFD921FE](0x6648C5ADFDA72BB)
						f83_local5 = true
						f82_local1 = true
					elseif not Engine[0xC3C68A8BA45A52D](f83_local2, f83_local1) then
						f83_local6 = 0xED7AAC4B721DBBF
						f83_local7 = Engine[0xF9F1239CFD921FE](0x7BDE85F342990C1)
						f83_local5 = true
						f82_local1 = true
					elseif not Engine[0x66E866C1DB6239B](f83_local3, f83_local1) then
						f83_local6 = 0xED7AAC4B721DBBF
						f83_local7 = Engine[0xF9F1239CFD921FE](0x7AE2FA3B14AB42C)
						f83_local5 = true
						f82_local1 = true
					elseif HasFilmAndFilmDownloaded() and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.autoStart") then
						CoD.DirectorUtility.DirectorTheaterLaunchDemo(f82_arg0, f82_arg1)
						local f83_local8 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategory")
						if f83_local8 == "film" or f83_local8 == "recentgames" or f83_local8 == "film_private" then
							f83_local7 = Engine[0xF9F1239CFD921FE](0xE8105FA89AA601F)
						else
							f83_local7 = Engine[0xF9F1239CFD921FE](0x39FE9D0CB0C6F0F)
						end
						f83_local5 = true
					elseif f83_local0 < 100 then
						if CoD.FileshareUtility.FileshareIsDownloadingInError(CoD.FileshareUtility.GetSelectedItemProperty("fileId")) then
							f83_local6 = 0xED7AAC4B721DBBF
							f83_local7 = Engine[0xF9F1239CFD921FE](0xCFC1E203E359C99)
							f82_local1 = true
						else
							f83_local7 = Engine[0xF9F1239CFD921FE](0x658F66BBA1E1ADF, f83_local0)
						end
						f83_local5 = true
					end
					if f83_local5 == true then
						CoD.OverlayUtility.Overlays[f82_arg0.menuName].title = f83_local6
						CoD.OverlayUtility.Overlays[f82_arg0.menuName].description = f83_local7
						f82_arg0:refreshData(nil)
					end
					f82_local0 = f82_local0 + f83_arg0.timeElapsed
				end
			end))
		end,
		title = 0xEF6E3D97714C03E,
		description = "",
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f84_arg0)
			return function(f85_arg0, f85_arg1)
				if CoD.FileshareUtility.FileshareIsDownloading(CoD.FileshareUtility.GetSelectedItemProperty("fileId")) then
					Engine[0xB81A5136C5503E4](f85_arg1, "demo_abortfilesharedownload")
				end
				if f85_arg0.occludedMenu and CoD.LobbyUtility.MapVoteTimerActive() then
					LobbyGoBack(f85_arg0.occludedMenu, f85_arg1)
				end
				GoBack(f85_arg0, f85_arg1)
			end
		end,
	},
	DemoSaveClipPopup = {
		menuName = "SystemOverlay_Full",
		title = function()
			return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x471098B0579A24C))
		end,
		description = function()
			return Engine[0xF9F1239CFD921FE](0x7BDC7223FDD20A0)
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		listDatasource = function()
			DataSources.DemoSaveClipPopup_List = DataSourceHelpers.ListSetup("DemoSaveClipPopup_List", function(f89_arg0)
				local f89_local0 = {}
				table.insert(f89_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xBBE01564BE96E29),
					},
					properties = {
						action = function(f90_arg0, f90_arg1, f90_arg2, f90_arg3, f90_arg4)
							Engine[0x7C75E608EA39B5C](f90_arg2, "demo_savesegment 0")
							GoBack(f90_arg4, f90_arg2)
						end,
					},
				})
				table.insert(f89_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x3B7168B75575032),
					},
					properties = {
						action = function(f91_arg0, f91_arg1, f91_arg2, f91_arg3, f91_arg4)
							CoD.DemoUtility.OpenDemoKeyboard(f91_arg0, f91_arg1, f91_arg2, "segmentName")
						end,
					},
				})
				table.insert(f89_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x9E22C6CE275ABC3),
					},
					properties = {
						action = function(f92_arg0, f92_arg1, f92_arg2, f92_arg3, f92_arg4)
							Engine[0x7C75E608EA39B5C](f92_arg2, "demo_previewsegment")
							GoBack(f92_arg4, f92_arg2)
						end,
					},
				})
				table.insert(f89_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x20EE0E918F7E7CD),
					},
					properties = {
						action = function(f93_arg0, f93_arg1, f93_arg2, f93_arg3, f93_arg4)
							Engine[0x7C75E608EA39B5C](f93_arg2, "demo_savesegment 1")
							GoBack(f93_arg4, f93_arg2)
						end,
					},
				})
				return f89_local0
			end, true, nil)
			return "DemoSaveClipPopup_List"
		end,
		postCreateStep = function(f94_arg0, f94_arg1)
			Engine[0x10BF7D7C03EECE6](f94_arg1, true)
			Engine[0x9B8C02E7F47BDE3](f94_arg1, true)
			LUI.OverrideFunction_CallOriginalSecond(f94_arg0, "close", function(element)
				Engine[0x10BF7D7C03EECE6](f94_arg1, false)
				Engine[0x9B8C02E7F47BDE3](f94_arg1, false)
			end)
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = nil,
	},
	DemoCustomizeHighlightReelPopup = {
		menuName = "SystemOverlay_DemoCustomizeHighlightReel",
		frameWidget = "CoD.DemoCustomizeHighlightReel",
		title = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x7AA390A01EFA66C)),
		description = Engine[0xF9F1239CFD921FE](0x9164F5093FB2C14),
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		listDatasource = function()
			DataSources.DemoCustomizeHighlightReel_List = DataSourceHelpers.ListSetup(
				"DemoCustomizeHighlightReel_List",
				function(f97_arg0)
					local f97_local0 = Engine[0xDCCF490619F1876]()
					local f97_local1 = {}
					table.insert(f97_local1, {
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x355E66EE96B33D5)),
							disabled = f97_local0 <= 0,
						},
						properties = {
							action = function(f98_arg0, f98_arg1, f98_arg2, f98_arg3, f98_arg4)
								GoBackMultiple(f98_arg0, f98_arg2, 2)
								Engine[0x7C75E608EA39B5C](f98_arg2, "demo_regeneratehighlightreel")
							end,
						},
					})
					return f97_local1
				end,
				nil,
				nil,
				function(f99_arg0, f99_arg1, f99_arg2)
					local f99_local0 = CoD.DemoUtility.GetNumHighlightReelMomentsModel()
					if f99_arg1.updateSubscription then
						f99_arg1:removeSubscription(f99_arg1.updateSubscription)
					end
					f99_arg1.updateSubscription = f99_arg1:subscribeToModel(f99_local0, function()
						f99_arg1:updateDataSource(false)
					end, false)
				end
			)
			return "DemoCustomizeHighlightReel_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function()
			return function(f102_arg0, f102_arg1)
				GoBack(f102_arg0, f102_arg1)
			end
		end,
	},
	DemoDeleteAllDollyCameraMarkers = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0xAFB18AF560AEA82,
		description = 0xD478721E04FE0A6,
		categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
		listDatasource = function()
			DataSources.DemoDeleteAllDollyCameraMarkers_List = DataSourceHelpers.ListSetup("DemoDeleteAllDollyCameraMarkers_List", function(f104_arg0)
				local f104_local0 = {}
				table.insert(f104_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xD08A225C6FA4034),
					},
					properties = {
						action = function(f105_arg0, f105_arg1, f105_arg2, f105_arg3, f105_arg4)
							CoD.DemoUtility.RemoveDollyCamMarker(f105_arg0, f105_arg1, f105_arg2, "-1", f105_arg4)
							CoD.DemoUtility.SetEditingDollyCameraMarker(f105_arg2, false)
							GoBack(f105_arg4, f105_arg2)
						end,
					},
				})
				table.insert(f104_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
					},
					properties = {
						action = function(f106_arg0, f106_arg1, f106_arg2, f106_arg3, f106_arg4)
							GoBack(f106_arg4, f106_arg2)
						end,
						selectIndex = true,
					},
				})
				return f104_local0
			end, true, nil)
			return "DemoDeleteAllDollyCameraMarkers_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f107_arg0, f107_arg1, f107_arg2, f107_arg3, f107_arg4)
			return function(f108_arg0, f108_arg1)
				CoD.DemoUtility.RemoveDollyCamMarker(f107_arg0, f107_arg1, f108_arg1, "-1", f108_arg0)
				CoD.DemoUtility.SetEditingDollyCameraMarker(f108_arg1, false)
				GoBack(f108_arg0, f108_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f109_arg0)
			return function(f110_arg0, f110_arg1)
				GoBack(f110_arg0, f110_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	DemoDeleteAllLightmanMarkers = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x7D0A0960E680418,
		description = 0x6BDA7219E3794F8,
		categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
		listDatasource = function()
			DataSources.DemoDeleteAllLightmanMarkers_List = DataSourceHelpers.ListSetup("DemoDeleteAllLightmanMarkers_List", function(f112_arg0)
				local f112_local0 = {}
				table.insert(f112_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xD08A225C6FA4034),
					},
					properties = {
						action = function(f113_arg0, f113_arg1, f113_arg2, f113_arg3, f113_arg4)
							CoD.DemoUtility.RemoveLightmanMarker(f113_arg0, f113_arg1, f113_arg2, "-1", f113_arg4)
							CoD.DemoUtility.SetEditingLightmanMarker(f113_arg2, false)
							GoBack(f113_arg4, f113_arg2)
						end,
					},
				})
				table.insert(f112_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
					},
					properties = {
						action = function(f114_arg0, f114_arg1, f114_arg2, f114_arg3, f114_arg4)
							GoBack(f114_arg4, f114_arg2)
						end,
						selectIndex = true,
					},
				})
				return f112_local0
			end, true, nil)
			return "DemoDeleteAllLightmanMarkers_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f115_arg0, f115_arg1, f115_arg2, f115_arg3, f115_arg4)
			return function(f116_arg0, f116_arg1)
				CoD.DemoUtility.RemoveLightmanMarker(f115_arg0, f115_arg1, f116_arg1, "-1", f116_arg0)
				CoD.DemoUtility.SetEditingLightmanMarker(f116_arg1, false)
				GoBack(f116_arg0, f116_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f117_arg0)
			return function(f118_arg0, f118_arg1)
				GoBack(f118_arg0, f118_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	DemoDeleteSegment = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0xA9DF1FEDB2B6352,
		description = 0x3C93A343D0D4E7A,
		categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
		listDatasource = function()
			DataSources.DemoDeleteSegment_List = DataSourceHelpers.ListSetup("DemoDeleteSegment_List", function(f120_arg0)
				local f120_local0 = {}
				table.insert(f120_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
					},
					properties = {
						action = function(f121_arg0, f121_arg1, f121_arg2, f121_arg3, f121_arg4)
							Engine[0xB81A5136C5503E4](f121_arg2, "demo_deletesegment " .. Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](CoD.DemoUtility.Timeline_GetHighlightedSegmentModel(), "segmentNumber")) - 1)
							TimelineEditorRefresh()
							GoBack(f121_arg4, f121_arg2)
						end,
					},
				})
				table.insert(f120_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
					},
					properties = {
						action = function(f122_arg0, f122_arg1, f122_arg2, f122_arg3, f122_arg4)
							GoBack(f122_arg4, f122_arg2)
						end,
						selectIndex = true,
					},
				})
				return f120_local0
			end, true, nil)
			return "DemoDeleteSegment_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f123_arg0)
			return function(f124_arg0, f124_arg1)
				Engine[0xB81A5136C5503E4](f124_arg1, "demo_deletesegment " .. Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](CoD.DemoUtility.Timeline_GetHighlightedSegmentModel(), "segmentNumber")) - 1)
				TimelineEditorRefresh()
				GoBack(f124_arg0, f124_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f125_arg0)
			return function(f126_arg0, f126_arg1)
				GoBack(f126_arg0, f126_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	DemoDeleteAllSegments = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x835CE6A81360E27,
		description = 0xCF790D62CC5FF35,
		categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
		listDatasource = function()
			DataSources.DemoDeleteAllSegments_List = DataSourceHelpers.ListSetup("DemoDeleteAllSegments_List", function(f128_arg0)
				local f128_local0 = {}
				table.insert(f128_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
					},
					properties = {
						action = function(f129_arg0, f129_arg1, f129_arg2, f129_arg3, f129_arg4)
							Engine[0xB81A5136C5503E4](f129_arg2, "demo_deleteclip")
							TimelineEditorRefresh()
							GoBack(f129_arg4, f129_arg2)
						end,
					},
				})
				table.insert(f128_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
					},
					properties = {
						action = function(f130_arg0, f130_arg1, f130_arg2, f130_arg3, f130_arg4)
							GoBack(f130_arg4, f130_arg2)
						end,
						selectIndex = true,
					},
				})
				return f128_local0
			end, true, nil)
			return "DemoDeleteAllSegments_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f131_arg0)
			return function(f132_arg0, f132_arg1)
				Engine[0xB81A5136C5503E4](f132_arg1, "demo_deleteclip")
				TimelineEditorRefresh()
				GoBack(f132_arg0, f132_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f133_arg0)
			return function(f134_arg0, f134_arg1)
				GoBack(f134_arg0, f134_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	DemoMergeAllSegments = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x27E276A81A157A4,
		description = 0x5B672D58B3799C8,
		categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
		listDatasource = function()
			DataSources.DemoMergeAllSegments_List = DataSourceHelpers.ListSetup("DemoMergeAllSegments_List", function(f136_arg0)
				local f136_local0 = {}
				table.insert(f136_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
					},
					properties = {
						action = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4)
							Engine[0xB81A5136C5503E4](f137_arg2, "demo_mergesegments")
							TimelineEditorRefresh()
							GoBack(f137_arg4, f137_arg2)
						end,
					},
				})
				table.insert(f136_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
					},
					properties = {
						action = function(f138_arg0, f138_arg1, f138_arg2, f138_arg3, f138_arg4)
							GoBack(f138_arg4, f138_arg2)
						end,
						selectIndex = true,
					},
				})
				return f136_local0
			end, true, nil)
			return "DemoMergeAllSegments_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f139_arg0)
			return function(f140_arg0, f140_arg1)
				Engine[0xB81A5136C5503E4](f140_arg1, "demo_mergesegments")
				TimelineEditorRefresh()
				GoBack(f140_arg0, f140_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f141_arg0)
			return function(f142_arg0, f142_arg1)
				GoBack(f142_arg0, f142_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	EndDemoPopup = {
		menuName = "SystemOverlay_FreeCursor",
		title = function()
			local f143_local0 = nil
			local f143_local1 = Engine[0x4A884DF5CCCEB2E]()
			local f143_local2 = Engine[0x15B6CD621113691]()
			if not f143_local1 then
				if f143_local2 then
					f143_local0 = 0xAF10C79FA8979B9
				else
					f143_local0 = 0x683F5885FC33F7
				end
			elseif f143_local2 then
				f143_local0 = 0x1D0E892038AAC19
			else
				f143_local0 = 0x5F4332EC7BB2FF7
			end
			return f143_local0
		end,
		description = function()
			if Engine[0xE27188849954EC8]() then
				return 0x865068626103889
			else
				return 0x0
			end
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.EndDemoPopup_List = DataSourceHelpers.ListSetup("EndDemoPopup_List", function(f146_arg0)
				local f146_local0 = {}
				table.insert(f146_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
					},
					properties = {
						action = function(f147_arg0, f147_arg1, f147_arg2, f147_arg3, f147_arg4)
							GoBack(f147_arg4, f147_arg2)
							CoD.DemoUtility.EndDemo(f147_arg2)
						end,
					},
				})
				table.insert(f146_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x5C16E02B211A4F4),
					},
					properties = {
						action = function(f148_arg0, f148_arg1, f148_arg2, f148_arg3, f148_arg4)
							GoBack(f148_arg4, f148_arg2)
						end,
						selectIndex = true,
					},
				})
				return f146_local0
			end, true, nil)
			return "EndDemoPopup_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f149_arg0)
			return function(f150_arg0, f150_arg1)
				CoD.DemoUtility.EndDemo(f150_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f151_arg0)
			return function(f152_arg0, f152_arg1)
				GoBack(f152_arg0, f152_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	ScriptMessageDialog_Compact = {
		menuName = "SystemOverlay_FreeCursor",
		title = nil,
		description = nil,
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f153_arg0)
			return function(f154_arg0, f154_arg1)
				SendOwnMenuResponse(f154_arg0, f154_arg1, "close")
				Engine[0x10BF7D7C03EECE6](f154_arg1, false)
				Close(f154_arg0, f154_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0x70A9FDC87CD3D48,
	},
	UpdateNeeded = {
		menuName = "SystemOverlay_Compact",
		postCreateStep = function(f155_arg0, f155_arg1)
			f155_arg0.anyControllerAllowed = true
		end,
		title = 0xA009F37E1567367,
		description = 0x31A6CA9A4EEC046,
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		listDatasource = function(f156_arg0)
			DataSources.UpdateNeededPopupList = DataSourceHelpers.ListSetup("UpdateNeededPopupList", function(f157_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1),
						},
						properties = {
							action = function(f158_arg0, f158_arg1, f158_arg2, f158_arg3, f158_arg4)
								CoD.LobbyUtility.FailedDWConnection = true
								Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), true)
								GoBack(f158_arg4, f158_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "UpdateNeededPopupList"
		end,
	},
	LoadingProfile = {
		menuName = "SystemOverlay_Compact",
		frameWidget = "CoD.systemOverlay_Compact_BasicFrame_Loading",
		postCreateStep = function(f159_arg0, f159_arg1)
			f159_arg0.unusedControllerAllowed = true
			local f159_local0 = 0
			f159_arg0:addElement(LUI.UITimer.newElementTimer(400, false, function(f160_arg0)
				if Engine[0x2598E548104179E](f159_arg1) == true then
					GoBack(f159_arg0, f159_arg1)
					return
				elseif f159_local0 > CoD.OverlayUtility.LOCAL_FILES_FETCH_WAIT_TIME then
					GoBack(f159_arg0, f159_arg1)
					return
				else
					f159_local0 = f159_local0 + f160_arg0.timeElapsed
				end
			end))
		end,
		title = 0x4A3C27FB27F4DC7,
		description = 0x0,
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	ConnectingToDemonware = {
		menuName = "SystemOverlay_Compact",
		frameWidget = "CoD.systemOverlay_Compact_BasicFrame_Loading",
		postCreateStep = function(f161_arg0, f161_arg1)
			f161_arg0.unusedControllerAllowed = true
			local f161_local0 = 0
			local f161_local1 = 0
			Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.beginPlay"), Enum[0xC84D3E505F1444][0xDB898B3478D2D71])
			f161_arg0:addElement(LUI.UITimer.newElementTimer(400, false, function(f162_arg0)
				local f162_local0 = Engine[0x451F40A2FEDDF88](f161_arg1)
				if f162_local0.connectionState == 7 then
					CoD.OverlayUtility.Overlays[f161_arg0.menuName].description = Engine[0xF9F1239CFD921FE](0xA41969317F908FF)
					f161_arg0:refreshData(nil)
				else
					CoD.OverlayUtility.Overlays[f161_arg0.menuName].description = ""
				end
				local f162_local1 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.startPopups")
				local f162_local2 = 0
				if f162_local1 then
					f162_local2 = Engine[0x614D394F6F9A18D](f162_local1)
				end
				if f162_local2 > 0 then
					local f162_local3 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.startBitsToFetch"))
					if f162_local3 & Engine[0x4DC3A644148CFC](f161_arg1) == f162_local3 then
						if not CoD.MOTDUtility.MOTD_ShouldShowMOTD(f161_arg1) then
							Engine[0x83C9B5DE1D9371](f162_local1, CoD.BitUtility.ClearBit(f162_local2, LuaEnum.START_POPUPS.MOTD))
						else
							GoBack(f161_arg0, f161_arg1)
							return
						end
					end
				elseif Engine[0x3CD0351DA0D371](f161_arg1) then
					CoD.LobbyUtility.FailedDWConnection = false
					Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), false)
					local f162_local3 = LobbyData.GetLobbyNav()
					if Engine[0xA5B9C0111291A8B]() == f161_arg1 then
						if f162_local3 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f162_local3 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
							Engine[0x87AE7E64BA5AD61]("OnNetworkModeChanged", {
								controller = f161_arg1,
								networkMode = Enum[0xC84D3E505F1444][0xE99F41098B71960],
							})
						elseif f162_local3 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
							Engine[0xEF56B086D9D2C36](Enum[0xC84D3E505F1444][0xE99F41098B71960])
						end
					end
					GoBack(f161_arg0, f161_arg1)
					if f162_local3 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
						Dvar[0x6CCDF6439ECB1EF]:set(Enum[0xC84D3E505F1444][0xE99F41098B71960])
					end
					return
				end
				local f162_local3 = Engine[0x85FB7614CA3F97E]()
				local f162_local4 = LuaUtils.ConnectingToDemonwareMaxWaitTime()
				if Engine[0x5A66FAF3BBCAC63]() then
					local f162_local5 = Engine[0xF9A2D658382A8DE]()
					if f162_local5 == 0 or f162_local5 == 100 then
						CoD.OverlayUtility.Overlays[f161_arg0.menuName].description = Engine[0xF9F1239CFD921FE](0x3E26E8FAE6EC0BF)
					else
						CoD.OverlayUtility.Overlays[f161_arg0.menuName].description = Engine[0xF9F1239CFD921FE](0xD9EDFBB4CD890FF, f162_local5)
					end
					f161_arg0:refreshData(nil)
					f161_local0 = 0
				elseif f162_local4 < f161_local0 or f162_local3 == false then
					local f162_local5 = GoBack(f161_arg0, f161_arg1)
					CoD.OverlayUtility.CreateConnectionErrorOverlay(f161_arg1, f162_local5.id, f162_local3)
				end
				if Engine[0xF62AEC4075B0105](f161_arg1) or Engine[0x4E9A9EF7583DC81](f161_arg1) then
					CoD.OverlayUtility.CreateOverlay(f161_arg1, GoBack(f161_arg0, f161_arg1), "LoginQueued")
				end
				f161_local0 = f161_local0 + f162_arg0.timeElapsed
				if CoD.isPC and f161_local1 < Engine[0x4DC3A644148CFC](f161_arg1) then
					f161_local1 = Engine[0x4DC3A644148CFC](f161_arg1)
					f161_local0 = 0
				end
			end))
		end,
		title = 0x959976D30A883CB,
		description = "",
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
	},
	LobbyPlayNetworkModePopup = {
		menuName = CoD.OverlayUtility.AutoSizeMenuFromDescription("LobbyPlayNetworkModePopup"),
		title = function(f163_arg0)
			local f163_local0 = 0x0
			if f163_arg0 == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
				f163_local0 = 0xB8CCFF42AA4540F
			elseif f163_arg0 == Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
				f163_local0 = 0xB7452C346AFFF67
			end
			return Engine[0xF9F1239CFD921FE](f163_local0)
		end,
		description = function(f164_arg0)
			local f164_local0 = 0x0
			local f164_local1 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
			if f164_arg0 == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
				if Engine[0x44FC97037CE42ED](f164_local1, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F]) > 1 then
					f164_local0 = 0xA8219C5EFD57415
				else
					f164_local0 = 0x641941712295807
				end
			elseif f164_arg0 == Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
				if Engine[0x44FC97037CE42ED](f164_local1, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F]) > 1 then
					f164_local0 = 0x2C90CCF70351109
				else
					f164_local0 = 0xC63DC8F5263EFB7
				end
			end
			return Engine[0xF9F1239CFD921FE](f164_local0)
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		listDatasource = function(f165_arg0)
			DataSources.LobbyPlayNetworkModePopupButtons = DataSourceHelpers.ListSetup("LobbyPlayNetworkModePopupButtons", function(f166_arg0)
				local f166_local0 = 0x0
				if f165_arg0 == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
					f166_local0 = 0xE15741425E1DEBD
				elseif f165_arg0 == Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
					f166_local0 = 0x968A794E7F44FAD
				end
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](f166_local0),
						},
						properties = {
							action = function(f167_arg0, f167_arg1, f167_arg2, f167_arg3, f167_arg4)
								LobbyToggleNetwork(f167_arg0, f167_arg1, f167_arg2, f167_arg3)
								GoBack(f167_arg4, f167_arg2)
							end,
							actionParam = f165_arg0,
						},
					},
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
						},
						properties = {
							action = function(f168_arg0, f168_arg1, f168_arg2, f168_arg3, f168_arg4)
								GoBack(f168_arg4, f168_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "LobbyPlayNetworkModePopupButtons"
		end,
	},
	CheckingRestrictions = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0xD7A26B6796F8776),
		frameWidget = "CoD.systemOverlay_Compact_BasicFrame_Loading",
		description = 0x0,
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		postCreateStep = function(f169_arg0, f169_arg1)
			f169_arg0.unusedControllerAllowed = true
			local f169_local0 = 0
			f169_arg0:addElement(LUI.UITimer.newElementTimer(800, false, function(f170_arg0)
				if Engine[0x55DF22E0A4260A5](f169_arg1) == false then
					if Engine[0xD4D05ACED1A0F3](f169_arg1) then
						CoD.LobbyUtility.FailedDWConnection = false
						Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), false)
						local f170_local0 = LobbyData.GetLobbyNav()
						if f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
							Engine[0x87AE7E64BA5AD61]("OnNetworkModeChanged", {
								controller = f169_arg1,
								networkMode = Enum[0xC84D3E505F1444][0xE99F41098B71960],
							})
						elseif f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
							Engine[0xEF56B086D9D2C36](Enum[0xC84D3E505F1444][0xE99F41098B71960])
						end
						GoBack(f169_arg0, f169_arg1)
						if f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
							Dvar[0x6CCDF6439ECB1EF]:set(Enum[0xC84D3E505F1444][0xE99F41098B71960])
						end
						return
					end
					Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "CheckingRestrictions:HasCompletedCheckingRestrictions still hasn't completed.\n")
					local f170_local0 = LobbyData.GetLobbyNav()
					if f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
						Engine[0x87AE7E64BA5AD61]("OnNetworkModeChanged", {
							controller = f169_arg1,
							networkMode = Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255],
						})
					elseif f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
						Engine[0xEF56B086D9D2C36](Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255])
					end
					GoBack(f169_arg0, f169_arg1)
					if f170_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
						Dvar[0x6CCDF6439ECB1EF]:set(Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255])
					end
					return
				else
				end
			end))
		end,
	},
	LoginQueued = {
		menuName = "SystemOverlay_Compact",
		frameWidget = "CoD.systemOverlay_Compact_BasicFrame_Loading",
		postCreateStep = function(f171_arg0, f171_arg1)
			f171_arg0.unusedControllerAllowed = true
			local f171_local0 = 0
			local f171_local1 = 0
			f171_arg0:addElement(LUI.UITimer.newElementTimer(400, false, function(f172_arg0)
				local f172_local0 = Engine[0x8D7B33196264589](f171_arg1)
				if f172_local0.closed then
					local f172_local1 = LuaEnum.BD_LOBBY_ERROR_CODES_DESCRIPTION_STRINGS[f172_local0.errorCode]
					if f172_local1 ~= nil then
						CoD.OverlayUtility.Overlays[f171_arg0.menuName].description = Engine[0xF9F1239CFD921FE](f172_local1)
					end
					CoD.OverlayUtility.Overlays[f171_arg0.menuName].title = Engine[0xF9F1239CFD921FE](0x572450D01E06CD6)
					f171_arg0:refreshData(nil)
				elseif f172_local0.queued then
					if f172_local0.position > 0 and f172_local0.estimatedWaitTimeSec > 0 then
						local f172_local1 = math.floor(f172_local0.estimatedWaitTimeSec / 60)
						local f172_local2 = f172_local0.estimatedWaitTimeSec % 60
						local f172_local3 = math.floor(f172_local1 / 60)
						local f172_local4 = f172_local1 % 60
						local f172_local5 = math.floor(f172_local0.timeSinceQueuedSec / 60)
						local f172_local6 = f172_local0.timeSinceQueuedSec % 60
						local f172_local7 = math.floor(f172_local5 / 60)
						local f172_local8 = f172_local5 % 60
						CoD.OverlayUtility.Overlays[f171_arg0.menuName].description = Engine[0xF9F1239CFD921FE](Engine[0xF9F1239CFD921FE](0x78D7640C2093217, f172_local0.position, f172_local5, f172_local6, f172_local1, f172_local2))
					end
					CoD.OverlayUtility.Overlays[f171_arg0.menuName].title = Engine[0xF9F1239CFD921FE](0xC51866DCC22F69A)
					f171_arg0:refreshData(nil)
				elseif f172_local0.disabled then
				elseif not f172_local0.success then
					local f172_local1 = 0x632F97C36A01BD6
					local f172_local2 = GoBack(f171_arg0, f171_arg1)
					LuaUtils.UI_ShowErrorMessageDialog(f171_arg1, f172_local1, 0x31E422BC40B2429)
					CoD.LobbyUtility.FailedDWConnection = true
					Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), true)
					Engine[0x4ED0477E4FACDCF](f171_arg1)
				else
					CoD.OverlayUtility.CreateOverlay(f171_arg1, GoBack(f171_arg0, f171_arg1), "ConnectingToDemonware")
				end
				f171_local1 = f171_local1 + f172_arg0.timeElapsed
			end))
		end,
		title = Engine[0xF9F1239CFD921FE](0x572450D01E06CD6),
		description = "",
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	PaintjobClearConfirmationOverlay = {
		menuName = "SystemOverlay_FreeCursor",
		frameWidget = "CoD.systemOverlay_DeletePaintjobFrame",
		title = Engine[0xF9F1239CFD921FE](0x74BEFB514E9134B),
		description = Engine[0xF9F1239CFD921FE](0xF23BA024C1883C6),
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		listDatasource = function()
			DataSources.DeletePaintjobConfirmation_List = DataSourceHelpers.ListSetup("DeletePaintjobConfirmation_List", function(f174_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
						},
						properties = {
							action = function(f175_arg0, f175_arg1, f175_arg2, f175_arg3, f175_arg4)
								PaintjobSelector_ClearPaintjob(f175_arg4, f175_arg2)
								GoBack(f175_arg4, f175_arg2)
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
						},
						properties = {
							action = function(f176_arg0, f176_arg1, f176_arg2, f176_arg3, f176_arg4)
								GoBack(f176_arg4, f176_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "DeletePaintjobConfirmation_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f177_arg0)
			return function(f178_arg0, f178_arg1)
				PaintjobSelector_ClearPaintjob(f178_arg0, f178_arg1)
				GoBack(f178_arg0, f178_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f179_arg0)
			return function(f180_arg0, f180_arg1)
				GoBack(f180_arg0, f180_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	InitialCODPointsOverlay = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x25BC30296F0A01F)),
		description = 0x6B5C6DE62EF7B8F,
		categoryType = CoD.OverlayUtility.OverlayTypes.CODPoints,
		listDatasource = function()
			DataSources.InitialCODPoints_List = DataSourceHelpers.ListSetup("InitialCODPoints_List", function(f182_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1),
						},
						properties = {
							action = function(f183_arg0, f183_arg1, f183_arg2, f183_arg3, f183_arg4)
								local f183_local0 = Engine[0x8BF970606552F4C](f183_arg2, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
								if f183_local0 then
									f183_local0.codPointMsgSeen:set(1)
									Engine[0x28A466EF7723621](f183_arg2, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
								end
								GoBack(f183_arg4, f183_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "InitialCODPoints_List"
		end,
	},
	EmblemClearConfirmationOverlay = {
		menuName = "SystemOverlay_FreeCursor",
		frameWidget = "CoD.systemOverlay_DeleteEmblemFrame",
		title = Engine[0xF9F1239CFD921FE](0xC9D0E475F9A65A9),
		description = Engine[0xF9F1239CFD921FE](0xF18FEBD3AE90DFF),
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		listDatasource = function()
			DataSources.DeleteEmblemConfirmation_List = DataSourceHelpers.ListSetup("DeleteEmblemConfirmation_List", function(f185_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
						},
						properties = {
							action = function(f186_arg0, f186_arg1, f186_arg2, f186_arg3, f186_arg4)
								CoD.CraftUtility.EmblemSelect_ClearEmblem(f186_arg4, f186_arg2)
								GoBack(f186_arg4, f186_arg2)
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289),
						},
						properties = {
							action = function(f187_arg0, f187_arg1, f187_arg2, f187_arg3, f187_arg4)
								GoBack(f187_arg4, f187_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "DeleteEmblemConfirmation_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f188_arg0)
			return function(f189_arg0, f189_arg1)
				CoD.CraftUtility.EmblemSelect_ClearEmblem(f189_arg0, f189_arg1)
				GoBack(f189_arg0, f189_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f190_arg0)
			return function(f191_arg0, f191_arg1)
				GoBack(f191_arg0, f191_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	GunsmithSaveVariant = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_SaveVariantFrame",
		title = Engine[0xF9F1239CFD921FE](0xA887F080414BD45),
		description = function(f192_arg0, f192_arg1)
			return LocalizeWeaponNameIntoString(0x6E7F7FD2F8A555, f192_arg0, CoD.GetCustomization(f192_arg0, "weapon_index"))
		end,
		image = function(f193_arg0, f193_arg1)
			local f193_local0 = f193_arg1:getModel()
			if f193_local0 then
				local f193_local1 = Engine[0x40E824FE270E174](f193_local0, "variantIndex")
				if f193_local1 then
					return Engine[0x614D394F6F9A18D](f193_local1)
				end
			end
			return ""
		end,
		variantName = function(f194_arg0, f194_arg1)
			local f194_local0 = f194_arg1:getModel()
			if f194_local0 then
				local f194_local1 = Engine[0x40E824FE270E174](f194_local0, "variantName")
				if f194_local1 then
					return Engine[0x614D394F6F9A18D](f194_local1)
				end
			end
			return ""
		end,
		weaponName = function(f195_arg0, f195_arg1)
			local f195_local0 = f195_arg1:getModel()
			if f195_local0 then
				local f195_local1 = Engine[0x40E824FE270E174](f195_local0, "weaponIndex")
				if f195_local1 then
					return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](Engine[0x614D394F6F9A18D](f195_local1))))
				end
			end
			return ""
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		listDatasource = function(f196_arg0, f196_arg1)
			DataSources.GunsmithSaveVariant_List = DataSourceHelpers.ListSetup("GunsmithSaveVariant_List", function(f197_arg0)
				return {
					{
						models = {
							displayText = LocalizeToUpperString(0x6800A599D7171FA),
						},
						properties = {
							action = function(f198_arg0, f198_arg1, f198_arg2, f198_arg3, f198_arg4)
								if Gunsmith_IsCurrentVariantChanged(f198_arg2) then
									Gunsmith_ClearSelectedGunsmithVariantStats(f198_arg2)
									Gunsmith_ClearCACWithUpdatedVariant(f198_arg4, f198_arg2)
								end
								ForceNotifyModel(f198_arg2, "Gunsmith.UpdateDataSource")
							end,
						},
					},
					{
						models = {
							displayText = LocalizeToUpperString(0xFD9C2574305F7C3),
						},
						properties = {
							action = function(f199_arg0, f199_arg1, f199_arg2, f199_arg3, f199_arg4) end,
						},
					},
				}
			end, true, nil)
			return "GunsmithSaveVariant_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	EmblemSave = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_SaveEmblemFrame",
		title = Engine[0xF9F1239CFD921FE](0xB92671421489FE1),
		description = Engine[0xF9F1239CFD921FE](0xAAC383C11CADD1B),
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		inputText = function(f200_arg0, f200_arg1, f200_arg2, f200_arg3)
			if f200_arg1 then
				return Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f200_arg1, "emblemTextEntry"))
			else
			end
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f201_arg0, f201_arg1, f201_arg2, f201_arg3)
			return function(f202_arg0, f202_arg1)
				GoBack(f202_arg0, f202_arg1)
				PaintjobEditor_RestoreGridState(f202_arg1)
			end
		end,
		listDatasource = function(f203_arg0, f203_arg1, f203_arg2, f203_arg3)
			DataSources.EmblemSave_List = DataSourceHelpers.ListSetup("EmblemSave_List", function(f204_arg0)
				local f204_local0 = 0x30BBCC54CF2C2AE
				if f203_arg1 then
					f204_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f203_arg1, "emblemTextEntry"))
				end
				local f204_local1 = CraftSlotsFullByStorageType(f204_arg0, Enum[0xBBD4F9E70101BA8][0x791C91FD2327632])
				local f204_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f203_arg1, "isUsed")) == 1
				local f204_local3 = {}
				local f204_local4 = LocalizeToUpperString(0xE738001B1CB1269)
				if f204_local2 then
					f204_local4 = LocalizeToUpperString(0x5C0A6F0BCEAC8DF)
				end
				table.insert(f204_local3, {
					models = {
						displayText = f204_local4,
						disabled = IsPreBuiltEmblemTab(f204_arg0),
					},
					properties = {
						action = function(f205_arg0, f205_arg1, f205_arg2, f205_arg3, f205_arg4)
							local f205_local0 = CoD.CraftUtility.EmblemEditor_SaveEmblemAndExit(f205_arg4, f205_arg1, f205_arg2, f203_arg1, false)
							if f203_arg2 then
								ForceNotifyModel(f205_arg2, "Emblem.UpdateDataSource")
							end
							CoD.CraftUtility.CraftSaveToast(f205_arg0, Engine[0xF9F1239CFD921FE](0xFCA49E5ABA85C61))
							if f203_arg3 ~= nil then
								f203_arg3(f205_local0)
							end
						end,
					},
				})
				if f204_local2 then
					table.insert(f204_local3, {
						models = {
							displayText = LocalizeToUpperString(0xCDD21EE3622D1D1),
							disabled = f204_local1,
						},
						properties = {
							action = function(f206_arg0, f206_arg1, f206_arg2, f206_arg3, f206_arg4)
								local f206_local0 = CoD.CraftUtility.EmblemEditor_SaveEmblemAndExit(f206_arg4, f206_arg1, f206_arg2, f203_arg1, IsPreBuiltEmblemTab(f206_arg2) or f204_local2)
								if f203_arg2 then
									ForceNotifyModel(f206_arg2, "Emblem.UpdateDataSource")
								end
								CoD.CraftUtility.CraftSaveToast(f206_arg0, Engine[0xF9F1239CFD921FE](0xFCA49E5ABA85C61))
								if f203_arg3 ~= nil then
									f203_arg3(f206_local0)
								end
							end,
						},
					})
				end
				if f204_local2 or f203_arg2 then
					table.insert(f204_local3, {
						models = {
							rename = false,
							displayText = LocalizeToUpperString(0x45A42BBA5637767),
						},
						properties = {
							action = function(f207_arg0, f207_arg1, f207_arg2, f207_arg3, f207_arg4)
								if f203_arg3 ~= nil then
									GoBack(f207_arg4, f207_arg2)
									f203_arg3()
									return
								else
									CoD.CraftUtility.EmblemEditor_ReturnToSelect(f207_arg4, f207_arg1, f207_arg2)
									ForceNotifyModel(f207_arg2, "Emblem.UpdateDataSource")
								end
							end,
						},
					})
				end
				return f204_local3
			end, true, nil)
			return "EmblemSave_List"
		end,
	},
	DecalGroupSave = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_SaveDecalGroupFrame",
		title = Engine[0xF9F1239CFD921FE](0x97EA723817D4A5C),
		description = Engine[0xF9F1239CFD921FE](0x291C9E3FE925DA4),
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		inputText = function(f208_arg0, f208_arg1)
			if f208_arg1 then
				return Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f208_arg1, "emblemTextEntry"))
			else
			end
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		listDatasource = function(f209_arg0, f209_arg1)
			DataSources.DecalGroupSave_List = DataSourceHelpers.ListSetup("DecalGroupSave_List", function(f210_arg0)
				return {
					{
						models = {
							rename = false,
							displayText = LocalizeToUpperString(0xC5F3C3BC3105BF9),
						},
						properties = {
							action = function(f211_arg0, f211_arg1, f211_arg2, f211_arg3, f211_arg4)
								CoD.CraftUtility.Groups.Save(f211_arg4, f211_arg2)
								CoD.CraftUtility.CraftSaveToast(f211_arg0, ConvertToUpperString(Engine[0xF9F1239CFD921FE](0x345431B325139E6)))
							end,
						},
					},
				}
			end, true, nil)
			return "DecalGroupSave_List"
		end,
	},
	DecalGroupRename = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_RenameDecalGroupFrame_PC",
		title = Engine[0xF9F1239CFD921FE](0x5AE7DFA79AC244F),
		description = Engine[0xF9F1239CFD921FE](0x81053C5F36C47C1),
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		inputText = function(f212_arg0, f212_arg1)
			if f212_arg1 then
				return Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f212_arg1, "emblemTextEntry"))
			else
			end
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		listDatasource = function(f213_arg0, f213_arg1)
			DataSources.DecalGroupRename_List = DataSourceHelpers.ListSetup("DecalGroupRename_List", function(f214_arg0)
				return {
					{
						models = {
							displayText = LocalizeToUpperString(0xC5F3C3BC3105BF9),
						},
						properties = {
							action = function(f215_arg0, f215_arg1, f215_arg2, f215_arg3, f215_arg4)
								CoD.CraftUtility.EmblemChooseIcon_RenameDecal(f215_arg0, f215_arg1, f215_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "DecalGroupRename_List"
		end,
	},
	PaintjobSave = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_SavePaintjobFrame",
		title = Engine[0xF9F1239CFD921FE](0x91A0B3DBB08314),
		description = Engine[0xF9F1239CFD921FE](0xAF9A268B817FFDC),
		categoryType = CoD.OverlayUtility.OverlayTypes.Save,
		inputText = function(f216_arg0, f216_arg1, f216_arg2, f216_arg3)
			if f216_arg1 then
				return Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f216_arg1, "paintjobTextEntry"))
			else
			end
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f217_arg0, f217_arg1, f217_arg2, f217_arg3)
			return function(f218_arg0, f218_arg1)
				GoBack(f218_arg0, f218_arg1)
				PaintjobEditor_RestoreGridState(f218_arg1)
			end
		end,
		listDatasource = function(f219_arg0, f219_arg1, f219_arg2, f219_arg3)
			DataSources.PaintjobSave_List = DataSourceHelpers.ListSetup("PaintjobSave_List", function(f220_arg0)
				local f220_local0 = 0x30BBCC54CF2C2AE
				if f219_arg1 then
					f220_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f219_arg1, "paintjobTextEntry"))
				end
				local f220_local1 = CraftSlotsFullByStorageType(f220_arg0, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61])
				local f220_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f219_arg1, "weaponIndex")) ~= CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX
				local f220_local3 = {}
				local f220_local4 = LocalizeToUpperString(0xE738001B1CB1269)
				if f220_local2 then
					f220_local4 = LocalizeToUpperString(0x5C0A6F0BCEAC8DF)
				end
				table.insert(f220_local3, {
					models = {
						displayText = f220_local4,
					},
					properties = {
						action = function(f221_arg0, f221_arg1, f221_arg2, f221_arg3, f221_arg4)
							if f219_arg2 then
								CoD.CraftUtility.PaintjobEditor_SavePaintjobAndExit(f221_arg4, f221_arg1, f221_arg2, f219_arg1, false)
								ForceNotifyModel(f221_arg2, "Paintshop.UpdateDataSource")
							else
								CoD.CraftUtility.PaintjobEditor_SavePaintjobAndEdit(f221_arg4, f221_arg1, f221_arg2, f219_arg1, false)
								GoBack(f221_arg4, f221_arg2)
							end
							CoD.CraftUtility.CraftSaveToast(f221_arg0, Engine[0xF9F1239CFD921FE](0x91A0B3DBB08314))
							if f219_arg3 ~= nil then
								f219_arg3()
							end
						end,
					},
				})
				if f220_local2 then
					table.insert(f220_local3, {
						models = {
							displayText = LocalizeToUpperString(0xCDD21EE3622D1D1),
							disabled = f220_local1,
						},
						properties = {
							action = function(f222_arg0, f222_arg1, f222_arg2, f222_arg3, f222_arg4)
								local f222_local0 = f220_local2
								if f219_arg2 then
									CoD.CraftUtility.PaintjobEditor_SavePaintjobAndExit(f222_arg4, f222_arg1, f222_arg2, f219_arg1, f222_local0)
									ForceNotifyModel(f222_arg2, "Paintshop.UpdateDataSource")
								else
									CoD.CraftUtility.PaintjobEditor_SavePaintjobAndEdit(f222_arg4, f222_arg1, f222_arg2, f219_arg1, f222_local0)
									GoBack(f222_arg4, f222_arg2)
								end
								CoD.CraftUtility.CraftSaveToast(f222_arg0, Engine[0xF9F1239CFD921FE](0x91A0B3DBB08314))
								if f219_arg3 ~= nil then
									f219_arg3()
								end
							end,
						},
					})
				end
				if f220_local2 or f219_arg2 then
					table.insert(f220_local3, {
						models = {
							rename = false,
							displayText = LocalizeToUpperString(0x45A42BBA5637767),
						},
						properties = {
							action = function(f223_arg0, f223_arg1, f223_arg2, f223_arg3, f223_arg4)
								if f219_arg3 ~= nil then
									GoBack(f223_arg4, f223_arg2)
									f219_arg3()
									return
								else
									CoD.CraftUtility.Paintshop_ShowPreviewOfRecentlyEdited(f223_arg2)
									CoD.CraftUtility.PaintjobEditor_DiscardChanges(f223_arg0, f223_arg2, f219_arg1)
									ForceNotifyModel(f223_arg2, "Paintshop.UpdateDataSource")
								end
							end,
						},
					})
				end
				return f220_local3
			end, true, nil)
			return "PaintjobSave_List"
		end,
	},
	DailyChallengeWarningOverlay = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_DailyChallengeWarningFrame",
		categoryType = CoD.OverlayUtility.OverlayTypes.Notice,
		title = 0x24093201635E25B,
		description = 0x3FFE8BBAFA58EAA,
		listDatasource = function()
			DataSources.DailyChallengeWarningOverlay = DataSourceHelpers.ListSetup("DailyChallengeWarningOverlay", function(f225_arg0)
				return {
					{
						models = {
							displayText = LocalizeToUpperString(0x3996BAAC73C3F6D),
						},
						properties = {
							action = function(f226_arg0, f226_arg1, f226_arg2, f226_arg3, f226_arg4)
								GoBack(f226_arg4, f226_arg2)
							end,
						},
					},
					{
						models = {
							displayText = LocalizeToUpperString(0x8BAF8C765361E1A),
						},
						properties = {
							action = function(f227_arg0, f227_arg1, f227_arg2, f227_arg3, f227_arg4)
								GoBack(f227_arg4, f227_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "DailyChallengeWarningOverlay"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f228_arg0, f228_arg1, f228_arg2, f228_arg3)
			return function(f229_arg0, f229_arg1)
				OpenSystemOverlay(f229_arg0, GoBack(f229_arg0, f229_arg1), f229_arg1, "InspectDailyChallengeOverlay", nil)
			end
		end,
	},
	InspectDailyChallengeOverlay = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_DailyChallengeFrame",
		categoryType = CoD.OverlayUtility.OverlayTypes.Notice,
		title = function(f230_arg0, f230_arg1)
			CoD.perController[f230_arg0].dailyChallengeInfo = CoD.ChallengesUtility.GetDailyChallenge(f230_arg0, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
			if not CoD.perController[f230_arg0].dailyChallengeInfo then
				return ""
			else
				return CoD.perController[f230_arg0].dailyChallengeInfo.challengeName
			end
		end,
		description = function(f231_arg0, f231_arg1)
			if not CoD.perController[f231_arg0].dailyChallengeInfo then
				return ""
			else
				return CoD.perController[f231_arg0].dailyChallengeInfo.challengeDescription
			end
		end,
		image = function(f232_arg0, f232_arg1)
			if not CoD.perController[f232_arg0].dailyChallengeInfo then
				return ""
			else
				return CoD.perController[f232_arg0].dailyChallengeInfo.image
			end
		end,
		fractionText = function(f233_arg0, f233_arg1)
			if not CoD.perController[f233_arg0].dailyChallengeInfo then
				return ""
			else
				local f233_local0 = CoD.perController[f233_arg0].dailyChallengeInfo
				return Engine[0xF9F1239CFD921FE](0x31CF0F51CCA3A27, f233_local0.currChallengeStatValue, f233_local0.targetVal)
			end
		end,
		progressPercentage = function(f234_arg0, f234_arg1)
			if not CoD.perController[f234_arg0].dailyChallengeInfo then
				return 0
			else
				return CoD.perController[f234_arg0].dailyChallengeInfo.percentComplete
			end
		end,
		rewardText = function(f235_arg0, f235_arg1)
			if not CoD.perController[f235_arg0].dailyChallengeInfo then
				return ""
			else
				return CoD.perController[f235_arg0].dailyChallengeInfo.rewardText
			end
		end,
		listDatasource = function()
			DataSources.InspectDailyChallengeOverlay = DataSourceHelpers.ListSetup("InspectDailyChallengeOverlay", function(f237_arg0)
				local f237_local0 = {}
				table.insert(f237_local0, {
					models = {
						displayText = LocalizeToUpperString(0x3996BAAC73C3F6D),
					},
					properties = {
						action = function(f238_arg0, f238_arg1, f238_arg2, f238_arg3, f238_arg4)
							GoBack(f238_arg4, f238_arg2)
						end,
					},
				})
				if Engine[0x440310E3919716](f237_arg0) then
					table.insert(f237_local0, {
						models = {
							displayText = LocalizeToUpperString(0x8BAF8C765361E1A),
						},
						properties = {
							action = function(f239_arg0, f239_arg1, f239_arg2, f239_arg3, f239_arg4)
								OpenSystemOverlay(f239_arg0, GoBack(f239_arg4, f239_arg2), f239_arg2, "DailyChallengeWarningOverlay", nil)
							end,
						},
					})
				end
				return f237_local0
			end, true, nil)
			return "InspectDailyChallengeOverlay"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	CraftNoChangesNotification = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x259DC0AE25F0626,
		description = 0x70A4BEE310634C1,
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f240_arg0)
			return function(f241_arg0, f241_arg1)
				CoD.CraftUtility.EmblemEditor_NoChangesAction(f241_arg0, f241_arg1)
				CoD.CraftUtility.Paintshop_ShowPreviewOfRecentlyEdited(f241_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xD8FF5E03592FD99,
	},
	CustomGamesNotification = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0xCD9D367AFD39C8B,
		description = function()
			if CoD.isWarzone then
				return 0xE49E17BA15E27B
			elseif LuaUtils.IsArenaMode() then
				return 0x4A917216574AD4C
			else
				return 0x6F3E57AE4BFB89D
			end
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.CustomGames,
		listDatasource = function()
			DataSources.CustomGamesNotification_List = DataSourceHelpers.ListSetup("CustomGamesNotification_List", function(f244_arg0)
				return {
					{
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xD8FF5E03592FD99)),
						},
						properties = {
							action = function(f245_arg0, f245_arg1, f245_arg2, f245_arg3, f245_arg4)
								GoBack(f245_arg4, f245_arg2)
								if not IsLobbyNetworkModeLAN() then
									CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode(f245_arg4, f245_arg2)
								else
									CoD.DirectorUtility.OfflineNavigateToCustomGames(f245_arg4, f245_arg2)
								end
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289)),
						},
						properties = {
							action = function(f246_arg0, f246_arg1, f246_arg2, f246_arg3, f246_arg4)
								GoBack(f246_arg4, f246_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "CustomGamesNotification_List"
		end,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f247_arg0)
			return function(f248_arg0, f248_arg1)
				GoBack(f248_arg0, f248_arg1)
				if not IsLobbyNetworkModeLAN() then
					CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode(f248_arg0, f248_arg1)
				else
					CoD.DirectorUtility.OfflineNavigateToCustomGames(f248_arg0, f248_arg1)
				end
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xD8FF5E03592FD99,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f249_arg0)
			return function(f250_arg0, f250_arg1)
				GoBack(f250_arg0, f250_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	CustomMutationsNotification = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x3B0E3BB0D43F91C,
		description = 0x5B29A99004A6B64,
		categoryType = CoD.OverlayUtility.OverlayTypes.CustomGames,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f251_arg0)
			return function(f252_arg0, f252_arg1)
				GoBack(f252_arg0, f252_arg1)
				if not IsLobbyNetworkModeLAN() then
					CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode(f252_arg0, f252_arg1)
				else
					CoD.DirectorUtility.OfflineNavigateToCustomGames(f252_arg0, f252_arg1)
				end
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xD8FF5E03592FD99,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f253_arg0)
			return function(f254_arg0, f254_arg1)
				GoBack(f254_arg0, f254_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	CampaignOfflineToOnlineWarning = {
		menuName = "SystemOverlay_Compact",
		title = 0x2FDFEFE692A50F6,
		description = 0xFE90E4CB2E73D0C,
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		listDatasource = function()
			DataSources.CampaignOfflineToOnlineWarning = DataSourceHelpers.ListSetup("CampaignOfflineToOnlineWarning", function(f256_arg0)
				return {
					{
						models = {
							displayText = 0xE209447B4A40C7B,
						},
						properties = {
							action = function(f257_arg0, f257_arg1, f257_arg2, f257_arg3, f257_arg4)
								GoBack(f257_arg4, f257_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "CampaignOfflineToOnlineWarning"
		end,
	},
	PublisherFilesChangedPopup = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x41A646FD4F798CE,
		description = 0x4E62FD61197D6DF,
		categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
		listDatasource = function()
			DataSources.PublisherFilesChangedPopup_List = DataSourceHelpers.ListSetup("PublisherFilesChangedPopup_List", function(f259_arg0)
				return {
					{
						models = {
							displayText = 0xE209447B4A40C7B,
						},
						properties = {
							action = function(f260_arg0, f260_arg1, f260_arg2, f260_arg3, f260_arg4)
								Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "pubstorageFilesChanged"), false)
								Engine[0xB177D654FFB67BE]("live_pubSemaphoreUserTriggerTime", Engine[0x9D33D652B9B0F3B]())
								Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92], "")
							end,
						},
					},
				}
			end, true, nil)
			return "PublisherFilesChangedPopup_List"
		end,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f261_arg0)
			return function()
				Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "pubstorageFilesChanged"), false)
				Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92], "")
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0x349737B0BDAA763,
	},
	RegistrationSuccess = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0xEF2EC2C66BFD57F),
		description = Engine[0xF9F1239CFD921FE](0x26B299D9492F452),
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		listDatasource = function()
			DataSources.RegistrationSuccess_List = DataSourceHelpers.ListSetup("RegistrationSuccess_List", function(f264_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1),
						},
						properties = {
							action = function(f265_arg0, f265_arg1, f265_arg2, f265_arg3, f265_arg4)
								CoD.MetricsUtility.AccountCreated(f265_arg0, f265_arg2, "1", "menu")
								FinishRegistrationFlow(f265_arg0, f265_arg2, f265_arg4)
							end,
						},
					},
				}
			end, true, nil)
			return "RegistrationSuccess_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function()
			return function(f267_arg0, f267_arg1)
				CoD.MetricsUtility.AccountCreated(f267_arg0, f267_arg1, "1", "menu")
				FinishRegistrationFlow(f267_arg0, f267_arg1, f267_arg0)
			end
		end,
	},
	OptInSuccess = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0xEF2EC2C66BFD57F),
		description = Engine[0xF9F1239CFD921FE](0x6745166A236B37F),
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		listDatasource = function()
			DataSources.OptInSuccess_List = DataSourceHelpers.ListSetup("OptInSuccess_List", function(f269_arg0)
				return {
					{
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1),
						},
						properties = {
							action = function(f270_arg0, f270_arg1, f270_arg2, f270_arg3, f270_arg4)
								CoD.MetricsUtility.AccountCreated(f270_arg0, f270_arg2, "1", "menu")
								FinishRegistrationFlow(f270_arg0, f270_arg2, f270_arg4)
							end,
						},
					},
				}
			end, true, nil)
			return "OptInSuccess_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function()
			return function(f272_arg0, f272_arg1)
				CoD.MetricsUtility.AccountCreated(f272_arg0, f272_arg1, "1", "menu")
				FinishRegistrationFlow(f272_arg0, f272_arg1, f272_arg0)
			end
		end,
	},
	ConfirmPCGraphicsChange = {
		menuName = "SystemOverlay_Compact",
		title = Engine[0xF9F1239CFD921FE](0xADB7C8A56882A8),
		description = 0x0,
		categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
		listDatasource = function()
			DataSources.ConfirmPCGraphicsChange_List = DataSourceHelpers.ListSetup("ConfirmPCGraphicsChange_List", function(f274_arg0)
				return {
					{
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xDFD294FC69F682)),
						},
						properties = {
							action = function(f275_arg0, f275_arg1, f275_arg2, f275_arg3, f275_arg4)
								CoD.PCOptionsUtility.ApplyAllPCChangedOptions(f275_arg0, f275_arg2)
								UpdateGamerprofile(f275_arg4, f275_arg1, f275_arg2)
								GoBackMultiple(f275_arg4, f275_arg2, 2)
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x5C16E02B211A4F4)),
						},
						properties = {
							action = function(f276_arg0, f276_arg1, f276_arg2, f276_arg3, f276_arg4)
								CoD.PCOptionsUtility.RevertPCHardwareChanges(f276_arg0, f276_arg2)
								GoBackMultiple(f276_arg4, f276_arg2, 2)
							end,
						},
					},
				}
			end, true, nil)
			return "ConfirmPCGraphicsChange_List"
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	ArenaEventDone = {
		menuName = "SystemOverlay_Compact",
		title = 0x71D55281FC93E48,
		description = 0x4851B928B356F90,
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.ArenaEventDone = DataSourceHelpers.ListSetup("ArenaEventDone", function(f278_arg0)
				return {
					{
						models = {
							displayText = 0xE209447B4A40C7B,
						},
						properties = {
							action = function(f279_arg0, f279_arg1, f279_arg2, f279_arg3, f279_arg4)
								local f279_local0 = Engine[0x8DF2E5447F384B9]()
								f279_local0 = f279_local0.Arena:create("triggerEndOfEvent")
								f279_local0:set(false)
								LobbyGoBack(f279_arg4, f279_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "ArenaEventDone"
		end,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f280_arg0)
			return function(f281_arg0, f281_arg1)
				local f281_local0 = Engine[0x8DF2E5447F384B9]()
				f281_local0 = f281_local0.Arena:create("triggerEndOfEvent")
				f281_local0:set(false)
				LobbyGoBack(f281_arg0, f281_arg1)
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0x349737B0BDAA763,
	},
	GenericPopup = {
		menuName = function(f282_arg0, f282_arg1, f282_arg2, f282_arg3, f282_arg4, f282_arg5, f282_arg6)
			if f282_arg0 == CoD.OverlayUtility.GenericPopupSizes.Small then
				return "SystemOverlay_Compact"
			elseif f282_arg0 == CoD.OverlayUtility.GenericPopupSizes.Large then
				return "SystemOverlay_Full"
			else
			end
		end,
		title = function(f283_arg0, f283_arg1, f283_arg2, f283_arg3, f283_arg4, f283_arg5, f283_arg6)
			return Engine[0xF9F1239CFD921FE](f283_arg1)
		end,
		description = function(f284_arg0, f284_arg1, f284_arg2, f284_arg3, f284_arg4, f284_arg5, f284_arg6)
			return Engine[0xF9F1239CFD921FE](f284_arg2)
		end,
		image = function(f285_arg0, f285_arg1, f285_arg2, f285_arg3, f285_arg4, f285_arg5, f285_arg6)
			if f285_arg3 and f285_arg3 ~= "" then
				return f285_arg3
			else
			end
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		listDatasource = function(f286_arg0, f286_arg1, f286_arg2, f286_arg3, f286_arg4, f286_arg5, f286_arg6)
			if f286_arg4 then
				local f286_local0 = "GenericPopup_" .. Engine[0xF9F1239CFD921FE](f286_arg1)
				DataSources[f286_local0] = DataSourceHelpers.ListSetup(f286_local0 .. "_List", function(f287_arg0)
					local f287_local0 = f286_arg5
					if not f287_local0 or type(f287_local0) ~= "function" then
						f287_local0 = CoD.OverlayUtility.DefaultButtonAction
					end
					return {
						{
							models = {
								displayText = Engine[0xF9F1239CFD921FE](f286_arg4),
							},
							properties = {
								action = f287_local0,
							},
						},
					}
				end, true, nil)
				return f286_local0
			else
			end
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f288_arg0, f288_arg1, f288_arg2, f288_arg3, f288_arg4, f288_arg5, f288_arg6)
			if f288_arg6 and type(f288_arg6) == "function" then
				return f288_arg6
			else
				return CoD.OverlayUtility.DefaultGoBack()
			end
		end,
		[CoD.OverlayUtility.aCrossPromptFn] = CoD.isPC and function(f289_arg0, f289_arg1, f289_arg2, f289_arg3, f289_arg4, f289_arg5, f289_arg6)
			if f289_arg6 and type(f289_arg6) == "function" then
				return f289_arg6
			else
				return CoD.OverlayUtility.DefaultGoBack()
			end
		end or nil,
		[CoD.OverlayUtility.aCrossPromptText] = CoD.isPC and 0x5BE4A02B20F31F1 or nil,
	},
	GenericModalDialog = {
		menuName = CoD.OverlayUtility.AutoSizeMenuFromDescription("GenericModalDialog"),
		title = function(f290_arg0, f290_arg1, f290_arg2, f290_arg3, f290_arg4)
			return Engine[0xF9F1239CFD921FE](f290_arg0)
		end,
		description = function(f291_arg0, f291_arg1, f291_arg2, f291_arg3, f291_arg4)
			return Engine[0xF9F1239CFD921FE](f291_arg1)
		end,
		image = function(f292_arg0, f292_arg1, f292_arg2, f292_arg3, f292_arg4)
			if f292_arg2 and f292_arg2 ~= "" then
				return f292_arg2
			else
			end
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		listDatasource = function(f293_arg0, f293_arg1, f293_arg2, f293_arg3, f293_arg4)
			local f293_local0 = "GenericModalDialog" .. f293_arg0
			DataSources[f293_local0] = DataSourceHelpers.ListSetup(f293_local0 .. "_List", function(f294_arg0)
				local f294_local0 = {}
				for f294_local4, f294_local5 in ipairs(f293_arg3) do
					table.insert(f294_local0, {
						models = {
							displayText = Engine[0xF9F1239CFD921FE](f294_local5),
						},
						properties = {
							action = function(f295_arg0, f295_arg1, f295_arg2, f295_arg3, f295_arg4)
								if not f293_arg4 or f293_arg4(f294_local4 - 1) then
									GoBack(f295_arg4, f295_arg2)
								end
							end,
						},
					})
				end
				return f294_local0
			end, true, nil)
			return f293_local0
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = function(f296_arg0, f296_arg1, f296_arg2, f296_arg3, f296_arg4)
			return function(f297_arg0, f297_arg1)
				if f296_arg4 then
					f296_arg4()
				end
				GoBack(f297_arg0, f297_arg1)
			end
		end,
	},
	LobbyLocalClientWarning = {
		menuName = CoD.OverlayUtility.AutoSizeMenuFromDescription("LobbyLocalClientWarning"),
		title = 0x641F00ACB6B36A3,
		description = 0xC0E964190DE7A7F,
		image = "",
		categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
		listDatasource = function(f298_arg0)
			DataSources.LobbyLocalClientWarningButtons = DataSourceHelpers.ListSetup("LobbyLocalClientWarningButtons", function()
				return {
					{
						models = {
							displayText = 0x6393FF34EA56966,
						},
						properties = {
							action = function(f300_arg0, f300_arg1, f300_arg2, f300_arg3, f300_arg4)
								GoBack(f300_arg4, f300_arg2)
								f298_arg0.disbandParty = true
								for f300_local0 = 1, Engine[0xB686A0A723E6442]() - 1, 1 do
									LobbyRemoveLocalClientFromLobby(f300_arg0, f300_local0)
								end
								if f298_arg0.navToMenu ~= nil then
									Engine[0x87AE7E64BA5AD61]("OnGoForward", f298_arg0)
								elseif f298_arg0.popupName ~= nil and f298_arg0.openFromMenu ~= nil then
									OpenPopup(f298_arg0.openFromMenu, f298_arg0.popupName, 0)
								elseif f298_arg0.actionFunc ~= nil then
									f298_arg0:actionFunc()
								end
							end,
						},
					},
					{
						models = {
							displayText = 0xC2E92C54C2BE289,
						},
						properties = {
							action = function(f301_arg0, f301_arg1, f301_arg2, f301_arg3, f301_arg4)
								if f301_arg4.occludedMenu and f301_arg4.occludedMenu.openOverlayAfterSpinner then
									f301_arg4.occludedMenu.openOverlayAfterSpinner = nil
								end
								GoBack(f301_arg4, f301_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "LobbyLocalClientWarningButtons"
		end,
	},
	CPMaxLevelNotification = {
		menuName = "SystemOverlay_Full",
		openMethod = CoD.OverlayUtility.OpenMethods.Overlay,
		frameWidget = "CoD.cpReachedMaxLevelOverlayFrame",
		maxRankName = function()
			return Engine[0xED84C33EC5F01EA](Engine[0x278F31E285A95F6](CoD.RankUtility.GetRankCap()))
		end,
		title = function()
			return CoD.OverlayUtility.Overlays.CPMaxLevelNotification.maxRankName()
		end,
		description = function()
			return Engine[0xF9F1239CFD921FE](0x419A32DAB47E460, CoD.OverlayUtility.Overlays.CPMaxLevelNotification.maxRankName())
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
	},
	AnticheatMessage = {
		menuName = "SystemOverlay_Full",
		title = Engine[0xF9F1239CFD921FE](0xED7AAC4B721DBBF),
		description = function(f305_arg0, f305_arg1, f305_arg2)
			return Engine[0xF9F1239CFD921FE](f305_arg0, f305_arg1)
		end,
		listDatasource = function(f306_arg0, f306_arg1, f306_arg2)
			DataSources.AnticheatMessageButtons = DataSourceHelpers.ListSetup("AnticheatMessageButtons", function(f307_arg0)
				local f307_local0 = f306_arg1
				local f307_local1 = f306_arg2
				local f307_local2 = {}
				if f307_local0 ~= "" then
					table.insert(f307_local2, {
						models = {
							displayText = Engine[0xF9F1239CFD921FE](0xA63CCA126DA271B),
						},
						properties = {
							action = OpenAnticheatPolicyInBrowser,
						},
					})
				end
				table.insert(f307_local2, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1),
					},
					properties = {
						action = f307_local1,
					},
				})
				return f307_local2
			end, true, nil)
			return "AnticheatMessageButtons"
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Error,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	},
	ArenaQuitNotification = {
		menuName = "SystemOverlay_FreeCursor",
		title = 0x41B605F57D89FA6,
		description = 0x9200F56C635FC35,
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		listDatasource = function()
			DataSources.ArenaQuitNotification_List = DataSourceHelpers.ListSetup("ArenaQuitNotification_List", function(f309_arg0)
				return {
					{
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xD8FF5E03592FD99)),
						},
						properties = {
							action = function(f310_arg0, f310_arg1, f310_arg2, f310_arg3, f310_arg4)
								GoBack(f310_arg4, f310_arg2)
								CoDShared.QuitGame(f310_arg2, not CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty(f310_arg2))
							end,
						},
					},
					{
						models = {
							displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xC2E92C54C2BE289)),
						},
						properties = {
							action = function(f311_arg0, f311_arg1, f311_arg2, f311_arg3, f311_arg4)
								GoBack(f311_arg4, f311_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "ArenaQuitNotification_List"
		end,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f312_arg0)
			return function(f313_arg0, f313_arg1)
				GoBack(f313_arg0, f313_arg1)
				CoDShared.QuitGame(f313_arg1, not CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty(f313_arg1))
			end
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xD8FF5E03592FD99,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f314_arg0)
			return function(f315_arg0, f315_arg1)
				GoBack(f315_arg0, f315_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0xC2E92C54C2BE289,
	},
	ReportPlayer = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_reportPlayer",
		xuid = function(f316_arg0, f316_arg1, f316_arg2)
			return f316_arg2.xuid
		end,
		gamertag = function(f317_arg0, f317_arg1, f317_arg2)
			return f317_arg2.gamertag
		end,
		clantag = function(f318_arg0, f318_arg1, f318_arg2)
			return f318_arg2.clantag
		end,
		emblemBacking = function(f319_arg0, f319_arg1, f319_arg2)
			return f319_arg2.emblemBacking
		end,
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		listDatasource = function(f320_arg0, f320_arg1, f320_arg2)
			local f320_local0 = f320_arg2.xuid
			local f320_local1 = f320_arg2.gamertag
			local f320_local2 = "uie_t7_icon_menu_options_dislike"
			DataSources.ReportOptions = DataSourceHelpers.ListSetup("ReportOptions", function(f321_arg0)
				local f321_local0 = Engine[0x3176B986956D1B3](f321_arg0, f320_local0)
				local f321_local1 = {}
				if not f321_local0 then
					table.insert(f321_local1, {
						models = {
							displayText = 0x6BD8567C603F5A3,
						},
						properties = {
							action = function(f322_arg0, f322_arg1, f322_arg2, f322_arg3, f322_arg4)
								CoD.MetricsUtility.ReportUser(f322_arg2, f320_local0, "offensive", 1, true)
								GoBack(f322_arg0, f322_arg2)
								CoD.OverlayUtility.ShowToast("Invite", Engine[0xED84C33EC5F01EA](0xE64954DBD80A7CF), f320_local1, f320_local2)
							end,
							actionParam = f320_local0,
						},
					})
				end
				table.insert(f321_local1, {
					models = {
						displayText = 0x5919C649561B63C,
					},
					properties = {
						action = function(f323_arg0, f323_arg1, f323_arg2, f323_arg3, f323_arg4)
							CoD.MetricsUtility.ReportUser(f323_arg2, f320_local0, "offensive_emblem", 1, true)
							GoBack(f323_arg0, f323_arg2)
							CoD.OverlayUtility.ShowToast("Invite", Engine[0xED84C33EC5F01EA](0x47FE6FBD71AF9CF), f320_local1, f320_local2)
						end,
						actionParam = f320_local0,
					},
				})
				table.insert(f321_local1, {
					models = {
						displayText = 0xCE324B8FB722A9B,
					},
					properties = {
						action = function(f324_arg0, f324_arg1, f324_arg2, f324_arg3, f324_arg4)
							CoD.MetricsUtility.ReportUser(f324_arg2, f320_local0, "offensive_paintjob", 1, true)
							GoBack(f324_arg0, f324_arg2)
							CoD.OverlayUtility.ShowToast("Invite", Engine[0xED84C33EC5F01EA](0x2FDE62E23ABC28), f320_local1, f320_local2)
						end,
						actionParam = f320_local0,
					},
				})
				if not f321_local0 then
					table.insert(f321_local1, {
						models = {
							displayText = 0x2519B57188045C6,
						},
						properties = {
							action = function(f325_arg0, f325_arg1, f325_arg2, f325_arg3, f325_arg4)
								CoD.MetricsUtility.ReportUser(f325_arg2, f320_local0, "cheater", 1, true)
								GoBack(f325_arg0, f325_arg2)
								CoD.OverlayUtility.ShowToast("Invite", Engine[0xED84C33EC5F01EA](0x33A182AC50FF0D2), f320_local1, f320_local2)
							end,
							actionParam = f320_local0,
						},
					})
					table.insert(f321_local1, {
						models = {
							displayText = 0x8D520440159326,
						},
						properties = {
							action = function(f326_arg0, f326_arg1, f326_arg2, f326_arg3, f326_arg4)
								CoD.MetricsUtility.ReportUser(f326_arg2, f320_local0, "greifer", 1, true)
								GoBack(f326_arg0, f326_arg2)
								CoD.OverlayUtility.ShowToast("Invite", Engine[0xED84C33EC5F01EA](0x1E6CE0A4E16A923), f320_local1, f320_local2)
							end,
							actionParam = f320_local0,
						},
					})
				end
				if CoD.isPC then
					table.insert(f321_local1, {
						models = {
							displayText = 0x6DA4540B4705513,
						},
						properties = {
							action = function(f327_arg0, f327_arg1, f327_arg2, f327_arg3, f327_arg4)
								GoBack(f327_arg4, f327_arg2)
							end,
						},
					})
				end
				return f321_local1
			end)
			return "ReportOptions"
		end,
	},
	SeasonPassUpsell = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_SeasonPassUpsellFrame",
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		title = Engine[0xF9F1239CFD921FE](0x280BEF7AE12F4AD),
		description = function(f328_arg0, f328_arg1)
			return Engine[0xF9F1239CFD921FE](f328_arg1._description)
		end,
		image = function(f329_arg0, f329_arg1)
			return CoD.StoreUtility.GetDLCImageByPlaylistId(f329_arg0, CoD.SafeGetModelValue(f329_arg1._model, "playlist"))
		end,
		listDatasource = function(f330_arg0, f330_arg1)
			DataSources.SeasonPassUpsellPopup = DataSourceHelpers.ListSetup("SeasonPassUpsellPopup", function(f331_arg0)
				return {
					{
						models = {
							displayText = 0xC19A0DEC8DA8D3,
						},
						properties = {
							action = function(f332_arg0, f332_arg1, f332_arg2, f332_arg3, f332_arg4)
								CoD.StoreUtility.OpenStoreToDLCPackByPlaylist(f332_arg0, CoD.SafeGetModelValue(f330_arg1._model, "playlist"), f332_arg2, "UpsellPopup", GoBack(f332_arg0, f332_arg2))
							end,
						},
					},
					{
						models = {
							displayText = 0xD9EEC9289F5517F,
						},
						properties = {
							action = function(f333_arg0, f333_arg1, f333_arg2, f333_arg3, f333_arg4)
								GoBack(f333_arg0, f333_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "SeasonPassUpsellPopup"
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xAC3B80C833B60E1,
	},
	DownloadDLC = {
		menuName = "SystemOverlay_Full",
		frameWidget = "CoD.systemOverlay_SeasonPassUpsellFrame",
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		title = Engine[0xF9F1239CFD921FE](0x42ABA837C21FB71),
		description = Engine[0xF9F1239CFD921FE](0x7A25AE1AC727D78),
		image = function(f334_arg0, f334_arg1)
			return CoD.StoreUtility.GetDLCImageByPlaylistId(f334_arg0, CoD.SafeGetModelValue(f334_arg1._model, "playlist"))
		end,
		listDatasource = function(f335_arg0, f335_arg1)
			DataSources.DownloadDLCPopup = DataSourceHelpers.ListSetup("DownloadDLCPopup", function(f336_arg0)
				return {
					{
						models = {
							displayText = 0x8CC9A0BBAA43937,
						},
						properties = {
							action = function(f337_arg0, f337_arg1, f337_arg2, f337_arg3, f337_arg4)
								CoD.StoreUtility.OpenStoreToDLCPackByPlaylist(f337_arg0, CoD.SafeGetModelValue(f335_arg1._model, "playlist"), f337_arg2, "UpsellPopup", GoBack(f337_arg0, f337_arg2))
							end,
						},
					},
					{
						models = {
							displayText = 0x7BED49E12BD1273,
						},
						properties = {
							action = function(f338_arg0, f338_arg1, f338_arg2, f338_arg3, f338_arg4)
								GoBack(f338_arg0, f338_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "DownloadDLCPopup"
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xAC3B80C833B60E1,
	},
	TrialVersionUpsell = {
		menuName = "SystemOverlay_Full",
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		title = Engine[0xF9F1239CFD921FE](0x89F50A5AB4EE929),
		description = function()
			return Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.trialOverlayDescription"))
		end,
		listDatasource = function()
			DataSources.TrialUpsellPopup = DataSourceHelpers.ListSetup("TrialUpsellPopup", function(f341_arg0)
				return {
					{
						models = {
							displayText = 0x9EF45921F4CD86C,
						},
						properties = {
							action = function(f342_arg0, f342_arg1, f342_arg2, f342_arg3, f342_arg4)
								OpenOverlay(f342_arg0, "Store", f342_arg2)
							end,
						},
					},
					{
						models = {
							displayText = 0x6DA4540B4705513,
						},
						properties = {
							action = function(f343_arg0, f343_arg1, f343_arg2, f343_arg3, f343_arg4)
								GoBack(f343_arg0, f343_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "TrialUpsellPopup"
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xAC3B80C833B60E1,
	},
	TrialNotAvailable = {
		menuName = "SystemOverlay_Full",
		categoryType = CoD.OverlayUtility.OverlayTypes.Unlock,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		title = 0x2B1FC9FD0435234,
		description = 0xB08A9FC8EFFADD1,
		listDatasource = function()
			DataSources.TrialNotAvailablePopup = DataSourceHelpers.ListSetup("TrialNotAvailablePopup", function(f345_arg0)
				return {
					{
						models = {
							displayText = 0x9EF45921F4CD86C,
						},
						properties = {
							action = function(f346_arg0, f346_arg1, f346_arg2, f346_arg3, f346_arg4)
								OpenOverlay(f346_arg0, "Store", f346_arg2)
							end,
						},
					},
					{
						models = {
							displayText = 0x6DA4540B4705513,
						},
						properties = {
							action = function(f347_arg0, f347_arg1, f347_arg2, f347_arg3, f347_arg4)
								GoBack(f347_arg0, f347_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "TrialNotAvailablePopup"
		end,
		[CoD.OverlayUtility.aCrossPromptText] = 0xAC3B80C833B60E1,
	},
	LobbyLeaveTrial = {
		menuName = "SystemOverlay_Full",
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		title = Engine[0xF9F1239CFD921FE](0xC31F6523A462DB6),
		description = function()
			return Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.trialOverlayDescription"))
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptText] = 0xAC3B80C833B60E1,
		listDatasource = function()
			DataSources.LobbyLeaveTrial = DataSourceHelpers.ListSetup("LobbyLeaveTrial", function(f350_arg0)
				return {
					{
						models = {
							displayText = 0x7C57347FF991141,
						},
						properties = {
							action = function(f351_arg0, f351_arg1, f351_arg2, f351_arg3, f351_arg4)
								Engine[0xC419886DCFCE74A](f351_arg2)
								GoBack(f351_arg0, f351_arg2)
							end,
						},
					},
					{
						models = {
							displayText = 0x9A8A3365AB81AFC,
						},
						properties = {
							action = function(f352_arg0, f352_arg1, f352_arg2, f352_arg3, f352_arg4)
								Engine[0x4DAF7B02664BF69](f352_arg2)
								GoBack(f352_arg0, f352_arg2)
							end,
						},
					},
					{
						models = {
							displayText = 0x6DA4540B4705513,
						},
						properties = {
							action = function(f353_arg0, f353_arg1, f353_arg2, f353_arg3, f353_arg4)
								GoBack(f353_arg0, f353_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "LobbyLeaveTrial"
		end,
	},
	LobbyLeaveInvalidPlayers = {
		menuName = "SystemOverlay_Full",
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		title = Engine[0xF9F1239CFD921FE](0xB69F71ABEAEC777),
		description = function()
			return Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.trialOverlayDescription"))
		end,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		[CoD.OverlayUtility.aCrossPromptText] = 0xAC3B80C833B60E1,
		listDatasource = function(f355_arg0)
			DataSources.LobbyLeaveInvalidPlayers = DataSourceHelpers.ListSetup("LobbyLeaveInvalidPlayers", function(f356_arg0)
				return {
					{
						models = {
							displayText = 0x7C57347FF991141,
						},
						properties = {
							action = function(f357_arg0, f357_arg1, f357_arg2, f357_arg3, f357_arg4)
								Engine[0xC419886DCFCE74A](f357_arg2)
								GoBack(f357_arg0, f357_arg2)
							end,
						},
					},
					{
						models = {
							displayText = 0x4BB600B618F65E3,
						},
						properties = {
							action = function(f358_arg0, f358_arg1, f358_arg2, f358_arg3, f358_arg4)
								if f355_arg0.removeTrial then
									Engine[0x4DAF7B02664BF69](f358_arg2)
								end
								if f355_arg0.removeKoreanUnderage then
									Engine[0xA31028790AF1818](f358_arg2)
								end
								if f355_arg0.removeLimitedNoZM then
									Engine[0x3A15B7FFA141651](f358_arg2)
								end
								GoBack(f358_arg0, f358_arg2)
							end,
						},
					},
					{
						models = {
							displayText = 0x6DA4540B4705513,
						},
						properties = {
							action = function(f359_arg0, f359_arg1, f359_arg2, f359_arg3, f359_arg4)
								GoBack(f359_arg0, f359_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "LobbyLeaveInvalidPlayers"
		end,
	},
	LobbyLeaveZMOfflineCustom = {
		menuName = "SystemOverlay_FreeCursor",
		categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
		title = Engine[0xF9F1239CFD921FE](0xC31F6523A462DB6),
		description = "",
		[CoD.OverlayUtility.aCrossPromptText] = 0xF420F9DB5188F96,
		[CoD.OverlayUtility.aCrossPromptFn] = function(f360_arg0)
			return function(f361_arg0, f361_arg1)
				GoBack(f361_arg0, f361_arg1)
				CoD.ZombieUtility.SetZMOfflineScreenStateToPrivate(f361_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptFn] = function(f362_arg0)
			return function(f363_arg0, f363_arg1)
				GoBack(f363_arg0, f363_arg1)
			end
		end,
		[CoD.OverlayUtility.bCirclePromptText] = 0x6DA4540B4705513,
	},
})
CoD.OverlayUtility.AddSystemOverlay = function(f364_arg0, f364_arg1)
	if LUI.DEV and CoD.OverlayUtility.Overlays[f364_arg0] then
		LUI.DEV.PrintCallstack("Overlay " .. f364_arg0 .. " already exists. Overwritting.")
	end
	CoD.OverlayUtility.Overlays[f364_arg0] = f364_arg1
end
CoD.OverlayUtility.OverlayCloseMethod = function(f365_arg0, f365_arg1)
	return function()
		ClearMenuSavedState(f365_arg0)
		if f365_arg0.overlayModelName then
			local f366_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f365_arg1), f365_arg0.overlayModelName)
			if f366_local0 then
				Engine[0x8C7A8C4C5FD9892](f366_local0)
			end
		end
		if CoD.isPC then
			CoD.PCUtility.UnlockUIShortcutInput(f365_arg0, f365_arg1)
		end
	end
end
CoD.OverlayUtility.RefreshOverlayModels = function(f367_arg0, f367_arg1, f367_arg2)
	for f367_local4, f367_local5 in ipairs(CoD.OverlayUtility.OverlayModelFields) do
		local f367_local3 = nil
		local f367_local6 = Engine[0xA798E4552F5E872](f367_arg0, f367_local5)
		f367_local3 = CoD.OverlayUtility.callFnOrGetValue(f367_arg1[f367_local5], f367_arg2)
		if not f367_local3 and CoD.OverlayUtility.DefaultModelFields[f367_local5] then
			f367_local3 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.DefaultModelFields[f367_local5], {
				f367_arg1,
				f367_arg2,
			})
		end
		if f367_local3 ~= nil then
			Engine[0x83C9B5DE1D9371](f367_local6, f367_local3)
		end
	end
end
CoD.OverlayUtility.RefreshOverlayProperties = function(f368_arg0, f368_arg1, f368_arg2)
	for f368_local4, f368_local5 in ipairs(CoD.OverlayUtility.OverlayPropertyFields) do
		local f368_local3 = nil
		f368_local3 = CoD.OverlayUtility.callFnOrGetValue(f368_arg1[f368_local5], f368_arg2)
		if not f368_local3 and CoD.OverlayUtility.DefaultPropertyFields[f368_local5] then
			f368_local3 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.DefaultPropertyFields[f368_local5], {
				f368_arg1,
				f368_arg2,
			})
		end
		f368_arg0[f368_local5] = f368_local3
	end
end
CoD.OverlayUtility.RefreshOverlayPrompts = function(f369_arg0, f369_arg1, f369_arg2)
	for f369_local5, f369_local6 in pairs(CoD.OverlayUtility.ButtonPromptsFields) do
		local f369_local7 = f369_arg0.buttonModel[f369_local5]
		if f369_local7 then
			local f369_local3 = nil
			f369_local3 = CoD.OverlayUtility.callFnOrGetValue(f369_arg1[f369_local6], f369_arg2)
			if not f369_local3 and CoD.OverlayUtility.DefaultPropertyFields[f369_local6] then
				f369_local3 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.DefaultPropertyFields[f369_local6], {
					f369_arg1,
					f369_arg2,
				})
			end
			local f369_local4 = f369_local7:create("overlayLabel")
			f369_local4:set(CoD.BaseUtility.LocalizeIfXHash(f369_local3) or "")
			f369_local7.Label:forceNotifySubscriptions()
		end
	end
end
CoD.OverlayUtility.RefreshOverlayDataFunction = function(f370_arg0, f370_arg1)
	return function()
		CoD.OverlayUtility.RefreshOverlayModels(f370_arg0:getModel(), CoD.OverlayUtility.Overlays[f370_arg0.menuName], f370_arg1)
		CoD.OverlayUtility.RefreshOverlayProperties(f370_arg0, CoD.OverlayUtility.Overlays[f370_arg0.menuName], f370_arg1)
		CoD.OverlayUtility.RefreshOverlayPrompts(f370_arg0, CoD.OverlayUtility.Overlays[f370_arg0.menuName], f370_arg1)
	end
end
CoD.OverlayUtility.OpenPublisherFilesChangedOverlay = function(f372_arg0, f372_arg1)
	if CoD.OverlayUtility.HasOpenedPublisherFilesChangedOverlay then
		return
	else
		CoD.OverlayUtility.HasOpenedPublisherFilesChangedOverlay = true
		LUI.OverrideFunction_CallOriginalFirst(CoD.OverlayUtility.CreateOverlay(f372_arg0, f372_arg1, "PublisherFilesChangedPopup"), "close", function(element)
			CoD.OverlayUtility.HasOpenedPublisherFilesChangedOverlay = nil
		end)
	end
end
CoD.OverlayUtility.CreateConnectionErrorOverlay = function(f374_arg0, f374_arg1, f374_arg2)
	local f374_local0 = ""
	local f374_local1 = 0x31E422BC40B2429
	if f374_arg2 == false then
		f374_local0 = 0xB2AE7971531C126
	elseif Dvar[0xBA976FA45F7D3C]:get() then
		f374_local0 = 0x14C0DA3363E75CB
	else
		local f374_local2, f374_local3 = Engine[0x50D07ABC7D13586](f374_arg0, CoD.SYSINFO_CONNECTIVITY_INFO)
		f374_local0 = Engine[0xF9F1239CFD921FE](0x632F97C36A01BD6) .. "\n\n" .. Engine[0xF9F1239CFD921FE](0xDBD2D992E939135, f374_local2 .. "\n" .. Engine[0x979890CEFD94F11](f374_arg0))
		if f374_arg1 == "Menu.Main" then
			f374_local1 = 0xD8301725C955017
		end
		if false == Engine[0x573048F8D3B4E25]() then
			f374_local0 = f374_local0 .. "\n\n\tDEBUG INFO:\n" .. f374_local3
		end
	end
	if not Engine[0xE39F1F30B306065]() then
		local f374_local2, f374_local3, f374_local4, f374_local5 = Engine[0x4DC3A644148CFC](f374_arg0)
		if f374_local5 then
			local f374_local6 = Engine[0x8506F73B393062F](1)
			local f374_local7 = Engine[0x8506F73B393062F](0)
			for f374_local8 = 0, f374_local4, 1 do
				if f374_local2 & f374_local6 << f374_local8 == f374_local7 then
					local f374_local11 = "alphabetSoup_"
					if f374_local8 < 26 then
						f374_local11 = f374_local11 .. string.char(string.byte("A") + f374_local8)
					else
						f374_local11 = f374_local11 .. string.char(string.byte("a") + f374_local8 - 26)
					end
					Engine[0xF5111961D03A0F5](f374_local11, 1)
				end
			end
		end
	end
	CoD.LobbyUtility.FailedDWConnection = true
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), true)
	LuaUtils.UI_ShowErrorMessageDialog(f374_arg0, f374_local0, f374_local1)
end
CoD.OverlayUtility.CreateOverlay = function(f375_arg0, f375_arg1, f375_arg2, ...)
	local f375_local0 = nil
	local f375_local1 = {
		n = select("#", ...),
		...,
	}
	local f375_local2 = function(f376_arg0, f376_arg1)
		for f376_local4, f376_local5 in ipairs(CoD.OverlayUtility.OverlayModelFields) do
			local f376_local3 = nil
			local f376_local6 = Engine[0xA798E4552F5E872](f376_arg0, f376_local5)
			if type(f376_arg1[f376_local5]) == "function" then
				f376_local3 = f376_arg1[f376_local5](unpack(f375_local1))
			else
				f376_local3 = f376_arg1[f376_local5]
			end
			if not f376_local3 and CoD.OverlayUtility.DefaultModelFields[f376_local5] then
				f376_local3 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.DefaultModelFields[f376_local5], {
					f376_arg1,
					f375_local1,
				})
			end
			if f376_local3 ~= nil then
				Engine[0x83C9B5DE1D9371](f376_local6, f376_local3)
			end
		end
	end
	if CoD.OverlayUtility.Overlays[f375_arg2] then
		local f375_local3 = CoD.OverlayUtility.Overlays[f375_arg2]
		local f375_local4 = CoD.OverlayUtility.callFnOrGetValue(f375_local3.menuName, f375_local1)
		if f375_local4 then
			if CoD.Menu.ModelToUse then
				CoD.OverlayUtility.RefreshOverlayModels(CoD.Menu.ModelToUse, f375_local3, f375_local1)
			end
			CoD.Menu.OverwriteMenuName = f375_arg2
			if CoD.isPC and f375_arg1.pcQuitOverlayActive and f375_arg2 ~= "QuitPCGamePopup" and f375_arg1.occludedBy and f375_arg1.occludedBy.menuName == "QuitPCGamePopup" then
				PerformOverlayBack(f375_arg1.occludedBy, f375_arg0)
			end
			if not f375_local3.openMethod or f375_local3.openMethod == CoD.OverlayUtility.OpenMethods.Popup then
				f375_local0 = OpenPopup(f375_arg1, f375_local4, f375_arg0)
			elseif f375_local3.openMethod == CoD.OverlayUtility.OpenMethods.Overlay then
				f375_local0 = OpenOverlay(f375_arg1, f375_local4, f375_arg0)
			end
			CoD.Menu.OverwriteMenuName = nil
			if f375_local0 then
				if CoD.isPC then
					CoD.PCUtility.LockUIShortcutInput(f375_local0, f375_arg0)
				end
				f375_local0.refreshData = CoD.OverlayUtility.RefreshOverlayDataFunction(f375_local0, f375_local1)
				CoD.OverlayUtility.RefreshOverlayProperties(f375_local0, f375_local3, f375_local1)
				CoD.OverlayUtility.RefreshOverlayPrompts(f375_local0, f375_local3, f375_local1)
				if f375_local3.preCreateStep then
					f375_local3.preCreateStep(f375_local0, f375_arg0, unpack(f375_local1))
				end
				if not f375_local0:getModel() then
					f375_local0.overlayModelName = "Overlay." .. f375_arg2
					local f375_local5 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f375_arg0), f375_local0.overlayModelName)
					CoD.OverlayUtility.RefreshOverlayModels(f375_local5, f375_local3, f375_local1)
					f375_local0:setModel(f375_local5, f375_arg0)
				end
				LUI.OverrideFunction_CallOriginalFirst(f375_local0, "close", CoD.OverlayUtility.OverlayCloseMethod(f375_local0, f375_arg0))
				if f375_local3.postCreateStep then
					f375_local3.postCreateStep(f375_local0, f375_arg0)
				end
				f375_local0:UpdateAllButtonPrompts(f375_arg0)
				if (f375_local4 == "SystemOverlay_FreeCursor" or f375_local4 == "SystemOverlay_MessageDialog" or f375_local4 == "SystemOverlay_FreeCursor_Full" or f375_local4 == "SystemOverlay_MessageDialogFull") and not f375_local3.allowFreeCursor then
					MenuHidesFreeCursor(f375_local0, f375_arg0)
				end
			end
		end
	end
	return f375_local0
end
DataSourceHelpers.PerControllerDataSourceSetup("FrontendToast", "FrontendToast", function(f377_arg0, f377_arg1)
	local f377_local0 = f377_arg0:create("state")
	f377_local0:set("DefaultState")
	f377_local0 = f377_arg0:create("kicker")
	f377_local0:set("")
	f377_local0 = f377_arg0:create("description")
	f377_local0:set("")
	f377_local0 = f377_arg0:create("contentIcon")
	f377_local0:set(0x7615068F50B3D66)
	f377_local0 = f377_arg0:create("functionIcon")
	f377_local0:set(0x7615068F50B3D66)
	f377_local0 = f377_arg0:create("emblemDecal")
	f377_local0:set(0)
	f377_local0 = f377_arg0:create("category")
	f377_local0:set("")
	f377_arg0:create("notify")
end, false)
CoD.OverlayUtility.ShowToast = function(f378_arg0, f378_arg1, f378_arg2, f378_arg3, f378_arg4, f378_arg5, f378_arg6, f378_arg7)
	local f378_local0 = function(f379_arg0)
		if f379_arg0 and type(f379_arg0) ~= "xhash" then
			f379_arg0 = Engine[0xC53F8D38DF9042B](f379_arg0)
		end
		return f379_arg0
	end
	local f378_local1 = DataSources.FrontendToast.getModel(Engine[0xA5B9C0111291A8B]())
	f378_local1.state:set(f378_arg0 or "DefaultState")
	f378_local1.kicker:set(f378_arg1 or "")
	f378_local1.description:set(f378_arg2 or "")
	f378_local1.contentIcon:set(f378_local0(f378_arg3) or 0x7615068F50B3D66)
	f378_local1.functionIcon:set(f378_local0(f378_arg4) or 0x7615068F50B3D66)
	f378_local1.emblemDecal:set(f378_arg5 or 0)
	f378_local1.category:set(f378_arg7 or "")
	f378_local1.notify:set(true)
end
CoD.OverlayUtility.HasOverlayACrossAction = function(f380_arg0)
	return f380_arg0[CoD.OverlayUtility.aCrossPromptFn] ~= nil
end
CoD.OverlayUtility.PerformOverlayACrossAction = function(f381_arg0, f381_arg1)
	f381_arg0[CoD.OverlayUtility.aCrossPromptFn](f381_arg0, f381_arg1)
end
CoD.OverlayUtility.HasOverlayBCircleAction = function(f382_arg0)
	return f382_arg0[CoD.OverlayUtility.bCirclePromptFn] ~= nil
end
CoD.OverlayUtility.PerformOverlayBCircleAction = function(f383_arg0, f383_arg1)
	f383_arg0[CoD.OverlayUtility.bCirclePromptFn](f383_arg0, f383_arg1)
end
CoD.OverlayUtility.HasOverlayXSquareAction = function(f384_arg0)
	return f384_arg0[CoD.OverlayUtility.xSquarePromptFn] ~= nil
end
CoD.OverlayUtility.PerformOverlayXSquareAction = function(f385_arg0, f385_arg1)
	f385_arg0[CoD.OverlayUtility.xSquarePromptFn](f385_arg0, f385_arg1)
end
CoD.OverlayUtility.HasOverlayYTriangleAction = function(f386_arg0)
	return f386_arg0[CoD.OverlayUtility.yTrianglePromptFn] ~= nil
end
CoD.OverlayUtility.PerformOverlayYTriangleAction = function(f387_arg0, f387_arg1)
	f387_arg0[CoD.OverlayUtility.yTrianglePromptFn](f387_arg0, f387_arg1)
end
CoD.OverlayUtility.SystemOverlayPreLoad = function(f388_arg0, f388_arg1)
	local f388_local0 = DataSources.MessageDialog.getModel(f388_arg1)
	local f388_local1 = CoD.SafeGetModelValue(f388_local0, "controller")
	if CoD.SafeGetModelValue(f388_local0, "anyControllerAllowed") == true then
		f388_arg0.anyControllerAllowed = true
	elseif f388_local1 ~= nil then
		f388_arg0:setOwner(f388_local1)
		f388_arg0.anyControllerAllowed = false
	end
	f388_arg0.unusedControllerAllowed = true
end
CoD.OverlayUtility.SystemOverlayPostLoad = function(f389_arg0, f389_arg1)
	f389_arg0.disableBlur = true
	local f389_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.MessageDialog.getModel(f389_arg1), "message"))
	if f389_local0 ~= nil then
		if type(f389_local0) == "xhash" then
			f389_local0 = Engine[0xF9F1239CFD921FE](f389_local0)
		end
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "MessageDialogBox: Opened with '" .. f389_local0 .. "'.\n")
	else
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "MessageDialogBox: Opened with no message.\n")
	end
end
CoD.OverlayUtility.AnimateInFromOffset = function(f390_arg0, f390_arg1)
	f390_arg0.animateInFromOffset = f390_arg1
end
CoD.OverlayUtility.DisableBlur = function(f391_arg0)
	f391_arg0.disableBlur = true
end
CoD.OverlayUtility.DisablePopupOpenCloseAnim = function(f392_arg0)
	f392_arg0.disablePopupOpenCloseAnim = true
end
