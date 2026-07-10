require("x64:f72d4606ccc678a")
CoD.IconRewardWidget = InheritFrom(LUI.UIElement)
CoD.IconRewardWidget.__defaultWidth = 72
CoD.IconRewardWidget.__defaultHeight = 72
CoD.IconRewardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IconRewardWidget)
	self.id = "IconRewardWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Notification2xpReward = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 72)
	Notification2xpReward:mergeStateConditions({
		{
			stateName = "VisibleWZ",
			condition = function(menu, element, event)
				local f2_local0 = IsDoubleXP(f1_arg1)
				if f2_local0 then
					f2_local0 = IsWarzone()
					if f2_local0 then
						f2_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "icon", @"t7_hud_mp_notifications_xp_blue")
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "icon", @"t7_hud_mp_notifications_xp_blue")
			end,
		},
	})
	local CallingCardReward = Notification2xpReward
	local RewardImage = Notification2xpReward.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	RewardImage(CallingCardReward, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(Notification2xpReward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Notification2xpReward:linkToElementModel(Notification2xpReward, "icon", true, function(model)
		f1_arg0:updateElementState(Notification2xpReward, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "icon",
		})
	end)
	Notification2xpReward:linkToElementModel(self, nil, false, function(model)
		Notification2xpReward:setModel(model, f1_arg1)
	end)
	self:addElement(Notification2xpReward)
	self.Notification2xpReward = Notification2xpReward
	RewardImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 72, 0, 0, 0, 72)
	RewardImage:setStretchedDimension(6)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	CallingCardReward = LUI.UIImage.new(0, 0, 0, 72, 0, 0, 0, 72)
	CallingCardReward:setAlpha(0)
	CallingCardReward:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	CallingCardReward:setShaderVector(0, 0.5, 0, 0, 0)
	CallingCardReward:setShaderVector(1, 1, 1, 0, 0)
	CallingCardReward:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(CallingCardReward)
	self.CallingCardReward = CallingCardReward
	self.RewardImage:linkToElementModel(self, "icon", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RewardImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self.CallingCardReward:linkToElementModel(self, "icon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CallingCardReward:setImage(RegisterImage(f8_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "CallingCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCallingCard") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "size", "CallingCard")
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "icon", @"t7_hud_mp_notifications_xp_blue")
			end,
		},
	})
	self:linkToElementModel(self, "isCallingCard", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isCallingCard",
		})
	end)
	self:linkToElementModel(self, "size", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "size",
		})
	end)
	self:linkToElementModel(self, "icon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "icon",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IconRewardWidget.__resetProperties = function(f14_arg0)
	f14_arg0.RewardImage:completeAnimation()
	f14_arg0.CallingCardReward:completeAnimation()
	f14_arg0.RewardImage:setAlpha(1)
	f14_arg0.CallingCardReward:setAlpha(0)
end
CoD.IconRewardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	CallingCard = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.RewardImage:completeAnimation()
			f16_arg0.RewardImage:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.RewardImage)
			f16_arg0.CallingCardReward:completeAnimation()
			f16_arg0.CallingCardReward:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.CallingCardReward)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.RewardImage:completeAnimation()
			f17_arg0.RewardImage:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.RewardImage)
		end,
	},
}
CoD.IconRewardWidget.__onClose = function(f18_arg0)
	f18_arg0.Notification2xpReward:close()
	f18_arg0.RewardImage:close()
	f18_arg0.CallingCardReward:close()
end
