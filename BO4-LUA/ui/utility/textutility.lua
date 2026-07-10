CoD.TextUtility = {}
CoD.TextUtility.SetupHorizontalScrollingWidget = function(f1_arg0, f1_arg1)
	local f1_local0 = function(f2_arg0, f2_arg1, f2_arg2)
		f2_arg0.textBox:beginAnimation("move", f2_arg2 or 0)
		f2_arg0.currentXOffset = f2_arg1
		f2_arg0.updatingScroll = true
		if IsCurrentLanguageReversed() then
			f2_arg0.textBox:setLeftRight(false, true, f2_arg0.currentXOffset - f2_arg0.totalTextWidth, f2_arg0.currentXOffset)
		else
			f2_arg0.textBox:setLeftRight(true, false, -f2_arg0.currentXOffset, f2_arg0.totalTextWidth - f2_arg0.currentXOffset)
		end
		f2_arg0.updatingScroll = false
	end
	local f1_local1 = function(f3_arg0)
		f1_local0(f3_arg0, 0)
	end
	f1_arg0.autoScrollStartDelay = 2500
	f1_arg0.autoScrollSpeed = 0.4
	f1_arg0.autoScrollEndDelay = 2500
	f1_arg0.rightStickScrollSpeed = 0.7
	f1_arg0.allowAutoScrolling = true
	f1_arg0.allowRightStickScrolling = false
	local f1_local2 = 100
	local f1_local3 = 0
	local f1_local4 = 0
	local f1_local5 = true
	f1_arg0.currentXOffset = 0
	f1_arg0.scrollDistance = 0
	local f1_local6 = function()
		f1_local4 = 0
		f1_local3 = 0
		f1_local5 = true
	end
	f1_local6()
	local f1_local7 = function()
		local f5_local0 = f1_arg0:getWidth()
		f1_arg0.totalAreaWidth = f5_local0
		f1_arg0.totalTextWidth = f1_arg0.textBox:getTextWidth()
		local f5_local1, f5_local2 = f1_arg0.textBox:getLocalSize()
		f1_arg0.textLineWidth = f5_local1
		f1_arg0.scrollDistance = f1_arg0.totalTextWidth - f5_local0
		f1_local1(f1_arg0)
		f1_local6()
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0.textBox, "setText", f1_local7)
	f1_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
		f1_local7()
		if not f1_arg0.updateTimer then
			local f6_local0 = DataSources.RightStick.getModel(f1_arg1)
			local f6_local1 = nil
			if f6_local0 then
				f6_local1 = Engine[@"getmodel"](f6_local0, "X")
			end
			f1_arg0.updateTimer = LUI.UITimer.newElementTimer(f1_local2, false, function(f7_arg0)
				local f7_local0 = 0
				if f1_arg0.allowRightStickScrolling and f6_local1 then
					f7_local0 = -Engine[@"getmodelvalue"](f6_local1) * f1_arg0.rightStickScrollSpeed / f7_arg0.timeElapsed * 1000
				end
				if math.abs(f7_local0) > 0.05 then
					f1_local3 = 0
					f1_local5 = true
				elseif f1_local5 then
					f7_local0 = 0
					f1_local3 = f1_local3 + f7_arg0.timeElapsed
					if f1_arg0.autoScrollStartDelay <= f1_local3 then
						f1_local5 = false
					end
				end
				if not f1_local5 and 0 < f1_arg0.autoScrollSpeed and f1_arg0.allowAutoScrolling then
					f7_local0 = f1_arg0.autoScrollSpeed / f7_arg0.timeElapsed * 1000
				end
				local f7_local1 = math.max(math.min(f1_arg0.currentXOffset + f7_local0, f1_arg0.scrollDistance), 0)
				local f7_local2 = f1_local2
				if f1_arg0.scrollDistance <= f7_local1 and not f1_local5 and f1_arg0.allowAutoScrolling then
					f1_local4 = f1_local4 + f7_arg0.timeElapsed
					if f1_arg0.autoScrollEndDelay <= f1_local4 then
						f1_local6()
						f7_local1 = 0
						f7_local2 = 0
					end
				end
				f1_local0(f1_arg0, f7_local1, f7_local2)
			end)
			f1_arg0:addElement(f1_arg0.updateTimer)
		end
	end))
end
CoD.TextUtility.SetupVerticalScrollingTextWidget = function(f8_arg0, f8_arg1)
	local f8_local0 = function(f9_arg0, f9_arg1, f9_arg2)
		f9_arg0.textBox:beginAnimation("move", f9_arg2 or 0)
		f9_arg0.currentYOffset = f9_arg1
		f9_arg0.updatingScroll = true
		f9_arg0.textBox:setTopBottom(true, false, -f9_arg0.currentYOffset, f9_arg0.textLineHeight - f9_arg0.currentYOffset)
		f9_arg0.updatingScroll = false
	end
	local f8_local1 = function(f10_arg0)
		f8_local0(f10_arg0, 0)
	end
	f8_arg0.autoScrollStartDelay = 5000
	f8_arg0.autoScrollSpeed = 0.4
	f8_arg0.autoScrollEndDelay = 3000
	f8_arg0.rightStickScrollSpeed = 0.7
	f8_arg0.allowAutoScrolling = true
	f8_arg0.allowRightStickScrolling = true
	local f8_local2 = 100
	local f8_local3 = 0
	local f8_local4 = 0
	local f8_local5 = true
	f8_arg0.currentYOffset = 0
	f8_arg0.scrollDistance = 0
	local f8_local6 = function()
		f8_local4 = 0
		f8_local3 = 0
		f8_local5 = true
	end
	f8_local6()
	local f8_local7 = function()
		local f12_local0, f12_local1 = f8_arg0:getLocalSize()
		f8_arg0.totalAreaHeight = f12_local1
		f8_arg0.totalTextHeight = f8_arg0.textBox.text:getTextHeightForWidth(f12_local0)
		local f12_local2, f12_local3 = f8_arg0.textBox:getLocalSize()
		f8_arg0.textLineHeight = f12_local3
		f8_arg0.scrollDistance = f8_arg0.totalTextHeight - f12_local1
		f8_local1(f8_arg0)
		f8_local6()
	end
	LUI.OverrideFunction_CallOriginalFirst(f8_arg0.textBox.text, "setText", f8_local7)
	f8_arg0:registerEventHandler("menu_loaded", function()
		f8_local7()
		if not f8_arg0.updateTimer then
			local f13_local0 = DataSources.RightStick.getModel(f8_arg1)
			local f13_local1 = nil
			if f13_local0 then
				f13_local1 = Engine[@"getmodel"](f13_local0, "Y")
			end
			f8_arg0.updateTimer = LUI.UITimer.newElementTimer(f8_local2, false, function(f14_arg0)
				local f14_local0 = 0
				if f8_arg0.allowRightStickScrolling and f13_local1 then
					f14_local0 = -Engine[@"getmodelvalue"](f13_local1) * f8_arg0.rightStickScrollSpeed / f14_arg0.timeElapsed * 1000
				end
				if math.abs(f14_local0) > 0.05 then
					f8_local3 = 0
					f8_local5 = true
				elseif f8_local5 then
					f14_local0 = 0
					f8_local3 = f8_local3 + f14_arg0.timeElapsed
					if f8_arg0.autoScrollStartDelay <= f8_local3 then
						f8_local5 = false
					end
				end
				if not f8_local5 and 0 < f8_arg0.autoScrollSpeed and f8_arg0.allowAutoScrolling then
					f14_local0 = f8_arg0.autoScrollSpeed / f14_arg0.timeElapsed * 1000
				end
				local f14_local1 = math.max(math.min(f8_arg0.currentYOffset + f14_local0, f8_arg0.scrollDistance), 0)
				local f14_local2 = f8_local2
				if f8_arg0.scrollDistance <= f14_local1 and not f8_local5 and f8_arg0.allowAutoScrolling then
					f8_local4 = f8_local4 + f14_arg0.timeElapsed
					if f8_arg0.autoScrollEndDelay <= f8_local4 then
						f8_local6()
						f14_local1 = 0
						f14_local2 = 0
					end
				end
				f8_local0(f8_arg0, f14_local1, f14_local2)
			end)
			f8_arg0:addElement(f8_arg0.updateTimer)
		end
	end)
end
CoD.TextUtility.FormatNumberWithDelimiters = function(f15_arg0)
	return Engine[@"hash_BA51654DAB171D"](f15_arg0 .. "")
end
