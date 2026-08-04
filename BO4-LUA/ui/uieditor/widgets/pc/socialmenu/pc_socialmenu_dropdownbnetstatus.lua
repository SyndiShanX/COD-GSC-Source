require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/dropdownlistsmaller")
require("ui/uieditor/widgets/pc/listitemnocategory")
CoD.PC_SocialMenu_DropDownBNetStatus = InheritFrom(LUI.UIElement)
CoD.PC_SocialMenu_DropDownBNetStatus.__defaultWidth = 200
CoD.PC_SocialMenu_DropDownBNetStatus.__defaultHeight = 32
CoD.PC_SocialMenu_DropDownBNetStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if CoD.PCUtility.IsBGSEnabled() then
		CoD.PCBattlenetUtility.PrepareSocialStatusDropdownProperties(self, f1_arg1)
	end
	self:setClass(CoD.PC_SocialMenu_DropDownBNetStatus)
	self.id = "PC_SocialMenu_DropDownBNetStatus"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListItem = CoD.ListItemNoCategory.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 0, 0, 0, 35)
	ListItem:setAlpha(0)
	ListItem:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ListItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, -0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local DropdownList = CoD.DropDownListSmaller.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DropdownList:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	DropdownList:linkToElementModel(DropdownList, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(DropdownList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	DropdownList:linkToElementModel(self, nil, false, function(model)
		DropdownList:setModel(model, f1_arg1)
	end)
	DropdownList:linkToElementModel(self, "currentValue", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DropdownList.TextBox:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.OptionValueToOptionName(self, f6_local0)))
		end
	end)
	self:addElement(DropdownList)
	self.DropdownList = DropdownList
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		if CoD.PCUtility.IsBGSEnabled() then
			CoD.PCWidgetUtility.PrepareDropdownList(self, f1_arg1, f1_arg0, controller, self.DropdownList)
		end
	end)
	emptyFocusable.id = "emptyFocusable"
	DropdownList.id = "DropdownList"
	self.__defaultFocus = DropdownList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	if CoD.PCUtility.IsBGSEnabled() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.PC_SocialMenu_DropDownBNetStatus.__resetProperties = function(f10_arg0)
	f10_arg0.DropdownList:completeAnimation()
	f10_arg0.DropdownList:setAlpha(1)
end
CoD.PC_SocialMenu_DropDownBNetStatus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Unavailable = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.DropdownList:completeAnimation()
			f12_arg0.DropdownList:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.DropdownList)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.DropdownList:completeAnimation()
			f13_arg0.DropdownList:setAlpha(0.2)
			f13_arg0.clipFinished(f13_arg0.DropdownList)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.DropdownList:completeAnimation()
			f14_arg0.DropdownList:setAlpha(0.2)
			f14_arg0.clipFinished(f14_arg0.DropdownList)
		end,
	},
}
CoD.PC_SocialMenu_DropDownBNetStatus.__onClose = function(f15_arg0)
	f15_arg0.ListItem:close()
	f15_arg0.emptyFocusable:close()
	f15_arg0.DropdownList:close()
end
