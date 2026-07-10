require("x64:df74eb6f7a902b4")
CoD.TabletIcePickGadget_Item = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_Item.__defaultWidth = 144
CoD.TabletIcePickGadget_Item.__defaultHeight = 144
CoD.TabletIcePickGadget_Item.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_Item)
	self.id = "TabletIcePickGadget_Item"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayersBg = LUI.UIImage.new(0, 0, 0, 144, 0, 0, 0, 144)
	PlayersBg:setAlpha(0.2)
	PlayersBg:setImage(RegisterImage(@"hash_2816694178B99B8A"))
	PlayersBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PlayersBg:setShaderVector(0, 0, 0, 0, 0)
	PlayersBg:setupNineSliceShader(72, 72)
	self:addElement(PlayersBg)
	self.PlayersBg = PlayersBg
	local sizeElement = CoD.TabletIcePickGadget_ItemBlock.new(f1_arg0, f1_arg1, 0, 0, 0, 144, 0, 0, 0, 144)
	sizeElement:linkToElementModel(self, nil, false, function(model)
		sizeElement:setModel(model, f1_arg1)
	end)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	self:mergeStateConditions({
		{
			stateName = "DoubleWidth",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "hackableDoubleWidth", 0)
			end,
		},
	})
	self:linkToElementModel(self, "hackableDoubleWidth", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hackableDoubleWidth",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_Item.__resetProperties = function(f5_arg0)
	f5_arg0.sizeElement:completeAnimation()
	f5_arg0.PlayersBg:completeAnimation()
	f5_arg0.sizeElement:setLeftRight(0, 0, 0, 144)
	f5_arg0.PlayersBg:setLeftRight(0, 0, 0, 144)
end
CoD.TabletIcePickGadget_Item.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	DoubleWidth = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.PlayersBg:completeAnimation()
			f7_arg0.PlayersBg:setLeftRight(0, 0, 0, 288)
			f7_arg0.clipFinished(f7_arg0.PlayersBg)
			f7_arg0.sizeElement:completeAnimation()
			f7_arg0.sizeElement:setLeftRight(0, 0, 0, 288)
			f7_arg0.clipFinished(f7_arg0.sizeElement)
		end,
	},
}
CoD.TabletIcePickGadget_Item.__onClose = function(f8_arg0)
	f8_arg0.sizeElement:close()
end
