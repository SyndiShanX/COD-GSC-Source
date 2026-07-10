require("x64:6ab7d3b958bb572")
CoD.WeaponBribeItem = InheritFrom(LUI.UIElement)
CoD.WeaponBribeItem.__defaultWidth = 274
CoD.WeaponBribeItem.__defaultHeight = 126
CoD.WeaponBribeItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "weaponSelectItemIndex", 0)
	self:setClass(CoD.WeaponBribeItem)
	self.id = "WeaponBribeItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponBribeItemInternal = CoD.WeaponBribeItemInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 126)
	WeaponBribeItemInternal:linkToElementModel(self, nil, false, function(model)
		WeaponBribeItemInternal:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponBribeItemInternal)
	self.WeaponBribeItemInternal = WeaponBribeItemInternal
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	WeaponBribeItemInternal.id = "WeaponBribeItemInternal"
	self.__defaultFocus = WeaponBribeItemInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponBribeItem.__resetProperties = function(f4_arg0)
	f4_arg0.WeaponBribeItemInternal:completeAnimation()
	f4_arg0.WeaponBribeItemInternal:setScale(1, 1)
end
CoD.WeaponBribeItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.WeaponBribeItemInternal:completeAnimation()
			f6_arg0.WeaponBribeItemInternal:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.WeaponBribeItemInternal)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.WeaponBribeItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.WeaponBribeItemInternal:setScale(1.05, 1.05)
				f7_arg0.WeaponBribeItemInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.WeaponBribeItemInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.WeaponBribeItemInternal:completeAnimation()
			f7_arg0.WeaponBribeItemInternal:setScale(1, 1)
			f7_local0(f7_arg0.WeaponBribeItemInternal)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.WeaponBribeItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f9_arg0.WeaponBribeItemInternal:setScale(1, 1)
				f9_arg0.WeaponBribeItemInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.WeaponBribeItemInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.WeaponBribeItemInternal:completeAnimation()
			f9_arg0.WeaponBribeItemInternal:setScale(1.05, 1.05)
			f9_local0(f9_arg0.WeaponBribeItemInternal)
		end,
	},
	PC = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WeaponBribeItem.__onClose = function(f12_arg0)
	f12_arg0.WeaponBribeItemInternal:close()
end
