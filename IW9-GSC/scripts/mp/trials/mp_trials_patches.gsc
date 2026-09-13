/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trials_patches.gsc
***************************************************/

init_trial_patches() {
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
  mapname = level.trial["zone"];
  _id_391E7BBA92E85F93 = level.trial["missionID"];
  _id_40853847B9CDA9FD = level.trial["missionScript"];
  _id_8E003FDA6A2C258F = level.trial["variant"];

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
      level.vfx_smoke = loadfx("vfx/core/mp/core/vfx_flare_glow_en.vfx");
      level.vfx_flare = loadfx("vfx/iw7/levels/europa/vfx_eu_icecave_flare_01.vfx");
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
      mp_m_speed_patch();
      break;
    case "mp_m_speed_sh":
      _id_2D553533AB5BC4F3();
      break;
    case "mp_deadzone":
      mp_deadzone_patch();
      break;
    case "mp_petrograd":
      scripts\mp\trials\mp_trials_patches_petrograd::init_petrograd_bsp_patch();
      break;
    case "mp_spear":
    case "mp_spear_pm":
      patch_weapons_on_rack_cleararea(mapname, _id_391E7BBA92E85F93);
      thread move_and_delete_objects_cleararea(mapname, _id_391E7BBA92E85F93);
      break;
    case "mp_m_speedball":
      mp_m_speedball_patch();
      break;
    case "mp_runner_pm":
    case "mp_runner":
      mp_runner_patch(_id_40853847B9CDA9FD, _id_391E7BBA92E85F93, _id_8E003FDA6A2C258F);
      break;
    case "mp_raid":
      mp_raid_patch();
      break;
    case "mp_euphrates":
      mp_euphrates_patches();
      break;
    case "mp_aniyah":
      mp_aniyah_patch();
      break;
    case "mp_piccadilly":
      mp_piccadilly_patch(_id_8E003FDA6A2C258F);
      break;
    case "mp_m_overunder":
      mp_m_overunder_patch();
      break;
    case "mp_shipment":
      mp_shipment_patch();
      break;
    case "mp_vacant":
      mp_vacant_patch();
      break;
    case "mp_crash2":
      mp_crash2();
      break;
    case "mp_farms2_gw":
      mp_farms2_gw_patch();
    case "mp_hackney_am":
    case "mp_hackney_yard":
      mp_hackney_yard_patch();
      break;
    case "mp_cave_am":
      mp_cave_am_patch();
      break;
    case "mp_m_stack":
      mp_m_stack_patch();
      break;
    case "mp_port2_gw":
      mp_port2_gw_patch();
      break;
    case "mp_downtown_gw":
      mp_downtown_gw_patch();
      break;
    case "mp_boneyard_gw":
      mp_boneyard_gw_patch();
      break;
    case "mp_backlot2":
      mp_backlot2_patch();
      break;
    case "mp_t_reflex":
      mp_t_reflex_patch(_id_8E003FDA6A2C258F, _id_40853847B9CDA9FD);
      break;
    case "mp_rust":
      mp_rust_patch(_id_8E003FDA6A2C258F);
      break;
    case "mp_hideout":
      mp_hideout_patch();
      break;
    case "mp_layover_gw":
      mp_layover_patch();
      break;
    case "mp_village2":
      mp_village2_patches();
      break;
    case "mp_m_trench":
      mp_m_trench_patch();
      break;
    case "mp_hardhat":
      mp_hardhat_patch();
      break;
    case "mp_emporium":
      mp_emporium_patch();
      break;
    case "mp_harbor":
      mp_harbor_patch();
      break;
    case "mp_m_king":
      mp_m_king_patch();
      break;
    case "mp_m_cornfield":
      mp_m_cornfield_patch(_id_40853847B9CDA9FD);
      break;
    case "mp_oilrig":
      mp_oilrig_patches();
      break;
    case "mp_t_sn_reflex":
      _id_F4FE6A8D156A2CAD();
      break;
    default:
      break;
  }

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("strike_init_done");
}

patch_weapons_on_rack_cleararea(mapname, _id_391E7BBA92E85F93) {
  if(mapname == "mp_spear" || mapname == "mp_spear_pm") {
    if(isDefined(_id_391E7BBA92E85F93)) {
      _id_0D3409E5272F75DB = scripts\engine\utility::string(_id_391E7BBA92E85F93);
      _id_996F1A6F5AAD2F08 = undefined;

      if(mapname == "mp_spear_pm")
        _id_996F1A6F5AAD2F08 = "iw8_pi_golf21+laserrange_pstl+silencerbalanced";
      else
        _id_996F1A6F5AAD2F08 = "iw8_pi_golf21+silencerbalanced";

      switch (_id_0D3409E5272F75DB[2]) {
        case "1":
          _id_039E9DDC1C25AD20 = (692.695, -2043.02, 117.313);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_sm_mpapa5+pistolgrip01+barsil_mpapa5+hybrid_west03+gunperk_burst";
          weapons[0].script_noteworthy = "trial_starting_weapon_NOT";
          _id_039E9DDC1C25AD20 = (692.75, -2092.47, 115.505);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = _id_996F1A6F5AAD2F08;
          weapons[0].script_noteworthy = "trial_starting_weapon";
          weapons[0].origin = (692.75, -2096.8, 115.505);
          _id_039E9DDC1C25AD20 = (694.5, -2021.58, 134.055);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_sm_papa90+reflex_west01+silencersmg_west01+pistolgrip01_papa90+laserrange_smg_papa90_v2";
          _id_039E9DDC1C25AD20 = (693.772, -2100.09, 137.15);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_ar_akilo47+minireddot+barsmg_akilo47+stockno_akilo47+calsmg_akilo47+silencer_east01_akilo47";
          break;
        case "2":
          _id_039E9DDC1C25AD20 = (692.538, -2032.93, 115.817);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_ar_scharlie+silencer+gripvert+stockcust+laserrange+reflex_west01_irons";
          weapons[0].script_noteworthy = "trial_starting_weapon_NOT";
          _id_039E9DDC1C25AD20 = (695.223, -2033.98, 156.209);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_ar_mike4+reflex_west01+silencer04+gripvert";
          _id_039E9DDC1C25AD20 = (692.604, -2093.99, 118.358);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_ar_falpha+reflex_west01+silencer+gripvert+stocks";
          _id_039E9DDC1C25AD20 = (693.636, -2101.48, 137.097);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_ar_mcharlie+reflex_west02+silencer_west01+barlong_mcharlie+stockh_mcharlie+pistolgrip01_mcharlie+gripang";
          _id_039E9DDC1C25AD20 = (695.083, -2097.3, 153.988);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_ar_kilo433+holo_west01+barsil_kilo433+stockno_kilo433";
          _id_039E9DDC1C25AD20 = (693.113, -2043.55, 136.183);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);

          foreach(weapon in weapons) {
            if(weapon.script_parameters == "iw8_ar_akilo47+silencer_east01+pistolgrip01_akilo47") {
              weapon.script_parameters = _id_996F1A6F5AAD2F08;
              weapon.script_noteworthy = "trial_starting_weapon";
              weapon.origin = (693.113, -2048, 133.25);
            }
          }

          break;
        case "3":
          _id_039E9DDC1C25AD20 = (691.32, -2045.88, 120.804);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_lm_kilo121+bipod_kilo121+reflex_west02+silencerlmg_west01";
          weapons[0].script_noteworthy = "trial_starting_weapon_NOT";
          _id_039E9DDC1C25AD20 = (694, -2111.61, 150.817);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_lm_mgolf34+acog_east01_irons+silencer+xmags+pistolgrip01";
          _id_039E9DDC1C25AD20 = (693.377, -2106.26, 116.755);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);

          if(weapons.size != 0)
            weapons[0].script_parameters = "iw8_ar_asierra12+acog_east01+silencer2_asierra12+gripvertpro";

          _id_039E9DDC1C25AD20 = (692.996, -2042.65, 136.554);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);

          if(weapons.size != 0)
            weapons[0].script_parameters = "iw8_lm_pkilo+acog_east01+silencerlmg_west01+gripvertpro";

          _id_039E9DDC1C25AD20 = (684, -2118, 105);
          _id_DBDFBCB794B9185A = (2, 124, 90);
          weapon = spawn("script_origin", _id_039E9DDC1C25AD20);
          weapon.angles = _id_DBDFBCB794B9185A;
          weapon.targetname = "trial_weapon";
          weapon.script_noteworthy = "trial_starting_weapon";
          weapon.script_parameters = _id_996F1A6F5AAD2F08;
          break;
        case "4":
          _id_039E9DDC1C25AD20 = (691.56, -2034.7, 120.85);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_sn_mike14+hybrid_west01+silencerdmr_east01+strap_mike14+pistolgrip01_mike14";
          weapons[0].script_noteworthy = "trial_starting_weapon_NOT";
          _id_039E9DDC1C25AD20 = (692.145, -2107.21, 118.634);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = _id_996F1A6F5AAD2F08;
          weapons[0].script_noteworthy = "trial_starting_weapon";
          weapons[0].origin = (692.145, -2111.5, 118.35);
          _id_039E9DDC1C25AD20 = (693.044, -2045.93, 135.554);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_sn_alpha50+barshort_alpha50+silencersnpr_alpha50+pistolgrip01_alpha50+stockl_alpha50";
          break;
        case "5":
          _id_039E9DDC1C25AD20 = (691.239, -2086.17, 117.865);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_pi_cpapa+custscope_cpapa+silencerbalanced+barlong_cpapa";
          break;
        case "6":
          _id_039E9DDC1C25AD20 = (694.323, -2041.51, 147.329);
          weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
          weapons[0].script_parameters = "iw8_sh_charlie725+silencershtgn_charlie725+barshort_charlie725+stockno_charlie725+fastreload";
          weapons[0].origin = (695, -2038, 149.25);
          break;
      }
    }
  }

  if(mapname == "mp_spear_pm") {
    _id_039E9DDC1C25AD20 = (704, 2712, -37);
    weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
    weapons[0].script_parameters = "iw8_sm_uzulu+laserrange_smg";
    _id_039E9DDC1C25AD20 = (100, 3489.25, -3.25);
    weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
    weapons[0].script_parameters = "iw8_lm_pkilo+laserrange_bar";
    _id_039E9DDC1C25AD20 = (-610, 2547.75, 19.25);
    weapons = getentarrayinradius("trial_weapon", "targetname", _id_039E9DDC1C25AD20, 1);
    weapons[0].script_parameters = "iw8_ar_akilo47+laserrange_bar";
  }
}

move_and_delete_objects_cleararea(mapname, _id_391E7BBA92E85F93) {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  wait 1;

  if(mapname == "mp_spear" || mapname == "mp_spear_pm") {
    van = undefined;
    script_models = getEntArray("script_model", "classname");

    foreach(ent in script_models) {
      if(ent.model == "veh8_civ_lnd_palfa_rhd_infil")
        van = ent;
    }

    if(isDefined(van)) {
      children = van getlinkedchildren();
      van delete();
      scripts\engine\utility::array_delete(children);
      clips = getentarrayinradius("script_model", "classname", (-38.8918, 3264, -43), 1);
      clips[0] delete();
    }

    spawners = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
    _id_86D64B6341B881CE = (912, 1664, 272);
    _id_753B54A7C1E56A93 = scripts\engine\utility::getclosest(_id_86D64B6341B881CE, spawners, 50);
    _id_753B54A7C1E56A93.origin = (933, 1701, 272);
    _id_79D78DD32C9EAA49 = (-496, 352, 144);
    _id_53FD9BCFE97F77D0 = (-464, 360, 144);
    _id_8D8A55772595CED7 = getnodesinradius(_id_79D78DD32C9EAA49, 5, 0, 50, "cover");
    _id_FD31930969F4A012 = spawncovernode(_id_53FD9BCFE97F77D0, _id_8D8A55772595CED7[0].angles, "Cover Stand");
    _id_8D8A55772595CED7[0] _meth_547AAB3C2787AC87();
  }
}

trial_chevron_init() {
  mapname = getDvar("g_mapname");
  level.trial_chevron_vfx = loadfx("vfx/core/mp/core/vfx_hp_chev_grey.vfx");
  _id_969E3FB7D0B6E268 = [];
  _id_019AF92D560E6E9E = getEntArray("trial_hp_chevron", "targetname");
  _id_969E3FB7D0B6E268 = scripts\engine\utility::array_combine(_id_969E3FB7D0B6E268, _id_019AF92D560E6E9E);

  switch (mapname) {
    case "mp_spear":
      _id_790ED4FC86C63670 = [];
      _id_790ED4FC86C63670[0] = spawn("script_origin", (448, -1998, 75));
      _id_790ED4FC86C63670[0].angles = (0, 90, 0);
      _id_790ED4FC86C63670[1] = spawn("script_origin", (552, -1998, 75));
      _id_790ED4FC86C63670[1].angles = (0, 90, 0);
      _id_790ED4FC86C63670[2] = spawn("script_origin", (598, -1888, 75));
      _id_790ED4FC86C63670[2].angles = (0, 180, 0);
      _id_790ED4FC86C63670[3] = spawn("script_origin", (402, -1888, 75));
      _id_790ED4FC86C63670[3].angles = (0, 0, 0);
      break;
    case "mp_spear_pm":
      _id_790ED4FC86C63670 = [];
      _id_790ED4FC86C63670[0] = spawn("script_origin", (448, -1998, 75));
      _id_790ED4FC86C63670[0].angles = (0, 90, 0);
      _id_790ED4FC86C63670[1] = spawn("script_origin", (552, -1998, 75));
      _id_790ED4FC86C63670[1].angles = (0, 90, 0);
      _id_790ED4FC86C63670[2] = spawn("script_origin", (598, -1888, 75));
      _id_790ED4FC86C63670[2].angles = (0, 180, 0);
      _id_790ED4FC86C63670[3] = spawn("script_origin", (402, -1888, 75));
      _id_790ED4FC86C63670[3].angles = (0, 0, 0);
      break;
    case "mp_runner":
      _id_790ED4FC86C63670 = [];
      _id_790ED4FC86C63670[0] = spawn("script_origin", (2658, 328, 256));
      _id_790ED4FC86C63670[0].angles = (0, 0, 0);
      _id_790ED4FC86C63670[1] = spawn("script_origin", (2658, 360, 256));
      _id_790ED4FC86C63670[1].angles = (0, 0, 0);
      _id_790ED4FC86C63670[2] = spawn("script_origin", (2658, 392, 256));
      _id_790ED4FC86C63670[2].angles = (0, 0, 0);
      _id_790ED4FC86C63670[3] = spawn("script_origin", (2688, 400, 256));
      _id_790ED4FC86C63670[3].angles = (0, 270, 0);
      _id_790ED4FC86C63670[4] = spawn("script_origin", (2720, 400, 256));
      _id_790ED4FC86C63670[4].angles = (0, 270, 0);
      _id_790ED4FC86C63670[5] = spawn("script_origin", (2752, 400, 256));
      _id_790ED4FC86C63670[5].angles = (0, 270, 0);
      _id_790ED4FC86C63670[6] = spawn("script_origin", (2782, 392, 256));
      _id_790ED4FC86C63670[6].angles = (0, 180, 0);
      _id_790ED4FC86C63670[7] = spawn("script_origin", (2782, 360, 256));
      _id_790ED4FC86C63670[7].angles = (0, 180, 0);
      _id_790ED4FC86C63670[8] = spawn("script_origin", (2782, 328, 256));
      _id_790ED4FC86C63670[8].angles = (0, 180, 0);
      break;
    case "mp_runner_pm":
      _id_790ED4FC86C63670 = [];
      _id_790ED4FC86C63670[0] = spawn("script_origin", (2658, 328, 256));
      _id_790ED4FC86C63670[0].angles = (0, 0, 0);
      _id_790ED4FC86C63670[1] = spawn("script_origin", (2658, 360, 256));
      _id_790ED4FC86C63670[1].angles = (0, 0, 0);
      _id_790ED4FC86C63670[2] = spawn("script_origin", (2658, 392, 256));
      _id_790ED4FC86C63670[2].angles = (0, 0, 0);
      _id_790ED4FC86C63670[3] = spawn("script_origin", (2688, 400, 256));
      _id_790ED4FC86C63670[3].angles = (0, 270, 0);
      _id_790ED4FC86C63670[4] = spawn("script_origin", (2720, 400, 256));
      _id_790ED4FC86C63670[4].angles = (0, 270, 0);
      _id_790ED4FC86C63670[5] = spawn("script_origin", (2752, 400, 256));
      _id_790ED4FC86C63670[5].angles = (0, 270, 0);
      _id_790ED4FC86C63670[6] = spawn("script_origin", (2782, 392, 256));
      _id_790ED4FC86C63670[6].angles = (0, 180, 0);
      _id_790ED4FC86C63670[7] = spawn("script_origin", (2782, 360, 256));
      _id_790ED4FC86C63670[7].angles = (0, 180, 0);
      _id_790ED4FC86C63670[8] = spawn("script_origin", (2782, 328, 256));
      _id_790ED4FC86C63670[8].angles = (0, 180, 0);
      break;
    case "mp_cave_am":
      _id_790ED4FC86C63670 = [];
      _id_790ED4FC86C63670[0] = spawn("script_origin", (-1934, -1264, -23));
      _id_790ED4FC86C63670[0].angles = (0, 270, 0);
      _id_790ED4FC86C63670[1] = spawn("script_origin", (-1870, -1264, -16));
      _id_790ED4FC86C63670[1].angles = (0, 270, 0);
      _id_790ED4FC86C63670[2] = spawn("script_origin", (-2000, -1292, -24));
      _id_790ED4FC86C63670[2].angles = (180, 180, 180);
      _id_790ED4FC86C63670[3] = spawn("script_origin", (-2000, -1342, -24));
      _id_790ED4FC86C63670[3].angles = (180, 180, 180);
      _id_790ED4FC86C63670[4] = spawn("script_origin", (-2000, -1388, -26));
      _id_790ED4FC86C63670[4].angles = (180, 180, 180);
      _id_790ED4FC86C63670[5] = spawn("script_origin", (-2000, -1438, -22));
      _id_790ED4FC86C63670[5].angles = (180, 180, 180);
      _id_790ED4FC86C63670[6] = spawn("script_origin", (-1870, -1462, -16));
      _id_790ED4FC86C63670[6].angles = (0, 90, 0);
      _id_790ED4FC86C63670[7] = spawn("script_origin", (-1934, -1462, -16));
      _id_790ED4FC86C63670[7].angles = (0, 90, 0);
      break;
    case "mp_village2":
      _id_790ED4FC86C63670 = [];
      _id_790ED4FC86C63670[0] = spawn("script_origin", (-1208, -2061, 422));
      _id_790ED4FC86C63670[0].angles = (0, 0, 0);
      _id_790ED4FC86C63670[1] = spawn("script_origin", (-1208, -2103, 417));
      _id_790ED4FC86C63670[1].angles = (0, 0, 0);
      _id_790ED4FC86C63670[2] = spawn("script_origin", (-1208, -2141, 412));
      _id_790ED4FC86C63670[2].angles = (0, 0, 0);
      _id_790ED4FC86C63670[3] = spawn("script_origin", (-1183, -2159, 406));
      _id_790ED4FC86C63670[3].angles = (0, 90, 0);
      _id_790ED4FC86C63670[4] = spawn("script_origin", (-1131, -2159, 406));
      _id_790ED4FC86C63670[4].angles = (0, 90, 0);
      _id_790ED4FC86C63670[5] = spawn("script_origin", (-1085, -2159, 406));
      _id_790ED4FC86C63670[5].angles = (0, 90, 0);
      _id_790ED4FC86C63670[6] = spawn("script_origin", (-1047.5, -2159, 421.5));
      _id_790ED4FC86C63670[6].angles = (0, 90, 0);
      _id_790ED4FC86C63670[7] = spawn("script_origin", (-1029, -2072.5, 424.5));
      _id_790ED4FC86C63670[7].angles = (0, 180, 0);
      _id_790ED4FC86C63670[8] = spawn("script_origin", (-1029, -2106.5, 424.5));
      _id_790ED4FC86C63670[8].angles = (0, 180, 0);
      _id_790ED4FC86C63670[9] = spawn("script_origin", (-1029, -2141, 423));
      _id_790ED4FC86C63670[9].angles = (0, 180, 0);
      break;
    default:
      _id_790ED4FC86C63670 = [];
      break;
  }

  _id_969E3FB7D0B6E268 = scripts\engine\utility::array_combine(_id_969E3FB7D0B6E268, _id_790ED4FC86C63670);
  _id_E31AE11F36FCE56F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_969E3FB7D0B6E268.size; _id_AC0E594AC96AA3A8++) {
    _id_E31AE11F36FCE56F[_id_AC0E594AC96AA3A8] = spawn("script_model", _id_969E3FB7D0B6E268[_id_AC0E594AC96AA3A8].origin);
    _id_E31AE11F36FCE56F[_id_AC0E594AC96AA3A8].angles = _id_969E3FB7D0B6E268[_id_AC0E594AC96AA3A8].angles;
    _id_E31AE11F36FCE56F[_id_AC0E594AC96AA3A8] setModel("tag_origin");
  }

  scripts\engine\utility::array_call(_id_969E3FB7D0B6E268, ::delete);
  return _id_E31AE11F36FCE56F;
}

trial_chevron_vfx_action(_id_C8D461CD5545583A, action) {
  if(action == "turn_on") {
    foreach(_id_0EAE85273686F4F4 in _id_C8D461CD5545583A) {
      waitframe();
      playFXOnTag(level.trial_chevron_vfx, _id_0EAE85273686F4F4, "TAG_ORIGIN");
    }
  }

  if(action == "turn_off") {
    foreach(_id_0EAE85273686F4F4 in _id_C8D461CD5545583A)
    stopFXOnTag(level.trial_chevron_vfx, _id_0EAE85273686F4F4, "TAG_ORIGIN");
  }
}

mp_m_speed_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (60, 2140, 26), (0, 180, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  _id_2391E4D180BD249F = spawn("script_origin", (-260, 2140, 32));
  _id_2391E4D180BD249F.angles = (0, 0, 0);
  _id_2391E4D180BD249F.targetname = "trial_juggernaut_crate";
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  register_create_script_arrays("mp_m_speed_create_script", "mp_m_speed_trial", _id_13B292F93B86D410::main);
}

_id_2D553533AB5BC4F3() {
  if(level.trial["missionScript"] == "gun") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-642.5, 3352, 40), (0, 270, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  }

  if(level.trial["missionScript"] == "clear") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-813.584, 166.11, 23.833), (0, 0, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    level.trial_enemy_dont_drop_weapon = 1;
    level.trial_explosive_clear = 1;
    thread scripts\mp\trials\mp_trl_cleararea::createscript_covernodes();
  }
}

mp_deadzone_patch() {
  if(level.trial["missionScript"] == "jugg") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-728, 588, 460), (0, 320, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    _id_2391E4D180BD249F = spawn("script_origin", (-532, 424, 460));
    _id_2391E4D180BD249F.angles = (0, 320, 0);
    _id_2391E4D180BD249F.targetname = "trial_juggernaut_crate";
  } else if(level.trial["missionScript"] == "race") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (1118, -4101, 328), (9, 153, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");

    if(level.trial["variant"] == "trialympic") {
      level.trial_race_lap_total_override = 1;
      level.trial_dogtag_setup = "trialympic_dogtag";
      return;
    }

    _id_AF5C4BBB2B1E37D1 = getEnt("clip8x8x256", "targetname");
    _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
    _id_87890A761838B95F = getEnt("clip32x32x32", "targetname");
    _id_84422B770B8927AE = [];
    _id_4EB850D95C514C5B = [];
    _id_F234453E9FBAED2A = [];
    _id_84422B770B8927AE[0] = spawn("script_model", (-279, -1940, 224));
    _id_84422B770B8927AE[0].angles = (0, 350, 0);
    _id_84422B770B8927AE[1] = spawn("script_model", (-1075, -2018, 265));
    _id_84422B770B8927AE[1].angles = (0, 26, 0);
    _id_84422B770B8927AE[2] = spawn("script_model", (-1102, -1878, 271));
    _id_84422B770B8927AE[2].angles = (0, 9, 0);
    _id_84422B770B8927AE[3] = spawn("script_model", (-1086, -1743, 271));
    _id_84422B770B8927AE[3].angles = (0, 351, 0);
    _id_84422B770B8927AE[4] = spawn("script_model", (-1266, 1816, 322));
    _id_84422B770B8927AE[4].angles = (0, 0, 0);
    _id_84422B770B8927AE[5] = spawn("script_model", (-530, 2909, 185));
    _id_84422B770B8927AE[5].angles = (0, 0, 0);
    _id_84422B770B8927AE[6] = spawn("script_model", (-393, 2906, 182));
    _id_84422B770B8927AE[6].angles = (0, 353, 0);
    _id_84422B770B8927AE[7] = spawn("script_model", (-265, 2861, 186));
    _id_84422B770B8927AE[7].angles = (0, 334, 0);
    _id_84422B770B8927AE[8] = spawn("script_model", (664, -1922, 192));
    _id_84422B770B8927AE[8].angles = (0, 43, 0);
    _id_84422B770B8927AE[9] = spawn("script_model", (847, -2058, 203));
    _id_84422B770B8927AE[9].angles = (0, 343, 0);
    _id_84422B770B8927AE[10] = spawn("script_model", (1065, -2072, 201));
    _id_84422B770B8927AE[10].angles = (0, 3, 0);
    _id_84422B770B8927AE[11] = spawn("script_model", (2294, -2189, 174));
    _id_84422B770B8927AE[11].angles = (0, 37, 0);
    _id_84422B770B8927AE[12] = spawn("script_model", (2356, -2350, 167));
    _id_84422B770B8927AE[12].angles = (0, 0, 0);
    _id_84422B770B8927AE[13] = spawn("script_model", (2332, -2526, 167));
    _id_84422B770B8927AE[13].angles = (0, 341, 0);
    _id_84422B770B8927AE[14] = spawn("script_model", (1568, -4350, 131));
    _id_84422B770B8927AE[14].angles = (0, 98, 0);
    _id_84422B770B8927AE[15] = spawn("script_model", (1354, -4365, 132));
    _id_84422B770B8927AE[15].angles = (0, 84, 0);
    _id_84422B770B8927AE[16] = spawn("script_model", (1167, -4318, 141));
    _id_84422B770B8927AE[16].angles = (0, 80, 0);

    foreach(_id_F90358454413407F in _id_84422B770B8927AE)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_AF5C4BBB2B1E37D1);

    _id_4EB850D95C514C5B[0] = spawn("script_model", (1101, 2090, 327));
    _id_4EB850D95C514C5B[0].angles = (0, 134, 0);
    _id_4EB850D95C514C5B[1] = spawn("script_model", (975, 2234, 337));
    _id_4EB850D95C514C5B[1].angles = (3, 225, 0);
    _id_4EB850D95C514C5B[2] = spawn("script_model", (283, 1789, 408));
    _id_4EB850D95C514C5B[2].angles = (0, 78, 0);
    _id_4EB850D95C514C5B[3] = spawn("script_model", (206, 1789, 406));
    _id_4EB850D95C514C5B[3].angles = (0, 98, 0);
    _id_4EB850D95C514C5B[4] = spawn("script_model", (-100, 1519, 447));
    _id_4EB850D95C514C5B[4].angles = (0, 268, 0);
    _id_4EB850D95C514C5B[5] = spawn("script_model", (-192, 1495, 440));
    _id_4EB850D95C514C5B[5].angles = (0, 60, 0);
    _id_4EB850D95C514C5B[6] = spawn("script_model", (-795, 1391, 451));
    _id_4EB850D95C514C5B[6].angles = (0, 304, 0);
    _id_4EB850D95C514C5B[7] = spawn("script_model", (-837, 1440, 451));
    _id_4EB850D95C514C5B[7].angles = (0, 304, 0);
    _id_4EB850D95C514C5B[8] = spawn("script_model", (-974, 1506, 438));
    _id_4EB850D95C514C5B[8].angles = (0, 324, 0);
    _id_4EB850D95C514C5B[9] = spawn("script_model", (346, 950, 436));
    _id_4EB850D95C514C5B[9].angles = (0, 5, 0);
    _id_4EB850D95C514C5B[10] = spawn("script_model", (755, -1325, 331));
    _id_4EB850D95C514C5B[10].angles = (357, 23, 3);
    _id_4EB850D95C514C5B[11] = spawn("script_model", (1587, -3411, 293));
    _id_4EB850D95C514C5B[11].angles = (0, 356, 0);
    _id_4EB850D95C514C5B[12] = spawn("script_model", (1583, -3478, 293));
    _id_4EB850D95C514C5B[12].angles = (0, 356, 0);
    _id_4EB850D95C514C5B[13] = spawn("script_model", (914, -4208, 283));
    _id_4EB850D95C514C5B[13].angles = (357, 328, 2);
    _id_4EB850D95C514C5B[14] = spawn("script_model", (-1047, -1708, 403));
    _id_4EB850D95C514C5B[14].angles = (356, 345, 2);
    _id_4EB850D95C514C5B[15] = spawn("script_model", (-609, -1561, 415));
    _id_4EB850D95C514C5B[15].angles = (357, 312, 3);
    _id_4EB850D95C514C5B[16] = spawn("script_model", (-611, -1501, 416));
    _id_4EB850D95C514C5B[16].angles = (351, 270, 10);
    _id_4EB850D95C514C5B[17] = spawn("script_model", (1836, -1879, 334));
    _id_4EB850D95C514C5B[17].angles = (352, 43, 1);
    _id_4EB850D95C514C5B[18] = spawn("script_model", (1877, -1910, 335));
    _id_4EB850D95C514C5B[18].angles = (359, 321, 7);

    foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

    _id_F234453E9FBAED2A[0] = spawn("script_model", (-1153, -1966, 413));
    _id_F234453E9FBAED2A[0].angles = (359, 2, -5);
    _id_F234453E9FBAED2A[1] = spawn("script_model", (-1155, -1935, 411));
    _id_F234453E9FBAED2A[1].angles = (359, 2, -5);
    _id_F234453E9FBAED2A[2] = spawn("script_model", (-1159, -1869, 405));
    _id_F234453E9FBAED2A[2].angles = (360, 3, 4);
    _id_F234453E9FBAED2A[3] = spawn("script_model", (-1161, -1838, 408));
    _id_F234453E9FBAED2A[3].angles = (360, 3, 4);
    _id_F234453E9FBAED2A[4] = spawn("script_model", (-1166, -1780, 409));
    _id_F234453E9FBAED2A[4].angles = (360, 3, 6);
    _id_F234453E9FBAED2A[5] = spawn("script_model", (-1168, -1749, 413));
    _id_F234453E9FBAED2A[5].angles = (360, 3, 6);
    _id_F234453E9FBAED2A[6] = spawn("script_model", (-1098, 1659, 433));
    _id_F234453E9FBAED2A[6].angles = (360, 22, -4);
    _id_F234453E9FBAED2A[7] = spawn("script_model", (-1111, 1689, 431));
    _id_F234453E9FBAED2A[7].angles = (360, 22, -4);
    _id_F234453E9FBAED2A[8] = spawn("script_model", (-1131, 1747, 431));
    _id_F234453E9FBAED2A[8].angles = (0, 18, 3);
    _id_F234453E9FBAED2A[9] = spawn("script_model", (-1141, 1778, 433));
    _id_F234453E9FBAED2A[9].angles = (0, 18, 3);
    _id_F234453E9FBAED2A[10] = spawn("script_model", (-1154, 1837, 430));
    _id_F234453E9FBAED2A[10].angles = (0, 12, 3);
    _id_F234453E9FBAED2A[11] = spawn("script_model", (-1161, 1869, 432));
    _id_F234453E9FBAED2A[11].angles = (0, 12, 3);
    _id_F234453E9FBAED2A[12] = spawn("script_model", (-526, 2859, 324));
    _id_F234453E9FBAED2A[12].angles = (358, 86, 3);
    _id_F234453E9FBAED2A[13] = spawn("script_model", (-494, 2856, 322));
    _id_F234453E9FBAED2A[13].angles = (358, 86, 3);
    _id_F234453E9FBAED2A[14] = spawn("script_model", (-436, 2855, 321));
    _id_F234453E9FBAED2A[14].angles = (3, 82, 2);
    _id_F234453E9FBAED2A[15] = spawn("script_model", (-404, 2850, 320));
    _id_F234453E9FBAED2A[15].angles = (3, 82, 2);
    _id_F234453E9FBAED2A[16] = spawn("script_model", (-351, 2840, 323));
    _id_F234453E9FBAED2A[16].angles = (3, 72, -2);
    _id_F234453E9FBAED2A[17] = spawn("script_model", (-320, 2830, 324));
    _id_F234453E9FBAED2A[17].angles = (3, 72, -2);
    _id_F234453E9FBAED2A[18] = spawn("script_model", (-267, 2805, 331));
    _id_F234453E9FBAED2A[18].angles = (360, 65, 1);
    _id_F234453E9FBAED2A[19] = spawn("script_model", (-237, 2791, 330));
    _id_F234453E9FBAED2A[19].angles = (360, 65, 1);
    _id_F234453E9FBAED2A[20] = spawn("script_model", (685, -1761, 333));
    _id_F234453E9FBAED2A[20].angles = (357, 16, 7);
    _id_F234453E9FBAED2A[21] = spawn("script_model", (694, -1791, 329));
    _id_F234453E9FBAED2A[21].angles = (357, 16, 7);
    _id_F234453E9FBAED2A[22] = spawn("script_model", (733, -1885, 328));
    _id_F234453E9FBAED2A[22].angles = (0, 33, -8);
    _id_F234453E9FBAED2A[23] = spawn("script_model", (750, -1911, 333));
    _id_F234453E9FBAED2A[23].angles = (0, 33, -8);
    _id_F234453E9FBAED2A[24] = spawn("script_model", (834, -2002, 346));
    _id_F234453E9FBAED2A[24].angles = (4, 59, -4);
    _id_F234453E9FBAED2A[25] = spawn("script_model", (861, -2019, 348));
    _id_F234453E9FBAED2A[25].angles = (4, 59, -4);
    _id_F234453E9FBAED2A[26] = spawn("script_model", (1572, -4302, 272));
    _id_F234453E9FBAED2A[26].angles = (0, 280, -1);
    _id_F234453E9FBAED2A[27] = spawn("script_model", (1541, -4308, 272));
    _id_F234453E9FBAED2A[27].angles = (0, 280, -1);
    _id_F234453E9FBAED2A[28] = spawn("script_model", (1441, -4328, 276));
    _id_F234453E9FBAED2A[28].angles = (360, 274, -1);
    _id_F234453E9FBAED2A[29] = spawn("script_model", (1410, -4331, 276));
    _id_F234453E9FBAED2A[29].angles = (360, 274, -1);
    _id_F234453E9FBAED2A[30] = spawn("script_model", (1305, -4315, 282));
    _id_F234453E9FBAED2A[30].angles = (360, 254, -3);
    _id_F234453E9FBAED2A[31] = spawn("script_model", (1275, -4306, 283));
    _id_F234453E9FBAED2A[31].angles = (360, 254, -3);
    _id_F234453E9FBAED2A[32] = spawn("script_model", (1179, -4270, 290));
    _id_F234453E9FBAED2A[32].angles = (358, 238, 1);
    _id_F234453E9FBAED2A[33] = spawn("script_model", (1152, -4254, 290));
    _id_F234453E9FBAED2A[33].angles = (358, 238, 1);

    foreach(_id_F90358454413407F in _id_F234453E9FBAED2A)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_87890A761838B95F);
  }
}

mp_shipment_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-654.833, 1994.12, 15.9902), (0, 0, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  _id_2391E4D180BD249F = spawn("script_origin", (-278.833, 1994.12, 15.9902));
  _id_2391E4D180BD249F.angles = (0, 0, 0);
  _id_2391E4D180BD249F.targetname = "trial_juggernaut_crate";
}

mp_m_speedball_patch() {
  trig = spawn("script_origin", (0, 0, 0));
  trig.targetname = "progression";
  trig.target = "alpha";
  trig.script_noteworthy = "start";
  trig thread fake_trigger_think(::mp_speedball_check_trigger_pos);
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-892, 5, 16), (0, 43.1957, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((-739.378, 167.847, 66.9861), (285.714, 315.5, -46.9039), "trial_variant_fast", undefined, "iw8_lm_lima86+reflexmini+barshort+pistolgrip02+silencer3");
  create_trial_weapon_spawn((-738.471, 187.473, 63.2056), (38.4734, 89.4932, -0.965993), "trial_variant_fast", undefined, "iw8_pi_golf21+fastreload+trigcust03+laserrange+stockcust+xmagslrg");
  create_trial_weapon_spawn((-739.5, 188.25, 54.5), (18.2161, 89.5772, -0.784029), "trial_variant_fast", undefined, "iw8_pi_papa320+fastreload+trigcust03+laserrange+xmagslrg");
  create_trial_weapon_spawn((-740.8, 75.613, 65.6452), (296.215, 48.4494, 45.8564), "trial_variant_fast", undefined, "iw8_sh_romeo870+fastreload+stockno+xmags+gripcust+barshort");
  create_trial_weapon_spawn((-740.187, 103.475, 69.1132), (284.965, 342.911, -72.7181), "trial_variant_fast", undefined, "iw8_ar_asierra12+stocks+pistolgrip02+barshort");
  create_trial_weapon_spawn((-740.294, 116.337, 71.5601), (292.978, 47.6906, 43.0764), "trial_variant_fast", undefined, "iw8_sn_mike14+laserbalanced+pistolgrip06+xmagslrg+barshort");
  create_trial_weapon_spawn((-739.47, 86.873, 69.4761), (282.94, 337.806, -67.6405), "trial_variant_fast", undefined, "iw8_ar_falima+stockno+pistolgrip02+barshort");
  create_trial_weapon_spawn((-737.721, 189.723, 75.7056), (10.9774, 89.6008, -0.726613), "trial_variant_fast", undefined, "iw8_pi_cpapa+fastreload+trigcust+calcust2+pistolgrip02+barshort");
  create_trial_weapon_spawn((-741.622, 154.403, 67.7361), (282.486, 61.4191, 28.8511), "trial_variant_fast", undefined, "iw8_ar_mike4+fastreload+stockh+pistolgrip02+calcust+gripvert");
  create_trial_weapon_spawn((615.378, -154.847, 52.986), (277.284, 38.6086, 9.38197), "trial_variant_pickup", "osp", "iw8_ar_mike4+reflex4+fmj+stockno+pistolgrip02");
  create_trial_weapon_spawn((-353.3, 626.613, 52.3952), (0.706816, 90.4638, 3.21603), "trial_variant_pickup", "osp", "iw8_sh_romeo870+fastreload+stockno+xmags+gripcust+barshort");
  create_trial_weapon_spawn((-209.47, 372.373, 49.7261), (272.789, 302.444, -32.1599), "trial_variant_pickup", "osp", "iw8_ar_scharlie+fastreload+laserbalanced+stockl+pistolgrip02+barshort");
  create_trial_weapon_spawn((-253.687, -265.525, 17.8632), (359.286, 238.951, -92.3844), "trial_variant_pickup", "osp", "iw8_ar_asierra12+stocks+pistolgrip02+barshort");
  create_trial_weapon_spawn((-721.294, 136.337, 56.5601), (286.817, 86.2294, 2.34117), "trial_variant_pickup", "osp", "iw8_sn_sbeta+acog2+fastreload+laserbalanced+stockh+pistolgrip02");
  create_trial_weapon_spawn((-720.471, 129.723, 55.9556), (10.9774, 89.6008, -0.726613), "trial_variant_pickup", "osp", "iw8_pi_cpapa+fastreload+trigcust+laserrange+pistolgrip02+barshort");
  create_trial_weapon_spawn((495.597, 512.911, 59.2126), (278.32, 353.274, 4.7039), "trial_variant_pickup", "osp", "iw8_sm_mpapa5+laserbalanced+stockno+pistolgrip02+calcust+barshort");
}

mp_runner_patch(_id_059BA51395D592EE, _id_391E7BBA92E85F93, _id_8E003FDA6A2C258F) {
  if(_id_059BA51395D592EE == "clear") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (2731, 727.75, 253), (0, 270, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    create_trial_weapon_spawn((3023.75, -289.25, 125.75), (0, 270, 0), undefined, "trial_starting_weapon", "iw8_knife");
    create_trial_weapon_spawn((2587, 611, 305), (360, 270, 0), "trial_variant_assault", undefined, "iw8_ar_mike4+minireddot+gripvert");
    create_trial_weapon_spawn((2587.5, 613, 322), (0, 270, 0), "trial_variant_assault", undefined, "iw8_ar_asierra12+minireddot+gripvert");
    create_trial_weapon_spawn((2586.75, 549.25, 308), (0, 270, 0), "trial_variant_assault", undefined, "iw8_ar_tango21+minireddot_tall+gripvert+stockl_tango21+barshort_tango21");
    create_trial_weapon_spawn((2585.75, 553, 323), (0, 270, 0), "trial_variant_assault", undefined, "iw8_ar_scharlie+reflex_east01+silencer_west01+gripvert+stocks_scharlie+laserrange");
    create_trial_weapon_spawn((2587, 550, 325.75), (360, 270, 0), "trial_variant_heavy", undefined, "iw8_lm_mgolf36+stockl+calcust+gripang+barmid");
    create_trial_weapon_spawn((2586, 558, 305), (0, 270, 0), "trial_variant_heavy", undefined, "iw8_lm_mgolf34+silencer+xmags+pistolgrip01");
    create_trial_weapon_spawn((2587.5, 618, 322), (360, 270, 5.48232), "trial_variant_heavy", undefined, "iw8_lm_pkilo+acog_east01+silencerbalanced+gripvertpro");
    create_trial_weapon_spawn((2588, 621, 305), (0, 270, 0), "trial_variant_heavy", undefined, "iw8_lm_kilo121+silencerlmg_west01+bipod_kilo121");
    create_trial_weapon_spawn((2586.6, 611.86, 312.064), (359, 270, -0.000128963), "trial_variant_night", undefined, "iw8_pi_papa320+silencer+fastreload+laserrange");
    level.player_equip_primary = "equip_frag";
    level.player_equip_secondary = "equip_flash";
    level.player_equip_regen = 1;
    thread scripts\mp\trials\mp_trl_cleararea::createscript_covernodes();
    register_create_script_arrays("mp_runner_create_script", "mp_runner_create_script", _id_2B4B74E318A08824::main);

    if(_id_391E7BBA92E85F93 == 323) {
      level.player_limitedammo = 1;
      return;
    }
  } else if(_id_059BA51395D592EE == "lava") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (1472, -1121, 311), (0, 53.5, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
    _id_3908F68C4CE949B7 = [];
    _id_3908F68C4CE949B7[0] = spawn("script_model", (-390, 25, 256));
    _id_3908F68C4CE949B7[0].angles = (0, 0, 0);
    _id_3908F68C4CE949B7[1] = spawn("script_model", (-342, 25, 256));
    _id_3908F68C4CE949B7[1].angles = (0, 0, 0);
    _id_3908F68C4CE949B7[2] = spawn("script_model", (-938, -207, 168));
    _id_3908F68C4CE949B7[2].angles = (0, 342, 0);
    _id_3908F68C4CE949B7[3] = spawn("script_model", (-954, -257, 168));
    _id_3908F68C4CE949B7[3].angles = (0, 342, 0);
    _id_3908F68C4CE949B7[4] = spawn("script_model", (-916, -427, 174));
    _id_3908F68C4CE949B7[4].angles = (0, 0, 0);
    _id_3908F68C4CE949B7[5] = spawn("script_model", (-1006, -563, 171));
    _id_3908F68C4CE949B7[5].angles = (8.5, 84, -2.4);
    _id_3908F68C4CE949B7[6] = spawn("script_model", (-1209, -591, 168));
    _id_3908F68C4CE949B7[6].angles = (0, 326, 0);
    _id_3908F68C4CE949B7[7] = spawn("script_model", (-1704, -765, 168));
    _id_3908F68C4CE949B7[7].angles = (0, 0, 0);
    _id_3908F68C4CE949B7[10] = spawn("script_model", (-2180, -801, 168));
    _id_3908F68C4CE949B7[10].angles = (0, 0, 0);
    _id_3908F68C4CE949B7[11] = spawn("script_model", (-2365, -804, 168));
    _id_3908F68C4CE949B7[11].angles = (0, 0, 0);
    _id_3908F68C4CE949B7[12] = spawn("script_model", (-2365, -804, 168));
    _id_3908F68C4CE949B7[12].angles = (0, 330, 0);
    _id_3908F68C4CE949B7[13] = spawn("script_model", (-2530, -747, 168));
    _id_3908F68C4CE949B7[13].angles = (0, 330, 0);
    _id_3908F68C4CE949B7[14] = spawn("script_model", (-2629, -598, 168));
    _id_3908F68C4CE949B7[14].angles = (0, 270, 0);
    _id_3908F68C4CE949B7[15] = spawn("script_model", (-2650, -412, 170));
    _id_3908F68C4CE949B7[15].angles = (0, 270, 0);
    _id_3908F68C4CE949B7["truckpart1"] = spawn("script_model", (1620.21, -958.617, 236));
    _id_3908F68C4CE949B7["truckpart1"].angles = (0, 230, 0);
    _id_3908F68C4CE949B7["truckpart2"] = spawn("script_model", (1583.66, -927.504, 236));
    _id_3908F68C4CE949B7["truckpart2"].angles = (0, 230, 0);

    foreach(_id_F90358454413407F in _id_3908F68C4CE949B7)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);

    _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
    _id_4EB850D95C514C5B = [];
    _id_4EB850D95C514C5B[0] = spawn("script_model", (1542.18, -976.239, 236));
    _id_4EB850D95C514C5B[0].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[1] = spawn("script_model", (1578.73, -1007.35, 236));
    _id_4EB850D95C514C5B[1].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[2] = spawn("script_model", (1500.69, -1024.97, 236));
    _id_4EB850D95C514C5B[2].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[3] = spawn("script_model", (1537.24, -1056.09, 236));
    _id_4EB850D95C514C5B[3].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[4] = spawn("script_model", (1459.21, -1073.71, 236));
    _id_4EB850D95C514C5B[4].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[5] = spawn("script_model", (1495.76, -1104.82, 236));
    _id_4EB850D95C514C5B[5].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[6] = spawn("script_model", (1423.82, -1127.63, 236));
    _id_4EB850D95C514C5B[6].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[7] = spawn("script_model", (1460.37, -1158.74, 236));
    _id_4EB850D95C514C5B[7].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[8] = spawn("script_model", (1403.07, -1152, 256));
    _id_4EB850D95C514C5B[8].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[9] = spawn("script_model", (1427.44, -1172.74, 256));
    _id_4EB850D95C514C5B[9].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[10] = spawn("script_model", (1403.07, -1152, 320));
    _id_4EB850D95C514C5B[10].angles = (0, 230, 0);
    _id_4EB850D95C514C5B[11] = spawn("script_model", (1427.44, -1172.74, 320));
    _id_4EB850D95C514C5B[11].angles = (0, 230, 0);

    foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

    _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
    _id_C665700AAD2CBF97 = [];
    _id_C665700AAD2CBF97[0] = spawn("script_model", (1508.34, -978.958, 324));
    _id_C665700AAD2CBF97[0].angles = (0, 230, 90);
    _id_C665700AAD2CBF97[1] = spawn("script_model", (1425.38, -1076.43, 324));
    _id_C665700AAD2CBF97[1].angles = (0, 230, 90);
    _id_C665700AAD2CBF97[2] = spawn("script_model", (1504.57, -1143.84, 324));
    _id_C665700AAD2CBF97[2].angles = (0, 230, 90);
    _id_C665700AAD2CBF97[3] = spawn("script_model", (1587.54, -1046.37, 324));
    _id_C665700AAD2CBF97[3].angles = (0, 230, 90);

    foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

    _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
    _id_B096CCC1A2F2D643 = [];
    _id_B096CCC1A2F2D643[0] = spawn("script_model", (1422.72, -1116.44, 380));
    _id_B096CCC1A2F2D643[0].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[1] = spawn("script_model", (1459.28, -1147.56, 380));
    _id_B096CCC1A2F2D643[1].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[2] = spawn("script_model", (1500.94, -1098.73, 380));
    _id_B096CCC1A2F2D643[2].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[3] = spawn("script_model", (1464.39, -1067.62, 380));
    _id_B096CCC1A2F2D643[3].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[4] = spawn("script_model", (1542.43, -1049.99, 380));
    _id_B096CCC1A2F2D643[4].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[5] = spawn("script_model", (1505.88, -1018.88, 380));
    _id_B096CCC1A2F2D643[5].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[6] = spawn("script_model", (1583.91, -1001.26, 380));
    _id_B096CCC1A2F2D643[6].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[7] = spawn("script_model", (1547.36, -970.147, 380));
    _id_B096CCC1A2F2D643[7].angles = (0, 230, 0);
    _id_B096CCC1A2F2D643[8] = spawn("script_model", (1584.21, -926.617, 300));
    _id_B096CCC1A2F2D643[8].angles = (14, 230, 0);
    _id_B096CCC1A2F2D643[9] = spawn("script_model", (1622.21, -958.617, 300));
    _id_B096CCC1A2F2D643[9].angles = (14, 230, 0);

    foreach(_id_F90358454413407F in _id_B096CCC1A2F2D643)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

    _id_887DDA7C1841F51B = spawn("script_model", (1607.7, -979.485, 340));
    _id_887DDA7C1841F51B.angles = (90, 230, 0);
    _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
    _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
    _id_0E05FDBC2B05C5E4 = spawn("script_model", (1565.06, -943.187, 340));
    _id_0E05FDBC2B05C5E4.angles = (90, 230, 0);
    _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
    _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
    _id_039E9DDC1C25AD20 = (0, 0, 0);
    _id_DBDFBCB794B9185A = (0, 0, 0);
    weapon = spawn("script_origin", _id_039E9DDC1C25AD20);
    weapon.angles = _id_DBDFBCB794B9185A;
    weapon.targetname = "trial_weapon";
    weapon.script_noteworthy = "trial_starting_weapon";

    if(_id_8E003FDA6A2C258F == "knife")
      weapon.script_parameters = "iw8_knife";
    else {
      weapon.script_parameters = "iw8_pi_golf21";
      level.trial_weapon_defined = 1;
    }

    register_create_script_arrays("mp_runner_pm_create_script", "mp_runner_trial_floorislava", _id_75C2E5C13123176E::main);
  }
}

mp_aniyah_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-2144, -1263, 312), (0, 7, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  _id_AF5C4BBB2B1E37D1 = getEnt("clip8x8x256", "targetname");
  _id_84422B770B8927AE = [];
  _id_84422B770B8927AE[0] = spawn("script_model", (-191, -1785, 116));
  _id_84422B770B8927AE[0].angles = (0, 146, 0);
  _id_84422B770B8927AE[1] = spawn("script_model", (-70, -1630, 116));
  _id_84422B770B8927AE[1].angles = (0, 161, 0);
  _id_84422B770B8927AE[2] = spawn("script_model", (-38, -1443, 116));
  _id_84422B770B8927AE[2].angles = (0, 180, 0);
  _id_84422B770B8927AE[3] = spawn("script_model", (3688, 1959, 199));
  _id_84422B770B8927AE[3].angles = (0, 199, 0);
  _id_84422B770B8927AE[4] = spawn("script_model", (3601, 2100, 199));
  _id_84422B770B8927AE[4].angles = (0, 242, 0);
  _id_84422B770B8927AE[5] = spawn("script_model", (3424, 2198, 199));
  _id_84422B770B8927AE[5].angles = (0, 242, 0);
  _id_84422B770B8927AE[6] = spawn("script_model", (231, 593, 116));
  _id_84422B770B8927AE[6].angles = (0, 29, 0);
  _id_84422B770B8927AE[7] = spawn("script_model", (90, 494, 116));
  _id_84422B770B8927AE[7].angles = (0, 12, 0);
  _id_84422B770B8927AE[8] = spawn("script_model", (-70, 445, 116));
  _id_84422B770B8927AE[8].angles = (0, 0, 0);
  _id_84422B770B8927AE[9] = spawn("script_model", (-3690, 563, 116));
  _id_84422B770B8927AE[9].angles = (0, 13, 0);
  _id_84422B770B8927AE[10] = spawn("script_model", (-3901, 492, 116));
  _id_84422B770B8927AE[10].angles = (0, 42, 0);
  _id_84422B770B8927AE[11] = spawn("script_model", (-4064, 356, 116));
  _id_84422B770B8927AE[11].angles = (0, 71, 0);
  _id_84422B770B8927AE[12] = spawn("script_model", (-4110, 125, 116));
  _id_84422B770B8927AE[12].angles = (0, 81, 0);
  _id_84422B770B8927AE[13] = spawn("script_model", (-4170, -201, 116));
  _id_84422B770B8927AE[13].angles = (0, 81, 0);
  _id_84422B770B8927AE[14] = spawn("script_model", (-4164, -522, 116));
  _id_84422B770B8927AE[14].angles = (0, 113, 0);
  _id_84422B770B8927AE[15] = spawn("script_model", (-4129, -718, 116));
  _id_84422B770B8927AE[15].angles = (0, 113, 0);
  _id_84422B770B8927AE[16] = spawn("script_model", (-4026, -890, 116));
  _id_84422B770B8927AE[16].angles = (0, 133, 0);
  _id_84422B770B8927AE[17] = spawn("script_model", (-3854, -1058, 116));
  _id_84422B770B8927AE[17].angles = (0, 156, 0);

  foreach(_id_F90358454413407F in _id_84422B770B8927AE)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_AF5C4BBB2B1E37D1);
}

mp_raid_patch() {
  if(level.trial["missionScript"] == "race") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-2700, 748, 271), (0, 70, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  } else if(level.trial["missionScript"] == "sniper") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-155, 3420, 521), (0, 270, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    create_trial_weapon_spawn((-176, 3172, 532), (315, 270, 0), undefined, "outline", "iw8_sn_crossbow+ammo_crossbow+armstac_crossbow+fastreload+grip_crossbow+rec_crossbow+stocks_crossbow+custscope_crossbow+wirel_crossbow");
    level.trial_use_headicon = 1;
    level.headicon_time_left = 10000;
    level.trial_white_phosphorus = 1;
    level.trial_white_phosphorus_activate = 3;
  }
}

mp_euphrates_patches() {
  _id_25B3DB8E2BA2CE96 = [];
  _id_ED5B157AE957AA5D = [];

  switch (level.trial["missionScript"]) {
    case "sniper":
      spawner = spawnStruct();
      spawner.origin = (193, -12, 23);
      spawner.angles = (0, 330, 0);
      register_create_script_arrays("mp_euphrates_create_script", "mp_euphrates_create_script", scripts\mp\trials\mp_euphrates_create_script::main);
      create_trial_weapon_spawn((428, -176, 38), (278, 360, 90), "trial_variant_sniper", "trial_starting_weapon", "iw8_pi_cpapa");
      create_trial_weapon_spawn((428, -176, 38), (278, 360, 90), "trial_variant_sniper", "outline", "iw8_sn_delta+barshort+vzscope+ammomod_impact");
      create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), "trial_variant_pistol", "trial_starting_weapon", "iw8_knife");
      create_trial_weapon_spawn((480.5, -105.5, 58.5), (17, 90, 6), "trial_variant_pistol", "outline", "iw8_pi_decho+trigcust02+xmags+barlong+brake+acog3");
      level.trial_use_headicon = 1;
      thread target_remap_key_value_pairs();
      break;
    case "gun_nonlinear":
      spawner = spawnStruct();
      spawner.origin = (388, 712, 28);
      spawner.angles = (0, 218, 0);
      register_create_script_arrays("mp_euphrates_create_script_gunnonlinear", "mp_euphrates_create_script_gunnonlinear", scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::main);
      create_trial_weapon_spawn((-81.47, 604.373, 47.9761), (358.504, 182.354, 90.2531), "trial_variant_pickup", "osp", "iw8_pi_cpapa+custscope_cpapa+barlong_cpapa+pistolgrip_pstl04_cpapa");
      create_trial_weapon_spawn((493.53, -167.877, 54), (358.5, 8, 0), "trial_variant_pickup", "osp", "iw8_ar_mike4+barlong_mike4+stocks_mike4+calcust_mike4_50+snprscope_mike14_ar+gunperk_semi+silencerbalanced+bipod");
      create_trial_weapon_spawn((16.53, -987.627, 47.726), (0, 211, 90), "trial_variant_pickup", "osp", "iw8_sh_charlie725+barlong_charlie725+slugs_charlie725+custscope_charlie725+silencerbalancedshtgn_charlie725");
      create_trial_weapon_spawn((596.53, -1595.63, 47.7261), (0, 0, -90), "trial_variant_pickup", "osp", "iw8_sn_kilo98+barshort_kilo98+stockl_kilo98+snprscope_kilo98");
      _id_25B3DB8E2BA2CE96[0] = spawn("script_model", (-80, 568, 15));
      _id_25B3DB8E2BA2CE96[1] = spawn("script_model", (-80, 600, 15));
      _id_25B3DB8E2BA2CE96[2] = spawn("script_model", (18, -1016, 15));
      _id_25B3DB8E2BA2CE96[3] = spawn("script_model", (18, -984, 15));
      _id_25B3DB8E2BA2CE96[4] = spawn("script_model", (594, -1624, 15));
      _id_25B3DB8E2BA2CE96[5] = spawn("script_model", (594, -1592, 15));
      _id_25B3DB8E2BA2CE96[6] = spawn("script_model", (499, -177, 15));
      _id_25B3DB8E2BA2CE96[7] = spawn("script_model", (499, -145, 15));
      _id_25B3DB8E2BA2CE96[8] = spawn("script_model", (548, -514, 15));
      _id_25B3DB8E2BA2CE96[9] = spawn("script_model", (548, -482, 15));
      _id_25B3DB8E2BA2CE96[10] = spawn("script_model", (548, -482, 24));
      _id_25B3DB8E2BA2CE96[11] = spawn("script_model", (548, -514, 32));
      _id_25B3DB8E2BA2CE96[12] = spawn("script_model", (524, -514, 32));
      _id_25B3DB8E2BA2CE96[13] = spawn("script_model", (524, -514, 15));
      _id_25B3DB8E2BA2CE96[14] = spawn("script_model", (524, -482, 24));
      _id_25B3DB8E2BA2CE96[15] = spawn("script_model", (524, -482, 15));
      _id_25B3DB8E2BA2CE96[16] = spawn("script_model", (-12, -542, 32));
      _id_25B3DB8E2BA2CE96[17] = spawn("script_model", (-12, -542, 15));
      _id_25B3DB8E2BA2CE96[18] = spawn("script_model", (-12, -510, 24));
      _id_25B3DB8E2BA2CE96[19] = spawn("script_model", (-12, -510, 15));
      _id_25B3DB8E2BA2CE96[20] = spawn("script_model", (-36, -542, 32));
      _id_25B3DB8E2BA2CE96[21] = spawn("script_model", (-36, -542, 15));
      _id_25B3DB8E2BA2CE96[22] = spawn("script_model", (-36, -510, 24));
      _id_25B3DB8E2BA2CE96[23] = spawn("script_model", (-36, -510, 15));
      _id_25B3DB8E2BA2CE96[24] = spawn("script_model", (568, -1691, 24));
      _id_25B3DB8E2BA2CE96[25] = spawn("script_model", (568, -1691, 15));
      _id_25B3DB8E2BA2CE96[26] = spawn("script_model", (568, -1723, 32));
      _id_25B3DB8E2BA2CE96[27] = spawn("script_model", (568, -1723, 15));
      _id_25B3DB8E2BA2CE96[28] = spawn("script_model", (592, -1691, 24));
      _id_25B3DB8E2BA2CE96[29] = spawn("script_model", (592, -1691, 15));
      _id_25B3DB8E2BA2CE96[30] = spawn("script_model", (592, -1723, 32));
      _id_25B3DB8E2BA2CE96[31] = spawn("script_model", (592, -1723, 15));
      _id_25B3DB8E2BA2CE96[32] = spawn("script_model", (-55, 699, 24));
      _id_25B3DB8E2BA2CE96[33] = spawn("script_model", (-55, 699, 15));
      _id_25B3DB8E2BA2CE96[34] = spawn("script_model", (-55, 667, 32));
      _id_25B3DB8E2BA2CE96[35] = spawn("script_model", (-55, 667, 15));
      _id_25B3DB8E2BA2CE96[36] = spawn("script_model", (-79, 699, 24));
      _id_25B3DB8E2BA2CE96[37] = spawn("script_model", (-79, 699, 15));
      _id_25B3DB8E2BA2CE96[38] = spawn("script_model", (-79, 667, 32));
      _id_25B3DB8E2BA2CE96[39] = spawn("script_model", (-79, 667, 15));
      _id_ED5B157AE957AA5D[0] = spawn("script_model", (535, -491, 14));
      _id_ED5B157AE957AA5D[1] = spawn("script_model", (-25, -518, 12));
      _id_ED5B157AE957AA5D[2] = spawn("script_model", (579, -1699, 12));
      _id_ED5B157AE957AA5D[3] = spawn("script_model", (-68, 691, 12));
      thread mp_euphrates_gunnonlinear_opendoor();
      thread target_remap_key_value_pairs();
      break;
    case "race":
      spawner = spawnStruct();
      spawner.origin = (2430, -1939, -102);
      spawner.angles = (0, 68, 0);
      create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
      register_create_script_arrays("mp_trl_create_a_script_race_euphrates", "mp_t_euphrates_race_trial", scripts\mp\trials\mp_trl_create_a_script_race_euphrates::main);
      _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
      _id_D8D2858BF9F87EF7 = [];
      _id_D8D2858BF9F87EF7[0] = spawn("script_model", (-346, -819, -290));
      _id_D8D2858BF9F87EF7[0].angles = (0, 37, 0);
      _id_D8D2858BF9F87EF7[1] = spawn("script_model", (-1829, -1039, -267));
      _id_D8D2858BF9F87EF7[1].angles = (0, 29, 0);
      _id_D8D2858BF9F87EF7[2] = spawn("script_model", (-1945, -1113, -248));
      _id_D8D2858BF9F87EF7[2].angles = (0, 19, 0);
      _id_D8D2858BF9F87EF7[3] = spawn("script_model", (-2006, -1133, -246));
      _id_D8D2858BF9F87EF7[3].angles = (0, 19, 0);
      _id_D8D2858BF9F87EF7[4] = spawn("script_model", (-2048, -1158, -255));
      _id_D8D2858BF9F87EF7[4].angles = (0, 45, 0);
      _id_D8D2858BF9F87EF7[5] = spawn("script_model", (-2266, -989, -256));
      _id_D8D2858BF9F87EF7[5].angles = (0, 2, 0);
      _id_D8D2858BF9F87EF7[6] = spawn("script_model", (-2331, -989, -256));
      _id_D8D2858BF9F87EF7[6].angles = (0, 2, 0);
      _id_D8D2858BF9F87EF7[7] = spawn("script_model", (-2398, -989, -264));
      _id_D8D2858BF9F87EF7[7].angles = (0, 0, 0);
      _id_D8D2858BF9F87EF7[8] = spawn("script_model", (-1858, -153, -264));
      _id_D8D2858BF9F87EF7[8].angles = (0, 333, 0);
      _id_D8D2858BF9F87EF7[9] = spawn("script_model", (-1915, -124, -264));
      _id_D8D2858BF9F87EF7[9].angles = (0, 333, 0);
      _id_D8D2858BF9F87EF7[10] = spawn("script_model", (-1972, -95, -264));
      _id_D8D2858BF9F87EF7[10].angles = (0, 333, 0);
      _id_D8D2858BF9F87EF7[11] = spawn("script_model", (-2092, -45, -276));
      _id_D8D2858BF9F87EF7[11].angles = (0, 318, 0);
      _id_D8D2858BF9F87EF7[12] = spawn("script_model", (-2135, -93, -276));
      _id_D8D2858BF9F87EF7[12].angles = (0, 318, 0);
      _id_D8D2858BF9F87EF7[13] = spawn("script_model", (-2185, -48, -276));
      _id_D8D2858BF9F87EF7[13].angles = (0, 318, 0);
      _id_D8D2858BF9F87EF7[14] = spawn("script_model", (-2199, 14, -269));
      _id_D8D2858BF9F87EF7[14].angles = (0, 285, 0);
      _id_D8D2858BF9F87EF7[15] = spawn("script_model", (-2208, 47, -269));
      _id_D8D2858BF9F87EF7[15].angles = (0, 285, 0);
      _id_D8D2858BF9F87EF7[16] = spawn("script_model", (-2278, 80, -269));
      _id_D8D2858BF9F87EF7[16].angles = (0, 343, 0);
      _id_D8D2858BF9F87EF7[17] = spawn("script_model", (-2340, 98, -269));
      _id_D8D2858BF9F87EF7[17].angles = (0, 343, 0);
      _id_D8D2858BF9F87EF7[18] = spawn("script_model", (-3508, 987, -159));
      _id_D8D2858BF9F87EF7[18].angles = (0, 332, 0);
      _id_D8D2858BF9F87EF7[19] = spawn("script_model", (-198, -1276, -283));
      _id_D8D2858BF9F87EF7[19].angles = (0, 15, 0);
      _id_D8D2858BF9F87EF7[20] = spawn("script_model", (-214, -1214, -283));
      _id_D8D2858BF9F87EF7[20].angles = (0, 15, 0);
      _id_D8D2858BF9F87EF7[21] = spawn("script_model", (-220, -1145, -277));
      _id_D8D2858BF9F87EF7[21].angles = (0, 356, 0);
      _id_D8D2858BF9F87EF7[22] = spawn("script_model", (-216, -1080, -277));
      _id_D8D2858BF9F87EF7[22].angles = (0, 356, 0);
      _id_D8D2858BF9F87EF7[23] = spawn("script_model", (-1887, -1071, -267));
      _id_D8D2858BF9F87EF7[23].angles = (0, 29, 0);
      _id_D8D2858BF9F87EF7[24] = spawn("script_model", (-2095, -1203, -253));
      _id_D8D2858BF9F87EF7[24].angles = (0, 45, 0);
      _id_D8D2858BF9F87EF7[26] = spawn("script_model", (-1242, 1102, -231));
      _id_D8D2858BF9F87EF7[26].angles = (0, 70, 0);
      _id_D8D2858BF9F87EF7[27] = spawn("script_model", (-1181, 1080, -231));
      _id_D8D2858BF9F87EF7[27].angles = (0, 70, 0);
      _id_D8D2858BF9F87EF7[28] = spawn("script_model", (-1061, 673, -231));
      _id_D8D2858BF9F87EF7[28].angles = (0, 25, 0);
      _id_D8D2858BF9F87EF7[29] = spawn("script_model", (-1090, 736, -231));
      _id_D8D2858BF9F87EF7[29].angles = (0, 25, 0);
      _id_D8D2858BF9F87EF7[30] = spawn("script_model", (2501, -631, -248));
      _id_D8D2858BF9F87EF7[30].angles = (0, 54.5, 0);
      _id_D8D2858BF9F87EF7[31] = spawn("script_model", (2443, -590, -248));
      _id_D8D2858BF9F87EF7[31].angles = (0, 54.5, 0);
      _id_D8D2858BF9F87EF7[32] = spawn("script_model", (3060, -928, -212));
      _id_D8D2858BF9F87EF7[32].angles = (0, 70, 0);
      _id_D8D2858BF9F87EF7[33] = spawn("script_model", (3127, -952, -212));
      _id_D8D2858BF9F87EF7[33].angles = (0, 70, 0);
      _id_D8D2858BF9F87EF7[34] = spawn("script_model", (-1563, 1033, -231));
      _id_D8D2858BF9F87EF7[34].angles = (0, 340, 0);
      _id_D8D2858BF9F87EF7[35] = spawn("script_model", (-1539, 1099, -231));
      _id_D8D2858BF9F87EF7[35].angles = (0, 340, 0);
      _id_D8D2858BF9F87EF7[36] = spawn("script_model", (-2441, -809, -291));
      _id_D8D2858BF9F87EF7[36].angles = (0, 0, 0);
      _id_D8D2858BF9F87EF7[37] = spawn("script_model", (-2505, -811, -291));
      _id_D8D2858BF9F87EF7[37].angles = (0, 0, 0);
      _id_D8D2858BF9F87EF7[38] = spawn("script_model", (-2769, -334, -269));
      _id_D8D2858BF9F87EF7[38].angles = (0, 307, 0);
      _id_D8D2858BF9F87EF7[39] = spawn("script_model", (-2509, -289, -281));
      _id_D8D2858BF9F87EF7[39].angles = (0, 275, 0);
      _id_D8D2858BF9F87EF7[40] = spawn("script_model", (-2515, -226, -281));
      _id_D8D2858BF9F87EF7[40].angles = (0, 275, 0);
      _id_D8D2858BF9F87EF7[41] = spawn("script_model", (-2834, -284, -281));
      _id_D8D2858BF9F87EF7[41].angles = (0, 322, 0);
      _id_D8D2858BF9F87EF7[42] = spawn("script_model", (-2884, -246, -281));
      _id_D8D2858BF9F87EF7[42].angles = (0, 322, 0);
      _id_D8D2858BF9F87EF7[43] = spawn("script_model", (-3502, 803, -144));
      _id_D8D2858BF9F87EF7[43].angles = (0, 275, 0);
      _id_D8D2858BF9F87EF7[44] = spawn("script_model", (-3437, 1054, -158));
      _id_D8D2858BF9F87EF7[44].angles = (0, 315, 0);
      _id_D8D2858BF9F87EF7[45] = spawn("script_model", (-1204, -249, -268));
      _id_D8D2858BF9F87EF7[45].angles = (0, 268, 0);
      _id_D8D2858BF9F87EF7[46] = spawn("script_model", (-2336, 275, -230));
      _id_D8D2858BF9F87EF7[46].angles = (0, 268, 0);
      _id_D8D2858BF9F87EF7[47] = spawn("script_model", (-2343, 339, -230));
      _id_D8D2858BF9F87EF7[47].angles = (0, 268, 0);
      _id_D8D2858BF9F87EF7[48] = spawn("script_model", (115, -1789, -247));
      _id_D8D2858BF9F87EF7[48].angles = (0, 275, 0);

      foreach(_id_F90358454413407F in _id_D8D2858BF9F87EF7)
      _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

      _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
      _id_88619ED98D390BDB = [];
      _id_88619ED98D390BDB[23] = spawn("script_model", (1426, -1755, -59));
      _id_88619ED98D390BDB[23].angles = (340, 0, 0);
      _id_88619ED98D390BDB[24] = spawn("script_model", (1306, -1755, -102));
      _id_88619ED98D390BDB[24].angles = (340, 0, 0);
      _id_88619ED98D390BDB[25] = spawn("script_model", (1158, -1755, -149));
      _id_88619ED98D390BDB[25].angles = (340, 0, 0);
      _id_88619ED98D390BDB[26] = spawn("script_model", (1068, -1755, -182));
      _id_88619ED98D390BDB[26].angles = (340, 0, 0);
      _id_88619ED98D390BDB[27] = spawn("script_model", (948, -1755, -226));
      _id_88619ED98D390BDB[27].angles = (340, 0, 0);

      foreach(_id_F90358454413407F in _id_88619ED98D390BDB)
      _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

      break;
    default:
      spawner = spawnStruct();
      spawner.origin = (0, 0, 0);
      spawner.angles = (0, 0, 0);
      weapons = [];
      break;
  }

  _id_87890A761838B95F = getEnt("clip32x32x32", "targetname");

  foreach(_id_F90358454413407F in _id_25B3DB8E2BA2CE96)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_87890A761838B95F);

  _id_D768B0D538D3EE63 = getEnt("tactical_cover_col", "targetname");

  foreach(_id_F90358454413407F in _id_ED5B157AE957AA5D)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_D768B0D538D3EE63);

  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", spawner.origin, spawner.angles);
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
}

mp_euphrates_gunnonlinear_opendoor() {
  level waittill("course_started");
  doors = getentitylessscriptablearray("scriptable_scriptable_door_metal_panel_03_left_mp", "classname");
  door = scripts\engine\utility::getclosest((1876, -1397, -56), doors, 10);
  door scriptabledooropen();

  foreach(_id_F7806D4CF24AACD3 in doors) {}
}

mp_piccadilly_patch(_id_8E003FDA6A2C258F) {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-2666, 390, 198), (0, 45, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);

  if(_id_8E003FDA6A2C258F == "pistol") {
    _id_039E9DDC1C25AD20 = (0, 0, 0);
    _id_DBDFBCB794B9185A = (0, 0, 0);
    weapon = spawn("script_origin", _id_039E9DDC1C25AD20);
    weapon.angles = _id_DBDFBCB794B9185A;
    weapon.targetname = "trial_weapon";
    weapon.script_noteworthy = "trial_starting_weapon";
    weapon.script_parameters = "iw8_pi_decho";
  }

  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_887DDA7C1841F51B = spawn("script_model", (-2510.15, 508.249, 237));
  _id_887DDA7C1841F51B.angles = (90, 225, 0);
  _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
  _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_0E05FDBC2B05C5E4 = spawn("script_model", (-2549.75, 547.847, 237));
  _id_0E05FDBC2B05C5E4.angles = (90, 225, 0);
  _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
  _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_F2F3E4D8F2851C37 = [];
  _id_F2F3E4D8F2851C37[0] = spawn("script_model", (-1657, -514, 253));
  _id_F2F3E4D8F2851C37[0].angles = (0, 41, -7.5);
  _id_F2F3E4D8F2851C37[1] = spawn("script_model", (-1615.5, -560.25, 261));
  _id_F2F3E4D8F2851C37[1].angles = (0, 41, -7.5);
  _id_F2F3E4D8F2851C37[2] = spawn("script_model", (-226.5, 307.5, 242.75));
  _id_F2F3E4D8F2851C37[2].angles = (0, 308, 9.5);
  _id_F2F3E4D8F2851C37[3] = spawn("script_model", (-274, 270.25, 231));
  _id_F2F3E4D8F2851C37[3].angles = (0, 308, 13);

  foreach(_id_F90358454413407F in _id_F2F3E4D8F2851C37)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

  _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
  _id_3908F68C4CE949B7 = [];
  _id_3908F68C4CE949B7[0] = spawn("script_model", (1595, 659, 128));
  _id_3908F68C4CE949B7[0].angles = (0, 348, 0);
  _id_3908F68C4CE949B7[1] = spawn("script_model", (1646, 648, 128));
  _id_3908F68C4CE949B7[1].angles = (0, 348, 0);
  _id_3908F68C4CE949B7[2] = spawn("script_model", (2237, 1303, 131));
  _id_3908F68C4CE949B7[2].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[3] = spawn("script_model", (2185, 1303, 131));
  _id_3908F68C4CE949B7[3].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[4] = spawn("script_model", (2231, 1303, 186));
  _id_3908F68C4CE949B7[4].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[5] = spawn("script_model", (-1174, 19, 137));
  _id_3908F68C4CE949B7[5].angles = (0, 330, 0);
  _id_3908F68C4CE949B7[6] = spawn("script_model", (-1947, 395, 148));
  _id_3908F68C4CE949B7[6].angles = (0, 348, 0);
  _id_3908F68C4CE949B7[7] = spawn("script_model", (-2413, 711, 148));
  _id_3908F68C4CE949B7[7].angles = (0, 354, 0);
  _id_3908F68C4CE949B7[8] = spawn("script_model", (-1636.75, -111.5, 126.25));
  _id_3908F68C4CE949B7[8].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[9] = spawn("script_model", (-1547.5, -898.75, 98.75));
  _id_3908F68C4CE949B7[9].angles = (0, 45.75, 0);
  _id_3908F68C4CE949B7[10] = spawn("script_model", (-1512.5, -862.75, 98.75));
  _id_3908F68C4CE949B7[10].angles = (0, 45.75, 0);
  _id_3908F68C4CE949B7[11] = spawn("script_model", (-1512.5, -862.75, 153.75));
  _id_3908F68C4CE949B7[11].angles = (0, 45.75, 0);
  _id_3908F68C4CE949B7[12] = spawn("script_model", (-254.25, 285, 127));
  _id_3908F68C4CE949B7[12].angles = (0, 343, 0);
  _id_3908F68C4CE949B7[13] = spawn("script_model", (-254.25, 285, 181.75));
  _id_3908F68C4CE949B7[13].angles = (0, 301, 0);
  _id_3908F68C4CE949B7[14] = spawn("script_model", (-577, 89.5, 127));
  _id_3908F68C4CE949B7[14].angles = (0, 343, 0);
  _id_3908F68C4CE949B7[15] = spawn("script_model", (-1093, -408.5, 111));
  _id_3908F68C4CE949B7[15].angles = (-4, 111, 0);
  _id_3908F68C4CE949B7[16] = spawn("script_model", (-1112.5, -362.25, 114.25));
  _id_3908F68C4CE949B7[16].angles = (-4, 111, 0);
  _id_3908F68C4CE949B7[17] = spawn("script_model", (-1111, -365, 169));
  _id_3908F68C4CE949B7[17].angles = (-4, 111, 0);

  foreach(_id_F90358454413407F in _id_3908F68C4CE949B7)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);

  _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
  _id_4EB850D95C514C5B = [];
  _id_4EB850D95C514C5B[0] = spawn("script_model", (-2705.31, 330.059, 217));
  _id_4EB850D95C514C5B[0].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[1] = spawn("script_model", (-2727.94, 352.686, 217));
  _id_4EB850D95C514C5B[1].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[2] = spawn("script_model", (-2705.31, 330.059, 153));
  _id_4EB850D95C514C5B[2].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[3] = spawn("script_model", (-2727.94, 352.686, 153));
  _id_4EB850D95C514C5B[3].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[4] = spawn("script_model", (-2671.37, 341.372, 133));
  _id_4EB850D95C514C5B[4].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[5] = spawn("script_model", (-2631.77, 392.284, 133));
  _id_4EB850D95C514C5B[5].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[6] = spawn("script_model", (-2586.52, 437.539, 133));
  _id_4EB850D95C514C5B[6].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[7] = spawn("script_model", (-2541.26, 482.793, 133));
  _id_4EB850D95C514C5B[7].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[8] = spawn("script_model", (-2575.21, 516.734, 133));
  _id_4EB850D95C514C5B[8].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[9] = spawn("script_model", (-2620.46, 471.48, 133));
  _id_4EB850D95C514C5B[9].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[10] = spawn("script_model", (-2665.72, 426.225, 133));
  _id_4EB850D95C514C5B[10].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[11] = spawn("script_model", (-2705.31, 375.314, 133));
  _id_4EB850D95C514C5B[11].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[12] = spawn("script_model", (-2496.01, 528.048, 133));
  _id_4EB850D95C514C5B[12].angles = (0, 225, 0);
  _id_4EB850D95C514C5B[13] = spawn("script_model", (-2529.95, 561.989, 133));
  _id_4EB850D95C514C5B[13].angles = (0, 225, 0);

  foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

  _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
  _id_C665700AAD2CBF97 = [];
  _id_C665700AAD2CBF97[0] = spawn("script_model", (-2609.15, 516.735, 221));
  _id_C665700AAD2CBF97[0].angles = (0, 230, 90);
  _id_C665700AAD2CBF97[1] = spawn("script_model", (-2699.66, 426.225, 221));
  _id_C665700AAD2CBF97[1].angles = (0, 230, 90);
  _id_C665700AAD2CBF97[2] = spawn("script_model", (-2626.12, 352.686, 221));
  _id_C665700AAD2CBF97[2].angles = (0, 230, 90);
  _id_C665700AAD2CBF97[3] = spawn("script_model", (-2535.61, 443.195, 221));
  _id_C665700AAD2CBF97[3].angles = (0, 230, 90);

  foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

  _id_B096CCC1A2F2D643 = [];
  _id_B096CCC1A2F2D643[0] = spawn("script_model", (-2704.97, 386.971, 277));
  _id_B096CCC1A2F2D643[0].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[1] = spawn("script_model", (-2660.06, 431.882, 277));
  _id_B096CCC1A2F2D643[1].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[2] = spawn("script_model", (-2614.8, 477.137, 277));
  _id_B096CCC1A2F2D643[2].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[3] = spawn("script_model", (-2569.55, 522.391, 277));
  _id_B096CCC1A2F2D643[3].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[4] = spawn("script_model", (-2535.61, 488.45, 277));
  _id_B096CCC1A2F2D643[4].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[5] = spawn("script_model", (-2580.86, 443.195, 277));
  _id_B096CCC1A2F2D643[5].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[6] = spawn("script_model", (-2626.12, 397.941, 277));
  _id_B096CCC1A2F2D643[6].angles = (0, 225, 0);
  _id_B096CCC1A2F2D643[7] = spawn("script_model", (-2671.03, 353.029, 277));
  _id_B096CCC1A2F2D643[7].angles = (0, 225, 0);

  foreach(_id_F90358454413407F in _id_B096CCC1A2F2D643)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

  _id_44F8C91AB1B69E5D = getEnt("mantle64", "targetname");
  _id_D3C7396CDFF37BE5 = [];
  _id_D3C7396CDFF37BE5[1] = spawn("script_model", (-1598.5, -580.75, 273));
  _id_D3C7396CDFF37BE5[1].angles = (0, 41, -7.5);
  _id_D3C7396CDFF37BE5[2] = spawn("script_model", (-2550, 582, 197));
  _id_D3C7396CDFF37BE5[2].angles = (0, 45, 0);
  _id_D3C7396CDFF37BE5[3] = spawn("script_model", (-2475, 508, 197));
  _id_D3C7396CDFF37BE5[3].angles = (0, 45, 0);
  _id_D3C7396CDFF37BE5[4] = spawn("script_model", (-2475, 548, 197));
  _id_D3C7396CDFF37BE5[4].angles = (0, 135, 0);
  _id_D3C7396CDFF37BE5[5] = spawn("script_model", (-2510, 583, 197));
  _id_D3C7396CDFF37BE5[5].angles = (0, 135, 0);
  _id_D3C7396CDFF37BE5[6] = spawn("script_model", (-258, 247, 239));
  _id_D3C7396CDFF37BE5[6].angles = (13, 218, 0);
  _id_D3C7396CDFF37BE5[7] = spawn("script_model", (-296.75, 252, 233));
  _id_D3C7396CDFF37BE5[7].angles = (0, 308, 13);
  _id_D3C7396CDFF37BE5[8] = spawn("script_model", (-293, 291, 239.25));
  _id_D3C7396CDFF37BE5[8].angles = (13, 218, 0);
  _id_D3C7396CDFF37BE5[9] = spawn("script_model", (-1858.5, 139.75, 179));
  _id_D3C7396CDFF37BE5[9].angles = (0, 352, 0);
  _id_D3C7396CDFF37BE5[10] = spawn("script_model", (-1798.5, 123.5, 179));
  _id_D3C7396CDFF37BE5[10].angles = (0, 338, 0);
  _id_D3C7396CDFF37BE5[11] = spawn("script_model", (-1745, 92.75, 179));
  _id_D3C7396CDFF37BE5[11].angles = (0, 323, 0);
  _id_D3C7396CDFF37BE5[12] = spawn("script_model", (-1706, 52.75, 179));
  _id_D3C7396CDFF37BE5[12].angles = (0, 307.5, 0);
  _id_D3C7396CDFF37BE5[13] = spawn("script_model", (-1676.75, 4, 179));
  _id_D3C7396CDFF37BE5[13].angles = (0, 296, 0);
  _id_D3C7396CDFF37BE5[14] = spawn("script_model", (-1661.25, -50, 179));
  _id_D3C7396CDFF37BE5[14].angles = (0, 279, 0);
  _id_D3C7396CDFF37BE5[15] = spawn("script_model", (-1863, 129.75, 179));
  _id_D3C7396CDFF37BE5[15].angles = (0, 352, 0);
  _id_D3C7396CDFF37BE5[16] = spawn("script_model", (-1803, 113.5, 179));
  _id_D3C7396CDFF37BE5[16].angles = (0, 338, 0);
  _id_D3C7396CDFF37BE5[17] = spawn("script_model", (-1749.5, 82.75, 179));
  _id_D3C7396CDFF37BE5[17].angles = (0, 323, 0);
  _id_D3C7396CDFF37BE5[18] = spawn("script_model", (-1710.5, 42.75, 179));
  _id_D3C7396CDFF37BE5[18].angles = (0, 307.5, 0);
  _id_D3C7396CDFF37BE5[19] = spawn("script_model", (-1681.25, -6, 179));
  _id_D3C7396CDFF37BE5[19].angles = (0, 296, 0);
  _id_D3C7396CDFF37BE5[20] = spawn("script_model", (-1665.75, -60, 179));
  _id_D3C7396CDFF37BE5[20].angles = (0, 279, 0);
  _id_D3C7396CDFF37BE5[23] = spawn("script_model", (979.75, 113, 187.75));
  _id_D3C7396CDFF37BE5[23].angles = (0, 307.5, 0);
  _id_D3C7396CDFF37BE5[24] = spawn("script_model", (1269.75, 304.25, 207));
  _id_D3C7396CDFF37BE5[24].angles = (0, 305.5, 0);

  foreach(_id_F90358454413407F in _id_D3C7396CDFF37BE5)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_44F8C91AB1B69E5D, 1);
}

mp_m_overunder_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (551, 968, 16), (0, 223, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((596.712, 826.265, 52.7056), (38.4733, 358.746, -0.96607), "trial_variant_fast", undefined, "iw8_pi_golf21+reflexmini2+pistolgrip02+trigcust02+laserrange+barshort");
  create_trial_weapon_spawn((597.505, 827.286, 44), (18.2161, 358.831, -0.784065), "trial_variant_fast", undefined, "iw8_pi_mike1911+laserrange+pistolgrip02+barshort+trigcust+xmags");
  create_trial_weapon_spawn((577.046, 826.312, 56.4861), (285.713, 224.755, -46.9075), "trial_variant_fast", undefined, "iw8_lm_mgolf36+stockl+silencer2+calcust+gripang+barmid");
  create_trial_weapon_spawn((563.626, 828.726, 57.2361), (282.486, 330.676, 28.8378), "trial_variant_fast", undefined, "iw8_ar_mike4+holo3+laserbalanced+pistolgrip02+gripang+barmid");
  create_trial_weapon_spawn((550.079, 827.501, 57.7261), (287.752, 230.356, -51.1188), "trial_variant_fast", undefined, "iw8_ar_akilo47+gripang+laserbalanced+pistolgrip02+stockl+fastreload");
  create_trial_weapon_spawn((522.533, 827.936, 61.0601), (292.978, 316.954, 43.057), "trial_variant_fast", undefined, "iw8_ar_scharlie+silencer2+xmagslrg+pistolgrip02+stocks+barshort");
  create_trial_weapon_spawn((505.864, 827.979, 58.6132), (284.965, 252.173, -72.7305), "trial_variant_fast", undefined, "iw8_ar_tango21+silencer2+holo3+pistolgrip01+stockl+barshort");
  create_trial_weapon_spawn((487.901, 827.433, 58.9761), (282.94, 247.059, -67.6423), "trial_variant_fast", undefined, "iw8_ar_falima+barshort+stockl+gripang+xmagslrg+fastreload");
  create_trial_weapon_spawn((-255, 307, 44.5), (277, 271, 90), "trial_variant_pickup", "osp", "iw8_ar_falima+barshort+stockl+gripang+fastreload");
  create_trial_weapon_spawn((0, 655, 47), (0, 0, 0), "trial_variant_pickup", "osp", "iw8_pi_golf21+reflexmini2+pistolgrip02+trigcust02+laserrange+barshort");
  create_trial_weapon_spawn((130.25, 97.75, 49.7261), (0, 0, 0), "trial_variant_pickup", "osp", "iw8_ar_akilo47+pistolgrip02+gripang+calsmg+stockl+barshortnoguard");
  create_trial_weapon_spawn((224.5, -280.5, 46.75), (0, 90, 0), "trial_variant_pickup", "osp", "iw8_sn_mike14+comp+gripang+pistolgrip03+fastreload+xmagslrg");
  create_trial_weapon_spawn((-365.75, -279.75, 11.5), (286, 186, 90), "trial_variant_pickup", "osp", "iw8_ar_mike4+barshort+pistolgrip02+holo+stocks+silencer2");
  _id_7C287B9BC0721912 = getEnt("clip64x64x8", "targetname");
  _id_DA592E99D82F0C0F = getEnt("clip64x64x256", "targetname");
  _id_49A5BB4F4DCFF867 = spawn("script_model", (-393, 990.25, 177.5));
  _id_49A5BB4F4DCFF867.angles = (270, 0, 0);
  _id_49A5BB4F4DCFF867 clonebrushmodeltoscriptmodel(_id_7C287B9BC0721912);
  _id_49A5BC4F4DCFFA9A = spawn("script_model", (-393, 936.5, 177.5));
  _id_49A5BC4F4DCFFA9A.angles = (270, 0, 0);
  _id_49A5BC4F4DCFFA9A clonebrushmodeltoscriptmodel(_id_7C287B9BC0721912);
  _id_49A5BD4F4DCFFCCD = spawn("script_model", (-393, 911.5, 177.5));
  _id_49A5BD4F4DCFFCCD.angles = (270, 0, 0);
  _id_49A5BD4F4DCFFCCD clonebrushmodeltoscriptmodel(_id_7C287B9BC0721912);
  _id_49A5B64F4DCFED68 = spawn("script_model", (-287.75, 321.5, 177.5));
  _id_49A5B64F4DCFED68.angles = (270, 0, 0);
  _id_49A5B64F4DCFED68 clonebrushmodeltoscriptmodel(_id_7C287B9BC0721912);
  _id_49A5B74F4DCFEF9B = spawn("script_model", (-287.75, 288.5, 177.5));
  _id_49A5B74F4DCFEF9B.angles = (270, 0, 0);
  _id_49A5B74F4DCFEF9B clonebrushmodeltoscriptmodel(_id_7C287B9BC0721912);
  _id_49A5B84F4DCFF1CE = spawn("script_model", (325, 838, 0));
  _id_49A5B84F4DCFF1CE.angles = (0, 346.838, 0);
  _id_49A5B84F4DCFF1CE clonebrushmodeltoscriptmodel(_id_DA592E99D82F0C0F);
  _id_49A5B94F4DCFF401 = spawn("script_model", (317.5, 827.5, 0));
  _id_49A5B94F4DCFF401.angles = (0, 337.959, 0);
  _id_49A5B94F4DCFF401 clonebrushmodeltoscriptmodel(_id_DA592E99D82F0C0F);
  _id_49A5B24F4DCFE49C = spawn("script_model", (574.25, 773.75, 0));
  _id_49A5B24F4DCFE49C.angles = (0, 0, 0);
  _id_49A5B24F4DCFE49C clonebrushmodeltoscriptmodel(_id_DA592E99D82F0C0F);
  _id_49A5B34F4DCFE6CF = spawn("script_model", (515.75, 773.75, 0));
  _id_49A5B34F4DCFE6CF.angles = (0, 0, 0);
  _id_49A5B34F4DCFE6CF clonebrushmodeltoscriptmodel(_id_DA592E99D82F0C0F);
  _id_C7734668205F2755 = spawn("script_model", (507.5, 749.25, 0));
  _id_C7734668205F2755.angles = (0, 0, 0);
  _id_C7734668205F2755 clonebrushmodeltoscriptmodel(_id_DA592E99D82F0C0F);
  _id_C7734568205F2522 = spawn("script_model", (571.5, 749.25, 0));
  _id_C7734568205F2522.angles = (0, 0, 0);
  _id_C7734568205F2522 clonebrushmodeltoscriptmodel(_id_DA592E99D82F0C0F);
}

mp_hackney_yard_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (1191, -1372, 62), (0, 154, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);

  switch (level.trial["variant"]) {
    case "knife":
      weapon_name = "iw8_knife";
      break;
    case "shield":
      weapon_name = "iw8_me_riotshield";
      break;
    case "pistol":
      weapon_name = "iw8_pi_decho";
      break;
    case "free":
      weapon_name = "iw8_knife";
      break;
    default:
      weapon_name = "iw8_pi_golf21";
      break;
  }

  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", weapon_name);
  level.trial_weapon_defined = 1;
  _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
  _id_3908F68C4CE949B7 = [];
  _id_3908F68C4CE949B7[0] = spawn("script_model", (210, -923, 18));
  _id_3908F68C4CE949B7[0].angles = (0, 45, 0);
  _id_3908F68C4CE949B7[1] = spawn("script_model", (1594, -323, 18));
  _id_3908F68C4CE949B7[1].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[2] = spawn("script_model", (1578, -707, 18));
  _id_3908F68C4CE949B7[2].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[3] = spawn("script_model", (1466, -787, 18));
  _id_3908F68C4CE949B7[3].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[4] = spawn("script_model", (1290, -763, 18));
  _id_3908F68C4CE949B7[4].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[5] = spawn("script_model", (-374, -1211, 29));
  _id_3908F68C4CE949B7[5].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[6] = spawn("script_model", (-494, 765, 17));
  _id_3908F68C4CE949B7[6].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[7] = spawn("script_model", (-214, 1277, 15));
  _id_3908F68C4CE949B7[7].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[8] = spawn("script_model", (330, 581, 18));
  _id_3908F68C4CE949B7[8].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[9] = spawn("script_model", (-323, 1618, 23));
  _id_3908F68C4CE949B7[9].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[10] = spawn("script_model", (-211, 1498, 17));
  _id_3908F68C4CE949B7[10].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[11] = spawn("script_model", (-91, 1386, 17));
  _id_3908F68C4CE949B7[11].angles = (0, 0, 0);

  foreach(_id_F90358454413407F in _id_3908F68C4CE949B7)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);

  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_887DDA7C1841F51B = spawn("script_model", (1020.19, -1258.55, 99));
  _id_887DDA7C1841F51B.angles = (89.9943, 50.4576, 75.86);
  _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
  _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_0E05FDBC2B05C5E4 = spawn("script_model", (996.16, -1309.13, 99));
  _id_0E05FDBC2B05C5E4.angles = (89.9943, 50.4576, 75.86);
  _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
  _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_B096CCC1A2F2D643 = [];
  _id_B096CCC1A2F2D643[0] = spawn("script_model", (1047.38, -1275.89, 139));
  _id_B096CCC1A2F2D643[0].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[1] = spawn("script_model", (1026.78, -1319.25, 139));
  _id_B096CCC1A2F2D643[1].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[2] = spawn("script_model", (1105.18, -1303.35, 139));
  _id_B096CCC1A2F2D643[2].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[3] = spawn("script_model", (1084.59, -1346.71, 139));
  _id_B096CCC1A2F2D643[3].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[4] = spawn("script_model", (1163, -1330.81, 139));
  _id_B096CCC1A2F2D643[4].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[5] = spawn("script_model", (1142.41, -1374.17, 139));
  _id_B096CCC1A2F2D643[5].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[6] = spawn("script_model", (1228.04, -1361.69, 139));
  _id_B096CCC1A2F2D643[6].angles = (0, 334.595, 0);
  _id_B096CCC1A2F2D643[7] = spawn("script_model", (1207.44, -1405.06, 139));
  _id_B096CCC1A2F2D643[7].angles = (0, 334.595, 0);

  foreach(_id_F90358454413407F in _id_B096CCC1A2F2D643)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

  _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
  _id_C665700AAD2CBF97 = [];
  _id_C665700AAD2CBF97[0] = spawn("script_model", (1090.01, -1260.71, 83));
  _id_C665700AAD2CBF97[0].angles = (0, 334.595, 89.9989);
  _id_C665700AAD2CBF97[1] = spawn("script_model", (1205.63, -1315.63, 83));
  _id_C665700AAD2CBF97[1].angles = (0, 334.595, 89.9989);
  _id_C665700AAD2CBF97[2] = spawn("script_model", (1045.39, -1354.66, 83));
  _id_C665700AAD2CBF97[2].angles = (0, 334.595, 89.9989);
  _id_C665700AAD2CBF97[3] = spawn("script_model", (1161.01, -1409.57, 83));
  _id_C665700AAD2CBF97[3].angles = (0, 334.595, 89.9989);

  foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

  _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
  _id_4EB850D95C514C5B = [];
  _id_4EB850D95C514C5B[0] = spawn("script_model", (996.79, -1251.87, -5));
  _id_4EB850D95C514C5B[0].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[1] = spawn("script_model", (976.198, -1295.23, -5));
  _id_4EB850D95C514C5B[1].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[2] = spawn("script_model", (1054.6, -1279.32, -5));
  _id_4EB850D95C514C5B[2].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[3] = spawn("script_model", (1034.01, -1322.68, -5));
  _id_4EB850D95C514C5B[3].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[4] = spawn("script_model", (1112.42, -1306.78, -5));
  _id_4EB850D95C514C5B[4].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[5] = spawn("script_model", (1091.82, -1350.14, -5));
  _id_4EB850D95C514C5B[5].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[6] = spawn("script_model", (1170.22, -1334.24, -5));
  _id_4EB850D95C514C5B[6].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[7] = spawn("script_model", (1149.63, -1377.59, -5));
  _id_4EB850D95C514C5B[7].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[8] = spawn("script_model", (1228.46, -1361.47, -5));
  _id_4EB850D95C514C5B[8].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[9] = spawn("script_model", (1207.87, -1404.82, -5));
  _id_4EB850D95C514C5B[9].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[10] = spawn("script_model", (1253.51, -1382.65, 15));
  _id_4EB850D95C514C5B[10].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[11] = spawn("script_model", (1239.78, -1411.56, 15));
  _id_4EB850D95C514C5B[11].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[12] = spawn("script_model", (1253.51, -1382.65, 79));
  _id_4EB850D95C514C5B[12].angles = (0, 334.595, 0);
  _id_4EB850D95C514C5B[13] = spawn("script_model", (1239.78, -1411.56, 79));
  _id_4EB850D95C514C5B[13].angles = (0, 334.595, 0);

  foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

  _id_44F8C91AB1B69E5D = getEnt("mantle64", "targetname");
  _id_D3C7396CDFF37BE5 = [];
  _id_D3C7396CDFF37BE5[0] = spawn("script_model", (950.79, -1282.87, 59));
  _id_D3C7396CDFF37BE5[0].angles = (0, 244.595, 0);
  _id_D3C7396CDFF37BE5[1] = spawn("script_model", (970.79, -1239.87, 59));
  _id_D3C7396CDFF37BE5[1].angles = (0, 244.595, 0);
  _id_D3C7396CDFF37BE5[2] = spawn("script_model", (963.79, -1320.87, 59));
  _id_D3C7396CDFF37BE5[2].angles = (0, 334.595, 0);
  _id_D3C7396CDFF37BE5[3] = spawn("script_model", (1008.79, -1225.87, 59));
  _id_D3C7396CDFF37BE5[3].angles = (0, 334.595, 0);

  foreach(_id_F90358454413407F in _id_D3C7396CDFF37BE5)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_44F8C91AB1B69E5D, 1);

  if(level.trial["variant"] == "shield")
    level.playerhastknife = 1;

  register_create_script_arrays("mp_hackney_yard_create_script", "mp_hackney_yard_trial", _id_125077A37C8F84F0::main);
}

mp_m_stack_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (960, 0, 152), (0, 180, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((803.97, 4.83, 205.7), (283.41, 238.67, 35.51), "trial_variant_shotgun", undefined, "iw8_sh_dpapa12+fmj+guardlight+barshort");
  create_trial_weapon_spawn((804.42, 15.72, 203.25), (282.84, 232.89, 37.28), "trial_variant_shotgun", undefined, "iw8_sh_romeo870+fastreload+xmags+stockh+barshort");
  create_trial_weapon_spawn((805.06, -11.8, 200.98), (283.73, 126.36, -38.79), "trial_variant_shotgun", undefined, "iw8_sh_oscar12+fmj");
  create_trial_weapon_spawn((805.17, -24.5, 195.47), (285.92, 237.26, 31.72), "trial_variant_shotgun", undefined, "iw8_sh_mike26+reflexmini+stockno+fastreload+gripvert+barmid");
  create_trial_weapon_spawn((804.51, -29.71, 205.95), (38.47, 268.74, -0.9), "trial_variant_shotgun", undefined, "iw8_pi_cpapa+barshort+pistolgrip02+fastreload+trigcust+calcust2");
  create_trial_weapon_spawn((801.56, -15.55, 221.23), (350.4, 89.83, -4.89), "trial_variant_shotgun", undefined, "iw8_sh_charlie725+guardheavy+fastreload+stockno+barshort");
  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_B096CCC1A2F2D643 = [];
  _id_B096CCC1A2F2D643[0] = spawn("script_model", (812.5, -6.5, 209.25));
  _id_B096CCC1A2F2D643[0].angles = (270, 0, 0);
  _id_B096CCC1A2F2D643[1] = spawn("script_model", (804.75, -6.5, 209.25));
  _id_B096CCC1A2F2D643[1].angles = (270, 0, 0);
  _id_B096CCC1A2F2D643[2] = spawn("script_model", (812.5, -6.5, 173.75));
  _id_B096CCC1A2F2D643[2].angles = (270, 0, 0);
  _id_B096CCC1A2F2D643[3] = spawn("script_model", (804.75, -6.5, 173.75));
  _id_B096CCC1A2F2D643[3].angles = (270, 0, 0);

  foreach(_id_F90358454413407F in _id_B096CCC1A2F2D643)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

  _id_0AE514B31D5FC294 = getEnt("clip256x256x8", "targetname");
  _id_CBBA18DA7AF2B0B3 = [];
  _id_CBBA18DA7AF2B0B3[0] = spawn("script_model", (929.25, 191.75, 209.25));
  _id_CBBA18DA7AF2B0B3[0].angles = (90, 90, 0);
  _id_CBBA18DA7AF2B0B3[1] = spawn("script_model", (929.25, -198.5, 209.25));
  _id_CBBA18DA7AF2B0B3[1].angles = (90, 90, 0);

  foreach(_id_F90358454413407F in _id_CBBA18DA7AF2B0B3)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0AE514B31D5FC294);
}

mp_m_king_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-1096, 0, 16), (0, 0, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((-982, 85.5, 72.5), (33.6, 127, 0), "trial_variant_fast", undefined, "iw8_pi_mike9+fastreload+reflexmini+trigcust02+pistolgrip02+barshort");
  create_trial_weapon_spawn((-991.6, 98.5, 73.2), (33.6, 127, 0), "trial_variant_fast", undefined, "iw8_pi_golf21+trigcust02+laserbalanced+pistolgrip02+xmags+barshort");
  create_trial_weapon_spawn((-1001, 110, 72.5), (33.6, 127, 0), "trial_variant_fast", undefined, "iw8_pi_papa320+pistolgrip02+barmid+silencer+reflexmini2");
  create_trial_weapon_spawn((-993.7, 99.6, 65), (0, 127, 7), "trial_variant_fast", undefined, "iw8_sm_smgolf45+reflexmini3+barshort+stocks+pistolgrip02+smags");
  create_trial_weapon_spawn((-990, 91.5, 52), (0, 127, 7), "trial_variant_fast", undefined, "iw8_ar_akilo47+acog2+pistolgrip03+stockl+calsmg+barshortnoguard");

  if(scripts\mp\trials\trial_utility::trial_is_event())
    thread trial_special_vfx();

  register_create_script_arrays("mp_m_king_create_script", "mp_m_king_trial_guncourse", scripts\mp\trials\mp_m_king_create_script::main);
}

mp_harbor_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (3915.5, -2334, 236.5), (0, 104, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_887DDA7C1841F51B = spawn("script_model", (3844.75, -2172.25, 278.75));
  _id_887DDA7C1841F51B.angles = (270.6, 350, -62);
  _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
  _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_0E05FDBC2B05C5E4 = spawn("script_model", (3893.25, -2158.25, 278.25));
  _id_0E05FDBC2B05C5E4.angles = (270.6, 350, -62);
  _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
  _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
  _id_3908F68C4CE949B7 = [];
  _id_3908F68C4CE949B7[0] = spawn("script_model", (2841, -1100, 303));
  _id_3908F68C4CE949B7[0].angles = (0, 272.7, 0);
  _id_3908F68C4CE949B7[1] = spawn("script_model", (2636, -1408, 192));
  _id_3908F68C4CE949B7[1].angles = (0, 268, 0);
  _id_3908F68C4CE949B7[2] = spawn("script_model", (2097, -1282, 192));
  _id_3908F68C4CE949B7[2].angles = (0, 268, 0);
  _id_3908F68C4CE949B7[3] = spawn("script_model", (1954, -1208, 192));
  _id_3908F68C4CE949B7[3].angles = (0, 271, 0);
  _id_3908F68C4CE949B7[4] = spawn("script_model", (1632, -371, 295));
  _id_3908F68C4CE949B7[4].angles = (0, 271, 0);
  _id_3908F68C4CE949B7[5] = spawn("script_model", (-478, -1242, 192));
  _id_3908F68C4CE949B7[5].angles = (0, 271, 0);
  _id_3908F68C4CE949B7[6] = spawn("script_model", (1691, -425, 192));
  _id_3908F68C4CE949B7[6].angles = (0, 0, 0);
  _id_3908F68C4CE949B7[7] = spawn("script_model", (2843, -1048, 248));
  _id_3908F68C4CE949B7[7].angles = (0, 268, 0);
  _id_3908F68C4CE949B7[8] = spawn("script_model", (2793, -1048, 192));
  _id_3908F68C4CE949B7[8].angles = (0, 270.5, 0);
  _id_3908F68C4CE949B7[9] = spawn("script_model", (3803, -1392, 192));
  _id_3908F68C4CE949B7[9].angles = (0, 268, 0);
  _id_3908F68C4CE949B7[10] = spawn("script_model", (3363, -1584, 192));
  _id_3908F68C4CE949B7[10].angles = (0, 240, 0);
  _id_3908F68C4CE949B7[11] = spawn("script_model", (3536, -990, 192));
  _id_3908F68C4CE949B7[11].angles = (0, 249, 0);
  _id_3908F68C4CE949B7[12] = spawn("script_model", (699, -1219, 192));
  _id_3908F68C4CE949B7[12].angles = (0, 271, 0);

  foreach(_id_F90358454413407F in _id_3908F68C4CE949B7)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);

  register_create_script_arrays("mp_harbor_floorislava_create_script", "mp_harbor_trial_floor_is_lava", scripts\mp\trials\mp_harbor_floorislava_create_script::main);
}

mp_backlot2_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-125, 819.5, 104.5), (0, 351, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_887DDA7C1841F51B = spawn("script_model", (46.6, 772.4, 143.6));
  _id_887DDA7C1841F51B.angles = (270.6, 350, -178);
  _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
  _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_0E05FDBC2B05C5E4 = spawn("script_model", (53.6, 822.4, 143.6));
  _id_0E05FDBC2B05C5E4.angles = (270.6, 350, -178);
  _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
  _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_B096CCC1A2F2D643 = [];
  _id_B096CCC1A2F2D643[0] = spawn("script_model", (-167.25, 805.7, 195.9));
  _id_B096CCC1A2F2D643[0].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[1] = spawn("script_model", (-161.25, 847, 195.9));
  _id_B096CCC1A2F2D643[1].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[2] = spawn("script_model", (-104.25, 796.6, 195.2));
  _id_B096CCC1A2F2D643[2].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[3] = spawn("script_model", (-98.25, 838, 195.2));
  _id_B096CCC1A2F2D643[3].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[4] = spawn("script_model", (-41.05, 787.6, 194.7));
  _id_B096CCC1A2F2D643[4].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[5] = spawn("script_model", (-35.05, 829, 194.7));
  _id_B096CCC1A2F2D643[5].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[6] = spawn("script_model", (22.15, 778.7, 193.9));
  _id_B096CCC1A2F2D643[6].angles = (0.6, 351.8, -180);
  _id_B096CCC1A2F2D643[7] = spawn("script_model", (28.15, 820, 193.9));
  _id_B096CCC1A2F2D643[7].angles = (0.6, 351.8, -180);

  foreach(_id_F90358454413407F in _id_B096CCC1A2F2D643)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

  _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
  _id_C665700AAD2CBF97 = [];
  _id_C665700AAD2CBF97[0] = spawn("script_model", (-115, 764.25, 127.9));
  _id_C665700AAD2CBF97[0].angles = (0.6, 351.8, -90);
  _id_C665700AAD2CBF97[1] = spawn("script_model", (-13.75, 749.75, 126.9));
  _id_C665700AAD2CBF97[1].angles = (0.6, 351.8, -90);
  _id_C665700AAD2CBF97[2] = spawn("script_model", (-100.75, 865, 127.9));
  _id_C665700AAD2CBF97[2].angles = (0.6, 351.8, -90);
  _id_C665700AAD2CBF97[3] = spawn("script_model", (0.5, 850.5, 126.9));
  _id_C665700AAD2CBF97[3].angles = (0.6, 351.8, -90);

  foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

  _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
  _id_4EB850D95C514C5B = [];
  _id_4EB850D95C514C5B[0] = spawn("script_model", (-203.25, 810.25, 192.5));
  _id_4EB850D95C514C5B[0].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[1] = spawn("script_model", (-197, 853.75, 192.5));
  _id_4EB850D95C514C5B[1].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[2] = spawn("script_model", (-203.25, 810.25, 128));
  _id_4EB850D95C514C5B[2].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[3] = spawn("script_model", (-197, 853.75, 128));
  _id_4EB850D95C514C5B[3].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[4] = spawn("script_model", (-147.25, 802, 103.25));
  _id_4EB850D95C514C5B[4].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[5] = spawn("script_model", (-141, 845.5, 103.25));
  _id_4EB850D95C514C5B[5].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[6] = spawn("script_model", (-102.5, 795.25, 102.5));
  _id_4EB850D95C514C5B[6].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[7] = spawn("script_model", (-96.25, 838.75, 102.5));
  _id_4EB850D95C514C5B[7].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[8] = spawn("script_model", (-48.5, 787.25, 102));
  _id_4EB850D95C514C5B[8].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[9] = spawn("script_model", (-42.25, 831, 102));
  _id_4EB850D95C514C5B[9].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[10] = spawn("script_model", (13.25, 778.75, 101.5));
  _id_4EB850D95C514C5B[10].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[11] = spawn("script_model", (19.5, 822.25, 101.5));
  _id_4EB850D95C514C5B[11].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[12] = spawn("script_model", (76.25, 769.75, 101));
  _id_4EB850D95C514C5B[12].angles = (0.6, 351.8, -180);
  _id_4EB850D95C514C5B[13] = spawn("script_model", (82.25, 813.25, 101));
  _id_4EB850D95C514C5B[13].angles = (0.6, 351.8, -180);

  foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

  _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
  _id_3908F68C4CE949B7 = [];
  _id_3908F68C4CE949B7[0] = spawn("script_model", (1056, 161.5, 55.25));
  _id_3908F68C4CE949B7[0].angles = (0, 267.81, 0);
  _id_3908F68C4CE949B7[1] = spawn("script_model", (1278.5, -141.25, 60.25));
  _id_3908F68C4CE949B7[1].angles = (0, 268, 0);
  _id_3908F68C4CE949B7[2] = spawn("script_model", (-993.5, -739, 69.75));
  _id_3908F68C4CE949B7[2].angles = (358.75, 248.85, 2.35);
  _id_3908F68C4CE949B7[3] = spawn("script_model", (-219.75, 1092.25, 56.5));
  _id_3908F68C4CE949B7[3].angles = (0, 269, -2.4);
  _id_3908F68C4CE949B7[4] = spawn("script_model", (-1037.75, 794.5, 60.5));
  _id_3908F68C4CE949B7[4].angles = (3.5, 269, 0);
  _id_3908F68C4CE949B7[5] = spawn("script_model", (-532, -704, 62));
  _id_3908F68C4CE949B7[5].angles = (0, 269, 0);
  _id_3908F68C4CE949B7[6] = spawn("script_model", (-404.5, 1299, 62));
  _id_3908F68C4CE949B7[6].angles = (0, 269, 0);

  foreach(_id_F90358454413407F in _id_3908F68C4CE949B7)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);

  _id_44F8C91AB1B69E5D = getEnt("mantle64", "targetname");
  _id_D3C7396CDFF37BE5 = [];
  _id_D3C7396CDFF37BE5[0] = spawn("script_model", (86.75, 841.5, 101));
  _id_D3C7396CDFF37BE5[0].angles = (0.6, 351.8, -180);
  _id_D3C7396CDFF37BE5[1] = spawn("script_model", (110.8, 809.5, 101));
  _id_D3C7396CDFF37BE5[1].angles = (0, 261.8, -0.6);
  _id_D3C7396CDFF37BE5[2] = spawn("script_model", (104.5, 765.25, 101));
  _id_D3C7396CDFF37BE5[2].angles = (0, 261.8, -0.6);
  _id_D3C7396CDFF37BE5[3] = spawn("script_model", (72.25, 741.5, 101));
  _id_D3C7396CDFF37BE5[3].angles = (0.6, 351.8, -180);

  foreach(_id_F90358454413407F in _id_D3C7396CDFF37BE5)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_44F8C91AB1B69E5D, 1);
}

mp_vacant_patch() {
  level.trial_infinite_reserve_ammo = 1;
  glassradiusdamage((3229, 2578, 131), 128, 99999, 9999);
  glassradiusdamage((3069, 2023, 131), 128, 99999, 9999);
  glassradiusdamage((2699, 1683, 131), 128, 99999, 9999);
  thread target_remap_key_value_pairs();
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (3793, 1413, 68), (0, 240, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((3843.58, 1054.18, 124.7), (0, 205, 0), "trial_variant_default", "trial_starting_weapon", "iw8_pi_mike1911+barmid+pistolgrip01+trigcust+xmagslrg");
  create_trial_weapon_spawn((3867.43, 1063.33, 146.36), (0, 24, 0), "trial_variant_default", undefined, "iw8_ar_mcharlie+silencer2+calcust+holo3+stocks+barshort");
  create_trial_weapon_spawn((3869.86, 1065.88, 129.89), (0, 24, 0), "trial_variant_default", undefined, "iw8_sm_mpapa5+reflexmini+pistolgrip02+stockno+barshort+calcust");
  create_trial_weapon_spawn((3867.48, 1065.71, 113.6), (0, 24, 0), "trial_variant_default", undefined, "iw8_sh_dpapa12+pistolgrip03+guardcust+brake+barshort+xmags");
  create_trial_weapon_spawn((3789.69, 1044.18, 130.55), (0, 0, 0), "trial_variant_default", undefined, "iw8_ar_tango21+pistolgrip02+fmj+stockl+reflex2+barmid");
  create_trial_weapon_spawn((3786.95, 1044.11, 147.39), (0, 0, 0), "trial_variant_default", undefined, "iw8_ar_akilo47+gripangpro+pistolgrip02+stockcust+barcust");
  create_trial_weapon_spawn((3789.21, 1047.14, 112.9), (0, 0, 0), "trial_variant_default", undefined, "iw8_lm_mgolf36+laserrange+pistolgrip02+reflex5+barmid+calcust");
  create_trial_weapon_spawn((3843.58, 1054.18, 124.7), (0, 205, 0), "trial_variant_smoke", "trial_starting_weapon", "iw8_pi_mike1911+barmid+pistolgrip01+trigcust+xmagslrg+laserrange");
  create_trial_weapon_spawn((3867.43, 1063.33, 146.36), (0, 24, 0), "trial_variant_smoke", undefined, "iw8_ar_mcharlie+silencer2+calcust+holo3+stocks+barshort+laserrange");
  create_trial_weapon_spawn((3869.86, 1065.88, 129.89), (0, 24, 0), "trial_variant_smoke", undefined, "iw8_sm_mpapa5+reflexmini+pistolgrip02+stockno+barshort+calcust+laserrange");
  create_trial_weapon_spawn((3867.48, 1065.71, 113.6), (0, 24, 0), "trial_variant_smoke", undefined, "iw8_sh_dpapa12+pistolgrip03+guardcust+barshort+xmags+laserrange");
  create_trial_weapon_spawn((3789.69, 1044.18, 130.55), (0, 0, 0), "trial_variant_smoke", undefined, "iw8_ar_tango21+pistolgrip02+stockl+reflex2+barmid+laserrange");
  create_trial_weapon_spawn((3786.95, 1044.11, 147.39), (0, 0, 0), "trial_variant_smoke", undefined, "iw8_ar_akilo47+gripangpro+pistolgrip02+stockcust+barcust+laserrange");
  create_trial_weapon_spawn((3789.21, 1047.14, 112.9), (0, 0, 0), "trial_variant_smoke", undefined, "iw8_lm_mgolf36+laserrange+pistolgrip02+reflex5+barmid+calcust");
  thread target_random_models();
  thread flares_from_structs("course_started");
  thread mp_vacant_patch_thread();
}

mp_vacant_patch_thread() {
  for(;;) {
    level waittill("course_started");
    _id_5BC9236DA6605441 = getentitylessscriptablearray("scriptable_scriptable_construction_doors_metal_b_02_mp", "classname");
    _id_5BC9206DA6604DA8 = getentitylessscriptablearray("scriptable_scriptable_door_metal_single_b_02_grey", "classname");
    _id_5BC9216DA6604FDB = getentitylessscriptablearray("scriptable_scriptable_door_wooden_office_01_mp", "classname");
    doors = scripts\engine\utility::array_combine(_id_5BC9236DA6605441, _id_5BC9206DA6604DA8, _id_5BC9216DA6604FDB);

    foreach(door in doors)
    door scriptabledoorclose();
  }
}

mp_hideout_patch() {
  level.trial_infinite_reserve_ammo = 1;
  glassradiusdamage((112, -1366, 67), 128, 99999, 9999);
  glassradiusdamage((112, -1366, 185.5), 128, 99999, 9999);
  glassradiusdamage((191, -1560, 185.5), 128, 99999, 9999);
  glassradiusdamage((-1088, -951, 67), 128, 99999, 9999);
  thread target_remap_key_value_pairs();
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-98.5, 1639.25, 13), (0, 10, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((101.75, 1765, 84.5), (338.5, 130.25, 5.2), "trial_variant_fast", "trial_starting_weapon", "iw8_pi_mike1911+barmid+pistolgrip01+trigcust+xmagslrg");
  create_trial_weapon_spawn((112, 1753.25, 83.7), (347.6, 131, 5), "trial_variant_fast", undefined, "iw8_pi_mike9+fastreload");
  create_trial_weapon_spawn((120.5, 1741.75, 84), (347.6, 131, 5), "trial_variant_fast", undefined, "iw8_pi_golf21+reflexmini2+pistolgrip02+trigcust02+laserrange+barshort");
  create_trial_weapon_spawn((107.25, 1757.25, 64), (286.8, 99.23, 28), "trial_variant_fast", undefined, "iw8_sm_mpapa5+barsil2+stockl+fastreload+pistolgrip02+xmags");
  create_trial_weapon_spawn((115.75, 1746, 66.25), (286.8, 99.25, 28), "trial_variant_fast", undefined, "iw8_sm_uzulu+fastreload+stocks+pistolgrip02+barcust+xmagslrg");
  create_trial_weapon_spawn((125.5, 1733.25, 66), (286.8, 99.25, 28), "trial_variant_fast", undefined, "iw8_sm_mpapa7+stockl+barshort+fastreload+pistolgrip02+xmags");
  create_trial_weapon_spawn((62.25, 1797.5, 87), (0, 143, 0), "trial_variant_heavy", "trial_starting_weapon", "iw8_ar_mike4+fastreload+stocks+pistolgrip02+reflexmini+barsil");
  create_trial_weapon_spawn((53, 1801.5, 60), (288, 125.15, 17.4), "trial_variant_heavy", undefined, "iw8_sn_mike14+pistolgrip03+fastreload+xmags+barshort+reflexmini");
  create_trial_weapon_spawn((64.25, 1792.5, 58.5), (287.35, 123.75, 18.74), "trial_variant_heavy", undefined, "iw8_ar_falima+fastreload+stocks+pistolgrip02+barshort+reflexmini");
  create_trial_weapon_spawn((75, 1784.25, 61.5), (289.6, 126, 16.6), "trial_variant_heavy", undefined, "iw8_sn_sksierra+laserbalanced+fastreload+pistolgrip06+barshort+reflex3");
  _id_9E370B5BABD9FCF1 = getEnt("clip128x128x128", "targetname");
  _id_A30A5E2BC3E5F146 = [];
  _id_A30A5E2BC3E5F146[0] = spawn("script_model", (1145.25, 291, 0.75));
  _id_A30A5E2BC3E5F146[0].angles = (0, 0, 0);
  _id_A30A5E2BC3E5F146[1] = spawn("script_model", (1273.75, 291, 0.75));
  _id_A30A5E2BC3E5F146[1].angles = (0, 0, 0);
  _id_A30A5E2BC3E5F146[2] = spawn("script_model", (1145.25, 164.5, 0.75));
  _id_A30A5E2BC3E5F146[2].angles = (0, 0, 0);
  _id_A30A5E2BC3E5F146[3] = spawn("script_model", (1273.75, 164.5, 0.75));
  _id_A30A5E2BC3E5F146[3].angles = (0, 0, 0);
  _id_A30A5E2BC3E5F146[4] = spawn("script_model", (203.25, -622.75, 0.75));
  _id_A30A5E2BC3E5F146[4].angles = (0, 0, 0);
  _id_A30A5E2BC3E5F146[5] = spawn("script_model", (93, -599.5, 0.75));
  _id_A30A5E2BC3E5F146[5].angles = (0, 350.75, 0);
  _id_A30A5E2BC3E5F146[6] = spawn("script_model", (124.5, -655.75, 0.75));
  _id_A30A5E2BC3E5F146[6].angles = (0, 38.5, 0);
  _id_A30A5E2BC3E5F146[7] = spawn("script_model", (203.25, -684.75, 0.75));
  _id_A30A5E2BC3E5F146[7].angles = (0, 0, 0);

  foreach(_id_F90358454413407F in _id_A30A5E2BC3E5F146)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_9E370B5BABD9FCF1);

  thread target_random_models();
  thread flares_from_structs("course_started");
}

mp_farms2_gw_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (53844, -18822, 4690), (75, 355, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
}

mp_port2_gw_patch() {
  if(level.trial["missionScript"] == "race") {
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (36805, -14366, -152), (0, 300, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    level.trial_race_lap_total_override = 1;
    register_create_script_arrays("mp_trial_helicopter_port_create_a_script", "mp_trial_helicopter_race", scripts\mp\trials\mp_trial_helicopter_port_create_a_script::main);
  } else {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (53844, -18822, 4690), (75, 355, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  }
}

mp_downtown_gw_patch() {
  if(level.trial["missionScript"] == "race") {
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (22448, -17782, 560), (0, 315.999, 0));
    thread downtown_helicopter_start();
    level.trial_race_lap_total_override = 1;
    level.localeid = "locale_8";
  } else {
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_ar_mike4+reflex_west02+fmj+pistolgrip02+stockl+barlong");
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon_2", "iw8_la_rpapa7");
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (28101, -11340, 7000), (75, 200, 0));
  }

  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  register_create_script_arrays("mp_downtown_gw_create_script", "mp_downtown_gw_trial", _id_4EAD0293865FBA60::main);
}

mp_cave_am_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-2482.78, -1290.79, -28.0287), (0, 0, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  create_trial_weapon_spawn((-2262.25, -1500.75, 33), (0, 0, 0), undefined, undefined, "iw8_ar_mike4+minireddot+gripvert+gl");
  create_trial_weapon_spawn((-2276.25, -1502.25, 50), (0, 0, 0), undefined, undefined, "iw8_la_rpapa7");
  create_trial_weapon_spawn((-2204, -1501, 36), (0, 0, 0), undefined, undefined, "iw8_la_mike32");
  create_trial_weapon_spawn((-2204.25, -1503, 51), (0, 0, 0), undefined, undefined, "iw8_ar_scharlie+reflex_east01+silencer_west01+gl+stocks_scharlie+laserrange");
  level.player_equip_primary = "equip_c4";
  level.player_equip_secondary = "equip_thermite";
  level.player_equip_regen = 1;
  level.player_limitedammo = 1;
  level.trial_player_perks = [];
  level.trial_player_perks = scripts\engine\utility::array_add(level.trial_player_perks, "specialty_fastreload");
  level.trial_enemy_dont_drop_weapon = 1;
  level.trial_explosive_clear = 1;
  thread scripts\mp\trials\mp_trl_cleararea::createscript_covernodes();
  register_create_script_arrays("mp_cave_am_create_script", "mp_cave_am_create_script", scripts\mp\trials\mp_cave_am_create_script::main);
}

mp_hardhat_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (864, -752, 288), (0, 270, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
}

fake_trigger_think(_id_E7189FE88B802B75) {
  for(;;) {
    while([[_id_E7189FE88B802B75]]())
      waitframe();

    self notify("trigger");
    waitframe();
  }
}

mp_speedball_check_trigger_pos() {
  if(!isDefined(level.player))
    return 1;

  _id_DAF073C7DEB0268F = level.player.origin[0] < -720;
  _id_2EF0DA8EBD601BB7 = level.player.origin[1] > -60;
  _id_2EF0DB8EBD601DEA = level.player.origin[1] < 330;

  if(!isDefined(level.player_in_spawn_area)) {
    if(_id_DAF073C7DEB0268F && _id_2EF0DA8EBD601BB7 && _id_2EF0DB8EBD601DEA)
      level.player_in_spawn_area = 1;
  }

  if(istrue(level.player_in_spawn_area)) {
    if(!_id_DAF073C7DEB0268F || !_id_2EF0DA8EBD601BB7 || !_id_2EF0DB8EBD601DEA) {
      level.player_in_spawn_area = 0;
      return 0;
    }
  }

  return 1;
}

mp_crash2() {
  setdynamicdvar("scr_game_enableMinimap", 0);
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (45, -617, 330), (0, 81, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  register_create_script_arrays("mp_trl_gunslinger_crash_create_script", "mp_crash2", scripts\mp\trials\mp_trl_gunslinger_crash_create_script::main);
  _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
  _id_C665700AAD2CBF97 = [];
  _id_C665700AAD2CBF97[0] = spawn("script_model", (-56, -587, 333));
  _id_C665700AAD2CBF97[0].angles = (90, 0, 0);
  _id_C665700AAD2CBF97[1] = spawn("script_model", (-56, -715, 333));
  _id_C665700AAD2CBF97[1].angles = (90, 0, 0);
  _id_C665700AAD2CBF97[2] = spawn("script_model", (16, -760, 333));
  _id_C665700AAD2CBF97[2].angles = (90, 90, 0);
  _id_C665700AAD2CBF97[3] = spawn("script_model", (144, -760, 333));
  _id_C665700AAD2CBF97[3].angles = (90, 90, 0);
  _id_C665700AAD2CBF97[4] = spawn("script_model", (16, -523, 333));
  _id_C665700AAD2CBF97[4].angles = (90, 90, 0);
  _id_C665700AAD2CBF97[5] = spawn("script_model", (144, -760, 333));
  _id_C665700AAD2CBF97[5].angles = (90, 39.786, -82.713);
  _id_C665700AAD2CBF97[6] = spawn("script_model", (144, -523, 333));
  _id_C665700AAD2CBF97[6].angles = (90, 90, 0);

  foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

  _id_87890A761838B95F = getEnt("clip32x32x32", "targetname");
  _id_F234453E9FBAED2A = [];
  _id_F234453E9FBAED2A[0] = spawn("script_model", (21, -565, 268));
  _id_F234453E9FBAED2A[0].angles = (0, 326.9, 0);
  _id_F234453E9FBAED2A[1] = spawn("script_model", (35, -543, 268));
  _id_F234453E9FBAED2A[1].angles = (0, 326.9, 0);

  foreach(_id_F90358454413407F in _id_F234453E9FBAED2A)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_87890A761838B95F);
}

mp_t_reflex_patch(_id_8E003FDA6A2C258F, _id_40853847B9CDA9FD) {
  if(_id_40853847B9CDA9FD == "gunslinger" || _id_40853847B9CDA9FD == "pitcher") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (1874, 1198.75, 8), (0, 182.4, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);

    if(_id_8E003FDA6A2C258F == "knife") {
      create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
      register_create_script_arrays("mp_trl_gunslinger_knife_create_script", "mp_trl_gunslinger_targets3_create_script", scripts\mp\trials\mp_trl_gunslinger_knife_create_script::main);
    }

    if(_id_8E003FDA6A2C258F == "reflex" && scripts\mp\trials\trial_utility::trial_is_event()) {
      register_create_script_arrays("mp_t_reflex_game_of_summer_createscript", "mp_t_reflex_game_of_summer_createscript", _id_3767BEB9DD6A7B4A::main);
      level.vfx_special_height = 275;
      level.vfx_special_time = 2.25;
      thread trial_special_vfx();
    }
  }

  if(_id_40853847B9CDA9FD == "race") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-2896, 1480, 16), (0, 35, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    register_create_script_arrays("mp_t_reflex_create_script_quadrace", "mp_t_reflex_trial_race_createscript", scripts\mp\trials\mp_t_reflex_create_script_quadrace::main);
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    thread hangar_doors_opening_quadrace();
    _id_87997A644A946CAD = getEntArray("remove_for_race", "targetname");

    foreach(ent in _id_87997A644A946CAD)
    ent delete();

    thread mp_t_reflex_containers_collisions();
  }
}

hangar_doors_opening_quadrace() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_643ADC5D8C4B1451 = getEnt("open_hangardoors", "targetname");
  _id_B92ED59A4803BFC6 = getentitylessscriptablearray("big_door_l", "targetname");
  _id_F0A703890C4BA81B = getentitylessscriptablearray("big_door_r", "targetname");
  _id_2C11B765EE814740 = getEnt("doorcoll_left", "targetname");
  _id_DD233886F8198BD5 = getEnt("doorcoll_right", "targetname");
  _id_643ADC5D8C4B1451 waittill("trigger");
  _id_B92ED59A4803BFC6[0] setscriptablepartstate("base", "move_l_quadrace");
  _id_F0A703890C4BA81B[0] setscriptablepartstate("base", "move_r_quadrace");
  waitframe();

  while(_id_2C11B765EE814740.origin != _id_B92ED59A4803BFC6[0].origin && _id_DD233886F8198BD5.origin != _id_F0A703890C4BA81B[0].origin) {
    _id_2C11B765EE814740.origin = (_id_B92ED59A4803BFC6[0].origin[0], _id_B92ED59A4803BFC6[0].origin[1], _id_B92ED59A4803BFC6[0].origin[2]);
    _id_DD233886F8198BD5.origin = (_id_F0A703890C4BA81B[0].origin[0], _id_F0A703890C4BA81B[0].origin[1], _id_F0A703890C4BA81B[0].origin[2]);
    waitframe();
  }
}

mp_t_reflex_containers_collisions() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_F579AF73F074FC0F = getEntArray("container_model", "targetname");
  _id_7E76D03BBA61827B = getEnt("container_collision", "targetname");

  foreach(ent in _id_F579AF73F074FC0F) {
    _id_6CAFCA24B497061B = spawn("script_model", ent.origin);
    _id_6CAFCA24B497061B.angles = ent.angles;
    _id_6CAFCA24B497061B clonebrushmodeltoscriptmodel(_id_7E76D03BBA61827B);
  }
}

mp_layover_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-21478, 25049, -338), (0, 0, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.trial_race_lap_total_override = 1;
  register_create_script_arrays("mp_trl_quarry_raceislava_trial_create_a_script", "mp_quarry_trials_race", scripts\mp\trials\mp_trl_quarry_raceislava_trial_create_a_script::main);
}

mp_m_trench_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-1108, -88, -84), (0, 28, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((-906.97, 138.623, -5.5239), (0, 271, 0), undefined, "trial_starting_weapon", "iw8_pi_cpapa+barlong_cpapa+stockcust_cpapa+trigcust03_cpapa");
  create_trial_weapon_spawn((-923.97, 202.123, -54.7739), (345, 180, 0.000108306), undefined, undefined, "iw8_me_riotshield");
  create_trial_weapon_spawn((-909.97, 132.123, -27.7739), (286.245, 316.609, -46.8203), undefined, undefined, "iw8_sn_kilo98+barshort_kilo98+fastreload");
  create_trial_weapon_spawn((-905.72, 147.123, 2.9761), (359.382, 271.507, -13.7324), undefined, undefined, "iw8_sh_charlie725+barshort_charlie725");
  create_trial_weapon_spawn((-909.97, 148.123, -29.2739), (288.531, 318.307, -48.1768), undefined, undefined, "iw8_sn_sksierra+snprscope_sksierra+smags_sksierra+pistolgrip04_sksierra+barshort_sksierra");
  create_trial_weapon_spawn((-909.22, 166.623, -29.7739), (287.755, 321.101, -51.1163), undefined, undefined, "iw8_ar_akilo47+bayonet_akilo47+barsmg_akilo47+stocklmg_akilo47");
  create_trial_weapon_spawn((481.28, -380.877, -34.0239), (287.755, 321.101, -51.1163), undefined, undefined, "iw8_la_rpapa7");
  thread mp_m_trench_patch_giveplayer_c4();
  register_create_script_arrays("mp_m_trench_create_script_gunnonlinear", "mp_m_trench_create_script_gunnonlinear", scripts\mp\trials\mp_m_trench_create_script_gunnonlinear::main);
  thread target_remap_key_value_pairs();
}

mp_m_trench_patch_giveplayer_c4() {
  level endon("course_ended");
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  level.player scripts\mp\equipment::giveequipment("equip_c4", "primary");
  scripts\mp\trials\mp_trl_cleararea::recharge_equipment_init();
}

mp_emporium_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-596, 1455, 654), (0, 194, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.playerhastrock = 1;
  thread player_give_infinite_rocks();
  register_create_script_arrays("mp_emporium_create_script_floorislava", "mp_emporium_create_script_floorislava", scripts\mp\trials\mp_emporium_create_script_floorislava::main);
  thread patch_collisions_crates();
  _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
  _id_4EB850D95C514C5B = [];
  _id_4EB850D95C514C5B[0] = spawn("script_model", (-813.913, 1425.88, 588));
  _id_4EB850D95C514C5B[0].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[1] = spawn("script_model", (-805.913, 1378.55, 588));
  _id_4EB850D95C514C5B[1].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[2] = spawn("script_model", (-750.813, 1436.54, 588));
  _id_4EB850D95C514C5B[2].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[3] = spawn("script_model", (-742.812, 1389.22, 588));
  _id_4EB850D95C514C5B[3].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[4] = spawn("script_model", (-687.7, 1447.21, 588));
  _id_4EB850D95C514C5B[4].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[5] = spawn("script_model", (-679.705, 1399.88, 588));
  _id_4EB850D95C514C5B[5].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[6] = spawn("script_model", (-624.602, 1457.88, 588));
  _id_4EB850D95C514C5B[6].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[7] = spawn("script_model", (-616.6, 1410.55, 588));
  _id_4EB850D95C514C5B[7].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[8] = spawn("script_model", (-562.832, 1476.43, 588));
  _id_4EB850D95C514C5B[8].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[9] = spawn("script_model", (-554.83, 1429.11, 588));
  _id_4EB850D95C514C5B[9].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[10] = spawn("script_model", (-528.607, 1465.99, 608));
  _id_4EB850D95C514C5B[10].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[11] = spawn("script_model", (-523.27, 1434.44, 608));
  _id_4EB850D95C514C5B[11].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[12] = spawn("script_model", (-528.607, 1465.99, 672));
  _id_4EB850D95C514C5B[12].angles = (0, 9.6, 0);
  _id_4EB850D95C514C5B[13] = spawn("script_model", (-523.27, 1434.44, 672));
  _id_4EB850D95C514C5B[13].angles = (0, 9.6, 0);

  foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);

  _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
  _id_C665700AAD2CBF97 = [];
  _id_C665700AAD2CBF97[0] = spawn("script_model", (-606.269, 1493.43, 676));
  _id_C665700AAD2CBF97[0].angles = (0, 9.6, 90);
  _id_C665700AAD2CBF97[1] = spawn("script_model", (-732.48, 1472.1, 676));
  _id_C665700AAD2CBF97[1].angles = (0, 9.6, 90);
  _id_C665700AAD2CBF97[2] = spawn("script_model", (-588.936, 1390.89, 676));
  _id_C665700AAD2CBF97[2].angles = (0, 9.6, 90);
  _id_C665700AAD2CBF97[3] = spawn("script_model", (-715.141, 1369.55, 676));
  _id_C665700AAD2CBF97[3].angles = (0, 9.6, 90);

  foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

  _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
  _id_B096CCC1A2F2D643 = [];
  _id_B096CCC1A2F2D643[0] = spawn("script_model", (-561.497, 1468.55, 732));
  _id_B096CCC1A2F2D643[0].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[1] = spawn("script_model", (-553.493, 1421.21, 732));
  _id_B096CCC1A2F2D643[1].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[2] = spawn("script_model", (-632.484, 1456.54, 732));
  _id_B096CCC1A2F2D643[2].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[3] = spawn("script_model", (-624.482, 1409.22, 732));
  _id_B096CCC1A2F2D643[3].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[4] = spawn("script_model", (-695.597, 1445.87, 732));
  _id_B096CCC1A2F2D643[4].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[5] = spawn("script_model", (-687.595, 1398.55, 732));
  _id_B096CCC1A2F2D643[5].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[6] = spawn("script_model", (-758.695, 1435.21, 732));
  _id_B096CCC1A2F2D643[6].angles = (0, 9.6, 0);
  _id_B096CCC1A2F2D643[7] = spawn("script_model", (-750.696, 1387.88, 732));
  _id_B096CCC1A2F2D643[7].angles = (0, 9.6, 0);

  foreach(_id_F90358454413407F in _id_B096CCC1A2F2D643)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);

  _id_649E2EE364F136E0 = getEnt("mantle64", "targetname");
  _id_D4FBBEB09DA57BCE = [];
  _id_D4FBBEB09DA57BCE[0] = spawn("script_model", (-218, -543, 713));
  _id_D4FBBEB09DA57BCE[0].angles = (0, 270, 0);
  _id_D4FBBEB09DA57BCE[1] = spawn("script_model", (-248, -387, 713));
  _id_D4FBBEB09DA57BCE[1].angles = (0, 0, 0);
  _id_D4FBBEB09DA57BCE[2] = spawn("script_model", (-440, -387, 713));
  _id_D4FBBEB09DA57BCE[2].angles = (0, 0, 0);

  foreach(_id_F90358454413407F in _id_D4FBBEB09DA57BCE)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_649E2EE364F136E0, 1);

  _id_2A234F16F35B4A43 = getEnt("mantle128", "targetname");
  _id_3596D16AD1AC27D5 = [];
  _id_3596D16AD1AC27D5[0] = spawn("script_model", (-432, 451, 713));
  _id_3596D16AD1AC27D5[0].angles = (0, 0, 0);
  _id_3596D16AD1AC27D5[1] = spawn("script_model", (-22, -2083, 705));
  _id_3596D16AD1AC27D5[1].angles = (0, 0, 0);
  _id_3596D16AD1AC27D5[2] = spawn("script_model", (50, -2128, 705));
  _id_3596D16AD1AC27D5[2].angles = (0, 270, 0);

  foreach(_id_F90358454413407F in _id_3596D16AD1AC27D5)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_2A234F16F35B4A43, 1);

  _id_887DDA7C1841F51B = spawn("script_model", (-790.916, 1433.82, 692));
  _id_887DDA7C1841F51B.angles = (89.9991, 161.295, 151.702);
  _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
  _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  _id_0E05FDBC2B05C5E4 = spawn("script_model", (-781.584, 1378.61, 692));
  _id_0E05FDBC2B05C5E4.angles = (89.9991, 161.295, 151.702);
  _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
  _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
  thread mp_emporium_hanging_crates();
}

patch_collisions_crates() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
  crates = getEntArray("trial_crate_model", "targetname");

  foreach(model in crates) {
    _id_0791F4882815F7B8 = spawn("script_model", model.origin);
    _id_0791F4882815F7B8.angles = model.angles;
    _id_0791F4882815F7B8 clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);
  }
}

mp_emporium_hanging_crates() {
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  _id_116C626E97D8E9A4 = getEntArray("hanging_crate", "targetname");
  _id_850B149879FDBFE3 = loadfx("vfx/iw8_mp/trials/speedball/vfx_trials_imp_clay.vfx");

  foreach(crate in _id_116C626E97D8E9A4)
  crate thread hanging_crate_think(_id_850B149879FDBFE3);

  thread care_packages_unusable_think();
}

care_packages_unusable_think() {
  while(!isDefined(level.cratedata.usablecrates))
    waitframe();

  while(isDefined(level.cratedata.usablecrates)) {
    foreach(crate in level.cratedata.usablecrates) {
      if(isDefined(crate))
        crate scripts\cp_mp\killstreaks\airdrop::makecrateunusable();

      if(isDefined(crate.headicon))
        crate scripts\cp_mp\killstreaks\airdrop::_destroyheadicon();

      if(isDefined(crate.minimapid))
        crate scripts\cp_mp\killstreaks\airdrop::destroyminimapicon();
    }

    waitframe();
  }
}

hanging_crate_think(impact_vfx) {
  _id_FBFF01F6F282B3E9 = self.origin;
  _id_04FC1AA61751D7D0 = self.angles;
  _id_CB4CA4C438DDCB16 = scripts\engine\utility::get_target_ent();
  _id_CB4CA4C438DDCB16 setCanDamage(1);
  _id_CB4CA4C438DDCB16 waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
  playFX(impact_vfx, point);
  playsoundatpos(point, "trial_sfx_target_report_clay_smash");
  _id_486D209FE39D4AA9 = scripts\cp_mp\killstreaks\airdrop::dropkillstreakcrate(undefined, level.player.team, undefined, _id_FBFF01F6F282B3E9, _id_04FC1AA61751D7D0, undefined);
  _id_486D209FE39D4AA9.nevertimeout = 1;
  self delete();
  _id_CB4CA4C438DDCB16 delete();
}

player_give_infinite_rocks() {
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  level.player scripts\mp\equipment::giveequipment("equip_rock", "primary");

  while(isalive(level.player)) {
    equipment = level.player scripts\mp\equipment::getcurrentequipment("primary");
    _id_212E6B7D207A0089 = level.player scripts\mp\equipment::getequipmentammo(equipment);

    if(_id_212E6B7D207A0089 != 1)
      level.player scripts\mp\equipment::setequipmentammo(equipment, 1);

    wait 0.5;
  }
}

mp_m_cornfield_patch(_id_40853847B9CDA9FD) {
  if(_id_40853847B9CDA9FD == "lava") {
    entities = getEntArray("alpha", "targetname");

    foreach(e in entities) {
      if(isDefined(e) && e.script_gameobjectname == "trial")
        e delete();
    }

    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-1158.9, -233.964, 48.5), (0, 44.097, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    _id_18E6C172A1C69BE8 = getEnt("clip64x64x8", "targetname");
    _id_887DDA7C1841F51B = spawn("script_model", (-1008.48, -122.919, 89.482));
    _id_887DDA7C1841F51B.angles = (90, 226, 0);
    _id_887DDA7C1841F51B.targetname = "trial_truck_door_coll_l";
    _id_887DDA7C1841F51B clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
    _id_0E05FDBC2B05C5E4 = spawn("script_model", (-1049.24, -84.752, 89.411));
    _id_0E05FDBC2B05C5E4.angles = (90, 226, 0);
    _id_0E05FDBC2B05C5E4.targetname = "trial_truck_door_coll_r";
    _id_0E05FDBC2B05C5E4 clonebrushmodeltoscriptmodel(_id_18E6C172A1C69BE8);
    _id_8F57B2786C108819 = getEnt("care_package_col", "targetname");
    _id_3908F68C4CE949B7 = [];
    _id_3908F68C4CE949B7[0] = spawn("script_model", (-842, 367, -2));
    _id_3908F68C4CE949B7[0].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[1] = spawn("script_model", (-598, 343, -2));
    _id_3908F68C4CE949B7[1].angles = (0, 65, 0);
    _id_3908F68C4CE949B7[2] = spawn("script_model", (113, -132, -2));
    _id_3908F68C4CE949B7[2].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[3] = spawn("script_model", (118, -341, -2));
    _id_3908F68C4CE949B7[3].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[4] = spawn("script_model", (1632, -371, 295));
    _id_3908F68C4CE949B7[4].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[5] = spawn("script_model", (0.826, -522, -2));
    _id_3908F68C4CE949B7[5].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[6] = spawn("script_model", (-49.043, -520, -2));
    _id_3908F68C4CE949B7[6].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[7] = spawn("script_model", (-49.169, -520.725, 54));
    _id_3908F68C4CE949B7[7].angles = (0, 90, 0);
    _id_3908F68C4CE949B7[8] = spawn("script_model", (-405.75, -1325.75, -4));
    _id_3908F68C4CE949B7[8].angles = (0, 271, 0);
    _id_3908F68C4CE949B7[9] = spawn("script_model", (219, -1298, 3));
    _id_3908F68C4CE949B7[9].angles = (0, 223, 0);
    _id_3908F68C4CE949B7[10] = spawn("script_model", (256, -1489, 3));
    _id_3908F68C4CE949B7[10].angles = (0, 180, 0);
    _id_3908F68C4CE949B7[11] = spawn("script_model", (256, -1539, 3));
    _id_3908F68C4CE949B7[11].angles = (0, 180, 0);
    _id_3908F68C4CE949B7[12] = spawn("script_model", (256, -1539, 58));
    _id_3908F68C4CE949B7[12].angles = (0, 180, 0);
    _id_3908F68C4CE949B7[13] = spawn("script_model", (-1017.97, -60.04, -10.566));
    _id_3908F68C4CE949B7[13].angles = (15, 226.013, 0);
    _id_3908F68C4CE949B7[14] = spawn("script_model", (-985.725, -91.156, -10.564));
    _id_3908F68C4CE949B7[14].angles = (15, 226.013, 0);
    _id_3908F68C4CE949B7[15] = spawn("script_model", (-1124, -1146, 0.695871));
    _id_3908F68C4CE949B7[15].angles = (0, 90, 0);

    foreach(_id_F90358454413407F in _id_3908F68C4CE949B7)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8F57B2786C108819);

    _id_44F8C91AB1B69E5D = getEnt("mantle64", "targetname");
    _id_D3C7396CDFF37BE5 = [];
    _id_D3C7396CDFF37BE5[0] = spawn("script_model", (-1144.19, -305.643, 137));
    _id_D3C7396CDFF37BE5[0].angles = (0, 225.756, 0);
    _id_D3C7396CDFF37BE5[1] = spawn("script_model", (-1099.54, -259.762, 137));
    _id_D3C7396CDFF37BE5[1].angles = (0, 225.756, 0);
    _id_D3C7396CDFF37BE5[2] = spawn("script_model", (-1054.9, -213.881, 137));
    _id_D3C7396CDFF37BE5[2].angles = (0, 225.756, 0);
    _id_D3C7396CDFF37BE5[3] = spawn("script_model", (-1010.25, -168, 137));
    _id_D3C7396CDFF37BE5[3].angles = (0, 225.756, 0);
    _id_D3C7396CDFF37BE5[4] = spawn("script_model", (-1046.25, -92, 137));
    _id_D3C7396CDFF37BE5[4].angles = (0, 315.756, 0);
    _id_D3C7396CDFF37BE5[5] = spawn("script_model", (-1015.25, -122, 137));
    _id_D3C7396CDFF37BE5[5].angles = (0, 315.756, 0);
    _id_D3C7396CDFF37BE5[6] = spawn("script_model", (-149.25, -524, 162));
    _id_D3C7396CDFF37BE5[6].angles = (0, 90, 0);

    foreach(_id_F90358454413407F in _id_D3C7396CDFF37BE5)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_44F8C91AB1B69E5D, 1);

    if(scripts\mp\trials\trial_utility::trial_is_event())
      thread trial_special_vfx();

    register_create_script_arrays("mp_m_cornfield_floor_is_lava_create_script", "mp_m_cornfield_trial_floor_is_laval", scripts\mp\trials\mp_m_cornfield_floor_is_lava_create_script::main);
  } else {
    create_trial_weapon_spawn((-381.5, -1669, 41), (360, 327.999, -90.0002), undefined, "trial_starting_weapon", "iw8_knife");
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-542, -1731, 60), (0, 33, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  }
}

mp_rust_patch(_id_8E003FDA6A2C258F) {
  if(level.trial["missionScript"] == "gunslinger") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-79, 1355, -160), (0, 270, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
    register_create_script_arrays("mp_trl_gunslinger_memory_create_script", "mp_trl_gunslinger_targets4_create_script", scripts\mp\trials\mp_trl_gunslinger_memory_create_script::main);
    _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
    _id_C665700AAD2CBF97 = [];
    _id_C665700AAD2CBF97[0] = spawn("script_model", (55, 1316, -178));
    _id_C665700AAD2CBF97[0].angles = (0, 90, -90);
    _id_C665700AAD2CBF97[1] = spawn("script_model", (-168, 1316, -178));
    _id_C665700AAD2CBF97[1].angles = (0, 90, -90);
    _id_C665700AAD2CBF97[2] = spawn("script_model", (-105, 1259, -178));
    _id_C665700AAD2CBF97[2].angles = (0, 0, -90);
    _id_C665700AAD2CBF97[3] = spawn("script_model", (23, 1259, -178));
    _id_C665700AAD2CBF97[3].angles = (0, 0, -90);

    foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

    _id_87890A761838B95F = getEnt("clip32x32x32", "targetname");
    _id_F234453E9FBAED2A = [];
    _id_F234453E9FBAED2A[0] = spawn("script_model", (-64.726, 1250.21, -230.99));
    _id_F234453E9FBAED2A[0].angles = (0, 0, 0);
    _id_F234453E9FBAED2A[1] = spawn("script_model", (-96.726, 1250.21, -230.99));
    _id_F234453E9FBAED2A[1].angles = (0, 0, 0);

    foreach(_id_F90358454413407F in _id_F234453E9FBAED2A)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_87890A761838B95F);
  } else if(level.trial["missionScript"] == "jugg") {
    _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-66, 190, -237), (0, 45, 0));
    scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
    _id_2391E4D180BD249F = spawn("script_origin", (102, 358, -237));
    _id_2391E4D180BD249F.angles = (0, 0, 0);
    _id_2391E4D180BD249F.targetname = "trial_juggernaut_crate";
    create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  }
}

mp_boneyard_gw_patch() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-24974.3, -6286.91, -292.057), (0, 8, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.localeid = "locale_4";
  register_create_script_arrays("mp_trl_boneyard_gw_race", "mp_boneyard_gw_trial_race", scripts\mp\trials\mp_trl_boneyard_gw_race::main);
  _id_0F128935A669F058 = getEnt("clip128x128x8", "targetname");
  _id_C665700AAD2CBF97 = [];
  _id_C665700AAD2CBF97[0] = spawn("script_model", (-27937, -4290, -249));
  _id_C665700AAD2CBF97[0].angles = (0, 0, 90);
  _id_C665700AAD2CBF97[1] = spawn("script_model", (-28065, -4290, -249));
  _id_C665700AAD2CBF97[1].angles = (0, 0, 90);
  _id_C665700AAD2CBF97[2] = spawn("script_model", (-28193, -4290, -249));
  _id_C665700AAD2CBF97[2].angles = (0, 0, 90);
  _id_C665700AAD2CBF97[3] = spawn("script_model", (-28314, -4325, -249));
  _id_C665700AAD2CBF97[3].angles = (0, 32.299, 90);
  _id_C665700AAD2CBF97[4] = spawn("script_model", (-28364, -4429, -249));
  _id_C665700AAD2CBF97[4].angles = (0, 97.096, 90);
  _id_C665700AAD2CBF97[5] = spawn("script_model", (-28349, -4555, -249));
  _id_C665700AAD2CBF97[5].angles = (0, 97.096, 90);
  _id_C665700AAD2CBF97[6] = spawn("script_model", (-28156, -6667, -33));
  _id_C665700AAD2CBF97[6].angles = (359.997, 270.09, 90);
  _id_C665700AAD2CBF97[7] = spawn("script_model", (-28169, -6795, -33));
  _id_C665700AAD2CBF97[7].angles = (359.997, 258.19, 90);
  _id_C665700AAD2CBF97[8] = spawn("script_model", (-28246, -7060, -10));
  _id_C665700AAD2CBF97[8].angles = (0, 115.295, 90);
  _id_C665700AAD2CBF97[9] = spawn("script_model", (-28228, -7177, -10));
  _id_C665700AAD2CBF97[9].angles = (359.999, 76.392, 90);
  _id_C665700AAD2CBF97[10] = spawn("script_model", (-28289, -7281, -10));
  _id_C665700AAD2CBF97[10].angles = (359.997, 44.392, 90);
  _id_C665700AAD2CBF97[11] = spawn("script_model", (-27391, -6955, 48));
  _id_C665700AAD2CBF97[11].angles = (359.994, 346.289, 90);
  _id_C665700AAD2CBF97[12] = spawn("script_model", (-27519, -6948, 48));
  _id_C665700AAD2CBF97[12].angles = (359.995, 7.488, 90);
  _id_C665700AAD2CBF97[13] = spawn("script_model", (-27568, -7018, 48));
  _id_C665700AAD2CBF97[13].angles = (359.995, 280.19, 90);
  _id_C665700AAD2CBF97[14] = spawn("script_model", (-27496, -7076, 48));
  _id_C665700AAD2CBF97[14].angles = (359.995, 355.491, 90);
  _id_C665700AAD2CBF97[15] = spawn("script_model", (-27369, -7086, 48));
  _id_C665700AAD2CBF97[15].angles = (359.995, 355.491, 90);
  _id_C665700AAD2CBF97[16] = spawn("script_model", (-27310, -7032, 48));
  _id_C665700AAD2CBF97[16].angles = (359.995, 280.19, 90);
  _id_C665700AAD2CBF97[17] = spawn("script_model", (-27115.6, -6828, 10.677));
  _id_C665700AAD2CBF97[17].angles = (22.45, 90, -2.439);
  _id_C665700AAD2CBF97[18] = spawn("script_model", (-26989.7, -6824.39, 15.419));
  _id_C665700AAD2CBF97[18].angles = (22.45, 90, -2.439);
  _id_C665700AAD2CBF97[19] = spawn("script_model", (-26710, -6607, 83));
  _id_C665700AAD2CBF97[19].angles = (359.994, 286.688, 90.001);
  _id_C665700AAD2CBF97[20] = spawn("script_model", (-26640, -6662, 83));
  _id_C665700AAD2CBF97[20].angles = (359.996, 6.286, 90.001);
  _id_C665700AAD2CBF97[21] = spawn("script_model", (-26459, -6950, 182));
  _id_C665700AAD2CBF97[21].angles = (359.997, 280.19, -179.996);
  _id_C665700AAD2CBF97[22] = spawn("script_model", (-26376, -6931, 182));
  _id_C665700AAD2CBF97[22].angles = (359.997, 280.19, -179.996);
  _id_C665700AAD2CBF97[23] = spawn("script_model", (-26377.4, -7490.33, 82.251));
  _id_C665700AAD2CBF97[23].angles = (24.389, 276.924, -1.632);
  _id_C665700AAD2CBF97[24] = spawn("script_model", (-26388.4, -7406.33, 121.349));
  _id_C665700AAD2CBF97[24].angles = (24.389, 276.924, -1.632);
  _id_C665700AAD2CBF97[29] = spawn("script_model", (-26401, -7329, 91));
  _id_C665700AAD2CBF97[29].angles = (359.999, 7.688, 90);
  _id_C665700AAD2CBF97[30] = spawn("script_model", (-25099, -7301, -112));
  _id_C665700AAD2CBF97[30].angles = (359.997, 297.287, 90);
  _id_C665700AAD2CBF97[31] = spawn("script_model", (-25092, -5424, -97));
  _id_C665700AAD2CBF97[31].angles = (359.999, 304.389, 90);
  _id_C665700AAD2CBF97[32] = spawn("script_model", (-24344, -5754, -262));
  _id_C665700AAD2CBF97[32].angles = (359.997, 282.79, 90);
  _id_C665700AAD2CBF97[33] = spawn("script_model", (-24300, -5870, -262));
  _id_C665700AAD2CBF97[33].angles = (359.996, 300, 90);
  _id_C665700AAD2CBF97[34] = spawn("script_model", (-24238, -5981, -262));
  _id_C665700AAD2CBF97[34].angles = (0, 300, 90);
  _id_C665700AAD2CBF97[35] = spawn("script_model", (-23664, -6961, -285));
  _id_C665700AAD2CBF97[35].angles = (359.994, 291.99, 90);
  _id_C665700AAD2CBF97[36] = spawn("script_model", (-23614, -7079, -285));
  _id_C665700AAD2CBF97[36].angles = (359.994, 291.99, 90);
  _id_C665700AAD2CBF97[37] = spawn("script_model", (-23575, -7168, -285));
  _id_C665700AAD2CBF97[37].angles = (359.994, 291.99, 90);
  _id_C665700AAD2CBF97[40] = spawn("script_model", (-27083.3, -8893.63, 7.683));
  _id_C665700AAD2CBF97[40].angles = (359.288, 351.421, 90.068);
  _id_C665700AAD2CBF97[41] = spawn("script_model", (-27066.3, -8913.63, 7.683));
  _id_C665700AAD2CBF97[41].angles = (359.288, 351.421, 90.068);
  _id_C665700AAD2CBF97[42] = spawn("script_model", (-23939.1, -7485.67, -256));
  _id_C665700AAD2CBF97[42].angles = (359.288, 211.399, 90.068);

  foreach(_id_F90358454413407F in _id_C665700AAD2CBF97)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_0F128935A669F058);

  _id_8A0EBF19C7BFA542 = getEnt("clip64x64x64", "targetname");
  _id_4EB850D95C514C5B = [];
  _id_4EB850D95C514C5B[0] = spawn("script_model", (-23745, -7335, -293));
  _id_4EB850D95C514C5B[0].angles = (0, 242.697, 90);
  _id_4EB850D95C514C5B[1] = spawn("script_model", (-23783.1, -7418.76, -293));
  _id_4EB850D95C514C5B[1].angles = (0, 232.597, 90);
  _id_4EB850D95C514C5B[2] = spawn("script_model", (-23859.1, -7496.76, -268));
  _id_4EB850D95C514C5B[2].angles = (344.471, 202.69, 87.974);
  _id_4EB850D95C514C5B[3] = spawn("script_model", (-27502.1, -6962.76, 21));
  _id_4EB850D95C514C5B[3].angles = (0, 242.697, 90);
  _id_4EB850D95C514C5B[4] = spawn("script_model", (-28209.1, -6693.76, -62));
  _id_4EB850D95C514C5B[4].angles = (0, 173.095, 90);
  _id_4EB850D95C514C5B[5] = spawn("script_model", (-28218.1, -6813.76, -62));
  _id_4EB850D95C514C5B[5].angles = (0, 168.296, 90);
  _id_4EB850D95C514C5B[6] = spawn("script_model", (-28267.1, -7071.76, -42));
  _id_4EB850D95C514C5B[6].angles = (0, 206.297, 90);
  _id_4EB850D95C514C5B[7] = spawn("script_model", (-28224.1, -7140.76, -33));
  _id_4EB850D95C514C5B[7].angles = (0, 257.797, 90);
  _id_4EB850D95C514C5B[8] = spawn("script_model", (-28237.1, -7216.76, -33));
  _id_4EB850D95C514C5B[8].angles = (0, 257.797, 90);
  _id_4EB850D95C514C5B[9] = spawn("script_model", (-27877.1, -4693.76, -270));
  _id_4EB850D95C514C5B[9].angles = (0, 263.996, 90);
  _id_4EB850D95C514C5B[10] = spawn("script_model", (-27896.1, -4251.76, -273));
  _id_4EB850D95C514C5B[10].angles = (0, 263.996, 90);
  _id_4EB850D95C514C5B[11] = spawn("script_model", (-27964.1, -4251.76, -278));
  _id_4EB850D95C514C5B[11].angles = (0, 263.996, 90);
  _id_4EB850D95C514C5B[12] = spawn("script_model", (-28032.1, -4240.76, -278));
  _id_4EB850D95C514C5B[12].angles = (0, 263.996, 90);
  _id_4EB850D95C514C5B[13] = spawn("script_model", (-28166.1, -4240.76, -278));
  _id_4EB850D95C514C5B[13].angles = (0, 263.996, 90);
  _id_4EB850D95C514C5B[14] = spawn("script_model", (-28282.1, -4227.76, -278));
  _id_4EB850D95C514C5B[14].angles = (0, 313.694, 90);
  _id_4EB850D95C514C5B[15] = spawn("script_model", (-28372.1, -4262.76, -278));
  _id_4EB850D95C514C5B[15].angles = (0, 308.594, 90);
  _id_4EB850D95C514C5B[16] = spawn("script_model", (-26688.1, -6594.76, 50));
  _id_4EB850D95C514C5B[16].angles = (0, 191.496, 90);
  _id_4EB850D95C514C5B[17] = spawn("script_model", (-26581.1, -6651.76, 45));
  _id_4EB850D95C514C5B[17].angles = (0, 219.896, 90);
  _id_4EB850D95C514C5B[18] = spawn("script_model", (-27140.1, -8950.76, 1));
  _id_4EB850D95C514C5B[18].angles = (0, 219.896, 90);
  _id_4EB850D95C514C5B[19] = spawn("script_model", (-25962.1, -7874.76, -6));
  _id_4EB850D95C514C5B[19].angles = (0, 216.295, 90);
  _id_4EB850D95C514C5B[20] = spawn("script_model", (-25047.1, -5431.76, -103));
  _id_4EB850D95C514C5B[20].angles = (0, 210.658, 90);
  _id_4EB850D95C514C5B[21] = spawn("script_model", (-25057.1, -7311.76, -140));
  _id_4EB850D95C514C5B[21].angles = (0, 206.358, 90);
  _id_4EB850D95C514C5B[22] = spawn("script_model", (-26581.1, -6651.76, 45));
  _id_4EB850D95C514C5B[22].angles = (0, 219.896, 90);

  foreach(_id_F90358454413407F in _id_4EB850D95C514C5B)
  _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_8A0EBF19C7BFA542);
}

mp_village2_patches() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (-1222, -2462, 386), (0, 53, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((-998, -2305, 412), (0, 0, -93), "trial_variant_explosion", "trial_starting_weapon", "iw8_knife");
  create_trial_weapon_spawn((-1015, -2284, 459), (0, 141, 0), "trial_variant_explosion", undefined, "iw8_la_mike32+fastreload");
  create_trial_weapon_spawn((-1025, -2280, 430), (297, 117, 125), "trial_variant_explosion", undefined, "iw8_sn_crossbow+fastreload+cableh+barmid+reflexmini");
  create_trial_weapon_spawn((-998, -2302, 431), (290, 1.6, -163), "trial_variant_explosion", undefined, "iw8_la_rpapa7");
  create_trial_weapon_spawn((-1011, -2289, 432), (288.4, 116, 23), "trial_variant_explosion", undefined, "iw8_sh_romeo870+melee+holo3+stocks+gripvertpro+barshort");
  level.player_equip_primary = "equip_c4";
  level.player_equip_regen = 1;
  level.player_limitedammo = 1;
  level.trial_enemy_dont_drop_weapon = 1;
  level.trial_explosive_clear = 1;
  thread scripts\mp\trials\mp_trl_cleararea::createscript_covernodes();
}

mp_oilrig_patches() {
  _id_4296DA31DDEF2DCF = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_trial_spawn", (1188, -1459, 872), (0, 209, 0));
  scripts\mp\spawnlogic::addscriptedspawnpoints([_id_4296DA31DDEF2DCF]);
  create_trial_weapon_spawn((0, 0, 0), (0, 0, 0), undefined, "trial_starting_weapon", "iw8_knife");
  level.trial_delete_out_of_bounds = 1;
  register_create_script_arrays("mp_oilrig_create_script", "mp_oilrig_create_script", scripts\mp\trials\mp_oilrig_create_script::main);
}

_id_F4FE6A8D156A2CAD() {
  if(scripts\mp\trials\trial_utility::trial_is_event())
    thread trial_special_vfx();

  if(level.trial["variant"] == "trialympic") {
    _id_D12BD2A8EC16DD50 = getEnt("clip8x8x256", "targetname");
    _id_735A4E2A53898878 = [];
    _id_735A4E2A53898878[0] = spawn("script_model", (1792, 852, 8));
    _id_735A4E2A53898878[0].angles = (0, 0, 0);
    _id_735A4E2A53898878[1] = spawn("script_model", (1906, 852, 8));
    _id_735A4E2A53898878[1].angles = (0, 0, 0);
    _id_735A4E2A53898878[2] = spawn("script_model", (1906, 1562, 8));
    _id_735A4E2A53898878[2].angles = (0, 0, 0);
    _id_735A4E2A53898878[3] = spawn("script_model", (1786, 1562, 8));
    _id_735A4E2A53898878[3].angles = (0, 0, 0);

    foreach(_id_F90358454413407F in _id_735A4E2A53898878)
    _id_F90358454413407F clonebrushmodeltoscriptmodel(_id_D12BD2A8EC16DD50);
  }
}

register_create_script_arrays(script, _id_365929041E4386ED, func) {
  if(isDefined(script))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = script;

  if(isDefined(_id_365929041E4386ED))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = _id_365929041E4386ED;

  level.create_script_file_ids[script] = "cs" + level.scripted_spawner_func.size;

  if(isDefined(func))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = func;
}

create_trial_weapon_spawn(origin, angles, _id_6C462293994EFA73, noteworthy, weapon_name) {
  _id_DE88CD14114C1E24 = spawn("script_origin", origin);

  if(isDefined(angles))
    _id_DE88CD14114C1E24.angles = angles;

  if(isDefined(_id_6C462293994EFA73))
    _id_DE88CD14114C1E24.script_gameobjectname = _id_6C462293994EFA73;
  else
    _id_DE88CD14114C1E24.script_gameobjectname = "trial";

  if(isDefined(noteworthy))
    _id_DE88CD14114C1E24.script_noteworthy = noteworthy;

  _id_DE88CD14114C1E24.targetname = "trial_weapon";
  _id_DE88CD14114C1E24.script_parameters = weapon_name;
  return _id_DE88CD14114C1E24;
}

target_remap_key_value_pairs() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_DBFED29DAA551385 = scripts\engine\utility::getStructArray("hint_struct", "targetname");

  foreach(_id_B8E70FF71A02E32D in level.course_targets) {
    _id_30AAF28CC8D40B14 = scripts\engine\utility::getclosest(_id_B8E70FF71A02E32D.origin, _id_DBFED29DAA551385, 32);

    if(isDefined(_id_30AAF28CC8D40B14)) {
      _id_13FA4EE81D2D62C1 = strtok(_id_30AAF28CC8D40B14.script_noteworthy, "+");

      foreach(_id_1CC7C9040CC89B48 in _id_13FA4EE81D2D62C1) {
        strings = strtok(_id_1CC7C9040CC89B48, "=");

        switch (strings[0]) {
          case "targetname":
            _id_B8E70FF71A02E32D.targetname = strings[1];
            break;
          case "script_speed":
            _id_B8E70FF71A02E32D.script_speed = float(strings[1]);
            break;
          default:
            break;
        }
      }
    }
  }
}

target_random_models() {
  while(!isDefined(level.targets_thinking) || istrue(level.targets_thinking))
    waitframe();

  _id_D59668175D173E0A = ["ee_military_shooting_range_plate_enemy_01", "ee_military_shooting_range_plate_enemy_02", "ee_military_shooting_range_plate_enemy_03", "ee_military_shooting_range_plate_enemy_04", "ee_military_shooting_range_plate_enemy_05", "ee_military_shooting_range_plate_enemy_06"];
  _id_C95DAC27196563D7 = ["ee_military_shooting_range_plate_civilian_01", "ee_military_shooting_range_plate_civilian_02", "ee_military_shooting_range_plate_civilian_03"];
  _id_5D92F86712740B86 = ["ee_military_shooting_range_plate_bullet", "ee_military_shooting_range_plate_bullet_01", "ee_military_shooting_range_plate_bullet_02", "ee_military_shooting_range_plate_bullet_03"];
  enemies = scripts\engine\utility::array_randomize(level.enemy_targets);
  civilians = scripts\engine\utility::array_randomize(level.civilian_targets);

  foreach(enemy in enemies) {
    enemy.bullet_decal = spawn("script_model", enemy.plate.origin);
    enemy.bullet_decal.angles = enemy.plate.angles;
    enemy.bullet_decal linkTo(enemy.plate);

    if(isDefined(enemy.script_parameters))
      enemy.plate setModel(enemy.script_parameters);
  }

  foreach(enemy in enemies) {
    _id_ECA765B2402F7A34 = scripts\engine\utility::getclosest(enemy.origin, scripts\engine\utility::array_remove(enemies, enemy));
    _id_ECA768B2402F80CD = scripts\engine\utility::getclosest(enemy.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(enemies, enemy), _id_ECA765B2402F7A34));
    _id_ECA767B2402F7E9A = scripts\engine\utility::getclosest(enemy.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(enemies, enemy), _id_ECA765B2402F7A34), _id_ECA768B2402F80CD));
    _id_CA3EE2AD0E0A0E42 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(_id_5D92F86712740B86, _id_ECA765B2402F7A34.bullet_decal.model), _id_ECA768B2402F80CD.bullet_decal.model), _id_ECA767B2402F7E9A.bullet_decal.model);

    if(!isDefined(enemy.script_parameters)) {
      _id_2DF718E627733A8A = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(_id_D59668175D173E0A, _id_ECA765B2402F7A34.plate.model), _id_ECA768B2402F80CD.plate.model), _id_ECA767B2402F7E9A.plate.model);
      enemy.plate setModel(scripts\engine\utility::random(_id_2DF718E627733A8A));
    }

    enemy.bullet_decal setModel(scripts\engine\utility::random(_id_CA3EE2AD0E0A0E42));
  }

  foreach(civilian in civilians) {
    _id_ECA765B2402F7A34 = scripts\engine\utility::getclosest(civilian.origin, scripts\engine\utility::array_remove(civilians, civilian));
    _id_ECA768B2402F80CD = scripts\engine\utility::getclosest(civilian.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(civilians, civilian), _id_ECA765B2402F7A34));

    if(isDefined(civilian.script_parameters)) {
      civilian.plate setModel(civilian.script_parameters);
      continue;
    }

    _id_2DF718E627733A8A = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(_id_C95DAC27196563D7, _id_ECA765B2402F7A34.plate.model), _id_ECA768B2402F80CD.plate.model);
    civilian.plate setModel(scripts\engine\utility::random(_id_2DF718E627733A8A));
  }
}

downtown_helicopter_start() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  start_trigger = getEnt("start_flares_trig", "targetname");
  _id_D9A138833F1C9681 = getEntArray("start_flare", "targetname");
  start_trigger waittill("trigger");
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    foreach(flare in _id_D9A138833F1C9681) {
      if(isDefined(flare.script_noteworthy)) {
        if(int(flare.script_noteworthy) == _id_AC0E594AC96AA3A8) {
          flare playSound("iw9_tactical_insert_flare_pu");
          playFXOnTag(level.vfx_flare, flare, "j_top");
        }
      }
    }

    wait 0.5;
    _id_AC0E594AC96AA3A8++;
  }
}

flares_from_structs(msg, smoke) {
  level._effect["trial_smoke"] = loadfx("vfx/core/mp/core/vfx_flare_glow_en.vfx");
  level._effect["trial_flare"] = loadfx("vfx/iw7/levels/europa/vfx_eu_icecave_flare_01.vfx");

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_DC158F4C54EB9AC2 = scripts\engine\utility::getStructArray("flare_struct", "targetname");

  foreach(struct in _id_DC158F4C54EB9AC2) {
    _id_D5B7FADC10C3C201 = spawn("script_model", struct.origin);
    _id_D5B7FADC10C3C201.angles = struct.angles;
    _id_D5B7FADC10C3C201 setModel("equipment_flare_wm");
    struct.flame_emitter = spawn("script_model", struct.origin);
    struct.flame_emitter.angles = struct.angles;
    struct.flame_emitter setModel("tag_origin");
    struct.flame_emitter linkTo(_id_D5B7FADC10C3C201, "tag_fire_fx", (0, 0, -1.75), (0, 180, 0));

    if(istrue(smoke)) {
      struct.smoke_emitter = spawn("script_model", struct.origin);
      struct.smoke_emitter.angles = struct.angles;
      struct.smoke_emitter setModel("tag_origin");
      struct.smoke_emitter linkTo(_id_D5B7FADC10C3C201, "tag_fire_fx", (1, 0, 0), (90, 0, 0));
    }
  }

  for(;;) {
    level waittill(msg);

    foreach(struct in _id_DC158F4C54EB9AC2) {
      playFXOnTag(level._effect["trial_flare"], struct.flame_emitter, "tag_origin");

      if(istrue(smoke))
        playFXOnTag(level._effect["trial_smoke"], struct.smoke_emitter, "tag_origin");
    }

    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();

    foreach(struct in _id_DC158F4C54EB9AC2) {
      stopFXOnTag(level._effect["trial_flare"], struct.flame_emitter, "tag_origin");

      if(istrue(smoke))
        stopFXOnTag(level._effect["trial_smoke"], struct.smoke_emitter, "tag_origin");
    }
  }
}

trial_special_vfx() {
  level._effect["trial_cup_flames"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_olympic_flame.vfx");
  level._effect["trial_small_cup_flames"] = loadfx("vfx/iw8/level/estate/vfx_estate_oil_fire.vfx");
  level._effect["trial_thermite_bronze"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_celeb_flame_bronze.vfx");
  level._effect["trial_thermite_silver"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_celeb_flame_silver.vfx");
  level._effect["trial_thermite_gold"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_celeb_flame_gold.vfx");
  level._effect["trial_celebration_flare"] = loadfx("vfx/iw8_mp/trials/summer/vfx_t_angelflares.vfx");
  level._effect["big_red_vfx"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail.vfx");
  level.trial_special_end = 1;

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  thread celebration_end();
  level.trialympic_fires = getEntArray("trial_flames", "targetname");

  if(isDefined(level.trialympic_fires)) {
    wait 5;

    foreach(fire in level.trialympic_fires) {
      if(istrue(level.trial_small_fire))
        playFXOnTag(scripts\engine\utility::getfx("trial_small_cup_flames"), fire, "j_top");
      else
        playFXOnTag(scripts\engine\utility::getfx("trial_cup_flames"), fire, "j_top");

      fire setModel("tag_origin");
    }
  }
}

celebration_end() {
  level.trial_celebration_flares = getEntArray("trial_celebration_flares", "targetname");
  level.trial_end_flares = getEntArray("trial_end_flares", "targetname");

  if(isDefined(level.vfx_special_height))
    level.vfx_height = level.vfx_special_height;
  else
    level.vfx_height = 750;

  if(isDefined(level.vfx_special_time))
    level.vfx_time = level.vfx_special_time;
  else
    level.vfx_time = 1.75;

  for(;;) {
    level._id_436D9728256C5C6C = undefined;
    level waittill("course_ended");

    if(istrue(level._id_44F499EB7125DF94)) {
      level._id_436D9728256C5C6C = getomnvar("ui_trial_reward_tier");

      if(level._id_436D9728256C5C6C == 0) {
        level.player playsoundtoplayer("gos_crowd_boo_loser", level.player);
        level._id_436D9728256C5C6C = 0;
        continue;
      }
    } else {
      while(!isDefined(level.score["total"]))
        waitframe();

      if(level.trial["scoreType"] == "time") {
        if(level.score["total"] <= level.trial["tier3"])
          level._id_436D9728256C5C6C = 3;
        else if(level.score["total"] <= level.trial["tier2"])
          level._id_436D9728256C5C6C = 2;
        else if(level.score["total"] <= level.trial["tier1"])
          level._id_436D9728256C5C6C = 1;
        else {
          level.player playsoundtoplayer("gos_crowd_boo_loser", level.player);
          level._id_436D9728256C5C6C = 0;
          continue;
        }
      } else if(level.score["total"] >= level.trial["tier3"])
        level._id_436D9728256C5C6C = 3;
      else if(level.score["total"] >= level.trial["tier2"])
        level._id_436D9728256C5C6C = 2;
      else if(level.score["total"] >= level.trial["tier1"])
        level._id_436D9728256C5C6C = 1;
      else {
        level.player playsoundtoplayer("gos_crowd_boo_loser", level.player);
        level._id_436D9728256C5C6C = 0;
        continue;
      }
    }

    foreach(flare in level.trial_celebration_flares) {
      if(isDefined(flare.script_noteworthy) && float(flare.script_noteworthy) <= level._id_436D9728256C5C6C)
        flare thread trial_play_flare_fx(flare.script_noteworthy);
    }

    if(level._id_436D9728256C5C6C == 3) {
      wait 3;
      level.player playsoundtoplayer("gos_cheer_front", level.player);

      foreach(_id_D8AFC65D94B4F696 in level.trial_end_flares)
      _id_D8AFC65D94B4F696 thread end_flares();
    }

    wait 4;

    foreach(flare in level.trial_celebration_flares) {
      if(istrue(flare.flare_activated))
        flare stoploopsound();
    }
  }
}

end_flares() {
  if(isDefined(self.script_noteworthy))
    wait(float(self.script_noteworthy) * 0.5);

  if(isDefined(self.target)) {
    if(self.target == "big_red_vfx") {
      _id_23803F15C6DB7059 = spawn("script_model", self gettagorigin("j_top") + (0, 0, 25));
      _id_23803F15C6DB7059 setModel("tag_origin");
      _id_23803F15C6DB7059.angles = self.angles;
      waitframe();
      playFXOnTag(scripts\engine\utility::getfx("big_red_vfx"), _id_23803F15C6DB7059, "tag_origin");
      _id_23803F15C6DB7059 moveTo(_id_23803F15C6DB7059.origin + (0, 0, level.vfx_height), level.vfx_time);
      _id_23803F15C6DB7059 playsoundonmovingent("gos_firework_scream_sfx");
      self playSound("gos_firework_explo_sfx");
      wait 4;
      stopFXOnTag(scripts\engine\utility::getfx("big_red_vfx"), _id_23803F15C6DB7059, "tag_origin");
    }
  } else {
    playFXOnTag(scripts\engine\utility::getfx("trial_celebration_flare"), self, "j_top");
    self playSound("ks_apache_flares");
  }
}

trial_play_flare_fx(_id_7A4D89B99942D23C) {
  if(isDefined(_id_7A4D89B99942D23C))
    wait(float(_id_7A4D89B99942D23C));

  if(isDefined(self.target))
    wait(float(self.target));

  playFXOnTag(scripts\engine\utility::getfx(_id_C166265242E8A14F()), self, "j_top");
  self playSound("gos_firework_explo_sfx");
  self.flare_activated = 1;

  if(isDefined(_id_7A4D89B99942D23C) && _id_7A4D89B99942D23C == "0" && level._id_436D9728256C5C6C >= 3) {
    wait 2;
    playFXOnTag(scripts\engine\utility::getfx(_id_C166265242E8A14F()), self, "j_top");
  }
}

_id_C166265242E8A14F() {
  switch (level._id_436D9728256C5C6C) {
    case 1:
      _id_940CC9D235AA6CFF = "trial_thermite_bronze";
      break;
    case 2:
      _id_940CC9D235AA6CFF = "trial_thermite_silver";
      break;
    case 3:
      _id_940CC9D235AA6CFF = "trial_thermite_gold";
      break;
    default:
      _id_940CC9D235AA6CFF = "trial_thermite_bronze";
      break;
  }

  return _id_940CC9D235AA6CFF;
}