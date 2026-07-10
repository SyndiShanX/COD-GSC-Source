require("x64:f78acfcbc465bba")
require("x64:94dab3a4d2d79b2")
require("x64:19c1945d2e472b0")
CoD.FTUEGameIntroductionInfo = InheritFrom(LUI.UIElement)
CoD.FTUEGameIntroductionInfo.__defaultWidth = 296
CoD.FTUEGameIntroductionInfo.__defaultHeight = 424
CoD.FTUEGameIntroductionInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FTUEGameIntroductionInfo)
	self.id = "FTUEGameIntroductionInfo"
	self.soundSet = "default"
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 296, 0.09, 0.09, 388, 647)
	NoiseTiledBacking:setAlpha(0.7)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Image = LUI.UIImage.new(0, 0, 0, 296, 0, 0, 0, 424)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f2_local0)))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 296, 0, 0, 379, 424)
	DotTiledBacking:setAlpha(0.69)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 296, 0, 0, 379, 424)
	DotCorner9Slice:setAlpha(0.72)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local TitleText = LUI.UIText.new(0, 0, 9, 285, 0, 0, 391, 414)
	TitleText:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	TitleText:setTTF("ttmussels_demibold")
	TitleText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	TitleText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"]))
	TitleText:linkToElementModel(self, "displayTitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TitleText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(TitleText)
	self.TitleText = TitleText
	local BodyText = LUI.UIText.new(0, 0, 9, 285, 0, 0, 438.5, 456.5)
	BodyText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BodyText:setTTF("dinnext_regular")
	BodyText:setLineSpacing(5)
	BodyText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	BodyText:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	BodyText:linkToElementModel(self, "displayText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BodyText:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(BodyText)
	self.BodyText = BodyText
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	local infoBracketBot = LUI.UIImage.new(0, 0, -1, 297, 0, 0, 676, 684)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FTUEGameIntroductionInfo.__onClose = function(f5_arg0)
	f5_arg0.Image:close()
	f5_arg0.DotTiledBacking:close()
	f5_arg0.DotCorner9Slice:close()
	f5_arg0.TitleText:close()
	f5_arg0.BodyText:close()
	f5_arg0.Lines:close()
end
