require("x64:80ed92ccb6ae549")
require("x64:2bf789c3c32d132")
require("x64:9c229ee624f5b47")
require("x64:98097eccfe72615")
require("x64:8214f26f4d90650")
require("x64:88b4d51833c79f5")
require("x64:ce1e6b6549d478c")
require("x64:4fef7f34e3f5ca0")
require("x64:567f2a963ddad0f")
CoD.AARLevelUpOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.AARLevelUpOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AARLevelUpOverlay", f1_arg0)
	local f1_local1 = self
	CoD.AARUtility.SetupLevelUpModels(f1_local1, f1_arg0)
	self:setClass(CoD.AARLevelUpOverlay)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 0, 1080)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local FractalGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FractalGrid:setAlpha(0)
	FractalGrid:setImage(RegisterImage(0x1DF4C930E69FFB0))
	FractalGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	FractalGrid:setShaderVector(0, 1, 1, 0, 0)
	FractalGrid:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(FractalGrid)
	self.FractalGrid = FractalGrid
	local ZMSmokeBackgroundR = CoD.zm_hud_gameover_smokebackground.new(f1_local1, f1_arg0, 0.5, 0.5, 929, 1399, 0.5, 0.5, -758, -288)
	ZMSmokeBackgroundR:setAlpha(0)
	ZMSmokeBackgroundR:setScale(4, 3)
	self:addElement(ZMSmokeBackgroundR)
	self.ZMSmokeBackgroundR = ZMSmokeBackgroundR
	local ZMSmokeBackgroundL = CoD.zm_hud_gameover_smokebackground.new(f1_local1, f1_arg0, 0.5, 0.5, -1498, -1028, 0.5, 0.5, -669.5, -199.5)
	ZMSmokeBackgroundL:setAlpha(0)
	ZMSmokeBackgroundL:setZRot(190)
	ZMSmokeBackgroundL:setScale(3.5, 3)
	self:addElement(ZMSmokeBackgroundL)
	self.ZMSmokeBackgroundL = ZMSmokeBackgroundL
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local BgElements = CoD.AARLevelUpOverlay_LevelUpBg.new(f1_local1, f1_arg0, 0, 0, 125, 1795, 0, 0, 144, 930)
	self:addElement(BgElements)
	self.BgElements = BgElements
	local XpMeter = CoD.AARXpMeter.new(f1_local1, f1_arg0, 0.5, 0.5, -877, 423, 0.5, 0.5, 374, 394)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", nil, function(model)
		XpMeter:setModel(model, f1_arg0)
	end)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", "earnedXpProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			XpMeter.EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", "earnedXpProgress", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			XpMeter.EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", "earnedXpProgress", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			XpMeter.EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", "previousXpProgress", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			XpMeter.PreviousXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", "previousXpProgress", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			XpMeter.PreviousXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	XpMeter:subscribeToGlobalModel(f1_arg0, "AARLevelUp", "previousXpProgress", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			XpMeter.PreviousXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))
		end
	end)
	XpMeter:linkToElementModel(self, "xpEarnedDuringMatch", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			XpMeter.xpEarnedText:setText(LocalizeIntoString(0x5C4E2BA06EA49A5, f10_local0))
		end
	end)
	XpMeter:linkToElementModel(self, "xpNeededToLevelUp", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			XpMeter.xpNeededText:setText(LocalizeIntoString(0x2B924F206C5B4D8, f11_local0))
		end
	end)
	self:addElement(XpMeter)
	self.XpMeter = XpMeter
	local DoubleXPIcon = CoD.DoubleXPIcon.new(f1_local1, f1_arg0, 0.5, 0.5, 605, 677, 0.5, 0.5, 348, 420)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	local MainCornerL = LUI.UIImage.new(0.5, 0.5, -784, -754, 0, 0, 146, 176)
	MainCornerL:setAlpha(0.04)
	MainCornerL:setYRot(180)
	MainCornerL:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(MainCornerL)
	self.MainCornerL = MainCornerL
	local MainCornerR = LUI.UIImage.new(0.5, 0.5, 756, 786, 0, 0, 145, 175)
	MainCornerR:setAlpha(0.04)
	MainCornerR:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(MainCornerR)
	self.MainCornerR = MainCornerR
	local Reward = CoD.AARLevelUpReward.new(f1_local1, f1_arg0, 0.5, 0.5, -400, 400, 0.5, 0.5, 55.5, 335.5)
	Reward:subscribeToGlobalModel(f1_arg0, "AARLevelUp", nil, function(model)
		Reward:setModel(model, f1_arg0)
	end)
	self:addElement(Reward)
	self.Reward = Reward
	local ArrowL = CoD.AARLevelUpOverlay_ArrowsInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -396, -372, 0, 0, 824.5, 877.5)
	self:addElement(ArrowL)
	self.ArrowL = ArrowL
	local ArrowR = CoD.AARLevelUpOverlay_ArrowsInternal.new(f1_local1, f1_arg0, 0.5, 0.5, 372, 396, 0, 0, 824.5, 877.5)
	self:addElement(ArrowR)
	self.ArrowR = ArrowR
	local Rank = CoD.AARLevelUpRank.new(f1_local1, f1_arg0, 0.5, 0.5, -200, 200, 0.5, 0.5, -420, -20)
	Rank:subscribeToGlobalModel(f1_arg0, "AARLevelUp", nil, function(model)
		Rank:setModel(model, f1_arg0)
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local LevelUpText = CoD.AARLevelUpOverlay_LevelUpTextInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -199.5, 200.5, 0, 0, 48.5, 108.5)
	LevelUpText:mergeStateConditions({
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
		{
			stateName = "CurrentRank",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsCurrentRankStartingRank(self.LevelUpText, f1_arg0)
			end,
		},
	})
	local Rewardsound = LevelUpText
	local Ranksound = LevelUpText.subscribeToModel
	local f1_local20 = Engine[0x8DF2E5447F384B9]()
	Ranksound(Rewardsound, f1_local20["lobbyRoot.lobbyNav"], function(f16_arg0)
		f1_local1:updateElementState(LevelUpText, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LevelUpText:linkToElementModel(LevelUpText, "rank", true, function(model)
		f1_local1:updateElementState(LevelUpText, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "rank",
		})
	end)
	LevelUpText:subscribeToGlobalModel(f1_arg0, "AARLevelUp", nil, function(model)
		LevelUpText:setModel(model, f1_arg0)
	end)
	self:addElement(LevelUpText)
	self.LevelUpText = LevelUpText
	Ranksound = LUI.UIElement.new(0, 0, 1013, 1045, 0, 0, 290, 322)
	Ranksound:setPlaySoundDirect(true)
	self:addElement(Ranksound)
	self.Ranksound = Ranksound
	Rewardsound = LUI.UIElement.new(0, 0, 1073, 1105, 0, 0, 650, 682)
	Rewardsound:setPlaySoundDirect(true)
	self:addElement(Rewardsound)
	self.Rewardsound = Rewardsound
	self:mergeStateConditions({
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local21 = self
	f1_local20 = self.subscribeToModel
	local f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local21, f1_local22["lobbyRoot.lobbyNav"], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f21_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local21 = self
	f1_local20 = self.subscribeToModel
	f1_local22 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local20(f1_local21, f1_local22.LastInput, function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsPC() then
			CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsPC() and IsGamepad(controller) then
			CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
			return true
		elseif IsPC() and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.CloseLevelUpOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
		return false
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local20 = self
	CoD.AARUtility.AnimateRankXpBar(f1_local1, f1_arg0)
	return self
end
CoD.AARLevelUpOverlay.__resetProperties = function(f31_arg0)
	f31_arg0.LevelUpText:completeAnimation()
	f31_arg0.BgElements:completeAnimation()
	f31_arg0.Rank:completeAnimation()
	f31_arg0.Reward:completeAnimation()
	f31_arg0.DoubleXPIcon:completeAnimation()
	f31_arg0.XpMeter:completeAnimation()
	f31_arg0.ArrowR:completeAnimation()
	f31_arg0.ArrowL:completeAnimation()
	f31_arg0.MainCornerR:completeAnimation()
	f31_arg0.MainCornerL:completeAnimation()
	f31_arg0.FractalGrid:completeAnimation()
	f31_arg0.Backing:completeAnimation()
	f31_arg0.Ranksound:completeAnimation()
	f31_arg0.Rewardsound:completeAnimation()
	f31_arg0.ZMSmokeBackgroundR:completeAnimation()
	f31_arg0.ZMSmokeBackgroundL:completeAnimation()
	f31_arg0.LevelUpText:setAlpha(1)
	f31_arg0.BgElements:setAlpha(1)
	f31_arg0.Rank:setAlpha(1)
	f31_arg0.Reward:setAlpha(1)
	f31_arg0.DoubleXPIcon:setAlpha(1)
	f31_arg0.XpMeter:setAlpha(1)
	f31_arg0.ArrowR:setAlpha(1)
	f31_arg0.ArrowL:setAlpha(1)
	f31_arg0.MainCornerR:setAlpha(0.04)
	f31_arg0.MainCornerL:setAlpha(0.04)
	f31_arg0.FractalGrid:setAlpha(0)
	f31_arg0.Backing:setAlpha(0.9)
	f31_arg0.ZMSmokeBackgroundR:setAlpha(0)
	f31_arg0.ZMSmokeBackgroundL:setAlpha(0)
end
CoD.AARLevelUpOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(14)
			local f32_local0 = function(f33_arg0)
				f32_arg0.Backing:beginAnimation(100)
				f32_arg0.Backing:setAlpha(0.9)
				f32_arg0.Backing:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Backing:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.Backing:completeAnimation()
			f32_arg0.Backing:setAlpha(0.5)
			f32_local0(f32_arg0.Backing)
			f32_arg0.FractalGrid:completeAnimation()
			f32_arg0.FractalGrid:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.FractalGrid)
			local f32_local1 = function(f34_arg0)
				f32_arg0.BgElements:beginAnimation(100)
				f32_arg0.BgElements:setAlpha(1)
				f32_arg0.BgElements:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BgElements:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BgElements:completeAnimation()
			f32_arg0.BgElements:setAlpha(0)
			f32_local1(f32_arg0.BgElements)
			local f32_local2 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.XpMeter:beginAnimation(300)
				f32_arg0.XpMeter:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.XpMeter:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f32_arg0.XpMeter:completeAnimation()
			f32_arg0.XpMeter:setAlpha(0)
			f32_local2(f32_arg0.XpMeter)
			local f32_local3 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f38_arg0:setAlpha(1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.DoubleXPIcon:beginAnimation(300)
				f32_arg0.DoubleXPIcon:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DoubleXPIcon:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f32_arg0.DoubleXPIcon:completeAnimation()
			f32_arg0.DoubleXPIcon:setAlpha(0)
			f32_local3(f32_arg0.DoubleXPIcon)
			local f32_local4 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(100)
					f40_arg0:setAlpha(0.04)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.MainCornerL:beginAnimation(100)
				f32_arg0.MainCornerL:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.MainCornerL:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f32_arg0.MainCornerL:completeAnimation()
			f32_arg0.MainCornerL:setAlpha(0)
			f32_local4(f32_arg0.MainCornerL)
			local f32_local5 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(100)
					f42_arg0:setAlpha(0.04)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.MainCornerR:beginAnimation(100)
				f32_arg0.MainCornerR:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.MainCornerR:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f32_arg0.MainCornerR:completeAnimation()
			f32_arg0.MainCornerR:setAlpha(0)
			f32_local5(f32_arg0.MainCornerR)
			local f32_local6 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(100)
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.Reward:beginAnimation(200)
				f32_arg0.Reward:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Reward:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f32_arg0.Reward:completeAnimation()
			f32_arg0.Reward:setAlpha(0)
			f32_local6(f32_arg0.Reward)
			local f32_local7 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f46_arg0:setAlpha(1)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.ArrowL:beginAnimation(250)
				f32_arg0.ArrowL:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ArrowL:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f32_arg0.ArrowL:completeAnimation()
			f32_arg0.ArrowL:setAlpha(0)
			f32_local7(f32_arg0.ArrowL)
			local f32_local8 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f48_arg0:setAlpha(1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.ArrowR:beginAnimation(250)
				f32_arg0.ArrowR:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ArrowR:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f32_arg0.ArrowR:completeAnimation()
			f32_arg0.ArrowR:setAlpha(0)
			f32_local8(f32_arg0.ArrowR)
			local f32_local9 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(100)
					f50_arg0:setAlpha(1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.Rank:beginAnimation(50)
				f32_arg0.Rank:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Rank:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f32_arg0.Rank:completeAnimation()
			f32_arg0.Rank:setAlpha(0)
			f32_local9(f32_arg0.Rank)
			local f32_local10 = function(f51_arg0)
				f32_arg0.LevelUpText:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f32_arg0.LevelUpText:setAlpha(1)
				f32_arg0.LevelUpText:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.LevelUpText:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.LevelUpText:completeAnimation()
			f32_arg0.LevelUpText:setAlpha(0)
			f32_local10(f32_arg0.LevelUpText)
			f32_arg0.Ranksound:beginAnimation(100)
			f32_arg0.Ranksound:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.Ranksound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_wz_aar_box", f32_arg1)
				f32_arg0.clipFinished(element, event)
			end)
			f32_arg0.Rewardsound:beginAnimation(1000)
			f32_arg0.Rewardsound:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.Rewardsound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_wz_aar_challenge_complete", f32_arg1)
				f32_arg0.clipFinished(element, event)
			end)
		end,
	},
	ZM = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(14)
			local f54_local0 = function(f55_arg0)
				f54_arg0.Backing:beginAnimation(100)
				f54_arg0.Backing:setAlpha(0.9)
				f54_arg0.Backing:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.Backing:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.Backing:completeAnimation()
			f54_arg0.Backing:setAlpha(0.5)
			f54_local0(f54_arg0.Backing)
			f54_arg0.FractalGrid:completeAnimation()
			f54_arg0.FractalGrid:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.FractalGrid)
			local f54_local1 = function(f56_arg0)
				f54_arg0.ZMSmokeBackgroundR:beginAnimation(100)
				f54_arg0.ZMSmokeBackgroundR:setAlpha(0.03)
				f54_arg0.ZMSmokeBackgroundR:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.ZMSmokeBackgroundR:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.ZMSmokeBackgroundR:completeAnimation()
			f54_arg0.ZMSmokeBackgroundR:setAlpha(0)
			f54_local1(f54_arg0.ZMSmokeBackgroundR)
			local f54_local2 = function(f57_arg0)
				f54_arg0.ZMSmokeBackgroundL:beginAnimation(100)
				f54_arg0.ZMSmokeBackgroundL:setAlpha(0.02)
				f54_arg0.ZMSmokeBackgroundL:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.ZMSmokeBackgroundL:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.ZMSmokeBackgroundL:completeAnimation()
			f54_arg0.ZMSmokeBackgroundL:setAlpha(0)
			f54_local2(f54_arg0.ZMSmokeBackgroundL)
			f54_arg0.BgElements:completeAnimation()
			f54_arg0.BgElements:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.BgElements)
			local f54_local3 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f59_arg0:setAlpha(1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.XpMeter:beginAnimation(300)
				f54_arg0.XpMeter:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.XpMeter:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f54_arg0.XpMeter:completeAnimation()
			f54_arg0.XpMeter:setAlpha(0)
			f54_local3(f54_arg0.XpMeter)
			local f54_local4 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f61_arg0:setAlpha(1)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.DoubleXPIcon:beginAnimation(300)
				f54_arg0.DoubleXPIcon:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.DoubleXPIcon:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f54_arg0.DoubleXPIcon:completeAnimation()
			f54_arg0.DoubleXPIcon:setAlpha(0)
			f54_local4(f54_arg0.DoubleXPIcon)
			f54_arg0.MainCornerL:completeAnimation()
			f54_arg0.MainCornerL:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.MainCornerL)
			f54_arg0.MainCornerR:completeAnimation()
			f54_arg0.MainCornerR:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.MainCornerR)
			local f54_local5 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					f63_arg0:beginAnimation(100)
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.Reward:beginAnimation(200)
				f54_arg0.Reward:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.Reward:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f54_arg0.Reward:completeAnimation()
			f54_arg0.Reward:setAlpha(0)
			f54_local5(f54_arg0.Reward)
			f54_arg0.ArrowL:completeAnimation()
			f54_arg0.ArrowL:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.ArrowL)
			f54_arg0.ArrowR:completeAnimation()
			f54_arg0.ArrowR:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.ArrowR)
			local f54_local6 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					f65_arg0:beginAnimation(100)
					f65_arg0:setAlpha(1)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.Rank:beginAnimation(50)
				f54_arg0.Rank:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.Rank:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f54_arg0.Rank:completeAnimation()
			f54_arg0.Rank:setAlpha(0)
			f54_local6(f54_arg0.Rank)
			local f54_local7 = function(f66_arg0)
				f54_arg0.LevelUpText:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f54_arg0.LevelUpText:setAlpha(1)
				f54_arg0.LevelUpText:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.LevelUpText:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.LevelUpText:completeAnimation()
			f54_arg0.LevelUpText:setAlpha(0)
			f54_local7(f54_arg0.LevelUpText)
		end,
	},
}
CoD.AARLevelUpOverlay.__onClose = function(f67_arg0)
	f67_arg0.ZMSmokeBackgroundR:close()
	f67_arg0.ZMSmokeBackgroundL:close()
	f67_arg0.FooterContainerFrontendRight:close()
	f67_arg0.BgElements:close()
	f67_arg0.XpMeter:close()
	f67_arg0.DoubleXPIcon:close()
	f67_arg0.Reward:close()
	f67_arg0.ArrowL:close()
	f67_arg0.ArrowR:close()
	f67_arg0.Rank:close()
	f67_arg0.LevelUpText:close()
end
