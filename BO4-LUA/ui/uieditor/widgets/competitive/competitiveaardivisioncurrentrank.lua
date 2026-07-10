require("x64:5879d06ca5a4b57")
require("x64:3d775f8faa1b3e7")
require("x64:a2c4a319ea5353")
CoD.CompetitiveAARDivisionCurrentRank = InheritFrom(LUI.UIElement)
CoD.CompetitiveAARDivisionCurrentRank.__defaultWidth = 600
CoD.CompetitiveAARDivisionCurrentRank.__defaultHeight = 251
CoD.CompetitiveAARDivisionCurrentRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompetitiveAARDivisionCurrentRank)
	self.id = "CompetitiveAARDivisionCurrentRank"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.05, 0.05, 0.05)
	self:addElement(backing)
	self.backing = backing
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGridTiledBacking:setAlpha(0.07)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local GridTiled = LUI.UIImage.new(0, 1, 1, 1, 0, 1, 0, 0)
	GridTiled:setAlpha(0.1)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local PlacementMessage2 = CoD.CompetitiveAARDivisionRankAwardTittle.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 42)
	PlacementMessage2.PlacementMessage:setText(Engine[0xF9F1239CFD921FE](0xB173E5D02BB9455))
	self:addElement(PlacementMessage2)
	self.PlacementMessage2 = PlacementMessage2
	local FETitleNumBrdr00 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FETitleNumBrdr00:setAlpha(0.2)
	self:addElement(FETitleNumBrdr00)
	self.FETitleNumBrdr00 = FETitleNumBrdr00
	local DivisionIcon = LUI.UIImage.new(0, 0, 33, 208, 0, 0, 60.5, 235.5)
	DivisionIcon:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayIconLarge", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DivisionIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(DivisionIcon)
	self.DivisionIcon = DivisionIcon
	local LadderRank = LUI.UIText.new(0, 0, 238, 438, 0, 0, 109.5, 137.5)
	LadderRank:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	LadderRank:setTTF("ttmussels_regular")
	LadderRank:setLetterSpacing(1)
	LadderRank:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LadderRank:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LadderRank:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRank", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LadderRank:setText(ToUpper(LocalizeStringWithParameter(0x47AC0462E4B2132, f3_local0)))
		end
	end)
	self:addElement(LadderRank)
	self.LadderRank = LadderRank
	local rubies = CoD.ArenaLeaguePlayRubiesDynamic.new(f1_arg0, f1_arg1, 0, 0, 230, 370, 0, 0, 140.5, 180.5)
	self:addElement(rubies)
	self.rubies = rubies
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompetitiveAARDivisionCurrentRank.__onClose = function(f4_arg0)
	f4_arg0.PlacementMessage2:close()
	f4_arg0.FETitleNumBrdr00:close()
	f4_arg0.DivisionIcon:close()
	f4_arg0.LadderRank:close()
	f4_arg0.rubies:close()
end
