require("x64:a969aa55b2ced8")
CoD.PaintCanIdentityWidget = InheritFrom(LUI.UIElement)
CoD.PaintCanIdentityWidget.__defaultWidth = 530
CoD.PaintCanIdentityWidget.__defaultHeight = 40
CoD.PaintCanIdentityWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintCanIdentityWidget)
	self.id = "PaintCanIdentityWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local membername = CoD.CommonIdentityMemberNameStreamlined.new(f1_arg0, f1_arg1, 0, 0, 310, 530, 0, 0, 9.5, 30.5)
	membername:linkToElementModel(self, nil, false, function(model)
		membername:setModel(model, f1_arg1)
	end)
	self:addElement(membername)
	self.membername = membername
	local StatValue = LUI.UIText.new(0, 0, 238, 305, 0, 0, 10, 32)
	StatValue:setTTF("ttmussels_demibold")
	StatValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StatValue:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	StatValue:subscribeToGlobalModel(f1_arg1, "PerController", "paintCanCount", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StatValue:setText(f3_local0)
		end
	end)
	self:addElement(StatValue)
	self.StatValue = StatValue
	local PaintCanImage = LUI.UIImage.new(0, 0, 194, 246, 0, 0, -6, 46)
	PaintCanImage:setImage(RegisterImage(0xB808223FCD4471D))
	self:addElement(PaintCanImage)
	self.PaintCanImage = PaintCanImage
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		if IsPC() and IsInGame() then
			HideWidget(self.membername)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintCanIdentityWidget.__onClose = function(f5_arg0)
	f5_arg0.membername:close()
	f5_arg0.StatValue:close()
end
