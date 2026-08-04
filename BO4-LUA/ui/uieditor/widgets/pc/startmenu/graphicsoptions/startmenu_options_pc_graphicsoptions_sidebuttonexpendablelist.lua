require("ui/uieditor/widgets/pc/sidebuttonexpendable")
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList.__defaultWidth = 390
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList.__defaultHeight = 272
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList)
	self.id = "StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SideButtonExpendable = CoD.SideButtonExpendable.new(f1_arg0, f1_arg1, 0, 0, 0, 390, 0, 0, 0, 84)
	SideButtonExpendable:mergeStateConditions({
		{
			stateName = "Collapsed",
			condition = function(menu, element, event)
				local f2_local0 = CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "SideButtonExpendable")
				if f2_local0 then
					f2_local0 = CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "SideButtonExpendable2")
					if f2_local0 then
						f2_local0 = CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "SideButtonExpendable3")
					end
				end
				return f2_local0
			end,
		},
	})
	SideButtonExpendable:appendEventHandler("record_curr_focused_elem_id", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SideButtonExpendable, f3_arg1)
	end)
	SideButtonExpendable:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SideButtonExpendable.ButtonLabel:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	SideButtonExpendable:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		if IsMenuInState(f1_arg0, "MovedLeft") then
			SetMenuState(f1_arg0, "MovedRight", f1_arg1)
		end
		return f5_local0
	end)
	self:addElement(SideButtonExpendable)
	self.SideButtonExpendable = SideButtonExpendable
	local SideButtonExpendable2 = CoD.SideButtonExpendable.new(f1_arg0, f1_arg1, 0, 0, 0, 390, 0, 0, 94, 178)
	SideButtonExpendable2.ButtonLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B32524670765A1B"))
	self:addElement(SideButtonExpendable2)
	self.SideButtonExpendable2 = SideButtonExpendable2
	local SideButtonExpendable3 = CoD.SideButtonExpendable.new(f1_arg0, f1_arg1, 0, 0, 0, 390, 0, 0, 187.5, 271.5)
	SideButtonExpendable3.ButtonLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_76315A7DFF851A75"))
	self:addElement(SideButtonExpendable3)
	self.SideButtonExpendable3 = SideButtonExpendable3
	SideButtonExpendable.id = "SideButtonExpendable"
	SideButtonExpendable2.id = "SideButtonExpendable2"
	SideButtonExpendable3.id = "SideButtonExpendable3"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList.__resetProperties = function(f6_arg0)
	f6_arg0.SideButtonExpendable:completeAnimation()
	f6_arg0.SideButtonExpendable:setLeftRight(0, 0, 0, 390)
	f6_arg0.SideButtonExpendable:setTopBottom(0, 0, 0, 84)
end
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.SideButtonExpendable:completeAnimation()
			f8_arg0.SideButtonExpendable:setLeftRight(0, 0, 0, 390)
			f8_arg0.SideButtonExpendable:setTopBottom(0, 0, 0, 84)
			f8_arg0.clipFinished(f8_arg0.SideButtonExpendable)
		end,
	},
}
CoD.StartMenu_Options_PC_GraphicsOptions_SideButtonExpendableList.__onClose = function(f9_arg0)
	f9_arg0.SideButtonExpendable:close()
	f9_arg0.SideButtonExpendable2:close()
	f9_arg0.SideButtonExpendable3:close()
end
