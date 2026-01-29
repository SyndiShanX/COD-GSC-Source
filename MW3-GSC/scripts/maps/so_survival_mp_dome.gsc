/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_dome.gsc
************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_2.csv";
  level.loadout_table = "sp/so_survival/tier_2.csv";

  if(getdvarint("survival_chaos") != 1) {
    _id_47CD(0.8);

  }
  maps\mp\mp_dome_precache::main();
  maps\createart\mp_dome_art::main();
  maps\mp\mp_dome_fx::main();
  maps\createfx\mp_dome_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_dome");
  maps\_utility::set_vision_set("mp_dome", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_dome");
  _id_0618::_id_6F52();
  maps\_so_survival::_id_3F67();
  thread killtrigger((0, 263, -223), 24, 10);
}

_id_47CD(var_0) {
  var_1 = getEntArray("explodable_barrel", "targetname");
  var_2 = int(var_0 * var_1.size);
  var_3 = [];
  var_1 = maps\_utility::_id_0B53(var_1);

  foreach(var_7, var_5 in var_1) {
    if(var_7 >= var_2) {
      break;
    }

    var_3[var_3.size] = var_5;
    var_6 = getent(var_5.target, "targetname");
    var_6 delete();
  }

  foreach(var_5 in var_3) {}
  var_5 delete();
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