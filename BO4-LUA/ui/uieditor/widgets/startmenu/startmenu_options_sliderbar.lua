require("ui/uieditor/widgets/lobby/common/fe_focusbarcontainer")
require("ui/uieditor/widgets/lobby/common/fe_titlenumbrdr")
require("ui/uieditor/widgets/startmenu/startmenu_frame_nobg")
require("ui/uieditor/widgets/startmenu/startmenu_options_sliderbar_bar")
local f0_local0 = function(f1_arg0, f1_arg1)
	local f1_local0, f1_local1, f1_local2, f1_local3 = f1_arg0.FilledPartBg:getRect()
	local f1_local4 = f1_local2 - f1_local0
	f1_arg0:processEvent({
		name = "slider_updated",
		fraction = CoD.ColorUtility.ClampColor(f1_arg1.x - f1_local0, 0, f1_local4) / f1_local4,
		controller = f1_arg1.controller,
	})
end
local f0_local1 = function(f2_arg0)
	local f2_local0, f2_local1, f2_local2, f2_local3 = f2_arg0.FilledPartBg:getLocalRect()
	local f2_local4 = f2_arg0.m_fraction * (f2_local2 - f2_local0)
	local f2_local5 = string.format(f2_arg0.m_formatString, f2_arg0.m_currentValue)
	if f2_local5 == string.format(f2_arg0.m_formatString, -0) then
		f2_local5 = string.format(f2_arg0.m_formatString, -0)
	end
	f2_arg0.numeric:setText(f2_local5)
	f2_arg0.Bar:setLeftRight(true, false, f2_local0 + f2_local4 - f2_arg0.m_markerHalfWidth, f2_local0 + f2_local4 + f2_arg0.m_markerHalfWidth)
	f2_arg0.FilledPart:setLeftRight(true, false, f2_local0, f2_local0 + f2_local4)
end
local PostLoadFunc = function(self, controller, menu)
	self.m_forceMouseEventDispatch = true
	local f3_local0, f3_local1, f3_local2, f3_local3 = self.Bar:getLocalRect()
	self.m_markerHalfWidth = (f3_local2 - f3_local0) / 2
	self.m_formatString = "%.2f"
	self.m_speedMaxMultiplier = 25
	self.m_ownerController = controller
	self:registerEventHandler("options_refresh", function(element, event)
		if type(element.sliderRefresh) == "function" then
			element.sliderRefresh(controller, element)
			f0_local1(element)
		end
	end)
	self:registerEventHandler("slider_updated", function(element, event)
		if type(element.sliderUpdated) == "function" then
			element.sliderUpdated(controller, element, event.fraction)
			f0_local1(element)
		end
	end)
	self:registerEventHandler("update_bar", function(element, event)
		local f6_local0 = element.m_slideDirection
		local f6_local1 = element.m_fraction
		local f6_local2 = element.m_currentSpeed
		if f6_local0 then
			element:processEvent({
				name = "slider_updated",
				fraction = CoD.ColorUtility.ClampColor(f6_local1 + f6_local2 * f6_local0 * event.timeElapsed / 1000, 0, 1),
				controller = element.m_ownerController,
			})
		end
	end)
	self.updateSlideDirection = function(f7_arg0, f7_arg1)
		f7_arg0.m_slideDirection = f7_arg1
	end
	self:registerEventHandler("lose_focus", function(element, event)
		element:updateSlideDirection(nil)
		element.m_timer:close()
	end)
	self:registerEventHandler("check_pulse", function(element, event)
		if self.m_beat then
			self.m_timer:close()
			self.m_heartbeat:close()
			self.m_beat = nil
		end
	end)
	self.m_timer = LUI.UITimer.new(1, "update_bar", false)
	self.m_heartbeat = LUI.UITimer.new(100, "check_pulse", false)
	CoD.Menu.AddButtonCallbackFunction(menu, self, controller, Enum.LUIButton[@"lui_key_left"], "ui_navleft", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		if not self.m_disableNavigation then
			if not self.m_beat then
				self:updateSlideDirection(-1)
				self:addElement(self.m_timer)
				self.m_currentSpeed = self.m_sliderSpeed
				self.m_speedMax = self.m_sliderSpeed * self.m_speedMaxMultiplier
				self.m_beat = true
				self:addElement(self.m_heartbeat)
			else
				self.m_heartbeat:reset()
				self.m_currentSpeed = math.min(self.m_currentSpeed * 1.1, self.m_speedMax)
			end
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(menu, self, controller, Enum.LUIButton[@"lui_key_right"], "ui_navright", function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if not self.m_disableNavigation then
			if not self.m_beat then
				self:updateSlideDirection(1)
				self:addElement(self.m_timer)
				self.m_currentSpeed = self.m_sliderSpeed
				self.m_speedMax = self.m_sliderSpeed * self.m_speedMaxMultiplier
				self.m_beat = true
				self:addElement(self.m_heartbeat)
			else
				self.m_heartbeat:reset()
				self.m_currentSpeed = math.min(self.m_currentSpeed * 1.1, self.m_speedMax)
			end
		end
	end)
end
CoD.StartMenu_Options_SliderBar = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SliderBar.__defaultWidth = 750
CoD.StartMenu_Options_SliderBar.__defaultHeight = 60
CoD.StartMenu_Options_SliderBar.new = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4, f12_arg5, f12_arg6, f12_arg7, f12_arg8, f12_arg9)
	local self = LUI.UIElement.new(f12_arg2, f12_arg3, f12_arg4, f12_arg5, f12_arg6, f12_arg7, f12_arg8, f12_arg9)
	self:setClass(CoD.StartMenu_Options_SliderBar)
	self.id = "StartMenu_Options_SliderBar"
	self.soundSet = "ChooseDecal"
	f12_arg0:addElementToPendingUpdateStateList(self)
	local fullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullBacking:setRGB(0.1, 0.1, 0.1)
	fullBacking:setAlpha(0)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local frameOutline = CoD.StartMenu_frame_noBG.new(f12_arg0, f12_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	frameOutline:setRGB(0.87, 0.37, 0)
	frameOutline:setAlpha(0)
	self:addElement(frameOutline)
	self.frameOutline = frameOutline
	local label = LUI.UIText.new(0, 0, 12, 352, 0, 0, 8, 46)
	label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	label:setTTF("default")
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(label)
	self.label = label
	local numeric = LUI.UIText.new(0, 0, 679, 741, 0, 0, 8, 46)
	numeric:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	numeric:setTTF("default")
	numeric:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(numeric)
	self.numeric = numeric
	local FilledPartBg = LUI.UIImage.new(0, 0, 382, 652, 0.5, 0.5, -1, 1)
	FilledPartBg:setRGB(0.55, 0.55, 0.55)
	FilledPartBg:setAlpha(0)
	self:addElement(FilledPartBg)
	self.FilledPartBg = FilledPartBg
	local FilledPart = LUI.UIImage.new(0, 0, 385, 568, 0.5, 0.5, -3.5, 3.5)
	FilledPart:setRGB(0.87, 0.37, 0)
	self:addElement(FilledPart)
	self.FilledPart = FilledPart
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f12_arg0, f12_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local FocusBarT = CoD.FE_FocusBarContainer.new(f12_arg0, f12_arg1, 0, 1, 0, 0, 0, 0, 0, 6)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local FocusBarB = CoD.FE_FocusBarContainer.new(f12_arg0, f12_arg1, 0, 1, 0, 0, 1, 1, -8, 0)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	local FETitleNumBrdr0 = CoD.FE_TitleNumBrdr.new(f12_arg0, f12_arg1, 0, 1, 379, -91, 0, 1, 23, -23)
	self:addElement(FETitleNumBrdr0)
	self.FETitleNumBrdr0 = FETitleNumBrdr0
	local Bar = CoD.StartMenu_Options_SliderBar_Bar.new(f12_arg0, f12_arg1, 0, 0, 567.5, 576.5, 0.5, 0.5, -16, 16)
	self:addElement(Bar)
	self.Bar = Bar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f12_arg1, f12_arg0)
	end
	return self
end
CoD.StartMenu_Options_SliderBar.__resetProperties = function(f13_arg0)
	f13_arg0.FilledPart:completeAnimation()
	f13_arg0.numeric:completeAnimation()
	f13_arg0.frameOutline:completeAnimation()
	f13_arg0.FocusBarT:completeAnimation()
	f13_arg0.FocusBarB:completeAnimation()
	f13_arg0.Bar:completeAnimation()
	f13_arg0.FilledPart:setRGB(0.87, 0.37, 0)
	f13_arg0.numeric:setAlpha(1)
	f13_arg0.frameOutline:setAlpha(0)
	f13_arg0.FocusBarT:setLeftRight(0, 1, 0, 0)
	f13_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
	f13_arg0.FocusBarT:setAlpha(0)
	f13_arg0.FocusBarB:setAlpha(0)
	f13_arg0.Bar:setRGB(1, 1, 1)
end
CoD.StartMenu_Options_SliderBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.numeric:completeAnimation()
			f14_arg0.numeric:setAlpha(0.5)
			f14_arg0.clipFinished(f14_arg0.numeric)
			f14_arg0.FilledPart:completeAnimation()
			f14_arg0.FilledPart:setRGB(1, 1, 1)
			f14_arg0.clipFinished(f14_arg0.FilledPart)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.frameOutline:completeAnimation()
			f15_arg0.frameOutline:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.frameOutline)
			f15_arg0.FocusBarT:completeAnimation()
			f15_arg0.FocusBarT:setLeftRight(0, 1, 0, 0)
			f15_arg0.FocusBarT:setTopBottom(0, 0, 0, 8)
			f15_arg0.FocusBarT:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBarT)
			f15_arg0.FocusBarB:completeAnimation()
			f15_arg0.FocusBarB:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBarB)
			f15_arg0.Bar:completeAnimation()
			f15_arg0.Bar:setRGB(0.87, 0.37, 0)
			f15_arg0.clipFinished(f15_arg0.Bar)
		end,
	},
}
CoD.StartMenu_Options_SliderBar.__onClose = function(f16_arg0)
	f16_arg0.frameOutline:close()
	f16_arg0.StartMenuframenoBG00:close()
	f16_arg0.FocusBarT:close()
	f16_arg0.FocusBarB:close()
	f16_arg0.FETitleNumBrdr0:close()
	f16_arg0.Bar:close()
end
