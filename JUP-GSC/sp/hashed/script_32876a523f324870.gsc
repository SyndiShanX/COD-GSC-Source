/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_32876a523f324870.gsc
*************************************************/

#using script_4ab4bd3ef85fb34c;
#using script_5d0aad069db3eeb8;
#using script_5d5ed488e7b712ab;
#using script_691cea1edc5b7e41;
#using script_71b48ffe76b07d2;
#using script_a6f526f54ee52f7;
#using scripts\aitypes\combat;
#using scripts\anim\combat_utility;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\damagefeedback;
#using scripts\sp\door;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting;
#using scripts\sp\player;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace namespace_aa821a9218e60e7b;

function function_489fd3094f4eb769() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_enter", array_add(level.allies, level.player));
  activate_trigger_with_targetname("trigger_color_concourse_stackup");
  thread set_flag_on_targetname_trigger("trigger_concourse_start");
  level.player setsoundsubmix("sp_jup_flashback_intro_stairwell", 3.5);
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_cac0d6c867a55103);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }
}

function function_f8489d92e5a8e479() {
  flag_wait("radtrig_player_in_stairwell");
  function_90a7f510097cffd3();
  function_18fba09d8d521583();
  function_cec768382d475778(0);
  thread function_690d01bfac087d01();
  thread function_fa6808088cd6c88d();
  thread function_86b791c1893be31b();
  thread function_906beb56a64295c2();
  namespace_47819225b08b445d::function_bbe10cdead87303b("trigger_concourse_start", "infil_stairs_player_at_top");
  level notify("stop_repeating_doorway_stairs_walla");
  exploder("inside_stadium_fx");
  function_af71e5d06fda8b30(1);
}

function function_906beb56a64295c2() {
  trigger_wait_targetname("trigger_concourse_start");
  level.player clearsoundsubmix("sp_jup_flashback_intro_stairwell", 3.5);
  level notify("stop_repeating_doorway_stairs_walla");
}

function function_cec768382d475778(var_15290fcc81ff476e) {
  if(!isDefined(var_15290fcc81ff476e)) {
    var_15290fcc81ff476e = 0;
  }

  foreach(ally in level.allies) {
    if(var_15290fcc81ff476e) {
      ally namespace_47819225b08b445d::function_363c08ddb86b8493();
      ally.baseaccuracy = ally.og_baseaccuracy;
      continue;
    }

    ally namespace_47819225b08b445d::function_e59f66b2ecf3471f();
    ally.og_baseaccuracy = ally.baseaccuracy;
  }
}

function function_e85c076ff6aa136() {
  exploder("inside_stadium_fx");
  function_90a7f510097cffd3();
  function_18fba09d8d521583();
  flag_set("concourse_enter_vo_done");
  function_f4b26798e8723de9();
}

function function_690d01bfac087d01() {
  flag_init("concourse_enter_vo_done");
  flag_wait("vo_shield_moment_done");

  if(!flag("trigger_concourse_start")) {
    if(!flag("infil_stairs_player_at_top")) {
      var_8e1a2cd34275a5bb = ["dx_sp_flas_shld_pric_upthestairs", "dx_sp_flas_shld_pric_needyouwithussergean", "dx_sp_flas_shld_pric_soapweremovingonthec"];
      level.price thread nagtill([level, "infil_stairs_player_at_top"], var_8e1a2cd34275a5bb, 5, 2);
      flag_wait("infil_stairs_player_at_top");
    }

    var_3ca0ae7d09ba2480 = getEnt("trigger_infil_stairs_top", "targetname");

    if(level.player istouching(var_3ca0ae7d09ba2480)) {
      level.price say_team("dx_sp_flas_stcn_pric_contactfront", undefined, undefined, undefined, 2);
    } else {
      level.player say_team("dx_sp_flas_stcn_soap_contactfront", undefined, undefined, undefined, 0.2);
    }
  } else {
    level.player say_team("dx_sp_flas_stcn_soap_contactfront", undefined, undefined, undefined, 0.2);
  }

  flag_set("concourse_enter_vo_done");
}

function function_6e67e3f9eb00d5e0() {
  thread set_flag_on_targetname_trigger("trigger_concourse_a");
  thread set_flag_on_targetname_trigger("trigger_concourse_b");
  thread set_flag_on_targetname_trigger("trigger_concourse_c");
  thread set_flag_on_targetname_trigger("trigger_concourse_d");
  thread set_flag_on_targetname_trigger("trigger_concourse_e");
}

function function_d5667fa5953a9f50() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_combat", array_add(level.allies, level.player));
  function_cec768382d475778(0);
  level.player thread function_be2529906db91d65();
  delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_ally_a");
  level.player setsoundsubmix("sp_jup_flashback_concourse", 3.5);
}

function concourse_a_main() {
  thread function_6b4d0d9d3243e5e5();
  namespace_5e9fb42dea43f1f0::function_def2ca6a173dd447();
  function_b3e5fcdd53c3371b();
  function_6e67e3f9eb00d5e0();
  level.player setsoundsubmix("sp_jup_flashback_concourse", 3.5);
  thread function_3c107eb6737f7f48();
  thread function_b955dce8af519940();
  thread concourse_combat_a();
  thread function_13635c1df73f29c3();
  delaythread(5, &function_44f3a6520a2ca727);
  level delaythread(8, &function_b5176a6465a5455b);
  thread concourse_execute();
  thread function_970d6a08ab976df7();
  thread function_875d4520c51812b();
  thread function_be1adb2e63b21688();
}

function function_3c107eb6737f7f48() {
  flag_wait("p1stairs_shield_done");
  wait 1;

  if(!flag("trigger_concourse_a")) {
    activate_trigger_with_targetname("trigger_concourse_ally_a");
    thread function_d709e6bfd067c199();
  }

  level.player delaythread(4, &function_be2529906db91d65);
}

function function_d709e6bfd067c199() {
  level.price disable_ai_color();
  level.price setgoalpos((31510.3, 2862.5, -672), 64);
  level.price disable_arrivals();
  level.price waittill_any_timeout(3, "goal");
  level.price enable_arrivals();
  level.price enable_ai_color();
}

function function_87d743691911c137() {
  delaythread(1, &flag_set, "stop_looping_civs_concourse_a");
  function_b3e5fcdd53c3371b();
  function_6e67e3f9eb00d5e0();
  flag_set("concourse_a_vo_done");
  thread function_13635c1df73f29c3();
}

function function_b955dce8af519940() {
  flag_init("concourse_a_vo_done");
  flag_wait("concourse_enter_vo_done");
  thread function_94cb0acf22c313fc();
  thread function_387da36ac753f03a();
  thread function_7677054903389a99();
  thread function_f07419b945642405();
  thread function_7467c372b4d2edef();
  thread function_b869434a1e0a1d8b();
  civ = getclosest(level.player.origin, namespace_5e9fb42dea43f1f0::function_1b73273370d27c99(), 1000);

  if(isDefined(civ)) {
    civ playsoundonmovingent("dx_sp_flas_stcn_rmc1_thepoliceareshooting");
  }

  flag_wait("concourse_execution_enemies_dead");
  flag_set("pause_warning_vo");
  level.price function_fc0eb6b81c66c661(0.5, "dx_sp_flas_stcn_pric_goldeaglebravo6werei");
  level.shepherd function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcn_shep_copyallpoliceontarge");
  level.price function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcn_pric_rogerthat");
  flag_clear("pause_warning_vo");
  thread function_8a516e070a5a0851();
  flag_set("concourse_a_vo_done");
}

function function_f07419b945642405() {
  level endon("trigger_concourse_e");
  nags = create_deck(["dx_sp_flas_stcn_pric_movemove", "dx_sp_flas_stcn_pric_staydown", "dx_sp_flas_stcn_pric_getdown", "dx_sp_flas_stcn_pric_getofouthere", "dx_sp_flas_stcn_pric_rungo"]);

  while(true) {
    flag_waitopen("pause_warning_vo");
    level.price say(nags deck_draw());
    wait randomintrange(20, 25);
  }
}

function function_b869434a1e0a1d8b() {
  flag_wait("trigger_concourse_a");
  function_f14bef78123d2da0();
  function_ddb9cade705f06a();
  flag_wait("trigger_concourse_b");
  function_f14bef78123d2da0();
  function_ddb9cade705f06a();
  flag_wait("trigger_concourse_c");
  function_f14bef78123d2da0();
  function_ddb9cade705f06a();
  flag_wait("trigger_concourse_e");
  function_f14bef78123d2da0();
  function_ddb9cade705f06a();
}

function function_7467c372b4d2edef() {
  level endon("trigger_concourse_e");
  nags = create_deck(["dx_sp_flas_stcn_burn_downstaydown", "dx_sp_flas_stcn_burn_keeprunninggo", "dx_sp_flas_stcn_burn_gettosafetyrun", "dx_sp_flas_stcn_burn_cmonletsgoletsgo"]);

  while(true) {
    flag_waitopen("pause_warning_vo");
    level.redshirt say(nags deck_draw());
    wait randomintrange(10, 20);
  }
}

function function_8a516e070a5a0851() {
  level endon("trigger_concourse_e");
  nags = create_deck(["dx_sp_flas_stcn_pric_keepmovingthroughthe", "dx_sp_flas_stcn_pric_moveupsergeantwerepu"]);
  var_b78709d260ae8bd0 = (29080, 5592, -608);

  while(true) {
    flag_waitopen("pause_warning_vo");
    var_b47b1961a72fb795 = distance2dsquared(level.player.origin, level.price.origin) > 250000;

    if(var_b47b1961a72fb795) {
      level.price say(nags deck_draw());
      price_closer = distance2dsquared(level.player.origin, var_b78709d260ae8bd0) > distance2dsquared(level.price.origin, var_b78709d260ae8bd0);

      if(price_closer) {
        level.price say_delayed(0.2, "dx_sp_flas_stcn_pric_soapgetuphere");
      }
    }

    wait randomintrange(10, 20);
  }
}

function function_387da36ac753f03a() {
  level endon("concourse_combat_done");
  nades = [];

  while(true) {
    wait 1;
    nades = getEntArray("grenade", "classname");

    if(nades.size == 0 || flag("pause_warning_vo")) {
      continue;
    }

    var_cfb65343cd42a773 = [];

    foreach(nade in nades) {
      if(isvalidmissile(nade) && isPlayer(getmissileowner(nade))) {
        var_cfb65343cd42a773[var_cfb65343cd42a773.size] = nade;
      }
    }

    if(var_cfb65343cd42a773.size) {
      continue;
    }

    break;
  }

  var_2bea0bb219c1740e = getclosest(level.player.origin, nades);

  if(isDefined(var_2bea0bb219c1740e) && distance2dsquared(var_2bea0bb219c1740e.origin, level.player.origin) < 360000) {
    level.player say("dx_bc_hrbc_eata_soap_grenade");
    var_2bea0bb219c1740e waittill("explode");
    wait 0.2;
  }

  level.player say("dx_sp_flas_stcn_soap_fuckersareusinggrena");
}

function function_94cb0acf22c313fc() {
  level endon("trigger_concourse_b");
  flag_wait_all("trigger_concourse_a", "concourse_a_vo_done");
  flag_wait("stop_looping_civs_concourse_a_outer");
  aliases = ["dx_sp_flas_stcn_soap_movinleft", "dx_sp_flas_stcn_soap_pushingleft", "dx_sp_flas_stcn_soap_takingleft"];
  level.player say_team(random(aliases), 3, 100);
}

function function_f14bef78123d2da0() {
  flag_waitopen("pause_warning_vo");
  aliases = ["dx_sp_flas_stcn_pric_moving", "dx_sp_flas_stcn_pric_forcingup", "dx_sp_flas_stcn_pric_immoving", "dx_sp_flas_stcn_pric_movingup"];
  level.price say_team(random(aliases), 2, undefined, undefined, 0.2);
}

function function_ddb9cade705f06a() {
  flag_waitopen("pause_warning_vo");
  aliases = ["dx_sp_flas_stcn_burn_moving", "dx_sp_flas_stcn_burn_pushingup", "dx_sp_flas_stcn_burn_imforcingup", "dx_sp_flas_stcn_burn_pushingforward"];
  level.redshirt say_team(random(aliases), 2);
}

function function_7677054903389a99() {
  level endon("stop_concourse_civ_panic");
  aliases = ["dx_sp_flas_stcn_rfc1_itsthepolice", "dx_sp_flas_stcn_rfc1_theyreshootingpeople", "dx_sp_flas_stcn_rfc1_runthepolicearehere", "dx_sp_flas_stcn_rmc1_thepoliceareshooting", "dx_sp_flas_stcn_rmc1_getawayfromthepolice", "dx_sp_flas_stcn_rmc1_theyrebehindusrun", "dx_sp_flas_stcn_bfc1_getoutthepolicearehe", "dx_sp_flas_stcn_bfc1_thepoliceareshooting", "dx_sp_flas_stcn_bfc1_itsthepolice", "dx_sp_flas_stcn_bmc1_thepolicearecomingru", "dx_sp_flas_stcn_bmc1_policeareeverywhere", "dx_sp_flas_stcn_bmc1_rungogo"];
  vo_deck = create_deck(aliases);

  while(true) {
    wait randomintrange(5, 7);

    if(level.price is_speaking() || level.shepherd is_speaking() || level.redshirt is_speaking()) {
      continue;
    }

    civ = getclosest(level.player.origin, namespace_5e9fb42dea43f1f0::function_1b73273370d27c99(), 1000);

    if(isDefined(civ)) {
      civ playsoundonmovingent(vo_deck deck_draw());
    }
  }
}

function function_854b7eb5a78ab6c5() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_b", array_add(level.allies, level.player));
  function_cec768382d475778(0);
  thread namespace_5e9fb42dea43f1f0::function_def2ca6a173dd447();
  level.player thread function_be2529906db91d65();
  childthread function_a41db02710a45f0f(0);
  delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_a");
}

function function_3b39efb880edc635() {
  thread function_b955dfe8af519fd9();
  thread concourse_combat_b();
  thread function_9ea8b72fcd97394e();
}

function function_8fdffe00597d78a() {
  delaythread(1, &flag_set, "stop_looping_civs_concourse_b");
  flag_set("concourse_b_vo_done");
}

function function_b955dfe8af519fd9() {
  flag_init("concourse_b_vo_done");
  flag_wait_all("concourse_a_vo_done", "trigger_concourse_b");
  level.price function_fc0eb6b81c66c661(1, "dx_sp_flas_stcn_pric_clearemoutfast");
  flag_set("concourse_b_vo_done");
}

function function_c223032eb5b41192() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_c", array_add(level.allies, level.player));
  function_cec768382d475778(0);
  thread namespace_5e9fb42dea43f1f0::function_def2ca6a173dd447();
  level.player thread function_be2529906db91d65();
  delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_c_allies");
}

function concourse_c_main() {
  thread function_b955dee8af519da6();
  thread concourse_combat_c();
  thread function_c09f705937921211();
  thread function_93cafb415909567a();
}

function function_6cbbdc09986c4aa5() {
  delaythread(1, &flag_set, "stop_looping_civs_concourse_d");
  flag_set("concourse_c_vo_done");
}

function function_b955dee8af519da6() {
  flag_init("concourse_c_vo_done");
  flag_wait_all("concourse_b_vo_done", "trigger_concourse_c");
  thread function_bffdc87164876218();
  level.price say_team("dx_sp_flas_ccrs_pric_smokeaheadcareful");
  flag_wait("concourse_c_enemies_dead");
  flag_set("concourse_c_vo_done");
}

function function_bffdc87164876218() {
  var_dc531506526b2ea9 = getEnt("trigger_concourse_e", "targetname");
  var_dc531506526b2ea9 endon("trigger");
  var_1e6bb3a31eed7b9a = getEnt("concourse_shop_smoke", "targetname");

  while(!level.player istouching(var_1e6bb3a31eed7b9a)) {
    waitframe();
  }

  level.player say_team("dx_sp_flas_stcn_soap_cuttingthroughthesho");
  level.price function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcn_pric_copy");
}

function function_cd5719323cafb7e7() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_c", array_add(level.allies, level.player));
  function_cec768382d475778(0);
  thread namespace_5e9fb42dea43f1f0::function_def2ca6a173dd447();
  level.player thread function_be2529906db91d65();
  delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_d_allies");
}

function function_e3cb183f20faf443() {
  thread set_flag_on_targetname_trigger("trigger_concourse_d_smoke");
  thread function_b955e1e8af51a43f();
  thread function_e457e8265ed190f4();
}

function function_7014938de02d0f8() {
  delaythread(1, &flag_set, "stop_looping_civs_concourse_d");
  flag_set("concourse_d_vo_done");
}

function function_b955e1e8af51a43f() {
  flag_init("concourse_d_vo_done");
  flag_wait_all("concourse_c_vo_done", "trigger_concourse_d");
  flag_wait_all("concoure_d_enemies_dead", "smoke_enemies_dead");

  if(!flag("trigger_concourse_e")) {
    level.price function_fc0eb6b81c66c661(0.5, "dx_sp_flas_ccrs_pric_clearsecurethestairw");
  }

  flag_set("concourse_d_vo_done");
}

function function_f16596bfb23ae5f4() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_e", array_add(level.allies, level.player));
  function_cec768382d475778(0);
  thread namespace_5e9fb42dea43f1f0::function_def2ca6a173dd447();
  level.player thread function_be2529906db91d65();
  delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_e");
  delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_e_allies");
  level.player clearsoundsubmix("sp_jup_flashback_concourse_smoke_moment", 4);
}

function function_79621f1fa4ebafa2() {
  thread function_b955e0e8af51a20c();
  thread function_e457e9265ed19327();
  thread function_cbe0e4532e203684();
  trigger_wait_targetname("trigger_concourse_end");
  level notify("stop_concourse_civ_panic");
  thread concourse_combat_done();
  level.player function_d903f960bd137761();
  function_cec768382d475778(1);
}

function function_4fdd61a8778cf7f3() {
  flag_set("concourse_e_vo_done");
}

function function_b955e0e8af51a20c() {
  flag_init("concourse_e_vo_done");
  flag_wait_all("concourse_d_vo_done", "trigger_concourse_e");
  door_eye = getStruct("struct_objective_concourse_e", "targetname");

  if(level.player can_see_origin(door_eye.origin)) {
    level.player say_team("dx_sp_flas_stcn_soap_visualonthestairwell");
  } else {
    level.price say_team("dx_sp_flas_stcn_pric_stairwellrightside");
  }

  flag_wait_all("concourse_stairs_scene_enemies_dead", "concourse_e_boss_dead");

  if(!flag("nt_fbk_0290_no_return")) {
    struct = getStruct("struct_concourse_stair_door_eye", "targetname");

    if(distance2dsquared(level.player.origin, struct.origin) < 202500) {
      level.player function_fc0eb6b81c66c661(1, "dx_sp_flas_stcn_soap_rungo");
    }
  }

  level.redshirt function_fc0eb6b81c66c661(0.5, "dx_sp_flas_stcn_burn_xraysdown");
  flag_set("concourse_e_vo_done");
}

function function_be2529906db91d65() {
  self notify("stop_civ_avoidance");
  self endon("stop_civ_avoidance");
  var_7fa9c425dfb67ada = 10;

  while(true) {
    halfsize = var_7fa9c425dfb67ada;
    skip_badplace = 0;

    if(level.player namespace_47819225b08b445d::function_9d3eb4b159acb2c()) {
      skip_badplace = 1;
    }

    bounds_origin = level.player.origin + anglesToForward(level.player.angles) * 90;
    bounds_angles = (level.player.angles[0], level.player.angles[1] + 45, level.player.angles[2]);

    if(!skip_badplace) {
      self.var_b1ba06306b3b7858 = createnavbadplacebybounds(bounds_origin, (halfsize, halfsize, 1000), bounds_angles, "neutral");
    }

    wait 4;

    if(isDefined(self.var_b1ba06306b3b7858)) {
      destroynavobstacle(self.var_b1ba06306b3b7858);
    }
  }
}

function function_d903f960bd137761() {
  self notify("stop_civ_avoidance");

  if(isDefined(self.var_b1ba06306b3b7858)) {
    destroynavobstacle(self.var_b1ba06306b3b7858);
  }
}

function function_75482285b36a7a8f() {
  trigger_wait_targetname("trigger_concourse_b");
  wait 1;
  enemy = get_living_ai("molotov_thrower", "script_noteworthy");

  if(is_dead_or_dying(enemy)) {
    assertex(0, "Failed to get molotov thrower!");
    return;
  }

  result = enemy waittill_any_return("death", "reached_path_end");

  if(result == "death") {
    return;
  }

  enemy.grenadeweapon = makeweapon("molotov");
  grenadetargetpos = (29384, 4888, -616);
  armoffset = getgrenadethrowoffset("exposed_throw_grenade", 1);
  velocityvec = enemy checkgrenadethrowpos(armoffset, grenadetargetpos, 0, "min energy");

  if(isDefined(velocityvec)) {
    enemy.var_ca01d1496480b62c = grenadetargetpos;
    enemy.var_624efed57c34c807 = velocityvec;
    thread namespace_47819225b08b445d::function_efc089d7d1b8af28(10, grenadetargetpos, (55, 55, 55), (0, 225, 0), "neutral", "neutral");
  }

  enemy thread spawner::go_to_node(getnode("molotov_thrower_post_throw_node", "targetname"));
}

function function_be1adb2e63b21688() {
  trigger_wait_targetname("trigger_concourse_b");
  trigg = getEnt("OutOfBounds_infil_stairs", "targetname");
  trigg thread namespace_47819225b08b445d::function_8f2ebae90f61cb99();
}

function function_93cafb415909567a() {
  trigger_wait_targetname("trigger_concourse_c");
  trigg = getEnt("OutOfBounds_concourse_a", "targetname");
  trigg thread namespace_47819225b08b445d::function_8f2ebae90f61cb99();
}

function function_cbe0e4532e203684() {
  trigger_wait_targetname("trigger_concourse_end");
  trigg = getEnt("OutOfBounds_concourse_c", "targetname");
  trigg thread namespace_47819225b08b445d::function_8f2ebae90f61cb99();
  flag_wait("concourse_stairs_top_open");
  trigg delete();
}

function function_a41db02710a45f0f(debug_mode) {
  if(debug_mode) {
    animnode = {
      #angles: (0, -37, 0), #origin: (31504, 2792, -936)
    };
  } else {
    animnode = {
      #angles: (0, 0, 0), #origin: (30310, 3951, -672)
    };
  }

  timeout_time = 7;
  var_f2fb99d6f3e11a41 = 672400;

  while(distance2dsquared(level.player.origin, animnode.origin) > var_f2fb99d6f3e11a41) {
    waitframe();
  }

  enemy = dospawnaitype("actor_jup_enemy_police_ar", (0, 0, 0), (0, 0, 0), 1, 0, 1, 1);
  enemy namespace_47819225b08b445d::function_447207547d20ae92();
  enemy.animname = "enemy01";
  enemy.allowdeath = 1;
  enemy.og_health = enemy.health;
  enemy.health = 1;
  enemy utility::set_ignoreme(1);
  enemy utility::function_1a479cad9c3adbb1(0);
  civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1, 1, 1);
  civ.animname = "civ01";
  civ.var_2dd755c521498bb5 = 1;
  civ.deathfunction = &scripts\sp\anim::function_ce450b9957138bd5;
  civ.allowdeath = 1;
  civ notify("disable_headlook");
  var_c59a1bf410f24b79 = [enemy, civ];
  animnode anim_first_frame(var_c59a1bf410f24b79, "concourse_restaurant_enter");
  civ thread function_c8541b973e340d65(enemy);
  animnode anim_single(var_c59a1bf410f24b79, "concourse_restaurant_enter");

  if(is_dead_or_dying(enemy)) {
    return;
  }

  enemy utility::delaythread(timeout_time / 2, &utility::set_ignoreme, 0);
  animnode thread anim_loop_solo(enemy, "concourse_restaurant_idle");
  bad_place = createnavbadplacebybounds((30376, 3952, -672), (50, 50, 50), (0, 225, 0), "neutral", "neutral");
  thread check_player_too_close(enemy, 250, "concourse_restaurant_player_too_close");
  result = waittill_any_ents_or_timeout_return(timeout_time, enemy, "damage", level, "concourse_restaurant_player_too_close");
  animnode notify("stop_loop");

  if(result == "concourse_restaurant_player_too_close" && !is_dead_or_dying(enemy)) {
    enemy namespace_47819225b08b445d::function_363c08ddb86b8493();
    enemy.health = enemy.og_health;
    enemy function_1a479cad9c3adbb1(1);
    animnode anim_single_solo(enemy, "concourse_restaurant_exit");
  }

  destroynavobstacle(bad_place);
}

function function_c8541b973e340d65(enemy) {
  thread namespace_47819225b08b445d::function_264ea5c38c1ae771();
  result = waittill_any_ents_return(self, "single_anim_done", level, "restaurant_shooter_killed_civ");

  if(!isDefined(result)) {
    return;
  }

  if(result == "single_anim_done") {
    node = getStruct("restaurant_shooter_runto_node", "targetname");
    thread spawner::go_to_node(node);
    return;
  } else if(result == "restaurant_shooter_killed_civ") {
    wait 0.5;
  }

  die();
}

function function_970d6a08ab976df7() {
  level endon("stop_concourse_vignettes");
  childthread concourse_hostage(0);
  childthread function_a41db02710a45f0f(0);
  childthread function_4e0f1ada5e803f87();
  childthread function_9a8d08deb80e19de();
}

function function_9ea8b72fcd97394e() {
  level endon("stop_concourse_vignettes");
  childthread price_rescue();
}

function function_c09f705937921211() {
  level endon("stop_concourse_vignettes");
  childthread civ_hang();
}

function function_a8a66b06c79dba9d() {
  level.player teleport_player({
    #angles: (0, 135, 0), #origin: (31672, 2600, -936)
  });
}

function function_5e10cf399d75048d() {
  function_90a7f510097cffd3();
  childthread concourse_hostage(1);
  level waittill("<dev string:x1c>");
}

function concourse_hostage(debug_mode) {
  animnode = getStruct("animnode_concourse_hostage", "targetname");

  if(!isDefined(animnode)) {
    animnode = {
      #angles: (0, 308, 0), #origin: (29824, 3671, -671.5)
    };
  }

  if(debug_mode) {
    animnode = {
      #angles: (0, -37, 0), #origin: (31380, 2880, -936)
    };
  }

  flag_init("hostage_intro_done");
  flag_init("enemy_killed");
  flag_init("civ_killed");
  flag_init("concourse_hostage_timeout");
  flag_init("player_too_close");
  level.concourse_hostage = spawnStruct();
  level.concourse_hostage.civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1);
  civ = level.concourse_hostage.civ;
  civ.targetname = "civ01";
  civ.allowdeath = 1;
  civ.animname = civ.targetname;
  civ notify("disable_headlook");
  civ notify("stop_injured_dmg_death_logic");
  animnode anim_first_frame_solo(civ, "fbk_0275_enter");
  level.concourse_hostage.enemy = spawn_aitype("actor_jup_enemy_police_pistol", (0, 0, 0), (0, 0, 0), 1, undefined, undefined, "enemy01");
  enemy = level.concourse_hostage.enemy;
  enemy.health = 1;
  enemy.animname = enemy.targetname;
  enemy.allowdeath = 1;
  enemy function_1a479cad9c3adbb1(0);
  enemy magic_bullet_shield();
  golf18 = utility::make_weapon("iw9_pi_golf18_sp", ["mag_pi_xlarge_p24"]);
  enemy namespace_47819225b08b445d::function_17177a175dd8f243(golf18);
  animnode anim_first_frame_solo(enemy, "fbk_0275_enter");
  var_c59a1bf410f24b79 = [enemy, civ];

  if(!debug_mode) {
    var_57d772d019e9051f = getEnt("trigger_concourse_b", "targetname");
    result = waittill_any_ents_return(level, "stop_looping_civs_concourse_a_outer", var_57d772d019e9051f, "trigger");

    if(result == "trigger") {
      if(isDefined(civ)) {
        civ stop_magic_bullet_shield();
        civ delete();
      }

      if(isDefined(enemy)) {
        if(enemy.magic_bullet_shield) {
          enemy stop_magic_bullet_shield();
        }

        enemy delete();
      }

      level notify("stop_concourse_hostage_vo");
      return;
    }
  }

  enemy stop_magic_bullet_shield();
  thread function_7a0680e780206b2a(debug_mode);
  thread function_47cbc8cdc26a5c8(animnode, var_c59a1bf410f24b79, civ, enemy, debug_mode);
  thread function_f9026debf44ba181(animnode, var_c59a1bf410f24b79, civ, enemy, debug_mode);
}

function function_7a0680e780206b2a(debug_mode) {
  level endon("stop_concourse_hostage_vo");
  civ = level.concourse_hostage.civ;
  enemy = level.concourse_hostage.enemy;
  civ thread say("dx_sp_flas_stcn_bfc2_helphelpmeplease");
  result = level waittill_any_return("enemy_killed", "player_too_close", "concourse_hostage_timeout", "intro_player_too_close");
  waitframe();

  if(result == "enemy_killed" && !flag("civ_killed")) {
    level.player say_delayed(1, "dx_sp_flas_stcn_soap_rungo");

    if(!is_dead_or_dying(civ)) {
      civ say_delayed(0.2, "dx_sp_flas_stcn_bfc2_ohgodohmygod");
    }

    return;
  }

  aliases = ["dx_sp_flas_stcn_soap_shit", "dx_sp_flas_stcn_soap_fuck", "dx_sp_flas_stcn_soap_goddamnit", "dx_sp_flas_stcn_soap_no"];
  level.player say_delayed(1.5, random(aliases));
}

function function_47cbc8cdc26a5c8(animnode, var_c59a1bf410f24b79, civ, enemy, debug_mode) {
  animnode thread anim_single(var_c59a1bf410f24b79, "fbk_0275_enter");
  thread function_ec829c3f4efe677(civ, enemy, debug_mode);
  animnode waittill("fbk_0275_enter");
  flag_set("hostage_intro_done");
}

function function_ec829c3f4efe677(civ, enemy, debug_mode) {
  level endon("hostage_intro_done");
  flag_init("hostage_intro_interupted");
  enemy thread function_76bc9fc80e267c90();
  civ thread function_25f8ddd46902762a();
  thread check_player_too_close(enemy, 330, "intro_player_too_close", "hostage_intro_interupted");
  result = level waittill_any_return("enemy_killed", "civ_killed", "intro_player_too_close");
  level notify("stop_hostage_checks");
  civ.deathfunction = &scripts\sp\anim::function_ce450b9957138bd5;

  if(result == "intro_player_too_close") {
    if(debug_mode) {
      iprintln("Hostage intro inturupted: Player too close");
    }

    enemy shoot();
    enemy stopanimScripted();
    enemy function_1a479cad9c3adbb1(1);
    namespace_7f81dff3bcaf7919::squib_head(civ);
    civ die();
  } else if(flag("enemy_killed")) {
    if(debug_mode) {
      iprintln("Hostage intro inturupted: Enemy killed");
    }

    civ stopanimScripted();
    civ utility::delaythread(2, &scripts\sp\spawner::go_to_node, getStruct("concourse_hostage_runto_node", "targetname"));
  } else {
    if(debug_mode) {
      iprintln("Hostage intro inturupted: Civ killed");
    }

    enemy stopanimScripted();
    civ die();

    if(civ.attacker == level.player) {
      scripts\sp\player_death::set_custom_death_quote(30);
      missionfailedwrapper();
    }
  }

  flag_set("hostage_intro_interupted");
}

function function_f9026debf44ba181(animnode, var_c59a1bf410f24b79, civ, enemy, debug_mode) {
  level endon("hostage_intro_interupted");
  flag_wait("hostage_intro_done");
  timeout_seconds = 8;
  enemy magic_bullet_shield();
  civ.deathfunction = undefined;
  thread function_48470e3b06c8dbc5(animnode, enemy, civ, timeout_seconds);
  enemy thread function_76bc9fc80e267c90();
  civ thread function_25f8ddd46902762a();
  thread check_timeout(timeout_seconds);
  thread check_player_too_close(enemy, 330, "player_too_close");
  result = level waittill_any_return("enemy_killed", "civ_killed", "concourse_hostage_timeout", "player_too_close");
  waitframe();
  animnode notify("stop_loop");
  level notify("stop_hostage_checks");

  if(result == "concourse_hostage_timeout" || result == "player_too_close") {
    if(debug_mode) {
      iprintln("Killing civ: " + result);
    }

    enemy stop_magic_bullet_shield();
    civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    animnode anim_single(var_c59a1bf410f24b79, "fbk_0275_enemy_killed_civ");
    enemy function_1a479cad9c3adbb1(1);
    node = getnodesinradius(enemy.origin, 256, 0);

    if(isDefined(node)) {
      enemy thread spawner::go_to_node(node);
    }

    return;
  }

  if(flag("enemy_killed") && flag("civ_killed")) {
    if(debug_mode) {
      iprintln("Both killed");
    }

    enemy thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    animnode thread anim_single(var_c59a1bf410f24b79, "fbk_0275_enemy_dead_civ_dead");
    scripts\sp\player_death::set_custom_death_quote(30);
    missionfailedwrapper();
    return;
  }

  if(flag("enemy_killed")) {
    if(debug_mode) {
      iprintln("Enemy killed");
    }

    enemy thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    animnode anim_single(var_c59a1bf410f24b79, "fbk_0275_enemy_death_civ_live");
    civ thread scripts\sp\spawner::go_to_node(getStruct("concourse_hostage_runto_node", "targetname"));
    civ thread namespace_47819225b08b445d::injured_dmg_death_logic();
    return;
  }

  if(flag("civ_killed")) {
    if(debug_mode) {
      iprintln("Civ killed");
    }

    civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    enemy stop_magic_bullet_shield();
    enemy function_1a479cad9c3adbb1(1);
    animnode thread anim_single(var_c59a1bf410f24b79, "fbk_0275_plr_killed_civ");
    scripts\sp\player_death::set_custom_death_quote(30);
    missionfailedwrapper();
  }
}

function function_48470e3b06c8dbc5(animnode, enemy, civ, max_timeout) {
  level endon("stop_hostage_checks");
  var_ac174352302163af = 4;
  var_f78410a76a3318ef = max_timeout / var_ac174352302163af;
  var_c59a1bf410f24b79 = [enemy, civ];

  while(true) {
    animnode childthread anim_loop(var_c59a1bf410f24b79, "fbk_0275_idle", "stop_fbk_0275_idle");
    wait var_f78410a76a3318ef;
    animnode notify("stop_fbk_0275_idle");
    enemy childthread function_8ef87cf2de85e288();
    animnode anim_single(var_c59a1bf410f24b79, "fbk_0275_enemy_shoot");
    flag_clear("nt_fbk_0275_start_shooting");
    flag_clear("nt_fbk_0275_stop_shooting");
  }
}

function function_8ef87cf2de85e288() {
  self endon("death");
  level endon("nt_fbk_0275_stop_shooting");
  flag_wait("nt_fbk_0275_start_shooting");

  while(true) {
    self shoot(0.5, level.player);
    wait 0.07;
  }
}

function function_76bc9fc80e267c90(optional_endon) {
  if(isDefined(optional_endon)) {
    level endon(optional_endon);
  }

  level endon("stop_hostage_checks");
  namespace_47819225b08b445d::function_293d34b4366acee();
  flag_set("enemy_killed");
}

function function_25f8ddd46902762a(optional_endon) {
  if(isDefined(optional_endon)) {
    level endon(optional_endon);
  }

  level endon("stop_hostage_checks");
  self waittill("damage", damage, attacker);
  self.attacker = attacker;
  flag_set("civ_killed");
}

function check_timeout(max_timeout) {
  assert(isDefined(max_timeout));
  level endon("stop_hostage_checks");
  wait max_timeout;
  flag_set("concourse_hostage_timeout");
}

function check_player_too_close(enemy, max_distance, var_75a0b6863e59a497, optional_endon) {
  if(is_dead_or_dying(enemy)) {
    return;
  }

  enemy endon("death");
  max_distance = default_to(max_distance, 130);

  if(isDefined(optional_endon)) {
    level endon(optional_endon);
  }

  level endon("stop_hostage_checks");

  while(true) {
    waitframe();
    var_d73bdd3ccd0df1c = distance2dsquared(level.player.origin, enemy.origin);

    if(var_d73bdd3ccd0df1c < max_distance * max_distance) {
      break;
    }
  }

  if(isDefined(var_75a0b6863e59a497)) {
    flag_set(var_75a0b6863e59a497);
  }
}

function price_rescue() {
  trigger_wait_targetname("trigger_concourse_b");
  level.price.ignoreall = 1;
  wait 0.2;
  animnode = getStruct("animnode_price_rescue", "targetname");

  if(!isDefined(animnode)) {
    animnode = {
      #angles: (0, 0, 0), #origin: (29793, 4486, -672)
    };
  }

  animnode = animnode;
  civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 0, 1, 1);
  assert(isDefined(civ));
  civ thread namespace_47819225b08b445d::function_96ef51c945a57bf7();
  civ setModel("body_c_jup_sp_civ_soccerfan_f_02_russia");
  civ notify("stop_injured_dmg_death_logic");
  civ notify("disable_headlook");
  civ.targetname = "price_rescue_civ";
  assert(isDefined(civ));
  civ.animname = "civ";
  civ dontinterpolate();
  animnode anim_first_frame_solo(civ, "civ_rescue_enter");

  if(is_dead_or_dying(civ)) {
    return;
  }

  animnode anim_single_solo(civ, "civ_rescue_enter");
  animnode thread anim_loop_solo(civ, "civ_rescue_idle", "stop_rescue_idle");
  animnode anim_reach_solo(level.price, "civ_rescue");
  level.price.ignoreme = 1;
  level.price disable_ai_color();
  var_c59a1bf410f24b79 = [level.price, civ];
  animnode notify("stop_rescue_idle");
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  thread namespace_47819225b08b445d::function_efc089d7d1b8af28(2.5, (29912, 4384, -664), (55, 130, 55), (0, 225, 0), "neutral", "neutral");
  animnode thread anim_single(var_c59a1bf410f24b79, "civ_rescue");
  level.price namespace_47819225b08b445d::function_264ea5c38c1ae771();
  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  level.price enable_ai_color();
  activate_trigger_with_targetname("color_price_to_bar");
  level.price.ignoreme = 0;
  level.price.ignoreall = 0;
  animnode thread anim_loop_solo(civ, "civ_rescue_safe_idle", "stop_civ_rescue_idle");
  flag_wait("concourse_stairs_top_open");
  animnode notify("stop_civ_rescue_idle");
  waitframe();

  if(!is_dead_or_dying(civ)) {
    civ delete();
  }
}

function function_9a8d08deb80e19de() {
  flag_wait("stop_looping_civs_concourse_a_outer");
  animnode = undefined;

  if(!isDefined(animnode)) {
    animnode = {
      #angles: (0, 0, 0), #origin: (30019, 3538, -672)
    };
  }

  civ = namespace_47819225b08b445d::spawn_civ((29212, 4260, -664), undefined, 1, undefined, undefined, undefined, 1);
  assert(isDefined(civ));
  civ.animname = "civ_recorder";
  civ.disablearrivals = 1;
  civ.ignoreme = 1;
  civ.pushable = 0;
  civ.script_pushable = 0;
  civ enableavoidance(0, 0);
  civ notify("disable_headlook");
  civ notify("stop_injured_dmg_death_logic");
  civ.phone = spawn("script_model", (0, 0, 0));
  civ.phone setModel("electronics_smartphone_01");
  civ.phone.origin = civ gettagorigin("tag_accessory_right");
  civ.phone.angles = (0, 0, 0);
  civ.phone linkTo(civ, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  civ.phone.owner = civ;
  civ.phone thread namespace_47819225b08b445d::function_a1cbeb0b29becc97();
  civ dontinterpolate();
  animnode anim_first_frame_solo(civ, "civ_record");
  animnode thread anim_loop_solo(civ, "civ_record_idle");

  while(true) {
    var_eed285a5c7668b98 = distance2dsquared(level.player.origin, animnode.origin) < 396900;
    closest_enemy = getclosest(animnode.origin, getaiarray("axis"));
    enemies_close = 0;

    if(isDefined(closest_enemy)) {
      enemies_close = distance2dsquared(closest_enemy.origin, animnode.origin) < 12100;
    }

    if(enemies_close || var_eed285a5c7668b98) {
      break;
    }

    waitframe();
  }

  animnode notify("stop_loop");
  civ thread namespace_47819225b08b445d::function_76bb2b4d7fbca9f8();
  animnode anim_single_solo(civ, "civ_record");
  civ.phone unlink();
}

function function_4e0f1ada5e803f87() {
  trigger_wait_targetname("trigger_concourse_a");
  runner = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1, undefined, undefined, undefined, 1);
  killed_civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1, undefined, undefined, undefined, 1);
  runner.animname = "cpr_runner";
  runner.deathfunction = &anim_sp::function_ce450b9957138bd5;
  killed_civ.animname = "cpr_killed_civ";
  killed_civ.deathfunction = &anim_sp::function_ce450b9957138bd5;
  animnode = getStruct("animnode_concourse_cpr", "targetname");

  if(!isDefined(animnode)) {
    animnode = {
      #angles: (0, 0, 0), #origin: (30622, 3913, -672)
    };
  }

  var_c59a1bf410f24b79 = [runner, killed_civ];
  array_notify(var_c59a1bf410f24b79, "disable_headlook");
  array_call(var_c59a1bf410f24b79, &dontinterpolate);
  array_thread(var_c59a1bf410f24b79, &utility::set_allowdeath, 1);
  var_53861e869d7fe138 = animnode function_af77f9a5b0511869(var_c59a1bf410f24b79);
  animnode notify("stop_cpr_idle");

  if(!istrue(var_53861e869d7fe138)) {
    foreach(guy in var_c59a1bf410f24b79) {
      if(isalive(guy)) {
        if(isDefined(guy.magic_bullet_shield)) {
          guy ai::stop_magic_bullet_shield();
        }

        guy die();
      }
    }

    return;
  }

  array_call(var_c59a1bf410f24b79, &stopanimscripted);
  array_call(var_c59a1bf410f24b79, &delete);
}

function function_af77f9a5b0511869(guys) {
  foreach(guy in guys) {
    guy endon("death");
  }

  anim_first_frame(guys, "cpr_enter");
  anim_single(guys, "cpr_enter");
  childthread anim_loop(guys, "cpr_idle", "stop_cpr_idle");
  trigger_wait_targetname("trigger_concourse_c");
  return true;
}

function function_5ad31b80db6408b4() {
  trig = getEnt("trigger_field", "targetname");
  return !level.player istouching(trig);
}

function function_5a41cfd6197b85bd() {
  return !level.player ent_flag("out_of_bounds");
}

function function_67451b211141e5ab() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_concourse_stairs", array_add(level.allies, level.player));
  function_a4d5dee1f16e5ad7(0);
  function_af71e5d06fda8b30(1);
  function_6466d38354c8ebd9();
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_cac0d6c867a55103);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }
}

function function_6f9af4650b4c7647() {
  level.player clearsoundsubmix("sp_jup_flashback_concourse", 3.5);
  level.player clearsoundsubmix("sp_jup_flashback_stairs_lower_door_moment", 3.5);
  thread function_a19544f59746bc43();
  thread function_f3e7c7e794cba286("player_at_concourse_stairs", "struct_gunshot_stairs_0");
  thread fb_lighting::stairs_sun_switch_thread();
  function_93c8fdc795d4717c();
  function_5bb5be7ceb9e379();
  thread function_eb1f8ad123dba023();
  flag_wait("player_at_concourse_stairs");
  level.player val::reset_all("cough");
  autosave_by_name();
  thread function_2a04dc8e64efa265();
  thread function_564579a7b113a217();
  thread stairs_murder();
  thread concourse_stairs_1();
  thread concourse_stairs_2();
  flag_wait_all("concourse_stairs_1_enemies_dead", "concourse_stairs_2_enemies_dead");
  thread function_ca1ee3f6b48b0bb3();
  thread autosave_by_name();

  foreach(transient in level.var_a67ce3c274f5544e) {
    settransientvisibility(transient, 1);
  }
}

function function_decfda1efe2cb284() {
  fb_lighting::function_7ba7b6df6537fc07();
  flag_set("concourse_stairs_2_enemies_dead");
  flag_set("concourse_stairs_1_enemies_dead");
  flag_set("concourse_stairs_vo_done");
  flag_set("concourse_stairs_fourth_floor_vo_done");
  flag_set("trigger_concourse_stairs_2");
}

function function_a19544f59746bc43() {
  thread set_flag_on_targetname_trigger("trigger_concourse_stairs_2");
  flag_init("concourse_stairs_vo_done");
  flag_wait_all("concourse_e_vo_done");
  level.price say_team("dx_sp_flas_stcn_pric_thirdfloorsourtarget");
  level.price function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcn_pric_takepointsoap");

  if(!flag("player_at_concourse_stairs")) {
    nags = ["dx_sp_flas_stcn_pric_takepointsoap", "dx_sp_flas_stcn_pric_thirdfloorsourtarget", "dx_sp_flas_stcn_pric_headupstairssergeant", "dx_sp_flas_stcn_pric_upthestairssergeantg", "dx_sp_flas_stcn_pric_onyousoapletsgetupst"];
    level.price nagtill([level, "player_at_concourse_stairs"], nags, 11);
  }

  flag_wait("player_at_concourse_stairs");
  level.player say_team("dx_sp_flas_stcn_soap_movingonthestairwell");
  flag_wait("concourse_stairs_1_enemies_dead");
  wait 1.6;
  level.player say_team("dx_sp_flas_stcs_soap_twodownonthestairs");
  level.price function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcs_pric_copy");
  level.price function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcs_pric_nextfloorsergeant");
  var_3b9d88fdac5455e0 = level.constairs_hostage;
  var_2e85f4cf0abc9800 = level.var_74ecea13881f0759;
  flag_wait("trigger_concourse_stairs_2");
  flag_wait("concourse_stairs_fourth_floor_vo_done");
  flag_set("concourse_stairs_vo_done");
}

function function_ca1ee3f6b48b0bb3() {
  trigg = getEnt("OutOfBounds_concourse", "targetname");
  trigg thread namespace_47819225b08b445d::function_8f2ebae90f61cb99();
  flag_wait("penthouse_secure");
  trigg delete();
}

function function_b3e5fcdd53c3371b() {
  function_ab6aeb48cee6016();
  function_d90396978fe6b6f7();
  function_de2e5b48058efa80();
  function_6d3567f851c4d2d9();
  function_ac4255109ff379e2();
  function_40b875d4e0017c4();
}

function concourse_combat_a() {
  flag_set("player_at_concourse_a");
}

function concourse_combat_b() {
  thread function_485a143d57e550b7();
  trigger_wait_targetname("trigger_concourse_b");
  flag_set("player_at_concourse_b");
  enemyspawners = getspawnerarray("enemy_concourse_b");
  array_spawn(enemyspawners, 1);
  thread function_ba6214134567c27a("trigger_concourse_b_extra", "player_at_concourse_c", "player_on_ascendor");
}

function concourse_combat_c() {
  thread function_485a133d57e54e84();
  trigger_wait_targetname("trigger_concourse_c");
  function_4cbb35939dcfd68b();

  if(!flag("player_at_concourse_out_c")) {
    enemyspawners = getspawnerarray("enemy_concourse_c");
    enemies = array_spawn(enemyspawners, 1);
    namespace_47819225b08b445d::function_5da13e5444950c67(enemies, "concourse_c_enemies_dead");
  }

  flag_set("player_at_concourse_c");
}

function function_e457e8265ed190f4() {
  trigger_wait_targetname("trigger_concourse_d");
  flag_set("player_at_concourse_d");
  waitframe();
  enemies = get_living_ai_array("enemy_concourse_d", "targetname");
  thread namespace_47819225b08b445d::function_5da13e5444950c67(enemies, "concoure_d_enemies_dead");
  namespace_47819225b08b445d::function_bbe10cdead87303b("trigger_concourse_d_smoke", "trigger_concourse_d_smoke");
  thread function_8f2438533e558692();
  level.player setsoundsubmix("sp_jup_flashback_concourse_smoke_moment", 0.5);
}

function function_e457e9265ed19327() {
  thread function_d271f4efe0860cf2();
  trigger_wait_targetname("trigger_concourse_e");
  level.player clearsoundsubmix("sp_jup_flashback_concourse_smoke_moment", 4);
  flag_set("player_at_concourse_e");
  thread function_25393bbf27d09350();
  flag_wait("concourse_stiarwell_enemies_spawn");
  activate_trigger_with_targetname("trigger_concourse_ally_e");
  thread function_cd2fb121ca820853();
  enemies = getaiarray("axis");

  while(enemies.size > 0) {
    enemies = scripts\engine\utility::array_removedead(enemies);
    wait 1;
  }

  flag_set("concourse_combat_done");
}

function function_d271f4efe0860cf2() {
  flag_wait("stop_looping_civs_concourse_d");
  spawner = getspawner("enemy_concourse_e_swat", "script_noteworthy");
  guy = spawner spawn_ai(1);
  guy scripts\common\ai::set_gunpose("ads");
  guy set_movement_speed(64);
  guy namespace_47819225b08b445d::function_447207547d20ae92();
  guy namespace_47819225b08b445d::function_15e8419bc7722d0b();
  var_ef3e58115fe9676e = (27808, 5480, -624);
  var_adf8835a422d488b = (27808, 5336, -624);
  guy.fake_enemy.origin = var_ef3e58115fe9676e;
  guy.fake_enemy.health = 9999;
  guy.fake_enemy.targetname = "concourse_e_boss_fake_enemy";
  guy.fake_enemy thread function_235b6934eacb0b77(var_ef3e58115fe9676e, var_adf8835a422d488b, 2);
  guy thread function_35fd51823f9dbc3e(400, "stop_shooting_fake_enemy");
  guy utility::waittill_any("reached_path_end", "damage", "player_close");
  guy notify("stop_shooting_fake_enemy");
  guy namespace_47819225b08b445d::ignore_fake_enemy();
  guy.goalradius = 64;
  guy setgoalentity(level.player);

  if(!is_dead_or_dying(guy)) {
    guy waittill("death");
  }

  flag_set("concourse_e_boss_dead");
  utility::autosave_by_name();
}

function function_cd2fb121ca820853() {
  setmusicstate("mx_flashback_combatstairs");
}

function civ_hang() {
  thread function_84cbe4e39ae194f4();
  var_22199f3f7cbfa427 = getEnt("trigger_concourse_d", "targetname");
  var_cf2b6900ca781091 = getEnt("trigger_concourse_c_portal", "targetname");
  result = waittill_any_ents_return(var_22199f3f7cbfa427, "trigger", level, "exterior_start_civ_hang", var_cf2b6900ca781091, "trigger");
  civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1);
  civ.animname = "civ_hanger";
  civ notify("disable_headlook");
  animnode = getStruct("animnode_civ_hang", "targetname");
  animnode anim_first_frame_solo(civ, "civ_hang");
  animnode anim_single_solo(civ, "civ_hang");
  path_start = getStructArray("civ_looper_concourse_b", "targetname")[0];
  civ thread go_to_node(path_start);
}

function function_84cbe4e39ae194f4() {
  flag_wait("stop_looping_civs_concourse_b_outside");

  if(namespace_47819225b08b445d::function_9d3eb4b159acb2c()) {
    flag_set("exterior_start_civ_hang");
  }
}

function function_8f2438533e558692() {
  flag_set("player_at_concourse_d_smoke");

  if(namespace_47819225b08b445d::function_9d3eb4b159acb2c()) {
    function_13a8f9f2f733fb1();
  } else {
    enemyspawners = getspawnerarray("enemy_concourse_d_smoke");
    enemies = [];

    foreach(spawner in enemyspawners) {
      enemy = spawner spawn_ai(1);
      path_node = getStruct(spawner.target, "targetname");
      enemy thread function_792523961fd2c3da(path_node);
      enemies[enemies.size] = enemy;
    }

    thread function_46d675dc092c3771(enemies, "smoke_enemies_dead", "player_at_concourse_e");
  }

  thread function_e05be9dff75942c();
  flag_wait_or_timeout("smoke_enemies_dead", 8);
  trigger = getEnt("trigger_concourse_d_allies", "targetname");

  if(isDefined(trigger)) {
    trigger notify("trigger");
  }
}

function function_792523961fd2c3da(path_node) {
  self endon("death");
  ai::set_gunpose("ads");
  thread spawner::go_to_node(path_node);
  function_54993bf18a5224c2();
  ai::reset_gunpose();
  utility::clear_movement_speed();
}

function function_54993bf18a5224c2() {
  self endon("death");
  self endon("reached_path_end");

  while(true) {
    if(isDefined(self.lastattacker) && isPlayer(self.lastattacker)) {
      break;
    }

    waitframe();
  }
}

function function_b5176a6465a5455b() {
  level endon("player_at_concourse_stairs");
  level.player endon("death");
  waittime = level.player getgestureanimlength("iw9_ges_gas_cough_long");
  cooldown = 5;

  while(true) {
    if(function_ae9983616987769c()) {
      var_800096efa6136d74 = level.player utility::player_gesture_combat("iw9_ges_gas_cough_long");

      if(istrue(var_800096efa6136d74)) {
        level.player val::set("cough", "damage", 0);
        level.player delaythread(waittime, &val::reset_all, "cough");
        level.player thread say_self("hero_cough_fit_soap_plr_1", 1, 0, 0);
        wait waittime + cooldown;
      }
    }

    wait 0.3;
  }
}

function function_ae9983616987769c() {
  if(level.player isthrowinggrenade()) {
    return false;
  }

  if(level.player isswitchingweapon()) {
    return false;
  }

  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  point1 = (28297.5, 4784.5, -661.5);
  point2 = (29180, 5620, -661.5);
  var_b0e57d35ef9cee89 = pointonsegmentnearesttopoint(point1, point2, level.player.origin);

  if(distancesquared(var_b0e57d35ef9cee89, level.player.origin) > 22500) {
    return false;
  }

  return true;
}

function function_e05be9dff75942c() {
  flag_wait("smoke_enemies_dead");
  thread utility::autosave_by_name();
}

function function_875d4520c51812b() {
  thread function_f3e7c7e794cba286("player_at_concourse_b", "struct_gunshot_concourse_combat_a");
  thread function_f3e7c7e794cba286("player_at_concourse_c", "struct_gunshot_concourse_combat_b");
  thread function_f3e7c7e794cba286("player_at_concourse_d", "struct_gunshot_concourse_combat_c");
}

function function_f3e7c7e794cba286(endonflag, targetname) {
  level endon(endonflag);
  structarray = getStructArray(targetname, "targetname");

  while(!flag(endonflag)) {
    foreach(struct in structarray) {
      start = struct.origin;
      end = struct.origin + (0, 0, 100);

      if(cointoss()) {
        function_a33c459fd65b08a0(start, end);
      } else {
        magicbullet("iw9_ar_mike4", start, end);
      }

      wait randomfloatrange(0.3, 0.5);
    }

    wait randomintrange(2, 4);
  }
}

function function_a33c459fd65b08a0(start, end) {
  for(i = 0; i < 3; i++) {
    magicbullet("iw9_ar_mike4", start, end);
    wait randomfloatrange(0.1, 0.2);
  }

  wait 0.5;

  for(i = 0; i < 5; i++) {
    magicbullet("iw9_ar_mike4", start, end);
    wait randomfloatrange(0.1, 0.2);
  }
}

function function_25393bbf27d09350() {
  thread function_9e0625b6a3445fc3();
  animnode = getStruct("animnode_concourse_door_end", "targetname");

  while(distance2dsquared(animnode.origin, level.player.origin) > 640000) {
    waitframe();
  }

  enemyspawners = getspawnerarray("enemy_concourse_inside_stairwell");
  enemies = array_spawn(enemyspawners, 1);
  flag_set("concourse_stiarwell_enemies_spawn");
  function_199bd953909a998e();
}

function function_90a7f510097cffd3() {
  doors = getEntArray("concourse_anim_door", "script_noteworthy");
  doors = array_combine(doors, getEntArray("penthouse_anim_door", "script_noteworthy"));

  foreach(door in doors) {
    if(isDefined(door) && isDefined(door.target)) {
      door.collision = getEnt(door.target, "targetname");
      door.collision linkTo(door);
    }
  }
}

function function_18fba09d8d521583(debug_mode) {
  if(!isDefined(debug_mode)) {
    debug_mode = 0;
  }

  level.var_88e6a4aa02c0cb9a = spawnStruct();
  level.var_88e6a4aa02c0cb9a.debug_mode = debug_mode;
  level.var_88e6a4aa02c0cb9a.animnode = getStruct("animnode_concourse_door_end", "targetname");

  if(istrue(debug_mode)) {
    level.var_88e6a4aa02c0cb9a.animnode = {
      #angles: (0, -37, 0), #origin: (31504, 2792, -936)
    };
  }

  level.var_88e6a4aa02c0cb9a.var_ee32376b13801f98 = getEnt("concourse_end_door_left", "targetname");
  level.var_88e6a4aa02c0cb9a.var_ee32376b13801f98 assign_animtree("concourse_door_left");
  level.var_88e6a4aa02c0cb9a.doorright = getEnt("concourse_end_door_right", "targetname");
  level.var_88e6a4aa02c0cb9a.doorright assign_animtree("concourse_door_right");
  level.var_88e6a4aa02c0cb9a.doors = [level.var_88e6a4aa02c0cb9a.var_ee32376b13801f98, level.var_88e6a4aa02c0cb9a.doorright];

  foreach(door in level.var_88e6a4aa02c0cb9a.doors) {
    door.animnode = level.var_88e6a4aa02c0cb9a.animnode;
    door dontinterpolate();
    door.animnode anim_first_frame_solo(door, "fbk_0290_slowdeath");
  }
}

function function_199bd953909a998e() {
  level.player clearsoundsubmix("sp_jup_flashback_concourse", 3.5);
  level.player setsoundsubmix("sp_jup_flashback_stairs_lower_door_moment", 0.5);
  level.player delaycall(5, &clearsoundsubmix, "sp_jup_flashback_stairs_lower_door_moment", 5);
  assert(isDefined(level.var_88e6a4aa02c0cb9a));
  flag_init("player_interupted_execution");
  thread function_749e89b46ff718da();
  var_c59a1bf410f24b79 = [];

  foreach(door in level.var_88e6a4aa02c0cb9a.doors) {
    var_c59a1bf410f24b79[var_c59a1bf410f24b79.size] = door;
  }

  if(istrue(level.var_88e6a4aa02c0cb9a.debug_mode)) {
    enemies = array_spawn(getspawnerarray("enemy_concourse_inside_stairwell"));
  } else {
    enemies = get_living_ai_array("enemy_concourse_inside_stairwell", "targetname");
  }

  level.var_88e6a4aa02c0cb9a.enemies = [];

  for(i = 0; i < enemies.size; i++) {
    guy = enemies[i];
    guy.animname = "cop0" + i + 1;
    guy.ignoreme = 1;
    guy.animnode = level.var_88e6a4aa02c0cb9a.animnode;
    guy set_allowdeath(1);
    guy function_1a479cad9c3adbb1(0);
    level.var_88e6a4aa02c0cb9a.enemies[level.var_88e6a4aa02c0cb9a.enemies.size] = guy;
    var_c59a1bf410f24b79[var_c59a1bf410f24b79.size] = guy;
  }

  level.var_88e6a4aa02c0cb9a.civs = [];

  for(i = 1; i < 4; i++) {
    is_male = 1;
    animname = "civ0" + i;

    if(animname == "civ02") {
      is_male = 0;
    }

    guy = namespace_47819225b08b445d::spawn_civ(undefined, undefined, is_male);
    guy notify("stop_injured_dmg_death_logic");
    guy.animname = animname;
    guy.animnode = level.var_88e6a4aa02c0cb9a.animnode;
    guy notify("disable_headlook");
    guy set_allowdeath(1);
    guy thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    guy playSound("fb_civ_death_stairwell");
    level.var_88e6a4aa02c0cb9a.civs[level.var_88e6a4aa02c0cb9a.civs.size] = guy;
    var_c59a1bf410f24b79[var_c59a1bf410f24b79.size] = guy;
  }

  assert(level.var_88e6a4aa02c0cb9a.civs.size);
  level.var_88e6a4aa02c0cb9a.survivors = [];

  for(i = 1; i < 3; i++) {
    animname = "survivor0" + i;
    is_male = 1;

    if(animname == "survivor01") {
      is_male = 0;
    }

    guy = namespace_47819225b08b445d::spawn_civ(undefined, undefined, is_male);
    guy.animname = animname;
    guy.animnode = level.var_88e6a4aa02c0cb9a.animnode;
    guy.deathfunction = &animation::function_ce450b9957138bd5;
    guy set_allowdeath(1);
    level.var_88e6a4aa02c0cb9a.survivors[level.var_88e6a4aa02c0cb9a.survivors.size] = guy;
  }

  assert(level.var_88e6a4aa02c0cb9a.survivors.size);
  array_call(var_c59a1bf410f24b79, &dontinterpolate);
  thread function_b17c15a0fabdfda9();
  level.var_88e6a4aa02c0cb9a.animnode anim_first_frame(var_c59a1bf410f24b79, "fbk_0290_slowdeath");
  level.var_88e6a4aa02c0cb9a.animnode anim_first_frame(level.var_88e6a4aa02c0cb9a.survivors, "fbk_0290_slowdeath");
  array_thread(level.var_88e6a4aa02c0cb9a.enemies, &function_ee7b4d976f0d0d32);
  array_thread(level.var_88e6a4aa02c0cb9a.civs, &function_de595924b3ebea40);
  array_thread(level.var_88e6a4aa02c0cb9a.doors, &door_logic);
  array_thread(level.var_88e6a4aa02c0cb9a.survivors, &survivor_logic);
  thread namespace_47819225b08b445d::function_5da13e5444950c67(level.var_88e6a4aa02c0cb9a.enemies, "concourse_stairs_scene_enemies_dead");
}

function function_749e89b46ff718da() {
  level endon("player_interupted_execution");
  flag_wait("nt_fbk_0290_no_return");
  struct = getStruct("struct_concourse_stair_door_eye", "targetname");

  if(distance2dsquared(level.player.origin, struct.origin) < 1000000 && within_fov(level.player.origin, level.player getplayerangles(), struct.origin, 0.642788)) {
    level.player say_team("dx_sp_flas_stcn_soap_no");
    level.player function_fc0eb6b81c66c661(0.2, "dx_sp_flas_stcn_soap_goddamnit");
  }
}

function function_ee7b4d976f0d0d32() {
  self.animnode anim_single_solo(self, "fbk_0290_slowdeath");
  self.ignoreme = 0;
  function_1a479cad9c3adbb1(1);
}

function function_de595924b3ebea40() {
  self.animnode anim_single_solo(self, "fbk_0290_slowdeath");
}

function survivor_logic() {
  self endon("death");
  thread survivor_run();
  thread survivor_death();
}

function survivor_run() {
  self endon("death");
  level endon("nt_fbk_0290_no_return");
  self.animnode anim_single_solo(self, "fbk_0290_slowdeath");

  if(flag("nt_fbk_0290_no_return")) {
    return;
  }

  node = getStruct("struct_civ_concourse_path_0", "targetname");
  thread scripts\sp\spawner::go_to_node(node);
}

function survivor_death() {
  self endon("death");
  level endon("player_interupted_execution");
  flag_wait("nt_fbk_0290_no_return");

  if(!is_dead_or_dying(self)) {
    thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    self.animnode anim_single_solo(self, "fbk_0290_slowdeath_killed");
  }
}

function door_logic() {
  self.animnode anim_single_solo(self, "fbk_0290_slowdeath");

  if(isDefined(self.collision) && self.collision.spawnflags & 1) {
    self.collision connectpaths();
  }
}

function function_e5076f4fdba65598() {
  foreach(enemy in level.var_88e6a4aa02c0cb9a.enemies) {
    enemy endon("death");
    enemy endon("damage");
  }

  array_wait_match(level.var_88e6a4aa02c0cb9a.enemies, "single anim", "end");
  level notify("police_anims_done");
}

function function_b17c15a0fabdfda9() {
  thread function_e5076f4fdba65598();
  level endon("police_anims_done");
  waittill_any_ents_array(level.var_88e6a4aa02c0cb9a.enemies, "death", "damage");

  foreach(enemy in level.var_88e6a4aa02c0cb9a.enemies) {
    enemy stopanimScripted();
  }

  flag_set("player_interupted_execution");
}

function function_9e0625b6a3445fc3() {
  level endon("player_look_at_concourse_stair");
  struct = getStruct("struct_concourse_stair_door_eye", "targetname");

  while(!function_6db117296b9b05fa(level.player.origin, struct.origin, 200000)) {
    waitframe();
  }

  flag_set("player_look_at_concourse_stair");
}

function function_504e22fba61ac454() {
  level endon("concourse_hostage_killer_hit");
  level endon("concourse_hostage_hit");

  while(!function_6db117296b9b05fa(level.player.origin, level.var_f49854aa539939b4.origin, 8000)) {
    waitframe();
  }

  flag_set("concourse_hostage_hit");
}

function function_6466d38354c8ebd9() {
  function_90a7f510097cffd3();
  function_18fba09d8d521583();

  foreach(door in level.var_88e6a4aa02c0cb9a.doors) {
    if(isDefined(door) && isDefined(door.collision) && door.collision.spawnflags & 1) {
      door.collision connectpaths();
    }
  }

  level.var_88e6a4aa02c0cb9a.animnode delaythread(0.5, &namespace_47819225b08b445d::function_b5b7c971ef980a7, level.var_88e6a4aa02c0cb9a.doors, "fbk_0290_slowdeath");
}

function function_f024697d2f071331(actors) {
  level endon("concourse_hostage_dead");
  flag_wait("concourse_hostage_killer_hit");
  self notify("stop_hostage_loop");
  array_call(actors, &stopanimscripted);
  anim_single(actors, "concourse_hostage_exit_b");
  flag_set("concourse_hostage_saved");
  level.var_f49854aa539939b4.killer function_89cbdb51c2bc27b7();
  level.var_f49854aa539939b4 anim_single_solo(level.var_f49854aa539939b4, "concourse_hostage_sit_idle");
  struct = getStruct("struct_civ_concourse_path_0", "targetname");
  level.var_f49854aa539939b4 endon("death");
  level.var_f49854aa539939b4 unlink();
  level.var_f49854aa539939b4 set_goal_radius(5);
  level.var_f49854aa539939b4 thread scripts\sp\spawner::go_to_node(struct);
  level.var_f49854aa539939b4 waittill("reached_path_end");
  level.var_f49854aa539939b4 stop_magic_bullet_shield();
  level.var_f49854aa539939b4 delete();
}

function function_a950b19f1d8a9dad() {
  var_f82eedd99e9fdd1d = getspawner("enemy_concourse_hostage", "targetname");
  var_fee9ce0d96dd084b = getspawner("civ_concourse_hostage", "targetname");
}

function function_7251ba5bb49b0864() {
  level endon("concourse_hostage_dead");
  level endon("concourse_hostage_hit");
  childthread function_19115262247348a7();
  waittill_any("damage", "bullethit");
  flag_set("concourse_hostage_killer_hit");
}

function function_76f841a2a88a3352() {
  level endon("concourse_hostage_dead");
  waittill_any("damage", "bullethit");
  flag_set("concourse_hostage_hit");
}

function function_19115262247348a7() {
  self waittill("death");
  flag_set("concourse_hostage_killer_hit");
}

function function_89cbdb51c2bc27b7() {
  set_allowdeath(1);
  stop_magic_bullet_shield();
  self kill();
}

function function_48b9d5295395a9a4(actors) {
  level endon("concourse_hostage_killer_hit");
  level endon("concourse_hostage_hit");
  struct = getStruct("struct_hostage_idle_spline_start", "targetname");
  mover = spawn_tag_origin(struct.origin, self.angles);
  self linkTo(mover);

  foreach(guy in actors) {
    guy linkTo(mover);
  }

  newtarget = getStruct(struct.target, "targetname");

  while(true) {
    mover moveTo(newtarget.origin, 3);
    mover waittill("movedone");

    if(!isDefined(newtarget.target)) {
      break;
    }

    newtarget = getStruct(newtarget.target, "targetname");
    wait 1;
  }

  flag_set("hostage_walk_done");
  wait 2;

  foreach(guy in actors) {
    guy unlink();
  }

  self unlink();
  thread function_f3929486de091fe8(actors);
  flag_wait_any("concourse_hostage_dead", "concourse_hostage_saved");
  mover delete();
}

function function_f3929486de091fe8(actors) {
  level endon("concourse_hostage_killer_hit");
  self notify("stop_hostage_loop");
  array_call(actors, &stopanimscripted);
  level.var_f49854aa539939b4.killer set_allowdeath(1);
  flag_set("concourse_hostage_dead");
  anim_single(actors, "concourse_hostage_exit_a");
  level.var_f49854aa539939b4.killer set_ignoreall(0);
  level.var_f49854aa539939b4.killer set_ignoreme(0);
  level.var_f49854aa539939b4.killer stop_magic_bullet_shield();
  thread anim_last_frame_solo(level.var_f49854aa539939b4, "concourse_hostage_exit_a");
  level.var_f49854aa539939b4 stop_magic_bullet_shield();
  level.var_f49854aa539939b4 visiblenotsolid();
  level.var_f49854aa539939b4 thread function_ab007d9e68a6d16b("player_at_concourse_stairs_1");
  flag_set("concourse_hostage_dead");
}

function concourse_combat_done() {
  flag_wait_all("concourse_combat_done");
  activate_trigger_with_targetname("trigger_concourse_ally_end");
}

function function_485a143d57e550b7() {
  thread function_ba6214134567c27a("trigger_concourse_out_b", "player_at_concourse_c", "player_on_ascendor");
  trigger_wait_targetname("trigger_concourse_out_b");
  flag_set("player_at_concourse_out_b");

  if(!flag("player_at_concourse_b")) {
    wait 1;
    enemyspawners = getspawnerarray("enemy_concourse_out_b");
    enemies = array_spawn(enemyspawners);
    thread namespace_47819225b08b445d::function_5da13e5444950c67(enemies, "concourse_out_b_enemies_dead");
  }
}

function function_485a133d57e54e84() {
  thread function_ba6214134567c27a("trigger_concourse_out_c", "player_at_concourse_d", "player_on_ascendor");
  trigger_wait_targetname("trigger_concourse_out_c");
  flag_set("player_at_concourse_out_c");

  if(!flag("player_at_concourse_c")) {
    enemyspawners = getspawnerarray("enemy_concourse_out_c");
    array_spawn(enemyspawners);
  }
}

function function_13a8f9f2f733fb1() {
  structs = getStructArray("struct_concourse_out_smoke", "targetname");

  foreach(struct in structs) {
    end = getgroundposition(struct.origin, 1);
  }

  enemyspawners = getspawnerarray("enemy_concourse_d_smoke");
  enemies = array_spawn(enemyspawners, 1);
  thread function_46d675dc092c3771(enemies, "smoke_enemies_dead", "player_at_concourse_e");
}

function function_44f3a6520a2ca727() {
  level endon("player_at_concourse_stairs");
  struct1 = {
    #angles: (0, 156.245, 0), #origin: (28886, 5381, -650)
  };
  struct2 = {
    #angles: (0, 358.4, 0), #origin: (28159.5, 5420, -668)
  };

  while(true) {
    var_68252fe0b47426bb = getaiarray("axis", "allies");

    foreach(guy in var_68252fe0b47426bb) {
      if(isalive(guy) && struct1 math::is_point_in_front(guy.origin) && struct2 math::is_point_in_front(guy.origin)) {
        if(!guy ent_flag("in_smoke")) {
          guy ent_flag_set("in_smoke");
          guy.maxvisibledist = 200;
          guy enable_cqbwalk();
        }
      } else if(isalive(guy) && guy ent_flag("in_smoke")) {
        guy ent_flag_clear("in_smoke");
        guy.maxvisibledist = 8192;
        guy disable_cqbwalk();
      }

      waitframe();
    }

    wait 0.65;
  }
}

function function_f0434d947a2ecf4c(var_ec5021bbd54f4d97, var_70447122e184892d) {
  structarray = getStructArray(var_ec5021bbd54f4d97, "targetname");
  var_fee9ce0d96dd084b = getspawner(var_70447122e184892d, "targetname");
  civs = [];

  foreach(struct in structarray) {
    var_fee9ce0d96dd084b.count = 1;
    civ = var_fee9ce0d96dd084b spawn_ai();
    civs[civs.size] = civ;
    civ.var_aa6cee6a954fdcdc = struct;
    wait 0.1;
  }

  return civs;
}

function function_d718c819fe813832() {
  self clearpath();
  set_goal_radius(50);
  self endon("death");

  for(struct = self.var_aa6cee6a954fdcdc; true; struct = getStruct(struct.target, "targetname")) {
    self setgoalpos(struct.origin);
    self waittill("goal");

    if(!isDefined(struct.target)) {
      break;
    }
  }

  self delete();
}

function function_ab6aeb48cee6016() {
  enemyspawners = getspawnerarray("enemy_concourse_a");
}

function function_d90396978fe6b6f7() {
  enemyspawners = getspawnerarray("enemy_concourse_b");
  array_spawn_function(enemyspawners, &function_e4fc78962c5d164);
  function_5a72f15ad78e5700();
  function_f890a5c4d84890ca();
}

function function_5a72f15ad78e5700() {
  enemyspawners = getspawnerarray("enemy_concourse_out_b");
  array_spawn_function(enemyspawners, &function_b1f9d04067329bb9);
}

function function_b1f9d04067329bb9() {
  flag_set("concourse_combat_out_b_spawned");
}

function function_f890a5c4d84890ca() {
  enemyspawners = getspawnerarray("enemy_concourse_b_extra");
  array_spawn_function(enemyspawners, &set_movement_speed, 180);
  array_spawn_function(enemyspawners, &function_62aec8b5e3137207);
}

function function_62aec8b5e3137207() {
  self.script_forcegoal = 1;
  thread function_a884e5a1d3d99f16();
}

function function_a884e5a1d3d99f16() {
  ent_flag_init("reach_path_end");
  self waittill("reached_path_end");
  ent_flag_set("reach_path_end");
}

function function_e4fc78962c5d164() {
  if(is_equal(self.script_noteworthy, "molotov_thrower")) {
    result = waittill_any_return("death", "reached_path_end");

    if(result == "death") {
      return;
    }

    self.grenadeweapon = makeweapon("molotov");
    grenadetargetpos = (29384, 4888, -616);
    armoffset = getgrenadethrowoffset("exposed_throw_grenade", 1);
    velocityvec = self checkgrenadethrowpos(armoffset, grenadetargetpos, 0, "min energy");

    if(isDefined(velocityvec)) {
      self.var_ca01d1496480b62c = grenadetargetpos;
      self.var_624efed57c34c807 = velocityvec;
      thread namespace_47819225b08b445d::function_efc089d7d1b8af28(10, grenadetargetpos, (55, 55, 55), (0, 225, 0), "neutral", "neutral");
    }

    thread spawner::go_to_node(getnode("molotov_thrower_post_throw_node", "targetname"));
  }

  if(is_equal(self.script_noteworthy, "enemy_balcony_shooter")) {
    self.script_forcebalconydeath = 1;
    self.script_forcegoal = 1;
    disable_long_death();
    namespace_47819225b08b445d::function_447207547d20ae92();
    thread function_f6d4b09ee0fde7b3();
  }
}

function function_f6d4b09ee0fde7b3() {
  start_pos = spawnStruct();
  start_pos.origin = (29332.6, 5316, -608);
  end_pos = spawnStruct();
  end_pos.origin = (29000, 5200, -608);
  namespace_47819225b08b445d::function_fbb289d0b3ad4df0();
  self.fake_enemy.origin = start_pos.origin;
  self.fake_enemy.health = 9999;
  self.fake_enemy.targetname = "balcony_shooter_fake_enemy";
  namespace_47819225b08b445d::function_15e8419bc7722d0b();
  self.fake_enemy thread function_235b6934eacb0b77(start_pos, end_pos, 3);
  function_35fd51823f9dbc3e();
  namespace_47819225b08b445d::ignore_fake_enemy();
  namespace_47819225b08b445d::function_363c08ddb86b8493();
}

function function_35fd51823f9dbc3e(distance_threshold, optional_endon) {
  if(!isDefined(distance_threshold)) {
    distance_threshold = 1120;
  }

  self endon("death");
  self endon("damage");

  if(isDefined(optional_endon)) {
    self endon(optional_endon);
  }

  while(true) {
    var_bf88912c237ec109 = distance2dsquared(level.player.origin, self.origin);

    if(var_bf88912c237ec109 < distance_threshold * distance_threshold || self.fake_enemy.health < 1) {
      break;
    }

    wait 1;
  }

  self notify("player_close");
}

function function_235b6934eacb0b77(start_pos, end_pos, move_time) {
  self endon("death");
  self endon("damage");
  self endon("stop_shooting_fake_enemy");

  if(isvector(start_pos)) {
    start = start_pos;
  } else {
    start = start_pos.origin;
  }

  if(isvector(end_pos)) {
    end = end_pos;
  } else {
    end = end_pos.origin;
  }

  while(true) {
    self moveTo(end, move_time);
    wait move_time;
    self moveTo(start, move_time);
    wait move_time;
  }
}

function function_9542731bda504cc3() {
  level.var_3df1f4a9966d9c41 = default_to(level.var_3df1f4a9966d9c41, []);
  level.var_3df1f4a9966d9c41[level.var_3df1f4a9966d9c41.size] = self;
}

function function_de2e5b48058efa80() {
  enemyspawners = getspawnerarray("enemy_concourse_c");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
  function_55482caa61e61377();
}

function function_55482caa61e61377() {
  enemyspawners = getspawnerarray("enemy_concourse_out_c");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
}

function function_6d3567f851c4d2d9() {
  enemyspawners = getspawnerarray("enemy_concourse_d");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
  function_faff94c715c3b03b();
}

function function_faff94c715c3b03b() {
  enemyspawners = getspawnerarray("enemy_concourse_d_smoke");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
}

function function_ac4255109ff379e2() {
  enemyspawners = getspawnerarray("enemy_concourse_e");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
}

function function_40b875d4e0017c4() {
  enemyspawners = getspawnerarray("enemy_concourse_inside_stairwell");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
}

function function_f4b26798e8723de9() {
  enemyspawners = getspawnerarray("enemy_concourse_start");
  array_spawn_function(enemyspawners, &function_9542731bda504cc3);
}

function function_93c8fdc795d4717c() {
  enemyspawners = getspawnerarray("enemy_concourse_stairs_1");
  array_spawn_function(enemyspawners, &function_50edfdcb8f0095c7);
}

function function_5bb5be7ceb9e379() {
  enemyspawners = getspawnerarray("enemy_concourse_stairs_2");
  array_spawn_function(enemyspawners, &function_50edfdcb8f0095c7);
}

function function_50edfdcb8f0095c7() {
  level.var_f23b3e4753f0fb2 = default_to(level.var_f23b3e4753f0fb2, []);
  level.var_f23b3e4753f0fb2[level.var_f23b3e4753f0fb2.size] = self;
  self.team = "axis";
  self.script_team = "axis";
  self.name = "";
  self.grenadeammo = 0;
  self.baseaccuracy = 0.6;
  set_movement_speed(180);
  self allowedstances("stand");
  self getenemyinfo(level.player);
  self enableavoidance(0, 1);
  set_goal_radius(5);
  set_goal_height(20);
}

function function_78dec95811d71534() {
  thread function_48ac97e10ef2c9af("struct_anim_cower_b", "player_at_concourse_c");
}

function function_9a4a78ea609bc08b() {
  self function_b661b022700ba72f("script", 1);
  self function_d5cda8a759cc36bc("flee");
  speed = randomintrange(195, 200);
  set_movement_speed(speed);
  self.maystumble = 1;
}

function function_1e423ccffad5d3cd(targetname) {
  guys = get_living_ai_array(targetname, "targetname");

  foreach(guy in guys) {
    if(!namespace_47819225b08b445d::function_e7c30095a6cdc3ef(guy getEye())) {
      guy delete();
    }
  }
}

function function_fa6808088cd6c88d() {
  var_fee9ce0d96dd084b = getspawner("civ_concourse_far_side", "targetname");
  level endon("player_on_ascendor");
  level.var_72235c2923f36d22 = [];
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_far_side_1", 999, 3);
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_far_side_2", 999, 4);
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_far_side_3", 999, 2);
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_far_side_4", 999, 5);
}

function function_86b791c1893be31b() {
  var_fee9ce0d96dd084b = getspawner("civ_concourse_far_side", "targetname");
  level endon("player_at_concourse_c");
  level.var_72235c2923f36d22 = [];
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_back_side_1", 999, 3);
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_back_side_2", 999, 4);
  childthread namespace_84ed3a3872f22d68::function_e8623dcf9dbedfc3("civ_concourse_far_side", "struct_crowd_stadium_int_back_side_5", 999, 6);
}

function function_2460e4a11a304e89() {
  civspawners = getspawnerarray("civ_concourse_early_1");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  civspawners = getspawnerarray("civ_concourse_early_2");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  civspawners = getspawnerarray("civ_concourse_early_3");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
}

function function_25349ebc42a2b51d() {
  civspawners = getspawnerarray("civ_concourse_a");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
  civspawners = getspawnerarray("civ_concourse_a_main");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
}

function function_a6664e8cc7c322e8() {
  civspawners = getspawnerarray("civ_concourse_b");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
  function_79375008fc5214af();
}

function function_79375008fc5214af() {
  var_fee9ce0d96dd084b = getspawner("civ_concourse_out_b", "targetname");
  var_fee9ce0d96dd084b add_spawn_function(&function_f7941b6f37af6a94);
}

function function_4cbb35939dcfd68b() {
  civspawners = getspawnerarray("civ_concourse_c");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
  civspawners = getspawnerarray("civ_concourse_c_main");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
}

function function_c9ed90e79e5ef4e() {
  civspawners = getspawnerarray("civ_concourse_d");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
}

function function_c423e525c7264691() {
  civspawners = getspawnerarray("civ_concourse_e");
  array_spawn_function(civspawners, &function_f7941b6f37af6a94);
  array_spawn_function(civspawners, &namespace_47819225b08b445d::function_e29483c00b1210fa);
}

function function_a84ac189c12dadb2() {
  var_fee9ce0d96dd084b = getspawner("civ_concourse_stairs", "targetname");
  var_fee9ce0d96dd084b add_spawn_function(&function_2f4525039bec1a0e);
}

function function_f7941b6f37af6a94() {
  function_9a4a78ea609bc08b();
  self.disablearrivals = 1;
  level.var_59ef7b8f0b1ed260 = default_to(level.var_59ef7b8f0b1ed260, []);
  level.var_59ef7b8f0b1ed260[level.var_59ef7b8f0b1ed260.size] = self;
  self function_3865e25cd6d22f56("focus_behaviors", "fsm", "civ_default");
  thread bump_player();
  thread civ_headlook();
  thread namespace_47819225b08b445d::injured_dmg_death_logic();
  thread delete_on_path_end();
}

function delete_on_path_end() {
  self endon("death");
  self endon("entitydeleted");
  self waittill("reached_path_end");
  self delete();
}

function function_2f4525039bec1a0e() {
  self dontinterpolate();
  self function_b661b022700ba72f("script", 1);
  self.disablearrivals = 1;
  self function_d5cda8a759cc36bc("cower");
  self.ignoreme = 1;
  self enableavoidance(0, 0);
  thread bump_player();
  thread namespace_47819225b08b445d::injured_dmg_death_logic();
  level.var_375090d896d72a46 = default_to(level.var_375090d896d72a46, []);
  level.var_375090d896d72a46[level.var_375090d896d72a46.size] = self;
  disable_pain();
  delaythread(1, &set_movement_speed, 90);
  delaythread(3, &set_movement_speed, 180);
}

function function_17dd057ac41662e1() {
  level endon("infil_stairs_player_at_top");
  spawners = getspawnerarray("civ_concourse_early_1");
  childthread function_e8f80e3a670cfd8d(spawners);
  spawners = getspawnerarray("civ_concourse_early_2");
  childthread function_e8f80e3a670cfd8d(spawners);
  spawners = getspawnerarray("civ_concourse_early_3");
  childthread function_e8f80e3a670cfd8d(spawners);
}

function function_e8f80e3a670cfd8d(spawners) {
  while(true) {
    foreach(spawner in spawners) {
      var_cb8e2103144ac736 = randomfloatrange(0.8, 2);
      wait var_cb8e2103144ac736;
      spawner.count = 1;
      guy = spawner spawn_ai(1);
    }
  }
}

function function_f9c00d92bcfe4470() {
  runto_node = getStruct("concourse_execute_runto_node", "targetname");
  namespace_47819225b08b445d::function_87a1690da9ade14(runto_node);
}

function function_54878a8b1dd817af(animnode) {
  namespace_47819225b08b445d::function_264ea5c38c1ae771();
  animnode thread anim_loop_solo(self, "concourse_intro_group1_idle");
}

function concourse_execute() {
  var_40467c011c89e682 = 0;
  animnode = {
    #angles: (0, 0, 0), #origin: (31105, 2866, -672)
  };
  var_c59a1bf410f24b79 = [];
  var_5d9044a3044ff257 = [];

  for(i = 1; i < 5; i++) {
    civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1, undefined, undefined, undefined, 1);
    civ.animname = "civ0" + i;
    var_5d9044a3044ff257[var_5d9044a3044ff257.size] = civ;

    switch (civ.animname) {
      case #"hash_743e43a7aaadb5d1":
      case #"hash_743e46a7aaadba8a":
        civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
        break;
      case #"hash_743e45a7aaadb8f7":
        civ thread function_f9c00d92bcfe4470();
        break;
      case #"hash_743e44a7aaadb764":
        civ thread function_54878a8b1dd817af(animnode);
        break;
    }

    animnode anim_first_frame_solo(civ, "concourse_intro_group1");
  }

  var_c59a1bf410f24b79 = array_merge(var_c59a1bf410f24b79, var_5d9044a3044ff257);
  var_2060e7eae801727c = [];

  for(i = 5; i < 10; i++) {
    is_male = 1;
    animname = "civ0" + i;

    switch (animname) {
      case #"hash_743e3ea7aaadadf2":
      case #"hash_743e40a7aaadb118":
        is_male = 0;
        break;
    }

    civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, is_male);
    civ.animname = animname;
    var_2060e7eae801727c[var_2060e7eae801727c.size] = civ;
    civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
    animnode anim_first_frame_solo(civ, "concourse_intro_group2");
  }

  var_c59a1bf410f24b79 = array_merge(var_c59a1bf410f24b79, var_2060e7eae801727c);

  if(var_40467c011c89e682) {
    var_a4763d72497e0305 = [];
    var_f82eedd99e9fdd1d = getspawnerarray("dynamic_spawner")[0];

    for(i = 1; i < 4; i++) {
      enemy = spawn_aitype(var_f82eedd99e9fdd1d.classname, (0, 0, 0), (0, 0, 0), 1);
      enemy.animname = "enemy0" + i;
      enemy thread namespace_47819225b08b445d::function_c0036e04e68c5f15();
      enemy function_1a479cad9c3adbb1(0);
      var_a4763d72497e0305[var_a4763d72497e0305.size] = enemy;
      enemy dontinterpolate();
      animnode anim_first_frame_solo(enemy, "concourse_intro_group2");
    }

    var_c59a1bf410f24b79 = array_merge(var_c59a1bf410f24b79, var_a4763d72497e0305);
  }

  if(level.start_point != "stadium_combat_enter" && level.start_point != "stadium_combat_int" && level.start_point != "concourse_a") {
    trigger_wait_targetname("trigger_infil_stairs_top");
  }

  animnode thread anim_single(var_5d9044a3044ff257, "concourse_intro_group1");

  if(level.start_point != "stadium_combat_enter" && level.start_point != "stadium_combat_int" && level.start_point != "concourse_a") {
    trigger_wait_targetname("trigger_concourse_start");
  }

  thread namespace_ccad715273481961::function_68562e15bb2bd6f0("sp_jup_flashback_concourse_reveal_moment", 3.5, 1, 8, 10);
  thread function_7aa9bee22a31baa6();
  thread play_sound_in_space("fb_crowd_panic_concourse_reveal_moment", (30748, 3474, -566));
  animnode thread anim_single(var_2060e7eae801727c, "concourse_intro_group2");

  if(var_40467c011c89e682) {
    animnode anim_single(var_a4763d72497e0305, "concourse_intro_group2");

    foreach(enemy in var_a4763d72497e0305) {
      enemy function_1a479cad9c3adbb1(0);
    }
  }

  if(!var_40467c011c89e682) {
    var_a4763d72497e0305 = [];
    i = 1;
    execution_spawners = getspawnerarray("concourse_execution_enemy");

    foreach(spawner in execution_spawners) {
      enemy = spawner spawn_ai(1);
      enemy thread function_e4b19bcdfc4817e0();
      assertex(isDefined(enemy), "Failed to spawn enemy for concourse execution scene!");
      enemy.animname = "enemy0" + i;
      var_a4763d72497e0305[var_a4763d72497e0305.size] = enemy;
      var_c59a1bf410f24b79[var_c59a1bf410f24b79.size] = enemy;
      i++;
    }
  }

  thread function_29eaf7d9d2a90e3a(var_a4763d72497e0305);
  namespace_47819225b08b445d::function_5da13e5444950c67(var_a4763d72497e0305, "concourse_execution_enemies_dead");
  thread autosave_by_name();
}

function function_29eaf7d9d2a90e3a(enemies) {
  level endon("trigger_concourse_b");
  function_9b971e1bc95bc1df(enemies, &headshot_monitor);
  array_wait(enemies, "headshot");
  death_point = (30379, 3035, -669);

  while(true) {
    if(distance2dsquared(death_point, level.player.origin) < 3600 && within_fov(level.player.origin, level.player getplayerangles(), death_point, cos(45))) {
      break;
    }

    waitframe();
  }

  was_played = level.player utility::player_gesture_combat("ges_salute_mp");
}

function headshot_monitor() {
  self waittill("damage", dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);

  if(scripts\sp\damagefeedback::isheadshot(full_partname) && is_equal(attacker, level.player)) {
    self notify("headshot");
  }
}

function function_8fec7bf25599e39e(node) {
  self.allowdeath = 0;
  flag_wait("infil_stairs_player_at_top");
  node anim_single_solo(self, "concourse_intro");

  if(self.animname != "civ02") {
    die_frozen();
  }
}

function function_e4b19bcdfc4817e0() {
  self endon("death");
  self setgoalpos(self.origin, 32);
  self.ignoreall = 1;
  flag_wait("infil_stairs_player_at_top");
  self.ignoreall = 0;
  self.og_sidearm = self.sidearm;
  self.sidearm = nullweapon();
  self.ignoreme = 1;
  set_movement_speed(64 + randomint(4));
  spot = self.origin + anglesToForward(self.angles) * 550;
  self.goalradius = 32;
  self.disablearrivals = 1;
  self setgoalpos(getclosestpointonnavmesh(spot));
  waitframe();
  namespace_47819225b08b445d::function_15e8419bc7722d0b();
  childthread function_e22110d3da2d9559();
  function_77e167158f5effbb();

  if(!flag("player_engaged")) {
    flag_set("player_engaged");
  }

  self.ignoreme = 0;
  namespace_47819225b08b445d::ignore_fake_enemy();
  self.disablearrivals = 0;
  clear_movement_speed();
  self setgoalpos(self.origin);
  self.goalradius = 1000;
  self.sidearm = self.og_sidearm;
}

function function_77e167158f5effbb() {
  self endon("death");
  start = gettime();

  while(true) {
    if(isDefined(self.lastattacker) && isPlayer(self.lastattacker)) {
      break;
    }

    if(time_has_passed(start, 7)) {
      break;
    }

    if(flag("player_engaged")) {
      wait 0.8 + randomfloat(1);
      break;
    }

    waitframe();
  }
}

function function_e22110d3da2d9559() {
  self endon("stop_shooting_fake_enemy");

  while(true) {
    var_bdc37736ca03f0ce = namespace_5e9fb42dea43f1f0::function_1b73273370d27c99();
    targets = sortbydistance(var_bdc37736ca03f0ce, self.origin);
    var_7187aca64d5f7699 = undefined;
    angles = vectortoangles(self.goalpos - self.origin);

    foreach(civ in targets) {
      if(utility::within_fov(self.origin, angles, civ.origin, 0.642788)) {
        var_7187aca64d5f7699 = civ;
        break;
      }
    }

    if(!isDefined(var_7187aca64d5f7699)) {
      waitframe();
      continue;
    }

    self.fake_enemy.health = 999;
    from = self getshootfrompos();
    to = var_7187aca64d5f7699 gettagorigin("j_spine4");
    angles = vectortoangles(to - from);
    spot = from + anglesToForward(angles) * 150;
    self.fake_enemy.origin = spot;
    self cansee(self.fake_enemy, 0);
    self.bulletsinclip = weaponclipsize(self.weapon);
    var_7187aca64d5f7699 waittill_notify_or_timeout("death", 1.5);
  }
}

function function_13635c1df73f29c3() {
  level.player endon("death");
  level endon("player_on_ascendor");
  add_extra_autosave_check("prevent_save_on_field", &function_5ad31b80db6408b4, "Player is on the field");
  add_extra_autosave_check("player_oob", &function_5a41cfd6197b85bd, "Player is on out of bounds");
  trigger = getEnt("trigger_field", "targetname");
  level.player.on_field = 0;

  while(true) {
    waitframe();

    if(level.player istouching(trigger)) {
      if(!level.player.on_field) {
        level.player.on_field = 1;
        thread function_a4b065324ca2206b();
      }

      continue;
    }

    level.player.on_field = 0;
    level.player notify("out_of_field");
  }
}

function function_a4b065324ca2206b() {
  level.player endon("out_of_field");
  thread function_cd83dfebf9f2f7f9();
  wait 0.5;
  childthread function_da3d978630efb606();
  wait 1.5;
  function_fef68651f4786a();
  function_86ca9dc84c890062();
}

function function_cd83dfebf9f2f7f9() {
  level.price function_fc0eb6b81c66c661(1, "dx_sp_flas_ccrs_pric_getoutofthereyoureto");
}

function function_da3d978630efb606() {
  level.player endon("out_of_field");
  var_b7446ac290118e4b = ["ar_crack_near_near", "ar_crack_near_med"];
  hit_aliases = ["ar_super_whiz_near", "ar_super_whiz_med", "ar_super_whiz_far", "ar_super_whiz_veryfar"];

  while(true) {
    thread play_sound_in_space(random(var_b7446ac290118e4b), level.player getEye());
    wait randomfloatrange(0.1, 0.3);
    thread play_sound_in_space(random(hit_aliases), level.player getEye());
  }
}

function function_fef68651f4786a() {
  level.player endon("out_of_field");
  structarray = getStructArray("struct_stadium_sniper", "targetname");
  impact_aliases = ["prj_bullet_small_flesh_torso_plr", "prj_bullet_large_flesh_torso_plr"];

  for(i = 0; i < 4; i++) {
    level.player dodamage(level.player.health + 1, random(structarray).origin, undefined, undefined, "MOD_RIFLE_BULLET");
    thread play_sound_in_space(random(impact_aliases), level.player getEye());
    wait randomfloatrange(0.2, 1);
  }
}

function function_86ca9dc84c890062() {
  structarray = getStructArray("struct_stadium_sniper", "targetname");
  finalstruct = undefined;

  foreach(struct in structarray) {
    if(isDefined(finalstruct)) {
      continue;
    }

    if(!namespace_47819225b08b445d::function_e7c30095a6cdc3ef(struct.origin)) {
      finalstruct = struct;
    }
  }

  if(!isDefined(finalstruct)) {
    finalstruct = structarray[0];
  }

  magicbullet("iw9_ar_mike4", finalstruct.origin, level.player getEye());
  wait 0.1;
  scripts\sp\player_death::set_custom_death_quote(516);
  level.player kill();
}

function function_bb19fc343b60e7a7() {
  level endon("player_at_concourse_stairs");
  function_a84ac189c12dadb2();
  structs = getStructArray("struct_concourse_stairs_civ_start_0", "targetname");
  var_fee9ce0d96dd084b = getspawner("civ_concourse_stairs", "targetname");
  flag_wait_any("concourse_hostage_dead", "concourse_hostage_saved");

  while(!flag("concourse_stairs_2_enemies_dead")) {
    foreach(struct in structs) {
      var_cb8e2103144ac736 = randomintrange(1, structs.size);

      if(i < var_cb8e2103144ac736) {
        continue;
      }

      function_a89224372a5cd28c(struct, var_fee9ce0d96dd084b);
      wait randomfloatrange(0.2, 0.5);
    }

    wait randomintrange(3, 6);
  }
}

function concourse_stairs_1() {
  thread function_f3e7c7e794cba286("player_at_concourse_stairs_1", "struct_gunshot_stairs_1");
  trigger_wait_targetname("trigger_concourse_stairs_anim_second_lfoor");
  trigger_wait_targetname("trigger_concourse_stairs_1");
  flag_set("player_at_concourse_stairs_1");
  thread function_f3e7c7e794cba286("player_at_concourse_stairs_2", "struct_gunshot_stairs_2");
}

function stairs_murder() {
  trigger_wait_targetname("trigger_concourse_stairs_1");
  enemies = [];
  spawners = getspawnerarray("enemy_concourse_stairs_1");

  foreach(spawner in spawners) {
    node = getnode(spawner.target, "targetname");
    enemy = utility::spawn_aitype("actor_jup_enemy_police_ar", node.origin, node.angles, 1, 0, 0, "stairs_murderer");
    enemy.goalradius = 32;
    enemy setgoalnode(node);
    enemy.dontevershoot = 1;
    enemy.grenadeammo = 0;
    enemy namespace_47819225b08b445d::function_447207547d20ae92();
    enemy ai::magic_bullet_shield();
    enemies[enemies.size] = enemy;
  }

  thread namespace_47819225b08b445d::function_5da13e5444950c67(enemies, "concourse_stairs_1_enemies_dead");
  thread function_b511e99b84377640(enemies);

  while(level.player.origin[2] < -525) {
    waitframe();
  }

  flag_set("stairs_murder");
  autosave_by_name();
  array_thread(enemies, &ai::stop_magic_bullet_shield);
  temp = spawners[0] spawn_script_origin();
  temp playSound("walla_civ_panic_stairs_shot");
  temp delaythread(2, &utility::sound_fade_and_delete, 1);
  civs = [];
  animnames = ["right_03_male", "left_01_female", "left_03_female", "right_01_female"];

  foreach(animname in animnames) {
    thread function_fc6e6e180eb58077("top", animname);

    if(i == 1) {
      wait 1.2;
    }
  }

  var_23c6346c443f5c55 = getaiarrayinradius(node.origin, 350, "neutral");
  utility::array_thread(var_23c6346c443f5c55, &become_target);
  enemies = utility::array_removeundefined(enemies);

  if(!enemies.size) {
    return;
  }

  utility::array_thread(enemies, &utility::disable_dontevershoot);
  utility::array_thread(enemies, &function_a3f1569faa4bc198);
}

function function_b511e99b84377640(enemies) {
  waittill_dead_or_dying(enemies);
  var_23c6346c443f5c55 = getaiarray("neutral");

  foreach(civ in var_23c6346c443f5c55) {
    civ.team = "neutral";
  }

  flag_clear("stairs_murder");
}

function function_a3f1569faa4bc198() {
  self endon("death");
  namespace_47819225b08b445d::function_15e8419bc7722d0b();
  childthread murder_shoot();

  while(true) {
    var_23c6346c443f5c55 = getaiarrayinradius(self.origin, 330, "neutral");
    var_23c6346c443f5c55 = sortbydistance(var_23c6346c443f5c55, self.origin);
    target = undefined;
    var_9f840f45b5af631d = 1;

    foreach(civ in var_23c6346c443f5c55) {
      if(!is_equal(civ.script_noteworthy, "top")) {
        continue;
      }

      if(!isalive(civ)) {
        continue;
      }

      var_1bac71332ff19ede = civ gettagorigin("j_spine4");
      frames = 0;

      if(sighttracepassed(self gettagorigin("tag_eye"), var_1bac71332ff19ede, 0, self, civ)) {
        while(isalive(civ)) {
          waitframe();

          if(!self tagexists("tag_flash")) {
            continue;
          }

          var_9f840f45b5af631d = 0;
          dist = distance(self.origin, civ.origin);
          from = self gettagorigin("tag_flash");
          self.fake_enemy.health = 999;
          to = civ gettagorigin("j_spine4");
          angles = vectortoangles(to - from);
          spot = from + anglesToForward(angles) * dist / 2;
          self.fake_enemy.origin = spot;

          if(frames == 25) {
            self.bulletsinclip = weaponclipsize(self.weapon);
            self cansee(self.fake_enemy, 0);
            frames = 0;
            continue;
          }

          frames++;
        }
      }

      wait 1.5;
    }

    if(var_9f840f45b5af631d) {
      self.fake_enemy.origin = level.player getEye() + (0, 0, 25);
      break;
    }

    waitframe();
  }

  self notify("stop_fake_shooting");
  wait 0.3;
  self.dontevershoot = 0;
  namespace_47819225b08b445d::function_363c08ddb86b8493();
  namespace_47819225b08b445d::ignore_fake_enemy();
}

function murder_shoot() {
  self endon("stop_fake_shooting");
  self.dontevershoot = 1;

  while(true) {
    burst = randomintrange(15, 25);

    for(i = 0; i < burst; i++) {
      if(!isnullweapon(self.weapon)) {
        self shoot();
      }

      wait 0.1;

      if(utility::percent_chance(15)) {
        wait 0.1;
      }
    }

    wait 0.65;
  }
}

function become_target() {
  if(!isalive(self)) {
    return;
  }

  self.health = 60;
  self.allowdeath = 1;
}

function stairs_murderer() {
  self endon("death");

  if(self.animname == "enemy01") {
    self shoot();
  }

  self waittill("damage");

  if(self isinscriptedstate()) {
    self stopanimScripted();
  }
}

function function_9bf87e7d0c204e62() {
  left = [];
  right = [];
  var_8e5fa3b3638168c8 = utility::function_df57c8a03e293db4("loop");

  foreach(name in var_8e5fa3b3638168c8) {
    if(name[0] == "l") {
      left[left.size] = name;
      continue;
    }

    right[right.size] = name;
  }

  level.var_99f44432dff3de84 = utility::create_deck(left, 0, 1, 1);
  level.var_bb573827894e8229 = utility::create_deck(right, 0, 1, 1);
}

function function_eb1f8ad123dba023() {
  level endon("player_at_concourse_stairs_2");
  function_9bf87e7d0c204e62();
  struct = getStruct("struct_objective_concourse_e", "targetname");
  close = 10000;

  while(true) {
    if(distance2dsquared(level.player.origin, struct.origin) < close) {
      break;
    }

    if(!struct math::is_point_in_front(level.player.origin)) {
      break;
    }

    wait 0.15;
  }

  struct = undefined;
  order = ["left", "left", "right", "right "];
  top_deck = create_deck(order, 0, 0, 0);
  mid_deck = create_deck(order, 0, 0, 0);
  exit_deck = create_deck(order, 0, 0, 0);
  count = 0;

  while(true) {
    while(function_d19707203a40263a()) {
      wait 1;
    }

    var_d573410119c1523e = 0;
    curr_deck = undefined;
    playerheight = level.player.origin[2];
    type = undefined;
    var_206ec8263c03560a = undefined;

    if(playerheight < -667) {
      var_d573410119c1523e = 1;
      curr_deck = exit_deck;
      type = "bottom";
    } else if(playerheight > -590 && playerheight < -543) {
      var_d573410119c1523e = 1;
      curr_deck = mid_deck;
      type = "mid";
    }

    if(var_d573410119c1523e) {
      side = curr_deck utility::deck_draw();
      animname_list = side == "left" ? level.var_99f44432dff3de84 : level.var_bb573827894e8229;
      var_206ec8263c03560a = animname_list utility::deck_draw();
      level thread function_fc6e6e180eb58077(type, var_206ec8263c03560a);
      wait 1.2;
      count++;

      if(count % 2 == 0) {
        wait 1.2;
      }
    }

    waitframe();
  }
}

function function_fc6e6e180eb58077(type, animname) {
  animnodes = [];
  animnodes["top"] = {
    #script_noteworthy: "loop", #angles: (0, 135, 0), #origin: (26677, 5594.52, -288)
  };
  animnodes["mid"] = {
    #script_noteworthy: "loop", #angles: (0, -45, 0), #origin: (26824.5, 5469.98, -416)
  };
  animnodes["bottom"] = {
    #script_noteworthy: "exit", #angles: (0, 135, 0), #origin: (26677.4, 5594.44, -544)
  };
  assert(isDefined(animnodes[type]));
  civ = function_908a05bd26b68cbd(animname);
  civ.script_noteworthy = type;
  civ.allowdeath = 1;
  civ endon("death");
  animnodes[type] animation::anim_first_frame_solo(civ, animnodes[type].script_noteworthy);

  switch (type) {
    case #"hash_6d308d6c437ce11c":
      animnodes["top"] animation::anim_single_solo(civ, animnodes["top"].script_noteworthy);
    case #"hash_2881ce6c1efb40c5":
      animnodes["mid"] animation::anim_single_solo(civ, animnodes["mid"].script_noteworthy);
    case #"hash_dcbcc9b3083fb78a":
      animnodes["bottom"] animation::anim_single_solo(civ, animnodes["bottom"].script_noteworthy);
      break;
    default:
      assertmsg("How did this happen?");
      break;
  }

  civ function_f4cf449875577a81();
}

function concourse_stairs_2(debug_mode) {
  if(!isDefined(debug_mode)) {
    debug_mode = 0;
  }

  if(debug_mode) {
    function_99aaac73d34d7c3c(debug_mode);
    level.player enableinvulnerability();
    startweapon = make_weapon("iw9_pi_papa220_sp", ["iw9_minireddot04_pstl"]);
    level.player give_weapon(startweapon, 0, 0, 0, 1);
    level.player switchtoweapon(startweapon);
    level.player setOrigin((26832, 5408, -152));
    level.player setplayerangles((0, 135, 0));
    wait 1;
  } else {
    trigger_wait_targetname("trigger_concourse_stairs_2");
    function_99aaac73d34d7c3c(0);
  }

  flag_set("player_at_concourse_stairs_2");
  enemies = get_living_ai_array("enemy_concourse_stairs_fourth_floor", "targetname");
  array_thread(enemies, &stop_magic_bullet_shield);
  thread function_6b61fcd1dffd95d(debug_mode);
}

function function_f4cf449875577a81() {
  self.goalradius = 100;
  utility::set_movement_speed(170 + randomint(15));
  level delaythread(7, &utility::ai_delete_when_out_of_sight, [self], 800);
  origin1 = (27649.5, 5273, -666) + namespace_47819225b08b445d::function_a03f2672d2839be1(100, 170);
  self setgoalpos(origin1);
  self waittill("goal");
  origin2 = (31681.5, 1204.5, -666) + namespace_47819225b08b445d::function_a03f2672d2839be1(100, 170);
  self setgoalpos(origin2);
}

function function_908a05bd26b68cbd(animname) {
  var_8f1b7542d7fdc179 = isDefined(self.origin) ? self.origin : (0, 0, 0);
  gender = strtok(animname, "_")[2];
  classname = gender == "male" ? "actor_jup_civilian_rus_male_flashback" : "actor_jup_civilian_rus_female_flashback";
  civ = spawn_aitype(classname, var_8f1b7542d7fdc179, (0, 0, 0), 1, 0, 0, "new_concourse_stairs_civ");
  civ function_b661b022700ba72f("script", 1);
  civ function_d5cda8a759cc36bc("flee");
  civ.doavoidanceblocking = 0;
  civ.deathfunction = &animation::function_ce450b9957138bd5;
  civ.animname = animname;
  civ thread namespace_47819225b08b445d::death_sfx();
  civ thread namespace_47819225b08b445d::injured_dmg_death_logic();
  civ thread namespace_47819225b08b445d::function_e29483c00b1210fa();
  level thread function_eb6422260d16b13c(civ);
  return civ;
}

function function_d19707203a40263a() {
  point1 = (26860, 5502, -675);
  point2 = (26905.5, 5443.5, -675);
  count = 0;
  civs = getaiarray("neutral");
  var_3cf480edcd18a5d2 = 3600;

  foreach(civ in civs) {
    if(isalive(civ)) {
      var_1f1be0ffd3590c5d = pointonsegmentnearesttopoint(point1, point2, civ.origin);
      var_75c2c902a22f36c5 = distance2dsquared(var_1f1be0ffd3590c5d, civ.origin);
      atexit = var_75c2c902a22f36c5 < var_3cf480edcd18a5d2;
      var_2d3f3020d503fb64 = civ.velocity == (0, 0, 0);

      if(atexit && var_2d3f3020d503fb64) {
        count++;

        if(count >= 2) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_eb6422260d16b13c(civ_add) {
  level endon("fourth_floor_hostage_scene_done");

  if(flag("stairs_murder")) {
    return;
  }

  if(isDefined(level.var_726cd56d13d38a67)) {
    level.var_726cd56d13d38a67[level.var_726cd56d13d38a67.size] = civ_add;
    return;
  }

  level.var_726cd56d13d38a67 = [];
  level.var_726cd56d13d38a67[level.var_726cd56d13d38a67.size] = civ_add;

  while(true) {
    waitframe();

    if(level.var_726cd56d13d38a67.size == 0) {
      continue;
    }

    if(flag("stairs_murder")) {
      continue;
    }

    level.var_726cd56d13d38a67 = array_removedead(level.var_726cd56d13d38a67);
    player_pushed = 0;

    foreach(civ in level.var_726cd56d13d38a67) {
      if(distancesquared(civ.origin, level.player.origin) > 64 * 64) {
        continue;
      }

      if(abs(civ.origin[2] - level.player.origin[2]) > 40) {
        continue;
      }

      player_origin = flat_origin(level.player.origin);
      civ_origin = flat_origin(civ.origin);
      player_pushed = 0;
      dir = vectorNormalize(player_origin - civ_origin);
      dist = distance2d(civ.origin, level.player.origin);
      power = math::lerp(15, 0, dist / 64);
      player_pushed = 1;
      level.player pushplayervector(dir * power);
      civ thread function_41218104564ae8a7();
      break;
    }

    if(!player_pushed) {
      level.player pushplayervector((0, 0, 0));
    }
  }
}

function function_41218104564ae8a7() {
  if(isalive(self) && isDefined(self.toggle_solid)) {
    return;
  }

  self endon("death");
  self.toggle_solid = 1;
  self visiblenotsolid();

  while(distancesquared(level.player.origin, self.origin) < 4900) {
    waitframe();
  }

  self visiblesolid();
  self.toggle_solid = undefined;
}

function function_99aaac73d34d7c3c(debug_mode) {
  level.var_4e39b800c0cb3a26 = spawn_tag_origin((26596, 5622, -32), (0, -45, 0));
  level.var_b24651c26f3bc640 = {
    #angles: (0, 0, 0), #origin: (26657.5, 5637.36, -31.842)
  };
  left_door = getEnt("concourse_stairs_top_door", "targetname");
  left_door assign_animtree("fourth_floor_door");
  level.var_b24651c26f3bc640 anim_first_frame_solo(left_door, "fourth_floor_door_close");
  enemies = [];

  for(i = 0; i < 2; i++) {
    enemy = spawn_aitype("actor_jup_enemy_police_ar", (0, 0, 0), (0, 0, 0), 1);
    enemy.targetname = "enemy_concourse_stairs_fourth_floor";
    enemy.animname = "enemy0" + i + 1;
    enemy.script_noteworthy = enemy.animname;
    enemy.og_health = enemy.health;
    enemy magic_bullet_shield();

    switch (enemy.animname) {
      case #"hash_b1814a65888b98f0":
        level.var_8f588ea2d8b101c6 = enemy;
        level.var_b24651c26f3bc640 anim_first_frame_solo(enemy, "fourth_floor_civ_kick");
        enemy thread utility::flag_on_death("civ_kicker_dead");
        break;
      case #"hash_b1814d65888b9da9":
        level.var_4a920f39618d8ba5 = enemy;
        enemy function_1a479cad9c3adbb1(0);
        enemy utility::gun_remove();
        enemy utility::place_weapon_on(enemy.sidearm, "inhand");
        level.var_4e39b800c0cb3a26 anim_first_frame_solo(enemy, "fourth_floor_hostage_intro");
        enemy.health = 1;
        break;
    }

    enemies[enemies.size] = enemy;
  }

  civs = [];

  for(i = 0; i < 2; i++) {
    is_male = 1;
    animname = "civ0" + i + 1;

    if(animname == "civ02") {
      is_male = 0;
    } else if(animname == "civ01") {
      is_male = 1;
    }

    civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, is_male, undefined, undefined, undefined, 1);
    civ.targetname = "civ_concourse_stairs_fourth_floor";
    civ.animname = animname;
    civ.script_noteworthy = animname;

    switch (civ.animname) {
      case #"hash_743e46a7aaadba8a":
        level.var_74ecea13881f0759 = civ;
        civ notify("stop_injured_dmg_death_logic");
        level.var_b24651c26f3bc640 anim_first_frame_solo(civ, "fourth_floor_civ_kick");
        break;
      case #"hash_743e45a7aaadb8f7":
        level.constairs_hostage = civ;
        civ setModel("c_jup_body_civ_london_female_4_1");
        level.var_4e39b800c0cb3a26 anim_first_frame_solo(civ, "fourth_floor_hostage_intro");
        waitframe();
        civ linkTo(level.var_4e39b800c0cb3a26, "tag_origin");
        break;
    }

    civs[civs.size] = civ;
  }

  level.var_88ddddbcc9770154 = array_merge(enemies, civs);
}

function function_6b61fcd1dffd95d(debug_mode) {
  flag_init("fourth_floor_hostage_scene_done");
  flag_init("fourth_floor_civ_kick_done");
  doorright = scripts\sp\door::get_interactive_door("door_concourse_stair_right");
  doorright.no_bash = 1;

  if(debug_mode) {
    thread set_flag_on_targetname_trigger("trigger_concourse_stairs_2");
    delaythread(1, &activate_trigger_with_targetname, "trigger_concourse_stairs_2");
  }

  thread function_25127dbe02497e41();
  thread function_45172af6a40c13dd();
  thread function_97b5d857591882eb();
  thread function_51064903be8b320c(debug_mode);
  enemies = get_living_ai_array("enemy_concourse_stairs_fourth_floor", "targetname");
  thread namespace_47819225b08b445d::function_5da13e5444950c67(enemies, "concourse_stairs_2_enemies_dead");
  flag_wait_all("fourth_floor_hostage_scene_done", "fourth_floor_civ_kick_done");

  if(!debug_mode) {
    namespace_997789c5b521a997::function_88342a549599c562();
  }
}

function function_25127dbe02497e41() {
  flag_init("concourse_stairs_fourth_floor_vo_done");
  flag_wait("trigger_concourse_stairs_2");
  flag_wait("concourse_stairs_2_enemies_dead");
  level.player say("dx_sp_flas_stcs_soap_xraysdown");
  flag_set("concourse_stairs_fourth_floor_vo_done");
}

function function_45172af6a40c13dd() {
  left_door = getEnt("concourse_stairs_top_door", "targetname");
  level.var_b24651c26f3bc640 anim_single_solo(left_door, "fourth_floor_door_close");
}

function function_97b5d857591882eb() {
  enemy = get_living_ai("enemy01", "script_noteworthy");
  enemy.allowdeath = 1;
  civ = get_living_ai("civ01", "script_noteworthy");
  var_c59a1bf410f24b79 = [enemy, civ];
  civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
  enemy thread function_2332db06c06dab5c();
  level.var_b24651c26f3bc640 anim_single(var_c59a1bf410f24b79, "fourth_floor_civ_kick");

  if(!is_dead_or_dying(enemy)) {
    enemy.health = enemy.og_health;
  }

  flag_set("fourth_floor_civ_kick_done");
}

function function_2332db06c06dab5c() {
  level endon("fourth_floor_civ_kick_done");
  flag_wait("hostage_flashed");
  self stopanimScripted();
  delaythread(0.05, &scripts\anim\combat_utility::flashbangstart, 1);
}

function function_93c43fe9b33e79c8(enemy) {
  level endon("stop_hostage_logic");
  self endon("death");

  while(true) {
    new_angles = vectortoangles(level.player.origin - self.origin);
    new_orientation = (self.angles[0], new_angles[1], self.angles[2]);

    if(isai(self)) {
      self forceteleport(self.origin, new_orientation);
    } else {
      self.angles = new_orientation;
    }

    waitframe();
  }
}

function function_ce9fdd7fe834de65() {
  civ = get_living_ai("civ02", "script_noteworthy");
  namespace_47819225b08b445d::function_6d41ec7b09cd23b6(civ);
  namespace_47819225b08b445d::function_6d41ec7b09cd23b6(level.var_4e39b800c0cb3a26);
}

function function_b20f714490fa6163() {
  level endon("stop_hostage_logic");
  hostage = level.constairs_hostage;
  enemy = get_living_ai("enemy02", "script_noteworthy");

  if(is_dead_or_dying(enemy) || is_dead_or_dying(hostage)) {
    return;
  }

  hostage say("dx_sp_flas_stcs_bfc1_panickedscream");
  hostage say_delayed(0.2, "dx_sp_flas_stcs_rfc2_pleaseno");
  hostage say_delayed(0.2, "dx_sp_flas_stcs_rfc2_whyareyoudoingthiswh");
  enemy say_delayed(0.2, "dx_sp_flas_stcs_kon3_shutthefuckup");
  hostage say_delayed(0.2, "dx_sp_flas_stcs_rfc2_ihavechildrenpleasei");
  enemy say_delayed(0.2, "dx_sp_flas_stcs_kon4_theyllbesoldiersofth");
  hostage say_delayed(0.2, "dx_sp_flas_stcs_rfc2_letmejustgohomeiwant");
}

function function_51064903be8b320c(debug_mode) {
  flag_init("hostage_enemy_dead");
  flag_init("hostage_civ_dead");
  flag_init("hostage_player_too_close");
  flag_init("hostage_flashed");
  thread function_b20f714490fa6163();
  enemy = get_living_ai("enemy02", "script_noteworthy");
  enemy ai::magic_bullet_shield();
  civ = get_living_ai("civ02", "script_noteworthy");
  civ.var_2dd755c521498bb5 = 1;
  civ.var_9fc4633f94fe22ee = 1;
  var_c59a1bf410f24b79 = [enemy, civ];
  var_f542bf968436bfb1 = level.var_4e39b800c0cb3a26.angles;
  level.var_4e39b800c0cb3a26 anim_single(var_c59a1bf410f24b79, "fourth_floor_hostage_intro");
  civ linkTo(level.var_4e39b800c0cb3a26, "tag_origin");
  level.var_4e39b800c0cb3a26 thread anim_loop_solo(civ, "constairs_hostage_aim_idle", "stop_hostage_loop");
  level.var_4e39b800c0cb3a26 thread function_93c43fe9b33e79c8(enemy);
  enemy getenemyinfo(level.player);
  enemy.favoriteenemy = level.player;
  aimlimits["left"] = 60;
  aimlimits["right"] = -20;
  aimlimits["up"] = -30;
  aimlimits["down"] = 30;
  waitframe();
  enemy thread anim_aim("constairs_hostage_aim", level.var_4e39b800c0cb3a26, aimlimits);
  og_enemyangles = enemy.angles;
  enemy thread function_93c43fe9b33e79c8();
  thread function_81581e3b30bde63a(enemy, civ);
  result = level waittill_any_return("hostage_enemy_dead", "hostage_civ_dead", "hostage_player_too_close", "hostage_flashed");
  level notify("stop_hostage_logic");
  level.var_4e39b800c0cb3a26 notify("stop_hostage_loop");
  level.var_4e39b800c0cb3a26.angles = var_f542bf968436bfb1;
  enemy forceteleport(enemy.origin, og_enemyangles);
  enemy stop_magic_bullet_shield();
  enemy utility::place_weapon_on(enemy.sidearm, "right");
  waitframe();
  enemy.forcesidearm = 1;

  switch (result) {
    case #"hash_3bb00a9df13e33d2":
      thread function_e83441a5aeff5770();
      enemy notify("stop_anim_aim");
      waitframe();
      enemy thread scripts\anim\combat_utility::flashbangstart(1);
      enemy.health = enemy.og_health;
      enemy.allowdeath = 1;
      enemy function_1a479cad9c3adbb1(1);
      array_call(var_c59a1bf410f24b79, &unlink);
      level.var_4e39b800c0cb3a26 anim_single_solo(civ, "fourth_floor_hostage_save");
      level.var_4e39b800c0cb3a26 thread anim_loop_solo(civ, "fourth_floor_hostage_save_idle");
      break;
    case #"hash_43cbf1b7137cc30":
      thread function_e83441a5aeff5770();
      shared::dropallaiweapons();
      enemy thread namespace_47819225b08b445d::function_e0a9de6b0601ed23();
      level.var_4e39b800c0cb3a26 anim_single(var_c59a1bf410f24b79, "fourth_floor_hostage_save");
      level.var_4e39b800c0cb3a26 thread anim_loop_solo(civ, "fourth_floor_hostage_save_idle");
      break;
    case #"hash_208ce139e356a4de":
    case #"hash_80e059198dd365f4":
    default:
      thread function_b0fdad63ec7909bc();
      enemy.health = enemy.og_health;
      enemy.allowdeath = 1;
      enemy function_1a479cad9c3adbb1(1);
      array_call(var_c59a1bf410f24b79, &unlink);
      civ thread namespace_47819225b08b445d::function_e0a9de6b0601ed23(undefined, undefined, undefined, undefined, 0);
      level.var_4e39b800c0cb3a26 anim_single(var_c59a1bf410f24b79, "constairs_hostage_execute");
      break;
  }

  flag_set("fourth_floor_hostage_scene_done");
  level.player pushplayervector((0, 0, 0));
}

function function_e83441a5aeff5770() {
  level endon("player_at_vip_floor");
  level.constairs_hostage endon("level.constairs_hostage");
  level.constairs_hostage stop_dialogue();
}

function function_b0fdad63ec7909bc() {
  level endon("player_at_vip_floor");
  level.player say_delayed(0.2, "dx_sp_flas_stcn_soap_no");
  flag_wait("concourse_stairs_fourth_floor_vo_done");
  level.player say_delayed(0.5, "dx_sp_flas_stcs_soap_clear");
  level.player say_delayed(0.5, "dx_sp_flas_stcs_soap_fuck");
}

function anim_aim(animprefix, animnode, aimlimits) {
  self.og_leftaimlimit = self.leftaimlimit;
  self.og_rightaimlimit = self.rightaimlimit;
  self.og_upaimlimit = self.upaimlimit;
  self.og_downaimlimit = self.downaimlimit;

  if(isDefined(aimlimits)) {
    self.leftaimlimit = aimlimits["left"];
    self.rightaimlimit = aimlimits["right"];
    self.upaimlimit = aimlimits["up"];
    self.downaimlimit = aimlimits["down"];
  } else {
    self.leftaimlimit = 45;
    self.rightaimlimit = -45;
    self.upaimlimit = -15;
    self.downaimlimit = 15;
  }

  self.aim_animprefix = animprefix;
  self.aim_animnode = animnode;
  scripts\asm\asm_sp::asm_animcustom(&anim_aim_internal, &anim_aim_end);
}

function anim_aim_internal() {
  self endon("death");
  self endon("stop_anim_aim");
  level endon("stop_hostage_logic");
  animnode = undefined;

  if(isDefined(self.aim_animnode)) {
    animnode = self.aim_animnode;
  }

  animprefix = self.aim_animprefix;

  thread aim_dvars();

  childthread anim_aim_shoot(animprefix);
  enemy = self.enemy;

  if(isDefined(self.favoriteenemy)) {
    enemy = self.favoriteenemy;
  }

  self bb_newshootparams(undefined, enemy, 1);
  scripts\asm\asm_bb::bb_claimshootparams(0);
  namespace_47819225b08b445d::function_e59f66b2ecf3471f();
  self._blackboard.shootparams_burstcount = randomintrange(1, 3);
  self._blackboard.shootparams_shotsperburst = 1;
  self.asm.track.aim_2 = getanim(animprefix + "_2_knob");
  self.asm.track.aim_4 = getanim(animprefix + "_4_knob");
  self.asm.track.aim_6 = getanim(animprefix + "_6_knob");
  self.asm.track.aim_8 = getanim(animprefix + "_8_knob");
  self setanimknoblimited(getanim(animprefix + "_2"), 1, 0.2);
  self.var_15b9736ae2dde804 = 1;
  var_2ea1c6c1d48fcd45 = getanim(animprefix + "_5");
  self animmode("noclip");
  self notify("activate_track_loop");

  while(true) {
    self setflaggedanimrestart("aim_loop", var_2ea1c6c1d48fcd45, 1);
    self waittillmatch("aim_loop", "end");
  }
}

function aim_dvars() {
  var_b74ec67fbc80c209 = @ "hash_49124f9b92c121db";
  var_f773a0473a6004ec = @ "hash_64c78aa6d5ad457c";
  var_b033f6afcb96489d = @ "hash_63bc06f4280fbd1b";
  var_5d51b82d47778c24 = @ "hash_d53e3792980e02dc";
  setdvarifuninitialized(var_b74ec67fbc80c209, -1000);
  setdvarifuninitialized(var_f773a0473a6004ec, -1000);
  setdvarifuninitialized(var_b033f6afcb96489d, -1000);
  setdvarifuninitialized(var_5d51b82d47778c24, -1000);
  self endon("<dev string:x24>");

  while(true) {
    left = getdvarfloat(var_b74ec67fbc80c209, -1000);
    right = getdvarfloat(var_f773a0473a6004ec, -1000);
    up = getdvarfloat(var_b033f6afcb96489d, -1000);
    down = getdvarfloat(var_5d51b82d47778c24, -1000);

    if(left != -1000 && self.leftaimlimit != left) {
      self.leftaimlimit = left;
    }

    if(right != -1000 && self.rightaimlimit != right) {
      self.rightaimlimit = right;
    }

    if(up != -1000 && self.upaimlimit != up) {
      self.upaimlimit = up;
    }

    if(down != -1000 && self.downaimlimit != down) {
      self.downaimlimit = down;
    }

    waitframe();
  }
}

function anim_aim_end() {
  self.var_15b9736ae2dde804 = 0;
  self.leftaimlimit = self.og_leftaimlimit;
  self.rightaimlimit = self.og_rightaimlimit;
  self.upaimlimit = self.og_upaimlimit;
  self.downaimlimit = self.og_downaimlimit;
  self.og_leftaimlimit = undefined;
  self.og_rightaimlimit = undefined;
  self.og_upaimlimit = undefined;
  self.og_downaimlimit = undefined;
}

function function_b618de8b15b3d2ca(player) {
  var_e9bad04d7e65931d = 30;
  var_b9d90b231b4b3c3 = anglesToForward(self gettagangles("tag_eye"));
  start = self gettagorigin("tag_eye") + var_b9d90b231b4b3c3 * var_e9bad04d7e65931d;
  return sighttracepassed(start, level.player getEye(), 1, self, level.player);
}

function anim_aim_shoot(animprefix) {
  waittillframeend();
  var_d5f2b98eea80af8a = isDefined(level.scr_anim["enemy02"]["constairs_hostage_aim_fire"]);
  var_d5f2b98eea80af8a = 0;
  fireanim = undefined;

  if(var_d5f2b98eea80af8a) {
    fireanim = level.scr_anim["enemy02"]["constairs_hostage_aim_fire"];
    self setanimknoblimitedrestart(fireanim, 1, 0.2);
  }

  numshots = 0;
  var_ee23e4ff75ba574a = 0;
  var_5a5e35aab381ee9d = 0.2;
  mercy = 1;

  while(true) {
    waitframe();

    if(!isDefined(self.enemy)) {
      continue;
    }

    if(function_b618de8b15b3d2ca(self.enemy) && !istrue(self.scriptedflashed)) {
      self.downaimlimit = 90;
      self bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);

      if(function_f4ff7e4967060e35()) {
        if(var_d5f2b98eea80af8a) {
          self setanim(fireanim, 1, var_5a5e35aab381ee9d);
        }

        if(!isDefined(level.var_eaddaec00778ad2)) {
          level.var_eaddaec00778ad2 = gettime();
        }

        if(function_4b28d924e75317da()) {
          self shoot();
        } else {
          self shoot(1, level.player getEye() + (0, 0, 25));
        }

        self.bulletsinclip--;
        numshots++;
        wait var_5a5e35aab381ee9d + randomfloat(0.1);

        if(var_d5f2b98eea80af8a) {
          self clearanim(fireanim, 0.1);
          wait 0.1;
        }

        if(numshots % 3 == 0) {
          wait 0.4 + randomfloat(0.4);
        }

        if(mercy && level.gameskill < 2 && level.player player::function_693be821d14ede2f()) {
          mercy = 0;
          wait 2;
        }
      }

      if(self.bulletsinclip == 0) {
        self.bulletsinclip = weaponclipsize(self.weapon);
      }
    }
  }
}

function function_f4ff7e4967060e35() {
  if(scripts\aitypes\combat::isaimedataimtarget()) {
    return true;
  }

  if(sighttracepassed(self gettagorigin("tag_eye"), level.player getEye(), 0, self, level.player)) {
    return true;
  }

  return false;
}

function function_4b28d924e75317da() {
  if(flag("fourth_floor_civ_kick_done")) {
    return true;
  }

  if(flag("civ_kicker_dead")) {
    return true;
  }

  if(utility::time_has_passed(level.var_eaddaec00778ad2, 5)) {
    return true;
  }

  return false;
}

function function_81581e3b30bde63a(enemy, civ) {
  level endon("stop_hostage_logic");
  enemy childthread function_37ef10dc066b6f29("hostage_enemy_dead");
  childthread function_59b12c7b414d4d12(level.player, enemy);
  childthread function_af5278d2e267676c("hostage_flashed", enemy, civ);
}

function function_af5278d2e267676c(var_5285599f4b507cad, enemy, civ) {
  enemy waittill("damage", dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);

  if(is_equal(weapobj.basename, "flash")) {
    flag_set(var_5285599f4b507cad);
  }
}

function function_59b12c7b414d4d12(player, enemy) {
  while(distancesquared(player.origin, enemy.origin) > 32400) {
    waitframe();
  }

  flag_set("hostage_player_too_close");
}

function function_37ef10dc066b6f29(var_fdbc9909431cf348) {
  assert(isstring(var_fdbc9909431cf348));
  waittill_any("death", "damage");
  flag_set(var_fdbc9909431cf348);
}

function function_f7a4ecd3e810b3f() {
  level endon("concourse_hostage_dead");
  level endon("concourse_hostage_hit");
  childthread function_19115262247348a7();
  waittill_any("damage", "bullethit");
  flag_set("concourse_stair_hostage_killer_hit");
}

function function_e3d9300317ae065c() {
  level endon("concourse_stair_hostage_dead");
  waittill_any("damage", "bullethit");
  flag_set("concourse_hostage_hit");
}

function function_8ca6270f0771d0c9() {
  self endon("death");
  struct = getStruct("struct_civ_concourse_path_0", "targetname");
  set_goal_radius(5);
  thread scripts\sp\spawner::go_to_node(struct);
  self waittill("reached_path_end");
  self delete();
}

function function_179e425029ea73a() {
  civspawners = getspawnerarray("civ_concourse_stairs_first_floor");
  array_spawn_function(civspawners, &function_2f4525039bec1a0e);
  civspawners = getspawnerarray("civ_concourse_stairs_second_floor");
  array_spawn_function(civspawners, &function_2f4525039bec1a0e);
  civspawners = getspawnerarray("civ_concourse_stairs_third_floor");
  array_spawn_function(civspawners, &function_2f4525039bec1a0e);
  civspawners = getspawnerarray("civ_concourse_stairs_fourth_floor");
  array_spawn_function(civspawners, &function_2f4525039bec1a0e);
  enemyspawners = getspawnerarray("enemy_concourse_stairs_fourth_floor");
}

function function_bf3d51fb5493051a(struct) {
  self clearpath();
  set_goal_radius(50);
  self endon("death");
  delaycall(0.1, &function_d5cda8a759cc36bc, "panicked");
  delaythread(3, &set_movement_speed, 180);

  while(true) {
    self setgoalpos(struct.origin);
    self waittill("goal");

    if(!isDefined(struct.target)) {
      break;
    }

    struct = getStruct(struct.target, "targetname");
  }

  self delete();
}

function function_1638a4522a2406cd(structs, wavecount, var_37207e8bb0ea1205, var_3b897a1024b09a9, var_fd6b2033195025ef) {
  self notify("stop_old_loops");
  wavecount = default_to(wavecount, 0);
  var_37207e8bb0ea1205 = default_to(var_37207e8bb0ea1205, 0.1);
  var_3b897a1024b09a9 = default_to(var_3b897a1024b09a9, 0);
  var_fd6b2033195025ef = default_to(var_fd6b2033195025ef, 0);
  self endon("stop_old_loops");

  for(i = 0; i < wavecount; i++) {
    foreach(j, struct in structs) {
      j++;

      if(j < var_fd6b2033195025ef) {
        continue;
      }

      thread function_a89224372a5cd28c(struct, self);
      wait var_37207e8bb0ea1205;
    }

    wait var_3b897a1024b09a9;
  }
}

function function_f6f145c68454541a(spawnername) {
  enemies = [];
  var_f82eedd99e9fdd1d = getspawnerarray(spawnername);
  var_f82eedd99e9fdd1d = array_sort_by_script_index(var_f82eedd99e9fdd1d);

  for(i = 0; i < var_f82eedd99e9fdd1d.size; i++) {
    enemies[enemies.size] = var_f82eedd99e9fdd1d[i] spawn_ai(1);
    wait 0.75;
  }

  return enemies;
}

function function_a89224372a5cd28c(struct, var_fee9ce0d96dd084b) {
  var_fee9ce0d96dd084b.count = 1;
  civ = var_fee9ce0d96dd084b spawn_ai();

  if(isDefined(civ)) {
    civ forceteleport(struct.origin, struct.angles);
    civ thread function_bf3d51fb5493051a(struct);
  }

  wait 0.1;
}

function function_564579a7b113a217() {
  doorright = scripts\sp\door::get_interactive_door("door_concourse_stair_right");
  doorright scripts\sp\door::lock_door();
  level endon("concourse_stairs_top_anim_start");
  doorright childthread function_87272da15814d456("player_at_concourse_stair_top_doors");
  doorright childthread function_32c060fcace6680("player_at_concourse_stair_top_doors");
}

function function_87272da15814d456(var_799bebae5bb7d70e) {
  self waittill("trigger");
  flag_set(var_799bebae5bb7d70e);
}

function function_32c060fcace6680(var_799bebae5bb7d70e) {
  self waittill("attempt_bash");
  flag_set(var_799bebae5bb7d70e);
}

function function_2a04dc8e64efa265() {
  thread namespace_47819225b08b445d::function_9246165d7c3054cc(60);
}

function function_9d3a4a4d96ade79b() {
  thread namespace_47819225b08b445d::function_9246165d7c3054cc(65);
}

function function_ba6214134567c27a(triggertargetname, waitflag, endonflag) {
  level endon(endonflag);
  flag_wait(waitflag);
  trigger = getEnt(triggertargetname, "targetname");

  if(isDefined(trigger)) {
    trigger triggerdisable();
  }
}

function allies_ignore(value) {
  value = default_to(value, 0);

  foreach(guy in level.allies) {
    guy set_ignoreall(value);
    guy set_ignoreme(value);
  }
}

function function_35cee4ca9585a994(flagname) {
  thread function_f8e0a530f1cf7513(flagname);
  self waittill("damage");
  flag_set(flagname);
}

function function_f8e0a530f1cf7513(flagname) {
  self waittill("death");
  flag_set(flagname);
}

function bump_player() {
  if(istrue(self.var_619c00fc6f1b4cc)) {
    return;
  }

  self.var_619c00fc6f1b4cc = 1;
  self endon("death");
  self pushplayer(0);

  while(true) {
    distsqrd = distancesquared(self.origin, level.player.origin);

    if(distsqrd > 360000) {
      wait 2;
      continue;
    } else if(distsqrd > 62500) {
      wait 1.5;
      continue;
    } else if(level.player ent_flag("script_pushed") || distsqrd > 10000) {
      wait 1;
      continue;
    } else if(distsqrd > 2500) {
      waitframe();
      continue;
    } else if(function_eabff426922f6e6e()) {
      level thread function_8730aa0a05d62e54(self);
      return;
    }

    waitframe();
  }
}

function civ_headlook() {
  self endon("death");
  self endon("disable_headlook");

  while(true) {
    nearby = getaiarrayinradius(self.origin, 450, "axis", "allies");

    if(distancesquared(self.origin, level.player.origin) < 202500) {
      nearby[nearby.size] = level.player;
    }

    lookat = undefined;

    if(istrue(nearby.size)) {
      if(nearby.size > 1) {
        nearby = sortbydistance(nearby, self.origin);
        lookat = randomint(100) < 50 ? nearby[0] : nearby[1];
      } else {
        lookat = nearby[0];
      }
    }

    if(isalive(lookat)) {
      self.lookatent = lookat;
      self setlookatentity(lookat, 1);
    } else if(isDefined(self.lookatent)) {
      self setlookatentity();
      self.lookatent = undefined;
    }

    wait 1.25;
  }
}

function function_eabff426922f6e6e() {
  if(level.player ent_flag("script_pushed")) {
    return false;
  }

  if(int(length(self.velocity)) < 30) {
    return false;
  }

  if(!math::within_fov_2d(level.player.origin, level.player.angles, self.origin, 0.766044)) {
    return false;
  }

  return true;
}

function function_8730aa0a05d62e54(civ) {
  if(level.player ent_flag("script_pushed")) {
    return;
  }

  level.player ent_flag_set("script_pushed");
  alias = level.player issprinting() == 1 ? "civ_player_collide_sprint" : "civ_player_collide";

  if(soundexists(alias)) {
    thread play_sound_in_space(alias, level.player.origin);
  }

  level.player screenshakeonentity(4, 0, 0, 0.6);
  level.player playRumbleOnEntity("damage_heavy");
  player_origin = flat_origin(level.player.origin);
  civ_origin = flat_origin(civ.origin);
  player_pushed = 0;
  dir = vectorNormalize(player_origin - civ_origin);
  dist = distance2d(civ.origin, level.player.origin);
  power = math::lerp(15, 0, dist / 64);
  player_pushed = 1;
  level.player pushplayervector(dir * power);
  wait 1.5;
  level.player pushplayervector((0, 0, 0));
  wait 3;
  level.player ent_flag_clear("script_pushed");
}

function function_a4d5dee1f16e5ad7(value) {
  value = default_to(value, 2);

  foreach(guy in level.allies) {
    guy.grenadeammo = value;
  }
}

function function_af71e5d06fda8b30(value) {
  level.price set_ignoresuppression(value);
}

function function_46d675dc092c3771(enemies, setflag, endonflag) {
  level endon(endonflag);

  if(!isDefined(enemies)) {
    return;
  }

  while(enemies.size > 0) {
    enemies = function_fdc9d5557c53078e(enemies);
    wait 1;
  }

  flag_set(setflag);
}

function function_6d0221db4fd3a1a8() {
  level endon("concourse_police_hostile");
  enemy = get_living_ai("police_concourse_speaker", "script_noteworthy");
  level.price say_team("Gents', what's the situtation.");
  enemy say_global("Ah, American- Follow these people and get to safety.");
  level.price say_team("British. We're here to secure the VIP's where are they?");
  enemy say_global("Safe with the boss.");
  level.price say_team("The boss...");
}

function function_106536541db3d687() {
  while(true) {
    enemies = [];
    enemies = getaiarray("axis");
    wait 1;
  }
}

function function_8d4d7c777184e8b1() {
  trigger_wait_targetname("trigger_concourse_a");
  iprintln("a");
  trigger_wait_targetname("trigger_concourse_b");
  iprintln("b");
  trigger_wait_targetname("trigger_concourse_c");
  iprintln("c");
  trigger_wait_targetname("trigger_concourse_d");
  iprintln("d");
  trigger_wait_targetname("trigger_concourse_e");
  iprintln("e");
}

function function_48ac97e10ef2c9af(var_ec5021bbd54f4d97, waitflag) {}

function function_ab007d9e68a6d16b(waitflag) {
  flag_wait(waitflag);

  while(true) {
    dist = distancesquared(level.player.origin, self.origin);

    if(dist > 2400) {
      break;
    }

    wait 1;
  }

  while(true) {
    if(!namespace_47819225b08b445d::function_e7c30095a6cdc3ef(self getEye())) {
      break;
    }

    wait 0.5;
  }

  self delete();
}

function function_ecf7a9662560a458() {
  level.player teleport_player({
    #angles: (0, 135, 0), #origin: (30992, 3172, -664)
  });
}

function function_4e660927b19f12a6() {
  setDvar(@ "hash_16956aedc3a8b7a6", 1);
  thread function_13635c1df73f29c3();
  namespace_5e9fb42dea43f1f0::function_57dc6f590951cdc0();
  level.enemies = [];
  level.player thread namespace_5e9fb42dea43f1f0::function_9886db945af3b751();
  thread infinite_spawn(0);
  thread infinite_spawn(1);
  level waittill("forever");
}

function infinite_spawn(is_civ) {
  while(true) {
    if(is_civ) {
      ai = namespace_47819225b08b445d::spawn_civ((30800, 3268, -664), (0, 315, 0), undefined, 0, 0, 0, 1);
      ai.var_137740b3477936a3 = 0;
      level.var_ab31e06e378b397[level.var_ab31e06e378b397.size] = ai;
    } else {
      ai = spawn_aitype("actor_jup_enemy_police_ar", (30900, 3268, -664), (0, 315, 0), 1);
      level.enemies[level.enemies.size] = ai;
    }

    ai.ignoreall = 1;
    ai.dontevershoot = 1;
    ai setgoalpos(ai.origin, 32);
    ai waittill("death");
    level.enemies = array_removedead_or_dying(level.enemies);
    wait 1;
  }
}

function function_6b4d0d9d3243e5e5() {
  if(isDefined(level.var_bf97ba528a738d87) && isent(level.var_bf97ba528a738d87)) {
    level.var_bf97ba528a738d87 delete();
  }

  if(isDefined(level.var_bf97bb528a738fba) && isent(level.var_bf97bb528a738fba)) {
    level.var_bf97ba528a738d87 delete();
  }
}

function function_7aa9bee22a31baa6() {
  crowd_pos = (27805, 1359, -400);
  play_sound_in_space("civ_walla_distant_crowd_panic", crowd_pos);
}

#using_animtree("generic_human");

function function_183990d9d6c9e5d3() {
  self setanim(%sdr_com_pi_golf17_weapon_offset, 1);
}