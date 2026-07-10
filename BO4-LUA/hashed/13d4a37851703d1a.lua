require("x64:f432feaf297b8de")
require("x64:62cb1d00e50cc75")
require("x64:ff03870cd3bee03")
require("x64:c83f9a398165f22")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.ClanOptionsWidget = InheritFrom(LUI.UIElement)
CoD.ClanOptionsWidget.__defaultWidth = 1920
CoD.ClanOptionsWidget.__defaultHeight = 1080
CoD.ClanOptionsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClanOptionsWidget)
	self.id = "ClanOptionsWidget"
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
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local CurrentClassName = LUI.UIText.new(1, 1, -460.5, -82.5, 0, 0, 128, 167)
	CurrentClassName:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	CurrentClassName:setText(LocalizeToUpperString(0x0))
	CurrentClassName:setTTF("notosans_bold")
	CurrentClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(CurrentClassName)
	self.CurrentClassName = CurrentClassName
	local TitleSeparator = LUI.UIImage.new(1, 1, -462.5, -82.5, 0, 0, 175, 176)
	TitleSeparator:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	self:addElement(TitleSeparator)
	self.TitleSeparator = TitleSeparator
	local ClassOptionsList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	ClassOptionsList:setLeftRight(1, 1, -467.5, -82.5)
	ClassOptionsList:setTopBottom(0, 0, 270, 502)
	ClassOptionsList:setWidgetType(CoD.CommonListButtonGeneric)
	ClassOptionsList:setVerticalCount(4)
	ClassOptionsList:setSpacing(20)
	ClassOptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClassOptionsList:setDataSource("ClanAdminOptionsButtonList")
	ClassOptionsList:registerEventHandler("list_item_gain_focus", function(element, event)
		return nil
	end)
	ClassOptionsList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ClassOptionsList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(ClassOptionsList)
	self.ClassOptionsList = ClassOptionsList
	local ClassOptionDesc = LUI.UIText.new(1, 1, -459.5, -49.5, 0, 0, 200.5, 219.5)
	ClassOptionDesc:setTTF("dinnext_regular")
	ClassOptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClassOptionDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClassOptionDesc)
	self.ClassOptionDesc = ClassOptionDesc
	local PCSmallCloseButton = nil
	PCSmallCloseButton = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 336, 370, 0.5, 0.5, -500, -466)
	PCSmallCloseButton:setAlpha(0)
	PCSmallCloseButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(PCSmallCloseButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCSmallCloseButton)
	self.PCSmallCloseButton = PCSmallCloseButton
	self.ClassOptionDesc:linkToElementModel(self, "hintText", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			ClassOptionDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](f14_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
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
	ClassOptionsList.id = "ClassOptionsList"
	if CoD.isPC then
		PCSmallCloseButton.id = "PCSmallCloseButton"
	end
	self.__defaultFocus = ClassOptionsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	MenuHidesFreeCursor(f1_arg0, f1_arg1)
	PlaySoundAlias("uin_party_ease_slide")
	return self
end
CoD.ClanOptionsWidget.__resetProperties = function(f17_arg0)
	f17_arg0.ClassOptionsList:completeAnimation()
	f17_arg0.ClassOptionDesc:completeAnimation()
	f17_arg0.TitleSeparator:completeAnimation()
	f17_arg0.CurrentClassName:completeAnimation()
	f17_arg0.CommonRightSlideInPopup:completeAnimation()
	f17_arg0.PCBacking:completeAnimation()
	f17_arg0.featureOverlayButtonMouseOnly:completeAnimation()
	f17_arg0.buttons:completeAnimation()
	f17_arg0.ClassOptionsList:setLeftRight(1, 1, -467.5, -82.5)
	f17_arg0.ClassOptionsList:setTopBottom(0, 0, 270, 502)
	f17_arg0.ClassOptionDesc:setLeftRight(1, 1, -459.5, -49.5)
	f17_arg0.ClassOptionDesc:setTopBottom(0, 0, 200.5, 219.5)
	f17_arg0.ClassOptionDesc:setAlpha(1)
	f17_arg0.TitleSeparator:setLeftRight(1, 1, -462.5, -82.5)
	f17_arg0.TitleSeparator:setTopBottom(0, 0, 175, 176)
	f17_arg0.TitleSeparator:setAlpha(1)
	f17_arg0.CurrentClassName:setLeftRight(1, 1, -460.5, -82.5)
	f17_arg0.CurrentClassName:setTopBottom(0, 0, 128, 167)
	f17_arg0.CurrentClassName:setAlpha(1)
	f17_arg0.CommonRightSlideInPopup:setLeftRight(1, 1, -1920, 0)
	f17_arg0.CommonRightSlideInPopup:setAlpha(1)
	f17_arg0.PCBacking:setAlpha(0)
	f17_arg0.featureOverlayButtonMouseOnly:setLeftRight(1, 1, -525, -365)
	f17_arg0.featureOverlayButtonMouseOnly:setTopBottom(1, 1, -60, 0)
	f17_arg0.buttons:setLeftRight(1, 1, -1920, 0)
	f17_arg0.buttons:setAlpha(1)
end
CoD.ClanOptionsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			local f19_local0 = function(f20_arg0)
				f19_arg0.CommonRightSlideInPopup:beginAnimation(200)
				f19_arg0.CommonRightSlideInPopup:setLeftRight(1, 1, -1920, 0)
				f19_arg0.CommonRightSlideInPopup:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CommonRightSlideInPopup:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CommonRightSlideInPopup:completeAnimation()
			f19_arg0.CommonRightSlideInPopup:setLeftRight(1, 1, -1371, 549)
			f19_local0(f19_arg0.CommonRightSlideInPopup)
			local f19_local1 = function(f21_arg0)
				f19_arg0.CurrentClassName:beginAnimation(200)
				f19_arg0.CurrentClassName:setLeftRight(1, 1, -460.5, -82.5)
				f19_arg0.CurrentClassName:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CurrentClassName:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CurrentClassName:completeAnimation()
			f19_arg0.CurrentClassName:setLeftRight(1, 1, 88.5, 466.5)
			f19_local1(f19_arg0.CurrentClassName)
			local f19_local2 = function(f22_arg0)
				f19_arg0.TitleSeparator:beginAnimation(200)
				f19_arg0.TitleSeparator:setLeftRight(1, 1, -462.5, -82.5)
				f19_arg0.TitleSeparator:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.TitleSeparator:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.TitleSeparator:completeAnimation()
			f19_arg0.TitleSeparator:setLeftRight(1, 1, 86.5, 466.5)
			f19_local2(f19_arg0.TitleSeparator)
			local f19_local3 = function(f23_arg0)
				f19_arg0.ClassOptionsList:beginAnimation(200)
				f19_arg0.ClassOptionsList:setLeftRight(1, 1, -467.5, -82.5)
				f19_arg0.ClassOptionsList:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ClassOptionsList:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ClassOptionsList:completeAnimation()
			f19_arg0.ClassOptionsList:setLeftRight(1, 1, 81.5, 466.5)
			f19_local3(f19_arg0.ClassOptionsList)
			local f19_local4 = function(f24_arg0)
				f19_arg0.ClassOptionDesc:beginAnimation(200)
				f19_arg0.ClassOptionDesc:setLeftRight(1, 1, -459.5, -49.5)
				f19_arg0.ClassOptionDesc:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ClassOptionDesc:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ClassOptionDesc:completeAnimation()
			f19_arg0.ClassOptionDesc:setLeftRight(1, 1, 89.5, 499.5)
			f19_local4(f19_arg0.ClassOptionDesc)
		end,
	},
	PC = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(8)
			f25_arg0.PCBacking:completeAnimation()
			f25_arg0.PCBacking:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.PCBacking)
			f25_arg0.CommonRightSlideInPopup:completeAnimation()
			f25_arg0.CommonRightSlideInPopup:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CommonRightSlideInPopup)
			f25_arg0.buttons:completeAnimation()
			f25_arg0.buttons:setLeftRight(0.5, 0.5, -1440, 480)
			f25_arg0.buttons:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.buttons)
			f25_arg0.featureOverlayButtonMouseOnly:completeAnimation()
			f25_arg0.featureOverlayButtonMouseOnly:setLeftRight(0.5, 0.5, -339, -179)
			f25_arg0.featureOverlayButtonMouseOnly:setTopBottom(1, 1, -108, -48)
			f25_arg0.clipFinished(f25_arg0.featureOverlayButtonMouseOnly)
			f25_arg0.CurrentClassName:completeAnimation()
			f25_arg0.CurrentClassName:setLeftRight(0.5, 0.5, -189, 189)
			f25_arg0.CurrentClassName:setTopBottom(0.5, 0.5, -500, -461)
			f25_arg0.CurrentClassName:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.CurrentClassName)
			f25_arg0.TitleSeparator:completeAnimation()
			f25_arg0.TitleSeparator:setLeftRight(0.5, 0.5, -244.5, 244.5)
			f25_arg0.TitleSeparator:setTopBottom(0.5, 0.5, -444, -443)
			f25_arg0.TitleSeparator:setAlpha(0.5)
			f25_arg0.clipFinished(f25_arg0.TitleSeparator)
			f25_arg0.ClassOptionsList:completeAnimation()
			f25_arg0.ClassOptionsList:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f25_arg0.ClassOptionsList:setTopBottom(0.5, 0.5, -254, -22)
			f25_arg0.clipFinished(f25_arg0.ClassOptionsList)
			f25_arg0.ClassOptionDesc:completeAnimation()
			f25_arg0.ClassOptionDesc:setLeftRight(0.5, 0.5, -192.5, 192.5)
			f25_arg0.ClassOptionDesc:setTopBottom(0.5, 0.5, -30, -11)
			f25_arg0.ClassOptionDesc:setAlpha(0.15)
			f25_arg0.clipFinished(f25_arg0.ClassOptionDesc)
		end,
	},
}
CoD.ClanOptionsWidget.__onClose = function(f26_arg0)
	f26_arg0.PCBacking:close()
	f26_arg0.CommonRightSlideInPopup:close()
	f26_arg0.buttons:close()
	f26_arg0.featureOverlayButtonMouseOnly:close()
	f26_arg0.ClassOptionsList:close()
	f26_arg0.ClassOptionDesc:close()
	f26_arg0.PCSmallCloseButton:close()
end
