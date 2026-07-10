require("x64:3e426332d66c91e")
require("x64:e12ddba2d13fc72")
CoD.DirectorLobbyMemberInternalCardNeverExpanded = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMemberInternalCardNeverExpanded.__defaultWidth = 68
CoD.DirectorLobbyMemberInternalCardNeverExpanded.__defaultHeight = 68
CoD.DirectorLobbyMemberInternalCardNeverExpanded.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMemberInternalCardNeverExpanded)
	self.id = "DirectorLobbyMemberInternalCardNeverExpanded"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlur = LUI.UIImage.new(0, 0, 0, 68, 0, 0, 0, 68)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 0, -10, 78, 0.5, 0.5, -44, 44)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local BackingBorder = LUI.UIImage.new(0, 0, 0, 68, 0, 0, 0, 68)
	BackingBorder:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingBorder:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder)
	self.BackingBorder = BackingBorder
	local BackingBorder2 = LUI.UIImage.new(0, 0, 0, 68, 0, 0, 0, 68)
	BackingBorder2:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	BackingBorder2:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder2:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder2)
	self.BackingBorder2 = BackingBorder2
	local EmblemBacking = LUI.UIImage.new(0, 0, 2, 66, 0, 0, 2, 66)
	EmblemBacking:setRGB(0, 0, 0)
	EmblemBacking:setAlpha(0.8)
	self:addElement(EmblemBacking)
	self.EmblemBacking = EmblemBacking
	local emblem = LUI.UIImage.new(0, 0, 2, 66, 0, 0, 2, 66)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, 2, 66, 0, 0, -28.5, -3.5)
	VoipWaves.Muted:setZRot(0)
	VoipWaves:linkToElementModel(self, "info", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			VoipWaves:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local FocusBorder = LUI.UIImage.new(0, 0, -2, 70, 0, 1, -2, 2)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(5, 5)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local FrontendFrame = LUI.UIImage.new(0, 0, -1, 69, 0, 0, -1, 69)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local FocusGlowSquare = LUI.UIImage.new(-0, 0.53, -34, 66, 0.26, 0.74, -50, 50)
	FocusGlowSquare:setAlpha(0)
	FocusGlowSquare:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlowSquare:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlowSquare:setShaderVector(0, 0, 0, 0.24, 0.25)
	FocusGlowSquare:setShaderVector(1, 1, 0, 0, 0)
	FocusGlowSquare:setupNineSliceShader(100, 100)
	self:addElement(FocusGlowSquare)
	self.FocusGlowSquare = FocusGlowSquare
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyMemberInternalCardNeverExpanded.__resetProperties = function(f4_arg0)
	f4_arg0.FocusBorder:completeAnimation()
	f4_arg0.FocusBrackets:completeAnimation()
	f4_arg0.FocusGlowSquare:completeAnimation()
	f4_arg0.FocusBorder:setLeftRight(0, 0, -2, 70)
	f4_arg0.FocusBorder:setAlpha(0)
	f4_arg0.FocusBrackets:setLeftRight(0, 0, -10, 78)
	f4_arg0.FocusBrackets:setTopBottom(0.5, 0.5, -44, 44)
	f4_arg0.FocusBrackets:setAlpha(0)
	f4_arg0.FocusGlowSquare:setAlpha(0)
end
CoD.DirectorLobbyMemberInternalCardNeverExpanded.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.FocusBrackets:completeAnimation()
			f6_arg0.FocusBrackets:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FocusBrackets)
			f6_arg0.FocusBorder:completeAnimation()
			f6_arg0.FocusBorder:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FocusBorder)
			f6_arg0.FocusGlowSquare:completeAnimation()
			f6_arg0.FocusGlowSquare:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FocusGlowSquare)
		end,
		Active = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.FocusBorder:completeAnimation()
			f7_arg0.FocusBorder:setLeftRight(0, 0, -2, 70)
			f7_arg0.clipFinished(f7_arg0.FocusBorder)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f10_arg0:setLeftRight(0, 0, -10, 78)
					f10_arg0:setTopBottom(0.5, 0.5, -44, 44)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.FocusBrackets:beginAnimation(100)
				f8_arg0.FocusBrackets:setLeftRight(0, 0, -8, 76)
				f8_arg0.FocusBrackets:setTopBottom(0.5, 0.5, -42, 42)
				f8_arg0.FocusBrackets:setAlpha(0.75)
				f8_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.FocusBrackets:completeAnimation()
			f8_arg0.FocusBrackets:setLeftRight(0, 0, -30, 98)
			f8_arg0.FocusBrackets:setTopBottom(0.5, 0.5, -64, 64)
			f8_arg0.FocusBrackets:setAlpha(0)
			f8_local0(f8_arg0.FocusBrackets)
			local f8_local1 = function(f11_arg0)
				f8_arg0.FocusBorder:beginAnimation(200)
				f8_arg0.FocusBorder:setAlpha(1)
				f8_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusBorder:completeAnimation()
			f8_arg0.FocusBorder:setAlpha(0)
			f8_local1(f8_arg0.FocusBorder)
			local f8_local2 = function(f12_arg0)
				f8_arg0.FocusGlowSquare:beginAnimation(200)
				f8_arg0.FocusGlowSquare:setAlpha(1)
				f8_arg0.FocusGlowSquare:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusGlowSquare:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusGlowSquare:completeAnimation()
			f8_arg0.FocusGlowSquare:setAlpha(0)
			f8_local2(f8_arg0.FocusGlowSquare)
		end,
		LoseFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.FocusBrackets:beginAnimation(60, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f13_arg0.FocusBrackets:setAlpha(0)
				f13_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.FocusBrackets:completeAnimation()
			f13_arg0.FocusBrackets:setAlpha(1)
			f13_local0(f13_arg0.FocusBrackets)
			local f13_local1 = function(f15_arg0)
				f13_arg0.FocusBorder:beginAnimation(200)
				f13_arg0.FocusBorder:setAlpha(0)
				f13_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.FocusBorder:completeAnimation()
			f13_arg0.FocusBorder:setAlpha(1)
			f13_local1(f13_arg0.FocusBorder)
			local f13_local2 = function(f16_arg0)
				f13_arg0.FocusGlowSquare:beginAnimation(200)
				f13_arg0.FocusGlowSquare:setAlpha(0)
				f13_arg0.FocusGlowSquare:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FocusGlowSquare:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.FocusGlowSquare:completeAnimation()
			f13_arg0.FocusGlowSquare:setAlpha(1)
			f13_local2(f13_arg0.FocusGlowSquare)
		end,
	},
}
CoD.DirectorLobbyMemberInternalCardNeverExpanded.__onClose = function(f17_arg0)
	f17_arg0.FocusBrackets:close()
	f17_arg0.emblem:close()
	f17_arg0.VoipWaves:close()
end
