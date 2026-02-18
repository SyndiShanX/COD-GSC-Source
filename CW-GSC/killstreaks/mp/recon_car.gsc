/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\recon_car.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\remote_weapons;
#namespace recon_car;

function private autoexec __init__system__() {
  system::register("recon_car", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  killstreak_detect::init_shared();
  remote_weapons::init_shared();
  killstreaks::function_b5b6ef3e(&init_killstreak);
}

function init_killstreak() {
  if(sessionmodeiswarzonegame()) {
    bundle = getscriptbundle("killstreak_recon_car_wz");
  } else {
    bundle = getscriptbundle("killstreak_recon_car");
  }

  killstreak_vehicle::init_killstreak(bundle);
  vehicle::add_main_callback("vehicle_t9_rcxd_racing", &function_d1661ada);
}

function function_d1661ada() {
  self killstreak_vehicle::init_vehicle(&function_d4789bf5);
  self util::make_sentient();
  self.var_7d4f75e = 1;
  self.ignore_death_jolt = 1;
  self.var_92043a49 = 1;
  self.var_20c65a3e = 0;
  self disabledriverfiring(1);
  self.var_a6ab9a09 = 1;
  self.var_5ab0177c = 1;
  bundle = killstreaks::get_script_bundle("recon_car");

  if(is_true(bundle.var_dad2e3a2)) {
    self.predictedcollisiontime = 0.1;
    self thread function_819fff9d();
  }

  if(isDefined(bundle.var_1c30ba81)) {
    self.var_a0f50ca8 = &function_2087b17f;
  }

  self.var_62b033f0 = &function_76817ccc;
  self thread function_f3170551();
}

function function_d4789bf5() {
  self.var_99c7a1bc = self.weapon;
}

function function_819fff9d() {
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"veh_predictedcollision");

    if(isPlayer(waitresult.target) && util::function_fbce7263(self.team, waitresult.target.team)) {
      if(isDefined(self.owner) && isDefined(self.var_22a05c26.kstype)) {
        self.owner killstreaks::function_e9873ef7(self.var_22a05c26.kstype, self.killstreak_id, #"auto_detonation");
      }

      self killstreak_vehicle::function_1f46c433();
    }
  }
}

function function_f3170551() {
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"veh_landed");
    bundle = killstreaks::get_script_bundle("recon_car");

    if(isDefined(bundle.var_b771831a)) {
      a_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
      str_fx = self getfxfromsurfacetable(bundle.var_b771831a, a_trace[# "surfacetype"]);
      playFX(str_fx, a_trace[# "position"], (0, 0, 1));
    }
  }
}

function function_2087b17f() {
  bundle = killstreaks::get_script_bundle("recon_car");
  trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
  explosionfx = self getfxfromsurfacetable(bundle.var_1c30ba81, trace[# "surfacetype"]);

  if(isDefined(explosionfx)) {
    fxorigin = self gettagorigin("tag_body");

    if(!isDefined(fxorigin)) {
      fxorigin = self.origin;
    }

    playFX(explosionfx, fxorigin, (0, 0, 1));
  }

  playsoundatposition(#"hash_2d5cdc03d392d5ec", self.origin);
}

function function_76817ccc() {
  if(isDefined(self.owner) && isDefined(self.var_22a05c26.kstype)) {
    self.owner killstreaks::function_e9873ef7(self.var_22a05c26.kstype, self.killstreak_id, #"manual_detonation");
  }
}