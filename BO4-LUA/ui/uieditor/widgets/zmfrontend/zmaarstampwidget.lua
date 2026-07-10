CoD.ZMAARStampWidget = InheritFrom(LUI.UIElement)
CoD.ZMAARStampWidget.__defaultWidth = 340
CoD.ZMAARStampWidget.__defaultHeight = 80
CoD.ZMAARStampWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARStampWidget)
	self.id = "ZMAARStampWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StampName = LUI.UIText.new(0, 0, -33, 291, 0, 0, 26.5, 51.5)
	StampName:setText(CoD.AARUtility.GetAARStamp(f1_arg1, "RED GREEN BLUE PURPLE"))
	StampName:setTTF("skorzhen")
	StampName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	StampName:setLetterSpacing(2)
	StampName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	StampName:setBackingType(2)
	StampName:setBackingXPadding(24)
	StampName:setBackingYPadding(8)
	StampName:setBackingImage(RegisterImage(@"uie_ui_hud_zm_aar_obj_bg"))
	self:addElement(StampName)
	self.StampName = StampName
	local Stamp = LUI.UIImage.new(0, 0, 290, 340, 0, 0, 15, 65)
	Stamp:setImage(RegisterImage(@"hash_151A5D15E57F49CE"))
	self:addElement(Stamp)
	self.Stamp = Stamp
	local URL = LUI.UIText.new(0, 0, 98, 298, 0, 0, 49, 65)
	URL:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4D8599B289858EC4"))
	URL:setTTF("dinnext_regular")
	URL:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(URL)
	self.URL = URL
	self:mergeStateConditions({
		{
			stateName = "Visible_Korea",
			condition = function(menu, element, event)
				local f2_local0 = IsZombies()
				if f2_local0 then
					if not IsLAN() then
						f2_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
						if f2_local0 then
							f2_local0 = IsCurrentLanguageKorean()
							if f2_local0 then
								f2_local0 = IsPC()
								if f2_local0 then
									f2_local0 = CoD.AARUtility.AARMatchIDValid(f1_arg1)
								end
							end
						end
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f3_local0 = IsZombies()
				if f3_local0 then
					if not IsLAN() then
						f3_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
						if f3_local0 then
							f3_local0 = CoD.BaseUtility.IsDvarEnabled("ui_showZMAARStamp")
							if f3_local0 then
								f3_local0 = CoD.AARUtility.AARMatchIDValid(f1_arg1)
							end
						end
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["AAR.activeTab"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARStampWidget.__resetProperties = function(f7_arg0)
	f7_arg0.Stamp:completeAnimation()
	f7_arg0.StampName:completeAnimation()
	f7_arg0.URL:completeAnimation()
	f7_arg0.Stamp:setAlpha(1)
	f7_arg0.StampName:setTopBottom(0, 0, 26.5, 51.5)
	f7_arg0.StampName:setAlpha(1)
	f7_arg0.URL:setTopBottom(0, 0, 49, 65)
	f7_arg0.URL:setAlpha(1)
end
CoD.ZMAARStampWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.StampName:completeAnimation()
			f8_arg0.StampName:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.StampName)
			f8_arg0.Stamp:completeAnimation()
			f8_arg0.Stamp:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Stamp)
			f8_arg0.URL:completeAnimation()
			f8_arg0.URL:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.URL)
		end,
	},
	Visible_Korea = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.StampName:completeAnimation()
			f9_arg0.StampName:setTopBottom(0, 0, 26.5, 46.5)
			f9_arg0.clipFinished(f9_arg0.StampName)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(500)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.Stamp:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f9_arg0.Stamp:setAlpha(0.5)
				f9_arg0.Stamp:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Stamp:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.Stamp:completeAnimation()
			f9_arg0.Stamp:setAlpha(1)
			f9_local0(f9_arg0.Stamp)
			f9_arg0.URL:completeAnimation()
			f9_arg0.URL:setTopBottom(0, 0, 49, 64)
			f9_arg0.clipFinished(f9_arg0.URL)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
	Visible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(500)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.Stamp:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f13_arg0.Stamp:setAlpha(0.5)
				f13_arg0.Stamp:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Stamp:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.Stamp:completeAnimation()
			f13_arg0.Stamp:setAlpha(1)
			f13_local0(f13_arg0.Stamp)
			f13_arg0.nextClip = "DefaultClip"
		end,
	},
}
if not CoD.isPC then
	CoD.ZMAARStampWidget.__clipsPerState.Visible_Korea.DefaultClip = nil
end
