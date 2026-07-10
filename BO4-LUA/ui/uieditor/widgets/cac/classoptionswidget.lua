require("x64:f432feaf297b8de")
require("x64:62cb1d00e50cc75")
require("x64:ff03870cd3bee03")
require("x64:30f6657af27fb76")
require("x64:c83f9a398165f22")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.ClassOptionsWidget = InheritFrom(LUI.UIElement)
CoD.ClassOptionsWidget.__defaultWidth = 1920
CoD.ClassOptionsWidget.__defaultHeight = 1080
CoD.ClassOptionsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassOptionsWidget)
	self.id = "ClassOptionsWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCBacking = nil
	PCBacking = CoD.PC_ClassOptionsPopup.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0, 1, 0, 0)
	PCBacking:setAlpha(0)
	self:addElement(PCBacking)
	self.PCBacking = PCBacking
	local CommonRightSlideInPopup = CoD.CommonRightSlideInPopup.new(f1_arg0, f1_arg1, 1, 1, -1920, 0, 0.5, 0.5, -540, 540)
	self:addElement(CommonRightSlideInPopup)
	self.CommonRightSlideInPopup = CommonRightSlideInPopup
	local buttons = CoD.FooterButton_Frontend_Right.new(f1_arg0, f1_arg1, 1, 1, -1920, 0, 1, 1, -48, 0)
	self:addElement(buttons)
	self.buttons = buttons
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 1, 1, -525, -365, 1, 1, -60, 0)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x78D439E1B360368))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local ClassSetOptionsList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	ClassSetOptionsList:setLeftRight(1, 1, -465.5, -80.5)
	ClassSetOptionsList:setTopBottom(0, 0, 601, 707)
	ClassSetOptionsList:setWidgetType(CoD.CommonListButtonGeneric)
	ClassSetOptionsList:setVerticalCount(2)
	ClassSetOptionsList:setSpacing(20)
	ClassSetOptionsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClassSetOptionsList:setDataSource("CACClassOptions")
	ClassSetOptionsList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		ClassOptionsSetHintText(f1_arg0, element, f1_arg1)
		return f5_local0
	end)
	ClassSetOptionsList:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsClassSetsAvailableForCurrentGameMode() then
			MakeNotFocusable(element, f1_arg1)
		elseif not DoesPlayerHaveExtraSlotsItem(f1_arg1) then
			MakeNotFocusable(element, f1_arg1)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	ClassSetOptionsList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ClassSetOptionsList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(ClassSetOptionsList)
	self.ClassSetOptionsList = ClassSetOptionsList
	local TitleSeparator2 = LUI.UIImage.new(1, 1, -462.5, -82.5, 0, 0, 601, 602)
	TitleSeparator2:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	self:addElement(TitleSeparator2)
	self.TitleSeparator2 = TitleSeparator2
	local TitleSeparator3 = nil
	TitleSeparator3 = LUI.UIImage.new(0.5, 0.5, -162.5, 162.5, 0, 0, 275, 276)
	TitleSeparator3:setAlpha(0.03)
	self:addElement(TitleSeparator3)
	self.TitleSeparator3 = TitleSeparator3
	local Image = nil
	Image = LUI.UIImage.new(0.5, 0.5, -192.5, 192.5, 0, 0, 139, 182)
	Image:setAlpha(0.02)
	self:addElement(Image)
	self.Image = Image
	local ClassNameLabelBacking = nil
	ClassNameLabelBacking = LUI.UIImage.new(0.5, 0.5, -192.5, 192.5, 0, 0, 139, 182)
	ClassNameLabelBacking:setAlpha(0.5)
	ClassNameLabelBacking:setImage(RegisterImage(0x34839E8065B1E53))
	ClassNameLabelBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	ClassNameLabelBacking:setShaderVector(0, 0, 0, 0, 0)
	ClassNameLabelBacking:setupNineSliceShader(196, 88)
	self:addElement(ClassNameLabelBacking)
	self.ClassNameLabelBacking = ClassNameLabelBacking
	local ClassNamelLabel = nil
	ClassNamelLabel = LUI.UIText.new(0.5, 0.5, -192.5, 192.5, 0, 0, 146, 175)
	ClassNamelLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ClassNamelLabel:setAlpha(0.2)
	ClassNamelLabel:setText(LocalizeToUpperString(0xDD163B6B797AB91))
	ClassNamelLabel:setTTF("ttmussels_regular")
	ClassNamelLabel:setLetterSpacing(4)
	ClassNamelLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(ClassNamelLabel)
	self.ClassNamelLabel = ClassNamelLabel
	local PCClassOptionRenameBox = nil
	PCClassOptionRenameBox = CoD.PC_ClassOptionRenameBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -192.5, 192.5, 0, 0, 182, 232)
	self:addElement(PCClassOptionRenameBox)
	self.PCClassOptionRenameBox = PCClassOptionRenameBox
	local ClassOptionsTitle = nil
	ClassOptionsTitle = LUI.UIText.new(0.5, 0.5, -192.5, 192.5, 0, 0, 40, 79)
	ClassOptionsTitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	ClassOptionsTitle:setText(LocalizeToUpperString(0x27F19FF8EF11A44))
	ClassOptionsTitle:setTTF("ttmussels_demibold")
	ClassOptionsTitle:setLetterSpacing(2)
	ClassOptionsTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(ClassOptionsTitle)
	self.ClassOptionsTitle = ClassOptionsTitle
	local CurrentClassName = LUI.UIText.new(1, 1, -460.5, -82.5, 0, 0, 128, 167)
	CurrentClassName:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	CurrentClassName:setTTF("notosans_bold")
	CurrentClassName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CurrentClassName:subscribeToGlobalModel(f1_arg1, "CACClassOptions", "customClassName", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CurrentClassName:setText(f10_local0)
		end
	end)
	self:addElement(CurrentClassName)
	self.CurrentClassName = CurrentClassName
	local ClassSetTitle = LUI.UIText.new(1, 1, -460.5, -82.5, 0, 0, 551.5, 590.5)
	ClassSetTitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	ClassSetTitle:setTTF("notosans_bold")
	ClassSetTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClassSetTitle:subscribeToGlobalModel(f1_arg1, "CustomClassMenu", "customClassSetName", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ClassSetTitle:setText(f11_local0)
		end
	end)
	self:addElement(ClassSetTitle)
	self.ClassSetTitle = ClassSetTitle
	local TitleSeparator = LUI.UIImage.new(1, 1, -462.5, -82.5, 0, 0, 175, 176)
	TitleSeparator:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	self:addElement(TitleSeparator)
	self.TitleSeparator = TitleSeparator
	local ClassOptionsList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	ClassOptionsList:setLeftRight(1, 1, -467.5, -82.5)
	ClassOptionsList:setTopBottom(0, 0, 272, 504)
	ClassOptionsList:setWidgetType(CoD.CommonListButtonGeneric)
	ClassOptionsList:setVerticalCount(4)
	ClassOptionsList:setSpacing(20)
	ClassOptionsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClassOptionsList:setDataSource("CACClassOptions")
	ClassOptionsList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f12_local0 = nil
		ClassOptionsSetHintText(f1_arg0, element, f1_arg1)
		return f12_local0
	end)
	ClassOptionsList:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ClassOptionsList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(ClassOptionsList)
	self.ClassOptionsList = ClassOptionsList
	local ClassOptionDesc = LUI.UIText.new(1, 1, -459.5, -49.5, 0, 0, 200.5, 219.5)
	ClassOptionDesc:setTTF("dinnext_regular")
	ClassOptionDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClassOptionDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ClassOptionDesc:subscribeToGlobalModel(f1_arg1, "CACClassOptions", "customClassOptionsHintText", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			ClassOptionDesc:setText(Engine[0xF9F1239CFD921FE](f16_local0))
		end
	end)
	self:addElement(ClassOptionDesc)
	self.ClassOptionDesc = ClassOptionDesc
	local PCSmallCloseButton = nil
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 336, 370, 0.5, 0.5, -500, -466)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f17_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCSmallCloseButton)
	self.PCSmallCloseButton = PCSmallCloseButton
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "PCclassSets",
			condition = function(menu, element, event)
				local f23_local0 = IsClassSetsAvailableForCurrentGameMode()
				if f23_local0 then
					f23_local0 = DoesPlayerHaveExtraSlotsItem(f1_arg1)
					if f23_local0 then
						f23_local0 = IsPC()
					end
				end
				return f23_local0
			end,
		},
		{
			stateName = "ClassSets",
			condition = function(menu, element, event)
				local f24_local0 = IsClassSetsAvailableForCurrentGameMode()
				if f24_local0 then
					f24_local0 = DoesPlayerHaveExtraSlotsItem(f1_arg1)
					if f24_local0 then
						f24_local0 = not IsPC()
					end
				end
				return f24_local0
			end,
		},
	})
	buttons:appendEventHandler("menu_loaded", function()
		buttons:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		buttons.id = "buttons"
	end
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	ClassSetOptionsList.id = "ClassSetOptionsList"
	if CoD.isPC then
		PCClassOptionRenameBox.id = "PCClassOptionRenameBox"
	end
	ClassOptionsList.id = "ClassOptionsList"
	if CoD.isPC then
		PCSmallCloseButton.id = "PCSmallCloseButton"
	end
	self.__defaultFocus = ClassOptionsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local19 = self
	MenuHidesFreeCursor(f1_arg0, f1_arg1)
	PlaySoundAlias("uin_party_ease_slide")
	return self
end
CoD.ClassOptionsWidget.__resetProperties = function(f26_arg0)
	f26_arg0.ClassSetTitle:completeAnimation()
	f26_arg0.ClassSetOptionsList:completeAnimation()
	f26_arg0.TitleSeparator2:completeAnimation()
	f26_arg0.PCClassOptionRenameBox:completeAnimation()
	f26_arg0.ClassOptionsList:completeAnimation()
	f26_arg0.ClassOptionDesc:completeAnimation()
	f26_arg0.TitleSeparator:completeAnimation()
	f26_arg0.CurrentClassName:completeAnimation()
	f26_arg0.CommonRightSlideInPopup:completeAnimation()
	f26_arg0.PCBacking:completeAnimation()
	f26_arg0.featureOverlayButtonMouseOnly:completeAnimation()
	f26_arg0.buttons:completeAnimation()
	f26_arg0.ClassSetTitle:setLeftRight(1, 1, -460.5, -82.5)
	f26_arg0.ClassSetTitle:setTopBottom(0, 0, 551.5, 590.5)
	f26_arg0.ClassSetTitle:setAlpha(1)
	f26_arg0.ClassSetOptionsList:setLeftRight(1, 1, -465.5, -80.5)
	f26_arg0.ClassSetOptionsList:setTopBottom(0, 0, 601, 707)
	f26_arg0.ClassSetOptionsList:setAlpha(1)
	f26_arg0.TitleSeparator2:setLeftRight(1, 1, -462.5, -82.5)
	f26_arg0.TitleSeparator2:setTopBottom(0, 0, 601, 602)
	f26_arg0.TitleSeparator2:setAlpha(1)
	f26_arg0.PCClassOptionRenameBox:setLeftRight(0.5, 0.5, -192.5, 192.5)
	f26_arg0.PCClassOptionRenameBox:setTopBottom(0, 0, 182, 232)
	f26_arg0.ClassOptionsList:setLeftRight(1, 1, -467.5, -82.5)
	f26_arg0.ClassOptionsList:setTopBottom(0, 0, 272, 504)
	f26_arg0.ClassOptionDesc:setLeftRight(1, 1, -459.5, -49.5)
	f26_arg0.ClassOptionDesc:setTopBottom(0, 0, 200.5, 219.5)
	f26_arg0.ClassOptionDesc:setAlpha(1)
	f26_arg0.TitleSeparator:setLeftRight(1, 1, -462.5, -82.5)
	f26_arg0.TitleSeparator:setTopBottom(0, 0, 175, 176)
	f26_arg0.TitleSeparator:setAlpha(1)
	f26_arg0.CurrentClassName:setLeftRight(1, 1, -460.5, -82.5)
	f26_arg0.CurrentClassName:setTopBottom(0, 0, 128, 167)
	f26_arg0.CurrentClassName:setAlpha(1)
	f26_arg0.CommonRightSlideInPopup:setLeftRight(1, 1, -1920, 0)
	f26_arg0.CommonRightSlideInPopup:setAlpha(1)
	f26_arg0.PCBacking:setAlpha(0)
	f26_arg0.featureOverlayButtonMouseOnly:setLeftRight(1, 1, -525, -365)
	f26_arg0.featureOverlayButtonMouseOnly:setTopBottom(1, 1, -60, 0)
	f26_arg0.buttons:setLeftRight(1, 1, -1920, 0)
	f26_arg0.buttons:setAlpha(1)
end
CoD.ClassOptionsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.ClassSetOptionsList:completeAnimation()
			f27_arg0.ClassSetOptionsList:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ClassSetOptionsList)
			f27_arg0.TitleSeparator2:completeAnimation()
			f27_arg0.TitleSeparator2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.TitleSeparator2)
			f27_arg0.PCClassOptionRenameBox:completeAnimation()
			f27_arg0.PCClassOptionRenameBox:setLeftRight(1, 1, -494.5, -82.5)
			f27_arg0.PCClassOptionRenameBox:setTopBottom(0, 0, 128, 158)
			f27_arg0.clipFinished(f27_arg0.PCClassOptionRenameBox)
			f27_arg0.ClassSetTitle:completeAnimation()
			f27_arg0.ClassSetTitle:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ClassSetTitle)
		end,
		Intro = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(8)
			local f28_local0 = function(f29_arg0)
				f28_arg0.CommonRightSlideInPopup:beginAnimation(200)
				f28_arg0.CommonRightSlideInPopup:setLeftRight(1, 1, -1920, 0)
				f28_arg0.CommonRightSlideInPopup:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CommonRightSlideInPopup:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CommonRightSlideInPopup:completeAnimation()
			f28_arg0.CommonRightSlideInPopup:setLeftRight(1, 1, -1371, 549)
			f28_local0(f28_arg0.CommonRightSlideInPopup)
			f28_arg0.ClassSetOptionsList:completeAnimation()
			f28_arg0.ClassSetOptionsList:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ClassSetOptionsList)
			f28_arg0.TitleSeparator2:completeAnimation()
			f28_arg0.TitleSeparator2:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.TitleSeparator2)
			local f28_local1 = function(f30_arg0)
				f28_arg0.CurrentClassName:beginAnimation(200)
				f28_arg0.CurrentClassName:setLeftRight(1, 1, -460.5, -82.5)
				f28_arg0.CurrentClassName:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CurrentClassName:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CurrentClassName:completeAnimation()
			f28_arg0.CurrentClassName:setLeftRight(1, 1, 88.5, 466.5)
			f28_local1(f28_arg0.CurrentClassName)
			f28_arg0.ClassSetTitle:completeAnimation()
			f28_arg0.ClassSetTitle:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ClassSetTitle)
			local f28_local2 = function(f31_arg0)
				f28_arg0.TitleSeparator:beginAnimation(200)
				f28_arg0.TitleSeparator:setLeftRight(1, 1, -462.5, -82.5)
				f28_arg0.TitleSeparator:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.TitleSeparator:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.TitleSeparator:completeAnimation()
			f28_arg0.TitleSeparator:setLeftRight(1, 1, 86.5, 466.5)
			f28_local2(f28_arg0.TitleSeparator)
			local f28_local3 = function(f32_arg0)
				f28_arg0.ClassOptionsList:beginAnimation(200)
				f28_arg0.ClassOptionsList:setLeftRight(1, 1, -467.5, -82.5)
				f28_arg0.ClassOptionsList:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ClassOptionsList:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.ClassOptionsList:completeAnimation()
			f28_arg0.ClassOptionsList:setLeftRight(1, 1, 81.5, 466.5)
			f28_local3(f28_arg0.ClassOptionsList)
			local f28_local4 = function(f33_arg0)
				f28_arg0.ClassOptionDesc:beginAnimation(200)
				f28_arg0.ClassOptionDesc:setLeftRight(1, 1, -459.5, -49.5)
				f28_arg0.ClassOptionDesc:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ClassOptionDesc:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.ClassOptionDesc:completeAnimation()
			f28_arg0.ClassOptionDesc:setLeftRight(1, 1, 89.5, 499.5)
			f28_local4(f28_arg0.ClassOptionDesc)
		end,
	},
	PC = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(11)
			f34_arg0.PCBacking:completeAnimation()
			f34_arg0.PCBacking:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.PCBacking)
			f34_arg0.CommonRightSlideInPopup:completeAnimation()
			f34_arg0.CommonRightSlideInPopup:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.CommonRightSlideInPopup)
			f34_arg0.buttons:completeAnimation()
			f34_arg0.buttons:setLeftRight(0.5, 0.5, -1440, 480)
			f34_arg0.buttons:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.buttons)
			f34_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f34_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -339, -179)
			f34_arg0.featureOverlayButtonMouseOnly:setTopBottom(1, 1, -108, -48)
			f34_arg0.clipFinished(f34_arg0.featureOverlayButtonMouseOnly)
			f34_arg0.ClassSetOptionsList:completeAnimation()
			f34_arg0.ClassSetOptionsList:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f34_arg0.ClassSetOptionsList:setTopBottom(0.5, 0.5, 61, 167)
			f34_arg0.ClassSetOptionsList:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ClassSetOptionsList)
			f34_arg0.TitleSeparator2:completeAnimation()
			f34_arg0.TitleSeparator2:setLeftRight(0.5, 0.5, -190, 190)
			f34_arg0.TitleSeparator2:setTopBottom(0.5, 0.5, 61, 62)
			f34_arg0.TitleSeparator2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.TitleSeparator2)
			f34_arg0.CurrentClassName:completeAnimation()
			f34_arg0.CurrentClassName:setLeftRight(0.5, 0.5, -189, 189)
			f34_arg0.CurrentClassName:setTopBottom(0.5, 0.5, -412, -373)
			f34_arg0.CurrentClassName:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.CurrentClassName)
			f34_arg0.ClassSetTitle:completeAnimation()
			f34_arg0.ClassSetTitle:setLeftRight(0.5, 0.5, -189, 189)
			f34_arg0.ClassSetTitle:setTopBottom(0.5, 0.5, 11.5, 50.5)
			f34_arg0.ClassSetTitle:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ClassSetTitle)
			f34_arg0.TitleSeparator:completeAnimation()
			f34_arg0.TitleSeparator:setLeftRight(0.5, 0.5, -244.5, 244.5)
			f34_arg0.TitleSeparator:setTopBottom(0.5, 0.5, -444, -443)
			f34_arg0.TitleSeparator:setAlpha(0.5)
			f34_arg0.clipFinished(f34_arg0.TitleSeparator)
			f34_arg0.ClassOptionsList:completeAnimation()
			f34_arg0.ClassOptionsList:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f34_arg0.ClassOptionsList:setTopBottom(0.5, 0.5, -254, -22)
			f34_arg0.clipFinished(f34_arg0.ClassOptionsList)
			f34_arg0.ClassOptionDesc:completeAnimation()
			f34_arg0.ClassOptionDesc:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f34_arg0.ClassOptionDesc:setTopBottom(0.5, 0.5, -30, -11)
			f34_arg0.ClassOptionDesc:setAlpha(0.15)
			f34_arg0.clipFinished(f34_arg0.ClassOptionDesc)
		end,
	},
	PCclassSets = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(11)
			f35_arg0.PCBacking:completeAnimation()
			f35_arg0.PCBacking:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.PCBacking)
			f35_arg0.CommonRightSlideInPopup:completeAnimation()
			f35_arg0.CommonRightSlideInPopup:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.CommonRightSlideInPopup)
			f35_arg0.buttons:completeAnimation()
			f35_arg0.buttons:setLeftRight(0.5, 0.5, -1440, 480)
			f35_arg0.buttons:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.buttons)
			f35_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f35_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -339, -179)
			f35_arg0.featureOverlayButtonMouseOnly:setTopBottom(1, 1, -108, -48)
			f35_arg0.clipFinished(f35_arg0.featureOverlayButtonMouseOnly)
			f35_arg0.ClassSetOptionsList:completeAnimation()
			f35_arg0.ClassSetOptionsList:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f35_arg0.ClassSetOptionsList:setTopBottom(0.5, 0.5, 61, 167)
			f35_arg0.ClassSetOptionsList:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ClassSetOptionsList)
			f35_arg0.TitleSeparator2:completeAnimation()
			f35_arg0.TitleSeparator2:setLeftRight(0.5, 0.5, -190, 190)
			f35_arg0.TitleSeparator2:setTopBottom(0.5, 0.5, 61, 62)
			f35_arg0.TitleSeparator2:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.TitleSeparator2)
			f35_arg0.CurrentClassName:completeAnimation()
			f35_arg0.CurrentClassName:setLeftRight(0.5, 0.5, -189, 189)
			f35_arg0.CurrentClassName:setTopBottom(0.5, 0.5, -412, -373)
			f35_arg0.CurrentClassName:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.CurrentClassName)
			f35_arg0.ClassSetTitle:completeAnimation()
			f35_arg0.ClassSetTitle:setLeftRight(0.5, 0.5, -189, 189)
			f35_arg0.ClassSetTitle:setTopBottom(0.5, 0.5, 11.5, 50.5)
			f35_arg0.ClassSetTitle:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ClassSetTitle)
			f35_arg0.TitleSeparator:completeAnimation()
			f35_arg0.TitleSeparator:setLeftRight(0.5, 0.5, -244.5, 244.5)
			f35_arg0.TitleSeparator:setTopBottom(0.5, 0.5, -444, -443)
			f35_arg0.TitleSeparator:setAlpha(0.5)
			f35_arg0.clipFinished(f35_arg0.TitleSeparator)
			f35_arg0.ClassOptionsList:completeAnimation()
			f35_arg0.ClassOptionsList:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f35_arg0.ClassOptionsList:setTopBottom(0.5, 0.5, -254, -22)
			f35_arg0.clipFinished(f35_arg0.ClassOptionsList)
			f35_arg0.ClassOptionDesc:completeAnimation()
			f35_arg0.ClassOptionDesc:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f35_arg0.ClassOptionDesc:setTopBottom(0.5, 0.5, -30, -11)
			f35_arg0.ClassOptionDesc:setAlpha(0.15)
			f35_arg0.clipFinished(f35_arg0.ClassOptionDesc)
		end,
	},
	ClassSets = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(3)
			f36_arg0.ClassSetOptionsList:completeAnimation()
			f36_arg0.ClassSetOptionsList:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ClassSetOptionsList)
			f36_arg0.TitleSeparator2:completeAnimation()
			f36_arg0.TitleSeparator2:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.TitleSeparator2)
			f36_arg0.ClassSetTitle:completeAnimation()
			f36_arg0.ClassSetTitle:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ClassSetTitle)
		end,
	},
}
CoD.ClassOptionsWidget.__onClose = function(f37_arg0)
	f37_arg0.PCBacking:close()
	f37_arg0.CommonRightSlideInPopup:close()
	f37_arg0.buttons:close()
	f37_arg0.featureOverlayButtonMouseOnly:close()
	f37_arg0.ClassSetOptionsList:close()
	f37_arg0.PCClassOptionRenameBox:close()
	f37_arg0.CurrentClassName:close()
	f37_arg0.ClassSetTitle:close()
	f37_arg0.ClassOptionsList:close()
	f37_arg0.ClassOptionDesc:close()
	f37_arg0.PCSmallCloseButton:close()
end
