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

function craft_scout_drone(var0) {
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

  if(!isDefined(var0)) {
    var0 = make_scout_config();
  }

  thread scripts\cp\drone\utility::deploy_drone(self, var0);
}

function deploy_scout_drone(var0) {
  var1 = make_scout_config();
  thread craft_scout_drone(var0);
}

function deploy_ac130_drone(var0) {
  var1 = make_ac130_drone_config();
  thread craft_scout_drone(var0);
}

function deploy_scout_detonate_drone(var0) {
  var1 = make_scout_detonate_config();
  thread craft_scout_drone(var0);
}

function deploy_collection_drone(var0) {
  var1 = make_collection_config();
  thread craft_scout_drone(var0);
}

function deploy_scout_drone_generic(var0) {
  scripts\cp\drone\utility::deploy_drone(var0, make_scout_config());
}

function make_scout_config() {
  var0 = spawnStruct();
  var0.model = "veh8_mil_air_malfa_small";
  var0.vehicle_info = "veh_radar_drone_recon_mp";
  var0.health = 150;
  var0.speed = 180;
  var0.accel = 20;
  var0.timeout = 30;
  var0.use_func = &use_scout_drone;
  var0.self_destruct = 1;
  var0.mark_ai = 1;
  var0.mark_vehicles = 1;
  var0.play_intro = 1;
  return var0;
}

function make_ac130_drone_config() {
  var0 = spawnStruct();
  var0.model = "veh8_mil_air_malfa_small";
  var0.vehicle_info = "veh_mine_drone_mp";
  var0.health = 150;
  var0.speed = 180;
  var0.accel = 20;
  var0.timeout = 30000;
  var0.use_func = &use_scout_drone;
  var0.self_destruct = 1;
  var0.mark_ai = 1;
  var0.mark_vehicles = 1;
  var0.play_intro = 0;
  var0.send_down = 1;
  return var0;
}

function make_scout_detonate_config() {
  var0 = spawnStruct();
  var0.model = "veh8_mil_air_malfa_small";
  var0.vehicle_info = "veh_mine_drone_mp";
  var0.health = 150;
  var0.speed = 180;
  var0.accel = 20;
  var0.timeout = 30000;
  var0.use_func = &use_scout_drone;
  var0.detonate_mines = 1;
  var0.play_intro = 0;
  return var0;
}

function make_collection_config() {
  var0 = spawnStruct();
  var0.model = "veh8_mil_air_malfa_small";
  var0.vehicle_info = "veh_radar_drone_recon_mp";
  var0.health = 150;
  var0.speed = 180;
  var0.accel = 20;
  var0.timeout = 30;
  var0.use_func = &use_scout_drone;
  var0.self_destruct = 1;
  var0.mark_ai = 1;
  var0.mark_vehicles = 1;
  var0.play_intro = 1;
  var0.no_control = 1;
  return var0;
}

function use_scout_drone(var0, var1) {
  var1 endon("death");

  foreach(var3 in level.players) {
    if(var3 != var0) {
      var3 thread scripts\cp\cp_hud_message::showsplash("cp_used_assault_drone", undefined, var0);
    }
  }

  var1.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcdmarker", var0.owner, undefined, 0, 1);
  var1.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", var0, var0, 1);
  thread scout_drone_clean_up(var1, var0);

  if(istrue(var1.mark_ai)) {
    thread scout_drone_mark_npcs();
  }

  if(istrue(var1.mark_vehicles)) {
    thread scout_drone_markvehicles();
  }

  if(istrue(var1.self_destruct)) {
    var0 notifyonplayercommand("deploy_scout_blast", "+usereload");

    for(;;) {
      var0 thread scripts\cp\utility::hint_prompt("self_destruct", 1);
      var0 waittill("deploy_scout_blast");
      var1 radiusdamage(var1.origin, 160, 180, 10, var0, "MOD_EXPLOSIVE");
      thread notify_nearby_enemies();
      var0 thread scripts\cp\utility::hint_prompt("self_destruct", 0);
      break;
    }

    thread delay_exit_drone(var1, var0);
    return;
  }

  if(istrue(var1.detonate_mines)) {
    var0 notifyonplayercommand("break_drone", "+stance");

    for(;;) {
      var0 waittill("break_drone");
      thread notify_nearby_enemies();
      break;
    }

    thread delay_exit_drone(var1, var0);
    return;
  }
}

function playremotesequence(var0, var1) {
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
  var2 = undefined;

  if(self isonladder() || self ismantling() || !self isonground()) {
    return false;
  }

  var2 = "ks_remote_device_mp";
  scripts\cp\utility::_giveweapon(var2, 0, 0, 1);
  var3 = scripts\cp\cp_weapons::switchtoweaponreliable(var2);

  if(istrue(var3)) {
    thread scripts\cp\cp_weapons::watchformanualweaponend(var2);
  } else {
    return false;
  }

  scripts\cp\utility::setusingremote(var0.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  var4 = scripts\engine\utility::ref_143b9(1.8, "death");
  self notify("ks_freeze_end");
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();

  if(isDefined(var2)) {
    self takeweapon(var2);
  }

  self stoplocalsound("mp_killstreak_tablet_gear");
  return true;
}

function scout_drone_mark_npcs() {
  var0 = self.owner;
  var0 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(;;) {
    foreach(var3 in var1) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!var3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var3 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
        continue;
      }

      if(isbeingmarked(var3)) {
        continue;
      }

      if(isreconmarked(var3)) {
        continue;
      }

      if(!isinmarkingrange(var3)) {
        continue;
      }

      if(!canseetarget(var3)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var0, var3, 70, 50)) {
        thread startmarkingtarget(var3, "enemy", 0, 1);
      }
    }

    wait 0.05;
  }
}

function canseetarget(var0) {
  var1 = 0;
  var2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  var3 = [var0.origin];

  if(isPlayer(var0) || isagent(var0)) {
    var3 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0.origin];
  }

  var4 = [self, var0];

  for(var5 = 0; var5 < var3.size; var5++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var3[var5], var4, var2)) {
      continue;
    }

    var1 = 1;
    break;
  }

  return var1;
}

function scout_drone_markvehicles(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var2 = vehicle_getarray();

    foreach(var4 in var2) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!isDefined(var4)) {
        continue;
      }

      if(level.teambased && isDefined(var4.script_team) && var4.script_team == self.team) {
        continue;
      } else if(level.teambased && isDefined(var4.team) && var4.team == self.team) {
        continue;
      } else if(isDefined(var4.owner) && var4.owner == self) {
        continue;
      }

      if(isbeingmarked(var4)) {
        continue;
      }

      if(isreconmarked(var4)) {
        continue;
      }

      if(!isinmarkingrange(var4)) {
        continue;
      }

      if(!canseetarget(var4)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var1, var4, 70, 50)) {
        thread startmarkingtarget(var4, "equipment", 0, 1);
      }
    }

    wait 0.1;
  }
}

function helperdrone_markequipment(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var2 = [[level.getactiveequipmentarray]]();

    foreach(var4 in var2) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!isDefined(var4)) {
        continue;
      }

      if(level.teambased && var4.team == self.team) {
        continue;
      } else if(isDefined(var4.owner) && var4.owner == self) {
        continue;
      }

      if(isbeingmarked(var4)) {
        continue;
      }

      if(isreconmarked(var4)) {
        continue;
      }

      if(!isinmarkingrange(var4)) {
        continue;
      }

      if(!canseetarget(var4)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var1, var4, 70, 50)) {
        thread startmarkingtarget(var4, "equipment", 0, 1);
      }
    }

    waitframe();
  }
}

function helperdrone_markkillstreaks(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    var2 = level.activekillstreaks;

    foreach(var4 in var2) {
      if(istrue(self.markingtarget)) {
        continue;
      }

      if(!isDefined(var4)) {
        continue;
      }

      if(level.teambased && var4.team == self.team) {
        continue;
      } else if(isDefined(var4.owner) && var4.owner == self) {
        continue;
      }

      if(isbeingmarked(var4)) {
        continue;
      }

      if(isreconmarked(var4)) {
        continue;
      }

      if(!isinmarkingrange(var4)) {
        continue;
      }

      if(!canseetarget(var4)) {
        continue;
      }

      if(helperdrone_istargetinreticle(var1, var4, 70, 50)) {
        thread startmarkingtarget(var4, "killstreak", 0, 1);
      }
    }

    waitframe();
  }
}

function isreconmarked(var0) {
  return istrue(var0.reconmarked);
}

function isinouterradius(var0, var1) {
  return scripts\engine\utility::array_contains(var0.targetsinouterradius, var1);
}

function isbeingmarked(var0) {
  return isDefined(var0.beingmarked);
}

function isinmarkingrange(var0) {
  return distancesquared(self.origin, var0.origin) < 4000000;
}

function startmarkingtarget(var0, var1, var2, var3) {
  var4 = self.owner;
  var4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var5 = self.enemytargetmarkergroup;

  if(!isDefined(var5)) {
    return;
  }

  if(!isDefined(self.enemiesmarked)) {
    self.enemiesmarked = [];
  }

  var0.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  self.owner setclientomnvar("cp_scout_drone_controls", 2);
  var6 = 0.5;

  while(var6 > 0) {
    if(!isDefined(var0)) {
      return;
    }

    if(!helperdrone_istargetinreticle(var4, var0, 70, 50)) {
      var0.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("cp_scout_drone_controls", 1);
      return;
    }

    var6 -= 0.05;
    wait 0.05;
  }

  var0.reconmarked = 1;
  self.markingtarget = undefined;
  markent(var0, self, undefined, "end_mark");
  self.owner setclientomnvar("cp_scout_drone_controls", 3);
  self.owner playlocalsound("recondrone_tag");
  scripts\cp\utility::playsoundatpos_safe(var0.origin, "recondrone_tag");
  targetmarkergroupsetextrastate(self.enemytargetmarkergroup, var0, 1);
  var7 = 30;
  var0 scripts\engine\utility::ref_143ba(var7, "death", "set_noscopeoutline");

  if(helperdrone_istargetinreticle(var4, var0, 70, 150) && !var0 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
    targetmarkergroupsetextrastate(self.enemytargetmarkergroup, var0, 0);
  } else {
    targetmarkergroupsetentitystate(self.enemytargetmarkergroup, var0);
  }

  var0 notify("end_mark");
}

function resetreticlemarkingprogressstate(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var1 = self.owner;
  var1 endon("disconnect");
  var1 endon("marking_target");
  wait var0;
  self.owner setclientomnvar("cp_scout_drone_controls", 1);
}

function helperdrone_istargetinreticle(var0, var1, var2) {
  var3 = 0;
  var4 = [var0.origin];

  if(isPlayer(var0) || isagent(var0)) {
    var4 = [var0.origin, var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_eye")];
  }

  foreach(var6 in var4) {
    if(self worldpointinreticle_circle(var6, var1, var2)) {
      var3 = 1;
      break;
    }
  }

  return var3;
}

function markent(var0, var1, var2, var3) {
  self.enemiesmarked[self.enemiesmarked.size] = var0;
  var4 = var1.owner;

  if(level.teambased) {
    var4 = var1.team;
  }

  var0 hudoutlineenable(1, 0, 1);
  thread markent_watchmarkingentstatus(var1);
  thread markent_watchtargetstatus(var1, var0, var2);
}

function markent_getclassperkicon(var0, var1) {
  var2 = var0;
  var3 = undefined;

  if(isDefined(var1.loadoutperks)) {
    foreach(var5 in var1.loadoutperks) {
      if(scripts\engine\utility::array_contains(level.perkpackagelist, var5)) {
        var3 = var5;
        break;
      }
    }

    if(isDefined(var3)) {
      var2 = level.perktable[var3].npicon;
    }
  }

  return var2;
}

function markent_getweaponicon(var0, var1, var2) {
  var3 = var0;
  var4 = var1;
  var5 = spawnStruct();

  if(isDefined(var2.weapon_name)) {
    var6 = undefined;

    if(issubstr(var2.weapon_name, "claymore")) {
      var6 = "equip_claymore";
    } else if(issubstr(var2.weapon_name, "c4")) {
      var6 = "equip_c4";
    } else if(issubstr(var2.weapon_name, "atMine")) {
      var6 = "equip_at_mine";
    } else if(issubstr(var2.weapon_name, "trophy")) {
      var6 = "equip_trophy";
    }

    if(isDefined(var6)) {
      var3 = level.equipment.table[var6].image;
    }
  } else if(isDefined(var2.streakinfo)) {
    var7 = var2.streakinfo.streakname;
    var3 = game["killstreakTable"].tabledatabyref[var7]["overheadIcon"];
    var4 = 75;
  }

  var5.weaponicon = var3;
  var5.weaponoffset = var4;
  return var5;
}

function markent_watchmarkingentstatus(var0) {
  level endon("game_ended");
  var0 endon("unmarked");
  scripts\engine\utility::ref_143a6("explode", "death", "leaving");
  wait 3;
  unmark(var0);
}

function markent_watchtargetstatus(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("unmarked");
  thread resetreticlemarkingprogressstate(0.5);

  if(isDefined(var1)) {
    var0 scripts\engine\utility::ref_143bb(var1, "death", "disconnect", var2);
  } else {
    var0 scripts\engine\utility::ref_143a6("death", "disconnect", var2);
  }

  unmark(var0);
}

function unmark(var0) {
  var0 hudoutlinedisable();

  if(isDefined(var0)) {
    var0.reconmarked = undefined;
    var0.beingmarked = undefined;

    if(isDefined(self)) {
      if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0) {
        self.enemiesmarked = scripts\engine\utility::array_remove(self.enemiesmarked, var0);
      }
    }

    if(isPlayer(var0)) {
      var0 setclientomnvar("ui_rcd_target_notify", 0);
    }

    var0 notify("unmarked");
    return;
  }

  if(isDefined(self.enemiesmarked) && self.enemiesmarked.size > 0) {
    self.enemiesmarked = scripts\engine\utility::array_removeundefined(self.enemiesmarked);
    return;
  }
}

function notify_nearby_enemies() {
  var0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var1 = scripts\engine\utility::get_array_of_closest(self.origin, var0, undefined, undefined, 1000);

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      var3 notify("bulletwhizby");
      var3 notify("icon_cancel_delete");
    }
  }

  if(!isDefined(var1) || var1.size == 0) {
    var0 = scripts\cp\utility::getactorsinradius(self.origin, 1000);

    if(var0.size > 0) {
      foreach(var6 in var0) {
        if(isai(var6)) {
          var6 notify("bulletwhizby");
          var6 notify("icon_cancel_delete");
        }
      }

      return;
    }

    return;
  }
}

function delay_exit_drone(var0, var1) {
  wait 0.3;

  if(isDefined(var0)) {
    scripts\cp\drone\utility::exit_drone(var0, var1);
  }

  if(isDefined(var1)) {
    scripts\cp\drone\utility::drone_explode(var1);
    return;
  }
}

function self_destruct_drone(var0, var1) {
  var2 = 0.3;

  if(isDefined(var1.extra_drone_delay)) {
    var2 = var1.extra_drone_delay;
  }

  if(isDefined(var1)) {
    playFX(level._effect["vfx_drone_explo"], var1.origin);
  }

  if(isDefined(var0)) {
    drone_exit_delayed(var0, var1, var1.extra_drone_delay);
  }

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function drone_exit_delayed(var0, var1, var2) {
  if(isent(var1)) {
    var1 playSound("recondrone_destroyed");
  }

  if(!isent(var1)) {
    return;
  }

  scripts\cp\drone\utility::turn_off_drone_hud(var0);
  var0 setplayerangles(var0.pre_drone_angles);
  var0.using_drone = undefined;
  var0.disable_map_tablet = undefined;
  wait var2;
  var0 remotecontrolvehicleoff();
  var0 cameraunlink(var1);
  var0 scripts\common\utility::allow_weapon_switch(1);
  var3 = var0 scripts\cp\utility::getweapontoswitchbackto();
  var0 switchtoweapon(var3);
  var0 takeweapon("ks_remote_map_cp");
  var0 scripts\common\utility::allow_weapon(1);
  var0 scripts\common\utility::allow_usability(1);
  var0 notify("exiting_drone");
  var0 notify("exit_mine_drone");
}

function scout_drone_clean_up(var0, var1) {
  var0 endon("disconnect");
  var1 waittill("death");
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var1.enemytargetmarkergroup);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var1.friendlytargetmarkergroup);
  var0 thread scripts\cp\utility::hint_prompt("scout_blast_ready", 0);
  var0 thread scripts\cp\utility::hint_prompt("scout_hit_target", 0);
  thread delay_nvgs();

  if(isDefined(level.scout_drone_clean_up_func)) {
    level thread[[level.scout_drone_clean_up_func]](var0, var1);
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