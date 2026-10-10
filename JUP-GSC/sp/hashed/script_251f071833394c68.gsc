/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_251f071833394c68.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_7c0e88f32463912b;

function function_2fce2f81588a2462() {
  if(!isDefined(level.var_bf8aa3f39f981625)) {
    level.var_bf8aa3f39f981625 = [];
  }

  level.var_bf8aa3f39f981625[level.var_bf8aa3f39f981625.size] = &init_juggernaut_damage_states;
}

function init_juggernaut_damage_states() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(!is_equal(self.model, "body_opforce_juggernaut_basebody")) {
    return;
  }

  if(isDefined(level.var_1734de9810f8e785)) {
    [[level.var_1734de9810f8e785]](self);
  }

  create_juggernaut_damagedata("left_arm", 100, ["left_arm_upper", "left_arm_lower", "left_hand"]);
  create_juggernaut_damagedata("right_arm", 100, ["right_arm_upper", "right_arm_lower", "right_hand"]);

  if(!isDefined(self.var_1ec812b92a31cdd3)) {
    self.var_1ec812b92a31cdd3 = [];
  }

  self.var_1ec812b92a31cdd3[self.var_1ec812b92a31cdd3.size] = &function_8b750ca7ecac8f1f;
}

function private function_8b750ca7ecac8f1f(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname) {
  apply_juggernaut_part_damage(self.damagelocation, idamage);
}

function private create_juggernaut_damagedata(name, health, parts) {
  data = spawnStruct();
  data.health = health;
  data.is_part_swapped = 0;

  if(!isDefined(self.damagedata)) {
    self.damagedata = [];
  }

  self.damagedata[name] = data;

  if(!isDefined(self.damagedatalookup)) {
    self.damagedatalookup = [];
  }

  foreach(part in parts) {
    self.damagedatalookup[part] = name;
  }
}

function private apply_juggernaut_part_damage(location, dmg) {
  if(!isDefined(self.damagedatalookup[location])) {
    return;
  }

  name = self.damagedatalookup[location];
  data = self.damagedata[name];
  data.health -= dmg;

  if(data.health <= 0 && !istrue(data.is_part_swapped)) {
    self setscriptablepartstate(name, "dmg", 1);
    data.is_part_swapped = 1;
  }
}