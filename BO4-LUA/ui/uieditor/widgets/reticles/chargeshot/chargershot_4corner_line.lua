require("x64:193310c856aff8e")
CoD.ChargerShot_4corner_line = InheritFrom(LUI.UIElement)
CoD.ChargerShot_4corner_line.__defaultWidth = 441
CoD.ChargerShot_4corner_line.__defaultHeight = 445
CoD.ChargerShot_4corner_line.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargerShot_4corner_line)
	self.id = "ChargerShot_4corner_line"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChargeShotActiveLine3 = CoD.ChargeShot_ActiveLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -221, -144, 0.5, 0.5, -223, -146)
	ChargeShotActiveLine3:setRGB(0.29, 0.69, 0.95)
	self:addElement(ChargeShotActiveLine3)
	self.ChargeShotActiveLine3 = ChargeShotActiveLine3
	local ChargeShotActiveLine1 = CoD.ChargeShot_ActiveLine.new(f1_arg0, f1_arg1, 0.5, 0.5, 144, 220, 0.5, 0.5, 146, 223)
	ChargeShotActiveLine1:setRGB(0.29, 0.69, 0.95)
	ChargeShotActiveLine1:setXRot(-180)
	ChargeShotActiveLine1:setYRot(180)
	self:addElement(ChargeShotActiveLine1)
	self.ChargeShotActiveLine1 = ChargeShotActiveLine1
	local ChargeShotActiveLine10 = CoD.ChargeShot_ActiveLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -220, -143, 0.5, 0.5, 146, 223)
	ChargeShotActiveLine10:setRGB(0.29, 0.69, 0.95)
	ChargeShotActiveLine10:setXRot(180)
	self:addElement(ChargeShotActiveLine10)
	self.ChargeShotActiveLine10 = ChargeShotActiveLine10
	local ChargeShotActiveLine11 = CoD.ChargeShot_ActiveLine.new(f1_arg0, f1_arg1, 0.5, 0.5, 144, 220, 0.5, 0.5, -223, -146)
	ChargeShotActiveLine11:setRGB(0.29, 0.69, 0.95)
	ChargeShotActiveLine11:setXRot(180)
	ChargeShotActiveLine11:setZRot(180)
	self:addElement(ChargeShotActiveLine11)
	self.ChargeShotActiveLine11 = ChargeShotActiveLine11
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChargerShot_4corner_line.__resetProperties = function(f2_arg0)
	f2_arg0.ChargeShotActiveLine3:completeAnimation()
	f2_arg0.ChargeShotActiveLine10:completeAnimation()
	f2_arg0.ChargeShotActiveLine1:completeAnimation()
	f2_arg0.ChargeShotActiveLine11:completeAnimation()
	f2_arg0.ChargeShotActiveLine3:setLeftRight(0.5, 0.5, -221, -144)
	f2_arg0.ChargeShotActiveLine3:setTopBottom(0.5, 0.5, -223, -146)
	f2_arg0.ChargeShotActiveLine3:setAlpha(1)
	f2_arg0.ChargeShotActiveLine10:setLeftRight(0.5, 0.5, -220, -143)
	f2_arg0.ChargeShotActiveLine10:setTopBottom(0.5, 0.5, 146, 223)
	f2_arg0.ChargeShotActiveLine1:setLeftRight(0.5, 0.5, 144, 220)
	f2_arg0.ChargeShotActiveLine1:setTopBottom(0.5, 0.5, 146, 223)
	f2_arg0.ChargeShotActiveLine1:setAlpha(1)
	f2_arg0.ChargeShotActiveLine11:setLeftRight(0.5, 0.5, 144, 220)
	f2_arg0.ChargeShotActiveLine11:setTopBottom(0.5, 0.5, -223, -146)
	f2_arg0.ChargeShotActiveLine11:setAlpha(1)
end
CoD.ChargerShot_4corner_line.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Fire = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			local f4_local0 = function(f5_arg0)
				f4_arg0.ChargeShotActiveLine3:beginAnimation(50)
				f4_arg0.ChargeShotActiveLine3:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ChargeShotActiveLine3:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.ChargeShotActiveLine3:completeAnimation()
			f4_arg0.ChargeShotActiveLine3:setLeftRight(0.5, 0.5, -102, -25)
			f4_arg0.ChargeShotActiveLine3:setTopBottom(0.5, 0.5, -95.5, -19.5)
			f4_arg0.ChargeShotActiveLine3:setAlpha(1)
			f4_local0(f4_arg0.ChargeShotActiveLine3)
			f4_arg0.ChargeShotActiveLine1:beginAnimation(390)
			f4_arg0.ChargeShotActiveLine1:setLeftRight(0.5, 0.5, 21, 97)
			f4_arg0.ChargeShotActiveLine1:setTopBottom(0.5, 0.5, 26, 103)
			f4_arg0.ChargeShotActiveLine1:setAlpha(1)
			f4_arg0.ChargeShotActiveLine1:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotActiveLine1:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			f4_arg0.ChargeShotActiveLine10:beginAnimation(110)
			f4_arg0.ChargeShotActiveLine10:setLeftRight(0.5, 0.5, -102.5, -26.5)
			f4_arg0.ChargeShotActiveLine10:setTopBottom(0.5, 0.5, 26.5, 102.5)
			f4_arg0.ChargeShotActiveLine10:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotActiveLine10:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			f4_arg0.ChargeShotActiveLine11:beginAnimation(390)
			f4_arg0.ChargeShotActiveLine11:setLeftRight(0.5, 0.5, 21, 97)
			f4_arg0.ChargeShotActiveLine11:setTopBottom(0.5, 0.5, -96, -19)
			f4_arg0.ChargeShotActiveLine11:setAlpha(1)
			f4_arg0.ChargeShotActiveLine11:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.ChargeShotActiveLine11:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
		end,
		Cancel = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ChargerShot_4corner_line.__onClose = function(f7_arg0)
	f7_arg0.ChargeShotActiveLine3:close()
	f7_arg0.ChargeShotActiveLine1:close()
	f7_arg0.ChargeShotActiveLine10:close()
	f7_arg0.ChargeShotActiveLine11:close()
end
