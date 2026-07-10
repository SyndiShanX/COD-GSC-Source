CoD.VideoStreamingUtility = {}
CoD.VideoStreamingUtility.DownloadURLObject = nil
DataSourceHelpers.GlobalDataSourceSetup("LiveEventViewer", "liveEventViewer", function(f1_arg0, f1_arg1)
	if CoD.isPC then
		local f1_local0 = f1_arg0:create("stream")
		f1_local0:set("")
	end
	local f1_local0 = f1_arg0:create("loading")
	f1_local0:set(false)
end, false)
DataSourceHelpers.GlobalDataSourceSetup("VoDViewer", "vodViewer", function(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0:create("stream")
	f2_local0:set("")
	f2_local0 = f2_arg0:create("loading")
	f2_local0:set(false)
end, false)
DataSourceHelpers.GlobalDataSourceSetup("HLSPlayback", "hlsPlayback", function(f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0:create("haveStarted")
	f3_local0:set(false)
	f3_local0 = f3_arg0:create("posInSeconds")
	f3_local0:set(0)
	f3_local0 = f3_arg0:create("vodLengthInSeconds")
	f3_local0:set(0)
end, false)
CoD.VideoStreamingUtility.LiveEventUpdateCurrentFeed = function()
	if not DataSources then
		return
	end
	local f4_local0 = Dvar[0x14F55599DC04FE0]:get()
	for f4_local6, f4_local7 in ipairs(CoD.VideoStreamingUtility.LiveEventQualities) do
		if f4_local7.qualityId == f4_local0 then
			local f4_local4 = DataSources.LiveEventViewer.getModel()
			if f4_local4 then
				local f4_local5 = Engine[0x40E824FE270E174](f4_local4, "currentQuality")
				if f4_local5 then
					Engine[0x83C9B5DE1D9371](f4_local5, f4_local7.display)
				end
			end
		end
	end
end
CoD.VideoStreamingUtility.StartLiveEventFromData = function(f5_arg0)
	StartLiveEvent(f5_arg0.controller, f5_arg0.liveEventStreamerIndex)
end
CoD.VideoStreamingUtility.LiveEventAutoDetectQuality = {
	qualityId = "autodetect",
	display = Engine[0xF9F1239CFD921FE](0x40AE254682D73CE),
}
CoD.VideoStreamingUtility.LiveEventNewQualities = function(f6_arg0)
	CoD.VideoStreamingUtility.LiveEventQualities = {
		CoD.VideoStreamingUtility.LiveEventAutoDetectQuality,
	}
	local f6_local0 = {
		[CoD.VideoStreamingUtility.LiveEventAutoDetectQuality.qualityId] = true,
	}
	if not f6_arg0.availableQualities or f6_arg0.availableQualities == "" then
		CoD.VideoStreamingUtility.LiveEventUpdateCurrentFeed()
		if CoD.isPC then
			local f6_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "LiveEventViewer")
			local f6_local2 = f6_local1:create("stream")
			f6_local2:set("")
		end
		return
	end
	local f6_local1 = "720"
	local f6_local2 = false
	local f6_local3 = false
	for f6_local12, f6_local13 in ipairs(LUI.splitString(f6_arg0.availableQualities, ";")) do
		if f6_local13 ~= "" then
			local f6_local7 = LUI.splitString(f6_local13, ",")
			if #f6_local7 == 2 then
				local f6_local8 = LUI.splitString(f6_local7[2], "x")
				if #f6_local8 == 2 then
					local f6_local9 = f6_local7[1]
					local f6_local10 = f6_local8[2]
					if not f6_local0[f6_local9] then
						f6_local0[f6_local9] = true
						local f6_local11 = nil
						if f6_local2 then
							f6_local2 = false
							f6_local3 = true
							f6_local11 = Engine[0xF9F1239CFD921FE](0x56E3C9DF1FEE64)
						else
							f6_local11 = Engine[0xF9F1239CFD921FE](0xB961CE5CE287588, f6_local10)
							if not f6_local3 and f6_local10 == f6_local1 then
								f6_local2 = true
							end
						end
						table.insert(CoD.VideoStreamingUtility.LiveEventQualities, {
							qualityId = f6_local9,
							display = f6_local11,
						})
					end
				end
			end
		end
	end
	if not f6_local0[Dvar[0x14F55599DC04FE0]:get()] then
		CoD.VideoStreamingUtility.SelectLiveEventQuality_Internal(CoD.VideoStreamingUtility.LiveEventAutoDetectQuality.qualityId)
	end
	CoD.VideoStreamingUtility.LiveEventUpdateCurrentFeed()
	if DataSources.LiveEventViewerQualities and DataSources.LiveEventViewerQualities.Update then
		DataSources.LiveEventViewerQualities.Update()
	end
end
CoD.VideoStreamingUtility.LiveEventNewQualities({
	availableQualities = Dvar[0x25DCCD772511DA0]:get(),
})
DataSources.LiveEventViewerQualities = ListHelper_SetupDataSource(
	"LiveEventViewerQualities",
	function(f7_arg0)
		local f7_local0 = {}
		local f7_local1 = Dvar[0x14F55599DC04FE0]:get()
		for f7_local5, f7_local6 in ipairs(CoD.VideoStreamingUtility.LiveEventQualities) do
			table.insert(f7_local0, {
				models = {
					displayText = f7_local6.display,
				},
				properties = {
					qualityId = f7_local6.qualityId,
					selectIndex = f7_local6.qualityId == f7_local1,
				},
			})
		end
		return f7_local0
	end,
	true,
	nil,
	function(f8_arg0, f8_arg1, f8_arg2)
		DataSources.LiveEventViewerQualities.Update = function()
			f8_arg1:updateDatasource()
		end
		LUI.OverrideFunction_CallOriginalFirst(f8_arg1, "close", function()
			DataSources.LiveEventViewerQualities.Update = nil
		end)
	end
)
CoD.VideoStreamingUtility.SelectLiveEventQuality_Internal = function(f11_arg0)
	if f11_arg0 and f11_arg0 ~= Dvar[0x14F55599DC04FE0]:get() then
		Dvar[0x14F55599DC04FE0]:set(f11_arg0)
		CoD.VideoStreamingUtility.LiveEventUpdateCurrentFeed()
		local f11_local0 = DataSources.LiveEventViewer.getModel()
		if f11_local0 then
			local f11_local1 = Engine[0x40E824FE270E174](f11_local0, "stream")
			if f11_local1 then
				Engine[0x6A489878620F3BC](f11_local1)
			end
		end
	end
end
CoD.VideoStreamingUtility.IsLEVFeaturedCardEnabled = function()
	if Dvar[0xC4CE265DD374630]:exists() then
		return Dvar[0xC4CE265DD374630]:get()
	else
		return true
	end
end
CoD.VideoStreamingUtility.CreateLEVFeaturedCard = function(f13_arg0, f13_arg1)
	if CoD.VideoStreamingUtility.HasLiveEvent(f13_arg1) and CoD.VideoStreamingUtility.IsLEVFeaturedCardEnabled() then
		table.insert(f13_arg0, {
			models = {
				locked = false,
				name = CoD.VideoStreamingUtility.GetLiveEventTitle(f13_arg1),
				iconBackground = CoD.VideoStreamingUtility.GetLiveEventImage(f13_arg1),
				iconBackgroundFocus = CoD.VideoStreamingUtility.GetLiveEventImage(f13_arg1),
				descriptionText = 0x61AA1B2C5FE2E9F,
				action = CoD.MOTDUtility.FeatureCard_OpenLEVAction,
				actionString = "liveevent",
				param = CoD.VideoStreamingUtility.GetLiveEventName(f13_arg1),
				showForAllClients = true,
				hasDoubleXP = false,
				hasDoubleWeaponXP = false,
			},
		})
	end
end
CoD.VideoStreamingUtility.HasLiveEvent = function(f14_arg0)
	local f14_local0 = CoD.SafeGetModelValue(DataSources.LiveEventViewer.getModel(f14_arg0), "stream")
	return f14_local0 and f14_local0 ~= ""
end
CoD.VideoStreamingUtility.GetLiveEventName = function(f15_arg0)
	local f15_local0 = CoD.SafeGetModelValue(DataSources.LiveEventViewer.getModel(f15_arg0), "stream")
	if f15_local0 then
		return f15_local0
	else
		return ""
	end
end
CoD.VideoStreamingUtility.GetLiveEventTitle = function(f16_arg0)
	local f16_local0 = CoD.SafeGetModelValue(DataSources.LiveEventViewer.getModel(f16_arg0), "title")
	if f16_local0 then
		return f16_local0
	else
		return Engine[0xF9F1239CFD921FE](0x7DE2527076D9C58)
	end
end
CoD.VideoStreamingUtility.StreamerTableName = "gamedata/tables/common/live_event_streamers.csv"
CoD.VideoStreamingUtility.StreamerIDCol = 0
CoD.VideoStreamingUtility.StreamerNameCol = 1
CoD.VideoStreamingUtility.StreamImageCol = 2
CoD.VideoStreamingUtility.StreamerDevCol = 3
CoD.VideoStreamingUtility.StreamerTitleCol = 4
CoD.VideoStreamingUtility.GetLiveEventImage = function(f17_arg0)
	local f17_local0 = "gamedata/tables/common/live_event_streamers.csv"
	local f17_local1 = CoD.VideoStreamingUtility.GetLiveEventName(f17_arg0)
	if f17_local1 ~= "" then
		local f17_local2 = Engine[0x910CBCCD3C164C9](CoD.VideoStreamingUtility.StreamerTableName, CoD.VideoStreamingUtility.StreamerNameCol, f17_local1)
		if f17_local2 == nil then
			return nil
		elseif #f17_local2 > 0 then
			return Engine[0xC6F8EC444864600](CoD.VideoStreamingUtility.StreamerTableName, f17_local2[1], CoD.VideoStreamingUtility.StreamImageCol)
		end
	end
	return 0x0
end
CoD.VideoStreamingUtility.IsMLGStream = function(f18_arg0)
	local f18_local0 = CoD.SafeGetModelValue(DataSources.LiveEventViewer.getModel(f18_arg0), "stream")
	return f18_local0 and LUI.startswith(f18_local0, "mlg/")
end
CoD.VideoStreamingUtility.GetMoviePlayerParams = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	return "" .. (f19_arg0 or Enum[0xC47FC1BD2E5CCEE][0x90B07394D69C5F4]) .. "," .. (f19_arg1 or "") .. "," .. tostring(f19_arg2 or false) .. "," .. tostring(f19_arg3 or false)
end
CoD.VideoStreamingUtility.IsMoviePaused = function(f20_arg0)
	return f20_arg0:isMoviePaused()
end
CoD.VideoStreamingUtility.ExpandMoviePlayerParams = function(f21_arg0)
	local f21_local0 = CoDShared.splitString(f21_arg0, ",")
	local f21_local1 = f21_local0[1]
	if not f21_local1 then
		f21_local1 = Enum[0xC47FC1BD2E5CCEE][0x90B07394D69C5F4]
	else
		f21_local1 = tonumber(f21_local1)
	end
	local f21_local2 = f21_local0[2]
	local f21_local3 = f21_local0[3]
	if not f21_local3 or f21_local3 == "false" then
		f21_local3 = false
	else
		f21_local3 = true
	end
	local f21_local4 = f21_local0[4]
	if not f21_local4 or f21_local4 == "false" then
		f21_local4 = false
	else
		f21_local4 = true
	end
	return f21_local1, f21_local2, f21_local3, f21_local4
end
CoD.VideoStreamingUtility.MLGUniqueIdToURL = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	local f22_local0 = f22_arg2:getModel()
	if f22_arg3 ~= "" then
		f22_local0 = LUI.getTableFromPath(f22_arg3, f22_local0)
	end
	local f22_local1 = Enum[0xC47FC1BD2E5CCEE][0x55550017F21A53C]
	local f22_local2 = CoD.SafeGetModelValue(f22_local0, "videoID") or ""
	local f22_local3 = Dvar[0xCF3B43F93B77DAB]:get()
	if f22_local3 and f22_local3 ~= "" then
		Engine[0x9EDE43760887B20]("https://core-api.majorleaguegaming.com/api/v1/organizations/" .. f22_local3 .. "/assemblers/extended-playback-videos/" .. f22_local2, "vodDownloadGroup", function(f23_arg0)
			if f23_arg0 then
				local f23_local0 = LUI.getTableFromPath("body.assets", f23_arg0)
				if f23_local0 then
					for f23_local6, f23_local7 in ipairs(f23_local0) do
						if f23_local7.format == "hls" and f23_local7.sourceUrl then
							local f23_local4 = "https:" .. f23_local7.sourceUrl
							local f23_local5 = f22_local0:create("movieName")
							f23_local5:set(f23_local4)
							f23_local5 = f22_local0:create("loading")
							f23_local5:set(false)
							CoD.VideoStreamingUtility.SetupVoDMovie(f22_arg1, f22_arg2, f22_arg3)
							if f22_arg4 then
								f22_arg4(f22_arg0, f22_arg2, f22_arg1, f22_arg3)
							end
							return
						end
					end
				end
			end
			LuaUtils.UI_ShowErrorMessageDialog(f22_arg1, 0x2D63571522A693D, 0x127999393F1681)
		end)
	else
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "MLG Organization ID is invalid for current platform. No VoDs can be downloaded.\n")
		LuaUtils.UI_ShowErrorMessageDialog(f22_arg1, 0x2D63571522A693D, 0x127999393F1681)
	end
end
CoD.VideoStreamingUtility.CancelDownloadUrlGroup = function()
	Engine[0xB285A069D4E40CB]("vodDownloadGroup")
end
CoD.VideoStreamingUtility.SetupVoDMovie = function(f25_arg0, f25_arg1, f25_arg2)
	local f25_local0 = f25_arg1:getModel()
	if f25_arg2 ~= "" then
		f25_local0 = LUI.getTableFromPath(f25_arg2, f25_local0)
	end
	local f25_local1 = Enum[0xC47FC1BD2E5CCEE][0x90B07394D69C5F4]
	if CoD.SafeGetModelValue(f25_local0, "isStreamed") then
		f25_local1 = Enum[0xC47FC1BD2E5CCEE][0x55550017F21A53C]
	end
	local f25_local2 = CoD.SafeGetModelValue(f25_local0, "movieName") or ""
	local f25_local3 = CoD.SafeGetModelValue(f25_local0, "isAdditive") or false
	local f25_local4 = CoD.SafeGetModelValue(f25_local0, "isLooping") or false
	local f25_local5 = DataSources.VoDViewer.getModel(f25_arg0)
	f25_local5.stream:set(CoD.VideoStreamingUtility.GetMoviePlayerParams(f25_local1, f25_local2, f25_local3, f25_local4))
end
CoD.VideoStreamingUtility.SetupVoDPreviewWidget = function(f26_arg0, f26_arg1)
	local f26_local0 = f26_arg0
	local f26_local1 = Enum[0xC47FC1BD2E5CCEE][0x90B07394D69C5F4]
	if CoD.SafeGetModelValue(f26_local0, "isStreamed") then
		f26_local1 = Enum[0xC47FC1BD2E5CCEE][0x55550017F21A53C]
	end
	return f26_local1, CoD.SafeGetModelValue(f26_local0, "movieName") or "", CoD.SafeGetModelValue(f26_local0, "isAdditive") or false, CoD.SafeGetModelValue(f26_local0, "isLooping") or false
end
CoD.VideoStreamingUtility.HasLiveEventStreamQualities = function(f27_arg0)
	local f27_local0 = CoD.SafeGetModelValue(DataSources.LiveEventViewer.getModel(f27_arg0), "currentQuality")
	return f27_local0 and f27_local0 ~= ""
end
CoD.VideoStreamingUtility.VoDViewerPreLoadFunc = function(f28_arg0, f28_arg1, f28_arg2)
	f28_arg0.userData = f28_arg2
	f28_arg0:setOwner(f28_arg1)
	local f28_local0 = Engine[0x8DF2E5447F384B9]()
	local f28_local1 = f28_local0:create("VoDViewerFullscreen")
	if f28_arg2 and f28_arg2.fullscreen then
		f28_local1:set(true)
	else
		f28_local1:set(false)
	end
	if CoD.isPC then
		f28_arg0:setHandleMouse(true)
	end
	f28_arg0:registerEventHandler("finished_movie_playback", function(element, event)
		CoD.VideoStreamingUtility.SkipVoDViewer(element, f28_arg1)
	end)
	if f28_arg0.userData and f28_arg0.userData.onlySkippable then
		f28_arg0.buttonModel = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f28_arg1), "SkippableVoDViewer.buttonPrompts")
		return
	end
	f28_arg0.buttonModel = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f28_arg1), "VoDViewer.buttonPrompts")
	local f28_local2 = function()
		return false
	end
	local f28_local3 = function()
		return true
	end
	local f28_local4 = function()
		SetProperty(f28_arg0, "showPrompt", true)
		f28_arg0:setState(f28_arg1, "ShowPrompts")
	end
	local f28_local5 = function()
		SetProperty(f28_arg0, "showPrompt", false)
		f28_arg0:setState(f28_arg1, "DefaultState")
		if f28_arg0.skipHideTimer then
			f28_arg0.skipHideTimer:close()
			f28_arg0.skipHideTimer = nil
		end
	end
	local f28_local6 = function()
		f28_arg0.skipHideTimer = LUI.UITimer.newElementTimer(5000, true, f28_local5)
		f28_arg0:addElement(f28_arg0.skipHideTimer)
	end
	local f28_local7 = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
		if f28_arg0.skipHideTimer then
			f28_arg0.skipHideTimer:reset()
		else
			f28_local4()
			f28_local6()
		end
	end
	local f28_local8 = function(f36_arg0, f36_arg1, f36_arg2, f36_arg3)
		if PropertyIsTrue(f28_arg0, "showPrompt") or IsMouseOrKeyboard(f36_arg2) then
			GoBack(f36_arg1, f36_arg2)
		else
			f28_local7(f36_arg0, f36_arg1, f36_arg2, f36_arg3)
		end
		return true
	end
	local f28_local9 = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
		if PropertyIsTrue(f28_arg0, "showPrompt") and CoD.VideoStreamingUtility.HasLiveEventStreamQualities(f37_arg2) then
			OpenPopup(f37_arg1, "LiveEventViewerQualities", f37_arg2)
			f28_local5()
		else
			f28_local7(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
		end
		return true
	end
	local f28_local10 = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
		if PropertyIsTrue(f28_arg0, "showPrompt") then
			if IsChildElementInState(f38_arg1, "LiveEventViewerMovieAndBackground", "Windowed") then
				SetElementStateByElementName(f38_arg1, "LiveEventViewerMovieAndBackground", f38_arg2, "DefaultState")
				CoD.Menu.UpdateButtonShownState(f38_arg0, f38_arg1, f38_arg2, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
				return true
			else
				SetElementStateByElementName(f38_arg1, "LiveEventViewerMovieAndBackground", f38_arg2, "Windowed")
				CoD.Menu.UpdateButtonShownState(f38_arg0, f38_arg1, f38_arg2, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
				return true
			end
		else
			f28_local7(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
		end
	end
	local f28_local11 = function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
		if IsDpadButton(f39_arg3) then
			f28_local7(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
		end
	end
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, f28_local11, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], nil, f28_local11, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, f28_local11, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], nil, f28_local11, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, f28_local7, f28_local2, false)
	if LUI.DEV == nil then
		f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], nil, f28_local7, f28_local2, false)
	end
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], nil, f28_local7, f28_local2, false)
	f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, f28_local8, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x6C253CF816B40B5)
		return true
	end, false)
	if f28_arg0.userData and f28_arg0.userData.allowStreamQualityChange then
		f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, f28_local9, function(element, menu, controller)
			if CoD.VideoStreamingUtility.HasLiveEventStreamQualities(controller) then
				CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x56FFD43E4B03BCF)
				return true
			else
				CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0)
				return false
			end
		end, false)
	end
	if f28_arg0.userData and f28_arg0.userData.allowToggleFullscreen then
		f28_arg0:AddButtonCallbackFunction(f28_arg0, f28_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, f28_local10, function(element, menu, controller)
			if menu.LiveEventViewerMovieAndBackground and IsChildElementInState(menu, "LiveEventViewerMovieAndBackground", "Windowed") then
				CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x70675323ADAA7D6)
				return true
			else
				CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0xB7DCA76B1E2C72E)
				return true
			end
		end, false)
	end
end
CoD.VideoStreamingUtility.VoDViewerPostLoadFunc = function(f43_arg0, f43_arg1, f43_arg2)
	CoD.PlayFrontendMusic("")
	Dvar[0x5CE320CFE22FBC0]:set(true)
	LUI.OverrideFunction_CallOriginalSecond(f43_arg0, "close", function(element)
		Dvar[0x5CE320CFE22FBC0]:set(false)
		local f44_local0 = CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
		if f44_local0 then
			CoD.PlayFrontendMusicForLobby(f44_local0)
		end
	end)
end
CoD.VideoStreamingUtility.SkipVoDViewer = function(f45_arg0, f45_arg1)
	local f45_local0 = f45_arg0.userData
	if f45_local0 and f45_local0.on_pre_finished_movie_playback then
		f45_local0.on_pre_finished_movie_playback(f45_arg0, f45_arg1, f45_local0)
	end
	if not f45_local0 or f45_local0 and not f45_local0.dont_exit_movie then
		GoBack(f45_arg0, f45_arg1)
	end
	if f45_local0 and f45_local0.on_post_finished_movie_playback then
		f45_local0.on_post_finished_movie_playback(f45_arg0, f45_arg1, f45_local0)
	end
end
CoD.VideoStreamingUtility.SkipFullScreenMovie = function(f46_arg0, f46_arg1)
	Engine[0x46C794158F47657](f46_arg1, Engine[0xC53F8D38DF9042B](f46_arg0.menuName), Engine[0xC53F8D38DF9042B]("finished_movie_playback"), 0)
end
