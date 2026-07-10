require("x64:c640857356d4915")
CoD.WZCompassIntercardinal = InheritFrom(LUI.UIElement)
CoD.WZCompassIntercardinal.__defaultWidth = 62
CoD.WZCompassIntercardinal.__defaultHeight = 37
CoD.WZCompassIntercardinal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCompassIntercardinal)
	self.id = "WZCompassIntercardinal"
	self.soundSet = "default"
	local TextAndPip = CoD.WZCompassIntercardinalInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 62, 0, 0, -6, 37)
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
CoD.WZCompassIntercardinal.__onClose = function(f4_arg0)
	f4_arg0.TextAndPip:close()
end
