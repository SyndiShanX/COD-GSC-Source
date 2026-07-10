CoD.OverheadNameWZCash = InheritFrom(LUI.UIElement)
CoD.OverheadNameWZCash.__defaultWidth = 32
CoD.OverheadNameWZCash.__defaultHeight = 32
CoD.OverheadNameWZCash.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverheadNameWZCash)
	self.id = "OverheadNameWZCash"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OverheadNameWZCash = LUI.UIImage.new(0, 0, 0, 32, 0, 0, 0, 32)
	OverheadNameWZCash:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	OverheadNameWZCash:setImage(RegisterImage(@"ui_icon_wz_hud_cash"))
	self:addElement(OverheadNameWZCash)
	self.OverheadNameWZCash = OverheadNameWZCash
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "hasCash", 1)
			end,
		},
	})
	self:linkToElementModel(self, "hasCash", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasCash",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverheadNameWZCash.__resetProperties = function(f4_arg0)
	f4_arg0.OverheadNameWZCash:completeAnimation()
	f4_arg0.OverheadNameWZCash:setAlpha(1)
end
CoD.OverheadNameWZCash.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.OverheadNameWZCash:completeAnimation()
			f5_arg0.OverheadNameWZCash:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.OverheadNameWZCash)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
