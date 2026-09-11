/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_reveal.gsc
*******************************************************/

function init() {
  level.ref_12d05 = getdvarint("scr_br_reveal_event_type", 1);
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("teamSpectate");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("kiosk");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("prematchBlueprints");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("restartCircleElimination", &ref_12cbd);
  scripts\mp\gametypes\br_gametypes::ref_12b11("lootUsedIgnore", &ref_11a48);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &ref_12cf4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &ref_12cf4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12cea);
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &ref_12cee);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &ref_12cec);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &ref_11b80);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyVehicleDamage", &ref_11ca1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("allowMeleeVehicleDamage", &brking_cleanupents);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerGetZombieSpawnLocation", &ref_12582);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("regenHealthAdd", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1264b);
  scripts\mp\gametypes\br_gametypes::ref_12b11("regenDelaySpeed", &scripts\mp\gametypes\br_alt_mode_zxp::ref_1264a);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postUpdateGameEvents", &scripts\mp\gametypes\br_alt_mode_zxp::ref_12810);
  scripts\mp\gametypes\br_gametypes::ref_12b11("lastStandAllowed", &scripts\mp\gametypes\br_alt_mode_zxp::watch_flight_collision);
  scripts\mp\gametypes\br_gametypes::ref_12b11("kioskRevivePlayer", &scripts\mp\gametypes\br_alt_mode_zxp::wait_for_chopper_boss_finish_turning);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerDamaged", &scripts\mp\gametypes\br_alt_mode_zxp::onplayerdamaged);
  scripts\mp\gametypes\br_gametypes::ref_12b11("shouldLastStandDamageScale", &scripts\mp\gametypes\br_gametype_zxp::ref_13308);
  scripts\mp\gametypes\br_gametypes::ref_12b11("ignoreVehicleExplosiveDamage", &scripts\mp\gametypes\br_alt_mode_zxp::standard_health);
  level.ref_133e0 = 0;
  level.scriptedphysicaldofenabled = 1;
  level.disable_super_in_turret.ref_12ca1 = getdvarint("scr_br_reveal_respawnDelay", 0);
  level.disable_super_in_turret.timelimit = getdvarint("scr_br_timelimit", 900);
  level.disable_super_in_turret.player_equip_secondary = relic_third_person();
  level.parachuterestoreweaponscb = &blankfunc;
  level.disableforfeit = 1;
  level.debug_safehouse_gunshop_start = 1;
  level.skipprematchdropspawn = 0;
  level.ref_13b75 = getdvarint("scr_br_timedSection1Duration", 420);
  level.ref_13b77 = getdvarint("scr_br_timedSection2Duration", 70);
  level.ref_13b79 = getdvarint("scr_br_timedSection3Duration", 19);
  level.ref_12cfa = ["shipwreck", "prison", "hospital", "stadium", "tvstation", "superstore", "dam", "trainstation", "storagetown", "quarry", "promwest", "promeast", "downtown", "farms", "lumber", "port", "park", "hills", "boneyard", "airport", "milbase"];
  level.ref_12d08 = undefined;
  level.ref_12cf6 = [];
  level.ref_12d02 = undefined;
  level.ref_11e96 = 1;
  level._effect["smoke_exfil"] = loadfx("vfx/iw8_br/gameplay/vfx_br_crate_smoke_signal.vfx");

  if(level.script == "mp_br_mechanics") {
    level.grouptorewards = (475, -1956, 0);
  } else {
    level.grouptorewards = (-20830, 46010, -654);
  }

  game["dialog"]["plague_intro"] = "plague_intro";
  game["dialog"]["op2_dov1_infil_3"] = "op2_dov1_infil_3_10";
  game["dialog"]["plague_overrun"] = "plague_overrun";
  game["dialog"]["ebr_alert_phase4_80"] = "ebr_alert_phase4_80";
  game["dialog"]["ebr_alert_missile_20"] = "ebr_alert_missile_20";
  game["dialog"]["dx_bra_cp1_plague_zone_chopper_inbound"] = "dx_bra_cp1_plague_zone_chopper_inbound";
  game["dialog"]["plague_exfil"] = "plague_exfil";
  game["dialog"]["op1_dov1_infil_1_10"] = "op1_dov1_infil_1_10";
  game["dialog"]["plague_no_exfil"] = "plague_no_exfil";
  game["dialog"]["op1_dov1_infil_2"] = "op1_dov1_infil_2_10";
  game["dialog"]["ebr_alert_phase4_70"] = "ebr_alert_phase4_70";
  game["dialog"]["op2_dov1_infil_10"] = "op2_dov1_infil_1_10";
  game["dialog"]["op2_dov1_infil_2_10"] = "op2_dov1_infil_2_10";
  game["dialog"]["ebr_alert_phase4_90"] = "ebr_alert_phase4_90";
  level.playerzombieupdatetagobjectives = ["apc_russian", "atv", "big_bird", "cargo_truck", "cargo_truck_mg", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van"];
  thread toggleusbstickinhand();
}

function toggleusbstickinhand() {
  waittillframeend();
  ref_12d07();
  scripts\mp\flags::gameflaginit("reveal_timed_section_1", 0);
  scripts\mp\flags::gameflaginit("reveal_timed_section_2", 0);
  level.disable_back_light = 1;
  level.ref_12888 = &emp_drone_proximity_explode;
  thread ref_12d09();
  thread playernakeddroploadout();

  if(getdvarint("scr_br_reveal_give_xp_to_humans", 0)) {
    thread searchradiusmin();
  }

  thread deploy_balloon_nags();
  thread ref_12cfc();
}

function blankfunc() {}

function ref_12d09() {
  level endon("game_ended");
  level endon("forceFinalRunToExfil");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  setomnvar("ui_br_zm_marked_area", 255);
  level waittill("infils_ready");
  wait 5;
  setomnvar("ui_br_circle_state", 0);
  ref_12cfb();
  thread ref_13b74();
  ref_12d0a(level.ref_13b75);
  thread ref_13b76();
  ref_12d0a(level.ref_13b77);
  thread ref_13b78();
  level notify("watchFinalRunToExfil");
  ref_12d0a(level.ref_13b79);
  ref_12cf3(1);
  thread ref_12cf0();
}

function ref_13b74() {
  level endon("endRevealTimeHandler");
  scripts\mp\flags::gameflagset("reveal_timed_section_1");
  thread ref_12ced(660);
  thread ref_12d0f(6, 4, 0, 1);
  thread toggle_switch_model();

  foreach(var_2, var_1 in level.players) {
    var_1 scripts\mp\hud_message::showsplash("br_dov_survive");

    if(scripts\mp\utility\player::isreallyalive(var_1) && !var_1 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_1 setclientomnvar("ui_br_reveal_state", 1);
    }
  }

  thread ref_12cf2();

  if(level.ref_13b75 <= 45) {
    var_3 = 5;
  } else {
    var_3 = 45;
  }

  wait var_3 - 6;

  foreach(var_2 in level.players) {
    ref_12d0d(var_2, "op2_dov1_infil_3");
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(5);
  wait 6;
  thread ref_12e02();
  scripts\mp\gametypes\br_publicevent_juggernaut::attackerswaittime();
  wait 10;
  level notify("dov_1_broadcast");
  wait 33;
  level notify("zombie_outbreak_1_start");
  wait 50;
  level notify("zombie_outbreak_2_start");
  wait level.ref_13b75 - var_3 - 93 - 70;
  level notify("zombie_outbreak_3_start");
  wait 60;
  level notify("zombie_outbreak_4_start");
  wait 10;
}

function ref_13b76() {
  level endon("endRevealTimeHandler");
  level notify("end_containment_fx");
  scripts\mp\flags::gameflagset("reveal_timed_section_2");
  scripts\mp\gametypes\br_public::brleaderdialog("plague_overrun", 0, level.players);

  foreach(var_1 in level.players) {
    ref_12d0d(var_1, "ebr_alert_phase4_80");
  }

  setomnvar("scriptable_loot_hide", 1);
  var_3 = getarraykeys(level.teamdata);

  foreach(var_5 in var_3) {
    setteamradar(var_5, 0);
    setteamradarstrength(var_5, 0);
  }

  foreach(var_1 in level.players) {
    if(scripts\mp\utility\player::isreallyalive(var_1) && !var_1 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_1 setclientomnvar("ui_br_reveal_state", 2);
    }
  }

  setmusicstate("dovp1_exfil_gameplay");
  ref_12cf1();
  wait 6;

  foreach(var_1 in level.players) {
    ref_12d0d(var_1, "op2_dov1_infil_2_10");
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(4);
  wait 6;

  if(getdvarint("scr_br_reveal_bombardement_enabled", 1)) {
    level _hidesafecircleui::changetimertoovertimetimer(level.grouptorewards, undefined, 8, 7000);
    wait 4;

    foreach(var_1 in level.players) {
      ref_12d0d(var_1, "ebr_alert_missile_20");
    }

    wait 11;
  } else {
    wait 15;
  }

  if(getdvarint("scr_br_reveal_exfil_helicopter", 1)) {
    level notify("reveal_exfil_heli_incoming");

    foreach(var_1 in level.players) {
      ref_12d0d(var_1, "dx_bra_cp1_plague_zone_chopper_inbound", 1);
    }
  }

  scripts\mp\gametypes\br_public::brleaderdialog("plague_exfil", 0, level.players);
  wait 15;

  foreach(var_1 in level.players) {
    thread ref_12d0d(var_1);
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(3.5);
}

function ref_13b78() {
  level endon("endRevealTimeHandler");
  level notify("revealTimedSection3");
  level notify("end_containment_fx");
  level.ref_12d08 = scripts\engine\utility::play_loopsound_in_space("iw8_nuke_alarm_lp", level.grouptorewards + (0, 0, 500));
  setmusicstate("dovp1_nuke_countdown");

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("mp_br_event_dovp1_nuke", 6);
  }

  ref_13365(level.ref_13b79);
  level.ref_11f0f = 1;
  wait 1;

  foreach(var_1 in level.players) {
    if(!var_1 scripts\mp\gametypes\br_public::ref_125f3()) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("plague_no_exfil", var_1, 0);
    }
  }

  setomnvarforallclients("ui_br_reveal_state", 3);
  setomnvarforallclients("ui_hide_minimap", 1);
  wait 1;
  level notify("revealTimedSection3_after_initial_VO");

  foreach(var_1 in level.players) {
    ref_12d0d(var_1, "op1_dov1_infil_2");
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(14);
  wait 6;

  foreach(var_1 in level.players) {
    ref_12d0d(var_1, "ebr_alert_phase4_70");
  }

  wait 1;
  infil_chopper_dialogue();

  foreach(var_1 in level.players) {
    ref_12d0d(var_1, "op2_dov1_infil_10");
  }

  wait 4;

  foreach(var_1 in level.players) {
    ref_12d0d(var_1, "ebr_alert_phase4_90");
    var_1 setsoundsubmix("mp_br_event_dovp1_outro", 5);
  }

  wait 3;

  foreach(var_1 in level.players) {
    var_1.plotarmor = 1;
  }

  scripts\mp\gametypes\br_containmentprotocol::elevator_trigger_wait_for_spawn();
}

function searchradiusmin() {
  level endon("watchFinalRunToExfil");
  level endon("forceFinalRunToExfil");
  level waittill("infils_ready");

  for(;;) {
    wait 20;

    foreach(var_1 in level.players) {
      if(!var_1 scripts\mp\gametypes\br_public::ref_125f3()) {
        var_1 thread scripts\mp\rank::giverankxp("br_reveal_surviving", 50);
        var_1 thread scripts\mp\rank::scoreeventpopup("br_reveal_surviving");
      }
    }
  }
}

function playernakeddroploadout() {
  level endon("watchFinalRunToExfil");

  if(getdvarint("scr_br_reveal_force_final_run_disabled", 0)) {
    return;
  }

  level waittill("infils_ready");
  var_0 = 1;

  while(var_0) {
    wait 3;
    var_0 = 0;
    var_1 = getarraykeys(level.teamdata);

    foreach(var_3 in var_1) {
      if(scripts\mp\gametypes\br_alt_mode_zxp::ref_12bba(var_3) > 0) {
        var_0 = 1;
        break;
      }
    }

    if(!var_0) {
      level notify("forceFinalRunToExfil");
      thread ref_13b78();
      ref_12d0a(level.ref_13b79);
      ref_12cf3(1);
      ref_12cf0();
    }
  }
}

function ref_12cf4() {
  var_0 = getdvarvector("br_final_circle_override", level.grouptorewards);
  return var_0;
}

function ref_12cf5() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    scripts\mp\gametypes\br::scriptednode(var_1);
  }
}

function ref_12d0a(var_0) {
  level endon("endRevealTimeHandler");
  wait var_0;
}

function ref_12cf7() {
  if(!isDefined(level.ref_12d05)) {
    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_armor::searchcirclesize();
  level waittill("infils_ready");
  scripts\mp\gametypes\br_armor::searchcirclesize();
}

function ref_12ceb() {
  foreach(var_1 in level.players) {
    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("event_dov_completed");
    waitframe();
    scripts\mp\gametypes\br::ref_13fcc(var_1);
    waitframe();
  }
}

function ref_12d0f(var_0, var_1, var_2, var_3) {
  level endon("endRevealTimeHandler");
  level endon("forceFinalRunToExfil");

  for(var_4 = 1; var_4 <= 4; var_4++) {
    switch (var_4) {
      case 1:
        level waittill("zombie_outbreak_1_start");
        break;
      case 2:
        level waittill("zombie_outbreak_2_start");
        break;
      case 3:
        level waittill("zombie_outbreak_3_start");
        break;
      case 4:
        level waittill("zombie_outbreak_4_start");
        break;
    }

    ref_12d00("mp_run_" + var_4, var_3, 4);
    ref_12cfe("mp_run_" + var_4, var_3, "zombie_outbreak");
    ref_12d0e(var_0);
  }
}

function ref_12cf3(var_0) {
  var_1 = "mp_final_run";
  var_2 = 45;

  if(isDefined(level.ref_12d08)) {
    level.ref_12d08 delete();
  }

  thread scripts\mp\gametypes\br_vehicles::emptyallvehicles();

  if(isDefined(level.ref_12cf6)) {
    foreach(var_4 in level.ref_12cf6) {
      var_4 destroy();
    }

    level.ref_12cf6 = [];
  }

  foreach(var_7 in level.players) {
    if(var_7 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_7 notify("zombie_unset");
    }

    var_7 scripts\mp\utility\player::_freezecontrols(1);
    var_7 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  }

  wait 2;
  thread scripts\mp\gametypes\br_vehicles::deleteextantvehicles();
  thread ref_12ceb();
  ref_12d00(var_1, var_0, 9);
  level notify("end_containment_fx");
  ref_12cfe(var_1, var_0, "final_nuke");
  wait var_2 - 2;
}

function ref_12d00(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isalive(var_4)) {
      continue;
    }

    var_4 skydive_cutparachuteon(var_0, 0, var_1);
    var_4 setclientomnvar("ui_br_bink_overlay_state", var_2);
  }
}

function ref_12cfe(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "";
  }

  switch (var_2) {
    case "zombie_outbreak":
      break;
    case "final_nuke":
      setmusicstate("");

      foreach(var_4 in level.players) {
        if(!isalive(var_4)) {
          continue;
        }

        var_4 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_4 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
      }

      break;
  }

  foreach(var_4 in level.players) {
    if(!isalive(var_4)) {
      continue;
    }

    var_4 preloadcinematicforplayer(var_0, 1, var_1);
  }
}

function ref_12d0e(var_0) {
  wait var_0;

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_br_bink_overlay_state", 0);
    var_2 clearsoundsubmix("mp_br_event_dovp1_nuke", 0.5);
    var_2 clearsoundsubmix("mp_br_event_dovp1_outro", 0.5);
  }
}

function ref_12cea() {
  var_0 = self;

  if(var_0 scripts\mp\gametypes\br_public::ref_125f3()) {
    return;
  }

  level.deletescriptableinstanceaftertime = ref_12ce9();
  var_0 scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  var_0 scripts\mp\gametypes\br::searchcircleorigin(0, 1, 0);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_0, "brloot_equip_gasmask", 1);
  var_0 scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  var_0 scripts\mp\gametypes\br_pickups::ref_12c81();
  var_0 scripts\mp\gametypes\br_pickups::forcegivesuper("super_ammo_drop", 0);
  var_0 scripts\mp\gametypes\br::scriptednode(var_0);
  var_0 scripts\mp\gametypes\br_armor::searchcirclesize();
}

function ref_13268() {
  level endon("game_ended");
  var_0 = 20;
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_br_bink_overlay_state", 4);
    var_2 preloadcinematicforplayer("mp_connor", 1, 1);
  }
}

function ref_12cfc() {
  wait 1;
  level.vehicle_isneutraltoplayer = [];
  var_0 = spawnStruct();
  var_0.id = 1;
  var_0.occupied = 0;
  var_0.origin = (-4903, 25796, -394);
  level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var_0;
  var_1 = spawnStruct();
  var_1.id = 1;
  var_1.occupied = 0;
  var_1.origin = (-28977, 23076, -390);
  level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var_1;
  var_2 = spawnStruct();
  var_2.id = 1;
  var_2.occupied = 0;
  var_2.origin = (2693, 41717, 1607);
  level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var_2;
}

function ref_12ced(var_0) {
  level endon("game_ended");
  setomnvar("ui_br_circle_state", 6);
  setomnvar("ui_hardpoint_timer", gettime() + int(var_0 * 1000));
}

function ref_12cef(var_0) {
  level endon("game_ended");
  wait var_0;
  level.ref_12888 = &scripts\mp\gametypes\br::emp_drone_proximity_explode;
  level.ref_11c76 = &scripts\mp\gametypes\br::dyn_door;
  level.modeonspawnplayer = &scripts\mp\gametypes\br::onspawnplayer;
  level.disable_super_in_turret.funcs["spawnHandled"] = undefined;
  level.disable_super_in_turret.funcs["playerKilledSpawn"] = undefined;
}

function ref_12cf0() {
  level thread scripts\mp\gamelogic::forceend();
  level waittill("game_cleanup");
  scripts\mp\gametypes\br_alt_mode_zxp::spawnangle();
}

function ref_12cfb() {
  thread ref_12cf5();
  scripts\mp\gametypes\br_public::brleaderdialog("plague_intro", 0, level.players);
  scripts\mp\gametypes\br_circle::all_players_are_in_trap_room_entrance();
  setomnvar("ui_br_circle0_start_entity", undefined);
}

function ref_11a48(var_0) {
  return false;
}

function ref_12ce9() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function relic_third_person() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function scripted_fov() {
  var_0 = self;
  var_0 scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  var_0 scripts\mp\gametypes\br_pickups::ref_12c81();
  var_0.pers["gamemodeLoadout"] = level.disable_super_in_turret.player_equip_secondary;
  var_0.class = "gamemode";
}

function ref_13365(var_0) {
  var_1 = gettime();
  var_2 = var_0 * 1000 + var_1;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 3);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var_0);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  setomnvar("ui_nuke_end_milliseconds", var_2);
}

function spawn_cypher_monitor_model() {
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
}

function ref_12cf1() {
  var_0 = spawn("script_model", level.grouptorewards - (0, 0, 200));
  var_0 setModel("risk_dom_plate");
  var_0 setscriptablepartstate("risk_dom_beacon", "on", 0);

  foreach(var_2 in level.players) {
    if(var_2 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_2 scripts\mp\hud_message::showsplash("br_dov_stop_exfil");
      continue;
    }

    var_2 scripts\mp\hud_message::showsplash("br_dov_exfil");
  }

  ref_12d02();
  var_4 = spawnfx(level._effect["smoke_exfil"], level.grouptorewards);
  triggerfx(var_4);
}

function ref_12d02() {
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_0, "current", level.grouptorewards + (0, 0, 600), "ui_mp_br_mapmenu_icon_dov_1_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
    objective_removeallfrommask(var_0);

    foreach(var_2 in level.players) {
      if(var_2 scripts\mp\gametypes\br_public::ref_125f3()) {
        continue;
      }

      objective_addclienttomask(var_0, var_2);
    }

    objective_showtoplayersinmask(var_0);
    level.ref_12d02 = var_0;
    return;
  }
}

function ref_12d03() {
  level endon("game_ended");

  if(!isDefined(level.ref_12d02)) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.ref_12d02, self);
}

function ref_12d0d(var_0, var_1) {
  var_2 = self;

  if(istrue(var_1)) {
    var_3 = var_0;
  } else {
    var_3 = "dx_brm_" + game["dialog"][var_1];
    var_3 = tolower(var_3);
  }

  if(soundexists(var_3)) {
    var_4 = lookupsoundlength(var_3, 1) / 1000;
  } else {
    var_4 = 3;
  }

  var_4 += 0.5;
  var_3 queuedialogforplayer(var_4, var_2, var_4);
}

function onspawnplayer() {
  self notify("br_spawned");

  if(isagent(self)) {
    return;
  }

  var_0 = istrue(self.gulag);
  scripts\mp\gametypes\br_pickups::initplayer(var_0);
  scripts\mp\gametypes\br_functional_poi::initplayer();
  scripts\mp\gametypes\br_armor::teamfriendlyto();
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.br_lastscenecheck = gettime();
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  level.superdelay = 0;
  level.superpointsmod = 1;
  self.br_perks = [0, 0, 0, 0, 0];
  self.br_perkpoints = 0;

  if(level.ref_121c8) {
    self getclientomnvar();
  } else {
    self weaponswitchbuttonPressed();
  }

  if(level.ref_121c9) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  thread ref_12cf7();
}

function ref_11b80(var_0) {
  var_1 = 1;

  if(!scripts\mp\gametypes\br_public::ref_125f3()) {
    ref_12d03();
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b80(var_0, var_1);
}

function ref_11b16() {
  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b16();
}

function emp_drone_proximity_explode(var_0) {
  var_1 = 0.5;

  if(!isDefined(self.ref_1286f) || self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  thread scripts\mp\gametypes\br::emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model) && !(isDefined(level.ref_12d05) && level.ref_12d05 == 2)) {
    var_2 = level.disable_super_in_turret.ref_12ca1 > 0;
    var_3 = undefined;

    if(var_2) {
      var_3 = level.disable_super_in_turret.ref_12ca1 * 1000;
      scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
      scripts\mp\spectating::setdisabled();
    }

    var_4 = scripts\mp\gametypes\br_public::ref_126b8(self.ref_1286f.origin, self.ref_1286f.height);
    var_5 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
    scripts\mp\gametypes\br_public::ref_126b9(var_4, var_5, 1, 0, var_3);

    if(var_2) {
      var_6 = 4;
      var_7 = 1;
      var_8 = 0.25;
      var_9 = var_7 - var_8;
      self setclientomnvar("ui_show_spectateHud", self getentitynumber());
      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_3));
      var_10 = max(level.disable_super_in_turret.ref_12ca1 - var_6, 0);
      wait var_10;
      thread scripts\mp\gametypes\br_gulag::fadeoutin(var_7);
      wait var_9;
      scripts\mp\gametypes\br::spawnintermission(var_4, self.ref_1286f.angles);
      scripts\mp\gametypes\br::ending_fade_in();
      self setclientomnvar("ui_br_transition_type", 2);
      wait var_8;
      var_11 = max(level.disable_super_in_turret.ref_12ca1 - var_10 - var_7, 0);
      wait var_11;
      scripts\mp\gametypes\br_public::ref_1252b();
      self setclientomnvar("ui_show_spectateHud", -1);
    } else {
      if(!istrue(level.ref_14623)) {
        scripts\mp\gametypes\br::ending_fade_in();
        self setclientomnvar("ui_br_transition_type", 4);
      }

      wait var_1;
      scripts\mp\gametypes\br::spawnintermission(var_4, self.ref_1286f.angles);
      scripts\mp\spectating::setdisabled();
      scripts\mp\gametypes\br_public::ref_126ed();
    }
  } else {
    self.thrust_fx_model = undefined;
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  self freezecontrols(0);
}

function ref_12582() {
  var_0 = ref_12583();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_0 = undefined;

  if(!isDefined(var_1)) {
    var_3 = ref_12584();
    var_1 = var_3[0];
    var_2 = var_3[1];
    var_3 = undefined;
  }

  if(isDefined(var_1)) {
    return [var_1, var_2];
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::ref_12582();
}

function ref_12583() {
  var_0 = undefined;
  var_1 = undefined;

  if(!getdvarint("scr_br_reveal_override_zombie_spawns_near_team", 1)) {
    return [var_0, var_1];
  }

  var_2 = getdvarfloat("scr_br_reveal_override_zombie_spawns_near_team_disable_time", -1);

  if(var_2 > 0 && isDefined(level.starttime)) {
    var_3 = (gettime() - level.starttime) / 1000;

    if(var_3 > var_2) {
      return [var_0, var_1];
    }
  }

  var_4 = scripts\mp\gametypes\br_alt_mode_zxp::ref_1270e();
  var_0 = var_4[0];
  var_1 = var_4[1];
  var_4 = undefined;
  return [var_0, var_1];
}

function ref_12584() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 50;
  var_3 = 10000;

  if(!getdvarint("scr_br_reveal_override_zombie_spawns_random", 1)) {
    return [var_0, var_1];
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret.ref_146fb)) {
    return [var_0, var_1];
  }

  var_4 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_6 = var_4 + var_2;
  var_7 = getdvarfloat("scr_br_reveal_override_zombie_spawns_min_angle", 210);
  var_8 = getdvarfloat("scr_br_reveal_override_zombie_spawns_max_angle", 390);
  var_9 = getdvarint("scr_br_reveal_override_zombie_spawns_attempts", 5);
  var_10 = var_8 - var_7;
  var_11 = var_10 / var_9;
  var_12 = randomfloat(var_11);
  var_13 = [];

  for(var_14 = 0; var_14 < var_9; var_14++) {
    var_13 = var_7 + var_14 * var_11 + var_12;
  }

  var_13 = scripts\engine\utility::array_randomize(var_13);

  for(var_14 = 0; var_14 < var_13.size; var_14++) {
    var_15 = anglesToForward((0, var_13[var_14], 0));
    var_16 = scripts\mp\gametypes\br_alt_mode_zxp::run_track_enemy_patrollers(var_5, var_15, var_6);
    var_0 = var_16[0];
    var_1 = var_16[1];
    var_16 = undefined;

    if(isDefined(var_0)) {
      var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0, var_3);
      break;
    }
  }

  return [var_0, var_1];
}

function ref_1327a() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_sandbox_time_warning", 120);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_br_circle_state", 5);

  if(level.disable_super_in_turret.timelimit <= 0) {
    return;
  }

  setomnvar("ui_hardpoint_timer", gettime() + int(level.disable_super_in_turret.timelimit * 1000));
  var_1 = max(level.disable_super_in_turret.timelimit - var_0, 0);
  wait var_1;
  setomnvar("ui_br_circle_state", 6);
}

function ontimelimit() {
  if(istrue(level.gameended)) {
    return;
  }

  setupmapquadrantcornersandgrid();
  thread scripts\mp\gametypes\br::brendgame(level.disable_super_in_turret.player_enemy_cooldown, game["end_reason"]["objective_completed"]);
}

function onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  if(isDefined(var_0.victim) && isPlayer(var_0.victim) && !istrue(level.ref_11f0f)) {
    var_0.victim setclientomnvar("ui_br_reveal_state", 4);
    var_0.victim scripts\mp\gametypes\br_containmentprotocol::elim_hud();
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || !isDefined(var_0.victim) || var_0.attacker == var_0.victim) {
    return;
  }

  var_1 = var_0.attacker.team;

  if(!isDefined(level.teamdata[var_1]["kills"])) {
    level.teamdata[var_1]["kills"] = 0;
  }

  level.teamdata[var_1]["kills"]++;

  if(isDefined(level.ref_12d05)) {
    if(!istrue(level.br_prematchstarted)) {
      return;
    }

    if(level.gameended) {
      return;
    }

    var_2 = var_0.victim;
    var_3 = var_0.attacker;

    if(!isDefined(var_3) || !isPlayer(var_3) || !isDefined(var_2)) {
      return;
    }

    return;
  }
}

function playerdropplunderondeath(var_0, var_1) {
  var_2 = int(self.plundercount * 0.5);
  var_3 = self.plundercount - var_2;

  if(var_3 <= 0) {
    var_3 = 1;
  }

  self.plundercountondeath = var_2;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var_2);
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var_3, var_0);
  return true;
}

function setupmapquadrantcornersandgrid() {}

function ref_12cbd(var_0, var_1) {
  level endon("game_ended");
  level.ontimelimit = &scripts\mp\gametypes\br::ontimelimit;
  var_2 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
  level.watchdvars[var_2].value = 0;
  level.overridewatchdvars[var_2] = 0;
  wait var_1;
  level.ref_12888 = &scripts\mp\gametypes\br::emp_drone_proximity_explode;
  level.ref_11c76 = &scripts\mp\gametypes\br::dyn_door;
  level.modeonspawnplayer = &scripts\mp\gametypes\br::onspawnplayer;
  level.disable_super_in_turret.gulagfixuparena = 1;
  level notify("closeSandboxMenu");

  foreach(var_4 in level.players) {
    if(isDefined(var_4.spawndangertriggers)) {
      var_4.spawndangertriggers destroy();
    }
  }

  level.disable_super_in_turret.funcs["spawnHandled"] = undefined;
  level.disable_super_in_turret.funcs["playerKilledSpawn"] = undefined;
}

function ref_12cee() {
  var_0 = (10895, -10916, 292);
  var_1 = level.br_level.br_circleradii[1] - 42000;
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function ref_12cec() {
  thread ref_12cf9();
}

function ref_12cf9() {
  level endon("game_ended");
  self endon("death");
  var_0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "c130" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "outOfBounds";
      var_3 notify("halo_kick_c130");
    }
  }
}

function ref_12d07() {
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.default_player_connect_black_screen[0] = 1;
}

function deploy_balloon_nags() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_zmb_dov_sfx");
}

function toggle_switch_model() {
  if(level.script == "mp_br_mechanics") {
    scripts\mp\gametypes\br_zones::swap_access_card("a", (0, 0, 0), 500, 20, 0, 2);
    scripts\mp\gametypes\br_zones::swap_access_card("b", (1000, 1000, 0), 500, 20, 0, 2);
    scripts\mp\gametypes\br_zones::swap_access_card("c", (1000, -1000, 0), 500, 20, 0, 2);
    var_0 = "a,b,c";
  } else {
    var_0 = "dam,stadium,hospital,super,tv,quarry,bank";
  }

  scripts\mp\gametypes\br_zones::swaphelifordrivable("scr_br_reveal_plague_zone_locations", var_0);
  thread ref_123bb();
}

function ref_123bb() {
  scripts\mp\flags::gameflagwait("reveal_timed_section_2");
  var_0 = getdvarfloat("scr_br_reveal_plague_zone_delete_time", 10);

  foreach(var_2 in level.deployingplayer.zones) {
    if(var_2.type == "plague") {
      var_2 thread scripts\mp\gametypes\br_zones::ref_1471b(undefined, 50, var_0);
    }
  }

  wait var_0;

  foreach(var_2 in level.deployingplayer.zones) {
    if(var_2.type == "plague") {
      var_2 scripts\mp\gametypes\br_zones::ref_14714();
    }
  }
}

function ref_12cf2() {
  level endon("game_ended");

  if(!getdvarint("scr_br_reveal_exfil_helicopter", 1)) {
    return;
  }

  level waittill("reveal_exfil_heli_incoming");
  var_0 = [level.grouptorewards + (500, 0, 0), level.grouptorewards - (500, 0, 0), level.grouptorewards + (350, 0, 500) - (0, 650, 0)];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    thread ai_is_juggernaut(level);
  }
}

function ai_is_juggernaut(var_0) {
  while(istrue(level.create_agent_definition)) {
    wait 1;
  }

  var_1 = level.players[randomint(level.players.size)];
  var_2 = ref_126a7(var_1, var_0);

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.origin = var_0;
    var_3.angles = var_2.angles;
    var_3.spawntype = "GAME_MODE";
    var_4 = spawnStruct();
    var_5 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var_3, var_4);

    if(isDefined(var_5)) {
      var_2.snapshot_grenade_applysnapshot = var_5;
      var_5 hide();
      helicreateextractvfx(var_2, var_0);
      thread onkillstreakend(var_2);
      return;
    }

    return;
  }
}

function onkillstreakend(var_0) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  var_0 settargetyaw(var_0.select_mountain_two_spawners);
  var_1 = tracegroundheight(var_0, var_0.pathgoal + (0, 0, 400));
  var_1 += getdvarfloat("scr_br_reveal_exfil_heli_z_offset", 300);
  var_1 += randomfloat(getdvarfloat("scr_br_reveal_exfil_heli_z_offset_random", 300));
  var_2 = var_0.pathgoal[2] - var_1;
  var_0.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_2);
  var_0 waittill("goal");
  thread sound_ent();
  thread snapshot_crate_spawn();
  helidescend(var_0, var_0.endpoint, var_1);
  helicleanupextract(var_0, 0);
}

function tracegroundheight(var_0) {
  var_1 = 125;
  var_2 = tracegroundpoint(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

function tracegroundpoint(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  return var_6["position"];
}

function sound_ent() {
  self endon("death");
  level waittill("revealTimedSection3_after_initial_VO");
  wait 3;
  sol_3_4_pool();
}

function frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(30000, 150, 100);
  var_2 = frag_crate_spawn(var_0, 37.5, 25);
  var_3 = var_1 + var_2;
  return var_3;
}

function frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 1.57828e-05;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / 2 * var_4;
  var_7 *= 3600;
  var_7 += 1.5;
  return var_7;
}

function sol_3_4_pool() {
  self endon("death");
  self show();
  self notify("leaving");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  sortplayerplunderscores(3, self.player_weapon_fired_monitor);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.ref_121ff, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("goal");
  self stoploopsound();
  sortplayerplunderscores(0, 0);
  self notify("heli_gone");
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function sortplayerplunderscores(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level.teamdata[self.team]["alivePlayers"];

  foreach(var_5 in var_3) {
    var_5 setclientomnvar("ui_br_plunder_extract_state", var_0);
    var_5 setclientomnvar("ui_br_plunder_extract_end_time", var_2);
  }
}

function helidescend(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(37.5, 25);
  thread snapplayertotoppos();
  thread snappointtooutofboundstriggertrace();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

function snapshot_crate_spawn() {
  self endon("death");

  if(!isDefined(self.vfxent)) {
    return;
  }

  wait 5;
  self.vfxent endon("death");
  self.vfxent setscriptablepartstate("smoke", "dissipate");
  self.vfxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

function ref_126a7(var_0) {
  var_1 = self;
  var_2 = var_0;
  var_3 = getEnt("airstrikeheight", "targetname");
  var_4 = var_3.origin[2] - 300;
  var_5 = (var_2[0], var_2[1], var_4);
  var_6 = (0, randomfloat(360), 0);
  var_7 = var_5 + -1 * anglesToForward(var_6) * 30000;
  var_8 = var_5 + anglesToForward(var_6) * 30000;
  var_9 = spawnheli(var_1, var_1, var_7, var_5, var_8);
  return var_9;
}

function helicleanupextract(var_0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var_0) && isDefined(self.site)) {
    self.site setscriptablepartstate(self.site.type, self.site.audio_shf_kill_hangar_lights);
    return;
  }
}

function snapplayertotoppos() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && nuke_vault_suicidebomber_internal(var_0)) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

function spawnheli(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = 1;
  var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_4, "veh_apache_plunder_mp", "veh8_mil_air_lbravo_personnel_mp_flyable");

  if(!isDefined(var_6)) {
    return;
  }

  var_7 = var_2 * (1, 1, 0);
  var_6.damagecallback = &callback_vehicledamage;
  var_6.speed = 150;
  var_6.accel = 100;
  var_6.health = 1000;
  var_6.maxhealth = var_6.health;
  var_6.team = var_0.team;
  var_6.owner = var_0;
  var_6.defendloc = var_2;
  var_6.lifeid = 0;
  var_6.flaresreservecount = var_5;
  var_6.pathgoal = var_2;
  var_6.ref_121ff = var_3;
  var_6.endpoint = var_7;
  var_6.select_mountain_two_spawners = var_4[1];
  var_6.vehiclename = "magma_plunder_chopper";
  var_6 setCanDamage(1);
  var_6 setmaxpitchroll(10, 25);
  var_6 vehicle_setspeed(var_6.speed, var_6.accel);
  var_6 sethoverparams(50, 100, 50);
  var_6 setturningability(0.05);
  var_6 setyawspeed(45, 25, 25, 0.5);
  var_6 setotherent(var_0);
  var_6 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  thread handledestroydamage();
  thread smuggler_post_tele_kill();
  return var_6;
}

function smuggler_post_tele_kill() {
  self endon("heli_gone");
  self endon("swapped");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("death", var_2, var_3, var_4, var_5);
  smoke_enemy_think();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread smokesignal(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  snowballfighthint(var_2);
}

function snowballfighthint(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  smoke_screen(1);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function snappointtooutofboundstriggertrace() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("test_f", var_2) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_m", var_3) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_b", var_4) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function smoke_screen(var_0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
    return;
  }
}

function smokesignal(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

function smoke_enemy_think() {
  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.crate)) {
    self.crate delete();
    return;
  }
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      smoke_screen(1);
    }
  }
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
  var_2 = 0;
  self.smoking = 1;
}

function helicreateextractvfx(var_0) {
  self.vfxent = spawn("script_model", var_0);
  self.vfxent setModel("scr_smoke_grenade");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  self.vfxent setscriptablepartstate("smoke", "on");
}

function modifyplayerdamage(var_0) {
  if(isPlayer(var_0.victim)) {
    var_1 = var_0.victim scripts\mp\gametypes\br_public::ref_125f3();
    var_2 = ui_damage_num_next_index(var_0);

    if(!var_1 && var_2) {
      var_0.damage = 0;
    }
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::modifyplayerdamage(var_0);
}

function ref_11ca1(var_0) {
  if(ui_damage_num_next_index(var_0) && isDefined(self.occupants) && self.occupants.size) {
    var_0.damage = 0;
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11ca1(var_0);
}

function brking_cleanupents(var_0) {
  var_1 = isPlayer(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::ref_125f3();
  return var_1;
}

function ui_damage_num_next_index(var_0) {
  return isDefined(var_0.objweapon) && var_0.objweapon.basename == "chopper_support_turret_mp";
}

function ref_12e02() {
  if(!getdvarint("scr_br_reveal_attack_helis_enabled", 1)) {
    return;
  }

  var_0 = [level.grouptorewards, (-4903, 25796, -394), (-28977, 23076, -390), (2693, 41717, 1607)];
  var_1 = (0, 0, 0);

  for(var_2 = 0;; var_2++) {
    var_3 = var_1;

    if(var_2 < var_0.size) {
      var_3 = var_0[var_2];
    }

    var_4 = getdvarvector("scr_br_reveal_attack_heli_" + var_2 + 1 + "_origin", var_3);

    if(var_4 == var_1) {
      break;
    }

    var_5 = getdvarfloat("scr_br_reveal_attack_heli_" + var_2 + 1 + "_delay", 20);
    thread battle_tracks_getsfxalias(var_4, var_5);
    wait 0.1;
  }
}

function infil_chopper_dialogue() {
  if(!isDefined(level.ref_119e7)) {
    return;
  }

  foreach(var_1 in level.ref_119e7) {
    challenges_init(var_1, undefined);
  }
}

function battle_tracks_getsfxalias(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  if(!isDefined(level.ref_119e7)) {
    scripts\mp\gametypes\br_lootchopper::init();
  }

  var_2 = ref_1360e(var_0);
}

function ref_1360e(var_0) {
  var_1 = getdvarfloat("scr_br_reveal_attack_heli_patrol_radius", 4000);
  var_0 = scripts\mp\gametypes\br::resetcircuitbreakers(var_0, (0, 0, 10000));
  var_2 = scripts\cp_mp\killstreaks\chopper_support::getpathstart(var_0);
  var_3 = vectortoangles(var_0 - var_2);
  var_4 = "veh_chopper_support_pe_mp";
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, var_4, "veh8_mil_air_palfa_east");

  if(!isDefined(var_5)) {
    return;
  }

  var_5.speed = getdvarint("scr_br_reveal_attack_heli_speed", 100);
  var_5.accel = getdvarint("scr_br_reveal_attack_heli_accel", 50);
  var_5.lifetime = getdvarint("scr_br_reveal_attack_heli_lifetime", 9999);
  var_5.team = "neutral";
  var_5.angles = var_3;
  var_5.flaresreservecount = 0;
  var_5.currentdamagestate = 0;
  var_5.pathstart = var_2;
  var_5.pathgoal = var_0;
  var_5.currentaction = "patrol";
  var_5.currenttarget = undefined;
  var_5.heightoffset = (0, 0, getdvarint("scr_br_reveal_attack_heli_height_offset", 1500));
  var_5.ref_1220d = var_0;
  var_5.ref_1220f = var_1;
  var_5.ref_13766 = getdvarint("scr_br_reveal_attack_heli_stage_1_acc", 60);
  var_5.ref_11c43 = getdvarint("scr_br_reveal_attack_heli_stage_2_shots", 10);
  var_5.ref_13767 = getdvarint("scr_br_reveal_attack_heli_stage_2_acc", 40);
  var_5.ref_11c44 = getdvarint("scr_br_reveal_attack_heli_stage_3_shots", 20);
  var_5.ref_13768 = getdvarint("scr_br_reveal_attack_heli_stage_3_acc", 20);

  if(var_5.ref_13768 <= 0) {
    var_5.ref_13768 = undefined;
  }

  var_5.infil_complete = var_5.heightoffset[2] - 250;
  var_5 setmaxpitchroll(15, 15);
  var_5 vehicle_setspeed(var_5.speed, var_5.accel);
  var_5 sethoverparams(50, 5, 2.5);
  var_5 setturningability(0.5);
  var_5 setyawspeed(100, 25, 25, 0.1);
  var_5 setCanDamage(0);
  var_5 setneargoalnotifydist(768);
  var_5 setvehicleteam(var_5.team);
  var_5.health = 5000;
  var_5.maxhealth = 9999;
  var_5 scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", var_5.team);
  carriable_weapon_change_watch(var_5);
  var_5 setscriptablepartstate("blinking_lights", "on", 0);
  var_5 setscriptablepartstate("engine", "on", 0);
  var_5.frontturret = spawnturret("misc_turret", var_5 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_5.frontturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var_5.frontturret.team = var_5.team;
  var_5.frontturret.angles = var_5.angles;
  var_5.frontturret.turreton = 1;
  var_5.frontturret.name = "front_turret";
  var_5.frontturret.attackingtarget = undefined;
  var_5.frontturret.ref_14258 = "loot_chopper";
  var_5.frontturret linkTo(var_5);
  var_5.frontturret setturretteam(var_5.team);
  var_5.frontturret setturretmodechangewait(0);
  var_5.frontturret setmode("manual");
  var_5.frontturret setdefaultdroppitch(45);
  var_5.frontturret.groundtargetent = spawn("script_model", var_5.origin);
  var_5.frontturret.groundtargetent setModel("tag_origin");
  var_5.frontturret.groundtargetent dontinterpolate();
  var_5.rearturret = spawnturret("misc_turret", var_5 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_5.rearturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var_5.rearturret.team = var_5.team;
  var_5.rearturret.angles = var_5.angles;
  var_5.rearturret.turreton = 1;
  var_5.rearturret.name = "rear_turret";
  var_5.rearturret.attackingtarget = undefined;
  var_5.rearturret.ref_14258 = "loot_chopper";
  var_5.rearturret linkTo(var_5);
  var_5.rearturret setturretteam(var_5.team);
  var_5.rearturret setturretmodechangewait(0);
  var_5.rearturret setmode("manual");
  var_5.rearturret setdefaultdroppitch(45);
  var_5.rearturret.groundtargetent = spawn("script_model", var_5.origin);
  var_5.rearturret.groundtargetent setModel("tag_origin");
  var_5.rearturret.groundtargetent dontinterpolate();
  level.ref_119e7[level.ref_119e7.size] = var_5;
  var_5.ref_1220c = &scripts\mp\gametypes\br_lootchopper::ref_11a12;
  var_5.has_ammo_drain_passive = &scripts\mp\gametypes\br_lootchopper::ref_11a03;
  var_5.va_standard_spawnpoint_valid = &va_standard_spawnpoint_valid;

  if(getdvarint("scr_br_reveal_attack_objective", 0)) {
    var_5 scripts\mp\gametypes\br_lootchopper::ref_11a04();
  }

  var_5 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  var_5 thread scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var_5.pathgoal, 1);
  return var_5;
}

function va_standard_spawnpoint_valid(var_0) {
  return var_0 scripts\mp\gametypes\br_public::ref_125f3();
}

function carriable_weapon_change_watch() {
  self.vehiclename = "loot_chopper";
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, &challengestarttime);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, &challengesdisabled);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, &challenges_init);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

function challengestarttime(var_0) {
  return false;
}

function challengesdisabled(var_0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage(var_0);
  return true;
}

function challenges_init(var_0) {
  if(isDefined(var_0)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(var_0);
  } else {
    self.killedbyweapon = "none";
  }

  self notify("death");
  return true;
}