require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
CoD.basicTabWidget = InheritFrom(LUI.UIElement)
CoD.basicTabWidget.__defaultWidth = 270
CoD.basicTabWidget.__defaultHeight = 60
CoD.basicTabWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.basicTabWidget)
	self.id = "basicTabWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 60)
	text:setTTF("default")
	text:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	text:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	text:linkToElementModel(self, "tabName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	local buttonText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 16, 44)
	buttonText:setAlpha(0)
	buttonText:setTTF("default")
	buttonText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	buttonText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	buttonText:linkToElementModel(self, "tabIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			buttonText:setText(f3_local0)
		end
	end)
	self:addElement(buttonText)
	self.buttonText = buttonText
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Frame)
	self.Frame = Frame
	self:mergeStateConditions({
		{
			stateName = "NavButton",
			condition = function(menu, element, event)
				return ShouldDisplayButton(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "tabIcon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tabIcon",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.basicTabWidget.__resetProperties = function(f6_arg0)
	f6_arg0.text:completeAnimation()
	f6_arg0.buttonText:completeAnimation()
	f6_arg0.text:setRGB(1, 1, 1)
	f6_arg0.text:setAlpha(1)
	f6_arg0.buttonText:setAlpha(0)
end
CoD.basicTabWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Active = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.text:completeAnimation()
			f8_arg0.text:setRGB(1, 0.41, 0)
			f8_arg0.clipFinished(f8_arg0.text)
		end,
	},
	NavButton = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.text:completeAnimation()
			f9_arg0.text:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.text)
			f9_arg0.buttonText:completeAnimation()
			f9_arg0.buttonText:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.buttonText)
		end,
	},
}
CoD.basicTabWidget.__onClose = function(f10_arg0)
	f10_arg0.text:close()
	f10_arg0.buttonText:close()
	f10_arg0.Frame:close()
end
