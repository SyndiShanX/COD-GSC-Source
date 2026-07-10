CoD.VoipContainer = InheritFrom(LUI.UIElement)
CoD.VoipContainer.__defaultWidth = 21
CoD.VoipContainer.__defaultHeight = 21
CoD.VoipContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoipContainer)
	self.id = "VoipContainer"
	self.soundSet = "default"
	local voipCustomElement = LUI.UIImage.new(0, 0, 0, 21, 0, 0, 0, 21)
	voipCustomElement:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			voipCustomElement:setupVoipImage(f2_local0)
		end
	end)
	self:addElement(voipCustomElement)
	self.voipCustomElement = voipCustomElement
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VoipContainer.__onClose = function(f3_arg0)
	f3_arg0.voipCustomElement:close()
end
