require("ui/uieditor/widgets/systemoverlays/systemoverlay_fademask")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_supportwidget")
require("ui/uieditor/widgets/systemoverlays/systemoverlayspinner")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_layout_genericforeground_pc")
CoD.systemOverlay_Compact_BasicFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Compact_BasicFrame.__defaultWidth = 1920
CoD.systemOverlay_Compact_BasicFrame.__defaultHeight = 286
CoD.systemOverlay_Compact_BasicFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Compact_BasicFrame)
	self.id = "systemOverlay_Compact_BasicFrame"
	self.soundSet = "overlay"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 549, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	local SystemOverlaySpinner = CoD.SystemOverlaySpinner.new(f1_arg0, f1_arg1, 0, 0, 639, 1088, 0, 0, 102.5, 123.5)
	SystemOverlaySpinner:setAlpha(0)
	self:addElement(SystemOverlaySpinner)
	self.SystemOverlaySpinner = SystemOverlaySpinner
	local systemOverlayFadeMask = CoD.systemOverlay_FadeMask.new(f1_arg0, f1_arg1, 0, 0, 254, 750, 0, 0, 0, 286)
	systemOverlayFadeMask:setAlpha(0)
	self:addElement(systemOverlayFadeMask)
	self.systemOverlayFadeMask = systemOverlayFadeMask
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.foreground = f1_local4
	local foregroundPC = nil
	foregroundPC = CoD.systemOverlay_Layout_GenericForeground_PC.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 286)
	foregroundPC:setAlpha(0)
	foregroundPC.options:setHorizontalCount(4)
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
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		PlaySoundAlias("uin_warning_generic")
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	f1_local4.id = "foreground"
	if CoD.isPC then
		foregroundPC.id = "foregroundPC"
	end
	self.__defaultFocus = f1_local4
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	if IsPC() then
		SetProperty(self, "__defaultFocus", foregroundPC)
	end
	return self
end
CoD.systemOverlay_Compact_BasicFrame.__resetProperties = function(f7_arg0)
	f7_arg0.foregroundPC:completeAnimation()
	f7_arg0.foreground:completeAnimation()
	f7_arg0.foregroundPC:setLeftRight(0, 0, 0, 1920)
	f7_arg0.foregroundPC:setTopBottom(0, 0, 0, 286)
	f7_arg0.foregroundPC:setAlpha(0)
	f7_arg0.foreground:setAlpha(1)
end
CoD.systemOverlay_Compact_BasicFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.foreground:completeAnimation()
			f9_arg0.foreground:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.foreground)
			f9_arg0.foregroundPC:completeAnimation()
			f9_arg0.foregroundPC:setLeftRight(0, 0, 0, 1920)
			f9_arg0.foregroundPC:setTopBottom(0, 0, 0, 294)
			f9_arg0.foregroundPC:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.foregroundPC)
		end,
	},
}
CoD.systemOverlay_Compact_BasicFrame.__onClose = function(f10_arg0)
	f10_arg0.__on_close_removeOverrides()
	f10_arg0.supportInfo:close()
	f10_arg0.SystemOverlaySpinner:close()
	f10_arg0.systemOverlayFadeMask:close()
	f10_arg0.foreground:close()
	f10_arg0.foregroundPC:close()
end
