/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\shared\mp\move_v2.gsc
*********************************************/

waitforsharpturnv2(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self waittill("path_dir_change", var_3);
  var_4 = [var_3, 0];
  scripts\asm\asm::asm_fireevent(var_1, "sharp_turn", var_4);
  thread lib_0F3C::func_136E7(var_0, var_1, var_2);
}

playmoveloopv2(var_0, var_1, var_2, var_3) {
  thread lib_0F3C::func_136B4(var_0, var_1, var_3);
  thread waitforsharpturnv2(var_0, var_1, var_3);
  thread lib_0F3C::func_136CC(var_0, var_1, var_3);
  var_4 = 1;
  if(isDefined(self.asm.moveplaybackrate)) {
    var_4 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var_4 = self.moveplaybackrate;
  }

  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, var_4);
}

playsharpturnanimv2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self.var_FC61 = undefined;
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", self.angles);
  var_5 = scripts\asm\asm::func_2341(var_0, var_1);
  if(isDefined(self.moveplaybackrate)) {
    scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_4, self.moveplaybackrate, var_1, "code_move", var_5);
  } else {
    scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_4, var_1, "code_move", var_5);
  }

  self orientmode("face motion");
  self ghostlaunched("code_move");
}