require("x64:eda152e1d10147a")
require("x64:dc0fc4f12ef5abe")
require("x64:3dd43113c4e1bd6")
CoD.DeleteFileshareFile = InheritFrom(CoD.Menu)
LUI.createMenu.DeleteFileshareFile = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DeleteFileshareFile", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.DeleteFileshareFile)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.9)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGTint:setRGB(0, 0, 0)
	BGTint:setAlpha(0.8)
	self:addElement(BGTint)
	self.BGTint = BGTint
	local StartMenuBackground0 = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuBackground0:mergeStateConditions({
		{
			stateName = "InGame",
			condition = function(menu, element, event)
				return IsInGame()
			end,
		},
	})
	StartMenuBackground0:setAlpha(0)
	self:addElement(StartMenuBackground0)
	self.StartMenuBackground0 = StartMenuBackground0
	local BlackBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBG:setAlpha(0)
	BlackBG:setImage(RegisterImage(0x4BF88A437F4C579))
	self:addElement(BlackBG)
	self.BlackBG = BlackBG
	local GenericMenuFrame0 = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	GenericMenuFrame0.CommonHeader.subtitle.StageTitle:setText(Engine[0xF9F1239CFD921FE](0x8242B5D10AB6D48))
	GenericMenuFrame0:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericMenuFrame0.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(GenericMenuFrame0)
	self.GenericMenuFrame0 = GenericMenuFrame0
	local FileshareCategoryContentList = CoD.FileshareCategoryContentList.new(f1_local1, f1_arg0, 0.5, 0.5, -782.5, 782.5, 0.5, 0.5, -398, 382)
	FileshareCategoryContentList:setScale(0.96, 0.96)
	self:addElement(FileshareCategoryContentList)
	self.FileshareCategoryContentList = FileshareCategoryContentList
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		CoD.FileshareUtility.UpdateCurrentQuota(controller)
		PreserveThumbnails(controller, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	GenericMenuFrame0:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame0.id = "GenericMenuFrame0"
	end
	FileshareCategoryContentList.id = "FileshareCategoryContentList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FileshareCategoryContentList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.DeleteFileshareFile.__onClose = function(f6_arg0)
	f6_arg0.StartMenuBackground0:close()
	f6_arg0.GenericMenuFrame0:close()
	f6_arg0.FileshareCategoryContentList:close()
end
