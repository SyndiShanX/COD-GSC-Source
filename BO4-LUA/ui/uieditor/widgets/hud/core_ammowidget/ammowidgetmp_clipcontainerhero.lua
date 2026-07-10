require("x64:a4f0aa4e3a1e010")
CoD.AmmoWidgetMP_ClipContainerHero = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_ClipContainerHero.__defaultWidth = 64
CoD.AmmoWidgetMP_ClipContainerHero.__defaultHeight = 61
CoD.AmmoWidgetMP_ClipContainerHero.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_ClipContainerHero)
	self.id = "AmmoWidgetMP_ClipContainerHero"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Clip = CoD.AmmoWidget_ClipContainerValue.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Clip:setRGB(0.74, 0.74, 0.74)
	Clip:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "ammoInClip", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Clip.Clip:setText(f2_local0)
		end
	end)
	self:addElement(Clip)
	self.Clip = Clip
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_ClipContainerHero.__resetProperties = function(f3_arg0)
	f3_arg0.Clip:completeAnimation()
	f3_arg0.Clip:setRGB(0.74, 0.74, 0.74)
	f3_arg0.Clip:setAlpha(1)
end
CoD.AmmoWidgetMP_ClipContainerHero.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Clip:completeAnimation()
			f4_arg0.Clip:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Clip)
		end,
		Hero = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Clip:beginAnimation(500, Enum[@"luitween"][@"luitween_bounce"])
				f5_arg0.Clip:setAlpha(1)
				f5_arg0.Clip:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Clip:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Clip:completeAnimation()
			f5_arg0.Clip:setAlpha(0)
			f5_local0(f5_arg0.Clip)
		end,
	},
	Weapon = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Clip:beginAnimation(500, Enum[@"luitween"][@"luitween_bounce"])
				f8_arg0.Clip:setAlpha(0)
				f8_arg0.Clip:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Clip:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Clip:completeAnimation()
			f8_arg0.Clip:setAlpha(1)
			f8_local0(f8_arg0.Clip)
		end,
	},
	Ability = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Clip:completeAnimation()
			f10_arg0.Clip:setRGB(ColorSet.BadgeBorder.r, ColorSet.BadgeBorder.g, ColorSet.BadgeBorder.b)
			f10_arg0.clipFinished(f10_arg0.Clip)
		end,
	},
}
CoD.AmmoWidgetMP_ClipContainerHero.__onClose = function(f11_arg0)
	f11_arg0.Clip:close()
end
