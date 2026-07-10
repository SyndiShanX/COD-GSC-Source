require("x64:5d497c1e7ee7ebe")
CoD.WarzoneInventoryAmmoItem = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryAmmoItem.__defaultWidth = 92
CoD.WarzoneInventoryAmmoItem.__defaultHeight = 90
CoD.WarzoneInventoryAmmoItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryAmmoItem)
	self.id = "WarzoneInventoryAmmoItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local internal = CoD.WarzoneInventoryMenuItemSmall_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 46, 0.5, 0.5, -45, 45)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	local Cover = LUI.UIImage.new(0, 0, -1, 93, 0, 0, -1.5, 91.5)
	Cover:setRGB(0.15, 0.15, 0.13)
	Cover:setAlpha(0)
	Cover:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_frame_cover"))
	Cover:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Cover:setShaderVector(0, 0, 0, 0, 0)
	Cover:setupNineSliceShader(20, 20)
	self:addElement(Cover)
	self.Cover = Cover
	local Name = LUI.UIText.new(0, 0, 6, 86, 0, 0, 4.5, 22.5)
	Name:setRGB(0.75, 0.75, 0.75)
	Name:setTTF("ttmussels_regular")
	Name:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Name:setShaderVector(0, 1, 0, 0, 0)
	Name:setShaderVector(1, 0, 0, 0, 0)
	Name:setShaderVector(2, 0, 0, 0, 0.7)
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "stackCount", 0)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	self:linkToElementModel(self, "stackCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryAmmoItem.__resetProperties = function(f8_arg0)
	f8_arg0.internal:completeAnimation()
	f8_arg0.Name:completeAnimation()
	f8_arg0.Cover:completeAnimation()
	f8_arg0.internal:setScale(1, 1)
	f8_arg0.internal.InventoryIcon:setRGB(1, 1, 1)
	f8_arg0.internal.InventoryIcon:setShaderVector(0, 1, 0, 0, 0)
	f8_arg0.Name:setLeftRight(0, 0, 6, 86)
	f8_arg0.Name:setTopBottom(0, 0, 4.5, 22.5)
	f8_arg0.Name:setRGB(0.75, 0.75, 0.75)
	f8_arg0.Cover:setAlpha(0)
end
CoD.WarzoneInventoryAmmoItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.internal:completeAnimation()
			f9_arg0.clipFinished(f9_arg0.internal)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.internal:completeAnimation()
			f10_arg0.internal:setScale(1.08, 1.08)
			f10_arg0.clipFinished(f10_arg0.internal)
			f10_arg0.Name:completeAnimation()
			f10_arg0.Name:setLeftRight(0, 0, 3, 91)
			f10_arg0.Name:setTopBottom(0, 0, 1.5, 19.5)
			f10_arg0.clipFinished(f10_arg0.Name)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.internal:beginAnimation(140)
				f11_arg0.internal:setScale(1.08, 1.08)
				f11_arg0.internal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.internal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.internal:completeAnimation()
			f11_arg0.internal:setScale(1, 1)
			f11_local0(f11_arg0.internal)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Name:beginAnimation(140)
				f11_arg0.Name:setLeftRight(0, 0, 3, 83)
				f11_arg0.Name:setTopBottom(0, 0, 1.5, 19.5)
				f11_arg0.Name:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Name:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Name:completeAnimation()
			f11_arg0.Name:setLeftRight(0, 0, 6, 94)
			f11_arg0.Name:setTopBottom(0, 0, 4.5, 22.5)
			f11_local1(f11_arg0.Name)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.internal:beginAnimation(140)
				f14_arg0.internal:setScale(1, 1)
				f14_arg0.internal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.internal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.internal:completeAnimation()
			f14_arg0.internal:setScale(1.08, 1.08)
			f14_local0(f14_arg0.internal)
			local f14_local1 = function(f16_arg0)
				f14_arg0.Name:beginAnimation(140)
				f14_arg0.Name:setLeftRight(0, 0, 6, 86)
				f14_arg0.Name:setTopBottom(0, 0, 4.5, 22.5)
				f14_arg0.Name:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Name:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Name:completeAnimation()
			f14_arg0.Name:setLeftRight(0, 0, 3, 91)
			f14_arg0.Name:setTopBottom(0, 0, 1.5, 19.5)
			f14_local1(f14_arg0.Name)
		end,
	},
	Disabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.internal:completeAnimation()
			f17_arg0.internal.InventoryIcon:completeAnimation()
			f17_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f17_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f17_arg0.clipFinished(f17_arg0.internal)
			f17_arg0.Cover:completeAnimation()
			f17_arg0.Cover:setAlpha(0.88)
			f17_arg0.clipFinished(f17_arg0.Cover)
			f17_arg0.Name:completeAnimation()
			f17_arg0.Name:setRGB(0.38, 0.38, 0.36)
			f17_arg0.clipFinished(f17_arg0.Name)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.internal:completeAnimation()
			f18_arg0.internal.InventoryIcon:completeAnimation()
			f18_arg0.internal:setScale(1.08, 1.08)
			f18_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f18_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f18_arg0.clipFinished(f18_arg0.internal)
			f18_arg0.Name:completeAnimation()
			f18_arg0.Name:setLeftRight(0, 0, 3, 91)
			f18_arg0.Name:setTopBottom(0, 0, 1.5, 19.5)
			f18_arg0.clipFinished(f18_arg0.Name)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.internal:beginAnimation(140)
				f19_arg0.internal:setScale(1.08, 1.08)
				f19_arg0.internal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.internal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.internal:completeAnimation()
			f19_arg0.internal.InventoryIcon:completeAnimation()
			f19_arg0.internal:setScale(1, 1)
			f19_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f19_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f19_local0(f19_arg0.internal)
			local f19_local1 = function(f21_arg0)
				f19_arg0.Name:beginAnimation(140)
				f19_arg0.Name:setLeftRight(0, 0, 3, 83)
				f19_arg0.Name:setTopBottom(0, 0, 1.5, 19.5)
				f19_arg0.Name:setRGB(0.75, 0.75, 0.75)
				f19_arg0.Name:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Name:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Name:completeAnimation()
			f19_arg0.Name:setLeftRight(0, 0, 6, 94)
			f19_arg0.Name:setTopBottom(0, 0, 4.5, 22.5)
			f19_arg0.Name:setRGB(0.54, 0.53, 0.5)
			f19_local1(f19_arg0.Name)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.internal:beginAnimation(140)
				f22_arg0.internal:setScale(1, 1)
				f22_arg0.internal:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.internal:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.internal:completeAnimation()
			f22_arg0.internal.InventoryIcon:completeAnimation()
			f22_arg0.internal:setScale(1.08, 1.08)
			f22_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f22_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f22_local0(f22_arg0.internal)
			local f22_local1 = function(f24_arg0)
				f22_arg0.Name:beginAnimation(140)
				f22_arg0.Name:setLeftRight(0, 0, 6, 86)
				f22_arg0.Name:setTopBottom(0, 0, 4.5, 22.5)
				f22_arg0.Name:setRGB(0.54, 0.53, 0.5)
				f22_arg0.Name:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Name:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Name:completeAnimation()
			f22_arg0.Name:setLeftRight(0, 0, 3, 91)
			f22_arg0.Name:setTopBottom(0, 0, 1.5, 19.5)
			f22_arg0.Name:setRGB(0.75, 0.75, 0.75)
			f22_local1(f22_arg0.Name)
		end,
	},
	Empty = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.internal:completeAnimation()
			f25_arg0.internal.InventoryIcon:completeAnimation()
			f25_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f25_arg0.clipFinished(f25_arg0.internal)
			f25_arg0.Cover:completeAnimation()
			f25_arg0.Cover:setAlpha(0.88)
			f25_arg0.clipFinished(f25_arg0.Cover)
			f25_arg0.Name:completeAnimation()
			f25_arg0.Name:setRGB(0.38, 0.38, 0.36)
			f25_arg0.clipFinished(f25_arg0.Name)
		end,
	},
}
CoD.WarzoneInventoryAmmoItem.__onClose = function(f26_arg0)
	f26_arg0.internal:close()
	f26_arg0.Name:close()
end
