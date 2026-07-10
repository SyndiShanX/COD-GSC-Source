require("x64:7c07612ffc6dbec")
CoD.StorePriceContainer = InheritFrom(LUI.UIElement)
CoD.StorePriceContainer.__defaultWidth = 300
CoD.StorePriceContainer.__defaultHeight = 30
CoD.StorePriceContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StorePriceContainer)
	self.id = "StorePriceContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StorePriceLabel = CoD.StorePriceLabel.new(f1_arg0, f1_arg1, 1, 1, -300, 0, 0.5, 0.5, -15, 17)
	StorePriceLabel.Glow:setRGB(0.3, 0.23, 0.2)
	self:addElement(StorePriceLabel)
	self.StorePriceLabel = StorePriceLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StorePriceContainer.__resetProperties = function(f2_arg0)
	f2_arg0.StorePriceLabel:completeAnimation()
	f2_arg0.StorePriceLabel:setAlpha(1)
end
CoD.StorePriceContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hide = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.StorePriceLabel:completeAnimation()
			f4_arg0.StorePriceLabel:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.StorePriceLabel)
		end,
	},
}
CoD.StorePriceContainer.__onClose = function(f5_arg0)
	f5_arg0.StorePriceLabel:close()
end
