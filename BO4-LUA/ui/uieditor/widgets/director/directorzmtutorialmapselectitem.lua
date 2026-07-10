require("x64:ff936e9bc4df392")
CoD.DirectorZMTutorialMapSelectItem = InheritFrom(LUI.UIElement)
CoD.DirectorZMTutorialMapSelectItem.__defaultWidth = 246
CoD.DirectorZMTutorialMapSelectItem.__defaultHeight = 104
CoD.DirectorZMTutorialMapSelectItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMTutorialMapSelectItem)
	self.id = "DirectorZMTutorialMapSelectItem"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Botton = CoD.DirectorTutorialMapSelectItem_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 246, 0, 0, 0, 104)
	Botton:linkToElementModel(self, nil, false, function(model)
		Botton:setModel(model, f1_arg1)
	end)
	Botton:linkToElementModel(self, "id", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Botton.MapImage:setImage(RegisterImage(MapNameToMapImage(f3_local0)))
		end
	end)
	Botton:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Botton.MapName:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	Botton:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Botton.GamemodeIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(Botton)
	self.Botton = Botton
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "MapVote.mapVoteMapNext", "id") and CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "localZMDifficulty", "difficulty")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["MapVote.mapVoteMapNext"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "MapVote.mapVoteMapNext",
		})
	end, false)
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4.localZMDifficulty, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "localZMDifficulty",
		})
	end, false)
	self:linkToElementModel(self, "difficulty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "difficulty",
		})
	end)
	Botton.id = "Botton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorZMTutorialMapSelectItem.__resetProperties = function(f11_arg0)
	f11_arg0.Botton:completeAnimation()
	f11_arg0.Botton:setScale(1, 1)
end
CoD.DirectorZMTutorialMapSelectItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Botton:completeAnimation()
			f13_arg0.Botton:setScale(1.05, 1.05)
			f13_arg0.clipFinished(f13_arg0.Botton)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Botton:beginAnimation(200)
				f14_arg0.Botton:setScale(1.05, 1.05)
				f14_arg0.Botton:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Botton:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Botton:completeAnimation()
			f14_arg0.Botton:setScale(1, 1)
			f14_local0(f14_arg0.Botton)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Botton:beginAnimation(200)
				f16_arg0.Botton:setScale(1, 1)
				f16_arg0.Botton:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Botton:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Botton:completeAnimation()
			f16_arg0.Botton:setScale(1.05, 1.05)
			f16_local0(f16_arg0.Botton)
		end,
	},
	Selected = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.Botton:completeAnimation()
			f19_arg0.Botton:setScale(1.05, 1.05)
			f19_arg0.clipFinished(f19_arg0.Botton)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Botton:beginAnimation(200)
				f20_arg0.Botton:setScale(1.05, 1.05)
				f20_arg0.Botton:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Botton:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Botton:completeAnimation()
			f20_arg0.Botton:setScale(1, 1)
			f20_local0(f20_arg0.Botton)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.Botton:beginAnimation(200)
				f22_arg0.Botton:setScale(1, 1)
				f22_arg0.Botton:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Botton:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Botton:completeAnimation()
			f22_arg0.Botton:setScale(1.05, 1.05)
			f22_local0(f22_arg0.Botton)
		end,
	},
}
CoD.DirectorZMTutorialMapSelectItem.__onClose = function(f24_arg0)
	f24_arg0.Botton:close()
end
