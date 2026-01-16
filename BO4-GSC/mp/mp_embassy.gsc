/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_embassy.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\compass;
#include scripts\core_common\doors_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;
#include scripts\mp_common\load;

#namespace mp_embassy;

event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "spawn_flavor_apc_explosion", 1, 1, "counter");
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((1663, -2262, 11.25), (-506, -3186, 14), (3888, -32, 39), (71, -1169, 14), (3398, -2146, 7));
  level.var_f3e25805 = &prematch_init;
  level thread function_34fc666e();
}

function_34fc666e() {
  level endon(#"game_ended");

  if(util::isfirstround() && getgametypesetting(#"allowmapscripting") && draft::is_draft_this_round()) {
    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    level thread scene::play(#"aib_t8_vign_cust_emb_civs_running_01");
    level thread scene::play(#"aib_t8_vign_cust_emb_civs_running_02");
    return;
  }

  mdl_apc = getent("spawn_flavor_apc_explode", "targetname");
  mdl_apc setModel("veh_t8_mil_apc_macv_dead_no_turret_no_armor_mp_grey");
  scene::skipto_end(#"p8_fxanim_mp_emb_apc_arrive_bundle");
  level flag::wait_till("first_player_spawned");
  array::delete_all(getEntArray("sun_block", "targetname"));
  exploder::exploder("fxexp_embassy_aftermath");
}

prematch_init() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  scene::stop(#"aib_t8_vign_cust_emb_civs_running_01", 1);
  scene::stop(#"aib_t8_vign_cust_emb_civs_running_02", 1);

  if(util::isfirstround() && getgametypesetting(#"allowmapscripting")) {
    exploder::exploder("fxexp_embassy_explosion");
    level util::delay(4, "game_ended", &scene::play, #"p8_fxanim_mp_emb_apc_arrive_bundle");
    level thread scene::play(#"p8_fxanim_mp_emb_balloons_fly_bundle");
    mdl_apc = getent("spawn_flavor_apc_explode", "targetname");
    mdl_apc setModel("veh_t8_mil_apc_macv_dead_no_turret_no_armor_mp_grey");
    mdl_apc clientfield::increment("spawn_flavor_apc_explosion");
    return;
  }
}