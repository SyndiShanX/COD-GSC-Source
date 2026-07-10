require("x64:1053cc2f0b27dee")
CoD.DoubleXPCardIconsLeftAligned = InheritFrom(LUI.UIElement)
CoD.DoubleXPCardIconsLeftAligned.__defaultWidth = 129
CoD.DoubleXPCardIconsLeftAligned.__defaultHeight = 43
CoD.DoubleXPCardIconsLeftAligned.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DoubleXPCardIconsLeftAligned)
	self.id = "DoubleXPCardIconsLeftAligned"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPCardIconsInternal = CoD.DoubleXPCardIconsInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 129, 0, 0, 0, 43)
	DoubleXPCardIconsInternal:linkToElementModel(self, nil, false, function(model)
		DoubleXPCardIconsInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPCardIconsInternal)
	self.DoubleXPCardIconsInternal = DoubleXPCardIconsInternal
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPCardIconsLeftAligned.__resetProperties = function(f4_arg0)
	f4_arg0.DoubleXPCardIconsInternal:completeAnimation()
	f4_arg0.DoubleXPCardIconsInternal:setAlpha(1)
end
CoD.DoubleXPCardIconsLeftAligned.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.DoubleXPCardIconsInternal:completeAnimation()
			f5_arg0.DoubleXPCardIconsInternal:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.DoubleXPCardIconsInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DoubleXPCardIconsInternal:completeAnimation()
			f6_arg0.DoubleXPCardIconsInternal:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.DoubleXPCardIconsInternal)
		end,
	},
}
CoD.DoubleXPCardIconsLeftAligned.__onClose = function(f7_arg0)
	f7_arg0.DoubleXPCardIconsInternal:close()
end
