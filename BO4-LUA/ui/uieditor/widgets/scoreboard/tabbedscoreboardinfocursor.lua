CoD.TabbedScoreboardInfoCursor = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardInfoCursor.__defaultWidth = 30
CoD.TabbedScoreboardInfoCursor.__defaultHeight = 30
CoD.TabbedScoreboardInfoCursor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardInfoCursor)
	self.id = "TabbedScoreboardInfoCursor"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CursorFocus = LUI.UIImage.new(0, 0, 5, 25, 0, 0, 6, 26)
	CursorFocus:setImage(RegisterImage(0x8DD2B93D88D623D))
	self:addElement(CursorFocus)
	self.CursorFocus = CursorFocus
	local Cursor = LUI.UIImage.new(0, 0, 6, 24, 0, 0, 6, 24)
	Cursor:setImage(RegisterImage(0x850AA28B0953D86))
	self:addElement(Cursor)
	self.Cursor = Cursor
	local CursorGlow = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	CursorGlow:setImage(RegisterImage(0xF6FD4C7B4310756))
	CursorGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CursorGlow)
	self.CursorGlow = CursorGlow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardInfoCursor.__resetProperties = function(f2_arg0)
	f2_arg0.Cursor:completeAnimation()
	f2_arg0.CursorGlow:completeAnimation()
	f2_arg0.CursorFocus:completeAnimation()
	f2_arg0.Cursor:setAlpha(1)
	f2_arg0.CursorGlow:setAlpha(1)
	f2_arg0.CursorFocus:setAlpha(1)
end
CoD.TabbedScoreboardInfoCursor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(500)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(1000)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f4_arg0:beginAnimation(300)
				f4_arg0:setAlpha(1)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.CursorFocus:beginAnimation(200)
			f3_arg0.CursorFocus:setAlpha(0)
			f3_arg0.CursorFocus:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.CursorFocus:registerEventHandler("transition_complete_keyframe", f3_local0)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(500)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(500)
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(1200)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.Cursor:beginAnimation(300, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.Cursor:setAlpha(1)
				f3_arg0.Cursor:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Cursor:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.Cursor:completeAnimation()
			f3_arg0.Cursor:setAlpha(0)
			f3_local1(f3_arg0.Cursor)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							f15_arg0:beginAnimation(500)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f14_arg0:beginAnimation(500)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(1200)
					f13_arg0:setAlpha(0.7)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.CursorGlow:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.CursorGlow:setAlpha(1)
				f3_arg0.CursorGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.CursorGlow:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.CursorGlow:completeAnimation()
			f3_arg0.CursorGlow:setAlpha(0)
			f3_local2(f3_arg0.CursorGlow)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
