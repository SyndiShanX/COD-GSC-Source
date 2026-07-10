CoD.CodCasterMiniMapName = InheritFrom(LUI.UIElement)
CoD.CodCasterMiniMapName.__defaultWidth = 200
CoD.CodCasterMiniMapName.__defaultHeight = 30
CoD.CodCasterMiniMapName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.CodCasterMiniMapName)
	self.id = "CodCasterMiniMapName"
	self.soundSet = "none"
	local bg = LUI.UIImage.new(-0.4, -0.4, 0, 400, 0.5, 0.5, -15, 15)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.85)
	bg:setImage(RegisterImage(@"hash_4650EEDEA9341CB9"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_75EBE8D6E802F0F5"))
	bg:setShaderVector(0, 1, 0, 0, 0)
	bg:setShaderVector(1, 0.3, 0, 0, 0)
	bg:setShaderVector(2, 2, 0, 0, 0)
	bg:setShaderVector(3, 0, 0, 0, 0)
	bg:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local mapTitle = LUI.UIText.new(0.49, 0.49, -10, 162, 0.5, 0.5, -11.5, 13.5)
	mapTitle:setTTF("ttmussels_regular")
	mapTitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	mapTitle:setShaderVector(0, 0.3, 0, 0, 0)
	mapTitle:setShaderVector(1, 0.3, 0, 0, 0)
	mapTitle:setShaderVector(2, 0, 0, 0, 0.75)
	mapTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	mapTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	mapTitle:subscribeToGlobalModel(f1_arg1, "MapInfo", "mapName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			mapTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(mapTitle)
	self.mapTitle = mapTitle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterMiniMapName.__onClose = function(f3_arg0)
	f3_arg0.mapTitle:close()
end
