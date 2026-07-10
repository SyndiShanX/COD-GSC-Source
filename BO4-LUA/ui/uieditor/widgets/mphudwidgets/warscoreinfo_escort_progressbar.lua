local PostLoadFunc = function(self, controller)
	self.ProgressMarker:subscribeToGlobalModel(controller, "WarData", "currentZoneProgress", function(model)
		local f2_local0, f2_local1, f2_local2, f2_local3 = self.ProgressMarker:getLocalRect()
		local f2_local4 = Engine[@"getmodelvalue"](model)
		if f2_local4 and f2_local0 and f2_local2 then
			local f2_local5 = f2_local4 * 0.85
			self.ProgressMarker:setLeftRight(f2_local5, f2_local5, f2_local0, f2_local2)
		end
	end)
end
CoD.WarScoreInfo_Escort_ProgressBar = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_Escort_ProgressBar.__defaultWidth = 400
CoD.WarScoreInfo_Escort_ProgressBar.__defaultHeight = 15
CoD.WarScoreInfo_Escort_ProgressBar.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.WarScoreInfo_Escort_ProgressBar)
	self.id = "WarScoreInfo_Escort_ProgressBar"
	self.soundSet = "default"
	local ProgressBarBacking = LUI.UIImage.new(0, 0, 0, 340, 0, 0, 4, 12)
	ProgressBarBacking:setRGB(0, 0, 0)
	ProgressBarBacking:setAlpha(0.5)
	ProgressBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	ProgressBarBacking:setShaderVector(0, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ProgressBar = LUI.UIImage.new(0, 0, 0, 340, 0, 0, 6, 10)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:subscribeToGlobalModel(f3_arg1, "WarData", "currentZoneProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local ProgressMarker = LUI.UIImage.new(0, 0, -2, 0, 0, 0, 6, 18)
	self:addElement(ProgressMarker)
	self.ProgressMarker = ProgressMarker
	local DistanceLabel = LUI.UIText.new(0, 0, 344, 400, 0, 0, -4, 20)
	DistanceLabel:setTTF("ttmussels_demibold")
	DistanceLabel:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	DistanceLabel:setShaderVector(0, 0, 0, 0, 0)
	DistanceLabel:setShaderVector(1, 0, 0, 0, 1)
	DistanceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DistanceLabel:subscribeToGlobalModel(f3_arg1, "WarData", "robotCurrentDistance", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DistanceLabel:setText(LocalizeIntoString(@"hash_1A9AE1E6BC1CFEDC", UnitsToMeters(f5_local0)))
		end
	end)
	self:addElement(DistanceLabel)
	self.DistanceLabel = DistanceLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.WarScoreInfo_Escort_ProgressBar.__onClose = function(f6_arg0)
	f6_arg0.ProgressBar:close()
	f6_arg0.DistanceLabel:close()
end
