CoD[0x2991D141DEC107A] = InheritFrom(LUI.UIElement)
CoD[0x2991D141DEC107A].__defaultWidth = 960
CoD[0x2991D141DEC107A].__defaultHeight = 240
CoD[0x2991D141DEC107A].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x2991D141DEC107A])
	self.id = "Callingcards_zm_Elixirs_Talismans"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Bg:setImage(RegisterImage(0xD5733816054D54A))
	Bg:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	Bg:setShaderVector(0, 1, 1, 0, 0)
	Bg:setShaderVector(1, 0.05, 0, 0, 0)
	self:addElement(Bg)
	self.Bg = Bg
	local zombies = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	zombies:setAlpha(0.1)
	zombies:setImage(RegisterImage(0x3EE0D6B51455601))
	zombies:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	zombies:setShaderVector(0, 1, 1, 0, 0)
	zombies:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(zombies)
	self.zombies = zombies
	local wires = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	wires:setImage(RegisterImage(0x57996D2145E9AAC))
	self:addElement(wires)
	self.wires = wires
	local beakers = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	beakers:setImage(RegisterImage(0xB2223E79CADA3B1))
	self:addElement(beakers)
	self.beakers = beakers
	local beakerFlames = LUI.UIImage.new(0, 0, 708.5, 903.5, 0, 0, 163, 272)
	beakerFlames:setRGB(0.44, 0.58, 0.87)
	beakerFlames:setImage(RegisterImage(0x90C9EAABB997320))
	beakerFlames:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	beakerFlames:setShaderVector(0, 0, 3, 0, 0)
	beakerFlames:setShaderVector(1, 24, 0, 0, 0)
	self:addElement(beakerFlames)
	self.beakerFlames = beakerFlames
	local mist = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	mist:setImage(RegisterImage(0x699A82F55A31273))
	mist:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	mist:setShaderVector(0, 1, 1, 0, 0)
	mist:setShaderVector(1, -0.01, 0, 0, 0)
	self:addElement(mist)
	self.mist = mist
	local bubbles = LUI.UIImage.new(0, 0, 759, 845, 0, 0, 163, 496)
	bubbles:setImage(RegisterImage(0x355FCE59C482A5E))
	bubbles:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	bubbles:setShaderVector(0, 1, 1, 0, 0)
	bubbles:setShaderVector(1, 0, 0.3, 0, 0)
	self:addElement(bubbles)
	self.bubbles = bubbles
	local bubbles2 = LUI.UIImage.new(0, 0, 655.5, 692.5, 0, 0, 190.5, 353.5)
	bubbles2:setImage(RegisterImage(0x355FCE59C482A5E))
	bubbles2:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	bubbles2:setShaderVector(0, 1, 1, 0, 0)
	bubbles2:setShaderVector(1, 0, 0.3, 0, 0)
	self:addElement(bubbles2)
	self.bubbles2 = bubbles2
	local beakerShine = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	beakerShine:setImage(RegisterImage(0x33E8918E3CD20C7))
	beakerShine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(beakerShine)
	self.beakerShine = beakerShine
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x2991D141DEC107A].__resetProperties = function(f2_arg0)
	f2_arg0.beakerShine:completeAnimation()
	f2_arg0.beakerShine:setAlpha(1)
end
CoD[0x2991D141DEC107A].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2000)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.beakerShine:beginAnimation(2000)
				f3_arg0.beakerShine:setAlpha(1)
				f3_arg0.beakerShine:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.beakerShine:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.beakerShine:completeAnimation()
			f3_arg0.beakerShine:setAlpha(0)
			f3_local0(f3_arg0.beakerShine)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
