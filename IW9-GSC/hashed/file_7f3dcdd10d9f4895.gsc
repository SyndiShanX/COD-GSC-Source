/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7f3dcdd10d9f4895.gsc
***********************************************/

main() {
  if(isDefined(level._id_B6F920E6490405E8)) {
    if(!scripts\engine\utility::flag_exist(level._id_B6F920E6490405E8 + "_completed"))
      scripts\engine\utility::flag_init(level._id_B6F920E6490405E8 + "_completed");

    scripts\engine\utility::flag_wait(level._id_B6F920E6490405E8 + "_completed");
  } else {
    if(!scripts\engine\utility::flag_exist("cp_crate_drops_cs_completed"))
      scripts\engine\utility::flag_init("cp_crate_drops_cs_completed");

    scripts\engine\utility::flag_wait("cp_crate_drops_cs_completed");
  }

  level thread start_crate_drops();
}

start_crate_drops() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  level.crate_drop_time = 15;
  level.crates_active_at_location = [];

  for(;;) {
    script_noteworthy = "";
    _id_1644B9CB168349AE = undefined;
    _id_1CDE3266E2EC3F23 = undefined;
    _id_EDB3C79706A464E5 = undefined;

    if(getdvarint("dvar_DB1043933E74629A", 0) != 0)
      level scripts\engine\utility::waittill_any_timeout_2(level.crate_drop_time, "start_periodic_drops", "drop_requested");
    else
      level waittill("drop_requested", script_noteworthy, _id_1644B9CB168349AE, _id_1CDE3266E2EC3F23, _id_EDB3C79706A464E5);

    _id_4ED8A7AE9D9964E0 = isDefined(_id_EDB3C79706A464E5) && istrue(_id_EDB3C79706A464E5._id_CAF6CE727AF8B2CE);

    if(getdvarint("dvar_33C6CE6F30F102BA", 0) == 0) {
      _id_EA88845C8353CC2E = getrandompointincpmap(script_noteworthy);

      if(!isDefined(_id_EA88845C8353CC2E)) {
        continue;
      }
      if(isDefined(_id_EA88845C8353CC2E.script_linkname)) {
        if(isDefined(level.crates_active_at_location[_id_EA88845C8353CC2E.script_linkname]))
          continue;
      } else if(isDefined(_id_EA88845C8353CC2E.script_noteworthy)) {
        if(isDefined(level.crates_active_at_location[_id_EA88845C8353CC2E.script_noteworthy]) && !_id_4ED8A7AE9D9964E0)
          continue;
      }

      level thread dropcarepackage(_id_EA88845C8353CC2E, _id_1644B9CB168349AE, _id_1CDE3266E2EC3F23);
    }
  }
}

request_crate_drop(script_noteworthy, _id_1644B9CB168349AE) {
  level notify("drop_requested", script_noteworthy, _id_1644B9CB168349AE);
}

getrandompointincpmap(script_noteworthy) {
  if(script_noteworthy != "") {
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(script_noteworthy, "script_noteworthy");
    return _id_9E4E1482CB40C9C5[randomint(_id_9E4E1482CB40C9C5.size)];
  } else {
    pos = scripts\cp\utility\entity::getaverageorigin(level.players);
    _id_20FBC820D79759B8 = scripts\engine\utility::getStructArray("crate_spawn", "targetname");
    struct = scripts\engine\utility::get_array_of_closest(pos, _id_20FBC820D79759B8, undefined, 1, 6669);

    if(struct.size > 0)
      return struct[0];
    else {
      struct = _id_20FBC820D79759B8[0];
      return struct;
    }
  }
}

dropcarepackage(_id_EA88845C8353CC2E, _id_1644B9CB168349AE, _id_1CDE3266E2EC3F23) {
  level endon("game_ended");
  dropposition = scripts\engine\utility::drop_to_ground(_id_EA88845C8353CC2E.origin, 50, -200, (0, 0, 1));
  dropposition = dropposition + (0, 0, 1);

  if(!istrue(level.announcer_vo_playing) && !istrue(level.isteamvoplaying))
    thread scripts\cp\cp_dialogue::play_vo_to_all("dx_mpa_rutl_airdrop_friendly_use", 6);

  crate = dropcratefrommanualheli_cp(dropposition, _id_1CDE3266E2EC3F23);
  crate thread _id_F3CC921D5C3FB159(dropposition, _id_EA88845C8353CC2E);

  if(isDefined(_id_1644B9CB168349AE))
    crate.random_loot_override = _id_1644B9CB168349AE;

  crate thread oncratedrop(dropposition, _id_EA88845C8353CC2E);

  if(isDefined(_id_EA88845C8353CC2E.script_linkname))
    level.crates_active_at_location[_id_EA88845C8353CC2E.script_linkname] = crate;
  else if(isDefined(_id_EA88845C8353CC2E.script_noteworthy))
    level.crates_active_at_location[_id_EA88845C8353CC2E.script_noteworthy] = crate;

  return crate;
}

_id_F3CC921D5C3FB159(_id_BD86AD8F5C8000AD, _id_EA88845C8353CC2E) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.animendtime)) {
    timer = int((self.animendtime - gettime()) / 1000);
    _id_4C87400544DC7457 = 38;
    self.objicon = scripts\cp\cp_objectives::requestworldid("crate_timer", 25);
    objective_setplayintro(self.objicon, 1);
    objective_setbackground(self.objicon, 1);
    objective_state(self.objicon, "invisible");
    objective_icon(self.objicon, "hud_icon_survival_killstreak_small");
    objective_setminimapiconsize(self.objicon, "icon_regular");
    org = _id_EA88845C8353CC2E.origin;
    objective_position(self.objicon, org + (0, 0, _id_4C87400544DC7457));
    objective_setshowdistance(self.objicon, 1);
    objective_sethot(self.objicon, 0);
    objective_setpinned(self.objicon, 0);
    objective_hidefromplayersinmask(self.objicon);
    objective_removeallfrommask(self.objicon);
    wait 2.5;
    progress = 1;
    _id_D19E041C9E06ACBE = timer;
    waittime = 0.1;
    _id_9A856EA56A94E11E = waittime / _id_D19E041C9E06ACBE;
    objective_showprogressforteam(self.objicon, "allies");

    while(progress > 0) {
      objective_setprogress(self.objicon, progress);
      wait(waittime);
      progress = progress - _id_9A856EA56A94E11E;

      if(progress < 0)
        progress = 0;
    }

    scripts\cp\cp_objectives::freeworldid("crate_timer");
  }

  if(isDefined(_id_EA88845C8353CC2E.script_linkname))
    level notify("crate_dropped_" + _id_EA88845C8353CC2E.script_linkname, self);
  else if(isDefined(_id_EA88845C8353CC2E.script_noteworthy))
    level notify("crate_dropped_" + _id_EA88845C8353CC2E.script_noteworthy, self);
}

dropcratefrommanualheli_cp(position, _id_1CDE3266E2EC3F23) {
  type = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "attachment", "munition"));
  cratetype = "operation_crates";

  if(getDvar("dvar_D1D8A66C23A05A04", "") != "")
    cratetype = getDvar("dvar_D1D8A66C23A05A04", "");

  if(isDefined(_id_1CDE3266E2EC3F23))
    cratetype = _id_1CDE3266E2EC3F23;

  dropstruct = dropcpcratefromscriptedheli(undefined, "allies", cratetype, position, (0, randomfloat(360), 0), position, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype(cratetype));

  if(!isDefined(dropstruct))
    return undefined;
  else if(!isDefined(dropstruct.crate))
    return undefined;

  return dropstruct.crate;
}

oncratedrop(dropposition, _id_EA88845C8353CC2E) {
  self endon("death");
  _id_4E0D9C78FA04CDD4 = spawn("script_model", _id_EA88845C8353CC2E.origin);
  _id_4E0D9C78FA04CDD4 setModel("offhand_wm_grenade_smoke");
  _id_4E0D9C78FA04CDD4.angles = (0, 90, 90);
  fxent = spawn("script_model", _id_EA88845C8353CC2E.origin);
  fxent setModel("ks_crate_marker_mp");
  fxent setscriptablepartstate("smoke", "on", 0);
  _id_4E0D9C78FA04CDD4 thread watchforcratecapture(self);
  fxent thread watchforcratecapture(self);

  if(isDefined(self.data) && istrue(self.data._id_6AE5AFA97C7F286C) || istrue(level.cratedropdata._id_6AE5AFA97C7F286C)) {
    return;
  }
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(90);

  if(isDefined(_id_EA88845C8353CC2E.script_noteworthy)) {
    if(isDefined(level.crates_active_at_location[_id_EA88845C8353CC2E.script_noteworthy]))
      level.crates_active_at_location[_id_EA88845C8353CC2E.script_noteworthy] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  if(isDefined(_id_EA88845C8353CC2E.script_linkname)) {
    if(isDefined(level.crates_active_at_location[_id_EA88845C8353CC2E.script_linkname]))
      level.crates_active_at_location[_id_EA88845C8353CC2E.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

watchforcratecapture(crate) {
  self endon("death");
  crate waittill("death");
  self delete();
}

getcpcratedropcaststart(position, _id_5E43D97DFC3D0419) {
  caststart = undefined;

  if(istrue(_id_5E43D97DFC3D0419))
    caststart = position * (1, 1, 0) + (0, 0, getcpscriptedhelidropheight());
  else
    caststart = position + (0, 0, 25);

  return caststart;
}

getcpscriptedhelidropheight() {
  if(isDefined(level.cratedropdata.heliheightoffset)) {
    _id_98EA5AFB293A76A2 = scripts\engine\utility::ter_op(level.cratedropdata.helis.size > 0, level.cratedropdata.helis.size, 1);
    return 3000 + _id_98EA5AFB293A76A2 * level.cratedropdata.heliheightoffset;
  }

  return 3000;
}

dropcpcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data, streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]())
      return undefined;
  }

  _id_EBB5C644A3F5CFBC = getcpcratedropcaststart(position, 1);
  _id_46D5F28D2724BF1F = angles * (0, 1, 0);

  if(!isDefined(destination)) {
    destination = scripts\cp_mp\killstreaks\airdrop::getcratedropdestination(_id_EBB5C644A3F5CFBC, scripts\cp_mp\killstreaks\airdrop::getcratedropcastend(_id_EBB5C644A3F5CFBC, 1));

    if(!isDefined(destination))
      return undefined;
  }

  scenenode = spawn("script_model", _id_EBB5C644A3F5CFBC);
  scenenode.angles = _id_46D5F28D2724BF1F;
  scenenode setModel("tag_origin");
  scenenode.owner = owner;
  scenenode.team = team;
  scenenode.hasowner = isDefined(owner);
  _id_7AA1799A3474E873 = 1;

  if(_id_7AA1799A3474E873) {
    vehicleisreserved = undefined;

    if(isDefined(data))
      vehicleisreserved = data.vehicleisreserved;

    heli = scripts\cp_mp\killstreaks\airdrop::createheli(owner, team, _id_EBB5C644A3F5CFBC, _id_46D5F28D2724BF1F, vehicleisreserved, streakinfo);

    if(!isDefined(heli)) {
      scenenode delete();
      return undefined;
    }

    heli setup_pilot();
    heli.scenenode = heli;
    heli setscriptablepartstate("visibility", "hide", 0);
    heli.animname = "care_package_heli";
    heli thread watch_for_death();
    scenenode.heli = heli;
    scenenode.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
    scenenode.latestanimendtime = scenenode.heliendtime;
  } else
    scenenode.latestanimendtime = gettime();

  crate = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(owner, team, cratetype, destination, undefined, 0, data, streakinfo, scenenode, "care_package", "care_package_drop");

  if(!isDefined(crate))
    return undefined;

  chute = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(scenenode, crate, "care_package_chute", "care_package_drop");

  if(!isDefined(chute))
    return undefined;

  chute setscriptablepartstate("visibility", "hide", 0);

  if(isDefined(scenenode.heli))
    scenenode thread scripts\cp_mp\killstreaks\airdrop::watchdropcratefromscriptedheli();
  else
    scenenode thread _id_3874CA87A68CE263();

  scenenode.crate = crate;
  return scenenode;
}

_id_3874CA87A68CE263() {
  self endon("death");

  foreach(crate in self.crates) {
    scripts\common\anim::anim_last_frame_solo(crate, "care_package_drop");
    scripts\cp_mp\killstreaks\airdrop::docratedropfromscripted(crate);
  }
}

watch_for_death() {
  self waittill("death");

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self.copilot))
    self.copilot delete();
}

setup_pilot() {
  _id_F204DACE25365C76 = "tag_pilot";

  if(!self tagexists(_id_F204DACE25365C76) && self tagexists("tag_pilot1"))
    _id_F204DACE25365C76 = "tag_pilot1";

  if(!self tagexists(_id_F204DACE25365C76)) {
    return;
  }
  _id_535116D8E57C6F31 = (0, 0, -20);
  _id_7595128B0DFBCB5B = (0, 0, 0);
  pilot = spawn("script_model", self gettagorigin(_id_F204DACE25365C76));
  pilot setModel("aq_pilot_fullbody_1");
  pilot linkTo(self, _id_F204DACE25365C76, _id_535116D8E57C6F31, _id_7595128B0DFBCB5B);
  pilot scriptmodelplayanim("vh_blima_rappel_pilot");
  self.pilot = pilot;
}