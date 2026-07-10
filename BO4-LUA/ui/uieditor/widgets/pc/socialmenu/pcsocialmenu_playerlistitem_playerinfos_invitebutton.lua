CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton.__defaultWidth = 50
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton.__defaultHeight = 50
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton)
	self.id = "PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0.9, 0, 0)
	ButtonBG:setRGB(0.12, 0.12, 0.12)
	self:addElement(ButtonBG)
	self.ButtonBG = ButtonBG
	local InviteIcon = LUI.UIImage.new(0.15, 0.85, 0, 0, 0.1, 0.8, 0, 0)
	InviteIcon:setImage(RegisterImage(0x218AEB6D7780F8E))
	self:addElement(InviteIcon)
	self.InviteIcon = InviteIcon
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NineSliceShaderImage:setImage(RegisterImage(0xD21D1B533ED3AEA))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(14, 14)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonBG:completeAnimation()
	f2_arg0.InviteIcon:completeAnimation()
	f2_arg0.ButtonBG:setRGB(0.12, 0.12, 0.12)
	f2_arg0.InviteIcon:setRGB(1, 1, 1)
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_InviteButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.ButtonBG:beginAnimation(100)
				f4_arg0.ButtonBG:setRGB(0.16, 0.16, 0.16)
				f4_arg0.ButtonBG:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ButtonBG:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.ButtonBG:completeAnimation()
			f4_arg0.ButtonBG:setRGB(0.12, 0.12, 0.12)
			f4_local0(f4_arg0.ButtonBG)
			local f4_local1 = function(f6_arg0)
				f4_arg0.InviteIcon:beginAnimation(100)
				f4_arg0.InviteIcon:setRGB(1, 1, 1)
				f4_arg0.InviteIcon:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.InviteIcon:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.InviteIcon:completeAnimation()
			f4_arg0.InviteIcon:setRGB(0.57, 0.57, 0.57)
			f4_local1(f4_arg0.InviteIcon)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ButtonBG:beginAnimation(100)
				f7_arg0.ButtonBG:setRGB(0.12, 0.12, 0.12)
				f7_arg0.ButtonBG:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonBG:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonBG:completeAnimation()
			f7_arg0.ButtonBG:setRGB(0.16, 0.16, 0.16)
			f7_local0(f7_arg0.ButtonBG)
			local f7_local1 = function(f9_arg0)
				f7_arg0.InviteIcon:beginAnimation(100)
				f7_arg0.InviteIcon:setRGB(0.57, 0.57, 0.57)
				f7_arg0.InviteIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.InviteIcon:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.InviteIcon:completeAnimation()
			f7_arg0.InviteIcon:setRGB(1, 1, 1)
			f7_local1(f7_arg0.InviteIcon)
		end,
	},
}
