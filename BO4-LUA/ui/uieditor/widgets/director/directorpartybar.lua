require("x64:ef2c4b77caab743")
require("x64:7610254bee05fe0")
CoD.DirectorPartyBar = InheritFrom(LUI.UIElement)
CoD.DirectorPartyBar.__defaultWidth = 5
CoD.DirectorPartyBar.__defaultHeight = 64
CoD.DirectorPartyBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPartyBar)
	self.id = "DirectorPartyBar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyBar = CoD.DirectorPartyBarInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	PartyBar:linkToElementModel(self, nil, false, function(model)
		PartyBar:setModel(model, f1_arg1)
	end)
	self:addElement(PartyBar)
	self.PartyBar = PartyBar
	local DirectorPartyLeader = CoD.DirectorPartyLeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -1, 19, 0.5, 0.5, -10, 10)
	DirectorPartyLeader:linkToElementModel(self, nil, false, function(model)
		DirectorPartyLeader:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorPartyLeader)
	self.DirectorPartyLeader = DirectorPartyLeader
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
CoD.DirectorPartyBar.__resetProperties = function(f8_arg0)
	f8_arg0.DirectorPartyLeader:completeAnimation()
	f8_arg0.PartyBar:completeAnimation()
	f8_arg0.DirectorPartyLeader:setAlpha(1)
	f8_arg0.PartyBar:setAlpha(1)
	f8_arg0.PartyBar.PartyBarGlow2:setRGB(0, 0.08, 0.61)
	f8_arg0.PartyBar.PartyBarGlow3:setRGB(0, 0.08, 0.61)
	f8_arg0.PartyBar.PartyBar:setRGB(0.02, 0.29, 0.49)
	f8_arg0.PartyBar.PartyBarGlow:setRGB(0, 0.03, 0.2)
	f8_arg0.PartyBar.PartyBarhotspot:setRGB(0, 0.56, 1)
end
CoD.DirectorPartyBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.PartyBar:completeAnimation()
			f9_arg0.PartyBar:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PartyBar)
			f9_arg0.DirectorPartyLeader:completeAnimation()
			f9_arg0.DirectorPartyLeader:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DirectorPartyLeader)
		end,
	},
	YourParty = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.PartyBar:completeAnimation()
			f10_arg0.clipFinished(f10_arg0.PartyBar)
		end,
	},
	OtherParty = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.PartyBar:completeAnimation()
			f11_arg0.PartyBar.PartyBarGlow2:completeAnimation()
			f11_arg0.PartyBar.PartyBarGlow3:completeAnimation()
			f11_arg0.PartyBar.PartyBar:completeAnimation()
			f11_arg0.PartyBar.PartyBarGlow:completeAnimation()
			f11_arg0.PartyBar.PartyBarhotspot:completeAnimation()
			f11_arg0.PartyBar.PartyBarGlow2:setRGB(0.61, 0.61, 0.61)
			f11_arg0.PartyBar.PartyBarGlow3:setRGB(0.61, 0.61, 0.61)
			f11_arg0.PartyBar.PartyBar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f11_arg0.PartyBar.PartyBarGlow:setRGB(0.2, 0.2, 0.2)
			f11_arg0.PartyBar.PartyBarhotspot:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f11_arg0.clipFinished(f11_arg0.PartyBar)
		end,
	},
}
CoD.DirectorPartyBar.__onClose = function(f12_arg0)
	f12_arg0.PartyBar:close()
	f12_arg0.DirectorPartyLeader:close()
end
