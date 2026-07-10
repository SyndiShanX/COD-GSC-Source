require("x64:e48baaf224320fd")
CoD.Obituary = InheritFrom(LUI.UIElement)
CoD.Obituary.__defaultWidth = 500
CoD.Obituary.__defaultHeight = 210
CoD.Obituary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Obituary)
	self.id = "Obituary"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	background:setAlpha(0)
	self:addElement(background)
	self.background = background
	local ObituaryEntry0 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry0:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line0", function(model)
		ObituaryEntry0:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry0)
	self.ObituaryEntry0 = ObituaryEntry0
	local ObituaryEntry1 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry1:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line1", function(model)
		ObituaryEntry1:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry1)
	self.ObituaryEntry1 = ObituaryEntry1
	local ObituaryEntry2 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry2:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line2", function(model)
		ObituaryEntry2:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry2)
	self.ObituaryEntry2 = ObituaryEntry2
	local ObituaryEntry3 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry3:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line3", function(model)
		ObituaryEntry3:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry3)
	self.ObituaryEntry3 = ObituaryEntry3
	local ObituaryEntry4 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry4:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line4", function(model)
		ObituaryEntry4:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry4)
	self.ObituaryEntry4 = ObituaryEntry4
	local ObituaryEntry5 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry5:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line5", function(model)
		ObituaryEntry5:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry5)
	self.ObituaryEntry5 = ObituaryEntry5
	local ObituaryEntry6 = CoD.ObituaryEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 176, 210)
	ObituaryEntry6:subscribeToGlobalModel(f1_arg1, "HUDItems", "obituary.line6", function(model)
		ObituaryEntry6:setModel(model, f1_arg1)
	end)
	self:addElement(ObituaryEntry6)
	self.ObituaryEntry6 = ObituaryEntry6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	CoD.ConsoleUtility.InitObituary(self, f1_arg1, "obituary", 6)
	return self
end
CoD.Obituary.__onClose = function(f9_arg0)
	f9_arg0.ObituaryEntry0:close()
	f9_arg0.ObituaryEntry1:close()
	f9_arg0.ObituaryEntry2:close()
	f9_arg0.ObituaryEntry3:close()
	f9_arg0.ObituaryEntry4:close()
	f9_arg0.ObituaryEntry5:close()
	f9_arg0.ObituaryEntry6:close()
end
