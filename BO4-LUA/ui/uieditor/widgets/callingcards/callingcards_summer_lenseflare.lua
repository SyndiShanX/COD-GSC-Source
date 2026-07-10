CoD.CallingCards_Summer_lenseflare = InheritFrom(LUI.UIElement)
CoD.CallingCards_Summer_lenseflare.__defaultWidth = 10
CoD.CallingCards_Summer_lenseflare.__defaultHeight = 10
CoD.CallingCards_Summer_lenseflare.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Summer_lenseflare)
	self.id = "CallingCards_Summer_lenseflare"
	self.soundSet = "default"
	local lenseflare = LUI.UIImage.new(0, 0, -135, 505, 0, 0, -153, 183)
	lenseflare:setImage(RegisterImage(0xD0E6290A54EC443))
	lenseflare:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(lenseflare)
	self.lenseflare = lenseflare
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
