/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\gunship_cp.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_flares;
#using scripts\cp\globallogic;
#using scripts\cp\killstreaks\gunship_cp;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\gunship;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace gunship_cp;

function init() {
  scripts\engine\utility::registersharedfunc("gunship", "findBoxCenter", &gunship_findboxcenter);
  scripts\engine\utility::registersharedfunc("gunship", "getBombingPoint", &gunship_getbombingpoints);
  scripts\engine\utility::registersharedfunc("gunship", "br_respawn", &gunship_startbrrespawn);

  if(!scripts\cp\utility::is_specops_gametype()) {
    scripts\engine\utility::registersharedfunc("gunship", "assignTargetMarkers", &gunship_assigntargetmarkers);
  }
}

function gunship_findboxcenter(mins, maxs) {
  return scripts\cp\globallogic::findboxcenter(mins, maxs);
}

function gunship_getbombingpoints(centerpoint, numpoints, bombingradius) {
  bombingpoints = [];
  centerpoint -= anglesToForward(self.angles) * 100;

  for(i = 0; i < numpoints; i++) {
    randdist = randomint(bombingradius);
    randangle = randomint(360);
    x = centerpoint[0] + randdist * cos(randangle);
    y = centerpoint[1] + randdist * sin(randangle);
    z = centerpoint[2];
    point = (x, y, z);
    trace = scripts\engine\trace::ray_trace(point + (0, 0, 2000), point - (0, 0, 10000), level.players);

    if(isDefined(trace["position"])) {
      point = trace["position"];
    }

    bombingpoints[bombingpoints.size] = point;
  }

  return bombingpoints;
}

function gunship_startbrrespawn(player) {
  if(isDefined(player) && isPlayer(player)) {
    if(!istrue(player.fauxdead)) {
      player.shouldskiplaststand = 0;
    }
  }
}

function gunship_assigntargetmarkers(gunner) {
  var_2cd52bbc2a67b7cf = [];
  var_ff93381949523976 = [];
  var_4496855dec276732 = [];
  all_ai = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  all_players = level.players;
  var_eba1c5743194000d = [];

  if(isDefined(level.killstreak_additional_targets)) {
    foreach(target in level.killstreak_additional_targets) {
      var_eba1c5743194000d = array_add(var_eba1c5743194000d, target);
    }
  }

  var_4496855dec276732 = array_combine(var_eba1c5743194000d, all_ai, all_players);

  foreach(enemy in var_4496855dec276732) {
    if(level.teambased && enemy.team == self.team) {
      continue;
    }

    if(enemy == self.owner) {
      continue;
    }

    if(enemy scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_2cd52bbc2a67b7cf[var_2cd52bbc2a67b7cf.size] = enemy;
  }

  foreach(player in all_players) {
    if(level.teambased && player.team != self.team) {
      continue;
    }

    var_ff93381949523976[var_ff93381949523976.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var_2cd52bbc2a67b7cf, self.owner, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var_ff93381949523976, self.owner, 1, 1);
  level thread gunship_assignedtargetmarkers_onnewai(self.enemytargetmarkergroup, 0);
}

function gunship_assignedtargetmarkers_onnewai(targetmarkergroupid, var_262f4b55aa151de1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + targetmarkergroupid);

  while(true) {
    level waittill("spawned_group_soldier", soldier);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(soldier, targetmarkergroupid, var_262f4b55aa151de1);
  }
}

function enemygunship_spawngunship(var_2acd6736c2bc3edb, var_a2c5157971449c35, centeroverride, radiusoverride, heightoverride, var_b4a73ef4935724be) {
  if(!istrue(var_b4a73ef4935724be)) {
    if(isDefined(var_2acd6736c2bc3edb) && (isint(var_2acd6736c2bc3edb) || isfloat(var_2acd6736c2bc3edb))) {
      wait var_2acd6736c2bc3edb;
    }

    if(isDefined(var_a2c5157971449c35) && isstring(var_a2c5157971449c35)) {
      level waittill(var_a2c5157971449c35);
    }
  }

  var_8945c22a67231e20 = randomint(360);
  radiusoffset = 15000;

  if(isDefined(radiusoverride)) {
    radiusoffset = radiusoverride;
  }

  xoffset = cos(var_8945c22a67231e20) * radiusoffset;
  yoffset = sin(var_8945c22a67231e20) * radiusoffset;
  zoffset = 8000;

  if(isDefined(heightoverride)) {
    zoffset = heightoverride;
  }

  var_78ac3c5ef5263d4f = vectorNormalize((xoffset, yoffset, zoffset));
  var_78ac3c5ef5263d4f *= zoffset;
  var_bc737640dd23dd18 = "veh8_mil_air_acharlie130_small_east";
  center = level.gunship.origin;

  if(isDefined(centeroverride) && isvector(centeroverride)) {
    center = centeroverride;
    level.gunship.origin = centeroverride;
  }

  gunship_owner = spawn("script_model", center);
  gunship_owner setModel("tag_origin");
  gunship_owner.team = "axis";
  gunship = spawn("script_model", center);
  gunship setModel(var_bc737640dd23dd18);
  gunship setCanDamage(1);
  gunship.currenthealth = 1000;
  gunship.maxhealth = gunship.currenthealth;
  gunship.health = 9999999;
  gunship.owner = gunship_owner;
  gunship.timeout = 6669;
  gunship.currentdamagestate = 0;
  gunship.team = "axis";
  gunship.ogflaresreservecount = 2;
  gunship.flaresreservecount = 2;
  gunship scriptmoveroutline();
  gunship scriptmoverthermal();
  minimapid = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = gunship[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", gunship.team, 1, 1, 1);
  }

  if(isDefined(minimapid)) {
    objective_setshowoncompass(minimapid, 1);
  }

  gunship.minimapid = minimapid;
  gunship_owner linkTo(level.gunship, "tag_origin");
  gunship linkTo(level.gunship, "tag_origin", var_78ac3c5ef5263d4f, (0, var_8945c22a67231e20 + 90, -30));
  gunship_owner.pers = [];
  gunship.streakinfo = gunship_owner createstreakinfo("gunship", gunship_owner);

  if(getdvarint(@ "hash_dc7962896e99ec", 0) != 0) {
    gunship thread scripts\cp\killstreaks\gunship_cp::enemygunship_watchdebuglocation(undefined, 1);
  }

  gunship thread enemygunship_watchdamage();
  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_watchgameend(undefined);

  if(level.script == "cp_arms_dealer") {
    gunship thread enemygunship_watchexfilsequencestart(undefined, 1);
  } else {
    gunship thread enemygunship_watchexfilsequencestart(undefined);
  }

  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_linklightfxent();
  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_linkwingfxents();
  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_trackvelocity();
  gunship thread scripts\cp\cp_flares::flares_monitor(gunship.flaresreservecount);
  gunship thread enemygunship_watchtargets();
  scripts\cp\weapon::add_to_special_lockon_target_list(gunship);

  if(scripts\engine\utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    gunship thread[[scripts\engine\utility::getsharedfunc("flares", "handleIncomingStinger")]](&enemygunship_handlemissiledetection);
  }

  gunship playLoopSound("iw8_ks_ac130_lp");
}

function play_fake_vo_for_gunship() {
  voalias = #"ping_killstreak_gunship_hostile";
  pingowner = self;
  var_4d0ce2d79bf45d54 = pingowner;
  alias2d = var_4d0ce2d79bf45d54 scripts\cp_mp\calloutmarkerping::calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(voalias);
  alias3d = var_4d0ce2d79bf45d54 scripts\cp_mp\calloutmarkerping::calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(voalias);
  var_c197335aad9f5e31 = soundexists(alias2d);
  var_c1934d5aad9ba188 = soundexists(alias3d);
  var_196ffc81c8206c2a = scripts\cp_mp\calloutmarkerping::calloutmarkerpingvo_getmaxsoundaliaslength(var_c197335aad9f5e31, alias2d, var_c1934d5aad9ba188, alias3d);
  canplayvo = 1;

  if(istrue(canplayvo)) {
    assert(issharedfuncdefined("game", "getFriendlyPlayers"));
    playersquad = [[getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

    foreach(teammate in playersquad) {
      if(var_4d0ce2d79bf45d54 == teammate) {
        if(var_c197335aad9f5e31) {
          var_4d0ce2d79bf45d54 playsoundtoplayer(alias2d, teammate);
        }

        continue;
      }

      if(var_c1934d5aad9ba188) {
        var_4d0ce2d79bf45d54 playsoundtoplayer(alias3d, teammate);
      }
    }
  }
}

function enemygunship_watchexfilsequencestart(gunner, var_fa9457caf94a8d20) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(istrue(var_fa9457caf94a8d20)) {
    while(true) {
      level waittill("exfil_sequence_started");

      if(istrue(level.bloadinghvt)) {
        continue;
      }

      break;
    }
  } else {
    level waittill("exfil_sequence_started");
  }

  thread scripts\cp_mp\killstreaks\gunship::gunship_leave(gunner);
}

function enemygunship_watchdamage(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 8192);
  self setCanDamage(1);

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(isDefined(level.teambased) && isPlayer(attacker) && attacker.team == self.team) {
      continue;
    }

    if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    if(isPlayer(attacker)) {
      if(issharedfuncdefined("damage", "updateDamageFeedback")) {
        attacker[[getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    thread run_suppression_logic(7);
    self.wasdamaged = 1;
    modifieddamage = undefined;

    if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, smeansofdeath, damage, self.maxhealth, 4, 5, 6);
    }

    self.damagetaken += modifieddamage;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread scripts\cp_mp\killstreaks\gunship::gunship_startengineblowoutfx();
    }

    if(self.damagetaken >= self.maxhealth) {
      streakname = self.streakinfo.streakname;
      damagetype = undefined;
      scorepopupname = "destroyed_" + streakname;
      leaderdialog = undefined;
      cardsplash = "callout_destroyed_" + streakname;
      skipdeathnotify = 1;

      if(isPlayer(attacker)) {
        if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
          thread[[getsharedfunc("hud", "teamPlayerCardSplash")]](cardsplash, attacker);
        }
      }

      if(scripts\engine\utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
        notifyattacker = self[[scripts\engine\utility::getsharedfunc("damage", "onKillstreakKilled")]](streakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify);
      }

      self.owner delete();
      level.disableannouncer = 1;
      thread scripts\cp_mp\killstreaks\gunship::gunship_crash(gunner);
    }
  }
}

function run_suppression_logic(delay) {
  self notify("run_suppression_logic");
  self endon("run_suppression_logic");
  self endon("death");
  level endon("game_ended");
  self.suppressedgunner = 1;

  iprintln("<dev string:x1c>");

  childthread removesuppressioneffectsaftertimeout(delay);
}

function removesuppressioneffectsaftertimeout(timeout) {
  self notify("removeSuppressionEffectsAfterTimeout");
  self endon("removeSuppressionEffectsAfterTimeout");
  self endon("death");
  level endon("game_ended");
  wait timeout;

  iprintln("<dev string:x32>");

  self.suppressedgunner = undefined;
}

function enemygunship_handlemissiledetection(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      if(scripts\engine\utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\engine\utility::getsharedfunc("flares", "reduceReserves")]](missiletarget);
      }

      missiletarget scripts\cp_mp\killstreaks\gunship::gunship_playflaresfx(fxtagoverride);

      if(isDefined(missiletarget.owner) && isPlayer(missiletarget.owner)) {
        missiletarget playkillstreakoperatordialog("gunship", "gunship_flares", 1);
      }

      newtarget = undefined;

      if(scripts\engine\utility::issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[scripts\engine\utility::getsharedfunc("flares", "deploy")]]();
      }

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    } else if(curdist < 300 && missiletarget.flaresreservecount <= 0) {
      missiletarget thread scripts\cp_mp\killstreaks\gunship::gunship_playfakebodyexplosion();
      missiledamage = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner) && isPlayer(self.owner)) {
        missiletarget dodamage(missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      } else {
        missiletarget dodamage(missiledamage, missiletarget.origin, undefined, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      self delete();
    }

    waitframe();
  }
}

function gunship_lockedoncallback() {
  playkillstreakoperatordialog("gunship", "gunship_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function enemygunship_watchtargets(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  while(true) {
    visibletargets = [];

    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(level.teambased && player.team == self.team) {
        continue;
      }

      if(istrue(player.respawn_in_progress)) {
        continue;
      }

      if(istrue(player.inlaststand)) {
        continue;
      }

      if(player isskydiving()) {
        continue;
      }

      if(isDefined(player.vehicle) && isent(player.vehicle)) {} else if(player scripts\cp\utility::is_indoors(player)) {
        continue;
      } else if(!sighttracepassed(self.origin, player.origin, 0, undefined, 1)) {
        continue;
      }

      if(scripts\engine\utility::issharedfuncdefined("perk", "hasPerk")) {
        if(player[[scripts\engine\utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye") || player[[scripts\engine\utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost")) {
          if(player.stealthtimeelapsed <= 3) {
            player.stealthtimeelapsed += 0.05;
            continue;
          } else {
            player.stealthtimeelapsed = 0;
          }
        }
      }

      visibletargets = enemygunship_getnearbytargets(player);
      break;
    }

    if(visibletargets.size > 0 && visibletargets.size < 2) {
      foreach(guy in visibletargets) {
        if(isPlayer(guy)) {
          guy thread scripts\cp\killstreaks\gunship_cp::play_fake_vo_for_gunship();
          thread scripts\cp\killstreaks\gunship_cp::enemygunship_firerounds(guy);
          guy thread playkillstreakoperatordialog("gunship", "gunship_single_spotted");
          self notify("gunship_shoot_debug_location");
        }
      }
    } else if(visibletargets.size >= 2) {
      foreach(guy in visibletargets) {
        if(isPlayer(guy)) {
          thread scripts\cp\killstreaks\gunship_cp::enemygunship_firerounds(guy);
          guy thread playkillstreakoperatordialog("gunship", "gunship_multi_spotted");
          self notify("gunship_shoot_debug_location");
        }
      }
    }

    wait randomintrange(3, 15);
  }
}

function enemygunship_getnearbytargets(maintarget) {
  var_69338ca0bf9d8d91 = utility::playersinsphere(maintarget.origin, 666);
  nearbytargets = [];

  foreach(player in var_69338ca0bf9d8d91) {
    if(level.teambased && player.team != maintarget.team) {
      continue;
    }

    nearbytargets[nearbytargets.size] = player;
  }

  return nearbytargets;
}

function enemygunship_watchplanedistance() {
  self endon("death");
  self.owner endon("gunship_switch_debug_weapon");
  self.owner endon("gunship_shoot_debug_location");

  while(true) {
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 40000), self);

    if(getdvarint(@ "hash_dc7962896e99ec", 0) != 0) {
      line(self.origin, trace["<dev string:x48>"], (1, 1, 1), 1, 0, 1);
      sphere(level.gunship.origin, 200, (1, 1, 1), 0, 1);
      iprintlnbold("<dev string:x51>" + distance(self.origin, trace["<dev string:x48>"]));
    }

    waitframe();
  }
}

function enemygunship_watchdebuglocation(tagname, showaxis) {
  self endon("<dev string:x5c>");

  while(true) {
    debuglocation = self.origin;

    if(isDefined(tagname)) {
      debuglocation = self gettagorigin(tagname);
    }

    sphere(debuglocation, 100, (1, 1, 1), 0, 1);

    if(istrue(showaxis)) {
      testforward = anglesToForward(self.angles);
      testright = anglestoright(self.angles);
      testup = anglestoup(self.angles);
      line(debuglocation, debuglocation + testforward * 1000, (1, 0, 0), 1, 0, 1);
      line(debuglocation, debuglocation + testright * 1000, (0, 1, 0), 1, 0, 1);
      line(debuglocation, debuglocation + testup * 1000, (0, 0, 1), 1, 0, 1);
    }

    wait 0.05;
  }
}

function enemygunship_firerounds(target) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self notify(target.name + "enemyGunship_fireRounds");
  self endon(target.name + "enemyGunship_fireRounds");

  if(!isDefined(self.currentgunshipweapon)) {
    self.weaponstocycle = ["gunship_105mm_mp", "gunship_40mm_mp", "gunship_25mm_mp"];
    self.currentdebugweaponindex = 0;
    self.currentdebugweapon = self.weaponstocycle[0];
    self.currentgunshipweapon = self.currentdebugweapon;
  }

  while(true) {
    result = waittill_any_return_2("gunship_switch_debug_weapon", "gunship_shoot_debug_location");

    if(!isDefined(result)) {
      waitframe();
      continue;
    }

    if(result == "gunship_switch_debug_weapon") {
      self.currentdebugweaponindex++;

      if(self.currentdebugweaponindex > 2) {
        self.currentdebugweaponindex = 0;
      }

      self.currentdebugweapon = self.weaponstocycle[self.currentdebugweaponindex];
      self.currentgunshipweapon = self.currentdebugweapon;

      if(getdvarint(@ "hash_dc7962896e99ec", 0) != 0) {
        iprintlnbold("<dev string:x62>" + self.currentdebugweapon);
      }

      continue;
    }

    if(istrue(self.suppressedgunner)) {
      waitframe();
      continue;
    }

    shotgoal = enemygunship_getshotgoal(target);
    thread enemygunship_attackgoal(shotgoal, self.currentdebugweapon);
  }
}

function enemygunship_getfiretime(weapon) {
  return weaponfiretime(weapon);
}

function enemygunship_getshotgoal(target) {
  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(content);
  starttrace = self.origin;
  vdir = vectorNormalize(target.origin - self.origin);
  endtrace = starttrace + vdir * 50000;
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, self, contentoverride);
  endpos = trace["position"];
  return endpos;
}

function enemygunship_attackgoal(shotgoal, currentdebugweapon) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("gunship_shoot_debug_location");
  self endon("gunship_switch_debug_weapon");

  while(true) {
    if(getdvarint(@ "hash_dc7962896e99ec", 0) != 0) {
      sphere(shotgoal, 10, (1, 1, 0), 0, 60);
      iprintlnbold("<dev string:x7d>" + currentdebugweapon + "<dev string:x85>" + shotgoal + "<dev string:x8a>" + getweaponexplosionradius(currentdebugweapon));
    }

    ammoleft = weaponmaxammo(currentdebugweapon);

    while(ammoleft > 0) {
      if(istrue(self.suppressedgunner)) {
        waitframe();
        continue;
      }

      var_e84b952249e4abe = undefined;
      var_bf366eb7073782af = scripts\cp_mp\killstreaks\toma_strike::tomastrike_getrandombombingpoint(shotgoal, 333);
      var_e84b952249e4abe = var_bf366eb7073782af.point;
      owner = undefined;
      projectile = _magicbullet(makeweapon(currentdebugweapon), self.origin, var_e84b952249e4abe, owner);
      projectile.weapon_name = currentdebugweapon;
      projectile.team = self.team;
      ammoleft--;

      if(ammoleft == 0) {
        wait 1;
        self notify("gunship_switch_debug_weapon");
        reloadtimer = level.weaponreloadtime[currentdebugweapon] + getdvarint(@ "hash_c38108a3a770d64c", 0);

        while(reloadtimer > 0) {
          if(getdvarint(@ "hash_dc7962896e99ec", 0) != 0) {
            iprintlnbold("<dev string:x9c>" + currentdebugweapon);
          }

          reloadtimer--;
          wait 1;
        }
      }

      wait enemygunship_getfiretime(currentdebugweapon);
    }
  }
}

function enemygunship_watchweaponimpact(projectile) {}

function enemygunship_updatedebugflashlight(shotgoal) {
  self endon("<dev string:x5c>");
  self endon("<dev string:xa7>");
  self endon("<dev string:xaf>");
  self.owner endon("<dev string:xb8>");
  self.owner endon("<dev string:xd4>");

  while(true) {
    self.flashlight.angles = vectortoangles(shotgoal - self.origin);
    line(self.origin, shotgoal, (1, 1, 1), 1, 0, 1);
    waitframe();
  }
}

# /