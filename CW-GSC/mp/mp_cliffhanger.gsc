/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_cliffhanger.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\load_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#namespace mp_cliffhanger;

function event_handler[level_init] main(eventstruct) {
  callback::on_start_gametype(&start_gametype);
  scene::function_497689f6(#"cin_mp_cliffhanger_intro_cia", "helicopter", "tag_probe_attach", "prb_tn_mil_rus_heli_trans");
  load::main();
  compass::setupminimap("");
  setDvar(#"hash_7b06b8037c26b99b", 64);
  level thread function_29584e41();
}

function start_gametype() {
  waittillframeend();

  if(challenges::canprocesschallenges()) {
    challenges::registerchallengescallback("gameEnd", &challengegameendmp);
  }
}

function challengegameendmp(data) {
  if(!isDefined(data.player)) {
    return;
  }

  data.player stats::function_a47092b5(#"hash_522726cf51951b8", 1, #"hash_5de4e8563e882e42");
}

function function_29584e41() {
  level flag::wait_till(#"item_world_reset");

  if(util::get_game_type() !== # "spy") {
    var_94c44cac = getdynentarray("spy_special_weapon_stash");
    var_de285f77 = getdynentarray("spy_ammo_stash");
    var_ffd6a2d3 = getdynentarray("spy_equipment_stash");
    var_3c1644b6 = arraycombine(var_94c44cac, var_de285f77);
    var_3c1644b6 = arraycombine(var_3c1644b6, var_ffd6a2d3);

    foreach(dynent in var_3c1644b6) {
      setdynentstate(dynent, 3);
    }

    return;
  }

  level.var_e8dfa0d2 = &function_631d44bc;
}

function function_631d44bc(dynents) {
  foreach(dynent in dynents) {
    if(distancesquared(dynent.origin, (154.204, -13.1016, 560.125)) < 2500) {
      item_world::function_160294c7(dynent);
      continue;
    }

    if(distancesquared(dynent.origin, (-64.3946, -923.241, 560.125)) < 2500) {
      item_world::function_160294c7(dynent);
    }
  }
}