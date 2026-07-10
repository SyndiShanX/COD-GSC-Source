require("x64:dab8c3a6f5b136c")
require("x64:5f8cf56752aa71b")
CoD.DirectorTutorialMapSelectItem_Internal = InheritFrom(LUI.UIElement)
CoD.DirectorTutorialMapSelectItem_Internal.__defaultWidth = 246
CoD.DirectorTutorialMapSelectItem_Internal.__defaultHeight = 104
CoD.DirectorTutorialMapSelectItem_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTutorialMapSelectItem_Internal)
	self.id = "DirectorTutorialMapSelectItem_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(0, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local Highlight = LUI.UIImage.new(0, 1, -52, 52, 0, 1, -60, 60)
	Highlight:setAlpha(0.03)
	Highlight:setImage(RegisterImage(0xC9205D0D378F108))
	Highlight:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	Highlight:setShaderVector(0, 0, 0, 0, 0.25)
	Highlight:setShaderVector(1, 1, 0, 0, 0)
	Highlight:setupNineSliceShader(100, 100)
	self:addElement(Highlight)
	self.Highlight = Highlight
	local MapImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapImage:setRGB(0.6, 0.6, 0.6)
	MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	MapImage:setShaderVector(0, 0, 0, 0, 0)
	MapImage:setShaderVector(1, 1, 1, 0, 0)
	MapImage:setShaderVector(2, 0, 0, 0, 0)
	MapImage:linkToElementModel(self, "id", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage:setImage(RegisterImage(MapNameToMapImage(f2_local0)))
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local nameBg = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 79, 104)
	nameBg:setRGB(0, 0, 0)
	nameBg:setAlpha(0.75)
	self:addElement(nameBg)
	self.nameBg = nameBg
	local MapName = LUI.UIText.new(0, 0, 9, 245, 1, 1, -22, -4)
	MapName:setTTF("skorzhen")
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	MapName:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MapName:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	local TeamName = LUI.UIText.new(1, 1, -204, -4, 1, 1, -22, -4)
	TeamName:setTTF("skorzhen")
	TeamName:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TeamName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TeamName:linkToElementModel(self, "id", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TeamName:setText(Engine[0xF9F1239CFD921FE](CoD.MapUtility.GetMapTeamNameFromMapID(f4_local0)))
		end
	end)
	self:addElement(TeamName)
	self.TeamName = TeamName
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local GamemodeIcon = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -120, 80)
	GamemodeIcon:setAlpha(0)
	GamemodeIcon:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GamemodeIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(GamemodeIcon)
	self.GamemodeIcon = GamemodeIcon
	local EquippedMarkerTick2 = LUI.UIImage.new(1, 1, -150, 10, 0, 0, -17, 143)
	EquippedMarkerTick2:setAlpha(0)
	EquippedMarkerTick2:setImage(RegisterImage(0x65F14AD6E4F3F8F))
	self:addElement(EquippedMarkerTick2)
	self.EquippedMarkerTick2 = EquippedMarkerTick2
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "MapVote.mapVoteMapNext", "id") and CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "localZMDifficulty", "difficulty")
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[0x8DF2E5447F384B9]()
	f1_local13(f1_local12, f1_local14["MapVote.mapVoteMapNext"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "MapVote.mapVoteMapNext",
		})
	end, false)
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[0x8DF2E5447F384B9]()
	f1_local13(f1_local12, f1_local14.localZMDifficulty, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "localZMDifficulty",
		})
	end, false)
	self:linkToElementModel(self, "difficulty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "difficulty",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTutorialMapSelectItem_Internal.__resetProperties = function(f11_arg0)
	f11_arg0.MapName:completeAnimation()
	f11_arg0.TeamName:completeAnimation()
	f11_arg0.EquippedMarkerTick2:completeAnimation()
	f11_arg0.MapName:setRGB(1, 1, 1)
	f11_arg0.TeamName:setRGB(1, 1, 1)
	f11_arg0.EquippedMarkerTick2:setAlpha(0)
end
CoD.DirectorTutorialMapSelectItem_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.MapName:completeAnimation()
			f13_arg0.MapName:setRGB(0.92, 0.89, 0.72)
			f13_arg0.clipFinished(f13_arg0.MapName)
			f13_arg0.TeamName:completeAnimation()
			f13_arg0.TeamName:setRGB(0.92, 0.89, 0.72)
			f13_arg0.clipFinished(f13_arg0.TeamName)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.MapName:completeAnimation()
			f14_arg0.MapName:setRGB(0.92, 0.89, 0.72)
			f14_arg0.clipFinished(f14_arg0.MapName)
			f14_arg0.TeamName:completeAnimation()
			f14_arg0.TeamName:setRGB(0.92, 0.89, 0.72)
			f14_arg0.clipFinished(f14_arg0.TeamName)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.MapName:completeAnimation()
			f15_arg0.MapName:setRGB(0.92, 0.89, 0.72)
			f15_arg0.clipFinished(f15_arg0.MapName)
			f15_arg0.TeamName:completeAnimation()
			f15_arg0.TeamName:setRGB(0.92, 0.89, 0.72)
			f15_arg0.clipFinished(f15_arg0.TeamName)
		end,
	},
	Selected = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.EquippedMarkerTick2:completeAnimation()
			f16_arg0.EquippedMarkerTick2:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.EquippedMarkerTick2)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.MapName:completeAnimation()
			f17_arg0.MapName:setRGB(0.92, 0.89, 0.72)
			f17_arg0.clipFinished(f17_arg0.MapName)
			f17_arg0.TeamName:completeAnimation()
			f17_arg0.TeamName:setRGB(0.92, 0.89, 0.72)
			f17_arg0.clipFinished(f17_arg0.TeamName)
			f17_arg0.EquippedMarkerTick2:completeAnimation()
			f17_arg0.EquippedMarkerTick2:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.EquippedMarkerTick2)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.MapName:completeAnimation()
			f18_arg0.MapName:setRGB(0.92, 0.89, 0.72)
			f18_arg0.clipFinished(f18_arg0.MapName)
			f18_arg0.TeamName:completeAnimation()
			f18_arg0.TeamName:setRGB(0.92, 0.89, 0.72)
			f18_arg0.clipFinished(f18_arg0.TeamName)
			f18_arg0.EquippedMarkerTick2:completeAnimation()
			f18_arg0.EquippedMarkerTick2:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.EquippedMarkerTick2)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.MapName:completeAnimation()
			f19_arg0.MapName:setRGB(1, 1, 1)
			f19_arg0.clipFinished(f19_arg0.MapName)
			f19_arg0.TeamName:completeAnimation()
			f19_arg0.TeamName:setRGB(1, 1, 1)
			f19_arg0.clipFinished(f19_arg0.TeamName)
			f19_arg0.EquippedMarkerTick2:completeAnimation()
			f19_arg0.EquippedMarkerTick2:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.EquippedMarkerTick2)
		end,
	},
}
CoD.DirectorTutorialMapSelectItem_Internal.__onClose = function(f20_arg0)
	f20_arg0.DotTiledBacking:close()
	f20_arg0.MapImage:close()
	f20_arg0.MapName:close()
	f20_arg0.TeamName:close()
	f20_arg0.CommonButtonOutline:close()
	f20_arg0.GamemodeIcon:close()
end
