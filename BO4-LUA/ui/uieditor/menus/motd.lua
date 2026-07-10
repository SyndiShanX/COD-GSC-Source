require("x64:74865184d366449")
require("x64:74864184d366296")
require("x64:e62f9ce75b5e6b9")
require("x64:47c0adba754f8d0")
require("x64:1bf0f5b435e0a27")
require("x64:f027dcc6409e42c")
CoD.MOTD = InheritFrom(CoD.Menu)
LUI.createMenu.MOTD = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MOTD", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.MOTD)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlurBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBG:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBG)
	self.BlurBG = BlurBG
	local MotdBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MotdBG:setRGB(0, 0, 0)
	MotdBG:setAlpha(0.8)
	self:addElement(MotdBG)
	self.MotdBG = MotdBG
	local TiledBacking = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -440, 440)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local GridBG = CoD.MOTD_BannerImage_Grid.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	GridBG:setAlpha(0.5)
	self:addElement(GridBG)
	self.GridBG = GridBG
	local TiledBacking2 = LUI.UIImage.new(0.5, 0.5, -960, -516, 0.5, 0.5, -440, 440)
	TiledBacking2:setAlpha(0.2)
	TiledBacking2:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking2)
	self.TiledBacking2 = TiledBacking2
	local Buttons = CoD.MOTD_ButtonContainer.new(f1_local1, f1_arg0, 0.5, 0.5, 650, 902, 0.5, 0.5, 381, 429)
	Buttons:subscribeToGlobalModel(f1_arg0, "PerController", "LastInput", function(model)
		local f2_local0 = Buttons
		if IsGamepad(f1_arg0) then
			ShowWidget(f2_local0)
		elseif not IsGamepad(f1_arg0) then
			HideWidget(f2_local0)
		end
	end)
	self:addElement(Buttons)
	self.Buttons = Buttons
	local BoxHighlighted = CoD.CommonBgLayoutElement03.new(f1_local1, f1_arg0, 0.5, 0.5, -622, -546, 0.5, 0.5, 164.5, 544.5)
	BoxHighlighted:setAlpha(0.5)
	BoxHighlighted:setScale(0.4, 0.4)
	self:addElement(BoxHighlighted)
	self.BoxHighlighted = BoxHighlighted
	local LayoutElement02 = CoD.CommonBgLayoutElement02.new(f1_local1, f1_arg0, 0.5, 0.5, 679.5, 983.5, 0.5, 0.5, -404.5, -328.5)
	LayoutElement02:setZoom(100)
	LayoutElement02:setScale(0.5, 0.5)
	self:addElement(LayoutElement02)
	self.LayoutElement02 = LayoutElement02
	local LayoutFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	LayoutFrame:setLeftRight(0.5, 0.5, -485, 907)
	LayoutFrame:setTopBottom(0.5, 0.5, -338, 342)
	self:addElement(LayoutFrame)
	self.LayoutFrame = LayoutFrame
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, -962, 962, 0.5, 0.5, 426, 442)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	local f1_local12 = nil
	local ButtonsList = LUI.UIList.new(f1_local1, f1_arg0, 18, 0, nil, false, false, false, false)
	ButtonsList:setLeftRight(0.5, 0.5, -425, 847)
	ButtonsList:setTopBottom(0.5, 0.5, 349, 429)
	ButtonsList:setWidgetType(CoD.PC_MOTD_Buttons)
	ButtonsList:setHorizontalCount(5)
	ButtonsList:setSpacing(18)
	ButtonsList:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ButtonsList:setDataSource("PCMOTDOptions")
	ButtonsList:subscribeToGlobalModel(f1_arg0, "PerController", "LastInput", function(model)
		local f3_local0 = ButtonsList
		if IsMouseOrKeyboard(f1_arg0) then
			ShowWidget(f3_local0)
		elseif not IsMouseOrKeyboard(f1_arg0) then
			HideWidget(f3_local0)
		end
	end)
	self:addElement(ButtonsList)
	self.ButtonsList = ButtonsList
	local DividerSolidBot = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, 441, 445)
	DividerSolidBot:setAlpha(0.5)
	DividerSolidBot:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidBot:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidBot)
	self.DividerSolidBot = DividerSolidBot
	local DividerSolidTop = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -444, -440)
	DividerSolidTop:setAlpha(0.5)
	DividerSolidTop:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidTop:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidTop:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidTop)
	self.DividerSolidTop = DividerSolidTop
	local BoundaryTop = LUI.UIImage.new(0.5, 0.5, -962, 962, 0.5, 0.5, -442, -426)
	BoundaryTop:setAlpha(0.15)
	BoundaryTop:setZRot(180)
	BoundaryTop:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryTop:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryTop:setShaderVector(0, 0, 0, 0, 0)
	BoundaryTop:setupNineSliceShader(66, 8)
	self:addElement(BoundaryTop)
	self.BoundaryTop = BoundaryTop
	local DividerSolid = LUI.UIImage.new(0.5, 0.5, -956, -78, 0.5, 0.5, -2, 2)
	DividerSolid:setAlpha(0.02)
	DividerSolid:setZRot(90)
	DividerSolid:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolid:setShaderVector(0, 0, 0, 0, 0)
	DividerSolid:setupNineSliceShader(8, 4)
	self:addElement(DividerSolid)
	self.DividerSolid = DividerSolid
	local MOTDBanners = CoD.MOTD_BannerContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -874, -546, 0.5, 0.5, -338.5, 340.5)
	self:addElement(MOTDBanners)
	self.MOTDBanners = MOTDBanners
	LayoutFrame:linkToElementModel(MOTDBanners.MOTDBanners, nil, false, function(model)
		LayoutFrame:setModel(model, f1_arg0)
	end)
	LayoutFrame:linkToElementModel(MOTDBanners.MOTDBanners, "frameLayout", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			LayoutFrame:changeFrameWidget(f5_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "KBMouse",
			condition = function(menu, element, event)
				local f6_local0
				if not IsGamepad(f1_arg0) then
					f6_local0 = IsPC()
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f7_arg1)
	end)
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local20(f1_local19, f1_local21.LastInput, function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.MOTDUtility.MOTD_Close(self, controller, menu, self.MOTDBanners)
		ResetThumbnailViewer(controller)
		ClearMenuSavedState(menu)
		CoD.VideoStreamingUtility.CancelDownloadUrlGroup()
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x6C253CF816B40B5, nil, nil)
		return true
	end, false)
	self.__on_menuOpened_self = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if IsElementReceivingMenuOpenEventForTheFirstTime(self) and IsPC() then
			CoD.PCUtility.LockUIShortcutInput(f11_arg2, f11_arg1)
			UpdateElementDataSource(self, "ButtonsList")
			CoD.VideoStreamingUtility.CancelDownloadUrlGroup()
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			CoD.PCUtility.UnlockUIShortcutInput(f1_local1, f1_arg0)
		end
	end)
	Buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		Buttons.id = "Buttons"
	end
	LayoutFrame.id = "LayoutFrame"
	ButtonsList.id = "ButtonsList"
	MOTDBanners.id = "MOTDBanners"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = MOTDBanners
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local20 = self
	CoD.WZUtility.PlayWZTrialVideo(f1_local1, f1_arg0)
	return self
end
CoD.MOTD.__onClose = function(f14_arg0)
	f14_arg0.__on_close_removeOverrides()
	f14_arg0.LayoutFrame:close()
	f14_arg0.GridBG:close()
	f14_arg0.Buttons:close()
	f14_arg0.BoxHighlighted:close()
	f14_arg0.LayoutElement02:close()
	f14_arg0.ButtonsList:close()
	f14_arg0.MOTDBanners:close()
end
