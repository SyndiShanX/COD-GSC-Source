require("x64:259226575a01bf0")
CoD.CompassMinimapMap = InheritFrom(LUI.UIElement)
CoD.CompassMinimapMap.__defaultWidth = 192
CoD.CompassMinimapMap.__defaultHeight = 192
CoD.CompassMinimapMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassMinimapMap)
	self.id = "CompassMinimapMap"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CompassMinimapMap = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"compass_type_partial"])
	self:addElement(CompassMinimapMap)
	self.CompassMinimapMap = CompassMinimapMap
	local MinimapFogOfWar = CoD.MinimapFogOfWar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(MinimapFogOfWar)
	self.MinimapFogOfWar = MinimapFogOfWar
	self:mergeStateConditions({
		{
			stateName = "FogOfWar",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsFogOfWarEnabled(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassMinimapMap.__resetProperties = function(f3_arg0)
	f3_arg0.MinimapFogOfWar:completeAnimation()
	f3_arg0.CompassMinimapMap:completeAnimation()
	f3_arg0.MinimapFogOfWar:setAlpha(1)
	f3_arg0.CompassMinimapMap:setAlpha(1)
end
CoD.CompassMinimapMap.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.MinimapFogOfWar:completeAnimation()
			f4_arg0.MinimapFogOfWar:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.MinimapFogOfWar)
		end,
	},
	FogOfWar = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CompassMinimapMap:completeAnimation()
			f5_arg0.CompassMinimapMap:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CompassMinimapMap)
		end,
	},
}
CoD.CompassMinimapMap.__onClose = function(f6_arg0)
	f6_arg0.MinimapFogOfWar:close()
end
