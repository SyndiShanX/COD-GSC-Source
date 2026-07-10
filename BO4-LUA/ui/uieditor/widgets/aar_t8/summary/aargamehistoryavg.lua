CoD.AARGameHistoryAvg = InheritFrom(LUI.UIElement)
CoD.AARGameHistoryAvg.__defaultWidth = 1311
CoD.AARGameHistoryAvg.__defaultHeight = 23
CoD.AARGameHistoryAvg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARGameHistoryAvg)
	self.id = "AARGameHistoryAvg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AverageLine = LUI.UIImage.new(0, 0, 69, 1243, 0.5, 0.5, -8, 8)
	AverageLine:setImage(RegisterImage(@"uie_ui_menu_aar_stat_avg_line"))
	self:addElement(AverageLine)
	self.AverageLine = AverageLine
	local AverageLineAdd = LUI.UIImage.new(0, 0, 69, 1243, 0.5, 0.5, -8, 8)
	AverageLineAdd:setAlpha(0.65)
	AverageLineAdd:setImage(RegisterImage(@"uie_ui_menu_aar_stat_avg_line"))
	AverageLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	AverageLineAdd:setShaderVector(0, 1.56, 0, 0, 0)
	self:addElement(AverageLineAdd)
	self.AverageLineAdd = AverageLineAdd
	local StatAverageR = LUI.UIImage.new(0, 0, 1243, 1311, 0, 0, -3, 25)
	StatAverageR:setAlpha(0.8)
	StatAverageR:setImage(RegisterImage(@"uie_ui_menu_aar_stat_avg_right"))
	self:addElement(StatAverageR)
	self.StatAverageR = StatAverageR
	local StatAverageL = LUI.UIImage.new(0, 0, 0, 68, 0, 0, -3, 25)
	StatAverageL:setAlpha(0)
	StatAverageL:setZRot(180)
	StatAverageL:setImage(RegisterImage(@"uie_ui_menu_aar_stat_avg_right"))
	self:addElement(StatAverageL)
	self.StatAverageL = StatAverageL
	local AVGL = LUI.UIText.new(0, 0, 31.5, 60.5, 0, 0, 6, 16)
	AVGL:setRGB(0, 0, 0)
	AVGL:setAlpha(0)
	AVGL:setText(LocalizeToUpperString(@"menu/avg"))
	AVGL:setTTF("ttmussels_demibold")
	AVGL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	AVGL:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AVGL:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AVGL)
	self.AVGL = AVGL
	local AVGR = LUI.UIText.new(0, 0, 1263.5, 1292.5, 0, 0, 6, 16)
	AVGR:setRGB(0, 0, 0)
	AVGR:setAlpha(0.95)
	AVGR:setText(LocalizeToUpperString(@"menu/avg"))
	AVGR:setTTF("ttmussels_demibold")
	AVGR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	AVGR:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AVGR:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AVGR)
	self.AVGR = AVGR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARGameHistoryAvg.__resetProperties = function(f2_arg0)
	f2_arg0.AverageLineAdd:completeAnimation()
	f2_arg0.StatAverageL:completeAnimation()
	f2_arg0.StatAverageR:completeAnimation()
	f2_arg0.AVGL:completeAnimation()
	f2_arg0.AverageLineAdd:setAlpha(0.65)
	f2_arg0.AverageLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f2_arg0.AverageLineAdd:setShaderVector(0, 1.56, 0, 0, 0)
	f2_arg0.StatAverageL:setAlpha(0)
	f2_arg0.StatAverageR:setAlpha(0.8)
	f2_arg0.AVGL:setAlpha(0)
end
CoD.AARGameHistoryAvg.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(3000)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setAlpha(0.2)
					f5_arg0:setShaderVector(0, 1, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.AverageLineAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.AverageLineAdd:setAlpha(1)
				f3_arg0.AverageLineAdd:setShaderVector(0, 2, 0, 0, 0)
				f3_arg0.AverageLineAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.AverageLineAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.AverageLineAdd:completeAnimation()
			f3_arg0.AverageLineAdd:setAlpha(0.2)
			f3_arg0.AverageLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f3_arg0.AverageLineAdd:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.AverageLineAdd)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							f10_arg0:beginAnimation(500)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f9_arg0:beginAnimation(1000)
						f9_arg0:setAlpha(0.8)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(1000)
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.StatAverageR:beginAnimation(2500)
				f3_arg0.StatAverageR:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.StatAverageR:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.StatAverageR:completeAnimation()
			f3_arg0.StatAverageR:setAlpha(0.8)
			f3_local1(f3_arg0.StatAverageR)
			f3_arg0.StatAverageL:completeAnimation()
			f3_arg0.StatAverageL:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.StatAverageL)
			f3_arg0.AVGL:completeAnimation()
			f3_arg0.AVGL:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.AVGL)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
