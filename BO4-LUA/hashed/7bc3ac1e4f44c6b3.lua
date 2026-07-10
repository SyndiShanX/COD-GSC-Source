require("x64:621aef7b6879b4e")
CoD.ZMTalismanStatusButton = InheritFrom(LUI.UIElement)
CoD.ZMTalismanStatusButton.__defaultWidth = 90
CoD.ZMTalismanStatusButton.__defaultHeight = 90
CoD.ZMTalismanStatusButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanStatusButton)
	self.id = "ZMTalismanStatusButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerkDesc = LUI.UIText.new(0.5, 0.5, 56, 658, 0, 0, 90, 108)
	PerkDesc:setRGB(0.56, 0.56, 0.56)
	PerkDesc:setTTF("ttmussels_regular")
	PerkDesc:setLetterSpacing(6)
	PerkDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PerkDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PerkDesc:linkToElementModel(self, "detailedDesc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PerkDesc:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(PerkDesc)
	self.PerkDesc = PerkDesc
	local ElixirCount = CoD.ZMTalismanStatusButtonInternal.new(f1_arg0, f1_arg1, 0, 0, -63, 153, 0, 0, -63, 153)
	ElixirCount:linkToElementModel(self, nil, false, function(model)
		ElixirCount:setModel(model, f1_arg1)
	end)
	self:addElement(ElixirCount)
	self.ElixirCount = ElixirCount
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not IsLive()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ElixirCount.id = "ElixirCount"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanStatusButton.__resetProperties = function(f7_arg0)
	f7_arg0.ElixirCount:completeAnimation()
	f7_arg0.ElixirCount:setScale(1, 1)
end
CoD.ZMTalismanStatusButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ElixirCount:completeAnimation()
			f9_arg0.ElixirCount:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.ElixirCount)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f10_arg0.ElixirCount:setScale(1.05, 1.05)
				f10_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ElixirCount:completeAnimation()
			f10_arg0.ElixirCount:setScale(1, 1)
			f10_local0(f10_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ElixirCount:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f12_arg0.ElixirCount:setScale(1, 1)
				f12_arg0.ElixirCount:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ElixirCount:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ElixirCount:completeAnimation()
			f12_arg0.ElixirCount:setScale(1.05, 1.05)
			f12_local0(f12_arg0.ElixirCount)
		end,
	},
	Locked = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ZMTalismanStatusButton.__onClose = function(f15_arg0)
	f15_arg0.PerkDesc:close()
	f15_arg0.ElixirCount:close()
end
