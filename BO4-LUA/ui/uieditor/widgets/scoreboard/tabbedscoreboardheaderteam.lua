CoD.TabbedScoreboardHeaderTeam = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderTeam.__defaultWidth = 740
CoD.TabbedScoreboardHeaderTeam.__defaultHeight = 134
CoD.TabbedScoreboardHeaderTeam.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeaderTeam)
	self.id = "TabbedScoreboardHeaderTeam"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TeamBacking = LUI.UIImage.new(0.5, 0.5, -355.5, 332.5, 0, 0, 0, 92)
	TeamBacking:setImage(RegisterImage(0xF98FF610AB331DA))
	TeamBacking:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamBacking:setRGB(f2_local0)
		end
	end)
	self:addElement(TeamBacking)
	self.TeamBacking = TeamBacking
	local TeamBackingAnim = LUI.UIImage.new(0.5, 0.5, -355.5, 332.5, 0, 0, 0, 92)
	TeamBackingAnim:setAlpha(0.17)
	TeamBackingAnim:setImage(RegisterImage(0xF98FF610AB331DA))
	TeamBackingAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	TeamBackingAnim:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TeamBackingAnim:setRGB(f3_local0)
		end
	end)
	self:addElement(TeamBackingAnim)
	self.TeamBackingAnim = TeamBackingAnim
	local TeamBotLineGlowAnim = LUI.UIImage.new(0, 0, 0, 740, 0, 0, 43.5, 133.5)
	TeamBotLineGlowAnim:setAlpha(0.17)
	TeamBotLineGlowAnim:setImage(RegisterImage(0x29B69305A070EF5))
	TeamBotLineGlowAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	TeamBotLineGlowAnim:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TeamBotLineGlowAnim:setRGB(f4_local0)
		end
	end)
	self:addElement(TeamBotLineGlowAnim)
	self.TeamBotLineGlowAnim = TeamBotLineGlowAnim
	local TeamBotLine = LUI.UIImage.new(0, 0, 14, 704, 0, 0, 83.5, 93.5)
	TeamBotLine:setImage(RegisterImage(0xCE30EC2995B2373))
	TeamBotLine:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TeamBotLine:setRGB(f5_local0)
		end
	end)
	self:addElement(TeamBotLine)
	self.TeamBotLine = TeamBotLine
	local TeamBotLineGlow = LUI.UIImage.new(0, 0, 0, 740, 0, 0, 43.5, 133.5)
	TeamBotLineGlow:setImage(RegisterImage(0x29B69305A070EF5))
	TeamBotLineGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	TeamBotLineGlow:setShaderVector(0, 1, 0, 0, 0)
	TeamBotLineGlow:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TeamBotLineGlow:setRGB(f6_local0)
		end
	end)
	self:addElement(TeamBotLineGlow)
	self.TeamBotLineGlow = TeamBotLineGlow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderTeam.__resetProperties = function(f7_arg0)
	f7_arg0.TeamBackingAnim:completeAnimation()
	f7_arg0.TeamBotLineGlowAnim:completeAnimation()
	f7_arg0.TeamBackingAnim:setAlpha(0.17)
	f7_arg0.TeamBotLineGlowAnim:setAlpha(0.17)
end
CoD.TabbedScoreboardHeaderTeam.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							f12_arg0:beginAnimation(1000)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
						end
						f11_arg0:beginAnimation(1100)
						f11_arg0:setAlpha(0.1)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(799)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.TeamBackingAnim:beginAnimation(1100)
				f8_arg0.TeamBackingAnim:setAlpha(0.8)
				f8_arg0.TeamBackingAnim:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.TeamBackingAnim:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.TeamBackingAnim:completeAnimation()
			f8_arg0.TeamBackingAnim:setAlpha(0.1)
			f8_local0(f8_arg0.TeamBackingAnim)
			local f8_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							f16_arg0:beginAnimation(1000)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
						end
						f15_arg0:beginAnimation(1200)
						f15_arg0:setAlpha(0.1)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(599)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f8_arg0.TeamBotLineGlowAnim:beginAnimation(1200)
				f8_arg0.TeamBotLineGlowAnim:setAlpha(0.9)
				f8_arg0.TeamBotLineGlowAnim:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.TeamBotLineGlowAnim:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f8_arg0.TeamBotLineGlowAnim:completeAnimation()
			f8_arg0.TeamBotLineGlowAnim:setAlpha(0.1)
			f8_local1(f8_arg0.TeamBotLineGlowAnim)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.TabbedScoreboardHeaderTeam.__onClose = function(f17_arg0)
	f17_arg0.TeamBacking:close()
	f17_arg0.TeamBackingAnim:close()
	f17_arg0.TeamBotLineGlowAnim:close()
	f17_arg0.TeamBotLine:close()
	f17_arg0.TeamBotLineGlow:close()
end
