/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_ai_tank.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\_vehicle;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\visionset_mgr_shared;
#using_animtree("mp_vehicles");
#namespace ai_tank;

function autoexec __init__sytem__() {
  system::register("ai_tank", &__init__, undefined, undefined);
}

function __init__() {
  bundle = struct::get_script_bundle("killstreak", "killstreak_ai_tank_drop");
  level.aitankkillstreakbundle = bundle;
  level._ai_tank_fx = [];
  level._ai_tank_fx["light_green"] = "killstreaks/fx_agr_vlight_eye_grn";
  level._ai_tank_fx["light_red"] = "killstreaks/fx_agr_vlight_eye_red";
  level._ai_tank_fx["stun"] = "killstreaks/fx_agr_emp_stun";
  clientfield::register("vehicle", "ai_tank_death", 1, 1, "int", &death, 0, 0);
  clientfield::register("vehicle", "ai_tank_missile_fire", 1, 2, "int", &missile_fire, 0, 0);
  clientfield::register("vehicle", "ai_tank_stun", 1, 1, "int", &tank_stun, 0, 0);
  clientfield::register("toplayer", "ai_tank_update_hud", 1, 1, "counter", &update_hud, 0, 0);
  vehicle::add_vehicletype_callback("ai_tank_drone_mp", &spawned);
  vehicle::add_vehicletype_callback("spawner_bo3_ai_tank_mp", &spawned);
  vehicle::add_vehicletype_callback("spawner_bo3_ai_tank_mp_player", &spawned);
  visionset_mgr::register_visionset_info("agr_visionset", 1, 16, undefined, "mp_vehicles_agr");
}

function spawned(localclientnum, killstreak_duration) {
  self thread play_driving_rumble(localclientnum);
  self.killstreakbundle = level.aitankkillstreakbundle;
}

function missile_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(self hasanimtree() == 0) {
    self useanimtree($mp_vehicles);
  }
  missiles_loaded = newval;
  if(newval == 2) {
    self setanimrestart( % mp_vehicles::o_drone_tank_missile1_fire, 1, 0, 0.5);
  } else {
    if(newval == 1) {
      self setanimrestart( % mp_vehicles::o_drone_tank_missile2_fire, 1, 0, 0.5);
    } else {
      if(newval == 0) {
        self setanimrestart( % mp_vehicles::o_drone_tank_missile3_fire, 1, 0, 0.5);
      } else if(newval == 3) {
        self setanimrestart( % mp_vehicles::o_drone_tank_missile_full_reload, 1, 0, 1);
      }
    }
  }
  if(missiles_loaded <= 3) {
    update_ui_ammo_count(localclientnum, missiles_loaded);
  }
}

function update_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("disconnect");
  wait(0.016);
  vehicle = getplayervehicle(self);
  if(isDefined(vehicle)) {
    self update_ui_model_ammo_count(localclientnum, vehicle clientfield::get("ai_tank_missile_fire"));
  }
}

function update_ui_ammo_count(localclientnum, missiles_loaded) {
  if(self islocalclientdriver(localclientnum) || isspectating(localclientnum)) {
    update_ui_model_ammo_count(localclientnum, missiles_loaded);
  }
}

function update_ui_model_ammo_count(localclientnum, missiles_loaded) {
  ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.ammo");
  if(isDefined(ammo_ui_data_model)) {
    setuimodelvalue(ammo_ui_data_model, missiles_loaded);
  }
}

function tank_stun(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self endon("death");
  if(newval) {
    self notify("light_disable");
    self stop_stun_fx(localclientnum);
    self start_stun_fx(localclientnum);
  } else {
    self stop_stun_fx(localclientnum);
  }
}

function death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(localclientnum);
  if(!isDefined(player)) {
    return;
  }
  if(player getinkillcam(localclientnum)) {
    return;
  }
  if(newval) {
    self stop_stun_fx(localclientnum);
    self notify("light_disable");
  }
}

function start_stun_fx(localclientnum) {
  self.stun_fx = playFXOnTag(localclientnum, level._ai_tank_fx["stun"], self, "tag_origin");
  playSound(localclientnum, "veh_talon_shutdown", self.origin);
}

function stop_stun_fx(localclientnum) {
  if(isDefined(self.stun_fx)) {
    stopfx(localclientnum, self.stun_fx);
    self.stun_fx = undefined;
  }
}

function play_driving_rumble(localclientnum) {
  self notify("driving_rumble");
  self endon("entityshutdown");
  self endon("death");
  self endon("driving_rumble");
  for(;;) {
    if(isinvehicle(localclientnum, self)) {
      speed = self getspeed();
      if(speed >= 40 || speed <= -40) {
        player = getlocalplayer(localclientnum);
        if(isDefined(player)) {
          player earthquake(0.1, 0.1, self.origin, 200);
        }
      }
    }
    util::server_wait(localclientnum, 0.05);
  }
}