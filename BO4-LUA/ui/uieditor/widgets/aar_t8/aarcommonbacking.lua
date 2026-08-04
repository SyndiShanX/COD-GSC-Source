require("ui/uieditor/widgets/aar_t8/levelup/aarlevelcommonboxes")
CoD.AARCommonBacking = InheritFrom(LUI.UIElement)
CoD.AARCommonBacking.__defaultWidth = 1356
CoD.AARCommonBacking.__defaultHeight = 836
CoD.AARCommonBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARCommonBacking)
	self.id = "AARCommonBacking"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backer:setRGB(0.67, 0.67, 0.67)
	Backer:setAlpha(0.02)
	self:addElement(Backer)
	self.Backer = Backer
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.12)
	TiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local SquareOthers = CoD.AARLevelCommonBoxes.new(f1_arg0, f1_arg1, 1, 1, -128, -80, 0, 0, 5, 18)
	SquareOthers:setAlpha(0.2)
	self:addElement(SquareOthers)
	self.SquareOthers = SquareOthers
	local FuiBox02Right = LUI.UIImage.new(1, 1, -84, -50, 1, 1, -10, -44)
	FuiBox02Right:setAlpha(0.05)
	FuiBox02Right:setZRot(-90)
	FuiBox02Right:setImage(RegisterImage("uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARCommonBacking.__onClose = function(f2_arg0)
	f2_arg0.SquareOthers:close()
end
