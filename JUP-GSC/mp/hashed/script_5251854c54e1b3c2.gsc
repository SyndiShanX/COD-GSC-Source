/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5251854c54e1b3c2.gsc
*************************************************/

#using script_5251854c54e1b3c2;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametypes;
#namespace namespace_e367146fa7344941;

function main() {
  level.var_cdc15ee14362fbf = &namespace_e342703f6722ee12::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  function_a96666bc3e3d2cb0();
  function_81b59887710baf14();
}

function function_a96666bc3e3d2cb0() {
  scripts\mp\gametypes\br_gametypes::disablefeature("circle");
  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("dropbag");
  scripts\mp\gametypes\br_gametypes::disablefeature("plunderSites");
  scripts\mp\gametypes\br_gametypes::disablefeature("circle");
  scripts\mp\gametypes\br_gametypes::disablefeature("brQuests");

  if(getdvarint(@ "hash_c3a2e929e971289a", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("teamSpectate");
  }

  if(getdvarint(@ "hash_cf460f5e17cacbe6", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("kiosk");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");

  if(getdvarint(@ "hash_38723bbb368f3f8c", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::enablefeature("tabletReplace");
  }
}

function function_81b59887710baf14() {}