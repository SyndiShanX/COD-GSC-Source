/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_numbers_tower.gsc
*****************************************************/

function init() {
  if(!getdvarint("scr_br_numbers_tower_enabled", 0)) {
    return;
  }

  scripts\engine\scriptable::scriptable_addpostinitcallback(&scriptable_postinit);
  scripts\engine\scriptable::ref_12F5B("numbers_tower_model", &ref_11F32);
  level.ref_11F35 = spawnStruct();
  level.ref_11F35.eliminate_drone = getdvarint("scr_br_numbers_tower_broken", 0);
  level.ref_11F35.usable = 0;
  level.ref_11F35.localangles = getdvarint("scr_br_numbers_tower_disable_vo_sequence", 0);
  level.ref_11F35.ref_1277B = getdvarint("scr_br_numbers_tower_play_vo_sequence_once", 0);

  if(!level.ref_11F35.eliminate_drone) {
    level.ref_11F35.usable = getdvarint("scr_br_numbers_tower_usable", 0);
  }

  level.ref_11F35.ref_13C1A = [];
  level.ref_11F35.ref_13C19 = [];

  if(level.ref_11F35.usable) {
    level.ref_1442D = &maxaccesscardspawns_red;
    level._effect["numbers_tower_normal"] = loadfx("vfx/iw8_br/gameplay/vfx_numbers_normal");
    level._effect["numbers_tower_intense"] = loadfx("vfx/iw8_br/gameplay/vfx_numbers_intense");
    switch_disabled();
  }

  thread ref_11FF3();
  thread delay_suspend_vehicle_convoy();
}

function scriptable_postinit() {
  ref_135E7();
}

function ref_11FF3() {
  level waittill("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(level.ref_11F35.usable) {
    targetvehicle();
    thread ref_14440();
    thread ref_129F1();
    return;
  }
}

function put_players_out_of_black_screen() {
  switch (level.mapname) {
    case "mp_br_mechanics":
      return &ref_131FB;
    case "mp_don4_pm":
    case "mp_don4":
      return &ref_131FC;
  }

  return undefined;
}

function barrel_think(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.ref_1386F = var_3;
  var_5 = level.ref_11F35.ref_13C1A.size;
  var_4.id = level.ref_11F35.ref_13C1A.size;
  var_4.getaltbunkerkeypadindexforscriptable = var_2;
  level.ref_11F35.ref_13C1A[var_5] = var_4;
}

function ref_131FB() {
  barrel_think((5518, 140, 0), (0, 130, 0), "test_0");
  barrel_think((6182, 296, 0), (0, 180, 0), "test_1");
  barrel_think((5806, 830, 0), (0, 210, 0), undefined, 1);
}

function ref_131FC() {
  barrel_think((11772, 28752, 1088), (0, 330, 0), undefined, 1);
  barrel_think((-9860, -36372, 244), (0, 0, 0), "t9_ch_common_season_55_wz_event_hills");
  barrel_think((-15928, 32440, -236), (0, 350, 0), "t9_ch_common_season_55_wz_event_airport");
  barrel_think((352, 53544, 984), (0, 195, 0), "t9_ch_common_season_55_wz_event_military_base");
  barrel_think((9212, 11036, -344), (0, 315, 0), "t9_ch_common_season_55_wz_event_tv_station");
  barrel_think((-22856, -408, -344), (0, 25, 0), "t9_ch_common_season_55_wz_event_boneyard_supers");
  barrel_think((42708, 33764, -148), (0, 75, 0), "t9_ch_common_season_55_wz_event_salt_mine");
  barrel_think((48704, -10908, 40), (0, 305, 0), "t9_ch_common_season_55_wz_event_farmland");
  barrel_think((34752, -31764, -532), (0, 320, 0), "t9_ch_common_season_55_wz_event_port");
  barrel_think((-22416, -16012, -288), (0, 0, 0), "t9_ch_common_season_55_wz_event_train_station");
}

function ref_135E7() {
  var_0 = put_players_out_of_black_screen();

  if(isDefined(var_0)) {
    level thread[[var_0]]();
  }

  foreach(var_2 in level.ref_11F35.ref_13C1A) {
    var_3 = var_2.origin;
    var_4 = var_2.angles;
    var_5 = ref_135E6(var_3, var_4);
    var_5.id = var_2.id;
    var_5.getaltbunkerkeypadindexforscriptable = var_2.getaltbunkerkeypadindexforscriptable;
    var_5.ref_1386F = var_2.ref_1386F;

    if(level.ref_11F35.eliminate_drone) {
      var_5 setscriptablepartstate("numbers_tower_model", "broken");
    } else if(istrue(var_5.ref_1386F)) {
      var_5 setscriptablepartstate("numbers_tower_model", "raised");
    }

    level.ref_11F35.ref_13C19[level.ref_11F35.ref_13C19.size] = var_5;
  }
}

function ref_135E6(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("communication_antenna_mobile_rig");
  return var_2 getlinkedscriptableinstance();
}

function targetvehicle() {
  foreach(var_1 in level.ref_11F35.ref_13C19) {
    if(tu0bakechanges(var_1)) {
      ref_11A97(var_1);
      battle_station_combat_logic(var_1);
    }
  }
}

function battle_station_combat_logic(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.objid = var_1;
  var_2 = var_0.origin + rotatevector((-88, 60, 85), var_0.angles);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "current", var_2);
  getbnetigrbattlepassxpmultiplier(var_1, 4500, 5000);
  objective_setshowoncompass(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_icon(var_1, "ui_mp_br_mapmenu_legend_mobile_broadcast");
  function_0421(var_1, 1);
}

function ref_130F8(var_0) {
  if(!isDefined(var_0.objid)) {
    return;
  }

  objective_state(var_0.objid, "active");
  objective_icon(var_0.objid, "ui_mp_br_mapmenu_legend_broadcast_signal");
}

function last_grenade_fire_time(var_0) {
  if(!isDefined(var_0.objid)) {
    return;
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(var_0.objid);
  var_0.objid = undefined;
}

function ref_11A97(var_0) {
  var_0 setscriptablepartstate("numbers_tower_model", "usable");
}

function ref_11F32(var_0, var_1, var_2, var_3, var_4) {
  thread ref_11FF7(level, var_0);
}

function ref_11FF7(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_1.team;
  ref_12C3C(var_2, var_0, var_1);
  minigun_sweep_to_loc(var_0, var_1);
  ref_130F8(var_0);
  ref_129EF(var_0);
  thread ref_12430(level, var_2);
}

function minigun_sweep_to_loc(var_0, var_1) {
  var_2 = 50;

  if(getDvar("scr_br_gametype") == "dbd") {
    var_2 = getdvarint("scr_brdbd_towercashoverride", 25);
  }

  var_1 scripts\mp\gametypes\br_plunder::ref_12627(var_2);
}

function ref_129EF(var_0) {
  var_0 endon("death");
  var_0 setscriptablepartstate("numbers_tower_model", "raising");

  while(var_0 getscriptablepartstate("numbers_tower_model") != "raised") {
    waitframe();
  }
}

function tu0bakechanges(var_0) {
  return var_0 getscriptablepartstate("numbers_tower_model") == "disabled";
}

function tugofwar_hvt_placed(var_0) {
  return var_0 getscriptablepartstate("numbers_tower_model") == "raised";
}

function tugofwar_hvt_taken_firsttime(var_0) {
  return var_0 getscriptablepartstate("numbers_tower_model") == "usable";
}

function dangercircletick(var_0, var_1) {
  if(!isDefined(level.ref_11F35) || !istrue(level.ref_11F35.usable)) {
    return;
  }

  var_2 = 25000000;

  foreach(var_4 in level.ref_11F35.ref_13C19) {
    if(!isDefined(var_4.objid)) {
      continue;
    }

    var_5 = 5000 + var_1;
    var_6 = distance2dsquared(var_4.origin, var_0);

    if(var_6 > var_5 * var_5) {
      last_grenade_fire_time(var_4);
    }
  }
}

function ref_12430(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && !var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() && var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      thread ref_1242F(level);
      waitframe();
    }
  }
}

function ref_1242F(var_0) {
  playfxontagforclients(level._effect["numbers_tower_normal"], var_0, "tag_origin", var_0);
  thread ref_12405(level);
}

function ref_123CF(var_0) {
  playfxontagforclients(level._effect["numbers_tower_intense"], var_0, "tag_origin", var_0);
  thread ref_12405(level);
}

function ref_123D1(var_0) {
  playfxontagforclients(level._effect["numbers_tower_intense"], var_0, "tag_origin", var_0);
  ref_123D2(var_0);
}

function ref_12405(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(ref_11F31(var_0)) {
    return;
  }

  thread handlepersistentgungame(level);
  ref_137E1(var_0);
  ref_12406(var_0);
  ref_138BE(var_0);
  var_0 notify("numbers_audio_end");
}

function ref_137E1(var_0) {
  var_0.ref_11F33 = 1;
  var_0 playLoopSound("br_numbers_sfx_lp");
  var_0 playlocalsound("br_numbers_stinger");
}

function ref_138BE(var_0) {
  var_0 playlocalsound("br_numbers_stinger");
  wait 0.5;
  var_0 stoploopsound();
  var_0.ref_11F33 = undefined;
}

function ref_12406(var_0) {
  if(istrue(level.ref_11F35.localangles)) {
    return;
  }

  if(istrue(level.ref_11F35.ref_1277B) && istrue(var_0.ref_11F37)) {
    return;
  }

  var_0.ref_11F37 = 1;
  wait 0.75;

  for(var_1 = 0; var_1 < level.ref_11F35.checked_missiles.size; var_1++) {
    var_0 playlocalsound(level.ref_11F35.checked_missiles[var_1]);
    wait 2.5;
  }
}

function handlepersistentgungame(var_0) {
  var_0 endon("disconnect");
  var_0 endon("numbers_audio_end");
  var_0 waittill("death");

  if(!isDefined(var_0)) {
    return;
  }

  var_0 stoploopsound();
  var_0.ref_11F33 = undefined;
}

function ref_123D2(var_0) {
  if(ref_11F31(var_0)) {
    return;
  }

  var_1 = gettime();

  if(isDefined(var_0.ref_11E7A) && var_0.ref_11E7A > var_1) {
    return;
  }

  var_0 playlocalsound("br_numbers_stinger");
  var_0.ref_11E7A = var_1 + 5000;
}

function ref_11F31(var_0) {
  return istrue(var_0.ref_11F33);
}

function switch_disabled() {
  level.ref_11F35.checked_missiles = [];
  bankplunderextractinstantly("dx_brm_stc_numbers_16_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_23_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_9_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_8_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_14_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_22_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_5_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_18_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_18_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_7_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_11_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_14_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_2_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_12_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_3_10");
  bankplunderextractinstantly("dx_brm_stc_numbers_0_10");
}

function bankplunderextractinstantly(var_0) {
  level.ref_11F35.checked_missiles[level.ref_11F35.checked_missiles.size] = var_0;
}

function ref_129F1() {
  for(;;) {
    foreach(var_1 in level.ref_11F35.ref_13C19) {
      if(istrue(var_1.ref_1386F) || !tugofwar_hvt_placed(var_1)) {
        continue;
      }

      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var_1.origin, 5000);
      }

      foreach(var_4 in var_2) {
        if(!isDefined(var_4) || var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || !var_4 scripts\cp_mp\utility\player_utility::_isalive() || ref_124F9(var_4, var_1)) {
          continue;
        }

        ref_12C3B(var_4, var_1);
        ref_123CF(var_4);
        ref_12AA0("dlog_event_br_numbers_tower_broadcast", var_4, var_1);
        waitframe();
      }

      waitframe();
    }

    waitframe();
  }
}

function ref_14440() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.ref_11F35.ref_13C19) {
      if(tugofwar_hvt_placed(var_2)) {
        var_0++;
      }
    }

    if(var_0 > 0 && var_0 >= level.ref_11F35.ref_13C19.size) {
      break;
    }

    waitframe();
  }

  ref_12A9E("dlog_event_br_numbers_tower_all_raised");
  thread ref_123D0();
}

function ref_123D0() {
  for(;;) {
    var_0 = gettime();

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2)) {
        continue;
      }

      if(isDefined(var_2.ref_11E7B) && var_2.ref_11E7B > var_0) {
        continue;
      }

      if(isDefined(var_2.ref_125E4)) {
        if(!isDefined(var_2.ref_11E7B)) {
          thread ref_12405(level);
          ref_12A9F("dlog_event_br_numbers_tower_gas", var_2);
        }

        ref_123D1(var_2);
        var_2.ref_11E7B = var_0 + 2500;
        waitframe();
      }
    }

    wait 0.1;
  }
}

function delay_suspend_vehicle_convoy() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_event_numbers_sfx");
}

function ref_12C3C(var_0, var_1, var_2) {
  foreach(var_4 in scripts\mp\utility\teams::getfriendlyplayers(var_0)) {
    if(isDefined(var_2) && var_2 == var_4) {
      ref_12AA0("dlog_event_br_numbers_tower_used", var_4, var_1);
    } else {
      ref_12AA0("dlog_event_br_numbers_tower_team_used", var_4, var_1);
    }

    ref_12C3B(var_4, var_1);
  }
}

function ref_12C3B(var_0, var_1) {
  if(ref_124F9(var_0, var_1)) {
    return;
  }

  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_120A9(var_1.getaltbunkerkeypadindexforscriptable);
  ref_130AB(var_0, var_0, var_1);
}

function ref_130AB(var_0, var_1) {
  if(!isDefined(var_1.id)) {
    return;
  }

  if(!isDefined(var_0.ref_11F36)) {
    var_0.ref_11F36 = [];
  }

  var_0.ref_11F36[var_1.id] = 1;
}

function ref_124F9(var_0, var_1) {
  return isDefined(var_1.id) && isDefined(var_0.ref_11F36) && istrue(var_0.ref_11F36[var_1.id]);
}

function maxaccesscardspawns_red() {
  var_0 = level.audio_start_obj_room_fires;
  var_1 = 3;

  while(var_0.size > 0 && var_1 > 0) {
    var_1--;
    var_2 = randomint(var_0.size);
    var_0[var_2] scripts\mp\gametypes\br_warp_door::ref_13289();
    var_0 = scripts\engine\utility::array_remove_index(var_0, var_2);
  }
}

function propheight() {
  var_0 = [];
  var_1 = level.ref_11F35.ref_13C19;

  foreach(var_3 in level.ref_11F35.ref_13C19) {
    if(tugofwar_hvt_taken_firsttime(var_3) && scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_3.origin)) {
      var_0 = var_3;
    }
  }

  if(var_0.size <= 0) {
    return undefined;
  }

  return var_0[randomint(var_0.size)];
}

function ref_12A1B(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace_get_all_results(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4["entity"])) {
      return var_4;
    }
  }

  return var_2[var_2.size - 1];
}

function ref_12A1A(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace_get_all_results(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4["entity"];

    if(isDefined(var_5) && isalive(var_5) && isDefined(var_5.vehiclename)) {
      return var_4;
    }
  }

  return undefined;
}

function ref_12AA0(var_0, var_1, var_2) {
  var_3 = juggernaut_getavoidanceposition();
  var_3 = autostartcircle(var_3, "towerid", var_2.id);
  var_3 = autostructnum(var_3, var_1.origin);
  var_1 dlog_recordplayerevent(var_0, var_3);
}

function ref_12A9F(var_0, var_1) {
  var_2 = juggernaut_getavoidanceposition();
  var_2 = autostructnum(var_2, var_1.origin);
  var_1 dlog_recordplayerevent(var_0, var_2);
}

function ref_12A9E(var_0) {
  var_1 = juggernaut_getavoidanceposition();
  getentitylessscriptablearray(var_0, var_1);
}

function juggernaut_getavoidanceposition() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "time_msfrommatchstart");
}

function autostartcircle(var_0, var_1, var_2) {
  var_0 = var_1;
  var_0 = var_2;
  return var_0;
}

function autostructnum(var_0, var_1) {
  var_0 = autostartcircle(var_0, "pos_x", var_1[0]);
  var_0 = autostartcircle(var_0, "pos_y", var_1[1]);
  var_0 = autostartcircle(var_0, "pos_z", var_1[2]);
  return var_0;
}