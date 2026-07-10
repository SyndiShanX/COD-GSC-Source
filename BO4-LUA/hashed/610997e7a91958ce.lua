require("x64:fbffc86e9a93477")
require("x64:2d64ca9d3c705ce")
require("x64:71d2a0ed724628e")
require("x64:38c11a77e96e48c")
require("x64:dd778a9bfa8090d")
require("x64:f1e8b13ffafda55")
CoD.WZJumpKitSelectorInternal = InheritFrom(LUI.UIElement)
CoD.WZJumpKitSelectorInternal.__defaultWidth = 1920
CoD.WZJumpKitSelectorInternal.__defaultHeight = 1080
CoD.WZJumpKitSelectorInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZJumpKitSelectorInternal)
	self.id = "WZJumpKitSelectorInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:setAlpha(0)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	local InfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 504, 0, 0, 754.5, 904.5)
	self:addElement(InfoPanel)
	self.InfoPanel = InfoPanel
	local SelectedItems = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, false, false, false, false)
	SelectedItems:setLeftRight(0.5, 0.5, 526, 678)
	SelectedItems:setTopBottom(0, 0, 216, 694)
	SelectedItems:setWidgetType(CoD.JumpkitSelected)
	SelectedItems:setVerticalCount(3)
	SelectedItems:setSpacing(11)
	SelectedItems:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SelectedItems:setDataSource("WZJumpKitSelectedItems")
	self:addElement(SelectedItems)
	self.SelectedItems = SelectedItems
	local BgImage01 = LUI.UIImage.new(0.5, 0.5, -37, 503, 0, 0, 216, 756)
	BgImage01:setAlpha(0.5)
	BgImage01:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BgImage01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BgImage01:setShaderVector(0, 0, 0, 0, 0)
	BgImage01:setupNineSliceShader(196, 88)
	self:addElement(BgImage01)
	self.BgImage01 = BgImage01
	local itemImage = LUI.UIImage.new(0.5, 0.5, -36, 503, 0, 0, 216, 755)
	self:addElement(itemImage)
	self.itemImage = itemImage
	local FrontendFrame02 = LUI.UIImage.new(0.5, 0.5, -37, 505, 0, 0, 216, 756)
	FrontendFrame02:setAlpha(0.4)
	FrontendFrame02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local SelectedText = LUI.UIText.new(0.5, 0.5, 526, 678, 0, 0, 175, 196)
	SelectedText:setRGB(0.92, 0.89, 0.72)
	SelectedText:setText(LocalizeToUpperString(@"menu/equipped"))
	SelectedText:setTTF("ttmussels_demibold")
	SelectedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SelectedText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(SelectedText)
	self.SelectedText = SelectedText
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0.5, 0.5, -695, -150, 0, 0, 181.5, 920.5)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local DotLineBottom = LUI.UIImage.new(0.5, 0.5, -663, -185, 0, 0, 901.5, 905.5)
	DotLineBottom:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	DotLineBottom:setShaderVector(0, 0, 0, 0, 0)
	DotLineBottom:setShaderVector(1, 1, 1, 0, 0)
	DotLineBottom:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	local DotLineBottom2 = LUI.UIImage.new(0.5, 0.5, -663, -185, 0, 0, 197, 201)
	DotLineBottom2:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	DotLineBottom2:setShaderVector(0, 0, 0, 0, 0)
	DotLineBottom2:setShaderVector(1, 1, 1, 0, 0)
	DotLineBottom2:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(DotLineBottom2)
	self.DotLineBottom2 = DotLineBottom2
	local emblemListBg = LUI.UIImage.new(0.5, 0.5, -737, -103, 0, 0, 117, 962)
	emblemListBg:setScale(0.77, 0.77)
	emblemListBg:setImage(RegisterImage(@"uie_ui_menu_emblem_empty_bg"))
	emblemListBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	emblemListBg:setShaderVector(0, 0, 0, 0, 0)
	emblemListBg:setupNineSliceShader(212, 212)
	self:addElement(emblemListBg)
	self.emblemListBg = emblemListBg
	local optionsVerticalCounter = CoD.verticalCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, -580, -280, 0, 0, 862, 899)
	self:addElement(optionsVerticalCounter)
	self.optionsVerticalCounter = optionsVerticalCounter
	local WingsuitText = LUI.UIText.new(0.5, 0.5, -337, -185, 0, 0, 175, 196)
	WingsuitText:setRGB(0.92, 0.89, 0.72)
	WingsuitText:setText(LocalizeToUpperString(@"hash_1D31D93D47E71A15"))
	WingsuitText:setTTF("ttmussels_demibold")
	WingsuitText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WingsuitText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WingsuitText)
	self.WingsuitText = WingsuitText
	local TrailsText = LUI.UIText.new(0.5, 0.5, -500.5, -347.5, 0, 0, 175, 196)
	TrailsText:setRGB(0.92, 0.89, 0.72)
	TrailsText:setText(LocalizeToUpperString(@"hash_72F9555D2DB46C29"))
	TrailsText:setTTF("ttmussels_demibold")
	TrailsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TrailsText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(TrailsText)
	self.TrailsText = TrailsText
	local ParachuteText = LUI.UIText.new(0.5, 0.5, -663, -510, 0, 0, 175, 196)
	ParachuteText:setRGB(0.92, 0.89, 0.72)
	ParachuteText:setText(LocalizeToUpperString(@"menu/parachute"))
	ParachuteText:setTTF("ttmussels_regular")
	ParachuteText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ParachuteText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(ParachuteText)
	self.ParachuteText = ParachuteText
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	options:setLeftRight(0.5, 0.5, -663, -185)
	options:setTopBottom(0, 0, 216, 857)
	options:setWidgetType(CoD.JumpkitItemEntry)
	options:setHorizontalCount(3)
	options:setVerticalCount(4)
	options:setSpacing(11)
	options:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	options:setDataSource("WZJumpKitItems")
	local f1_local17 = options
	local f1_local18 = options.subscribeToModel
	local f1_local19 = DataSources.WZJumpKitItems.getModel(f1_arg1)
	f1_local18(f1_local17, f1_local19.updateSelections, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	options:registerEventHandler("list_item_lose_focus", function(element, event)
		local f4_local0 = nil
		CoD.BreadcrumbUtility.SetJumpkitPartOld(f1_arg0, element, f1_arg1)
		return f4_local0
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.PlayerRoleUtility.IsEquippedJumpkitItem(menu, controller, element) then
			PlaySoundAlias("uin_cac_equip_base")
			CoD.PlayerRoleUtility.EquipJumpkitItem(menu, controller, element)
			UpdateElementDataSource(self, "SelectedItems")
			SetMenuProperty(menu, "_appliedToAll", false)
			UpdateElementStateWithoutChildren(menu, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.PlayerRoleUtility.IsEquippedJumpkitItem(menu, controller, element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/equip", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	InfoPanel:linkToElementModel(options, nil, false, function(model)
		InfoPanel:setModel(model, f1_arg1)
	end)
	itemImage:linkToElementModel(options, "largeIcon", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			itemImage:setImage(RegisterImage(f9_local0))
		end
	end)
	SelectedItems.id = "SelectedItems"
	optionsVerticalCounter.id = "optionsVerticalCounter"
	options.id = "options"
	self.__defaultFocus = options
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local18 = self
	SetElementProperty(SelectedItems, "m_inputDisabled", true)
	SetAsListVerticalCounter(self, optionsVerticalCounter, "options")
	f1_local18 = options
	if IsPC() then
		SetElementProperty(f1_local18, "_checkChildFocusForSelectability", true)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local18, f1_arg1, "name", "", "")
	end
	return self
end
CoD.WZJumpKitSelectorInternal.__resetProperties = function(f10_arg0)
	f10_arg0.FramingCornerBrackets:completeAnimation()
	f10_arg0.emblemListBg:completeAnimation()
	f10_arg0.DotLineBottom2:completeAnimation()
	f10_arg0.DotLineBottom:completeAnimation()
	f10_arg0.options:completeAnimation()
	f10_arg0.ParachuteText:completeAnimation()
	f10_arg0.TrailsText:completeAnimation()
	f10_arg0.WingsuitText:completeAnimation()
	f10_arg0.optionsVerticalCounter:completeAnimation()
	f10_arg0.SelectedText:completeAnimation()
	f10_arg0.FrontendFrame02:completeAnimation()
	f10_arg0.SelectedItems:completeAnimation()
	f10_arg0.InfoPanel:completeAnimation()
	f10_arg0.itemImage:completeAnimation()
	f10_arg0.BgImage01:completeAnimation()
	f10_arg0.FramingCornerBrackets:setAlpha(0.1)
	f10_arg0.emblemListBg:setAlpha(1)
	f10_arg0.DotLineBottom2:setAlpha(1)
	f10_arg0.DotLineBottom:setAlpha(1)
	f10_arg0.options:setAlpha(1)
	f10_arg0.ParachuteText:setAlpha(1)
	f10_arg0.TrailsText:setAlpha(1)
	f10_arg0.WingsuitText:setAlpha(1)
	f10_arg0.optionsVerticalCounter:setAlpha(1)
	f10_arg0.SelectedText:setAlpha(1)
	f10_arg0.FrontendFrame02:setAlpha(0.4)
	f10_arg0.SelectedItems:setAlpha(1)
	f10_arg0.InfoPanel:setAlpha(1)
	f10_arg0.itemImage:setAlpha(1)
	f10_arg0.BgImage01:setAlpha(0.5)
end
CoD.WZJumpKitSelectorInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(15)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(100)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.InfoPanel:beginAnimation(230)
				f11_arg0.InfoPanel:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.InfoPanel:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.InfoPanel:completeAnimation()
			f11_arg0.InfoPanel:setAlpha(0)
			f11_local0(f11_arg0.InfoPanel)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(99)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.SelectedItems:beginAnimation(330)
				f11_arg0.SelectedItems:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SelectedItems:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.SelectedItems:completeAnimation()
			f11_arg0.SelectedItems:setAlpha(0)
			f11_local1(f11_arg0.SelectedItems)
			local f11_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(100)
					f17_arg0:setAlpha(0.5)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.BgImage01:beginAnimation(230)
				f11_arg0.BgImage01:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.BgImage01:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f11_arg0.BgImage01:completeAnimation()
			f11_arg0.BgImage01:setAlpha(0)
			f11_local2(f11_arg0.BgImage01)
			local f11_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(100)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.itemImage:beginAnimation(230)
				f11_arg0.itemImage:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f11_arg0.itemImage:completeAnimation()
			f11_arg0.itemImage:setAlpha(0)
			f11_local3(f11_arg0.itemImage)
			local f11_local4 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(100)
					f21_arg0:setAlpha(0.4)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.FrontendFrame02:beginAnimation(230)
				f11_arg0.FrontendFrame02:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FrontendFrame02:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f11_arg0.FrontendFrame02:completeAnimation()
			f11_arg0.FrontendFrame02:setAlpha(0)
			f11_local4(f11_arg0.FrontendFrame02)
			local f11_local5 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(99)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.SelectedText:beginAnimation(330)
				f11_arg0.SelectedText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SelectedText:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f11_arg0.SelectedText:completeAnimation()
			f11_arg0.SelectedText:setAlpha(0)
			f11_local5(f11_arg0.SelectedText)
			local f11_local6 = function(f24_arg0)
				f11_arg0.FramingCornerBrackets:beginAnimation(100)
				f11_arg0.FramingCornerBrackets:setAlpha(0.1)
				f11_arg0.FramingCornerBrackets:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FramingCornerBrackets:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FramingCornerBrackets:completeAnimation()
			f11_arg0.FramingCornerBrackets:setAlpha(0)
			f11_local6(f11_arg0.FramingCornerBrackets)
			local f11_local7 = function(f25_arg0)
				f11_arg0.DotLineBottom:beginAnimation(100)
				f11_arg0.DotLineBottom:setAlpha(1)
				f11_arg0.DotLineBottom:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DotLineBottom:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DotLineBottom:completeAnimation()
			f11_arg0.DotLineBottom:setAlpha(0)
			f11_local7(f11_arg0.DotLineBottom)
			local f11_local8 = function(f26_arg0)
				f11_arg0.DotLineBottom2:beginAnimation(100)
				f11_arg0.DotLineBottom2:setAlpha(1)
				f11_arg0.DotLineBottom2:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DotLineBottom2:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DotLineBottom2:completeAnimation()
			f11_arg0.DotLineBottom2:setAlpha(0)
			f11_local8(f11_arg0.DotLineBottom2)
			local f11_local9 = function(f27_arg0)
				f11_arg0.emblemListBg:beginAnimation(100)
				f11_arg0.emblemListBg:setAlpha(1)
				f11_arg0.emblemListBg:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.emblemListBg:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.emblemListBg:completeAnimation()
			f11_arg0.emblemListBg:setAlpha(0)
			f11_local9(f11_arg0.emblemListBg)
			local f11_local10 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(99)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.optionsVerticalCounter:beginAnimation(150)
				f11_arg0.optionsVerticalCounter:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.optionsVerticalCounter:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f11_arg0.optionsVerticalCounter:completeAnimation()
			f11_arg0.optionsVerticalCounter:setAlpha(0)
			f11_local10(f11_arg0.optionsVerticalCounter)
			local f11_local11 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(100)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.WingsuitText:beginAnimation(100)
				f11_arg0.WingsuitText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.WingsuitText:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f11_arg0.WingsuitText:completeAnimation()
			f11_arg0.WingsuitText:setAlpha(0)
			f11_local11(f11_arg0.WingsuitText)
			local f11_local12 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(100)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.TrailsText:beginAnimation(100)
				f11_arg0.TrailsText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.TrailsText:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f11_arg0.TrailsText:completeAnimation()
			f11_arg0.TrailsText:setAlpha(0)
			f11_local12(f11_arg0.TrailsText)
			local f11_local13 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(100)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.ParachuteText:beginAnimation(100)
				f11_arg0.ParachuteText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ParachuteText:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f11_arg0.ParachuteText:completeAnimation()
			f11_arg0.ParachuteText:setAlpha(0)
			f11_local13(f11_arg0.ParachuteText)
			local f11_local14 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(99)
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.options:beginAnimation(150)
				f11_arg0.options:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.options:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f11_arg0.options:completeAnimation()
			f11_arg0.options:setAlpha(0)
			f11_local14(f11_arg0.options)
		end,
	},
}
CoD.WZJumpKitSelectorInternal.__onClose = function(f38_arg0)
	f38_arg0.InfoPanel:close()
	f38_arg0.itemImage:close()
	f38_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
	f38_arg0.SelectedItems:close()
	f38_arg0.FramingCornerBrackets:close()
	f38_arg0.optionsVerticalCounter:close()
	f38_arg0.options:close()
end
