CoD.WarzoneKillsCount = InheritFrom(LUI.UIElement)
CoD.WarzoneKillsCount.__defaultWidth = 69
CoD.WarzoneKillsCount.__defaultHeight = 32
CoD.WarzoneKillsCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneKillsCount)
	self.id = "WarzoneKillsCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow2 = LUI.UIImage.new(0, 0, -9, 77, 0, 0, -6, 38)
	Glow2:setRGB(1, 0, 0)
	Glow2:setAlpha(0)
	Glow2:setImage(RegisterImage(0xC58FF2328701EBA))
	Glow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow2)
	self.Glow2 = Glow2
	local Glow = LUI.UIImage.new(0, 0, 24.5, 74.5, 0, 0, -16, 48)
	Glow:setRGB(1, 0, 0)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0x65BA0231BD57E0B))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local PlayerKills = LUI.UIText.new(1, 1, -42.5, -0.5, 0, 0, 5, 27)
	PlayerKills:setTTF("0arame_mono_stencil")
	PlayerKills:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	PlayerKills:setShaderVector(0, 0.8, 0, 0, 0)
	PlayerKills:setShaderVector(1, 0, 0, 0, 0)
	PlayerKills:setShaderVector(2, 1, 1, 1, 0.35)
	PlayerKills:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayerKills:subscribeToGlobalModel(f1_arg1, "HUDItems", "playerKills", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerKills:setText(f2_local0)
		end
	end)
	self:addElement(PlayerKills)
	self.PlayerKills = PlayerKills
	local PlayerKillsAdd = LUI.UIText.new(1, 1, -42.5, -0.5, 0, 0, 5, 27)
	PlayerKillsAdd:setRGB(0.98, 0.18, 0.1)
	PlayerKillsAdd:setAlpha(0)
	PlayerKillsAdd:setTTF("0arame_mono_stencil")
	PlayerKillsAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	PlayerKillsAdd:setShaderVector(0, 0, 0, 0, 0)
	PlayerKillsAdd:setShaderVector(1, 0, 0, 0, 0)
	PlayerKillsAdd:setShaderVector(2, 1, 1, 1, 0)
	PlayerKillsAdd:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	PlayerKillsAdd:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayerKillsAdd:subscribeToGlobalModel(f1_arg1, "HUDItems", "playerKills", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerKillsAdd:setText(f3_local0)
		end
	end)
	self:addElement(PlayerKillsAdd)
	self.PlayerKillsAdd = PlayerKillsAdd
	local playerKillsIcon = LUI.UIImage.new(1, 1, -69, -37, 0, 0, 0, 32)
	playerKillsIcon:setImage(RegisterImage(0x5EFE28D1E8EB917))
	self:addElement(playerKillsIcon)
	self.playerKillsIcon = playerKillsIcon
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.playerKills", function(model)
		local f4_local0 = self
		PlayClip(self, "KillCount", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneKillsCount.__resetProperties = function(f5_arg0)
	f5_arg0.PlayerKills:completeAnimation()
	f5_arg0.playerKillsIcon:completeAnimation()
	f5_arg0.PlayerKillsAdd:completeAnimation()
	f5_arg0.Glow:completeAnimation()
	f5_arg0.Glow2:completeAnimation()
	f5_arg0.PlayerKills:setRGB(1, 1, 1)
	f5_arg0.PlayerKills:setAlpha(1)
	f5_arg0.PlayerKills:setScale(1, 1)
	f5_arg0.playerKillsIcon:setRGB(1, 1, 1)
	f5_arg0.PlayerKillsAdd:setRGB(0.98, 0.18, 0.1)
	f5_arg0.PlayerKillsAdd:setAlpha(0)
	f5_arg0.PlayerKillsAdd:setScale(1, 1)
	f5_arg0.Glow:setAlpha(0)
	f5_arg0.Glow:setScale(1, 1)
	f5_arg0.Glow2:setAlpha(0)
	f5_arg0.Glow2:setScale(1, 1)
end
CoD.WarzoneKillsCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		KillCount = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(5)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(380)
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(229)
					f9_arg0:setAlpha(0.59)
					f9_arg0:setScale(0, 1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.Glow2:beginAnimation(160)
				f7_arg0.Glow2:setAlpha(0.94)
				f7_arg0.Glow2:setScale(2, 2)
				f7_arg0.Glow2:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Glow2:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Glow2:completeAnimation()
			f7_arg0.Glow2:setAlpha(0)
			f7_arg0.Glow2:setScale(1, 1)
			f7_local0(f7_arg0.Glow2)
			local f7_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(229)
					f12_arg0:setScale(1.32, 0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.Glow:beginAnimation(160)
				f7_arg0.Glow:setAlpha(1)
				f7_arg0.Glow:setScale(2.25, 4.03)
				f7_arg0.Glow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Glow:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f7_arg0.Glow:completeAnimation()
			f7_arg0.Glow:setAlpha(0)
			f7_arg0.Glow:setScale(1.99, 2.97)
			f7_local1(f7_arg0.Glow)
			local f7_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(100)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(229, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f14_arg0:setScale(1, 1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f7_arg0.PlayerKills:beginAnimation(160)
				f7_arg0.PlayerKills:setScale(3, 3)
				f7_arg0.PlayerKills:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.PlayerKills:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f7_arg0.PlayerKills:completeAnimation()
			f7_arg0.PlayerKills:setRGB(1, 1, 1)
			f7_arg0.PlayerKills:setAlpha(1)
			f7_arg0.PlayerKills:setScale(1, 1)
			f7_local2(f7_arg0.PlayerKills)
			local f7_local3 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						f18_arg0:beginAnimation(110)
						f18_arg0:setAlpha(0)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f17_arg0:beginAnimation(220)
					f17_arg0:setAlpha(0.5)
					f17_arg0:setScale(1, 1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f7_arg0.PlayerKillsAdd:beginAnimation(160)
				f7_arg0.PlayerKillsAdd:setRGB(1, 1, 1)
				f7_arg0.PlayerKillsAdd:setAlpha(0.8)
				f7_arg0.PlayerKillsAdd:setScale(5, 5)
				f7_arg0.PlayerKillsAdd:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.PlayerKillsAdd:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f7_arg0.PlayerKillsAdd:completeAnimation()
			f7_arg0.PlayerKillsAdd:setRGB(0.98, 0.18, 0.1)
			f7_arg0.PlayerKillsAdd:setAlpha(0)
			f7_arg0.PlayerKillsAdd:setScale(6, 6)
			f7_local3(f7_arg0.PlayerKillsAdd)
			local f7_local4 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(229)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.playerKillsIcon:beginAnimation(160)
				f7_arg0.playerKillsIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.playerKillsIcon:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f7_arg0.playerKillsIcon:completeAnimation()
			f7_arg0.playerKillsIcon:setRGB(1, 1, 1)
			f7_local4(f7_arg0.playerKillsIcon)
		end,
	},
}
CoD.WarzoneKillsCount.__onClose = function(f21_arg0)
	f21_arg0.PlayerKills:close()
	f21_arg0.PlayerKillsAdd:close()
end
