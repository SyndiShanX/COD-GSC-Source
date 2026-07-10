CoD.JobFeedItemBattleCommand = InheritFrom(LUI.UIElement)
CoD.JobFeedItemBattleCommand.__defaultWidth = 128
CoD.JobFeedItemBattleCommand.__defaultHeight = 128
CoD.JobFeedItemBattleCommand.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.JobFeedItemBattleCommand)
	self.id = "JobFeedItemBattleCommand"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BattleCommandGlow = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	BattleCommandGlow:setRGB(0.15, 0.97, 1)
	BattleCommandGlow:setAlpha(0)
	BattleCommandGlow:setScale(0.65, 0.9)
	BattleCommandGlow:setImage(RegisterImage(0xD4F7AA0A4512AE0))
	BattleCommandGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	BattleCommandGlow:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(BattleCommandGlow)
	self.BattleCommandGlow = BattleCommandGlow
	self:mergeStateConditions({
		{
			stateName = "BattleCommandActive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.combatEfficiencyActive", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.combatEfficiencyActive"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.combatEfficiencyActive",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.JobFeedItemBattleCommand.__resetProperties = function(f4_arg0)
	f4_arg0.BattleCommandGlow:completeAnimation()
	f4_arg0.BattleCommandGlow:setAlpha(0)
	f4_arg0.BattleCommandGlow:setScale(0.65, 0.9)
end
CoD.JobFeedItemBattleCommand.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	BattleCommandActive = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(500)
					f8_arg0:setScale(0.65, 0.9)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.BattleCommandGlow:beginAnimation(500)
				f6_arg0.BattleCommandGlow:setScale(0.7, 0.95)
				f6_arg0.BattleCommandGlow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.BattleCommandGlow:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.BattleCommandGlow:completeAnimation()
			f6_arg0.BattleCommandGlow:setAlpha(0.5)
			f6_arg0.BattleCommandGlow:setScale(0.65, 0.9)
			f6_local0(f6_arg0.BattleCommandGlow)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
}
