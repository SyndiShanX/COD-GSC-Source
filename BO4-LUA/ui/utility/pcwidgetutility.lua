CoD.PCWidgetUtility = {}
CoD.PCWidgetUtility.SocialInviteStatus = {
	NOT_SENT = 0,
	IN_PARTY = 1,
	PENDING = 2,
	RECEIVED = 3,
	PARTY_PENDING = 4,
	PARTY_RECEIVED = 5,
}
CoD.PCWidgetUtility.PartyInviteStatus = {
	UNAVAILABLE = 0,
	NOT_SENT = 1,
	PENDING = 2,
	RECEIVED = 3,
}
CoD.PCWidgetUtility.CurrentChatInputWidget = {}
CoD.PCWidgetUtility.VoiceChatChannelsOptions = {
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/voice_chat_party"),
		value = 0,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/voice_chat_team"),
		value = 2,
	},
}
DataSources.VoiceChatChannelsSelectionOptions = DataSourceHelpers.DropdownListSetup("PC.VoiceChatChannelsSelectionOptions", CoD.PCWidgetUtility.VoiceChatChannelsOptions)
DataSources.VoiceChatChannelsSelection = {
	getModel = function(f1_arg0)
		local f1_local0 = Engine.GetModelForController(f1_arg0)
		local f1_local1 = f1_local0.VoiceChatChannelsSelection
		if not f1_local1 then
			f1_local1 = f1_local0:create("VoiceChatChannelsSelection")
			local f1_local2 = f1_local1:create("name")
			f1_local2:set(Engine[@"hash_4F9F1239CFD921FE"]("menu/voice_chat_team"))
			f1_local2 = f1_local1:create("optionsDataSource")
			f1_local2:set("VoiceChatChannelsSelectionOptions")
			f1_local2 = f1_local1:create("isOpen")
			f1_local2:set(false)
			f1_local2 = f1_local1:create("currentValue")
			f1_local2:set(Engine.ProfileInt(f1_arg0, "voice_favored_channel"))
		end
		return f1_local1
	end,
}
CoD.PCWidgetUtility.PrepareVoiceChatDropdownProperties = function(f2_arg0, f2_arg1)
	f2_arg0._optionProperties = {}
	f2_arg0._optionProperties._options = CoD.PCWidgetUtility.VoiceChatChannelsOptions
	f2_arg0._optionProperties._setCurrentValue = function(f3_arg0, f3_arg1, f3_arg2)
		Engine.SetProfileVar(f3_arg1, "voice_favored_channel", f3_arg2)
		f2_arg0.immediateUpdateValue = f3_arg2
		local f3_local0 = f2_arg0:getModel()
		f3_local0.currentValue:set(f2_arg0._optionProperties._getCurrentValue())
	end
	f2_arg0._optionProperties._getCurrentValue = function()
		if f2_arg0.immediateUpdateValue then
			local f4_local0 = f2_arg0.immediateUpdateValue
			f2_arg0.immediateUpdateValue = nil
			return f4_local0
		else
			return Engine.ProfileInt(f2_arg1, "voice_favored_channel")
		end
	end
end
CoD.PCWidgetUtility.PCKeybindingsTabId = 2
CoD.PCWidgetUtility.RGBPresetKeyColors = {
	COMBAT = 13209,
	MOVEMENT = 255,
	INTERACTION = 16711680,
}
CoD.PCWidgetUtility.PresetKeyColors = {
	{
		key_escape = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_tab = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_capital = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_m = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_f = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad1 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad2 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad3 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad4 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad5 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad6 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_1 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_2 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_3 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_4 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_5 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_6 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_e = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_x = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_q = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_v = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_r = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_w = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_a = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_s = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_d = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_c = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_space = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lcontrol = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lshift = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
	},
	{
		key_escape = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_tab = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_capital = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_m = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_f = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad1 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad2 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad3 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad4 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad5 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad6 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_1 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_2 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_3 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_4 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_x = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_g = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_e = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_q = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_v = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_r = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_w = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_a = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_s = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_d = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_space = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_c = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lcontrol = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lshift = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
	},
	{
		key_escape = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_backslash = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_p = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_c = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_h = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad1 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad2 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad3 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad4 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad5 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad6 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_9 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_0 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_8 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_7 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_6 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_5 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_u = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_comma = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_o = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_b = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_y = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_i = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_j = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_k = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_l = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_n = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_space = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_m = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_slash = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
	},
	{
		key_escape = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_tab = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_capital = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_m = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_f = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad1 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad2 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad3 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad4 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad5 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad6 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_1 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_2 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_3 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_4 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_5 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_6 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_e = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_x = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_q = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_v = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_r = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_w = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_a = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_s = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_d = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_space = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lcontrol = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lshift = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
	},
	{
		key_escape = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_tab = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_capital = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_n = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_e = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad1 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad2 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad3 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad4 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad5 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_numpad6 = CoD.PCWidgetUtility.RGBPresetKeyColors.INTERACTION,
		key_q = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_1 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_2 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_5 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_6 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_7 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_8 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_q = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_3 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_x = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_4 = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_v = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_r = CoD.PCWidgetUtility.RGBPresetKeyColors.COMBAT,
		key_w = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_a = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_s = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_d = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_space = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lcontrol = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
		key_lshift = CoD.PCWidgetUtility.RGBPresetKeyColors.MOVEMENT,
	},
}
CoD.PCWidgetUtility.CategoryScrollAndFocus = true
CoD.PCWidgetUtility.CategoryAlwaysOnTop = false
CoD.PCWidgetUtility.OptionsListCacheBehavior = true
CoD.PCWidgetUtility.ShowIfInViper = function(f5_arg0)
	local f5_local0
	if f5_arg0 == LuaDefine.BATTLENET_CURRENTGAME_FOURCC then
		f5_local0 = 1
		if not f5_local0 then
		else
			return f5_local0
		end
	end
	f5_local0 = 0
end
CoD.PCWidgetUtility.round = function(f6_arg0)
	if 0 <= f6_arg0 then
		return math.floor(f6_arg0 + 0.5)
	else
		return math.ceil(f6_arg0 - 0.5)
	end
end
local f0_local0 = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	return {
		models = {
			identityBadge = {
				gamertag = f7_arg2,
				xuid = f7_arg3,
			},
			inviteStatus = f7_arg1,
			isLeader = f7_arg4,
		},
		properties = {},
	}
end
CoD.PCWidgetUtility.ChangeWidgetValue = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5)
	local f8_local0 = f8_arg0._optionProperties._getCurrentValue(f8_arg1, f8_arg2)
	f8_arg0._optionProperties._setCurrentValue(f8_arg1, f8_arg2, f8_arg4)
	if f8_arg5 and f8_local0 ~= f8_arg3.currentValue:get() then
		f8_arg0:playSound("value_changed", f8_arg2)
	end
end
CoD.PCWidgetUtility.GetNearestValueFromFraction = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:getModel()
	f9_local0 = f9_local0.maxValue:get()
	local f9_local1 = f9_arg0:getModel()
	f9_local0 = f9_local0 - f9_local1.minValue:get()
	f9_local1 = CoD.PCWidgetUtility.GetNearestValue
	local f9_local2 = f9_arg0
	local f9_local3 = f9_arg0:getModel()
	return f9_local1(f9_local2, f9_local3.minValue:get() + f9_local0 * f9_arg1)
end
CoD.PCWidgetUtility.GetNearestValue = function(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0:getModel()
	if f10_arg1 == f10_local0.maxValue:get() then
		return f10_local0.maxValue:get()
	else
		return math.min(f10_local0.minValue:get() + CoD.PCWidgetUtility.round((f10_arg1 - f10_local0.minValue:get()) / f10_local0.increment:get()) * f10_local0.increment:get(), f10_local0.maxValue:get())
	end
end
CoD.PCWidgetUtility.GetNearestFraction = function(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0:getModel()
	return (f11_arg1 - f11_local0.minValue:get()) / (f11_local0.maxValue:get() - f11_local0.minValue:get())
end
CoD.PCWidgetUtility.UpdateSliderbarVisuals = function(f12_arg0, f12_arg1)
	if not f12_arg0.prepared then
		return
	end
	local f12_local0 = f12_arg0:getModel()
	if not f12_local0.currentValue or not f12_local0.currentValue:get() then
		return
	end
	local f12_local1 = CoD.PCWidgetUtility.GetNearestFraction(f12_arg0, f12_local0.currentValue:get())
	local f12_local2, f12_local3, f12_local4, f12_local5 = f12_arg1.FilledPartBg:getLocalRect()
	local f12_local6 = f12_local1 * (f12_local4 - f12_local2)
	if f12_arg1.NumericText ~= nil and f12_arg0.__editBoxModel then
		if f12_local0.decimalPlace and f12_local0.decimalPlace:get() > 0 then
			f12_arg0.__editBoxModel:set(string.format("%." .. f12_local0.decimalPlace:get() .. "f", f12_local0.currentValue:get()))
		else
			f12_arg0.__editBoxModel:set(string.format("%i", f12_local0.currentValue:get()))
		end
	end
	if f12_arg0.EditBox ~= nil and f12_arg0.__editBoxModel then
		if f12_local0.decimalPlace and f12_local0.decimalPlace:get() > 0 then
			f12_arg0.__editBoxModel:set(string.format("%." .. f12_local0.decimalPlace:get() .. "f", f12_local0.currentValue:get()))
		else
			f12_arg0.__editBoxModel:set(string.format("%i", f12_local0.currentValue:get()))
		end
	end
	local f12_local7 = LUI.clamp(math.floor(f12_local2 + f12_local6 - f12_arg0.m_markerHalfWidth), 0, f12_local4 - 1)
	f12_arg1.Bar:setLeftRight(true, false, f12_local7, math.floor(f12_local2 + f12_local6 + f12_arg0.m_markerHalfWidth))
	if f12_arg1.Bar.Detail then
		local f12_local8, f12_local9, f12_local10, f12_local11 = f12_arg1.Bar.Detail:getLocalRect()
		local f12_local12 = f12_local10 - f12_local8
		if f12_local7 - f12_local12 < 0 then
			local f12_local13 = -f12_local7
			f12_arg1.Bar.Detail:setLeftRight(true, false, f12_local13, f12_local13 + f12_local12)
		else
			f12_arg1.Bar.Detail:setLeftRight(true, false, -f12_local12, 0)
		end
	end
	f12_arg1.FilledPart:setLeftRight(true, false, f12_local2, f12_local2 + f12_local6)
end
CoD.PCWidgetUtility.UpdateSliderbarUsingMouse = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = f13_arg0:getModel()
	local f13_local1, f13_local2, f13_local3, f13_local4 = f13_arg2.FilledPartBg:getRect()
	local f13_local5 = f13_local3 - f13_local1
	CoD.PCWidgetUtility.ChangeWidgetValue(f13_arg0, f13_local0.profileVar:get(), f13_arg1.controller, f13_local0, CoD.PCWidgetUtility.GetNearestValueFromFraction(f13_arg0, CoD.ColorUtility.ClampColor(f13_arg1.x - f13_local1, 0, f13_local5) / f13_local5), false)
	f13_arg0.m_internalValue = f13_local0.currentValue:get()
end
CoD.PCWidgetUtility.UpdateSliderbarMousePosition = function(f14_arg0, f14_arg1, f14_arg2)
	assert(f14_arg1.controller ~= nil)
	assert(f14_arg1.x ~= nil)
	CoD.PCWidgetUtility.UpdateSliderbarUsingMouse(f14_arg0, f14_arg1, f14_arg2)
	return true
end
CoD.PCWidgetUtility.UpdateSlideDirection = function(m_currentSpeed, f15_arg1)
	if not m_currentSpeed.m_disableNavigation then
		if not m_currentSpeed.m_beat then
			m_currentSpeed.m_slideDirection = f15_arg1
			m_currentSpeed:addElement(m_currentSpeed.m_timer)
			m_currentSpeed.m_currentSpeed = m_currentSpeed.m_sliderSpeed
			m_currentSpeed.m_beat = true
			m_currentSpeed:addElement(m_currentSpeed.m_heartbeat)
		else
			m_currentSpeed.m_heartbeat:reset()
			m_currentSpeed.m_currentSpeed = math.min(m_currentSpeed.m_currentSpeed * 1.1, m_currentSpeed.m_speedMax)
		end
	end
end
CoD.PCWidgetUtility.PrepareSliderBar = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
	if not f16_arg3 or not f16_arg3.maxValue or not f16_arg3.minValue or not f16_arg3.currentValue then
		return
	end
	f16_arg0.controller = f16_arg1
	f16_arg0.__disableAutoButtonCallback = true
	assert(f16_arg4.FilledPart ~= nil)
	assert(f16_arg4.FilledPartBg ~= nil)
	assert(f16_arg4.Bar ~= nil)
	local f16_local0 = assert
	local f16_local1
	if f16_arg4.NumericText == nil and f16_arg0.EditBox == nil then
		f16_local1 = false
	else
		f16_local1 = true
	end
	f16_local0(f16_local1)
	f16_arg4:setHandleMouseButton(true)
	DisableKeyboardNavigationByElement(f16_arg4)
	if not f16_arg3.increment then
		f16_local0 = f16_arg3:create("increment")
		f16_local0:set(1)
	end
	if not f16_arg3.decimalPlace then
		if f16_arg3.increment:get() == 1 then
			f16_local0 = f16_arg3:create("decimalPlace")
			f16_local0:set(0)
		else
			f16_local0 = f16_arg3:create("decimalPlace")
			f16_local0:set(2)
		end
	end
	assert(f16_arg3.minValue:get() < f16_arg3.maxValue:get())
	f16_arg0.m_internalValue = f16_arg3.currentValue:get()
	f16_arg0.m_sliderSpeed = f16_arg3.increment:get() * 10
	f16_arg0.m_speedMax = f16_arg0.m_sliderSpeed * 10
	f16_arg0.m_slideDirection = 0
	f16_local0, f16_local1, f16_local2, f16_local3 = f16_arg4.Bar:getLocalRect()
	f16_arg0.m_markerHalfWidth = (f16_local2 - f16_local0) / 2
	f16_arg0.m_timer = LUI.UITimer.new(1, "update_bar", false)
	f16_arg0.m_heartbeat = LUI.UITimer.new(100, "check_pulse", false)
	f16_arg0:registerEventHandler("update_bar", function(element, event)
		if element.m_slideDirection then
			local f17_local0 = LUI.clamp(element.m_internalValue + element.m_currentSpeed * element.m_slideDirection * event.timeElapsed / 1000, f16_arg3.minValue:get(), f16_arg3.maxValue:get())
			CoD.PCWidgetUtility.ChangeWidgetValue(element, f16_arg3.profileVar:get(), f16_arg1, f16_arg3, CoD.PCWidgetUtility.GetNearestValue(element, f17_local0), true)
			element.m_internalValue = f17_local0
		end
	end)
	f16_arg0:registerEventHandler("check_pulse", function(element, event)
		if f16_arg0.m_beat then
			f16_arg0.m_timer:close()
			f16_arg0.m_heartbeat:close()
			f16_arg0.m_beat = nil
		end
	end)
	f16_arg4:registerEventHandler("leftmousedrag", function(element, event)
		if element.__lockedFocus then
			return CoD.PCWidgetUtility.UpdateSliderbarMousePosition(f16_arg0, event, element)
		else
		end
	end)
	f16_arg4:registerEventHandler("leftmousedown", function(element, event)
		f16_arg2:CaptureMouseAndLockFocus(event.controller, element)
		SetProperty(f16_arg2, "preserveLuiButton", {
			[Enum.LUIButton[@"lui_key_xba_pscross"]] = true,
		})
		element.__lockedFocus = true
		f16_arg0:playSound("gain_focus", f16_arg1)
		return CoD.PCWidgetUtility.UpdateSliderbarMousePosition(f16_arg0, event, element)
	end)
	f16_arg4:registerEventHandler("leftmouseup", function(element, event)
		f16_arg2:CaptureMouseAndLockFocus(event.controller, nil)
		SetProperty(f16_arg2, "preserveLuiButton", {
			[Enum.LUIButton[@"lui_key_xba_pscross"]] = nil,
		})
		element.__lockedFocus = false
		f16_arg0:playSound("value_changed", f16_arg1)
		return true
	end)
	f16_arg4:appendEventHandler("lose_focus", function(f22_arg0, f22_arg1)
		f16_arg0.m_slideDirection = 0
		f16_arg0.m_timer:close()
		if f22_arg0.__lockedFocus then
			assert(f22_arg1.controller ~= nil)
			f16_arg2:CaptureMouseAndLockFocus(f22_arg1.controller, nil)
			SetProperty(f16_arg2, "preserveLuiButton", {
				[Enum.LUIButton[@"lui_key_xba_pscross"]] = nil,
			})
			f22_arg0.__lockedFocus = false
		end
	end)
	f16_arg4:registerEventHandler("mouse_capture_lost", function(element, event)
		if element.__lockedFocus then
			SetProperty(f16_arg2, "preserveLuiButton", {
				[Enum.LUIButton[@"lui_key_xba_pscross"]] = nil,
			})
			element.__lockedFocus = false
		end
	end)
	f16_arg4.__onSliderClose = function(f24_arg0)
		if f24_arg0.__lockedFocus then
			f16_arg2:CaptureMouseAndLockFocus(f16_arg1, nil)
			SetProperty(f16_arg2, "preserveLuiButton", {
				[Enum.LUIButton[@"lui_key_xba_pscross"]] = nil,
			})
			f24_arg0.__lockedFocus = false
		end
	end
	LUI.OverrideFunction_CallOriginalSecond(f16_arg4, "close", f16_arg4.__onSliderClose)
	f16_arg0.__navAction = function(f25_arg0, f25_arg1)
		local f25_local0 = CoD.PCWidgetUtility.UpdateSlideDirection
		local f25_local1 = f16_arg0
		local f25_local2
		if f25_arg1 == "left" then
			f25_local2 = -1
			if not f25_local2 then
			else
				f25_local0(f25_local1, f25_local2, f16_arg4)
				return true
			end
		end
		f25_local2 = 1
	end
	if f16_arg0.EditBox ~= nil then
		local f16_local4 = 7
		DisableKeyboardNavigationByElement(f16_arg0.EditBox)
		CoD.Menu.AddButtonCallbackFunction(f16_arg2, f16_arg0, f16_arg1, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
			CoD.PCWidgetUtility.BringIntoView(f16_arg0, f26_arg2)
			f26_arg1:ChangeInputFocus(f26_arg2, f16_arg0.EditBox)
			return true
		end)
		f16_arg0.__editBoxModel = f16_arg3:create("textRepresentation")
		if f16_arg3.decimalPlace and f16_arg3.decimalPlace:get() > 0 then
			f16_arg0.__editBoxModel:set(string.format("%." .. f16_arg3.decimalPlace:get() .. "f", f16_arg3.currentValue:get()))
		else
			f16_arg0.__editBoxModel:set(string.format("%i", f16_arg3.currentValue:get()))
		end
		CoD.PCUtility.SetupEditControlWithModel(f16_arg0.EditBox, f16_arg1, f16_arg2, f16_arg0.__editBoxModel, function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
			if string.len(f27_arg0:get()) > 0 then
				local f27_local0 = f16_arg0:getModel()
				f27_local0 = f27_local0.profileVar
				if f27_local0 then
					f27_local0 = f16_arg0:getModel()
					f27_local0 = f27_local0.profileVar:get()
				end
				local f27_local1 = tonumber(f27_arg0:get())
				CoD.PCWidgetUtility.ChangeWidgetValue(f16_arg0, f27_local0, f16_arg1, f16_arg0:getModel(), f27_local1, true)
				f16_arg0.m_internalValue = f27_local1
			end
		end)
		local f16_local5 = CoD.PCUtility.MakeEditControlNumerical
		local f16_local6 = f16_arg0.EditBox
		local f16_local7 = f16_arg3.minValue:get()
		local f16_local8 = f16_arg3.maxValue:get()
		local f16_local9
		if not f16_arg3.decimalPlace or f16_arg3.decimalPlace:get() ~= 0 then
			f16_local9 = false
		else
			f16_local9 = true
		end
		f16_local5(f16_local6, f16_local7, f16_local8, f16_local9, f16_local4)
	end
	f16_arg0.prepared = true
	CoD.PCWidgetUtility.UpdateSliderbarVisuals(f16_arg0, f16_arg4)
end
CoD.PCWidgetUtility.IsToggled = function(f28_arg0, f28_arg1)
	local f28_local0 = f28_arg0:getModel()
	if f28_local0.currentValue and f28_local0.maxValue then
		return f28_local0.currentValue:get() == f28_local0.maxValue:get()
	else
		return false
	end
end
CoD.PCWidgetUtility.SetToggleString = function(f29_arg0, f29_arg1, f29_arg2)
	local f29_local0 = f29_arg0:getModel()
	local f29_local1 = f29_local0
	local f29_local2 = f29_local0[f29_arg1]
	if f29_local2 then
		f29_local2 = f29_local1 and f29_local0[f29_arg1]:get()
	end
	if f29_local2 then
		f29_arg2 = f29_local2
	end
	return f29_arg2
end
CoD.PCWidgetUtility.PrepareYesNoToggleButton = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4, f30_arg5)
	if not f30_arg5 then
		return
	else
		local f30_local0 = function(f31_arg0)
			CoD.PCWidgetUtility.BringIntoView(f30_arg0, f30_arg3)
			if f30_arg0._unavailable then
				return false
			else
				local f31_local0
				if f31_arg0 then
					f31_local0 = f30_arg5.maxValue:get()
					if not f31_local0 then
					else
						CoD.PCWidgetUtility.ChangeWidgetValue(f30_arg0, f30_arg5.profileVar:get(), f30_arg3, f30_arg5, f31_local0, true)
						f30_arg0:processEvent({
							name = "update_state",
							controller = f30_arg3,
							menu = f30_arg4,
							forceDispatch = true,
						})
						return true
					end
				end
			end
			f31_local0 = f30_arg5.minValue:get()
		end
		f30_arg4:AddButtonCallbackFunction(f30_arg1, f30_arg3, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
			f30_local0(true)
			return true
		end, false)
		f30_arg4:AddButtonCallbackFunction(f30_arg2, f30_arg3, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f33_arg0, f33_arg1, f33_arg2, f33_arg3)
			f30_local0(false)
			return true
		end, false)
		f30_arg4:AddButtonCallbackFunction(f30_arg0, f30_arg3, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
			return false
		end, false)
		f30_arg4:AddButtonCallbackFunction(f30_arg0, f30_arg3, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
			f30_local0(not CoD.PCWidgetUtility.IsToggled(f30_arg0, nil))
			return true
		end, false)
		f30_arg0.__navAction = function(f36_arg0, f36_arg1)
			f30_local0(f36_arg1 == "left")
			return true
		end
	end
end
CoD.PCWidgetUtility.KeyBoundHandler = function(f37_arg0, f37_arg1)
	local f37_local0 = f37_arg0:getModel()
	if f37_local0 then
		local f37_local1 = f37_local0.command:get()
		local f37_local2 = f37_local0.bindIndex:get()
		if f37_local1 and f37_local2 then
			f37_local0.binding:set(false)
			f37_local0.keybind:set(Engine.GetKeyBindingLocalizedString(f37_arg1.controller, f37_local1, f37_local2, false, false))
		end
	end
	return true
end
CoD.PCWidgetUtility.PrepareMainAltKeyBinder = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4, f38_arg5)
	f38_arg0._bindKey = function(f39_arg0)
		if not f38_arg2.m_disableNavigation and f38_arg2:AcceptGamePadButtonInputFromModelCallback(f38_arg1) then
			CoD.PCWidgetUtility.BringIntoView(f38_arg0, f38_arg1)
			if not Engine.LastInput_Gamepad() then
				local f39_local0 = f38_arg0:getModel()
				if f39_local0 then
					local f39_local1 = f39_local0.command:get()
					local f39_local2 = f39_local0.bindIndex:get()
					if f39_local1 and f39_local2 then
						local f39_local3 = DataSources.KeybindMessages.getModel(f38_arg1)
						f39_local3.showPastKeybind:set(false)
						f39_local3 = DataSources.KeybindMessages.getModel(f38_arg1)
						f39_local3.showErrorMessage:set(false)
						f39_local3 = DataSources.KeybindMessages.getModel(f38_arg1)
						f39_local3.showWarningMessage:set(false)
						f39_local3 = DataSources.KeybindMessages.getModel(f38_arg1)
						f39_local3.isBindingKey:set(true)
						f39_local3 = DataSources.KeybindMessages.getModel(f38_arg1)
						f39_local3.keybindMessage:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1EEC966B7C77D17"))
						Engine.ExecNow(f38_arg1, "clearKeyStates")
						PlaySoundSetSound(f38_arg0, "gain_focus")
						if f39_arg0 then
							f39_local3 = f38_arg3.bind_alt:get()
							local f39_local4 = DataSources.KeybindMessages.getModel(f38_arg1)
							f39_local4.currentKeybind:set(Engine.ToUpper(f39_local3))
							f39_local0.binding_alt:set(true)
							Engine[@"hash_59EB5B4A37440B79"](f38_arg1, f39_local1, f39_local2)
						else
							f39_local3 = f38_arg3.bind_main:get()
							local f39_local4 = DataSources.KeybindMessages.getModel(f38_arg1)
							f39_local4.currentKeybind:set(Engine.ToUpper(f39_local3))
							f39_local0.binding_main:set(true)
							Engine.BindCommand(f38_arg1, f39_local1, f39_local2)
						end
					end
				end
			end
			return true
		else
		end
	end
	f38_arg2:AddButtonCallbackFunction(f38_arg4, f38_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
		f38_arg0._bindKey(false)
		return true
	end, false)
	f38_arg2:AddButtonCallbackFunction(f38_arg5, f38_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
		f38_arg0._bindKey(true)
		return true
	end, false)
	local f38_local0 = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
		if not Engine.LastInput_Gamepad() then
			CoD.PCWidgetUtility.BringIntoView(f38_arg0, f42_arg2)
			CoD.PCWidgetUtility.DeleteKeybind(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg0 == f38_arg4)
		end
	end
	for f38_local4, f38_local5 in ipairs({
		"ui_remove",
		"BACKSPACE",
	}) do
		f38_arg2:AddButtonCallbackFunction(f38_arg4, f38_arg1, Enum.LUIButton[@"lui_key_none"], f38_local5, f38_local0)
		f38_arg2:AddButtonCallbackFunction(f38_arg5, f38_arg1, Enum.LUIButton[@"lui_key_none"], f38_local5, f38_local0)
	end
	if not f38_arg0.__contextualPrepared then
		f38_arg4:AddContextualMenuAction(f38_arg2, f38_arg1, "options/unbind", function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
			local f43_local0 = f43_arg0:getModel()
			f43_local0 = f43_local0.bind_main:get()
			if f43_local0 and f43_local0 ~= "" then
				return function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
					PlaySoundSetSound(f38_arg0, "toggle")
					f38_local0(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
				end
			else
			end
		end)
		f38_arg5:AddContextualMenuAction(f38_arg2, f38_arg1, "options/unbind", function(f45_arg0, f45_arg1, f45_arg2, f45_arg3)
			local f45_local0 = f45_arg0:getModel()
			f45_local0 = f45_local0.bind_alt:get()
			if f45_local0 and f45_local0 ~= "" then
				return function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
					PlaySoundSetSound(f38_arg0, "toggle")
					f38_local0(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
				end
			else
			end
		end)
		f38_arg0.__contextualPrepared = true
	end
	f38_arg0._updateKeyBind = function(f47_arg0, f47_arg1)
		local f47_local0 = f47_arg0:getModel()
		if f47_local0 then
			local f47_local1 = f47_local0.command:get()
			local f47_local2 = f47_local0.bindIndex:get()
			if f47_local1 and f47_local2 then
				local f47_local3, f47_local4 = Engine[@"hash_27C4C4DBF61B869E"](f47_arg1.controller, f47_local1, f47_local2, true)
				if not f47_local3 then
					f47_local3 = ""
				end
				if not f47_local4 then
					f47_local4 = ""
				end
				f47_local0.bind_main:set(Engine.ToUpper(f47_local3))
				f47_local0.bind_alt:set(Engine.ToUpper(f47_local4))
				if f47_local0.binding_main:get() or f47_local0.binding_alt:get() then
					local f47_local5 = DataSources.KeybindMessages.getModel(f38_arg1)
					f47_local5.showErrorMessage:set(false)
					if not f47_arg1.isValidKeyBinding and f47_arg1.invalidKey then
						if f47_arg1.invalidKey ~= "" then
							f47_local5 = DataSources.KeybindMessages.getModel(f38_arg1)
							f47_local5.showErrorMessage:set(true)
							f47_local5 = DataSources.KeybindMessages.getModel(f38_arg1)
							f47_local5.keybindMessage:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_57C79F5CDEA78F15", Engine.ToUpper(f47_arg1.invalidKey)))
						end
						return
					end
					f47_local5 = DataSources.KeybindMessages.getModel(f38_arg1)
					f47_local5 = f47_local5.currentKeybind:get()
					local f47_local6 = ""
					local f47_local7 = DataSources.KeybindMessages.getModel(f38_arg1)
					f47_local7.pastKeybind:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_42EC45BE9E9BD199", f47_local5))
					if f47_local0.binding_main:get() then
						f47_local6 = f47_local3
					else
						f47_local6 = f47_local4
					end
					if f47_local5 ~= Engine.ToUpper(f47_local6) then
						PlaySoundSetSound(f47_arg0, "toggle")
						f47_local7 = 6
						local f47_local8 = {}
						for f47_local9 = 1, f47_local7, 1 do
							if f47_arg1["unbindedBindings" .. f47_local9] and f47_arg1["unbindedBindings" .. f47_local9] ~= "" then
								table.insert(f47_local8, f47_arg1["unbindedBindings" .. f47_local9])
							end
						end
						if #f47_local8 > 0 then
							f47_local9 = DataSources.KeybindMessages.getModel(f38_arg1)
							f47_local9.showWarningMessage:set(true)
							f47_local9 = Engine[@"hash_4F9F1239CFD921FE"](f47_local0.name:get())
							if #f47_local8 > 1 then
								f47_local10 = DataSources.KeybindMessages.getModel(f38_arg1)
								f47_local10.keybindMessage:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_592F53A3665DC3A5", Engine.ToUpper(f47_local6), f47_local9))
							else
								local f47_local10 = Engine[@"hash_4F9F1239CFD921FE"](CoD.PCOptionsUtility.CommandToXHash(f38_arg1, f47_local8[1]) or 0x0)
								local f47_local11 = DataSources.KeybindMessages.getModel(f38_arg1)
								f47_local11.keybindMessage:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4EB1FF40050E3938", Engine.ToUpper(f47_local6), f47_local10, f47_local9))
							end
						else
							local f47_local9 = DataSources.KeybindMessages.getModel(f38_arg1)
							f47_local9.showPastKeybind:set(true)
							if f47_local5 == "" then
								f47_local9 = DataSources.KeybindMessages.getModel(f38_arg1)
								f47_local9.keybindMessage:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63D1E55048CE3726", Engine.ToUpper(f47_local6)))
							else
								f47_local9 = DataSources.KeybindMessages.getModel(f38_arg1)
								f47_local9.currentKeybind:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_34A7CDEC944CCCAF", Engine.ToUpper(f47_local6)))
								f47_local9 = DataSources.KeybindMessages.getModel(f38_arg1)
								f47_local9.keybindMessage:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2B729DA024CB9455", Engine.ToUpper(f47_local6), f47_local5))
							end
						end
						Dvar[@"hash_72B49C5C32022076"]:set(true)
						f47_local9 = DataSources.OptionControlKeyBindingsDropDown.getModel(f38_arg1)
						f47_local9.presetIsModified:set(true)
						f47_local9 = f47_arg0:getMenu()
						if f47_local9._keybindMessageTimer then
							f47_local9._keybindMessageTimer:close()
							f47_local9._keybindMessageTimer = nil
						end
						f47_local9._keybindMessageTimer = LUI.UITimer.newElementTimer(5000, true, function()
							local f48_local0 = DataSources.KeybindMessages.getModel(f38_arg1)
							f48_local0.showPastKeybind:set(false)
							f48_local0 = DataSources.KeybindMessages.getModel(f38_arg1)
							f48_local0.showWarningMessage:set(false)
							f47_local9._keybindMessageTimer:close()
							f47_local9._keybindMessageTimer = nil
						end)
						f47_local9:addElement(f47_local9._keybindMessageTimer)
						if CoD.PCOptionsUtility.SettingsSession[f38_arg1] then
							CoD.PCOptionsUtility.SettingsSession[f38_arg1].optionsChangedInTab[CoD.PCOptionsUtility.OptionTabIds.Keybind] = true
						end
					end
					f47_local7 = DataSources.KeybindMessages.getModel(f38_arg1)
					f47_local7.isBindingKey:set(false)
				end
				f47_local0.binding_main:set(false)
				f47_local0.binding_alt:set(false)
			end
		end
	end
	f38_arg0:registerEventHandler("key_bound", f38_arg0._updateKeyBind)
	f38_arg0:registerEventHandler("input_source_changed", f38_arg0._updateKeyBind)
	f38_arg0:registerEventHandler("options_refresh", f38_arg0._updateKeyBind)
end
CoD.PCWidgetUtility.DeleteKeybind = function(f49_arg0, f49_arg1, f49_arg2, f49_arg3, f49_arg4)
	local f49_local0 = f49_arg0:getParent()
	f49_local0 = f49_local0:getModel()
	if f49_local0 then
		local f49_local1 = f49_local0.command:get()
		local f49_local2 = f49_local0.bindIndex:get()
		if f49_local1 and f49_local2 then
			PlaySoundSetSound(f49_arg0, "toggle")
			Engine[@"hash_183D5ABE29C88EF6"](f49_arg2, f49_local1, f49_local2, f49_arg4)
		end
	end
	return true
end
CoD.PCWidgetUtility.GetWidgetXYOffset = function(f50_arg0, f50_arg1)
	assert(f50_arg0.isScrollView)
	local f50_local0 = f50_arg1:getParent()
	while f50_local0 ~= f50_arg0.View.itemStencil and f50_local0:getParent() ~= nil do
		f50_arg1 = f50_local0
		f50_local0 = f50_arg1:getParent()
	end
	local f50_local1, f50_local2, f50_local3, f50_local4 = f50_arg1:getLocalRect()
	return f50_local1, f50_local2
end
CoD.PCWidgetUtility.PrepareScrollView = function(f51_arg0, f51_arg1, f51_arg2)
	f51_arg0._setViewFrameTop = function(f52_arg0, f52_arg1, f52_arg2)
		local f52_local0, f52_local1, f52_local2, f52_local3 = f52_arg0.View:getLocalTopBottom()
		local f52_local4 = assert
		local f52_local5
		if (f52_local0 ~= 0 or f52_local1 ~= 0) and (f52_local0 ~= 0 or f52_local1 ~= 1 or f52_local2 ~= 0 or f52_local3 ~= 0) then
			f52_local5 = false
		else
			f52_local5 = true
		end
		f52_local4(f52_local5)
		if f52_local0 ~= 0 or f52_local1 ~= 1 then
			f52_local4 = false
		else
			f52_local4 = true
		end
		if not f52_local4 then
			f52_arg1 = math.floor(LUI.clamp(f52_arg1, 0, f52_arg0.totalYDistance))
			f52_arg0.View:beginAnimation("move", f52_arg2 or 0)
			if not f52_arg0._scrollAnchoredToBottom then
				f52_arg0.View:setTopPx(-f52_arg1)
			else
				f52_arg0.View:setTopPx(f52_arg1 + f52_arg0:getHeight() - f52_arg0.View:getHeight())
			end
			f52_arg0.currentYOffset = f52_arg1
			f52_arg0:processEventToParent({
				name = "view_scrolled",
				controller = f51_arg1,
			})
		end
	end
	f51_arg0._setViewFrameLeft = function(f53_arg0, f53_arg1, f53_arg2)
		local f53_local0, f53_local1, f53_local2, f53_local3 = f53_arg0.View:getLocalLeftRight()
		local f53_local4 = assert
		local f53_local5
		if (f53_local0 ~= 0 or f53_local1 ~= 0) and (f53_local0 ~= 0 or f53_local1 ~= 1 or f53_local2 ~= 0 or f53_local3 ~= 0) then
			f53_local5 = false
		else
			f53_local5 = true
		end
		f53_local4(f53_local5)
		if f53_local0 ~= 0 or f53_local1 ~= 1 then
			f53_local4 = false
		else
			f53_local4 = true
		end
		if not f53_local4 then
			f53_arg1 = math.floor(LUI.clamp(f53_arg1, 0, f53_arg0.totalXDistance))
			f53_arg0.View:beginAnimation("move", f53_arg2 or 0)
			f53_arg0.View:setLeftPx(-f53_arg1)
			f53_arg0.currentXOffset = f53_arg1
			f53_arg0:processEventToParent({
				name = "view_scrolled",
				controller = f51_arg1,
			})
		end
	end
	f51_arg0._computeDefaultTotalScrollDistances = function(f54_arg0)
		return math.max(f54_arg0.View:getScreenWidth(f51_arg1) - f54_arg0:getScreenWidth(f51_arg1), 0), math.max(f54_arg0.View:getScreenHeight(f51_arg1) - f54_arg0:getScreenHeight(f51_arg1), 0)
	end
	f51_arg0._onSizeChanged = function(f55_arg0, f55_arg1)
		f55_arg0.viewHeight = f55_arg0.View:getScreenHeight(f51_arg1)
		f55_arg0.viewWidth = f55_arg0.View:getScreenWidth(f51_arg1)
		local f55_local0, f55_local1 = f55_arg0:_computeDefaultTotalScrollDistances()
		f55_arg0.totalYDistance = f55_arg0.totalYDistanceOverride or f55_local1
		f55_arg0.totalXDistance = f55_arg0.totalXDistanceOverride or f55_local0
		f55_arg0.currentXOffset = math.min(f55_arg0.currentXOffset, f55_arg0.totalXDistance)
		f55_arg0.currentYOffset = math.min(f55_arg0.currentYOffset, f55_arg0.totalYDistance)
		f55_arg0:_setViewFrameLeft(f55_arg0.currentXOffset, 0)
		f55_arg0:_setViewFrameTop(f55_arg0.currentYOffset, 0)
		return true
	end
	f51_arg0._overrideTotalDistances = function(f56_arg0, f56_arg1, f56_arg2)
		f56_arg0.totalYDistanceOverride = f56_arg1
		f56_arg0.totalXDistanceOverride = f56_arg2
		f56_arg0.totalYDistance = f56_arg0.totalYDistanceOverride or f56_arg0.totalYDistance
		f56_arg0.totalXDistance = f56_arg0.totalXDistanceOverride or f56_arg0.totalXDistance
	end
	f51_arg0._scrollVertical = function(f57_arg0)
		local f57_local0 = f51_arg0.currentYOffset + f57_arg0
		if f51_arg0._scrollAnchoredToBottom then
			f57_local0 = f51_arg0.currentYOffset - f57_arg0
		end
		f51_arg0:_setViewFrameTop(f57_local0, 0)
		CoD.FreeCursorUtility.RetriggerCursorPositionNoDelay(f51_arg0, f51_arg1)
	end
	f51_arg0._scrollHorizontal = function(f58_arg0)
		f51_arg0:_setViewFrameLeft(f51_arg0.currentXOffset + f58_arg0, 0)
		CoD.FreeCursorUtility.RetriggerCursorPositionNoDelay(f51_arg0, f51_arg1)
	end
	f51_arg0.isScrollView = true
	f51_arg0.viewHeight = 0
	f51_arg0.viewWidth = 0
	f51_arg0.currentXOffset = 0
	f51_arg0.totalXDistance = 0
	f51_arg0.currentYOffset = 0
	f51_arg0.totalYDistance = 0
	f51_arg0.unitScrollAmount = 20
	f51_arg0:setUseStencil(true)
	f51_arg0:setupSizeChangeEventWithDefaultLayout()
	f51_arg0:registerEventHandler("size_changed", f51_arg0._onSizeChanged)
end
CoD.PCWidgetUtility.AnchorScrollViewToBottom = function(f59_arg0, f59_arg1)
	assert(f59_arg0.isScrollView)
	f59_arg0._scrollAnchoredToBottom = true
end
CoD.PCWidgetUtility.ScrollToElementOnTopLeft = function(f60_arg0, f60_arg1)
	assert(f60_arg0.isScrollView)
	local f60_local0, f60_local1, f60_local2, f60_local3 = f60_arg0:getRect()
	local f60_local4, f60_local5, f60_local6, f60_local7 = f60_arg1:getRect()
	local f60_local8 = f60_local5 - f60_local1
	local f60_local9 = f60_local7 - f60_local1
	local f60_local10 = f60_local4 - f60_local0
	local f60_local11 = f60_local6 - f60_local2
	if f60_local1 <= f60_local5 and f60_local7 < f60_local3 and f60_local0 <= f60_local4 and f60_local6 < f60_local2 then
		return false
	else
		CoD.PCWidgetUtility.ScrollVerticalByAmount(f60_arg0, f60_local8)
		CoD.PCWidgetUtility.ScrollHorizontalByAmount(f60_arg0, f60_local10)
	end
end
CoD.PCWidgetUtility.ScrollToElement = function(f61_arg0, f61_arg1, f61_arg2)
	assert(f61_arg0.isScrollView)
	local f61_local0, f61_local1, f61_local2, f61_local3 = f61_arg0:getScreenRect(f61_arg2)
	local f61_local4, f61_local5, f61_local6, f61_local7 = f61_arg1:getScreenRect(f61_arg2)
	if f61_local1 <= f61_local5 and f61_local7 <= f61_local3 and f61_local0 <= f61_local4 and f61_local6 <= f61_local2 then
		return false
	end
	local f61_local8 = f61_local5 - f61_local1
	local f61_local9 = f61_local7 - f61_local1
	local f61_local10 = f61_local4 - f61_local0
	local f61_local11 = f61_local6 - f61_local0
	if f61_arg0:getHeight() < f61_local9 then
		CoD.PCWidgetUtility.ScrollVerticalByAmount(f61_arg0, f61_local9 - f61_local3 - f61_local1)
	elseif f61_local8 < 0 then
		CoD.PCWidgetUtility.ScrollVerticalByAmount(f61_arg0, f61_local8)
	end
	if f61_arg0:getWidth() < f61_local11 then
		CoD.PCWidgetUtility.ScrollHorizontalByAmount(f61_arg0, f61_local11 - f61_local2 - f61_local0)
	elseif f61_local10 < 0 then
		CoD.PCWidgetUtility.ScrollHorizontalByAmount(f61_arg0, f61_local10)
	end
	return true
end
CoD.PCWidgetUtility.BringIntoView = function(f62_arg0, f62_arg1)
	local f62_local0 = f62_arg0
	while f62_local0 and not f62_local0.isScrollView do
		f62_local0 = f62_local0:getParent()
	end
	if f62_local0 then
		local f62_local1 = f62_arg0
		while f62_local1 and not f62_local1.gridInfoTable do
			f62_local1 = f62_local1:getParent()
		end
		if f62_local1 and f62_local1.gridInfoTable.parentGrid.activeWidget ~= f62_local1 then
			SetCurrentElementAsActive(f62_local0, f62_local1, f62_arg1)
		end
		CoD.PCWidgetUtility.ScrollToElement(f62_local0, f62_arg0, f62_arg1)
	end
end
CoD.PCWidgetUtility.ScrollVerticalTo = function(f63_arg0, f63_arg1)
	assert(f63_arg0.isScrollView)
	f63_arg0:_setViewFrameTop(f63_arg1)
end
CoD.PCWidgetUtility.ScrollVerticalByAmount = function(f64_arg0, f64_arg1)
	assert(f64_arg0.isScrollView)
	f64_arg0._scrollVertical(f64_arg1)
end
CoD.PCWidgetUtility.ScrollUpOneUnit = function(f65_arg0)
	assert(f65_arg0.isScrollView)
	f65_arg0._scrollVertical(-f65_arg0.unitScrollAmount)
end
CoD.PCWidgetUtility.ScrollDownOneUnit = function(f66_arg0)
	assert(f66_arg0.isScrollView)
	f66_arg0._scrollVertical(f66_arg0.unitScrollAmount)
end
CoD.PCWidgetUtility.ScrollHorizontalTo = function(f67_arg0, f67_arg1)
	assert(f67_arg0.isScrollView)
	f67_arg0:_setViewFrameLeft(f67_arg1)
end
CoD.PCWidgetUtility.ScrollHorizontalByAmount = function(f68_arg0, f68_arg1)
	assert(f68_arg0.isScrollView)
	f68_arg0._scrollHorizontal(f68_arg1)
end
CoD.PCWidgetUtility.ScrollLeftOneUnit = function(f69_arg0)
	assert(f69_arg0.isScrollView)
	f69_arg0._scrollHorizontal(-f69_arg0.unitScrollAmount)
end
CoD.PCWidgetUtility.ScrollRightOneUnit = function(f70_arg0)
	assert(f70_arg0.isScrollView)
	f70_arg0._scrollHorizontal(f70_arg0.unitScrollAmount)
end
CoD.PCWidgetUtility.ScrollToActiveElement = function(f71_arg0, f71_arg1)
	assert(f71_arg0.isScrollView)
	CoD.PCWidgetUtility.ScrollToElement(f71_arg0, f71_arg0.View.activeWidget, f71_arg1)
end
CoD.PCWidgetUtility.AddScrollWheels = function(f72_arg0, f72_arg1, f72_arg2)
	f72_arg0:AddButtonCallbackFunction(f72_arg2, f72_arg1, Enum.LUIButton[@"lui_key_none"], "MWHEELUP", function(f73_arg0, f73_arg1, f73_arg2, f73_arg3)
		f72_arg2.ScrollView.View:navigateItemUp()
		return true
	end, function(f74_arg0, f74_arg1, f74_arg2)
		CoD.Menu.SetButtonLabel(f74_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MWHEELUP")
		return false
	end, false)
	f72_arg0:AddButtonCallbackFunction(f72_arg2, f72_arg1, Enum.LUIButton[@"lui_key_none"], "MWHEELDOWN", function(f75_arg0, f75_arg1, f75_arg2, f75_arg3, f75_arg4)
		f72_arg2.ScrollView.View:navigateItemDown()
		return true
	end, function(f76_arg0, f76_arg1, f76_arg2)
		CoD.Menu.SetButtonLabel(f76_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MWHEELDOWN")
		return false
	end, false)
end
CoD.PCWidgetUtility.SetMouseWheelScrollUnit = function(f77_arg0, f77_arg1)
	f77_arg0.wheelScrollUnit = f77_arg1
end
CoD.PCWidgetUtility.SetArrowClickScrollUnit = function(f78_arg0, f78_arg1)
	f78_arg0.arrowScrollUnit = f78_arg1
end
CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget = function(f79_arg0, f79_arg1, f79_arg2)
	if f79_arg0.ScrollView.totalYDistance == 0 then
		f79_arg0.VScrollbar:setAlpha(0)
	else
		f79_arg0.VScrollbar:setAlpha(1)
		local f79_local0 = (f79_arg0.ScrollView.viewHeight - f79_arg0.ScrollView.totalYDistance) / f79_arg0.ScrollView.viewHeight
		if not f79_arg0.ScrollView._scrollAnchoredToBottom then
			local f79_local1 = f79_arg0.ScrollView.currentYOffset / f79_arg0.ScrollView.viewHeight
			f79_arg0.VScrollbar.Scrollbar.Bar:setTopBottomPct(f79_local1, f79_local1 + f79_local0)
		else
			local f79_local1 = 1 - f79_arg0.ScrollView.currentYOffset / f79_arg0.ScrollView.viewHeight
			f79_arg0.VScrollbar.Scrollbar.Bar:setTopBottomPct(f79_local1 - f79_local0, f79_local1)
		end
	end
end
CoD.PCWidgetUtility.PrepareVScrollWidgetNavigation = function(f80_arg0, f80_arg1, f80_arg2)
	local f80_local0 = 0
	local f80_local1 = 1
	local f80_local2 = function(f81_arg0)
		if not f81_arg0:isFocusable() then
			f81_arg0 = CoD.BaseUtility.FindSingleFocusableDescendant(f81_arg0, true)
		end
		f80_arg2:ChangeFocusedElement(f80_arg1, f81_arg0, true)
		CoD.PCWidgetUtility.ScrollToElement(f80_arg0.ScrollView, f81_arg0, f80_arg1)
	end
	local f80_local3 = function(f82_arg0, f82_arg1)
		local f82_local0 = CoD.SafeGetModelValue(f82_arg1:getModel(), "isOpen")
		if f82_arg1.__frame.hasFrameFocus then
			if f82_arg0 == f80_local0 then
				return false
			elseif f82_arg0 == f80_local1 then
				if f82_local0 then
					f82_arg1.__list:getFirstSelectableItem(true)
				else
					f80_local2(f82_arg1.__button)
				end
				return true
			end
		elseif f82_arg1.__button:isInFocus() then
			if f82_arg0 == f80_local0 then
				if f82_local0 then
					f82_arg1.__list:getLastSelectableItem(true)
				else
					f80_local2(f82_arg1.__frame)
				end
				return true
			elseif f82_arg0 == f80_local1 then
				return false
			end
		elseif f82_arg1.__list.hasListFocus then
			if f82_arg0 == f80_local0 then
				if not f82_arg1.__list.navigateItemUp() then
					f82_arg1.gridInfoTable.parentGrid:setActiveItem(f82_arg1)
					f80_local2(f82_arg1.__frame)
				end
				return true
			elseif f82_arg0 == f80_local1 then
				if not f82_arg1.__list.navigateItemDown() then
					f82_arg1.gridInfoTable.parentGrid:setActiveItem(f82_arg1)
					f80_local2(f82_arg1.__button)
				end
				return true
			end
		end
	end
	local f80_local4 = function(f83_arg0)
		if not f80_arg0.__activeList then
			return false
		end
		local f83_local0, f83_local1 = false
		local f83_local2 = CoD.GetMouseFocus(f80_arg1)
		if f83_local2 ~= nil and f80_arg0.__activeList.activeWidget ~= f83_local2 and (not f80_arg0.__activeList.activeWidget or not f80_arg0.__activeList.activeWidget:isParentOf(f83_local2)) then
			if f80_arg0.__activeList.activeWidget then
				if f80_arg0.__activeList.activeWidget.__defaultFocus then
					f80_local2(f80_arg0.__activeList.activeWidget.__defaultFocus)
				else
					f80_local2(f80_arg0.__activeList.activeWidget)
				end
			end
			return true
		elseif f80_arg0.__activeList.activeWidget.isExpander then
			f83_local1 = f80_arg0.__activeList.activeWidget
			f83_local0 = f80_local3(f83_arg0, f80_arg0.__activeList.activeWidget)
		end
		if not f83_local0 then
			if f83_arg0 == f80_local0 then
				f83_local0 = f80_arg0.__activeList:navigateItemUp()
			elseif f83_arg0 == f80_local1 then
				f83_local0 = f80_arg0.__activeList:navigateItemDown()
			end
		end
		if not f83_local0 then
			local f83_local3 = f80_arg0.__activeList:getParent()
			if f83_local3.isExpander then
				f83_local3 = f80_arg0.__activeList:getParent()
				f83_local3.gridInfoTable.parentGrid:setActiveItem(f83_local3)
				if f83_arg0 == f80_local0 then
					f80_local2(f83_local3.__frame)
				elseif f83_arg0 == f80_local1 then
					f80_local2(f83_local3.__button)
				end
			else
				return f83_arg0 ~= f80_local0
			end
		elseif not f80_arg0.__activeList.activeWidget.isExpander then
			f80_local2(f80_arg0.__activeList.activeWidget)
		elseif not f83_local1 or f83_local1 ~= f80_arg0.__activeList.activeWidget then
			local f83_local3 = f80_arg0.__activeList.activeWidget
			if f83_arg0 == f80_local0 then
				f80_local2(f83_local3.__button)
			elseif f83_arg0 == f80_local1 then
				f80_local2(f83_local3.__frame)
			end
		end
		return true
	end
	CoD.Menu.AddButtonCallbackFunction(f80_arg2, f80_arg0, f80_arg1, Enum.LUIButton[@"lui_key_up"], "ui_navup", function(f84_arg0, f84_arg1, f84_arg2, f84_arg3)
		if not f80_arg0.m_disableNavigation and (not (not f80_arg0.dpadDisabled or not IsDpadButton(f84_arg3)) or f80_local4(f80_local0)) then
			return true
		else
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f80_arg2, f80_arg0, f80_arg1, Enum.LUIButton[@"lui_key_down"], "ui_navdown", function(f85_arg0, f85_arg1, f85_arg2, f85_arg3)
		if not f80_arg0.m_disableNavigation and (not (not f80_arg0.dpadDisabled or not IsDpadButton(f85_arg3)) or f80_local4(f80_local1)) then
			return true
		else
		end
	end)
	local f80_local5 = function(f86_arg0, f86_arg1)
		if f86_arg0.__navAction then
			CoD.PCWidgetUtility.BringIntoView(f86_arg0, f80_arg1)
			local f86_local0 = CoD.GetMouseFocus(f80_arg1)
			if f86_local0 ~= nil and not f86_arg0:isParentOf(f86_local0) then
				f80_local2(f86_arg0.__defaultFocus)
			end
			return f86_arg0.__navAction(f80_arg1, f86_arg1)
		else
			return false
		end
	end
	CoD.Menu.AddButtonCallbackFunction(f80_arg2, f80_arg0, f80_arg1, Enum.LUIButton[@"lui_key_left"], "ui_navleft", function(f87_arg0, f87_arg1, f87_arg2, f87_arg3)
		if f80_arg0.m_disableNavigation then
			return false
		elseif CoD.PCOptionsUtility.OptionListFocusModelBehavior then
			local f87_local0 = CoD.GetMouseFocus(f87_arg2)
			while f87_local0 and not f87_local0.__navAction do
				f87_local0 = f87_local0:getParent()
			end
			if f87_local0 then
				return f80_local5(f87_local0, "left")
			end
		elseif f80_arg0.__activeList and f80_arg0.__activeList.activeWidget then
			return f80_local5(f80_arg0.__activeList.activeWidget, "left")
		end
		return false
	end)
	CoD.Menu.AddButtonCallbackFunction(f80_arg2, f80_arg0, f80_arg1, Enum.LUIButton[@"lui_key_right"], "ui_navright", function(f88_arg0, f88_arg1, f88_arg2, f88_arg3)
		if f80_arg0.m_disableNavigation then
			return false
		elseif CoD.PCOptionsUtility.OptionListFocusModelBehavior then
			local f88_local0 = CoD.GetMouseFocus(f88_arg2)
			while f88_local0 and not f88_local0.__navAction do
				f88_local0 = f88_local0:getParent()
			end
			if f88_local0 then
				return f80_local5(f88_local0, "right")
			end
		elseif f80_arg0.__activeList and f80_arg0.__activeList.activeWidget then
			return f80_local5(f80_arg0.__activeList.activeWidget, "right")
		end
		return false
	end)
end
CoD.PCWidgetUtility.SetupScrollForButton = function(f89_arg0, f89_arg1, f89_arg2, f89_arg3, f89_arg4)
	f89_arg1:registerEventHandler("leftmousedown", function(element, event)
		if f89_arg0.scrollTimer then
			f89_arg0.scrollTimer:close()
			f89_arg0.scrollTimer = nil
		end
		f89_arg0.scrollTimer = LUI.UITimer.new(f89_arg3, {
			name = "scroll_tick",
			scrollUp = f89_arg2,
			first_tick = true,
			fastScrollDelay = f89_arg4,
		}, false)
		f89_arg0:addElement(f89_arg0.scrollTimer)
		CoD.PCWidgetUtility.ScrollVerticalByAmount(f89_arg0.ScrollView, f89_arg2 and -f89_arg0.arrowScrollUnit or f89_arg0.arrowScrollUnit)
		return true
	end)
	f89_arg1:registerEventHandler("leftmouseup", function(element, event)
		if f89_arg0.scrollTimer then
			f89_arg0.scrollTimer:close()
			f89_arg0.scrollTimer = nil
		end
		return true
	end)
	f89_arg1:appendEventHandler("lose_focus", function(f92_arg0, f92_arg1)
		if f89_arg0.scrollTimer then
			f89_arg0.scrollTimer:close()
			f89_arg0.scrollTimer = nil
		end
	end)
	f89_arg0:registerEventHandler("scroll_tick", function(element, event)
		CoD.PCWidgetUtility.ScrollVerticalByAmount(element.ScrollView, event.scrollUp and -element.arrowScrollUnit or element.arrowScrollUnit)
		if event.first_tick then
			event.first_tick = false
			event.timer.interval = event.fastScrollDelay
		end
	end)
end
CoD.PCWidgetUtility.SetupScrollbar = function(f94_arg0, f94_arg1, f94_arg2, f94_arg3, f94_arg4, f94_arg5)
	local f94_local0 = 500
	local f94_local1 = 50
	local f94_local2 = f94_arg0.VScrollbar.Scrollbar.Bar
	local f94_local3 = f94_arg0.VScrollbar.Scrollbar.Background
	local f94_local4 = f94_arg0.ScrollView
	if not f94_arg5 or not f94_arg5 then
		f94_arg5 = f94_arg0
	end
	if not f94_arg4 then
		f94_arg0.VScrollbar.ScrollDown:setHandleMouseButton(true)
		f94_arg0.VScrollbar.ScrollUp:setHandleMouseButton(true)
		CoD.PCWidgetUtility.SetupScrollForButton(f94_arg0, f94_arg0.VScrollbar.ScrollDown, false, f94_local0, f94_local1)
		CoD.PCWidgetUtility.SetupScrollForButton(f94_arg0, f94_arg0.VScrollbar.ScrollUp, true, f94_local0, f94_local1)
		f94_local2:setHandleMouse(true)
		f94_local2:registerEventHandler("leftmousedown", function(element, event)
			assert(not element.__lockedFocus)
			local f95_local0 = element:getMenu()
			f95_local0:CaptureMouseAndLockFocus(event.controller, element)
			element.__lockedFocus = true
			local f95_local1, f95_local2, f95_local3, f95_local4 = element:getRect()
			element._mouseContactPoint = {
				x = event.x - f95_local1,
				y = event.y - f95_local2,
			}
		end)
		f94_local2:registerEventHandler("leftmouseup", function(element, event)
			if element.__lockedFocus then
				local f96_local0 = element:getMenu()
				f96_local0:CaptureMouseAndLockFocus(event.controller, nil)
				element.__lockedFocus = false
				element._mouseContactPoint = nil
			end
		end)
		f94_local2:appendEventHandler("lose_focus", function(f97_arg0, f97_arg1)
			if f97_arg0.__lockedFocus then
				local f97_local0 = f97_arg0:getMenu()
				f97_local0:CaptureMouseAndLockFocus(f97_arg1.controller, nil)
				f97_arg0.__lockedFocus = false
				f97_arg0._mouseContactPoint = nil
			end
		end)
		f94_local2:registerEventHandler("mouse_capture_lost", function(element, event)
			if element.__lockedFocus then
				element.__lockedFocus = false
				element._mouseContactPoint = nil
			end
		end)
		f94_local2.__onScrollbarClose = function(f99_arg0)
			if f99_arg0.__lockedFocus then
				local f99_local0 = f99_arg0:getMenu()
				f99_local0:CaptureMouseAndLockFocus(f94_arg1, nil)
				f99_arg0.__lockedFocus = false
				f99_arg0._mouseContactPoint = nil
			end
		end
		LUI.OverrideFunction_CallOriginalSecond(f94_local2, "close", f94_local2.__onScrollbarClose)
		f94_local2:registerEventHandler("leftmousedrag", function(element, event)
			if element.__lockedFocus then
				local f100_local0, f100_local1, f100_local2, f100_local3 = f94_local3:getRect()
				local f100_local4 = LUI.clamp((event.y - element._mouseContactPoint.y - f100_local1) / (f100_local3 - f100_local1), 0, 1)
				if f94_arg3 then
					f100_local4 = 1 - f100_local4
				end
				CoD.PCWidgetUtility.ScrollVerticalTo(f94_local4, f100_local4 * f94_local4.viewHeight)
			end
		end)
		f94_local3:setHandleMouseButton(true)
		f94_local3:registerEventHandler("leftmousedown", function(element, event)
			local f101_local0, f101_local1, f101_local2, f101_local3 = f94_arg0.VScrollbar.sliderBorder:getRect()
			local f101_local4 = LUI.clamp((event.y - f101_local1) / (f101_local3 - f101_local1), 0, 1)
			local f101_local5 = 0.5 * (f94_local4.viewHeight - f94_local4.totalYDistance) / f94_local4.viewHeight
			if f94_arg3 then
				f101_local4 = 1 - f101_local4
			end
			CoD.PCWidgetUtility.ScrollVerticalTo(f94_local4, (f101_local4 - f101_local5) * f94_local4.viewHeight)
			CoD.FreeCursorUtility.RetriggerCursorPosition(f94_arg0, f94_arg1)
		end)
	else
		f94_local2.m_focusable = false
		f94_local2:registerEventHandler("update_state", function(element)
			element.m_focusable = false
		end)
		f94_local3.m_focusable = false
		f94_local3:registerEventHandler("update_state", function(element)
			element.m_focusable = false
		end)
	end
	f94_arg2:AddButtonCallbackFunction(f94_arg5, f94_arg1, Enum.LUIButton[@"lui_key_none"], "MWHEELDOWN", function(f104_arg0, f104_arg1, f104_arg2, f104_arg3)
		CoD.PCWidgetUtility.ScrollVerticalByAmount(f94_local4, f94_arg0.wheelScrollUnit)
		return true
	end, function(f105_arg0, f105_arg1, f105_arg2)
		return false
	end, false)
	f94_arg2:AddButtonCallbackFunction(f94_arg5, f94_arg1, Enum.LUIButton[@"lui_key_none"], "MWHEELUP", function(f106_arg0, f106_arg1, f106_arg2, f106_arg3)
		CoD.PCWidgetUtility.ScrollVerticalByAmount(f94_local4, -f94_arg0.wheelScrollUnit)
		return true
	end, function(f107_arg0, f107_arg1, f107_arg2)
		return false
	end, false)
end
CoD.PCWidgetUtility.OnSettingsMenuOpen = function(f108_arg0, f108_arg1)
	if not f108_arg0.__openAlreadyHandled then
		f108_arg0.__openAlreadyHandled = true
		SetControllerModelValue(f108_arg1, "SettingsMenuOpen", true)
		CoD.PCOptionsUtility.SyncHardwareProfileWithDVar(f108_arg0, f108_arg1)
		CoD.PCOptionsUtility.SyncAllOptionModels(f108_arg1)
		CoD.PCUtility.SetActiveIndexInListDependingOnProperty(f108_arg0, f108_arg1, f108_arg0, f108_arg0.OptionsTabs.OptionsTabList, "_tabIdToOpen")
		CoD.PCOptionsUtility.StartSettingsSession(f108_arg1)
	end
end
CoD.PCWidgetUtility.OnSettingsMenuClose = function(f109_arg0, f109_arg1)
	CoD.PCUtility.HideKeybindMessage(f109_arg0, f109_arg1)
	CoD.PCOptionsUtility.RevertPCHardwareChanges(f109_arg0, f109_arg1)
	CoD.PCOptionsUtility.EndSettingsSession(f109_arg1)
	f109_arg0:CaptureMouseAndLockFocus(f109_arg0, nil)
	SetControllerModelValue(f109_arg1, "SettingsMenuOpen", false)
	f109_arg0.__openAlreadyHandled = false
end
CoD.PCWidgetUtility.CachedSettingMenu = {}
CoD.PCWidgetUtility.SetupSettingsMenuCache = function(f110_arg0, f110_arg1)
	if not CoD.PCWidgetUtility.OptionsListCacheBehavior then
		return
	elseif CoD.PCWidgetUtility.CachedSettingMenu[f110_arg0] then
		assert(CoD.PCWidgetUtility.CachedSettingMenu[f110_arg0] == f110_arg1)
	else
		CoD.PCWidgetUtility.CachedSettingMenu[f110_arg0] = f110_arg1
		LUI.createMenu.PC_StartMenu_Options_New = function(f111_arg0, f111_arg1)
			f110_arg1.m_disableAllButtonActions = nil
			f110_arg1.m_inputDisabled = nil
			f110_arg1.ignoreCursor = nil
			f110_arg1:playSound("menu_open", f111_arg0)
			return CoD.PCWidgetUtility.CachedSettingMenu[f111_arg0]
		end
		f110_arg1.close = function(f112_arg0)
			local f112_local0 = f112_arg0:getOwner()
			if not f112_local0 then
				f112_local0 = Engine.GetPrimaryController()
			end
			CoD.Menu.RemoveFromCurrMenuNameList(f112_arg0.menuName)
			if f112_arg0.occludedBy ~= nil and f112_arg0.occludedBy.occludedMenu == f112_arg0 then
				f112_arg0.occludedBy.occludedMenu = f112_arg0.occludedMenu
			end
			if f112_arg0.occludedMenu ~= nil and f112_arg0.occludedMenu.occludedBy == f112_arg0 then
				if f112_arg0.occludedBy ~= nil then
					f112_arg0.occludedMenu.occludedBy = f112_arg0.occludedBy
				else
					if IsGameTypeDOA() and Engine.issplitscreen() then
						f112_arg0.occludedMenu:setOwner(f112_arg0:getOwner())
					end
					f112_arg0.occludedMenu:processEvent({
						name = "occlusion_change",
						occluded = false,
						occludedBy = f112_arg0,
					})
				end
			end
			f112_arg0.occludedBy = nil
			if UnregisterOpenedMenu then
				UnregisterOpenedMenu(f112_arg0, f112_arg0.menuName)
			end
			if f112_arg0:getSoundSet() then
				f112_arg0:playSound("menu_close")
			end
			if CoD.GetMouseFocus(f112_local0) and f112_arg0:isParentOf(CoD.GetMouseFocus(f112_local0)) then
				f112_arg0:ChangeFocusedElement(f112_local0, nil)
			end
			if DataSources.FreeCursor.getButtonPromptsModel(f112_local0) == f112_arg0.buttonModel then
				DataSources.FreeCursor.registerButtonPrompts(f112_local0, nil)
			end
			CoD.MetricsUtility.CloseMenu(f112_arg0)
			f112_arg0.m_disableAllButtonActions = true
			f112_arg0.ignoreCursor = true
			local f112_local1 = f112_arg0:getParent()
			if f112_local1 ~= nil then
				f112_local1:removeElement(f112_arg0)
			end
		end
	end
end
CoD.PCWidgetUtility.CachedDataSourceGridElements = {}
CoD.PCWidgetUtility.PrepareOptionScreenListCache = function(f113_arg0, f113_arg1, f113_arg2)
	if not CoD.PCWidgetUtility.OptionsListCacheBehavior then
		return
	else
		local f113_local0 = f113_arg0
		local f113_local1 = function(f114_arg0)
			if f114_arg0.dataSourceName and not CoD.PCWidgetUtility.CachedDataSourceGridElements[f114_arg0.dataSourceName] then
				CoD.PCWidgetUtility.CachedDataSourceGridElements[f114_arg0.dataSourceName] = {
					itemStencil = f114_arg0.itemStencil,
					layoutItems = f114_arg0.layoutItems,
					rowColumnIndexMap = f114_arg0.rowColumnIndexMap,
					itemCount = f114_arg0.itemCount,
					requestedColumnCount = f114_arg0.requestedColumnCount,
					requestedRowCount = f114_arg0.requestedRowCount,
					customDataSourceHelper = f114_arg0.customDataSourceHelper,
					dataSourceController = f114_arg0.dataSourceController,
					listModelName = f114_arg0[f114_arg0.customDataSourceHelper],
				}
			end
		end
		f113_local0.ScrollView.View.setDataSource = function(f115_arg0, f115_arg1)
			if not f115_arg0.__cachedDataTemp then
				f115_arg0.__cachedDataTemp = {}
			end
			if f115_arg0.dataSourceName ~= f115_arg1 then
				f113_local1(f115_arg0)
				local f115_local0 = CoD.PCWidgetUtility.CachedDataSourceGridElements[f115_arg1]
				if f115_local0 then
					f115_arg0:setActiveItem(nil, 0)
					if CoD.GetMouseFocus(f113_arg1) and f115_arg0:isParentOf(CoD.GetMouseFocus(f113_arg1)) then
						f113_arg2:ChangeFocusedElement(f113_arg1, nil)
					end
					local f115_local1 = Engine[0x4B06D9D6B673AA](f113_arg1)
					if f115_local1 and f115_arg0:isParentOf(f115_local1) then
						Engine[@"hash_718F7786899BA625"](f113_arg1)
					end
					f115_arg0:removeDataSourceLink(true)
					f115_arg0:removeElement(f115_arg0.itemStencil)
					for f115_local5, f115_local6 in pairs(f115_local0) do
						if f115_local5 ~= "listModelName" then
							f115_arg0[f115_local5] = f115_local6
						end
					end
					f115_arg0[f115_arg0.customDataSourceHelper] = f115_local0.listModelName
					f115_arg0.dataSourceName = f115_arg1
					f115_arg0:addElement(f115_local0.itemStencil)
					f115_arg0:addDataSourceLink()
					f115_local2 = f115_arg0.itemStencil:getFirstChild()
					while f115_local2 do
						f115_local3 = f115_local2:getModel()
						f115_local3 = f115_local3:create("skipGridLayoutModelUpdate")
						f115_local3:set(true)
						f115_local2.gridInfoTable.parentGrid = f115_arg0
						f115_local2 = f115_local2:getNextSibling()
					end
					f115_arg0.prepared = true
					f115_arg0:processEvent({
						name = "update_state",
						controller = f113_arg1,
						menu = f113_arg2,
						initialSetup = not f115_arg0.__cachedDataTemp[f115_arg1],
						forceDispatch = true,
					})
					f115_arg0.__cachedDataTemp[f115_arg1] = true
					f115_arg0:setLayoutCached(false)
					f113_local0.ScrollView:setLayoutCached(false)
				else
					if f115_arg0.dataSourceName then
						f115_arg0:setActiveItem(nil, 0)
						if CoD.GetMouseFocus(f113_arg1) and f115_arg0:isParentOf(CoD.GetMouseFocus(f113_arg1)) then
							f113_arg2:ChangeFocusedElement(f113_arg1, nil)
						end
						local f115_local1 = Engine[0x4B06D9D6B673AA](f113_arg1)
						if f115_local1 and f115_arg0:isParentOf(f115_local1) then
							Engine[@"hash_718F7786899BA625"](f113_arg1)
						end
						f115_arg0:removeDataSourceLink(true)
						f115_arg0:removeElement(f115_arg0.itemStencil)
						f115_arg0.itemStencil = LUI.UIElement.new(0.5, 0.5, 0, 0, 0.5, 0.5, 0, 0)
						f115_arg0.itemStencil.anyChildUsesUpdateState = true
						f115_arg0.itemStencil.id = "itemStencil"
						f115_arg0.itemStencil.__passButtonPress = true
						f115_arg0.itemStencil:setForceMouseEventDispatch(true)
						f115_arg0.itemStencil:setUseStencil(f115_arg0.usingStencil)
						f115_arg0:addElement(f115_arg0.itemStencil)
						f115_arg0.layoutItems = {}
						f115_arg0:resetCurrentRowAndColumn()
						f115_arg0.prepared = false
					end
					LUI.GridLayout.setDataSource(f115_arg0, f115_arg1)
					f115_arg0.__cachedDataTemp[f115_arg1] = true
				end
			end
			local f115_local0 = f115_arg0:getFirstSelectableItem(true)
			if f115_local0 and IsUsingKeyboardNavigation(f113_arg1) then
				f113_arg2:ChangeFocusedElement(f113_arg1, CoD.BaseUtility.FindSingleFocusableDescendant(f115_local0, true))
			else
				CoD.PCOptionsUtility.SetCurrentCategoryModel(f113_arg1, 1)
			end
			CoD.PCWidgetUtility.ScrollVerticalTo(f113_local0.ScrollView, 0)
			CoD.FreeCursorUtility.RetriggerCursorPosition(f115_arg0:getMenu(), f113_arg1)
		end
		f113_local0.ScrollView.View.close = function(f116_arg0)
			f113_local1(f116_arg0)
			f116_arg0.__closing = true
			f116_arg0:unsubscribeFromAllModels()
			f116_arg0.layoutItems = {}
			f116_arg0:resetCurrentRowAndColumn()
			f116_arg0:setActiveItem(nil, 0)
			f116_arg0:removeElement(f116_arg0.itemStencil)
			f116_arg0.itemStencil = nil
			f116_arg0:removeDataSourceLink()
			f116_arg0.menu:removeMenuOpenedCallback(f116_arg0._on_menuOpened)
			LUI.GridLayout.super.close(f116_arg0)
		end
	end
end
CoD.PCWidgetUtility.PrepareVScrollWidget = function(f117_arg0, f117_arg1, f117_arg2)
	local f117_local0 = function()
		assert(f117_arg0.ScrollView.View.itemStencil)
		f117_arg0._categoryCache = {}
		local f118_local0 = f117_arg0.ScrollView.View.itemStencil:getFirstChild()
		while f118_local0 do
			local f118_local1 = f118_local0:getModel()
			if f118_local1 and f118_local1.categoryId then
				local f118_local2, f118_local3 = CoD.PCWidgetUtility.GetWidgetXYOffset(f117_arg0.ScrollView, f118_local0)
				f117_arg0._categoryCache[f118_local1.categoryId:get()] = {
					xOffset = f118_local2,
					yOffset = f118_local3,
				}
				if CoD.PCWidgetUtility.CategoryScrollAndFocus then
					local f118_local4 = f118_local0.gridInfoTable.gridRowIndex
					local f118_local5 = f118_local0.gridInfoTable.gridColIndex
					local f118_local6 = f117_arg0._categoryCache
					local f118_local7 = f118_local1.categoryId
					f118_local6[f118_local1.categoryId:get()].focusTarget = f117_arg0.ScrollView.View:getItemAtPosition(f118_local4 + 1, f118_local5, true)
				end
			end
			f118_local0 = f118_local0:getNextSibling()
		end
	end
	local f117_local1 = function(f119_arg0)
		if not f117_arg0.ScrollView.View.itemStencil then
			return
		elseif not f117_arg0._categoryCache then
			f117_local0()
		end
		local f119_local0, f119_local1 = CoD.PCWidgetUtility.GetWidgetXYOffset(f117_arg0.ScrollView, f119_arg0)
		local f119_local2 = 1
		while f119_local2 <= #f117_arg0._categoryCache do
			local f119_local3 = f117_arg0._categoryCache[f119_local2]
			local f119_local4 = f117_arg0._categoryCache[f119_local2 + 1]
			if f119_local3.yOffset <= f119_local1 and (f119_local4 == nil or f119_local1 < f119_local4.yOffset) then
				local f119_local5 = CoD.PCOptionsUtility.GetCurrentCategoryModel(f117_arg1)
				if f119_local5:get() ~= f119_local2 then
					f117_arg0._categoryUpdatedFromSelf = true
					CoD.PCOptionsUtility.SetCurrentCategoryModel(f117_arg1, f119_local2)
					break
				end
			end
			f119_local2 = f119_local2 + 1
		end
	end
	local f117_local2 = function(f120_arg0, f120_arg1)
		local f120_local0 = function(f121_arg0)
			local f121_local0 = f121_arg0:getParent()
			while f121_local0 ~= nil and f121_local0 ~= f120_arg0 do
				f121_local0 = f121_local0:getParent()
			end
			return f121_local0 == f120_arg0
		end
		if not f120_local0(f120_arg1) then
			return false
		else
			f117_local1(f120_arg1)
			return true
		end
	end
	CoD.PCOptionsUtility.SetCurrentCategoryModel(f117_arg1, 1)
	f117_arg0.ScrollView.View:subscribeToModel(CoD.PCOptionsUtility.GetCurrentCategoryModel(f117_arg1), function(model)
		if not f117_arg0.ScrollView.View.itemStencil or f117_arg0.scrollTimer then
			return
		elseif f117_arg0._categoryUpdatedFromSelf then
			f117_arg0._categoryUpdatedFromSelf = false
			return
		else
			f117_arg0.scrollTimer = LUI.UITimer.new(0.02, {
				name = "scroll_to_category",
				category = model:get(),
			}, true)
			f117_arg0:addElement(f117_arg0.scrollTimer)
		end
	end)
	f117_arg0:registerEventHandler("scroll_to_category", function(element, event)
		if not element._categoryCache or not element._categoryCache[event.category] then
			f117_local0()
		end
		if element._categoryCache[event.category] then
			if CoD.PCWidgetUtility.CategoryScrollAndFocus then
				local f123_local0 = element._categoryCache[event.category].focusTarget
				if f123_local0 then
					element.ScrollView.View:setActiveItem(f123_local0)
				end
			end
			CoD.PCWidgetUtility.ScrollVerticalTo(element.ScrollView, element._categoryCache[event.category].yOffset)
		end
		element.scrollTimer = nil
	end)
	f117_arg0.ScrollView:registerEventHandler("record_curr_focused_elem_id", function(element, event)
		local f124_local0 = event.leaf
		if element.RecordCurrFocusedElemID then
			element:RecordCurrFocusedElemID(event)
		elseif element.super.RecordCurrFocusedElemID then
			element.super:RecordCurrFocusedElemID(event)
		end
		f117_local2(element:getParent(), f124_local0)
		if CoD.PCOptionsUtility.OptionListFocusModelBehavior then
			local f124_local1 = f124_local0
			while f124_local1 and not f124_local1.gridInfoTable do
				f124_local1 = f124_local1:getParent()
			end
			if element.View:isParentOf(f124_local1) then
				element.View:setModel(f124_local1:getModel(), f117_arg1)
			end
		end
		return false
	end)
	LUI.OverrideFunction_CallOriginalFirst(f117_arg0.ScrollView, "childFocusLost", function(element)
		if CoD.PCOptionsUtility.OptionListFocusModelBehavior and f117_arg0.__activeList and f117_arg0.__activeList.activeWidget then
			element.View:setModel(f117_arg0.__activeList.activeWidget:getModel(), f117_arg1)
		end
	end)
	f117_arg0.ScrollView:appendEventHandler("size_changed", function(f126_arg0, f126_arg1)
		f117_local0()
		if CoD.PCWidgetUtility.CategoryAlwaysOnTop then
			local f126_local0 = f117_arg0._categoryCache[#f117_arg0._categoryCache]
			local f126_local1, f126_local2 = f117_arg0.ScrollView:_computeDefaultTotalScrollDistances()
			f117_arg0.ScrollView:_overrideTotalDistances(math.max(math.max(f126_local0.yOffset, f126_local2), 0), math.max(math.max(f126_local0.xOffset, f126_local1), 0))
		end
		CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget(f117_arg0, f117_arg1, f117_arg2)
		return true
	end)
	f117_arg0:registerEventHandler("view_scrolled", function(element, event)
		CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget(element, f117_arg1, f117_arg2)
		return true
	end)
	CoD.PCWidgetUtility.SetupScrollbar(f117_arg0, f117_arg1, f117_arg2, false, false)
	f117_arg2:AddButtonCallbackFunction(f117_arg0.ScrollView, f117_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f128_arg0, f128_arg1, f128_arg2, f128_arg3)
		if CoD.GetMouseFocus(f128_arg2) then
			local f128_local0 = CoD.GetMouseFocus(f128_arg2)
			while f128_local0 and not f128_local0.gridInfoTable do
				f128_local0 = f128_local0:getParent()
			end
			if f128_local0 then
				SetCurrentElementAsActive(f117_arg0, f128_local0, f128_arg2)
			end
			return true
		else
			return false
		end
	end)
	local f117_local3 = f117_arg0.VScrollbar.Scrollbar.Bar
	local f117_local4 = f117_arg0.VScrollbar.Scrollbar.Background
	f117_arg0:registerEventHandler("list_active_changed", function(element, event)
		local f129_local0 = event.list
		if not f129_local0.activeWidget then
			return
		end
		local f129_local1 = f117_arg0.__activeList
		f117_arg0.__activeList = f129_local0
		if f129_local1 and f129_local1 ~= f117_arg0.__activeList then
			f129_local1:setActiveItem(nil)
		end
		if not CoD.PCOptionsUtility.OptionListFocusModelBehavior then
			f117_arg0.ScrollView.View:setModel(f117_arg0.__activeList.activeWidget:getModel(), f117_arg1)
		end
	end)
	CoD.PCWidgetUtility.PrepareVScrollWidgetNavigation(f117_arg0, f117_arg1, f117_arg2)
	f117_arg0.ScrollView.View.blockBottomEdge = true
	if not f117_arg0.wheelScrollUnit then
		f117_arg0.wheelScrollUnit = 20
	end
	if not f117_arg0.arrowScrollUnit then
		f117_arg0.arrowScrollUnit = 20
	end
end
CoD.PCWidgetUtility.ScrollUpDown = function(f130_arg0, f130_arg1, f130_arg2, f130_arg3)
	if CoD.GetMouseFocus(f130_arg1) and f130_arg0:isParentOf(CoD.GetMouseFocus(f130_arg1)) then
		local f130_local0 = Engine.GetModelValue(f130_arg3)
		local f130_local1 = CoD.GetScriptNotifyData(f130_arg3)
		f130_local1 = f130_local1[1]
		local f130_local2 = CoD.GetScriptNotifyData(f130_arg3)
		f130_local2 = f130_local2[2]
		local f130_local3 = 25
		if f130_arg0.scrollTimer then
			f130_arg0.scrollTimer:close()
			f130_arg0.scrollTimer = nil
		end
		if f130_local1 then
			f130_arg0.scrollTimer = LUI.UITimer.new(f130_local3, {
				name = "scroll_tick",
				scrollUp = f130_local2,
				first_tick = true,
				fastScrollDelay = f130_local3,
			}, false)
			f130_arg0:addElement(f130_arg0.scrollTimer)
			local f130_local4 = CoD.PCWidgetUtility.ScrollVerticalByAmount
			local f130_local5 = f130_arg0.ScrollView
			local f130_local6
			if f130_local2 then
				f130_local6 = -f130_arg0.wheelScrollUnit
				if not f130_local6 then
				else
					f130_local4(f130_local5, f130_local6)
				end
			end
			f130_local6 = f130_arg0.wheelScrollUnit
		end
	end
end
CoD.PCWidgetUtility.PrepareSimpleVScrollWidget = function(f131_arg0, f131_arg1, f131_arg2)
	f131_arg0.ScrollView:appendEventHandler("size_changed", function(f132_arg0, f132_arg1)
		CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget(f131_arg0, f131_arg1, f131_arg2)
		return true
	end)
	f131_arg0:registerEventHandler("view_scrolled", function(element, event)
		CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget(element, f131_arg1, f131_arg2)
		return true
	end)
	CoD.PCWidgetUtility.SetupScrollbar(f131_arg0, f131_arg1, f131_arg2, false, false)
	f131_arg0.ScrollView.View.blockBottomEdge = true
	if not f131_arg0.wheelScrollUnit then
		f131_arg0.wheelScrollUnit = 20
	end
	if not f131_arg0.arrowScrollUnit then
		f131_arg0.arrowScrollUnit = 20
	end
end
CoD.PCWidgetUtility.SelectFirstActiveItemInPCScrollView = function(f134_arg0, f134_arg1, f134_arg2, f134_arg3)
	f134_arg0:appendEventHandler("grid_updated", function(f135_arg0, f135_arg1)
		if not f134_arg2.gridUpdatedFirstTime and f135_arg1.grid == f134_arg2.ScrollView.View and f134_arg2.ScrollView.View:getFirstSelectableItem(true) then
			f134_arg2.gridUpdatedFirstTime = true
			LUI.GridLayout.giveFocusToActiveWidget(f134_arg2.ScrollView.View)
			CopyScrollViewActiveModelToElementAndCacheSocialData(f134_arg0, f134_arg1, f134_arg2, f134_arg3)
		end
	end)
end
CoD.PCWidgetUtility.SetFocusToFirstSelectableItemInPCScrollView = function(f136_arg0)
	f136_arg0.ScrollView.View:getFirstSelectableItem(true)
	LUI.GridLayout.giveFocusToActiveWidget(f136_arg0.ScrollView.View)
end
CoD.PCWidgetUtility.PrepareCategoryButton = function(f137_arg0, f137_arg1, f137_arg2, f137_arg3)
	if not f137_arg3 then
		return
	end
	assert(f137_arg3.categoryId)
	local f137_local0 = f137_arg3.categoryId:get()
	f137_arg2:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f138_arg0, f138_arg1, f138_arg2, f138_arg3)
		CoD.PCOptionsUtility.SetCurrentCategoryModel(f138_arg2, f137_local0)
		f137_arg0:playSound("list_right", f138_arg2)
		return true
	end, function(f139_arg0, f139_arg1, f139_arg2)
		return false
	end, false)
	if CoD.PCWidgetUtility.CategoryScrollAndFocus then
		DisableKeyboardNavigationByElement(f137_arg0)
	end
	if f137_local0 >= 0 and f137_local0 <= 9 then
		f137_arg2:AddButtonCallbackFunction(f137_arg2, f137_arg1, Enum.LUIButton[@"lui_key_none"], tostring(f137_local0), function(f140_arg0, f140_arg1, f140_arg2, f140_arg3)
			PlaySoundSetSound(f137_arg0, "list_right")
			CoD.PCOptionsUtility.SetCurrentCategoryModel(f140_arg2, f137_local0)
			return true
		end, function(f141_arg0, f141_arg1, f141_arg2)
			return false
		end, false)
	end
end
CoD.PCWidgetUtility.UpdateOptionList = function(f142_arg0, f142_arg1, f142_arg2)
	if not f142_arg0._optionProperties then
		return
	elseif not f142_arg0._optionProperties._getOptions then
		return
	elseif f142_arg2 or not f142_arg0._optionProperties._options then
		f142_arg0._optionProperties._options = f142_arg0._optionProperties._getOptions(f142_arg1)
		local f142_local0 = f142_arg0:getModel()
		if f142_arg0._optionProperties._options and f142_local0.optionCount then
			f142_local0.optionCount:set(#f142_arg0._optionProperties._options)
		end
		if f142_local0 and f142_local0.currentValue then
			if f142_local0.profileVar and f142_arg0._optionProperties and f142_arg0._optionProperties._options and #f142_arg0._optionProperties._options > 0 and CoD.PCWidgetUtility.OptionValueToOptionIndex(f142_arg0, f142_local0.currentValue:get()) == -1 then
				f142_arg0._optionProperties._setCurrentValue(f142_local0.profileVar:get(), f142_arg1, f142_arg0._optionProperties._options[1].value)
			end
			Engine.ForceNotifyModelSubscriptions(f142_local0.currentValue)
		end
	end
end
CoD.PCWidgetUtility.ShouldHideLeftArrow = function(f143_arg0, f143_arg1, f143_arg2)
	if f143_arg0._getCurrentSelection then
		return f143_arg0._getCurrentSelection() == 1
	else
		return false
	end
end
CoD.PCWidgetUtility.ShouldHideRightArrow = function(f144_arg0, f144_arg1, f144_arg2)
	if f144_arg0._getCurrentSelection and f144_arg0._optionProperties and f144_arg0._optionProperties._options then
		return f144_arg0._getCurrentSelection() == #f144_arg0._optionProperties._options
	else
		return false
	end
end
CoD.PCWidgetUtility.ShouldHideArrows = function(f145_arg0, f145_arg1, f145_arg2)
	local f145_local0
	if f145_arg0._optionProperties ~= nil and f145_arg0._optionProperties._options ~= nil and #f145_arg0._optionProperties._options > 1 then
		f145_local0 = false
	else
		f145_local0 = true
	end
	return f145_local0
end
CoD.PCWidgetUtility.GetOptionIndexFromValue = function(f146_arg0, f146_arg1)
	if f146_arg0 and 0 < #f146_arg0 then
		for f146_local3, f146_local4 in ipairs(f146_arg0) do
			if f146_local4.value == f146_arg1 then
				return f146_local3
			end
		end
	end
	return -1
end
CoD.PCWidgetUtility.GetOptionNameFromValue = function(f147_arg0, f147_arg1)
	if f147_arg0 and 0 < #f147_arg0 then
		for f147_local3, f147_local4 in ipairs(f147_arg0) do
			if f147_local4.value == f147_arg1 then
				return f147_local4.name
			end
		end
	end
	return ""
end
CoD.PCWidgetUtility.OptionValueToOptionName = function(f148_arg0, f148_arg1)
	local f148_local0 = f148_arg0
	if f148_local0._optionProperties and f148_local0._optionProperties._options then
		return CoD.PCWidgetUtility.GetOptionNameFromValue(f148_local0._optionProperties._options, f148_arg1)
	else
		return ""
	end
end
CoD.PCWidgetUtility.OptionValueToOptionIndex = function(f149_arg0, f149_arg1)
	if f149_arg0._optionProperties and f149_arg0._optionProperties._options then
		return CoD.PCWidgetUtility.GetOptionIndexFromValue(f149_arg0._optionProperties._options, f149_arg1)
	else
		return 0
	end
end
CoD.PCWidgetUtility.GetSettingSliderPagination = function(f150_arg0, f150_arg1, f150_arg2, f150_arg3, f150_arg4, f150_arg5)
	local f150_local0 = f150_arg1.optionCount
	if f150_local0 then
		f150_local0 = f150_arg1.optionCount:get()
	end
	if f150_local0 then
		local f150_local1 = f150_arg1.currentValue
		if f150_local1 then
			f150_local1 = f150_arg1.currentValue:get()
		end
		local f150_local2 = f150_local1 and CoD.PCWidgetUtility.OptionValueToOptionIndex(f150_arg0:getParent(), f150_local1)
		local f150_local3 = 1 / f150_local0
		local f150_local4 = (f150_local2 - 1) * f150_local3
		return f150_local4, f150_local4 + f150_local3, 0, 1
	else
		return f150_arg2, f150_arg3, f150_arg4, f150_arg5
	end
end
CoD.PCWidgetUtility.PrepareCyclingList = function(f151_arg0, f151_arg1, f151_arg2, f151_arg3, f151_arg4)
	local f151_local0 = assert
	local f151_local1 = f151_arg4
	local f151_local2 = f151_arg4.left
	if f151_local2 then
		f151_local2 = f151_local1 and f151_arg4.right
	end
	f151_local0(f151_local2)
	if not f151_arg3 then
		return
	else
		f151_arg0._getCurrentSelection = function()
			return CoD.PCWidgetUtility.GetOptionIndexFromValue(f151_arg0._optionProperties._options, f151_arg3.currentValue:get())
		end
		f151_local0 = function(f153_arg0)
			if f151_arg0._unavailable then
				return
			elseif f151_arg0._optionProperties._options and #f151_arg0._optionProperties._options > 0 then
				CoD.PCWidgetUtility.BringIntoView(f151_arg0, f151_arg1)
				if #f151_arg0._optionProperties._options < f153_arg0 then
					f153_arg0 = 1
				elseif f153_arg0 < 1 then
					f153_arg0 = #f151_arg0._optionProperties._options
				end
				CoD.PCWidgetUtility.ChangeWidgetValue(f151_arg0, f151_arg3.profileVar:get(), f151_arg1, f151_arg3, f151_arg0._optionProperties._options[f153_arg0].value, true)
			end
		end
		CoD.PCWidgetUtility.UpdateOptionList(f151_arg0, f151_arg1, true)
		f151_arg2:AddButtonCallbackFunction(f151_arg4.center, f151_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f154_arg0, f154_arg1, f154_arg2)
			return false
		end, false)
		f151_arg2:AddButtonCallbackFunction(f151_arg4.center, f151_arg1, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f155_arg0, f155_arg1, f155_arg2)
			f151_local0(f151_arg0._getCurrentSelection() + 1)
			return true
		end, false)
		f151_arg2:AddButtonCallbackFunction(f151_arg4.left, f151_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f156_arg0, f156_arg1, f156_arg2)
			local f156_local0 = f151_arg0._getCurrentSelection()
			if f156_local0 > 1 then
				f151_local0(f156_local0 - 1)
			end
			return true
		end, false)
		f151_arg2:AddButtonCallbackFunction(f151_arg4.right, f151_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f157_arg0, f157_arg1, f157_arg2)
			local f157_local0 = f151_arg0._getCurrentSelection()
			if f157_local0 < #f151_arg0._optionProperties._options then
				f151_local0(f157_local0 + 1)
			end
			return true
		end, false)
		f151_arg0.__navAction = function(f158_arg0, f158_arg1)
			local f158_local0 = f151_arg0._getCurrentSelection()
			local f158_local1
			if f158_arg1 == "left" then
				f158_local1 = -1
				if not f158_local1 then
				else
					f151_local0(f158_local0 + f158_local1)
					return true
				end
			end
			f158_local1 = 1
		end
		f151_arg2:AddButtonCallbackFunction(f151_arg0, f151_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f159_arg0, f159_arg1, f159_arg2)
			return false
		end, false)
		f151_arg2:AddButtonCallbackFunction(f151_arg0, f151_arg1, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f160_arg0, f160_arg1, f160_arg2)
			f151_local0(f151_arg0._getCurrentSelection() + 1)
			return true
		end, false)
	end
end
CoD.PCWidgetUtility.PrepareDropdownItem = function(f161_arg0, f161_arg1, f161_arg2, f161_arg3)
	f161_arg2:AddButtonCallbackFunction(f161_arg0, f161_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f162_arg0, f162_arg1, f162_arg2)
		local f162_local0 = f161_arg0
		local f162_local1 = f162_local0
		f162_local0 = f162_local0.dispatchEventToParent
		local f162_local2 = {
			name = "onDropdownItemChanged",
			controller = f162_arg2,
		}
		local f162_local3 = f161_arg0:getModel()
		f162_local2.value = f162_local3.value:get()
		f162_local0(f162_local1, f162_local2)
		return true
	end)
end
CoD.PCWidgetUtility.PrepareHeistBuyMenuButtons = function(f163_arg0, f163_arg1, f163_arg2)
	assert(f163_arg0.BountyHunterBuyInternal and f163_arg0.BountyHunterOpenPrompt)
	f163_arg2:AddButtonCallbackFunction(f163_arg0, f163_arg1, Enum.LUIButton[@"lui_key_none"], "+activate", function(f164_arg0, f164_arg1, f164_arg2)
		if not IsVisibilityBitSet(f164_arg2, Enum.UIVisibilityBit[@"bit_ui_active"]) and IsMouseOrKeyboard(f164_arg2) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.ToggleBuyMenuVisible(f163_arg0, f164_arg2, f163_arg0.BountyHunterBuyInternal, f163_arg0.BountyHunterOpenPrompt, f163_arg0.PCBackButton)
			return true
		else
		end
	end)
	f163_arg2:AddButtonCallbackFunction(f163_arg0, f163_arg1, Enum.LUIButton[@"lui_key_none"], "ESCAPE", function(f165_arg0, f165_arg1, f165_arg2)
		if not IsVisibilityBitSet(f165_arg2, Enum.UIVisibilityBit[@"bit_ui_active"]) and CoD.BountyHunterUtility.IsBuyMenuVisible(f163_arg0.BountyHunterBuyInternal) and IsMouseOrKeyboard(f165_arg2) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.ToggleBuyMenuVisible(f163_arg0, f165_arg2, f163_arg0.BountyHunterBuyInternal, f163_arg0.BountyHunterOpenPrompt, f163_arg0.PCBackButton)
			return true
		else
		end
	end)
end
CoD.PCWidgetUtility.OpenedDropdownIds = {}
CoD.PCWidgetUtility.CloseAllOpenedDropdown = function(f166_arg0)
	for f166_local3, f166_local4 in ipairs(CoD.PCWidgetUtility.OpenedDropdownIds) do
		local f166_local5 = f166_arg0[f166_local4]
		assert(f166_local5)
		local f166_local6 = f166_local5:getModel()
		if f166_local6 and f166_local6.isOpen then
			f166_local6.isOpen:set(false)
		else
			f166_local5:close()
		end
	end
end
CoD.PCWidgetUtility.PrepareContextList = function(f167_arg0, f167_arg1, f167_arg2)
	f167_arg0.updatePosAndSize = function()
		local f168_local0, f168_local1, f168_local2, f168_local3 = f167_arg0._anchor:getScreenRect(f167_arg1)
		local f168_local4 = f168_local1
		local f168_local5 = f168_local3
		local f168_local6 = f167_arg0.ScrollView.View:getHeight()
		local f168_local7 = 1
		f168_local1 = f168_local3
		f168_local3 = f168_local1 + f168_local6 + f168_local7
		local f168_local8 = f167_arg0._anchor:getParent()
		while f168_local8 do
			if f168_local8:getUseStencil() or f168_local8 == f167_arg2 then
				local f168_local9, f168_local10, f168_local11, f168_local12 = f168_local8:getScreenRect(f167_arg1)
				if f168_local12 < f168_local3 then
					break
				end
			end
			f168_local8 = f168_local8:getParent()
		end
		if f168_local8 then
			f167_arg0:setTopBottom(true, false, f168_local4 - f168_local6, f168_local4 + f168_local7)
			f167_arg0:setLeftRight(true, false, f168_local0, f168_local2)
		else
			f167_arg0:setTopBottom(true, false, f168_local1, f168_local3)
			f167_arg0:setLeftRight(true, false, f168_local0, f168_local2)
		end
		return true
	end
	f167_arg0.ScrollView:appendEventHandler("size_changed", function(f169_arg0, f169_arg1)
		f167_arg0.updatePosAndSize()
	end)
	f167_arg0.ScrollView:setUseStencil(false)
	f167_arg0.ScrollView.View.itemStencil:setUseStencil(false)
end
CoD.PCWidgetUtility.CreateDropdown = function(f170_arg0, f170_arg1, f170_arg2, f170_arg3, f170_arg4)
	local f170_local0 = CoD[f170_arg4].new(f170_arg3, f170_arg2, 0, 0, 0, 0, 0, 0, 0, 0)
	f170_local0.id = f170_arg0.id .. "Dropdown"
	CoD.PCWidgetUtility.BringIntoView(f170_arg0, f170_arg2)
	f170_local0._owner = f170_arg0
	f170_local0._anchor = f170_arg1
	f170_local0.updatePosAndSize()
	table.insert(CoD.PCWidgetUtility.OpenedDropdownIds, f170_local0.id)
	f170_local0:linkToElementModel(f170_arg0, nil, false, function(model)
		if model and model.isOpen then
			model.isOpen:set(true)
		end
		f170_local0:setModel(model, f170_arg2)
	end)
	LUI.OverrideFunction_CallOriginalSecond(f170_local0, "close", function(element)
		f170_arg3[element.id] = nil
		local f172_local0 = LuaUtils.FindItemInArray(CoD.PCWidgetUtility.OpenedDropdownIds, element.id)
		if f172_local0 then
			table.remove(CoD.PCWidgetUtility.OpenedDropdownIds, f172_local0)
		end
		f170_arg3:setInputOverrideElement(nil)
	end)
	f170_local0:setPriority(100)
	f170_arg3:addElement(f170_local0)
	f170_arg3[f170_local0.id] = f170_local0
	f170_arg3:sendInitializationEvents(f170_arg2, f170_local0)
	f170_arg3:setInputOverrideElement(f170_local0, function(f173_arg0, f173_arg1, f173_arg2, f173_arg3, f173_arg4)
		local f173_local0 = -1
		local f173_local1 = 0
		local f173_local2 = 1
		local f173_local3 = f173_local0
		if f173_arg3 == "W" or f173_arg3 == "UPARROW" or f173_arg3 == "ui_navup" or f173_arg4 == Enum.LUIButton[@"lui_key_up"] then
			f173_local3 = f173_local1
		elseif f173_arg3 == "S" or f173_arg3 == "DOWNARROW" or f173_arg3 == "ui_navdown" or f173_arg4 == Enum.LUIButton[@"lui_key_down"] then
			f173_local3 = f173_local2
		elseif f173_arg3 == "ui_confirm" then
			local f173_local4 = f170_local0.ScrollView.View.activeWidget
			local f173_local5 = f173_local4
			local f173_local6 = f173_local4.dispatchEventToParent
			local f173_local7 = {
				name = "onDropdownItemChanged",
				controller = f173_arg2,
			}
			local f173_local8 = f173_local4:getModel()
			f173_local7.value = f173_local8.value:get()
			f173_local6(f173_local5, f173_local7)
			return true
		elseif f173_arg3 == "ESCAPE" or f173_arg4 == Enum.LUIButton[@"lui_key_xbb_pscircle"] then
			local f173_local4 = f170_local0:getModel()
			f173_local4.isOpen:set(false)
			return true
		else
			local f173_local4 = f170_local0:getModel()
			f173_local4.isOpen:set(false)
			if CoD.GetMouseFocus(f173_arg2) and f170_arg0:isParentOf(CoD.GetMouseFocus(f173_arg2)) then
				return true
			else
				return false
			end
		end
		if f173_local3 ~= f173_local0 then
			local f173_local4 = f170_local0.ScrollView.View
			if CoD.GetMouseFocus(f173_arg2) == nil or f173_local4.activeWidget ~= CoD.GetMouseFocus(f173_arg2) and not f173_local4.activeWidget:isParentOf(CoD.GetMouseFocus(f173_arg2)) then
				f173_arg1:ChangeFocusedElement(f173_arg2, f173_local4.activeWidget, true)
			elseif f173_local3 == f173_local1 then
				f173_local4:navigateItemUp(LUI.GridLayout.NavigationFlags.CHANGE_FOCUS)
			elseif f173_local3 == f173_local2 then
				f173_local4:navigateItemDown(LUI.GridLayout.NavigationFlags.CHANGE_FOCUS)
			end
			return true
		end
	end)
	if f170_arg0.DropdownList then
		local f170_local1 = f170_arg0
	end
	local f170_local2 = f170_local1 or f170_arg0:getParent()
	local f170_local3 = f170_local0.ScrollView.View
	local f170_local4 = f170_local3.itemStencil:getFirstChild()
	while f170_local4 do
		local f170_local5 = f170_local4:getModel()
		if f170_local5 and f170_local5.name then
			local f170_local6 = f170_local5.name:get()
			local f170_local7 = CoD.PCWidgetUtility.OptionValueToOptionName
			local f170_local8 = f170_local2
			local f170_local9 = f170_local0:getModel()
			if f170_local6 == f170_local7(f170_local8, f170_local9.currentValue:get()) then
				f170_arg3:ChangeFocusedElement(f170_arg2, f170_local4, true)
				f170_local3:setActiveItem(f170_local4)
				break
			end
		end
		f170_local4 = f170_local4:getNextSibling()
	end
	if not f170_local4 then
		f170_local3:getFirstSelectableItem(true)
	end
	f170_local0.ScrollView.View.loopEdges = true
	local f170_local5 = f170_local2.DropdownList
	f170_local5._checkListOptionsOutdated = nil
	if f170_local2._optionProperties and f170_local2._optionProperties._useListOptionsOutdatedCheck then
		f170_local5._checkListOptionsOutdated = function(f174_arg0)
			local f174_local0 = f170_local2._optionProperties._getOptions(f174_arg0)
			local f174_local1
			if f174_local0 then
				f174_local1 = #f174_local0
				if not f174_local1 then
				else
					if f174_local1 ~= f170_local3.itemCount then
						return true
					end
					for f174_local5, f174_local6 in ipairs(f174_local0) do
						local f174_local7 = f170_local3:getItemAt(f174_local5)
						local f174_local8 = f174_local7 and f174_local7:getModel()
						if f174_local8.name and f174_local8.name:get() ~= f174_local6.name then
							return true
						end
					end
					return false
				end
			end
			f174_local1 = 0
		end
		f170_local0.checkListOptionsOutdatedTimer = LUI.UITimer.newElementTimer(500, false, function(f175_arg0)
			if f170_local5._checkListOptionsOutdated(f170_arg2) then
				local f175_local0 = f170_local0:getModel()
				f175_local0.isOpen:set(false)
			end
		end)
		f170_local0:addElement(f170_local0.checkListOptionsOutdatedTimer)
	end
	f170_local0:registerEventHandler("onDropdownItemChanged", function(element, event)
		return f170_arg0:processEventToParent(event)
	end)
	CoD.FreeCursorUtility.RetriggerCursorPositionNoDelay(f170_arg0, f170_arg2)
end
CoD.PCWidgetUtility.DropdownGiveFocusBack = function(f177_arg0, f177_arg1, f177_arg2)
	f177_arg1:ChangeFocusedElement(f177_arg2, f177_arg0._owner, true)
end
CoD.PCWidgetUtility.OnDropdownIsOpenChange = function(f178_arg0, f178_arg1)
	if f178_arg1:get() == false then
		f178_arg0:close()
	end
end
CoD.PCWidgetUtility.DropdownClose = function(f179_arg0)
	local f179_local0 = f179_arg0:getModel()
	f179_local0.isOpen:set(false)
end
CoD.PCWidgetUtility.PrepareDropdownList = function(f180_arg0, f180_arg1, f180_arg2, f180_arg3, f180_arg4)
	assert(f180_arg4 and f180_arg4.center)
	if not f180_arg3 then
		return
	end
	f180_arg0._getCurrentSelection = function()
		if f180_arg0._optionProperties._options and #f180_arg0._optionProperties._options > 0 then
			return CoD.PCWidgetUtility.GetOptionIndexFromValue(f180_arg0._optionProperties._options, f180_arg3.currentValue:get())
		else
			return -1
		end
	end
	local f180_local0 = function(f182_arg0)
		if f180_arg0._unavailable then
			return
		elseif f180_arg0._optionProperties._options and #f180_arg0._optionProperties._options > 0 then
			f182_arg0 = math.max(1, math.min(#f180_arg0._optionProperties._options, f182_arg0))
			local f182_local0 = f180_arg3.profileVar
			if f182_local0 then
				f182_local0 = f180_arg3.profileVar:get()
			end
			CoD.PCWidgetUtility.ChangeWidgetValue(f180_arg0, f182_local0, f180_arg1, f180_arg3, f180_arg0._optionProperties._options[f182_arg0].value, true)
		end
	end
	CoD.PCWidgetUtility.UpdateOptionList(f180_arg0, f180_arg1, true)
	f180_arg0:registerEventHandler("onDropdownItemChanged", function(element, event)
		if not f180_arg4._checkListOptionsOutdated or not f180_arg4._checkListOptionsOutdated(f180_arg1) then
			if f180_arg3.refreshWidget then
				Engine.ForceNotifyModelSubscriptions(f180_arg3.refreshWidget)
			end
			local f183_local0 = f180_arg3.profileVar
			if f183_local0 then
				f183_local0 = f180_arg3.profileVar:get()
			end
			CoD.PCWidgetUtility.ChangeWidgetValue(element, f183_local0, event.controller, f180_arg3, event.value, true)
		end
		f180_arg3.isOpen:set(false)
		if Engine[@"hash_267ACA658A43FBD"](f180_arg1) then
			f180_arg2:ChangeFocusedElement(f180_arg1, element, true)
		end
	end)
	if not f180_arg0.__subscribedToSettingsMenuOpen then
		f180_arg0:subscribeToGlobalModel(f180_arg1, "PerController", "SettingsMenuOpen", function(model)
			if model:get() and f180_arg4._checkListOptionsOutdated and f180_arg4._checkListOptionsOutdated(f180_arg1) and f180_arg3.refreshWidget then
				Engine.ForceNotifyModelSubscriptions(f180_arg3.refreshWidget)
			end
		end)
		f180_arg0.__subscribedToSettingsMenuOpen = true
	end
end
CoD.PCWidgetUtility.PrepareDirectorQuitButton = function(f185_arg0, f185_arg1)
	local f185_local0 = function(f186_arg0, f186_arg1)
		if Dvar.r_fullscreen:get() == 0 then
			f186_arg0:hide()
		else
			f186_arg0:show()
		end
	end
	f185_arg0:registerEventHandler("options_refresh", f185_local0)
	f185_local0(f185_arg0, {
		controller = f185_arg1,
	})
end
CoD.PCWidgetUtility.IsOpen = function(f187_arg0)
	local f187_local0 = f187_arg0:getModel()
	return f187_local0.isOpen:get()
end
CoD.PCWidgetUtility.IsExpanderLock = function(f188_arg0)
	local f188_local0 = f188_arg0:getModel()
	if f188_local0.frameWidget then
		local f188_local1 = CoD.PCOptionsUtility.GetWidgetType(f188_local0.frameWidget:get())
		if f188_local1 == "keybinder" then
			CoD.PCWidgetUtility.SwapKeyBinderOptions(f188_arg0)
		elseif f188_local1 == "checkbox" then
			return f188_arg0._optionProperties._getCurrentValue(f188_local0.profileVar:get(), f188_arg0.controller) == f188_local0.minValue:get()
		end
	end
	return false
end
CoD.PCWidgetUtility.SwapKeyBinderOptions = function(f189_arg0)
	local f189_local0 = f189_arg0.MainOption.framedWidget
	if f189_local0 then
		local f189_local1 = f189_local0:getModel()
		if not (f189_local1.bind_main:get() ~= "" or f189_local1.bind_alt:get() ~= "") or not f189_local1.isDefault:get() then
			local f189_local2 = f189_arg0.ElementList.itemStencil:getFirstChild()
			local f189_local3, f189_local4 = nil
			while f189_local2 do
				local f189_local5 = f189_local2:getModel()
				if f189_local5 and (f189_local5.bind_main:get() ~= "" or f189_local5.bind_alt:get() ~= "") then
					if f189_local5.isDefault:get() then
						f189_local3 = f189_local2
						f189_local4 = f189_local5
						break
					elseif f189_local1.bind_main:get() == "" and f189_local1.bind_alt:get() == "" then
						f189_local3 = f189_local2
						f189_local4 = f189_local5
					end
				end
				f189_local2 = f189_local2:getNextSibling()
			end
			if f189_local3 ~= nil then
			else
			end
		end
	end
end
CoD.PCWidgetUtility.UpdateExpander = function(f190_arg0, f190_arg1, f190_arg2, f190_arg3, f190_arg4)
	assert(f190_arg2 ~= nil)
	assert(f190_arg3 ~= nil)
	assert(f190_arg4 ~= nil)
	local f190_local0 = 10
	local f190_local1, f190_local2, f190_local3, f190_local4 = f190_arg4:getLocalTopBottom()
	local f190_local5, f190_local6, f190_local7, f190_local8 = f190_arg3:getLocalTopBottom()
	local f190_local9, f190_local10, f190_local11, f190_local12 = f190_arg2:getLocalTopBottom()
	local f190_local13 = f190_local4 + f190_local0
	if CoD.PCWidgetUtility.IsOpen(f190_arg0) then
		local f190_local14 = f190_local4 + f190_local0
		f190_local13 = f190_local14 + f190_local12 - f190_local11 + f190_local0
		f190_arg2:setTopBottom(f190_local9, f190_local10, f190_local14, f190_local14 + f190_local12 - f190_local11)
	end
	f190_arg3:setTopBottom(f190_local5, f190_local6, f190_local13, f190_local13 + f190_local8 - f190_local7)
	local f190_local14, f190_local15, f190_local16, f190_local17 = f190_arg0.VLine:getLocalTopBottom()
	local f190_local18 = f190_local13 + (f190_local8 - f190_local7) / 2
	f190_arg0.VLine:setTopBottom(0, 0, f190_local16, f190_local18)
	f190_arg0.HLine:setTopBottom(0, 0, f190_local18, f190_local18 + 1)
end
CoD.PCWidgetUtility.UpdateExpanderChildrenUnavailability = function(f191_arg0, f191_arg1, f191_arg2)
	local f191_local0 = f191_arg0:getModel()
	if f191_local0 and f191_local0.currentValue and f191_local0.minValue then
		local f191_local1 = f191_arg0.ElementList.itemStencil:getFirstChild()
		while f191_local1 do
			f191_local1:processEvent({
				name = "update_state",
				controller = f191_arg2,
				menu = f191_arg1,
				forceDispatch = true,
			})
			f191_local1 = f191_local1:getNextSibling()
		end
	end
end
CoD.PCWidgetUtility.PrepareTopExpander = function(f192_arg0, f192_arg1, f192_arg2, f192_arg3, f192_arg4, f192_arg5, f192_arg6)
	if not f192_arg3 then
		return
	else
		CoD.PCWidgetUtility.PrepareExpander(f192_arg0, f192_arg1, f192_arg2, f192_arg3, f192_arg4, f192_arg5, f192_arg6)
		f192_arg0.getHeightInList = function(f193_arg0)
			if CoD.PCWidgetUtility.CanHideBattlenetFriendsCategory(f193_arg0) and CoD.PCWidgetUtility.IsBattlenetFriendsCategoryEmpty(f193_arg0) then
				return 0
			elseif CoD.PCWidgetUtility.IsOpen(f193_arg0) then
				local f193_local0, f193_local1, f193_local2, f193_local3 = f192_arg4:getLocalTopBottom()
				return f193_local3
			else
				local f193_local0, f193_local1, f193_local2, f193_local3 = f193_arg0.Button:getLocalTopBottom()
				return f193_local3
			end
		end
	end
end
CoD.PCWidgetUtility.PrepareExpander = function(f194_arg0, f194_arg1, f194_arg2, f194_arg3, f194_arg4, f194_arg5, f194_arg6)
	if not f194_arg3 then
		return
	end
	assert(f194_arg4 ~= nil)
	assert(f194_arg5 ~= nil)
	f194_arg0.controller = f194_arg1
	f194_arg0.getHeightInList = function(f195_arg0)
		local f195_local0, f195_local1, f195_local2, f195_local3 = f195_arg0.Button:getLocalTopBottom()
		return f195_local3
	end
	if f194_arg6 then
		f194_arg6.customFramedWidgetSetup = function(f196_arg0, f196_arg1)
			if f194_arg0._optionProperties and f194_arg0._optionProperties._subWidgetProperties then
				for f196_local3, f196_local4 in pairs(f194_arg0._optionProperties._subWidgetProperties) do
					f196_arg1[f196_local3] = f196_local4
				end
			end
			f196_arg1.m_disableNavigation = false
		end
		f194_arg6.handleHasFrameFocusInRecordFocus = true
	end
	local f194_local0 = function()
		return f194_arg0.gridInfoTable.parentGrid
	end
	f194_arg4.updateSize = function()
		local f198_local0 = f194_local0()
		if f198_local0 then
			f198_local0:processEvent({
				name = "update_state",
				controller = f194_arg1,
				menu = f194_arg2,
				forceDispatch = true,
			})
		end
	end
	f194_arg4.updateSizeWithTimer = function()
		local f199_local0 = f194_local0()
		if f199_local0 then
			if not f199_local0.updateSizeTimer then
				f199_local0.updateSizeTimer = LUI.UITimer.newElementTimer(1, true, function(f200_arg0)
					f199_local0:processEvent({
						name = "update_state",
						controller = f194_arg1,
						menu = f194_arg2,
						forceDispatch = true,
					})
					f199_local0.updateSizeTimer:close()
					f199_local0.updateSizeTimer = nil
				end)
				f199_local0:addElement(f199_local0.updateSizeTimer)
			else
				f199_local0.updateSizeTimer:reset()
			end
		end
	end
	f194_arg0:registerEventHandler("lose_active", function(element, event)
		if element.m_preventFromBeingActive and not element.m_active then
			return
		end
		element.m_active = nil
		element:PlayMainBuiltinClip(true)
		local f201_local0 = element:getFirstChild()
		if f201_local0 == nil then
			return
		end
		while f201_local0 ~= nil do
			local f201_local1 = f201_local0:getNextSibling()
			if f201_local0 ~= f194_arg4 then
				local f201_local2 = f201_local0:processEvent(event)
				if f201_local2 then
					return f201_local2
				end
			end
			f201_local0 = f201_local1
		end
	end)
	f194_arg2:AddButtonCallbackFunction(f194_arg5, f194_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f202_arg0, f202_arg1, f202_arg2, f202_arg3)
		f194_arg3.isOpen:set(not f194_arg3.isOpen:get())
		f194_arg4.updateSize()
		f194_arg0:playSound("toggle", f202_arg2)
		if f194_arg3.isOpen:get() then
			local f202_local0 = f194_arg4:getFirstSelectableItem(true)
			if Engine[@"hash_267ACA658A43FBD"]() then
				local f202_local1 = f202_local0
				if not f202_local1:isFocusable() then
					f202_local1 = CoD.BaseUtility.FindSingleFocusableDescendant(f202_local1, true)
				end
				f202_arg1:ChangeFocusedElement(f202_arg2, f202_local1, true)
			end
		else
			f194_arg0.gridInfoTable.parentGrid:setActiveItem(f194_arg0)
			if Engine[@"hash_267ACA658A43FBD"]() then
				local f202_local0 = f194_arg5
				if not f202_local0:isFocusable() then
					f202_local0 = CoD.BaseUtility.FindSingleFocusableDescendant(f202_local0, true)
				end
				f202_arg1:ChangeFocusedElement(f202_arg2, f202_local0, true)
			end
		end
		return true
	end)
	f194_arg0.__navAction = function(f203_arg0, f203_arg1)
		if CoD.GetMouseFocus(f203_arg0) and f194_arg0.__frame:isParentOf(CoD.GetMouseFocus(f203_arg0)) and f194_arg0.__frame and f194_arg0.__frame.framedWidget then
			local f203_local0 = f194_arg0.__frame.framedWidget.__navAction
			if f203_local0 then
				return f203_local0(f203_arg0, f203_arg1)
			end
		end
		return false
	end
	f194_arg0.__frame = f194_arg6
	f194_arg0.__button = f194_arg5
	f194_arg0.__list = f194_arg4
	f194_arg0.isExpander = true
end
CoD.PCWidgetUtility.PrepareFrameWidget = function(f204_arg0, f204_arg1, f204_arg2, f204_arg3, f204_arg4, f204_arg5)
	local f204_local0 = CoD.PCOptionsUtility.GetWidgetType(f204_arg1)
	if f204_local0 == "checkbox" then
		CoD.PCWidgetUtility.PrepareYesNoToggleButton(f204_arg2, f204_arg2.On, f204_arg2.Off, f204_arg3, f204_arg4, f204_arg5)
	elseif f204_local0 == "sliderbar" then
		CoD.PCWidgetUtility.PrepareSliderBar(f204_arg0, f204_arg3, f204_arg4, f204_arg5)
	end
end
CoD.PCWidgetUtility.PrepareUpdateExpanderDependingOnChildListCount = function(f205_arg0, f205_arg1, f205_arg2)
	local f205_local0 = f205_arg0:getModel()
	f205_arg0:registerEventHandler("grid_updated", function(element, event)
		if event.grid == element.ElementList then
			local f206_local0 = event.grid:getDataSource()
			Engine.SetModelValue(f205_local0.listCount, f206_local0.getCount(event.grid))
			element.ElementList.updateSizeWithTimer()
		end
	end)
end
CoD.PCWidgetUtility.IsBattlenetFriendsCategoryEmpty = function(f207_arg0)
	local f207_local0 = f207_arg0:getModel()
	return Engine.GetModelValue(f207_local0.listCount) == 0
end
CoD.PCWidgetUtility.CanHideBattlenetFriendsCategory = function(f208_arg0)
	local f208_local0 = f208_arg0:getModel()
	return Engine.GetModelValue(f208_local0.hideIfEmpty)
end
CoD.PCWidgetUtility.UpdateNameOnListCount = function(f209_arg0, f209_arg1)
	assert(f209_arg0 ~= nil)
	local f209_local0 = f209_arg0:getModel()
	return Engine[@"hash_4F9F1239CFD921FE"](f209_local0.name:get(), f209_arg1)
end
CoD.PCWidgetUtility.IsJoinableInScrollView = function(f210_arg0, f210_arg1)
	return IsJoinable(f210_arg0.ScrollView.View, f210_arg1)
end
CoD.PCWidgetUtility.LobbyQuickJoinInScrollView = function(f211_arg0, f211_arg1, f211_arg2, f211_arg3, f211_arg4)
	LobbyQuickJoin(f211_arg0, f211_arg1.ScrollView.View, f211_arg2, f211_arg3, f211_arg4)
end
CoD.PCWidgetUtility.SetupFakeChatPreview = function(f212_arg0, f212_arg1, f212_arg2)
	f212_arg0:subscribeToModel(Engine.GetModel(Engine.GetModelForController(f212_arg1), f212_arg2), function(model, f213_arg1)
		if CoD.BitUtility.IsBitwiseAndNonZero(model:get(), Enum.LUIButtonFlags[@"flag_isrepeat"] | Enum.LUIButtonFlags[@"flag_down"]) then
			if f213_arg1.currentState == "Inactive" or f213_arg1.currentState == nil then
				SetElementState(f213_arg1, f213_arg1, f212_arg1, "Collapsed")
			elseif f213_arg1.currentState == "Collapsed" then
				SetElementState(f213_arg1, f213_arg1, f212_arg1, "Expanded")
			else
				SetElementState(f213_arg1, f213_arg1, f212_arg1, "Inactive")
			end
		end
	end)
	f212_arg0:setPriority(10000)
end
CoD.PCWidgetUtility.CanShowMenuStyleChat = function(f214_arg0)
	local f214_local0 = false
	if CoD.BountyHunterUtility.GameTypeIsBounty(f214_arg0) then
		f214_local0 = CoD.ChatClientUtility.IsInBountyHunterMenu
	end
	local f214_local1 = false
	if CoD.isWarzone then
		local f214_local2 = Engine.GetModelForController(f214_arg0)
		f214_local2 = f214_local2.gameScore
		f214_local2 = f214_local2 and f214_local2.currentState
		if f214_local2 then
			f214_local2 = f214_local2:get()
		end
		f214_local1 = f214_local2 and f214_local2 ~= ""
	end
	local f214_local2 = IsVisibilityBitSet(f214_arg0, Enum.UIVisibilityBit[@"bit_ui_active"])
	if not f214_local2 then
		f214_local2 = f214_local0 or f214_local1
	end
	return f214_local2
end
CoD.PCWidgetUtility.RegisterInGameChatEventActivated = function(f215_arg0, f215_arg1, f215_arg2)
	f215_arg2.__inGameChattingModelSubscription = f215_arg2:subscribeToModel(CoD.ChatClientUtility.GetInGameChattingModel(f215_arg0), function(model)
		if not CoD.PCWidgetUtility.CanShowMenuStyleChat(f215_arg0) then
			if model:get() then
				Engine[@"hash_37FFD5B70FD46B06"](f215_arg0, "MOUSE1")
				CoD.FreeCursorUtility.RetriggerCursorPosition(f215_arg2, f215_arg0)
				if f215_arg1 and f215_arg1.occludedBy == nil and f215_arg1.currentInputFocus ~= f215_arg2.InputText then
					f215_arg1:ChangeInputFocus(f215_arg0, f215_arg2.InputText)
				end
			else
				Engine.LockInput(f215_arg0, false, Enum[@"hash_39061B48916076D5"][@"hash_52334BDF2E4222EA"])
			end
		else
			Engine.LockInput(f215_arg0, false, Enum[@"hash_39061B48916076D5"][@"hash_52334BDF2E4222EA"])
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f215_arg1, f215_arg1, f215_arg0, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f217_arg0, f217_arg1, f217_arg2, f217_arg3)
		if not CoD.PCWidgetUtility.CanShowMenuStyleChat(f217_arg2) then
			local f217_local0 = CoD.ChatClientUtility.GetInGameChattingModel(f217_arg2)
			if f217_local0:get() and not f215_arg2:IsMouseInsideElement(f217_arg2) then
				f217_local0:set(false)
				BlockGameFromKeyEvent(f217_arg2)
				return true
			else
				return false
			end
		else
		end
	end)
end
CoD.PCWidgetUtility.GetChatChannelColor = function(f218_arg0)
	return CoD.ChatClientUtility.ColorToString(CoD.ChatClientUtility.GetColorForChannelType(Engine[@"hash_5884871F4FF3ACA"](f218_arg0)))
end
CoD.PCWidgetUtility.SetupChatEntriesView = function(f219_arg0, f219_arg1, f219_arg2, f219_arg3)
	local f219_local0 = f219_arg3
	f219_arg0.controller = f219_arg2
	f219_arg0:setupChatVerticalList()
	local f219_local1 = DataSources.ChatClientEntriesList
	f219_arg0.dataSource = f219_local1
	f219_arg0.dataSourceName = "ChatClientEntriesList"
	f219_arg0.updateDataSource = function()
		local f220_local0 = f219_arg0.dataSource
		f220_local0.prepare(f219_arg0.controller, f219_arg0, f219_arg0.filter)
		local f220_local1 = f220_local0.getCount(f219_arg0)
		for f220_local2 = 1, f220_local1, 1 do
			local f220_local5 = f220_local0.getItem(f219_arg2, f219_arg0, f220_local2)
			f219_arg0.__entries[f220_local2]:setAlpha(1)
			f219_arg0.__entries[f220_local2]:setModel(f220_local5, f219_arg2)
		end
		for f220_local2 = f220_local1 + 1, f219_local0, 1 do
			if f219_arg0.__entries[f220_local2] ~= nil then
				f219_arg0.__entries[f220_local2]:setAlpha(0)
			end
		end
	end
	f219_arg0.vCount = f219_local0
	if f219_local1.prepare and (not f219_arg0.prepared or not ignorePrepare) then
		f219_arg0.prepared = false
		f219_local1.prepare(f219_arg0.controller, f219_arg0, f219_arg0.filter)
		f219_arg0.prepared = true
	end
	f219_arg0.__entries = {}
	f219_arg0.__entries[1] = f219_arg0.ChatEntry1
	assert(f219_arg0.__entries[1])
	for f219_local2 = 2, f219_local0, 1 do
		f219_arg0.__entries[f219_local2] = CoD.ChatClientEntryContainer.new(f219_arg1, f219_arg2, 0, 0, 0, 500, 0, 0, 0, 40)
		local f219_local5 = "ChatEntry" .. tostring(f219_local2)
		f219_arg0.__entries[f219_local2].id = f219_local5
		f219_arg0[f219_local5] = f219_arg0.__entries[f219_local2]
		f219_arg0:addElement(f219_arg0.__entries[f219_local2])
		f219_arg1:sendInitializationEvents(f219_arg2, f219_arg0.__entries[f219_local2])
	end
	if f219_local1 and f219_local1.prepare then
		f219_arg0:updateDataSource(nil, true)
	end
end
CoD.PCWidgetUtility.ResizePlayerName = function(f221_arg0, f221_arg1)
	local f221_local0 = f221_arg0:getModel()
	if f221_local0 then
		local f221_local1 = f221_local0.fullname:get()
		if f221_local1 ~= nil and f221_local1 ~= "" then
			local f221_local2 = CoD.ChatClientUtility.GetCurrentChattingModel(f221_arg1)
			if not f221_local2:get() then
				f221_arg0.m_focusable = false
				return
			end
			f221_arg0.m_focusable = true
			local f221_local2, f221_local3 = f221_arg0:getLocalSize()
			local f221_local4, f221_local5, f221_local6, f221_local7 = GetTextDimensions(f221_local1, CoD.fonts.Chat, f221_local3)
			local f221_local8, f221_local9, f221_local10, f221_local11 = f221_arg0:getLocalRect()
			local f221_local12, f221_local13, f221_local14 = nil
			f221_local14 = f221_local8
			f221_arg0:setLeftRight(true, false, f221_local14, f221_local14 + f221_local6 - f221_local4)
		end
		f221_arg0.m_focusable = false
		return
	end
end
CoD.PCWidgetUtility.RepositionElements = function(f222_arg0, f222_arg1)
	local f222_local0, f222_local1, f222_local2, f222_local3 = f222_arg0:getLocalRect()
	local f222_local4, f222_local5, f222_local6, f222_local7 = nil
	f222_arg0.entryBodyText:setLeftRight(true, false, f222_local0, f222_local2)
	local f222_local8, f222_local9 = f222_arg0.entryBodyText:getTextWidthAndHeight()
	f222_local5 = f222_local9
	if f222_local8 > 0 then
		f222_local8 = f222_arg0:getParent()
		f222_local8 = f222_local8:getParent()
		f222_local8:setTopBottom(true, false, 0, f222_local5)
		f222_local8 = f222_arg0:getParent()
		f222_local8:setTopBottom(true, false, 0, f222_local5)
		f222_arg0:setTopBottom(true, false, 0, f222_local5)
	else
		f222_arg0:setTopBottom(true, false, 0, 0)
	end
	f222_local8 = f222_arg0:getParent()
	while f222_local8 and not f222_local8.isScrollView do
		f222_local8 = f222_local8:getParent()
	end
	if f222_local8 and f222_local8._onSizeChanged then
		f222_local8:_onSizeChanged()
	end
end
CoD.PCWidgetUtility.UpdateChatPlayerName = function(f223_arg0, f223_arg1)
	CoD.PCWidgetUtility.ResizePlayerName(f223_arg0, f223_arg1)
end
CoD.PCWidgetUtility.UpdateChatEntryPositions = function(f224_arg0, f224_arg1)
	CoD.PCWidgetUtility.RepositionElements(f224_arg0, f224_arg1)
end
CoD.PCWidgetUtility.UpdateChatEntryState = function(f225_arg0, f225_arg1, f225_arg2)
	local f225_local0 = f225_arg0:getModel()
	if f225_local0 and Engine[@"milliseconds"]() - f225_local0.timeMs:get() < 5000 then
		local f225_local1 = f225_arg0:getParent()
		f225_local1:setState(f225_arg1, f225_local1.currentState, true, true)
	end
end
CoD.PCWidgetUtility.SetupTwoColorsText = function(f226_arg0, f226_arg1, f226_arg2, f226_arg3, f226_arg4)
	f226_arg0:setupTwoColorsText(f226_arg1, f226_arg2, f226_arg3, f226_arg4)
end
CoD.PCWidgetUtility.RemoveTwoColorsText = function(f227_arg0)
	f227_arg0:disableTwoColorsText()
end
CoD.PCWidgetUtility.SetupChatLineWidget = function(f228_arg0)
	if not CoD.isPC then
		return
	else
		f228_arg0:registerEventHandler("update_safe_area", function(element, event)
			CoD.PCWidgetUtility.RepositionElements(element.ChatClientChatEntryLineOfText, event.controller)
			CoD.PCWidgetUtility.ResizePlayerName(element.ChatClientChatEntryPlayerName, event.controller)
		end)
	end
end
CoD.PCWidgetUtility.PrepareChatVScrollWidget = function(f230_arg0, f230_arg1, f230_arg2, f230_arg3)
	f230_arg3.ScrollView:appendEventHandler("size_changed", function(f231_arg0, f231_arg1)
		CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget(f230_arg3, f230_arg1, f230_arg2)
		return true
	end)
	f230_arg3:registerEventHandler("view_scrolled", function(element, event)
		CoD.PCWidgetUtility.UpdateScrollbarInVScrollWidget(element, f230_arg1, f230_arg2)
		return true
	end)
	CoD.PCWidgetUtility.SetupScrollbar(f230_arg3, f230_arg1, f230_arg2, f230_arg3.ScrollView._scrollAnchoredToBottom, true, f230_arg0)
	f230_arg3.ScrollView.View.blockBottomEdge = true
	if not f230_arg3.wheelScrollUnit then
		f230_arg3.wheelScrollUnit = 10
	end
	if not f230_arg3.arrowScrollUnit then
		f230_arg3.arrowScrollUnit = 10
	end
end
CoD.PCWidgetUtility.SetupClickableChatChannel = function(f233_arg0, f233_arg1)
	f233_arg0.handleMouseButton = true
	f233_arg0.keepOldInputFocusOnClick = false
	f233_arg0:appendEventHandler("leftmousedown", function(f234_arg0, f234_arg1)
		local f234_local0 = CoD.SafeGetModelValue(f234_arg0:getModel(), "chId")
		if f234_local0 then
			Engine.ForceNotifyModelSubscriptions(CoD.ChatClientUtility.GetCurrentChattingModel(f234_arg1.controller))
			CoD.ChatClientUtility.SetChannelTo(f234_arg1.controller, f234_local0)
		end
	end)
end
CoD.PCWidgetUtility.SetupLeftClickableChatPlayerName = function(f235_arg0, f235_arg1, f235_arg2)
	f235_arg0.handleMouseButton = true
	CoD.Menu.AddButtonCallbackFunction(f235_arg2, f235_arg0, f235_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f236_arg0, f236_arg1, f236_arg2, f236_arg3)
		local f236_local0 = f236_arg0:getModel()
		local f236_local1 = f236_local0.xuid:get()
		local f236_local2 = nil
		if Engine.GetXUID64(f236_arg2) == f236_local1 then
			f236_local2 = f236_local0.chId:get()
			if Engine[@"hash_5884871F4FF3ACA"](f236_local2) ~= Enum[@"hash_7F6296F5D7A38AD2"][@"hash_75E57997D82BCBD1"] then
				f236_local2 = nil
			end
		else
			f236_local2 = CoD.ChatClientUtility.GetAndJoinWhisperChannelIdByXuid(f236_arg2, f236_local1)
		end
		if f236_local2 then
			local f236_local3 = CoD.ChatClientUtility.GetInputChannelModel(f236_arg2)
			f236_local3:set(f236_local2)
		end
	end)
end
CoD.PCWidgetUtility.SetupRightClickableChatPlayerNameParent = function(f237_arg0, f237_arg1, f237_arg2)
	f237_arg0.handleMouseButton = true
	CoD.PCWidgetUtility.SetupContextualMenu(f237_arg0, f237_arg1, "displayName", "realName", "xuid")
	LUI.OverrideFunction_CallOriginalFirst(f237_arg0, "childFocusGained", function(element)
		CoD.PCWidgetUtility.UpdatePlayerContextualMenu(f237_arg0, f237_arg0:getMenu(), f237_arg1)
	end)
end
CoD.PCWidgetUtility.GetSelectedFriendXUID = function(f239_arg0)
	return Engine.GetModelValue(Engine.CreateModel(Engine.GetModelForController(f239_arg0), "Social.selectedFriendXUID"))
end
CoD.PCWidgetUtility.GetSelectedFriendGamertag = function(f240_arg0)
	return Engine.GetModelValue(Engine.CreateModel(Engine.GetModelForController(f240_arg0), "Social.selectedFriendGamertag"))
end
CoD.PCWidgetUtility.RemoveFriend = function(f241_arg0, f241_arg1, f241_arg2, f241_arg3, f241_arg4)
	local f241_local0 = {
		controller = f241_arg2,
	}
	local f241_local1
	if f241_arg3 then
		f241_local1 = f241_arg3.xuid
		if not f241_local1 then
		else
			f241_local0.xuid = f241_local1
			if f241_arg3 then
				f241_local1 = f241_arg3.gamertag
				if not f241_local1 then
				else
					f241_local0.gamertag = f241_local1
					CoD.OverlayUtility.CreateOverlay(f241_arg2, f241_arg4, "RemoveFriendConfirmation", f241_arg4, f241_local0)
					return true
				end
			end
			f241_local1 = CoD.PCWidgetUtility.GetSelectedFriendGamertag(f241_arg2)
		end
	end
	f241_local1 = CoD.PCWidgetUtility.GetSelectedFriendXUID(f241_arg2)
end
CoD.PCWidgetUtility.WhisperPlayer = function(f242_arg0, f242_arg1, f242_arg2, f242_arg3, f242_arg4, f242_arg5)
	local f242_local0 = CoD.ChatClientUtility.GetCurrentChattingModel(f242_arg2)
	if not f242_local0:get() then
		f242_local0:set(true)
	end
	CoD.PCBattlenetUtility.CloseBattlenetMenu(f242_arg1, f242_arg4, f242_arg2, false)
	local f242_local1
	if f242_arg3 then
		f242_local1 = f242_arg3.xuid
		if not f242_local1 then
		else
			local f242_local2 = CoD.ChatClientUtility.GetAndJoinWhisperChannelIdByXuid(f242_arg2, f242_local1)
			if f242_local2 then
				local f242_local3 = CoD.ChatClientUtility.GetInputChannelModel(f242_arg2)
				f242_local3:set(f242_local2)
			end
			if not f242_arg5 then
				f242_arg4:goBack(f242_arg2)
			end
		end
	end
	f242_local1 = CoD.PCWidgetUtility.GetSelectedFriendXUID(f242_arg2)
end
CoD.PCWidgetUtility.InspectPlayer = function(f243_arg0, f243_arg1, f243_arg2, f243_arg3, f243_arg4, f243_arg5)
	if f243_arg4 then
		if not f243_arg5 then
			GoBackAndOpenOverlayOnParent(f243_arg4, "SinglePlayerInspection", f243_arg2)
		else
			OpenOverlay(f243_arg4, "SinglePlayerInspection", f243_arg2)
		end
	end
end
CoD.PCWidgetUtility.BlockPlayer = function(f244_arg0, f244_arg1, f244_arg2, f244_arg3, f244_arg4, f244_arg5)
	if not f244_arg5 then
		f244_arg4:goBack(f244_arg2)
	end
	local f244_local0
	if f244_arg3 then
		f244_local0 = f244_arg3.xuid
		if not f244_local0 then
		else
			return Engine[@"blockplayer"](f244_local0)
		end
	end
	f244_local0 = CoD.PCWidgetUtility.GetSelectedFriendXUID(f244_arg2)
end
CoD.PCWidgetUtility.UnblockPlayer = function(f245_arg0, f245_arg1, f245_arg2, f245_arg3, f245_arg4, f245_arg5)
	if not f245_arg5 then
		f245_arg4:goBack(f245_arg2)
	end
	local f245_local0
	if f245_arg3 then
		f245_local0 = f245_arg3.xuid
		if not f245_local0 then
		else
			return Engine[@"unblockplayer"](f245_local0)
		end
	end
	f245_local0 = CoD.PCWidgetUtility.GetSelectedFriendXUID(f245_arg2)
end
CoD.PCWidgetUtility.OpenInvitePlayerPopup = function(f246_arg0, f246_arg1, f246_arg2, f246_arg3, f246_arg4, f246_arg5)
	local f246_local0 = "Social_InvitePlayersPopup"
	if f246_arg4.menuName ~= f246_local0 then
		OpenOverlay(f246_arg4, f246_local0, f246_arg2, nil)
		CoD.PCBattlenetUtility.CloseBattlenetMenu(f246_arg1, f246_arg4, f246_arg2, false)
	end
end
CoD.PCWidgetUtility.LeaveParty = function(f247_arg0, f247_arg1, f247_arg2, f247_arg3, f247_arg4, f247_arg5)
	CoD.OverlayUtility.CreateOverlay(f247_arg2, f247_arg4, "LeaveLobbyPopupPC", LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE)
end
CoD.PCWidgetUtility.ReportPlayer = function(f248_arg0, f248_arg1, f248_arg2, f248_arg3, f248_arg4, f248_arg5)
	local f248_local0
	if f248_arg3 then
		f248_local0 = f248_arg3.xuid
		if not f248_local0 then
		else
			local f248_local1 = Engine.GetPlayerInfo(f248_arg2, f248_local0)
			local f248_local2 = {
				controller = f248_arg2,
				xuid = f248_local0,
			}
			local f248_local3 = CoD.PCBattlenetUtility.StripBattleTagNumber
			local f248_local4
			if f248_arg3 then
				f248_local4 = f248_arg3.gamertag
				if not f248_local4 then
				else
					f248_local2.gamertag = f248_local3(f248_local4)
					f248_local2.clantag = f248_local1.info.clantag
					f248_local2.emblemBacking = f248_local1.info.emblemBacking
					CoD.OverlayUtility.CreateOverlay(f248_arg2, f248_arg4, "ReportPlayer", f248_arg2, f248_arg1, f248_local2)
				end
			end
			f248_local4 = CoD.PCWidgetUtility.GetSelectedFriendGamertag(f248_arg2)
		end
	end
	f248_local0 = CoD.PCWidgetUtility.GetSelectedFriendXUID(f248_arg2)
end
CoD.PCWidgetUtility.CancelPartyInvite = function(f249_arg0, f249_arg1, f249_arg2, f249_arg3, f249_arg4, f249_arg5)
	local f249_local0
	if f249_arg3 then
		f249_local0 = f249_arg3.xuid
		if not f249_local0 then
		else
			Engine[@"hash_2406FC054276FCE6"](f249_arg2, f249_local0)
		end
	end
	f249_local0 = CoD.PCWidgetUtility.GetSelectedFriendXUID(f249_arg2)
end
CoD.PCWidgetUtility.OpenPlayerAccount = function(f250_arg0, f250_arg1, f250_arg2, f250_arg3, f250_arg4, f250_arg5)
	CoD.PCUtility.ToggleShortcutMenu(f250_arg4, f250_arg2, "ui_openPlayerAccount")
end
CoD.PCWidgetUtility.ShowRemoveFriend = function(f251_arg0, f251_arg1, f251_arg2)
	return Engine.IsFriendFromXUID(f251_arg0, f251_arg2)
end
CoD.PCWidgetUtility.ShowInspectPlayer = function(f252_arg0, f252_arg1, f252_arg2)
	local f252_local0 = f252_arg1
	local f252_local1
	if not f252_arg1.disableInspection then
		f252_local1 = not IsInGame()
	else
		f252_local1 = false
	end
	return f252_local1
end
CoD.PCWidgetUtility.ShowWhisperPlayer = function(f253_arg0, f253_arg1, f253_arg2)
	local f253_local0 = Engine.GetXUID64(f253_arg0) == f253_arg2
	local f253_local1 = Engine.IsFriendFromXUID(f253_arg0, f253_arg2)
	local f253_local2 = Engine[@"isplayerblocked"](f253_arg2)
	local f253_local3
	if not f253_local0 then
		local f253_local4 = f253_local1
		if not f253_local2 then
			f253_local3 = CoD.PCUtility.MenuHasChat()
		end
	end
	f253_local3 = false
end
CoD.PCWidgetUtility.ShowBlockPlayer = function(f254_arg0, f254_arg1, f254_arg2)
	local f254_local0
	if not (Engine.GetXUID64(f254_arg0) == f254_arg2) and not Engine.IsFriendFromXUID(f254_arg0, f254_arg2) then
		f254_local0 = not Engine[@"isplayerblocked"](f254_arg2)
	else
		f254_local0 = false
	end
	return f254_local0
end
CoD.PCWidgetUtility.ShowUnblockPlayer = function(f255_arg0, f255_arg1, f255_arg2)
	local f255_local0
	if not (Engine.GetXUID64(f255_arg0) == f255_arg2) then
		f255_local0 = Engine[@"isplayerblocked"](f255_arg2)
	else
		f255_local0 = false
	end
	return f255_local0
end
CoD.PCWidgetUtility.ShowInvitePlayersToParty = function(f256_arg0, f256_arg1, f256_arg2)
	return Engine.GetXUID64(f256_arg0) == f256_arg2
end
CoD.PCWidgetUtility.ShowLeaveParty = function(f257_arg0, f257_arg1, f257_arg2)
	return Engine.GetXUID64(f257_arg0) == f257_arg2 and ShouldShowLeaveParty(f257_arg0)
end
CoD.PCWidgetUtility.ShowReportPlayer = function(f258_arg0, f258_arg1, f258_arg2)
	return not (Engine.GetXUID64(f258_arg0) == f258_arg2)
end
CoD.PCWidgetUtility.ShowCancelPartyInvite = function(f259_arg0, f259_arg1, f259_arg2)
	local f259_local0
	if (Engine.GetXUID64(f259_arg0) == f259_arg2) or CoD.PCBattlenetUtility.GetPartyInviteStatus(f259_arg0, f259_arg2) ~= CoD.PCWidgetUtility.PartyInviteStatus.PENDING then
		f259_local0 = false
	else
		f259_local0 = true
	end
	return f259_local0
end
CoD.PCWidgetUtility.ShowOpenPlayerAccount = function(f260_arg0, f260_arg1, f260_arg2)
	local f260_local0 = Engine.GetXUID64(f260_arg0) == f260_arg2
	local f260_local1
	if not IsInGame() then
		f260_local1 = not IsMainModeInvalid()
	else
		f260_local1 = false
	end
	return f260_local1
end
CoD.PCWidgetUtility.CanFriendRequest = function(f261_arg0, f261_arg1)
	return not Engine.IsFriendFromXUID(f261_arg0, f261_arg1)
end
CoD.PCWidgetUtility.CanRemoveFriend = function(f262_arg0, f262_arg1)
	return Engine.IsFriendFromXUID(f262_arg0, f262_arg1)
end
CoD.PCWidgetUtility.CanBlockPlayer = function(f263_arg0, f263_arg1)
	return false
end
CoD.PCWidgetUtility.ContextualMenuTitleModel = nil
CoD.PCWidgetUtility.ContextualMenuSecondLineModel = nil
CoD.PCWidgetUtility.ContextualMenuXuidModel = nil
CoD.PCWidgetUtility.ContextualMenuActions = {}
CoD.PCWidgetUtility.SetupContextualMenu = function(f264_arg0, f264_arg1, f264_arg2, f264_arg3, f264_arg4)
	f264_arg0.__contextualMenuTitleModelPath = f264_arg2
	f264_arg0.__contextualMenuSecondLineModelPath = f264_arg3
	f264_arg0.__contextualMenuXuidModelPath = f264_arg4
end
CoD.PCWidgetUtility.PrepareContextualMenuActions = function(f265_arg0, f265_arg1, f265_arg2, f265_arg3, f265_arg4, f265_arg5)
	CoD.PCWidgetUtility.ContextualMenuActions = {}
	local f265_local0 = 0
	for f265_local4, f265_local5 in pairs(f265_arg4) do
		if f265_local5.getActionFunction(f265_arg0, f265_arg1, f265_arg2, f265_arg3) then
			if not f265_arg5 then
				table.insert(CoD.PCWidgetUtility.ContextualMenuActions, {
					name = f265_local5.actionName,
					getActionFunction = f265_local5.getActionFunction,
				})
			end
			f265_local0 = f265_local0 + 1
		end
	end
	return f265_local0
end
CoD.PCWidgetUtility.CloseContextualMenu = function(f266_arg0, f266_arg1)
	if f266_arg0 and f266_arg0.ContextualMenu then
		for f266_local3, f266_local4 in ipairs(f266_arg0.__focusableElementPaths) do
			if f266_local4.id == "ContextualMenu" then
				table.remove(f266_arg0.__focusableElementPaths, f266_local3)
			end
		end
		f266_arg0.ContextualMenu:close()
		f266_arg0.ContextualMenu = nil
		f266_arg0:addElement(LUI.UITimer.newElementTimer(1, true, function()
			ForceNotifyControllerModel(f266_arg1, "FreeCursor.position")
		end))
	end
end
CoD.PCWidgetUtility.PlayerContextualMenuExtraOptionsData = {
	{
		name = @"hash_62ABB014B7887052",
		id = "removeFriend",
		clickFct = CoD.PCWidgetUtility.RemoveFriend,
		visibilityFct = CoD.PCWidgetUtility.ShowRemoveFriend,
		enableFct = CoD.PCWidgetUtility.CanRemoveFriend,
	},
	{
		name = @"hash_76FA0A657B8DE886",
		id = "blockPlayer",
		clickFct = CoD.PCWidgetUtility.BlockPlayer,
		visibilityFct = CoD.PCWidgetUtility.ShowBlockPlayer,
		enableFct = CoD.PCWidgetUtility.CanBlockPlayer,
	},
	{
		name = @"hash_64D831F3E49D4035",
		id = "unblockPlayer",
		clickFct = CoD.PCWidgetUtility.UnblockPlayer,
		visibilityFct = CoD.PCWidgetUtility.ShowUnblockPlayer,
		enableFct = CoD.PCWidgetUtility.CanUnblockPlayer,
	},
	{
		name = @"hash_6891CBAB469619DF",
		id = "whisperPlayer",
		clickFct = CoD.PCWidgetUtility.WhisperPlayer,
		visibilityFct = CoD.PCWidgetUtility.ShowWhisperPlayer,
		enableFct = nil,
	},
	{
		name = "menu/invite_players",
		id = "invitePlayersToParty",
		clickFct = CoD.PCWidgetUtility.OpenInvitePlayerPopup,
		visibilityFct = CoD.PCWidgetUtility.ShowInvitePlayersToParty,
		enableFct = nil,
	},
	{
		name = "menu/manage_party_leave_button",
		id = "leaveParty",
		clickFct = CoD.PCWidgetUtility.LeaveParty,
		visibilityFct = CoD.PCWidgetUtility.ShowLeaveParty,
		enableFct = nil,
	},
	{
		name = @"menu/report_player",
		id = "reportPlayerPc",
		clickFct = CoD.PCWidgetUtility.ReportPlayer,
		visibilityFct = CoD.PCWidgetUtility.ShowReportPlayer,
		enableFct = nil,
	},
	{
		name = @"hash_79477D8B17843EA2",
		id = "cancelPartyInvite",
		clickFct = CoD.PCWidgetUtility.CancelPartyInvite,
		visibilityFct = CoD.PCWidgetUtility.ShowCancelPartyInvite,
		enableFct = nil,
	},
	{
		name = "menu/playeraccount",
		id = "playerAccount",
		clickFct = CoD.PCWidgetUtility.OpenPlayerAccount,
		visibilityFct = CoD.PCWidgetUtility.ShowOpenPlayerAccount,
		enableFct = nil,
	},
}
CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu = function(f268_arg0, f268_arg1, f268_arg2)
	f268_arg0.handleMouseButton = true
	CoD.PCWidgetUtility.SetupContextualMenu(f268_arg0, f268_arg1, "gamertag", "realName", "xuid")
	LUI.OverrideFunction_CallOriginalFirst(f268_arg0, "childFocusGained", function(element)
		CoD.PCWidgetUtility.UpdatePlayerContextualMenu(f268_arg0, element:getMenu(), f268_arg1)
	end)
end
CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuScoreboard = function(f270_arg0, f270_arg1, f270_arg2)
	f270_arg0.handleMouseButton = true
	CoD.PCWidgetUtility.SetupContextualMenu(f270_arg0, f270_arg1, "scoreboard.playerName")
	LUI.OverrideFunction_CallOriginalFirst(f270_arg0, "childFocusGained", function(element)
		CoD.PCWidgetUtility.UpdatePlayerContextualMenu(f270_arg0, element:getMenu(), f270_arg1)
	end)
	f270_arg0:registerEventHandler("gain_focus", function(element, event)
		local f272_local0 = nil
		if element.gainFocus then
			f272_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f272_local0 = element.super:gainFocus(event)
		end
		CoD.PCWidgetUtility.UpdatePlayerContextualMenu(f270_arg0, element:getMenu(), f270_arg1)
		return f272_local0
	end)
end
CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuLeaderboard = function(f273_arg0, f273_arg1, f273_arg2)
	f273_arg0.handleMouseButton = true
	CoD.PCWidgetUtility.SetupContextualMenu(f273_arg0, f273_arg1, "name", nil, "xuid")
	f273_arg0:registerEventHandler("gain_focus", function(element, event)
		local f274_local0 = nil
		if element.gainFocus then
			f274_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f274_local0 = element.super:gainFocus(event)
		end
		CoD.PCWidgetUtility.UpdatePlayerContextualMenu(f273_arg0, element:getMenu(), f273_arg1)
		return f274_local0
	end)
end
CoD.PCWidgetUtility.UpdatePlayerContextualMenu = function(f275_arg0, f275_arg1, f275_arg2)
	CoD.PCWidgetUtility.UpdatePlayerContextualMenuOptions(f275_arg0, f275_arg1, f275_arg2)
end
CoD.PCWidgetUtility.PlayerContextualMenuOptionsIDOrder = {
	"cancelPartyInvite",
	"inspectPlayer",
	"invitePlayersToParty",
	"whisperPlayer",
	"inviteToParty",
	"joinGame",
	"promoteToLeader",
	"mutePlayer",
	"unmutePlayer",
	"removeFromParty",
	"leaveParty",
	"sendFriendRequest",
	"removeFriend",
	"reportPlayerPc",
	"blockPlayer",
	"unblockPlayer",
	"playerAccount",
}
CoD.PCWidgetUtility.InGamePlayerContextualMenuOptionsIDOrder = {
	"cancelPartyInvite",
	"whisperPlayer",
	"inviteToParty",
	"joinGame",
	"promoteToLeader",
	"mutePlayer",
	"unmutePlayer",
	"sendFriendRequest",
	"removeFriend",
	"reportPlayerPc",
	"blockPlayer",
	"unblockPlayer",
}
CoD.PCWidgetUtility.UpdatePlayerContextualMenuOptions = function(f276_arg0, f276_arg1, f276_arg2)
	local f276_local0 = f276_arg0:getModel()
	if f276_local0 == nil then
		return
	end
	local f276_local1 = f276_local0.xuid
	if f276_local1 then
		f276_local1 = f276_local0.xuid:get()
	end
	if not f276_local1 and f276_local0.clientNum then
		f276_local1 = GetClientGameLobbyXUIDForClientNum(f276_local0.clientNum:get())
	end
	if f276_local1 == nil or not Engine[@"xuidisvalid"](f276_local1) or Engine[@"hash_65CB8E6B7FBBFFD5"](f276_local1) then
		return
	end
	Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f276_arg2), "Social.selectedFriendXUID"), f276_local1)
	if not f276_local0.gamertag or not f276_local0.gamertag:get() then
		local f276_local2 = f276_local0.fullname
		local f276_local3 = f276_local0.fullname:get()
		local f276_local4 = ""
	end
	local f276_local5 = f276_local2 and f276_local3 or f276_local4
	local f276_local6 = CoD.SocialUtility.GetFriendsButtonOptions(f276_arg2, nil, f276_local1, f276_local5, (f276_local0.battlenetPresence and f276_local0.battlenetPresence:get() or Engine[@"getbattlenetpresence"](f276_local1)) ~= Enum[@"hash_28811A60F2FF3ADA"][@"hash_5D7B6D45F00CF380"], true, f276_arg1.menuName)
	f276_arg0.__contextualMenuActions = {}
	local f276_local7 = CoD.PCWidgetUtility.PlayerContextualMenuOptionsIDOrder
	if not InFrontend() then
		f276_local7 = CoD.PCWidgetUtility.InGamePlayerContextualMenuOptionsIDOrder
	end
	for f276_local17, f276_local18 in ipairs(f276_local7) do
		local f276_local11 = false
		for f276_local12, f276_local13 in pairs(f276_local6) do
			if f276_local13.id == f276_local18 then
				f276_arg0:AddContextualMenuAction(f276_arg1, f276_arg2, f276_local13.text, function(f277_arg0, f277_arg1, f277_arg2, f277_arg3)
					if not f276_local13.disabled then
						return function(f278_arg0, f278_arg1, f278_arg2, f278_arg3)
							f276_local13.action(f276_arg0, f278_arg0, f278_arg2, f276_local13.params, f278_arg1, true)
						end
					else
					end
				end)
				f276_local11 = true
				break
			end
		end
		for f276_local12, f276_local13 in pairs(CoD.PCWidgetUtility.PlayerContextualMenuExtraOptionsData) do
			if f276_local13.id == f276_local18 then
				f276_arg0:AddContextualMenuAction(f276_arg1, f276_arg2, f276_local13.name, function(f279_arg0, f279_arg1, f279_arg2, f279_arg3)
					if f276_local13.visibilityFct(f279_arg2, f279_arg1, f276_local1) then
						return function(f280_arg0, f280_arg1, f280_arg2)
							f276_local13.clickFct(f276_arg0, f280_arg0, f280_arg2, {
								xuid = f276_local1,
								gamertag = f276_local5,
							}, f280_arg1, true)
						end
					else
					end
				end)
				f276_local11 = true
			end
		end
	end
end
CoD.PCWidgetUtility.SetupPlayerContextualMenuItem = function(f281_arg0, f281_arg1)
	f281_arg0.handleMouseButton = true
	f281_arg0:appendEventHandler("leftmousedown", function(f282_arg0, f282_arg1)
		local f282_local0 = f282_arg0:getModel()
		local f282_local1 = CoD.SafeGetModelValue(f282_local0, "clickFct")
		if f282_local1 and f282_local1(f282_arg1.controller, CoD.SafeGetModelValue(f282_local0, "xuidnumber")) then
			local f282_local2 = f282_arg0:getMenu()
			f282_local2.PlayerContextualMenu:setState(f282_arg1.controller, "Closed")
		end
	end)
end
CoD.PCWidgetUtility.SetupClickableFilter = function(f283_arg0, f283_arg1)
	f283_arg0.handleMouseButton = true
	f283_arg0.keepOldInputFocusOnClick = false
	f283_arg0:appendEventHandler("leftmousedown", function(f284_arg0, f284_arg1)
		local f284_local0 = f284_arg0:getModel()
		local f284_local1 = CoD.SafeGetModelValue(f284_local0, "channelId")
		local f284_local2 = f284_local0.active
		Engine[@"hash_6D1DD5DBCA5778EA"](f284_local1)
		local f284_local3 = Engine[@"hash_3CA0ADE9B4DA235D"](f284_local1)
		local f284_local4 = f284_local2
		local f284_local5 = f284_local2.set
		local f284_local6
		if not f284_local3 then
			f284_local6 = 1
			if not f284_local6 then
			else
				f284_local5(f284_local4, f284_local6)
				f284_local5 = CoD.ChatClientUtility.GetInputChannelModel(f283_arg1)
				f284_local5 = f284_local5:get()
				if f284_local3 then
					if f284_local5 == f284_local1 then
						Engine[@"hash_38D53AF0ABECF512"]()
					end
				elseif Engine[@"hash_5884871F4FF3ACA"](f284_local5) == Enum[@"hash_7F6296F5D7A38AD2"][@"hash_659073B959F68608"] then
					Engine[@"hash_38D53AF0ABECF512"]()
				end
			end
		end
		f284_local6 = 0
	end)
end
CoD.PCWidgetUtility.SetupChatFiltersButton = function(f285_arg0, f285_arg1)
	f285_arg0.handleMouseButton = true
	f285_arg0.keepOldInputFocusOnClick = false
	f285_arg0:appendEventHandler("leftmousedown", function(f286_arg0, f286_arg1)
		local f286_local0 = f286_arg0:getMenu()
		if f286_local0.ChatClientFilterList ~= nil then
			if f286_local0.ChatClientFilterList.currentState == "DefaultState" then
				f286_local0.ChatClientFilterList:setState(f286_arg1.controller, "Closed")
				return true
			end
			f286_local0.ChatClientFilterList:close()
		end
		f286_local0.ChatClientFilterList = CoD.ChatClientFilterList.new(f286_local0, f286_arg1.controller, 0, 0, 0, 0, 0, 0, 0, 0)
		f286_local0.ChatClientFilterList:setPriority(1002)
		assert(f286_local0.ChatClientFilterList)
		f286_local0:addElement(f286_local0.ChatClientFilterList)
		f286_local0:sendInitializationEvents(f286_arg1.controller, f286_local0.ChatClientFilterList)
		local f286_local1, f286_local2, f286_local3, f286_local4 = Engine[@"hash_3695399A0E06EC35"](f286_arg1.controller, f286_arg0)
		local f286_local5, f286_local6, f286_local7, f286_local8 = f286_local0:getRect()
		if f286_local5 ~= nil then
			local f286_local9, f286_local10 = Engine[@"getscreensize"](f286_arg1.controller)
			f286_local1 = f286_local1 * f286_local9 / (f286_local7 - f286_local5)
			f286_local3 = f286_local3 * f286_local9 / (f286_local7 - f286_local5)
			f286_local2 = f286_local2 * f286_local10 / (f286_local8 - f286_local6)
			f286_local4 = f286_local4 * f286_local10 / (f286_local8 - f286_local6)
		end
		local f286_local9 = f286_local4 - f286_local2
		f286_local0.ChatClientFilterList:setLeftRight(0, 0, f286_local1, f286_local1)
		f286_local0.ChatClientFilterList:setTopBottom(0, 0, f286_local2 + f286_local9, f286_local2 + f286_local9)
		f286_local0.ChatClientFilterList:registerEventHandler("lose_input_focus", function(element, event)
			local f287_local0 = element:getMenu()
			f287_local0.ChatClientFilterList:setState(f286_arg1.controller, "Closed")
			return true
		end)
		LUI.GridLayout.menuOpened(f286_local0.ChatClientFilterList.FiltersList)
		f286_local0.ChatClientFilterList:setState(f286_arg1.controller, "DefaultState")
		f286_local0:ChangeInputFocus(f286_arg1.controller, f286_local0.ChatClientFilterList, false)
		f286_local0.ChatClientFilterList:registerEventHandler("clear_recorded_pcinputfocus", function(element, event)
			local f288_local0 = element:getMenu()
			if element == f288_local0.currentInputFocus then
				f288_local0:ChangeInputFocus(event.controller, nil, false)
			end
		end)
	end)
end
CoD.PCWidgetUtility.ReportDropdownOptions = {
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_186F94CB724F2FB4"),
		value = 1,
		description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_C71757DD87707BC"),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4988B900B0DF0B83"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7A93EF7EF4B1AC05"),
		reason = Enum[@"reporttype"][@"hash_52FCEB963D858F6A"],
		source = Enum[@"reportsource"][@"hash_22CC5A4603BB6D6"],
		action = function(f289_arg0, f289_arg1) end,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/report_user_offensive_caps"),
		value = 2,
		description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2B804A7D12B045B3"),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6BF3C356602228DA"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"]("menu/reportplayer_offensive_language_reported"),
		reason = Enum[@"reporttype"][@"hash_DAF54FBD07FE70D"],
		source = Enum[@"reportsource"][@"hash_3DF74048DC41F55A"],
		action = function(f290_arg0, f290_arg1)
			local f290_local0 = Engine.GetModelForController(f290_arg0)
			CoD.MetricsUtility.ReportUser(f290_arg0, f290_arg1, "offensive", 1, true, f290_local0.ReportPlayerText:get())
		end,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](0x8D520440159326),
		value = 3,
		description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18BD0AD1B03A5766"),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F774FEAC5C1F55D"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_53E766BC24D20E27"),
		reason = -1,
		source = Enum[@"reportsource"][@"hash_3DF74048DC41F55A"],
		action = function(f291_arg0, f291_arg1)
			local f291_local0 = Engine.GetModelForController(f291_arg0)
			f291_local0 = f291_local0.ReportPlayerText:get()
			CoD.MetricsUtility.ReportUser(f291_arg0, f291_arg1, "greifer", 1, true)
		end,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/report_user_offensive_emblem_caps"),
		value = 4,
		description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_24D8434BEFFB6730"),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_768497C5E58F25BF"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"]("menu/reportplayer_offensive_emblem_reported"),
		reason = -1,
		source = Enum[@"reportsource"][@"hash_3DF74048DC41F55A"],
		action = function(f292_arg0, f292_arg1)
			local f292_local0 = Engine.GetModelForController(f292_arg0)
			CoD.MetricsUtility.ReportUser(f292_arg0, f292_arg1, "offensive_emblem", 1, true, f292_local0.ReportPlayerText:get())
		end,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/report_user_offensive_paintjob_caps"),
		value = 5,
		description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D69EE51ABD16407"),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5AB7F2F75ADF7E86"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"]("menu/reportplayer_offensive_paintjob_reported"),
		reason = -1,
		source = Enum[@"reportsource"][@"hash_3DF74048DC41F55A"],
		action = function(f293_arg0, f293_arg1)
			local f293_local0 = Engine.GetModelForController(f293_arg0)
			CoD.MetricsUtility.ReportUser(f293_arg0, f293_arg1, "offensive_paintjob", 1, true, f293_local0.ReportPlayerText:get())
		end,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/report_user_cheater_caps"),
		value = 6,
		description = Engine[@"hash_4F9F1239CFD921FE"](0xE3C15A99F65706),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_734B1B14D7769F7D"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"]("menu/reportplayer_cheating_reported"),
		reason = -1,
		source = Enum[@"reportsource"][@"hash_3DF74048DC41F55A"],
		action = function(f294_arg0, f294_arg1)
			Engine[@"hash_4752216AD625784A"](f294_arg0, f294_arg1)
			local f294_local0 = Engine.GetModelForController(f294_arg0)
			CoD.MetricsUtility.ReportUser(f294_arg0, f294_arg1, "cheater", 1, true, f294_local0.ReportPlayerText:get())
		end,
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"]("menu/report_user_booster_caps"),
		value = 7,
		description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1F85E8086F061446"),
		confirmation = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FBD108477DE79BD"),
		chatConfirmation = Engine[@"hash_4F9F1239CFD921FE"]("menu/reportplayer_booster_reported"),
		reason = -1,
		source = Enum[@"reportsource"][@"hash_3DF74048DC41F55A"],
		action = function(f295_arg0, f295_arg1)
			local f295_local0 = Engine.GetModelForController(f295_arg0)
			CoD.MetricsUtility.ReportUser(f295_arg0, f295_arg1, "booster", 1, true, f295_local0.ReportPlayerText:get())
		end,
	},
}
DataSources.ReportPlayerDropDownList = DataSourceHelpers.DropdownListSetup("PC.ReportPlayerDropDownList", CoD.PCWidgetUtility.ReportDropdownOptions)
DataSources.ReportPlayerDropDown = {
	getModel = function(f296_arg0)
		local f296_local0 = Engine.GetModelForController(f296_arg0)
		local f296_local1 = f296_local0.ReportPlayerDropDownList
		if not f296_local1 then
			f296_local1 = f296_local0:create("ReportPlayerDropDownList")
			local f296_local2 = f296_local1:create("name")
			f296_local2:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1625E26A2459D33B"))
			f296_local2 = f296_local1:create("optionsDataSource")
			f296_local2:set("ReportPlayerDropDownList")
			f296_local2 = f296_local1:create("isOpen")
			f296_local2:set(false)
			f296_local2 = f296_local1:create("currentValue")
			f296_local2:set(0)
		end
		return f296_local1
	end,
	getCurrentValue = function(f297_arg0, f297_arg1)
		local f297_local0 = DataSources.ReportPlayerDropDown.getModel(f297_arg1)
		return f297_local0.currentValue:get()
	end,
	setCurrentValue = function(f298_arg0, f298_arg1, f298_arg2)
		local f298_local0 = DataSources.ReportPlayerDropDown.getModel(f298_arg1)
		f298_local0.currentValue:set(f298_arg2)
	end,
	resetModel = function(f299_arg0)
		local f299_local0 = DataSources.ReportPlayerDropDown.getModel(f299_arg0)
		f299_local0.name:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1625E26A2459D33B"))
		f299_local0.currentValue:set(0)
	end,
}
CoD.PCWidgetUtility.ReportReasonToText = function(f300_arg0, f300_arg1)
	local f300_local0 = DataSources.ReportPlayerDropDown.getModel(f300_arg0)
	if f300_local0.currentValue:get() > 0 then
		local f300_local1 = CoD.PCWidgetUtility.ReportDropdownOptions
		local f300_local2 = f300_local0.currentValue
		return f300_local1[REG4:get()].name
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1625E26A2459D33B")
	end
end
CoD.PCWidgetUtility.ReportReasonToDescription = function(f301_arg0, f301_arg1)
	local f301_local0 = DataSources.ReportPlayerDropDown.getModel(f301_arg0)
	if f301_local0.currentValue:get() > 0 then
		local f301_local1 = CoD.PCWidgetUtility.ReportDropdownOptions
		local f301_local2 = f301_local0.currentValue
		return f301_local1[REG4:get()].description
	else
		return Engine[@"hash_4F9F1239CFD921FE"]("menu/report_player_desc")
	end
end
CoD.PCWidgetUtility.ReportReasonToConfirmation = function(f302_arg0, f302_arg1)
	local f302_local0 = DataSources.ReportPlayerDropDown.getModel(f302_arg0)
	if f302_local0.currentValue:get() > 0 then
		local f302_local1 = CoD.PCWidgetUtility.ReportDropdownOptions
		local f302_local2 = f302_local0.currentValue
		return f302_local1[REG4:get()].confirmation
	else
		return ""
	end
end
CoD.PCWidgetUtility.IsReportDefault = function(f303_arg0)
	local f303_local0 = DataSources.ReportPlayerDropDown.getModel(f303_arg0)
	return f303_local0.currentValue:get() == 0
end
CoD.PCWidgetUtility.PrepareReportPlayerDropdownProperties = function(f304_arg0, f304_arg1)
	f304_arg0._optionProperties = {}
	f304_arg0._optionProperties._options = CoD.PCWidgetUtility.ReportDropdownOptions
	f304_arg0._optionProperties._getCurrentValue = DataSources.ReportPlayerDropDown.getCurrentValue
	f304_arg0._optionProperties._setCurrentValue = DataSources.ReportPlayerDropDown.setCurrentValue
end
CoD.PCWidgetUtility.ResetReportModel = function(f305_arg0)
	DataSources.ReportPlayerDropDown.resetModel(f305_arg0)
end
CoD.PCWidgetUtility.SendReportPlayer = function(f306_arg0, f306_arg1)
	local f306_local0 = f306_arg0:getModel()
	f306_local0 = f306_local0.xuid:get()
	local f306_local1 = DataSources.ReportPlayerDropDown.getModel(f306_arg1)
	local f306_local2 = CoD.PCWidgetUtility.ReportDropdownOptions
	local f306_local3 = f306_local1.currentValue
	f306_local2 = f306_local2[f306_local4:get()].reason
	local f306_local4 = CoD.PCWidgetUtility.ReportDropdownOptions
	local f306_local5 = f306_local1.currentValue
	f306_local4 = f306_local4[f306_local3:get()].source
	f306_local3 = Engine.GetModelForController(f306_arg1)
	f306_local3 = f306_local3.ReportPlayerText:get()
	if CoD.MetricsUtility.NextReportTime <= Engine[@"milliseconds"]() and f306_local2 ~= -1 then
		Engine[@"hash_5310BF60E8E4712E"](f306_local0, f306_local2, f306_local4, f306_local3)
	end
	f306_local5 = CoD.PCWidgetUtility.ReportDropdownOptions
	local f306_local6 = f306_local1.currentValue
	f306_local5[f306_local7:get()].action(f306_arg1, f306_local0)
	f306_local5 = CoD.PCWidgetUtility.ReportDropdownOptions
	f306_local6 = f306_local1.currentValue
	if f306_local5[f306_local7:get()].chatConfirmation then
		f306_local5 = CoD.PCUtility.ShowGameEvent
		local f306_local7 = CoD.PCWidgetUtility.ReportDropdownOptions
		local f306_local8 = f306_local1.currentValue
		f306_local5(f306_local7[f306_local6:get()].chatConfirmation)
		f306_local5 = CoD.OverlayUtility.ShowToast
		f306_local7 = nil
		f306_local6 = CoD.PCWidgetUtility.ReportDropdownOptions
		local f306_local9 = f306_local1.currentValue
		f306_local5(f306_local7, f306_local6[f306_local8:get()].chatConfirmation)
	end
end
CoD.PCWidgetUtility.ResetReportPlayerText = function(f307_arg0)
	local f307_local0 = Engine.GetModelForController(f307_arg0)
	if f307_local0.ReportPlayerText:get() then
		local f307_local1 = Engine.GetModelForController(f307_arg0)
		f307_local1.ReportPlayerText:set("")
	end
end
CoD.PCWidgetUtility.ShowScoreboard = function(f308_arg0, f308_arg1, f308_arg2)
	f308_arg1:changeFrameWidget(CoD.TabbedScoreboardScores)
end
CoD.PCWidgetUtility.ShowMap = function(f309_arg0, f309_arg1, f309_arg2)
	f309_arg1:changeFrameWidget(CoD.ScoreboardGameStatus)
end
CoD.PCWidgetUtility.PrepareOpenButton = function(f310_arg0, f310_arg1, f310_arg2, f310_arg3, f310_arg4)
	if not f310_arg4 then
		return
	else
		local f310_local0 = f310_arg4.openMenuName:get()
		f310_arg3:AddButtonCallbackFunction(f310_arg1, f310_arg2, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f311_arg0, f311_arg1, f311_arg2, f311_arg3)
			if not f310_arg0._unavailable then
				PlaySoundSetSound(f310_arg0, "gain_focus")
				OpenOverlay(f311_arg1, f310_local0, f311_arg2)
			end
			return true
		end, function(f312_arg0, f312_arg1, f312_arg2)
			return false
		end, false)
		f310_arg3:AddButtonCallbackFunction(f310_arg0, f310_arg2, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f313_arg0, f313_arg1, f313_arg2, f313_arg3)
			if not f310_arg0._unavailable then
				PlaySoundSetSound(f310_arg0, "gain_focus")
				OpenOverlay(f313_arg1, f310_local0, f313_arg2)
			end
			return true
		end, function(f314_arg0, f314_arg1, f314_arg2)
			return false
		end, false)
	end
end
CoD.PCWidgetUtility.KeybindingsLayoutDropdownOptions = {
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_228175489C8141B6"),
		value = "default",
		image = "i_mtl_keypreset_default",
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6F19766D304A31AF"),
		value = "bo3",
		image = "i_mtl_keypreset_bo3",
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B84EDDAA5625C93"),
		value = "lefty",
		image = "i_mtl_keypreset_lefty",
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](0xB9797AB1FCB7D7),
		value = "watcher",
		image = "i_mtl_keypreset_overwatch",
	},
	{
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1CBC02A14B23EC17"),
		value = "defuser",
		image = "i_mtl_keypreset_lefty",
	},
}
DataSources.OptionControlKeyBindingsDropDownList = DataSourceHelpers.DropdownListSetup("PC.OptionControlKeyBindingsDropDownList", CoD.PCWidgetUtility.KeybindingsLayoutDropdownOptions)
DataSources.OptionControlKeyBindingsDropDown = {
	getModel = function(f315_arg0)
		local f315_local0 = Engine.GetModelForController(f315_arg0)
		local f315_local1 = f315_local0.OptionControlKeyBindingsDropDown
		if not f315_local1 then
			f315_local1 = f315_local0:create("OptionControlKeyBindingsDropDown")
			local f315_local2 = f315_local1:create("name")
			f315_local2:set(Engine[@"hash_4F9F1239CFD921FE"]("options/bindings_title"))
			f315_local2 = f315_local1:create("optionsDataSource")
			f315_local2:set("OptionControlKeyBindingsDropDownList")
			f315_local2 = f315_local1:create("isOpen")
			f315_local2:set(false)
			f315_local2 = f315_local1:create("text")
			f315_local2:set("")
			f315_local2 = f315_local1:create("image")
			f315_local2:set("")
			f315_local2 = f315_local1:create("presetId")
			f315_local2:set(1)
			f315_local2 = f315_local1:create("presetIsModified")
			f315_local2:set(false)
			f315_local2 = f315_local1:create("dropdownUpdated")
			f315_local2:set(false)
			f315_local2 = f315_local1:create("currentValue")
			f315_local2:set(DataSources.OptionControlKeyBindingsDropDown.getCurrentValue(nil, f315_arg0))
		end
		return f315_local1
	end,
	getCurrentValue = function(f316_arg0, f316_arg1)
		local f316_local0 = DataSources.OptionControlKeyBindingsDropDown.getModel(f316_arg1)
		local f316_local1 = f316_local0.presetId
		return CoD.PCWidgetUtility.KeybindingsLayoutDropdownOptions[f316_local0:get()].value
	end,
	setCurrentValue = function(f317_arg0, f317_arg1, f317_arg2)
		local f317_local0 = CoD.PCWidgetUtility.GetOptionIndexFromValue(CoD.PCWidgetUtility.KeybindingsLayoutDropdownOptions, f317_arg2)
		local f317_local1 = DataSources.OptionControlKeyBindingsDropDown.getModel(f317_arg1)
		local f317_local2
		if f317_local0 < 1 then
			f317_local2 = 1
			if not f317_local2 then
			else
				f317_local1.presetId:set(f317_local2)
				f317_local1.presetIsModified:set(false)
				f317_local1.dropdownUpdated:set(true)
				f317_local1.currentValue:set(DataSources.OptionControlKeyBindingsDropDown.getCurrentValue(nil, f317_arg1))
				CoD.PCWidgetUtility.UpdateKeyboardPresetColor(f317_local2)
			end
		end
		f317_local2 = f317_local0
	end,
}
CoD.PCWidgetUtility.KeybindPresetToText = function(f318_arg0, f318_arg1)
	local f318_local0 = f318_arg0
	local f318_local1 = f318_local0:getModel()
	if f318_local1.presetIsModified:get() then
		local f318_local2 = Engine[@"hash_4F9F1239CFD921FE"]
		local f318_local3 = @"hash_31F53D4B78955D1"
		local f318_local4 = f318_local0._optionProperties._options
		local f318_local5 = f318_local1.presetId
		return f318_local2(f318_local3, f318_local4[REG7:get()].name)
	else
		local f318_local2 = f318_local0._optionProperties._options
		local f318_local4 = f318_local1.presetId
		return f318_local2[f318_local3:get()].name
	end
end
CoD.PCWidgetUtility.PrepareOptionsKeysetBindingsDropdownProperties = function(f319_arg0, f319_arg1)
	f319_arg0._optionProperties = {}
	f319_arg0._optionProperties._options = CoD.PCWidgetUtility.KeybindingsLayoutDropdownOptions
	f319_arg0._optionProperties._valueUpdated = function(f320_arg0, f320_arg1)
		local f320_local0 = f320_arg0:getModel()
		if f320_local0 then
			f320_local0.presetId:set(CoD.PCWidgetUtility.GetOptionIndexFromValue(f320_arg0._optionProperties._options, f320_local0.currentValue:get()))
			local f320_local1 = f320_local0.image
			local f320_local2 = f320_local1
			f320_local1 = f320_local1.set
			local f320_local3 = f320_arg0._optionProperties._options
			local f320_local4 = f320_local0.presetId
			f320_local1(f320_local2, f320_local3[REG6:get()].image)
		end
	end
	f319_arg0._setModelToCurrentDvars = function(f321_arg0, f321_arg1, f321_arg2)
		local f321_local0 = f321_arg0:getModel()
		if f321_local0 then
			local f321_local1 = Dvar[@"hash_14EF8884606BD64C"]:get()
			if f321_local1 == 0 then
				f321_local1 = 1 or f321_local1
			end
			f321_local0.presetId:set(f321_local1)
			if f321_arg2 then
				f321_local0.presetIsModified:set(false)
			else
				f321_local0.presetIsModified:set(Dvar[@"hash_72B49C5C32022076"]:get())
			end
			f321_local0.dropdownUpdated:set(false)
			CoD.PCWidgetUtility.UpdateKeyboardPresetColor(f321_local1)
		end
	end
	f319_arg0:_setModelToCurrentDvars(f319_arg1, false)
	f319_arg0._applySelectedChanges = function(f322_arg0, f322_arg1)
		local f322_local0 = f322_arg0:getModel()
		if not f322_local0.dropdownUpdated:get() then
			return
		end
		local f322_local1 = f322_local0.presetId:get()
		if f322_local1 == 1 then
			ResetPCBindings(f322_arg0, f322_arg1)
		else
			LoadPCBindings(f322_arg0, f322_arg1, f322_arg0._optionProperties._options[f322_local1].value)
		end
		Dvar[@"hash_14EF8884606BD64C"]:set(f322_local1)
		Dvar[@"hash_72B49C5C32022076"]:set(f322_local0.presetIsModified:get())
		f322_local0.dropdownUpdated:set(false)
	end
	f319_arg0._optionProperties._getCurrentValue = DataSources.OptionControlKeyBindingsDropDown.getCurrentValue
	f319_arg0._optionProperties._setCurrentValue = DataSources.OptionControlKeyBindingsDropDown.setCurrentValue
end
CoD.PCWidgetUtility.ApplyOptionsKeysetBindingsDropdownProperties = function(f323_arg0, f323_arg1, f323_arg2)
	assert(f323_arg2)
	f323_arg2:_applySelectedChanges(f323_arg1)
end
CoD.PCWidgetUtility.DisplayApplyPresetConfirmationPopupAndGoToSettings = function(f324_arg0, f324_arg1, f324_arg2)
	assert(f324_arg2)
	if Dvar[@"hash_72B49C5C32022076"]:get() then
		local f324_local0 = f324_arg2:getModel()
		if not f324_local0.dropdownUpdated:get() then
			CoD.PCWidgetUtility.GoBackAndOpenSettingsMenuOnTabId(f324_arg0, f324_arg1, 1, CoD.PCWidgetUtility.PCKeybindingsTabId)
		else
			CoD.OverlayUtility.CreateOverlay(f324_arg1, f324_arg0, "ApplyPresetConfirmation", {
				_dropdown = f324_arg2,
				_multipleGoBackOnApply = false,
				_resetDropdownOnCancel = false,
				_goToSettingsAfter = true,
			})
		end
	else
		CoD.PCWidgetUtility.ApplyOptionsKeysetBindingsDropdownProperties(f324_arg0, f324_arg1, f324_arg2)
		CoD.PCWidgetUtility.GoBackAndOpenSettingsMenuOnTabId(f324_arg0, f324_arg1, 1, CoD.PCWidgetUtility.PCKeybindingsTabId)
	end
end
CoD.PCWidgetUtility.DisplayApplyPresetConfirmationPopup = function(f325_arg0, f325_arg1, f325_arg2, f325_arg3, f325_arg4)
	assert(f325_arg2)
	if Dvar[@"hash_72B49C5C32022076"]:get() then
		local f325_local0 = f325_arg2:getModel()
		if not f325_local0.dropdownUpdated:get() then
			GoBack(f325_arg0, f325_arg1)
		else
			CoD.OverlayUtility.CreateOverlay(f325_arg1, f325_arg0, "ApplyPresetConfirmation", {
				_dropdown = f325_arg2,
				_multipleGoBackOnApply = f325_arg3,
				_resetDropdownOnCancel = f325_arg4,
				_goToSettingsAfter = false,
			})
		end
	else
		CoD.PCWidgetUtility.ApplyOnDropdownConfirmationPopup(f325_arg0, f325_arg1, f325_arg2, false)
	end
end
CoD.PCWidgetUtility.ResetOptionsKeysetBindingsDropdownToDvars = function(f326_arg0, f326_arg1, f326_arg2, f326_arg3)
	assert(f326_arg2)
	f326_arg2:_setModelToCurrentDvars(f326_arg1, f326_arg3)
end
CoD.PCWidgetUtility.ApplyOnDropdownConfirmationPopup = function(f327_arg0, f327_arg1, f327_arg2, f327_arg3)
	CoD.PCWidgetUtility.ApplyOptionsKeysetBindingsDropdownProperties(f327_arg0, f327_arg1, f327_arg2)
	if f327_arg3 then
		GoBackMultiple(f327_arg0, f327_arg1, 2)
	else
		GoBack(f327_arg0, f327_arg1)
	end
end
CoD.PCWidgetUtility.PrepareOptionDescriptionPanel = function(f328_arg0, f328_arg1)
	assert(f328_arg0.DescriptionTextBox ~= nil)
	assert(f328_arg0.DescriptionTextBox.detailedDescription ~= nil)
	assert(f328_arg0.DescriptionImage ~= nil)
	local f328_local0 = 28
	LUI.OverrideFunction_CallOriginalFirst(f328_arg0.DescriptionTextBox.detailedDescription, "setText", function(element, controller)
		local f329_local0, f329_local1, f329_local2, f329_local3 = element:getLocalRect()
		local f329_local4 = element:getTextHeightForWidth(f329_local2 - f329_local0)
		local f329_local5, f329_local6, f329_local7, f329_local8 = f328_arg0.DescriptionImage:getLocalTopBottom()
		local f329_local9 = f328_arg0:getModel()
		local f329_local10 = f328_arg0:getModel()
		f329_local10 = f329_local9 and f329_local10.image or nil
		local f329_local11 = f329_local1 + f329_local4 + (element._backingYPadding and 2 * element._backingYPadding or 0)
		f328_arg0.DescriptionTextBox:setHeight(f329_local11)
		local f329_local12 = f329_local11 + f328_local0
		if f329_local10 then
			local f329_local13 = f329_local10:get()
			local f329_local14 = f329_local8 - f329_local7
		end
		f328_arg0:setHeight(f329_local12 + (f329_local13 and f329_local14 or 0))
	end)
end
CoD.PCWidgetUtility.UpdateKeyboardPresetColor = function(f330_arg0)
	CoD.PCWidgetUtility.ResetAllKeysColor()
	if f330_arg0 <= #CoD.PCWidgetUtility.PresetKeyColors then
		for f330_local3, f330_local4 in pairs(CoD.PCWidgetUtility.PresetKeyColors[f330_arg0]) do
			CoD.PCWidgetUtility.SetKeyColor(f330_local3, f330_local4)
		end
	end
end
CoD.PCWidgetUtility.PrepareFastLoadoutContainer = function(f331_arg0, f331_arg1, f331_arg2, f331_arg3)
	f331_arg0.showNotify = true
	local f331_local0 = function(f332_arg0, f332_arg1)
		if CoD.isPC then
			f331_arg2:_selectClassId(f332_arg0, f332_arg1)
			if f331_arg0.closeFastLoadoutTimer then
				f331_arg0.closeFastLoadoutTimer:reset()
			else
				f331_arg0.closeFastLoadoutTimer = LUI.UITimer.new(1600, {
					name = "close_fast_loadout",
					classId = f332_arg1,
				}, true, f331_arg0)
				f331_arg0:addElement(f331_arg0.closeFastLoadoutTimer)
			end
		end
	end
	local f331_local1 = f331_arg0
	local f331_local2 = f331_arg0.subscribeToModel
	local f331_local3 = Engine.GetModelForController(f331_arg1)
	f331_local2(f331_local1, f331_local3.engineLoadoutSelect, function(f333_arg0)
		local modelValue = Engine.GetModelValue(f333_arg0)
		local f333_local1 = Engine.GetModel(Engine.GetModelForController(f331_arg1), "PositionDraft.stage")
		if not f333_local1:get() ~= CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_NONE and not CoD.BountyHunterUtility.GameTypeIsBounty(f331_arg1) then
			f331_local0(f331_arg1, modelValue)
		end
	end, false)
	f331_arg0:registerEventHandler("close_fast_loadout", function(element, event)
		f331_arg2:_closeFastLoadout(f331_arg1)
		if element.closeFastLoadoutTimer then
			element.closeFastLoadoutTimer:close()
			element.closeFastLoadoutTimer = nil
		end
	end)
end
CoD.PCWidgetUtility.CanShowChat = function()
	return CoD.isPC
end
CoD.PCWidgetUtility.CloseChat = function(f336_arg0, f336_arg1)
	f336_arg0:ChangeInputFocus(f336_arg1, nil)
	local f336_local0 = CoD.ChatClientUtility.GetCurrentChattingModel(f336_arg1)
	f336_local0:set(false)
end
CoD.PCWidgetUtility.PrepareFastLoadoutTinyNumbersList = function(f337_arg0, f337_arg1, f337_arg2, f337_arg3)
	f337_arg0.isOpen = false
	f337_arg0._openFastLoadout = function(f338_arg0, f338_arg1)
		f338_arg0.isOpen = true
		UpdateSelfState(f338_arg0, f338_arg1)
		if f338_arg0:hasClip("OpenFastLoadout") then
			f338_arg0:playClip("OpenFastLoadout")
		end
	end
	f337_arg0._selectClassId = function(f339_arg0, f339_arg1, f339_arg2)
		if not f339_arg0.isOpen then
			f339_arg0:_openFastLoadout(f339_arg1)
		end
		local f339_local0 = f337_arg3:getItemAtPosition(1, f339_arg2 + 1, false)
		if f339_local0 ~= nil then
			LUI.GridLayout.setActiveItem(f337_arg3, f339_local0, nil)
		end
	end
	f337_arg0._closeFastLoadout = function(f340_arg0, f340_arg1)
		f340_arg0.isOpen = false
		if f340_arg0:hasClip("CloseFastLoadout") then
			f340_arg0:playClip("CloseFastLoadout")
		end
	end
end
CoD.PCWidgetUtility.SetDvarBool = function(f341_arg0, f341_arg1, f341_arg2, f341_arg3)
	Dvar[f341_arg2]:set(f341_arg3)
end
CoD.PCWidgetUtility.KeyboardColor = function(f342_arg0, f342_arg1)
	Engine[@"hash_67CDF15507B69734"](f342_arg0, f342_arg1)
end
CoD.PCWidgetUtility.KeyboardFadeColor = function(f343_arg0, f343_arg1, f343_arg2, f343_arg3)
	Engine[@"hash_1AAB4482CC62F5C6"](f343_arg0, f343_arg1, f343_arg2, f343_arg3)
end
CoD.PCWidgetUtility.KeyboardBlinkColor = function(f344_arg0, f344_arg1, f344_arg2, f344_arg3, f344_arg4)
	Engine[@"hash_1675F017817C9C7D"](f344_arg0, f344_arg1, f344_arg2, f344_arg3, f344_arg4)
end
CoD.PCWidgetUtility.KeyboardPulseColor = function(f345_arg0, f345_arg1, f345_arg2, f345_arg3, f345_arg4, f345_arg5)
	Engine[@"hash_4838F9E94E55E4CA"](f345_arg0, f345_arg1, f345_arg2, f345_arg3, f345_arg4, f345_arg5)
end
CoD.PCWidgetUtility.KeyboardColorReset = function(f346_arg0)
	Engine[@"hash_3117D8D649C9A0FC"](f346_arg0)
end
CoD.PCWidgetUtility.SetKeyColor = function(f347_arg0, f347_arg1)
	Engine[@"hash_598D45A2A00D1381"](f347_arg0, f347_arg1)
end
CoD.PCWidgetUtility.SetKeyFadeColor = function(f348_arg0, f348_arg1, f348_arg2, f348_arg3)
	Engine[@"hash_66DCD06D981B8B3F"](f348_arg0, f348_arg1, f348_arg2, f348_arg3)
end
CoD.PCWidgetUtility.SetKeyBlinkColor = function(f349_arg0, f349_arg1, f349_arg2, f349_arg3, f349_arg4)
	Engine[@"hash_1408F665FA8CF244"](f349_arg0, f349_arg1, f349_arg2, f349_arg3, f349_arg4)
end
CoD.PCWidgetUtility.SetKeyPulseColor = function(f350_arg0, f350_arg1, f350_arg2, f350_arg3, f350_arg4, f350_arg5)
	Engine[@"hash_2BF005CAA3F45ABF"](f350_arg0, f350_arg1, f350_arg2, f350_arg3, f350_arg4, f350_arg5)
end
CoD.PCWidgetUtility.ResetKeyColor = function(f351_arg0)
	Engine[@"hash_6617BD4E27764ADB"](f351_arg0)
end
CoD.PCWidgetUtility.ResetAllKeysColor = function()
	Engine[@"hash_1955A84E44475EF7"]()
end
CoD.PCWidgetUtility.DefaultKeyboardPulseColor = function()
	Engine[@"hash_4838F9E94E55E4CA"](0, "0x0021fa", "2500", "750", "750", "0")
end
CoD.PCWidgetUtility.OpenPreviewKeybindsPopup = function(f354_arg0, f354_arg1, f354_arg2)
	OpenOverlay(f354_arg0, "StartMenu_Options_Controls_PreviewKeybindings", f354_arg1, {
		_parentMenuId = f354_arg2,
	})
end
CoD.PCWidgetUtility.GoBackAndOpenSettingsMenuOnTabId = function(f355_arg0, f355_arg1, f355_arg2, f355_arg3)
	local f355_local0 = GoBackMultiple(f355_arg0, f355_arg1, f355_arg2)
	f355_local0:openOverlay("PC_StartMenu_Options_New", f355_arg1, {
		_tabIdToOpen = f355_arg3,
	})
end
CoD.PCWidgetUtility.SetupEmptyFocusableTooltip = function(f356_arg0, f356_arg1, f356_arg2, f356_arg3)
	local f356_local0 = Engine.CreateModel(Engine.GetModelForController(f356_arg1), "EmptyFocusableTooltip")
	Engine.SetModelValue(Engine.CreateModel(f356_local0, "name"), 0x0)
	Engine.SetModelValue(Engine.CreateModel(f356_local0, "detailedDescription"), Engine.Localize(0x0))
	Engine.SetModelValue(Engine.CreateModel(f356_local0, "tooltipArchetype"), CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE)
	f356_arg0:setModel(f356_local0, f356_arg1)
	f356_arg0:registerEventHandler("gain_focus", function(element, event)
		local f357_local0 = nil
		if element.gainFocus then
			f357_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f357_local0 = element.super:gainFocus(event)
		end
		Engine.SetModelValue(Engine.CreateModel(f356_local0, "name"), f356_arg2)
		Engine.SetModelValue(Engine.CreateModel(f356_local0, "detailedDescription"), Engine.Localize(f356_arg3))
		return f357_local0
	end)
	f356_arg0:registerEventHandler("lose_focus", function(element, event)
		local f358_local0 = nil
		if element.loseFocus then
			f358_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f358_local0 = element.super:loseFocus(event)
		end
		Engine.SetModelValue(Engine.CreateModel(f356_local0, "name"), 0x0)
		Engine.SetModelValue(Engine.CreateModel(f356_local0, "detailedDescription"), Engine.Localize(0x0))
		return f358_local0
	end)
end
CoD.PCWidgetUtility.SetStateOnVideoViewerParent = function(f359_arg0, f359_arg1, f359_arg2, f359_arg3)
	local f359_local0 = f359_arg0:getParent()
	if IsElementInState(f359_local0, f359_arg3) then
		SetState(f359_local0, f359_arg2, f359_arg1)
	elseif IsElementInState(f359_local0, f359_arg2) then
		SetState(f359_local0, f359_arg3, f359_arg1)
	end
end
CoD.PCWidgetUtility.SetupDefaultFocusDirectorPublicIfBountyMode = function(f360_arg0)
	f360_arg0.__defaultFocus = f360_arg0.HomeOrPlayListPC
end
CoD.PCWidgetUtility.EnableShrinkToFit = function(f361_arg0)
	f361_arg0:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
end
