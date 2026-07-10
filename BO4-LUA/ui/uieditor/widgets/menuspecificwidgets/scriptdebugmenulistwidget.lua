CoD.ScriptDebugMenuListWidget = InheritFrom(LUI.UIElement)
CoD.ScriptDebugMenuListWidget.__defaultWidth = 900
CoD.ScriptDebugMenuListWidget.__defaultHeight = 45
CoD.ScriptDebugMenuListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScriptDebugMenuListWidget)
	self.id = "ScriptDebugMenuListWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local selectedImage = LUI.UIImage.new(0, 1, 0, -900, 0, 1, 0, 0)
	selectedImage:setRGB(1, 0.64, 0)
	selectedImage:setAlpha(0)
	self:addElement(selectedImage)
	self.selectedImage = selectedImage
	local listItemName = LUI.UIText.new(0, 0, 22, 277, 0.5, 0.5, -18, 12)
	listItemName:setZoom(10)
	listItemName:setTTF("default")
	listItemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(listItemName)
	self.listItemName = listItemName
	self.listItemName:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			listItemName:setRGB(f2_local0)
		end
	end)
	self.listItemName:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			listItemName:setText(f3_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScriptDebugMenuListWidget.__resetProperties = function(f4_arg0)
	f4_arg0.listItemName:completeAnimation()
	f4_arg0.selectedImage:completeAnimation()
	f4_arg0.listItemName:setLeftRight(0, 0, 22, 277)
	f4_arg0.listItemName:setTopBottom(0.5, 0.5, -18, 12)
	f4_arg0.selectedImage:setLeftRight(0, 1, 0, -900)
	f4_arg0.selectedImage:setTopBottom(0, 1, 0, 0)
	f4_arg0.selectedImage:setAlpha(0)
end
CoD.ScriptDebugMenuListWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.listItemName:completeAnimation()
			f5_arg0.listItemName:setLeftRight(0, 0, 1.5, 235.5)
			f5_arg0.listItemName:setTopBottom(0.5, 0.5, -18, 12)
			f5_arg0.clipFinished(f5_arg0.listItemName)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.selectedImage:completeAnimation()
			f6_arg0.selectedImage:setLeftRight(0, 1, 0, -888)
			f6_arg0.selectedImage:setTopBottom(0, 1, 0, 0)
			f6_arg0.selectedImage:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.selectedImage)
			f6_arg0.listItemName:completeAnimation()
			f6_arg0.listItemName:setLeftRight(0, 0, 22.5, 256.5)
			f6_arg0.listItemName:setTopBottom(0.5, 0.5, -18, 12)
			f6_arg0.clipFinished(f6_arg0.listItemName)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.selectedImage:beginAnimation(100)
				f7_arg0.selectedImage:setLeftRight(0, 1, 0, -888)
				f7_arg0.selectedImage:setAlpha(1)
				f7_arg0.selectedImage:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.selectedImage:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.selectedImage:completeAnimation()
			f7_arg0.selectedImage:setLeftRight(0, 1, 0, -900)
			f7_arg0.selectedImage:setTopBottom(0, 1, 0, 0)
			f7_arg0.selectedImage:setAlpha(0)
			f7_local0(f7_arg0.selectedImage)
			f7_arg0.listItemName:completeAnimation()
			f7_arg0.listItemName:setLeftRight(0, 0, 22.5, 256.5)
			f7_arg0.listItemName:setTopBottom(0.5, 0.5, -18, 12)
			f7_arg0.clipFinished(f7_arg0.listItemName)
		end,
	},
}
CoD.ScriptDebugMenuListWidget.__onClose = function(f9_arg0)
	f9_arg0.listItemName:close()
end
