/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_maldives_scripted.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_maldives_scripted;

autoexec __init__system__() {
  system::register(#"mp_maldives_scripted", &__main__, undefined, undefined);
}

__main__() {
  callback::on_game_playing(&on_game_playing);
  level scene::add_scene_func(#"p8_fxanim_mp_mal_border_shark_01_bundle", &function_62a2843c);
  level scene::add_scene_func(#"p8_fxanim_mp_mal_border_shark_02_bundle", &function_62a2843c);
  level scene::add_scene_func(#"p8_fxanim_mp_mal_border_shark_03_bundle", &function_62a2843c);
  level.var_f3e25805 = &prematch_init;
}

on_game_playing() {
  laser_trig = getent("laser_kill_trig", "targetname");
  laser_trig triggerenable(0);
  laser_trig callback::on_trigger(&function_7da97cb5);
  laser_button = struct::get("laser_button");
  laser_button.mdl_gameobject gameobjects::set_onuse_event(&function_bc78a4d0);
  laser_button.mdl_gameobject.laser_trig = laser_trig;

  if(!getgametypesetting(#"allowmapscripting")) {
    laser_button.mdl_gameobject gameobjects::disable_object();
    return;
  }

  if(util::isfirstround()) {
    level scene::play(#"p8_fxanim_mp_mal_laser_weapon_bundle", "Shot " + randomintrange(1, 3));
    level thread scene::skipto_end(#"p8_fxanim_mp_mal_laser_weapon_bundle");
  }
}

prematch_init() {}

function_7da97cb5(var_ad3d227e) {
  player = var_ad3d227e.activator;

  if(isalive(player)) {
    mod = "MOD_BURNED";

    if(isvehicle(player)) {
      mod = "MOD_EXPLOSIVE";
    }

    player dodamage(player.health, player.origin, undefined, undefined, undefined, mod);
  }
}

function_bc78a4d0(activator) {
  level endon(#"game_ended");
  self gameobjects::disable_object();
  self playSound("evt_laser_button");
  activator gestures::function_56e00fbf("gestable_door_interact", undefined, 0);
  self thread function_8e65b1f2();
  level scene::play(#"p8_fxanim_mp_mal_laser_weapon_bundle", "Shot " + randomintrange(1, 3));
  level scene::play(#"p8_fxanim_mp_mal_laser_weapon_bundle", "recharge");
  self playSound("evt_laser_ready");
  self gameobjects::enable_object();
}

function_8e65b1f2() {
  level endon(#"game_ended");
  wait 3.5;
  self.laser_trig triggerenable(1);
  wait 7;
  self.laser_trig triggerenable(0);
}

function_62a2843c(a_ents) {
  shark = a_ents[#"prop 1"];
  trigger = spawn("trigger_radius_new", shark gettagorigin("head_jnt") + (0, 0, -20), 0, 34, 38);
  trigger.shark = shark;
  trigger triggerignoreteam();
  trigger enablelinkto();
  trigger linkto(shark);
  trigger callback::on_trigger(&function_9534b46c);
}

function_9534b46c(var_95057a9a) {
  shark = self.shark;
  player = var_95057a9a.activator;

  if(isalive(player) && isDefined(shark)) {
    player dodamage(player.maxhealth, shark.origin, undefined, undefined, undefined, "MOD_IMPACT");
  }
}