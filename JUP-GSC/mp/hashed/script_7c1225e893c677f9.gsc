/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7c1225e893c677f9.gsc
*************************************************/

#using script_28e46eeeec9480c0;
#using script_58989565e9a3bde8;
#using script_cab1c8ded8da82a;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#namespace mp_m_alley;

function main() {
  namespace_fcf80468fb0f17f8::main();
  namespace_7caec9fad4e6c08c::main();
  namespace_1d315e7feaa8c0fa::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_alley");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 512);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread function_6e3cce6a02667476();
  thread function_771f3d37d84f3215();
}

function function_da7c9335e454c032(player) {
  if(getdvarint(@ "camera_thirdperson") == 1 || istrue(level.thirdpersonmode)) {
    setDvar(@ "hash_31f818870138cd26", 1);
  }
}

function function_6e3cce6a02667476() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    function_da7c9335e454c032(player);
    player thread function_5b2361e97848cabd();
  }
}

function function_5b2361e97848cabd() {
  self endon("disconnect");
  level waittill("game_ended");
  setDvar(@ "hash_31f818870138cd26", 0);
}

function function_771f3d37d84f3215() {
  var_771f7b37d84fba6f = spawn("trigger_rotatable_radius", (-288, -128, 192), 0, 256, 320);
  var_771f7b37d84fba6f.angles = (0, 0, 90);
  var_771f7b37d84fba6f.targetname = "callout_area";
  var_771f7b37d84fba6f.script_noteworthy = "market";
  var_771f7c37d84fbca2 = spawn("trigger_rotatable_radius", (512, -96, 128), 0, 512, 600);
  var_771f7c37d84fbca2.angles = (90, 0, 0);
  var_771f7c37d84fbca2.targetname = "callout_area";
  var_771f7c37d84fbca2.script_noteworthy = "wall";
  var_771f7d37d84fbed5 = spawn("trigger_rotatable_radius", (-512, 96, 128), 0, 512, 600);
  var_771f7d37d84fbed5.angles = (-90, 0, 0);
  var_771f7d37d84fbed5.targetname = "callout_area";
  var_771f7d37d84fbed5.script_noteworthy = "junk";
  var_771f7637d84faf70 = spawn("trigger_rotatable_radius", (0, 0, 120), 0, 192, 128);
  var_771f7637d84faf70.angles = (0, 0, 0);
  var_771f7637d84faf70.targetname = "callout_area";
  var_771f7637d84faf70.script_noteworthy = "bridge";
  var_771f7737d84fb1a3 = spawn("trigger_rotatable_radius", (288, 128, 192), 0, 256, 320);
  var_771f7737d84fb1a3.angles = (0, 0, -90);
  var_771f7737d84fb1a3.targetname = "callout_area";
  var_771f7737d84fb1a3.script_noteworthy = "hookah";
  var_771f7837d84fb3d6 = spawn("trigger_rotatable_radius", (576, -704, 128), 0, 256, 320);
  var_771f7837d84fb3d6.angles = (0, 0, 90);
  var_771f7837d84fb3d6.targetname = "callout_area";
  var_771f7837d84fb3d6.script_noteworthy = "carpet";
  var_771f7937d84fb609 = spawn("trigger_rotatable_radius", (-576, 704, 128), 0, 256, 320);
  var_771f7937d84fb609.angles = (0, 0, -90);
  var_771f7937d84fb609.targetname = "callout_area";
  var_771f7937d84fb609.script_noteworthy = "basket";
  var_771f8237d84fc9d4 = spawn("trigger_rotatable_radius", (0, 0, -40), 0, 512, 128);
  var_771f8237d84fc9d4.angles = (0, 0, 0);
  var_771f8237d84fc9d4.targetname = "callout_area";
  var_771f8237d84fc9d4.script_noteworthy = "alley";
}