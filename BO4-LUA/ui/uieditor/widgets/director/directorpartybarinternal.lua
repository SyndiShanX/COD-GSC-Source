CoD.DirectorPartyBarInternal = InheritFrom(LUI.UIElement)
CoD.DirectorPartyBarInternal.__defaultWidth = 5
CoD.DirectorPartyBarInternal.__defaultHeight = 64
CoD.DirectorPartyBarInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPartyBarInternal)
	self.id = "DirectorPartyBarInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyBarGlow2 = LUI.UIImage.new(0.04, 0.96, 0, 0, 0, 1, 0, 0)
	PartyBarGlow2:setRGB(0, 0.08, 0.61)
	PartyBarGlow2:setImage(RegisterImage(0x51DBC58C5B3B71))
	self:addElement(PartyBarGlow2)
	self.PartyBarGlow2 = PartyBarGlow2
	local PartyBarGlow3 = LUI.UIImage.new(-0.6, 1.4, 0, 0, 0, 1, 0, 0)
	PartyBarGlow3:setRGB(0, 0.08, 0.61)
	PartyBarGlow3:setAlpha(0.5)
	PartyBarGlow3:setImage(RegisterImage(0x51DBC58C5B3B71))
	PartyBarGlow3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PartyBarGlow3)
	self.PartyBarGlow3 = PartyBarGlow3
	local PartyBar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PartyBar:setRGB(0.02, 0.29, 0.49)
	PartyBar:setImage(RegisterImage(0x51DBC58C5B3B71))
	PartyBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	PartyBar:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(PartyBar)
	self.PartyBar = PartyBar
	local PartyBarGlow = LUI.UIImage.new(-0.4, 1.4, 0, 0, 0, 1, 0, 0)
	PartyBarGlow:setRGB(0, 0.03, 0.2)
	PartyBarGlow:setImage(RegisterImage(0x51DBC58C5B3B71))
	PartyBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PartyBarGlow)
	self.PartyBarGlow = PartyBarGlow
	local PartyBarhotspot = LUI.UIImage.new(-0.24, 0.64, 1, 1, 0, 1, 0, 0)
	PartyBarhotspot:setRGB(0, 0.56, 1)
	PartyBarhotspot:setAlpha(0.5)
	PartyBarhotspot:setImage(RegisterImage(0x489CCF0AA805F92))
	PartyBarhotspot:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PartyBarhotspot)
	self.PartyBarhotspot = PartyBarhotspot
	self:mergeStateConditions({
		{
			stateName = "NoParty",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isInAParty") then
					f2_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isPartyMember")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "PartyTopOrMiddle",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsPartyBarTopOrMiddle(self)
			end,
		},
		{
			stateName = "PartyLast",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "isInAParty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInAParty",
		})
	end)
	self:linkToElementModel(self, "isPartyMember", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPartyMember",
		})
	end)
	self:linkToElementModel(self, "isPartyMemberTopOrMiddle", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPartyMemberTopOrMiddle",
		})
	end)
	self:linkToElementModel(self, "isOtherMemberTopOrMiddle", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOtherMemberTopOrMiddle",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPartyBarInternal.__resetProperties = function(f9_arg0)
	f9_arg0.PartyBarGlow2:completeAnimation()
	f9_arg0.PartyBarGlow3:completeAnimation()
	f9_arg0.PartyBar:completeAnimation()
	f9_arg0.PartyBarhotspot:completeAnimation()
	f9_arg0.PartyBarGlow:completeAnimation()
	f9_arg0.PartyBarGlow2:setTopBottom(0, 1, 0, 0)
	f9_arg0.PartyBarGlow2:setAlpha(1)
	f9_arg0.PartyBarGlow3:setTopBottom(0, 1, 0, 0)
	f9_arg0.PartyBarGlow3:setAlpha(0.5)
	f9_arg0.PartyBar:setTopBottom(0, 1, 0, 0)
	f9_arg0.PartyBar:setAlpha(1)
	f9_arg0.PartyBarhotspot:setTopBottom(0, 1, 0, 0)
	f9_arg0.PartyBarhotspot:setAlpha(0.5)
	f9_arg0.PartyBarGlow:setTopBottom(0, 1, 0, 0)
	f9_arg0.PartyBarGlow:setAlpha(1)
end
CoD.DirectorPartyBarInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.PartyBarGlow2:completeAnimation()
			f10_arg0.PartyBarGlow2:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PartyBarGlow2)
			f10_arg0.PartyBarGlow3:completeAnimation()
			f10_arg0.PartyBarGlow3:setAlpha(0.5)
			f10_arg0.clipFinished(f10_arg0.PartyBarGlow3)
			f10_arg0.PartyBar:completeAnimation()
			f10_arg0.PartyBar:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PartyBar)
		end,
	},
	NoParty = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.PartyBarGlow2:completeAnimation()
			f11_arg0.PartyBarGlow2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyBarGlow2)
			f11_arg0.PartyBarGlow3:completeAnimation()
			f11_arg0.PartyBarGlow3:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyBarGlow3)
			f11_arg0.PartyBar:completeAnimation()
			f11_arg0.PartyBar:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyBar)
			f11_arg0.PartyBarGlow:completeAnimation()
			f11_arg0.PartyBarGlow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyBarGlow)
			f11_arg0.PartyBarhotspot:completeAnimation()
			f11_arg0.PartyBarhotspot:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyBarhotspot)
		end,
	},
	PartyTopOrMiddle = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.PartyBarGlow2:completeAnimation()
			f12_arg0.PartyBarGlow2:setTopBottom(0, 1.16, 0, 0)
			f12_arg0.clipFinished(f12_arg0.PartyBarGlow2)
			f12_arg0.PartyBarGlow3:completeAnimation()
			f12_arg0.PartyBarGlow3:setTopBottom(0, 1.16, 0, 0)
			f12_arg0.clipFinished(f12_arg0.PartyBarGlow3)
			f12_arg0.PartyBar:completeAnimation()
			f12_arg0.PartyBar:setTopBottom(0, 0, 0, 74)
			f12_arg0.clipFinished(f12_arg0.PartyBar)
			f12_arg0.PartyBarGlow:completeAnimation()
			f12_arg0.PartyBarGlow:setTopBottom(0, 1.16, 0, 0)
			f12_arg0.clipFinished(f12_arg0.PartyBarGlow)
			f12_arg0.PartyBarhotspot:completeAnimation()
			f12_arg0.PartyBarhotspot:setTopBottom(0, 1.16, 0, 0)
			f12_arg0.clipFinished(f12_arg0.PartyBarhotspot)
		end,
	},
	PartyLast = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
