require("x64:bc6e2379d2241fb")
require("x64:bc22715ccac339a")
require("x64:f9f0e41049e1efe")
CoD.LaboratoryPlasma_PopoutContainer = InheritFrom(LUI.UIElement)
CoD.LaboratoryPlasma_PopoutContainer.__defaultWidth = 800
CoD.LaboratoryPlasma_PopoutContainer.__defaultHeight = 1080
CoD.LaboratoryPlasma_PopoutContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryPlasma_PopoutContainer)
	self.id = "LaboratoryPlasma_PopoutContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local leftBackground = LUI.UIImage.new(0.5, 0.5, -400, 400, 0, 1, 0, 0)
	leftBackground:setRGB(0.04, 0.04, 0.04)
	leftBackground:setAlpha(0.8)
	self:addElement(leftBackground)
	self.leftBackground = leftBackground
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0.5, 798.5, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.6)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local StoneTiledBacking = LUI.UIImage.new(0, 0, 0, 799, 0, 0, 1, 207)
	StoneTiledBacking:setRGB(0.83, 0.11, 0.01)
	StoneTiledBacking:setAlpha(0.8)
	StoneTiledBacking:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonbgtile"))
	StoneTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	StoneTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	StoneTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(StoneTiledBacking)
	self.StoneTiledBacking = StoneTiledBacking
	local RedOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 207)
	RedOverlay:setRGB(0.83, 0.11, 0.01)
	RedOverlay:setAlpha(0.02)
	self:addElement(RedOverlay)
	self.RedOverlay = RedOverlay
	local Divider = LUI.UIImage.new(0.5, 0.5, -325, 325, 0.5, 0.5, 5, 7)
	Divider:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider:setAlpha(0.1)
	self:addElement(Divider)
	self.Divider = Divider
	local tileTexture = LUI.UIImage.new(0.5, 0.5, -400, 400, 0, 1, 0, 0)
	tileTexture:setAlpha(0.5)
	tileTexture:setImage(RegisterImage(@"uie_t7_tile_texture"))
	tileTexture:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	tileTexture:setShaderVector(0, 30, 55, 0, 0)
	tileTexture:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(tileTexture)
	self.tileTexture = tileTexture
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 19, 0, nil, false, false, false, false)
	List:setLeftRight(0, 0, 75, 725)
	List:setTopBottom(0.5, 0.5, 66, 374)
	List:setWidgetType(CoD.LaboratoryPlasma_ListButton)
	List:setVerticalCount(3)
	List:setSpacing(19)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List:setFilter(function(f2_arg0)
		return f2_arg0.isFeatured:get() ~= true
	end)
	List:setDataSource("ZMLaboratoryPlasmaItemList")
	List:linkToElementModel(List, "disabled", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	List:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(List)
	self.List = List
	local titlePurchasePlasma = LUI.UIText.new(0.5, 0.5, -325.5, 326.5, 0, 0, 175.5, 205.5)
	titlePurchasePlasma:setRGB(0.58, 0.85, 1)
	titlePurchasePlasma:setText(LocalizeToUpperString(@"hash_29616DF01C4B70B"))
	titlePurchasePlasma:setTTF("skorzhen")
	titlePurchasePlasma:setLetterSpacing(5)
	titlePurchasePlasma:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	titlePurchasePlasma:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(titlePurchasePlasma)
	self.titlePurchasePlasma = titlePurchasePlasma
	local titleNotEnoughPlasma = LUI.UIText.new(0.5, 0.5, -325.5, 326.5, 0, 0, 175.5, 205.5)
	titleNotEnoughPlasma:setRGB(0.58, 0.85, 1)
	titleNotEnoughPlasma:setText(LocalizeToUpperString(@"hash_1DFE20BB2A710F9C"))
	titleNotEnoughPlasma:setTTF("skorzhen")
	titleNotEnoughPlasma:setLetterSpacing(5)
	titleNotEnoughPlasma:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	titleNotEnoughPlasma:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(titleNotEnoughPlasma)
	self.titleNotEnoughPlasma = titleNotEnoughPlasma
	local reason = LUI.UIText.new(0.5, 0.5, -324.5, 325.5, 0, 0, 231.5, 251.5)
	reason:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	reason:setTTF("dinnext_regular")
	reason:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	reason:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	reason:linkToElementModel(self, "plasmaPrice", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			reason:setText(CoD.ZMLaboratoryUtility.UpdateNPPurchaseDesc(self:getModel(), f1_arg1, f7_local0))
		end
	end)
	self:addElement(reason)
	self.reason = reason
	local Featured = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	Featured:setLeftRight(0, 0, 76, 726)
	Featured:setTopBottom(0, 0, 355, 445)
	Featured:setWidgetType(CoD.LaboratoryPlasma_ListButton)
	Featured:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Featured:setFilter(function(f8_arg0)
		return f8_arg0.isFeatured:get() == true
	end)
	Featured:setDataSource("ZMLaboratoryPlasmaItemList")
	Featured:linkToElementModel(Featured, "disabled", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Featured:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Featured, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(Featured)
	self.Featured = Featured
	local BgZmStar = LUI.UIImage.new(0.5, 0.5, -100, 100, 0, 0, 107, 307)
	BgZmStar:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	BgZmStar:setAlpha(0.4)
	BgZmStar:setImage(RegisterImage(@"uie_ui_hud_zm_arr_reward_star"))
	BgZmStar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BgZmStar:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(BgZmStar)
	self.BgZmStar = BgZmStar
	local DividerCenter = LUI.UIImage.new(0.5, 0.5, -7.5, 7.5, 0.5, 0.5, -1.5, 13.5)
	DividerCenter:setImage(RegisterImage(@"hash_61EC82771A88A0E6"))
	self:addElement(DividerCenter)
	self.DividerCenter = DividerCenter
	local HeaderUnderline = CoD.zm_LaboratoryDescriptionDivider.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 324.5, 0, 0, 191, 223)
	self:addElement(HeaderUnderline)
	self.HeaderUnderline = HeaderUnderline
	local SideBar = LUI.UIImage.new(0, 0, -2, 3, 0, 1, 0, 0)
	SideBar:setAlpha(0.25)
	SideBar:setImage(RegisterImage(@"hash_638DA8EF7E70CB06"))
	self:addElement(SideBar)
	self.SideBar = SideBar
	local SideBar2 = nil
	SideBar2 = LUI.UIImage.new(0, 0, 796, 801, 0, 1, 0, 0)
	SideBar2:setAlpha(0.25)
	SideBar2:setYRot(180)
	SideBar2:setImage(RegisterImage(@"hash_638DA8EF7E70CB06"))
	self:addElement(SideBar2)
	self.SideBar2 = SideBar2
	local CommonIdentityWidgetStreamlined = CoD.CommonIdentityWidgetStreamlined.new(f1_arg0, f1_arg1, 1, 1, -603.5, -73.5, 0, 0, 87, 127)
	CommonIdentityWidgetStreamlined:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlined:setModel(model, f1_arg1)
	end)
	self:addElement(CommonIdentityWidgetStreamlined)
	self.CommonIdentityWidgetStreamlined = CommonIdentityWidgetStreamlined
	self:mergeStateConditions({
		{
			stateName = "notEnoughPlasma",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, nil, false, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model and model:get(),
			modelName = nil,
		})
	end)
	self:linkToElementModel(self, nil, true, function(model)
		UpdateSelfElementState(f1_arg0, self, f1_arg1)
	end)
	List.id = "List"
	Featured.id = "Featured"
	self.__defaultFocus = List
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryPlasma_PopoutContainer.__resetProperties = function(f17_arg0)
	f17_arg0.titleNotEnoughPlasma:completeAnimation()
	f17_arg0.reason:completeAnimation()
	f17_arg0.titlePurchasePlasma:completeAnimation()
	f17_arg0.titleNotEnoughPlasma:setAlpha(1)
	f17_arg0.reason:setAlpha(1)
	f17_arg0.titlePurchasePlasma:setAlpha(1)
end
CoD.LaboratoryPlasma_PopoutContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.titleNotEnoughPlasma:completeAnimation()
			f18_arg0.titleNotEnoughPlasma:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.titleNotEnoughPlasma)
			f18_arg0.reason:completeAnimation()
			f18_arg0.reason:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.reason)
		end,
	},
	notEnoughPlasma = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.titlePurchasePlasma:completeAnimation()
			f19_arg0.titlePurchasePlasma:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.titlePurchasePlasma)
		end,
	},
}
CoD.LaboratoryPlasma_PopoutContainer.__onClose = function(f20_arg0)
	f20_arg0.List:close()
	f20_arg0.reason:close()
	f20_arg0.Featured:close()
	f20_arg0.HeaderUnderline:close()
	f20_arg0.CommonIdentityWidgetStreamlined:close()
end
