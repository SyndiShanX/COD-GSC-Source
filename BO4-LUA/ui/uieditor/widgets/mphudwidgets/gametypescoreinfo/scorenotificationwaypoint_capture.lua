CoD.ScoreNotificationWaypoint_Capture = InheritFrom(LUI.UIElement)
CoD.ScoreNotificationWaypoint_Capture.__defaultWidth = 96
CoD.ScoreNotificationWaypoint_Capture.__defaultHeight = 96
CoD.ScoreNotificationWaypoint_Capture.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreNotificationWaypoint_Capture)
	self.id = "ScoreNotificationWaypoint_Capture"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.35, 0.35, 0.35)
	BG:setAlpha(0)
	BG:setImage(RegisterImage(0x3BF343DD71EE04E))
	self:addElement(BG)
	self.BG = BG
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -37.5, 38.5)
	WaypointPattern:setAlpha(0.7)
	WaypointPattern:setImage(RegisterImage(0xD35B12E94483619))
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local Ring = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	Ring:setScale(0.7, 0.7)
	Ring:setImage(RegisterImage(0x632454E45B21D53))
	self:addElement(Ring)
	self.Ring = Ring
	local CheckIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 2, 2)
	CheckIcon:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	CheckIcon:setAlpha(0)
	CheckIcon:setScale(1.5, 1.5)
	CheckIcon:setImage(RegisterImage(0x92EAA6F7CD84C92))
	self:addElement(CheckIcon)
	self.CheckIcon = CheckIcon
	local CrossIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 2, 2)
	CrossIcon:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	CrossIcon:setScale(1.5, 1.5)
	CrossIcon:setImage(RegisterImage(0x1CE082E174BE175))
	self:addElement(CrossIcon)
	self.CrossIcon = CrossIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreNotificationWaypoint_Capture.__resetProperties = function(f2_arg0)
	f2_arg0.CrossIcon:completeAnimation()
	f2_arg0.CheckIcon:completeAnimation()
	f2_arg0.BG:completeAnimation()
	f2_arg0.Ring:completeAnimation()
	f2_arg0.WaypointPattern:completeAnimation()
	f2_arg0.CrossIcon:setAlpha(1)
	f2_arg0.CheckIcon:setAlpha(0)
	f2_arg0.BG:setAlpha(0)
	f2_arg0.Ring:setRGB(1, 1, 1)
	f2_arg0.Ring:setAlpha(1)
	f2_arg0.WaypointPattern:setRGB(1, 1, 1)
end
CoD.ScoreNotificationWaypoint_Capture.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			f3_arg0.BG:completeAnimation()
			f3_arg0.BG:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.BG)
			f3_arg0.Ring:completeAnimation()
			f3_arg0.Ring:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Ring)
			f3_arg0.CheckIcon:completeAnimation()
			f3_arg0.CheckIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.CheckIcon)
			f3_arg0.CrossIcon:completeAnimation()
			f3_arg0.CrossIcon:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.CrossIcon)
		end,
	},
	AttackTeam = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(5)
			f4_arg0.BG:completeAnimation()
			f4_arg0.BG:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.BG)
			f4_arg0.WaypointPattern:completeAnimation()
			f4_arg0.WaypointPattern:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
			f4_arg0.clipFinished(f4_arg0.WaypointPattern)
			f4_arg0.Ring:completeAnimation()
			f4_arg0.Ring:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
			f4_arg0.clipFinished(f4_arg0.Ring)
			f4_arg0.CheckIcon:completeAnimation()
			f4_arg0.CheckIcon:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.CheckIcon)
			f4_arg0.CrossIcon:completeAnimation()
			f4_arg0.CrossIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CrossIcon)
		end,
	},
	DefendTeam = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.BG:completeAnimation()
			f5_arg0.BG:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BG)
			f5_arg0.WaypointPattern:completeAnimation()
			f5_arg0.WaypointPattern:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
			f5_arg0.clipFinished(f5_arg0.WaypointPattern)
			f5_arg0.Ring:completeAnimation()
			f5_arg0.Ring:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
			f5_arg0.clipFinished(f5_arg0.Ring)
			f5_arg0.CheckIcon:completeAnimation()
			f5_arg0.CheckIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CheckIcon)
			f5_arg0.CrossIcon:completeAnimation()
			f5_arg0.CrossIcon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.CrossIcon)
		end,
	},
}
