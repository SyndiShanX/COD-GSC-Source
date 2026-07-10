require("x64:f78acfcbc465bba")
require("x64:94dab3a4d2d79b2")
require("x64:19c1945d2e472b0")
CoD.FTUEWZProgressionLargeWidget = InheritFrom(LUI.UIElement)
CoD.FTUEWZProgressionLargeWidget.__defaultWidth = 500
CoD.FTUEWZProgressionLargeWidget.__defaultHeight = 800
CoD.FTUEWZProgressionLargeWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FTUEWZProgressionLargeWidget)
	self.id = "FTUEWZProgressionLargeWidget"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.23, 0.23, 0.23)
	self:addElement(Background)
	self.Background = Background
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 500, 0.09, 0.09, -68, 732)
	NoiseTiledBacking:setAlpha(0.7)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 718, 800)
	DotTiledBacking:setAlpha(0.69)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 718, 800)
	DotCorner9Slice:setAlpha(0.72)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local EchelonImage = LUI.UIImage.new(0, 0, 49, 451, 0, 0, 63.5, 465.5)
	EchelonImage:setImage(RegisterImage(@"ui_icon_rank_wz_master_large"))
	self:addElement(EchelonImage)
	self.EchelonImage = EchelonImage
	local EchelonTitle = LUI.UIText.new(0, 0, 0, 500, 0, 0, 733, 762)
	EchelonTitle:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	EchelonTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_11E01D65FBE7F99B"))
	EchelonTitle:setTTF("ttmussels_demibold")
	EchelonTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EchelonTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EchelonTitle)
	self.EchelonTitle = EchelonTitle
	local EchelonIndex = LUI.UIText.new(0, 0, 0, 500, 0, 0, 766, 789)
	EchelonIndex:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EchelonIndex:setText(LocalizeStringWithParameter(@"hash_2294790D215078A9", LocalizeHash(@"hash_54008CE61FE52DCD")))
	EchelonIndex:setTTF("ttmussels_regular")
	EchelonIndex:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EchelonIndex:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EchelonIndex)
	self.EchelonIndex = EchelonIndex
	local CallingCardImage = LUI.UIImage.new(0, 0, 58.5, 464.5, 0, 0, 569.5, 671.5)
	CallingCardImage:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_insigniaechelons_master"))
	self:addElement(CallingCardImage)
	self.CallingCardImage = CallingCardImage
	local wzcharacterunlock = LUI.UIImage.new(0, 0, -14.5, 260.5, 0, 0, 476, 718)
	wzcharacterunlock:setImage(RegisterImage(@"uie_ui_icon_specialist_portrait_draft_hardened_male"))
	self:addElement(wzcharacterunlock)
	self.wzcharacterunlock = wzcharacterunlock
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FTUEWZProgressionLargeWidget.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
	f2_arg0.DotCorner9Slice:close()
	f2_arg0.Lines:close()
end
