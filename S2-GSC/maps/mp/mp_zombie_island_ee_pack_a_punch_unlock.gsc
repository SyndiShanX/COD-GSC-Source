/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_ee_pack_a_punch_unlock.gsc
***************************************************************/

init() {
  common_scripts\utility::flag_init("pap_elevator_stage_1");
  common_scripts\utility::flag_init("pap_elevator_stage_2");
  common_scripts\utility::flag_init("pap_elevator_stage_3");
  common_scripts\utility::flag_init("pap_elevator_access_1");
  common_scripts\utility::flag_init("pap_elevator_access_2");
  common_scripts\utility::flag_init("pap_elevator_access_3");
  level.pack_a_punch_current_access_count = 0;
  common_scripts\utility::flag_init("pap_elevator_arrived");
  var_00 = ["pap_elevator_stage_1", "pap_elevator_stage_2", "pap_elevator_stage_3"];
  level thread handle_island_pack_a_punch(var_00);
  level thread init_upgrade_machine_visuals();
}

add_player_fuse_count() {
  level.pack_a_punch_current_access_count++;
  common_scripts\utility::flag_set("pap_elevator_access_" + level.pack_a_punch_current_access_count);
}

handle_island_pack_a_punch(param_00) {
  level thread handle_fuses(param_00);
  var_01 = getEnt("zmb_pack_a_punch_elevator", "targetname");
  var_02 = common_scripts\utility::func_46B5("zmb_pack_a_punch_scripted_node", "targetname");
  var_03 = getEnt("pack_a_punch_dummy", "targetname");
  var_04 = getEnt("zmb_pack_a_punch_door_clip", "targetname");
  while(!isDefined(level.pap_model)) {
    wait 0.05;
  }

  var_03.origin = (level.pap_model.origin[0] + 6.16, level.pap_model.origin[1] - 0.28, var_03.origin[2] + 2.056 - 2);
  wait 0.05;
  var_03 linktosynchronizedparent(var_01, "cart");
  var_05 = getEntArray("elevator_linked_prop", "targetname");
  foreach(var_07 in var_05) {
    var_07 linktosynchronizedparent(var_01, "cart");
  }

  var_01 thread open_elevator_doors(var_02);
  var_09 = [];
  var_09["zmb_elevator_cart_start_pose"] = % zmb_elevator_cart_start_pose;
  var_09["zmb_elevator_cart_move_01"] = % zmb_elevator_cart_move_01;
  var_09["zmb_elevator_cart_move_02"] = % zmb_elevator_cart_move_02;
  var_09["zmb_elevator_cart_move_03"] = % zmb_elevator_cart_move_03;
  var_01 method_8495("zmb_elevator_cart_start_pose", var_02.origin, var_02.angles, "scripted_anim");
  wait 0.05;
  var_0A = spawnStruct();
  var_0A.eleaudcallbacks = [];
  var_0A.eleaudcallbacks[0] = ::elevator_raise_1_callback;
  var_0A.eleaudcallbacks[1] = ::elevator_raise_2_callback;
  var_0A.eleaudcallbacks[2] = ::elevator_raise_3_callback;
  for(var_0B = 0; var_0B < param_00.size; var_0B++) {
    common_scripts\utility::func_3C9F(param_00[var_0B]);
    var_01 thread[[var_0A.eleaudcallbacks[var_0B]]]();
    var_01 method_8495("zmb_elevator_cart_move_0" + var_0B + 1, var_02.origin, var_02.angles, "scripted_anim");
    wait(getanimlength(var_09["zmb_elevator_cart_move_0" + var_0B + 1]));
  }

  var_04 connectpaths();
  var_04 delete();
  maps / mp / gametypes / zombies::func_47A8("DLC1_ZM_GOINGUP");
  common_scripts\utility::flag_set("pap_elevator_arrived");
  wait 0.05;
  var_03 delete();
  thread packapunchlight();
}

packapunchlight() {
  var_00 = function_021F("packapunchlight", "targetname");
  var_00 = var_00[0];
  var_00 setscriptablepartstate("lightpart", "on");
}

elevator_raise_1_callback() {
  lib_0378::func_8D74("pap_elevator_move");
}

elevator_raise_2_callback() {
  lib_0378::func_8D74("pap_elevator_move");
}

elevator_raise_3_callback() {
  lib_0378::func_8D74("pap_elevator_move");
}

wait_for_upgrade_machine_arrived(param_00, param_01) {
  level.pap_model = param_01;
  param_01 hidefromclient(param_00);
  common_scripts\utility::func_3C9F("pap_elevator_arrived");
}

open_elevator_doors(param_00) {
  var_01 = getEnt("zmb_pack_a_punch_elevator_door", "targetname");
  var_02 = "";
  while(var_02 != "door_open") {
    self waittill("scripted_anim", var_02);
  }

  lib_0378::func_8D74("pap_elevator_door_open");
  var_01 method_8495("zmb_elevator_door_open_02", param_00.origin, param_00.angles, "script_anim");
}

handle_fuses(param_00) {
  var_01 = common_scripts\utility::func_46B5("elevator_trigger_pap", "targetname");
  var_02 = common_scripts\utility::func_44BE(var_01.target, "targetname");
  var_01.fuse_spawns = [];
  var_01.fuse_spawns_start_structs = [];
  foreach(var_04 in var_02) {
    switch (var_04.script_noteworthy) {
      case "elevator_electroschnell_trig":
        var_01.var_9D65 = var_04;
        break;

      case "elevator_electroschnell":
        var_01.fuse_spawns[var_04.var_8140 - 1] = var_04;
        var_04 hide();
        break;

      case "elevator_electroschnell_dest":
        var_01.fuse_spawns_start_structs[var_04.var_8140 - 1] = var_04;
        break;
    }
  }

  var_01.var_9D65 usetouchtriggerrequirefacingposition(1, var_01.fuse_spawns[1].origin);
  var_01.var_9D65 setHintString(&"ZOMBIE_ISLAND_PAP_INSERT");
  var_01 show_fuse(0);
  var_01.var_9D65 waittill("trigger", var_06);
  var_01.var_9D65 common_scripts\utility::func_9D9F();
  set_upgrade_machine_visuals(1);
  var_06 thread lib_0367::func_8E3C("elevatorhint");
  var_01 insert_fuse(0);
  for(var_07 = 0; var_07 < param_00.size; var_07++) {
    common_scripts\utility::func_3C9F("pap_elevator_access_" + var_07 + 1);
    var_01.var_9D65 common_scripts\utility::func_9DA3();
    var_01.var_9D65 thread wait_for_user_electroschnell_insert(param_00[var_07], var_07);
    common_scripts\utility::func_3C9F(param_00[var_07]);
    var_01.var_9D65 common_scripts\utility::func_9D9F();
    var_01 show_fuse(var_07 + 1);
    var_01 insert_fuse(var_07 + 1);
    set_upgrade_machine_visuals(var_07 + 2);
    wait(0.75);
  }

  var_01.var_9D65 common_scripts\utility::func_9D9F();
}

show_fuse(param_00) {
  self.fuse_spawns[param_00].var_6C4E = self.fuse_spawns[param_00].origin;
  self.fuse_spawns[param_00].origin = self.fuse_spawns_start_structs[param_00].origin;
  self.fuse_spawns[param_00] show();
}

insert_fuse(param_00) {
  self.fuse_spawns[param_00] moveTo(self.fuse_spawns[param_00].var_6C4E, 1);
  if(param_00 <= 2) {
    self.fuse_spawns[param_00] lib_0378::func_8D74("pap_schell_insert");
    return;
  }

  if(param_00 == 3) {
    self.fuse_spawns[param_00] lib_0378::func_8D74("pap_schell_insert_final");
  }
}

wait_for_user_electroschnell_insert(param_00, param_01) {
  self waittill("trigger", var_02);
  switch (param_01) {
    case 0:
      var_02 thread lib_0367::func_8E3C("papcircuit");
      break;

    case 1:
      var_02 thread lib_0367::func_8E3C("papcircuitsecond");
      break;

    case 2:
      var_02 thread lib_0367::func_8E3C("papcircuitadd");
      break;
  }

  common_scripts\utility::func_9D9F();
  common_scripts\utility::flag_set(param_00);
}

init_upgrade_machine_visuals() {
  if(!isDefined(level.zmb_pack_a_punch_fuse_box)) {
    level.zmb_pack_a_punch_fuse_box = getEnt("fuse_machine", "script_noteworthy");
  }

  level.zmb_pack_a_punch_fuse_box set_light(1, "RED");
  level.zmb_pack_a_punch_fuse_box set_light(2, "RED");
  level.zmb_pack_a_punch_fuse_box set_light(3, "RED");
  level.zmb_pack_a_punch_fuse_box set_light(4, "RED");
  level.zmb_pack_a_punch_fuse_box showpart("TAG_LIGHT_RED_01");
  level.zmb_pack_a_punch_fuse_box hidepart("TAG_LIGHT_GREEN_01");
}

set_upgrade_machine_visuals(param_00) {
  if(!isDefined(level.zmb_pack_a_punch_fuse_box)) {
    level.zmb_pack_a_punch_fuse_box = getEnt("fuse_machine", "script_noteworthy");
  }

  level.zmb_pack_a_punch_fuse_box set_light(param_00, "GREEN");
}

set_light(param_00, param_01) {
  self hidepart("TAG_LIGHT_GREEN_0" + param_00);
  self hidepart("TAG_LIGHT_RED_0" + param_00);
  self showpart("TAG_LIGHT_" + param_01 + "_0" + param_00);
}