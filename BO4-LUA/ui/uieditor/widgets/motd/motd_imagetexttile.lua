CoD.MOTD_ImageTextTile = InheritFrom(LUI.UIElement)
CoD.MOTD_ImageTextTile.__defaultWidth = 356
CoD.MOTD_ImageTextTile.__defaultHeight = 280
CoD.MOTD_ImageTextTile.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_ImageTextTile)
	self.id = "MOTD_ImageTextTile"
	self.soundSet = "default"
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 356, 0.09, 0.09, -24, 256)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TileImage = LUI.UIImage.new(0, 0, 0, 356, 0, 0, 0, 150)
	self:addElement(TileImage)
	self.TileImage = TileImage
	local TileText = LUI.UIText.new(0, 0, 6, 350, 0, 0, 159, 177)
	TileText:setRGB(0.92, 0.92, 0.92)
	TileText:setAlpha(0.2)
	TileText:setTTF("dinnext_regular")
	TileText:setLetterSpacing(1)
	TileText:setLineSpacing(2)
	TileText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	TileText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(TileText)
	self.TileText = TileText
	self.TileImage:linkToElementModel(self, "popup_image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TileImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self.TileText:linkToElementModel(self, "content_short", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TileText:setText(f3_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_ImageTextTile.__onClose = function(f4_arg0)
	f4_arg0.TileImage:close()
	f4_arg0.TileText:close()
end
