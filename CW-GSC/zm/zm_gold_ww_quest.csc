/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold_ww_quest.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace zm_gold_ww_quest;

function init() {
  clientfield::register("world", "" + # "hash_e3e178ca4bfed0a", 16000, 1, "int", &function_770151a9, 0, 0);
  clientfield::register("world", "" + # "hash_4bbd14acfb65a055", 16000, 1, "counter", &function_e9ae3d81, 0, 0);
  clientfield::register("world", "" + # "hash_6ad15545c118bf44", 16000, 6, "int", &function_9b54b294, 0, 0);
  clientfield::register("world", "" + # "play_charge_fx", 16000, 1, "int", &play_charge_fx, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_438f8800ecce6fba", 16000, 1, "int", &function_b5268151, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_631477f00832803c", 16000, 1, "int", &function_aa1d2bf6, 0, 0);
}

function play_charge_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_7f49111b = getent(fieldname, "power_cell_charge_base", "targetname");

  if(isDefined(var_7f49111b.var_d3c6a366)) {
    stopfx(fieldname, var_7f49111b.var_d3c6a366);
    var_7f49111b.var_d3c6a366 = undefined;
  }

  if(bwasdemojump == 1 && isDefined(var_7f49111b)) {
    var_7f49111b.var_d3c6a366 = playFX(fieldname, #"hash_7ac1bd398f0f3d90", var_7f49111b.origin, anglesToForward(var_7f49111b.angles), anglestoup(var_7f49111b.angles));
  }
}

function function_b5268151(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    var_3e0b2cbd = self gettagorigin("tag_scanner");
    var_8946daad = (20, 0, 0);
    self.var_1e7bc717 = playFX(fieldname, #"hash_6dd20a5f232201ca", var_3e0b2cbd, anglesToForward(var_8946daad), anglestoup(var_8946daad));
  }
}

function function_770151a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel(#"p9_zm_gold_screen_board_01");
    forcestreamxmodel(#"p9_zm_gold_screen_board_01_red");
    forcestreamxmodel(#"p9_zm_gold_screen_board_02");
    forcestreamxmodel(#"p9_zm_gold_screen_board_03");
    return;
  }

  stopforcestreamingxmodel(#"p9_zm_gold_screen_board_01");
  stopforcestreamingxmodel(#"p9_zm_gold_screen_board_01_red");
  stopforcestreamingxmodel(#"p9_zm_gold_screen_board_02");
  stopforcestreamingxmodel(#"p9_zm_gold_screen_board_03");
}

function function_e9ae3d81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_14db7cdb = getent(bwasdemojump, "ww_quest_computer_screen", "targetname");
  var_14db7cdb setModel(#"p9_zm_gold_screen_board_01");
}

function function_9b54b294(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_14db7cdb = getent(fieldname, "ww_quest_computer_screen", "targetname");
  var_14db7cdb setModel(#"p9_zm_gold_screen_board_01");
  waitframe(1);

  if(bwasdemojump) {
    b_clockwise = (bwasdemojump & 32) == 0;
    var_14db7cdb thread function_5d7d4dd0(fieldname, bwasdemojump & 31, b_clockwise);
    return;
  }

  var_14db7cdb notify(#"turn_off");
  level.var_4965c181[fieldname] = undefined;
  playSound(fieldname, #"hash_30c83800bc972d7a", var_14db7cdb gettagorigin("tag_screen_fx"));

  if(isDefined(level.var_838bf3b1[fieldname])) {
    level.var_838bf3b1[fieldname] delete();
  }

  if(isDefined(level.var_3e560871[fieldname])) {
    level.var_3e560871[fieldname] delete();
  }
}

function private function_5d7d4dd0(localclientnum, var_76f1881e, b_clockwise = 1) {
  assert(var_76f1881e > 0 && var_76f1881e <= 20);
  v_center = self gettagorigin("tag_screen_fx");

  if(!isDefined(level.var_838bf3b1[localclientnum])) {
    level.var_838bf3b1[localclientnum] = util::spawn_model(localclientnum, #"p9_zm_gold_screen_board_02", v_center);
  }

  if(!isDefined(level.var_3e560871[localclientnum])) {
    level.var_3e560871[localclientnum] = util::spawn_model(localclientnum, #"p9_zm_gold_screen_board_03", v_center);
  }

  if(!isDefined(level.var_4965c181[localclientnum])) {
    level.var_4965c181[localclientnum] = 0;
    level function_b2061f2f(1, localclientnum);
  }

  self function_5824b6e(var_76f1881e, b_clockwise, localclientnum);
}

function function_5824b6e(var_76f1881e, b_clockwise, localclientnum) {
  level endon(#"end_game");
  self endon(#"death", #"turn_off");

  do {
    wait 0.5;
    level function_b2061f2f(b_clockwise, localclientnum);
  }
  while(level.var_4965c181[localclientnum] != var_76f1881e);

  level.var_838bf3b1[localclientnum] playSound(localclientnum, #"hash_b1ecaea59103899");
}

function function_b2061f2f(b_clockwise, localclientnum) {
  if(b_clockwise) {
    level.var_4965c181[localclientnum]++;

    if(level.var_4965c181[localclientnum] > 20) {
      level.var_4965c181[localclientnum] -= 20;
    }
  } else {
    level.var_4965c181[localclientnum]--;

    if(level.var_4965c181[localclientnum] <= 0) {
      level.var_4965c181[localclientnum] += 20;
    }
  }

  var_9085056e = level.var_838bf3b1[localclientnum];
  var_f6f1e92e = level.var_3e560871[localclientnum];
  var_9085056e playSound(localclientnum, #"hash_3d0cf473b49c2cb3");
  n_angle = (level.var_4965c181[localclientnum] - 1) * -1 * 18;

  if(level.var_4965c181[localclientnum] % 2) {
    var_f6f1e92e.angles = (var_f6f1e92e.angles[0], var_f6f1e92e.angles[1], n_angle);
    var_f6f1e92e show();
    var_9085056e hide();
    return;
  }

  var_9085056e.angles = (var_9085056e.angles[0], var_9085056e.angles[1], n_angle);
  var_9085056e show();
  var_f6f1e92e hide();
}

function function_aa1d2bf6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"end_game");

  if(bwasdemojump) {
    var_79bb44c5 = util::spawn_model(fieldname, #"p9_zm_gold_dart_board_02", self.origin, self.angles);
    board_rotate_origin = getent(fieldname, "board_rotate_origin", "targetname");
    var_79bb44c5 linkto(board_rotate_origin);
    board_rotate_origin rotateto(board_rotate_origin.angles + (0, 90, 0), 3);
    var_79bb44c5 playSound(fieldname, #"hash_1500984cecfd6a57");
  }
}