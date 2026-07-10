CoD[0x5193BEB891279E9] = InheritFrom(LUI.UIElement)
CoD[0x5193BEB891279E9].__defaultWidth = 960
CoD[0x5193BEB891279E9].__defaultHeight = 240
CoD[0x5193BEB891279E9].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x5193BEB891279E9])
	self.id = "CallingCards_Operations_Killjoys"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage(0x434A15996B65B48))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x9DCADD45EDA8C8D))
	background:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	background:setShaderVector(0, 1, 1, 0, 0)
	background:setShaderVector(1, 0.03, 0, 0, 0)
	self:addElement(background)
	self.background = background
	local characters = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	characters:setImage(RegisterImage(0x3BAAB7408129209))
	self:addElement(characters)
	self.characters = characters
	local bloodSpurting = LUI.UIImage.new(0, 0, 142, 261, 0, 0, 40, 159)
	bloodSpurting:setAlpha(0)
	bloodSpurting:setImage(RegisterImage(0x25A59953DEFCAE5))
	bloodSpurting:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	bloodSpurting:setShaderVector(0, 0, 4, 0, 0)
	bloodSpurting:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(bloodSpurting)
	self.bloodSpurting = bloodSpurting
	local GlowFist = LUI.UIImage.new(0, 0, 671, 786, 0, 0, 90.5, 195.5)
	GlowFist:setAlpha(0.7)
	GlowFist:setImage(RegisterImage(0x12AE5D2AECB8D92))
	GlowFist:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowFist)
	self.GlowFist = GlowFist
	local gloweyes = LUI.UIImage.new(0, 0, 641, 753, 0, 0, 2, 42)
	gloweyes:setImage(RegisterImage(0x27018CBD53DE18E))
	gloweyes:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	gloweyes:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(gloweyes)
	self.gloweyes = gloweyes
	local SwordSheen = LUI.UIImage.new(0, 0, 502, 622, 0, 0, 85.5, 221.5)
	SwordSheen:setImage(RegisterImage(0x1A64C654F9EAA3))
	SwordSheen:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	SwordSheen:setShaderVector(0, 0, 1, 0, 0)
	SwordSheen:setShaderVector(1, 0, 0, 0, 0)
	SwordSheen:setShaderVector(2, 0, 1, 0, 0)
	SwordSheen:setShaderVector(3, 0, 0, 0, 0)
	SwordSheen:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SwordSheen)
	self.SwordSheen = SwordSheen
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x5193BEB891279E9].__resetProperties = function(f2_arg0)
	f2_arg0.gloweyes:completeAnimation()
	f2_arg0.GlowFist:completeAnimation()
	f2_arg0.SwordSheen:completeAnimation()
	f2_arg0.gloweyes:setAlpha(1)
	f2_arg0.GlowFist:setAlpha(0.7)
	f2_arg0.GlowFist:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	f2_arg0.SwordSheen:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.SwordSheen:setShaderVector(4, 0, 0, 0, 0)
end
CoD[0x5193BEB891279E9].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1060)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.GlowFist:beginAnimation(940)
				f3_arg0.GlowFist:setAlpha(0.6)
				f3_arg0.GlowFist:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowFist:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowFist:completeAnimation()
			f3_arg0.GlowFist:setAlpha(0)
			f3_arg0.GlowFist:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
			f3_local0(f3_arg0.GlowFist)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(1000)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(1000)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.gloweyes:beginAnimation(1000)
				f3_arg0.gloweyes:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gloweyes:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.gloweyes:completeAnimation()
			f3_arg0.gloweyes:setAlpha(0)
			f3_local1(f3_arg0.gloweyes)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(500)
					f10_arg0:setShaderVector(0, -0.03, 0.05, 0, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.SwordSheen:beginAnimation(500)
				f3_arg0.SwordSheen:setShaderVector(0, 0.24, 0.37, 0, 0)
				f3_arg0.SwordSheen:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.SwordSheen:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.SwordSheen:completeAnimation()
			f3_arg0.SwordSheen:setShaderVector(0, 0.9, 0.97, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(1, 0.06, 0.06, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.SwordSheen:setShaderVector(4, 0, 0, 0, 0)
			f3_local2(f3_arg0.SwordSheen)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
