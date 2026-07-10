require("x64:18dc11de922fa85")
require("x64:dbf8e26e700cf9")
CoD.DirectorCustomGameCodCaster = InheritFrom(LUI.UIElement)
CoD.DirectorCustomGameCodCaster.__defaultWidth = 400
CoD.DirectorCustomGameCodCaster.__defaultHeight = 85
CoD.DirectorCustomGameCodCaster.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCustomGameCodCaster)
	self.id = "DirectorCustomGameCodCaster"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCODCasterMemberInfo = CoD.DirectorCODCasterMemberInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 85)
	DirectorCODCasterMemberInfo:linkToElementModel(self, nil, false, function(model)
		DirectorCODCasterMemberInfo:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorCODCasterMemberInfo)
	self.DirectorCODCasterMemberInfo = DirectorCODCasterMemberInfo
	local EmptyText = CoD.DirectorTeamMemberEmpty.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 85)
	EmptyText:setAlpha(0)
	EmptyText:linkToElementModel(self, nil, false, function(model)
		EmptyText:setModel(model, f1_arg1)
	end)
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	self:mergeStateConditions({
		{
			stateName = "FirstEmptyHighlighted",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "firstEmptyForTeam")
				if f4_local0 then
					if not CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedXuid", LuaDefine.INVALID_XUID_X64) and not CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "lobbyRoot.selectedXuidTeam", "team") then
						f4_local0 = IsGamepad(f1_arg1)
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "firstEmptyForTeam")
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xuid", Engine[0x9073FBE2D48C156]("0"))
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "lobbyRoot.selectedXuid", "xuid")
			end,
		},
	})
	self:linkToElementModel(self, "firstEmptyForTeam", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "firstEmptyForTeam",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.selectedXuid"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.selectedXuid",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.selectedXuidTeam"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.selectedXuidTeam",
		})
	end, false)
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f12_arg1)
	end)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	DirectorCODCasterMemberInfo.id = "DirectorCODCasterMemberInfo"
	EmptyText.id = "EmptyText"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCustomGameCodCaster.__resetProperties = function(f15_arg0)
	f15_arg0.DirectorCODCasterMemberInfo:completeAnimation()
	f15_arg0.EmptyText:completeAnimation()
	f15_arg0.DirectorCODCasterMemberInfo:setAlpha(1)
	f15_arg0.DirectorCODCasterMemberInfo:setScale(1, 1)
	f15_arg0.EmptyText:setAlpha(0)
	f15_arg0.EmptyText:setScale(1, 1)
end
CoD.DirectorCustomGameCodCaster.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f17_arg0.DirectorCODCasterMemberInfo:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.DirectorCODCasterMemberInfo)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.DirectorCODCasterMemberInfo:beginAnimation(200)
				f18_arg0.DirectorCODCasterMemberInfo:setScale(1.05, 1.05)
				f18_arg0.DirectorCODCasterMemberInfo:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.DirectorCODCasterMemberInfo:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f18_arg0.DirectorCODCasterMemberInfo:setScale(1, 1)
			f18_local0(f18_arg0.DirectorCODCasterMemberInfo)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.DirectorCODCasterMemberInfo:beginAnimation(200)
				f20_arg0.DirectorCODCasterMemberInfo:setScale(1, 1)
				f20_arg0.DirectorCODCasterMemberInfo:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.DirectorCODCasterMemberInfo:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f20_arg0.DirectorCODCasterMemberInfo:setScale(1.05, 1.05)
			f20_local0(f20_arg0.DirectorCODCasterMemberInfo)
		end,
	},
	FirstEmptyHighlighted = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f22_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.DirectorCODCasterMemberInfo)
			f22_arg0.EmptyText:completeAnimation()
			f22_arg0.EmptyText:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.EmptyText)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f23_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DirectorCODCasterMemberInfo)
			f23_arg0.EmptyText:completeAnimation()
			f23_arg0.EmptyText:setAlpha(1)
			f23_arg0.EmptyText:setScale(1.05, 1.05)
			f23_arg0.clipFinished(f23_arg0.EmptyText)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f24_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DirectorCODCasterMemberInfo)
			local f24_local0 = function(f25_arg0)
				f24_arg0.EmptyText:beginAnimation(200)
				f24_arg0.EmptyText:setScale(1.05, 1.05)
				f24_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.EmptyText:completeAnimation()
			f24_arg0.EmptyText:setAlpha(1)
			f24_arg0.EmptyText:setScale(1, 1)
			f24_local0(f24_arg0.EmptyText)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f26_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DirectorCODCasterMemberInfo)
			local f26_local0 = function(f27_arg0)
				f26_arg0.EmptyText:beginAnimation(200)
				f26_arg0.EmptyText:setScale(1, 1)
				f26_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.EmptyText:completeAnimation()
			f26_arg0.EmptyText:setAlpha(1)
			f26_arg0.EmptyText:setScale(1.05, 1.05)
			f26_local0(f26_arg0.EmptyText)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f28_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DirectorCODCasterMemberInfo)
			f28_arg0.EmptyText:completeAnimation()
			f28_arg0.EmptyText:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.EmptyText)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f29_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.DirectorCODCasterMemberInfo)
			f29_arg0.EmptyText:completeAnimation()
			f29_arg0.EmptyText:setAlpha(1)
			f29_arg0.EmptyText:setScale(1.05, 1.05)
			f29_arg0.clipFinished(f29_arg0.EmptyText)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f30_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.DirectorCODCasterMemberInfo)
			local f30_local0 = function(f31_arg0)
				f30_arg0.EmptyText:beginAnimation(200)
				f30_arg0.EmptyText:setScale(1.05, 1.05)
				f30_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.EmptyText:completeAnimation()
			f30_arg0.EmptyText:setAlpha(1)
			f30_arg0.EmptyText:setScale(1, 1)
			f30_local0(f30_arg0.EmptyText)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f32_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.DirectorCODCasterMemberInfo)
			local f32_local0 = function(f33_arg0)
				f32_arg0.EmptyText:beginAnimation(200)
				f32_arg0.EmptyText:setScale(1, 1)
				f32_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.EmptyText:completeAnimation()
			f32_arg0.EmptyText:setAlpha(1)
			f32_arg0.EmptyText:setScale(1.05, 1.05)
			f32_local0(f32_arg0.EmptyText)
		end,
	},
	Empty = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f34_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DirectorCODCasterMemberInfo)
			f34_arg0.EmptyText:completeAnimation()
			f34_arg0.EmptyText:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.EmptyText)
		end,
		ChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f35_arg0.DirectorCODCasterMemberInfo:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.DirectorCODCasterMemberInfo)
			f35_arg0.EmptyText:completeAnimation()
			f35_arg0.EmptyText:setAlpha(1)
			f35_arg0.EmptyText:setScale(1.05, 1.05)
			f35_arg0.clipFinished(f35_arg0.EmptyText)
		end,
	},
	Selected = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.DirectorCODCasterMemberInfo:completeAnimation()
			f36_arg0.DirectorCODCasterMemberInfo:setScale(1.05, 1.05)
			f36_arg0.clipFinished(f36_arg0.DirectorCODCasterMemberInfo)
		end,
	},
}
CoD.DirectorCustomGameCodCaster.__onClose = function(f37_arg0)
	f37_arg0.DirectorCODCasterMemberInfo:close()
	f37_arg0.EmptyText:close()
end
