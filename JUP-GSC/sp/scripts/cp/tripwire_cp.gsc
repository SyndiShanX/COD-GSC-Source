/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\tripwire_cp.gsc
***********************************************/

#using scripts\anim\battlechatter;
#using scripts\common\utility;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_achievement;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\equipment;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#namespace tripwire_cp;

function init() {
  scripts\engine\utility::registersharedfunc("tripwire", "init", &function_fd2cc3a566c5a280);
  scripts\engine\utility::registersharedfunc("tripwire", "createHintObject", &tripwire_createhintobject);
  scripts\engine\utility::registersharedfunc("tripwire", "canTripTrap", &tripwire_cantriptrap);
  scripts\engine\utility::registersharedfunc("tripwire", "damageFunc", &tripwire_damagefunc);
  scripts\engine\utility::registersharedfunc("tripwire", "disarmGiveWeapon", &tripwire_disarmgiveweapon);
  scripts\engine\utility::registersharedfunc("tripwire", "blowTripWire", &tripwire_trackachievementboom);
  scripts\engine\utility::registersharedfunc("tripwire", "createLootDropInfo", &createlootdropinfo);
  scripts\engine\utility::registersharedfunc("tripwire", "spawnPickup", &scripts\cp\pickups::spawnpickup);
}

function function_fd2cc3a566c5a280() {
  setDvar(@ "hash_492741ff5b4afd4a", 1);
  level thread function_c119a25a61ffcb35();
}

function tripwire_createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  use_model = spawn("script_model", hintpos);
  use_model setModel("tag_origin");
  use_model.angles = (0, 0, 0);
  use_model makeusable();

  if(isDefined(duration)) {
    use_model setuseholdduration(duration);
  } else {
    use_model setuseholdduration("duration_medium");
  }

  if(!isDefined(duration) || duration == "duration_medium" || duration == "duration_long") {
    use_model sethintrequiresholding(1);
  }

  if(isDefined(onobstruction)) {
    use_model sethintonobstruction(onobstruction);
  } else {
    use_model sethintonobstruction("hide");
  }

  if(isDefined(hintdist)) {
    use_model sethintdisplayrange(hintdist);
  } else {
    use_model sethintdisplayrange(200);
  }

  use_model sethintdisplayfov(65);

  if(isDefined(level.var_ca6cc42c53b63433)) {
    use_model setuserange(level.var_ca6cc42c53b63433);
  } else if(isDefined(usedist)) {
    use_model setuserange(usedist);
  } else {
    use_model setuserange(72);
  }

  if(isDefined(usefov)) {
    use_model setusefov(usefov);
  } else {
    use_model setusefov(65);
  }

  thread setup_player_marks();
  level thread scripts\cp\weapon::add_to_mine_list(self);

  if(isDefined(level.var_93617d996e732d98)) {
    use_model thread[[level.var_93617d996e732d98]]();
  }

  if(isDefined(level.var_e7cbc54feb458782)) {
    use_model thread[[level.var_e7cbc54feb458782]]();
  }

  if(!isDefined(level.tripwire_defuses)) {
    level.tripwire_defuses = [];
  }

  level.tripwire_defuses[level.tripwire_defuses.size] = use_model;
  use_model thread function_3525aa896a01c0ba();
  hintstring = &"CP_STRIKE/DEFUSE";
  use_model setHintString(hintstring);
  use_model setCursorHint("HINT_BUTTON");
  return use_model;
}

function function_3525aa896a01c0ba() {
  if(!isDefined(level.tripwire_defuses)) {
    return;
  }

  self waittill("death");
  level.tripwire_defuses = array_remove(level.tripwire_defuses, self);
}

function function_dc7db69812defce8(allow) {
  if(!isDefined(level.tripwire_defuses)) {
    return;
  }

  if(istrue(allow)) {
    foreach(defuse_model in level.tripwire_defuses) {
      if(isent(defuse_model)) {
        defuse_model enableplayeruse(self);
      }
    }

    return;
  }

  foreach(defuse_model in level.tripwire_defuses) {
    if(isent(defuse_model)) {
      defuse_model disableplayeruse(self);
    }
  }
}

function setup_player_marks() {
  self enableplayermarks("equipment");
  self waittill("death");

  if(isDefined(self)) {
    self disableplayermarks("equipment");
  }
}

function tripwire_cantriptrap(attacker, objweapon, type, damage, point) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(isPlayer(attacker) && isexplosivedamagemod(type) && damage > 90) {
    return true;
  }

  if(isPlayer(attacker) && istripwiredamagetype(type) && damage > 10) {
    return true;
  }

  if(isPlayer(attacker) && isempdamage(attacker, objweapon)) {
    return true;
  }

  return false;
}

function istripwiredamagetype(type) {
  if(isbulletdamage(type)) {
    return true;
  }

  if(type == "MOD_FIRE") {
    return true;
  }

  return false;
}

function isempdamage(attacker, objweapon) {
  if(objweapon.basename == "emp_drone_player_mp") {
    return true;
  }

  if(objweapon.basename == "emp_drone_non_player_mp") {
    return true;
  }

  if(objweapon.basename == "emp_drone_non_player_direct_mp") {
    return true;
  }

  return false;
}

function tripwire_damagefunc(tripwire_struct, victim) {
  level notify("trigger_reinforcements_if_applicable");

  if(isDefined(level.var_75aebc73793d8c40)) {
    level.var_75aebc73793d8c40 = array_removeundefined(level.var_75aebc73793d8c40);
    var_349b1adb8e32fd9a = getclosest(tripwire_struct.origin, level.var_75aebc73793d8c40);

    if(isDefined(var_349b1adb8e32fd9a)) {
      var_349b1adb8e32fd9a delete();
    }

    level.var_75aebc73793d8c40 = array_removeundefined(level.var_75aebc73793d8c40);
  }

  tripwire_struct disableplayermarks("equipment");

  if(isDefined(victim) && isPlayer(victim)) {
    victim.shouldskipdeathsshield = 1;
  }

  radiusdamage(tripwire_struct.origin, 384, 700, 120, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", tripwire_struct.origin);
  earthquake(0.45, 0.7, tripwire_struct.origin, 800);

  if(isDefined(victim) && isPlayer(victim)) {
    if(distancesquared(victim.origin, tripwire_struct.origin) < 250000) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(victim, #"bc_flavor_player_negative", undefined, 1);
    }
  }
}

function tripwire_givegrenade(weapon, player) {
  weapon_name = "power_frag";

  if(!isstring(weapon)) {
    weapon_name = getcompleteweaponname(weapon);
  }

  switch (weapon_name) {
    case #"hash_a8e4a914fb03a4d5":
      name = "equip_frag";
      break;
    case #"hash_5d11ac1131cddab1":
      name = "equip_semtex";
      break;
    case #"hash_fa1e80f6bd5b8e72":
      name = "equip_c4";
      break;
    default:
      name = "equip_frag";
      break;
  }

  maxcharges = scripts\cp\cp_loadout::get_num_of_charges_for_power(player, "primary");
  var_caf75c2ba47b7261 = scripts\cp_mp\equipment::getequipmentammo(name);
  var_9b4fb988b660eb30 = scripts\cp_mp\equipment::getequipmentmaxammo(name);

  if(var_caf75c2ba47b7261 >= var_9b4fb988b660eb30) {
    var_caf75c2ba47b7261 = var_9b4fb988b660eb30 - 1;
  }

  player scripts\cp_mp\equipment::giveequipment(name, "primary");
  player scripts\cp_mp\equipment::setequipmentammo(name, var_caf75c2ba47b7261 + 1);
}

function tripwire_disarmgiveweapon(weapon, lootname, player, grenade_origin, grenade_angles) {
  objweapon = weapon;

  if(isstring(weapon)) {
    objweapon = makeweaponfromstring(weapon);
  }

  var_f79f311c1ed5a958 = scripts\cp\equipment::function_4fd4273c8a15ac00("equip_frag");

  if(var_f79f311c1ed5a958 != "") {
    if(!isDefined(grenade_origin)) {
      grenade_origin = self.origin;
    }

    if(!isDefined(grenade_angles)) {
      grenade_angles = self.angles;
    }

    dropinfo = scripts\cp\pickups::getitemdropinfo(grenade_origin, grenade_angles);
    item = scripts\cp\pickups::spawnpickup(var_f79f311c1ed5a958, dropinfo);
  }

  if(isDefined(level.var_75aebc73793d8c40)) {
    var_349b1adb8e32fd9a = getclosest(grenade_origin, level.var_75aebc73793d8c40);

    if(isDefined(var_349b1adb8e32fd9a)) {
      var_349b1adb8e32fd9a delete();
    }

    level.var_75aebc73793d8c40 = array_removeundefined(level.var_75aebc73793d8c40);
  }

  if(istrue(level.var_460285f52f6bc514)) {
    level thread function_d9e4a4a56dd99ab3(player, grenade_origin, grenade_angles);
  }

  level thread play_disarm_operator_vo(player);
}

function hasequipmentoftype(weap, player) {
  objweapon = weap;

  if(isstring(weap)) {
    objweapon = makeweaponfromstring(weap);
  }

  equiplist = player.offhandinventory;

  foreach(weapon in equiplist) {
    if(getweaponbasename(weapon) == getweaponbasename(objweapon)) {
      return true;
    }

    if(getweaponbasename(objweapon) == "frag" && getweaponbasename(weapon) == "frag_grenade_mp") {
      return true;
    }
  }

  return false;
}

function hasnolethalequipment(player) {
  var_edc29cd611c294cd = 0;
  equiplist = player.offhandinventory;

  foreach(weapon in equiplist) {
    weapon_type = scripts\cp\utility::getequipmenttype(getweaponbasename(weapon));

    if(isDefined(weapon_type)) {
      if(weapon_type == "lethal") {
        var_edc29cd611c294cd = 1;
      }
    }
  }

  if(!var_edc29cd611c294cd) {
    return true;
  }

  return false;
}

function issameoffhandtype(weapon, objweapon) {
  weapon_type = scripts\cp\utility::getequipmenttype(weapon);

  if(!isDefined(weapon_type)) {
    return false;
  }

  if(weapon_type == scripts\cp\utility::getequipmenttype(objweapon)) {
    return true;
  }

  return false;
}

function haslethalequipment(player) {
  equiplist = player.offhandinventory;

  foreach(weapon in equiplist) {
    weapon_type = scripts\cp\utility::getequipmenttype(getweaponbasename(weapon));

    if(isDefined(weapon_type) && weapon_type == "lethal") {
      return true;
    }
  }

  return false;
}

function play_disarm_operator_vo(player) {
  if(!isDefined(level.vo_tripwire_next_callout_time) || gettime() > level.vo_tripwire_next_callout_time) {
    level.vo_tripwire_next_callout_time = gettime() + 30000;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, #"ping_equipment_lethal_generic_hostile", undefined, 0.8);
  }
}

function tripwire_trackachievementboom(attacker, type) {
  if(isPlayer(attacker) && (type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH")) {
    attacker thread scripts\cp\cp_achievement::trapachievementboom(attacker);
  }
}

function createlootdropinfo(baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44) {
  return scripts\cp\pickups::getitemdroporiginandangles(0, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44);
}

function function_7bda4e577b34a556() {
  if(!isDefined(level.tripwires) || !isDefined(level.tripwires.traps)) {
    return;
  }

  foreach(tripwire in level.tripwires.traps) {
    if(isDefined(tripwire.deletefunc)) {
      tripwire[[tripwire.deletefunc]]();
    }
  }

  wait 1;

  foreach(tripwire in level.tripwires.tripwires) {
    if(isent(tripwire)) {
      tripwire delete();
    }
  }
}

function function_d9e4a4a56dd99ab3(player, object_origin, object_angles, dist_override) {
  nearby_ai = getaiarray("axis");
  dist = ter_op(isDefined(dist_override), dist_override, 512);
  nearby_ai = scripts\anim\battlechatter::getaiinrange(object_origin, dist);

  if(isDefined(nearby_ai) && nearby_ai.size > 0) {
    nearby_ai = sortbydistance(nearby_ai, object_origin);
  } else {
    nearby_ai = [];
  }

  count = min(nearby_ai.size, 10);

  for(i = 0; i < count; i++) {
    waitframe();
    count_ratio = (i + 1) / count;

    if(percent_chance((1 - count_ratio) * 30)) {
      continue;
    }

    guy = nearby_ai[i];

    if(!isalive(guy)) {
      continue;
    }

    team = guy.team;
    origin = guy.origin;

    if(!isDefined(team) || !isDefined(origin)) {
      continue;
    }

    state = guy scripts\anim\battlechatter::getcombatstate();

    if(!isDefined(state) || !isDefined(guy.team)) {
      continue;
    }

    if(state == "dead" || guy.team == "neutral") {
      continue;
    }

    if(state == "combat" && guy scripts\anim\battlechatter::function_8f59caa9212fcc56()) {
      continue;
    }

    if(scripts\cp\coop_stealth::function_e39a555170607456()) {
      print3d(origin + (0, 0, 100), "<dev string:x1c>", (1, 1, 1), 1, 0.3, 20, 1);
    }

    angles = vectortoangles(object_origin - guy.origin);
    spot = guy.origin + anglesToForward(angles) * 750;
    guy aieventlistenerevent("investigate", player, spot);
    waitframe();
    guy.var_93b8288efb765770 = 90000;
    wait 3 + randomfloat(2);
  }
}

function function_c119a25a61ffcb35() {
  level endon("game_ended");
  wait 3;

  if(!isDefined(level.tripwires) || !isDefined(level.tripwires.traps)) {
    return;
  }

  foreach(trap in level.tripwires.traps) {
    if(isDefined(trap.model) && trap.model == "projectile_c4_v0") {
      trap setscriptablepartstate("effects", "plant", 0);
    }
  }
}