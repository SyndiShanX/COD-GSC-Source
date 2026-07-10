CoD.codcaster_player_portrait_frames = InheritFrom(LUI.UIElement)
CoD.codcaster_player_portrait_frames.__defaultWidth = 132
CoD.codcaster_player_portrait_frames.__defaultHeight = 156
CoD.codcaster_player_portrait_frames.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcaster_player_portrait_frames)
	self.id = "codcaster_player_portrait_frames"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local frameLarge = LUI.UIImage.new(0, 0, 0, 132, 0, 0, 0, 156)
	frameLarge:setAlpha(0)
	frameLarge:setImage(RegisterImage(0xC8D12F1E779001C))
	frameLarge:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			frameLarge:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(frameLarge)
	self.frameLarge = frameLarge
	local frameLargeDead = LUI.UIImage.new(0, 0, 0, 132, 0, 0, 0, 156)
	frameLargeDead:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	frameLargeDead:setAlpha(0)
	frameLargeDead:setImage(RegisterImage(0xC8D12F1E779001C))
	self:addElement(frameLargeDead)
	self.frameLargeDead = frameLargeDead
	local frameMedium = LUI.UIImage.new(0.5, 0.5, -66, 66, 0, 0, 0, 124)
	frameMedium:setAlpha(0)
	frameMedium:setImage(RegisterImage(0xE36BFACD2F7ECBC))
	frameMedium:linkToElementModel(self, "clientNum", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			frameMedium:setRGB(TeamColorFromPlayerIndex(f1_arg1, f3_local0))
		end
	end)
	self:addElement(frameMedium)
	self.frameMedium = frameMedium
	local frameMediumDead = LUI.UIImage.new(0.5, 0.5, -66, 66, 0, 0, 0, 124)
	frameMediumDead:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	frameMediumDead:setAlpha(0)
	frameMediumDead:setImage(RegisterImage(0xE36BFACD2F7ECBC))
	self:addElement(frameMediumDead)
	self.frameMediumDead = frameMediumDead
	local frameSmall = LUI.UIImage.new(0, 0, 0, 132, 0, 0, 0, 92)
	frameSmall:setImage(RegisterImage(0xCF38A5FC3EF32E4))
	frameSmall:linkToElementModel(self, "clientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			frameSmall:setRGB(TeamColorFromPlayerIndex(f1_arg1, f4_local0))
		end
	end)
	self:addElement(frameSmall)
	self.frameSmall = frameSmall
	local frameSmallDead = LUI.UIImage.new(0, 0, 0, 132, 0, 0, 0, 92)
	frameSmallDead:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	frameSmallDead:setAlpha(0)
	frameSmallDead:setImage(RegisterImage(0xCF38A5FC3EF32E4))
	self:addElement(frameSmallDead)
	self.frameSmallDead = frameSmallDead
	self:mergeStateConditions({
		{
			stateName = "fullDead",
			condition = function(menu, element, event)
				local f5_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f5_local0 then
					f5_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
					if f5_local0 then
						if not CoD.HUDUtility.IsGameTypeEqualToString("bounty") then
							f5_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
						else
							f5_local0 = false
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "fullheistDead",
			condition = function(menu, element, event)
				local f6_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
				if f6_local0 then
					f6_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
					if f6_local0 then
						f6_local0 = CoD.HUDUtility.IsGameTypeEqualToString("bounty")
						if f6_local0 then
							f6_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
						end
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "mediumstreakDead",
			condition = function(menu, element, event)
				local f7_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f7_local0 then
					f7_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 0)
					if f7_local0 then
						if not CoD.HUDUtility.IsGameTypeEqualToString("bounty") then
							f7_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
						else
							f7_local0 = false
						end
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "mediuminfoDead",
			condition = function(menu, element, event)
				local f8_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
				if f8_local0 then
					f8_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 0)
					if f8_local0 then
						f8_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "full",
			condition = function(menu, element, event)
				local f9_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f9_local0 then
					f9_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
					if f9_local0 then
						f9_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("bounty")
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "fullheist",
			condition = function(menu, element, event)
				local f10_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
				if f10_local0 then
					f10_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
					if f10_local0 then
						f10_local0 = CoD.HUDUtility.IsGameTypeEqualToString("bounty")
					end
				end
				return f10_local0
			end,
		},
		{
			stateName = "mediumstreak",
			condition = function(menu, element, event)
				local f11_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f11_local0 then
					f11_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 0)
					if f11_local0 then
						f11_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("bounty")
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "mediuminfo",
			condition = function(menu, element, event)
				return IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1) and IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 0)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.profileSettingsUpdated, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcaster_player_portrait_frames.__resetProperties = function(f15_arg0)
	f15_arg0.frameSmall:completeAnimation()
	f15_arg0.frameLarge:completeAnimation()
	f15_arg0.frameLargeDead:completeAnimation()
	f15_arg0.frameMedium:completeAnimation()
	f15_arg0.frameMediumDead:completeAnimation()
	f15_arg0.frameSmall:setAlpha(1)
	f15_arg0.frameLarge:setAlpha(0)
	f15_arg0.frameLargeDead:setAlpha(0)
	f15_arg0.frameMedium:setAlpha(0)
	f15_arg0.frameMediumDead:setAlpha(0)
end
CoD.codcaster_player_portrait_frames.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.frameSmall:completeAnimation()
			f16_arg0.frameSmall:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.frameSmall)
		end,
	},
	fullDead = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.frameLarge:completeAnimation()
			f17_arg0.frameLarge:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.frameLarge)
			f17_arg0.frameLargeDead:completeAnimation()
			f17_arg0.frameLargeDead:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.frameLargeDead)
			f17_arg0.frameSmall:completeAnimation()
			f17_arg0.frameSmall:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.frameSmall)
		end,
	},
	fullheistDead = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.frameMedium:completeAnimation()
			f18_arg0.frameMedium:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.frameMedium)
			f18_arg0.frameMediumDead:completeAnimation()
			f18_arg0.frameMediumDead:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.frameMediumDead)
			f18_arg0.frameSmall:completeAnimation()
			f18_arg0.frameSmall:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.frameSmall)
		end,
	},
	mediumstreakDead = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.frameMedium:completeAnimation()
			f19_arg0.frameMedium:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.frameMedium)
			f19_arg0.frameMediumDead:completeAnimation()
			f19_arg0.frameMediumDead:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.frameMediumDead)
			f19_arg0.frameSmall:completeAnimation()
			f19_arg0.frameSmall:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.frameSmall)
		end,
	},
	mediuminfoDead = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.frameMedium:completeAnimation()
			f20_arg0.frameMedium:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.frameMedium)
			f20_arg0.frameMediumDead:completeAnimation()
			f20_arg0.frameMediumDead:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.frameMediumDead)
			f20_arg0.frameSmall:completeAnimation()
			f20_arg0.frameSmall:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.frameSmall)
		end,
	},
	full = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.frameLarge:completeAnimation()
			f21_arg0.frameLarge:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.frameLarge)
			f21_arg0.frameSmall:completeAnimation()
			f21_arg0.frameSmall:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.frameSmall)
		end,
	},
	fullheist = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.frameMedium:completeAnimation()
			f22_arg0.frameMedium:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.frameMedium)
			f22_arg0.frameSmall:completeAnimation()
			f22_arg0.frameSmall:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.frameSmall)
		end,
	},
	mediumstreak = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.frameMedium:completeAnimation()
			f23_arg0.frameMedium:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.frameMedium)
			f23_arg0.frameSmall:completeAnimation()
			f23_arg0.frameSmall:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.frameSmall)
		end,
	},
	mediuminfo = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.frameMedium:completeAnimation()
			f24_arg0.frameMedium:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.frameMedium)
			f24_arg0.frameSmall:completeAnimation()
			f24_arg0.frameSmall:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.frameSmall)
		end,
	},
}
CoD.codcaster_player_portrait_frames.__onClose = function(f25_arg0)
	f25_arg0.frameLarge:close()
	f25_arg0.frameMedium:close()
	f25_arg0.frameSmall:close()
end
