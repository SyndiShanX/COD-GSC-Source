require("x64:817fd7a76f502e6")
CoD.CodCasterButtonBar = InheritFrom(LUI.UIElement)
CoD.CodCasterButtonBar.__defaultWidth = 1800
CoD.CodCasterButtonBar.__defaultHeight = 36
CoD.CodCasterButtonBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterButtonBar)
	self.id = "CodCasterButtonBar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local black = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 120)
	black:setRGB(0, 0, 0)
	black:setAlpha(0.7)
	self:addElement(black)
	self.black = black
	local CodCasterButtons = CoD.CodCasterButtons.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CodCasterButtons:linkToElementModel(self, nil, false, function(model)
		CodCasterButtons:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterButtons)
	self.CodCasterButtons = CodCasterButtons
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_toolbar", 1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.profileSettingsUpdated, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	if CoD.isPC then
		CodCasterButtons.id = "CodCasterButtons"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterButtonBar.__resetProperties = function(f5_arg0)
	f5_arg0.CodCasterButtons:completeAnimation()
	f5_arg0.black:completeAnimation()
	f5_arg0.CodCasterButtons:setAlpha(1)
	f5_arg0.black:setAlpha(0.7)
end
CoD.CodCasterButtonBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.black:completeAnimation()
			f6_arg0.black:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.black)
			f6_arg0.CodCasterButtons:completeAnimation()
			f6_arg0.CodCasterButtons:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CodCasterButtons)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CodCasterButtonBar.__onClose = function(f8_arg0)
	f8_arg0.CodCasterButtons:close()
end
