require("x64:5de488f119cdd59")
CoD.CodCasterObjectiveStatusDomination = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusDomination.__defaultWidth = 412
CoD.CodCasterObjectiveStatusDomination.__defaultHeight = 64
CoD.CodCasterObjectiveStatusDomination.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusDomination)
	self.id = "CodCasterObjectiveStatusDomination"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterObjectiveStatusDominationSiteB = CoD.CodCasterObjectiveStatusDominationSite.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -29.5, 30.5)
	CodCasterObjectiveStatusDominationSiteB.siteLetter:setImage(RegisterImage(0xFEE9CEC7F9FF4BC))
	CodCasterObjectiveStatusDominationSiteB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterObjectiveStatusDominationSiteB.siteLetter:setRGB(f2_local0)
		end
	end)
	CodCasterObjectiveStatusDominationSiteB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CodCasterObjectiveStatusDominationSiteB.siteBackground2:setRGB(f3_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusDominationSiteB)
	self.CodCasterObjectiveStatusDominationSiteB = CodCasterObjectiveStatusDominationSiteB
	local CodCasterObjectiveStatusDominationSiteC = CoD.CodCasterObjectiveStatusDominationSite.new(f1_arg0, f1_arg1, 0.6, 0.6, -35, 25, 0.5, 0.5, -29.5, 30.5)
	CodCasterObjectiveStatusDominationSiteC.siteLetter:setImage(RegisterImage(0xEB356E758926279))
	CodCasterObjectiveStatusDominationSiteC:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveC.color", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CodCasterObjectiveStatusDominationSiteC.siteLetter:setRGB(f4_local0)
		end
	end)
	CodCasterObjectiveStatusDominationSiteC:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveC.color", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CodCasterObjectiveStatusDominationSiteC.siteBackground2:setRGB(f5_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusDominationSiteC)
	self.CodCasterObjectiveStatusDominationSiteC = CodCasterObjectiveStatusDominationSiteC
	local CodCasterObjectiveStatusDominationSiteA = CoD.CodCasterObjectiveStatusDominationSite.new(f1_arg0, f1_arg1, 0.4, 0.4, -25, 35, 0.5, 0.5, -29.5, 30.5)
	CodCasterObjectiveStatusDominationSiteA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CodCasterObjectiveStatusDominationSiteA.siteLetter:setRGB(f6_local0)
		end
	end)
	CodCasterObjectiveStatusDominationSiteA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CodCasterObjectiveStatusDominationSiteA.siteBackground2:setRGB(f7_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusDominationSiteA)
	self.CodCasterObjectiveStatusDominationSiteA = CodCasterObjectiveStatusDominationSiteA
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusDomination.__resetProperties = function(f8_arg0)
	f8_arg0.CodCasterObjectiveStatusDominationSiteA:completeAnimation()
	f8_arg0.CodCasterObjectiveStatusDominationSiteC:completeAnimation()
	f8_arg0.CodCasterObjectiveStatusDominationSiteB:completeAnimation()
	f8_arg0.CodCasterObjectiveStatusDominationSiteA:setLeftRight(0.4, 0.4, -25, 35)
	f8_arg0.CodCasterObjectiveStatusDominationSiteA:setAlpha(1)
	f8_arg0.CodCasterObjectiveStatusDominationSiteC:setLeftRight(0.6, 0.6, -35, 25)
	f8_arg0.CodCasterObjectiveStatusDominationSiteC:setAlpha(1)
	f8_arg0.CodCasterObjectiveStatusDominationSiteB:setAlpha(1)
end
CoD.CodCasterObjectiveStatusDomination.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.CodCasterObjectiveStatusDominationSiteC:completeAnimation()
			f9_arg0.CodCasterObjectiveStatusDominationSiteC:setLeftRight(0.6, 0.6, -38, 22)
			f9_arg0.clipFinished(f9_arg0.CodCasterObjectiveStatusDominationSiteC)
			f9_arg0.CodCasterObjectiveStatusDominationSiteA:completeAnimation()
			f9_arg0.CodCasterObjectiveStatusDominationSiteA:setLeftRight(0.4, 0.4, -22, 38)
			f9_arg0.clipFinished(f9_arg0.CodCasterObjectiveStatusDominationSiteA)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.CodCasterObjectiveStatusDominationSiteB:completeAnimation()
			f10_arg0.CodCasterObjectiveStatusDominationSiteB:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterObjectiveStatusDominationSiteB)
			f10_arg0.CodCasterObjectiveStatusDominationSiteC:completeAnimation()
			f10_arg0.CodCasterObjectiveStatusDominationSiteC:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterObjectiveStatusDominationSiteC)
			f10_arg0.CodCasterObjectiveStatusDominationSiteA:completeAnimation()
			f10_arg0.CodCasterObjectiveStatusDominationSiteA:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterObjectiveStatusDominationSiteA)
		end,
	},
}
CoD.CodCasterObjectiveStatusDomination.__onClose = function(f11_arg0)
	f11_arg0.CodCasterObjectiveStatusDominationSiteB:close()
	f11_arg0.CodCasterObjectiveStatusDominationSiteC:close()
	f11_arg0.CodCasterObjectiveStatusDominationSiteA:close()
end
