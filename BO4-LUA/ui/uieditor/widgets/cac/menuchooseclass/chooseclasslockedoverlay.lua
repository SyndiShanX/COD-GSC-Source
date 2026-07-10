require("x64:94dab3a4d2d79b2")
require("x64:2675595fa323085")
CoD.ChooseClassLockedOverlay = InheritFrom(LUI.UIElement)
CoD.ChooseClassLockedOverlay.__defaultWidth = 1920
CoD.ChooseClassLockedOverlay.__defaultHeight = 1080
CoD.ChooseClassLockedOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChooseClassLockedOverlay)
	self.id = "ChooseClassLockedOverlay"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlack = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 539.5, 1079.5)
	BackingBlack:setRGB(0, 0, 0)
	BackingBlack:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local BackingWhite = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 539.5, 1079.5)
	BackingWhite:setRGB(0.59, 0.59, 0.59)
	BackingWhite:setAlpha(0.1)
	BackingWhite:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(BackingWhite)
	self.BackingWhite = BackingWhite
	local NoiseTiledBacking = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 539.5, 1079.5)
	NoiseTiledBacking:setRGB(0.65, 0.65, 0.65)
	NoiseTiledBacking:setAlpha(0.9)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	NoiseTiledBacking:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TiledBacking = LUI.UIImage.new(0.5, 0.5, -594.5, 594.5, 0, 0, 600, 950)
	TiledBacking:setAlpha(0.95)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local GridTiled = LUI.UIImage.new(0.5, 0.5, -210, 593, 0.5, 0.5, 62, 408)
	GridTiled:setAlpha(0.1)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local BlackfadeBlurB = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurB:setRGB(0, 0, 0)
	BlackfadeBlurB:setAlpha(0)
	BlackfadeBlurB:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlackfadeBlurB:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlackfadeBlurB)
	self.BlackfadeBlurB = BlackfadeBlurB
	local BlackfadeBlurF = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlackfadeBlurF:setRGB(0, 0, 0)
	BlackfadeBlurF:setAlpha(0)
	self:addElement(BlackfadeBlurF)
	self.BlackfadeBlurF = BlackfadeBlurF
	local DescriptionTint2 = LUI.UIImage.new(0, 0, 365.5, 746.5, 0, 0, 601, 951)
	DescriptionTint2:setRGB(0.39, 0.39, 0.39)
	DescriptionTint2:setAlpha(0.04)
	DescriptionTint2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DescriptionTint2)
	self.DescriptionTint2 = DescriptionTint2
	local DescriptionTint = LUI.UIImage.new(0, 0, 779, 1522, 0, 0, 730, 794)
	DescriptionTint:setRGB(0.39, 0.39, 0.39)
	DescriptionTint:setAlpha(0.07)
	DescriptionTint:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DescriptionTint)
	self.DescriptionTint = DescriptionTint
	local UnlockDescription = LUI.UIText.new(0, 0, 850, 1522, 0, 0, 740.5, 785.5)
	UnlockDescription:setRGB(0.96, 0.93, 0.84)
	UnlockDescription.__String_Reference = function()
		UnlockDescription:setText(ConvertToUpperString(CoD.CACUtility.GetUnlockDescriptionForFeature(f1_arg0, f1_arg1, 0x0)))
	end
	UnlockDescription.__String_Reference()
	UnlockDescription:setTTF("ttmussels_regular")
	UnlockDescription:setLetterSpacing(4)
	UnlockDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	local ClassName = LUI.UIText.new(0.5, 0.5, -99, 201, 0, 0, 702, 727)
	ClassName:setAlpha(0.15)
	ClassName:setTTF("ttmussels_regular")
	ClassName:setLetterSpacing(3)
	ClassName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ClassName:linkToElementModel(self, "customClassName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ClassName:setText(ToUpper(f6_local0))
		end
	end)
	self:addElement(ClassName)
	self.ClassName = ClassName
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 779, 843, 0, 0, 730, 794)
	DotCorner9Slice:setAlpha(0.3)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local LockImage = LUI.UIImage.new(0, 0, 779, 843, 0, 0, 730, 794)
	LockImage:setImage(RegisterImage(0xE1E7C490B2BA4FB))
	self:addElement(LockImage)
	self.LockImage = LockImage
	local BotBarAdd = LUI.UIImage.new(0, 0, 1371, 1727, 0, 0, 767, 783)
	BotBarAdd:setAlpha(0.8)
	BotBarAdd:setZRot(90)
	BotBarAdd:setImage(RegisterImage(0x5AD5487D499ECDD))
	BotBarAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BotBarAdd)
	self.BotBarAdd = BotBarAdd
	local LayoutTopBar = LUI.UIImage.new(0.5, 0.5, -594.5, 594.5, 0, 0, 578, 598)
	LayoutTopBar:setAlpha(0.5)
	LayoutTopBar:setImage(RegisterImage(0x1426C1694668EB3))
	LayoutTopBar:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	LayoutTopBar:setShaderVector(0, 0, 0, 0, 0)
	LayoutTopBar:setupNineSliceShader(6, 6)
	self:addElement(LayoutTopBar)
	self.LayoutTopBar = LayoutTopBar
	local LayoutBotStripe = LUI.UIImage.new(0.5, 0.5, -594, 594, 0, 0, 953.5, 981.5)
	LayoutBotStripe:setAlpha(0.4)
	LayoutBotStripe:setImage(RegisterImage(0x36E1590316DA74B))
	LayoutBotStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LayoutBotStripe)
	self.LayoutBotStripe = LayoutBotStripe
	local RankIcon = LUI.UIImage.new(0, 0, 395.5, 715.5, 0, 0, 615, 935)
	RankIcon.__Image = function()
		RankIcon:setImage(RegisterImage(CoD.CACUtility.GetUnlockRankIconLargeForFeature(f1_arg0, 0x21793BE97AC0B5A)))
	end
	RankIcon.__Image()
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local blockPCNavigationEmptyFocusable = nil
	blockPCNavigationEmptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(blockPCNavigationEmptyFocusable)
	self.blockPCNavigationEmptyFocusable = blockPCNavigationEmptyFocusable
	UnlockDescription:linkToElementModel(self, nil, true, UnlockDescription.__String_Reference)
	RankIcon:linkToElementModel(self, nil, true, RankIcon.__Image)
	if CoD.isPC then
		blockPCNavigationEmptyFocusable.id = "blockPCNavigationEmptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChooseClassLockedOverlay.__resetProperties = function(f8_arg0)
	f8_arg0.BlackfadeBlurB:completeAnimation()
	f8_arg0.BlackfadeBlurF:completeAnimation()
	f8_arg0.ClassName:completeAnimation()
	f8_arg0.UnlockDescription:completeAnimation()
	f8_arg0.LockImage:completeAnimation()
	f8_arg0.LayoutBotStripe:completeAnimation()
	f8_arg0.LayoutTopBar:completeAnimation()
	f8_arg0.BotBarAdd:completeAnimation()
	f8_arg0.DotCorner9Slice:completeAnimation()
	f8_arg0.DescriptionTint2:completeAnimation()
	f8_arg0.DescriptionTint:completeAnimation()
	f8_arg0.TiledBacking:completeAnimation()
	f8_arg0.NoiseTiledBacking:completeAnimation()
	f8_arg0.BackingWhite:completeAnimation()
	f8_arg0.GridTiled:completeAnimation()
	f8_arg0.RankIcon:completeAnimation()
	f8_arg0.BackingBlack:completeAnimation()
	f8_arg0.blockPCNavigationEmptyFocusable:completeAnimation()
	f8_arg0.BlackfadeBlurB:setAlpha(0)
	f8_arg0.BlackfadeBlurF:setAlpha(0)
	f8_arg0.ClassName:setAlpha(0.15)
	f8_arg0.UnlockDescription:setAlpha(1)
	f8_arg0.LockImage:setAlpha(1)
	f8_arg0.LayoutBotStripe:setAlpha(0.4)
	f8_arg0.LayoutTopBar:setAlpha(0.5)
	f8_arg0.BotBarAdd:setAlpha(0.8)
	f8_arg0.DotCorner9Slice:setAlpha(0.3)
	f8_arg0.DescriptionTint2:setAlpha(0.04)
	f8_arg0.DescriptionTint:setAlpha(0.07)
	f8_arg0.TiledBacking:setAlpha(0.95)
	f8_arg0.NoiseTiledBacking:setTopBottom(0, 0, 539.5, 1079.5)
	f8_arg0.NoiseTiledBacking:setAlpha(0.9)
	f8_arg0.BackingWhite:setTopBottom(0, 0, 539.5, 1079.5)
	f8_arg0.BackingWhite:setAlpha(0.1)
	f8_arg0.GridTiled:setAlpha(0.1)
	f8_arg0.RankIcon:setAlpha(1)
	f8_arg0.BackingBlack:setTopBottom(0, 0, 539.5, 1079.5)
	f8_arg0.BackingBlack:setAlpha(1)
	f8_arg0.blockPCNavigationEmptyFocusable:setAlpha(1)
end
CoD.ChooseClassLockedOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(18)
			f9_arg0.BackingBlack:completeAnimation()
			f9_arg0.BackingBlack:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BackingBlack)
			f9_arg0.BackingWhite:completeAnimation()
			f9_arg0.BackingWhite:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BackingWhite)
			f9_arg0.NoiseTiledBacking:completeAnimation()
			f9_arg0.NoiseTiledBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NoiseTiledBacking)
			f9_arg0.TiledBacking:completeAnimation()
			f9_arg0.TiledBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TiledBacking)
			f9_arg0.GridTiled:completeAnimation()
			f9_arg0.GridTiled:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.GridTiled)
			f9_arg0.BlackfadeBlurB:completeAnimation()
			f9_arg0.BlackfadeBlurB:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BlackfadeBlurB)
			f9_arg0.BlackfadeBlurF:completeAnimation()
			f9_arg0.BlackfadeBlurF:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BlackfadeBlurF)
			f9_arg0.DescriptionTint2:completeAnimation()
			f9_arg0.DescriptionTint2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DescriptionTint2)
			f9_arg0.DescriptionTint:completeAnimation()
			f9_arg0.DescriptionTint:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DescriptionTint)
			f9_arg0.UnlockDescription:completeAnimation()
			f9_arg0.UnlockDescription:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.UnlockDescription)
			f9_arg0.ClassName:completeAnimation()
			f9_arg0.ClassName:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ClassName)
			f9_arg0.DotCorner9Slice:completeAnimation()
			f9_arg0.DotCorner9Slice:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DotCorner9Slice)
			f9_arg0.LockImage:completeAnimation()
			f9_arg0.LockImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LockImage)
			f9_arg0.BotBarAdd:completeAnimation()
			f9_arg0.BotBarAdd:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BotBarAdd)
			f9_arg0.LayoutTopBar:completeAnimation()
			f9_arg0.LayoutTopBar:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LayoutTopBar)
			f9_arg0.LayoutBotStripe:completeAnimation()
			f9_arg0.LayoutBotStripe:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LayoutBotStripe)
			f9_arg0.RankIcon:completeAnimation()
			f9_arg0.RankIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RankIcon)
			f9_arg0.blockPCNavigationEmptyFocusable:completeAnimation()
			f9_arg0.blockPCNavigationEmptyFocusable:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.blockPCNavigationEmptyFocusable)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	ZombiesVisible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.BackingBlack:completeAnimation()
			f11_arg0.BackingBlack:setTopBottom(0, 0, 115.5, 1079.5)
			f11_arg0.clipFinished(f11_arg0.BackingBlack)
			f11_arg0.BackingWhite:completeAnimation()
			f11_arg0.BackingWhite:setTopBottom(0, 0, 115.5, 1079.5)
			f11_arg0.clipFinished(f11_arg0.BackingWhite)
			f11_arg0.NoiseTiledBacking:completeAnimation()
			f11_arg0.NoiseTiledBacking:setTopBottom(0, 0, 115.5, 1079.5)
			f11_arg0.clipFinished(f11_arg0.NoiseTiledBacking)
		end,
	},
}
CoD.ChooseClassLockedOverlay.__onClose = function(f12_arg0)
	f12_arg0.UnlockDescription:close()
	f12_arg0.ClassName:close()
	f12_arg0.DotCorner9Slice:close()
	f12_arg0.RankIcon:close()
	f12_arg0.blockPCNavigationEmptyFocusable:close()
end
