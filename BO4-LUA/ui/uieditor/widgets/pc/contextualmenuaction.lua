CoD.ContextualMenuAction = InheritFrom(LUI.UIElement)
CoD.ContextualMenuAction.__defaultWidth = 233
CoD.ContextualMenuAction.__defaultHeight = 29
CoD.ContextualMenuAction.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ContextualMenuAction)
	self.id = "ContextualMenuAction"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.18, 0.17, 0.17)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local ActionName = LUI.UIText.new(0.02, 0.02, 0, 213, 0.5, 0.5, -10.5, 10.5)
	ActionName:setRGB(0.76, 0.76, 0.76)
	ActionName:setTTF("ttmussels_regular")
	ActionName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActionName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ActionName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ActionName)
	self.ActionName = ActionName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContextualMenuAction.__resetProperties = function(f3_arg0)
	f3_arg0.ActionName:completeAnimation()
	f3_arg0.Background:completeAnimation()
	f3_arg0.ActionName:setRGB(0.76, 0.76, 0.76)
	f3_arg0.Background:setAlpha(0)
end
CoD.ContextualMenuAction.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Background)
			f5_arg0.ActionName:completeAnimation()
			f5_arg0.ActionName:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.ActionName)
		end,
	},
}
CoD.ContextualMenuAction.__onClose = function(f6_arg0)
	f6_arg0.ActionName:close()
end
