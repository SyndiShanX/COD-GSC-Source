require("x64:258a2641aa72235")
require("x64:a9d9ad002907d62")
require("x64:be779d5e87238aa")
CoD.systemOverlay_FreeCursor_Full_BasicFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_FreeCursor_Full_BasicFrame.__defaultWidth = 1920
CoD.systemOverlay_FreeCursor_Full_BasicFrame.__defaultHeight = 480
CoD.systemOverlay_FreeCursor_Full_BasicFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_FreeCursor_Full_BasicFrame)
	self.id = "systemOverlay_FreeCursor_Full_BasicFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local foreground = CoD.systemOverlay_Layout_GenericForeground_FreeCursor_Full.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	foreground:linkToElementModel(self, nil, false, function(model)
		foreground:setModel(model, f1_arg1)
	end)
	self:addElement(foreground)
	self.foreground = foreground
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 528, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	local f1_local3 = nil
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 581, 996)
	options:setTopBottom(1, 1, -126.5, -59.5)
	options:setAutoScaleContent(true)
	options:setWidgetType(CoD.featureOverlay_Button)
	options:setHorizontalCount(2)
	options:setSpacing(15)
	options:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			options:setDataSource(f4_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	options.id = "options"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_FreeCursor_Full_BasicFrame.__onClose = function(f9_arg0)
	f9_arg0.foreground:close()
	f9_arg0.supportInfo:close()
	f9_arg0.options:close()
end
