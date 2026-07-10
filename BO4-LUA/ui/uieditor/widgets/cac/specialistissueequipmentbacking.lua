CoD.SpecialistIssueEquipmentBacking = InheritFrom(LUI.UIElement)
CoD.SpecialistIssueEquipmentBacking.__defaultWidth = 400
CoD.SpecialistIssueEquipmentBacking.__defaultHeight = 89
CoD.SpecialistIssueEquipmentBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistIssueEquipmentBacking)
	self.id = "SpecialistIssueEquipmentBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurShader = LUI.UIImage.new(0, 1, 10, -10, 0, 1, 12, -12)
	BlurShader:setAlpha(0.9)
	BlurShader:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurShader:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurShader)
	self.BlurShader = BlurShader
	local BGBox = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 4, -4)
	BGBox:setAlpha(0.6)
	BGBox:setImage(RegisterImage(@"uie_ui_menu_cac_preview_class_bg_main"))
	BGBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BGBox:setShaderVector(0, 0, 0, 0, 0)
	BGBox:setupNineSliceShader(60, 44)
	self:addElement(BGBox)
	self.BGBox = BGBox
	local TiledBGImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBGImage:setAlpha(0.2)
	TiledBGImage:setImage(RegisterImage(@"uie_ui_menu_cac_dot_pattern_bg01"))
	TiledBGImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBGImage:setShaderVector(0, 0, 0, 0, 0)
	TiledBGImage:setupNineSliceShader(64, 64)
	self:addElement(TiledBGImage)
	self.TiledBGImage = TiledBGImage
	local CornerFluffTL = LUI.UIImage.new(0, 0, 9, 19, 0, 0, 14.5, 22.5)
	CornerFluffTL:setAlpha(0.2)
	CornerFluffTL:setZRot(90)
	CornerFluffTL:setImage(RegisterImage(@"hash_62563C2B0AE61C5E"))
	self:addElement(CornerFluffTL)
	self.CornerFluffTL = CornerFluffTL
	local CornerFluffBL = LUI.UIImage.new(0, 0, 9, 19, 1, 1, -22, -14)
	CornerFluffBL:setAlpha(0.2)
	CornerFluffBL:setZRot(90)
	CornerFluffBL:setImage(RegisterImage(@"hash_62563C2B0AE61C5E"))
	self:addElement(CornerFluffBL)
	self.CornerFluffBL = CornerFluffBL
	local CornerFluffTR = LUI.UIImage.new(1, 1, -19, -9, 0, 0, 14.5, 22.5)
	CornerFluffTR:setAlpha(0.2)
	CornerFluffTR:setZRot(90)
	CornerFluffTR:setImage(RegisterImage(@"hash_62563C2B0AE61C5E"))
	self:addElement(CornerFluffTR)
	self.CornerFluffTR = CornerFluffTR
	local CornerFluffBR = LUI.UIImage.new(1, 1, -19, -9, 1, 1, -22, -14)
	CornerFluffBR:setAlpha(0.2)
	CornerFluffBR:setZRot(90)
	CornerFluffBR:setImage(RegisterImage(@"hash_62563C2B0AE61C5E"))
	self:addElement(CornerFluffBR)
	self.CornerFluffBR = CornerFluffBR
	local TopBracket = LUI.UIImage.new(0, 1, -2, 2, 0, 0, 0, 12)
	TopBracket:setAlpha(0.5)
	TopBracket:setZRot(180)
	TopBracket:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	TopBracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	TopBracket:setShaderVector(0, 0, 0, 0, 0)
	TopBracket:setupNineSliceShader(120, 12)
	self:addElement(TopBracket)
	self.TopBracket = TopBracket
	local BottomBracket = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -12, 0)
	BottomBracket:setAlpha(0.5)
	BottomBracket:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	BottomBracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket:setupNineSliceShader(120, 12)
	self:addElement(BottomBracket)
	self.BottomBracket = BottomBracket
	self:mergeStateConditions({
		{
			stateName = "ShowDescription",
			condition = function(menu, element, event)
				return IsCurrentMenu(menu, "SpecialistEquipmentSelect")
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
