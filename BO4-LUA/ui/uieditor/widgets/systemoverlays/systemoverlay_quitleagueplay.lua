require("x64:a9d9ad002907d62")
require("x64:e1b76d902bbc762")
CoD.systemOverlay_QuitLeaguePlay = InheritFrom(LUI.UIElement)
CoD.systemOverlay_QuitLeaguePlay.__defaultWidth = 1920
CoD.systemOverlay_QuitLeaguePlay.__defaultHeight = 286
CoD.systemOverlay_QuitLeaguePlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_QuitLeaguePlay)
	self.id = "systemOverlay_QuitLeaguePlay"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 549, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	local foregroundPC = nil
	foregroundPC = CoD.systemOverlay_Layout_GenericForeground_PC.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 294)
	foregroundPC:linkToElementModel(self, nil, false, function(model)
		foregroundPC:setModel(model, f1_arg1)
	end)
	self:addElement(foregroundPC)
	self.foregroundPC = foregroundPC
	local f1_local3 = nil
	self.foreground = LUI.UIElement.createFake()
	local PenaltyAmount = LUI.UIText.new(0, 0, 149.5, 399.5, 0, 0, 53, 233)
	PenaltyAmount:setRGB(1, 0, 0)
	PenaltyAmount:setText(CoD.StartMenuUtility.GetArenaQuitPenaltyText(f1_arg1, ""))
	PenaltyAmount:setTTF("ttmussels_regular")
	PenaltyAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PenaltyAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PenaltyAmount)
	self.PenaltyAmount = PenaltyAmount
	local PenaltyText = LUI.UIText.new(0, 0, 174.5, 374.5, 0, 0, 216.5, 249.5)
	PenaltyText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_589D3338A869821C"))
	PenaltyText:setTTF("ttmussels_regular")
	PenaltyText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PenaltyText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PenaltyText)
	self.PenaltyText = PenaltyText
	if CoD.isPC then
		foregroundPC.id = "foregroundPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_QuitLeaguePlay.__onClose = function(f4_arg0)
	f4_arg0.supportInfo:close()
	f4_arg0.foregroundPC:close()
	f4_arg0.foreground:close()
end
