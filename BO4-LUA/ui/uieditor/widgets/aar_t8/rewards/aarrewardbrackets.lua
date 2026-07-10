CoD.AARRewardBrackets = InheritFrom(LUI.UIElement)
CoD.AARRewardBrackets.__defaultWidth = 382
CoD.AARRewardBrackets.__defaultHeight = 184
CoD.AARRewardBrackets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardBrackets)
	self.id = "AARRewardBrackets"
	self.soundSet = "default"
	local Corner3 = LUI.UIImage.new(0, 0, 0, 12, 1, 1, -12, 0)
	Corner3:setXRot(180)
	Corner3:setYRot(180)
	Corner3:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(Corner3)
	self.Corner3 = Corner3
	local Corner4 = LUI.UIImage.new(1, 1, -12, 0, 1, 1, -12, 0)
	Corner4:setXRot(180)
	Corner4:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(Corner4)
	self.Corner4 = Corner4
	local Corner2 = LUI.UIImage.new(1, 1, -12, 0, 0, 0, 0, 12)
	Corner2:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(Corner2)
	self.Corner2 = Corner2
	local Corner = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 12)
	Corner:setYRot(180)
	Corner:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(Corner)
	self.Corner = Corner
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
