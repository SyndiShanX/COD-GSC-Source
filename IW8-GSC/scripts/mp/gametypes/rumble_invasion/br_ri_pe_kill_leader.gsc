/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader.gsc
*************************************************************************/

function init() {
  level.start_reach_exhaust_waste.verbal_clip = spawnStruct();
  level.start_reach_exhaust_waste.verbal_clip.active = 0;
  level.start_reach_exhaust_waste.verbal_clip.duration = getdvarint("scr_ri_pe_kill_leader_duration", 120);
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_kill_leader_weight", 1);
  var_0.attackerswaittime = &attackerswaittime;
  var_0.ref_140cf = &ref_140cf;
  var_0.ref_14382 = &ref_14382;
  var_0.ref_11b78 = getdvarint("scr_br_pe_kill_leader_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("kill_leader", "10 5 0 0 0 0 0 0");
  scripts\mp\gametypes\br_publicevents::ref_12b35(100, var_0);
}

function ref_140cf() {
  return false;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function forest_combat() {
  var_0 = getdvarfloat("scr_ri_pe_kill_leader_starttime_min", 795);
  var_1 = getdvarfloat("scr_ri_pe_kill_leader_starttime_max", 1110);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function attackerswaittime() {
  level endon("game_ended");

  if(!istrue(level.start_reach_exhaust_waste.verbal_clip.inited)) {
    ref_12af3(level.start_reach_exhaust_waste.verbal_clip);
    level.start_reach_exhaust_waste.verbal_clip.inited = 1;
  }

  if(getdvarint("scr_ri_skip_event_wait_times", 0) == 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("hvt_incoming", 0);
    scripts\mp\gametypes\br_publicevents::ref_13371("br_ri_pe_kill_leader_event_incoming");
    wait 20;
  }

  level.start_reach_exhaust_waste.verbal_clip.active = 1;
  level.start_reach_exhaust_waste.verbal_clip.ref_13009 = [];
  ref_12338(level.start_reach_exhaust_waste.verbal_clip);
  wait 3;
  thread ref_13ef0();
  thread oceanrock();
}

function onriskplayerdisconnect() {
  if(!isDefined(level.start_reach_exhaust_waste.verbal_clip.ref_13009)) {
    return;
  }

  var_2 = 500;
  var_3 = undefined;

  foreach(var_5 in level.start_reach_exhaust_waste.verbal_clip.ref_13009) {
      if(var_5.team == var_0.team && var_5 != var_0) {
        var_6 = distance2d(var_5.origin, var_1.origin) < var_2;
        var_7 = abs(var_5.origin[2] - var_1.origin[2]) < 500;
        var_8 = var_6 && var_7;
        var_9 = distance2d(var_5.origin, var_1.origin) < var_2;
        var_10 = abs(var_5.origin[2] - var_1.origin[2]) < 500;
        var_11 = var_9 && var_10;

        if(var_8 || var_11) {
          var_0 thread scripts\mp\rank::giverankxp("rumble_hvt_defend_kill", int(50), var_0 getcurrentprimaryweapon());
          var_0 thread scripts\mp\rank::scoreeventpopup("rumble_hvt_defend_kill");
          break;
        }
      }
    }

    <
    error > = undefined;
  var_0 = undefined;
}

function oceanrock() {
  level endon("game_ended");
  self endon("event_end");
  var_0 = gettime() + (level.start_reach_exhaust_waste.verbal_clip.duration - 3) * 1000;
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();
  level.start_reach_exhaust_waste.verbal_clip.heli_arrived = var_1;
  setomnvar("ui_publicevent_timer_type", 3);
  setomnvar("ui_publicevent_timer", var_0);
  wait level.start_reach_exhaust_waste.verbal_clip.duration - 5 - 3;

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1 playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  thread obj_room_fire_10();
}

function obj_room_fire_10(var_0, var_1) {
  level endon("game_ended");
  level.start_reach_exhaust_waste.verbal_clip.active = 0;

  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(isDefined(level.start_reach_exhaust_waste.verbal_clip.heli_arrived)) {
    level.start_reach_exhaust_waste.verbal_clip.heli_arrived delete();
  }

  setomnvar("ui_publicevent_timer_type", 0);
  var_2 = obj_tugofwar_drain_speed();
  var_3 = "br_ri_pe_kill_leader_event_end_early_contested";
  var_4 = var_0 == "hvt_team_wiped" && var_2 != "contested";

  foreach(var_6 in level.players) {
    if(var_4) {
      if(var_6.team == var_2) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_all_enemies_down", var_6, 0);
        var_3 = "br_ri_pe_kill_leader_event_end_early_eliminated_enemy";
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_all_friendlies_down", var_6, 0);
        var_3 = "br_ri_pe_kill_leader_event_end_early_eliminated_ally";
      }
    }

    scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_12425(var_6, var_3);
  }

  obj_vindia(level.start_reach_exhaust_waste);
  ref_13ee6();
  level.start_reach_exhaust_waste.verbal_clip.ref_13009 = [];
  self notify("event_end");
}

function obj_room_fire_07() {
  var_0 = obj_running_exfil_wave();
  var_1 = var_0["axis"];
  var_2 = var_0["allies"];

  if(var_1 == 0 || var_2 == 0 || level.start_reach_exhaust_waste.verbal_clip.ref_13009.size == 0) {
    var_3 = 0;
    var_4 = undefined;
    thread obj_room_fire_10(level.start_reach_exhaust_waste.verbal_clip, "hvt_team_wiped");
    return;
  }
}

function obj_running_exfil_wave() {
  var_0 = 0;
  var_1 = 0;
  var_2 = [];
  GscBinSkip0(0x2e, "axis", 0);
}

function obj_tugofwar_drain_speed() {
  var_0 = obj_running_exfil_wave();
  var_1 = var_0["axis"];
  var_2 = var_0["allies"];

  if(var_1 == var_2) {
    return "contested";
  }

  return scripts\engine\utility::ter_op(var_1 > var_2, "axis", "allies");
}

function obj_vindia() {
  foreach(var_1 in level.start_reach_exhaust_waste.verbal_clip.ref_13009) {
    ref_12bd8(var_1);
    ref_12bd7(var_1);
    var_1.verbal_string.trial_thermite_watcher = 0;
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1.team, 5, 0);
    var_1 thread scripts\mp\gametypes\br_plunder::ref_12627(50);
    thread objectivetext();
  }
}

function objectivetext() {
  self endon("death_or_disconnect");
  wait 4;
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_survived", self, 0);
  scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_12425(self, "br_ri_pe_kill_leader_event_survived_player", 5);
  thread scripts\mp\rank::giverankxp("rumble_hvt_survivor", 250, self getcurrentprimaryweapon());
  thread scripts\mp\rank::scoreeventpopup("rumble_hvt_survivor");
}

function ref_13ef0() {
  var_0 = obj_running_exfil_wave();
  var_1 = var_0["axis"];
  var_2 = var_0["allies"];

  foreach(var_4 in level.players) {
    if(isDefined(var_4)) {
      switch (var_4.team) {
        case "axis":
          var_5 = scripts\engine\utility::string(var_1) + scripts\engine\utility::string(var_2) + scripts\engine\utility::string(1);
          var_4 setclientomnvar("rebirth_tracked_teams", int(var_5));
          break;
        case "allies":
          var_5 = scripts\engine\utility::string(var_2) + scripts\engine\utility::string(var_1) + scripts\engine\utility::string(1);
          var_4 setclientomnvar("rebirth_tracked_teams", int(var_5));
          break;
      }
    }
  }
}

function ref_13ee6() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 setclientomnvar("rebirth_tracked_teams", 0);
    }
  }
}

function ref_13f9a(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.start_reach_exhaust_waste.verbal_clip.ref_13009) {
    switch (var_4.team) {
      case "axis":
        var_1++;
        break;
      case "allies":
        var_2++;
        break;
    }
  }

  var_6 = [];
  GscBinSkip0(0x2e, "axis", var_1);
}

function ref_12af1(var_0) {
  if(!isDefined(var_0.verbal_string)) {
    var_1 = spawnStruct();
    var_1.trial_thermite_watcher = 0;
    var_1.ref_11f64 = undefined;
    var_0.verbal_string = var_1;
    return;
  }
}

function ref_12af3() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      ref_12af1(var_1);
    }
  }
}

function ref_11ff1(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !isDefined(level.start_reach_exhaust_waste.verbal_clip) || !isDefined(level.start_reach_exhaust_waste.verbal_clip.inited) || !level.start_reach_exhaust_waste.verbal_clip.active) {
    return;
  }

  if(scripts\engine\utility::array_contains(level.start_reach_exhaust_waste.verbal_clip.ref_13009, var_1)) {
    var_3 = isDefined(var_2) && (var_2 == "MOD_SUICIDE" || var_2 == "MOD_FALLING");
    cheeselocs(var_1, var_0, var_3);
    ref_12bd7(var_1);
    ref_12bd8(var_1);
    playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var_1.origin);
    playsoundatpos(var_1.origin, "br_splash_vip_eliminated");

    if(level.start_reach_exhaust_waste.verbal_clip.ref_13009.size > 1) {
      thread ref_12c41(level.start_reach_exhaust_waste.verbal_clip);
    }

    var_1.verbal_string.trial_thermite_watcher = 0;
    level.start_reach_exhaust_waste.verbal_clip.ref_13009 = scripts\engine\utility::array_remove(level.start_reach_exhaust_waste.verbal_clip.ref_13009, var_1);

    foreach(var_5 in level.players) {
      ref_13f9a(var_5, var_1);
    }
  }

  obj_room_fire_07();
}

function ref_12c41(var_0) {
  level endon("game_ended");

  if(!isDefined(level.start_reach_exhaust_waste.verbal_clip.vfx_struct)) {
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 0;
  }

  if(!level.start_reach_exhaust_waste.verbal_clip.vfx_struct) {
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 1;
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("hvt_friendly_down", var_0.team);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("hvt_enemy_down", scripts\engine\utility::get_enemy_team(var_0.team));
    wait 8;
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 0;
    return;
  }
}

function cheeselocs(var_0, var_1) {
  var_2 = scripts\engine\utility::get_enemy_team(self.team);
  var_3 = 4;
  var_4 = 25;

  if(istrue(var_1)) {
    var_3 += 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var_2, var_3, 0);
    return;
  }

  if(isDefined(var_0) && istrue(var_0.ref_12827)) {
    var_3 *= 2;
    var_4 *= 2;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var_2, var_3, 0);

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_0 thread scripts\mp\gametypes\br_plunder::ref_12627(var_4);
    return;
  }
}

function ref_12338() {
  var_0 = ["axis", "allies"];

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\utility\teams::getteamdata(var_2, "players");
    var_4 = 0;
    var_5 = [];

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_7 = undefined;
      var_8 = 0;

      foreach(var_10 in var_3) {
        if(!isDefined(var_10) || !scripts\mp\utility\player::isreallyalive(var_10) || istrue(var_10.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var_5, var_10.squadindex)) {
          continue;
        }

        if(var_10.pers["kills"] > var_8) {
          var_7 = var_10;
          var_8 = var_10.pers["kills"];
        }
      }

      if(isDefined(var_7)) {
        ref_11a91(var_7);
        var_5 = var_7.squadindex;
        var_4++;
        continue;
      }

      break;
    }

    var_12 = 5 - var_4;

    for(var_6 = 0; var_6 < var_12; var_6++) {
      var_3 = scripts\engine\utility::array_randomize(var_3);
      var_7 = undefined;

      foreach(var_14 in var_3) {
        if(istrue(var_14.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var_5, var_14.squadindex) || !scripts\mp\utility\player::isreallyalive(var_14)) {
          continue;
        }

        var_7 = var_14;
      }

      if(isDefined(var_7)) {
        ref_11a91(var_7);
        var_5 = var_7.squadindex;
        var_4++;
        continue;
      }

      break;
    }
  }

  foreach(var_10 in level.players) {
    if(!istrue(var_10.verbal_string.trial_thermite_watcher)) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_started", var_10, 0);
      var_10 thread scripts\mp\hud_message::showsplash("br_ri_pe_kill_leader_event_start_as_hunter");
    }
  }
}

function ref_11a91() {
  self.verbal_string.trial_thermite_watcher = 1;
  level.start_reach_exhaust_waste.verbal_clip.ref_13009 = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.verbal_clip.ref_13009, self);
  thread ref_1357a();
  thread ref_13f9e();
  thread scripts\mp\hud_message::showsplash("br_ri_pe_kill_leader_event_start_as_target");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_hunted", self, 0, 0);
}

function ref_13f9e() {
  level endon("game_ended");
  wait 8;
  self.verbal_string.ref_11c3e = [];
  self.verbal_string.ref_11c3e[0] = spawnStruct();
  self.verbal_string.ref_11c3e[1] = spawnStruct();
  self.verbal_string.ref_11c3e[0] scripts\mp\gametypes\br_quest_util::init_tactical_boxes(3, 5, 0, self.origin);
  self.verbal_string.ref_11c3e[1] scripts\mp\gametypes\br_quest_util::init_tactical_boxes(1, 5, 0, self.origin);
  var_0 = scripts\engine\utility::get_enemy_team(self.team);
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_3 in level.players) {
    var_4 = self.team == var_3.team;
    self.verbal_string.ref_11c3e[scripts\engine\utility::ter_op(var_4, 0, 1)] scripts\mp\gametypes\br_quest_util::ref_1336a(var_3);
  }

  if(isDefined(self.verbal_string.ref_11c3e[0])) {
    thread ref_13f9d(self.verbal_string.ref_11c3e[0]);
  }

  if(isDefined(self.verbal_string.ref_11c3e[1])) {
    thread ref_13f9d(self.verbal_string.ref_11c3e[1], self);
    return;
  }
}

function ref_13f9d(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(var_0) || !isalive(var_0) || !isDefined(self.mapcircle)) {
      break;
    }

    scripts\mp\gametypes\br_quest_util::ref_1316f(0);
    scripts\mp\gametypes\br_quest_util::ref_11dae(var_0.origin);

    if(isDefined(var_1)) {
      wait var_1;
      continue;
    }

    waitframe();
  }

  ref_12bd8(var_0);
}

function ref_12bd8() {
  if(!isDefined(self.verbal_string.ref_11c3e) || !isDefined(self.verbal_string.ref_11c3e[0]) || !isDefined(self.verbal_string.ref_11c3e[1])) {
    return;
  }

  foreach(var_1 in self.verbal_string.ref_11c3e) {
    if(isDefined(var_1)) {
      var_1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
      self.verbal_string.ref_11c3e[var_2] = undefined;
    }
  }
}

function ref_1357a() {
  if(isDefined(self.verbal_string.ref_11f64)) {
    return;
  }

  var_0 = "ui_mp_br_mapmenu_icon_plunder_leader";
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var_1, "invisible");
  objective_position(var_1, self.origin + (0, 0, 100));
  objective_setplayintro(var_1, 0);
  objective_setshowoncompass(var_1, 0);
  objective_setshowdistance(var_1, 0);
  getbnetigrbattlepassxpmultiplier(var_1, 0, 1150);
  getscriptcachecontents(var_1, 0.2, 0.3);
  scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 100);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self);
  var_2 = scripts\engine\utility::get_enemy_team(self.team);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 6);

  if(!isDefined(self.verbal_string.ref_11f64)) {
    self.verbal_string.ref_11f64 = [];
  }

  self.verbal_string.ref_11f64[self.verbal_string.ref_11f64.size] = var_1;
}

function ref_12bd7() {
  if(!isDefined(self.verbal_string.ref_11f64)) {
    return;
  }

  foreach(var_1 in self.verbal_string.ref_11f64) {
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(var_1);
  }

  self.verbal_string.ref_11f64 = undefined;
}