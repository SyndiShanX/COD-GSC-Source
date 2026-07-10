require("x64:898fb1426ae8fec")
require("x64:6ee653ade3452f5")
CoD.VHUD_Hellstorm = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Hellstorm = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Hellstorm", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Hellstorm)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local ScorestreakAspectRatioFixPC = nil
	ScorestreakAspectRatioFixPC = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	ScorestreakAspectRatioFixPC:setAlpha(0.9)
	self:addElement(ScorestreakAspectRatioFixPC)
	self.ScorestreakAspectRatioFixPC = ScorestreakAspectRatioFixPC
	local vhudhellstorminternal0 = CoD.vhud_hellstorm_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudhellstorminternal0:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		vhudhellstorminternal0:setModel(model, f1_arg0)
	end)
	self:addElement(vhudhellstorminternal0)
	self.vhudhellstorminternal0 = vhudhellstorminternal0
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.VHUD_Hellstorm.__onClose = function(f3_arg0)
	f3_arg0.ScorestreakAspectRatioFixPC:close()
	f3_arg0.vhudhellstorminternal0:close()
end
