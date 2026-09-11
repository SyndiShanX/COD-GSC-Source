/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_kill_leader.gsc
*************************************************************************/

function init() {
  level.start_reach_exhaust_waste.verbal_clip = spawnStruct();
  level.start_reach_exhaust_waste.verbal_clip.active = 0;
  level.start_reach_exhaust_waste.verbal_clip.duration = getdvarint("scr_ri_pe_kill_leader_duration", 120);
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_br_pe_kill_leader_weight", 1);
  var0.attackerswaittime = &attackerswaittime;
  var0.ref_140cf = &ref_140cf;
  var0.ref_14382 = &ref_14382;
  var0.ref_11b78 = getdvarint("scr_br_pe_kill_leader_max_times", 1);
  var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("kill_leader", "10 5 0 0 0 0 0 0");
  scripts\mp\gametypes\br_publicevents::ref_12b35(100, var0);
}

function ref_140cf() {
  return false;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function forest_combat() {
  var0 = getdvarfloat("scr_ri_pe_kill_leader_starttime_min", 795);
  var1 = getdvarfloat("scr_ri_pe_kill_leader_starttime_max", 1110);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
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

  var2 = 500;
  var3 = undefined;

  foreach(var5 in level.start_reach_exhaust_waste.verbal_clip.ref_13009) {
      if(var5.team == var0.team && var5 != var0) {
        var6 = distance2d(var5.origin, var1.origin) < var2;
        var7 = abs(var5.origin[2] - var1.origin[2]) < 500;
        var8 = var6 && var7;
        var9 = distance2d(var5.origin, var1.origin) < var2;
        var10 = abs(var5.origin[2] - var1.origin[2]) < 500;
        var11 = var9 && var10;

        if(var8 || var11) {
          var0 thread scripts\mp\rank::giverankxp("rumble_hvt_defend_kill", int(50), var0 getcurrentprimaryweapon());
          var0 thread scripts\mp\rank::scoreeventpopup("rumble_hvt_defend_kill");
          break;
        }
      }
    }

    <
    error > = undefined;
  var0 = undefined;
}

function oceanrock() {
  level endon("game_ended");
  self endon("event_end");
  var0 = gettime() + (level.start_reach_exhaust_waste.verbal_clip.duration - 3) * 1000;
  var1 = spawn("script_origin", (0, 0, 0));
  var1 hide();
  level.start_reach_exhaust_waste.verbal_clip.heli_arrived = var1;
  setomnvar("ui_publicevent_timer_type", 3);
  setomnvar("ui_publicevent_timer", var0);
  wait level.start_reach_exhaust_waste.verbal_clip.duration - 5 - 3;

  for(var2 = 0; var2 < 5; var2++) {
    var1 playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  thread obj_room_fire_10();
}

function obj_room_fire_10(var0, var1) {
  level endon("game_ended");
  level.start_reach_exhaust_waste.verbal_clip.active = 0;

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(isDefined(level.start_reach_exhaust_waste.verbal_clip.heli_arrived)) {
    level.start_reach_exhaust_waste.verbal_clip.heli_arrived delete();
  }

  setomnvar("ui_publicevent_timer_type", 0);
  var2 = obj_tugofwar_drain_speed();
  var3 = "br_ri_pe_kill_leader_event_end_early_contested";
  var4 = var0 == "hvt_team_wiped" && var2 != "contested";

  foreach(var6 in level.players) {
    if(var4) {
      if(var6.team == var2) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_all_enemies_down", var6, 0);
        var3 = "br_ri_pe_kill_leader_event_end_early_eliminated_enemy";
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_all_friendlies_down", var6, 0);
        var3 = "br_ri_pe_kill_leader_event_end_early_eliminated_ally";
      }
    }

    scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_12425(var6, var3);
  }

  obj_vindia(level.start_reach_exhaust_waste);
  ref_13ee6();
  level.start_reach_exhaust_waste.verbal_clip.ref_13009 = [];
  self notify("event_end");
}

function obj_room_fire_07() {
  var0 = obj_running_exfil_wave();
  var1 = var0["axis"];
  var2 = var0["allies"];

  if(var1 == 0 || var2 == 0 || level.start_reach_exhaust_waste.verbal_clip.ref_13009.size == 0) {
    var3 = 0;
    var4 = undefined;
    thread obj_room_fire_10(level.start_reach_exhaust_waste.verbal_clip, "hvt_team_wiped");
    return;
  }
}

function obj_running_exfil_wave() {
  var0 = 0;
  var1 = 0;
  var2 = [];
  GscBinSkip0(0x2e, "axis", 0);
}

function obj_tugofwar_drain_speed() {
  var0 = obj_running_exfil_wave();
  var1 = var0["axis"];
  var2 = var0["allies"];

  if(var1 == var2) {
    return "contested";
  }

  return scripts\engine\utility::ter_op(var1 > var2, "axis", "allies");
}

function obj_vindia() {
  foreach(var1 in level.start_reach_exhaust_waste.verbal_clip.ref_13009) {
    ref_12bd8(var1);
    ref_12bd7(var1);
    var1.verbal_string.trial_thermite_watcher = 0;
    level scripts\mp\gamescore::giveteamscoreforobjective(var1.team, 5, 0);
    var1 thread scripts\mp\gametypes\br_plunder::ref_12627(50);
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
  var0 = obj_running_exfil_wave();
  var1 = var0["axis"];
  var2 = var0["allies"];

  foreach(var4 in level.players) {
    if(isDefined(var4)) {
      switch (var4.team) {
        case "axis":
          var5 = scripts\engine\utility::string(var1) + scripts\engine\utility::string(var2) + scripts\engine\utility::string(1);
          var4 setclientomnvar("rebirth_tracked_teams", int(var5));
          break;
        case "allies":
          var5 = scripts\engine\utility::string(var2) + scripts\engine\utility::string(var1) + scripts\engine\utility::string(1);
          var4 setclientomnvar("rebirth_tracked_teams", int(var5));
          break;
      }
    }
  }
}

function ref_13ee6() {
  foreach(var1 in level.players) {
    if(isDefined(var1)) {
      var1 setclientomnvar("rebirth_tracked_teams", 0);
    }
  }
}

function ref_13f9a(var0) {
  var1 = 0;
  var2 = 0;

  foreach(var4 in level.start_reach_exhaust_waste.verbal_clip.ref_13009) {
    switch (var4.team) {
      case "axis":
        var1++;
        break;
      case "allies":
        var2++;
        break;
    }
  }

  var6 = [];
  GscBinSkip0(0x2e, "axis", var1);
}

function ref_12af1(var0) {
  if(!isDefined(var0.verbal_string)) {
    var1 = spawnStruct();
    var1.trial_thermite_watcher = 0;
    var1.ref_11f64 = undefined;
    var0.verbal_string = var1;
    return;
  }
}

function ref_12af3() {
  foreach(var1 in level.players) {
    if(isDefined(var1)) {
      ref_12af1(var1);
    }
  }
}

function ref_11ff1(var0, var1, var2) {
  if(!isDefined(var1) || !isDefined(level.start_reach_exhaust_waste.verbal_clip) || !isDefined(level.start_reach_exhaust_waste.verbal_clip.inited) || !level.start_reach_exhaust_waste.verbal_clip.active) {
    return;
  }

  if(scripts\engine\utility::array_contains(level.start_reach_exhaust_waste.verbal_clip.ref_13009, var1)) {
    var3 = isDefined(var2) && (var2 == "MOD_SUICIDE" || var2 == "MOD_FALLING");
    cheeselocs(var1, var0, var3);
    ref_12bd7(var1);
    ref_12bd8(var1);
    playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var1.origin);
    playsoundatpos(var1.origin, "br_splash_vip_eliminated");

    if(level.start_reach_exhaust_waste.verbal_clip.ref_13009.size > 1) {
      thread ref_12c41(level.start_reach_exhaust_waste.verbal_clip);
    }

    var1.verbal_string.trial_thermite_watcher = 0;
    level.start_reach_exhaust_waste.verbal_clip.ref_13009 = scripts\engine\utility::array_remove(level.start_reach_exhaust_waste.verbal_clip.ref_13009, var1);

    foreach(var5 in level.players) {
      ref_13f9a(var5, var1);
    }
  }

  obj_room_fire_07();
}

function ref_12c41(var0) {
  level endon("game_ended");

  if(!isDefined(level.start_reach_exhaust_waste.verbal_clip.vfx_struct)) {
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 0;
  }

  if(!level.start_reach_exhaust_waste.verbal_clip.vfx_struct) {
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 1;
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("hvt_friendly_down", var0.team);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("hvt_enemy_down", scripts\engine\utility::get_enemy_team(var0.team));
    wait 8;
    level.start_reach_exhaust_waste.verbal_clip.vfx_struct = 0;
    return;
  }
}

function cheeselocs(var0, var1) {
  var2 = scripts\engine\utility::get_enemy_team(self.team);
  var3 = 4;
  var4 = 25;

  if(istrue(var1)) {
    var3 += 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var2, var3, 0);
    return;
  }

  if(isDefined(var0) && istrue(var0.ref_12827)) {
    var3 *= 2;
    var4 *= 2;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var2, var3, 0);

  if(isDefined(var0) && isPlayer(var0)) {
    var0 thread scripts\mp\gametypes\br_plunder::ref_12627(var4);
    return;
  }
}

function ref_12338() {
  var0 = ["axis", "allies"];

  foreach(var2 in var0) {
    var3 = scripts\mp\utility\teams::getteamdata(var2, "players");
    var4 = 0;
    var5 = [];

    for(var6 = 0; var6 < 3; var6++) {
      var7 = undefined;
      var8 = 0;

      foreach(var10 in var3) {
        if(!isDefined(var10) || !scripts\mp\utility\player::isreallyalive(var10) || istrue(var10.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var5, var10.squadindex)) {
          continue;
        }

        if(var10.pers["kills"] > var8) {
          var7 = var10;
          var8 = var10.pers["kills"];
        }
      }

      if(isDefined(var7)) {
        ref_11a91(var7);
        var5 = var7.squadindex;
        var4++;
        continue;
      }

      break;
    }

    var12 = 5 - var4;

    for(var6 = 0; var6 < var12; var6++) {
      var3 = scripts\engine\utility::array_randomize(var3);
      var7 = undefined;

      foreach(var14 in var3) {
        if(istrue(var14.verbal_string.trial_thermite_watcher) || scripts\engine\utility::array_contains(var5, var14.squadindex) || !scripts\mp\utility\player::isreallyalive(var14)) {
          continue;
        }

        var7 = var14;
      }

      if(isDefined(var7)) {
        ref_11a91(var7);
        var5 = var7.squadindex;
        var4++;
        continue;
      }

      break;
    }
  }

  foreach(var10 in level.players) {
    if(!istrue(var10.verbal_string.trial_thermite_watcher)) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("hvt_started", var10, 0);
      var10 thread scripts\mp\hud_message::showsplash("br_ri_pe_kill_leader_event_start_as_hunter");
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
  var0 = scripts\engine\utility::get_enemy_team(self.team);
  var1 = scripts\mp\utility\teams::getteamdata(var0, "players");

  foreach(var3 in level.players) {
    var4 = self.team == var3.team;
    self.verbal_string.ref_11c3e[scripts\engine\utility::ter_op(var4, 0, 1)] scripts\mp\gametypes\br_quest_util::ref_1336a(var3);
  }

  if(isDefined(self.verbal_string.ref_11c3e[0])) {
    thread ref_13f9d(self.verbal_string.ref_11c3e[0]);
  }

  if(isDefined(self.verbal_string.ref_11c3e[1])) {
    thread ref_13f9d(self.verbal_string.ref_11c3e[1], self);
    return;
  }
}

function ref_13f9d(var0, var1) {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(var0) || !isalive(var0) || !isDefined(self.mapcircle)) {
      break;
    }

    scripts\mp\gametypes\br_quest_util::ref_1316f(0);
    scripts\mp\gametypes\br_quest_util::ref_11dae(var0.origin);

    if(isDefined(var1)) {
      wait var1;
      continue;
    }

    waitframe();
  }

  ref_12bd8(var0);
}

function ref_12bd8() {
  if(!isDefined(self.verbal_string.ref_11c3e) || !isDefined(self.verbal_string.ref_11c3e[0]) || !isDefined(self.verbal_string.ref_11c3e[1])) {
    return;
  }

  foreach(var1 in self.verbal_string.ref_11c3e) {
    if(isDefined(var1)) {
      var1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
      self.verbal_string.ref_11c3e[var2] = undefined;
    }
  }
}

function ref_1357a() {
  if(isDefined(self.verbal_string.ref_11f64)) {
    return;
  }

  var0 = "ui_mp_br_mapmenu_icon_plunder_leader";
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var1, "invisible");
  objective_position(var1, self.origin + (0, 0, 100));
  objective_setplayintro(var1, 0);
  objective_setshowoncompass(var1, 0);
  objective_setshowdistance(var1, 0);
  getbnetigrbattlepassxpmultiplier(var1, 0, 1150);
  getscriptcachecontents(var1, 0.2, 0.3);
  scripts\mp\objidpoolmanager::update_objective_icon(var1, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var1, 100);
  scripts\mp\objidpoolmanager::update_objective_onentity(var1, self);
  var2 = scripts\engine\utility::get_enemy_team(self.team);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var1, 6);

  if(!isDefined(self.verbal_string.ref_11f64)) {
    self.verbal_string.ref_11f64 = [];
  }

  self.verbal_string.ref_11f64[self.verbal_string.ref_11f64.size] = var1;
}

function ref_12bd7() {
  if(!isDefined(self.verbal_string.ref_11f64)) {
    return;
  }

  foreach(var1 in self.verbal_string.ref_11f64) {
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(var1);
  }

  self.verbal_string.ref_11f64 = undefined;
}