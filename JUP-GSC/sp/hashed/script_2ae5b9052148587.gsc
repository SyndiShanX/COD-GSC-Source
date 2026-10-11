/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2ae5b9052148587.gsc
************************************************/

#using script_102d83a437e2b29f;
#using script_3a8f9ace195c9da9;
#using script_3b0812a5fdfecf0;
#using script_48324b060b129b7b;
#using scripts\anim\dialogue;
#using scripts\anim\utility_common;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp\coop_stealth;
#using scripts\cp\munitions;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace namespace_7f4f66b90d3178e7;

function function_ffc7dd3a5adfd5cf() {
  if(isDefined(level.var_1b908bf18691b097) && isDefined(level.var_1b908bf18691b097.checkpoint)) {
    checkpoint = level.var_1b908bf18691b097.checkpoint;
  } else {
    checkpoint = 0;
  }

  if(checkpoint == 0) {
    thread vo_intro();
    thread vo_infil();
  }

  thread watch_for_jump();
  thread function_62cf2295b42a5159();
  thread function_5994eb14c59dd582();
  thread function_d2d87cd7d32a2066();
  thread function_c0791d4fbca710d0();
  thread function_4b0ccdf45b0a8702();
  thread function_5a8578b192c64d43();
  thread function_2f96fcbbfb50889d();
  level.var_5ef076251e7516c7 = 0;
}

function vo_intro() {
  level endon("vo_player_jumped");
  level endon("intro_skipped");
  utility::flag_wait("player_spawned_with_loadout");
  utility::flag_wait("flag_intro_start");
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  thread function_e075f6e48fa39b02(start_trigger);
  thread function_187f95119431e566(start_trigger);
  var_3e39fa78e1ffff69 = "dx_cp_cdam_dift_lasw_fourbombsplacedatstr";
  ghost_vo = ["dx_cp_cdam_dift_ghos_andawayforustolocate", "dx_cp_cdam_dift_ghos_wecanusethemtolocate", "dx_cp_cdam_dift_ghos_likelyprotectingthet", "dx_cp_cdam_dift_ghos_safeguardingthebombs"];
  var_f5f317da206b1b8c = create_deck(ghost_vo, 1, 1);
  var_28a4682f8a6dff07 = undefined;
  var_28a4682f8a6dff07 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f("dx_cp_cdam_dift_ghos_watcher1bravo7wereat", undefined, "vo_player_jumped");
  var_28a4682f8a6dff07 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f("dx_cp_cdam_dift_lasw_beadvisedkonniperson", undefined, "vo_player_jumped");
  var_28a4682f8a6dff07 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f("dx_cp_cdam_dift_soap_securityforthedemoli", undefined, "vo_player_jumped");

  if(level.player istouching(start_trigger) && istrue(var_28a4682f8a6dff07) && !flag("scan_speaking") && !level.player isinfreefall()) {
    level.player say_team(var_f5f317da206b1b8c deck_draw(), 0.4, 0.4, 0);
    level.player say_team("dx_cp_cdam_dift_lasw_affirmativefindthech", 0.4, 0.4, 0);
  }
}

function function_187f95119431e566(start_trigger) {
  level endon("scan_speaking");
  level endon("vo_player_jumped");
  utility::flag_wait("flag_dungeon_intro_complete");

  if(!isDefined(start_trigger)) {
    return;
  }

  said = undefined;

  if(!flag("intro_skipped")) {
    wait 3;
  } else {
    wait 1;
  }

  if(level.player istouching(start_trigger) && !flag("scan_speaking")) {
    said = level.player say_team("dx_cp_cdam_dift_soap_immovingonthereservo", 0.4, 0.4, 0);
  }

  if(level.player istouching(start_trigger) && istrue(said) && !flag("scan_speaking")) {
    level.player say_team("dx_cp_cdam_dift_ghos_samejohnny", 0.4, 1, 0);
  }
}

function function_e075f6e48fa39b02(start_trigger) {
  level endon("vo_player_jumped");
  utility::flag_wait("flag_dungeon_intro_complete");
  var_3a42ab791e961d6 = ["dx_cp_cdam_inna_lasw_07youhavepotentialta", "dx_cp_cdam_inna_lasw_07gettothebombsitesa", "dx_cp_cdam_inna_lasw_07moveonthebombsites", "dx_cp_cdam_inna_lasw_letsstepitupghostthe", "dx_cp_cdam_inna_lasw_wereliterallychasing", "dx_cp_cdam_inna_soap_breaksoverltletsgo", "dx_cp_cdam_inna_lasw_moveoutghostclockist", "dx_cp_cdam_inna_lasw_keeppushing07wemayru"];
  deck = create_deck(var_3a42ab791e961d6, 1, 1);
  thread function_1fe4d8b7c33c12b6(start_trigger);
  wait 60;
  i = 0;

  while(level.player istouching(start_trigger) && i < 8) {
    i++;
    wait 0.5;

    if(!level.player istouching(start_trigger)) {
      break;
    }

    if(isDefined(level.var_abcb2fbd2517634d)) {
      if(!time_has_passed(level.var_abcb2fbd2517634d, 10)) {
        continue;
      }
    }

    alias = deck deck_draw();
    level.player namespace_e36cb7ca6117d2cc::function_227d97458ce08880(alias);
    wait randomintrange(16, 20);
  }
}

function function_1fe4d8b7c33c12b6(start_trigger) {
  level endon("all_bombs_defused");
  var_3a42ab791e961d6 = ["dx_cp_cdam_inna_lasw_07gettothebombsitesa", "dx_cp_cdam_inna_lasw_07moveonthebombsites", "dx_cp_cdam_inna_lasw_letsstepitupghostthe", "dx_cp_cdam_inna_lasw_wereliterallychasing", "dx_cp_cdam_inna_soap_breaksoverltletsgo", "dx_cp_cdam_inna_lasw_keeppushing07wemayru"];
  deck = create_deck(var_3a42ab791e961d6, 1, 1);

  while(level.player istouching(start_trigger)) {
    waitframe();
  }

  while(!flag("flag_obj_all_bombs_defused")) {
    if(!function_1bb1470f934a81eb()) {
      wait randomintrange(40, 60);

      if(!function_1bb1470f934a81eb()) {
        level.player namespace_e36cb7ca6117d2cc::function_227d97458ce08880(deck deck_draw());
      }
    }

    wait 1;
  }
}

function vo_infil() {
  utility::flag_wait("player_spawned_with_loadout");
  utility::flag_wait("flag_intro_start");
  utility::flag_wait("flag_dungeon_intro_complete");
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(isDefined(level.var_1b908bf18691b097) && isDefined(level.var_1b908bf18691b097.checkpoint)) {
    checkpoint = level.var_1b908bf18691b097.checkpoint;
  } else {
    checkpoint = 0;
  }

  if(checkpoint > 0) {
    return;
  }

  var_d78ffd3825091641 = ["dx_cp_cdam_tdep_ghos_flyingin", "dx_cp_cdam_tdep_ghos_droppingin"];
  wait 1;
  var_2c871ca3d0eab792 = create_deck(var_d78ffd3825091641, 1, 1);
  level waittill("vo_player_jumped");

  while(level.player isinfreefall() && !level.player isparachuting()) {
    waitframe();
  }

  level.player say(var_2c871ca3d0eab792 deck_draw(), 0.3, 3);
  utility::flag_set("vo_infil_complete");
}

function watch_for_jump() {
  utility::flag_wait("flag_dungeon_intro_complete");
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  while(level.player istouching(start_trigger) && level.player.origin[2] > 2000) {
    waitframe();
  }

  level notify("vo_player_jumped");
}

function function_fabb9dbcf8f5583a() {
  var_7874ceb53bcb96e9 = getEntArray("dry", "script_noteworthy");

  foreach(slide in var_7874ceb53bcb96e9) {
    if(level.player istouching(slide)) {
      return true;
    }
  }

  return false;
}

function function_20ee27bc593b9233() {
  var_4ce32e2e6c936e4e = getEntArray("wet", "script_noteworthy");

  foreach(slide in var_4ce32e2e6c936e4e) {
    if(level.player istouching(slide)) {
      return true;
    }
  }

  return false;
}

function function_6b12ac7ec1c1c0b() {
  deathBy = namespace_96731f4d002634f6::function_69fa4a2561ada985("deathBy");
  vo = ["dx_cp_cdam_idbg_lasw_bravo7yourecleartone", "dx_cp_cdam_idbg_lasw_expectcontact07konni", "dx_cp_cdam_idbg_lasw_ifkonnirespondsisola", "dx_cp_cdam_idbg_lasw_letsmakeamovenow07", "dx_cp_cdam_idbg_lasw_watcherto07dowhateve", "dx_cp_cdam_dirs_lasw_07konnisoldiersaregu", "dx_cp_cdam_dirs_lasw_ghostiseekonnicircle", "dx_cp_cdam_dirs_lasw_07youneedtolocatethe", "dx_cp_cdam_dirs_lasw_locateandsecurethose", "dx_cp_cdam_dirs_lasw_locateanddisarmthebo", "dx_cp_cdam_dirs_lasw_findandsecureallbomb", "dx_cp_cdam_dirs_lasw_getthosebombsitessec"];

  if(isDefined(deathBy)) {
    switch (deathBy) {
      case #"hash_36b7174a04de8799":
        vo = ["dx_cp_cdam_idbc_lasw_konnishadsetuptimeex", "dx_cp_cdam_idbc_lasw_watchyourfootingbrav", "dx_cp_cdam_idbc_lasw_watchoutforclaymores", "dx_cp_cdam_idbc_lasw_intelsuggestsboobytr", "dx_cp_cdam_idbc_lasw_beadvisedintelshowsb"];
        break;
      case #"hash_6191aaef9f922f96":
        vo = ["dx_cp_cdam_idbr_lasw_snipersintheaowatchy", "dx_cp_cdam_idbr_lasw_beadvisedaoissniperr", "dx_cp_cdam_idbr_lasw_beadvisedkonnihassni", "dx_cp_cdam_idbr_lasw_intelhaspotentialsni"];
        break;
      case #"hash_d4850e4dfbc48417":
        vo = ["dx_cp_cdam_indt_lasw_beadvisedmultiplesen", "dx_cp_cdam_indt_lasw_ghostifyoufindasentr", "dx_cp_cdam_indt_lasw_konnimayhavedeployed", "dx_cp_cdam_indt_lasw_bravo7ifyouhackasent"];
        break;
    }
  }

  if(vo.size > 0) {
    level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, vo);
  }

  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  utility::flag_wait("flag_dungeon_intro_complete");
  thread function_e075f6e48fa39b02(start_trigger);
  thread vo_infil();
}

function function_62cf2295b42a5159() {
  thread function_6f84c9ce7d207be8();
  thread function_d7a7aedeaf26bf7d();
  thread function_f4f561d4265a2e7b();
  thread function_398a151fbe3e3697();
}

function function_4a6408d1cdb36e0c() {
  vo = ["dx_cp_cdam_dsix_ghos_helipadontheturbineb", "dx_cp_cdam_dsix_ghos_goteyesonapotentiale", "dx_cp_cdam_dsix_ghos_thatpadsagoodexit", "dx_cp_cdam_dsix_ghos_helipadsaprimeexfil", "dx_cp_cdam_dsix_ghos_thatpadwouldmakeagoo", "dx_cp_cdam_tsee_lasw_couldbekonnisexfilpo", "dx_cp_cdam_tsee_lasw_thathelipadmaybekonn", "dx_cp_cdam_tsee_lasw_goodeyekonnimayuseit"];
  utility::flag_wait("scan_helipad");
  level.player function_31fcf0528e5d8d3f([get_random_line(vo), "dx_cp_cdam_tsee_lasw_thatbuildinghousesth"]);
}

function function_6f84c9ce7d207be8() {
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  vo = ["dx_cp_cdam_dsii_ghos_eyesonasniper", "dx_cp_cdam_dsii_ghos_hellomate", "dx_cp_cdam_dsii_ghos_sniperonthenorthend", "dx_cp_cdam_dsii_ghos_hescoveringhislanebu", "dx_cp_cdam_dsii_ghos_enemysniper", "dx_cp_cdam_dsii_lasw_seeingkonnioverwatch", "dx_cp_cdam_dsii_lasw_visualonasniper", "dx_cp_cdam_dsii_lasw_gotanenemysnipernear", "dx_cp_cdam_dsii_lasw_spottedasniper07", "dx_cp_cdam_dsii_lasw_konnisniperthereghos", "dx_cp_cdam_dsii_lasw_beadvisedyougotasnip"];
  var_6cfa66cff72430ba = create_deck(vo, 1, 1);
  utility::flag_wait("scan_sniper");
  level notify("player_scanning");
  level.var_abcb2fbd2517634d = gettime();

  if(level.player istouching(start_trigger)) {
    level.player say_team(var_6cfa66cff72430ba deck_draw(), 0.4, 0.5, 0);
  }
}

function function_d7a7aedeaf26bf7d() {
  level endon("all_bombs_defused");
  vo = ["dx_cp_cdam_dsir_ghos_gotaturret", "dx_cp_cdam_dsir_ghos_turretuptop", "dx_cp_cdam_dsir_ghos_hostileturret", "dx_cp_cdam_dsir_ghos_enemyturret", "dx_cp_cdam_dsir_ghos_activeturret", "dx_cp_cdam_dsir_lasw_gotakonniturretsetup", "dx_cp_cdam_dsir_lasw_watchuptopseeingatur", "dx_cp_cdam_dsir_lasw_gotavisualonaturret", "dx_cp_cdam_dsir_lasw_enemyturretthereghos", "dx_cp_cdam_dsir_lasw_ghostactiveturretiny", "dx_cp_cdam_tuwa_lasw_watchtheturretsseeif"];
  var_f1e2e96171f07a1d = create_deck(vo, 1, 1);

  while(true) {
    utility::flag_wait("scan_turret");
    level.player namespace_e36cb7ca6117d2cc::function_227d97458ce08880(var_f1e2e96171f07a1d deck_draw());
    level.var_abcb2fbd2517634d = gettime();
    break;
  }
}

function function_40ee74e2f8d73c71() {
  level endon("all_bombs_defused");
  vo = ["dx_cp_cdam_dsip_ghos_activityonthewater", "dx_cp_cdam_dsip_ghos_patrolboats", "dx_cp_cdam_dsip_ghos_hostileboatsintheao", "dx_cp_cdam_dsip_ghos_zodiacspatrolling", "dx_cp_cdam_dsip_ghos_apairofzodiacs"];

  while(true) {
    utility::flag_wait("scan_water");
    level.player namespace_e36cb7ca6117d2cc::function_227d97458ce08880([get_random_line(vo), "dx_cp_cdam_tplr_lasw_konniforcesarecloset"]);
    break;
  }
}

function function_f4f561d4265a2e7b() {
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");
  aliases = ["dx_cp_cdam_tdst_ghos_lottakonniintheturbi", "dx_cp_cdam_tdst_ghos_theresactivitybythet", "dx_cp_cdam_tdst_ghos_konnisguardingabuild", "dx_cp_cdam_tdst_ghos_watchertheresactivit", "dx_cp_cdam_tdst_ghos_watchertheresactivit"];
  var_f5f317da206b1b8c = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_ttlr_lasw_thepowerhousegorastu";
  aliases[aliases.size] = "dx_cp_cdam_ttlr_lasw_thatsgoraspowerhouse";
  aliases[aliases.size] = "dx_cp_cdam_ttlr_lasw_07thatsthedamspowerh";
  aliases[aliases.size] = "dx_cp_cdam_ttlr_lasw_thatsthepowerhouseit";
  aliases[aliases.size] = "dx_cp_cdam_tsee_lasw_thatstheturbinebuild";
  response = create_deck(aliases, 1, 1);
  var_e4d502f3218bc1bc = "dx_cp_cdam_ttlr_soap_youcanbetyourarsetha";
  var_248a4992cd45d7d8 = undefined;
  utility::flag_wait("scan_turbine");

  if(flag("vo_powerhouse_scanned")) {
    return;
  }

  level.var_abcb2fbd2517634d = gettime();
  flag_set("scan_speaking");
  var_248a4992cd45d7d8 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(var_f5f317da206b1b8c deck_draw());
  flag_clear("scan_speaking");

  if(istrue(var_248a4992cd45d7d8) && !flag("scan_speaking")) {
    var_5468b51121fa491f = level.player say_team(response deck_draw(), 0.8, 0.4);
  }

  if(istrue(var_5468b51121fa491f) && !flag("scan_speaking")) {
    level.player say_team(var_e4d502f3218bc1bc, 0.8, 0.4);
  }

  if(istrue(var_248a4992cd45d7d8)) {
    utility::flag_set("vo_powerhouse_scanned");
  }
}

function function_f5610d3fe7a878d4() {
  vo = ["dx_cp_cdam_lila_lasw_thatsthebridgeifabom", "dx_cp_cdam_ausr_lasw_killingmillions", "dx_cp_cdam_awfg_ghos_goodcall"];
  utility::flag_wait("scan_basin");
  level.var_abcb2fbd2517634d = gettime();
  level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, vo);
}

function function_5438611515fae301() {
  vo = ["dx_cp_cdam_dsib_ghos_heavyactivityaroundt", "dx_cp_cdam_dsib_ghos_heavyactivityaroundt", "dx_cp_cdam_dsib_ghos_buildingsactiveproba", "dx_cp_cdam_dsib_ghos_buildingsactiveproba", "dx_cp_cdam_dsib_ghos_buildingsactiveproba"];
  var_f5f317da206b1b8c = create_deck(vo, 1, 1);
  utility::flag_wait("scan_bunker");
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  flag_set("scan_speaking");
  var_248a4992cd45d7d8 = undefined;

  if(!flag("vo_bunker_scanned")) {
    var_248a4992cd45d7d8 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(var_f5f317da206b1b8c deck_draw());
  }

  if(istrue(var_248a4992cd45d7d8)) {
    flag_set("vo_bunker_scanned");
  }

  level.var_abcb2fbd2517634d = gettime();
  flag_clear("scan_speaking");

  if(istrue(var_248a4992cd45d7d8) && !flag("scan_speaking")) {
    level.player say_team("dx_cp_cdam_asre_lasw_thatsthegatehousegor", 0.8, 0.4, 0);
  }
}

function function_e4aaefc47fd1b2e9() {
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_watcher1ivegotactivi";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_gotagroupofkonniatth";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_konnisatthebridgewat";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_theresakonnisquadatt";
  var_f5f317da206b1b8c = create_deck(aliases, 1, 1);
  utility::flag_wait("scan_bridge");
  var_248a4992cd45d7d8 = undefined;
  level.var_abcb2fbd2517634d = gettime();
  flag_set("scan_speaking");

  if(!flag("vo_bridge_scanned")) {
    var_248a4992cd45d7d8 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(var_f5f317da206b1b8c deck_draw());
  }

  if(istrue(var_248a4992cd45d7d8)) {
    flag_set("vo_bridge_scanned");
  }

  flag_clear("scan_speaking");

  if(istrue(var_248a4992cd45d7d8) && !flag("scan_speaking")) {
    level.player say_team("dx_cp_cdam_lila_lasw_thatsthebridgeifabom", 0.8, 0.5, 0);
  }
}

function function_4c599e4a22902ee1() {
  vo = [];
  utility::flag_wait("scan_catwalk");
  level.var_abcb2fbd2517634d = gettime();
  level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, vo);
}

function function_8387b0f4f7906acd() {
  utility::flag_wait("scan_bombsite");
  vo = ["dx_cp_cdam_tdst_lasw_konnisholdingpositio", "dx_cp_cdam_tdst_lasw_watchthatbuildingfor", "dx_cp_cdam_tdst_lasw_gotkonniposteduparou", "dx_cp_cdam_tdst_lasw_imseeingmovementnear", "dx_cp_cdam_tdst_lasw_visualonkonnimingled", "dx_cp_cdam_tdst_lasw_gotkonnistationedaro", "dx_cp_cdam_tdst_lasw_seeingthreatsallover"];
  vo_deck = create_deck(vo, 1, 1);

  if(!flag("vo_truck_scanned")) {
    level.player say_team(vo_deck deck_draw(), 0.8, 0.5, 0);
  }
}

function function_794027f4da86a997() {
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  vo = ["dx_cp_cdam_dsit_ghos_truckssuspicious"];
  var_f5f317da206b1b8c = create_deck(vo, 1, 1);
  var_e281f7f1380cd552 = ["dx_cp_cdam_dsit_lasw_konnicouldbetranspor", "dx_cp_cdam_dsit_lasw_copy07konnimaybetran"];
  var_dabbee033d7e5c88 = create_deck(var_e281f7f1380cd552, 1, 1);
  utility::flag_wait("obj_bomb_truck");
  flag_set("scan_speaking");
  var_248a4992cd45d7d8 = undefined;

  if(level.player istouching(start_trigger) && !flag("vo_truck_scanned")) {
    var_248a4992cd45d7d8 = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(var_f5f317da206b1b8c deck_draw());
  }

  flag_clear("scan_speaking");

  if(istrue(var_248a4992cd45d7d8) && !flag("scan_speaking")) {
    level.player say_team(var_dabbee033d7e5c88 deck_draw(), 0.8, 0.4);
  }

  level.var_abcb2fbd2517634d = gettime();

  if(istrue(var_248a4992cd45d7d8)) {
    flag_set("vo_truck_scanned");
  }
}

function function_398a151fbe3e3697() {
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  flag_wait_all("vo_bunker_scanned", "vo_powerhouse_scanned", "vo_bridge_scanned", "vo_truck_scanned");
  wait 2;

  if(flag("scan_speaking")) {
    flag_waitopen("scan_speaking");
  }

  if(level.player istouching(start_trigger)) {
    function_129359a1ad7c60b1(start_trigger);
  }
}

function function_79aadc7dcb65beb2() {
  vo = ["dx_cp_cdam_snwa_lasw_theywontspotyouifyou", "dx_cp_cdam_snwa_lasw_carefulghostiftheyge", "dx_cp_cdam_snwa_lasw_carefulghostiftheyge", "dx_cp_cdam_snwa_lasw_yourehiddenfornowbut", "dx_cp_cdam_snwa_lasw_youllbehardertodetec", "dx_cp_cdam_snwa_lasw_youcanmoveundetected"];

  while(!utility::flag("flag_obj_all_bombs_defused")) {
    if(level.player isswimming() && function_eac0cd99c9c6d8ee() == "hidden") {
      wait 5;
      level.player namespace_e36cb7ca6117d2cc::function_d6ae85f5832a5aec(1, vo);
      wait 60;
    }

    wait 1;
  }
}

function function_d2d87cd7d32a2066() {
  level endon("all_bombs_defused");
  vo = ["dx_cp_cdam_thft_ghos_hackingaturret", "dx_cp_cdam_tuhd_ghos_ivehackedthesentrygu", "dx_cp_cdam_tuhd_ghos_hackedthesentrygun", "dx_cp_cdam_tuhd_ghos_hackedthesentrygun_01", "dx_cp_cdam_tuhd_ghos_sentrygunhacked"];
  var_8afb860f544cfdc4 = create_deck(vo, 1, 1);

  while(!utility::flag("flag_obj_all_bombs_defused")) {
    level waittill("turret_hacked");
    level.player say_team(var_8afb860f544cfdc4 deck_draw(), 0.6, 2, 0);

    if(!istrue(level.var_330a234fb25b9286)) {
      thread function_7ca61a980f3e2d0c();
    }
  }
}

function function_7ca61a980f3e2d0c() {
  level endon("all_bombs_defused");
  vo = ["dx_cp_cdam_tuhd_ghos_tookcontrolofaturret", "dx_cp_cdam_tuhd_ghos_tookcontrolofaturret_01", "dx_cp_cdam_tuhd_ghos_sentrygunisminenow_01", "dx_cp_cdam_tuhd_ghos_sentrygunisminenow"];
  vo_deck = create_deck(vo, 1, 1);

  if(!utility::flag("flag_obj_all_bombs_defused")) {
    level.var_330a234fb25b9286 = 1;
    level waittill("turret_converted");
    level.player say_team(vo_deck deck_draw(), 0.6, 2, 0);
    level.var_330a234fb25b9286 = 0;
  }
}

function function_cc116388b57ace53(kill_dist, issniper) {
  flag_set("vo_in_kill");

  if(!isDefined(level.var_fbe41e2d7996c186)) {
    level.var_fbe41e2d7996c186 = -10001;
  }

  if(!isDefined(level.var_767c0b950a3af9ef) || !isDefined(level.var_2c669f2af3a03bb2)) {
    function_ea101df42d86cfe3();
  }

  if(!isDefined(level.var_cc6d379004bc5407)) {
    level.var_cc6d379004bc5407 = 0;
  }

  var_31f8b11328b07f8a = percent_chance(70);

  if(issniper) {
    var_31f8b11328b07f8a = 1;
  }

  if(isDefined(level.var_fbe41e2d7996c186) && (var_31f8b11328b07f8a || kill_dist > 300) && !function_e852b681bf0fbfc0()) {
    if(function_335daf3b15d106cd(5)) {
      alias = level.var_767c0b950a3af9ef deck_draw();

      if(issniper) {
        if(!level.var_cc6d379004bc5407) {
          alias = "dx_cp_cdam_wrng_lasw_sniperdown";
          level.var_cc6d379004bc5407 = 1;
        } else {
          level.var_cc6d379004bc5407 = 0;
        }
      }
    }
  }

  if(!isDefined(alias)) {
    alias = level.var_2c669f2af3a03bb2 deck_draw();
  }

  wait randomfloatrange(0.3, 1.2);
  var_715db78dca5b22bf = level.player say_team(alias, 0.2, 0.2, 0, 0.3);
  flag_clear("vo_in_kill");

  if(istrue(var_715db78dca5b22bf)) {
    level.var_5ef076251e7516c7 = 1;
    wait 7;
    level.var_5ef076251e7516c7 = 0;
  }
}

function function_ea101df42d86cfe3() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_cleanshot07";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_solidkill";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_07goodhit";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_enemydown";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_onelesskonniinthewor";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_threateliminated";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_hesdown";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_baggedemghost";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_targetdown";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_killconfirmed";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_yougotem";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_hesdone";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_cleankill";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_niceshot";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_nailedhim";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_putaforkinthatone";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_burnedem";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_smokedem";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_downillsendflowers";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_hammeredhim";
  aliases[aliases.size] = "dx_cp_cdam_wrng_lasw_senthisasspacking";
  level.var_767c0b950a3af9ef = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_eliminated";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_tookhimout";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_down";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_gothim";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_friedhim";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_hesagoner";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_terminated";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_annihilated";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_chalkedhim";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_hesout";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_ekia";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_hesnotgettingup";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_intothebloodyabyss";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_anotherhastydepartur";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_thatsacasualty";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_dead";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_earlydemise";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_slottedem";
  aliases[aliases.size] = "dx_cp_cdam_wrng_ghos_sortedthatone";
  level.var_2c669f2af3a03bb2 = create_deck(aliases, 1, 1);
}

function function_335daf3b15d106cd(cooldown) {
  cooldown = default_to(cooldown, 5);

  if(!isDefined(level.var_fbe41e2d7996c186)) {
    level.var_fbe41e2d7996c186 = -10001;
  }

  if(time_has_passed(level.var_fbe41e2d7996c186, cooldown)) {
    return true;
  }

  return false;
}

function function_a8cf239507277966(radius) {
  ai = coop_stealth::get_ai_within_range(level.player.origin, radius * radius, 12);

  foreach(bot in ai) {
    if(bot scripts\stealth\utility::function_6a86dd83c01f8faa()) {
      return true;
    }
  }

  return false;
}

function function_b040f21595f033c(origin, radius) {
  ai = get_ai_within_range(level.player.origin, radius * radius, 20);
  var_9cc05aa827880781 = 0;

  foreach(bot in ai) {
    state = bot.stealth_bsmstate;

    if(state > var_9cc05aa827880781) {
      var_9cc05aa827880781 = state;
    }
  }

  return var_9cc05aa827880781;
}

function function_86cf2e4b31d401() {
  level endon("flag_obj_all_bombs_defused");
  level endon("defend_transition_vo_started");
  flag_wait("flag_dungeon_intro_complete");
  level waittill("vo_player_jumped");
  worldstate = function_eac0cd99c9c6d8ee();

  if(!isDefined(level.var_145284b6f60e4958)) {
    function_a7228048f360bb32();
  }

  level.player namespace_d3c2a7ff4bcf34e0::function_8e12a06df7f7b5a6(worldstate, "flag_obj_all_bombs_defused", &function_16b772b16d97af4b, &function_e852b681bf0fbfc0, &function_497e0262cfd55c90);
}

function function_497e0262cfd55c90() {
  if(level.bombsdefused == 4) {
    return true;
  }

  return false;
}

function function_16b772b16d97af4b() {
  return sortbydistance(utility::getStructArray("obj_bomb_interact", "targetname"), level.player.origin)[0];
}

function function_54202f70c1d70acd() {
  while(true) {
    ai = scripts\common\ai::function_30dd4f3ef5f328ea(level.player.origin, "axis");
    iprintln(ai.stealth_bsmstate);
    wait 0.5;
  }
}

function function_e852b681bf0fbfc0() {
  var_321e1c7a71a8df9c = function_1c4d592029f2b0d3("reinf_trigger_bunker_left");
  var_3ba3e00c0a1a2ec9 = function_1c4d592029f2b0d3("reinf_trigger_bunker_right");
  var_78878c8491671509 = function_1c4d592029f2b0d3("powerplant_trigger");

  if(level.player istouching(var_321e1c7a71a8df9c) || level.player istouching(var_3ba3e00c0a1a2ec9) || level.player istouching(var_78878c8491671509)) {
    if(is_indoors(level.player)) {
      return true;
    }
  }

  return false;
}

function function_ab4a3f19d7a35700() {
  level notify("comm_loc_started");
  level endon("comm_loc_started");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_allunitshostilesight";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_allunitshostilesight_01";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_allunitshostilesight_02";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_allunitshostilesight_03";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_allunitshostilesight_04";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_allunitshostilesight_05";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_wegothimallunitsonmy";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_thereintheskullmask";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_iseehim";
  aliases[aliases.size] = "dx_cp_cdam_csko_kon1_thereshoottokill";
  catwalk = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("bomb_search_catwalk");
  bridge = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_water_left");
  helipad = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("roof_trigger");
  var_9f0359505632a7e4 = 505;
  var_321e1c7a71a8df9c = function_1c4d592029f2b0d3("reinf_trigger_bunker_left");
  var_3ba3e00c0a1a2ec9 = function_1c4d592029f2b0d3("reinf_trigger_bunker_right");
  truck = getEnt("obj_bomb_truck_model", "targetname");
  powerhouse = function_1c4d592029f2b0d3("powerplant_trigger");

  if(!isDefined(level.var_2d4829c0bf613c2f)) {
    level.var_2d4829c0bf613c2f = 0;
  }

  if(!isDefined(level.var_492f538bc0e0e84)) {
    level.var_492f538bc0e0e84 = "none";
  }

  if(!time_has_passed(level.var_2d4829c0bf613c2f, 15)) {
    return;
  }

  ai_array = array_removedead_or_dying(getaiarray("axis"));
  speaker = undefined;

  while(!isDefined(speaker)) {
    speaker = level.player namespace_a0852b262a68d01::function_d0b6fd4fc2332c8c(ai_array);
    waitframe();
  }

  alias = undefined;

  if(level.player istouching(catwalk)) {
    alias = aliases[0];
  } else if(level.player istouching(bridge)) {
    alias = aliases[1];
  } else if(level.player istouching(helipad)) {
    if(level.player.origin[2] > var_9f0359505632a7e4) {
      alias = aliases[2];
    }
  } else if((level.player istouching(var_321e1c7a71a8df9c) || level.player istouching(var_3ba3e00c0a1a2ec9)) && function_e852b681bf0fbfc0()) {
    alias = aliases[3];
  } else if(level.player istouching(powerhouse) && function_e852b681bf0fbfc0()) {
    alias = aliases[5];
  } else if(distancesquared(level.player.origin, truck.origin) < 160000) {
    alias = aliases[4];
  }

  speaker utility::set_battlechatter(0);

  if(isDefined(speaker) && isalive(speaker) && speaker scripts\stealth\utility::function_6a86dd83c01f8faa() && isDefined(alias) && alias != level.var_492f538bc0e0e84) {
    said = speaker say_self(alias, 0.2, 3, 0);
  }

  speaker utility::set_battlechatter(1);

  if(istrue(said)) {
    level.var_2d4829c0bf613c2f = gettime();
    level.var_492f538bc0e0e84 = alias;
  }
}

function function_a7228048f360bb32() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_theydontseeyoughosty";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_youreundetectedatthi";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_konniisunawareofyou";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_noenemyradiotrafficy";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_sofarsogood07";
  level.var_c7fdcd075be6fa67 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_carefulghostsomethin";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_somethingsgottheirat";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_konniactivityispicki";
  level.investigate_deck = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_ghostyouvebeenspotte";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_konnisreactingtheyre";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_konniknowsyoureinthe";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_ghostyoureexposedkon";
  level.var_f740dcfe6d515900 = create_deck(aliases, 1, 1);
  level.var_23d7b4931a9dd766 = create_deck(["dx_cp_cdam_wscr_ghos_watcheramiclear", "dx_cp_cdam_wscr_ghos_watchersitrep", "dx_cp_cdam_wscr_ghos_watcherwhatveyougot"], 1, 1);
  level.var_145284b6f60e4958 = create_deck(["dx_cp_cdam_wscr_lasw_07nomovementatthisti", "dx_cp_cdam_wscr_lasw_youreclear", "dx_cp_cdam_wscr_lasw_07youreclear"], 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_theyknowyourehere";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_hostilesincoming";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_ghostyourepositionis";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_ghosttheyremovingony";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_takethemoutfastorthe";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_eliminatethethreadbe";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_theyllalertthewholeb";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_fixthisfastoryourego";
  aliases[aliases.size] = "dx_cp_cdam_wscr_lasw_cleanthisupandmove";
  level.var_a9016d2b6b364c4d = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_snwa_lasw_usethewatertobreakco";
  aliases[aliases.size] = "dx_cp_cdam_snwa_lasw_youcanlosetheminthew";
  aliases[aliases.size] = "dx_cp_cdam_snwa_lasw_getcoverghostdiveund";
  aliases[aliases.size] = "dx_cp_cdam_snwa_lasw_gounderwaterghostbre";
  level.var_7467bfae31bc08ed = create_deck(aliases, 1, 1);
}

function function_537b15c65ccae79() {
  if(!isDefined(level.var_34b46fc829d2b7fb)) {
    level.var_34b46fc829d2b7fb = 0;
  }

  var_b5360561e71acedc = create_deck(["dx_cp_cdam_csup_lasw_enemyvehicle", "dx_cp_cdam_csup_lasw_07youvegotanenemyveh", "dx_cp_cdam_csup_lasw_ghostanenemyvehiclei"], 1, 1);
  wait 2;
  said = undefined;

  if(time_has_passed(level.var_34b46fc829d2b7fb, 5)) {
    said = level.player say_team(var_b5360561e71acedc deck_draw(), 0.4, 3, 0);
  }

  if(istrue(said)) {
    level.var_34b46fc829d2b7fb = gettime();
  }
}

function function_57a8fcb266b0f311() {
  if(!isDefined(level.var_34b46fc829d2b7fb)) {
    level.var_34b46fc829d2b7fb = 0;
  }

  vo = ["dx_cp_cdam_csup_lasw_07akonnihelosenterin", "dx_cp_cdam_csup_lasw_headsupghosttheresak", "dx_cp_cdam_csup_lasw_beadvised07youvegota", "dx_cp_cdam_csup_lasw_07enemyhelosareincom", "dx_cp_cdam_csup_lasw_ghostimpickingupmult", "dx_cp_cdam_csup_lasw_konnibirdsareincomin"];
  var_f951f5eed82d75e3 = create_deck(vo, 1, 1);
  wait 2;
  said = undefined;

  if(time_has_passed(level.var_34b46fc829d2b7fb, 5)) {
    said = level.player say_team(var_f951f5eed82d75e3 deck_draw(), 0.4, 3, 0);
  }

  if(istrue(said)) {
    level.var_34b46fc829d2b7fb = gettime();
  }
}

function function_694866c779854c31() {
  if(!isDefined(level.var_34b46fc829d2b7fb)) {
    level.var_34b46fc829d2b7fb = 0;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_theyrecallingreinfor";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_enemyreinforcementsi";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_konnireinforcementsa";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_ghosttheyresendingin";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_youvegotenemyreinfor";
  aliases[aliases.size] = "dx_cp_cdam_cose_lasw_enemyreinforcementsa";
  var_8071bf572b393d71 = create_deck(aliases, 1, 1);
  wait 2;
  said = undefined;

  if(time_has_passed(level.var_34b46fc829d2b7fb, 5)) {
    said = level.player say_team(var_8071bf572b393d71 deck_draw(), 0.4, 3, 0);
  }

  if(istrue(said)) {
    level.var_34b46fc829d2b7fb = gettime();
  }
}

function function_8115d486ae5ddaa() {
  if(!isDefined(level.var_34b46fc829d2b7fb)) {
    level.var_34b46fc829d2b7fb = 0;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_yougotparatroopersco";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_paratroopersincoming";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_ghostwatchtheskychut";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_theyredroppingparatr";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_ghostparatroopersare";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_eyeshighghostkonnire";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_konnideployedreinfor";
  aliases[aliases.size] = "dx_cp_cdam_csup_lasw_watchtheskieskonnire";
  var_8071bf572b393d71 = create_deck(aliases, 1, 1);
  wait 2;
  said = undefined;

  if(time_has_passed(level.var_34b46fc829d2b7fb, 5)) {
    said = level.player say_team(var_8071bf572b393d71 deck_draw(), 0.4, 3, 0);
  }

  if(istrue(said)) {
    level.var_34b46fc829d2b7fb = gettime();
  }
}

function function_de5f4de0c9d08181() {
  switch (level.bombsdefused) {
    case 0:
      return ["dx_cp_cdam_ags4_ghos_konnisengagingbombmu"];
    case 1:
      return ["dx_cp_cdam_ags4_ghos_morekonnibombcouldbe", "dx_cp_cdam_ags4_ghos_konnisonmebombcouldb", "dx_cp_cdam_ags4_ghos_konnisputtingupafigh", "dx_cp_cdam_ags4_ghos_konnisengagingbombmu", "dx_cp_cdam_ags4_ghos_konniwantstokeepmeat"];
    case 2:
      return ["dx_cp_cdam_ags4_ghos_morekonnibombcouldbe", "dx_cp_cdam_ags4_ghos_konnisonmebombcouldb", "dx_cp_cdam_ags4_ghos_konnisputtingupafigh", "dx_cp_cdam_ags4_ghos_konnisengagingbombmu", "dx_cp_cdam_ags4_ghos_konniwantstokeepmeat"];
    case 3:
      return ["dx_cp_cdam_ascl_ghos_wheresthatlastbloody"];
  }
}

function function_5e031a3b3360eba0() {
  switch (level.bombsdefused) {
    case 0:
      return ["dx_cp_cdam_aflr_lasw_yougottabecloseghost", "dx_cp_cdam_aflr_lasw_staymovingitsheresom", "dx_cp_cdam_aflr_lasw_eyesupghostyoullfind", "dx_cp_cdam_aflr_lasw_keepsearching"];
    case 1:
      return ["dx_cp_cdam_amlr_lasw_stayonthemoveitshere", "dx_cp_cdam_amlr_lasw_headonaswivelghost", "dx_cp_cdam_amlr_lasw_stayonitghost", "dx_cp_cdam_amlr_lasw_keeponthemoveyoullfi"];
    case 2:
      return ["dx_cp_cdam_aflr_lasw_eyesupghostyoullfind", "dx_cp_cdam_amlr_lasw_stayonitghost", "dx_cp_cdam_aflr_lasw_keepsearching", "dx_cp_cdam_amlr_lasw_keeponthemoveyoullfi"];
    case 3:
      return ["dx_cp_cdam_allr_lasw_konniwontmakeiteasyf", "dx_cp_cdam_allr_lasw_downtothewirelieuten", "dx_cp_cdam_allr_lasw_stayfocusedlieutenan", "dx_cp_cdam_allr_lasw_finditcomehome"];
  }
}

function function_95288fd44c37a365() {
  vo = ["dx_cp_cdam_lagr_lasw_copy", "dx_cp_cdam_lagr_lasw_copyghost", "dx_cp_cdam_lagr_lasw_copy07", "dx_cp_cdam_lagr_lasw_copythat", "dx_cp_cdam_lagr_lasw_solidcopy07", "dx_cp_cdam_lagr_lasw_goodcopyghost"];
  return get_random_line(vo);
}

function function_90a3dd0b61222a10() {
  level endon("all_bombs_defused");
  level endon("flag_bomb_truck_defused");
  areatrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("bomb_search_truck");

  if(!isDefined(areatrigger)) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_nearthetrucksearchin";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_nearthetrucksearchin";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_nearthetrucksearchin";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_nearthetrucksearchin";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_nearthetrucksearchin";
  var_7d6334f47018c181 = create_deck(aliases, 1, 1);
  var_402ee74db169656d = "";
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atsc_ghos_goingforthetruck";
  aliases[aliases.size] = "dx_cp_cdam_atsc_ghos_movingonthetruck";
  aliases[aliases.size] = "dx_cp_cdam_atsc_ghos_approachingthetruck";
  aliases[aliases.size] = "dx_cp_cdam_atsc_ghos_headingforthetruck";
  var_269b06ded808418e = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_watcher1konnisgroupi";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_konnispullingsecurit";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_gotagroupofkonnitoth";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_watcher1konnisguardi";
  aliases[aliases.size] = "dx_cp_cdam_atsi_ghos_visualonkonnieastsid";
  var_cc96b162713db78f = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_cdam_atsc_ghos_watcherkonnisguardin", "dx_cp_cdam_atsc_ghos_watchertakingfirenea", "dx_cp_cdam_atsc_ghos_contactkonnisnearatr"];
  var_e4105b148b8996e4 = create_deck(aliases, 1, 1);
  var_daad0549dd2f725c = ["dx_cp_cdam_atsr_soap_iftheyblowachargeont", "dx_cp_cdam_atsr_soap_konnistargetingthesu", "dx_cp_cdam_atsr_lasw_konnimaybetargetingt", "dx_cp_cdam_atsr_lasw_ifkonnistargetingthe"];
  var_6a811f61a136f24a = ["dx_cp_cdam_atsr_lasw_iftheyblowachargeont", "dx_cp_cdam_atsr_lasw_theyretargetingtheab", "dx_cp_cdam_atsr_lasw_theyretargetingthesu", "dx_cp_cdam_atsr_soap_theyretargetingthesu", "dx_cp_cdam_atsr_soap_theyllcollapsethedam"];
  response = create_deck(var_daad0549dd2f725c, 1, 1);
  var_3fc7ad0319613a84 = create_deck(var_6a811f61a136f24a, 1, 1);
  var_e24b4649d6c1e67a = ["dx_cp_cdam_atsr_lasw_konnimaybetransporti", "dx_cp_cdam_atsr_lasw_checkthattruckforexp"];
  var_9912ce8c185446c4 = ["dx_cp_cdam_atsr_lasw_ghostgettothattruckc", "dx_cp_cdam_atsr_lasw_ghosttheexplosivesco"];
  var_65da24fb338f1134 = create_deck(var_e24b4649d6c1e67a, 1, 1);
  var_d328c3b0eb48af62 = create_deck(var_9912ce8c185446c4, 1, 1);

  while(!level.player istouching(areatrigger)) {
    wait 0.5;
  }

  if(flag("soap_checkin_1_speaking")) {
    flag_waitopen("soap_checkin_1_speaking");
  }

  level notify("truck_circle_on");

  if(!flag("flag_bomb_truck_arrived")) {
    wait 0.5;
  }

  if(!isDefined(level.var_8c550b3ecc84a260) || !level.var_8c550b3ecc84a260 istouching(areatrigger)) {
    return;
  }

  if(flag("vo_truck_scanned")) {
    level.player function_31fcf0528e5d8d3f(var_7d6334f47018c181 deck_draw(), undefined, "truck_bomb_found", var_269b06ded808418e deck_draw());
  } else {
    level.player function_31fcf0528e5d8d3f(var_cc96b162713db78f deck_draw(), undefined, "truck_bomb_found", var_e4105b148b8996e4 deck_draw());
  }

  wait 0.8;

  if(!flag("truck_bomb_found")) {
    level.player function_227d97458ce08880(response deck_draw(), undefined, "truck_bomb_found", var_3fc7ad0319613a84 deck_draw());
  }

  wait 0.6;
  var_1ea6c853cec2f660 = undefined;

  if(function_1bb1470f934a81eb()) {
    var_1ea6c853cec2f660 = var_d328c3b0eb48af62 deck_draw();
  } else {
    var_1ea6c853cec2f660 = var_65da24fb338f1134 deck_draw();
  }

  if(isDefined(var_1ea6c853cec2f660) && !flag("truck_bomb_found")) {
    level.player say_team(var_1ea6c853cec2f660, 0.4, 0.5, 0);
  }
}

function function_8bb62aecfdc15fc8() {
  level endon("all_bombs_defused");
  var_93658337d29fb20f = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("bomb_search_water");
  var_d3cde2ce4f5af819 = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_water_right");
  var_7b419df2e6d3d2c = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_water_left");

  if(!isDefined(var_93658337d29fb20f) || !isDefined(var_d3cde2ce4f5af819) || !isDefined(var_7b419df2e6d3d2c)) {
    return;
  }

  var_6d76a2bed33771b2 = ["dx_cp_cdam_awsi_ghos_headingtothebridge", "dx_cp_cdam_awsi_ghos_movingonthebridge", "dx_cp_cdam_awsi_ghos_searchingthebridge", "dx_cp_cdam_awsi_ghos_goingforthebridge"];
  var_7d6334f47018c181 = create_deck(var_6d76a2bed33771b2, 1, 1);
  var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_awsc_ghos_atthebridge", "dx_cp_cdam_awsc_ghos_imatthebridge"];
  var_269b06ded808418e = create_deck(var_8c0dd9b91a21a1c9, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_07youreapproachingth";
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_ghostbeadvisedkonnii";
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_07youreclosingontheb";
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_gotkonniduginhardatt";
  var_e91ec8fe8cbec22b = create_deck(aliases, 1, 1);
  var_1850cf5943fcc496 = create_deck(["dx_cp_cdam_awsc_lasw_07konniisdefendingth", "dx_cp_cdam_awsc_lasw_ghostimseeingkonnion", "dx_cp_cdam_awsc_lasw_konnihasahardpointon"]);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_watcher1ivegotactivi";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_gotagroupofkonniatth";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_konnisguardingthebri";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_konnisatthebridgewat";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_theresakonnisquadatt";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_sentryturretonthebri";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_xraysonthebridge";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_konnisonthebridge";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_gotactivityonthebrid";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_gotgunnersonthebridg";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_seeingkonnipostedont";
  var_cc96b162713db78f = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_bridgecontrolsthewat";
  aliases[aliases.size] = "dx_cp_cdam_ausr_soap_hellfloodthewholecit";
  aliases[aliases.size] = "dx_cp_cdam_ausr_ghos_andkilleveryoneinit";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_thebridgecouldbeatar";
  var_5b9101c4c56231f = aliases;
  var_e4105b148b8996e4 = create_deck(["dx_cp_cdam_awsc_ghos_watcherimtakingfiref", "dx_cp_cdam_awsc_ghos_contactsouthkonnison", "dx_cp_cdam_awsc_ghos_imtakingfirefromtheb"]);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_07imseeingkonniactiv";
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_07beadvisedkonniisgu";
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_07checksouthyouhavek";
  aliases[aliases.size] = "dx_cp_cdam_awsi_lasw_ghostyouvegotkonnion";
  var_f32f130817a4c4f1 = create_deck(aliases, 1, 1);
  var_559d613a0e21aac = create_deck(["dx_cp_cdam_awsc_lasw_07konniistoyoursouth", "dx_cp_cdam_awsc_lasw_ghostchecksouthkonni", "dx_cp_cdam_awsc_lasw_watchsouthghostkonni"]);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_thebridgecouldbeatar_01";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_konnicouldbetargetin";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_ghostthatbridgemaybe";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_ghostkonnimaybetarge";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_searchforexplosivesn";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_07ifkonniistargeting";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_checkthebridgeforcha";
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_adviseyoucheckthewat";
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_theexplosivescouldbe";
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_konnimayhavesetthech";
  aliases[aliases.size] = "dx_cp_cdam_awsg_soap_checkunderthewaterlt";
  aliases[aliases.size] = "dx_cp_cdam_awsg_soap_checkbelowthesurface";
  aliases[aliases.size] = "dx_cp_cdam_awsg_soap_explosivescouldbeund";
  aliases[aliases.size] = "dx_cp_cdam_awsg_soap_bombcouldbeinthewate";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_ifthebridgeiscomprom";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_sweepforbombsnearthe";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_ghostconfirmifcharge";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_konnisguardingthebri";
  aliases[aliases.size] = "dx_cp_cdam_ausr_lasw_checkforexplosivesne";
  var_58a7506605c68323 = create_deck(aliases, 1, 1);
  var_4c65a04f058bdd78 = (-19702, 43823, -707);

  while(true) {
    if(distancesquared(level.player.origin, var_4c65a04f058bdd78) < 1440000) {
      break;
    }

    if(level.player istouching(var_d3cde2ce4f5af819) || level.player istouching(var_7b419df2e6d3d2c) || level.player isswimming() && level.player istouching(var_93658337d29fb20f)) {
      break;
    }

    wait 0.5;
  }

  level endon("flag_bomb_1_defused");

  if(flag("soap_checkin_1_speaking")) {
    flag_waitopen("soap_checkin_1_speaking");
  }

  level notify("bridge_circle_on");
  thread function_dfe0c631668e2e18();

  if(flag("vo_bridge_scanned")) {
    if(!level.player isswimming()) {
      level.player function_31fcf0528e5d8d3f(var_7d6334f47018c181 deck_draw(), undefined, "flag_bomb_1_defused", var_269b06ded808418e deck_draw());
    } else {
      level.player function_31fcf0528e5d8d3f(var_e91ec8fe8cbec22b deck_draw(), undefined, "flag_bomb_1_defused", var_1850cf5943fcc496 deck_draw());
    }
  } else if(!level.player isswimming()) {
    level.player function_31fcf0528e5d8d3f(var_cc96b162713db78f deck_draw(), undefined, "flag_bomb_1_defused", var_e4105b148b8996e4 deck_draw());
  } else {
    level.player function_31fcf0528e5d8d3f(var_f32f130817a4c4f1 deck_draw(), undefined, "flag_bomb_1_defused", var_559d613a0e21aac deck_draw());
  }

  wait 1;

  if(!flag("flag_bomb_1_defused")) {
    level.player function_227d97458ce08880(var_5b9101c4c56231f, undefined, "flag_bomb_1_defused", var_58a7506605c68323 deck_draw());
  }
}

function function_dfe0c631668e2e18() {
  level endon("bomb_1_defused");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_awsg_ghos_konnisettrapsunderth";
  aliases[aliases.size] = "dx_cp_cdam_awsg_ghos_theyvegottripminesun";
  aliases[aliases.size] = "dx_cp_cdam_awsg_ghos_tripminesareunderthe";
  aliases[aliases.size] = "dx_cp_cdam_awsi_ghos_gotadaisychainoc4her";
  var_1efd42c6fce5ec3e = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_youcantrydisablingth";
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_youcandisablethem";
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_ifyougetcloseyoucoul";
  aliases[aliases.size] = "dx_cp_cdam_awsg_lasw_trydisablingthem";
  var_ab4fff4193e0e629 = create_deck(aliases, 1, 1);
  var_5993636f597cc250 = getentitylessscriptablearray("bridge_c4", "targetname");
  var_f08b865ff4d2a43e = create_deck(["dx_cp_cdam_awsg_lasw_theyreguardingsometh", "dx_cp_cdam_awsg_lasw_defensesforthebombsi"], 1, 1);

  while(true) {
    if(level.player function_c4951a4784954657(var_5993636f597cc250)) {
      break;
    }

    wait 0.5;
  }

  if(level.player isswimunderwater()) {
    surfaced = function_9913ea09a554891a(10);
  }

  if(istrue(surfaced)) {
    said = level.player say(var_1efd42c6fce5ec3e deck_draw(), 0.8, 4);
  }

  if(istrue(said)) {
    level.player function_227d97458ce08880(var_f08b865ff4d2a43e deck_draw());
  }

  wait 5;
  level.player function_227d97458ce08880(var_ab4fff4193e0e629 deck_draw());
}

function function_9913ea09a554891a(timeout) {
  start_time = gettime();

  while(!time_has_passed(start_time, timeout)) {
    if(!level.player isswimunderwater()) {
      return true;
    }
  }

  return false;
}

function function_bcf5cbc27f24fada() {
  level endon("all_bombs_defused");
  areatrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("bomb_search_catwalk");

  if(!isDefined(areatrigger)) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_onthecatwalks";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_onthecatwalks";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_onthecatwalks";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_onthecatwalks";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_onthecatwalks";
  var_f11a96702b73d405 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_searchingcatwalkssou";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_checkingthecatwalkss";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_movingsouthtothecatw";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_sweepingsouthcheckin";
  aliases[aliases.size] = "dx_cp_cdam_acsi_ghos_onthecatwalkssouthsi";
  var_29de6fc3669f1c78 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_anexplosionherewould";
  aliases[aliases.size] = "dx_cp_cdam_acsr_soap_thatllcollapsethedam";
  aliases[aliases.size] = "dx_cp_cdam_acsr_ghos_wecantletthathappen";
  aliases[aliases.size] = "dx_cp_cdam_acsr_soap_letsstayonitlt";
  var_c6ea612904cb3c5e = aliases;
  var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_acsi_ghos_onthecatwalks", "dx_cp_cdam_acsc_ghos_movingonthecatwalks", "dx_cp_cdam_acsc_ghos_onthecatwalks", "dx_cp_cdam_acsc_ghos_atthecatwalks", "dx_cp_cdam_acsc_ghos_checkingthecatwalks", "dx_cp_cdam_acsc_ghos_searchingthecatwalks"];
  var_9b699f2618d550e2 = create_deck(var_8c0dd9b91a21a1c9, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_acsc_ghos_searchingcatwalkssou";
  aliases[aliases.size] = "dx_cp_cdam_acsc_ghos_checkingthecatwalkss";
  aliases[aliases.size] = "dx_cp_cdam_acsc_ghos_movingsouthtothecatw";
  aliases[aliases.size] = "dx_cp_cdam_acsc_ghos_sweepingsouthcheckin";
  aliases[aliases.size] = "dx_cp_cdam_acsc_ghos_onthecatwalkssouthsi";
  var_de3af9b01c0062a5 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_theyretargetingthepo";
  aliases[aliases.size] = "dx_cp_cdam_acsr_soap_theyllcollapsethedam";
  aliases[aliases.size] = "dx_cp_cdam_acsr_ghos_wecantletthathappen_01";
  var_21c6905c379e6231 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_findtheexplosivesont_01";
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_locatethoseexplosive_01";
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_securethecatwalks07_01";
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_findthechargesonthec";
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_securethecatwalks07";
  aliases[aliases.size] = "dx_cp_cdam_acsr_lasw_clearthecatwalksofor";
  var_53ef17a9ea5592fe = random(aliases);
  var_21c6905c379e6231 = array_add(var_21c6905c379e6231, var_53ef17a9ea5592fe);
  thread function_dfce875643a1c5e8();

  while(!level.player istouching(areatrigger)) {
    wait 0.1;
  }

  flag_set("vo_entered_catwalks");
  level notify("catwalk_circle_on");

  if(flag("vo_powerhouse_explored")) {
    level.player function_31fcf0528e5d8d3f(var_f11a96702b73d405 deck_draw(), undefined, undefined, var_9b699f2618d550e2 deck_draw());
    return;
  }

  level.player function_31fcf0528e5d8d3f(var_29de6fc3669f1c78 deck_draw(), undefined, undefined, var_de3af9b01c0062a5 deck_draw());

  if(!flag("catwalk_bomb_found")) {
    level.player function_31fcf0528e5d8d3f(var_c6ea612904cb3c5e, undefined, "catwalk_bomb_found", var_21c6905c379e6231);
  }
}

function function_dfce875643a1c5e8() {
  areatrigger = function_1c4d592029f2b0d3("defend_trigger");
  var_e68167bf22060f86 = function_1c4d592029f2b0d3("powerplant_trigger");
  hacktrigger = function_1c4d592029f2b0d3("hack_trigger");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_apsi_ghos_searchingnearthepowe";
  aliases[aliases.size] = "dx_cp_cdam_apsi_ghos_movingonthepowerhous";
  aliases[aliases.size] = "dx_cp_cdam_apsi_ghos_checkingnearthepower";
  aliases[aliases.size] = "dx_cp_cdam_apsi_ghos_imnearthepowerhouse";
  aliases[aliases.size] = "dx_cp_cdam_apsi_ghos_atthepowerhouse";
  var_28140b008f4bd149 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_searchingnearthepowe";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_movingonthepowerhous";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_checkingnearthepower";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_imnearthepowerhouse";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_atthepowerhouse";
  var_72070cd871d47e5b = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_cdam_apsi_ghos_watcher1konnisguardi", "dx_cp_cdam_apsi_ghos_watcher1spottedkonni", "dx_cp_cdam_apsi_ghos_watchergotkonnineara"];
  var_a1128ce60d479d18 = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_cdam_acsr_lasw_locatethoseexplosive"];
  var_1bbdfd3f815539be = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_cdam_apsc_ghos_watcher1konnisguardi", "dx_cp_cdam_apsc_ghos_watcher1spottedkonni", "dx_cp_cdam_apsc_ghos_watchergotkonnineara"];
  var_7db9800745b9b95e = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_cdam_acsr_lasw_findthosechargesghos"];
  var_fc8531fee0770c0 = create_deck(aliases, 1, 1);

  while(!level.player istouching(areatrigger)) {
    wait 0.5;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_07illhavenovisualwhi";
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_07beadvisedivelostvi";
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_icantseethroughwalls";
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_careful07icantseewhi";
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_copyillwatchtheoutsi";
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_rogerthativegoteyeso";
  aliases[aliases.size] = "dx_cp_cdam_absi_lasw_stayoncommsforenemya";
  var_befbf7e5cd065186 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_07ihavenovisualonyou";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_07beadvisedivelostvi";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_icantseethroughwalls";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_careful07icantseewhi";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_stayoncommsforenemya";
  var_f821f553847501b8 = create_deck(aliases, 1, 1);

  if(flag("vo_powerhouse_scanned")) {
    level.player function_227d97458ce08880(var_28140b008f4bd149 deck_draw(), undefined, undefined, var_72070cd871d47e5b deck_draw());
  } else {
    level.player function_227d97458ce08880(var_a1128ce60d479d18 deck_draw(), undefined, undefined, var_7db9800745b9b95e deck_draw());
    level.player function_227d97458ce08880(var_1bbdfd3f815539be deck_draw(), undefined, undefined, var_fc8531fee0770c0 deck_draw());
  }

  while(!(level.player istouching(var_e68167bf22060f86) && function_e852b681bf0fbfc0())) {
    wait 0.5;
  }

  flag_set("vo_powerhouse_explored");

  if(!level.player istouching(hacktrigger)) {
    level.player function_227d97458ce08880(var_befbf7e5cd065186 deck_draw(), undefined, undefined, var_f821f553847501b8 deck_draw());
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_apsn_ghos_powerhouselooksclear";
  aliases[aliases.size] = "dx_cp_cdam_apsn_ghos_negativeontheexplosi";
  aliases[aliases.size] = "dx_cp_cdam_apsn_ghos_explosivesarentinthe";
  aliases[aliases.size] = "dx_cp_cdam_apsn_ghos_watcherdryholepowerh";
  var_551690fe0f910d98 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_apsn_ghos_negativeontheexplosi";
  aliases[aliases.size] = "dx_cp_cdam_apsn_ghos_explosivesarentinthe";
  var_eada51ae7894c8c = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_powerhouseisclear";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_negativeontheexplosi";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_noexplosivesinthepow";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_explosivesarentinher";
  aliases[aliases.size] = "dx_cp_cdam_apsc_ghos_dryholepowerhouseisc";
  var_6dea4e81ab7b71de = create_deck(aliases, 1, 1);
  var_2b0447a43b1d613f = (-24103.9, 43055.6, 12.7);
  room_origin = (-24333.1, 43626.4, -109.437);
  var_63847449ce16c055 = (-247709, 43443.7, -100);
  var_b9c652641bab3648 = (-24925.1, 43294.4, 103.553);

  while(true) {
    if(level.player function_c4951a4784954657([var_63847449ce16c055, room_origin]) || level.player istouching(hacktrigger)) {
      break;
    }

    wait 0.5;
  }

  if(function_9b2709ace834bb83(var_e68167bf22060f86) && !function_1bb1470f934a81eb()) {
    level.player function_227d97458ce08880(var_eada51ae7894c8c deck_draw(), undefined, undefined, var_6dea4e81ab7b71de deck_draw());
  } else {
    level.player function_227d97458ce08880(var_551690fe0f910d98 deck_draw(), undefined, undefined, var_6dea4e81ab7b71de deck_draw());
  }

  if(flag("flag_bomb_2_defused")) {
    return;
  }

  wait 4;
  var_9f68130479f3415 = create_deck(["dx_cp_cdam_apsw_lasw_07impickingupactivit", "dx_cp_cdam_apsw_lasw_07theresmovementonth", "dx_cp_cdam_apsw_lasw_07checksouthimpickin"]);
  var_f8ad4dec70f0c06f = create_deck(["dx_cp_cdam_apsw_lasw_07checkthecatwalksso", "dx_cp_cdam_apsw_lasw_07konniisguardingthe", "dx_cp_cdam_apsw_lasw_07checksouththeresmo"]);

  while(function_1bb1470f934a81eb()) {
    wait 0.5;
  }

  wait 5;

  if(level.player istouching(areatrigger) && !flag("vo_entered_catwalks")) {
    level.player function_227d97458ce08880(var_9f68130479f3415 deck_draw(), undefined, undefined, var_f8ad4dec70f0c06f deck_draw());
  }
}

function function_9b2709ace834bb83(trigger, var_3c37abdd6853bbc0) {
  var_3c37abdd6853bbc0 = default_to(var_3c37abdd6853bbc0, 0);

  foreach(ai in getaiarray("axis")) {
    if(ai istouching(trigger)) {
      if(var_3c37abdd6853bbc0) {
        if(is_indoors(ai)) {
          return true;
        }

        continue;
      }

      return true;
    }
  }

  return false;
}

function function_ff9e90e6a299a1ff() {
  foreach(ai in getaiarray("axis")) {
    if(scripts\anim\utility_common::player_can_see_ai(self, ai)) {
      return true;
    }
  }

  return false;
}

function function_c4951a4784954657(targets, fov) {
  foreach(target in targets) {
    if(isent(target)) {
      if(scripts\engine\trace::can_see_origin(target.origin)) {
        return true;
      }

      continue;
    }

    if(isvector(target)) {
      if(scripts\engine\trace::can_see_origin(target)) {
        return true;
      }

      continue;
    }

    if(isDefined(target.origin)) {
      if(scripts\engine\trace::can_see_origin(target.origin)) {
        return true;
      }
    }
  }

  return false;
}

function function_f7f64fe0002567ac(targets, radius) {
  foreach(target in targets) {
    if(isent(target)) {
      target = target.origin;
    }
  }
}

function function_65841865d493fc29() {
  level endon("all_bombs_defused");
  areatrigger = function_1c4d592029f2b0d3("bomb_search_dam");
  var_110d68e32a148ac = function_1c4d592029f2b0d3("reinf_trigger_bunker_left");
  var_6ecc57b48dd04299 = function_1c4d592029f2b0d3("reinf_trigger_bunker_right");
  var_5ac36d58ff4ac522 = [var_110d68e32a148ac, var_6ecc57b48dd04299];

  if(!isDefined(areatrigger) || !isDefined(var_110d68e32a148ac) || !isDefined(var_6ecc57b48dd04299)) {
    return;
  }

  var_d3ff5ca4726747ef = [];
  var_d3ff5ca4726747ef[var_d3ff5ca4726747ef.size] = "dx_cp_cdam_atid_ghos_approachingthegateho";
  var_d3ff5ca4726747ef[var_d3ff5ca4726747ef.size] = "dx_cp_cdam_atid_ghos_workingmywaytothegat";
  var_d3ff5ca4726747ef[var_d3ff5ca4726747ef.size] = "dx_cp_cdam_atid_ghos_workingmywaytothegat";
  var_d3ff5ca4726747ef[var_d3ff5ca4726747ef.size] = "dx_cp_cdam_atid_ghos_workingmywaytothegat";
  var_d3ff5ca4726747ef[var_d3ff5ca4726747ef.size] = "dx_cp_cdam_atid_ghos_headingtothegatehous";
  var_be3f029fcd93c218 = create_deck(var_d3ff5ca4726747ef, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atco_ghos_approachingthegateho";
  aliases[aliases.size] = "dx_cp_cdam_atco_ghos_movingonthegatehouse";
  aliases[aliases.size] = "dx_cp_cdam_atco_ghos_checkingthegatehouse";
  aliases[aliases.size] = "dx_cp_cdam_atco_ghos_movingtothegatehouse";
  aliases[aliases.size] = "dx_cp_cdam_atco_ghos_headingtothegatehous";
  var_269b06ded808418e = create_deck(aliases, 1, 1);
  var_1ef33d59a230c5db = [];
  var_1ef33d59a230c5db[var_1ef33d59a230c5db.size] = "dx_cp_cdam_atid_lasw_07youreapproachingth";
  var_1ef33d59a230c5db[var_1ef33d59a230c5db.size] = "dx_cp_cdam_atid_lasw_seeingheavyactivitya";
  var_1ef33d59a230c5db[var_1ef33d59a230c5db.size] = "dx_cp_cdam_atid_lasw_headsupghostgotagrou";
  var_1ef33d59a230c5db[var_1ef33d59a230c5db.size] = "dx_cp_cdam_atid_lasw_konnisgroupingnearth";
  var_1ef33d59a230c5db[var_1ef33d59a230c5db.size] = "dx_cp_cdam_atid_lasw_watchoutghostkonniso";
  var_1ef33d59a230c5db[var_1ef33d59a230c5db.size] = "dx_cp_cdam_atid_lasw_eyesonkonnisneartheb";
  var_4b941a9d9ae92825 = create_deck(var_1ef33d59a230c5db, 1, 1);
  var_a4a5e39d72bdd5e1 = create_deck(["dx_cp_cdam_atco_lasw_07youreapproachingth", "dx_cp_cdam_atco_lasw_07konniismaneuvering", "dx_cp_cdam_atco_lasw_ghostcheckwestkonnii"], 1, 1);
  var_64fee4c92ce208fa = [];
  var_64fee4c92ce208fa[var_64fee4c92ce208fa.size] = "dx_cp_cdam_atid_ghos_watcherkonniisguardi";
  var_64fee4c92ce208fa[var_64fee4c92ce208fa.size] = "dx_cp_cdam_atid_ghos_visualonkonniattheba";
  var_64fee4c92ce208fa[var_64fee4c92ce208fa.size] = "dx_cp_cdam_atid_ghos_konniiswestofmylocat";
  var_d9b2a19975efbb7f = create_deck(var_64fee4c92ce208fa, 1, 1);
  var_b1704e66b4948627 = create_deck(["dx_cp_cdam_atco_ghos_watcherkonnisattheba", "dx_cp_cdam_atco_ghos_konnisguardingabuild", "dx_cp_cdam_atco_ghos_visualonkonnibaseoft"], 1, 1);
  var_f4218b7b58d9c1df = [];
  var_f4218b7b58d9c1df[var_f4218b7b58d9c1df.size] = "dx_cp_cdam_atid_lasw_07youvegotkonniwesto";
  var_f4218b7b58d9c1df[var_f4218b7b58d9c1df.size] = "dx_cp_cdam_atid_lasw_07impickingupkonniac";
  var_f4218b7b58d9c1df[var_f4218b7b58d9c1df.size] = "dx_cp_cdam_atid_lasw_07beadvisedkonniisgu";
  var_99495bf5e5b91dba = create_deck(var_f4218b7b58d9c1df, 1, 1);
  var_99ca138c17092324 = create_deck(["dx_cp_cdam_atco_lasw_07konniiswestofyourl", "dx_cp_cdam_atco_lasw_07konnisatthegatehou", "dx_cp_cdam_atco_lasw_07konniisguardingthe"], 1, 1);
  var_6d76a2bed33771b2 = [];
  var_6d76a2bed33771b2[var_6d76a2bed33771b2.size] = "dx_cp_cdam_absi_ghos_searchingthegatehous";
  var_6d76a2bed33771b2[var_6d76a2bed33771b2.size] = "dx_cp_cdam_absi_ghos_sweepingthroughthega";
  var_6d76a2bed33771b2[var_6d76a2bed33771b2.size] = "dx_cp_cdam_absi_ghos_movingintothegatehou";
  var_6d76a2bed33771b2[var_6d76a2bed33771b2.size] = "dx_cp_cdam_absi_ghos_checkingthegatehouse";
  var_6d76a2bed33771b2[var_6d76a2bed33771b2.size] = "dx_cp_cdam_absi_ghos_checkingthegatehouse";
  var_fdd7627901170a4e = create_deck(var_6d76a2bed33771b2, 1, 1);
  var_1d7f416b7f28739e = [];
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_07illhavenovisualwhi";
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_07beadvisedivelostvi";
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_icantseethroughwalls";
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_careful07icantseewhi";
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_copyillwatchtheoutsi";
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_rogerthativegoteyeso";
  var_1d7f416b7f28739e[var_1d7f416b7f28739e.size] = "dx_cp_cdam_absi_lasw_stayoncommsforenemya";
  var_cf986d1c416c0170 = create_deck(var_1d7f416b7f28739e, 1, 1);
  var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_atco_ghos_contactabombmustbecl", "dx_cp_cdam_atco_ghos_lottakonniatthebunke", "dx_cp_cdam_atco_ghos_searchingnearthebunk", "dx_cp_cdam_atco_ghos_havingalookaroundthe", "dx_cp_cdam_atco_ghos_enteringthegatehouse"];
  var_351727713b49c0d3 = create_deck(var_8c0dd9b91a21a1c9, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_07beadvisedivelostvi";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_07ihavenovisualonyou";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_careful07icantseewhi";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_copyillwatchtheoutsi";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_icantseethroughwalls";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_rogerthativegoteyeso";
  aliases[aliases.size] = "dx_cp_cdam_atco_lasw_stayoncommsforenemya";
  var_5b3b3d4bd70068e3 = create_deck(aliases, 1, 1);
  var_5f0f16b505ab547a = 0;
  function_9c254963e6893bb(var_be3f029fcd93c218, var_269b06ded808418e, var_d9b2a19975efbb7f, var_b1704e66b4948627, var_4b941a9d9ae92825, var_a4a5e39d72bdd5e1, var_99495bf5e5b91dba, var_99ca138c17092324);
  function_a9419fdf6de00a17(var_fdd7627901170a4e, var_cf986d1c416c0170, var_351727713b49c0d3, var_5b3b3d4bd70068e3);
}

function function_9c254963e6893bb(var_be3f029fcd93c218, var_269b06ded808418e, var_d6c1cd0373c42dd5, var_1430ae22627733b1, var_e950aa20f6273b70, var_4cd2a22a876c42da, var_308dbf3ebcc09c73, var_c30364c19789d6fc) {
  if(utility::flag("bunker_bomb_found")) {
    return;
  }

  level endon("bunker_bomb_found");
  areatrigger = function_1c4d592029f2b0d3("bomb_search_dam");
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_eyeson";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_visual";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_rogeyeson";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_copygotavisual";
  var_202d57eef4169bc6 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_iseeem";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_eyeson";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_visual";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_copyiseeem";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_rogeyeson";
  aliases[aliases.size] = "dx_cp_cdam_atid_lasw_copygotavisual";
  var_6ce1762960c565c9 = create_deck(aliases, 1, 1);

  while(true) {
    if(level.player istouching(areatrigger)) {
      break;
    }

    wait 0.5;
  }

  level endon("flag_bomb_3_defused");

  if(flag("soap_checkin_1_speaking")) {
    flag_waitopen("soap_checkin_1_speaking");
  }

  level notify("bunker_circle_on");

  if(flag("vo_bunker_scanned")) {
    if(level.player isswimming() && isDefined(var_e950aa20f6273b70)) {
      alias = var_e950aa20f6273b70 deck_draw();
    } else if(function_1bb1470f934a81eb()) {
      alias = var_269b06ded808418e deck_draw();
    } else {
      alias = var_be3f029fcd93c218 deck_draw();
    }

    level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f([alias, var_202d57eef4169bc6 deck_draw()]);
    return;
  }

  if(level.player isswimming() && isDefined(var_308dbf3ebcc09c73)) {
    alias = var_308dbf3ebcc09c73 deck_draw();
  } else if(function_1bb1470f934a81eb()) {
    alias = var_1430ae22627733b1 deck_draw();
  } else {
    alias = var_d6c1cd0373c42dd5 deck_draw();
  }

  level.var_f066b789844b533d = level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f([alias, var_6ce1762960c565c9 deck_draw()]);
}

function function_a9419fdf6de00a17(enter, response, var_351727713b49c0d3, var_3fc7ad0319613a84) {
  if(utility::flag("bunker_bomb_found")) {
    return;
  }

  level endon("bunker_bomb_found");
  var_110d68e32a148ac = function_1c4d592029f2b0d3("reinf_trigger_bunker_left");
  var_6ecc57b48dd04299 = function_1c4d592029f2b0d3("reinf_trigger_bunker_right");

  while(true) {
    if(level.player istouching(var_110d68e32a148ac) || level.player istouching(var_6ecc57b48dd04299)) {
      break;
    }

    wait 0.5;
  }

  if(flag("soap_checkin_1_speaking")) {
    flag_waitopen("soap_checkin_1_speaking");
  }

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    alias = var_351727713b49c0d3 deck_draw();
    response = var_3fc7ad0319613a84 deck_draw();
  } else {
    alias = enter deck_draw();
    response = response deck_draw();
  }

  if(istrue(level.var_f066b789844b533d) || flag("vo_bunker_scouted")) {
    level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f([alias, response]);
  }
}

function function_2f6c6ed8cf9a2038() {
  function_19b7d9600018ae70(1);
}

function function_1384390d0791f3aa() {
  function_19b7d9600018ae70(2);
}

function function_5cd1cc2cfe5c1858() {
  function_19b7d9600018ae70(3);
}

function function_884156c6f254680() {
  function_19b7d9600018ae70(0);
}

function function_19b7d9600018ae70(num) {
  var_6d76a2bed33771b2 = [];
  var_8c0dd9b91a21a1c9 = [];

  switch (num) {
    case 1:
      var_6d76a2bed33771b2 = ["dx_cp_cdam_awfi_ghos_visualonthebombitsun", "dx_cp_cdam_awfi_ghos_foundthebombitsunder", "dx_cp_cdam_awfi_ghos_allstationsexplosive", "dx_cp_cdam_awfg_ghos_bombsinthewater", "dx_cp_cdam_awfg_ghos_explosivesareunderth", "dx_cp_cdam_awfg_ghos_explosivesareunderwa"];
      var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_aufo_ghos_bombsunderwater", "dx_cp_cdam_aufo_ghos_itsunderwater"];
      utility::flag_set("water_bomb_found");
      utility::flag_set("vo_bridge_scanned");
      break;
    case 2:
      var_6d76a2bed33771b2 = ["dx_cp_cdam_acfi_ghos_watchertheresabombon", "dx_cp_cdam_acfi_ghos_watcherkonnisetachar", "dx_cp_cdam_acfi_ghos_watchercatwalksrigge"];
      var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_acfc_ghos_explosivesareontheca", "dx_cp_cdam_acfc_ghos_bombsonthecatwalk", "dx_cp_cdam_acfc_ghos_theresachargeontheca", "dx_cp_cdam_acfc_ghos_theyriggedthecatwalk", "dx_cp_cdam_acfc_ghos_thecatwalksrigged"];
      utility::flag_set("catwalk_bomb_found");
      break;
    case 3:
      var_6d76a2bed33771b2 = ["dx_cp_cdam_atfi_ghos_eyesonanexplosiveint", "dx_cp_cdam_atfi_ghos_foundthebombrightnex", "dx_cp_cdam_atfi_ghos_ihavevisualonanexplo", "dx_cp_cdam_atfi_ghos_ivegoteyesonthebunke", "dx_cp_cdam_atfi_ghos_jackpotfoundthebomb"];
      var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_atfz_ghos_foundthebomb", "dx_cp_cdam_atfz_ghos_bombshere", "dx_cp_cdam_atfz_ghos_gottothebomb", "dx_cp_cdam_atfz_ghos_bunkerbomb", "dx_cp_cdam_atfz_ghos_eyesonbunkerbomb"];
      utility::flag_set("bunker_bomb_found");
      utility::flag_set("vo_bunker_scanned");
      break;
    case 0:
      var_6d76a2bed33771b2 = ["dx_cp_cdam_afig_ghos_bombsinthebackofthat", "dx_cp_cdam_afig_ghos_foundabombinthetruck", "dx_cp_cdam_afig_ghos_contactfoundabombint", "dx_cp_cdam_afig_ghos_confirmedbombsinthet", "dx_cp_cdam_afig_ghos_truckscarryingabomb"];
      var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_atfc_ghos_bombsinthefuckingboo", "dx_cp_cdam_atfc_ghos_foundtheexplosive", "dx_cp_cdam_atfc_ghos_haveeyesonthetruckbo", "dx_cp_cdam_atfc_ghos_bombsinthefuckingtru", "dx_cp_cdam_atfc_ghos_bombsinthetruck"];
      utility::flag_set("truck_bomb_found");
      utility::flag_set("vo_truck_scanned");
      break;
  }

  var_3e6586f255dc93ff = ["dx_cp_cdam_gflr_lasw_goodgetthatordnanceo", "dx_cp_cdam_gflr_lasw_goodworkdisarmitandm", "dx_cp_cdam_gflr_lasw_hurryanddisarmkonnis", "dx_cp_cdam_gflr_lasw_goodeyedisarmitbefor", "dx_cp_cdam_gflr_lasw_disarmitandclearthea", "dx_cp_cdam_atfr_lasw_copydefusewhenable", "dx_cp_cdam_atfr_lasw_copygetitdefused"];
  var_1ffae88bff4bff92 = ["dx_cp_cdam_gflr_lasw_goodgetthatordnanceo", "dx_cp_cdam_gflr_lasw_goodworkdisarmitandm", "dx_cp_cdam_gflr_lasw_hurryanddisarmkonnis", "dx_cp_cdam_gflr_lasw_goodeyedisarmitbefor", "dx_cp_cdam_gflr_lasw_disarmitandclearthea", "dx_cp_cdam_atfr_lasw_copydefusewhenable", "dx_cp_cdam_atfr_lasw_copygetitdefused"];

  if(var_6d76a2bed33771b2.size > 0) {
    while(level.player isswimunderwater()) {
      waitframe();
    }

    if(flag("flag_bomb_" + num + "_defused")) {
      return;
    }

    var_59c8e8e7a767bdae = get_random_line(var_6d76a2bed33771b2);

    if(function_eac0cd99c9c6d8ee() == "spotted") {
      var_59c8e8e7a767bdae = get_random_line(var_8c0dd9b91a21a1c9);
    }

    var_9783e01495371f79 = get_random_line(var_3e6586f255dc93ff);

    if(function_eac0cd99c9c6d8ee() == "spotted") {
      var_9783e01495371f79 = get_random_line(var_1ffae88bff4bff92);
    }

    flag_str = "flag_bomb_" + num + "_defused";

    if(num == 0) {
      flag_str = "flag_bomb_truck_defused";
    }

    level.player say_sequence([var_59c8e8e7a767bdae, var_9783e01495371f79], 1, 1, 0, undefined, "team", flag_str);
    thread function_262d0dadfef3cc66(num);

    switch (num) {
      case 1:
        utility::flag_set("water_bomb_found");
        break;
      case 2:
        utility::flag_set("catwalk_bomb_found");
        break;
      case 3:
        utility::flag_set("bunker_bomb_found");
        break;
      case 0:
        utility::flag_set("truck_bomb_found");
        break;
    }
  }
}

function function_262d0dadfef3cc66(bombnum) {
  flag_str = "flag_bomb_" + bombnum + "_defused";

  if(bombnum == 0) {
    flag_str = "flag_bomb_truck_defused";
  }

  if(flag(flag_str)) {
    return;
  }

  level endon(flag_str);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_copydefusewhenable";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_copygetitdefused";
  var_373c09dc422a8851 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_copydefusewhenable_01";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_copygetitdefused_01";
  var_b71275f9121a7b94 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_07getthatchargedefus";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_07thatchargeisstillh";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_ghostdefusetheexplos";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_ghostdisarmthatcharg";
  var_968944443850b297 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_07getthatchargedefus_01";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_07thatchargeisstillh_01";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_ghostdefusetheexplos_01";
  aliases[aliases.size] = "dx_cp_cdam_atfr_lasw_ghostdisarmthatcharg_01";
  var_acaa62ce24ce4f9a = create_deck(aliases, 1, 1);
  level.player endon("interact_started");
  wait 12;

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    alias = var_acaa62ce24ce4f9a deck_draw();
  } else {
    alias = var_968944443850b297 deck_draw();
  }

  level.player say_team(alias, 0.4, 3, 0);
}

function function_38c914390b41befb() {
  vo = ["dx_cp_cdam_dabb_ghos_standby", "dx_cp_cdam_dabb_ghos_disarming", "dx_cp_cdam_dabb_ghos_defusing", "dx_cp_cdam_dabb_ghos_onit"];
  var_798409162ed883a4 = [];
  var_798409162ed883a4[var_798409162ed883a4.size] = "dx_cp_cdam_dabb_ghos_standby_01";
  var_798409162ed883a4[var_798409162ed883a4.size] = "dx_cp_cdam_dabb_ghos_disarming_01";
  var_798409162ed883a4[var_798409162ed883a4.size] = "dx_cp_cdam_dabb_ghos_defusing_01";
  var_798409162ed883a4[var_798409162ed883a4.size] = "dx_cp_cdam_dabb_ghos_onit_01";

  if(!level.player isswimunderwater()) {
    if(function_eac0cd99c9c6d8ee() == "spotted") {
      lines = var_798409162ed883a4;
    } else {
      lines = vo;
    }

    var_bd115db7d0394798 = create_deck(lines, 1, 1);
    level.player say_team(var_bd115db7d0394798 deck_draw(), 0.2, 0.1, 0);
  }
}

function function_5994eb14c59dd582() {
  while(true) {
    msg = level utility::waittill_any_return_4("flag_bomb_1_defused", "flag_bomb_2_defused", "flag_bomb_3_defused", "flag_bomb_truck_defused");

    if(level.bombsdefused < level.numbombs) {
      alias = "";

      switch (msg) {
        case #"hash_4284c0a2e8e09675":
          var_6d76a2bed33771b2 = ["dx_cp_cdam_audi_ghos_bridgedisarmed", "dx_cp_cdam_audi_ghos_bridgesecured", "dx_cp_cdam_audi_ghos_bridgeisdefused", "dx_cp_cdam_audi_ghos_chargedefusedbridgei"];
          var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_audc_ghos_bridgeisdisarmed", "dx_cp_cdam_audc_ghos_bridgesecured", "dx_cp_cdam_audc_ghos_bridgeisdefused", "dx_cp_cdam_audc_ghos_chargedefusedbridgei"];
          break;
        case #"hash_251ae3f0ba22f4b0":
          var_6d76a2bed33771b2 = ["dx_cp_cdam_acdi_ghos_catwalkbombsdisarmed", "dx_cp_cdam_acdi_ghos_explosivesdefusedcat", "dx_cp_cdam_acdi_ghos_bombdisarmedclearatt", "dx_cp_cdam_acdi_ghos_watcher1bombdefusedc", "dx_cp_cdam_acdi_ghos_watcher1bombdefusedc"];
          var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_acdc_ghos_catwalkbombsdisarmed", "dx_cp_cdam_acdc_ghos_explosivesdefusedcat", "dx_cp_cdam_acdc_ghos_bombdisarmedclearatt", "dx_cp_cdam_acdc_ghos_bombdisabledcatwalks", "dx_cp_cdam_acdc_ghos_catwalksdisarmedwere", "dx_cp_cdam_acdc_ghos_bombdisarmedcatwalki"];
          break;
        case #"hash_10dac7350ca06a2f":
          var_6d76a2bed33771b2 = ["dx_cp_cdam_atzi_ghos_bunkerbombisdown", "dx_cp_cdam_atzi_ghos_idisarmedthebunkerbo", "dx_cp_cdam_atzi_ghos_bombdisabledemergenc"];
          var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_atdc_ghos_bunkerbombdisarmed", "dx_cp_cdam_atdc_ghos_securedthebunker", "dx_cp_cdam_atdc_ghos_bunkersallclear", "dx_cp_cdam_atdc_ghos_bunkerssafe", "dx_cp_cdam_atdc_ghos_bunkerbombsdead"];
          break;
        case #"hash_8b91f1e08b2cd759":
          var_6d76a2bed33771b2 = ["dx_cp_cdam_atdi_ghos_wonthurtnoonenow", "dx_cp_cdam_atdi_ghos_disabled", "dx_cp_cdam_atdi_ghos_bombisdisabled", "dx_cp_cdam_atdi_ghos_truckbombneutralized", "dx_cp_cdam_atdi_ghos_chargeissafe", "dx_cp_cdam_atdi_ghos_truckbombdisabled"];
          var_8c0dd9b91a21a1c9 = ["dx_cp_cdam_ashp_ghos_doneanddusted", "dx_cp_cdam_ashp_ghos_neutralized", "dx_cp_cdam_ashp_ghos_trucksclear", "dx_cp_cdam_ashp_ghos_truckbombneutralized"];
          break;
      }

      if(var_6d76a2bed33771b2.size > 0) {
        if(msg == "flag_bomb_1_defused") {
          while(level.player isswimunderwater()) {
            waitframe();
          }
        }

        wait 2;
        var_968944443850b297 = create_deck(var_6d76a2bed33771b2, 1, 1);
        var_acaa62ce24ce4f9a = create_deck(var_8c0dd9b91a21a1c9, 1, 1);

        if(function_155f16ed1b7f00cd()) {
          level.player say_team(var_acaa62ce24ce4f9a deck_draw(), 1, 1, 0);
        } else {
          level.player say_team(var_968944443850b297 deck_draw(), 1, 1, 0);
        }
      }

      switch (level.bombsdefused) {
        case 1:
          var_3e6586f255dc93ff = ["dx_cp_cdam_dmtm_lasw_thatmeansweneedtofin", "dx_cp_cdam_bdl2_lasw_niceworkbutkonnisget"];

          if(flag("vo_four_bombs_said")) {
            level.player say_team(random(var_3e6586f255dc93ff), 0.8, 2, 0);
          }

          function_4d74a5f0f6b017ff();
          break;
        case 2:
          var_3e6586f255dc93ff = ["dx_cp_cdam_bdlr_lasw_justtwomoretogo", "dx_cp_cdam_bdlr_lasw_onlytwomoretogo", "dx_cp_cdam_bdlr_lasw_justtwoleft", "dx_cp_cdam_bdlr_lasw_justtwomoretogo"];
          var_1ffae88bff4bff92 = ["dx_cp_cdam_bdlr_lasw_twobombsareleft", "dx_cp_cdam_bdlr_lasw_twobombsarestillacti", "dx_cp_cdam_bdlr_lasw_twomoretogo"];

          if(flag("vo_four_bombs_said")) {
            level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, var_3e6586f255dc93ff, undefined, undefined, var_1ffae88bff4bff92);
          }

          function_4d74a6f0f6b01a32();
          break;
        case 3:
          var_3e6586f255dc93ff = ["dx_cp_cdam_bdlr_lasw_hurryghostonlyonelef", "dx_cp_cdam_bdlr_lasw_justoneleft", "dx_cp_cdam_bdlr_lasw_yourenotdoneonemoret"];
          var_1ffae88bff4bff92 = ["dx_cp_cdam_bdlr_lasw_onebombisstilloutthe", "dx_cp_cdam_bdlr_lasw_gettothelastbombgo", "dx_cp_cdam_bdlr_lasw_onechargeleftmove"];
          level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, var_3e6586f255dc93ff, undefined, undefined, var_1ffae88bff4bff92);
          function_4d74a7f0f6b01c65();
          break;
      }
    }
  }
}

function function_4d74a5f0f6b017ff() {
  wait 5;
  convo = ["dx_cp_cdam_sci1_soap_thinkifoundagascanni", "dx_cp_cdam_sci1_lasw_describeit", "dx_cp_cdam_sci1_soap_uhcannistershaped", "dx_cp_cdam_sci1_soap_gascannistersinthewa", "dx_cp_cdam_sci1_lasw_thatsamatchneutraliz", "dx_cp_cdam_sci1_soap_bastardsnotjustflood"];
  flag_set("soap_checkin_1_speaking");
  level.player say_sequence(convo, 1, 0, 0, 0, "team");
  flag_clear("soap_checkin_1_speaking");
  wait 1;

  if(!level.player isswimming() && !function_1bb1470f934a81eb()) {
    level.player say_team("dx_cp_cdam_sci1_ghos_theyllbenosurvivors", 0, 0.3, 0);
  }

  wait 0.8;
  level.player say_team("dx_cp_cdam_sci1_lasw_youtwoaretheonlyones", 0, 0.4, 0);
}

function function_4d74a6f0f6b01a32() {
  wait 5;

  if(!flag("vo_four_bombs_said")) {
    function_129359a1ad7c60b1();
    return;
  }

  convo = ["dx_cp_cdam_sci3_soap_laswellimhalfthrough", "dx_cp_cdam_sci3_lasw_niceworkyouregetting", "dx_cp_cdam_sci3_soap_thefirstsixweretheha"];
  level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(convo);
}

function function_4d74a7f0f6b01c65() {
  wait 3;
  convo = ["dx_cp_cdam_sci2_soap_overwatchivefoundand", "dx_cp_cdam_sci2_lasw_keepgoingthereshould", "dx_cp_cdam_sci2_soap_christthatsmywholeni"];
  level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(convo);
}

function function_129359a1ad7c60b1(trigger) {
  level.player say_team("dx_cp_cdam_dmtm_lasw_07wepickedupenemyrad", 1, 5, 0);
  wait 0.5;
  level.player say_team("dx_cp_cdam_dmtm_soap_fourteamsfourbombs", 1, 5, 0);
  wait 0.3;
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_dmtm_lasw_thenwevegotworktodo";
  aliases[aliases.size] = "dx_cp_cdam_dmtm_lasw_thatmeansweneedtofin";
  aliases[aliases.size] = "dx_cp_cdam_dmtm_lasw_meanswegottwomoretol";
  aliases[aliases.size] = "dx_cp_cdam_dmtm_lasw_meanstheresstillonem";

  if(isDefined(trigger)) {
    if(level.player istouching(trigger)) {
      level.player say_team(aliases[level.bombsdefused], 1, 3, 0);
    }
  } else {
    level.player say_team(aliases[level.bombsdefused], 1, 3, 0);
  }

  flag_set("vo_four_bombs_said");
}

function function_d56db4c25d306c25() {
  while(level.player isswimunderwater()) {
    waitframe();
  }

  var_3e6586f255dc93ff = ["dx_cp_cdam_bdl3_lasw_thatshouldbethelasto", "dx_cp_cdam_bdl3_lasw_allordnancesaccounte", "dx_cp_cdam_bdl3_lasw_allfourordnancesacco", "dx_cp_cdam_bdl3_lasw_thatsthelastoftheord"];
  var_dabbee033d7e5c88 = create_deck(var_3e6586f255dc93ff, 1, 1);
  level.player dialogue::stop_dialogue();
  level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(var_dabbee033d7e5c88 deck_draw());
  utility::flag_set("transition_search_vo_complete");
}

function function_d1ffc480a3c78acb(var_433ddca2d1d4416b) {
  while(!level.player istouching(var_433ddca2d1d4416b)) {
    waitframe();
  }
}

function function_c0791d4fbca710d0() {
  var_10573cf12f893594 = "dx_cp_cdam_cose_lasw_thefacilityisonhigha";

  while(true) {
    waitframe();
    level waittill("red_alert_begin");

    if(flag("vo_alert_said") || flag("flag_obj_all_bombs_defused")) {
      continue;
    }

    level.player say_team(var_10573cf12f893594, 0.8, 4, 0);
    flag_set("vo_alert_said");
    namespace_720324fc2825f6b9::flag_clear_delayed("vo_alert_said", 10);
  }
}

function function_262b38cc79b24196() {
  utility::flag_wait("flag_hack_complete");
  level.player dialogue::stop_dialogue();
  level notify("hack_vo_complete");
}

function function_2f4f8142ad705630() {
  wait 30;

  if(!utility::flag("defend_west_complete")) {
    level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f("dx_cp_cdam_gslr_lasw_itlookshotdowntherew");
  }
}

function function_5a8578b192c64d43() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_xfil_ghos_watcher1spillwayiscl";
  aliases[aliases.size] = "dx_cp_cdam_xfil_soap_weregooduptopreservo";
  vo1 = aliases;

  if(getdvarint(@ "hash_28f8434dbc4fa9dd", 0)) {
    utility::flag_wait("flag_obj_all_bombs_defused");
  } else {
    utility::flag_wait("flag_defend_complete");
  }

  level notify("defend_transition_vo_started");
  wait 5;
  level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(vo1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_cdam_xfil_lasw_solidcopystandby";
  aliases[aliases.size] = "dx_cp_cdam_xfil_lasw_yankeethisiswatcher1";
  aliases[aliases.size] = "dx_cp_cdam_xfil_niko_copywatcher1inboundn";
  aliases[aliases.size] = "dx_cp_cdam_xfil_soap_moveyourasslt";
  aliases[aliases.size] = "dx_cp_cdam_xfil_niko_rogeronemikeout";
  vo2 = aliases;
  wait 1;
  level.player namespace_e36cb7ca6117d2cc::function_31fcf0528e5d8d3f(vo2);
  thread exfil_music();
  wait 2;
  level notify("defend_transition_vo_complete");
}

function exfil_music() {
  wait 1.5;
  setmusicstate("mx_dam_exfil");
}

function function_2f96fcbbfb50889d() {
  utility::flag_wait("flag_exfil_heli_arriving");
  level.player say_team("dx_cp_cdam_xfil_niko_yankeetoghostseconda", 1, 3);
  utility::flag_wait("flag_exfil_heli_idle_start");
  thread function_505d0d20c242e9a5();
  var_e281f7f1380cd552 = create_deck(["dx_cp_cdam_xfil_lasw_missionaccomplishedb", "dx_cp_cdam_xfil_lasw_goodworkniksoapghost", "dx_cp_cdam_xfil_lasw_jobwelldoneboyswesav"], 1, 1);
  wait 1;

  if(!istrue(level.var_db9ec95ee6e4d501)) {
    if(istrue(level.var_5843e823f7ef9a57)) {
      level.player say_team("dx_cp_cdam_xfil_niko_touchingdownnearther", 1, 3);
    } else {
      level.player say_team("dx_cp_cdam_xfil_niko_touchingdownatthebri", 1, 3);
    }
  }

  utility::flag_wait("flag_exfil_heli_player_on_board");
  thread function_adf509f9ba7e98df();
  level.player say_team("dx_cp_cdam_xfil_soap_nikltsondeckwereclea", 1, 3);
  level.player say_team("dx_cp_cdam_xfil_niko_copyliftingoff", 1, 3);
  wait 1;
  level.player say_team(var_e281f7f1380cd552 deck_draw(), 1, 3);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1);
  level.player say_team("dx_cp_cdam_xfil_niko_copywatcherwerertb", 1, 3);
  wait 1;
  level notify("exfil_vo_complete");
}

function function_adf509f9ba7e98df() {
  setmusicstate("mx_dam_exfil_end");
}

function function_505d0d20c242e9a5() {
  if(flag("flag_exfil_heli_player_on_board")) {
    return;
  }

  level endon("flag_exfil_heli_player_on_board");
  level endon("flag_dungeon_outro_start");

  if(istrue(level.var_5843e823f7ef9a57)) {
    aliases = ["dx_cp_cdam_xfil_niko_bravo7werewaitingnea", "dx_cp_cdam_xfil_soap_rallyneartheradiotow", "dx_cp_cdam_xfil_soap_exfilsneartheradioto", "dx_cp_cdam_xfil_lasw_ghostexfilisinboundh", "dx_cp_cdam_xfil_soap_moveyourassltwegotta", "dx_cp_cdam_xfil_soap_ghostwecantholdthemo", "dx_cp_cdam_xfil_soap_thehelicantwaitforev"];
  } else {
    aliases = ["dx_cp_cdam_xfil_niko_bravo7wereholdingatt", "dx_cp_cdam_xfil_soap_stepitupltweretaking", "dx_cp_cdam_xfil_soap_ghostletsgotakingeff", "dx_cp_cdam_xfil_lasw_ghostexfilisinboundg"];
  }

  level.player childthread nagtill("flag_exfil_heli_player_on_board", aliases, growing_delay(7, 12, 3));

  while(distancesquared(level.player.origin, level.heli_model.origin) > 1440000) {
    wait 0.2;
  }

  level.player say_team("dx_cp_cdam_xfil_ghos_onmyway", 0.8, 6);
}

function get_random_line(line_array) {
  if(line_array.size < 1) {
    return "";
  }

  return line_array[randomint(line_array.size)];
}

function function_b70b8e27fd850523(alias, priority, vo_timeout) {
  priority = default_to(priority, 1);
  vo_timeout = default_to(vo_timeout, 0);

  while(level.player isswimunderwater()) {
    waitframe();
  }

  level.player say(alias, priority, vo_timeout);
}

function function_4b0ccdf45b0a8702() {
  utility::flag_wait("vo_infil_complete");
  thread function_f6808d0d20028df0();
  thread function_12e4c11d0b4f8940();
  thread function_adfccc90ce7cbe2();
  thread function_ee26920749ea1875();
  thread function_69ec5c0e10ff92de();
}

function function_f6808d0d20028df0() {
  level endon("game_ended");
  level.player endon("death");
  vo = ["dx_cp_cdam_kiin_lasw_ghostshadowairdroppe", "dx_cp_cdam_kiin_ghos_notaproblem", "dx_cp_cdam_kiin_lasw_ifyourecoverthedrops", "dx_cp_cdam_kiin_ghos_copythat"];
  wait 4;
  level.player say_sequence(vo, 0.1, 2, 0);
}

function function_12e4c11d0b4f8940() {
  level endon("game_ended");
  level.player endon("death");
  vo = ["dx_cp_cdam_kii1_lasw_ghostlookslikeyoufou", "dx_cp_cdam_kii1_ghos_illuseitifineeditsti", "dx_cp_cdam_kii1_soap_youandmebothlt", "dx_cp_cdam_kii1_lasw_idontblameyouboys"];

  while(!level.player scripts\cp\munitions::has_munition("chopper_gunner")) {
    waitframe();
  }

  wait 1;
  level.player say_sequence(vo, 0.1, 2, 0);
}

function function_adfccc90ce7cbe2() {
  level endon("game_ended");
  level.player endon("death");
  vo = ["dx_cp_cdam_kii2_lasw_nicefindghostthatwil", "dx_cp_cdam_kii2_ghos_illtakethatunderadvi"];

  while(!level.player scripts\cp\munitions::has_munition("hover_jet")) {
    waitframe();
  }

  wait 1;
  level.player say_sequence(vo, 0.1, 2, 0);
}

function function_ee26920749ea1875() {
  level endon("game_ended");
  level.player endon("death");
  vo = ["dx_cp_cdam_kii3_lasw_thatwillcomeinhandya", "dx_cp_cdam_kii3_ghos_withfriendslikethemw"];

  while(!level.player scripts\cp\munitions::has_munition("cruise_missile")) {
    waitframe();
  }

  wait 1;
  level.player say_sequence(vo, 0.1, 2, 0);
}

function function_69ec5c0e10ff92de() {
  level endon("game_ended");
  level.player endon("death");
  vo = ["dx_cp_cdam_kii4_lasw_youfoundashadowsuppl", "dx_cp_cdam_kii4_ghos_foundalasermarkerfor"];

  while(!level.player scripts\cp\munitions::has_munition("toma_strike")) {
    waitframe();
  }

  wait 1;
  level.player say_sequence(vo, 0.1, 2, 0);
}