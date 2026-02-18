/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_vtol.gsc
************************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\heatseekingmissile;
#namespace player_vtol;

function private autoexec __init__system__() {
  system::register(#"player_vtol", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  vehicle::add_main_callback("player_vtol", &function_1b39ded0);
}

function function_1b39ded0() {
  self function_803e9bf3(1);
  self.numflares = 1;
  self.var_fc0dee44 = 10000;
  bundle = killstreaks::get_script_bundle("hoverjet");
  self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death", "dodge_missile", 1);
  self.var_51e39f11 = [];
  self thread function_7d2e878c();
  self thread function_fcc7ca52();
  self thread targetting_delay::function_7e1a12ce(self.var_fc0dee44);
}

function function_fcc7ca52() {
  self endon(#"death");

  for(;;) {
    params = self waittill(#"gunner_weapon_fired");

    if(params.gunner_index === 1) {
      self turretsettarget(2, self turretgettarget(1));
      self fireweapon(2, undefined, undefined, self);
    }
  }
}

function event_handler[event_5fafee73] function_49e8c140() {
  if(target_istarget(self)) {
    target_remove(self);
  }

  foreach(missile in self.var_51e39f11) {
    if(isDefined(missile)) {
      missile missile_settarget(undefined);
    }
  }

  self.var_51e39f11 = [];
  self notify(#"dodge_missile");
  bundle = killstreaks::get_script_bundle("hoverjet");
  self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death", "dodge_missile", 1);
}

function event_handler[event_a1da12f0] function_9d2a2309() {
  target_set(self);
}

function function_7d2e878c() {
  level endon(#"game_ended");
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"stinger_fired_at_me");

    if(!isDefined(self.var_51e39f11)) {
      self.var_51e39f11 = [];
    } else if(!isarray(self.var_51e39f11)) {
      self.var_51e39f11 = array(self.var_51e39f11);
    }

    self.var_51e39f11[self.var_51e39f11.size] = waitresult.projectile;
  }
}

function function_ff2361d1(target) {
  self waittill(#"death");

  if(isDefined(target) && isDefined(target.var_51e39f11)) {
    arrayremovevalue(target.var_51e39f11, self);
  }
}