CoD.ProximityAlarm_Icon = InheritFrom(LUI.UIElement)
CoD.ProximityAlarm_Icon.__defaultWidth = 37
CoD.ProximityAlarm_Icon.__defaultHeight = 39
CoD.ProximityAlarm_Icon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ProximityAlarm_Icon)
	self.id = "ProximityAlarm_Icon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local C4 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	C4:setImage(RegisterImage(0x5B5AAE62953369F))
	C4:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(C4)
	self.C4 = C4
	local EnemyDetection = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	EnemyDetection:setAlpha(0)
	EnemyDetection:setImage(RegisterImage(0x278D98D6BCB84FB))
	EnemyDetection:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EnemyDetection)
	self.EnemyDetection = EnemyDetection
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ProximityAlarm_Icon.__resetProperties = function(f2_arg0)
	f2_arg0.C4:completeAnimation()
	f2_arg0.EnemyDetection:completeAnimation()
	f2_arg0.C4:setAlpha(1)
	f2_arg0.EnemyDetection:setAlpha(0)
end
CoD.ProximityAlarm_Icon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.C4:completeAnimation()
			f3_arg0.C4:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.C4)
			f3_arg0.EnemyDetection:completeAnimation()
			f3_arg0.EnemyDetection:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.EnemyDetection)
		end,
	},
	C4 = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.C4:completeAnimation()
			f4_arg0.C4:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.C4)
			f4_arg0.EnemyDetection:completeAnimation()
			f4_arg0.EnemyDetection:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.EnemyDetection)
		end,
	},
	EnemyDetection = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.C4:completeAnimation()
			f5_arg0.C4:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.C4)
			f5_arg0.EnemyDetection:completeAnimation()
			f5_arg0.EnemyDetection:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.EnemyDetection)
		end,
	},
}
