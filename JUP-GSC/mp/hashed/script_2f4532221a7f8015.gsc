/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f4532221a7f8015.gsc
*************************************************/

#using script_2816a042b9f7996;
#using script_595a577ac71de143;
#using scripts\cp_mp\utility\game_utility;
#namespace ob_map;

function main() {
  map_main();
  level thread namespace_f9b6a4254d2d8100::init_vehicles();
}

function private execute_main(function) {
  assert(isfunction(function));

  if(isfunction(function)) {
    [[function]]();
  }
}

function map_main() {
  mapname = getmapname();

  if(!isDefined(mapname)) {
    return;
  }

  switch (mapname) {
    case #"hash_9ae3f9a4f2372775":
      execute_main(level.var_cd52e517ad96566d);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_727a83f7155e77af":
      execute_main(level.var_42f9d919e49a0633);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_20b3e47add062367":
      execute_main(level.var_b59297aa6933406b);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_d7741d09a5c36348":
      execute_main(level.var_cf32182eec3bc910);
      level thread ob_visionset::function_da135ec070e2e6e8("mp_jup_outbreak", undefined, 1);
      break;
    case #"hash_2a217c09d161ff72":
      execute_main(level.var_87cbaa272123525e);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a217b09d161fddf":
      execute_main(level.var_ba419fdced2d3dfb);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a217a09d161fc4c":
      execute_main(level.var_efcc16c5e7fc5a6c);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_e7a134448c275447":
      execute_main(level.var_7e1adb313a3b34d3);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a217909d161fab9":
      execute_main(level.var_9d4c681557f7fe61);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a217809d161f926":
      execute_main(level.var_d6d4a817542a6b12);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a217709d161f793":
      execute_main(level.var_c61c1ef4d4aaec8f);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a217609d161f600":
      execute_main(level.var_6bf302c2c5d67b40);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a218509d1620d9d":
      execute_main(level.var_de0ea044921d6935);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_2a218409d1620c0a":
      execute_main(level.var_8bc670aa106fa796);
      level thread ob_visionset::function_29b46d591982c45a();
      break;
    case #"hash_224f194c88e9eac":
      execute_main(level.var_870202fb30967234);
      level thread ob_visionset::function_da135ec070e2e6e8("mp_jup_fort", undefined, 1);
      break;
    case #"hash_330a93d145b37045":
      execute_main(level.var_b803ce6ba2261e5);
      level thread ob_visionset::function_da135ec070e2e6e8("mp_jup_hydro", undefined, 1);
      break;
    case #"hash_9c19c4ead133822":
      execute_main(level.var_9180efe6324031e6);
      level thread ob_visionset::function_da135ec070e2e6e8("mp_jup_tower", undefined, 1);
      break;
  }
}