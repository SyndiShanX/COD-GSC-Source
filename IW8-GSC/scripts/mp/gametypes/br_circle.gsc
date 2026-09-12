/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_circle.gsc
***********************************************/

function initcircle() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("circle")) {
    level.br_circle_disabled = 1;
    return;
  }

  if(!isDefined(level.br_level)) {
    return;
  }

  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;

  if(getdvarint("scr_br_circle_fixed_damage", 0) > 0) {
    level.br_circle.damagetick = [getdvarint("scr_br_circle_fixed_damage", 0)];
  } else if(level.mapname == "mp_quarry2" || level.mapname == "mp_prison" || level.mapname == "mp_lumber") {
    level.br_circle.damagetick = [9, 9, 9, 9, 9];
  } else {
    level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];
  }

  ref_1312a();
  var_0 = getdvarvector("br_final_circle_override", (0, 0, 0));

  if(length(var_0) > 0) {
    level.br_circle.br_finalcircleoverride = var_0;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getFinalCircleCenter")) {
    level.br_circle.br_finalcircleoverride = scripts\mp\gametypes\br_gametypes::ref_12e05("getFinalCircleCenter");
  }

  setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[0]);
  level.br_circle.circleindex = -1;
  allplayers_setphysicaldof();
  var_1 = level.br_level.br_circleradii.size;

  if(isDefined(var_1) && var_1 > 0) {
    teleport_entities_inside_subway_car(var_1);
    return;
  }

  teleport_entities_inside_subway_car(12);
}

function ref_1312a() {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start)) {
    level.debug_vault_assault_retrieve_saw_obj_start = [];
  }

  if(getDvar("scr_br_circle_exclude_values") != "") {
    var_0 = strtok(getDvar("scr_br_circle_exclude_values"), ",");

    if(var_0.size % 4 != 0) {
      return;
    }

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = int(var_0[var_1]);
      var_3 = var_2 + "";

      if(var_3 != var_0[var_1]) {
        return;
      }

      var_0 = var_2;
    }

    var_1 = 0;

    while(var_1 < var_0.size) {
      level.debug_vault_assault_retrieve_saw_obj_start[level.debug_vault_assault_retrieve_saw_obj_start.size] = init_safehouse_gunshop((var_0[var_1], var_0[var_1 + 1], var_0[var_1 + 2]), var_0[var_1 + 3]);
      var_1 += 4;
    }

    return;
  }
}

function teleport_players_inside_subway_car(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.br_circle)) {
    return;
  }

  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;
  level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];
  var_5 = level.br_level.br_circleclosetimes.size - 1;

  if(!isDefined(var_2) || var_2 < 0) {
    var_2 = 0;
  } else if(var_2 > var_5) {
    var_2 = var_5;
  }

  var_6 = level.br_level.br_circleclosetimes.size - var_2;
  var_7 = level.br_level.br_circleradii[0];

  if(!isDefined(var_3) || var_3 <= 0) {
    var_3 = level.br_level.br_circleclosetimes[0];
  }

  level.br_circle.circleindex = -1;
  level.br_level.ground_trigger_pipes_room = undefined;
  level.br_circle.damagetick = ignorefallback(level.br_circle.damagetick, var_2);
  level.br_level.br_circleclosetimes = ignorefallback(level.br_level.br_circleclosetimes, var_2);
  level.br_level.br_circledelaytimes = safehouse_vo_return_end(var_6, var_1);
  level.br_level.default_player_connect_black_screen = safehouse_vo_return_end(var_6, var_1);
  level.br_level.default_suicidebomber_combat = ignorefallback(level.br_level.default_suicidebomber_combat, var_2);
  level.br_level.br_circleminimapradii = ignorefallback(level.br_level.br_circleminimapradii, var_2);
  level.br_level.br_circleradii = ignorefallback(level.br_level.br_circleradii, var_2);
  level.br_level.br_circleradii[0] = var_7;
  level.br_level.br_circleclosetimes[0] = var_3;

  if(isDefined(var_4)) {
    level.br_level.br_circledelaytimes[1] = var_4;
  }

  level.br_circle.br_finalcircleoverride = var_0;
  cacheentity();
  thread allplayers_setphysicaldof();
  level.br_circle.br_finalcircleoverride = undefined;
  level notify("CirclePeekCleanup");

  if(isDefined(level.gulag_tutorial_vo)) {
    foreach(var_9 in level.gulag_tutorial_vo) {
      var_9 delete();
    }

    level.gulag_tutorial_vo = undefined;
    scripts\mp\gametypes\br_quest_util::ref_13234();
  }

  thread ref_12e09(0);
}

function ignorefallback(var_0, var_1) {
  if(var_1 == 0) {
    return var_0;
  }

  var_0 = scripts\engine\utility::array_slice(var_0, var_1, var_0.size);
  return var_0;
}

function safehouse_vo_return_end(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, 0, var_1);
}

function getsafecircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    return (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  }

  return (0, 0, 0);
}

function getsafecircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    return level.br_circle.safecircleent.origin[2];
  }

  return 0;
}

function getdangercircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    return (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  }

  return (0, 0, 0);
}

function getdangercircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    return level.br_circle.dangercircleent.origin[2];
  }

  return 0;
}

function reset_timescalefactor() {
  var_0 = level.br_circle.circleindex + 2;

  if(var_0 < level.br_level.default_class_chosen.size) {
    return level.br_level.default_class_chosen[var_0];
  }

  return undefined;
}

function reset_totals_keep_type() {
  var_0 = level.br_circle.circleindex + 2;

  if(var_0 < level.br_level.br_circleradii.size) {
    return level.br_level.br_circleradii[var_0];
  }

  return undefined;
}

function get_best_goal_closest_to_any_player() {
  return isDefined(level.br_circle.safecircleent) && !istrue(level.br_circle.safecircleent.hidden);
}

function get_bcrumbstruct_proximity() {
  return isDefined(level.br_circle.dangercircleent) && !istrue(level.br_circle.dangercircleent.hidden);
}

function ref_12519() {
  if(istrue(self.ref_14439)) {
    return false;
  }

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed)) {
      return false;
    }
  }

  if(istrue(self.unset_relic_thirdperson)) {
    return false;
  }

  return get_bcrumbstruct_proximity();
}

function cancircledamageplayer(var_0) {
  return isalive(var_0) && ref_12519(var_0) && !istrue(var_0.gulag) && !istrue(var_0.inrespawnc130) && !var_0 scripts\mp\gametypes\br_public::ref_125f3() && !var_0 scripts\mp\gametypes\br_public::ref_125ec();
}

function ref_13e18() {
  var_0 = self;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.vehicle_collision_getleveldata)) {
    return;
  }

  if(!isDefined(var_0.operatorcustomization)) {
    return;
  }

  if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }

  if(isDefined(var_0.did_ads_hint) && gettime() < var_0.did_ads_hint) {
    return;
  }

  var_0.did_ads_hint = gettime() + randomintrange(5000, 7000);

  if(!isai(var_0)) {
    var_0 playsoundtoplayer("gas_player_cough", var_0, var_0);
  }

  var_1 = "allies_male_cough";
  var_2 = scripts\mp\gametypes\br_public::disableannouncer(var_0);
  var_3 = var_0.operatorcustomization.gender;

  if(var_2 == "axis") {
    if(isDefined(var_3) && var_3 == "female") {
      var_1 = "axis_female_cough";
    } else {
      var_1 = "axis_male_cough";
    }
  } else if(isDefined(var_3) && var_3 == "female") {
    var_1 = "allies_female_cough";
  } else {
    var_1 = "allies_male_cough";
  }

  var_4 = randomint(game["dialogue"][var_1].size);
  var_5 = game["dialogue"][var_1][var_4];
  var_0 playsoundonmovingent(var_5);
}

function ref_131a0() {
  if(!isDefined(self.ref_125e4)) {
    self.ref_125e4 = gettime();
    return;
  }
}

function ref_12c79() {
  self.ref_125e4 = undefined;
}

function firstteam() {
  var_0 = [60, 90, 120];
  var_1 = [2, 3, 10];
  var_2 = spawnStruct();
  var_2.enabled = getdvarint("scr_player_gas_timer_mult_enabled", 1);
  var_2.ref_11f3f = getdvarint("scr_player_gas_timer_mult_count", 3);
  var_2.ref_13b7b = [];
  var_2.ref_11e09 = [];
  var_3 = 0;
  var_4 = 1;

  for(var_5 = 0; var_5 < var_2.ref_11f3f; var_5++) {
    var_6 = undefined;
    var_7 = undefined;

    if(var_5 < var_0.size) {
      var_6 = var_0[var_5];
      var_7 = var_1[var_5];
      var_3 = var_6;
      var_4 = var_7;
    } else {
      var_3 += 1;
      var_4 += 1;
      var_6 = var_3;
      var_7 = var_4;
    }

    var_2.ref_13b7b[var_5] = getdvarfloat("scr_player_gas_timer_mult_time_" + scripts\engine\utility::string(var_5 + 1), var_6);
    var_2.ref_11e09[var_5] = getdvarfloat("scr_player_gas_timer_mult_mult_" + scripts\engine\utility::string(var_5 + 1), var_7);
  }

  return var_2;
}

function relic_nuketimer(var_0, var_1) {
  if(!var_0.enabled) {
    return var_1;
  }

  if(!isDefined(self.ref_125e4)) {
    return var_1;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.ffsm_onground_stateenter) && self.vehicle.vehiclename == "veh_bt") {
      return level.ffsm_onground_stateenter;
    }

    if(isDefined(level.pickedupcoreminigun) && self.vehicle.vehiclename == "veh_a10fd") {
      return level.pickedupcoreminigun;
    }
  }

  var_2 = (gettime() - self.ref_125e4) * 0.001;
  var_3 = var_0.ref_11f3f - 1;

  while(var_3 >= 0) {
    var_4 = var_0.ref_13b7b[var_3];

    if(var_2 >= var_4) {
      var_5 = var_0.ref_11e09[var_3];
      return int(var_1 * var_5);
    }

    var_4--;
  }

  return var_2;
}

function circledamagetick() {
  level endon("game_ended");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0) {
    waitframe();
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  var_0 = getdvarfloat("scr_br_circle_object_cleanup_threshold", 2400);
  var_1 = getdvarfloat("scr_br_circle_radio_cleanup_threshold", 1000);
  var_2 = firstteam();

  for(;;) {
    if(isDefined(level.br_circle.dangercircleent)) {
      var_3 = level.br_circle.circleindex;

      if(var_3 > level.br_circle.damagetick.size - 1) {
        var_3 = level.br_circle.damagetick.size - 1;
      }

      var_4 = level.br_circle.damagetick[var_3];

      if(isDefined(level.circledamagemultiplier)) {
        var_4 *= level.circledamagemultiplier;
      }

      if(var_4 > 0) {
        var_5 = getdangercircleorigin();
        var_6 = getdangercircleradius();

        foreach(var_8 in level.players) {
          if(!isDefined(var_8) || !isDefined(var_8.origin)) {
            continue;
          }

          if(isDefined(var_8) && istrue(var_8.start_death_from_above_sequence)) {
            continue;
          }

          if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("circleEarlyStart") && istrue(var_8.plotarmor)) {
            ref_12c79(var_8);
            continue;
          }

          var_9 = 0;

          if(distance2dsquared(var_5, var_8.origin) > var_6 * var_6) {
            if(cancircledamageplayer(var_8, var_8)) {
              var_9 = 1;
              ref_131a0(var_8);
              var_10 = relic_nuketimer(var_8, var_2, var_4);

              if(scripts\cp_mp\gasmask::hasgasmask(var_8)) {
                if(scripts\mp\gametypes\br_pickups::ks_circlecount(var_8)) {
                  if(!istrue(var_8.gasmaskequipped)) {
                    ref_1384c(var_8, var_10);

                    if(!isalive(var_8)) {
                      continue;
                    }
                  }

                  var_8 scripts\cp_mp\gasmask::processdamage(var_10);
                } else {
                  if(!istrue(level.gasmasktoggledisable) && !istrue(var_8.gasmaskequipped) && !istrue(var_8.gasmaskswapinprogress) && var_8 method_87eb()) {
                    ref_1384c(var_8, var_10);

                    if(!isalive(var_8)) {
                      continue;
                    }
                  }

                  if(isDefined(var_8.gasmaskhealth) && var_8.gasmaskhealth <= 0) {
                    var_8 playsoundtoplayer("br_gas_mask_crack_plr", var_8);
                    var_8 scripts\mp\gametypes\br_pickups::handleweaponreloadammodrop();
                  } else {
                    var_8 scripts\mp\gametypes\br_pickups::plunderrepositoryref("br_circle");
                    var_8 scripts\cp_mp\gasmask::processdamage(var_10);
                  }
                }
              } else {
                ref_1384c(var_8, var_10);
              }
            } else {
              ref_12c79(var_8);
            }
          } else {
            ref_12c79(var_8);

            if(scripts\cp_mp\gasmask::hasgasmask(var_8)) {
              if(scripts\mp\gametypes\br_pickups::ks_circlecount(var_8)) {
                continue;
              } else if(isDefined(var_8.gasmaskhealth) && var_8.gasmaskhealth <= 0) {
                var_8 playsoundtoplayer("br_gas_mask_crack_plr", var_8);
                var_8 scripts\mp\gametypes\br_pickups::handleweaponreloadammodrop();
              } else {
                var_8 scripts\mp\gametypes\br_pickups::plunderrankupdate("br_circle");
              }
            }
          }

          if(scripts\mp\utility\game::getgametype() == "br") {
            ref_13fe3(var_8, var_9);
          }
        }

        var_12 = var_6 + var_0;
        var_13 = var_6 + var_1;
        scripts\mp\gametypes\br_plunder::dangercircletick(var_5, var_12);
        scripts\mp\gametypes\br_respawn::dangercircletick(var_5, var_12);
        scripts\mp\gametypes\br_quest_util::dangercircletick(var_5, var_6, var_12);
        scripts\mp\gametypes\br_armory_kiosk::dangercircletick(var_5, var_12);
        scripts\mp\gametypes\br_armory_trader::dangercircletick(var_5, var_12);
        scripts\mp\gametypes\br_vehicles::dangercircletick(var_5, var_6);
        scripts\mp\gametypes\br_pickups::dangercircletick(var_5, var_6);
        scripts\mp\gametypes\br_publicevents::dangercircletick(var_5, var_6);
        scripts\mp\gametypes\br_satellite_hunt::dangercircletick(var_5, var_6);
        scripts\mp\gametypes\br_numbers_tower::dangercircletick(var_5, var_6);
        scripts\mp\equipment\binoculars::isbossheli(var_5, var_6);
        scripts\mp\gametypes\br_gametypes::ref_12e05("dangerCircleTick", var_5, var_12);
        scripts\mp\gametypes\br_gametypes::ref_12e05("dangerCircleTickActual", var_5, var_6);
        _findgivearmoramountanddropleftovers::dangercircletick(var_5, var_12);

        if(getdvarint("scr_br_alt_mode_escape", 0)) {
          scripts\mp\gametypes\br_alt_mode_escape::dangercircletick(var_5, var_13, var_6);
        }

        if(getdvarint("scr_city_killers_convoy_event_active", 0) && isDefined(level.hudextractnum)) {
          [[level.hudextractnum]](var_5, var_6);
        }

        if(getdvarint("scr_br_using_exfil_radio", 0) && isDefined(level.onmatchplacement)) {
          [[level.onmatchplacement]](var_5, var_13, var_6);
        }

        if(getdvarint("scr_wz320_ai_events", 0) && isDefined(level.next_drone_cd)) {
          [[level.next_drone_cd]](var_5, var_6);
        }
      }
    }

    wait 1;
  }
}

function ref_1384c(var_0) {
  var_1 = self;

  if(isDefined(level.ref_11c95)) {
    var_0 = var_1[[level.ref_11c95]](var_0);
  }

  if(var_1 scripts\mp\utility\killstreak::isjuggernaut()) {
    var_0 = scripts\mp\gametypes\br_jugg_common::ref_11c95(var_0);
  }

  var_1 dodamage(var_0, var_1.origin, var_1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

  if(var_1 scripts\mp\gametypes\br_public::hasarmor()) {
    var_1 scripts\mp\gametypes\br_public::damagearmor(var_0);
  }

  if(isalive(var_1)) {
    ref_13e18(var_1);
    return;
  }
}

function ref_13fe3(var_0) {
  if(!isDefined(self.unset_relic_shieldsonly)) {
    self.unset_relic_shieldsonly = var_0;
    self.waittill_see_infl_lbravo_long_enough = gettime();
  }

  if(self.unset_relic_shieldsonly != var_0) {
    self.unset_relic_shieldsonly = var_0;
    var_1 = gettime();

    if(var_0) {
      scripts\cp\vehicles\vehicle_compass_cp::ref_1383b("alive_in_gas");
      scripts\mp\gametypes\br_analytics::descendpos(self, var_1 - self.waittill_see_infl_lbravo_long_enough);
    } else {
      scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_in_gas");
      scripts\mp\gametypes\br_analytics::descendsolostarts(self, var_1 - self.waittill_see_infl_lbravo_long_enough);
    }

    self.waittill_see_infl_lbravo_long_enough = var_1;
    return;
  }
}

function startuiclosetimer(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e07("startUICloseTimer", var_0, var_1, var_2, var_3))) {
    return;
  }

  setomnvar("ui_hardpoint_timer", gettime() + int(var_0 * 1000));
  var_4 = ref_13322();

  if(var_1 == 0) {
    var_1 = !scripts\mp\flags::gameflag("br_ready_to_jump");
  }

  if(!var_1) {
    foreach(var_6 in level.players) {
      if(!isbot(var_6) && !var_6 scripts\mp\gametypes\br_public::isplayeringulag()) {
        if(istrue(var_2)) {
          var_6 thread scripts\mp\hud_message::showsplash("br_final_circle");
          continue;
        }

        if(!var_4 || var_3 > 1) {
          var_6 thread scripts\mp\hud_message::showsplash("br_new_circle");
        }
      }
    }
  }

  if(istrue(var_2)) {
    setomnvar("ui_br_circle_state", 3);
  } else {
    setomnvar("ui_br_circle_state", 0);
  }

  var_8 = [60, 30, 20, 10, 0];
  var_9 = var_8.size - 1;

  for(var_10 = 0; var_10 < var_8.size; var_10++) {
    if(var_0 > var_8[var_10]) {
      var_9 = var_10;
      break;
    }
  }

  if(var_0 < var_8[var_9]) {
    return;
  }

  wait var_0 - var_8[var_9];

  for(var_10 = var_9; var_10 < var_8.size - 1; var_10++) {
    if(var_10 == 2) {
      thread scripts\mp\music_and_dialog::debugtype();
    }

    if(var_10 == 3) {
      setomnvar("ui_br_circle_state", 2);
    }

    wait var_8[var_10] - var_8[var_10 + 1];
  }

  level notify("br_circle_closing");

  if(!var_1) {
    foreach(var_6 in level.players) {
      if(!isbot(var_6) && !var_6 scripts\mp\gametypes\br_public::isplayeringulag() && (!var_4 || var_3 > 0)) {
        if(istrue(level.vehicle_collision_getleveldata)) {
          var_6 scripts\engine\utility::delaythread(2, &scripts\mp\hud_message::showsplash, "br_x1_1");
        } else {
          var_6 thread scripts\mp\hud_message::showsplash("br_circle_moving");
        }

        var_6 playlocalsound("br_circle_closing");
      }
    }
  }

  setomnvar("ui_br_circle_state", 1);
}

function all_players_are_in_trap_room_entrance() {
  setomnvar("ui_br_circle0_start_time", 0);
}

function ref_131ad(var_0) {
  if(scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "x2" && scripts\mp\utility\game::round_vehicle_logic() != "respect") {
    setomnvar("ui_br_circle0_start_entity", var_0);
  }

  setomnvar("ui_br_circle0_end_entity", var_0);
}

function setstaticuicircles(var_0, var_1, var_2, var_3) {
  var_4 = ammo_buy_point_loop(var_0);
  setomnvar("ui_br_circle0_start_time", gettime());
  setomnvar("ui_br_circle0_duration", var_4);

  if(scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "x2" && scripts\mp\utility\game::round_vehicle_logic() != "respect") {
    setomnvar("ui_br_circle0_start_entity", var_1);
  }

  setomnvar("ui_br_circle0_end_entity", var_1);

  if(istrue(var_3)) {
    all_players_are_in_trap_room_entrance();
  }

  var_4 = adjust_damage_based_on_weaponclass(var_0);
  setomnvar("ui_br_circle1_start_time", gettime());
  setomnvar("ui_br_circle1_duration", var_4);
  setomnvar("ui_br_circle1_start_entity", var_2);
  setomnvar("ui_br_circle1_end_entity", var_2);
  thread updatecirclehide(var_0, var_1, var_2);
}

function setclosinguicircle(var_0, var_1, var_2, var_3) {
  var_4 = ammo_buy_point_loop(var_0);
  setomnvar("ui_br_circle0_start_time", gettime());
  setomnvar("ui_br_circle0_duration", var_4);

  if(scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "x2" && scripts\mp\utility\game::round_vehicle_logic() != "respect") {
    setomnvar("ui_br_circle0_start_entity", var_1);
  }

  setomnvar("ui_br_circle0_end_entity", var_1);

  if(istrue(var_3)) {
    all_players_are_in_trap_room_entrance();
  }

  var_4 = adjust_damage_based_on_weaponclass(var_0);
  setomnvar("ui_br_circle1_start_time", gettime());
  setomnvar("ui_br_circle1_duration", var_4);
  setomnvar("ui_br_circle1_start_entity", var_2);
  setomnvar("ui_br_circle1_end_entity", var_1);
  thread updatecirclehide(var_0, var_1, var_2);
}

function updatecirclehide(var_0, var_1, var_2) {
  level notify("update_circle_omnvars");
  level endon("update_circle_omnvars");

  for(;;) {
    level waittill("update_circle_hide");
    var_3 = ammo_buy_point_loop(var_0);
    setomnvar("ui_br_circle0_duration", var_3);
    var_3 = adjust_damage_based_on_weaponclass(var_0);
    setomnvar("ui_br_circle1_duration", var_3);
  }
}

function adjust_damage_based_on_weaponclass(var_0) {
  if(get_bcrumbstruct_proximity()) {
    return int(var_0 * 1000);
  }

  return 0;
}

function ammo_buy_point_loop(var_0) {
  if(get_best_goal_closest_to_any_player()) {
    return int(var_0 * 1000);
  }

  return 0;
}

function islastcircle() {
  return level.br_circle.circleindex >= level.br_level.br_circleradii.size - 1 || !(level.br_level.br_circleradii[level.br_circle.circleindex + 1] > 0);
}

function groupindex(var_0) {
  var_1 = level.br_level.br_circledelaytimes[var_0];
  var_2 = level.br_level.br_circleclosetimes[var_0];
  var_3 = var_1 + var_2;
  return var_3;
}

function inithelirepository() {
  var_0 = level.br_circle.circleindex;
  var_1 = groupindex(var_0);
  var_2 = level.br_circle.starttime / 1000;
  var_3 = gettime() / 1000 - var_2;
  return var_1 - var_3;
}

function iscurrentcircleclosing() {
  var_0 = level.br_circle.circleindex;

  if(!isDefined(var_0) || var_0 < 0) {
    return false;
  }

  var_1 = inithelirepository();
  var_2 = level.br_level.br_circleclosetimes[var_0];
  return var_1 <= var_2;
}

function helibankplunder(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::array_randomize(scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var_0.team, var_0.squadindex));
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6 != var_0) {
      var_4 = var_6;
      break;
    }
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_8 = var_4.origin;
  var_9 = level.br_circle.circleindex;
  var_10 = level.br_circle.starttime / 1000;
  var_11 = var_1 + gettime() / 1000 + var_2;
  var_12 = max(var_11 - var_10 - level.br_level.br_circledelaytimes[var_9], 0);
  var_13 = int(min(var_9 + 1, level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective - 1));
  var_14 = level.br_level.br_circleclosetimes[var_9];
  var_15 = level.br_level.default_class_chosen[var_9];
  var_16 = level.br_level.br_circleradii[var_9];
  var_17 = level.br_level.default_class_chosen[var_13];
  var_18 = level.br_level.br_circleradii[var_13];
  var_19 = (var_17 - var_15) / var_14;
  var_20 = (var_18 - var_16) / var_14;
  var_21 = var_15 + var_19 * var_12;
  var_22 = var_16 + var_20 * var_12;
  var_23 = distance2d(var_8, var_21);

  if(var_23 == 0) {
    return undefined;
  }

  var_24 = getdvarfloat("scr_br_respawn_dist_away", 1000);
  var_25 = var_8 + (var_21 - var_8) * var_24 / var_23;

  if(vandalize_minigun_speed(var_25, 0, var_1 + var_2)) {
    return var_25;
  }

  var_26 = getdvarfloat("scr_br_respawn_dist_fraction_away", 0.5);
  var_24 = var_23 * var_26;
  var_25 = var_8 + (var_21 - var_8) * var_24 / var_23;

  if(vandalize_minigun_speed(var_25, 0, var_1 + var_2)) {
    return var_25;
  }

  var_27 = var_8 - var_21;
  var_25 = var_21 + var_22 / var_23 * var_27;

  if(vandalize_minigun_speed(var_25, 0, var_1 + var_2)) {
    return var_25;
  }

  return undefined;
}

function vandalize_minigun_speed(var_0, var_1, var_2) {
  if(!scripts\mp\gametypes\br_c130::ispointinbounds(var_0, 1)) {
    return false;
  }

  if(istrue(var_1) && allassassin_teamcompare(var_0)) {
    return false;
  }

  if(isDefined(var_2)) {
    var_3 = getmintimetillpointindangercircle(var_0);

    if(var_2 > var_3) {
      return false;
    }
  }

  return true;
}

function closestsafeperimeterpointfromsquadmate(var_0, var_1) {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_2 = scripts\engine\utility::array_sort_with_func(scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(self.team, self.squadindex), &_compare_higher_health);

    foreach(var_4 in var_2) {
      if(var_4 != self) {
        if(var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() == 0) {
          var_5 = _getclosestsafeperimeterpoint(var_4.origin, var_0, var_1);

          if(isDefined(var_5)) {
            return var_5;
          }
        }
      }
    }
  }

  return undefined;
}

function _compare_higher_health(var_0, var_1) {
  return var_0.health >= var_1.health;
}

function closestsafeperimeterpointfromloadout(var_0, var_1) {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    foreach(var_3 in level.br_pickups.crates) {
      if(!isDefined(var_3) || !isDefined(var_3.team) || var_3.team != self.team) {
        continue;
      }

      if(isDefined(var_3.playerscaptured) && isDefined(var_3.playerscaptured[self getentitynumber()])) {
        continue;
      }

      var_4 = _getclosestsafeperimeterpoint(var_3.origin, var_0, var_1);

      if(isDefined(var_4)) {
        return var_4;
      }
    }
  }

  return undefined;
}

function _getclosestsafeperimeterpoint(var_0, var_1, var_2) {
  var_3 = getsafecircleorigin();
  var_4 = float(getsafecircleradius());
  var_5 = getdangercircleorigin();
  var_6 = getdangercircleradius();
  var_7 = var_4 * var_4;

  if(var_7 > 0) {
    var_8 = distance2d(var_0, var_5);

    if(var_8 == 0) {
      return var_0;
    }

    var_6 = min(var_6, var_8);
    var_9 = 4;

    for(var_10 = var_9; var_10 >= 0; var_10--) {
      var_11 = var_6 * var_10 / var_9;
      var_12 = (var_0 - var_5) * var_11 / var_8 * var_1 + var_5;

      if(vandalize_minigun_speed(var_12, 0, var_2)) {
        if(getdvarint("scr_br_maxRespawnSnapToNavMesh", 1) == 1 && isscriptabledefined()) {
          var_12 = getclosestpointonnavmesh(var_12);

          if(vandalize_minigun_speed(var_12, 0, var_2) == 0) {
            continue;
          }
        }

        return var_12;
      }
    }
  }

  return undefined;
}

function risk_flagspawnshiftingpercent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_5 = istrue(var_5) && isscriptabledefined();
  var_8 = 8;
  var_9 = var_0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 360;

  while(var_10 < var_8) {
    var_13 = getrandompointincircle(var_0, var_1, var_2, var_3, 1, 0, var_11, var_12);

    if(vandalize_minigun_speed(var_13, var_6, var_7)) {
      var_9 = var_13;

      if(var_5) {
        var_13 = getclosestpointonnavmesh(var_9);

        if(vandalize_minigun_speed(var_13, var_6, var_7)) {
          var_9 = var_13;
          break;
        }
      } else {
        break;
      }
    }

    var_14 = level.br_level.default_class_chosen[0] - var_0;
    var_14 = (var_14[0], var_14[1], 0);
    var_15 = vectortoangles(var_14)[1];
    var_16 = (1 - var_10 / var_8) * 180;
    var_11 = var_15 - var_16;
    var_12 = var_15 + var_16;
    var_10++;
  }

  return var_9;
}

function getrandompointincircle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 <= 0) {
    return var_0;
  }

  var_8 = 0;

  if(isDefined(var_2)) {
    var_8 = var_2;
  }

  var_9 = 1;

  if(isDefined(var_3)) {
    var_9 = var_3;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 360;
  }

  var_10 = squared(var_1 * var_8);
  var_11 = squared(var_1 * var_9);
  var_12 = undefined;

  if(var_10 == var_11) {
    var_12 = sqrt(var_10);
  } else {
    var_12 = sqrt(randomfloatrange(var_10, var_11));
  }

  var_13 = var_6 + randomfloat(var_7 - var_6);
  var_14 = (var_12 * cos(var_13), var_12 * sin(var_13), 0);
  var_15 = var_0 + var_14;

  if(var_4) {
    var_16 = scripts\mp\gametypes\br_public::semtex_used();
    var_17 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var_15 = scripts\mp\gametypes\br_public::modifyplayer_damage((var_0[0], var_0[1], 0) + var_14, var_16);
  }

  if(var_5 && isscriptabledefined()) {
    var_15 = getclosestpointonnavmesh(var_15);
  }

  return var_15;
}

function getrandompointincurrentcircle(var_0, var_1) {
  var_2 = getdangercircleorigin();
  var_3 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  return getrandompointincircle(var_2, var_3, var_0, var_1);
}

function riskspawn_flagspawnbytier(var_0, var_1) {
  var_2 = getsafecircleorigin();
  var_3 = getsafecircleradius();
  return getrandompointincircle(var_2, var_3, var_0, var_1);
}

function risk_modifyflagstieronrespawn(var_0, var_1) {
  var_2 = getsafecircleorigin();
  var_3 = getsafecircleradius();
  return risk_flagspawnshiftingpercent(var_2, var_3, var_0, var_1);
}

function ispointincurrentsafecircle(var_0) {
  if(!isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var_1 = (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  var_2 = float(level.br_level.br_circleradii[level.br_circle.circleindex + 1]);
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2) {
    return true;
  }

  return false;
}

function updateprestreamrespawn(var_0) {
  if(!isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var_1 = getdangercircleorigin();
  var_2 = float(getdangercircleradius());
  var_3 = distance2dsquared(var_1, var_0);
  var_4 = var_2 * var_2;
  return var_3 < var_4;
}

function updatescavengerhud(var_0) {
  var_1 = reset_timescalefactor();
  var_2 = float(reset_totals_keep_type());

  if(!isDefined(var_1) || !isDefined(var_2)) {
    return false;
  }

  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2) {
    return true;
  }

  return false;
}

function isblocked() {
  self endon("death");

  for(;;) {
    self show();

    foreach(var_1 in level.players) {
      if(!ref_12519(var_1)) {
        self hidefromplayer(var_1);
      }
    }

    level waittill("update_circle_hide");
  }
}

function allassassin_teamcompare(var_0) {
  if(getdvarint("scr_br_badAreaKillswitch", 0) == 1) {
    return false;
  }

  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start) || level.debug_vault_assault_retrieve_saw_obj_start.size == 0) {
    return false;
  }

  foreach(var_2 in level.debug_vault_assault_retrieve_saw_obj_start) {
    var_3 = distance2dsquared(var_0, var_2.origin);

    if(var_3 < var_2.ref_129e5) {
      return true;
    }
  }

  return false;
}

function allplayers_setphysicaldof(var_0, var_1) {
  level.br_level.default_class_chosen = [];
  var_2 = (level.br_circle.mapbounds[0] + level.br_circle.mapbounds[1]) * 0.5;

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("mapCenterFinalCircle")) {
    var_2 = scripts\mp\gametypes\br_gametypes::ref_12e05("mapCenterFinalCircle");
  }

  level.br_level.default_class_chosen[0] = (var_2[0], var_2[1], 0);
  var_3 = var_2[0];
  var_4 = var_2[1];

  if(istrue(level.br_level.ref_13884)) {
    level.br_level.default_class_chosen[0] = scripts\engine\utility::drop_to_ground((var_3, var_4, 4000));
    level.br_level.default_class_chosen[1] = level.br_level.default_class_chosen[0];
    return;
  }

  var_5 = getdvarfloat("scr_br_circle_first_placement_scale", 0);
  var_6 = var_5 * level.br_level.br_circleradii[1];
  var_7 = [];
  GscBinSkip0(0x2e, 0, level.br_circle.mapbounds[0][0] - var_6);
}

function relic_amped_play_beep() {
  var_0 = (0, 0, 0);
  var_1 = [];
  var_2 = 1;
  var_3 = 0;

  for(;;) {
    var_4 = getdvarvector("scr_br_circle_end_pos_" + var_2, var_0);

    if(var_4 == var_0) {
      break;
    }

    var_5 = spawnStruct();
    var_5.pos = var_4;
    var_5.radius = getdvarfloat("scr_br_circle_end_pos_radius_" + var_2, 0);
    var_6 = getdvarfloat("scr_br_circle_end_pos_weight_" + var_2, 1);

    if(var_6 > 0) {
      var_3 += var_6;
      var_5.weight = var_3;
      var_1 = var_5;
    }

    var_2++;
  }

  if(!var_1.size) {
    return undefined;
  }

  var_7 = undefined;
  var_8 = getdvarint("scr_br_circle_end_pos_force_index", 0);

  if(var_8) {
    var_8 -= 1;

    if(var_8 < var_1.size) {
      var_7 = var_1[var_8];
    }
  } else {
    var_9 = randomfloatrange(0, var_3);

    for(var_10 = 0; var_10 < var_1.size; var_10++) {
      if(var_9 < var_1[var_10].weight) {
        var_7 = var_1[var_10];
        break;
      }
    }
  }

  if(!isDefined(var_7)) {
    return undefined;
  }

  if(var_7.radius > 0) {
    return risk_flagspawnshiftingpercent(var_7.pos, var_7.radius, 0, 1, 1, 1, 1);
  }

  return var_7.pos;
}

function ref_12e09(var_0) {
  level endon("game_ended");
  level endon("br_ending_start");
  level.br_circle.safecircleent = spawn("script_model", (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], level.br_level.br_circleradii[1]));
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui = spawn("script_model", level.br_circle.safecircleent.origin);
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent = spawnbrcircle(level.br_level.default_class_chosen[0][0], level.br_level.default_class_chosen[0][1], level.br_level.br_circleradii[0]);
  level.br_circle.dangercircleent.hidden = 0;
  thread isblocked();
  level.br_circle.dangercircleui = spawn("script_model", level.br_circle.dangercircleent.origin);
  level.br_circle.dangercircleui.hidden = 0;
  ref_131ad(level.br_circle.safecircleent);
  spawn_carriable_at_struct();

  if(istrue(var_0) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  if(istrue(level.usegulag)) {
    scripts\mp\gametypes\br_gulag::ref_13249();
  }

  ref_13348();
  thread circledamagetick();
  thread ref_138d7();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(var_1 = 0; var_1 < level.br_level.br_circledelaytimes.size; var_1++) {
      circletimer(var_1);
    }
  }

  scripts\mp\gametypes\br_armory_kiosk::little_bird_mg_initomnvars();
  scripts\mp\gametypes\br_armory_trader::little_bird_mg_initspawning();
}

function ref_138d7() {
  level notify("stopCirclesAtGameEnd");
  level endon("stopCirclesAtGameEnd");
  level scripts\engine\utility::waittill_any_two("game_ended", "br_ending_start");

  if(scripts\mp\utility\game::getgametype() == "br") {
    setomnvar("ui_hardpoint_timer", 0);
    return;
  }
}

function relic_amped_reset_deathshield_on_revived(var_0) {
  if(!isDefined(level.br_circle)) {
    return -1;
  }

  var_1 = -1;

  for(var_2 = 0; var_2 < level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective; var_2++) {
    var_3 = level.br_level.default_class_chosen[var_2];
    var_4 = level.br_level.br_circleradii[var_2];
    var_5 = distance2d(var_0, var_3);

    if(var_5 >= var_4) {
      break;
    }

    var_1 = var_2;
  }

  return var_1;
}

function getmintimetillpointindangercircle(var_0) {
  if(istrue(level.br_circle_disabled)) {
    return 99999;
  }

  if(!isDefined(level.br_circle)) {
    return -1;
  }

  if(istrue(level.br_level.ref_13884)) {
    return -1;
  }

  var_1 = 0;

  if(level.br_circle.circleindex >= 0) {
    var_2 = level.br_circle.circleindex;
    var_3 = level.br_circle.starttime;
    var_4 = level.br_circle.dangercircleent.origin[2];
    var_5 = level.br_circle.dangercircleent.origin;

    if(var_2 >= level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective) {
      var_2 = level.br_level.default_class_chosen.size - 1;
    }
  } else {
    var_2 = 0;
    var_3 = gettime();
    var_4 = level.br_level.br_circleradii[0];
    var_5 = level.br_level.default_class_chosen[0];
  }

  var_6 = relic_amped_reset_deathshield_on_revived(var_4);

  if(var_6 < 0) {
    return var_5;
  } else if(var_6 < var_2) {
    return var_5;
  } else if(var_6 == var_2) {
    if(distance2d(var_5, var_4) > var_4) {
      return var_5;
    }
  }

  for(var_7 = var_2 + 1; var_7 < var_6; var_7++) {
    var_5 += level.br_level.br_circleclosetimes[var_7];
    var_5 += level.br_level.br_circledelaytimes[var_7];
  }

  var_8 = level.br_level.br_circledelaytimes[var_2];
  var_9 = level.br_level.br_circleclosetimes[var_2];
  var_10 = (gettime() - var_3) / 1000;

  if(var_6 > var_2) {
    var_11 = var_8 + var_9;
    var_5 += var_11 - var_10;
    var_5 += level.br_level.br_circledelaytimes[var_6];
    var_12 = level.br_level.br_circleclosetimes[var_6];
    var_13 = level.br_level.default_class_chosen[var_6];
    var_14 = level.br_level.default_class_chosen[var_6 + 1];
    var_15 = level.br_level.br_circleradii[var_6];
    var_16 = level.br_level.br_circleradii[var_6 + 1];
  } else {
    if(var_16 < var_14) {
      var_6 += var_14 - var_16;
      var_12 = var_15;
    } else {
      var_12 = var_16 - var_12 - var_15;
    }

    var_13 = var_12;
    var_14 = level.br_level.default_class_chosen[var_8 + 1];
    var_15 = var_10;
    var_16 = level.br_level.br_circleradii[var_8 + 1];
  }

  var_15 = float(var_15);
  var_16 = float(var_16);

  if(var_12 == 0) {
    return var_7;
  }

  var_17 = var_6[0];
  var_18 = var_17 * var_17;
  var_19 = var_13[0];
  var_20 = var_19 * var_19;
  var_21 = (var_14[0] - var_13[0]) / var_12;
  var_22 = var_21 * var_21;
  var_23 = var_6[1];
  var_24 = var_23 * var_23;
  var_25 = var_13[1];
  var_26 = var_25 * var_25;
  var_27 = (var_14[1] - var_13[1]) / var_12;
  var_28 = var_27 * var_27;
  var_29 = var_15;
  var_30 = var_29 * var_29;
  var_31 = (var_16 - var_15) / var_12;
  var_32 = var_31 * var_31;
  var_33 = sqrt(pow(2 * var_17 * var_21 - 2 * var_19 * var_21 + 2 * var_23 * var_27 - 2 * var_25 * var_27 + 2 * var_29 * var_31, 2) - 4 * (-1 * var_22 - var_28 + var_32) * (-1 * var_18 + 2 * var_17 * var_19 - var_20 - var_24 + 2 * var_23 * var_25 - var_26 + var_30));
  var_34 = -2 * var_17 * var_21 + 2 * var_19 * var_21 - 2 * var_23 * var_27 + 2 * var_25 * var_27 - 2 * var_29 * var_31;
  var_35 = 2 * (-1 * var_22 - var_28 + var_32);

  if(var_35 == 0) {
    return var_7;
  }

  var_36 = (-1 * var_33 + var_34) / var_35;
  var_37 = (var_33 + var_34) / var_35;

  if(var_36 < 0) {
    var_38 = var_37;
  } else if(var_38 < 0) {
    var_38 = var_37;
  } else {
    var_38 = min(var_38, var_38);
  }

  var_9 += var_38;
  return var_9;
}

function spawn_carriable_at_struct() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleui)) {
    return;
  }

  level.br_circle.dangercircleui.hidden++;
  level.br_circle.dangercircleent.hidden++;
  level notify("update_circle_hide");
}

function spawn_dummy_crate() {
  level.br_circle.safecircleui.hidden++;
  level.br_circle.safecircleent.hidden++;
  level notify("update_circle_hide");
}

function ref_13348() {
  var_0 = level.br_circle.dangercircleent.hidden || level.br_circle.dangercircleent.hidden;
  level.br_circle.dangercircleui.hidden--;
  level.br_circle.dangercircleent.hidden--;
  var_1 = level.br_circle.dangercircleui.hidden || level.br_circle.dangercircleent.hidden;

  if(var_0 && !var_1) {
    level notify("update_circle_hide");
    return;
  }
}

function ref_1336f() {
  var_0 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;
  level.br_circle.safecircleui.hidden--;
  level.br_circle.safecircleent.hidden--;
  var_1 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;

  if(var_0 && !var_1) {
    level notify("update_circle_hide");
    return;
  }
}

function ref_13322() {
  return scripts\mp\utility\game::round_vehicle_logic() == "mini" || scripts\mp\utility\game::round_vehicle_logic() == "mmp" || getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0) || scripts\mp\utility\game::round_vehicle_logic() == "reveal" || isDefined(level.disable_heli_lights) && level.disable_heli_lights.ref_14291 == 3 || getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) != 0;
}

function circletimer(var_0) {
  level endon("game_ended");
  level endon("br_ending_start");

  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("circleTimer", var_0))) {
    return;
  }

  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = var_0;
  var_1 = var_0 == 0;
  var_2 = var_0 == level.br_level.br_circleclosetimes.size - 1;
  var_3 = level.br_level.br_circledelaytimes[var_0];
  var_4 = level.br_level.br_circleclosetimes[var_0];
  var_5 = level.br_level.br_circleradii[var_0 + 1];

  if(ref_13322()) {
    setomnvar("ui_br_circle_num", var_0);
  } else {
    setomnvar("ui_br_circle_num", var_0 + 1);
  }

  thread scripts\mp\gametypes\br_gulag::circletimer(var_0);
  scripts\mp\gametypes\br_gametypes::ref_12e05("circleTimerNext", var_0);
  thread delay_play_depart_vo(level);
  var_6 = level.br_level.default_class_chosen[var_0 + 1];
  level.br_circle.centertarget = var_6;
  level.br_circle.safecircleent.origin = (level.br_circle.centertarget[0], level.br_circle.centertarget[1], var_5);
  level.respawnclosets = gathervalidspawnclosets(var_6, var_5);
  cleanupoutercrates();
  gatheroutercrates(var_6, var_5);
  var_7 = level.br_level.default_player_connect_black_screen[var_0];

  if(var_7 > 0) {
    spawn_carriable_at_struct();
    scripts\engine\utility::delaythread(var_7, &ref_13348);
  }

  var_8 = level.br_level.default_suicidebomber_combat[var_0];

  if(var_8 > 0) {
    spawn_dummy_crate();
    scripts\engine\utility::delaythread(var_8, &ref_1336f);
  }

  thread startuiclosetimer(level, var_3, var_1, var_2);
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = getdangercircleorigin() + (0, 0, getdangercircleradius());
  setstaticuicircles(var_3, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_2);

  if(get_allykilled_alias(var_0)) {
    if(var_1) {
      scripts\mp\gametypes\br_public::brleaderdialog("first_circle", 1);
    } else {
      scripts\mp\gametypes\br_public::brleaderdialog("new_circle", 1);
    }
  }

  if(istrue(level.usegulag)) {
    level thread scripts\mp\gametypes\br_gulag::transitioncircle(var_5, var_3);
  }

  level notify("br_circle_set", var_0 + 1);
  wait var_3;
  level notify("br_circle_started", var_0 + 1);
  level.group_unset_jugg_standstill = 1;
  setomnvar("ui_hardpoint_timer", gettime() + int(var_4 * 1000));

  if(get_allowed_vehicle_types_from_wave(var_0)) {
    if(var_2) {
      scripts\mp\gametypes\br_public::brleaderdialog("final_circle", 1);
    } else {
      scripts\mp\gametypes\br_public::brleaderdialog("circle_closing", 1);
    }

    thread dialoguelines(var_0);
  }

  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = getdangercircleorigin() + (0, 0, getdangercircleradius());
  setclosinguicircle(int(var_4), level.br_circle.safecircleent, level.br_circle.dangercircleui, var_2);
  level.br_circle.dangercircleent brcirclemoveTo(level.br_circle.centertarget[0], level.br_circle.centertarget[1], var_5, var_4);
  thread scripts\mp\music_and_dialog::defcon_alarms_stop();
  wait var_4;

  if(ref_12c72(var_0)) {
    if(getdvarint("scr_br_correct_cicle_post_move", 1)) {
      level.br_circle.dangercircleent.origin = (level.br_circle.centertarget[0], level.br_circle.centertarget[1], var_5);
    }
  }

  var_9 = 5;

  if(var_9 > 0 && var_0 < var_9) {
    scripts\mp\rank::addglobalrankxpmultiplier(1.2, "cirlceMult_" + scripts\engine\utility::string(var_0));
    scripts\mp\weaponrank::addweaponrankxpmultiplier(1.2, "cirlceMult_" + scripts\engine\utility::string(var_0));
  }

  level.group_unset_jugg_standstill = 0;
  cleanupouterspawnclosets(var_6, var_5);
}

function delay_play_depart_vo(var_0) {
  level endon("game_ended");

  if(var_0 > 0) {
    var_1 = var_0 - 1;
    var_2 = level.br_level.br_circleminimapradii[var_0];
    var_3 = level.br_level.br_circleminimapradii[var_1];

    if(var_2 == var_3) {
      return;
    }

    var_4 = 0.05;
    var_5 = 2;
    var_6 = var_5 / var_4;
    var_7 = int((var_3 - var_2) / var_6);
    var_8 = level.br_level.br_circleminimapradii[var_1];

    for(var_9 = 0; var_9 < var_6; var_9++) {
      var_8 -= var_7;
      setomnvar("ui_br_minimap_radius", var_8);
      wait var_4;
    }

    setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[var_0]);
    return;
  }

  setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[var_0]);
}

function cleanupouterspawnclosets(var_0, var_1) {
  var_2 = var_1 * var_1;

  if(isDefined(level.revivetriggers)) {
    foreach(var_4 in level.revivetriggers) {
      if(isDefined(var_4) && distance2dsquared(var_0, var_4.trigger.origin) > var_2) {
        var_5 = gathervalidspawnclosets(var_4.trigger.origin, var_1);

        if(isDefined(var_5) && var_5.size > 0) {
          var_4.victim scripts\mp\teamrevive::relocatetrigger(var_5[0].origin);
        } else {
          var_4.victim scripts\mp\teamrevive::removetrigger(var_6);
        }
      }
    }

    return;
  }
}

function gathervalidspawnclosets(var_0, var_1) {
  if(isDefined(level.respawnclosets)) {
    var_2 = scripts\engine\utility::get_array_of_closest(var_0, level.respawnclosets, undefined, undefined, var_1);
    return var_2;
  }

  return undefined;
}

function gatheroutercrates(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.br_pickups.crates) {
    if(isDefined(var_4) && distance2dsquared(var_0, var_4.origin) > var_2) {
      level.br_pickups.outercrates[level.br_pickups.outercrates.size] = var_4;
    }
  }
}

function cleanupoutercrates() {
  foreach(var_1 in level.br_pickups.outercrates) {
    if(isDefined(var_1) && var_1.curprogress == 0) {
      var_1 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }

  level.br_pickups.outercrates = [];
}

function can_man_turret(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2 = var_0;
  }

  return var_2;
}

function can_killstreak_be_detected(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.5;
  }

  if(!isDefined(var_5)) {
    var_5 = 0.1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_7 = var_3 / 3 + var_4 / 2 + var_5;

  for(var_8 = 0; var_8 < var_1; var_8++) {
    if(var_2) {
      var_9 = var_1 - var_8 - 1;
    } else {
      var_9 = var_8;
    }

    var_10 = (var_3 * (6 * var_8 * var_8 + 6 * var_8 + 2) + 3 * var_1 * (2 * var_4 * var_8 + var_4 + 2 * var_5 * var_1)) / 6 * var_1 * var_1 * var_1;
    var_11 = var_10 / var_7;
    var_6 = var_11 * var_0;
  }

  return var_6;
}

function open_teleport_room_door(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(!isarray(var_1)) {
    var_1 = can_man_turret(var_1, var_0.size);
  }

  if(!isarray(var_2)) {
    var_2 = can_man_turret(var_2, var_0.size);
  }

  if(!isarray(var_3)) {
    var_3 = can_man_turret(var_3, var_0.size);
  }

  if(!isarray(var_4)) {
    var_4 = can_man_turret(var_4, var_0.size);
  }

  if(!isarray(var_5)) {
    var_5 = can_man_turret(var_5, var_0.size);
  }

  var_6 = level.br_level.br_circleradii[level.br_level.br_circleradii.size - 1];
  level.br_level.br_circleradii[level.br_level.br_circleradii.size - 1] = undefined;

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_8 = level.br_level.br_circleradii.size;
    level.br_level.br_circleradii[var_8] = var_0[var_7];
    var_8 = level.br_level.br_circleclosetimes.size;
    level.br_level.br_circleclosetimes[var_8] = var_1[var_7];
    var_8 = level.br_level.br_circledelaytimes.size;
    level.br_level.br_circledelaytimes[var_8] = var_2[var_7];
    var_8 = level.br_level.br_circleminimapradii.size;
    level.br_level.br_circleminimapradii[var_8] = var_3[var_7];
    var_8 = level.br_level.default_player_connect_black_screen.size;
    level.br_level.default_player_connect_black_screen[var_8] = var_4[var_7];
    var_8 = level.br_level.default_suicidebomber_combat.size;
    level.br_level.default_suicidebomber_combat[var_8] = var_5[var_7];
  }

  level.br_level.br_circleradii[level.br_level.br_circleradii.size] = var_6;
}

function last_vo_time(var_0) {
  level.br_level.br_circleradii = scripts\engine\utility::array_remove_index(level.br_level.br_circleradii, var_0);
  level.br_level.br_circleclosetimes = scripts\engine\utility::array_remove_index(level.br_level.br_circleclosetimes, var_0);
  level.br_level.br_circledelaytimes = scripts\engine\utility::array_remove_index(level.br_level.br_circledelaytimes, var_0);
  level.br_level.br_circleminimapradii = scripts\engine\utility::array_remove_index(level.br_level.br_circleminimapradii, var_0);
  level.br_level.default_player_connect_black_screen = scripts\engine\utility::array_remove_index(level.br_level.default_player_connect_black_screen, var_0);
  level.br_level.default_suicidebomber_combat = scripts\engine\utility::array_remove_index(level.br_level.default_suicidebomber_combat, var_0);
}

function calculatebrbonusxp() {
  if(!getdvarint("scr_br_moving_circle_enabled", 1) || scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("movingCircle")) {
    level.br_level.delay_start_escort_protect_hvi_objective = 0;
    return;
  }

  level.br_level.delay_start_escort_protect_hvi_objective = getdvarint("scr_br_moving_circle_count", 0);
  level.br_level.delay_start_player_weapon_fired_monitor = getdvarfloat("scr_br_moving_circle_move_dist_min", 100);
  level.br_level.delay_start_player_grenade_fire_monitor = getdvarfloat("scr_br_moving_circle_move_dist_max", 300);
  var_0 = getdvarint("scr_br_moving_circle_preset", 0);
  var_1 = level.br_level.br_circleradii.size - 1;

  switch (var_0) {
    case 1:
      if(!level.br_level.delay_start_escort_protect_hvi_objective) {
        level.br_level.delay_start_escort_protect_hvi_objective = 4;
      }

      var_2 = level.br_level.br_circleradii[var_1];
      var_3 = level.br_level.br_circleradii[var_1 - 1];
      var_4 = level.br_level.br_circleclosetimes[var_1 - 1];
      var_5 = level.br_level.br_circledelaytimes[var_1 - 1];
      var_6 = level.br_level.br_circleminimapradii[var_1 - 1];
      last_vo_time(var_1 - 1);
      var_7 = level.br_level.delay_start_escort_protect_hvi_objective;
      var_8 = getdvarvector("scr_br_moving_circle_preset_auto_radius_distribution", (0, 1, 0));
      var_9 = [];
      var_10 = can_killstreak_be_detected(var_3 - var_2, var_7 + 1, 1, var_8[0], var_8[1], var_8[2]);
      var_11 = 0;

      for(var_12 = 0; var_12 < var_7; var_12++) {
        var_11 += var_10[var_12];
        var_9 = var_3 - var_11;
      }

      var_8 = getdvarvector("scr_br_moving_circle_preset_auto_time_distribution", (0, 1, 0.125));
      var_13 = getdvarfloat("scr_br_moving_circle_preset_auto_time_scale", 1);
      var_14 = getdvarfloat("scr_br_moving_circle_preset_auto_time_ratio", 0.5);
      var_15 = (var_4 + var_4) * var_13;
      var_16 = can_killstreak_be_detected(var_15 * var_14, var_7, 1, var_8[0], var_8[1], var_8[2]);
      var_17 = can_killstreak_be_detected(var_15 * (1 - var_14), var_7, 1, var_8[0], var_8[1], var_8[2]);
      open_teleport_room_door(var_9, var_16, var_17, var_6);
      break;
    case 2:
      last_vo_time(var_1 - 1);
      level.br_level.delay_start_escort_protect_hvi_objective = 4;
      var_9 = [1200, 900, 600, 300];
      var_16 = [30, 30, 30, 30];
      var_18 = [30, 20, 10, 0];
      var_19 = [5500, 5000, 4500, 4000];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 3:
      level.br_level.delay_start_escort_protect_hvi_objective = 5;
      var_9 = [1200, 900, 600, 300];
      var_16 = [30, 30, 30, 30];
      var_18 = [30, 20, 10, 0];
      var_19 = [5500, 5000, 4500, 4000];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 4:
      last_vo_time(var_1 - 1);
      level.br_level.delay_start_escort_protect_hvi_objective = 4;
      var_20 = 1500;
      var_21 = 750 + randomint(301);
      var_22 = 1000 + randomint(301);
      var_9 = [var_20, var_20, var_21, var_22];
      var_16 = [30, 30, 30, 45];
      var_18 = [10, 5, 5, 0];
      var_19 = [5500, 5500, 5500, 5500];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 5:
      var_2 = level.br_level.br_circleradii[var_1];
      var_3 = level.br_level.br_circleradii[var_1 - 1];
      var_4 = level.br_level.br_circleclosetimes[var_1 - 1];
      var_5 = level.br_level.br_circledelaytimes[var_1 - 1];
      var_6 = level.br_level.br_circleminimapradii[var_1 - 1];
      last_vo_time(var_1 - 1);

      if(!level.br_level.delay_start_escort_protect_hvi_objective) {
        level.br_level.delay_start_escort_protect_hvi_objective = 4;
      }

      var_7 = level.br_level.delay_start_escort_protect_hvi_objective;
      var_8 = getdvarvector("scr_br_moving_circle_preset_auto_radius_distribution", (0, 1, 0));
      var_9 = [];
      var_10 = can_killstreak_be_detected(var_3 - var_2, var_7 + 1, 1, var_8[0], var_8[1], var_8[2]);
      var_11 = 0;

      for(var_12 = 0; var_12 < var_7; var_12++) {
        var_11 += var_10[var_12];
        var_9 = var_3 - var_11;
      }

      var_23 = [3000, 2000, 1000, 500];

      for(var_12 = 0; var_12 < var_7; var_12++) {
        var_9 = var_9[var_12] + var_23[var_12];
      }

      var_8 = getdvarvector("scr_br_moving_circle_preset_auto_time_distribution", (0, 1, 0.125));
      var_13 = getdvarfloat("scr_br_moving_circle_preset_auto_time_scale", 1);
      var_14 = getdvarfloat("scr_br_moving_circle_preset_auto_time_ratio", 0.5);
      var_15 = (var_4 + var_4) * var_13;
      var_16 = can_killstreak_be_detected(var_15 * var_14, var_7, 1, var_8[0], var_8[1], var_8[2]);
      var_17 = can_killstreak_be_detected(var_15 * (1 - var_14), var_7, 1, var_8[0], var_8[1], var_8[2]);
      open_teleport_room_door(var_9, var_16, var_17, var_6);
      break;
    case 6:
      level.br_level.delay_start_escort_protect_hvi_objective = 4;
      var_9 = [4200, 2200, 1300, 600];
      var_16 = [30, 30, 30, 30];
      var_18 = [30, 20, 10, 0];
      var_19 = [5500, 5000, 4500, 4000];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 0:
    default:
      break;
  }

  if(var_0) {
    var_24 = level.br_level.br_circleradii.size - 1;
    level.br_level.delay_start_infiltrate_objective = var_24 - var_1;
    return;
  }
}

function cachedomnars() {
  var_0 = level.br_level;
  var_1 = var_0.br_circleclosetimes.size;
  var_2 = var_0.br_circleradii[var_1];
  var_3 = 0;

  while(var_3 < var_1 + 1) {
    var_4 = "scr_br_circle_set_" + var_3;
    var_5 = getDvar(var_4, "");

    if(var_5 == "") {} else {
      if(var_5 == "delete") {
        for(var_6 = var_3; var_6 < var_1; var_6++) {
          var_0.br_circleradii[var_6] = undefined;
          var_0.br_circleclosetimes[var_6] = undefined;
          var_0.br_circledelaytimes[var_6] = undefined;
          var_0.br_circleminimapradii[var_6] = undefined;
          var_0.default_player_connect_black_screen[var_6] = undefined;
          var_0.default_suicidebomber_combat[var_6] = undefined;
        }

        var_0.br_circleradii[var_3] = var_2;
        var_0.br_circleradii[var_6] = undefined;
        break;
      }

      var_7 = "?";
      var_8 = strtok(var_5, ",");

      if(var_3 >= var_1) {
        var_9 = 6;
        gulagindex(var_8.size == var_9, "Dvar: " + var_4 + " has " + var_8.size + " values, expected " + var_9);

        if(var_8.size != var_9) {
          break;
        }

        var_10 = 1;

        for(var_8 = 0; var_8 < var_11; var_8++) {
          if(var_7[var_8] == var_5) {
            var_10 = 0;
            break;
          }
        }

        gulagindex(var_10, "Dvar: " + var_3 + " has requires all " + var_11 + " values set");

        if(!var_10) {
          break;
        }
      }

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_7 = var_4[var_5];

        if(var_7 == var_3) {
          continue;
        }

        switch (var_5) {
          case 0:
            <
            error > .br_circleradii[var_0] = int(var_7);
            break;
          case 1:
            <
            error > .br_circleclosetimes[var_0] = int(var_7);
            break;
          case 2:
            <
            error > .br_circledelaytimes[var_0] = int(var_7);
            break;
          case 3:
            <
            error > .br_circleminimapradii[var_0] = int(var_7);
            break;
          case 4:
            <
            error > .default_player_connect_black_screen[var_0] = int(var_7);
            break;
          case 5:
            <
            error > .default_suicidebomber_combat[var_0] = int(var_7);
            break;
          default:
            break;
        }
      }

      if(var_0 >= < error > ) {
        <
        error > .br_circleradii[var_0 + 1] = < error > ; <
        error > ++;
      }
    }

    var_0++;
  }
}

function cacheentity() {
  calculatebrbonusxp();
  cachedomnars();
  var_0 = getdvarfloat("scr_br_circle_time_scale", 1);
  var_1 = level.br_level;
  var_1.br_circleclosetimes = add_client_back_to_mask_after_delay(var_1.br_circleclosetimes, "close_time", var_0, 0);
  var_1.br_circledelaytimes = add_client_back_to_mask_after_delay(var_1.br_circledelaytimes, "delay_time", var_0, 0);
  var_1.default_player_connect_black_screen = add_client_back_to_mask_after_delay(var_1.default_player_connect_black_screen, "show_delay_danger", var_0, 1);
  var_1.default_suicidebomber_combat = add_client_back_to_mask_after_delay(var_1.default_suicidebomber_combat, "show_delay_safe", var_0, 1);

  if(!isDefined(var_1.default_compare)) {
    var_1.default_compare = level.br_level.br_circleradii[0];
  }

  cargo_truck_mg_cp_initlate();
}

function add_client_back_to_mask_after_delay(var_0, var_1, var_2, var_3) {
  var_4 = getdvarfloat("scr_br_circle_" + var_1 + "_scale", 1);

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = getdvarfloat("scr_br_circle_override_" + var_1 + "_" + var_5, -1);

    if(var_6 > 0 || var_6 == 0 && var_3) {
      var_0 = var_6;
    }

    var_0 = var_0[var_5] * var_2;
    var_0 = var_0[var_5] * var_4;
  }

  return var_0;
}

function cargo_truck_mg_cp_initlate() {
  gulagindex(isDefined(level.br_level.br_circleclosetimes), "level.br_level.br_circleCloseTimes not defined");
  gulagindex(isDefined(level.br_level.br_circledelaytimes), "level.br_level.br_circleDelayTimes not defined");
  gulagindex(isDefined(level.br_level.default_player_connect_black_screen), "level.br_level.br_circleShowDelayDanger not defined");
  gulagindex(isDefined(level.br_level.default_suicidebomber_combat), "level.br_level.br_circleShowDelaySafe not defined");
  gulagindex(isDefined(level.br_level.br_circleminimapradii), "level.br_level.br_circleMinimapRadii not defined");
  gulagindex(isDefined(level.br_level.br_circleradii), "level.br_level.br_circleDelayTimes not defined");
  var_0 = level.br_level.br_circleclosetimes.size;
  gulagindex(var_0 == level.br_level.br_circledelaytimes.size, "level.br_level.br_circleDelayTimes size != " + var_0);
  gulagindex(var_0 == level.br_level.default_player_connect_black_screen.size, "level.br_level.br_circleShowDelayDanger size != " + var_0);
  gulagindex(var_0 == level.br_level.default_suicidebomber_combat.size, "level.br_level.br_circleShowDelaySafe size != " + var_0);
  gulagindex(var_0 == level.br_level.br_circleminimapradii.size, "level.br_level.br_circleMinimapRadii size != " + var_0);
  gulagindex(var_0 == level.br_level.br_circleradii.size - 1, "level.br_level.br_circleRadii size-1 != " + var_0);

  for(var_1 = 0; var_1 < level.br_level.default_player_connect_black_screen.size; var_1++) {
    var_2 = level.br_level.br_circledelaytimes[var_1];
    gulagindex(isDefined(var_2), "delayTime undefined for br_circleDelayTimes " + var_1);
    var_3 = level.br_level.default_player_connect_black_screen[var_1];
    gulagindex(isDefined(var_3), "showDelay undefined for br_circleShowDelayDanger " + var_1);
    gulagindex(var_3 <= var_2, "level.br_level.br_circleShowDelayDanger[" + var_1 + "] " + var_2 + " > " + var_3);
  }

  for(var_1 = 0; var_1 < level.br_level.br_circledelaytimes.size; var_1++) {
    var_2 = level.br_level.br_circledelaytimes[var_1];
    gulagindex(isDefined(var_2), "delayTime undefined for br_circleDelayTimes " + var_1);
    var_3 = level.br_level.default_suicidebomber_combat[var_1];
    gulagindex(isDefined(var_3), "showDelay undefined for br_circleShowDelaySafe " + var_1);
    gulagindex(var_3 <= var_2, "level.br_level.br_circleDelayTimes[" + var_1 + "] " + var_2 + " > " + var_3);
  }

  if(getdvarint("scr_br_moving_circle_enabled", 1) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("movingCircle")) {
    gulagindex(level.br_level.br_circleradii[0] == level.br_level.default_compare, "Changing circle radius 0 is not supported");
    return;
  }
}

function gulagindex(var_0, var_1) {
  if(!var_0) {
    return;
  }
}

function relic_amped_pick_random_valid_player(var_0) {
  if(!isDefined(level.br_level)) {
    return 0;
  }

  if(!isDefined(level.br_level.br_circledelaytimes) || !level.br_level.br_circledelaytimes.size) {
    return 0;
  }

  var_1 = level.br_level.br_circledelaytimes.size;

  if(var_0 >= var_1) {
    var_0 = var_1 - 1;
  }

  var_2 = 0;

  for(var_3 = 0; var_3 <= var_0; var_3++) {
    var_4 = level.br_level.br_circledelaytimes[var_3];
    var_5 = level.br_level.br_circleclosetimes[var_3];
    var_2 = var_2 + var_4 + var_5;
  }

  return var_2;
}

function dialoguelines(var_0) {
  var_1 = level.br_level.br_circledelaytimes[var_0] / 5;
  wait var_1;

  foreach(var_3 in level.teamnamelist) {
    var_4 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_3);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_6 = var_4[var_5];
      thread maxtokensdropondeath(level, var_3);
    }
  }
}

function maxtokensdropondeath(var_0, var_1) {
  var_2 = getsafecircleorigin();
  var_3 = getsafecircleradius();
  var_4 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(var_0, var_1);

  if(var_4.size <= 1) {
    return;
  }

  var_5 = sortbydistance(var_4, var_2);
  var_6 = distance2dsquared(var_2, var_5[0].origin);

  if(var_6 > var_3 * var_3) {
    if(var_6 > var_3 * var_3 * 4) {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "obj_sitrep_circle_outfar");
      return;
    }

    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "obj_sitrep_circle_out");
    return;
  }

  var_7 = distance2dsquared(var_2, var_5[var_5.size - 1].origin);

  if(var_7 > var_3 * var_3) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "obj_sitrep_circle_mixed");
    return;
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "obj_sitrep_circle_in");
}

function init_safehouse_gunshop(var_0, var_1) {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start)) {
    level.debug_vault_assault_retrieve_saw_obj_start = [];
  }

  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.radius = var_1;
  var_2.ref_129e5 = var_1 * var_1;
  return var_2;
}

function get_allykilled_alias(var_0) {
  var_1 = 1;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "mini" || var_2 == "rumble" || var_2 == "kingslayer" || var_2 == "zxp" || getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0) || var_2 == "reveal" || isDefined(level.disable_heli_lights) && level.disable_heli_lights.ref_14291 == 3 || var_2 == "x2" || getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) || scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("firstCircleVo")) {
    if(var_0 <= 1) {
      var_1 = 0;
    }
  }

  return var_1;
}

function get_allowed_vehicle_types_from_wave(var_0) {
  var_1 = 1;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "reveal" || var_2 == "x2" || var_2 == "Rumble") {
    var_1 = 0;
    return var_1;
  }

  if(var_2 == "mini" || var_2 == "zxp" || getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0) || isDefined(level.disable_heli_lights) && level.disable_heli_lights.ref_14291 == 3 || getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) || scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("firstCircleVo")) {
    if(var_0 == 0) {
      var_1 = 0;
    }
  }

  return var_1;
}

function ref_12c72(var_0) {
  var_1 = 0;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "zxp":
    case "mmp":
    case "mini":
      if(var_0 == 0) {
        var_1 = 1;
      }

      break;
    case "brdov":
      if(level.disable_heli_lights.ref_14291 == 3) {
        if(var_0 == 0) {
          var_1 = 1;
        }
      }

      break;
    case "reveal":
      var_1 = 1;
      break;
  }

  if(isDefined(level.obit_activation) && getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0)) {
    var_1 = 1;
  }

  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) != 0 && var_0 == 0) {
    var_1 = 1;
  }

  return var_1;
}

function teleport_entities_inside_subway_car(var_0) {
  setdvarifuninitialized("scr_br_fc_circle_disable", 3);
  setdvarifuninitialized("scr_br_circle_close_time_scale", 1);
  setdvarifuninitialized("scr_br_circle_delay_time_scale", 1);
  setdvarifuninitialized("scr_br_circle_show_delay_danger_scale", 1);
  setdvarifuninitialized("scr_br_circle_show_delay_safe_scale", 1);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    setdvarifuninitialized("scr_br_circle_override_close_time_" + var_1, -1);
    setdvarifuninitialized("scr_br_circle_override_delay_time_" + var_1, -1);
    setdvarifuninitialized("scr_br_circle_override_show_delay_danger_" + var_1, -1);
  }
}

function init_relic_explodedmg(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(var_1 > var_0.size) {
    var_1 = var_0.size;
  }

  foreach(var_4 in var_0) {
    var_0 = (var_4[0], var_4[1], 0);
  }

  var_6 = scripts\engine\utility::array_randomize(getarraykeys(var_0));
  var_7 = [];

  for(var_8 = 0; var_8 < var_1; var_8++) {
    var_9 = spawnStruct();
    var_9.origin = var_0[var_6[var_8]];
    var_9.heli_watch_for_fly_away = [];
    var_9.radius = 0;
    var_7 = var_9;
  }

  for(var_10 = 0; var_10 < var_2; var_10++) {
    for(var_8 = 0; var_8 < var_1; var_8++) {
      var_7[var_8].heli_watch_for_fly_away = [];
    }

    foreach(var_16, var_12 in var_0) {
      var_13 = 0;
      var_14 = distance2dsquared(var_12, var_7[0].origin);

      for(var_8 = 1; var_8 < var_7.size; var_8++) {
        var_15 = distance2dsquared(var_12, var_7[var_8].origin);

        if(var_15 < var_14) {
          var_13 = var_8;
          var_14 = var_15;
        }
      }

      var_7[var_13].heli_watch_for_fly_away[var_16] = var_0[var_16];
    }

    var_17 = 0;

    foreach(var_9 in var_7) {
      if(var_9.heli_watch_for_fly_away.size == 0) {
        continue;
      }

      var_19 = (0, 0, 0);

      foreach(var_4 in var_9.heli_watch_for_fly_away) {
        var_19 += var_4;
      }

      var_19 /= var_9.heli_watch_for_fly_away.size;

      if(var_19 != var_9.origin) {
        var_9.origin = var_19;
        var_17 = 1;
      }
    }

    if(!var_17) {
      break;
    }
  }

  return var_7;
}

function relic_focusfire_modifyplayerdamage(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    var_1 = var_3.origin;
  }

  [var_6] = init_relic_explodedmg(var_1, var_0);

  foreach(var_8 in var_5) {
    if(var_8.heli_watch_for_fly_away.size > var_6.heli_watch_for_fly_away.size) {
      var_6 = var_8;
    }
  }

  return var_6.origin;
}