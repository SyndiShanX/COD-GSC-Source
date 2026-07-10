require("x64:6f28821b90063e7")
require("x64:474d14efb47ebf4")
CoD.Migration = InheritFrom(CoD.Menu)
LUI.createMenu.Migration = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Migration", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Migration)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local elementDarkenBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	elementDarkenBg:setRGB(0, 0, 0)
	self:addElement(elementDarkenBg)
	self.elementDarkenBg = elementDarkenBg
	local VoipContainer = CoD.Voip_Container.new(f1_local1, f1_arg0, 0, 0, 96, 505, 0, 0, 54, 162)
	VoipContainer:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				return IsCodCasterProfileValueEqualTo(f1_arg0, "shoutcaster_ds_voip_dock", 1) and AlwaysFalse()
			end,
		},
	})
	local migratingHostsLabel = VoipContainer
	local Team1PlayerList = VoipContainer.subscribeToModel
	local Image = DataSources.CodCaster.getModel(f1_arg0)
	Team1PlayerList(migratingHostsLabel, Image.profileSettingsUpdated, function(f4_arg0)
		f1_local1:updateElementState(VoipContainer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:addElement(VoipContainer)
	self.VoipContainer = VoipContainer
	Team1PlayerList = LUI.UIList.new(f1_local1, f1_arg0, 7, 0, nil, false, false, false, false)
	Team1PlayerList:setLeftRight(0.5, 0.5, -864, -534)
	Team1PlayerList:setTopBottom(0, 0, 54, 183)
	Team1PlayerList:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Team1PlayerList:setVerticalCount(4)
	Team1PlayerList:setSpacing(7)
	Team1PlayerList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Team1PlayerList)
	self.Team1PlayerList = Team1PlayerList
	migratingHostsLabel = LUI.UIText.new(0.5, 0.5, -564.5, 564.5, 0, 0, 63, 143)
	migratingHostsLabel:setText(Engine[0xF9F1239CFD921FE](0x52AEA8564483540))
	migratingHostsLabel:setTTF("default")
	migratingHostsLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	migratingHostsLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(migratingHostsLabel)
	self.migratingHostsLabel = migratingHostsLabel
	Image = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	Image:setImage(RegisterImage(0xD7107421B53850D))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	Image:setShaderVector(0, 28, 1, 0, 0)
	Image:setShaderVector(1, 20.83, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	Team1PlayerList.id = "Team1PlayerList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Migration.__resetProperties = function(f5_arg0)
	f5_arg0.VoipContainer:completeAnimation()
	f5_arg0.Team1PlayerList:completeAnimation()
	f5_arg0.VoipContainer:setAlpha(1)
	f5_arg0.Team1PlayerList:setAlpha(1)
end
CoD.Migration.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.VoipContainer:completeAnimation()
			f6_arg0.VoipContainer:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.VoipContainer)
		end,
	},
	Multiplayer = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Team1PlayerList:completeAnimation()
			f7_arg0.Team1PlayerList:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Team1PlayerList)
		end,
	},
}
CoD.Migration.__onClose = function(f8_arg0)
	f8_arg0.VoipContainer:close()
	f8_arg0.Team1PlayerList:close()
end
