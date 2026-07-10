require("x64:eeb1847d838c6b1")
CoD.CACCustomClassListButton = InheritFrom(LUI.UIElement)
CoD.CACCustomClassListButton.__defaultWidth = 230
CoD.CACCustomClassListButton.__defaultHeight = 35
CoD.CACCustomClassListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACCustomClassListButton)
	self.id = "CACCustomClassListButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local internal = CoD.CACTabButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:linkToElementModel(self, nil, false, function(model)
		internal.RestrictedIcon:setModel(model, f1_arg1)
	end)
	internal:linkToElementModel(self, "customClassName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			internal.Text:setText(f3_local0)
		end
	end)
	internal:linkToElementModel(self, "customClassName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			internal.TextFocus:setText(f4_local0)
		end
	end)
	self:addElement(internal)
	self.internal = internal
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACCustomClassListButton.__onClose = function(f5_arg0)
	f5_arg0.internal:close()
end
