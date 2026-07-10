CoD.BountyHunterPlayerMoney = InheritFrom(LUI.UIElement)
CoD.BountyHunterPlayerMoney.__defaultWidth = 205
CoD.BountyHunterPlayerMoney.__defaultHeight = 40
CoD.BountyHunterPlayerMoney.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "luielement.BountyHunterLoadout.money", 0)
	self:setClass(CoD.BountyHunterPlayerMoney)
	self.id = "BountyHunterPlayerMoney"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0.5, 0.5, -98, 98, 0.5, 0.5, -16, 17)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local PanelDark = LUI.UIImage.new(0.5, 0.5, -98, 98, 0.5, 0.5, -16, 17)
	PanelDark:setRGB(0.09, 0.09, 0.09)
	PanelDark:setAlpha(0.94)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local TiledShaderImage = LUI.UIImage.new(0.5, 0.5, -110.5, 98.5, 0.5, 0.5, -27.5, 17.5)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setAlpha(0.2)
	TiledShaderImage:setImage(RegisterImage(@"hash_5322AF9BC49B4F3E"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(220, 60)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local StretchableFrameThin = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StretchableFrameThin:setImage(RegisterImage(@"uie_ui_hud_core_frame_top_thin_stretchable"))
	StretchableFrameThin:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	StretchableFrameThin:setShaderVector(0, 0, 0, 0, 0)
	StretchableFrameThin:setupNineSliceShader(22, 22)
	self:addElement(StretchableFrameThin)
	self.StretchableFrameThin = StretchableFrameThin
	local Sign = LUI.UIText.new(0.5, 0.5, -41, -27, 0.5, 0.5, -11.5, 13.5)
	Sign:setRGB(0.12, 0.8, 0.14)
	Sign:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	Sign:setTTF("ttmussels_regular")
	Sign:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Sign:setShaderVector(0, 0.68, 0, 0, 0)
	Sign:setShaderVector(1, 0, 0, 0, 0)
	Sign:setShaderVector(2, 0.34, 0.74, 0.46, 0.4)
	Sign:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Sign:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Sign)
	self.Sign = Sign
	local Money = LUI.UIText.new(0.5, 0.5, -24, 84, 0.5, 0.5, -11.5, 13.5)
	Money:setRGB(0.12, 0.8, 0.14)
	Money:setTTF("ttmussels_regular")
	Money:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Money:setShaderVector(0, 0.68, 0, 0, 0)
	Money:setShaderVector(1, 0, 0, 0, 0)
	Money:setShaderVector(2, 0.34, 0.74, 0.46, 0.4)
	Money:setLetterSpacing(2)
	Money:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Money:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Money:linkToElementModel(self, "luielement.BountyHunterLoadout.money", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Money:setText(f2_local0)
		end
	end)
	self:addElement(Money)
	self.Money = Money
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPlayerMoney.__resetProperties = function(f4_arg0)
	f4_arg0.Sign:completeAnimation()
	f4_arg0.Money:completeAnimation()
	f4_arg0.StretchableFrameThin:completeAnimation()
	f4_arg0.TiledShaderImage:completeAnimation()
	f4_arg0.PanelDark:completeAnimation()
	f4_arg0.Blur:completeAnimation()
	f4_arg0.Sign:setAlpha(1)
	f4_arg0.Money:setAlpha(1)
	f4_arg0.StretchableFrameThin:setAlpha(1)
	f4_arg0.TiledShaderImage:setAlpha(0.2)
	f4_arg0.PanelDark:setAlpha(0.94)
	f4_arg0.Blur:setAlpha(1)
end
CoD.BountyHunterPlayerMoney.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
			f5_arg0.Blur:completeAnimation()
			f5_arg0.Blur:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Blur)
			f5_arg0.PanelDark:completeAnimation()
			f5_arg0.PanelDark:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PanelDark)
			f5_arg0.TiledShaderImage:completeAnimation()
			f5_arg0.TiledShaderImage:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TiledShaderImage)
			f5_arg0.StretchableFrameThin:completeAnimation()
			f5_arg0.StretchableFrameThin:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.StretchableFrameThin)
			f5_arg0.Sign:completeAnimation()
			f5_arg0.Sign:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Sign)
			f5_arg0.Money:completeAnimation()
			f5_arg0.Money:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Money)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BountyHunterPlayerMoney.__onClose = function(f7_arg0)
	f7_arg0.Money:close()
end
