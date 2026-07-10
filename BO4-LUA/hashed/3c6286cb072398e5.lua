require("x64:ebfe24f09f3e978")
require("x64:de9e0a106439c01")
CoD.LaboratoryMixAgain = InheritFrom(LUI.UIElement)
CoD.LaboratoryMixAgain.__defaultWidth = 280
CoD.LaboratoryMixAgain.__defaultHeight = 1080
CoD.LaboratoryMixAgain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryMixAgain)
	self.id = "LaboratoryMixAgain"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(-1, 1, 0.5, 0.5, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local StoneTiledBacking = LUI.UIImage.new(-1, 1, 0, 0, 0.09, 0.09, -91, 116)
	StoneTiledBacking:setRGB(0.83, 0.11, 0.01)
	StoneTiledBacking:setAlpha(0.5)
	StoneTiledBacking:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonbgtile"))
	StoneTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	StoneTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	StoneTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(StoneTiledBacking)
	self.StoneTiledBacking = StoneTiledBacking
	local RedOverlay = LUI.UIImage.new(-1, 1, 0, 0, 0, 1, 0, 0)
	RedOverlay:setRGB(0.83, 0.11, 0.01)
	RedOverlay:setAlpha(0.02)
	self:addElement(RedOverlay)
	self.RedOverlay = RedOverlay
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -115, 115, 0, 0, 255.5, 485.5)
	FixedAspectRatioImage:setStretchedDimension(4)
	FixedAspectRatioImage:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local MixAgain = LUI.UIText.new(0.5, 1.5, -124, -156, 0, 0, 175.5, 205.5)
	MixAgain:setRGB(0.58, 0.85, 1)
	MixAgain:setText(LocalizeToUpperString(@"hash_1496C7B4FF40634"))
	MixAgain:setTTF("skorzhen")
	MixAgain:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MixAgain:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MixAgain)
	self.MixAgain = MixAgain
	local Name = LUI.UIText.new(0, 1, 16, -16, 0, 0, 527.5, 557.5)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("default")
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0, 1, 16, -16, 0, 0, 598.5, 616.5)
	Description:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Description:setTTF("default")
	Description:setLetterSpacing(1)
	Description:setLineSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local LaboratoryMixAgainButton = CoD.LaboratoryMixAgainButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -115, 115, 0, 0, 900.5, 976.5)
	LaboratoryMixAgainButton:linkToElementModel(self, nil, false, function(model)
		LaboratoryMixAgainButton:setModel(model, f1_arg1)
	end)
	LaboratoryMixAgainButton:linkToElementModel(self, "plasmaPrice", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			LaboratoryMixAgainButton.Button.Cost:setText(ConvertToUpperString(LocalizeIntoStringIfNotEmpty(@"hash_310EE05AA87A5498", f6_local0)))
		end
	end)
	local TopBar = LaboratoryMixAgainButton
	local DoneButton = LaboratoryMixAgainButton.subscribeToModel
	local BgZmStar = Engine[@"getmodelforcontroller"](f1_arg1)
	DoneButton(TopBar, BgZmStar["Laboratory.animState"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	TopBar = LaboratoryMixAgainButton
	DoneButton = LaboratoryMixAgainButton.subscribeToModel
	BgZmStar = Engine[@"getmodelforcontroller"](f1_arg1)
	DoneButton(TopBar, BgZmStar["Laboratory.disableInput"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LaboratoryMixAgainButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LaboratoryMixAgainButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			CoD.ZMLaboratoryUtility.MixAgain(self, menu, controller)
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			OpenPopup(self, "PurchasePlasma", controller, element:getModel())
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			local f10_local0 = OpenSystemOverlay
			local f10_local1 = self
			local f10_local2 = menu
			local f10_local3 = controller
			local f10_local4 = "NotEnoughNPPopup"
			local f10_local5 = {}
			local f10_local6 = element:getModel()
			f10_local5.npRequired = f10_local6.plasmaPrice:get()
			f10_local0(f10_local1, f10_local2, f10_local3, f10_local4, f10_local5)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(LaboratoryMixAgainButton)
	self.LaboratoryMixAgainButton = LaboratoryMixAgainButton
	DoneButton = nil
	DoneButton = CoD.LaboratoryMixAgainButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -115, 115, 0, 0, 900.5, 976.5)
	DoneButton.Button.Cost:setText(LocalizeToUpperString(@"menu/close"))
	BgZmStar = DoneButton
	TopBar = DoneButton.subscribeToModel
	local SideBar = Engine[@"getmodelforcontroller"](f1_arg1)
	TopBar(BgZmStar, SideBar["Laboratory.animState"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	BgZmStar = DoneButton
	TopBar = DoneButton.subscribeToModel
	SideBar = Engine[@"getmodelforcontroller"](f1_arg1)
	TopBar(BgZmStar, SideBar["Laboratory.disableInput"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	DoneButton:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DoneButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			SendClientScriptNotify(controller, "mix_again", "0")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DoneButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			SendClientScriptNotify(controller, "mix_again", "0")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ZMLaboratoryUtility.IsInAnimState1(controller, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(DoneButton)
	self.DoneButton = DoneButton
	TopBar = LUI.UIImage.new(0.5, 0.5, -120, 120, 0, 0, 202.5, 217.5)
	TopBar:setImage(RegisterImage(@"uie_ui_hud_zm_aar_top_bar"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	BgZmStar = LUI.UIImage.new(0.5, 0.5, -100, 100, 0, 0, 107, 307)
	BgZmStar:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	BgZmStar:setAlpha(0.4)
	BgZmStar:setImage(RegisterImage(@"uie_ui_hud_zm_arr_reward_star"))
	BgZmStar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BgZmStar:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(BgZmStar)
	self.BgZmStar = BgZmStar
	SideBar = LUI.UIImage.new(1, 1, -5, 0, 0, 1, 0, 0)
	SideBar:setAlpha(0.25)
	SideBar:setImage(RegisterImage(@"hash_638DA8EF7E70CB06"))
	self:addElement(SideBar)
	self.SideBar = SideBar
	local SideBar2 = nil
	SideBar2 = LUI.UIImage.new(0, 0, 0, 5, 0, 1, 0, 0)
	SideBar2:setAlpha(0.25)
	SideBar2:setZRot(180)
	SideBar2:setImage(RegisterImage(@"hash_638DA8EF7E70CB06"))
	self:addElement(SideBar2)
	self.SideBar2 = SideBar2
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LaboratoryMixAgainButton.id = "LaboratoryMixAgainButton"
	if CoD.isPC then
		DoneButton.id = "DoneButton"
	end
	self.__defaultFocus = LaboratoryMixAgainButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryMixAgain.__resetProperties = function(f20_arg0)
	f20_arg0.DoneButton:completeAnimation()
	f20_arg0.LaboratoryMixAgainButton:completeAnimation()
	f20_arg0.StoneTiledBacking:completeAnimation()
	f20_arg0.RedOverlay:completeAnimation()
	f20_arg0.NoiseTiledBacking:completeAnimation()
	f20_arg0.DoneButton:setTopBottom(0, 0, 900.5, 976.5)
	f20_arg0.LaboratoryMixAgainButton:setTopBottom(0, 0, 900.5, 976.5)
	f20_arg0.StoneTiledBacking:setLeftRight(-1, 1, 0, 0)
	f20_arg0.RedOverlay:setLeftRight(-1, 1, 0, 0)
	f20_arg0.NoiseTiledBacking:setLeftRight(-1, 1, 0.5, 0.5)
end
CoD.LaboratoryMixAgain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.NoiseTiledBacking:completeAnimation()
			f22_arg0.NoiseTiledBacking:setLeftRight(-0, 1, 0.5, 0.5)
			f22_arg0.clipFinished(f22_arg0.NoiseTiledBacking)
			f22_arg0.StoneTiledBacking:completeAnimation()
			f22_arg0.StoneTiledBacking:setLeftRight(0, 1, 0, 0)
			f22_arg0.clipFinished(f22_arg0.StoneTiledBacking)
			f22_arg0.RedOverlay:completeAnimation()
			f22_arg0.RedOverlay:setLeftRight(0, 1, 0, 0)
			f22_arg0.clipFinished(f22_arg0.RedOverlay)
			f22_arg0.LaboratoryMixAgainButton:completeAnimation()
			f22_arg0.LaboratoryMixAgainButton:setTopBottom(0, 0, 806.5, 882.5)
			f22_arg0.clipFinished(f22_arg0.LaboratoryMixAgainButton)
			f22_arg0.DoneButton:completeAnimation()
			f22_arg0.DoneButton:setTopBottom(0, 0, 900.5, 976.5)
			f22_arg0.clipFinished(f22_arg0.DoneButton)
		end,
	},
}
CoD.LaboratoryMixAgain.__onClose = function(f23_arg0)
	f23_arg0.FixedAspectRatioImage:close()
	f23_arg0.Name:close()
	f23_arg0.Description:close()
	f23_arg0.LaboratoryMixAgainButton:close()
	f23_arg0.DoneButton:close()
end
