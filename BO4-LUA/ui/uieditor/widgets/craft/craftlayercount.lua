CoD.CraftLayerCount = InheritFrom(LUI.UIElement)
CoD.CraftLayerCount.__defaultWidth = 80
CoD.CraftLayerCount.__defaultHeight = 30
CoD.CraftLayerCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftLayerCount)
	self.id = "CraftLayerCount"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local layerNumber = LUI.UIText.new(0, 0, 30, 80, 0, 1.02, 0, 0)
	layerNumber:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_76D1701FCBBE8ED8"))
	layerNumber:setTTF("ttmussels_demibold")
	layerNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(layerNumber)
	self.layerNumber = layerNumber
	local groupIcon = LUI.UIImage.new(0, 0, 0, 30, 0.5, 0.5, -15, 15)
	groupIcon:setImage(RegisterImage(@"uie_t7_menu_emblem_group"))
	self:addElement(groupIcon)
	self.groupIcon = groupIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftLayerCount.__resetProperties = function(f2_arg0)
	f2_arg0.groupIcon:completeAnimation()
	f2_arg0.layerNumber:completeAnimation()
	f2_arg0.groupIcon:setAlpha(1)
	f2_arg0.layerNumber:setRGB(1, 1, 1)
	f2_arg0.layerNumber:setAlpha(1)
end
CoD.CraftLayerCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.layerNumber:completeAnimation()
			f4_arg0.layerNumber:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.layerNumber)
			f4_arg0.groupIcon:completeAnimation()
			f4_arg0.groupIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.groupIcon)
		end,
	},
	Error = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.layerNumber:completeAnimation()
			f5_arg0.layerNumber:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
			f5_arg0.clipFinished(f5_arg0.layerNumber)
		end,
	},
}
