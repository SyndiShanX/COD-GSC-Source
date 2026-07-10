require("x64:ee6d0fdccf48746")
require("x64:244a1783f37ff8d")
CoD.WZObituaryEntry = InheritFrom(LUI.UIElement)
CoD.WZObituaryEntry.__defaultWidth = 500
CoD.WZObituaryEntry.__defaultHeight = 34
CoD.WZObituaryEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.WZObituaryEntry)
	self.id = "WZObituaryEntry"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(-0.01, 1.01, -5, 5, 0.09, 1.09, -4, -2)
	Blur:setRGB(0, 0, 0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	Blur:setShaderVector(0, 0, 0.9, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Attacker = CoD.WZObituaryAttacker.new(f1_arg0, f1_arg1, 0, 0, 92, 260, 0, 0, 2.5, 28.5)
	Attacker:linkToElementModel(self, nil, false, function(model)
		Attacker:setModel(model, f1_arg1)
	end)
	self:addElement(Attacker)
	self.Attacker = Attacker
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 264, 328, 0, 0, 0, 32)
	FixedAspectRatioImage:setStretchedDimension(0)
	FixedAspectRatioImage:setAutoSizeProperty(true)
	FixedAspectRatioImage:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local Victim = CoD.WZObituaryVictim.new(f1_arg0, f1_arg1, 0, 0, 332, 500, 0, 0, 2.5, 28.5)
	Victim:linkToElementModel(self, nil, false, function(model)
		Victim:setModel(model, f1_arg1)
	end)
	self:addElement(Victim)
	self.Victim = Victim
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	if IsWarzone() then
		CoD.ConsoleUtility.ObituaryEntryInit(self, f1_arg1, 5000, CoD.ConsoleUtility.ObituaryEntryDirection.DOWN)
	else
		CoD.ConsoleUtility.ObituaryEntryInit(self, f1_arg1, 5000, CoD.ConsoleUtility.ObituaryEntryDirection.UP)
	end
	return self
end
CoD.WZObituaryEntry.__resetProperties = function(f5_arg0)
	f5_arg0.FixedAspectRatioImage:completeAnimation()
	f5_arg0.Blur:completeAnimation()
	f5_arg0.Attacker:completeAnimation()
	f5_arg0.Victim:completeAnimation()
	f5_arg0.FixedAspectRatioImage:setAlpha(1)
	f5_arg0.Blur:setAlpha(1)
	f5_arg0.Attacker:setAlpha(1)
	f5_arg0.Victim:setAlpha(1)
end
CoD.WZObituaryEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Blur:completeAnimation()
			f6_arg0.Blur:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Blur)
			f6_arg0.FixedAspectRatioImage:completeAnimation()
			f6_arg0.FixedAspectRatioImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FixedAspectRatioImage)
		end,
		FadeOut = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Blur:beginAnimation(100)
				f7_arg0.Blur:setAlpha(0)
				f7_arg0.Blur:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Blur:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Blur:completeAnimation()
			f7_arg0.Blur:setAlpha(1)
			f7_local0(f7_arg0.Blur)
			local f7_local1 = function(f9_arg0)
				f7_arg0.Attacker:beginAnimation(100)
				f7_arg0.Attacker:setAlpha(0)
				f7_arg0.Attacker:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Attacker:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Attacker:completeAnimation()
			f7_arg0.Attacker:setAlpha(1)
			f7_local1(f7_arg0.Attacker)
			local f7_local2 = function(f10_arg0)
				f7_arg0.FixedAspectRatioImage:beginAnimation(100)
				f7_arg0.FixedAspectRatioImage:setAlpha(0)
				f7_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FixedAspectRatioImage:completeAnimation()
			f7_arg0.FixedAspectRatioImage:setAlpha(1)
			f7_local2(f7_arg0.FixedAspectRatioImage)
			local f7_local3 = function(f11_arg0)
				f7_arg0.Victim:beginAnimation(100)
				f7_arg0.Victim:setAlpha(0)
				f7_arg0.Victim:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Victim:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Victim:completeAnimation()
			f7_arg0.Victim:setAlpha(1)
			f7_local3(f7_arg0.Victim)
		end,
		FadeIn = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Blur:beginAnimation(100)
				f12_arg0.Blur:setAlpha(1)
				f12_arg0.Blur:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Blur:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Blur:completeAnimation()
			f12_arg0.Blur:setAlpha(0)
			f12_local0(f12_arg0.Blur)
			local f12_local1 = function(f14_arg0)
				f12_arg0.Attacker:beginAnimation(100)
				f12_arg0.Attacker:setAlpha(1)
				f12_arg0.Attacker:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Attacker:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Attacker:completeAnimation()
			f12_arg0.Attacker:setAlpha(0)
			f12_local1(f12_arg0.Attacker)
			local f12_local2 = function(f15_arg0)
				f12_arg0.FixedAspectRatioImage:beginAnimation(100)
				f12_arg0.FixedAspectRatioImage:setAlpha(1)
				f12_arg0.FixedAspectRatioImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FixedAspectRatioImage:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FixedAspectRatioImage:completeAnimation()
			f12_arg0.FixedAspectRatioImage:setAlpha(0)
			f12_local2(f12_arg0.FixedAspectRatioImage)
			local f12_local3 = function(f16_arg0)
				f12_arg0.Victim:beginAnimation(100)
				f12_arg0.Victim:setAlpha(1)
				f12_arg0.Victim:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Victim:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Victim:completeAnimation()
			f12_arg0.Victim:setAlpha(0)
			f12_local3(f12_arg0.Victim)
		end,
	},
}
CoD.WZObituaryEntry.__onClose = function(f17_arg0)
	f17_arg0.Attacker:close()
	f17_arg0.FixedAspectRatioImage:close()
	f17_arg0.Victim:close()
end
