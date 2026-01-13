/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\zombie_dlc4\zipline_traversal.gsc
*********************************************************/

playtraversezipline(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoTraverse");
  self.do_immediate_ragdoll_save = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  playtraverseziplineinternal(var_0, var_1, var_4);
}

get_closest_zipline_traversal(var_0) {
  var_1 = 16384;
  foreach(var_3 in level.zipline_traversals) {
    if(distance2dsquared(var_3.traversal_start, var_0) < var_1) {
      return var_3;
    }
  }

  return undefined;
}

playtraverseziplineinternal(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = self getsafecircleorigin(var_1, var_3);
  var_5 = getnotetracktimes(var_4, "flex_height_up_end");
  var_6 = get_closest_zipline_traversal(self.origin);
  self.zipline = var_6;
  var_7 = var_6.var_13EFC.origin + (0, 0, -84);
  var_8 = scripts\asm\asm::func_2341(var_0, var_1);
  var_9 = vectortoangles(var_6.var_13EFB.origin - var_6.var_13EFC.origin);
  var_9 = (0, var_9[1], 0);
  self orientmode("face angle abs", var_9);
  self gib_fx_override("noclip");
  self ghostlaunched("anim deltas");
  scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_3, var_1, "flex_height_up_start", undefined);
  scripts\mp\agents\_scriptedagents::func_5AC2(var_1, var_3, var_1, var_4, "flex_height_up_start", "flex_height_up_end", var_7, var_5[0]);
  attach_to_zipline_and_go();
  scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_3, 1, var_1, "end", undefined);
  self.angles = var_9;
}

attach_to_zipline_and_go() {
  self.zipline_ent = spawn("script_model", self.origin);
  self.zipline_ent setModel("tag_origin");
  self.zipline_ent.angles = self.angles;
  self linkto(self.zipline_ent, "tag_origin");
  var_0 = self.zipline.var_13EFC.origin + (0, 0, -84);
  var_1 = self.zipline.var_13EFB.origin + (0, 0, -84);
  var_2 = distance(var_0, var_1);
  var_3 = 500;
  var_4 = int(var_2 / var_3);
  self.zipline_ent moveto(var_1, var_4, 2);
  self.zipline.var_6393 = gettime() + int(var_4 * 1000);
}

playtraverseziplineloop(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  self setanimstate(var_1, var_4, 1);
  var_6 = self.zipline.var_6393 - gettime();
  if(var_6 > 0) {
    wait(var_6 / 1000);
  }

  scripts\asm\asm::asm_fireevent(var_1, "loop_finished");
}

playtraverseziplinedrop(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getnotetracktimes(var_5, "flex_height_down_end");
  var_7 = self.zipline.traversal_end;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_4, var_1, "flex_height_down_start", undefined);
  scripts\mp\agents\_scriptedagents::func_5AC2(var_1, var_4, var_1, var_5, "flex_height_down_start", "flex_height_down_end", var_7, var_6[0], undefined);
  scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_4, 1, var_1, "end", undefined);
  thread scripts\asm\zombie\zombie::func_11701(var_0, var_1);
}

terminateziplineintro(var_0, var_1, var_2) {
  if(!isalive(self) && isDefined(self.zipline_ent)) {
    self unlink();
    self.zipline_ent delete();
  }
}

terminateziplineloop(var_0, var_1, var_2) {
  if(isDefined(self.zipline_ent)) {
    self unlink();
    self.zipline_ent delete();
  }
}

terminatezipline(var_0, var_1, var_2) {
  self.do_immediate_ragdoll = self.do_immedate_ragdoll_save;
  self.do_immedate_ragdoll_save = undefined;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
  self.zipline = undefined;
}

chooseanimzipline(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}