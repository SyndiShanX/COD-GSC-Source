require("x64:a9255c570c68aa8")
CoD.LeaguePlaySkillDivisionRankBacking = InheritFrom(LUI.UIElement)
CoD.LeaguePlaySkillDivisionRankBacking.__defaultWidth = 411
CoD.LeaguePlaySkillDivisionRankBacking.__defaultHeight = 94
CoD.LeaguePlaySkillDivisionRankBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlaySkillDivisionRankBacking)
	self.id = "LeaguePlaySkillDivisionRankBacking"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WhiteBacking = LUI.UIImage.new(0, 0, 0, 411, 0, 0, 0, 94)
	WhiteBacking:setAlpha(0.02)
	WhiteBacking:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	WhiteBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	WhiteBacking:setShaderVector(0, 0, 0, 0, 0)
	WhiteBacking:setupNineSliceShader(64, 64)
	self:addElement(WhiteBacking)
	self.WhiteBacking = WhiteBacking
	local DarkBacking2 = LUI.UIImage.new(1, 1, -315, 0, 0, 0, 0, 94)
	DarkBacking2:setAlpha(0.25)
	DarkBacking2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	DarkBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	DarkBacking2:setShaderVector(0, 0, 0, 0, 0)
	DarkBacking2:setupNineSliceShader(196, 88)
	self:addElement(DarkBacking2)
	self.DarkBacking2 = DarkBacking2
	local Outline = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 411, 0, 0, 0, 94)
	Outline:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Outline:setAlpha(0.04)
	self:addElement(Outline)
	self.Outline = Outline
	local DotLine = LUI.UIImage.new(0, 0, 95, 97, 0, 0, 0, 94)
	DotLine:setAlpha(0.2)
	DotLine:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	DotLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DotLine:setShaderVector(0, 0, 0, 0, 0)
	DotLine:setupNineSliceShader(8, 3)
	self:addElement(DotLine)
	self.DotLine = DotLine
	local TopTriangle = LUI.UIImage.new(0.5, 0.5, -172, -142, 0.5, 0.5, -66, -46)
	TopTriangle:setRGB(0.92, 0.92, 0.92)
	TopTriangle:setAlpha(0)
	TopTriangle:setZRot(180)
	TopTriangle:setImage(RegisterImage(@"uie_ui_menu_arena_league_hub_triangle"))
	self:addElement(TopTriangle)
	self.TopTriangle = TopTriangle
	self:mergeStateConditions({
		{
			stateName = "NoSkillBadgeBacking",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlaySkillDivisionRankBacking.__resetProperties = function(f3_arg0)
	f3_arg0.WhiteBacking:completeAnimation()
	f3_arg0.DotLine:completeAnimation()
	f3_arg0.DarkBacking2:completeAnimation()
	f3_arg0.WhiteBacking:setAlpha(0.02)
	f3_arg0.DotLine:setAlpha(0.2)
	f3_arg0.DarkBacking2:setLeftRight(1, 1, -315, 0)
end
CoD.LeaguePlaySkillDivisionRankBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	NoSkillBadgeBacking = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.WhiteBacking:completeAnimation()
			f5_arg0.WhiteBacking:setAlpha(0.02)
			f5_arg0.clipFinished(f5_arg0.WhiteBacking)
			f5_arg0.DarkBacking2:completeAnimation()
			f5_arg0.DarkBacking2:setLeftRight(1, 1, -411, 0)
			f5_arg0.clipFinished(f5_arg0.DarkBacking2)
			f5_arg0.DotLine:completeAnimation()
			f5_arg0.DotLine:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.DotLine)
		end,
	},
}
CoD.LeaguePlaySkillDivisionRankBacking.__onClose = function(f6_arg0)
	f6_arg0.Outline:close()
end
