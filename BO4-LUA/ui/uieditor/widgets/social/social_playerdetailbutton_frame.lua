CoD.Social_playerDetailButton_frame = InheritFrom(LUI.UIElement)
CoD.Social_playerDetailButton_frame.__defaultWidth = 566
CoD.Social_playerDetailButton_frame.__defaultHeight = 12
CoD.Social_playerDetailButton_frame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_playerDetailButton_frame)
	self.id = "Social_playerDetailButton_frame"
	self.soundSet = "default"
	local ButtonFrameTop = LUI.UIImage.new(0, 0, 85, 481, 0, 0, 0, 12)
	ButtonFrameTop:setImage(RegisterImage("uie_ui_menu_social_popup_list_frame_top"))
	ButtonFrameTop:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(ButtonFrameTop)
	self.ButtonFrameTop = ButtonFrameTop
	local ButtonFrameTopRight = LUI.UIImage.new(0, 0, 497.5, 565.5, 0, 0, 0, 12)
	ButtonFrameTopRight:setAlpha(0.01)
	ButtonFrameTopRight:setImage(RegisterImage("uie_ui_menu_social_popup_list_frame_box"))
	self:addElement(ButtonFrameTopRight)
	self.ButtonFrameTopRight = ButtonFrameTopRight
	local ButtonFrameTopLeft = LUI.UIImage.new(0, 0, 0, 68, 0, 0, 0, 12)
	ButtonFrameTopLeft:setAlpha(0.01)
	ButtonFrameTopLeft:setZRot(180)
	ButtonFrameTopLeft:setImage(RegisterImage("uie_ui_menu_social_popup_list_frame_box"))
	self:addElement(ButtonFrameTopLeft)
	self.ButtonFrameTopLeft = ButtonFrameTopLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
