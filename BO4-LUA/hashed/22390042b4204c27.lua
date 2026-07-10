require("x64:db806626fb64f10")
require("x64:e7061dfbce6aa90")
require("x64:7889ce1e3e2e8a")
CoD.Theater_SelectFilm = InheritFrom(CoD.Menu)
LUI.createMenu.Theater_SelectFilm = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Theater_SelectFilm", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Theater_SelectFilm)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setRGB(0.08, 0.08, 0.08)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlack:setAlpha(0.9)
	BGBlack:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BGBlack)
	self.BGBlack = BGBlack
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local DirectorTheaterSelectFile = CoD.DirectorTheaterSelectFile.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorTheaterSelectFile.TabBacking.TabBackingBlur:setAlpha(0)
	DirectorTheaterSelectFile:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(DirectorTheaterSelectFile)
	self.DirectorTheaterSelectFile = DirectorTheaterSelectFile
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/theater"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	self:registerEventHandler("menu_loaded", function(self, event)
		local f4_local0 = nil
		if self.menuLoaded then
			f4_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f4_local0 = self.super:menuLoaded(event)
		end
		ShowHeaderIconOnly(f1_local1)
		if not f4_local0 then
			f4_local0 = self:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.FileshareUtility.ClearCurrentFilter()
		CoD.FileshareUtility.SetupFileshareForTheater(controller)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		ResetThumbnailViewer(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	DirectorTheaterSelectFile.id = "DirectorTheaterSelectFile"
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
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
CoD.Theater_SelectFilm.__onClose = function(f7_arg0)
	f7_arg0.Background:close()
	f7_arg0.DirectorTheaterSelectFile:close()
	f7_arg0.GenericMenuFrameIdentity:close()
end
