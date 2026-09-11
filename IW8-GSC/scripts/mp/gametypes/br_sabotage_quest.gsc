/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_sabotage_quest.gsc
******************************************************/

function init() {
  var0 = getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1;

  if(getdvarint("scr_br_sabotage_award_truck", 1) == 1 || var0) {
    scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata(var0);
    scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_loadoutchangeremovehcr();
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13df8();
  }

  var1 = scripts\mp\gametypes\br_quest_util::registerquestcategory("sabotage", 1);

  if(!var1) {
    return;
  }

  var1 = scripts\mp\gametypes\br_quest_util::registerquestcategory("sabotage_redacted", 1);

  if(var1) {
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

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("sabotage", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var2 = "";

  if(var0.type == "brloot_redacted_sabotage_tablet") {
    var2 = "_redacted";
  }

  var1.modifier = var2;
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var1.team = self.team;
  var1.semtex_stuckplayer = self;
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.ŽK / ÃsˆE÷£ èûË = 1;
  var3 = ref_12e41();
  var4 = ref_12e4c(var1, var3);
  var1.ref_14261 = sortbydistance(var4[0], var1.semtex_stuckplayer.origin);
  var1.ref_1426a = sortbydistance(var4[1], var1.semtex_stuckplayer.origin);

  if(isDefined(var1.ref_14261)) {
    if(var1.ref_14261.size > 0) {
      for(var5 = 0; var5 < var1.ref_14261.size; var5++) {
        if(isDefined(var1.ref_14261[var5].ref_13aad)) {
          if(var1.ref_14261[var5].ref_13aad != var1.semtex_stuckplayer.team && var1.ref_14261[var5].occupants.size > 0) {
            var6 = 0;

            for(var7 = 0; var7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var7++) {
              if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var7] == var1.ref_14261[var5]) {
                var6 = 1;
                break;
              }
            }

            if(!var6) {
              var1.ref_13a92 = var1.ref_14261[var5];
            }
          }
        }

        if(!isDefined(var1.ref_13a92)) {
          var6 = 0;

          for(var7 = 0; var7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var7++) {
            if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var7] == var1.ref_14261[var5]) {
              var6 = 1;
              break;
            }
          }

          if(!var6) {
            var1.ref_13a92 = var1.ref_14261[var5];
          }
        }
      }
    }
  }

  if(isDefined(var1.ref_1426a)) {
    if(var1.ref_1426a.size > 0) {
      for(var5 = var1.ref_1426a.size - 1; var5 >= 0; var5--) {
        if(isDefined(var1.ref_1426a[var5].ref_13aad)) {
          if(var1.ref_1426a[var5].ref_13aad != var1.semtex_stuckplayer.team && var1.ref_1426a[var5].occupants.size > 0) {
            var6 = 0;

            for(var7 = 0; var7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var7++) {
              if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var7] == var1.ref_1426a[var5]) {
                var6 = 1;
                break;
              }
            }

            if(!var6) {
              var1.ref_13a92 = var1.ref_1426a[var5];
            }
          }
        }

        if(!isDefined(var1.ref_13a92)) {
          var6 = 0;

          for(var7 = 0; var7 < scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size; var7++) {
            if(scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[var7] == var1.ref_1426a[var5]) {
              var6 = 1;
              break;
            }
          }

          if(!var6) {
            var1.ref_13a92 = var1.ref_1426a[var5];
          }
        }
      }
    }
  }

  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_sabotage_objective_enemy", "active");
  ref_12e3f(var1);
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(getdvarint("scr_br_sabotage_questTimeBase", 180), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("sabotage", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("sabotage", self, self.team);
  var8 = spawnStruct();
  var8.excludedplayers = [];
  var8.excludedplayers[0] = self;
  var8.ogangles = [];
  var8.ogangles[0] = var1.team;
  var8.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("sabotage", scripts\mp\gametypes\br_quest_util::ringing(self.team), var1.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var1.team, "br_sabotage_quest_start_team", var8);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var1.semtex_stuckplayer, "br_sabotage_quest_start_tablet_finder", var8);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_accept", var1.team, 1, 0.5);

  if(isDefined(var1.ref_13a92)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76[scripts\mp\gametypes\br_quest_util::getquestdata("sabotage").ref_13a76.size] = var1.ref_13a92;
    var1.ref_13a92.ref_12970 = var1;
    var1.ref_13a92.center_node = [];
    return;
  }

  ref_12e49(var1, 1);
}

function ref_12e3f() {
  objective_addalltomask(self.objectiveiconid);
  var0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var2 in var0["valid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("sabotage" + self.modifier);
    scripts\mp\gametypes\br_quest_util::ref_1336c(var2);
  }

  foreach(var2 in var0["invalid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var2);
  }
}

function ref_12e46(var0, var1) {
  ref_12e48(var1, var0);
}

function ref_12e47(var0) {
  ref_12e48(var0);
}

function ref_12e43(var0) {
  ref_12e3e(var0);
}

function ref_12e44(var0) {
  if(var0.team == self.team) {
    ref_12e40(var0);
    scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
    return;
  }

  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_12e48(var0, var1) {
  if(var0.team == self.team) {
    ref_12e3e(var0);
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
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

function ref_12e40(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("sabotage" + self.modifier);
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_12e3e(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_12e3d() {
  foreach(var1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    ref_12e3e(var1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function ref_12e49(var0) {
  wait 2;
  self.ref_12d2d = "_poached";
  var1 = spawnStruct();
  var2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var3 = scripts\mp\gametypes\br_quest_util::getquestindex("sabotage");
  var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("sabotage", self.ref_12d2d, self.modifier));
  var5 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var2, var4, undefined, var5);

  if(var0) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_novehicle", var1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_fail", self.team, 1);
  } else {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_poached", var1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_fail", self.team, 1);
  }

  self.ref_12d2e = (0, 0, 0);
  self.ref_12d2b = (0, 0, 0);
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_12e3b() {
  var0 = spawnStruct();
  var1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var2 = scripts\mp\gametypes\br_quest_util::getquestindex("sabotage" + self.modifier);
  var3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("sabotage", self.modifier));
  var4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var2, var1, var3, undefined, var4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_sabotage_quest_complete", var0);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_success", self.team, 1);
  self.ref_12d2d = undefined;
  self.ref_12d2e = (0, 0, 0);
  self.ref_12d2b = (0, 0, 0);
  self.result = "success";

  if(getdvarint("scr_br_sabotage_award_truck", 1) == 1 || getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1) {
    var5 = sabotage_truck_check_roof(self.ref_13a92.origin, self.ref_13a92);
    var6 = self.ref_13a92;

    if(isDefined(var5) && var5.size > 0) {
      var6.origin = var5["position"] + (0, 0, 6);
    } else {
      var6.origin = getclosestpointonnavmesh(var6.origin);
    }

    var7 = getvehiclespawnStruct(var6);
    sabotage_spawnVehicle(var6, var7);
  }

  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function getvehiclespawnStruct(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 setModel("ks_airdrop_crate_br");
  var1 setscriptablepartstate("smoke_signal", "on", 0);
  var2 = 17;

  if(getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1) {
    var2 = 19;
  }

  var1 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, var2, 2, var0.origin);
  var1 scripts\mp\gametypes\br_quest_util::ref_1316f(1150);
  var1 scripts\mp\gametypes\br_quest_util::ref_13369();
  var1.location = var0;
  return var1;
}

function sabotage_spawnVehicle(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0.origin + (0, 0, 50000);
  var3 = getrewardvehicle(var2);

  if(isDefined(var3)) {
    var4 = (0, var1.location.angles[1], 0);
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var3, var1.location.origin, var4, 1);
    var1 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    thread scripts\mp\gametypes\br_publicevent_armoredtruck::ref_14235(var3, var1);
    return;
  }
}

function getrewardvehicle(var0, var1) {
  if(getdvarint("scr_br_sabotage_award_carpoc_jeep", 0) == 1) {
    if(!isDefined(var0.angles)) {
      var0.angles = (0, randomfloat(360), 0);
    }

    var2 = spawnStruct();
    var2.origin = var0.origin;
    var2.angles = var0.angles;
    var2.spawntype = "GAME_MODE";
    var2.showheadicon = 1;
    return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("open_jeep_carpoc", var2, var1);
  }

  return scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var1);
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
  var0 = [];
  var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  foreach(var4 in level.vehicle.instances) {
    foreach(var6 in var4) {
      if(isDefined(var6)) {
        if(isDefined(var6.name)) {
          if(var6.name == "convoy_truck") {
            continue;
          }
        }

        if(distance2d(var6.origin, var1) >= var2 && var2 > 0) {
          continue;
        }

        if(istrue(var6.isdestroyed)) {
          continue;
        }

        var0 = var6;
      }
    }
  }

  return var0;
}

function ref_12e4c(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, []);
}

function sabotage_isvehicleincircle(var0) {
  var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(isDefined(var0)) {
    if(distance2d(var0.origin, var1) >= var2 && var2 > 0) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function ref_12e42(var0, var1) {
  level endon("game_ended");

  if(isDefined(var1.ŽK / ÃsˆE÷£ èûË)) {
    if(var1.ŽK / ÃsˆE÷£ èûË == 1) {
      if(isDefined(var0.center_node)) {
        var2 = 0;

        for(var3 = var0.center_node.size - 1; var3 >= 0; var3--) {
          if(var2 >= getdvarint("scr_sabotage_attacker_buffer", 3)) {
            break;
          }

          if(var0.center_node[var3].team == var1.semtex_stuckplayer.team) {
            ref_12e3b(var1);
            return;
          }

          var2++;
        }

        ref_12e49(var1, 0);
        return;
      }

      sabotage_circle_fail(var1);
      return;
    }

    return;
  }
}

function sabotage_circle_fail(var0) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("sabotage_circle_consumed", var0.team, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var0.team, "br_sabotage_quest_circle_failure");
  ref_12e3c(var0);
}

function sabotage_truck_check_roof(var0, var1) {
  var2 = var0 + (0, 0, getdvarint("scr_sabotage_truck_drop_max_check_Height", 3937));
  var3 = var0 + (0, 0, 10);
  var4 = [var1];
  var5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);
  var6 = scripts\mp\gametypes\br_public::modifytriggerlocation(var2, 0, -100000, var5, var4);
  return var6;
}