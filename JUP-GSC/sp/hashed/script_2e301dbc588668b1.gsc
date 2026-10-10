/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2e301dbc588668b1.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_2386704e3c08f8ca;
#using script_3a8f9ace195c9da9;
#using script_3c5077a8847a5d9e;
#using script_48324b060b129b7b;
#using scripts\anim\dialogue;
#using scripts\engine\utility;
#namespace namespace_23bfe2351f50df28;

function function_ffc7dd3a5adfd5cf() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level thread function_c28d7d6ef47736ff();
  level thread function_797e8b614a0a3268();
  level thread function_b21e539650c5319c();
  level thread function_a4c05663ca6507cf();
  level thread function_a3614e3a6d464b88("mid1_traps");
  level thread function_a3614e3a6d464b88("mid2_traps");
  level thread function_4b1b7457895f43fe();
  level thread function_2b77e8aaf701c03c();
  level thread function_d34a9fb2da5b3f63();
  level thread function_9496e4c193844a95();
  level thread function_b0bb187903b917f9();
  level thread function_83c1474813ed14a1();
  level thread function_b644d6ef884bd03c();
  level thread function_9a6146ac4bf164ca();
  level thread function_e4565f1627bc7672();
  level thread function_b93e7ab816ce1df0();
  level thread function_8e216772f4e0cce5();
  level thread function_2dab584158f27c57();
  level thread function_41581fcd95acbc60();
  level thread function_1e8ef6cb45712c73();
  level thread vo_near_ladder();
  level thread function_2c11f121d75834b();

  while(!isDefined(level.ally)) {
    waitframe();
  }

  level thread function_42dda48a62b633f6();
  level thread function_d8911be5bb7a816b();

  while(!isDefined(level.hvt)) {
    waitframe();
  }

  level thread function_81d8b57d5cc6b325();
  level thread function_b01862fb01f4df3c();
  level thread function_e6ae109c49671dbc();
  level thread function_408720b52e461941();
  level thread function_6ac61054bf40ecc7();
  level thread function_cfb293515004f084();
  level thread function_20efa67a317ecbcc();
  level thread function_e6e969e56305e2d1();
  level thread function_ddbf55cb7ed6bbb1();
  level thread function_cf5f249143725c3d();
  level thread function_5f7d6b12ff64a4fe();
  level thread function_909cc32cc72988cc();
  level thread function_1f85392609ffa50f();
  level thread function_82710c32d74b4ff3();
  level thread function_6c8838a2e5acbc63();
  level thread function_10ec9a884b8c5fc5();
}

function function_62b86e686212d678(var_e1593666b82027a8) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  if(!isDefined(level.player.pers["one_off_lines"])) {
    level.player.pers["one_off_lines"] = [];
  }

  if(isDefined(level.player.pers["one_off_lines"][var_e1593666b82027a8]) && getdvarint(@ "hash_d5ae28dd37a0904c", 0) == 0) {
    return;
  }

  level.player.pers["one_off_lines"][var_e1593666b82027a8] = 1;
  say(var_e1593666b82027a8);
}

function function_c28d7d6ef47736ff() {
  level endon("game_ended");
  level endon("flag_apt_basement_complete");
  level endon("intro_skipped");
  flag_wait("intro_anim_started");
  wait 0.5;
  level.player say("dx_cp_apar_bmnt_lasw_goodletsseewhoandwha");
  wait 0.5;
  level.player say("dx_cp_apar_bmnt_gazz_affirmativegoodtogo");
}

function function_5db55ded4b9d3d21() {
  sequence = [level, 0, "dx_cp_apar_bmnt_pric_gazpressupletmeknoww", level.player, 0.3, "dx_cp_apar_bmnt_gazz_rogonthemove"];
  endons = [level, "player_near_basement_elevator"];
  say_sequence(sequence, undefined, undefined, undefined, undefined, undefined, endons);
}

function function_ad9a31085eee46() {
  aliases = array_randomize(["dx_cp_apar_inre_pric_ascenderswillmakethe", "dx_cp_apar_inre_pric_takeadvantageofanyas"]);
  level say(aliases[0]);
}

function function_17040b13d6d0d1d3(guys) {
  level endon("broke_stealth_earlier");
  guys = sortbydistance(guys, level.player.origin);

  foreach(guy in guys) {
    guy endon("damage");
    guy endon("death");
  }

  wait 5;
  guys = array_removedead_or_dying(guys);

  if(guys.size < 2) {
    return;
  }

  guys[0] say("dx_cp_apar_mid1_kon1_wevealreadyclearedth");
  wait 0.5;
  guys[1] say("dx_cp_apar_mid1_kon2_thenweclearitagainno");
}

function function_52efb572a14e9a9e() {
  flag_wait("near_6th_floor_stairs");

  if(level.player.origin[1] > 3000) {
    return;
  }

  level notify("stop_kill_first_guys_dialogue");
  aliases = ["dx_cp_apar_dcal_pric_gazyougothostilesont", "dx_cp_apar_dcal_pric_hostilescomingdownth"];
  alias = random(aliases);
  level thread say(alias);
  wait 0.5;
  guys = function_d330ef725ee0137c("mid_1_front");
  guys = array_removedead_or_dying(guys);

  if(guys.size == 0) {
    return;
  }

  guys = sortbydistance(guys, level.player.origin);

  if(guys[0].var_fe5ebefa740c7106 == 0) {
    guys[0] say("dx_cp_apar_mid1_kon4_headingtolevel5");
  }
}

function function_a3614e3a6d464b88(flagname) {
  flag_wait(flagname);
  responses = [];

  if(flagname == "mid1_traps") {
    aliases = ["dx_cp_apar_ntv1_gazz_igottrapssetallovert"];
    responses[responses.size] = "dx_cp_apar_ntv1_pric_youcantrydisablingth";
    responses[responses.size] = "dx_cp_apar_ntv1_pric_youcandisablethem";
  } else {
    aliases = ["dx_cp_apar_ntv1_gazz_therearetrapseverywh"];
    responses[responses.size] = "dx_cp_apar_ntv1_pric_ifyougetcloseyoucoul";
    responses[responses.size] = "dx_cp_apar_ntv1_pric_trydisablingthem";
  }

  function_7f9bc6a284801043("trap", 10);
  level.player say(random(aliases));
  wait 0.2;
  level say(random(responses));
}

function function_2c11f121d75834b() {
  flag_wait("courtyard_jackpot");
  sequence = [level.player, 0, "dx_cp_apar_ntv2_gazz_jackpotmoregearinher", level, 0.4, "dx_cp_apar_ntv2_pric_takewhatyouneedkonni"];
  say_sequence(sequence);
}

function function_35148079444a7bc1() {
  function_17b7868bdc4351d8(11);
  function_a6ee2346a2b961bf(11);
  tempent = spawn_script_origin(level.player.origin + (0, 0, 200));
  tempent say("dx_cp_apar_mid2_noln_allpersonneltheenemy");
  wait 0.3;
  level say("dx_cp_apar_mid2_pric_nolanhasalertedhiste");
  tempent delete();
}

function function_bf73f0d2dae5ebf4() {
  aliases = ["dx_cp_apar_upr1_kon6_poppingsmoke", "dx_cp_apar_upr1_kon6_smokeout"];
  function_385aeebef33198ba(aliases[randomint(aliases.size)]);
}

function function_385aeebef33198ba(alias) {
  guys = getaiarray("axis");
  guys = array_removedead_or_dying(guys);

  if(guys.size == 0) {
    return;
  }

  guys = sortbydistance(guys, level.player.origin);
  guy = guys[0];
  guy say(alias);
}

function function_f3e9b824417516ee(pos) {
  if(!isDefined(level.var_e7564d2ab5aab260)) {
    level.var_e7564d2ab5aab260 = [];
  }

  struct = spawnStruct();
  struct.origin = pos;
  level.var_e7564d2ab5aab260[level.var_e7564d2ab5aab260.size] = struct;
}

function function_873ef3cd9a77e453(alias) {
  guys = getaiarray("axis");
  guys = array_removedead_or_dying(guys);
  radios = guys;

  if(isDefined(level.var_e7564d2ab5aab260)) {
    radios = array_combine(level.var_e7564d2ab5aab260);
  }

  radios = sortbydistance(radios, level.player.origin);
  distsqrd = 40000;
  var_1507d978c1cb3ce5 = lookupsoundlength(alias) * 0.001;
  var_1fe5b916408712e8 = [];
  count = 3;

  foreach(radio in radios) {
    if(isai(radio) && !isalive(radio)) {
      continue;
    }

    if(!isDefined(radio)) {
      continue;
    }

    var_6180baa7a85ed632 = 0;

    foreach(t in var_1fe5b916408712e8) {
      if(distancesquared(radio.origin, t.origin) < distsqrd) {
        var_6180baa7a85ed632 = 1;
      }
    }

    if(var_6180baa7a85ed632) {
      continue;
    }

    temp = spawn_script_origin(radio.origin);
    var_1fe5b916408712e8[var_1fe5b916408712e8.size] = temp;

    if(isai(radio)) {
      temp.origin += (0, 0, 50);
      temp linkTo(radio);
    }

    temp thread function_3ac3c88e22ab0b6e(alias, var_1507d978c1cb3ce5);
    count--;

    if(count == 0) {
      break;
    }

    if(cointoss()) {
      wait randomfloat(0.1);
    }
  }

  wait var_1507d978c1cb3ce5;
}

function function_3ac3c88e22ab0b6e(alias, var_1507d978c1cb3ce5) {
  self playSound(alias);
  wait var_1507d978c1cb3ce5;
  self delete();
}

function function_fece794ef755bf46() {
  if(function_1e4aaaddfd5236ca()) {
    alias = "dx_cp_apar_mid1_gazz_gotanascenderrope";
  } else {
    alias = "dx_cp_apar_mid1_gazz_foundanascenderropeh";
  }

  var_cf14848c064120ba = level.player say(alias, undefined, 0);

  if(!istrue(var_cf14848c064120ba)) {
    return;
  }

  level say("dx_cp_apar_mid1_pric_thatllsaveyouahike", undefined, 0);
}

function function_fed2464824100bb1() {
  if(flag("nvgs_picked_up")) {
    return;
  }

  flag_set("nvgs_picked_up");
  sequence = [level.player, 0, "dx_cp_apar_ntv1_gazz_foundsomenods", level, 0.2, "dx_cp_apar_ntv1_pric_bettheresmoregearlyi"];
  level say_sequence(sequence);
}

function function_797e8b614a0a3268() {}

function function_6efca826052dbc92() {
  level endon("game_ended");
  level.player endon("death");
  level endon("player_top_of_basement_elevator");
  var_65ca7b76418441ba = function_1f067aa9b7648939();
  flag_wait("player_near_basement_elevator");
  flag_wait_either("basement_guy_killed", "player_in_basement_elevator");

  if(!var_65ca7b76418441ba) {
    level.player function_79e142d9b0202354("dx_cp_apar_ladd_gazz_capattheelevatorshaf");
    level function_79e142d9b0202354("dx_cp_apar_ladd_pric_copyuseit");
    wait 0.5;
  }

  level function_79e142d9b0202354("dx_cp_apar_ladd_lasw_bravogotahitonourhvi");

  if(!var_65ca7b76418441ba) {
    if(!flag("player_in_basement_elevator_upper")) {
      wait 0.1;

      if(!flag("player_in_basement_elevator_upper")) {
        level.player function_79e142d9b0202354("dx_cp_apar_ladd_gazz_soundslikeaguyidlike");
      }
    }

    if(!flag("player_in_basement_elevator_upper")) {
      wait 0.2;

      if(!flag("player_in_basement_elevator_upper")) {
        level function_79e142d9b0202354("dx_cp_apar_ladd_pric_mefirst");
      }
    }

    if(!flag("player_in_basement_elevator_upper")) {
      wait 0.4;

      if(!flag("player_in_basement_elevator_upper")) {
        level function_79e142d9b0202354("dx_cp_apar_ladd_lasw_savesomeformenolanis");
      }
    }
  }

  if(!flag("player_in_basement_elevator_upper")) {
    wait 0.2;

    if(!flag("player_in_basement_elevator_upper")) {
      level function_79e142d9b0202354("dx_cp_apar_ladd_pric_roggazwesnatchandgra");
    }
  }

  wait 0.2;
  level.player function_79e142d9b0202354("dx_cp_apar_ladd_gazz_copyhowdoweextracthi");
  wait 0.3;
  level function_79e142d9b0202354("dx_cp_apar_ladd_pric_aliveillsecureexfila");
  thread function_27ecfa9ce71a39ba();
}

function function_79e142d9b0202354(alias) {
  while(level.player isinexecutionattack()) {
    waitframe();
  }

  say(alias);
}

function function_27ecfa9ce71a39ba() {
  level endon("game_ended");
  level.player endon("death");
  level endon("player_top_of_basement_elevator");
  flag_wait("player_in_basement_elevator_upper");

  while(!level.player isonladder()) {
    wait 0.2;
  }

  flag_set("elevator_dialogue_done");
}

function function_4b1b7457895f43fe() {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("player_top_of_basement_elevator");

  foreach(guy in level.var_83ff5ca62aefdeb9) {
    guy endon("damage");
  }

  flag_wait("flag_apt_basement_complete");
  flag_set("mid_1_elevator_comment_complete");
  aliases = ["dx_cp_apar_mid1_pric_2seeinghostilesmovin", "dx_cp_apar_mid1_pric_62headsupforhostiles"];
  level say(aliases[randomint(aliases.size)], undefined, 1);
}

function function_2b77e8aaf701c03c() {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("mid_1_start_radio_chatter");
  radio = spawn("script_origin", level.var_27b0dbdc7c692c9.origin);
  wait 10;
  radio say("dx_cp_apar_m1nr_noln_alpha21tosentryhowco");
  wait 10;
  radio say("dx_cp_apar_m1nr_noln_alpha21tosentryackno");
  wait 10;
  radio say("dx_cp_apar_m1nr_noln_sentrywhatthefuckisg");
}

function function_d34a9fb2da5b3f63() {
  level endon("game_ended");
  level endon("flag_apt_upper_complete");
  level endon("mid_2_start");

  if(flag("flag_apt_upper_complete")) {
    return;
  }

  flag_wait("broke_stealth_earlier");
  wait 2.5;
  aliases = ["dx_cp_apar_aler_pric_gaztheyknowyourether", "dx_cp_apar_aler_pric_sergeantyourecomprom", "dx_cp_apar_aler_pric_gazyoupokedthebearko", "dx_cp_apar_aler_pric_youkickedthenestthey", "dx_cp_apar_aler_pric_theyknowyourposition", "dx_cp_apar_aler_pric_theyrecallingreinfor"];
  level say(aliases[randomint(aliases.size)]);
}

function function_b21e539650c5319c() {
  flag_wait("flag_apt_basement_complete");
  flag_wait_either("mid_1_kill_first_guys", "flag_apt_mid_1_complete");
  wait 1;

  while(true) {
    level waittill("player_killed_enemy", loc);

    if(flag("broke_stealth_earlier")) {
      continue;
    }

    closest_guy = function_a44c98e5ec0f3b0c(loc, 1);

    if(isDefined(closest_guy) && distance2d(closest_guy.origin, loc) < 400) {
      continue;
    }

    level notify("player_stealth_kill_callout");
    wait 15;
  }
}

function function_a4c05663ca6507cf() {
  level endon("game_ended");
  level endon("flag_apt_upper_complete");

  if(flag("flag_apt_upper_complete")) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_clear";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_dustedem";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_droppedem";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_erased";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_leadpoisoning";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_hestoasted";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_friedhim";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_goner";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_ripasshole";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_naptime";
  aliases[aliases.size] = "dx_cp_apar_dcal_gazz_lightsoutlad";
  var_30a0b473fda40f50 = array_randomize(aliases);
  iter = 0;

  while(true) {
    level waittill("player_stealth_kill_callout");
    wait 0.7;
    level.player say(var_30a0b473fda40f50[iter]);
    iter++;

    if(iter >= var_30a0b473fda40f50.size) {
      break;
    }
  }
}

function function_24d06ee4cf6331e6(guys) {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");
  level endon("mid_2_start");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("6th_floor_hallway");
  wait randomfloat(2);
  function_7f9bc6a284801043("enemy", 10);
  sequences = [];

  if(function_1e4aaaddfd5236ca()) {
    aliases = ["dx_cp_apar_mid1_gazz_placeiscrawlingwithk", "dx_cp_apar_mid1_gazz_konnisgotseriousnumb", "dx_cp_apar_mid1_gazz_shitloadomanpowerher"];
    alias = random(aliases);
    responses = ["dx_cp_apar_mid1_pric_illcoverwhereicanyou", "dx_cp_apar_mid1_pric_shootandmovegarricky"];
    response = random(responses);
    sequence = [level.player, 0, alias, level, 0.3, response];
    sequences[sequences.size] = sequence;
  } else {
    alias = "dx_cp_apar_mid1_gazz_placeiscrawlingwithk_01";
    responses = ["dx_cp_apar_mid1_pric_nothingyoucanthandle", "dx_cp_apar_mid1_pric_targetrichenvironmen", "dx_cp_apar_mid1_pric_morethemerriersergea"];
    response = responses[randomint(responses.size)];
    sequence = [level.player, 0, alias, level, 0.3, response];
    sequences[sequences.size] = sequence;
    sequence = [level.player, 0, "dx_cp_apar_mid1_gazz_gotkonnialloverthepl", level, 0.3, "dx_cp_apar_mid1_pric_ifitwaseasyeveryonew", level.player, 0.2, "dx_cp_apar_mid1_gazz_aintthatthetruth"];
    sequences[sequences.size] = sequence;
    sequence = [level.player, 0, "dx_cp_apar_mid1_gazz_gotenemiesupthewazoo", level, 0.2, "dx_cp_apar_mid1_pric_eliminateallthreatsu", level.player, 0.2, "dx_cp_apar_mid1_gazz_rogerthat"];
    sequences[sequences.size] = sequence;
    sequence = [level.player, 0, "dx_cp_apar_mid1_gazz_gotafucktonobadguysi", level, 0.2, "dx_cp_apar_mid1_pric_layemoutandgettother", level.player, 0.2, "dx_cp_apar_mid1_gazz_dontmindifido"];
    sequences[sequences.size] = sequence;
    sequence = [level.player, 0.2, "dx_cp_apar_mid1_gazz_kneedeepinkonniheres", level, 0.2, "dx_cp_apar_mid1_pric_neveris"];
    sequences[sequences.size] = sequence;
    aliases = ["dx_cp_apar_mid1_gazz_gotkonnigroupingupne", "dx_cp_apar_mid1_gazz_imseeingkonniguardin", "dx_cp_apar_mid1_gazz_gotanungodlynumberof"];
    alias = aliases[randomint(aliases.size)];
    sequence = [level.player, 0.2, alias, level, 0.2, "dx_cp_apar_mid1_pric_copyyourecleartoenga"];
    sequences[sequences.size] = sequence;
  }

  endons = [level, "near_6th_floor_stairs", level, "stop_kill_first_guys_dialogue"];
  sequence = sequences[randomint(sequences.size)];
  level say_sequence(sequence, undefined, undefined, undefined, undefined, undefined, endons);
}

function function_9496e4c193844a95() {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("mid_1_trap_route");

  if(flag("broke_stealth_earlier")) {
    return;
  }

  level function_62b86e686212d678("dx_cp_apar_ntv1_pric_watchyourstepprobabl");
}

function function_b0bb187903b917f9() {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("player_near_blocked_stairs");

  if(level.player function_9cc921a57ff4deb5()) {
    flag_clear("player_near_blocked_stairs");
    return;
  }

  if(function_1e4aaaddfd5236ca()) {
    alias = "dx_cp_apar_mid1_gazz_stairsareblocked_01";
  } else {
    alias = "dx_cp_apar_mid1_gazz_stairsareblocked";
  }

  var_cf14848c064120ba = level.player say(alias, undefined, 0);

  if(!istrue(var_cf14848c064120ba)) {
    return;
  }

  wait 0.2;
  responses = ["dx_cp_apar_mid1_pric_findanotherwayup", "dx_cp_apar_mid1_pric_handleitsergeant", "dx_cp_apar_mid1_pric_rerouteplentyofwayst"];
  response = random(responses);
  level say(response, undefined, 0);
}

function function_83c1474813ed14a1() {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("entered_courtyard");
  wait 0.4;
  aliases = [];

  if(function_1e4aaaddfd5236ca()) {
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_movingoutsidethestru";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_movingexterior";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_headingoutside";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_goingexternal";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_egressingthebuilding";
  } else {
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_movingoutsidethestru_01";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_movingtoexterior";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_headingoutside_01";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_goingexternal_01";
    aliases[aliases.size] = "dx_cp_apar_mid1_gazz_egressingthebuilding_01";
  }

  level.player say(random(aliases));
}

function function_b644d6ef884bd03c() {
  level endon("game_ended");
  level endon("flag_apt_mid_1_complete");

  if(flag("flag_apt_mid_1_complete")) {
    return;
  }

  flag_wait("entered_ground_floor_courtyard");
  wait 5;
  level function_62b86e686212d678("dx_cp_apar_upr1_pric_takingthescenicroute");
  wait 0.3;
  level.player function_62b86e686212d678("dx_cp_apar_upr1_gazz_iliketobethorough");
  wait 1;
  level say("dx_cp_apar_upr1_pric_clockstickingarrick");
  wait 45;
  triggers = function_f159c10d5cf8f0b4("courtyard_tracking", "targetname");

  if(!level.player istouching(triggers[0])) {
    return;
  }

  level function_62b86e686212d678("dx_cp_apar_inre_pric_ascenderswillmakethe");
}

function function_9a6146ac4bf164ca() {
  level endon("game_ended");
  level endon("flag_apt_upper_complete");

  if(flag("flag_apt_upper_complete")) {
    return;
  }

  flag_wait("entered_courtyard");
  var_547ba329236fb1e7 = function_7a18da6e48b71c35("hvt_courtyard_standin");
  var_a55efd6f55a56a69 = spawn("script_origin", var_547ba329236fb1e7.origin);
  wait 30;
  var_a55efd6f55a56a69 say("dx_cp_apar_m1nr_noln_wehaveascheduletokee");
  wait 30;
  var_a55efd6f55a56a69 say("dx_cp_apar_m1nr_noln_keepitmovingweleaveb");
  wait 30;
  var_a55efd6f55a56a69 say("dx_cp_apar_m1nr_noln_wellmeetourgroundtea");
}

function function_e4565f1627bc7672() {
  level endon("game_ended");
  level endon("flag_apt_mid_complete");

  if(flag("flag_apt_mid_complete")) {
    return;
  }

  flag_wait("mid_2_trap_route");

  if(flag("broke_stealth_earlier")) {
    return;
  }

  wait 3;
}

function function_b93e7ab816ce1df0() {
  flag_wait("spawn_computer_hallway");
  level.var_e7564d2ab5aab260 = [level.computer_enemy];
  function_873ef3cd9a77e453("dx_cp_apar_rach_kon2_doesanyonehaveeyeson");
  flag_wait("start_computer_scene");
  level endon("hallway_guys_down");

  if(flag("spawn_computer_hallway_back")) {
    return;
  }

  if(isDefined(level.computer_enemy)) {
    function_873ef3cd9a77e453("dx_cp_apar_ntv1_kon5_behindus");
  }

  wait 1;
  enemy = random(level.var_2009c2f240a11712);
  level.var_e7564d2ab5aab260 = [enemy];
  function_873ef3cd9a77e453("dx_cp_apar_u1ko_kon4_takehimout");
  wait 0.5;
  enemy = random(level.var_2009c2f240a11712);
  level.var_e7564d2ab5aab260 = [enemy];
  function_873ef3cd9a77e453("dx_cp_apar_ntv1_kon1_shoothim");
}

function function_8e216772f4e0cce5() {
  flag_wait("player_near_container");
  level.player say("dx_cp_apar_cont_gazz_foundashortcut");
  flag_wait("start_container_scene");
  level.var_8f1b690e208d358f thread function_937ec86991da65e2();
  level say("dx_cp_apar_cont_pric_gazyougotoneontopofy");
  level.var_8f1b690e208d358f waittill("death");
  wait 1;

  if(istrue(level.var_2ff99aabf1f7224d)) {
    level.player say("dx_cp_apar_sove_gazz_appreciatethecoverbo");
    wait 0.2;
    level say("dx_cp_apar_move_pric_rog");
    return;
  }

  level.player say("dx_cp_apar_dcal_gazz_droppedem");
}

function function_937ec86991da65e2() {
  self endon("death");
  wait 1.6;
  level.var_8f1b690e208d358f say("dx_cp_apar_cont_kon7_hesinthecontainer");
}

function function_2dab584158f27c57() {
  level endon("game_ended");
  level endon("flag_apt_upper_complete");

  if(flag("flag_apt_upper_complete")) {
    return;
  }

  flag_wait("move_enemies_upper_020");
  level say("dx_cp_apar_upr1_pric_gazyourealmosttother");
}

function function_41581fcd95acbc60() {
  level endon("game_ended");
  level endon("flag_apt_upper_complete");

  if(flag("flag_apt_upper_complete")) {
    return;
  }

  flag_wait("upper_1_shortcut_route");
  level function_62b86e686212d678("dx_cp_apar_cont_pric_whodareswins");
  wait 0.5;
  level.player function_62b86e686212d678("dx_cp_apar_cont_gazz_foundashortcut");
}

function function_1e8ef6cb45712c73() {
  level endon("game_ended");
  level endon("ally_can_rappel");
  flag_wait("near_upper_2_equipment");
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
  level.player say("dx_cp_apar_upr2_gazz_foundtheircommscente");
  wait 0.5;
  level say("dx_cp_apar_upr2_pric_thiswholelocationsbu");
  level.player say("dx_cp_apar_upr2_gazz_wewillnotleaveemptyh");
  flag_set("vo_near_ladder");
}

function vo_near_ladder() {
  level endon("ally_can_rappel");
  flag_wait("vo_near_ladder");

  if(flag("near_upper_2_equipment")) {
    wait 2;
  }

  level say("dx_cp_apar_upr2_pric_nolanwontgodowneasy");
  wait 0.2;
  level.player say("dx_cp_apar_upr2_gazz_thenhesinforaworldoh");
}

function function_421fcd37d6e828e7() {
  level endon("game_ended");
  level endon("hostage_downed");

  if(flag("hostage_downed")) {
    return;
  }

  flag_wait("roof_entered");

  while(!isDefined(level.hvt)) {
    wait 0.5;
  }

  level.hvt say("dx_cp_apar_roof_noln_getonthoseperchesext");
}

function function_5d53ad6a2e5b7c1a() {
  level endon("game_ended");
  level endon("hostage_downed");

  if(flag("hostage_downed")) {
    return;
  }

  flag_wait("player_detected_on_roof");
  wait 20;
  var_d1f118fb73bc8a6 = 800;
  function_345b441e6d9da33c(level.hvt, var_d1f118fb73bc8a6);
  level.hvt say("dx_cp_apar_roof_noln_hostilesontheroofall");
  wait 20;
  function_345b441e6d9da33c(level.hvt, var_d1f118fb73bc8a6);
  level.hvt say("dx_cp_apar_roof_noln_allteamswevegothosti");
  wait 20;
  function_345b441e6d9da33c(level.hvt, var_d1f118fb73bc8a6);
  level.hvt say("dx_cp_apar_roof_noln_charlieteamthisis21i");
}

function function_42dda48a62b633f6() {
  level endon("move_price_to_roof");
  flag_wait("balcony_clear");

  if(level.var_bb473981236c9e8a == 1) {
    level.player say("dx_cp_apar_sove_gazz_goodkillcap", 1, 0);
  } else if(level.var_bb473981236c9e8a >= 2) {
    level.player say("dx_cp_apar_sove_gazz_solidshotssix", 1, 0);
  }

  level say("dx_cp_apar_roof_pric_copycominyourwaynowg", 1, 0);
}

function function_d8911be5bb7a816b() {
  level endon("player_sees_roof_vista");
  level endon("obj_find_hostage_completed");

  if(flag("obj_find_hostage_completed")) {
    return;
  }

  flag_wait("move_price_to_roof");
  wait 0.1;
  level.ally say("dx_cp_apar_roof_pric_lightupeverythingtha", 2, 0);
  level.player say("dx_cp_apar_roof_gazz_check", 2, 0);
}

function function_81d8b57d5cc6b325() {
  level endon("game_ended");
  level endon("obj_secure_hostage_completed");

  if(flag("obj_secure_hostage_completed")) {
    return;
  }

  flag_wait("player_sees_roof_vista");
  level.player say("dx_cp_apar_roof_gazz_eyesonnolanbeadvised", 3, 0);
  level.ally say("dx_cp_apar_roof_pric_checkshoottoincapaci");
  level.player say("dx_cp_apar_roof_gazz_youreabuzzkillsir");
}

function function_b01862fb01f4df3c() {
  level endon("hostage_downed");
  flag_wait("player_sees_roof_vista");
  wait 2;
  level.hvt say("dx_cp_apar_roof_noln_getonthoseperchesext");
  flag_wait("player_detected_on_roof");
  level.hvt say("dx_cp_apar_roof_noln_thereheisbringhimdow");
  flag_wait("start_flare_anim_vo");
  level.hvt say("dx_cp_apar_roof_noln_charlieteamthisis21i");
  var_de74b72b962ec971 = ["dx_cp_apar_roof_noln_hostilesontheroofall", "dx_cp_apar_roof_noln_allteamswevegothosti", "dx_cp_apar_roof_noln_icounttwohostileslig"];

  for(i = 0; i < 2; i++) {
    wait 3;
    var_5fd4c51a5e2c0029 = random(var_de74b72b962ec971);
    level.hvt say(var_5fd4c51a5e2c0029);
    var_de74b72b962ec971 = array_remove(var_de74b72b962ec971, var_5fd4c51a5e2c0029);
  }
}

function function_e6ae109c49671dbc() {
  flag_wait("start_flare_anim_vo");
  wait 15;
  level say("dx_cp_apar_roof_lasw_bravobeadvisedradars");
  wait 2;
  level.ally say("dx_cp_apar_roof_pric_copythatgazletsgetam");
}

function function_6ac61054bf40ecc7() {
  flag_wait("start_grenade_toss");
  wait 1.5;
  level.ally say("dx_cp_apar_roof_pric_theyrethrowingsmoke");
}

function function_cfb293515004f084() {
  flag_wait("player_near_stronghold_corner");
  level.player say("dx_cp_apar_roof_gazz_wegothimcornered");
}

function function_20efa67a317ecbcc() {
  level endon("game_ended");
  level endon("obj_secure_roof_completed");

  if(flag("obj_secure_roof_completed")) {
    return;
  }

  flag_wait("hostage_enter_downed_state");
  wait 1;

  while(!level.player function_ca9c35fd0715a998(level.player, level.hvt)) {
    wait 0.1;
  }

  level.player say("dx_cp_apar_roof_gazz_6targetisdown");
  thread function_a236ff21ca0f4e27();
  flag_set("hvt_down_callout_done");
  level.var_67879e03aaea08eb = gettime();
  level.ally say("dx_cp_apar_roof_pric_copyhvidowncleanwork");
  flag_set("hvt_down_vo_done");
}

function function_a236ff21ca0f4e27() {
  stopmusicstate("mx_apt_roof");
}

function function_e6e969e56305e2d1() {
  level endon("obj_secure_roof_completed");
  flag_wait("hvt_down_vo_done");
  wait 5;
  level.ally say("dx_cp_apar_rona_pric_stillgothostilesonth");
  wait 10;
  level.ally say("dx_cp_apar_rona_pric_cleartheareaandsecur");
}

function function_ddbf55cb7ed6bbb1() {
  level endon("start_hvt_convo");
  level endon("player_carrying_hvt");
  flag_wait("obj_secure_roof_completed");

  if(flag("player_carrying_hvt")) {
    return;
  }

  while(!level.player function_ca9c35fd0715a998(level.player, level.hvt)) {
    wait 0.1;
  }

  if(!flag("hvt_down_callout_done")) {
    level.player say("dx_cp_apar_capt_gazz_goteyesonandreinolan");
  } else if(isDefined(level.var_67879e03aaea08eb) && gettime() > level.var_67879e03aaea08eb + 5000) {
    level.player say("dx_cp_apar_capt_gazz_goteyesonandreinolan");
  }

  level.ally say("dx_cp_apar_roof_pric_gazmovetosecureifhes");
  wait 4;
  level.ally say("dx_cp_apar_capt_pric_takehimaliveweneedwh");
  wait 1;
  level.ally say("dx_cp_apar_roof_pric_watchersecuringhvica");
}

function function_ca9c35fd0715a998(player, ai) {
  currenttime = gettime();

  if(isDefined(ai.playerseesmetime) && ai.playerseesmetime >= currenttime) {
    assert(isDefined(ai.playerseesme));
    return ai.playerseesme;
  }

  ai.playerseesmetime = currenttime;

  if(!within_fov(player.origin, player.angles, ai.origin, 0.766)) {
    ai.playerseesme = 0;
    return 0;
  }

  playereye = player getEye();
  feetorigin = ai.origin;
  eyeorigin = ai getapproxeyepos();

  if(sighttracepassed(playereye, eyeorigin, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  midorigin = (eyeorigin + feetorigin) * 0.5;

  if(sighttracepassed(playereye, midorigin, 1, player, ai)) {
    ai.playerseesme = 1;
    return 1;
  }

  ai.playerseesme = 0;
  return 0;
}

function function_cf5f249143725c3d() {
  level.player waittill("hostage_picked_up");
  level endon("nearing_blimp_platform");
  level.ally say("dx_cp_apar_hoaf_pric_gazwegotenemyhelosco");
  wait 0.5;
  level.player say("dx_cp_apar_hoaf_gazz_bravotowatchertarget");
  level say("dx_cp_apar_roof_lasw_copythatyankeeinboun");
  flag_set("exfil_info_vo_done");
  level.player say("dx_cp_apar_hoaf_gazz_copy");
  wait 1;
  level.ally say("dx_cp_apar_hoaf_pric_letshopewegotenoughc");
  wait 2;
  level.player say("dx_cp_apar_hoaf_gazz_theyreallywanttheirb");
  wait 0.5;
  level.ally say("dx_cp_apar_hoaf_pric_welltheycanthavehim");
}

function function_408720b52e461941() {
  level endon("game_ended");
  level endon("obj_reach_exfil_completed");

  if(flag("obj_reach_exfil_completed")) {
    return;
  }

  flag_wait("player_detected_on_roof");
  wait 10;
  var_e56a2d79827df9e2 = ["dx_cp_apar_rona_pric_gaznolanisontheroofw", "dx_cp_apar_rona_pric_sergeanttargetisonth", "dx_cp_apar_rona_pric_getingeargazmakarovs", "dx_cp_apar_rona_pric_gaznolanisontheroofl", "dx_cp_apar_rona_pric_sergeanttargetisonth_01", "dx_cp_apar_rona_pric_gaznolanisdownrangew"];

  for(var_970e5ba01e1c53db = var_e56a2d79827df9e2; true; var_970e5ba01e1c53db = var_e56a2d79827df9e2) {
    wait 5;

    if(level.player.origin[2] > 1800) {
      continue;
    }

    delay = growing_delay(5, 20, var_e56a2d79827df9e2.size);
    waitfor(delay);
    var_1a30dd66e0eedf = random(var_970e5ba01e1c53db);
    level.ally say(var_1a30dd66e0eedf);
    var_970e5ba01e1c53db = array_remove(var_970e5ba01e1c53db, var_1a30dd66e0eedf);

    if(var_970e5ba01e1c53db.size == 0) {}
  }
}

function function_5f7d6b12ff64a4fe() {
  level endon("game_ended");
  level endon("attach_interact_used");

  if(flag("attach_interact_used")) {
    return;
  }

  flag_wait("nearing_blimp_platform");

  if(getaiarray("axis").size > 1) {
    level.ally say("dx_cp_apar_hoaf_pric_gazgetnolanhookedint");
  } else {
    level.ally say("dx_cp_apar_hoan_pric_latchthetargetuptoth");
  }

  wait 5;
  nags = ["dx_cp_apar_hoan_pric_hookinseargantletsgo", "dx_cp_apar_hoan_pric_garrickhooknolanin"];

  while(true) {
    delay = growing_delay(10, 30, 5);
    waitfor(delay);
    level.ally say(random(nags));
  }
}

function function_909cc32cc72988cc() {
  flag_wait("attach_interact_used");
  wait 7;
  level.ally say("dx_cp_apar_dfen_pric_morehelosinboundkeep");
  level notify("vo_exfil_nik_update");
  flag_wait_either("helo_3_unload", "helo_4_unload");
  wait 12;
  level.ally say("dx_cp_apar_dfen_pric_helosaredroppingmore");
  flag_wait("final_helo_unloading");
  level.ally say("dx_cp_apar_dfen_pric_wereabouttobeoverrun");
  level notify("vo_exfil_nik_update");
}

function function_1f85392609ffa50f() {
  flag_wait("attach_interact_used");
  level waittill("vo_exfil_nik_update");
  wait 6;
  level say("dx_cp_apar_dfen_niko_skyhooktwoclicksout");
  level waittill("vo_exfil_nik_update");
  level say("dx_cp_apar_dfen_niko_skyhookoneclickout");
  level waittill("vo_exfil_nik_update");
  level say("dx_cp_apar_dfen_niko_skyhooktwomikesout");
  flag_wait("spawn_next_helos");
  level say("dx_cp_apar_dfen_niko_skyhookonemikeout");
}

function function_82710c32d74b4ff3() {
  level endon("exfil_attach_used");
  flag_wait("final_helo_unloading");
  level waittill("vo_exfil_nik_update");
  wait 0.5;
  level say("dx_cp_apar_dfen_niko_yankeewillentertheao");
  flag_wait("player_can_exfil");
  level say("dx_cp_apar_defn_niko_skyhookimminentbravo");
  level notify("exfil_start_price_nags");

  while(true) {
    delay = growing_delay(5, 30, 5);
    waitfor(delay);
    level say("dx_cp_apar_defn_niko_yankeeonapproach");
  }
}

function function_6c8838a2e5acbc63() {
  level endon("exfil_attach_used");
  flag_wait("player_can_exfil");
  level waittill("exfil_start_price_nags");
  wait 1;
  nags = ["dx_cp_apar_defn_pric_gazattachyourselftot", "dx_cp_apar_defn_pric_gettotheexfilandhook", "dx_cp_apar_defn_pric_strapyourselftotheta"];
  level.ally say(nags[0]);
  wait 5;
  level.ally say(nags[1]);
  wait 8;
  level.ally say(nags[2]);

  while(true) {
    delay = growing_delay(10, 25, nags.size);
    waitfor(delay);
    level.ally say(random(nags));
  }
}

function function_10ec9a884b8c5fc5() {
  level endon("game_ended");
  flag_wait("exfil_attach_used");
  wait 1.5;
  var_926d1dba8f99510 = ["dx_cp_apar_xfil_gazz_readycap", "dx_cp_apar_xfil_gazz_weresetsir"];
  level.player say(random(var_926d1dba8f99510));
  wait 1;
  var_75b7d6a3b1aec38f = ["dx_cp_apar_xfil_pric_neatandcompletekyleh", "dx_cp_apar_xfil_pric_jobwelldonesergeanth"];
  level.ally say(random(var_75b7d6a3b1aec38f));
}

function function_2fec7e4049183fe0() {
  flag_wait("start_mission_flow");
  level.player endon("death");
  level endon("stop_price_callouts");
  function_5dbbdb20865cde92();
  level.player thread function_dc359a0917fa9f97();

  if(flag("stop_price_callouts")) {
    return;
  }

  flag_set("price_callout_enabled");

  while(true) {
    flag_wait("price_callout_enabled");
    wait 1;

    if(function_1e4aaaddfd5236ca()) {
      var_3c8e1c51f5b910aa = function_161db85afb8ac2fe();
    } else {
      var_3c8e1c51f5b910aa = function_f1379cf9286b03ea();
    }

    if(var_3c8e1c51f5b910aa) {
      continue;
    }

    var_3c8e1c51f5b910aa = function_56bb368f21000579();

    if(var_3c8e1c51f5b910aa) {
      continue;
    }
  }
}

function function_5dbbdb20865cde92() {
  level.callout = spawnStruct();
  level.callout.var_5b08c2aed6624cc0["enemy"] = 0;
  level.callout.var_5b08c2aed6624cc0["enemy_left_or_right"] = 0;
  level.callout.var_5b08c2aed6624cc0["enemy_hunting"] = 0;
  level.callout.var_5b08c2aed6624cc0["trap"] = 0;
  level.callout.var_80213604487c07d3["trap"] = (0, 0, 0);
  level.callout.playerfov = cos(30);
  level.callout.data = [];
  setdvarifuninitialized(@ "hash_bc518e536ab39d41", 0);
  level.callout.var_ccfd97347d63cea = [];
  level.callout.var_ccfd97347d63cea["trap"] = function_f159c10d5cf8f0b4("no_callout_trap", "targetname");
  aliases = ["dx_cp_apar_dcal_pric_threatsyourleftgarri", "dx_cp_apar_dcal_pric_enemiestotheleft"];
  function_fa602774be18d4a2("enemy_dir_left", aliases);
  aliases = ["dx_cp_apar_dcal_pric_enemiestotheright", "dx_cp_apar_dcal_pric_checkrightforenemies", "dx_cp_apar_dcal_pric_konnisoldiersrightsi"];
  function_fa602774be18d4a2("enemy_dir_right", aliases);
  aliases = ["dx_cp_apar_dcal_pric_checkfrontforenemies", "dx_cp_apar_dcal_pric_enemies12oclock", "dx_cp_apar_dcal_pric_youshouldbeseeingkon", "dx_cp_apar_dcal_pric_headfrontyougotgunsa"];
  function_fa602774be18d4a2("enemy_dir_ahead", aliases);
  aliases = ["dx_cp_apar_dcal_pric_enemiesbehindyou"];
  function_fa602774be18d4a2("enemy_dir_behind", aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_keepalertgaztheyrelo";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_theyrelookingforyoug";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_staysharpgazkonnison";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_dontletyourguarddown";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_beadvisedgazkonnisol";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_sergeantkonnistryina";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_theyhuntingforyougaz";
  function_fa602774be18d4a2("enemy_hunting", aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_gazkeepwatchforclaym";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_staysharpiseeclaymor";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_stayfrostyforclaymor";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_keepwatchforclaymore";
  function_fa602774be18d4a2("claymore", array_randomize(aliases));
  aliases = [];
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_eyesoutfortrapsinyou";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_headsupfortrapsgaz";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_watchfortrapsinthere";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_watchforchargesinyou";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_headsupforchargesgaz";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_gazmindthetrapahead";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_watchyoursteparealoo";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_watchyourstepareacou";
  aliases[aliases.size] = "dx_cp_apar_dcal_pric_mindwhereyourewalkso";
  function_fa602774be18d4a2("trap", array_randomize(aliases));
}

function function_4bb3316282fa6db4(dir) {
  return function_fa140c0764afb93("enemy_dir_" + dir);
}

function function_fa140c0764afb93(type) {
  data = function_5cbd0ea33d4084d9(type);
  data.index++;

  if(data.index == data.aliases.size) {
    data.index = 0;
    data.aliases = array_randomize(data.aliases);
  }

  return data.aliases[data.index];
}

function function_5cbd0ea33d4084d9(type) {
  return level.callout.data[type];
}

function function_91db54a0b3cc4c2b(type) {
  return level.callout.data[type].aliases;
}

function function_fa602774be18d4a2(type, data) {
  if(!isarray(data)) {
    data = [data];
  }

  struct = spawnStruct();
  struct.aliases = data;
  struct.index = -1;

  if(!isDefined(level.callout.data[type])) {
    level.callout.data[type] = [];
  }

  level.callout.data[type] = struct;
}

function function_161db85afb8ac2fe() {
  if(gettime() < level.callout.var_5b08c2aed6624cc0["enemy"]) {
    return false;
  }

  guys = getaiarray("axis");

  if(guys.size == 0) {
    return false;
  }

  guys = array_removedead_or_dying(guys);
  guys = sortbydistance(guys, level.player.origin);
  closest_guy = undefined;
  var_903d1163c9b5266c = undefined;
  debugmsg = "";

  foreach(guy in guys) {
    if(istrue(guy.var_c88fcc14f9bda088)) {
      guy function_e78241389b3e9317("<dev string:x1c>");

      continue;
    }

    if(guy function_dc00d02aa2f067f(closest_guy)) {
      continue;
    }

    distsqrd = distancesquared(level.player.origin, guy.origin);

    if(distsqrd > 4000000) {
      guy function_e78241389b3e9317("<dev string:x24>");

      continue;
    }

    if(!guy function_db81576f206a1ab7(level.player)) {
      guy function_e78241389b3e9317("<dev string:x31>");

      continue;
    }

    var_8053ce4fa8fe3218 = 1;

    if(isDefined(closest_guy) && !function_936be12ad1016e63(closest_guy, var_903d1163c9b5266c, guy)) {
      continue;
    }

    if(distsqrd < 40000) {
      in_fov = within_fov(level.player getEye(), level.player getplayerangles(), guy getEye(), level.callout.playerfov);

      if(in_fov) {
        guy function_e78241389b3e9317("<dev string:x46>");

        continue;
      }
    }

    if(var_8053ce4fa8fe3218 && !guy cansee(level.player)) {
      guy function_e78241389b3e9317(debugmsg + "<dev string:x67>");

      continue;
    }

    if(!isDefined(closest_guy)) {
      var_903d1163c9b5266c = vectorNormalize(flat_origin(guy.origin) - flat_origin(level.player.origin));
      closest_guy = guy;
      break;
    }
  }

  if(!isDefined(closest_guy)) {
    return false;
  }

  var_73b18218ea8ec580 = function_f7fca5ff69effe3a(closest_guy);

  if(!isDefined(var_73b18218ea8ec580)) {
    return false;
  }

  if(var_73b18218ea8ec580 == "right" || var_73b18218ea8ec580 == "left") {
    if(gettime() < level.callout.var_5b08c2aed6624cc0["enemy_left_or_right"]) {
      return false;
    }

    if(level.player.var_ec3c743b093a0213 > 0) {
      level.callout.var_5b08c2aed6624cc0["enemy_left_or_right"] = gettime() + randomintrange(3000, 7000);
      return false;
    }

    level.callout.var_5b08c2aed6624cc0["enemy_left_or_right"] = gettime() + randomintrange(18000, 25000);
  }

  if(getdvarint(@ "hash_bc518e536ab39d41")) {
    line(closest_guy.origin, level.player.origin, (1, 0, 0), 1, 1, 20);
  }

  closest_guy.var_16b75ff80e325c75 = gettime() + 60000;
  alias = function_4bb3316282fa6db4(var_73b18218ea8ec580);
  level callout_say(alias);
  level.callout.var_5b08c2aed6624cc0["enemy"] = gettime() + randomintrange(6000, 13000);
  return true;
}

function function_f1379cf9286b03ea() {
  if(gettime() < level.callout.var_5b08c2aed6624cc0["enemy_hunting"]) {
    return false;
  }

  guys = function_2cefd0205583ac50();

  if(guys.size == 0) {
    return false;
  }

  guys = sortbydistance(guys, level.player.origin);
  closest_guy = undefined;

  foreach(guy in guys) {
    if(istrue(guy.var_c88fcc14f9bda088)) {
      continue;
    }

    distsqrd = distancesquared(level.player.origin, guy.origin);

    if(distsqrd > 90000) {
      continue;
    }

    if(abs(guy.origin[2] - level.player.origin[2]) > 180) {
      continue;
    }

    if(!isDefined(closest_guy)) {
      closest_guy = guy;
      break;
    }
  }

  if(!isDefined(closest_guy)) {
    return false;
  }

  closest_guy.var_16b75ff80e325c75 = gettime() + 60000;
  alias = function_fa140c0764afb93("enemy_hunting");
  level callout_say(alias);
  level.callout.var_5b08c2aed6624cc0["enemy_hunting"] = gettime() + randomintrange(9000, 16000);
  return true;
}

function function_db81576f206a1ab7(other) {
  if(!isDefined(self.building)) {
    function_995f9a44a436cfce();
  }

  if(!isDefined(self.building)) {
    return false;
  }

  if(!isalive(other)) {
    return false;
  }

  if(isPlayer(other)) {
    var_e158826062e1dce = function_3c2f10ae0ccbe003();

    if(!isDefined(var_e158826062e1dce)) {
      var_e158826062e1dce = "outside";
    }
  } else {
    if(!isDefined(other.building)) {
      other function_995f9a44a436cfce();
    }

    var_e158826062e1dce = other.building;
  }

  return self.building == var_e158826062e1dce;
}

function function_995f9a44a436cfce() {
  var_26d4bc420f7164b8 = function_f159c10d5cf8f0b4("northbuilding_tracking", "targetname");
  var_24f6e3ab7856fd82 = function_f159c10d5cf8f0b4("southbuilding_tracking", "targetname");
  building = undefined;

  foreach(trigger in var_26d4bc420f7164b8) {
    if(self istouching(trigger)) {
      self.building = "north";
      return;
    }
  }

  if(!isDefined(building)) {
    foreach(trigger in var_24f6e3ab7856fd82) {
      if(self istouching(trigger)) {
        self.building = "south";
        return;
      }
    }
  }
}

function function_936be12ad1016e63(closest_guy, var_903d1163c9b5266c, guy) {
  if(guy.origin[2] - closest_guy.origin[2] > 90) {
    guy function_e78241389b3e9317("<dev string:x7a>");

    return false;
  }

  dir = vectorNormalize(flat_origin(guy.origin) - flat_origin(level.player.origin));
  dot = vectordot(var_903d1163c9b5266c, dir);

  if(dot < 0.707) {
    guy function_e78241389b3e9317("<dev string:x9b>");

    return false;
  }

  return true;
}

function function_dc00d02aa2f067f(closest_guy) {
  if(!isDefined(self.var_16b75ff80e325c75)) {
    return false;
  }

  if(isDefined(closest_guy) && self.var_16b75ff80e325c75 - gettime() > 3) {
    function_e78241389b3e9317("<dev string:xb5>", (0, 1, 0));

    return false;
  } else if(!isDefined(closest_guy) && gettime() < self.var_16b75ff80e325c75) {
    function_e78241389b3e9317("<dev string:xd9>");

    return true;
  }

  return false;
}

function function_e78241389b3e9317(msg, color) {
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  if(getdvarint(@ "hash_bc518e536ab39d41")) {
    print3d(self.origin, msg, color, 1, 0.6, 20, 1);
  }
}

function function_56bb368f21000579() {
  if(gettime() < level.callout.var_5b08c2aed6624cc0["trap"]) {
    return false;
  }

  if(distancesquared(level.callout.var_80213604487c07d3["trap"], level.player.origin) < 10000) {
    return false;
  }

  if(function_47c8cd789feec17d("trap")) {
    level.callout.var_5b08c2aed6624cc0["trap"] = gettime() + 5000;
    return false;
  }

  level.callout.var_80213604487c07d3["trap"] = (0, 0, 0);
  traps = [];

  if(level.var_804a2874c0323da7.size > 0) {
    traps = array_combine(traps, level.var_804a2874c0323da7);
  }

  if(level.laser_traps.size > 0) {
    traps = array_combine(traps, level.laser_traps);
  }

  traps = array_removeundefined(traps);

  if(traps.size == 0) {
    return false;
  }

  traps = sortbydistance(traps, level.player.origin);
  var_deeadd38f0232523 = undefined;

  foreach(trap in traps) {
    if(isDefined(trap.team) && trap.team == "allies") {
      trap function_e78241389b3e9317("<dev string:xe9>");

      continue;
    } else if(trap function_91bfba70ba3d3256()) {
      trap function_e78241389b3e9317("<dev string:xf7>");

      continue;
    }

    if(trap function_dc00d02aa2f067f()) {
      continue;
    }

    distsqrd = distancesquared(level.player.origin, trap.origin);

    if(distsqrd > 90000) {
      trap function_e78241389b3e9317("<dev string:x106>");

      continue;
    }

    if(abs(trap.origin[2] - level.player.origin[2]) > 90) {
      trap function_e78241389b3e9317("<dev string:x115>");

      continue;
    }

    if(!sighttracepassed(trap.origin, level.player getEye(), 0, trap)) {
      trap function_e78241389b3e9317("<dev string:x131>");

      continue;
    }

    var_deeadd38f0232523 = trap;
    break;
  }

  if(!isDefined(var_deeadd38f0232523)) {
    return false;
  }

  type = "trap";

  if(isDefined(var_deeadd38f0232523.weapon_name) && var_deeadd38f0232523.weapon_name == "jup_claymore_cp") {
    type = "claymore";
  }

  foreach(trap in level.laser_traps) {
    if(trap == var_deeadd38f0232523) {
      continue;
    }

    if(distancesquared(trap.origin, var_deeadd38f0232523.origin) < 62500) {
      trap.var_16b75ff80e325c75 = gettime() + 30000;
    }
  }

  var_deeadd38f0232523.var_16b75ff80e325c75 = gettime() + 30000;
  level.callout.var_80213604487c07d3["trap"] = level.player.origin;
  alias = function_fa140c0764afb93(type);
  level.player callout_say(alias);
  level.callout.var_5b08c2aed6624cc0["trap"] = gettime() + 20000;
  return true;
}

function function_47c8cd789feec17d(type) {
  if(!isDefined(level.callout.var_ccfd97347d63cea[type])) {
    return false;
  }

  foreach(trigger in level.callout.var_ccfd97347d63cea[type]) {
    if(level.player istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function callout_say(alias, ent) {
  level notify("callout_say");
  say(alias, undefined, 0);
}

function function_91bfba70ba3d3256() {
  if(!istrue(self.laser_trap)) {
    return false;
  }

  if(!isDefined(self.hint_obj)) {
    return true;
  }

  if(!isDefined(self.hint_obj.owner)) {
    return false;
  }

  return self.hint_obj.owner == level.player;
}

function function_a6ee2346a2b961bf(time) {
  time *= 1000;

  foreach(_ in level.callout.var_5b08c2aed6624cc0) {
    level.callout.var_5b08c2aed6624cc0[i] = gettime() + time;
  }
}

function function_7f9bc6a284801043(type, time) {
  level.callout.var_5b08c2aed6624cc0[type] = gettime() + time * 1000;
}

function function_dc359a0917fa9f97() {
  level endon("game_ended");
  self endon("death");
  delta = 0;
  prev = 0;
  minangle = 5;
  var_ca9fc0037af496c = minangle * 10;

  while(true) {
    delta += abs(self.angles[1] - prev) - minangle;
    delta = clamp(delta, 0, var_ca9fc0037af496c);
    self.var_ec3c743b093a0213 = delta;
    prev = self.angles[1];
    waitframe();
  }
}