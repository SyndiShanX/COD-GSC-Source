require("x64:25a577ad356c4")
require("x64:f3c88d193f18ae2")
local PostLoadFunc = function(self, controller, menu)
	local f1_local0 = Engine[@"getgametypeinfo"](Engine[@"lobbygetgametype"]())
	local f1_local1 = f1_local0.image
	local f1_local2 = f1_local0.nameRefCaps
	local f1_local3 = f1_local0.descriptionRef
	self.image:setImage(RegisterImage(f1_local1))
	local f1_local4 = self.GameSettingstexbox.TextBox
	local f1_local5 = f1_local4
	f1_local4 = f1_local4.setText
	local f1_local6
	if f1_local3 then
		f1_local6 = Engine[@"hash_4F9F1239CFD921FE"](f1_local3)
		if not f1_local6 then
		else
			f1_local4(f1_local5, f1_local6)
			f1_local4 = self.GameSettingstitlesecbox.Textbox
			f1_local5 = f1_local4
			f1_local4 = f1_local4.setText
			if f1_local2 then
				f1_local6 = Engine[@"hash_4F9F1239CFD921FE"](f1_local2)
				if not f1_local6 then
				else
					f1_local4(f1_local5, f1_local6)
				end
			end
			f1_local6 = ""
		end
	end
	f1_local6 = ""
end
CoD.GameSettings_MatchSettingsInfo = InheritFrom(LUI.UIElement)
CoD.GameSettings_MatchSettingsInfo.__defaultWidth = 674
CoD.GameSettings_MatchSettingsInfo.__defaultHeight = 115
CoD.GameSettings_MatchSettingsInfo.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.GameSettings_MatchSettingsInfo)
	self.id = "GameSettings_MatchSettingsInfo"
	self.soundSet = "default"
	local image = LUI.UIImage.new(0, 0, 0, 115, 1, 1, -115, 0)
	image:setImage(RegisterImage(@"playlist_war"))
	self:addElement(image)
	self.image = image
	local GameSettingstitlesecbox = CoD.GameSettings_titlesecbox.new(f2_arg0, f2_arg1, 1, 1, -549, 0, 0, 0, 0, 42)
	GameSettingstitlesecbox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameSettingstitlesecbox:subscribeToGlobalModel(f2_arg1, "GametypeSettings", "gametype", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameSettingstitlesecbox.Textbox:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(GameSettingstitlesecbox)
	self.GameSettingstitlesecbox = GameSettingstitlesecbox
	local GameSettingstexbox = CoD.GameSettings_texbox.new(f2_arg0, f2_arg1, 1, 1, -549, 0, 0, 0, 42, 115)
	GameSettingstexbox.TextBox:setAlpha(0.15)
	GameSettingstexbox.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_750499BB4CC7AF75"))
	self:addElement(GameSettingstexbox)
	self.GameSettingstexbox = GameSettingstexbox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	return self
end
CoD.GameSettings_MatchSettingsInfo.__onClose = function(f4_arg0)
	f4_arg0.GameSettingstitlesecbox:close()
	f4_arg0.GameSettingstexbox:close()
end
