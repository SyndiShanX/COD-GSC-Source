require("x64:1cbc21606fc4149")
require("x64:1c3ea9f0ec2f9b6")
CoD.DirectorZMTutorialSelectItem = InheritFrom(LUI.UIElement)
CoD.DirectorZMTutorialSelectItem.__defaultWidth = 512
CoD.DirectorZMTutorialSelectItem.__defaultHeight = 476
CoD.DirectorZMTutorialSelectItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMTutorialSelectItem)
	self.id = "DirectorZMTutorialSelectItem"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorPlaylistOptionaInternal = CoD.DirectorPlaylistOptionInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorPlaylistOptionaInternal.MiddleText:setText(LocalizeToUpperString(@"hash_A43B10D9DA121A"))
	DirectorPlaylistOptionaInternal.GamemodeIcon:setAlpha(0)
	DirectorPlaylistOptionaInternal.PlaylistImage:setAlpha(1)
	DirectorPlaylistOptionaInternal.DoubleXPCardIconsLeftAligned:setAlpha(0)
	DirectorPlaylistOptionaInternal.GameModeText:setTTF("skorzhen")
	DirectorPlaylistOptionaInternal:linkToElementModel(self, nil, false, function(model)
		DirectorPlaylistOptionaInternal:setModel(model, f1_arg1)
	end)
	DirectorPlaylistOptionaInternal:linkToElementModel(self, "descriptionText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorPlaylistOptionaInternal.GameModeDescription:setText(f3_local0)
		end
	end)
	self:addElement(DirectorPlaylistOptionaInternal)
	self.DirectorPlaylistOptionaInternal = DirectorPlaylistOptionaInternal
	local equippedIcon = CoD.ZMPlaylistSelected.new(f1_arg0, f1_arg1, 1, 1, -23, -6, 0, 0, 6, 22)
	equippedIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsZombies() and CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(self, "lobbyRoot.playlistId", "playlistID")
			end,
		},
	})
	local f1_local3 = equippedIcon
	local f1_local4 = equippedIcon.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(equippedIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = equippedIcon
	f1_local4 = equippedIcon.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.playlistId"], function(f6_arg0)
		f1_arg0:updateElementState(equippedIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.playlistId",
		})
	end, false)
	equippedIcon:linkToElementModel(equippedIcon, "playlistID", true, function(model)
		f1_arg0:updateElementState(equippedIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "playlistID",
		})
	end)
	equippedIcon:linkToElementModel(self, nil, false, function(model)
		equippedIcon:setModel(model, f1_arg1)
	end)
	self:addElement(equippedIcon)
	self.equippedIcon = equippedIcon
	self:mergeStateConditions({
		{
			stateName = "Featured",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "featured")
			end,
		},
	})
	self:linkToElementModel(self, "featured", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featured",
		})
	end)
	DirectorPlaylistOptionaInternal.id = "DirectorPlaylistOptionaInternal"
	self.__defaultFocus = DirectorPlaylistOptionaInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorZMTutorialSelectItem.__resetProperties = function(f11_arg0)
	f11_arg0.equippedIcon:completeAnimation()
	f11_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
	f11_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
	f11_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
	f11_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 1, 0, 0)
	f11_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
end
CoD.DirectorZMTutorialSelectItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.equippedIcon:completeAnimation()
			f12_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
			f12_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
			f12_arg0.clipFinished(f12_arg0.equippedIcon)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f13_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f13_arg0.clipFinished(f13_arg0.DirectorPlaylistOptionaInternal)
			f13_arg0.equippedIcon:completeAnimation()
			f13_arg0.equippedIcon:setLeftRight(1, 1, -10, 7)
			f13_arg0.equippedIcon:setTopBottom(0, 0, -6, 10)
			f13_arg0.clipFinished(f13_arg0.equippedIcon)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
				f14_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f14_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
			f14_local0(f14_arg0.DirectorPlaylistOptionaInternal)
			local f14_local1 = function(f16_arg0)
				f14_arg0.equippedIcon:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.equippedIcon:setLeftRight(1, 1, -10, 7)
				f14_arg0.equippedIcon:setTopBottom(0, 0, -6, 10)
				f14_arg0.equippedIcon:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.equippedIcon:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.equippedIcon:completeAnimation()
			f14_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
			f14_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
			f14_local1(f14_arg0.equippedIcon)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f17_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
				f17_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f17_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f17_local0(f17_arg0.DirectorPlaylistOptionaInternal)
			local f17_local1 = function(f19_arg0)
				f17_arg0.equippedIcon:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f17_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
				f17_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
				f17_arg0.equippedIcon:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.equippedIcon:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.equippedIcon:completeAnimation()
			f17_arg0.equippedIcon:setLeftRight(1, 1, -10, 7)
			f17_arg0.equippedIcon:setTopBottom(0, 0, -6, 10)
			f17_local1(f17_arg0.equippedIcon)
		end,
	},
	Featured = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f20_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 476)
			f20_arg0.clipFinished(f20_arg0.DirectorPlaylistOptionaInternal)
			f20_arg0.equippedIcon:completeAnimation()
			f20_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
			f20_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
			f20_arg0.clipFinished(f20_arg0.equippedIcon)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f21_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 476)
			f21_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.DirectorPlaylistOptionaInternal)
			f21_arg0.equippedIcon:completeAnimation()
			f21_arg0.equippedIcon:setLeftRight(1, 1, -10, 7)
			f21_arg0.equippedIcon:setTopBottom(0, 0, -6, 10)
			f21_arg0.clipFinished(f21_arg0.equippedIcon)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f22_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
				f22_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f22_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 476)
			f22_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
			f22_local0(f22_arg0.DirectorPlaylistOptionaInternal)
			local f22_local1 = function(f24_arg0)
				f22_arg0.equippedIcon:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f22_arg0.equippedIcon:setLeftRight(1, 1, -10, 7)
				f22_arg0.equippedIcon:setTopBottom(0, 0, -6, 10)
				f22_arg0.equippedIcon:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.equippedIcon:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.equippedIcon:completeAnimation()
			f22_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
			f22_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
			f22_local1(f22_arg0.equippedIcon)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.DirectorPlaylistOptionaInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f25_arg0.DirectorPlaylistOptionaInternal:setScale(1, 1)
				f25_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DirectorPlaylistOptionaInternal:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.DirectorPlaylistOptionaInternal:completeAnimation()
			f25_arg0.DirectorPlaylistOptionaInternal:setTopBottom(0, 0, 0, 476)
			f25_arg0.DirectorPlaylistOptionaInternal:setScale(1.05, 1.05)
			f25_local0(f25_arg0.DirectorPlaylistOptionaInternal)
			local f25_local1 = function(f27_arg0)
				f25_arg0.equippedIcon:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f25_arg0.equippedIcon:setLeftRight(1, 1, -23, -6)
				f25_arg0.equippedIcon:setTopBottom(0, 0, 6, 22)
				f25_arg0.equippedIcon:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.equippedIcon:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.equippedIcon:completeAnimation()
			f25_arg0.equippedIcon:setLeftRight(1, 1, -10, 7)
			f25_arg0.equippedIcon:setTopBottom(0, 0, -6, 10)
			f25_local1(f25_arg0.equippedIcon)
		end,
	},
}
CoD.DirectorZMTutorialSelectItem.__onClose = function(f28_arg0)
	f28_arg0.DirectorPlaylistOptionaInternal:close()
	f28_arg0.equippedIcon:close()
end
