/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\events.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp\cp_challenge;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_matchdata;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weapons;
#using scripts\cp\laststand;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\spawning;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp\utility\player_frame_update_aggregator;
#using scripts\cp\utility\script;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace events;

function init() {
  scripts\cp_mp\utility\game_utility::initchallengeandeventglobals();
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect_events);
  level.var_27dcaf9644646944 = #"display_xp";

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  bundle = undefined;

  if(isDefined(level.gametypebundle)) {
    bundlename = level.gametypebundle.scoreeventlist;

    if(isstring(bundlename)) {
      bundle = getscriptbundle(hashcat(%"scoreeventlist:", bundlename));
    }
  }

  if(!isDefined(bundle)) {
    bundle = function_15fd33eb83ce9723();
  }

  if(isDefined(bundle)) {
    foreach(entry in bundle.var_954e1637c0fe6111) {
      function_e1fb4dfa1db65ce2(entry);
    }

    foreach(entry in bundle.var_a45b64683777600d) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_2820c891e54b9ac0) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_24a4cf263452716) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_64f120e8e17d6a6) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_60c4cdc67f3daa88) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_c865e015a35e7213) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_df30271d78b67bc4) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_4d8678eb66db4dee) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_dc9d1000672be9fc) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_22d3e4c7f898ce16) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_8cb7d576afcbade5) {
      function_51e853369bc3f0bf(entry);
    }

    foreach(entry in bundle.var_bc38d83854c4c304) {
      function_51e853369bc3f0bf(entry);
    }
  }

  scripts\cp\rank::registerscoreinfo(#"persistent_xp", #"value", 500);
  level thread monitorhealed();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawn);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&monitoradstime);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&updatestancetracking);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&events_monitorslideupdate);
  scripts\cp\spawning::add_global_spawn_function("axis", &init_ai_kill_params_for_events);
}

function function_15fd33eb83ce9723() {
  game_type = scripts\cp\utility::getgametype();

  if(!isDefined(game_type)) {
    game_type = getDvar(@ "g_gametype");
  }

  scriptbundlename = "score_event_list_" + game_type;

  if(getdvarint(@ "t10") > 0) {
    scriptbundlename += "_t10_cp";

    utility::scriptbundlewarning("<dev string:x1c>", scriptbundlename);
  } else {
    scriptbundlename += "_iw9_cp";

    utility::scriptbundlewarning("<dev string:x1c>", scriptbundlename);
  }

  bundle = getscriptbundle("scoreeventlist:" + scriptbundlename);
  assert(isDefined(bundle), "Score Event Bundle required for game type: " + game_type);
  return bundle;
}

function function_e1fb4dfa1db65ce2(entry) {
  if(!isDefined(entry)) {
    return;
  }

  ref = entry.ref;

  if(!isDefined(ref) || ref == "") {
    return;
  }

  scripts\cp\rank::registerscoreinfomultiplier(ref, entry.multiplier);
  group = default_to(entry.group, "unassigned");
  scripts\cp\rank::registerscoreinfo(ref, #"group", group);
}

function function_51e853369bc3f0bf(entry) {
  if(!isDefined(entry)) {
    return;
  }

  ref = entry.ref;

  if(!isDefined(ref) || ref == "") {
    return;
  }

  if(istrue(entry.isaward)) {
    scripts\cp\rank::registerscoreinfo(ref, #"hash_6dd3d93bbf03abc6", 1);
  }

  score = default_to(entry.score, 0);
  xp = default_to(entry.xp, 0);
  var_e705ea298dacd4e2 = default_to(entry.var_e705ea298dacd4e2, 0);

  if(!istrue(entry.forceinit)) {
    if(score == 0 && xp == 0) {
      return;
    }

    assert(score >= 0);
    assert(xp >= 0);
  }

  scripts\cp\rank::registerscoreinfo(ref, #"value", score);
  scripts\cp\rank::registerscoreinfo(ref, #"xp", xp);
  scripts\cp\rank::registerscoreinfo(ref, #"hash_afa3cfee9cf8b4c6", var_e705ea298dacd4e2);
  var_eef8a3f0dcf96328 = isxhashasset(entry.splashbundle);

  if(!var_eef8a3f0dcf96328) {
    function_4e7a52f99699d997(ref, scripts\cp\cp_hud_message::getsplashtablename());
  }

  group = default_to(entry.group, "unassigned");
  scripts\cp\rank::registerscoreinfo(ref, #"group", group);

  if(!istrue(entry.nobonus)) {
    scripts\cp\rank::registerscoreinfo(ref, #"allowbonus", 1);
  }

  if(istrue(entry.var_5b5911eca3f2426f)) {
    scripts\cp\rank::registerscoreinfo(ref, #"hash_582866801a05178b", 1);
  }

  if(isxhashasset(entry.splashbundle)) {
    var_8cde9a095cf42d8f = function_2336488258354fbc(#"scriptbundle_splash", entry.splashbundle);
    assertex(isDefined(var_8cde9a095cf42d8f), "Net const string id is undefined for an existing splash bundle: " + getxhashsourcename(entry.splashbundle));

    if(isDefined(var_8cde9a095cf42d8f)) {
      scripts\cp\rank::registerscoreinfo(ref, #"hash_9ef9bbcd1edc198b", var_8cde9a095cf42d8f);
      function_cbf4b04a2e7f02ae(ref, entry.splashbundle, var_8cde9a095cf42d8f);
    }
  }
}

function function_4e7a52f99699d997(ref, splashtablename) {
  var_2c6153492a7defb2 = tablelookuprownum(splashtablename, 0, ref);

  if(var_2c6153492a7defb2 < 0) {
    return;
  }

  scripts\cp\rank::registerscoreinfo(ref, #"hash_edd89bb2cc2d506", var_2c6153492a7defb2);
  text = tablelookup(splashtablename, 0, ref, 2);

  if(isstring(text) && text != "") {
    scripts\cp\rank::registerscoreinfo(ref, #"hastext", 1);
  }

  priority = int(tablelookup(splashtablename, 0, ref, 13));
  scripts\cp\rank::registerscoreinfo(ref, #"priority", priority);
  var_43297beee133b22 = int(tablelookup(splashtablename, 0, ref, 14));
  scripts\cp\rank::registerscoreinfo(ref, #"alwaysshowsplash", var_43297beee133b22);
}

function function_cbf4b04a2e7f02ae(ref, var_5a45f9068b4f316, var_8cde9a095cf42d8f) {
  assert(isxhashasset(var_5a45f9068b4f316));

  if(!isxhashasset(var_5a45f9068b4f316)) {
    return;
  }

  splashbundle = getscriptbundle(var_5a45f9068b4f316);
  assert(isstruct(splashbundle));

  if(!isstruct(splashbundle)) {
    return;
  }

  if(isDefined(splashbundle.shortname)) {
    scripts\cp\rank::registerscoreinfo(ref, #"hastext", 1);
  }

  if(isDefined(splashbundle.priority)) {
    scripts\cp\rank::registerscoreinfo(ref, #"priority", splashbundle.priority);
  }

  if(istrue(splashbundle.alwaysshowsplash)) {
    scripts\cp\rank::registerscoreinfo(ref, #"alwaysshowsplash", 1);
  }
}

function onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

function onplayerconnect_events() {
  self.killedplayers = [];
  self.killedby = [];
  self.lastkilledby = undefined;
  self.greatestuniqueplayerkills = 0;
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.lastkilltime = 0;
  self.lastkilldogtime = 0;
  self.damagedplayers = [];

  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
  }

  if(!isDefined(self.pers["cur_death_streak"])) {
    self.pers["cur_death_streak"] = 0;
  }

  initslidemonitor();
  initmonitoradstime();
  thread monitorreload();
  thread monitorweaponpickup();
  self.lastweaponchangetime = 0;
  initstancetracking();
}

function damagedplayer(victim, damage) {
  if(damage < 50 && damage > 10) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_light", undefined, 0.1);
    return;
  }

  level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

function playerworlddeath(attacker, meansofdeath) {}

function killedplayernotifysys(killid, victim, objweapon, meansofdeath) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self.killsinaframecount)) {
    self.killsinaframecount = 0;
  }

  self.killsinaframecount++;

  if(weaponclass(objweapon) == "spread") {
    if(!isDefined(self.shotgunkillsinaframecount)) {
      self.shotgunkillsinaframecount = 1;
    } else {
      self.shotgunkillsinaframecount++;

      if(self.shotgunkillsinaframecount >= 2) {
        shotguncollateral(self.shotgunkillsinaframecount);
      }
    }
  } else if(meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT") {
    if(!isDefined(self.bulletkillsinaframecount)) {
      self.bulletkillsinaframecount = 1;
    } else {
      self.bulletkillsinaframecount++;

      if(self.bulletkillsinaframecount >= 2) {
        collateral(self.bulletkillsinaframecount);
      }
    }
  }

  waittillframeend();
  thread notifykilledplayer(killid, victim, objweapon, meansofdeath, self.killsinaframecount);
  self.killsinaframecount = 0;
  self.bulletkillsinaframecount = 0;
  self.shotgunkillsinaframecount = 0;
}

function notifykilledplayer(killid, victim, objweapon, meansofdeath, numkills) {
  fullweaponstring = getcompleteweaponname(objweapon);

  for(i = 0; i < numkills; i++) {
    self notify("got_a_kill", victim, fullweaponstring, meansofdeath);
    waitframe();
  }
}

function killedenemy(killid, victim, objweapon, meansofdeath, inflictor, psoffsettime, shitloc) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(level.numkills)) {
    level.numkills = 0;
  }

  level.numkills++;
  self.modifiers = [];
  self.modifiers["mask"] = 0;

  if(!istrue(self.pers["ignoreKillstreakKillRewards"])) {
    checkkillstreakkillevents(objweapon, meansofdeath, inflictor);
  }

  if(isai(victim) || isDefined(victim.classname) && victim.classname == "script_vehicle") {
    victim.guid = victim getentitynumber();
  }

  victimguid = victim.guid;
  myguid = self.guid;
  curtime = gettime();
  fullweaponstring = getcompleteweaponname(objweapon);
  thread killedplayernotifysys(killid, victim, objweapon, meansofdeath);
  thread updaterecentkills(killid, victim, objweapon, fullweaponstring);
  thread updatequadfeedcounter(self, killid);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = curtime;
  self.lastkilledplayer = victim;
  self.lastkillvictimpos = victim.origin;

  if(isPlayer(self)) {
    if(self.deaths > 0) {
      kdr = self.kills / self.deaths;

      if(kdr > 3) {
        level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_kd_high", undefined, 0.75);
      }
    } else if(self.kills > 5) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_kd_high", undefined, 0.75);
    }
  }

  if(istrue(self.laststanding)) {
    incpersstat("clutch", 1);
  }

  if(isDefined(self.damagedplayers) && isDefined(self.damagedplayers[victimguid])) {
    self.damagedplayers[victimguid] = undefined;
  }

  weapongroup = scripts\cp\weapon::getweapongroup(objweapon.basename);

  if(!scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename) && !scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    if(meansofdeath == "MOD_EXECUTION") {
      execution(killid);
    }

    if(objweapon.basename == "none" && !scripts\cp_mp\utility\player_utility::isinvehicle() && meansofdeath != "MOD_EXECUTION") {
      return 0;
    }

    if(isDefined(victim.attackerposition)) {
      attackerposition = victim.attackerposition;
    } else {
      attackerposition = self.origin;
    }

    attackerisinflictor = 1;

    if(isDefined(inflictor)) {
      attackerisinflictor = inflictor == self;
    }

    var_a2c3fea3986af52a = anglesToForward(self getplayerangles());
    var_146f31f6b6666ca7 = victim.origin - attackerposition;
    var_9669ee24872dd095 = vectorNormalize(var_146f31f6b6666ca7);
    var_72705a221874f8a9 = vectordot(var_a2c3fea3986af52a, var_9669ee24872dd095);
    isbulletdamage = isbulletdamage(meansofdeath);

    if(isDefined(victim.attackerdata)) {
      if(weapongroup == "weapon_sniper" && meansofdeath != "MOD_MELEE" && curtime == victim.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hash_603a0dde50c94e47"));
        thread scripts\cp\points::doscoreevent(#"one_shot_kill");
        incpersstat("oneShotOneKills", 1);
      }

      if(weapongroup == "weapon_shotgun" && meansofdeath != "MOD_MELEE" && curtime == victim.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill_shotgun"] = 1;
        incpersstat("oneShotOneKills", 1);
      }
    }

    if(meansofdeath == "MOD_MELEE") {
      if(weapongroup != "weapon_melee" && weapongroup != "weapon_melee2") {
        thread scripts\cp\points::doscoreevent(#"gun_butt");
      }

      if(objweapon.basename == "iw9_me_fists_mp") {
        thread scripts\cp\points::doscoreevent(#"fist_kill");
      }
    }

    if(isPlayer(victim)) {
      heldoffhand = victim getheldoffhand();

      if(heldoffhand.basename == "frag_grenade_mp" || heldoffhand.basename == "cluster_grenade_mp") {
        self.modifiers["cooking"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"cooking"));
      }
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      assistedsuicide(killid, objweapon);
    }

    if(!istrue(game["firstBlood"])) {
      game["firstBlood"] = 1;
      firstblood(killid);
    }

    if(isDefined(self.pers) && self.pers["cur_death_streak"] > 3) {
      comeback(killid);
    }

    if(meansofdeath == "MOD_HEAD_SHOT" || isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet" || shitloc == "neck") && !istrue(meansofdeath == "MOD_FIRE") && !istrue(meansofdeath == "MOD_EXPLOSIVE")) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      headshot(killid);
    }

    if(isDefined(self.wasti) && self.wasti && curtime - self.spawntime <= 5000) {
      self.modifiers["jackintheboxkill"] = 1;
    }

    if(!scripts\cp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      timesincelastdeath = gettime() - self.deathtime;

      if(timesincelastdeath < 1500 && timesincelastdeath > 0) {
        postdeathkill(killid);
      }

      if(scripts\cp\utility::issimultaneouskillenabled()) {
        if(timesincelastdeath == 0 && isDefined(self.lastattacker) && self.lastattacker == victim) {
          thread scripts\cp\points::doscoreevent(#"hash_992baa42f95d6a55", undefined, undefined, undefined, 1);
          victim thread scripts\cp\points::doscoreevent(#"hash_992baa42f95d6a55", undefined, undefined, undefined, 1);
        }
      }
    }

    if(isDefined(victim.lastkilltime) && level.teambased && curtime - victim.lastkilltime < 1500) {
      if(isDefined(victim.lastkilledplayer) && victim.lastkilledplayer != self) {
        avengedplayer(killid, victim.lastkilledplayer);
      }
    }

    if(isDefined(victim.damagedplayers)) {
      foreach(guid, damagetime in victim.damagedplayers) {
        if(guid == self.guid || guid == string(victim.guid)) {
          continue;
        }

        if(level.teambased && curtime - damagetime < 1750) {
          defendedplayer(killid, guid);
        }
      }
    }

    if(attackerisinflictor) {
      var_3c709d201f0772ad = getshotdistancetype(self, objweapon, meansofdeath, attackerposition, victim);

      switch (var_3c709d201f0772ad) {
        case #"hash_e1ae7daca67ccc55":
          thread pointblank(killid);
          break;
        case #"hash_bbddd8225d923d3":
          thread longshot(killid, self, victim);
          break;
        case #"hash_4364fa08acd17954":
          thread longshot(killid, self, victim);
          thread very_longshot(killid);
          break;
      }
    }

    if(isbackkill(self, victim, meansofdeath)) {
      if(objweapon.basename == "iw8_knife_mp") {
        thread scripts\cp\points::doscoreevent(#"backstab");
      }

      self.modifiers["backstab"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"backstab"));
    }

    if(self isswimming()) {
      self.modifiers["swimming"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"swimming"));
    }

    if(self ishanging()) {
      self.modifiers["ledgehanging"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"ledgehanging"));
    }

    if(self getcamerathirdperson() || self getplayerdata("cp", "progression", "thirdPerson") == 1) {
      self.modifiers["thirdperson"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"thirdperson"));
    }

    if(level.script == "cp_hydro") {
      if(!istrue(self isnightvisionon())) {
        self.modifiers["withoutnvgs"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"withoutnvgs"));
      }
    }

    if(self getclientomnvar("ui_assault_suit_on") == 1) {
      self.modifiers["victiminstronghold"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"victiminstronghold"));
    }

    if(attackerisinflictor) {
      switch (weaponclass(objweapon.basename)) {
        case #"hash_8cdaf2e4ecfe5b51":
          incpersstat("arKills", 1);
          victim incpersstat("arDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("arHeadshots", 1);
          }

          break;
        case #"hash_900cb96c552c5e8e":
          incpersstat("smgKills", 1);
          victim incpersstat("smgDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("smgHeadshots", 1);
          }

          break;
        case #"hash_690c0d6a821b42e":
          incpersstat("shotgunKills", 1);
          victim incpersstat("shotgunDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("shotgunHeadshots", 1);
          }

          break;
        case #"hash_fa24dff6bd60a12d":
          incpersstat("lmgKills", 1);
          victim incpersstat("lmgDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("lmgHeadshots", 1);
          }

          break;
        case #"hash_6191aaef9f922f96":
          incpersstat("sniperKills", 1);
          victim incpersstat("sniperDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("sniperHeadshots", 1);
          }

          break;
        case #"hash_61e969dacaaf9881":
          incpersstat("launcherKills", 1);
          victim incpersstat("launcherDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("launcherHeadshots", 1);
          }

          break;
        case #"hash_719417cb1de832b6":
          incpersstat("pistolKills", 1);
          victim incpersstat("pistolDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT") {
            incpersstat("pistolHeadshots", 1);
          }

          break;
      }

      if(meansofdeath == "MOD_MELEE") {
        incpersstat("meleeKills", 1);
        victim incpersstat("meleeDeaths", 1);
      }

      if(scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        incpersstat("stoppingPowerKills", 1);

        if(!isDefined(self.stoppingpowerkills)) {
          self.stoppingpowerkills = 0;
        }

        self.stoppingpowerkills++;
      }

      if(scripts\cp\utility::_hasperk("specialty_quieter")) {
        incpersstat("deadSilenceKills", 1);

        if(!isDefined(self.deadsilencekills)) {
          self.deadsilencekills = 0;
        }

        self.deadsilencekills++;
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(drone in level.supportdrones) {
          if(drone.owner == self && drone.helperdronetype == "radar_drone_overwatch") {
            drone.owner incpersstat("killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(issurvivorkill(self)) {
        thread doscoreevent(#"low_health_kill");
      }

      if(scripts\cp\utility\player::isplayerads()) {
        self.modifiers["ads"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ads"));
        incpersstat("adsKills", 1);
      } else if(isbulletdamage) {
        self.modifiers["hipfire"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hipfire"));
        incpersstat("hipfireKills", 1);
      }

      if(!self isonground()) {
        self.modifiers["airborne"] = 1;
      }

      if(isPlayer(victim) || isagent(victim)) {
        if(!victim isonground()) {
          self.modifiers["victim_airborne"] = 1;
        }
      }

      if(self playermount() >= 0.5) {
        self.modifiers["mounted"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"mounted"));
      }

      if(isbulletdamage) {
        self.modifiers["bullet_damage"] = 1;
        remainingammo = self getweaponammoclip(objweapon);

        if(remainingammo <= 0) {
          self.modifiers["last_bullet_kill"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"lastbullet"));
        }
      }

      if(isPlayer(victim) || isagent(victim)) {
        if(victim issprinting()) {
          self.modifiers["victim_sprinting"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"victimsprinting"));
        }
      }

      if(level.teambased) {
        foreach(player in level.players) {
          if(self.team != player.team || self == player) {
            continue;
          }

          if(!scripts\cp\utility\player::isreallyalive(player)) {
            continue;
          }

          if(distancesquared(self.origin, player.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
        }
      }

      if(scripts\cp_mp\armor::hasarmor()) {
        self.modifiers["weearingarmor"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"wearingarmor"));
      }

      if(scripts\cp_mp\armor::function_9bca5c1d23a3e0b3()) {
        self.modifiers["fullarmor"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"fullarmor"));
      }
    } else if(weapongroup == "weapon_projectile") {
      if(isDefined(inflictor) && isDefined(inflictor.adsfire)) {
        if(inflictor.adsfire) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ads"));
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hipfire"));
        }
      }
    }

    if(isPlayer(victim) || isagent(victim)) {
      if(!victim isonground() && !victim iswallrunning() && !self isonground() && !self iswallrunning()) {
        if(attackerisinflictor) {
          thread doscoreevent(#"air_to_air_kill");
        }
      } else {
        if(attackerisinflictor) {
          if(self iswallrunning()) {
            thread doscoreevent(#"wallrun_kill");
          } else if(isdeathfromabove(self, objweapon, meansofdeath, attackerposition, victim)) {
            thread doscoreevent(#"air_kill");
          } else if(events_issliding()) {
            thread doscoreevent(#"slide_kill");
            self.modifiers["sliding"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"slide"));
          }

          stance = self getstance();

          switch (stance) {
            case #"hash_d91940431ed7c605":
              self.modifiers["prone_kill"] = 1;
              self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"prone"));
              break;
            case #"hash_3fed0cbd303639eb":
              self.modifiers["crouch_kill"] = 1;
              self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"crouch"));
              break;
          }
        }

        if(victim iswallrunning()) {
          thread doscoreevent(#"hash_a7776242889bf154");
        } else if(isskeetshooter(self, objweapon, meansofdeath, attackerposition, victim)) {
          thread doscoreevent(#"hash_37c5d5f71008db1d");
        }
      }
    }

    if(isDefined(victim.streakdata)) {
      foreach(streakinfo in victim.streakdata.streaks) {
        costdiff = streakinfo.currentcost - victim.streakpoints;

        if(costdiff > 0 && costdiff <= 1) {
          buzzkill(killid, victim);
          break;
        }
      }
    }

    if(attackerisinflictor && (isPlayer(self) || isagent(self))) {
      if(self ismantling()) {
        thread scripts\cp\points::doscoreevent(#"mantle_kill");
      }

      if(isDefined(self.tookweaponfrom[fullweaponstring]) && self.tookweaponfrom[fullweaponstring] == victim) {
        thread scripts\cp\points::doscoreevent(#"backfire");
        self.modifiers["backfire"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"backfire"));
      }
    }

    if(isDefined(victim.stuckbygrenade)) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);
      self.modifiers["grenadestuck"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"grenadestuck"));
    }

    if(scripts\cp\cp_weapons::isthrowingknife(objweapon.basename)) {
      thread scripts\cp\points::doscoreevent(#"throwingknife_kill");
    }

    if(isDefined(victim.baitedbydecoy) && isDefined(victim.baitedbydecoy.owner)) {
      if(victim.baitedbydecoy.owner != self) {
        thread killeventtextpopup(#"assist_decoy");
      }
    }

    if(isagent(victim) && istrue(victim scripts\cp\spawning::is_specified_unittype("juggernaut"))) {
      thread killeventtextpopup(#"kill_juggernaut");
    }

    cur_kill_streak = self.pers["cur_kill_streak"] + 1;
    streaknum = 5;

    if(level.gametype == "arm") {
      streaknum = 10;
    }

    if(!(cur_kill_streak % streaknum)) {
      if(!isDefined(self.lastkillsplash) || cur_kill_streak != self.lastkillsplash) {
        thread teamplayercardsplash("callout_kill_streaking", self, undefined, cur_kill_streak);
        self.lastkillsplash = cur_kill_streak;
      }

      if(cur_kill_streak <= 30) {
        thread scripts\cp\points::doscoreevent(hashcat(#"streak_", cur_kill_streak));
      }
    }

    if(cur_kill_streak > 30) {
      thread scripts\cp\points::doscoreevent(#"streak_max");
    }

    if(isDefined(inflictor) && istrue(inflictor.isequipment) && meansofdeath == "MOD_IMPACT" && !scripts\cp\cp_weapons::isthrowingknife(objweapon.basename)) {
      thread scripts\cp\points::doscoreevent(#"item_impact");
      self.modifiers["item_impact"] = 1;
    }

    if(scripts\cp\cp_weapons::islauncherdirectimpactdamage(objweapon, meansofdeath)) {
      thread scripts\cp\points::doscoreevent(#"hash_e13c7899c2eed171");
      self.modifiers["launcher_impact"] = 1;
    }

    if(var_72705a221874f8a9 >= 0.6428) {
      self.modifiers["victim_in_standard_view"] = 1;
    }

    if(meansofdeath == "MOD_MELEE") {
      self.modifiers["melee"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"melee"));
    }

    if(isDefined(self.lastadsstarttime) && curtime - self.lastadsstarttime <= 500 && weapongroup == "weapon_sniper") {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"quickscope"));
    }

    if(self.health <= 50) {
      self.modifiers["low_health_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"lowhealth"));
    }

    if(isDefined(self.lastweaponchangetime) && curtime - self.lastweaponchangetime <= 1500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"weaponswap"));
    }

    if(isDefined(self.lastweaponpickuptime) && curtime - self.lastweaponpickuptime <= 1500) {
      self.modifiers["weapon_pickup_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hash_30a2422996add07a"));
    }

    if(isDefined(self.lastreloadtime) && curtime - self.lastreloadtime <= 1500) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"recentreload"));
    }

    vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"invehicle"));

      if(meansofdeath == "MOD_CRUSH") {
        self.modifiers["crush"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"crush"));
      }
    }

    if(victim scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["victim_in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"victiminvehicle"));
    }

    if(self isinvehicleleanout()) {
      self.modifiers["vehiclelean"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehiclelean"));
    }

    for(moverparent = self; true; moverparent = newparent) {
      if((isPlayer(moverparent) || isactor(moverparent)) && !moverparent islinked()) {
        newparent = moverparent getmovingplatformparent(1);
      } else {
        newparent = moverparent getlinkedparent();
      }

      if(!isDefined(newparent)) {
        break;
      }
    }

    if(isDefined(moverparent) && moverparent scripts\cp_mp\vehicles\vehicle::isvehicle() && (!isDefined(vehicle) || moverparent != vehicle)) {
      self.modifiers["vehiclesurf"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehiclesurf"));

      if(moverparent vehicle_getspeed() > 25) {
        self.modifiers["infastvehicle"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"infastvehicle"));
      }
    }

    if(isDefined(inflictor) && isDefined(inflictor.equipmentref)) {
      if(inflictor.equipmentref == "equip_c4" || inflictor.equipmentref == "equip_claymore") {
        stuckto = inflictor getlinkedparent();

        if(isDefined(stuckto) && isDefined(stuckto.helperdronetype) && stuckto.helperdronetype == "radar_drone_recon") {
          self.modifiers["recon_drone_explosive"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"recondroneexplosive"));

          if(level.challengesallowed && isDefined(stuckto.owner)) {
            self.recondroneteammate = stuckto.owner;
          }
        } else if(isDefined(stuckto) && stuckto scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          self.modifiers["vehicle_explosive"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehicleexplosive"));
        }
      }
    }

    if(istrue(victim.isdefusing)) {
      self.modifiers["killed_defuser"] = 1;
    }

    if(scripts\cp\weapon::iscacsecondaryweapon(objweapon)) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"usingsecondaryweapon"));
    }

    if(scripts\cp\laststand::isinlaststand(self)) {
      self.modifiers["last_stand"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"laststand"));
    }

    thread checkmatchdatakills(killid, victim);
  }

  if(!isDefined(self.killedplayers[victimguid])) {
    self.killedplayers[victimguid] = 0;
  }

  if(!isDefined(victim.killedby) || !isDefined(victim.killedby[myguid])) {
    victim.killedby[myguid] = 0;
  }

  self.killedplayers[victimguid]++;
  victim.killedby[myguid]++;
  victim.lastkilledby = self;

  if(isPlayer(victim)) {
    if(!victim scripts\common\utility::isusingremote() && (!victim scripts\cp\utility::_hasperk("specialty_survivor") || istrue(victim.inlaststand))) {
      victim thread scripts\cp\utility::setdof_killer();
    }
  }

  bufferednotify("kill_event_buffered", victim, fullweaponstring, meansofdeath, self.modifiers);
}

function iskillstreakvehicleinflictor(einflictor) {
  return isDefined(einflictor) && isDefined(einflictor.streakinfo) && (isDefined(einflictor.vehiclename) || isDefined(einflictor.vehiclemodel));
}

function checkkillstreakkillevents(objweapon, meansofdeath, inflictor) {
  iskillstreak = scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename) || iskillstreakvehicleinflictor(inflictor);
  forcekillstreak = scripts\cp\points::isforcekillstreakprogressweapon(objweapon);

  if(iskillstreak && !forcekillstreak) {
    killstreakname = level.killstreakweaponmap[objweapon.basename];
    cankillchain = 0;
    givemidmatch = 0;
    isair = 0;
    isground = 0;

    if(isDefined(inflictor.model) && is_equal(inflictor.model, "ks_airstrike_target_mp")) {
      killstreakname = "precision_airstrike";
    }

    if(!isDefined(killstreakname)) {
      return;
    }

    if(!isDefined(self.modifiers)) {
      self.modifiers = [];
    }

    if(!isDefined(self.modifiers["mask"])) {
      self.modifiers["mask"] = 0;
    }

    if(!isDefined(self.modifiers["mask2"])) {
      self.modifiers["mask2"] = 0;
    }

    switch (killstreakname) {
      case #"hash_9e36e3bd3a9dd00d":
        givemidmatch = 1;
        isground = 1;
        self.modifiers["recon_drone_explosive"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"recondroneexplosive"));
        break;
      case #"hash_e477c24ee18bb2f6":
        incpersstat("killstreakTankKills", 1);
        givemidmatch = 1;
        isground = 1;
        break;
      case #"hash_4d35eb58f9d545f0":
        givemidmatch = 1;
        isground = 1;
        self.modifiers["cluster_mine_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"cluster_mine_kill"));
        break;
      case #"hash_349713b5ad494dda":
        incpersstat("killstreakChopperGunnerKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_691f39dddd9116b8":
        incpersstat("killstreakChopperSupportKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_28d0236400e33fd0":
        incpersstat("killstreakCruiseMissileKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_4220be38a5f150b8":
        givemidmatch = 1;
        break;
      case #"hash_413c38e72fe8b5bf":
        incpersstat("killstreakGunshipKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_bf2f9adbd2b41d5":
        incpersstat("killstreakVTOLJetKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_4ad475e6e15635bd":
        incpersstat("killstreakJuggernautKills", 1);
        givemidmatch = 1;
        isground = 1;
        break;
      case #"hash_52d9b7ed584bec3e":
        incpersstat("killstreakShieldTurretKills", 1);
        givemidmatch = 1;
        isground = 1;
        break;
      case #"hash_62810d05099e0103":
        givemidmatch = 1;
        break;
      case #"hash_cf0ef5bef19a311b":
        incpersstat("killstreakWheelsonKills", 1);
        givemidmatch = 1;
        isground = 1;
        break;
      case #"hash_8c766d6477287bb6":
        incpersstat("killstreakAirstrikeKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_4d5aa76e8707f47b":
        incpersstat("killstreakSentryGunKills", 1);
        givemidmatch = 1;
        isground = 1;
        self.modifiers["sentry_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask2"], function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"sentry_kill"));
        break;
      case #"hash_b4ac3581c343a029":
        incpersstat("killstreakCluserStrikeKills", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      case #"hash_e6bea339d3cbd3e8":
        incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        givemidmatch = 1;
        isair = 1;
        break;
      default:
        thread scripts\cp\points::doscoreevent(#"hash_1387a1180e68dc64", objweapon);
        break;
    }

    if(isDefined(inflictor.streakinfo)) {
      if(!isDefined(inflictor.streakinfo.kills)) {
        inflictor.streakinfo.kills = 0;
      }

      inflictor.streakinfo.kills++;
    }

    incpersstat("killstreakKills", 1);

    if(isair) {
      incpersstat("killstreakAirKills", 1);
    }

    if(isground) {
      incpersstat("killstreakGroundKills", 1);
    }

    if(givemidmatch) {
      thread scripts\cp\points::doscoreevent(hashcat(#"ss_kill_", killstreakname), undefined, undefined, undefined, undefined, undefined, undefined, cankillchain);
    }

    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
  }
}

function killedkillstreak(killstreakname, killer, objweapon) {
  if(scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename)) {
    thread checkkillstreakkillevents(objweapon, undefined, killer);
  } else {
    awardname = hashcat(#"kill_ss_", killstreakname);
    eventinfo = spawnStruct();
    eventinfo.isdestroyedkillstreak = 1;
    killer thread scripts\cp\points::doscoreevent(awardname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo);
    killer incpersstat("destroyedKillstreaks", 1);
    level thread scripts\cp\cp_player_battlechatter::saytoself(killer, "plr_killstreak_destroy", undefined, 0.75);
  }

  if(isDefined(killer.perk_data) && killer scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
    var_199c16fdbeb2c72b = 10;
    amount = var_199c16fdbeb2c72b * killer.perk_data["super_fill_scalar"];
    killer scripts\cp\super::increase_super_progress(amount);
  }
}

function is_enemy_highest_score(enemy, enemies) {
  foreach(e in enemies) {
    if(e.score > enemy.score) {
      return false;
    }
  }

  return true;
}

function getshotdistancetype(attacker, objweapon, meansofdeath, attackerposition, victim) {
  if(isalive(attacker) && !attacker scripts\common\utility::isusingremote() && (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT") && !scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename) && !istrue(attacker.assistedsuicide)) {
    killdistsq = distancesquared(attackerposition, victim.origin);

    if(killdistsq < 9216) {
      return "pointblank";
    }

    if(killdistsq > 4000000) {
      return "very_longshot";
    }

    var_a77e978567103b98 = scripts\cp\weapon::getweapongroup(objweapon.basename);
    longshotdist = undefined;

    switch (var_a77e978567103b98) {
      case #"hash_34340d457a63e7f1":
        longshotdist = 800;
        break;
      case #"hash_ab10f9c080fe4faf":
      case #"hash_c9c190665b9c4a1d":
        longshotdist = 1200;
        break;
      case #"hash_bef5ec0b3e197ae":
      case #"hash_47368bc0d2ef1565":
      case #"hash_8af0086b038622b5":
      case #"hash_dd616da0b395a0b0":
        if(objweapon.basename == "iw9_dm_crossbow_mp") {
          longshotdist = 1200;
        } else {
          longshotdist = 1500;
        }

        break;
      case #"hash_46b22b021532342e":
      case #"hash_c095d67337b1f5a1":
        longshotdist = 2000;
        break;
      case #"hash_16cf6289ab06bd30":
        longshotdist = 500;
        break;
      case #"hash_9d18adab1b65a661":
      default:
        longshotdist = 1536;
        break;
    }

    longshotdistsq = longshotdist * longshotdist;

    if(killdistsq > longshotdistsq) {
      return "longshot";
    }
  }

  return "none";
}

function isdeathfromabove(attacker, objweapon, meansofdeath, attackerposition, victim) {
  if(isalive(attacker) && attacker isjumping() && isbulletdamage(meansofdeath)) {
    deltaheight = attacker.origin[2] - victim.origin[2];
    return (deltaheight > 60);
  }

  return false;
}

function isskeetshooter(attacker, objweapon, meansofdeath, attackerposition, victim) {
  return isalive(attacker) && victim isjumping() && isbulletdamage(meansofdeath);
}

function isbackkill(attacker, victim, meansofdeath) {
  if(!isPlayer(attacker) || !isPlayer(victim)) {
    return false;
  }

  if(meansofdeath != "MOD_RIFLE_BULLET" && meansofdeath != "MOD_PISTOL_BULLET" && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_HEAD_SHOT") {
    return false;
  }

  victimangles = victim getplayerangles();
  attackerangles = attacker getplayerangles();
  anglediff = angleclamp180(victimangles[1] - attackerangles[1]);

  if(abs(anglediff) < 80) {
    return true;
  }

  return false;
}

function issurvivorkill(player) {
  return player.health > 0 && player.health < player.maxhealth * 0.2;
}

function checkmatchdatakills(killid, victim) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == victim) {
    self.lastkilledby = undefined;
    revenge(killid, victim);
  }
}

function proximityassist(killid) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\cp\points::doscoreevent(#"proximityassist");
}

function proximitykill(killid) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\cp\points::doscoreevent(#"proximitykill");
}

function longshot(killid, attacker, victim) {
  self.modifiers["longshot"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"longrange"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "longshot");

  if(isDefined(attacker) && isDefined(victim) && isalive(attacker)) {
    killdist = math::round_float(distance(attacker.origin, victim.origin) / 39.37, 2);
    self setclientomnvar("ui_longshot_dist", killdist);
  }

  incpersstat("longshotKills", 1);
  thread scripts\cp\points::doscoreevent(#"longshot");
}

function very_longshot(killid) {
  self.modifiers["very_longshot"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"hash_72a2c2883e780324"));
}

function pointblank(killid) {
  self.modifiers["pointblank"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"shortrange"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "pointblank");
  thread scripts\cp\points::doscoreevent(#"pointblank");
  incpersstat("pointBlankKills", 1);
}

function headshot(killid) {
  self.modifiers["headshot"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"headshot"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "headshot");
  thread scripts\cp\points::doscoreevent(#"headshot");
}

function avengedplayer(killid, lastvictim) {
  self.modifiers["avenger"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"avenger"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "avenger");
  incpersstat("avengerKills", 1);
  thread scripts\cp\points::doscoreevent(#"avenger");
}

function assistedsuicide(killid, objweapon) {
  self.modifiers["assistedsuicide"] = 1;
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "assistedsuicide");
  thread scripts\cp\points::doscoreevent(#"assistedsuicide", objweapon);
}

function defendedplayer(killid, guid) {
  self.modifiers["defender"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"defender"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "defender");
  incpersstat("defenderKills", 1);
  saved = scripts\cp\utility::getplayerforguid(guid);
  thread killeventtextpopup(#"hash_106962d4edb25321", 0);
  thread scripts\cp\points::doscoreevent(#"save_teammate");
}

function postdeathkill(killid) {
  self.modifiers["posthumous"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"posthumous"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "posthumous");
  thread scripts\cp\points::doscoreevent(#"posthumous");
}

function revenge(killid, victim) {
  self.modifiers["revenge"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"revenge"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "revenge");
  incpersstat("revengeKills", 1);
  thread scripts\cp\points::doscoreevent(#"revenge");
}

function multikill(killid, killcount, var_c95c893c15217527, dontshowscoreevent) {
  assert(killcount > 1);

  if(!isDefined(self.currentmultikill)) {
    self.currentmultikill = killcount;
  }

  if(killcount < self.currentmultikill) {
    return;
  }

  self notify("multiKill");
  self endon("multiKill");
  waitframe();
  award = undefined;
  teamsplash = undefined;
  self notify("got_multikill");

  switch (killcount) {
    case 2:
      award = #"double";
      break;
    case 3:
      award = #"triple";
      teamsplash = "callout_3xkill";
      break;
    case 4:
      award = #"four";
      teamsplash = "callout_4xkill";
      break;
    case 5:
      award = #"five";
      teamsplash = "callout_5xkill";
      break;
    case 6:
      award = #"six";
      teamsplash = "callout_6xkill";
      break;
    case 7:
      award = #"seven";
      teamsplash = "callout_7xkill";
      break;
    case 8:
      award = #"eight";
      teamsplash = "callout_8xkill";
      break;
    default:
      award = #"multi";
      teamsplash = "callout_9xkill";
      break;
  }

  if(isDefined(self.pers["highestMultikill"]) && killcount > self.pers["highestMultikill"]) {
    self.pers["highestMultikill"] = killcount;
  }

  thread scripts\cp\cp_matchdata::logmultikill(killid, killcount);

  if(isDefined(award)) {
    thread killeventtextpopup(award, ter_op(isDefined(var_c95c893c15217527), var_c95c893c15217527, 1), istrue(dontshowscoreevent));

    if(!istrue(dontshowscoreevent)) {
      thread scripts\cp\points::doscoreevent(award, self getcurrentweapon());
    }
  }

  if(isDefined(teamsplash)) {
    if(!istrue(dontshowscoreevent)) {
      thread fireoffsplashforplayer(self, teamsplash, undefined, self);
      return;
    }

    thread teamplayercardsplash(teamsplash, self, self.team, undefined, 1);
  }
}

function fireoffsplashforplayer(player, splash, optionalnumber, owner) {
  player thread scripts\cp\cp_hud_message::showsplash(splash, optionalnumber, owner);
}

function firstblood(killid) {
  self.modifiers["firstblood"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"firstblood"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "firstblood");
  thread teamplayercardsplash("callout_firstblood", self);
  thread scripts\cp\points::doscoreevent(#"firstblood");
}

function winningshot(killid) {}

function buzzkill(killid, victim) {
  self.modifiers["buzzkill"] = victim.pers["cur_kill_streak"];
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"buzzkill"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "buzzkill");
  thread scripts\cp\points::doscoreevent(#"buzzkill");
}

function comeback(killid) {
  self.modifiers["comeback"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"comeback"));
  thread scripts\cp\cp_matchdata::logattackerkillevent(killid, "comeback");
  thread scripts\cp\points::doscoreevent(#"comeback");
  incpersstat("comebackKills", 1);
}

function collateral(numkills) {
  if(numkills == 2) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
    thread scripts\cp\points::doscoreevent(#"one_shot_two_kills");
  }

  if(numkills == 3) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
  }
}

function shotguncollateral(numkills) {}

function quadfeed(killid, struct) {
  self.modifiers["quadfeed"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"quadfeed"));
  thread scripts\cp\points::doscoreevent(#"quad_feed");
}

function disconnected() {
  myguid = self.guid;

  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].killedplayers[myguid])) {
      level.players[entry].killedplayers[myguid] = undefined;
    }

    if(isDefined(level.players[entry].killedby[myguid])) {
      level.players[entry].killedby[myguid] = undefined;
    }
  }
}

function monitorhealed() {
  if(scripts\cp\rank::function_377a94f711d96927("healed") == 0) {
    return;
  }

  level endon("end_game");

  for(;;) {
    level waittill("healed", player);
    player thread scripts\cp\points::doscoreevent(#"healed");
  }
}

function updaterecentkills(killid, victim, objweapon, fullweaponstring) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");

  if(!isDefined(self.recentkillcount)) {
    self.recentkillcount = 0;
  }

  self.recentkillcount++;

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[fullweaponstring])) {
    self.recentkillsperweapon[fullweaponstring] = 1;
  } else {
    self.recentkillsperweapon[fullweaponstring]++;
  }

  weaponinfo = scripts\cp\utility::getequipmenttype(objweapon.basename);

  if(isDefined(weaponinfo) && weaponinfo == "lethal" && objweapon.basename != "throwingknife_mp") {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.recentkillsperweapon[fullweaponstring] > 0 && self.recentkillsperweapon[fullweaponstring] % 2 == 0) {
      thread scripts\cp\points::doscoreevent(#"grenade_double");
    }
  }

  bufferednotify("update_rapid_kill_buffered", self.recentkillcount, fullweaponstring);

  if(self.recentkillcount > 1) {
    thread multikill(killid, self.recentkillcount, 0);
  }

  wait 2.5;

  if(self.recentkillcount > 1) {
    thread multikill(killid, self.recentkillcount, 1, 1);
  }

  incpersstat("mostMultikills", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.recentkillsperweapon = undefined;
}

function monitorcratejacking() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", cratetype, owner);
    thread scripts\cp\points::doscoreevent(#"hash_519e0923d0608694");
    splashname = "hijacked_airdrop";

    if(isDefined(owner)) {
      owner scripts\cp\cp_hud_message::showsplash(splashname, undefined, self);
    }
  }
}

function updatequadfeedcounter(attacker, killid) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 5000) {
    level.quadfeedinfo = undefined;
  }

  if(!isDefined(level.quadfeedinfo) || level.quadfeedinfo.player != attacker) {
    struct = spawnStruct();
    struct.player = attacker;
    struct.starttime = gettime();
    struct.feedcount = 1;
    level.quadfeedinfo = struct;
    return;
  }

  struct = level.quadfeedinfo;
  struct.feedcount++;

  if(struct.feedcount == 4) {
    struct.player quadfeed(killid, struct);
    level.quadfeedinfo = undefined;
  }
}

function initslidemonitor() {
  self.eventswassliding = self issprintsliding();
  self.eventsslideendtime = undefined;
}

function events_monitorslideupdate() {
  if(scripts\cp\utility\player::isreallyalive(self)) {
    eventsissliding = self issprintsliding();

    if(istrue(self.eventswassliding) && !eventsissliding) {
      self.eventsslideendtime = gettime();
    }

    self.eventswassliding = eventsissliding;
    return;
  }

  self.eventswassliding = 0;
  self.eventsslideendtime = undefined;
}

function events_issliding() {
  if(self issprintsliding()) {
    return true;
  }

  events_monitorslideupdate();

  if(isDefined(self.eventsslideendtime)) {
    if(gettime() - self.eventsslideendtime <= 150) {
      return true;
    }
  }

  return false;
}

function initmonitoradstime() {
  self.wasads = scripts\cp\utility\player::isplayerads();
  self.lastadsstarttime = 0;
}

function monitoradstime() {
  if(scripts\cp\utility\player::isplayerads()) {
    if(!self.wasads) {
      self.lastadsstarttime = gettime();
      self.wasads = 1;
    }

    return;
  }

  self.wasads = 0;
}

function monitorreload() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastreloadtime = 0;

  while(true) {
    self waittill("reload");
    self.lastreloadtime = gettime();
    incpersstat("reloads", 1);
  }
}

function monitorweaponpickup() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponpickuptime = 0;

  while(true) {
    self waittill("weapon_pickup");
    self.lastweaponpickuptime = gettime();
    incpersstat("weaponPickups", 1);
  }
}

function monitorweaponswitch() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponchangetime = 0;

  while(true) {
    self waittill("weapon_change");
    self.lastweaponchangetime = gettime();
  }
}

function updateweaponchangetime() {
  self.lastweaponchangetime = gettime();
}

function initstancetracking() {
  self.laststance = self getstance();
  self.laststancechangetime = gettime();
  self.laststancetimes = [];
  self.laststancetimes["prone"] = 0;
  self.laststancetimes["crouch"] = 0;
  self.laststancetimes["stand"] = 0;
}

function updatestancetracking() {
  if(!isalive(self)) {
    return;
  }

  mantleprev = self.mantlecur;
  self.mantlecur = self ismantling();

  if(!istrue(mantleprev) && self.mantlecur) {}

  jumpprev = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(jumpprev) && self.jumpcur) {}

  stance = self getstance();

  if(stance != self.laststance) {
    if(self.laststance == "crouch") {
      starttime = self.laststancechangetime;
      time = (gettime() - starttime) / 1000;
      incpersstat("timeCrouched", time);
    }

    if(self.laststance == "prone") {
      starttime = self.laststancechangetime;
      time = (gettime() - starttime) / 1000;
      incpersstat("timeProne", time);
    }

    self.laststancechangetime = gettime();

    if(!isDefined(self.pers["stanceTracking"])) {
      self.pers["stanceTracking"] = [];
      self.pers["stanceTracking"]["prone"] = 0;
      self.pers["stanceTracking"]["crouch"] = 0;
      self.pers["stanceTracking"]["stand"] = 0;
    }

    if(stance == "prone" || stance == "crouch" || stance == "stand") {
      self.pers["stanceTracking"][stance]++;
    }
  }

  self.laststancetimes[stance] = gettime();
  self.laststance = stance;
}

function predatormissileimpact(impactpos) {}

function largevehicleexplosion(explosionpos) {}

function vehiclekilled(damagedata) {}

function missilefired(missile) {
  thread trackmissile(missile);
}

function trackmissile(missile) {
  level endon("game_ended");
  missile endon("death");
  missile endon("entitydeleted");
  missile.whizbyplayers = [];

  while(true) {
    whizbyplayers = utility::playersnear(missile.origin, 220);

    foreach(player in whizbyplayers) {
      if(isDefined(missile.owner) && player == missile.owner) {
        continue;
      }

      missilewhizby(player, missile);
      missile.whizbyplayers[player.guid] = 1;
    }

    wait 0.1;
  }
}

function missilewhizby(player, missile) {}

function bombdefused(defuser) {
  var_8f8dc78c3242728b = 0;
  enemiesnearby = 0;

  if(!var_8f8dc78c3242728b) {
    playersnearby = scripts\cp\utility::getplayersinradius(defuser.origin, 600);

    foreach(player in playersnearby) {
      if(player.team != defuser.team) {
        enemiesnearby = 1;
        break;
      }
    }
  }

  if(var_8f8dc78c3242728b) {
    defuser thread scripts\cp\points::doscoreevent(#"mode_sd_last_defuse");
  } else {
    defuser thread scripts\cp\points::doscoreevent(#"mode_sd_defuse");
  }

  defuser incpersstat("defuses", 1);

  if(isPlayer(defuser)) {
    telemetrydata = spawnStruct();
    telemetrydata.player = defuser;
    telemetrydata.eventname = "defuse";
    telemetrydata.position = defuser.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", telemetrydata);
  }
}

function revivedplayer(reviver, revivee) {
  if(scripts\cp\utility::getgametype() == "cp_survival") {}
}

function doorused(player, opening) {
  if(opening) {
    player.lastdooropentime = gettime();
  }
}

function shothit() {}

function shotmissed() {}

function killeventtextpopup(scoreeventref, showassplash, dontshowscoreevent) {
  if(function_16aa7ce5efacbccb()) {
    return;
  }

  self endon("death_or_disconnect");

  if(!scripts\cp\rank::scoreeventhastext(scoreeventref)) {
    return;
  }

  if(!isDefined(self.killeventqueue)) {
    self.killeventqueue = [];
  }

  foreach(event in self.killeventqueue) {
    if(event.scoreeventref == scoreeventref) {
      return;
    }
  }

  splashdata = spawnStruct();
  splashdata.scoreeventref = scoreeventref;
  splashdata.showassplash = istrue(showassplash);
  splashdata.priority = scripts\cp\rank::getscoreeventpriority(scoreeventref);
  splashdata.alwaysshowsplash = scripts\cp\rank::scoreeventalwaysshowassplash(scoreeventref);
  splashdata.processedsplash = 0;
  splashdata.processedscoreevent = 0;
  splashdata.dontshowscoreevent = istrue(dontshowscoreevent);
  self.killeventqueue[self.killeventqueue.size] = splashdata;
  self notify("killEventTextPopup");
  self endon("killEventTextPopup");
  waitframe();

  if(!isDefined(self.splashpriorityqueue)) {
    self.splashpriorityqueue = [];
  }

  foreach(event in self.killeventqueue) {
    insertbypriority(event);
  }

  self.killeventqueue = undefined;
  thread processsplashpriorityqueue();
}

function function_16aa7ce5efacbccb() {
  if(getdvarint(@ "hash_6735e9fcb3e821b9", 0)) {
    return true;
  }

  return istrue(level.var_16aa7ce5efacbccb);
}

function insertbypriority(splashdata) {
  if(self.splashpriorityqueue.size == 0) {
    self.splashpriorityqueue[self.splashpriorityqueue.size] = splashdata;
    return;
  }

  foreach(event in self.splashpriorityqueue) {
    if(event.scoreeventref == splashdata.scoreeventref) {
      return;
    }
  }

  for(i = 0; i < self.splashpriorityqueue.size; i++) {
    if(splashdata.priority > self.splashpriorityqueue[i].priority) {
      self.splashpriorityqueue = array_insert(self.splashpriorityqueue, splashdata, i);
      return;
    }
  }

  self.splashpriorityqueue[self.splashpriorityqueue.size] = splashdata;
}

function processsplashpriorityqueue() {
  self notify("processSplashPriorityQueue");
  self endon("processSplashPriorityQueue");

  if(!isDefined(self.splashpriorityqueue)) {
    return;
  }

  splashallowed = !istrue(level.removekilleventsplash);

  foreach(event in self.splashpriorityqueue) {
    if(splashallowed && istrue(event.showassplash) && event.alwaysshowsplash) {
      println("<dev string:x2b>" + getxhashsourcename(event.scoreeventref));
    }

    println("<dev string:x35>" + getxhashsourcename(event.scoreeventref));
  }

  foreach(event in self.splashpriorityqueue) {
    if(event.processedsplash) {
      continue;
    }

    if(splashallowed && istrue(event.showassplash) && event.alwaysshowsplash) {
      thread scripts\cp\cp_hud_message::showsplash(event.scoreeventref);
    }

    event.processedsplash = 1;
  }

  foreach(event in self.splashpriorityqueue) {
    if(event.processedscoreevent || event.dontshowscoreevent) {
      continue;
    }

    thread scripts\cp\rank::scoreeventpopup(event.scoreeventref);
    event.processedscoreevent = 1;
    wait getdvarfloat(@ "hash_1eb32d180bc7cff8", 0.25);
  }

  self.splashpriorityqueue = undefined;
}

function initpersstat(dataname) {
  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }
}

function getpersstat(dataname) {
  return self.pers[dataname];
}

function incpersstat(dataname, increment) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[dataname])) {
    self.pers[dataname] += increment;
  }
}

function setextrascore0(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore0 = newvalue;
  self.pers["extrascore0"] = newvalue;
}

function setextrascore1(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore1 = newvalue;
  self.pers["extrascore1"] = newvalue;
}

function setextrascore2(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore2 = newvalue;
  self.pers["extrascore2"] = newvalue;
}

function setextrascore3(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore3 = newvalue;
  self.pers["extrascore3"] = newvalue;
}

function getplayerdataloadoutgroup() {
  return "cploadouts";
}

function setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

function canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

function getstreakrecordtype(streakname) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", streakname)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", streakname)) {
    return "supportScorestreakStats";
  }

  return undefined;
}

function execution(killid) {
  self.modifiers["execution"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::function_6d40f12a09494350(self.modifiers["mask"], function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"execution"));
  thread scripts\cp\points::doscoreevent(#"execution");
  self notify("killed_ai_via_execution");
}

function init_ai_kill_params_for_events() {
  self.killedplayers = [];
  self.killedby = [];
  self.lastkilledby = undefined;
  self.greatestuniqueplayerkills = 0;
  self.damagedplayers = [];
  self.lastkilltime = 0;
  self.lastkilldogtime = 0;
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.tookweaponfrom = [];
  self.guid = scripts\cp\utility\player::getuniqueid();
  thread watch_for_long_death();
}

function watch_for_long_death() {
  self endon("death");
  self waittill("long_death");

  if(isDefined(self.attackers) && self.attackers.size > 0) {
    foreach(guid, entity in self.attackers) {
      if(isPlayer(entity)) {
        if(isDefined(self.attackerdata) && self.attackerdata.size > 0) {
          if(!isDefined(entity.longdeathtracker)) {
            entity.longdeathtracker = [];
          }

          entity thread killedenemy(undefined, self, self.attackerdata[guid].objweapon, self.attackerdata[guid].smeansofdeath, entity, 0);
          thread scripts\cp\cp_challenge::onplayerkilled(entity, entity, self.maxhealth, undefined, self.attackerdata[guid].smeansofdeath, self.attackerdata[guid].objweapon, self.attackerdata[guid].smeansofdeathshitloc, entity.modifiers);
          entity thread scripts\cp\points::doscoreevent(#"kill", self.attackerdata[guid].objweapon);
          entity.longdeathtracker[self getentitynumber()] = 1;
        }
      }
    }
  }
}