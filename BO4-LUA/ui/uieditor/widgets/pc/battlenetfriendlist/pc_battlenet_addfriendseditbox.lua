CoD.PC_Battlenet_AddFriendsEditBox = InheritFrom(LUI.UIElement)
CoD.PC_Battlenet_AddFriendsEditBox.__defaultWidth = 388
CoD.PC_Battlenet_AddFriendsEditBox.__defaultHeight = 30
CoD.PC_Battlenet_AddFriendsEditBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Battlenet_AddFriendsEditBox)
	self.id = "PC_Battlenet_AddFriendsEditBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NameEntryBG = LUI.UIImage.new(0.01, 1.01, -4, -4, 0, 1, 0, 0)
	NameEntryBG:setRGB(0.06, 0.06, 0.06)
	self:addElement(NameEntryBG)
	self.NameEntryBG = NameEntryBG
	local NameEntryPlaceholderText = LUI.UIText.new(0.5, 0.5, -186, 186, 0.5, 0.5, -10.5, 10.5)
	NameEntryPlaceholderText:setRGB(0.41, 0.41, 0.41)
	NameEntryPlaceholderText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x329CEC2EABE8884))
	NameEntryPlaceholderText:setTTF("ttmussels_regular")
	NameEntryPlaceholderText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	NameEntryPlaceholderText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(NameEntryPlaceholderText)
	self.NameEntryPlaceholderText = NameEntryPlaceholderText
	local TextBox = LUI.UIText.new(0.5, 0.5, -186, 186, 0.5, 0.5, -10.5, 10.5)
	TextBox:setAlpha(0)
	TextBox:setText("")
	TextBox:setTTF("notosans_regular")
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local NameEntryBorder = LUI.UIImage.new(0.01, 1.01, -4, -4, 0, 1, 0, 0)
	NameEntryBorder:setRGB(0.57, 0.57, 0.57)
	NameEntryBorder:setAlpha(0.5)
	NameEntryBorder:setImage(RegisterImage("uie_highlight_border_line"))
	NameEntryBorder:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	NameEntryBorder:setShaderVector(0, 0, 0, 0, 0)
	NameEntryBorder:setupNineSliceShader(6, 6)
	self:addElement(NameEntryBorder)
	self.NameEntryBorder = NameEntryBorder
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum.LUIButton[@"lui_key_none"], "ui_confirm", function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		CoD.PCUtility.SocialAddFriend(self, f2_arg2, "EditBoxGlobal.BattlenetAddFriend")
		return true
	end, function(f3_arg0, f3_arg1, f3_arg2)
		CoD.Menu.SetButtonLabel(f3_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "EditBoxGlobal.BattlenetAddFriend", "")
	CoD.PCUtility.SetupSocialAddFriendEditControl(self, f1_arg1, f1_arg0, "EditBoxGlobal.BattlenetAddFriend")
	CoD.PCUtility.MakeEditBoxRealTime(self, "EditBoxGlobal.BattlenetAddFriend")
	CoD.PCUtility.SetEditBoxScrollingSteps(self, 5, 350, 60)
	CoD.BaseUtility.SetUseStencil(self)
	DisableModelStringReplacement(TextBox)
	return self
end
CoD.PC_Battlenet_AddFriendsEditBox.__resetProperties = function(f4_arg0)
	f4_arg0.TextBox:completeAnimation()
	f4_arg0.NameEntryPlaceholderText:completeAnimation()
	f4_arg0.NameEntryBorder:completeAnimation()
	f4_arg0.NameEntryBG:completeAnimation()
	f4_arg0.TextBox:setAlpha(0)
	f4_arg0.NameEntryPlaceholderText:setRGB(0.41, 0.41, 0.41)
	f4_arg0.NameEntryPlaceholderText:setAlpha(1)
	f4_arg0.NameEntryBorder:setRGB(0.57, 0.57, 0.57)
	f4_arg0.NameEntryBorder:setAlpha(0.5)
	f4_arg0.NameEntryBG:setRGB(0.06, 0.06, 0.06)
end
CoD.PC_Battlenet_AddFriendsEditBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		InputFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.NameEntryPlaceholderText:completeAnimation()
			f6_arg0.NameEntryPlaceholderText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NameEntryPlaceholderText)
			f6_arg0.TextBox:completeAnimation()
			f6_arg0.TextBox:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TextBox)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.NameEntryBG:beginAnimation(100)
				f7_arg0.NameEntryBG:setRGB(0.03, 0.03, 0.03)
				f7_arg0.NameEntryBG:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.NameEntryBG:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.NameEntryBG:completeAnimation()
			f7_arg0.NameEntryBG:setRGB(0.06, 0.06, 0.06)
			f7_local0(f7_arg0.NameEntryBG)
			local f7_local1 = function(f9_arg0)
				f7_arg0.NameEntryPlaceholderText:beginAnimation(100)
				f7_arg0.NameEntryPlaceholderText:setRGB(1, 1, 1)
				f7_arg0.NameEntryPlaceholderText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.NameEntryPlaceholderText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.NameEntryPlaceholderText:completeAnimation()
			f7_arg0.NameEntryPlaceholderText:setRGB(0.41, 0.41, 0.41)
			f7_local1(f7_arg0.NameEntryPlaceholderText)
			local f7_local2 = function(f10_arg0)
				f7_arg0.NameEntryBorder:beginAnimation(100)
				f7_arg0.NameEntryBorder:setAlpha(1)
				f7_arg0.NameEntryBorder:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.NameEntryBorder:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.NameEntryBorder:completeAnimation()
			f7_arg0.NameEntryBorder:setRGB(1, 1, 1)
			f7_arg0.NameEntryBorder:setAlpha(0.5)
			f7_local2(f7_arg0.NameEntryBorder)
		end,
	},
}
CoD.PC_Battlenet_AddFriendsEditBox.__onClose = function(f11_arg0)
	f11_arg0.TextBox:close()
end
