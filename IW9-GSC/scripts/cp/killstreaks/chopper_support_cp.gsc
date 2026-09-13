/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\chopper_support_cp.gsc
*********************************************************/

init_chopper_support() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", ::chopper_support_set_vehicle_hit_damage_data);
  level.averagealliesz = 0;
}

chopper_support_set_vehicle_hit_damage_data(ref, hitstokill) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(ref, hitstokill);
}

chopper_support_create_enemy_chopper(owner) {
  streakinfo = spawnStruct();
  streakinfo.streakname = "chopper_support";
  streakinfo.owner = owner;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  chopper = owner spawnenemychopper(owner, streakinfo);

  if(!isDefined(chopper)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT ^1 chopper_support_create_enemy_chopper(...)");
    return 0;
  }

  chopper thread startenemychopper(owner, streakinfo);
}

spawnenemychopper(owner, streakinfo) {
  heightoffset = (0, 0, 1750);
  pathstart = owner.origin - anglesToForward(owner.angles) * 15000 + heightoffset;
  pathgoal = owner.origin + anglesToForward(owner.angles) * 2000 + heightoffset;
  angles = owner.angles;
  _id_EBBE5C4D79905B3D = getdvarint("dvar_D992CE3D83291D98", 45);
  goalstruct = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    _id_8013278937FF2600 = randomint(level.heli_structs_entrances.size);
    _id_B2F2CBEB5539EFA6 = level.heli_structs_entrances[_id_8013278937FF2600];
    goalstruct = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(_id_B2F2CBEB5539EFA6.script_linkto, level.heli_structs_goals);
    _id_A168DB747B0D79AC = _id_B2F2CBEB5539EFA6.origin * (1, 1, 0) + heightoffset;
    _id_C32E33B4D51BE12F = goalstruct.origin * (1, 1, 0) + heightoffset;
    _id_8577D255D1A9BD14 = vectorNormalize(_id_C32E33B4D51BE12F - _id_A168DB747B0D79AC);
    pathstart = _id_C32E33B4D51BE12F - _id_8577D255D1A9BD14 * 15000;
    pathgoal = _id_C32E33B4D51BE12F;
    angles = vectortoangles(_id_8577D255D1A9BD14);
  } else
    iprintlnbold("Level is missing heli structs, please set them up!");

  _id_D8AF13D53A9C00A0 = "veh8_mil_air_palfa_east";
  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_chopper_support_mp", _id_D8AF13D53A9C00A0);

  if(!isDefined(chopper)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT - ^1 spawnEnemyChopper(...) ");
    return undefined;
  }

  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = _id_EBBE5C4D79905B3D;
  chopper.team = "axis";
  chopper.owner = owner;
  chopper.angles = angles;
  chopper.streakinfo = streakinfo;
  chopper.streakname = streakinfo.streakname;
  chopper.flaresreservecount = 666;
  chopper.currentdamagestate = 0;
  chopper.pathstart = pathstart;
  chopper.pathgoal = pathgoal;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.currentpatrolstruct = goalstruct;
  chopper.heightoffset = heightoffset;
  chopper.crashoffset = heightoffset[2] - 750;
  chopper.stage1accradius = 50;
  chopper.stage2accradius = 25;
  chopper.stage3accradius = undefined;
  chopper.minshotstostage2acc = 7;
  chopper.minshotstostage3acc = 12;
  chopper.health = 2000;
  chopper.maxhealth = 2000;
  chopper scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname, "destroyed_chopper_support", undefined, "callout_destroyed_chopper_support");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakinfo.streakname, scripts\cp_mp\killstreaks\chopper_support::_id_400022DABDB64055);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](streakinfo.streakname, scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);

  level.choppersupports[level.choppersupports.size] = chopper;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);

  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  _id_9EBE5C9DAEC0C8C2 = "veh8_mil_air_ahotel64_turret_wm_east";
  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  chopper.frontturret setModel(_id_9EBE5C9DAEC0C8C2);
  chopper.frontturret.owner = owner;
  chopper.frontturret.team = "axis";
  chopper.frontturret.angles = chopper.angles;
  chopper.frontturret.streakinfo = streakinfo;
  chopper.frontturret.turreton = 1;
  chopper.frontturret.name = "front_turret";
  chopper.frontturret.attackingtarget = undefined;
  chopper.frontturret linkTo(chopper);
  chopper.frontturret setturretteam("axis");
  chopper.frontturret setturretmodechangewait(0);
  chopper.frontturret setmode("manual");
  chopper.frontturret setdefaultdroppitch(45);
  chopper.frontturret.groundtargetent = spawn("script_model", self.origin);
  chopper.frontturret.groundtargetent setModel("tag_origin");
  chopper.frontturret.groundtargetent dontinterpolate();
  chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  chopper.rearturret setModel(_id_9EBE5C9DAEC0C8C2);
  chopper.rearturret.owner = owner;
  chopper.rearturret.team = "axis";
  chopper.rearturret.angles = chopper.angles;
  chopper.rearturret.streakinfo = streakinfo;
  chopper.rearturret.turreton = 1;
  chopper.rearturret.name = "rear_turret";
  chopper.rearturret.attackingtarget = undefined;
  chopper.rearturret linkTo(chopper);
  chopper.rearturret setturretteam("axis");
  chopper.rearturret setturretmodechangewait(0);
  chopper.rearturret setmode("manual");
  chopper.rearturret setdefaultdroppitch(45);
  chopper.rearturret.groundtargetent = spawn("script_model", self.origin);
  chopper.rearturret.groundtargetent setModel("tag_origin");
  chopper.rearturret.groundtargetent dontinterpolate();
  chopper.killcament = spawn("script_model", chopper gettagorigin("tag_ground"));
  chopper.killcament linkTo(chopper, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  chopper.frontturret.killcament = chopper.killcament;
  chopper.rearturret.killcament = chopper.killcament;
  level notify("matchrecording_chopper", chopper);
  return chopper;
}

startenemychopper(owner, streakinfo) {
  self endon("death");
  self setvehgoalpos(self.pathgoal, 1);
  owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support", "use_" + streakinfo.streakname, 1);
  thread choppersupport_neargoalsettings_enemy();
  self playsoundonmovingent("ks_chopper_support_approach");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
}

choppersupport_neargoalsettings_enemy() {
  self endon("leaving");
  self endon("death");
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchdestoyed();
  thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchgameendleave();
  thread choppersupport_leaveoncommand_enemy();
  thread choppersupport_patrolfield_enemy(1);
  thread choppersupport_engageturrettarget_enemy(self.frontturret);
  thread choppersupport_engageturrettarget_enemy(self.rearturret);
}

choppersupport_leaveoncommand_enemy() {
  self endon("death");
  self endon("leaving");
  level waittill("all_enemy_vehicles_leave");
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_cleanup();
}

choppersupport_patrolfield_enemy(_id_0CE938A4EA8A54D5) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(self.currentaction != "patrol")
    self.currentaction = "patrol";
  else if(self.currentaction == "patrol" && !istrue(_id_0CE938A4EA8A54D5)) {
    return;
  }
  self setneargoalnotifydist(100);
  _id_65AF68838583C396 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(_id_65AF68838583C396))
        _id_65AF68838583C396 = 1;

      waitframe();
      continue;
    }

    if(!istrue(_id_0CE938A4EA8A54D5) && istrue(_id_65AF68838583C396)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support", "chopper_support_patrol");
      _id_65AF68838583C396 = 0;
    }

    _id_E0C08758EB0006BE = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findclosestpatrolstruct();

    if(isDefined(_id_E0C08758EB0006BE))
      scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(_id_E0C08758EB0006BE, 1);
    else {
      _id_2DBC7C5305828A30 = [];
      _id_05E57C125BA3E9B8 = (0, 0, 0);
      _id_D38145343175DDE9 = self.pathgoal;

      foreach(player in level.players) {
        if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        _id_05E57C125BA3E9B8 = _id_05E57C125BA3E9B8 + player.origin;
        _id_2DBC7C5305828A30[_id_2DBC7C5305828A30.size] = player;
      }

      if(isDefined(_id_05E57C125BA3E9B8) && _id_2DBC7C5305828A30.size > 0) {
        _id_565CDE9E77EA668E = _id_05E57C125BA3E9B8 / _id_2DBC7C5305828A30.size;
        scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(_id_565CDE9E77EA668E);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

choppersupport_engageturrettarget_enemy(turret) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(turret.turreton) || istrue(turret.turretdisabled)) {
      waitframe();
      continue;
    }

    targets = choppersupport_gettargets_enemy(turret, 6000, 1, 1);

    if(isDefined(targets) && targets.size > 0) {
      result = choppersupport_acquireturrettarget_enemy(turret, targets);

      if(isDefined(result) && result == "stopped_firing")
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);

      if(!scripts\cp_mp\killstreaks\chopper_support::choppersupport_checkifactivetargets())
        thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_patrolfield();
    }

    wait 0.05;
  }
}

choppersupport_gettargets_enemy(turret, _id_F0885A4B1F9CC49E, _id_F8C5D9BA90C73623, _id_F537B27C366F06C9) {
  self endon("death");
  self endon("leaving");
  targets = [];
  players = level.players;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    _id_397EB484DFDDD2DA = 4500;

    if(isDefined(_id_F0885A4B1F9CC49E))
      _id_397EB484DFDDD2DA = _id_F0885A4B1F9CC49E;

    players = scripts\common\utility::playersinsphere(self.origin, _id_397EB484DFDDD2DA);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    _id_BD73C7ACC56CD20C = players[_id_AC0E594AC96AA3A8];
    [_id_42266A7FD7932C50, _id_4631FDFCABB28E61, invehicle] = choppersupport_istarget_enemy(turret, _id_BD73C7ACC56CD20C, _id_F8C5D9BA90C73623, _id_F537B27C366F06C9);

    if(istrue(_id_42266A7FD7932C50)) {
      newtarget = spawnStruct();
      newtarget.player = _id_BD73C7ACC56CD20C;
      newtarget.searchfortarget = _id_4631FDFCABB28E61;
      newtarget.targetvehicle = invehicle;
      targets[targets.size] = newtarget;
    } else
      continue;

    wait 0.05;
  }

  return targets;
}

choppersupport_istarget_enemy(turret, _id_BD73C7ACC56CD20C, _id_F8C5D9BA90C73623, _id_F537B27C366F06C9) {
  self endon("death");
  self endon("leaving");

  if(!scripts\cp_mp\killstreaks\chopper_support::choppersupport_isplayeractive(_id_BD73C7ACC56CD20C))
    return [0, 0, 0];

  if(isDefined(self.owner) && _id_BD73C7ACC56CD20C == self.owner && self.team == self.owner.team)
    return [0, 0, 0];

  if(!isDefined(_id_BD73C7ACC56CD20C.pers["team"]))
    return [0, 0, 0];

  if(level.teambased && _id_BD73C7ACC56CD20C.pers["team"] == self.team)
    return [0, 0, 0];

  if(_id_BD73C7ACC56CD20C.pers["team"] == "spectator")
    return [0, 0, 0];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(_id_BD73C7ACC56CD20C[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye"))
      return [0, 0, 0];
  }

  if(istrue(_id_BD73C7ACC56CD20C.inlaststand))
    return [0, 0, 0];

  if(scripts\cp_mp\parachute::isparachutegametype() && (_id_BD73C7ACC56CD20C isparachuting() || _id_BD73C7ACC56CD20C isskydiving()))
    return [0, 0, 0];

  _id_E5FEDFF34DEB3853 = 0;

  if(istrue(_id_F8C5D9BA90C73623)) {
    if(distance2dsquared(self.origin, _id_BD73C7ACC56CD20C.origin) > 20250000) {
      if(distance2dsquared(self.origin, _id_BD73C7ACC56CD20C.origin) > 36000000)
        return [0, 0, 0];

      _id_E5FEDFF34DEB3853 = 1;
    }
  }

  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  _id_B9D5783A4F34EFBC = [turret];
  _id_15C3C1D963654F89 = 0;

  if(istrue(_id_F537B27C366F06C9)) {
    _id_15C3C1D963654F89 = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(_id_15C3C1D963654F89)) {
      _id_281DEDD57C723E4F = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::getvehicle();
      _id_B9D5783A4F34EFBC[_id_B9D5783A4F34EFBC.size] = _id_281DEDD57C723E4F;
      _id_53023FDA76FA64FE = _id_281DEDD57C723E4F getlinkedchildren();

      if(isDefined(_id_53023FDA76FA64FE) && _id_53023FDA76FA64FE.size > 0)
        _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_B9D5783A4F34EFBC, _id_53023FDA76FA64FE);
    }
  }

  canseetarget = scripts\engine\trace::ray_trace_passed(turret gettagorigin("tag_barrel"), _id_BD73C7ACC56CD20C gettagorigin("j_head"), _id_B9D5783A4F34EFBC, _id_C3FBB6661B91750F);

  if(!istrue(canseetarget))
    return [0, 0, 0];

  return [1, _id_E5FEDFF34DEB3853, _id_15C3C1D963654F89];
}

choppersupport_acquireturrettarget_enemy(turret, targets) {
  self notify("engaging_target");
  result = undefined;
  [besttarget, searchfortarget, targetvehicle] = choppersupport_getbesttarget_enemy(turret, targets);

  if(isDefined(besttarget)) {
    _id_F14A9B1E9835AEAF = undefined;

    if(istrue(targetvehicle))
      _id_F14A9B1E9835AEAF = besttarget scripts\cp_mp\utility\player_utility::getvehicle();

    scripts\cp_mp\killstreaks\chopper_support::choppersupport_setcurrenttarget(turret, besttarget);

    if(istrue(searchfortarget) && self.currenttarget == besttarget)
      thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(besttarget, 1);

    scripts\cp_mp\killstreaks\chopper_support::choppersupport_fireonturrettarget(turret, besttarget, _id_F14A9B1E9835AEAF, 1, searchfortarget);
    result = "stopped_firing";
  } else
    result = "continue_searching";

  return result;
}

choppersupport_getbesttarget_enemy(turret, targets) {
  _id_88C2B48BA3714B8E = undefined;
  besttarget = undefined;
  _id_F6227B830478253F = undefined;
  _id_79594FB5961C597A = undefined;

  foreach(_id_B8E70FF71A02E32D in targets) {
    if(!scripts\cp_mp\killstreaks\chopper_support::choppersupport_isplayeractive(_id_B8E70FF71A02E32D.player)) {
      continue;
    }
    if(scripts\cp_mp\killstreaks\chopper_support::choppersupport_isactivetarget(_id_B8E70FF71A02E32D.player) && !istrue(_id_B8E70FF71A02E32D.targetvehicle)) {
      continue;
    }
    searchfortarget = 0;
    targetvehicle = 0;
    angle = abs(vectortoangles(_id_B8E70FF71A02E32D.player.origin - self.origin)[1]);
    _id_A6F54781E7E6CB25 = abs(self gettagangles("tag_flash")[1]);
    angle = abs(angle - _id_A6F54781E7E6CB25);
    _id_D6E9347C3618A5BB = _id_B8E70FF71A02E32D.player getweaponslistitems();

    foreach(weapon in _id_D6E9347C3618A5BB) {
      _id_C0B9C9A4FA4EEF84 = weaponclass(weapon);

      if(_id_C0B9C9A4FA4EEF84 == "rocketlauncher")
        angle = angle - 40;
    }

    if(istrue(_id_B8E70FF71A02E32D.searchfortarget)) {
      searchfortarget = 1;
      angle = angle + 40;
    }

    if(istrue(_id_B8E70FF71A02E32D.targetvehicle)) {
      targetvehicle = 1;
      angle = angle + 20;
    }

    if(!isDefined(_id_88C2B48BA3714B8E) || _id_88C2B48BA3714B8E > angle) {
      _id_88C2B48BA3714B8E = angle;
      besttarget = _id_B8E70FF71A02E32D.player;
      _id_79594FB5961C597A = targetvehicle;
      _id_F6227B830478253F = searchfortarget;
    }
  }

  return [besttarget, _id_F6227B830478253F, _id_79594FB5961C597A];
}