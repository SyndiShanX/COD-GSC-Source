require("x64:c98cfa25d10d264")
CoD.PC_IGR_AAR_BonusXP = InheritFrom(LUI.UIElement)
CoD.PC_IGR_AAR_BonusXP.__defaultWidth = 350
CoD.PC_IGR_AAR_BonusXP.__defaultHeight = 189
CoD.PC_IGR_AAR_BonusXP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_IGR_AAR_BonusXP)
	self.id = "PC_IGR_AAR_BonusXP"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IGRPerkElement2 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0.08, 0.08, 63, 127)
	IGRPerkElement2.PerkLogo:setImage(RegisterImage(@"hash_58FBBCE5058992F3"))
	IGRPerkElement2.PerkText:setText(CoD.PCKoreaUtility.InjectBonusGunXP(@"hash_6936FCC81C9EE8D0"))
	self:addElement(IGRPerkElement2)
	self.IGRPerkElement2 = IGRPerkElement2
	local IGRPerkElement3 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0.08, 0.08, 115, 179)
	IGRPerkElement3.PerkLogo:setImage(RegisterImage(@"hash_6C1460CF69AB482B"))
	IGRPerkElement3.PerkText:setText(CoD.PCKoreaUtility.InjectBonusCredits(@"hash_1327C56902BCB8A5"))
	self:addElement(IGRPerkElement3)
	self.IGRPerkElement3 = IGRPerkElement3
	local IGRPerkElement1 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 24, 88)
	IGRPerkElement1.PerkLogo:setImage(RegisterImage(@"hash_5CFD527F0E4A01CE"))
	IGRPerkElement1.PerkText:setText(CoD.PCKoreaUtility.InjectBonusXP(@"hash_1D38DFFC56710A2B"))
	self:addElement(IGRPerkElement1)
	self.IGRPerkElement1 = IGRPerkElement1
	local Title = LUI.UIText.new(0.03, 0.03, -3, 332, 0, 0, 0, 25)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_44C5A165B66FA0C3"))
	Title:setTTF("ttmussels_demibold")
	Title:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Title:setShaderVector(0, 1, 0, 0, 0)
	Title:setShaderVector(1, 1, 0, 0, 0)
	Title:setShaderVector(2, 1, 0.78, 0, 0.3)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(Title)
	self.Title = Title
	local SeparationLine = LUI.UIImage.new(0.02, 0.02, 0, 327, 0, 0, 28, 29)
	SeparationLine:setRGB(0.51, 0.51, 0.51)
	self:addElement(SeparationLine)
	self.SeparationLine = SeparationLine
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCKoreaUtility.IsInIGR()
			end,
		},
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_IGR_AAR_BonusXP.__resetProperties = function(f5_arg0)
	f5_arg0.SeparationLine:completeAnimation()
	f5_arg0.Title:completeAnimation()
	f5_arg0.IGRPerkElement1:completeAnimation()
	f5_arg0.IGRPerkElement2:completeAnimation()
	f5_arg0.IGRPerkElement3:completeAnimation()
	f5_arg0.SeparationLine:setAlpha(1)
	f5_arg0.Title:setAlpha(1)
	f5_arg0.IGRPerkElement1:setAlpha(1)
	f5_arg0.IGRPerkElement2:setAlpha(1)
	f5_arg0.IGRPerkElement3:setAlpha(1)
end
CoD.PC_IGR_AAR_BonusXP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(5)
			f7_arg0.IGRPerkElement2:completeAnimation()
			f7_arg0.IGRPerkElement2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.IGRPerkElement2)
			f7_arg0.IGRPerkElement3:completeAnimation()
			f7_arg0.IGRPerkElement3:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.IGRPerkElement3)
			f7_arg0.IGRPerkElement1:completeAnimation()
			f7_arg0.IGRPerkElement1:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.IGRPerkElement1)
			f7_arg0.Title:completeAnimation()
			f7_arg0.Title:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Title)
			f7_arg0.SeparationLine:completeAnimation()
			f7_arg0.SeparationLine:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SeparationLine)
		end,
	},
	Warzone = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.IGRPerkElement2:completeAnimation()
			f8_arg0.IGRPerkElement2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.IGRPerkElement2)
			f8_arg0.IGRPerkElement3:completeAnimation()
			f8_arg0.IGRPerkElement3:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.IGRPerkElement3)
			f8_arg0.IGRPerkElement1:completeAnimation()
			f8_arg0.IGRPerkElement1:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.IGRPerkElement1)
			f8_arg0.Title:completeAnimation()
			f8_arg0.Title:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Title)
			f8_arg0.SeparationLine:completeAnimation()
			f8_arg0.SeparationLine:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SeparationLine)
		end,
	},
}
CoD.PC_IGR_AAR_BonusXP.__onClose = function(f9_arg0)
	f9_arg0.IGRPerkElement2:close()
	f9_arg0.IGRPerkElement3:close()
	f9_arg0.IGRPerkElement1:close()
end
