require("x64:3507e0532e2631f")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	f1_arg0.disableBlur = true
	f1_arg0.animateInFromOffset = -355
end
CoD.ChooseModeSidebar = InheritFrom(CoD.Menu)
LUI.createMenu.ChooseModeSidebar = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("ChooseModeSidebar", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.ChooseModeSidebar)
	self.soundSet = "ChooseDecal"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	f2_local1:addElementToPendingUpdateStateList(self)
	local BGBlur = LUI.UIImage.new(0, 0, -87, 413, 0, 0, -63, 1163)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGTint = LUI.UIImage.new(0, 0, -87, 413, 0, 0, -63, 1163)
	BGTint:setRGB(0, 0, 0)
	BGTint:setAlpha(0.92)
	self:addElement(BGTint)
	self.BGTint = BGTint
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, -87, 413, 0, 0, -63, 1163)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local Title = LUI.UIText.new(0, 0, 30, 380, 0, 0, 195, 234)
	Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Title:setText(LocalizeToUpperString(0x5D6995788BFB8D2))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local HintText = LUI.UIText.new(0, 0, 53, 380, 0, 0, 663.5, 684.5)
	HintText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HintText:setTTF("dinnext_regular")
	HintText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HintText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(HintText)
	self.HintText = HintText
	local ButtonList = LUI.UIList.new(f2_local1, f2_arg0, 10, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0, 0, 30, 380)
	ButtonList:setTopBottom(0, 0, 253, 643)
	ButtonList:setWidgetType(CoD.DemoSideBarButton)
	ButtonList:setVerticalCount(5)
	ButtonList:setSpacing(10)
	ButtonList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonList:setDataSource("DemoChooseModeButtonList")
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f2_local1:AddButtonCallbackFunction(ButtonList, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local Arrow = LUI.UIImage.new(0, 0, 30, 45, 0, 0, 666.5, 681.5)
	Arrow:setAlpha(0.6)
	Arrow:setImage(RegisterImage(0x6961F4FBB41134C))
	self:addElement(Arrow)
	self.Arrow = Arrow
	HintText:linkToElementModel(ButtonList, "hintText", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HintText:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "HighlightReelMode",
			condition = function(menu, element, event)
				return IsDemoContextHighlightReelMode()
			end,
		},
	})
	local f2_local9 = self
	local f2_local10 = self.subscribeToModel
	local f2_local11 = Engine[0x8DF2E5447F384B9]()
	f2_local10(f2_local9, f2_local11["demo.contextMode"], function(f8_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f8_arg0:get(),
			modelName = "demo.contextMode",
		})
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.DemoUtility.CloseChooseModeSidebar(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	ButtonList.id = "ButtonList"
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = ButtonList
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.ChooseModeSidebar.__resetProperties = function(f11_arg0)
	f11_arg0.HintText:completeAnimation()
	f11_arg0.Arrow:completeAnimation()
	f11_arg0.HintText:setLeftRight(0, 0, 53, 380)
	f11_arg0.HintText:setTopBottom(0, 0, 663.5, 684.5)
	f11_arg0.Arrow:setAlpha(0.6)
end
CoD.ChooseModeSidebar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	HighlightReelMode = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.HintText:completeAnimation()
			f13_arg0.HintText:setLeftRight(0, 0, 52, 390)
			f13_arg0.HintText:setTopBottom(0, 0, 348, 375)
			f13_arg0.clipFinished(f13_arg0.HintText)
			f13_arg0.Arrow:completeAnimation()
			f13_arg0.Arrow:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Arrow)
		end,
	},
}
CoD.ChooseModeSidebar.__onClose = function(f14_arg0)
	f14_arg0.HintText:close()
	f14_arg0.ButtonList:close()
end
