CoD.IGRPerkElement = InheritFrom(LUI.UIElement)
CoD.IGRPerkElement.__defaultWidth = 350
CoD.IGRPerkElement.__defaultHeight = 64
CoD.IGRPerkElement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IGRPerkElement)
	self.id = "IGRPerkElement"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerkLogo = LUI.UIFixedAspectRatioImage.new(0.04, 0.04, 0, 48, 0.5, 0.5, -24, 24)
	PerkLogo:setImage(RegisterImage(0x6DC0330DA89BE10))
	PerkLogo:setMaterial(LUI.UIImage.GetCachedMaterial(0x98A2728B4675FB5))
	PerkLogo:setShaderVector(0, 0, 0, 0, 0)
	PerkLogo:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(PerkLogo)
	self.PerkLogo = PerkLogo
	local PerkText = LUI.UIText.new(1, 1, -279, -7, 0.5, 0.5, -9, 4)
	PerkText:setText(Engine[0xF9F1239CFD921FE](0xA2F4D3BF4BFC6E7))
	PerkText:setTTF("ttmussels_demibold")
	PerkText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	PerkText:setShaderVector(0, 1, 0, 0, 0)
	PerkText:setShaderVector(1, 1, 0, 0, 0)
	PerkText:setShaderVector(2, 1, 0.78, 0, 0.3)
	PerkText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PerkText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(PerkText)
	self.PerkText = PerkText
	self:mergeStateConditions({
		{
			stateName = "IsKoreanOrChinese",
			condition = function(menu, element, event)
				return IsCurrentLanguageKoreanOrTraditionalChinese()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IGRPerkElement.__resetProperties = function(f3_arg0)
	f3_arg0.PerkText:completeAnimation()
	f3_arg0.PerkLogo:completeAnimation()
	f3_arg0.PerkText:setTopBottom(0.5, 0.5, -9, 4)
	f3_arg0.PerkLogo:setShaderVector(0, 0, 0, 0, 0)
	f3_arg0.PerkLogo:setShaderVector(1, -46.8, 0, 0, 0)
end
CoD.IGRPerkElement.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f5_arg0:beginAnimation(460)
				f5_arg0:setShaderVector(0, 1, 0, 0, 0)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.PerkLogo:beginAnimation(3000)
			f4_arg0.PerkLogo:setShaderVector(0, 0, 0, 0, 0)
			f4_arg0.PerkLogo:setShaderVector(1, -46.8, 0, 0, 0)
			f4_arg0.PerkLogo:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.PerkLogo:registerEventHandler("transition_complete_keyframe", f4_local0)
			f4_arg0.PerkText:completeAnimation()
			f4_arg0.PerkText:setTopBottom(0.5, 0.5, -10, 5)
			f4_arg0.clipFinished(f4_arg0.PerkText)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	IsKoreanOrChinese = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f7_arg0:beginAnimation(460)
				f7_arg0:setShaderVector(0, 1, 0, 0, 0)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.PerkLogo:beginAnimation(3000)
			f6_arg0.PerkLogo:setShaderVector(0, 0, 0, 0, 0)
			f6_arg0.PerkLogo:setShaderVector(1, -46.8, 0, 0, 0)
			f6_arg0.PerkLogo:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.PerkLogo:registerEventHandler("transition_complete_keyframe", f6_local0)
			f6_arg0.PerkText:completeAnimation()
			f6_arg0.PerkText:setTopBottom(0.5, 0.5, -9, 4)
			f6_arg0.clipFinished(f6_arg0.PerkText)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
}
