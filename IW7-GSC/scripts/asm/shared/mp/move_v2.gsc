/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\shared\mp\move_v2.gsc
*********************************************/

waitforsharpturnv2(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  self waittill("path_dir_change", var_03);
  var_04 = [var_03, 0];
  scripts\asm\asm::asm_fireevent(param_01, "sharp_turn", var_04);
  thread lib_0F3C::func_136E7(param_00, param_01, param_02);
}

playmoveloopv2(param_00, param_01, param_02, param_03) {
  thread lib_0F3C::func_136B4(param_00, param_01, param_03);
  thread waitforsharpturnv2(param_00, param_01, param_03);
  thread lib_0F3C::func_136CC(param_00, param_01, param_03);
  var_04 = 1;
  if(isDefined(self.asm.moveplaybackrate)) {
    var_04 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var_04 = self.moveplaybackrate;
  }

  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, var_04);
}

playsharpturnanimv2(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self.var_FC61 = undefined;
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", self.angles);
  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  if(isDefined(self.moveplaybackrate)) {
    scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, self.moveplaybackrate, param_01, "code_move", var_05);
  } else {
    scripts\mp\agents\_scriptedagents::func_CED5(param_01, var_04, param_01, "code_move", var_05);
  }

  self orientmode("face motion");
  self ghostlaunched("code_move");
}