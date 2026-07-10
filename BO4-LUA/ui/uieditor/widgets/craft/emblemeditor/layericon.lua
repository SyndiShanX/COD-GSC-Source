require("x64:8babac3499fee73")
require("x64:2197bee85183273")
CoD.LayerIcon = InheritFrom(LUI.UIElement)
CoD.LayerIcon.__defaultWidth = 180
CoD.LayerIcon.__defaultHeight = 180
CoD.LayerIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LayerIcon)
	self.id = "LayerIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local layerIcon = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	layerIcon:setScale(0.9, 0.9)
	layerIcon.__DrawLayerDecal = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			layerIcon:setupDrawEmblemLayer(GetEmblemLayerAndGroupIndex(f1_arg1, f2_local0))
		end
	end
	layerIcon:linkToElementModel(self, "layerAndGroupIndex", true, layerIcon.__DrawLayerDecal)
	layerIcon.__DrawLayerDecal_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.layerAndGroupIndex
		end
		if f3_local0 then
			layerIcon.__DrawLayerDecal(f3_local0)
		end
	end
	self:addElement(layerIcon)
	self.layerIcon = layerIcon
	local emptyLayerIcon = LUI.UIImage.new(0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	emptyLayerIcon:setAlpha(0)
	emptyLayerIcon:setImage(RegisterImage(@"uie_ui_menu_common_add_plus"))
	emptyLayerIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	emptyLayerIcon:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(emptyLayerIcon)
	self.emptyLayerIcon = emptyLayerIcon
	local linkIcon = CoD.EmblemChainIcon.new(f1_arg0, f1_arg1, 1, 1, -33, -9, 0, 0, 9, 33)
	linkIcon:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_IsLayerLinked(element, f1_arg1) and not CoD.CraftUtility.Emblem_IsLayerGrouped(element, f1_arg1)
			end,
		},
	})
	linkIcon:linkToElementModel(linkIcon, "isLinked", true, function(model)
		f1_arg0:updateElementState(linkIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLinked",
		})
	end)
	linkIcon:linkToElementModel(linkIcon, "isGrouped", true, function(model)
		f1_arg0:updateElementState(linkIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	linkIcon:linkToElementModel(self, nil, false, function(model)
		linkIcon:setModel(model, f1_arg1)
	end)
	self:addElement(linkIcon)
	self.linkIcon = linkIcon
	local emblemLayerNumber = CoD.EmblemLayerNumber.new(f1_arg0, f1_arg1, 0, 0, 9, 84, 0, 0, 9, 33)
	emblemLayerNumber:mergeStateConditions({
		{
			stateName = "GroupLayerNum",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_IsLayerLinked(element, f1_arg1) and CoD.CraftUtility.Emblem_IsLayerGrouped(element, f1_arg1)
			end,
		},
	})
	emblemLayerNumber:linkToElementModel(emblemLayerNumber, "isLinked", true, function(model)
		f1_arg0:updateElementState(emblemLayerNumber, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLinked",
		})
	end)
	emblemLayerNumber:linkToElementModel(emblemLayerNumber, "isGrouped", true, function(model)
		f1_arg0:updateElementState(emblemLayerNumber, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	emblemLayerNumber:linkToElementModel(self, nil, false, function(model)
		emblemLayerNumber:setModel(model, f1_arg1)
	end)
	self:addElement(emblemLayerNumber)
	self.emblemLayerNumber = emblemLayerNumber
	layerIcon:linkToElementModel(self, "iconID", true, layerIcon.__DrawLayerDecal_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LayerIcon.__resetProperties = function(f12_arg0)
	f12_arg0.layerIcon:completeAnimation()
	f12_arg0.emblemLayerNumber:completeAnimation()
	f12_arg0.linkIcon:completeAnimation()
	f12_arg0.emptyLayerIcon:completeAnimation()
	f12_arg0.layerIcon:setAlpha(1)
	f12_arg0.layerIcon:setScale(0.9, 0.9)
	f12_arg0.emblemLayerNumber:setLeftRight(0, 0, 9, 84)
	f12_arg0.emblemLayerNumber:setTopBottom(0, 0, 9, 33)
	f12_arg0.emblemLayerNumber:setAlpha(1)
	f12_arg0.linkIcon:setLeftRight(1, 1, -33, -9)
	f12_arg0.linkIcon:setTopBottom(0, 0, 9, 33)
	f12_arg0.linkIcon:setAlpha(1)
	f12_arg0.emptyLayerIcon:setLeftRight(0.5, 0.5, -24, 24)
	f12_arg0.emptyLayerIcon:setTopBottom(0.5, 0.5, -24, 24)
	f12_arg0.emptyLayerIcon:setAlpha(0)
end
CoD.LayerIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.layerIcon:completeAnimation()
			f13_arg0.layerIcon:setScale(0.8, 0.8)
			f13_arg0.clipFinished(f13_arg0.layerIcon)
			f13_arg0.linkIcon:completeAnimation()
			f13_arg0.linkIcon:setLeftRight(1, 1, -26, -2)
			f13_arg0.linkIcon:setTopBottom(0, 0, 6, 30)
			f13_arg0.clipFinished(f13_arg0.linkIcon)
			f13_arg0.emblemLayerNumber:completeAnimation()
			f13_arg0.emblemLayerNumber:setLeftRight(0, 0, 6.5, 81.5)
			f13_arg0.emblemLayerNumber:setTopBottom(0, 0, 4, 28)
			f13_arg0.clipFinished(f13_arg0.emblemLayerNumber)
		end,
	},
	EmptyLayer = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.layerIcon:completeAnimation()
			f14_arg0.layerIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.layerIcon)
			f14_arg0.emptyLayerIcon:completeAnimation()
			f14_arg0.emptyLayerIcon:setLeftRight(0.5, 0.5, -18, 18)
			f14_arg0.emptyLayerIcon:setTopBottom(0.5, 0.5, -18, 18)
			f14_arg0.emptyLayerIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.emptyLayerIcon)
			f14_arg0.linkIcon:completeAnimation()
			f14_arg0.linkIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.linkIcon)
			f14_arg0.emblemLayerNumber:completeAnimation()
			f14_arg0.emblemLayerNumber:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.emblemLayerNumber)
		end,
	},
}
CoD.LayerIcon.__onClose = function(f15_arg0)
	f15_arg0.layerIcon:close()
	f15_arg0.linkIcon:close()
	f15_arg0.emblemLayerNumber:close()
end
