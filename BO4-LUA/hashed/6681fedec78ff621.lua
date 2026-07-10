CoD.PC_Korea_Event_Week_Reward = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Week_Reward.__defaultWidth = 112
CoD.PC_Korea_Event_Week_Reward.__defaultHeight = 112
CoD.PC_Korea_Event_Week_Reward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Week_Reward)
	self.id = "PC_Korea_Event_Week_Reward"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeekRewardBG = LUI.UIImage.new(1, 1, -112, 0, 0, 1, 0, 0)
	WeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_week_bg"))
	WeekRewardBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	WeekRewardBG:setShaderVector(0, 0, 0, 0, 0)
	WeekRewardBG:setupNineSliceShader(64, 64)
	self:addElement(WeekRewardBG)
	self.WeekRewardBG = WeekRewardBG
	local CompletedWeekRewardBG = LUI.UIImage.new(0.5, 0.5, -56, 56, 0, 1, 0, 0)
	CompletedWeekRewardBG:setAlpha(0)
	CompletedWeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_completedweek_bg"))
	CompletedWeekRewardBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CompletedWeekRewardBG:setShaderVector(0, 0, 0, 0, 0)
	CompletedWeekRewardBG:setupNineSliceShader(64, 64)
	self:addElement(CompletedWeekRewardBG)
	self.CompletedWeekRewardBG = CompletedWeekRewardBG
	local CurrentWeekRewardBG = LUI.UIImage.new(1, 1, -112, 0, 0, 1, 0, 0)
	CurrentWeekRewardBG:setAlpha(0)
	CurrentWeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_currentweek_bg"))
	CurrentWeekRewardBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CurrentWeekRewardBG:setShaderVector(0, 0, 0, 0, 0)
	CurrentWeekRewardBG:setupNineSliceShader(64, 64)
	self:addElement(CurrentWeekRewardBG)
	self.CurrentWeekRewardBG = CurrentWeekRewardBG
	local RewardImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RewardImage:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_1"))
	RewardImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint"))
	RewardImage:setShaderVector(0, -0.11, 0, 0, 0)
	RewardImage:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local IncludeRewardImage3 = LUI.UIImage.new(0.83, 1.78, 20, 20, 0.03, 0.98, 0, 0)
	IncludeRewardImage3:setAlpha(0)
	IncludeRewardImage3:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_4"))
	self:addElement(IncludeRewardImage3)
	self.IncludeRewardImage3 = IncludeRewardImage3
	local IncludeRewardImage1 = LUI.UIImage.new(0.83, 1.78, 20, 20, 0.03, 0.98, 0, 0)
	IncludeRewardImage1:setAlpha(0)
	IncludeRewardImage1:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_2"))
	self:addElement(IncludeRewardImage1)
	self.IncludeRewardImage1 = IncludeRewardImage1
	local IncludeRewardImage2 = LUI.UIImage.new(0.83, 1.78, 20, 20, 0.03, 0.98, 0, 0)
	IncludeRewardImage2:setAlpha(0)
	IncludeRewardImage2:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_3"))
	self:addElement(IncludeRewardImage2)
	self.IncludeRewardImage2 = IncludeRewardImage2
	local LockIcon = LUI.UIImage.new(0.5, 0.5, -15, 17, 0.5, 0.5, -16, 16)
	LockIcon:setAlpha(0)
	LockIcon:setImage(RegisterImage(@"uie_icon_locks_lock_01"))
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	local LockLines = LUI.UIImage.new(0.5, 0.5, -56, 56, 0.5, 0.5, -56, 56)
	LockLines:setAlpha(0)
	LockLines:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_reward_line_lock"))
	self:addElement(LockLines)
	self.LockLines = LockLines
	local WeeklyRewardSound = LUI.UIElement.new(0, 0, 41, 73, 0, 0, 112, 144)
	self:addElement(WeeklyRewardSound)
	self.WeeklyRewardSound = WeeklyRewardSound
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Week_Reward.__resetProperties = function(f2_arg0)
	f2_arg0.CurrentWeekRewardBG:completeAnimation()
	f2_arg0.RewardImage:completeAnimation()
	f2_arg0.WeeklyRewardSound:completeAnimation()
	f2_arg0.CompletedWeekRewardBG:completeAnimation()
	f2_arg0.WeekRewardBG:completeAnimation()
	f2_arg0.LockLines:completeAnimation()
	f2_arg0.LockIcon:completeAnimation()
	f2_arg0.CurrentWeekRewardBG:setRGB(1, 1, 1)
	f2_arg0.CurrentWeekRewardBG:setAlpha(0)
	f2_arg0.CurrentWeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_currentweek_bg"))
	f2_arg0.RewardImage:setRGB(1, 1, 1)
	f2_arg0.RewardImage:setShaderVector(0, -0.11, 0, 0, 0)
	f2_arg0.RewardImage:setShaderVector(1, -46.8, 0, 0, 0)
	f2_arg0.WeeklyRewardSound:setPlaySoundDirect(false)
	f2_arg0.CompletedWeekRewardBG:setLeftRight(0.5, 0.5, -56, 56)
	f2_arg0.CompletedWeekRewardBG:setTopBottom(0, 1, 0, 0)
	f2_arg0.CompletedWeekRewardBG:setAlpha(0)
	f2_arg0.WeekRewardBG:setRGB(1, 1, 1)
	f2_arg0.LockLines:setAlpha(0)
	f2_arg0.LockIcon:setAlpha(0)
end
CoD.PC_Korea_Event_Week_Reward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	CurrentWeekRewardIntroUnlock = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			local f4_local0 = function(f5_arg0)
				f4_arg0.CurrentWeekRewardBG:beginAnimation(590)
				f4_arg0.CurrentWeekRewardBG:setRGB(1, 1, 1)
				f4_arg0.CurrentWeekRewardBG:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CurrentWeekRewardBG:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.CurrentWeekRewardBG:completeAnimation()
			f4_arg0.CurrentWeekRewardBG:setRGB(0.39, 0.39, 0.39)
			f4_arg0.CurrentWeekRewardBG:setAlpha(1)
			f4_arg0.CurrentWeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_currentweek_bg"))
			f4_local0(f4_arg0.CurrentWeekRewardBG)
			local f4_local1 = function(f6_arg0)
				f4_arg0.RewardImage:beginAnimation(590)
				f4_arg0.RewardImage:setRGB(1, 1, 1)
				f4_arg0.RewardImage:setShaderVector(0, 1.12, 0, 0, 0)
				f4_arg0.RewardImage:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.RewardImage:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.RewardImage:completeAnimation()
			f4_arg0.RewardImage:setRGB(0.39, 0.39, 0.39)
			f4_arg0.RewardImage:setShaderVector(0, -0.09, 0, 0, 0)
			f4_arg0.RewardImage:setShaderVector(1, -46, 0, 0, 0)
			f4_local1(f4_arg0.RewardImage)
			f4_arg0.WeeklyRewardSound:completeAnimation()
			f4_arg0.WeeklyRewardSound:setPlaySoundDirect(true)
			f4_arg0.WeeklyRewardSound:playSound("uin_igr_weeklyrewardunlock", f4_arg1)
			f4_arg0.clipFinished(f4_arg0.WeeklyRewardSound)
		end,
	},
	CurrentWeekRewardUnlocked = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.CurrentWeekRewardBG:completeAnimation()
			f7_arg0.CurrentWeekRewardBG:setAlpha(1)
			f7_arg0.CurrentWeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_currentweek_bg"))
			f7_arg0.clipFinished(f7_arg0.CurrentWeekRewardBG)
		end,
	},
	CurrentWeek = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.CurrentWeekRewardBG:completeAnimation()
			f8_arg0.CurrentWeekRewardBG:setRGB(0.39, 0.39, 0.39)
			f8_arg0.CurrentWeekRewardBG:setAlpha(1)
			f8_arg0.CurrentWeekRewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_currentweek_bg"))
			f8_arg0.clipFinished(f8_arg0.CurrentWeekRewardBG)
			f8_arg0.RewardImage:completeAnimation()
			f8_arg0.RewardImage:setRGB(0.39, 0.39, 0.39)
			f8_arg0.clipFinished(f8_arg0.RewardImage)
		end,
	},
	Completed = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.CompletedWeekRewardBG:completeAnimation()
			f9_arg0.CompletedWeekRewardBG:setLeftRight(0.5, 0.5, -56, 56)
			f9_arg0.CompletedWeekRewardBG:setTopBottom(0, 1, 0, 0)
			f9_arg0.CompletedWeekRewardBG:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.CompletedWeekRewardBG)
		end,
	},
	Failed = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.WeekRewardBG:completeAnimation()
			f10_arg0.WeekRewardBG:setRGB(0.75, 0.75, 0.75)
			f10_arg0.clipFinished(f10_arg0.WeekRewardBG)
			f10_arg0.RewardImage:completeAnimation()
			f10_arg0.RewardImage:setRGB(0.39, 0.39, 0.39)
			f10_arg0.clipFinished(f10_arg0.RewardImage)
		end,
	},
	Unavailable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.WeekRewardBG:completeAnimation()
			f11_arg0.WeekRewardBG:setRGB(0.39, 0.39, 0.39)
			f11_arg0.clipFinished(f11_arg0.WeekRewardBG)
			f11_arg0.RewardImage:completeAnimation()
			f11_arg0.RewardImage:setRGB(0.32, 0.32, 0.32)
			f11_arg0.clipFinished(f11_arg0.RewardImage)
			f11_arg0.LockIcon:completeAnimation()
			f11_arg0.LockIcon:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.LockIcon)
			f11_arg0.LockLines:completeAnimation()
			f11_arg0.LockLines:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.LockLines)
		end,
	},
}
