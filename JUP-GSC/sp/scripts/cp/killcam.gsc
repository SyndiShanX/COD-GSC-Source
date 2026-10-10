/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killcam.gsc
***********************************************/

#using script_1b1a05843f74cfa9;
#using scripts\cp\damage;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\tweakables;
#namespace killcam;

function init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");

  if(!getdvarint(@ "hash_c229158783c9be0e", 0)) {
    level.killcam = 0;
  }

  level.killcammiscitems = [];

  for(row = 0; true; row++) {
    id = tablelookupbyrow("mp_cp/miscKillcamItems.csv", row, 0);

    if(!isDefined(id) || id == "") {
      break;
    }

    id = int(id);
    weapon = tablelookupbyrow("mp_cp/miscKillcamItems.csv", row, 1);

    if(!isDefined(weapon) || weapon == "") {
      assertmsg("Killcam Misc Item Entry #" + id + " has no weapon listed");
      break;
    }

    assertex(!isDefined(level.killcammiscitems[weapon]), "Killcam Misc Item \"" + weapon + "\" is listed twice");
    level.killcammiscitems[weapon] = id;
  }

  level.onpostkillcamcallback = &scripts\cp\damage::function_e4a54b8991b813bf;
  level.numplayerswaitingtoenterkillcam = 0;
  level.showingfinalkillcam = 0;
  level.gameended = 0;
  level.gameendtime = 0;
}

function function_3f8b7ecacb8eb472(deathdata) {
  assertex(isDefined(deathdata) && isDefined(deathdata.dokillcam), "Called shouldDoKillcam with invalid death data");
  return deathdata.dokillcam && level.killcam;
}

function setupkillcamui(attacker, victim, objweapon, killcamtimes, var_53c65e436a20e8e4, attackerloadoutperks) {
  if(iskillstreakweapon(objweapon.basename)) {
    setkillcamkillstreaktypeomnvars(objweapon);
  }

  forcerespawn = getdvarint(@ "hash_5d64cd3b24cf883a");

  if(var_53c65e436a20e8e4 && !level.gameended || isDefined(self) && !level.gameended || forcerespawn == 0 && !level.gameended) {
    self setclientomnvar("ui_killcam_text", "skip");
  } else if(!level.gameended) {
    self setclientomnvar("ui_killcam_text", "respawn");
  } else {
    self setclientomnvar("ui_killcam_text", "none");
  }

  setkillcamuitimer(killcamtimes.killcamlength);
}

function calckillcamtimes(einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, predelay, objweapon, var_53c65e436a20e8e4, delayedtime, smeansofdeath) {
  if(getDvar(@ "scr_killcam_time") == "") {
    weaponrootname = getweaponrootstring(objweapon);

    if(level.showingfinalkillcam) {
      if(smeansofdeath == "MOD_EXECUTION") {
        camtime = 4;
      } else {
        camtime = 4 + level.maxkillcamdelay - delayedtime;
      }
    } else if(objweapon.basename == "artillery_mp") {
      camtime = 2.25;
    } else if(objweapon.basename == "hover_jet_proj_mp") {
      camtime = 3;
    } else if(function_ee36210863ca9f2c(objweapon)) {
      camtime = 1.5;
    } else if(objweapon.basename == "toma_proj_mp") {
      camtime = 2.5;
    } else if(objweapon.basename == "cruise_proj_mp") {
      camtime = 3;
    } else if(objweapon.basename == "javelin_mp") {
      camtime = 8;
    } else if(issubstr(objweapon.basename, "remotemissile_")) {
      camtime = 5;
    } else if(isDefined(einflictor.sentrytype) && einflictor.sentrytype == "multiturret") {
      camtime = 2;
    } else if(!var_53c65e436a20e8e4 || var_53c65e436a20e8e4 > 3) {
      camtime = 3;
    } else if(weaponrootname == "frag_grenade" || objweapon.basename == "frag_grenade_short_mp" || objweapon.basename == "semtex_mp" || objweapon.basename == "semtexproj_mp" || objweapon.basename == "mortar_shell__mp" || objweapon.basename == "cluster_grenade_mp") {
      camtime = 4.25;
    } else {
      camtime = 2.5;
    }
  } else {
    camtime = getdvarfloat(@ "scr_killcam_time");
  }

  if(isDefined(maxtime)) {
    if(camtime > maxtime) {
      camtime = maxtime;
    }

    if(camtime < level.framedurationseconds) {
      camtime = level.framedurationseconds;
    }
  }

  if(getDvar(@ "scr_killcam_posttime") == "") {
    postdelay = 2;
  } else {
    postdelay = getdvarfloat(@ "scr_killcam_posttime");

    if(postdelay < level.framedurationseconds) {
      postdelay = level.framedurationseconds;
    }
  }

  if(!isDefined(attacker) || isagent(attacker) || isagent(einflictor)) {
    attackernum = victim getentitynumber();
  }

  killcamtimes = trimkillcamtime(inflictoragentinfo, attacker, camtime, postdelay, predelay, maxtime);

  if(!isDefined(killcamtimes)) {
    return undefined;
  }

  assert(isDefined(killcamtimes.camtime));
  assert(isDefined(killcamtimes.postdelay));
  assert(isDefined(killcamtimes.killcamlength));
  assert(isDefined(killcamtimes.killcamoffset));
  return killcamtimes;
}

function waitskipkillcambutton(var_53c65e436a20e8e4) {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");
    self waittill("kc_respawn");

    if(isDefined(level.var_d39aa4b67cefa0d6)) {
      thread function_e35f3dda3b0ea636();
    }

    scripts\cp_mp\utility\player_utility::printspawnmessage("killcam::waitSkipKillcamButton() Killcam SKIPPED");
    self notify("abort_killcam");
  }
}

function function_7e144cfdd1c3385e() {
  self endon("disconnect");
  self endon("killcam_ended");
  self endon("abort_killcam");

  if(self usingtouch()) {
    while(!self jumpbuttonPressed()) {
      waitframe();
    }
  } else {
    while(self usinggamepad() || !self jumpbuttonPressed()) {
      waitframe();
    }
  }

  scripts\cp_mp\utility\player_utility::printspawnmessage("killcam::waitSkipKillcamKBMOrTouch() Killcam SKIPPED");
  self notify("abort_killcam");
}

function queueforkillcam() {
  level.numplayerswaitingtoenterkillcam++;
  var_c40a8900810543a2 = 1;
  delayedtime = level.framedurationseconds * int(floor((level.numplayerswaitingtoenterkillcam - 1) / var_c40a8900810543a2));
  level.maxkillcamdelay = delayedtime;

  if(delayedtime > 0) {
    println("<dev string:x1c>" + level.numplayerswaitingtoenterkillcam);
    wait delayedtime;
  }

  waitframe();
  level.numplayerswaitingtoenterkillcam--;
  return delayedtime;
}

function killcamcleanup(updatesession, gameended, isfinalkillcam) {
  clearkillcamomnvars();
  self.killcam = undefined;
  setcinematiccamerastyle("unknown", -1, -1);
  scripts\cp_mp\utility\player_utility::clearkillcamstate();

  if(istrue(updatesession) && !istrue(gameended)) {
    scripts\cp_mp\utility\player_utility::updatesessionstate("dead");
  }

  self notify("killcam_ended");

  if(istrue(isfinalkillcam)) {
    self setclientomnvar("post_game_state", 1);
  }
}

function endedkillcamcleanup(isfinalkillcam) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  killcamcleanup(1, 1, isfinalkillcam);
}

function spawnedkillcamcleanup(isfinalkillcam) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  killcamcleanup(0, undefined, isfinalkillcam);
}

function killcam(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, predelay, offsettime, var_53c65e436a20e8e4, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo, isfinalkillcam) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  var_f2fce7707e422e62 = 0;

  if(!getdvarint(@ "hash_76f4afc3d036e83", 0)) {
    var_f2fce7707e422e62 = attacker.classname == "worldspawn";
  }

  var_939dccf1a8fe8064 = 0;

  if(!getdvarint(@ "hash_8547d5d31f5dde5d", 0)) {
    var_939dccf1a8fe8064 = issubstr(objweapon.basename, "thermite") || issubstr(objweapon.basename, "c4") || issubstr(objweapon.basename, "semtex");
  }

  if(!isDefined(attacker) || attacker == victim || var_f2fce7707e422e62 || var_939dccf1a8fe8064) {
    killcamcleanup(1, undefined, isfinalkillcam);
    wait 1;
    return;
  }

  scripts\cp_mp\utility\player_utility::printspawnmessage("killcam::killcam() START");

  if(attackernum < 0 || !isDefined(attacker)) {
    self notify("killcam_canceled");

    if(istrue(isfinalkillcam)) {
      self setclientomnvar("post_game_state", 1);
    }

    killcamcleanup(1, undefined, isfinalkillcam);
    return;
  }

  killcamtimes = calckillcamtimes(einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, predelay, objweapon, var_53c65e436a20e8e4, 0, smeansofdeath);

  if(!isDefined(killcamtimes) || !isDefined(killcamtimes.killcamoffset) || !isDefined(victim)) {
    self notify("killcam_canceled");

    if(istrue(isfinalkillcam)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  setupkillcamui(attacker, victim, objweapon, killcamtimes, var_53c65e436a20e8e4, attackerloadoutperks);

  if(isPlayer(attacker)) {
    self loadcustomizationplayerview(attacker);
  }

  if(isDefined(level.var_d39aa4b67cefa0d6) && isDefined(einflictor.racecar)) {
    self playlocalsound(level.var_d39aa4b67cefa0d6);
  }

  beginarchiveplayback(attackernum, killcamtimes.killcamoffset, killcamtimes.killcamlength, offsettime);
  var_eed67ecb94e5635b = setkillcamerastyle(einflictor, inflictoragentinfo, attackernum, victim, killcamentityindex, killcamtimes, objweapon);

  if(!var_eed67ecb94e5635b) {
    thread setkillcamentity(killcamentityindex, killcamtimes.killcamoffset, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent);
  }

  thread endedkillcamcleanup(isfinalkillcam);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(killcamtimes.killcamoffset);
  killcamtimes.camtime = self.archivetime - level.framedurationseconds - predelay;
  killcamtimes.killcamlength = killcamtimes.camtime + killcamtimes.postdelay;
  self.killcamlength = killcamtimes.killcamlength;

  if(killcamtimes.camtime <= 0) {
    println("<dev string:x4b>");
    killcamcleanup(1, undefined, isfinalkillcam);
    return;
  }

  self.killcam = 1;
  thread spawnedkillcamcleanup(isfinalkillcam);

  if(istrue(doslowmo)) {
    thread dokillcamslowmo(killcamtimes.camtime);
  }

  if(!isDefined(skippable) || skippable) {
    thread waitskipkillcambutton(var_53c65e436a20e8e4);
    thread function_7e144cfdd1c3385e();
  }

  thread endkillcamifnothingtoshow();
  self.killcamwatchtime = gettime();
  waittillkillcamover();
  self.killcamwatchtime = (gettime() - self.killcamwatchtime) / 1000;
  killcamcleanup(1, undefined, isfinalkillcam);
  scripts\cp_mp\utility\player_utility::printspawnmessage("killcam::killcam() COMPLETE");
}

function getkillcamentity(attacker, einflictor, objweapon, meansofdeath) {
  if(!isDefined(attacker) || !isDefined(einflictor)) {
    return undefined;
  }

  if(usesattackeraskillcamentity(attacker, einflictor, objweapon, meansofdeath)) {
    return undefined;
  }

  if(usesvehiclekillcamentityrelay(attacker, einflictor, objweapon, meansofdeath)) {
    return einflictor.killcament;
  }

  if(attacker.classname == "laser_trap") {
    return ter_op(isDefined(einflictor.killcament), einflictor.killcament, einflictor);
  }

  switch (objweapon.basename) {
    case #"hash_1d6b88bde28b109a":
    case #"hash_1ed1da8a2c218aa7":
    case #"hash_2b2cfdf125b4764d":
    case #"hash_2cdebdb0a44e94e6":
    case #"hash_44ac662b86af3e18":
    case #"hash_4e86f50e99575707":
    case #"hash_55b3daf553a1271e":
    case #"hash_5e3fa526a48eaaa5":
    case #"hash_8c12df11df01f306":
    case #"hash_badacfdae124cc01":
    case #"hash_d9cbc629e947d1b7":
    case #"hash_eec4a41906598dfc":
    case #"hash_f085b57dce639767":
    case #"hash_f89fb49cf58b70a5":
      return ter_op(isDefined(einflictor.killcament), einflictor.killcament, einflictor);
    case #"hash_91a48ebfd2d03a40":
    case #"hash_996849dc6e47c18f":
    case #"hash_aae52fc2913829d0":
    case #"hash_c124ad09158500e9":
    case #"hash_db653a4972b3c13b":
    case #"hash_e4dc94c459367249":
      if(isnoneweaponinflictor(einflictor) || isenvironmentalinflictor(einflictor)) {
        return einflictor.killcament;
      }

      break;
  }

  return einflictor;
}

function usesattackeraskillcamentity(attacker, inflictor, objweapon, meansofdeath) {
  switch (objweapon.basename) {
    case #"hash_1e6ad4ef0904a0f1":
    case #"hash_1eb643f396ea8577":
    case #"hash_1ee2bbd1bc80ea9a":
    case #"hash_20305144649233ed":
    case #"hash_284c201e9a29be96":
    case #"hash_31aebb2fa566704a":
    case #"hash_4f9064f9a7a4b7d1":
    case #"hash_507c24a8f53354fe":
    case #"hash_62a9688b69906271":
    case #"hash_708fb6e22f87a3a4":
    case #"hash_80d39fa6a58bf503":
    case #"hash_85ea99fcbe4116a4":
    case #"hash_8d7aa4b158a0e9a9":
    case #"hash_9a70af630b5b1849":
    case #"hash_a622e958420b92a0":
    case #"hash_bb463b7f255eafce":
    case #"hash_c5c19fe9ae40cd0c":
    case #"hash_fd9c279f85990dad":
    case #"hash_fe08358bc8f9a34a":
      return true;
  }

  return false;
}

function usesvehiclekillcamentityrelay(attacker, inflictor, objweapon, meansofdeath) {
  if(!isDefined(inflictor)) {
    return 0;
  }

  if(!inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return 0;
  }

  switch (meansofdeath) {
    case #"hash_3c20f39c73a1422b":
    case #"hash_571e46e17a3cf2e3":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_c22b13f81bed11f0":
      return 1;
    default:
      return 0;
  }
}

function isnoneweaponinflictor(einflictor) {
  isnoneweapon = 0;

  if(isDefined(einflictor) && isDefined(einflictor.targetname)) {
    switch (einflictor.targetname) {
      case #"hash_2b6c3cfd33ba8b3":
      case #"hash_2b6c4cfd33baa46":
      case #"hash_2b6c5cfd33babd9":
      case #"hash_2b6c6cfd33bad6c":
      case #"hash_2b6c7cfd33baeff":
      case #"hash_2b6c8cfd33bb092":
      case #"hash_3fd866e3da61a87":
      case #"hash_5cfc71f81e9bba54":
        isnoneweapon = 1;
        break;
    }
  }

  return isnoneweapon;
}

function isenvironmentalinflictor(einflictor) {
  var_b61b72e59b2ea4e2 = 0;

  if(isDefined(einflictor.killcament) && isDefined(einflictor.classname)) {
    switch (einflictor.classname) {
      case #"hash_3872eb7d97592cac":
      case #"hash_6318af6067faf262":
      case #"hash_8040aa10d9cac1e8":
        var_b61b72e59b2ea4e2 = 1;
        break;
    }
  }

  return var_b61b72e59b2ea4e2;
}

function setkillcamnormalweaponomnvars(objweapon, smeansofdeath, einflictor, executionref, attacker) {
  if(isPlayer(attacker) || isagent(attacker)) {
    self setclientomnvar("ui_killcam_killedby_id", attacker getentitynumber());
  } else {
    self setclientomnvar("ui_killcam_killedby_id", -1);
  }

  if(smeansofdeath == "MOD_EXECUTION") {
    setkillcamexecutiontypeomnvars(executionref);
    return;
  }

  if(!isDefined(objweapon) || objweapon.basename == "none") {
    clearkillcamattachmentomnvars();
    return;
  }

  if(isDefined(einflictor) && isDefined(einflictor.glgrenadeparent)) {
    equipmenttype = undefined;
    objweapon = einflictor.glgrenadeparent;
    einflictor = undefined;
  } else {
    equipmenttype = scripts\cp\utility::getequipmenttype(objweapon.basename);
  }

  if(isDefined(equipmenttype) && equipmenttype == "super") {
    setkillcamsupertypeomnvars(objweapon);
    return;
  }

  if(isDefined(equipmenttype) && (equipmenttype == "lethal" || equipmenttype == "tactical")) {
    setkillcamequipmenttypeomnvars(objweapon);
    return;
  }

  if(isDefined(level.killcammiscitems[objweapon.basename])) {
    setkillcammisctypeomnvars(level.killcammiscitems[objweapon.basename]);
    return;
  }

  setkillcamweapontypeomnvars(objweapon, einflictor, attacker);
}

function setkillcamexecutiontypeomnvars(ref) {
  if(!isDefined(ref)) {
    id = 0;
  } else {
    id = scripts\cp_mp\execution::execution_getidbyref(ref);
  }

  setkillcamkilledbyitemomnvars(4, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamsupertypeomnvars(objweapon) {
  ref = scripts\cp\super::getsuperrefforsuperweapon(objweapon);
  id = scripts\cp_mp\supers\supers::getsuperid(ref);
  setkillcamkilledbyitemomnvars(2, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamequipmenttypeomnvars(objweapon) {
  equipmentref = scripts\cp_mp\equipment::getequipmentreffromweapon(objweapon);

  if(isDefined(equipmentref)) {
    equipmentinfo = scripts\cp_mp\equipment::getequipmenttableinfo(equipmentref);

    if(isDefined(equipmentinfo)) {
      setkillcamkilledbyitemomnvars(3, equipmentinfo.id);
    }
  } else {
    iprintlnbold("<dev string:x9c>" + objweapon.basename + "<dev string:xbd>");

    setkillcamkilledbyitemomnvars(3, -1);
  }

  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcammisctypeomnvars(id) {
  setkillcamkilledbyitemomnvars(5, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamweapontypeomnvars(objweapon, einflictor, attacker) {
  objweapon = attacker scripts\cp_mp\utility\weapon_utility::function_1e3102980c3a4cc1(objweapon);
  objweapon = scripts\cp\weapon::mapweapon(objweapon, einflictor);
  rootweaponname = getweaponrootname(objweapon.basename);
  var_dc45d6f50c9a112b = scripts\cp_mp\weapon::function_a221d76594ef4e8b();
  var_23baff4cd29861a2 = -1;

  if(isDefined(var_dc45d6f50c9a112b) && array_contains(var_dc45d6f50c9a112b, rootweaponname)) {
    var_23baff4cd29861a2 = array_find(var_dc45d6f50c9a112b, rootweaponname) + 1;
  }

  self setclientomnvar("ui_weapon_pickup", 0);

  if(!isDefined(var_23baff4cd29861a2) || var_23baff4cd29861a2 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  lootinfo = scripts\cp\utility::getlootinfoforweapon(objweapon.basename, objweapon.variantid);

  if(isDefined(lootinfo)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", lootinfo.variantid);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  }

  setkillcamkilledbyitemomnvars(0, var_23baff4cd29861a2);
}