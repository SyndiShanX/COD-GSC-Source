/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\cp_explosive_barrel.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace cp_explosive_barrel;

function private autoexec __init__system__() {
  system::register(#"cp_explosive_barrel", &preload, undefined, undefined, undefined);
}

function preload() {
  init_clientfields();
  init_fx();
}

function init_clientfields() {
  clientfield::register("scriptmover", "barrel_effects", 1, 2, "int", &function_c4e043ee, 0, 0);
  clientfield::register("scriptmover", "barrel_effects_fire", 1, 1, "int", &function_fa9bea36, 0, 0);
}

function init_fx() {
  level._effect[# "hash_6eed38de2452398a"] = "maps/cp_rus_siege/fx9_fire_gas_leak_impact_sm_runner";
  level._effect[# "hash_2713fd7d423c75c5"] = "maps/cp_rus_siege/fx9_exp_fuel_barrel_runner";
  level._effect[# "hash_254b2ba7e3542938"] = "destruct/fx8_red_barrel_fire";
}

function function_c4e043ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!isDefined(self.var_59419da4)) {
    self.var_59419da4 = [];
  }

  if(bwastimejump == 1) {
    self.notifyonbulletimpact = 1;
    self thread function_f1bf9643(fieldname);
    return;
  }

  if(bwastimejump == 2) {
    waitframe(1);
    n_fx = playFX(fieldname, level._effect[# "hash_2713fd7d423c75c5"], self.origin);
    snd::play("exp_incindiary_large", self.origin);
    self thread function_c1e7f821(fieldname, n_fx);
    self notify(#"exploded");
    waitframe(1);

    foreach(n_fx in self.var_59419da4) {
      snd::stop(level.var_d83adbeb);
      killfx(fieldname, n_fx);
    }
  }
}

function function_c1e7f821(localclientnum, n_fx) {
  self endon(#"death");
  e_sound = snd::play("evt_incendiary_fire_barrel_sm", self.origin + (0, 0, 40));

  while(isfxplaying(localclientnum, n_fx)) {
    waitframe(1);
  }

  snd::stop(e_sound, 0.25);
}

function function_f1bf9643(localclientnum) {
  self endon(#"death", #"exploded");

  while(self.var_59419da4.size < 7) {
    var_e5818e0c = self waittill(#"damage");
    self function_e14eea31(localclientnum, var_e5818e0c, level._effect[# "hash_6eed38de2452398a"]);
  }
}

function function_e14eea31(localclientnum, var_26fce16e, fx) {
  self endon(#"death");

  if(isDefined(var_26fce16e.position) && isDefined(var_26fce16e.direction)) {
    n_fx = playFX(localclientnum, fx, var_26fce16e.position, var_26fce16e.direction * -1);

    if(!isDefined(self.var_59419da4)) {
      self.var_59419da4 = [];
    } else if(!isarray(self.var_59419da4)) {
      self.var_59419da4 = array(self.var_59419da4);
    }

    self.var_59419da4[self.var_59419da4.size] = n_fx;

    if(self.var_59419da4.size == 1) {
      level.var_d83adbeb = snd::play("evt_incendiary_fire_barrel_sm", self.origin + (0, 0, 40));
    }
  }
}

function function_fa9bea36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump && !is_true(self.destroyed)) {
    self function_ad8beac(fieldname, level._effect[# "hash_254b2ba7e3542938"]);
  }
}

function function_ad8beac(localclientnum, fx) {
  n_fx = playFX(localclientnum, fx, self.origin + (10, 0, 40));

  if(!isDefined(self.var_59419da4)) {
    self.var_59419da4 = [];
  } else if(!isarray(self.var_59419da4)) {
    self.var_59419da4 = array(self.var_59419da4);
  }

  self.var_59419da4[self.var_59419da4.size] = n_fx;
}