CoD.CraftLayerNumber = InheritFrom(LUI.UIElement)
CoD.CraftLayerNumber.__defaultWidth = 108
CoD.CraftLayerNumber.__defaultHeight = 24
CoD.CraftLayerNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftLayerNumber)
	self.id = "CraftLayerNumber"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local topbar = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	topbar:setRGB(0, 0, 0)
	topbar:setAlpha(0.9)
	self:addElement(topbar)
	self.topbar = topbar
	local layerNumber = LUI.UIText.new(0, 0, 26, 108, 0.5, 0.5, -10, 10)
	layerNumber:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	layerNumber:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/craft_layers"))
	layerNumber:setTTF("ttmussels_regular")
	layerNumber:setLetterSpacing(1)
	layerNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	layerNumber:setBackingType(2)
	layerNumber:setBackingColor(0, 0, 0)
	layerNumber:setBackingXPadding(2)
	layerNumber:setBackingYPadding(2)
	self:addElement(layerNumber)
	self.layerNumber = layerNumber
	local groupIcon = LUI.UIImage.new(0, 0, 1, 23, 0, 0, 1, 23)
	groupIcon:setImage(RegisterImage(@"uie_t7_menu_emblem_group"))
	self:addElement(groupIcon)
	self.groupIcon = groupIcon
	self:mergeStateConditions({
		{
			stateName = "NoGroupSelected",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.EmblemChooseIcon_IsDecalGroupFocused(self, f1_arg1)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftLayerNumber.__resetProperties = function(f3_arg0)
	f3_arg0.layerNumber:completeAnimation()
	f3_arg0.groupIcon:completeAnimation()
	f3_arg0.topbar:completeAnimation()
	f3_arg0.layerNumber:setLeftRight(0, 0, 26, 108)
	f3_arg0.layerNumber:setTopBottom(0.5, 0.5, -10, 10)
	f3_arg0.layerNumber:setAlpha(1)
	f3_arg0.groupIcon:setAlpha(1)
	f3_arg0.topbar:setAlpha(0.9)
end
CoD.CraftLayerNumber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.layerNumber:completeAnimation()
			f4_arg0.layerNumber:setLeftRight(0, 0, 32, 76)
			f4_arg0.layerNumber:setTopBottom(-0, 1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.layerNumber)
		end,
	},
	NoGroupSelected = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.topbar:completeAnimation()
			f5_arg0.topbar:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.topbar)
			f5_arg0.layerNumber:completeAnimation()
			f5_arg0.layerNumber:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.layerNumber)
			f5_arg0.groupIcon:completeAnimation()
			f5_arg0.groupIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.groupIcon)
		end,
	},
}
