/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_focus_test.gsc
************************************************************/

main() {
  level._id_6662 = common_scripts\utility::_id_46B7("objective_testing_spawners", "targetname");
  level._id_6664 = common_scripts\utility::_id_46B7("objective_testing_spawners_salt", "targetname");
  level._id_6663 = common_scripts\utility::_id_46B7("objective_testing_spawners_com", "targetname");
  level._id_6661 = common_scripts\utility::_id_46B7("objective_testing_spawners_blimp", "targetname");
}

_id_3DA6() {
  thread maps\mp\mp_zombie_nest_ee_quicktest::_id_0CAE("teslagun_zm", "stg44_pap_zm", 5000, 7);
  level._id_66D6 = 11;
  level thread _id_8C92();
  level thread _id_057D::_id_4769();
  wait 1;
  level._id_76CE = 1;
  common_scripts\utility::flag_set("5 Right Hand fuses");
  _id_0557::_id_782D("1 fire well", "gas flowing");
  maps\mp\mp_zombie_nest_ee_fire_well::_id_7854();
}

_id_3DA4() {
  thread maps\mp\mp_zombie_nest_ee_quicktest::_id_0CAE("teslagun_zm", "stg44_pap_zm", 5000, 5);
  level._id_66D6 = 8;
  level thread _id_8C92();
  level thread _id_057D::_id_4769();
}

_id_8C92() {
  if(isDefined(level._id_66D6))
    level._id_A981 = level._id_66D6 - 1;

  level._id_ABEC maps\mp\_utility::_id_5DC7();
  level._id_ABED maps\mp\_utility::_id_5DC7();
  level._id_AC12 maps\mp\_utility::_id_5DC7();
  var_0 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_2 in var_0) {
    if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_boss_village")) {
      continue;
    }
    var_2 suicide();
  }

  level notify("skipWave");
}