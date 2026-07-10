require("x64:2b390c8152e424d")
require("x64:12bbcf811bbabdb")
require("x64:468ab2ec3656329")
CoD.vehicleRadarRTT = InheritFrom(LUI.UIElement)
CoD.vehicleRadarRTT.__defaultWidth = 280
CoD.vehicleRadarRTT.__defaultHeight = 280
CoD.vehicleRadarRTT.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vehicleRadarRTT)
	self.id = "vehicleRadarRTT"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundNoFog = LUI.UIImage.new(1, 2, -280, -280, 0, 1, 0, 0)
	BackgroundNoFog:setRGB(0, 0, 0)
	BackgroundNoFog:setAlpha(0.8)
	self:addElement(BackgroundNoFog)
	self.BackgroundNoFog = BackgroundNoFog
	local CompassMinimap = CoD.CompassMinimapMap.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassMinimap:setRGB(0.51, 0.51, 0.51)
	CompassMinimap:setAlpha(0.8)
	self:addElement(CompassMinimap)
	self.CompassMinimap = CompassMinimap
	local OuterRing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	OuterRing:setRGB(0, 0, 0)
	OuterRing:setAlpha(0.75)
	OuterRing:setImage(RegisterImage(0x99AE5E7738A5587))
	self:addElement(OuterRing)
	self.OuterRing = OuterRing
	local InnerRing = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 5, -5)
	InnerRing:setRGB(0, 0, 0)
	InnerRing:setAlpha(0.94)
	InnerRing:setImage(RegisterImage(0x4C5101F002300A2))
	self:addElement(InnerRing)
	self.InnerRing = InnerRing
	local InnerDetail = LUI.UIImage.new(0, 1, 7, -7, 0, 1, 7, -7)
	InnerDetail:setImage(RegisterImage(0x65814E308814E29))
	self:addElement(InnerDetail)
	self.InnerDetail = InnerDetail
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassItems:setAlpha(0.75)
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0:setAlpha(0.6)
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vehicleRadarRTT.__resetProperties = function(f2_arg0)
	f2_arg0.CompassMinimap:completeAnimation()
	f2_arg0.CompassMinimap:setAlpha(0.8)
end
CoD.vehicleRadarRTT.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Campaign = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.CompassMinimap:completeAnimation()
			f4_arg0.CompassMinimap:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.CompassMinimap)
		end,
	},
}
CoD.vehicleRadarRTT.__onClose = function(f5_arg0)
	f5_arg0.CompassMinimap:close()
	f5_arg0.CompassOverlay:close()
	f5_arg0.CompassItems:close()
	f5_arg0.CompassItems0:close()
end
