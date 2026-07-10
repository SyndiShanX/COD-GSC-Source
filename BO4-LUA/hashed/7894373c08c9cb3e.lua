require("x64:14861357805ac7b")
CoD.ReservesMeter = InheritFrom(LUI.UIElement)
CoD.ReservesMeter.__defaultWidth = 684
CoD.ReservesMeter.__defaultHeight = 67
CoD.ReservesMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesMeter)
	self.id = "ReservesMeter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReservesPromo = CoD.ReservesMeterInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 684, 0, 0, 0, 67)
	ReservesPromo:setAlpha(0)
	ReservesPromo:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", nil, function(model)
		ReservesPromo:setModel(model, f1_arg1)
	end)
	self:addElement(ReservesPromo)
	self.ReservesPromo = ReservesPromo
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.ShowReservesMeter(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesMeter.__resetProperties = function(f4_arg0)
	f4_arg0.ReservesPromo:completeAnimation()
	f4_arg0.ReservesPromo:setAlpha(0)
end
CoD.ReservesMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Active = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ReservesPromo:completeAnimation()
			f6_arg0.ReservesPromo:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.ReservesPromo)
		end,
	},
}
CoD.ReservesMeter.__onClose = function(f7_arg0)
	f7_arg0.ReservesPromo:close()
end
