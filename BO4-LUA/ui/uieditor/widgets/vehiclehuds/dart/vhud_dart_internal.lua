require("x64:d4776314db9989d")
require("x64:f72f7312b3f60f6")
CoD.vhud_dart_internal = InheritFrom(LUI.UIElement)
CoD.vhud_dart_internal.__defaultWidth = 1920
CoD.vhud_dart_internal.__defaultHeight = 1080
CoD.vhud_dart_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_internal)
	self.id = "vhud_dart_internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local vhuddartPCreticleBacking = nil
	vhuddartPCreticleBacking = CoD.vhud_dart_PC_reticleBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(vhuddartPCreticleBacking)
	self.vhuddartPCreticleBacking = vhuddartPCreticleBacking
	local vhuddartreticle = CoD.vhud_dart_reticle.new(f1_arg0, f1_arg1, 0, 1, -24, 24, 0, 1, 0, 0)
	vhuddartreticle:linkToElementModel(self, nil, false, function(model)
		vhuddartreticle:setModel(model, f1_arg1)
	end)
	self:addElement(vhuddartreticle)
	self.vhuddartreticle = vhuddartreticle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	f1_local3 = vhuddartreticle
	if IsPC() then
		SizeToHudArea(f1_local3, f1_arg1)
	end
	return self
end
CoD.vhud_dart_internal.__onClose = function(f3_arg0)
	f3_arg0.vhuddartPCreticleBacking:close()
	f3_arg0.vhuddartreticle:close()
end
