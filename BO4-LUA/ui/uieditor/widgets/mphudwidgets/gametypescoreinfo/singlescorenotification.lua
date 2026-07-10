CoD.SingleScoreNotification = InheritFrom(LUI.UIElement)
CoD.SingleScoreNotification.__defaultWidth = 190
CoD.SingleScoreNotification.__defaultHeight = 80
CoD.SingleScoreNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SingleScoreNotification)
	self.id = "SingleScoreNotification"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ObjectiveProgressionFrame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	ObjectiveProgressionFrame:setLeftRight(0, 0, 18, 418)
	ObjectiveProgressionFrame:setTopBottom(0, 0, -14, 1)
	ObjectiveProgressionFrame:subscribeToGlobalModel(f1_arg1, "WarData", "zone1.progressWidget", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ObjectiveProgressionFrame:changeFrameWidget(f2_local0)
		end
	end)
	self:addElement(ObjectiveProgressionFrame)
	self.ObjectiveProgressionFrame = ObjectiveProgressionFrame
	local ObjectiveTextBox = LUI.UIText.new(0, 1, 0, 0, 0, 0, 20, 48)
	ObjectiveTextBox:setTTF("default")
	ObjectiveTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ObjectiveTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ObjectiveTextBox:subscribeToGlobalModel(f1_arg1, "WarData", "zone1.teamObjective", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ObjectiveTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(ObjectiveTextBox)
	self.ObjectiveTextBox = ObjectiveTextBox
	local ContestedText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 20, 48)
	ContestedText:setAlpha(0)
	ContestedText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2E57B38B7A8EE82E"))
	ContestedText:setTTF("default")
	ContestedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ContestedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ContestedText)
	self.ContestedText = ContestedText
	self:mergeStateConditions({
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["hudItems.war.objectiveHeldByAttackingTeam"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["hudItems.war.objectiveHeldByDefendingTeam"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	ObjectiveProgressionFrame.id = "ObjectiveProgressionFrame"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SingleScoreNotification.__resetProperties = function(f7_arg0)
	f7_arg0.ObjectiveTextBox:completeAnimation()
	f7_arg0.ContestedText:completeAnimation()
	f7_arg0.ObjectiveTextBox:setAlpha(1)
	f7_arg0.ContestedText:setAlpha(0)
	f7_arg0.ContestedText:setScale(1, 1)
end
CoD.SingleScoreNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Contested = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.ObjectiveTextBox:completeAnimation()
			f9_arg0.ObjectiveTextBox:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ObjectiveTextBox)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(1000)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(600, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
					f11_arg0:setScale(1, 1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.ContestedText:beginAnimation(400)
				f9_arg0.ContestedText:setScale(1.2, 1.2)
				f9_arg0.ContestedText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ContestedText:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.ContestedText:completeAnimation()
			f9_arg0.ContestedText:setAlpha(1)
			f9_arg0.ContestedText:setScale(1, 1)
			f9_local0(f9_arg0.ContestedText)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.SingleScoreNotification.__onClose = function(f13_arg0)
	f13_arg0.ObjectiveProgressionFrame:close()
	f13_arg0.ObjectiveTextBox:close()
end
