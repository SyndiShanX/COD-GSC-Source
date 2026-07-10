CoD.IdentityLootCaseCount = InheritFrom(LUI.UIElement)
CoD.IdentityLootCaseCount.__defaultWidth = 104
CoD.IdentityLootCaseCount.__defaultHeight = 38
CoD.IdentityLootCaseCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IdentityLootCaseCount)
	self.id = "IdentityLootCaseCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CaseIcon = LUI.UIImage.new(0, 0, 0, 52, 0.5, 0.5, -21, 31)
	CaseIcon:setImage(RegisterImage(0xD0C0C9F62783A5C))
	self:addElement(CaseIcon)
	self.CaseIcon = CaseIcon
	local CaseCount = LUI.UIText.new(0, 0, 52, 104, 0.5, 0.5, -11, 11)
	CaseCount:setText(SetValueIfNumberEqualTo(-1, "-", 0))
	CaseCount:setTTF("ttmussels_demibold")
	CaseCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CaseCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(CaseCount)
	self.CaseCount = CaseCount
	local Flash = LUI.UIImage.new(0.5, 0.5, -75, 75, 0.5, 0.5, -75, 75)
	Flash:setRGB(1, 0.98, 0.71)
	Flash:setAlpha(0)
	Flash:setImage(RegisterImage(0x4A1176ABBF1AB4C))
	Flash:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Flash)
	self.Flash = Flash
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_enable_blackjack_reserves") and IsPerControllerTablePropertyValue(f1_arg1, "inBlackMarket", true)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IdentityLootCaseCount.__resetProperties = function(f3_arg0)
	f3_arg0.CaseIcon:completeAnimation()
	f3_arg0.CaseCount:completeAnimation()
	f3_arg0.Flash:completeAnimation()
	f3_arg0.CaseIcon:setAlpha(1)
	f3_arg0.CaseCount:setAlpha(1)
	f3_arg0.Flash:setAlpha(0)
	f3_arg0.Flash:setScale(1, 1)
end
CoD.IdentityLootCaseCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.CaseIcon:completeAnimation()
			f4_arg0.CaseIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CaseIcon)
			f4_arg0.CaseCount:completeAnimation()
			f4_arg0.CaseCount:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CaseCount)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		GetCase = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(329)
					f8_arg0:setAlpha(0)
					f8_arg0:setScale(6, 6)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.Flash:beginAnimation(170)
				f6_arg0.Flash:setAlpha(1)
				f6_arg0.Flash:setScale(2.7, 2.7)
				f6_arg0.Flash:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Flash:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Flash:completeAnimation()
			f6_arg0.Flash:setAlpha(0)
			f6_arg0.Flash:setScale(1, 1)
			f6_local0(f6_arg0.Flash)
		end,
	},
}
