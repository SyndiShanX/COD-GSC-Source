require("x64:6031721cab048e6")
CoD.CompetitiveAARDivisionRankAwardPlaces = InheritFrom(LUI.UIElement)
CoD.CompetitiveAARDivisionRankAwardPlaces.__defaultWidth = 600
CoD.CompetitiveAARDivisionRankAwardPlaces.__defaultHeight = 50
CoD.CompetitiveAARDivisionRankAwardPlaces.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompetitiveAARDivisionRankAwardPlaces)
	self.id = "CompetitiveAARDivisionRankAwardPlaces"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Position = LUI.UIText.new(0.15, 0.15, -85.5, 214.5, 0, 0, 11, 39)
	Position:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Position:setText(Engine[0xF9F1239CFD921FE](0x62C273392778D63))
	Position:setTTF("ttmussels_regular")
	Position:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Position:setLetterSpacing(1)
	Position:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Position:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Position)
	self.Position = Position
	local arenaLeaguePlayRubiesList = CoD.arenaLeaguePlayRubiesList.new(f1_arg0, f1_arg1, 0, 0, 400.5, 540.5, 0, 0, 5, 45)
	self:addElement(arenaLeaguePlayRubiesList)
	self.arenaLeaguePlayRubiesList = arenaLeaguePlayRubiesList
	self.__on_menuOpened_self = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = self
		CoD.ArenaLeaguePlayUtility.FillRubyList(self, self.arenaLeaguePlayRubiesList)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	arenaLeaguePlayRubiesList.id = "arenaLeaguePlayRubiesList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompetitiveAARDivisionRankAwardPlaces.__onClose = function(f4_arg0)
	f4_arg0.__on_close_removeOverrides()
	f4_arg0.arenaLeaguePlayRubiesList:close()
end
