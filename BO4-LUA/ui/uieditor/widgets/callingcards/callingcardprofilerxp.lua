CoD.CallingCardProfilerXP = InheritFrom(LUI.UIElement)
CoD.CallingCardProfilerXP.__defaultWidth = 158
CoD.CallingCardProfilerXP.__defaultHeight = 54
CoD.CallingCardProfilerXP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCardProfilerXP)
	self.id = "CallingCardProfilerXP"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XPText = LUI.UIText.new(0, 0, 54, 158, 0, 0, 17.5, 38.5)
	XPText:setTTF("default")
	XPText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	XPText:linkToElementModel(self, "xp", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			XPText:setText(LocalizeIntoString(@"hash_1C0E387C289AD7A9", f2_local0))
		end
	end)
	self:addElement(XPText)
	self.XPText = XPText
	local MeritsText = LUI.UIText.new(0, 0, 54, 158, 0, 0, 17.5, 38.5)
	MeritsText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MeritsText:setAlpha(0)
	MeritsText:setTTF("default")
	MeritsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MeritsText:linkToElementModel(self, "xp", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MeritsText:setText(LocalizeIntoString(@"hash_5B30C9471AAF95D", f3_local0))
		end
	end)
	self:addElement(MeritsText)
	self.MeritsText = MeritsText
	local XPIcon = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 54)
	XPIcon:setImage(RegisterImage(@"uie_t7_hud_mp_notifications_xp"))
	self:addElement(XPIcon)
	self.XPIcon = XPIcon
	self:mergeStateConditions({
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isWZ")
			end,
		},
	})
	self:linkToElementModel(self, "isWZ", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isWZ",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCardProfilerXP.__resetProperties = function(f6_arg0)
	f6_arg0.XPIcon:completeAnimation()
	f6_arg0.MeritsText:completeAnimation()
	f6_arg0.XPText:completeAnimation()
	f6_arg0.XPIcon:setAlpha(1)
	f6_arg0.MeritsText:setLeftRight(0, 0, 54, 158)
	f6_arg0.MeritsText:setAlpha(0)
	f6_arg0.MeritsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f6_arg0.XPText:setAlpha(1)
end
CoD.CallingCardProfilerXP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	WZ = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.XPText:completeAnimation()
			f8_arg0.XPText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.XPText)
			f8_arg0.MeritsText:completeAnimation()
			f8_arg0.MeritsText:setLeftRight(0.5, 0.5, -75, 75)
			f8_arg0.MeritsText:setAlpha(1)
			f8_arg0.MeritsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f8_arg0.clipFinished(f8_arg0.MeritsText)
			f8_arg0.XPIcon:completeAnimation()
			f8_arg0.XPIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.XPIcon)
		end,
	},
}
CoD.CallingCardProfilerXP.__onClose = function(f9_arg0)
	f9_arg0.XPText:close()
	f9_arg0.MeritsText:close()
end
