CoD.StartMenu_Options_Controls_GenericControllerItem = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Controls_GenericControllerItem.__defaultWidth = 300
CoD.StartMenu_Options_Controls_GenericControllerItem.__defaultHeight = 37
CoD.StartMenu_Options_Controls_GenericControllerItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Controls_GenericControllerItem)
	self.id = "StartMenu_Options_Controls_GenericControllerItem"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local defaultText = LUI.UIText.new(0, 1, 0, 0, 0.18, 0.83, 0, 0)
	defaultText:setTTF("dinnext_regular")
	defaultText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	defaultText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	defaultText:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			defaultText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(defaultText)
	self.defaultText = defaultText
	self:mergeStateConditions({
		{
			stateName = "NonDefault",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDefault")
			end,
		},
	})
	self:linkToElementModel(self, "isDefault", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDefault",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Controls_GenericControllerItem.__resetProperties = function(f5_arg0)
	f5_arg0.defaultText:completeAnimation()
	f5_arg0.defaultText:setRGB(1, 1, 1)
end
CoD.StartMenu_Options_Controls_GenericControllerItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.defaultText:completeAnimation()
			f6_arg0.clipFinished(f6_arg0.defaultText)
		end,
	},
	NonDefault = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.defaultText:completeAnimation()
			f7_arg0.defaultText:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f7_arg0.clipFinished(f7_arg0.defaultText)
		end,
	},
}
CoD.StartMenu_Options_Controls_GenericControllerItem.__onClose = function(f8_arg0)
	f8_arg0.defaultText:close()
end
