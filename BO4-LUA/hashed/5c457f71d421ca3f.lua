require("x64:eda152e1d10147a")
require("x64:2e03ae630340c1f")
require("x64:7889ce1e3e2e8a")
CoD.SpecialistHeadquartersSelectSpecialist = InheritFrom(CoD.Menu)
LUI.createMenu.SpecialistHeadquartersSelectSpecialist = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SpecialistHeadquartersSelectSpecialist", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.CreateGlobalModel("MapVote.timerActive")
	self:setClass(CoD.SpecialistHeadquartersSelectSpecialist)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local SelectSpecialistInternal = CoD.SpecialistHeadquartersSelectSpecialistInternal.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self.__on_menuOpened_SelectSpecialistInternal = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		SizeToSafeArea(SelectSpecialistInternal, f2_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_SelectSpecialistInternal)
	self:addElement(SelectSpecialistInternal)
	self.SelectSpecialistInternal = SelectSpecialistInternal
	local SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x2D67DCCB863C991))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["MapVote.timerActive"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		if CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.LobbyUtility.StopManualTimer(controller)
			CoD.CTUtility.RefreshChosenSpecialistParams(controller)
			return true
		elseif not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.CTUtility.UpdateShownSpecialist(controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x78D439E1B360368, nil, "ESCAPE")
			return true
		elseif not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x78D439E1B360368, nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	SelectSpecialistInternal.id = "SelectSpecialistInternal"
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = SelectSpecialistInternal
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_SelectSpecialistInternal)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquartersSelectSpecialist.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.Background:close()
	f8_arg0.SelectSpecialistInternal:close()
	f8_arg0.SocialFrame:close()
end
