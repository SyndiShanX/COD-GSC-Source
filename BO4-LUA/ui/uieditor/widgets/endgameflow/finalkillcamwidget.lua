require("x64:ec9c426ad19318")
require("x64:9c845e427b3e350")
require("x64:3d7fd4fcd481d79")
require("x64:764072a8b023151")
CoD.FinalKillcamWidget = InheritFrom(LUI.UIElement)
CoD.FinalKillcamWidget.__defaultWidth = 1920
CoD.FinalKillcamWidget.__defaultHeight = 1080
CoD.FinalKillcamWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if IsCampaign() then
		CoD.GameEndScoreUtility.SetupGameEndScoreWidget(self, f1_arg1)
	end
	self:setClass(CoD.FinalKillcamWidget)
	self.id = "FinalKillcamWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerInfo = CoD.FinalKillcamPlayerInfo.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -120, 35)
	PlayerInfo:setAlpha(0)
	self:addElement(PlayerInfo)
	self.PlayerInfo = PlayerInfo
	local CODGradientBacking = CoD.CODCasterTeamBaseGradient.new(f1_arg0, f1_arg1, 0, 0, -9, 1945, 0, 0, 932, 1092)
	CODGradientBacking:setAlpha(0)
	self:addElement(CODGradientBacking)
	self.CODGradientBacking = CODGradientBacking
	local blurbackplate = LUI.UIImage.new(-0.05, 1.05, 0, 0, 0, 0, -4.5, 1355.5)
	blurbackplate:setRGB(0, 0, 0)
	blurbackplate:setAlpha(0)
	blurbackplate:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blurbackplate:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurbackplate)
	self.blurbackplate = blurbackplate
	local BlackForeground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackForeground:setRGB(0, 0, 0)
	BlackForeground:setAlpha(0)
	self:addElement(BlackForeground)
	self.BlackForeground = BlackForeground
	local topbarblack = LUI.UIImage.new(-0.05, 1.05, 0, 0, 0, 0, 1, 119)
	topbarblack:setRGB(0, 0, 0)
	topbarblack:setAlpha(0)
	topbarblack:setImage(RegisterImage(@"hash_5128E65A576FCBB8"))
	self:addElement(topbarblack)
	self.topbarblack = topbarblack
	local killcamTitle = CoD.PLayOfTheMatchTitle.new(f1_arg0, f1_arg1, 0.5, 0.5, -949, -167, 0, 0, 5, 105)
	killcamTitle:setAlpha(0)
	self:addElement(killcamTitle)
	self.killcamTitle = killcamTitle
	local AttackerPlayerCard = CoD.PlayOfTheMatchCallingCard.new(f1_arg0, f1_arg1, 0.5, 0.5, -962, -368, 1, 1, -181, -1)
	AttackerPlayerCard:setAlpha(0)
	self:addElement(AttackerPlayerCard)
	self.AttackerPlayerCard = AttackerPlayerCard
	AttackerPlayerCard.id = "AttackerPlayerCard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FinalKillcamWidget.__resetProperties = function(f2_arg0)
	f2_arg0.PlayerInfo:completeAnimation()
	f2_arg0.topbarblack:completeAnimation()
	f2_arg0.blurbackplate:completeAnimation()
	f2_arg0.CODGradientBacking:completeAnimation()
	f2_arg0.killcamTitle:completeAnimation()
	f2_arg0.AttackerPlayerCard:completeAnimation()
	f2_arg0.BlackForeground:completeAnimation()
	f2_arg0.PlayerInfo:setLeftRight(0, 1, 0, 0)
	f2_arg0.PlayerInfo:setTopBottom(1, 1, -120, 35)
	f2_arg0.PlayerInfo:setAlpha(0)
	f2_arg0.topbarblack:setTopBottom(0, 0, 1, 119)
	f2_arg0.topbarblack:setAlpha(0)
	f2_arg0.blurbackplate:setTopBottom(0, 0, -4.5, 1355.5)
	f2_arg0.blurbackplate:setAlpha(0)
	f2_arg0.CODGradientBacking:setAlpha(0)
	f2_arg0.killcamTitle:setAlpha(0)
	f2_arg0.killcamTitle:setScale(1, 1)
	f2_arg0.AttackerPlayerCard:setTopBottom(1, 1, -181, -1)
	f2_arg0.AttackerPlayerCard:setAlpha(0)
	f2_arg0.AttackerPlayerCard:setScale(1, 1)
	f2_arg0.BlackForeground:setAlpha(0)
end
CoD.FinalKillcamWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.PlayerInfo:completeAnimation()
			f3_arg0.PlayerInfo:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.PlayerInfo)
			f3_arg0.topbarblack:completeAnimation()
			f3_arg0.topbarblack:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.topbarblack)
		end,
	},
	FinalKillcam = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(6)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(520)
					f6_arg0:setTopBottom(1, 1, -146, 9)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.PlayerInfo:beginAnimation(590)
				f4_arg0.PlayerInfo:setAlpha(1)
				f4_arg0.PlayerInfo:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.PlayerInfo:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.PlayerInfo:completeAnimation()
			f4_arg0.PlayerInfo:setLeftRight(0, 1, 0, 0)
			f4_arg0.PlayerInfo:setTopBottom(1, 1, 8, 163)
			f4_arg0.PlayerInfo:setAlpha(0)
			f4_local0(f4_arg0.PlayerInfo)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(480)
					f8_arg0:setAlpha(0.4)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.CODGradientBacking:beginAnimation(1110)
				f4_arg0.CODGradientBacking:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CODGradientBacking:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.CODGradientBacking:completeAnimation()
			f4_arg0.CODGradientBacking:setAlpha(0)
			f4_local1(f4_arg0.CODGradientBacking)
			local f4_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(520, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setTopBottom(0, 0, -4.5, 95.5)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.blurbackplate:beginAnimation(590)
				f4_arg0.blurbackplate:setAlpha(0.55)
				f4_arg0.blurbackplate:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.blurbackplate:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f4_arg0.blurbackplate:completeAnimation()
			f4_arg0.blurbackplate:setTopBottom(0, 0, -125.5, -7.5)
			f4_arg0.blurbackplate:setAlpha(0)
			f4_local2(f4_arg0.blurbackplate)
			local f4_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(520, Enum[@"luitween"][@"luitween_ease_out"])
					f12_arg0:setTopBottom(0, 0, -4, 95)
					f12_arg0:setAlpha(0.97)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.topbarblack:beginAnimation(590)
				f4_arg0.topbarblack:setAlpha(0.53)
				f4_arg0.topbarblack:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.topbarblack:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f4_arg0.topbarblack:completeAnimation()
			f4_arg0.topbarblack:setTopBottom(0, 0, -125.5, -7.5)
			f4_arg0.topbarblack:setAlpha(0)
			f4_local3(f4_arg0.topbarblack)
			local f4_local4 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(19, Enum[@"luitween"][@"luitween_ease_out"])
					f14_arg0:setAlpha(1)
					f14_arg0:setScale(1, 1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f13_arg0:beginAnimation(159, Enum[@"luitween"][@"luitween_ease_out"])
				f13_arg0:setAlpha(0.97)
				f13_arg0:setScale(0.95, 0.95)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f4_arg0.killcamTitle:beginAnimation(1110)
			f4_arg0.killcamTitle:setAlpha(0)
			f4_arg0.killcamTitle:setScale(2, 2)
			f4_arg0.killcamTitle:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.killcamTitle:registerEventHandler("transition_complete_keyframe", f4_local4)
			local f4_local5 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(139)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(20)
					f16_arg0:setAlpha(1)
					f16_arg0:setScale(1, 1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f15_arg0:beginAnimation(159)
				f15_arg0:setAlpha(0.89)
				f15_arg0:setScale(0.95, 0.95)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f4_arg0.AttackerPlayerCard:beginAnimation(1270)
			f4_arg0.AttackerPlayerCard:setTopBottom(1, 1, -151, 29)
			f4_arg0.AttackerPlayerCard:setAlpha(0)
			f4_arg0.AttackerPlayerCard:setScale(2, 2)
			f4_arg0.AttackerPlayerCard:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.AttackerPlayerCard:registerEventHandler("transition_complete_keyframe", f4_local5)
		end,
		End = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.BlackForeground:beginAnimation(1000)
				f18_arg0.BlackForeground:setAlpha(1)
				f18_arg0.BlackForeground:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.BlackForeground:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.BlackForeground:completeAnimation()
			f18_arg0.BlackForeground:setAlpha(0)
			f18_local0(f18_arg0.BlackForeground)
		end,
	},
}
CoD.FinalKillcamWidget.__onClose = function(f20_arg0)
	f20_arg0.PlayerInfo:close()
	f20_arg0.CODGradientBacking:close()
	f20_arg0.killcamTitle:close()
	f20_arg0.AttackerPlayerCard:close()
end
