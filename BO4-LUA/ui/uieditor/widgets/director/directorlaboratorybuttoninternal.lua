require("x64:5f8cf56752aa71b")
require("x64:d6501065ee1c789")
require("x64:19c1945d2e472b0")
CoD.DirectorLaboratoryButtonInternal = InheritFrom(LUI.UIElement)
CoD.DirectorLaboratoryButtonInternal.__defaultWidth = 354
CoD.DirectorLaboratoryButtonInternal.__defaultHeight = 110
CoD.DirectorLaboratoryButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLaboratoryButtonInternal)
	self.id = "DirectorLaboratoryButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local BgTint = LUI.UIImage.new(0, 1, 4, -4, 0, 0, 44, 106)
	BgTint:setRGB(0, 0, 0)
	BgTint:setAlpha(0.5)
	self:addElement(BgTint)
	self.BgTint = BgTint
	local BgTintAll = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgTintAll:setRGB(0, 0, 0)
	BgTintAll:setAlpha(0.2)
	self:addElement(BgTintAll)
	self.BgTintAll = BgTintAll
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 0, 44, 106)
	DotTiledBacking.NoiseBacking:setAlpha(0.9)
	DotTiledBacking.TiledShaderImage:setAlpha(0.3)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local BlackMarketName = LUI.UIText.new(0.5, 0.5, -200, 200, 0.5, 0.5, 8, 32)
	BlackMarketName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	BlackMarketName:setText(LocalizeToUpperString(0x96D9A8F7540D6B6))
	BlackMarketName:setTTF("ttmussels_demibold")
	BlackMarketName:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	BlackMarketName:setLetterSpacing(3)
	BlackMarketName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	BlackMarketName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(BlackMarketName)
	self.BlackMarketName = BlackMarketName
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local SpecialEventBanner = CoD.DirectorLaboratoryButtonElixerOffer.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 0, 4, 44)
	self:addElement(SpecialEventBanner)
	self.SpecialEventBanner = SpecialEventBanner
	local StreamImageSmall = LUI.UIFixedAspectRatioImage.new(0, 0, 1, 97, 1, 1, -124, -6)
	StreamImageSmall:setImage(RegisterImage(0x76C393335224D3F))
	StreamImageSmall:setStretchedDimension(5)
	self:addElement(StreamImageSmall)
	self.StreamImageSmall = StreamImageSmall
	local vialCount = LUI.UIText.new(0, 0, 70, 132, 1, 1, -28, -6)
	vialCount:setTTF("ttmussels_demibold")
	vialCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	vialCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	vialCount:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "plasma", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			vialCount:setText(SetValueIfNumberEqualTo(-1, "-", f2_local0))
		end
	end)
	self:addElement(vialCount)
	self.vialCount = vialCount
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLaboratoryButtonInternal.__resetProperties = function(f3_arg0)
	f3_arg0.CommonButtonOutline:completeAnimation()
	f3_arg0.CommonButtonOutline:setAlpha(1)
end
CoD.DirectorLaboratoryButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CommonButtonOutline:completeAnimation()
			f5_arg0.CommonButtonOutline:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.CommonButtonOutline)
		end,
	},
}
CoD.DirectorLaboratoryButtonInternal.__onClose = function(f6_arg0)
	f6_arg0.DotTiledBacking:close()
	f6_arg0.CommonButtonOutline:close()
	f6_arg0.SpecialEventBanner:close()
	f6_arg0.vialCount:close()
end
