require("x64:88c6f65f2dd32da")
CoD.DirectorGauntletMapSelectItem = InheritFrom(LUI.UIElement)
CoD.DirectorGauntletMapSelectItem.__defaultWidth = 246
CoD.DirectorGauntletMapSelectItem.__defaultHeight = 104
CoD.DirectorGauntletMapSelectItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorGauntletMapSelectItem)
	self.id = "DirectorGauntletMapSelectItem"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.DirectorZMMapSelectItemOffline_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 246, 0, 0, 0, 104)
	Button:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "MapVote.mapVoteMapNext", "id") and CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "localZMTrialVariant", "trialVariant")
			end,
		},
	})
	local f1_local2 = Button
	local f1_local3 = Button.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["MapVote.mapVoteMapNext"], function(f3_arg0)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "MapVote.mapVoteMapNext",
		})
	end, false)
	Button:linkToElementModel(Button, "id", true, function(model)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	f1_local2 = Button
	f1_local3 = Button.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4.localZMTrialVariant, function(f5_arg0)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "localZMTrialVariant",
		})
	end, false)
	Button:linkToElementModel(Button, "trialVariant", true, function(model)
		f1_arg0:updateElementState(Button, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialVariant",
		})
	end)
	Button.FeaturedTag:setText(LocalizeToUpperString(@"menu/public_tab"))
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	Button:linkToElementModel(self, "id", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Button.MapImage:setImage(RegisterImage(MapNameToMapImage(f8_local0)))
		end
	end)
	Button.MapName.__MapName_String_Reference = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			Button.MapName:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.ZombieUtility.GauntletMapNameToLocalizedMapDetailedName(f1_arg1, self:getModel(), f9_local0)))
		end
	end
	Button:linkToElementModel(self, "id", true, Button.MapName.__MapName_String_Reference)
	Button.MapName.__MapName_String_Reference_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.id
		end
		if f10_local0 then
			Button.MapName.__MapName_String_Reference(f10_local0)
		end
	end
	Button:linkToElementModel(self, "id", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Button.TeamName:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.MapUtility.GetMapTeamNameFromMapID(f11_local0)))
		end
	end)
	self:addElement(Button)
	self.Button = Button
	Button:linkToElementModel(self, "trialVariant", true, Button.MapName.__MapName_String_Reference_FullPath)
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorGauntletMapSelectItem.__resetProperties = function(f12_arg0)
	f12_arg0.Button:completeAnimation()
	f12_arg0.Button:setScale(1, 1)
end
CoD.DirectorGauntletMapSelectItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Button:completeAnimation()
			f14_arg0.Button:setScale(1.05, 1.05)
			f14_arg0.clipFinished(f14_arg0.Button)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Button:beginAnimation(200)
				f15_arg0.Button:setScale(1.05, 1.05)
				f15_arg0.Button:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Button:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Button:completeAnimation()
			f15_arg0.Button:setScale(1, 1)
			f15_local0(f15_arg0.Button)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Button:beginAnimation(200)
				f17_arg0.Button:setScale(1, 1)
				f17_arg0.Button:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Button:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Button:completeAnimation()
			f17_arg0.Button:setScale(1.05, 1.05)
			f17_local0(f17_arg0.Button)
		end,
	},
}
CoD.DirectorGauntletMapSelectItem.__onClose = function(f19_arg0)
	f19_arg0.Button:close()
end
