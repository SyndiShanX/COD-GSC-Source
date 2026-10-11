/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killcam.gsc
***********************************************/

#using script_1b1a05843f74cfa9;
#using scripts\common\utility;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\render_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\final_killcam;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;
#using scripts\mp\killcam;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\loot;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\tweakables;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace killcam;

function init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];

  for(row = 0; true; row++) {
    id = tablelookupbyrow("mp_cp/miscKillcamItems.csv", row, 0);

    if(!isDefined(id) || id == "") {
      break;
    }

    id = int(id);
    weapon = tablelookupbyrow("mp_cp/miscKillcamItems.csv", row, 1);

    if(!isDefined(weapon) || weapon == "") {
      assertmsg("<dev string:x1c>" + id + "<dev string:x39>");
      break;
    }

    assertex(!isDefined(level.killcammiscitems[weapon]), "<dev string:x52>" + weapon + "<dev string:x69>");
    level.killcammiscitems[weapon] = id;
  }
}

function getkillcamentity(attacker, einflictor, objweapon, meansofdeath) {
  if(!isDefined(attacker) || !isDefined(einflictor) || attacker == einflictor && !isagent(attacker)) {
    return undefined;
  }

  if(usesattackeraskillcamentity(attacker, einflictor, objweapon, meansofdeath)) {
    return undefined;
  }

  if(usesvehiclekillcamentityrelay(attacker, einflictor, objweapon, meansofdeath)) {
    return einflictor.killcament;
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
    case #"hash_89d354623ee9af57":
    case #"hash_8c12df11df01f306":
    case #"hash_9f2f1998a27377df":
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

  if(utility::isdestructibleweapon(objweapon.basename) || isbombsiteweapon(objweapon.basename)) {
    if(isDefined(einflictor.killcament) && !attacker attackerinremotekillstreak()) {
      return einflictor.killcament;
    } else {
      return undefined;
    }
  }

  if(utility::isbrstylegametype() && getdvarint(@ "hash_19f870e5ffafa391", 1)) {
    if(function_51cff425beb83788(attacker, einflictor, objweapon, meansofdeath)) {
      return undefined;
    }
  }

  return einflictor;
}

function usesattackeraskillcamentity(attacker, inflictor, objweapon, meansofdeath) {
  switch (objweapon.basename) {
    case #"hash_104394c101679f9e":
    case #"hash_1a9da8a4fac9fde4":
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
    case #"hash_83d55c8dbb9f72ba":
    case #"hash_85ea99fcbe4116a4":
    case #"hash_8d7aa4b158a0e9a9":
    case #"hash_9a70af630b5b1849":
    case #"hash_9b89ea95df7dfadb":
    case #"hash_a49fac234083ff01":
    case #"hash_a622e958420b92a0":
    case #"hash_b1091bccb52690e0":
    case #"hash_b8c7008e1d8543df":
    case #"hash_bb463b7f255eafce":
    case #"hash_c5c19fe9ae40cd0c":
    case #"hash_d30bcd7e470500f3":
    case #"hash_d4532f8e0fa86548":
    case #"hash_d78eda24c2fd8252":
    case #"hash_e1e4906cafc3af9d":
    case #"hash_fd9c279f85990dad":
    case #"hash_fe08358bc8f9a34a":
      return true;
  }

  return false;
}

function function_51cff425beb83788(attacker, einflictor, objweapon, meansofdeath) {
  if(!isPlayer(attacker)) {
    return false;
  }

  if(!isDefined(meansofdeath) && meansofdeath != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(einflictor.killcament) && isDefined(einflictor.classname) && isDefined(einflictor.owner)) {
    if(einflictor.classname == "script_brushmodel") {
      return true;
    }
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

function prekillcamnotify(attacker) {
  if(isDefined(attacker) && !isagent(attacker)) {
    var_ad0224b36ccb588c = [];

    if(isDefined(self.class) && isDefined(self.classstruct)) {
      playerassets = scripts\mp\playerlogic::getplayerassets(self.classstruct);
      var_ad0224b36ccb588c[var_ad0224b36ccb588c.size] = playerassets;
    }

    if(isDefined(attacker.class) && isDefined(attacker.classstruct)) {
      var_af890d92bafd84cf = attacker scripts\mp\playerlogic::getplayerassets(attacker.classstruct);
      var_ad0224b36ccb588c[var_ad0224b36ccb588c.size] = var_af890d92bafd84cf;
    }

    if(var_ad0224b36ccb588c.size > 0) {
      scripts\mp\playerlogic::loadplayerassets(var_ad0224b36ccb588c, 1);
    }

    if(isDefined(attacker.damagetrigger) && isDefined(attacker.damagetrigger.code_classname) && attacker.damagetrigger.code_classname == "trigger_hurt") {
      if(isDefined(attacker.team)) {
        team = attacker.team;
      } else {
        team = "neutral";
      }

      attacker makeentitysentient(team);

      if(!isDefined(level.var_58a42cd072629ca) || [[level.var_58a42cd072629ca]]()) {
        self predictstreamposuntilcleared(attacker getEye());
      }

      return;
    }

    if(!isDefined(level.var_58a42cd072629ca) || [[level.var_58a42cd072629ca]]()) {
      self predictstreamposuntilcleared(attacker getEye());
    }

    if(isPlayer(attacker)) {
      self loadcustomizationplayerview(attacker);
    }
  }
}

function makekillcamdata(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, offsettime, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo) {
  killcamstruct = spawnStruct();
  killcamstruct.einflictor = einflictor;
  killcamstruct.inflictoragentinfo = inflictoragentinfo;
  killcamstruct.attackernum = attackernum;
  killcamstruct.killcamentityindex = killcamentityindex;
  killcamstruct.killcamentitystarttime = killcamentitystarttime;
  killcamstruct.killcamlookatentityindex = killcamlookatentityindex;
  killcamstruct.killcamentstickstolookatent = killcamentstickstolookatent;
  killcamstruct.objweapon = objweapon;
  killcamstruct.offsettime = offsettime;
  killcamstruct.maxtime = maxtime;
  killcamstruct.attacker = attacker;
  killcamstruct.victim = victim;
  killcamstruct.smeansofdeath = smeansofdeath;
  killcamstruct.attackerloadoutperks = attackerloadoutperks;
  killcamstruct.skippable = skippable;
  killcamstruct.doslowmo = doslowmo;
  killcamstruct.attackerhealthratio = int(clamp(attacker.health / attacker.maxhealth * 127, 0, 127));

  if(isDefined(attacker)) {
    killcamstruct.streampos = attacker.origin;
  } else if(isDefined(victim)) {
    killcamstruct.streampos = victim.origin;
  }

  if(smeansofdeath == "MOD_EXECUTION") {
    killcamstruct.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(attacker);
  }

  return killcamstruct;
}

function dokillcamfromstruct(killcamstruct, predelay, var_53c65e436a20e8e4, isfinalkillcam) {
  killcam(killcamstruct.einflictor, killcamstruct.inflictoragentinfo, killcamstruct.attackernum, killcamstruct.killcamentityindex, killcamstruct.killcamentitystarttime, killcamstruct.killcamlookatentityindex, killcamstruct.killcamentstickstolookatent, killcamstruct.objweapon, predelay, killcamstruct.offsettime, var_53c65e436a20e8e4, killcamstruct.maxtime, killcamstruct.attacker, killcamstruct.victim, killcamstruct.smeansofdeath, killcamstruct.attackerloadoutperks, killcamstruct.skippable, killcamstruct.doslowmo, killcamstruct.attackerhealthratio, isfinalkillcam);
}

function calckillcamtimes(einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, predelay, objweapon, var_53c65e436a20e8e4, delayedtime, smeansofdeath) {
  if(getDvar(@ "scr_killcam_time") == "") {
    weaponrootname = getweaponrootstring(objweapon);

    if(level.showingfinalkillcam) {
      if(smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN") {
        camtime = 4;
      } else if(getgametype() == "arena") {
        if(isDefined(attacker.recentkillcount) && attacker.recentkillcount > 1) {
          camtime = 4 + level.maxkillcamdelay - delayedtime;
        } else {
          camtime = 1.5 + level.maxkillcamdelay - delayedtime;
        }
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
    } else if(objweapon.basename == "ims_charge_explosive_mp" && issharedfuncdefined("ims", "ims_getKillCamTime")) {
      camtime = callsharedfunc("ims", "ims_getKillCamTime");
    } else if(!var_53c65e436a20e8e4 || var_53c65e436a20e8e4 > 5) {
      camtime = 5;
    } else if(weaponrootname == "frag_grenade" || objweapon.basename == "frag_grenade_short_mp" || objweapon.basename == "semtex_mp" || objweapon.basename == "semtexproj_mp" || objweapon.basename == "mortar_shell__mp" || objweapon.basename == "cluster_grenade_mp") {
      camtime = 4.25;
    } else if(objweapon.basename == "loitering_munition_proj_mp") {
      camtime = 3;
    } else if(objweapon.basename == "dna_nuke_mp") {
      camtime = 3;
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

  if(getgametype() == "arena") {
    postdelay = 1;

    if(smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN") {
      postdelay = 3;
    }
  } else if(getDvar(@ "scr_killcam_posttime") == "") {
    postdelay = 2;
  } else {
    postdelay = getdvarfloat(@ "scr_killcam_posttime");

    if(postdelay < level.framedurationseconds) {
      postdelay = level.framedurationseconds;
    }
  }

  if(attackernum < 0 || !isDefined(attacker)) {
    return undefined;
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

function setkilledbyuiomnvar(killedbyplayer) {
  self setclientomnvar("ui_killcam_killedby_id", killedbyplayer getentitynumber());
}

function function_b07f44c04a1ab4d2(attacker) {
  if(isDefined(attacker.equipment) && isDefined(attacker.equipment["primary"])) {
    self setclientomnvar("ui_killcam_killedby_equipment_primary", attacker.equipment["primary"]);
  } else {
    self setclientomnvar("ui_killcam_killedby_equipment_primary", "none");
  }

  if(isDefined(attacker.equipment) && isDefined(attacker.equipment["secondary"])) {
    self setclientomnvar("ui_killcam_killedby_equipment_secondary", attacker.equipment["secondary"]);
    return;
  }

  self setclientomnvar("ui_killcam_killedby_equipment_secondary", "none");
}

function function_64266f65b359ad7(attacker) {
  self setclientomnvar("ui_killcam_killedby_super1", attacker scripts\mp\perks\perkpackage::perkpackage_getfirstfieldupgrade());
  self setclientomnvar("ui_killcam_killedby_super2", attacker scripts\mp\perks\perkpackage::perkpackage_getsecondfieldupgrade());
}

function setupkillcamui(attacker, victim, objweapon, killcamtimes, var_53c65e436a20e8e4, attackerloadoutperks) {
  assert(scripts\cp_mp\utility\game_utility::isgameparticipant(attacker));

  if(isPlayer(attacker)) {
    setkilledbyuiomnvar(attacker);
    self setclientomnvar("ui_killcam_victim_id", victim getentitynumber());
    self loadcustomizationplayerview(attacker);
  }

  if(iskillstreakweapon(objweapon.basename) && !function_1a9394eb58e66a9b(objweapon.basename)) {
    setkillcamkillstreaktypeomnvars(objweapon);
  } else if(istrue(level.allowperks) && isDefined(attackerloadoutperks)) {
    var_9e0a050f0398edc3 = attacker.pers["loadoutExtraPerks"];
    scripts\mp\perks\perks::setomnvarsforperklist("ui_killcam_killedby_perk", attackerloadoutperks, var_9e0a050f0398edc3);
  }

  function_b07f44c04a1ab4d2(attacker);
  function_64266f65b359ad7(attacker);
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

function queueforkillcam() {
  level.numplayerswaitingtoenterkillcam++;
  var_c40a8900810543a2 = 1;

  if(istrue(level.showingfinalkillcam) && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_c40a8900810543a2 = 5;
  }

  delayedtime = level.framedurationseconds * int(floor((level.numplayerswaitingtoenterkillcam - 1) / var_c40a8900810543a2));
  level.maxkillcamdelay = delayedtime;

  if(delayedtime > 0) {
    println("<dev string:x7e>" + level.numplayerswaitingtoenterkillcam);
    wait delayedtime;
  }

  waitframe();
  level.numplayerswaitingtoenterkillcam--;
  return delayedtime;
}

function function_89219d56ee2cf4e2() {
  if(isPlayer(self)) {
    isskipped = 0;
    var_cfe146984e2524ed = round_float(self.killcamlength, 1, 1);
    var_b740f5a639690509 = round_float(self.killcamwatchtime, 1, 1);

    if(var_b740f5a639690509 < var_cfe146984e2524ed) {
      isskipped = 1;
    }

    self dlog_recordplayerevent("dlog_event_match_killcam", ["time_spent", self.killcamwatchtime, "is_skipped", isskipped]);
  }
}

function killcam(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, predelay, offsettime, var_53c65e436a20e8e4, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo, attackerhealthratio, isfinalkillcam) {
  self endon("disconnect");
  self endon("spawned");
  self endon("final_killcam_starting");

  if(!istrue(level.var_ae3b17e71eb3bec7)) {
    level endon("game_ended");
  }

  callsharedfunc("super_evg", "evg_handleKillcam", attacker);
  printspawnmessage("killcam::killcam() START");
  resetplayeromnvarsonkillcam();

  if(attackernum < 0 || !isDefined(attacker)) {
    self notify("killcam_canceled");

    if(istrue(isfinalkillcam)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  delayedtime = queueforkillcam();
  killcamtimes = calckillcamtimes(einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, predelay, objweapon, var_53c65e436a20e8e4, delayedtime, smeansofdeath);

  if(!isDefined(killcamtimes) || !isDefined(killcamtimes.killcamoffset) || !isDefined(victim) || istrue(level.var_904aa57b8b22090c)) {
    self notify("killcam_canceled");

    if(istrue(isfinalkillcam)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  if(istrue(isfinalkillcam)) {
    self setclientomnvar("post_game_state", 3);
    self setclientomnvar("ui_killcam_victim_or_attacker", 1);

    if(self iscodcaster()) {
      self setclientomnvar("ui_killcam_killedby_health_ratio", attackerhealthratio);
    }

    self playlocalsound("final_killcam_in");
    self setclienttriggeraudiozonepartial("killcam", "mix");
  }

  setupkillcamui(attacker, victim, objweapon, killcamtimes, var_53c65e436a20e8e4, attackerloadoutperks);

  if(isPlayer(attacker)) {
    self loadcustomizationplayerview(attacker);
  }

  if(isDefined(level.var_d39aa4b67cefa0d6) && isDefined(einflictor.racecar)) {
    self playlocalsound(level.var_d39aa4b67cefa0d6);
  }

  self setsoundsubmix("iw9_mp_core_killcam_mix");
  beginarchiveplayback(attackernum, killcamtimes.killcamoffset, killcamtimes.killcamlength, offsettime);
  var_eed67ecb94e5635b = setkillcamerastyle(einflictor, inflictoragentinfo, attackernum, victim, killcamentityindex, killcamtimes, objweapon);

  if(!var_eed67ecb94e5635b) {
    thread setkillcamentity(killcamentityindex, killcamtimes.killcamoffset, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent);
  }

  if(!istrue(level.var_ae3b17e71eb3bec7)) {
    thread endedkillcamcleanup(isfinalkillcam);
  }

  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(killcamtimes.killcamoffset);
  killcamtimes.camtime = self.archivetime - level.framedurationseconds - predelay;
  killcamtimes.killcamlength = killcamtimes.camtime + killcamtimes.postdelay;
  self.killcamlength = killcamtimes.killcamlength;

  if(killcamtimes.camtime <= 0) {
    println("<dev string:xb0>");
    killcamcleanup(1, undefined, isfinalkillcam);
    return;
  }

  self.killcam = 1;
  self.var_7c813e50ff75be27 = 1;
  thread spawnedkillcamcleanup(isfinalkillcam);

  if(istrue(doslowmo)) {
    thread dokillcamslowmo(killcamtimes.camtime);
  }

  if(!isDefined(skippable) || skippable) {
    thread waitskipkillcambutton(var_53c65e436a20e8e4);
    thread function_7e144cfdd1c3385e();
  }

  if(getdvarint(@ "hash_6a04bab2b440c5eb", 0)) {
    thread scripts\mp\killstreaks\killstreaks::function_770554a011a28178();
  }

  if(istrue(isfinalkillcam)) {
    thread scripts\mp\final_killcam::finalkillcamplaybackbegin();
  }

  thread endkillcamifnothingtoshow();

  if(!isbot(self)) {
    thread resetstreamerposhint();
  }

  self.killcamwatchtime = gettime();
  waittillkillcamover();
  self.killcamwatchtime = (gettime() - self.killcamwatchtime) / 1000;
  scripts\mp\utility\stats::incpersstat("timeWatchingKillcams", self.killcamwatchtime);
  killcamcleanup(1, undefined, isfinalkillcam);
  function_89219d56ee2cf4e2();
  printspawnmessage("killcam::killcam() COMPLETE");
}

function resetstreamerposhint() {
  self endon("disconnect");
  waittill_any_timeout_2(0.15, "killcam_canceled", "spawned");

  if(!isDefined(level.var_58a42cd072629ca) || [[level.var_58a42cd072629ca]]()) {
    self clearpredictedstreampos();
  }

  if(istrue(level.showingfinalkillcam)) {
    scripts\mp\gamelogic::predictandclearintermissionstreaming();
  }
}

function setuppotgui(spectateplayer, durationsec) {
  setkilledbyuiomnvar(spectateplayer);
  setkillcamuitimer(durationsec);
}

function potg_killcam(spectateentity, psoffsettime, starttimems, endtimems) {
  self endon("disconnect");
  scripts\mp\killcam::prekillcamnotify(spectateentity);
  resetplayeromnvarsonkillcam();
  var_79fe9d21e7286c23 = spectateentity getentitynumber();
  queueforkillcam();

  if(isPlayer(spectateentity)) {
    self loadcustomizationplayerview(spectateentity);
  }

  curtimems = gettime();
  var_897b58815b52404c = (curtimems - starttimems) / 1000;
  var_a7611280671612f1 = (curtimems - endtimems) / 1000;
  durationsec = (endtimems - starttimems) / 1000;
  setuppotgui(spectateentity, durationsec);
  self.archiveusepotg = 1;
  beginarchiveplayback(var_79fe9d21e7286c23, var_897b58815b52404c, durationsec, psoffsettime);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(var_897b58815b52404c);
  self.killcamlength = self.archivetime - var_a7611280671612f1;
  self.killcam = 1;
  self notify("begin_killcam");
  waittillkillcamover();
  potgkillcamcleanup();
}

function potgkillcamcleanup() {
  self.killcam = undefined;
  scripts\mp\spectating::setspectatepermissions();
  updatesessionstate("dead");
  clearkillcamstate();
  self notify("killcam_ended");
}

function setkillcamnormalweaponomnvars(objweapon, smeansofdeath, einflictor, executionref, attacker) {
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
    equipmenttype = scripts\mp\utility\weapon::getequipmenttype(objweapon);
  }

  if(isDefined(scripts\mp\supers::getsuperrefforsuperweapon(objweapon))) {
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

    scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
    printspawnmessage("killcam::waitSkipKillcamButton() Killcam SKIPPED");
    self setclientomnvar("ui_rcd_controls", 0);
    self setclientomnvar("ui_using_killstreak_remote", 0);
    scripts\cp_mp\utility\render_utility::function_e2eae50826e12247();
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

  scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
  printspawnmessage("killcam::waitSkipKillcamKBMOrTouch() Killcam SKIPPED");
  self setclientomnvar("ui_rcd_controls", 0);
  self setclientomnvar("ui_using_killstreak_remote", 0);
  scripts\cp_mp\utility\render_utility::function_e2eae50826e12247();
  self notify("abort_killcam");
}

function spawnedkillcamcleanup(isfinalkillcam) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  killcamcleanup(0, undefined, isfinalkillcam);
}

function endedkillcamcleanup(isfinalkillcam) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  killcamcleanup(1, 1, isfinalkillcam);
}

function killcamcleanup(updatesession, gameended, isfinalkillcam) {
  clearkillcamomnvars();
  self.killcam = undefined;
  setcinematiccamerastyle("unknown", -1, -1);
  scripts\mp\spectating::setspectatepermissions(gameended);
  clearkillcamstate();

  if(istrue(updatesession) && !istrue(gameended)) {
    updatesessionstate("dead");
  }

  self notify("killcam_ended");

  if(istrue(level.doingkillcamslowmo)) {
    setslowmotion(0.25, 1, 1);
    level.doingkillcamslowmo = undefined;
  }

  self clearsoundsubmix("iw9_mp_core_killcam_mix");
  self clearsoundsubmix("iw9_mp_killcam");

  if(istrue(isfinalkillcam)) {
    self setclientomnvar("post_game_state", 1);
  }
}

function setkillcamweapontypeomnvars(objweapon, einflictor, attacker) {
  objweapon = attacker function_1e3102980c3a4cc1(objweapon);
  objweapon = mapweapon(objweapon, einflictor);
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

  lootinfo = scripts\mp\loot::getlootinfoforweapon(objweapon.basename, objweapon.variantid);

  if(isDefined(lootinfo)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", lootinfo.variantid);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  }

  setkillcamkilledbyitemomnvars(0, var_23baff4cd29861a2);

  if(rootweaponname != "iw8_knife") {
    attachments = getweaponattachments(objweapon);

    if(!isDefined(attachments)) {
      attachments = [];
    }

    var_26e8678bd2761ff9 = 0;

    for(attachindex = 0; attachindex < attachments.size; attachindex++) {
      var_b72fb037a64a6025 = attachments[attachindex];

      if(attachmentisselectable(rootweaponname, var_b72fb037a64a6025)) {
        if(var_26e8678bd2761ff9 >= 8) {
          assertmsg("<dev string:x104>" + getcompleteweaponname(objweapon));
          break;
        }

        if(isDefined(level.weaponattachments) && isDefined(level.weaponattachments[var_b72fb037a64a6025])) {
          attachmentlootid = level.weaponattachments[var_b72fb037a64a6025];
          self setclientomnvar("ui_killcam_killedby_attachment" + var_26e8678bd2761ff9 + 1, attachmentlootid);
          var_26e8678bd2761ff9++;
        }
      }
    }

    for(attachindex = var_26e8678bd2761ff9; attachindex < 8; attachindex++) {
      self setclientomnvar("ui_killcam_killedby_attachment" + attachindex + 1, -1);
    }
  }
}

function setkillcamsupertypeomnvars(objweapon) {
  ref = scripts\mp\supers::getsuperrefforsuperweapon(objweapon);
  id = scripts\mp\supers::getsuperid(ref);
  setkillcamkilledbyitemomnvars(2, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamequipmenttypeomnvars(objweapon) {
  equipmentref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);
  equipmentinfo = scripts\mp\equipment::getequipmenttableinfo(equipmentref);

  if(isDefined(equipmentinfo)) {
    setkillcamkilledbyitemomnvars(3, equipmentinfo.id);
  }

  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
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

function setkillcammisctypeomnvars(id) {
  setkillcamkilledbyitemomnvars(5, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
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

function resetplayeromnvarsonkillcam() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearall(self);
}

function function_e2177089f4dd55a(time) {
  if(!level.killcam) {
    return;
  }

  starttime = time - 1000;
  endtime = time + 10000;

  while(gettime() < starttime) {
    waitframe();
  }

  level.var_904aa57b8b22090c = 1;
  var_8e3ad4d5a51de4f4 = level.skipfinalkillcam;
  level.skipfinalkillcam = 1;

  foreach(player in level.players) {
    player notify("abort_killcam");
  }

  while(gettime() < endtime) {
    waitframe();
  }

  level.var_904aa57b8b22090c = 0;
  level.skipfinalkillcam = var_8e3ad4d5a51de4f4;
}