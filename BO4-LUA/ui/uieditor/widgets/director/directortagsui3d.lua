require("x64:55657a807fcb662")
CoD.DirectorTagsUI3D = InheritFrom(LUI.UIElement)
CoD.DirectorTagsUI3D.__defaultWidth = 500
CoD.DirectorTagsUI3D.__defaultHeight = 500
CoD.DirectorTagsUI3D.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTagsUI3D)
	self.id = "DirectorTagsUI3D"
	self.soundSet = "none"
	Engine[@"setupui3dwindow"](f1_arg1, 1, 500, 500)
	self:setUI3DWindow(1)
	self.anyChildUsesUpdateState = true
	local DirectorTagsUI3DPlayer1 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0, 0.25, 0, 0, 0, 0.25, 0, 0)
	DirectorTagsUI3DPlayer1:subscribeToGlobalModel(f1_arg1, "LobbyClients", "1", function(model)
		DirectorTagsUI3DPlayer1:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer1)
	self.DirectorTagsUI3DPlayer1 = DirectorTagsUI3DPlayer1
	local DirectorTagsUI3DPlayer16 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.75, 1, 0, 0, 0.75, 1, 0, 0)
	DirectorTagsUI3DPlayer16:subscribeToGlobalModel(f1_arg1, "LobbyClients", "16", function(model)
		DirectorTagsUI3DPlayer16:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer16)
	self.DirectorTagsUI3DPlayer16 = DirectorTagsUI3DPlayer16
	local DirectorTagsUI3DPlayer15 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.5, 0.75, 0, 0, 0.75, 1, 0, 0)
	DirectorTagsUI3DPlayer15:subscribeToGlobalModel(f1_arg1, "LobbyClients", "15", function(model)
		DirectorTagsUI3DPlayer15:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer15)
	self.DirectorTagsUI3DPlayer15 = DirectorTagsUI3DPlayer15
	local DirectorTagsUI3DPlayer14 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.25, 0.5, 0, 0, 0.75, 1, 0, 0)
	DirectorTagsUI3DPlayer14:subscribeToGlobalModel(f1_arg1, "LobbyClients", "14", function(model)
		DirectorTagsUI3DPlayer14:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer14)
	self.DirectorTagsUI3DPlayer14 = DirectorTagsUI3DPlayer14
	local DirectorTagsUI3DPlayer13 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0, 0.25, 0, 0, 0.75, 1, 0, 0)
	DirectorTagsUI3DPlayer13:subscribeToGlobalModel(f1_arg1, "LobbyClients", "13", function(model)
		DirectorTagsUI3DPlayer13:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer13)
	self.DirectorTagsUI3DPlayer13 = DirectorTagsUI3DPlayer13
	local DirectorTagsUI3DPlayer12 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.75, 1, 0, 0, 0.5, 0.75, 0, 0)
	DirectorTagsUI3DPlayer12:subscribeToGlobalModel(f1_arg1, "LobbyClients", "12", function(model)
		DirectorTagsUI3DPlayer12:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer12)
	self.DirectorTagsUI3DPlayer12 = DirectorTagsUI3DPlayer12
	local DirectorTagsUI3DPlayer11 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.5, 0.75, 0, 0, 0.5, 0.75, 0, 0)
	DirectorTagsUI3DPlayer11:subscribeToGlobalModel(f1_arg1, "LobbyClients", "11", function(model)
		DirectorTagsUI3DPlayer11:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer11)
	self.DirectorTagsUI3DPlayer11 = DirectorTagsUI3DPlayer11
	local DirectorTagsUI3DPlayer10 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.25, 0.5, 0, 0, 0.5, 0.75, 0, 0)
	DirectorTagsUI3DPlayer10:subscribeToGlobalModel(f1_arg1, "LobbyClients", "10", function(model)
		DirectorTagsUI3DPlayer10:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer10)
	self.DirectorTagsUI3DPlayer10 = DirectorTagsUI3DPlayer10
	local DirectorTagsUI3DPlayer9 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0, 0.25, 0, 0, 0.5, 0.75, 0, 0)
	DirectorTagsUI3DPlayer9:subscribeToGlobalModel(f1_arg1, "LobbyClients", "9", function(model)
		DirectorTagsUI3DPlayer9:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer9)
	self.DirectorTagsUI3DPlayer9 = DirectorTagsUI3DPlayer9
	local DirectorTagsUI3DPlayer8 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.75, 1, 0, 0, 0.25, 0.5, 0, 0)
	DirectorTagsUI3DPlayer8:subscribeToGlobalModel(f1_arg1, "LobbyClients", "8", function(model)
		DirectorTagsUI3DPlayer8:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer8)
	self.DirectorTagsUI3DPlayer8 = DirectorTagsUI3DPlayer8
	local DirectorTagsUI3DPlayer7 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.5, 0.75, 0, 0, 0.25, 0.5, 0, 0)
	DirectorTagsUI3DPlayer7:subscribeToGlobalModel(f1_arg1, "LobbyClients", "7", function(model)
		DirectorTagsUI3DPlayer7:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer7)
	self.DirectorTagsUI3DPlayer7 = DirectorTagsUI3DPlayer7
	local DirectorTagsUI3DPlayer6 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.25, 0.5, 0, 0, 0.25, 0.5, 0, 0)
	DirectorTagsUI3DPlayer6:subscribeToGlobalModel(f1_arg1, "LobbyClients", "6", function(model)
		DirectorTagsUI3DPlayer6:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer6)
	self.DirectorTagsUI3DPlayer6 = DirectorTagsUI3DPlayer6
	local DirectorTagsUI3DPlayer5 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0, 0.25, 0, 0, 0.25, 0.5, 0, 0)
	DirectorTagsUI3DPlayer5:subscribeToGlobalModel(f1_arg1, "LobbyClients", "5", function(model)
		DirectorTagsUI3DPlayer5:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer5)
	self.DirectorTagsUI3DPlayer5 = DirectorTagsUI3DPlayer5
	local DirectorTagsUI3DPlayer4 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.75, 1, 0, 0, 0, 0.25, 0, 0)
	DirectorTagsUI3DPlayer4:subscribeToGlobalModel(f1_arg1, "LobbyClients", "4", function(model)
		DirectorTagsUI3DPlayer4:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer4)
	self.DirectorTagsUI3DPlayer4 = DirectorTagsUI3DPlayer4
	local DirectorTagsUI3DPlayer3 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.5, 0.75, 0, 0, 0, 0.25, 0, 0)
	DirectorTagsUI3DPlayer3:subscribeToGlobalModel(f1_arg1, "LobbyClients", "3", function(model)
		DirectorTagsUI3DPlayer3:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer3)
	self.DirectorTagsUI3DPlayer3 = DirectorTagsUI3DPlayer3
	local DirectorTagsUI3DPlayer2 = CoD.DirectorTagsUI3DPlayer.new(f1_arg0, f1_arg1, 0.25, 0.5, 0, 0, 0, 0.25, 0, 0)
	DirectorTagsUI3DPlayer2:subscribeToGlobalModel(f1_arg1, "LobbyClients", "2", function(model)
		DirectorTagsUI3DPlayer2:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorTagsUI3DPlayer2)
	self.DirectorTagsUI3DPlayer2 = DirectorTagsUI3DPlayer2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTagsUI3D.__onClose = function(f18_arg0)
	f18_arg0.DirectorTagsUI3DPlayer1:close()
	f18_arg0.DirectorTagsUI3DPlayer16:close()
	f18_arg0.DirectorTagsUI3DPlayer15:close()
	f18_arg0.DirectorTagsUI3DPlayer14:close()
	f18_arg0.DirectorTagsUI3DPlayer13:close()
	f18_arg0.DirectorTagsUI3DPlayer12:close()
	f18_arg0.DirectorTagsUI3DPlayer11:close()
	f18_arg0.DirectorTagsUI3DPlayer10:close()
	f18_arg0.DirectorTagsUI3DPlayer9:close()
	f18_arg0.DirectorTagsUI3DPlayer8:close()
	f18_arg0.DirectorTagsUI3DPlayer7:close()
	f18_arg0.DirectorTagsUI3DPlayer6:close()
	f18_arg0.DirectorTagsUI3DPlayer5:close()
	f18_arg0.DirectorTagsUI3DPlayer4:close()
	f18_arg0.DirectorTagsUI3DPlayer3:close()
	f18_arg0.DirectorTagsUI3DPlayer2:close()
end
