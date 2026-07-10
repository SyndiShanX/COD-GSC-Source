CoD.DrawEmblemFocusable = InheritFrom(LUI.UIElement)
CoD.DrawEmblemFocusable.__defaultWidth = 1920
CoD.DrawEmblemFocusable.__defaultHeight = 1080
CoD.DrawEmblemFocusable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DrawEmblemFocusable)
	self.id = "DrawEmblemFocusable"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DrawEmblem = nil
	DrawEmblem = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	DrawEmblem:setAlpha(0)
	DrawEmblem:setupEmblem(Enum[@"customizationtype"][@"customization_type_paintshop_view_left"])
	self:addElement(DrawEmblem)
	self.DrawEmblem = DrawEmblem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = DrawEmblem
	if IsPC() then
		SetUsingFocusInterraction(f1_local2, true)
	end
	return self
end
CoD.DrawEmblemFocusable.__resetProperties = function(f2_arg0)
	f2_arg0.DrawEmblem:completeAnimation()
	f2_arg0.DrawEmblem:setAlpha(0)
end
CoD.DrawEmblemFocusable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.DrawEmblem:completeAnimation()
			f4_arg0.DrawEmblem:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DrawEmblem)
		end,
	},
}
if not CoD.isPC then
	CoD.DrawEmblemFocusable.__clipsPerState.DefaultState.Focus = nil
end
CoD.DrawEmblemFocusable.__onClose = function(f5_arg0)
	f5_arg0.DrawEmblem:close()
end
