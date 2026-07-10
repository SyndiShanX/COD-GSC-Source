CoD.FileshareSpinner = InheritFrom(LUI.UIElement)
CoD.FileshareSpinner.__defaultWidth = 96
CoD.FileshareSpinner.__defaultHeight = 96
CoD.FileshareSpinner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FileshareSpinner)
	self.id = "FileshareSpinner"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpinnerFlipbook = LUI.UIImage.new(0, 0, -11, 106, 0, 0, -11, 106)
	SpinnerFlipbook:setRGB(1, 0.63, 0)
	SpinnerFlipbook:setImage(RegisterImage(0xD7107421B53850D))
	SpinnerFlipbook:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	SpinnerFlipbook:setShaderVector(0, 28, 0, 0, 0)
	SpinnerFlipbook:setShaderVector(1, 22, 0, 0, 0)
	self:addElement(SpinnerFlipbook)
	self.SpinnerFlipbook = SpinnerFlipbook
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not FileshareIsReady(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["fileshareRoot.ready"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "fileshareRoot.ready",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FileshareSpinner.__resetProperties = function(f4_arg0)
	f4_arg0.SpinnerFlipbook:completeAnimation()
	f4_arg0.SpinnerFlipbook:setAlpha(1)
end
CoD.FileshareSpinner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.SpinnerFlipbook:completeAnimation()
			f5_arg0.SpinnerFlipbook:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.SpinnerFlipbook)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
