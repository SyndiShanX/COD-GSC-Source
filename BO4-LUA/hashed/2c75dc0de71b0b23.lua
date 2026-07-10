CoD.WarzoneDeathCamTriangleBGCorners = InheritFrom(LUI.UIElement)
CoD.WarzoneDeathCamTriangleBGCorners.__defaultWidth = 93
CoD.WarzoneDeathCamTriangleBGCorners.__defaultHeight = 80
CoD.WarzoneDeathCamTriangleBGCorners.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDeathCamTriangleBGCorners)
	self.id = "WarzoneDeathCamTriangleBGCorners"
	self.soundSet = "default"
	local TriangleBGCornerTop = LUI.UIImage.new(0.5, 0.5, -32, 32, 0, 0, -64, -36)
	TriangleBGCornerTop:setImage(RegisterImage(@"uie_ui_hud_wz_deathcam_triangle_bg_corner"))
	TriangleBGCornerTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TriangleBGCornerTop:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TriangleBGCornerTop)
	self.TriangleBGCornerTop = TriangleBGCornerTop
	local TriangleBGCornerRight = LUI.UIImage.new(1, 1, -48, 0, 1, 1, -120, -64)
	TriangleBGCornerRight:setImage(RegisterImage(@"uie_ui_hud_wz_deathcam_triangle_bg_corner_side"))
	TriangleBGCornerRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TriangleBGCornerRight:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TriangleBGCornerRight)
	self.TriangleBGCornerRight = TriangleBGCornerRight
	local TriangleBGCornerLeft = LUI.UIImage.new(0, 0, 0, 48, 1, 1, -120, -64)
	TriangleBGCornerLeft:setYRot(180)
	TriangleBGCornerLeft:setImage(RegisterImage(@"uie_ui_hud_wz_deathcam_triangle_bg_corner_side"))
	TriangleBGCornerLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TriangleBGCornerLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TriangleBGCornerLeft)
	self.TriangleBGCornerLeft = TriangleBGCornerLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
