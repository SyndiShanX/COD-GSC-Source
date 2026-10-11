/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_15eddb0fac236a22.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace namespace_4925be476a433a59;

function function_9c138fdbc077542() {
  if(getdvarint(@ "hash_2c0a995859575abf", 1) == 0) {
    return false;
  }

  if(issp() || iscp() || getgametype() == "ob") {
    return false;
  }

  return true;
}

function private function_7e3861fd7026453() {
  if(isDefined(self.var_e557be412f9c91ab)) {
    return self.var_e557be412f9c91ab;
  }

  if(!isPlayer(self) || isai(self)) {
    return 0;
  }

  if(scripts\mp\gamelogic::inprematch() && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return 0;
  }

  if(!isDefined(getpersstat("weapKills"))) {
    function_69043ccdd6af91e1();
    return 0;
  }

  if(!function_9c138fdbc077542()) {
    self.var_e557be412f9c91ab = 0;
  } else if(istrue(level.istrainingcourse)) {
    self.var_e557be412f9c91ab = 0;
  } else {
    self.var_e557be412f9c91ab = 1;
  }

  return self.var_e557be412f9c91ab;
}

function function_e6dddb660c52817() {
  self endon("disconnect");

  if(isPlayer(self)) {
    function_69043ccdd6af91e1();
    function_adcb155953291ec7();
    function_15f9e82b69d4c27a();
  }
}

function function_15f9e82b69d4c27a() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self setclientomnvar("ui_gameplay_telemetry_operatorsKill", isDefined(getpersstat("operatorsKill")) ? getpersstat("operatorsKill") : 0);
    self setclientomnvar("ui_gameplay_telemetry_operatorsKD", isDefined(getpersstat("operatorsKD")) ? getpersstat("operatorsKD") : 0);
    self setclientomnvar("ui_gameplay_telemetry_operatorsDown", isDefined(getpersstat("operatorsDown")) ? getpersstat("operatorsDown") : 0);
    self setclientomnvar("ui_gameplay_telemetry_teamRevive", isDefined(getpersstat("teamRevive")) ? getpersstat("teamRevive") : 0);
    self setclientomnvar("ui_gameplay_telemetry_teamWipe", isDefined(getpersstat("teamWipe")) ? getpersstat("teamWipe") : 0);
  } else {
    childthread function_7018e21062adbaa();
    function_d8eb5fb3b35ed1a1();
    function_f1b4726896f5c0c9();
    self setclientomnvar("ui_gameplay_telemetry_lastkill_dist", isDefined(getpersstat("lastKillRange")) ? getpersstat("lastKillRange") : 0);
  }

  function_298b6dd0b26f13bd();
  self.damagedealt = isDefined(getpersstat("damageDealt")) ? getpersstat("damageDealt") : 0;
}

function function_69043ccdd6af91e1() {
  if(!isDefined(getpersstat("weapKills"))) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      self.pers["weapDowned"] = [];
      self.pers["weapLastKillDistance"] = [];
      self.pers["weapLongestKillDistance"] = [];
    } else {
      self.pers["weapDeaths"] = [];
      self.pers["weapKDRatio"] = [];
      self.pers["weapHeadShotCount"] = [];
      self.pers["weapHeadShotAccuracy"] = [];
    }

    self.pers["weapKills"] = [];
    self.pers["weapShotFired"] = [];
    self.pers["weapShotHit"] = [];
    self.pers["weapAccuracy"] = [];
    self.pers["weapDamageDealt"] = [];
    waitframe();
  }
}

function function_b96bbb38cfb63125() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  initpersstat("operatorsKill");
  self.pers["operatorsKill"]++;
  self setclientomnvar("ui_gameplay_telemetry_operatorsKill", getpersstat("operatorsKill"));
  function_c3599460c850b0f7();
}

function function_c3599460c850b0f7() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  initpersstat("operatorsKD");
  var_1fb741075f72e58d = isDefined(self.pers["operatorsKill"]) ? self.pers["operatorsKill"] : 0;
  self.pers["operatorsKD"] = var_1fb741075f72e58d / max(self.pers["deaths"], 1);
  self setclientomnvar("ui_gameplay_telemetry_operatorsKD", getpersstat("operatorsKD"));
}

function function_ac584dc244d416b1() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  initpersstat("operatorsDown");
  self.pers["operatorsDown"]++;
  self setclientomnvar("ui_gameplay_telemetry_operatorsDown", getpersstat("operatorsDown"));
  function_c29690d78b252bb1();
}

function function_b821fe623180790() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  initpersstat("teamRevive");
  self.pers["teamRevive"]++;
  self setclientomnvar("ui_gameplay_telemetry_teamRevive", getpersstat("teamRevive"));
}

function function_8c38798d6a558ad0() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  initpersstat("teamWipe");
  self.pers["teamWipe"]++;
  self setclientomnvar("ui_gameplay_telemetry_teamWipe", getpersstat("teamWipe"));
}

function function_298b6dd0b26f13bd() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  totalshots = getpersstat("shotsFired");
  totalhits = getpersstat("shotsBulletHit");

  if(isDefined(totalshots) && isDefined(totalhits)) {
    self setclientomnvar("ui_gameplay_telemetry_shotAccuracy", totalhits / max(totalshots, 1) * 100);
  }
}

function function_f1b4726896f5c0c9() {
  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  totalheadshot = getpersstat("headshots");

  if(isDefined(totalheadshot)) {
    self.headshotcount = totalheadshot;
  }
}

function function_d8eb5fb3b35ed1a1() {
  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  killstreakcount = getpersstat("cur_kill_streak");

  if(isDefined(killstreakcount)) {
    self setclientomnvar("ui_gameplay_telemetry_killstreakCount", int(killstreakcount));
  }
}

function function_964e22a27383117d(killdistance) {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(!isDefined(killdistance) || !isnumber(killdistance)) {
    return;
  }

  initpersstat("lastKillRange");
  self.pers["lastKillRange"] = killdistance;
  self setclientomnvar("ui_gameplay_telemetry_lastkill_dist", killdistance);
}

function function_7018e21062adbaa() {
  level notify("gameplaytelemetry_finished");
  level endon("gameplayTelemetry_finished");
  level endon("game_ended");
  refresh_rate = 1;

  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  initpersstat("SPM");

  while(true) {
    function_4781d3b961760043();
    wait refresh_rate;
  }
}

function private function_4781d3b961760043() {
  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  spm = function_18fdff35aee0a387();
  self.pers["SPM"] = spm;
  self setclientomnvar("ui_gameplay_telemetry_SPM", int(spm));
}

function function_f9b01f503cdbfd7d(damagevalue) {
  if(!function_7e3861fd7026453()) {
    return;
  }

  scripts\mp\utility\stats::initpersstat("damageDealt");
  incpersstat("damageDealt", damagevalue);
  damagedealt = getpersstat("damageDealt");
  damagedealt = int(clamp(damagedealt, 0, 65535));
  self.damagedealt = damagedealt;
}

function function_99b3339dca12abde(damagevalue) {
  if(!function_7e3861fd7026453()) {
    return;
  }

  damagevalue = int(clamp(damagevalue, 0, 65535));
  scripts\mp\utility\stats::initpersstat("damageReceived");
  clampeddamage = int(clamp(getpersstat("damageReceived") + damagevalue, 0, 65535));
  self.pers["damageReceived"] = clampeddamage;
  self.damagereceived = clampeddamage;
}

function function_968efd4a57cd5164(cashvalue) {
  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  scripts\mp\utility\stats::initpersstat("cashEarned");
  cashearned = int(clamp(getpersstat("cashEarned") + cashvalue, 0, 99999));
  self.pers["cashEarned"] = cashearned;
  self setclientomnvar("ui_gameplay_telemetry_cash_earned", cashearned);
}

function private function_3c954868ecfc7400(current_weapon, kills_count) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  var_c1648f9a511f9859 = self.var_d0459a2a284e95b0;
  weapon_index = getweaponindex(current_weapon);

  if(isDefined(var_c1648f9a511f9859) && var_c1648f9a511f9859 == weapon_index) {
    self.var_1c12f40e4a9da54d = kills_count;
    return;
  }

  if(!isDefined(self.var_1c12f40e4a9da54d)) {
    self.var_1c12f40e4a9da54d = 0;
  }

  if(kills_count > self.var_1c12f40e4a9da54d) {
    self.var_2be26c80434dff7c = current_weapon.basename;
    self.var_d0459a2a284e95b0 = weapon_index;
    self.var_1c12f40e4a9da54d = kills_count;
  }
}

function private function_a7a626b18c53f42e(current_weapon, damage_done) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  var_c1648f9a511f9859 = self.var_d4786e52d23ad30f;
  weapon_index = getweaponindex(current_weapon);

  if(isDefined(var_c1648f9a511f9859) && var_c1648f9a511f9859 == weapon_index) {
    self.var_4ffa15f74bfb231f = damage_done;
    return;
  }

  if(!isDefined(self.var_4ffa15f74bfb231f)) {
    self.var_4ffa15f74bfb231f = 0;
  }

  if(damage_done > self.var_4ffa15f74bfb231f) {
    self.var_63d7835a0b33d117 = current_weapon.basename;
    self.var_d4786e52d23ad30f = weapon_index;
    self.var_4ffa15f74bfb231f = damage_done;
  }
}

function function_4552872977024e34(victim) {
  self endon("disconnect");

  if(!function_7e3861fd7026453()) {
    return;
  }

  isbr = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(isai(victim) && isbr) {
    return;
  }

  var_5a960f1bd94b23fd = self.primaryweaponobj;
  var_3065d231080b3c3d = self.secondaryweaponobj;

  if(isbr) {
    var_b0cd737e73a94490 = self.equippedweapons;
    var_5a960f1bd94b23fd = var_b0cd737e73a94490[0];
    var_3065d231080b3c3d = var_b0cd737e73a94490[1];
  }

  currentweap = self getcurrentweapon();

  if(!isnullweapon(currentweap)) {
    if(currentweap.basename == "jup_amp_knifestab_mp") {
      if(isDefined(self.lastcacweaponobj) && self.lastcacweaponobj hasattachment("jup_grip_vert_tk_amp")) {
        currentweap = self.lastcacweaponobj;
      }
    }

    currweapname = currentweap.basename;

    if(!isDefined(getpersstat("weapKills")[currweapname])) {
      self.pers["weapKills"][currweapname] = 0;
    }

    var_43b647370ff5e8e = 1;
    isprimary = 1;

    if(isDefined(var_5a960f1bd94b23fd) && var_5a960f1bd94b23fd.basename == currweapname) {
      var_8568e8369df1384b = getpersstat("weapKills")[currweapname] + 1;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_kills", var_8568e8369df1384b);

      if(isbr) {
        killdist = math::round_float(distance(self.origin, victim.origin) * 0.0254, 2);
        function_3c954868ecfc7400(var_5a960f1bd94b23fd, var_8568e8369df1384b);
        function_822c6ec14dbe6941(killdist);
      }
    } else if(isDefined(var_3065d231080b3c3d) && var_3065d231080b3c3d.basename == currweapname) {
      isprimary = 0;
      var_f0d3d8421b92df8b = getpersstat("weapKills")[currweapname] + 1;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_kills", var_f0d3d8421b92df8b);

      if(isbr) {
        killdist = math::round_float(distance(self.origin, victim.origin) * 0.0254, 2);
        function_3c954868ecfc7400(var_3065d231080b3c3d, var_f0d3d8421b92df8b);
        function_822c6ec14dbe6941(killdist);
      }
    } else {
      var_43b647370ff5e8e = 0;
    }

    if(var_43b647370ff5e8e) {
      self.pers["weapKills"][currweapname]++;
      function_51b30814ed768ae6(currweapname, isprimary);
      function_3f473cca053bcacb(currweapname, isprimary);
    }
  }
}

function function_221ea9f08eaf2346() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  currentweap = self getcurrentweapon();

  if(!isnullweapon(currentweap)) {
    currweapname = currentweap.basename;

    if(!isDefined(getpersstat("weapDeaths")[currweapname])) {
      self.pers["weapDeaths"][currweapname] = 0;
    }

    isprimary = undefined;

    if(isDefined(self.primaryweaponobj) && self.primaryweaponobj.basename == currweapname) {
      isprimary = 1;
    } else if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename == currweapname) {
      isprimary = 0;
    }

    if(isDefined(isprimary)) {
      self.pers["weapDeaths"][currweapname]++;
      function_51b30814ed768ae6(currweapname, isprimary);
    }
  }
}

function function_c29690d78b252bb1() {
  if(!function_7e3861fd7026453() || !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  currentweap = self getcurrentweapon();

  if(!isnullweapon(currentweap)) {
    currweapname = currentweap.basename;

    if(!isDefined(getpersstat("weapDowned")[currweapname])) {
      self.pers["weapDowned"][currweapname] = 0;
    }

    var_43b647370ff5e8e = 1;
    isprimary = undefined;
    self.pers["weapDowned"][currweapname]++;
    var_b0cd737e73a94490 = self.equippedweapons;

    if(isDefined(var_b0cd737e73a94490[0]) && var_b0cd737e73a94490[0].basename == currweapname) {
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_downs", getpersstat("weapDowned")[currweapname]);
      return;
    }

    if(isDefined(var_b0cd737e73a94490[1]) && var_b0cd737e73a94490[1].basename == currweapname) {
      isprimary = 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_downs", getpersstat("weapDowned")[currweapname]);
    }
  }
}

function private function_51b30814ed768ae6(currweapname, isprimary) {
  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype() || !isDefined(currweapname) || !isDefined(isprimary)) {
    return;
  }

  weapkillcount = ter_op(isDefined(getpersstat("weapKills")[currweapname]), getpersstat("weapKills")[currweapname], 0);
  weapdeathcount = ter_op(isDefined(getpersstat("weapDeaths")[currweapname]), getpersstat("weapDeaths")[currweapname], 1);
  weapkdratio = weapkillcount / max(weapdeathcount, 1);
  self.pers["weapKDRatio"][currweapname] = weapkdratio;

  if(isprimary) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_kdratio", weapkdratio);
    return;
  }

  self setclientomnvar("ui_gameplay_telemetry_weap_sec_kdratio", weapkdratio);
}

function function_e08012bdba393c79(damagingweapon, damagevalue) {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || isnullweapon(damagingweapon)) {
    return;
  }

  if(damagingweapon.basename == "jup_amp_knifestab_mp") {
    if(isDefined(self.lastcacweaponobj) && self.lastcacweaponobj hasattachment("jup_grip_vert_tk_amp")) {
      damagingweapon = self.lastcacweaponobj;
    }
  }

  var_5a960f1bd94b23fd = self.primaryweaponobj;
  var_3065d231080b3c3d = self.secondaryweaponobj;
  isbr = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(isbr) {
    var_b0cd737e73a94490 = self.equippedweapons;
    var_5a960f1bd94b23fd = var_b0cd737e73a94490[0];
    var_3065d231080b3c3d = var_b0cd737e73a94490[1];
  }

  damagingweaponname = damagingweapon.basename;

  if(!isDefined(getpersstat("weapDamageDealt")[damagingweaponname])) {
    self.pers["weapDamageDealt"][damagingweaponname] = 0;
  }

  self.pers["weapDamageDealt"][damagingweaponname] = getpersstat("weapDamageDealt")[damagingweaponname] + damagevalue;

  if(isDefined(var_5a960f1bd94b23fd) && var_5a960f1bd94b23fd.basename == damagingweaponname) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_damagedealt", getpersstat("weapDamageDealt")[damagingweaponname]);
    function_a7a626b18c53f42e(damagingweapon, getpersstat("weapDamageDealt")[damagingweaponname]);
    return;
  }

  if(isDefined(var_3065d231080b3c3d) && var_3065d231080b3c3d.basename == damagingweaponname) {
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_damagedealt", getpersstat("weapDamageDealt")[damagingweaponname]);
    function_a7a626b18c53f42e(damagingweapon, getpersstat("weapDamageDealt")[damagingweaponname]);
  }
}

function function_a4bd960925ab1205() {
  self endon("disconnect");

  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  currentweap = self getcurrentweapon();

  if(isnullweapon(currentweap) || scripts\mp\utility\weapon::iscacmeleeweapon(currentweap)) {
    return;
  }

  currweapname = currentweap.basename;

  if(!isDefined(getpersstat("weapHeadShotCount")[currweapname])) {
    self.pers["weapHeadShotCount"][currweapname] = 0;
  }

  var_43b647370ff5e8e = 1;
  isprimary = 1;

  if(isDefined(self.primaryweaponobj) && self.primaryweaponobj.basename == currweapname) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_headshot_count", getpersstat("weapHeadShotCount")[currweapname] + 1);
  } else if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename == currweapname) {
    isprimary = 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_headshot_count", getpersstat("weapHeadShotCount")[currweapname] + 1);
  } else {
    var_43b647370ff5e8e = 0;
  }

  if(var_43b647370ff5e8e) {
    self.pers["weapHeadShotCount"][currweapname]++;
    function_3f473cca053bcacb(currweapname, isprimary);
  }
}

function private function_3f473cca053bcacb(currweapname, isprimary) {
  if(!function_7e3861fd7026453() || scripts\cp_mp\utility\game_utility::isbrstylegametype() || !isDefined(currweapname) || !isDefined(isprimary)) {
    return;
  }

  weapkillcount = ter_op(isDefined(getpersstat("weapKills")[currweapname]), getpersstat("weapKills")[currweapname], 1);
  weapheadshotcount = ter_op(isDefined(getpersstat("weapHeadShotCount")[currweapname]), getpersstat("weapHeadShotCount")[currweapname], 0);
  headshotratio = weapheadshotcount / max(weapkillcount, 1) * 100;
  self.pers["weapHeadShotAccuracy"][currweapname] = headshotratio;

  if(isprimary) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_headshot_accuracy", headshotratio);
    return;
  }

  self setclientomnvar("ui_gameplay_telemetry_weap_sec_headshot_accuracy", headshotratio);
}

function function_2efd6926efd58b49(hitdetected, isprimary) {
  self endon("disconnect");

  if(!function_7e3861fd7026453()) {
    return;
  }

  currentweap = self getcurrentweapon();

  if(isnullweapon(currentweap) || scripts\mp\utility\weapon::iscacmeleeweapon(currentweap)) {
    return;
  }

  currweapname = currentweap.basename;

  if(!isDefined(getpersstat("weapShotFired")[currweapname])) {
    self.pers["weapShotFired"][currweapname] = 0;
    self.pers["weapShotHit"][currweapname] = 0;
  }

  if(hitdetected) {
    self.pers["weapShotHit"][currweapname]++;
  } else {
    self.pers["weapShotFired"][currweapname]++;
  }

  self.pers["weapAccuracy"][currweapname] = getpersstat("weapShotHit")[currweapname] / max(getpersstat("weapShotFired")[currweapname], 1) * 100;
  isbr = scripts\cp_mp\utility\game_utility::isbrstylegametype();
  var_5a960f1bd94b23fd = self.primaryweaponobj;
  var_3065d231080b3c3d = self.secondaryweaponobj;

  if(isbr) {
    var_b0cd737e73a94490 = self.equippedweapons;
    var_5a960f1bd94b23fd = var_b0cd737e73a94490[0];
    var_3065d231080b3c3d = var_b0cd737e73a94490[1];
  }

  if(isDefined(var_5a960f1bd94b23fd) && var_5a960f1bd94b23fd.basename == currweapname) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_accuracy", getpersstat("weapAccuracy")[currweapname]);
    return;
  }

  if(isDefined(var_3065d231080b3c3d) && var_3065d231080b3c3d.basename == currweapname) {
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_accuracy", getpersstat("weapAccuracy")[currweapname]);
  }
}

function function_822c6ec14dbe6941(lastkilldistance) {
  if(!function_7e3861fd7026453()) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(!isDefined(lastkilldistance)) {
    return;
  }

  currentweap = self getcurrentweapon();

  if(isnullweapon(currentweap)) {
    return;
  }

  currweapname = currentweap.basename;

  if(!isDefined(getpersstat("weapLastKillDistance")[currweapname])) {
    self.pers["weapLastKillDistance"][currweapname] = 0;
  }

  self.pers["weapLastKillDistance"][currweapname] = lastkilldistance;
  var_43b647370ff5e8e = 1;
  isprimary = 1;
  var_b0cd737e73a94490 = self.equippedweapons;

  if(isDefined(var_b0cd737e73a94490[0]) && var_b0cd737e73a94490[0].basename == currweapname) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_dist", getpersstat("weapLastKillDistance")[currweapname]);
  } else if(isDefined(var_b0cd737e73a94490[1]) && var_b0cd737e73a94490[1].basename == currweapname) {
    isprimary = 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_dist", getpersstat("weapLastKillDistance")[currweapname]);
  } else {
    var_43b647370ff5e8e = 0;
  }

  if(var_43b647370ff5e8e) {
    function_4fe47f76ff9db96b(lastkilldistance, isprimary, currentweap);
  }
}

function private function_4fe47f76ff9db96b(lastkilldistance, isprimary, currentweap) {
  if(!isDefined(isprimary)) {
    return;
  }

  currweapname = currentweap.basename;

  if(!isDefined(getpersstat("weapLongestKillDistance")[currweapname])) {
    self.pers["weapLongestKillDistance"][currweapname] = lastkilldistance;
  } else if(self.pers["weapLongestKillDistance"][currweapname] < lastkilldistance) {
    self.pers["weapLongestKillDistance"][currweapname] = lastkilldistance;
  }

  if(isprimary) {
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_longest_dist", getpersstat("weapLongestKillDistance")[currweapname]);
    return;
  }

  self setclientomnvar("ui_gameplay_telemetry_weap_sec_longest_dist", getpersstat("weapLongestKillDistance")[currweapname]);
}

function function_adcb155953291ec7(var_ff9387e409ebe4a2, var_c51f7affa4c0cd0d) {
  self endon("disconnect");

  if(!function_7e3861fd7026453()) {
    return;
  }

  isbr = scripts\cp_mp\utility\game_utility::isbrstylegametype();
  checkboth = 0;
  isprimary = 0;

  if(!isDefined(var_ff9387e409ebe4a2)) {
    checkboth = 1;
  } else {
    isprimary = var_ff9387e409ebe4a2;
  }

  if(!isDefined(var_c51f7affa4c0cd0d)) {
    var_c51f7affa4c0cd0d = 0;
  }

  weaponname = undefined;

  if(isbr) {
    if(var_c51f7affa4c0cd0d) {
      weaponname = self.var_2be26c80434dff7c;
    } else if(isDefined(self.equippedweapons[0]) && self.equippedweapons[0].inventorytype == "primary") {
      weaponname = self.equippedweapons[0].basename;
    }
  } else if(var_c51f7affa4c0cd0d && isDefined(self.var_2c1e886765f7b608) && isDefined(self.var_2c1e886765f7b608.basename)) {
    weaponname = self.var_2c1e886765f7b608.basename;
  } else if(isDefined(self.primaryweaponobj) && isDefined(self.primaryweaponobj.basename) && (isprimary || checkboth)) {
    weaponname = self.primaryweaponobj.basename;
  }

  if(isDefined(weaponname) && (isprimary || checkboth)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      primarydowns = isDefined(getpersstat("weapDowned")[weaponname]) ? getpersstat("weapDowned")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_downs", primarydowns);
      var_c3cce17e819a97e = isDefined(getpersstat("weapLastKillDistance")[weaponname]) ? getpersstat("weapLastKillDistance")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_dist", var_c3cce17e819a97e);
      var_9ec85557ffab1f2e = isDefined(getpersstat("weapLongestKillDistance")[weaponname]) ? getpersstat("weapLongestKillDistance")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_longest_dist", var_9ec85557ffab1f2e);
    } else {
      primarykdratio = isDefined(getpersstat("weapKDRatio")[weaponname]) ? getpersstat("weapKDRatio")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_kdratio", primarykdratio);
      var_7c24d8d7201e0012 = isDefined(getpersstat("weapHeadShotCount")[weaponname]) ? getpersstat("weapHeadShotCount")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_headshot_count", var_7c24d8d7201e0012);
      var_215acf2e2d6ff0e9 = isDefined(getpersstat("weapHeadShotAccuracy")[weaponname]) ? getpersstat("weapHeadShotAccuracy")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_pri_headshot_accuracy", var_215acf2e2d6ff0e9);
    }

    var_2f852c080f0e1334 = isDefined(getpersstat("weapAccuracy")[weaponname]) ? getpersstat("weapAccuracy")[weaponname] : 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_accuracy", var_2f852c080f0e1334);
    primarykill = isDefined(getpersstat("weapKills")[weaponname]) ? getpersstat("weapKills")[weaponname] : 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_kills", primarykill);
    primarydamagedealt = isDefined(getpersstat("weapDamageDealt")[weaponname]) ? getpersstat("weapDamageDealt")[weaponname] : 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_pri_damagedealt", primarydamagedealt);
  }

  weaponname = undefined;

  if(isbr) {
    if(var_c51f7affa4c0cd0d) {
      weaponname = self.var_63d7835a0b33d117;
    } else if(isDefined(self.equippedweapons[1]) && self.equippedweapons[1].inventorytype == "primary") {
      weaponname = self.equippedweapons[1].basename;
    }
  } else {
    if(isDefined(self.secondaryweaponobj) && isDefined(self.secondaryweaponobj.basename) && (!isprimary || checkboth)) {
      weaponname = self.secondaryweaponobj.basename;
    }

    if(var_c51f7affa4c0cd0d && isDefined(self.var_f96aba3b2bb21958) && isDefined(self.var_f96aba3b2bb21958.basename)) {
      weaponname = self.var_f96aba3b2bb21958.basename;
    }
  }

  if(isDefined(weaponname) && (!isprimary || checkboth)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      secondarydowns = isDefined(getpersstat("weapDowned")[weaponname]) ? getpersstat("weapDowned")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_downs", secondarydowns);
      secondarykilldistance = isDefined(getpersstat("weapLastKillDistance")[weaponname]) ? getpersstat("weapLastKillDistance")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_dist", secondarykilldistance);
      var_ea726d34f3ebe296 = isDefined(getpersstat("weapLongestKillDistance")[weaponname]) ? getpersstat("weapLongestKillDistance")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_longest_dist", var_ea726d34f3ebe296);
    } else {
      secondarykdratio = isDefined(getpersstat("weapKDRatio")[weaponname]) ? getpersstat("weapKDRatio")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_kdratio", secondarykdratio);
      var_6736d6623a51a752 = isDefined(getpersstat("weapHeadShotCount")[weaponname]) ? getpersstat("weapHeadShotCount")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_headshot_count", var_6736d6623a51a752);
      var_3351a10825c2cf29 = isDefined(getpersstat("weapHeadShotAccuracy")[weaponname]) ? getpersstat("weapHeadShotAccuracy")[weaponname] : 0;
      self setclientomnvar("ui_gameplay_telemetry_weap_sec_headshot_accuracy", var_3351a10825c2cf29);
    }

    var_3ae90b2c5e766474 = isDefined(getpersstat("weapAccuracy")[weaponname]) ? getpersstat("weapAccuracy")[weaponname] : 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_accuracy", var_3ae90b2c5e766474);
    secondarykill = isDefined(getpersstat("weapKills")[weaponname]) ? getpersstat("weapKills")[weaponname] : 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_kills", secondarykill);
    secondarydamagedealt = isDefined(getpersstat("weapDamageDealt")[weaponname]) ? getpersstat("weapDamageDealt")[weaponname] : 0;
    self setclientomnvar("ui_gameplay_telemetry_weap_sec_damagedealt", secondarydamagedealt);
  }
}

function private function_18fdff35aee0a387() {
  if(!isPlayer(self) || isai(self)) {
    return 0;
  }

  currentscore = level.teambased ? self.score : getpersstat("gamemodeScore");

  if(!isDefined(currentscore)) {
    return 0;
  }

  minutespassed = getgamelength() / 60000;

  if(minutespassed <= 0) {
    return 0;
  }

  spm = currentscore / minutespassed;

  if(spm > 100000) {
    spm = 100000;
  }

  return spm;
}

function function_e90bd443e0a197dd(primaryweaponobj, secondaryweaponobj) {
  if(!function_7e3861fd7026453()) {
    return;
  }

  self.var_2c1e886765f7b608 = primaryweaponobj;
  self.var_f96aba3b2bb21958 = secondaryweaponobj;
}