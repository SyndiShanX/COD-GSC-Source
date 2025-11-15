/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\zombie_dlc1\zipline_traversal.gsc
*********************************************************/

playtraversezipline(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoTraverse");
  self.do_immediate_ragdoll_save = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  playtraverseziplineinternal(param_00, param_01, var_04);
}

get_closest_zipline_traversal(param_00) {
  var_01 = 16384;
  foreach(var_03 in level.zipline_traversals) {
    if(distance2dsquared(var_03.traversal_start, param_00) < var_01) {
      return var_03;
    }
  }

  return undefined;
}

playtraverseziplineinternal(param_00, param_01, param_02) {
  var_03 = param_02;
  var_04 = self getsafecircleorigin(param_01, var_03);
  var_05 = getnotetracktimes(var_04, "flex_height_up_end");
  var_06 = get_closest_zipline_traversal(self.origin);
  self.zipline = var_06;
  var_07 = var_06.var_13EFC.origin + (0, 0, -84);
  var_08 = scripts\asm\asm::func_2341(param_00, param_01);
  var_09 = vectortoangles(var_06.var_13EFB.origin - var_06.var_13EFC.origin);
  var_09 = (0, var_09[1], 0);
  self orientmode("face angle abs", var_09);
  self gib_fx_override("noclip");
  self ghostlaunched("anim deltas");
  scripts\mp\agents\_scriptedagents::func_CED5(param_01, var_03, param_01, "flex_height_up_start", undefined);
  scripts\mp\agents\_scriptedagents::func_5AC2(param_01, var_03, param_01, var_04, "flex_height_up_start", "flex_height_up_end", var_07, var_05[0]);
  attach_to_zipline_and_go();
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_03, 1, param_01, "end", undefined);
  self.angles = var_09;
}

attach_to_zipline_and_go() {
  self.zipline_ent = spawn("script_model", self.origin);
  self.zipline_ent setModel("tag_origin");
  self.zipline_ent.angles = self.angles;
  self linkto(self.zipline_ent, "tag_origin");
  var_00 = self.zipline.var_13EFC.origin + (0, 0, -84);
  var_01 = self.zipline.var_13EFB.origin + (0, 0, -84);
  var_02 = distance(var_00, var_01);
  var_03 = 500;
  var_04 = int(var_02 / var_03);
  self.zipline_ent moveto(var_01, var_04, 2);
  self.zipline.var_6393 = gettime() + int(var_04 * 1000);
}

playtraverseziplineloop(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self playLoopSound("rave_zombie_zipline_lp");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  self setanimstate(param_01, var_04, 1);
  var_06 = self.zipline.var_6393 - gettime();
  if(var_06 > 0) {
    wait(var_06 / 1000);
  }

  scripts\asm\asm::asm_fireevent(param_01, "loop_finished");
}

playtraverseziplinedrop(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self playSound("rave_zombie_zipline_stop");
  self stoploopsound("rave_zombie_zipline_lp");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getnotetracktimes(var_05, "flex_height_down_end");
  var_07 = self.zipline.traversal_end;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, 2, param_01, "flex_height_down_start", undefined);
  scripts\mp\agents\_scriptedagents::func_5AC2(param_01, var_04, param_01, var_05, "flex_height_down_start", "flex_height_down_end", var_07, var_06[0], undefined);
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, 1.5, param_01, "end", undefined);
  self gib_fx_override("gravity");
  self.is_traversing = undefined;
  self notify("traverse_end");
  thread scripts\asm\zombie\zombie::func_11701(param_00, param_01);
}

terminateziplineintro(param_00, param_01, param_02) {
  if(!isalive(self) && isDefined(self.zipline_ent)) {
    self unlink();
    self.zipline_ent delete();
  }
}

terminateziplineloop(param_00, param_01, param_02) {
  if(isDefined(self.zipline_ent)) {
    self unlink();
    self.zipline_ent delete();
  }
}

terminatezipline(param_00, param_01, param_02) {
  self.do_immediate_ragdoll = self.do_immedate_ragdoll_save;
  self.do_immedate_ragdoll_save = undefined;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
  self.zipline = undefined;
  self.zipline_arm = undefined;
}

chooseanimzipline(param_00, param_01, param_02) {
  var_03 = ["left", "right"];
  if(!isDefined(self.zipline_arm)) {
    if(lib_0C72::func_9EA4()) {
      self.zipline_arm = "right";
    } else if(lib_0C72::func_9EA5()) {
      self.zipline_arm = "left";
    } else {
      self.zipline_arm = var_03[randomint(var_03.size)];
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.zipline_arm);
}