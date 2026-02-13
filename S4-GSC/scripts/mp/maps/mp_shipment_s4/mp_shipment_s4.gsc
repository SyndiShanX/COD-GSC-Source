/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_shipment_s4\mp_shipment_s4.gsc
*************************************************************/

main() {
  scripts\mp\maps\mp_shipment_s4\mp_shipment_s4_precache::main();
  scripts\mp\maps\mp_shipment_s4\gen\mp_shipment_s4_art::main();
  scripts\mp\maps\mp_shipment_s4\mp_shipment_s4_fx::main();
  scripts\mp\maps\mp_shipment_s4\mp_shipment_s4_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_shipment_s4");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 0;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);

  if(getdvarint("#x347607a0a0f191e1c", 0)) {
    var_0 = getdvarfloat("#x3267f06d1e050f93c", -1);

    if(var_0 > 0) {
      setDvar("#x3c88360cea4930df9", var_0);
    }

    var_1 = getdvarfloat("#x393ab8c4b9fe63209", -1);

    if(var_1 > 0) {
      setDvar("#x38710aab0fedc9f6a", var_1);
    }

    var_2 = getdvarfloat("#x3ef9b291057379530", -1);

    if(var_2 > 0) {
      setDvar("#x3826e4573d651231", var_2);
    }

    var_3 = getdvarfloat("#x333f396372d4e111d", -1);

    if(var_3 > 0) {
      setDvar("#x3efafc99757380082", var_3);
    }

    var_4 = getdvarint("#x339ba9c8410535c25", -1);

    if(var_4 > 0) {
      setDvar("#x365d67b5652d0bab2", var_4);
    }

    var_5 = getdvarint("#x339dda6841079b9db", -1);

    if(var_5 > 0) {
      setDvar("#x365b3655652aa4298", var_5);
    }
  }

  scripts\mp\s4_elf_poi::add_elf_poi_position((-1263, 7350.5, -349.75), (0, 180, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-993, 7134, -356.5), (0, 0, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1028.89, 6764.04, -389.25), (0, 155, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-240.792, 7944.79, -467.5), (0, 203.576, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-418.308, 7406.82, -355.25), (0, 114, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-403.733, 6725.23, -473), (0, 129, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1612.86, 7168.42, -355.5), (0, 288.421, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-990.559, 6729.22, -469.75), (0, 187, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-928.548, 7806.07, -468.25), (0, 168, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-934.235, 6706.51, -357.75), (0, 105.5, 0), "standing");
  thread setmapcenterloc();
  thread postshipspawns();
}

setmapcenterloc() {
  wait 2;
  var_0 = getEntArray("minimap_corner", "targetname");
  level._id_9AAC = _id_0817::_id_5AE1(var_0[0].origin, var_0[1].origin);
  setmapcenter(level._id_9AAC);
}

postshipspawns() {
  removeunusedspawns();
}

removeunusedspawns() {
  level._id_9FFA["-9280 8384"]["mp_dd_spawn_attacker_a"]["remove"] = 1;
  level._id_9FFA["-9280 8320"]["mp_dd_spawn_attacker"]["remove"] = 1;
  level._id_9FFA["-9280 8256"]["mp_dd_spawn_attacker_b"]["remove"] = 1;
  level._id_9FFA["-9216 8320"]["mp_dd_spawn_attacker_start"]["remove"] = 1;
  level._id_9FFA["-8192 8320"]["mp_dd_spawn_defender_start"]["remove"] = 1;
  level._id_9FFA["-8128 8384"]["mp_dd_spawn_defender_a"]["remove"] = 1;
  level._id_9FFA["-8128 8320"]["mp_dd_spawn_defender"]["remove"] = 1;
  level._id_9FFA["-8128 8256"]["mp_dd_spawn_attacker_b"]["remove"] = 1;
  level._id_9FFA["-9216 7936"]["mp_front_spawn_allies"]["remove"] = 1;
  level._id_9FFA["-8192 7936"]["mp_front_spawn_axis"]["remove"] = 1;
  level._id_9FFA["-9216 7744"]["mp_ball_spawn_allies_start"]["remove"] = 1;
  level._id_9FFA["-8704 7616"]["mp_ball_spawn"]["remove"] = 1;
  level._id_9FFA["-8192 7744"]["mp_ball_spawn_axis_start"]["remove"] = 1;
}