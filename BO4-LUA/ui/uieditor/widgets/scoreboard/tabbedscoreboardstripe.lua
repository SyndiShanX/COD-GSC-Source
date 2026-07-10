CoD.TabbedScoreboardStripe = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardStripe.__defaultWidth = 602
CoD.TabbedScoreboardStripe.__defaultHeight = 24
CoD.TabbedScoreboardStripe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardStripe)
	self.id = "TabbedScoreboardStripe"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapLayoutStripe = LUI.UIImage.new(0, 0, 0, 602, 0, 0, 0, 24)
	MapLayoutStripe:setImage(RegisterImage(@"hash_2C9D613B4A6711AA"))
	self:addElement(MapLayoutStripe)
	self.MapLayoutStripe = MapLayoutStripe
	local MapLayoutStripePC = nil
	MapLayoutStripePC = LUI.UIImage.new(0, 0, 0, 602, 0, 0, 0, 24)
	MapLayoutStripePC:setAlpha(0)
	MapLayoutStripePC:setImage(RegisterImage(@"hash_6461DCBE6816FA39"))
	self:addElement(MapLayoutStripePC)
	self.MapLayoutStripePC = MapLayoutStripePC
	local MapLayoutStripeAdd = LUI.UIImage.new(0, 0, 0, 602, 0, 0, 0, 24)
	MapLayoutStripeAdd:setAlpha(0.5)
	MapLayoutStripeAdd:setImage(RegisterImage(@"hash_2C9D613B4A6711AA"))
	MapLayoutStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	MapLayoutStripeAdd:setShaderVector(0, 0, 1, 0, 0)
	MapLayoutStripeAdd:setShaderVector(1, 0, 0, 0, 0)
	MapLayoutStripeAdd:setShaderVector(2, 0, 1, 0, 0)
	MapLayoutStripeAdd:setShaderVector(3, 0, 0, 0, 0)
	MapLayoutStripeAdd:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MapLayoutStripeAdd)
	self.MapLayoutStripeAdd = MapLayoutStripeAdd
	local MapLayoutStripeAddPC = nil
	MapLayoutStripeAddPC = LUI.UIImage.new(0, 0, 0, 602, 0, 0, 0, 24)
	MapLayoutStripeAddPC:setAlpha(0)
	MapLayoutStripeAddPC:setImage(RegisterImage(@"hash_6461DCBE6816FA39"))
	MapLayoutStripeAddPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	MapLayoutStripeAddPC:setShaderVector(0, 0, 1, 0, 0)
	MapLayoutStripeAddPC:setShaderVector(1, 0, 0, 0, 0)
	MapLayoutStripeAddPC:setShaderVector(2, 0, 1, 0, 0)
	MapLayoutStripeAddPC:setShaderVector(3, 0, 0, 0, 0)
	MapLayoutStripeAddPC:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MapLayoutStripeAddPC)
	self.MapLayoutStripeAddPC = MapLayoutStripeAddPC
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardStripe.__resetProperties = function(f3_arg0)
	f3_arg0.MapLayoutStripeAdd:completeAnimation()
	f3_arg0.MapLayoutStripeAddPC:completeAnimation()
	f3_arg0.MapLayoutStripePC:completeAnimation()
	f3_arg0.MapLayoutStripe:completeAnimation()
	f3_arg0.MapLayoutStripeAdd:setAlpha(0.5)
	f3_arg0.MapLayoutStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	f3_arg0.MapLayoutStripeAdd:setShaderVector(0, 0, 1, 0, 0)
	f3_arg0.MapLayoutStripeAdd:setShaderVector(1, 0, 0, 0, 0)
	f3_arg0.MapLayoutStripeAdd:setShaderVector(2, 0, 1, 0, 0)
	f3_arg0.MapLayoutStripeAdd:setShaderVector(3, 0, 0, 0, 0)
	f3_arg0.MapLayoutStripeAdd:setShaderVector(4, 0, 0, 0, 0)
	f3_arg0.MapLayoutStripeAddPC:setAlpha(0)
	f3_arg0.MapLayoutStripeAddPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	f3_arg0.MapLayoutStripeAddPC:setShaderVector(0, 0, 1, 0, 0)
	f3_arg0.MapLayoutStripeAddPC:setShaderVector(1, 0, 0, 0, 0)
	f3_arg0.MapLayoutStripeAddPC:setShaderVector(2, 0, 1, 0, 0)
	f3_arg0.MapLayoutStripeAddPC:setShaderVector(3, 0, 0, 0, 0)
	f3_arg0.MapLayoutStripeAddPC:setShaderVector(4, 0, 0, 0, 0)
	f3_arg0.MapLayoutStripePC:setAlpha(0)
	f3_arg0.MapLayoutStripe:setAlpha(1)
end
CoD.TabbedScoreboardStripe.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								f9_arg0:beginAnimation(990)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f8_arg0:beginAnimation(510)
							f8_arg0:setAlpha(0.5)
							f8_arg0:setShaderVector(0, 1, 1, 0, 0)
							f8_arg0:setShaderVector(1, 0, 0, 0, 0)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(500)
						f7_arg0:setAlpha(0.6)
						f7_arg0:setShaderVector(0, 0.33, 1, 0, 0)
						f7_arg0:setShaderVector(1, 0.5, 0, 0, 0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(500)
					f6_arg0:setAlpha(0.7)
					f6_arg0:setShaderVector(0, 0, 1, 0, 0)
					f6_arg0:setShaderVector(1, 1, 0, 0, 0)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.MapLayoutStripeAdd:beginAnimation(500)
				f4_arg0.MapLayoutStripeAdd:setAlpha(0.6)
				f4_arg0.MapLayoutStripeAdd:setShaderVector(0, 0, 0.48, 0, 0)
				f4_arg0.MapLayoutStripeAdd:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.MapLayoutStripeAdd:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.MapLayoutStripeAdd:completeAnimation()
			f4_arg0.MapLayoutStripeAdd:setAlpha(0.5)
			f4_arg0.MapLayoutStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
			f4_arg0.MapLayoutStripeAdd:setShaderVector(0, 0, 0, 0, 0)
			f4_arg0.MapLayoutStripeAdd:setShaderVector(1, 0.5, 0, 0, 0)
			f4_arg0.MapLayoutStripeAdd:setShaderVector(2, 0, 1, 0, 0)
			f4_arg0.MapLayoutStripeAdd:setShaderVector(3, 0, 0, 0, 0)
			f4_arg0.MapLayoutStripeAdd:setShaderVector(4, 0, 0, 0, 0)
			f4_local0(f4_arg0.MapLayoutStripeAdd)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.MapLayoutStripe:completeAnimation()
			f10_arg0.MapLayoutStripe:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MapLayoutStripe)
			f10_arg0.MapLayoutStripePC:completeAnimation()
			f10_arg0.MapLayoutStripePC:setAlpha(0.7)
			f10_arg0.clipFinished(f10_arg0.MapLayoutStripePC)
			f10_arg0.MapLayoutStripeAdd:completeAnimation()
			f10_arg0.MapLayoutStripeAdd:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MapLayoutStripeAdd)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							local f14_local0 = function(f15_arg0)
								f15_arg0:beginAnimation(990)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
							end
							f14_arg0:beginAnimation(510)
							f14_arg0:setAlpha(0.5)
							f14_arg0:setShaderVector(0, 1, 1, 0, 0)
							f14_arg0:setShaderVector(1, 0, 0, 0, 0)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(500)
						f13_arg0:setAlpha(0.6)
						f13_arg0:setShaderVector(0, 0.33, 1, 0, 0)
						f13_arg0:setShaderVector(1, 0.5, 0, 0, 0)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(500)
					f12_arg0:setAlpha(0.7)
					f12_arg0:setShaderVector(0, 0, 1, 0, 0)
					f12_arg0:setShaderVector(1, 1, 0, 0, 0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f10_arg0.MapLayoutStripeAddPC:beginAnimation(500)
				f10_arg0.MapLayoutStripeAddPC:setAlpha(0.6)
				f10_arg0.MapLayoutStripeAddPC:setShaderVector(0, 0, 0.48, 0, 0)
				f10_arg0.MapLayoutStripeAddPC:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.MapLayoutStripeAddPC:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.MapLayoutStripeAddPC:completeAnimation()
			f10_arg0.MapLayoutStripeAddPC:setAlpha(0.5)
			f10_arg0.MapLayoutStripeAddPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
			f10_arg0.MapLayoutStripeAddPC:setShaderVector(0, 0, 0, 0, 0)
			f10_arg0.MapLayoutStripeAddPC:setShaderVector(1, 0.5, 0, 0, 0)
			f10_arg0.MapLayoutStripeAddPC:setShaderVector(2, 0, 1, 0, 0)
			f10_arg0.MapLayoutStripeAddPC:setShaderVector(3, 0, 0, 0, 0)
			f10_arg0.MapLayoutStripeAddPC:setShaderVector(4, 0, 0, 0, 0)
			f10_local0(f10_arg0.MapLayoutStripeAddPC)
			f10_arg0.nextClip = "DefaultClip"
		end,
	},
}
