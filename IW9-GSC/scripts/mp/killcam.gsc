/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killcam.gsc
***********************************************/

init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    id = tablelookupbyrow("mp/miscKillcamItems.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(id) || id == "") {
      break;
    }

    id = int(id);
    weapon = tablelookupbyrow("mp/miscKillcamItems.csv", _id_CB89110314447B2F, 1);

    if(!isDefined(weapon) || weapon == "") {
      break;
    }

    level.killcammiscitems[weapon] = id;
    _id_CB89110314447B2F++;
  }
}

setcinematiccamerastyle(camerastyle, _id_226F86D3A2D6DA77, _id_B41E4C5EB0094058) {
  self setclientomnvar("cam_scene_name", camerastyle);
  self setclientomnvar("cam_scene_lead", _id_226F86D3A2D6DA77);
  self setclientomnvar("cam_scene_support", _id_B41E4C5EB0094058);
}

getkillcamentity(attacker, einflictor, objweapon, meansofdeath) {
  if(!isDefined(attacker) || !isDefined(einflictor) || attacker == einflictor && !isagent(attacker))
    return undefined;

  if(usesattackeraskillcamentity(attacker, einflictor, objweapon, meansofdeath))
    return undefined;

  if(usesvehiclekillcamentityrelay(attacker, einflictor, objweapon, meansofdeath))
    return einflictor.killcament;

  switch (objweapon.basename) {
    case "lighttank_mp":
    case "iw9_racecar_mp":
    case "trip_mine_mp":
    case "bouncing_betty_mp":
    case "bomb_site_mp":
    case "chopper_support_turret_mp":
    case "hover_jet_bomb_mp":
    case "airdrop_escort_turret_mp":
    case "hover_jet_turret_ballistics_mp":
    case "airdrop_escort_turret_ballistics_mp":
    case "pac_sentry_turret_mp":
    case "player_trophy_system_mp":
    case "trophy_mp":
    case "hover_jet_turret_mp":
      return scripts\engine\utility::ter_op(isDefined(einflictor.killcament), einflictor.killcament, einflictor);
    case "toma_proj_mp":
    case "fuelstrike_proj_mp":
    case "artillery_mp":
    case "nuke_mp":
    case "auto_drone_proj_mp":
    case "none":
      if(isnoneweaponinflictor(einflictor) || isenvironmentalinflictor(einflictor))
        return einflictor.killcament;

      break;
  }

  if(scripts\common\utility::isdestructibleweapon(objweapon.basename) || scripts\mp\utility\weapon::isbombsiteweapon(objweapon.basename)) {
    if(isDefined(einflictor.killcament) && !attacker scripts\mp\utility\killstreak::attackerinremotekillstreak())
      return einflictor.killcament;
    else
      return undefined;
  }

  return einflictor;
}

usesattackeraskillcamentity(attacker, inflictor, objweapon, meansofdeath) {
  switch (objweapon.basename) {
    case "semtex_xmike109_splash_mp":
    case "iw9_mg_light_tank_mp":
    case "thermite_xmike109_radius_mp":
    case "iw9_mg_jltv_mp":
    case "iw9_tur_apc_russian_mp":
    case "iw9_tur_light_tank_mp":
    case "cruise_proj_mp":
    case "chopper_gunner_turret_mp":
    case "gunship_25mm_mp":
    case "gunship_hellfire_mp":
    case "gunship_40mm_mp":
    case "chopper_gunner_turret_ballistics_mp":
    case "chopper_gunner_proj_mp":
    case "iw9_mg_mrap_mp":
    case "iw9_tur_cougar_mp":
    case "iw9_mg_patrol_boat_back_mp":
    case "iw9_mg_cougar_mp":
    case "iw9_mg_patrol_boat_front_mp":
    case "iw9_tur_mrap_mp":
    case "thermite_bolt_mp":
    case "thermite_bolt_radius_mp":
    case "semtex_bolt_splash_mp":
    case "semtex_bolt_mp":
    case "gunship_105mm_mp":
    case "semtex_xmike109_mp":
    case "thermite_xmike109_mp":
    case "assault_drone_mp":
      return 1;
  }

  return 0;
}

usesvehiclekillcamentityrelay(attacker, inflictor, objweapon, meansofdeath) {
  if(!isDefined(inflictor))
    return 0;

  if(!inflictor scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  switch (meansofdeath) {
    case "MOD_PROJECTILE":
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_PROJECTILE_SPLASH":
      return 1;
    default:
      return 0;
  }
}

setkillcamerastyle(einflictor, inflictoragentinfo, attackernum, _id_E851FFA44B7E0D54, killcamentityindex, _id_AA26C3B6336CFA30, objweapon) {
  _id_AA26C3B6336CFA30.camerastyle = "unknown";

  if(isDefined(inflictoragentinfo) && isDefined(inflictoragentinfo.agent_type)) {
    setcinematiccamerastyle("killcam_agent", einflictor getentitynumber(), _id_E851FFA44B7E0D54 getentitynumber());
    _id_AA26C3B6336CFA30.camerastyle = "killcam_agent";
    return 1;
  } else if(isDefined(einflictor) && istrue(einflictor._id_26FB072855FD4772)) {
    if(getdvarint("dvar_1A5E4AF153D0E5BB", 1) == 0) {
      setcinematiccamerastyle("killcam_racecar", einflictor._id_7F256D9F9CD2E337 getentitynumber(), _id_E851FFA44B7E0D54 getentitynumber());
      _id_AA26C3B6336CFA30.camerastyle = "killcam_racecar";
      return 1;
    }
  } else if(isDefined(objweapon) && isDefined(objweapon.basename)) {
    if(objweapon.basename == "manual_turret_mp")
      return 1;
  } else if(killcamentityindex > 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  } else {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  }

  return 0;
}

trimkillcamtime(inflictoragentinfo, attacker, camtime, postdelay, _id_6F81975C2B48BE15, maxtime) {
  killcamlength = camtime + postdelay;

  if(isDefined(maxtime) && killcamlength > maxtime) {
    if(maxtime < 2) {
      return;
    }
    if(maxtime - camtime >= 1)
      postdelay = maxtime - camtime;
    else {
      postdelay = 1;
      camtime = maxtime - 1;
    }

    killcamlength = camtime + postdelay;
  }

  killcamoffset = camtime + _id_6F81975C2B48BE15;
  currenttime = gettime();
  _id_9E91BD73BB9BC9EC = currenttime;

  if(isDefined(inflictoragentinfo) && isDefined(inflictoragentinfo.lastspawntime))
    _id_9E91BD73BB9BC9EC = inflictoragentinfo.lastspawntime;
  else {
    if(isDefined(attacker.lastspawntime))
      _id_9E91BD73BB9BC9EC = attacker.lastspawntime;

    if(isDefined(attacker.deathtime)) {
      if(currenttime - attacker.deathtime < postdelay * 1000.0) {
        postdelay = 1.0;
        postdelay = postdelay - level.framedurationseconds;
        killcamlength = camtime + postdelay;
      }
    }
  }

  _id_E4D57B464C6A7053 = (currenttime - _id_9E91BD73BB9BC9EC) / 1000.0;

  if(killcamoffset > _id_E4D57B464C6A7053 && _id_E4D57B464C6A7053 > _id_6F81975C2B48BE15) {
    _id_38B7C5810BAFDB39 = _id_E4D57B464C6A7053 - _id_6F81975C2B48BE15;

    if(camtime > _id_38B7C5810BAFDB39) {
      camtime = _id_38B7C5810BAFDB39;
      killcamlength = camtime + postdelay;
      killcamoffset = camtime + _id_6F81975C2B48BE15;
    }
  }

  result = spawnStruct();
  result.camtime = camtime;
  result.postdelay = postdelay;
  result.killcamlength = killcamlength;
  result.killcamoffset = killcamoffset;
  return result;
}

prekillcamnotify(attacker) {
  if(isDefined(attacker) && !isagent(attacker)) {
    _id_AD0224B36CCB588C = [];

    if(isDefined(self.class) && isDefined(self.classstruct)) {
      _id_1583B947947AD005 = scripts\mp\playerlogic::getplayerassets(self.classstruct);
      _id_AD0224B36CCB588C[_id_AD0224B36CCB588C.size] = _id_1583B947947AD005;
    }

    if(isDefined(attacker.class) && isDefined(attacker.classstruct)) {
      _id_AF890D92BAFD84CF = attacker scripts\mp\playerlogic::getplayerassets(attacker.classstruct);
      _id_AD0224B36CCB588C[_id_AD0224B36CCB588C.size] = _id_AF890D92BAFD84CF;
    }

    if(_id_AD0224B36CCB588C.size > 0)
      scripts\mp\playerlogic::loadplayerassets(_id_AD0224B36CCB588C, 1);

    if(isDefined(attacker._id_ACB55A437C3145C0) && isDefined(attacker._id_ACB55A437C3145C0.code_classname) && attacker._id_ACB55A437C3145C0.code_classname == "trigger_hurt") {
      if(isDefined(attacker.team))
        team = attacker.team;
      else
        team = "neutral";

      attacker makeentitysentient(team);
      self _meth_BC667001F9DD3808(attacker getEye());
    } else {
      self _meth_BC667001F9DD3808(attacker getEye());

      if(isPlayer(attacker))
        self loadcustomizationplayerview(attacker);
    }
  }
}

makekillcamdata(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, offsettime, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo) {
  _id_B5A1F56C62BDB31D = spawnStruct();
  _id_B5A1F56C62BDB31D.einflictor = einflictor;
  _id_B5A1F56C62BDB31D.inflictoragentinfo = inflictoragentinfo;
  _id_B5A1F56C62BDB31D.attackernum = attackernum;
  _id_B5A1F56C62BDB31D.killcamentityindex = killcamentityindex;
  _id_B5A1F56C62BDB31D.killcamentitystarttime = killcamentitystarttime;
  _id_B5A1F56C62BDB31D.killcamlookatentityindex = killcamlookatentityindex;
  _id_B5A1F56C62BDB31D.killcamentstickstolookatent = killcamentstickstolookatent;
  _id_B5A1F56C62BDB31D.objweapon = objweapon;
  _id_B5A1F56C62BDB31D.offsettime = offsettime;
  _id_B5A1F56C62BDB31D.maxtime = maxtime;
  _id_B5A1F56C62BDB31D.attacker = attacker;
  _id_B5A1F56C62BDB31D.victim = victim;
  _id_B5A1F56C62BDB31D.smeansofdeath = smeansofdeath;
  _id_B5A1F56C62BDB31D.attackerloadoutperks = attackerloadoutperks;
  _id_B5A1F56C62BDB31D.skippable = skippable;
  _id_B5A1F56C62BDB31D.doslowmo = doslowmo;
  _id_B5A1F56C62BDB31D._id_6035B072327656EB = int(attacker.health / attacker.maxhealth * 127);

  if(isDefined(attacker))
    _id_B5A1F56C62BDB31D._id_14A780F439CFFF1D = attacker.origin;
  else if(isDefined(victim))
    _id_B5A1F56C62BDB31D._id_14A780F439CFFF1D = victim.origin;

  if(smeansofdeath == "MOD_EXECUTION")
    _id_B5A1F56C62BDB31D.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(attacker);

  return _id_B5A1F56C62BDB31D;
}

dokillcamfromstruct(_id_B5A1F56C62BDB31D, _id_6F81975C2B48BE15, _id_53C65E436A20E8E4, _id_DBEFC13F81D8D26A) {
  killcam(_id_B5A1F56C62BDB31D.einflictor, _id_B5A1F56C62BDB31D.inflictoragentinfo, _id_B5A1F56C62BDB31D.attackernum, _id_B5A1F56C62BDB31D.killcamentityindex, _id_B5A1F56C62BDB31D.killcamentitystarttime, _id_B5A1F56C62BDB31D.killcamlookatentityindex, _id_B5A1F56C62BDB31D.killcamentstickstolookatent, _id_B5A1F56C62BDB31D.objweapon, _id_6F81975C2B48BE15, _id_B5A1F56C62BDB31D.offsettime, _id_53C65E436A20E8E4, _id_B5A1F56C62BDB31D.maxtime, _id_B5A1F56C62BDB31D.attacker, _id_B5A1F56C62BDB31D.victim, _id_B5A1F56C62BDB31D.smeansofdeath, _id_B5A1F56C62BDB31D.attackerloadoutperks, _id_B5A1F56C62BDB31D.skippable, _id_B5A1F56C62BDB31D.doslowmo, _id_DBEFC13F81D8D26A);
}

calckillcamtimes(einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, _id_6F81975C2B48BE15, objweapon, _id_53C65E436A20E8E4, _id_5C539133A8240074, smeansofdeath) {
  if(getDvar("scr_killcam_time") == "") {
    _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(objweapon);

    if(level.showingfinalkillcam) {
      if(smeansofdeath == "MOD_EXECUTION")
        camtime = 4.0;
      else if(scripts\mp\utility\game::getgametype() == "arena") {
        if(isDefined(attacker.recentkillcount) && attacker.recentkillcount > 1)
          camtime = 4.0 + level.maxkillcamdelay - _id_5C539133A8240074;
        else
          camtime = 1.5 + level.maxkillcamdelay - _id_5C539133A8240074;
      } else
        camtime = 4.0 + level.maxkillcamdelay - _id_5C539133A8240074;
    } else if(objweapon.basename == "artillery_mp")
      camtime = 2.25;
    else if(objweapon.basename == "hover_jet_proj_mp")
      camtime = 3.0;
    else if(_id_EE36210863CA9F2C(objweapon))
      camtime = 1.5;
    else if(objweapon.basename == "toma_proj_mp")
      camtime = 2.5;
    else if(objweapon.basename == "cruise_proj_mp")
      camtime = 3.0;
    else if(objweapon.basename == "javelin_mp")
      camtime = 8;
    else if(issubstr(objweapon.basename, "remotemissile_"))
      camtime = 5;
    else if(isDefined(einflictor.sentrytype) && einflictor.sentrytype == "multiturret")
      camtime = 2.0;
    else if(!_id_53C65E436A20E8E4 || _id_53C65E436A20E8E4 > 5.0)
      camtime = 5.0;
    else if(_id_49E6EF3EDADD524E == "frag_grenade" || objweapon.basename == "frag_grenade_short_mp" || objweapon.basename == "semtex_mp" || objweapon.basename == "semtexproj_mp" || objweapon.basename == "mortar_shell__mp" || objweapon.basename == "cluster_grenade_mp")
      camtime = 4.25;
    else
      camtime = 2.5;
  } else
    camtime = getdvarfloat("scr_killcam_time");

  if(isDefined(maxtime)) {
    if(camtime > maxtime)
      camtime = maxtime;

    if(camtime < level.framedurationseconds)
      camtime = level.framedurationseconds;
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    postdelay = 1;

    if(smeansofdeath == "MOD_EXECUTION")
      postdelay = 3.0;
  } else if(getDvar("scr_killcam_posttime") == "")
    postdelay = 2;
  else {
    postdelay = getdvarfloat("scr_killcam_posttime");

    if(postdelay < level.framedurationseconds)
      postdelay = level.framedurationseconds;
  }

  if(attackernum < 0 || !isDefined(attacker))
    return undefined;

  if(isagent(attacker) || isagent(einflictor))
    attackernum = victim getentitynumber();

  _id_9E78F0AC35B8615A = trimkillcamtime(inflictoragentinfo, attacker, camtime, postdelay, _id_6F81975C2B48BE15, maxtime);

  if(!isDefined(_id_9E78F0AC35B8615A))
    return undefined;

  return _id_9E78F0AC35B8615A;
}

setkilledbyuiomnvar(_id_34521C3F3A06B3B4) {
  self setclientomnvar("ui_killcam_killedby_id", _id_34521C3F3A06B3B4 getentitynumber());
}

setkillcamuitimer(_id_235A1E847DA06145) {
  self setclientomnvar("ui_killcam_end_milliseconds", int(_id_235A1E847DA06145 * 1000) + gettime());
}

setupkillcamui(attacker, victim, objweapon, _id_9E78F0AC35B8615A, _id_53C65E436A20E8E4, attackerloadoutperks) {
  if(isPlayer(attacker)) {
    setkilledbyuiomnvar(attacker);
    self setclientomnvar("ui_killcam_victim_id", victim getentitynumber());
    self loadcustomizationplayerview(attacker);
  }

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !_id_2669878CF5A1B6BC::_id_1A9394EB58E66A9B(objweapon.basename))
    setkillcamkillstreaktypeomnvars(objweapon);
  else if(istrue(level.allowperks) && isDefined(attackerloadoutperks))
    scripts\mp\perks\perks::setomnvarsforperklist("ui_killcam_killedby_perk", attackerloadoutperks);

  _id_E00332A98BB01254 = getdvarint("scr_player_forcerespawn");

  if(_id_53C65E436A20E8E4 && !level.gameended || isDefined(self) && !level.gameended || _id_E00332A98BB01254 == 0 && !level.gameended)
    self setclientomnvar("ui_killcam_text", "skip");
  else if(!level.gameended)
    self setclientomnvar("ui_killcam_text", "respawn");
  else
    self setclientomnvar("ui_killcam_text", "none");

  setkillcamuitimer(_id_9E78F0AC35B8615A.killcamlength);
}

beginarchiveplayback(_id_79FE9D21E7286C23, _id_3F4E575C117A6FFB, _id_59CFB81470C4C810, psoffsettime) {
  scripts\mp\utility\player::updatesessionstate("spectator");
  self.spectatekillcam = 1;
  self.forcespectatorclient = _id_79FE9D21E7286C23;
  self.killcamentity = -1;
  self.archivetime = _id_3F4E575C117A6FFB;
  self.killcamlength = _id_59CFB81470C4C810;
  self.psoffsettime = psoffsettime;
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  self allowspectateteam(_id_FABF84450735DD93, 1);
}

checkkillcamtruncation(killcamoffset) {
  if(!isDefined(killcamoffset)) {
    return;
  }
  if(self.archivetime + 0.015 < killcamoffset) {
    _id_5B71064E47C6B27B = killcamoffset - self.archivetime;

    if(game["truncated_killcams"] < 32)
      game["truncated_killcams"]++;
  }
}

queueforkillcam() {
  level.numplayerswaitingtoenterkillcam++;
  _id_C40A8900810543A2 = 1;

  if(istrue(level.showingfinalkillcam) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_C40A8900810543A2 = 5;

  _id_5C539133A8240074 = level.framedurationseconds * int(floor((level.numplayerswaitingtoenterkillcam - 1) / _id_C40A8900810543A2));
  level.maxkillcamdelay = _id_5C539133A8240074;

  if(_id_5C539133A8240074 > 0)
    wait(_id_5C539133A8240074);

  waitframe();
  level.numplayerswaitingtoenterkillcam--;
  return _id_5C539133A8240074;
}

killcam(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, _id_6F81975C2B48BE15, offsettime, _id_53C65E436A20E8E4, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo, _id_DBEFC13F81D8D26A) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  scripts\mp\utility\player::printspawnmessage("killcam::killcam() START");
  resetplayeromnvarsonkillcam();

  if(attackernum < 0 || !isDefined(attacker)) {
    self notify("killcam_canceled");

    if(istrue(_id_DBEFC13F81D8D26A))
      self setclientomnvar("post_game_state", 1);

    return;
  }

  _id_5C539133A8240074 = queueforkillcam();
  _id_9E78F0AC35B8615A = calckillcamtimes(einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, _id_6F81975C2B48BE15, objweapon, _id_53C65E436A20E8E4, _id_5C539133A8240074, smeansofdeath);

  if(!isDefined(_id_9E78F0AC35B8615A) || !isDefined(_id_9E78F0AC35B8615A.killcamoffset) || !isDefined(victim) || istrue(level._id_904AA57B8B22090C)) {
    self notify("killcam_canceled");

    if(istrue(_id_DBEFC13F81D8D26A))
      self setclientomnvar("post_game_state", 1);

    return;
  }

  setupkillcamui(attacker, victim, objweapon, _id_9E78F0AC35B8615A, _id_53C65E436A20E8E4, attackerloadoutperks);

  if(isPlayer(attacker))
    self loadcustomizationplayerview(attacker);

  if(isDefined(level._id_D39AA4B67CEFA0D6) && isDefined(einflictor._id_0FDA11F45E9C5542))
    self playlocalsound(level._id_D39AA4B67CEFA0D6);

  self setsoundsubmix("iw9_mp_core_killcam_mix");
  beginarchiveplayback(attackernum, _id_9E78F0AC35B8615A.killcamoffset, _id_9E78F0AC35B8615A.killcamlength, offsettime);
  _id_EED67ECB94E5635B = setkillcamerastyle(einflictor, inflictoragentinfo, attackernum, victim, killcamentityindex, _id_9E78F0AC35B8615A, objweapon);

  if(!_id_EED67ECB94E5635B)
    thread setkillcamentity(killcamentityindex, _id_9E78F0AC35B8615A.killcamoffset, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent);

  thread endedkillcamcleanup(_id_DBEFC13F81D8D26A);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  checkkillcamtruncation(_id_9E78F0AC35B8615A.killcamoffset);
  _id_9E78F0AC35B8615A.camtime = self.archivetime - level.framedurationseconds - _id_6F81975C2B48BE15;
  _id_9E78F0AC35B8615A.killcamlength = _id_9E78F0AC35B8615A.camtime + _id_9E78F0AC35B8615A.postdelay;
  self.killcamlength = _id_9E78F0AC35B8615A.killcamlength;

  if(_id_9E78F0AC35B8615A.camtime <= 0) {
    killcamcleanup(1, undefined, _id_DBEFC13F81D8D26A);
    return;
  }

  self.killcam = 1;
  self._id_7C813E50FF75BE27 = 1;
  thread spawnedkillcamcleanup(_id_DBEFC13F81D8D26A);

  if(istrue(doslowmo))
    thread dokillcamslowmo(_id_9E78F0AC35B8615A.camtime);

  if(!isDefined(skippable) || skippable) {
    thread waitskipkillcambutton(_id_53C65E436A20E8E4);
    thread _id_7E144CFDD1C3385E();
  }

  if(istrue(_id_DBEFC13F81D8D26A))
    thread scripts\mp\final_killcam::finalkillcamplaybackbegin();

  thread endkillcamifnothingtoshow();

  if(!isbot(self))
    thread resetstreamerposhint();

  self.killcamwatchtime = gettime();
  waittillkillcamover();
  self.killcamwatchtime = (gettime() - self.killcamwatchtime) / 1000;
  scripts\mp\utility\stats::incpersstat("timeWatchingKillcams", self.killcamwatchtime);
  killcamcleanup(1, undefined, _id_DBEFC13F81D8D26A);
  scripts\mp\utility\player::printspawnmessage("killcam::killcam() COMPLETE");
}

resetstreamerposhint() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_timeout_2(0.15, "killcam_canceled", "spawned");
  self clearpredictedstreampos();

  if(istrue(level.showingfinalkillcam))
    scripts\mp\gamelogic::predictandclearintermissionstreaming();
}

setuppotgui(_id_E835A6B69CA8276F, _id_396646EDB4BA78FE) {
  setkilledbyuiomnvar(_id_E835A6B69CA8276F);
  setkillcamuitimer(_id_396646EDB4BA78FE);
}

potg_killcam(spectateentity, psoffsettime, _id_7BF1255A3715A632, _id_754110404C0D574F) {
  self endon("disconnect");
  prekillcamnotify(spectateentity);
  resetplayeromnvarsonkillcam();
  _id_79FE9D21E7286C23 = spectateentity getentitynumber();
  queueforkillcam();

  if(isPlayer(spectateentity))
    self loadcustomizationplayerview(spectateentity);

  _id_2D2FCE6A8562BFA4 = gettime();
  _id_897B58815B52404C = (_id_2D2FCE6A8562BFA4 - _id_7BF1255A3715A632) / 1000.0;
  _id_A7611280671612F1 = (_id_2D2FCE6A8562BFA4 - _id_754110404C0D574F) / 1000.0;
  _id_396646EDB4BA78FE = (_id_754110404C0D574F - _id_7BF1255A3715A632) / 1000.0;
  setuppotgui(spectateentity, _id_396646EDB4BA78FE);
  self.archiveusepotg = 1;
  beginarchiveplayback(_id_79FE9D21E7286C23, _id_897B58815B52404C, _id_396646EDB4BA78FE, psoffsettime);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  checkkillcamtruncation(_id_897B58815B52404C);
  self.killcamlength = self.archivetime - _id_A7611280671612F1;
  self.killcam = 1;
  self notify("begin_killcam");
  waittillkillcamover();
  potgkillcamcleanup();
}

potgkillcamcleanup() {
  self.killcam = undefined;
  scripts\mp\spectating::setspectatepermissions();
  scripts\mp\utility\player::updatesessionstate("dead");
  scripts\mp\utility\player::clearkillcamstate();
  self notify("killcam_ended");
}

dokillcamslowmo(camtime) {
  self endon("killcam_ended");

  if(isDefined(level.doingkillcamslowmo)) {
    return;
  }
  level.doingkillcamslowmo = 1;
  _id_3E8187406C7718B5 = 0;
  _id_C65CA876A670ED43 = camtime;

  if(_id_C65CA876A670ED43 > 1.0) {
    _id_C65CA876A670ED43 = 1.0;
    _id_3E8187406C7718B5 = _id_3E8187406C7718B5 + 1.0;
    wait(camtime - _id_3E8187406C7718B5);
  }

  if(!isDefined(level.killcam_timescalefactor)) {
    soundsettimescalefactorfromtable("killcam");
    level.killcam_timescalefactor = 1;
  }

  setslowmotion(1.0, 0.25, _id_C65CA876A670ED43);
  wait(_id_C65CA876A670ED43 + 0.5);
  setslowmotion(0.25, 1, 1);
  level.doingkillcamslowmo = undefined;
}

setkillcamnormalweaponomnvars(objweapon, smeansofdeath, einflictor, executionref, attacker) {
  if(smeansofdeath == "MOD_EXECUTION")
    setkillcamexecutiontypeomnvars(executionref);
  else if(!isDefined(objweapon) || objweapon.basename == "none")
    clearkillcamattachmentomnvars();
  else {
    if(isDefined(einflictor) && isDefined(einflictor.glgrenadeparent)) {
      _id_11D2F075E9A0E643 = undefined;
      objweapon = einflictor.glgrenadeparent;
      einflictor = undefined;
    } else
      _id_11D2F075E9A0E643 = scripts\mp\utility\weapon::getequipmenttype(objweapon);

    if(isDefined(scripts\mp\supers::getsuperrefforsuperweapon(objweapon)))
      setkillcamsupertypeomnvars(objweapon);
    else {
      if(isDefined(_id_11D2F075E9A0E643) && (_id_11D2F075E9A0E643 == "lethal" || _id_11D2F075E9A0E643 == "tactical")) {
        setkillcamequipmenttypeomnvars(objweapon);
        return;
      }

      if(isDefined(level.killcammiscitems[objweapon.basename])) {
        setkillcammisctypeomnvars(level.killcammiscitems[objweapon.basename]);
        return;
      }

      setkillcamweapontypeomnvars(objweapon, einflictor, attacker);
    }
  }
}

waittillkillcamover() {
  self endon("abort_killcam");
  scripts\mp\utility\player::printspawnmessage("killcam::waittillKillcamOver() START");
  wait(self.killcamlength - level.frameduration / 1000.0);
  scripts\mp\utility\player::printspawnmessage("killcam::waittillKillcamOver() COMPLETE");
}

_id_7A8A04D15AD052D5() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");

  if(level.killcam) {
    while(!isDefined(self._id_7C813E50FF75BE27))
      waitframe();

    if(level.killcam && istrue(self.killcam))
      scripts\engine\utility::waittill_any_3("killcam_ended", "killcam_canceled", "abort_killcam");
  }
}

setkillcamentity(killcamentityindex, killcamoffset, starttime, killcamlookatentityindex, killcamentstickstolookatent) {
  self endon("disconnect");
  self endon("killcam_ended");
  _id_16A890759EC9C34D = gettime() - killcamoffset * 1000;

  if(starttime > _id_16A890759EC9C34D) {
    waitframe();
    killcamoffset = self.archivetime;
    _id_16A890759EC9C34D = gettime() - killcamoffset * 1000;

    if(starttime > _id_16A890759EC9C34D)
      wait((starttime - _id_16A890759EC9C34D) / 1000);
  }

  self.killcamentity = killcamentityindex;

  if(isDefined(killcamlookatentityindex))
    self.killcamentitylookat = killcamlookatentityindex;

  if(isDefined(killcamentstickstolookatent))
    self setkillcamentstickstolookatent(killcamentstickstolookatent);
}

waitskipkillcambutton(_id_53C65E436A20E8E4) {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");
    self waittill("kc_respawn");

    if(isDefined(level._id_D39AA4B67CEFA0D6))
      thread _id_E35F3DDA3B0EA636();

    scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
    scripts\mp\utility\player::printspawnmessage("killcam::waitSkipKillcamButton() Killcam SKIPPED");
    self notify("abort_killcam");
  }
}

_id_E35F3DDA3B0EA636() {
  wait 0.1;
  self stoplocalsound(level._id_D39AA4B67CEFA0D6);
}

_id_7E144CFDD1C3385E() {
  self endon("disconnect");
  self endon("killcam_ended");
  self endon("abort_killcam");

  if(self _meth_C6CB3E654225077A()) {
    while(!self jumpbuttonPressed())
      waitframe();
  } else {
    while(self usinggamepad() || !self jumpbuttonPressed())
      waitframe();
  }

  scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
  scripts\mp\utility\player::printspawnmessage("killcam::waitSkipKillcamKBMOrTouch() Killcam SKIPPED");
  self notify("abort_killcam");
}

endkillcamifnothingtoshow() {
  self endon("disconnect");
  self endon("killcam_ended");

  for(;;) {
    if(self.archivetime <= 0) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\player::printspawnmessage("killcam::endKillcamIfNothingToShow() Killcam SKIPPED");
  self notify("abort_killcam");
}

spawnedkillcamcleanup(_id_DBEFC13F81D8D26A) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  killcamcleanup(0, undefined, _id_DBEFC13F81D8D26A);
}

endedkillcamcleanup(_id_DBEFC13F81D8D26A) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  killcamcleanup(1, 1, _id_DBEFC13F81D8D26A);
}

clearkillcamomnvars() {
  clearkillcamkilledbyitemomnvars();
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_id", -1);
  self setclientomnvar("ui_killcam_victim_id", -1);
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  clearkillcamattachmentomnvars();

  for(_id_2B8554E15B5C8E77 = 0; _id_2B8554E15B5C8E77 < 6; _id_2B8554E15B5C8E77++)
    self setclientomnvar("ui_killcam_killedby_perk" + _id_2B8554E15B5C8E77, "none");
}

killcamcleanup(_id_4355BC97735AEC7C, gameended, _id_DBEFC13F81D8D26A) {
  clearkillcamomnvars();
  self.killcam = undefined;
  setcinematiccamerastyle("unknown", -1, -1);
  scripts\mp\spectating::setspectatepermissions(gameended);
  scripts\mp\utility\player::clearkillcamstate();

  if(istrue(_id_4355BC97735AEC7C) && !istrue(gameended))
    scripts\mp\utility\player::updatesessionstate("dead");

  self notify("killcam_ended");
  self clearsoundsubmix("iw9_mp_core_killcam_mix");
  self clearsoundsubmix("iw9_mp_killcam");

  if(istrue(_id_DBEFC13F81D8D26A))
    self setclientomnvar("post_game_state", 1);
}

clearlootweaponomnvars() {
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
}

clearkillcamkilledbyitemomnvars() {
  self setclientomnvar("ui_killcam_killedby_item_type", -1);
  self setclientomnvar("ui_killcam_killedby_item_id", -1);
}

setkillcamkilledbyitemomnvars(type, _id_DB35956D84816F27) {
  self setclientomnvar("ui_killcam_killedby_item_type", type);
  self setclientomnvar("ui_killcam_killedby_item_id", _id_DB35956D84816F27);
}

setkillcamweapontypeomnvars(objweapon, einflictor, attacker) {
  objweapon = attacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
  objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, einflictor);
  _id_CD13663AEE778DB6 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon.basename);
  _id_DC45D6F50C9A112B = _id_2669878CF5A1B6BC::_id_A221D76594EF4E8B();
  _id_23BAFF4CD29861A2 = -1;

  if(isDefined(_id_DC45D6F50C9A112B) && scripts\engine\utility::array_contains(_id_DC45D6F50C9A112B, _id_CD13663AEE778DB6))
    _id_23BAFF4CD29861A2 = scripts\engine\utility::array_find(_id_DC45D6F50C9A112B, _id_CD13663AEE778DB6) + 1;

  self setclientomnvar("ui_weapon_pickup", 0);

  if(!isDefined(_id_23BAFF4CD29861A2) || _id_23BAFF4CD29861A2 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  _id_60CE74182E7C83A7 = scripts\mp\loot::getlootinfoforweapon(objweapon.basename, objweapon.variantid);

  if(isDefined(_id_60CE74182E7C83A7))
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", _id_60CE74182E7C83A7.variantid);
  else
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);

  setkillcamkilledbyitemomnvars(0, _id_23BAFF4CD29861A2);

  if(_id_CD13663AEE778DB6 != "iw8_knife") {
    attachments = getweaponattachments(objweapon);

    if(!isDefined(attachments))
      attachments = [];

    _id_26E8678BD2761FF9 = 0;

    for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < attachments.size; _id_40E4B9C48B36C9EC++) {
      _id_B72FB037A64A6025 = attachments[_id_40E4B9C48B36C9EC];

      if(scripts\mp\utility\weapon::attachmentisselectable(_id_CD13663AEE778DB6, _id_B72FB037A64A6025)) {
        if(_id_26E8678BD2761FF9 >= 8) {
          break;
        }

        if(isDefined(level.weaponattachments) && isDefined(level.weaponattachments[_id_B72FB037A64A6025])) {
          _id_4F13B964AB82FE13 = level.weaponattachments[_id_B72FB037A64A6025];
          self setclientomnvar("ui_killcam_killedby_attachment" + (_id_26E8678BD2761FF9 + 1), _id_4F13B964AB82FE13);
          _id_26E8678BD2761FF9++;
        }
      }
    }

    for(_id_40E4B9C48B36C9EC = _id_26E8678BD2761FF9; _id_40E4B9C48B36C9EC < 8; _id_40E4B9C48B36C9EC++)
      self setclientomnvar("ui_killcam_killedby_attachment" + (_id_40E4B9C48B36C9EC + 1), -1);
  }
}

setkillcamsupertypeomnvars(objweapon) {
  ref = scripts\mp\supers::getsuperrefforsuperweapon(objweapon);
  id = scripts\mp\supers::getsuperid(ref);
  setkillcamkilledbyitemomnvars(2, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

setkillcamkillstreaktypeomnvars(objweapon) {
  _id_87C06A6FBF20E489 = scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(level.killstreakweaponmap[objweapon.basename]);

  if(isDefined(self.scorestreakvariantattackerinfo)) {
    _id_87C06A6FBF20E489 = self.scorestreakvariantattackerinfo.id;
    _id_37318ADC176F0BB8 = self.scorestreakvariantattackerinfo.rarity;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", _id_87C06A6FBF20E489);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", _id_37318ADC176F0BB8 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, _id_87C06A6FBF20E489);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

setkillcamequipmenttypeomnvars(objweapon) {
  equipmentref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);
  _id_9B83EFBA8BFECC3F = scripts\mp\equipment::getequipmenttableinfo(equipmentref);

  if(isDefined(_id_9B83EFBA8BFECC3F))
    setkillcamkilledbyitemomnvars(3, _id_9B83EFBA8BFECC3F.id);

  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

setkillcamexecutiontypeomnvars(ref) {
  if(!isDefined(ref))
    id = 0;
  else
    id = scripts\cp_mp\execution::execution_getidbyref(ref);

  setkillcamkilledbyitemomnvars(4, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

setkillcammisctypeomnvars(id) {
  setkillcamkilledbyitemomnvars(5, id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

clearkillcamattachmentomnvars() {
  for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < 8; _id_40E4B9C48B36C9EC++)
    self setclientomnvar("ui_killcam_killedby_attachment" + (_id_40E4B9C48B36C9EC + 1), -1);
}

isnoneweaponinflictor(einflictor) {
  _id_2919414905A66F17 = 0;

  if(isDefined(einflictor) && isDefined(einflictor.targetname)) {
    switch (einflictor.targetname) {
      case "care_package":
      case "car_damage2":
      case "car_damage1":
      case "remote_tank":
      case "car_damage6":
      case "car_damage5":
      case "car_damage4":
      case "car_damage3":
        _id_2919414905A66F17 = 1;
        break;
    }
  }

  return _id_2919414905A66F17;
}

isenvironmentalinflictor(einflictor) {
  _id_B61B72E59B2EA4E2 = 0;

  if(isDefined(einflictor.killcament) && isDefined(einflictor.classname)) {
    switch (einflictor.classname) {
      case "script_brushmodel":
      case "script_model":
      case "trigger_multiple":
        _id_B61B72E59B2EA4E2 = 1;
        break;
    }
  }

  return _id_B61B72E59B2EA4E2;
}

resetplayeromnvarsonkillcam() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearall(self);
}

_id_EE36210863CA9F2C(objweapon) {
  _id_BF8545F1FC7059D3 = 0;

  switch (objweapon.basename) {
    case "chopper_support_turret_mp":
    case "airdrop_escort_turret_mp":
    case "hover_jet_turret_ballistics_mp":
    case "airdrop_escort_turret_ballistics_mp":
    case "hover_jet_turret_mp":
      _id_BF8545F1FC7059D3 = 1;
      break;
  }

  return _id_BF8545F1FC7059D3;
}

_id_0E2177089F4DD55A(time) {
  if(!level.killcam) {
    return;
  }
  starttime = time - 1000;
  endtime = time + 10000;

  while(gettime() < starttime)
    waitframe();

  level._id_904AA57B8B22090C = 1;
  _id_8E3AD4D5A51DE4F4 = level.skipfinalkillcam;
  level.skipfinalkillcam = 1;

  foreach(player in level.players)
  player notify("abort_killcam");

  while(gettime() < endtime)
    waitframe();

  level._id_904AA57B8B22090C = 0;
  level.skipfinalkillcam = _id_8E3AD4D5A51DE4F4;
}