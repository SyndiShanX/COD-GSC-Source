CoD.CalloutItemText = InheritFrom(LUI.UIElement)
CoD.CalloutItemText.__defaultWidth = 182
CoD.CalloutItemText.__defaultHeight = 26
CoD.CalloutItemText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CalloutItemText)
	self.id = "CalloutItemText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Title = LUI.UIText.new(0.5, 0.5, -91, 91, 0, 0, 0, 26)
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "SocialCallout",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "isSocialCallout", 1)
			end,
		},
	})
	self:linkToElementModel(self, "isSocialCallout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isSocialCallout",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CalloutItemText.__resetProperties = function(f5_arg0)
	f5_arg0.Title:completeAnimation()
	f5_arg0.Title:setRGB(1, 1, 1)
end
CoD.CalloutItemText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	SocialCallout = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Title:completeAnimation()
			f7_arg0.Title:setRGB(ColorSet.PlayerGreen.r, ColorSet.PlayerGreen.g, ColorSet.PlayerGreen.b)
			f7_arg0.clipFinished(f7_arg0.Title)
		end,
	},
}
CoD.CalloutItemText.__onClose = function(f8_arg0)
	f8_arg0.Title:close()
end
