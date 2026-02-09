/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_gibs;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\util_shared;
#namespace namespace_eaa992c;

function init() {
  level._effect["def_explode"] = "explosions/fx_exp_grenade_default";
  level._effect["impact_raygun"] = "zombie/fx_raygun_impact_zmb";
  level._effect["impact_raygun1"] = "zombie/fx_raygun_impact_zmb";
  level._effect["impact_raygun2"] = "zombie/fx_blood_torso_explo_lg_os_zmb";
  level._effect["impact_rpg"] = "zombie/fx_blood_torso_explo_lg_os_zmb";
  level._effect["ground_pound"] = "zombie/fx_turret_impact_doa";
  level._effect["truck_splash"] = "water/fx_water_splash_doa_truck";
  function_6dcb1bbc("boots", 1);
  function_6dcb1bbc("magnet_on", 2);
  function_6dcb1bbc("magnet_fade", 2);
  function_6dcb1bbc("stunbear", 4);
  function_6dcb1bbc("stunbear_fade", 5);
  function_6dcb1bbc("glow_red", 6);
  function_6dcb1bbc("glow_green", 7);
  function_6dcb1bbc("glow_blue", 8);
  function_6dcb1bbc("glow_yellow", 9);
  function_6dcb1bbc("glow_white", 10);
  function_6dcb1bbc("glow_item", 11);
  function_6dcb1bbc("timeshift", 12);
  function_6dcb1bbc("timeshift_fade", 12);
  function_6dcb1bbc("tesla_launch", 14);
  function_6dcb1bbc("tesla_trail", 15);
  function_6dcb1bbc("tesla_shock", 16);
  function_6dcb1bbc("tesla_shock_eyes", 17);
  function_6dcb1bbc("hazard_electric", 18);
  function_6dcb1bbc("player_respawn_green", 19);
  function_6dcb1bbc("player_respawn_blue", 70);
  function_6dcb1bbc("player_respawn_red", 71);
  function_6dcb1bbc("player_respawn_yellow", 72);
  function_6dcb1bbc("hazard_water", 20);
  function_6dcb1bbc("stoneboss_shield_death", 27);
  function_6dcb1bbc("stoneboss_shield_explode", 28);
  function_6dcb1bbc("stoneboss_death", 21);
  function_6dcb1bbc("stoneboss_dmg1", 22);
  function_6dcb1bbc("stoneboss_dmg2", 23);
  function_6dcb1bbc("stoneboss_dmg3", 24);
  function_6dcb1bbc("stoneboss_dmg4", 25);
  function_6dcb1bbc("stoneboss_dmg5", 26);
  function_6dcb1bbc("fate_impact", 29);
  function_6dcb1bbc("fate_trigger", 30);
  function_6dcb1bbc("fate_explode", 31);
  function_6dcb1bbc("fate_launch", 32);
  function_6dcb1bbc("fate2_awarded", 33);
  function_6dcb1bbc("def_explode", 34);
  function_6dcb1bbc("fire_trail", 35);
  function_6dcb1bbc("veh_takeoff", 36);
  function_6dcb1bbc("egg_hatch", 37);
  function_6dcb1bbc("egg_explode", 38);
  function_6dcb1bbc("monkey_explode", 39);
  function_6dcb1bbc("boss_takeoff", 40);
  function_6dcb1bbc("sprinkler_land", 41);
  function_6dcb1bbc("sprinkler_takeoff", 42);
  function_6dcb1bbc("sprinkler_active", 43);
  function_6dcb1bbc("red_shield", 44);
  function_6dcb1bbc("timeshift_contact", 45);
  function_6dcb1bbc("stunbear_contact", 46);
  function_6dcb1bbc("tesla_ball", 47);
  function_6dcb1bbc("chicken_explode", 48);
  function_6dcb1bbc("gem_trail_red", 49);
  function_6dcb1bbc("gem_trail_white", 50);
  function_6dcb1bbc("gem_trail_blue", 51);
  function_6dcb1bbc("gem_trail_green", 52);
  function_6dcb1bbc("gem_trail_yellow", 53);
  function_6dcb1bbc("trail_fast", 54);
  function_6dcb1bbc("margwa_intro", 55);
  function_6dcb1bbc("margwa_head_explode", 56);
  function_6dcb1bbc("slow_feet", 57);
  function_6dcb1bbc("player_trail_green", 58);
  function_6dcb1bbc("player_trail_blue", 59);
  function_6dcb1bbc("player_trail_red", 60);
  function_6dcb1bbc("player_trail_yellow", 61);
  function_6dcb1bbc("fast_feet", 64);
  function_6dcb1bbc("fury_patch", 63);
  function_6dcb1bbc("fury_boost", 62);
  function_6dcb1bbc("turret_impact", 65);
  function_6dcb1bbc("crater_dust", 66);
  function_6dcb1bbc("blow_hole", 67);
  function_6dcb1bbc("teleporter", 68);
  function_6dcb1bbc("egg_hatchXL", 69);
  function_6dcb1bbc("boxing_pow", 73);
  function_6dcb1bbc("boxing_stars", 74);
  function_6dcb1bbc("player_flashlight", 75);
  function_6dcb1bbc("meatball_trail", 76);
  function_6dcb1bbc("stunbear_affected", 77);
  function_6dcb1bbc("cow_explode", 78);
  function_6dcb1bbc("cow_sacred", 79);
  function_6dcb1bbc("ammo_infinite", 80);
  function_6dcb1bbc("player_shield_short", 81);
  function_6dcb1bbc("player_shield_long", 82);
  function_6dcb1bbc("incoming_impact", 83);
  function_6dcb1bbc("sparkle_silver", 84);
  function_6dcb1bbc("sparkle_gold", 85);
  function_6dcb1bbc("player_trail_green_night", 86);
  function_6dcb1bbc("player_trail_blue_night", 87);
  function_6dcb1bbc("player_trail_red_night", 88);
  function_6dcb1bbc("player_trail_yellow_night", 89);
  function_6dcb1bbc("headshot", 90);
  function_6dcb1bbc("headshot_nochunks", 91);
  function_6dcb1bbc("bloodspurt", 92);
  function_6dcb1bbc("silverback_intro", 93);
  function_6dcb1bbc("silverback_intro_explo", 94);
  function_6dcb1bbc("silverback_intro_trail1", 95);
  function_6dcb1bbc("silverback_intro_trail2", 96);
  function_6dcb1bbc("silverback_banana_explo", 97);
  function_6dcb1bbc("explo_warning_light_banana", 98);
  function_6dcb1bbc("explo_warning_light", 99);
  function_6dcb1bbc("shadow_fade", 100);
  function_6dcb1bbc("shadow_move", 101);
  function_6dcb1bbc("shadow_appear", 102);
  function_6dcb1bbc("shadow_die", 103);
  function_6dcb1bbc("shadow_glow", 104);
  function_6dcb1bbc("meatball_impact", 105);
  function_6dcb1bbc("bomb", 106);
  function_6dcb1bbc("cyber_eye", 107);
  function_6dcb1bbc("spawnZombie", 108);
  function_6dcb1bbc("reviveAdvertise", 109);
  function_6dcb1bbc("reviveActive", 110);
  function_6dcb1bbc("reviveCredit", 111);
  function_6dcb1bbc("down_marker_green", 112);
  function_6dcb1bbc("down_marker_blue", 113);
  function_6dcb1bbc("down_marker_red", 114);
  function_6dcb1bbc("down_marker_yellow", 115);
  function_6dcb1bbc("electrical_surge", 116);
  function_6dcb1bbc("blue_eyes", 117);
  function_6dcb1bbc("zombie_angry", 118);
  function_6dcb1bbc("teamShift", 120);
  function_6dcb1bbc("teamShift_contact", 119);
  function_6dcb1bbc("web_contact", 121);
}

function function_6dcb1bbc(name, type) {
  assert(type < 128, "");
  if(!isDefined(level.doa.var_1142e0a2)) {
    level.doa.var_1142e0a2 = [];
  }
  level.doa.var_1142e0a2[name] = type;
}

function function_39dbe45b(name) {
  if(!isDefined(name)) {
    return;
  }
  assert(isDefined(level.doa.var_1142e0a2[name]), "");
  return level.doa.var_1142e0a2[name];
}

function function_81e169ac() {
  self endon("death");
  while(isDefined(self) && gettime() < self.var_b2ce38d9) {
    wait(0.05);
  }
  if(isDefined(self)) {
    self.var_b2ce38d9 = gettime() + 200;
  }
}

function function_1f8cb1fa() {
  self endon("death");
  while(isDefined(self) && gettime() < self.var_78c14ec2) {
    wait(0.05);
  }
  if(isDefined(self)) {
    self.var_78c14ec2 = gettime() + 200;
  }
}

function function_64bc2503(&queue, flag, waitfunc, var_a6cc22d4 = 0) {
  self endon("death");
  if(!var_a6cc22d4) {
    self notify("fxProcessQueue_" + flag);
    self endon("fxProcessQueue_" + flag);
  }
  if(queue.size >= 16) {
    foreach(item in queue) {
      doa_utility::debugmsg("" + item);
    }
    assert(0, "" + queue[15]);
  }
  self[[waitfunc]]();
  if(queue.size == 0 && isDefined(self)) {
    self clientfield::set(flag, 0);
    self notify("hash_6a404ade");
    return;
  }
  var_1b0298c0 = function_39dbe45b(queue[0]);
  arrayremoveindex(queue, 0, 0);
  if(isDefined(self) && isDefined(var_1b0298c0)) {
    self clientfield::set(flag, var_1b0298c0);
    self function_64bc2503(queue, flag, waitfunc, 1);
  }
}

function turnofffx(name) {
  if(!isDefined(name) || !isDefined(self)) {
    return;
  }
  self notify("turnofffx");
  self endon("turnofffx");
  self endon("death");
  assert(!(isPlayer(self) && name == ""));
  assert(!(isPlayer(self) && name == ""));
  if(!isDefined(self.var_350c7e91)) {
    self.var_350c7e91 = [];
    self.var_78c14ec2 = 0;
  }
  if(isDefined(self.var_3930cdff)) {
    arrayremovevalue(self.var_3930cdff, name);
  }
  if(!isinarray(self.var_350c7e91, name)) {
    self.var_350c7e91[self.var_350c7e91.size] = name;
  }
  self function_64bc2503(self.var_350c7e91, "off_fx", &function_1f8cb1fa);
  level notify("hash_67a1310c");
}

function function_285a2999(name) {
  if(!isDefined(name) || !isDefined(self)) {
    return;
  }
  self notify("hash_285a2999");
  self endon("hash_285a2999");
  self endon("death");
  assert(!(isPlayer(self) && name == ""));
  assert(!(isPlayer(self) && name == ""));
  if(!isDefined(self.var_3930cdff)) {
    self.var_3930cdff = [];
    self.var_b2ce38d9 = 0;
  }
  if(isinarray(self.var_3930cdff, name)) {
    return;
  }
  if(isDefined(self.var_350c7e91)) {
    arrayremovevalue(self.var_350c7e91, name);
  }
  self.var_3930cdff[self.var_3930cdff.size] = name;
  self function_64bc2503(self.var_3930cdff, "play_fx", &function_81e169ac);
}

function function_2fc7e62f(victim, damage, attacker, dir, smeansofdeath, weapon) {
  if(weapon == level.doa.var_f5fcdb51) {
    playFX(level._effect["impact_raygun1"], victim.origin + vectorscale((0, 0, 1), 40));
  } else {
    if(weapon == level.doa.var_e30c10ec) {
      playFX(level._effect["impact_raygun2"], victim.origin + vectorscale((0, 0, 1), 40));
      if(isDefined(attacker)) {
        attacker notify("hash_21f7a743", victim);
      }
    } else {
      playFX(level._effect["impact_raygun"], victim.origin + vectorscale((0, 0, 1), 40));
    }
  }
}

function function_2c0f7946(victim, damage, attacker, dir, smeansofdeath, weapon) {
  playFX(level._effect["impact_rpg"], victim.origin + vectorscale((0, 0, 1), 40));
}

function function_f51d2b7e(victim, damage, attacker, dir, smeansofdeath, weapon) {
  if(!isDefined(level.doa.var_f6ac2080)) {
    level.doa.var_f6ac2080 = 6;
  }
  if(!isDefined(level.doa.var_b86d53a5)) {
    level.doa.var_b86d53a5 = 3;
  }
  dir = vectornormalize(dir + (0, 0, level.doa.var_b86d53a5));
  dir = dir * level.doa.var_f6ac2080;
  if(!(isDefined(victim.boss) && victim.boss)) {
    victim namespace_fba031c8::function_ddf685e8(dir, attacker);
  }
}

function function_4f66d2fb(victim, damage, attacker, dir, smeansofdeath, weapon) {
  function_2aa1c0b3(victim, damage, attacker, dir, smeansofdeath, weapon);
}

function function_2aa1c0b3(victim, damage, attacker, dir, smeansofdeath, weapon) {
  if(isDefined(victim.boss) && victim.boss) {
    return;
  }
  if(isDefined(victim.burning) && victim.burning) {
    return;
  }
  if(isDefined(victim.nofire) && victim.nofire) {
    return;
  }
  if(issubstr(weapon.name, "_1")) {
    victim clientfield::set("burnType", 2);
    victim.var_7aac5112 = 2;
  } else {
    if(issubstr(weapon.name, "_2")) {
      victim clientfield::set("burnType", 3);
      victim.var_7aac5112 = 3;
    } else {
      victim clientfield::set("burnType", 1);
      victim.var_7aac5112 = 1;
    }
  }
  victim.burning = 1;
  wait(0.05);
  if(isDefined(victim) && isactor(victim)) {
    victim thread function_32bcda58(victim.var_7aac5112, attacker);
    victim clientfield::increment("burnZombie");
    victim thread function_9fc6e261(victim.var_7aac5112);
    if(!isDefined(victim.var_dd70dacd)) {
      victim asmsetanimationrate(0.75);
    }
  }
}

function function_32bcda58(var_7aac5112, attacker) {
  self notify("hash_e32770a3");
  self endon("hash_e32770a3");
  self endon("death");
  dmg = getdvarint("scr_doa_dot_burn_dmg", 120) * var_7aac5112;
  if(!isDefined(self.var_a27665f9)) {
    self.var_a27665f9 = 0;
  }
  var_1b22f058 = getdvarint("scr_doa_dot_max_inc", 3);
  while(isalive(self)) {
    self dodamage(dmg, self.origin, attacker);
    wait(0.3);
    if(var_1b22f058 > 0 && (self.var_a27665f9 % getdvarint("scr_doa_dot_burn_fx_rate", 30)) == 0) {
      var_1b22f058--;
      self clientfield::increment("burnZombie");
    }
    self.var_a27665f9++;
  }
}

function private function_9fc6e261(type) {
  self waittill("actor_corpse", corpse);
  wait(0.05);
  if(isDefined(corpse)) {
    corpse clientfield::set("burnType", type);
    wait(0.05);
    if(isDefined(corpse)) {
      corpse clientfield::increment("burnCorpse");
      if(randomint(100) < 50) {
        corpse clientfield::set("enemy_ragdoll_explode", 1);
      }
    }
  }
}