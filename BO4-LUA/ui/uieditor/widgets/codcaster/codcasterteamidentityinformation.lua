CoD.CodCasterTeamIdentityInformation = InheritFrom(LUI.UIElement)
CoD.CodCasterTeamIdentityInformation.__defaultWidth = 684
CoD.CodCasterTeamIdentityInformation.__defaultHeight = 274
CoD.CodCasterTeamIdentityInformation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterTeamIdentityInformation)
	self.id = "CodCasterTeamIdentityInformation"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local outlinelogo3 = LUI.UIImage.new(0, 0, 237, 553, 0, 0, 163, 217)
	outlinelogo3:setImage(RegisterImage(@"uie_ui_menu_common_line_square"))
	outlinelogo3:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	outlinelogo3:setShaderVector(0, 0, 0, 0, 0)
	outlinelogo3:setupNineSliceShader(20, 20)
	self:addElement(outlinelogo3)
	self.outlinelogo3 = outlinelogo3
	local outlinelogo2 = LUI.UIImage.new(0, 0, 237, 553, 0, 0, 58, 112)
	outlinelogo2:setImage(RegisterImage(@"uie_ui_menu_common_line_square"))
	outlinelogo2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	outlinelogo2:setShaderVector(0, 0, 0, 0, 0)
	outlinelogo2:setupNineSliceShader(20, 20)
	self:addElement(outlinelogo2)
	self.outlinelogo2 = outlinelogo2
	local outlinelogo = LUI.UIImage.new(0, 0, 9, 201, 0, 0, 58, 250)
	outlinelogo:setImage(RegisterImage(@"uie_ui_menu_common_line_square"))
	outlinelogo:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	outlinelogo:setShaderVector(0, 0, 0, 0, 0)
	outlinelogo:setupNineSliceShader(20, 20)
	self:addElement(outlinelogo)
	self.outlinelogo = outlinelogo
	local TeamLogoTitle = LUI.UIText.new(0, 0, 13, 311, 0, 0, 30, 51)
	TeamLogoTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TeamLogoTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_753D63E3F4E6CDC0"))
	TeamLogoTitle:setTTF("ttmussels_regular")
	TeamLogoTitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	TeamLogoTitle:setShaderVector(0, 0.08, 0, 0, 0)
	TeamLogoTitle:setShaderVector(1, 0, 0, 0, 0)
	TeamLogoTitle:setShaderVector(2, 1, 0, 0, 0)
	TeamLogoTitle:setLetterSpacing(1)
	TeamLogoTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamLogoTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TeamLogoTitle)
	self.TeamLogoTitle = TeamLogoTitle
	local TeamLogoImage = LUI.UIImage.new(0, 0, 9, 201, 0, 0, 58, 250)
	TeamLogoImage:linkToElementModel(self, "teamLogo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamLogoImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(TeamLogoImage)
	self.TeamLogoImage = TeamLogoImage
	local TeamNameTitle = LUI.UIText.new(0, 0, 241, 541, 0, 0, 30, 51)
	TeamNameTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TeamNameTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D1CDFD2190AC31C"))
	TeamNameTitle:setTTF("ttmussels_regular")
	TeamNameTitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	TeamNameTitle:setShaderVector(0, 0.08, 0, 0, 0)
	TeamNameTitle:setShaderVector(1, 0, 0, 0, 0)
	TeamNameTitle:setShaderVector(2, 1, 0, 0, 0)
	TeamNameTitle:setLetterSpacing(1)
	TeamNameTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamNameTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TeamNameTitle)
	self.TeamNameTitle = TeamNameTitle
	local TeamNameText = LUI.UIText.new(0, 0, 254, 542, 0, 0, 75, 96)
	TeamNameText:setTTF("ttmussels_demibold")
	TeamNameText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamNameText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	TeamNameText:linkToElementModel(self, "teamName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TeamNameText:setText(f3_local0)
		end
	end)
	self:addElement(TeamNameText)
	self.TeamNameText = TeamNameText
	local TeamColorTitle = LUI.UIText.new(0, 0, 241, 541, 0, 0, 141, 162)
	TeamColorTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TeamColorTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21BE11FFFC43DC2E"))
	TeamColorTitle:setTTF("ttmussels_regular")
	TeamColorTitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	TeamColorTitle:setShaderVector(0, 0.08, 0, 0, 0)
	TeamColorTitle:setShaderVector(1, 0, 0, 0, 0)
	TeamColorTitle:setShaderVector(2, 1, 0, 0, 0)
	TeamColorTitle:setLetterSpacing(1)
	TeamColorTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamColorTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TeamColorTitle)
	self.TeamColorTitle = TeamColorTitle
	local TeamColorImage = LUI.UIImage.new(0, 0, 243, 547, 0, 0, 169, 211)
	TeamColorImage:setAlpha(0.6)
	TeamColorImage:linkToElementModel(self, "teamColor", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TeamColorImage:setRGB(f4_local0)
		end
	end)
	self:addElement(TeamColorImage)
	self.TeamColorImage = TeamColorImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterTeamIdentityInformation.__resetProperties = function(f5_arg0)
	f5_arg0.TeamColorImage:completeAnimation()
	f5_arg0.TeamColorTitle:completeAnimation()
	f5_arg0.TeamNameText:completeAnimation()
	f5_arg0.TeamNameTitle:completeAnimation()
	f5_arg0.TeamLogoImage:completeAnimation()
	f5_arg0.TeamLogoTitle:completeAnimation()
	f5_arg0.TeamColorImage:setAlpha(0.6)
	f5_arg0.TeamColorTitle:setAlpha(1)
	f5_arg0.TeamNameText:setAlpha(1)
	f5_arg0.TeamNameTitle:setAlpha(1)
	f5_arg0.TeamLogoImage:setAlpha(1)
	f5_arg0.TeamLogoTitle:setAlpha(1)
end
CoD.CodCasterTeamIdentityInformation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.TeamColorImage:completeAnimation()
			f6_arg0.TeamColorImage:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TeamColorImage)
		end,
	},
	Invisible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			f7_arg0.TeamLogoTitle:completeAnimation()
			f7_arg0.TeamLogoTitle:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TeamLogoTitle)
			f7_arg0.TeamLogoImage:completeAnimation()
			f7_arg0.TeamLogoImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TeamLogoImage)
			f7_arg0.TeamNameTitle:completeAnimation()
			f7_arg0.TeamNameTitle:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TeamNameTitle)
			f7_arg0.TeamNameText:completeAnimation()
			f7_arg0.TeamNameText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TeamNameText)
			f7_arg0.TeamColorTitle:completeAnimation()
			f7_arg0.TeamColorTitle:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TeamColorTitle)
			f7_arg0.TeamColorImage:completeAnimation()
			f7_arg0.TeamColorImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TeamColorImage)
		end,
	},
}
CoD.CodCasterTeamIdentityInformation.__onClose = function(f8_arg0)
	f8_arg0.TeamLogoImage:close()
	f8_arg0.TeamNameText:close()
	f8_arg0.TeamColorImage:close()
end
