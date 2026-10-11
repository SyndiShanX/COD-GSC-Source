/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_28a77d87ba9d1de5.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_24fbedba9a7a1ef4;
#using script_3a8f9ace195c9da9;
#using script_3b0812a5fdfecf0;
#using script_41abe5ab9dd2b8fa;
#using script_48324b060b129b7b;
#using script_737f801e6beb18c7;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\laststand;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\engine\scriptable_ascender;
#using scripts\engine\utility;
#namespace namespace_89c3ab7b9669ae5a;

function function_e0cb0c471c8390dd() {
  level endon("game_ended");
  level endon("tracker_done");
  vo_init();
  flag_wait_any("flag_dungeon_intro_complete", "flag_dungeon_start_vo");
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();
  is_first_time = !isDefined(function_69fa4a2561ada985("introFinished")) && checkpoint == "";
  childthread vo_intro(is_first_time, checkpoint);
  childthread function_e839281e26b3b853();
  childthread vo_red_alert();
  flag_wait("vo_intro_finished");
  childthread function_1d0c3a8419f09db3();
  childthread function_4717a003070a5023();
  childthread function_b429bbacf52cc809();
  childthread function_ddb529054ae6c549();
  childthread function_47cb26ce5b67bc8c();
  childthread function_5fd00c1d1a6f2d02();
  childthread function_a4fc183dfeccb918();

  if(!is_equal(checkpoint, "found_gps_and_rfid")) {
    if(!is_equal(checkpoint, "found_gps_tracker")) {
      childthread function_de3c72713813c9e6(checkpoint);
    }

    if(!is_equal(checkpoint, "found_rfid_reader")) {
      childthread function_df08f850818fbe66(checkpoint);
    }

    flag_wait("ShipTower_Objectives_Intro");
    function_19371345edf0e95a();
    childthread function_904ca5f20664ac7a();
    childthread function_220c095ea04f61bc();
  }

  childthread function_ff7751f2a3de38be();
  flag_wait_all("flag_trackers_retrieved", "flag_manifest_retrieved");
  thread function_e5d3f41bd8738f8f(checkpoint);
}

function function_4c047b72e92b2026() {
  if(flag("scene_skipped")) {
    return;
  }

  level endon("scene_skipped");
  level.player playSound("port_infil_radio_sfx");
  wait 1;
  level.player say("dx_cp_port_iwa3_alex_thisisecho31troopsin");
  wait 0.5;
  level.player say("dx_cp_port_iwa0_alex_isayagaintroopsinthe");
  wait 0.2;
  level.player say("dx_cp_port_iwa3_grav_copythatholdyourposi");
  wait 2.1;
  level.player say("dx_cp_port_iwa3_grav_shadow01tokilodoyour");
  wait 1.7;
  level.player say("dx_cp_port_iwa3_grav_kilofarahdoyoucopy");
}

function vo_init() {
  level.graves = level;
  level.alex = level;
  level.farah = level.player;
  level.vo = function_69fa4a2561ada985("vo_struct");

  if(!isDefined(level.vo)) {
    level.vo = spawnStruct();
    function_2311740fe797906a("vo_struct", level.vo);
  }

  scripts\common\callbacks::add("player_vehicle_enter", &function_cd3ddd11020f508e);
  scripts\common\callbacks::add("player_vehicle_exit", &function_a7c26196ab875253);
  var_31aef45453ecbda0 = [(6854.21, -3879.57, 371.91), (1751.5, -5159.5, 1.5), (4700, -6397.5, 1), (829.5, -4695.5, 296), (1017, -2778.5, 0), (842, -5105.5, 1), (1026, -5357, 136), (6234.5, -4045.5, 372), (1035, -4921, 1), (1178.96, -2242.79, 47.3004), (4223, -2965, 8), (1391, -4661.5, 0), (1689, -5415, 1.5), (983, -5315, 1), (631.825, -4863.75, 136.402), (1625.5, -5598, 1.5), (2757.28, -6312.64, -0.125), (3675.35, -6697.55, 9.25025), (6751.97, -4256.05, 371.91), (3829.35, -6727.05, 7.24988), (3825.84, -6629.38, 8), (6150.29, -2485.36, 206.91), (6163.5, -3854, 372), (4826.35, -6369.05, -0.75012), (6329.5, -4104, 372), (818.5, -2064.5, 47.5), (6537, -3336, 268), (6297, -3597, 372), (1992.4, -5586.13, -2.00012), (4578, -3849, 111), (1967.4, -5496.13, -2.00012), (2363.28, -6276.64, -0.125), (1273.11, -5074.77, 296.152), (2275.78, -6242.14, -0.125), (2392.78, -5806.14, -0.125), (4372.5, -3026, 8), (2044.78, -6359.14, -0.125), (3381.72, -6276.36, -0.125), (524.5, -4819, 1), (1162.11, -5313.77, 296.152), (6249.86, -2290.81, 207.91), (6437.51, -3875.43, 371.91), (1102.5, -4941, 1), (1327.5, -4615, 0), (3744, -3387.5, 8), (6402.5, -3299, 164), (1570, -5311, 1.5), (3758, -3315.5, 8), (1071.5, -2710.5, -0.5), (6390, -2901, 208), (1665, -5384.5, 1), (6624.5, -4064, 372), (1775.5, -4678.5, 0.5), (1377.5, -5256.5, 1), (6380, -2437.5, 211), (6658.5, -3446, 268), (753.465, -4493.07, 296.152), (1309.2, -5257.5, 136.152), (884, -4933, 136)];
  var_cf47821a07174187 = [];

  for(i = 0; i < var_31aef45453ecbda0.size; i++) {
    var_cf47821a07174187[i] = spawnStruct();
    var_cf47821a07174187[i].origin = var_31aef45453ecbda0[i] + (0, 0, 27.5);
  }

  level.vo.var_cf47821a07174187 = var_cf47821a07174187;
  level.vo.var_ed8c0f68867ab0ff = 0;
  level.vo.var_ca9e7a5abc36e84a = 0;
  level.var_6e6f83686e847254 = 0;
}

function vo_intro(first_time, checkpoint) {
  weaponlist = level.player getweaponslistprimaries();
  var_31cb970d30a8ce47 = 0;

  foreach(weapon in weaponlist) {
    if(!istrue(weapon.ismelee)) {
      var_31cb970d30a8ce47 = 1;
      break;
    }
  }

  if(first_time) {
    var_155e8b2de84f997d = [level.farah, 0.3, "dx_cp_port_iwa3_fara_thisiskilowewereambu", level, 0.2, "dx_cp_port_iwa3_alex_itskonnitheyreeveryw", level.farah, 0.3, "dx_cp_port_iwa3_fara_themissilestheyregoi", level.graves, 0.2, "dx_cp_port_iwa3_grav_wecantletthemdothatf", &function_712bfb508ccdf975, level.farah, 0.4, "dx_cp_port_iwa3_fara_ineedweapons", &function_712bfb508ccdf975, level.graves, 0.3, "dx_cp_port_iwa3_grav_lookforcontainerswit_01", &function_712bfb508ccdf975, level.farah, 0.2, "dx_cp_port_iwa3_fara_youwereshippingmoret", &function_712bfb508ccdf975, level.graves, 0.3, "dx_cp_port_iwa3_grav_plentymoreluckyforyo"];
    var_6af2aa8cbc99edec = [level.farah, 0, "dx_cp_port_iwa1_fara_kiloactualtoshadow01", level.graves, 0.6, "dx_cp_port_pinr_grav_shadow01tokilokonnii"];
    wait 3;

    if(!istrue(var_31cb970d30a8ce47)) {
      say_sequence(var_155e8b2de84f997d, 1, 1, 0, 1.5);
    } else {
      say_sequence(var_6af2aa8cbc99edec, 1, 1, 0, 1.5);
    }

    flag_set("vo_intro_finished");
    function_2311740fe797906a("introFinished", 1);
    return;
  }

  if(!isDefined(level.vo.var_d780475abf315691)) {
    aliases = ["dx_cp_port_pinr_grav_farahyouregonnaneedw", "dx_cp_port_pinr_grav_kilolookforcontainer", "dx_cp_port_pinr_grav_konniisgoingforthemi", "dx_cp_port_pinr_grav_containerswithshadow", "dx_cp_port_pinr_grav_shadow01tokilokonnii", "dx_cp_port_pinr_grav_gearupandstopkonnifr", "dx_cp_port_pinr_grav_findcontainersmarked", "dx_cp_port_pinr_grav_wecantletkonnisecure"];
    level.vo.var_d780475abf315691 = create_deck(aliases, 1, 1, 1);
  }

  function_e6896df0edffd880();

  if(is_equal(checkpoint, "")) {
    sequence = [level.graves, 0, level.vo.var_d780475abf315691 deck_draw()];
    say_sequence(sequence, 1, 1, 0, 0.5);
  }

  flag_set("vo_intro_finished");
}

function function_712bfb508ccdf975() {
  if(flag("player_at_ftue_container") || flag("first_gear_container_done")) {
    return 0;
  }

  return undefined;
}

function function_f167dd6c002180f1() {
  level endon("player_at_ftue_container");
  level endon("first_gear_container_done");
  var_7cd60be27834d865 = ["first_gear_container_done", "flag_enter_hmo", "flag_board_ship"];

  if(flag_any(var_7cd60be27834d865)) {
    return;
  }

  var_5575746405992588 = (2425.82, -492.58, 47.86);
  var_3966b866f26b07a3 = spawnStruct();
  var_3966b866f26b07a3.origin = var_5575746405992588;

  while(distance2dsquared(level.player.origin, var_3966b866f26b07a3.origin) > 122500) {
    wait 0.1;
  }

  sequence = [level.farah, 0, "dx_cp_port_aoco_fara_imatthecontainer", level.graves, 0.2, "dx_cp_port_rene_grav_copy"];
  say_sequence(sequence, 0.5, 2, 0, 0.5);
}

function function_e839281e26b3b853() {
  level endon("flag_enter_hmo");
  level endon("flag_board_ship");
  var_7cd60be27834d865 = ["first_gear_container_done", "flag_enter_hmo", "flag_board_ship"];
  flag_clear("player_at_ftue_container");

  if(flag_any(var_7cd60be27834d865)) {
    return;
  }

  childthread function_f167dd6c002180f1();
  function_d14fcd3a04720601("ftue_container_gear_exit");
  flag_set("player_at_ftue_container");
  var_2f7074ffdef8296e = [level.farah, 0.3, "dx_cp_port_sgsm_fara_foundansmg", level.graves, 0.5, "dx_cp_port_sgsm_grav_shouldalreadyhaveasu"];
  var_4c08cd56d8f4179a = [level.farah, 0.4, "dx_cp_port_sgar_fara_gotanar", level.graves, 0.5, "dx_cp_port_sgar_grav_gladwepackedone", level.farah, 0.5, "dx_cp_port_sgar_fara_nosuppressor", level.graves, 0.4, "dx_cp_port_sgar_grav_yeahthatllmakesomeno"];
  var_a21e2e53b88f05bb = [level.farah, 0.4, "dx_cp_port_sgtk_fara_throwingknives", level.graves, 0.5, "dx_cp_port_sgtk_grav_theyrequietanddeadly", level.farah, 0.6, "dx_cp_port_sgtk_fara_ifyouknowhowtousethe", level.graves, 0.5, "dx_cp_port_sgtk_grav_isuspectyoudo", level.farah, 0.5, "dx_cp_port_sgtk_fara_youreright"];
  var_29f0715ebc724abc = [level.farah, 0.4, "dx_cp_port_shpa_fara_grabbingaparachute", level.graves, 0.3, "dx_cp_port_shpa_grav_smartplentyofhighpla"];
  var_d0a24ff0a029822 = [level.farah, 0.4, "dx_cp_port_shtg_fara_someteargasinhere", level.graves, 0.5, "dx_cp_port_shtg_grav_thatlltaketheirbreat"];
  var_efd4fe9b81337bd0 = [level.farah, 0.6, "dx_cp_port_shap_fara_armorplatesinhand", level.graves, 0.5, "dx_cp_port_shap_grav_nobrainerforabsorbin"];
  pickups = ["brloot_armor_plate": var_efd4fe9b81337bd0, "brloot_offhand_gas": var_d0a24ff0a029822, "cp_parachute_activator": var_29f0715ebc724abc, "brloot_offhand_throwingknife": var_a21e2e53b88f05bb, "brloot_weapon_generic_ar": var_4c08cd56d8f4179a, "brloot_weapon_generic_sm": var_2f7074ffdef8296e];
  level childthread function_e09f7e197d632f3d(pickups);
  flag_wait("first_gear_container_done");
  level childthread function_8bdc2fcd048b8a97();

  if(flag("ShipTower_Objectives_Intro")) {
    return;
  }

  sequence = [level.graves, 0.5, "dx_cp_port_stoi_grav_farahthatgeargivesyo", level.farah, 0.2, "dx_cp_port_stoi_fara_iwillnotallowkonnito", level.graves, 0.5, "dx_cp_port_stoi_grav_weregonnaneedacontin"];
  say_sequence(sequence, 1, 5, 0, 0.5);
  flag_set("ShipTower_Objectives_Intro");
}

function function_e09f7e197d632f3d(pickups) {
  while(!flag("intro_leaving_container")) {
    level waittill("pickedupweapon_all", pickupent);

    if(flag("intro_leaving_container")) {
      break;
    }

    if(!isDefined(pickupent) || !isDefined(pickupent.scriptablename) || istrue(pickupent.isautouse)) {
      continue;
    }

    pickup_name = pickupent.scriptablename;

    if(!array_contains_key(pickups, pickup_name)) {
      continue;
    }

    sequence = pickups[pickup_name];
    played = say_sequence(sequence, 0.2, 0.2, 0, 0.5);

    if(istrue(played)) {
      pickups = array_remove_key(pickups, pickup_name);
    }
  }
}

function function_8bdc2fcd048b8a97() {
  function_d14fcd3a04720601("ftue_container_gear_exit");
  flag_set("intro_leaving_container");
}

function function_1d0c3a8419f09db3() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_565dc6390c37290d)) {
    aliases = ["dx_cp_port_pina_grav_konnisnotwaitingfory", "dx_cp_port_pina_grav_adviseyougearupfastk", "dx_cp_port_pina_grav_takewhatyouneedfromt", "dx_cp_port_pina_grav_knifesnotgonnabeenou", "dx_cp_port_pina_grav_farahgetgearedupbefo"];
    level.vo.var_565dc6390c37290d = create_deck(aliases, 1, 1, 1);
  }

  var_7cd60be27834d865 = ["ShipTower_Objectives_Intro", "first_gear_container_done", "flag_enter_hmo", "flag_board_ship"];

  while(true) {
    wait 45;

    if(flag_any(var_7cd60be27834d865)) {
      return;
    }

    level thread function_c3c9f3a78b693fda();
    sequence = [level.graves, 0.9, level.vo.var_565dc6390c37290d deck_draw(), &function_84d907e2af3c9eb4];
    say_sequence(sequence, 0, 3, 0, 0.5);
  }
}

function function_e6896df0edffd880() {
  if(!isDefined(level.vo.var_c10a52e31a9ccb7c)) {
    aliases = ["dx_cp_port_pids_grav_watchforanymovingmac", "dx_cp_port_pids_grav_eyesupwhencrossingth", "dx_cp_port_pids_grav_machinerysautomatedf", "dx_cp_port_pids_grav_machinerysactivekilo", "dx_cp_port_pids_grav_carefulcrossingthose"];
    level.vo.var_c10a52e31a9ccb7c = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pidl_grav_keepaneyeoutkilogotg", "dx_cp_port_pidl_grav_watchyourselffarahgo", "dx_cp_port_pidl_grav_watchforthosegantryw", "dx_cp_port_pidl_grav_gantriesareautomated", "dx_cp_port_pidl_grav_carefulwiththosegant"];
    level.vo.var_f90674adaca1327f = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pidr_grav_keepyoureyespeeledfo", "dx_cp_port_pidr_grav_stayclearofanyjltvsk", "dx_cp_port_pidr_grav_watchforenemyvehicle", "dx_cp_port_pidr_grav_konnimighthavevehicl", "dx_cp_port_pidr_grav_hostilevehiclesinthe"];
    level.vo.var_329848be6a16ad48 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pide_grav_checkfireontheoilbar", "dx_cp_port_pide_grav_farahkeepyourshotsaw", "dx_cp_port_pide_grav_portsgotflammableswa", "dx_cp_port_pide_grav_advisetriggerdiscipl", "dx_cp_port_pide_grav_lotofoilbarrelsaroun"];
    level.vo.var_230e1d47852abb60 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pidd_grav_theresheavyundertows", "dx_cp_port_pidd_grav_keepyourfeetonsolidg", "dx_cp_port_pidd_grav_gearllpullyoudownint", "dx_cp_port_pidd_grav_keepyourfeetdrykiloy"];
    level.vo.var_578dd9e52aa81f5 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pidg_grav_konnismovinginhardki", "dx_cp_port_pidg_grav_watchyourassdownther", "dx_cp_port_pidg_grav_dontletkonnigettheup", "dx_cp_port_pidg_grav_staysharpkilokonniwo", "dx_cp_port_pidg_grav_expectcontactfarahko"];
    level.vo.var_f64b71874263251a = create_deck(aliases, 1, 1, 1);
  }

  var_87def50a330b5c5b = ["explosion": level.vo.var_230e1d47852abb60, "hitnRun": level.vo.var_329848be6a16ad48, "gantryHitnRun": level.vo.var_f90674adaca1327f, "gantrySquish": level.vo.var_c10a52e31a9ccb7c, "drown": level.vo.var_578dd9e52aa81f5, "generic": level.vo.var_f64b71874263251a];
  deathBy = function_69fa4a2561ada985("deathBy");

  if(!isDefined(deathBy) || !array_contains_key(var_87def50a330b5c5b, deathBy)) {
    return;
  }

  sequence = [level.graves, 0, var_87def50a330b5c5b[deathBy] deck_draw()];
  say_sequence(sequence, 1, 1, 0, 0.5);
}

function function_19371345edf0e95a() {
  var_61753ae8124ce989 = ["flag_trackers_retrieved", "flag_manifest_retrieved"];

  if(flag_any(var_61753ae8124ce989)) {
    flag_set("vo_objective_intro_done");
    return;
  }

  sequence = [level.graves, 0.6, "dx_cp_port_stoi_grav_commanderihavegpstra", level.farah, 0.5, "dx_cp_port_stoi_fara_istillneedtolocateth", level.graves, 0.6, "dx_cp_port_stoi_grav_shippingmanifestswou", level.farah, 0.3, "dx_cp_port_stoi_fara_thetower", level.graves, 0.4, "dx_cp_port_stoi_grav_affirmative", level.farah, 0.3, "dx_cp_port_stoi_fara_copythat"];
  say_sequence(sequence, 1, 1, 0, 0);
  flag_set("vo_objective_intro_done");
}

function function_904ca5f20664ac7a() {
  if(!isDefined(level.vo.var_285efae5199ee468)) {
    aliases = ["dx_cp_port_ston_grav_grabthegpstrackersan", "dx_cp_port_ston_grav_lookformanifestsinth", "dx_cp_port_ston_grav_headtotheshiportheto", "dx_cp_port_ston_grav_cantletthesemissiles", "dx_cp_port_ston_grav_weneedthegpstrackers", "dx_cp_port_ston_grav_cantletkonnigetawayw", "dx_cp_port_ston_grav_theshipandthetowerha"];
    level.vo.var_285efae5199ee468 = create_deck(aliases, 1, 1, 1);
  }

  var_7cd60be27834d865 = ["flag_enter_hmo", "flag_board_ship", "flag_trackers_retrieved", "flag_manifest_retrieved"];

  while(true) {
    wait 45;

    if(flag_any(var_7cd60be27834d865)) {
      return;
    }

    if(isDefined(level.var_c822dc207b2239db)) {
      if(!time_has_passed(level.var_c822dc207b2239db, 30)) {
        continue;
      }
    }

    sequence = [level.graves, 0, level.vo.var_285efae5199ee468 deck_draw(), &function_84d907e2af3c9eb4];
    say_sequence(sequence, 0, 1, 0, 0.5);
  }
}

function function_df08f850818fbe66(checkpoint) {
  if(flag("flag_manifest_retrieved")) {
    return;
  }

  if(!isDefined(level.vo.var_e7cb7bc4490e3827)) {
    aliases = ["dx_cp_port_ntnc_fara_01beadvisedapproachi", "dx_cp_port_ntnc_fara_nearingthetowerhosti", "dx_cp_port_ntnc_fara_nearingtheharbortowe", "dx_cp_port_ntnc_fara_approachingharbortow", "dx_cp_port_ntnc_fara_closingonthetowerkon"];
    level.vo.var_e7cb7bc4490e3827 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ntoc_fara_almosttothetower", "dx_cp_port_ntoc_fara_approachingthetower", "dx_cp_port_ntoc_fara_nearingthetower", "dx_cp_port_ntoc_fara_closingonthetower", "dx_cp_port_ntoc_fara_nearingtowernow"];
    level.vo.var_e5e0f8fd09fe6ed0 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_atoo_fara_atthetower", "dx_cp_port_atoo_fara_inthetower01", "dx_cp_port_atoo_fara_insidethetower", "dx_cp_port_atoo_fara_reachedthetower"];
    level.vo.var_8150889ae93205aa = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_atoo_grav_copylookforthemanife", "dx_cp_port_atoo_grav_goodkilosearchitfort", "dx_cp_port_atoo_grav_copythatlocatetheman", "dx_cp_port_atoo_grav_manifestshouldbether"];
    level.vo.var_f407c9823407454d = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nnnn_fara_atthetower", "dx_cp_port_nnnn_fara_inthetower", "dx_cp_port_nnnn_fara_insidetower"];
    level.vo.var_4ee608a57004fbf7 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nnnn_grav_lookforthemanifest", "dx_cp_port_nnnn_grav_searchforthemanifest", "dx_cp_port_nnnn_grav_locatethemanifestkil"];
    level.vo.var_6f89fd458652feae = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ator_grav_konnillbelookingfori", "dx_cp_port_ator_grav_keepyoureyesopenkonn"];
    level.vo.var_5ed1f9f47b00f033 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_aorc_grav_konnineedsitasmuchas", "dx_cp_port_aorc_grav_konnissearchingforit", "dx_cp_port_aorc_grav_konniwantsittoobeate"];
    level.vo.var_6f1e63ba3d13c2cc = create_deck(aliases, 1, 1, 1);
    aliases = [];
    aliases[aliases.size] = "dx_cp_port_stor_grav_searchthemainofficet";
    aliases[aliases.size] = "dx_cp_port_stor_grav_towersthirdflooroffi";
    aliases[aliases.size] = "dx_cp_port_stor_grav_searchdenasofficethi";
    aliases[aliases.size] = "dx_cp_port_stor_grav_harbormastersoffices";
    level.vo.var_5ea5ae05b599ab5d = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_9f4066036fe78be3)) {
    aliases = ["dx_cp_port_loto_fara_gotthemanifest", "dx_cp_port_loto_fara_ifoundthemanifestgra", "dx_cp_port_loto_fara_manifestinhand01", "dx_cp_port_loto_fara_manifestishere"];
    level.vo.var_9f4066036fe78be3 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_qqqq_fara_manifestlocated", "dx_cp_port_qqqq_fara_foundthemanifest", "dx_cp_port_qqqq_fara_locatedthemanifest"];
    level.vo.var_b44a36dbcc13d1c = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_893fb567d7c0a65f)) {
    aliases = ["dx_cp_port_rt2s_grav_excellentthegpstrack"];
    level.vo.var_893fb567d7c0a65f = create_deck(aliases, 1, 1, 1);
  }

  if(is_equal(checkpoint, "found_gps_tracker")) {
    function_eb7328ff9bae5a5d("tower", undefined, 1);
    childthread function_aa9ab7df2a7e6f8b(1, "tower", 1);
  }

  function_d14fcd3a04720601("trig_vo_hmo");
  flag_set("ShipTower_Objectives_Intro");
  function_d14fcd3a04720601("trig_vo_hmo_near");
  flag_set("flag_vo_hmo_near");
  sequence = [level.player, 0, function_cd70fbc5ff85bc7d(level.vo.var_e5e0f8fd09fe6ed0, level.vo.var_e7cb7bc4490e3827)];
  played = say_sequence(sequence, 0, 4, 0, 0.5);
  flag_wait("flag_enter_hmo");
  sequence = [level.player, 0.4, function_cd70fbc5ff85bc7d(level.vo.var_4ee608a57004fbf7, level.vo.var_8150889ae93205aa), level.graves, 0.5, function_cd70fbc5ff85bc7d(level.vo.var_5ea5ae05b599ab5d, level.vo.var_5ea5ae05b599ab5d)];
  played = say_sequence(sequence, 0.5, 4, 0, 0.5);
  childthread function_30415684896f8ce1();
  childthread function_5225f55238ee67b1();
  flag_wait("flag_manifest_retrieved");
  sequence = [level.player, 0.4, function_cfa4b3e55017bda7(level.vo.var_b44a36dbcc13d1c, level.vo.var_9f4066036fe78be3)];
  played = say_sequence(sequence, 1, 3, 0, 0.5);

  if(flag("flag_trackers_retrieved")) {
    return;
  }

  sequence = [level.graves, 0.4, level.vo.var_893fb567d7c0a65f deck_draw()];
  played = say_sequence(sequence, 1, 3, 0, 0.5);
  function_eb7328ff9bae5a5d("ship", 1);
  thread function_4d9590ff10fb8b6a();
}

function function_34e62ddce67ef1fb(type) {
  if(!isDefined(level.vo.checkin)) {
    aliases = ["dx_cp_port_chin_grav_talktomekilo", "dx_cp_port_chin_grav_gimmethesitrepkilo", "dx_cp_port_chin_grav_statusupdate", "dx_cp_port_chin_grav_status", "dx_cp_port_chin_grav_farahwhatstheworddow", "dx_cp_port_chin_grav_kilohowwelooking", "dx_cp_port_chin_grav_checkinkilo", "dx_cp_port_chin_grav_kilositrep", "dx_cp_port_chin_grav_shadowtokilowhatsthe", "dx_cp_port_chin_grav_anyupdateskilo", "dx_cp_port_chin_grav_kilotalktome", "dx_cp_port_chin_grav_whereareweatkilo"];
    level.vo.checkin = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_rene_grav_copy", "dx_cp_port_rene_grav_roger", "dx_cp_port_rene_grav_understood", "dx_cp_port_rene_grav_solidcopy", "dx_cp_port_rene_grav_rog", "dx_cp_port_rene_grav_ok", "dx_cp_port_rene_grav_keepmoving", "dx_cp_port_rene_grav_gotit", "dx_cp_port_rene_grav_check", "dx_cp_port_rene_grav_gotcha", "dx_cp_port_rene_grav_stayalert"];
    level.vo.var_9bad0e649d1c9dbe = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_rego_grav_alright", "dx_cp_port_rego_grav_goodwork", "dx_cp_port_rego_grav_nicelydone", "dx_cp_port_rego_grav_good", "dx_cp_port_rego_grav_excellent", "dx_cp_port_rego_grav_allyoucommander", "dx_cp_port_rego_grav_notbad", "dx_cp_port_rego_grav_outfuckinstandingkil", "dx_cp_port_rego_grav_thatissomeseriouslyh", "dx_cp_port_rego_grav_seriousbadasseryfara"];
    level.vo.var_bdfa716d95f3068e = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_reba_grav_whataclusterfuck", "dx_cp_port_reba_grav_fuckincircus", "dx_cp_port_reba_grav_notgood", "dx_cp_port_reba_grav_nottoobueno", "dx_cp_port_reba_grav_nothappytohearthat", "dx_cp_port_reba_grav_yougotthis", "dx_cp_port_reba_grav_thatsunfortunate", "dx_cp_port_reba_grav_thatsregretful", "dx_cp_port_reba_grav_thatissubstandard", "dx_cp_port_reba_grav_thatslessthanideal", "dx_cp_port_reba_grav_fubar"];
    level.vo.var_4bf3f10321726182 = create_deck(aliases, 1, 1, 1);
    level.vo.var_bda3f1aea00d7672 = ["bad": level.vo.var_4bf3f10321726182, "good": level.vo.var_bdfa716d95f3068e, "neutral": level.vo.var_9bad0e649d1c9dbe, "checkin": level.vo.checkin];
  }

  if(!array_contains_key(level.vo.var_bda3f1aea00d7672, type)) {
    assertmsg("Generic graves response type '" + type + "' does not exist.");
    return;
  }

  var_653b5f47eb2af262 = level.vo.var_bda3f1aea00d7672[type] deck_draw();
  sequence = [level.graves, 0, var_653b5f47eb2af262];
  played = say_sequence(sequence, 1, 1, 0, 0.5);
}

function function_5225f55238ee67b1() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_48492a29fb379b8d)) {
    aliases = ["dx_cp_port_sto1_fara_theshippingmanifestm", "dx_cp_port_sto1_fara_themanifestshouldbei", "dx_cp_port_sto1_fara_shippingmanifesthast", "dx_cp_port_sto1_fara_themanifestshouldbeh", "dx_cp_port_sto1_fara_manifestshouldbesome"];
    level.vo.var_48492a29fb379b8d = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_stor_grav_searchthemainofficet", "dx_cp_port_stor_grav_towersthirdflooroffi", "dx_cp_port_stor_grav_searchdenasofficethi", "dx_cp_port_stor_grav_harbormastersoffices"];
    level.vo.var_44a676204e395db3 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_sto4_fara_needtofindthatmanife", "dx_cp_port_sto4_fara_lookingforthemanifes", "dx_cp_port_sto4_fara_manifestshouldbenear", "dx_cp_port_sto4_fara_themanifestcantbefar"];
    level.vo.var_4cce219c198479b6 = create_deck(aliases, 1, 1, 1);
  }

  delay = growing_delay(15, 30, 3);

  while(!flag("flag_manifest_retrieved")) {
    waitfor(delay);

    if(flag("SHIP_ACTIVE")) {
      flag_wait("HMO_ACTIVE");
      continue;
    }

    if(flag("flag_manifest_retrieved") || flag("flag_third_floor_trigger")) {
      break;
    }

    var_cb7fcc660aafd7bc = [level.player, 0.3, level.vo.var_48492a29fb379b8d deck_draw(), level.graves, 0.3, level.vo.var_44a676204e395db3 deck_draw()];
    var_9ed18883d5c763a1 = [level.player, 0.4, level.vo.var_4cce219c198479b6 deck_draw(), level.graves, 0.3, level.vo.var_44a676204e395db3 deck_draw()];
    sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
    played = say_sequence(sequence, 0.5, 4, 0, 0.5);
  }

  if(!isDefined(level.vo.var_57731cc8f80517f6)) {
    aliases = ["dx_cp_port_netr_grav_checkaroundthedeskma", "dx_cp_port_netr_grav_harbormastersareorga", "dx_cp_port_netr_grav_idstartwiththedeskma"];
    level.vo.var_57731cc8f80517f6 = create_deck(aliases, 1, 1, 1);
  }

  delay = growing_delay(12, 25, 3);

  while(!flag("flag_manifest_retrieved")) {
    waitfor(delay);

    if(flag("SHIP_ACTIVE") || function_a7c8f01b64b95e8e()) {
      flag_wait("HMO_ACTIVE");
      continue;
    }

    if(flag("flag_manifest_retrieved")) {
      break;
    }

    sequence = [level.graves, 0, level.vo.var_57731cc8f80517f6 deck_draw()];
    played = say_sequence(sequence, 0.5, 4, 0, 0.5);
  }
}

function function_30415684896f8ce1() {
  level endon("game_ended");
  level endon("flag_manifest_retrieved");

  if(!isDefined(level.vo.var_63c740be7d0e52a8)) {
    aliases = ["dx_cp_port_nt1n_fara_onthethirdfloorneart", "dx_cp_port_nt1n_fara_reachedthethirdfloor", "dx_cp_port_nt1n_fara_searchingthirdfloorf", "dx_cp_port_nt1n_fara_imneartheofficeonthe", "dx_cp_port_nt1n_fara_closingontheofficefo"];
    level.vo.var_63c740be7d0e52a8 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nt1c_fara_thirdfloorlookingfor", "dx_cp_port_nt1c_fara_thirdfloorofficeiscl", "dx_cp_port_nt1c_fara_onthethirdfloorneart", "dx_cp_port_nt1c_fara_atthethirdflooroffic"];
    level.vo.var_61d9dc5291de40a3 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_57731cc8f80517f6)) {
    aliases = ["dx_cp_port_netr_grav_checkaroundthedeskma", "dx_cp_port_netr_grav_harbormastersareorga", "dx_cp_port_netr_grav_idstartwiththedeskma"];
    level.vo.var_57731cc8f80517f6 = create_deck(aliases, 1, 1, 1);
  }

  var_9ed18883d5c763a1 = [level.player, 0.3, level.vo.var_61d9dc5291de40a3 deck_draw(), level.graves, 0.3, level.vo.var_57731cc8f80517f6 deck_draw()];
  var_cb7fcc660aafd7bc = [level.player, 0.2, level.vo.var_63c740be7d0e52a8 deck_draw(), level.graves, 0.3, level.vo.var_57731cc8f80517f6 deck_draw()];
  childthread function_74f9d60daf519a3a();
  flag_wait_any("flag_third_floor", "flag_third_floor_trigger");
  sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
  played = say_sequence(sequence, 1, 4, 0, 0.5);

  if(istrue(played) && function_84d907e2af3c9eb4()) {
    thread function_aa9ab7df2a7e6f8b(2, "tower");
  }
}

function function_74f9d60daf519a3a() {
  level endon("game_ended");
  level endon("flag_manifest_retrieved");
  function_d14fcd3a04720601("trig_vo_hmo_thirdfloor");
  flag_set("flag_third_floor_trigger");
}

function function_4717a003070a5023() {
  level endon("game_ended");
  level.vo.var_4202c8d1d8952b1e = 0;
  scripts\engine\scriptable_ascender::function_547c48dc070b2109(&function_86b50d50e22de606);
  scripts\engine\scriptable_ascender::function_de7ceb99406215a9(&function_9d7443fd43cded76);

  if(flag("ascender_obj_complete")) {
    return;
  }

  flag_wait("ascender_obj_starting");
  function_182e777b9a80fd28();
  flag_set("ascender_obj_starting_vo_finished");
  function_8e60856af14db88e();
  flag_wait("ascender_picked_up");
  function_fd637bed854b2ba8();
}

function function_86b50d50e22de606(instance, player, edgeindex, isinverted, isvertical, ascendervec) {
  if(!isDefined(isinverted) || !isDefined(ascendervec)) {
    return;
  }

  var_aebff5030f63a8b4 = ascendervec[2];
  going_up = var_aebff5030f63a8b4 > 0 && !isinverted || var_aebff5030f63a8b4 < 0 && isinverted;

  if(!going_up || level.vo.var_4202c8d1d8952b1e > gettime()) {
    return;
  }

  if(!isDefined(level.vo.var_d83257f80148c5ac)) {
    aliases = ["dx_cp_port_usas_fara_ascending", "dx_cp_port_usas_fara_headingup", "dx_cp_port_usas_fara_goinghigh", "dx_cp_port_usas_fara_grunt", "dx_cp_port_usas_fara_grunt_01", "dx_cp_port_usas_fara_grunt_02"];
    level.vo.var_d83257f80148c5ac = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_usas_fara_grunt", "dx_cp_port_usas_fara_grunt_01", "dx_cp_port_usas_fara_grunt_02"];
    level.vo.var_fdcd202beea711fd = create_deck(aliases, 1, 1, 1);
  }

  wait 0.15;

  if(!function_a7c8f01b64b95e8e()) {
    sequence = [level.player, 0.3, level.vo.var_d83257f80148c5ac deck_draw()];
    played = say_sequence(sequence, 0, 1, 0, 0.5);
  } else {
    sequence = [level.player, 0.4, level.vo.var_fdcd202beea711fd deck_draw()];
    played = say_sequence(sequence, 0, 1, 0, 0.5);
  }

  played = default_to(played, 0);
  level.vo.var_4202c8d1d8952b1e = gettime() + 7500 * played;
}

function function_9d7443fd43cded76(instance, player, edgeindex, isvertical, isinverted, isgoingup) {
  level.var_53dde20ce19c6235 = undefined;

  if(flag("ascender_obj_starting")) {
    return;
  }

  if(!isDefined(level.vo.var_428c4e20fbe6df5a)) {
    aliases = ["dx_cp_port_nacn_fara_foundacable", "dx_cp_port_nacn_fara_goteyesonacable", "dx_cp_port_nacn_fara_seeingacablethere", "dx_cp_port_nacn_fara_theresacable", "dx_cp_port_nacn_fara_spottedacable"];
    level.vo.var_428c4e20fbe6df5a = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nanr_grav_canuseanascendertosc", "dx_cp_port_nanr_grav_anascenderdmakequick"];
    level.vo.var_94c64ce4c942c80c = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nacc_fara_eyesonascendercable", "dx_cp_port_nacc_fara_ascendercable", "dx_cp_port_nacc_fara_ascendercablespotted", "dx_cp_port_nacc_fara_iseeanascendercable"];
    level.vo.var_46743ac46bbc1595 = create_deck(aliases, 1, 1, 1);
  }

  wait 0.35;

  if(function_a7c8f01b64b95e8e()) {
    sequence = [level.player, 0.4, level.vo.var_46743ac46bbc1595 deck_draw()];
    say_sequence(sequence, 0, 1, 0, 0.5);
    return undefined;
  }

  sequence = [level.player, 0.3, level.vo.var_428c4e20fbe6df5a deck_draw(), level.graves, 0.4, level.vo.var_94c64ce4c942c80c deck_draw()];
  say_sequence(sequence, 0, 1, 0, 0.5);
  return undefined;
}

function function_182e777b9a80fd28() {
  if(!isDefined(level.vo.var_db8f354aa03aa14a)) {
    aliases = ["dx_cp_port_arsb_fara_theresnowayontothesh", "dx_cp_port_arsb_fara_icantgetontheshipfro", "dx_cp_port_arsb_fara_wehaveaproblemtheres", "dx_cp_port_arsb_fara_icantgetaboardtheshi"];
    level.vo.var_db8f354aa03aa14a = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_rrrr_fara_notseeingawayontothe", "dx_cp_port_rrrr_fara_icantgetontheshipfro", "dx_cp_port_rrrr_fara_icantgetaboardtheshi", "dx_cp_port_rrrr_fara_cantgetontotheshipfr"];
    level.vo.var_348821487e059c57 = create_deck(aliases, 1, 1, 1);
  }

  var_da013309201aa35d = function_cd70fbc5ff85bc7d(level.vo.var_348821487e059c57, level.vo.var_db8f354aa03aa14a);
  dialog = [level.player, 0, var_da013309201aa35d];
  say_sequence(dialog, 1, 3, 0, 0.5);
}

function function_8e60856af14db88e() {
  if(!isDefined(level.vo.var_8592c3bc2030286a)) {
    aliases = ["dx_cp_port_arsr_grav_konnilikelyusedascen", "dx_cp_port_arsr_grav_seeifkonnihasascende", "dx_cp_port_arsr_grav_ifkonnigotaboardyouc", "dx_cp_port_arsr_grav_konnigotaboardtheydh", "dx_cp_port_arsr_grav_idwagerkonnibroughta"];
    level.vo.var_8592c3bc2030286a = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_6cda9f37d370cd36)) {
    aliases = ["dx_cp_port_arsr_fara_goodcall", "dx_cp_port_arsr_fara_copysmart", "dx_cp_port_arsr_fara_goodthinking"];
    level.vo.var_6cda9f37d370cd36 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_8592c2bc20302637)) {
    aliases = ["dx_cp_port_arsr_grav_evenablindsquirrelfi", "dx_cp_port_arsr_grav_brokenclocksstillrig", "dx_cp_port_arsr_grav_ihavemymoments"];
    level.vo.var_8592c2bc20302637 = create_deck(aliases, 1, 1, 1);
  }

  var_afdbb4f1a001782d = [level.graves, 0.3, "dx_cp_port_arsr_grav_imnotallbad", level.player, 0.4, "dx_cp_port_arsr_fara_whosaysyourebad", level.graves, 0.3, "dx_cp_port_arsr_grav_dependswhoyouask"];
  var_87cf7fc226f21fe0 = percent_chance(75) ? &return_true : &return_false;
  var_14bccd6722b79ffc = [level.graves, 0.2, level.vo.var_8592c3bc2030286a deck_draw(), &function_84d907e2af3c9eb4, level.player, 0.3, level.vo.var_6cda9f37d370cd36 deck_draw(), &function_84d907e2af3c9eb4, level.graves, 0.3, level.vo.var_8592c2bc20302637 deck_draw(), &function_84d907e2af3c9eb4, var_87cf7fc226f21fe0];

  if(![[var_87cf7fc226f21fe0]]()) {
    var_14bccd6722b79ffc = array_combine(var_14bccd6722b79ffc, var_afdbb4f1a001782d);
  }

  say_sequence(var_14bccd6722b79ffc, 0.8, 3, 0, 0.5);
}

function function_fd637bed854b2ba8() {
  if(!isDefined(level.vo.var_dd7e341a9a50e8ee)) {
    aliases = ["dx_cp_port_geas_fara_foundanascender", "dx_cp_port_geas_fara_gotanascenderhere", "dx_cp_port_geas_fara_ascenderacquired", "dx_cp_port_geas_fara_gotanascender", "dx_cp_port_geas_fara_ascenderlocated"];
    level.vo.var_dd7e341a9a50e8ee = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_tttt_fara_foundanascender", "dx_cp_port_tttt_fara_gotanascender", "dx_cp_port_tttt_fara_ascender"];
    level.vo.var_b8d7af30cc7d4833 = create_deck(aliases, 1, 1, 1);
  }

  var_e1f25e821b859477 = function_cd70fbc5ff85bc7d(level.vo.var_b8d7af30cc7d4833, level.vo.var_dd7e341a9a50e8ee);
  dialog = [level.player, 0.3, var_e1f25e821b859477];
  say_sequence(dialog, 0, 1, 0, 0.5);
}

function function_de3c72713813c9e6(checkpoint) {
  if(flag("flag_trackers_retrieved")) {
    return;
  }

  if(!isDefined(level.vo.var_14f8f8f49750666b)) {
    aliases = ["dx_cp_port_ns1n_fara_closingonthebridgeto", "dx_cp_port_ns1n_fara_ifthegpstrackersareo", "dx_cp_port_ns1n_fara_trackersshouldbeclos", "dx_cp_port_ns1n_fara_gettingclosetothebri"];
    level.vo.var_14f8f8f49750666b = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nesr_grav_checkthetabletheyrep", "dx_cp_port_nesr_grav_theyshouldbeoutinthe", "dx_cp_port_nesr_grav_trackerswontbehidden"];
    level.vo.var_2b3df4554f34771d = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ns1c_fara_nearingthebridgeandt", "dx_cp_port_ns1c_fara_movingtothebridgefor", "dx_cp_port_ns1c_fara_nearingthebridgetrac", "dx_cp_port_ns1c_fara_closingonbridgeforth", "dx_cp_port_ns1c_fara_headingtothetrackers"];
    level.vo.var_95b1f533400fc4a4 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_losh_fara_gotthetrackers", "dx_cp_port_losh_fara_foundthegpstrackers", "dx_cp_port_losh_fara_ihavethetrackersgrav", "dx_cp_port_losh_fara_gpstrackersinmyposse", "dx_cp_port_losh_fara_gpstrackersinhand"];
    level.vo.var_f8e73c331782158c = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_mmmm_fara_gotthetrackers", "dx_cp_port_mmmm_fara_foundthetrackers", "dx_cp_port_mmmm_fara_trackersacquired"];
    level.vo.var_60706a9da68f729d = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_rs2t_grav_greatnowgettothetowe"];
    level.vo.var_122e0e8b6b58b7b9 = create_deck(aliases, 1, 1, 1);
  }

  if(is_equal(checkpoint, "found_rfid_reader")) {
    function_eb7328ff9bae5a5d("ship", undefined, 1);
    childthread function_aa9ab7df2a7e6f8b(1, "ship", 1);
  }

  function_d14fcd3a04720601("trig_vo_ship");
  flag_set("ShipTower_Objectives_Intro");
  function_d14fcd3a04720601("trig_vo_ship_near");
  function_933cb409cccfde6f();
  flag_wait("flag_board_ship");
  childthread function_7a06ab7aa341c8ff();
  function_12f20ca03dab6c05();
  flag_wait("flag_enter_cabin");
  var_9ed18883d5c763a1 = [level.player, 0.3, level.vo.var_95b1f533400fc4a4 deck_draw(), level.graves, 0.2, &function_2c84e12f922c2783, level.vo.var_2b3df4554f34771d deck_draw()];
  var_cb7fcc660aafd7bc = [level.player, 0.3, level.vo.var_14f8f8f49750666b deck_draw(), level.graves, 0.2, &function_2c84e12f922c2783, level.vo.var_2b3df4554f34771d deck_draw()];
  sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
  say_sequence(sequence, 1, 3, 0, 0.5);
  wait 1.5;
  childthread function_aa9ab7df2a7e6f8b(2, "ship");
  flag_wait("flag_trackers_retrieved");
  var_1b4096f817b282e8 = [level.player, 0.3, function_cfa4b3e55017bda7(level.vo.var_60706a9da68f729d, level.vo.var_f8e73c331782158c)];

  if(flag("flag_manifest_retrieved")) {
    played = say_sequence(var_1b4096f817b282e8, 0.9, 3, 0, 0.5);
    return;
  }

  played = say_sequence(var_1b4096f817b282e8, 1, 5, 0, 0.5);
  sequence = [level.graves, 0, level.vo.var_122e0e8b6b58b7b9 deck_draw()];
  played = say_sequence(sequence, 0.9, 4, 0, 0.5);
  function_eb7328ff9bae5a5d("tower", 1);
  thread function_da51df3c6dab0090();
}

function function_2c84e12f922c2783() {
  if(!flag("flag_trackers_retrieved")) {
    return;
  }

  return 0;
}

function function_933cb409cccfde6f() {
  level endon("flag_board_ship");

  if(!isDefined(level.vo.var_6c990eea93ef9fba)) {
    aliases = ["dx_cp_port_nsnc_fara_gotkonniguardsonthes", "dx_cp_port_nsnc_fara_gunnerspostedontheca", "dx_cp_port_nsnc_fara_enemiesontheboat", "dx_cp_port_nsnc_fara_konnisgotshootersont", "dx_cp_port_nsnc_fara_shipsfilledwithkonni"];
    level.vo.var_6c990eea93ef9fba = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nshc_fara_nearingthecargoship", "dx_cp_port_nshc_fara_approachingthecargos", "dx_cp_port_nshc_fara_cargoshipswellguarde", "dx_cp_port_nshc_fara_konnisaboardtheship", "dx_cp_port_nshc_fara_shipsfullofhostiles"];
    level.vo.var_7759eb792908f5 = create_deck(aliases, 1, 1, 1);
  }

  sequence = [level.player, 0, function_cd70fbc5ff85bc7d(level.vo.var_7759eb792908f5, level.vo.var_6c990eea93ef9fba)];
  say_sequence(sequence, 0, 3, 0, 0.5);
}

function function_eb7328ff9bae5a5d(towards, second, force) {
  if(!isDefined(level.vo.var_bdfe69963396b6ed)) {
    aliases = ["dx_cp_port_mts1_fara_makingmywaytowardsth", "dx_cp_port_mts1_fara_headingtowardstheshi", "dx_cp_port_mts1_fara_movingtowardsthecarg", "dx_cp_port_mts1_fara_makingmywaytothefrei", "dx_cp_port_mts1_fara_enroutetotheship", "dx_cp_port_mts1_fara_makingmywaytowardsth_01", "dx_cp_port_mts1_fara_onmywaytotheship", "dx_cp_port_mts1_fara_headingtowardsthefre"];
    level.vo.var_bdfe69963396b6ed = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_dddd_fara_pushingtothecargoshi", "dx_cp_port_dddd_fara_headingtothecargoshi", "dx_cp_port_dddd_fara_movingtothecargoship", "dx_cp_port_dddd_fara_goingtothefreighter", "dx_cp_port_dddd_fara_headingtotheship"];
    level.vo.var_db40edaa0ddc489a = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_7dc4ea375e747ff4)) {
    aliases = ["dx_cp_port_mtt1_fara_makingmywaytothetowe", "dx_cp_port_mtt1_fara_goingtothetower", "dx_cp_port_mtt1_fara_imenroutetothetower", "dx_cp_port_mtt1_fara_movingtothetower", "dx_cp_port_mtt1_fara_headingtowardsthetow", "dx_cp_port_mtt1_fara_maneuveringtothetowe", "dx_cp_port_mtt1_fara_enroutetothetower", "dx_cp_port_mtt1_fara_headingtothetower", "dx_cp_port_mtt1_fara_onmywaytotheharborto"];
    level.vo.var_7dc4ea375e747ff4 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ffff_fara_makingmywaytothetowe", "dx_cp_port_ffff_fara_goingtothetower", "dx_cp_port_ffff_fara_headingtothetower", "dx_cp_port_ffff_fara_approachingtheharbor"];
    level.vo.var_4c9fde193cbe4b85 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_999e7a63ba374fe0)) {
    aliases = ["dx_cp_port_mts2_fara_headingtowardsthecar", "dx_cp_port_mts2_fara_movingtowardsthecarg", "dx_cp_port_mts2_fara_imheadingtotheshipfo", "dx_cp_port_mts2_fara_onmywaytothecargoshi", "dx_cp_port_mts2_fara_onmywaytogetthetrack"];
    level.vo.var_999e7a63ba374fe0 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_1112_fara_headingforthetracker", "dx_cp_port_1112_fara_movingtotheshipforth", "dx_cp_port_1112_fara_imheadingtotheshipfo", "dx_cp_port_1112_fara_onmywaytotheshipfort", "dx_cp_port_1112_fara_movingtothecargoship"];
    level.vo.var_4c772258849702c9 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_mtt2_fara_movingtothetowerfort", "dx_cp_port_mtt2_fara_headingtowardsthetow", "dx_cp_port_mtt2_fara_movingtotheharbortow", "dx_cp_port_mtt2_fara_imheadingtothetowerf", "dx_cp_port_mtt2_fara_onmywaytotheharborto"];
    level.vo.var_dd6150f46a6d40a1 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_1113_fara_movingtothetowerfort", "dx_cp_port_1113_fara_headingtothetowerfor", "dx_cp_port_1113_fara_movingtotheharbortow", "dx_cp_port_1113_fara_goingtotheharbortowe"];
    level.vo.var_2745c36f2eb696e6 = create_deck(aliases, 1, 1, 1);
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_port_rene_grav_stayalert";
  aliases[aliases.size] = "dx_cp_port_rene_grav_copy";
  aliases[aliases.size] = "dx_cp_port_rene_grav_roger";
  aliases[aliases.size] = "dx_cp_port_rene_grav_understood";
  aliases[aliases.size] = "dx_cp_port_rene_grav_solidcopy";
  aliases[aliases.size] = "dx_cp_port_rene_grav_rog";
  aliases[aliases.size] = "dx_cp_port_rene_grav_ok";
  aliases[aliases.size] = "dx_cp_port_rene_grav_keepmoving";
  aliases[aliases.size] = "dx_cp_port_rene_grav_gotit";
  aliases[aliases.size] = "dx_cp_port_rene_grav_check";
  aliases[aliases.size] = "dx_cp_port_rene_grav_gotcha";
  var_34bd2dc79895b799 = create_deck(aliases, 1, 1);

  if(!istrue(force)) {
    if(level.player function_da0fc97699b7c873("obj_board_ship") || level.player function_da0fc97699b7c873("obj_harbormaster_building")) {
      return;
    }

    if(level.player function_909f63295ad5bc62(400)) {
      return;
    }
  }

  if(towards == "ship") {
    var_9ed18883d5c763a1 = undefined;
    var_cb7fcc660aafd7bc = undefined;

    if(istrue(second)) {
      var_9ed18883d5c763a1 = [level.player, 1, level.vo.var_4c772258849702c9 deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
      var_cb7fcc660aafd7bc = [level.player, 1, level.vo.var_999e7a63ba374fe0 deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
    } else {
      var_9ed18883d5c763a1 = [level.player, 1, level.vo.var_db40edaa0ddc489a deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
      var_cb7fcc660aafd7bc = [level.player, 1, level.vo.var_bdfe69963396b6ed deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
    }

    sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
    say_sequence(sequence, 0.25, 8, 0, 0.5);
    flag_clear("HMO_ACTIVE");
    flag_set("SHIP_ACTIVE");
    level.var_c822dc207b2239db = gettime();
    return;
  }

  if(towards == "tower") {
    var_9ed18883d5c763a1 = undefined;
    var_cb7fcc660aafd7bc = undefined;

    if(istrue(second)) {
      var_9ed18883d5c763a1 = [level.player, 0, level.vo.var_2745c36f2eb696e6 deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
      var_cb7fcc660aafd7bc = [level.player, 0, level.vo.var_dd6150f46a6d40a1 deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
    } else {
      var_9ed18883d5c763a1 = [level.player, 0, level.vo.var_4c9fde193cbe4b85 deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
      var_cb7fcc660aafd7bc = [level.player, 0, level.vo.var_7dc4ea375e747ff4 deck_draw(), level.graves, 0.2, var_34bd2dc79895b799 deck_draw()];
    }

    sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
    say_sequence(sequence, 0.25, 4, 0, 0.5);
    flag_set("HMO_ACTIVE");
    flag_clear("SHIP_ACTIVE");
    level.var_c822dc207b2239db = gettime();
    return;
  }
}

function function_220c095ea04f61bc() {
  var_61753ae8124ce989 = ["flag_trackers_retrieved", "flag_manifest_retrieved"];
  var_5fc5e85e101f921c = function_1c4d592029f2b0d3("trig_vo_ship");
  var_8cd5f3e006987dd8 = function_1c4d592029f2b0d3("trig_vo_hmo");
  childthread function_84c515a79e4dbb5d(var_5fc5e85e101f921c, level.vo, "stop_tracking_move", "move_towards");
  childthread function_84c515a79e4dbb5d(var_8cd5f3e006987dd8, level.vo, "stop_tracking_move", "move_towards");
  var_2669df344aeefd96 = ["trig_vo_hmo": "tower", "trig_vo_ship": "ship"];
  var_603065bee83aeb20 = undefined;

  while(true) {
    level.vo waittill("move_towards", trig);

    if(!isDefined(trig)) {
      assertmsg("Trig should not be undefined, the map may have changed.");
      continue;
    }

    trig_name = trig.targetname;

    if(!isDefined(trig_name) || !array_contains_key(var_2669df344aeefd96, trig_name)) {
      continue;
    }

    level.vo notify("stop_tracking_move");

    if(flag_any(var_61753ae8124ce989)) {
      return;
    }

    destination = var_2669df344aeefd96[trig_name];
    function_eb7328ff9bae5a5d(destination);
    childthread function_aa9ab7df2a7e6f8b(1, destination);
    var_603065bee83aeb20 = destination;
    break;
  }

  while(true) {
    level.vo notify("stop_tracking_move");
    wait 20;
    childthread function_84c515a79e4dbb5d(var_5fc5e85e101f921c, level.vo, "stop_tracking_move", "move_towards");
    childthread function_84c515a79e4dbb5d(var_8cd5f3e006987dd8, level.vo, "stop_tracking_move", "move_towards");
    level.vo waittill("move_towards", trig);

    if(!isDefined(trig)) {
      assertmsg("Trig should not be undefined, the map may have changed.");
      continue;
    }

    trig_name = trig.targetname;

    if(!isDefined(trig_name) || !array_contains_key(var_2669df344aeefd96, trig_name)) {
      continue;
    }

    if(flag_any(var_61753ae8124ce989)) {
      return;
    }

    destination = var_2669df344aeefd96[trig_name];

    if(is_equal(destination, var_603065bee83aeb20)) {
      continue;
    }

    if(percent_chance(60)) {
      function_34e62ddce67ef1fb("checkin");
    }

    function_747084c13512e761(destination);
    var_603065bee83aeb20 = destination;
  }
}

function function_747084c13512e761(towards) {
  if(!isDefined(level.vo.var_29ed04521af1860d)) {
    aliases = ["dx_cp_port_cmts_fara_changeofplansimgoing", "dx_cp_port_cmts_fara_changingcourseheadin", "dx_cp_port_cmts_fara_newplangravesillgett", "dx_cp_port_cmts_fara_shadowillgetthetrack", "dx_cp_port_cmts_fara_goingforthetrackersc"];
    level.vo.var_29ed04521af1860d = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_c40634d30c9af07a)) {
    aliases = ["dx_cp_port_aaaa_fara_changeofplansimgoing", "dx_cp_port_aaaa_fara_changingcourseheadin", "dx_cp_port_aaaa_fara_illgetthetrackersfro", "dx_cp_port_aaaa_fara_illsearchforthetrack", "dx_cp_port_aaaa_fara_goingforthetrackersc"];
    level.vo.var_c40634d30c9af07a = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_c32afe06179aba94)) {
    aliases = ["dx_cp_port_cmtt_fara_changeofplansimgoing", "dx_cp_port_cmtt_fara_changingcourseheadin", "dx_cp_port_cmtt_fara_gravesillgetthemanif", "dx_cp_port_cmtt_fara_changingcourseillhea", "dx_cp_port_cmtt_fara_manifestfirstimchang"];
    level.vo.var_c32afe06179aba94 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_d6eca4db567f0e5)) {
    aliases = ["dx_cp_port_vvvv_fara_changeofplansimgoing", "dx_cp_port_vvvv_fara_changingcourseheadin", "dx_cp_port_vvvv_fara_updatingplansillgett", "dx_cp_port_vvvv_fara_changingcourseillhea", "dx_cp_port_vvvv_fara_manifestfirstimchang"];
    level.vo.var_d6eca4db567f0e5 = create_deck(aliases, 1, 1, 1);
  }

  if(towards == "ship") {
    var_84c58846f5116744 = [level.player, 0.3, level.vo.var_29ed04521af1860d deck_draw(), level.graves, 0.4, "dx_cp_port_cmts_grav_goodcopydowhatyousee"];
    var_8afdac9ba3efccb5 = [level.player, 0.3, level.vo.var_c40634d30c9af07a deck_draw(), level.graves, 0.4, "dx_cp_port_aaaa_grav_copyyourcallcommande"];
    sequence = function_70386f0dbf01d6f4(var_8afdac9ba3efccb5, var_84c58846f5116744);
    say_sequence(sequence, 1, 3, 0, 0.5);
    flag_clear("HMO_ACTIVE");
    flag_set("SHIP_ACTIVE");
    level.var_c822dc207b2239db = gettime();
    return;
  }

  if(towards == "tower") {
    var_84c58846f5116744 = [level.player, 0.3, level.vo.var_c32afe06179aba94 deck_draw(), level.graves, 0.4, "dx_cp_port_cmtt_grav_dealerschoicekilosta"];
    var_8afdac9ba3efccb5 = [level.player, 0.3, level.vo.var_d6eca4db567f0e5 deck_draw()];
    sequence = function_70386f0dbf01d6f4(var_8afdac9ba3efccb5, var_84c58846f5116744);
    say_sequence(sequence, 1, 3, 0, 0.5);
    flag_set("HMO_ACTIVE");
    flag_clear("SHIP_ACTIVE");
    level.var_c822dc207b2239db = gettime();
    return;
  }
}

function function_12f20ca03dab6c05() {
  if(!isDefined(level.vo.var_c4a733d9b9577193)) {
    aliases = ["dx_cp_port_asho_fara_aboardtheship", "dx_cp_port_asho_fara_ondeck", "dx_cp_port_asho_fara_imontheship", "dx_cp_port_asho_fara_boardedtheship"];
    level.vo.var_c4a733d9b9577193 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_248d309c650ecaf2)) {
    aliases = ["dx_cp_port_asho_grav_goodnowlookforthegps", "dx_cp_port_asho_grav_searchforthegpstrack", "dx_cp_port_asho_grav_sweepforthetrackers", "dx_cp_port_asho_grav_startsweepingforthet"];
    level.vo.var_248d309c650ecaf2 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_e6c163e8ebe5d72)) {
    aliases = ["dx_cp_port_ashr_grav_headtowardsthebridge", "dx_cp_port_ashr_grav_gotothebridgecheckfo", "dx_cp_port_ashr_grav_thetrackersshouldbei"];
    level.vo.var_e6c163e8ebe5d72 = create_deck(aliases, 1, 0, 1);
  }

  if(!isDefined(level.vo.var_aab6da8926647526)) {
    aliases = ["dx_cp_port_asor_grav_shouldbetheresomewhe", "dx_cp_port_asor_grav_konnisonlyafterourmi", "dx_cp_port_asor_grav_konnissniffinformiss"];
    level.vo.var_aab6da8926647526 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_d56d27a9ded310ec)) {
    aliases = ["dx_cp_port_bbbb_fara_madeittotheship", "dx_cp_port_bbbb_fara_imontheship"];
    level.vo.var_d56d27a9ded310ec = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_7aec57da984579ef)) {
    aliases = ["dx_cp_port_bbbb_grav_findthosetrackerskil", "dx_cp_port_bbbb_grav_searchforthegpstrack", "dx_cp_port_bbbb_grav_nowlookforthetracker"];
    level.vo.var_7aec57da984579ef = create_deck(aliases, 1, 1, 1);
  }

  var_b737a2c158a15a10 = [level.player, 0.3, level.vo.var_c4a733d9b9577193 deck_draw(), level.graves, 0.2, "dx_cp_port_ashr_grav_thetrackersshouldbei", level.graves, 1, level.vo.var_aab6da8926647526 deck_draw()];
  var_ad451464907eb97f = [level.player, 0.3, level.vo.var_d56d27a9ded310ec deck_draw(), level.graves, 0.4, "dx_cp_port_ashr_grav_thetrackersshouldbei"];
  sequence = function_70386f0dbf01d6f4(var_ad451464907eb97f, var_b737a2c158a15a10);
  say_sequence(sequence, 1, 3, 0, 0.5);
}

function function_e5d3f41bd8738f8f(checkpoint) {
  level endon("game_ended");
  var_b2704cd710218e00 = [level.farah, 0.4, "dx_cp_port_cono_fara_gravessendingyouthei", level.graves, 0.5, "dx_cp_port_cono_grav_gotitcrossreferencin"];
  var_7e7624c893d04b7b = [level.graves, 0.6, "dx_cp_port_cono_grav_gotallthreecontainer", level.farah, 0.4, "dx_cp_port_cono_fara_onlytwo", level.graves, 0.5, "dx_cp_port_cono_grav_righttwogoddamnultra", level.farah, 0.6, "dx_cp_port_cono_fara_tellmewheretogoillpl", level.graves, 0.4, "dx_cp_port_cono_grav_rogerthatletsgettoit"];
  var_54b09bc1a5cee4b7 = [level.graves, 0.5, "dx_cp_port_conr_grav_timetoplantthosetrac"];
  var_db27369b490db198 = [level.graves, 0.5, "dx_cp_port_cono_grav_checkthecranestheyma", level.farah, 0.7, "dx_cp_port_cono_fara_copyillcheckhighandl"];

  if(flag("vo_missile_container_truck_seen")) {
    var_b2704cd710218e00 = array_combine(var_b2704cd710218e00, var_7e7624c893d04b7b);
  } else {
    var_b2704cd710218e00 = array_combine(var_b2704cd710218e00, var_54b09bc1a5cee4b7);
  }

  var_b2704cd710218e00 = array_combine(var_b2704cd710218e00, var_db27369b490db198);
  var_422d39123d6b61b0 = [level.graves, 0.5, "dx_cp_port_cono_grav_gotitcrossreferencin", level.graves, 1.5, "dx_cp_port_cono_grav_checkthecranestheyma", level.graves, 0.5, "dx_cp_port_cono_grav_movefastkilotimeaint"];

  if(!isDefined(level.vo.var_bd2b5fc19c3cee72)) {
    aliases = ["dx_cp_port_conr_grav_timetoplantthosetrac", "dx_cp_port_conr_grav_letsgetthosetrackers", "dx_cp_port_conr_grav_gettothemissilesandp", "dx_cp_port_conr_grav_wegottagetthosetrack", "dx_cp_port_conr_grav_placethosetrackerson"];
    level.vo.var_bd2b5fc19c3cee72 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_mc11_fara_headingforoneofthemi", "dx_cp_port_mc11_fara_goingforthefirstmiss", "dx_cp_port_mc11_fara_approachingamissilec"];
    level.vo.var_18046b0a7cd53fab = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_mc14_fara_goingforfirstcontain", "dx_cp_port_mc14_fara_movingtocontainer", "dx_cp_port_mc14_fara_onthemove"];
    level.vo.var_92106a99bdeac6e4 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nc11_fara_firstonesupaboveneed", "dx_cp_port_nc11_fara_firstcontainerspotte", "dx_cp_port_nc11_fara_haveeyesonthefirstmi"];
    level.vo.var_5ba798cbc894d0af = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nc14_fara_firstcontainerslocat", "dx_cp_port_nc14_fara_visualonthefirstcont", "dx_cp_port_nc14_fara_foundthefirstcontain", "dx_cp_port_nc14_fara_firstcontainersstack"];
    level.vo.var_1903b9b887802878 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pc14_fara_onedown", "dx_cp_port_pc14_fara_firstonedown", "dx_cp_port_pc14_fara_itsmarked", "dx_cp_port_pc14_fara_containersmarked", "dx_cp_port_pc14_fara_trackersonthecontain"];
    level.vo.var_c99d4ef04192bdf3 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pc11_fara_firstmissilemarked", "dx_cp_port_pc11_fara_trackersonthemissile", "dx_cp_port_pc11_fara_missilecontainersmar", "dx_cp_port_pc11_fara_trackeronthecontaine", "dx_cp_port_pc11_fara_trackersactiveonthef"];
    level.vo.var_e3a65a58bf7aa0b8 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_con2_grav_greatyouknowwheretog", "dx_cp_port_con2_grav_alrightpushtotheseco", "dx_cp_port_con2_grav_secondonesstillunmar", "dx_cp_port_con2_grav_getthenextoneplanted", "dx_cp_port_con2_grav_halfwaythereoneconta"];
    level.vo.var_b2708dd710221cf3 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_mc14_fara_goingforfirstcontain", "dx_cp_port_mc14_fara_movingtocontainer", "dx_cp_port_mc14_fara_onthemove"];
    level.vo.var_54d43ea8b3574796 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_mc24_fara_headingtothenextone", "dx_cp_port_mc24_fara_onthemove", "dx_cp_port_mc24_fara_movingtothenext", "dx_cp_port_mc24_fara_pushingtonextcontain"];
    level.vo.var_54231ba3ae306131 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nc21_fara_secondcontainerlocat", "dx_cp_port_nc21_fara_multiplesquadsnearth", "dx_cp_port_nc21_fara_closingonthesecondco", "dx_cp_port_nc21_fara_eyesonthesecondconta", "dx_cp_port_nc21_fara_closingonsecondconta"];
    level.vo.var_75221fe30353033a = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nc24_fara_foundthenextonesecur", "dx_cp_port_nc24_fara_moreguardsbythesecon", "dx_cp_port_nc24_fara_locatedtheotherone", "dx_cp_port_nc24_fara_secondcontainersnear", "dx_cp_port_nc24_fara_closetothesecondone"];
    level.vo.var_dd59d7781422c075 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pc21_fara_plantinglasttrackern", "dx_cp_port_pc21_fara_placingthefinaltrack", "dx_cp_port_pc21_fara_plantingthefinaltrac", "dx_cp_port_pc21_fara_lasttracker", "dx_cp_port_pc21_fara_markingthelastcontai"];
    level.vo.var_a4f05994961e281 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pc24_fara_placingthelasttracke", "dx_cp_port_pc24_fara_lasttracker", "dx_cp_port_pc24_fara_finaltracker", "dx_cp_port_pc24_fara_placingfinaltracker"];
    level.vo.var_8a87e4b79a84705a = create_deck(aliases, 1, 1, 1);
  }

  var_ef24cffef3c5d90a = [level.farah, 0.6, "dx_cp_port_poen_fara_allstationslasttrack", level.graves, 0.4, "dx_cp_port_poen_grav_solidcopyyoudidwhatn", level.farah, 0.6, "dx_cp_port_poen_fara_echohowcopy", level.alex, 0.4, "dx_cp_port_poen_alex_loudandclearfarahkon", level.farah, 0.5, "dx_cp_port_poen_fara_welivetofightanother", level.graves, 0.3, "dx_cp_port_poen_grav_noitsnotwerejustgett", level.alex, 0.6, "dx_cp_port_poen_alex_kiloimcomingyourwayw"];

  if(is_equal(checkpoint, "found_gps_and_rfid")) {
    sequence = [level.player, 0.3, level.vo.var_bd2b5fc19c3cee72 deck_draw()];
    played = say_sequence(sequence, 1, 5, 0, 0.5);
  } else {
    wait 2;

    if(flag("vo_missile_container_truck") && level.player function_da0fc97699b7c873("obj_board_ship")) {
      flag_wait_or_timeout("vo_missile_container_truck_seen", 15);
    }

    if(function_92c06f383a5b0c34()) {
      played = say_sequence(var_422d39123d6b61b0, 1, 10, 0, 0.5);
    } else {
      played = say_sequence(var_b2704cd710218e00, 1, 10, 0, 0.5);
    }
  }

  flag_set("vo_containerintro_done");
  childthread function_e8b505209d3225a5();
  childthread function_aa9ab7df2a7e6f8b(3);
  childthread function_3c81e542fe006d1f("trig_container_b_");
  childthread function_3c81e542fe006d1f("trig_container_c_");
  flag_wait_any("missile_container_hmo_found", "missile_container_boat_found");

  if(!flag("vo_container_said")) {
    flag_wait_or_timeout("vo_container_said", 6);
  }

  sequence = [level.graves, 0.3, level.vo.var_b2708dd710221cf3 deck_draw()];
  played = say_sequence(sequence, 1, 4, 0, 0.5);
  childthread function_aa9ab7df2a7e6f8b(4);
  childthread function_d93e8da358a91734();
  flag_wait_all("missile_container_hmo_found", "missile_container_boat_found");
  flag_set("flag_container_planted");
  flag_set("flag_vo_container2");
  flag_wait("tracker_done");
  level.player function_54d3bd59bff7e908(1, 1);
}

function function_3c81e542fe006d1f(container) {
  var_61881a78cb4ad8e7 = function_1c4d592029f2b0d3(container + "1");
  thread function_84c515a79e4dbb5d(var_61881a78cb4ad8e7, level.vo, "stop_checking_containers", "player_pursuing_container");
  function_f06cc4fdc818295a(container + "1");
  level.var_2f7a98ab3ea09ffc = default_to(level.var_2f7a98ab3ea09ffc, container);
  var_a1a9c9f5934e4a30 = is_equal(level.var_2f7a98ab3ea09ffc, container);
  var_2eb41df16241f1c1 = [level.player, 0.3, function_cd70fbc5ff85bc7d(level.vo.var_92106a99bdeac6e4, level.vo.var_18046b0a7cd53fab)];
  var_c477f0ea2c945cbd = [level.player, 0.3, function_cd70fbc5ff85bc7d(level.vo.var_54231ba3ae306131, level.vo.var_54d43ea8b3574796)];
  sequence = var_a1a9c9f5934e4a30 ? var_2eb41df16241f1c1 : var_c477f0ea2c945cbd;
  played = say_sequence(sequence, 0.8, 3, 0, 0.5);
  flag_set("vo_container_said");
  var_61881a78cb4ad8e7 = function_1c4d592029f2b0d3(container + "2");
  thread function_84c515a79e4dbb5d(var_61881a78cb4ad8e7, level.vo, "stop_checking_containers", "player_pursuing_container");
  function_f06cc4fdc818295a(container + "2");
  flag_clear("vo_container_said");
  var_98c930e419a3f4fb = "dx_cp_port_nc14_fara_firstcontainersupabo";
  var_bcc35dc5a93e3c1f = "dx_cp_port_nc11_fara_locatedthefirstonelo";
  var_6208620c6f313416 = "dx_cp_port_nc11_fara_eyesonthemissilecont";

  if(level.player.origin[2] < 410 && container == "trig_container_c_") {
    var_2eb41df16241f1c1 = [level.player, 0.3, function_70386f0dbf01d6f4(var_98c930e419a3f4fb, var_bcc35dc5a93e3c1f)];
    var_c477f0ea2c945cbd = [level.player, 0.3, function_70386f0dbf01d6f4(var_98c930e419a3f4fb, var_6208620c6f313416)];
  } else {
    var_2eb41df16241f1c1 = [level.player, 0.3, function_cd70fbc5ff85bc7d(level.vo.var_1903b9b887802878, level.vo.var_5ba798cbc894d0af)];
    var_c477f0ea2c945cbd = [level.player, 0.3, function_cd70fbc5ff85bc7d(level.vo.var_dd59d7781422c075, level.vo.var_75221fe30353033a)];
  }

  sequence = var_a1a9c9f5934e4a30 ? var_2eb41df16241f1c1 : var_c477f0ea2c945cbd;
  played = say_sequence(sequence, 1, 5, 0, 0.5);
  flag_wait("flag_container" + (var_a1a9c9f5934e4a30 ? "1" : "2"));
  var_2eb41df16241f1c1 = [level.player, 0.3, function_cd70fbc5ff85bc7d(level.vo.var_c99d4ef04192bdf3, level.vo.var_e3a65a58bf7aa0b8)];
  var_c477f0ea2c945cbd = [level.player, 0.3, function_cd70fbc5ff85bc7d(level.vo.var_8a87e4b79a84705a, level.vo.var_a4f05994961e281)];
  sequence = var_a1a9c9f5934e4a30 ? var_2eb41df16241f1c1 : var_c477f0ea2c945cbd;
  played = say_sequence(sequence, 1, 5, 0, 0.5);
  flag_set("vo_container_said");
}

function function_f06cc4fdc818295a(container) {
  var_e68b5e0e50cd2d6f = getEnt("konni_exfil_container", "targetname");
  var_b20d3cdfdd25d30a = [var_e68b5e0e50cd2d6f.origin + (0, 0, 70), var_e68b5e0e50cd2d6f.origin - (0, 0, 70), var_e68b5e0e50cd2d6f.origin + (80, 0, 0), var_e68b5e0e50cd2d6f.origin - (80, 0, 0)];
  var_db514d1c6739320b = [];

  foreach(orig in var_b20d3cdfdd25d30a) {
    var_93c9349bbde512c9 = spawnStruct();
    var_93c9349bbde512c9.origin = orig;
    var_db514d1c6739320b[var_db514d1c6739320b.size] = var_93c9349bbde512c9;
  }

  while(true) {
    if(container == "trig_container_c_2") {
      var_db514d1c6739320b waittill_player_lookat(85, undefined, 900, undefined, undefined, 0.2);
    } else {
      level.vo waittill("player_pursuing_container", trig);

      if(!isDefined(trig)) {
        assertmsg("Trig should not be undefined, the map may have changed.");
        continue;
      }

      trig_name = trig.targetname;

      if(!is_equal(container, trig_name)) {
        continue;
      }
    }

    flag_set("flag_container_move");
    break;
  }
}

function function_7a06ab7aa341c8ff() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_2d1669636a46e8b4)) {
    aliases = ["dx_cp_port_ssh1_fara_gpstrackerscantbefar", "dx_cp_port_ssh1_fara_thetrackersshouldbef", "dx_cp_port_ssh1_fara_trackersshouldbenear", "dx_cp_port_ssh1_fara_trackersmustbesomewh", "dx_cp_port_ssh1_fara_gpstrackersshouldbea"];
    level.vo.var_2d1669636a46e8b4 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_7385295b2e00996f)) {
    aliases = ["dx_cp_port_ssh4_fara_gottafindthetrackers", "dx_cp_port_ssh4_fara_trackersmustbearound", "dx_cp_port_ssh4_fara_lookingforthetracker"];
    level.vo.var_7385295b2e00996f = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_e6c163e8ebe5d72)) {
    aliases = ["dx_cp_port_ashr_grav_headtowardsthebridge", "dx_cp_port_ashr_grav_gotothebridgecheckfo", "dx_cp_port_ashr_grav_thetrackersshouldbei"];
    level.vo.var_e6c163e8ebe5d72 = create_deck(aliases, 1, 0, 1);
  }

  delay = growing_delay(15, 30, 3);

  while(!flag("flag_trackers_retrieved")) {
    waitfor(delay);

    if(flag("HMO_ACTIVE")) {
      flag_wait("SHIP_ACTIVE");
      continue;
    }

    if(flag("flag_trackers_retrieved") || flag("flag_enter_cabin")) {
      break;
    }

    var_cb7fcc660aafd7bc = [level.player, 0.1, level.vo.var_2d1669636a46e8b4 deck_draw(), level.graves, 0.2, level.vo.var_e6c163e8ebe5d72 deck_draw()];
    var_9ed18883d5c763a1 = [level.player, 0.1, level.vo.var_7385295b2e00996f deck_draw(), level.graves, 0.2, level.vo.var_e6c163e8ebe5d72 deck_draw()];
    sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);

    if(!flag("flag_enter_cabin")) {
      say_sequence(sequence, 0, 2, 0, 0.5);
    }
  }

  if(!isDefined(level.vo.var_2b3df4554f34771d)) {
    aliases = ["dx_cp_port_nesr_grav_checkthetabletheyrep", "dx_cp_port_nesr_grav_theyshouldbeoutinthe", "dx_cp_port_nesr_grav_trackerswontbehidden"];
    level.vo.var_2b3df4554f34771d = create_deck(aliases, 1, 1, 1);
  }

  var_6c29849e5ac20240 = getEnt("obj_board_ship", "targetname");
  delay = growing_delay(12, 25, 3);

  while(!flag("flag_trackers_retrieved")) {
    waitfor(delay);

    if(flag("flag_trackers_retrieved")) {
      break;
    }

    if(flag("HMO_ACTIVE") || function_a7c8f01b64b95e8e()) {
      flag_wait("SHIP_ACTIVE");
      continue;
    }

    sequence = [level.graves, 0, level.vo.var_2b3df4554f34771d deck_draw()];
    say_sequence(sequence, 0.25, 1, 0, 0.5);
  }
}

function function_da51df3c6dab0090() {
  level endon("flag_enter_hmo");
  level endon("game_ended");

  if(!isDefined(level.vo.var_dc88bd9059255012)) {
    aliases = ["dx_cp_port_mt2n_grav_dontsearchblindforth", "dx_cp_port_mt2n_grav_letsgetthemanifestbe", "dx_cp_port_mt2n_grav_manifestshouldtellus"];
    level.vo.var_dc88bd9059255012 = create_deck(aliases, 1, 1, 1);
  }

  while(!flag("flag_enter_hmo")) {
    wait 60;

    if(flag("flag_enter_hmo")) {
      break;
    }

    sequence = [level.graves, 0, level.vo.var_dc88bd9059255012 deck_draw(), &function_84d907e2af3c9eb4];
    played = say_sequence(sequence, 0.25, 1, 0, 0.5);
  }
}

function function_4d9590ff10fb8b6a() {
  level endon("flag_board_ship");
  level endon("game_ended");

  if(!isDefined(level.vo.var_fbe09b338cb75453)) {
    aliases = ["dx_cp_port_ms2n_grav_ifwecantsaveourmissi", "dx_cp_port_ms2n_grav_trackersaretheonlywa", "dx_cp_port_ms2n_grav_withoutthetrackerswe"];
    level.vo.var_fbe09b338cb75453 = create_deck(aliases, 1, 1, 1);
  }

  while(!flag("flag_board_ship")) {
    wait 60;

    if(flag("flag_board_ship")) {
      break;
    }

    sequence = [level.graves, 0, level.vo.var_fbe09b338cb75453 deck_draw(), &function_84d907e2af3c9eb4];
    played = say_sequence(sequence, 0.25, 1, 0, 0.5);
  }
}

function function_ff7751f2a3de38be() {
  flag_wait("vo_missile_container_truck");
  wait 0.1;
  level.var_f90218e659db52ec waittill_player_lookat(80, 5, 2000, (0, 0, 0), undefined, 0.5);
  var_cb7fcc660aafd7bc = [level.farah, 0.3, "dx_cp_port_loco_fara_kilotoshadow01konnif", level.graves, 0.4, "dx_cp_port_loco_grav_dammitthatsonemissil", level.farah, 0.3, "dx_cp_port_loco_fara_ifthemissilesareallh", level.graves, 0.4, "dx_cp_port_loco_grav_bigifkilo", level.graves, 0.3, "dx_cp_port_loco_grav_hopeyoureright"];
  var_9ed18883d5c763a1 = [level.farah, 0.3, "dx_cp_port_1111_fara_kilotoshadowtheyrele", level.graves, 0.3, "dx_cp_port_1111_grav_dammitthatsonemissil"];
  sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
  say_sequence(sequence, 1, 10, 0, 0.5);
  flag_set("vo_missile_container_truck_seen");
}

function function_e8b505209d3225a5() {
  level endon("game_ended");
  level endon("flag_container_move");

  if(!isDefined(level.vo.var_abf157421e769e0b)) {
    aliases = ["dx_cp_port_mcn0_grav_dontletkonnileavebef", "dx_cp_port_mcn0_grav_withoutthosetrackers", "dx_cp_port_mcn0_grav_stayonitfarahwegotta", "dx_cp_port_mcn0_grav_keepatitfarahwecantl", "dx_cp_port_mcn0_grav_wegottagetthosetrack"];
    level.vo.var_abf157421e769e0b = create_deck(aliases, 1, 1, 1);
  }

  while(!flag("flag_container_move")) {
    wait 45;

    if(flag("flag_container_move")) {
      break;
    }

    sequence = [level.graves, 0, level.vo.var_abf157421e769e0b deck_draw(), &function_84d907e2af3c9eb4];
    played = say_sequence(sequence, 0.25, 1, 0, 0.5);
  }
}

function function_d93e8da358a91734() {
  level endon("flag_container_planted");

  if(!isDefined(level.vo.var_2312f0c164ce437d)) {
    aliases = ["dx_cp_port_pcon_grav_getthattrackeronweal", "dx_cp_port_pcon_grav_getthattrackeronkilo", "dx_cp_port_pcon_grav_plantthattrackerkilo", "dx_cp_port_pcon_grav_placeatrackeronthemi", "dx_cp_port_pcon_grav_kiloplantthattracker"];
    level.vo.var_2312f0c164ce437d = create_deck(aliases, 1, 1, 1);
  }

  while(!flag("flag_container_planted")) {
    wait 45;

    if(flag("flag_container_planted")) {
      return;
    }

    sequence = [level.player, 0, level.vo.var_2312f0c164ce437d deck_draw(), &function_84d907e2af3c9eb4];
    played = say_sequence(sequence, 0, 5, 0, 0.5);
  }
}

function function_aa9ab7df2a7e6f8b(var_a0338adbf2ab3ddb, context, var_d146fe61c414e8db) {
  if(!isDefined(var_d146fe61c414e8db)) {
    var_d146fe61c414e8db = 0;
  }

  level.var_c9c6c8cbf3a5f033 = var_a0338adbf2ab3ddb;

  for(var_a5cb0e2fa2f413e = 0; function_a7c8f01b64b95e8e() && level.var_c9c6c8cbf3a5f033 == var_a0338adbf2ab3ddb; var_a5cb0e2fa2f413e++) {
    if(var_a5cb0e2fa2f413e > 15) {
      return;
    }

    wait 1;
  }

  var_a400540ac77fdb82 = function_69fa4a2561ada985("World1");

  if(var_a0338adbf2ab3ddb == 1 && (istrue(var_d146fe61c414e8db) || !isDefined(var_a400540ac77fdb82))) {
    if(!isDefined(level.var_20484a3cff522215)) {
      level.var_20484a3cff522215 = 0;
    }

    if(!time_has_passed(level.var_20484a3cff522215, 15)) {
      return;
    }

    var_b0add8712f3d4f7b = [level.farah, 0.5, "dx_cp_port_wu1s_fara_illkeepaneyeoutforan", level.graves, 0.8, "dx_cp_port_wu1s_grav_wasntmyshiporcrewwew"];
    var_5f912159a9f31d92 = [level.graves, 0.4, "dx_cp_port_wu1t_grav_couldstillmakeadirec", level.farah, 0.4, "dx_cp_port_wu1t_fara_copythatgravesnoretr", level.graves, 0.3, "dx_cp_port_wu1t_grav_likeisaidfarahilikey"];
    sequence = is_equal(context, "ship") ? var_b0add8712f3d4f7b : var_5f912159a9f31d92;

    if(function_a7c8f01b64b95e8e()) {
      return;
    }

    played = say_sequence(sequence, 0.5, 5, 0, 0.5);

    if(istrue(played)) {
      level.var_20484a3cff522215 = gettime();
    }

    function_2311740fe797906a("World1", 1);
    return;
  }

  var_e3e612a10b250221 = function_69fa4a2561ada985("World2");

  if(var_a0338adbf2ab3ddb == 2 && (istrue(var_d146fe61c414e8db) || !isDefined(var_e3e612a10b250221))) {
    var_b0add8712f3d4f7b = [level.farah, 0.4, "dx_cp_port_wu2s_fara_beadvisedkonnileftno", level.graves, 0.5, "dx_cp_port_wu2s_grav_letsmakesuretheygetw", level.farah, 0.3, "dx_cp_port_wu2s_fara_wewontlettheirsacrif", level.graves, 0.3, "dx_cp_port_wu2s_grav_hitemforbothofusfara"];
    var_5f912159a9f31d92 = [level.graves, 0.5, "dx_cp_port_wu2t_grav_ifyoulosethesemissil", level.farah, 0.3, "dx_cp_port_wu2t_fara_ihavecontactswhocanh", level.graves, 0.4, "dx_cp_port_wu2t_grav_cantheybetrustedthis", level.farah, 0.4, "dx_cp_port_wu2t_fara_verymuchso", level.graves, 0.3, "dx_cp_port_wu2t_grav_rogerthat"];
    sequence = is_equal(context, "ship") ? var_b0add8712f3d4f7b : var_5f912159a9f31d92;
    say_sequence(sequence, 0.5, 5, 0, 0.5);
    function_2311740fe797906a("World2", 1);
    return;
  }

  var_5c1ae56cc052e934 = function_69fa4a2561ada985("World3");

  if(var_a0338adbf2ab3ddb == 3 && (istrue(var_d146fe61c414e8db) || !isDefined(var_5c1ae56cc052e934))) {
    sequence = [level.farah, 0.4, "dx_cp_port_wup3_fara_kiloactualto31whatsy", level.alex, 0.3, "dx_cp_port_wup3_alex_wereholdingemoffbutt", level.farah, 0.4, "dx_cp_port_wup3_fara_illhandlethemfullfor", level.alex, 0.3, "dx_cp_port_wup3_alex_samekiloechoout"];
    say_sequence(sequence, 0.5, 5, 0, 0.5);
    function_2311740fe797906a("World3", 1);
    return;
  }

  var_34a5d1af09ac2e9b = function_69fa4a2561ada985("World4");

  if(var_a0338adbf2ab3ddb == 4 && (istrue(var_d146fe61c414e8db) || !isDefined(var_34a5d1af09ac2e9b))) {
    sequence = [level.farah, 0.4, "dx_cp_port_wup4_fara_theyarentlettingup", level.graves, 0.4, "dx_cp_port_wup4_grav_konnisgotseriousnumb", level.farah, 0.3, "dx_cp_port_wup4_fara_whoeversfundingthemh", level.graves, 0.4, "dx_cp_port_wup4_grav_shedoes", level.farah, 0.5, "dx_cp_port_wup4_fara_whereisthisperson", level.graves, 0.6, "dx_cp_port_wup4_grav_wereworkingonthat", level.farah, 0.4, "dx_cp_port_wup4_fara_thatsvaluableintel", level.graves, 0.4, "dx_cp_port_wup4_grav_yesitis"];
    say_sequence(sequence, 0.5, 5, 0, 0.5);
    function_2311740fe797906a("World4", 1);
    return;
  }
}

function function_b429bbacf52cc809() {
  level endon("flag_container2");
  flag_wait("vo_objective_intro_done");
  childthread vo_notice_ladder();
  wait 0.1;
  childthread vo_notice_gantry();
  wait 0.1;
  childthread vo_notice_machshop();
  childthread vo_notice_dockbodies();
  childthread function_aa701d8b60a0e9af();
  wait 0.1;
  childthread vo_notice_tower();
  childthread vo_notice_ship();
  wait 0.1;
  childthread function_7119ea16c9ea1314();
  wait 0.1;
  childthread function_9f23d35752fe7143();
  childthread function_174ba1ccffae4818();
}

function vo_notice_ladder() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_cf26be758f7df977)) {
    aliases = ["dx_cp_port_pnil_fara_couldgetabetterviewu", "dx_cp_port_pnil_fara_foundaladderforabett", "dx_cp_port_pnil_fara_laddercouldgetmesome", "dx_cp_port_pnil_fara_foundaladdercouldcli", "dx_cp_port_pnil_fara_ladderherecouldgetth"];
    level.vo.var_cf26be758f7df977 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_pnil_grav_ifyoufindaladderclos", "dx_cp_port_pnil_grav_ladderllgetyouatacti", "dx_cp_port_pnil_grav_ifyouseealaddersnear", "dx_cp_port_pnil_grav_ifaladdersnearbyusei"];
    level.vo.var_b8f30eef206b1b1b = create_deck(aliases, 1, 1, 1);
  }

  var_54a7333b8661bd29 = getStructArray("notice_ladder", "targetname");
  sequence = percent_chance(60) ? [level.player, 0, level.vo.var_cf26be758f7df977 deck_draw()] : [level.graves, 0, level.vo.var_b8f30eef206b1b1b deck_draw()];

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0.5, 1, 0, 0.5)) {
    var_54a7333b8661bd29 waittill_player_lookat(undefined, 1, 300, undefined, undefined, 0.8);

    if(function_a7c8f01b64b95e8e()) {
      break;
    }
  }
}

function vo_notice_drone() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_7b4d5ef8d1a89b03)) {
    aliases = ["dx_cp_port_pnsd_fara_dronewouldgivemebett", "dx_cp_port_pnsd_fara_coulduseadronetoscop", "dx_cp_port_pnsd_fara_theresadroneifineedt"];
    level.vo.var_7b4d5ef8d1a89b03 = create_deck(aliases, 1, 1, 1);
  }

  sequence = [level.player, 0.3, level.vo.var_7b4d5ef8d1a89b03 deck_draw(), level.graves, 0.4, "dx_cp_port_pnsd_grav_goodfind"];
  var_19bb39be0eeda25e = getStruct("notice_drone", "targetname");

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0.5, 1, 0, 0.5)) {
    var_19bb39be0eeda25e waittill_player_lookat(undefined, 1, 150, undefined, undefined, 1);

    if(function_a7c8f01b64b95e8e()) {
      break;
    }
  }
}

function vo_notice_gantry() {
  level endon("game_ended");

  if(!isDefined(level.vo.notice_gantry)) {
    aliases = ["dx_cp_port_noga_fara_eyesongantries", "dx_cp_port_noga_fara_haveeyesongantries", "dx_cp_port_noga_fara_visualongantries", "dx_cp_port_noga_fara_gantrieseverywhere"];
    level.vo.notice_gantry = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_e947fbff05dc3c40)) {
    aliases = ["dx_cp_port_noga_grav_theyreallautomated", "dx_cp_port_noga_grav_automatedcranesllsta", "dx_cp_port_noga_grav_iftheyrestillrunning"];
    level.vo.var_e947fbff05dc3c40 = create_deck(aliases, 1, 1, 1);
  }

  sequence = [level.player, 0.3, level.vo.notice_gantry deck_draw(), level.graves, 0.4, level.vo.var_e947fbff05dc3c40 deck_draw()];
  var_202d11b0936c7d28 = getStructArray("notice_gantry", "targetname");

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0, 1, 0, 0.5)) {
    var_202d11b0936c7d28 waittill_player_lookat(undefined, 1500, 2200, undefined, 150, 1, undefined);
    var_73e6148a744fbfce = level.player function_bce20c074033e937();

    if(function_a7c8f01b64b95e8e() || isDefined(var_73e6148a744fbfce) && var_73e6148a744fbfce < 3) {
      continue;
    }
  }
}

function vo_notice_machshop() {
  level endon("game_ended");
  level endon("container_obj_start");

  if(flag("container_obj_start")) {
    return;
  }

  if(!isDefined(level.vo.var_3e26be352e93e1fe)) {
    aliases = ["dx_cp_port_nms0_fara_neartheshopappearsko", "dx_cp_port_nms0_fara_shadowkonnistakenthe", "dx_cp_port_nms0_fara_shadowkonnipostedint", "dx_cp_port_nms0_fara_lookslikekonnisturne", "dx_cp_port_nms0_fara_shopisunderenemycont"];
    level.vo.var_3e26be352e93e1fe = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nmar_grav_dealingwiththemissil", "dx_cp_port_nmar_grav_itsanarmoryyouneedth", "dx_cp_port_nmar_grav_thatsaulfarmoryiwoul", "dx_cp_port_nmar_grav_moregearneverhurts", "dx_cp_port_nmar_grav_denamadethataulfarmo"];
    level.vo.var_27ca77e5af20ed45 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_b8bac1b78851d1a3)) {
    aliases = ["dx_cp_port_gggg_fara_neartheshopgothostil", "dx_cp_port_gggg_fara_theyvetakentheshop", "dx_cp_port_gggg_fara_konnitooktheshop", "dx_cp_port_gggg_fara_shopsgotkonniinside", "dx_cp_port_gggg_fara_shopisunderkonnicont"];
    level.vo.var_b8bac1b78851d1a3 = create_deck(aliases, 1, 1, 1);
  }

  var_9ed18883d5c763a1 = [level.player, 0.3, level.vo.var_b8bac1b78851d1a3 deck_draw()];
  var_cb7fcc660aafd7bc = [level.player, 0.3, level.vo.var_3e26be352e93e1fe deck_draw(), level.graves, 0.4, level.vo.var_27ca77e5af20ed45 deck_draw()];
  played = 0;
  var_e3b578a5c40f6a86 = getStructArray("notice_machshop", "targetname");

  while(!istrue(played)) {
    while(true) {
      if(function_909f63295ad5bc62(500)) {
        break;
      }

      wait 0.2;
    }

    sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);

    if(function_a7c8f01b64b95e8e() && function_e7f0b424b27ddcd1(500)) {
      played = say_sequence(sequence, 0.3, 3, 0, 0.5);
    }

    wait 1;
  }
}

function function_909f63295ad5bc62(dist) {
  dist = default_to(dist, 400);
  origin = (991, -2065, 105);
  height = 255;

  if(!isDefined(level.player)) {
    return 0;
  }

  if(distance2dsquared(level.player.origin, origin) < dist * dist && level.player.origin[2] < 255) {
    return 1;
  }

  return 0;
}

function function_e7f0b424b27ddcd1(dist) {
  dist = default_to(dist, 400);
  origin = (991, -2065, 105);
  height = 255;
  ai_array = getaiarrayinradius(origin, dist, "axis");

  if(ai_array.size > 0) {
    return 1;
  }

  return 0;
}

function vo_notice_dockbodies() {
  level endon("game_ended");
  var_c1ac4b4885957a27 = create_deck(["dx_cp_port_ndbn_fara_halfthedeadaredenasw", "dx_cp_port_ndbn_fara_nosignofsurvivorsjus"]);
  var_c1ac4c4885957c5a = create_deck(["dx_cp_port_ndbn_fara_urzikstanwasfreeofvi", "dx_cp_port_ndbn_fara_thesewereinnocentpeo"]);
  var_a9b3c8564b9c5197 = create_deck(["dx_cp_port_ndbn_grav_peacethroughstrength", "dx_cp_port_ndnr_grav_sometimesthatsthebus", "dx_cp_port_ndnr_grav_konnigroupisfullofwa", "dx_cp_port_ndnr_grav_damnshamewhencivilia", "dx_cp_port_ndnr_grav_noteveryoneplaysbyth"]);
  var_cf47821a07174187 = level.vo.var_cf47821a07174187;

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0, 1, 0, 0.5)) {
    var_cf47821a07174187 waittill_player_lookat(undefined, 5, 120, undefined, undefined, 1);

    if(function_a7c8f01b64b95e8e()) {
      continue;
    }

    sequence = [level.farah, 0.3, var_c1ac4b4885957a27 deck_draw(), level.farah, 0.4, var_c1ac4c4885957c5a deck_draw(), level.graves, 0.5, var_a9b3c8564b9c5197 deck_draw()];
  }
}

function function_aa701d8b60a0e9af() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_aed71223afc82871)) {
    aliases = ["dx_cp_port_ngea_fara_iseegearcloseby", "dx_cp_port_ngea_fara_sightedsomegear", "dx_cp_port_ngea_fara_seeuseablegear", "dx_cp_port_ngea_fara_foundgear", "dx_cp_port_ngea_fara_spottedgear", "dx_cp_port_ngea_fara_moreequipment", "dx_cp_port_ngea_fara_visualonequipment", "dx_cp_port_ngea_fara_goteyesongear"];
    level.vo.var_aed71223afc82871 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ngea_grav_takeit", "dx_cp_port_ngea_grav_grabitifyouwant", "dx_cp_port_ngea_grav_commandeeritkilo", "dx_cp_port_ngea_grav_getit", "dx_cp_port_ngea_grav_stockupwhileyoucan"];
    level.vo.var_85dd7c979130220 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ngec_fara_eyesongear", "dx_cp_port_ngec_fara_moregear", "dx_cp_port_ngec_fara_eyesonequipment", "dx_cp_port_ngec_fara_iseegear", "dx_cp_port_ngec_fara_moreequipment", "dx_cp_port_ngec_fara_gotsupplieshere", "dx_cp_port_ngec_fara_gotequipmenthere", "dx_cp_port_ngec_fara_gotsupplies"];
    level.vo.var_70370f38e3c9950a = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ngec_grav_takeit", "dx_cp_port_ngec_grav_grabitifyouwant", "dx_cp_port_ngec_grav_commandeeritkilo", "dx_cp_port_ngec_grav_getit", "dx_cp_port_ngec_grav_stockthehellup"];
    level.vo.var_f48f4b172dbba36d = create_deck(aliases, 1, 1, 1);
  }

  var_cb7fcc660aafd7bc = [level.player, 0.3, level.vo.var_aed71223afc82871 deck_draw(), level.graves, 0.4, level.vo.var_85dd7c979130220 deck_draw()];
  var_9ed18883d5c763a1 = [level.player, 0.3, level.vo.var_70370f38e3c9950a deck_draw(), level.player, 0.4, level.vo.var_f48f4b172dbba36d deck_draw()];
  var_ad612b7313f0a24 = getStructArray("armor_pickup_vest", "targetname");

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0, 2, 0, 0.5)) {
    var_ad612b7313f0a24 waittill_player_lookat(undefined, 5, 120, undefined, undefined, 1);
    sequence = function_70386f0dbf01d6f4(var_9ed18883d5c763a1, var_cb7fcc660aafd7bc);
  }
}

function vo_notice_tower() {
  level endon("game_ended");
  level endon("flag_vo_hmo_near");

  if(!isDefined(level.vo.notice_tower)) {
    aliases = ["dx_cp_port_noto_fara_goteyesontheharborto", "dx_cp_port_noto_fara_visualonthetowerdena", "dx_cp_port_noto_fara_denasofficewasinthat", "dx_cp_port_noto_fara_haveeyesontheharbort", "dx_cp_port_noto_fara_denasofficewasinthat_01"];
    level.vo.notice_tower = create_deck(aliases, 1, 1, 1);
  }

  sequence = [level.player, 0.4, level.vo.notice_tower deck_draw(), level.graves, 0.3, "dx_cp_port_notr_grav_nevereasytoloseyourp", level.farah, 0.4, "dx_cp_port_notr_fara_dontknowhowilltellde", level.graves, 0.4, "dx_cp_port_notr_grav_youneedtosurvivethis", level.farah, 0.3, "dx_cp_port_notr_fara_youredamnrightidogra", level.graves, 0.3, "dx_cp_port_notr_grav_nowletskeeponitkilo"];
  var_2f163f8850928170 = getStructArray("notice_tower", "targetname");

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0.5, 5, 0, 0.5)) {
    var_2f163f8850928170 waittill_player_lookat(30, 1000, 3500, undefined, undefined, 1);

    if(function_a7c8f01b64b95e8e()) {
      continue;
    }

    if(flag("flag_vo_hmo_near")) {
      break;
    }

    if(flag("flag_manifest_retrieved")) {
      break;
    }
  }
}

function vo_notice_mantle() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_a7aa5847c69460e9)) {
    aliases = ["dx_cp_port_nlnc_fara_movementonthecontain", "dx_cp_port_nlnc_fara_shadowkonniisclimbin", "dx_cp_port_nlnc_fara_shadowkonniisscaling", "dx_cp_port_nlnc_fara_gravesgothostilessea", "dx_cp_port_nlnc_fara_1enemyforcesaresearc"];
    level.vo.var_a7aa5847c69460e9 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nlnc_grav_mustbesearchingoutth", "dx_cp_port_nlnc_grav_theyrelookingforthem"];
    level.vo.var_4293f2d059740ce9 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_ncnr_grav_stillsearchingmeansw", "dx_cp_port_ncnr_grav_haventlocatedanythin", "dx_cp_port_ncnr_grav_seekandyeshallfindwe", "dx_cp_port_ncnr_grav_thentheylikelyhavent", "dx_cp_port_ncnr_grav_theyrestillsearching"];
    level.vo.var_f49619d5336a3df1 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nclc_fara_hostilesscalingconta", "dx_cp_port_nclc_fara_konnisclimbingthecon", "dx_cp_port_nclc_fara_gotmultipleenemiessc"];
    level.vo.var_86806627fc2c7f82 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_nclc_grav_theyrelookingforthem", "dx_cp_port_nclc_grav_konnionthecontainers"];
    level.vo.var_547e5104a09c95a5 = create_deck(aliases, 1, 1, 1);
  }

  var_7ad24216781dc334 = getStructArray("ai_mantle_struct", "targetname");

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0.5, 3, 0, 0.5)) {
    var_7ad24216781dc334 waittill_player_lookat(undefined, 700, 1300, undefined, undefined, 1);
    sequence = [];

    if(!function_a7c8f01b64b95e8e()) {
      sequence = [level.player, 0, level.vo.var_a7aa5847c69460e9 deck_draw()];
      var_f6fb65b0d63b682b = [level.graves, 0, level.vo.var_4293f2d059740ce9 deck_draw(), level.farah, 0, "dx_cp_port_nlnc_fara_theycanthavethem", level.graves, 0, "dx_cp_port_nlnc_grav_theyregonnahaveavote"];
      var_f6fb66b0d63b6a5e = [level.graves, 0, level.vo.var_f49619d5336a3df1 deck_draw(), level.farah, 0, "dx_cp_port_ncnr_fara_itwillrunout", level.graves, 0, "dx_cp_port_ncnr_grav_yeahitwill"];
      sequence = array_combine(sequence, percent_chance(50) ? var_f6fb65b0d63b682b : var_f6fb66b0d63b6a5e);
      continue;
    }

    sequence = [level.player, 0, level.vo.var_86806627fc2c7f82 deck_draw(), level.graves, 0, level.vo.var_547e5104a09c95a5 deck_draw()];
  }
}

function function_7119ea16c9ea1314() {
  if(!isDefined(level.vo.var_fb0921b2185f30ea)) {
    aliases = ["dx_cp_port_njnc_fara_haveeyesonenemyjltv", "dx_cp_port_njnc_fara_hostilejltvspatrolli", "dx_cp_port_njnc_fara_enemyjltvsonthemove", "dx_cp_port_njnc_fara_theyhaveanactivejltv", "dx_cp_port_njnc_fara_clockingajltv"];
    level.vo.var_fb0921b2185f30ea = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_327dcdc7ca588246)) {
    aliases = ["dx_cp_port_njnr_grav_stayoutofsightorgear", "dx_cp_port_njnr_grav_theyspotyoutheyllcom", "dx_cp_port_njnr_grav_dontletemgettooclose", "dx_cp_port_njnr_grav_makesureyougotwhatyo", "dx_cp_port_njnr_grav_theygetyouintheirsig"];
    level.vo.var_327dcdc7ca588246 = create_deck(aliases, 1, 1, 1);
  }

  var_84c58846f5116744 = [level.player, 0.3, level.vo.var_fb0921b2185f30ea deck_draw(), level.graves, 0.4, level.vo.var_327dcdc7ca588246 deck_draw()];

  if(!isDefined(level.vo.var_aa078060dad5f925)) {
    aliases = ["dx_cp_port_njtc_grav_enemyjltv", "dx_cp_port_njtc_grav_theygotajltv", "dx_cp_port_njtc_grav_hostilejltv", "dx_cp_port_njtc_grav_watchforthejltvfarah", "dx_cp_port_njtc_grav_lookoutforkonnijltvs", "dx_cp_port_njtc_fara_konnijltv", "dx_cp_port_njtc_fara_visualonenemyjltv", "dx_cp_port_njtc_fara_konnijltvontheground", "dx_cp_port_njtc_fara_enemyjltvsmoving", "dx_cp_port_njtc_fara_konnihasjltvsinthepo"];
    level.vo.var_aa078060dad5f925 = create_deck(aliases, 1, 1, 1);
  }

  var_8afdac9ba3efccb5 = [level.player, 0.3, level.vo.var_aa078060dad5f925 deck_draw()];
  var_66a1156521ee6dea = level.var_84ff13af8e463899;

  if(!isDefined(var_66a1156521ee6dea)) {
    return;
  }

  wait 5;

  for(played = 0; !istrue(played); played = say_sequence(sequence, 0.1, 3, 0, 0.5)) {
    var_66a1156521ee6dea waittill_player_lookat(undefined, 1000, 2000, undefined, undefined, 1);
    sequence = function_70386f0dbf01d6f4(var_8afdac9ba3efccb5, var_84c58846f5116744);
  }
}

function function_d91e5b6d7f23af44() {
  if(!isDefined(level.vo.var_5c09fcce860ae98a)) {
    aliases = ["dx_cp_port_ncci_fara_shadowcontaineritsun", "dx_cp_port_ncci_fara_foundanunlockedshado", "dx_cp_port_ncci_fara_spottedacontainerico", "dx_cp_port_ncci_fara_foundashadowcontaine", "dx_cp_port_ncci_fara_thisshadowcontainers"];
    level.vo.var_5c09fcce860ae98a = create_deck(aliases, 1, 1, 1);
    level.vo.var_1c7282027e97616e = spawnStruct();
    level.vo.var_1c7282027e97616e.var_66ccb1e7253709fc = [level.graves, 0.3, "dx_cp_port_ocir_grav_urzikstanisourgotopo", level.farah, 0.2, "dx_cp_port_ocir_fara_whatwillioweyougrave", level.graves, 0.3, "dx_cp_port_ocir_grav_notathingiwanttheseb"];
    level.vo.var_1c7282027e97616e.var_66ccb4e725371095 = [level.graves, 0.4, "dx_cp_port_ncci_grav_helpyourselfkilo", level.graves, 0.3, "dx_cp_port_ncci_grav_micasaessucasa", level.farah, 0.3, "dx_cp_port_ncci_fara_youspeakspanish", level.graves, 0.4, "dx_cp_port_ncci_grav_ipickedupsomeinmexic", level.farah, 0.4, "dx_cp_port_ncci_fara_howlongwereyouthere", level.graves, 0.3, "dx_cp_port_ncci_grav_toolong"];
  }

  level.vo.var_1c7282027e97616e.var_5b16eb9ae97604fa = 0;
  level.vo.var_1c7282027e97616e.var_8a2342d40eb3a844 = 0;
}

function function_2631c4de0c00f5a3() {
  level endon("game_ended");
  self endon("trigger");

  if(distance2d(self.origin, (2415, -468, 58)) < 50) {
    return;
  }

  flag_wait("vo_intro_finished");
  function_d91e5b6d7f23af44();
  self.var_b19c4f4885220bc2 = [level.player, 0.3, level.vo.var_5c09fcce860ae98a deck_draw()];
  thread function_788c1ae5ee35917d();
  self.var_f7e62784b4b142b9 = 0;

  while(!istrue(self.var_f7e62784b4b142b9) && !istrue(self.var_90c161ea8f7984de)) {
    waittill_player_lookat(65, 50, 250, undefined, undefined, 0.75);

    if(gettime() < level.vo.var_1c7282027e97616e.var_5b16eb9ae97604fa + 30000) {
      continue;
    }

    if(function_a7c8f01b64b95e8e()) {
      continue;
    }

    if(istrue(self.var_90c161ea8f7984de)) {
      break;
    }

    self.var_f7e62784b4b142b9 = level.player say_sequence(self.var_b19c4f4885220bc2, 0.2, 1.5, 0, 0.5);
  }

  level.vo.var_1c7282027e97616e.var_5b16eb9ae97604fa = gettime();
}

function function_788c1ae5ee35917d() {
  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    break;
  }

  self.var_90c161ea8f7984de = 1;
  wait 1.5;
  sequence = [];

  if(isDefined(self.var_f7e62784b4b142b9) && self.var_f7e62784b4b142b9 == 0) {
    if(!level.player is_speaking() && !is_equal(level.player.var_88502eb1e08dfc4d, self.var_b19c4f4885220bc2[2])) {
      sequence = self.var_b19c4f4885220bc2;
    }
  }

  if(function_a7c8f01b64b95e8e()) {
    return;
  }

  played = 0;

  if(level.vo.var_1c7282027e97616e.var_8a2342d40eb3a844 == 0) {
    sequence = array_combine(sequence, level.vo.var_1c7282027e97616e.var_66ccb1e7253709fc);
  } else if(level.vo.var_1c7282027e97616e.var_8a2342d40eb3a844 == 1) {
    sequence = array_combine(sequence, level.vo.var_1c7282027e97616e.var_66ccb4e725371095);
  }

  if(isDefined(sequence) && sequence.size > 1) {
    played = level.graves say_sequence(sequence, 0.35, 2, 0, 0.5);
  }

  if(!isDefined(played) || played == 1) {
    level.vo.var_1c7282027e97616e.var_8a2342d40eb3a844++;
  }
}

function function_9f23d35752fe7143() {
  level endon("game_ended");

  if(!isDefined(level.vo.var_8bbdc1e10cb57cee)) {
    aliases = ["dx_cp_port_noci_fara_spottedashadowcontai", "dx_cp_port_noci_fara_theresgearinthere", "dx_cp_port_noci_fara_someshadowcontainers", "dx_cp_port_noci_fara_someofthesecontainer", "dx_cp_port_noci_fara_seeingshadowcontaine"];
    level.vo.var_8bbdc1e10cb57cee = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(level.vo.var_1ef34fa2107bc1b9)) {
    aliases = ["dx_cp_port_noci_grav_theresmoreshadowcont", "dx_cp_port_noci_grav_stockuponsuppliessha", "dx_cp_port_noci_grav_feelfreetotakeourgea", "dx_cp_port_noci_grav_yourenearashadowcont", "dx_cp_port_noci_grav_shadowgearinthosecon"];
    level.vo.var_1ef34fa2107bc1b9 = create_deck(aliases, 1, 1, 1);
  }

  var_6cf0d7a0fefa454b = [level.player, 0, level.vo.var_8bbdc1e10cb57cee deck_draw()];
  var_2458cec7615cc8d7 = [level.graves, 0, level.vo.var_1ef34fa2107bc1b9 deck_draw()];
  sequence = percent_chance(40) ? var_6cf0d7a0fefa454b : var_2458cec7615cc8d7;
  var_1cc7d5caa463c322 = getStructArray("vo_notice_cont_open", "targetname");
  played = 0;

  while(!istrue(played)) {
    var_1cc7d5caa463c322 waittill_player_lookat(undefined, 100, 400, undefined, undefined, 1);

    if(function_a7c8f01b64b95e8e()) {
      break;
    }

    played = say_sequence(sequence, 0.2, 4, 0, 0.5);
    wait 10;
  }
}

function vo_notice_ship() {
  level endon("game_ended");
  level endon("flag_board_ship");

  if(!isDefined(level.vo.notice_ship)) {
    aliases = ["dx_cp_port_nosh_fara_gravesyourshipisstil", "dx_cp_port_nosh_fara_shadowscargoshipisst", "dx_cp_port_nosh_fara_konnihasntstolenyour", "dx_cp_port_nosh_fara_sightedyourshipgrave", "dx_cp_port_nosh_fara_shadowscargoshipisst_01"];
    level.vo.notice_ship = create_deck(aliases, 1, 1, 1);
  }

  sequence = [level.player, 0.4, level.vo.notice_ship deck_draw(), level.graves, 0.3, "dx_cp_port_nosr_grav_youseeanyofmypeople", level.player, 0.5, "dx_cp_port_nosr_fara_negative", level.graves, 0.4, "dx_cp_port_nosr_grav_mmnotwhatiwantedtohe"];
  var_cb2c566daaba1433 = getStructArray("notice_ship", "targetname");
  played = 0;

  while(!istrue(played)) {
    var_cb2c566daaba1433 waittill_player_lookat(30, 1000, 3500, undefined, undefined, 1);

    if(function_a7c8f01b64b95e8e()) {
      continue;
    }

    if(flag_any(["flag_board_ship", "flag_trackers_retrieved"])) {
      break;
    }

    if(!isDefined(level.var_20484a3cff522215)) {
      level.var_20484a3cff522215 = 0;
    }

    if(!time_has_passed(level.var_20484a3cff522215, 15)) {
      played = say(level.vo.notice_ship deck_draw(), 0.2, 3, 0, 0.5);
    } else {
      played = say_sequence(sequence, 0.5, 3, 0, 0.5);
    }

    if(istrue(played)) {
      level.var_20484a3cff522215 = gettime();
      break;
    }
  }
}

function function_174ba1ccffae4818() {
  sequence = [level.farah, 0.3, "dx_cp_port_nosv_fara_spottedyourvehiclegr", level.graves, 0.4, "dx_cp_port_nosv_grav_thoughtthatmightcome", level.farah, 0.3, "dx_cp_port_nosv_fara_itjustmight"];
  original_position = level.var_42121fc7776918bd.origin;
  played = 0;

  while(!istrue(played)) {
    level.var_42121fc7776918bd waittill_player_lookat(70, undefined, 1600, (-25, -85, 25), undefined, 1);

    if(function_a7c8f01b64b95e8e()) {
      continue;
    }

    if(distance(original_position, level.var_42121fc7776918bd.origin) > 25) {
      return;
    }

    played = say_sequence(sequence, 0.5, 1, 0, 0.5);

    if(istrue(played)) {
      break;
    }
  }
}

function function_ddb529054ae6c549(pickups) {
  for(munitions = function_82cc74592d6295ac(); true; munitions = array_remove_key(munitions, var_5a8f1accec64dc4a)) {
    level waittill("munition_pickup", var_5a8f1accec64dc4a);

    if(!isDefined(var_5a8f1accec64dc4a)) {
      continue;
    }

    if(level.player function_da0fc97699b7c873("obj_board_ship") || level.player function_da0fc97699b7c873("obj_harbormaster_building")) {
      continue;
    }

    if(!array_contains_key(munitions, var_5a8f1accec64dc4a)) {
      continue;
    }

    sequence = munitions[var_5a8f1accec64dc4a];
    played = say_sequence(sequence, 0.25, 1, 0, 0.5);

    if(istrue(played)) {}
  }
}

function function_5fd00c1d1a6f2d02() {
  if(!isDefined(level.vo.var_7b4d5ef8d1a89b03)) {
    aliases = ["dx_cp_port_pnsd_fara_dronewouldgivemebett", "dx_cp_port_pnsd_fara_coulduseadronetoscop", "dx_cp_port_pnsd_fara_theresadroneifineedt"];
    level.vo.var_7b4d5ef8d1a89b03 = create_deck(aliases, 1, 1, 1);
  }

  while(true) {
    level waittill("pickedupweapon_all", pickupent);

    if(!isDefined(pickupent) || !is_equal(pickupent.scriptablename, "brloot_super_recondrone")) {
      continue;
    }

    if(function_a7c8f01b64b95e8e()) {
      continue;
    }

    var_c486ef0a9937b42e = [level.player, 0.4, level.vo.var_7b4d5ef8d1a89b03 deck_draw(), level.graves, 0.3, "dx_cp_port_pnsd_grav_goodfind"];
    played = say_sequence(var_c486ef0a9937b42e, 0.5, 1, 0, 0.5);

    if(played) {
      return;
    }
  }
}

function function_82cc74592d6295ac() {
  var_d5f95fff9c8036af = [level.farah, 0.4, "dx_cp_port_geua_fara_uav", level.graves, 0.3, "dx_cp_port_geua_grav_birdseyeviewonlywayt"];
  var_c3fad1aa11c87d82 = [level.farah, 0.4, "dx_cp_port_gemo_fara_lookslikeamosquitodr", level.graves, 0.3, "dx_cp_port_gemo_grav_thatsexactlywhatitis"];
  var_f20c129ba88a7b85 = [level.farah, 0.4, "dx_cp_port_gebd_fara_grabbedabombdrone", level.graves, 0.3, "dx_cp_port_gebd_grav_flyinc4becarefulwith"];
  var_e9abb9834b636c1e = [level.farah, 0.4, "dx_cp_port_gecm_fara_isacruisemissileusua", level.graves, 0.3, "dx_cp_port_gecm_grav_youtellme"];
  var_4e0ec7c369131f0b = [level.farah, 0.3, "dx_cp_port_gesg_fara_doesshadowhaveunlimi", level.graves, 0.4, "dx_cp_port_gesg_grav_werewellinvested", level.farah, 0.4, "dx_cp_port_gesg_fara_thismustvecostafortu", level.graves, 0.4, "dx_cp_port_gesg_grav_fundsandfavorsmaketh", level.farah, 0.3, "dx_cp_port_gesg_fara_thatssomestockpile", level.graves, 0.4, "dx_cp_port_gesg_grav_theysaythepenismight"];
  var_ab92432c9582fb28 = ["switchblade_drone": var_c3fad1aa11c87d82, "assault_drone": var_f20c129ba88a7b85, "cruise_missile": var_e9abb9834b636c1e, "sentry": var_4e0ec7c369131f0b, "uav": var_d5f95fff9c8036af];
  return var_ab92432c9582fb28;
}

function function_47cb26ce5b67bc8c() {
  level.vo.var_eb120c9e1dd36f0a = spawnStruct();
  var_ab92432c9582fb28 = function_9a2746087718eadd();
  childthread function_f03f99a7294b0dba();

  while(true) {
    level.player waittill("munitions_used", var_5a8f1accec64dc4a);

    if(!isDefined(var_5a8f1accec64dc4a)) {
      continue;
    }

    if(function_a7c8f01b64b95e8e()) {
      var_5a8f1accec64dc4a += "_combat";
    }

    if(!array_contains_key(var_ab92432c9582fb28, var_5a8f1accec64dc4a)) {
      continue;
    }

    sequence = var_ab92432c9582fb28[var_5a8f1accec64dc4a] deck_draw();
    played = say_sequence(sequence, 1, 1, 0, 0.5);

    if(istrue(played)) {
      var_ab92432c9582fb28 = array_remove_key(var_ab92432c9582fb28, var_5a8f1accec64dc4a);
    }
  }
}

function function_f03f99a7294b0dba() {
  level.player waittill("assault_drone_deployed");
  level.player say(function_cd70fbc5ff85bc7d(level.vo.var_7c75db0107cf9c52, level.vo.var_dd5c25f066064405), 0.8, 1, 0, 0.5);
}

function function_9a2746087718eadd() {
  if(!isDefined(level.vo.var_aca858ffbb59c32f)) {
    aliases = ["dx_cp_port_usua_fara_sendingouttheuav", "dx_cp_port_usua_fara_uavisout", "dx_cp_port_usua_fara_uavsupandrunning", "dx_cp_port_usua_fara_uavsonthemove", "dx_cp_port_usua_fara_uavisintheair"];
    level.vo.var_aca858ffbb59c32f = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_1114_fara_sendingouttheuav", "dx_cp_port_1114_fara_uavisout", "dx_cp_port_1114_fara_uavsupandrunning", "dx_cp_port_1114_fara_uavsonthemove", "dx_cp_port_1114_fara_uavisintheair"];
    level.vo.var_a564a9b25bb91260 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_usmo_fara_themosquitosup", "dx_cp_port_usmo_fara_mosquitosactive", "dx_cp_port_usmo_fara_activatedthemosquito", "dx_cp_port_usmo_fara_mosquitoisonline", "dx_cp_port_usmo_fara_deployingmosquito"];
    level.vo.var_5d2d2b0c6fca1302 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_1115_fara_themosquitosup", "dx_cp_port_1115_fara_mosquitosactive", "dx_cp_port_1115_fara_activatedthemosquito", "dx_cp_port_1115_fara_mosquitoisonline", "dx_cp_port_1115_fara_deployingmosquito"];
    level.vo.var_10fdc3a2c93a314f = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_usbd_fara_bombdroneonline", "dx_cp_port_usbd_fara_bombdroneonthemove", "dx_cp_port_usbd_fara_thebombdroneisout", "dx_cp_port_usbd_fara_sendingoutthebombdro", "dx_cp_port_usbd_fara_deployingbombdrone"];
    level.vo.var_dd5c25f066064405 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_1116_fara_bombdroneonline", "dx_cp_port_1116_fara_bombdroneonthemove", "dx_cp_port_1116_fara_thebombdroneisout", "dx_cp_port_1116_fara_sendingoutthebombdro", "dx_cp_port_1116_fara_deployingbombdrone"];
    level.vo.var_7c75db0107cf9c52 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_uscm_fara_cruisemissilesonline", "dx_cp_port_uscm_fara_cruisemissilemoving", "dx_cp_port_uscm_fara_cruisemissilelaunche", "dx_cp_port_uscm_fara_cruisemissileisactiv", "dx_cp_port_uscm_fara_launchingcruisemissi"];
    level.vo.var_14f9448ceed8fc9e = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_1119_fara_cruisemissilesonline", "dx_cp_port_1119_fara_cruisemissilemoving", "dx_cp_port_1119_fara_cruisemissilelaunche", "dx_cp_port_1119_fara_cruisemissileisactiv", "dx_cp_port_1119_fara_launchingcruisemissi"];
    level.vo.var_331eb2ced324b903 = create_deck(aliases, 1, 1, 1);
  }

  var_973eff5f4251716d = ["cruise_missile_combat": level.vo.var_331eb2ced324b903, "cruise_missile": level.vo.var_14f9448ceed8fc9e, "switchblade_drone_combat": level.vo.var_10fdc3a2c93a314f, "switchblade_drone": level.vo.var_5d2d2b0c6fca1302, "uav_combat": level.vo.var_a564a9b25bb91260, "uav": level.vo.var_aca858ffbb59c32f];
  return var_973eff5f4251716d;
}

function function_a4fc183dfeccb918() {
  if(!isDefined(level.vo.var_db117ae3abea2adb)) {
    function_a7228048f360bb32();
    assert(isDefined(level.vo.var_db117ae3abea2adb));
  }

  wait 5;
  var_61753ae8124ce989 = ["flag_container2"];
  var_ad9041d8b5db0a4f = function_eac0cd99c9c6d8ee();
  var_ed1e225d2f4e55c9 = "clear";

  while(true) {
    wait 1;

    if(flag_any(var_61753ae8124ce989)) {
      return;
    }

    if(scripts\cp\laststand::player_in_laststand(level.player)) {
      continue;
    }

    var_38db78cfd89ddb8b = function_eac0cd99c9c6d8ee();

    var_6d7a24f8c2b6a1ae = var_ad9041d8b5db0a4f == "<dev string:x1c>" && var_38db78cfd89ddb8b == "<dev string:x23>";
    var_dba4e6719a450198 = var_ad9041d8b5db0a4f == "<dev string:x23>" && var_38db78cfd89ddb8b == "<dev string:x1c>";
    var_e666c89656842ee9 = function_1bb1470f934a81eb();
    var_fb51a12ae08fdc4c = function_6e7eeaf3dc05e54e();
    var_48f9ba03a7b8897c = function_8f63b34b24e150de();
    println("<dev string:x2b>" + var_e666c89656842ee9 + "<dev string:x34>" + var_fb51a12ae08fdc4c + "<dev string:x3d>" + var_48f9ba03a7b8897c);

    if(var_38db78cfd89ddb8b == "hidden") {
      println("<dev string:x48>");
      var_fe5418da61094b14 = function_94acd5be090760cc(var_ed1e225d2f4e55c9);
      var_ed1e225d2f4e55c9 = default_to(var_fe5418da61094b14, var_ed1e225d2f4e55c9);
    } else {
      println("<dev string:x4f>");
      var_fe5418da61094b14 = function_9921f747f29da3ad(var_ed1e225d2f4e55c9);
      var_ed1e225d2f4e55c9 = default_to(var_fe5418da61094b14, var_ed1e225d2f4e55c9);
    }

    var_ad9041d8b5db0a4f = var_38db78cfd89ddb8b;
  }
}

function function_94acd5be090760cc(var_ed1e225d2f4e55c9) {
  if(flag("vo_hidden_said") || flag("flag_container2")) {
    return undefined;
  }

  var_e666c89656842ee9 = function_1bb1470f934a81eb();
  var_fb51a12ae08fdc4c = function_6e7eeaf3dc05e54e();
  var_48f9ba03a7b8897c = function_8f63b34b24e150de();

  if(var_fb51a12ae08fdc4c && var_ed1e225d2f4e55c9 != "hunt") {
    flag_set("vo_hidden_said");
    sequence = [level.graves, 0, level.vo.var_5b446985deb24321 deck_draw()];
    played = say_sequence(sequence, 0.5, 4, 0, 2);

    if(istrue(played)) {
      var_ed1e225d2f4e55c9 = "hunt";
    }
  } else if(!var_fb51a12ae08fdc4c && var_48f9ba03a7b8897c && var_ed1e225d2f4e55c9 != "investigate") {
    flag_set("vo_hidden_said");
    var_11e7a31396ad922 = level.vo.var_ed8c0f68867ab0ff > 1 ? level.vo.var_e5f327e35a3ea5fb : level.vo.var_8e0ed2a21bf988e7;
    sequence = [level.graves, 0, var_11e7a31396ad922 deck_draw()];
    played = say_sequence(sequence, 0.5, 4, 0, 2);

    if(istrue(played)) {
      var_ed1e225d2f4e55c9 = "investigate";
      level.vo.var_ca9e7a5abc36e84a = gettime();
    }
  } else if(!var_fb51a12ae08fdc4c && !var_48f9ba03a7b8897c && var_ed1e225d2f4e55c9 != "clear" && gettime() > level.vo.var_ca9e7a5abc36e84a + 7500) {
    flag_set("vo_hidden_said");
    sequence = [level.graves, 0, level.vo.var_db117ae3abea2adb deck_draw()];
    played = say_sequence(sequence, 0.5, 4, 0, 2);

    if(istrue(played)) {
      var_ed1e225d2f4e55c9 = "clear";
    }
  }

  namespace_d3c2a7ff4bcf34e0::flag_clear_delayed("vo_hidden_said", 1);
  return var_ed1e225d2f4e55c9;
}

function function_9921f747f29da3ad(var_ed1e225d2f4e55c9) {
  if(flag("vo_alert_said")) {
    return undefined;
  }

  var_e666c89656842ee9 = function_1bb1470f934a81eb();
  var_fb51a12ae08fdc4c = function_6e7eeaf3dc05e54e();
  var_48f9ba03a7b8897c = function_8f63b34b24e150de();

  if(flag("vo_red_alert")) {
    flag_set("vo_alert_said");

    if(var_ed1e225d2f4e55c9 != "red_alert") {
      sequence = [level.graves, 0, level.vo.var_c357efafb67a656f deck_draw()];
      played = say_sequence(sequence, 0.5, 4, 0, 2);

      if(istrue(played)) {
        var_ed1e225d2f4e55c9 = "red_alert";
      }
    }
  } else if(var_e666c89656842ee9 && var_ed1e225d2f4e55c9 != "combat") {
    flag_set("vo_alert_said");
    alias = level.vo.var_1155b6f5785024d4 deck_draw();

    if(is_equal(alias, "dx_cp_port_suco_grav_theresenemyfire")) {
      wait 0.25;
      nearby_ai = getaiarrayinradius(level.player.origin, 2000, "axis");
      var_f4b14d10a211cae2 = function_a3b5f52b9d203b7f(nearby_ai);

      if(!isDefined(var_f4b14d10a211cae2)) {
        alias = level.vo.var_1155b6f5785024d4 deck_draw();
      }
    }

    sequence = [level.graves, 0, alias];
    played = say_sequence(sequence, 0.5, 4, 0, 2);
    level.vo.var_ed8c0f68867ab0ff = gettime();

    if(istrue(played)) {
      var_ed1e225d2f4e55c9 = "combat";
    }
  } else if(!var_e666c89656842ee9 && var_fb51a12ae08fdc4c && var_ed1e225d2f4e55c9 != "hunt") {
    flag_set("vo_alert_said");
    sequence = [level.graves, 0, level.vo.var_5b446985deb24321 deck_draw()];
    played = say_sequence(sequence, 0.5, 4, 0, 2);

    if(istrue(played)) {
      var_ed1e225d2f4e55c9 = "hunt";
    }
  } else if(!var_e666c89656842ee9 && !var_fb51a12ae08fdc4c && var_48f9ba03a7b8897c && var_ed1e225d2f4e55c9 != "investigate") {
    flag_set("vo_alert_said");
    sequence = [level.graves, 0, level.vo.var_e5f327e35a3ea5fb deck_draw()];
    played = say_sequence(sequence, 0.5, 4, 0, 2);

    if(istrue(played)) {
      var_ed1e225d2f4e55c9 = "investigate";
    }
  }

  namespace_d3c2a7ff4bcf34e0::flag_clear_delayed("vo_alert_said", 1);
  return var_ed1e225d2f4e55c9;
}

function function_a7228048f360bb32() {
  if(!isDefined(level.vo.var_db117ae3abea2adb)) {
    aliases = ["dx_cp_port_sunc_grav_thingsseemquieter", "dx_cp_port_sunc_grav_dontthinktheyknowyou", "dx_cp_port_sunc_grav_notpickinupmuchenemy", "dx_cp_port_sunc_grav_idsaytheydontknowwhe", "dx_cp_port_sunc_grav_youmaybehiddenfornow", "dx_cp_port_sunc_grav_farahtheydontseeyou"];
    level.vo.var_db117ae3abea2adb = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_suin_grav_theymaysuspectsomeon", "dx_cp_port_suin_grav_konnisinvestigatings", "dx_cp_port_suin_grav_konniknowssomethings", "dx_cp_port_suin_grav_enemymightbeontoyou", "dx_cp_port_suin_grav_yougotkonnionedgewat", "dx_cp_port_suin_grav_headsupyoumightbecom"];
    level.vo.var_8e0ed2a21bf988e7 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_sual_grav_konniknowsyourehere", "dx_cp_port_sual_grav_hostilesarelookingfo", "dx_cp_port_sual_grav_eyesupkonnissearchin", "dx_cp_port_sual_grav_konnisgottabelooking", "dx_cp_port_sual_grav_theyknowyourestillal", "dx_cp_port_sual_grav_theyresearchingforya"];
    level.vo.var_e5f327e35a3ea5fb = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_suco_grav_theresenemyfire", "dx_cp_port_suco_grav_soundsliketheyfoundy", "dx_cp_port_suco_grav_thinkyouremadekilo", "dx_cp_port_suco_grav_konniscominforyafara"];
    level.vo.var_1155b6f5785024d4 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_sphn_grav_theyrehuntingforyast", "dx_cp_port_sphn_grav_theyresweepingtheare", "dx_cp_port_sphn_grav_stayoutofsightkonnis", "dx_cp_port_sphn_grav_theyrelookingforyouk", "dx_cp_port_sphn_grav_konnisonthehuntwatch"];
    level.vo.var_5b446985deb24321 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_sura_grav_farahgetoutofthere", "dx_cp_port_sura_grav_beadvisedkonnisonhig", "dx_cp_port_sura_grav_enemyreinforcementsi", "dx_cp_port_sura_grav_watchyourasstheyllal", "dx_cp_port_sura_grav_konniscomintogetyafa"];
    level.vo.var_c357efafb67a656f = create_deck(aliases, 1, 1, 1);
  }
}

function vo_red_alert() {
  while(true) {
    level.vo waittill("red_alert", is_active);

    if(flag("tracker_done")) {
      return;
    }

    if(istrue(is_active)) {
      flag_set("vo_red_alert");
      continue;
    }

    flag_clear("vo_red_alert");
  }
}

function function_a963b0c7d5cfeea2(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(eattacker)) {
    eattacker.var_acee42d23dd54f0f = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_864cab28ac2178c3() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_container2");
  self waittill("death", attacker, meansofdeath, weaponobject, damagelocation);

  if(!isDefined(level.vo.var_7970c6c8b5335c7e)) {
    aliases = ["dx_cp_port_kwve_fara_hostilesunderthewhee", "dx_cp_port_kwve_fara_ranthatonedown", "dx_cp_port_kwve_fara_theyneverthinktomove", "dx_cp_port_kwve_fara_thatseffective"];
    level.vo.var_7970c6c8b5335c7e = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_kwve_grav_goodattackfarah", "dx_cp_port_kwve_grav_goodkillkilo", "dx_cp_port_kwve_grav_thingodambeauty", "dx_cp_port_kwve_grav_goodtakedownkilo", "dx_cp_port_kwve_grav_sathimthefuckdown"];
    level.vo.var_2a1837b9b03013c7 = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_kwve_grav_annihilation", "dx_cp_port_kwve_grav_obliterated", "dx_cp_port_kwve_grav_senthimpackin", "dx_cp_port_kwve_grav_neutralized", "dx_cp_port_kwve_grav_vaporizinshitnowfara", "dx_cp_port_kwve_grav_thatsaconfirmederasu", "dx_cp_port_kwve_grav_vanquishingdudesfara", "dx_cp_port_kwve_grav_thatstermination", "dx_cp_port_kwve_grav_eradicated", "dx_cp_port_kwve_grav_burninshitdownkilo"];
    level.vo.var_cd5e3937f411d7fd = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_kwve_grav_downwaydown", "dx_cp_port_kwve_grav_directandtothepoint", "dx_cp_port_kwve_grav_solidshotsfarah", "dx_cp_port_kwve_grav_bodybagtime", "dx_cp_port_kwve_grav_konniexterminated", "dx_cp_port_kwve_grav_takinoutthetrashfara"];
    level.vo.var_9807944c04cac0a6 = create_deck(aliases, 1, 1, 1);
  }

  if(!flag("vo_objective_intro_done")) {
    return;
  }

  var_339f9993b57334a2 = (6471, -3899, 410);
  var_c1282cf6f5338d1 = 372;

  if(level.player function_da0fc97699b7c873("obj_board_ship") && isDefined(self.origin)) {
    if(distance2dsquared(level.player.origin, var_339f9993b57334a2) < var_c1282cf6f5338d1 * var_c1282cf6f5338d1 && distance2dsquared(self.origin, var_339f9993b57334a2) < var_c1282cf6f5338d1 * var_c1282cf6f5338d1) {
      return;
    }
  }

  if(level.player function_da0fc97699b7c873("obj_harbormaster_building")) {
    return;
  }

  if(level.var_6e6f83686e847254 > gettime()) {
    return;
  }

  kill_dist = distance(level.player.origin, self.origin);
  clean_kill = !function_1bb1470f934a81eb() && function_eac0cd99c9c6d8ee() != "spotted" && namespace_a0852b262a68d01::function_db1910344d3cdfa8(self.origin);
  munition = isDefined(attacker) && (is_equal(attacker.classname, "misc_turret") || is_equal(attacker.currentvisionset, "cruise_color_mp") || is_equal(attacker.currentkillstreakopvo, "assault_drone_use"));

  if(!munition && !is_equal(attacker, level.player) && !is_equal(attacker.owner, level.player)) {
    return;
  }

  if(munition && is_equal(attacker.currentvisionset, "cruise_color_mp")) {
    attacker.currentvisionset = "";
  }

  if(!munition && is_equal(attacker.owner, level.player)) {
    level.var_6e6f83686e847254 = gettime() + 12500;
    played = level.player say(level.vo.var_7970c6c8b5335c7e deck_draw(), 0, 1.5, 0, 1);
  } else if(munition || isDefined(attacker.currentmultikill) && attacker.currentmultikill >= 3) {
    level.var_6e6f83686e847254 = gettime() + 15000;
    played = level.graves say(level.vo.var_cd5e3937f411d7fd deck_draw(), 0, 1.5, 0, 1);
  } else if(istrue(level.player.var_acee42d23dd54f0f) || kill_dist > 3200) {
    if(percent_chance(35)) {
      return;
    }

    level.var_6e6f83686e847254 = gettime() + 12500;
    played = level.graves say(level.vo.var_2a1837b9b03013c7 deck_draw(), 0, 0.2, 0, 1);
  } else if(clean_kill && gettime() > level.vo.var_ed8c0f68867ab0ff + 5000) {
    level.var_6e6f83686e847254 = gettime() + 25000;
    played = level.graves say(level.vo.var_9807944c04cac0a6 deck_draw(), 0, 0.2, 0, 1);
  }

  if(isDefined(played) && !istrue(played)) {
    level.var_6e6f83686e847254 = 0;
  }
}

function function_a7c26196ab875253(params) {
  level.vo.var_28008ca0233c6e7d = default_to(level.vo.var_28008ca0233c6e7d, 0);

  if(level.vo.var_28008ca0233c6e7d > gettime()) {
    return;
  }

  if(!isDefined(level.vo.var_80df62a7b77c28ab)) {
    aliases = ["dx_cp_port_crve_fara_vehiclesdown", "dx_cp_port_crve_fara_vehicleneedsrepairs", "dx_cp_port_crve_fara_donewiththevehicle", "dx_cp_port_crve_fara_vehiclesdead"];
    level.vo.var_80df62a7b77c28ab = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_2221_fara_vehiclesdown", "dx_cp_port_2221_fara_vehicleneedsrepairs", "dx_cp_port_2221_fara_donewiththevehicle", "dx_cp_port_2221_fara_vehiclesdead"];
    level.vo.var_36b291550b0c7e04 = create_deck(aliases, 1, 1, 1);
  }

  if(!isDefined(params) || !isDefined(params.vehicle) || !isDefined(params.vehicle.health) || params.vehicle.health > params.vehicle.maxhealth * 0.8) {
    return;
  }

  sequence = [level.player, 0, function_cd70fbc5ff85bc7d(level.vo.var_36b291550b0c7e04, level.vo.var_80df62a7b77c28ab)];
  played = say_sequence(sequence, 0.25, 3, 0, 1.25);

  if(istrue(played)) {
    level.vo.var_28008ca0233c6e7d = gettime() + 17500;
  }
}

function function_cd3ddd11020f508e(params) {
  level.vo.var_aff9990bcf11e90a = default_to(level.vo.var_aff9990bcf11e90a, 0);

  if(level.vo.var_aff9990bcf11e90a > gettime()) {
    return;
  }

  if(!isDefined(level.vo.drive_vehicle)) {
    aliases = ["dx_cp_port_drve_fara_behindthewheel", "dx_cp_port_drve_fara_gettinginthedriverss", "dx_cp_port_drve_fara_hopethishandleswell", "dx_cp_port_drve_fara_letsride", "dx_cp_port_drve_fara_goingforadrive"];
    level.vo.drive_vehicle = create_deck(aliases, 1, 1, 1);
    aliases = ["dx_cp_port_2222_fara_behindthewheel", "dx_cp_port_2222_fara_gettinginthedriverss", "dx_cp_port_2222_fara_hopethishandleswell", "dx_cp_port_2222_fara_letsride", "dx_cp_port_2222_fara_goingforadrive"];
    level.vo.var_bcc3368bca278dad = create_deck(aliases, 1, 1, 1);
  }

  sequence = [level.player, 0, function_cd70fbc5ff85bc7d(level.vo.var_bcc3368bca278dad, level.vo.drive_vehicle)];
  played = say_sequence(sequence, 0.25, 3, 0, 1.25);

  if(istrue(played)) {
    level.vo.var_aff9990bcf11e90a = gettime() + 17500;
  }
}

function flag_any(var_b138dd7869070a36) {
  foreach(f in var_b138dd7869070a36) {
    if(flag(f)) {
      return true;
    }
  }

  return false;
}

function flag_all(var_b138dd7869070a36) {
  foreach(f in var_b138dd7869070a36) {
    if(!flag(f)) {
      return false;
    }
  }

  return true;
}

function function_84c515a79e4dbb5d(trigger_ent, notify_ent, endon_string, notify_string) {
  if(!isDefined(notify_string)) {
    notify_string = "player_trigger";
  }

  level endon("game_ended");
  trigger_ent = default_to(trigger_ent, self);
  notify_ent = default_to(notify_ent, self);

  if(isDefined(endon_string)) {
    notify_ent endon(endon_string);
    trigger_ent endon(endon_string);
  }

  while(true) {
    trigger_ent waittill("trigger", entity);

    if(isDefined(entity.vehicletype)) {
      vehicleoccupants = entity.occupants;
      var_95dfb4ea629973 = 0;

      if(!isDefined(vehicleoccupants)) {
        continue;
      }

      foreach(occupant in vehicleoccupants) {
        if(isPlayer(occupant)) {
          var_95dfb4ea629973 = 1;
          break;
        }
      }

      if(var_95dfb4ea629973) {
        break;
      }
    }

    if(!isPlayer(entity)) {
      continue;
    }

    if(!scripts\cp\utility\player::isreallyalive(entity)) {
      continue;
    }

    break;
  }

  notify_ent notify(notify_string, trigger_ent);
}

function function_8a4672f9cc98c67d() {
  return level.player namespace_e875ad14b292bd61::binoculars_isads();
}

function function_a7c8f01b64b95e8e() {
  return flag("ai_combat_active") || function_489a0835e10a9b55();
}

function function_92c06f383a5b0c34() {
  nearby_ai = getaiarrayinradius(level.player.origin, 1000, "axis");

  if(nearby_ai.size > 0 && (flag("ai_combat_active") || function_489a0835e10a9b55())) {
    return true;
  }

  return false;
}

function function_84d907e2af3c9eb4() {
  return !function_a7c8f01b64b95e8e();
}

function function_70386f0dbf01d6f4(combat, noncombat) {
  return function_a7c8f01b64b95e8e() ? combat : noncombat;
}

function function_cd70fbc5ff85bc7d(var_b3d9068a7f08a7d7, var_10ce425f218389f8) {
  return function_a7c8f01b64b95e8e() ? var_b3d9068a7f08a7d7 deck_draw() : var_10ce425f218389f8 deck_draw();
}

function function_cfa4b3e55017bda7(var_b3d9068a7f08a7d7, var_10ce425f218389f8) {
  return function_92c06f383a5b0c34() ? var_b3d9068a7f08a7d7 deck_draw() : var_10ce425f218389f8 deck_draw();
}

function return_false() {
  return false;
}

function return_true() {
  return true;
}

function function_f5568b526c931901(old) {
  return !old;
}