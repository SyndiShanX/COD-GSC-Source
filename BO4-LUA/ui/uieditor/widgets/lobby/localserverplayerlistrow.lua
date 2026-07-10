require("x64:960383123cd2d0b")
require("x64:a9255c570c68aa8")
CoD.LocalServerPlayerListRow = InheritFrom(LUI.UIElement)
CoD.LocalServerPlayerListRow.__defaultWidth = 250
CoD.LocalServerPlayerListRow.__defaultHeight = 40
CoD.LocalServerPlayerListRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LocalServerPlayerListRow)
	self.id = "LocalServerPlayerListRow"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 1.02, 0, -4, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.08)
	self:addElement(Background)
	self.Background = Background
	local Gamertag = LUI.UIText.new(0, 0, 28, 330, 0.5, 0.5, -10, 10)
	Gamertag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Gamertag:setTTF("notosans_regular")
	Gamertag:setLetterSpacing(1)
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	local LobbyLeaderIcon = CoD.LobbyLeaderIcon.new(f1_arg0, f1_arg1, 0, 0, 4, 26, 0, 0, 9, 31)
	self:addElement(LobbyLeaderIcon)
	self.LobbyLeaderIcon = LobbyLeaderIcon
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 0, 40)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.02)
	self:addElement(Frame)
	self.Frame = Frame
	self.Gamertag:linkToElementModel(self, "gamertag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Gamertag:setText(f2_local0)
		end
	end)
	self.LobbyLeaderIcon:linkToElementModel(self, "isLeader", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LobbyLeaderIcon:setAlpha(f3_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LocalServerPlayerListRow.__onClose = function(f4_arg0)
	f4_arg0.Gamertag:close()
	f4_arg0.LobbyLeaderIcon:close()
	f4_arg0.Frame:close()
end
