require("x64:94dab3a4d2d79b2")
require("x64:31fac280b1c11fc")
CoD.AARRewardHeader = InheritFrom(LUI.UIElement)
CoD.AARRewardHeader.__defaultWidth = 412
CoD.AARRewardHeader.__defaultHeight = 210
CoD.AARRewardHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardHeader)
	self.id = "AARRewardHeader"
	self.soundSet = "none"
	local Pointer = LUI.UIImage.new(0, 0, 190, 222, 0, 0, 209.5, 221.5)
	Pointer:setRGB(0.32, 0.34, 0.13)
	Pointer:setAlpha(0.17)
	Pointer:setZRot(180)
	Pointer:setMaterial(LUI.UIImage.GetCachedMaterial(0xBE6E734C31AE757))
	self:addElement(Pointer)
	self.Pointer = Pointer
	local headerBacking = LUI.UIImage.new(0.5, 0.5, -206, 206, 0, 0, 0, 210)
	headerBacking:setRGB(0.32, 0.34, 0.13)
	headerBacking:setAlpha(0.09)
	self:addElement(headerBacking)
	self.headerBacking = headerBacking
	local TopStripBase = LUI.UIImage.new(0, 0, 2, 298, 0, 0, 0, 6)
	TopStripBase:setAlpha(0)
	self:addElement(TopStripBase)
	self.TopStripBase = TopStripBase
	local TopStripeDiagonal = LUI.UIImage.new(0.5, 0.5, -148, 148, 0, 0, -1, 7)
	TopStripeDiagonal:setRGB(0, 0, 0)
	TopStripeDiagonal:setAlpha(0)
	TopStripeDiagonal:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripeDiagonal:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	TopStripeDiagonal:setShaderVector(0, 1, 1, 0, 0)
	TopStripeDiagonal:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(TopStripeDiagonal)
	self.TopStripeDiagonal = TopStripeDiagonal
	local TitleBacker = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 127, 167)
	TitleBacker:setRGB(0, 0, 0)
	TitleBacker:setAlpha(0.5)
	self:addElement(TitleBacker)
	self.TitleBacker = TitleBacker
	local levelText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 133.5, 162.5)
	levelText:setText("")
	levelText:setTTF("ttmussels_demibold")
	levelText:setLetterSpacing(4)
	levelText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(levelText)
	self.levelText = levelText
	local mainTitle = LUI.UIText.new(0.36, 1.36, -150, -150, 0, 0, 177, 199)
	mainTitle:setRGB(1, 1, 1)
	mainTitle:setText("")
	mainTitle:setTTF("ttmussels_demibold")
	mainTitle:setLetterSpacing(2)
	mainTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	mainTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(mainTitle)
	self.mainTitle = mainTitle
	local mainIcon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -60, 60, 0, 0, 3, 123)
	self:addElement(mainIcon)
	self.mainIcon = mainIcon
	local Header = CoD.WeaponLevelUpHeaderStripe.new(f1_arg0, f1_arg1, 0, 0, 2, 298, 0, 0, 0, 8)
	Header:setAlpha(0)
	Header.HeaderBacking:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Header.HeaderBacking:setShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(Header)
	self.Header = Header
	local GridTiled = LUI.UIImage.new(-0, 1.01, -2, -2, 0, 1.01, -3, -3)
	GridTiled:setAlpha(0.06)
	GridTiled:setScale(0.99, 0.99)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardHeader.__onClose = function(f2_arg0)
	f2_arg0.Header:close()
end
