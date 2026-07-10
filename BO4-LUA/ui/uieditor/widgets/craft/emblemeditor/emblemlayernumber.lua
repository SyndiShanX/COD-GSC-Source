CoD.EmblemLayerNumber = InheritFrom(LUI.UIElement)
CoD.EmblemLayerNumber.__defaultWidth = 108
CoD.EmblemLayerNumber.__defaultHeight = 36
CoD.EmblemLayerNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemLayerNumber)
	self.id = "EmblemLayerNumber"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local topbar = LUI.UIImage.new(0, 0, 0, 96, 0, 0, 0, 24)
	topbar:setRGB(0, 0, 0)
	topbar:setAlpha(0)
	self:addElement(topbar)
	self.topbar = topbar
	local layerNumber = LUI.UIText.new(0, 0, 30, 75, 0, 1, 0, 0)
	layerNumber:setTTF("ttmussels_demibold")
	layerNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	layerNumber:linkToElementModel(self, "layerNumberString", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			layerNumber:setText(f2_local0)
		end
	end)
	self:addElement(layerNumber)
	self.layerNumber = layerNumber
	local groupIcon = LUI.UIImage.new(0, 0, 0, 30, 0.5, 0.5, -15, 15)
	groupIcon:setImage(RegisterImage(@"uie_t7_menu_emblem_group"))
	self:addElement(groupIcon)
	self.groupIcon = groupIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemLayerNumber.__resetProperties = function(f3_arg0)
	f3_arg0.groupIcon:completeAnimation()
	f3_arg0.layerNumber:completeAnimation()
	f3_arg0.groupIcon:setAlpha(1)
	f3_arg0.layerNumber:setLeftRight(0, 0, 30, 75)
	f3_arg0.layerNumber:setTopBottom(0, 1, 0, 0)
end
CoD.EmblemLayerNumber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.layerNumber:completeAnimation()
			f4_arg0.layerNumber:setLeftRight(0, 0, -0.5, 43.5)
			f4_arg0.layerNumber:setTopBottom(0, 1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.layerNumber)
			f4_arg0.groupIcon:completeAnimation()
			f4_arg0.groupIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.groupIcon)
		end,
	},
	GroupLayerNum = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemLayerNumber.__onClose = function(f6_arg0)
	f6_arg0.layerNumber:close()
end
