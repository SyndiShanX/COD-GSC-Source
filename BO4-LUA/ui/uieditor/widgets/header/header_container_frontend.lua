require("ui/uieditor/widgets/header/headerlinescontainer")
CoD.header_container_frontend = InheritFrom(LUI.UIElement)
CoD.header_container_frontend.__defaultWidth = 1920
CoD.header_container_frontend.__defaultHeight = 42
CoD.header_container_frontend.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.header_container_frontend)
	self.id = "header_container_frontend"
	self.soundSet = "default"
	local BackingBlack = LUI.UIImage.new(-0.14, 1.16, 0, 0, 0, 0, -103, 9)
	BackingBlack:setRGB(0.02, 0.02, 0.02)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local f1_local2 = nil
	self.BackingGrayMediumLeft = LUI.UIElement.createFake()
	local BackingGrayMediumLeftPC = nil
	BackingGrayMediumLeftPC = CoD.HeaderLinesContainer.new(f1_arg0, f1_arg1, -0.14, 1.16, 0, 0, 0, 0, -103, 9)
	BackingGrayMediumLeftPC:setRGB(0.28, 0.28, 0.28)
	self:addElement(BackingGrayMediumLeftPC)
	self.BackingGrayMediumLeftPC = BackingGrayMediumLeftPC
	local GrainBG01 = LUI.UIImage.new(-0.14, 1.16, 0, 0, 0, 0, -247, 9)
	GrainBG01:setAlpha(0.5)
	GrainBG01:setImage(RegisterImage("uie_ui_menu_director_grain_bg01"))
	GrainBG01:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
	self:addElement(GrainBG01)
	self.GrainBG01 = GrainBG01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.header_container_frontend.__onClose = function(f2_arg0)
	f2_arg0.BackingGrayMediumLeft:close()
	f2_arg0.BackingGrayMediumLeftPC:close()
end
