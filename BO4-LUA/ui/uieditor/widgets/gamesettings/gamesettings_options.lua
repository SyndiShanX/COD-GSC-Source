require("x64:61d2b39aaf0a5fc")
require("x64:29187ea00d726c3")
CoD.GameSettings_Options = InheritFrom(LUI.UIElement)
CoD.GameSettings_Options.__defaultWidth = 480
CoD.GameSettings_Options.__defaultHeight = 1080
CoD.GameSettings_Options.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.GameSettings_Options)
	self.id = "GameSettings_Options"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local VerticalListSpacer0 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 480, 0, 0, 0, 223)
	self:addElement(VerticalListSpacer0)
	self.VerticalListSpacer0 = VerticalListSpacer0
	local TextBox0 = LUI.UIText.new(0, 0, 19, 459, 0, 0, 223, 260)
	TextBox0:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	TextBox0:setText(LocalizeToUpperString(@"menu/options"))
	TextBox0:setTTF("ttmussels_regular")
	TextBox0:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox0:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox0)
	self.TextBox0 = TextBox0
	local spacer = LUI.UIImage.new(0, 0, 19, 452, 0, 0, 260, 316)
	spacer:setAlpha(0)
	self:addElement(spacer)
	self.spacer = spacer
	local List0 = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	List0:setLeftRight(0, 0, 19, 452)
	List0:setTopBottom(0, 0, 316, 516)
	List0:setAutoScaleContent(true)
	List0:setWidgetType(CoD.GameSettings_OptionsButton)
	List0:setVerticalCount(3)
	List0:setSpacing(10)
	List0:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List0:setDataSource("GameSettingsOptions")
	List0:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(List0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		ProcessListAction(self, element, controller, menu)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(List0)
	self.List0 = List0
	local VerticalListSpacer1 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -77, 527, 0, 0, 518, 541)
	self:addElement(VerticalListSpacer1)
	self.VerticalListSpacer1 = VerticalListSpacer1
	local Title = LUI.UIText.new(0, 0, 19, 432, 0, 0, 541, 565)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	Title:linkToElementModel(List0, "description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	List0.id = "List0"
	self.__defaultFocus = List0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_Options.__onClose = function(f6_arg0)
	f6_arg0.Title:close()
	f6_arg0.VerticalListSpacer0:close()
	f6_arg0.List0:close()
	f6_arg0.VerticalListSpacer1:close()
end
