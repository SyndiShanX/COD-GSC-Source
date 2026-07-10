CoD[@"hash_2DF24394E064A5D7"] = InheritFrom(LUI.UIElement)
CoD[@"hash_2DF24394E064A5D7"].__defaultWidth = 960
CoD[@"hash_2DF24394E064A5D7"].__defaultHeight = 240
CoD[@"hash_2DF24394E064A5D7"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_2DF24394E064A5D7"])
	self.id = "CallingCards_MP_100percent"
	self.soundSet = "default"
	local clouds = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 238)
	clouds:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_clouds"))
	clouds:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	clouds:setShaderVector(0, 1, 1, 0, 0)
	clouds:setShaderVector(1, 0.04, 0, 0, 0)
	self:addElement(clouds)
	self.clouds = clouds
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_background"))
	self:addElement(bg)
	self.bg = bg
	local swordSheen = LUI.UIImage.new(0, 0, 643, 707, 0, 0, 0, 240)
	swordSheen:setAlpha(0.15)
	swordSheen:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_sword_shine"))
	swordSheen:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	swordSheen:setShaderVector(0, 0, 4, 0, 0)
	swordSheen:setShaderVector(1, 2, 0, 0, 0)
	self:addElement(swordSheen)
	self.swordSheen = swordSheen
	local ArmorShine = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ArmorShine:setAlpha(0.3)
	ArmorShine:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_armor_shine"))
	ArmorShine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	ArmorShine:setShaderVector(0, 0, 3, 0, 0)
	ArmorShine:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(ArmorShine)
	self.ArmorShine = ArmorShine
	local goldShader = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	goldShader:setAlpha(0.2)
	goldShader:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_gold_shader"))
	goldShader:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	goldShader:setShaderVector(0, 0, 3, 0, 0)
	goldShader:setShaderVector(1, 18, 0, 0, 0)
	self:addElement(goldShader)
	self.goldShader = goldShader
	local coinShimmer = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	coinShimmer:setAlpha(0.25)
	coinShimmer:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_coin_shine"))
	coinShimmer:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	coinShimmer:setShaderVector(0, 0, 3, 0, 0)
	coinShimmer:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(coinShimmer)
	self.coinShimmer = coinShimmer
	local snarl = LUI.UIImage.new(0, 0, 201, 273, 0, 0, -2, 238)
	snarl:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_100percent_snarl"))
	snarl:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	snarl:setShaderVector(0, 0, 4, 0, 0)
	snarl:setShaderVector(1, 4.01, 0, 0, 0)
	self:addElement(snarl)
	self.snarl = snarl
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(@"uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
