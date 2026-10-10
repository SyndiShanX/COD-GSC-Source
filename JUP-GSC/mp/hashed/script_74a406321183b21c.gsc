/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_74a406321183b21c.gsc
*************************************************/

#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\equipment;
#namespace namespace_200cccfc0de17d4e;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, &createaction, 2000);
}

function evaluatescore(bot) {
  equippedsuper = bot.equipment["super"];

  if(!isDefined(equippedsuper)) {
    return 0;
  }

  var_7211c2f25e275c26 = "equip_munitionsbox";
  var_a3ba12c6175cdc5f = "equip_armorbox";

  if(equippedsuper == var_a3ba12c6175cdc5f) {
    var_5324597edfaff57c = bot scripts\mp\equipment::getequipmentslotammo("health");

    if(isDefined(var_5324597edfaff57c) && var_5324597edfaff57c >= 2) {
      return 0;
    }
  } else if(equippedsuper == var_7211c2f25e275c26) {
    primaryweapon = bot.primaryweaponobj;
    supportweapon = ["rifle", "smg", "sniper", "mg"];
    var_6be76f0842d9ed3f = 1;

    if(isDefined(primaryweapon)) {
      primaryweaponclass = weaponclass(primaryweapon);

      foreach(item in supportweapon) {
        if(primaryweaponclass == item) {
          var_6be76f0842d9ed3f = 0;
          break;
        }
      }
    }

    if(var_6be76f0842d9ed3f) {
      return 0;
    }

    if(bot isammoenough(primaryweapon, 0.3)) {
      return 0;
    }

    grenadearray = getEntArray("grenade", "classname");
    usedbefore = 0;

    foreach(item in grenadearray) {
      issameteam = isDefined(item.team) && item.team == bot.team;
      isammobox = isDefined(item.weapon_name) && item.weapon_name == "support_box_mp";
      isnearby = isDefined(item.origin) && distancesquared(bot.origin, item.origin) < self.constants.var_2070b5f48167a4a;

      if(issameteam && isammobox && isnearby) {
        usedbefore = 1;
        break;
      }
    }

    if(usedbefore) {
      return 0;
    }
  } else {
    return 0;
  }

  return self.constants.basescore;
}

function createaction(bot) {
  return createactionbase("Use field upgrade box", undefined, "main", bot.equipment["super"], &actionprocess, self, &function_f4caae7e8af9d32c);
}

function actionprocess(bot) {
  bot botsetflag("disable_movement", 1);
  self.var_e042806c3ece447a = 1;

  while(bot isgestureplaying()) {
    wait 0.1;
  }

  bot enableoffhandweapons();
  bot enableoffhandspecialweapons();
  bot botlookatpoint(bot gettagorigin("j_mainroot"), 0.75);
  bot botpressbutton("special", 0.5);

  function_f3cf203834e48c6d("<dev string:x1c>");
  logstring("<dev string:x2c>" + bot.name + "<dev string:x45>");

  wait 4;

  function_f3cf203834e48c6d("<dev string:x5c>");

  bot botsetflag("disable_movement", 0);
  thrownbox = bot function_d244cc7c3f9b8eae();

  if(!isDefined(thrownbox)) {
    var_6a7656aecbf92e60 = "[Mind] Use field upgrade failed: ";
    var_6a7656aecbf92e60 += ter_op(bot isswitchingweapon(), ", IsSwitchingWeapon", "");
    var_6a7656aecbf92e60 += ter_op(bot isreloading(), ", IsReloading", "");
    var_6a7656aecbf92e60 += ter_op(bot ismantling(), ", IsMantling", "");
    var_6a7656aecbf92e60 += ter_op(bot isthrowinggrenade(), ", IsThrowingGrenade", "");
    var_6a7656aecbf92e60 += ter_op(bot israisingweapon(), ", IsRaisingWeapon", "");
    var_6a7656aecbf92e60 += ter_op(bot ismeleeing(), ", IsMeleeing", "");
    var_6a7656aecbf92e60 += ter_op(bot isparachuting(), ", IsParachuting", "");
    var_6a7656aecbf92e60 += ter_op(bot isskydiving(), ", IsSkydiving", "");
    var_6a7656aecbf92e60 += ter_op(bot issprintsliding(), ", IsSprintSliding", "");
    var_6a7656aecbf92e60 += ter_op(bot isjumping(), ", IsJumping", "");
    var_6a7656aecbf92e60 += ter_op(bot isswimming(), ", IsSwimming", "");
    var_6a7656aecbf92e60 += ter_op(bot isswimunderwater(), ", IsSwimUnderwater", "");
    var_6a7656aecbf92e60 += ter_op(istrue(bot.inlaststand), ", IsInLastStand", "");
    var_6a7656aecbf92e60 += ", bot stance:" + bot getstance() + "\n";
    assertmsg("<dev string:x60>" + var_6a7656aecbf92e60);
    return "No supply box thrown";
  }

  targetpos = function_f8350ab882cc2439(thrownbox.origin);
  bot setscriptgoal(targetpos, 32);

  while(true) {
    result = bot waittill_any_in_array_or_timeout(["goal", "bad_path"], 5);

    if(result == "goal") {
      bot botlookatpoint(targetpos, 0.75);
      bot botpressbutton("use", 0.5);
      break;
    }

    if(result != "timeout") {
      return result;
    }
  }
}

function function_f4caae7e8af9d32c(action) {
  if(function_d57dd414963503d1()) {
    if(action.var_e042806c3ece447a) {
      self.equipment["super"] = undefined;
    }

    self botsetflag("disable_movement", 0);
  }
}

function function_d244cc7c3f9b8eae() {
  grenadearray = getEntArray("grenade", "classname");
  thrownbox = undefined;

  foreach(item in grenadearray) {
    if(isDefined(item.owner) && item.owner == self) {
      if(!isDefined(thrownbox) || item.birthday > thrownbox.birthday) {
        thrownbox = item;
      }
    }
  }

  return thrownbox;
}