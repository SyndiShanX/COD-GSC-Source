CoD.Prestige_LevelRewardsBacking = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelRewardsBacking.__defaultWidth = 128
CoD.Prestige_LevelRewardsBacking.__defaultHeight = 466
CoD.Prestige_LevelRewardsBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LevelRewardsBacking)
	self.id = "Prestige_LevelRewardsBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BodyBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BodyBg:setRGB(0.16, 0.16, 0.16)
	self:addElement(BodyBg)
	self.BodyBg = BodyBg
	self:mergeStateConditions({
		{
			stateName = "LevelAchieved",
			condition = function(menu, element, event)
				local f2_local0
				if not IsMaxPrestigeLevel(f1_arg1) then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "rankAchieved")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "MasterPrestige",
			condition = function(menu, element, event)
				return IsMaxPrestigeLevel(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "rankAchieved", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rankAchieved",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LevelRewardsBacking.__resetProperties = function(f5_arg0)
	f5_arg0.BodyBg:completeAnimation()
	f5_arg0.BodyBg:setRGB(0.16, 0.16, 0.16)
end
CoD.Prestige_LevelRewardsBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.BodyBg:completeAnimation()
			f6_arg0.BodyBg:setRGB(0.15, 0.15, 0.15)
			f6_arg0.clipFinished(f6_arg0.BodyBg)
		end,
	},
	LevelAchieved = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.BodyBg:completeAnimation()
			f7_arg0.BodyBg:setRGB(0.2, 0.2, 0.2)
			f7_arg0.clipFinished(f7_arg0.BodyBg)
		end,
	},
	MasterPrestige = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.BodyBg:completeAnimation()
			f8_arg0.BodyBg:setRGB(0.14, 0.14, 0.14)
			f8_arg0.clipFinished(f8_arg0.BodyBg)
		end,
	},
}
