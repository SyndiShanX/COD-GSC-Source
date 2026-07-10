require("x64:dbf24db6ac58306")
require("x64:b0810588c9ad0b8")
require("x64:7f02a0c84ffbeac")
CoD.Expander = InheritFrom(LUI.UIElement)
CoD.Expander.__defaultWidth = 750
CoD.Expander.__defaultHeight = 695
CoD.Expander.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Expander)
	self.id = "Expander"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ElementList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 10, 0, nil, nil, false, false, false, false)
	ElementList:setLeftRight(0, 1, 12, 0)
	ElementList:setTopBottom(0, 0, 105, 770)
	ElementList:setAutoScaleContent(true)
	ElementList:setWidgetType(CoD.PC_StartMenu_Options_Controls_KeyBinder)
	ElementList:setVerticalCount(9)
	ElementList:setSpacing(10)
	ElementList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ElementList:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ElementList:setDataSource(f2_local0)
		end
	end)
	self:addElement(ElementList)
	self.ElementList = ElementList
	local Button = CoD.ExpandableOption_Button.new(f1_arg0, f1_arg1, 0, 1, 48, 0, 0, 0, 75, 105)
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
	self:addElement(Button)
	self.Button = Button
	local MainOption = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	MainOption:setLeftRight(0, 1, 0, 0)
	MainOption:setTopBottom(0, 0, 0, 65)
	MainOption:linkToElementModel(self, nil, false, function(model)
		MainOption:setModel(model, f1_arg1)
	end)
	MainOption:linkToElementModel(self, "frameWidget", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MainOption:changeFrameWidget(f6_local0)
		end
	end)
	self:addElement(MainOption)
	self.MainOption = MainOption
	local VLine = LUI.UIImage.new(0, 0, 36, 37, 0, 0, 65, 90)
	VLine:setAlpha(0.1)
	self:addElement(VLine)
	self.VLine = VLine
	local HLine = LUI.UIImage.new(0, 0, 36, 48, 0, 0, 90, 91)
	HLine:setAlpha(0.1)
	self:addElement(HLine)
	self.HLine = HLine
	self:mergeStateConditions({
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
		CoD.PCWidgetUtility.PrepareExpander(self, f1_arg1, f1_arg0, controller, self.ElementList, self.Button, self.MainOption)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		CoD.PCWidgetUtility.UpdateExpander(self, controller, self.ElementList, self.Button, self.MainOption)
	end)
	self:linkToElementModel(self, "isOpen", true, function(model)
		local f15_local0 = self
		CoD.PCWidgetUtility.UpdateExpanderChildrenUnavailability(self, f1_arg0, f1_arg1)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f16_local0 = self
		CoD.PCWidgetUtility.UpdateExpanderChildrenUnavailability(self, f1_arg0, f1_arg1)
	end)
	ElementList.id = "ElementList"
	Button.id = "Button"
	MainOption.id = "MainOption"
	self.__defaultFocus = MainOption
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Expander.__resetProperties = function(f17_arg0)
	f17_arg0.ElementList:completeAnimation()
	f17_arg0.VLine:completeAnimation()
	f17_arg0.HLine:completeAnimation()
	f17_arg0.MainOption:completeAnimation()
	f17_arg0.Button:completeAnimation()
	f17_arg0.ElementList:setAlpha(1)
	f17_arg0.VLine:setAlpha(0.1)
	f17_arg0.HLine:setAlpha(0.1)
	f17_arg0.MainOption:setAlpha(1)
	f17_arg0.Button:setAlpha(1)
end
CoD.Expander.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.ElementList:completeAnimation()
			f18_arg0.ElementList:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ElementList)
			f18_arg0.VLine:completeAnimation()
			f18_arg0.VLine:setAlpha(0.1)
			f18_arg0.clipFinished(f18_arg0.VLine)
			f18_arg0.HLine:completeAnimation()
			f18_arg0.HLine:setAlpha(0.1)
			f18_arg0.clipFinished(f18_arg0.HLine)
		end,
		Active = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.ElementList:completeAnimation()
			f19_arg0.ElementList:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ElementList)
			f19_arg0.VLine:completeAnimation()
			f19_arg0.VLine:setAlpha(0.7)
			f19_arg0.clipFinished(f19_arg0.VLine)
			f19_arg0.HLine:completeAnimation()
			f19_arg0.HLine:setAlpha(0.7)
			f19_arg0.clipFinished(f19_arg0.HLine)
		end,
	},
	Open = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.ElementList:completeAnimation()
			f20_arg0.ElementList:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ElementList)
			f20_arg0.VLine:completeAnimation()
			f20_arg0.VLine:setAlpha(0.1)
			f20_arg0.clipFinished(f20_arg0.VLine)
			f20_arg0.HLine:completeAnimation()
			f20_arg0.HLine:setAlpha(0.1)
			f20_arg0.clipFinished(f20_arg0.HLine)
		end,
		Active = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.ElementList:completeAnimation()
			f21_arg0.ElementList:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ElementList)
			f21_arg0.VLine:completeAnimation()
			f21_arg0.VLine:setAlpha(0.7)
			f21_arg0.clipFinished(f21_arg0.VLine)
			f21_arg0.HLine:completeAnimation()
			f21_arg0.HLine:setAlpha(0.7)
			f21_arg0.clipFinished(f21_arg0.HLine)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.ElementList:completeAnimation()
			f22_arg0.ElementList:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.ElementList)
			f22_arg0.VLine:completeAnimation()
			f22_arg0.VLine:setAlpha(0.1)
			f22_arg0.clipFinished(f22_arg0.VLine)
			f22_arg0.HLine:completeAnimation()
			f22_arg0.HLine:setAlpha(0.1)
			f22_arg0.clipFinished(f22_arg0.HLine)
		end,
	},
	Locked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.ElementList:completeAnimation()
			f23_arg0.ElementList:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ElementList)
		end,
	},
	OpenFadedOut = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.ElementList:completeAnimation()
			f24_arg0.ElementList:setAlpha(0.3)
			f24_arg0.clipFinished(f24_arg0.ElementList)
			f24_arg0.Button:completeAnimation()
			f24_arg0.Button:setAlpha(0.3)
			f24_arg0.clipFinished(f24_arg0.Button)
			f24_arg0.MainOption:completeAnimation()
			f24_arg0.MainOption:setAlpha(0.3)
			f24_arg0.clipFinished(f24_arg0.MainOption)
		end,
	},
	ClosedFadedOut = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.ElementList:completeAnimation()
			f25_arg0.ElementList:setAlpha(0.3)
			f25_arg0.clipFinished(f25_arg0.ElementList)
			f25_arg0.Button:completeAnimation()
			f25_arg0.Button:setAlpha(0.3)
			f25_arg0.clipFinished(f25_arg0.Button)
			f25_arg0.MainOption:completeAnimation()
			f25_arg0.MainOption:setAlpha(0.3)
			f25_arg0.clipFinished(f25_arg0.MainOption)
		end,
	},
}
CoD.Expander.__onClose = function(f26_arg0)
	f26_arg0.ElementList:close()
	f26_arg0.Button:close()
	f26_arg0.MainOption:close()
end
