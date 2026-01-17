/*********************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_tactical_rig_proximitydeterrent.gsc
*********************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_dev;
#using scripts\cp\cybercom\_cybercom_gadget_system_overload;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_tacrig_proximitydeterrent;

function init() {}

function main() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  cybercom_tacrig::register_cybercom_rig_ability("cybercom_proximitydeterrent", 2);
  cybercom_tacrig::register_cybercom_rig_possession_callbacks("cybercom_proximitydeterrent", &proximitydeterrentgive, &proximitydeterrenttake);
  cybercom_tacrig::register_cybercom_rig_activation_callbacks("cybercom_proximitydeterrent", &proximitydeterrentactivate, &proximitydeterrentdeactivate);
}

function on_player_connect() {}

function on_player_spawned() {}

function proximitydeterrentgive(type) {
  self.cybercom.var_a9774972 = getweapon("gadget_proximity_det");
  self.cybercom.var_f4b9137e = getweapon("gadget_es_strike");
  if(!isDefined(self.cybercom.var_d7d9f704)) {
    self.cybercom.var_d7d9f704 = [];
    self.cybercom.var_d7d9f704[0] = spawnStruct();
    self.cybercom.var_d7d9f704[1] = spawnStruct();
    self.cybercom.var_d7d9f704[2] = spawnStruct();
    self.cybercom.var_d7d9f704[3] = spawnStruct();
    self.cybercom.var_d7d9f704[0].time = 0;
    self.cybercom.var_d7d9f704[1].time = 0;
    self.cybercom.var_d7d9f704[2].time = 0;
    self.cybercom.var_d7d9f704[3].time = 0;
  }
  self thread function_f5590749();
  self thread proximitydeterrentthink(type);
}

function proximitydeterrenttake(type) {
  self.cybercom.var_a9774972 = undefined;
  self notify("proximitydeterrenttake");
}

function proximitydeterrentthink(type) {
  self notify("proximitydeterrentthink");
  self endon("proximitydeterrentthink");
  self endon("disconnect");
  self endon("take_ability_" + type);
  while(true) {
    self waittill("damage", n_damage, e_attacker, v_vector, v_point, str_means_of_death, str_string_1, str_string_2, str_string_3, w_weapon);
    if(issubstr(str_means_of_death, "MOD_MELEE") && isDefined(e_attacker)) {
      self.cybercom.proximity_deterrent_target = e_attacker;
      self cybercom_tacrig::turn_rig_ability_on(type);
      self thread function_ae8e24a7(e_attacker);
    }
  }
}

function function_f5590749() {
  self endon("proximitydeterrenttake");
  while(true) {
    curtime = gettime();
    var_f9459f98 = undefined;
    var_2f0e78d0 = 0;
    for(zone = 0; zone < 4; zone++) {
      if(self.cybercom.var_d7d9f704[zone].time > curtime) {
        attacker = self.cybercom.var_d7d9f704[zone].attacker;
        if(isDefined(attacker)) {
          self.cybercom.var_d7d9f704[zone].yaw = self cybercom::getyawtospot(attacker.origin);
        }
        if(self.cybercom.var_d7d9f704[zone].time > var_2f0e78d0) {
          var_2f0e78d0 = self.cybercom.var_d7d9f704[zone].time;
          var_f9459f98 = zone;
        }
        continue;
      }
      if(self.cybercom.var_d7d9f704[zone].time != 0) {
        self.cybercom.var_d7d9f704[zone].time = 0;
        self.cybercom.var_d7d9f704[zone].attacker = undefined;
        self.cybercom.var_d7d9f704[zone].yaw = undefined;
      }
    }
    if(isDefined(var_f9459f98)) {
      self clientfield::set_player_uimodel("playerAbilities.proximityIndicatorIntensity", 1);
      self clientfield::set_player_uimodel("playerAbilities.proximityIndicatorDirection", var_f9459f98);
    } else {
      self clientfield::set_player_uimodel("playerAbilities.proximityIndicatorIntensity", 0);
    }
    wait(0.05);
  }
}

function function_ae8e24a7(attacker) {
  yaw = self cybercom::getyawtospot(attacker.origin);
  if(yaw > -45 && yaw <= 45) {
    zone = 0;
  } else {
    if(yaw > 45 && yaw <= 135) {
      zone = 3;
    } else {
      if(yaw > 135 && yaw <= 180 || (yaw >= -180 && yaw < -135)) {
        zone = 2;
      } else {
        zone = 1;
      }
    }
  }
  self.cybercom.var_d7d9f704[zone].time = gettime() + getdvarint("scr_proximity_indicator_durationMSEC", 1500);
  self.cybercom.var_d7d9f704[zone].attacker = attacker;
  self.cybercom.var_d7d9f704[zone].yaw = yaw;
}

function proximitydeterrentactivate(type) {
  if(isDefined(self.cybercom.proximity_deterrent_target)) {
    self.cybercom.proximity_deterrent_target thread proximitydeterrentonattacker(type, self);
  }
  self cybercom_tacrig::turn_rig_ability_off(type);
}

function proximitydeterrentdeactivate(type) {}

function proximitydeterrentonattacker(type, player) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(player.cybercom.tacrigs_disabled) && player.cybercom.tacrigs_disabled) {
    return;
  }
  if(isDefined(self.nocybercom) && self.nocybercom) {
    return;
  }
  player playSound("gdt_cybercore_rig_prox_activate");
  level thread _stunassailant(player, self, player hascybercomrig(type) == 2);
}

function private _stunassailant(player, attacker, upgraded) {
  attacker endon("death");
  if(!isDefined(attacker.archetype)) {
    return;
  }
  switch (attacker.archetype) {
    case "human":
    case "human_riotshield":
    case "zombie": {
      var_36a3e6ad = "J_Wrist_LE";
      fx = level._effect["es_effect_human"];
      tag = "j_spine4";
      damage = attacker.health;
      weapon = player.cybercom.var_a9774972;
      if(isDefined(attacker.voiceprefix) && isDefined(attacker.bcvoicenumber)) {
        attacker thread battlechatter::do_sound((attacker.voiceprefix + attacker.bcvoicenumber) + "_exert_electrocution", 1);
      }
      break;
    }
    case "robot": {
      var_36a3e6ad = "J_Wrist_LE";
      fx = level._effect["es_effect_robot"];
      attacker playSound("fly_bot_disable");
      tag = "j_spine4";
      damage = attacker.health;
      weapon = player.cybercom.var_f4b9137e;
      break;
    }
    case "warlord": {
      var_36a3e6ad = "J_Wrist_LE";
      fx = level._effect["es_effect_warlord"];
      tag = "j_spine4";
      damage = getdvarint("scr_proximity_stun_damage_to_warlord", 60);
      weapon = player.cybercom.var_a9774972;
      break;
    }
    case "direwolf": {
      var_36a3e6ad = "J_Wrist_LE";
      fx = level._effect["es_effect_generic"];
      tag = "tag_origin";
      damage = attacker.health;
      weapon = player.cybercom.var_a9774972;
      break;
    }
    default: {
      var_36a3e6ad = "J_Wrist_LE";
      tag = "tag_origin";
      fx = level._effect["es_effect_generic"];
      damage = attacker.health;
      weapon = player.cybercom.var_a9774972;
      break;
    }
  }
  if(isDefined(upgraded) && upgraded) {
    level thread function_c0ba5acc(player, attacker);
  }
  playFXOnTag(level._effect["es_contact"], player, var_36a3e6ad);
  playFXOnTag(fx, attacker, tag);
  attacker playSound("gdt_cybercore_rig_prox_imp");
  attacker dodamage(damage, player.origin, player, player, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
}

function function_c0ba5acc(player, attacker, radius) {
  enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
  if(!isDefined(radius)) {
    var_119472f5 = getdvarint("scr_proximity_stun_discharge_radius", 144) * getdvarint("scr_proximity_stun_discharge_radius", 144);
  } else {
    var_119472f5 = radius * radius;
  }
  var_4c0d9ab5 = [];
  foreach(guy in enemies) {
    if(isDefined(attacker) && guy == attacker) {
      continue;
    }
    if(isvehicle(guy)) {
      continue;
    }
    if(!isDefined(guy.archetype)) {
      continue;
    }
    if(isDefined(guy.nocybercom) && guy.nocybercom) {
      continue;
    }
    if(guy.takedamage == 0) {
      continue;
    }
    distsq = distancesquared(player.origin, guy.origin);
    if(distsq > var_119472f5) {
      continue;
    }
    var_4c0d9ab5[var_4c0d9ab5.size] = guy;
    if(var_4c0d9ab5.size >= getdvarint("scr_proximity_stun_max_secondary_hits", 6)) {
      break;
    }
  }
  foreach(guy in var_4c0d9ab5) {
    level thread function_a38f70a1(player, guy);
  }
}

function private function_c8e11a8b(ent, note) {
  ent endon("death");
  self waittill(note);
  ent delete();
}

function private function_a38f70a1(player, target) {
  target endon("death");
  player endon("disconnect");
  orb = spawn("script_model", player.origin + vectorscale((0, 0, 1), 45));
  orb setModel("tag_origin");
  playFXOnTag(level._effect["es_arc"], orb, "tag_origin");
  orb endon("death");
  target thread function_c8e11a8b(orb, "death");
  player thread function_c8e11a8b(orb, "disconnect");
  orb moveto(target.origin + vectorscale((0, 0, 1), 45), 0.3);
  orb waittill("movedone");
  target playSound("gdt_cybercore_rig_prox_imp");
  damage = getdvarint("scr_proximity_stun_damage", 20);
  switch (target.archetype) {
    case "human":
    case "human_riotshield":
    case "zombie": {
      fx = level._effect["es_effect_human"];
      tag = "j_spine4";
      target dodamage(damage, player.origin, player, player, "none", "MOD_UNKNOWN", 0, player.cybercom.var_a9774972, -1, 1);
      target notify("bhtn_action_notify", "electrocute");
      break;
    }
    case "robot": {
      fx = level._effect["es_effect_robot"];
      tag = "j_spine4";
      target thread cybercom_gadget_system_overload::system_overload(player);
      break;
    }
    case "warlord": {
      fx = level._effect["es_effect_warlord"];
      tag = "j_spine4";
      target dodamage(damage, player.origin, player, player, "none", "MOD_UNKNOWN", 0, player.cybercom.var_a9774972, -1, 1);
      break;
    }
    case "direwolf": {
      fx = level._effect["es_effect_generic"];
      tag = "tag_origin";
      target dodamage(damage, player.origin, player, player, "none", "MOD_UNKNOWN", 0, player.cybercom.var_a9774972, -1, 1);
      break;
    }
    default: {
      fx = level._effect["es_effect_generic"];
      tag = "tag_body";
      target dodamage(damage, player.origin, player, player, "none", "MOD_GRENADE_SPLASH", 0, getweapon("emp_grenade"), -1, 1);
      break;
    }
  }
  playFX(level._effect["es_contact"], orb.origin);
  playFXOnTag(fx, target, tag);
  orb delete();
}

function function_327bda1e(idamage, damagemod) {
  if(!issubstr(damagemod, "_MELEE")) {
    return idamage;
  }
  status = self hascybercomrig("cybercom_proximitydeterrent");
  reducer = (status == 2 ? getdvarfloat("scr_proximity_damage_reducer_upg", 0.1) : getdvarfloat("scr_proximity_damage_reducer", 0.2));
  var_bc6c098a = int(idamage * reducer);
  return var_bc6c098a;
}