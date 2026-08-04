CoD.PC_SocialMenu_SortButton = InheritFrom(LUI.UIElement)
CoD.PC_SocialMenu_SortButton.__defaultWidth = 213
CoD.PC_SocialMenu_SortButton.__defaultHeight = 26
CoD.PC_SocialMenu_SortButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SocialMenu_SortButton)
	self.id = "PC_SocialMenu_SortButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SortButton = LUI.UIImage.new(0, 0, 0, 213, 0, 0, 0, 26)
	SortButton:setRGB(0.13, 0.13, 0.13)
	SortButton:setAlpha(0.7)
	self:addElement(SortButton)
	self.SortButton = SortButton
	local TextureButtonSort = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextureButtonSort:setAlpha(0.25)
	TextureButtonSort:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TextureButtonSort:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TextureButtonSort:setShaderVector(0, 0, 0, 0, 0)
	TextureButtonSort:setupNineSliceShader(100, 50)
	self:addElement(TextureButtonSort)
	self.TextureButtonSort = TextureButtonSort
	local TextureButtonSortAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextureButtonSortAdd:setAlpha(0)
	TextureButtonSortAdd:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TextureButtonSortAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TextureButtonSortAdd:setShaderVector(0, 0, 0, 0, 0)
	TextureButtonSortAdd:setupNineSliceShader(100, 50)
	self:addElement(TextureButtonSortAdd)
	self.TextureButtonSortAdd = TextureButtonSortAdd
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setAlpha(0.7)
	Border:setImage(RegisterImage("uie_ui_menu_store_common_frame"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(5, 5)
	self:addElement(Border)
	self.Border = Border
	local SortText = LUI.UIText.new(0, 0, 3, 211, 0.5, 0.5, -9, 9)
	SortText:setRGB(0.76, 0.76, 0.76)
	SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_alphabetical"))
	SortText:setTTF("ttmussels_regular")
	SortText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	SortText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(SortText)
	self.SortText = SortText
	local Arrow = LUI.UIImage.new(0, 0, 190, 210, 0.5, 0.5, -10, 10)
	Arrow:setImage(RegisterImage("keyarrowdown"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		if IsInDefaultState(self) then
			CoD.PCBattlenetUtility.SetSortFunction(f2_arg2, CoD.PCBattlenetUtility.SortEnum.ALPHABETICALLY_DESC)
			SetState(self, "AlphabeticalReversed", f2_arg2)
			return true
		elseif IsSelfInState(self, "AlphabeticalReversed") then
			CoD.PCBattlenetUtility.SetSortFunction(f2_arg2, CoD.PCBattlenetUtility.SortEnum.STARTUPTIME_ASC)
			SetState(self, "Recent", f2_arg2)
			return true
		elseif IsSelfInState(self, "Recent") then
			CoD.PCBattlenetUtility.SetSortFunction(f2_arg2, CoD.PCBattlenetUtility.SortEnum.STARTUPTIME_DESC)
			SetState(self, "RecentReversed", f2_arg2)
			return true
		elseif IsSelfInState(self, "RecentReversed") then
			CoD.PCBattlenetUtility.SetSortFunction(f2_arg2, CoD.PCBattlenetUtility.SortEnum.ALPHABETICALLY_ASC)
			SetState(self, "DefaultState", f2_arg2)
			return true
		else
		end
	end, function(f3_arg0, f3_arg1, f3_arg2)
		if IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(f3_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		elseif IsSelfInState(self, "AlphabeticalReversed") then
			CoD.Menu.SetButtonLabel(f3_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		elseif IsSelfInState(self, "Recent") then
			CoD.Menu.SetButtonLabel(f3_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		elseif IsSelfInState(self, "RecentReversed") then
			CoD.Menu.SetButtonLabel(f3_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.PCBattlenetUtility.SetSortFunction(f1_arg1, CoD.PCBattlenetUtility.SortEnum.ALPHABETICALLY_ASC)
	return self
end
CoD.PC_SocialMenu_SortButton.__resetProperties = function(f4_arg0)
	f4_arg0.TextureButtonSortAdd:completeAnimation()
	f4_arg0.SortText:completeAnimation()
	f4_arg0.Arrow:completeAnimation()
	f4_arg0.TextureButtonSortAdd:setAlpha(0)
	f4_arg0.SortText:setRGB(0.76, 0.76, 0.76)
	f4_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_alphabetical"))
	f4_arg0.Arrow:setTopBottom(0.5, 0.5, -10, 10)
end
CoD.PC_SocialMenu_SortButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.TextureButtonSortAdd:completeAnimation()
			f6_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.TextureButtonSortAdd)
			f6_arg0.SortText:completeAnimation()
			f6_arg0.SortText:setRGB(1, 1, 1)
			f6_arg0.clipFinished(f6_arg0.SortText)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.TextureButtonSortAdd:beginAnimation(200)
				f7_arg0.TextureButtonSortAdd:setAlpha(0)
				f7_arg0.TextureButtonSortAdd:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TextureButtonSortAdd:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.TextureButtonSortAdd:completeAnimation()
			f7_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f7_local0(f7_arg0.TextureButtonSortAdd)
			local f7_local1 = function(f9_arg0)
				f7_arg0.SortText:beginAnimation(200)
				f7_arg0.SortText:setRGB(0.76, 0.76, 0.76)
				f7_arg0.SortText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SortText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SortText:completeAnimation()
			f7_arg0.SortText:setRGB(1, 1, 1)
			f7_local1(f7_arg0.SortText)
		end,
	},
	AlphabeticalReversed = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Arrow:completeAnimation()
			f10_arg0.Arrow:setTopBottom(0.5, 0.5, 10, -10)
			f10_arg0.clipFinished(f10_arg0.Arrow)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.TextureButtonSortAdd:completeAnimation()
			f11_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.TextureButtonSortAdd)
			f11_arg0.SortText:completeAnimation()
			f11_arg0.SortText:setRGB(1, 1, 1)
			f11_arg0.clipFinished(f11_arg0.SortText)
			f11_arg0.Arrow:completeAnimation()
			f11_arg0.Arrow:setTopBottom(0.5, 0.5, 10, -10)
			f11_arg0.clipFinished(f11_arg0.Arrow)
		end,
		LoseFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.TextureButtonSortAdd:beginAnimation(200)
				f12_arg0.TextureButtonSortAdd:setAlpha(0)
				f12_arg0.TextureButtonSortAdd:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.TextureButtonSortAdd:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.TextureButtonSortAdd:completeAnimation()
			f12_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f12_local0(f12_arg0.TextureButtonSortAdd)
			local f12_local1 = function(f14_arg0)
				f12_arg0.SortText:beginAnimation(200)
				f12_arg0.SortText:setRGB(0.76, 0.76, 0.76)
				f12_arg0.SortText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SortText:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SortText:completeAnimation()
			f12_arg0.SortText:setRGB(1, 1, 1)
			f12_local1(f12_arg0.SortText)
			f12_arg0.Arrow:completeAnimation()
			f12_arg0.Arrow:setTopBottom(0.5, 0.5, 10, -10)
			f12_arg0.clipFinished(f12_arg0.Arrow)
		end,
	},
	Recent = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.SortText:completeAnimation()
			f15_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_recent"))
			f15_arg0.clipFinished(f15_arg0.SortText)
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.TextureButtonSortAdd:completeAnimation()
			f16_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f16_arg0.clipFinished(f16_arg0.TextureButtonSortAdd)
			f16_arg0.SortText:completeAnimation()
			f16_arg0.SortText:setRGB(1, 1, 1)
			f16_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_recent"))
			f16_arg0.clipFinished(f16_arg0.SortText)
		end,
		LoseFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.TextureButtonSortAdd:beginAnimation(200)
				f17_arg0.TextureButtonSortAdd:setAlpha(0)
				f17_arg0.TextureButtonSortAdd:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TextureButtonSortAdd:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.TextureButtonSortAdd:completeAnimation()
			f17_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f17_local0(f17_arg0.TextureButtonSortAdd)
			local f17_local1 = function(f19_arg0)
				f17_arg0.SortText:beginAnimation(200)
				f17_arg0.SortText:setRGB(0.76, 0.76, 0.76)
				f17_arg0.SortText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SortText:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SortText:completeAnimation()
			f17_arg0.SortText:setRGB(1, 1, 1)
			f17_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_recent"))
			f17_local1(f17_arg0.SortText)
		end,
	},
	RecentReversed = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.SortText:completeAnimation()
			f20_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_recent"))
			f20_arg0.clipFinished(f20_arg0.SortText)
			f20_arg0.Arrow:completeAnimation()
			f20_arg0.Arrow:setTopBottom(0.5, 0.5, 10, -10)
			f20_arg0.clipFinished(f20_arg0.Arrow)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.TextureButtonSortAdd:completeAnimation()
			f21_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f21_arg0.clipFinished(f21_arg0.TextureButtonSortAdd)
			f21_arg0.SortText:completeAnimation()
			f21_arg0.SortText:setRGB(1, 1, 1)
			f21_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_recent"))
			f21_arg0.clipFinished(f21_arg0.SortText)
			f21_arg0.Arrow:completeAnimation()
			f21_arg0.Arrow:setTopBottom(0.5, 0.5, 10, -10)
			f21_arg0.clipFinished(f21_arg0.Arrow)
		end,
		LoseFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.TextureButtonSortAdd:beginAnimation(200)
				f22_arg0.TextureButtonSortAdd:setAlpha(0)
				f22_arg0.TextureButtonSortAdd:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.TextureButtonSortAdd:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.TextureButtonSortAdd:completeAnimation()
			f22_arg0.TextureButtonSortAdd:setAlpha(0.5)
			f22_local0(f22_arg0.TextureButtonSortAdd)
			local f22_local1 = function(f24_arg0)
				f22_arg0.SortText:beginAnimation(200)
				f22_arg0.SortText:setRGB(0.76, 0.76, 0.76)
				f22_arg0.SortText:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.SortText:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.SortText:completeAnimation()
			f22_arg0.SortText:setRGB(1, 1, 1)
			f22_arg0.SortText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/sorting_recent"))
			f22_local1(f22_arg0.SortText)
			f22_arg0.Arrow:completeAnimation()
			f22_arg0.Arrow:setTopBottom(0.5, 0.5, 10, -10)
			f22_arg0.clipFinished(f22_arg0.Arrow)
		end,
	},
}
