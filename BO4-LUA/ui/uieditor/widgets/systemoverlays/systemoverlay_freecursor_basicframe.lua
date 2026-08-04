require("ui/uieditor/widgets/systemoverlays/systemoverlay_freecursor_genericforeground")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_supportwidget")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_layout_genericforeground_pc")
CoD.systemOverlay_FreeCursor_BasicFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_FreeCursor_BasicFrame.__defaultWidth = 1920
CoD.systemOverlay_FreeCursor_BasicFrame.__defaultHeight = 286
CoD.systemOverlay_FreeCursor_BasicFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_FreeCursor_BasicFrame)
	self.id = "systemOverlay_FreeCursor_BasicFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 549, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	local foreground = CoD.systemOverlay_FreeCursor_GenericForeground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	foreground:linkToElementModel(self, nil, false, function(model)
		foreground:setModel(model, f1_arg1)
	end)
	self:addElement(foreground)
	self.foreground = foreground
	local foregroundPC = nil
	foregroundPC = CoD.systemOverlay_Layout_GenericForeground_PC.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 294)
	foregroundPC:setAlpha(0)
	foregroundPC:linkToElementModel(self, nil, false, function(model)
		foregroundPC:setModel(model, f1_arg1)
	end)
	self:addElement(foregroundPC)
	self.foregroundPC = foregroundPC
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if CoD.isPC then
		foregroundPC.id = "foregroundPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_FreeCursor_BasicFrame.__resetProperties = function(f6_arg0)
	f6_arg0.foregroundPC:completeAnimation()
	f6_arg0.foreground:completeAnimation()
	f6_arg0.supportInfo:completeAnimation()
	f6_arg0.foregroundPC:setAlpha(0)
	f6_arg0.foreground:setAlpha(1)
	f6_arg0.supportInfo:setAlpha(1)
end
CoD.systemOverlay_FreeCursor_BasicFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.supportInfo:completeAnimation()
			f8_arg0.supportInfo:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.supportInfo)
			f8_arg0.foreground:completeAnimation()
			f8_arg0.foreground:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.foreground)
			f8_arg0.foregroundPC:completeAnimation()
			f8_arg0.foregroundPC:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.foregroundPC)
		end,
	},
}
CoD.systemOverlay_FreeCursor_BasicFrame.__onClose = function(f9_arg0)
	f9_arg0.supportInfo:close()
	f9_arg0.foreground:close()
	f9_arg0.foregroundPC:close()
end
