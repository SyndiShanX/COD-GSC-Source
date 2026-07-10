require("x64:c5498697e836cb4")
require("x64:a9255c570c68aa8")
CoD.LANServerBrowserDetails = InheritFrom(LUI.UIElement)
CoD.LANServerBrowserDetails.__defaultWidth = 515
CoD.LANServerBrowserDetails.__defaultHeight = 610
CoD.LANServerBrowserDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LANServerBrowserDetails)
	self.id = "LANServerBrowserDetails"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Mainframe = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 515, 0, 0, 0, 610)
	Mainframe:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Mainframe:setAlpha(0.01)
	self:addElement(Mainframe)
	self.Mainframe = Mainframe
	local PlayerList = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	PlayerList:setLeftRight(0, 0, 6, 510)
	PlayerList:setTopBottom(0, 0, 350, 610)
	PlayerList:setWidgetType(CoD.LocalServerPlayerListRow)
	PlayerList:setHorizontalCount(2)
	PlayerList:setVerticalCount(6)
	PlayerList:setSpacing(4)
	PlayerList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerList:setDataSource("LocalServerPlayer")
	self:addElement(PlayerList)
	self.PlayerList = PlayerList
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -181, 515, 0, 0, -92, 657)
	TiledPlusGrid:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TiledPlusGrid:setAlpha(0.1)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local PlayerListTitle = LUI.UIText.new(0, 0, 5, 225, 0, 0, 321, 341)
	PlayerListTitle:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	PlayerListTitle:setText(Engine[0xF9F1239CFD921FE](0x8AA6A380B90C9BA))
	PlayerListTitle:setTTF("ttmussels_regular")
	PlayerListTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(PlayerListTitle)
	self.PlayerListTitle = PlayerListTitle
	local MapImage = LUI.UIImage.new(0, 0, 0, 515, 0, 0, 0, 292)
	MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	MapImage:setShaderVector(0, 0, 0, 0, 0)
	MapImage:setShaderVector(1, 1, 1, 0, 0)
	MapImage:setShaderVector(2, 0, 0, 0, 0)
	MapImage:linkToElementModel(self, "mapName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage:setImage(RegisterImage(CoD.MapUtility.MapNameToMapImage(CoD.MapUtility.ConvertMapNameToXHash(f2_local0))))
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local MapBackImage = LUI.UIImage.new(0, 0, 0, 515, 0, 0, 218, 293)
	MapBackImage:setRGB(0, 0, 0)
	MapBackImage:setAlpha(0.6)
	self:addElement(MapBackImage)
	self.MapBackImage = MapBackImage
	local GameType = LUI.UIText.new(0, 0, 16.5, 510.5, 0, 0, 222, 252)
	GameType:setRGB(1, 0.84, 0)
	GameType:setTTF("ttmussels_regular")
	GameType:setLetterSpacing(2)
	GameType:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GameType:linkToElementModel(self, "gameType", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameType:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(CoD.GameTypeUtility.ConvertMapNameToLocalizedXHash(f3_local0)))
		end
	end)
	self:addElement(GameType)
	self.GameType = GameType
	local MapName = LUI.UIText.new(0, 0, 16.5, 500.5, 0, 0, 248, 293)
	MapName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MapName:setTTF("ttmussels_regular")
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MapName:linkToElementModel(self, "mapName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperName(CoD.MapUtility.ConvertMapNameToLocalizedXHash(f4_local0)))
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self, f1_arg1, "")
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	PlayerList.id = "PlayerList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LANServerBrowserDetails.__resetProperties = function(f7_arg0)
	f7_arg0.GameType:completeAnimation()
	f7_arg0.MapName:completeAnimation()
	f7_arg0.MapImage:completeAnimation()
	f7_arg0.PlayerListTitle:completeAnimation()
	f7_arg0.PlayerList:completeAnimation()
	f7_arg0.MapBackImage:completeAnimation()
	f7_arg0.GameType:setLeftRight(0, 0, 16.5, 510.5)
	f7_arg0.GameType:setTopBottom(0, 0, 222, 252)
	f7_arg0.GameType:setAlpha(1)
	f7_arg0.MapName:setLeftRight(0, 0, 16.5, 500.5)
	f7_arg0.MapName:setAlpha(1)
	f7_arg0.MapImage:setAlpha(1)
	f7_arg0.PlayerListTitle:setAlpha(1)
	f7_arg0.PlayerList:setAlpha(1)
	f7_arg0.MapBackImage:setAlpha(0.6)
end
CoD.LANServerBrowserDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.GameType:completeAnimation()
			f8_arg0.GameType:setLeftRight(0, 0, 0, 171)
			f8_arg0.GameType:setTopBottom(0, 0, 218, 248)
			f8_arg0.clipFinished(f8_arg0.GameType)
			f8_arg0.MapName:completeAnimation()
			f8_arg0.MapName:setLeftRight(0, 0, 0, 255)
			f8_arg0.clipFinished(f8_arg0.MapName)
		end,
	},
	Invisible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(6)
			f9_arg0.PlayerList:completeAnimation()
			f9_arg0.PlayerList:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PlayerList)
			f9_arg0.PlayerListTitle:completeAnimation()
			f9_arg0.PlayerListTitle:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PlayerListTitle)
			f9_arg0.MapImage:completeAnimation()
			f9_arg0.MapImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.MapImage)
			f9_arg0.MapBackImage:completeAnimation()
			f9_arg0.MapBackImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.MapBackImage)
			f9_arg0.GameType:completeAnimation()
			f9_arg0.GameType:setTopBottom(0, 0, 218, 248)
			f9_arg0.GameType:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.GameType)
			f9_arg0.MapName:completeAnimation()
			f9_arg0.MapName:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.MapName)
		end,
	},
}
CoD.LANServerBrowserDetails.__onClose = function(f10_arg0)
	f10_arg0.Mainframe:close()
	f10_arg0.PlayerList:close()
	f10_arg0.MapImage:close()
	f10_arg0.GameType:close()
	f10_arg0.MapName:close()
end
