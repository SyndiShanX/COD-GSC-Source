/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trials_patches.gsc
***************************************************/

function init_trial_patches() {
  level.create_script_file_ids = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  var_0 = level.trial["zone"];
  var_1 = level.trial["missionID"];
  var_2 = level.trial["missionScript"];
  var_3 = level.trial["variant"];

  switch (level.trial["missionScript"]) {
    case "gun":
      break;
    case "clear":
      level._effect["vehicle_explosion2"] = loadfx("vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx");
      level._effect["vehicle_explosion"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_atv.vfx");
      level._effect["vehicle_fire"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_fire_linger.vfx");
      level._effect["vehicle_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
      level._effect["barrel_explosion1"] = loadfx("vfx/iw8/prop/scriptables/vfx_red_barrel_exp.vfx");
      level._effect["barrel_explosion2"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
      level._effect["barrel_flame_small"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire_sm.vfx");
      level._effect["barrel_fire"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire.vfx");
      level._effect["nuke_rolling_death"] = loadfx("vfx/iw8_mp/killstreak/vfx_nuke_player_death_2.vfx");
      break;
    case "lava":
      break;
    case "jugg":
      break;
    case "gun_nonlinear":
      break;
    case "pitcher":
      break;
    case "race":
      level.ref_142A5 = loadfx("vfx/core/mp/core/vfx_flare_glow_en.vfx");
      level.ref_14297 = loadfx("vfx/iw7/levels/europa/vfx_eu_icecave_flare_01.vfx");
      level._effect["circle"] = loadfx("vfx/iw8_mp/trials/vfx_trials_ring_heli.vfx");
      break;
    case "gunslinger":
      break;
    case "sniper":
      level._effect["ambush_sniper_glint"] = loadfx("vfx/iw8/level/highway/vfx_sniper_glint.vfx");
      level._effect["trial_flare"] = loadfx("vfx/iw8_mp/equipment/tac_insert/vfx_tac_flare_en.vfx");
      level._effect["trial_thermite"] = loadfx("vfx/iw8_br/mp_stadium/vfx_br_stadium_goal_celebration.vfx");
      level._effect["trial_thermite_end"] = loadfx("vfx/iw8_mp/equipment/vfx_thermite_end.vfx");
      break;
    default:
      break;
  }

  switch (level.trial["zone"]) {
    case "mp_m_speed":
      ref_11DDE();
      break;
    case "mp_deadzone":
      ref_11DCC();
      break;
    case "mp_petrograd":
      _precalcsafecirclecenters::switcharray();
      break;
    case "mp_spear":
    case "mp_spear_pm":
      ref_121EF(var_0, var_1);
      thread ref_11D7E(var_0, var_1);
      break;
    case "mp_m_speedball":
      ref_11DDF();
      break;
    case "mp_runner":
    case "mp_runner_pm":
      ref_11DE7(var_2, var_1, var_3);
      break;
    case "mp_raid":
      ref_11DE6();
      break;
    case "mp_euphrates":
      ref_11DD4();
      break;
    case "mp_aniyah":
      ref_11DC4();
      break;
    case "mp_piccadilly":
      ref_11DE4(var_3);
      break;
    case "mp_m_overunder":
      ref_11DDD();
      break;
    case "mp_shipment":
      ref_11DE9();
      break;
    case "mp_vacant":
      ref_11DEF();
      break;
    case "mp_crash2":
      ref_11DCB();
      break;
    case "mp_farms2_gw":
      ref_11DD5();
    case "mp_hackney_am":
    case "mp_hackney_yard":
      ref_11DD6();
      break;
    case "mp_cave_am":
      ref_11DCA();
      break;
    case "mp_m_stack":
      ref_11DE0();
      break;
    case "mp_port2_gw":
      ref_11DE5();
      break;
    case "mp_downtown_gw":
      ref_11DCF();
      break;
    case "mp_boneyard_gw":
      ref_11DC6();
      break;
    case "mp_backlot2":
      ref_11DC5();
      break;
    case "mp_t_reflex":
      ref_11DED(var_3, var_2);
      break;
    case "mp_rust":
      ref_11DE8(var_3);
      break;
    case "mp_hideout":
      ref_11DD9();
      break;
    case "mp_layover_gw":
      ref_11DDA();
      break;
    case "mp_village2":
      ref_11DF1();
      break;
    case "mp_m_trench":
      ref_11DE1();
      break;
    case "mp_hardhat":
      ref_11DD8();
      break;
    case "mp_emporium":
      ref_11DD1();
      break;
    case "mp_harbor":
      ref_11DD7();
      break;
    case "mp_m_king":
      ref_11DDC();
      break;
    case "mp_m_cornfield":
      ref_11DDB(var_2);
      break;
    case "mp_oilrig":
      ref_11DE3();
      break;
    case "mp_t_sn_reflex":
      ref_11DEE();
      break;
    case "mp_escape2":
      ref_11DD2();
      break;
    default:
      break;
  }

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
    return;
  }
}

function ref_121EF(var_0, var_1) {
  if(var_0 == "mp_spear" || var_0 == "mp_spear_pm") {
    if(isDefined(var_1)) {
      var_2 = scripts\engine\utility::string(var_1);
      var_3 = undefined;

      if(var_0 == "mp_spear_pm") {
        var_3 = "iw8_pi_golf21+laserrange_pstl+silencerbalanced";
      } else {
        var_3 = "iw8_pi_golf21+silencerbalanced";
      }

      switch (var_2[2]) {
        case "1":
          var_4 = (692.695, -2043.02, 117.313);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_sm_mpapa5+pistolgrip01+barsil_mpapa5+hybrid_west03+gunperk_burst";
          var_5[0].script_noteworthy = "trial_starting_weapon_NOT";
          var_4 = (692.75, -2092.47, 115.505);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = var_3;
          var_5[0].script_noteworthy = "trial_starting_weapon";
          var_5[0].origin = (692.75, -2096.8, 115.505);
          var_4 = (694.5, -2021.58, 134.055);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_sm_papa90+reflex_west01+silencersmg_west01+pistolgrip01_papa90+laserrange_smg_papa90_v2";
          var_4 = (693.772, -2100.09, 137.15);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_ar_akilo47+minireddot+barsmg_akilo47+stockno_akilo47+calsmg_akilo47+silencer_east01_akilo47";
          break;
        case "2":
          var_4 = (692.538, -2032.93, 115.817);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_ar_scharlie+silencer+gripvert+stockcust+laserrange+reflex_west01_irons";
          var_5[0].script_noteworthy = "trial_starting_weapon_NOT";
          var_4 = (695.223, -2033.98, 156.209);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_ar_mike4+reflex_west01+silencer04+gripvert";
          var_4 = (692.604, -2093.99, 118.358);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_ar_falpha+reflex_west01+silencer+gripvert+stocks";
          var_4 = (693.636, -2101.48, 137.097);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_ar_mcharlie+reflex_west02+silencer_west01+barlong_mcharlie+stockh_mcharlie+pistolgrip01_mcharlie+gripang";
          var_4 = (695.083, -2097.3, 153.988);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_ar_kilo433+holo_west01+barsil_kilo433+stockno_kilo433";
          var_4 = (693.113, -2043.55, 136.183);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);

          foreach(var_7 in var_5) {
            if(var_7.script_parameters == "iw8_ar_akilo47+silencer_east01+pistolgrip01_akilo47") {
              var_7.script_parameters = var_3;
              var_7.script_noteworthy = "trial_starting_weapon";
              var_7.origin = (693.113, -2048, 133.25);
            }
          }

          break;
        case "3":
          var_4 = (691.32, -2045.88, 120.804);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_lm_kilo121+bipod_kilo121+reflex_west02+silencerlmg_west01";
          var_5[0].script_noteworthy = "trial_starting_weapon_NOT";
          var_4 = (694, -2111.61, 150.817);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_lm_mgolf34+acog_east01_irons+silencer+xmags+pistolgrip01";
          var_4 = (693.377, -2106.26, 116.755);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);

          if(var_5.size != 0) {
            var_5[0].script_parameters = "iw8_ar_asierra12+acog_east01+silencer2_asierra12+gripvertpro";
          }

          var_4 = (692.996, -2042.65, 136.554);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);

          if(var_5.size != 0) {
            var_5[0].script_parameters = "iw8_lm_pkilo+acog_east01+silencerlmg_west01+gripvertpro";
          }

          var_4 = (684, -2118, 105);
          var_9 = (2, 124, 90);
          var_7 = spawn("script_origin", var_4);
          var_7.angles = var_9;
          var_7.targetname = "trial_weapon";
          var_7.script_noteworthy = "trial_starting_weapon";
          var_7.script_parameters = var_3;
          break;
        case "4":
          var_4 = (691.56, -2034.7, 120.85);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_sn_mike14+hybrid_west01+silencerdmr_east01+strap_mike14+pistolgrip01_mike14";
          var_5[0].script_noteworthy = "trial_starting_weapon_NOT";
          var_4 = (692.145, -2107.21, 118.634);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = var_3;
          var_5[0].script_noteworthy = "trial_starting_weapon";
          var_5[0].origin = (692.145, -2111.5, 118.35);
          var_4 = (693.044, -2045.93, 135.554);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_sn_alpha50+barshort_alpha50+silencersnpr_alpha50+pistolgrip01_alpha50+stockl_alpha50";
          break;
        case "5":
          var_4 = (691.239, -2086.17, 117.865);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_pi_cpapa+custscope_cpapa+silencerbalanced+barlong_cpapa";
          break;
        case "6":
          var_4 = (694.323, -2041.51, 147.329);
          var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
          var_5[0].script_parameters = "iw8_sh_charlie725+silencershtgn_charlie725+barshort_charlie725+stockno_charlie725+fastreload";
          var_5[0].origin = (695, -2038, 149.25);
          break;
      }
    }
  }

  if(var_0 == "mp_spear_pm") {
    var_4 = (704, 2712, -37);
    var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
    var_5[0].script_parameters = "iw8_sm_uzulu+laserrange_smg";
    var_4 = (100, 3489.25, -3.25);
    var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
    var_5[0].script_parameters = "iw8_lm_pkilo+laserrange_bar";
    var_4 = (-610, 2547.75, 19.25);
    var_5 = getentarrayinradius("trial_weapon", "targetname", var_4, 1);
    var_5[0].script_parameters = "iw8_ar_akilo47+laserrange_bar";
    return;
  }
}

function ref_11D7E(var_0, var_1) {
  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  wait 1;

  if(var_0 == "mp_spear" || var_0 == "mp_spear_pm") {
    var_2 = undefined;
    var_3 = getEntArray("script_model", "classname");

    foreach(var_5 in var_3) {
      if(var_5.model == "veh8_civ_lnd_palfa_rhd_infil") {
        var_2 = var_5;
      }
    }

    if(isDefined(var_2)) {
      var_7 = var_2 getlinkedchildren();
      var_2 delete();
      scripts\engine\utility::array_delete(var_7);
      var_8 = getentarrayinradius("script_model", "classname", (-38.8918, 3264, -43), 1);
      var_8[0] delete();
    }

    var_9 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
    var_10 = (912, 1664, 272);
    var_11 = scripts\engine\utility::getclosest(var_10, var_9, 50);
    var_11.origin = (933, 1701, 272);
    var_12 = (-496, 352, 144);
    var_13 = (-464, 360, 144);
    var_14 = getnodesinradius(var_12, 5, 0, 50, "cover");
    var_15 = spawncovernode(var_13, var_14[0].angles, "Cover Stand");
    var_14[0] disconnectnode();
    return;
  }
}

function trial_chevron_init() {
  var_0 = getDvar("mapname");
  level.trial_chevron_vfx = loadfx("vfx/core/mp/core/vfx_hp_chev_grey.vfx");
  var_1 = [];
  var_2 = getEntArray("trial_hp_chevron", "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_2);

  switch (var_0) {
    case "mp_spear":
      var_3 = [];
      GscBinSkip0(0x2e, 0, spawn("script_origin", (448, -1998, 75)));

    case "mp_spear_pm":
      var_3 = [];
      GscBinSkip0(0x2e, 0, spawn("script_origin", (448, -1998, 75)));

    case "mp_runner":
      var_3 = [];
      GscBinSkip0(0x2e, 0, spawn("script_origin", (2658, 328, 256)));

    case "mp_runner_pm":
      var_3 = [];
      GscBinSkip0(0x2e, 0, spawn("script_origin", (2658, 328, 256)));

    case "mp_cave_am":
      var_3 = [];
      GscBinSkip0(0x2e, 0, spawn("script_origin", (-1934, -1264, -23)));

    case "mp_village2":
      var_3 = [];
      GscBinSkip0(0x2e, 0, spawn("script_origin", (-1208, -2061, 422)));

    default:
      var_3 = [];
      break;
  }

  var_3 = scripts\engine\utility::array_combine(var_3, var_3);
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_4 = spawn("script_model", var_3[var_5].origin);
    var_4[var_5].angles = var_3[var_5].angles;
    var_4[var_5] setModel("tag_origin");
  }

  scripts\engine\utility::array_call(var_3, &delete);
  return var_4;
}

function trial_chevron_vfx_action(var_0, var_1) {
  if(var_1 == "turn_on") {
    foreach(var_3 in var_0) {
      waitframe();
      playFXOnTag(level.trial_chevron_vfx, var_3, "TAG_ORIGIN");
    }
  }

  if(var_1 == "turn_off") {
    foreach(var_3 in var_0) {
      stopFXOnTag(level.trial_chevron_vfx, var_3, "TAG_ORIGIN");
    }

    return;
  }
}

function ref_11DDE() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (60, 2140, 26), (0, 180, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  var_1 = spawn("script_origin", (-260, 2140, 32));
  var_1.angles = (0, 0, 0);
  var_1.targetname = "trial_juggernaut_crate";
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  register_create_script_arrays("mp_m_speed_create_script", "mp_m_speed_trial", &scripts\mp\maps\mp_m_speed\mp_m_speed_create_script::main);
}

function ref_11DCC() {
  if(level.trial["missionScript"] == "jugg") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-728, 588, 460), (0, 320, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    var_1 = spawn("script_origin", (-532, 424, 460));
    var_1.angles = (0, 320, 0);
    var_1.targetname = "trial_juggernaut_crate";
    return;
  }

  if(level.trial["missionScript"] == "race") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (1118, -4101, 328), (9, 153, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    register_create_script_arrays("mp_deadzone_create_script", "mp_deadzone_trial", &scripts\mp\maps\mp_deadzone\mp_deadzone_create_script::main);

    if(level.trial["variant"] == "trialympic") {
      level.ref_13D5B = 1;
      level.ref_13D3A = "trialympic_dogtag";
      return;
    }

    var_2 = getEnt("clip8x8x256", "targetname");
    var_3 = getEnt("clip64x64x64", "targetname");
    var_4 = getEnt("clip32x32x32", "targetname");
    var_5 = [];
    var_6 = [];
    var_7 = [];
    var_5 = spawn("script_model", (-279, -1940, 224));
    var_5[0].angles = (0, 350, 0);
    var_5 = spawn("script_model", (-1075, -2018, 265));
    var_5[1].angles = (0, 26, 0);
    var_5 = spawn("script_model", (-1102, -1878, 271));
    var_5[2].angles = (0, 9, 0);
    var_5 = spawn("script_model", (-1086, -1743, 271));
    var_5[3].angles = (0, 351, 0);
    var_5 = spawn("script_model", (-1266, 1816, 322));
    var_5[4].angles = (0, 0, 0);
    var_5 = spawn("script_model", (-530, 2909, 185));
    var_5[5].angles = (0, 0, 0);
    var_5 = spawn("script_model", (-393, 2906, 182));
    var_5[6].angles = (0, 353, 0);
    var_5 = spawn("script_model", (-265, 2861, 186));
    var_5[7].angles = (0, 334, 0);
    var_5 = spawn("script_model", (664, -1922, 192));
    var_5[8].angles = (0, 43, 0);
    var_5 = spawn("script_model", (847, -2058, 203));
    var_5[9].angles = (0, 343, 0);
    var_5 = spawn("script_model", (1065, -2072, 201));
    var_5[10].angles = (0, 3, 0);
    var_5 = spawn("script_model", (2294, -2189, 174));
    var_5[11].angles = (0, 37, 0);
    var_5 = spawn("script_model", (2356, -2350, 167));
    var_5[12].angles = (0, 0, 0);
    var_5 = spawn("script_model", (2332, -2526, 167));
    var_5[13].angles = (0, 341, 0);
    var_5 = spawn("script_model", (1568, -4350, 131));
    var_5[14].angles = (0, 98, 0);
    var_5 = spawn("script_model", (1354, -4365, 132));
    var_5[15].angles = (0, 84, 0);
    var_5 = spawn("script_model", (1167, -4318, 141));
    var_5[16].angles = (0, 80, 0);

    foreach(var_9 in var_5) {
      var_9 clonebrushmodeltoscriptmodel(var_2);
    }

    var_6 = spawn("script_model", (1101, 2090, 327));
    var_6[0].angles = (0, 134, 0);
    var_6 = spawn("script_model", (975, 2234, 337));
    var_6[1].angles = (3, 225, 0);
    var_6 = spawn("script_model", (283, 1789, 408));
    var_6[2].angles = (0, 78, 0);
    var_6 = spawn("script_model", (206, 1789, 406));
    var_6[3].angles = (0, 98, 0);
    var_6 = spawn("script_model", (-100, 1519, 447));
    var_6[4].angles = (0, 268, 0);
    var_6 = spawn("script_model", (-192, 1495, 440));
    var_6[5].angles = (0, 60, 0);
    var_6 = spawn("script_model", (-795, 1391, 451));
    var_6[6].angles = (0, 304, 0);
    var_6 = spawn("script_model", (-837, 1440, 451));
    var_6[7].angles = (0, 304, 0);
    var_6 = spawn("script_model", (-974, 1506, 438));
    var_6[8].angles = (0, 324, 0);
    var_6 = spawn("script_model", (346, 950, 436));
    var_6[9].angles = (0, 5, 0);
    var_6 = spawn("script_model", (755, -1325, 331));
    var_6[10].angles = (357, 23, 3);
    var_6 = spawn("script_model", (1587, -3411, 293));
    var_6[11].angles = (0, 356, 0);
    var_6 = spawn("script_model", (1583, -3478, 293));
    var_6[12].angles = (0, 356, 0);
    var_6 = spawn("script_model", (914, -4208, 283));
    var_6[13].angles = (357, 328, 2);
    var_6 = spawn("script_model", (-1047, -1708, 403));
    var_6[14].angles = (356, 345, 2);
    var_6 = spawn("script_model", (-609, -1561, 415));
    var_6[15].angles = (357, 312, 3);
    var_6 = spawn("script_model", (-611, -1501, 416));
    var_6[16].angles = (351, 270, 10);
    var_6 = spawn("script_model", (1836, -1879, 334));
    var_6[17].angles = (352, 43, 1);
    var_6 = spawn("script_model", (1877, -1910, 335));
    var_6[18].angles = (359, 321, 7);

    foreach(var_9 in var_6) {
      var_9 clonebrushmodeltoscriptmodel(var_3);
    }

    var_7 = spawn("script_model", (-1153, -1966, 413));
    var_7[0].angles = (359, 2, -5);
    var_7 = spawn("script_model", (-1155, -1935, 411));
    var_7[1].angles = (359, 2, -5);
    var_7 = spawn("script_model", (-1159, -1869, 405));
    var_7[2].angles = (360, 3, 4);
    var_7 = spawn("script_model", (-1161, -1838, 408));
    var_7[3].angles = (360, 3, 4);
    var_7 = spawn("script_model", (-1166, -1780, 409));
    var_7[4].angles = (360, 3, 6);
    var_7 = spawn("script_model", (-1168, -1749, 413));
    var_7[5].angles = (360, 3, 6);
    var_7 = spawn("script_model", (-1098, 1659, 433));
    var_7[6].angles = (360, 22, -4);
    var_7 = spawn("script_model", (-1111, 1689, 431));
    var_7[7].angles = (360, 22, -4);
    var_7 = spawn("script_model", (-1131, 1747, 431));
    var_7[8].angles = (0, 18, 3);
    var_7 = spawn("script_model", (-1141, 1778, 433));
    var_7[9].angles = (0, 18, 3);
    var_7 = spawn("script_model", (-1154, 1837, 430));
    var_7[10].angles = (0, 12, 3);
    var_7 = spawn("script_model", (-1161, 1869, 432));
    var_7[11].angles = (0, 12, 3);
    var_7 = spawn("script_model", (-526, 2859, 324));
    var_7[12].angles = (358, 86, 3);
    var_7 = spawn("script_model", (-494, 2856, 322));
    var_7[13].angles = (358, 86, 3);
    var_7 = spawn("script_model", (-436, 2855, 321));
    var_7[14].angles = (3, 82, 2);
    var_7 = spawn("script_model", (-404, 2850, 320));
    var_7[15].angles = (3, 82, 2);
    var_7 = spawn("script_model", (-351, 2840, 323));
    var_7[16].angles = (3, 72, -2);
    var_7 = spawn("script_model", (-320, 2830, 324));
    var_7[17].angles = (3, 72, -2);
    var_7 = spawn("script_model", (-267, 2805, 331));
    var_7[18].angles = (360, 65, 1);
    var_7 = spawn("script_model", (-237, 2791, 330));
    var_7[19].angles = (360, 65, 1);
    var_7 = spawn("script_model", (685, -1761, 333));
    var_7[20].angles = (357, 16, 7);
    var_7 = spawn("script_model", (694, -1791, 329));
    var_7[21].angles = (357, 16, 7);
    var_7 = spawn("script_model", (733, -1885, 328));
    var_7[22].angles = (0, 33, -8);
    var_7 = spawn("script_model", (750, -1911, 333));
    var_7[23].angles = (0, 33, -8);
    var_7 = spawn("script_model", (834, -2002, 346));
    var_7[24].angles = (4, 59, -4);
    var_7 = spawn("script_model", (861, -2019, 348));
    var_7[25].angles = (4, 59, -4);
    var_7 = spawn("script_model", (1572, -4302, 272));
    var_7[26].angles = (0, 280, -1);
    var_7 = spawn("script_model", (1541, -4308, 272));
    var_7[27].angles = (0, 280, -1);
    var_7 = spawn("script_model", (1441, -4328, 276));
    var_7[28].angles = (360, 274, -1);
    var_7 = spawn("script_model", (1410, -4331, 276));
    var_7[29].angles = (360, 274, -1);
    var_7 = spawn("script_model", (1305, -4315, 282));
    var_7[30].angles = (360, 254, -3);
    var_7 = spawn("script_model", (1275, -4306, 283));
    var_7[31].angles = (360, 254, -3);
    var_7 = spawn("script_model", (1179, -4270, 290));
    var_7[32].angles = (358, 238, 1);
    var_7 = spawn("script_model", (1152, -4254, 290));
    var_7[33].angles = (358, 238, 1);

    foreach(var_9 in var_7) {
      var_9 clonebrushmodeltoscriptmodel(var_4);
    }

    return;
  }
}

function ref_11DE9() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-654.833, 1994.12, 15.9902), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  var_1 = spawn("script_origin", (-278.833, 1994.12, 15.9902));
  var_1.angles = (0, 0, 0);
  var_1.targetname = "trial_juggernaut_crate";
}

function ref_11DDF() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.targetname = "progression";
  var_0.target = "alpha";
  var_0.script_noteworthy = "start";
  thread pavelow_boss_health_bar(var_0);
  var_1 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-892, 5, 16), (0, 43.1957, 0));
  scripts\mp\spawnlogic::bdiedonce([var_1]);
  init_nuke_vault((-739.378, 167.847, 66.9861), (285.714, 315.5, -46.9039), "trial_variant_fast", undefined, "iw8_lm_lima86+reflexmini+barshort+pistolgrip02+silencer3");
  init_nuke_vault((-738.471, 187.473, 63.2056), (38.4734, 89.4932, -0.965993), "trial_variant_fast", undefined, "iw8_pi_golf21+fastreload+trigcust03+laserrange+stockcust+xmagslrg");
  init_nuke_vault((-739.5, 188.25, 54.5), (18.2161, 89.5772, -0.784029), "trial_variant_fast", undefined, "iw8_pi_papa320+fastreload+trigcust03+laserrange+xmagslrg");
  init_nuke_vault((-740.8, 75.613, 65.6452), (296.215, 48.4494, 45.8564), "trial_variant_fast", undefined, "iw8_sh_romeo870+fastreload+stockno+xmags+gripcust+barshort");
  init_nuke_vault((-740.187, 103.475, 69.1132), (284.965, 342.911, -72.7181), "trial_variant_fast", undefined, "iw8_ar_asierra12+stocks+pistolgrip02+barshort");
  init_nuke_vault((-740.294, 116.337, 71.5601), (292.978, 47.6906, 43.0764), "trial_variant_fast", undefined, "iw8_sn_mike14+laserbalanced+pistolgrip06+xmagslrg+barshort");
  init_nuke_vault((-739.47, 86.873, 69.4761), (282.94, 337.806, -67.6405), "trial_variant_fast", undefined, "iw8_ar_falima+stockno+pistolgrip02+barshort");
  init_nuke_vault((-737.721, 189.723, 75.7056), (10.9774, 89.6008, -0.726613), "trial_variant_fast", undefined, "iw8_pi_cpapa+fastreload+trigcust+calcust2+pistolgrip02+barshort");
  init_nuke_vault((-741.622, 154.403, 67.7361), (282.486, 61.4191, 28.8511), "trial_variant_fast", undefined, "iw8_ar_mike4+fastreload+stockh+pistolgrip02+calcust+gripvert");
  init_nuke_vault((615.378, -154.847, 52.986), (277.284, 38.6086, 9.38197), "trial_variant_pickup", "osp", "iw8_ar_mike4+reflex4+fmj+stockno+pistolgrip02");
  init_nuke_vault((-353.3, 626.613, 52.3952), (0.706816, 90.4638, 3.21603), "trial_variant_pickup", "osp", "iw8_sh_romeo870+fastreload+stockno+xmags+gripcust+barshort");
  init_nuke_vault((-209.47, 372.373, 49.7261), (272.789, 302.444, -32.1599), "trial_variant_pickup", "osp", "iw8_ar_scharlie+fastreload+laserbalanced+stockl+pistolgrip02+barshort");
  init_nuke_vault((-253.687, -265.525, 17.8632), (359.286, 238.951, -92.3844), "trial_variant_pickup", "osp", "iw8_ar_asierra12+stocks+pistolgrip02+barshort");
  init_nuke_vault((-721.294, 136.337, 56.5601), (286.817, 86.2294, 2.34117), "trial_variant_pickup", "osp", "iw8_sn_sbeta+acog2+fastreload+laserbalanced+stockh+pistolgrip02");
  init_nuke_vault((-720.471, 129.723, 55.9556), (10.9774, 89.6008, -0.726613), "trial_variant_pickup", "osp", "iw8_pi_cpapa+fastreload+trigcust+laserrange+pistolgrip02+barshort");
  init_nuke_vault((495.597, 512.911, 59.2126), (278.32, 353.274, 4.7039), "trial_variant_pickup", "osp", "iw8_sm_mpapa5+laserbalanced+stockno+pistolgrip02+calcust+barshort");
  register_create_script_arrays("mp_m_speedball_create_script", "mp_m_speedball_trial", &scripts\mp\maps\mp_m_speedball\mp_m_speedball_create_script::main);
}

function ref_11DE7(var_0, var_1, var_2) {
  if(var_0 == "clear") {
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (2731, 727.75, 253), (0, 270, 0));
    scripts\mp\spawnlogic::bdiedonce([var_3]);
    init_nuke_vault((3023.75, -289.25, 125.75), (0, 270, 0), undefined, "trial_starting_weapon", "iw8_knife");
    init_nuke_vault((2587, 611, 305), (360, 270, 0), "trial_variant_assault", undefined, "iw8_ar_mike4+minireddot+gripvert");
    init_nuke_vault((2587.5, 613, 322), (0, 270, 0), "trial_variant_assault", undefined, "iw8_ar_asierra12+minireddot+gripvert");
    init_nuke_vault((2586.75, 549.25, 308), (0, 270, 0), "trial_variant_assault", undefined, "iw8_ar_tango21+minireddot_tall+gripvert+stockl_tango21+barshort_tango21");
    init_nuke_vault((2585.75, 553, 323), (0, 270, 0), "trial_variant_assault", undefined, "iw8_ar_scharlie+reflex_east01+silencer_west01+gripvert+stocks_scharlie+laserrange");
    init_nuke_vault((2587, 550, 325.75), (360, 270, 0), "trial_variant_heavy", undefined, "iw8_lm_mgolf36+stockl+calcust+gripang+barmid");
    init_nuke_vault((2586, 558, 305), (0, 270, 0), "trial_variant_heavy", undefined, "iw8_lm_mgolf34+silencer+xmags+pistolgrip01");
    init_nuke_vault((2587.5, 618, 322), (360, 270, 5.48232), "trial_variant_heavy", undefined, "iw8_lm_pkilo+acog_east01+silencerbalanced+gripvertpro");
    init_nuke_vault((2588, 621, 305), (0, 270, 0), "trial_variant_heavy", undefined, "iw8_lm_kilo121+silencerlmg_west01+bipod_kilo121");
    init_nuke_vault((2586.6, 611.86, 312.064), (359, 270, -0.000128963), "trial_variant_night", undefined, "iw8_pi_papa320+silencer+fastreload+laserrange");
    level.ref_12489 = "equip_frag";
    level.ref_1248B = "equip_flash";
    level.ref_1248A = 1;
    thread scripts\mp\trials\mp_trl_cleararea::init_trap_room_debug();
    register_create_script_arrays("mp_runner_create_script", "mp_runner_create_script", &scripts\mp\maps\mp_runner\mp_runner_create_script::main);

    if(var_1 == 323) {
      level.ref_124C9 = 1;
      return;
    }

    return;
  }

  if(var_0 == "lava") {
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (1472, -1121, 311), (0, 53.5, 0));
    scripts\mp\spawnlogic::bdiedonce([var_3]);
    var_4 = getEnt("care_package_col", "targetname");
    var_5 = [];
    GscBinSkip0(0x2e, 0, spawn("script_model", (-390, 25, 256)));
  }
}

function ref_11DC4() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-2144, -1263, 312), (0, 7, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  register_create_script_arrays("mp_aniyah_create_script", "mp_aniyah_trial", &scripts\mp\maps\mp_aniyah\mp_aniyah_create_script::main);
  var_1 = getEnt("clip8x8x256", "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (-191, -1785, 116)));
}

function ref_11DE6() {
  if(level.trial["missionScript"] == "race") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-2700, 748, 271), (0, 70, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  } else if(level.trial["missionScript"] == "sniper") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-155, 3420, 521), (0, 270, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    init_nuke_vault((-176, 3172, 532), (315, 270, 0), undefined, "outline", "iw8_sn_crossbow+ammo_crossbow+armstac_crossbow+fastreload+grip_crossbow+rec_crossbow+stocks_crossbow+custscope_crossbow+wirel_crossbow");
    level.ref_13D8F = 1;
    level.showdebugresult = 10000;
    level.ref_13D94 = 1;
    level.ref_13D95 = 3;
  }

  register_create_script_arrays("mp_raid_create_script", "race_trial", &scripts\mp\maps\mp_raid\mp_raid_create_script::main);
}

function ref_11DD4() {
  var_0 = [];
  var_1 = [];

  switch (level.trial["missionScript"]) {
    case "sniper":
      var_2 = spawnStruct();
      var_2.origin = (193, -12, 23);
      var_2.angles = (0, 330, 0);
      register_create_script_arrays("mp_euphrates_create_script", "mp_euphrates_create_script", &_maphint_computerscriptableused::main);
      init_nuke_vault((428, -176, 38), (278, 360, 90), "trial_variant_sniper", "trial_starting_weapon", "iw8_pi_cpapa");
      init_nuke_vault((428, -176, 38), (278, 360, 90), "trial_variant_sniper", "outline", "iw8_sn_delta+barshort+vzscope+ammomod_impact");
      init_nuke_vault((0, 0, 0), (0, 0, 0), "trial_variant_pistol", "trial_starting_weapon", "iw8_knife");
      init_nuke_vault((480.5, -105.5, 58.5), (17, 90, 6), "trial_variant_pistol", "outline", "iw8_pi_decho+trigcust02+xmags+barlong+brake+acog3");
      level.ref_13D8F = 1;
      thread ref_13A69();
      break;
    case "gun_nonlinear":
      var_2 = spawnStruct();
      var_2.origin = (388, 712, 28);
      var_2.angles = (0, 218, 0);
      register_create_script_arrays("mp_euphrates_create_script_gunnonlinear", "mp_euphrates_create_script_gunnonlinear", &_maphint_keypadscriptableused::main);
      init_nuke_vault((-81.47, 604.373, 47.9761), (358.504, 182.354, 90.2531), "trial_variant_pickup", "osp", "iw8_pi_cpapa+custscope_cpapa+barlong_cpapa+pistolgrip_pstl04_cpapa");
      init_nuke_vault((493.53, -167.877, 54), (358.5, 8, 0), "trial_variant_pickup", "osp", "iw8_ar_mike4+barlong_mike4+stocks_mike4+calcust_mike4_50+snprscope_mike14_ar+gunperk_semi+silencerbalanced+bipod");
      init_nuke_vault((16.53, -987.627, 47.726), (0, 211, 90), "trial_variant_pickup", "osp", "iw8_sh_charlie725+barlong_charlie725+slugs_charlie725+custscope_charlie725+silencerbalancedshtgn_charlie725");
      init_nuke_vault((596.53, -1595.63, 47.7261), (0, 0, -90), "trial_variant_pickup", "osp", "iw8_sn_kilo98+barshort_kilo98+stockl_kilo98+snprscope_kilo98");
      var_1 = spawn("script_model", (-80, 568, 15));
      var_1 = spawn("script_model", (-80, 600, 15));
      var_1 = spawn("script_model", (18, -1016, 15));
      var_1 = spawn("script_model", (18, -984, 15));
      var_1 = spawn("script_model", (594, -1624, 15));
      var_1 = spawn("script_model", (594, -1592, 15));
      var_1 = spawn("script_model", (499, -177, 15));
      var_1 = spawn("script_model", (499, -145, 15));
      var_1 = spawn("script_model", (548, -514, 15));
      var_1 = spawn("script_model", (548, -482, 15));
      var_1 = spawn("script_model", (548, -482, 24));
      var_1 = spawn("script_model", (548, -514, 32));
      var_1 = spawn("script_model", (524, -514, 32));
      var_1 = spawn("script_model", (524, -514, 15));
      var_1 = spawn("script_model", (524, -482, 24));
      var_1 = spawn("script_model", (524, -482, 15));
      var_1 = spawn("script_model", (-12, -542, 32));
      var_1 = spawn("script_model", (-12, -542, 15));
      var_1 = spawn("script_model", (-12, -510, 24));
      var_1 = spawn("script_model", (-12, -510, 15));
      var_1 = spawn("script_model", (-36, -542, 32));
      var_1 = spawn("script_model", (-36, -542, 15));
      var_1 = spawn("script_model", (-36, -510, 24));
      var_1 = spawn("script_model", (-36, -510, 15));
      var_1 = spawn("script_model", (568, -1691, 24));
      var_1 = spawn("script_model", (568, -1691, 15));
      var_1 = spawn("script_model", (568, -1723, 32));
      var_1 = spawn("script_model", (568, -1723, 15));
      var_1 = spawn("script_model", (592, -1691, 24));
      var_1 = spawn("script_model", (592, -1691, 15));
      var_1 = spawn("script_model", (592, -1723, 32));
      var_1 = spawn("script_model", (592, -1723, 15));
      var_1 = spawn("script_model", (-55, 699, 24));
      var_1 = spawn("script_model", (-55, 699, 15));
      var_1 = spawn("script_model", (-55, 667, 32));
      var_1 = spawn("script_model", (-55, 667, 15));
      var_1 = spawn("script_model", (-79, 699, 24));
      var_1 = spawn("script_model", (-79, 699, 15));
      var_1 = spawn("script_model", (-79, 667, 32));
      var_1 = spawn("script_model", (-79, 667, 15));
      var_2 = spawn("script_model", (535, -491, 14));
      var_2 = spawn("script_model", (-25, -518, 12));
      var_2 = spawn("script_model", (579, -1699, 12));
      var_2 = spawn("script_model", (-68, 691, 12));
      thread ref_11DD3();
      thread ref_13A69();
      break;
    case "race":
      var_2 = spawnStruct();
      var_2.origin = (2430, -1939, -102);
      var_2.angles = (0, 68, 0);
      init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
      register_create_script_arrays("mp_trl_create_a_script_race_euphrates", "mp_t_euphrates_race_trial", &_purchasemenuclosedbyclient::main);
      var_3 = getEnt("clip64x64x64", "targetname");
      var_4 = [];
      GscBinSkip0(0x2e, 0, spawn("script_model", (-346, -819, -290)));

    default:
      var_2 = spawnStruct();
      var_2.origin = (0, 0, 0);
      var_2.angles = (0, 0, 0);
      var_12 = [];
      break;
  }

  var_13 = getEnt("clip32x32x32", "targetname");

  foreach(var_6 in var_3) {
    var_6 clonebrushmodeltoscriptmodel(var_13);
  }

  var_16 = getEnt("tactical_cover_col", "targetname");

  foreach(var_6 in var_4) {
    var_6 clonebrushmodeltoscriptmodel(var_16);
  }

  var_19 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", var_2.origin, var_2.angles);
  scripts\mp\spawnlogic::bdiedonce([var_19]);
}

function ref_11DD3() {
  level waittill("course_started");
  var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_metal_panel_03_left_mp", "classname");
  var_1 = scripts\engine\utility::getclosest((1876, -1397, -56), var_0, 10);
  var_1 constraintoscriptgoalRadius();

  foreach(var_3 in var_0) {}
}

function ref_11DE4(var_0) {
  var_1 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-2666, 390, 198), (0, 45, 0));
  scripts\mp\spawnlogic::bdiedonce([var_1]);

  if(var_0 == "pistol") {
    var_2 = (0, 0, 0);
    var_3 = (0, 0, 0);
    var_4 = spawn("script_origin", var_2);
    var_4.angles = var_3;
    var_4.targetname = "trial_weapon";
    var_4.script_noteworthy = "trial_starting_weapon";
    var_4.script_parameters = "iw8_pi_decho";
  }

  var_5 = getEnt("clip64x64x8", "targetname");
  var_6 = spawn("script_model", (-2510.15, 508.249, 237));
  var_6.angles = (90, 225, 0);
  var_6.targetname = "trial_truck_door_coll_l";
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = spawn("script_model", (-2549.75, 547.847, 237));
  var_7.angles = (90, 225, 0);
  var_7.targetname = "trial_truck_door_coll_r";
  var_7 clonebrushmodeltoscriptmodel(var_5);
  var_8 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (-1657, -514, 253)));
}

function ref_11DDD() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (551, 968, 16), (0, 223, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((596.712, 826.265, 52.7056), (38.4733, 358.746, -0.96607), "trial_variant_fast", undefined, "iw8_pi_golf21+reflexmini2+pistolgrip02+trigcust02+laserrange+barshort");
  init_nuke_vault((597.505, 827.286, 44), (18.2161, 358.831, -0.784065), "trial_variant_fast", undefined, "iw8_pi_mike1911+laserrange+pistolgrip02+barshort+trigcust+xmags");
  init_nuke_vault((577.046, 826.312, 56.4861), (285.713, 224.755, -46.9075), "trial_variant_fast", undefined, "iw8_lm_mgolf36+stockl+silencer2+calcust+gripang+barmid");
  init_nuke_vault((563.626, 828.726, 57.2361), (282.486, 330.676, 28.8378), "trial_variant_fast", undefined, "iw8_ar_mike4+holo3+laserbalanced+pistolgrip02+gripang+barmid");
  init_nuke_vault((550.079, 827.501, 57.7261), (287.752, 230.356, -51.1188), "trial_variant_fast", undefined, "iw8_ar_akilo47+gripang+laserbalanced+pistolgrip02+stockl+fastreload");
  init_nuke_vault((522.533, 827.936, 61.0601), (292.978, 316.954, 43.057), "trial_variant_fast", undefined, "iw8_ar_scharlie+silencer2+xmagslrg+pistolgrip02+stocks+barshort");
  init_nuke_vault((505.864, 827.979, 58.6132), (284.965, 252.173, -72.7305), "trial_variant_fast", undefined, "iw8_ar_tango21+silencer2+holo3+pistolgrip01+stockl+barshort");
  init_nuke_vault((487.901, 827.433, 58.9761), (282.94, 247.059, -67.6423), "trial_variant_fast", undefined, "iw8_ar_falima+barshort+stockl+gripang+xmagslrg+fastreload");
  init_nuke_vault((-255, 307, 44.5), (277, 271, 90), "trial_variant_pickup", "osp", "iw8_ar_falima+barshort+stockl+gripang+fastreload");
  init_nuke_vault((0, 655, 47), (0, 0, 0), "trial_variant_pickup", "osp", "iw8_pi_golf21+reflexmini2+pistolgrip02+trigcust02+laserrange+barshort");
  init_nuke_vault((130.25, 97.75, 49.7261), (0, 0, 0), "trial_variant_pickup", "osp", "iw8_ar_akilo47+pistolgrip02+gripang+calsmg+stockl+barshortnoguard");
  init_nuke_vault((224.5, -280.5, 46.75), (0, 90, 0), "trial_variant_pickup", "osp", "iw8_sn_mike14+comp+gripang+pistolgrip03+fastreload+xmagslrg");
  init_nuke_vault((-365.75, -279.75, 11.5), (286, 186, 90), "trial_variant_pickup", "osp", "iw8_ar_mike4+barshort+pistolgrip02+holo+stocks+silencer2");
  var_1 = getEnt("clip64x64x8", "targetname");
  var_2 = getEnt("clip64x64x256", "targetname");
  var_3 = spawn("script_model", (-393, 990.25, 177.5));
  var_3.angles = (270, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_1);
  var_4 = spawn("script_model", (-393, 936.5, 177.5));
  var_4.angles = (270, 0, 0);
  var_4 clonebrushmodeltoscriptmodel(var_1);
  var_5 = spawn("script_model", (-393, 911.5, 177.5));
  var_5.angles = (270, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_1);
  var_6 = spawn("script_model", (-287.75, 321.5, 177.5));
  var_6.angles = (270, 0, 0);
  var_6 clonebrushmodeltoscriptmodel(var_1);
  var_7 = spawn("script_model", (-287.75, 288.5, 177.5));
  var_7.angles = (270, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_1);
  var_8 = spawn("script_model", (325, 838, 0));
  var_8.angles = (0, 346.838, 0);
  var_8 clonebrushmodeltoscriptmodel(var_2);
  var_9 = spawn("script_model", (317.5, 827.5, 0));
  var_9.angles = (0, 337.959, 0);
  var_9 clonebrushmodeltoscriptmodel(var_2);
  var_10 = spawn("script_model", (574.25, 773.75, 0));
  var_10.angles = (0, 0, 0);
  var_10 clonebrushmodeltoscriptmodel(var_2);
  var_11 = spawn("script_model", (515.75, 773.75, 0));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_2);
  var_12 = spawn("script_model", (507.5, 749.25, 0));
  var_12.angles = (0, 0, 0);
  var_12 clonebrushmodeltoscriptmodel(var_2);
  var_13 = spawn("script_model", (571.5, 749.25, 0));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_2);
  register_create_script_arrays("mp_m_overunder_create_script", "mp_overunder_guncourse", &scripts\mp\maps\mp_m_overunder\mp_m_overunder_create_script::main);
}

function ref_11DD6() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (1191, -1372, 62), (0, 154, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);

  switch (level.trial["variant"]) {
    case "knife":
      var_1 = "iw8_knife";
      break;
    case "shield":
      var_1 = "iw8_me_riotshield";
      break;
    case "pistol":
      var_1 = "iw8_pi_decho";
      break;
    case "free":
      var_1 = "iw8_knife";
      break;
    default:
      var_1 = "iw8_pi_golf21";
      break;
  }

  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", var_1);
  level.ref_13D93 = 1;
  var_2 = getEnt("care_package_col", "targetname");
  var_3 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (210, -923, 18)));
}

function ref_11DE0() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (960, 0, 152), (0, 180, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((803.97, 4.83, 205.7), (283.41, 238.67, 35.51), "trial_variant_shotgun", undefined, "iw8_sh_dpapa12+fmj+guardlight+barshort");
  init_nuke_vault((804.42, 15.72, 203.25), (282.84, 232.89, 37.28), "trial_variant_shotgun", undefined, "iw8_sh_romeo870+fastreload+xmags+stockh+barshort");
  init_nuke_vault((805.06, -11.8, 200.98), (283.73, 126.36, -38.79), "trial_variant_shotgun", undefined, "iw8_sh_oscar12+fmj");
  init_nuke_vault((805.17, -24.5, 195.47), (285.92, 237.26, 31.72), "trial_variant_shotgun", undefined, "iw8_sh_mike26+reflexmini+stockno+fastreload+gripvert+barmid");
  init_nuke_vault((804.51, -29.71, 205.95), (38.47, 268.74, -0.9), "trial_variant_shotgun", undefined, "iw8_pi_cpapa+barshort+pistolgrip02+fastreload+trigcust+calcust2");
  init_nuke_vault((801.56, -15.55, 221.23), (350.4, 89.83, -4.89), "trial_variant_shotgun", undefined, "iw8_sh_charlie725+guardheavy+fastreload+stockno+barshort");
  var_1 = getEnt("clip64x64x8", "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (812.5, -6.5, 209.25)));
}

function ref_11DDC() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-1096, 0, 16), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((-982, 85.5, 72.5), (33.6, 127, 0), "trial_variant_fast", undefined, "iw8_pi_mike9+fastreload+reflexmini+trigcust02+pistolgrip02+barshort");
  init_nuke_vault((-991.6, 98.5, 73.2), (33.6, 127, 0), "trial_variant_fast", undefined, "iw8_pi_golf21+trigcust02+laserbalanced+pistolgrip02+xmags+barshort");
  init_nuke_vault((-1001, 110, 72.5), (33.6, 127, 0), "trial_variant_fast", undefined, "iw8_pi_papa320+pistolgrip02+barmid+silencer+reflexmini2");
  init_nuke_vault((-993.7, 99.6, 65), (0, 127, 7), "trial_variant_fast", undefined, "iw8_sm_smgolf45+reflexmini3+barshort+stocks+pistolgrip02+smags");
  init_nuke_vault((-990, 91.5, 52), (0, 127, 7), "trial_variant_fast", undefined, "iw8_ar_akilo47+acog2+pistolgrip03+stockl+calsmg+barshortnoguard");

  if(_tablethide::ref_13D4C()) {
    thread ref_13D6D();
  }

  register_create_script_arrays("mp_m_king_create_script", "mp_m_king_trial_guncourse", &_maxoutequipmentammo::main);
}

function ref_11DD7() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (3915.5, -2334, 236.5), (0, 104, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  var_1 = getEnt("clip64x64x8", "targetname");
  var_2 = spawn("script_model", (3844.75, -2172.25, 278.75));
  var_2.angles = (270.6, 350, -62);
  var_2.targetname = "trial_truck_door_coll_l";
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = spawn("script_model", (3893.25, -2158.25, 278.25));
  var_3.angles = (270.6, 350, -62);
  var_3.targetname = "trial_truck_door_coll_r";
  var_3 clonebrushmodeltoscriptmodel(var_1);
  var_4 = getEnt("care_package_col", "targetname");
  var_5 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (2841, -1100, 303)));
}

function ref_11DC5() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-125, 819.5, 104.5), (0, 351, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  var_1 = getEnt("clip64x64x8", "targetname");
  var_2 = spawn("script_model", (46.6, 772.4, 143.6));
  var_2.angles = (270.6, 350, -178);
  var_2.targetname = "trial_truck_door_coll_l";
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = spawn("script_model", (53.6, 822.4, 143.6));
  var_3.angles = (270.6, 350, -178);
  var_3.targetname = "trial_truck_door_coll_r";
  var_3 clonebrushmodeltoscriptmodel(var_1);
  var_1 = getEnt("clip64x64x8", "targetname");
  var_4 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (-167.25, 805.7, 195.9)));
}

function ref_11DEF() {
  level.trial_infinite_reserve_ammo = 1;
  glassradiusdamage((3229, 2578, 131), 128, 99999, 9999);
  glassradiusdamage((3069, 2023, 131), 128, 99999, 9999);
  glassradiusdamage((2699, 1683, 131), 128, 99999, 9999);
  thread ref_13A69();
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (3793, 1413, 68), (0, 240, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((3843.58, 1054.18, 124.7), (0, 205, 0), "trial_variant_default", "trial_starting_weapon", "iw8_pi_mike1911+barmid+pistolgrip01+trigcust+xmagslrg");
  init_nuke_vault((3867.43, 1063.33, 146.36), (0, 24, 0), "trial_variant_default", undefined, "iw8_ar_mcharlie+silencer2+calcust+holo3+stocks+barshort");
  init_nuke_vault((3869.86, 1065.88, 129.89), (0, 24, 0), "trial_variant_default", undefined, "iw8_sm_mpapa5+reflexmini+pistolgrip02+stockno+barshort+calcust");
  init_nuke_vault((3867.48, 1065.71, 113.6), (0, 24, 0), "trial_variant_default", undefined, "iw8_sh_dpapa12+pistolgrip03+guardcust+brake+barshort+xmags");
  init_nuke_vault((3789.69, 1044.18, 130.55), (0, 0, 0), "trial_variant_default", undefined, "iw8_ar_tango21+pistolgrip02+fmj+stockl+reflex2+barmid");
  init_nuke_vault((3786.95, 1044.11, 147.39), (0, 0, 0), "trial_variant_default", undefined, "iw8_ar_akilo47+gripangpro+pistolgrip02+stockcust+barcust");
  init_nuke_vault((3789.21, 1047.14, 112.9), (0, 0, 0), "trial_variant_default", undefined, "iw8_lm_mgolf36+laserrange+pistolgrip02+reflex5+barmid+calcust");
  init_nuke_vault((3843.58, 1054.18, 124.7), (0, 205, 0), "trial_variant_smoke", "trial_starting_weapon", "iw8_pi_mike1911+barmid+pistolgrip01+trigcust+xmagslrg+laserrange");
  init_nuke_vault((3867.43, 1063.33, 146.36), (0, 24, 0), "trial_variant_smoke", undefined, "iw8_ar_mcharlie+silencer2+calcust+holo3+stocks+barshort+laserrange");
  init_nuke_vault((3869.86, 1065.88, 129.89), (0, 24, 0), "trial_variant_smoke", undefined, "iw8_sm_mpapa5+reflexmini+pistolgrip02+stockno+barshort+calcust+laserrange");
  init_nuke_vault((3867.48, 1065.71, 113.6), (0, 24, 0), "trial_variant_smoke", undefined, "iw8_sh_dpapa12+pistolgrip03+guardcust+barshort+xmags+laserrange");
  init_nuke_vault((3789.69, 1044.18, 130.55), (0, 0, 0), "trial_variant_smoke", undefined, "iw8_ar_tango21+pistolgrip02+stockl+reflex2+barmid+laserrange");
  init_nuke_vault((3786.95, 1044.11, 147.39), (0, 0, 0), "trial_variant_smoke", undefined, "iw8_ar_akilo47+gripangpro+pistolgrip02+stockcust+barcust+laserrange");
  init_nuke_vault((3789.21, 1047.14, 112.9), (0, 0, 0), "trial_variant_smoke", undefined, "iw8_lm_mgolf36+laserrange+pistolgrip02+reflex5+barmid+calcust");
  register_create_script_arrays("mp_vacant_create_script", "mp_vacant_trial", &scripts\mp\maps\mp_vacant\mp_vacant_create_script::main);
  thread target_random_models();
  thread player_isusingtacmap("course_started");
  thread ref_11DF0();
}

function ref_11DF0() {
  for(;;) {
    level waittill("course_started");
    var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_construction_doors_metal_b_02_mp", "classname");
    var_1 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_metal_single_b_02_grey", "classname");
    var_2 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_wooden_office_01_mp", "classname");
    var_3 = scripts\engine\utility::array_combine(var_0, var_1, var_2);

    foreach(var_5 in var_3) {
      var_5 vehicle_getinputvalue();
    }
  }
}

function ref_11DD9() {
  level.trial_infinite_reserve_ammo = 1;
  glassradiusdamage((112, -1366, 67), 128, 99999, 9999);
  glassradiusdamage((112, -1366, 185.5), 128, 99999, 9999);
  glassradiusdamage((191, -1560, 185.5), 128, 99999, 9999);
  glassradiusdamage((-1088, -951, 67), 128, 99999, 9999);
  thread ref_13A69();
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-98.5, 1639.25, 13), (0, 10, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((101.75, 1765, 84.5), (338.5, 130.25, 5.2), "trial_variant_fast", "trial_starting_weapon", "iw8_pi_mike1911+barmid+pistolgrip01+trigcust+xmagslrg");
  init_nuke_vault((112, 1753.25, 83.7), (347.6, 131, 5), "trial_variant_fast", undefined, "iw8_pi_mike9+fastreload");
  init_nuke_vault((120.5, 1741.75, 84), (347.6, 131, 5), "trial_variant_fast", undefined, "iw8_pi_golf21+reflexmini2+pistolgrip02+trigcust02+laserrange+barshort");
  init_nuke_vault((107.25, 1757.25, 64), (286.8, 99.23, 28), "trial_variant_fast", undefined, "iw8_sm_mpapa5+barsil2+stockl+fastreload+pistolgrip02+xmags");
  init_nuke_vault((115.75, 1746, 66.25), (286.8, 99.25, 28), "trial_variant_fast", undefined, "iw8_sm_uzulu+fastreload+stocks+pistolgrip02+barcust+xmagslrg");
  init_nuke_vault((125.5, 1733.25, 66), (286.8, 99.25, 28), "trial_variant_fast", undefined, "iw8_sm_mpapa7+stockl+barshort+fastreload+pistolgrip02+xmags");
  init_nuke_vault((62.25, 1797.5, 87), (0, 143, 0), "trial_variant_heavy", "trial_starting_weapon", "iw8_ar_mike4+fastreload+stocks+pistolgrip02+reflexmini+barsil");
  init_nuke_vault((53, 1801.5, 60), (288, 125.15, 17.4), "trial_variant_heavy", undefined, "iw8_sn_mike14+pistolgrip03+fastreload+xmags+barshort+reflexmini");
  init_nuke_vault((64.25, 1792.5, 58.5), (287.35, 123.75, 18.74), "trial_variant_heavy", undefined, "iw8_ar_falima+fastreload+stocks+pistolgrip02+barshort+reflexmini");
  init_nuke_vault((75, 1784.25, 61.5), (289.6, 126, 16.6), "trial_variant_heavy", undefined, "iw8_sn_sksierra+laserbalanced+fastreload+pistolgrip06+barshort+reflex3");
  var_1 = getEnt("clip128x128x128", "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (1145.25, 291, 0.75)));
}

function ref_11DD5() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (53844, -18822, 4690), (75, 355, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
}

function ref_11DE5() {
  if(level.trial["missionScript"] == "race") {
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (36805, -14366, -152), (0, 300, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    level.ref_13D5B = 1;
    level.localeid = "locale_3";
    register_create_script_arrays("mp_trial_helicopter_port_create_a_script", "mp_trial_helicopter_race", &_playerwaittillcinematiccompleteinternal::main);
    return;
  }

  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (53844, -18822, 4690), (75, 355, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
}

function ref_11DCF() {
  if(level.trial["missionScript"] == "race") {
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (22448, -17782, 560), (0, 315.999, 0));
    thread mindia_exterior_sfx();
    level.ref_13D5B = 1;
    level.localeid = "locale_8";
  } else {
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_ar_mike4+reflex_west02+fmj+pistolgrip02+stockl+barlong");
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon_2", "iw8_la_rpapa7");
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (28101, -11340, 7000), (75, 200, 0));
  }

  scripts\mp\spawnlogic::bdiedonce([var_0]);
  register_create_script_arrays("mp_downtown_gw_create_script", "mp_downtown_gw_trial", &scripts\mp\maps\mp_downtown_gw\mp_downtown_gw_create_script::main);
}

function ref_11DCA() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-2482.78, -1290.79, -28.0287), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  init_nuke_vault((-2262.25, -1500.75, 33), (0, 0, 0), undefined, undefined, "iw8_ar_mike4+minireddot+gripvert+gl");
  init_nuke_vault((-2276.25, -1502.25, 50), (0, 0, 0), undefined, undefined, "iw8_la_rpapa7");
  init_nuke_vault((-2204, -1501, 36), (0, 0, 0), undefined, undefined, "iw8_la_mike32");
  init_nuke_vault((-2204.25, -1503, 51), (0, 0, 0), undefined, undefined, "iw8_ar_scharlie+reflex_east01+silencer_west01+gl+stocks_scharlie+laserrange");
  level.ref_12489 = "equip_c4";
  level.ref_1248B = "equip_thermite";
  level.ref_1248A = 1;
  level.ref_124C9 = 1;
  level.ref_13D59 = [];
  level.ref_13D59 = scripts\engine\utility::array_add(level.ref_13D59, "specialty_fastreload");
  level.ref_13D3F = 1;
  level.ref_13D41 = 1;
  thread scripts\mp\trials\mp_trl_cleararea::init_trap_room_debug();
  register_create_script_arrays("mp_cave_am_create_script", "mp_cave_am_create_script", &_maphint_cheese2scriptableused::main);
}

function ref_11DD8() {
  level.trial_infinite_reserve_ammo = 1;
  level.ref_13D87 = 1;
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (864, -752, 288), (0, 270, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  init_nuke_vault((1030, -1040, 382), (0, 60, 0), undefined, undefined, "iw8_ar_anovember94+barlong_anovember94+brake_anovember94+gripvert+ironsdefault_anovember94+mag_anovember94+pistolgrip01_anovember94+rec_anovember94+selectsemi_anov94+stockskel_anovember94");
  init_nuke_vault((1028, -1040, 362), (0, 60, 0), undefined, undefined, "iw8_pi_papa320+barlong_papa320+minireddot02_golf21+pistolgrip_pstl01_papa320+rec_papa320+silencerpstl_oil+xmagslrg_papa320");
  init_nuke_vault((1026, -1040, 344), (0, 60, 0), undefined, undefined, "iw8_sm_charlie9+barsil_charlie9+gripvertsmg+ironsdefault_charlie9+pistolgrip01_charlie9+rec_charlie9+selectsemi+stockh_charlie9+xmags_charlie9");
  init_nuke_vault((976, -1096, 364), (0, 30, 0), undefined, undefined, "iw8_lm_sierrax+adversefire_sierrax+baradlong_sierrax+ironsdefault_sierrax+laserbalanced_sierrax+rec_sierrax+silencerbalancedlmg+stocksaw_sierrax+stocksaw_sierrax_attributes+triggrip_sierrax+xmags_sierrax");
  thread target_random_models();
  thread player_isusingtacmap(undefined, undefined, 1);
  register_create_script_arrays("mp_hardhat_create_script", "mp_hardhat_trial", &scripts\mp\maps\mp_hardhat\mp_hardhat_create_script::main);
}

function pavelow_boss_health_bar(var_0) {
  for(;;) {
    while([[var_0]]()) {
      waitframe();
    }

    self notify("trigger");
    waitframe();
  }
}

function ref_11DEA() {
  if(!isDefined(level.player)) {
    return true;
  }

  var_0 = level.player.origin[0] < -720;
  var_1 = level.player.origin[1] > -60;
  var_2 = level.player.origin[1] < 330;

  if(!isDefined(level.ref_124B8)) {
    if(var_0 && var_1 && var_2) {
      level.ref_124B8 = 1;
    }
  }

  if(istrue(level.ref_124B8)) {
    if(!var_0 || !var_1 || !var_2) {
      level.ref_124B8 = 0;
      return false;
    }
  }

  return true;
}

function ref_11DCB() {
  setdynamicdvar("scr_game_enableMinimap", 0);
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (45, -617, 330), (0, 81, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  register_create_script_arrays("mp_trl_gunslinger_crash_create_script", "mp_crash2", &_runmovequestlocale::main);
  var_1 = getEnt("clip128x128x8", "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (-56, -587, 333)));
}

function ref_11DED(var_0, var_1) {
  if(var_1 == "gunslinger" || var_1 == "pitcher") {
    var_2 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (1874, 1198.75, 8), (0, 182.4, 0));
    scripts\mp\spawnlogic::bdiedonce([var_2]);

    if(var_0 == "knife") {
      init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
      register_create_script_arrays("mp_trl_gunslinger_knife_create_script", "mp_trl_gunslinger_targets3_create_script", &_safecircledurationforplayer::main);
    }

    if(var_0 == "reflex" && _tablethide::ref_13D4C()) {
      register_create_script_arrays("mp_t_reflex_game_of_summer_createscript", "mp_t_reflex_game_of_summer_createscript", &scripts\mp\maps\mp_t_reflex\mp_t_reflex_game_of_summer_createscript::main);
      level.ref_142A6 = 275;
      level.ref_142A7 = 2.25;
      thread ref_13D6D();
    }
  }

  if(var_1 == "race") {
    var_2 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-2896, 1480, 16), (0, 35, 0));
    scripts\mp\spawnlogic::bdiedonce([var_2]);
    register_create_script_arrays("mp_t_reflex_create_script_quadrace", "mp_t_reflex_trial_race_createscript", &_phonemorsesinglescriptableused::main);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    thread setupsoccerball();
    var_3 = getEntArray("remove_for_race", "targetname");

    foreach(var_5 in var_3) {
      var_5 delete();
    }

    thread ref_11DEC();
    return;
  }
}

function setupsoccerball() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEnt("open_hangardoors", "targetname");
  var_1 = getentitylessscriptablearrayinradius("big_door_l", "targetname");
  var_2 = getentitylessscriptablearrayinradius("big_door_r", "targetname");
  var_3 = getEnt("doorcoll_left", "targetname");
  var_4 = getEnt("doorcoll_right", "targetname");
  var_0 waittill("trigger");
  var_1[0] setscriptablepartstate("base", "move_l_quadrace");
  var_2[0] setscriptablepartstate("base", "move_r_quadrace");
  waitframe();

  while(var_3.origin != var_1[0].origin && var_4.origin != var_2[0].origin) {
    var_3.origin = (var_1[0].origin[0], var_1[0].origin[1], var_1[0].origin[2]);
    var_4.origin = (var_2[0].origin[0], var_2[0].origin[1], var_2[0].origin[2]);
    waitframe();
  }
}

function ref_11DEC() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEntArray("container_model", "targetname");
  var_1 = getEnt("container_collision", "targetname");

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 clonebrushmodeltoscriptmodel(var_1);
  }
}

function ref_11DDA() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-21478, 25049, -338), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.ref_13D5B = 1;
  register_create_script_arrays("mp_trl_quarry_raceislava_trial_create_a_script", "mp_quarry_trials_race", &_setclientkillstreakindexes::main);
}

function ref_11DE1() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-1108, -88, -84), (0, 28, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((-906.97, 138.623, -5.5239), (0, 271, 0), undefined, "trial_starting_weapon", "iw8_pi_cpapa+barlong_cpapa+stockcust_cpapa+trigcust03_cpapa");
  init_nuke_vault((-923.97, 202.123, -54.7739), (345, 180, 0.000108306), undefined, undefined, "iw8_me_riotshield");
  init_nuke_vault((-909.97, 132.123, -27.7739), (286.245, 316.609, -46.8203), undefined, undefined, "iw8_sn_kilo98+barshort_kilo98+fastreload");
  init_nuke_vault((-905.72, 147.123, 2.9761), (359.382, 271.507, -13.7324), undefined, undefined, "iw8_sh_charlie725+barshort_charlie725");
  init_nuke_vault((-909.97, 148.123, -29.2739), (288.531, 318.307, -48.1768), undefined, undefined, "iw8_sn_sksierra+snprscope_sksierra+smags_sksierra+pistolgrip04_sksierra+barshort_sksierra");
  init_nuke_vault((-909.22, 166.623, -29.7739), (287.755, 321.101, -51.1163), undefined, undefined, "iw8_ar_akilo47+bayonet_akilo47+barsmg_akilo47+stocklmg_akilo47");
  init_nuke_vault((481.28, -380.877, -34.0239), (287.755, 321.101, -51.1163), undefined, undefined, "iw8_la_rpapa7");
  thread ref_11DE2();
  register_create_script_arrays("mp_m_trench_create_script_gunnonlinear", "mp_m_trench_create_script_gunnonlinear", &_onmatchstartbr::main);
  thread ref_13A69();
}

function ref_11DE2() {
  level endon("course_ended");
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player)) {
    waitframe();
  }

  level.player scripts\mp\equipment::giveequipment("equip_c4", "primary");
  scripts\mp\trials\mp_trl_cleararea::ref_12A8E();
}

function ref_11DD1() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-596, 1455, 654), (0, 194, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.ref_125CB = 1;
  level.ref_13D83 = 120;
  thread ref_124A1();
  register_create_script_arrays("mp_emporium_create_script_floorislava", "mp_emporium_create_script_floorislava", &_maphint_cheesescriptableused::main);
  thread ref_121EA();
  var_1 = getEnt("clip64x64x64", "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, 10, spawn("script_model", (-528.607, 1465.99, 608)));
}

function ref_121EA() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEnt("care_package_col", "targetname");
  var_1 = getEntArray("trial_crate_model", "targetname");

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

function ref_11DD0() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player)) {
    waitframe();
  }

  var_0 = getEntArray("hanging_crate", "targetname");
  var_1 = loadfx("vfx/iw8_mp/trials/speedball/vfx_trials_imp_clay.vfx");

  foreach(var_3 in var_0) {
    thread setupstartweaponsattachments(var_3);
  }

  thread get_dist_to_closest_player();
}

function get_dist_to_closest_player() {
  for(;;) {
    jumpiftrue(isDefined(level.cratedata.usablecrates)) LOC_00000014;
    waitframe();
  }

  while(isDefined(level.cratedata.usablecrates)) {
    foreach(var_1 in level.cratedata.usablecrates) {
      if(isDefined(var_1)) {
        var_1 scripts\cp_mp\killstreaks\airdrop::makecrateunusable();
      }

      if(isDefined(var_1.headicon)) {
        var_1 scripts\cp_mp\killstreaks\airdrop::_destroyheadicon();
      }

      if(isDefined(var_1.minimapid)) {
        var_1 scripts\cp_mp\killstreaks\airdrop::destroyminimapicon();
      }
    }

    waitframe();
  }
}

function setupstartweaponsattachments(var_0) {
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = scripts\engine\utility::get_target_ent();
  var_3 setCanDamage(1);
  var_3 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17);
  playFX(var_0, var_7);
  playsoundatpos(var_7, "trial_sfx_target_report_clay_smash");
  var_18 = scripts\cp_mp\killstreaks\airdrop::dropkillstreakcrate(undefined, level.player.team, undefined, var_1, var_2, undefined);
  var_18.nevertimeout = 1;
  self delete();
  var_3 delete();
}

function ref_124A1() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player)) {
    waitframe();
  }

  level.player scripts\mp\equipment::giveequipment("equip_rock", "primary");

  while(isalive(level.player)) {
    var_0 = level.player scripts\mp\equipment::getcurrentequipment("primary");
    var_1 = level.player scripts\mp\equipment::getequipmentammo(var_0);

    if(var_1 != 1) {
      level.player scripts\mp\equipment::setequipmentammo(var_0, 1);
    }

    wait 0.5;
  }
}

function ref_11DDB(var_0) {
  if(var_0 == "lava") {
    var_1 = getEntArray("alpha", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && var_3.script_gameobjectname == "trial") {
        var_3 delete();
      }
    }

    var_5 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-1158.9, -233.964, 48.5), (0, 44.097, 0));
    scripts\mp\spawnlogic::bdiedonce([var_5]);
    var_6 = getEnt("clip64x64x8", "targetname");
    var_7 = spawn("script_model", (-1008.48, -122.919, 89.482));
    var_7.angles = (90, 226, 0);
    var_7.targetname = "trial_truck_door_coll_l";
    var_7 clonebrushmodeltoscriptmodel(var_6);
    var_8 = spawn("script_model", (-1049.24, -84.752, 89.411));
    var_8.angles = (90, 226, 0);
    var_8.targetname = "trial_truck_door_coll_r";
    var_8 clonebrushmodeltoscriptmodel(var_6);
    var_9 = getEnt("care_package_col", "targetname");
    var_10 = [];
    GscBinSkip0(0x2e, 0, spawn("script_model", (-842, 367, -2)));
  }

  init_nuke_vault((-381.5, -1669, 41), (360, 327.999, -90.0002), undefined, "trial_starting_weapon", "iw8_knife");
  var_5 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-542, -1731, 60), (0, 33, 0));
  scripts\mp\spawnlogic::bdiedonce([var_5]);
}

function ref_11DE8(var_0) {
  if(level.trial["missionScript"] == "gunslinger") {
    var_1 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-79, 1355, -160), (0, 270, 0));
    scripts\mp\spawnlogic::bdiedonce([var_1]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    register_create_script_arrays("mp_trl_gunslinger_memory_create_script", "mp_trl_gunslinger_targets4_create_script", &_setclientkillstreakavailability::main);
    var_2 = getEnt("clip128x128x8", "targetname");
    var_3 = [];
    GscBinSkip0(0x2e, 0, spawn("script_model", (55, 1316, -178)));
  }

  if(level.trial["missionScript"] == "jugg") {
    var_1 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-66, 190, -237), (0, 45, 0));
    scripts\mp\spawnlogic::bdiedonce([var_1]);
    var_11 = spawn("script_origin", (102, 358, -237));
    var_11.angles = (0, 0, 0);
    var_11.targetname = "trial_juggernaut_crate";
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    return;
  }
}

function ref_11DC6() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-24702, -5429, -283), (1, 281, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.localeid = "locale_4";
  register_create_script_arrays("mp_trl_boneyard_gw_race", "mp_boneyard_gw_trial_race", &_proximitywatcher::main);
  var_1 = getEnt("clip128x128x8", "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (-27937, -4290, -249)));
}

function ref_13D27() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEnt("left_door", "targetname");
  var_1 = getEnt("right_door", "targetname");
  var_2 = getEnt("box_open", "targetname");
  var_3 = getEnt("door_col", "targetname");

  while(!isalive(level.player)) {
    waitframe();
  }

  wait 34;
  var_4 = scripts\mp\utility\outline::outlineenableforplayer(var_2, level.player, "outline_trial_item", "level_script");
  var_2 setHintString(&"MP/DOOR_USE_OPEN");
  var_2 setCursorHint("hint_button");
  var_2 sethintdisplayrange(200);
  var_2 sethintdisplayfov(65);
  var_2 setuserange(72);
  var_2 setusefov(120);
  var_2 sethintonobstruction("show");
  var_2 setuseholdduration("duration_short");
  var_2 makeusable();
  var_2 waittill("trigger");
  var_2 makeunusable();
  scripts\mp\utility\outline::outlinedisable(var_4, var_2);
  var_3 notsolid();
  var_0 rotateby((0, 260, 0), 2.5);
  var_1 rotateby((0, -260, 0), 2.5);
  var_0 playsoundonmovingent("trial_sfx_door_truck_left");
  var_1 playsoundonmovingent("trial_sfx_door_truck_right");
}

function ref_11DF1() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-1222, -2462, 386), (0, 53, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((-998, -2305, 412), (0, 0, -93), "trial_variant_explosion", "trial_starting_weapon", "iw8_knife");
  init_nuke_vault((-1015, -2284, 459), (0, 141, 0), "trial_variant_explosion", undefined, "iw8_la_mike32+fastreload");
  init_nuke_vault((-1025, -2280, 430), (297, 117, 125), "trial_variant_explosion", undefined, "iw8_sn_crossbow+fastreload+cableh+barmid+reflexmini");
  init_nuke_vault((-998, -2302, 431), (290, 1.6, -163), "trial_variant_explosion", undefined, "iw8_la_rpapa7");
  init_nuke_vault((-1011, -2289, 432), (288.4, 116, 23), "trial_variant_explosion", undefined, "iw8_sh_romeo870+melee+holo3+stocks+gripvertpro+barshort");
  level.ref_12489 = "equip_c4";
  level.ref_1248A = 1;
  level.ref_124C9 = 1;
  level.ref_13D3F = 1;
  level.ref_13D41 = 1;
  thread scripts\mp\trials\mp_trl_cleararea::init_trap_room_debug();
  register_create_script_arrays("mp_village2_clearthearea_create_script", "mp_village2_trial_clearthearea", &scripts\mp\maps\mp_village2\mp_village2_clearthearea_create_script::main);
}

function ref_11DE3() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (1188, -1459, 872), (0, 209, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.ref_13D2F = 1;
  register_create_script_arrays("mp_oilrig_create_script", "mp_oilrig_create_script", &_ontabletgiven::main);
}

function ref_11DEE() {
  if(_tablethide::ref_13D4C()) {
    thread ref_13D6D();
  }

  if(level.trial["variant"] == "trialympic") {
    var_0 = getEnt("clip8x8x256", "targetname");
    var_1 = [];
    GscBinSkip0(0x2e, 0, spawn("script_model", (1792, 852, 8)));
  }
}

function ref_11DD2() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-2470.23, 4496.36, 707.14), (359.983, 231.857, 0.0086689));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  level.ref_13D5B = 1;
  register_create_script_arrays("mp_escape2_create_script", "mp_escape2_create_script", &scripts\mp\maps\mp_escape2\mp_escape2_create_script::main);
}

function register_create_script_arrays(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;
  }

  if(isDefined(var_1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;
  }

  level.create_script_file_ids[var_0] = "cs" + level.scripted_spawner_func.size;

  if(isDefined(var_2)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_2;
    return;
  }
}

function init_nuke_vault(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    var_5.angles = var_1;
  }

  if(isDefined(var_2)) {
    var_5.script_gameobjectname = var_2;
  } else {
    var_5.script_gameobjectname = "trial";
  }

  if(isDefined(var_3)) {
    var_5.script_noteworthy = var_3;
  }

  var_5.targetname = "trial_weapon";
  var_5.script_parameters = var_4;
  return var_5;
}

function ref_13A69() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = scripts\engine\utility::getStructArray("hint_struct", "targetname");

  foreach(var_2 in level.course_targets) {
    var_3 = scripts\engine\utility::getclosest(var_2.origin, var_0, 32);

    if(isDefined(var_3)) {
      var_4 = strtok(var_3.script_noteworthy, "+");

      foreach(var_6 in var_4) {
        var_7 = strtok(var_6, "=");

        switch (var_7[0]) {
          case "targetname":
            var_2.targetname = var_7[1];
            break;
          case "script_speed":
            var_2.script_speed = float(var_7[1]);
            break;
          default:
            break;
        }
      }
    }
  }
}

function target_random_models() {
  while(!isDefined(level.targets_thinking) || istrue(level.targets_thinking)) {
    waitframe();
  }

  var_0 = ["ee_military_shooting_range_plate_enemy_01", "ee_military_shooting_range_plate_enemy_02", "ee_military_shooting_range_plate_enemy_03", "ee_military_shooting_range_plate_enemy_04", "ee_military_shooting_range_plate_enemy_05", "ee_military_shooting_range_plate_enemy_06"];
  var_1 = ["ee_military_shooting_range_plate_civilian_01", "ee_military_shooting_range_plate_civilian_02", "ee_military_shooting_range_plate_civilian_03"];
  var_2 = ["ee_military_shooting_range_plate_bullet", "ee_military_shooting_range_plate_bullet_01", "ee_military_shooting_range_plate_bullet_02", "ee_military_shooting_range_plate_bullet_03"];

  if(istrue(level.ref_13D87)) {
    var_0 = [];
    var_1 = [];
    var_0 = ["ee_military_shooting_range_plate_enemy_01_ds", "ee_military_shooting_range_plate_enemy_02_ds", "ee_military_shooting_range_plate_enemy_03_ds", "ee_military_shooting_range_plate_enemy_04_ds", "ee_military_shooting_range_plate_enemy_05_ds", "ee_military_shooting_range_plate_enemy_06_ds"];
    var_1 = ["ee_military_shooting_range_plate_civilian_01_ds", "ee_military_shooting_range_plate_civilian_02_ds", "ee_military_shooting_range_plate_civilian_03_ds"];
  }

  var_3 = scripts\engine\utility::array_randomize(level.enemy_targets);
  var_4 = scripts\engine\utility::array_randomize(level.civilian_targets);

  foreach(var_6 in var_3) {
    var_6.bullet_decal = spawn("script_model", var_6.plate.origin);
    var_6.bullet_decal.angles = var_6.plate.angles;
    var_6.bullet_decal linkTo(var_6.plate);

    if(isDefined(var_6.script_parameters)) {
      var_6.plate setModel(var_6.script_parameters);
    }
  }

  foreach(var_6 in var_3) {
    var_9 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(var_3, var_6));
    var_10 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9));
    var_11 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9), var_10));
    var_12 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_2, var_9.bullet_decal.model), var_10.bullet_decal.model), var_11.bullet_decal.model);

    if(!isDefined(var_6.script_parameters)) {
      var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_0, var_9.plate.model), var_10.plate.model), var_11.plate.model);
      var_6.plate setModel(scripts\engine\utility::random(var_13));
    }

    var_6.bullet_decal setModel(scripts\engine\utility::random(var_12));
  }

  foreach(var_16 in var_4) {
    var_9 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(var_4, var_16));
    var_10 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_4, var_16), var_9));

    if(isDefined(var_16.script_parameters)) {
      var_16.plate setModel(var_16.script_parameters);
      continue;
    }

    var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_1, var_9.plate.model), var_10.plate.model);
    var_16.plate setModel(scripts\engine\utility::random(var_13));
  }
}

function mindia_exterior_sfx() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEnt("start_flares_trig", "targetname");
  var_1 = getEntArray("start_flare", "targetname");
  var_0 waittill("trigger");

  for(var_2 = 0;; var_2++) {
    foreach(var_4 in var_1) {
      if(isDefined(var_4.script_noteworthy)) {
        if(int(var_4.script_noteworthy) == var_2) {
          var_4 playSound("iw8_tactical_insert_flare_pu");
          playFXOnTag(level.ref_14297, var_4, "j_top");
        }
      }
    }

    wait 0.5;
  }
}

function player_isusingtacmap(var_0, var_1, var_2) {
  level._effect["trial_smoke"] = loadfx("vfx/core/mp/core/vfx_flare_glow_en.vfx");
  level._effect["trial_flare"] = loadfx("vfx/iw7/levels/europa/vfx_eu_icecave_flare_01.vfx");

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_3 = scripts\engine\utility::getStructArray("flare_struct", "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawn("script_model", var_5.origin);
    var_6.angles = var_5.angles;
    var_6 setModel("equipment_flare_wm");
    var_5.player_is_at_buy_station = spawn("script_model", var_5.origin);
    var_5.player_is_at_buy_station.angles = var_5.angles;
    var_5.player_is_at_buy_station setModel("tag_origin");
    var_5.player_is_at_buy_station linkTo(var_6, "tag_fire_fx", (0, 0, -1.75), (0, 180, 0));

    if(istrue(var_1)) {
      var_5.ref_1341F = spawn("script_model", var_5.origin);
      var_5.ref_1341F.angles = var_5.angles;
      var_5.ref_1341F setModel("tag_origin");
      var_5.ref_1341F linkTo(var_6, "tag_fire_fx", (1, 0, 0), (90, 0, 0));
    }
  }

  for(;;) {
    if(istrue(var_2)) {
      _tablethide::waittill_player_isDefined();

      while(level.player getvelocity() == 0) {
        waitframe();
      }
    } else {
      level waittill(var_0);
    }

    foreach(var_5 in var_3) {
      playFXOnTag(level._effect["trial_flare"], var_5.player_is_at_buy_station, "tag_origin");

      if(istrue(var_1)) {
        playFXOnTag(level._effect["trial_smoke"], var_5.ref_1341F, "tag_origin");
      }
    }

    if(istrue(var_2)) {
      level waittill("forever");
    }

    _tablethide::trial_ui_waittill_retry();

    foreach(var_5 in var_3) {
      stopFXOnTag(level._effect["trial_flare"], var_5.player_is_at_buy_station, "tag_origin");

      if(istrue(var_1)) {
        stopFXOnTag(level._effect["trial_smoke"], var_5.ref_1341F, "tag_origin");
      }
    }
  }
}

function ref_13D6D() {
  level._effect["trial_cup_flames"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_olympic_flame.vfx");
  level._effect["trial_small_cup_flames"] = loadfx("vfx/iw8/level/estate/vfx_estate_oil_fire.vfx");
  level._effect["trial_thermite_bronze"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_celeb_flame_bronze.vfx");
  level._effect["trial_thermite_silver"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_celeb_flame_silver.vfx");
  level._effect["trial_thermite_gold"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_celeb_flame_gold.vfx");
  level._effect["trial_celebration_flare"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_angelflares.vfx");
  level._effect["big_red_vfx"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail.vfx");
  level.ref_13D6C = 1;

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  thread get_wave_spawn_count();
  level.ref_13D9B = getEntArray("trial_flames", "targetname");

  if(isDefined(level.ref_13D9B)) {
    wait 5;

    foreach(var_1 in level.ref_13D9B) {
      if(istrue(level.ref_13D68)) {
        playFXOnTag(scripts\engine\utility::getfx("trial_small_cup_flames"), var_1, "j_top");
      } else {
        playFXOnTag(scripts\engine\utility::getfx("trial_cup_flames"), var_1, "j_top");
      }

      var_1 setModel("tag_origin");
    }

    return;
  }
}

function get_wave_spawn_count() {
  level.ref_13D2A = getEntArray("trial_celebration_flares", "targetname");
  level.ref_13D3C = getEntArray("trial_end_flares", "targetname");

  if(isDefined(level.ref_142A6)) {
    level.ref_14298 = level.ref_142A6;
  } else {
    level.ref_14298 = 750;
  }

  if(isDefined(level.ref_142A7)) {
    level.ref_142AB = level.ref_142A7;
    goto LOC_00000067;
  }

  level.ref_142AB = 1.75;

  for(;;) {
    level.ref_13D7F = undefined;
    level waittill("course_ended");

    if(istrue(level.ref_13D2E)) {
      level.ref_13D7F = getomnvar("ui_trial_reward_tier");

      if(level.ref_13D7F == 0) {
        level.player playsoundtoplayer("gos_crowd_boo_loser", level.player);
        level.ref_13D7F = 0;
        continue;
      }
    } else {
      while(!isDefined(level.score["total"])) {
        waitframe();
      }

      if(level.trial["scoreType"] == "time") {
        if(level.score["total"] <= level.trial["tier3"]) {
          level.ref_13D7F = 3;
        } else if(level.score["total"] <= level.trial["tier2"]) {
          level.ref_13D7F = 2;
        } else if(level.score["total"] <= level.trial["tier1"]) {
          level.ref_13D7F = 1;
        } else {
          level.player playsoundtoplayer("gos_crowd_boo_loser", level.player);
          level.ref_13D7F = 0;
          continue;
        }
      } else if(level.score["total"] >= level.trial["tier3"]) {
        level.ref_13D7F = 3;
      } else if(level.score["total"] >= level.trial["tier2"]) {
        level.ref_13D7F = 2;
      } else if(level.score["total"] >= level.trial["tier1"]) {
        level.ref_13D7F = 1;
      } else {
        level.player playsoundtoplayer("gos_crowd_boo_loser", level.player);
        level.ref_13D7F = 0;
        continue;
      }
    }

    foreach(var_1 in level.ref_13D2A) {
      if(isDefined(var_1.script_noteworthy) && float(var_1.script_noteworthy) <= level.ref_13D7F) {
        thread ref_13D58(var_1);
      }
    }

    if(level.ref_13D7F == 3) {
      wait 3;
      level.player playsoundtoplayer("gos_cheer_front", level.player);

      foreach(var_4 in level.ref_13D3C) {
        thread movequestcircle();
      }
    }

    wait 4;

    foreach(var_1 in level.ref_13D2A) {
      if(istrue(var_1.player_is_exposed)) {
        var_1 stoploopsound();
      }
    }
  }
}

function movequestcircle() {
  if(isDefined(self.script_noteworthy)) {
    wait float(self.script_noteworthy) * 0.5;
  }

  if(isDefined(self.target)) {
    if(self.target == "big_red_vfx") {
      var_0 = spawn("script_model", self gettagorigin("j_top") + (0, 0, 25));
      var_0 setModel("tag_origin");
      var_0.angles = self.angles;
      waitframe();
      playFXOnTag(scripts\engine\utility::getfx("big_red_vfx"), var_0, "tag_origin");
      var_0 moveTo(var_0.origin + (0, 0, level.ref_14298), level.ref_142AB);
      var_0 playsoundonmovingent("gos_firework_scream_sfx");
      self playSound("gos_firework_explo_sfx");
      wait 4;
      stopFXOnTag(scripts\engine\utility::getfx("big_red_vfx"), var_0, "tag_origin");
      return;
    }

    return;
  }

  playFXOnTag(scripts\engine\utility::getfx("trial_celebration_flare"), self, "j_top");
  self playSound("ks_apache_flares");
}

function ref_13D58(var_0) {
  if(isDefined(var_0)) {
    wait float(var_0);
  }

  if(isDefined(self.target)) {
    wait float(self.target);
  }

  playFXOnTag(scripts\engine\utility::getfx(proptiebreaker()), self, "j_top");
  self playSound("gos_firework_explo_sfx");
  self.player_is_exposed = 1;

  if(isDefined(var_0) && var_0 == "0" && level.ref_13D7F >= 3) {
    wait 2;
    playFXOnTag(scripts\engine\utility::getfx(proptiebreaker()), self, "j_top");
    return;
  }
}

function proptiebreaker() {
  switch (level.ref_13D7F) {
    case 1:
      var_0 = "trial_thermite_bronze";
      break;
    case 2:
      var_0 = "trial_thermite_silver";
      break;
    case 3:
      var_0 = "trial_thermite_gold";
      break;
    default:
      var_0 = "trial_thermite_bronze";
      break;
  }

  return var_0;
}