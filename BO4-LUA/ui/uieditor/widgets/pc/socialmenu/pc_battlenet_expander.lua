require("ui/uieditor/widgets/pc/pc_battlenet_expanderbutton")
require("ui/uieditor/widgets/pc/socialmenu/pc_battlenetfriend_offline")
CoD.PC_Battlenet_expander = InheritFrom(LUI.UIElement)
CoD.PC_Battlenet_expander.__defaultWidth = 750
CoD.PC_Battlenet_expander.__defaultHeight = 695
CoD.PC_Battlenet_expander.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Battlenet_expander)
	self.id = "PC_Battlenet_expander"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ElementList = LUI.UIList.new(f1_arg0, f1_arg1, 3, 0, nil, false, false, false, false)
	ElementList:setLeftRight(-0.01, 0.99, 6, 6)
	ElementList:setTopBottom(0, 0, 30, 531)
	ElementList:setAutoScaleContent(true)
	ElementList:setVerticalCount(AddWithoutPreview(200, 8))
	ElementList:setSpacing(3)
	ElementList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(ElementList)
	self.ElementList = ElementList
	local Button = CoD.PC_Battlenet_ExpanderButton.new(f1_arg0, f1_arg1, -0.03, 1.06, 24, -24, 0, 0, 0, 30)
	Button:mergeStateConditions({
		{
			stateName = "Open",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.IsOpen(self)
			end,
		},
	})
	Button:linkToElementModel(Button, "isOpen", true, function(model)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOpen",
		})
	end)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	self.ElementList:linkToElementModel(self, "frameWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ElementList:setWidgetType(f5_local0)
		end
	end)
	self.ElementList:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ElementList:setDataSource(f6_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.CanHideBattlenetFriendsCategory(self) and CoD.PCWidgetUtility.IsBattlenetFriendsCategoryEmpty(self)
			end,
		},
		{
			stateName = "Open",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.IsOpen(self)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.IsExpanderLock(self) and AlwaysFalse()
			end,
		},
		{
			stateName = "OpenFadedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ClosedFadedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "listCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "listCount",
		})
	end)
	self:linkToElementModel(self, "isOpen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOpen",
		})
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentValue",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.PCWidgetUtility.PrepareTopExpander(self, f1_arg1, f1_arg0, controller, self.ElementList, self.Button, element)
		CoD.PCWidgetUtility.PrepareUpdateExpanderDependingOnChildListCount(self, f1_arg0, element)
	end)
	self:linkToElementModel(self, "isOpen", true, function(model)
		local f16_local0 = self
		CoD.PCWidgetUtility.UpdateExpanderChildrenUnavailability(self, f1_arg0, f1_arg1)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f17_local0 = self
		CoD.PCWidgetUtility.UpdateExpanderChildrenUnavailability(self, f1_arg0, f1_arg1)
	end)
	ElementList.id = "ElementList"
	Button.id = "Button"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.PCUtility.ActivateListPCSelectionBehavior(self.ElementList)
	CoD.PCUtility.SetFilterUsingControllerModel(self, f1_arg1, "ElementList", "identityBadge.gamertag", "EditBoxGlobal.BattlenetFriendsFilter", "", "0")
	return self
end
CoD.PC_Battlenet_expander.__resetProperties = function(f18_arg0)
	f18_arg0.ElementList:completeAnimation()
	f18_arg0.Button:completeAnimation()
	f18_arg0.ElementList:setAlpha(1)
	f18_arg0.Button:setAlpha(1)
end
CoD.PC_Battlenet_expander.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.ElementList:completeAnimation()
			f19_arg0.ElementList:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ElementList)
		end,
		Active = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.ElementList:completeAnimation()
			f20_arg0.ElementList:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ElementList)
		end,
	},
	Invisible = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.ElementList:completeAnimation()
			f21_arg0.ElementList:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ElementList)
			f21_arg0.Button:completeAnimation()
			f21_arg0.Button:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Button)
		end,
	},
	Open = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.ElementList:completeAnimation()
			f22_arg0.ElementList:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.ElementList)
		end,
		Active = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.ElementList:completeAnimation()
			f23_arg0.ElementList:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.ElementList)
		end,
	},
	Locked = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.ElementList:completeAnimation()
			f24_arg0.ElementList:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ElementList)
		end,
	},
	OpenFadedOut = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.ElementList:completeAnimation()
			f25_arg0.ElementList:setAlpha(0.3)
			f25_arg0.clipFinished(f25_arg0.ElementList)
			f25_arg0.Button:completeAnimation()
			f25_arg0.Button:setAlpha(0.3)
			f25_arg0.clipFinished(f25_arg0.Button)
		end,
	},
	ClosedFadedOut = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.ElementList:completeAnimation()
			f26_arg0.ElementList:setAlpha(0.3)
			f26_arg0.clipFinished(f26_arg0.ElementList)
			f26_arg0.Button:completeAnimation()
			f26_arg0.Button:setAlpha(0.3)
			f26_arg0.clipFinished(f26_arg0.Button)
		end,
	},
}
CoD.PC_Battlenet_expander.__onClose = function(f27_arg0)
	f27_arg0.ElementList:close()
	f27_arg0.Button:close()
end
