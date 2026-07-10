require("x64:93a575a7ca17e04")
CoD.HealthBoostPlayerListWidget = InheritFrom(LUI.UIElement)
CoD.HealthBoostPlayerListWidget.__defaultWidth = 175
CoD.HealthBoostPlayerListWidget.__defaultHeight = 190
CoD.HealthBoostPlayerListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBoostPlayerListWidget)
	self.id = "HealthBoostPlayerListWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0.16, 0.16, 0.16)
	self:addElement(bg)
	self.bg = bg
	local PlayerImage = LUI.UIImage.new(0, 0, 0, 175, 0, 0, 0, 127)
	PlayerImage:linkToElementModel(self, "characterIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerImage:setImage(RegisterImage(GetPositionDraftIconByIndex(f2_local0)))
		end
	end)
	self:addElement(PlayerImage)
	self.PlayerImage = PlayerImage
	local HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 23.5, 151.5, 0, 0, 133, 150)
	HealthBar:setRGB(0.92, 0.92, 0.92)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	HealthBar.HealthFill.__Health_Bar_Color = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			HealthBar.HealthFill:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyHealthBarColorByTeamId(f1_arg1, f4_local0))
		end
	end
	HealthBar:linkToElementModel(self, "team", true, HealthBar.HealthFill.__Health_Bar_Color)
	HealthBar.HealthFill.__Health_Bar_Color_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.team
		end
		if f5_local0 then
			HealthBar.HealthFill.__Health_Bar_Color(f5_local0)
		end
	end
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local HealthValue = LUI.UIText.new(0, 0, 57.5, 117.5, 0, 0, 149, 170)
	HealthValue:setTTF("0arame_mono_stencil")
	HealthValue:setLetterSpacing(2)
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f6_local0))
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	local ClanAndGamerName = LUI.UIText.new(0, 0, -10, 185, 0, 0, 169, 190)
	ClanAndGamerName:setAlpha(0.8)
	ClanAndGamerName:setTTF("ttmussels_regular")
	ClanAndGamerName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ClanAndGamerName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ClanAndGamerName:linkToElementModel(self, "clientNum", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ClanAndGamerName:setText(CoD.BaseUtility.AlreadyLocalized(GetClientNameAndClanTag(f1_arg1, f7_local0)))
		end
	end)
	self:addElement(ClanAndGamerName)
	self.ClanAndGamerName = ClanAndGamerName
	local f1_local6 = HealthBar
	local f1_local7 = HealthBar.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["factions.playerFactionTeamEnum"], HealthBar.HealthFill.__Health_Bar_Color_FullPath)
	f1_local6 = HealthBar
	f1_local7 = HealthBar.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["profile.colorblindMode"], HealthBar.HealthFill.__Health_Bar_Color_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	return self
end
CoD.HealthBoostPlayerListWidget.__resetProperties = function(f8_arg0)
	f8_arg0.bg:completeAnimation()
	f8_arg0.bg:setRGB(0.16, 0.16, 0.16)
end
CoD.HealthBoostPlayerListWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.bg:completeAnimation()
			f10_arg0.bg:setRGB(0.31, 0.31, 0.31)
			f10_arg0.clipFinished(f10_arg0.bg)
		end,
	},
}
CoD.HealthBoostPlayerListWidget.__onClose = function(f11_arg0)
	f11_arg0.PlayerImage:close()
	f11_arg0.HealthBar:close()
	f11_arg0.HealthValue:close()
	f11_arg0.ClanAndGamerName:close()
end
