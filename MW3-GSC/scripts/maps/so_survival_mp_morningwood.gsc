/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_morningwood.gsc
*******************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\mp\mp_morningwood_precache::main();
  maps\createart\mp_morningwood_art::main();
  maps\mp\mp_morningwood_fx::main();
  maps\createfx\mp_morningwood_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_morningwood");
  maps\_utility::set_vision_set("mp_morningwood", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_morningwood");
  maps\_so_survival::_id_3F67();
  thread killtrigger((-328, -712, 824), 40, 50);
  thread killtrigger((-368, -724, 824), 40, 50);
  thread killtrigger((-404, -752, 824), 40, 50);
  thread killtrigger((-440, -772, 824), 40, 50);
  thread spawn_blocker_collision((-324, -742.5, 816), (0, 27.4, 0));
  thread spawn_blocker_collision((-341, -751, 816), (0, 27.4, 0));
  thread spawn_blocker_collision((-392, -777, 816), (0, 26.8, 0));
  thread spawn_blocker_collision((-442.5, -802, 816), (0, 27.3, 0));
}

killtrigger(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0, 0, var_1, var_2);

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isplayer(var_4)) {
      continue;
    }
    var_4 maps\_utility::_id_1887();
  }
}

spawn_blocker_collision(var_0, var_1) {
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.origin = var_0;
  var_2.angles = var_1 + (0, 90, 0);
  var_2 clonebrushmodeltoscriptmodel(level._id_3BB1[0]);
}