/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_bomb_quest.gsc
*****************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_bomb", 0);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("x2_bomb").ref_11C4C = getdvarint("scr_br_x2_bomb_missionTimeBase", 240);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_bomb", &ref_1464F);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("x2_bomb", &ref_1464D);
  scripts\mp\gametypes\br_quest_util::ref_12B30("x2_bomb", &ref_14650);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_bomb", &ref_14652, 0.05);
  scripts\mp\gametypes\br_quest_util::ref_1297C("x2_bomb", 0);
  scripts\mp\gametypes\br_quest_util::ref_12B31("x2_bomb", &ref_1464C);
  level.disable_super_in_turret.ref_14653 = 0;
  init_post_bsp_entities();
  level.ref_1464E = "bomb";
  level.ref_14651 = 0;
  scripts\mp\gametypes\br_quest_util::ref_12B38("x2_signal");

  if(!isDefined(level.disable_super_in_turret.ref_12391)) {
    level.disable_super_in_turret.ref_12391 = [];
    return;
  }
}

function init_post_bsp_entities() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, []);
}

function ref_14650(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_bomb");
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function ref_1464C() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_1464F() {
  if(isDefined(self.initspawnswar)) {
    foreach(var_1 in self.playerlist) {
      if(isDefined(var_1)) {
        self.initspawnswar.gameobject hidefromplayer(var_1);
        self.initspawnswar.gameobject disableplayeruse(var_1);
      }
    }
  }

  last_time_calc_defuser();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_1464D(var_0) {
  if(var_0.team == self.team) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function gethillspawnshutofforigin(var_0) {
  return scripts\mp\gametypes\br_gametype_x2::extra_riders_func(var_0);
}

function search(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_bomb", var_0, var_1, var_4);
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  switch (level.ref_1464E) {
    case "signal":
      var_6 = "x2_signal";
      var_7 = "br_x2_signal_quest_start_team_notify";
      var_8 = "ui_mp_br_mapmenu_icon_x2_02_objective";
      break;
    case "bomb":
    default:
      var_6 = "x2_bomb";
      var_7 = "br_x2_bomb_quest_start_team_notify";
      var_8 = "ui_mp_br_mapmenu_icon_x2_01_objective";
      break;
  }

  var_5 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations(var_8, "current", (0, 0, 0));
  ref_1312D(var_5);

  foreach(var_2 in var_5.playerlist) {
    if(isDefined(var_2)) {
      var_5 scripts\mp\gametypes\br_quest_util::ref_1336C(var_2);
      var_2.ref_1296E = var_5.initspawnswar.origin;
    }
  }

  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam(var_6, self.team);
  var_5 scripts\mp\gametypes\br_quest_util::ref_1297D(scripts\mp\gametypes\br_quest_util::getquestdata("x2_bomb").ref_11C4C, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_bomb", var_5);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_bomb", self, self.team);
  var_11 = spawnStruct();
  var_11.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_bomb", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, var_7, var_11);
  return var_5;
}

function calculatehelispawndata() {
  return scripts\mp\gametypes\br_gametype_x2::enemy_signal_flare("x2_bomb", &search);
}

function init_reach_icbm_launch(var_0) {
  var_1 = spawnStruct();
  var_1.origin = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0, 0, -200) + (0, 0, 20);
  var_1.gameobject = spawn("script_model", var_1.origin);
  var_1.gameobject.origin = var_0;
  var_1.gameobject.angles = (45, 0, 45);
  var_1.gameobject hide();
  thread ref_1464B();
  return var_1;
}

function ref_1464B() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    ref_14065(var_0, self);
    var_0 playlocalsound("br_pickup_generic");
  }
}

function ref_14065(var_0) {
  var_1 = scripts\mp\gametypes\br_gametype_x2::entmantling("x2_bomb", self);

  if(level.ref_1464E == "signal") {
    thread init_trap_room_spawning_module(var_0.origin);
    thread ref_126C7();
  } else {
    var_2 = spawn("script_model", var_0.origin);
    var_2 setModel("us_military_tnt_bundle_01");
    var_2.angles = (0, 180, 0);
    var_2 istacmapactive();
    level.disable_super_in_turret.ref_12391[level.disable_super_in_turret.ref_12391.size] = var_2;
  }

  var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_5 in var_3) {
    if(isDefined(var_5)) {
      var_5 notify("bomb_used");
    }
  }

  level.ref_14639 += scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex).size;
  level.ref_14651++;
  ref_12A37(var_1);
}

function ref_1312D() {
  self.initprematchc130 = level.ref_14632;
  self.initspawnswar = scripts\mp\gametypes\br_quest_util::getquestdata("x2_bomb").launcher_second_techo[self.initprematchc130][level.disable_super_in_turret.ref_14653];

  if(!isDefined(self.initspawnswar)) {
    return;
  }

  level.disable_super_in_turret.ref_14653++;
  scripts\mp\gametypes\br_quest_util::ref_11DB0(self.initspawnswar.origin + (0, 0, 38));

  if(!istrue(self.initspawnswar.gameobject.spawn_gate_guards)) {
    self.initspawnswar.gameobject.spawn_gate_guards = 1;
    self.initspawnswar.gameobject istacmapactive();
    self.initspawnswar.gameobject scripts\mp\gameobjects::sethintobject(undefined, undefined, undefined, regroup_trigger(), undefined, "duration_none", undefined, 200, 90, 72, 90);
    self.initspawnswar.gameobject setuseprioritymax();
  }

  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1)) {
      self.initspawnswar.gameobject enableplayeruse(var_1);
    }
  }

  self.initspawnswar.gameobject show();
  ref_13FC5();
}

function ref_12A37() {
  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1)) {
      var_1 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }

  ref_1464A();
}

function ref_14652() {
  if(isDefined(self.initspawnswar) && isDefined(self.initspawnswar.gameobject)) {
    scripts\mp\gametypes\br_quest_util::ref_11DB0(self.initspawnswar.gameobject.origin);
  }

  if(istrue(self.playermonitorspectatorcycle) || scripts\mp\flags::gameflag("x2_ambush" + self.initprematchc130 + 1 + "_starting") || scripts\mp\flags::gameflag("x2_train_destroyed")) {
    path_timeout();
    return;
  }
}

function ref_1464A() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_bomb");
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_bomb"));
  var_0.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_2, var_1, var_3);
  var_4 = undefined;

  switch (level.ref_1464E) {
    case "signal":
      var_4 = "br_x2_signal_quest_complete";
      break;
    case "bomb":
    default:
      var_4 = "br_x2_bomb_quest_complete";
      break;
  }

  if(getdvarint("scr_br_x2_contractKillcamFix", 1)) {
    var_5 = scripts\mp\gametypes\br_gametype_x2::enter_laser_panel_anim_sequence(self.playerlist);
    scripts\mp\gametypes\br_quest_util::longwaitradarsweep(var_5, var_4, var_0);

    foreach(var_7 in self.playerlist) {
      if(isDefined(var_7)) {
        var_7 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_ambush");
      }
    }
  } else {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, var_4, var_0);
  }

  self.ref_12D2E = self.playerlist[0].origin;
  self.ref_12D2B = self.playerlist[0].angles;
  self.result = "success";
  self.ref_11EBA = 1;
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function path_timeout() {
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_13FC5() {
  foreach(var_1 in self.playerlist) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = undefined;

    switch (level.ref_1464E) {
      case "signal":
        var_2 = "x2_signal";
        break;
      case "bomb":
      default:
        var_2 = "x2_bomb";
        break;
    }

    var_1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow(var_2);
    scripts\mp\gametypes\br_quest_util::ref_1336C(var_1);
  }
}

function spawn_caches_tank(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function last_time_calc_defuser() {
  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1)) {
      spawn_caches_tank(var_1);
    }
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();

  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1)) {
      var_1 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }
}

function regroup_trigger() {
  var_0 = undefined;

  switch (level.ref_1464E) {
    case "signal":
      var_0 = &"BR_REVEAL_X2_EVENT/X2_MARK_AREA";
      break;
    case "bomb":
    default:
      var_0 = &"BR_REVEAL_X2_EVENT/X2_SET_TNT";
      break;
  }

  return var_0;
}

function init_trap_room_spawning_module(var_0, var_1) {
  level endon("game_ended");
  wait 1.35;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = spawn("script_model", var_0);
  var_2 setModel("x2_smoke_marker");
  var_2.origin += (0, 0, var_1);
  var_2.angles = (0, 0, 0);
  var_2 playSound("smoke_carepackage_expl_trans");
  var_2 playLoopSound("smoke_carepackage_smoke_lp");
  var_2 setscriptablepartstate("smoke", "on");
  var_2 unmarkkeyframedmover(1);
  level.disable_super_in_turret.ref_12391[level.disable_super_in_turret.ref_12391.size] = var_2;
}

function loop_station_closed_vo(var_0) {
  level endon("game_ended");
  var_0 setscriptablepartstate("smoke", "dissipate");
  var_0 playSound("smoke_canister_tail_dissipate");
  wait 1;
  var_0 stoploopsound();
  wait 4.5;
  var_0 delete();
}

function ref_126C7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_plunder_smoke", 1.867);
}

function has_headicon() {
  foreach(var_1 in level.disable_super_in_turret.ref_12391) {
    if(isDefined(var_1)) {
      switch (level.ref_1464E) {
        case "signal":
          thread loop_station_closed_vo(var_1);
          break;
        case "bomb":
        default:
          var_1 delete();
          break;
      }
    }
  }

  level.disable_super_in_turret.ref_12391 = [];
}

function ref_1362D(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0, 100, -200);
  init_trap_room_spawning_module(var_2, var_1);
}