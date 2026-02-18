/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7c5d86c25e7584a4.gsc
***********************************************/

#using script_237e957844a8197c;
#using script_5991d6501121591f;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_69a17177;

function start(str_objective) {}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  var_b6ac0499 = struct::get("rooftop_regroup_obj_pos", "targetname");
  level thread function_e6b30b71();
  var_d929545b = getent("rooftop_backgate_blocker", "targetname");
  var_d929545b hide();
  var_d929545b notsolid();

  if(isDefined(level.park)) {
    var_5ad9bf5e = struct::get("park_rooftop_struct");
    level.park colors::disable();
    level.park.ignoreall = 1;
    level.park.goalradius = 8;
    var_7caf50bf = getnode("rooftop_initial_park_node", "targetname");
    level.park setgoal(var_7caf50bf);
  } else {
    level hms_util::function_ee1d1df6("park", "Park", "park_rooftop_struct");
  }

  if(isDefined(level.lazar)) {
    var_a91cada6 = struct::get("lazar_rooftop_struct");
    level.lazar colors::disable();
    level.lazar.ignoreall = 1;
    level.lazar.goalradius = 8;
    var_cb77324d = getnode("rooftop_lazar_node", "targetname");
    level.lazar setgoal(var_cb77324d);
  } else {
    level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_rooftop_struct");
  }

  hms_util::function_eaa0342e("rooftop_containment_warnings", "rooftop_containment_fails");
  level thread function_4995f40d();
  level thread namespace_a789f8ae::function_ba3f106b("rooftop");
  level thread function_cabf998b();
  objectives::goto("obj_rooftop_regroup", var_b6ac0499.origin, #"hash_4ac509ec6068df31");
  level flag::wait_till("flg_player_in_defend_arena");
  namespace_232ddc52::music("13.0_rooftop_transition");
  var_d929545b = getent("rooftop_backgate_blocker", "targetname");
  var_d929545b show();
  var_d929545b solid();
  level flag::wait_till("flg_defend_ready_to_start");
  objectives::complete("obj_rooftop_regroup");
  skipto::function_4e3ab877("nic_rooftop");
}

function function_cabf998b() {
  level flag::wait_till("flg_setup_skyhook_done");

  if(isDefined(level.redshirt_1) && isalive(level.redshirt_1)) {
    level.redshirt_1 val::set(#"hash_34296d85d30e4cc7", "magic_bullet_shield", 0);
    level.redshirt_1 colors::disable();
    level.redshirt_1.goalradius = 8;
    var_e5340d06 = getnode("rooftop_redshirt_1_node", "targetname");
    level.redshirt_1 setgoal(var_e5340d06);
  }

  if(isDefined(level.redshirt_2) && isalive(level.redshirt_2)) {
    level.redshirt_2 val::set(#"hash_34296d85d30e4cc7", "magic_bullet_shield", 0);
    level.redshirt_2 colors::disable();
    level.redshirt_2.goalradius = 8;
    var_500edd5b = getnode("rooftop_redshirt_2_node", "targetname");
    level.redshirt_2 setgoal(var_500edd5b);
  }
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x4c>");
}

function function_4995f40d() {
  level.player endon(#"death");
  var_bb86b0db = struct::get("pilot_dialogue", "targetname");
  level flag::wait_till("flg_rooftop_redshirts_spawned");
  level.redshirt_1 hms_util::dialogue("vox_cp_cbcr_01800_cia1_balloonisupandr_96", 0, "allies", "CIA Operative");
  var_bb86b0db thread hms_util::dialogue("vox_cp_cbcr_01800_pilo_rogerthatground_02", 1, "allies", "Pilot");
  level flag::set("flg_defend_ready_to_start");
}

function function_e6b30b71() {
  level endon(#"flg_regroup_with_team");
  s_lookat = struct::get("balloon_release_lookat");

  for(b_visible = 0; !b_visible; b_visible = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), s_lookat.origin, cos(45))) {
    wait 0.1;
  }

  level flag::set("flg_regroup_with_team");
}