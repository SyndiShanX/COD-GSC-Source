/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_ee_pack_a_punch_unlock.gsc
***********************************************************************/

init() {
  common_scripts\utility::flag_init("pap_elevator_stage_1");
  common_scripts\utility::flag_init("pap_elevator_stage_2");
  common_scripts\utility::flag_init("pap_elevator_stage_3");
  common_scripts\utility::flag_init("pap_elevator_access_1");
  common_scripts\utility::flag_init("pap_elevator_access_2");
  common_scripts\utility::flag_init("pap_elevator_access_3");
  level.pack_a_punch_current_access_count = 0;
  common_scripts\utility::flag_init("pap_elevator_arrived");
  var_0 = ["pap_elevator_stage_1", "pap_elevator_stage_2", "pap_elevator_stage_3"];
  level thread handle_island_pack_a_punch(var_0);
  level thread init_upgrade_machine_visuals();
}

add_player_fuse_count() {
  level.pack_a_punch_current_access_count++;
  common_scripts\utility::flag_set("pap_elevator_access_" + level.pack_a_punch_current_access_count);
}

#using_animtree("animated_props_zombies");

handle_island_pack_a_punch(var_0) {
  level thread handle_fuses(var_0);
  var_1 = _getent("zmb_pack_a_punch_elevator", "targetname");
  var_2 = common_scripts\utility::_id_46B5("zmb_pack_a_punch_scripted_node", "targetname");
  var_3 = _getent("pack_a_punch_dummy", "targetname");
  var_4 = _getent("zmb_pack_a_punch_door_clip", "targetname");

  while(!isDefined(level.pap_model))
    waitframe();

  var_3.origin = (level.pap_model.origin[0] + 6.16, level.pap_model.origin[1] - 0.28, var_3.origin[2] + 2.056 - 2);
  waitframe();
  var_3 linktosynchronizedparent(var_1, "cart");
  var_5 = getEntArray("elevator_linked_prop", "targetname");

  foreach(var_7 in var_5)
  var_7 linktosynchronizedparent(var_1, "cart");

  var_1 thread open_elevator_doors(var_2);
  var_9 = [];
  var_9["zmb_elevator_cart_start_pose"] = % zmb_elevator_cart_start_pose;
  var_9["zmb_elevator_cart_move_01"] = % zmb_elevator_cart_move_01;
  var_9["zmb_elevator_cart_move_02"] = % zmb_elevator_cart_move_02;
  var_9["zmb_elevator_cart_move_03"] = % zmb_elevator_cart_move_03;
  var_1 scriptmodelplayanimdeltamotionfrompos("zmb_elevator_cart_start_pose", var_2.origin, var_2.angles, "scripted_anim");
  waitframe();
  var_10 = spawnStruct();
  var_10.eleaudcallbacks = [];
  var_10.eleaudcallbacks[0] = ::elevator_raise_1_callback;
  var_10.eleaudcallbacks[1] = ::elevator_raise_2_callback;
  var_10.eleaudcallbacks[2] = ::elevator_raise_3_callback;

  for(var_11 = 0; var_11 < var_0.size; var_11++) {
    common_scripts\utility::_id_3C9F(var_0[var_11]);
    var_1 thread[[var_10.eleaudcallbacks[var_11]]]();
    var_1 scriptmodelplayanimdeltamotionfrompos("zmb_elevator_cart_move_0" + (var_11 + 1), var_2.origin, var_2.angles, "scripted_anim");
    wait(_getanimlength(var_9["zmb_elevator_cart_move_0" + (var_11 + 1)]));
  }

  var_4 connectpaths();
  var_4 delete();
  maps\mp\gametypes\zombies::_id_47A8("DLC1_ZM_GOINGUP");
  common_scripts\utility::flag_set("pap_elevator_arrived");
  waitframe();
  var_3 delete();
  thread packapunchlight();
}

packapunchlight() {
  var_0 = _getscriptablearray("packapunchlight", "targetname");
  var_0 = var_0[0];
  var_0 setscriptablepartstate("lightpart", "on");
}

elevator_raise_1_callback() {
  _id_0378::_id_8D74("pap_elevator_move");
}

elevator_raise_2_callback() {
  _id_0378::_id_8D74("pap_elevator_move");
}

elevator_raise_3_callback() {
  _id_0378::_id_8D74("pap_elevator_move");
}

wait_for_upgrade_machine_arrived(var_0, var_1) {
  level.pap_model = var_1;
  var_1 _meth_8006(var_0);
  common_scripts\utility::_id_3C9F("pap_elevator_arrived");
}

open_elevator_doors(var_0) {
  var_1 = _getent("zmb_pack_a_punch_elevator_door", "targetname");
  var_2 = "";

  while(var_2 != "door_open")
    self waittill("scripted_anim", var_2);

  _id_0378::_id_8D74("pap_elevator_door_open");
  var_1 scriptmodelplayanimdeltamotionfrompos("zmb_elevator_door_open_02", var_0.origin, var_0.angles, "script_anim");
}

handle_fuses(var_0) {
  var_1 = common_scripts\utility::_id_46B5("elevator_trigger_pap", "targetname");
  var_2 = common_scripts\utility::_id_44BE(var_1.target, "targetname");
  var_1.fuse_spawns = [];
  var_1.fuse_spawns_start_structs = [];

  foreach(var_4 in var_2) {
    switch (var_4._id_0165) {
      case "elevator_electroschnell_trig":
        var_1._id_9D65 = var_4;
        break;
      case "elevator_electroschnell":
        var_1.fuse_spawns[var_4.setanimknobrestart - 1] = var_4;
        var_4 hide();
        break;
      case "elevator_electroschnell_dest":
        var_1.fuse_spawns_start_structs[var_4.setanimknobrestart - 1] = var_4;
        break;
    }
  }

  var_1._id_9D65 _meth_8660(1, var_1.fuse_spawns[1].origin);
  var_1._id_9D65 sethintstring(&"ZOMBIE_ISLAND_PAP_INSERT");
  var_1 show_fuse(0);
  var_1._id_9D65 waittill("trigger", var_6);
  var_1._id_9D65 common_scripts\utility::_id_9D9F();
  set_upgrade_machine_visuals(1);
  var_6 thread _id_0367::_id_8E3C("elevatorhint");
  var_1 insert_fuse(0);

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    common_scripts\utility::_id_3C9F("pap_elevator_access_" + (var_7 + 1));
    var_1._id_9D65 common_scripts\utility::_id_9DA3();
    var_1._id_9D65 thread wait_for_user_electroschnell_insert(var_0[var_7], var_7);
    common_scripts\utility::_id_3C9F(var_0[var_7]);
    var_1._id_9D65 common_scripts\utility::_id_9D9F();
    var_1 show_fuse(var_7 + 1);
    var_1 insert_fuse(var_7 + 1);
    set_upgrade_machine_visuals(var_7 + 2);
    wait 0.75;
  }

  var_1._id_9D65 common_scripts\utility::_id_9D9F();
}

show_fuse(var_0) {
  self.fuse_spawns[var_0]._id_6C4E = self.fuse_spawns[var_0].origin;
  self.fuse_spawns[var_0].origin = self.fuse_spawns_start_structs[var_0].origin;
  self.fuse_spawns[var_0] show();
}

insert_fuse(var_0) {
  self.fuse_spawns[var_0] moveto(self.fuse_spawns[var_0]._id_6C4E, 1);

  if(var_0 <= 2)
    self.fuse_spawns[var_0] _id_0378::_id_8D74("pap_schell_insert");
  else if(var_0 == 3)
    self.fuse_spawns[var_0] _id_0378::_id_8D74("pap_schell_insert_final");
}

wait_for_user_electroschnell_insert(var_0, var_1) {
  self waittill("trigger", var_2);

  switch (var_1) {
    case 0:
      var_2 thread _id_0367::_id_8E3C("papcircuit");
      break;
    case 1:
      var_2 thread _id_0367::_id_8E3C("papcircuitsecond");
      break;
    case 2:
      var_2 thread _id_0367::_id_8E3C("papcircuitadd");
      break;
  }

  common_scripts\utility::_id_9D9F();
  common_scripts\utility::flag_set(var_0);
}

init_upgrade_machine_visuals() {
  if(!isDefined(level.zmb_pack_a_punch_fuse_box))
    level.zmb_pack_a_punch_fuse_box = _getent("fuse_machine", "script_noteworthy");

  level.zmb_pack_a_punch_fuse_box set_light(1, "RED");
  level.zmb_pack_a_punch_fuse_box set_light(2, "RED");
  level.zmb_pack_a_punch_fuse_box set_light(3, "RED");
  level.zmb_pack_a_punch_fuse_box set_light(4, "RED");
  level.zmb_pack_a_punch_fuse_box showpart("TAG_LIGHT_RED_01");
  level.zmb_pack_a_punch_fuse_box hidepart("TAG_LIGHT_GREEN_01");
}

set_upgrade_machine_visuals(var_0) {
  if(!isDefined(level.zmb_pack_a_punch_fuse_box))
    level.zmb_pack_a_punch_fuse_box = _getent("fuse_machine", "script_noteworthy");

  level.zmb_pack_a_punch_fuse_box set_light(var_0, "GREEN");
}

set_light(var_0, var_1) {
  self hidepart("TAG_LIGHT_GREEN_0" + var_0);
  self hidepart("TAG_LIGHT_RED_0" + var_0);
  self showpart("TAG_LIGHT_" + var_1 + "_0" + var_0);
}