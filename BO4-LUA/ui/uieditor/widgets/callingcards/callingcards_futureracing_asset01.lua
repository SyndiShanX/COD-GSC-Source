CoD.CallingCards_FutureRacing_asset01 = InheritFrom(LUI.UIElement)
CoD.CallingCards_FutureRacing_asset01.__defaultWidth = 576
CoD.CallingCards_FutureRacing_asset01.__defaultHeight = 240
CoD.CallingCards_FutureRacing_asset01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_FutureRacing_asset01)
	self.id = "CallingCards_FutureRacing_asset01"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local roadtop = LUI.UIImage.new(0, 0, 0, 576, 0, 0, 0, 240)
	roadtop:setImage(RegisterImage(@"uie_cc_toproad"))
	self:addElement(roadtop)
	self.roadtop = roadtop
	local vehicle02 = LUI.UIImage.new(0, 0, 192, 288, 0, 0, 248, 488)
	vehicle02:setZRot(-38)
	vehicle02:setScale(1.2, 1.2)
	vehicle02:setImage(RegisterImage(@"uie_cc_vehicle03anim"))
	vehicle02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	vehicle02:setShaderVector(0, 3, 0, 0, 0)
	vehicle02:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(vehicle02)
	self.vehicle02 = vehicle02
	local vehicle01 = LUI.UIImage.new(0, 0, -35, 125, 0, 0, 248, 488)
	vehicle01:setZRot(-45)
	vehicle01:setScale(1.2, 1.2)
	vehicle01:setImage(RegisterImage(@"uie_cc_vehicle01anim"))
	vehicle01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	vehicle01:setShaderVector(0, 3, 0, 0, 0)
	vehicle01:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(vehicle01)
	self.vehicle01 = vehicle01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_FutureRacing_asset01.__resetProperties = function(f2_arg0)
	f2_arg0.vehicle02:completeAnimation()
	f2_arg0.vehicle01:completeAnimation()
	f2_arg0.vehicle02:setLeftRight(0, 0, 192, 288)
	f2_arg0.vehicle02:setTopBottom(0, 0, 248, 488)
	f2_arg0.vehicle02:setScale(1.2, 1.2)
	f2_arg0.vehicle01:setLeftRight(0, 0, -35, 125)
	f2_arg0.vehicle01:setTopBottom(0, 0, 248, 488)
	f2_arg0.vehicle01:setScale(1.2, 1.2)
end
CoD.CallingCards_FutureRacing_asset01.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.vehicle02:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.vehicle02:setLeftRight(0, 0, 480, 576)
				f3_arg0.vehicle02:setTopBottom(0, 0, -205, 35)
				f3_arg0.vehicle02:setScale(0.7, 0.7)
				f3_arg0.vehicle02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.vehicle02:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.vehicle02:completeAnimation()
			f3_arg0.vehicle02:setLeftRight(0, 0, 192, 288)
			f3_arg0.vehicle02:setTopBottom(0, 0, 248, 488)
			f3_arg0.vehicle02:setScale(1.2, 1.2)
			f3_local0(f3_arg0.vehicle02)
			local f3_local1 = function(f5_arg0)
				f5_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_in"])
				f5_arg0:setLeftRight(0, 0, 358, 518)
				f5_arg0:setTopBottom(0, 0, -210, 30)
				f5_arg0:setScale(0.7, 0.7)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.vehicle01:beginAnimation(500)
			f3_arg0.vehicle01:setLeftRight(0, 0, -35, 125)
			f3_arg0.vehicle01:setTopBottom(0, 0, 248, 488)
			f3_arg0.vehicle01:setScale(1.2, 1.2)
			f3_arg0.vehicle01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.vehicle01:registerEventHandler("transition_complete_keyframe", f3_local1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
