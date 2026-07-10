require("x64:247a72681127259")
if CoD.isPC then
	require("x64:cfcd4cb80781b03")
end
if LUI.DEV ~= nil then
	require("x64:501c64f03fcbffe")
end
DataSources.InitControllerModelsAndSubscriptions()
local f0_local0 = Engine[@"getglobalmodel"]()
f0_local0:create("lobbyRoot.gameClient.update", true)
f0_local0 = Engine[@"getglobalmodel"]()
f0_local0:create("lobbyRoot.gameClient.isHost", true)
if CoD.isFrontend then
	require("x64:2dd4ff313102b79")
	require("x64:6eee5926f63b60b")
	LUI.createMenu.main = function()
		local f1_local0 = Engine[@"getmaxcontrollercount"]()
		for f1_local1 = 0, f1_local0 - 1, 1 do
			Engine[@"lockinput"](f1_local1, true)
			Engine[@"setuiactive"](f1_local1, true)
		end
		CoD.VideoStreamingUtility.StartLiveEventFromData({
			liveEventStreamerIndex = Dvar[@"currentliveevent"]:get(),
		})
		local f1_local1 = CoD.Menu.NewFromState("main", nil, 0, 1, 0, 0, 0, 1, 0, 0)
		f1_local1._elementsThatCloseOnReload = {}
		f1_local1.addElementThatClosesOnReload = function(f2_arg0, f2_arg1)
			f2_arg0:addElement(f2_arg1)
			table.insert(f2_arg0._elementsThatCloseOnReload, f2_arg1)
		end
		f1_local1.closeElementsThatCloseOnReload = function(f3_arg0)
			for f3_local3, f3_local4 in ipairs(f3_arg0._elementsThatCloseOnReload) do
				f3_local4:close()
			end
			f3_arg0._elementsThatCloseOnReload = {}
		end
		f1_local1.ignoreCursor = true
		f1_local1.anyChildUsesUpdateState = true
		f1_local1:setPriority(9999)
		f1_local1:processEvent({
			name = "menu_loaded",
		})
		Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "MapVote", true), "mapVoteMapNext", true)
		local f1_local3 = function(f4_arg0, f4_arg1, f4_arg2)
			f4_arg0:closeElementsThatCloseOnReload()
			local f4_local0 = CoD.ToastNotification.new(f4_arg0, f4_arg1, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
			f4_local0:setState(f4_arg1, "DefaultState")
			f4_arg0:addElementThatClosesOnReload(f4_local0)
			local f4_local1 = CoD.Spinner.new(f4_arg0, f4_arg1, 0, 0, 0, CoD.Spinner.__defaultWidth, 0, 0, 0, CoD.Spinner.__defaultHeight)
			f4_arg0:addElementThatClosesOnReload(f4_local1)
			f4_local1:setLeftRight(0, 1, 0, 0)
			f4_local1:setTopBottom(0, 1, 0, 0)
			f4_local1:processEvent({
				name = "update_state",
				menu = f4_arg0,
				controller = f4_arg1,
				forceDispatch = true,
			})
			f4_arg0:sendInitializationEvents(f4_arg1, f4_local1)
			if CoD.MatchStartWarning then
				local f4_local2 = CoD.MatchStartWarning.new(f4_arg0, f4_arg1, 0, 1, 0, 0, 0, 0, 0, CoD.MatchStartWarning.__defaultHeight)
				f4_local2:setLeftRight(0, 1, 0, 0)
				f4_arg0:addElementThatClosesOnReload(f4_local2)
				f4_arg0:sendInitializationEvents(f4_arg1, f4_local2)
			end
			if Engine[@"usingfreecursor"]() then
				local f4_local2 = LUI.createMenu.FreeCursor(f4_arg1)
				f4_local2:setPriority(1000)
				f4_local2:menuOpened(f4_arg1, f4_local2)
				if f4_arg2 then
					local f4_local3 = Engine[@"getmodelforcontroller"](f4_arg1)
					f4_local3.FreeCursor.hidden:set(1)
					local f4_local4 = f4_local3.FreeCursor:create("ignoreNextMenuHides")
					f4_local4:set(true)
				end
				f4_arg0:addElementThatClosesOnReload(f4_local2)
			end
			f4_arg0:setOwner(f4_arg1)
			CoD.BaseUtility.SubscribeToMessageDialogBox(f4_arg0, f4_arg1)
			f4_arg0.MainOverlay = CoD.MainOverlay.new(f4_arg0, 0, 0, 1, 0, 0, 0, 1, 0, 0)
			f4_arg0.MainOverlay:setPriority(1000)
			f4_arg0:addElementThatClosesOnReload(f4_arg0.MainOverlay)
			f4_arg0:sendInitializationEvents(f4_arg1, f4_arg0.MainOverlay)
			f4_arg0.waitForUI3DTimer = LUI.UITimer.newElementTimer(200, false, function()
				if Engine[@"hash_17D6FD4F19566B8A"]() then
					f4_arg0:addElementThatClosesOnReload(CoD.DirectorTagsUI3D.new(f4_arg0, f4_arg1, 0, 0, 0, CoD.DirectorTagsUI3D.__defaultWidth, 0, 0, 0, CoD.DirectorTagsUI3D.__defaultHeight))
					f4_arg0.waitForUI3DTimer:close()
					f4_arg0.waitForUI3DTimer = nil
				end
			end)
			f4_arg0:addElement(f4_arg0.waitForUI3DTimer)
			if f4_arg0._menuMusicSub then
				f4_arg0:removeSubscription(f4_arg0._menuMusicSub)
			end
			local f4_local3 = f4_arg0
			local f4_local2 = f4_arg0.subscribeToModel
			local f4_local4 = Engine[@"getmodelforcontroller"](f4_arg1)
			f4_arg0._menuMusicSub = f4_local2(f4_local3, f4_local4.MenuMusic, function(f6_arg0)
				local f6_local0 = f6_arg0.musicStateName:get()
				local f6_local1 = f6_arg0.delayInMS:get()
				if f6_local0 ~= "" then
					if f4_arg0._menuMusicTimer then
						f4_arg0._menuMusicTimer:close()
						f4_arg0._menuMusicTimer = nil
					end
					f4_arg0._menuMusicTimer = LUI.UITimer.newElementTimer(f6_local1, true, function()
						Engine[@"playmenumusic"](f6_local0)
					end)
					f4_arg0:addElement(f4_arg0._menuMusicTimer)
				elseif f4_arg0._menuMusicTimer then
					f4_arg0._menuMusicTimer:close()
					f4_arg0._menuMusicTimer = nil
				end
			end, false)
		end
		local f1_local4 = Engine[@"getprimarycontroller"]()
		f1_local3(f1_local1, f1_local4, true)
		f1_local1:registerEventHandler("debug_reload", function(element, event)
			element:closeElementsThatCloseOnReload()
			element:removeAllChildren()
			f1_local3(f1_local1, f1_local4, false)
		end)
		LUI.OverrideFunction_CallOriginalSecond(f1_local1, "close", function(element)
			element.toastNotification:close()
		end)
		if CoD.isPC then
			CoD.PCUtility.RegisterPlaytimeLeftWatcher(f1_local1)
		end
		CoD.mainMenu = f1_local1
		return f1_local1
	end
else
	require("x64:a5e5b699e3c7636")
	require("x64:bb976bfdb29267")
	local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7 = nil
	local f0_local8 = 10
	local f0_local9 = nil
	local f0_local10 = false
	EnableGlobals()
	function HUD_IngameMenuClosed()
		f0_local9 = nil
	end
	function HUD_DelayLoadMenus()
		if f0_local10 then
			return
		end
		DebugPrint("Loading HUD menus")
		f0_local10 = true
		if CoD.isCampaign then
			require("x64:a60cfdff30b341a")
			require("x64:ad86e26de1fa54e")
		elseif CoD.isZombie then
			require("x64:cb5bf4e094259d8")
			require("x64:19c89699d4ccb93")
			require("x64:9aedfb02e1b42ad")
			if Engine[@"getcurrentmap"]() == "zm_zod" then
				require("x64:2532ef6b6f817cc")
				require("x64:e78fa14df4f0af7")
				require("x64:5f43e319e75b4d8")
				require("x64:bba34780c0a9b3e")
				require("x64:14acbde4348bf2e")
				require("x64:813c164dd9d9b1d")
			elseif Engine[@"getcurrentmap"]() == "zm_factory" then
				require("x64:e096ca64b60431f")
			elseif Engine[@"getcurrentmap"]() == "zm_castle" then
				require("x64:82fa79a45ef9936")
			elseif Engine[@"getcurrentmap"]() == "zm_island" then
				require("x64:e00202699294517")
			else
				require("x64:1824fcd24cd5764")
			end
		elseif CoD.isWarzone then
			require("x64:8f9e828ebdeac4c")
			require("x64:be322a54ff91a9a")
			require("x64:9aedfb02e1b42ad")
			require("x64:ad86e26de1fa54e")
		else
			require("x64:eb491e34e330ae0")
			require("x64:6b7fc557f641386")
			require("x64:f1b9c001eb57aa3")
			require("x64:be322a54ff91a9a")
			require("x64:7c614e146b5eea5")
			require("x64:9aedfb02e1b42ad")
			require("x64:ad86e26de1fa54e")
		end
	end
	if CoD.isCampaign or Engine[@"getcurrentmap"]() == "zm_zod" then
		HUD_DelayLoadMenus()
	end
	local f0_local11 = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if f12_arg3 and f12_arg0.vehicleHUD then
			f12_arg2 = f12_arg0.vehicleHUD.vehicleType
		end
		if f12_arg0.vehicleHUD then
			if (f12_arg0.vehicleHUD.vehicleType == f12_arg2 or CoD.isPC and f12_arg2 ~= 0x0) and not f12_arg3 then
				return
			end
			f12_arg0.vehicleHUD:close()
			f12_arg0.vehicleHUD = nil
			Engine[@"disablescenefilter"](f12_arg0:getOwner(), 4)
			DataSources.VehicleInfo.resetVehicleModels(f12_arg1)
		end
		if not f12_arg2 or f12_arg2 == "" then
			return
		elseif Engine[@"isvisibilitybitset"](f12_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]) then
			return
		elseif CoD.CodCasterUtility.CodCasterIsInAerialCam(f12_arg1) then
			return
		end
		local f12_local0 = CoD.VehicleUtility.GetVehicleHudInfo(f12_arg0, f12_arg1, f12_arg2)
		if not f12_local0 then
			return
		end
		local f12_local1 = LUI.createMenu[f12_local0.hudName]
		if f12_local1 then
			DataSources.VehicleInfo.setupVehicleModels(f12_arg1, f12_local0)
			if CoD.isWarzone then
				local f12_local2 = DataSources.VehicleInfo.getModel(f12_arg1)
				f12_local2 = f12_local2.hidePlayerInfo
				if f12_local2 and f12_local2:get() then
					CoD.WZUtility.CloseQuickAccessInventory(f12_arg0, f12_arg1)
				end
			end
			f12_arg0.vehicleHUD = f12_local1(f12_arg1)
			f12_arg0.vehicleHUD:setPriority(-10)
			f12_arg0.vehicleHUD.vehicleType = f12_arg2
			f12_arg0.vehicleHUD:setLeftRight(0, 1, 0, 0)
			f12_arg0.vehicleHUD:setTopBottom(0, 1, 0, 0)
			f12_arg0.vehicleHUD:setModel(DataSources.VehicleInfo.getModel(f12_arg1), f12_arg1)
			f12_arg0:addForceClosedChild(f12_arg0.vehicleHUD, "vehicleHUD")
			f12_arg0.vehicleHUD:menuOpened(f12_arg1, f12_arg0.vehicleHUD)
		end
	end
	local f0_local12 = function(f13_arg0, f13_arg1)
		local f13_local0 = true
		if IsCampaign() then
			local f13_local1 = false
			local f13_local2 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f13_arg1), "safehouse")
			if f13_local2 then
				f13_local1 = CoD.SafeGetModelValue(f13_local2, "inTrainingSim") == 1
			end
		end
		local f13_local1 = DataSources.VehicleInfo.getModel(f13_arg1)
		if f13_local1.vehicleType:get() == "killcamVehicle" then
			f13_local0 = false
		end
		if Engine[@"isvisibilitybitset"](f13_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]) then
			f13_local0 = false
		end
		f13_arg0.reticleVisible = f13_local0
		if f13_arg0.reticle then
			f13_arg0.reticle:setAlpha(f13_arg0.reticleVisible and 1 or 0)
		end
	end
	local f0_local13 = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if f14_arg0.reticle then
			if f14_arg3 then
				f14_arg2 = f14_arg0.reticle.reticleType
			end
			if f14_arg0.reticle.reticleType == f14_arg2 and not f14_arg3 then
				return
			end
			f14_arg0.reticle:close()
			f14_arg0.reticle = nil
		end
		if f14_arg2 and f14_arg2 ~= "" and CoD[f14_arg2] and CoD[f14_arg2].new then
			f14_arg0.reticle = CoD[f14_arg2].new(f14_arg0, f14_arg1, 0, 0, 0, CoD[f14_arg2].__defaultWidth, 0, 0, 0, CoD[f14_arg2].__defaultHeight)
			f14_arg0.reticle.reticleType = f14_arg2
			f14_arg0.reticle:setPriority(-100)
			f14_arg0.reticle:setAlpha(f14_arg0.reticleVisible and 1 or 0)
			LUI.OverrideFunction_CallOriginalSecond(f14_arg0.reticle, "close", function(element)
				if element == f14_arg0.reticle then
					f14_arg0.reticle = nil
				end
			end)
			f14_arg0:addForceClosedChild(f14_arg0.reticle, "reticle")
			f14_arg0:sendInitializationEvents(f14_arg1, f14_arg0.reticle)
		end
		f0_local12(f14_arg0, f14_arg1)
	end
	local f0_local14 = function(f16_arg0, f16_arg1, f16_arg2)
		if f16_arg0.lockOnWidget then
			f16_arg0.lockOnWidget:close()
			f16_arg0.lockOnWidget = nil
		end
		if f16_arg2 and f16_arg2 ~= "" and CoD[f16_arg2] and CoD[f16_arg2].new then
			local f16_local0 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f16_arg1), "lockOnModel")
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f16_local0, "status"), 0)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f16_local0, "lockOnPercent"), 0)
			f16_arg0.lockOnWidget = CoD[f16_arg2].new(f16_arg0, f16_arg1, 0, 0, 0, CoD[f16_arg2].__defaultWidth, 0, 0, 0, CoD[f16_arg2].__defaultWidth)
			f16_arg0.lockOnWidget:setModel(f16_local0, f16_arg1)
			f16_arg0:addForceClosedChild(f16_arg0.lockOnWidget, "lockOnWidget")
			f16_arg0:sendInitializationEvents(f16_arg1, f16_arg0.lockOnWidget)
		end
	end
	LUI.createMenu.HUD = function(f17_arg0)
		local f17_local0 = CoD.Menu.NewFromState("HUD", f17_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
		f17_local0.ignoreCursor = true
		CoD.BaseUtility.SubscribeToMessageDialogBox(f17_local0, f17_arg0)
		f17_local0:appendEventHandler("occlusion_change", function(f18_arg0, f18_arg1)
			if f18_arg0.T7HudMenu then
				f18_arg0.T7HudMenu.m_disableAllButtonActions = f18_arg1.occluded
			end
			if f18_arg0.T7HudMenuGameMode then
				f18_arg0.T7HudMenuGameMode.m_disableAllButtonActions = f18_arg1.occluded
			end
		end)
		if not CoD.isCampaign and Engine[@"getcurrentmap"]() ~= "zm_zod" then
			f17_local0:registerEventHandler("delay_load_menus", HUD_DelayLoadMenus)
		end
		f17_local0:addElement(LUI.UITimer.new(3000, "delay_load_menus", true))
		f17_local0:setOwner(f17_arg0)
		f17_local0.controller = f17_arg0
		local f17_local1 = function(f19_arg0)
			for f19_local3, f19_local4 in ipairs(f17_local0.forceCloseChildren) do
				if f19_local4.widget == f19_arg0 then
					return f19_local3
				end
			end
			return -1
		end
		local f17_local2 = function(f20_arg0)
			local f20_local0 = f17_local1(f20_arg0)
			if f20_local0 ~= -1 then
				table.remove(f17_local0.forceCloseChildren, f20_local0)
			end
		end
		f17_local0.forceCloseChildren = {}
		f17_local0.addForceClosedChild = function(f21_arg0, f21_arg1, f21_arg2)
			f21_arg0:addElement(f21_arg1)
			if f17_local1(f21_arg1) == -1 then
				table.insert(f21_arg0.forceCloseChildren, {
					widget = f21_arg1,
					selfFieldName = f21_arg2,
				})
				LUI.OverrideFunction_CallOriginalFirst(f21_arg1, "close", f17_local2)
			end
		end
		f17_local0.addForceClosedSafeAreaChild = function(f22_arg0, f22_arg1, f22_arg2)
			f22_arg0.safeArea:addElement(f22_arg1)
			if f17_local1(f22_arg1) == -1 then
				table.insert(f22_arg0.forceCloseChildren, {
					widget = f22_arg1,
					selfFieldName = f22_arg2,
				})
				LUI.OverrideFunction_CallOriginalFirst(f22_arg1, "close", f17_local2)
			end
		end
		f17_local0.addCustomForceClosedWidget = function(f23_arg0, f23_arg1, f23_arg2)
			if f17_local1(f23_arg1) == -1 then
				table.insert(f23_arg0.forceCloseChildren, {
					widget = f23_arg1,
					selfFieldName = f23_arg2,
				})
				LUI.OverrideFunction_CallOriginalFirst(f23_arg1, "close", f17_local2)
			end
		end
		f0_local1(f17_local0)
		f17_local0:registerEventHandler("debug_reload", HUD_DebugReload)
		if CoD.isPC then
			Engine[@"exec"](f17_arg0, "ui_keyboard_cancel")
			CoD.PCUtility.RegisterPlaytimeLeftWatcher(f17_local0)
		end
		Engine[@"playmenumusic"]("")
		if f17_arg0 == 0 then
			if (not CoD.isCampaign or not "Loading_CP") and (not CoD.isZombie or not "Loading_ZM") then
				local f17_local3 = CoD.isWarzone
				local f17_local4 = "Loading_WZ"
				local f17_local5 = "Loading_MP"
			end
			f17_local0.loadingMenu = LUI.createMenu[f17_local3 and f17_local4 or f17_local5](f17_arg0)
			if f17_local0:getFirstChild() then
				f17_local0.loadingMenu:addElementBefore(f17_local0:getFirstChild())
			else
				f17_local0:addElement(f17_local0.loadingMenu)
			end
			f17_local0.loadingMenu:menuOpened(f17_arg0, f17_local0.loadingMenu)
		end
		if CoD.isWarzone and Engine[@"issplitscreen"]() then
			f17_local0.splitscreenLoading = LUI.createMenu.Loading_WZ_Splitscreen(f17_arg0)
			if f17_local0:getFirstChild() then
				f17_local0.splitscreenLoading:addElementBefore(f17_local0:getFirstChild())
			else
				f17_local0:addElement(f17_local0.splitscreenLoading)
			end
			f17_local0.splitscreenLoading:menuOpened(f17_arg0, f17_local0.splitscreenLoading)
		end
		f17_local0:setAlpha(1)
		f17_local0:processEvent({
			name = "menu_loaded",
			controller = f17_arg0,
		})
		Dvar.ui_shouldDiscardStableStats:set(false)
		return f17_local0
	end
	f0_local1 = function(f24_arg0)
		HUD_SetupEventHandlers_Common(f24_arg0)
		if CoD.isZombie == false then
			HUD_SetupEventHandlers_Multiplayer(f24_arg0)
		end
	end
	function UpdateHUDVisibility(f25_arg0, f25_arg1)
		if Engine[@"isvisibilitybitset"](f25_arg1.controller, Enum[@"uivisibilitybit"][@"bit_camera_anim_hiding_hud"]) then
			if f25_arg0.T7HudMenu then
				f25_arg0.T7HudMenu:setAlpha(0)
			end
			if f25_arg0.T7HudMenuGameMode then
				f25_arg0.T7HudMenuGameMode:setAlpha(0)
			end
		else
			if f25_arg0.T7HudMenu then
				f25_arg0.T7HudMenu:setAlpha(1)
			end
			if f25_arg0.T7HudMenuGameMode then
				f25_arg0.T7HudMenuGameMode:setAlpha(1)
			end
		end
	end
	function HUD_Hide(f26_arg0, f26_arg1)
		f26_arg0:setAlpha(0)
	end
	function HUD_Show(f27_arg0, f27_arg1)
		f27_arg0:setAlpha(1)
	end
	local f0_local15 = function(f28_arg0, f28_arg1)
		local f28_local0 = LUI.roots
		local f28_local1 = "UIRoot"
		if f28_local0["UIRoot" .. f28_arg1.controller].ingameFriendsList then
			LUI.roots[rootName]:processEvent({
				name = "closeFriendsList",
				controller = f28_arg1.controller,
			})
			LUI.roots[rootName]:processEvent({
				name = "closeallpopups",
				controller = f28_arg1.controller,
			})
		else
			f28_arg0:openPopup("FriendsList", f28_arg1.controller)
		end
	end
	local f0_local16 = function(f29_arg0, f29_arg1)
		Engine[@"setactivemenu"](f29_arg1.controller, Enum[@"uimenucommand_t"][@"uimenu_none"])
	end
	local f0_local17 = function(f30_arg0, f30_arg1)
		local f30_local0 = f30_arg1.isError
		local f30_local1 = f30_arg1.gamertag
		if f30_local0 == false then
			CoD.OverlayUtility.ShowToast("Invite", Engine[@"hash_4F9F1239CFD921FE"](@"hash_5513526C1CA23EB9"), f30_local1, LuaDefine.INVITE_TOAST_POPUP_ICON)
		else
			CoD.OverlayUtility.ShowToast("Invite", Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_3248E1604D27C8DA")), f30_local1, LuaDefine.INVITE_TOAST_POPUP_ERROR_ICON)
		end
		return true
	end
	function HUD_SetupEventHandlers_Common(f31_arg0)
		f31_arg0:registerEventHandler("first_snapshot", HUD_FirstSnapshot)
		f31_arg0:registerEventHandler("open_ingame_menu", f0_local0)
		f31_arg0:registerEventHandler("close_ingame_menu", HUD_CloseInGameMenu)
		if CoD.isPC then
			CoD.PCUtility.SetupUIMenuShortcuts(f31_arg0, f31_arg0.controller)
		end
		f31_arg0:registerEventHandler("open_toaster_popup", f0_local17)
		f31_arg0:subscribeToModel(Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f31_arg0.controller), "scriptNotify"), function(model)
			local f32_local0 = Engine[@"getmodelvalue"](model)
			if f32_local0 == @"show_outcome" then
				f0_local16(f31_arg0, {
					controller = f31_arg0.controller,
					name = f32_local0,
					data = CoD.GetScriptNotifyData(model),
				})
			elseif f32_local0 == @"track_victim_death" then
				f0_local5(f31_arg0, {
					controller = f31_arg0.controller,
					name = f32_local0,
					data = CoD.GetScriptNotifyData(model),
				})
			elseif f32_local0 == @"force_scoreboard" then
				if Engine[@"isdemoplaying"]() == false or CoD.isZombie == false then
					local f32_local1 = 1
					if CoD.isZombie == true then
						local f32_local2 = CoD.GetScriptNotifyData(model)
						if f32_local2 ~= nil then
							f32_local1 = f32_local2[1]
						end
					end
					Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f31_arg0.controller), "forceScoreboard"), f32_local1)
				end
			elseif f32_local0 == @"open_ingame_menu" then
				f0_local0(f31_arg0, {
					controller = f31_arg0.controller,
					name = f32_local0,
					data = CoD.GetScriptNotifyData(model),
				})
			elseif f32_local0 == @"close_ingame_menu" then
				HUD_CloseSpecificInGameMenu(f31_arg0, {
					controller = f31_arg0.controller,
					name = f32_local0,
					data = CoD.GetScriptNotifyData(model),
				})
			elseif f32_local0 == @"hash_9AB42B593C66ED" then
				f0_local6(f31_arg0, {
					controller = f31_arg0.controller,
					name = f32_local0,
					data = CoD.GetScriptNotifyData(model),
				})
			elseif f32_local0 == @"potm_client" then
				local f32_local1 = CoD.GetScriptNotifyData(model)
				if f32_local1 ~= nil then
					local f32_local2 = f32_local1[1]
					if f32_local2 then
						local f32_local3 = DataSources.StageResults.getModel()
						f32_local3.potmClient:set(f32_local2)
					end
				end
			elseif f32_local0 == @"hash_EE32E40C182320B" then
				assert(CoD.isWarzone)
				f31_arg0.downButNotOutHUD = LUI.createMenu.DownButNotOut(f31_arg0.controller)
				local f32_local1 = f31_arg0:getParent()
				f32_local1:addElement(f31_arg0.downButNotOutHUD)
				f31_arg0:addCustomForceClosedWidget(f31_arg0.downButNotOutHUD, "downButNotOutHUD")
				f31_arg0.downButNotOutHUD:menuOpened(f31_arg0.controller, f31_arg0.downButNotOutHUD)
			end
		end)
		f31_arg0:subscribeToModel(Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f31_arg0.controller), "engineLoadoutSelect"), function(model)
			local f33_local0 = Engine[@"getmodelvalue"](model)
			local f33_local1 = f33_local0
			local f33_local2 = CoD.CACUtility.classModels
			if f33_local2 then
				f33_local2 = CoD.CACUtility.classModels[f31_arg0.controller]
				if f33_local2 then
					f33_local2 = f33_local1 and CoD.CACUtility.classModels[f31_arg0.controller][f33_local0 + 1]
				end
			end
			local f33_local3 = f33_local2 and f33_local2.properties.classNum
			if f33_local3 and f33_local3 <= 11 and f33_local0 and f33_local0 >= 0 and not CoD.CACUtility.IsClassLocked(f31_arg0.controller, f33_local0) and not CoD.BountyHunterUtility.GameTypeIsBounty(f31_arg0.controller) then
				CoD.CACUtility.ChangeClass(f31_arg0.controller, f33_local0, nil)
			end
		end)
		local f31_local0 = Engine[@"getmodelforcontroller"](f31_arg0.controller)
		f31_local0 = f31_local0:create("open_ingame_menu_update")
		f31_local0:set(0)
		f31_arg0:registerEventHandler("open_migration_menu", HUD_StartMigration)
		f31_arg0:registerEventHandler("open_hud_menu", HUD_OpenHudMenu)
		f31_arg0:registerEventHandler("close_hud_menu", HUD_CloseHudMenu)
		f31_arg0:registerEventHandler("open_hud_popup", HUD_OpenHudPopup)
		f31_arg0:registerEventHandler("close_hud", HUD_Close)
		f31_arg0:registerEventHandler("spectate_hide_gamehud", HUD_Hide)
		f31_arg0:registerEventHandler("spectate_show_gamehud", HUD_Show)
		f31_arg0:registerEventHandler("fullscreen_viewport_start", HUD_FullscreenStart)
		f31_arg0:registerEventHandler("fullscreen_viewport_stop", HUD_FullscreenStop)
		f31_arg0:registerEventHandler("update_scoreboard_columns", HUD_UpdateScoreboardColumns)
		f31_local0 = f31_arg0:getOwner()
		if f31_local0 == nil then
			f31_local0 = Engine[@"getprimarycontroller"]()
		end
		local f31_local1 = Engine[@"getmodelforcontroller"](f31_local0)
		f31_arg0:subscribeToModel(Engine[@"getmodel"](f31_local1, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_camera_anim_hiding_hud"]), function(model)
			UpdateHUDVisibility(f31_arg0, {
				controller = f31_local0,
			})
		end, false)
		local f31_local2 = DataSources.CurrentWeapon.getModel(f31_local0)
		f31_local2:create("weaponReticle")
		f31_local2 = DataSources.CurrentWeapon.getModel(f31_local0)
		f31_local2:create("lockOnWidget")
		f31_arg0:subscribeToGlobalModel(f31_local0, "VehicleInfo", "vehicleType", function(model)
			local f35_local0 = Engine[@"getmodelvalue"](model)
			if f35_local0 then
				f0_local11(f31_arg0, f31_local0, f35_local0, false)
				f0_local12(f31_arg0, f31_local0)
			end
		end, true)
		f31_arg0:subscribeToGlobalModel(f31_local0, "VehicleInfo", "forceUpdateVehicleBindings", function(model)
			if f31_arg0.vehicleHUD then
				f0_local11(f31_arg0, f31_local0, f31_arg0.vehicleHUD.vehicleType, true)
			end
		end, true)
		f31_arg0:subscribeToGlobalModel(f31_local0, "VehicleInfo", "isVehicleOwner", function(model)
			if f31_arg0.vehicleHUD then
				f0_local11(f31_arg0, f31_local0, f31_arg0.vehicleHUD.vehicleType, true)
			end
		end, true)
		if not CoD.isZombie then
			Engine[@"createmodel"](f31_local1, "vehicle.vehicleAttackMode")
			f31_arg0:subscribeToGlobalModel(f31_local0, "PerController", "vehicle.vehicleAttackMode", function(model)
				if f31_arg0.vehicleHUD then
					f0_local11(f31_arg0, f31_local0, f31_arg0.vehicleHUD.vehicleType, true)
				end
			end, true)
		end
		if CoD.isPC and not CoD.isWarzone then
			f31_arg0:subscribeToModel(f31_local1.LastInput, function()
				if f31_arg0.vehicleHUD and Engine[@"hash_1A11C376CCDCBA5A"](f31_local0) then
					f0_local11(f31_arg0, f31_local0, f31_arg0.vehicleHUD.vehicleType, true)
				end
			end)
		end
		f31_arg0.reticleVisible = true
		f31_arg0:subscribeToGlobalModel(f31_local0, "CurrentWeapon", "weaponReticle", function(model)
			local f40_local0 = Engine[@"getmodelvalue"](model)
			if f40_local0 then
				f0_local13(f31_arg0, f31_local0, f40_local0, false)
			end
		end)
		f31_arg0:subscribeToGlobalModel(f31_local0, "CurrentWeapon", "lockOnWidget", function(model)
			local f41_local0 = Engine[@"getmodelvalue"](model)
			if f41_local0 then
				f0_local14(f31_arg0, f31_local0, f41_local0)
			end
		end)
		CoD.DemoUtility.RegisterEventHandlers(f31_arg0, f31_local0)
		if Engine[@"isdemoplaying"]() then
			f31_arg0:subscribeToGlobalModel(f31_local0, "Demo", "cameraMode", function(model)
				local f42_local0 = DataSources.VehicleInfo.getModel(f31_local0)
				f0_local11(f31_arg0, f31_local0, f42_local0.vehicleType:get(), true)
				f0_local12(f31_arg0, f31_local0)
			end)
		end
	end
	function HUD_SetupEventHandlers_Multiplayer(f43_arg0)
		f43_arg0:registerEventHandler("hud_force_kill_killstreak_hud", f0_local3)
		local f43_local0 = f43_arg0:getOwner()
		if f43_local0 == nil then
			f43_local0 = Engine[@"getprimarycontroller"]()
		end
		local f43_local1 = function(f44_arg0)
			HUD_UpdateRefresh(f43_arg0, {
				controller = f43_local0,
			})
		end
		local f43_local2 = Engine[@"getmodelforcontroller"](f43_local0)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_migrating_host"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]), f43_local1)
		f43_arg0:subscribeToModel(Engine[@"getmodel"](f43_local2, "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"]), function(model)
			f0_local4(f43_arg0, {
				controller = f43_local0,
			})
		end)
		f43_arg0:subscribeToModel(f43_local2.heldWeapons[0]:create("viewmodelWeaponName"), function(model)
			CoD.HUDUtility[@"updateicepick"](f43_arg0, f43_arg0.safeArea, model:get(), f43_local0)
		end)
		if Engine[@"getmodel"](f43_local2, "team") == nil then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f43_local2, "team"), 0)
		end
		if CoD.isPC then
			f43_arg0:registerEventHandler("chooseclass_hotkey", HUD_Handle_ChooseClass_HotKey)
			f43_arg0:subscribeToModel(f43_local2.LastInput, function()
				if Engine[@"hash_1A11C376CCDCBA5A"](f43_local0) then
					CoD.ScoreboardUtility.HideScoreboard(f43_arg0, f43_local0)
					CoD.ModelUtility.SetGlobalDatasourceModelValueToEnum(f43_local0, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_1E16E7DEBC8823D8"])
				end
			end)
		end
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f43_local0), "forceScoreboard"), 0)
	end
	function HUD_RemoveAllChildren(f48_arg0)
		while #f48_arg0.forceCloseChildren > 0 do
			local f48_local0 = f48_arg0.forceCloseChildren[1]
			if f48_local0.widget then
				f48_local0.widget:close()
			end
			if f48_local0.selfFieldName then
				f48_arg0[f48_local0.selfFieldName] = nil
			end
		end
		f48_arg0.forceCloseChildren = {}
		f48_arg0:removeAllChildren()
	end
	function HUD_FirstSnapshot(f49_arg0, f49_arg1)
		f49_arg0:dispatchEventToChildren({
			name = "close_all_popups",
			controller = f49_arg1.controller,
		})
		f49_arg0.bootOnOpen = false
		if f49_arg0.T7HudMenu ~= nil then
			if f49_arg1.debugReload or f49_arg1.hostMigrationOccured then
				CoD.Menu.DebugCloseMenu(f49_arg0.T7HudMenu)
				f49_arg0.T7HudMenu = nil
			else
				f49_arg0.bootOnOpen = f49_arg0.T7HudMenu.hasBooted
			end
		end
		if f49_arg0.T7HudMenuGameMode ~= nil and (f49_arg1.debugReload or f49_arg1.hostMigrationOccured) then
			CoD.Menu.DebugCloseMenu(f49_arg0.T7HudMenuGameMode)
			CoD.HUDUtility.ClearCustomGainFocusWidgets(f49_arg0)
			f49_arg0.T7HudMenuGameMode = nil
		end
		HUD_RemoveAllChildren(f49_arg0)
		if f49_arg0.loadingMenu then
			local f49_local0 = function(f50_arg0)
				if f50_arg0.loadingMenu then
					Engine[@"hash_2B3B13569A733293"]()
					if f50_arg0.loadingMenu:hasClip("Close") and not Engine[@"issplitscreen"]() then
						f50_arg0.loadingMenu:playClip("Close")
						f50_arg0.loadingMenu:registerEventHandler("clip_over", function(element, event)
							element:close()
							f50_arg0.loadingMenu = nil
						end)
					else
						f50_arg0.loadingMenu:close()
						f50_arg0.loadingMenu = nil
					end
				end
			end
			local f49_local1 = f49_arg0:getParent()
			f49_local1:addElement(f49_arg0.loadingMenu)
			if CoD.isWarzone then
				f49_local1 = DataSources.HUDItems.getModel(f49_arg1.controller)
				f49_arg0:subscribeToModel(f49_local1.wzLoadFinished, function(model)
					if model:get() == 1 then
						f49_local0(f49_arg0)
					end
				end)
			else
				f49_local1 = f49_arg0:getParent()
				f49_local1:addElement(LUI.UITimer.newElementTimer(0, true, function()
					f49_local0(f49_arg0)
				end))
			end
		else
			Engine[@"hash_2B3B13569A733293"]()
		end
		if CoD.isWarzone and f49_arg0.splitscreenLoading then
			local f49_local0 = DataSources.HUDItems.getModel(f49_arg1.controller)
			f49_local0 = f49_local0.wzLoadFinished
			local f49_local1 = f49_arg0:getParent()
			f49_local1:addElement(f49_arg0.splitscreenLoading)
			f49_arg0:subscribeToModel(f49_local0, function(model)
				if model:get() == 1 then
					f49_arg0.splitscreenLoading:close()
					f49_arg0.splitscreenLoading = nil
				end
			end)
		end
		f49_arg0:setOwner(f49_arg1.controller)
		f49_arg0.controller = f49_arg1.controller
		HUD_DelayLoadMenus()
		if Engine[@"usingfreecursor"]() then
			if not f49_arg0.freeCursor then
				f49_arg0.freeCursor = LUI.createMenu.FreeCursor(f49_arg0.controller)
				f49_arg0.freeCursor:setPriority(1000)
				local f49_local0 = f49_arg0:getParent()
				f49_local0:addElement(f49_arg0.freeCursor)
				f49_arg0:addCustomForceClosedWidget(f49_arg0.freeCursor, "freeCursor")
			end
			f49_arg0.freeCursor:menuOpened(f49_arg0.controller, f49_arg0.freeCursor)
		end
		local f49_local0 = CoD.BlackTransitionFade.new(f49_arg0, f49_arg0.controller, 0, 1, 0, 0, 0, 1, 0, 0)
		f49_local0:setPriority(1001)
		local f49_local1 = f49_arg0:getParent()
		f49_local1:addElement(f49_local0)
		f49_arg0:addCustomForceClosedWidget(f49_local0, "BlackFade")
		f49_local1 = CoD.MainOverlay.new(f49_arg0, f49_arg0.controller, 0, 1, 0, 0, 0, 1, 0, 0)
		f49_local1:setPriority(1000)
		local f49_local2 = f49_arg0:getParent()
		f49_local2:addElement(f49_local1)
		f49_arg0:sendInitializationEvents(f49_arg0.controller, f49_local1)
		f49_arg0:addCustomForceClosedWidget(f49_local1, "MainOverlay")
		f49_arg0.startMenu = LUI.createMenu.StartMenu_Main(f49_arg0.controller)
		f49_arg0.startMenu.onStartMenuOpened = function(f55_arg0, f55_arg1)
			if CoD.isPC then
				f55_arg0:CheckDefaultFocus(f55_arg1)
			elseif f55_arg0.__defaultFocus then
				CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f55_arg0, f55_arg0, f55_arg1)
			end
			local f55_local0 = Engine[@"getmodelforcontroller"](f55_arg1)
			f55_local0.open_ingame_menu_update:forceNotifySubscriptions()
		end
		f49_arg0.startMenu.onStartMenuClosed = function(f56_arg0, f56_arg1) end
		f49_arg0.startMenu.m_disableAllButtonActions = true
		if not CoD.isPC then
			f49_arg0:addCustomForceClosedWidget(f49_arg0.startMenu, "startMenu")
		end
		f49_arg0.startMenu:processEvent({
			name = "menu_loaded",
			controller = f49_arg0.controller,
			menu = f49_arg0.startMenu,
		})
		f49_arg0.startMenu:menuOpened(f49_arg0.controller, f49_arg0.startMenu)
		HUD_FirstSnapshot_Common(f49_arg0, f49_arg1)
		if false == CoD.isZombie then
			HUD_FirstSnapshot_NotZombie(f49_arg0, f49_arg1)
			if CoD.isCampaign == true then
				HUD_FirstSnapshot_Campaign(f49_arg0, f49_arg1)
			elseif Engine[@"getlobbymode"](Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])) == Enum[@"lobbymode"][@"hash_3B3A1BBF18C0B176"] or IsSimulateCT() then
				HUD_FirstSnapshot_CombatTraining(f49_arg0, f49_arg1)
			end
		else
			if not CoD.isPC then
				f49_arg0:dispatchEventToRoot({
					name = "close_menu",
					menuName = "StartMenu_Main",
					controller = f49_arg1.controller,
				})
			end
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f49_arg1.controller), "forceScoreboard"), 0)
			HUD_FirstSnapshot_Zombie(f49_arg0, f49_arg1)
		end
		if f49_arg0.safeArea then
			f49_arg0.safeArea:processEvent({
				name = "menu_loaded",
				controller = f49_arg0.controller,
				menu = f49_arg0.safeArea,
			})
			f49_arg0.safeArea:menuOpened(f49_arg0.controller, f49_arg0.startMenu)
		end
		Engine[@"forcehudrefresh"](f49_arg1.controller)
		HUD_UpdateRefresh(f49_arg0, f49_arg1)
		f49_arg0.firstSnapshotProcessed = true
		if f49_arg0.pendingInGameMenuEvents then
			for f49_local2 = 1, #f49_arg0.pendingInGameMenuEvents, 1 do
				f0_local0(f49_arg0, f49_arg0.pendingInGameMenuEvents[f49_local2])
			end
			f49_arg0.pendingInGameMenuEvents = nil
		end
		return true
	end
	function HUD_StartMigration(f57_arg0, f57_arg1)
		HUD_RemoveAllChildren(f57_arg0)
		CoD.CodCasterUtility.SetupUIModels(f57_arg1.controller)
		CoD.SubtitleUtility.ClearSubtitleModels(f57_arg1.controller)
		f57_arg0.hostMigrationMenu = LUI.createMenu.Migration(f57_arg1.controller, f57_arg0)
		f57_arg0.hostMigrationMenu:setPriority(1002)
		local f57_local0 = f57_arg0:getParent()
		if f57_local0 then
			f57_local0:addElement(f57_arg0.hostMigrationMenu)
			f57_arg0:addCustomForceClosedWidget(f57_arg0.hostMigrationMenu, "hostMigrationMenu")
			f57_arg0.hostMigrationMenu:menuOpened(f57_arg1.controller, f57_arg0.hostMigrationMenu)
		end
	end
	function HUD_FirstSnapshot_Common(f58_arg0, f58_arg1)
		CoD.scoreInfoTable = CoD.GameTypeUtility.GetGameTypeValue(Engine[@"lobbygetgametype"](), "scoreInfoFile", CoD.scoreInfoTable)
		if not CoD.isMultiplayer and not CoD.isWarzone then
			f58_arg0.cinematicSubtitles = CoD.MovieSubtitles.new(f58_arg0, f58_arg1.controller, 0.5, 0.5, -640, 640, 0.5, 0.5, -360, 360)
			f58_arg0:addForceClosedChild(f58_arg0.cinematicSubtitles, "cinematicSubtitles")
			f58_arg0.SubtitlesContainer = CoD.SubtitlesContainer.new(f58_arg0, f58_arg1.controller, 0.5, 0.5, -555, 555, 1, 1, -468, -321)
			f58_arg0:addForceClosedChild(f58_arg0.SubtitlesContainer, "SubtitlesContainer")
		end
		CoD.HUDUtility.GetCachedBloodSettings()
		local f58_local0 = f58_arg1.controller
		HUD_AddHintTextElements(f58_arg0, f58_local0)
		local f58_local1 = CoD.Menu.NewFromState("hud_safearea")
		f58_local1.ignoreCursor = true
		f58_local1.disableKeyboardNavigation = true
		f58_local1:sizeToSafeArea(f58_local0)
		f58_local1:setPriority(100)
		f58_local1:setOwner(f58_arg1.controller)
		f58_arg0:addElement(f58_local1)
		if f58_arg0.safeArea and f58_arg0.safeArea.buttonModel then
			if LUI.DEV then
				local f58_local2 = LUI.DEV.ErrorIfModelsDoNotMatch(f58_arg0.safeArea.buttonModel, Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f58_local0), "HUDSafeArea.buttonPrompts"))
			end
			Engine[@"unsubscribeandfreemodel"](f58_arg0.safeArea.buttonModel)
			f58_arg0.safeArea:close()
		end
		f58_arg0.safeArea = f58_local1
		CoD.HUDUtility.AddCustomGainFocusWidget(f58_arg0, f58_arg0.safeArea)
		f58_arg0.safeArea.buttonModel = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f58_local0), "HUDSafeArea.buttonPrompts")
	end
	function HUD_AddHintTextElements(f59_arg0, f59_arg1)
		local f59_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f59_arg1), "profile.colorblindMode")
		local f59_local1 = Engine[@"lobbygetgametype"]()
		if f59_local1 == "codfu" then
			return
		elseif f59_local1 == "doa" then
			return
		end
		local self = LUI.UIElement.new()
		self:setLeftRight(true, true, 0, 0)
		self:setTopBottom(false, true, -320, -320 + CoD.textSize.ExtraSmall)
		f59_arg0:addForceClosedChild(self)
		self:setupPlayerStance()
		local f59_local3 = LUI.UIElement.new()
		f59_local3:setLeftRight(true, true, 0, 0)
		f59_local3:setTopBottom(true, false, 180, 180 + CoD.textSize.Default)
		f59_arg0:addForceClosedChild(f59_local3)
		f59_local3:setupHoldBreathHint()
		local f59_local4 = LUI.UIElement.new()
		f59_local4:setLeftRight(true, true, 0, 0)
		f59_local4:setTopBottom(true, false, 140, 140 + CoD.textSize.Default)
		f59_arg0:addForceClosedChild(f59_local4)
		f59_local4:setupHoldBreathZoomHint()
		local f59_local5 = LUI.UIElement.new()
		f59_local5:setLeftRight(true, true, 0, 0)
		f59_local5:setTopBottom(false, false, 90, 90 + CoD.textSize.Default)
		f59_arg0:addForceClosedChild(f59_local5)
		f59_local5:setupMeleeChargeHint()
		local f59_local6 = LUI.UIElement.new()
		f59_local6:setLeftRight(true, true, 0, 0)
		f59_local6:setTopBottom(false, false, 90, 90 + CoD.textSize.Default)
		f59_arg0:addForceClosedChild(f59_local6)
		f59_local6:setupMeleeCounterHint()
		local f59_local7 = LUI.UIElement.new()
		f59_local7:setLeftRight(true, true, 0, 0)
		f59_local7:setTopBottom(false, false, 45, 45 + CoD.textSize.ExtraSmall)
		f59_arg0:addForceClosedChild(f59_local7)
		f59_local7:setupInvalidCmdHint()
		if not CoD.isZombie and not CoD.isCampaign then
			if not IsWarzone() then
				local f59_local8 = LUI.UIElement.new()
				f59_local8:setLeftRight(true, true, 0, 0)
				f59_local8:setTopBottom(true, true, 0, 0)
				f59_local8:setImage(RegisterMaterial(@"compassping_enemy_diamond_bottom"))
				f59_local8:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, "EnemyScorestreakTarget")))
				f59_arg0:addForceClosedChild(f59_local8)
				f59_local8:setupTargetHighlights_Enemy()
				if f59_local0 then
					f59_local8:subscribeToModel(f59_local0, function(model)
						f59_local8:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, "EnemyScorestreakTarget")))
					end, false)
				end
			end
			local f59_local8 = LUI.UIElement.new()
			f59_local8:setLeftRight(true, true, 0, 0)
			f59_local8:setTopBottom(true, true, 0, 0)
			f59_local8:setImage(RegisterMaterial(@"compassping_enemy_diamond_bottom"))
			f59_local8:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, "PlayerYellow")))
			f59_arg0:addForceClosedChild(f59_local8)
			f59_local8:setupTargetHighlights_Friendly()
			if f59_local0 then
				f59_local8:subscribeToModel(f59_local0, function(model)
					f59_local8:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, IsMultiplayer() and "PlayerYellow" or "PlayerGreen")))
				end, false)
			end
			local f59_local9 = LUI.UIElement.new()
			f59_local9:setLeftRight(true, true, 0, 0)
			f59_local9:setTopBottom(true, true, 0, 0)
			f59_local9:setImage(RegisterMaterial(@"compassping_enemysatellite_diamond"))
			f59_local9:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, "PlayerYellow")))
			f59_arg0:addForceClosedChild(f59_local9)
			f59_local9:setupTargetHighlights_Friendly()
			if f59_local0 then
				f59_local9:subscribeToModel(f59_local0, function(model)
					f59_local9:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, IsMultiplayer() and "PlayerYellow" or "PlayerGreen")))
				end, false)
			end
			local f59_local10 = LUI.UIElement.new()
			f59_local10:setLeftRight(true, true, 0, 0)
			f59_local10:setTopBottom(true, true, 0, 0)
			f59_local10:setImage(RegisterMaterial(@"compassping_enemysatellite_diamond"))
			f59_local10:setRGB(1, 0, 0)
			f59_arg0:addForceClosedChild(f59_local10)
			f59_local10:setupPlayerPivotTargetting()
		end
		local f59_local8 = LUI.UIElement.new()
		f59_local8:setLeftRight(true, true, 0, 0)
		f59_local8:setTopBottom(true, true, 0, 0)
		f59_local8:setRGB(1, 0, 0)
		f59_arg0:addForceClosedChild(f59_local8)
		f59_local8:setupPlayerGrappleTargetting()
		if not CoD.isZombie and not CoD.isCampaign then
			local f59_local9 = LUI.UIElement.new()
			f59_local9:setLeftRight(true, true, 0, 0)
			f59_local9:setTopBottom(true, true, 0, 0)
			f59_local9:setImage(RegisterMaterial(@"compassping_enemysatellite_diamond"))
			f59_local9:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, "EnemyScorestreakTarget")))
			f59_arg0:addForceClosedChild(f59_local9)
			f59_local9:setupLockonHighlights()
			if f59_local0 then
				f59_local9:subscribeToModel(f59_local0, function(model)
					f59_local9:setRGB(CoD.ColorUtility.ExplodeColor(CoD.ColorUtility.GetColorBlindColorForPlayer(f59_arg1, "EnemyScorestreakTarget")))
				end, false)
			end
		end
		if CoD.isZombie == true or CoD.isWarzone then
			local f59_local9 = LUI.UIElement.new()
			f59_local9:setLeftRight(true, true, 0, 0)
			f59_local9:setTopBottom(true, true, 0, 0)
			f59_arg0:addForceClosedChild(f59_local9)
			f59_local9:setupFriendlyArrows()
			if CoD.isZombie == true then
				local f59_local10 = Engine[@"getglobalmodel"]()
				f59_local10 = f59_local10["ZMHudGlobal.trials.hudDeactivated"]
				if f59_local10 then
					f59_local9:subscribeToModel(f59_local10, function(model)
						if model:get() == 1 then
							f59_local9:setAlpha(0)
						else
							f59_local9:setAlpha(1)
						end
					end)
				end
			end
		end
	end
	local f0_local18 = function(f65_arg0, f65_arg1, f65_arg2)
		if CoD.isMultiplayer and not Engine[@"isdemoplaying"]() then
			local f65_local0 = CoD.SpawnSelectKillcam.new(f65_arg1, f65_arg2, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
			f65_local0:setState(f65_arg2, "Hidden")
			LUI.roots["UIRoot" .. f65_arg2].addElement(REG4["UIRoot" .. f65_arg2], f65_local0)
			f65_arg0:addCustomForceClosedWidget(f65_local0, "spawnSelect")
		end
	end
	local f0_local19 = function(f66_arg0, f66_arg1, f66_arg2)
		f66_arg0.killcamHUD = LUI.createMenu.KillcamMenu(f66_arg2)
		f66_arg0.killcamHUD:addElementBefore(f66_arg1)
		f66_arg0.killcamHUD.persistent = true
		f66_arg0.killcamHUD:setAlpha(0)
		f66_arg0:addCustomForceClosedWidget(f66_arg0.killcamHUD, "killcamHUD")
		f66_arg0.killcamHUD:menuOpened(f66_arg2, f66_arg0.killcamHUD)
	end
	local f0_local20 = function(f67_arg0, f67_arg1)
		if Engine[@"isdemoplaying"]() then
			return
		else
			local f67_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f67_arg1), "team")
			local f67_local1 = function(f68_arg0)
				if Engine[@"getmodelvalue"](f68_arg0) == Enum[@"team_t"][@"team_spectator"] then
					if f67_arg0.safeArea and f67_arg0.safeArea.CodCaster == nil then
						if CoD.isWarzone then
							f67_arg0.safeArea.CodCaster = CoD.CodCaster_WZ.new(f67_arg0.safeArea, f67_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
						else
							f67_arg0.safeArea.CodCaster = CoD.CodCaster.new(f67_arg0.safeArea, f67_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
						end
						f67_arg0:addForceClosedSafeAreaChild(f67_arg0.safeArea.CodCaster)
						f67_arg0.safeArea:sendInitializationEvents(f67_arg1, f67_arg0.safeArea.CodCaster)
						f67_arg0.safeArea.buttonFunctions = f67_arg0.safeArea.CodCaster.buttonFunctions
						if not Engine[@"isvisibilitybitset"](f67_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) then
							f67_arg0.safeArea.CodCaster:processEvent({
								name = "gain_focus",
								controller = f67_arg1,
							})
							f67_arg0.safeArea.CodCaster:gainFocus({
								controller = f67_arg1,
							})
						end
						if f67_arg0.safeArea.PostCodCasterLoad then
							f67_arg0.safeArea.PostCodCasterLoad(f67_arg0.safeArea.CodCaster)
							f67_arg0.safeArea.PostCodCasterLoad = nil
						end
						LUI.OverrideFunction_CallOriginalSecond(f67_arg0.safeArea.CodCaster, "close", function(element)
							CoD.Menu.UnsubscribeFromControllerSubscriptionsForElement(f67_arg0.safeArea, element)
						end)
						UpdateState(f67_arg0.safeArea.CodCaster, {
							controller = f67_arg1,
						})
					end
				elseif f67_arg0.safeArea and f67_arg0.safeArea.CodCaster ~= nil then
					f67_arg0.safeArea.CodCaster:close()
					f67_arg0.safeArea.buttonFunctions = nil
					f67_arg0.safeArea.CodCaster = nil
				end
			end
			if f67_arg0.hasTeamModelSubscription then
				f67_local1(f67_local0)
				return
			else
				f67_arg0.hasTeamModelSubscription = true
				f67_arg0:subscribeToModel(f67_local0, f67_local1)
			end
		end
	end
	function HUD_FirstSnapshot_NotZombie(f70_arg0, f70_arg1)
		CoD.CodCasterUtility.SetupUIModels(f70_arg1.controller)
		CoD.BaseUtility.CreateControllerModel(f70_arg1.controller, "interactivePrompt.activeObjectiveID")
		HUD_DelayLoadMenus()
		if CoD.isPC then
			CoD.PCUtility.DeactivateMenuChat(f70_arg1.controller)
		end
		f70_arg0.toastNotification = CoD.ToastNotification.new(f70_arg0, f70_arg1.controller, 0.5, 0.5, -960, 960, 0, 0, 0, CoD.ToastNotification.__defaultHeight)
		f70_arg0.toastNotification:setState(f70_arg1.controller, "DefaultState")
		f70_arg0.toastNotification:setPriority(9999)
		local f70_local0 = f70_arg0:getParent()
		if f70_local0 then
			f70_local0:addElement(f70_arg0.toastNotification)
			f70_arg0:addCustomForceClosedWidget(f70_arg0.toastNotification, "toastNotification")
		end
		local f70_local1 = Engine[@"getmodelforcontroller"](f70_arg1.controller)
		if f70_local1 then
			f70_local1 = Engine[@"getmodel"](f70_local1, "hudItems.playerSpawned")
		end
		local f70_local2 = f70_local1 and Engine[@"getmodelvalue"](f70_local1)
		if f70_local2 then
			Engine[@"setmodelvalue"](f70_local1, false)
		end
		local f70_local3 = Engine[@"lobbygetgametype"]()
		if f70_arg0.T7HudMenu then
			f70_arg0.T7HudMenu.SafeAreaContainerBack.Notifications.NotificationQueueWidget:clearNotificationQueue()
			f70_arg0.T7HudMenu.hasBooted = false
			f70_arg0.T7HudMenu:setAlpha(1)
		elseif f70_local3 ~= "doa" and f70_local3 ~= "codfu" then
			local f70_local4 = nil
			f70_local4 = LUI.createMenu.Hud(f70_arg1.controller)
			if f70_arg0.bootOnOpen and not CoD.IsShoutcaster(f70_arg1.controller) then
				f70_arg0.bootOnOpen = false
				TryBootHUD(f70_local4, 0)
			end
			f70_arg0.T7HudMenu = f70_local4
		end
		if f70_arg0.T7HudMenu then
			f70_arg0:addElement(f70_arg0.T7HudMenu)
			f70_arg0.T7HudMenu:menuOpened(f70_arg1.controller, f70_arg0.T7HudMenu)
		end
		local f70_local4 = nil
		if CoD.isCampaign == true then
			f70_local4 = "CP"
		elseif CoD.isWarzone or f70_local3 == "warzone" then
			f70_local4 = "WZ"
		else
			f70_local4 = "MP"
		end
		if f70_local3 == "codfu" then
			f70_local4 = "CODFU"
		end
		if f70_local3 == "doa" then
			require("x64:ba86678eab61fd3")
			f70_local4 = "DOA"
		end
		if not f70_arg0.T7HudMenuGameMode then
			local f70_local5 = nil
			if CoD.CodCasterUtility.IsCodCasterAssigned(f70_arg1.controller) and not CoD.isWarzone then
				f70_local5 = LUI.createMenu.Hud_MP_Codcaster(f70_arg1.controller)
			else
				f70_local5 = LUI.createMenu["Hud_" .. f70_local4](f70_arg1.controller)
			end
			if f70_local4 == "CP" and not f70_arg0.InGameTalkersWidget then
				local f70_local6 = CoD.InGameTalkersWidget.new(f70_local5, f70_arg1.controller, 0, 0, 64, 254, 0, 0, 36, 123)
				f70_arg0:addElement(f70_local6)
				f70_arg0.InGameTalkersWidget = f70_local6
			end
			if f70_local2 then
				Engine[@"setmodelvalue"](f70_local1, true)
			end
			f70_arg0.T7HudMenuGameMode = f70_local5
		else
			f70_arg0.T7HudMenuGameMode:setAlpha(1)
			if f70_local2 then
				Engine[@"setmodelvalue"](f70_local1, true)
			end
		end
		f70_arg0:addElement(f70_arg0.T7HudMenuGameMode)
		if CoD.isPC and not IsMultiplayer() then
			CoD.PCUtility.DisableKeyboardNavigationInMenu(f70_arg0.T7HudMenuGameMode)
		end
		CoD.HUDUtility.AddCustomGainFocusWidget(f70_arg0, f70_arg0.T7HudMenuGameMode)
		f70_arg0.T7HudMenuGameMode:menuOpened(f70_arg1.controller, f70_arg0.T7HudMenuGameMode)
		CoD.HUDUtility.GiveFocus(f70_arg0.T7HudMenuGameMode, f70_arg1.controller)
		if f70_arg0.T7HudMenu then
			f70_arg0.T7HudMenu:registerEventHandler("gain_focus", function(element, event)
				CoD.HUDUtility.GiveFocus(f70_arg0.T7HudMenuGameMode, event.controller)
			end)
		else
			CoD.HUDUtility.GiveFocus(f70_arg0.T7HudMenuGameMode, f70_arg1.controller)
		end
		f70_arg0:setAlpha(1)
		if f70_arg0.T7HudMenuGameMode then
			f0_local18(f70_arg0, f70_arg0.T7HudMenuGameMode, f70_arg1.controller)
		end
		if CoD.isMultiplayer then
			f0_local19(f70_arg0, f70_arg0.T7HudMenu, f70_arg1.controller)
		end
		CoD.scoreInfoTable = CoD.GameTypeUtility.GetGameTypeValue(f70_local3, "scoreInfoFile", nil) or CoD.scoreInfoTable
		f0_local20(f70_arg0, f70_arg1.controller)
		CoD.DemoUtility.AddHUDWidgets(f70_arg0.T7HudMenuGameMode, f70_arg1)
		if f70_arg0.T7HudMenuGameMode then
			if f70_arg0.positionDraftSub then
				f70_arg0:removeSubscription(f70_arg0.positionDraftSub)
			end
			if CoD.isPC and CoD.isWarzone then
				f70_arg0.T7HudMenuGameMode:appendEventHandler("occlusion_change", CoD.PCUtility.OnWZOcclusionChange)
				f70_arg0:appendEventHandler("occlusion_change", function(f72_arg0, f72_arg1)
					CoD.PCUtility.OnWZOcclusionChange(f72_arg0.T7HudMenuGameMode, f72_arg1)
				end)
			end
			if CoD.isMultiplayer then
				local f70_local7 = f70_arg0
				local f70_local6 = f70_arg0.subscribeToModel
				local f70_local8 = Engine[@"getmodelforcontroller"](f70_arg1.controller)
				f70_arg0.positionDraftSub = f70_local6(f70_local7, f70_local8:create("PositionDraft.stage"), function(f73_arg0)
					if f73_arg0 then
						local f73_local0 = f70_arg0
						local f73_local1 = f73_arg0:get()
						if f73_local1 ~= nil and f73_local1 > CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_NONE and f73_local1 <= CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_FINALIZE then
							CreatePrematchDraft(f70_arg0, f70_arg1.controller)
						elseif f73_local1 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_CHOOSE_POST_DRAFT then
							CoD.PlayerRoleUtility.ChooseSpecialistMidMatch(f70_arg0, f70_arg1.controller)
						end
					end
				end)
			end
		end
	end
	local f0_local21 = function(f74_arg0, f74_arg1)
		if f74_arg0._vehicleHackModeSubscription then
			f74_arg0:removeSubscription(f74_arg0._vehicleHackModeSubscription)
		end
		f74_arg0._vehicleHackModeSubscription = f74_arg0:subscribeToGlobalModel(f74_arg1.controller, "HUDItems", "vehicleHack.mode", function(model)
			local f75_local0 = model:get() or 0
			if f74_arg0.vehicleHack and f75_local0 == 0 then
				f74_arg0.vehicleHack:close()
				f74_arg0.vehicleHack = nil
			elseif not f74_arg0.vehicleHack and f75_local0 ~= 0 then
				f74_arg0.vehicleHack = CoD.vehicleHack.new(f74_arg0, f74_arg1.controller, 0, 0, 0, CoD.vehicleHack.__defaultWidth, 0, 0, 0, CoD.vehicleHack.__defaultHeight)
				f74_arg0.vehicleHack.mode = f75_local0
				LUI.OverrideFunction_CallOriginalSecond(f74_arg0.vehicleHack, "close", function()
					f74_arg0.vehicleHack = nil
				end)
				f74_arg0:addForceClosedChild(f74_arg0.vehicleHack, "vehicleHack")
				f74_arg0:sendInitializationEvents(f74_arg0.controller, f74_arg0.vehicleHack)
			elseif f74_arg0.vehicleHack and f74_arg0.vehicleHack.mode ~= f75_local0 then
				CoD.CPUtility.SetupVehicleHack(f74_arg0.vehicleHack, f74_arg1.controller)
			end
		end)
		if f74_arg0._spinnerPuzzleSubscription then
			f74_arg0:removeSubscription(f74_arg0._spinnerPuzzleSubscription)
		end
		f74_arg0._spinnerPuzzleSubscription = f74_arg0:subscribeToGlobalModel(f74_arg1.controller, "SpinnerPuzzle", "active", function(model)
			if model:get() and not f74_arg0.spinnerPuzzle then
				f74_arg0.spinnerPuzzle = CoD.spinnersPuzzle.new(f74_arg0, f74_arg0.controller, 0, 0, 0, CoD.spinnersPuzzle.__defaultWidth, 0, 0, 0, CoD.spinnersPuzzle.__defaultHeight)
				f74_arg0:sendInitializationEvents(f74_arg0.controller, f74_arg0.spinnerPuzzle)
				LUI.OverrideFunction_CallOriginalSecond(f74_arg0.spinnerPuzzle, "close", function()
					f74_arg0.spinnerPuzzle = nil
				end)
				f74_arg0:addForceClosedChild(f74_arg0.spinnerPuzzle, "spinnerPuzzle")
				f74_arg0:sendInitializationEvents(f74_arg0.controller, f74_arg0.spinnerPuzzle)
			elseif not model:get() and f74_arg0.spinnerPuzzle then
				f74_arg0.spinnerPuzzle:close()
				f74_arg0.spinnerPuzzle = nil
			end
		end)
		if f74_arg0._threeRingsSubscription then
			f74_arg0:removeSubscription(f74_arg0._threeRingsSubscription)
		end
		f74_arg0._threeRingsSubscription = f74_arg0:subscribeToGlobalModel(f74_arg1.controller, "ThreeRings", "active", function(model)
			if model:get() and not f74_arg0.threeRings then
				f74_arg0.threeRings = CoD.ThreeRings.new(f74_arg0, f74_arg0.controller, 0, 0, 0, CoD.ThreeRings.__defaultWidth, 0, 0, 0, CoD.ThreeRings.__defaultHeight)
				LUI.OverrideFunction_CallOriginalSecond(f74_arg0.threeRings, "close", function()
					f74_arg0.threeRings = nil
				end)
				f74_arg0:addForceClosedChild(f74_arg0.threeRings, "threeRings")
				f74_arg0:sendInitializationEvents(f74_arg0.controller, f74_arg0.threeRings)
			elseif not model:get() and f74_arg0.threeRings then
				f74_arg0.threeRings:close()
				f74_arg0.threeRings = nil
			end
		end)
		if f74_arg0._axeHackSubscription then
			f74_arg0:removeSubscription(f74_arg0._axeHackSubscription)
		end
		f74_arg0._axeHackSubscription = f74_arg0:subscribeToGlobalModel(f74_arg1.controller, "AxeHack", "active", function(model)
			if model:get() and not f74_arg0.axeHack then
				f74_arg0.axeHack = CoD.AxeHack.new(f74_arg0, f74_arg0.controller, 0, 0, 0, CoD.AxeHack.__defaultWidth, 0, 0, 0, CoD.AxeHack.__defaultHeight)
				f74_arg0.axeHack:setLeftRight(true, true, 0, 0)
				f74_arg0.axeHack:setTopBottom(true, true, 0, 0)
				LUI.OverrideFunction_CallOriginalSecond(f74_arg0.axeHack, "close", function()
					f74_arg0.axeHack = nil
				end)
				f74_arg0:addForceClosedChild(f74_arg0.axeHack, "axeHack")
				f74_arg0:sendInitializationEvents(f74_arg0.controller, f74_arg0.axeHack)
			elseif not model:get() and f74_arg0.axeHack then
				f74_arg0.axeHack:close()
				f74_arg0.axeHack = nil
			end
		end)
	end
	local f0_local22 = function(f83_arg0, f83_arg1)
		if f83_arg0._interferenceSelectorSubscription then
			f83_arg0:removeSubscription(f83_arg0._interferenceSelectorSubscription)
		end
		f83_arg0._interferenceSelectorSubscription = f83_arg0:subscribeToGlobalModel(f83_arg1.controller, "InterferenceSelect", "active", function(model)
			if model:get() == 1 and not f83_arg0.interferenceSelector then
				f83_arg0.interferenceSelector = LUI.createMenu.InterferenceSelector(f83_arg0.controller)
				LUI.OverrideFunction_CallOriginalSecond(f83_arg0.interferenceSelector, "close", function()
					f83_arg0.interferenceSelector = nil
				end)
				f83_arg0:addForceClosedChild(f83_arg0.interferenceSelector, "interferenceSelector")
				f83_arg0.interferenceSelector:sendInitializationEvents(f83_arg0.controller, f83_arg0.interferenceSelector)
				f83_arg0.interferenceSelector:menuOpened(f83_arg0.controller, f83_arg0.interferenceSelector)
			elseif model:get() == 0 and f83_arg0.interferenceSelector then
				f83_arg0.interferenceSelector:close()
				f83_arg0.interferenceSelector = nil
			end
		end)
	end
	function HUD_FirstSnapshot_Campaign(f86_arg0, f86_arg1)
		CoD.CodCasterUtility.SetupUIModels(f86_arg1.controller)
		local f86_local0 = DataSources.HUDItems.getModel(f86_arg1.controller)
		f86_local0 = f86_local0:create("vehicleHack.mode")
		f86_local0:set(0)
		f86_local0 = DataSources.HUDItems.getModel(f86_arg1.controller)
		f86_local0 = f86_local0:create("vehicleHack.level")
		f86_local0:set(0)
		f0_local21(f86_arg0, f86_arg1)
		f0_local22(f86_arg0, f86_arg1)
	end
	function HUD_FirstSnapshot_CombatTraining(f87_arg0, f87_arg1)
		local f87_local0 = Engine[@"getglobalmodel"]()
		local f87_local1 = f87_local0:create("isIntroTutorialMovie")
		local f87_local2 = 0
		if f87_local1 and f87_local1:get() then
			f87_local2 = 1
		end
		Engine[@"sendmenuresponse"](f87_arg1.controller, f87_arg0.menuName, "isIntroTutorialMovie", f87_local2)
	end
	function HUD_FirstSnapshot_Zombie(f88_arg0, f88_arg1)
		CoD.CodCasterUtility.SetupUIModels(f88_arg1.controller)
		local self = LUI.UIElement.new()
		self:setLeftRight(true, true, 0, 0)
		self:setTopBottom(true, true, 0, 0)
		self:sizeToSafeArea(f88_arg1.controller)
		f88_arg0:addForceClosedChild(self)
		HUD_DelayLoadMenus()
		f88_arg0.toastNotification = CoD.ToastNotification.new(f88_arg0, f88_arg1.controller, 0.5, 0.5, -960, 960, 0, 0, 0, CoD.ToastNotification.__defaultHeight)
		f88_arg0.toastNotification:setState(f88_arg1.controller, "DefaultState")
		f88_arg0.toastNotification:setPriority(9999)
		local f88_local1 = f88_arg0:getParent()
		if f88_local1 then
			f88_local1:addElement(f88_arg0.toastNotification)
			f88_arg0:addCustomForceClosedWidget(f88_arg0.toastNotification, "toastNotification")
		end
		if f88_arg0.T7HudMenuGameMode == nil then
			local f88_local2 = LUI.createMenu["T7Hud_" .. Engine[@"getcurrentmap"]()]
			if f88_local2 then
				f88_arg0.T7HudMenuGameMode = f88_local2(f88_arg1.controller)
			else
				f88_arg0.T7HudMenuGameMode = LUI.createMenu.T7Hud_zm_factory(f88_arg1.controller)
			end
		else
			f88_arg0.T7HudMenuGameMode:setAlpha(1)
			local f88_local3 = Engine[@"getmodelforcontroller"](f88_arg1.controller)
			if f88_local3 then
				f88_local3 = Engine[@"getmodel"](f88_local3, "hudItems.playerSpawned")
			end
			if f88_local3 and Engine[@"getmodelvalue"](f88_local3) then
				Engine[@"setmodelvalue"](f88_local3, true)
			end
		end
		f88_arg0:addElement(f88_arg0.T7HudMenuGameMode)
		if CoD.isPC then
			CoD.PCUtility.DisableKeyboardNavigationInMenu(f88_arg0.T7HudMenuGameMode)
		end
		f88_arg0.T7HudMenuGameMode:menuOpened(f88_arg1.controller, f88_arg0.T7HudMenuGameMode)
		if f88_arg0.T7HudMenuGameMode then
			if f88_arg0.positionDraftSub then
				f88_arg0:removeSubscription(f88_arg0.positionDraftSub)
			end
			local f88_local2 = f88_arg0
			local f88_local3 = f88_arg0.subscribeToModel
			local f88_local4 = Engine[@"getmodelforcontroller"](f88_arg1.controller)
			f88_arg0.positionDraftSub = f88_local3(f88_local2, f88_local4:create("PositionDraft.stage"), function(f89_arg0)
				if f89_arg0 then
					local f89_local0 = f88_arg0
					local f89_local1 = f89_arg0:get()
					if f89_local1 ~= nil and f89_local1 > CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_NONE then
						CreatePrematchDraft(f88_arg0, f88_arg1.controller)
					end
				end
			end)
		end
		CoD.DemoUtility.AddHUDWidgets(f88_arg0.T7HudMenuGameMode, f88_arg1)
	end
	function HasAnyChildWithID(f90_arg0, f90_arg1)
		local f90_local0 = f90_arg0:getFirstChild()
		while f90_local0 ~= nil do
			if f90_local0.id == f90_arg1 then
				return true
			end
			f90_local0 = f90_local0:getNextSibling()
		end
		return false
	end
	f0_local0 = function(f91_arg0, f91_arg1)
		if not f91_arg0.firstSnapshotProcessed then
			if not f91_arg0.pendingInGameMenuEvents then
				f91_arg0.pendingInGameMenuEvents = {}
			end
			table.insert(f91_arg0.pendingInGameMenuEvents, f91_arg1)
			return
		elseif type(f91_arg1.menuName) == "xhash" then
			local f91_local0 = nil
			for f91_local4, f91_local5 in pairs(LUI.createMenu) do
				if Engine[@"converttoxhash"](f91_local4) == f91_arg1.menuName then
					f91_local0 = f91_local4
					break
				end
			end
			if not f91_local0 then
				for f91_local4, f91_local5 in pairs(CoD.OverlayUtility.Overlays) do
					if Engine[@"converttoxhash"](f91_local4) == f91_arg1.menuName then
						f91_local0 = f91_local4
						break
					end
				end
			end
			if not f91_local0 then
				return
			end
			f91_arg1.menuName = f91_local0
		end
		if f91_arg1.menuName == "DOA_INGAME_PAUSE" and CoD.isDOAPauseMenuOpen ~= nil and CoD.isDOAPauseMenuOpen == true then
			return
		elseif f91_arg1.menuName == "StartMenu_Main" then
			if Engine[@"ismigrating"](f91_arg1.controller) == true then
				return
			end
			local f91_local0 = f91_arg0:getParent()
			if f91_local0 ~= nil and HasAnyChildWithID(f91_local0, "Menu.StartMenu_Main") then
				return
			end
		end
		if Engine[@"canpausegame"]() then
			if CoD.InGameMenu.m_unpauseDisabled == nil then
				CoD.InGameMenu.m_unpauseDisabled = {}
			end
			CoD.InGameMenu.m_unpauseDisabled[f91_arg1.controller + 1] = 0
			if f91_arg1.unpausable ~= nil and f91_arg1.unpausable == 0 then
				CoD.InGameMenu.m_unpauseDisabled[f91_arg1.controller + 1] = 1
			end
		end
		if f91_arg1.data ~= nil then
			f91_arg1.menuName = Engine[@"getistring"](f91_arg1.data[1], "CS_SCRIPT_MENUS")
		end
		local f91_local0 = nil
		CoD.Menu.ModelToUse = f91_arg1.model
		if f91_arg1.menuName == "StartMenu_Main" then
			local f91_local2 = function(f92_arg0)
				if not CoD.isPC or not CoD.isWarzone then
					return false
				elseif Engine[@"isdemoplaying"]() then
					return false
				end
				local f92_local0 = Engine[@"getmodelforcontroller"](f92_arg0)
				f92_local0 = f92_local0.gameScore
				if f92_local0 then
					f92_local0 = Engine[@"getmodelforcontroller"](f92_arg0)
					f92_local0 = f92_local0.gameScore.currentState:get()
				end
				if f92_local0 ~= nil and f92_local0 ~= "" then
					return true
				elseif IsVisibilityBitSet(f92_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) then
					return true
				end
				return false
			end
			if f91_local2(f91_arg1.controller) then
				f91_local2 = QuitPCGame_WZ_Spectating(f91_arg0, f91_arg1.controller, true)
				if f91_local2 then
					LUI.OverrideFunction_CallOriginalFirst(f91_local2, "close", function()
						StartMenuResumeGame(f91_local2, f91_arg1.controller)
					end)
				end
				return nil
			end
			f91_local0 = f91_arg0.startMenu
			f91_local0:setOccludedMenu(f91_arg0)
			f91_local0.m_disableAllButtonActions = false
			f91_local2 = LUI.getTableFromPath("SafeAreaContainer.TabBar.Tabs.grid", f91_local0)
			if f91_local2 then
				f91_local2:updateDataSource(true)
			end
			if CoD.isPC then
				CoD.PCUtility.MigrateStickyElementsForward(f91_local0, f91_arg0.controller)
			end
			local f91_local3 = f91_arg0:getParent()
			f91_local3:addElement(f91_local0)
			DataSources.FreeCursor.registerButtonPrompts(f91_arg0.controller, f91_local0.buttonModel)
			if not CoD.isWarzone then
				DataSources.XPProgressionBar.getModel(f91_arg0.controller)
			end
			f91_local0:onStartMenuOpened(f91_arg0.controller)
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f91_local0, f91_local0, f91_arg0.controller)
			if CoD.isPC then
				CoD.PCUtility.DeactivateMenuChat(f91_arg1.controller)
			end
		elseif LUI.createMenu[f91_arg1.menuName] ~= nil then
			f0_local9 = true
			if f91_arg1.menuName == "ChooseClass_InGame" or f91_arg1.menuName == "PositionDraft" then
				f91_arg0:dispatchEventToRoot({
					name = "close_menu",
					menuName = f91_arg1.menuName,
					controller = f91_arg1.controller,
				})
			end
			if f91_arg1.isMenu or LUI.hudMenuType[f91_arg1.menuName] == "hud" then
				f91_local0 = f91_arg0:openMenu(f91_arg1.menuName, f91_arg1.controller)
				if f91_local0._priority ~= nil then
					f91_local0:setPriority(f91_local0._priority)
				end
			else
				f91_local0 = f91_arg0:openPopup(f91_arg1.menuName, f91_arg1.controller)
			end
			if CoD.isPC and f91_arg1.menuName == "BountyHunterBuy" then
				CoD.ChatClientUtility.SetIsInBountyHunterMenu(true)
				CoD.PCUtility.MigrateStickyElementsForward(f91_local0, f91_arg0.controller)
			end
		else
			f91_local0 = CoD.OverlayUtility.CreateOverlay(f91_arg1.controller, f91_arg0, f91_arg1.menuName, f91_arg1.controller)
			if f91_local0 then
				f0_local9 = true
			end
		end
		if f91_local0 and f91_local0:getModel() then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f91_local0:getModel(), "close_current_menu"), 0)
			f91_local0:subscribeToCloseMenuModel()
			f91_local0:subscribeToStateModel(f91_arg1.controller)
			f91_local0:subscribeToCurrAnimationModel()
		end
		CoD.Menu.ModelToUse = nil
		return f91_local0
	end
	function HUD_CloseSpecificInGameMenu(f94_arg0, f94_arg1)
		if f94_arg1.data ~= nil then
			if f94_arg0.pendingInGameMenuEvents then
				for f94_local0 = #f94_arg0.pendingInGameMenuEvents, 1, -1 do
					if f94_arg0.pendingInGameMenuEvents[f94_local0].controller == f94_arg1.controller and (not (not f94_arg0.pendingInGameMenuEvents[f94_local0].data or f94_arg0.pendingInGameMenuEvents[f94_local0].data[1] ~= f94_arg1.data[1]) or f94_arg0.pendingInGameMenuEvents[f94_local0].menuName and f94_arg0.pendingInGameMenuEvents[f94_local0].menuName == f94_arg1.menuName) then
						table.remove(f94_arg0.pendingInGameMenuEvents, f94_local0)
					end
				end
			end
			f94_arg0:dispatchEventToRoot({
				name = "close_menu",
				menuName = Engine[@"getistring"](f94_arg1.data[1], "CS_SCRIPT_MENUS"),
				controller = f94_arg1.controller,
			})
		end
	end
	function HUD_OpenHudMenu(f95_arg0, f95_arg1)
		f95_arg1.isMenu = true
		f0_local0(f95_arg0, f95_arg1)
		return true
	end
	function HUD_CloseHudMenu(f96_arg0, f96_arg1)
		local f96_local0 = f96_arg1.menuName
		if f96_local0 then
			f96_arg0:dispatchEventToRoot({
				name = "close_menu",
				menuName = f96_local0,
				controller = f96_arg1.controller,
			})
		end
	end
	function HUD_Close(f97_arg0, f97_arg1)
		if f97_arg0.safeArea and f97_arg0.safeArea.buttonModel then
			if LUI.DEV then
				local f97_local0 = LUI.DEV.ErrorIfModelsDoNotMatch(f97_arg0.safeArea.buttonModel, Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f97_arg0:getOwner() or 0), "HUDSafeArea.buttonPrompts"))
			end
			Engine[@"unsubscribeandfreemodel"](f97_arg0.safeArea.buttonModel)
		end
		f97_arg0.safeArea.buttonModel = nil
		f97_arg0:close()
	end
	function HUD_OpenHudPopup(f98_arg0, f98_arg1)
		f0_local0(f98_arg0, f98_arg1)
		return true
	end
	function HUD_CloseInGameMenu(f99_arg0, f99_arg1)
		if Engine[@"canpausegame"]() then
			if CoD.InGameMenu.m_unpauseDisabled == nil then
				CoD.InGameMenu.m_unpauseDisabled = {}
			end
			CoD.InGameMenu.m_unpauseDisabled[f99_arg1.controller + 1] = 0
		end
		f0_local9 = nil
		if Engine[@"canpausegame"]() then
			Engine[@"setactivemenu"](f99_arg1.controller, Enum[@"uimenucommand_t"][@"uimenu_none"])
		end
	end
	function HUD_DebugReload(f100_arg0, f100_arg1)
		if f100_arg0.m_eventHandlers.debug_reload ~= HUD_DebugReload then
			f100_arg0:registerEventHandler("debug_reload", HUD_DebugReload)
			f100_arg0:processEvent({
				name = "debug_reload",
			})
			return
		else
			HUD_FirstSnapshot(f100_arg0, {
				controller = f100_arg0.controller,
				debugReload = true,
			})
			Engine[@"forcehudrefresh"](f100_arg0.controller)
			f100_arg0:processEvent({
				name = "hud_boot",
				controller = f100_arg0.controller,
			})
			Engine[@"setmodelvalue"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f100_arg0.controller), "scriptNotify"), @"player_spawned")
		end
	end
	function HUD_UpdateRefresh(f101_arg0, f101_arg1)
		local f101_local0 = DataSources.VehicleInfo.getModel(f101_arg1.controller)
		f101_local0 = f101_local0.vehicleType:get()
		if f101_local0 then
			f0_local11(f101_arg0, f101_arg1.controller, f101_local0, true)
		end
		local f101_local1 = CoD.SafeGetModelValue(DataSources.CurrentWeapon.getModel(f101_arg1.controller), "weaponReticle")
		if f101_local1 then
			f0_local13(f101_arg0, f101_arg1.controller, f101_local1, true)
		end
		f0_local4(f101_arg0, f101_arg1)
		f0_local2(f101_arg0, f101_arg1)
	end
	function HUD_FullscreenStart(f102_arg0, f102_arg1)
		f102_arg0:dispatchEventToChildren(f102_arg1)
		CoD.HUDUtility.FullscreenController = f102_arg1.controller
	end
	function HUD_FullscreenStop(f103_arg0, f103_arg1)
		f103_arg0:dispatchEventToChildren(f103_arg1)
		CoD.HUDUtility.FullscreenController = nil
	end
	function HUD_UpdateScoreboardColumns(f104_arg0, f104_arg1) end
	function HUD_StartKillcamHud(f105_arg0, f105_arg1)
		if f105_arg0.T7HudMenu and not f105_arg0._isKillcamHUDOpen then
			if Engine[@"updatekillcamuimodels"] then
				Engine[@"updatekillcamuimodels"](f105_arg1.controller, Engine[@"getpredictedclientnum"](f105_arg1.controller))
			end
			if f105_arg0.killcamHUD and f105_arg0.killcamHUD.persistent then
				f105_arg0.killcamHUD:setAlpha(1)
			else
				assert(CoD.isWarzone)
				f105_arg0.killcamHUD = LUI.createMenu.KillcamMenu_WZ(f105_arg1.controller)
				f105_arg0.killcamHUD:menuOpened(f105_arg1.controller, f105_arg0.killcamHUD)
			end
			if CoD.isWarzone then
				f105_arg0:addElement(f105_arg0.killcamHUD)
			else
			end
			assert(f105_arg0.killcamHUD)
			f105_arg0._isKillcamHUDOpen = true
		end
	end
	function HUD_StopKillcamHud(f106_arg0, f106_arg1)
		if f106_arg0._isKillcamHUDOpen then
			if f106_arg0.killcamHUD then
				if f106_arg0.killcamHUD.persistent then
					f106_arg0.killcamHUD:setAlpha(0)
				else
					f106_arg0.killcamHUD:close()
					f106_arg0.killcamHUD = nil
				end
			end
			f106_arg0._isKillcamHUDOpen = false
		end
	end
	f0_local2 = function(f107_arg0, f107_arg1)
		if Engine[@"isvisibilitybitset"](f107_arg1.controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) or Engine[@"isvisibilitybitset"](f107_arg1.controller, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) or Engine[@"isvisibilitybitset"](f107_arg1.controller, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) or Engine[@"isvisibilitybitset"](f107_arg1.controller, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) then
			HUD_StartKillcamHud(f107_arg0, f107_arg1)
		else
			HUD_StopKillcamHud(f107_arg0, f107_arg1)
		end
	end
	local f0_local23 = function(f108_arg0)
		local f108_local0
		if Engine[@"issplitscreen"]() == false then
			if Engine[@"isdemoshoutcaster"]() ~= true then
				f108_local0 = Engine[@"isvisibilitybitset"](f108_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
				if f108_local0 then
					f108_local0 = Engine[@"isvisibilitybitset"](f108_arg0, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
					if f108_local0 then
						if not Engine[@"isvisibilitybitset"](f108_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
							f108_local0 = not Engine[@"isvisibilitybitset"](f108_arg0, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						else
							f108_local0 = false
						end
					end
				end
			else
				f108_local0 = true
			end
		else
			f108_local0 = false
		end
		return f108_local0
	end
	local f0_local24 = function(f109_arg0)
		return Engine[@"isvisibilitybitset"](f109_arg0, Enum[@"uivisibilitybit"][@"bit_selecting_location"]) and not Engine[@"isvisibilitybitset"](f109_arg0, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
	end
	if not CoD.isZombie then
		require("x64:d923ab4f5b48d75")
	end
	f0_local4 = function(f110_arg0, f110_arg1)
		if f0_local24(f110_arg1.controller) then
			if f110_arg0.newLocationSelectorMap == nil then
				f110_arg0.newLocationSelectorMap = CoD.TabletLocationSelector.new(f110_arg0, f110_arg1.controller, 0, 0, 0, CoD.TabletLocationSelector.__defaultWidth, 0, 0, 0, CoD.TabletLocationSelector.__defaultHeight)
				LUI.OverrideFunction_CallOriginalSecond(f110_arg0.newLocationSelectorMap, "close", function()
					f110_arg0.newLocationSelectorMap = nil
				end)
				f110_arg0:addForceClosedChild(f110_arg0.newLocationSelectorMap, "newLocationSelectorMap")
				f110_arg0:sendInitializationEvents(f110_arg0.controller, f110_arg0.newLocationSelectorMap)
			end
		elseif f110_arg0.newLocationSelectorMap ~= nil then
			f110_arg0.newLocationSelectorMap:close()
			f110_arg0.newLocationSelectorMap = nil
		end
	end
	f0_local3 = function(f112_arg0, f112_arg1)
		if f112_arg0 ~= nil then
			local f112_local0 = f112_arg0:getOwner()
			if f112_local0 ~= nil then
				Engine[@"disablescenefilter"](f112_local0, 4)
			end
		end
	end
	f0_local5 = function(f113_arg0, f113_arg1)
		local f113_local0 = f113_arg1.data[1]
		local f113_local1 = f113_arg1.data[2]
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f113_arg1.controller), "Attacker"), "kills"), f113_local0)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f113_arg1.controller), "Victim"), "kills"), f113_local1)
	end
	f0_local6 = function(f114_arg0, f114_arg1)
		local f114_local0 = f114_arg1.data[1]
		local f114_local1 = f114_arg1.data[2]
		local f114_local2 = f114_arg1.data[3]
		local f114_local3 = f114_arg1.data[4]
		local f114_local4 = f114_arg1.data[5]
		local f114_local5 = Engine[@"getmodelforclient"](f114_local0)
		local f114_local6 = f114_local5.scoreboard.killStats[f114_local1]
		if f114_local6 then
			f114_local6.clientNum:set(f114_local2)
			f114_local6.killed:set(f114_local3)
			f114_local6.killedBy:set(f114_local4)
		end
	end
	function HUD_IsFFA()
		if f0_local7 == nil then
			local f115_local0 = Engine[@"lobbygetgametype"]()
			local f115_local1
			if f115_local0 ~= "dm" and f115_local0 ~= "hcdm" and f115_local0 ~= "hack" then
				f115_local1 = false
			else
				f115_local1 = true
			end
			f0_local7 = f115_local1
		end
		return f0_local7
	end
	function HUD_Handle_ChooseClass_HotKey(f116_arg0, f116_arg1)
		if UIExpression.Team(f116_arg1.controller, "name") ~= "TEAM_SPECTATOR" and CoD.IsWagerMode() == false and not (Engine[@"getgametypesetting"](@"disableclassselection") == 1) then
			f0_local0(f116_arg0, {
				menuName = "changeclass",
				controller = f116_arg1.controller,
			})
		end
	end
end
DisableGlobals()
Engine[@"stopeditingpresetclass"]()
