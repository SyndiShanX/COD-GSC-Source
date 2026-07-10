require("x64:5f8cf56752aa71b")
require("x64:1a4e34b4805b325")
CoD.PrestigeAttachmentSlot = InheritFrom(LUI.UIElement)
CoD.PrestigeAttachmentSlot.__defaultWidth = 100
CoD.PrestigeAttachmentSlot.__defaultHeight = 60
CoD.PrestigeAttachmentSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrestigeAttachmentSlot)
	self.id = "PrestigeAttachmentSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonButtonOutlineLocked = CoD.CommonButtonOutlineLocked.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutlineLocked:setAlpha(0)
	self:addElement(CommonButtonOutlineLocked)
	self.CommonButtonOutlineLocked = CommonButtonOutlineLocked
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local Image = LUI.UIImage.new(0, 0, 30.5, 69.5, 0, 0, 3, 42)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local name = LUI.UIText.new(0, 0, 0, 100, 0, 0, 45, 60)
	name:setTTF("ttmussels_demibold")
	name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	name:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			name:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(name)
	self.name = name
	local LockedIcon = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	LockedIcon:setAlpha(0)
	LockedIcon:setImage(RegisterImage(0xB8AD8D12CEB707D))
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(0xCE50842B84CCD5D))
	self:addElement(Backing)
	self.Backing = Backing
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -36, 8, 0, 0, -7, 37)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(0x9A8B26C9B001758))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -36, 8, 0, 0, -7, 37)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(0x7AF532D84DE505A))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped(menu, self, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	CommonButtonOutlineLocked.id = "CommonButtonOutlineLocked"
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PrestigeAttachmentSlot.__resetProperties = function(f7_arg0)
	f7_arg0.Image:completeAnimation()
	f7_arg0.Backing:completeAnimation()
	f7_arg0.LockedIcon:completeAnimation()
	f7_arg0.name:completeAnimation()
	f7_arg0.EquippedMarkerBG:completeAnimation()
	f7_arg0.EquippedMarkerTick:completeAnimation()
	f7_arg0.Image:setAlpha(1)
	f7_arg0.Image:setScale(1, 1)
	f7_arg0.Backing:setAlpha(0)
	f7_arg0.LockedIcon:setAlpha(0)
	f7_arg0.name:setAlpha(1)
	f7_arg0.EquippedMarkerBG:setAlpha(0)
	f7_arg0.EquippedMarkerTick:setAlpha(0)
end
CoD.PrestigeAttachmentSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setScale(1.1, 1.1)
			f9_arg0.clipFinished(f9_arg0.Image)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Image:beginAnimation(200)
				f10_arg0.Image:setScale(1.1, 1.1)
				f10_arg0.Image:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Image:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setScale(1, 1)
			f10_local0(f10_arg0.Image)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Image:beginAnimation(200)
				f12_arg0.Image:setScale(1, 1)
				f12_arg0.Image:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Image:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setScale(1.1, 1.1)
			f12_local0(f12_arg0.Image)
		end,
	},
	Locked = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.Image:completeAnimation()
			f14_arg0.Image:setAlpha(0.25)
			f14_arg0.clipFinished(f14_arg0.Image)
			f14_arg0.name:completeAnimation()
			f14_arg0.name:setAlpha(0.25)
			f14_arg0.clipFinished(f14_arg0.name)
			f14_arg0.LockedIcon:completeAnimation()
			f14_arg0.LockedIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.LockedIcon)
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Backing)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.Image:completeAnimation()
			f15_arg0.Image:setAlpha(0.25)
			f15_arg0.Image:setScale(1.1, 1.1)
			f15_arg0.clipFinished(f15_arg0.Image)
			f15_arg0.name:completeAnimation()
			f15_arg0.name:setAlpha(0.25)
			f15_arg0.clipFinished(f15_arg0.name)
			f15_arg0.LockedIcon:completeAnimation()
			f15_arg0.LockedIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LockedIcon)
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.Backing)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Image:beginAnimation(200)
				f16_arg0.Image:setScale(1.1, 1.1)
				f16_arg0.Image:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Image:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Image:completeAnimation()
			f16_arg0.Image:setAlpha(0.25)
			f16_arg0.Image:setScale(1, 1)
			f16_local0(f16_arg0.Image)
			f16_arg0.name:completeAnimation()
			f16_arg0.name:setAlpha(0.25)
			f16_arg0.clipFinished(f16_arg0.name)
			f16_arg0.LockedIcon:completeAnimation()
			f16_arg0.LockedIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.LockedIcon)
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.Backing)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Image:beginAnimation(200)
				f18_arg0.Image:setScale(1, 1)
				f18_arg0.Image:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Image:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Image:completeAnimation()
			f18_arg0.Image:setAlpha(0.25)
			f18_arg0.Image:setScale(1.1, 1.1)
			f18_local0(f18_arg0.Image)
			f18_arg0.name:completeAnimation()
			f18_arg0.name:setAlpha(0.25)
			f18_arg0.clipFinished(f18_arg0.name)
			f18_arg0.LockedIcon:completeAnimation()
			f18_arg0.LockedIcon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.LockedIcon)
			f18_arg0.Backing:completeAnimation()
			f18_arg0.Backing:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Backing)
		end,
	},
	Equipped = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.EquippedMarkerTick:completeAnimation()
			f20_arg0.EquippedMarkerTick:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerTick)
			f20_arg0.EquippedMarkerBG:completeAnimation()
			f20_arg0.EquippedMarkerBG:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerBG)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.Image:completeAnimation()
			f21_arg0.Image:setScale(1.1, 1.1)
			f21_arg0.clipFinished(f21_arg0.Image)
			f21_arg0.EquippedMarkerTick:completeAnimation()
			f21_arg0.EquippedMarkerTick:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EquippedMarkerTick)
			f21_arg0.EquippedMarkerBG:completeAnimation()
			f21_arg0.EquippedMarkerBG:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EquippedMarkerBG)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.Image:beginAnimation(200)
				f22_arg0.Image:setScale(1.1, 1.1)
				f22_arg0.Image:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Image:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Image:completeAnimation()
			f22_arg0.Image:setScale(1, 1)
			f22_local0(f22_arg0.Image)
			f22_arg0.EquippedMarkerTick:completeAnimation()
			f22_arg0.EquippedMarkerTick:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.EquippedMarkerTick)
			f22_arg0.EquippedMarkerBG:completeAnimation()
			f22_arg0.EquippedMarkerBG:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.EquippedMarkerBG)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			local f24_local0 = function(f25_arg0)
				f24_arg0.Image:beginAnimation(200)
				f24_arg0.Image:setScale(1, 1)
				f24_arg0.Image:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Image:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.Image:completeAnimation()
			f24_arg0.Image:setScale(1.1, 1.1)
			f24_local0(f24_arg0.Image)
			f24_arg0.EquippedMarkerTick:completeAnimation()
			f24_arg0.EquippedMarkerTick:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.EquippedMarkerTick)
			f24_arg0.EquippedMarkerBG:completeAnimation()
			f24_arg0.EquippedMarkerBG:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.EquippedMarkerBG)
		end,
	},
}
CoD.PrestigeAttachmentSlot.__onClose = function(f26_arg0)
	f26_arg0.CommonButtonOutlineLocked:close()
	f26_arg0.CommonButtonOutline:close()
	f26_arg0.Image:close()
	f26_arg0.name:close()
end
