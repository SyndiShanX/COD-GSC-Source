require("x64:3507e0532e2631f")
CoD.TimelineEditorFilmOptions = InheritFrom(CoD.Menu)
LUI.createMenu.TimelineEditorFilmOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("TimelineEditorFilmOptions", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.TimelineEditorFilmOptions)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BGBlur = LUI.UIImage.new(0, 0, -87, 413, 0, 0, -63, 1163)
	BGBlur:setAlpha(0)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGTint = LUI.UIImage.new(0, 0, -87, 413, 0, 0, -63, 1163)
	BGTint:setRGB(0, 0, 0)
	BGTint:setAlpha(0.98)
	self:addElement(BGTint)
	self.BGTint = BGTint
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, -87, 413, 0, 0, -63, 1163)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local Title = LUI.UIText.new(0, 0, 30, 380, 0, 0, 195, 234)
	Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Title:setText(LocalizeToUpperString(@"hash_2FA47140D97F89D"))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local ButtonList = LUI.UIList.new(f1_local1, f1_arg0, 10, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0, 0, 30, 380)
	ButtonList:setTopBottom(0, 0, 253, 643)
	ButtonList:setWidgetType(CoD.DemoSideBarButton)
	ButtonList:setVerticalCount(5)
	ButtonList:setSpacing(10)
	ButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonList:setDataSource("DemoFilmOptionsButtonList")
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(ButtonList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		SetGlobalModelValueFalse("demo.showFilmOptionsSidebar")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local HintText = LUI.UIText.new(0, 0, 53, 380, 0, 0, 701.5, 722.5)
	HintText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HintText:setTTF("dinnext_regular")
	HintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(HintText)
	self.HintText = HintText
	local Arrow = LUI.UIImage.new(0, 0, 30, 45, 0, 0, 703.5, 718.5)
	Arrow:setAlpha(0.6)
	Arrow:setImage(RegisterImage(@"uie_t7_menu_gunsmith_arrow_white"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	HintText:linkToElementModel(ButtonList, "hintText", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			HintText:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		SetGlobalModelValueFalse("demo.showFilmOptionsSidebar")
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	ButtonList.id = "ButtonList"
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
CoD.TimelineEditorFilmOptions.__onClose = function(f8_arg0)
	f8_arg0.HintText:close()
	f8_arg0.ButtonList:close()
end
