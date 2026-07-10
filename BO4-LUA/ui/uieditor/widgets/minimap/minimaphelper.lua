CoD.MinimapHelper = InheritFrom(LUI.UIElement)
CoD.MinimapHelper.__defaultWidth = 1140
CoD.MinimapHelper.__defaultHeight = 740
CoD.MinimapHelper.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MinimapHelper)
	self.id = "MinimapHelper"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HDRClamp = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HDRClamp:setRGB(0, 0, 0)
	HDRClamp:setMaterial(LUI.UIImage.GetCachedMaterial(0x7076F9EF46E6640))
	self:addElement(HDRClamp)
	self.HDRClamp = HDRClamp
	local BackingColor = LUI.UIImage.new(0.25, 1.75, -570, -570, 0.25, 1.75, -370, -370)
	BackingColor:setRGB(0.01, 0.01, 0.01)
	self:addElement(BackingColor)
	self.BackingColor = BackingColor
	local MapGlitch = LUI.UIImage.new(0, 1, -1, -1, 0, 1, 0, 0)
	MapGlitch:setRGB(0.01, 0.01, 0.01)
	MapGlitch:setImage(RegisterImage(GetCurrentMinimapImageName(0x6E4CF8E78AE6592)))
	self:addElement(MapGlitch)
	self.MapGlitch = MapGlitch
	local MapBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapBacking:setRGB(0.38, 0.38, 0.38)
	self:addElement(MapBacking)
	self.MapBacking = MapBacking
	local MinimapFogOfWar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWar:setImage(RegisterImage(0x6B3F6C9FC7AEC8A))
	MinimapFogOfWar:setMaterial(LUI.UIImage.GetCachedMaterial(0xACA98D41A38E390))
	MinimapFogOfWar:setShaderVector(0, 1, 0.1, 0.05, 0)
	MinimapFogOfWar:setupCompassFog(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	MinimapFogOfWar:setupCompassFogImageDiameter(1)
	self:addElement(MinimapFogOfWar)
	self.MinimapFogOfWar = MinimapFogOfWar
	local MinimapFogOfWarEnemyTearing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setImage(RegisterImage(0x706DFCD9F680830))
	MinimapFogOfWarEnemyTearing:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	MinimapFogOfWarEnemyTearing:setShaderVector(0, 5, 1, 0, 0)
	MinimapFogOfWarEnemyTearing:setShaderVector(1, 0, 0, 0, 0)
	MinimapFogOfWarEnemyTearing:setupCompassEnemyTearingFog(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	MinimapFogOfWarEnemyTearing:setupCompassFogImageDiameter(0.74)
	self:addElement(MinimapFogOfWarEnemyTearing)
	self.MinimapFogOfWarEnemyTearing = MinimapFogOfWarEnemyTearing
	local overlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	overlay:setAlpha(0.7)
	overlay:setupCompassOverlay(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(overlay)
	self.overlay = overlay
	local Scanlines = LUI.UIImage.new(-0.25, 1.25, 1, 1, -0.25, 1.25, 0, 0)
	Scanlines:setRGB(0.54, 0.53, 0.72)
	Scanlines:setAlpha(0.03)
	Scanlines:setImage(RegisterImage(GetCurrentMinimapImageName(0x6E4CF8E78AE6592)))
	Scanlines:setMaterial(LUI.UIImage.GetCachedMaterial(0x5D13CDAD1938D85))
	Scanlines:setShaderVector(0, 0.07, 0, 0, 0)
	Scanlines:setShaderVector(1, 0.86, 0, 0, 0)
	Scanlines:setShaderVector(2, 0.01, 0, 0, 0)
	self:addElement(Scanlines)
	self.Scanlines = Scanlines
	local MinimapMap2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MinimapMap2:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	MinimapMap2:setupCompassMap(Enum[0x398581F68B3E097][0x72D54007C707EBC])
	self:addElement(MinimapMap2)
	self.MinimapMap2 = MinimapMap2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MinimapHelper.__resetProperties = function(f2_arg0)
	f2_arg0.Scanlines:completeAnimation()
	f2_arg0.Scanlines:setMaterial(LUI.UIImage.GetCachedMaterial(0x5D13CDAD1938D85))
	f2_arg0.Scanlines:setShaderVector(0, 0.07, 0, 0, 0)
	f2_arg0.Scanlines:setShaderVector(1, 0.86, 0, 0, 0)
	f2_arg0.Scanlines:setShaderVector(2, 0.01, 0, 0, 0)
end
CoD.MinimapHelper.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(4000)
					f5_arg0:setShaderVector(2, 0, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Scanlines:beginAnimation(4000)
				f3_arg0.Scanlines:setShaderVector(2, 0.01, 0, 0, 0)
				f3_arg0.Scanlines:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Scanlines:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Scanlines:completeAnimation()
			f3_arg0.Scanlines:setMaterial(LUI.UIImage.GetCachedMaterial(0x5D13CDAD1938D85))
			f3_arg0.Scanlines:setShaderVector(0, 0.07, 0, 0, 0)
			f3_arg0.Scanlines:setShaderVector(1, 0.86, 0, 0, 0)
			f3_arg0.Scanlines:setShaderVector(2, 0, 0, 0, 0)
			f3_local0(f3_arg0.Scanlines)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
