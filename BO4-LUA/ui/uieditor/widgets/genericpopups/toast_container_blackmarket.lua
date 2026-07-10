require("x64:5121f7cbfe5fa89")
require("x64:83fdf4983fb5894")
CoD.Toast_Container_BlackMarket = InheritFrom(LUI.UIElement)
CoD.Toast_Container_BlackMarket.__defaultWidth = 340
CoD.Toast_Container_BlackMarket.__defaultHeight = 80
CoD.Toast_Container_BlackMarket.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Toast_Container_BlackMarket)
	self.id = "Toast_Container_BlackMarket"
	self.soundSet = "ChooseDecal"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local ToastBacking = CoD.Loot_BonusToastGenericBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ToastBacking)
	self.ToastBacking = ToastBacking
	local FooterText = LUI.UIText.new(0.5, 1.5, -170, -170, 0, 0.26, 50, 50)
	FooterText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	FooterText:setTTF("ttmussels_regular")
	FooterText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FooterText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	FooterText:linkToElementModel(self, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FooterText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(FooterText)
	self.FooterText = FooterText
	local ContentIconInternal = CoD.kickerinternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -170, 170, 0, 0, 10, 50)
	ContentIconInternal:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ContentIconInternal:linkToElementModel(self, "kicker", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContentIconInternal.NotifTextMain:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(ContentIconInternal)
	self.ContentIconInternal = ContentIconInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Toast_Container_BlackMarket.__onClose = function(f4_arg0)
	f4_arg0.ToastBacking:close()
	f4_arg0.FooterText:close()
	f4_arg0.ContentIconInternal:close()
end
