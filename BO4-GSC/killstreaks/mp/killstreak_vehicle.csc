/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreak_vehicle.csc
*************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\vehicles\driving_fx;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\mp_common\callbacks;

#namespace killstreak_vehicle;

init() {
  level._effect[#"rcbomb_enemy_light"] = #"killstreaks/fx_rcxd_lights_blinky";
  level._effect[#"rcbomb_friendly_light"] = #"killstreaks/fx_rcxd_lights_solid";
  level._effect[#"rcbomb_enemy_light_blink"] = #"killstreaks/fx_rcxd_lights_red";
  level._effect[#"rcbomb_friendly_light_blink"] = #"killstreaks/fx_rcxd_lights_grn";
  level._effect[#"rcbomb_stunned"] = #"hash_622d3cdb93e01de5";
  clientfield::register("vehicle", "stunned", 1, 1, "int", &callback::callback_stunned, 0, 0);
}

init_killstreak(bundle) {
  if(isDefined(bundle.ksvehicle)) {
    vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned, bundle);
  }

  if(isDefined(bundle.ksvehiclepost)) {
    visionset_mgr::register_overlay_info_style_postfx_bundle(bundle.ksvehiclepost, 1, 1, bundle.ksvehiclepost);
  }
}

spawned(localclientnum, bundle) {
  self thread demo_think(localclientnum);
  self thread stunnedhandler(localclientnum);
  self thread boost_think(localclientnum);
  self thread shutdown_think(localclientnum);
  self.driving_fx_collision_override = &ondrivingfxcollision;
  self.driving_fx_jump_landing_override = &ondrivingfxjumplanding;
  self killstreak_bundles::spawned(localclientnum, bundle);
}

demo_think(localclientnum) {
  self endon(#"death");

  if(!isdemoplaying()) {
    return;
  }

  for(;;) {
    level waittill(#"demo_jump", #"demo_player_switch");
    self vehicle::lights_off(localclientnum);
  }
}

boost_blur(localclientnum) {
  self endon(#"death");

  if(isDefined(self.owner) && self.owner function_21c0fa55()) {
    enablespeedblur(localclientnum, getdvarfloat(#"scr_rcbomb_amount", 0.1), getdvarfloat(#"scr_rcbomb_inner_radius", 0.5), getdvarfloat(#"scr_rcbomb_outer_radius", 0.75), 0, 0);
    wait getdvarfloat(#"scr_rcbomb_duration", 1);
    disablespeedblur(localclientnum);
  }
}

boost_think(localclientnum) {
  self endon(#"death");

  for(;;) {
    self waittill(#"veh_boost");
    self boost_blur(localclientnum);
  }
}

shutdown_think(localclientnum) {
  self waittill(#"death");
  disablespeedblur(localclientnum);
}

play_boost_fx(localclientnum) {
  self endon(#"death");

  while(true) {
    speed = self getspeed();

    if(speed > 400) {
      self playSound(localclientnum, #"mpl_veh_rc_boost");
      return;
    }

    util::server_wait(localclientnum, 0.1);
  }
}

stunnedhandler(localclientnum) {
  self endon(#"death");
  self thread enginestutterhandler(localclientnum);

  while(true) {
    self waittill(#"stunned");
    self setstunned(1);
    self thread notstunnedhandler(localclientnum);
    self thread play_stunned_fx_handler(localclientnum);
  }
}

notstunnedhandler(localclientnum) {
  self endon(#"death");
  self endon(#"stunned");
  self waittill(#"not_stunned");
  self setstunned(0);
}

play_stunned_fx_handler(localclientnum) {
  self endon(#"death");
  self endon(#"stunned");
  self endon(#"not_stunned");

  while(true) {
    util::playFXOnTag(localclientnum, level._effect[#"rcbomb_stunned"], self, "tag_origin");
    wait 0.5;
  }
}

enginestutterhandler(localclientnum) {
  self endon(#"death");

  while(true) {
    self waittill(#"veh_engine_stutter");

    if(self function_4add50a7()) {
      function_36e4ebd4(localclientnum, "rcbomb_engine_stutter");
    }
  }
}

ondrivingfxcollision(localclientnum, player, hip, hitn, hit_intensity) {
  if(isDefined(hit_intensity) && hit_intensity > 15) {
    volume = driving_fx::get_impact_vol_from_speed();

    if(isDefined(self.sounddef)) {
      alias = self.sounddef + "_suspension_lg_hd";
    } else {
      alias = "veh_default_suspension_lg_hd";
    }

    id = playSound(0, alias, self.origin, volume);
    earthquake(localclientnum, 0.7, 0.25, player.origin, 1500);
    player playrumbleonentity(localclientnum, "damage_heavy");
  }
}

ondrivingfxjumplanding(localclientnum, player) {}