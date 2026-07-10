require("x64:385ed39f564e5ba")
CoD.PaintshopSlotsFull = InheritFrom(LUI.UIElement)
CoD.PaintshopSlotsFull.__defaultWidth = 672
CoD.PaintshopSlotsFull.__defaultHeight = 141
CoD.PaintshopSlotsFull.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopSlotsFull)
	self.id = "PaintshopSlotsFull"
	self.soundSet = "Paintshop"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CountBacking = LUI.UIImage.new(0, 0, 0, 180, 0, 0, 1, 68)
	CountBacking:setRGB(0.34, 0.34, 0.34)
	CountBacking:setAlpha(0.15)
	self:addElement(CountBacking)
	self.CountBacking = CountBacking
	local TitleBacking = LUI.UIImage.new(0, 0, 0, 180, 0, 0, 1, 26)
	TitleBacking:setRGB(0, 0, 0)
	TitleBacking:setAlpha(0.3)
	self:addElement(TitleBacking)
	self.TitleBacking = TitleBacking
	local BackgroundPattern010 = CoD.BackgroundPattern01.new(f1_arg0, f1_arg1, 0, 0, 0, 180, 0, 0, 1, 68)
	BackgroundPattern010:setRGB(0.22, 0.22, 0.22)
	BackgroundPattern010:setAlpha(0.5)
	self:addElement(BackgroundPattern010)
	self.BackgroundPattern010 = BackgroundPattern010
	local Image = LUI.UIImage.new(0, 0, -2, 182, 0, 0, 0, 29)
	Image:setAlpha(0.5)
	Image:setImage(RegisterImage(@"uie_t7_menu_frontend_titlenumbrdrfull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(6, 6)
	self:addElement(Image)
	self.Image = Image
	local count = LUI.UIText.new(0, 0, 9, 170, 0, 0, 31, 64)
	count:setText(Engine[@"hash_4F9F1239CFD921FE"](0x8AD837A6ECA017))
	count:setTTF("default")
	count:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	count:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	count:subscribeToGlobalModel(f1_arg1, "PerController", "Paintshop.UpdateDataSource", function(model)
		CoD.CraftUtility.UpdateSlotCountText(self, count, f1_arg1, Enum[@"storagefiletype"][@"storage_paintjobs"])
	end)
	self:addElement(count)
	self.count = count
	local VariantSlots = LUI.UIText.new(0, 0, 0, 180, 0, 0, 2, 26)
	VariantSlots:setRGB(0.77, 0.77, 0.77)
	VariantSlots:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/paintjob_slots"))
	VariantSlots:setTTF("default")
	VariantSlots:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	VariantSlots:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(VariantSlots)
	self.VariantSlots = VariantSlots
	local slotFulltext = LUI.UIText.new(0, 0, 346, 624, 0, 0, 46, 84)
	slotFulltext:setAlpha(0)
	slotFulltext:setText(Engine[@"hash_4F9F1239CFD921FE"](0xB1C6DD77C8B6CA))
	slotFulltext:setTTF("default")
	slotFulltext:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	slotFulltext:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(slotFulltext)
	self.slotFulltext = slotFulltext
	local WarningBacking = LUI.UIImage.new(0, 0, -3, 9, 0, 0, 7, 32)
	WarningBacking:setRGB(0, 0, 0)
	WarningBacking:setAlpha(0)
	self:addElement(WarningBacking)
	self.WarningBacking = WarningBacking
	local slotfullWarningImage = LUI.UIImage.new(0, 0, 299, 347, 0, 0, 41, 89)
	slotfullWarningImage:setRGB(1, 0, 0)
	slotfullWarningImage:setAlpha(0)
	slotfullWarningImage:setImage(RegisterImage(@"t7_icon_error_overlays"))
	self:addElement(slotfullWarningImage)
	self.slotfullWarningImage = slotfullWarningImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintshopSlotsFull.__resetProperties = function(f3_arg0)
	f3_arg0.slotFulltext:completeAnimation()
	f3_arg0.slotfullWarningImage:completeAnimation()
	f3_arg0.count:completeAnimation()
	f3_arg0.VariantSlots:completeAnimation()
	f3_arg0.WarningBacking:completeAnimation()
	f3_arg0.slotFulltext:setLeftRight(0, 0, 346, 624)
	f3_arg0.slotFulltext:setTopBottom(0, 0, 46, 84)
	f3_arg0.slotFulltext:setRGB(1, 1, 1)
	f3_arg0.slotFulltext:setAlpha(0)
	f3_arg0.slotFulltext:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f3_arg0.slotfullWarningImage:setLeftRight(0, 0, 299, 347)
	f3_arg0.slotfullWarningImage:setTopBottom(0, 0, 41, 89)
	f3_arg0.slotfullWarningImage:setAlpha(0)
	f3_arg0.count:setRGB(1, 1, 1)
	f3_arg0.VariantSlots:setAlpha(1)
	f3_arg0.WarningBacking:setLeftRight(0, 0, -3, 9)
	f3_arg0.WarningBacking:setTopBottom(0, 0, 7, 32)
	f3_arg0.WarningBacking:setAlpha(0)
end
CoD.PaintshopSlotsFull.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	SlotsFull = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.count:completeAnimation()
			f5_arg0.count:setRGB(1, 0, 0)
			f5_arg0.clipFinished(f5_arg0.count)
			f5_arg0.VariantSlots:completeAnimation()
			f5_arg0.VariantSlots:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.VariantSlots)
			f5_arg0.slotFulltext:completeAnimation()
			f5_arg0.slotFulltext:setLeftRight(0, 0, -1, 179)
			f5_arg0.slotFulltext:setTopBottom(0, 0, 2, 26)
			f5_arg0.slotFulltext:setRGB(1, 0, 0)
			f5_arg0.slotFulltext:setAlpha(1)
			f5_arg0.slotFulltext:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f5_arg0.clipFinished(f5_arg0.slotFulltext)
			f5_arg0.WarningBacking:completeAnimation()
			f5_arg0.WarningBacking:setLeftRight(0, 0, -6, 6)
			f5_arg0.WarningBacking:setTopBottom(0, 0, 7, 26)
			f5_arg0.WarningBacking:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.WarningBacking)
			f5_arg0.slotfullWarningImage:completeAnimation()
			f5_arg0.slotfullWarningImage:setLeftRight(0, 0, -22, 22)
			f5_arg0.slotfullWarningImage:setTopBottom(0, 0, -7, 37)
			f5_arg0.slotfullWarningImage:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.slotfullWarningImage)
		end,
	},
}
CoD.PaintshopSlotsFull.__onClose = function(f6_arg0)
	f6_arg0.BackgroundPattern010:close()
	f6_arg0.count:close()
end
