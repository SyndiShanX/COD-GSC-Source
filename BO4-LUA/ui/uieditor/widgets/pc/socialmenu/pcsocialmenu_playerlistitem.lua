require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_playerlistitem_empty")
require("ui/uieditor/widgets/pc/socialmenu/pcsocialmenu_playerlistitem_playerinfos")
CoD.PCSocialMenu_PlayerListItem = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayerListItem.__defaultWidth = 622
CoD.PCSocialMenu_PlayerListItem.__defaultHeight = 85
CoD.PCSocialMenu_PlayerListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayerListItem)
	self.id = "PCSocialMenu_PlayerListItem"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Empty = CoD.PCSocialMenu_PlayerListItem_Empty.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 85)
	self:addElement(Empty)
	self.Empty = Empty
	local PlayerInfo = CoD.PCSocialMenu_PlayerListItem_PlayerInfos.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 85)
	PlayerInfo:linkToElementModel(self, nil, false, function(model)
		PlayerInfo:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerInfo)
	self.PlayerInfo = PlayerInfo
	local SelectedTop = LUI.UIImage.new(0, 1, 2, -2, 0, 0, 2, 6)
	SelectedTop:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	SelectedTop:setAlpha(0)
	self:addElement(SelectedTop)
	self.SelectedTop = SelectedTop
	local SelectedBottom = LUI.UIImage.new(0, 1, 2, -2, 1, 1, -6, -2)
	SelectedBottom:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	SelectedBottom:setAlpha(0)
	self:addElement(SelectedBottom)
	self.SelectedBottom = SelectedBottom
	PlayerInfo.id = "PlayerInfo"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PlayerListItem.__resetProperties = function(f3_arg0)
	f3_arg0.PlayerInfo:completeAnimation()
	f3_arg0.SelectedBottom:completeAnimation()
	f3_arg0.SelectedTop:completeAnimation()
	f3_arg0.PlayerInfo:setAlpha(1)
	f3_arg0.PlayerInfo:setScale(1, 1)
	f3_arg0.SelectedBottom:setAlpha(0)
	f3_arg0.SelectedTop:setAlpha(0)
end
CoD.PCSocialMenu_PlayerListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.PlayerInfo:beginAnimation(100)
				f5_arg0.PlayerInfo:setScale(1.03, 1.03)
				f5_arg0.PlayerInfo:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.PlayerInfo:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.PlayerInfo:completeAnimation()
			f5_arg0.PlayerInfo:setScale(1, 1)
			f5_local0(f5_arg0.PlayerInfo)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.PlayerInfo:beginAnimation(80)
				f7_arg0.PlayerInfo:setScale(1, 1)
				f7_arg0.PlayerInfo:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.PlayerInfo:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.PlayerInfo:completeAnimation()
			f7_arg0.PlayerInfo:setScale(1.03, 1.03)
			f7_local0(f7_arg0.PlayerInfo)
		end,
		Active = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.SelectedTop:beginAnimation(50)
				f9_arg0.SelectedTop:setAlpha(1)
				f9_arg0.SelectedTop:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectedTop:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectedTop:completeAnimation()
			f9_arg0.SelectedTop:setAlpha(0)
			f9_local0(f9_arg0.SelectedTop)
			local f9_local1 = function(f11_arg0)
				f9_arg0.SelectedBottom:beginAnimation(50)
				f9_arg0.SelectedBottom:setAlpha(1)
				f9_arg0.SelectedBottom:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectedBottom:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectedBottom:completeAnimation()
			f9_arg0.SelectedBottom:setAlpha(0)
			f9_local1(f9_arg0.SelectedBottom)
		end,
	},
	Empty = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.PlayerInfo:completeAnimation()
			f12_arg0.PlayerInfo:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PlayerInfo)
		end,
	},
	Selected = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.SelectedTop:completeAnimation()
			f13_arg0.SelectedTop:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.SelectedTop)
			f13_arg0.SelectedBottom:completeAnimation()
			f13_arg0.SelectedBottom:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.SelectedBottom)
		end,
	},
}
CoD.PCSocialMenu_PlayerListItem.__onClose = function(f14_arg0)
	f14_arg0.Empty:close()
	f14_arg0.PlayerInfo:close()
end
