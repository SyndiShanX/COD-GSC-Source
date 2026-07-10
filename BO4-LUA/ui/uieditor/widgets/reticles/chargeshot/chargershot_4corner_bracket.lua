require("x64:1e09a95b75e0bf3")
CoD.ChargerShot_4corner_Bracket = InheritFrom(LUI.UIElement)
CoD.ChargerShot_4corner_Bracket.__defaultWidth = 621
CoD.ChargerShot_4corner_Bracket.__defaultHeight = 601
CoD.ChargerShot_4corner_Bracket.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargerShot_4corner_Bracket)
	self.id = "ChargerShot_4corner_Bracket"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChargeShotOuterReticle0 = CoD.ChargeShot_OuterReticle.new(f1_arg0, f1_arg1, 0, 1, 370, 0, 0, 1, 1, -351)
	self:addElement(ChargeShotOuterReticle0)
	self.ChargeShotOuterReticle0 = ChargeShotOuterReticle0
	local ChargeShotOuterReticle1 = CoD.ChargeShot_OuterReticle.new(f1_arg0, f1_arg1, 0, 1, 0, -370, 0, 1, 1, -351)
	ChargeShotOuterReticle1:setYRot(180)
	self:addElement(ChargeShotOuterReticle1)
	self.ChargeShotOuterReticle1 = ChargeShotOuterReticle1
	local ChargeShotOuterReticle2 = CoD.ChargeShot_OuterReticle.new(f1_arg0, f1_arg1, 0, 1, 0, -370, 0, 1, 351, -1)
	ChargeShotOuterReticle2:setZRot(-180)
	self:addElement(ChargeShotOuterReticle2)
	self.ChargeShotOuterReticle2 = ChargeShotOuterReticle2
	local ChargeShotOuterReticle3 = CoD.ChargeShot_OuterReticle.new(f1_arg0, f1_arg1, 0, 1, 370, 0, 0, 1, 351, -1)
	ChargeShotOuterReticle3:setYRot(180)
	ChargeShotOuterReticle3:setZRot(-180)
	self:addElement(ChargeShotOuterReticle3)
	self.ChargeShotOuterReticle3 = ChargeShotOuterReticle3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChargerShot_4corner_Bracket.__resetProperties = function(f2_arg0)
	f2_arg0.ChargeShotOuterReticle3:completeAnimation()
	f2_arg0.ChargeShotOuterReticle1:completeAnimation()
	f2_arg0.ChargeShotOuterReticle2:completeAnimation()
	f2_arg0.ChargeShotOuterReticle0:completeAnimation()
	f2_arg0.ChargeShotOuterReticle3:setLeftRight(0, 1, 370, 0)
	f2_arg0.ChargeShotOuterReticle3:setTopBottom(0, 1, 351, -1)
	f2_arg0.ChargeShotOuterReticle3:setXRot(0)
	f2_arg0.ChargeShotOuterReticle1:setLeftRight(0, 1, 0, -370)
	f2_arg0.ChargeShotOuterReticle1:setTopBottom(0, 1, 1, -351)
	f2_arg0.ChargeShotOuterReticle2:setLeftRight(0, 1, 0, -370)
	f2_arg0.ChargeShotOuterReticle2:setTopBottom(0, 1, 351, -1)
	f2_arg0.ChargeShotOuterReticle0:setLeftRight(0, 1, 370, 0)
	f2_arg0.ChargeShotOuterReticle0:setTopBottom(0, 1, 1, -351)
end
CoD.ChargerShot_4corner_Bracket.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Fire = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.ChargeShotOuterReticle0:beginAnimation(400)
			f4_arg0.ChargeShotOuterReticle0:setLeftRight(0, 1, 315, -55)
			f4_arg0.ChargeShotOuterReticle0:setTopBottom(0, 1, 55, -297)
			f4_arg0.ChargeShotOuterReticle0:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotOuterReticle0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			f4_arg0.ChargeShotOuterReticle1:beginAnimation(390)
			f4_arg0.ChargeShotOuterReticle1:setLeftRight(0, 1, 54, -316)
			f4_arg0.ChargeShotOuterReticle1:setTopBottom(0, 1, 55, -297)
			f4_arg0.ChargeShotOuterReticle1:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotOuterReticle1:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			f4_arg0.ChargeShotOuterReticle2:beginAnimation(390)
			f4_arg0.ChargeShotOuterReticle2:setLeftRight(0, 1, 54, -316)
			f4_arg0.ChargeShotOuterReticle2:setTopBottom(0, 1, 303, -49)
			f4_arg0.ChargeShotOuterReticle2:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotOuterReticle2:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			local f4_local0 = function(f5_arg0)
				f5_arg0:beginAnimation(269)
				f5_arg0:setLeftRight(0, 1, 315, -55)
				f5_arg0:setTopBottom(0, 1, 303, -49)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.ChargeShotOuterReticle3:beginAnimation(120)
			f4_arg0.ChargeShotOuterReticle3:setLeftRight(0, 0, 130, 130)
			f4_arg0.ChargeShotOuterReticle3:setTopBottom(0, 0, 127, 127)
			f4_arg0.ChargeShotOuterReticle3:setXRot(0)
			f4_arg0.ChargeShotOuterReticle3:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotOuterReticle3:registerEventHandler("transition_complete_keyframe", f4_local0)
		end,
		Cancel = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ChargerShot_4corner_Bracket.__onClose = function(f7_arg0)
	f7_arg0.ChargeShotOuterReticle0:close()
	f7_arg0.ChargeShotOuterReticle1:close()
	f7_arg0.ChargeShotOuterReticle2:close()
	f7_arg0.ChargeShotOuterReticle3:close()
end
