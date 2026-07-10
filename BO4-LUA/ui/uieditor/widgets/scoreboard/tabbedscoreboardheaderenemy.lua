CoD.TabbedScoreboardHeaderEnemy = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderEnemy.__defaultWidth = 740
CoD.TabbedScoreboardHeaderEnemy.__defaultHeight = 133
CoD.TabbedScoreboardHeaderEnemy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeaderEnemy)
	self.id = "TabbedScoreboardHeaderEnemy"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EnemeyBacking = LUI.UIImage.new(0.5, 0.5, -332, 356, 0, 0, 0, 92)
	EnemeyBacking:setYRot(180)
	EnemeyBacking:setImage(RegisterImage(0xF98FF610AB331DA))
	EnemeyBacking:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnemeyBacking:setRGB(f2_local0)
		end
	end)
	self:addElement(EnemeyBacking)
	self.EnemeyBacking = EnemeyBacking
	local EnemeyBackingAnim = LUI.UIImage.new(0.5, 0.5, -332, 356, 0, 0, 0, 92)
	EnemeyBackingAnim:setAlpha(0.1)
	EnemeyBackingAnim:setYRot(180)
	EnemeyBackingAnim:setImage(RegisterImage(0xF98FF610AB331DA))
	EnemeyBackingAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	EnemeyBackingAnim:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemeyBackingAnim:setRGB(f3_local0)
		end
	end)
	self:addElement(EnemeyBackingAnim)
	self.EnemeyBackingAnim = EnemeyBackingAnim
	local EnemyBotLineGlowAnim = LUI.UIImage.new(0, 0, 0, 740, 0, 0, 43, 133)
	EnemyBotLineGlowAnim:setAlpha(0.5)
	EnemyBotLineGlowAnim:setYRot(180)
	EnemyBotLineGlowAnim:setImage(RegisterImage(0x29B69305A070EF5))
	EnemyBotLineGlowAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	EnemyBotLineGlowAnim:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EnemyBotLineGlowAnim:setRGB(f4_local0)
		end
	end)
	self:addElement(EnemyBotLineGlowAnim)
	self.EnemyBotLineGlowAnim = EnemyBotLineGlowAnim
	local EnemyBotLine = LUI.UIImage.new(0, 0, 36, 726, 0, 0, 83, 93)
	EnemyBotLine:setYRot(180)
	EnemyBotLine:setImage(RegisterImage(0xCE30EC2995B2373))
	EnemyBotLine:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EnemyBotLine:setRGB(f5_local0)
		end
	end)
	self:addElement(EnemyBotLine)
	self.EnemyBotLine = EnemyBotLine
	local EnemyBotLineGlow = LUI.UIImage.new(0, 0, 0, 740, 0, 0, 43, 133)
	EnemyBotLineGlow:setAlpha(0.5)
	EnemyBotLineGlow:setYRot(180)
	EnemyBotLineGlow:setImage(RegisterImage(0x29B69305A070EF5))
	EnemyBotLineGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	EnemyBotLineGlow:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			EnemyBotLineGlow:setRGB(f6_local0)
		end
	end)
	self:addElement(EnemyBotLineGlow)
	self.EnemyBotLineGlow = EnemyBotLineGlow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderEnemy.__resetProperties = function(f7_arg0)
	f7_arg0.EnemyBotLineGlowAnim:completeAnimation()
	f7_arg0.EnemeyBackingAnim:completeAnimation()
	f7_arg0.EnemyBotLineGlowAnim:setAlpha(0.5)
	f7_arg0.EnemeyBackingAnim:setAlpha(0.1)
end
CoD.TabbedScoreboardHeaderEnemy.__clipsPerState = {
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
				f8_arg0.EnemeyBackingAnim:beginAnimation(1100)
				f8_arg0.EnemeyBackingAnim:setAlpha(0.8)
				f8_arg0.EnemeyBackingAnim:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.EnemeyBackingAnim:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.EnemeyBackingAnim:completeAnimation()
			f8_arg0.EnemeyBackingAnim:setAlpha(0.1)
			f8_local0(f8_arg0.EnemeyBackingAnim)
			local f8_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							f16_arg0:beginAnimation(1000)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
						end
						f15_arg0:beginAnimation(1200)
						f15_arg0:setAlpha(0)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(599)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f8_arg0.EnemyBotLineGlowAnim:beginAnimation(1200)
				f8_arg0.EnemyBotLineGlowAnim:setAlpha(0.9)
				f8_arg0.EnemyBotLineGlowAnim:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.EnemyBotLineGlowAnim:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f8_arg0.EnemyBotLineGlowAnim:completeAnimation()
			f8_arg0.EnemyBotLineGlowAnim:setAlpha(0)
			f8_local1(f8_arg0.EnemyBotLineGlowAnim)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.TabbedScoreboardHeaderEnemy.__onClose = function(f17_arg0)
	f17_arg0.EnemeyBacking:close()
	f17_arg0.EnemeyBackingAnim:close()
	f17_arg0.EnemyBotLineGlowAnim:close()
	f17_arg0.EnemyBotLine:close()
	f17_arg0.EnemyBotLineGlow:close()
end
