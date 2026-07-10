CoD.BaseUtility = {}
local f0_local0 = Engine[@"getcurrentplatform"]()
CoD.BaseUtility.isDurango = f0_local0 == "durango"
CoD.BaseUtility.isPC = f0_local0 == "pc"
CoD.BaseUtility.isPS4 = f0_local0 == "orbis"
CoD.BaseUtility.InvalidXHash = Engine[@"numbertouint64"](0)
CoD.BaseUtility.CreateControllerModel = function(f1_arg0, f1_arg1)
	Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f1_arg0), f1_arg1)
end
CoD.BaseUtility.CreatePersistentControllerModel = function(f2_arg0, f2_arg1)
	local f2_local0 = Engine[@"getmodelforcontroller"](f2_arg0)
	f2_local0:create(f2_arg1, true)
end
CoD.BaseUtility.InitControllerModel = function(f3_arg0, f3_arg1, f3_arg2)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f3_arg0), f3_arg1), f3_arg2)
end
CoD.BaseUtility.InitDirectorCharacterControllerModels = function()
	for f4_local0 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
		CoD.BaseUtility.InitControllerModel(f4_local0, "PositionDraft.autoSelected", -1)
		CoD.BaseUtility.CreateControllerModel(f4_local0, "PositionDraft.stage")
		CoD.BaseUtility.CreateControllerModel(f4_local0, "PositionDraft.focusedCharacterIndex")
		SetControllerModelValue(f4_local0, "PositionDraft.focusedCharacterIndex", -1)
	end
end
CoD.BaseUtility.InitControllerModelIfNotSet = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = Engine[@"getmodelforcontroller"](f5_arg0)
	if not f5_local0[f5_arg1] then
		local f5_local1 = f5_local0:create(f5_arg1)
		f5_local1:set(f5_arg2)
	end
end
CoD.BaseUtility.InitPersistentControllerModelIfNotSet = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = Engine[@"getmodelforcontroller"](f6_arg0)
	if not f6_local0[f6_arg1] then
		local f6_local1 = f6_local0:create(f6_arg1, true)
		f6_local1:set(f6_arg2)
	end
end
CoD.BaseUtility.InitControllerModelEnumIfNotSet = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = Engine[@"getmodelforcontroller"](f7_arg0)
	if not f7_local0[f7_arg1] then
		local f7_local1 = f7_local0:create(f7_arg1)
		f7_local1:set(f7_arg2)
	end
end
CoD.BaseUtility.SetControllerModelToSelfModelValue = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = Engine[@"getmodelforcontroller"](f8_arg0)
	f8_local0 = f8_local0[f8_arg2]
	local f8_local1 = f8_arg1:getModel()
	f8_local0:set(f8_local1[f8_arg3]:get())
end
CoD.BaseUtility.SetProfileVarToSelfModelValue = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = f9_arg2:getModel()
	Engine[@"setprofilevar"](f9_arg0, f9_arg1, tostring(f9_local0[f9_arg3]:get()))
	Engine[@"commitprofilechanges"](f9_arg0)
end
CoD.BaseUtility.CreateGlobalModel = function(f10_arg0)
	Engine[@"createmodel"](Engine[@"getglobalmodel"](), f10_arg0)
end
CoD.BaseUtility.InitGlobalModel = function(f11_arg0, f11_arg1)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), f11_arg0), f11_arg1)
end
CoD.BaseUtility.SetMenuSessionMode = function(f12_arg0, f12_arg1)
	f12_arg0:setSessionMode(f12_arg1)
end
CoD.BaseUtility.GetMenuSessionMode = function(f13_arg0)
	return f13_arg0:getSessionMode()
end
CoD.BaseUtility.SetMenuSessionModeByElementModel = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = f14_arg0
	local f14_local1 = f14_arg0.setSessionMode
	local f14_local2 = f14_arg1:getModel()
	f14_local1(f14_local0, f14_local2[f14_arg2]:get())
end
CoD.BaseUtility.SetInGameMenuSessionMode = function(f15_arg0)
	if not CoD.isFrontend then
		f15_arg0:setSessionMode(Engine[@"currentsessionmode"]())
	end
end
CoD.BaseUtility.SetDefaultFocusToElement = function(f16_arg0, f16_arg1)
	f16_arg0.__defaultFocus = f16_arg1
end
CoD.BaseUtility.IsMenuSessionModeEqualTo = function(f17_arg0, f17_arg1)
	return CoD.BaseUtility.GetMenuSessionMode(f17_arg0) == f17_arg1
end
CoD.BaseUtility.GetMenuModel = function(f18_arg0)
	return f18_arg0._model
end
CoD.BaseUtility.GetMenuLoadoutSlot = function(f19_arg0)
	return f19_arg0._loadoutSlot
end
CoD.BaseUtility.GetMenuAttachmentFilter = function(f20_arg0)
	return f20_arg0._attachmentFilter
end
CoD.BaseUtility.GetMenuLoadoutListItemSlot = function(f21_arg0)
	return f21_arg0._loadoutListItemSlot
end
CoD.BaseUtility.GetMenuStorageBuffer = function(f22_arg0)
	return f22_arg0._storageBuffer
end
CoD.BaseUtility.GetMenuStorageClientBuffer = function(f23_arg0)
	return f23_arg0._storageClientBuffer
end
CoD.BaseUtility.GetMenuStorageLoadoutBuffer = function(f24_arg0)
	return f24_arg0._storageLoadoutBuffer
end
CoD.BaseUtility.IsMenuContextualEquipping = function(f25_arg0)
	return f25_arg0._isContextualEquipping
end
CoD.BaseUtility.GetMenuContextualEquipSlot = function(f26_arg0)
	return f26_arg0._contextualEquipSlot
end
CoD.BaseUtility.IsMenuLoadoutSlotEqualTo = function(f27_arg0, f27_arg1)
	return CoD.BaseUtility.GetMenuLoadoutSlot(f27_arg0) == f27_arg1
end
CoD.BaseUtility.SetMenuModelToElementModel = function(f28_arg0, f28_arg1)
	f28_arg0._model = f28_arg1:getModel()
end
CoD.BaseUtility.SetElementModelToNil = function(f29_arg0, f29_arg1)
	f29_arg1:setModel(nil, f29_arg0)
end
CoD.BaseUtility.SetElementModelToOtherElementModel = function(f30_arg0, f30_arg1, f30_arg2)
	f30_arg1:setModel(f30_arg2:getModel(), f30_arg0)
end
CoD.BaseUtility.SetElementModelToOtherElementModelFromPath = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
	f31_arg1:setModel(LUI.getTableFromPath(f31_arg3, f31_arg2:getModel()), f31_arg0)
end
CoD.BaseUtility.SetElementModelToActiveWidgetModel = function(f32_arg0, f32_arg1, f32_arg2)
	if f32_arg2.activeWidget then
		f32_arg1:setModel(f32_arg2.activeWidget:getModel(), f32_arg0)
	end
end
CoD.BaseUtility.SetModelFromPropertyModel = function(f33_arg0, f33_arg1, f33_arg2)
	if f33_arg2._model then
		f33_arg1:setModel(f33_arg2._model, f33_arg0)
	end
end
CoD.BaseUtility.SetElementModelFromPropertyModel = function(f34_arg0, f34_arg1, f34_arg2)
	if f34_arg1._model then
		f34_arg2:setModel(f34_arg1._model, f34_arg0)
	end
end
CoD.BaseUtility.SetModelFromExpression = function(f35_arg0, f35_arg1, f35_arg2)
	f35_arg1:setModel(f35_arg2, f35_arg0)
end
CoD.BaseUtility.SendCustomMenuResponse = function(f36_arg0, f36_arg1, f36_arg2, f36_arg3)
	Engine[@"sendmenuresponse"](f36_arg0, f36_arg1, f36_arg2, f36_arg3)
end
CoD.BaseUtility.SendModelValueAsCustomMenuResponse = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
	local f37_local0 = CoD.SafeGetModelValue(f37_arg1:getModel(), f37_arg4)
	if not f37_local0 then
		return
	else
		Engine[@"sendmenuresponse"](f37_arg0, f37_arg2, f37_arg3, f37_local0)
	end
end
CoD.BaseUtility.GetMenuModelModeLoadoutSlot = function(f38_arg0)
	return CoD.BaseUtility.GetMenuModel(f38_arg0), CoD.BaseUtility.GetMenuSessionMode(f38_arg0), CoD.BaseUtility.GetMenuLoadoutSlot(f38_arg0)
end
CoD.BaseUtility.CachedKeyedLocStringTables = {}
CoD.BaseUtility.GetLocStringListEntry = function(f39_arg0, f39_arg1)
	if tonumber(f39_arg1) then
		local f39_local0 = Engine[@"hash_2E00B2F29271C60B"](f39_arg0)
		return f39_local0.entries[f39_arg1][@"value"]
	elseif not CoD.BaseUtility.CachedKeyedLocStringTables[f39_arg0] then
		local f39_local0 = Engine[@"hash_2E00B2F29271C60B"](f39_arg0)
		CoD.BaseUtility.CachedKeyedLocStringTables[f39_arg0] = {}
		for f39_local4, f39_local5 in ipairs(f39_local0.entries) do
			CoD.BaseUtility.CachedKeyedLocStringTables[f39_arg0][f39_local4] = f39_local5[@"value"]
			if f39_local5[@"key"] then
				CoD.BaseUtility.CachedKeyedLocStringTables[f39_arg0][f39_local5[@"key"]] = f39_local5[@"value"]
			end
		end
	end
	return CoD.BaseUtility.CachedKeyedLocStringTables[f39_arg0][f39_arg1]
end
CoD.BaseUtility.ShownIfEqualToGlobalModelValue = function(f40_arg0, f40_arg1)
	local f40_local0 = Engine[@"getglobalmodel"]()
	if not f40_local0 then
		return false
	else
		local f40_local1
		if f40_arg1 == f40_local0[f40_arg0]:get() then
			f40_local1 = 1
			if not f40_local1 then
			else
				return f40_local1
			end
		end
	end
	f40_local1 = 0
end
CoD.BaseUtility.CopyVectorComponent = function(f41_arg0, f41_arg1, f41_arg2, f41_arg3, f41_arg4, f41_arg5)
	local f41_local0 = {
		f41_arg2,
		f41_arg3,
		f41_arg4,
		f41_arg5,
		[f41_arg1] = f41_local0[f41_arg0],
	}
	return unpack(f41_local0)
end
CoD.BaseUtility.OrbisDurangoPCValue = function(f42_arg0, f42_arg1, f42_arg2)
	if CoD.isPS4 then
		local f42_local0 = f42_arg0
	end
	if CoD.isDurango then
		local f42_local1 = f42_arg1
	end
	if CoD.isPC then
		local f42_local2 = f42_arg2
	end
	return f42_local2 or f42_local1 or f42_local0 or nil
end
CoD.BaseUtility.OwnSeasonPass = function(f43_arg0)
	return Engine[@"ownseasonpass"](f43_arg0)
end
CoD.BaseUtility.IsKnownDLC = function(f44_arg0)
	local f44_local0
	if f44_arg0 ~= nil then
		f44_local0 = CoD.BitUtility.IsBitwiseAndNonZero(CoD.BaseUtility.GetKnownDLCBits(), f44_arg0)
	else
		f44_local0 = false
	end
	return f44_local0
end
CoD.BaseUtility.IsHiddenDLC = function(f45_arg0)
	return CoD.DLCPackFromBit[f45_arg0] and f45_local0 and not CoD.ProductIsKnown[f45_arg0]
end
CoD.BaseUtility.SwitchMode = function(f46_arg0, f46_arg1)
	local f46_local0 = LuaUtils.EModeData[f46_arg1]
	local f46_local1
	if f46_local0 then
		f46_local1 = f46_local0.Abbreviation
		if not f46_local1 then
		else
			Engine[@"switchmode"](f46_arg0, f46_local1)
		end
	end
	f46_local1 = ""
end
CoD.BaseUtility.SwitchModeOnMenu = function(f47_arg0)
	local f47_local0 = LobbyData.GetCurrentMenuTarget()
	CoD.BaseUtility.SwitchMode(f47_arg0, LuaUtils.GetEModeForLobbyMainMode(f47_local0[@"mainmode"]))
end
CoD.BaseUtility.ProcessGridAction = function(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
	if f48_arg3 and f48_arg3.element then
		ProcessListAction(f48_arg1, f48_arg3.element, f48_arg2)
	end
end
CoD.BaseUtility.ParseKnownDLC = function()
	CoD.ProductIsKnown = {}
	CoD.ProductBitFromId = {}
	for f49_local7, f49_local8 in pairs(CoD.ProductFromBit) do
		for f49_local3, f49_local4 in pairs(f49_local8.products) do
			CoD.ProductBitFromId[f49_local4] = f49_local3
			local f49_local6 = Engine[@"hash_21B38356C98D220B"](f49_local4)
			if CoD.ProductIsKnown[f49_local3] then
				f49_local8.known = f49_local8.known | f49_local3
			end
			if f49_local6 and f49_local6.visibility then
				CoD.ProductIsKnown[f49_local3] = true
				f49_local8.known = f49_local8.known | f49_local3
			end
		end
	end
end
CoD.BaseUtility.ParseKnownDLC()
CoD.BaseUtility.GetKnownDLCBits = function()
	return CoD.ProductFromBit[Engine[@"currentsessionmode"]()].known
end
CoD.BaseUtility.GetMapDataFromMapID = function(f51_arg0)
	if f51_arg0 ~= nil then
		for f51_local3, f51_local4 in pairs(CoD.MapUtility.MapsTable) do
			if f51_local4.uniqueID == f51_arg0 then
				return f51_local4
			end
		end
	end
end
CoD.BaseUtility.GetMapIDFromMapUniqueID = function(f52_arg0)
	if f52_arg0 ~= nil then
		for f52_local3, f52_local4 in pairs(CoD.MapUtility.MapsTable) do
			if f52_local4.uniqueID == f52_arg0 then
				return f52_local3
			end
		end
	end
end
CoD.BaseUtility.GetMapValue = function(f53_arg0, f53_arg1, f53_arg2)
	f53_arg0 = CoD.MapUtility.ConvertMapNameToXHash(f53_arg0)
	if CoD.MapUtility.MapsTable[f53_arg0] ~= nil and CoD.MapUtility.MapsTable[f53_arg0][f53_arg1] ~= nil then
		return CoD.MapUtility.MapsTable[f53_arg0][f53_arg1]
	else
		return f53_arg2
	end
end
CoD.BaseUtility.GetGameModeOnMapNameString = function(f54_arg0, f54_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](@"menu/x_on_x", Engine[@"hash_4F9F1239CFD921FE"](CoD.GameTypeUtility.GetGameTypeValue(f54_arg0, "nameRef", 0x0)), CoD.MapUtility.GetMapValue(f54_arg1, "mapName", 0x0))
end
CoD.BaseUtility.AlreadyRegistered = function(f55_arg0)
	return f55_arg0
end
CoD.BaseUtility.AlreadyRegisteredIfUserData = function(f56_arg0)
	if type(f56_arg0) == "userdata" then
		return f56_arg0
	else
		return RegisterImage(f56_arg0)
	end
end
CoD.BaseUtility.AlreadyRegisteredIfUserDataOrCallingCard = function(f57_arg0)
	if type(f57_arg0) == "userdata" then
		return f57_arg0
	elseif CoD.ChallengesUtility.IsWidgetBasedCallingCard(f57_arg0) then
		return RegisterImage(@"blacktransparent")
	else
		return RegisterImage(f57_arg0)
	end
end
CoD.BaseUtility.NonStringWorkaround = function(f58_arg0)
	return "INVALID STRING REFERENCE " .. f58_arg0 .. ", FIX THE LUA"
end
CoD.BaseUtility.AlreadyLocalized = function(f59_arg0)
	return f59_arg0
end
CoD.BaseUtility.LocalizeIfNotCodcaster = function(f60_arg0, f60_arg1)
	if not CoD.CodCasterUtility.IsCodCasterOrAssigned(f60_arg0) then
		return Engine[@"hash_4F9F1239CFD921FE"](f60_arg1)
	else
		return f60_arg1
	end
end
CoD.BaseUtility.LocalizeIfXHash = function(f61_arg0)
	if type(f61_arg0) == "xhash" then
		return Engine[@"hash_4F9F1239CFD921FE"](f61_arg0)
	else
		return f61_arg0
	end
end
CoD.BaseUtility.LocalizeKeybindingInputs = function(f62_arg0)
	if string.len(f62_arg0) < 2 then
		return f62_arg0
	elseif LUI.startswith(f62_arg0, "^") then
		return f62_arg0
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f62_arg0)
	end
end
CoD.BaseUtility.PairsByKeys = function(f63_arg0, f63_arg1)
	local f63_local0 = {}
	for f63_local4, f63_local5 in pairs(f63_arg0) do
		table.insert(f63_local0, f63_local4)
	end
	table.sort(f63_local0, f63_arg1)
	f63_local1 = 0
	return function()
		f63_local1 = f63_local1 + 1
		if f63_local0[f63_local1] == nil then
			return nil
		else
			return f63_local0[f63_local1], f63_arg0[f63_local0[f63_local1]]
		end
	end
end
CoD.BaseUtility.GetLeftStickVector = function(f65_arg0)
	local f65_local0 = {
		x = 0,
		y = 0,
	}
	local f65_local1 = Engine[@"getmodelforcontroller"](f65_arg0)
	f65_local1 = f65_local1.LeftStick
	if f65_local1 then
		f65_local0.x = f65_local1.X:get()
		f65_local0.y = f65_local1.Y:get()
	end
	return f65_local0
end
CoD.BaseUtility.GetElementCenterVec = function(f66_arg0)
	local f66_local0, f66_local1, f66_local2, f66_local3 = f66_arg0:getLocalRect()
	return {
		x = (f66_local0 + f66_local2) / 2,
		y = (f66_local3 + f66_local1) / 2,
	}
end
CoD.BaseUtility.Vec2Scale = function(f67_arg0, f67_arg1)
	return {
		x = f67_arg0.x * f67_arg1,
		y = f67_arg0.y * f67_arg1,
	}
end
CoD.BaseUtility.Vec2Add = function(f68_arg0, f68_arg1)
	return {
		x = f68_arg0.x + f68_arg1.x,
		y = f68_arg0.y + f68_arg1.y,
	}
end
CoD.BaseUtility.Vec2Sub = function(f69_arg0, f69_arg1)
	return {
		x = f69_arg0.x - f69_arg1.x,
		y = f69_arg0.y - f69_arg1.y,
	}
end
CoD.BaseUtility.Vec2Dot = function(f70_arg0, f70_arg1)
	return f70_arg0.x * f70_arg1.x + f70_arg0.y * f70_arg1.y
end
CoD.BaseUtility.Vec2LenSq = function(f71_arg0)
	return f71_arg0.x * f71_arg0.x + f71_arg0.y * f71_arg0.y
end
CoD.BaseUtility.Vec2Project = function(f72_arg0, f72_arg1)
	return CoD.BaseUtility.Vec2Scale(f72_arg1, CoD.BaseUtility.Vec2Dot(f72_arg0, f72_arg1) / CoD.BaseUtility.Vec2Dot(f72_arg1, f72_arg1))
end
CoD.BaseUtility.Vec2Reject = function(f73_arg0, f73_arg1)
	return CoD.BaseUtility.Vec2Sub(f73_arg0, CoD.BaseUtility.Vec2Project(f73_arg0, f73_arg1))
end
CoD.BaseUtility.FindSingleFocusableDescendant = function(f74_arg0, f74_arg1)
	if not f74_arg0:allowsCursorMove() then
		return nil
	elseif f74_arg0:isFocusable() then
		if not f74_arg1 or not f74_arg0.m_disableKeyboardNavigation then
			return f74_arg0
		else
			return nil
		end
	end
	local f74_local0 = nil
	local f74_local1 = f74_arg0:getFirstChild()
	if f74_local1 == nil then
		return nil
	end
	while f74_local1 ~= nil do
		f74_local0 = CoD.BaseUtility.FindSingleFocusableDescendant(f74_local1, f74_arg1)
		if f74_local0 ~= nil then
			return f74_local0
		end
		f74_local1 = f74_local1:getNextSibling()
	end
	return nil
end
CoD.BaseUtility.FindAllFocusableDescendant = function(f75_arg0, f75_arg1, f75_arg2)
	if not f75_arg0:allowsCursorMove() then
		return
	elseif f75_arg0:isFocusable() then
		if not f75_arg1 or not f75_arg0.m_disableKeyboardNavigation then
			table.insert(f75_arg2, f75_arg0)
		end
		return
	end
	local f75_local0 = nil
	local f75_local1 = f75_arg0:getFirstChild()
	while f75_local1 ~= nil do
		CoD.BaseUtility.FindAllFocusableDescendant(f75_local1, f75_arg1, f75_arg2)
		f75_local1 = f75_local1:getNextSibling()
	end
end
CoD.BaseUtility.IsDvarEnabled = function(f76_arg0)
	local f76_local0 = Dvar[f76_arg0]:get()
	local f76_local1
	if f76_local0 ~= "1" and f76_local0 ~= 1 and f76_local0 ~= true then
		f76_local1 = false
	else
		f76_local1 = true
	end
	return f76_local1
end
CoD.BaseUtility.SubscribeToMessageDialogBox = function(f77_arg0, f77_arg1)
	if not f77_arg1 then
		f77_arg1 = Engine[@"getprimarycontroller"]()
	end
	if f77_arg0._messagePendingSubscription ~= nil then
		f77_arg0:removeSubscription(f77_arg0._messagePendingSubscription)
	end
	f77_arg0._messagePendingSubscription = f77_arg0:subscribeToGlobalModel(f77_arg1, "MessageDialog", "messagePending", function(model)
		if ShouldOpenMessageDialog(f77_arg0, f77_arg1) then
			local f78_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "messageDialog.controller") or f77_arg1
			local f78_local1 = f77_arg0.occludedBy
			local f78_local2 = f77_arg0.occludedMenu
			if f78_local1 and f78_local1.menuName == "MessageDialogBox" then
				Close(f78_local1, f77_arg1)
				f78_local1 = nil
			end
			if not CoD.isFrontend then
				if f77_arg0.id == "Menu.HUD" and (IsGameTypeDOA() == false or f78_local0 == 0) and f78_local0 == f77_arg1 then
					local f78_local3 = CoD.OverlayUtility.CreateOverlay(f78_local0, f78_local1 or f77_arg0, "MessageDialogBox", f78_local0)
					CoD.Menu.SetAsPriority(f78_local3, f78_local0)
					f78_local3:setPriority(9999)
					f78_local3:setOwner(f78_local0)
					f77_arg0._messageDialogBox = f78_local3
					LUI.OverrideFunction_CallOriginalSecond(f77_arg0._messageDialogBox, "close", function()
						f77_arg0._messageDialogBox = nil
					end)
					Engine[@"lockinput"](f78_local0, true)
					Engine[@"setuiactive"](f78_local0, true)
				end
			elseif not f78_local1 then
				local f78_local4 = CoD.OverlayUtility.CreateOverlay(f78_local0, f77_arg0, "MessageDialogBox", f78_local0)
				CoD.Menu.SetAsPriority(f78_local4, f78_local0)
				f78_local4:setPriority(9999)
				f78_local4:registerEventHandler("unused_durango_gamepad_button", function(element, event)
					element:close()
				end)
			end
		end
	end, false)
end
CoD.BaseUtility.RestoreState = function(f81_arg0, f81_arg1)
	f81_arg0:restoreState(f81_arg1)
end
CoD.BaseUtility.DisableNavigation = function(f82_arg0)
	f82_arg0.m_disableNavigation = true
end
CoD.BaseUtility.EnableNavigation = function(f83_arg0)
	f83_arg0.m_disableNavigation = false
end
CoD.BaseUtility.DisableMenuGridNavigation = function(f84_arg0)
	f84_arg0.m_disableGridNavigation = true
end
CoD.BaseUtility.EnableMenuGridNavigation = function(f85_arg0)
	f85_arg0.m_disableGridNavigation = false
end
CoD.BaseUtility.SaveState = function(f86_arg0, f86_arg1)
	f86_arg0:saveState(f86_arg1)
end
CoD.BaseUtility.PlaySoundOnce = function(f87_arg0, f87_arg1)
	if not f87_arg0._playOnceAliases then
		f87_arg0._playOnceAliases = {}
	end
	if f87_arg0._playOnceAliases[f87_arg1] then
		return
	else
		f87_arg0._playOnceAliases[f87_arg1] = true
		Engine[@"playsound"](f87_arg1)
	end
end
CoD.BaseUtility.StopPlayOnceSound = function(f88_arg0, f88_arg1)
	if f88_arg0._playOnceAliases then
		f88_arg0._playOnceAliases[f88_arg1] = nil
	end
	Engine[@"stopsound"](f88_arg1)
end
CoD.BaseUtility.AddToMenuList = function(f89_arg0)
	CoD.Menu.AddToCurrMenuNameList(f89_arg0.id)
end
CoD.BaseUtility.RemoveFromMenuList = function(f90_arg0)
	CoD.Menu.RemoveFromCurrMenuNameList(f90_arg0.id)
end
CoD.BaseUtility.RoundFraction = function(f91_arg0, f91_arg1)
	return string.format("%." .. f91_arg0 .. "f", f91_arg1)
end
CoD.BaseUtility.FloorFraction = function(f92_arg0, f92_arg1)
	local f92_local0 = tonumber(f92_arg1) - 0.5 / 10 ^ f92_arg0
	if f92_local0 < 0 then
		f92_local0 = 0
	end
	return string.format("%." .. f92_arg0 .. "f", f92_local0)
end
CoD.BaseUtility.TruncateFractionToIncrement = function(f93_arg0, f93_arg1)
	return math.floor(f93_arg0 / f93_arg1) * f93_arg1
end
CoD.BaseUtility.IsButtonHoldFinished = function(f94_arg0)
	local f94_local0 = f94_arg0 and f94_arg0:get()
	local f94_local1
	if f94_local0 ~= nil then
		f94_local1 = CoD.BitUtility.IsBitwiseAndNonZero(f94_local0, Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"])
	else
		f94_local1 = true
	end
	return f94_local1
end
CoD.BaseUtility.MenuPreservesButton = function(f95_arg0, f95_arg1, f95_arg2)
	if not f95_arg0.preserveLuiButton then
		f95_arg0.preserveLuiButton = {}
	end
	f95_arg0.preserveLuiButton[f95_arg1] = f95_arg2
end
CoD.BaseUtility.DoesElementOrChildHaveFocus = function(f96_arg0, f96_arg1)
	return f96_arg0[f96_arg1] and f96_arg0[f96_arg1]:doesElementOrChildHaveFocus()
end
CoD.BaseUtility.IsCurrentSessionModeEqualTo = function(f97_arg0)
	return Engine[@"currentsessionmode"]() == f97_arg0
end
CoD.BaseUtility.SetStateByMenuSessionMode = function(f98_arg0, f98_arg1, f98_arg2)
	local f98_local0 = CoD.BaseUtility.GetMenuSessionMode(f98_arg0)
	if f98_local0 == Enum[@"emodes"][@"mode_campaign"] then
		f98_arg1:setState(f98_arg2, "Campaign")
	elseif f98_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		f98_arg1:setState(f98_arg2, "Multiplayer")
	elseif f98_local0 == Enum[@"emodes"][@"mode_zombies"] then
		f98_arg1:setState(f98_arg2, "Zombies")
	else
		f98_arg1:setState(f98_arg2, "DefaultState")
	end
end
CoD.BaseUtility.GetCurrentSessionModeString = function()
	local f99_local0 = Engine[@"currentsessionmode"]()
	if f99_local0 == Enum[@"emodes"][@"mode_campaign"] then
		return "cp"
	elseif f99_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		return "mp"
	elseif f99_local0 == Enum[@"emodes"][@"mode_zombies"] then
		return "zm"
	elseif f99_local0 == Enum[@"emodes"][@"mode_warzone"] then
		return "wz"
	else
		return ""
	end
end
CoD.BaseUtility.SetPropertiesFromUserData = function(f100_arg0, f100_arg1)
	if f100_arg1 then
		for f100_local3, f100_local4 in pairs(f100_arg1) do
			f100_arg0[f100_local3] = f100_local4
		end
	end
end
CoD.BaseUtility.SetModelFromUserData = function(f101_arg0, f101_arg1, f101_arg2)
	if f101_arg2 then
		f101_arg1:setModel(f101_arg2, f101_arg0)
	end
end
CoD.BaseUtility.IsWidgetVisible = function(f102_arg0)
	return f102_arg0:getAlpha() > 0
end
CoD.BaseUtility.IsFirstTimeComplete = function(f103_arg0, f103_arg1)
	return Engine[@"isfirsttimecomplete"](f103_arg0, f103_arg1)
end
CoD.BaseUtility.SetStateOnClipOver = function(f104_arg0, f104_arg1, f104_arg2)
	f104_arg0._originalClipOver = f104_arg0.m_eventHandlers.clip_over
	f104_arg0:registerEventHandler("clip_over", function(element, event)
		if not element.nextClip and not IsElementInState(element, f104_arg2) then
			SetState(element, f104_arg2, f104_arg1)
		end
		element:_originalClipOver(event)
	end)
end
CoD.BaseUtility.PlayClipAndThenClose = function(f106_arg0, f106_arg1)
	f106_arg0:playClip(f106_arg1)
	f106_arg0:registerEventHandler("clip_over", function(element, event)
		element:close()
	end)
end
CoD.BaseUtility.DelaySetState = function(f108_arg0, f108_arg1, f108_arg2, f108_arg3)
	f108_arg0.setStateDelayTimer = LUI.UITimer.newElementTimer(f108_arg3, true, function(f109_arg0)
		if not IsElementInState(f108_arg0, f108_arg2) then
			f108_arg0:setState(f108_arg1, f108_arg2)
		end
		if f108_arg0.setStateDelayTimer then
			f108_arg0.setStateDelayTimer:close()
			f108_arg0.setStateDelayTimer = nil
		end
	end)
	f108_arg0:addElement(f108_arg0.setStateDelayTimer)
end
CoD.BaseUtility.SetUseStencil = function(f110_arg0)
	f110_arg0:setUseStencil(true)
end
CoD.BaseUtility.AnimateWidgetOnChangeNum = function(f111_arg0, f111_arg1)
	return f111_arg0
end
CoD.BaseUtility.AnimateWidgetOnChangeVector = function(f112_arg0, f112_arg1, f112_arg2, f112_arg3, f112_arg4)
	return f112_arg1, f112_arg2, f112_arg3, f112_arg4
end
CoD.BaseUtility.GetTimerStruct = function(f113_arg0, f113_arg1)
	local f113_local0 = CoD.perController[f113_arg0]
	if not f113_local0[f113_arg1] then
		f113_local0[f113_arg1] = {}
	end
	return f113_local0[f113_arg1]
end
CoD.BaseUtility.ResetInterpolationTimer = function(f114_arg0, f114_arg1)
	if CoD.perController[f114_arg0][f114_arg1] and CoD.perController[f114_arg0][f114_arg1].interpolateTimer then
		CoD.perController[f114_arg0][f114_arg1].interpolateTimer:close()
	end
	CoD.perController[f114_arg0][f114_arg1] = {}
end
CoD.BaseUtility.SmoothLinearInterpolateClientTime = function(f115_arg0, f115_arg1, f115_arg2, f115_arg3)
	if 1 <= f115_arg3 or f115_arg3 <= 0 then
		CoD.BaseUtility.ResetInterpolationTimer(f115_arg0, f115_arg1)
		return
	end
	local f115_local0 = CoD.BaseUtility.GetTimerStruct(f115_arg0, f115_arg1)
	if f115_local0.ignoreInterpolation then
		return
	end
	local f115_local1 = function(f116_arg0, f116_arg1, f116_arg2)
		f116_arg0.ignoreInterpolation = true
		f116_arg1:set(f116_arg2)
		f116_arg0.ignoreInterpolation = nil
	end
	local f115_local2 = f115_arg3
	local f115_local3 = Engine[@"hash_6316595FEDC72451"]()
	if not f115_local0.lastTime then
		f115_local0.lastTime = f115_local3
		f115_local0.lastValue = f115_local2
		f115_local1(f115_local0, f115_arg2, f115_local2)
		return
	end
	local f115_local4 = tonumber(Engine[@"uint64tostring"](f115_local3 - f115_local0.lastTime))
	local f115_local5 = (f115_local2 - f115_local0.lastValue) * 0.99
	f115_local0.lastTime = f115_local3
	f115_local0.lastValue = f115_local2
	if f115_local0.interpolateTimer then
		f115_local0.interpolateTimer:close()
		f115_local0.interpolateTimer = nil
	end
	local f115_local6 = 0
	f115_local0.interpolateTimer = LUI.UITimer.newElementTimer(10, false, function(f117_arg0)
		f115_local6 = tonumber(Engine[@"uint64tostring"](Engine[@"hash_6316595FEDC72451"]() - f115_local0.lastTime))
		if f115_local4 <= f115_local6 then
			f115_local1(f115_local0, f115_arg2, f115_local0.lastValue + f115_local5)
			f115_local0.interpolateTimer:close()
			f115_local0.interpolateTimer = nil
			return
		else
			f115_local1(f115_local0, f115_arg2, f115_local0.lastValue + f115_local5 * f115_local6 / f115_local4)
		end
	end)
	LUI.roots["UIRoot" .. f115_arg0].addElement(REG11["UIRoot" .. f115_arg0], f115_local0.interpolateTimer)
end
CoD.BaseUtility.RandomVectorXRange = function(f118_arg0, f118_arg1, f118_arg2, f118_arg3, f118_arg4, f118_arg5)
	return f118_arg0 + math.random() * (f118_arg1 - f118_arg0), f118_arg3, f118_arg4, f118_arg5
end
CoD.BaseUtility.IsSelfInState = function(f119_arg0, f119_arg1)
	return f119_arg0.currentState == f119_arg1
end
CoD.BaseUtility.IsSelfInEitherState = function(f120_arg0, f120_arg1, f120_arg2)
	local f120_local0
	if f120_arg0.currentState ~= f120_arg1 and f120_arg0.currentState ~= f120_arg2 then
		f120_local0 = false
	else
		f120_local0 = true
	end
	return f120_local0
end
CoD.BaseUtility.IsParameterValueDefined = function(f121_arg0)
	return f121_arg0 ~= nil
end
CoD.BaseUtility.StringModulo = function(f122_arg0, f122_arg1)
	return f122_arg1 % f122_arg0
end
CoD.BaseUtility.AddToTableIfNotEmpty = function(f123_arg0, f123_arg1)
	if f123_arg1 ~= 0x0 then
		f123_arg0[f123_arg1] = true
	end
end
CoD.BaseUtility.ForceStreamHelper = function(f124_arg0, f124_arg1)
	for f124_local3, f124_local4 in pairs(f124_arg1) do
		if type(f124_local3) ~= "userdata" and not f124_arg0[f124_local3] then
			Engine[@"hash_8A31148EE1BE3B1"](f124_local3)
		end
	end
	for f124_local3, f124_local4 in pairs(f124_arg0) do
		if type(f124_local3) ~= "userdata" and not f124_arg1[f124_local3] then
			Engine[0xE76D1EBA02208C](f124_local3)
		end
	end
	return f124_arg1
end
CoD.BaseUtility.AddForcedImageToTable = function(f125_arg0, f125_arg1)
	if f125_arg0 ~= 0x0 and f125_arg0 ~= nil then
		f125_arg1[f125_arg0] = true
	end
end
CoD.BaseUtility.AreAllForcedImagesStreamed = function(f126_arg0)
	for f126_local3, f126_local4 in pairs(f126_arg0) do
		if not Engine[@"hash_8A31148EE1BE3B1"](f126_local3) then
			return false
		end
	end
	return true
end
CoD.BaseUtility.CloseOccludingMenus = function(f127_arg0)
	local f127_local0 = f127_arg0.occludedBy
	while f127_local0 ~= nil do
		local f127_local1 = f127_local0.occludedBy
		f127_local0:close()
		f127_local0 = f127_local1
	end
end
CoD.BaseUtility.ClearBlur = function(f128_arg0)
	Engine[@"blurworld"](f128_arg0, 0)
	Engine[@"lockinput"](f128_arg0, false)
	Engine[@"setuiactive"](f128_arg0, false)
end
CoD.BaseUtility.IsCurrentLanguageRussian = function()
	local f129_local0
	if Dvar[@"loc_language"]:get() ~= Enum[@"language_t"][@"language_russian"] and Dvar[@"loc_language"]:get() ~= Enum[@"language_t"][@"hash_237F47E9EC48B533"] then
		f129_local0 = false
	else
		f129_local0 = true
	end
	return f129_local0
end
CoD.BaseUtility.IsCurrentLanguageAsian = function()
	local f130_local0 = Dvar[@"loc_language"]:get()
	if f130_local0 == Enum[@"language_t"][@"language_korean"] or f130_local0 == Enum[@"language_t"][@"language_traditionalchinese"] or f130_local0 == Enum[@"language_t"][@"language_simplifiedchinese"] or f130_local0 == Enum[@"language_t"][@"hash_39A4194D08679C69"] or f130_local0 == Enum[@"language_t"][@"language_japanese"] then
		return true
	else
		return false
	end
end
CoD.BaseUtility.HasChildElement = function(f131_arg0, f131_arg1)
	return f131_arg0[f131_arg1] ~= nil
end
CoD.BaseUtility.CallCustomElementFunction = function(f132_arg0, f132_arg1, f132_arg2, f132_arg3, f132_arg4)
	if f132_arg1[f132_arg4] then
		f132_arg1[f132_arg4](f132_arg0, f132_arg1, f132_arg2, f132_arg3)
	end
end
CoD.BaseUtility.SetUpPassCustomFunctionToChild = function(f133_arg0, f133_arg1, f133_arg2, f133_arg3, f133_arg4)
	if f133_arg0 == f133_arg1 then
		error("SetUpPassCustomFunctionToChild cannot be called on self")
	end
	f133_arg0[f133_arg4] = function()
		if f133_arg1[f133_arg4] ~= nil then
			f133_arg1[f133_arg4](f133_arg0, f133_arg1, f133_arg2, f133_arg3)
		end
	end
end
CoD.BaseUtility.SetUpProcessListElementOnCustomFunction = function(f135_arg0, f135_arg1, f135_arg2, f135_arg3, f135_arg4)
	f135_arg1[f135_arg4] = function()
		if f135_arg2.activeWidget and not f135_arg2.m_disableNavigation then
			ProcessListAction(f135_arg2, f135_arg2.activeWidget, f135_arg3, f135_arg0)
		end
	end
end
CoD.BaseUtility.SetupChooseClassAndReturnOnCustomFunction = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4)
	f137_arg1[f137_arg4] = function()
		if not CoD.CACUtility.IsCurrentClassLocked(f137_arg0, f137_arg3) and not IsPC() then
			local f138_local0 = f137_arg0:getParent()
			if f138_local0 then
				if f138_local0.id == "Menu.PositionDraft" or f138_local0.id == "Menu.ChooseSpecialistMidMatch" then
					ChangeClass(f137_arg0, f137_arg1, f137_arg2, f137_arg3)
					CoD.StartMenuUtility.HideClassSelectSlideout(f137_arg0, f137_arg3)
				else
					ChangeClass(f137_arg0, f137_arg1, f137_arg2, f137_arg3)
					CoD.StartMenuUtility.HideClassSelectSlideout(f137_arg0, f137_arg3)
					StartMenuGoBack(f138_local0, f137_arg3)
				end
			end
		end
	end
end
CoD.BaseUtility.NavigationDirection = LuaEnum.createEnum("left", "right", "up", "down")
CoD.BaseUtility.SetCustomNavDirection = function(f139_arg0, f139_arg1, f139_arg2)
	if f139_arg1.CustomNavigation == nil then
		f139_arg1.CustomNavigation = {}
	end
	if f139_arg0 == CoD.BaseUtility.NavigationDirection.left then
		f139_arg1.CustomNavigation.left = f139_arg2
	elseif f139_arg0 == CoD.BaseUtility.NavigationDirection.right then
		f139_arg1.CustomNavigation.right = f139_arg2
	elseif f139_arg0 == CoD.BaseUtility.NavigationDirection.up then
		f139_arg1.CustomNavigation.up = f139_arg2
	elseif f139_arg0 == CoD.BaseUtility.NavigationDirection.down then
		f139_arg1.CustomNavigation.down = f139_arg2
	end
end
CoD.BaseUtility.ClearCustomNav = function(f140_arg0)
	f140_arg0.CustomNavigation = {}
end
CoD.BaseUtility.SyncChildStateToSelfState = function(f141_arg0, f141_arg1, f141_arg2)
	LUI.OverrideFunction_CallOriginalFirst(f141_arg0, "setState", function(element, controller, f142_arg2, f142_arg3, f142_arg4)
		if f141_arg2.currentState ~= element.currentState then
			f141_arg2:setState(controller, f142_arg2)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(f141_arg2, "setState", function(element, controller, f143_arg2, f143_arg3, f143_arg4)
		if element.currentState ~= f141_arg0.currentState then
			element:setState(controller, f141_arg0.currentState)
		end
	end)
end
CoD.BaseUtility.PlayMusic = function(f144_arg0)
	Engine[@"playmenumusic"](f144_arg0)
end
CoD.BaseUtility.SelfShowsBuildInfo = function(f145_arg0)
	local f145_local0 = Engine[@"getglobalmodel"]()
	f145_local0 = f145_local0.showBuildInfo
	local f145_local1 = f145_local0 and f145_local0:get()
	f145_local0:set(f145_local1 + 1)
	LUI.OverrideFunction_CallOriginalSecond(f145_arg0, "close", function()
		f145_local0:set(f145_local1)
	end)
end
CoD.BaseUtility.SelfHidesBuildInfo = function(f147_arg0)
	local f147_local0 = Engine[@"getglobalmodel"]()
	f147_local0 = f147_local0.showBuildInfo
	local f147_local1 = f147_local0 and f147_local0:get()
	f147_local0:set(f147_local1 - 1)
	LUI.OverrideFunction_CallOriginalSecond(f147_arg0, "close", function()
		f147_local0:set(f147_local1)
	end)
end
CoD.BaseUtility.UpdateFixedRatioImageDimensions = function(f149_arg0)
	LUI.UIFixedAspectRatioImage.updateImageDimensions(f149_arg0)
end
CoD.BaseUtility.SetAsPriority = function(f150_arg0, f150_arg1)
	CoD.Menu.SetAsPriority(f150_arg0, f150_arg1)
end
CoD.BaseUtility.UINoAction = function() end
