/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d27f7166781c70b.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3b2905ec05ed796;
#using script_4937c6974f43bb71;
#using scripts\core_common\activities_util;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\ending;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace namespace_ef60e103;

function function_7ab616c1(str_objective) {
  setlightingstate(3);
  level flag::set("flg_loose_ends");
  level.player setcharacterbodytype(1);
  level.player setcharacteroutfit(1);
  level.player util::function_a5318821();
}

function function_2435d3e(str_objective, var_50cc0d4f) {
  snd::client_msg("ending_fade_out");
  namespace_82bfe441::fade(1, "FadeImmediate");
  exploder::kill_exploder("fxexp_nuke_loop_fx");

  if(!var_50cc0d4f) {
    setlightingstate(3);
  }

  level thread function_50f30bc3();
  level battlechatter::function_2ab9360b(0);
  namespace_61e6d095::create(#"hash_26ccd69d3e6f3b56", #"hash_28d1565bae3236e");
  namespace_61e6d095::set_color(#"hash_26ccd69d3e6f3b56", 0, 0, 0);
  namespace_61e6d095::function_39710437(#"hash_26ccd69d3e6f3b56", "fullscreen");
  namespace_61e6d095::function_46df0bc7(#"hash_26ccd69d3e6f3b56", 999);
  e_player = getplayers()[0];
  e_player val::set(#"hash_75e1db7c3af8ae06", "freezecontrols", 1);
  e_player val::set(#"hash_383e66ab943657f9", "disable_weapons", 0);
  e_player val::set(#"hash_fa9cf212730562d", "show_hud", 0);
  e_player enableweapons();
  pistol = getweapon("pistol_semiauto_t9");
  e_player takeallweapons();
  e_player giveweapon(pistol);
  e_player switchtoweapon(pistol, 1);
  level ending::function_103cd64c();
  e_player val::reset(#"hash_fa9cf212730562d", "show_hud");
  namespace_61e6d095::remove(#"hash_26ccd69d3e6f3b56");
  level util::screen_fade_out(0);
  var_8a3bb97c = getspawnerarray("adler_looseends", "targetname");
  level.var_8a9babf4 = var_8a3bb97c[0] spawner::spawn(1);
  level.var_8a9babf4 setweapon(pistol);
  level.var_8a9babf4 clientfield::set("toggle_bone_constraint", 1);
  level thread function_2daa05b8();
  level thread scene::play("armada_intro_seagull_circle_01", "play");
  level thread scene::play("armada_intro_seagull_circle_02", "play");
  level thread scene::play("armada_intro_seagull_circle_03", "play");
  level thread scene::play("scene_loose_ends", "loose_ends", [level.var_8a9babf4]);
  snd::client_msg("loose_ends_start");
  wait 2;
  level util::screen_fade_in(5);
  level waittill(#"hash_3678fbfcec341cb5");
  snd::client_msg("loose_ends_slow");
  var_6d369e51 = 4;
  var_c8ae7644 = 0.1;
  var_5816725d = 0.2;
  var_19846ec4 = 1;
  var_eb7c3686 = 1 - (1 - var_c8ae7644) * var_19846ec4;
  level thread function_f1c8f3ad();
  setslowmotion(1, var_c8ae7644, var_5816725d, 1, var_eb7c3686);
  wait_time = var_6d369e51 * var_c8ae7644 + var_5816725d * ((1 - var_c8ae7644) * 0.5 + var_c8ae7644);
  level.player waittilltimeout(wait_time, #"gun_shot");
  snd::client_msg("loose_ends_fire");
  setslowmotion(0.1, 1, 0);
  level.player clientfield::set_to_player("bullet_hit", 1);
  wait 0.25;
  level thread util::screen_fade_out(0, "black");
  level.player clientfield::set_to_player("bullet_hit", 0);
  level.player freezecontrols(1);
  level.player takeallweapons();
  level.var_8a9babf4 delete();
  level thread scene::stop("armada_intro_seagull_circle_01");
  level thread scene::stop("armada_intro_seagull_circle_02");
  level thread scene::stop("armada_intro_seagull_circle_03");
  wait 15;
  level.player freezecontrols(0);
  activities::function_59e67711("_exit");
  skipto::function_f02f0c63();
  skipto::function_1c2dfc20();
}

function function_2daa05b8() {
  level waittill(#"hash_403dca847fab7b32");
  wait 3.5;
  namespace_95f223d5::music("9.1_loose_ends");
  level waittill(#"hash_51de84c6e84bb743");
  wait 1.3;
  namespace_95f223d5::music("9.2_loose_ends");
}

function function_f1c8f3ad() {
  level waittill(#"hash_5e4fcea7a58a3f65");
  snd::client_msg("loose_ends_cando");
  level.player notifyonplayercommand("gun_shot", "+attack");
}

function function_8f77588(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_50f30bc3() {
  wait 0.1;
  var_82af4def = struct::get("loose_ends", "targetname");
  level.player setorigin(var_82af4def.origin);
  level.player setplayerangles((0, 0, 0));
}