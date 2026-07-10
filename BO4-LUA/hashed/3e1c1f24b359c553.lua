require("x64:d24e4a6046a91b2")
CoD.vhud_hcxd_timebar = InheritFrom(LUI.UIElement)
CoD.vhud_hcxd_timebar.__defaultWidth = 328
CoD.vhud_hcxd_timebar.__defaultHeight = 40
CoD.vhud_hcxd_timebar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hcxd_timebar)
	self.id = "vhud_hcxd_timebar"
	self.soundSet = "none"
	local DurationCornerTL = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 0, 16)
	DurationCornerTL:setAlpha(0.2)
	DurationCornerTL:setImage(RegisterImage(0xCE697C47EC17BA4))
	self:addElement(DurationCornerTL)
	self.DurationCornerTL = DurationCornerTL
	local DurationCornerBL = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 25, 41)
	DurationCornerBL:setAlpha(0.2)
	DurationCornerBL:setXRot(180)
	DurationCornerBL:setImage(RegisterImage(0xCE697C47EC17BA4))
	self:addElement(DurationCornerBL)
	self.DurationCornerBL = DurationCornerBL
	local DurationCornerBR = LUI.UIImage.new(0, 0, 312, 328, 0, 0, 25, 41)
	DurationCornerBR:setAlpha(0.2)
	DurationCornerBR:setXRot(180)
	DurationCornerBR:setYRot(180)
	DurationCornerBR:setImage(RegisterImage(0xCE697C47EC17BA4))
	self:addElement(DurationCornerBR)
	self.DurationCornerBR = DurationCornerBR
	local DurationCornerTR = LUI.UIImage.new(0, 0, 312, 328, 0, 0, 0, 16)
	DurationCornerTR:setAlpha(0.2)
	DurationCornerTR:setYRot(180)
	DurationCornerTR:setImage(RegisterImage(0xCE697C47EC17BA4))
	self:addElement(DurationCornerTR)
	self.DurationCornerTR = DurationCornerTR
	local Image = LUI.UIImage.new(0, 0, 6, 38, 0, 0, 7, 15)
	Image:setImage(RegisterImage(0xBE3C59102C8FA21))
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0, 0, 26, 34, 0, 0, 28, 36)
	Image2:setAlpha(0.2)
	Image2:setImage(RegisterImage(0xF6E71B8426B936D))
	self:addElement(Image2)
	self.Image2 = Image2
	local vhudmsTimebar = CoD.vhud_ms_Timebar.new(f1_arg0, f1_arg1, 0, 0, 10, 360, 0, 0, 15, 28)
	vhudmsTimebar:linkToElementModel(self, nil, false, function(model)
		vhudmsTimebar:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsTimebar)
	self.vhudmsTimebar = vhudmsTimebar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_hcxd_timebar.__onClose = function(f3_arg0)
	f3_arg0.vhudmsTimebar:close()
end
