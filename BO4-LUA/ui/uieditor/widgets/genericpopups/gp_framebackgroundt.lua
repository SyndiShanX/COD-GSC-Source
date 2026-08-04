require("ui/uieditor/widgets/lobby/common/fe_buttonpanel")
require("ui/uieditor/widgets/lobby/common/fe_titlenumbrdr")
CoD.GP_FrameBackgroundt = InheritFrom(LUI.UIElement)
CoD.GP_FrameBackgroundt.__defaultWidth = 523
CoD.GP_FrameBackgroundt.__defaultHeight = 85
CoD.GP_FrameBackgroundt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GP_FrameBackgroundt)
	self.id = "GP_FrameBackgroundt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FEButtonPanel0 = CoD.FE_ButtonPanel.new(f1_arg0, f1_arg1, 0, 1, 44, -42, 0, 1, 1, -3)
	FEButtonPanel0:setRGB(0, 0, 0)
	self:addElement(FEButtonPanel0)
	self.FEButtonPanel0 = FEButtonPanel0
	local FETitleNumBrdr0 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 44, -42, 0, 1, 1, -3)
	self:addElement(FETitleNumBrdr0)
	self.FETitleNumBrdr0 = FETitleNumBrdr0
	local Pixel201000 = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 6)
	Pixel201000:setAlpha(0)
	Pixel201000:setYRot(-180)
	Pixel201000:setImage(RegisterImage("uie_t7_menu_frontend_pixelist"))
	Pixel201000:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pixel201000)
	self.Pixel201000 = Pixel201000
	local Pixel2010000 = LUI.UIImage.new(0, 0, 0, 54, 1, 1, -6, 0)
	Pixel2010000:setAlpha(0)
	Pixel2010000:setYRot(-180)
	Pixel2010000:setImage(RegisterImage("uie_t7_menu_frontend_pixelist"))
	Pixel2010000:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pixel2010000)
	self.Pixel2010000 = Pixel2010000
	local Pixel2010001 = LUI.UIImage.new(1, 1, -54, 0, 0, 0, 0, 6)
	Pixel2010001:setAlpha(0)
	Pixel2010001:setImage(RegisterImage("uie_t7_menu_frontend_pixelist"))
	Pixel2010001:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pixel2010001)
	self.Pixel2010001 = Pixel2010001
	local Pixel20100000 = LUI.UIImage.new(1, 1, -54, 0, 1, 1, -6, 0)
	Pixel20100000:setAlpha(0)
	Pixel20100000:setImage(RegisterImage("uie_t7_menu_frontend_pixelist"))
	Pixel20100000:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Pixel20100000)
	self.Pixel20100000 = Pixel20100000
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GP_FrameBackgroundt.__onClose = function(f2_arg0)
	f2_arg0.FEButtonPanel0:close()
	f2_arg0.FETitleNumBrdr0:close()
end
