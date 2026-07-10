require("x64:8fd670b6e6a9526")
require("x64:f9e504ad8b2d1e7")
require("x64:e122b7636abd48c")
require("x64:536dc2ca6c391e7")
CoD.TabletLocationSelector_Frame = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_Frame.__defaultWidth = 1106
CoD.TabletLocationSelector_Frame.__defaultHeight = 710
CoD.TabletLocationSelector_Frame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletLocationSelector_Frame)
	self.id = "TabletLocationSelector_Frame"
	self.soundSet = "none"
	local FrameCornerTL = LUI.UIImage.new(0, 0, 58, 98, 0, 0, 0, 40)
	FrameCornerTL:setAlpha(0.2)
	FrameCornerTL:setImage(RegisterImage(@"hash_2102824AD846AAD9"))
	self:addElement(FrameCornerTL)
	self.FrameCornerTL = FrameCornerTL
	local FrameCornerBR = LUI.UIImage.new(1, 1, -140, -100, 1, 1, -45, -5)
	FrameCornerBR:setAlpha(0.2)
	FrameCornerBR:setZRot(180)
	FrameCornerBR:setImage(RegisterImage(@"hash_2102824AD846AAD9"))
	self:addElement(FrameCornerBR)
	self.FrameCornerBR = FrameCornerBR
	local FrameCornerTR = LUI.UIImage.new(1, 1, -140, -100, 0, 0, 0, 40)
	FrameCornerTR:setAlpha(0.2)
	FrameCornerTR:setYRot(180)
	FrameCornerTR:setImage(RegisterImage(@"hash_2102824AD846AAD9"))
	self:addElement(FrameCornerTR)
	self.FrameCornerTR = FrameCornerTR
	local FrameCornerBL = LUI.UIImage.new(0, 0, 58, 98, 1, 1, -45, -5)
	FrameCornerBL:setAlpha(0.2)
	FrameCornerBL:setXRot(180)
	FrameCornerBL:setImage(RegisterImage(@"hash_2102824AD846AAD9"))
	self:addElement(FrameCornerBL)
	self.FrameCornerBL = FrameCornerBL
	local FrameTopL = LUI.UIImage.new(0, 1, 98, -806, 0, 0, 0, 40)
	FrameTopL:setAlpha(0.2)
	FrameTopL:setImage(RegisterImage(@"hash_5201515318295B75"))
	self:addElement(FrameTopL)
	self.FrameTopL = FrameTopL
	local FrameTopR = LUI.UIImage.new(0.82, 1, -140, -140, 0, 0, 0, 40)
	FrameTopR:setAlpha(0.2)
	FrameTopR:setImage(RegisterImage(@"hash_5201515318295B75"))
	self:addElement(FrameTopR)
	self.FrameTopR = FrameTopR
	local FrameSideL = LUI.UIImage.new(0, 0, 58, 98, 0, 1, 42, -42)
	FrameSideL:setAlpha(0.02)
	FrameSideL:setImage(RegisterImage(@"hash_3FA302084C18FAA1"))
	self:addElement(FrameSideL)
	self.FrameSideL = FrameSideL
	local FrameSideR = LUI.UIImage.new(1, 1, -140, -100, 0, 1, 42, -42)
	FrameSideR:setAlpha(0.02)
	FrameSideR:setYRot(180)
	FrameSideR:setImage(RegisterImage(@"hash_3FA302084C18FAA1"))
	self:addElement(FrameSideR)
	self.FrameSideR = FrameSideR
	local FrameBotL = LUI.UIImage.new(0, 0.31, 98, 98, 1, 1, -45, -5)
	FrameBotL:setAlpha(0.2)
	FrameBotL:setZRot(180)
	FrameBotL:setImage(RegisterImage(@"hash_5201515318295B75"))
	self:addElement(FrameBotL)
	self.FrameBotL = FrameBotL
	local FrameBotR = LUI.UIImage.new(0.73, 1, -140, -140, 1, 1, -45, -5)
	FrameBotR:setAlpha(0.2)
	FrameBotR:setZRot(180)
	FrameBotR:setImage(RegisterImage(@"hash_5201515318295B75"))
	self:addElement(FrameBotR)
	self.FrameBotR = FrameBotR
	local Meter = LUI.UIImage.new(0.5, 0.5, -73, 43, 0, 0, 20, 50)
	Meter:setAlpha(0.05)
	Meter:setImage(RegisterImage(@"hash_33908E8325A56C68"))
	self:addElement(Meter)
	self.Meter = Meter
	local DiagonalFrameR = LUI.UIImage.new(1, 1, -314, -151, 1, 1, -189, -90)
	DiagonalFrameR:setAlpha(0.05)
	DiagonalFrameR:setImage(RegisterImage(@"hash_778EC0C14D6CB24B"))
	self:addElement(DiagonalFrameR)
	self.DiagonalFrameR = DiagonalFrameR
	local DiagonalFrameL = LUI.UIImage.new(0, 0, 111, 274, 1, 1, -189, -90)
	DiagonalFrameL:setAlpha(0.05)
	DiagonalFrameL:setYRot(180)
	DiagonalFrameL:setImage(RegisterImage(@"hash_778EC0C14D6CB24B"))
	self:addElement(DiagonalFrameL)
	self.DiagonalFrameL = DiagonalFrameL
	local ButtonCase1 = LUI.UIImage.new(0.5, 0.5, -355, -157, 1, 1, -54, -6)
	ButtonCase1:setAlpha(0.06)
	ButtonCase1:setZRot(180)
	ButtonCase1:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_ctrl_button_container"))
	self:addElement(ButtonCase1)
	self.ButtonCase1 = ButtonCase1
	local f1_local15 = nil
	self.ButtonCase2Base = LUI.UIElement.createFake()
	local f1_local16 = nil
	self.ButtonCase2 = LUI.UIElement.createFake()
	local ButtonCase3 = LUI.UIImage.new(0.5, 0.5, 157, 355, 1, 1, -54, -6)
	ButtonCase3:setAlpha(0.06)
	ButtonCase3:setZRot(180)
	ButtonCase3:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_ctrl_button_container"))
	self:addElement(ButtonCase3)
	self.ButtonCase3 = ButtonCase3
	local Grid = CoD.TabletLocationSelector_Grid.new(f1_arg0, f1_arg1, 0.5, 0.5, -449, 409, 0.5, 0.5, -284.5, 289.5)
	Grid:setRGB(0.64, 0.64, 0.64)
	self:addElement(Grid)
	self.Grid = Grid
	local GadgetCircleL = CoD.vhud_lightningstrike_ambientgadget_circle.new(f1_arg0, f1_arg1, 0.5, 0.5, -251, -137, 0, 0, 10, 60)
	GadgetCircleL:setAlpha(0.05)
	self:addElement(GadgetCircleL)
	self.GadgetCircleL = GadgetCircleL
	local GadgetCircleR = CoD.vhud_lightningstrike_ambientgadget_circle.new(f1_arg0, f1_arg1, 0.5, 0.5, 94, 208, 0, 0, 10, 60)
	GadgetCircleR:setAlpha(0.05)
	self:addElement(GadgetCircleR)
	self.GadgetCircleR = GadgetCircleR
	local GadgetSquareR = CoD.vhud_lightningstrike_ambientgadget_square.new(f1_arg0, f1_arg1, 0.5, 0.5, 196, 316, 1, 1, -56, -6)
	GadgetSquareR:setAlpha(0.06)
	self:addElement(GadgetSquareR)
	self.GadgetSquareR = GadgetSquareR
	local GadgetSquareL = CoD.vhud_lightningstrike_ambientgadget_square.new(f1_arg0, f1_arg1, 0.5, 0.5, -316, -196, 1, 1, -56, -6)
	GadgetSquareL:setAlpha(0.06)
	self:addElement(GadgetSquareL)
	self.GadgetSquareL = GadgetSquareL
	local AmbientGadgetL = LUI.UIImage.new(0, 0, -14, 67, 0, 0, 95, 228)
	AmbientGadgetL:setAlpha(0.05)
	AmbientGadgetL:setImage(RegisterImage(@"hash_5A6F04A05C52120B"))
	self:addElement(AmbientGadgetL)
	self.AmbientGadgetL = AmbientGadgetL
	local AmbientGadgetR = CoD.vhud_lightningstrike_ambientgadget.new(f1_arg0, f1_arg1, 1, 1, -100, 0, 0, 0, 130, 267)
	AmbientGadgetR:setAlpha(0.05)
	self:addElement(AmbientGadgetR)
	self.AmbientGadgetR = AmbientGadgetR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletLocationSelector_Frame.__onClose = function(f2_arg0)
	f2_arg0.Grid:close()
	f2_arg0.GadgetCircleL:close()
	f2_arg0.GadgetCircleR:close()
	f2_arg0.GadgetSquareR:close()
	f2_arg0.GadgetSquareL:close()
	f2_arg0.AmbientGadgetR:close()
end
