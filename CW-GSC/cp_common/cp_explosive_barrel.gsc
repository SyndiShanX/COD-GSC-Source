/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\cp_explosive_barrel.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\util;
#namespace cp_explosive_barrel;

function private autoexec __init__system__() {
  system::register(#"cp_explosive_barrel", &preload, &postload, undefined, undefined);
}

function preload() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("scriptmover", "barrel_effects", 1, 2, "int");
  clientfield::register("scriptmover", "barrel_effects_fire", 1, 1, "int");
}

function postload() {
  callback::function_c046382d(&function_f1582254);
  level thread function_573bc4d2();
}

function function_f1582254(s_params) {
  if(isDefined(s_params.eattacker) && s_params.eattacker.targetname === "cp_explosive_barrel") {
    level.var_85b00b2b = # "hash_15e17b6bf6d3ac93";
    level.var_30eb363 = # "hash_4c1c409797e3d6ee";
  }
}

function function_573bc4d2() {
  var_cd88ab02 = getEntArray("cp_explosive_barrel", "targetname");

  foreach(var_fc3729bf in var_cd88ab02) {
    function_8d10f6be(var_fc3729bf);
  }
}

function function_8d10f6be(var_fc3729bf) {
  var_fc3729bf.var_ccfafb9 = 0.01;
  var_fc3729bf.var_628bf12a = 260;
  var_fc3729bf.var_b5183cec = 260;
  var_fc3729bf.var_369a1b0e = 25;
  var_fc3729bf.var_40545cd8 = 200;
  var_fc3729bf.var_ac267381 = 1;

  if(isDefined(var_fc3729bf.var_3029be11) && var_fc3729bf.var_3029be11 != -1) {
    var_fc3729bf.var_628bf12a = var_fc3729bf.var_3029be11;
  }

  if(isDefined(var_fc3729bf.damage_min) && var_fc3729bf.damage_min != -1) {
    var_fc3729bf.var_369a1b0e = var_fc3729bf.damage_min;
  }

  if(isDefined(var_fc3729bf.var_a7069114) && var_fc3729bf.var_a7069114 != -1) {
    var_fc3729bf.var_40545cd8 = var_fc3729bf.var_a7069114;
  }

  if(isDefined(var_fc3729bf.var_12000c02) && var_fc3729bf.var_12000c02 != -1) {
    var_fc3729bf.var_ac267381 = var_fc3729bf.var_12000c02;
  }

  if(isDefined(var_fc3729bf.damage_radius) && var_fc3729bf.damage_radius != -1) {
    var_fc3729bf.var_b5183cec = var_fc3729bf.damage_radius;
  }

  var_fc3729bf thread function_fa18dccd();
}

function function_fa18dccd() {
  self endon(#"death");
  self setCanDamage(1);
  self val::set(#"explosive_barrel", "allowdeath", 0);
  self.var_eb129d54 = 0;
  self.var_a5b25d88 = 0;
  self.b_exploded = 0;
  self clientfield::set("barrel_effects", 1);

  while(!self.var_a5b25d88) {
    s_results = self waittill(#"damage");

    if(s_results hms_util::function_1062a852() || s_results.mod === "MOD_PISTOL_BULLET" || s_results.mod === "MOD_RIFLE_BULLET") {
      self.var_a5b25d88 = 1;
    }
  }

  if(isDefined(s_results.weapon) && s_results.weapon hms_util::function_17fe30b7() || s_results hms_util::function_1062a852()) {
    self function_e8f2c360(s_results);
  } else if(isDefined(s_results.attacker) && isvehicle(s_results.attacker)) {
    self dodamage(10000, self.origin);
  } else {
    self thread function_cba8ac4e();
  }

  var_767445cc = undefined;

  if(self.health > 1) {
    var_767445cc = "barrel" + self getentitynumber();
    badplace_cylinder(var_767445cc, 0, self.origin, self.var_628bf12a, self.var_628bf12a, "allies", "axis", "neutral");
  }

  while(self.health > 1) {
    n_damage = 10;
    self dodamage(n_damage, self.origin);
    wait 0.1;
  }

  if(isDefined(var_767445cc)) {
    badplace_delete(var_767445cc);
  }

  waitframe(1);
  self notify(#"exploding");
  self clientfield::set("barrel_effects", 2);
  wait 0.1;
  self clientfield::set("barrel_effects", 0);
  self clientfield::set("barrel_effects_fire", 0);
  var_bdf01ff7 = randomintrange(1, 3);
  self setModel("p9_rus_barrel_explosive_red_01_dmg_0" + var_bdf01ff7);
  physicsexplosionsphere(self.origin + (0, 0, 50), self.var_628bf12a, self.var_ccfafb9, self.var_ac267381);
  radiusdamage(self.origin + (0, 0, 25), self.var_b5183cec, self.var_40545cd8, self.var_369a1b0e, self, "MOD_EXPLOSIVE");
  self.b_exploded = 1;
}

function function_cba8ac4e() {
  self endon(#"death", #"exploding");

  while(true) {
    s_results = self waittill(#"damage");

    if(isDefined(s_results.weapon) && s_results.weapon hms_util::function_17fe30b7() || s_results hms_util::function_1062a852()) {
      self function_e8f2c360(s_results);
      continue;
    }

    if(isDefined(s_results.attacker) && isvehicle(s_results.attacker)) {
      self dodamage(10000, self.origin);
    }
  }
}

function function_e8f2c360(s_results, var_79480c68 = 7) {
  n_damage = s_results.amount;
  n_damage *= var_79480c68;

  if(n_damage < self.health && !self.var_eb129d54) {
    self clientfield::set("barrel_effects_fire", 1);
    self.var_eb129d54 = 1;
  }

  self dodamage(n_damage, self.origin);
}