require("x64:df03a3cfee01114")
CoD.DeathCamContainer = InheritFrom(LUI.UIElement)
CoD.DeathCamContainer.__defaultWidth = 600
CoD.DeathCamContainer.__defaultHeight = 300
CoD.DeathCamContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DeathCamContainer)
	self.id = "DeathCamContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DeathCamPlayerKilledBy = CoD.DeathCamPlayerKilledBy.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 300)
	DeathCamPlayerKilledBy:setAlpha(0)
	self:addElement(DeathCamPlayerKilledBy)
	self.DeathCamPlayerKilledBy = DeathCamPlayerKilledBy
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.hacked"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DeathCamContainer.__resetProperties = function(f5_arg0)
	f5_arg0.DeathCamPlayerKilledBy:completeAnimation()
	f5_arg0.DeathCamPlayerKilledBy:setAlpha(0)
end
CoD.DeathCamContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Visible = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.DeathCamPlayerKilledBy:beginAnimation(250)
				f7_arg0.DeathCamPlayerKilledBy:setAlpha(1)
				f7_arg0.DeathCamPlayerKilledBy:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.DeathCamPlayerKilledBy:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.DeathCamPlayerKilledBy:completeAnimation()
			f7_arg0.DeathCamPlayerKilledBy:setAlpha(0)
			f7_local0(f7_arg0.DeathCamPlayerKilledBy)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.DeathCamPlayerKilledBy:completeAnimation()
			f9_arg0.DeathCamPlayerKilledBy:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.DeathCamPlayerKilledBy)
		end,
	},
}
CoD.DeathCamContainer.__onClose = function(f10_arg0)
	f10_arg0.DeathCamPlayerKilledBy:close()
end
