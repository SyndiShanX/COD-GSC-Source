CoD.TabletTak5_PlayerHealthInfo = InheritFrom(LUI.UIElement)
CoD.TabletTak5_PlayerHealthInfo.__defaultWidth = 124
CoD.TabletTak5_PlayerHealthInfo.__defaultHeight = 230
CoD.TabletTak5_PlayerHealthInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletTak5_PlayerHealthInfo)
	self.id = "TabletTak5_PlayerHealthInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BoostFlash = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BoostFlash:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	BoostFlash:setAlpha(0)
	BoostFlash:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scanlines"))
	BoostFlash:setShaderVector(0, 2, 0, 0, 0)
	BoostFlash:setShaderVector(1, 0.4, 0, 0, 0)
	BoostFlash:setShaderVector(2, 0.01, 0, 0, 0)
	self:addElement(BoostFlash)
	self.BoostFlash = BoostFlash
	local BoostSlide = LUI.UIImage.new(0.5, 0.5, -62, 62, 0, 0, 230, 230)
	BoostSlide:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	BoostSlide:setAlpha(0.5)
	self:addElement(BoostSlide)
	self.BoostSlide = BoostSlide
	local PlayerImage = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -90, 90)
	PlayerImage:setAlpha(0.3)
	PlayerImage:setImage(RegisterImage(@"uie_ui_hud_tak5_humanbody"))
	self:addElement(PlayerImage)
	self.PlayerImage = PlayerImage
	local PlayerImageHealthWipe = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -90, 90)
	PlayerImageHealthWipe:setAlpha(0)
	PlayerImageHealthWipe:setImage(RegisterImage(@"uie_ui_hud_tak5_humanbody"))
	PlayerImageHealthWipe:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	PlayerImageHealthWipe:setShaderVector(0, 0, 1, 0, 0)
	PlayerImageHealthWipe:setShaderVector(1, 0, 0, 0, 0)
	PlayerImageHealthWipe:setShaderVector(3, 0, 0, 0, 0)
	PlayerImageHealthWipe:setShaderVector(4, 0, 0, 0, 0)
	PlayerImageHealthWipe.__Y_Start___Y_End = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			PlayerImageHealthWipe:setShaderVector(2, SetVectorComponent(2, 1, SubtractVectorComponentFrom(1, 1, CoD.HUDUtility.DivideByPlayerMaxHealth(self:getModel(), f1_arg1, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))))
		end
	end
	PlayerImageHealthWipe:linkToElementModel(self, "health.healthValue", true, PlayerImageHealthWipe.__Y_Start___Y_End)
	PlayerImageHealthWipe.__Y_Start___Y_End_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0["health.healthValue"]
		end
		if f3_local0 then
			PlayerImageHealthWipe.__Y_Start___Y_End(f3_local0)
		end
	end
	self:addElement(PlayerImageHealthWipe)
	self.PlayerImageHealthWipe = PlayerImageHealthWipe
	local playeroutline = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -90, 90)
	playeroutline:setAlpha(0.25)
	playeroutline:setImage(RegisterImage(@"uie_ui_hud_tak5_humanbody_outline"))
	self:addElement(playeroutline)
	self.playeroutline = playeroutline
	local playeroutlineAdd = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -90, 90)
	playeroutlineAdd:setAlpha(0.4)
	playeroutlineAdd:setImage(RegisterImage(@"uie_ui_hud_tak5_humanbody_outline"))
	playeroutlineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	playeroutlineAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(playeroutlineAdd)
	self.playeroutlineAdd = playeroutlineAdd
	local PlayerImageLine = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -90, 90)
	PlayerImageLine:setAlpha(0.3)
	PlayerImageLine:setImage(RegisterImage(@"uie_ui_hud_tak5_humanbody"))
	PlayerImageLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scanlines"))
	PlayerImageLine:setShaderVector(0, 2, 0, 0, 0)
	PlayerImageLine:setShaderVector(1, 1.5, 0, 0, 0)
	PlayerImageLine:setShaderVector(2, 0.01, 0, 0, 0)
	self:addElement(PlayerImageLine)
	self.PlayerImageLine = PlayerImageLine
	PlayerImageHealthWipe:linkToElementModel(self, "health.maxHealth", true, PlayerImageHealthWipe.__Y_Start___Y_End_FullPath)
	PlayerImageHealthWipe:linkToElementModel(self, "health.maxHealthRegen", true, PlayerImageHealthWipe.__Y_Start___Y_End_FullPath)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f4_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"localheal_fire") and CoD.ModelUtility.IsScriptNotifyDataArgEqualTo(model, 1, 1) then
			PlayClip(self, "HealthBoost", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletTak5_PlayerHealthInfo.__resetProperties = function(f5_arg0)
	f5_arg0.playeroutlineAdd:completeAnimation()
	f5_arg0.playeroutline:completeAnimation()
	f5_arg0.PlayerImageHealthWipe:completeAnimation()
	f5_arg0.PlayerImage:completeAnimation()
	f5_arg0.BoostFlash:completeAnimation()
	f5_arg0.BoostSlide:completeAnimation()
	f5_arg0.playeroutlineAdd:setAlpha(0.4)
	f5_arg0.playeroutline:setAlpha(0.25)
	f5_arg0.PlayerImageHealthWipe:setAlpha(0)
	f5_arg0.PlayerImage:setAlpha(0.3)
	f5_arg0.BoostFlash:setAlpha(0)
	f5_arg0.BoostSlide:setTopBottom(0, 0, 230, 230)
	f5_arg0.BoostSlide:setAlpha(0.5)
end
CoD.TabletTak5_PlayerHealthInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.PlayerImage:completeAnimation()
			f6_arg0.PlayerImage:setAlpha(0.3)
			f6_arg0.clipFinished(f6_arg0.PlayerImage)
			f6_arg0.PlayerImageHealthWipe:completeAnimation()
			f6_arg0.PlayerImageHealthWipe:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.PlayerImageHealthWipe)
			f6_arg0.playeroutline:completeAnimation()
			f6_arg0.playeroutline:setAlpha(0.2)
			f6_arg0.clipFinished(f6_arg0.playeroutline)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f8_arg0:setAlpha(0.1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.playeroutlineAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f6_arg0.playeroutlineAdd:setAlpha(0)
				f6_arg0.playeroutlineAdd:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.playeroutlineAdd:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.playeroutlineAdd:completeAnimation()
			f6_arg0.playeroutlineAdd:setAlpha(0.1)
			f6_local0(f6_arg0.playeroutlineAdd)
			f6_arg0.nextClip = "DefaultClip"
		end,
		HealthBoost = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							local f13_local0 = function(f14_arg0)
								local f14_local0 = function(f15_arg0)
									local f15_local0 = function(f16_arg0)
										local f16_local0 = function(f17_arg0)
											local f17_local0 = function(f18_arg0)
												local f18_local0 = function(f19_arg0)
													local f19_local0 = function(f20_arg0)
														local f20_local0 = function(f21_arg0)
															f21_arg0:beginAnimation(500)
															f21_arg0:setAlpha(0)
															f21_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
														end
														f20_arg0:beginAnimation(300)
														f20_arg0:setAlpha(0.2)
														f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
													end
													f19_arg0:beginAnimation(19)
													f19_arg0:setAlpha(0)
													f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
												end
												f18_arg0:beginAnimation(20)
												f18_arg0:setAlpha(0.2)
												f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
											end
											f17_arg0:beginAnimation(19)
											f17_arg0:setAlpha(0)
											f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
										end
										f16_arg0:beginAnimation(20)
										f16_arg0:setAlpha(0.2)
										f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
									end
									f15_arg0:beginAnimation(19)
									f15_arg0:setAlpha(0)
									f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
								end
								f14_arg0:beginAnimation(20)
								f14_arg0:setAlpha(0.2)
								f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
							end
							f13_arg0:beginAnimation(20)
							f13_arg0:setAlpha(0)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
						end
						f12_arg0:beginAnimation(20)
						f12_arg0:setAlpha(0.2)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(20)
					f11_arg0:setAlpha(0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.BoostFlash:beginAnimation(20)
				f9_arg0.BoostFlash:setAlpha(0.2)
				f9_arg0.BoostFlash:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.BoostFlash:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.BoostFlash:completeAnimation()
			f9_arg0.BoostFlash:setAlpha(0)
			f9_local0(f9_arg0.BoostFlash)
			local f9_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f23_arg0:setTopBottom(0, 0, 0, 230)
					f23_arg0:setAlpha(0)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.BoostSlide:beginAnimation(200)
				f9_arg0.BoostSlide:setAlpha(0.25)
				f9_arg0.BoostSlide:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.BoostSlide:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f9_arg0.BoostSlide:completeAnimation()
			f9_arg0.BoostSlide:setTopBottom(0, 0, 230, 230)
			f9_arg0.BoostSlide:setAlpha(0.5)
			f9_local1(f9_arg0.BoostSlide)
			local f9_local2 = function(f24_arg0)
				f9_arg0.PlayerImageHealthWipe:beginAnimation(200)
				f9_arg0.PlayerImageHealthWipe:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.PlayerImageHealthWipe:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.PlayerImageHealthWipe:completeAnimation()
			f9_arg0.PlayerImageHealthWipe:setAlpha(0)
			f9_local2(f9_arg0.PlayerImageHealthWipe)
			local f9_local3 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(300)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.playeroutline:beginAnimation(200)
				f9_arg0.playeroutline:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.playeroutline:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f9_arg0.playeroutline:completeAnimation()
			f9_arg0.playeroutline:setAlpha(0.15)
			f9_local3(f9_arg0.playeroutline)
			local f9_local4 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						local f29_local0 = function(f30_arg0)
							f30_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_in"])
							f30_arg0:setAlpha(0.1)
							f30_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
						end
						f29_arg0:beginAnimation(300)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
					end
					f28_arg0:beginAnimation(300)
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f9_arg0.playeroutlineAdd:beginAnimation(200)
				f9_arg0.playeroutlineAdd:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.playeroutlineAdd:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f9_arg0.playeroutlineAdd:completeAnimation()
			f9_arg0.playeroutlineAdd:setAlpha(0.1)
			f9_local4(f9_arg0.playeroutlineAdd)
		end,
	},
}
CoD.TabletTak5_PlayerHealthInfo.__onClose = function(f31_arg0)
	f31_arg0.PlayerImageHealthWipe:close()
end
