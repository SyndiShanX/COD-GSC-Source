require("x64:deb4c6e391aa750")
require("x64:31fac280b1c11fc")
CoD.NotificationRewardWidget = InheritFrom(LUI.UIElement)
CoD.NotificationRewardWidget.__defaultWidth = 384
CoD.NotificationRewardWidget.__defaultHeight = 96
CoD.NotificationRewardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NotificationRewardWidget)
	self.id = "NotificationRewardWidget"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PixelBacking = LUI.UIImage.new(0, 0, 312, 384, 0, 0, 12, 84)
	PixelBacking:setRGB(0.12, 0.12, 0.12)
	PixelBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	PixelBacking:setShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(PixelBacking)
	self.PixelBacking = PixelBacking
	local PixelGrid = LUI.UIImage.new(0, 0, 312, 384, 0, 0, 12, 84)
	PixelGrid:setAlpha(0.5)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(64, 64)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local ImageScanline = CoD.IconRewardWidget.new(f1_arg0, f1_arg1, 0, 0, 312, 384, 0, 0, 12, 84)
	ImageScanline:linkToElementModel(self, nil, false, function(model)
		ImageScanline:setModel(model, f1_arg1)
	end)
	self:addElement(ImageScanline)
	self.ImageScanline = ImageScanline
	local Text = LUI.UIText.new(1, 1, -384, -82, 0.5, 0.5, -15, 15)
	Text:setTTF("ttmussels_regular")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(Text)
	self.Text = Text
	local highlight = LUI.UIImage.new(0, 0, 252, 444, 0, 0, -48, 144)
	highlight:setImage(RegisterImage(@"uie_t7_hud_notficationhighlight"))
	highlight:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(highlight)
	self.highlight = highlight
	local Header = CoD.WeaponLevelUpHeaderStripe.new(f1_arg0, f1_arg1, 0, 0, 312, 384, 0, 0, 4, 12)
	Header.HeaderBacking:setRGB(0, 0, 0)
	Header.HeaderBacking:setShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(Header)
	self.Header = Header
	self.Text:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Text:setText(f3_local0)
		end
	end)
	self.highlight:linkToElementModel(self, "color", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			highlight:setRGB(f4_local0)
		end
	end)
	self.Header:linkToElementModel(self, nil, false, function(model)
		Header:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NotificationRewardWidget.__resetProperties = function(f6_arg0)
	f6_arg0.ImageScanline:completeAnimation()
	f6_arg0.highlight:completeAnimation()
	f6_arg0.Text:completeAnimation()
	f6_arg0.ImageScanline:setAlpha(1)
	f6_arg0.ImageScanline:setScale(1, 1)
	f6_arg0.highlight:setAlpha(1)
	f6_arg0.highlight:setZRot(0)
	f6_arg0.highlight:setScale(1, 1)
	f6_arg0.highlight:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	f6_arg0.Text:setAlpha(1)
end
CoD.NotificationRewardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							local f11_local0 = function(f12_arg0)
								local f12_local0 = function(f13_arg0)
									f13_arg0:beginAnimation(79)
									f13_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
								end
								f12_arg0:beginAnimation(30)
								f12_arg0:setAlpha(1)
								f12_arg0:setScale(1, 1)
								f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
							end
							f11_arg0:beginAnimation(60)
							f11_arg0:setAlpha(0.81)
							f11_arg0:setScale(0.95, 0.95)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
						end
						f10_arg0:beginAnimation(30)
						f10_arg0:setAlpha(0.44)
						f10_arg0:setScale(1, 1)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(39)
					f9_arg0:setAlpha(0.25)
					f9_arg0:setScale(1.86, 1.86)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.ImageScanline:beginAnimation(200)
				f7_arg0.ImageScanline:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ImageScanline:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.ImageScanline:completeAnimation()
			f7_arg0.ImageScanline:setAlpha(0)
			f7_arg0.ImageScanline:setScale(3, 3)
			f7_local0(f7_arg0.ImageScanline)
			local f7_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							f17_arg0:beginAnimation(30)
							f17_arg0:setAlpha(0)
							f17_arg0:setZRot(360)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
						end
						f16_arg0:beginAnimation(60)
						f16_arg0:setAlpha(0.5)
						f16_arg0:setZRot(292)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(70)
					f15_arg0:setAlpha(0.7)
					f15_arg0:setZRot(158)
					f15_arg0:setScale(1.5, 1.5)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f7_arg0.highlight:beginAnimation(200)
				f7_arg0.highlight:setAlpha(0.52)
				f7_arg0.highlight:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.highlight:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f7_arg0.highlight:completeAnimation()
			f7_arg0.highlight:setAlpha(0)
			f7_arg0.highlight:setZRot(0)
			f7_arg0.highlight:setScale(0, 0)
			f7_arg0.highlight:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f7_local1(f7_arg0.highlight)
		end,
		TimeUp = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						local f21_local0 = function(f22_arg0)
							local f22_local0 = function(f23_arg0)
								f23_arg0:beginAnimation(39, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
								f23_arg0:setAlpha(0)
								f23_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
							end
							f22_arg0:beginAnimation(40, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f22_arg0:setAlpha(0.6)
							f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
						end
						f21_arg0:beginAnimation(59, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f21_arg0:setAlpha(0)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
					end
					f20_arg0:beginAnimation(50)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f18_arg0.ImageScanline:beginAnimation(50)
				f18_arg0.ImageScanline:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ImageScanline:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.ImageScanline:completeAnimation()
			f18_arg0.ImageScanline:setAlpha(1)
			f18_local0(f18_arg0.ImageScanline)
			local f18_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							f27_arg0:beginAnimation(39, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f27_arg0:setAlpha(0)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
						end
						f26_arg0:beginAnimation(40, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f26_arg0:setAlpha(0.6)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(59, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
					f25_arg0:setAlpha(0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f18_arg0.Text:beginAnimation(100)
				f18_arg0.Text:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Text:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f18_arg0.Text:completeAnimation()
			f18_arg0.Text:setAlpha(1)
			f18_local1(f18_arg0.Text)
			f18_arg0.highlight:completeAnimation()
			f18_arg0.highlight:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.highlight)
		end,
	},
}
CoD.NotificationRewardWidget.__onClose = function(f28_arg0)
	f28_arg0.ImageScanline:close()
	f28_arg0.Text:close()
	f28_arg0.highlight:close()
	f28_arg0.Header:close()
end
