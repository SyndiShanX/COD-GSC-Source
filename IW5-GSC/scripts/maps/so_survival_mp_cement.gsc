/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_cement.gsc
**************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");

  if(!isDefined(level.func)) {
    level.func = [];
  }
  level.func["setanim"] = ::setanim;
  level.func["clearanim"] = ::clearanim;
  level.func["useanimtree"] = ::useanimtree;
  common_scripts\_interactive::init();
  maps\mp\mp_cement_precache::main();
  maps\createart\mp_cement_art::main();
  maps\mp\mp_cement_fx::main();
  maps\createfx\mp_cement_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_cement");
  maps\_utility::set_vision_set("mp_cement", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_cement");
  maps\_so_survival::_id_3F67();
  thread spawn_blocker_collision((166, -670, 388), (0, 270, 0));
  thread spawn_blocker_collision((166, -670, 360), (0, 270, 0));
  thread spawn_blocker_collision((166, -728, 388), (0, 270, 0));
  thread spawn_blocker_collision((166, -728, 360), (0, 270, 0));
  thread spawn_blocker_collision((166, -786, 388), (0, 270, 0));
  thread spawn_blocker_collision((166, -786, 360), (0, 270, 0));
}

spawn_blocker_collision(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.origin = var_0;
  var_2.angles = var_1 + (0, 90, 0);
  var_2 clonebrushmodeltoscriptmodel(level._id_3BB1[0]);
}