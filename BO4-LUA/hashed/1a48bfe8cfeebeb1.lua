CoD.AbilityCallout_Queue = InheritFrom(LUI.UIElement)
CoD.AbilityCallout_Queue.__defaultWidth = 300
CoD.AbilityCallout_Queue.__defaultHeight = 75
CoD.AbilityCallout_Queue.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AbilityCallout_Queue)
	self.id = "AbilityCallout_Queue"
	self.soundSet = "none"
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f2_local0 = self
		CoD.HUDUtility.AddToAbilityCalloutQueue(self, f1_arg1, model)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local1 = self
	CoD.HUDUtility.SetupAbilityCalloutQueue(self, f1_arg1, f1_arg0)
	return self
end
