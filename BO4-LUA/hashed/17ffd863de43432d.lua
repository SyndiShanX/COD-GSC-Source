CoD.Client_LeaderIcon = InheritFrom(LUI.UIElement)
CoD.Client_LeaderIcon.__defaultWidth = 30
CoD.Client_LeaderIcon.__defaultHeight = 30
CoD.Client_LeaderIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Client_LeaderIcon)
	self.id = "Client_LeaderIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaderIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LeaderIcon:setImage(RegisterImage(0xCC30C39E4A100F))
	self:addElement(LeaderIcon)
	self.LeaderIcon = LeaderIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ClientIsLeader(element, f1_arg1)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Client_LeaderIcon.__resetProperties = function(f3_arg0)
	f3_arg0.LeaderIcon:completeAnimation()
	f3_arg0.LeaderIcon:setAlpha(1)
end
CoD.Client_LeaderIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.LeaderIcon:completeAnimation()
			f4_arg0.LeaderIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.LeaderIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LeaderIcon:completeAnimation()
			f5_arg0.LeaderIcon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.LeaderIcon)
		end,
	},
}
