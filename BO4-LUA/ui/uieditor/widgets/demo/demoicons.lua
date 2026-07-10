CoD.DemoIcons = InheritFrom(LUI.UIElement)
CoD.DemoIcons.__defaultWidth = 857
CoD.DemoIcons.__defaultHeight = 200
CoD.DemoIcons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoIcons)
	self.id = "DemoIcons"
	self.soundSet = "default"
	local icon = LUI.UIImage.new(0.5, 0.5, -407.5, -377.5, 0.5, 0.5, -88, -58)
	icon:setImage(RegisterImage(@"theater_pause"))
	self:addElement(icon)
	self.icon = icon
	local icon2 = LUI.UIImage.new(0.5, 0.5, -353.5, -323.5, 0.5, 0.5, -88, -58)
	icon2:setImage(RegisterImage(@"theater_fastforward"))
	self:addElement(icon2)
	self.icon2 = icon2
	local Image = LUI.UIImage.new(0.5, 0.5, -303.5, -273.5, 0.5, 0.5, -88, -58)
	Image:setImage(RegisterImage(@"theater_play"))
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0.5, 0.5, -245.5, -215.5, 0.5, 0.5, -88, -58)
	Image2:setImage(RegisterImage(@"theater_record"))
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0.5, 0.5, -189.5, -159.5, 0.5, 0.5, -88, -58)
	Image3:setImage(RegisterImage(@"theater_back"))
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0.5, 0.5, -141.5, -111.5, 0.5, 0.5, -88, -58)
	Image4:setImage(RegisterImage(@"theater_video"))
	self:addElement(Image4)
	self.Image4 = Image4
	local Image5 = LUI.UIImage.new(0.5, 0.5, -85, -55, 0.5, 0.5, -88, -58)
	Image5:setImage(RegisterImage(@"theater_screenshot"))
	self:addElement(Image5)
	self.Image5 = Image5
	local Image6 = LUI.UIImage.new(0.5, 0.5, -43, -13, 0.5, 0.5, -88, -58)
	Image6:setImage(RegisterImage(@"theater_forward"))
	self:addElement(Image6)
	self.Image6 = Image6
	local Image7 = LUI.UIImage.new(0.5, 0.5, 0, 30, 0.5, 0.5, -88, -58)
	Image7:setImage(RegisterImage(@"theater_fastforward_1"))
	self:addElement(Image7)
	self.Image7 = Image7
	local Image8 = LUI.UIImage.new(0.5, 0.5, 42, 72, 0.5, 0.5, -88, -58)
	Image8:setImage(RegisterImage(@"theater_fastforward_2"))
	self:addElement(Image8)
	self.Image8 = Image8
	local Image9 = LUI.UIImage.new(0.5, 0.5, 82, 112, 0.5, 0.5, -88, -58)
	Image9:setImage(RegisterImage(@"theater_fastforward_3"))
	self:addElement(Image9)
	self.Image9 = Image9
	local Image10 = LUI.UIImage.new(0.5, 0.5, 125, 155, 0.5, 0.5, -88, -58)
	Image10:setImage(RegisterImage(@"theater_settings"))
	self:addElement(Image10)
	self.Image10 = Image10
	local Image11 = LUI.UIImage.new(0.5, 0.5, 170, 200, 0.5, 0.5, -88, -58)
	Image11:setImage(RegisterImage(@"theater_link"))
	self:addElement(Image11)
	self.Image11 = Image11
	local Image12 = LUI.UIImage.new(0.5, 0.5, 213, 243, 0.5, 0.5, -88, -58)
	Image12:setImage(RegisterImage(@"theater_bulb"))
	self:addElement(Image12)
	self.Image12 = Image12
	local Image13 = LUI.UIImage.new(0.5, 0.5, 255, 285, 0.5, 0.5, -88, -58)
	Image13:setImage(RegisterImage(@"theater_timeline"))
	self:addElement(Image13)
	self.Image13 = Image13
	local Image14 = LUI.UIImage.new(0.5, 0.5, 300, 330, 0.5, 0.5, -88, -58)
	Image14:setImage(RegisterImage(@"hash_472AEB4C18D4662F"))
	self:addElement(Image14)
	self.Image14 = Image14
	local Image15 = LUI.UIImage.new(0.5, 0.5, 341, 371, 0.5, 0.5, -88, -58)
	Image15:setImage(RegisterImage(@"hash_4414F4BE1E294D4E"))
	self:addElement(Image15)
	self.Image15 = Image15
	local Image16 = LUI.UIImage.new(0.5, 0.5, 382, 412, 0.5, 0.5, -88, -58)
	Image16:setImage(RegisterImage(@"hash_22A8E2789613E50E"))
	self:addElement(Image16)
	self.Image16 = Image16
	local Image17 = LUI.UIImage.new(0.5, 0.5, -407.5, -377.5, 0.5, 0.5, -42.5, -12.5)
	Image17:setImage(RegisterImage(@"hash_4BD020DE9BC680A9"))
	self:addElement(Image17)
	self.Image17 = Image17
	local Image18 = LUI.UIImage.new(0.5, 0.5, -368.5, -338.5, 0.5, 0.5, -42.5, -12.5)
	Image18:setImage(RegisterImage(@"theater_link_object"))
	self:addElement(Image18)
	self.Image18 = Image18
	local Image19 = LUI.UIImage.new(0.5, 0.5, -323.5, -293.5, 0.5, 0.5, -42.5, -12.5)
	Image19:setImage(RegisterImage(@"theater_unlink_object"))
	self:addElement(Image19)
	self.Image19 = Image19
	local Image20 = LUI.UIImage.new(0.5, 0.5, -275.5, -245.5, 0.5, 0.5, -42.5, -12.5)
	Image20:setImage(RegisterImage(@"theater_slow"))
	self:addElement(Image20)
	self.Image20 = Image20
	local Image21 = LUI.UIImage.new(0.5, 0.5, -132, -98, 0.5, 0.5, -42.5, -12.5)
	Image21:setImage(RegisterImage(@"theater_slow_3"))
	self:addElement(Image21)
	self.Image21 = Image21
	local Image22 = LUI.UIImage.new(0.5, 0.5, -91, -61, 0.5, 0.5, -42.5, -12.5)
	Image22:setImage(RegisterImage(@"hash_43E599F0D948E2DF"))
	self:addElement(Image22)
	self.Image22 = Image22
	local Image23 = LUI.UIImage.new(0.5, 0.5, -3, 27, 0.5, 0.5, -42.5, -12.5)
	Image23:setImage(RegisterImage(@"hash_3A294B63BC865A91"))
	self:addElement(Image23)
	self.Image23 = Image23
	local Image24 = LUI.UIImage.new(0.5, 0.5, 38.5, 68.5, 0.5, 0.5, -42.5, -12.5)
	Image24:setImage(RegisterImage(@"hash_38836A8306560A2A"))
	self:addElement(Image24)
	self.Image24 = Image24
	local Image25 = LUI.UIImage.new(0.5, 0.5, 80.5, 110.5, 0.5, 0.5, -42.5, -12.5)
	Image25:setImage(RegisterImage(@"hash_76008960BCA65979"))
	self:addElement(Image25)
	self.Image25 = Image25
	local Image26 = LUI.UIImage.new(0.5, 0.5, 123.5, 153.5, 0.5, 0.5, -42.5, -12.5)
	Image26:setImage(RegisterImage(@"hash_167235575E0A08AE"))
	self:addElement(Image26)
	self.Image26 = Image26
	local Image27 = LUI.UIImage.new(0.5, 0.5, 165.5, 195.5, 0.5, 0.5, -42.5, -12.5)
	Image27:setImage(RegisterImage(@"hash_14BD1D0C96ED384F"))
	self:addElement(Image27)
	self.Image27 = Image27
	local Image28 = LUI.UIImage.new(0.5, 0.5, 205.5, 235.5, 0.5, 0.5, -42.5, -12.5)
	Image28:setImage(RegisterImage(@"hash_45E49A6A4F3F8223"))
	self:addElement(Image28)
	self.Image28 = Image28
	local Image29 = LUI.UIImage.new(0.5, 0.5, 248.5, 278.5, 0.5, 0.5, -42.5, -12.5)
	Image29:setImage(RegisterImage(@"hash_11C22491FE84A86D"))
	self:addElement(Image29)
	self.Image29 = Image29
	local Image30 = LUI.UIImage.new(0.5, 0.5, -43, -13, 0.5, 0.5, -42.5, -12.5)
	Image30:setImage(RegisterImage(@"hash_430999227A02F4E0"))
	self:addElement(Image30)
	self.Image30 = Image30
	local Image31 = LUI.UIImage.new(0.5, 0.5, 296.5, 326.5, 0.5, 0.5, -42.5, -12.5)
	Image31:setImage(RegisterImage(@"hash_1D61F8B4F69737B8"))
	self:addElement(Image31)
	self.Image31 = Image31
	local Image32 = LUI.UIImage.new(0.5, 0.5, 338.5, 368.5, 0.5, 0.5, -42.5, -12.5)
	Image32:setImage(RegisterImage(@"hash_3CD6F4F47F250135"))
	self:addElement(Image32)
	self.Image32 = Image32
	local Image33 = LUI.UIImage.new(0.5, 0.5, 383.5, 413.5, 0.5, 0.5, -42.5, -12.5)
	Image33:setImage(RegisterImage(@"hash_715E6D5A56413D9A"))
	self:addElement(Image33)
	self.Image33 = Image33
	local Image34 = LUI.UIImage.new(0.5, 0.5, -398.5, -368.5, 0.5, 0.5, 0, 30)
	Image34:setImage(RegisterImage(@"hash_48E48C5C9B335333"))
	self:addElement(Image34)
	self.Image34 = Image34
	local Image35 = LUI.UIImage.new(0.5, 0.5, -353.5, -323.5, 0.5, 0.5, 0, 30)
	Image35:setImage(RegisterImage(@"hash_3FC7E24A95DA300D"))
	self:addElement(Image35)
	self.Image35 = Image35
	local Image36 = LUI.UIImage.new(0.5, 0.5, -50.5, -20.5, 0.5, 0.5, 0, 30)
	Image36:setImage(RegisterImage(@"hash_21746039F43DB75C"))
	self:addElement(Image36)
	self.Image36 = Image36
	local Image37 = LUI.UIImage.new(0.5, 0.5, -10.5, 19.5, 0.5, 0.5, 0, 30)
	Image37:setImage(RegisterImage(@"hash_3203B98C5FF05760"))
	self:addElement(Image37)
	self.Image37 = Image37
	local Image38 = LUI.UIImage.new(0.5, 0.5, -98.5, -68.5, 0.5, 0.5, 0, 30)
	Image38:setImage(RegisterImage(@"hash_578FD2238CC0C5EE"))
	self:addElement(Image38)
	self.Image38 = Image38
	local Image39 = LUI.UIImage.new(0.5, 0.5, -139.5, -109.5, 0.5, 0.5, 0, 30)
	Image39:setImage(RegisterImage(@"hash_8FA91637A4E25F4"))
	self:addElement(Image39)
	self.Image39 = Image39
	local Image60 = nil
	Image60 = LUI.UIImage.new(0.5, 0.5, -277.5, -247.5, 0.5, 0.5, 42.5, 72.5)
	Image60:setImage(RegisterImage(@"hash_2868395925CB26A7"))
	self:addElement(Image60)
	self.Image60 = Image60
	local Image59 = nil
	Image59 = LUI.UIImage.new(0.5, 0.5, -323.5, -293.5, 0.5, 0.5, 42.5, 72.5)
	Image59:setImage(RegisterImage(@"hash_1DCA9DCD4D6F634"))
	self:addElement(Image59)
	self.Image59 = Image59
	local Image40 = LUI.UIImage.new(0.5, 0.5, -184.5, -154.5, 0.5, 0.5, 0, 30)
	Image40:setImage(RegisterImage(@"hash_64229B8898CA8E1C"))
	self:addElement(Image40)
	self.Image40 = Image40
	local Image57 = nil
	Image57 = LUI.UIImage.new(0.5, 0.5, -407.5, -377.5, 0.5, 0.5, 42.5, 72.5)
	Image57:setImage(RegisterImage(@"hash_1E685DB08682E616"))
	self:addElement(Image57)
	self.Image57 = Image57
	local Image58 = nil
	Image58 = LUI.UIImage.new(0.5, 0.5, -368.5, -338.5, 0.5, 0.5, 42.5, 72.5)
	Image58:setImage(RegisterImage(0x3A71BD6F73F4AB))
	self:addElement(Image58)
	self.Image58 = Image58
	local Image41 = LUI.UIImage.new(0.5, 0.5, -232.5, -202.5, 0.5, 0.5, 0, 30)
	Image41:setImage(RegisterImage(@"hash_CD69BEABBCE5047"))
	self:addElement(Image41)
	self.Image41 = Image41
	local Image42 = LUI.UIImage.new(0.5, 0.5, -277.5, -247.5, 0.5, 0.5, 0, 30)
	Image42:setImage(RegisterImage(@"hash_1D53E0099155FE86"))
	self:addElement(Image42)
	self.Image42 = Image42
	local Image43 = LUI.UIImage.new(0.5, 0.5, -316.5, -286.5, 0.5, 0.5, 0, 30)
	Image43:setImage(RegisterImage(0xD24E1B46822A76))
	self:addElement(Image43)
	self.Image43 = Image43
	local Image44 = LUI.UIImage.new(0.5, 0.5, 31, 61, 0.5, 0.5, 0, 30)
	Image44:setImage(RegisterImage(@"hash_1EB22994B30A0082"))
	self:addElement(Image44)
	self.Image44 = Image44
	local Image45 = LUI.UIImage.new(0.5, 0.5, 73, 103, 0.5, 0.5, 0, 30)
	Image45:setImage(RegisterImage(@"hash_5C9C0D644E269514"))
	self:addElement(Image45)
	self.Image45 = Image45
	local Image46 = LUI.UIImage.new(0.5, 0.5, 106, 136, 0.5, 0.5, 0, 30)
	Image46:setImage(RegisterImage(@"theater_view"))
	self:addElement(Image46)
	self.Image46 = Image46
	local Image47 = LUI.UIImage.new(0.5, 0.5, 143, 173, 0.5, 0.5, 0, 30)
	Image47:setImage(RegisterImage(@"theater_delete"))
	self:addElement(Image47)
	self.Image47 = Image47
	local Image48 = LUI.UIImage.new(0.5, 0.5, 183, 213, 0.5, 0.5, 0, 30)
	Image48:setImage(RegisterImage(@"theater_rename"))
	self:addElement(Image48)
	self.Image48 = Image48
	local Image49 = LUI.UIImage.new(0.5, 0.5, 226, 256, 0.5, 0.5, 0, 30)
	Image49:setImage(RegisterImage(@"theater_save"))
	self:addElement(Image49)
	self.Image49 = Image49
	local Image50 = LUI.UIImage.new(0.5, 0.5, 261, 291, 0.5, 0.5, 0, 30)
	Image50:setImage(RegisterImage(@"theater_merge"))
	self:addElement(Image50)
	self.Image50 = Image50
	local Image51 = LUI.UIImage.new(0.5, 0.5, 301, 331, 0.5, 0.5, 0, 30)
	Image51:setImage(RegisterImage(@"theater_delete_all"))
	self:addElement(Image51)
	self.Image51 = Image51
	local Image54 = LUI.UIImage.new(0.5, 0.5, 338.5, 368.5, 0.5, 0.5, 0, 30)
	Image54:setImage(RegisterImage(@"hash_35B508D5EB68DD40"))
	self:addElement(Image54)
	self.Image54 = Image54
	local Image52 = LUI.UIImage.new(0.5, 0.5, -232.5, -202.5, 0.5, 0.5, -42.5, -12.5)
	Image52:setImage(RegisterImage(@"theater_slow_1"))
	self:addElement(Image52)
	self.Image52 = Image52
	local Image53 = LUI.UIImage.new(0.5, 0.5, -189.5, -159.5, 0.5, 0.5, -42.5, -12.5)
	Image53:setImage(RegisterImage(@"theater_slow_2"))
	self:addElement(Image53)
	self.Image53 = Image53
	local Image55 = LUI.UIImage.new(0.5, 0.5, 408.5, 438.5, 0.5, 0.5, 0, 30)
	Image55:setImage(RegisterImage(@"hash_574DED9A7DC4BD1C"))
	self:addElement(Image55)
	self.Image55 = Image55
	local Image56 = LUI.UIImage.new(0.5, 0.5, 371, 401, 0.5, 0.5, 0, 30)
	Image56:setImage(RegisterImage(@"hash_47828B8384381EB8"))
	self:addElement(Image56)
	self.Image56 = Image56
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
