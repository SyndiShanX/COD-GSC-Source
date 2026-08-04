require("ui/uieditor/widgets/footerbuttonprompt")
CoD.FooterButton_BackHold = InheritFrom(LUI.UIElement)
CoD.FooterButton_BackHold.__defaultWidth = 240
CoD.FooterButton_BackHold.__defaultHeight = 48
CoD.FooterButton_BackHold.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_BackHold)
	self.id = "FooterButton_BackHold"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0, 0, 240, 0, 0, 4, 44)
	Backing:setRGB(0.8, 0.2, 0.15)
	self:addElement(Backing)
	self.Backing = Backing
	local Bbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 1, 1, -241.5, -1.5, 1, 1, -48, 0)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Bbtn.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	Bbtn:linkToElementModel(self, nil, false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(self, f1_arg1, "flags", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"])
			end,
		},
	})
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	if CoD.isPC then
		Bbtn.id = "Bbtn"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_BackHold.__resetProperties = function(f6_arg0)
	f6_arg0.Bbtn:completeAnimation()
	f6_arg0.Backing:completeAnimation()
	f6_arg0.Bbtn:setAlpha(1)
	f6_arg0.Backing:setAlpha(1)
end
CoD.FooterButton_BackHold.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.Bbtn:completeAnimation()
			f8_arg0.Bbtn:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Bbtn)
		end,
	},
}
CoD.FooterButton_BackHold.__onClose = function(f9_arg0)
	f9_arg0.Bbtn:close()
end
