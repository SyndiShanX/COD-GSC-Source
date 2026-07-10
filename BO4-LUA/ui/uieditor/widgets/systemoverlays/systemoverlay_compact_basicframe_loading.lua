require("x64:ff767c56294d96c")
require("x64:a9d9ad002907d62")
require("x64:e1b76d902bbc762")
CoD.systemOverlay_Compact_BasicFrame_Loading = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Compact_BasicFrame_Loading.__defaultWidth = 1920
CoD.systemOverlay_Compact_BasicFrame_Loading.__defaultHeight = 286
CoD.systemOverlay_Compact_BasicFrame_Loading.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Compact_BasicFrame_Loading)
	self.id = "systemOverlay_Compact_BasicFrame_Loading"
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
	local f1_local2 = nil
	f1_local2 = LUI.UIElement.createFake()
	self.foreground = f1_local2
	local foregroundPC = nil
	foregroundPC = CoD.systemOverlay_Layout_GenericForeground_PC.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 286)
	foregroundPC:setAlpha(0)
	foregroundPC:linkToElementModel(self, nil, false, function(model)
		foregroundPC:setModel(model, f1_arg1)
	end)
	self:addElement(foregroundPC)
	self.foregroundPC = foregroundPC
	local largeImage = CoD.systemOverlay_connectinganim.new(f1_arg0, f1_arg1, 0, 0, 0, 549, 0, 0, 0, 286)
	largeImage:linkToElementModel(self, nil, false, function(model)
		largeImage:setModel(model, f1_arg1)
	end)
	self:addElement(largeImage)
	self.largeImage = largeImage
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local2.id = "foreground"
	if CoD.isPC then
		foregroundPC.id = "foregroundPC"
	end
	self.__defaultFocus = f1_local2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	if IsPC() then
		SetProperty(self, "__defaultFocus", foregroundPC)
	end
	return self
end
CoD.systemOverlay_Compact_BasicFrame_Loading.__resetProperties = function(f6_arg0)
	f6_arg0.foregroundPC:completeAnimation()
	f6_arg0.foreground:completeAnimation()
	f6_arg0.foregroundPC:setLeftRight(0, 0, 0, 1920)
	f6_arg0.foregroundPC:setTopBottom(0, 0, 0, 286)
	f6_arg0.foregroundPC:setAlpha(0)
	f6_arg0.foreground:setAlpha(1)
end
CoD.systemOverlay_Compact_BasicFrame_Loading.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.foreground:completeAnimation()
			f8_arg0.foreground:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.foreground)
			f8_arg0.foregroundPC:completeAnimation()
			f8_arg0.foregroundPC:setLeftRight(0, 0, 0, 1920)
			f8_arg0.foregroundPC:setTopBottom(0, 0, 0, 294)
			f8_arg0.foregroundPC:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.foregroundPC)
		end,
	},
}
CoD.systemOverlay_Compact_BasicFrame_Loading.__onClose = function(f9_arg0)
	f9_arg0.supportInfo:close()
	f9_arg0.foreground:close()
	f9_arg0.foregroundPC:close()
	f9_arg0.largeImage:close()
end
