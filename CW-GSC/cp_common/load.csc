/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\load.csc
***********************************************/

#using script_1d4ca739cb476f50;
#using script_31a4e84bd38b34e2;
#using script_c22b8fa254e64a0;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfaceanim_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\helicopter_sounds_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\scene_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\system_shared;
#using scripts\core_common\traps_deployable;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\cp_common\ambient;
#using scripts\cp_common\global_fx;
#using scripts\cp_common\hazard;
#using scripts\cp_common\oed;
#using scripts\cp_common\rotating_object;
#using scripts\cp_common\skipto;
#using scripts\weapons\antipersonnelguidance;
#using scripts\weapons\cp\weaponobjects;
#using scripts\weapons\spike_charge;
#namespace load;

function levelnotifyhandler(clientnum, state, oldstate) {
  if(oldstate != "") {
    level notify(oldstate, {
      #localclientnum: state
    });
  }
}

function autoexec function_aeb1baea() {
  assert(!isDefined(level.var_f18a6bd6));
  level.var_f18a6bd6 = &function_5e443ed1;
}

function function_5e443ed1() {
  assert(isDefined(level.first_frame), "<dev string:x38>");

  if(is_true(level._loadstarted)) {
    return;
  }

  level._loadstarted = 1;
  level thread util::init_utility();
  level thread register_clientfields();
  util::registersystem("levelNotify", &levelnotifyhandler);
  level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
  callback::add_callback(#"on_localclient_connect", &basic_player_connect);
  callback::on_spawned(&on_player_spawned);
  system::function_c11b0642();
  art_review();
  level flag::set(#"load_main_complete");
}

function basic_player_connect(localclientnum) {
  forcegamemodemappings(localclientnum, "default");
}

function on_player_spawned(localclientnum) {
  level flag::set(#"player_spawning");
  level flag::clear(#"player_spawning");
  self thread force_update_player_clientfields(localclientnum);
  self function_b181fc06(localclientnum);
}

function force_update_player_clientfields(localclientnum) {
  self endon(#"death");

  while(!clienthassnapshot(localclientnum)) {
    waitframe(1);
  }

  self processclientfieldsasifnew(1);
}

function register_clientfields() {}