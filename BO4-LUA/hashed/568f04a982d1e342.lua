CoD.AARTierRewardLootCaseMeter = InheritFrom(LUI.UIElement)
CoD.AARTierRewardLootCaseMeter.__defaultWidth = 150
CoD.AARTierRewardLootCaseMeter.__defaultHeight = 150
CoD.AARTierRewardLootCaseMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardLootCaseMeter)
	self.id = "AARTierRewardLootCaseMeter"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundRing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundRing:setRGB(0.36, 0.36, 0.36)
	BackgroundRing:setAlpha(0.35)
	BackgroundRing:setImage(RegisterImage(@"uie_t7_menu_aar_whiteringback"))
	self:addElement(BackgroundRing)
	self.BackgroundRing = BackgroundRing
	local CurrentProgressRing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CurrentProgressRing:setRGB(0.95, 0.91, 0.11)
	CurrentProgressRing:setImage(RegisterImage(@"uie_t7_menu_aar_whiteringthin"))
	CurrentProgressRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	CurrentProgressRing:setShaderVector(0, 0.66, 0, 0, 0)
	CurrentProgressRing:setShaderVector(1, 0.5, 0, 0, 0)
	CurrentProgressRing:setShaderVector(2, 0.5, 0, 0, 0)
	CurrentProgressRing:setShaderVector(3, 0, 0, 0, 0)
	CurrentProgressRing:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(CurrentProgressRing)
	self.CurrentProgressRing = CurrentProgressRing
	local PreviousProgressRing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PreviousProgressRing:setRGB(0.38, 0.36, 0.02)
	PreviousProgressRing:setImage(RegisterImage(@"uie_t7_menu_aar_whiteringthin"))
	PreviousProgressRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	PreviousProgressRing:setShaderVector(0, 0.5, 0, 0, 0)
	PreviousProgressRing:setShaderVector(1, 0.5, 0, 0, 0)
	PreviousProgressRing:setShaderVector(2, 0.5, 0, 0, 0)
	PreviousProgressRing:setShaderVector(3, 0, 0, 0, 0)
	PreviousProgressRing:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(PreviousProgressRing)
	self.PreviousProgressRing = PreviousProgressRing
	local CaseIcon = LUI.UIImage.new(0.5, 0.5, -75, 75, 0.5, 0.5, -75, 75)
	CaseIcon:setImage(RegisterImage(@"uie_ui_icon_blackmarket_reserve_count_neutral"))
	self:addElement(CaseIcon)
	self.CaseIcon = CaseIcon
	local CaseCount = LUI.UIText.new(0.5, 0.5, -48.5, 48.5, 0.5, 0.5, -31.5, 25.5)
	CaseCount:setRGB(0.91, 0.89, 0.89)
	CaseCount:setText(888)
	CaseCount:setTTF("ttmussels_demibold")
	CaseCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	CaseCount:setShaderVector(0, 0.1, 0, 0, 0)
	CaseCount:setShaderVector(1, 0, 0, 0, 0)
	CaseCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CaseCount:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(CaseCount)
	self.CaseCount = CaseCount
	local Flash = LUI.UIImage.new(0.5, 0.5, -125, 125, 0.5, 0.5, -125, 125)
	Flash:setRGB(1, 0.98, 0.71)
	Flash:setAlpha(0)
	Flash:setImage(RegisterImage(@"uie_ui_hud_notifications_glow"))
	Flash:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Flash)
	self.Flash = Flash
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.AARUtility.ShouldHideAARLootCaseMeter(f1_arg1)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardLootCaseMeter.__resetProperties = function(f3_arg0)
	f3_arg0.Flash:completeAnimation()
	f3_arg0.CaseCount:completeAnimation()
	f3_arg0.CaseIcon:completeAnimation()
	f3_arg0.PreviousProgressRing:completeAnimation()
	f3_arg0.CurrentProgressRing:completeAnimation()
	f3_arg0.BackgroundRing:completeAnimation()
	f3_arg0.Flash:setAlpha(0)
	f3_arg0.Flash:setScale(1, 1)
	f3_arg0.CaseCount:setAlpha(1)
	f3_arg0.CaseIcon:setAlpha(1)
	f3_arg0.PreviousProgressRing:setAlpha(1)
	f3_arg0.CurrentProgressRing:setAlpha(1)
	f3_arg0.BackgroundRing:setAlpha(0.35)
end
CoD.AARTierRewardLootCaseMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		GetCase = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(329)
					f7_arg0:setAlpha(0)
					f7_arg0:setScale(6, 6)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.Flash:beginAnimation(170)
				f5_arg0.Flash:setAlpha(1)
				f5_arg0.Flash:setScale(2.7, 2.7)
				f5_arg0.Flash:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Flash:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Flash:completeAnimation()
			f5_arg0.Flash:setAlpha(0)
			f5_arg0.Flash:setScale(1, 1)
			f5_local0(f5_arg0.Flash)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.BackgroundRing:completeAnimation()
			f8_arg0.BackgroundRing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.BackgroundRing)
			f8_arg0.CurrentProgressRing:completeAnimation()
			f8_arg0.CurrentProgressRing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CurrentProgressRing)
			f8_arg0.PreviousProgressRing:completeAnimation()
			f8_arg0.PreviousProgressRing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PreviousProgressRing)
			f8_arg0.CaseIcon:completeAnimation()
			f8_arg0.CaseIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CaseIcon)
			f8_arg0.CaseCount:completeAnimation()
			f8_arg0.CaseCount:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CaseCount)
		end,
	},
}
