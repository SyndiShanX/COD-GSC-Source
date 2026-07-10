require("x64:eeb1847d838c6b1")
CoD.BGBSelectCategory = InheritFrom(LUI.UIElement)
CoD.BGBSelectCategory.__defaultWidth = 170
CoD.BGBSelectCategory.__defaultHeight = 35
CoD.BGBSelectCategory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BGBSelectCategory)
	self.id = "BGBSelectCategory"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CurrentSlot = LUI.UIText.new(0.5, 0.5, -100, 100, 1, 1, 7, 28)
	CurrentSlot:setRGB(0.58, 0.85, 1)
	CurrentSlot:setTTF("ttmussels_regular")
	CurrentSlot:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	CurrentSlot:setShaderVector(0, 1, 0, 0, 0)
	CurrentSlot:setShaderVector(1, 0, 0, 0, 0)
	CurrentSlot:setShaderVector(2, 0.2, 0.3, 1, 0.3)
	CurrentSlot:setLetterSpacing(4)
	CurrentSlot:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CurrentSlot:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CurrentSlot:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "selectedIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentSlot:setText(ConvertToUpperString(CoD.ZMLoadoutUtility.GetBGBSlotEditingString(f2_local0)))
		end
	end)
	self:addElement(CurrentSlot)
	self.CurrentSlot = CurrentSlot
	local PerkName = CoD.CACTabButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 35)
	PerkName:linkToElementModel(self, nil, false, function(model)
		PerkName:setModel(model, f1_arg1)
	end)
	PerkName:linkToElementModel(self, nil, false, function(model)
		PerkName.RestrictedIcon:setModel(model, f1_arg1)
	end)
	PerkName:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PerkName.Text:setText(Engine[0xF9F1239CFD921FE](f5_local0))
		end
	end)
	PerkName:linkToElementModel(self, "name", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PerkName.TextFocus:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	self:addElement(PerkName)
	self.PerkName = PerkName
	PerkName.id = "PerkName"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BGBSelectCategory.__resetProperties = function(f7_arg0)
	f7_arg0.CurrentSlot:completeAnimation()
	f7_arg0.CurrentSlot:setLeftRight(0.5, 0.5, -100, 100)
	f7_arg0.CurrentSlot:setTopBottom(1, 1, 7, 28)
	f7_arg0.CurrentSlot:setAlpha(1)
end
CoD.BGBSelectCategory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CurrentSlot:completeAnimation()
			f8_arg0.CurrentSlot:setLeftRight(0.5, 0.5, -100, 100)
			f8_arg0.CurrentSlot:setTopBottom(1, 1, 30, 54)
			f8_arg0.CurrentSlot:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CurrentSlot)
		end,
		Active = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.CurrentSlot:completeAnimation()
			f9_arg0.CurrentSlot:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.CurrentSlot)
		end,
	},
}
CoD.BGBSelectCategory.__onClose = function(f10_arg0)
	f10_arg0.CurrentSlot:close()
	f10_arg0.PerkName:close()
end
