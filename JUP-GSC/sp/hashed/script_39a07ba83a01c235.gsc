/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_39a07ba83a01c235.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_181a761dd7020a2a;
#using script_3a8f9ace195c9da9;
#using script_48324b060b129b7b;
#using scripts\anim\dialogue;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\munitions;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_b537fef526154590;

function private function_a64710b9daa5b764(source, responses) {
  var_9dd4ad0d2b6c0064 = random(responses);
  source[source.size] = var_9dd4ad0d2b6c0064[0];
  source[source.size] = var_9dd4ad0d2b6c0064[1];
  source[source.size] = var_9dd4ad0d2b6c0064[2];
  return source;
}

function private function_a7c8f01b64b95e8e() {
  return flag("stealth_spotted");
}

function function_b1bd1a87d074e54c() {
  level.laswell = level;
  level.ghost = level;
  level.soap = level.player;
}

function function_c549184438040430() {
  for(;;) {
    if(!isalive(level.vip)) {} else {
      dist = distance(level.player.origin, level.vip.origin);

      iprintlnbold(dist);

      printtoscreen2d(100, 500, dist, (1, 1, 0), 1, 1);
    }

    waitframe();
  }
}

function function_90d19c9b48fdaac4() {
  sequence = ["dx_cp_reso_qiis_lasw_notimeforaboatridese", level.soap, 0.2, "dx_cp_reso_qiis_soap_notabadplacetogofish", level.ghost, 0.2, "dx_cp_reso_qiis_ghos_getofftheboatjohnny", level.soap, 0.3, "dx_cp_reso_qiis_soap_justsayin"];
  result = level thread function_c9a09b3ba9c68f8d(0.6, sequence);
  wait 1;
  sequence = [level.ghost, "dx_cp_reso_gwu1_ghos_movingtosecuretheper", &function_16b3ab92dae9a32, level.soap, 0.3, "dx_cp_reso_gwu1_soap_goodlucklt", &function_16b3ab92dae9a32, level.ghost, 0.4, "dx_cp_reso_gwu1_ghos_yeahtheyregonnaneedi"];
  result = level.ghost function_c9a09b3ba9c68f8d(0.3, sequence);
}

function function_ffc7dd3a5adfd5cf() {
  level endon("game_ended");
  function_b1bd1a87d074e54c();
  level function_f5e84957798fd3c7();
  thread function_741a03c7595144d6();
  wait 1;
  flag_wait("flag_dungeon_intro_complete");

  if(scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("terminal_checkpoint")) {
    flag_set("vo_spotted_security_building");
    flag_set("bunker_terminal_vo_completed");
    flag_set("vo_found_door_controls");
    flag_set("vo_finished_ghost_updates");
  } else {
    thread function_94b9f50eea5e8993();
    thread function_2a347e177dd268fe();
    thread function_53e3a26ab0b0f575();
    thread function_958b5465f37a2002();
    thread function_fc439c82f0b44441();
    thread function_c29b695e7df4843d();
    thread function_44aa92d6e4b96295();
    thread function_eda7d8016eafb64e();
    thread function_5c5a589e629678a2();
  }

  thread function_7c1f1411fabbf624();
  thread function_14253eea24df30e2();
  thread function_4bc62ec0304bd2e7();
  thread function_2cef8fa07cd294c5();
  thread function_1a08ad97946816c2();
  thread vo_red_alert();
  thread function_fdc445c5ebb7f83e();
  thread function_191610be46ef35a4();
  thread function_3c8c4b4c063e9260();
  thread function_19c7d50f5ca3775b();
  thread function_b66949e28f8b252c();
  thread function_6e723dc45133badb();
  thread function_7b149b2c903ea258();
  thread function_1502997c352f6a08();
  thread function_6577b99a4ca3bba();
  thread function_adb560d383ed603a();
}

function function_741a03c7595144d6() {
  level.player waittill("death");
  function_a583984eb78c6c32();
}

function function_2a347e177dd268fe() {
  if(!isDefined(level.vo.var_3078cb6eb89d6049)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_xreo_ghos_youneedtotakedowntha";
    aliases[aliases.size] = "dx_cp_reso_xreo_ghos_getdowntobusinessjoh";
    aliases[aliases.size] = "dx_cp_reso_xreo_ghos_nofuckinaboutsoaptim";
    aliases[aliases.size] = "dx_cp_reso_wvcy_ghos_hvijohnnystalkhimand";
    aliases[aliases.size] = "dx_cp_reso_nlhx_ghos_takedownthehvijohnny";
    aliases[aliases.size] = "dx_cp_reso_rrsh_ghos_ifyourhvisnearbymove";
    level.vo.var_3078cb6eb89d6049 = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_nlhx_soap_onmyway";
    aliases[aliases.size] = "dx_cp_reso_nlhx_soap_withpleasurelt";
    aliases[aliases.size] = "dx_cp_reso_nlhx_soap_dontmindifdo";
    aliases[aliases.size] = "dx_cp_reso_rrsh_soap_rogerthat";
    level.vo.var_316e58687a33a8c4 = create_deck(aliases);
  }

  if(flag("obj_VIP_dead") || flag("obj_laptop2_completed")) {
    return;
  }

  level endon("obj_VIP_dead");
  delay = growing_delay(40, 200, 4);

  while(!isDefined(level.vip)) {
    wait 1;
  }

  var_ddd22acfab0782e1 = distancesquared(level.player.origin, level.vip.origin);

  while(true) {
    waitfor(delay);
    var_666b09fe74fa53ee = var_ddd22acfab0782e1;
    var_ddd22acfab0782e1 = distancesquared(level.player.origin, level.vip.origin);

    if(var_ddd22acfab0782e1 < var_666b09fe74fa53ee) {
      delay.current -= delay.increment;
      continue;
    }

    result = 0;

    while(isDefined(result) && !result) {
      while(flag("stealth_spotted") || !istrue(function_6bf44e0bb0f1720a(4, 1))) {
        flag_waitopen("stealth_spotted");
        wait 5;
        var_ddd22acfab0782e1 = distancesquared(level.player.origin, level.vip.origin);

        if(var_ddd22acfab0782e1 < var_666b09fe74fa53ee) {
          delay.current -= delay.increment;
          break;
        }
      }

      sequence = [level.vo.var_3078cb6eb89d6049 deck_draw(), level.soap, 0.3, level.vo.var_316e58687a33a8c4 deck_draw()];
      result = level.ghost function_c9a09b3ba9c68f8d(0.8, sequence, 0, 1);
      waitframe();
    }
  }
}

function function_3bf6123f2f799764() {
  flag_wait("vip_located");
  sequence = ["dx_cp_reso_feqk_lasw_imtrackingthelocatio", level.laswell, 0.4, "dx_cp_reso_feqk_lasw_signalisntgreatbuthi", level.soap, 0.6, "dx_cp_reso_nfha_soap_check_01"];
  var_e274235250d8ba5e = level function_c9a09b3ba9c68f8d(0.5, sequence, 1, 2);
  flag_set("said_tracking_hvi");
}

function function_53e3a26ab0b0f575() {
  level endon("stealth_spotted");
  closestai = sortbydistance(getaiarrayinradius(level.player.origin, 3000), level.player.origin);
  closestai = [closestai[0], closestai[2]];
  flag_wait("said_tracking_hvi");
  level.var_d34bf8b1633b9124 = function_ce1551245242a903(closestai, 0.95, 0.3, 1500);
  sequence = [level.laswell, 0, "dx_cp_reso_dbmb_lasw_71yougotahostileonth", level.soap, 0.1, &function_96e61c74f972cecc, "dx_cp_reso_vbxb_soap_iseehim"];
  level.player function_c9a09b3ba9c68f8d(&function_96e61c74f972cecc, sequence);
}

function function_3c8c4b4c063e9260() {
  level endon("entered_mansion");
  contents = scripts\engine\trace::create_default_contents(1);
  var_11ae0b1722c21016 = (3017.54, -4432.56, 363.79);
  result = 0;

  while(isDefined(result) && !result) {
    function_ce1551245242a903(var_11ae0b1722c21016, 0.95, 0.8, 8000);

    if(flag("stealth_spotted")) {
      flag_waitopen("stealth_spotted");
      wait 5;
    } else {
      sequence = [level.soap, 0.4, "dx_cp_reso_wzha_soap_bigfuckingboat", level.ghost, 0.5, "dx_cp_reso_wzha_ghos_moneycantbuyhappines", level.laswell, 0.3, "dx_cp_reso_wzha_lasw_iwouldntmindbeingsad", level.soap, 0.2, "dx_cp_reso_wzha_soap_iprobablywouldntcrym"];
      result = level.player function_c9a09b3ba9c68f8d(0.6, sequence, 0, &function_1b70cc297ee8e5da);
    }

    waitframe();
  }
}

function function_1b70cc297ee8e5da() {
  var_11ae0b1722c21016 = (3017.54, -4432.56, 363.79);
  function_bc9fb23680427ef5(var_11ae0b1722c21016, 0.75, 0.6, 8000);
}

function function_191610be46ef35a4() {
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  result = 0;

  while(isDefined(result) && !result) {
    for(;;) {
      while(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 5;
      }

      player_angles = level.player getplayerangles();

      if(player_angles[0] > -45) {} else {
        player_forward = anglesToForward(player_angles);
        start = level.player getEye();

        if(scripts\engine\trace::ray_trace_passed(start, start + player_forward * 1000, level.player, contents)) {
          break;
        }
      }

      waitframe();
    }

    if(!isDefined(level.vo.storm)) {
      aliases = ["dx_cp_reso_zvha_soap_stormsbrewin", "dx_cp_reso_zvha_soap_theresastormontheway", "dx_cp_reso_zvha_soap_lookslikewereinforas"];
      level.vo.storm = create_deck(aliases);
    }

    result = level.player function_fc0eb6b81c66c661(0.6, level.vo.storm deck_draw(), 0, &function_afd048066b78e4a6);
    waitframe();
  }
}

function function_afd048066b78e4a6() {
  contents = scripts\engine\trace::create_default_contents(1);

  for(;;) {
    player_angles = level.player getplayerangles();

    if(player_angles[0] > -35) {
      return;
    }

    player_forward = anglesToForward(player_angles);
    start = level.player getEye();

    if(!scripts\engine\trace::ray_trace_passed(start, start + player_forward * 1000, level.player, contents)) {
      return;
    }

    waitframe();
  }
}

function function_10e305c9f26829bb() {
  level endon("stealth_spotted");
  flag_waitopen("player_near_cabana");
}

function function_958b5465f37a2002() {
  level endon("entered_mansion");
  result = 0;

  while(isDefined(result) && !result) {
    while(!flag("player_near_cabana") || flag("stealth_spotted")) {
      if(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 5;
      }

      flag_wait("player_near_cabana");
    }

    sequence = ["dx_cp_reso_hlor_soap_imnearthesmallroomsw", level.laswell, 0.3, "dx_cp_reso_hlor_lasw_ibelievethosearecaba", &function_44547bb3f0740247, level.ghost, 0.2, "dx_cp_reso_hlor_ghos_notmuchforthebeachjo", level.soap, 0.3, "dx_cp_reso_hlor_soap_preferthesnowlt", &function_44547bb3f0740247, level.laswell, 0.4, "dx_cp_reso_hlor_lasw_skiorsnowboardsoap", level.soap, 0.3, "dx_cp_reso_hlor_soap_snowboard", &function_44547bb3f0740247, level.ghost, 0.4, "dx_cp_reso_hlor_ghos_snowboardingsforsava", &function_44547bb3f0740247, level.soap, 0.3, "dx_cp_reso_hlor_soap_whatsayyoulaswell", level.laswell, 0.5, "dx_cp_reso_hlor_lasw_snowmobileinternalco", level.soap, 0.3, "dx_cp_reso_hlor_soap_cantarguewiththat"];
    result = level.player function_c9a09b3ba9c68f8d(0.6, sequence, 0, &function_10e305c9f26829bb);
    waitframe();
  }

  wait 30;
  var_cb574097cf162b32 = [(-24.2368, 2942.61, 216), (925.636, 3184.95, 184), (-567.816, 2931.63, 204), (-1368.58, 3186.44, 184.5)];

  for(i = 0; i < 2; i++) {
    result = 0;

    while(isDefined(result) && !result) {
      function_ce1551245242a903(var_cb574097cf162b32, 0.7, 0.3, 200);

      while(flag("stealth_spotted")) {
        if(flag("stealth_spotted")) {
          flag_waitopen("stealth_spotted");
          wait 5;
        }

        function_ce1551245242a903(var_cb574097cf162b32, 0.7, 0.3, 200);
      }

      if(!isDefined(level.vo.var_ec86ce1f7a933a8d)) {
        aliases = ["dx_cp_reso_uqvu_soap_sweepingacabana", "dx_cp_reso_uqvu_soap_clearingacabana"];
        level.vo.var_ec86ce1f7a933a8d = create_deck(aliases);
      }

      result = level.player function_fc0eb6b81c66c661(0.6, level.vo.var_ec86ce1f7a933a8d deck_draw(), 0, 0.5);
      waitframe();
    }

    wait 20;
  }
}

function function_44547bb3f0740247() {
  if(level.vo_teams["allies"].vo_queue.size > 0) {
    return 0;
  }
}

function function_fc439c82f0b44441() {
  result = 0;

  while(isDefined(result) && !result) {
    while(!flag("player_on_boat") || flag("stealth_spotted")) {
      if(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 5;
      }

      flag_wait("player_on_boat");
    }

    sequence = ["dx_cp_reso_qiis_lasw_notimeforaboatridese", level.soap, 0.2, "dx_cp_reso_qiis_soap_notabadplacetogofish", &function_eb00c848fc9f0dbf, level.ghost, 0.2, "dx_cp_reso_qiis_ghos_getofftheboatjohnny", level.soap, 0.3, "dx_cp_reso_qiis_soap_justsayin"];
    result = level function_c9a09b3ba9c68f8d(0.6, sequence, 0, [level, "player_on_boat"]);
    waitframe();
  }
}

function function_eb00c848fc9f0dbf() {
  if(!flag("player_on_boat")) {
    return 0;
  }
}

function vo_red_alert() {
  flag_wait("red_alert");
  flag_set("vo_said_red_alert");
  wait 5;

  if(!istrue(level.vo.var_31a04d29a20cd5ac) && flag("red_alert")) {
    level.vo.var_31a04d29a20cd5ac = level function_fc0eb6b81c66c661(0.6, "dx_cp_reso_xext_ghos_theyreonhighalertall", 0, 5);
  }
}

function function_96e61c74f972cecc() {
  wait 0.3;

  if(!isalive(level.var_d34bf8b1633b9124)) {
    return 0;
  }
}

function function_c29b695e7df4843d() {
  for(i = 0; i < 2 || flag("stealth_spotted"); i++) {
    level waittill("ai_killed");
  }

  result = 0;

  while(isDefined(result) && !result) {
    for(i = 0; i < 1 || flag("stealth_spotted"); i++) {
      level waittill("ai_killed");
    }

    sequence = [level.soap, 0.2, "dx_cp_reso_axtg_soap_islandscrawlingwithk", level.ghost, 0.5, "dx_cp_reso_axtg_ghos_burnthroughemjohnny", level.soap, 0.3, "dx_cp_reso_axtg_soap_withfuckinpleasure"];
    wait 0.5;
    result = level.player function_c9a09b3ba9c68f8d(0.5, sequence, 0, 2);
    waitframe();
  }
}

function function_94b9f50eea5e8993() {
  level endon("game_ended");
  self endon("death");
  thread function_3bf6123f2f799764();
  thread function_41fb786e1de8ef56();
  thread function_6d8e09d597e95990();
}

function private function_41fb786e1de8ef56() {
  level endon("game_ended");
  level endon("obj_VIP_dead");
  distsq = squared(2000);
  wait 1;

  if(!isDefined(level.vip)) {
    return;
  }

  while(distancesquared(level.player.origin, level.vip.origin) > distsq) {
    if(flag("stealth_spotted")) {
      flag_waitopen("stealth_spotted");
      wait 5;
    }

    waitframe();
  }

  sequence = ["dx_cp_reso_yhex_lasw_beadviseddidsomedigg", level.soap, 0.6, "dx_cp_reso_yhex_soap_tellhisfamilyhewontb"];
  level function_c9a09b3ba9c68f8d([ &function_e89619d4312eb25b, 0.8], sequence);
  thread function_df134f17f77a08a2();
}

function function_e89619d4312eb25b(delay) {
  wait default_to(delay, 0);

  if(!isalive(level.vip)) {
    return 0;
  }
}

function player_spotted() {
  if(!flag("stealth_spotted")) {
    return 0;
  }
}

function function_a4e4a9fc80e228fd() {
  if(flag("stealth_spotted")) {
    return 0;
  }
}

function private function_df134f17f77a08a2() {
  level endon("game_ended");
  level endon("obj_VIP_dead");

  if(flag("obj_VIP_dead")) {
    return;
  }

  wait 5;

  if(!isDefined(level.vo.var_f024e00847613151)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_copy";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_understood";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_gotit";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_rog_01";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_affirm_01";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_check_01";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_rogerthat_01";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_solidcopy_01";
    level.vo.var_f024e00847613151 = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_rog";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_affirm";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_check";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_rogerthat";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_solidcopy";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_copy_01";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_understood_01";
    aliases[aliases.size] = "dx_cp_reso_nfha_soap_gotit_01";
    level.vo.var_a2b700acc4c2b4c5 = create_deck(aliases);
    aliases = ["dx_cp_reso_wfgv_lasw_hviwentinterior", "dx_cp_reso_wfgv_lasw_gustevisinsideastruc", "dx_cp_reso_wfgv_lasw_hvidisappearedinside"];
    level.vo.var_264499ce25b7bc7a = create_deck(aliases);
    aliases = ["dx_cp_reso_aigo_lasw_hvisexterior", "dx_cp_reso_aigo_lasw_hvisoutside"];
    level.vo.var_1b8fe82e97a96300 = create_deck(aliases);
    aliases = ["dx_cp_reso_aigo_lasw_youreclose", "dx_cp_reso_aigo_lasw_hvisnotfarsoap", "dx_cp_reso_aigo_lasw_youreclosingonhim"];
    level.vo.var_6a08c24a5007e0a6 = create_deck(aliases);
    aliases = ["dx_cp_reso_aigo_lasw_gustevstakingthestai", "dx_cp_reso_aigo_lasw_soaphvisatthestairs"];
    level.vo.var_7088f395455f4124 = create_deck(aliases);
    aliases = ["dx_cp_reso_aigo_lasw_hviisatthefountainso", "dx_cp_reso_aigo_lasw_checknearthefountain"];
    level.vo.var_4d32f1e7f3b287be = create_deck(aliases);
    aliases = ["dx_cp_reso_itub_soap_insight", "dx_cp_reso_itub_soap_spotted"];
    level.vo.var_dc07e9dac43db19b = create_deck(aliases);
  }

  trigger = getEnt("in_building_trigger", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }

  while(true) {
    alias = function_f4068065104eeb75();
    wait 1;
    sequence = [level.laswell, 0.3, &function_e89619d4312eb25b, alias, level.soap, 0.4, &function_5620037cc39e83cb, &function_8ef3b661c5cd49a7];
    result = level function_c9a09b3ba9c68f8d([ &function_e89619d4312eb25b, 0.4], sequence, 0, 3);

    if(istrue(result) && !flag("stealth_spotted") && !istrue(level.vo.var_3c70d40d050fe2fa)) {
      sequence = [level.laswell, 0.6, &function_a4e4a9fc80e228fd, &function_e89619d4312eb25b, &function_6725e24dfb7b70c9, "dx_cp_reso_pdak_lasw_hesgottwokonniwithhi", &function_d02ac10a2e2c450d, level.soap, 0.3, &function_a4e4a9fc80e228fd, "dx_cp_reso_dqui_soap_betterthanthree", level.ghost, 0.3, &function_a4e4a9fc80e228fd, &function_e89619d4312eb25b, "dx_cp_reso_dqui_ghos_takehimaloneifyoucan"];
      level function_c9a09b3ba9c68f8d([ &function_e89619d4312eb25b, 0.4], sequence, 0, 3);
    }
  }
}

function function_d02ac10a2e2c450d() {
  level.vo.var_3c70d40d050fe2fa = 1;
}

function private function_5620037cc39e83cb() {
  return flag("stealth_spotted") ? level.vo.var_a2b700acc4c2b4c5 deck_draw() : level.vo.var_f024e00847613151 deck_draw();
}

function private function_8ef3b661c5cd49a7() {
  if(isDefined(level.player function_826a16f43a8e949b(level.vip, 0.7, undefined, squared(1000)))) {
    wait 0.3;

    if(isDefined(level.player function_826a16f43a8e949b(level.vip, 0.7, undefined, squared(1000)))) {
      return level.vo.var_dc07e9dac43db19b deck_draw();
    }
  }
}

function private function_f4068065104eeb75() {
  var_a88f4c6d19699702 = getEnt("in_building_trigger", "script_noteworthy");
  fountain = (-780.333, 5852.49, 642.565);
  var_1dae1d207ace2939 = squared(300);
  var_811ccfd729ba41af = squared(800);

  while(true) {
    if(!istrue(level.var_6b6e1a1fc4997d79) && level.vip istouching(var_a88f4c6d19699702)) {
      level.var_6b6e1a1fc4997d79 = 1;
      return level.vo.var_264499ce25b7bc7a deck_draw();
    }

    if(istrue(level.var_6b6e1a1fc4997d79) && !level.vip istouching(var_a88f4c6d19699702)) {
      level.var_6b6e1a1fc4997d79 = 0;
      return level.vo.var_1b8fe82e97a96300 deck_draw();
    }

    var_32ad57b83ee801f7 = !isDefined(level.var_7096b22cb8c64f9) || time_has_passed(level.var_7096b22cb8c64f9, 60);

    if(var_32ad57b83ee801f7 && distance2dsquared(level.player.origin, level.vip.origin) < var_811ccfd729ba41af) {
      level.var_7096b22cb8c64f9 = gettime();
      return level.vo.var_6a08c24a5007e0a6 deck_draw();
    }

    var_10e05e893c2d3203 = !isDefined(level.var_7ec06af6482a71fd) || time_has_passed(level.var_7ec06af6482a71fd, 60);

    if(var_10e05e893c2d3203 && level.vip.origin[0] < -870 && level.vip.origin[0] > -1100 && level.vip.origin[1] > 4550 && level.vip.origin[1] < 5300) {
      level.var_7ec06af6482a71fd = gettime();
      return level.vo.var_7088f395455f4124 deck_draw();
    }

    var_e375dffa63a9b501 = !isDefined(level.var_fa5b6f34b6f073) || time_has_passed(level.var_fa5b6f34b6f073, 60);

    if(var_e375dffa63a9b501 && distance2dsquared(fountain, level.vip.origin) < var_1dae1d207ace2939) {
      level.var_fa5b6f34b6f073 = gettime();
      return level.vo.var_4d32f1e7f3b287be deck_draw();
    }

    waitframe();
  }
}

function private function_6725e24dfb7b70c9() {
  if(getaiarrayinradius(level.vip.origin, 400).size < 2) {
    return 0;
  }
}

function private function_6fa91a650968dda0() {
  level endon("game_ended");
}

function function_e1d6b1bfe3bce7b9() {
  if(flag("obj_laptop2_completed")) {
    return 0;
  }
}

function private function_6d8e09d597e95990() {
  level endon("game_ended");
  flag_wait("obj_VIP_dead");

  if(!isDefined(level.vip) || !is_equal(level.player, level.vip.lastattacker)) {
    return;
  }

  if(!isDefined(level.vo.var_d140ff9001fd4d0a)) {
    function_9d5a258818444673();
  }

  delay = growing_delay(15, 50, 4);
  level thread nag_wait("obj_laptop2_completed", level.vo.var_521cfe52d80d9e33, delay);
  wait 0.5;
  var_ad451464907eb97f = [level.vo.var_d140ff9001fd4d0a deck_draw(), level, 0.4, level.vo.var_446a88bbd47a4db4 deck_draw(), &function_e1d6b1bfe3bce7b9, level.player, 0.2, &function_e1d6b1bfe3bce7b9, level.vo.var_446a8bbbd47a544d deck_draw()];
  var_2e0fb9945519ab38 = [level.vo.var_89e7523508a990be deck_draw(), level, 0.3, level.vo.var_84fe31cdf65c01e9 deck_draw()];
  sequence = function_70386f0dbf01d6f4(var_ad451464907eb97f, var_2e0fb9945519ab38);
  level.player function_c9a09b3ba9c68f8d(0.3, sequence, 1, 3);
  flag_wait("obj_laptop2_completed");
  wait 0.5;
  var_fb8794bc8d9a042d = function_70386f0dbf01d6f4(level.vo.var_8b82e55e671353f3, level.vo.var_caa81b589676a6b8);
  level.player thread function_fc0eb6b81c66c661(0.4, var_fb8794bc8d9a042d deck_draw());
  alias = function_bdd45d18fa427efa();
  level.player function_fc0eb6b81c66c661(0.5, alias, 0, 10);

  if(!isDefined(level.vo.var_2589c21dbf99c514)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_rbrr_lasw_isuspecttheterminali";
    aliases[aliases.size] = "dx_cp_reso_rbrr_lasw_theterminalslocatedi";
    aliases[aliases.size] = "dx_cp_reso_rbrr_lasw_theterminalsinabunke";
    aliases[aliases.size] = "dx_cp_reso_rbrr_lasw_seeinanentrywayjustu";
    aliases[aliases.size] = "dx_cp_reso_rbrr_lasw_appearstobeabunkerbe";
    level.vo.var_2589c21dbf99c514 = create_deck(aliases);
  }

  if(!flag("obj_laptop3_completed")) {
    level thread function_a60fea4f51763a4f(["obj_laptop3_completed", "vo_spotted_security_building"], level.vo.var_2589c21dbf99c514, growing_delay(30, 50, 3));
    return;
  }

  level thread nag_wait("vo_entered_bunker", &function_bdd45d18fa427efa, growing_delay(30, 50, 3));
}

function function_bdd45d18fa427efa() {
  if(flag("obj_laptop3_completed")) {
    lines = function_70386f0dbf01d6f4(level.vo.var_59fb6ff91c509948, level.vo.var_156a3a3abdb8d03f);
  } else {
    lines = function_70386f0dbf01d6f4(level.vo.var_17efb5d0b30ec204, level.vo.var_e2953ad8c6586cb);
  }

  return lines deck_draw();
}

function function_44aa92d6e4b96295() {
  level endon("game_ended");
  level endon("obj_laptop3_completed");

  if(flag("obj_laptop3_completed")) {
    return;
  }

  thread function_dbf0c71d9c0ef7ce();
  thread function_83281cf463cbd265();

  if(!isDefined(level.vo.var_838822f029caa32f)) {
    level.vo.var_838822f029caa32f = create_deck(["dx_cp_reso_oeut_soap_imatasecuritybuildin", "dx_cp_reso_qdtc_soap_cominguponasecurityb", "dx_cp_reso_qdtc_soap_approachingasecurity", "dx_cp_reso_qdtc_soap_securityroomahead"]);
    level.vo.var_767ed0682a05ccb7 = create_deck(["dx_cp_reso_qbnr_soap_imoutsideabuildingac", "dx_cp_reso_mahv_soap_madeittoabuildingnea", "dx_cp_reso_mahv_soap_atastructureneartheb"]);
    level.vo.var_cb738a638f930a4a = create_deck(["dx_cp_reso_qbnr_lasw_iseeyoumoveinandchec", "dx_cp_reso_mahv_lasw_copyiseeyoucheckinsi", "dx_cp_reso_mahv_lasw_copyclearinandlookar", "dx_cp_reso_oeut_ghos_clearitandseewhatsin"]);
  }

  var_74a1c9ad4fab3339 = (-344, 6556, 709);
  function_8a487b265a8496ac(var_74a1c9ad4fab3339, 0.8, 0.4, 400);
  flag_set("vo_spotted_security_building");
  var_699db2a9620bd489 = function_70386f0dbf01d6f4(level.vo.var_838822f029caa32f deck_draw(), level.vo.var_767ed0682a05ccb7 deck_draw());
  sequence = [var_699db2a9620bd489, level, 0.6, level.vo.var_cb738a638f930a4a deck_draw()];
  level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 2);
}

function private function_9d5a258818444673() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_opnt_soap_hvisdown";
  aliases[aliases.size] = "dx_cp_reso_opnt_soap_gustevsdown";
  aliases[aliases.size] = "dx_cp_reso_opnt_soap_gothimlt";
  aliases[aliases.size] = "dx_cp_reso_opnt_soap_targetdown";
  level.vo.var_d140ff9001fd4d0a = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_opnt_lasw_gethisfobkey";
  aliases[aliases.size] = "dx_cp_reso_opnt_lasw_weneedhisfobkey";
  aliases[aliases.size] = "dx_cp_reso_opnt_lasw_pickuphisfobkeysoap";
  aliases[aliases.size] = "dx_cp_reso_opnt_ghos_getthekeyoffhimjohnn";
  level.vo.var_446a88bbd47a4db4 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_awzd_soap_workingonit";
  aliases[aliases.size] = "dx_cp_reso_awzd_soap_rog";
  aliases[aliases.size] = "dx_cp_reso_awzd_soap_solidcopy";
  aliases[aliases.size] = "dx_cp_reso_awzd_soap_imonit";
  level.vo.var_446a8bbbd47a544d = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_kydu_soap_targetdown";
  aliases[aliases.size] = "dx_cp_reso_kydu_soap_hviisoutcleanandquie";
  aliases[aliases.size] = "dx_cp_reso_kydu_soap_gustevdownforthecoun";
  aliases[aliases.size] = "dx_cp_reso_kydu_soap_hvisdown";
  level.vo.var_89e7523508a990be = create_deck(aliases);
  aliases = ["dx_cp_reso_kydu_lasw_welldone71moveinaget", "dx_cp_reso_kydu_lasw_smoothisfastsoapgeth", "dx_cp_reso_kydu_lasw_youllneedhisfobkeyto"];
  level.vo.var_84fe31cdf65c01e9 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_xocu_soap_gotit";
  aliases[aliases.size] = "dx_cp_reso_xocu_soap_gotthefobkey";
  aliases[aliases.size] = "dx_cp_reso_xocu_soap_keyacquired";
  aliases[aliases.size] = "dx_cp_reso_xocu_soap_keysecure";
  level.vo.var_8b82e55e671353f3 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_rtdx_soap_gotthefobkey";
  aliases[aliases.size] = "dx_cp_reso_rtdx_soap_grabbedthekey";
  aliases[aliases.size] = "dx_cp_reso_rtdx_soap_keyinhand";
  aliases[aliases.size] = "dx_cp_reso_rtdx_soap_gotthekey";
  level.vo.var_caa81b589676a6b8 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_terminalsinabunkerlo";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_soapyouneedtolocatet";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_findthebunkersoapter";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_pushtothebunkerandac";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_headtothebunkerconta";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_checkyourtacmapforth";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_pressuptothebunkeryo";
  aliases[aliases.size] = "dx_cp_reso_cjfh_ghos_gettothebunkerdoorte";
  aliases[aliases.size] = "dx_cp_reso_cjfh_ghos_bunkerjohnnynow";
  aliases[aliases.size] = "dx_cp_reso_cjfh_lasw_bunkersnext71accesst";
  level.vo.var_17efb5d0b30ec204 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_axpq_lasw_goodjob71terminalisi";
  aliases[aliases.size] = "dx_cp_reso_axpq_lasw_nicelydonebravo71hea";
  aliases[aliases.size] = "dx_cp_reso_axpq_ghos_gettothebunkerandacc";
  aliases[aliases.size] = "dx_cp_reso_axpq_lasw_terminalisinsideabun";
  level.vo.var_e2953ad8c6586cb = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_ngmx_ghos_gettotheopenbunkerjo";
  aliases[aliases.size] = "dx_cp_reso_ngmx_lasw_gettotheopenbunkeryo";
  aliases[aliases.size] = "dx_cp_reso_ngmx_lasw_headtotheopenbunker7";
  aliases[aliases.size] = "dx_cp_reso_ngmx_lasw_bunkersopen71youcana";
  level.vo.var_59fb6ff91c509948 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_tcib_ghos_bunkersopenandusbsin";
  aliases[aliases.size] = "dx_cp_reso_tcib_lasw_thebunkerisopenandyo";
  aliases[aliases.size] = "dx_cp_reso_tcib_lasw_thatsitheadtotheopen";
  aliases[aliases.size] = "dx_cp_reso_tcib_lasw_bunkersopengettothet";
  aliases[aliases.size] = "dx_cp_reso_tcib_ghos_bunkersopenlaswellsw";
  aliases[aliases.size] = "dx_cp_reso_tcib_lasw_bunkersopenheadinsid";
  level.vo.var_156a3a3abdb8d03f = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_xtkb_ghos_dontsleeponthatkeyjo";
  aliases[aliases.size] = "dx_cp_reso_xtkb_lasw_dontleavethefobkeybe";
  aliases[aliases.size] = "dx_cp_reso_xtkb_lasw_weneedhisfobkeytoacc";
  aliases[aliases.size] = "dx_cp_reso_xtkb_lasw_securehisfobkey";
  level.vo.var_521cfe52d80d9e33 = create_deck(aliases);
}

function private function_dbf0c71d9c0ef7ce() {
  level endon("game_ended");
  level endon("obj_laptop3_completed");
  wait 3;
  var_db985fba3eb25058 = (-305.62, 6732.61, 651.812);
  closestai = sortbydistance(getaiarrayinradius(var_db985fba3eb25058, 500), var_db985fba3eb25058);
  closestai = [closestai[0], closestai[1]];
  closestai[0] waittill("death");

  if(isalive(closestai[1])) {
    closestai[1] waittill("death");
  }

  var_75687123a6f1de49 = (-176.788, 6786.13, 696.508);
  function_ce1551245242a903(var_75687123a6f1de49, 0.95, 0.4, 600);
  sequence = [level.soap, "dx_cp_reso_ipoi_soap_roomclear", level.laswell, 0.4, "dx_cp_reso_ipoi_lasw_searchit"];
  level.player function_c9a09b3ba9c68f8d(0.3, sequence, 0, 3, 0);
  wait 1;
  var_b559870e6fc576ee = (-148.351, 6678.31, 696.508);
  function_ce1551245242a903(var_b559870e6fc576ee, 0.95, 0.3, 300);
  flag_set("vo_found_door_controls");

  if(!isDefined(level.vo.var_3b3c39e6efd5151d)) {
    aliases = ["dx_cp_reso_thus_lasw_headonaswivelforanyt", "dx_cp_reso_thus_lasw_asecuritybuildingmig", "dx_cp_reso_thus_lasw_keeplookingitscloset"];
    level.vo.var_3b3c39e6efd5151d = create_deck(aliases);
  }

  level thread nag_wait("obj_laptop3_completed", level.vo.var_3b3c39e6efd5151d, growing_delay(30, 50, 3));
}

function private function_83281cf463cbd265() {
  level endon("game_ended");
  var_7ea53598c0664c8b = [];
  var_7ea53598c0664c8b[var_7ea53598c0664c8b.size] = level.vo.var_18ea8b639c52b904;
  var_7ea53598c0664c8b[var_7ea53598c0664c8b.size] = level.vo.var_2061cec0f96818c7;
  var_7ea53598c0664c8b[var_7ea53598c0664c8b.size] = level.vo.var_dd008c6d0aeebf02;

  if(!isDefined(level.vo.var_221281bd09724a5b)) {
    level.vo.var_221281bd09724a5b = create_deck(["dx_cp_reso_hngn_soap_thebunkerdoorisopeni", "dx_cp_reso_hngn_soap_bunkerdooropenedrigh", "dx_cp_reso_hngn_soap_bunkersopenwatcher"]);
    level.vo.var_77194619da1fbc94 = create_deck(["dx_cp_reso_htxd_soap_justopenedthebunkerd", "dx_cp_reso_htxd_soap_thebunkerdoorisopeni", "dx_cp_reso_htxd_soap_justopenedthebunker"]);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_jsnb_lasw_weneedthatfobkeyhead";
    aliases[aliases.size] = "dx_cp_reso_jsnb_lasw_takedownthehviforhis";
    aliases[aliases.size] = "dx_cp_reso_jsnb_lasw_findgustevandtakehis";
    aliases[aliases.size] = "dx_cp_reso_jsnb_lasw_youcannotaccessthatt";
    level.vo.var_ef6b0cac86f726ef = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_uvcs_ghos_getintothebunkerjohn";
    aliases[aliases.size] = "dx_cp_reso_uvcs_lasw_gettotheterminalinth";
    aliases[aliases.size] = "dx_cp_reso_uvcs_lasw_moveintothebunkerand";
    aliases[aliases.size] = "dx_cp_reso_uvcs_lasw_melenasterminalisint";
    level.vo.var_beea6fb7db91ca18 = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_xyza_lasw_cleanwork71headintot";
    aliases[aliases.size] = "dx_cp_reso_xyza_lasw_gointothebunkerandac";
    aliases[aliases.size] = "dx_cp_reso_xyza_lasw_almostthere71enterth";
    level.vo.var_34238562c1a04fc6 = create_deck(aliases);
  }

  flag_wait("obj_laptop3_completed");
  flag_set("vo_found_door_controls");
  alias = function_70386f0dbf01d6f4(level.vo.var_77194619da1fbc94 deck_draw(), level.vo.var_221281bd09724a5b deck_draw());
  level.player function_c9a09b3ba9c68f8d(0.4, [alias, level, 0.6, "dx_cp_reso_ddzl_ghos_copy"], 1, 1);
  wait 1;
  var_17b8f577ed0b658 = undefined;

  if(flag("obj_laptop2_completed")) {
    sequence = function_70386f0dbf01d6f4(level.vo.var_beea6fb7db91ca18 deck_draw(), level.vo.var_34238562c1a04fc6 deck_draw());
    level function_fc0eb6b81c66c661(0.3, sequence, 1);
    return;
  }

  level endon("obj_laptop2_completed");

  while(flag("stealth_spottted")) {
    flag_waitopen("stealth_spottted");
    wait 5;
  }

  sequence = ["dx_cp_reso_eysc_ghos_roggetafterthathvi", level.laswell, 0.3, "dx_cp_reso_eysc_lasw_youllneedhisfobkeyon", level.soap, 0.2, "dx_cp_reso_eysc_soap_copyneedthehvitoproc"];
  level function_c9a09b3ba9c68f8d(0.4, sequence, 0, 10);
  wait 20;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(2, 1, 1))) {
      wait 1;
    }

    result = level.ghost say_delayed(0.5, "dx_cp_reso_eysc_ghos_doorsopenjohnnyexecu", 0, 3);
    waitframe();
  }

  wait 30;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(2, 1, 1))) {
      wait 1;
    }

    result = level.ghost say_delayed(0.5, "dx_cp_reso_eysc_lasw_pursuethehviforhisfo", 0, 3);
    waitframe();
  }
}

function function_eda7d8016eafb64e() {
  level endon("game_ended");
  thread function_a9419fdf6de00a17();
  flag_wait("obj_laptops_all_completed");
  flag_wait("obj_hack_terminal_completed");
  wait 0.5;
  sequence = [level.soap, "dx_cp_reso_kagq_soap_alrightterminalsboot"];
  level.player function_c9a09b3ba9c68f8d(0.5, sequence, 0, 1);
  wait 1;
  sequence = ["dx_cp_reso_yfik_lasw_goodworksoap", level.laswell, 0.2, "dx_cp_reso_yfik_lasw_iseemultipleaccounts", level.ghost, 0.4, "dx_cp_reso_yfik_ghos_sigintshowsmultiplec", level.soap, 0.5, "dx_cp_reso_yfik_soap_milenamustbeinside", level.laswell, 0.3, "dx_cp_reso_yfik_lasw_weneedherfaceeyespri", level.ghost, 0.2, "dx_cp_reso_yfik_ghos_checksoaprallyatthem", level.laswell, 0.4, "dx_cp_reso_yfik_lasw_konnillprotectmilena", level.soap, 0.3, "dx_cp_reso_yfik_soap_tothedeathitisletsdo"];
  level.player function_c9a09b3ba9c68f8d(0.3, sequence, 1);
  flag_set("bunker_terminal_vo_completed");
}

function private function_a9419fdf6de00a17() {
  level endon("game_ended");
  level endon("obj_hack_terminal_completed");

  if(flag("obj_hack_terminal_completed")) {
    return;
  }

  flag_wait_either("flag_visit_bunker", "obj_laptop3_completed");

  if(!flag("obj_laptop3_completed")) {
    thread function_7dde69e6ecc7d784();
  }

  flag_wait("obj_laptop3_completed");
  flag_wait("is_in_bunker");
  flag_set("vo_entered_bunker");

  while(!flag("obj_laptop2_completed")) {
    if(!isDefined(level.vo.var_2068ca955246b78f)) {
      aliases = ["dx_cp_reso_jsnb_lasw_youcannotaccessthatt", "dx_cp_reso_eysc_lasw_youneedthehviandhisu", "dx_cp_reso_eysc_lasw_pursuethehviforhisfo"];
      level.vo.var_2068ca955246b78f = create_deck(aliases);
    }

    level function_bace8af56ef0688b("is_in_bunker", level.vo.var_2068ca955246b78f, growing_delay(0, 15, 3));
    flag_wait("is_in_bunker");
  }

  wait 0.3;
  thread function_572565823b3516c3();

  if(flag("stealth_spotted")) {
    sequence = ["dx_cp_reso_kagq_soap_iminthebunker", level.laswell, 0.3, "dx_cp_reso_kagq_lasw_clearitbeforeaccessi"];
    level.player function_c9a09b3ba9c68f8d(0.4, sequence, 0, 3);
    flag_waitopen("stealth_spotted");

    if(flag("is_in_bunker") && !flag("obj_hack_terminal_completed")) {
      sequence = ["dx_cp_reso_wwzk_soap_roomclear", level.laswell, 0.4, "dx_cp_reso_mruc_lasw_copyaccessthetermina"];
      level.player function_c9a09b3ba9c68f8d(0.4, sequence, 0, 3);
    }
  } else {
    sequence = ["dx_cp_reso_mruc_soap_allstationsinsidethe", level.laswell, 0.4, "dx_cp_reso_mruc_lasw_copyaccessthetermina"];
    level.player function_c9a09b3ba9c68f8d(0.4, sequence, 0, 3, 1);
  }

  if(!isDefined(level.vo.var_ff7181f43b40438f)) {
    aliases = ["dx_cp_reso_yqan_lasw_accesstheterminalsoa", "dx_cp_reso_kagq_lasw_fobkeygetsyouin", "dx_cp_reso_yqan_lasw_usethekeytoaccessthe", "dx_cp_reso_kagq_lasw_usethefobkeyforacces", "dx_cp_reso_yqan_lasw_findtheterminal71"];
    level.vo.var_ff7181f43b40438f = create_deck(aliases);
  }

  level nag_wait("obj_hack_terminal_completed", level.vo.var_ff7181f43b40438f, growing_delay(10, 20, 3));
}

function private function_7dde69e6ecc7d784() {
  level endon("game_ended");
  level endon("obj_laptops_all_completed");
  level endon("obj_hack_terminal_completed");

  if(!flag("vo_spotted_security_building")) {
    var_ad451464907eb97f = ["dx_cp_reso_xyza_soap_attheterminalbunkerd", &function_e7ad302029b57aec, level.laswell, 0.2, "dx_cp_reso_xyza_lasw_mustopenfromsomewher", &function_e7ad302029b57aec, level.ghost, 0.4, "dx_cp_reso_xyza_ghos_securityhouseoracont", &player_spotted, &function_e7ad302029b57aec, level.soap, 0.4, "dx_cp_reso_xyza_soap_thatdbemybet", &function_e7ad302029b57aec, level.laswell, 0.3, "dx_cp_reso_xyza_lasw_goodcallbravolocatei"];
    var_2e0fb9945519ab38 = ["dx_cp_reso_ojrx_soap_attheterminalbunkerd", &function_e7ad302029b57aec, level.laswell, 0.2, "dx_cp_reso_ojrx_lasw_mustopenfromsomewher", &function_e7ad302029b57aec, level.ghost, 0.4, "dx_cp_reso_ojrx_ghos_securityhouseoracont", &function_a4e4a9fc80e228fd, &function_e7ad302029b57aec, level.soap, 0.4, "dx_cp_reso_ojrx_soap_thatdbemybet", &function_e7ad302029b57aec, level.laswell, 0.3, "dx_cp_reso_ojrx_lasw_goodcallbravolocatei"];
    sequence = function_70386f0dbf01d6f4(var_ad451464907eb97f, var_2e0fb9945519ab38);
    level.player function_c9a09b3ba9c68f8d(0.3, sequence, 0, 10);
  }

  flag_wait("obj_laptop2_completed");
  wait 10;

  if(!isDefined(level.vo.var_218eb3e622d72259)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_dffd_lasw_findawaytoopenthatbu";
    aliases[aliases.size] = "dx_cp_reso_dffd_lasw_fobkeysecurednowgett";
    aliases[aliases.size] = "dx_cp_reso_dffd_lasw_youneedtoopenthebunk";
    aliases[aliases.size] = "dx_cp_reso_dffd_lasw_youneedtogetthebunke";
    level.vo.var_218eb3e622d72259 = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_dffn_lasw_niceworkneedtofindaw";
    aliases[aliases.size] = "dx_cp_reso_dffn_lasw_goodjobwiththefobkey";
    aliases[aliases.size] = "dx_cp_reso_dffn_lasw_needtoopenthebunkerd";
    aliases[aliases.size] = "dx_cp_reso_dffn_lasw_terminalsinsidethebu";
    level.vo.var_45acbdb9ba5e9946 = create_deck(aliases);
  }

  var_4943a5bbcbc231f7 = [ &function_70386f0dbf01d6f4, level.vo.var_218eb3e622d72259, level.vo.var_45acbdb9ba5e9946];
  level nag_wait("vo_found_door_controls", var_4943a5bbcbc231f7, growing_delay(30, 90, 4));
}

function function_e7ad302029b57aec() {
  bunker_door = (267.974, 5745.09, 525.375);
  distsq = squared(600);

  if(distancesquared(level.player.origin, bunker_door) > distsq) {
    return 0;
  }
}

function private function_82bb32827092c1b9() {
  level endon("game_ended");
  level endon("is_in_bunker");
}

function function_7c1f1411fabbf624() {
  level endon("game_ended");
  thread function_cd002e184a77ba6c();
  flag_wait("obj_laptops_all_completed");
  flag_wait("obj_hack_terminal_completed");
  wait 4;
  thread function_bb17d135941fa3e0();
  thread function_5bb7c8621386b075();
  thread function_9ac8ff196b51965a();
  childthread function_e7fc55aeb89aac65();
}

function function_cd002e184a77ba6c() {
  level endon("game_ended");
  level endon("obj_hack_terminal_completed");
  level.player endon("death");

  if(!isDefined(level.vo.var_4a28b72b21649903)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_szve_lasw_wedontneedmilenaasof";
    aliases[aliases.size] = "dx_cp_reso_szve_lasw_mansionisnothingwith";
    aliases[aliases.size] = "dx_cp_reso_szve_lasw_weneedtheterminalbef";
    aliases[aliases.size] = "dx_cp_reso_szve_lasw_thepriorityisaccessi";
    aliases[aliases.size] = "dx_cp_reso_ceic_lasw_weneedtogetintotheac";
    aliases[aliases.size] = "dx_cp_reso_ceic_lasw_soapyouneedtoaccesst";
    level.vo.var_4a28b72b21649903 = create_deck(aliases);
  }

  delay = growing_delay(2, 30, 3);

  while(true) {
    wait 1.5;

    if(level.player.origin[0] < 2000 || level.player.origin[2] < 600) {
      continue;
    }

    init_drone_vo();

    if(!flag("drone_reinforcements_exhausted") && !flag("vo_did_drone_warning")) {
      sequence = array_add(level.vo.var_5158f4b6f347eef deck_draw(), &function_6e3c0899c41a66e0);
      level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 5);
      flag_set("vo_did_drone_warning");
      wait 3;
    }

    result = level.laswell function_fc0eb6b81c66c661(0.3, level.vo.var_4a28b72b21649903 deck_draw(), 0, 2);

    if(!istrue(result)) {
      continue;
    }

    waitfor(delay);
  }
}

function function_19822d165a3b5bf2() {
  sequence = ["dx_cp_reso_lcd2_lasw_shepherdsintelonmile", level.ghost, 0.4, "dx_cp_reso_lcd2_ghos_thenwetakehimdown", level.laswell, 0.3, "dx_cp_reso_lcd2_lasw_hemayleadustoher", level.soap, 0.3, "dx_cp_reso_lcd2_soap_copythat"];
  level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 10);
}

function function_9ac8ff196b51965a() {
  level endon("game_ended");
  flag_wait("flag_parking_area");
  wait 1;

  if(!isDefined(level.vo.var_66a1156521ee6dea)) {
    aliases = ["dx_cp_reso_notu_lasw_jltvscomingatyousoap", "dx_cp_reso_notu_lasw_jltvsrollingin", "dx_cp_reso_notu_lasw_watchit71trucksjustr"];
    level.vo.var_66a1156521ee6dea = create_deck(aliases);
  }

  level.player function_fc0eb6b81c66c661(0.3, level.vo.var_66a1156521ee6dea deck_draw(), 0, 5);
}

function function_48d32299a6dcca24() {
  level endon("game_ended");
  level endon("flag_code_completed");

  if(flag("flag_code_completed")) {
    return;
  }

  if(!isDefined(level.vo.var_3297b17ca88e3148)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_zefg_lasw_seeifhesgotakeycard";
    aliases[aliases.size] = "dx_cp_reso_zefg_ghos_thecaptainllhaveakey";
    aliases[aliases.size] = "dx_cp_reso_zefg_lasw_searchhimheslikelyto";
    aliases[aliases.size] = "dx_cp_reso_zefg_lasw_takehiskeycard";
    aliases[aliases.size] = "dx_cp_reso_twrh_ghos_captainskeycardwillo";
    aliases[aliases.size] = "dx_cp_reso_twrh_lasw_checkforakeycardsoap";
    aliases[aliases.size] = "dx_cp_reso_twrh_lasw_captainskeycardshoul";
    level.vo.var_3297b17ca88e3148 = create_deck(aliases);
  }

  delay = growing_delay(0, 30, 3);

  while(true) {
    alias = level.vo.var_3297b17ca88e3148 deck_draw();
    level.player function_fc0eb6b81c66c661(0.3, alias, 0, 2);
    waitfor(delay);
  }
}

function function_2ae506c2b163c044() {
  level endon("game_ended");
}

function function_bb17d135941fa3e0() {
  level endon("game_ended");
  result = 0;

  while(isDefined(result) && !result) {
    while(flag("stealth_combat") || !flag("is_in_garage")) {
      flag_waitopen("stealth_combat");
      flag_wait("is_in_garage");
    }

    wait 1;
    sequence = ["dx_cp_reso_itub_soap_bythebloodysaints", level.ghost, 0.3, "dx_cp_reso_itub_ghos_whatareyouonaboutjoh", level.soap, 0.4, "dx_cp_reso_itub_soap_itslikeafreakincarmu", level.ghost, 0.2, "dx_cp_reso_itub_ghos_marryyourselfanoliga", level.laswell, 0.3, "dx_cp_reso_itub_lasw_milenawontbeinthemoo"];
    result = level.player function_c9a09b3ba9c68f8d(0.3, sequence, 0, 2);
    waitframe();
  }
}

function init_drone_vo() {
  if(isDefined(level.vo.var_5158f4b6f347eef)) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = ["dx_cp_reso_dtf1_lasw_headsupbravoimseeing", 0.3, "dx_cp_reso_dtf1_ghos_eyeshighjohnnydustem", 0.3];
  aliases[aliases.size] = ["dx_cp_reso_dtf3_lasw_imseeingdronesincomi", 0.3, "dx_cp_reso_dtf3_ghos_konnisturningupthehe", 0.3];
  aliases[aliases.size] = ["dx_cp_reso_dtf4_lasw_konnijustturnedupthe", 0.3, "dx_cp_reso_dtf4_ghos_bringemdownjohnny", 0.3];
  level.vo.var_5158f4b6f347eef = create_deck(aliases);
  aliases = ["dx_cp_reso_dtf1_soap_rogerlt", "dx_cp_reso_dtf3_soap_copythat", "dx_cp_reso_dtf3_soap_thanksfortheupdate"];
  level.vo.var_104278c7704353bc = create_deck(aliases);
  aliases = ["dx_cp_reso_dtf1_soap_rogerthatlt", "dx_cp_reso_dtf2_soap_copythat", "dx_cp_reso_dtf2_soap_rog"];
  level.vo.var_fb61fe9209c6ac24 = create_deck(aliases);
  aliases = ["dx_cp_reso_made_soap_christssake", "dx_cp_reso_qdqu_soap_dronesaredivebombing", "dx_cp_reso_made_soap_fuckinhell"];
  level.vo.var_9d300e933f37993d = create_deck(aliases);
}

function function_5bb7c8621386b075() {
  level endon("game_ended");
  init_drone_vo();
  flag_wait("bunker_terminal_vo_completed");
  flag_wait("mansion_drones_released");

  while(level.player.origin[0] < 2000 || level.player.origin[2] < 600) {
    wait 0.2;
  }

  if(!flag("drone_reinforcements_exhausted") && !flag("vo_did_drone_warning")) {
    sequence = array_add(level.vo.var_5158f4b6f347eef deck_draw(), &function_6e3c0899c41a66e0);
    level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 5);
    flag_set("vo_did_drone_warning");
    wait 3;
  }

  childthread function_a1709a9b1f7cbe04();
  level waittill("drone_attacking_player");
  level function_fc0eb6b81c66c661(0.3, "dx_cp_reso_qdqu_lasw_watchthosedrones71");

  while(true) {
    level waittill("drone_exploded_on_proximity");
    result = level.player function_fc0eb6b81c66c661(0.2, level.vo.var_9d300e933f37993d deck_draw(), 0, 1);

    if(istrue(result)) {
      wait 10;
    }
  }
}

function function_7fc6cf9163b1c819() {
  return flag("drone_reinforcements_exhausted") ? "dx_cp_reso_gwu4_ghos_solidcopy" : "dx_cp_reso_modc_ghos_copykillingthepowers";
}

function function_eb45bca194636705() {
  if(flag("mansion_cleared")) {
    return 0;
  }
}

function function_e7fc55aeb89aac65() {
  while(level.player.origin[0] < 3060 || level.player.origin[0] > 4090 || level.player.origin[1] > 3715 || level.player.origin[1] < 3150) {
    waitframe();
  }

  flag_set("entered_mansion");
  thread function_8615a6b7cd263577();
  var_f6fb65b0d63b682b = ["dx_cp_reso_modc_soap_mainhousemovinginter", level.laswell, 0.3, "dx_cp_reso_modc_lasw_copybeadvisedilllose", level.soap, 0.2, "dx_cp_reso_modc_soap_checkwheresromanova"];
  var_20bb55124792b19b = ["dx_cp_reso_modc_soap_iminsidewheresromano"];
  var_f6fb66b0d63b6a5e = [level.laswell, 0.4, "dx_cp_reso_modc_lasw_holedupinherofficeth", level.soap, 0.3, "dx_cp_reso_modc_soap_howdowebreachit", level.laswell, 0.2, "dx_cp_reso_modc_lasw_ghostifyoucutpowerto", level.ghost, 0.2, &function_7fc6cf9163b1c819, &function_eb45bca194636705, level.laswell, 0.4, "dx_cp_reso_modc_lasw_evenifwedogettoroman", level.soap, 0.3, "dx_cp_reso_modc_soap_theyllstopwhentheyre", level.laswell, 0.4, "dx_cp_reso_modc_lasw_goodpointsoapyouknow", level.soap, 0.3, "dx_cp_reso_modc_soap_cleanandclearwatcher"];
  var_f6fb65b0d63b682b = flag("stealth_combat") ? var_20bb55124792b19b : var_f6fb65b0d63b682b;
  sequence = array_combine(var_f6fb65b0d63b682b, var_f6fb66b0d63b6a5e);
  level.player function_c9a09b3ba9c68f8d(0.3, sequence, 1, 3);
  thread function_e10c8018afc445ca();
  flag_wait("mansion_cleared");
  wait 3;
  sequence = [level, "dx_cp_reso_moon_ghos_allstationspowerisdo", &function_5dfc44f277853863, level.soap, 0.3, "dx_cp_reso_moon_soap_rightontimepoptheloc", level.laswell, 0.3, "dx_cp_reso_moon_lasw_onitstandby", 0.3, &unlock_door, level.laswell, 0.2, "dx_cp_reso_moon_lasw_doorsopenboyswerein", level.ghost, 0.3, "dx_cp_reso_moon_ghos_seeyouinsidejohnny"];
  level function_c9a09b3ba9c68f8d(0.3, sequence);
  aliases = [];
  aliases[aliases.size] = "dx_cp_reso_odn2_ghos_headinsidejohnny";
  aliases[aliases.size] = "dx_cp_reso_odn2_lasw_getinthatroomsoapits";
  aliases[aliases.size] = "dx_cp_reso_odn2_lasw_romanovasdoorisunloc";
  aliases[aliases.size] = "dx_cp_reso_odn2_ghos_johnnygetinthatroomi";
  level nag_wait("obj_hack_door_completed", aliases, growing_delay(5, 15, 4));
}

function function_8615a6b7cd263577() {
  wait 1;
  setmusicstate("mx_resort_exfil_end");
}

function function_5dfc44f277853863() {
  if(!flag("drone_reinforcements_exhausted")) {
    return [level.laswell, 0.4, "dx_cp_reso_moon_lasw_copythatdronesareout"];
  }
}

function unlock_door() {
  flag_set("vo_mansion_door_unlock");
  level play_sound_in_space("jup_oli_door_final_unlock", (3247, 3343, 1065));
}

function function_6e3c0899c41a66e0() {
  if(flag("stealth_combat")) {
    return level.vo.var_fb61fe9209c6ac24 deck_draw();
  }

  return level.vo.var_104278c7704353bc deck_draw();
}

function function_e10c8018afc445ca() {
  if(flag("mansion_cleared")) {
    return;
  }

  level endon("mansion_cleared");
  flag_wait("mansion_ai_spawned");
  wait 3;
  wait 5;
  sequence = ["dx_cp_reso_mkc2_soap_ghostwhatsthepowerup", level.ghost, 0.3, "dx_cp_reso_mkc2_ghos_breakerslocatedstayo"];
  level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 3);
  wait 10;

  if(!flag("drone_reinforcements_exhausted")) {
    sequence = ["dx_cp_reso_mdc1_soap_killingthesecuritysy", level.ghost, 0.2, "dx_cp_reso_mdc1_ghos_fingerscrossed"];
    level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 3);
    wait 15;
  }

  sequence = ["dx_cp_reso_mkc3_soap_ltgimmeasitrep", level.ghost, 0.3, "dx_cp_reso_mkc3_ghos_nearlydonekeeppressi"];
  level function_c9a09b3ba9c68f8d(0.3, sequence, 0, 3);
}

function function_58c67f2d814c01b1() {
  level endon("game_ended");
}

function function_1497fbfc6507c390() {
  if(!isDefined(level.var_92f743cb89a89d0e) || time_has_passed(level.var_92f743cb89a89d0e, 15)) {
    if(isDefined(level.vo.var_fe09a2981f15fbdc) == 0) {
      aliases = [];
      aliases[aliases.size] = "dx_cp_reso_jgwe_soap_downedadrone";
      aliases[aliases.size] = "dx_cp_reso_jgwe_soap_dronedown";
      aliases[aliases.size] = "dx_cp_reso_jgwe_soap_dronesdown";
      aliases[aliases.size] = "dx_cp_reso_jgwe_soap_anotherdrowndown";
      level.vo.var_fe09a2981f15fbdc = create_deck(aliases);
    }

    level.player say_team(level.vo.var_fe09a2981f15fbdc deck_draw(), 0, 0.5);
    level.var_92f743cb89a89d0e = gettime();
  }
}

function private function_47b24c74306093dc(var_6a9570728c63dca3, var_60e0f7f9862bdc27, var_a3f325deae21cea8) {
  level endon("game_ended");

  while(true) {
    flag_wait(var_6a9570728c63dca3);
    wait 0.5;
    var_17b8f577ed0b658 = function_70386f0dbf01d6f4(var_60e0f7f9862bdc27, var_a3f325deae21cea8);
    result = level.player say_sequence(var_17b8f577ed0b658, 0, 1, 0, 0.5);

    if(istrue(result)) {
      return;
    }

    flag_clear(var_6a9570728c63dca3);
    wait 2;
  }
}

function function_19c7d50f5ca3775b() {
  level endon("game_ended");
}

function private function_ef9691bc35d8ffbe() {
  if(!isDefined(level.vo.var_5ee73522648ed48a)) {
    level.vo.var_5ee73522648ed48a = create_deck(["dx_cp_reso_vbxb_lasw_staysharpyoureapproa", "dx_cp_reso_vbxb_lasw_soapyougotenemiesnea", "dx_cp_reso_vbxb_lasw_seeingmultiplehostil"]);
    level.vo.var_9ea03a8fe18b6efc = create_deck(["dx_cp_reso_dwep_lasw_soapyougotenemiesinc", "dx_cp_reso_dwep_lasw_71yougotshooterscomi", "dx_cp_reso_dwep_lasw_theyremovingyourways"]);
  }

  while(true) {
    while(getaiarrayinradius(level.player.origin, 1000).size < 3) {
      wait 0.5;
    }

    wait 0.5;
    lines = function_70386f0dbf01d6f4(level.vo.var_5ee73522648ed48a, level.vo.var_9ea03a8fe18b6efc);
    result = level function_fc0eb6b81c66c661(1, lines deck_draw(), 0, 2);
    delay = !isDefined(result) || result ? 60 : 15;
    wait delay;
  }
}

function vo_death() {
  level endon("game_ended");
  deathBy = namespace_96731f4d002634f6::function_69fa4a2561ada985("deathBy");
  vo = level.vo.var_da7b24b2f25e8a4e;

  if(isDefined(deathBy)) {
    switch (deathBy) {
      case #"hash_36b7174a04de8799":
        vo = level.vo.var_2217a4a74754ebd5;
        break;
      case #"hash_9fb1b3b793776417":
        vo = level.vo.var_3cc4ed83f3a97f5b;
        break;
      case #"hash_d63ab45faf622239":
        vo = level.vo.var_8a669e7961f76a1d;
        break;
      case #"hash_980e3152db2cdc0":
        vo = level.vo.var_fd87f5189d559bd4;
        break;
      case #"hash_df787120eae73295":
        vo = level.vo.var_66daa628fe3f10e9;
        break;
      case #"hash_e224d0b635d0dadd":
        vo = level.vo.var_7392ea26d2490ea9;
        break;
      case #"hash_dfc15a20eb20f9f1":
        vo = level.vo.var_66f97f28fe610d05;
        break;
    }
  }

  if(vo.size > 0) {
    level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, vo);
    level.player say_team(vo, 1, 2, 0, 1);
  }
}

function function_b66949e28f8b252c() {}

function function_684319b18c66ff02() {
  if(!isDefined(level.vo.var_1bb982edd8dc04d3)) {
    aliases = ["dx_cp_reso_qrfl_lasw_allstationseyeshighw", "dx_cp_reso_akbf_ghos_eyesonthekonniheloso", "dx_cp_reso_otin_lasw_beadvisedakonnireinf", "dx_cp_reso_udth_lasw_youvegotakonniheloin"];
    level.vo.var_1bb982edd8dc04d3 = create_deck(aliases);
  }

  wait 1;

  if(isDefined(level.var_bc5be9d1d84ada9a) && !time_has_passed(level.var_bc5be9d1d84ada9a, 45)) {
    return;
  }

  level.var_bc5be9d1d84ada9a = gettime();
  level.laswell thread function_fc0eb6b81c66c661(0.3, level.vo.var_1bb982edd8dc04d3 deck_draw(), 0, 2);
}

function function_354580fc952dbcdc() {
  level.laswell say_team("dx_cp_reso_notu_lasw_nomovementoutsideyou");
  level.ghost say_team("dx_cp_reso_ceic_ghos_letsnotwaisttimejohn");
}

function function_14253eea24df30e2() {
  level endon("game_ended");
  level endon("entered_mansion");
  level.player waittill("ascender_device_pickedup");

  if(!isDefined(level.vo.var_d89432b6c9875b5)) {
    level.vo.var_d89432b6c9875b5 = create_deck(["dx_cp_reso_zaqa_soap_foundanascender", "dx_cp_reso_zaqa_soap_pickedupanascender", "dx_cp_reso_jtjw_soap_foundanascender", "dx_cp_reso_zaqa_soap_gotanascenderhere"]);
    level.vo.var_f4a7c71385e04030 = create_deck(["dx_cp_reso_zaqa_lasw_couldbeuseful", "dx_cp_reso_zaqa_ghos_alwaysanicefind", "dx_cp_reso_zaqa_lasw_keepityoumayneedit"]);
  }

  sequence = [level.vo.var_d89432b6c9875b5 deck_draw(), level.laswell, 0.3, level.vo.var_f4a7c71385e04030 deck_draw()];
  level.player function_c9a09b3ba9c68f8d(0.4, sequence, 0, 4);
}

function function_6e723dc45133badb() {
  level endon("entered_mansion");

  if(!isDefined(level.vo.var_475013d72f6a8dfc)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_iabq_soap_makinentry";
    aliases[aliases.size] = "dx_cp_reso_iabq_soap_movinginterior";
    aliases[aliases.size] = "dx_cp_reso_iabq_soap_inside";
    aliases[aliases.size] = "dx_cp_reso_iabq_soap_interiornow";
    level.vo.var_475013d72f6a8dfc = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_wwzk_lasw_sweepforanythingwema";
    aliases[aliases.size] = "dx_cp_reso_pqxx_ghos_clearitandsweepforam";
    aliases[aliases.size] = "dx_cp_reso_pqxx_ghos_rogtakeanythingusefu";
    aliases[aliases.size] = "dx_cp_reso_uvzm_lasw_sweepforanythingusef";
    aliases[aliases.size] = "dx_cp_reso_cvys_ghos_sweepitforanythingth";
    level.vo.var_db35d7a19e309b57 = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_uvzm_soap_exiting";
    aliases[aliases.size] = "dx_cp_reso_uvzm_soap_movingexterior";
    aliases[aliases.size] = "dx_cp_reso_uvzm_soap_outside";
    aliases[aliases.size] = "dx_cp_reso_uvzm_soap_leavingthestructure";
    level.vo.var_6072167c0e2e6466 = create_deck(aliases);
    level.vo.var_cd6ca19457ecf7d1 = create_deck(["dx_cp_reso_wsee_lasw_copyiseeyou", "dx_cp_reso_fnmh_lasw_copy", 0]);
  }

  while(true) {
    wait 10;

    if(flag("player_in_building")) {
      continue;
    }

    flag_wait("player_in_building");

    if(!flag("stealth_spotted")) {
      sequence = [level.vo.var_475013d72f6a8dfc deck_draw(), level, 0.3, level.vo.var_db35d7a19e309b57 deck_draw()];
      function_c9a09b3ba9c68f8d(0.6, sequence, 0, 0.6);
    }

    wait 5;

    if(!flag("player_in_building")) {
      continue;
    }

    flag_waitopen("player_in_building");

    if(!flag("stealth_spotted")) {
      sequence = [level.vo.var_6072167c0e2e6466 deck_draw(), level, 0.3, level.vo.var_cd6ca19457ecf7d1 deck_draw()];
      function_c9a09b3ba9c68f8d(0.6, sequence, 0, 0.6);
    }
  }
}

function function_4bc62ec0304bd2e7() {
  level endon("game_ended");
  namespace_96731f4d002634f6::function_d14fcd3a04720601("trig_bungalow");
}

function function_2cef8fa07cd294c5() {
  level endon("game_ended");
  flag_wait_any("spotted_speedboats_left", "spotted_speedboats_right");
}

function function_fdc445c5ebb7f83e() {
  level endon("game_ended");
  level endon("entered_mansion");
  flag_wait("trig_cave_enter");
  sequence = [level.soap, "dx_cp_reso_uhtj_soap_searchingthecavefarw", level, 0.5, "dx_cp_reso_uhtj_lasw_illlosevisualwillrel"];
  level function_c9a09b3ba9c68f8d(0.7, sequence, 0, 5);
  wait 2;
  result = 0;

  while(isDefined(result) && !result) {
    while(!function_34fed8580660aeef()) {
      wait 2;
    }

    sequence = [ &function_34fed8580660aeef, level.soap, "dx_cp_reso_uhtj_soap_darkinhere", level.ghost, 0.6, "dx_cp_reso_uhtj_ghos_goodupdateisthewater", level.soap, 0.3, "dx_cp_reso_uhtj_soap_checkingstandby", level.laswell, 0.5, "dx_cp_reso_uhtj_lasw_goodtohavealaughwhil"];
    result = level function_c9a09b3ba9c68f8d(0.4, sequence, 0, 1);
    waitframe();
  }

  flag_set("vo_cleared_cave");
}

function function_34fed8580660aeef() {
  var_52b97f24a2ad6754 = (-3326.45, 4693.07, 155.466);
  distsq = squared(1000);
  return distancesquared(var_52b97f24a2ad6754, level.player.origin) < distsq;
}

function function_1a08ad97946816c2() {
  level endon("entered_mansion");
  result = 0;

  while(isDefined(result) && !result) {
    while(!flag("sweeping_beach") || flag("stealth_spotted")) {
      if(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 5;
      }

      flag_wait("sweeping_beach");
    }

    sequence = ["dx_cp_reso_ddzl_soap_sweepingthebeach", level.laswell, 0.2, "dx_cp_reso_kiin_lasw_whenshadowscoutedthe", level.soap, 0.4, "dx_cp_reso_kiin_soap_copythatmightcomeinh"];
    result = level.player function_c9a09b3ba9c68f8d(0.8, sequence, 0, [level, "sweeping_beach"]);
    waitframe();
  }

  wait 10;
  result = 0;

  while(isDefined(result) && !result) {
    while(!flag("sweeping_beach") || flag("stealth_spotted")) {
      if(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 5;
      }

      flag_wait("sweeping_beach");
    }

    sequence = ["dx_cp_reso_epqi_soap_laswellyouprefermoun", level.laswell, 0.3, "dx_cp_reso_epqi_lasw_doihavetochose", level.ghost, 0.6, "dx_cp_reso_epqi_ghos_littleoboththatsthew"];
    result = level.player function_c9a09b3ba9c68f8d(0.8, sequence, 0, [level, "sweeping_beach"]);
    waitframe();
  }

  wait 10;
  result = 0;

  while(isDefined(result) && !result) {
    while(!flag("sweeping_beach") || flag("stealth_spotted")) {
      if(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 5;
      }

      flag_wait("sweeping_beach");
    }

    sequence = ["dx_cp_reso_tdcv_soap_doyoutanorburnlt", level.ghost, 0.3, "dx_cp_reso_tdcv_ghos_animpeccablebronzejo", level.soap, 0.4, "dx_cp_reso_tdcv_soap_tanlinesaroundtheeye", level.ghost, 0.2, "dx_cp_reso_tdcv_ghos_naturally"];
    result = level.player function_c9a09b3ba9c68f8d(0.8, sequence, 0, [level, "sweeping_beach"]);
    waitframe();
  }
}

function function_7b149b2c903ea258() {
  level endon("game_ended");
}

function function_1502997c352f6a08() {
  level endon("game_ended");
}

function function_6577b99a4ca3bba() {
  level endon("game_ended");
  level endon("entered_mansion");
  flag_wait("stealth_enabled");
  childthread function_2f0b07d52498f339();
}

function function_2f0b07d52498f339() {
  if(!isDefined(level.vo.stealth_spotted)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_fnli_lasw_theyspottedyou";
    aliases[aliases.size] = "dx_cp_reso_fnli_lasw_yourecompromised";
    aliases[aliases.size] = "dx_cp_reso_fnli_lasw_youreexposed";
    aliases[aliases.size] = "dx_cp_reso_fnli_lasw_watchittheyseeyou";
    aliases[aliases.size] = "dx_cp_reso_fnli_lasw_theyseeyousoap";
    aliases[aliases.size] = "dx_cp_reso_fnli_lasw_theyreonyousoap";
    aliases[aliases.size] = "dx_cp_reso_xext_lasw_theyrealerted";
    aliases[aliases.size] = "dx_cp_reso_dwep_lasw_theyknowyourethere";
    aliases[aliases.size] = "dx_cp_reso_dwep_lasw_yourepositioniscompr";
    aliases[aliases.size] = "dx_cp_reso_dwep_lasw_headsupyougotcompany";
    aliases[aliases.size] = "dx_cp_reso_dwep_lasw_theyseeyousoap";
    aliases[aliases.size] = "dx_cp_reso_dwep_lasw_soapyouremade";
    aliases[aliases.size] = "dx_cp_reso_dwep_lasw_youvebeenspotted71";
    aliases[aliases.size] = "dx_cp_reso_fqvx_lasw_theyseeyou";
    aliases[aliases.size] = "dx_cp_reso_fqvx_lasw_theyknowyourethere71";
    level.vo.stealth_spotted = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_fupm_lasw_theylostyoufornow";
    aliases[aliases.size] = "dx_cp_reso_fupm_lasw_theyresettlingyourec";
    aliases[aliases.size] = "dx_cp_reso_fupm_lasw_youreintheclear";
    aliases[aliases.size] = [level.soap, "dx_cp_reso_fupm_soap_amiclear", level.laswell, 0.4, "dx_cp_reso_fupm_lasw_fornow"];
    aliases[aliases.size] = [level.soap, "dx_cp_reso_fupm_soap_didiloseem", level.laswell, 0.4, "dx_cp_reso_fupm_lasw_affirmative"];
    aliases[aliases.size] = "dx_cp_reso_fupm_lasw_youlostemsoap";
    level.vo.stealth_hidden = create_deck(aliases);
    aliases = [];
    aliases[aliases.size] = "dx_cp_reso_xext_lasw_theyrelookingforyou7";
    aliases[aliases.size] = "dx_cp_reso_xext_lasw_theyresearchingforyo";
    level.vo.var_70c8de0ec71d48cd = create_deck(aliases);
  }

  var_7b08121aa6393804 = 0;

  for(;;) {
    flag_wait("stealth_spotted");

    if(!function_d2b3639a2dfd8631(2)) {} else {
      lines = level.vo.stealth_spotted deck_draw();
      result = level function_c9a09b3ba9c68f8d([ &function_d2b3639a2dfd8631, 1], lines, 0, 5);

      if(isDefined(result) && !result && !flag("stealth_spotted")) {} else {
        while(flag("stealth_spotted")) {
          flag_waitopen("stealth_spotted");
          wait 3;
        }

        lines = level.vo.stealth_hidden deck_draw();
        level function_c9a09b3ba9c68f8d([ &function_88b43677e2d36760, 1], lines, 0, 10);
        wait 10;

        if(!istrue(var_7b08121aa6393804) && flag("vo_said_red_alert")) {
          lines = level.vo.var_70c8de0ec71d48cd deck_draw();
          var_7b08121aa6393804 = level function_c9a09b3ba9c68f8d([ &function_88b43677e2d36760, 1], lines, 0, 5);
        }

        wait 15;
        flag_waitopen("stealth_spotted");
      }
    }

    waitframe();
  }
}

function function_88b43677e2d36760(delay) {
  wait delay;
  return function_eac0cd99c9c6d8ee() == "hidden";
}

function function_d2b3639a2dfd8631(delay) {
  wait delay;
  return function_eac0cd99c9c6d8ee() == "spotted";
}

function function_a1709a9b1f7cbe04() {
  if(flag("entered_mansion")) {
    return;
  }

  level endon("entered_mansion");
  wait 2;
  sequence = [level.laswell, "dx_cp_reso_lacp_lasw_soapromanovasmakingc", level, 0.3, "dx_cp_reso_zwjz_miro_whoisaccessingtheter_01", level.soap, 0.4, "dx_cp_reso_zwjz_soap_gustevisnolongeravai", level.soap, 0.8, "dx_cp_reso_zwjz_soap_beadvisedmilenasspoo", level.laswell, 0.3, "dx_cp_reso_zwjz_lasw_goodwellweaponizetha"];
  level thread function_c9a09b3ba9c68f8d(0.7, sequence);
}

function function_bf82f5bdcf9e9f41(mindist, var_cfaa5978cdc2007) {
  distsq = squared(mindist);
  var_991fdc8d00e4c73f = getStruct("obj_interact_bar", "targetname");
  var_32d66d6599e1d29b = getStruct("obj_interact_usb", "targetname");
  var_5118e11a80569725 = !var_cfaa5978cdc2007 || !flag("obj_laptop3_completed");

  if(var_5118e11a80569725 && distancesquared(level.player.origin, var_991fdc8d00e4c73f.origin) < distsq) {
    return true;
  }

  var_e6f3422cd81bd8be = !var_cfaa5978cdc2007 || !flag("flag_visit_bunker");

  if(var_e6f3422cd81bd8be && distancesquared(level.player.origin, var_32d66d6599e1d29b.origin) < distsq) {
    return true;
  }

  if(isalive(level.vip) && distancesquared(level.player.origin, level.vip.origin) < distsq) {
    return true;
  }

  var_52b97f24a2ad6754 = (-2937, 4000, 0);

  if(!flag("vo_cleared_cave") && distancesquared(level.player.origin, var_52b97f24a2ad6754) < distsq) {
    return true;
  }

  return false;
}

function function_6bf44e0bb0f1720a(secondstowait, var_cb95d4a98694f10, var_1097c1dae18bc326) {
  secondswaited = 0;
  mindist = default_to(mindist, 1000);
  var_1097c1dae18bc326 = default_to(var_1097c1dae18bc326, 0);
  level.player endon("started_saying");
  level.ghost endon("started_saying");
  level.laswell endon("started_saying");

  for(secondswaited = 0; secondswaited < secondstowait; secondswaited++) {
    wait 1;

    if(function_bf82f5bdcf9e9f41(mindist, var_1097c1dae18bc326) || !istrue(var_cb95d4a98694f10) && flag("stealth_spotted")) {
      return false;
    }
  }

  return true;
}

function function_16b3ab92dae9a32() {
  if(level.player isswimunderwater()) {
    return 0;
  }
}

function function_5c5a589e629678a2() {
  level endon("game_ended");
  level endon("vo_end_ghostworld");
  wait 2;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(2, 1))) {
      wait 1;
    }

    sequence = [level.ghost, "dx_cp_reso_gwu1_ghos_movingtosecuretheper", &function_16b3ab92dae9a32, level.soap, 0.3, "dx_cp_reso_gwu1_soap_goodlucklt", &function_16b3ab92dae9a32, level.ghost, 0.4, "dx_cp_reso_gwu1_ghos_yeahtheyregonnaneedi"];
    result = level.ghost function_c9a09b3ba9c68f8d(0.5, sequence, 0, 3);
    waitframe();
  }

  wait 35;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(4, 1))) {
      wait 1;
    }

    sequence = ["dx_cp_reso_gwu1_ghos_watcherescapevehicle", level.laswell, 0.3, "dx_cp_reso_gwu1_lasw_howmany", level.ghost, 0.2, "dx_cp_reso_gwu1_ghos_theresacovewithfouri", level.laswell, 0.4, "dx_cp_reso_gwu1_lasw_wecantriskanevactake", level.ghost, 0.3, "dx_cp_reso_gwu1_ghos_rogerthatnoescape"];
    result = level.ghost function_c9a09b3ba9c68f8d(0.5, sequence, 0, 1);
    waitframe();
  }

  wait 30;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(4, 1))) {
      wait 1;
    }

    sequence = ["dx_cp_reso_gwu2_ghos_tookdowntheguardsont", level.laswell, 0.5, "dx_cp_reso_gwu2_lasw_sabotageallboatsandv", level.ghost, 0.2, "dx_cp_reso_gwu2_ghos_countonit"];
    result = level.ghost function_c9a09b3ba9c68f8d(0.5, sequence, 0, 3);
    waitframe();
  }

  wait 40;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(4, 1))) {
      wait 1;
    }

    sequence = ["dx_cp_reso_gwu2_ghos_boatsaredowngoingfor", level.laswell, 0.5, "dx_cp_reso_gwu3_lasw_niceworkghost"];
    result = level.ghost function_c9a09b3ba9c68f8d(0.5, sequence, 0, 3);
    waitframe();
  }

  wait 45;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(3, 1))) {
      wait 1;
    }

    sequence = ["dx_cp_reso_gwu2_ghos_allperimeterassetsar", level.laswell, 0.2, "dx_cp_reso_gwu2_lasw_copystayputandkeepit"];
    result = level.ghost function_c9a09b3ba9c68f8d(0.5, sequence, 0, 3);
    waitframe();
  }

  flag_set("vo_finished_ghost_updates");
  wait 35;
  result = 0;

  while(isDefined(result) && !result) {
    while(!istrue(function_6bf44e0bb0f1720a(3, 0))) {
      wait 1;
    }

    sequence = [level.soap, "dx_cp_reso_qjlz_soap_whatstheintelonmakan", level.laswell, 0.3, "dx_cp_reso_qjlz_lasw_herhusbandandmakarov", &function_44547bb3f0740247, level.ghost, 0.4, "dx_cp_reso_qjlz_ghos_whathappenedtothehus", level.laswell, 0.3, "dx_cp_reso_qjlz_lasw_hefellonaknifenineti", &function_44547bb3f0740247, level.soap, 0.4, "dx_cp_reso_qjlz_soap_figures", &function_44547bb3f0740247, level.laswell, 0.3, "dx_cp_reso_qjlz_lasw_milenagothisfortunea", &function_44547bb3f0740247, level.ghost, 0.3, "dx_cp_reso_qjlz_ghos_howconvenient"];
    result = level function_c9a09b3ba9c68f8d(0.5, sequence, 0, 3);
    waitframe();
  }
}

function function_572565823b3516c3() {
  level notify("vo_end_ghostworld");

  if(flag("vo_finished_ghost_updates")) {
    return;
  }

  wait 0.5;
  sequence = ["dx_cp_reso_gwu2_ghos_allperimeterassetsar", level.laswell, 0.2, "dx_cp_reso_fnmh_lasw_copy"];
  result = level.ghost function_c9a09b3ba9c68f8d(0.8, sequence);
}

function function_adb560d383ed603a() {
  level endon("game_ended");
  level.vo.var_dfe7ccb236b6086e = [];
  level.vo.var_d30a369c7ba22d1f = [];
  level.vo.var_97b7fa942cd21b70 = [];
  level.vo.var_fb26730ad7b54bca = [];
  function_78a283fe6bceac88("cruise_missile");
  function_64876aff259b1331("precision_airstrike");
  function_9fb30ca2da3211c1("uav");
  function_1b77585dbc3114bb("cluster_spike");
  function_60a8490997fccab0("missile_turret");
  level.vo.var_7e8c4ba78c7a4776 = [level.laswell, "dx_cp_reso_kiin_lasw_whenshadowscoutedthe", level.soap, 0.5, "dx_cp_reso_kiin_soap_copythatmightcomeinh"];

  while(true) {
    for(i = 0; i < level.vo.var_dfe7ccb236b6086e.size; i++) {
      if(function_6f5fb077122784a0(level.vo.var_dfe7ccb236b6086e[i])) {
        thread function_bfae2d12a116cdbd(level.vo.var_dfe7ccb236b6086e[i]);
        waitframe();
      }
    }

    if(function_607e21b405a406ab() == 1) {
      return;
    }

    wait 1;
  }
}

function private function_6f5fb077122784a0(id) {
  if(flag("killstreak_vo_playing") == 1) {
    return false;
  }

  if(level.player scripts\cp\munitions::has_munition(id)) {
    if(istrue(level.vo.var_fb26730ad7b54bca[id])) {
      return false;
    }

    return true;
  }

  return false;
}

function private function_bfae2d12a116cdbd(id) {
  level endon("game_ended");

  if(flag("killstreak_vo_playing") == 1) {
    return;
  }

  flag_set("killstreak_vo_playing");
  deck = level.vo.var_d30a369c7ba22d1f[id];

  if(function_a7c8f01b64b95e8e()) {
    deck = level.vo.var_97b7fa942cd21b70[id];
  }

  result = level function_c9a09b3ba9c68f8d(0.5, deck deck_draw(), 0, 2);

  if(istrue(result) == 0 && deck.index > 0) {
    deck.index -= 1;
  } else {
    level.vo.var_fb26730ad7b54bca[id] = 1;
  }

  flag_clear("killstreak_vo_playing");
}

function private function_607e21b405a406ab() {
  for(i = 0; i < level.vo.var_dfe7ccb236b6086e.size; i++) {
    if(isDefined(level.vo.var_dfe7ccb236b6086e[i]) && istrue(level.vo.var_fb26730ad7b54bca[level.vo.var_dfe7ccb236b6086e[i]]) == 0) {
      return false;
    }
  }

  return true;
}

function private function_78a283fe6bceac88(id) {
  if(isDefined(level.vo.var_d2b56eaeb87bd809) == 0) {
    var_ecac38c5291f6b17 = [level.laswell, "dx_cp_reso_kicm_lasw_lookslikeaguidedcrui", level.soap, 0.5, "dx_cp_reso_kicm_soap_goodeyewatcher"];
    var_ecac39c5291f6d4a = [level.soap, "dx_cp_reso_kicm_soap_lookslikeaguidedcrui", level.laswell, 0.5, "dx_cp_reso_kicm_lasw_goodfind"];
    var_ecac3ac5291f6f7d = [level.soap, "dx_cp_reso_kicm_soap_gotaguidedcruisemiss", level.ghost, 0.5, "dx_cp_reso_kicm_ghos_goodfind"];
    level.vo.var_d30a369c7ba22d1f[id] = create_deck([var_ecac38c5291f6b17, var_ecac39c5291f6d4a], 1, 1, 1);
    level.vo.var_97b7fa942cd21b70[id] = create_deck([var_ecac3ac5291f6f7d], 1, 1, 1);
  }

  level.vo.var_dfe7ccb236b6086e[level.vo.var_dfe7ccb236b6086e.size] = id;
}

function private function_64876aff259b1331(id) {
  if(isDefined(level.vo.var_73bd84366ac92887) == 0) {
    var_f81e06422000d63a = [level.soap, "dx_cp_reso_kipa_soap_shadowsreadyforaprec", level.laswell, 0.5, "dx_cp_reso_kipa_lasw_givethewordandtheyll"];
    level.vo.var_d30a369c7ba22d1f[id] = create_deck([var_f81e06422000d63a], 1, 1, 1);
    level.vo.var_97b7fa942cd21b70[id] = create_deck([var_f81e06422000d63a], 1, 1, 1);
  }

  level.vo.var_dfe7ccb236b6086e[level.vo.var_dfe7ccb236b6086e.size] = id;
}

function private function_9fb30ca2da3211c1(id) {
  if(isDefined(level.vo.uav) == 0) {
    var_9042a45609a2eae0 = [level.soap, "dx_cp_reso_kiua_soap_uavsusable", level.ghost, 0.5, "dx_cp_reso_kiua_ghos_nowheretohide"];
    var_9042a75609a2f179 = [level.soap, "dx_cp_reso_kiua_soap_uavhere", level.ghost, 0.5, "dx_cp_reso_kiua_ghos_nowheretohide_01"];
    level.vo.var_d30a369c7ba22d1f[id] = create_deck([var_9042a45609a2eae0], 1, 1, 1);
    level.vo.var_97b7fa942cd21b70[id] = create_deck([var_9042a75609a2f179], 1, 1, 1);
  }

  level.vo.var_dfe7ccb236b6086e[level.vo.var_dfe7ccb236b6086e.size] = id;
}

function private function_1b77585dbc3114bb(id) {
  if(isDefined(level.vo.clusterspike) == 0) {
    var_4ead5ea1a8dcec98 = [level.soap, "dx_cp_reso_kics_soap_foundaclusterspike", level.laswell, 0.5, "dx_cp_reso_kics_lasw_highdamagewideradius"];
    var_4ead61a1a8dcf331 = [level.soap, "dx_cp_reso_kics_soap_foundaclusterspike_01", level.laswell, 0.5, "dx_cp_reso_kics_lasw_highdamagewideradius_01"];
    level.vo.var_d30a369c7ba22d1f[id] = create_deck([var_4ead5ea1a8dcec98], 1, 1, 1);
    level.vo.var_97b7fa942cd21b70[id] = create_deck([var_4ead61a1a8dcf331], 1, 1, 1);
  }

  level.vo.var_dfe7ccb236b6086e[level.vo.var_dfe7ccb236b6086e.size] = id;
}

function private function_60a8490997fccab0(id) {
  if(isDefined(level.vo.samturret) == 0) {
    var_dc5d59c75f49dc83 = [level.soap, "dx_cp_reso_kist_soap_gotasamturret", level.laswell, 0.5, "dx_cp_reso_kist_lasw_limitedmissilesandvu"];
    var_dc5d5ac75f49deb6 = [level.soap, "dx_cp_reso_kist_soap_gotasamturret_01", level.laswell, 0.5, "dx_cp_reso_kist_lasw_useitwisely"];
    level.vo.var_d30a369c7ba22d1f[id] = create_deck([var_dc5d59c75f49dc83], 1, 1, 1);
    level.vo.var_97b7fa942cd21b70[id] = create_deck([var_dc5d5ac75f49deb6], 1, 1, 1);
  }

  level.vo.var_dfe7ccb236b6086e[level.vo.var_dfe7ccb236b6086e.size] = id;
}

function function_a5d488e99073e6c7() {
  level.vo.var_cc736f1e406bb105 = gettime();
}

function function_f5e84957798fd3c7() {
  level.vo = function_69fa4a2561ada985("vo_struct");

  if(!isDefined(level.vo)) {
    level.vo = spawnStruct();
    function_2311740fe797906a("vo_struct", level.vo);
  }

  level.vo.var_9dab3b7aba58fd2f = ["dx_cp_reso_csko_kon1_allunitshostilesight"];
  level.vo.var_9f0d9d2576eae36 = ["dx_cp_reso_csko_kon1_allunitshostilesight_01"];
  level.vo.var_7e531a1e844b2ba4 = ["dx_cp_reso_csko_kon1_allunitshostilesight_02"];
  level.vo.var_6e0a84c9c12a618f = ["dx_cp_reso_csko_kon1_allunitshostilesight_03"];
  level.vo.var_f6d89962d2fd6544 = ["dx_cp_reso_csko_kon1_allunitshostilesight_04"];
  level.vo.var_cda1d9bf275a199c = ["dx_cp_reso_csko_kon1_allunitshostilesight_05"];
  level.vo.var_fa5866625b09868e = ["dx_cp_reso_csko_kon1_allunitshostilesight_06"];
  level.vo.var_b5158aa5fd7cc8e4 = ["dx_cp_reso_csko_kon1_iseehim", "dx_cp_reso_csko_kon1_shoottokill"];
}

function function_8a487b265a8496ac(targets, dot, holdtime, maxdist, timeout, offset, var_e2073531fa9c0c72, var_cbe3524d314a7bd3) {
  return function_ce1551245242a903(targets, dot, holdtime, maxdist, timeout, offset, var_e2073531fa9c0c72, var_cbe3524d314a7bd3, 1);
}

function function_ce1551245242a903(targets, dot, holdtime, maxdist, timeout, offset, var_e2073531fa9c0c72, var_cbe3524d314a7bd3, var_12fd56460a1c9f2d) {
  dot = default_to(dot, 0.9995);
  var_e2073531fa9c0c72 = default_to(var_e2073531fa9c0c72, 0);
  holdtime = default_to(holdtime, 0.05);
  var_a8e10451f51aa11e = 0;
  maxdistsq = undefined;

  if(isDefined(maxdist)) {
    maxdistsq = squared(maxdist);
  }

  time = -0.05;

  while(!isDefined(timeout) || time < timeout) {
    time += 0.05;

    if(!isalive(level.player)) {
      return;
    }

    if(var_e2073531fa9c0c72 && level.player playerads() < 0.5) {} else {
      target = level.player function_826a16f43a8e949b(targets, dot, offset, maxdistsq, var_cbe3524d314a7bd3, var_12fd56460a1c9f2d);

      if(!isDefined(target)) {
        var_a8e10451f51aa11e = 0;
      } else {
        var_a8e10451f51aa11e += 0.05;

        if(getdvarint(@ "hash_8bb9ee0824446549", 0)) {
          printtoscreen2d(100, 300, "<dev string:x1c>" + var_a8e10451f51aa11e + "<dev string:x39>", (1, 1, 1), 1, 1);
        }

        if(var_a8e10451f51aa11e > holdtime) {
          return target;
        }
      }
    }

    waitframe();
  }
}

function function_bc9fb23680427ef5(targets, dot, maxdist, timeout, offset, var_cbe3524d314a7bd3, var_12fd56460a1c9f2d) {
  dot = default_to(dot, 0.9995);
  var_e2073531fa9c0c72 = default_to(var_e2073531fa9c0c72, 0);
  holdtime = default_to(holdtime, 0.05);
  var_a8e10451f51aa11e = 0;
  maxdistsq = undefined;

  if(isDefined(maxdist)) {
    maxdistsq = squared(maxdist);
  }

  time = -0.05;

  while(!isDefined(timeout) || time < timeout) {
    time += 0.05;

    if(!isalive(level.player)) {
      return;
    }

    target = level.player function_826a16f43a8e949b(targets, dot, offset, maxdistsq, var_cbe3524d314a7bd3, var_12fd56460a1c9f2d);

    if(!isDefined(target)) {
      var_a8e10451f51aa11e += 0.05;

      if(getdvarint(@ "hash_8bb9ee0824446549", 0)) {
        printtoscreen2d(100, 300, "<dev string:x1c>" + var_a8e10451f51aa11e + "<dev string:x39>", (1, 1, 1), 1, 1);
      }

      if(var_a8e10451f51aa11e > holdtime) {
        return target;
      }
    } else {
      var_a8e10451f51aa11e = 0;
    }

    waitframe();
  }
}

function function_826a16f43a8e949b(targets, dot, offset, maxdistsq, var_cbe3524d314a7bd3, var_12fd56460a1c9f2d) {
  if(isfunction(targets) || isbuiltinfunction(targets) || isbuiltinmethod(targets)) {
    targets = call_with_params(targets);
  }

  if(!isarray(targets)) {
    targets = [targets];
  }

  var_5ddb2b9e6961d6c8 = ter_op(istrue(var_cbe3524d314a7bd3), &distance2dsquared, &distancesquared);

  foreach(target in targets) {
    if(!isDefined(target)) {
      continue;
    }

    if(isai(target)) {
      if(!isalive(target)) {
        continue;
      }

      origin = target.origin + (0, 0, 50);

      if(isDefined(offset)) {
        origin = coordtransform(offset, target.origin, target.angles);
      }
    } else if(isent(target) || isstruct(target)) {
      origin = target.origin;

      if(isDefined(offset)) {
        origin = coordtransform(offset, target.origin, target.angles);
      }
    } else {
      origin = target;

      if(isDefined(offset)) {
        origin += offset;
      }
    }

    if(getdvarint(@ "hash_8bb9ee0824446549", 0) && is_equal(self, level.player)) {
      print3d(origin + (0, 0, 5), round(sqrt(builtin[[var_5ddb2b9e6961d6c8]](self.origin, origin))), (1, 1, 1), 1, 0.2, 1, 1);
    }

    if(isDefined(maxdistsq) && builtin[[var_5ddb2b9e6961d6c8]](self.origin, origin) > maxdistsq) {
      if(getdvarint(@ "hash_8bb9ee0824446549", 0) && is_equal(self, level.player)) {
        sphere(origin, 2, (1, 0.2, 0.4), 0, 1);
      }

      continue;
    }

    if(getdvarint(@ "hash_8bb9ee0824446549", 0) && is_equal(self, level.player)) {
      sphere(origin, 2, (1, 1, 0), 0, 1);
    }

    if(function_616c3c283f990dc4(origin, dot, var_12fd56460a1c9f2d)) {
      return target;
    }
  }
}

function function_616c3c283f990dc4(start, dot, dot_only, ignore_ent) {
  if(!isDefined(dot)) {
    dot = 0.8;
  }

  end = level.player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  player_angles = level.player getplayerangles();
  player_forward = anglesToForward(player_angles);
  new_dot = vectordot(forward, player_forward);

  if(new_dot < dot) {
    return 0;
  }

  if(istrue(dot_only)) {
    return 1;
  }

  return scripts\engine\trace::ray_trace_passed(start, end, ignore_ent, scripts\engine\trace::create_default_contents(1));
}

function function_70386f0dbf01d6f4(combat, noncombat) {
  return flag("stealth_spotted") ? combat : noncombat;
}