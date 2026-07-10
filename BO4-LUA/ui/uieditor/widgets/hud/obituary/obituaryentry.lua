CoD.ObituaryEntry = InheritFrom(LUI.UIElement)
CoD.ObituaryEntry.__defaultWidth = 500
CoD.ObituaryEntry.__defaultHeight = 34
CoD.ObituaryEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ObituaryEntry)
	self.id = "ObituaryEntry"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(-0.01, 1.01, -5, 5, 0.09, 1.09, -4, -2)
	Blur:setRGB(0, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	Blur:setShaderVector(0, 0, 0.68, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Attacker = LUI.UIText.new(0, 0, 0, 168, 0.48, 0.48, -13, 13)
	Attacker:setTTF("notosans_regular")
	Attacker:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Attacker.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			Attacker:setRGB(ConsoleColorFromIndex(f1_arg1, f2_local0))
		end
	end
	Attacker:linkToElementModel(self, "attackerColor", true, Attacker.__Color)
	Attacker.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.attackerColor
		end
		if f3_local0 then
			Attacker.__Color(f3_local0)
		end
	end
	Attacker:linkToElementModel(self, "attacker", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Attacker:setText(CoD.SocialUtility.CleanGamerTag(f4_local0))
		end
	end)
	self:addElement(Attacker)
	self.Attacker = Attacker
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 172, 236, 0, 0, 0, 32)
	FixedAspectRatioImage:setStretchedDimension(0)
	FixedAspectRatioImage:setAutoSizeProperty(true)
	FixedAspectRatioImage:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local Victim = LUI.UIText.new(0, 0, 240, 424, 0.48, 0.48, -12.5, 12.5)
	Victim:setTTF("notosans_regular")
	Victim:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Victim.__Color = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			Victim:setRGB(ConsoleColorFromIndex(f1_arg1, f6_local0))
		end
	end
	Victim:linkToElementModel(self, "victimColor", true, Victim.__Color)
	Victim.__Color_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.victimColor
		end
		if f7_local0 then
			Victim.__Color(f7_local0)
		end
	end
	Victim:linkToElementModel(self, "victim", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Victim:setText(CoD.SocialUtility.CleanGamerTag(f8_local0))
		end
	end)
	self:addElement(Victim)
	self.Victim = Victim
	local f1_local5 = Attacker
	local f1_local6 = Attacker.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["profile.colorblindMode"], Attacker.__Color_FullPath)
	f1_local5 = Victim
	f1_local6 = Victim.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["profile.colorblindMode"], Victim.__Color_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	if IsWarzone() then
		CoD.ConsoleUtility.ObituaryEntryInit(self, f1_arg1, 5000, CoD.ConsoleUtility.ObituaryEntryDirection.DOWN)
	else
		CoD.ConsoleUtility.ObituaryEntryInit(self, f1_arg1, 5000, CoD.ConsoleUtility.ObituaryEntryDirection.UP)
	end
	return self
end
CoD.ObituaryEntry.__resetProperties = function(f9_arg0)
	f9_arg0.FixedAspectRatioImage:completeAnimation()
	f9_arg0.Blur:completeAnimation()
	f9_arg0.Attacker:completeAnimation()
	f9_arg0.Victim:completeAnimation()
	f9_arg0.FixedAspectRatioImage:setAlpha(1)
	f9_arg0.Blur:setAlpha(1)
	f9_arg0.Attacker:setAlpha(1)
	f9_arg0.Victim:setAlpha(1)
end
CoD.ObituaryEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.Blur:completeAnimation()
			f10_arg0.Blur:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Blur)
			f10_arg0.Attacker:completeAnimation()
			f10_arg0.Attacker:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Attacker)
			f10_arg0.FixedAspectRatioImage:completeAnimation()
			f10_arg0.FixedAspectRatioImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FixedAspectRatioImage)
			f10_arg0.Victim:completeAnimation()
			f10_arg0.Victim:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Victim)
		end,
		FadeOut = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Blur:beginAnimation(100)
				f11_arg0.Blur:setAlpha(0)
				f11_arg0.Blur:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Blur:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Blur:completeAnimation()
			f11_arg0.Blur:setAlpha(1)
			f11_local0(f11_arg0.Blur)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Attacker:beginAnimation(100)
				f11_arg0.Attacker:setAlpha(0)
				f11_arg0.Attacker:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Attacker:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Attacker:completeAnimation()
			f11_arg0.Attacker:setAlpha(1)
			f11_local1(f11_arg0.Attacker)
			local f11_local2 = function(f14_arg0)
				f11_arg0.FixedAspectRatioImage:beginAnimation(100)
				f11_arg0.FixedAspectRatioImage:setAlpha(0)
				f11_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FixedAspectRatioImage:completeAnimation()
			f11_arg0.FixedAspectRatioImage:setAlpha(1)
			f11_local2(f11_arg0.FixedAspectRatioImage)
			local f11_local3 = function(f15_arg0)
				f11_arg0.Victim:beginAnimation(100)
				f11_arg0.Victim:setAlpha(0)
				f11_arg0.Victim:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Victim:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Victim:completeAnimation()
			f11_arg0.Victim:setAlpha(1)
			f11_local3(f11_arg0.Victim)
		end,
		FadeIn = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Blur:beginAnimation(100)
				f16_arg0.Blur:setAlpha(1)
				f16_arg0.Blur:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Blur:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Blur:completeAnimation()
			f16_arg0.Blur:setAlpha(0)
			f16_local0(f16_arg0.Blur)
			local f16_local1 = function(f18_arg0)
				f16_arg0.Attacker:beginAnimation(100)
				f16_arg0.Attacker:setAlpha(1)
				f16_arg0.Attacker:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Attacker:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Attacker:completeAnimation()
			f16_arg0.Attacker:setAlpha(0)
			f16_local1(f16_arg0.Attacker)
			local f16_local2 = function(f19_arg0)
				f16_arg0.FixedAspectRatioImage:beginAnimation(100)
				f16_arg0.FixedAspectRatioImage:setAlpha(1)
				f16_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.FixedAspectRatioImage:completeAnimation()
			f16_arg0.FixedAspectRatioImage:setAlpha(0)
			f16_local2(f16_arg0.FixedAspectRatioImage)
			local f16_local3 = function(f20_arg0)
				f16_arg0.Victim:beginAnimation(100)
				f16_arg0.Victim:setAlpha(1)
				f16_arg0.Victim:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Victim:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Victim:completeAnimation()
			f16_arg0.Victim:setAlpha(0)
			f16_local3(f16_arg0.Victim)
		end,
	},
}
CoD.ObituaryEntry.__onClose = function(f21_arg0)
	f21_arg0.Attacker:close()
	f21_arg0.FixedAspectRatioImage:close()
	f21_arg0.Victim:close()
end
