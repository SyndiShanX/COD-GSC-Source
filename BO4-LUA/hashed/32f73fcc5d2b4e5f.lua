require("x64:42dba08e7541934")
CoD.BountyCashEventContainer = InheritFrom(LUI.UIElement)
CoD.BountyCashEventContainer.__defaultWidth = 150
CoD.BountyCashEventContainer.__defaultHeight = 38
CoD.BountyCashEventContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyCashEventContainer)
	self.id = "BountyCashEventContainer"
	self.soundSet = "default"
	local BountyCashEvent1 = CoD.BountyCashEvent.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0, 0, 0, 38)
	self:addElement(BountyCashEvent1)
	self.BountyCashEvent1 = BountyCashEvent1
	local BountyCashEvent2 = CoD.BountyCashEvent.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0, 0, 0, 38)
	self:addElement(BountyCashEvent2)
	self.BountyCashEvent2 = BountyCashEvent2
	local BountyCashEvent4 = CoD.BountyCashEvent.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0, 0, 0, 38)
	self:addElement(BountyCashEvent4)
	self.BountyCashEvent4 = BountyCashEvent4
	local BountyCashEvent3 = CoD.BountyCashEvent.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0, 0, 0, 38)
	self:addElement(BountyCashEvent3)
	self.BountyCashEvent3 = BountyCashEvent3
	local BountyCashEvent5 = CoD.BountyCashEvent.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0, 0, 0, 38)
	self:addElement(BountyCashEvent5)
	self.BountyCashEvent5 = BountyCashEvent5
	self:subscribeToGlobalModel(f1_arg1, "PerController", "luielement.BountyHunterLoadout.money", function(model)
		local f2_local0 = self
		if CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1) then
			CoD.BountyHunterUtility.GiveBountyHunterMoneyScore(self, f1_arg0, f1_arg1, model)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyCashEventContainer.__onClose = function(f3_arg0)
	f3_arg0.BountyCashEvent1:close()
	f3_arg0.BountyCashEvent2:close()
	f3_arg0.BountyCashEvent4:close()
	f3_arg0.BountyCashEvent3:close()
	f3_arg0.BountyCashEvent5:close()
end
