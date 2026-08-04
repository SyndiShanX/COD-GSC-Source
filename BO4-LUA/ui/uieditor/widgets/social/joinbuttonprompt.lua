require("ui/uieditor/widgets/border")
CoD.JoinButtonPrompt = InheritFrom(LUI.UIElement)
CoD.JoinButtonPrompt.__defaultWidth = 39
CoD.JoinButtonPrompt.__defaultHeight = 39
CoD.JoinButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.JoinButtonPrompt)
	self.id = "JoinButtonPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GpadButtonImage = LUI.UIImage.new(0, 0, 0, 39, 0, 0, 0, 39)
	GpadButtonImage:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GpadButtonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GpadButtonImage)
	self.GpadButtonImage = GpadButtonImage
	local KMprompt = nil
	KMprompt = LUI.UIText.new(1, 1, -39, 0, 0, 0, 7, 40)
	KMprompt:setAlpha(0)
	KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("J"))
	KMprompt:setTTF("default")
	KMprompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	KMprompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(KMprompt)
	self.KMprompt = KMprompt
	local Border = nil
	Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.79, 0.78, 0.78)
	self:addElement(Border)
	self.Border = Border
	self:mergeStateConditions({
		{
			stateName = "KBMouse",
			condition = function(menu, element, event)
				local f3_local0
				if not IsGamepad(f1_arg1) then
					f3_local0 = IsPC()
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = KMprompt
	return self
end
CoD.JoinButtonPrompt.__resetProperties = function(f6_arg0)
	f6_arg0.Border:completeAnimation()
	f6_arg0.GpadButtonImage:completeAnimation()
	f6_arg0.KMprompt:completeAnimation()
	f6_arg0.Border:setAlpha(1)
	f6_arg0.GpadButtonImage:setAlpha(1)
	f6_arg0.KMprompt:setLeftRight(1, 1, -39, 0)
	f6_arg0.KMprompt:setTopBottom(0, 0, 7, 40)
	f6_arg0.KMprompt:setAlpha(0)
	f6_arg0.KMprompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
end
CoD.JoinButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Border:completeAnimation()
			f7_arg0.Border:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Border)
		end,
	},
	KBMouse = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.GpadButtonImage:completeAnimation()
			f8_arg0.GpadButtonImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GpadButtonImage)
			f8_arg0.KMprompt:completeAnimation()
			f8_arg0.KMprompt:setLeftRight(0.5, 0.5, -14, 16)
			f8_arg0.KMprompt:setTopBottom(0.5, 0.5, -14, 16)
			f8_arg0.KMprompt:setAlpha(1)
			f8_arg0.KMprompt:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
			f8_arg0.clipFinished(f8_arg0.KMprompt)
		end,
	},
}
CoD.JoinButtonPrompt.__onClose = function(f9_arg0)
	f9_arg0.GpadButtonImage:close()
	f9_arg0.KMprompt:close()
	f9_arg0.Border:close()
end
