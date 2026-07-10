CoD.HubCharacterTabItem = InheritFrom(LUI.UIElement)
CoD.HubCharacterTabItem.__defaultWidth = 180
CoD.HubCharacterTabItem.__defaultHeight = 30
CoD.HubCharacterTabItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubCharacterTabItem)
	self.id = "HubCharacterTabItem"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local name = LUI.UIText.new(0, 1, 0, 0, 0, 0, 9, 30)
	name:setRGB(0.96, 0.93, 0.84)
	name:setTTF("ttmussels_regular")
	name:setLetterSpacing(2)
	name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	name:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	name:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			name:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(name)
	self.name = name
	local nameBold = LUI.UIText.new(0, 1, 0, 0, 0, 0, 9, 30)
	nameBold:setRGB(0.96, 0.93, 0.84)
	nameBold:setAlpha(0)
	nameBold:setTTF("ttmussels_demibold")
	nameBold:setLetterSpacing(3)
	nameBold:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	nameBold:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	nameBold:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			nameBold:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(nameBold)
	self.nameBold = nameBold
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubCharacterTabItem.__resetProperties = function(f4_arg0)
	f4_arg0.name:completeAnimation()
	f4_arg0.nameBold:completeAnimation()
	f4_arg0.name:setRGB(0.96, 0.93, 0.84)
	f4_arg0.name:setAlpha(1)
	f4_arg0.nameBold:setAlpha(0)
end
CoD.HubCharacterTabItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.name:completeAnimation()
			f5_arg0.name:setRGB(0.96, 0.93, 0.84)
			f5_arg0.name:setAlpha(0.2)
			f5_arg0.clipFinished(f5_arg0.name)
		end,
		Active = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.name:completeAnimation()
			f6_arg0.name:setRGB(0.96, 0.93, 0.84)
			f6_arg0.name:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.name)
			f6_arg0.nameBold:completeAnimation()
			f6_arg0.nameBold:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.nameBold)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.name:completeAnimation()
			f7_arg0.name:setRGB(0.96, 0.93, 0.84)
			f7_arg0.name:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.name)
			f7_arg0.nameBold:completeAnimation()
			f7_arg0.nameBold:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.nameBold)
		end,
	},
}
if not CoD.isPC then
	CoD.HubCharacterTabItem.__clipsPerState.DefaultState.Focus = nil
end
CoD.HubCharacterTabItem.__onClose = function(f8_arg0)
	f8_arg0.name:close()
	f8_arg0.nameBold:close()
end
