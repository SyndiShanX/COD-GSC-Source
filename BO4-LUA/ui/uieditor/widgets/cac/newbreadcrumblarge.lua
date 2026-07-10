CoD.NewBreadcrumbLarge = InheritFrom(LUI.UIElement)
CoD.NewBreadcrumbLarge.__defaultWidth = 132
CoD.NewBreadcrumbLarge.__defaultHeight = 44
CoD.NewBreadcrumbLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NewBreadcrumbLarge)
	self.id = "NewBreadcrumbLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NewIcon = LUI.UIImage.new(0.5, 0.5, -56, 56, 0.5, 0.5, -12, 12)
	NewIcon:setImage(RegisterImage(@"uie_ui_icon_frontend_helptag2"))
	self:addElement(NewIcon)
	self.NewIcon = NewIcon
	local Glow = LUI.UIImage.new(0, 0, 0, 132, 0, 0, 0, 44)
	Glow:setScale(1.06, 1.12)
	Glow:setImage(RegisterImage(@"uie_ui_icon_frontend_helptag_glow02"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Glow:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLive()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NewBreadcrumbLarge.__resetProperties = function(f5_arg0)
	f5_arg0.Glow:completeAnimation()
	f5_arg0.NewIcon:completeAnimation()
	f5_arg0.Glow:setAlpha(1)
	f5_arg0.NewIcon:setAlpha(1)
end
CoD.NewBreadcrumbLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.NewIcon:completeAnimation()
			f6_arg0.NewIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NewIcon)
			f6_arg0.Glow:completeAnimation()
			f6_arg0.Glow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Glow)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f10_arg0:setAlpha(0.6)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f9_arg0:setAlpha(0.2)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.Glow:beginAnimation(500)
				f7_arg0.Glow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Glow:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Glow:completeAnimation()
			f7_arg0.Glow:setAlpha(0.6)
			f7_local0(f7_arg0.Glow)
			f7_arg0.nextClip = "DefaultClip"
		end,
		Intro = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(200)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.NewIcon:beginAnimation(200)
				f11_arg0.NewIcon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.NewIcon:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.NewIcon:completeAnimation()
			f11_arg0.NewIcon:setAlpha(0)
			f11_local0(f11_arg0.NewIcon)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							f17_arg0:beginAnimation(100)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f16_arg0:beginAnimation(299)
						f16_arg0:setAlpha(0.6)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(300)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f11_arg0.Glow:beginAnimation(300)
				f11_arg0.Glow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Glow:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.Glow:completeAnimation()
			f11_arg0.Glow:setAlpha(0)
			f11_local1(f11_arg0.Glow)
		end,
	},
}
