/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\tripwire_cp.gsc
***********************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "createHintObject", &tripwire_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "canTripTrap", &tripwire_cantriptrap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "damageFunc", &tripwire_damagefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "disarmGiveWeapon", &tripwire_disarmgiveweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "blowTripWire", &ref_13dd2);
}

function tripwire_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawn("script_model", var_0);
  var_11 setModel("tag_origin");
  var_11.angles = (0, 0, 0);

  if(isDefined(var_5)) {
    var_11 setuseholdduration(var_5);
  } else {
    var_11 setuseholdduration("duration_medium");
  }

  if(!isDefined(var_5) || var_5 == "duration_medium" || var_5 == "duration_long") {
    var_11 sethintrequiresholding(1);
  }

  if(isDefined(var_6)) {
    var_11 sethintonobstruction(var_6);
  } else {
    var_11 sethintonobstruction("hide");
  }

  if(isDefined(var_7)) {
    var_11 sethintdisplayrange(var_7);
  } else {
    var_11 sethintdisplayrange(200);
  }

  var_11 sethintdisplayfov(65);

  if(isDefined(var_9)) {
    var_11 setuserange(var_9);
  } else {
    var_11 setuserange(72);
  }

  if(isDefined(var_10)) {
    var_11 setusefov(var_10);
  } else {
    var_11 setusefov(65);
  }

  thread ref_13202();
  level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(self);
  var_3 = &"CP_STRIKE/DEFUSE";
  var_11 setHintString(var_3);
  var_11 setCursorHint("HINT_BUTTON");
  var_11 makeusable();
  return var_11;
}

function ref_13202() {
  self enableplayermarks("equipment");
  self waittill("death");

  if(isDefined(self)) {
    self disableplayermarks("equipment");
    return;
  }
}

function tripwire_cantriptrap(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isPlayer(var_0) && isexplosivedamagemod(var_2) && var_3 > 90) {
    return true;
  }

  if(isPlayer(var_0) && validchallengetimer(var_2) && var_3 > 10) {
    return true;
  }

  if(isPlayer(var_0) && unlockstop(var_0, var_1)) {
    return true;
  }

  return false;
}

function validchallengetimer(var_0) {
  if(scripts\engine\utility::isbulletdamage(var_0)) {
    return true;
  }

  if(var_0 == "MOD_FIRE") {
    return true;
  }

  return false;
}

function unlockstop(var_0, var_1) {
  if(var_1.basename == "emp_drone_player_mp") {
    return true;
  }

  if(var_1.basename == "emp_drone_non_player_mp") {
    return true;
  }

  if(var_1.basename == "emp_drone_non_player_direct_mp") {
    return true;
  }

  return false;
}

function tripwire_damagefunc(var_0, var_1) {
  var_0 disableplayermarks("equipment");

  if(isDefined(var_1) && isPlayer(var_1)) {
    radiusdamage(var_0.origin, 384, 256, 40, undefined, "MOD_SUICIDE", "frag_grenade_mp");
  } else {
    radiusdamage(var_0.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  }

  playrumbleonposition("grenade_rumble", var_0.origin);
  earthquake(0.45, 0.7, var_0.origin, 800);

  if(isDefined(var_1) && isPlayer(var_1)) {
    if(distancesquared(var_1.origin, var_0.origin) < 250000) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "flavor_negative", undefined, 1);
      return;
    }

    return;
  }
}

function tripwire_givegrenade(var_0, var_1) {
  var_2 = "power_frag";

  if(!isstring(var_0)) {
    var_2 = createheadicon(var_0);
  }

  switch (var_2) {
    case "frag":
      var_3 = "power_frag";
      break;
    case "semtex":
      var_3 = "power_semtex";
      break;
    case "c4":
      var_3 = "power_c4";
      break;
    default:
      var_3 = "power_frag";
      break;
  }

  var_4 = 0;

  if(isDefined(var_3.powers[var_3])) {
    var_4 = var_3.powers[var_3].charges;
  }

  var_5 = scripts\cp\cp_loadout::get_num_of_charges_for_power(var_3, "primary");

  if(var_4 >= var_5) {
    var_4 = var_5 - 1;
  }

  var_3 scripts\cp\cp_powers::givepower(var_3, "primary", undefined, undefined, undefined, 0, 1, var_4 + 1);
}

function tripwire_disarmgiveweapon(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isstring(var_0)) {
    var_3 = asmdevgetallstates(var_0);
  }

  if(hasequipmentoftype(var_0, var_2) || should_start_cautious_approach_koth(var_2)) {
    tripwire_givegrenade(var_0, var_2);
  }

  thread play_disarm_operator_vo(level);
}

function hasequipmentoftype(var_0, var_1) {
  var_2 = var_0;

  if(isstring(var_0)) {
    var_2 = asmdevgetallstates(var_0);
  }

  var_3 = var_1.offhandinventory;

  foreach(var_5 in var_3) {
    if(getweaponbasename(var_5) == getweaponbasename(var_2)) {
      return true;
    }

    if(getweaponbasename(var_2) == "frag" && getweaponbasename(var_5) == "frag_grenade_mp") {
      return true;
    }
  }

  return false;
}

function should_start_cautious_approach_koth(var_0) {
  var_1 = 0;
  var_2 = var_0.offhandinventory;

  foreach(var_4 in var_2) {
    var_5 = scripts\cp\utility::getequipmenttype(getweaponbasename(var_4));

    if(isDefined(var_5)) {
      if(var_5 == "lethal") {
        var_1 = 1;
      }
    }
  }

  if(!var_1) {
    return true;
  }

  return false;
}

function issameoffhandtype(var_0, var_1) {
  var_2 = scripts\cp\utility::getequipmenttype(var_0);

  if(!isDefined(var_2)) {
    return false;
  }

  if(var_2 == scripts\cp\utility::getequipmenttype(var_1)) {
    return true;
  }

  return false;
}

function haslethalequipment(var_0) {
  var_1 = var_0.offhandinventory;

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\utility::getequipmenttype(getweaponbasename(var_3));

    if(isDefined(var_4) && var_4 == "lethal") {
      return true;
    }
  }

  return false;
}

function play_disarm_operator_vo(var_0) {
  if(!isDefined(level.vo_tripwire_next_callout_time) || gettime() > level.vo_tripwire_next_callout_time) {
    level.vo_tripwire_next_callout_time = gettime() + 30000;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "ping_enemy_traps", undefined, 0.8);
    return;
  }
}

function ref_13dd2(var_0, var_1) {
  if(isPlayer(var_0) && (var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_PROJECTILE_SPLASH")) {
    var_0 thread scripts\cp\cp_achievement::trapachievementboom(var_0);
    return;
  }
}