require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
require("x64:fd51e83e2e6dbd1")
require("x64:218890762b209b")
require("x64:99814ce8a424f57")
CoD.SpecialistOutfitEntry_Internal = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitEntry_Internal.__defaultWidth = 125
CoD.SpecialistOutfitEntry_Internal.__defaultHeight = 150
CoD.SpecialistOutfitEntry_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitEntry_Internal)
	self.id = "SpecialistOutfitEntry_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = CoD.SpecialistOutfitRowBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local ItemImage = CoD.SpecialistOutfitEntryIcon.new(f1_arg0, f1_arg1, 0, 0, 2, 123, 0, 0, 2, 148)
	ItemImage:linkToElementModel(self, nil, false, function(model)
		ItemImage:setModel(model, f1_arg1)
	end)
	self:addElement(ItemImage)
	self.ItemImage = ItemImage
	local LockedIcon = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	LockedIcon:setAlpha(0)
	LockedIcon:setScale(0.25, 0.25)
	LockedIcon:setImage(RegisterImage(@"uie_ui_icon_global_lock"))
	LockedIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	LockedIcon:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local EquippedMarkerTick = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -34, 10, 0, 0, -9, 35)
	EquippedMarkerTick:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, f1_arg1)
			end,
		},
	})
	local CommonButtonOutline = EquippedMarkerTick
	local BreadcrumbNew = EquippedMarkerTick.subscribeToModel
	local f1_local7 = DataSources.MPSpecialistThemes.getModel(f1_arg1)
	BreadcrumbNew(CommonButtonOutline, f1_local7.update, function(f4_arg0)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "update",
		})
	end, false)
	EquippedMarkerTick:linkToElementModel(EquippedMarkerTick, "itemIndex", true, function(model)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick.image:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	EquippedMarkerTick:linkToElementModel(self, nil, false, function(model)
		EquippedMarkerTick:setModel(model, f1_arg1)
	end)
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	CommonButtonOutline:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "owned")
			end,
		},
	})
	CommonButtonOutline:linkToElementModel(CommonButtonOutline, "owned", true, function(model)
		f1_arg0:updateElementState(CommonButtonOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	local f1_local8 = CommonButtonOutline
	f1_local7 = CommonButtonOutline.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local8, f1_local9["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(CommonButtonOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CommonButtonOutline.Lines:setAlpha(0)
	CommonButtonOutline.LineSolid:setAlpha(1)
	CommonButtonOutline:linkToElementModel(self, nil, false, function(model)
		CommonButtonOutline:setModel(model, f1_arg1)
	end)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "owned")
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsSpecialistOutfitItemNew(menu, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	self:linkToElementModel(self, "owned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	self:linkToElementModel(self, "presetIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "presetIndex",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitEntry_Internal.__resetProperties = function(f18_arg0)
	f18_arg0.EquippedMarkerTick:completeAnimation()
	f18_arg0.LockedIcon:completeAnimation()
	f18_arg0.BreadcrumbNew:completeAnimation()
	f18_arg0.EquippedMarkerTick:setAlpha(1)
	f18_arg0.LockedIcon:setAlpha(0)
	f18_arg0.BreadcrumbNew:setAlpha(0)
end
CoD.SpecialistOutfitEntry_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	Unavailable = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.EquippedMarkerTick:completeAnimation()
			f20_arg0.EquippedMarkerTick:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerTick)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.EquippedMarkerTick:completeAnimation()
			f21_arg0.EquippedMarkerTick:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.EquippedMarkerTick:completeAnimation()
			f22_arg0.EquippedMarkerTick:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.EquippedMarkerTick)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.EquippedMarkerTick:completeAnimation()
			f23_arg0.EquippedMarkerTick:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.EquippedMarkerTick)
		end,
	},
	Disabled = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.LockedIcon:completeAnimation()
			f24_arg0.LockedIcon:setAlpha(0.1)
			f24_arg0.clipFinished(f24_arg0.LockedIcon)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.LockedIcon:completeAnimation()
			f25_arg0.LockedIcon:setAlpha(0.1)
			f25_arg0.clipFinished(f25_arg0.LockedIcon)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.LockedIcon:completeAnimation()
			f26_arg0.LockedIcon:setAlpha(0.1)
			f26_arg0.clipFinished(f26_arg0.LockedIcon)
		end,
		LoseChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.LockedIcon:completeAnimation()
			f27_arg0.LockedIcon:setAlpha(0.1)
			f27_arg0.clipFinished(f27_arg0.LockedIcon)
		end,
	},
	New = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.BreadcrumbNew:completeAnimation()
			f28_arg0.BreadcrumbNew:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
					f31_arg0:setAlpha(0)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.BreadcrumbNew:beginAnimation(400)
				f29_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f29_arg0.BreadcrumbNew:completeAnimation()
			f29_arg0.BreadcrumbNew:setAlpha(1)
			f29_local0(f29_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.BreadcrumbNew:completeAnimation()
			f32_arg0.BreadcrumbNew:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.BreadcrumbNew:completeAnimation()
			f33_arg0.BreadcrumbNew:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.BreadcrumbNew)
		end,
	},
}
CoD.SpecialistOutfitEntry_Internal.__onClose = function(f34_arg0)
	f34_arg0.backing:close()
	f34_arg0.ItemImage:close()
	f34_arg0.EquippedMarkerTick:close()
	f34_arg0.BreadcrumbNew:close()
	f34_arg0.CommonButtonOutline:close()
end
