require("x64:9165a1aef65c572")
require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.DirectorContractsButtonInternal = InheritFrom(LUI.UIElement)
CoD.DirectorContractsButtonInternal.__defaultWidth = 354
CoD.DirectorContractsButtonInternal.__defaultHeight = 142
CoD.DirectorContractsButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorContractsButtonInternal)
	self.id = "DirectorContractsButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local BgTint = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 3, -5)
	BgTint:setRGB(0, 0, 0)
	BgTint:setAlpha(0.5)
	self:addElement(BgTint)
	self.BgTint = BgTint
	local BgTintAll = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgTintAll:setRGB(0, 0, 0)
	BgTintAll:setAlpha(0.2)
	self:addElement(BgTintAll)
	self.BgTintAll = BgTintAll
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 3, -5)
	DotTiledBacking.NoiseBacking:setAlpha(0.9)
	DotTiledBacking.TiledShaderImage:setAlpha(0.3)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.01, 0.99, 1, -1)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local BMSmallContractStatusContainer = CoD.BM_SmallContractStatusContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -177, 177, 0.5, 0.5, -68.5, 3.5)
	self:addElement(BMSmallContractStatusContainer)
	self.BMSmallContractStatusContainer = BMSmallContractStatusContainer
	local Tint = LUI.UIImage.new(0, 0, 4, 350, 0, 0, 3, 73)
	Tint:setRGB(0.76, 0.76, 0.76)
	Tint:setAlpha(0.02)
	self:addElement(Tint)
	self.Tint = Tint
	local MiddleText = LUI.UIText.new(0, 1, 16, -16, 0.5, 0.5, 23, 47)
	MiddleText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MiddleText:setText(LocalizeToUpperString(0x616EBD2B8F67E64))
	MiddleText:setTTF("ttmussels_regular")
	MiddleText:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	MiddleText:setLetterSpacing(3)
	MiddleText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MiddleText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(MiddleText)
	self.MiddleText = MiddleText
	self:mergeStateConditions({
		{
			stateName = "DefaultStateAsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	CommonButtonOutline.id = "CommonButtonOutline"
	BMSmallContractStatusContainer.id = "BMSmallContractStatusContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorContractsButtonInternal.__resetProperties = function(f3_arg0)
	f3_arg0.CommonButtonOutline:completeAnimation()
	f3_arg0.CommonButtonOutline:setAlpha(1)
end
CoD.DirectorContractsButtonInternal.__clipsPerState = {
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
	DefaultStateAsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.CommonButtonOutline:completeAnimation()
			f7_arg0.CommonButtonOutline:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.CommonButtonOutline)
		end,
	},
}
CoD.DirectorContractsButtonInternal.__onClose = function(f8_arg0)
	f8_arg0.DotTiledBacking:close()
	f8_arg0.CommonButtonOutline:close()
	f8_arg0.BMSmallContractStatusContainer:close()
end
