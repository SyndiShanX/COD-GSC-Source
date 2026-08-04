CoD.ConsoleUtility = {}
CoD.ConsoleUtility.UpdateConsole = function(f1_arg0)
	local f1_local0 = 0
	for f1_local1 = 0, f1_arg0.maxElementIndex, 1 do
		if f1_arg0.lines[f1_local1].active then
			f1_arg0.lines[f1_local1].position = f1_arg0.lines[f1_local1].position + 1
			f1_arg0.lines[f1_local1].element:moveConsoleEntry(f1_arg0.lines[f1_local1].position)
			f1_local0 = f1_local0 + 1
		end
	end
	local f1_local1 = Engine.GetModelForController(f1_arg0.controller)
	local f1_local2 = Engine.GetModel(f1_arg0.consoleModel, "currentIndex")
	local f1_local3 = Engine.GetModelValue(f1_local2)
	if f1_arg0.maxElementIndex < f1_local0 then
		f1_arg0.lines[f1_local3].element:forceHideConsoleEntry()
	end
	if Engine.IsVisibilityBitSet(f1_arg0.controller, Enum.UIVisibilityBit[@"bit_demo_camera_mode_moviecam"]) then
	else
		f1_arg0.lines[f1_local3].element:showConsoleEntry(f1_local3, f1_arg0.padding)
		f1_arg0.lines[f1_local3].active = true
	end
	Engine.SetModelValue(f1_local2, (f1_local3 + 1) % (f1_arg0.maxElementIndex + 1))
	return true
end
CoD.ConsoleUtility.ConsoleNotificationComplete = function(f2_arg0, f2_arg1)
	f2_arg0.lines[f2_arg1.id].active = false
	f2_arg0.lines[f2_arg1.id].position = 0
end
CoD.ConsoleUtility.Init = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	f3_arg0.controller = f3_arg1
	local f3_local0 = Engine.GetModel(Engine.GetModelForController(f3_arg1), "hudItems." .. f3_arg2)
	Engine.SetModelValue(Engine.CreateModel(f3_local0, "currentIndex"), 0)
	f3_arg0.currentIndex = 0
	f3_arg0.maxElementIndex = f3_arg3 or 6
	f3_arg0.consoleModel = f3_local0
	f3_arg0.padding = f3_arg4
	f3_local0.numEntries:set(f3_arg0.maxElementIndex + 1)
	f3_arg0.lines = {}
	for f3_local1 = 0, f3_arg0.maxElementIndex, 1 do
		f3_arg0.lines[f3_local1] = {}
		f3_arg0.lines[f3_local1].active = false
		f3_arg0.lines[f3_local1].name = "ConsoleEntry" .. f3_local1
		f3_arg0.lines[f3_local1].element = f3_arg0[f3_arg0.lines[f3_local1].name]
		f3_arg0.lines[f3_local1].position = 0
	end
	f3_arg0:registerEventHandler("console_notification_complete", CoD.ConsoleUtility.ConsoleNotificationComplete)
	f3_arg0:subscribeToModel(f3_local0, function(model)
		CoD.ConsoleUtility.UpdateConsole(f3_arg0)
	end, false)
end
CoD.ConsoleUtility.CompleteAllAnimations = function(f5_arg0)
	f5_arg0.ConsoleEntry:completeAnimation()
	f5_arg0.ConsoleEntry.Text0:completeAnimation()
	f5_arg0.ConsoleEntry.Icon0:completeAnimation()
	f5_arg0.ConsoleEntry.Text1:completeAnimation()
	f5_arg0.ConsoleEntry.Icon1:completeAnimation()
end
CoD.ConsoleUtility.ShowConsoleEntry = function(f6_arg0, f6_arg1, f6_arg2)
	f6_arg0.id = f6_arg1
	if not f6_arg2 then
		f6_arg2 = 0
	end
	f6_arg0:completeAllAnimations()
	f6_arg0:setAlpha(1)
	f6_arg0.ConsoleEntry.Text0.Text:setAlpha(0)
	f6_arg0.ConsoleEntry.Icon0.Icon:setAlpha(0)
	f6_arg0.ConsoleEntry.Text1.Text:setAlpha(0)
	f6_arg0.ConsoleEntry.Icon1.Icon:setAlpha(0)
	local f6_local0, f6_local1, f6_local2, f6_local3 = f6_arg0:getLocalRect()
	f6_arg0:setTopBottom(false, true, -(f6_local3 - f6_local1), 0)
	local f6_local4 = 0
	f6_local0 = f6_local0 + f6_arg2 / 2
	local f6_local5 = function(f7_arg0)
		local f7_local0
		if f7_arg0 == nil or f7_arg0 == "" or f7_arg0 == 0x0 then
			f7_local0 = false
		else
			f7_local0 = true
		end
		return f7_local0
	end
	local f6_local6 = f6_arg0:getModel()
	f6_arg0.icon0Visible = f6_local5(Engine.GetModelValue(Engine.GetModel(f6_local6, "icon0")))
	f6_arg0.text0Visible = f6_local5(Engine.GetModelValue(Engine.GetModel(f6_local6, "text0")))
	f6_arg0.icon1Visible = f6_local5(Engine.GetModelValue(Engine.GetModel(f6_local6, "icon1")))
	f6_arg0.text1Visible = f6_local5(Engine.GetModelValue(Engine.GetModel(f6_local6, "text1")))
	f6_arg0.text2Visible = f6_local5(Engine.GetModelValue(Engine.GetModel(f6_local6, "text2")))
	if f6_arg0.icon0Visible then
		local f6_local7, f6_local8, f6_local9, f6_local10 = f6_arg0.ConsoleEntry.Icon0:getLocalRect()
		local f6_local11 = (f6_local10 - f6_local8) * Engine.GetModelValue(Engine.GetModel(f6_local6, "iconWidth"))
		if f6_local11 < 0 then
			f6_arg0.ConsoleEntry.Icon0:setLeftRight(true, false, f6_local0, f6_local0 - f6_local11)
		else
			f6_arg0.ConsoleEntry.Icon0:setLeftRight(true, false, f6_local0 + f6_local11, f6_local0)
		end
		f6_local0 = f6_local0 + math.abs(f6_local11) + f6_arg2
		f6_arg0.ConsoleEntry.Icon0:playClip("FadeIn")
	end
	if f6_arg0.text0Visible then
		local f6_local7 = f6_arg0.ConsoleEntry.Text0.Text:getTextWidth()
		f6_arg0.ConsoleEntry.Text0:setLeftRight(true, false, f6_local0, f6_local0 + f6_local7)
		f6_local0 = f6_local0 + f6_local7 + f6_arg2
		f6_arg0.ConsoleEntry.Text0:playClip("FadeIn")
	end
	if f6_arg0.icon1Visible then
		local f6_local7, f6_local8, f6_local9, f6_local10 = f6_arg0.ConsoleEntry.Icon1:getLocalRect()
		local f6_local11 = (f6_local10 - f6_local8) * Engine.GetModelValue(Engine.GetModel(f6_local6, "iconWidth"))
		if f6_local11 < 0 then
			f6_arg0.ConsoleEntry.Icon1:setLeftRight(true, false, f6_local0 - f6_local11, f6_local0)
		else
			f6_arg0.ConsoleEntry.Icon1:setLeftRight(true, false, f6_local0, f6_local0 + f6_local11)
		end
		f6_local0 = f6_local0 + math.abs(f6_local11) + f6_arg2
		f6_arg0.ConsoleEntry.Icon1:playClip("FadeIn")
	end
	if f6_arg0.text1Visible then
		local f6_local7 = f6_arg0.ConsoleEntry.Text1.Text:getTextWidth()
		f6_arg0.ConsoleEntry.Text1:setLeftRight(true, false, f6_local0, f6_local0 + f6_local7)
		f6_local0 = f6_local0 + f6_local7 + f6_arg2
		f6_arg0.ConsoleEntry.Text1:playClip("FadeIn")
	end
	if f6_arg0.text2Visible then
		local f6_local7 = f6_arg0.ConsoleEntry.Text2.Text:getTextWidth()
		f6_arg0.ConsoleEntry.Text2:setLeftRight(true, false, f6_local0, f6_local0 + f6_local7)
		f6_local0 = f6_local0 + f6_local7 + f6_arg2
		f6_arg0.ConsoleEntry.Text2:playClip("FadeIn")
	end
	f6_local0 = f6_local0 - f6_arg2 / 2
	f6_arg0.ConsoleEntry.Panel:setLeftRight(true, false, f6_arg0.panelStartLeft, f6_arg0.panelStartRight + f6_local0)
	if f6_arg0.alignment == Enum.LUIAlignment[@"lui_alignment_center"] then
		f6_arg0.ConsoleEntry:setLeftRight(false, false, -f6_local0 / 2, f6_local0 / 2)
	end
	f6_arg0.ConsoleEntry:playClip("FadeIn")
	f6_arg0.timer = LUI.UITimer.new(5000, "hide_console_entry", true, f6_arg0)
	f6_arg0:addElement(f6_arg0.timer)
end
CoD.ConsoleUtility.MoveConsoleEntry = function(f8_arg0, f8_arg1)
	f8_arg0:completeAllAnimations()
	local f8_local0, f8_local1, f8_local2, f8_local3 = f8_arg0.ConsoleEntry:getLocalRect()
	local f8_local4 = (f8_local1 - f8_local3) * f8_arg1
	f8_arg0:beginAnimation("move_console_event", 100)
	if f8_arg1 >= 5 then
		local f8_local5 = f8_arg0
		local f8_local6 = f8_arg0.setAlpha
		local f8_local7
		if f8_arg1 == 5 then
			f8_local7 = 0.6
			if not f8_local7 then
			else
				f8_local6(f8_local5, f8_local7)
			end
		end
		f8_local7 = 0.4
	end
	f8_arg0:setTopBottom(false, true, f8_local1 + f8_local4, f8_local3 + f8_local4)
end
CoD.ConsoleUtility.HideConsoleEntry = function(f9_arg0)
	f9_arg0:completeAllAnimations()
	if f9_arg0.forcedToHide then
		f9_arg0.ConsoleEntry.Text0.Text:setAlpha(0)
		f9_arg0.ConsoleEntry.Icon0.Icon:setAlpha(0)
		f9_arg0.ConsoleEntry.Text1.Text:setAlpha(0)
		f9_arg0.ConsoleEntry.Icon1.Icon:setAlpha(0)
		f9_arg0.ConsoleEntry.Panel:setAlpha(0)
	else
		if f9_arg0.text0Visible then
			f9_arg0.ConsoleEntry.Text0:playClip("FadeOut")
		end
		if f9_arg0.icon0Visible then
			f9_arg0.ConsoleEntry.Icon0:playClip("FadeOut")
		end
		if f9_arg0.icon1Visible then
			f9_arg0.ConsoleEntry.Icon1:playClip("FadeOut")
		end
		if f9_arg0.text1Visible then
			f9_arg0.ConsoleEntry.Text1:playClip("FadeOut")
		end
		if f9_arg0.text2Visible then
			f9_arg0.ConsoleEntry.Text2:playClip("FadeOut")
		end
		f9_arg0.ConsoleEntry:playClip("FadeOut")
	end
	f9_arg0.text0Visible = false
	f9_arg0.icon0Visible = false
	f9_arg0.icon1Visible = false
	f9_arg0.text1Visible = false
	f9_arg0.text2Visible = false
	f9_arg0:dispatchEventToParent({
		name = "console_notification_complete",
		id = f9_arg0.id,
	})
	f9_arg0.forcedToHide = false
end
CoD.ConsoleUtility.ForceHideConsoleEntry = function(f10_arg0)
	f10_arg0.forcedToHide = true
	f10_arg0.timer:processNow()
end
CoD.ConsoleUtility.EntryInit = function(f11_arg0, f11_arg1, f11_arg2)
	f11_arg0.id = -1
	f11_arg0.forcedToHide = false
	f11_arg0.text0Visible = false
	f11_arg0.icon0Visible = false
	f11_arg0.icon1Visible = false
	f11_arg0.text1Visible = false
	f11_arg0.text2Visible = false
	f11_arg0.alignment = f11_arg2
	f11_arg0:registerEventHandler("hide_console_entry", CoD.ConsoleUtility.HideConsoleEntry)
	f11_arg0.completeAllAnimations = CoD.ConsoleUtility.CompleteAllAnimations
	local f11_local0, f11_local1, f11_local2, f11_local3 = f11_arg0.ConsoleEntry.Panel:getLocalLeftRight()
	f11_arg0.panelStartLeft = f11_local2
	f11_arg0.panelStartRight = f11_local3
	f11_arg0.showConsoleEntry = CoD.ConsoleUtility.ShowConsoleEntry
	f11_arg0.moveConsoleEntry = CoD.ConsoleUtility.MoveConsoleEntry
	f11_arg0.hideConsoleEntry = CoD.ConsoleUtility.HideConsoleEntry
	f11_arg0.forceHideConsoleEntry = CoD.ConsoleUtility.ForceHideConsoleEntry
end
CoD.ConsoleUtility.ChooseEntryIconImage = function(f12_arg0)
	local f12_local0 = Engine.GetModel(f12_arg0.obitModel, "line" .. Engine.GetModelValue(f12_arg0.currentIndexModel))
	local f12_local1 = Engine.GetModel(f12_local0, "icon")
	local f12_local2 = Engine.GetModelValue(Engine.GetModel(f12_local0, "mod"))
	local f12_local3 = Engine.GetModelValue(Engine.GetModel(f12_local0, "weaponKillIcon"))
	local f12_local4 = f12_local0.ignoreModIconOverride
	if f12_local4 then
		f12_local4 = f12_local0.ignoreModIconOverride:get()
	end
	local f12_local5 = f12_local3
	if not Engine[@"hash_4238317564B9D47B"](f12_local5) then
		f12_local5 = CoD.HUDUtility.GetModIcon(Enum[@"meansofdeath_t"].mod_suicide, f12_local5)
	end
	local f12_local6 = f12_local5
	if not f12_local4 then
		f12_local6 = CoD.HUDUtility.GetModIcon(f12_local2, f12_local5)
	end
	Engine.SetModelValue(f12_local1, f12_local6)
end
CoD.ConsoleUtility.UpdateObituary = function(f13_arg0)
	if not f13_arg0.obitModel or not f13_arg0.currentIndexModel then
		return
	end
	CoD.ConsoleUtility.ChooseEntryIconImage(f13_arg0)
	local f13_local0 = 0
	for f13_local1 = 0, f13_arg0.maxElementIndex, 1 do
		if f13_arg0.lines[f13_local1].active then
			f13_arg0.lines[f13_local1].position = f13_arg0.lines[f13_local1].position + 1
			f13_arg0.lines[f13_local1].element:moveObituaryEntry(f13_arg0.lines[f13_local1].position)
			f13_local0 = f13_local0 + 1
		end
	end
	local f13_local1 = Engine.GetModelForController(f13_arg0.controller)
	local f13_local2 = Engine.GetModelValue(f13_arg0.currentIndexModel)
	if f13_arg0.maxElementIndex < f13_local0 then
		f13_arg0.lines[f13_local2].element:forceHideObituaryEntry()
	end
	if Engine.IsVisibilityBitSet(f13_arg0.controller, Enum.UIVisibilityBit[@"bit_demo_camera_mode_moviecam"]) then
	else
		f13_arg0.lines[f13_local2].element:showObituaryEntry(f13_local2)
		f13_arg0.lines[f13_local2].active = true
	end
	Engine.SetModelValue(f13_arg0.currentIndexModel, (f13_local2 + 1) % (f13_arg0.maxElementIndex + 1))
	return true
end
CoD.ConsoleUtility.ObituaryNotificationComplete = function(f14_arg0, f14_arg1)
	f14_arg0.lines[f14_arg1.id].active = false
	f14_arg0.lines[f14_arg1.id].position = 0
end
CoD.ConsoleUtility.InitObituary = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
	f15_arg0.controller = f15_arg1
	local f15_local0 = Engine.GetModel(Engine.GetModelForController(f15_arg1), "hudItems." .. f15_arg2)
	local f15_local1 = Engine.CreateModel(f15_local0, "currentIndex")
	f15_arg0.maxElementIndex = f15_arg3 or 6
	f15_arg0.obitModel = f15_local0
	f15_arg0.currentIndexModel = f15_local1
	Engine.SetModelValue(f15_local1, 0)
	f15_arg0.lines = {}
	for f15_local2 = 0, f15_arg0.maxElementIndex, 1 do
		f15_arg0.lines[f15_local2] = {}
		f15_arg0.lines[f15_local2].active = false
		f15_arg0.lines[f15_local2].name = "ObituaryEntry" .. f15_local2
		f15_arg0.lines[f15_local2].element = f15_arg0[f15_arg0.lines[f15_local2].name]
		f15_arg0.lines[f15_local2].position = 0
	end
	f15_arg0:registerEventHandler("obituary_notification_complete", CoD.ConsoleUtility.ObituaryNotificationComplete)
	f15_arg0:subscribeToModel(f15_local0, function(model)
		CoD.ConsoleUtility.UpdateObituary(f15_arg0)
	end, false)
end
CoD.ConsoleUtility.ObituaryEntryDirection = LuaEnum.createEnum("UP", "DOWN")
CoD.ConsoleUtility.ObituaryEntryInit = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
	f17_arg0.id = -1
	f17_arg0.forcedToHide = false
	f17_arg0:registerEventHandler("hide_obituary_entry", CoD.ConsoleUtility.HideObituaryEntry)
	f17_arg0.completeAllAnimations = CoD.ConsoleUtility.CompleteAllObituaryAnimations
	f17_arg0.showObituaryEntry = CoD.ConsoleUtility.ShowObituaryEntry
	f17_arg0.moveObituaryEntry = CoD.ConsoleUtility.MoveObituaryEntry
	f17_arg0.hideObituaryEntry = CoD.ConsoleUtility.HideObituaryEntry
	f17_arg0.forceHideObituaryEntry = CoD.ConsoleUtility.ForceHideObituaryEntry
	f17_arg0.lifetime = f17_arg2
	f17_arg0.direction = f17_arg3
end
CoD.ConsoleUtility.CompleteAllObituaryAnimations = function(f18_arg0)
	f18_arg0:completeAnimation()
end
CoD.ConsoleUtility.ShowObituaryEntry = function(f19_arg0, f19_arg1)
	f19_arg0.id = f19_arg1
	f19_arg0:moveObituaryEntry(0, 0)
	f19_arg0:completeAllAnimations()
	f19_arg0:setAlpha(1)
	f19_arg0:playClip("FadeIn")
	f19_arg0.timer = LUI.UITimer.new(f19_arg0.lifetime, "hide_obituary_entry", true, f19_arg0)
	f19_arg0:addElement(f19_arg0.timer)
end
CoD.ConsoleUtility.MoveObituaryEntry = function(f20_arg0, f20_arg1, f20_arg2)
	f20_arg0:completeAllAnimations()
	local f20_local0, f20_local1, f20_local2, f20_local3 = f20_arg0:getLocalRect()
	local f20_local4 = f20_local3 - f20_local1
	local f20_local5 = f20_local4 * f20_arg1
	if not f20_arg2 then
		f20_arg2 = 100
	end
	f20_arg0:beginAnimation("move_obituary_event", f20_arg2)
	if f20_arg1 >= 5 then
		f20_arg0:setAlpha(0.5)
	end
	if f20_arg0.direction == CoD.ConsoleUtility.ObituaryEntryDirection.DOWN then
		f20_arg0:setTopBottom(0, 0, f20_local5, f20_local5 + f20_local4)
	else
		f20_arg0:setTopBottom(1, 1, -f20_local4 - f20_local5, -f20_local4 - f20_local5 + f20_local4)
	end
end
CoD.ConsoleUtility.ForceHideObituaryEntry = function(f21_arg0)
	f21_arg0.forcedToHide = true
	f21_arg0.timer:processNow()
end
CoD.ConsoleUtility.HideObituaryEntry = function(f22_arg0)
	f22_arg0:completeAllAnimations()
	if f22_arg0.forcedToHide then
		f22_arg0:setAlpha(0)
	else
		f22_arg0:playClip("FadeOut")
	end
	f22_arg0:dispatchEventToParent({
		name = "obituary_notification_complete",
		id = f22_arg0.id,
	})
	f22_arg0.forcedToHide = false
end
CoD.ConsoleUtility.ResizeImageElement = function(f23_arg0, f23_arg1)
	local f23_local0, f23_local1, f23_local2, f23_local3 = f23_arg0.Icon:getLocalRect()
	local f23_local4 = f23_local3 - f23_local1
	local f23_local5, f23_local6 = f23_arg1:getImageDimensions()
	if f23_local5 > 0 and f23_local6 > 0 then
		local f23_local7 = f23_local4 * f23_local5 / f23_local6 / 2
		f23_arg0.Icon:setLeftRight(0.5, 0.5, -f23_local7, f23_local7)
	else
		f23_arg0.Icon:setLeftRight(0.5, 0.5, 0, 0)
	end
end
