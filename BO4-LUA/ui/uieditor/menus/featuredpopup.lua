require("x64:bee1e79985488c9")
require("x64:7fb57c6366fb4cf")
CoD.FeaturedPopup = InheritFrom(CoD.Menu)
LUI.createMenu.FeaturedPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FeaturedPopup", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.FeaturedPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
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
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -540, 540)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -440, 440)
	TiledBacking2:setAlpha(0.5)
	TiledBacking2:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking2)
	self.TiledBacking2 = TiledBacking2
	local Image = LUI.UIImage.new(0.5, 0.5, -693.5, 698.5, 0.5, 0.5, -330, 350)
	Image:linkToElementModel(self, "popup_image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local MOTDFeaturedButtonContainer = CoD.MOTD_FeaturedButtonContainer.new(f1_local1, f1_arg0, 0.5, 0.5, 298.5, 698.5, 0.5, 0.5, 350, 398)
	MOTDFeaturedButtonContainer:registerEventHandler("input_source_changed", function(element, event)
		local f3_local0 = nil
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	MOTDFeaturedButtonContainer:subscribeToGlobalModel(f1_arg0, "PerController", "LastInput", function(model)
		local f4_local0 = MOTDFeaturedButtonContainer
		if not IsMouseOrKeyboard(f1_arg0) then
			ShowWidget(f4_local0)
		elseif IsMouseOrKeyboard(f1_arg0) then
			HideWidget(f4_local0)
		end
	end)
	self:addElement(MOTDFeaturedButtonContainer)
	self.MOTDFeaturedButtonContainer = MOTDFeaturedButtonContainer
	local TitleLbl = LUI.UIText.new(0.5, 0.5, -673.5, 15.5, 0.5, 0.5, -312.5, -267.5)
	TitleLbl:setRGB(0.86, 0.74, 0.25)
	TitleLbl:setAlpha(0.1)
	TitleLbl:setTTF("ttmussels_demibold")
	TitleLbl:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TitleLbl:setShaderVector(0, 0, 0, 0, 0)
	TitleLbl:setShaderVector(1, 0, 0, 0, 0)
	TitleLbl:setShaderVector(2, 1, 1, 1, 0)
	TitleLbl:setLetterSpacing(10)
	TitleLbl:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	TitleLbl:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TitleLbl:setText(ConvertToUpperString(f5_local0))
		end
	end)
	self:addElement(TitleLbl)
	self.TitleLbl = TitleLbl
	local TitleLbl0 = LUI.UIText.new(0.5, 0.5, -673.5, 15.5, 0.5, 0.5, -312.5, -267.5)
	TitleLbl0:setRGB(0.86, 0.74, 0.25)
	TitleLbl0:setTTF("ttmussels_demibold")
	TitleLbl0:setLetterSpacing(10)
	TitleLbl0:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	TitleLbl0:linkToElementModel(self, "name", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TitleLbl0:setText(ConvertToUpperString(f6_local0))
		end
	end)
	self:addElement(TitleLbl0)
	self.TitleLbl0 = TitleLbl0
	local spacer = LUI.UIImage.new(0.5, 0.5, -693.5, -630.5, 0.5, 0.5, -266, -263)
	spacer:setAlpha(0)
	self:addElement(spacer)
	self.spacer = spacer
	local txtDescription = LUI.UIText.new(0.5, 0.5, -673.5, -2.5, 0.5, 0.5, -250.5, -229.5)
	txtDescription:setRGB(0.92, 0.92, 0.92)
	txtDescription:setTTF("dinnext_regular")
	txtDescription:setLetterSpacing(1)
	txtDescription:setLineSpacing(2)
	txtDescription:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	txtDescription:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(txtDescription)
	self.txtDescription = txtDescription
	local DividerSolidBot = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, 441, 445)
	DividerSolidBot:setAlpha(0.5)
	DividerSolidBot:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidBot:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidBot)
	self.DividerSolidBot = DividerSolidBot
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, -962, 962, 0.5, 0.5, 426, 442)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	local BoundaryTop = LUI.UIImage.new(0.5, 0.5, -962, 962, 0.5, 0.5, -442, -426)
	BoundaryTop:setAlpha(0.15)
	BoundaryTop:setZRot(180)
	BoundaryTop:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryTop:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryTop:setShaderVector(0, 0, 0, 0, 0)
	BoundaryTop:setupNineSliceShader(66, 8)
	self:addElement(BoundaryTop)
	self.BoundaryTop = BoundaryTop
	local DividerSolidTop = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -444, -440)
	DividerSolidTop:setAlpha(0.5)
	DividerSolidTop:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidTop:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidTop:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidTop)
	self.DividerSolidTop = DividerSolidTop
	local MOTDFeaturedButtonContainerPC = CoD.MOTD_FeaturedButtonContainer_PC.new(f1_local1, f1_arg0, 0.5, 0.5, 342, 699, 0.5, 0.5, 366, 426)
	MOTDFeaturedButtonContainerPC.continueButtonPC.featureOverlayButtonContainer.Title:setText(LocalizeToUpperString(0x6393FF34EA56966))
	MOTDFeaturedButtonContainerPC.backButtonPC.featureOverlayButtonContainer.Title:setText(LocalizeToUpperString(0x78D439E1B360368))
	self:addElement(MOTDFeaturedButtonContainerPC)
	self.MOTDFeaturedButtonContainerPC = MOTDFeaturedButtonContainerPC
	self.txtDescription:linkToElementModel(self, "content_long", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			txtDescription:setText(f7_local0)
		end
	end)
	self:linkToElementModel(self, "popupActionString", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0xA4032FB2AAB69F2, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelPathNil(element, controller, "popupActionString") and not CoD.ModelUtility.IsSelfModelValueNil(element, controller, "popupActionString") then
			CoD.MOTDUtility.FeatureCard_HandlePopupAction(self, controller, element, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelPathNil(element, controller, "popupActionString") and not CoD.ModelUtility.IsSelfModelValueNil(element, controller, "popupActionString") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		CoD.BaseUtility.SetModelFromUserData(f15_arg1, self, f1_arg1._model)
		CoD.MOTDUtility.FeatureCard_SetPopupActionButtonName(self, f15_arg1, f15_local0, f15_arg2)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	MOTDFeaturedButtonContainer:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MOTDFeaturedButtonContainer.id = "MOTDFeaturedButtonContainer"
	end
	if CoD.isPC then
		MOTDFeaturedButtonContainerPC.id = "MOTDFeaturedButtonContainerPC"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.FeaturedPopup.__onClose = function(f17_arg0)
	f17_arg0.__on_close_removeOverrides()
	f17_arg0.Image:close()
	f17_arg0.MOTDFeaturedButtonContainer:close()
	f17_arg0.TitleLbl:close()
	f17_arg0.TitleLbl0:close()
	f17_arg0.txtDescription:close()
	f17_arg0.MOTDFeaturedButtonContainerPC:close()
end
