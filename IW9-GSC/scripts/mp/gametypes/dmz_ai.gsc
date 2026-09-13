/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_ai.gsc
***********************************************/

init() {
  if(getdvarfloat("dvar_3545CA86FF96CB37", 0.34) != 0)
    scripts\cp_mp\utility\script_utility::registersharedfunc("ai", "dropLootOnAgentDeath", _id_48814951E916AF89::_id_82ED67AE79913551);

  _id_48814951E916AF89::_id_5AEE5D819F7DFD1C();

  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");
  setsaveddvar("dvar_0DF03D7AC5B31599", 1);
  _func_E00CC8C1C5CC38FB(1);
  _func_03875866B3A6D349(1);
  _func_4FF17EFD15D01D3F(256);
  _func_1611D0F6B5F84B9A(700);
  level thread _id_3C5C2E3402F0431E();
  level thread _id_BBBD3531AB976B5E();
}

_id_3C5C2E3402F0431E() {
  waittime = getdvarint("dvar_0BA0CC4A1F73DE4C", 10);

  if(waittime > 0)
    wait(waittime);

  _id_48814951E916AF89::_id_35BAE74232FF8B77(0);
  _id_48814951E916AF89::_id_2B36368B8B1B2B30(1);
  level notify("dmz_ai_removed_ignoreall_after_initialtime");
}

_id_BBBD3531AB976B5E() {
  waittime = getdvarint("dvar_E1B4B41AF9D69B3B", 15);

  if(waittime > 0)
    wait(waittime);

  _id_48814951E916AF89::_id_3C44B8551D08AC1D();
}

_id_428703950599C9E9() {
  _id_48814951E916AF89::_id_B1D1E7E3B23E0DFE(["mission", "perfTesting", "fortressGuards", "fortressPatrols", "reinforcements", "elites", "extraGuards", "extraPatrols", "firstKillFodder", "spawnPackage", "civilian", "vehiclePatrol", "bosses", "bossMinions", "convoy_attack", "huntSquad", "zombies"]);
}