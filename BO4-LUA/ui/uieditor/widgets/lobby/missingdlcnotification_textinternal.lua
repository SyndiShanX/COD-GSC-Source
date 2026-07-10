CoD.MissingDLCNotification_TextInternal = InheritFrom(LUI.UIElement)
CoD.MissingDLCNotification_TextInternal.__defaultWidth = 331
CoD.MissingDLCNotification_TextInternal.__defaultHeight = 14
CoD.MissingDLCNotification_TextInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MissingDLCNotification_TextInternal)
	self.id = "MissingDLCNotification_TextInternal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 14)
	label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A201C5CBA235AA1"))
	label:setTTF("ttmussels_demibold")
	label:setLetterSpacing(2)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(label)
	self.label = label
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MissingDLCNotification_TextInternal.__resetProperties = function(f3_arg0)
	f3_arg0.label:completeAnimation()
	f3_arg0.label:setTopBottom(0, 0, 0, 14)
end
CoD.MissingDLCNotification_TextInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.label:completeAnimation()
			f5_arg0.label:setTopBottom(0, 0, 4, 14)
			f5_arg0.clipFinished(f5_arg0.label)
		end,
	},
}
