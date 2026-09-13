/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_251f071833394c68.gsc
***********************************************/

_id_2FCE2F81588A2462() {
  if(!isDefined(level._id_BF8AA3F39F981625))
    level._id_BF8AA3F39F981625 = [];

  level._id_BF8AA3F39F981625[level._id_BF8AA3F39F981625.size] = ::init_juggernaut_damage_states;
}

init_juggernaut_damage_states() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(!scripts\engine\utility::is_equal(self.model, "body_opforce_juggernaut_basebody")) {
    return;
  }
  if(isDefined(level._id_1734DE9810F8E785))
    [[level._id_1734DE9810F8E785]](self);

  create_juggernaut_damagedata("left_arm", 100, ["left_arm_upper", "left_arm_lower", "left_hand"]);
  create_juggernaut_damagedata("right_arm", 100, ["right_arm_upper", "right_arm_lower", "right_hand"]);

  if(!isDefined(self._id_1EC812B92A31CDD3))
    self._id_1EC812B92A31CDD3 = [];

  self._id_1EC812B92A31CDD3[self._id_1EC812B92A31CDD3.size] = ::_id_8B750CA7ECAC8F1F;
}

_id_8B750CA7ECAC8F1F(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname) {
  apply_juggernaut_part_damage(self.damagelocation, idamage);
}

create_juggernaut_damagedata(name, health, parts) {
  data = spawnStruct();
  data.health = health;
  data.is_part_swapped = 0;

  if(!isDefined(self.damagedata))
    self.damagedata = [];

  self.damagedata[name] = data;

  if(!isDefined(self.damagedatalookup))
    self.damagedatalookup = [];

  foreach(part in parts)
  self.damagedatalookup[part] = name;
}

apply_juggernaut_part_damage(location, dmg) {
  if(!isDefined(self.damagedatalookup[location])) {
    return;
  }
  name = self.damagedatalookup[location];
  data = self.damagedata[name];
  data.health = data.health - dmg;

  if(data.health <= 0 && !istrue(data.is_part_swapped)) {
    self setscriptablepartstate(name, "dmg", 1);
    data.is_part_swapped = 1;
  }
}