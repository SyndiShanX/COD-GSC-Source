require("x64:8085f9873d6d33b")
CoD.CamoFilterButtonList = InheritFrom(LUI.UIElement)
CoD.CamoFilterButtonList.__defaultWidth = 250
CoD.CamoFilterButtonList.__defaultHeight = 233
CoD.CamoFilterButtonList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CamoFilterButtonList)
	self.id = "CamoFilterButtonList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CamoFilterList = LUI.UIList.new(f1_arg0, f1_arg1, 13, 0, nil, false, false, false, false)
	CamoFilterList:setLeftRight(0, 0, 0, 250)
	CamoFilterList:setTopBottom(0, 0, 0, 233)
	CamoFilterList:setWidgetType(CoD.CamoFilterButton)
	CamoFilterList:setVerticalCount(3)
	CamoFilterList:setSpacing(13)
	CamoFilterList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CamoFilterList:setDataSource("WeaponOptionsCamoCategories")
	CamoFilterList:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = CamoFilterList
	local f1_local3 = CamoFilterList.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CamoFilterList:registerEventHandler("input_source_changed", function(element, event)
		local f4_local0 = nil
		CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior(element, f1_arg1)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	CamoFilterList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CamoFilterList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetCurrentElementAsActive(self, element, controller)
			ProcessListAction(self, element, controller, menu)
			return true
		else
			ProcessListAction(self, element, controller, menu)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(CamoFilterList)
	self.CamoFilterList = CamoFilterList
	CamoFilterList.id = "CamoFilterList"
	self.__defaultFocus = CamoFilterList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = CamoFilterList
	CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior(f1_local3, f1_arg1)
	CoD.GridAndListUtility.ActivateListPCSelectionBehavior(f1_local3)
	return self
end
CoD.CamoFilterButtonList.__resetProperties = function(f8_arg0)
	f8_arg0.CamoFilterList:completeAnimation()
	f8_arg0.CamoFilterList:setAlpha(1)
end
CoD.CamoFilterButtonList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.CamoFilterList:completeAnimation()
			f9_arg0.CamoFilterList:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CamoFilterList)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.CamoFilterList:completeAnimation()
			f10_arg0.CamoFilterList:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.CamoFilterList)
		end,
	},
}
CoD.CamoFilterButtonList.__onClose = function(f11_arg0)
	f11_arg0.CamoFilterList:close()
end
