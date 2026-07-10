require("x64:c758905067eec43")
require("x64:6c9bc51841ccd42")
require("x64:49e0e4e7d6bf92f")
require("x64:b1abec47f2d820")
require("x64:bb6802b829c217b")
CoD.ScoreboardGameStatus = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameStatus.__defaultWidth = 1920
CoD.ScoreboardGameStatus.__defaultHeight = 793
CoD.ScoreboardGameStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardGameStatus)
	self.id = "ScoreboardGameStatus"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBG = LUI.UIImage.new(0, 0, 235, 1685, 0, 0, 177, 761)
	BlurBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBG)
	self.BlurBG = BlurBG
	local TintBot01 = LUI.UIImage.new(0, 0, 235, 1685, 0, 0, 753, 761)
	TintBot01:setRGB(0, 0, 0)
	TintBot01:setAlpha(0.3)
	self:addElement(TintBot01)
	self.TintBot01 = TintBot01
	local TintBody01 = LUI.UIImage.new(0, 0, 233, 1687, 0, 0, 185, 755)
	TintBody01:setRGB(0.87, 0.87, 0.87)
	TintBody01:setAlpha(0.9)
	TintBody01:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_map_bg"))
	self:addElement(TintBody01)
	self.TintBody01 = TintBody01
	local TintTop01 = LUI.UIImage.new(0, 0, 235, 1685, 0, 0, 177, 185)
	TintTop01:setRGB(0, 0, 0)
	TintTop01:setAlpha(0)
	self:addElement(TintTop01)
	self.TintTop01 = TintTop01
	local ScoreboardGameStatusMap = CoD.ScoreboardGameStatusMapMask.new(f1_arg0, f1_arg1, 0, 0, 460, 1460, 0, 0, 229, 719)
	self:addElement(ScoreboardGameStatusMap)
	self.ScoreboardGameStatusMap = ScoreboardGameStatusMap
	local MapGrid02 = LUI.UIImage.new(0, 0, 224, 1682, 0, 0, 218, 706)
	MapGrid02:setAlpha(0)
	MapGrid02:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_map_grid01"))
	MapGrid02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	MapGrid02:setShaderVector(0, 9, 4, 0, 0)
	MapGrid02:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(MapGrid02)
	self.MapGrid02 = MapGrid02
	local Corner = CoD.TabbedScoreboardLayoutCorner.new(f1_arg0, f1_arg1, 0, 0, 466, 1451, 0, 0, 239.5, 711.5)
	self:addElement(Corner)
	self.Corner = Corner
	local CornerAdd = CoD.TabbedScoreboardLayoutCorner.new(f1_arg0, f1_arg1, 0, 0, 466, 1451, 0, 0, 239.5, 711.5)
	CornerAdd:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CornerAdd)
	self.CornerAdd = CornerAdd
	local MapGrid01 = LUI.UIImage.new(0, 0, 475, 1441, 0, 0, 248, 748)
	MapGrid01:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_map_grid04"))
	MapGrid01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	MapGrid01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(MapGrid01)
	self.MapGrid01 = MapGrid01
	local infoGraphic = CoD.TabbedScoreboardMapInfographic.new(f1_arg0, f1_arg1, 0, 0, 218, 1702, 0, 0, 206, 748)
	self:addElement(infoGraphic)
	self.infoGraphic = infoGraphic
	local InfoboxRIght = CoD.TabbedScoreboardMapInfoboxRight.new(f1_arg0, f1_arg1, 0, 0, 1490, 1678, 0, 0, 625, 719)
	self:addElement(InfoboxRIght)
	self.InfoboxRIght = InfoboxRIght
	local infoboxLeft = CoD.TabbedScoreboardMapInfoboxLeft.new(f1_arg0, f1_arg1, 0, 0, 242, 382, 0, 0, 229, 378)
	self:addElement(infoboxLeft)
	self.infoboxLeft = infoboxLeft
	local MapLayoutSideBoxR = LUI.UIImage.new(0, 0, 1672, 1688, 0, 0, 465, 489)
	MapLayoutSideBoxR:setImage(RegisterImage(@"hash_12ED71ABEC279140"))
	self:addElement(MapLayoutSideBoxR)
	self.MapLayoutSideBoxR = MapLayoutSideBoxR
	local MapLayoutSideBoxL = LUI.UIImage.new(0, 0, 231.5, 247.5, 0, 0, 465, 489)
	MapLayoutSideBoxL:setZRot(180)
	MapLayoutSideBoxL:setImage(RegisterImage(@"hash_12ED71ABEC279140"))
	self:addElement(MapLayoutSideBoxL)
	self.MapLayoutSideBoxL = MapLayoutSideBoxL
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP)
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local16(f1_local15, f1_local17["scoreboardInfo.activeTab"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardGameStatus.__resetProperties = function(f4_arg0)
	f4_arg0.MapGrid02:completeAnimation()
	f4_arg0.TintTop01:completeAnimation()
	f4_arg0.TintBody01:completeAnimation()
	f4_arg0.BlurBG:completeAnimation()
	f4_arg0.TintBot01:completeAnimation()
	f4_arg0.infoGraphic:completeAnimation()
	f4_arg0.infoboxLeft:completeAnimation()
	f4_arg0.InfoboxRIght:completeAnimation()
	f4_arg0.CornerAdd:completeAnimation()
	f4_arg0.MapGrid01:completeAnimation()
	f4_arg0.Corner:completeAnimation()
	f4_arg0.MapLayoutSideBoxR:completeAnimation()
	f4_arg0.MapLayoutSideBoxL:completeAnimation()
	f4_arg0.MapGrid02:setAlpha(0)
	f4_arg0.TintTop01:setAlpha(0)
	f4_arg0.TintBody01:setAlpha(0.9)
	f4_arg0.BlurBG:setAlpha(1)
	f4_arg0.TintBot01:setAlpha(0.3)
	f4_arg0.infoGraphic:setAlpha(1)
	f4_arg0.infoboxLeft:setAlpha(1)
	f4_arg0.InfoboxRIght:setAlpha(1)
	f4_arg0.CornerAdd:setAlpha(1)
	f4_arg0.MapGrid01:setAlpha(1)
	f4_arg0.MapGrid01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f4_arg0.MapGrid01:setShaderVector(0, 1, 0, 0, 0)
	f4_arg0.Corner:setAlpha(1)
	f4_arg0.MapLayoutSideBoxR:setAlpha(1)
	f4_arg0.MapLayoutSideBoxL:setAlpha(1)
end
CoD.ScoreboardGameStatus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(11)
			f5_arg0.BlurBG:completeAnimation()
			f5_arg0.BlurBG:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BlurBG)
			f5_arg0.TintBot01:completeAnimation()
			f5_arg0.TintBot01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TintBot01)
			f5_arg0.TintBody01:completeAnimation()
			f5_arg0.TintBody01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TintBody01)
			f5_arg0.TintTop01:completeAnimation()
			f5_arg0.TintTop01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TintTop01)
			f5_arg0.MapGrid02:completeAnimation()
			f5_arg0.MapGrid02:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.MapGrid02)
			f5_arg0.Corner:completeAnimation()
			f5_arg0.Corner:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Corner)
			f5_arg0.CornerAdd:completeAnimation()
			f5_arg0.CornerAdd:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CornerAdd)
			f5_arg0.MapGrid01:completeAnimation()
			f5_arg0.MapGrid01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.MapGrid01)
			f5_arg0.infoGraphic:completeAnimation()
			f5_arg0.infoGraphic:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.infoGraphic)
			f5_arg0.InfoboxRIght:completeAnimation()
			f5_arg0.InfoboxRIght:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.InfoboxRIght)
			f5_arg0.infoboxLeft:completeAnimation()
			f5_arg0.infoboxLeft:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.infoboxLeft)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(9)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(100)
					f8_arg0:setAlpha(0.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f7_arg0:beginAnimation(399)
				f7_arg0:setAlpha(0.8)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.MapGrid02:beginAnimation(500)
			f6_arg0.MapGrid02:setAlpha(0)
			f6_arg0.MapGrid02:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.MapGrid02:registerEventHandler("transition_complete_keyframe", f6_local0)
			local f6_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(99)
					f10_arg0:setAlpha(0.8)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f9_arg0:beginAnimation(400)
				f9_arg0:setAlpha(1)
				f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f6_arg0.Corner:beginAnimation(200)
			f6_arg0.Corner:setAlpha(0)
			f6_arg0.Corner:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.Corner:registerEventHandler("transition_complete_keyframe", f6_local1)
			local f6_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(99)
					f12_arg0:setAlpha(0.8)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f11_arg0:beginAnimation(400)
				f11_arg0:setAlpha(1)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f6_arg0.CornerAdd:beginAnimation(200)
			f6_arg0.CornerAdd:setAlpha(0)
			f6_arg0.CornerAdd:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.CornerAdd:registerEventHandler("transition_complete_keyframe", f6_local2)
			local f6_local3 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(150)
					f14_arg0:setAlpha(0.2)
					f14_arg0:setShaderVector(0, 1, 0, 0, 0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.MapGrid01:beginAnimation(350)
				f6_arg0.MapGrid01:setAlpha(0.35)
				f6_arg0.MapGrid01:setShaderVector(0, 1.5, 0, 0, 0)
				f6_arg0.MapGrid01:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.MapGrid01:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f6_arg0.MapGrid01:completeAnimation()
			f6_arg0.MapGrid01:setAlpha(0)
			f6_arg0.MapGrid01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f6_arg0.MapGrid01:setShaderVector(0, 1, 0, 0, 0)
			f6_local3(f6_arg0.MapGrid01)
			local f6_local4 = function(f15_arg0)
				f15_arg0:beginAnimation(400)
				f15_arg0:setAlpha(1)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.infoGraphic:beginAnimation(200)
			f6_arg0.infoGraphic:setAlpha(0)
			f6_arg0.infoGraphic:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.infoGraphic:registerEventHandler("transition_complete_keyframe", f6_local4)
			local f6_local5 = function(f16_arg0)
				f6_arg0.InfoboxRIght:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.InfoboxRIght:setAlpha(1)
				f6_arg0.InfoboxRIght:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.InfoboxRIght:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.InfoboxRIght:completeAnimation()
			f6_arg0.InfoboxRIght:setAlpha(0)
			f6_local5(f6_arg0.InfoboxRIght)
			local f6_local6 = function(f17_arg0)
				f6_arg0.infoboxLeft:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.infoboxLeft:setAlpha(1)
				f6_arg0.infoboxLeft:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.infoboxLeft:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.infoboxLeft:completeAnimation()
			f6_arg0.infoboxLeft:setAlpha(0)
			f6_local6(f6_arg0.infoboxLeft)
			local f6_local7 = function(f18_arg0)
				f18_arg0:beginAnimation(299)
				f18_arg0:setAlpha(1)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.MapLayoutSideBoxR:beginAnimation(400)
			f6_arg0.MapLayoutSideBoxR:setAlpha(0)
			f6_arg0.MapLayoutSideBoxR:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.MapLayoutSideBoxR:registerEventHandler("transition_complete_keyframe", f6_local7)
			local f6_local8 = function(f19_arg0)
				f19_arg0:beginAnimation(299)
				f19_arg0:setAlpha(1)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.MapLayoutSideBoxL:beginAnimation(400)
			f6_arg0.MapLayoutSideBoxL:setAlpha(0)
			f6_arg0.MapLayoutSideBoxL:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.MapLayoutSideBoxL:registerEventHandler("transition_complete_keyframe", f6_local8)
		end,
	},
}
CoD.ScoreboardGameStatus.__onClose = function(f20_arg0)
	f20_arg0.ScoreboardGameStatusMap:close()
	f20_arg0.Corner:close()
	f20_arg0.CornerAdd:close()
	f20_arg0.infoGraphic:close()
	f20_arg0.InfoboxRIght:close()
	f20_arg0.infoboxLeft:close()
end
