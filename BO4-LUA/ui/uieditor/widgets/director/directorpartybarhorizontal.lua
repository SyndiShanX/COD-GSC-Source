require("x64:ef2c4b77caab743")
CoD.DirectorPartyBarHorizontal = InheritFrom(LUI.UIElement)
CoD.DirectorPartyBarHorizontal.__defaultWidth = 5
CoD.DirectorPartyBarHorizontal.__defaultHeight = 64
CoD.DirectorPartyBarHorizontal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPartyBarHorizontal)
	self.id = "DirectorPartyBarHorizontal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyBar = CoD.DirectorPartyBarInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	PartyBar:mergeStateConditions({
		{
			stateName = "PartyTopOrMiddle",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PartyBar:linkToElementModel(PartyBar, "isInAParty", true, function(model)
		f1_arg0:updateElementState(PartyBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInAParty",
		})
	end)
	PartyBar:linkToElementModel(PartyBar, "isPartyMember", true, function(model)
		f1_arg0:updateElementState(PartyBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPartyMember",
		})
	end)
	PartyBar.PartyBarGlow2:setRGB(0.61, 0.61, 0.61)
	PartyBar.PartyBarGlow3:setRGB(0.61, 0.61, 0.61)
	PartyBar:linkToElementModel(self, nil, false, function(model)
		PartyBar:setModel(model, f1_arg1)
	end)
	self:addElement(PartyBar)
	self.PartyBar = PartyBar
	self:mergeStateConditions({
		{
			stateName = "YourParty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isPartyMember") and CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isInAParty")
			end,
		},
		{
			stateName = "OtherParty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isInAParty")
			end,
		},
	})
	self:linkToElementModel(self, "isPartyMember", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPartyMember",
		})
	end)
	self:linkToElementModel(self, "isInAParty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInAParty",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPartyBarHorizontal.__resetProperties = function(f10_arg0)
	f10_arg0.PartyBar:completeAnimation()
	f10_arg0.PartyBar:setAlpha(1)
	f10_arg0.PartyBar.PartyBar:setRGB(0.02, 0.29, 0.49)
	f10_arg0.PartyBar.PartyBarGlow:setRGB(0, 0.03, 0.2)
	f10_arg0.PartyBar.PartyBarhotspot:setRGB(0, 0.56, 1)
end
CoD.DirectorPartyBarHorizontal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.PartyBar:completeAnimation()
			f11_arg0.PartyBar:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyBar)
		end,
	},
	YourParty = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.PartyBar:completeAnimation()
			f12_arg0.clipFinished(f12_arg0.PartyBar)
		end,
	},
	OtherParty = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.PartyBar:completeAnimation()
			f13_arg0.PartyBar.PartyBar:completeAnimation()
			f13_arg0.PartyBar.PartyBarGlow:completeAnimation()
			f13_arg0.PartyBar.PartyBarhotspot:completeAnimation()
			f13_arg0.PartyBar.PartyBar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f13_arg0.PartyBar.PartyBarGlow:setRGB(0.2, 0.2, 0.2)
			f13_arg0.PartyBar.PartyBarhotspot:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f13_arg0.clipFinished(f13_arg0.PartyBar)
		end,
	},
}
CoD.DirectorPartyBarHorizontal.__onClose = function(f14_arg0)
	f14_arg0.PartyBar:close()
end
