/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_numbers_tower.gsc
*****************************************************/

function init() {
  if(!getdvarint("scr_br_numbers_tower_enabled", 0)) {
    return;
  }

  scripts\engine\scriptable::scriptable_addpostinitcallback(&scriptable_postinit);
  scripts\engine\scriptable::ref_12f5b("numbers_tower_model", &ref_11f32);
  level.ref_11f35 = spawnStruct();
  level.ref_11f35.eliminate_drone = getdvarint("scr_br_numbers_tower_broken", 0);
  level.ref_11f35.usable = 0;
  level.ref_11f35.localangles = getdvarint("scr_br_numbers_tower_disable_vo_sequence", 0);
  level.ref_11f35.ref_1277b = getdvarint("scr_br_numbers_tower_play_vo_sequence_once", 0);

  if(!level.ref_11f35.eliminate_drone) {
    level.ref_11f35.usable = getdvarint("scr_br_numbers_tower_usable", 0);
  }

  level.ref_11f35.ref_13c1a = [];
  level.ref_11f35.ref_13c19 = [];

  if(level.ref_11f35.usable) {
    level.ref_1442d = &maxaccesscardspawns_red;
    level._effect["numbers_tower_normal"] = loadfx("vfx/iw8_br/gameplay/vfx_numbers_normal");
    level._effect["numbers_tower_intense"] = loadfx("vfx/iw8_br/gameplay/vfx_numbers_intense");
    switch_disabled();
  }

  thread ref_11ff3();
  thread delay_suspend_vehicle_convoy();
}

function scriptable_postinit() {
  ref_135e7();
}

function ref_11ff3() {
  level waittill("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(level.ref_11f35.usable) {
    targetvehicle();
    thread ref_14440();
    thread ref_129f1();
    return;
  }
}

function put_players_out_of_black_screen() {
  switch (level.mapname) {
    case "mp_br_mechanics":
      return &ref_131fb;
    case "mp_don4_pm":
    case "mp_don4":
      return &ref_131fc;
  }

  return undefined;
}

function barrel_think(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.origin = var0;
  var4.angles = var1;
  var4.ref_1386f = var3;
  var5 = level.ref_11f35.ref_13c1a.size;
  var4.id = level.ref_11f35.ref_13c1a.size;
  var4.getaltbunkerkeypadindexforscriptable = var2;
  level.ref_11f35.ref_13c1a[var5] = var4;
}

function ref_131fb() {
  barrel_think((5518, 140, 0), (0, 130, 0), "test_0");
  barrel_think((6182, 296, 0), (0, 180, 0), "test_1");
  barrel_think((5806, 830, 0), (0, 210, 0), undefined, 1);
}

function ref_131fc() {
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

function ref_135e7() {
  var0 = put_players_out_of_black_screen();

  if(isDefined(var0)) {
    level thread[[var0]]();
  }

  foreach(var2 in level.ref_11f35.ref_13c1a) {
    var3 = var2.origin;
    var4 = var2.angles;
    var5 = ref_135e6(var3, var4);
    var5.id = var2.id;
    var5.getaltbunkerkeypadindexforscriptable = var2.getaltbunkerkeypadindexforscriptable;
    var5.ref_1386f = var2.ref_1386f;

    if(level.ref_11f35.eliminate_drone) {
      var5 setscriptablepartstate("numbers_tower_model", "broken");
    } else if(istrue(var5.ref_1386f)) {
      var5 setscriptablepartstate("numbers_tower_model", "raised");
    }

    level.ref_11f35.ref_13c19[level.ref_11f35.ref_13c19.size] = var5;
  }
}

function ref_135e6(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("communication_antenna_mobile_rig");
  return var2 getlinkedscriptableinstance();
}

function targetvehicle() {
  foreach(var1 in level.ref_11f35.ref_13c19) {
    if(tu0bakechanges(var1)) {
      ref_11a97(var1);
      battle_station_combat_logic(var1);
    }
  }
}

function battle_station_combat_logic(var0) {
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var0.objid = var1;
  var2 = var0.origin + rotatevector((-88, 60, 85), var0.angles);
  scripts\mp\objidpoolmanager::objective_add_objective(var1, "current", var2);
  getbnetigrbattlepassxpmultiplier(var1, 4500, 5000);
  objective_setshowoncompass(var1, 0);
  objective_setbackground(var1, 1);
  objective_icon(var1, "ui_mp_br_mapmenu_legend_mobile_broadcast");
  function_0421(var1, 1);
}

function ref_130f8(var0) {
  if(!isDefined(var0.objid)) {
    return;
  }

  objective_state(var0.objid, "active");
  objective_icon(var0.objid, "ui_mp_br_mapmenu_legend_broadcast_signal");
}

function last_grenade_fire_time(var0) {
  if(!isDefined(var0.objid)) {
    return;
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(var0.objid);
  var0.objid = undefined;
}

function ref_11a97(var0) {
  var0 setscriptablepartstate("numbers_tower_model", "usable");
}

function ref_11f32(var0, var1, var2, var3, var4) {
  thread ref_11ff7(level, var0);
}

function ref_11ff7(var0, var1) {
  var0 endon("death");
  var2 = var1.team;
  ref_12c3c(var2, var0, var1);
  minigun_sweep_to_loc(var0, var1);
  ref_130f8(var0);
  ref_129ef(var0);
  thread ref_12430(level, var2);
}

function minigun_sweep_to_loc(var0, var1) {
  var2 = 50;

  if(getDvar("scr_br_gametype") == "dbd") {
    var2 = getdvarint("scr_brdbd_towercashoverride", 25);
  }

  var1 scripts\mp\gametypes\br_plunder::ref_12627(var2);
}

function ref_129ef(var0) {
  var0 endon("death");
  var0 setscriptablepartstate("numbers_tower_model", "raising");

  while(var0 getscriptablepartstate("numbers_tower_model") != "raised") {
    waitframe();
  }
}

function tu0bakechanges(var0) {
  return var0 getscriptablepartstate("numbers_tower_model") == "disabled";
}

function tugofwar_hvt_placed(var0) {
  return var0 getscriptablepartstate("numbers_tower_model") == "raised";
}

function tugofwar_hvt_taken_firsttime(var0) {
  return var0 getscriptablepartstate("numbers_tower_model") == "usable";
}

function dangercircletick(var0, var1) {
  if(!isDefined(level.ref_11f35) || !istrue(level.ref_11f35.usable)) {
    return;
  }

  var2 = 25000000;

  foreach(var4 in level.ref_11f35.ref_13c19) {
    if(!isDefined(var4.objid)) {
      continue;
    }

    var5 = 5000 + var1;
    var6 = distance2dsquared(var4.origin, var0);

    if(var6 > var5 * var5) {
      last_grenade_fire_time(var4);
    }
  }
}

function ref_12430(var0, var1) {
  var2 = scripts\mp\utility\teams::getfriendlyplayers(var0);

  foreach(var4 in var2) {
    if(isDefined(var4) && !var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() && var4 scripts\cp_mp\utility\player_utility::_isalive()) {
      thread ref_1242f(level);
      waitframe();
    }
  }
}

function ref_1242f(var0) {
  playfxontagforclients(level._effect["numbers_tower_normal"], var0, "tag_origin", var0);
  thread ref_12405(level);
}

function ref_123cf(var0) {
  playfxontagforclients(level._effect["numbers_tower_intense"], var0, "tag_origin", var0);
  thread ref_12405(level);
}

function ref_123d1(var0) {
  playfxontagforclients(level._effect["numbers_tower_intense"], var0, "tag_origin", var0);
  ref_123d2(var0);
}

function ref_12405(var0) {
  var0 endon("death");
  var0 endon("disconnect");

  if(ref_11f31(var0)) {
    return;
  }

  thread handlepersistentgungame(level);
  ref_137e1(var0);
  ref_12406(var0);
  ref_138be(var0);
  var0 notify("numbers_audio_end");
}

function ref_137e1(var0) {
  var0.ref_11f33 = 1;
  var0 playLoopSound("br_numbers_sfx_lp");
  var0 playlocalsound("br_numbers_stinger");
}

function ref_138be(var0) {
  var0 playlocalsound("br_numbers_stinger");
  wait 0.5;
  var0 stoploopsound();
  var0.ref_11f33 = undefined;
}

function ref_12406(var0) {
  if(istrue(level.ref_11f35.localangles)) {
    return;
  }

  if(istrue(level.ref_11f35.ref_1277b) && istrue(var0.ref_11f37)) {
    return;
  }

  var0.ref_11f37 = 1;
  wait 0.75;

  for(var1 = 0; var1 < level.ref_11f35.checked_missiles.size; var1++) {
    var0 playlocalsound(level.ref_11f35.checked_missiles[var1]);
    wait 2.5;
  }
}

function handlepersistentgungame(var0) {
  var0 endon("disconnect");
  var0 endon("numbers_audio_end");
  var0 waittill("death");

  if(!isDefined(var0)) {
    return;
  }

  var0 stoploopsound();
  var0.ref_11f33 = undefined;
}

function ref_123d2(var0) {
  if(ref_11f31(var0)) {
    return;
  }

  var1 = gettime();

  if(isDefined(var0.ref_11e7a) && var0.ref_11e7a > var1) {
    return;
  }

  var0 playlocalsound("br_numbers_stinger");
  var0.ref_11e7a = var1 + 5000;
}

function ref_11f31(var0) {
  return istrue(var0.ref_11f33);
}

function switch_disabled() {
  level.ref_11f35.checked_missiles = [];
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

function bankplunderextractinstantly(var0) {
  level.ref_11f35.checked_missiles[level.ref_11f35.checked_missiles.size] = var0;
}

function ref_129f1() {
  for(;;) {
    foreach(var1 in level.ref_11f35.ref_13c19) {
      if(istrue(var1.ref_1386f) || !tugofwar_hvt_placed(var1)) {
        continue;
      }

      var2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var1.origin, 5000);
      }

      foreach(var4 in var2) {
        if(!isDefined(var4) || var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || !var4 scripts\cp_mp\utility\player_utility::_isalive() || ref_124f9(var4, var1)) {
          continue;
        }

        ref_12c3b(var4, var1);
        ref_123cf(var4);
        ref_12aa0("dlog_event_br_numbers_tower_broadcast", var4, var1);
        waitframe();
      }

      waitframe();
    }

    waitframe();
  }
}

function ref_14440() {
  for(;;) {
    var0 = 0;

    foreach(var2 in level.ref_11f35.ref_13c19) {
      if(tugofwar_hvt_placed(var2)) {
        var0++;
      }
    }

    if(var0 > 0 && var0 >= level.ref_11f35.ref_13c19.size) {
      break;
    }

    waitframe();
  }

  ref_12a9e("dlog_event_br_numbers_tower_all_raised");
  thread ref_123d0();
}

function ref_123d0() {
  for(;;) {
    var0 = gettime();

    for(var1 = 0; var1 < level.players.size; var1++) {
      var2 = level.players[var1];

      if(!isDefined(var2)) {
        continue;
      }

      if(isDefined(var2.ref_11e7b) && var2.ref_11e7b > var0) {
        continue;
      }

      if(isDefined(var2.ref_125e4)) {
        if(!isDefined(var2.ref_11e7b)) {
          thread ref_12405(level);
          ref_12a9f("dlog_event_br_numbers_tower_gas", var2);
        }

        ref_123d1(var2);
        var2.ref_11e7b = var0 + 2500;
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

function ref_12c3c(var0, var1, var2) {
  foreach(var4 in scripts\mp\utility\teams::getfriendlyplayers(var0)) {
    if(isDefined(var2) && var2 == var4) {
      ref_12aa0("dlog_event_br_numbers_tower_used", var4, var1);
    } else {
      ref_12aa0("dlog_event_br_numbers_tower_team_used", var4, var1);
    }

    ref_12c3b(var4, var1);
  }
}

function ref_12c3b(var0, var1) {
  if(ref_124f9(var0, var1)) {
    return;
  }

  var0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a9(var1.getaltbunkerkeypadindexforscriptable);
  ref_130ab(var0, var0, var1);
}

function ref_130ab(var0, var1) {
  if(!isDefined(var1.id)) {
    return;
  }

  if(!isDefined(var0.ref_11f36)) {
    var0.ref_11f36 = [];
  }

  var0.ref_11f36[var1.id] = 1;
}

function ref_124f9(var0, var1) {
  return isDefined(var1.id) && isDefined(var0.ref_11f36) && istrue(var0.ref_11f36[var1.id]);
}

function maxaccesscardspawns_red() {
  var0 = level.audio_start_obj_room_fires;
  var1 = 3;

  while(var0.size > 0 && var1 > 0) {
    var1--;
    var2 = randomint(var0.size);
    var0[var2] scripts\mp\gametypes\br_warp_door::ref_13289();
    var0 = scripts\engine\utility::array_remove_index(var0, var2);
  }
}

function propheight() {
  var0 = [];
  var1 = level.ref_11f35.ref_13c19;

  foreach(var3 in level.ref_11f35.ref_13c19) {
    if(tugofwar_hvt_taken_firsttime(var3) && scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var3.origin)) {
      var0 = var3;
    }
  }

  if(var0.size <= 0) {
    return undefined;
  }

  return var0[randomint(var0.size)];
}

function ref_12a1b(var0, var1) {
  var2 = scripts\engine\trace::ray_trace_get_all_results(var0, var1);

  foreach(var4 in var2) {
    if(!isDefined(var4["entity"])) {
      return var4;
    }
  }

  return var2[var2.size - 1];
}

function ref_12a1a(var0, var1) {
  var2 = scripts\engine\trace::ray_trace_get_all_results(var0, var1);

  foreach(var4 in var2) {
    var5 = var4["entity"];

    if(isDefined(var5) && isalive(var5) && isDefined(var5.vehiclename)) {
      return var4;
    }
  }

  return undefined;
}

function ref_12aa0(var0, var1, var2) {
  var3 = juggernaut_getavoidanceposition();
  var3 = autostartcircle(var3, "towerid", var2.id);
  var3 = autostructnum(var3, var1.origin);
  var1 dlog_recordplayerevent(var0, var3);
}

function ref_12a9f(var0, var1) {
  var2 = juggernaut_getavoidanceposition();
  var2 = autostructnum(var2, var1.origin);
  var1 dlog_recordplayerevent(var0, var2);
}

function ref_12a9e(var0) {
  var1 = juggernaut_getavoidanceposition();
  getentitylessscriptablearray(var0, var1);
}

function juggernaut_getavoidanceposition() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "time_msfrommatchstart");
}

function autostartcircle(var0, var1, var2) {
  var0 = var1;
  var0 = var2;
  return var0;
}

function autostructnum(var0, var1) {
  var0 = autostartcircle(var0, "pos_x", var1[0]);
  var0 = autostartcircle(var0, "pos_y", var1[1]);
  var0 = autostartcircle(var0, "pos_z", var1[2]);
  return var0;
}