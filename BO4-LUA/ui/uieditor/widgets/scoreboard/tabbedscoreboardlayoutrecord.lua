CoD.TabbedScoreboardLayoutRecord = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardLayoutRecord.__defaultWidth = 111
CoD.TabbedScoreboardLayoutRecord.__defaultHeight = 24
CoD.TabbedScoreboardLayoutRecord.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardLayoutRecord)
	self.id = "TabbedScoreboardLayoutRecord"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Record = LUI.UIImage.new(0, 0, 0, 84, 0, 0, 4.5, 20.5)
	Record:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_map_record"))
	self:addElement(Record)
	self.Record = Record
	local RecordAdd = LUI.UIImage.new(0, 0, 0, 84, 0, 0, 4.5, 20.5)
	RecordAdd:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_map_record"))
	RecordAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	RecordAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(RecordAdd)
	self.RecordAdd = RecordAdd
	local RecordDot = LUI.UIImage.new(0, 0, 86.5, 110.5, 0, 0, 0, 24)
	RecordDot:setImage(RegisterImage(@"uie_ui_hud_selectspawn_layout_reddot"))
	self:addElement(RecordDot)
	self.RecordDot = RecordDot
	local RecordDotAdd = LUI.UIImage.new(0, 0, 86.5, 110.5, 0, 0, 0, 24)
	RecordDotAdd:setImage(RegisterImage(@"uie_ui_hud_selectspawn_layout_reddot"))
	RecordDotAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	RecordDotAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(RecordDotAdd)
	self.RecordDotAdd = RecordDotAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardLayoutRecord.__resetProperties = function(f2_arg0)
	f2_arg0.RecordAdd:completeAnimation()
	f2_arg0.RecordDotAdd:completeAnimation()
	f2_arg0.RecordAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f2_arg0.RecordAdd:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.RecordDotAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f2_arg0.RecordDotAdd:setShaderVector(0, 1, 0, 0, 0)
end
CoD.TabbedScoreboardLayoutRecord.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setShaderVector(0, 0, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.RecordAdd:beginAnimation(1500)
				f3_arg0.RecordAdd:setShaderVector(0, 1, 0, 0, 0)
				f3_arg0.RecordAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.RecordAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.RecordAdd:completeAnimation()
			f3_arg0.RecordAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f3_arg0.RecordAdd:setShaderVector(0, 0, 0, 0, 0)
			f3_local0(f3_arg0.RecordAdd)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							local f9_local0 = function(f10_arg0)
								local f10_local0 = function(f11_arg0)
									local f11_local0 = function(f12_arg0)
										local f12_local0 = function(f13_arg0)
											f13_arg0:beginAnimation(500)
											f13_arg0:setShaderVector(0, 0, 0, 0, 0)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f12_arg0:beginAnimation(500)
										f12_arg0:setShaderVector(0, 1, 0, 0, 0)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(500)
									f11_arg0:setShaderVector(0, 0, 0, 0, 0)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(500)
								f10_arg0:setShaderVector(0, 1, 0, 0, 0)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(500)
							f9_arg0:setShaderVector(0, 0, 0, 0, 0)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(500)
						f8_arg0:setShaderVector(0, 1, 0, 0, 0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(500)
					f7_arg0:setShaderVector(0, 0, 0, 0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.RecordDotAdd:beginAnimation(500)
				f3_arg0.RecordDotAdd:setShaderVector(0, 1, 0, 0, 0)
				f3_arg0.RecordDotAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.RecordDotAdd:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.RecordDotAdd:completeAnimation()
			f3_arg0.RecordDotAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f3_arg0.RecordDotAdd:setShaderVector(0, 0, 0, 0, 0)
			f3_local1(f3_arg0.RecordDotAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
