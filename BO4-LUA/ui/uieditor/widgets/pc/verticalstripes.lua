CoD.VerticalStripes = InheritFrom(LUI.UIElement)
CoD.VerticalStripes.__defaultWidth = 602
CoD.VerticalStripes.__defaultHeight = 24
CoD.VerticalStripes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VerticalStripes)
	self.id = "VerticalStripes"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapLayoutStripe = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapLayoutStripe:setAlpha(0.12)
	MapLayoutStripe:setImage(RegisterImage(@"hash_6E188316C34F5BAA"))
	MapLayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(MapLayoutStripe)
	self.MapLayoutStripe = MapLayoutStripe
	local MapLayoutStripeAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapLayoutStripeAdd:setAlpha(0.5)
	MapLayoutStripeAdd:setImage(RegisterImage(@"hash_6E188316C34F5BAA"))
	MapLayoutStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	MapLayoutStripeAdd:setShaderVector(0, 0, 1, 0, 0)
	MapLayoutStripeAdd:setShaderVector(1, 0, 0, 0, 0)
	MapLayoutStripeAdd:setShaderVector(2, 0, 1, 0, 0)
	MapLayoutStripeAdd:setShaderVector(3, 0, 0, 0, 0)
	MapLayoutStripeAdd:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(MapLayoutStripeAdd)
	self.MapLayoutStripeAdd = MapLayoutStripeAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VerticalStripes.__resetProperties = function(f2_arg0)
	f2_arg0.MapLayoutStripeAdd:completeAnimation()
	f2_arg0.MapLayoutStripeAdd:setLeftRight(0, 1, 0, 0)
	f2_arg0.MapLayoutStripeAdd:setAlpha(0.5)
	f2_arg0.MapLayoutStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	f2_arg0.MapLayoutStripeAdd:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.MapLayoutStripeAdd:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.MapLayoutStripeAdd:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.MapLayoutStripeAdd:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.MapLayoutStripeAdd:setShaderVector(4, 0, 0, 0, 0)
end
CoD.VerticalStripes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								f8_arg0:beginAnimation(1849)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f7_arg0:beginAnimation(490)
							f7_arg0:setAlpha(0.45)
							f7_arg0:setShaderVector(0, 1, 1, 0, 0)
							f7_arg0:setShaderVector(1, 0, 0, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setAlpha(0.55)
						f6_arg0:setShaderVector(0, 0.33, 1, 0, 0)
						f6_arg0:setShaderVector(1, 0.5, 0, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(409)
					f5_arg0:setAlpha(0.65)
					f5_arg0:setShaderVector(0, 0, 1, 0, 0)
					f5_arg0:setShaderVector(1, 1, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.MapLayoutStripeAdd:beginAnimation(370)
				f3_arg0.MapLayoutStripeAdd:setAlpha(0.54)
				f3_arg0.MapLayoutStripeAdd:setShaderVector(0, 0, 0.48, 0, 0)
				f3_arg0.MapLayoutStripeAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.MapLayoutStripeAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.MapLayoutStripeAdd:completeAnimation()
			f3_arg0.MapLayoutStripeAdd:setLeftRight(0, 1, 0, 0)
			f3_arg0.MapLayoutStripeAdd:setAlpha(0.45)
			f3_arg0.MapLayoutStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
			f3_arg0.MapLayoutStripeAdd:setShaderVector(0, 0, 0, 0, 0)
			f3_arg0.MapLayoutStripeAdd:setShaderVector(1, 0.5, 0, 0, 0)
			f3_arg0.MapLayoutStripeAdd:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.MapLayoutStripeAdd:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.MapLayoutStripeAdd:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.MapLayoutStripeAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
