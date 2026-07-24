/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_arrival.gsc
*************************************************************/

_id_3B81() {
  scripts\engine\utility::flag_set("mons_guns_down_end");
  scripts\engine\utility::flag_set("yard_obj_clear_path_done");
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B3B();
}

_id_BA8B() {
  scripts\sp\utility::_id_F5AF("jumpto_mons_guns_down", [level.player]);
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(1, 1, 1, undefined, 1);
  level.player allowmovement(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_fire(0);
  level.player disableweapons();
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 65, 65, 2, 8);
  level thread scripts\sp\maps\heistspace\heistspace_om130::_id_C421(1);
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_mons_guns_down");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_7657();
}

_id_BA87() {
  scripts\sp\utility::_id_2669("heistspace_om_done");
  setmusicstate("");
  level thread _id_BA8C();
  level thread _id_BA8A();
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(0);
  wait 2.5;
  level._id_2FF1 thread scripts\sp\maps\heistspace\heistspace_util::_id_AED6();
  level thread _id_30BF();
  scripts\engine\utility::flag_wait("mons_guns_down_end");
  level._id_2FF1 thread scripts\sp\maps\heistspace\heistspace_util::_id_12BD3();
  var_0 = getEnt("bridge_elevator_door_blocker", "targetname");

  if(isDefined(var_0)) {
    var_0 connectpaths();
    var_0 scripts\sp\utility::_id_8E9A();
  }
}

_id_30BF() {
  var_0 = getEnt("bridge_opsmap_scriptable", "targetname");
  var_0 setscriptablepartstate("glass", "broken");
}

_id_BA8A() {
  level.player thread _id_12BB2();
  level.player lerpviewangleclamp(1.0, 0, 0.5, 0, 0, 0, 0);
  var_0 = [];
  var_0[0] = level._id_EA2C;
  var_0[1] = level._id_6754;
  var_0[2] = level._id_30F6;
  var_0[3] = level._id_A54E;
  var_0[4] = level._id_D267;
  var_1 = scripts\engine\utility::getStruct("om_leave_bridge_animnode", "targetname");
  var_1 notify("end_ethan_bridge_loop");
  var_1 notify("end_brooks_bridge_loop");
  var_1 notify("end_kashima_bridge_loop");
  var_1 notify("end_salter_bridge_loop");
  level._id_6754 thread _id_BA89(var_1);
  level._id_30F6 thread _id_BA89(var_1);
  level._id_A54E thread _id_BA89(var_1);
  level._id_30F6 thread scripts\sp\utility::_id_DC45("raise");
  level._id_A54E thread scripts\sp\utility::_id_DC45("raise");
  level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");
  thread _id_BA88();
  var_1 thread scripts\sp\anim::_id_1F2C(var_0, "bridge_pcap");
  level._id_EA2C waittillmatch("single anim", "end");
  level._id_EA2C thread scripts\sp\utility::_id_DC45("lower");
  scripts\engine\utility::flag_set("yard_obj_clear_path_done");
  scripts\engine\utility::flag_set("mons_guns_down_end");
}

_id_BA88() {
  _id_0B0A::_id_583F(0, 0.25, 3.9, 60.75, 366.69, 2.607, 1.5);
  var_0 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("bridge_pcap"));
  wait(var_0 - 3.0);
  _id_0B0A::_id_583D(1.5);
}

_id_BA89(var_0) {
  self waittillmatch("single anim", "end");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "bridge_pcap_loop", "end_bridge_loop");
}

_id_12BB2() {
  level._id_D267 waittillmatch("single anim", "end");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_30C8();
  self unlink();
  level._id_D267 delete();
  self allowmovement(1);
  scripts\engine\utility::allow_jump(1);
  scripts\engine\utility::allow_prone(1);
  scripts\engine\utility::allow_crouch(1);
  scripts\engine\utility::allow_fire(1);
  scripts\sp\utility::_id_F526("relaxed");
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::waitframe();
  self enableweapons();
}

_id_BA8C() {
  level._id_A54E waittillmatch("single anim", "sd_heistspace_ksh_yesmaam");
  wait 0.5;
  scripts\sp\utility::_id_1034D("heistspace_plr_ethanyougotthec");
  scripts\engine\utility::flag_set("guns_down_vo_complete");
}