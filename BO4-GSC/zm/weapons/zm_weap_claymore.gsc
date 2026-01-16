/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_claymore.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\entityheadicons_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\deployable;
#include scripts\weapons\proximity_grenade;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_placeable_mine;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_claymore;

autoexec __init__system__() {
  system::register(#"claymore_zm", &__init__, undefined, undefined);
}

__init__() {
  weaponobjects::function_e6400478(#"claymore", &createclaymorewatcher, 0);
  weaponobjects::function_e6400478(#"claymore_extra", &createclaymorewatcher, 0);
  deployable::register_deployable(getweapon(#"claymore"), &function_4ed6fbd5, undefined, undefined, #"hash_1f65f161716fb57b");
  deployable::register_deployable(getweapon(#"claymore_extra"), &function_4ed6fbd5, undefined, undefined, #"hash_1f65f161716fb57b");
  zm::function_84d343d(#"claymore", &function_84072422);
  zm::function_84d343d(#"claymore_extra", &function_84072422);
  level.var_817314af = 0;
}

function_4ed6fbd5(v_origin, v_angles, player) {
  if(!zm_utility::check_point_in_playable_area(v_origin)) {
    return false;
  }

  return true;
}

function_84072422(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
  var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 30);
  return var_5d7b4163;
}

createclaymorewatcher(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = undefined;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.deleteonplayerspawn = 0;
  watcher.detectiondot = cos(70);
  watcher.detectionmindist = 10;
  watcher.detectiongraceperiod = 0.3;
  watcher.detonateradius = 100;
  watcher.stuntime = 1;
  watcher.ondetonatecallback = &proximitydetonate;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &function_c9893179;
  watcher.stun = &weaponobjects::weaponstun;
  watcher.var_994b472b = &function_aeb91d3;
  watcher.ondamage = &function_cbb2f05b;
}

proximitydetonate(attacker, weapon, target) {
  self thread function_1479a342(attacker, weapon);
  self weaponobjects::weapondetonate(attacker, weapon);
}

function_1479a342(attacker, weapon) {
  v_origin = self.origin;
  w_claymore = self.weapon;
  function_62e8a3();
  a_enemies = getaiteamarray(level.zombie_team);
  var_8345897c = arraysortclosest(a_enemies, v_origin, undefined, 0, w_claymore.explosionradius);
  var_84d440a5 = 0;

  foreach(ai in var_8345897c) {
    if(!isalive(ai)) {
      continue;
    }

    n_dist = distance2d(ai.origin, v_origin);
    n_damage = math::linear_map(n_dist, 0, w_claymore.explosionradius, w_claymore.explosionouterdamage, w_claymore.explosioninnerdamage);
    ai dodamage(int(n_damage), v_origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, w_claymore);
    var_84d440a5++;

    if(var_84d440a5 > 1) {
      waitframe(1);
      var_84d440a5 = 0;
    }
  }

  level.var_817314af--;
}

function_62e8a3(n_count_per_network_frame = 1) {
  while(level.var_817314af > n_count_per_network_frame) {
    waitframe(1);
  }

  level.var_817314af++;
}

function_aeb91d3(player) {
  self weaponobjects::weaponobjectfizzleout();
}

function_c9893179(watcher, player) {
  proximity_grenade::onspawnproximitygrenadeweaponobject(watcher, player);
}

play_claymore_effects(e_planter) {
  self endon(#"death");
  self zm_utility::waittill_not_moving();
}

claymore_detonation(e_planter) {
  self endon(#"death");
  self zm_utility::waittill_not_moving();
  detonateradius = 96;
  damagearea = spawn("trigger_radius", self.origin, (512 | 1) + 8, detonateradius, detonateradius * 2);
  damagearea setexcludeteamfortrigger(self.owner.team);
  damagearea enablelinkto();
  damagearea linkto(self);

  if(isDefined(self.isonbus) && self.isonbus) {
    damagearea setmovingplatformenabled(1);
  }

  self.damagearea = damagearea;
  self thread delete_mines_on_death(self.owner, damagearea);

  if(!isDefined(self.owner.placeable_mines)) {
    self.owner.placeable_mines = [];
  } else if(!isarray(self.owner.placeable_mines)) {
    self.owner.placeable_mines = array(self.owner.placeable_mines);
  }

  self.owner.placeable_mines[self.owner.placeable_mines.size] = self;

  while(true) {
    waitresult = damagearea waittill(#"trigger");
    ent = waitresult.activator;

    if(isDefined(self.owner) && ent == self.owner) {
      continue;
    }

    if(isDefined(ent.pers) && isDefined(ent.pers[#"team"]) && ent.pers[#"team"] == self.team) {
      continue;
    }

    if(isDefined(ent.ignore_placeable_mine) && ent.ignore_placeable_mine) {
      continue;
    }

    if(!ent should_trigger_claymore(self)) {
      continue;
    }

    if(ent damageconetrace(self.origin, self) > 0) {
      self playSound(#"wpn_claymore_alert");
      wait 0.4;

      if(isDefined(self.owner)) {
        self detonate(self.owner);
        return;
      }

      self detonate(undefined);
      return;
    }
  }
}

private should_trigger_claymore(e_mine) {
  n_detonation_dot = cos(70);
  pos = self.origin + (0, 0, 32);
  dirtopos = pos - e_mine.origin;
  objectforward = anglesToForward(e_mine.angles);
  dist = vectordot(dirtopos, objectforward);

  if(dist < 20) {
    return false;
  }

  dirtopos = vectornormalize(dirtopos);
  dot = vectordot(dirtopos, objectforward);
  return dot > n_detonation_dot;
}

private delete_mines_on_death(player, ent) {
  self waittill(#"death");

  if(isDefined(player)) {
    arrayremovevalue(player.placeable_mines, self);
  }

  waitframe(1);

  if(isDefined(ent)) {
    ent delete();
  }
}

function_cbb2f05b(watcher) {
  self endon(#"death", #"hacked", #"detonating");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.var_18acfe18 = 0;
  self.var_966835e3 = 150;

  while(true) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    damage = waitresult.amount;
    type = waitresult.mod;
    idflags = waitresult.flags;
    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
    self.var_18acfe18 += damage;

    if(!isplayer(attacker) && isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }

    if(isDefined(weapon)) {
      self weaponobjects::weapon_object_do_damagefeedback(weapon, attacker);
    }

    if(self.var_18acfe18 >= self.var_966835e3) {
      break;
    }
  }

  if(level.weaponobjectexplodethisframe) {
    wait 0.1 + randomfloat(0.4);
  } else {
    waitframe(1);
  }

  level.weaponobjectexplodethisframe = 1;
  self thread weaponobjects::resetweaponobjectexplodethisframe();
  self entityheadicons::setentityheadicon("none");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && idflags&8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;
  watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
}