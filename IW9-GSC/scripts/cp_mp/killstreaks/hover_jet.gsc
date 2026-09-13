/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\hover_jet.gsc
***************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hover_jet", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hover_jet", "init")]]();

  _id_3775988F960EC3E6();
  init_hover_jet_anims();
  init_hover_jet_vo();
}

_id_3775988F960EC3E6() {
  level.hoverjets = [];
  level.incomingallhoverjets = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level.incominghoverjets[_id_FABF84450735DD93] = 0;
}

#using_animtree("mp_vehicles_always_loaded");

init_hover_jet_anims() {
  level.scr_anim["hover_jet"]["airstrike_flyby_loop"] = % mp_halfa_flyin;
  level.scr_anim["hover_jet"]["airstrike_flyby_bank"] = % iw9_mp_halfa_strike_01;
  level.scr_anim["hover_jet"]["airstrike_flyby_straight"] = % iw9_mp_halfa_strike_02;
  level.scr_anim["hover_jet"]["exit"] = % mp_halfa_exit;
}

init_hover_jet_vo() {
  game["dialog"]["hover_jet_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["hover_jet_leave"] = "killstreak_remote_operator_leave";
  game["dialog"]["hover_jet_crash"] = "killstreak_remote_operator_crash";
  game["dialog"]["hover_jet_confirm"] = "killstreak_remote_operator_confirm_general";
}

weapongivenhoverjet(streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "startMapSelectSequence"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "startMapSelectSequence")]](undefined, undefined, undefined, undefined, streakinfo);

  return 1;
}

tryusehoverjet() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("hover_jet", self);
  return tryusehoverjetfromstruct(streakinfo);
}

tryusehoverjetfromstruct(streakinfo) {
  team = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    return 0;
  }

  level.incomingallhoverjets++;
  _id_F2EFED389AE42A3C = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_F2EFED389AE42A3C = 2;

  if(level.hoverjets.size >= _id_F2EFED389AE42A3C || level.hoverjets.size + level.incomingallhoverjets > _id_F2EFED389AE42A3C) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    level.incomingallhoverjets--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    _id_F8DBAA792BFD1C9F = 1;
    level.incominghoverjets[team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(team, level.hoverjets) + level.incominghoverjets[team] > _id_F8DBAA792BFD1C9F) {
      level.incomingallhoverjets--;
      level.incominghoverjets[team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_VTOL_JET");

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  result = _tryusehoverjetfromstructinternal(streakinfo);
  level.incomingallhoverjets--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level.incominghoverjets[team]--;

  if(!istrue(result)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  return 1;
}

_tryusehoverjetfromstructinternal(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("ks_remote_map_mp"), 1, ::weapongivenhoverjet);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  self playlocalsound("iw9_ks_tablet_ui_screen_plr");
  mappointinfo = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getSelectMapPoint")) {
    mappointinfo = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, 1);
    self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
  }

  if(!isDefined(mappointinfo))
    return 0;

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  thread starthoverjetairstrikepass(self, streakinfo, mappointinfo);
  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.5;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet", "hover_jet_use", 1, _id_52A5BE2E2F91D710);
  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "hover_jet", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_hover_jet", self);

  return 1;
}

starthoverjetairstrikepass(owner, streakinfo, mappointinfo) {
  level endon("game_ended");
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  _id_5ED27D0675C3B6EB = 24000;
  _id_23122E7B902F2EA9 = 6500;
  _id_76AB620FD7CC70BD = 3250;
  _id_67751D5D1646A2AE = 1000;
  heightoffset = (0, 0, 0);
  _id_361663D437DB22F5 = 1500;
  direction = owner.angles;
  _id_505331AD630BBC6B = 1;

  if(isDefined(_id_5FA1E1697A302583))
    _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2] + 750;

  localeid = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(localeid) && localeid == "locale_6")
    _id_76AB620FD7CC70BD = _id_76AB620FD7CC70BD + 500;

  _id_626B0E2269D27A1E = mappointinfo[0].location;
  direction = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(owner, _id_626B0E2269D27A1E, _id_76AB620FD7CC70BD, _id_5ED27D0675C3B6EB);
  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(_id_626B0E2269D27A1E, direction, _id_5ED27D0675C3B6EB, _id_5FA1E1697A302583, _id_76AB620FD7CC70BD, _id_23122E7B902F2EA9, _id_361663D437DB22F5, streakinfo.streakname, _id_505331AD630BBC6B);
  pathstart = flightpath["startPoint"];
  pathgoal = flightpath["endPoint"];
  _id_2ED1737D09C74B75 = "veh9_mil_air_halfa_mp";
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  _id_28F8F60414DFB888 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathstart, direction, "veh_hover_jet_mp_phys", _id_2ED1737D09C74B75);

  if(!isDefined(_id_28F8F60414DFB888)) {
    return;
  }
  _id_EF771A7A6CA753FB = 60;
  _id_28F8F60414DFB888.speed = 250;
  _id_28F8F60414DFB888.accel = 175;
  _id_28F8F60414DFB888.health = 2500;
  _id_28F8F60414DFB888.maxhealth = 2500;
  _id_28F8F60414DFB888.currenthealth = 2500;
  _id_28F8F60414DFB888.angles = vectortoangles(direction);
  _id_28F8F60414DFB888.lifetime = _id_EF771A7A6CA753FB;
  _id_28F8F60414DFB888.team = owner.team;
  _id_28F8F60414DFB888.owner = owner;
  _id_28F8F60414DFB888.streakinfo = streakinfo;
  _id_28F8F60414DFB888.streakname = streakinfo.streakname;
  _id_28F8F60414DFB888.flaresreservecount = 1;
  _id_28F8F60414DFB888.returngoal = _id_626B0E2269D27A1E;
  _id_28F8F60414DFB888.flyheight = _id_76AB620FD7CC70BD;
  _id_28F8F60414DFB888.hoverheight = _id_67751D5D1646A2AE;
  _id_28F8F60414DFB888.missiles = 6;
  _id_28F8F60414DFB888.pers["team"] = _id_28F8F60414DFB888.team;
  _id_28F8F60414DFB888.bestgroundtarget = undefined;
  _id_28F8F60414DFB888.bestairtarget = undefined;
  _id_28F8F60414DFB888.flightdir = flightpath["directionAngles"];
  _id_28F8F60414DFB888 setmaxpitchroll(0, 90);
  _id_28F8F60414DFB888 vehicle_setspeed(_id_28F8F60414DFB888.speed, _id_28F8F60414DFB888.accel);
  _id_28F8F60414DFB888 sethoverparams(50, 100, 50);
  _id_28F8F60414DFB888 setturningability(0.05);
  _id_28F8F60414DFB888 setyawspeed(45, 25, 25, 0.5);
  _id_28F8F60414DFB888 setotherent(_id_28F8F60414DFB888.owner);
  _id_28F8F60414DFB888 setCanDamage(1);
  _id_28F8F60414DFB888 setneargoalnotifydist(700);
  _id_28F8F60414DFB888 setvehicleteam(_id_28F8F60414DFB888.team);
  _id_28F8F60414DFB888 _meth_247AD6A91F6A4FFE(1);
  level thread scripts\cp_mp\utility\killstreak_utility::_id_EE93617532D8A679(_id_28F8F60414DFB888, owner, ::hoverjet_explode);
  _id_28F8F60414DFB888 setscriptablepartstate("blinking_lights", "on", 0);
  _id_28F8F60414DFB888 setscriptablepartstate("thrusters", "active", 0);
  _id_28F8F60414DFB888 setscriptablepartstate("contrails", "on", 0);
  _id_28F8F60414DFB888.turret = spawnturret("misc_turret", _id_28F8F60414DFB888 gettagorigin("tag_turret"), "hover_jet_turret_ballistics_mp");
  _id_28F8F60414DFB888.turret setModel("veh9_mil_air_halfa_turret");
  _id_28F8F60414DFB888.turret.owner = _id_28F8F60414DFB888.owner;
  _id_28F8F60414DFB888.turret.team = _id_28F8F60414DFB888.team;
  _id_28F8F60414DFB888.turret.angles = _id_28F8F60414DFB888.angles;
  _id_28F8F60414DFB888.turret.streakinfo = streakinfo;
  _id_28F8F60414DFB888.turret linkTo(_id_28F8F60414DFB888, "tag_turret", (0, 0, 5), (0, 0, 0));
  _id_28F8F60414DFB888.turret setturretteam(_id_28F8F60414DFB888.team);
  _id_28F8F60414DFB888.turret setturretmodechangewait(0);
  _id_28F8F60414DFB888.turret setmode("manual_target");
  _id_28F8F60414DFB888.turret setsentryowner(_id_28F8F60414DFB888.owner);
  _id_28F8F60414DFB888.turret setdefaultdroppitch(45);
  _id_28F8F60414DFB888.turret maketurretinoperable();
  _id_28F8F60414DFB888.turret setleftarc(360);
  _id_28F8F60414DFB888.turret setrightarc(360);
  _id_28F8F60414DFB888.turret setbottomarc(90);
  _id_28F8F60414DFB888.turret settoparc(90);
  _id_28F8F60414DFB888.turret setconvergencetime(0.5, "pitch");
  _id_28F8F60414DFB888.turret setconvergencetime(0.5, "yaw");
  _id_28F8F60414DFB888.turret setconvergenceheightpercent(0.65);
  _id_28F8F60414DFB888.killcament = spawn("script_model", _id_28F8F60414DFB888.turret gettagorigin("bi_center"));
  _id_28F8F60414DFB888.killcament linkTo(_id_28F8F60414DFB888, "tag_origin", (-500, 0, 500), (0, 0, 0));
  _id_28F8F60414DFB888.turret.killcament = _id_28F8F60414DFB888.killcament;
  _id_28F8F60414DFB888.turret.groundtargetent = spawn("script_model", _id_28F8F60414DFB888.origin);
  _id_28F8F60414DFB888.turret.groundtargetent setModel("tag_origin");
  _id_28F8F60414DFB888.turret.groundtargetent dontinterpolate();
  level.hoverjets[level.hoverjets.size] = _id_28F8F60414DFB888;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    _id_28F8F60414DFB888[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);

  _id_28F8F60414DFB888.animname = streakinfo.streakname;
  _id_28F8F60414DFB888.scenenode = spawn("script_model", _id_28F8F60414DFB888.returngoal * (1, 1, 0) + (0, 0, _id_76AB620FD7CC70BD));
  _id_28F8F60414DFB888.scenenode.angles = _id_28F8F60414DFB888.angles;
  _id_28F8F60414DFB888.scenenode setModel("tag_origin");
  _id_28F8F60414DFB888 _id_FBDA9177C810FF24(_id_626B0E2269D27A1E);
  _id_28F8F60414DFB888 hoverjet_playflyfx();
  _id_C51DE0AF53E40876 = _id_9F6C5E46080E47DC();
  _id_9BC4A52A93594DDD = getanimlength(level.scr_anim[_id_28F8F60414DFB888.animname][_id_C51DE0AF53E40876]);
  _id_2E44AA5689F2DB63 = scripts\engine\utility::get_notetrack_time(level.scr_anim[_id_28F8F60414DFB888.animname][_id_C51DE0AF53E40876], "contrail_off");
  _id_28F8F60414DFB888.scenenode thread scripts\common\anim::anim_single_solo(_id_28F8F60414DFB888, _id_C51DE0AF53E40876);
  _id_28F8F60414DFB888 thread hoverjet_delaysetscriptable(_id_2E44AA5689F2DB63, "contrails", "off");
  _id_28F8F60414DFB888 thread hoverjet_watchgameend();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hover_jet", "registerSentient"))
    _id_28F8F60414DFB888[[scripts\cp_mp\utility\script_utility::getsharedfunc("hover_jet", "registerSentient")]]("Killstreak_Air", self);

  _id_28F8F60414DFB888 _id_58258FDA8EE98D76(streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    _id_28F8F60414DFB888 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::hoverjet_handlemissiledetection);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_9BC4A52A93594DDD);

  if(!isDefined(_id_28F8F60414DFB888)) {
    return;
  }
  if(isDefined(_id_28F8F60414DFB888.scenenode))
    _id_28F8F60414DFB888.scenenode delete();

  _id_28F8F60414DFB888 starthoverjetdefend(streakinfo);
}

hoverjet_delaysetscriptable(_id_74B5B12BB6514385, part, state) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self setscriptablepartstate(part, state, 0);
}

hoverjet_playflyfx() {
  thread scripts\engine\utility::delaythread(0.05, ::hoverjet_playapproachfx);
  thread scripts\engine\utility::delaythread(6, ::hoverjet_playflybyfx);
  thread scripts\engine\utility::delaythread(14, ::hoverjet_playreturnfx);
}

hoverjet_playapproachfx() {
  self playsoundonmovingent("ks_hoverjet_approach");
}

hoverjet_playflybyfx() {
  self playsoundonmovingent("ks_hoverjet_flyby");
}

hoverjet_playreturnfx() {
  self playsoundonmovingent("ks_hoverjet_return");
}

_id_FBDA9177C810FF24(_id_7B59B41B01684053) {
  _id_CAEB7635E74EAD06 = getdvarint("dvar_8EF299CE102DA922", 3);
  thread _id_41780F288D860974(_id_7B59B41B01684053, _id_CAEB7635E74EAD06);
  thread _id_F42C29A91CABC8C2(_id_7B59B41B01684053, _id_CAEB7635E74EAD06);
}

_id_41780F288D860974(_id_7B59B41B01684053, _id_CAEB7635E74EAD06) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  if(_id_CAEB7635E74EAD06 != 0) {
    return;
  }
  _id_C51DE0AF53E40876 = _id_9F6C5E46080E47DC();
  _id_7B00721E9D1EF2A0 = scripts\engine\utility::get_notetrack_time(level.scr_anim["hover_jet"][_id_C51DE0AF53E40876], "attack");
  _id_26689F6158B948AA = _id_7B00721E9D1EF2A0 - 4;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_26689F6158B948AA);
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_0EBEAA9648906468 = self.angles * (0, 1, 0);
  _id_6C5CEED9B00EB7D5 = anglesToForward(_id_0EBEAA9648906468);
  _id_5CC1D6DD55C49E3A = anglestoright(_id_0EBEAA9648906468);
  _id_AE87376418450660 = [_id_7B59B41B01684053 - _id_6C5CEED9B00EB7D5 * 2250 + _id_5CC1D6DD55C49E3A * 750, _id_7B59B41B01684053 - _id_6C5CEED9B00EB7D5 * 1500 - _id_5CC1D6DD55C49E3A * 750, _id_7B59B41B01684053 - _id_6C5CEED9B00EB7D5 * 750 + _id_5CC1D6DD55C49E3A * 250, _id_7B59B41B01684053 - _id_5CC1D6DD55C49E3A * 250, _id_7B59B41B01684053 + _id_6C5CEED9B00EB7D5 * 750 + _id_5CC1D6DD55C49E3A * 750, _id_7B59B41B01684053 + _id_6C5CEED9B00EB7D5 * 1500 - _id_5CC1D6DD55C49E3A * 750, _id_7B59B41B01684053 + _id_6C5CEED9B00EB7D5 * 2250 + _id_5CC1D6DD55C49E3A * 250, _id_7B59B41B01684053 + _id_6C5CEED9B00EB7D5 * 3000 - _id_5CC1D6DD55C49E3A * 250];
  _id_C0C290150BFE81B7 = ["tag_right_aphid_missile", "tag_left_aphid_missile", "tag_right_archer_missile", "tag_left_archer_missile"];
  _id_43CF5D2A3C531D4B = 0;
  _id_C2E32AE249AA7753 = [];

  foreach(index, location in _id_AE87376418450660) {
    _id_22C4300CE1D248E8 = location + (0, 0, 10000);
    _id_98C6610C2907BA2B = location - (0, 0, 10000);
    _id_369DC9ED4C0EC3F5 = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, level.characters, contentoverride);
    enemies = scripts\common\utility::playersinsphere(_id_369DC9ED4C0EC3F5["position"], 1000);
    _id_6D87867F43E1D612 = hoverjet_findmissiletarget(enemies, _id_C2E32AE249AA7753);
    _id_2C990B843BA28448 = self gettagorigin(_id_C0C290150BFE81B7[_id_43CF5D2A3C531D4B]) + anglesToForward(self gettagangles(_id_C0C290150BFE81B7[_id_43CF5D2A3C531D4B])) * 300;
    missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hover_jet_proj_mp"), _id_2C990B843BA28448, _id_369DC9ED4C0EC3F5["position"], self.owner);
    missile.killcament = spawn("script_model", missile.origin);
    missile.killcament linkTo(missile, "tag_origin", (-100, 0, 500), (0, 0, 0));
    missile.killcament thread hoverjet_missilekillcammove(_id_369DC9ED4C0EC3F5["position"], missile.angles);
    missile.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread hoverjet_firemissilescriptable(_id_43CF5D2A3C531D4B + 1);

    if(isDefined(_id_6D87867F43E1D612)) {
      location = _id_6D87867F43E1D612.origin;
      _id_C2E32AE249AA7753[_id_C2E32AE249AA7753.size] = _id_6D87867F43E1D612;
      thread hoverjet_delaymissiletracking(missile, 0.05, _id_6D87867F43E1D612);
    }

    wait 0.5;
    _id_43CF5D2A3C531D4B++;

    if(_id_43CF5D2A3C531D4B > _id_C0C290150BFE81B7.size - 1)
      _id_43CF5D2A3C531D4B = 0;
  }

  _id_C2E32AE249AA7753 = undefined;
}

_id_F42C29A91CABC8C2(_id_7B59B41B01684053, _id_CAEB7635E74EAD06) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  if(_id_CAEB7635E74EAD06 != 1 && _id_CAEB7635E74EAD06 != 2 && _id_CAEB7635E74EAD06 != 3) {
    return;
  }
  _id_C13A68982F815DEC = "attack";

  if(_id_CAEB7635E74EAD06 == 1)
    _id_C13A68982F815DEC = "attack_bomb";

  _id_C51DE0AF53E40876 = _id_9F6C5E46080E47DC();
  _id_56D62165CF89D99C = scripts\engine\utility::get_notetrack_time(level.scr_anim["hover_jet"][_id_C51DE0AF53E40876], _id_C13A68982F815DEC);
  _id_D7C48ECCAE06E020 = _id_7B59B41B01684053 + self.flightdir * 500;
  wait(_id_56D62165CF89D99C);
  sideoffset = 100;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_2B7C965FB8B07829(_id_D7C48ECCAE06E020, sideoffset);
    sideoffset = sideoffset * -1;
    wait 0.095;
  }
}

_id_2B7C965FB8B07829(_id_7B59B41B01684053, sideoffset) {
  if(!isDefined(sideoffset))
    sideoffset = 0;

  _id_921393D77069E4D2 = "hover_jet_bomb_mp";
  _id_976A1708E3157766 = 10;
  _id_735317D9303B68A7 = self.origin - anglestoright(self.angles) * sideoffset;
  _id_8C9ADD3C0A2A7DC1 = _id_735317D9303B68A7 - anglestoup(self.angles) * randomintrange(100, 300);
  _id_67C9BE17F01E1D77 = vectorNormalize(_id_7B59B41B01684053 - self.origin);
  _id_5036600277A13160 = _id_8C9ADD3C0A2A7DC1 + _id_67C9BE17F01E1D77 * distance(_id_8C9ADD3C0A2A7DC1, _id_7B59B41B01684053);
  _id_AFB697B9B1EFC66A = _id_5036600277A13160 - _id_8C9ADD3C0A2A7DC1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "_launchGrenade")) {
    bomb = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "_launchGrenade")]](_id_921393D77069E4D2, _id_8C9ADD3C0A2A7DC1, _id_AFB697B9B1EFC66A, _id_976A1708E3157766);
    bomb.streakinfo = self.streakinfo;
    bomb.killcament = self.killcament;
    bomb thread _id_D6C447FE14CE9A65();
  }
}

_id_D6C447FE14CE9A65() {
  level endon("game_ended");
  self waittill("explode", position);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](position);
}

hoverjet_missilekillcammove(_id_F30B80168EF340E4, _id_D0B12377BC0EC26F) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveTo(_id_F30B80168EF340E4 - anglesToForward(_id_D0B12377BC0EC26F) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

hoverjet_firemissilescriptable(_id_1600845F933938D5) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + _id_1600845F933938D5, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self setscriptablepartstate("fire_missile_" + _id_1600845F933938D5, "off", 0);
}

hoverjet_findmissiletarget(targets, _id_FB3AD4BA40F6988A) {
  _id_D172B4330E232920 = undefined;

  foreach(target in targets) {
    if(level.teambased && target.team == self.team) {
      continue;
    }
    if(target == self.owner) {
      continue;
    }
    if(scripts\engine\utility::array_contains(_id_FB3AD4BA40F6988A, target)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(target[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye"))
        continue;
    }

    _id_D172B4330E232920 = target;
    break;
  }

  return _id_D172B4330E232920;
}

hoverjet_delaymissiletracking(missile, _id_74B5B12BB6514385, _id_D0792A7D1412666F) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  if(isDefined(missile))
    missile missile_settargetEnt(_id_D0792A7D1412666F, (0, 0, 10));
}

hoverjet_delayresetscriptable(_id_47A4179A1EEDCFF8) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("explode" + _id_47A4179A1EEDCFF8, "active", 0);
  wait 1;
  self setscriptablepartstate("explode" + _id_47A4179A1EEDCFF8, "neutral", 0);
}

starthoverjetdefend(streakinfo) {
  thread hoverjet_defendlocation(self.returngoal);
}

hoverjet_defendlocation(_id_28B401C980C645AE) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(self vehicle_isphysveh()) {
    self stopanimScripted();
    self vehphys_setdefaultmotion();
  }

  thread hoverjet_watchlifetime(self.lifetime);
  thread hoverjet_watchowner();
  thread hoverjet_startcombatlogic();
  wait 0.05;
  thread hoverjet_movetolocation(_id_28B401C980C645AE);
}

hoverjet_handlemissiledetection(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");
  _id_6D87867F43E1D612 endon("death");
  _id_6D87867F43E1D612 endon("crashing");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](_id_6D87867F43E1D612);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx"))
        _id_6D87867F43E1D612 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]]("jet_flares", _id_5991F0E5DA9F9BD5);

      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

hoverjet_watchlifetime(lifetime) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet", "hover_jet_leave", 1);
  thread hoverjet_leave();
}

hoverjet_watchgameend() {
  self endon("death");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  thread hoverjet_leave();
}

hoverjet_watchowner() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread hoverjet_leaveonownernotify("disconnect");
  thread hoverjet_leaveonownernotify("joined_team");
}

hoverjet_leaveonownernotify(_id_70687E0CC558A009) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(_id_70687E0CC558A009);
  thread hoverjet_leave();
}

hoverjet_startcombatlogic() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(45, 10);
  thread hoverjet_watchforreposition();
  thread hoverjet_engagegroundtargets();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    self.owner setclientomnvar("ui_using_hover_jet", 1);

  self setscriptablepartstate("thrusters", "idle", 0);
}

hoverjet_movetolocation(location) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  ignorelist = [self, self.turret];

  for(;;) {
    _id_0454EBDDE3D9DCF4 = self.origin;
    _id_2ECA7B12D2EE27BA = location * (1, 1, 0) + (0, 0, self.origin[2]);
    _id_691AA1D5DA533612 = scripts\engine\trace::sphere_trace(_id_0454EBDDE3D9DCF4, _id_2ECA7B12D2EE27BA, 256, ignorelist);
    _id_158F8E4D0E511638 = 0;
    _id_ED223B151283CBF6 = location[0];
    _id_ED223C151283CE29 = location[1];

    if(isDefined(_id_691AA1D5DA533612)) {
      if(_id_691AA1D5DA533612["hittype"] != "hittype_none") {
        _id_ED223B151283CBF6 = _id_691AA1D5DA533612["position"][0];
        _id_ED223C151283CE29 = _id_691AA1D5DA533612["position"][1];
        _id_158F8E4D0E511638 = 1;
      }
    }

    _id_ED2239151283C790 = hoverjet_getcorrectheight(_id_ED223B151283CBF6, _id_ED223C151283CE29, 20);
    _id_6C53D859D582A421 = (_id_ED223B151283CBF6, _id_ED223C151283CE29, _id_ED2239151283C790);
    self setvehgoalpos(_id_6C53D859D582A421, 1);
    self waittill("near_goal");

    if(!istrue(_id_158F8E4D0E511638)) {
      self.currentguardlocation = _id_6C53D859D582A421;
      self notify("hoverJet_moveToNewlocation", _id_6C53D859D582A421);
      break;
    }
  }

  self clearlookatent();
}

hoverjet_getcorrectheight(x, y, _id_00AE14C5A8B1B582) {
  _id_DC8BB6300463CF1E = self.hoverheight;
  _id_E7A7D619F927D791 = hoverjet_tracegroundpoint(x, y);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);
  return _id_1DC672CFE0F0128E;
}

hoverjet_tracegroundpoint(x, y) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  _id_E531AFBE1391F499 = self.origin[2];
  _id_3C590B0EE220AFA3 = level.averagealliesz;
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0, 0, 0);
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace((x, y, _id_E531AFBE1391F499), (x, y, z), 512, self, contentoverride, 1);

  if(_id_E96577032A7740FC["position"][2] < _id_3C590B0EE220AFA3)
    _id_0FA83E3A4C4E6902 = _id_3C590B0EE220AFA3;
  else
    _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];

  return _id_0FA83E3A4C4E6902;
}

hoverjet_engagegroundtargets() {
  self notify("engageGround");
  self endon("engageGround");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  thread _id_7CAD88468DF8256E();

  for(;;) {
    _id_97E45AB250562D16 = undefined;

    if(!isDefined(self.bestgroundtarget)) {
      _id_8B9F24FF1C0D7822 = undefined;
      _id_1833609413F67DE7 = undefined;
      _id_1C58DD8C5CA65897 = undefined;

      if(scripts\common\utility::iscp()) {
        _id_8B9F24FF1C0D7822 = "allies";
        _id_1833609413F67DE7 = 1;
        _id_1C58DD8C5CA65897 = 1;
      }

      _id_97E45AB250562D16 = _id_05323B44EE395058::_id_770A14E56B03B067(self.turret, 3000, 1, 0, 0, undefined, "dvar_48714771F0D0B941", _id_8B9F24FF1C0D7822, _id_1833609413F67DE7, _id_1C58DD8C5CA65897);

      if(!isDefined(_id_97E45AB250562D16)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
        continue;
      }

      self.bestgroundtarget = _id_05323B44EE395058::_id_70B8756E9FC03C44(_id_97E45AB250562D16);
      self notify("acquiringTarget", self.bestgroundtarget);
    }

    self.turret settargetentity(self.turret.groundtargetent);

    if(!isDefined(self.bestairtarget))
      self setlookatent(self.bestgroundtarget);

    _id_F14A9B1E9835AEAF = _id_05323B44EE395058::_id_0EFFEBB9076EFBDB(_id_97E45AB250562D16);
    thread hoverjet_watchtargetstatus(self.bestgroundtarget);
    thread hoverjet_watchtargetlos(self.bestgroundtarget, undefined, _id_F14A9B1E9835AEAF);
    thread hoverjet_watchtargettimeout(self.bestgroundtarget);
    hoverjet_fireongroundtarget(isDefined(_id_F14A9B1E9835AEAF));
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

_id_7CAD88468DF8256E() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self.turret waittill("missile_fire", projectile);
    projectile.streakinfo = self.streakinfo;
    projectile.killcament = self.killcament;
  }
}

hoverjet_fireongroundtarget(targetvehicle) {
  firetime = weaponfiretime("hover_jet_turret_ballistics_mp");
  _id_0DB0EA2C2C400255 = 0;
  _id_DBC5AEB90480B355 = 0;
  _id_B0B68854AE03B4D7 = 100;

  while(isDefined(self) && isDefined(self.bestgroundtarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving)) {
    if(self.turret hoverjet_turretlookingattarget()) {
      _id_DE95D26A97999B92 = undefined;

      if(isDefined(targetvehicle))
        _id_DE95D26A97999B92 = self.bestgroundtarget.origin;
      else
        _id_DE95D26A97999B92 = self.bestgroundtarget gettagorigin("j_mainroot");

      scripts\cp_mp\killstreaks\chopper_support::choppersupport_setattackpoint(self.turret, self.bestgroundtarget, _id_DE95D26A97999B92, _id_B0B68854AE03B4D7);

      if(_id_DBC5AEB90480B355 == 0)
        wait 0.1;

      if(_id_DBC5AEB90480B355 == 15)
        _id_B0B68854AE03B4D7 = 50;
      else if(_id_DBC5AEB90480B355 == 30)
        _id_B0B68854AE03B4D7 = undefined;

      self.turret shootturret("tag_flash");
      _id_DBC5AEB90480B355++;
      self.turret.streakinfo.shots_fired++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(firetime);
  }
}

hoverjet_turretlookingattarget() {
  _id_97F0985016AA48CB = 0.996;
  _id_929AD65D451FFC68 = anglesToForward(self gettagangles("tag_flash"));
  _id_EFA57ADC48838F9B = vectorNormalize(self.groundtargetent.origin - self.origin);
  _id_FF53E400DD536B82 = vectordot(_id_929AD65D451FFC68, _id_EFA57ADC48838F9B);

  if(isDefined(self gettargetentity(1)) && _id_FF53E400DD536B82 >= _id_97F0985016AA48CB)
    return 1;

  return 0;
}

hoverjet_engageairtargets() {
  self notify("engageAir");
  self endon("engageAir");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.bestairtarget)) {
      _id_18603C41332BF068 = [];
      _id_18603C41332BF068 = scripts\engine\utility::array_combine(level.helis, level.littlebirds, level.supportdrones);
      self.bestairtarget = hoverjet_getbestairtarget(_id_18603C41332BF068);
      self notify("hoverJet_acquiringAirTarget", self.bestairtarget);

      if(!isDefined(self.bestairtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
        continue;
      }
    }

    thread hoverjet_watchtargetstatus(self.bestairtarget);
    hoverjet_fireonairtarget();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

hoverjet_fireonairtarget() {
  _id_C42E4EFDF5E20E14 = "right";
  _id_B144B7D889960D44 = makeweapon("hover_jet_proj_mp");
  _id_52AEFEEF79E2902D = undefined;
  self setlookatent(self.bestairtarget);

  while(isDefined(self) && isDefined(self.bestairtarget)) {
    _id_ECBF90442E065A5F = 5;

    if(!istrue(_id_52AEFEEF79E2902D))
      _id_52AEFEEF79E2902D = 1;

    while(_id_ECBF90442E065A5F > 0 && isDefined(self.bestairtarget) && !hoverjet_airtargetiswithinview(self.bestairtarget)) {
      _id_ECBF90442E065A5F = _id_ECBF90442E065A5F - level.framedurationseconds;
      waitframe();
    }

    if(isDefined(self.bestairtarget))
      hoverjet_moveawayfromtarget(self.bestairtarget);
    else
      break;

    if(isDefined(self.bestairtarget)) {
      _id_3F5937AB90734769 = self gettagorigin("tag_" + _id_C42E4EFDF5E20E14 + "_archer_missile") + anglesToForward(self.angles) * 100;
      _id_77E91C731500DFE8 = _id_3F5937AB90734769 + anglesToForward(self.angles) * 100;
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(_id_B144B7D889960D44, _id_3F5937AB90734769, _id_77E91C731500DFE8, self.owner);
      _id_9806E3C29658CC34 = hoverjet_setmissileoffset(self.bestairtarget);
      missile missile_settargetEnt(self.bestairtarget, _id_9806E3C29658CC34);
      missile.streakinfo = self.streakinfo;

      if(_id_C42E4EFDF5E20E14 == "right")
        _id_C42E4EFDF5E20E14 = "left";
      else
        _id_C42E4EFDF5E20E14 = "right";
    } else
      break;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  }

  if(istrue(self.movedoffguardlocation)) {
    thread hoverjet_movetolocation(self.currentguardlocation);
    self.movedoffguardlocation = undefined;
  }
}

hoverjet_setmissileoffset(target) {
  offset = (0, 0, 0);

  if(isDefined(target.streakinfo)) {
    switch (target.streakinfo.streakname) {
      case "chopper_support":
      case "chopper_gunner":
        offset = (0, 0, -50);
        break;
      case "radar_drone_overwatch":
        offset = (0, 0, -30);
        break;
      case "hover_jet":
        offset = (0, 0, 20);
        break;
      case "scrambler_drone_guard":
        offset = (0, 0, 10);
        break;
    }
  }

  return offset;
}

hoverjet_airtargetiswithinview(_id_250463AB8AF4A9AE) {
  _id_97F0985016AA48CB = 0.866;
  _id_6C5CEED9B00EB7D5 = anglesToForward(self.angles);
  _id_EFA57ADC48838F9B = vectorNormalize(_id_250463AB8AF4A9AE.origin - self.origin);
  _id_FF53E400DD536B82 = vectordot(_id_6C5CEED9B00EB7D5, _id_EFA57ADC48838F9B);
  return scripts\engine\utility::ter_op(_id_FF53E400DD536B82 >= _id_97F0985016AA48CB, 1, 0);
}

hoverjet_airtargetistooclose(_id_250463AB8AF4A9AE) {
  return scripts\engine\utility::ter_op(distance2dsquared(_id_250463AB8AF4A9AE.origin, self.origin) < 1000000, 1, 0);
}

hoverjet_moveawayfromtarget(_id_250463AB8AF4A9AE) {
  while(isDefined(_id_250463AB8AF4A9AE) && hoverjet_airtargetistooclose(_id_250463AB8AF4A9AE)) {
    _id_6C53D859D582A421 = undefined;
    _id_6C5CEED9B00EB7D5 = anglesToForward(self.angles);
    _id_5CC1D6DD55C49E3A = anglestoright(self.angles);
    _id_4549CD5FC4176D49 = self.origin - _id_6C5CEED9B00EB7D5 * 1000;
    _id_FDA6246979F38F6D = self.origin + 707.0 * (_id_5CC1D6DD55C49E3A - _id_6C5CEED9B00EB7D5);
    _id_E3CFF2D14EFA4B98 = self.origin + 707.0 * (-1 * _id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A);
    _id_E2F36ECDAE896A0A = [_id_4549CD5FC4176D49, _id_FDA6246979F38F6D, _id_E3CFF2D14EFA4B98];
    _id_B9D5783A4F34EFBC = [self, _id_250463AB8AF4A9AE];

    foreach(position in _id_E2F36ECDAE896A0A) {
      if(scripts\engine\trace::sphere_trace_passed(self.origin, position, 256, _id_B9D5783A4F34EFBC))
        _id_6C53D859D582A421 = position * (1, 1, 0) + (0, 0, _id_250463AB8AF4A9AE.origin[2]);
    }

    if(isDefined(_id_6C53D859D582A421)) {
      self.movedoffguardlocation = 1;
      self setvehgoalpos(_id_6C53D859D582A421, 1);
    }

    waitframe();
  }
}

hoverjet_watchforreposition() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self setneargoalnotifydist(100);
  scripts\cp_mp\utility\killstreak_utility::_id_E68434BDB941ED1E(self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/HOVER_JET_GUARD", 1);
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  activatetime = 0.25;
  self.useobj setuseholdduration(250);

  while(isDefined(self.useobj)) {
    _id_23B90B34FECC58CD = 0;
    self.useobj waittill("trigger", player);

    if(player scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet", "hover_jet_confirm", 1);
    self setscriptablepartstate("thrusters", "active", 0);

    if(isDefined(player)) {
      thread hoverjet_movetolocation(player.origin);
      thread hoverjet_watchfornearmovementgoal();
    }
  }
}

hoverjet_watchfornearmovementgoal() {
  self endon("death");
  self endon("leaving");
  self waittill("near_goal");
  self setscriptablepartstate("thrusters", "idle", 0);
}

hoverjet_randomizemovement() {
  self notify("random_movement");
  self endon("random_movement");
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
}

_id_58258FDA8EE98D76(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_A7C9961508E4B099;
  _id_191284E2E2837328 = ::_id_8987EF697FE06DA3;
  _id_BACC6DD14316758C = ::_id_3B2CCB79D72D0155;
  _id_7DA88D9C69433487 = ::_id_ACD17BDC96A89F80;
  deathcallback = ::hoverjet_handledeathdamage;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, self.maxhealth * 0.75, ::_id_BE82A8C78A16752B);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, self.maxhealth * 0.5, ::_id_239DC7891D929C9C);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, self.maxhealth * 0.25, ::_id_BA3A1232DBDA15DA);
}

_id_A7C9961508E4B099(streakname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
}

_id_8987EF697FE06DA3(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 24;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 50;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 9;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 13;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_3B2CCB79D72D0155(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_ACD17BDC96A89F80(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

_id_BE82A8C78A16752B() {
  self setscriptablepartstate("body_damage_light", "on");
}

_id_239DC7891D929C9C() {
  self setscriptablepartstate("body_damage_medium", "on");
}

_id_BA3A1232DBDA15DA() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

hoverjet_handledeathdamage(data) {
  self.killedbyweapon = data.objweapon;
  thread hoverjet_handledestroyed(data.attacker, data.objweapon);
  return 1;
}

hoverjet_handledestroyed(attacker, killedbyweapon) {
  level endon("game_ended");
  self endon("hover_jet_gone");
  _id_01D4408C68F2118A = isDefined(attacker) && isPlayer(attacker) && istrue(attacker.isjuggernaut);
  _id_031777ACBF2B0901 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](killedbyweapon) && !_id_01D4408C68F2118A)
      _id_031777ACBF2B0901 = 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    self.owner setclientomnvar("ui_using_hover_jet", 0);

  if(istrue(_id_031777ACBF2B0901))
    hoverjet_crash(75);

  thread hoverjet_explode();
}

hoverjet_crash(speed) {
  self endon("explode");
  self.iscrashing = 1;
  self.killcament unlink();
  self.killcament.origin = self.origin + (0, 0, 100);
  self vehicle_turnengineoff();
  self clearlookatent();
  self notify("crashing");
  self playsoundonmovingent("ks_hoverjet_crash");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  _id_6847739E80FB4E81 = hoverjet_findcrashposition(2500);

  if(!isDefined(_id_6847739E80FB4E81)) {
    return;
  }
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet", "hover_jet_crash", 1);
  self setvehgoalpos(_id_6847739E80FB4E81, 0);
  thread _id_0A12DF0241D8EEA2(_id_6847739E80FB4E81);
  thread hoverjet_spinout(speed);
  scripts\engine\utility::waittill_any_timeout_2(5, "collision", "near_goal");
}

_id_0A12DF0241D8EEA2(_id_6847739E80FB4E81) {
  self endon("death");
  _id_9F9C84729373F7DB = length(self.origin - _id_6847739E80FB4E81);
  _id_501DFE1465156B4C = _id_9F9C84729373F7DB * 0.5;
  _id_153BDB19C511CB34 = _id_501DFE1465156B4C * _id_501DFE1465156B4C;

  for(;;) {
    if(distancesquared(self.origin, _id_6847739E80FB4E81) <= _id_153BDB19C511CB34) {
      break;
    }

    waitframe();
  }

  self setscriptablepartstate("explode_cockpit", "on", 0);
}

hoverjet_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.5);
    wait 0.5;
  }
}

hoverjet_findcrashposition(_id_6F8D59F68BD2B46C) {
  _id_B2B5F5510C5D94E0 = self.origin;
  crashoffset = 1000;
  _id_543F2191DDE2B7F6 = undefined;
  _id_6C5CEED9B00EB7D5 = anglesToForward(self.angles);
  _id_5CC1D6DD55C49E3A = anglestoright(self.angles);
  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 + _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_5CC1D6DD55C49E3A - _id_6C5CEED9B00EB7D5) - (0, 0, crashoffset);
  _id_4720F54E3EFF6E8D = scripts\engine\trace::ray_trace(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (-1 * _id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  return _id_543F2191DDE2B7F6;
}

hoverjet_explode() {
  if(istrue(self._id_3621873DCCBDE4B5)) {
    return;
  }
  self notify("explode");
  self._id_3621873DCCBDE4B5 = 1;
  scripts\cp_mp\utility\killstreak_utility::_id_5A9772411551E56E("hover_jet");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "hover_jet_turret_ballistics_mp");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread hoverjet_cleanup(1);
}

hoverjet_leave() {
  self endon("death");
  self.isleaving = 1;
  self notify("leaving");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    self.owner setclientomnvar("ui_using_hover_jet", 0);

  hoverjet_breakofftarget(undefined, 1);
  _id_DF6C75D1A1E4FF18 = 3;
  _id_E757789796C82383 = (0, 0, 1000);
  _id_BB0E78A73B33D580 = self.origin + _id_E757789796C82383;
  _id_BC09A6E223B96348 = undefined;
  _id_690E4620FE5FA98F = undefined;
  _id_EC0C66C48E6F8304 = undefined;

  while(_id_DF6C75D1A1E4FF18 > 0) {
    flightpath = scripts\cp_mp\utility\killstreak_utility::_id_999FE3838D6B6F8C(_id_BB0E78A73B33D580, self.angles, 350, 24000);

    if(isDefined(flightpath.end)) {
      _id_BC09A6E223B96348 = flightpath.start;
      _id_690E4620FE5FA98F = flightpath.end;
      _id_EC0C66C48E6F8304 = flightpath.angles;
      break;
    }

    _id_BB0E78A73B33D580 = _id_BB0E78A73B33D580 + (0, 0, 1000);
    _id_DF6C75D1A1E4FF18--;
    wait 0.05;
  }

  if(!isDefined(_id_690E4620FE5FA98F))
    thread hoverjet_explode();
  else {
    _id_1602FAB5EAB68601 = 150;
    _id_2451A07ACA478BF6 = 35;
    self setyawspeed(_id_1602FAB5EAB68601, 50, 25, 0);
    self settargetyaw(_id_EC0C66C48E6F8304[1]);
    self vehicle_setspeed(_id_2451A07ACA478BF6, 25);
    pathgoal = _id_BC09A6E223B96348;
    self setvehgoalpos(pathgoal, 1);
    self vehicleplayanim(level.scr_anim["hover_jet"]["exit"]);
    self playsoundonmovingent("ks_hoverjet_leave");
    self setscriptablepartstate("thrusters", "active", 0);
    scripts\engine\utility::waittill_any_timeout_1(3, "goal");
    _id_F457885F9E89C75D = 0;

    while(_id_F457885F9E89C75D < 2) {
      _id_9DBBC8DD984310F1 = (0, self.angles[1], 0);
      _id_93E14809173F1E03 = _id_EC0C66C48E6F8304 - _id_9DBBC8DD984310F1;

      if(abs(_id_93E14809173F1E03[1]) < 5) {
        break;
      }

      _id_F457885F9E89C75D = _id_F457885F9E89C75D + level.framedurationseconds;
      waitframe();
    }

    self vehicle_turnengineoff();
    self setscriptablepartstate("contrails", "on", 0);
    self vehicle_setspeed(250, 75);
    self setvehgoalpos(_id_690E4620FE5FA98F, 1);
    self setneargoalnotifydist(1000);
    scripts\engine\utility::waittill_any_timeout_1(10, "near_goal");
    self notify("hover_jet_gone");
    thread hoverjet_cleanup(0);
  }
}

hoverjet_cleanup(_id_4FAC8B8CE36E09F1) {
  if(istrue(self._id_BF178F6894D17B96)) {
    return;
  }
  self._id_BF178F6894D17B96 = 1;

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.turret.groundtargetent))
    self.turret.groundtargetent delete();

  if(isDefined(self.scenenode))
    self.scenenode delete();

  self setscriptablepartstate("blinking_lights", "off", 0);
  self setscriptablepartstate("thrusters", "off", 0);
  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(!istrue(self.recordedgameendstats))
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  level.hoverjets = scripts\engine\utility::array_remove(level.hoverjets, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

hoverjet_watchtargetstatus(target) {
  _id_1A3325FBF315EEE7 = target getentitynumber();
  self endon("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");

  if(isPlayer(target))
    thread hoverjet_watchgroundtargetdeathdisconnect(target);
  else
    thread hoverjet_watchairtargetdeath(target);

  thread hoverjet_watchforbreakaction(target, "hoverJet_targetLost " + _id_1A3325FBF315EEE7);
  thread hoverjet_watchforbreakaction(target, "hoverJet_targetNotInView " + _id_1A3325FBF315EEE7);
  thread hoverjet_watchforbreakaction(target, "hoverJet_moveToNewlocation");
  thread hoverjet_watchforbreakaction(target, "hoverJet_targetTimeout");
}

hoverjet_watchgroundtargetdeathdisconnect(_id_FC034515F9E66143) {
  _id_1A3325FBF315EEE7 = _id_FC034515F9E66143 getentitynumber();
  self endon("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  _id_FC034515F9E66143 waittill("death_or_disconnect");
  self notify("hoverJet_targetLost " + _id_1A3325FBF315EEE7);
}

hoverjet_watchairtargetdeath(_id_250463AB8AF4A9AE) {
  _id_1A3325FBF315EEE7 = _id_250463AB8AF4A9AE getentitynumber();
  self endon("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  _id_250463AB8AF4A9AE waittill("death");
  self notify("hoverJet_targetLost " + _id_1A3325FBF315EEE7);
}

hoverjet_watchforbreakaction(target, action) {
  _id_1A3325FBF315EEE7 = target getentitynumber();
  self endon("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  self waittill(action);
  hoverjet_breakofftarget(_id_1A3325FBF315EEE7);
}

hoverjet_watchtargetlos(target, tolerance, _id_9CB7C709F17E1C56) {
  _id_1A3325FBF315EEE7 = target getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  _id_FA2A5BDD4208DF6E = undefined;

  if(!isDefined(tolerance))
    tolerance = 500;

  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  ignorelist = [self.turret];

  if(isDefined(_id_9CB7C709F17E1C56)) {
    ignorelist[ignorelist.size] = _id_9CB7C709F17E1C56;
    _id_53023FDA76FA64FE = _id_9CB7C709F17E1C56 getlinkedchildren();

    if(isDefined(_id_53023FDA76FA64FE) && _id_53023FDA76FA64FE.size > 0)
      ignorelist = scripts\engine\utility::array_combine(ignorelist, _id_53023FDA76FA64FE);
  }

  for(;;) {
    canseetarget = scripts\engine\trace::ray_trace_passed(self.turret gettagorigin("tag_barrel"), target gettagorigin("j_head"), ignorelist, _id_C3FBB6661B91750F);

    if(!istrue(canseetarget)) {
      if(!isDefined(_id_FA2A5BDD4208DF6E))
        _id_FA2A5BDD4208DF6E = gettime();

      if(gettime() - _id_FA2A5BDD4208DF6E > tolerance) {
        self notify("hoverJet_targetNotInView " + _id_1A3325FBF315EEE7);
        return;
      }
    } else
      _id_FA2A5BDD4208DF6E = undefined;

    wait 0.25;
  }
}

hoverjet_watchtargettimeout(target) {
  _id_1A3325FBF315EEE7 = target getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self notify("hoverJet_targetTimeout");
}

hoverjet_breakofftarget(_id_1A3325FBF315EEE7, _id_D239154C0F9CED8E) {
  _id_291F69A68AA5DDB3 = undefined;

  if(!isDefined(_id_1A3325FBF315EEE7) || istrue(_id_D239154C0F9CED8E)) {
    self.bestgroundtarget = undefined;
    self.bestairtarget = undefined;
    self clearlookatent();
    self.turret cleartargetentity();
    self.turret.groundtargetent unlink();
    _id_291F69A68AA5DDB3 = "Breaking off all targets";
    self notify("hoverJet_breakOffAllTargets");
    return;
  } else {
    if(isDefined(self.bestgroundtarget) && _id_1A3325FBF315EEE7 == self.bestgroundtarget getentitynumber()) {
      if(isDefined(self.bestgroundtarget.name))
        _id_291F69A68AA5DDB3 = "Breaking off ground target: " + self.bestgroundtarget.name;

      self.bestgroundtarget = undefined;
      self.turret cleartargetentity();
      self.turret.groundtargetent unlink();
    } else if(isDefined(self.bestairtarget) && _id_1A3325FBF315EEE7 == self.bestairtarget getentitynumber()) {
      if(isDefined(self.bestairtarget.model))
        _id_291F69A68AA5DDB3 = "Breaking off air target: " + self.bestairtarget.model;

      self.bestairtarget = undefined;
    } else
      _id_291F69A68AA5DDB3 = "Breaking off removed target: " + _id_1A3325FBF315EEE7;

    if(!isDefined(self.bestgroundtarget) && !isDefined(self.bestairtarget))
      self clearlookatent();
  }

  self notify("hoverJet_breakOffTarget " + _id_1A3325FBF315EEE7);
}

hoverjet_getbestairtarget(targets) {
  self endon("death");
  self endon("leaving");
  besttarget = undefined;
  _id_FDB9974A1CCCE54C = undefined;
  _id_04EFAF0D84225539 = 0;

  foreach(_id_B8E70FF71A02E32D in targets) {
    if(!isDefined(_id_B8E70FF71A02E32D)) {
      continue;
    }
    if(!istrue(_id_04EFAF0D84225539)) {
      if(level.teambased && _id_B8E70FF71A02E32D.team == self.team) {
        continue;
      }
      if(_id_B8E70FF71A02E32D.owner == self.owner)
        continue;
    }

    _id_6B40B4C28ABE0A05 = distance2dsquared(_id_B8E70FF71A02E32D.origin, self.origin);

    if(_id_6B40B4C28ABE0A05 >= 6250000) {
      continue;
    }
    if(!isDefined(_id_FDB9974A1CCCE54C) || _id_6B40B4C28ABE0A05 < _id_FDB9974A1CCCE54C) {
      besttarget = _id_B8E70FF71A02E32D;
      _id_FDB9974A1CCCE54C = _id_6B40B4C28ABE0A05;
    }
  }

  return besttarget;
}

_id_9F6C5E46080E47DC() {
  _id_C51DE0AF53E40876 = "airstrike_flyby_straight";
  return _id_C51DE0AF53E40876;
}