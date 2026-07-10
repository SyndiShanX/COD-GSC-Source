require("x64:eda152e1d10147a")
require("x64:e106dd7e1189ae6")
require("x64:3e7363f43bb91")
require("x64:645619cd1eee885")
require("x64:65ed6705f0299cb")
CoD.DirectorCodCasterTeamIdentitySettings = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorCodCasterTeamIdentitySettings = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorCodCasterTeamIdentitySettings", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.DirectorCodCasterTeamIdentitySettings)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local FEButtonPanelShaderContainer0 = CoD.FE_ButtonPanelShaderContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FEButtonPanelShaderContainer0:setRGB(0.31, 0.31, 0.31)
	self:addElement(FEButtonPanelShaderContainer0)
	self.FEButtonPanelShaderContainer0 = FEButtonPanelShaderContainer0
	local FadeForStreamer = CoD.LobbyStreamerBlackFade.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FadeForStreamer:mergeStateConditions({
		{
			stateName = "Transparent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hideWorldForStreamer", 0)
			end,
		},
	})
	local FEMenuLeftGraphics = FadeForStreamer
	local GenericMenuFrame = FadeForStreamer.subscribeToModel
	local TeamColorList = Engine[0x8DF2E5447F384B9]()
	GenericMenuFrame(FEMenuLeftGraphics, TeamColorList.hideWorldForStreamer, function(f3_arg0)
		f1_local1:updateElementState(FadeForStreamer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "hideWorldForStreamer",
		})
	end, false)
	self:addElement(FadeForStreamer)
	self.FadeForStreamer = FadeForStreamer
	GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x7A023700261F0B2))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	FEMenuLeftGraphics = CoD.FE_Menu_LeftGraphics.new(f1_local1, f1_arg0, 0, 0, 29, 107, 0, 0, 129, 1055)
	self:addElement(FEMenuLeftGraphics)
	self.FEMenuLeftGraphics = FEMenuLeftGraphics
	TeamColorList = CoD.CodCasterTeamIdentitysettingscontainer.new(f1_local1, f1_arg0, 0.5, 0.5, -809.5, 759.5, 0, 0, -9.5, 893.5)
	TeamColorList:subscribeToGlobalModel(f1_arg0, "TeamIdentityInformation", "teamName", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TeamColorList.TeamNameInputButton2.Title:setText(f5_local0)
		end
	end)
	self:addElement(TeamColorList)
	self.TeamColorList = TeamColorList
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f6_local0 = nil
		HandleTeamIdentityKeyboardComplete(self, self, f1_arg0, event)
		if not f6_local0 then
			f6_local0 = self:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		SaveShoutcasterSettings(self, element, controller)
		RefreshLobbyGameClient(self, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	GenericMenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	TeamColorList.id = "TeamColorList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = GenericMenuFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.DirectorCodCasterTeamIdentitySettings.__onClose = function(f11_arg0)
	f11_arg0.FEButtonPanelShaderContainer0:close()
	f11_arg0.FadeForStreamer:close()
	f11_arg0.GenericMenuFrame:close()
	f11_arg0.FEMenuLeftGraphics:close()
	f11_arg0.TeamColorList:close()
end
