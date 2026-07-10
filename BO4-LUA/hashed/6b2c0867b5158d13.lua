require("x64:9b237d501cc3529")
require("x64:14a642527764da5")
require("x64:8561c81010cda6d")
CoD.KillcamMenu = InheritFrom(CoD.Menu)
LUI.createMenu.KillcamMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("KillcamMenu", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "hudItems.killcamAllowRespawn", 0)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.KillcamMenu)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local KillcamWidget = CoD.KillcamWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	KillcamWidget:setAlpha(0)
	self:addElement(KillcamWidget)
	self.KillcamWidget = KillcamWidget
	local PlayOfTheMatchWidget = CoD.PlayOfTheMatchWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	PlayOfTheMatchWidget:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f2_local0 = PlayOfTheMatchWidget
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x337E1F7E8F768D2) and not IsPC() then
			SetElementState(self, f2_local0, f1_arg0, "PlayOfTheMatch")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xBB70498F448D405) then
			SetElementState(self, f2_local0, f1_arg0, "DefaultState")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x337E1F7E8F768D2) and IsPC() then
			SetElementState(self, f2_local0, f1_arg0, "PlayOfTheMatchPC")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xBCAD2526C42E308) then
			SetElementState(self, f2_local0, f1_arg0, "DefaultState")
		end
	end)
	self:addElement(PlayOfTheMatchWidget)
	self.PlayOfTheMatchWidget = PlayOfTheMatchWidget
	local FinalKillcamWidget = CoD.FinalKillcamWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FinalKillcamWidget:setAlpha(0)
	FinalKillcamWidget:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f3_local0 = FinalKillcamWidget
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x337E1F7E8F768D2) then
			SetElementState(self, f3_local0, f1_arg0, "DefaultState")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xBB70498F448D405) then
			SetElementState(self, f3_local0, f1_arg0, "FinalKillcam")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xBCAD2526C42E308) then
			SetElementState(self, f3_local0, f1_arg0, "DefaultState")
		end
	end)
	self:addElement(FinalKillcamWidget)
	self.FinalKillcamWidget = FinalKillcamWidget
	local Foreground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Foreground:setRGB(0, 0, 0)
	self:addElement(Foreground)
	self.Foreground = Foreground
	self:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f4_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x937494C549C06BB) then
			PlayClip(self, "EndTransition", f1_arg0)
		end
	end)
	KillcamWidget.id = "KillcamWidget"
	FinalKillcamWidget.id = "FinalKillcamWidget"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	SetProperty(self, "ignoreCursor", true)
	return self
end
CoD.KillcamMenu.__resetProperties = function(f5_arg0)
	f5_arg0.KillcamWidget:completeAnimation()
	f5_arg0.Foreground:completeAnimation()
	f5_arg0.FinalKillcamWidget:completeAnimation()
	f5_arg0.PlayOfTheMatchWidget:completeAnimation()
	f5_arg0.KillcamWidget:setAlpha(0)
	f5_arg0.Foreground:setAlpha(1)
	f5_arg0.FinalKillcamWidget:setAlpha(0)
	f5_arg0.PlayOfTheMatchWidget:setAlpha(1)
end
CoD.KillcamMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.KillcamWidget:completeAnimation()
			f6_arg0.KillcamWidget:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.KillcamWidget)
			f6_arg0.FinalKillcamWidget:completeAnimation()
			f6_arg0.FinalKillcamWidget:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FinalKillcamWidget)
			f6_arg0.Foreground:completeAnimation()
			f6_arg0.Foreground:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Foreground)
		end,
		EndTransition = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			local f7_local0 = function(f8_arg0)
				f7_arg0.KillcamWidget:beginAnimation(900)
				f7_arg0.KillcamWidget:setAlpha(0)
				f7_arg0.KillcamWidget:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.KillcamWidget:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.KillcamWidget:completeAnimation()
			f7_arg0.KillcamWidget:setAlpha(1)
			f7_local0(f7_arg0.KillcamWidget)
			local f7_local1 = function(f9_arg0)
				f7_arg0.PlayOfTheMatchWidget:beginAnimation(900)
				f7_arg0.PlayOfTheMatchWidget:setAlpha(0)
				f7_arg0.PlayOfTheMatchWidget:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.PlayOfTheMatchWidget:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.PlayOfTheMatchWidget:completeAnimation()
			f7_arg0.PlayOfTheMatchWidget:setAlpha(1)
			f7_local1(f7_arg0.PlayOfTheMatchWidget)
			local f7_local2 = function(f10_arg0)
				f7_arg0.FinalKillcamWidget:beginAnimation(900)
				f7_arg0.FinalKillcamWidget:setAlpha(0)
				f7_arg0.FinalKillcamWidget:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FinalKillcamWidget:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FinalKillcamWidget:completeAnimation()
			f7_arg0.FinalKillcamWidget:setAlpha(1)
			f7_local2(f7_arg0.FinalKillcamWidget)
			local f7_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(100)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.Foreground:beginAnimation(900)
				f7_arg0.Foreground:setAlpha(1)
				f7_arg0.Foreground:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Foreground:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f7_arg0.Foreground:completeAnimation()
			f7_arg0.Foreground:setAlpha(0)
			f7_local3(f7_arg0.Foreground)
		end,
	},
}
CoD.KillcamMenu.__onClose = function(f13_arg0)
	f13_arg0.KillcamWidget:close()
	f13_arg0.PlayOfTheMatchWidget:close()
	f13_arg0.FinalKillcamWidget:close()
end
