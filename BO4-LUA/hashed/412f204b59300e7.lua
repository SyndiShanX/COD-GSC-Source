require("x64:f76d24ca4263dc4")
CoD.EmptyStreamItem = InheritFrom(LUI.UIElement)
CoD.EmptyStreamItem.__defaultWidth = 140
CoD.EmptyStreamItem.__defaultHeight = 158
CoD.EmptyStreamItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmptyStreamItem)
	self.id = "EmptyStreamItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local EmptyBox = CoD.ContractItemEmpty.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	EmptyBox:setRGB(0.24, 0.24, 0.24)
	EmptyBox:setAlpha(0.2)
	self:addElement(EmptyBox)
	self.EmptyBox = EmptyBox
	local Hash02 = LUI.UIImage.new(0, 0, 121, 138, 0, 0, 143.5, 149.5)
	Hash02:setAlpha(0.4)
	Hash02:setZRot(135)
	Hash02:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	Hash02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Hash02:setShaderVector(0, 0, 0, 0, 0)
	Hash02:setupNineSliceShader(120, 10)
	self:addElement(Hash02)
	self.Hash02 = Hash02
	local Hash03 = LUI.UIImage.new(0, 0, 120, 137, 0, 0, 6.5, 12.5)
	Hash03:setAlpha(0.4)
	Hash03:setZRot(225)
	Hash03:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	Hash03:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Hash03:setShaderVector(0, 0, 0, 0, 0)
	Hash03:setupNineSliceShader(120, 10)
	self:addElement(Hash03)
	self.Hash03 = Hash03
	local Hash04 = LUI.UIImage.new(0, 0, 1, 18, 0, 0, 7.5, 13.5)
	Hash04:setAlpha(0.4)
	Hash04:setZRot(315)
	Hash04:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	Hash04:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Hash04:setShaderVector(0, 0, 0, 0, 0)
	Hash04:setupNineSliceShader(120, 10)
	self:addElement(Hash04)
	self.Hash04 = Hash04
	local Hash01 = LUI.UIImage.new(0, 0, 3, 20, 0, 0, 145, 151)
	Hash01:setAlpha(0.4)
	Hash01:setZRot(45)
	Hash01:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	Hash01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Hash01:setShaderVector(0, 0, 0, 0, 0)
	Hash01:setupNineSliceShader(120, 10)
	self:addElement(Hash01)
	self.Hash01 = Hash01
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "gap")
			end,
		},
	})
	self:linkToElementModel(self, "gap", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gap",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmptyStreamItem.__resetProperties = function(f4_arg0)
	f4_arg0.Hash01:completeAnimation()
	f4_arg0.Hash04:completeAnimation()
	f4_arg0.Hash03:completeAnimation()
	f4_arg0.Hash02:completeAnimation()
	f4_arg0.EmptyBox:completeAnimation()
	f4_arg0.Blur:completeAnimation()
	f4_arg0.Hash01:setLeftRight(0, 0, 3, 20)
	f4_arg0.Hash01:setTopBottom(0, 0, 145, 151)
	f4_arg0.Hash01:setAlpha(0.4)
	f4_arg0.Hash04:setLeftRight(0, 0, 1, 18)
	f4_arg0.Hash04:setTopBottom(0, 0, 7.5, 13.5)
	f4_arg0.Hash04:setAlpha(0.4)
	f4_arg0.Hash03:setLeftRight(0, 0, 120, 137)
	f4_arg0.Hash03:setTopBottom(0, 0, 6.5, 12.5)
	f4_arg0.Hash03:setAlpha(0.4)
	f4_arg0.Hash02:setLeftRight(0, 0, 121, 138)
	f4_arg0.Hash02:setTopBottom(0, 0, 143.5, 149.5)
	f4_arg0.Hash02:setAlpha(0.4)
	f4_arg0.EmptyBox:setAlpha(0.2)
	f4_arg0.Blur:setAlpha(1)
end
CoD.EmptyStreamItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
			f5_arg0.Blur:completeAnimation()
			f5_arg0.Blur:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Blur)
			f5_arg0.EmptyBox:completeAnimation()
			f5_arg0.EmptyBox:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.EmptyBox)
			f5_arg0.Hash02:completeAnimation()
			f5_arg0.Hash02:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Hash02)
			f5_arg0.Hash03:completeAnimation()
			f5_arg0.Hash03:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Hash03)
			f5_arg0.Hash04:completeAnimation()
			f5_arg0.Hash04:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Hash04)
			f5_arg0.Hash01:completeAnimation()
			f5_arg0.Hash01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Hash01)
		end,
	},
	Empty = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(6)
			f6_arg0.Blur:completeAnimation()
			f6_arg0.Blur:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Blur)
			f6_arg0.EmptyBox:completeAnimation()
			f6_arg0.EmptyBox:setAlpha(0.2)
			f6_arg0.clipFinished(f6_arg0.EmptyBox)
			f6_arg0.Hash02:completeAnimation()
			f6_arg0.Hash02:setLeftRight(0, 0, 122, 139)
			f6_arg0.Hash02:setTopBottom(0, 0, 143.5, 149.5)
			f6_arg0.Hash02:setAlpha(0.35)
			f6_arg0.clipFinished(f6_arg0.Hash02)
			f6_arg0.Hash03:completeAnimation()
			f6_arg0.Hash03:setLeftRight(0, 0, 120, 137)
			f6_arg0.Hash03:setTopBottom(0, 0, 7.5, 13.5)
			f6_arg0.Hash03:setAlpha(0.35)
			f6_arg0.clipFinished(f6_arg0.Hash03)
			f6_arg0.Hash04:completeAnimation()
			f6_arg0.Hash04:setLeftRight(0, 0, 2, 19)
			f6_arg0.Hash04:setTopBottom(0, 0, 8.5, 14.5)
			f6_arg0.Hash04:setAlpha(0.35)
			f6_arg0.clipFinished(f6_arg0.Hash04)
			f6_arg0.Hash01:completeAnimation()
			f6_arg0.Hash01:setLeftRight(0, 0, 3, 20)
			f6_arg0.Hash01:setTopBottom(0, 0, 145, 151)
			f6_arg0.Hash01:setAlpha(0.35)
			f6_arg0.clipFinished(f6_arg0.Hash01)
		end,
	},
}
CoD.EmptyStreamItem.__onClose = function(f7_arg0)
	f7_arg0.EmptyBox:close()
end
