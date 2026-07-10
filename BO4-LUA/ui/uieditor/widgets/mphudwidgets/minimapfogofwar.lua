CoD.MinimapFogOfWar = InheritFrom(LUI.UIElement)
CoD.MinimapFogOfWar.__defaultWidth = 192
CoD.MinimapFogOfWar.__defaultHeight = 192
CoD.MinimapFogOfWar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MinimapFogOfWar)
	self.id = "MinimapFogOfWar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0.29, 0.29, 0.29)
	self:addElement(Image)
	self.Image = Image
	local MinimapFogOfWar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWar:setImage(RegisterImage(0x6B3F6C9FC7AEC8A))
	MinimapFogOfWar:setMaterial(LUI.UIImage.GetCachedMaterial(0xACA98D41A38E390))
	MinimapFogOfWar:setShaderVector(0, 1, 0.1, 0.05, 0)
	MinimapFogOfWar:setupCompassFog(Enum[0x398581F68B3E097][0x87B41F155A4F8BA])
	MinimapFogOfWar:setupCompassFogImageDiameter(0.74)
	self:addElement(MinimapFogOfWar)
	self.MinimapFogOfWar = MinimapFogOfWar
	local MinimapFogOfWarEnemyTearing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setImage(RegisterImage(0x706DFCD9F680830))
	MinimapFogOfWarEnemyTearing:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	MinimapFogOfWarEnemyTearing:setShaderVector(0, 5, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setShaderVector(1, 0, 0, 0, 0)
	MinimapFogOfWarEnemyTearing:setupCompassEnemyTearingFog(Enum[0x398581F68B3E097][0x87B41F155A4F8BA])
	MinimapFogOfWarEnemyTearing:setupCompassFogImageDiameter(0.74)
	self:addElement(MinimapFogOfWarEnemyTearing)
	self.MinimapFogOfWarEnemyTearing = MinimapFogOfWarEnemyTearing
	local CompassMinimapMap = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CompassMinimapMap:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	CompassMinimapMap:setupCompassMap(Enum[0x398581F68B3E097][0x87B41F155A4F8BA])
	self:addElement(CompassMinimapMap)
	self.CompassMinimapMap = CompassMinimapMap
	local MinimapDeathZoneMask = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapDeathZoneMask:setRGB(0.17, 0.17, 0.17)
	MinimapDeathZoneMask:setAlpha(0)
	MinimapDeathZoneMask:setMaterial(LUI.UIImage.GetCachedMaterial(0xA51F864ABFF9887))
	MinimapDeathZoneMask:setShaderVector(0, 0.5, 0.5, 0.2, 0.2)
	MinimapDeathZoneMask:setupCompassDeathZoneMask(Enum[0x398581F68B3E097][0x87B41F155A4F8BA])
	self:addElement(MinimapDeathZoneMask)
	self.MinimapDeathZoneMask = MinimapDeathZoneMask
	self:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MinimapFogOfWar.__resetProperties = function(f4_arg0)
	f4_arg0.Image:completeAnimation()
	f4_arg0.MinimapDeathZoneMask:completeAnimation()
	f4_arg0.Image:setRGB(0.29, 0.29, 0.29)
	f4_arg0.MinimapDeathZoneMask:setAlpha(0)
end
CoD.MinimapFogOfWar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setRGB(0.69, 0.69, 0.69)
			f6_arg0.clipFinished(f6_arg0.Image)
			f6_arg0.MinimapDeathZoneMask:completeAnimation()
			f6_arg0.MinimapDeathZoneMask:setAlpha(0.75)
			f6_arg0.clipFinished(f6_arg0.MinimapDeathZoneMask)
		end,
	},
}
