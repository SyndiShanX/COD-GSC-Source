require("ui/uieditor/widgets/common/commonlistbuttongenericlong")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_layout_foregroundmultilinetext")
CoD.systemOverlay_Layout_ForegroundVLayout = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Layout_ForegroundVLayout.__defaultWidth = 1192
CoD.systemOverlay_Layout_ForegroundVLayout.__defaultHeight = 420
CoD.systemOverlay_Layout_ForegroundVLayout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 34, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.systemOverlay_Layout_ForegroundVLayout)
	self.id = "systemOverlay_Layout_ForegroundVLayout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 2, 1194, 0, 0, 0, 30)
	text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	text:setAlpha(0.7)
	text:linkToElementModel(self, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text.text:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 0, 400)
	options:setTopBottom(0, 0, 64, 413)
	options:setWidgetType(CoD.CommonListButtonGenericLong)
	options:setVerticalCount(7)
	options:setSpacing(8)
	options:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			options:setDataSource(f3_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if not IsDisabled(f6_arg0, f6_arg2) then
			ProcessListAction(self, f6_arg0, f6_arg2, f6_arg1)
			return true
		else
		end
	end, function(f7_arg0, f7_arg1, f7_arg2)
		if not IsDisabled(f7_arg0, f7_arg2) then
			CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	options.id = "options"
	self.__defaultFocus = options
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Layout_ForegroundVLayout.__onClose = function(f8_arg0)
	f8_arg0.text:close()
	f8_arg0.options:close()
end
