CoD.ArenaRubyProgressRedBar = InheritFrom(LUI.UIElement)
CoD.ArenaRubyProgressRedBar.__defaultWidth = 480
CoD.ArenaRubyProgressRedBar.__defaultHeight = 50
CoD.ArenaRubyProgressRedBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRubyProgressRedBar)
	self.id = "ArenaRubyProgressRedBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 90, -90, 0, 1, 21, -21)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BG = LUI.UIImage.new(0, 1, 90, -90, 0, 1, 21, -21)
	BG:setRGB(0, 0, 0)
	BG:setAlpha(0.2)
	self:addElement(BG)
	self.BG = BG
	local RedBar01 = LUI.UIImage.new(0, 1, 90, -90, 0, 1, 21, -21)
	RedBar01:setRGB(0.44, 0.03, 0.03)
	self:addElement(RedBar01)
	self.RedBar01 = RedBar01
	local FocusGlow01 = LUI.UIImage.new(0, 1, 20, -20, 0, 1, 0, 0)
	FocusGlow01:setRGB(1, 0.35, 0.34)
	FocusGlow01:setAlpha(0.2)
	FocusGlow01:setImage(RegisterImage(0x223AD1B40A93955))
	FocusGlow01:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow01:setShaderVector(0, 0, 0, 0.21, 0.09)
	FocusGlow01:setShaderVector(1, 1.36, 0, 0, 0)
	FocusGlow01:setupNineSliceShader(245, 185)
	self:addElement(FocusGlow01)
	self.FocusGlow01 = FocusGlow01
	local Dot01 = LUI.UIImage.new(0, 1, 90, -90, 0, 1, 21, -21)
	Dot01:setImage(RegisterImage(0x4B6FFA90272070E))
	Dot01:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Dot01:setShaderVector(0, 0, 0, 0, 0)
	Dot01:setupNineSliceShader(24, 24)
	self:addElement(Dot01)
	self.Dot01 = Dot01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaRubyProgressRedBar.__resetProperties = function(f2_arg0)
	f2_arg0.FocusGlow01:completeAnimation()
	f2_arg0.FocusGlow01:setLeftRight(0, 1, 20, -20)
end
CoD.ArenaRubyProgressRedBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(199)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(2800)
						f6_arg0:setLeftRight(0, 1, 20, -20)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(200)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.FocusGlow01:beginAnimation(2800)
				f3_arg0.FocusGlow01:setLeftRight(0, 1, -20, 20)
				f3_arg0.FocusGlow01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.FocusGlow01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.FocusGlow01:completeAnimation()
			f3_arg0.FocusGlow01:setLeftRight(0, 1, 20, -20)
			f3_local0(f3_arg0.FocusGlow01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
