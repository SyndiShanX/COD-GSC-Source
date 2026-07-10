require("x64:478f2bd71f935fd")
require("x64:8cf8d06bc6c9b28")
CoD.WarzoneInventoryMenuItemSmall_Internal = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryMenuItemSmall_Internal.__defaultWidth = 92
CoD.WarzoneInventoryMenuItemSmall_Internal.__defaultHeight = 90
CoD.WarzoneInventoryMenuItemSmall_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryMenuItemSmall_Internal)
	self.id = "WarzoneInventoryMenuItemSmall_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blurPC = nil
	blurPC = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	blurPC:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blurPC:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurPC)
	self.blurPC = blurPC
	local f1_local2 = nil
	self.Backing = LUI.UIElement.createFake()
	local BackingPC = nil
	BackingPC = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingPC:setRGB(0.04, 0.04, 0.04)
	BackingPC:setAlpha(0.7)
	self:addElement(BackingPC)
	self.BackingPC = BackingPC
	local InUseBacking = LUI.UIImage.new(0.5, 0.5, -48, 48, 0.5, 0.5, -47.5, 45.5)
	InUseBacking:setRGB(0.34, 0.32, 0.2)
	InUseBacking:setAlpha(0)
	InUseBacking:setImage(RegisterImage(0xF3974F8EE78598C))
	self:addElement(InUseBacking)
	self.InUseBacking = InUseBacking
	local TiledBacking = LUI.UIImage.new(0, 1, 1, 1, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local CurrentIndexQuickCycleArrow = nil
	CurrentIndexQuickCycleArrow = CoD.CurrentIndexQuickCycleArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 0, 0, -10.5, 21.5)
	CurrentIndexQuickCycleArrow:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = IsPC()
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(self, f1_arg1, "hudItems.inventory.quickConsumeNetworkId", "id")
					if f2_local0 then
						f2_local0 = not CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local FrameSelected = CurrentIndexQuickCycleArrow
	local ItemFrameAdd = CurrentIndexQuickCycleArrow.subscribeToModel
	local FrameSelectedCorner = Engine[0x4DF5CFBC1771947](f1_arg1)
	ItemFrameAdd(FrameSelected, FrameSelectedCorner["hudItems.inventory.quickConsumeNetworkId"], function(f4_arg0)
		f1_arg0:updateElementState(CurrentIndexQuickCycleArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.inventory.quickConsumeNetworkId",
		})
	end, false)
	CurrentIndexQuickCycleArrow:linkToElementModel(CurrentIndexQuickCycleArrow, "id", true, function(model)
		f1_arg0:updateElementState(CurrentIndexQuickCycleArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	CurrentIndexQuickCycleArrow:setRGB(0.68, 0.67, 0.62)
	self:addElement(CurrentIndexQuickCycleArrow)
	self.CurrentIndexQuickCycleArrow = CurrentIndexQuickCycleArrow
	ItemFrameAdd = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	ItemFrameAdd:setAlpha(0)
	ItemFrameAdd:setImage(RegisterImage(0xC2AE59F4FA74812))
	ItemFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ItemFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	ItemFrameAdd:setupNineSliceShader(12, 164)
	self:addElement(ItemFrameAdd)
	self.ItemFrameAdd = ItemFrameAdd
	FrameSelected = LUI.UIImage.new(0.07, 0.93, -10, 10, 0.07, 0.93, -10, 10)
	FrameSelected:setAlpha(0)
	FrameSelected:setScale(0.96, 0.96)
	FrameSelected:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrameSelected:setupNineSliceShader(4, 4)
	self:addElement(FrameSelected)
	self.FrameSelected = FrameSelected
	FrameSelectedCorner = LUI.UIImage.new(0.02, 0.98, -10, 10, 0.02, 0.98, -10, 10)
	FrameSelectedCorner:setAlpha(0)
	FrameSelectedCorner:setImage(RegisterImage(0x793C73633F620BB))
	FrameSelectedCorner:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameSelectedCorner:setShaderVector(0, 0, 0, 0, 0)
	FrameSelectedCorner:setupNineSliceShader(22, 22)
	self:addElement(FrameSelectedCorner)
	self.FrameSelectedCorner = FrameSelectedCorner
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local StackCount = CoD.WarzoneInventoryCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, 20, 40, 0.5, 0.5, 21, 41)
	StackCount:linkToElementModel(self, nil, false, function(model)
		StackCount:setModel(model, f1_arg1)
	end)
	StackCount:linkToElementModel(self, "stackCount", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StackCount.Counter:setText(f7_local0)
		end
	end)
	self:addElement(StackCount)
	self.StackCount = StackCount
	local InventoryIcon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -32.5, 32.5, 0.5, 0.5, -32.5, 32.5)
	InventoryIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	InventoryIcon:setShaderVector(0, 1, 0, 0, 0)
	InventoryIcon:linkToElementModel(self, "icon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			InventoryIcon:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(InventoryIcon)
	self.InventoryIcon = InventoryIcon
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryMenuItemSmall_Internal.__resetProperties = function(f11_arg0)
	f11_arg0.FrameSelectedCorner:completeAnimation()
	f11_arg0.FrameSelected:completeAnimation()
	f11_arg0.Backing:completeAnimation()
	f11_arg0.StackCount:completeAnimation()
	f11_arg0.FrontendFrame:completeAnimation()
	f11_arg0.InventoryIcon:completeAnimation()
	f11_arg0.CurrentIndexQuickCycleArrow:completeAnimation()
	f11_arg0.FrameSelectedCorner:setAlpha(0)
	f11_arg0.FrameSelectedCorner:setScale(1, 1)
	f11_arg0.FrameSelected:setAlpha(0)
	f11_arg0.Backing:setRGB(0.11, 0.11, 0.11)
	f11_arg0.Backing:setAlpha(0.9)
	f11_arg0.StackCount:setAlpha(1)
	f11_arg0.FrontendFrame:setAlpha(1)
	f11_arg0.InventoryIcon:setAlpha(1)
	f11_arg0.CurrentIndexQuickCycleArrow:setAlpha(1)
end
CoD.WarzoneInventoryMenuItemSmall_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.FrameSelectedCorner:completeAnimation()
			f12_arg0.FrameSelectedCorner:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.FrameSelectedCorner)
		end,
		Focus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f13_arg0.Backing:setAlpha(0.1)
			f13_arg0.clipFinished(f13_arg0.Backing)
			f13_arg0.FrameSelected:completeAnimation()
			f13_arg0.FrameSelected:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.FrameSelected)
			f13_arg0.FrameSelectedCorner:completeAnimation()
			f13_arg0.FrameSelectedCorner:setAlpha(1)
			f13_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f13_arg0.clipFinished(f13_arg0.FrameSelectedCorner)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.FrameSelected:completeAnimation()
			f14_arg0.FrameSelected:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.FrameSelected)
			f14_arg0.FrameSelectedCorner:completeAnimation()
			f14_arg0.FrameSelectedCorner:setAlpha(1)
			f14_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f14_arg0.clipFinished(f14_arg0.FrameSelectedCorner)
		end,
		GainFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Backing:beginAnimation(140)
				f15_arg0.Backing:setRGB(0.65, 0.64, 0.61)
				f15_arg0.Backing:setAlpha(0.1)
				f15_arg0.Backing:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Backing:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setRGB(0.11, 0.11, 0.11)
			f15_arg0.Backing:setAlpha(0.9)
			f15_local0(f15_arg0.Backing)
			local f15_local1 = function(f17_arg0)
				f15_arg0.FrameSelected:beginAnimation(140)
				f15_arg0.FrameSelected:setAlpha(1)
				f15_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FrameSelected:completeAnimation()
			f15_arg0.FrameSelected:setAlpha(0)
			f15_local1(f15_arg0.FrameSelected)
			local f15_local2 = function(f18_arg0)
				f15_arg0.FrameSelectedCorner:beginAnimation(140)
				f15_arg0.FrameSelectedCorner:setAlpha(1)
				f15_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
				f15_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FrameSelectedCorner:completeAnimation()
			f15_arg0.FrameSelectedCorner:setAlpha(0)
			f15_arg0.FrameSelectedCorner:setScale(1, 1)
			f15_local2(f15_arg0.FrameSelectedCorner)
		end,
		LoseFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.Backing:beginAnimation(140)
				f19_arg0.Backing:setRGB(0.11, 0.11, 0.11)
				f19_arg0.Backing:setAlpha(0.9)
				f19_arg0.Backing:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Backing:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setRGB(0.65, 0.64, 0.61)
			f19_arg0.Backing:setAlpha(0.1)
			f19_local0(f19_arg0.Backing)
			local f19_local1 = function(f21_arg0)
				f19_arg0.FrameSelected:beginAnimation(140)
				f19_arg0.FrameSelected:setAlpha(0)
				f19_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.FrameSelected:completeAnimation()
			f19_arg0.FrameSelected:setAlpha(1)
			f19_local1(f19_arg0.FrameSelected)
			local f19_local2 = function(f22_arg0)
				f19_arg0.FrameSelectedCorner:beginAnimation(140)
				f19_arg0.FrameSelectedCorner:setAlpha(0)
				f19_arg0.FrameSelectedCorner:setScale(1, 1)
				f19_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.FrameSelectedCorner:completeAnimation()
			f19_arg0.FrameSelectedCorner:setAlpha(1)
			f19_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f19_local2(f19_arg0.FrameSelectedCorner)
		end,
	},
	Empty = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.CurrentIndexQuickCycleArrow:completeAnimation()
			f23_arg0.CurrentIndexQuickCycleArrow:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CurrentIndexQuickCycleArrow)
			f23_arg0.FrontendFrame:completeAnimation()
			f23_arg0.FrontendFrame:setAlpha(0.1)
			f23_arg0.clipFinished(f23_arg0.FrontendFrame)
			f23_arg0.StackCount:completeAnimation()
			f23_arg0.StackCount:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.StackCount)
			f23_arg0.InventoryIcon:completeAnimation()
			f23_arg0.InventoryIcon:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.InventoryIcon)
		end,
		Focus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.FrameSelected:completeAnimation()
			f24_arg0.FrameSelected:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.FrameSelected)
			f24_arg0.FrameSelectedCorner:completeAnimation()
			f24_arg0.FrameSelectedCorner:setAlpha(1)
			f24_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f24_arg0.clipFinished(f24_arg0.FrameSelectedCorner)
			f24_arg0.StackCount:completeAnimation()
			f24_arg0.StackCount:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.StackCount)
			f24_arg0.InventoryIcon:completeAnimation()
			f24_arg0.InventoryIcon:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.InventoryIcon)
		end,
		GainFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			local f25_local0 = function(f26_arg0)
				f25_arg0.FrameSelected:beginAnimation(140)
				f25_arg0.FrameSelected:setAlpha(1)
				f25_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FrameSelected:completeAnimation()
			f25_arg0.FrameSelected:setAlpha(0)
			f25_local0(f25_arg0.FrameSelected)
			local f25_local1 = function(f27_arg0)
				f25_arg0.FrameSelectedCorner:beginAnimation(140)
				f25_arg0.FrameSelectedCorner:setAlpha(1)
				f25_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
				f25_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FrameSelectedCorner:completeAnimation()
			f25_arg0.FrameSelectedCorner:setAlpha(0)
			f25_arg0.FrameSelectedCorner:setScale(1, 1)
			f25_local1(f25_arg0.FrameSelectedCorner)
			local f25_local2 = function(f28_arg0)
				f25_arg0.FrontendFrame:beginAnimation(140)
				f25_arg0.FrontendFrame:setAlpha(1)
				f25_arg0.FrontendFrame:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FrontendFrame:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FrontendFrame:completeAnimation()
			f25_arg0.FrontendFrame:setAlpha(0.1)
			f25_local2(f25_arg0.FrontendFrame)
			f25_arg0.StackCount:completeAnimation()
			f25_arg0.StackCount:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.StackCount)
			f25_arg0.InventoryIcon:completeAnimation()
			f25_arg0.InventoryIcon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.InventoryIcon)
		end,
		LoseFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			local f29_local0 = function(f30_arg0)
				f29_arg0.FrameSelected:beginAnimation(140)
				f29_arg0.FrameSelected:setAlpha(0)
				f29_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.FrameSelected:completeAnimation()
			f29_arg0.FrameSelected:setAlpha(1)
			f29_local0(f29_arg0.FrameSelected)
			local f29_local1 = function(f31_arg0)
				f29_arg0.FrameSelectedCorner:beginAnimation(140)
				f29_arg0.FrameSelectedCorner:setAlpha(0)
				f29_arg0.FrameSelectedCorner:setScale(1, 1)
				f29_arg0.FrameSelectedCorner:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.FrameSelectedCorner:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.FrameSelectedCorner:completeAnimation()
			f29_arg0.FrameSelectedCorner:setAlpha(1)
			f29_arg0.FrameSelectedCorner:setScale(0.94, 0.94)
			f29_local1(f29_arg0.FrameSelectedCorner)
			local f29_local2 = function(f32_arg0)
				f29_arg0.FrontendFrame:beginAnimation(140)
				f29_arg0.FrontendFrame:setAlpha(0.1)
				f29_arg0.FrontendFrame:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.FrontendFrame:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.FrontendFrame:completeAnimation()
			f29_arg0.FrontendFrame:setAlpha(1)
			f29_local2(f29_arg0.FrontendFrame)
			f29_arg0.StackCount:completeAnimation()
			f29_arg0.StackCount:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.StackCount)
			f29_arg0.InventoryIcon:completeAnimation()
			f29_arg0.InventoryIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.InventoryIcon)
		end,
	},
}
if not CoD.isPC then
	CoD.WarzoneInventoryMenuItemSmall_Internal.__clipsPerState.DefaultState.Active = nil
end
CoD.WarzoneInventoryMenuItemSmall_Internal.__onClose = function(f33_arg0)
	f33_arg0.CurrentIndexQuickCycleArrow:close()
	f33_arg0.StackCount:close()
	f33_arg0.InventoryIcon:close()
end
