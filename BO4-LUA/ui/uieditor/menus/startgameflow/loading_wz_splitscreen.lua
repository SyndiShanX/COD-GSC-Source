require("x64:f8db2063f73b388")
require("x64:2d858628f53d460")
require("x64:bd860e6848b37d7")
require("x64:6ee653ade3452f5")
require("x64:c0887595cfb6bb1")
CoD.Loading_WZ_Splitscreen = InheritFrom(CoD.Menu)
LUI.createMenu.Loading_WZ_Splitscreen = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Loading_WZ_Splitscreen", f1_arg0)
	local f1_local1 = self
	CoD.WZUtility.InitWZLoadingFractionUpdate(self, f1_arg0)
	self:setClass(CoD.Loading_WZ_Splitscreen)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	self:addElement(background)
	self.background = background
	local BlackFadeOut = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackFadeOut:setRGB(0, 0, 0)
	self:addElement(BlackFadeOut)
	self.BlackFadeOut = BlackFadeOut
	local LoadingElem2 = CoD.LoadingScreenLoadbar.new(f1_local1, f1_arg0, 0.5, 0.5, -865, 870, 1, 1, -70, -50)
	LoadingElem2:subscribeToGlobalModel(f1_arg0, "LoadingScreenTeamInfo", "wzLoadedFraction", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LoadingElem2.LoadingBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(LoadingElem2)
	self.LoadingElem2 = LoadingElem2
	local DoubleXPIconsLeftAligned = CoD.DoubleXPIconsLeftAligned.new(f1_local1, f1_arg0, 0.5, 0.5, -865, -649, 1, 1, -152, -80)
	self:addElement(DoubleXPIconsLeftAligned)
	self.DoubleXPIconsLeftAligned = DoubleXPIconsLeftAligned
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local PCNotifContainer = nil
	PCNotifContainer = CoD.PC_Notif_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 470, 920, 0, 0, 106, 206)
	self:addElement(PCNotifContainer)
	self.PCNotifContainer = PCNotifContainer
	local TrialInfo = CoD.Loading_WZ_TrialBanner.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -50, 250)
	self:addElement(TrialInfo)
	self.TrialInfo = TrialInfo
	if CoD.isPC then
		PCNotifContainer.id = "PCNotifContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Loading_WZ_Splitscreen.__resetProperties = function(f3_arg0)
	f3_arg0.LoadingElem2:completeAnimation()
	f3_arg0.BlackFadeOut:completeAnimation()
	f3_arg0.background:completeAnimation()
	f3_arg0.DoubleXPIconsLeftAligned:completeAnimation()
	f3_arg0.TrialInfo:completeAnimation()
	f3_arg0.LoadingElem2:setAlpha(1)
	f3_arg0.BlackFadeOut:setAlpha(1)
	f3_arg0.background:setAlpha(1)
	f3_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
	f3_arg0.TrialInfo:setAlpha(1)
end
CoD.Loading_WZ_Splitscreen.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Close = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(250)
					f7_arg0:setAlpha(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.background:beginAnimation(250)
				f5_arg0.background:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.background:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.background:completeAnimation()
			f5_arg0.background:setAlpha(1)
			f5_local0(f5_arg0.background)
			local f5_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(250)
					f9_arg0:setAlpha(0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.BlackFadeOut:beginAnimation(250)
				f5_arg0.BlackFadeOut:setAlpha(1)
				f5_arg0.BlackFadeOut:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.BlackFadeOut:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f5_arg0.BlackFadeOut:completeAnimation()
			f5_arg0.BlackFadeOut:setAlpha(0)
			f5_local1(f5_arg0.BlackFadeOut)
			local f5_local2 = function(f10_arg0)
				f5_arg0.LoadingElem2:beginAnimation(250)
				f5_arg0.LoadingElem2:setAlpha(0)
				f5_arg0.LoadingElem2:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.LoadingElem2:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.LoadingElem2:completeAnimation()
			f5_arg0.LoadingElem2:setAlpha(1)
			f5_local2(f5_arg0.LoadingElem2)
			local f5_local3 = function(f11_arg0)
				f5_arg0.DoubleXPIconsLeftAligned:beginAnimation(250)
				f5_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
				f5_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.DoubleXPIconsLeftAligned:completeAnimation()
			f5_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
			f5_local3(f5_arg0.DoubleXPIconsLeftAligned)
			local f5_local4 = function(f12_arg0)
				f5_arg0.TrialInfo:beginAnimation(250)
				f5_arg0.TrialInfo:setAlpha(0)
				f5_arg0.TrialInfo:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.TrialInfo:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.TrialInfo:completeAnimation()
			f5_arg0.TrialInfo:setAlpha(1)
			f5_local4(f5_arg0.TrialInfo)
		end,
	},
}
CoD.Loading_WZ_Splitscreen.__onClose = function(f13_arg0)
	f13_arg0.LoadingElem2:close()
	f13_arg0.DoubleXPIconsLeftAligned:close()
	f13_arg0.ScorestreakAspectRatioFix:close()
	f13_arg0.PCNotifContainer:close()
	f13_arg0.TrialInfo:close()
end
