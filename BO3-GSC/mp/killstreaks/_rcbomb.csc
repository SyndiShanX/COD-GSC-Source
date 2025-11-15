/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_rcbomb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_callbacks;
#using scripts\mp\_util;
#using scripts\mp\_vehicle;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_driving_fx;
#namespace rcbomb;

function autoexec __init__sytem__() {
  system::register("rcbomb", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["rcbomb_enemy_light"] = "killstreaks/fx_rcxd_lights_blinky";
  level._effect["rcbomb_friendly_light"] = "killstreaks/fx_rcxd_lights_solid";
  level._effect["rcbomb_enemy_light_blink"] = "killstreaks/fx_rcxd_lights_red";
  level._effect["rcbomb_friendly_light_blink"] = "killstreaks/fx_rcxd_lights_grn";
  level._effect["rcbomb_stunned"] = "_t6/weapon/grenade/fx_spark_disabled_rc_car";
  level.rcbombbundle = struct::get_script_bundle("killstreak", "killstreak_rcbomb");
  clientfield::register("vehicle", "rcbomb_stunned", 1, 1, "int", & callback::callback_stunned, 0, 0);
  vehicle::add_vehicletype_callback("rc_car_mp", & spawned);
}

function spawned(localclientnum) {
  self thread demo_think(localclientnum);
  self thread stunnedhandler(localclientnum);
  self thread boost_think(localclientnum);
  self thread shutdown_think(localclientnum);
  self.driving_fx_collision_override = & ondrivingfxcollision;
  self.driving_fx_jump_landing_override = & ondrivingfxjumplanding;
  self.killstreakbundle = level.rcbombbundle;
}

function demo_think(localclientnum) {
  self endon("entityshutdown");
  if(!isdemoplaying()) {
    return;
  }
  for(;;) {
    level util::waittill_any("demo_jump", "demo_player_switch");
    self vehicle::lights_off(localclientnum);
  }
}

function boost_blur(localclientnum) {
  self endon("entityshutdown");
  if(isDefined(self.owner) && self.owner islocalplayer()) {
    enablespeedblur(localclientnum, getdvarfloat("scr_rcbomb_amount", 0.1), getdvarfloat("scr_rcbomb_inner_radius", 0.5), getdvarfloat("scr_rcbomb_outer_radius", 0.75), 0, 0);
    wait(getdvarfloat("scr_rcbomb_duration", 1));
    disablespeedblur(localclientnum);
  }
}

function boost_think(localclientnum) {
  self endon("entityshutdown");
  for(;;) {
    self waittill("veh_boost");
    self boost_blur(localclientnum);
  }
}

function shutdown_think(localclientnum) {
  self waittill("entityshutdown");
  disablespeedblur(localclientnum);
}

function play_screen_fx_dirt(localclientnum) {}

function play_screen_fx_dust(localclientnum) {}

function play_driving_screen_fx(localclientnum) {
  speed_fraction = 0;
  while(true) {
    speed = self getspeed();
    maxspeed = self getmaxspeed();
    if(speed < 0) {
      maxspeed = self getmaxreversespeed();
    }
    if(maxspeed > 0) {
      speed_fraction = abs(speed) / maxspeed;
    } else {
      speed_fraction = 0;
    }
    if(self iswheelcolliding("back_left") || self iswheelcolliding("back_right")) {}
  }
}

function play_boost_fx(localclientnum) {
  self endon("entityshutdown");
  while(true) {
    speed = self getspeed();
    if(speed > 400) {
      self playSound(localclientnum, "mpl_veh_rc_boost");
      return;
    }
    util::server_wait(localclientnum, 0.1);
  }
}

function stunnedhandler(localclientnum) {
  self endon("entityshutdown");
  self thread enginestutterhandler(localclientnum);
  while(true) {
    self waittill("stunned");
    self setstunned(1);
    self thread notstunnedhandler(localclientnum);
    self thread play_stunned_fx_handler(localclientnum);
  }
}

function notstunnedhandler(localclientnum) {
  self endon("entityshutdown");
  self endon("stunned");
  self waittill("not_stunned");
  self setstunned(0);
}

function play_stunned_fx_handler(localclientnum) {
  self endon("entityshutdown");
  self endon("stunned");
  self endon("not_stunned");
  while(true) {
    playFXOnTag(localclientnum, level._effect["rcbomb_stunned"], self, "tag_origin");
    wait(0.5);
  }
}

function enginestutterhandler(localclientnum) {
  self endon("entityshutdown");
  while(true) {
    self waittill("veh_engine_stutter");
    if(self islocalclientdriver(localclientnum)) {
      player = getlocalplayer(localclientnum);
      if(isDefined(player)) {
        player playrumbleonentity(localclientnum, "rcbomb_engine_stutter");
      }
    }
  }
}

function ondrivingfxcollision(localclientnum, player, hip, hitn, hit_intensity) {
  if(isDefined(hit_intensity) && hit_intensity > 15) {
    volume = driving_fx::get_impact_vol_from_speed();
    if(isDefined(self.sounddef)) {
      alias = self.sounddef + "_suspension_lg_hd";
    } else {
      alias = "veh_default_suspension_lg_hd";
    }
    id = playSound(0, alias, self.origin, volume);
    player earthquake(0.7, 0.25, player.origin, 1500);
    player playrumbleonentity(localclientnum, "damage_heavy");
  }
}

function ondrivingfxjumplanding(localclientnum, player) {}