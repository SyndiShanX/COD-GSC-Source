CoD.LaboratoryListItemInternalPurchaseLimit = InheritFrom(LUI.UIElement)
CoD.LaboratoryListItemInternalPurchaseLimit.__defaultWidth = 150
CoD.LaboratoryListItemInternalPurchaseLimit.__defaultHeight = 34
CoD.LaboratoryListItemInternalPurchaseLimit.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryListItemInternalPurchaseLimit)
	self.id = "LaboratoryListItemInternalPurchaseLimit"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local limitBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	limitBG:setRGB(0, 0, 0)
	limitBG:setAlpha(0.69)
	self:addElement(limitBG)
	self.limitBG = limitBG
	local text = LUI.UIText.new(0, 1, 9, 1, 0, 0, 4, 18)
	text:setTTF("dinnext_regular")
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	text:linkToElementModel(self, "maxQuantity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text:setText(LocalizeIntoString(@"hash_1A29379575EF77E5", f2_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryListItemInternalPurchaseLimit.__resetProperties = function(f3_arg0)
	f3_arg0.text:completeAnimation()
	f3_arg0.limitBG:completeAnimation()
	f3_arg0.text:setRGB(1, 1, 1)
	f3_arg0.text:setAlpha(1)
	f3_arg0.limitBG:setAlpha(0.69)
end
CoD.LaboratoryListItemInternalPurchaseLimit.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.limitBG:completeAnimation()
			f4_arg0.limitBG:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.limitBG)
			f4_arg0.text:completeAnimation()
			f4_arg0.text:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.text)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleCantPurchase = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.text:completeAnimation()
			f6_arg0.text:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f6_arg0.clipFinished(f6_arg0.text)
		end,
	},
}
CoD.LaboratoryListItemInternalPurchaseLimit.__onClose = function(f7_arg0)
	f7_arg0.text:close()
end
