CoD.PositionDraft_ViewTeams_Slots = InheritFrom(LUI.UIElement)
CoD.PositionDraft_ViewTeams_Slots.__defaultWidth = 16
CoD.PositionDraft_ViewTeams_Slots.__defaultHeight = 16
CoD.PositionDraft_ViewTeams_Slots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_ViewTeams_Slots)
	self.id = "PositionDraft_ViewTeams_Slots"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backer:setRGB(0, 0, 0)
	backer:setAlpha(0.7)
	self:addElement(backer)
	self.backer = backer
	local fill = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fill:setAlpha(0)
	self:addElement(fill)
	self.fill = fill
	local box_line = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	box_line:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	box_line:setAlpha(0.5)
	box_line:setMaterial(LUI.UIImage.GetCachedMaterial(0xE7BDCB879A5176D))
	box_line:setShaderVector(0, 0, 0, 0, 0)
	box_line:setShaderVector(1, 0, 0, 0, 0)
	box_line:setupNineSliceShader(1, 1)
	self:addElement(box_line)
	self.box_line = box_line
	local pip01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(pip01)
	self.pip01 = pip01
	local pip02 = LUI.UIImage.new(0, 0, 15, 16, 0, 0, 0, 1)
	self:addElement(pip02)
	self.pip02 = pip02
	local pip03 = LUI.UIImage.new(0, 0, 15, 16, 0, 0, 15, 16)
	self:addElement(pip03)
	self.pip03 = pip03
	local pip04 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 15, 16)
	self:addElement(pip04)
	self.pip04 = pip04
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_ViewTeams_Slots.__resetProperties = function(f2_arg0)
	f2_arg0.fill:completeAnimation()
	f2_arg0.pip04:completeAnimation()
	f2_arg0.pip03:completeAnimation()
	f2_arg0.pip02:completeAnimation()
	f2_arg0.pip01:completeAnimation()
	f2_arg0.box_line:completeAnimation()
	f2_arg0.backer:completeAnimation()
	f2_arg0.fill:setAlpha(0)
	f2_arg0.pip04:setAlpha(1)
	f2_arg0.pip03:setAlpha(1)
	f2_arg0.pip02:setAlpha(1)
	f2_arg0.pip01:setAlpha(1)
	f2_arg0.box_line:setAlpha(0.5)
	f2_arg0.backer:setAlpha(0.7)
end
CoD.PositionDraft_ViewTeams_Slots.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Filled = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.fill:completeAnimation()
			f4_arg0.fill:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.fill)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
			f5_arg0.backer:completeAnimation()
			f5_arg0.backer:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.backer)
			f5_arg0.box_line:completeAnimation()
			f5_arg0.box_line:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.box_line)
			f5_arg0.pip01:completeAnimation()
			f5_arg0.pip01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.pip01)
			f5_arg0.pip02:completeAnimation()
			f5_arg0.pip02:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.pip02)
			f5_arg0.pip03:completeAnimation()
			f5_arg0.pip03:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.pip03)
			f5_arg0.pip04:completeAnimation()
			f5_arg0.pip04:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.pip04)
		end,
	},
}
