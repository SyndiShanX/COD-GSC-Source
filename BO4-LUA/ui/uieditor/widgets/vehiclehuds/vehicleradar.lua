require("x64:77e6c8e4d1f495")
CoD.vehicleRadar = InheritFrom(LUI.UIElement)
CoD.vehicleRadar.__defaultWidth = 280
CoD.vehicleRadar.__defaultHeight = 280
CoD.vehicleRadar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vehicleRadar)
	self.id = "vehicleRadar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vehicleRadarRTT = CoD.vehicleRadarRTT.new(f1_arg0, f1_arg1, 0, 0, 0, 280, 0, 0, 0, 280)
	vehicleRadarRTT:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2D79DB5C45AD6024"))
	vehicleRadarRTT:setShaderVector(0, 50, 0, 0, 0)
	vehicleRadarRTT:setShaderVector(1, 100, 100, 0, 0)
	vehicleRadarRTT:setShaderVector(2, 0, 0.2, 0, 0)
	vehicleRadarRTT.CompassMinimap.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"hash_6E08A971DC12C4CC"])
	vehicleRadarRTT.CompassMinimap.MinimapFogOfWar.CompassMinimapMap:setupCompassMap(Enum[@"compasstype"][@"hash_6E08A971DC12C4CC"])
	vehicleRadarRTT.CompassItems.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"hash_6E08A971DC12C4CC"])
	vehicleRadarRTT.CompassItems0.CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"hash_6E08A971DC12C4CC"])
	self:addElement(vehicleRadarRTT)
	self.vehicleRadarRTT = vehicleRadarRTT
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vehicleRadar.__resetProperties = function(f2_arg0)
	f2_arg0.vehicleRadarRTT:completeAnimation()
	f2_arg0.vehicleRadarRTT:setAlpha(1)
end
CoD.vehicleRadar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.vehicleRadarRTT:completeAnimation()
			f4_arg0.vehicleRadarRTT:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.vehicleRadarRTT)
		end,
	},
}
CoD.vehicleRadar.__onClose = function(f5_arg0)
	f5_arg0.vehicleRadarRTT:close()
end
