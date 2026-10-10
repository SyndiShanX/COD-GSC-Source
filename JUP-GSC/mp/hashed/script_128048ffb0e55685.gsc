/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_128048ffb0e55685.gsc
*************************************************/

#using script_1311c5c284dd1537;
#using script_2e378a72bb22c5e;
#using script_39476b974d936141;
#using script_4ab79785ddba1484;
#using script_50961bbda895acfe;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\utility\game;
#namespace mp_luxury;

function main() {
  namespace_b626da7a4a01c95f::main();
  namespace_d2189e7ddf9eb8ca::main();
  namespace_ec7a628faa057d3c::main();
  namespace_52028f6c650af52a::main();
  scripts\mp\load::main();
  namespace_5633828963c62e57::function_57d6a393b90824dc(600);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_luxury");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level function_3c37e8e4377aa2b3();
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  function_8672453924241040();
}

function function_1682cf22619a5e55() {
  level waittill("infil_setup_complete");
  var_6120df12544987e8 = getEnt("static_infil_van", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_6120df12544987e8)) {
    var_6120df12544987e8 hide();
  }
}

function function_8672453924241040() {
  audioent = spawn("script_origin", (0, 0, 0));
  audioent playLoopSound("pa_luxury_lobby_mus_lp");
  enablepaspeaker("pa_luxury");
}

function function_3c37e8e4377aa2b3() {
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((-572, 602, 0), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((1676, 1156, 80), 0);
  scripts\mp\equipment\tactical_cover::function_c5d3d6e10bd8c8ab((1422, 1208, 80), 0);
}