/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\scout_drone.gsc
***********************************************/

init() {
  level.use_scout_drone_func = ::deploy_scout_drone;
  level.use_ac130_drone_func = ::deploy_ac130_drone;
  level.use_detonate_drone_func = ::deploy_scout_detonate_drone;
  load_fx();
}

craft_scout_drone(_id_D121285BBE12FC18) {
  if(istrue(self.using_drone)) {
    return;
  }
  if(istrue(self.tablet_out)) {
    return;
  }
  self.nvg_was_on = 0;

  if(self isnightvisionon()) {
    self.nvg_was_on = 1;
    self nightvisionviewoff();
  }

  if(!isDefined(_id_D121285BBE12FC18))
    _id_D121285BBE12FC18 = make_scout_config();

  thread scripts\cp\drone\utility::deploy_drone(self, _id_D121285BBE12FC18);
}

deploy_scout_drone(player) {
  _id_D121285BBE12FC18 = make_scout_config();
  player thread craft_scout_drone(_id_D121285BBE12FC18);
}

deploy_ac130_drone(player) {
  _id_D121285BBE12FC18 = make_ac130_drone_config();
  player thread craft_scout_drone(_id_D121285BBE12FC18);
}

deploy_scout_detonate_drone(player) {
  _id_D121285BBE12FC18 = make_scout_detonate_config();
  player thread craft_scout_drone(_id_D121285BBE12FC18);
}

deploy_collection_drone(player) {
  _id_D121285BBE12FC18 = make_collection_config();
  player thread craft_scout_drone(_id_D121285BBE12FC18);
}

deploy_scout_drone_generic(player) {
  scripts\cp\drone\utility::deploy_drone(player, make_scout_config());
}

make_scout_config() {
  _id_5EC28C599676F004 = spawnStruct();
  _id_5EC28C599676F004.model = "veh8_mil_air_malfa_small";
  _id_5EC28C599676F004.vehicle_info = "veh_radar_drone_recon_mp";
  _id_5EC28C599676F004.health = 150;
  _id_5EC28C599676F004.speed = 180;
  _id_5EC28C599676F004.accel = 20;
  _id_5EC28C599676F004.timeout = 30;
  _id_5EC28C599676F004.use_func = ::use_scout_drone;
  _id_5EC28C599676F004.self_destruct = 1;
  _id_5EC28C599676F004.mark_ai = 1;
  _id_5EC28C599676F004.mark_vehicles = 1;
  _id_5EC28C599676F004.play_intro = 1;
  return _id_5EC28C599676F004;
}

make_ac130_drone_config() {
  _id_D65E1B21899D4301 = spawnStruct();
  _id_D65E1B21899D4301.model = "veh8_mil_air_malfa_small";
  _id_D65E1B21899D4301.vehicle_info = "veh_mine_drone_mp";
  _id_D65E1B21899D4301.health = 150;
  _id_D65E1B21899D4301.speed = 180;
  _id_D65E1B21899D4301.accel = 20;
  _id_D65E1B21899D4301.timeout = 30000;
  _id_D65E1B21899D4301.use_func = ::use_scout_drone;
  _id_D65E1B21899D4301.self_destruct = 1;
  _id_D65E1B21899D4301.mark_ai = 1;
  _id_D65E1B21899D4301.mark_vehicles = 1;
  _id_D65E1B21899D4301.play_intro = 0;
  _id_D65E1B21899D4301.send_down = 1;
  return _id_D65E1B21899D4301;
}

make_scout_detonate_config() {
  _id_128843D9CFEF6831 = spawnStruct();
  _id_128843D9CFEF6831.model = "veh8_mil_air_malfa_small";
  _id_128843D9CFEF6831.vehicle_info = "veh_mine_drone_mp";
  _id_128843D9CFEF6831.health = 150;
  _id_128843D9CFEF6831.speed = 180;
  _id_128843D9CFEF6831.accel = 20;
  _id_128843D9CFEF6831.timeout = 30000;
  _id_128843D9CFEF6831.use_func = ::use_scout_drone;
  _id_128843D9CFEF6831.detonate_mines = 1;
  _id_128843D9CFEF6831.play_intro = 0;
  return _id_128843D9CFEF6831;
}

make_collection_config() {
  _id_7E862E1847363F38 = spawnStruct();
  _id_7E862E1847363F38.model = "veh8_mil_air_malfa_small";
  _id_7E862E1847363F38.vehicle_info = "veh_radar_drone_recon_mp";
  _id_7E862E1847363F38.health = 150;
  _id_7E862E1847363F38.speed = 180;
  _id_7E862E1847363F38.accel = 20;
  _id_7E862E1847363F38.timeout = 30;
  _id_7E862E1847363F38.use_func = ::use_scout_drone;
  _id_7E862E1847363F38.self_destruct = 1;
  _id_7E862E1847363F38.mark_ai = 1;
  _id_7E862E1847363F38.mark_vehicles = 1;
  _id_7E862E1847363F38.play_intro = 1;
  _id_7E862E1847363F38.no_control = 1;
  return _id_7E862E1847363F38;
}

use_scout_drone(player, drone) {
  drone endon("death");

  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(_id_AC0E424AC96A7113 != player)
      _id_AC0E424AC96A7113 thread scripts\cp\cp_hud_message::showsplash("cp_used_assault_drone", undefined, player);
  }

  drone.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcdmarker", player.owner, undefined, 0, 1);
  drone.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", player, player, 1);
  drone thread scout_drone_clean_up(player, drone);

  if(istrue(drone.mark_ai))
    drone thread scout_drone_mark_npcs();

  if(istrue(drone.mark_vehicles))
    drone thread scout_drone_markvehicles();

  if(istrue(drone.self_destruct)) {
    player notifyonplayercommand("deploy_scout_blast", "+usereload");

    for(;;) {
      player thread scripts\cp\utility::hint_prompt("self_destruct", 1);
      player waittill("deploy_scout_blast");
      drone radiusdamage(drone.origin, 160, 180, 10, player, "MOD_EXPLOSIVE");
      drone thread notify_nearby_enemies();
      player thread scripts\cp\utility::hint_prompt("self_destruct", 0);
      break;
    }

    drone thread delay_exit_drone(player, drone);
  } else if(istrue(drone.detonate_mines)) {
    player notifyonplayercommand("break_drone", "+stance");

    for(;;) {
      player waittill("break_drone");
      drone thread notify_nearby_enemies();
      break;
    }

    drone thread delay_exit_drone(player, drone);
  }
}

playremotesequence(streakinfo, _id_3CFF035C1ECBD186) {
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp\utility::isusingremote())
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  self notify("play_remote_sequence");
  self playlocalsound("mp_killstreak_tablet_gear");
  _id_608BEF26DD02E2C7 = undefined;

  if(self isonladder() || self ismantling() || !self isonground())
    return 0;

  _id_608BEF26DD02E2C7 = "ks_remote_device_mp";
  scripts\cp\utility::_giveweapon(_id_608BEF26DD02E2C7, 0, 0, 1);
  _id_41BF9BF4918115AC = scripts\cp\cp_weapons::switchtoweaponreliable(_id_608BEF26DD02E2C7);

  if(istrue(_id_41BF9BF4918115AC))
    thread scripts\cp\cp_weapons::watchformanualweaponend(_id_608BEF26DD02E2C7);
  else
    return 0;

  scripts\cp\utility::setusingremote(streakinfo.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  result = scripts\engine\utility::waittill_any_timeout_1(1.8, "death");
  self notify("ks_freeze_end");
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();

  if(isDefined(_id_608BEF26DD02E2C7))
    self takeweapon(_id_608BEF26DD02E2C7);

  self stoplocalsound("mp_killstreak_tablet_gear");
  return 1;
}

scout_drone_mark_npcs() {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(;;) {
    foreach(soldier in _id_FC9AC45209F959BB) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!soldier scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(soldier scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
        continue;
      }
      if(isbeingmarked(soldier)) {
        continue;
      }
      if(isreconmarked(soldier)) {
        continue;
      }
      if(!isinmarkingrange(soldier)) {
        continue;
      }
      if(!canseetarget(soldier)) {
        continue;
      }
      if(_id_6D5A295AE3C46554 helperdrone_istargetinreticle(soldier, 70, 50))
        thread startmarkingtarget(soldier, "enemy", 0, 1);
    }

    wait 0.05;
  }
}

canseetarget(target) {
  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  _id_D895C679F6A927E5 = [target.origin];

  if(isPlayer(target) || isagent(target))
    _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target.origin];

  ignorelist = [self, target];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], ignorelist, contents)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

scout_drone_markvehicles(config) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    _id_84DBB1CE5BD4FA7D = vehicle_getarray();

    foreach(vehicle in _id_84DBB1CE5BD4FA7D) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!isDefined(vehicle)) {
        continue;
      }
      if(level.teambased && isDefined(vehicle.script_team) && vehicle.script_team == self.team)
        continue;
      else if(level.teambased && isDefined(vehicle.team) && vehicle.team == self.team)
        continue;
      else if(isDefined(vehicle.owner) && vehicle.owner == self) {
        continue;
      }
      if(isbeingmarked(vehicle)) {
        continue;
      }
      if(isreconmarked(vehicle)) {
        continue;
      }
      if(!isinmarkingrange(vehicle)) {
        continue;
      }
      if(!canseetarget(vehicle)) {
        continue;
      }
      if(_id_6D5A295AE3C46554 helperdrone_istargetinreticle(vehicle, 70, 50))
        thread startmarkingtarget(vehicle, "equipment", 0, 1);
    }

    wait 0.1;
  }
}

helperdrone_markequipment(config) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    _id_98FA4B76D957B210 = [[level.getactiveequipmentarray]]();

    foreach(equipment in _id_98FA4B76D957B210) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!isDefined(equipment)) {
        continue;
      }
      if(level.teambased && equipment.team == self.team)
        continue;
      else if(isDefined(equipment.owner) && equipment.owner == self) {
        continue;
      }
      if(isbeingmarked(equipment)) {
        continue;
      }
      if(isreconmarked(equipment)) {
        continue;
      }
      if(!isinmarkingrange(equipment)) {
        continue;
      }
      if(!canseetarget(equipment)) {
        continue;
      }
      if(_id_6D5A295AE3C46554 helperdrone_istargetinreticle(equipment, 70, 50))
        thread startmarkingtarget(equipment, "equipment", 0, 1);
    }

    waitframe();
  }
}

helperdrone_markkillstreaks(config) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    _id_6C845D64BE969CE8 = level.activekillstreaks;

    foreach(_id_F406BE343AB9CC93 in _id_6C845D64BE969CE8) {
      if(istrue(self.markingtarget)) {
        continue;
      }
      if(!isDefined(_id_F406BE343AB9CC93)) {
        continue;
      }
      if(level.teambased && _id_F406BE343AB9CC93.team == self.team)
        continue;
      else if(isDefined(_id_F406BE343AB9CC93.owner) && _id_F406BE343AB9CC93.owner == self) {
        continue;
      }
      if(isbeingmarked(_id_F406BE343AB9CC93)) {
        continue;
      }
      if(isreconmarked(_id_F406BE343AB9CC93)) {
        continue;
      }
      if(!isinmarkingrange(_id_F406BE343AB9CC93)) {
        continue;
      }
      if(!canseetarget(_id_F406BE343AB9CC93)) {
        continue;
      }
      if(_id_6D5A295AE3C46554 helperdrone_istargetinreticle(_id_F406BE343AB9CC93, 70, 50))
        thread startmarkingtarget(_id_F406BE343AB9CC93, "killstreak", 0, 1);
    }

    waitframe();
  }
}

isreconmarked(target) {
  return istrue(target.reconmarked);
}

isinouterradius(_id_8CA2917CFE80042E, target) {
  return scripts\engine\utility::array_contains(_id_8CA2917CFE80042E.targetsinouterradius, target);
}

isbeingmarked(target) {
  return isDefined(target.beingmarked);
}

isinmarkingrange(target) {
  return distancesquared(self.origin, target.origin) < 4000000;
}

startmarkingtarget(target, _id_39E02A8A79B6BA4C, _id_CAD4997EBDA279C7, useoutline) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  _id_C8462289EDFC0ACA = self.enemytargetmarkergroup;

  if(!isDefined(_id_C8462289EDFC0ACA)) {
    return;
  }
  if(!isDefined(self.enemiesmarked))
    self.enemiesmarked = [];

  target.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  self.owner setclientomnvar("cp_scout_drone_controls", 2);
  _id_2095B8A1AFAAF65E = 0.5;

  while(_id_2095B8A1AFAAF65E > 0) {
    if(!isDefined(target)) {
      return;
    }
    if(!_id_6D5A295AE3C46554 helperdrone_istargetinreticle(target, 70, 50)) {
      target.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("cp_scout_drone_controls", 1);
      return;
    }

    _id_2095B8A1AFAAF65E = _id_2095B8A1AFAAF65E - 0.05;
    wait 0.05;
  }

  target.reconmarked = 1;
  self.markingtarget = undefined;
  markent(target, self, undefined, "end_mark");
  self.owner setclientomnvar("cp_scout_drone_controls", 3);
  self.owner playlocalsound("recondrone_tag");
  scripts\cp\utility::playsoundatpos_safe(target.origin, "recondrone_tag");
  targetmarkergroupsetentitystate(self.enemytargetmarkergroup, target, 1);
  timeout = 30;
  target scripts\engine\utility::waittill_any_timeout_2(timeout, "death", "set_noscopeoutline");

  if(_id_6D5A295AE3C46554 helperdrone_istargetinreticle(target, 70, 150) && !target scripts\cp\utility::_hasperk("specialty_noscopeoutline"))
    targetmarkergroupsetentitystate(self.enemytargetmarkergroup, target, 0);
  else
    targetmarkergroupremoveentity(self.enemytargetmarkergroup, target);

  target notify("end_mark");
}

resetreticlemarkingprogressstate(_id_74B5B12BB6514385) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  _id_6D5A295AE3C46554 endon("marking_target");
  wait(_id_74B5B12BB6514385);
  self.owner setclientomnvar("cp_scout_drone_controls", 1);
}

helperdrone_istargetinreticle(_id_D89F028A5C8DB805, _id_C6CFD7BE26D2C7DF, _id_5E43B44751D01B1A) {
  _id_9B96536B85A38BC6 = 0;
  _id_20C094516733FFB1 = [_id_D89F028A5C8DB805.origin];

  if(isPlayer(_id_D89F028A5C8DB805) || isagent(_id_D89F028A5C8DB805))
    _id_20C094516733FFB1 = [_id_D89F028A5C8DB805.origin, _id_D89F028A5C8DB805 gettagorigin("j_mainroot"), _id_D89F028A5C8DB805 gettagorigin("tag_eye")];

  foreach(point in _id_20C094516733FFB1) {
    if(self worldpointinreticle_circle(point, _id_C6CFD7BE26D2C7DF, _id_5E43B44751D01B1A)) {
      _id_9B96536B85A38BC6 = 1;
      break;
    }
  }

  return _id_9B96536B85A38BC6;
}

markent(target, drone, timeout, notifytoendmark) {
  self.enemiesmarked[self.enemiesmarked.size] = target;
  showto = drone.owner;

  if(level.teambased)
    showto = drone.team;

  target hudoutlineenable(1, 0, 1);
  drone thread markent_watchmarkingentstatus(target);
  drone thread markent_watchtargetstatus(target, timeout, notifytoendmark);
}

markent_getclassperkicon(_id_BB093C5BEBC99B6F, target) {
  _id_5C6B6249312F5AEA = _id_BB093C5BEBC99B6F;
  _id_235F68A2F521DFF3 = undefined;

  if(isDefined(target.loadoutperks)) {
    foreach(perk in target.loadoutperks) {
      if(scripts\engine\utility::array_contains(level.perkpackagelist, perk)) {
        _id_235F68A2F521DFF3 = perk;
        break;
      }
    }

    if(isDefined(_id_235F68A2F521DFF3))
      _id_5C6B6249312F5AEA = level._id_A1AD2758FCBD2F5E[_id_235F68A2F521DFF3].npicon;
  }

  return _id_5C6B6249312F5AEA;
}

markent_getweaponicon(_id_BB093C5BEBC99B6F, _id_2F3CF0914D78AC25, target) {
  weaponicon = _id_BB093C5BEBC99B6F;
  weaponoffset = _id_2F3CF0914D78AC25;
  _id_558774275543A708 = spawnStruct();

  if(isDefined(target.weapon_name)) {
    weaponref = undefined;

    if(issubstr(target.weapon_name, "claymore"))
      weaponref = "equip_claymore";
    else if(issubstr(target.weapon_name, "c4"))
      weaponref = "equip_c4";
    else if(issubstr(target.weapon_name, "atMine"))
      weaponref = "equip_at_mine";
    else if(issubstr(target.weapon_name, "trophy"))
      weaponref = "equip_trophy";

    if(isDefined(weaponref))
      weaponicon = level.equipment.table[weaponref].image;
  } else if(isDefined(target.streakinfo)) {
    _id_2B7CF61AF0CB9960 = target.streakinfo.streakname;
    _id_CBAB602E6919AAD7 = level._id_0B23156D776B1D85._id_038F2A11237246AC[_id_2B7CF61AF0CB9960];
    weaponicon = scripts\engine\utility::ter_op(isDefined(_id_CBAB602E6919AAD7) && isDefined(_id_CBAB602E6919AAD7._id_890BC2DE5DEADF64), _id_CBAB602E6919AAD7._id_890BC2DE5DEADF64, "");
    weaponoffset = 75;
  }

  _id_558774275543A708.weaponicon = weaponicon;
  _id_558774275543A708.weaponoffset = weaponoffset;
  return _id_558774275543A708;
}

markent_watchmarkingentstatus(target) {
  level endon("game_ended");
  target endon("unmarked");
  scripts\engine\utility::waittill_any_3("explode", "death", "leaving");
  wait 3;
  unmark(target);
}

markent_watchtargetstatus(target, timeout, notifytoendmark) {
  level endon("game_ended");
  target endon("unmarked");
  thread resetreticlemarkingprogressstate(0.5);

  if(isDefined(timeout))
    target scripts\engine\utility::waittill_any_timeout_3(timeout, "death", "disconnect", notifytoendmark);
  else
    target scripts\engine\utility::waittill_any_3("death", "disconnect", notifytoendmark);

  unmark(target);
}

unmark(target) {
  target hudoutlinedisable();

  if(isDefined(target)) {
    target.reconmarked = undefined;
    target.beingmarked = undefined;

    if(isDefined(self)) {
      if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0)
        self.enemiesmarked = scripts\engine\utility::array_remove(self.enemiesmarked, target);
    }

    if(isPlayer(target))
      target setclientomnvar("ui_rcd_target_notify", 0);

    target notify("unmarked");
  } else if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0)
    self.enemiesmarked = scripts\engine\utility::array_removeundefined(self.enemiesmarked);
}

notify_nearby_enemies() {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_4CF33B57655A86C3 = scripts\engine\utility::get_array_of_closest(self.origin, enemies, undefined, undefined, 1000);

  foreach(enemy in _id_4CF33B57655A86C3) {
    if(isDefined(enemy)) {
      enemy notify("bulletwhizby");
      enemy notify("icon_cancel_delete");
    }
  }

  if(!isDefined(_id_4CF33B57655A86C3) || _id_4CF33B57655A86C3.size == 0) {
    enemies = getaiarrayinradius(self.origin, 1000);

    if(enemies.size > 0) {
      foreach(actor in enemies) {
        if(isai(actor)) {
          actor notify("bulletwhizby");
          actor notify("icon_cancel_delete");
        }
      }
    }
  }
}

delay_exit_drone(player, drone) {
  wait 0.3;

  if(isDefined(player))
    scripts\cp\drone\utility::exit_drone(player, drone);

  if(isDefined(drone))
    scripts\cp\drone\utility::drone_explode(drone);
}

self_destruct_drone(player, drone) {
  delay = 0.3;

  if(isDefined(drone.extra_drone_delay))
    delay = drone.extra_drone_delay;

  if(isDefined(drone))
    playFX(level._effect["vfx_drone_explo"], drone.origin);

  if(isDefined(player))
    drone_exit_delayed(player, drone, drone.extra_drone_delay);

  if(isDefined(drone))
    drone delete();
}

drone_exit_delayed(player, drone, delay) {
  if(isent(drone))
    drone playSound("recondrone_destroyed");

  if(!isent(drone)) {
    return;
  }
  scripts\cp\drone\utility::turn_off_drone_hud(player);
  player setplayerangles(player.pre_drone_angles);
  player.using_drone = undefined;
  player.disable_map_tablet = undefined;
  wait(delay);
  player remotecontrolvehicleoff();
  player cameraunlink(drone);
  player _id_3B64EB40368C1450::set("drone", "weapon_switch", 1);
  _id_929E81472980EC28 = player scripts\cp\utility::getweapontoswitchbackto();
  player switchtoweapon(_id_929E81472980EC28);
  player takeweapon("ks_remote_map_cp");
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("drone");
  player notify("exiting_drone");
  player notify("exit_mine_drone");
}

scout_drone_clean_up(player, drone) {
  player endon("disconnect");
  drone waittill("death");
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(drone.enemytargetmarkergroup);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(drone.friendlytargetmarkergroup);
  player thread scripts\cp\utility::hint_prompt("scout_blast_ready", 0);
  player thread scripts\cp\utility::hint_prompt("scout_hit_target", 0);
  player thread delay_nvgs();

  if(isDefined(level.scout_drone_clean_up_func))
    level thread[[level.scout_drone_clean_up_func]](player, drone);
}

delay_nvgs() {
  wait 0.75;

  if(self.nvg_was_on)
    self nightvisionviewon();
}

load_fx() {
  scripts\cp\drone\utility::load_fx();
}