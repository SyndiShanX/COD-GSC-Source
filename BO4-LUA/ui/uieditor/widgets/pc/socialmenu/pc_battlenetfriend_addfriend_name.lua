CoD.PC_BattlenetFriend_AddFriend_Name = InheritFrom(LUI.UIElement)
CoD.PC_BattlenetFriend_AddFriend_Name.__defaultWidth = 392
CoD.PC_BattlenetFriend_AddFriend_Name.__defaultHeight = 22
CoD.PC_BattlenetFriend_AddFriend_Name.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BattlenetFriend_AddFriend_Name)
	self.id = "PC_BattlenetFriend_AddFriend_Name"
	self.soundSet = "default"
	local FriendName = LUI.UIText.new(0.99, 0.99, -388, 4, 0.94, 0.94, -20.5, 1.5)
	FriendName:setText("")
	FriendName:setTTF("notosans_bold")
	FriendName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(FriendName)
	self.FriendName = FriendName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	f1_local2 = FriendName
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.PC_BattlenetFriend_AddFriend_Name.__onClose = function(f2_arg0)
	f2_arg0.FriendName:close()
end
