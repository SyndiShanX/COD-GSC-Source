CoD.PC_SocialMenu_AddFriendTextBox = InheritFrom(LUI.UIElement)
CoD.PC_SocialMenu_AddFriendTextBox.__defaultWidth = 639
CoD.PC_SocialMenu_AddFriendTextBox.__defaultHeight = 87
CoD.PC_SocialMenu_AddFriendTextBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SocialMenu_AddFriendTextBox)
	self.id = "PC_SocialMenu_AddFriendTextBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0.8)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.08, 0.08, 0.08)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0.92, 0.89, 0.72)
	BackingTint:setAlpha(0)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BorderRight = LUI.UIImage.new(1, 1, -1, 0, 0, 1, 0, 0)
	BorderRight:setAlpha(0.15)
	self:addElement(BorderRight)
	self.BorderRight = BorderRight
	local BorderBottom = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	BorderBottom:setAlpha(0.15)
	self:addElement(BorderBottom)
	self.BorderBottom = BorderBottom
	local BorderLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 0, 0)
	BorderLeft:setAlpha(0.15)
	self:addElement(BorderLeft)
	self.BorderLeft = BorderLeft
	local BorderTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	BorderTop:setAlpha(0.15)
	self:addElement(BorderTop)
	self.BorderTop = BorderTop
	local SearchPlaceholderText = LUI.UIText.new(0, 0, 11, 250, 0.5, 0.5, -16.5, 16.5)
	SearchPlaceholderText:setAlpha(0)
	SearchPlaceholderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1236F2E52CE62AFE"))
	SearchPlaceholderText:setTTF("default")
	SearchPlaceholderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SearchPlaceholderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SearchPlaceholderText)
	self.SearchPlaceholderText = SearchPlaceholderText
	local CornerTopL = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	CornerTopL:setAlpha(0.85)
	self:addElement(CornerTopL)
	self.CornerTopL = CornerTopL
	local CornerTopR = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	CornerTopR:setAlpha(0.85)
	self:addElement(CornerTopR)
	self.CornerTopR = CornerTopR
	local CornerBottomR = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	CornerBottomR:setAlpha(0.85)
	self:addElement(CornerBottomR)
	self.CornerBottomR = CornerBottomR
	local CornerBottomL = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	CornerBottomL:setAlpha(0.85)
	self:addElement(CornerBottomL)
	self.CornerBottomL = CornerBottomL
	local TextBox = LUI.UIText.new(0, 0.95, 11, 11, 0.19, 0.82, 0, 0)
	TextBox:setText("")
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "social_screen_editbox_add_friend", "")
	CoD.PCUtility.SetupEditControlWithControllerModel(self, f1_arg1, f1_arg0, "social_screen_editbox_add_friend")
	return self
end
CoD.PC_SocialMenu_AddFriendTextBox.__resetProperties = function(f2_arg0)
	f2_arg0.BackingTint:completeAnimation()
	f2_arg0.BackingTint:setAlpha(0)
end
CoD.PC_SocialMenu_AddFriendTextBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.BackingTint:beginAnimation(250)
				f4_arg0.BackingTint:setAlpha(0.5)
				f4_arg0.BackingTint:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.BackingTint:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.BackingTint:completeAnimation()
			f4_arg0.BackingTint:setAlpha(0)
			f4_local0(f4_arg0.BackingTint)
		end,
		InputFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.BackingTint:completeAnimation()
			f6_arg0.BackingTint:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.BackingTint)
		end,
	},
}
