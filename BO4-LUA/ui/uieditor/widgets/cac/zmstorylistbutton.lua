require("x64:eeb1847d838c6b1")
CoD.ZMStoryListButton = InheritFrom(LUI.UIElement)
CoD.ZMStoryListButton.__defaultWidth = 230
CoD.ZMStoryListButton.__defaultHeight = 35
CoD.ZMStoryListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMStoryListButton)
	self.id = "ZMStoryListButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local internal = CoD.CACTabButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:linkToElementModel(self, "storyName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			internal.Text:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	internal:linkToElementModel(self, "storyName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			internal.TextFocus:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(internal)
	self.internal = internal
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsMouseOrKeyboard(controller) then
			MakeFocusable(element, controller)
		end
	end)
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMStoryListButton.__onClose = function(f5_arg0)
	f5_arg0.internal:close()
end
