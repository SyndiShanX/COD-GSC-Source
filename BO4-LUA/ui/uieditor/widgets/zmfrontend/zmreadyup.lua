CoD.ZMReadyUp = InheritFrom(LUI.UIElement)
CoD.ZMReadyUp.__defaultWidth = 200
CoD.ZMReadyUp.__defaultHeight = 24
CoD.ZMReadyUp.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMReadyUp)
	self.id = "ZMReadyUp"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 24)
	TextBox:setAlpha(0)
	TextBox:setText(LocalizeToUpperString(0x8E54FCC8151C19C))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "NotReady",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrTrue(self, f1_arg1, "isReady")
			end,
		},
		{
			stateName = "Ready",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isReady")
			end,
		},
	})
	self:linkToElementModel(self, "isReady", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isReady",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMReadyUp.__resetProperties = function(f5_arg0)
	f5_arg0.TextBox:completeAnimation()
	f5_arg0.TextBox:setRGB(1, 1, 1)
	f5_arg0.TextBox:setAlpha(0)
	f5_arg0.TextBox:setText(LocalizeToUpperString(0x8E54FCC8151C19C))
end
CoD.ZMReadyUp.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NotReady = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TextBox:completeAnimation()
			f7_arg0.TextBox:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f7_arg0.TextBox:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.TextBox)
		end,
	},
	Ready = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f8_arg0.TextBox:setAlpha(1)
			f8_arg0.TextBox:setText(LocalizeToUpperString(0xE6F6113B8B75F3E))
			f8_arg0.clipFinished(f8_arg0.TextBox)
		end,
	},
}
