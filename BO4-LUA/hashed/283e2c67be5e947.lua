CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette = InheritFrom(LUI.UIElement)
CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.__defaultWidth = 390
CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.__defaultHeight = 155
CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette)
	self.id = "StartMenu_Inventory_CurrentWeaponPC_Vignette"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CurrentWeaponImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -195, 195, 1, 1, -113, -13)
	self:addElement(CurrentWeaponImage)
	self.CurrentWeaponImage = CurrentWeaponImage
	local CurrentWeaponName = LUI.UIText.new(0.5, 0.5, -200, 200, 0, 0, 0, 24)
	CurrentWeaponName:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	CurrentWeaponName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	CurrentWeaponName:setTTF("ttmussels_demibold")
	CurrentWeaponName:setLetterSpacing(4)
	CurrentWeaponName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CurrentWeaponName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(CurrentWeaponName)
	self.CurrentWeaponName = CurrentWeaponName
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.__resetProperties = function(f2_arg0)
	f2_arg0.CurrentWeaponImage:completeAnimation()
	f2_arg0.CurrentWeaponName:completeAnimation()
	f2_arg0.CurrentWeaponImage:setScale(1, 1)
	f2_arg0.CurrentWeaponName:setTopBottom(0, 0, 0, 24)
	f2_arg0.CurrentWeaponName:setScale(1, 1)
end
CoD.StartMenu_Inventory_CurrentWeaponPC_Vignette.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.CurrentWeaponImage:completeAnimation()
			f4_arg0.CurrentWeaponImage:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.CurrentWeaponImage)
			f4_arg0.CurrentWeaponName:completeAnimation()
			f4_arg0.CurrentWeaponName:setTopBottom(0, 0, -3, 21)
			f4_arg0.CurrentWeaponName:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.CurrentWeaponName)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.CurrentWeaponImage:beginAnimation(200)
				f5_arg0.CurrentWeaponImage:setScale(1.05, 1.05)
				f5_arg0.CurrentWeaponImage:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CurrentWeaponImage:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.CurrentWeaponImage:completeAnimation()
			f5_arg0.CurrentWeaponImage:setScale(1, 1)
			f5_local0(f5_arg0.CurrentWeaponImage)
			local f5_local1 = function(f7_arg0)
				f5_arg0.CurrentWeaponName:beginAnimation(200)
				f5_arg0.CurrentWeaponName:setTopBottom(0, 0, -3, 21)
				f5_arg0.CurrentWeaponName:setScale(1.05, 1.05)
				f5_arg0.CurrentWeaponName:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CurrentWeaponName:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.CurrentWeaponName:completeAnimation()
			f5_arg0.CurrentWeaponName:setTopBottom(0, 0, 0, 24)
			f5_arg0.CurrentWeaponName:setScale(1, 1)
			f5_local1(f5_arg0.CurrentWeaponName)
		end,
		LoseFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CurrentWeaponImage:beginAnimation(200)
				f8_arg0.CurrentWeaponImage:setScale(1, 1)
				f8_arg0.CurrentWeaponImage:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CurrentWeaponImage:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CurrentWeaponImage:completeAnimation()
			f8_arg0.CurrentWeaponImage:setScale(1.05, 1.05)
			f8_local0(f8_arg0.CurrentWeaponImage)
			local f8_local1 = function(f10_arg0)
				f8_arg0.CurrentWeaponName:beginAnimation(200)
				f8_arg0.CurrentWeaponName:setTopBottom(0, 0, 0, 24)
				f8_arg0.CurrentWeaponName:setScale(1, 1)
				f8_arg0.CurrentWeaponName:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CurrentWeaponName:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CurrentWeaponName:completeAnimation()
			f8_arg0.CurrentWeaponName:setTopBottom(0, 0, -3, 21)
			f8_arg0.CurrentWeaponName:setScale(1.05, 1.05)
			f8_local1(f8_arg0.CurrentWeaponName)
		end,
	},
}
