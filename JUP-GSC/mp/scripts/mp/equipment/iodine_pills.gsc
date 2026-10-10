/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\iodine_pills.gsc
****************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\utility\killstreak;
#namespace iodine_pills;

function function_80b2d6867c192094() {
  val::group_register("iodineUse", ["usability", "killstreaks", "supers", "gesture", "weapon_switch", "melee", "armor"]);
}

function function_43fe8ccc8b4e6146(equipmentref, equipmentslot, variantid) {
  if(equipmentref != "equip_iodine_pills") {
    return;
  }
}

function function_d41fe283435e26c4(equipmentref, equipmentslot) {
  if(equipmentref != "equip_iodine_pills") {
    return;
  }
}

function function_7430b01f931d7e4e(grenade, lootpickup) {
  equipuse = undefined;

  if(!isDefined(grenade)) {
    equipuse = 0;
  } else {
    equipuse = 1;
  }

  thread function_9c89631481683dd2(equipuse, lootpickup);
}

function function_9c89631481683dd2(equipuse, lootpickup) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!function_bef9c19cb3be47ef()) {
    return;
  }

  if(!istrue(equipuse)) {
    if(isDefined(lootpickup)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(lootpickup.scriptablename);
      namespace_aead94004cf4c147::function_6f39f9916649ac48(lootid, 1);
    }

    thread function_bbfe4eae6d4cdb6f();
    weaponobj = makeweapon("iodine_pills_mp");
    self giveandfireoffhand(weaponobj);
    self waittill("grenade_fire", grenade, objweapon);
  }

  var_8a7b4dc1a58fc045 = 0;

  if(function_3abd8504e2419fce(self)) {
    var_8a7b4dc1a58fc045 = 1;
  } else {
    self.radiationblock = 1;
  }

  thread function_bc28931a036b205(var_8a7b4dc1a58fc045);
}

function function_bef9c19cb3be47ef() {
  if(istrue(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self))) {
    return false;
  }

  if(scripts\common\utility::isusingremote()) {
    return false;
  }

  if(istrue(self.insertingarmorplate)) {
    return false;
  }

  if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(self isinfreefall() || self isparachuting()) {
    return false;
  }

  if(self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self isgestureplaying()) {
    return false;
  }

  if(self islinked()) {
    return false;
  }

  if(!val::get("offhand_weapons")) {
    return false;
  }

  return true;
}

function function_bbfe4eae6d4cdb6f() {
  self endon("disconnect");
  val::group_set("iodineUse", 0);
  waittill_any_4("grenade_fire", "death", "last_stand_start", "enter_live_ragdoll");
  val::group_reset("iodineUse");
}

function function_7214173379da1591(grenade) {
  if(isDefined(grenade)) {
    grenade delete();
  }
}

function function_bc28931a036b205(var_8a7b4dc1a58fc045) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("iodinePills_duration");
  self endon("iodinePills_duration");
  effectduration = 120;

  if(istrue(var_8a7b4dc1a58fc045)) {
    if(isDefined(self.var_a92738e0c1337805)) {
      remainingduration = self.var_a92738e0c1337805;
      newduration = effectduration + remainingduration;
      effectduration = min(newduration, 240);

      iprintlnbold("<dev string:x1c>" + effectduration);
    }
  }

  while(effectduration > 0) {
    if(!isalive(self)) {
      break;
    }

    self setclientomnvar("ui_iodine_pills", int(ceil(effectduration)));
    self.var_a92738e0c1337805 = effectduration;
    effectduration -= 0.05;
    wait 0.05;
  }

  self setclientomnvar("ui_iodine_pills", 0);
  self.radiationblock = undefined;
  self.var_ba4ca459c2788f09 = undefined;

  iprintlnbold("<dev string:x61>");
}

function function_ac74ff0686d2886e(damage) {
  if(isDefined(self.var_ba4ca459c2788f09)) {
    var_7e537db4f2a171ef = self.var_ba4ca459c2788f09 + 2000;

    if(gettime() < var_7e537db4f2a171ef) {
      return 0;
    }
  }

  player = self;

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    damage = scripts\mp\gametypes\br_jugg_common::modifybrgasdamage(damage);
  }

  damage = max(1, int(damage * 0.5));
  self.var_ba4ca459c2788f09 = gettime();

  if(scripts\cp_mp\gasmask::hasgasmask(player)) {
    return damage;
  }

  player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  player scripts\cp_mp\armor::damagearmor(damage);
  player thread scripts\mp\gametypes\br_circle::tryplaycoughaudio(randomintrange(7000, 10000));
  return damage;
}

function function_3abd8504e2419fce(player) {
  return istrue(player.radiationblock);
}