require("x64:19c1945d2e472b0")
CoD.KIllcam_Title = InheritFrom(LUI.UIElement)
CoD.KIllcam_Title.__defaultWidth = 782
CoD.KIllcam_Title.__defaultHeight = 100
CoD.KIllcam_Title.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KIllcam_Title)
	self.id = "KIllcam_Title"
	self.soundSet = "default"
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, -0, 1, 2, 2, 0, 0, -1, 100)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local HeaderLeftEnd = LUI.UIImage.new(0, 0, 0, 100, 0, 0, 0, 100)
	HeaderLeftEnd:setImage(RegisterImage(@"uie_ui_hud_tech_design_left"))
	self:addElement(HeaderLeftEnd)
	self.HeaderLeftEnd = HeaderLeftEnd
	local HeaderRightEnd = LUI.UIImage.new(1, 1, -100, 0, 0, 0, 0, 100)
	HeaderRightEnd:setImage(RegisterImage(@"uie_ui_hud_tech_design_right"))
	self:addElement(HeaderRightEnd)
	self.HeaderRightEnd = HeaderRightEnd
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KIllcam_Title.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
end
