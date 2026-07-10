require("x64:68116bb31f713ff")
require("x64:dd39f3a70898c77")
CoD.ScoreboardMapWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapWZ.__defaultWidth = 1920
CoD.ScoreboardMapWZ.__defaultHeight = 1080
CoD.ScoreboardMapWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapWZ)
	self.id = "ScoreboardMapWZ"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local MapFrame = CoD.ScoreboardMapWZInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -483.5, 483.5, 0.5, 0.5, -483, 483)
	self:addElement(MapFrame)
	self.MapFrame = MapFrame
	local MapKey = CoD.ScoreboardMapKeyWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, 689, 960, 1, 1, -254, 0)
	MapKey:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(MapKey)
	self.MapKey = MapKey
	MapFrame.id = "MapFrame"
	self.__defaultFocus = MapFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.MapFrame)
	return self
end
CoD.ScoreboardMapWZ.__onClose = function(f3_arg0)
	f3_arg0.MapFrame:close()
	f3_arg0.MapKey:close()
end
