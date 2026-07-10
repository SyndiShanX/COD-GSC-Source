require("x64:7cd385da3abb8bd")
require("x64:eda152e1d10147a")
require("x64:62080ad3aaa22da")
require("x64:1f150bc74d5590f")
require("x64:c9a3c9eb5d5ac59")
require("x64:50e26e98239f317")
require("x64:a8235cfc956d5a0")
require("x64:c3fa19037d61cad")
require("x64:7889ce1e3e2e8a")
CoD.MPSpecialistHUB = InheritFrom(CoD.Menu)
LUI.createMenu.MPSpecialistHUB = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPSpecialistHUB", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.CreateGlobalModel("currentShowcasedCharacterIndex")
	self:setClass(CoD.MPSpecialistHUB)
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
	local CommonBgLayoutLinkLine = CoD.CommonBgLayoutLinkLine.new(f1_local1, f1_arg0, 0.5, 0.5, 234, 943, 0, 0, 157.5, 186.5)
	CommonBgLayoutLinkLine:setAlpha(0.5)
	CommonBgLayoutLinkLine:setZRot(180)
	self:addElement(CommonBgLayoutLinkLine)
	self.CommonBgLayoutLinkLine = CommonBgLayoutLinkLine
	local CommonBgLayoutLinkLine2 = CoD.CommonBgLayoutLinkLine.new(f1_local1, f1_arg0, 0.5, 0.5, -30.5, 678.5, 0, 0, 404.5, 433.5)
	CommonBgLayoutLinkLine2:setAlpha(0.9)
	CommonBgLayoutLinkLine2:setZRot(-90)
	self:addElement(CommonBgLayoutLinkLine2)
	self.CommonBgLayoutLinkLine2 = CommonBgLayoutLinkLine2
	local CommonInformationFrame = CoD.CommonInformationFrame.new(f1_local1, f1_arg0, 0.5, 0.5, 324, 811, 0.5, 0.5, -273, 219)
	self:addElement(CommonInformationFrame)
	self.CommonInformationFrame = CommonInformationFrame
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -135, 1920, 0, 0, 0, 1080)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x3CB558214901699))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
	local equipment = CoD.HubEquipmentItem.new(f1_local1, f1_arg0, 0.5, 0.5, 582, 782, 0, 0, 391, 737)
	equipment.categoryHeader:setText(LocalizeToUpperString(0x759164343B5C489))
	self:addElement(equipment)
	self.equipment = equipment
	local weapon = CoD.HubEquipmentItem.new(f1_local1, f1_arg0, 0.5, 0.5, 356.5, 556.5, 0, 0, 391, 737)
	weapon.categoryHeader:setText(LocalizeToUpperString(0x71489612B1BCA6F))
	self:addElement(weapon)
	self.weapon = weapon
	local specialists = LUI.UIList.new(f1_local1, f1_arg0, 12, 0, nil, false, false, false, false)
	specialists:setLeftRight(0.5, 0.5, -589, 55)
	specialists:setTopBottom(0, 0, 221.5, 764.5)
	specialists:setWidgetType(CoD.HubSpecialist_character)
	specialists:setHorizontalCount(4)
	specialists:setVerticalCount(3)
	specialists:setSpacing(12)
	specialists:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	specialists:setDataSource("PositionLoadoutList")
	specialists:linkToElementModel(specialists, "characterIndex", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local SpecialistCornerTL = specialists
	local SpecialistCornerTR = specialists.subscribeToModel
	local SpecialistCornerBR = Engine[0x8DF2E5447F384B9]()
	SpecialistCornerTR(SpecialistCornerTL, SpecialistCornerBR.currentShowcasedCharacterIndex, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	specialists:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(specialists, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		local f6_local0 = OpenOverlay
		local f6_local1 = self
		local f6_local2 = "MPSpecialistHUBInspect"
		local f6_local3 = controller
		local f6_local4 = {
			_sessionMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		}
		local f6_local5 = element:getModel()
		f6_local4._selectIndex = f6_local5.characterIndex:get()
		f6_local4._storageLoadoutBuffer = menu._storageLoadoutBuffer
		f6_local0(f6_local1, f6_local2, f6_local3, f6_local4)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(specialists, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, controller) then
			CoD.PlayerRoleUtility.SetAsSelectedShowcaseCharacter(element, controller)
			UpdateSelfElementState(menu, self.showcaseCheckbox, controller)
			PlaySoundAlias("uin_start_char_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(specialists)
	self.specialists = specialists
	SpecialistCornerTR = LUI.UIImage.new(0.5, 0.5, 75, 99, 0, 0, 205, 229)
	SpecialistCornerTR:setAlpha(0.25)
	SpecialistCornerTR:setZRot(-90)
	SpecialistCornerTR:setScale(0.5, 0.5)
	SpecialistCornerTR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTR)
	self.SpecialistCornerTR = SpecialistCornerTR
	SpecialistCornerTL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0, 0, 205, 229)
	SpecialistCornerTL:setAlpha(0.2)
	SpecialistCornerTL:setScale(0.5, 0.5)
	SpecialistCornerTL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTL)
	self.SpecialistCornerTL = SpecialistCornerTL
	SpecialistCornerBR = LUI.UIImage.new(0.5, 0.5, 75, 99, 0, 0, 781.5, 805.5)
	SpecialistCornerBR:setAlpha(0.2)
	SpecialistCornerBR:setZRot(180)
	SpecialistCornerBR:setScale(0.5, 0.5)
	SpecialistCornerBR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerBR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBR)
	self.SpecialistCornerBR = SpecialistCornerBR
	local SpecialistCornerBL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0, 0, 781.5, 805.5)
	SpecialistCornerBL:setAlpha(0.2)
	SpecialistCornerBL:setZRot(90)
	SpecialistCornerBL:setScale(0.5, 0.5)
	SpecialistCornerBL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerBL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBL)
	self.SpecialistCornerBL = SpecialistCornerBL
	local showcaseCheckbox = CoD.HubShowcaseCheckbox.new(f1_local1, f1_arg0, 0.5, 0.5, 324, 362, 0, 0, 793.5, 830.5)
	showcaseCheckbox:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter(element, f1_arg0)
			end,
		},
	})
	showcaseCheckbox:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_local1
		f1_local1:updateElementState(showcaseCheckbox, f11_arg1)
	end)
	local f1_local17 = showcaseCheckbox
	local CommonSearchingBar = showcaseCheckbox.subscribeToModel
	local f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg0)
	CommonSearchingBar(f1_local17, f1_local19.LastInput, function(f12_arg0)
		f1_local1:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	showcaseCheckbox:linkToElementModel(showcaseCheckbox, "characterIndex", true, function(model)
		f1_local1:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	f1_local17 = showcaseCheckbox
	CommonSearchingBar = showcaseCheckbox.subscribeToModel
	f1_local19 = Engine[0x8DF2E5447F384B9]()
	CommonSearchingBar(f1_local17, f1_local19.currentShowcasedCharacterIndex, function(f14_arg0)
		f1_local1:updateElementState(showcaseCheckbox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "currentShowcasedCharacterIndex",
		})
	end, false)
	showcaseCheckbox.label:setText(Engine[0xF9F1239CFD921FE](0xE14BE8E7A50BA2))
	self:addElement(showcaseCheckbox)
	self.showcaseCheckbox = showcaseCheckbox
	CommonSearchingBar = CoD.CommonSearchingBar.new(f1_local1, f1_arg0, 0, 0, 893, 1015, 0, 0, 787, 809)
	CommonSearchingBar:setAlpha(0.5)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	CommonInformationFrame:linkToElementModel(specialists, "jobTitle", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			CommonInformationFrame.altHeader:setText(Engine[0xF9F1239CFD921FE](f15_local0))
		end
	end)
	CommonInformationFrame:linkToElementModel(specialists, "name", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			CommonInformationFrame.header:setText(LocalizeToUpperString(f16_local0))
		end
	end)
	CommonInformationFrame:linkToElementModel(specialists, "detailedDesc", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			CommonInformationFrame.description:setText(Engine[0xF9F1239CFD921FE](f17_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.image", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			equipment.Icon:setImage(RegisterImage(f18_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.displayName", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			equipment.name:setText(LocalizeToUpperString(f19_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.statTitle", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			equipment.statHeader:setText(LocalizeToUpperString(f20_local0))
		end
	end)
	equipment:linkToElementModel(specialists, "equipment.statValue", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			equipment.statValue:setText(f21_local0)
		end
	end)
	weapon:linkToElementModel(specialists, "ability.image", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			weapon.Icon:setImage(RegisterImage(f22_local0))
		end
	end)
	weapon:linkToElementModel(specialists, "ability.displayName", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			weapon.name:setText(LocalizeToUpperString(f23_local0))
		end
	end)
	weapon:linkToElementModel(specialists, "ability.statTitle", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			weapon.statHeader:setText(LocalizeToUpperString(f24_local0))
		end
	end)
	weapon:linkToElementModel(specialists, "ability.statValue", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			weapon.statValue:setText(f25_local0)
		end
	end)
	showcaseCheckbox:linkToElementModel(specialists, nil, false, function(model)
		showcaseCheckbox:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
	end)
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
	end
	specialists.id = "specialists"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = specialists
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local17 = self
	f1_local17 = showcaseCheckbox
	if IsPC() then
		HideWidget(f1_local17)
	end
	return self
end
CoD.MPSpecialistHUB.__resetProperties = function(f30_arg0)
	f30_arg0.CommonSearchingBar:completeAnimation()
	f30_arg0.specialists:completeAnimation()
	f30_arg0.CommonBgLayoutLinkLine2:completeAnimation()
	f30_arg0.CommonInformationFrame:completeAnimation()
	f30_arg0.CommonBgLayoutLinkLine:completeAnimation()
	f30_arg0.weapon:completeAnimation()
	f30_arg0.equipment:completeAnimation()
	f30_arg0.showcaseCheckbox:completeAnimation()
	f30_arg0.CommonSearchingBar:setAlpha(0.5)
	f30_arg0.specialists:setAlpha(1)
	f30_arg0.CommonBgLayoutLinkLine2:setAlpha(0.9)
	f30_arg0.CommonInformationFrame:setAlpha(1)
	f30_arg0.CommonBgLayoutLinkLine:setAlpha(0.5)
	f30_arg0.weapon:setAlpha(1)
	f30_arg0.equipment:setAlpha(1)
	f30_arg0.showcaseCheckbox:setAlpha(1)
end
CoD.MPSpecialistHUB.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(8)
			local f31_local0 = function(f32_arg0)
				f32_arg0:beginAnimation(150)
				f32_arg0:setAlpha(0.5)
				f32_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.CommonBgLayoutLinkLine:beginAnimation(150)
			f31_arg0.CommonBgLayoutLinkLine:setAlpha(0)
			f31_arg0.CommonBgLayoutLinkLine:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.CommonBgLayoutLinkLine:registerEventHandler("transition_complete_keyframe", f31_local0)
			local f31_local1 = function(f33_arg0)
				f33_arg0:beginAnimation(150)
				f33_arg0:setAlpha(0.9)
				f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.CommonBgLayoutLinkLine2:beginAnimation(100)
			f31_arg0.CommonBgLayoutLinkLine2:setAlpha(0)
			f31_arg0.CommonBgLayoutLinkLine2:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.CommonBgLayoutLinkLine2:registerEventHandler("transition_complete_keyframe", f31_local1)
			local f31_local2 = function(f34_arg0)
				f34_arg0:beginAnimation(150)
				f34_arg0:setAlpha(1)
				f34_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.CommonInformationFrame:beginAnimation(150)
			f31_arg0.CommonInformationFrame:setAlpha(0)
			f31_arg0.CommonInformationFrame:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.CommonInformationFrame:registerEventHandler("transition_complete_keyframe", f31_local2)
			local f31_local3 = function(f35_arg0)
				f35_arg0:beginAnimation(160)
				f35_arg0:setAlpha(1)
				f35_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.equipment:beginAnimation(340)
			f31_arg0.equipment:setAlpha(0)
			f31_arg0.equipment:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.equipment:registerEventHandler("transition_complete_keyframe", f31_local3)
			local f31_local4 = function(f36_arg0)
				f36_arg0:beginAnimation(149)
				f36_arg0:setAlpha(1)
				f36_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.weapon:beginAnimation(300)
			f31_arg0.weapon:setAlpha(0)
			f31_arg0.weapon:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.weapon:registerEventHandler("transition_complete_keyframe", f31_local4)
			local f31_local5 = function(f37_arg0)
				f37_arg0:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f37_arg0:setAlpha(1)
				f37_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.specialists:beginAnimation(50)
			f31_arg0.specialists:setAlpha(0)
			f31_arg0.specialists:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.specialists:registerEventHandler("transition_complete_keyframe", f31_local5)
			local f31_local6 = function(f38_arg0)
				f38_arg0:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0:setAlpha(1)
				f38_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.showcaseCheckbox:beginAnimation(450)
			f31_arg0.showcaseCheckbox:setAlpha(0)
			f31_arg0.showcaseCheckbox:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.showcaseCheckbox:registerEventHandler("transition_complete_keyframe", f31_local6)
			local f31_local7 = function(f39_arg0)
				f39_arg0:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f39_arg0:setAlpha(0.5)
				f39_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.CommonSearchingBar:beginAnimation(50)
			f31_arg0.CommonSearchingBar:setAlpha(0)
			f31_arg0.CommonSearchingBar:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.CommonSearchingBar:registerEventHandler("transition_complete_keyframe", f31_local7)
		end,
	},
}
CoD.MPSpecialistHUB.__onClose = function(f40_arg0)
	f40_arg0.CommonInformationFrame:close()
	f40_arg0.equipment:close()
	f40_arg0.weapon:close()
	f40_arg0.showcaseCheckbox:close()
	f40_arg0.Background:close()
	f40_arg0.CommonBgLayoutLinkLine:close()
	f40_arg0.CommonBgLayoutLinkLine2:close()
	f40_arg0.SocialFrame:close()
	f40_arg0.specialists:close()
	f40_arg0.CommonSearchingBar:close()
end
