CoD.SpecialistInfoCTProgress = InheritFrom(LUI.UIElement)
CoD.SpecialistInfoCTProgress.__defaultWidth = 75
CoD.SpecialistInfoCTProgress.__defaultHeight = 100
CoD.SpecialistInfoCTProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistInfoCTProgress)
	self.id = "SpecialistInfoCTProgress"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StarImage = LUI.UIImage.new(0, 0, 0, 75, 0, 0, 0, 75)
	StarImage:linkToElementModel(self, "starImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StarImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(StarImage)
	self.StarImage = StarImage
	local Header = LUI.UIText.new(0, 0, 0, 75, 0, 0, 79, 97)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setAlpha(0.5)
	Header:setTTF("ttmussels_regular")
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Header:linkToElementModel(self, "header", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Header:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Header)
	self.Header = Header
	self:mergeStateConditions({
		{
			stateName = "NotShown",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistInfoCTProgress.__resetProperties = function(f5_arg0)
	f5_arg0.StarImage:completeAnimation()
	f5_arg0.Header:completeAnimation()
	f5_arg0.StarImage:setAlpha(1)
	f5_arg0.Header:setAlpha(0.5)
end
CoD.SpecialistInfoCTProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NotShown = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.StarImage:completeAnimation()
			f7_arg0.StarImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.StarImage)
			f7_arg0.Header:completeAnimation()
			f7_arg0.Header:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Header)
		end,
	},
}
CoD.SpecialistInfoCTProgress.__onClose = function(f8_arg0)
	f8_arg0.StarImage:close()
	f8_arg0.Header:close()
end
