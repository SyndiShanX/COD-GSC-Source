/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\shockrifle.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_power;
#include scripts\abilities\gadgets\gadget_radiation_field;
#include scripts\core_common\audio_shared;
#include scripts\core_common\bots\bot_stance;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\weapons\weaponobjects;

#namespace shockrifle;

init_shared() {
  clientfield::register("toplayer", "shock_rifle_shocked", 1, 1, "int");
  clientfield::register("toplayer", "shock_rifle_damage", 1, 1, "int");
  clientfield::register("allplayers", "shock_rifle_sound", 1, 1, "int");
  level.shockrifleweapon = getweapon(#"shock_rifle");

  if(isDefined(level.shockrifleweapon.customsettings)) {
    level.var_a5ff950 = getscriptbundle(level.shockrifleweapon.customsettings);
  } else {
    level.var_a5ff950 = getscriptbundle("shock_rifle_custom_settings");
  }

  weaponobjects::function_e6400478(#"shock_rifle", &function_c1aa8f6b, 0);
  globallogic_score::function_a458dbe1(#"shock_rifle_shock", &function_95a892a);
  callback::on_connecting(&onplayerconnect);
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self clientfield::set_to_player("shock_rifle_damage", 0);
  self clientfield::set("shock_rifle_sound", 0);
}

onplayerconnect() {
  profilestart();
  self callback::on_player_killed(&onplayerkilled);
  profilestop();
}

onplayerkilled() {
  self function_3474c820();
}

function_95a892a(attacker, victim, var_3d1ed4bd, attackerweapon, meansofdeath) {
  if(!isDefined(var_3d1ed4bd) || !isDefined(attackerweapon) || var_3d1ed4bd == attackerweapon) {
    return false;
  }

  return true;
}

function_c1aa8f6b(watcher) {
  watcher.watchforfire = 1;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.detectiongraceperiod = 0;
  watcher.detonateradius = level.var_a5ff950.var_9c0267f2 + 50;
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.timeout = level.var_a5ff950.shockduration;
  watcher.ondetonatecallback = &function_7ce0a335;
  watcher.activationdelay = 0;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.immunespecialty = "specialty_immunetriggershock";
  watcher.onspawn = &function_aa6e2f52;
  watcher.ondamage = &function_bcc47944;
  watcher.ontimeout = &function_7ce0a335;
  watcher.onfizzleout = &function_7ce0a335;
}

function_a0081b68(ent) {
  self endon(#"death");
  ent waittill(#"death");
  wait level.var_a5ff950.var_e6dccd20;
  self function_7ce0a335(undefined, undefined, undefined);
}

function_aa6e2f52(watcher, owner) {
  self endon(#"death");
  self.protected_entities = [];
  self.hit_ents = [];
  self.var_7471e7b7 = 0;
  self setCanDamage(0);
  waitresult = self waittill(#"grenade_stuck");
  waitframe(2);

  if(!isDefined(waitresult.hitent)) {
    return;
  }

  if(isDefined(waitresult.hitent.isdog) && waitresult.hitent.isdog) {
    watcher.timeout = 0.75;
  } else {
    watcher.timeout = level.var_a5ff950.shockduration;
  }

  self playSound("prj_lightning_impact_human_fatal");
  self thread function_a0081b68(waitresult.hitent);

  if(!isactor(waitresult.hitent)) {
    self function_92eabc2f(waitresult.hitent, 1);
  }

  playFXOnTag("weapon/fx8_hero_sig_shockrifle_spike_active", self, "tag_fx");
  wait isDefined(level.var_a5ff950.var_aded392d) ? level.var_a5ff950.var_aded392d : 0;

  if(isDefined(waitresult.hitent) && isDefined(owner) && util::function_fbce7263(waitresult.hitent.team, owner.team)) {
    self thread function_5fff8c45(watcher, waitresult.hitent);
  }

  self.owner = owner;
}

function_7cc07921(ent) {
  if(distancesquared(self.origin, ent.origin) <= level.var_a5ff950.var_9c0267f2 * level.var_a5ff950.var_9c0267f2) {
    return true;
  }

  return false;
}

function_a6beb598(notifystr) {
  if(!isDefined(self) || !isDefined(self.submunition)) {
    return;
  }

  self.submunition function_7ce0a335(undefined, undefined, undefined);
}

function_5fff8c45(watcher, hitent) {
  self endon(#"death", #"hacked", #"kill_target_detection");

  if(isDefined(hitent)) {
    hitent endoncallback(&function_a6beb598, #"hash_16c7de1837351e82");
    hitent.submunition = self;
  }

  damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
  up = anglestoup(self.angles);
  traceorigin = self.origin + up;

  while(self.var_7471e7b7 < level.var_a5ff950.var_1fb6bd43) {
    waitresult = damagearea waittill(#"trigger");
    ent = waitresult.activator;

    if(isDefined(self.detonating) && self.detonating) {
      return;
    }

    if(!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent)) {
      continue;
    }

    if(weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent)) {
      continue;
    }

    if(!function_7cc07921(ent)) {
      continue;
    }

    if(function_33020ed7(ent)) {
      continue;
    }

    if(!isplayer(ent)) {
      continue;
    }

    if(ent damageconetrace(traceorigin, self) > 0) {
      self thread function_92eabc2f(ent, 0);
    }
  }

  function_7ce0a335(undefined, undefined, undefined);
}

function_33020ed7(ent) {
  for(i = 0; i < self.hit_ents.size; i++) {
    if(self.hit_ents[i] == ent) {
      return true;
    }
  }

  return false;
}

function_c23ed15d(ent, shockduration) {
  if(isDefined(ent.hittime) && ent.hittime + shockduration + int((isDefined(level.var_a5ff950.var_80cecde8) ? level.var_a5ff950.var_80cecde8 : 0) * 1000) > gettime()) {
    return true;
  }

  return false;
}

function_a64504d2() {
  shockduration = level.var_a5ff950.shockduration;

  if(isplayer(self)) {
    var_341cbc9e = self function_aa61b0b();

    if(var_341cbc9e) {
      shockduration *= var_341cbc9e;
    }
  }

  return shockduration;
}

deleteobjective(objectiveid) {
  objective_delete(objectiveid);
  gameobjects::release_obj_id(objectiveid);
}

function_13c7b967(owner) {
  if(isDefined(self.var_c3f76d52)) {
    return;
  }

  obj_id = gameobjects::get_next_obj_id();
  objective_add(obj_id, "invisible", self.origin, #"shockrifle_shocked");
  objective_onentity(obj_id, self);
  objective_setvisibletoall(obj_id);
  objective_setteam(obj_id, owner getteam());
  function_da7940a3(obj_id, 1);
  objective_setinvisibletoplayer(obj_id, self);
  function_3ae6fa3(obj_id, owner getteam(), 0);
  objective_setstate(obj_id, "active");
  self.var_c3f76d52 = obj_id;
}

function_3474c820() {
  if(!isDefined(self.var_c3f76d52)) {
    return;
  }

  deleteobjective(self.var_c3f76d52);
  self.var_c3f76d52 = undefined;
}

function_5439aa67(shockcharge) {
  self endon(#"death", #"shock_end");

  while(isDefined(self)) {
    if(self isplayerswimming()) {
      if(isDefined(shockcharge)) {
        self dodamage(10000, shockcharge.origin, shockcharge.owner, shockcharge, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
        return;
      }

      self dodamage(10000, self.origin, undefined, undefined, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
      return;
    }

    waitframe(1);
  }
}

watchfordeath() {
  self waittill(#"death");
  self clientfield::set("shock_rifle_sound", 0);
}

function_c80bac1f(shockcharge, var_51415470, shockduration) {
  self endon(#"death");
  self ability_player::function_fc4dc54(1);
  self.hittime = gettime();
  owner = shockcharge.owner;
  damagepos = shockcharge.origin;
  var_40aed931 = 0;

  if(var_40aed931) {
    self function_13c7b967(owner);
  }

  self playSound("wpn_shockrifle_bounce");

  if(isplayer(self)) {
    self thread function_5439aa67(shockcharge);
    self freezecontrolsallowlook(1);
  }

  shocked_hands = getweapon(#"shocked_hands");
  var_cb36e12 = getweapon(#"hash_19abd3767bd1566d");
  self giveweapon(shocked_hands);
  self switchtoweaponimmediate(shocked_hands, 1);
  prevstance = self getstance();
  self setstance("crouch");
  self disableweaponcycling();
  firstraisetime = isDefined(shocked_hands.firstraisetime) ? shocked_hands.firstraisetime : 1;
  wait firstraisetime;
  self allowcrouch(1);
  self allowprone(0);
  self allowstand(0);
  self giveweapon(var_cb36e12);
  self switchtoweaponimmediate(var_cb36e12, 1);

  if(isplayer(self)) {
    self freezecontrolsallowlook(0);
    self clientfield::set_to_player("shock_rifle_shocked", 1);
    self clientfield::set("shock_rifle_sound", 1);
  }

  if(isDefined(owner) && util::function_fbce7263(self.team, owner.team)) {
    if(var_51415470) {
      scoreevents::processscoreevent(#"hash_6f0ec202863eacd", owner, self, level.shockrifleweapon);
    } else {
      scoreevents::processscoreevent(#"tempest_shock_chain", owner, self, level.shockrifleweapon);
    }
  }

  wait shockduration;

  if(isDefined(self)) {
    self notify(#"hash_16c7de1837351e82");
  }

  self.var_beee9523 = 0;
  self function_3474c820();
  playsoundatposition(#"hash_f2b6a97233cbeb2", self.origin);

  if(isplayer(self)) {
    self clientfield::set_to_player("shock_rifle_shocked", 0);
    self clientfield::set_to_player("shock_rifle_damage", 0);
    self clientfield::set("shock_rifle_sound", 0);
  }

  self enableweaponcycling();
  self takeweapon(var_cb36e12);
  self takeweapon(shocked_hands);
  self killstreaks::switch_to_last_non_killstreak_weapon(1, 0, 0);
  self waittill(#"weapon_change");
  self setstance(prevstance);
  self allowprone(1);
  self allowstand(1);
  self notify(#"shock_end");
}

function_e0141557(ent, var_51415470) {
  damage = var_51415470 ? level.var_a5ff950.impactdamage : level.var_a5ff950.shockdamage;
  isplayer = isplayer(ent);

  if(isDefined(ent.var_beee9523) && ent.var_beee9523) {
    damage = 10000;
  } else if(isDefined(ent.var_dda9b735) && isDefined(ent.var_dda9b735.isshocked) && ent.var_dda9b735.isshocked) {
    damage = 10000;
  } else if(isplayer && ent isplayerswimming()) {
    damage = 10000;
  } else if((isplayer || isbot(ent)) && (ent isremotecontrolling() || ent.currentweapon.statname == #"recon_car")) {
    damage = 10000;
  }

  damagescalar = isplayer ? ent function_6e30f4a3() : 1;
  return damage * damagescalar;
}

function_92eabc2f(ent, var_51415470) {
  ent endon(#"death");
  self endon(#"death");
  self.hit_ents[self.hit_ents.size] = ent;
  self.var_7471e7b7++;

  if(isplayer(ent) && isDefined(ent.var_d44d1214)) {
    ent gadget_radiation_field::shutdown(1);
  }

  if(!var_51415470) {
    var_3e74fd3b = spawn("script_model", self.origin);
    var_3e74fd3b setModel("tag_origin");
    tag = ent gettagorigin("j_spineupper");

    if(!isDefined(tag)) {
      tag = ent.origin;
    }

    var_6fad972 = spawn("script_model", tag);
    var_6fad972 setModel("tag_origin");
    beamlaunch(var_3e74fd3b, var_6fad972, "tag_origin", "tag_origin", level.shockrifleweapon);
    level thread function_1c34cd1b(var_3e74fd3b);
    level thread function_1c34cd1b(var_6fad972);
  }

  ent.var_e8bb749a = 1;
  damage = function_e0141557(ent, var_51415470);
  ent dodamage(damage, self.origin, self.owner, self, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
  ent.var_beee9523 = 1;
  shockduration = ent function_a64504d2();
  params = getstatuseffect(#"shock_rifle_shock");
  ent status_effect::status_effect_apply(params, level.shockrifleweapon, self.owner, 0, int((shockduration + level.var_a5ff950.var_772f6a9c) * 1000), undefined, self.origin);
  isplayer = isplayer(ent);

  if(isplayer) {
    ent clientfield::set_to_player("shock_rifle_damage", 1);
  }

  if(!function_c23ed15d(ent, shockduration) && isplayer) {
    if(ent clientfield::get_to_player("vision_pulse_active") == 1) {
      ent[[level.shutdown_vision_pulse]](0, 1, ent.var_1ad61d27);
      waitframe(1);
    }

    ent thread function_c80bac1f(self, var_51415470, shockduration);
    return;
  }

  ent playSound("wpn_shockrifle_bounce");
}

function_7ce0a335(attacker, weapon, target) {
  self endon(#"death");

  if(isDefined(self.detonating) && self.detonating) {
    return;
  }

  self.detonating = 1;
  playFX(#"hash_788f36f3ae067065", self.origin);
  self ghost();
  self notsolid();
  self stoploopsound(0.5);
  wait level.var_a5ff950.shockduration + 1;
  self delete();
}

function_1c34cd1b(object) {
  wait 5;
  object delete();
}

function_bcc47944(watcher) {
  self endon(#"death");
  damagemax = 20;
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.damagetaken = 0;
  attacker = undefined;

  while(true) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    damage = waitresult.amount;
    type = waitresult.mod;
    idflags = waitresult.flags;

    if(weapon == level.shockrifleweapon) {
      continue;
    }

    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
    attacker = self[[level.figure_out_attacker]](waitresult.attacker);

    if(!isplayer(attacker)) {
      continue;
    }

    if(level.teambased) {
      if(!level.hardcoremode && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker) {
        continue;
      }
    }

    if(watcher.stuntime > 0 && weapon.dostun) {
      self thread weaponobjects::stunstart(watcher, watcher.stuntime);
    }

    if(damage::friendlyfirecheck(self.owner, attacker)) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        attacker damagefeedback::update();
      }
    }

    if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken += damage;
    }

    if(self.damagetaken >= damagemax) {
      watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
      return;
    }
  }
}