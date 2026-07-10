require("x64:ffbc64370f13dd9")
require("x64:ce1e6b6549d478c")
require("x64:74864184d366296")
require("x64:63b1db84578334f")
require("x64:7889ce1e3e2e8a")
CoD.MPSpecialistHUBWeapons = InheritFrom(CoD.Menu)
LUI.createMenu.MPSpecialistHUBWeapons = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPSpecialistHUBWeapons", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.SetModelFromExpression(f1_arg0, self, f1_arg1._model)
	self:setClass(CoD.MPSpecialistHUBWeapons)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.2)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -135, 1920, 0, 0, 0, 1080)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local weapon = CoD.HubWeaponVideoButton.new(f1_local1, f1_arg0, 0.5, 0.5, -615, -155, 0.5, 0.5, -296, 326)
	weapon.schemaHeader:setAlpha(0.3)
	weapon.mainHeader:setText(LocalizeToUpperString(@"menu/weapons"))
	weapon:linkToElementModel(self, "ability.description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			weapon.description:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	weapon.schema.__schema = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			weapon.schema:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PlayerRoleUtility.SetWeaponSchemaString(self, f1_arg0, f3_local0)))
		end
	end
	weapon:linkToElementModel(self, "weaponSchema", true, weapon.schema.__schema)
	weapon.schema.__schema_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.weaponSchema
		end
		if f4_local0 then
			weapon.schema.__schema(f4_local0)
		end
	end
	weapon:linkToElementModel(self, "weaponMovie", false, function(model)
		weapon.VoDPreviewWidget:setModel(model, f1_arg0)
	end)
	weapon:linkToElementModel(self, "ability.displayName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			weapon.itemName:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	weapon:linkToElementModel(weapon, "weaponMovie.hiResVideo.movieName", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	weapon:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(weapon, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, controller, "weaponMovie.hiResVideo.movieName") then
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, self, "weaponMovie.hiResVideo")
			SetLoseFocusToElement(self, "weapon", controller)
			DelayOpenOverlay(menu, "VoDViewer", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, controller, "weaponMovie.hiResVideo.movieName") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(weapon)
	self.weapon = weapon
	local speccialIssue = CoD.HubWeaponVideoButton.new(f1_local1, f1_arg0, 0.5, 0.5, 155, 615, 0.5, 0.5, -296, 326)
	speccialIssue.schemaHeader:setAlpha(0.3)
	speccialIssue.mainHeader:setText(LocalizeToUpperString(@"weapon/special_issue"))
	speccialIssue:linkToElementModel(self, "equipment.description", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			speccialIssue.description:setText(Engine[@"hash_4F9F1239CFD921FE"](f11_local0))
		end
	end)
	speccialIssue:linkToElementModel(self, "specialIssueSchema", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			speccialIssue.schema:setText(Engine[@"hash_4F9F1239CFD921FE"](f12_local0))
		end
	end)
	speccialIssue:linkToElementModel(self, "specialIssueMovie", false, function(model)
		speccialIssue.VoDPreviewWidget:setModel(model, f1_arg0)
	end)
	speccialIssue:linkToElementModel(self, "equipment.displayName", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			speccialIssue.itemName:setText(LocalizeToUpperString(f14_local0))
		end
	end)
	speccialIssue:linkToElementModel(speccialIssue, "specialIssueMovie.hiResVideo.movieName", true, function(model, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	speccialIssue:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f16_local0
	end)
	f1_local1:AddButtonCallbackFunction(speccialIssue, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, controller, "specialIssueMovie.hiResVideo.movieName") then
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, self, "specialIssueMovie.hiResVideo")
			SetLoseFocusToElement(self, "speccialIssue", controller)
			DelayOpenOverlay(menu, "VoDViewer", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, controller, "specialIssueMovie.hiResVideo.movieName") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(speccialIssue)
	self.speccialIssue = speccialIssue
	local tips = CoD.HubWeaponVideoButton.new(f1_local1, f1_arg0, 0.5, 0.5, 298, 758, 0.5, 0.5, -296, 326)
	tips:setAlpha(0)
	tips.schema:setText("")
	tips.schemaHeader:setAlpha(0)
	tips.itemName:setText(LocalizeToUpperString(@"hash_28004CEB4C794986"))
	tips.mainHeader:setText(LocalizeToUpperString(@"menu/in_action"))
	tips:linkToElementModel(self, "name", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			tips.description:setText(LocalizeIntoString(@"hash_444724E9BB68E576", f19_local0))
		end
	end)
	tips:linkToElementModel(self, "tipsMovie", false, function(model)
		tips.VoDPreviewWidget:setModel(model, f1_arg0)
	end)
	tips:linkToElementModel(tips, "tipsMovie.hiResVideo.movieName", true, function(model, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	tips:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f22_local0
	end)
	f1_local1:AddButtonCallbackFunction(tips, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, controller, "tipsMovie.hiResVideo.movieName") then
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, self, "tipsMovie.hiResVideo")
			SetLoseFocusToElement(self, "tips", controller)
			DelayOpenOverlay(menu, "VoDViewer", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, controller, "tipsMovie.hiResVideo.movieName") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(tips)
	self.tips = tips
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f25_local0 = nil
		if element.menuLoaded then
			f25_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f25_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f25_local0 then
			f25_local0 = element:dispatchEventToChildren(event)
		end
		return f25_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local BarRight = LUI.UIImage.new(0.5, 0.5, 841, 899, 0.5, 0.5, -22, 6)
	BarRight:setAlpha(0.3)
	BarRight:setImage(RegisterImage(@"uie_ui_hud_selectspawn_layout_boxside"))
	self:addElement(BarRight)
	self.BarRight = BarRight
	local BarLeft = LUI.UIImage.new(0.5, 0.5, -899, -841, 0.5, 0.5, -22, 6)
	BarLeft:setAlpha(0.3)
	BarLeft:setImage(RegisterImage(@"uie_ui_hud_selectspawn_layout_boxside"))
	self:addElement(BarLeft)
	self.BarLeft = BarLeft
	local LayoutBotStripe = LUI.UIImage.new(0.5, 0.5, -683, 693, 0.5, 0.5, 403.5, 431.5)
	LayoutBotStripe:setAlpha(0.5)
	LayoutBotStripe:setImage(RegisterImage(@"hash_36E1590316DA74B"))
	LayoutBotStripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(LayoutBotStripe)
	self.LayoutBotStripe = LayoutBotStripe
	local LayoutCornerTL = LUI.UIImage.new(0.5, 0.5, -888, -832, 0.5, 0.5, -448, -392)
	LayoutCornerTL:setAlpha(0.06)
	LayoutCornerTL:setImage(RegisterImage(0x832A542979692A))
	self:addElement(LayoutCornerTL)
	self.LayoutCornerTL = LayoutCornerTL
	local LayoutCornerTR = LUI.UIImage.new(0.5, 0.5, 832, 888, 0.5, 0.5, -448, -392)
	LayoutCornerTR:setAlpha(0.06)
	LayoutCornerTR:setZRot(-90)
	LayoutCornerTR:setImage(RegisterImage(0x832A542979692A))
	self:addElement(LayoutCornerTR)
	self.LayoutCornerTR = LayoutCornerTR
	local LayoutCornerBL = LUI.UIImage.new(0.5, 0.5, -888, -832, 0.5, 0.5, 378, 434)
	LayoutCornerBL:setAlpha(0.06)
	LayoutCornerBL:setZRot(90)
	LayoutCornerBL:setImage(RegisterImage(0x832A542979692A))
	self:addElement(LayoutCornerBL)
	self.LayoutCornerBL = LayoutCornerBL
	local LayoutCornerBR = LUI.UIImage.new(0.5, 0.5, 833, 888, 0.5, 0.5, 378, 434)
	LayoutCornerBR:setAlpha(0.06)
	LayoutCornerBR:setZRot(180)
	LayoutCornerBR:setImage(RegisterImage(0x832A542979692A))
	self:addElement(LayoutCornerBR)
	self.LayoutCornerBR = LayoutCornerBR
	local LayoutTopBar = LUI.UIImage.new(0.5, 0.5, -888, 888, 0.5, 0.5, -505.5, -485.5)
	LayoutTopBar:setAlpha(0.6)
	LayoutTopBar:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_layout_topbar"))
	LayoutTopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	LayoutTopBar:setShaderVector(0, 0, 0, 0, 0)
	LayoutTopBar:setupNineSliceShader(6, 6)
	self:addElement(LayoutTopBar)
	self.LayoutTopBar = LayoutTopBar
	local header = LUI.UIText.new(0.5, 0.5, -621, 513, 0.5, 0.5, -448, -381)
	header:setRGB(0.96, 0.93, 0.84)
	header:setAlpha(0.7)
	header:setTTF("ttmussels_regular")
	header:setLetterSpacing(14)
	header:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(header)
	self.header = header
	local GridOutlineBL = LUI.UIImage.new(0.5, 0.5, -1033, -693, 0.5, 0.5, 189, 191)
	GridOutlineBL:setAlpha(0.1)
	GridOutlineBL:setZRot(90)
	GridOutlineBL:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	GridOutlineBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridOutlineBL:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineBL:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineBL)
	self.GridOutlineBL = GridOutlineBL
	local GridOutlineTL = LUI.UIImage.new(0.5, 0.5, -1033, -693, 0.5, 0.5, -209, -207)
	GridOutlineTL:setAlpha(0.1)
	GridOutlineTL:setZRot(90)
	GridOutlineTL:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	GridOutlineTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridOutlineTL:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineTL:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineTL)
	self.GridOutlineTL = GridOutlineTL
	local GridOutlineBR = LUI.UIImage.new(0.5, 0.5, 704, 1044, 0.5, 0.5, 190, 192)
	GridOutlineBR:setAlpha(0.1)
	GridOutlineBR:setZRot(90)
	GridOutlineBR:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	GridOutlineBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridOutlineBR:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineBR:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineBR)
	self.GridOutlineBR = GridOutlineBR
	local GridOutlineTR = LUI.UIImage.new(0.5, 0.5, 704, 1044, 0.5, 0.5, -207, -205)
	GridOutlineTR:setAlpha(0.1)
	GridOutlineTR:setZRot(90)
	GridOutlineTR:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	GridOutlineTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridOutlineTR:setShaderVector(0, 0, 0, 0, 0)
	GridOutlineTR:setupNineSliceShader(4, 2)
	self:addElement(GridOutlineTR)
	self.GridOutlineTR = GridOutlineTR
	local BoxHighlighted = CoD.CommonBgLayoutElement03.new(f1_local1, f1_arg0, 0.5, 0.5, 804, 880, 0.5, 0.5, -660, -280)
	BoxHighlighted:setAlpha(0.8)
	BoxHighlighted:setZRot(90)
	BoxHighlighted:setScale(0.25, 0.25)
	self:addElement(BoxHighlighted)
	self.BoxHighlighted = BoxHighlighted
	local DividerCenter = LUI.UIImage.new(0.5, 0.5, -247, 245, 0, 0, 555, 561)
	DividerCenter:setAlpha(0.3)
	DividerCenter:setZRot(90)
	DividerCenter:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_dotline"))
	DividerCenter:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DividerCenter:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(DividerCenter)
	self.DividerCenter = DividerCenter
	weapon:appendEventHandler("input_source_changed", weapon.schema.__schema_FullPath)
	local f1_local24 = weapon
	local f1_local25 = weapon.subscribeToModel
	local f1_local26 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local25(f1_local24, f1_local26.LastInput, weapon.schema.__schema_FullPath)
	self.header:linkToElementModel(self, "name", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			header:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_6D39A0B9A6D35B18", f26_local0)))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	weapon.id = "weapon"
	speccialIssue.id = "speccialIssue"
	tips.id = "tips"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
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
CoD.MPSpecialistHUBWeapons.__resetProperties = function(f30_arg0)
	f30_arg0.weapon:completeAnimation()
	f30_arg0.tips:completeAnimation()
	f30_arg0.speccialIssue:completeAnimation()
	f30_arg0.weapon:setAlpha(1)
	f30_arg0.tips:setAlpha(0)
	f30_arg0.speccialIssue:setAlpha(1)
end
CoD.MPSpecialistHUBWeapons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			local f31_local0 = function(f32_arg0)
				f31_arg0.weapon:beginAnimation(150)
				f31_arg0.weapon:setAlpha(1)
				f31_arg0.weapon:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.weapon:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.weapon:completeAnimation()
			f31_arg0.weapon:setAlpha(0)
			f31_local0(f31_arg0.weapon)
			local f31_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(149)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.speccialIssue:beginAnimation(200)
				f31_arg0.speccialIssue:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.speccialIssue:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f31_arg0.speccialIssue:completeAnimation()
			f31_arg0.speccialIssue:setAlpha(0)
			f31_local1(f31_arg0.speccialIssue)
			f31_arg0.tips:completeAnimation()
			f31_arg0.tips:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.tips)
		end,
	},
}
CoD.MPSpecialistHUBWeapons.__onClose = function(f35_arg0)
	f35_arg0.Background:close()
	f35_arg0.weapon:close()
	f35_arg0.speccialIssue:close()
	f35_arg0.tips:close()
	f35_arg0.FooterContainerFrontendRight:close()
	f35_arg0.header:close()
	f35_arg0.BoxHighlighted:close()
end
