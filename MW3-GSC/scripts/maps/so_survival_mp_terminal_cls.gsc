/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_terminal_cls.gsc
********************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_terminal_cls_precache::main();
  maps\mp\mp_terminal_cls_precache::main();
  maps\createart\mp_terminal_cls_art::main();
  maps\mp\mp_terminal_cls_fx::main();
  maps\createfx\mp_terminal_cls_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  maps\_utility::set_vision_set("mp_terminal_cls", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_terminal_cls");
  maps\_so_survival::_id_3F67();
  var_0 = getEntArray("plane_belly_clip", "targetname");

  foreach(var_2 in var_0) {}
  var_2 connectpaths();

  level thread break_windows();
  level thread dog_at_plane_ladder();
}

break_windows() {
  var_0 = common_scripts\utility::getstructarray("window_break", "targetname");

  foreach(var_2 in var_0) {}
  glassradiusdamage(var_2.origin, 64.0, 500, 500);
}

dog_at_plane_ladder() {
  var_0 = getent("dog_at_plane_ladder", "targetname");
  var_1 = getent("plane_ladder_clip", "targetname");
  var_1 maps\_utility::_id_27C5();
  var_1 connectpaths();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isDefined(var_2) && isDefined(var_2.type) && var_2.type == "dog") {
      var_1 maps\_utility::_id_27C6();
      var_1 disconnectpaths();
      wait 3.0;
      var_1 maps\_utility::_id_27C5();
      var_1 connectpaths();
    }
  }
}