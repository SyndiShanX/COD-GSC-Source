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

function tripwire_createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = spawn("script_model", var0);
  var11 setModel("tag_origin");
  var11.angles = (0, 0, 0);

  if(isDefined(var5)) {
    var11 setuseholdduration(var5);
  } else {
    var11 setuseholdduration("duration_medium");
  }

  if(!isDefined(var5) || var5 == "duration_medium" || var5 == "duration_long") {
    var11 sethintrequiresholding(1);
  }

  if(isDefined(var6)) {
    var11 sethintonobstruction(var6);
  } else {
    var11 sethintonobstruction("hide");
  }

  if(isDefined(var7)) {
    var11 sethintdisplayrange(var7);
  } else {
    var11 sethintdisplayrange(200);
  }

  var11 sethintdisplayfov(65);

  if(isDefined(var9)) {
    var11 setuserange(var9);
  } else {
    var11 setuserange(72);
  }

  if(isDefined(var10)) {
    var11 setusefov(var10);
  } else {
    var11 setusefov(65);
  }

  thread ref_13202();
  level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(self);
  var3 = &"CP_STRIKE/DEFUSE";
  var11 setHintString(var3);
  var11 setCursorHint("HINT_BUTTON");
  var11 makeusable();
  return var11;
}

function ref_13202() {
  self enableplayermarks("equipment");
  self waittill("death");

  if(isDefined(self)) {
    self disableplayermarks("equipment");
    return;
  }
}

function tripwire_cantriptrap(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isPlayer(var0) && isexplosivedamagemod(var2) && var3 > 90) {
    return true;
  }

  if(isPlayer(var0) && validchallengetimer(var2) && var3 > 10) {
    return true;
  }

  if(isPlayer(var0) && unlockstop(var0, var1)) {
    return true;
  }

  return false;
}

function validchallengetimer(var0) {
  if(scripts\engine\utility::isbulletdamage(var0)) {
    return true;
  }

  if(var0 == "MOD_FIRE") {
    return true;
  }

  return false;
}

function unlockstop(var0, var1) {
  if(var1.basename == "emp_drone_player_mp") {
    return true;
  }

  if(var1.basename == "emp_drone_non_player_mp") {
    return true;
  }

  if(var1.basename == "emp_drone_non_player_direct_mp") {
    return true;
  }

  return false;
}

function tripwire_damagefunc(var0, var1) {
  var0 disableplayermarks("equipment");

  if(isDefined(var1) && isPlayer(var1)) {
    radiusdamage(var0.origin, 384, 256, 40, undefined, "MOD_SUICIDE", "frag_grenade_mp");
  } else {
    radiusdamage(var0.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  }

  playrumbleonposition("grenade_rumble", var0.origin);
  earthquake(0.45, 0.7, var0.origin, 800);

  if(isDefined(var1) && isPlayer(var1)) {
    if(distancesquared(var1.origin, var0.origin) < 250000) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "flavor_negative", undefined, 1);
      return;
    }

    return;
  }
}

function tripwire_givegrenade(var0, var1) {
  var2 = "power_frag";

  if(!isstring(var0)) {
    var2 = createheadicon(var0);
  }

  switch (var2) {
    case "frag":
      var3 = "power_frag";
      break;
    case "semtex":
      var3 = "power_semtex";
      break;
    case "c4":
      var3 = "power_c4";
      break;
    default:
      var3 = "power_frag";
      break;
  }

  var4 = 0;

  if(isDefined(var3.powers[var3])) {
    var4 = var3.powers[var3].charges;
  }

  var5 = scripts\cp\cp_loadout::get_num_of_charges_for_power(var3, "primary");

  if(var4 >= var5) {
    var4 = var5 - 1;
  }

  var3 scripts\cp\cp_powers::givepower(var3, "primary", undefined, undefined, undefined, 0, 1, var4 + 1);
}

function tripwire_disarmgiveweapon(var0, var1, var2) {
  var3 = var0;

  if(isstring(var0)) {
    var3 = asmdevgetallstates(var0);
  }

  if(hasequipmentoftype(var0, var2) || should_start_cautious_approach_koth(var2)) {
    tripwire_givegrenade(var0, var2);
  }

  thread play_disarm_operator_vo(level);
}

function hasequipmentoftype(var0, var1) {
  var2 = var0;

  if(isstring(var0)) {
    var2 = asmdevgetallstates(var0);
  }

  var3 = var1.offhandinventory;

  foreach(var5 in var3) {
    if(getweaponbasename(var5) == getweaponbasename(var2)) {
      return true;
    }

    if(getweaponbasename(var2) == "frag" && getweaponbasename(var5) == "frag_grenade_mp") {
      return true;
    }
  }

  return false;
}

function should_start_cautious_approach_koth(var0) {
  var1 = 0;
  var2 = var0.offhandinventory;

  foreach(var4 in var2) {
    var5 = scripts\cp\utility::getequipmenttype(getweaponbasename(var4));

    if(isDefined(var5)) {
      if(var5 == "lethal") {
        var1 = 1;
      }
    }
  }

  if(!var1) {
    return true;
  }

  return false;
}

function issameoffhandtype(var0, var1) {
  var2 = scripts\cp\utility::getequipmenttype(var0);

  if(!isDefined(var2)) {
    return false;
  }

  if(var2 == scripts\cp\utility::getequipmenttype(var1)) {
    return true;
  }

  return false;
}

function haslethalequipment(var0) {
  var1 = var0.offhandinventory;

  foreach(var3 in var1) {
    var4 = scripts\cp\utility::getequipmenttype(getweaponbasename(var3));

    if(isDefined(var4) && var4 == "lethal") {
      return true;
    }
  }

  return false;
}

function play_disarm_operator_vo(var0) {
  if(!isDefined(level.vo_tripwire_next_callout_time) || gettime() > level.vo_tripwire_next_callout_time) {
    level.vo_tripwire_next_callout_time = gettime() + 30000;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "ping_enemy_traps", undefined, 0.8);
    return;
  }
}

function ref_13dd2(var0, var1) {
  if(isPlayer(var0) && (var1 == "MOD_GRENADE_SPLASH" || var1 == "MOD_PROJECTILE_SPLASH")) {
    var0 thread scripts\cp\cp_achievement::trapachievementboom(var0);
    return;
  }
}