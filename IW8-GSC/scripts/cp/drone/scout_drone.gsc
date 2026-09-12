/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\scout_drone.gsc
***********************************************/

function init() {
  level.use_scout_drone_func = &deploy_scout_drone;
  level.use_ac130_drone_func = &deploy_ac130_drone;
  level.use_detonate_drone_func = &deploy_scout_detonate_drone;
  load_fx();
}

function craft_scout_drone(var_0) {
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

  if(!isDefined(var_0)) {
    var_0 = make_scout_config();
  }

  thread scripts\cp\drone\utility::deploy_drone(self, var_0);
}

function deploy_scout_drone(var_0) {
  var_1 = make_scout_config();
  thread craft_scout_drone(var_0);
}

function deploy_ac130_drone(var_0) {
  var_1 = make_ac130_drone_config();
  thread craft_scout_drone(var_0);
}

function deploy_scout_detonate_drone(var_0) {
  var_1 = make_scout_detonate_config();
  thread craft_scout_drone(var_0);
}

function deploy_collection_drone(var_0) {
  var_1 = make_collection_config();
  thread craft_scout_drone(var_0);
}

function deploy_scout_drone_generic(var_0) {
  scripts\cp\drone\utility::deploy_drone(var_0, make_scout_config());
}

function make_scout_config() {
  var_0 = spawnStruct();
  var_0.model = "veh8_mil_air_malfa_small";
  var_0.vehicle_info = "veh_radar_drone_recon_mp";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30;
  var_0.use_func = &use_scout_drone;
  var_0.self_destruct = 1;
  var_0.mark_ai = 1;
  var_0.mark_vehicles = 1;
  var_0.play_intro = 1;
  return var_0;
}

function make_ac130_drone_config() {
  var_0 = spawnStruct();
  var_0.model = "veh8_mil_air_malfa_small";
  var_0.vehicle_info = "veh_mine_drone_mp";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30000;
  var_0.use_func = &use_scout_drone;
  var_0.self_destruct = 1;
  var_0.mark_ai = 1;
  var_0.mark_vehicles = 1;
  var_0.play_intro = 0;
  var_0.send_down = 1;
  return var_0;
}

function make_scout_detonate_config() {
  var_0 = spawnStruct();
  var_0.model = "veh8_mil_air_malfa_small";
  var_0.vehicle_info = "veh_mine_drone_mp";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30000;
  var_0.use_func = &use_scout_drone;
  var_0.detonate_mines = 1;
  var_0.play_intro = 0;
  return var_0;
}

function make_collection_config() {
  var_0 = spawnStruct();
  var_0.model = "veh8_mil_air_malfa_small";
  var_0.vehicle_info = "veh_radar_drone_recon_mp";
  var_0.health = 150;
  var_0.speed = 180;
  var_0.accel = 20;
  var_0.timeout = 30;
  var_0.use_func = &use_scout_drone;
  var_0.self_destruct = 1;
  var_0.mark_ai = 1;
  var_0.mark_vehicles = 1;
  var_0.play_intro = 1;
  var_0.no_control = 1;
  return var_0;
}

function use_scout_drone(var_0, var_1) {
  var_1 endon("death");

  foreach(var_3 in level.players) {
    if(var_3 != var_0) {
      var_3 thread scripts\cp\cp_hud_message::showsplash("cp_used_assault_drone", undefined, var_0);
    }
  }

  var_1.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcdmarker", var_0.owner, undefined, 0, 1);
  var_1.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", var_0, var_0, 1);
  thread scout_drone_clean_up(var_1, var_0);

  if(istrue(var_1.mark_ai)) {
    thread scout_drone_mark_npcs();
  }

  if(istrue(var_1.mark_vehicles)) {
    thread scout_drone_markvehicles();
  }

  if(istrue(var_1.self_destruct)) {
    var_0 notifyonplayercommand("deploy_scout_blast", "+usereload");

    for(;;) {
      var_0 thread scripts\cp\utility::hint_prompt("self_destruct", 1);
      var_0 waittill("deploy_scout_blast");
      var_1 radiusdamage(var_1.origin, 160, 180, 10, var_0, "MOD_EXPLOSIVE");
      thread notify_nearby_enemies();
      var_0 thread scripts\cp\utility::hint_prompt("self_destruct", 0);
      break;
    }

    thread delay_exit_drone(var_1, var_0);
    return;
  }

  if(istrue(var_1.detonate_mines)) {
    var_0 notifyonplayercommand("break_drone", "+stance");

    for(;;) {
      var_0 waittill("break_drone");
      thread notify_nearby_enemies();
      break;
    }

    thread delay_exit_drone(var_1, var_0);
    return;
  }
}

function playremotesequence(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp\utility::isusingremote()) {
    return false;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  self notify("play_remote_sequence");
  self playlocalsound("mp_killstreak_tablet_gear");
  var_2 = undefined;

  if(self isonladder() || self ismantling() || !self isonground()) {
    return false;
  }

  var_2 = "ks_remote_device_mp";
  scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
  var_3 = scripts\cp\cp_weapons::switchtoweaponreliable(var_2);

  if(istrue(var_3)) {
    thread scripts\cp\cp_weapons::watchformanualweaponend(var_2);
  } else {
    return false;
  }

  scripts\cp\utility::setusingremote(var_0.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  var_4 = scripts\engine\utility::ref_143B9(1.8, "death");
  self notify("ks_freeze_end");
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();

  if(isDefined(var_2)) {
    self takeweapon(var_2);
  }

  self stoplocalsound("mp_killstreak_tablet_gear");
  return true;
}

function scout_drone_mark_npcs() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(;;) {
    foreach(var_3 in var_1) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var_3 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
        continue;
      }

      if(isbeingmarked(var_3)) {
        continue;
      }

      if(isreconmarked(var_3)) {
        continue;
      }

      if(!isinmarkingrange(var_3)) {
        continue;
      }

      if(!canseetarget(var_3)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var_0, var_3, 70, 50)) {
        thread startmarkingtarget(var_3, "enemy", 0, 1);
      }
    }

    wait 0.05;
  }
}

function canseetarget(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  var_3 = [var_0.origin];

  if(isPlayer(var_0) || isagent(var_0)) {
    var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0.origin];
  }

  var_4 = [self, var_0];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var_3[var_5], var_4, var_2)) {
      continue;
    }

    var_1 = 1;
    break;
  }

  return var_1;
}

function scout_drone_markvehicles(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var_2 = vehicle_getarray();

    foreach(var_4 in var_2) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!isDefined(var_4)) {
        continue;
      }

      if(level.teambased && isDefined(var_4.script_team) && var_4.script_team == self.team) {
        continue;
      } else if(level.teambased && isDefined(var_4.team) && var_4.team == self.team) {
        continue;
      } else if(isDefined(var_4.owner) && var_4.owner == self) {
        continue;
      }

      if(isbeingmarked(var_4)) {
        continue;
      }

      if(isreconmarked(var_4)) {
        continue;
      }

      if(!isinmarkingrange(var_4)) {
        continue;
      }

      if(!canseetarget(var_4)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var_1, var_4, 70, 50)) {
        thread startmarkingtarget(var_4, "equipment", 0, 1);
      }
    }

    wait 0.1;
  }
}

function helperdrone_markequipment(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var_2 = [[level.getactiveequipmentarray]]();

    foreach(var_4 in var_2) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!isDefined(var_4)) {
        continue;
      }

      if(level.teambased && var_4.team == self.team) {
        continue;
      } else if(isDefined(var_4.owner) && var_4.owner == self) {
        continue;
      }

      if(isbeingmarked(var_4)) {
        continue;
      }

      if(isreconmarked(var_4)) {
        continue;
      }

      if(!isinmarkingrange(var_4)) {
        continue;
      }

      if(!canseetarget(var_4)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var_1, var_4, 70, 50)) {
        thread startmarkingtarget(var_4, "equipment", 0, 1);
      }
    }

    waitframe();
  }
}

function helperdrone_markkillstreaks(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var_2 = level.activekillstreaks;

    foreach(var_4 in var_2) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!isDefined(var_4)) {
        continue;
      }

      if(level.teambased && var_4.team == self.team) {
        continue;
      } else if(isDefined(var_4.owner) && var_4.owner == self) {
        continue;
      }

      if(isbeingmarked(var_4)) {
        continue;
      }

      if(isreconmarked(var_4)) {
        continue;
      }

      if(!isinmarkingrange(var_4)) {
        continue;
      }

      if(!canseetarget(var_4)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var_1, var_4, 70, 50)) {
        thread startmarkingtarget(var_4, "killstreak", 0, 1);
      }
    }

    waitframe();
  }
}

function isreconmarked(var_0) {
  return istrue(var_0.reconmarked);
}

function isinouterradius(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_0.targetsinouterradius, var_1);
}

function isbeingmarked(var_0) {
  return isDefined(var_0.beingmarked);
}

function isinmarkingrange(var_0) {
  return distancesquared(self.origin, var_0.origin) < 4000000;
}

function startmarkingtarget(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_5 = self.enemytargetmarkergroup;

  if(!isDefined(var_5)) {
    return;
  }

  if(!isDefined(self.enemiesmarked)) {
    self.enemiesmarked = [];
  }

  var_0.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  self.owner setclientomnvar("cp_scout_drone_controls", 2);
  var_6 = 0.5;

  while(var_6 > 0) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!helperdrone_istargetinreticle(var_4, var_0, 70, 50)) {
      var_0.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("cp_scout_drone_controls", 1);
      return;
    }

    var_6 -= 0.05;
    wait 0.05;
  }

  var_0.reconmarked = 1;
  self.markingtarget = undefined;
  markent(var_0, self, undefined, "end_mark");
  self.owner setclientomnvar("cp_scout_drone_controls", 3);
  self.owner playlocalsound("recondrone_tag");
  scripts\cp\utility::playsoundatpos_safe(var_0.origin, "recondrone_tag");
  targetmarkergroupsetextrastate(self.enemytargetmarkergroup, var_0, 1);
  var_7 = 30;
  var_0 scripts\engine\utility::ref_143BA(var_7, "death", "set_noscopeoutline");

  if(helperdrone_istargetinreticle(var_4, var_0, 70, 150) && !var_0 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
    targetmarkergroupsetextrastate(self.enemytargetmarkergroup, var_0, 0);
  } else {
    targetmarkergroupsetentitystate(self.enemytargetmarkergroup, var_0);
  }

  var_0 notify("end_mark");
}

function resetreticlemarkingprogressstate(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_1 endon("marking_target");
  wait var_0;
  self.owner setclientomnvar("cp_scout_drone_controls", 1);
}

function helperdrone_istargetinreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [var_0.origin];

  if(isPlayer(var_0) || isagent(var_0)) {
    var_4 = [var_0.origin, var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_eye")];
  }

  foreach(var_6 in var_4) {
    if(self worldpointinreticle_circle(var_6, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

function markent(var_0, var_1, var_2, var_3) {
  self.enemiesmarked[self.enemiesmarked.size] = var_0;
  var_4 = var_1.owner;

  if(level.teambased) {
    var_4 = var_1.team;
  }

  var_0 hudoutlineenable(1, 0, 1);
  thread markent_watchmarkingentstatus(var_1);
  thread markent_watchtargetstatus(var_1, var_0, var_2);
}

function markent_getclassperkicon(var_0, var_1) {
  var_2 = var_0;
  var_3 = undefined;

  if(isDefined(var_1.loadoutperks)) {
    foreach(var_5 in var_1.loadoutperks) {
      if(scripts\engine\utility::array_contains(level.perkpackagelist, var_5)) {
        var_3 = var_5;
        break;
      }
    }

    if(isDefined(var_3)) {
      var_2 = level.perktable[var_3].npicon;
    }
  }

  return var_2;
}

function markent_getweaponicon(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1;
  var_5 = spawnStruct();

  if(isDefined(var_2.weapon_name)) {
    var_6 = undefined;

    if(issubstr(var_2.weapon_name, "claymore")) {
      var_6 = "equip_claymore";
    } else if(issubstr(var_2.weapon_name, "c4")) {
      var_6 = "equip_c4";
    } else if(issubstr(var_2.weapon_name, "atMine")) {
      var_6 = "equip_at_mine";
    } else if(issubstr(var_2.weapon_name, "trophy")) {
      var_6 = "equip_trophy";
    }

    if(isDefined(var_6)) {
      var_3 = level.equipment.table[var_6].image;
    }
  } else if(isDefined(var_2.streakinfo)) {
    var_7 = var_2.streakinfo.streakname;
    var_3 = game["killstreakTable"].tabledatabyref[var_7]["overheadIcon"];
    var_4 = 75;
  }

  var_5.weaponicon = var_3;
  var_5.weaponoffset = var_4;
  return var_5;
}

function markent_watchmarkingentstatus(var_0) {
  level endon("game_ended");
  var_0 endon("unmarked");
  scripts\engine\utility::ref_143A6("explode", "death", "leaving");
  wait 3;
  unmark(var_0);
}

function markent_watchtargetstatus(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("unmarked");
  thread resetreticlemarkingprogressstate(0.5);

  if(isDefined(var_1)) {
    var_0 scripts\engine\utility::ref_143BB(var_1, "death", "disconnect", var_2);
  } else {
    var_0 scripts\engine\utility::ref_143A6("death", "disconnect", var_2);
  }

  unmark(var_0);
}

function unmark(var_0) {
  var_0 hudoutlinedisable();

  if(isDefined(var_0)) {
    var_0.reconmarked = undefined;
    var_0.beingmarked = undefined;

    if(isDefined(self)) {
      if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0) {
        self.enemiesmarked = scripts\engine\utility::array_remove(self.enemiesmarked, var_0);
      }
    }

    if(isPlayer(var_0)) {
      var_0 setclientomnvar("ui_rcd_target_notify", 0);
    }

    var_0 notify("unmarked");
    return;
  }

  if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0) {
    self.enemiesmarked = scripts\engine\utility::array_removeundefined(self.enemiesmarked);
    return;
  }
}

function notify_nearby_enemies() {
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, undefined, 1000);

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 notify("bulletwhizby");
      var_3 notify("icon_cancel_delete");
    }
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    var_0 = scripts\cp\utility::getactorsinradius(self.origin, 1000);

    if(var_0.size > 0) {
      foreach(var_6 in var_0) {
        if(isai(var_6)) {
          var_6 notify("bulletwhizby");
          var_6 notify("icon_cancel_delete");
        }
      }

      return;
    }

    return;
  }
}

function delay_exit_drone(var_0, var_1) {
  wait 0.3;

  if(isDefined(var_0)) {
    scripts\cp\drone\utility::exit_drone(var_0, var_1);
  }

  if(isDefined(var_1)) {
    scripts\cp\drone\utility::drone_explode(var_1);
    return;
  }
}

function self_destruct_drone(var_0, var_1) {
  var_2 = 0.3;

  if(isDefined(var_1.extra_drone_delay)) {
    var_2 = var_1.extra_drone_delay;
  }

  if(isDefined(var_1)) {
    playFX(level._effect["vfx_drone_explo"], var_1.origin);
  }

  if(isDefined(var_0)) {
    drone_exit_delayed(var_0, var_1, var_1.extra_drone_delay);
  }

  if(isDefined(var_1)) {
    var_1 delete();
    return;
  }
}

function drone_exit_delayed(var_0, var_1, var_2) {
  if(isent(var_1)) {
    var_1 playSound("recondrone_destroyed");
  }

  if(!isent(var_1)) {
    return;
  }

  scripts\cp\drone\utility::turn_off_drone_hud(var_0);
  var_0 setplayerangles(var_0.pre_drone_angles);
  var_0.using_drone = undefined;
  var_0.disable_map_tablet = undefined;
  wait var_2;
  var_0 remotecontrolvehicleoff();
  var_0 cameraunlink(var_1);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_3 = var_0 scripts\cp\utility::getweapontoswitchbackto();
  var_0 switchtoweapon(var_3);
  var_0 takeweapon("ks_remote_map_cp");
  var_0 scripts\common\utility::allow_weapon(1);
  var_0 scripts\common\utility::allow_usability(1);
  var_0 notify("exiting_drone");
  var_0 notify("exit_mine_drone");
}

function scout_drone_clean_up(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 waittill("death");
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1.enemytargetmarkergroup);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1.friendlytargetmarkergroup);
  var_0 thread scripts\cp\utility::hint_prompt("scout_blast_ready", 0);
  var_0 thread scripts\cp\utility::hint_prompt("scout_hit_target", 0);
  thread delay_nvgs();

  if(isDefined(level.scout_drone_clean_up_func)) {
    level thread[[level.scout_drone_clean_up_func]](var_0, var_1);
    return;
  }
}

function delay_nvgs() {
  wait 0.75;

  if(self.nvg_was_on) {
    self nightvisionviewon();
    return;
  }
}

function load_fx() {
  scripts\cp\drone\utility::load_fx();
}