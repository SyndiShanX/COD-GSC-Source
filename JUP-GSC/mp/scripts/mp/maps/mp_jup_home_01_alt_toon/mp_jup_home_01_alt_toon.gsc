/*******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_home_01_alt_toon\mp_jup_home_01_alt_toon.gsc
*******************************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_home_01_alt_toon\gen\mp_jup_home_01_alt_toon_art;
#using scripts\mp\maps\mp_jup_home_01_alt_toon\mp_jup_home_01_alt_toon_fx;
#using scripts\mp\maps\mp_jup_home_01_alt_toon\mp_jup_home_01_alt_toon_lighting;
#using scripts\mp\utility\game;
#namespace mp_jup_home_01_alt_toon;

function main() {
  scripts\mp\maps\mp_jup_home_01_alt_toon\gen\mp_jup_home_01_alt_toon_art::main();
  scripts\mp\maps\mp_jup_home_01_alt_toon\mp_jup_home_01_alt_toon_fx::main();
  scripts\mp\maps\mp_jup_home_01_alt_toon\mp_jup_home_01_alt_toon_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_home_01_alt_toon");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(getdvarint(@ "hash_5f60d5026cd2c8b0") == 1) {
    function_476e26432f5d3edd();
  }

  scripts\cp_mp\utility\game_utility::registersmallmap();
  precachemodel("p7_box_cardboard_d_closed");
  precachemodel("us_decor_box_cash_02");
  precachemodel("us_decor_box_cash_01");
  thread function_77b5930f3eb27a50();
  thread function_261c472c0f5a1633();
}

function function_476e26432f5d3edd() {
  pumpkins = getStructArray("jackolantern", "script_noteworthy");
  testdist = 1024;

  foreach(pumpkin in pumpkins) {
    if(distance2dsquared(pumpkin.origin, (-252.5, 189, 55.2987)) <= testdist) {
      deletestruct_ref(pumpkin);
    }
  }
}

function function_77b5930f3eb27a50() {
  var_ae1adb1281a2e4f9 = getEnt("no_deploy", "targetname");
  var_ae1adb1281a2e4f9.mountmantlemodel = 1;
}

function function_261c472c0f5a1633() {
  if(getgametype() == "koth_horde") {
    var_39945b8df76825c5 = (16, 16, 60);
    var_b6272fe2a017d276 = (564, 64, 56);
    createnavbadplacebybounds(var_b6272fe2a017d276, var_39945b8df76825c5, (0, 0, 0));
    var_3994588df7681f2c = (16, 16, 60);
    var_b6272ee2a017d043 = (12, -448, 50);
    createnavbadplacebybounds(var_b6272ee2a017d043, var_3994588df7681f2c, (0, 0, 0));
    box01 = spawn_model("p7_box_cardboard_d_closed", (18.902, 389.645, 17.066), (0, 90.1995, 0));
    box02 = spawn_model("us_decor_box_cash_02", (18.427, 392.164, 36.523), (0.0127182, 177.297, -0.0128985));
    box03 = spawn_model("p7_box_cardboard_d_closed", (43.645, 390.098, 15.106), (0, 0.199495, 0));
    box04 = spawn_model("us_decor_box_cash_01", (44, 390, 34), (0, 180, 0));
    patch = getEnt("care_package_col", "targetname");
    var_45428b56ef07ea91 = spawn("script_model", (30, 398, 42));
    var_45428b56ef07ea91.angles = (0, 0, 0);
    var_45428b56ef07ea91 clonebrushmodeltoscriptmodel(patch);
  }
}