/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_radar.gsc
*************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_3.csv";
  level.loadout_table = "sp/so_survival/tier_3.csv";
  maps\mp\mp_radar_precache::main();
  maps\createart\mp_radar_art::main();
  maps\mp\mp_radar_fx::main();
  maps\createfx\mp_radar_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_radar");
  maps\_utility::set_vision_set("mp_radar", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_radar");
  maps\_so_survival::_id_3F67();
  thread killtrigger((-5451, 3761, 1374), 28, 16);
  thread killtrigger((-5450, 3606, 1392), 28, 16);
  thread killtrigger((-5452, 3712, 1380), 28, 16);
  thread killtrigger((-5452, 3656, 1380), 28, 16);
  thread killtrigger((-5431, 3781, 1378), 8, 10);
  thread killtrigger((-5479, 3781, 1379), 8, 10);
  thread killtrigger((-3380, 798, 1234), 28, 16);
  thread killtrigger((-3379, 644, 1246), 28, 16);
  thread killtrigger((-3730, 658, 1234), 28, 16);
  thread killtrigger((-3794, 640, 1234), 28, 16);
  thread killtrigger((-3358, 819, 1238), 8, 10);
  thread killtrigger((-3680, 669, 1234), 28, 16);
  thread killtrigger((-3830, 627, 1250), 28, 16);
  thread killtrigger((-3382, 738, 1234), 28, 16);
  thread killtrigger((-3382, 682, 1234), 28, 16);
  thread killtrigger((-3655, 657, 1228), 8, 10);
  thread killtrigger((-3666, 701, 1238), 8, 10);
  thread killtrigger((-4812, -40, 1256), 32, 24);
  thread killtrigger((-4763, -75, 1301), 10, 10);
  thread killtrigger((-4893, -71, 1128), 100, 10);
  thread killtrigger((-5017, -161, 1128), 100, 10);
  thread killtrigger((-4864, 3048, 1344), 4, 20);
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