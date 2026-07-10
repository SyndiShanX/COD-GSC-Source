CoD.PC_MultiItemPickupBacking = InheritFrom(LUI.UIElement)
CoD.PC_MultiItemPickupBacking.__defaultWidth = 770
CoD.PC_MultiItemPickupBacking.__defaultHeight = 290
CoD.PC_MultiItemPickupBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_MultiItemPickupBacking)
	self.id = "PC_MultiItemPickupBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurPC = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurPC:setAlpha(0.5)
	BlurPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurPC:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurPC)
	self.BlurPC = BlurPC
	local MuliPickBackground2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MuliPickBackground2:setRGB(0.04, 0.04, 0.04)
	MuliPickBackground2:setAlpha(0.4)
	self:addElement(MuliPickBackground2)
	self.MuliPickBackground2 = MuliPickBackground2
	local GridTiled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GridTiled:setScale(1, 1)
	GridTiled:setImage(RegisterImage(@"uie_ui_menu_store_bg_grid"))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local GridTiled2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GridTiled2:setScale(1, 1)
	GridTiled2:setImage(RegisterImage(@"uie_ui_menu_store_bg_grid"))
	GridTiled2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	GridTiled2:setShaderVector(0, 0, 0, 0, 0)
	GridTiled2:setupNineSliceShader(64, 64)
	self:addElement(GridTiled2)
	self.GridTiled2 = GridTiled2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	SetElementProperty(self, "__forceCursorTypeNormal", true)
	SetIgnorePlaySoundSetSound(self, true)
	return self
end
CoD.PC_MultiItemPickupBacking.__resetProperties = function(f2_arg0)
	f2_arg0.MuliPickBackground2:completeAnimation()
	f2_arg0.MuliPickBackground2:setAlpha(0.4)
end
CoD.PC_MultiItemPickupBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.MuliPickBackground2:completeAnimation()
			f4_arg0.MuliPickBackground2:setAlpha(0.4)
			f4_arg0.clipFinished(f4_arg0.MuliPickBackground2)
		end,
	},
}
