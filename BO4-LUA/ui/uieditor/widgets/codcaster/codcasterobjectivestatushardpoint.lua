CoD.CodCasterObjectiveStatusHardpoint = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusHardpoint.__defaultWidth = 412
CoD.CodCasterObjectiveStatusHardpoint.__defaultHeight = 64
CoD.CodCasterObjectiveStatusHardpoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusHardpoint)
	self.id = "CodCasterObjectiveStatusHardpoint"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 0, 168.5, 198.5, 0, 0, 13, 43)
	BG:setImage(RegisterImage(0x159D9B7B7294C91))
	BG:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.hardpointVisibility", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BG:setAlpha(f2_local0)
		end
	end)
	self:addElement(BG)
	self.BG = BG
	local HardpointTimer = LUI.UIText.new(0.49, 0.49, 0, 200, 0.45, 0.45, -7.5, 7.5)
	HardpointTimer:setTTF("ttmussels_demibold")
	HardpointTimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HardpointTimer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	HardpointTimer:setupBombTimer(0, true)
	self:addElement(HardpointTimer)
	self.HardpointTimer = HardpointTimer
	local objectiveCircleR = LUI.UIImage.new(0.41, 0.41, 0, 30, 0.2, 0.2, 0, 30)
	objectiveCircleR:setYRot(180)
	objectiveCircleR:setScale(0.9, 0.9)
	objectiveCircleR:setImage(RegisterImage(0x99464D465C38DB0))
	objectiveCircleR:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			objectiveCircleR:setRGB(f3_local0)
		end
	end)
	objectiveCircleR:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.hardpointVisibility", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			objectiveCircleR:setAlpha(f4_local0)
		end
	end)
	self:addElement(objectiveCircleR)
	self.objectiveCircleR = objectiveCircleR
	local objectiveCircleL = LUI.UIImage.new(0.41, 0.41, 0, 30, 0.2, 0.2, 0, 30)
	objectiveCircleL:setScale(0.9, 0.9)
	objectiveCircleL:setImage(RegisterImage(0x99464D465C38DB0))
	objectiveCircleL:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			objectiveCircleL:setRGB(f5_local0)
		end
	end)
	objectiveCircleL:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.hardpointVisibility", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			objectiveCircleL:setAlpha(f6_local0)
		end
	end)
	self:addElement(objectiveCircleL)
	self.objectiveCircleL = objectiveCircleL
	local objectiveIconL = LUI.UIImage.new(0.41, 0.41, 0, 30, 0.2, 0.2, 0, 30)
	objectiveIconL:setScale(0.9, 0.9)
	objectiveIconL:setImage(RegisterImage(0x8A17F638A929803))
	objectiveIconL:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			objectiveIconL:setRGB(f7_local0)
		end
	end)
	objectiveIconL:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.hardpointVisibility", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			objectiveIconL:setAlpha(f8_local0)
		end
	end)
	self:addElement(objectiveIconL)
	self.objectiveIconL = objectiveIconL
	local objectiveIconR = LUI.UIImage.new(0.41, 0.41, 0, 30, 0.2, 0.2, 0, 30)
	objectiveIconR:setYRot(180)
	objectiveIconR:setScale(0.9, 0.9)
	objectiveIconR:setImage(RegisterImage(0x8A17F638A929803))
	objectiveIconR:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			objectiveIconR:setRGB(f9_local0)
		end
	end)
	objectiveIconR:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.hardpointVisibility", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			objectiveIconR:setAlpha(f10_local0)
		end
	end)
	self:addElement(objectiveIconR)
	self.objectiveIconR = objectiveIconR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusHardpoint.__resetProperties = function(f11_arg0)
	f11_arg0.HardpointTimer:completeAnimation()
	f11_arg0.objectiveIconR:completeAnimation()
	f11_arg0.objectiveIconL:completeAnimation()
	f11_arg0.objectiveCircleL:completeAnimation()
	f11_arg0.objectiveCircleR:completeAnimation()
	f11_arg0.BG:completeAnimation()
	f11_arg0.HardpointTimer:setAlpha(1)
end
CoD.CodCasterObjectiveStatusHardpoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(6)
			f13_arg0.BG:completeAnimation()
			f13_arg0.clipFinished(f13_arg0.BG)
			f13_arg0.HardpointTimer:completeAnimation()
			f13_arg0.HardpointTimer:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.HardpointTimer)
			f13_arg0.objectiveCircleR:completeAnimation()
			f13_arg0.clipFinished(f13_arg0.objectiveCircleR)
			f13_arg0.objectiveCircleL:completeAnimation()
			f13_arg0.clipFinished(f13_arg0.objectiveCircleL)
			f13_arg0.objectiveIconL:completeAnimation()
			f13_arg0.clipFinished(f13_arg0.objectiveIconL)
			f13_arg0.objectiveIconR:completeAnimation()
			f13_arg0.clipFinished(f13_arg0.objectiveIconR)
		end,
	},
}
CoD.CodCasterObjectiveStatusHardpoint.__onClose = function(f14_arg0)
	f14_arg0.BG:close()
	f14_arg0.objectiveCircleR:close()
	f14_arg0.objectiveCircleL:close()
	f14_arg0.objectiveIconL:close()
	f14_arg0.objectiveIconR:close()
end
