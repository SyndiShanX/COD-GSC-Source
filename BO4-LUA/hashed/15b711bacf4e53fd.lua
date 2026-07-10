CoD.SpawnRegionCursor = InheritFrom(LUI.UIElement)
CoD.SpawnRegionCursor.__defaultWidth = 128
CoD.SpawnRegionCursor.__defaultHeight = 128
CoD.SpawnRegionCursor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionCursor)
	self.id = "SpawnRegionCursor"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Crosshair = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	Crosshair:setRGB(0.67, 0.92, 1)
	Crosshair:setImage(RegisterImage(@"uie_ui_hud_selectspawn_cursor"))
	self:addElement(Crosshair)
	self.Crosshair = Crosshair
	local CrosshairAdd = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	CrosshairAdd:setRGB(0.67, 0.92, 1)
	CrosshairAdd:setAlpha(0)
	CrosshairAdd:setImage(RegisterImage(@"uie_ui_hud_selectspawn_cursor"))
	CrosshairAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CrosshairAdd)
	self.CrosshairAdd = CrosshairAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnRegionCursor.__resetProperties = function(f2_arg0)
	f2_arg0.Crosshair:completeAnimation()
	f2_arg0.CrosshairAdd:completeAnimation()
	f2_arg0.Crosshair:setAlpha(1)
	f2_arg0.Crosshair:setScale(1, 1)
	f2_arg0.CrosshairAdd:setAlpha(0)
	f2_arg0.CrosshairAdd:setScale(1, 1)
end
CoD.SpawnRegionCursor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Crosshair:completeAnimation()
			f3_arg0.Crosshair:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.Crosshair)
		end,
		Release = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.Crosshair:beginAnimation(200)
				f4_arg0.Crosshair:setAlpha(0)
				f4_arg0.Crosshair:setScale(1, 1)
				f4_arg0.Crosshair:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Crosshair:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Crosshair:completeAnimation()
			f4_arg0.Crosshair:setAlpha(0.8)
			f4_arg0.Crosshair:setScale(0.9, 0.9)
			f4_local0(f4_arg0.Crosshair)
		end,
		Acquire = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Crosshair:beginAnimation(100)
				f6_arg0.Crosshair:setAlpha(0.8)
				f6_arg0.Crosshair:setScale(0.9, 0.9)
				f6_arg0.Crosshair:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Crosshair:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Crosshair:completeAnimation()
			f6_arg0.Crosshair:setAlpha(0)
			f6_arg0.Crosshair:setScale(2.5, 2.5)
			f6_local0(f6_arg0.Crosshair)
		end,
		Snap = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Crosshair:beginAnimation(90, Enum[@"luitween"][@"luitween_ease_both"])
				f8_arg0.Crosshair:setAlpha(0.8)
				f8_arg0.Crosshair:setScale(0.9, 0.9)
				f8_arg0.Crosshair:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Crosshair:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Crosshair:completeAnimation()
			f8_arg0.Crosshair:setAlpha(0)
			f8_arg0.Crosshair:setScale(4, 4)
			f8_local0(f8_arg0.Crosshair)
			local f8_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(29, Enum[@"luitween"][@"luitween_ease_in"])
					f11_arg0:setAlpha(0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.CrosshairAdd:beginAnimation(90, Enum[@"luitween"][@"luitween_ease_both"])
				f8_arg0.CrosshairAdd:setScale(0.9, 0.9)
				f8_arg0.CrosshairAdd:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CrosshairAdd:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f8_arg0.CrosshairAdd:completeAnimation()
			f8_arg0.CrosshairAdd:setAlpha(1)
			f8_arg0.CrosshairAdd:setScale(4, 4)
			f8_local1(f8_arg0.CrosshairAdd)
		end,
	},
}
