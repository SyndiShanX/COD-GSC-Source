CoD.callingcards_loot2_surrealistlandscapes_book = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_surrealistlandscapes_book.__defaultWidth = 704
CoD.callingcards_loot2_surrealistlandscapes_book.__defaultHeight = 240
CoD.callingcards_loot2_surrealistlandscapes_book.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_surrealistlandscapes_book)
	self.id = "callingcards_loot2_surrealistlandscapes_book"
	self.soundSet = "default"
	local book = LUI.UIImage.new(0, 0, 0, 704, 0, 0, 0, 240)
	book:setImage(RegisterImage(@"uie_ui_menu_callingcards_surrealistlandscape_bookwaterfall"))
	self:addElement(book)
	self.book = book
	local waterfall = LUI.UIImage.new(0, 0, 113, 289, 0, 0, 120, 240)
	waterfall:setAlpha(0.3)
	waterfall:setImage(RegisterImage(@"uie_ui_menu_callingcards_surrealistlandscape_waterfall"))
	waterfall:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	waterfall:setShaderVector(0, 4, 0, 0, 0)
	waterfall:setShaderVector(1, 32, 0, 0, 0)
	self:addElement(waterfall)
	self.waterfall = waterfall
	local embers04 = LUI.UIImage.new(0.14, 0.51, 0, -28, 0.59, 1, 0, 0)
	embers04:setRGB(0, 0.9, 1)
	embers04:setAlpha(0.18)
	embers04:setZRot(3)
	embers04:setImage(RegisterImage(@"uie_t7_zm_hud_rnd_spk2"))
	embers04:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	embers04:setShaderVector(0, 1, 1, 0, 0)
	embers04:setShaderVector(1, 0, 0.34, 0, 0)
	self:addElement(embers04)
	self.embers04 = embers04
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
