require("x64:36c7e8836ea401a")
CoD.WZCompassMinor = InheritFrom(LUI.UIElement)
CoD.WZCompassMinor.__defaultWidth = 62
CoD.WZCompassMinor.__defaultHeight = 37
CoD.WZCompassMinor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCompassMinor)
	self.id = "WZCompassMinor"
	self.soundSet = "default"
	local TextAndPip = CoD.WZCompassMinorInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 62, 0, 0, -6, 37)
	TextAndPip:linkToElementModel(self, "alpha", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextAndPip:setAlpha(f2_local0)
		end
	end)
	TextAndPip:linkToElementModel(self, nil, false, function(model)
		TextAndPip:setModel(model, f1_arg1)
	end)
	self:addElement(TextAndPip)
	self.TextAndPip = TextAndPip
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCompassMinor.__onClose = function(f4_arg0)
	f4_arg0.TextAndPip:close()
end
