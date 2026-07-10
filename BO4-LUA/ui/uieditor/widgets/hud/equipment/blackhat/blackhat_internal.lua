require("x64:c27a1a96def59e1")
require("x64:ccc321a04048e72")
require("x64:a550abac220aafe")
CoD.BlackHat_Internal = InheritFrom(LUI.UIElement)
CoD.BlackHat_Internal.__defaultWidth = 384
CoD.BlackHat_Internal.__defaultHeight = 384
CoD.BlackHat_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.HUDUtility.BlackHatPreLoad(self, f1_arg1)
	self:setClass(CoD.BlackHat_Internal)
	self.id = "BlackHat_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BLACKBG = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BLACKBG:setRGB(0, 0, 0)
	self:addElement(BLACKBG)
	self.BLACKBG = BLACKBG
	local BgScanning = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BgScanning:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_scanning"))
	self:addElement(BgScanning)
	self.BgScanning = BgScanning
	local BgScanningDetail = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BgScanningDetail:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_scanningdetail"))
	self:addElement(BgScanningDetail)
	self.BgScanningDetail = BgScanningDetail
	local BgHacking = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BgHacking:setAlpha(0)
	BgHacking:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_hacking"))
	self:addElement(BgHacking)
	self.BgHacking = BgHacking
	local BgHackingDetail = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BgHackingDetail:setAlpha(0)
	BgHackingDetail:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_hackingdetail"))
	self:addElement(BgHackingDetail)
	self.BgHackingDetail = BgHackingDetail
	local BgBreaching = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BgBreaching:setAlpha(0)
	BgBreaching:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_breaching"))
	self:addElement(BgBreaching)
	self.BgBreaching = BgBreaching
	local BgBreachingDetail = LUI.UIImage.new(0, 1, -36, 40, 0, 1, 0, 0)
	BgBreachingDetail:setAlpha(0)
	BgBreachingDetail:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_breachingdetail"))
	self:addElement(BgBreachingDetail)
	self.BgBreachingDetail = BgBreachingDetail
	local BgError = LUI.UIImage.new(0, 0, -36, 423, 0, 0, 0, 384)
	BgError:setAlpha(0)
	BgError:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_error"))
	self:addElement(BgError)
	self.BgError = BgError
	local BgErrorDetail = LUI.UIImage.new(0, 0, -36, 424, 0, 0, 0, 384)
	BgErrorDetail:setAlpha(0)
	BgErrorDetail:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_errordetail"))
	self:addElement(BgErrorDetail)
	self.BgErrorDetail = BgErrorDetail
	local BgErrorXmarks = LUI.UIImage.new(0, 0, -36, 424, 0, 0, 0, 384)
	BgErrorXmarks:setAlpha(0)
	BgErrorXmarks:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_error_xmarks"))
	self:addElement(BgErrorXmarks)
	self.BgErrorXmarks = BgErrorXmarks
	local BgErrorStripes = LUI.UIImage.new(0, 0, -36, 424, 0, 0, 0, 384)
	BgErrorStripes:setAlpha(0)
	BgErrorStripes:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_error_stripes"))
	self:addElement(BgErrorStripes)
	self.BgErrorStripes = BgErrorStripes
	local BgErrorIcon = LUI.UIImage.new(0, 0, -36, 424, 0, 0, 0, 384)
	BgErrorIcon:setAlpha(0)
	BgErrorIcon:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_error_icon"))
	self:addElement(BgErrorIcon)
	self.BgErrorIcon = BgErrorIcon
	local BfErrorIconGlow = LUI.UIImage.new(0, 0, -36, 424, 0, 0, 0, 384)
	BfErrorIconGlow:setAlpha(0)
	BfErrorIconGlow:setImage(RegisterImage(@"uie_t7_hud_blackhat_bg_error_iconglow"))
	self:addElement(BfErrorIconGlow)
	self.BfErrorIconGlow = BfErrorIconGlow
	local IconScanning = LUI.UIImage.new(0, 1, -9, -295, 0, 1, 248, 0)
	IconScanning:setAlpha(0)
	IconScanning:setScale(0.8, 0.8)
	IconScanning:setImage(RegisterImage(@"uie_t7_hud_blackhat_iconscanning"))
	self:addElement(IconScanning)
	self.IconScanning = IconScanning
	local IconBreaching = LUI.UIImage.new(0, 1, -9, -295, 0, 1, 248, 0)
	IconBreaching:setAlpha(0)
	IconBreaching:setScale(0.8, 0.8)
	IconBreaching:setImage(RegisterImage(@"uie_t7_hud_blackhat_iconbreaching"))
	self:addElement(IconBreaching)
	self.IconBreaching = IconBreaching
	local IconHacking = LUI.UIImage.new(0, 1, -9, -295, 0, 1, 248, 0)
	IconHacking:setAlpha(0)
	IconHacking:setScale(0.8, 0.8)
	IconHacking:setImage(RegisterImage(@"uie_t7_hud_blackhat_iconhacking"))
	self:addElement(IconHacking)
	self.IconHacking = IconHacking
	local StatusText = LUI.UIText.new(0, 0, 24, 360, 0, 0, 297, 333)
	StatusText:setText("")
	StatusText:setTTF("default")
	StatusText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatusText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatusText)
	self.StatusText = StatusText
	local PercentText = LUI.UIText.new(0, 0, 325, 377, 0, 0, 296, 334)
	PercentText:setTTF("default")
	PercentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PercentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PercentText:subscribeToGlobalModel(f1_arg1, "Blackhat", "perc", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PercentText:setText(BlackhatHackingPercentage(f2_local0))
		end
	end)
	self:addElement(PercentText)
	self.PercentText = PercentText
	local Spinner = LUI.UIImage.new(0, 0, 7, 75, 0, 0, 279, 351)
	Spinner:setRGB(0.85, 0.09, 0.73)
	Spinner:setAlpha(0)
	self:addElement(Spinner)
	self.Spinner = Spinner
	local HackingBarRight = CoD.HackingBar.new(f1_arg0, f1_arg1, 0, 0, 309, 425, 0, 0, 62, 234)
	self:addElement(HackingBarRight)
	self.HackingBarRight = HackingBarRight
	local HackingBarLeft = CoD.HackingBar.new(f1_arg0, f1_arg1, 0, 0, -40, 76, 0, 0, 62, 234)
	HackingBarLeft:setYRot(180)
	self:addElement(HackingBarLeft)
	self.HackingBarLeft = HackingBarLeft
	local WaveformBlackHat = CoD.WaveformBlackHat.new(f1_arg0, f1_arg1, 0, 0, 37.5, 346.5, 0, 0, 19, 279)
	self:addElement(WaveformBlackHat)
	self.WaveformBlackHat = WaveformBlackHat
	local blackhatEmp0 = CoD.blackhatEmp.new(f1_arg0, f1_arg1, 0.5, 0.5, -149, 155, 0.5, 0.5, -126, 126)
	blackhatEmp0:setAlpha(0)
	blackhatEmp0:setScale(1.5, 1.5)
	self:addElement(blackhatEmp0)
	self.blackhatEmp0 = blackhatEmp0
	self:mergeStateConditions({
		{
			stateName = "TeamHacking",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.blackhat.status", CoD.HUDUtility.BlackhatStatus.Hacking) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lockedOnEnemyTeamHacking")
			end,
		},
		{
			stateName = "Hacking",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.blackhat.status", CoD.HUDUtility.BlackhatStatus.Hacking)
			end,
		},
		{
			stateName = "Breaching",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.blackhat.status", CoD.HUDUtility.BlackhatStatus.Breaching)
			end,
		},
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
			end,
		},
	})
	local f1_local24 = self
	local f1_local25 = self.subscribeToModel
	local f1_local26 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local25(f1_local24, f1_local26["hudItems.blackhat.status"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.blackhat.status",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local25(f1_local24, f1_local26.lockedOnEnemyTeamHacking, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lockedOnEnemyTeamHacking",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local25(f1_local24, f1_local26["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BlackHat_Internal.__resetProperties = function(f11_arg0)
	f11_arg0.BgScanningDetail:completeAnimation()
	f11_arg0.StatusText:completeAnimation()
	f11_arg0.IconScanning:completeAnimation()
	f11_arg0.PercentText:completeAnimation()
	f11_arg0.BgHackingDetail:completeAnimation()
	f11_arg0.BgHacking:completeAnimation()
	f11_arg0.BgScanning:completeAnimation()
	f11_arg0.IconHacking:completeAnimation()
	f11_arg0.BgBreachingDetail:completeAnimation()
	f11_arg0.BgBreaching:completeAnimation()
	f11_arg0.IconBreaching:completeAnimation()
	f11_arg0.BgError:completeAnimation()
	f11_arg0.BgErrorDetail:completeAnimation()
	f11_arg0.BfErrorIconGlow:completeAnimation()
	f11_arg0.BgErrorXmarks:completeAnimation()
	f11_arg0.BgErrorStripes:completeAnimation()
	f11_arg0.BgErrorIcon:completeAnimation()
	f11_arg0.blackhatEmp0:completeAnimation()
	f11_arg0.HackingBarRight:completeAnimation()
	f11_arg0.HackingBarLeft:completeAnimation()
	f11_arg0.WaveformBlackHat:completeAnimation()
	f11_arg0.BgScanningDetail:setAlpha(1)
	f11_arg0.BgScanningDetail:setScale(1, 1)
	f11_arg0.StatusText:setAlpha(1)
	f11_arg0.StatusText:setText("")
	f11_arg0.IconScanning:setAlpha(0)
	f11_arg0.IconScanning:setScale(0.8, 0.8)
	f11_arg0.PercentText:setAlpha(1)
	f11_arg0.BgHackingDetail:setAlpha(0)
	f11_arg0.BgHacking:setAlpha(0)
	f11_arg0.BgScanning:setAlpha(1)
	f11_arg0.IconHacking:setAlpha(0)
	f11_arg0.IconHacking:setScale(0.8, 0.8)
	f11_arg0.BgBreachingDetail:setAlpha(0)
	f11_arg0.BgBreaching:setAlpha(0)
	f11_arg0.IconBreaching:setAlpha(0)
	f11_arg0.IconBreaching:setScale(0.8, 0.8)
	f11_arg0.BgError:setAlpha(0)
	f11_arg0.BgErrorDetail:setAlpha(0)
	f11_arg0.BfErrorIconGlow:setAlpha(0)
	f11_arg0.BgErrorXmarks:setAlpha(0)
	f11_arg0.BgErrorXmarks:setScale(1, 1)
	f11_arg0.BgErrorStripes:setAlpha(0)
	f11_arg0.BgErrorIcon:setAlpha(0)
	f11_arg0.BgErrorIcon:setScale(1, 1)
	f11_arg0.blackhatEmp0:setAlpha(0)
	f11_arg0.HackingBarRight:setAlpha(1)
	f11_arg0.HackingBarLeft:setAlpha(1)
	f11_arg0.WaveformBlackHat:setAlpha(1)
end
CoD.BlackHat_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								local f17_local0 = function(f18_arg0)
									local f18_local0 = function(f19_arg0)
										f19_arg0:beginAnimation(20)
										f19_arg0:setAlpha(1)
										f19_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
									end
									f18_arg0:beginAnimation(19)
									f18_arg0:setAlpha(0.5)
									f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
								end
								f17_arg0:beginAnimation(19)
								f17_arg0:setAlpha(1)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
							end
							f16_arg0:beginAnimation(20)
							f16_arg0:setAlpha(0.5)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(19)
						f15_arg0:setAlpha(1)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(19)
					f14_arg0:setAlpha(0.5)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.BgScanningDetail:beginAnimation(610, Enum[@"luitween"][@"luitween_ease_in"])
				f12_arg0.BgScanningDetail:setAlpha(1)
				f12_arg0.BgScanningDetail:setScale(1, 1)
				f12_arg0.BgScanningDetail:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BgScanningDetail:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.BgScanningDetail:completeAnimation()
			f12_arg0.BgScanningDetail:setAlpha(0)
			f12_arg0.BgScanningDetail:setScale(0.93, 0.93)
			f12_local0(f12_arg0.BgScanningDetail)
			local f12_local1 = function(f20_arg0)
				f20_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
				f20_arg0:setAlpha(1)
				f20_arg0:setScale(1, 1)
				f20_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.IconScanning:beginAnimation(420)
			f12_arg0.IconScanning:setAlpha(0)
			f12_arg0.IconScanning:setScale(0.9, 0.9)
			f12_arg0.IconScanning:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
			f12_arg0.IconScanning:registerEventHandler("transition_complete_keyframe", f12_local1)
			local f12_local2 = function(f21_arg0)
				f12_arg0.StatusText:beginAnimation(870)
				f12_arg0.StatusText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.StatusText:completeAnimation()
			f12_arg0.StatusText:setAlpha(1)
			f12_arg0.StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_15B0BB8A5179067B"))
			f12_local2(f12_arg0.StatusText)
			f12_arg0.PercentText:beginAnimation(870)
			f12_arg0.PercentText:setAlpha(1)
			f12_arg0.PercentText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
			f12_arg0.PercentText:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
		end,
	},
	TeamHacking = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(7)
			f22_arg0.BgScanning:completeAnimation()
			f22_arg0.BgScanning:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BgScanning)
			f22_arg0.BgScanningDetail:completeAnimation()
			f22_arg0.BgScanningDetail:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BgScanningDetail)
			local f22_local0 = function(f23_arg0)
				f22_arg0.BgHacking:beginAnimation(730)
				f22_arg0.BgHacking:setAlpha(1)
				f22_arg0.BgHacking:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BgHacking:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.BgHacking:completeAnimation()
			f22_arg0.BgHacking:setAlpha(0)
			f22_local0(f22_arg0.BgHacking)
			local f22_local1 = function(f24_arg0)
				f22_arg0.BgHackingDetail:beginAnimation(730, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f22_arg0.BgHackingDetail:setAlpha(1)
				f22_arg0.BgHackingDetail:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BgHackingDetail:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.BgHackingDetail:completeAnimation()
			f22_arg0.BgHackingDetail:setAlpha(0)
			f22_local1(f22_arg0.BgHackingDetail)
			local f22_local2 = function(f25_arg0)
				f25_arg0:beginAnimation(310, Enum[@"luitween"][@"luitween_ease_in"])
				f25_arg0:setAlpha(1)
				f25_arg0:setScale(1, 1)
				f25_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.IconHacking:beginAnimation(420)
			f22_arg0.IconHacking:setAlpha(0)
			f22_arg0.IconHacking:setScale(0.9, 0.9)
			f22_arg0.IconHacking:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
			f22_arg0.IconHacking:registerEventHandler("transition_complete_keyframe", f22_local2)
			local f22_local3 = function(f26_arg0)
				f22_arg0.StatusText:beginAnimation(870)
				f22_arg0.StatusText:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.StatusText:completeAnimation()
			f22_arg0.StatusText:setAlpha(1)
			f22_arg0.StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_28A0321A7A231A5"))
			f22_local3(f22_arg0.StatusText)
			f22_arg0.PercentText:beginAnimation(870)
			f22_arg0.PercentText:setAlpha(1)
			f22_arg0.PercentText:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
			f22_arg0.PercentText:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
		end,
	},
	Hacking = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(7)
			f27_arg0.BgScanning:completeAnimation()
			f27_arg0.BgScanning:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BgScanning)
			f27_arg0.BgScanningDetail:completeAnimation()
			f27_arg0.BgScanningDetail:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BgScanningDetail)
			local f27_local0 = function(f28_arg0)
				f27_arg0.BgHacking:beginAnimation(730)
				f27_arg0.BgHacking:setAlpha(1)
				f27_arg0.BgHacking:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BgHacking:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.BgHacking:completeAnimation()
			f27_arg0.BgHacking:setAlpha(0)
			f27_local0(f27_arg0.BgHacking)
			local f27_local1 = function(f29_arg0)
				f27_arg0.BgHackingDetail:beginAnimation(730, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f27_arg0.BgHackingDetail:setAlpha(1)
				f27_arg0.BgHackingDetail:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BgHackingDetail:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.BgHackingDetail:completeAnimation()
			f27_arg0.BgHackingDetail:setAlpha(0)
			f27_local1(f27_arg0.BgHackingDetail)
			local f27_local2 = function(f30_arg0)
				f30_arg0:beginAnimation(310, Enum[@"luitween"][@"luitween_ease_in"])
				f30_arg0:setAlpha(1)
				f30_arg0:setScale(1, 1)
				f30_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.IconHacking:beginAnimation(420)
			f27_arg0.IconHacking:setAlpha(0)
			f27_arg0.IconHacking:setScale(0.9, 0.9)
			f27_arg0.IconHacking:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
			f27_arg0.IconHacking:registerEventHandler("transition_complete_keyframe", f27_local2)
			local f27_local3 = function(f31_arg0)
				f27_arg0.StatusText:beginAnimation(870)
				f27_arg0.StatusText:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.StatusText:completeAnimation()
			f27_arg0.StatusText:setAlpha(1)
			f27_arg0.StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_DEDBD93286F117"))
			f27_local3(f27_arg0.StatusText)
			f27_arg0.PercentText:beginAnimation(870)
			f27_arg0.PercentText:setAlpha(1)
			f27_arg0.PercentText:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
			f27_arg0.PercentText:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
		end,
	},
	Breaching = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(6)
			local f32_local0 = function(f33_arg0)
				f32_arg0.BgBreaching:beginAnimation(730)
				f32_arg0.BgBreaching:setAlpha(1)
				f32_arg0.BgBreaching:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BgBreaching:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BgBreaching:completeAnimation()
			f32_arg0.BgBreaching:setAlpha(0)
			f32_local0(f32_arg0.BgBreaching)
			local f32_local1 = function(f34_arg0)
				f32_arg0.BgBreachingDetail:beginAnimation(730, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f32_arg0.BgBreachingDetail:setAlpha(1)
				f32_arg0.BgBreachingDetail:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BgBreachingDetail:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BgBreachingDetail:completeAnimation()
			f32_arg0.BgBreachingDetail:setAlpha(0)
			f32_local1(f32_arg0.BgBreachingDetail)
			local f32_local2 = function(f35_arg0)
				f32_arg0.IconScanning:beginAnimation(870)
				f32_arg0.IconScanning:setAlpha(0)
				f32_arg0.IconScanning:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.IconScanning:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.IconScanning:completeAnimation()
			f32_arg0.IconScanning:setAlpha(1)
			f32_local2(f32_arg0.IconScanning)
			local f32_local3 = function(f36_arg0)
				f36_arg0:beginAnimation(220, Enum[@"luitween"][@"luitween_ease_in"])
				f36_arg0:setAlpha(1)
				f36_arg0:setScale(1, 1)
				f36_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.IconBreaching:beginAnimation(510)
			f32_arg0.IconBreaching:setAlpha(0)
			f32_arg0.IconBreaching:setScale(0.9, 0.9)
			f32_arg0.IconBreaching:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.IconBreaching:registerEventHandler("transition_complete_keyframe", f32_local3)
			local f32_local4 = function(f37_arg0)
				f32_arg0.StatusText:beginAnimation(870)
				f32_arg0.StatusText:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.StatusText:completeAnimation()
			f32_arg0.StatusText:setAlpha(1)
			f32_arg0.StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x292DF57CA31383))
			f32_local4(f32_arg0.StatusText)
			f32_arg0.PercentText:beginAnimation(870)
			f32_arg0.PercentText:setAlpha(1)
			f32_arg0.PercentText:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.PercentText:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
		end,
	},
	Error = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(7)
			local f38_local0 = function(f39_arg0)
				f38_arg0.BgError:beginAnimation(700, Enum[@"luitween"][@"luitween_ease_in"])
				f38_arg0.BgError:setAlpha(1)
				f38_arg0.BgError:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.BgError:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.BgError:completeAnimation()
			f38_arg0.BgError:setAlpha(0)
			f38_local0(f38_arg0.BgError)
			local f38_local1 = function(f40_arg0)
				f38_arg0.BgErrorDetail:beginAnimation(700, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f38_arg0.BgErrorDetail:setAlpha(1)
				f38_arg0.BgErrorDetail:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.BgErrorDetail:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.BgErrorDetail:completeAnimation()
			f38_arg0.BgErrorDetail:setAlpha(0)
			f38_local1(f38_arg0.BgErrorDetail)
			local f38_local2 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						local f43_local0 = function(f44_arg0)
							local f44_local0 = function(f45_arg0)
								local f45_local0 = function(f46_arg0)
									local f46_local0 = function(f47_arg0)
										local f47_local0 = function(f48_arg0)
											local f48_local0 = function(f49_arg0)
												f49_arg0:beginAnimation(19)
												f49_arg0:setAlpha(1)
												f49_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
											end
											f48_arg0:beginAnimation(19)
											f48_arg0:setAlpha(0.5)
											f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
										end
										f47_arg0:beginAnimation(19)
										f47_arg0:setAlpha(1)
										f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
									end
									f46_arg0:beginAnimation(20)
									f46_arg0:setAlpha(0.5)
									f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
								end
								f45_arg0:beginAnimation(19)
								f45_arg0:setAlpha(1)
								f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
							end
							f44_arg0:beginAnimation(19)
							f44_arg0:setAlpha(0.5)
							f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
						end
						f43_arg0:beginAnimation(20)
						f43_arg0:setAlpha(1)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
					end
					f42_arg0:beginAnimation(19)
					f42_arg0:setAlpha(0.5)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f41_arg0:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_in"])
				f41_arg0:setAlpha(1)
				f41_arg0:setScale(1, 1)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f38_arg0.BgErrorXmarks:beginAnimation(620)
			f38_arg0.BgErrorXmarks:setAlpha(0)
			f38_arg0.BgErrorXmarks:setScale(0.9, 0.9)
			f38_arg0.BgErrorXmarks:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.BgErrorXmarks:registerEventHandler("transition_complete_keyframe", f38_local2)
			local f38_local3 = function(f50_arg0)
				f50_arg0:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_in"])
				f50_arg0:setAlpha(1)
				f50_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.BgErrorStripes:beginAnimation(620)
			f38_arg0.BgErrorStripes:setAlpha(0)
			f38_arg0.BgErrorStripes:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.BgErrorStripes:registerEventHandler("transition_complete_keyframe", f38_local3)
			local f38_local4 = function(f51_arg0)
				f51_arg0:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_in"])
				f51_arg0:setAlpha(1)
				f51_arg0:setScale(1, 1)
				f51_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.BgErrorIcon:beginAnimation(870)
			f38_arg0.BgErrorIcon:setAlpha(0)
			f38_arg0.BgErrorIcon:setScale(0.9, 0.9)
			f38_arg0.BgErrorIcon:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.BgErrorIcon:registerEventHandler("transition_complete_keyframe", f38_local4)
			local f38_local5 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					local f53_local0 = function(f54_arg0)
						local f54_local0 = function(f55_arg0)
							local f55_local0 = function(f56_arg0)
								f56_arg0:beginAnimation(669, Enum[@"luitween"][@"luitween_ease_in"])
								f56_arg0:setAlpha(1)
								f56_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
							end
							f55_arg0:beginAnimation(670, Enum[@"luitween"][@"luitween_ease_out"])
							f55_arg0:setAlpha(0)
							f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
						end
						f54_arg0:beginAnimation(680, Enum[@"luitween"][@"luitween_ease_in"])
						f54_arg0:setAlpha(1)
						f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
					end
					f53_arg0:beginAnimation(669, Enum[@"luitween"][@"luitween_ease_out"])
					f53_arg0:setAlpha(0.3)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
				end
				f52_arg0:beginAnimation(710, Enum[@"luitween"][@"luitween_ease_in"])
				f52_arg0:setAlpha(1)
				f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f38_arg0.BfErrorIconGlow:beginAnimation(400)
			f38_arg0.BfErrorIconGlow:setAlpha(0)
			f38_arg0.BfErrorIconGlow:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
			f38_arg0.BfErrorIconGlow:registerEventHandler("transition_complete_keyframe", f38_local5)
			f38_arg0.PercentText:completeAnimation()
			f38_arg0.PercentText:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.PercentText)
		end,
	},
	EMP = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(8)
			f57_arg0.BgScanning:completeAnimation()
			f57_arg0.BgScanning:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.BgScanning)
			f57_arg0.BgScanningDetail:completeAnimation()
			f57_arg0.BgScanningDetail:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.BgScanningDetail)
			f57_arg0.StatusText:completeAnimation()
			f57_arg0.StatusText:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.StatusText)
			f57_arg0.PercentText:completeAnimation()
			f57_arg0.PercentText:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.PercentText)
			f57_arg0.HackingBarRight:completeAnimation()
			f57_arg0.HackingBarRight:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.HackingBarRight)
			f57_arg0.HackingBarLeft:completeAnimation()
			f57_arg0.HackingBarLeft:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.HackingBarLeft)
			f57_arg0.WaveformBlackHat:completeAnimation()
			f57_arg0.WaveformBlackHat:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.WaveformBlackHat)
			f57_arg0.blackhatEmp0:completeAnimation()
			f57_arg0.blackhatEmp0:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.blackhatEmp0)
		end,
	},
}
CoD.BlackHat_Internal.__onClose = function(f58_arg0)
	f58_arg0.PercentText:close()
	f58_arg0.HackingBarRight:close()
	f58_arg0.HackingBarLeft:close()
	f58_arg0.WaveformBlackHat:close()
	f58_arg0.blackhatEmp0:close()
end
