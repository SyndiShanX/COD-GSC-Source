CoD.DirectorDraftSelectLoadoutInternal = InheritFrom(LUI.UIElement)
CoD.DirectorDraftSelectLoadoutInternal.__defaultWidth = 75
CoD.DirectorDraftSelectLoadoutInternal.__defaultHeight = 75
CoD.DirectorDraftSelectLoadoutInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorDraftSelectLoadoutInternal)
	self.id = "DirectorDraftSelectLoadoutInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0, 0, 75, 0, 0, 0, 75)
	Backing:setRGB(0.17, 0.17, 0.17)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Backing:setShaderVector(0, 0, 0.7, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local InspecReticleCornerDots = LUI.UIImage.new(0, 0, 0, 75, 0, 0, 0, 75)
	InspecReticleCornerDots:setAlpha(0.1)
	InspecReticleCornerDots:setImage(RegisterImage(0x23FBEAF2C01C54C))
	InspecReticleCornerDots:setMaterial(LUI.UIImage.GetCachedMaterial(0x5956C6C1FD41D3C))
	InspecReticleCornerDots:setShaderVector(0, 0.2, 1, 0, 0)
	InspecReticleCornerDots:setShaderVector(1, 0, 0, 0, 0)
	InspecReticleCornerDots:setShaderVector(2, 0, 0, 0, 0)
	InspecReticleCornerDots:setShaderVector(3, 0, 0, 0, 0)
	InspecReticleCornerDots:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(InspecReticleCornerDots)
	self.InspecReticleCornerDots = InspecReticleCornerDots
	local LoadoutText = LUI.UIText.new(0.5, 0.5, -37.5, 37.5, 0.5, 0.5, -15, 0)
	LoadoutText:setText(Engine[0xF9F1239CFD921FE](0x2CD058C9967F620))
	LoadoutText:setTTF("default")
	LoadoutText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LoadoutText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LoadoutText)
	self.LoadoutText = LoadoutText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorDraftSelectLoadoutInternal.__resetProperties = function(f2_arg0)
	f2_arg0.LoadoutText:completeAnimation()
	f2_arg0.LoadoutText:setRGB(1, 1, 1)
end
CoD.DirectorDraftSelectLoadoutInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.LoadoutText:completeAnimation()
			f4_arg0.LoadoutText:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.LoadoutText)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.LoadoutText:beginAnimation(200)
				f5_arg0.LoadoutText:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
				f5_arg0.LoadoutText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.LoadoutText:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.LoadoutText:completeAnimation()
			f5_arg0.LoadoutText:setRGB(1, 1, 1)
			f5_local0(f5_arg0.LoadoutText)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.LoadoutText:beginAnimation(200)
				f7_arg0.LoadoutText:setRGB(1, 1, 1)
				f7_arg0.LoadoutText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.LoadoutText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.LoadoutText:completeAnimation()
			f7_arg0.LoadoutText:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f7_local0(f7_arg0.LoadoutText)
		end,
	},
}
