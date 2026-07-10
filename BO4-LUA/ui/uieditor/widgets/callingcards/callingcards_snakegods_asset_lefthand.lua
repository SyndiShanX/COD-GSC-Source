CoD.callingcards_snakegods_asset_lefthand = InheritFrom(LUI.UIElement)
CoD.callingcards_snakegods_asset_lefthand.__defaultWidth = 10
CoD.callingcards_snakegods_asset_lefthand.__defaultHeight = 10
CoD.callingcards_snakegods_asset_lefthand.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_snakegods_asset_lefthand)
	self.id = "callingcards_snakegods_asset_lefthand"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lefthand = LUI.UIImage.new(0, 0, -68, 68, 0, 0, -94, 10)
	lefthand:setImage(RegisterImage(@"uie_ui_menu_callingcards_snake_gods_hand"))
	self:addElement(lefthand)
	self.lefthand = lefthand
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_snakegods_asset_lefthand.__resetProperties = function(f2_arg0)
	f2_arg0.lefthand:completeAnimation()
	f2_arg0.lefthand:setLeftRight(0, 0, -68, 68)
	f2_arg0.lefthand:setTopBottom(0, 0, -94, 10)
end
CoD.callingcards_snakegods_asset_lefthand.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(710, Enum[@"luitween"][@"luitween_ease_both"])
							f7_arg0:setLeftRight(0, 0, -68, 68)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(1290, Enum[@"luitween"][@"luitween_ease_both"])
						f6_arg0:setLeftRight(0, 0, -89, 47)
						f6_arg0:setTopBottom(0, 0, -76, 28)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setLeftRight(0, 0, -68, 68)
					f5_arg0:setTopBottom(0, 0, -80, 24)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.lefthand:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.lefthand:setLeftRight(0, 0, -88, 48)
				f3_arg0.lefthand:setTopBottom(0, 0, -94, 10)
				f3_arg0.lefthand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lefthand:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.lefthand:completeAnimation()
			f3_arg0.lefthand:setLeftRight(0, 0, -68, 68)
			f3_arg0.lefthand:setTopBottom(0, 0, -76, 28)
			f3_local0(f3_arg0.lefthand)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
