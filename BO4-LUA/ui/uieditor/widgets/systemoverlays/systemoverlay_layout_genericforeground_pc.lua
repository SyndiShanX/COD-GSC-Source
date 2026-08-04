require("ui/uieditor/widgets/pc/utility/verticallistspacer")
require("ui/uieditor/widgets/systemoverlays/featureoverlay_button")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_layout_foregroundmultilinetext")
CoD.systemOverlay_Layout_GenericForeground_PC = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Layout_GenericForeground_PC.__defaultWidth = 1920
CoD.systemOverlay_Layout_GenericForeground_PC.__defaultHeight = 294
CoD.systemOverlay_Layout_GenericForeground_PC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Middle)
	self:setClass(CoD.systemOverlay_Layout_GenericForeground_PC)
	self.id = "systemOverlay_Layout_GenericForeground_PC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local categoryTypeImage = LUI.UIImage.new(0, 0, 464.5, 514.5, 0, 0, 74, 124)
	categoryTypeImage:setAlpha(0)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f2_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local title = LUI.UIText.new(0, 0, 542, 1812, 0, 0, 65.5, 100.5)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	title:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	title:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f3_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 542, 1292, 0, 0, 100.5, 105.5)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 542, 1664, 0, 0, 105.5, 135.5)
	text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	text:setScale(LanguageOverrideNumber("japanese", 0.85, 1, 1))
	text:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			text.text:setText(CoD.BaseUtility.LocalizeIfXHash(f4_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 542, 1292, 0, 0, 135.5, 161.5)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 542, 957)
	options:setTopBottom(1, 1, -132.5, -65.5)
	options:setAutoScaleContent(true)
	options:setWidgetType(CoD.featureOverlay_Button)
	options:setHorizontalCount(2)
	options:setSpacing(15)
	options:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			options:setDataSource(f5_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if not IsDisabled(f8_arg0, f8_arg2) then
			ProcessListAction(self, f8_arg0, f8_arg2, f8_arg1)
			return true
		else
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		if not IsDisabled(f9_arg0, f9_arg2) then
			CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	self:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		DelayedForceCheckDefaultPCFocus(self.options, f1_arg0, controller, 100)
	end)
	options.id = "options"
	self.__defaultFocus = options
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if IsFreeCursorActive(f1_arg1) then
	else
	end
	return self
end
CoD.systemOverlay_Layout_GenericForeground_PC.__onClose = function(f14_arg0)
	f14_arg0.categoryTypeImage:close()
	f14_arg0.title:close()
	f14_arg0.VerticalListSpacer:close()
	f14_arg0.text:close()
	f14_arg0.VerticalListSpacer2:close()
	f14_arg0.options:close()
end
