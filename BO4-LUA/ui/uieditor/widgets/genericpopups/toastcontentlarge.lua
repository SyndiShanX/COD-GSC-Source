require("x64:1128ed000805fc9")
CoD.ToastContentLarge = InheritFrom(LUI.UIElement)
CoD.ToastContentLarge.__defaultWidth = 400
CoD.ToastContentLarge.__defaultHeight = 150
CoD.ToastContentLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ToastContentLarge)
	self.id = "ToastContentLarge"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -5, 1)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local HeaderDiagonalBarTop = CoD.AARPlayerReward_DiagonalHeaderInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -200.5, 200.5, 0, 0, -6, 2)
	self:addElement(HeaderDiagonalBarTop)
	self.HeaderDiagonalBarTop = HeaderDiagonalBarTop
	local HeaderBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 25)
	HeaderBacking:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	self:addElement(HeaderBacking)
	self.HeaderBacking = HeaderBacking
	local ItemImage = LUI.UIFixedAspectRatioImage.new(0, 0, 12.5, 112.5, 0, 0, 37, 137)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	local Details = LUI.UIText.new(0, 0, 126.5, 389.5, 0, 0, 47.5, 68.5)
	Details:setRGB(0.49, 0.49, 0.49)
	Details:setText("")
	Details:setTTF("dinnext_regular")
	Details:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Details:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Details)
	self.Details = Details
	local CommonFrame01 = LUI.UIImage.new(0, 1, -1, 1, -0.01, 0.99, 24, 2)
	CommonFrame01:setRGB(0.59, 0.59, 0.59)
	CommonFrame01:setAlpha(0.25)
	CommonFrame01:setImage(RegisterImage(@"hash_5CA6E5C175806396"))
	CommonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	CommonFrame01:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame01:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame01)
	self.CommonFrame01 = CommonFrame01
	local BottomBracket9Slice = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -7, 2)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local BottomBracket9Slice2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 24, 33)
	BottomBracket9Slice2:setZRot(180)
	BottomBracket9Slice2:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket9Slice2:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice2:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice2)
	self.BottomBracket9Slice2 = BottomBracket9Slice2
	local Title = LUI.UIText.new(0, 0, 0, 400, 0, 0, 0, 24)
	Title:setRGB(0.11, 0.15, 0.05)
	Title:setText(LocalizeToUpperString(0x0))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ToastContentLarge.__resetProperties = function(f2_arg0)
	f2_arg0.ItemImage:completeAnimation()
	f2_arg0.Details:completeAnimation()
	f2_arg0.ItemImage:setAlpha(1)
	f2_arg0.Details:setLeftRight(0, 0, 126.5, 389.5)
end
CoD.ToastContentLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	NoImage = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.ItemImage:completeAnimation()
			f4_arg0.ItemImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ItemImage)
			f4_arg0.Details:completeAnimation()
			f4_arg0.Details:setLeftRight(0, 0, 12.5, 389.5)
			f4_arg0.clipFinished(f4_arg0.Details)
		end,
	},
}
CoD.ToastContentLarge.__onClose = function(f5_arg0)
	f5_arg0.HeaderDiagonalBarTop:close()
end
