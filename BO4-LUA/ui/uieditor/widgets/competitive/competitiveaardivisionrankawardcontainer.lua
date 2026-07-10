require("x64:9ec6c73b605edb3")
require("x64:3d775f8faa1b3e7")
require("x64:a2c4a319ea5353")
CoD.CompetitiveAARDivisionRankAwardcontainer = InheritFrom(LUI.UIElement)
CoD.CompetitiveAARDivisionRankAwardcontainer.__defaultWidth = 600
CoD.CompetitiveAARDivisionRankAwardcontainer.__defaultHeight = 251
CoD.CompetitiveAARDivisionRankAwardcontainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompetitiveAARDivisionRankAwardcontainer)
	self.id = "CompetitiveAARDivisionRankAwardcontainer"
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
	local GridTiled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GridTiled:setAlpha(0.1)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local Position2 = CoD.CompetitiveAARDivisionRankAwardPlaces.new(f1_arg0, f1_arg1, 0, 0, 16, 616, 0, 0, 185, 235)
	Position2.Position:setText(Engine[0xF9F1239CFD921FE](0xE842BD902956361))
	Position2.arenaLeaguePlayRubiesList.rubiesListSlot:setHorizontalCount(2)
	Position2.arenaLeaguePlayRubiesList.rubiesList:setHorizontalCount(2)
	self:addElement(Position2)
	self.Position2 = Position2
	local Position3 = CoD.CompetitiveAARDivisionRankAwardPlaces.new(f1_arg0, f1_arg1, 0, 0, 16, 616, 0, 0, 118, 168)
	Position3.Position:setText(Engine[0xF9F1239CFD921FE](0x6AF779BB9407343))
	self:addElement(Position3)
	self.Position3 = Position3
	local Position = CoD.CompetitiveAARDivisionRankAwardPlaces.new(f1_arg0, f1_arg1, 0, 0, 16, 616, 0, 0, 52, 102)
	Position.Position:setText(Engine[0xF9F1239CFD921FE](0xF14024E66241B82))
	Position.arenaLeaguePlayRubiesList.rubiesListSlot:setHorizontalCount(4)
	Position.arenaLeaguePlayRubiesList.rubiesList:setHorizontalCount(4)
	self:addElement(Position)
	self.Position = Position
	local PlacementMessage = CoD.CompetitiveAARDivisionRankAwardTittle.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 42)
	PlacementMessage.PlacementMessage:setText(Engine[0xF9F1239CFD921FE](0x59F57B48865828C))
	self:addElement(PlacementMessage)
	self.PlacementMessage = PlacementMessage
	local FETitleNumBrdr00 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FETitleNumBrdr00:setAlpha(0.2)
	self:addElement(FETitleNumBrdr00)
	self.FETitleNumBrdr00 = FETitleNumBrdr00
	Position2.id = "Position2"
	Position3.id = "Position3"
	Position.id = "Position"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompetitiveAARDivisionRankAwardcontainer.__onClose = function(f2_arg0)
	f2_arg0.Position2:close()
	f2_arg0.Position3:close()
	f2_arg0.Position:close()
	f2_arg0.PlacementMessage:close()
	f2_arg0.FETitleNumBrdr00:close()
end
