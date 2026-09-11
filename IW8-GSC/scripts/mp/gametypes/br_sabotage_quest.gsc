/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_sabotage_quest.gsc
******************************************************/

function init() {
  var_0 = getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1;

  if(getdvarint("scr_br_sabotage_award_truck", 1) == 1 || var_0) {
    scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata(var_0);
    scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_loadoutchangeremovehcr();
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13df8();
  }

  var_1 = scripts\mp\gametypes\br_quest_util::registerquestcategory("sabotage", 1);

  if(!var_1) {
    return;
  }

  var_1 = scripts\mp\gametypes\br_quest_util::registerquestcategory("sabotage_redacted", 1);

  if(var_1) {
    scripts\mp\gametypes\br_quest_util::ref_12b2a("sabotage_redacted", "brloot_redacted_sabotage_tablet");
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("sabotage", &ref_12e4b);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("sabotage", &ref_12e46);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("sabotage", &ref_12e47);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("sabotage", &ref_12e43);
  scripts\mp\gametypes\br_quest_util::ref_12b30("sabotage", &ref_12e44);
  scripts\mp\gametypes\br_quest_util::registerquestthink("sabotage", &ref_12e4a, 1);
  scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76 = [];
  level.ref_1425a = &ref_12e42;
  game["dialog"]["sabotage_accept"] = "sabotage_contract_accept";
  game["dialog"]["sabotage_success"] = "sabotage_contract_success";
  game["dialog"]["sabotage_fail"] = "sabotage_enemy_destroyed";
  game["dialog"]["sabotage_timeout"] = "sabotage_contract_timeout";
  game["dialog"]["sabotage_circle_consumed"] = "sabotage_circle_consumed";
  scripts\mp\gametypes\br_quest_util::ref_1297c("sabotage", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("sabotage", &ref_12e45);
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("sabotage", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_2 = "";

  if(var_0.type == "brloot_redacted_sabotage_tablet") {
    var_2 = "_redacted";
  }

  var_1.modifier = var_2;
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_1.team = self.team;
  var_1.semtex_stuckplayer = self;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.ŽK / ÃsˆE÷£ èûË = 1;
  var_3 = ref_12e41();
  var_4 = ref_12e4c(var_1, var_3);
  var_1.ref_14261 = sortbydistance(var_4[0], var_1.semtex_stuckplayer.origin);
  var_1.ref_1426a = sortbydistance(var_4[1], var_1.semtex_stuckplayer.origin);

  if(isDefined(var_1.ref_14261)) {
    if(var_1.ref_14261.size > 0) {
      for(var_5 = 0; var_5 < var_1.ref_14261.size; var_5++) {
        if(isDefined(var_1.ref_14261[var_5].ref_13aad)) {
          if(var_1.ref_14261[var_5].ref_13aad != var_1.semtex_stuckplayer.team && var_1.ref_14261[var_5].occupants.size > 0) {
            var_6 = 0;

            for(var_7 = 0; var_7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var_7++) {
              if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var_7] == var_1.ref_14261[var_5]) {
                var_6 = 1;
                break;
              }
            }

            if(!var_6) {
              var_1.ref_13a92 = var_1.ref_14261[var_5];
            }
          }
        }

        if(!isDefined(var_1.ref_13a92)) {
          var_6 = 0;

          for(var_7 = 0; var_7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var_7++) {
            if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var_7] == var_1.ref_14261[var_5]) {
              var_6 = 1;
              break;
            }
          }

          if(!var_6) {
            var_1.ref_13a92 = var_1.ref_14261[var_5];
          }
        }
      }
    }
  }

  if(isDefined(var_1.ref_1426a)) {
    if(var_1.ref_1426a.size > 0) {
      for(var_5 = var_1.ref_1426a.size - 1; var_5 >= 0; var_5--) {
        if(isDefined(var_1.ref_1426a[var_5].ref_13aad)) {
          if(var_1.ref_1426a[var_5].ref_13aad != var_1.semtex_stuckplayer.team && var_1.ref_1426a[var_5].occupants.size > 0) {
            var_6 = 0;

            for(var_7 = 0; var_7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var_7++) {
              if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var_7] == var_1.ref_1426a[var_5]) {
                var_6 = 1;
                break;
              }
            }

            if(!var_6) {
              var_1.ref_13a92 = var_1.ref_1426a[var_5];
            }
          }
        }

        if(!isDefined(var_1.ref_13a92)) {
          var_6 = 0;

          for(var_7 = 0; var_7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var_7++) {
            if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var_7] == var_1.ref_1426a[var_5]) {
              var_6 = 1;
              break;
            }
          }

          if(!var_6) {
            var_1.ref_13a92 = var_1.ref_1426a[var_5];
          }
        }
      }
    }
  }

  var_1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_sabotage_objective_enemy", "active");
  ref_12e3f(var_1);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297d(getdvarint("scr_br_sabotage_questTimeBase", 180), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("sabotage", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("sabotage", self, self.team);
  var_8 = spawnStruct();
  var_8.excludedplayers = [];
  var_8.excludedplayers[0] = self;
  var_8.ogangles = [];
  var_8.ogangles[0] = var_1.team;
  var_8.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("sabotage", scripts\mp\gametypes\br_quest_util::ringing(self.team), var_1.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1.team, "br_sabotage_quest_start_team", var_8);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_1.semtex_stuckplayer, "br_sabotage_quest_start_tablet_finder", var_8);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_accept", var_1.team, 1, 0.5);

  if(isDefined(var_1.ref_13a92)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size] = var_1.ref_13a92;
    var_1.ref_13a92.ref_12970 = var_1;
    var_1.ref_13a92.center_node = [];
    return;
  }

  ref_12e49(var_1, 1);
}

function ref_12e3f() {
  objective_addalltomask(self.objectiveiconid);
  var_0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var_2 in var_0["valid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("sabotage" + self.modifier);
    scripts\mp\gametypes\br_quest_util::ref_1336c(var_2);
  }

  foreach(var_2 in var_0["invalid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_2);
  }
}

function ref_12e46(var_0, var_1) {
  ref_12e48(var_1, var_0);
}

function ref_12e47(var_0) {
  ref_12e48(var_0);
}

function ref_12e43(var_0) {
  ref_12e3e(var_0);
}

function ref_12e44(var_0) {
  if(var_0.team == self.team) {
    ref_12e40(var_0);
    scripts\mp\gametypes\br_quest_util::ref_1336c(var_0);
    return;
  }

  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function ref_12e48(var_0, var_1) {
  if(var_0.team == self.team) {
    ref_12e3e(var_0);
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
    return;
  }
}

function ref_12e45() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_timeout", self.team, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_timer_expired");
  ref_12e3c();
}

function ref_12e4b() {
  level notify("calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid);
  self.ŽK / ÃsˆE÷£ èûË = 0;
  ref_12e3d();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_12e40(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("sabotage" + self.modifier);
  scripts\mp\gametypes\br_quest_util::ref_1336c(var_0);
}

function ref_12e3e(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function ref_12e3d() {
  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    ref_12e3e(var_1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function ref_12e49(var_0) {
  wait 2;
  self.ref_12d2d = "_poached";
  var_1 = spawnStruct();
  var_2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_3 = scripts\mp\gametypes\br_quest_util::getquestindex("sabotage");
  var_4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("sabotage", self.ref_12d2d, self.modifier));
  var_5 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var_1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var_3, var_2, var_4, undefined, var_5);

  if(var_0) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_novehicle", var_1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_fail", self.team, 1);
  } else {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_poached", var_1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_fail", self.team, 1);
  }

  self.ref_12d2e = (0, 0, 0);
  self.ref_12d2b = (0, 0, 0);
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_12e3b() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("sabotage" + self.modifier);
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("sabotage", self.modifier));
  var_4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var_0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var_2, var_1, var_3, undefined, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_complete", var_0);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_success", self.team, 1);
  self.ref_12d2d = undefined;
  self.ref_12d2e = (0, 0, 0);
  self.ref_12d2b = (0, 0, 0);
  self.result = "success";

  if(getdvarint("scr_br_sabotage_award_truck", 1) == 1 || getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1) {
    var_5 = sabotage_truck_check_roof(self.ref_13a92.origin, self.ref_13a92);
    var_6 = self.ref_13a92;

    if(isDefined(var_5) && var_5.size > 0) {
      var_6.origin = var_5["position"] + (0, 0, 6);
    } else {
      var_6.origin = getclosestpointonnavmesh(var_6.origin);
    }

    var_7 = getvehiclespawnStruct(var_6);
    sabotage_spawnVehicle(var_6, var_7);
  }

  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function getvehiclespawnStruct(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("ks_airdrop_crate_br");
  var_1 setscriptablepartstate("smoke_signal", "on", 0);
  var_2 = 17;

  if(getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1) {
    var_2 = 19;
  }

  var_1 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, var_2, 2, var_0.origin);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1316f(1150);
  var_1 scripts\mp\gametypes\br_quest_util::ref_13369();
  var_1.location = var_0;
  return var_1;
}

function sabotage_spawnVehicle(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0.origin + (0, 0, 50000);
  var_3 = getrewardvehicle(var_2);

  if(isDefined(var_3)) {
    var_4 = (0, var_1.location.angles[1], 0);
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var_3, var_1.location.origin, var_4, 1);
    var_1 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    thread scripts\mp\gametypes\br_publicevent_armoredtruck::ref_14235(var_3, var_1);
    return;
  }
}

function getrewardvehicle(var_0, var_1) {
  if(getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1) {
    if(!isDefined(var_0.angles)) {
      var_0.angles = (0, randomfloat(360), 0);
    }

    var_2 = spawnStruct();
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    var_2.spawntype = "GAME_MODE";
    var_2.showheadicon = 1;
    return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("open_jeep_carpoc", var_2, var_1);
  }

  return scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var_1);
}

function ref_12e3c() {
  self.ref_12d2d = undefined;
  self.result = "fail";
  self.ref_12d2d = undefined;
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_12e4a() {
  if(isDefined(self.ref_13a92) && self.ŽK / ÃsˆE÷£ èûË == 1) {
    if(sabotage_isvehicleincircle(self.ref_13a92)) {
      scripts\mp\gametypes\br_quest_util::ref_11db0(self.ref_13a92.veh_origin);
      return;
    }

    sabotage_circle_fail(self);
    return;
  }
}

function ref_12e41() {
  var_0 = [];
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  foreach(var_4 in level.vehicle.instances) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(isDefined(var_6.name)) {
          if(var_6.name == "convoy_truck") {
            continue;
          }
        }

        if(distance2d(var_6.origin, var_1) >= var_2 && var_2 > 0) {
          continue;
        }

        if(istrue(var_6.isdestroyed)) {
          continue;
        }

        var_0 = var_6;
      }
    }
  }

  return var_0;
}

function ref_12e4c(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, []);
}

function sabotage_isvehicleincircle(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(isDefined(var_0)) {
    if(distance2d(var_0.origin, var_1) >= var_2 && var_2 > 0) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function ref_12e42(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_1.ŽK / ÃsˆE÷£ èûË)) {
    if(var_1.ŽK / ÃsˆE÷£ èûË == 1) {
      if(isDefined(var_0.center_node)) {
        var_2 = 0;

        for(var_3 = var_0.center_node.size - 1; var_3 >= 0; var_3--) {
          if(var_2 >= getdvarint("scr_sabotage_attacker_buffer", 3)) {
            break;
          }

          if(var_0.center_node[var_3].team == var_1.semtex_stuckplayer.team) {
            ref_12e3b(var_1);
            return;
          }

          var_2++;
        }

        ref_12e49(var_1, 0);
        return;
      }

      sabotage_circle_fail(var_1);
      return;
    }

    return;
  }
}

function sabotage_circle_fail(var_0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_circle_consumed", var_0.team, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_0.team, "br_sabotage_quest_circle_failure");
  ref_12e3c(var_0);
}

function sabotage_truck_check_roof(var_0, var_1) {
  var_2 = var_0 + (0, 0, getdvarint("scr_sabotage_truck_drop_max_check_Height", 3937));
  var_3 = var_0 + (0, 0, 10);
  var_4 = [var_1];
  var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);
  var_6 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_2, 0, -100000, var_5, var_4);
  return var_6;
}