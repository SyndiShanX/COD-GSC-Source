require("x64:dd09a0001b0ff37")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	f1_arg0.disableBlur = true
end
LUI.hudMenuType.LightmanColorPicker = "hud"
CoD.LightmanColorPicker = InheritFrom(CoD.Menu)
LUI.createMenu.LightmanColorPicker = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("LightmanColorPicker", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.LightmanColorPicker)
	self.soundSet = "ChooseDecal"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0.5, 0.5, -299, 299, 1, 1, -463, -225)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setAlpha(0.9)
	SceneBlur:setImage(RegisterImage(0x8FD6CEEA1F2AEEA))
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BGTint = LUI.UIImage.new(0.5, 0.5, -299, 299, 1, 1, -463, -225)
	BGTint:setRGB(0, 0, 0)
	BGTint:setAlpha(0.5)
	BGTint:setImage(RegisterImage(0xFF17EAF949B3DB4))
	BGTint:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	BGTint:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(BGTint)
	self.BGTint = BGTint
	local PixelGridTiledBacking = LUI.UIImage.new(0.5, 0.5, -295, 295, 1, 1, -459, -229)
	PixelGridTiledBacking:setAlpha(0.1)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local InnerFrameTL = LUI.UIImage.new(0.5, 0.5, -300, 0, 1, 1, -464, -344)
	InnerFrameTL:setRGB(0, 0, 0)
	InnerFrameTL:setAlpha(0.9)
	InnerFrameTL:setImage(RegisterImage(0xA6543C45DE8063F))
	InnerFrameTL:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	InnerFrameTL:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(InnerFrameTL)
	self.InnerFrameTL = InnerFrameTL
	local InnerFrameTR = LUI.UIImage.new(0.5, 0.5, 0, 300, 1, 1, -464, -344)
	InnerFrameTR:setRGB(0, 0, 0)
	InnerFrameTR:setAlpha(0.9)
	InnerFrameTR:setYRot(180)
	InnerFrameTR:setImage(RegisterImage(0xA6543C45DE8063F))
	InnerFrameTR:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	InnerFrameTR:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(InnerFrameTR)
	self.InnerFrameTR = InnerFrameTR
	local InnerFrameBR = LUI.UIImage.new(0.5, 0.5, 0, 300, 1, 1, -345, -225)
	InnerFrameBR:setRGB(0, 0, 0)
	InnerFrameBR:setAlpha(0.9)
	InnerFrameBR:setXRot(180)
	InnerFrameBR:setYRot(180)
	InnerFrameBR:setImage(RegisterImage(0xA6543C45DE8063F))
	InnerFrameBR:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	InnerFrameBR:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(InnerFrameBR)
	self.InnerFrameBR = InnerFrameBR
	local InnerFrameBR2 = LUI.UIImage.new(0.5, 0.5, -300, 0, 1, 1, -345, -225)
	InnerFrameBR2:setRGB(0, 0, 0)
	InnerFrameBR2:setAlpha(0.9)
	InnerFrameBR2:setXRot(180)
	InnerFrameBR2:setImage(RegisterImage(0xA6543C45DE8063F))
	InnerFrameBR2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	InnerFrameBR2:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(InnerFrameBR2)
	self.InnerFrameBR2 = InnerFrameBR2
	local OutterFrameTL = LUI.UIImage.new(0.5, 0.5, -300, 0, 1, 1, -464, -344)
	OutterFrameTL:setAlpha(0.9)
	OutterFrameTL:setImage(RegisterImage(0x62418998DA8F272))
	OutterFrameTL:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	OutterFrameTL:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(OutterFrameTL)
	self.OutterFrameTL = OutterFrameTL
	local OutterFrameTL2 = LUI.UIImage.new(0.5, 0.5, -300, 0, 1, 1, -345, -225)
	OutterFrameTL2:setAlpha(0.9)
	OutterFrameTL2:setYRot(180)
	OutterFrameTL2:setZRot(180)
	OutterFrameTL2:setImage(RegisterImage(0x62418998DA8F272))
	OutterFrameTL2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	OutterFrameTL2:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(OutterFrameTL2)
	self.OutterFrameTL2 = OutterFrameTL2
	local OutterFrameTL3 = LUI.UIImage.new(0.5, 0.5, 0, 300, 1, 1, -345, -225)
	OutterFrameTL3:setAlpha(0.9)
	OutterFrameTL3:setZRot(180)
	OutterFrameTL3:setImage(RegisterImage(0x62418998DA8F272))
	OutterFrameTL3:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	OutterFrameTL3:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(OutterFrameTL3)
	self.OutterFrameTL3 = OutterFrameTL3
	local OutterFrameTR = LUI.UIImage.new(0.5, 0.5, 0, 300, 1, 1, -464, -344)
	OutterFrameTR:setAlpha(0.9)
	OutterFrameTR:setYRot(180)
	OutterFrameTR:setImage(RegisterImage(0x62418998DA8F272))
	OutterFrameTR:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	OutterFrameTR:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(OutterFrameTR)
	self.OutterFrameTR = OutterFrameTR
	local ColorPicker = LUI.UIList.new(f2_local1, f2_arg0, 6, 0, nil, false, false, false, false)
	ColorPicker:setLeftRight(0.5, 0.5, -296, 296)
	ColorPicker:setTopBottom(1, 1, -458, -230)
	ColorPicker:setScale(0.97, 0.95)
	ColorPicker:setWidgetType(CoD.LightmanColorElement)
	ColorPicker:setHorizontalCount(13)
	ColorPicker:setVerticalCount(9)
	ColorPicker:setSpacing(6)
	ColorPicker:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ColorPicker:setDataSource("EmblemColorList")
	ColorPicker:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		CoD.DemoUtility.SelectLightmanColor(self, element, f2_arg0, f2_local1)
		return f3_local0
	end)
	ColorPicker:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		return f4_local0
	end)
	f2_local1:AddButtonCallbackFunction(ColorPicker, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.DemoUtility.SelectLightmanColor(self, element, controller, menu)
		GoBack(self, controller)
		SetGlobalModelValueFalse("demo.showLightmanColorPicker")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	f2_local1:AddButtonCallbackFunction(ColorPicker, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		CoD.DemoUtility.SelectLightmanColor(self, element, controller, menu)
		GoBack(self, controller)
		SetGlobalModelValueFalse("demo.showLightmanColorPicker")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(ColorPicker)
	self.ColorPicker = ColorPicker
	self:registerEventHandler("menu_loaded", function(self, event)
		local f9_local0 = nil
		if self.menuLoaded then
			f9_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f9_local0 = self.super:menuLoaded(event)
		end
		CoD.DemoUtility.StoreCurrentLightmanColor(self, self, f2_arg0, f2_local1)
		if not f9_local0 then
			f9_local0 = self:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.DemoUtility.CancelLightmanColorSelection(self, element, controller, menu)
		GoBack(self, controller)
		SetGlobalModelValueFalse("demo.showLightmanColorPicker")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	ColorPicker.id = "ColorPicker"
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = ColorPicker
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.LightmanColorPicker.__onClose = function(f12_arg0)
	f12_arg0.ColorPicker:close()
end
