require("x64:45c3699dabd929")
require("x64:5f74ee71e1ed6da")
require("x64:22dd5a83b46fd96")
require("x64:4dcb98330709b44")
CoD.MatchStartWarningContainer = InheritFrom(LUI.UIElement)
CoD.MatchStartWarningContainer.__defaultWidth = 300
CoD.MatchStartWarningContainer.__defaultHeight = 75
CoD.MatchStartWarningContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MatchStartWarningContainer)
	self.id = "MatchStartWarningContainer"
	self.soundSet = "default"
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0.01, 0.01, 0.01)
	background:setAlpha(0)
	self:addElement(background)
	self.background = background
	local BorderBakedSolid0 = CoD.BorderBakedSolid.new(f1_arg0, f1_arg1, 0, 1, -2, 2, 0, 1, -2, 2)
	BorderBakedSolid0:setAlpha(0)
	self:addElement(BorderBakedSolid0)
	self.BorderBakedSolid0 = BorderBakedSolid0
	local text = CoD.ArabicAlignTextBox.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 87.5, 120.5)
	text:setScale(0.6, 0.6)
	text.textBox:setText(LocalizeToUpperString(@"hash_1CCD3E1733C2481E"))
	text.textBox:setTTF("ttmussels_regular")
	self:addElement(text)
	self.text = text
	local timerBackground = LUI.UIImage.new(0, 0, 112, 187, 0, 0, 36, 69)
	timerBackground:setRGB(0.37, 0.1, 0)
	timerBackground:setAlpha(0)
	self:addElement(timerBackground)
	self.timerBackground = timerBackground
	local BorderBakedSolid00 = CoD.BorderBakedSolid.new(f1_arg0, f1_arg1, 0.5, 0.5, -40.5, 40.5, 0, 0, 33, 72)
	BorderBakedSolid00:setRGB(1, 0, 0)
	BorderBakedSolid00:setAlpha(0)
	self:addElement(BorderBakedSolid00)
	self.BorderBakedSolid00 = BorderBakedSolid00
	local MatchStartWarningTimerBkgd = CoD.MatchStartWarning_TimerBkgd.new(f1_arg0, f1_arg1, 0.5, 0.5, -37.5, 37.5, 0, 0, 36, 69)
	MatchStartWarningTimerBkgd:setRGB(1, 0, 0)
	MatchStartWarningTimerBkgd:setAlpha(0)
	self:addElement(MatchStartWarningTimerBkgd)
	self.MatchStartWarningTimerBkgd = MatchStartWarningTimerBkgd
	local BorderBakedSolid000 = CoD.BorderBakedSolid.new(f1_arg0, f1_arg1, 0.5, 0.5, -40.5, 40.5, 0, 0, 33, 72)
	BorderBakedSolid000:setRGB(1, 0, 0)
	BorderBakedSolid000:setAlpha(0)
	self:addElement(BorderBakedSolid000)
	self.BorderBakedSolid000 = BorderBakedSolid000
	local RadialTimer = CoD.MatchstartRadialTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	RadialTimer.Clock:setShaderVector(0, SetVectorComponent(0, 0, 1, 0.1, 0, 0))
	self:addElement(RadialTimer)
	self.RadialTimer = RadialTimer
	local Base = LUI.UIImage.new(0.5, 0.5, -55.5, 55.5, 0.5, 0.5, -55.5, 55.5)
	Base:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	Base:setAlpha(0.3)
	Base:setImage(RegisterImage(@"uie_ui_hud_common_draft_timer_backer"))
	self:addElement(Base)
	self.Base = Base
	local timerText = CoD.ArabicAlignTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0.5, 0.5, -16.5, 16.5)
	timerText.textBox:setTTF("ttmussels_demibold")
	timerText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTimeRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			timerText.textBox:setText(CoD.DirectorUtility.TimeRemainingForMatchStart(f2_local0))
		end
	end)
	self:addElement(timerText)
	self.timerText = timerText
	local Frame = LUI.UIImage.new(0.5, 0.5, -69, 69, 0.5, 0.5, -69, 69)
	Frame:setImage(RegisterImage(@"uie_ui_menu_popups_matchstart_circularframe"))
	self:addElement(Frame)
	self.Frame = Frame
	local BoxL = LUI.UIImage.new(0, 0, 95.5, 96.5, 0, 0, 39.5, 40.5)
	self:addElement(BoxL)
	self.BoxL = BoxL
	local BoxR = LUI.UIImage.new(0, 0, 204.5, 205.5, 0, 0, 39.5, 40.5)
	self:addElement(BoxR)
	self.BoxR = BoxR
	local StrokeR = LUI.UIImage.new(0, 0, 208, 300, 0, 0, 39.5, 40.5)
	self:addElement(StrokeR)
	self.StrokeR = StrokeR
	local StrokeL = LUI.UIImage.new(0, 0, 0, 92, 0, 0, 39.5, 40.5)
	self:addElement(StrokeL)
	self.StrokeL = StrokeL
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MatchStartWarningContainer.__onClose = function(f3_arg0)
	f3_arg0.BorderBakedSolid0:close()
	f3_arg0.text:close()
	f3_arg0.BorderBakedSolid00:close()
	f3_arg0.MatchStartWarningTimerBkgd:close()
	f3_arg0.BorderBakedSolid000:close()
	f3_arg0.RadialTimer:close()
	f3_arg0.timerText:close()
end
