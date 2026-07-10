CoD.WarzoneInventoryEquipped = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryEquipped.__defaultWidth = 90
CoD.WarzoneInventoryEquipped.__defaultHeight = 90
CoD.WarzoneInventoryEquipped.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryEquipped)
	self.id = "WarzoneInventoryEquipped"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local Arrow01 = LUI.UIImage.new(0, 0, 1, 89, 0, 0, 0, 88)
	Arrow01:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_inventory_widget_equipped_icon"))
	Arrow01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Arrow01)
	self.Arrow01 = Arrow01
	self:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "equipped", 1)
			end,
		},
	})
	self:linkToElementModel(self, "equipped", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "equipped",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryEquipped.__resetProperties = function(f4_arg0)
	f4_arg0.Arrow01:completeAnimation()
	f4_arg0.Backing:completeAnimation()
	f4_arg0.Arrow01:setAlpha(1)
	f4_arg0.Backing:setAlpha(0)
end
CoD.WarzoneInventoryEquipped.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Backing:completeAnimation()
			f5_arg0.Backing:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Backing)
			f5_arg0.Arrow01:completeAnimation()
			f5_arg0.Arrow01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Arrow01)
		end,
	},
	Equipped = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
