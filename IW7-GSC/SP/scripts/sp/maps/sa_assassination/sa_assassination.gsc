/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination.gsc
*****************************************************************/

main() {
  scripts\sp\utility::_id_116CB("sa_assassination");
  level._id_E982 = 1;
  scripts\sp\maps\sa_assassination\gen\sa_assassination_art::main();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::main();
  scripts\sp\maps\sa_assassination\sa_assassination_precache::main();
  _id_0F00::_id_25D8();
  scripts\sp\maps\sa_assassination\sa_assassination_audio::main();
  _id_0EFE::_id_FD0B();
  _id_0F05::_id_FCF3();
  _id_0B53::_id_B908("veh_mil_air_ca_destroyer", "sp/model_damage_tables/veh_mil_air_ca_destroyer_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_destroyer_fx.csv");
  _id_D83F();
  scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2394();
  _id_0F10::_id_FCFE();
  _id_0F0E::_id_D7F8();
  scripts\sp\utility::_id_1263F("sa_assassination_base_tr");
  scripts\sp\utility::_id_1263F("sa_assassination_infil_tr");
  scripts\sp\utility::_id_1263F("sa_assassination_destroyer_keel_tr");
  scripts\sp\utility::_id_1263F("sa_assassination_destroyer_int_tr");
  scripts\sp\utility::_id_1263F("sa_assassination_destroyer_ext_tr");
  scripts\sp\utility::_id_1263F("sa_assassination_exfil_retribution_tr");
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("sm_sunsamplesizenear", 1);
  setsaveddvar("player_isInZeroGLevel", 1);
  _id_FA53();

  if(getDvar("createfx") != "") {
    level thread _id_0F16::_id_88CA();
  }

  _id_0B51::_id_B8CA();
  level._id_FD6E._id_E35D hide();
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("hide");
  level._id_FD6E._id_E35D castspotshadows(0);
  scripts\sp\load::main();
  thread scripts\sp\maps\sa_assassination\sa_assassination_lighting::_id_E985();
  level._id_98C4 = ::_id_9716;
  level._id_13ED5 = 1;
  level._id_7495 = "sa_assassination";
  _id_0F0C::_id_E9BF();
  level._id_E977.spawners["assassin_lmg_patrol"] = getspawnerarray("sa_lmg_spawner_patrol");
  level._id_E977.spawners["assassin_smg_patrol"] = getspawnerarray("sa_smg_spawner_patrol");
  level._id_E977.spawners["assassin_crew_patrol"] = getspawnerarray("sa_crew_spawner_patrol");
  level._id_E977.spawners["assassin_ar_patrol"] = getspawnerarray("sa_ar_spawner_patrol");
  scripts\engine\utility::array_thread(level._id_E977.spawners["assassin_lmg_patrol"], scripts\sp\utility::_id_1747, scripts\sp\maps\sa_assassination\sa_assassination_int::_id_C126);
  scripts\engine\utility::array_thread(level._id_E977.spawners["assassin_smg_patrol"], scripts\sp\utility::_id_1747, scripts\sp\maps\sa_assassination\sa_assassination_int::_id_C126);
  scripts\engine\utility::array_thread(level._id_E977.spawners["assassin_crew_patrol"], scripts\sp\utility::_id_1747, scripts\sp\maps\sa_assassination\sa_assassination_int::_id_C126);
  scripts\engine\utility::array_thread(level._id_E977.spawners["assassin_ar_patrol"], scripts\sp\utility::_id_1747, scripts\sp\maps\sa_assassination\sa_assassination_int::_id_C126);
  scripts\sp\maps\sa_assassination\sa_assassination_anim::main();
  _id_0EFE::main();
  _id_0F05::_id_95B6();
  _id_0EFC::_id_967E();
  _id_0F04::_id_9587();
  _id_0F21::main();
  _id_0F35::main();
  scripts\sp\maps\sa_assassination\sa_assassination_lighting::main();
  scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_2390();
  setsaveddvar("r_umbraMinObjectContribution", 4);
  level._id_21E7 = scripts\sp\maps\sa_assassination\sa_assassination_anim::_id_21E8;
  scripts\engine\utility::delaythread(2, _id_0E4B::_id_8E06);
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_1086E("sdf_tech_officer", scripts\sp\maps\sa_assassination\sa_assassination_int::_id_115F8);
  _id_0F0E::_id_F900("destroyer_exterior_hull", "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx");
  level._id_3965 castspotshadows(0);
  thread _id_DC5F();
}

_id_DC5F() {
  level endon("gas_venting");
  scripts\engine\utility::flag_wait("ship_in_lockdown");
  wait 1.25;
  level.player scripts\sp\utility::_id_F526("normal");
  var_0 = randomintrange(1, 2);

  switch (var_0) {
    case 1:
      thread scripts\sp\utility::_id_10350("asn_slt_scramblingcomms");
    case 2:
      thread scripts\sp\utility::_id_10350("asn_slt_dropemquick");
  }

  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3._id_2894 = 25;
      var_3.accuracy = var_3._id_2894;
    }
  }

  scripts\sp\utility::_id_13754(var_1);
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_clear("ship_in_lockdown");
  scripts\engine\utility::waitframe();
  level.player scripts\sp\utility::_id_F526("relaxed");
  thread scripts\sp\utility::_id_10350("asn_slt_stilldarkreyescovers");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread _id_DC5F();
}

_id_FA7F() {
  level.player takeallweapons();
  level.player giveweapon("iw7_emc+reflexpstl+silencerpstle");
  level.player giveweapon("iw7_ar57+reflex+silencer");
  level.player giveweapon("iw7_knife_assassin");
  level.player switchtoweaponimmediate("iw7_ar57+reflex+silencer");
}

_id_D83F() {
  scripts\engine\utility::flag_init("hatch_ready");
  scripts\engine\utility::flag_init("hatch_used");
  scripts\engine\utility::flag_init("radarEMP");
  scripts\engine\utility::flag_init("zerog_combat_end");
  scripts\engine\utility::flag_init("enable_infil");
  scripts\engine\utility::flag_init("inside_trash_compactor");
  scripts\engine\utility::flag_init("enable_exfil");
  scripts\engine\utility::flag_init("flag_exfil_ext_door");
  scripts\engine\utility::flag_init("flag_escape_complete");
  scripts\engine\utility::flag_init("player_unloaded_from_drop_ship");
  scripts\engine\utility::flag_init("unload_drop_ship");
  scripts\engine\utility::flag_init("player_out_of_dropship");
  scripts\engine\utility::flag_init("infil retribution ftl");
  scripts\engine\utility::flag_init("launch_exfil_jackal");
  scripts\engine\utility::flag_init("flag_keel_salter_cont");
  scripts\engine\utility::flag_init("flag_keel_salter_gas");
  scripts\engine\utility::flag_init("flag_got_gas_device");
  scripts\engine\utility::flag_init("flag_scipted_jackal_landing");
  scripts\engine\utility::flag_init("infil_zero_g_end");
  scripts\engine\utility::flag_init("exfil_zero_g_end");
  scripts\engine\utility::flag_init("player_inside_ship");
  scripts\engine\utility::flag_init("flag_bomb_grab");
  scripts\engine\utility::flag_init("flag_gas_cursor_hint");
  scripts\engine\utility::flag_init("flag_gas_cursor_triggered");
  scripts\engine\utility::flag_init("enable_loot_room_01");
  scripts\engine\utility::flag_init("enable_loot_room_02");
  scripts\engine\utility::flag_init("captain_key_card_spawned");
  scripts\engine\utility::flag_init("captain_key_card_pickup_started");
  scripts\engine\utility::flag_init("captain_key_card_picked_up");
  scripts\engine\utility::flag_init("visionset_conference");
  scripts\engine\utility::flag_init("visionset_interior");
  scripts\engine\utility::flag_init("visionset_server");
  scripts\engine\utility::flag_init("visionset_assist");
  scripts\engine\utility::flag_init("visionset_exfil");
  scripts\engine\utility::flag_init("visionset_under");
  setsaveddvar("r_umbraShadowCasters", 1);
  _id_0F0E::_id_F902();
  scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_E3AF();
  level._effect["closeup_thruster_fx"] = loadfx("vfx/iw7/levels/sa_assassination/vfx_sa_assn_capship_thruster_close.vfx");
  level._effect["retribution_barrage"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_titan_explosion_large_cap");
  level._effect["vfx_airlock_vent_lrg_depress"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_lrg_depress.vfx");
  level._effect["vfx_airlock_vents_air"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_lrg_press.vfx");
  level._effect["destroyer_hull_omni"] = loadfx("vfx/iw7/levels/sa_assassination/vfx_sa_assn_light_underside_omni.vfx");
  scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_E30F();
  precachemodel("veh_mil_air_un_retribution_rig");
  precachemodel("ship_exterior_thruster_d_baked_flat");
  precachemodel("sdf_captain_keycard_01_static_nochain");
  precachemodel("vm_hero_protagonist_helmet_zerog_empty");
  precacheshader("cinematic");
  precachemodel("cnd_office_chair_01_rig");
  precachemodel("electrical_box_power_tall_01_closed_half");
  precachemodel("viewmodel_mp_stryker_2");
  precachemodel("viewmodel_body_mp_stryker_2");
  precachemodel("weapon_gas_bomb_vm");
  precachemodel("veh_mil_air_un_jackal_02_player");
  precachemodel("hvac_unit_door_01");
  precachemodel("p7_weights_metal_gym_25_grey_drk");
  precachemodel("weapon_sdfar_wm");
  precachemodel("equipment_duffle_bag_01");
  precachemodel("furniture_space_locker_metal_01_door_dark");
  precachemodel("body_sdf_army_heavy_4_vm_legs");
  precacheitem("iw7_crb");
  precacheitem("iw7_m8");
  precachemodel("sdf_cruise_missile_dolly_01_rig");
  precachemodel("sdf_shadow");
  precachemodel("sdf_cruise_missile_rack_clamp_01");
  precachemodel("sdf_cruise_missile_rack_link_01");
  precachemodel("sdf_cruise_missile_rack_01_rig");
  precachemodel("sdf_cruise_missile_rack_02_rig");
  precachemodel("sdf_cruise_missile_closed_01_black");
  precachemodel("sdf_cruise_missile_decals_black");
  precachemodel("sdf_cruise_missile_closed_01");
  precachemodel("sdf_cruise_missile_decals_white");
  precachemodel("sdf_cruise_missile_closed_01_red");
  precachemodel("sdf_cruise_missile_decals_red");
  precachestring(&"SA_ASSASSINATION_ENTER_SDF_GALAXIUS");
  precachestring(&"SA_ASSASSINATION_ACQUIRE_SDF_DISGUISE");
  precachestring(&"SA_ASSASSINATION_ACQUIRE_TECH_OFFICERS");
  precachestring(&"SA_ASSASSINATION_ACCESS_CONFERENCE_CENTER");
  precachestring(&"SA_ASSASSINATION_KILL_SDF_COMMANDERS");
  precachestring(&"SA_ASSASSINATION_ESCAPE_SHIP");
  precachestring(&"SA_ASSASSINATION_BOARD_THE_RETRIBUTION");
  precachestring(&"SA_ASSASSINATION_KILL_SKELTER_ACES");
  precachestring(&"SA_ASSASSINATION_PLANT_EMP_DEVICE");
  precachestring(&"SA_ASSASSINATION_DISGUISE");
  precachestring(&"SA_ASSASSINATION_CREDENTIALS");
  precachestring(&"SA_ASSASSINATION_SECURITY_TERMINAL");
  precachestring(&"SA_ASSASSINATION_SUPPORT");
  precachestring(&"SA_ASSASSINATION_FOLLOW");
  precachestring(&"SA_ASSASSINATION_TECH_OFFICER");
  precachestring(&"SA_ASSASSINATION_SDF_ACES");
}

_id_FA53() {
  var_0 = "sa_assassination_base_tr";
  var_1 = ["sa_assassination_destroyer_ext_tr", "sa_assassination_destroyer_keel_tr", "sa_assassination_infil_tr"];
  var_2 = ["sa_assassination_base_tr", "sa_assassination_destroyer_ext_tr", "sa_assassination_destroyer_keel_tr", "sa_assassination_destroyer_int_tr"];
  var_3 = ["sa_assassination_base_tr", "sa_assassination_destroyer_ext_tr", "sa_assassination_destroyer_int_tr"];
  scripts\sp\utility::_id_F343("dropship_start");
  scripts\sp\utility::_id_1749("space_intro_start", ::_id_104E4, "Space Intro", ::_id_104E3, var_1, ::_id_104E2);
  scripts\sp\utility::_id_1749("infil", ::_id_9489, "Sneak inside the Destroyer", ::_id_946C, var_1);
  scripts\sp\utility::_id_1749("inside_destroyer", ::_id_991C, "Inside Destroyer", ::_id_991B, var_2);
  scripts\sp\utility::_id_1749("barracks", ::_id_2829, "Get In Barracks", undefined, var_2);
  scripts\sp\utility::_id_1749("get_disguise", ::_id_793A, "Get Disguise", undefined, var_2);
  scripts\sp\utility::_id_1749("got_disguise", ::_id_845B, "Got Disguise", undefined, var_2);
  scripts\sp\utility::_id_1749("conference_room", ::_id_451B, "Conf Room", undefined, var_2);
  scripts\sp\utility::_id_1749("pre_gas_scene", ::_id_D7BF, "Gas the room", undefined, var_2);
  scripts\sp\utility::_id_1749("assist_salter", ::assist_onenduse, "Assist Salter", undefined, var_2);
  scripts\sp\utility::_id_1749("runout_salter", ::_id_E887, "Runout With Salter", undefined, var_2);
  scripts\sp\utility::_id_1749("exfil", ::_id_692A, "Exfiltrate", ::_id_691E, var_3);
  scripts\sp\utility::_id_1749("exfil exec", ::_id_692B, "Exfiltrate", ::_id_691E, var_3);
  scripts\sp\utility::_id_1749("loot_room_01", ::_id_B08C, "Loot Room 01", ::_id_B08B, var_2);
  scripts\sp\utility::_id_1749("loot_room_02", ::_id_B08E, "Loot Room 02", ::_id_B08D, var_2);
}

_id_104E4() {
  level._id_EADF = getspawner("salter_0G", "script_noteworthy");
  level._id_13EF6 = level._id_EADF scripts\sp\utility::_id_10619(1, 1);
  level._id_13EF6._id_1FBB = "salter";
  level._id_13EF6 _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  level.player switchtoweapon(level.player getweaponslistprimaries()[0]);
  setsaveddvar("player_zeroGravAutoLevel", (0, 0, 1));
  thread _id_0F35::_id_FAFD();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_104E1();
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_FA56();
  _id_0F16::_id_3E3F("infil_wait_point");
}

_id_104E3() {
  level.player disableweapons();
  level.player freezecontrols(1);

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
  }

  level._id_13EF6 scripts\sp\utility::_id_413D();
  level._id_13EF6.ignoreall = 1;
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_104E0();
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_8E88();
  var_0 = getEntArray("shockwave_asteroid", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_23F2);
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\sa_assassination\sa_assassination_infil::asteroid_cleanup);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C5(1);
  scripts\sp\hud_util::_id_6AA3(0);
  scripts\engine\utility::delaythread(4, scripts\sp\hud_util::_id_6A99, 2);
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_E7FF();
  scripts\sp\utility::_id_1034D("asn_plr_breathing2");
  scripts\sp\utility::_id_1034D("asn_plr_oxygensat36");
  wait 3;
  level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_theyshouldvebeenhere");
  wait 2;
  level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_got30moremikes");
  wait 1.5;
  scripts\sp\utility::_id_1034D("asn_plr_werestillbingoon");
  waitforalltransients();
  scripts\engine\utility::delaythread(0.25, scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_7477);
  level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_rogerstandingbyfor");
  wait 3.25;
  var_1 = scripts\sp\utility::_id_8200("ftl_destroyer", "targetname");
  var_1 thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_748E();

  while(!isDefined(level._id_2391)) {
    wait 0.02;
  }

  level._id_2391 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_2472();
  level._id_2391 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_10109();
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_100E2();
  level._id_13EF6 thread scripts\sp\utility::_id_10346("asn_slt_effort");
  thread scripts\sp\utility::_id_1034D("asn_plr_effort");
  level.player _meth_8291(5, 5, 0, 1, 0.3, 0.5, 0, 2, 1.5, 0);
  level notify("asteroid_shock");
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_7485();
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_74A2();
  _id_0BDD::_id_6186(1, 0.55);
  level._id_13EF6._id_EDB0 = 1;
  level._id_13EF6 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_3C0C("path_to_keel");
  scripts\sp\utility::_id_228A(getEntArray("removable_cap", "script_noteworthy"));
  scripts\sp\utility::_id_1034D("asn_plr_theresheis");
  level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_copytargetconfirmedsdf");
  scripts\sp\utility::_id_1034D("asn_plr_drydockhatchwaysouringress");
  level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_rogkeeptightto");
  level._id_13EF6 _id_0F33::_id_C18F();
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_15B2();
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_949D();
}

setup_o2_meter() {
  setomnvar("ui_helmet_meter_forceVisible", 1);
  thread scripts\sp\hud::_id_8DFD(38, 1);
  wait 1;
  thread scripts\sp\hud::_id_8DFD(30, 10);
  wait 10;
  setomnvar("ui_helmet_meter_forceVisible", 0);
}

_id_F3C1(var_0) {
  self._id_7482 = var_0;
}

_id_104E2() {
  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
  }
}

_id_9489() {
  _id_0F16::_id_3E3F("hatch_panel_before");
  level.player enableweapons();
  level.player scripts\engine\utility::delaycall(4, ::switchtoweapon, level.player getweaponslistprimaries()[0]);
  scripts\sp\utility::_id_228A(getEntArray("removable_cap", "script_noteworthy"));
  level._id_EADF = getspawner("salter_0G", "script_noteworthy");
  var_0 = scripts\engine\utility::getStruct("salter_infil_goal", "targetname");
  level._id_EADF.origin = var_0.origin;
  level._id_13EF6 = level._id_EADF scripts\sp\utility::_id_10619(1, 1);
  level._id_13EF6 _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  level._id_13EF6._id_1FBB = "salter";
  setsaveddvar("player_zeroGravAutoLevel", (0, 0, 1));
  thread _id_0F35::_id_FAFD();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9433();
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_10668();
  var_1 = scripts\sp\utility::_id_8200("ftl_destroyer", "targetname");
  var_2 = var_1 scripts\sp\utility::_id_10808();
  level._id_7477 = [];
  level._id_7477[level._id_7477.size] = var_2;
  var_2 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_2472();
  var_2 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_10109();
  level._id_9ABA = getEntArray("sdf_ftl_light_01", "targetname");
  level._id_9ABA = scripts\engine\utility::array_combine(level._id_9ABA, getEntArray("sdf_ftl_light_02", "targetname"));
  level._id_9ABA = scripts\engine\utility::array_combine(level._id_9ABA, getEntArray("sdf_ftl_light_03", "targetname"));
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_8E88();
  scripts\engine\utility::waitframe();
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_100E2();
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_15B2();
  level._id_91C1 = getEnt("intro_hull_grap_vol", "targetname");
  level._id_91C1 _id_0F31::_id_13544(1);
  scripts\engine\utility::flag_set("hatch_ready");
}

_id_946C() {
  setglobalsoundcontext("atmosphere", "space", 0.1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C5(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C8(1);
  scripts\sp\utility::_id_413D();
  level._id_13EF6 scripts\sp\utility::_id_F3DA("salter_infil_goal");
  level._id_13EF6.ignoreall = 1;
  var_0 = scripts\engine\utility::getStruct("hatch_panel_before", "targetname");

  while(distance(level.player.origin, var_0.origin) > 512) {
    wait 0.2;
  }

  scripts\sp\utility::_id_1034D("asn_plr_illgetusin");
  level._id_13EF6 scripts\sp\utility::_id_10346("asn_slt_copy");
  setmusicstate("mx_194_assassination_moods");
  thread scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_944C();

  while(!scripts\engine\utility::flag("hatch_used")) {
    wait 0.2;
  }

  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_6624();
  scripts\engine\utility::flag_set("infil_zero_g_end");
  level notify("kill_infil_door_nag");
  thread _id_ADD2();
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_1F77();
  level._id_3965 notify("hide_hull");
  scripts\sp\utility::_id_1264E("sa_assassination_infil_tr");
  level._id_91C1 _id_0F31::_id_13544(0);
  level._id_91C1 delete();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9431();
  thread scripts\sp\utility::_id_266F();
  wait 1;
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C5(0);
  thread scripts\sp\maps\sa_assassination\sa_assassination_lighting::_id_1345C();
}

_id_ADD2() {
  scripts\sp\utility::_id_12643(["sa_assassination_base_tr", "sa_assassination_destroyer_int_tr"]);
}

_id_991C() {
  thread _id_0F16::_id_3E3E("sa02_interior_pstart");
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_991A();
  scripts\engine\utility::flag_set("inside_trash_compactor");
  scripts\engine\utility::flag_set("player_in_gravity");
  scripts\sp\utility::_id_960B();
  scripts\sp\utility::_id_E1F0();
  level._id_EADF = getspawner("salter_interior_start", "targetname");
  level._id_EA2C = level._id_EADF scripts\sp\utility::_id_10619(1, 1);
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_EAF6();
}

_id_2829() {
  thread _id_0F16::_id_3E3E("sa02_barracks_pstart");
  thread _id_0F16::_id_8EA3();
  setglobalsoundcontext("atmosphere", "", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_991A();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  scripts\engine\utility::flag_set("inside_trash_compactor");
  scripts\engine\utility::flag_set("player_in_gravity");
  scripts\sp\utility::_id_960B();
  scripts\sp\utility::_id_E1F0();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("get_disguise");
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_D04E();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_88C1();
  scripts\engine\utility::flag_wait("flag_near_barracks");
  level thread _id_0F16::_id_991E(1);
  thread scripts\sp\utility::_id_2679();
}

_id_793A() {
  _id_0F0C::_id_E9AB("sa_barracks_vol");
  thread _id_0F16::_id_3E3E("sa02_get_disguise_pstart");
  thread _id_0F16::_id_8EA3();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C1(1);
  setglobalsoundcontext("atmosphere", "", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_793E();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("get_disguise");
  scripts\engine\utility::flag_set("flag_disguise_objective");
  level thread _id_0F16::_id_991E(1);
  level._id_E99E["trig_barracks_door_exit"] _id_0F05::_id_AED6(0);
}

_id_845B() {
  _id_0F0C::_id_E9AB("sa_barracks_vol");
  thread _id_0F16::_id_3E3E("sa02_disguise_pstart");
  thread _id_0F16::_id_8EA3();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C1(1);
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_845C();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  scripts\sp\maps\sa_assassination\sa_assassination_int::_id_5657();
  scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2474();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("got_disguise");
  scripts\engine\utility::flag_set("flag_got_disguise");
  scripts\engine\utility::flag_set("flag_kill_tech_officer");

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  level thread _id_0F16::_id_991E(1);
  thread _id_0F16::_id_88EC();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_F02B();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_6615();
  level._id_DBBE = getEntArray("missile_racks", "targetname");
  scripts\engine\utility::array_thread(level._id_DBBE, _id_0EFC::_id_F9D7);
}

_id_991B() {
  thread _id_0F16::_id_8EA3();
  scripts\sp\maps\sa_assassination\sa_assassination_infil::_id_62CC();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C5(0);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C8(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C1(1);
  setglobalsoundcontext("atmosphere", "");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  scripts\sp\utility::_id_BDEC(1);
  wait 1;
  level thread _id_0F16::_id_991E(1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("int_start");
}

_id_451B() {
  level._id_E99E["hub_bow_exit_door"] _id_0F05::_id_AED6(0);
  thread _id_0F16::_id_3E3E("sa02_conf_pstart");
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("conference_room");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_4519();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  scripts\engine\utility::flag_set("flag_near_conference");
  scripts\engine\utility::flag_set("sac_bowupper_start");
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_5657();
  level thread _id_0F16::_id_991E(1);
  scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2474();
  level.player scripts\sp\utility::_id_F526("relaxed");
}

_id_D7BF() {
  thread _id_0F16::_id_3E3E("pre_gas_scene");
  thread _id_0F16::_id_8EA3();
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_D7BE();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("conference_room");
  level thread _id_0F16::_id_991E(1);
  wait 2.1;
  scripts\engine\utility::flag_set("sa_bowupper_roomb_start");
  scripts\engine\utility::flag_set("flag_plant_gas_event");
  scripts\engine\utility::flag_set("flag_near_conference");
  scripts\engine\utility::flag_set("flag_near_gas_event");
  scripts\engine\utility::flag_set("flag_in_conference");
  scripts\engine\utility::flag_set("flag_handscanner_used");
  scripts\engine\utility::flag_set("flag_hand_bink");
  scripts\engine\utility::flag_set("flag_hand_bink_end");
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_5657();
  scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2474();
}

assist_onenduse() {
  thread _id_0F16::_id_3E3E("sa02_assist_pstart");
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("assist");
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_5657();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2474();
  scripts\engine\utility::flag_set("flag_commanders_killed");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::assist_onbeginuse();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132BE(1);
  scripts\sp\maps\sa_assassination\sa_assassination_util::_id_4127();
  level thread _id_0F16::_id_991E(1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_894D();
  scripts\engine\utility::flag_set("flag_red_alert");
  wait 1;
}

_id_E887() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  thread _id_0F16::_id_3E3E("sa02_runout_pstart");
  thread _id_0F16::_id_8EA3();
  var_0 = getspawner("salter_exfil", "targetname");
  level._id_EA2C = var_0 scripts\sp\utility::_id_10619(1, 1);
  level._id_EA2C scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("escape_salter_colors1");
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_8936("escape");
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_E886();
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_9919();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_5657();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2474();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_7413();
  scripts\engine\utility::flag_set("flag_at_salter");
  scripts\engine\utility::flag_set("flag_rescued_salter");
}

_id_692A() {
  scripts\engine\utility::delaythread(0.1, _id_0F16::_id_3E3F, "exfil_player_start");
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_5657();
  thread scripts\sp\maps\sa_assassination\sa_assassination_int::_id_2474();
  var_0 = getspawner("salter_exfil", "targetname");
  var_1 = scripts\engine\utility::getStruct("exfil_salter_start_int", "targetname");
  var_0.origin = var_1.origin;
  level._id_EA2C = var_0 scripts\sp\utility::_id_10619(1, 1);
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  level._id_EA2C setgoalpos(level._id_EA2C.origin);
  level._id_EA2C scripts\sp\utility::_id_F3DD(32);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_68FD();
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  scripts\engine\utility::flag_set("flag_at_salter");
  scripts\engine\utility::flag_set("flag_rescued_salter");
  var_2 = getEnt("approaching_airlock", "targetname");
  var_2 scripts\sp\utility::_id_C12D("trigger", 1.5);
  level._id_241D = 0;
  level.player _meth_8081();
  level.player setviewmodel("viewmodel_mp_stryker_2");
}

_id_692B() {
  level.player _meth_84C7("lastShipcribMission", "shipcrib_titan");
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_692A();
}

_id_691E() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C1(0);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132BE(0);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C2(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132AD(1);
  level._id_C70F = getmapsundirection();
  setsundirection(anglesToForward((-48, 52, 0)));
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_68FB();
  scripts\engine\utility::flag_wait("flag_rescued_salter");
  var_0 = getEnt("approaching_airlock", "targetname");
  var_0 waittill("trigger");
  level._id_FE15 = scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_4C73;
  level._id_FE13 = scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_4C73;
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_68F1();
  level._id_E99E["exfil_door_interior"] _id_0F05::_id_12BD3(undefined, "tag_ui_back");
  level._id_E99E["exfil_door_interior"].useperbullethitmarkers = scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_68F0;
  level._id_E99E["exfil_door"].useperbullethitmarkers = scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_68F2;
  level._id_E99E["exfil_door_interior"] waittill("trigger", var_1);
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_6911();
  thread scripts\sp\utility::_id_12641("sa_assassination_exfil_retribution_tr");
  scripts\engine\utility::flag_set("flag_airlock_escape");
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_5254();
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_68F4();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C2(0);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132B9(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132C5(1);
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::flag_set, "flag_exfil_ext_door");
  level._id_E99E["exfil_door"] waittill("trigger", var_1);
  setmusicstate("");
  var_2 = getEnt("exfil_enemy_chain", "targetname");
  var_2 notify("trigger");
  thread scripts\sp\maps\sa_assassination\sa_assassination_util::waitforalltransients_delayed(1.5);
  scripts\engine\utility::delaythread(1.5, scripts\sp\maps\sa_assassination\sa_assassination_util::_id_13481, "sa_assassination", 1);
  scripts\sp\utility::_id_10FEC("vfx_amb_camdust");
  scripts\engine\utility::waitframe();
  level notify("exfil_airlock_reached");
  level._id_91C1 = getEnt("hull_grap_vol", "targetname");
  level._id_91C1 _id_0F31::_id_13544(1);
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_132AD(0);
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::clean_up_robot_racks();

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_BBDC();
  scripts\engine\utility::array_call(getaiarray("axis"), ::delete);
  scripts\engine\utility::array_call(getcorpsearray(), ::delete);
  level._id_3965 notify("hide_hull");
  level._id_3965 thread scripts\sp\maps\sa_assassination\sa_assassination_util::_id_2473();
  level._id_3965 _id_0BB8::_id_39D0("idle");
  level._id_3965 _id_0BB8::_id_39CD("idle");
  level._id_3965._id_B904 = "veh_mil_air_ca_destroyer";
  level._id_3965 thread _id_0B53::_id_B909();
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_68FE();
  level._id_C0B7 = 1;
  level notify("gravity_special_case");
  level._id_E99E["exfil_door"] scripts\sp\utility::_id_65E3("begin_opening");
  thread scripts\sp\maps\sa_assassination\sa_assassination_audio::_id_6904();
  scripts\sp\maps\sa_assassination\sa_assassination_fx::_id_13305();
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_E3AA();
  wait 2.5;
  level notify("runout_crate_cleanup");
  var_3 = scripts\sp\utility::_id_7C84("exfil_zerog_enemy", "script_noteworthy");
  scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_1747, scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A36E);
  _id_0F31::_id_17A0();
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_106EB();
  wait 6;
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_EA91();
  scripts\sp\utility::_id_10350("asn_gtr_multiplehostilesheadedyour");
  scripts\sp\utility::_id_10350("asn_slt_iseeemengaging");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_F3B5("r");

  foreach(var_5 in level._id_68FE) {
    var_5 _id_0BB6::_id_39F0();
  }

  level._id_3965 _id_0BB6::_id_39F0();
  wait 1.5;
  scripts\engine\utility::delaythread(2, scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_68C8);
  wait 3.5;
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_51FE();
  wait 1.5;
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_51FB();
  wait 1;
  scripts\sp\utility::_id_10350("asn_gtr_jacksapproachingnowsir");
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_EAC1();
  thread _id_0F16::_id_D154("exfil_jackal", "player_exfil_jackal_spline", "player_exfil_jackal_start");
  level._id_D127._id_55A4 = 1;
  level._id_D127._id_12A88 = 1;
  level._id_D127 thread _id_0BDC::_id_A07D();
  level._id_D127 waittill("space_mode");
  level._id_D127 scripts\engine\utility::waittill_either("goal", "near_goal");
  level._id_D127 thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_F430();
  level._id_D127 thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_D149();
  scripts\sp\utility::_id_10350("asn_gtr_captainyourjackalsare");
  wait 0.5;
  scripts\sp\utility::_id_1034D("asn_plr_copyvisual");
  level._id_EA2C scripts\sp\utility::_id_10346("asn_slt_wingupreyes");
  _id_0BDC::_id_137CF();
  level notify("player_dogfight_ready");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("ESCAPE_SHIP"));
  level.player notify("side_evaluator_end");
  scripts\engine\utility::flag_set("exfil_zero_g_end");
  level._id_3965 notify("show_hull");
  lerpsundirection(anglesToForward((-48, 52, 0)), level._id_C70F, 0.75);
  level._id_91C1 _id_0F31::_id_13544(0);
  thread scripts\sp\utility::_id_1264E("sa_assassination_base_tr");
  thread scripts\sp\utility::_id_1264E("sa_assassination_destroyer_keel_tr");
  thread scripts\sp\utility::_id_1264E("sa_assassination_destroyer_int_tr");
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_D844();
  scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_266F);
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A280();
  wait 2.5;
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_9834();
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_589D();
  level.player waittill("flag_player_is_flying");
  level notify("player_is_flying");
  setomnvar("ui_jackal_weapon_display_temp", 1);
  level._id_D127 scripts\sp\vehicle::_id_8440();
  level._id_D127.ignoreme = 0;
  level._id_D127 _meth_8456((0, 0, 1));
  _id_0BDC::_id_A1AD("enemy_lockon");
  scripts\sp\utility::_id_241F(0);
  scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_2669, "aces");

  if(scripts\sp\utility::_id_93A6()) {
    _id_0BD9::_id_FA4F();
  }

  scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_E7D5();
  level notify("dogfighting_ended");
  _id_0BDC::_id_A162();
  scripts\sp\utility::_id_2679();
  level thread _id_0B51::_id_E3C6(1, 0);
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A7BD("some id", scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A7DA, scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A7D9, scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A82F, scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A7F4);
  wait 1;
  scripts\sp\utility::_id_1034D("asn_plr_scar2rtbwereout");
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_F9C1();
  wait 2.5;
  scripts\sp\utility::_id_10350("asn_slt_letsgowheels");
  wait 1;
  scripts\sp\utility::_id_1034D("asn_plr_roger");
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_6905();
  thread scripts\sp\maps\sa_assassination\sa_assassination_exfil::_id_A838();
}

_id_B08C() {
  thread _id_0F16::_id_3E3E("loot_room_01_start");
  thread _id_0F16::_id_8EA3();
  level thread _id_0F16::_id_991E(1);
}

_id_B08B() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level waittill("forever");
}

_id_B08E() {
  thread _id_0F16::_id_3E3E("loot_room_02_start");
  thread _id_0F16::_id_8EA3();
  level thread _id_0F16::_id_991E(1);
}

_id_B08D() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level waittill("forever");
}

_id_79F8(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sac_bowupper_vol":
      var_1["ar"] = 2;
      break;
    case "sa_barracks_vol":
      var_1["crew"] = 0;
      break;
    case "sa_armory_room_vol":
      var_1["ar"] = 3;
      var_1["smg"] = 2;
      break;
    case "sa_bowupper_roomb_vol":
      break;
    case "sa_hubstern_vol":
      var_1["ar"] = 3;
      var_1["smg"] = 3;
      break;
    case "sa_hubbow_vol":
      var_1["ar"] = 4;
      var_1["smg"] = 3;
      break;
    case "sa_bridge_vol":
      var_1["ar"] = 2;
      break;
    case "sa_bridge_com_vol":
      var_1["ar"] = 2;
      break;
    case "sa_sternport_rooma_vol":
      var_1["smg"] = 2;
      break;
    case "sa_sternport_roomb_vol":
      var_1["smg"] = 2;
      break;
    case "sa_starboard_lower_vol":
      break;
    case "sa_starboard_lower_rooma_vol":
      break;
    default:
      break;
  }

  return var_1;
}

_id_7B73(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sac_bowupper_vol":
      var_1["assassin_lmg_patrol"] = 1;
      var_1["assassin_ar_patrol"] = 2;
      break;
    case "sa_armory_room_vol":
      var_1["assassin_lmg_patrol"] = 5;
      var_1["assassin_crew_patrol"] = 3;
      break;
    case "sa_bowupper_roomb_vol":
      break;
    case "sa_hubstern_vol":
      var_1["assassin_lmg_patrol"] = 3;
      break;
    case "sa_hubbow_vol":
      var_1["assassin_lmg_patrol"] = 4;
      var_1["assassin_smg_patrol"] = 2;
      break;
    case "sa_barracks_vol":
      var_1["crew"] = 0;
      break;
    case "sa_sternport_rooma_vol":
      var_1["smg"] = 2;
      break;
    case "sa_sternport_roomb_vol":
      var_1["smg"] = 2;
      break;
    case "sa_starboard_lower_vol":
      break;
    case "sa_starboard_lower_rooma_vol":
      break;
    default:
      break;
  }

  return var_1;
}

_id_7913(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sa_armory_room_vol":
      return "sdf_tech_officer";
    case "sa_bowupper_roomb_vol":
      break;
    case "sa_hubstern_vol":
      break;
    case "sa_hubbow_vol":
      break;
    case "sa_sternport_rooma_vol":
      break;
    case "sa_sternport_roomb_vol":
      break;
    case "sa_starboard_lower_vol":
      break;
    case "sa_starboard_lower_rooma_vol":
      break;
    default:
      break;
  }

  return var_1;
}

_id_9716(var_0) {
  var_1 = [];
  var_1["sa_hangar_vol"] = "sa_hangar_start";
  var_1["sa_armory_room_vol"] = "sa_armory_start";
  var_1["sa_hubstern_vol"] = "sa_hubstern_start";
  var_1["sa_hubbow_vol"] = "sa_hubbow_start";
  var_1["sa_bridge_vol"] = "sa_bridge_start";
  var_1["sa_bridge_com_vol"] = "sa_bridge_com_start";
  var_1["sa_barracks_vol"] = "sa_barracks_start";
  var_1["sa_sternport_rooma_vol"] = "sa_sternport_rooma_start";
  var_1["sa_sternport_roomb_vol"] = "sa_sternport_roomb_start";
  var_1["sa_bowupper_roomb_vol"] = "sa_bowupper_roomb_start";
  var_1["sac_hubstern_port_vol"] = "sac_hubstern_port_start";
  var_1["sac_portlower_vol"] = "sac_portlower_start";
  var_1["sac_bowupper_vol"] = "sac_bowupper_start";
  var_2 = [];
  var_2["sa_hangar_vol"] = "unaware";
  var_2["sa_armory_room_vol"] = "unaware";
  var_2["sa_hubstern_vol"] = "unaware";
  var_2["sa_hubbow_vol"] = "unaware";
  var_2["sa_bridge_vol"] = "unaware";
  var_2["sa_bridge_com_vol"] = "unaware";
  var_2["sa_barracks_vol"] = "unaware";
  var_2["sa_sternport_rooma_vol"] = "unaware";
  var_2["sa_sternport_roomb_vol"] = "unaware";
  var_2["sa_bowupper_roomb_vol"] = "unaware";
  var_2["sac_hubstern_port_vol"] = "unaware";
  var_2["sac_portlower_vol"] = "unaware";
  var_2["sa_starboard_lower_vol"] = "unaware";
  var_2["sa_starboard_lower_rooma_vol"] = "unaware";
  var_2["sac_bowupper_vol"] = "unaware";
  var_3 = [];
  var_3["sa_hangar_vol"] = "sa_hangar_combat_vol";
  var_3["sa_armory_room_vol"] = "sa_armory_combat_vol";
  var_3["sa_hubstern_vol"] = "sa_hubstern_combat_vol";
  var_3["sa_hubbow_vol"] = "sa_hubbow_combat_vol";
  var_3["sa_bridge_vol"] = "sa_bridge_combat_vol";
  var_3["sa_bridge_com_vol"] = "sa_bridge_com_combat_vol";
  var_3["sa_barracks_vol"] = "sa_barracks_combat_vol";
  var_3["sa_sternport_rooma_vol"] = "sa_sternport_rooma_combat_vol";
  var_3["sa_sternport_roomb_vol"] = "sa_sternport_roomb_combat_vol";
  var_3["sa_bowupper_roomb_vol"] = "sa_bowupper_roomb_combat_vol";
  var_3["sa_barracks_vol"] = "sa_barracks_combat_vol";
  var_3["sa_starboard_lower_rooma_vol"] = "sa_starboard_lower_rooma_combat_vol";
  var_3["sac_hubstern_port_vol"] = "sac_hubstern_port_combat_vol";
  var_3["sac_portlower_vol"] = "sac_portlower_combat_vol";
  var_3["sa_starboard_lower_vol"] = "sa_starboard_lower_combat_vol";
  var_3["sac_bowupper_vol"] = "sac_bowupper_combat_vol";
  _id_0F0C::_id_E9E4(var_1, var_2, var_3, ::_id_79F8, ::_id_7B73, ::_id_7913);
}

_id_88F7() {
  scripts\engine\utility::flag_wait("event_turrets_down");
  scripts\engine\utility::flag_wait("event_capitalship_down");
}

_id_13E9B() {
  scripts\sp\utility::_id_F5AF("zerog_combat_start", [level.player]);
  var_0 = scripts\engine\utility::getStruct("zerog_combat_start", "targetname");
  level._id_D127 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(level._id_D127, var_0, "assault_mode");
}