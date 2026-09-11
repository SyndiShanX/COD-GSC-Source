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

  foreach(var2, var1 in level.players) {
    var1 scripts\mp\hud_message::showsplash("br_dov_survive");

    if(scripts\mp\utility\player::isreallyalive(var1) && !var1 scripts\mp\gametypes\br_public::ref_125f3()) {
      var1 setclientomnvar("ui_br_reveal_state", 1);
    }
  }

  thread ref_12cf2();

  if(level.ref_13b75 <= 45) {
    var3 = 5;
  } else {
    var3 = 45;
  }

  wait var3 - 6;

  foreach(var2 in level.players) {
    ref_12d0d(var2, "op2_dov1_infil_3");
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
  wait level.ref_13b75 - var3 - 93 - 70;
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

  foreach(var1 in level.players) {
    ref_12d0d(var1, "ebr_alert_phase4_80");
  }

  setomnvar("scriptable_loot_hide", 1);
  var3 = getarraykeys(level.teamdata);

  foreach(var5 in var3) {
    setteamradar(var5, 0);
    setteamradarstrength(var5, 0);
  }

  foreach(var1 in level.players) {
    if(scripts\mp\utility\player::isreallyalive(var1) && !var1 scripts\mp\gametypes\br_public::ref_125f3()) {
      var1 setclientomnvar("ui_br_reveal_state", 2);
    }
  }

  setmusicstate("dovp1_exfil_gameplay");
  ref_12cf1();
  wait 6;

  foreach(var1 in level.players) {
    ref_12d0d(var1, "op2_dov1_infil_2_10");
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(4);
  wait 6;

  if(getdvarint("scr_br_reveal_bombardement_enabled", 1)) {
    level _hidesafecircleui::changetimertoovertimetimer(level.grouptorewards, undefined, 8, 7000);
    wait 4;

    foreach(var1 in level.players) {
      ref_12d0d(var1, "ebr_alert_missile_20");
    }

    wait 11;
  } else {
    wait 15;
  }

  if(getdvarint("scr_br_reveal_exfil_helicopter", 1)) {
    level notify("reveal_exfil_heli_incoming");

    foreach(var1 in level.players) {
      ref_12d0d(var1, "dx_bra_cp1_plague_zone_chopper_inbound", 1);
    }
  }

  scripts\mp\gametypes\br_public::brleaderdialog("plague_exfil", 0, level.players);
  wait 15;

  foreach(var1 in level.players) {
    thread ref_12d0d(var1);
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(3.5);
}

function ref_13b78() {
  level endon("endRevealTimeHandler");
  level notify("revealTimedSection3");
  level notify("end_containment_fx");
  level.ref_12d08 = scripts\engine\utility::play_loopsound_in_space("iw8_nuke_alarm_lp", level.grouptorewards + (0, 0, 500));
  setmusicstate("dovp1_nuke_countdown");

  foreach(var1 in level.players) {
    var1 setsoundsubmix("mp_br_event_dovp1_nuke", 6);
  }

  ref_13365(level.ref_13b79);
  level.ref_11f0f = 1;
  wait 1;

  foreach(var1 in level.players) {
    if(!var1 scripts\mp\gametypes\br_public::ref_125f3()) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("plague_no_exfil", var1, 0);
    }
  }

  setomnvarforallclients("ui_br_reveal_state", 3);
  setomnvarforallclients("ui_hide_minimap", 1);
  wait 1;
  level notify("revealTimedSection3_after_initial_VO");

  foreach(var1 in level.players) {
    ref_12d0d(var1, "op1_dov1_infil_2");
  }

  scripts\mp\gametypes\br_containmentprotocol::elevatordoors(14);
  wait 6;

  foreach(var1 in level.players) {
    ref_12d0d(var1, "ebr_alert_phase4_70");
  }

  wait 1;
  infil_chopper_dialogue();

  foreach(var1 in level.players) {
    ref_12d0d(var1, "op2_dov1_infil_10");
  }

  wait 4;

  foreach(var1 in level.players) {
    ref_12d0d(var1, "ebr_alert_phase4_90");
    var1 setsoundsubmix("mp_br_event_dovp1_outro", 5);
  }

  wait 3;

  foreach(var1 in level.players) {
    var1.plotarmor = 1;
  }

  scripts\mp\gametypes\br_containmentprotocol::elevator_trigger_wait_for_spawn();
}

function searchradiusmin() {
  level endon("watchFinalRunToExfil");
  level endon("forceFinalRunToExfil");
  level waittill("infils_ready");

  for(;;) {
    wait 20;

    foreach(var1 in level.players) {
      if(!var1 scripts\mp\gametypes\br_public::ref_125f3()) {
        var1 thread scripts\mp\rank::giverankxp("br_reveal_surviving", 50);
        var1 thread scripts\mp\rank::scoreeventpopup("br_reveal_surviving");
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
  var0 = 1;

  while(var0) {
    wait 3;
    var0 = 0;
    var1 = getarraykeys(level.teamdata);

    foreach(var3 in var1) {
      if(scripts\mp\gametypes\br_alt_mode_zxp::ref_12bba(var3) > 0) {
        var0 = 1;
        break;
      }
    }

    if(!var0) {
      level notify("forceFinalRunToExfil");
      thread ref_13b78();
      ref_12d0a(level.ref_13b79);
      ref_12cf3(1);
      ref_12cf0();
    }
  }
}

function ref_12cf4() {
  var0 = getdvarvector("br_final_circle_override", level.grouptorewards);
  return var0;
}

function ref_12cf5() {
  level endon("game_ended");

  foreach(var1 in level.players) {
    scripts\mp\gametypes\br::scriptednode(var1);
  }
}

function ref_12d0a(var0) {
  level endon("endRevealTimeHandler");
  wait var0;
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
  foreach(var1 in level.players) {
    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("event_dov_completed");
    waitframe();
    scripts\mp\gametypes\br::ref_13fcc(var1);
    waitframe();
  }
}

function ref_12d0f(var0, var1, var2, var3) {
  level endon("endRevealTimeHandler");
  level endon("forceFinalRunToExfil");

  for(var4 = 1; var4 <= 4; var4++) {
    switch (var4) {
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

    ref_12d00("mp_run_" + var4, var3, 4);
    ref_12cfe("mp_run_" + var4, var3, "zombie_outbreak");
    ref_12d0e(var0);
  }
}

function ref_12cf3(var0) {
  var1 = "mp_final_run";
  var2 = 45;

  if(isDefined(level.ref_12d08)) {
    level.ref_12d08 delete();
  }

  thread scripts\mp\gametypes\br_vehicles::emptyallvehicles();

  if(isDefined(level.ref_12cf6)) {
    foreach(var4 in level.ref_12cf6) {
      var4 destroy();
    }

    level.ref_12cf6 = [];
  }

  foreach(var7 in level.players) {
    if(var7 scripts\mp\gametypes\br_public::ref_125f3()) {
      var7 notify("zombie_unset");
    }

    var7 scripts\mp\utility\player::_freezecontrols(1);
    var7 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  }

  wait 2;
  thread scripts\mp\gametypes\br_vehicles::deleteextantvehicles();
  thread ref_12ceb();
  ref_12d00(var1, var0, 9);
  level notify("end_containment_fx");
  ref_12cfe(var1, var0, "final_nuke");
  wait var2 - 2;
}

function ref_12d00(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(!isalive(var4)) {
      continue;
    }

    var4 skydive_cutparachuteon(var0, 0, var1);
    var4 setclientomnvar("ui_br_bink_overlay_state", var2);
  }
}

function ref_12cfe(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "";
  }

  switch (var2) {
    case "zombie_outbreak":
      break;
    case "final_nuke":
      setmusicstate("");

      foreach(var4 in level.players) {
        if(!isalive(var4)) {
          continue;
        }

        var4 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var4 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
      }

      break;
  }

  foreach(var4 in level.players) {
    if(!isalive(var4)) {
      continue;
    }

    var4 preloadcinematicforplayer(var0, 1, var1);
  }
}

function ref_12d0e(var0) {
  wait var0;

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_br_bink_overlay_state", 0);
    var2 clearsoundsubmix("mp_br_event_dovp1_nuke", 0.5);
    var2 clearsoundsubmix("mp_br_event_dovp1_outro", 0.5);
  }
}

function ref_12cea() {
  var0 = self;

  if(var0 scripts\mp\gametypes\br_public::ref_125f3()) {
    return;
  }

  level.deletescriptableinstanceaftertime = ref_12ce9();
  var0 scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  var0 scripts\mp\gametypes\br::searchcircleorigin(0, 1, 0);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var0, "brloot_equip_gasmask", 1);
  var0 scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  var0 scripts\mp\gametypes\br_pickups::ref_12c81();
  var0 scripts\mp\gametypes\br_pickups::forcegivesuper("super_ammo_drop", 0);
  var0 scripts\mp\gametypes\br::scriptednode(var0);
  var0 scripts\mp\gametypes\br_armor::searchcirclesize();
}

function ref_13268() {
  level endon("game_ended");
  var0 = 20;
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_br_bink_overlay_state", 4);
    var2 preloadcinematicforplayer("mp_connor", 1, 1);
  }
}

function ref_12cfc() {
  wait 1;
  level.vehicle_isneutraltoplayer = [];
  var0 = spawnStruct();
  var0.id = 1;
  var0.occupied = 0;
  var0.origin = (-4903, 25796, -394);
  level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var0;
  var1 = spawnStruct();
  var1.id = 1;
  var1.occupied = 0;
  var1.origin = (-28977, 23076, -390);
  level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var1;
  var2 = spawnStruct();
  var2.id = 1;
  var2.occupied = 0;
  var2.origin = (2693, 41717, 1607);
  level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var2;
}

function ref_12ced(var0) {
  level endon("game_ended");
  setomnvar("ui_br_circle_state", 6);
  setomnvar("ui_hardpoint_timer", gettime() + int(var0 * 1000));
}

function ref_12cef(var0) {
  level endon("game_ended");
  wait var0;
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

function ref_11a48(var0) {
  return false;
}

function ref_12ce9() {
  var0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function relic_third_person() {
  var0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function scripted_fov() {
  var0 = self;
  var0 scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  var0 scripts\mp\gametypes\br_pickups::ref_12c81();
  var0.pers["gamemodeLoadout"] = level.disable_super_in_turret.player_equip_secondary;
  var0.class = "gamemode";
}

function ref_13365(var0) {
  var1 = gettime();
  var2 = var0 * 1000 + var1;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 3);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var0);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  setomnvar("ui_nuke_end_milliseconds", var2);
}

function spawn_cypher_monitor_model() {
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
}

function ref_12cf1() {
  var0 = spawn("script_model", level.grouptorewards - (0, 0, 200));
  var0 setModel("risk_dom_plate");
  var0 setscriptablepartstate("risk_dom_beacon", "on", 0);

  foreach(var2 in level.players) {
    if(var2 scripts\mp\gametypes\br_public::ref_125f3()) {
      var2 scripts\mp\hud_message::showsplash("br_dov_stop_exfil");
      continue;
    }

    var2 scripts\mp\hud_message::showsplash("br_dov_exfil");
  }

  ref_12d02();
  var4 = spawnfx(level._effect["smoke_exfil"], level.grouptorewards);
  triggerfx(var4);
}

function ref_12d02() {
  var0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var0, "current", level.grouptorewards + (0, 0, 600), "ui_mp_br_mapmenu_icon_dov_1_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var0, 1);
    objective_removeallfrommask(var0);

    foreach(var2 in level.players) {
      if(var2 scripts\mp\gametypes\br_public::ref_125f3()) {
        continue;
      }

      objective_addclienttomask(var0, var2);
    }

    objective_showtoplayersinmask(var0);
    level.ref_12d02 = var0;
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

function ref_12d0d(var0, var1) {
  var2 = self;

  if(istrue(var1)) {
    var3 = var0;
  } else {
    var3 = "dx_brm_" + game["dialog"][var1];
    var3 = tolower(var3);
  }

  if(soundexists(var3)) {
    var4 = lookupsoundlength(var3, 1) / 1000;
  } else {
    var4 = 3;
  }

  var4 += 0.5;
  var3 queuedialogforplayer(var4, var2, var4);
}

function onspawnplayer() {
  self notify("br_spawned");

  if(isagent(self)) {
    return;
  }

  var0 = istrue(self.gulag);
  scripts\mp\gametypes\br_pickups::initplayer(var0);
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

function ref_11b80(var0) {
  var1 = 1;

  if(!scripts\mp\gametypes\br_public::ref_125f3()) {
    ref_12d03();
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b80(var0, var1);
}

function ref_11b16() {
  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11b16();
}

function emp_drone_proximity_explode(var0) {
  var1 = 0.5;

  if(!isDefined(self.ref_1286f) || self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  thread scripts\mp\gametypes\br::emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model) && !(isDefined(level.ref_12d05) && level.ref_12d05 == 2)) {
    var2 = level.disable_super_in_turret.ref_12ca1 > 0;
    var3 = undefined;

    if(var2) {
      var3 = level.disable_super_in_turret.ref_12ca1 * 1000;
      scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
      scripts\mp\spectating::setdisabled();
    }

    var4 = scripts\mp\gametypes\br_public::ref_126b8(self.ref_1286f.origin, self.ref_1286f.height);
    var5 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
    scripts\mp\gametypes\br_public::ref_126b9(var4, var5, 1, 0, var3);

    if(var2) {
      var6 = 4;
      var7 = 1;
      var8 = 0.25;
      var9 = var7 - var8;
      self setclientomnvar("ui_show_spectateHud", self getentitynumber());
      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var3));
      var10 = max(level.disable_super_in_turret.ref_12ca1 - var6, 0);
      wait var10;
      thread scripts\mp\gametypes\br_gulag::fadeoutin(var7);
      wait var9;
      scripts\mp\gametypes\br::spawnintermission(var4, self.ref_1286f.angles);
      scripts\mp\gametypes\br::ending_fade_in();
      self setclientomnvar("ui_br_transition_type", 2);
      wait var8;
      var11 = max(level.disable_super_in_turret.ref_12ca1 - var10 - var7, 0);
      wait var11;
      scripts\mp\gametypes\br_public::ref_1252b();
      self setclientomnvar("ui_show_spectateHud", -1);
    } else {
      if(!istrue(level.ref_14623)) {
        scripts\mp\gametypes\br::ending_fade_in();
        self setclientomnvar("ui_br_transition_type", 4);
      }

      wait var1;
      scripts\mp\gametypes\br::spawnintermission(var4, self.ref_1286f.angles);
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
  var0 = ref_12583();
  var1 = var0[0];
  var2 = var0[1];
  var0 = undefined;

  if(!isDefined(var1)) {
    var3 = ref_12584();
    var1 = var3[0];
    var2 = var3[1];
    var3 = undefined;
  }

  if(isDefined(var1)) {
    return [var1, var2];
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::ref_12582();
}

function ref_12583() {
  var0 = undefined;
  var1 = undefined;

  if(!getdvarint("scr_br_reveal_override_zombie_spawns_near_team", 1)) {
    return [var0, var1];
  }

  var2 = getdvarfloat("scr_br_reveal_override_zombie_spawns_near_team_disable_time", -1);

  if(var2 > 0 && isDefined(level.starttime)) {
    var3 = (gettime() - level.starttime) / 1000;

    if(var3 > var2) {
      return [var0, var1];
    }
  }

  var4 = scripts\mp\gametypes\br_alt_mode_zxp::ref_1270e();
  var0 = var4[0];
  var1 = var4[1];
  var4 = undefined;
  return [var0, var1];
}

function ref_12584() {
  var0 = undefined;
  var1 = undefined;
  var2 = 50;
  var3 = 10000;

  if(!getdvarint("scr_br_reveal_override_zombie_spawns_random", 1)) {
    return [var0, var1];
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret.ref_146fb)) {
    return [var0, var1];
  }

  var4 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var6 = var4 + var2;
  var7 = getdvarfloat("scr_br_reveal_override_zombie_spawns_min_angle", 210);
  var8 = getdvarfloat("scr_br_reveal_override_zombie_spawns_max_angle", 390);
  var9 = getdvarint("scr_br_reveal_override_zombie_spawns_attempts", 5);
  var10 = var8 - var7;
  var11 = var10 / var9;
  var12 = randomfloat(var11);
  var13 = [];

  for(var14 = 0; var14 < var9; var14++) {
    var13 = var7 + var14 * var11 + var12;
  }

  var13 = scripts\engine\utility::array_randomize(var13);

  for(var14 = 0; var14 < var13.size; var14++) {
    var15 = anglesToForward((0, var13[var14], 0));
    var16 = scripts\mp\gametypes\br_alt_mode_zxp::run_track_enemy_patrollers(var5, var15, var6);
    var0 = var16[0];
    var1 = var16[1];
    var16 = undefined;

    if(isDefined(var0)) {
      var0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var0, var3);
      break;
    }
  }

  return [var0, var1];
}

function ref_1327a() {
  level endon("game_ended");
  var0 = getdvarint("scr_br_sandbox_time_warning", 120);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_br_circle_state", 5);

  if(level.disable_super_in_turret.timelimit <= 0) {
    return;
  }

  setomnvar("ui_hardpoint_timer", gettime() + int(level.disable_super_in_turret.timelimit * 1000));
  var1 = max(level.disable_super_in_turret.timelimit - var0, 0);
  wait var1;
  setomnvar("ui_br_circle_state", 6);
}

function ontimelimit() {
  if(istrue(level.gameended)) {
    return;
  }

  setupmapquadrantcornersandgrid();
  thread scripts\mp\gametypes\br::brendgame(level.disable_super_in_turret.player_enemy_cooldown, game["end_reason"]["objective_completed"]);
}

function onplayerkilled(var0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  if(isDefined(var0.victim) && isPlayer(var0.victim) && !istrue(level.ref_11f0f)) {
    var0.victim setclientomnvar("ui_br_reveal_state", 4);
    var0.victim scripts\mp\gametypes\br_containmentprotocol::elim_hud();
  }

  if(!isDefined(var0.attacker) || !isPlayer(var0.attacker) || !isDefined(var0.victim) || var0.attacker == var0.victim) {
    return;
  }

  var1 = var0.attacker.team;

  if(!isDefined(level.teamdata[var1]["kills"])) {
    level.teamdata[var1]["kills"] = 0;
  }

  level.teamdata[var1]["kills"]++;

  if(isDefined(level.ref_12d05)) {
    if(!istrue(level.br_prematchstarted)) {
      return;
    }

    if(level.gameended) {
      return;
    }

    var2 = var0.victim;
    var3 = var0.attacker;

    if(!isDefined(var3) || !isPlayer(var3) || !isDefined(var2)) {
      return;
    }

    return;
  }
}

function playerdropplunderondeath(var0, var1) {
  var2 = int(self.plundercount * 0.5);
  var3 = self.plundercount - var2;

  if(var3 <= 0) {
    var3 = 1;
  }

  self.plundercountondeath = var2;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var2);
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var3, var0);
  return true;
}

function setupmapquadrantcornersandgrid() {}

function ref_12cbd(var0, var1) {
  level endon("game_ended");
  level.ontimelimit = &scripts\mp\gametypes\br::ontimelimit;
  var2 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
  level.watchdvars[var2].value = 0;
  level.overridewatchdvars[var2] = 0;
  wait var1;
  level.ref_12888 = &scripts\mp\gametypes\br::emp_drone_proximity_explode;
  level.ref_11c76 = &scripts\mp\gametypes\br::dyn_door;
  level.modeonspawnplayer = &scripts\mp\gametypes\br::onspawnplayer;
  level.disable_super_in_turret.gulagfixuparena = 1;
  level notify("closeSandboxMenu");

  foreach(var4 in level.players) {
    if(isDefined(var4.spawndangertriggers)) {
      var4.spawndangertriggers destroy();
    }
  }

  level.disable_super_in_turret.funcs["spawnHandled"] = undefined;
  level.disable_super_in_turret.funcs["playerKilledSpawn"] = undefined;
}

function ref_12cee() {
  var0 = (10895, -10916, 292);
  var1 = level.br_level.br_circleradii[1] - 42000;
  var2 = scripts\mp\gametypes\br_c130::createtestc130path(var0, var1);
  return var2;
}

function ref_12cec() {
  thread ref_12cf9();
}

function ref_12cf9() {
  level endon("game_ended");
  self endon("death");
  var0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var1;

  foreach(var3 in level.players) {
    if(isDefined(var3) && isDefined(var3.br_infil_type) && var3.br_infil_type == "c130" && !isDefined(var3.jumptype)) {
      var3.jumptype = "outOfBounds";
      var3 notify("halo_kick_c130");
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
    var0 = "a,b,c";
  } else {
    var0 = "dam,stadium,hospital,super,tv,quarry,bank";
  }

  scripts\mp\gametypes\br_zones::swaphelifordrivable("scr_br_reveal_plague_zone_locations", var0);
  thread ref_123bb();
}

function ref_123bb() {
  scripts\mp\flags::gameflagwait("reveal_timed_section_2");
  var0 = getdvarfloat("scr_br_reveal_plague_zone_delete_time", 10);

  foreach(var2 in level.deployingplayer.zones) {
    if(var2.type == "plague") {
      var2 thread scripts\mp\gametypes\br_zones::ref_1471b(undefined, 50, var0);
    }
  }

  wait var0;

  foreach(var2 in level.deployingplayer.zones) {
    if(var2.type == "plague") {
      var2 scripts\mp\gametypes\br_zones::ref_14714();
    }
  }
}

function ref_12cf2() {
  level endon("game_ended");

  if(!getdvarint("scr_br_reveal_exfil_helicopter", 1)) {
    return;
  }

  level waittill("reveal_exfil_heli_incoming");
  var0 = [level.grouptorewards + (500, 0, 0), level.grouptorewards - (500, 0, 0), level.grouptorewards + (350, 0, 500) - (0, 650, 0)];

  for(var1 = 0; var1 < var0.size; var1++) {
    thread ai_is_juggernaut(level);
  }
}

function ai_is_juggernaut(var0) {
  while(istrue(level.create_agent_definition)) {
    wait 1;
  }

  var1 = level.players[randomint(level.players.size)];
  var2 = ref_126a7(var1, var0);

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.origin = var0;
    var3.angles = var2.angles;
    var3.spawntype = "GAME_MODE";
    var4 = spawnStruct();
    var5 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var3, var4);

    if(isDefined(var5)) {
      var2.snapshot_grenade_applysnapshot = var5;
      var5 hide();
      helicreateextractvfx(var2, var0);
      thread onkillstreakend(var2);
      return;
    }

    return;
  }
}

function onkillstreakend(var0) {
  var0 endon("death");
  var0 endon("leaving");
  var0 setvehgoalpos(var0.pathgoal, 1);
  var0 settargetyaw(var0.select_mountain_two_spawners);
  var1 = tracegroundheight(var0, var0.pathgoal + (0, 0, 400));
  var1 += getdvarfloat("scr_br_reveal_exfil_heli_z_offset", 300);
  var1 += randomfloat(getdvarfloat("scr_br_reveal_exfil_heli_z_offset_random", 300));
  var2 = var0.pathgoal[2] - var1;
  var0.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var2);
  var0 waittill("goal");
  thread sound_ent();
  thread snapshot_crate_spawn();
  helidescend(var0, var0.endpoint, var1);
  helicleanupextract(var0, 0);
}

function tracegroundheight(var0) {
  var1 = 125;
  var2 = tracegroundpoint(var0, 100, [self]);
  var3 = var2[2];
  var4 = var3 + var1;
  return var4;
}

function tracegroundpoint(var0, var1, var2) {
  var3 = -99999;
  var4 = (var0[0], var0[1], var3);
  var5 = scripts\engine\trace::create_world_contents();
  var6 = undefined;

  if(isDefined(var1)) {
    var6 = scripts\engine\trace::sphere_trace(var0, var4, var1, var2, var5);
  } else {
    var6 = scripts\engine\trace::ray_trace(var0, var4, var2, var5);
  }

  return var6["position"];
}

function sound_ent() {
  self endon("death");
  level waittill("revealTimedSection3_after_initial_VO");
  wait 3;
  sol_3_4_pool();
}

function frag_crate_player_at_max_ammo(var0) {
  var1 = frag_crate_spawn(30000, 150, 100);
  var2 = frag_crate_spawn(var0, 37.5, 25);
  var3 = var1 + var2;
  return var3;
}

function frag_crate_spawn(var0, var1, var2) {
  var3 = var0 * 1.57828e-05;
  var4 = 0.5 * var2;
  var5 = var1;
  var6 = -1 * var3;
  var7 = (-1 * var5 + sqrt(var5 * var5 - 4 * var4 * var6)) / 2 * var4;
  var7 *= 3600;
  var7 += 1.5;
  return var7;
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

function sortplayerplunderscores(var0, var1) {
  var2 = gettime() + int(var1 * 1000);
  var3 = level.teamdata[self.team]["alivePlayers"];

  foreach(var5 in var3) {
    var5 setclientomnvar("ui_br_plunder_extract_state", var0);
    var5 setclientomnvar("ui_br_plunder_extract_end_time", var2);
  }
}

function helidescend(var0, var1) {
  self endon("death");
  var2 = var0[0];
  var3 = var0[1];
  var4 = (var2, var3, var1);
  self setvehgoalpos(var4, 1);
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

function ref_126a7(var0) {
  var1 = self;
  var2 = var0;
  var3 = getEnt("airstrikeheight", "targetname");
  var4 = var3.origin[2] - 300;
  var5 = (var2[0], var2[1], var4);
  var6 = (0, randomfloat(360), 0);
  var7 = var5 + -1 * anglesToForward(var6) * 30000;
  var8 = var5 + anglesToForward(var6) * 30000;
  var9 = spawnheli(var1, var1, var7, var5, var8);
  return var9;
}

function helicleanupextract(var0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var0) && isDefined(self.site)) {
    self.site setscriptablepartstate(self.site.type, self.site.audio_shf_kill_hangar_lights);
    return;
  }
}

function snapplayertotoppos() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var0);

    if(isDefined(var0) && nuke_vault_suicidebomber_internal(var0)) {
      var0 dodamage(var0.health, self.origin, var0, var0, "MOD_CRUSH");
    }
  }
}

function spawnheli(var0, var1, var2, var3) {
  var4 = vectortoangles(var2 - var1);
  var5 = 1;
  var6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var0, var1, var4, "veh_apache_plunder_mp", "veh8_mil_air_lbravo_personnel_mp_flyable");

  if(!isDefined(var6)) {
    return;
  }

  var7 = var2 * (1, 1, 0);
  var6.damagecallback = &callback_vehicledamage;
  var6.speed = 150;
  var6.accel = 100;
  var6.health = 1000;
  var6.maxhealth = var6.health;
  var6.team = var0.team;
  var6.owner = var0;
  var6.defendloc = var2;
  var6.lifeid = 0;
  var6.flaresreservecount = var5;
  var6.pathgoal = var2;
  var6.ref_121ff = var3;
  var6.endpoint = var7;
  var6.select_mountain_two_spawners = var4[1];
  var6.vehiclename = "magma_plunder_chopper";
  var6 setCanDamage(1);
  var6 setmaxpitchroll(10, 25);
  var6 vehicle_setspeed(var6.speed, var6.accel);
  var6 sethoverparams(50, 100, 50);
  var6 setturningability(0.05);
  var6 setyawspeed(45, 25, 25, 0.5);
  var6 setotherent(var0);
  var6 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  thread handledestroydamage();
  thread smuggler_post_tele_kill();
  return var6;
}

function smuggler_post_tele_kill() {
  self endon("heli_gone");
  self endon("swapped");
  var0 = self.owner;
  var1 = self.team;
  self waittill("death", var2, var3, var4, var5);
  smoke_enemy_think();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread smokesignal(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  snowballfighthint(var2);
}

function snowballfighthint(var0) {
  var1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var1, 256, 140, 70, var0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var1, 0.7);
  playrumbleonposition("grenade_rumble", var1);
  physicsexplosionsphere(var1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  smoke_screen(1);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function snappointtooutofboundstriggertrace() {
  self endon("leaving");
  self endon("death");
  var0 = 70;
  var1 = -80;
  var2 = 150;
  var3 = 25;
  var4 = -100;

  for(;;) {
    var5 = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(var5.size <= 1) {
      wait 0.5;
      continue;
    }

    var6 = scripts\engine\trace::create_vehicle_contents();
    var7 = anglesToForward(self.angles);
    var8 = self.origin + var7 * getdvarfloat("test_f", var2) + (0, 0, getdvarfloat("test_d", var1));
    var9 = scripts\engine\trace::sphere_trace(var8, var8 + (0, 0, 1), var0, self, var6);
    var10 = var9["entity"];

    if(isDefined(var10) && nuke_vault_suicidebomber_internal(var10)) {
      var10 dodamage(var10.health, self.origin, var10, var10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var8 = self.origin + var7 * getdvarfloat("test_m", var3) + (0, 0, getdvarfloat("test_d", var1));
    var9 = scripts\engine\trace::sphere_trace(var8, var8 + (0, 0, 1), var0, self, var6);
    var10 = var9["entity"];

    if(isDefined(var10) && nuke_vault_suicidebomber_internal(var10)) {
      var10 dodamage(var10.health, self.origin, var10, var10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var8 = self.origin + var7 * getdvarfloat("test_b", var4) + (0, 0, getdvarfloat("test_d", var1));
    var9 = scripts\engine\trace::sphere_trace(var8, var8 + (0, 0, 1), var0, self, var6);
    var10 = var9["entity"];

    if(isDefined(var10) && nuke_vault_suicidebomber_internal(var10)) {
      var10 dodamage(var10.health, self.origin, var10, var10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function smoke_screen(var0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
    return;
  }
}

function smokesignal(var0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var0, var0, var0);
  self settargetyaw(self.angles[1] + var0 * 2.5);
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    var9 = scripts\mp\utility\weapon::mapweapon(var9, var13);

    if((var9.basename == "aamissile_projectile_mp" || var9.basename == "nuke_mp") && var4 == "MOD_EXPLOSIVE" && var0 >= self.health) {
      callback_vehicledamage(var1, var1, 9001, 0, var4, var9, var3, var2, var3, 0, 0, var7);
      smoke_screen(1);
    }
  }
}

function callback_vehicledamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  scripts\mp\killstreaks\killstreaks::killstreakhit(var1, var5, self, var4, var2);
  var1 scripts\mp\damagefeedback::updatedamagefeedback("");
  var2 = 0;
  self.smoking = 1;
}

function helicreateextractvfx(var0) {
  self.vfxent = spawn("script_model", var0);
  self.vfxent setModel("scr_smoke_grenade");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  self.vfxent setscriptablepartstate("smoke", "on");
}

function modifyplayerdamage(var0) {
  if(isPlayer(var0.victim)) {
    var1 = var0.victim scripts\mp\gametypes\br_public::ref_125f3();
    var2 = ui_damage_num_next_index(var0);

    if(!var1 && var2) {
      var0.damage = 0;
    }
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::modifyplayerdamage(var0);
}

function ref_11ca1(var0) {
  if(ui_damage_num_next_index(var0) && isDefined(self.occupants) && self.occupants.size) {
    var0.damage = 0;
  }

  return scripts\mp\gametypes\br_alt_mode_zxp::ref_11ca1(var0);
}

function brking_cleanupents(var0) {
  var1 = isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
  return var1;
}

function ui_damage_num_next_index(var0) {
  return isDefined(var0.objweapon) && var0.objweapon.basename == "chopper_support_turret_mp";
}

function ref_12e02() {
  if(!getdvarint("scr_br_reveal_attack_helis_enabled", 1)) {
    return;
  }

  var0 = [level.grouptorewards, (-4903, 25796, -394), (-28977, 23076, -390), (2693, 41717, 1607)];
  var1 = (0, 0, 0);

  for(var2 = 0;; var2++) {
    var3 = var1;

    if(var2 < var0.size) {
      var3 = var0[var2];
    }

    var4 = getdvarvector("scr_br_reveal_attack_heli_" + var2 + 1 + "_origin", var3);

    if(var4 == var1) {
      break;
    }

    var5 = getdvarfloat("scr_br_reveal_attack_heli_" + var2 + 1 + "_delay", 20);
    thread battle_tracks_getsfxalias(var4, var5);
    wait 0.1;
  }
}

function infil_chopper_dialogue() {
  if(!isDefined(level.ref_119e7)) {
    return;
  }

  foreach(var1 in level.ref_119e7) {
    challenges_init(var1, undefined);
  }
}

function battle_tracks_getsfxalias(var0, var1) {
  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  if(!isDefined(level.ref_119e7)) {
    scripts\mp\gametypes\br_lootchopper::init();
  }

  var2 = ref_1360e(var0);
}

function ref_1360e(var0) {
  var1 = getdvarfloat("scr_br_reveal_attack_heli_patrol_radius", 4000);
  var0 = scripts\mp\gametypes\br::resetcircuitbreakers(var0, (0, 0, 10000));
  var2 = scripts\cp_mp\killstreaks\chopper_support::getpathstart(var0);
  var3 = vectortoangles(var0 - var2);
  var4 = "veh_chopper_support_pe_mp";
  var5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var2, var3, var4, "veh8_mil_air_palfa_east");

  if(!isDefined(var5)) {
    return;
  }

  var5.speed = getdvarint("scr_br_reveal_attack_heli_speed", 100);
  var5.accel = getdvarint("scr_br_reveal_attack_heli_accel", 50);
  var5.lifetime = getdvarint("scr_br_reveal_attack_heli_lifetime", 9999);
  var5.team = "neutral";
  var5.angles = var3;
  var5.flaresreservecount = 0;
  var5.currentdamagestate = 0;
  var5.pathstart = var2;
  var5.pathgoal = var0;
  var5.currentaction = "patrol";
  var5.currenttarget = undefined;
  var5.heightoffset = (0, 0, getdvarint("scr_br_reveal_attack_heli_height_offset", 1500));
  var5.ref_1220d = var0;
  var5.ref_1220f = var1;
  var5.ref_13766 = getdvarint("scr_br_reveal_attack_heli_stage_1_acc", 60);
  var5.ref_11c43 = getdvarint("scr_br_reveal_attack_heli_stage_2_shots", 10);
  var5.ref_13767 = getdvarint("scr_br_reveal_attack_heli_stage_2_acc", 40);
  var5.ref_11c44 = getdvarint("scr_br_reveal_attack_heli_stage_3_shots", 20);
  var5.ref_13768 = getdvarint("scr_br_reveal_attack_heli_stage_3_acc", 20);

  if(var5.ref_13768 <= 0) {
    var5.ref_13768 = undefined;
  }

  var5.infil_complete = var5.heightoffset[2] - 250;
  var5 setmaxpitchroll(15, 15);
  var5 vehicle_setspeed(var5.speed, var5.accel);
  var5 sethoverparams(50, 5, 2.5);
  var5 setturningability(0.5);
  var5 setyawspeed(100, 25, 25, 0.1);
  var5 setCanDamage(0);
  var5 setneargoalnotifydist(768);
  var5 setvehicleteam(var5.team);
  var5.health = 5000;
  var5.maxhealth = 9999;
  var5 scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", var5.team);
  carriable_weapon_change_watch(var5);
  var5 setscriptablepartstate("blinking_lights", "on", 0);
  var5 setscriptablepartstate("engine", "on", 0);
  var5.frontturret = spawnturret("misc_turret", var5 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var5.frontturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var5.frontturret.team = var5.team;
  var5.frontturret.angles = var5.angles;
  var5.frontturret.turreton = 1;
  var5.frontturret.name = "front_turret";
  var5.frontturret.attackingtarget = undefined;
  var5.frontturret.ref_14258 = "loot_chopper";
  var5.frontturret linkTo(var5);
  var5.frontturret setturretteam(var5.team);
  var5.frontturret setturretmodechangewait(0);
  var5.frontturret setmode("manual");
  var5.frontturret setdefaultdroppitch(45);
  var5.frontturret.groundtargetent = spawn("script_model", var5.origin);
  var5.frontturret.groundtargetent setModel("tag_origin");
  var5.frontturret.groundtargetent dontinterpolate();
  var5.rearturret = spawnturret("misc_turret", var5 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var5.rearturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var5.rearturret.team = var5.team;
  var5.rearturret.angles = var5.angles;
  var5.rearturret.turreton = 1;
  var5.rearturret.name = "rear_turret";
  var5.rearturret.attackingtarget = undefined;
  var5.rearturret.ref_14258 = "loot_chopper";
  var5.rearturret linkTo(var5);
  var5.rearturret setturretteam(var5.team);
  var5.rearturret setturretmodechangewait(0);
  var5.rearturret setmode("manual");
  var5.rearturret setdefaultdroppitch(45);
  var5.rearturret.groundtargetent = spawn("script_model", var5.origin);
  var5.rearturret.groundtargetent setModel("tag_origin");
  var5.rearturret.groundtargetent dontinterpolate();
  level.ref_119e7[level.ref_119e7.size] = var5;
  var5.ref_1220c = &scripts\mp\gametypes\br_lootchopper::ref_11a12;
  var5.has_ammo_drain_passive = &scripts\mp\gametypes\br_lootchopper::ref_11a03;
  var5.va_standard_spawnpoint_valid = &va_standard_spawnpoint_valid;

  if(getdvarint("scr_br_reveal_attack_objective", 0)) {
    var5 scripts\mp\gametypes\br_lootchopper::ref_11a04();
  }

  var5 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  var5 thread scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var5.pathgoal, 1);
  return var5;
}

function va_standard_spawnpoint_valid(var0) {
  return var0 scripts\mp\gametypes\br_public::ref_125f3();
}

function carriable_weapon_change_watch() {
  self.vehiclename = "loot_chopper";
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, &challengestarttime);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, &challengesdisabled);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, &challenges_init);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

function challengestarttime(var0) {
  return false;
}

function challengesdisabled(var0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage(var0);
  return true;
}

function challenges_init(var0) {
  if(isDefined(var0)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(var0);
  } else {
    self.killedbyweapon = "none";
  }

  self notify("death");
  return true;
}