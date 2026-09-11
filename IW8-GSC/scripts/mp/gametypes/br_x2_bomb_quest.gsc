/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_bomb_quest.gsc
*****************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_bomb", 0);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("x2_bomb").ref_11c4c = getdvarint("scr_br_x2_bomb_missionTimeBase", 240);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_bomb", &ref_1464f);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("x2_bomb", &ref_1464d);
  scripts\mp\gametypes\br_quest_util::ref_12b30("x2_bomb", &ref_14650);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_bomb", &ref_14652, 0.05);
  scripts\mp\gametypes\br_quest_util::ref_1297c("x2_bomb", 0);
  scripts\mp\gametypes\br_quest_util::ref_12b31("x2_bomb", &ref_1464c);
  level.disable_super_in_turret.ref_14653 = 0;
  init_post_bsp_entities();
  level.ref_1464e = "bomb";
  level.ref_14651 = 0;
  scripts\mp\gametypes\br_quest_util::ref_12b38("x2_signal");

  if(!isDefined(level.disable_super_in_turret.ref_12391)) {
    level.disable_super_in_turret.ref_12391 = [];
    return;
  }
}

function init_post_bsp_entities() {
  var0 = [];
  GscBinSkip0(0x2e, 0, []);
}

function ref_14650(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_bomb");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_1464c() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_1464f() {
  if(isDefined(self.initspawnswar)) {
    foreach(var1 in self.playerlist) {
      if(isDefined(var1)) {
        self.initspawnswar.gameobject hidefromplayer(var1);
        self.initspawnswar.gameobject disableplayeruse(var1);
      }
    }
  }

  last_time_calc_defuser();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_1464d(var0) {
  if(var0.team == self.team) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function gethillspawnshutofforigin(var0) {
  return scripts\mp\gametypes\br_gametype_x2::extra_riders_func(var0);
}

function search(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_bomb", var0, var1, var4);
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;

  switch (level.ref_1464e) {
    case "signal":
      var6 = "x2_signal";
      var7 = "br_x2_signal_quest_start_team_notify";
      var8 = "ui_mp_br_mapmenu_icon_x2_02_objective";
      break;
    case "bomb":
    default:
      var6 = "x2_bomb";
      var7 = "br_x2_bomb_quest_start_team_notify";
      var8 = "ui_mp_br_mapmenu_icon_x2_01_objective";
      break;
  }

  var5 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations(var8, "current", (0, 0, 0));
  ref_1312d(var5);

  foreach(var2 in var5.playerlist) {
    if(isDefined(var2)) {
      var5 scripts\mp\gametypes\br_quest_util::ref_1336c(var2);
      var2.ref_1296e = var5.initspawnswar.origin;
    }
  }

  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam(var6, self.team);
  var5 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("x2_bomb").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_bomb", var5);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_bomb", self, self.team);
  var11 = spawnStruct();
  var11.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_bomb", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, var7, var11);
  return var5;
}

function calculatehelispawndata() {
  return scripts\mp\gametypes\br_gametype_x2::enemy_signal_flare("x2_bomb", &search);
}

function init_reach_icbm_launch(var0) {
  var1 = spawnStruct();
  var1.origin = scripts\mp\gametypes\br_public::modifyplayer_damage(var0, 0, -200) + (0, 0, 20);
  var1.gameobject = spawn("script_model", var1.origin);
  var1.gameobject.origin = var0;
  var1.gameobject.angles = (45, 0, 45);
  var1.gameobject hide();
  thread ref_1464b();
  return var1;
}

function ref_1464b() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);
    ref_14065(var0, self);
    var0 playlocalsound("br_pickup_generic");
  }
}

function ref_14065(var0) {
  var1 = scripts\mp\gametypes\br_gametype_x2::entmantling("x2_bomb", self);

  if(level.ref_1464e == "signal") {
    thread init_trap_room_spawning_module(var0.origin);
    thread ref_126c7();
  } else {
    var2 = spawn("script_model", var0.origin);
    var2 setModel("us_military_tnt_bundle_01");
    var2.angles = (0, 180, 0);
    var2 istacmapactive();
    level.disable_super_in_turret.ref_12391[level.disable_super_in_turret.ref_12391.size] = var2;
  }

  var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var5 in var3) {
    if(isDefined(var5)) {
      var5 notify("bomb_used");
    }
  }

  level.ref_14639 += scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex).size;
  level.ref_14651++;
  ref_12a37(var1);
}

function ref_1312d() {
  self.initprematchc130 = level.ref_14632;
  self.initspawnswar = scripts\mp\gametypes\br_quest_util::getquestdata("x2_bomb").launcher_second_techo[self.initprematchc130][level.disable_super_in_turret.ref_14653];

  if(!isDefined(self.initspawnswar)) {
    return;
  }

  level.disable_super_in_turret.ref_14653++;
  scripts\mp\gametypes\br_quest_util::ref_11db0(self.initspawnswar.origin + (0, 0, 38));

  if(!istrue(self.initspawnswar.gameobject.spawn_gate_guards)) {
    self.initspawnswar.gameobject.spawn_gate_guards = 1;
    self.initspawnswar.gameobject istacmapactive();
    self.initspawnswar.gameobject scripts\mp\gameobjects::sethintobject(undefined, undefined, undefined, regroup_trigger(), undefined, "duration_none", undefined, 200, 90, 72, 90);
    self.initspawnswar.gameobject setuseprioritymax();
  }

  foreach(var1 in self.playerlist) {
    if(isDefined(var1)) {
      self.initspawnswar.gameobject enableplayeruse(var1);
    }
  }

  self.initspawnswar.gameobject show();
  ref_13fc5();
}

function ref_12a37() {
  foreach(var1 in self.playerlist) {
    if(isDefined(var1)) {
      var1 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }

  ref_1464a();
}

function ref_14652() {
  if(isDefined(self.initspawnswar) && isDefined(self.initspawnswar.gameobject)) {
    scripts\mp\gametypes\br_quest_util::ref_11db0(self.initspawnswar.gameobject.origin);
  }

  if(istrue(self.playermonitorspectatorcycle) || scripts\mp\flags::gameflag("x2_ambush" + self.initprematchc130 + 1 + "_starting") || scripts\mp\flags::gameflag("x2_train_destroyed")) {
    path_timeout();
    return;
  }
}

function ref_1464a() {
  var0 = spawnStruct();
  var1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var2 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_bomb");
  var3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_bomb"));
  var0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var2, var1, var3);
  var4 = undefined;

  switch (level.ref_1464e) {
    case "signal":
      var4 = "br_x2_signal_quest_complete";
      break;
    case "bomb":
    default:
      var4 = "br_x2_bomb_quest_complete";
      break;
  }

  if(getdvarint("scr_br_x2_contractKillcamFix", 1)) {
    var5 = scripts\mp\gametypes\br_gametype_x2::enter_laser_panel_anim_sequence(self.playerlist);
    scripts\mp\gametypes\br_quest_util::longwaitradarsweep(var5, var4, var0);

    foreach(var7 in self.playerlist) {
      if(isDefined(var7)) {
        var7 thread scripts\mp\utility\points::giveunifiedpoints("br_x2_ambush");
      }
    }
  } else {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, var4, var0);
  }

  self.ref_12d2e = self.playerlist[0].origin;
  self.ref_12d2b = self.playerlist[0].angles;
  self.result = "success";
  self.ref_11eba = 1;
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function path_timeout() {
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_13fc5() {
  foreach(var1 in self.playerlist) {
    if(!isDefined(var1)) {
      continue;
    }

    var2 = undefined;

    switch (level.ref_1464e) {
      case "signal":
        var2 = "x2_signal";
        break;
      case "bomb":
      default:
        var2 = "x2_bomb";
        break;
    }

    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow(var2);
    scripts\mp\gametypes\br_quest_util::ref_1336c(var1);
  }
}

function spawn_caches_tank(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function last_time_calc_defuser() {
  foreach(var1 in self.playerlist) {
    if(isDefined(var1)) {
      spawn_caches_tank(var1);
    }
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();

  foreach(var1 in self.playerlist) {
    if(isDefined(var1)) {
      var1 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }
}

function regroup_trigger() {
  var0 = undefined;

  switch (level.ref_1464e) {
    case "signal":
      var0 = &"BR_REVEAL_X2_EVENT/X2_MARK_AREA";
      break;
    case "bomb":
    default:
      var0 = &"BR_REVEAL_X2_EVENT/X2_SET_TNT";
      break;
  }

  return var0;
}

function init_trap_room_spawning_module(var0, var1) {
  level endon("game_ended");
  wait 1.35;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = spawn("script_model", var0);
  var2 setModel("x2_smoke_marker");
  var2.origin += (0, 0, var1);
  var2.angles = (0, 0, 0);
  var2 playSound("smoke_carepackage_expl_trans");
  var2 playLoopSound("smoke_carepackage_smoke_lp");
  var2 setscriptablepartstate("smoke", "on");
  var2 unmarkkeyframedmover(1);
  level.disable_super_in_turret.ref_12391[level.disable_super_in_turret.ref_12391.size] = var2;
}

function loop_station_closed_vo(var0) {
  level endon("game_ended");
  var0 setscriptablepartstate("smoke", "dissipate");
  var0 playSound("smoke_canister_tail_dissipate");
  wait 1;
  var0 stoploopsound();
  wait 4.5;
  var0 delete();
}

function ref_126c7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_plunder_smoke", 1.867);
}

function has_headicon() {
  foreach(var1 in level.disable_super_in_turret.ref_12391) {
    if(isDefined(var1)) {
      switch (level.ref_1464e) {
        case "signal":
          thread loop_station_closed_vo(var1);
          break;
        case "bomb":
        default:
          var1 delete();
          break;
      }
    }
  }

  level.disable_super_in_turret.ref_12391 = [];
}

function ref_1362d(var0, var1) {
  var2 = scripts\mp\gametypes\br_public::modifyplayer_damage(var0, 100, -200);
  init_trap_room_spawning_module(var2, var1);
}