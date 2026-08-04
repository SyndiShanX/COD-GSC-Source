CoD.SubtitleUtility = {}
CoD.SubtitleUtility.NumLines = 7
CoD.SubtitleUtility.UpdateSubtitle = function(f1_arg0)
	local f1_local0 = 0
	local f1_local1 = f1_arg0.subtitlesModel.currentIndex
	local f1_local2 = f1_local1:get()
	local f1_local3 = nil
	if f1_local2 then
		local f1_local4, f1_local5, f1_local6, f1_local7 = f1_arg0.lines[f1_local2].element.SubtitleEntry:getLocalRect()
		f1_local3 = f1_local5 - f1_local7
	end
	for f1_local4 = 0, f1_arg0.maxElementIndex, 1 do
		if f1_arg0.lines[f1_local4].active then
			f1_arg0.lines[f1_local4].position = f1_arg0.lines[f1_local4].position + 1
			f1_arg0.lines[f1_local4].element:moveSubtitleEntry(f1_arg0.lines[f1_local4].position, f1_local3)
			f1_local0 = f1_local0 + 1
		end
	end
	if f1_arg0.maxElementIndex < f1_local0 then
		f1_arg0.lines[f1_local2].element:forceHideSubtitleEntry()
	end
	local f1_local4 = f1_arg0.controller
	if not Engine.IsVisibilityBitSet(f1_local4, Enum.UIVisibilityBit[@"bit_demo_camera_mode_moviecam"]) then
		if CoD.IsShoutcaster(f1_local4) and not CoD.ShoutcasterProfileVarBool(f1_local4, "shoutcaster_ds_killfeed") then
		else
			f1_arg0.lines[f1_local2].element:showSubtitleEntry(f1_local2)
			f1_arg0.lines[f1_local2].active = true
		end
	end
	f1_local1:set((f1_local2 + 1) % (f1_arg0.maxElementIndex + 1))
	return true
end
CoD.SubtitleUtility.SubtitleNotificationComplete = function(f2_arg0, f2_arg1)
	f2_arg0.lines[f2_arg1.id].active = false
	f2_arg0.lines[f2_arg1.id].position = 0
	return true
end
CoD.SubtitleUtility.Init = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	f3_arg0.controller = f3_arg1
	local f3_local0 = DataSources.HUDItems.getModel(f3_arg1)
	f3_local0 = f3_local0:create(f3_arg2)
	local f3_local1 = f3_local0:create("currentIndex")
	f3_local1:set(0)
	f3_arg0.currentIndex = 0
	f3_arg0.maxElementIndex = f3_arg3 or CoD.SubtitleUtility.NumLines - 1
	assert(f3_arg0.maxElementIndex < CoD.SubtitleUtility.NumLines)
	f3_arg0.subtitlesModel = f3_local0
	f3_arg0.lines = {}
	for f3_local1 = 0, f3_arg0.maxElementIndex, 1 do
		f3_arg0.lines[f3_local1] = {}
		f3_arg0.lines[f3_local1].active = false
		f3_arg0.lines[f3_local1].name = "SubtitleEntry" .. f3_local1
		f3_arg0.lines[f3_local1].element = f3_arg0[f3_arg0.lines[f3_local1].name]
		f3_arg0.lines[f3_local1].position = 0
	end
	f3_arg0:registerEventHandler("subtitle_notification_complete", CoD.SubtitleUtility.SubtitleNotificationComplete)
	f3_arg0:subscribeToModel(f3_local0, function(model)
		CoD.SubtitleUtility.UpdateSubtitle(f3_arg0)
	end, false)
end
CoD.SubtitleUtility.CompleteAllAnimations = function(f5_arg0)
	f5_arg0.SubtitleEntry:completeAnimation()
end
CoD.SubtitleUtility.ShowSubtitleEntry = function(f6_arg0, f6_arg1)
	f6_arg0.id = f6_arg1
	f6_arg0:completeAllAnimations()
	local f6_local0, f6_local1 = f6_arg0:getLocalSize()
	f6_arg0:setTopBottom(false, true, -f6_local1, 0)
	f6_arg0.SubtitleEntry:playClip("FadeIn")
	local f6_local2 = LUI.UITimer.new
	local f6_local3 = f6_arg0:getModel()
	f6_arg0.timer = f6_local2(f6_local3.duration:get(), "hide_subtitle_entry", true, f6_arg0)
	f6_arg0:addElement(f6_arg0.timer)
end
CoD.SubtitleUtility.MoveSubtitleEntry = function(f7_arg0, f7_arg1, f7_arg2)
	f7_arg0:completeAllAnimations()
	local f7_local0, f7_local1, f7_local2, f7_local3 = f7_arg0.SubtitleEntry:getLocalRect()
	if not f7_arg2 then
		f7_arg2 = f7_local1 - f7_local3
	end
	local f7_local4 = f7_arg2 * f7_arg1
	f7_arg0:beginAnimation("move_subtitle_event", 100)
	f7_arg0:setTopBottom(false, true, f7_local1 + f7_local4, f7_local3 + f7_local4)
end
CoD.SubtitleUtility.HideSubtitleEntry = function(f8_arg0)
	f8_arg0:completeAllAnimations()
	if f8_arg0.forcedToHide then
		f8_arg0.SubtitleEntry:playClip("Hide")
	else
		f8_arg0.SubtitleEntry:playClip("FadeOut")
	end
	f8_arg0:dispatchEventToParent({
		name = "subtitle_notification_complete",
		id = f8_arg0.id,
	})
	f8_arg0.forcedToHide = false
end
CoD.SubtitleUtility.ForceHideSubtitleEntry = function(f9_arg0)
	f9_arg0.forcedToHide = true
	f9_arg0.timer:processNow()
end
CoD.SubtitleUtility.EntryInit = function(f10_arg0, f10_arg1, f10_arg2)
	f10_arg0.id = -1
	f10_arg0.forcedToHide = false
	f10_arg0.alignment = f10_arg2
	f10_arg0:registerEventHandler("hide_subtitle_entry", CoD.SubtitleUtility.HideSubtitleEntry)
	f10_arg0.completeAllAnimations = CoD.SubtitleUtility.CompleteAllAnimations
	f10_arg0.showSubtitleEntry = CoD.SubtitleUtility.ShowSubtitleEntry
	f10_arg0.moveSubtitleEntry = CoD.SubtitleUtility.MoveSubtitleEntry
	f10_arg0.hideSubtitleEntry = CoD.SubtitleUtility.HideSubtitleEntry
	f10_arg0.forceHideSubtitleEntry = CoD.SubtitleUtility.ForceHideSubtitleEntry
end
CoD.SubtitleUtility.ClearSubtitleModels = function(f11_arg0)
	local f11_local0 = DataSources.HUDItems.getModel(f11_arg0)
	f11_local0 = f11_local0.subtitles
	if not f11_local0 then
		return
	end
	for f11_local1 = 0, CoD.SubtitleUtility.NumLines - 1, 1 do
		local f11_local4 = f11_local0["line" .. f11_local1]
		if f11_local4 and f11_local4.text then
			f11_local4.text:set("")
		end
	end
end
