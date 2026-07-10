CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.__defaultWidth = 50
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.__defaultHeight = 50
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton)
	self.id = "PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AcceptButtonBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0.9, 0, 0)
	AcceptButtonBG:setRGB(0.12, 0.12, 0.12)
	self:addElement(AcceptButtonBG)
	self.AcceptButtonBG = AcceptButtonBG
	local AcceptIcon = LUI.UIImage.new(0.1, 0.9, 0, 0, 0.05, 0.85, 0, 0)
	AcceptIcon:setImage(RegisterImage(@"uie_accept_icon"))
	self:addElement(AcceptIcon)
	self.AcceptIcon = AcceptIcon
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NineSliceShaderImage:setImage(RegisterImage(@"uie_borderbutton2_9s"))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(14, 14)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.__resetProperties = function(f2_arg0)
	f2_arg0.AcceptButtonBG:completeAnimation()
	f2_arg0.AcceptIcon:completeAnimation()
	f2_arg0.AcceptButtonBG:setRGB(0.12, 0.12, 0.12)
	f2_arg0.AcceptIcon:setRGB(1, 1, 1)
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.AcceptButtonBG:beginAnimation(100)
				f4_arg0.AcceptButtonBG:setRGB(0.16, 0.16, 0.16)
				f4_arg0.AcceptButtonBG:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.AcceptButtonBG:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.AcceptButtonBG:completeAnimation()
			f4_arg0.AcceptButtonBG:setRGB(0.12, 0.12, 0.12)
			f4_local0(f4_arg0.AcceptButtonBG)
			local f4_local1 = function(f6_arg0)
				f4_arg0.AcceptIcon:beginAnimation(100)
				f4_arg0.AcceptIcon:setRGB(1, 1, 1)
				f4_arg0.AcceptIcon:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.AcceptIcon:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.AcceptIcon:completeAnimation()
			f4_arg0.AcceptIcon:setRGB(0.57, 0.57, 0.57)
			f4_local1(f4_arg0.AcceptIcon)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.AcceptButtonBG:beginAnimation(100)
				f7_arg0.AcceptButtonBG:setRGB(0.12, 0.12, 0.12)
				f7_arg0.AcceptButtonBG:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AcceptButtonBG:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AcceptButtonBG:completeAnimation()
			f7_arg0.AcceptButtonBG:setRGB(0.16, 0.16, 0.16)
			f7_local0(f7_arg0.AcceptButtonBG)
			local f7_local1 = function(f9_arg0)
				f7_arg0.AcceptIcon:beginAnimation(100)
				f7_arg0.AcceptIcon:setRGB(0.57, 0.57, 0.57)
				f7_arg0.AcceptIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AcceptIcon:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AcceptIcon:completeAnimation()
			f7_arg0.AcceptIcon:setRGB(1, 1, 1)
			f7_local1(f7_arg0.AcceptIcon)
		end,
	},
}
