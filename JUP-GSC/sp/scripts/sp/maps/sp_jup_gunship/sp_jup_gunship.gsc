/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_gunship\sp_jup_gunship.gsc
*************************************************************/



#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_4919201dc1ccf0af;
#using script_53f4e6352b0b2425;
#using script_5fca5166921c5d65;
#using script_60145ee124b1cbd1;
#using script_6bf6c8e2e1fdccaa;
#using script_7b8f1f3b1f8d3554;
#using script_a7e2df121c70d22;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\audio;
#using scripts\sp\debug;
#using scripts\sp\hud_util;
#using scripts\sp\load;
#using scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_fx;
#using scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_lighting;
#using scripts\sp\player;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#using scripts\vehicle\vehicle_common;
#namespace sp_jup_gunship;

function main() {
  audio::set_audio_level_fade_time(0);
  namespace_f57cdcbb3bf176bf::main();
  sp_jup_gunship_fx::main();
  namespace_829b29c5553db8bb::main();
  sp_jup_gunship_lighting::main();
  namespace_6393a86f2fcda776::precache();
  function_1331a5b66e736a84();
  load::main();
  namespace_6393a86f2fcda776::function_67d9968de909c242();
  thread function_232df4d82c72daf1();

  setdvarifuninitialized(@ "hash_658daf70d61a2a34", "<dev string:x1c>");

  if(getdvarint(@ "hash_658daf70d61a2a34") == 1) {
    thread debug::print_timer();
  }
}

function function_1331a5b66e736a84() {
  utility::set_default_start("mission_start");
  utility::add_start("mission_start", &function_49a22cfc6e162661, &function_767aef496a3ec942, undefined, &function_227a0bed4f6b8913);
  utility::add_start("locate_teams", &function_fe8bba6cc02041a1, &function_5a7719e5d6215f82, undefined, &function_7d0cdf9cad6b4053);
  utility::add_start("radio_tower", &function_32e31df8ada16d42, &function_58f2b3284794bcd3, undefined, &function_79eabb701106fec8);
  utility::add_start("push_1", &function_2eb04bc1a1ed5570, &function_2befc67ff1467929, undefined, &function_d8852f347c68bca6);
  utility::add_start("push_2", &function_589f3cbe544df6a1, &function_1db6a285e59d682, undefined, &function_4c814142720b3d53);
  utility::add_start("hangar", &function_55798db8d4ab92d4, &function_cf5ed05c525a5385, undefined, &function_49a1951324d6bd1a);
  utility::add_start("vehicles_a", &function_4868dfa9a5d5ea06, &function_dd509c2a4f4d7f4f, undefined, &function_aecf12ea5f4057fc);
  utility::add_start("vehicles_b", &function_74ceee896d6a0e13, &function_26c8449412809784, undefined, &function_53e174eafac9d865);
  utility::add_start("heli_boss", &function_439b3c3f9f86bda6, &function_ff6d0826f03fca6f, undefined, &function_3bbc2c6c7f9c419c);
  utility::add_start("outro", &function_ca7d885d7ba14570, &function_eac54160d832c929, undefined, &function_c11d92f684da2ca6);

  utility::add_start("<dev string:x1e>", &function_700130a517ceae37);
  utility::add_start("<dev string:x26>", &function_76e4b531d9548ef);
  utility::add_start("<dev string:x32>", &function_7c03766c30329d11);
}

function function_232df4d82c72daf1() {
  switch (level.start_point) {
    case #"hash_60ca87b3b05310aa":
    case #"hash_909a661762547e3e":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("eyes_on", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_LOCATE_TEAM");
      utility::flag_wait("teams_located");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("eyes_on");
    case #"hash_3b30b6edbef02255":
    case #"hash_88c7b7ddf8ba43d6":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("boneyard", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_BONEYARD");
      utility::flag_wait_any("sam_site_start", "sam_site_dead");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("boneyard");

      if(!utility::flag("sam_site_dead")) {
        namespace_6393a86f2fcda776::function_621018eac1ae9012("sam_site", "current", level.sam_site, &"SP_JUP_GUNSHIP/OBJ_SAM_SITE", 1000);
        utility::flag_wait("sam_site_dead");
        namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("sam_site");
      }

      namespace_6393a86f2fcda776::function_621018eac1ae9012("push_1", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_BONEYARD");
      utility::flag_wait("push_1_over");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("push_1");
    case #"hash_3b30b3edbef01d9c":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("push_2", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_BONEYARD");
      utility::flag_wait("jet_a_start");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("push_2");
    case #"hash_3d9ccd28b21cb88e":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("jet_a_start", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_CLEAR_RUNWAYS");
      utility::flag_wait("jet_a_end");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("jet_a_start");
      namespace_6393a86f2fcda776::function_621018eac1ae9012("jet_a_end", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_CLEAR_AREA");
      utility::flag_wait("vehicle_a_start");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("jet_a_end");
    case #"hash_797ddd6719ecf630":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("vehicle_a_start", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_CLEAR_AREA");
      utility::flag_wait("vehicle_b_start");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("vehicle_a_start");
    case #"hash_797de06719ecfae9":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("vehicle_b_start", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_CLEAR_AREA");
      utility::flag_wait("vehicle_b_end");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("vehicle_b_start");
    case #"hash_f4f80a06409327cf":
      namespace_6393a86f2fcda776::function_621018eac1ae9012("heli_boss", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_HELI_BOSS");
      utility::flag_wait("heli_dead");
      wait 2;
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("heli_boss");
      namespace_6393a86f2fcda776::function_621018eac1ae9012("clear_hangar", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_HANGAR_CLEAR");
      utility::flag_wait("hangar_clear");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("clear_hangar");
      namespace_6393a86f2fcda776::function_621018eac1ae9012("level_hangar", "current", undefined, &"SP_JUP_GUNSHIP/OBJ_HANGAR_DSTR");
      utility::flag_wait("hangar_b_death");
      namespace_6393a86f2fcda776::function_9b7e8d9669747c9f("level_hangar");
    case #"hash_97591d94e1ac2788":
      level.player scripts\sp\player::focusdisable();
      break;
  }
}

function function_49a22cfc6e162661() {}

function function_767aef496a3ec942() {
  namespace_6393a86f2fcda776::spawnallies(1);
  utility::activate_trigger_with_noteworthy("allies_push_trigger_01");

  foreach(guy in getaiarray("allies")) {
    guy.ignoreall = 1;
  }

  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_push_0", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_push_0", level.farah, level.var_7ea643c0d786d48);
  level.var_44401f5c747eee93 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_01", 1, 1);
  level.var_4440205c747ef0c6 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_02", 1, 1);
  level.var_4440215c747ef2f9 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_03", 1, 1);
  level.var_4440225c747ef52c = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_04", 1, 1);
  level.var_4440235c747ef75f = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_05", 1, 1);
  namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_06", 1);
  hud_util::fade_out(0);
  level.player freezecontrols(1);
  level.player setsoundsubmix("sp_mix_plr_foley_mute", 0.05);
  level.player setsoundsubmix("sp_jup_gunship_mix", 0.05);
  thread intro_music();
  thread function_59e0484cf23b621a();
  wait 1;
  level.player freezecontrols(0);
  delaythread(0.2, &hud_util::fade_in, 0);
  namespace_6393a86f2fcda776::setup_gunship(280, 18000, 26000, 205, 0, 1);
  level.var_5a3f504f0ddbd74f = 0;
  focus_struct = utility::getStruct("gunship_focus_1", "targetname");
  level.var_dc44706239201a43 = focus_struct.origin;
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_01");

  if(!istrue(level.var_259a7e2e6fa2cbe6)) {
    level waittill("gunship_intro_over");
  } else {
    flag_wait("intro_vo_over");
  }

  if(utility::flag("userskipped") && isDefined(level.var_3e806433874b3b6c)) {
    snd_stop(level.var_3e806433874b3b6c, 0.2);
  }

  utility::autosave_by_name("intro_over");
}

function intro_music() {
  wait 1;
  setmusicstate("mx_gunship_intro");
}

function intro_vfx() {
  playFX(getfx("vfx_gunship_intro_sunflare"), (0, 0, 0));
}

function function_227a0bed4f6b8913() {
  utility::flag_set("intro_vo_over");
  level.player setsoundsubmix("sp_mix_plr_foley_mute", 0.05);
  level.player setsoundsubmix("sp_jup_gunship_mix", 0.05);
}

function function_59e0484cf23b621a() {
  level endon("userskipped");
  utility::flag_set("intro_vo_over");
}

function function_fe8bba6cc02041a1() {
  namespace_6393a86f2fcda776::setup_gunship(280, 18000, 26000, 205, 0);
  focus_struct = utility::getStruct("gunship_focus_1", "targetname");
  level.var_dc44706239201a43 = focus_struct.origin;
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_01");
  namespace_6393a86f2fcda776::spawnallies(1);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_push_0", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_push_0", level.farah, level.var_7ea643c0d786d48);
  level.var_44401f5c747eee93 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_01", 1, 1);
  level.var_4440205c747ef0c6 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_02", 1, 1);
  level.var_4440215c747ef2f9 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_03", 1, 1);
  level.var_4440225c747ef52c = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_04", 1, 1);
  level.var_4440235c747ef75f = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_05", 1, 1);
  namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_06", 1);
  utility::activate_trigger_with_noteworthy("allies_push_trigger_01");
}

function function_5a7719e5d6215f82() {
  allies = getaiarray("allies");

  foreach(guy in allies) {
    guy.ignoreall = 1;
    guy.ignoreme = 1;
  }

  function_29092b5a44845a82();
}

function function_7d0cdf9cad6b4053() {
  utility::flag_set("teams_located");
  utility::flag_set("price_located");
  utility::flag_set("farah_located");
}

function function_29092b5a44845a82() {
  wait 0.5;

  level.var_6906aa4d708551de = 1;
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_02", 60);
  thread function_c429b64f8eb308f9();
  animnode = getStruct("intro_lasso_loop_node", "targetname");
  animnode function_5b93faddf8b9f342();
  markers = [];

  foreach(ally in [level.price, level.farah]) {
    markers[markers.size] = ally thread namespace_6393a86f2fcda776::function_91fff8ef1083babf((0, 0, 0), 1, 1, 0, "icon_waypoint_overlay_marker_neutral_small", 1, 1);
  }

  level.price thread function_9529433d6844e3f0("price_located", 1);
  level.farah thread function_9529433d6844e3f0("farah_located", 2);
  utility::flag_wait_any_array(["price_located", "farah_located"]);
  utility::flag_set("teams_located");
  utility::autosave_by_name("teams_located");
  animnode function_ac4418db8ff0afc2();

  foreach(marker in markers) {
    if(isDefined(marker) && !isint(marker)) {
      marker destroy();
    }
  }

  foreach(hero in level.heros) {
    hero thread namespace_6393a86f2fcda776::function_91fff8ef1083babf((0, 0, 0), 1, 1, 0, "icon_waypoint_overlay_marker_friendly_small", 0, 1);
  }

  level.var_6906aa4d708551de = undefined;
  function_b0f3a3113baa9089();
  utility::autosave_by_name("teams_located_done");
}

function function_5361bef5df574c2d() {
  setmusicstate("mx_gunship_intro_alt");
}

function function_c429b64f8eb308f9() {
  if(istrue(level.var_259a7e2e6fa2cbe6)) {
    level endon("price_located");
    level endon("farah_located");
    wait 0.2;
    level.farah dialogue::say_team("dx_sp_jsgs_lote_fara_shadow1groundteamish");
    level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_lote_grav_copystandby");
    level dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_lote_grav_gunnerconfirmvisualo");
    var_dc8c01a8d7691c60 = ter_op(function_2624fca3e73f715e(level.player), "weapon_ads_hold", "weapon_ads");
    utility::display_hint(var_dc8c01a8d7691c60, undefined, 0.05, level, ["price_located", "farah_located"]);
  } else {
    utility::flag_wait_any("intro_vo_over", "userskipped");
    level dialogue::say_team("dx_sp_jsgs_lote_grav_copystandby");
  }

  thread function_aa5f35d84b816ee1();
}

function function_aa5f35d84b816ee1() {
  level endon("teams_located");

  if(utility::flag("teams_located")) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_gunnerconfirmvisual";
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_thatsyougunner";
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_getvisualontheground";
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_gunnerzoominonthoses";
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_zoominonthosestrobes";
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_zoominconfirmvisual";
  aliases[aliases.size] = "dx_sp_jsgs_lote_grav_letsgogunnerconfirmv";
  level.player thread nag_wait("teams_located", aliases, growing_delay(10, 20, 3));
}

function function_5b93faddf8b9f342() {
  thread anim_loop_solo(level.alex, "intro_lasso_loop", "intro_lasso_loop_stop");
  level.alex namespace_ca8e7784c927af3::function_ed889c1df05699ab();
}

function function_ac4418db8ff0afc2() {
  thread notify_delay("intro_lasso_loop_stop", 6);
  level.alex delaythread(6, &namespace_ca8e7784c927af3::function_b9e632d78e4e194f);
}

function function_b0f3a3113baa9089() {
  wait 0.1;
  level.player dialogue::say_team("dx_sp_jsgs_lote_sgun_copyvisual");
  level dialogue::say_team("dx_sp_jsgs_lote_ssig_marking");
  wait 0.3;
  level dialogue::say_team("dx_sp_jsgs_lote_grav_groundteamwehavevisu");
}

function function_9529433d6844e3f0(flag, var_cd7fcfe71408b4ff) {
  namespace_6393a86f2fcda776::function_b8739f7855404a3b([self], 0.999391, undefined, 1, 1);
  utility::flag_set(flag);
}

function function_32e31df8ada16d42() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(310, 18000, 26000, 205, 0);
  focus_struct = utility::getStruct("gunship_focus_2", "targetname");
  level.var_dc44706239201a43 = focus_struct.origin;
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  level.var_44401f5c747eee93 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_01", 1, 1);
  level.var_4440205c747ef0c6 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_02", 1, 1);
  level.var_4440215c747ef2f9 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_03", 1, 1);
  level.var_4440225c747ef52c = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_04", 1, 1);
  level.var_4440235c747ef75f = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_05", 1, 1);
  namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_06", 1);
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_01");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_02", 50);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_push_0", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_push_0", level.farah, level.var_7ea643c0d786d48);
  allies = getaiarray("allies");

  foreach(guy in allies) {
    guy.ignoreall = 1;
    guy.ignoreme = 1;
  }

  utility::activate_trigger_with_noteworthy("allies_push_trigger_01");
}

function function_58f2b3284794bcd3() {
  function_8c5bbfa14df9b834();
}

function function_79eabb701106fec8() {
  utility::flag_set("tower_fall_vo_done");
  utility::add_global_spawn_function("axis", &namespace_6393a86f2fcda776::function_686b79a5ab9b4807);
  utility::add_global_spawn_function("allies", &namespace_6393a86f2fcda776::function_93adc12f2e2e2314);
}

function function_8c5bbfa14df9b834() {
  thread function_8d394d9dfee5cad6();
  level waittill("gunship_weapon_impact", position, weaponname);
  allies = getaiarray("allies");

  foreach(guy in allies) {
    guy namespace_6393a86f2fcda776::function_93adc12f2e2e2314();
  }

  axis = getaiarray("axis");

  foreach(guy in axis) {
    targets = sortbydistance(allies, guy.origin);
    guy getenemyinfo(targets[0]);

    if(!istrue(guy.var_d39adb66d4154683)) {
      guy anim_stopanimScripted();
    }

    guy.var_500ae92ed478c56f = guy.var_6308088457db06da;
    guy namespace_6393a86f2fcda776::function_686b79a5ab9b4807(1);
    guy thread namespace_5bf3bd82da62657f::function_56909bc02dcec30d(1);
  }

  utility::add_global_spawn_function("axis", &namespace_6393a86f2fcda776::function_686b79a5ab9b4807);
  utility::add_global_spawn_function("allies", &namespace_6393a86f2fcda776::function_93adc12f2e2e2314);
  utility::autosave_by_name("combat_start");
  thread function_c2553f2d985620d5();
  wait 0.5;
  level.price dialogue::say_team("dx_sp_jsgs_psh1_grav_konniknowswerehere");
}

function function_8d394d9dfee5cad6() {
  level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_lote_fara_copyourtargetsarethe");
  wait 0.3;
  level dialogue::say_team("dx_sp_jsgs_psh1_ssig_markingthreatsintheb");

  if(isDefined(level.var_44401f5c747eee93)) {
    namespace_6393a86f2fcda776::function_c2ace64053c30140(level.var_44401f5c747eee93);
    thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(20, "gunship_weapon_impact", level.marker_locations["location_boneyard"], 2);
  }

  wait 0.6;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_groundteamholdpositi");
  wait 0.5;
  thread function_92b79f29b8902c80(level.farah, "boneyard_lasso_01", 10, "flares_enabled");
  wait 0.3;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_gunnerlaydowncoverfi");
  wait 0.2;
  level thread dialogue::say_team("dx_sp_jsgs_psh1_sgun_onthetrigger");
  wait 0.25;
  level.var_f1acd9be11d8efe5 = 1;
  level dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_jsgs_psh1_grav_timetogettoworkshado");
}

function private function_c5a4ea2d2f4e3290() {
  level endon("sam_site_dead");
  utility::flag_wait_or_timeout("sam_site_ready", 30);
  utility::flag_set("sam_site_ready");
  utility::flag_set("sam_site_start");
  utility::flag_wait("sam_start_shooting");
  sam_turret = getEnt("sam_site_top", "targetname");
  sam_turret endon("entitydeleted");
  sam_turret function_9094567c9547a9cc(sam_turret.sam_missiles[0], 4, 0, 8);
  sam_turret function_9094567c9547a9cc(sam_turret.sam_missiles[1], 4, 0, 7);
  sam_turret function_9094567c9547a9cc(sam_turret.sam_missiles[2], 2.5, 0, 0.5);
  sam_turret function_9094567c9547a9cc(sam_turret.sam_missiles[3], 0.5, 1);
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_c2553f2d985620d5() {
  wait 5;
  stopmusicstate("mx_gunship_intro");
}

function function_b93a3675736f6b7f() {
  level endon("sam_site_dead");
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_rtwr_grav_konnistargetingushit";
  aliases[aliases.size] = "dx_sp_jsgs_rtwr_splt_enemysamsite";
  aliases[aliases.size] = "dx_sp_jsgs_rtwr_grav_hitthatsamsitenow";
  i = 0;
  var_91b920aeeee2cc6a = utility::getStructArray("radio_tower_structs", "targetname");

  while(!utility::flag("sam_site_dead")) {
    wait 3;

    if(utility::flag("sam_site_dead")) {
      return;
    }

    if(i >= 3) {
      i = 0;
    }

    voline = aliases[i];
    i++;

    if(!utility::flag("sam_start_shooting")) {
      thread utility::flag_set_delayed("sam_start_shooting", 2);
    }

    if(function_c4951a4784954657(var_91b920aeeee2cc6a, 0.984808, 100) && !isDefined(level.var_d6d3568761e946c5)) {
      thread utility::display_hint("weapon_swap", 10, 1, level, "sam_site_dead");
    }

    level dialogue::say_team(voline);
  }
}

function function_2eb04bc1a1ed5570() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(330, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  level.var_44401f5c747eee93 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_01", 1, 1);
  level.var_4440205c747ef0c6 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_02", 1, 1);
  level.var_4440215c747ef2f9 = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_03", 1, 1);
  level.var_4440225c747ef52c = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_04", 1, 1);
  level.var_4440235c747ef75f = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_05", 1, 1);
  namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_06", 1);
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_02");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_push_1", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_push_1", level.farah, level.var_7ea643c0d786d48);
  thread namespace_6393a86f2fcda776::marklocation(level.marker_locations["location_boneyard"], 2);
  thread function_25169dc0c00d0522();
}

function function_25169dc0c00d0522() {
  while(!isDefined(level.var_ce37247e494d0064)) {
    waitframe();
  }

  axis = getaiarray("axis");
  allies = getaiarray("allies");

  foreach(guy in axis) {
    targets = sortbydistance(allies, guy.origin);
    guy getenemyinfo(targets[0]);
    guy thread namespace_6393a86f2fcda776::function_686b79a5ab9b4807(1);
  }
}

function function_2befc67ff1467929() {
  while(!isDefined(level.var_44401f5c747eee93)) {
    waitframe();
  }

  if(isDefined(level.var_44401f5c747eee93)) {
    namespace_6393a86f2fcda776::function_c2ace64053c30140(level.var_44401f5c747eee93);
  }

  thread namespace_6393a86f2fcda776::function_c2ace64053c30140(level.var_4440205c747ef0c6, "base_group_02_push");
  threats = utility::array_combine(level.var_44401f5c747eee93, level.var_4440205c747ef0c6, level.var_4440215c747ef2f9, level.var_4440225c747ef52c);
  threats = utility::array_removedead_or_dying(threats);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(level.var_44401f5c747eee93, 2, 60);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(2);
  group_01 = utility::array_removedead_or_dying(level.var_44401f5c747eee93);

  foreach(threat in group_01) {
    threat.attackeraccuracy = 10;
  }

  thread function_a1e89aec1859886a("base_group_tower", "tents_tower_01", 1);
  thread utility::flag_set_delayed("base_group_02_push", 9);
  thread utility::flag_set_delayed("base_group_03_push", 17);
  thread utility::flag_set_delayed("base_group_05_push", 22);
  thread function_dbb9b8a3f5996b7();
  utility::flag_wait("sam_site_dead");
  threats = utility::array_removedead_or_dying(threats);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(threats, 22, 60);
  var_799015587fcdda8f = getStruct("location_boneyard", "script_noteworthy");
  var_799015587fcdda8f.origin = (-43042.6, 22490.1, 536.646);
  threats = utility::array_removedead_or_dying(threats);
  thread namespace_6393a86f2fcda776::function_c2ace64053c30140(level.var_4440215c747ef2f9, "base_group_03_push");
  thread namespace_6393a86f2fcda776::function_c2ace64053c30140(level.var_4440235c747ef75f, "base_group_05_push");
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(threats, 16, 60);
  group_02 = utility::array_removedead_or_dying(level.var_4440205c747ef0c6);

  foreach(threat in group_02) {
    threat.attackeraccuracy = 10;
  }

  utility::flag_set("fallback_01");
  utility::autosave_by_name("push_1");
  utility::flag_set("push_1");
  utility::flag_set("push_1_over");
  threats = utility::array_combine(level.var_44401f5c747eee93, level.var_4440205c747ef0c6, level.var_4440215c747ef2f9, level.var_4440225c747ef52c, level.var_4440235c747ef75f);
  threats = utility::array_removedead_or_dying(threats);
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_03", 60);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(threats, 14, 60, undefined, 3);
  utility::activate_trigger_with_noteworthy("allies_push_trigger_03");
  thread function_ffcce2a206bdbe7a();
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(2);
  utility::flag_set("fallback_02");
  utility::flag_set("stop_boneyard_nag");
  utility::autosave_by_name("push_2");
  utility::flag_set("push_2");
  node = getStruct("tents_fallback_node", "targetname");
  var_c50f1c0c85f33730 = utility::array_combine(level.var_44401f5c747eee93, level.var_4440205c747ef0c6, level.var_4440215c747ef2f9, level.var_4440235c747ef75f);
  var_c50f1c0c85f33730 = utility::array_removedead_or_dying(var_c50f1c0c85f33730);

  foreach(guy in var_c50f1c0c85f33730) {
    guy thread spawner::go_to_node(node);
  }

  threats = utility::array_combine(level.var_44401f5c747eee93, level.var_4440205c747ef0c6, level.var_4440215c747ef2f9, level.var_4440225c747ef52c, level.var_4440235c747ef75f);
  threats = utility::array_removedead_or_dying(threats);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(threats, 12, 90, undefined, 3);
  utility::flag_set("fallback_03");
  threats = utility::array_removedead_or_dying(threats);

  foreach(threat in threats) {
    threat.attackeraccuracy = 10;
  }
}

function function_ffcce2a206bdbe7a() {
  level.farah thread function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_psh1_fara_groundteamispushingt");
  level function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_veha_grav_rogerthatshadowswatc");
}

function function_d8852f347c68bca6() {
  utility::flag_set("push_1");
  utility::flag_set("push_1_over");
  utility::flag_set("fallback_01");
  utility::flag_set("fallback_02");
  utility::flag_set("fallback_03");
  utility::flag_set("push_2");
  utility::flag_set("flares_enabled");
  utility::flag_set("base_group_02_push");
  utility::flag_set("base_group_03_push");
  utility::flag_set("base_group_05_push");
  utility::flag_set("sam_site_dead");
  utility::flag_set("sam_site_ready");
  utility::flag_set("sam_site_start");
  utility::flag_set("sam_start_shooting");
  thread function_c70423de2fd6d621();
}

function function_a1e89aec1859886a(ainame, var_42f4fa744be9bf5, mark) {
  level endon("fallback_03");
  utility::flag_wait("sam_site_dead");
  tower = level.var_ce37247e494d0064[var_42f4fa744be9bf5];
  tower.guys = namespace_6393a86f2fcda776::function_de001f4d27208780(ainame, 1, 1);

  if(istrue(mark)) {
    namespace_6393a86f2fcda776::function_c2ace64053c30140(tower.guys);
  }

  guys = array_removedead_or_dying(tower.guys);

  if(tower getscriptablepartstate("base", 1) == "dead") {
    foreach(guy in guys) {
      if(isDefined(guy.var_6308088457db06da)) {
        guy thread spawner::go_to_node(guy.var_6308088457db06da);
      }
    }
  }

  foreach(guy in guys) {
    guy.var_7811134668469758 = 1;
    guy.var_e169a98f19389f0d = 1;
  }
}

function function_dbb9b8a3f5996b7() {
  if(utility::flag("sam_site_dead")) {
    var_799015587fcdda8f = getStruct("location_boneyard", "script_noteworthy");
    var_799015587fcdda8f.origin = (-43042.6, 22490.1, 536.646);
    utility::flag_set("push_0");
    utility::activate_trigger_with_noteworthy("allies_push_trigger_02");
    delaythread(1, &function_92b79f29b8902c80, level.farah, "boneyard_lasso_02", 10, "push_1");
    utility::flag_set("flares_enabled");
    return;
  }

  thread function_92b79f29b8902c80(level.price, "tower_lasso_01", 20, "sam_site_dead");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
  guys = namespace_6393a86f2fcda776::function_de001f4d27208780("sam_site_guys", 1, 1);

  foreach(guy in guys) {
    guy.ignoreall = 1;
  }

  level.sam_site thread function_c5a4ea2d2f4e3290();
  utility::flag_set("flares_enabled");
  utility::flag_set("disable_autosaves");
  thread function_6e935fbd89b88380();
  thread function_c0388e74577248d2();
  utility::flag_wait("sam_site_dead");

  if(!flag("push_0")) {
    utility::flag_set("push_0");
    utility::activate_trigger_with_noteworthy("allies_push_trigger_02");
  }

  utility::flag_clear("disable_autosaves");
  utility::autosave_by_name("sam_site_end");

  if(getomnvar("ui_veh_warning") != 0) {
    level.player setclientomnvarbit("ui_veh_warning", 2, 0);
  }

  level.var_e2dedfef1129cd21 = undefined;

  if(isDefined(level.sam_site) && isDefined(level.sam_site.marker) && !isint(level.sam_site.marker)) {
    level.sam_site.marker destroy();
  }

  utility::autosave_by_name("radio_tower");
  var_799015587fcdda8f = getStruct("location_boneyard", "script_noteworthy");
  var_799015587fcdda8f.origin = (-43042.6, 22490.1, 536.646);
  thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(20, "push_0", level.marker_locations["location_boneyard"], 2);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  wait 0.5;
  level dialogue::say_team("dx_sp_jsgs_rtwr_snav_goodimpacttargetdest");
  wait 2;
  guys = getaiarray("axis");

  if(guys.size > 5) {
    level.gaz dialogue::say_team("dx_sp_jsgs_psh1_gazz_checksouthkonnismovi");
    level.farah dialogue::say_team("dx_sp_jsgs_psh1_fara_shadow1groundteamisi");
    wait 0.2;
    level dialogue::say_team("dx_sp_jsgs_veha_grav_copythatwereonit");
    wait 0.3;
    guys = getaiarray("axis");

    if(guys.size > 5 && isDefined(level.gunship.last_fired) && time_has_passed(level.gunship.last_fired, 2)) {
      level dialogue::say_team("dx_sp_jsgs_psh1_grav_putroundsintheboneya");

      if(!flag("fallback_02")) {
        thread function_d55bbf2b7185096c();
      }
    }
  }

  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_d55bbf2b7185096c(guys, count) {
  utility::flag_set("stop_boneyard_nag");
  utility::flag_clear("stop_boneyard_nag");
  level endon("stop_boneyard_nag");
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_enemiesintheboneyard";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_multiplekonniinthebo";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_snav_targetlocationisthee";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_gunnertargettheboney";
  level thread dialogue::nag_wait("stop_boneyard_nag", aliases, growing_delay(10, 20, 3));

  if(!isDefined(guys)) {
    guys = utility::array_combine(level.var_44401f5c747eee93, level.var_4440205c747ef0c6, level.var_4440215c747ef2f9);
  }

  guys = utility::array_removedead_or_dying(guys);
  namespace_6393a86f2fcda776::function_65d3632dd282d98a(guys, 0.999848, 100, undefined, "stop_boneyard_nag");

  for(;;) {
    guys = array_removedead_or_dying(guys);

    if(guys.size <= default_to(count, 8)) {
      break;
    }

    waitframe();
  }

  utility::flag_set("stop_boneyard_nag");
}

function function_c0388e74577248d2() {
  level endon("sam_site_dead");
  var_91b920aeeee2cc6a = utility::getStructArray("radio_tower_structs", "targetname");
  namespace_6393a86f2fcda776::function_65d3632dd282d98a(var_91b920aeeee2cc6a, 0.999848, 500);
  utility::flag_set("push_0");
  utility::activate_trigger_with_noteworthy("allies_push_trigger_02");
  delaythread(1, &function_92b79f29b8902c80, level.farah, "boneyard_lasso_02", 10, "push_1");

  while(isDefined(level.var_d6d3568761e946c5)) {
    waitframe();
  }

  thread utility::display_hint("weapon_swap", 10, 1, level, "sam_site_dead");
}

function function_6e935fbd89b88380() {
  if(utility::flag("sam_site_dead")) {
    return;
  }

  level endon("sam_site_dead");
  level dialogue::say_team("dx_sp_jsgs_rtwr_splt_threatstothenortheas");
  level.sam_site.marker = level.sam_site thread namespace_6393a86f2fcda776::function_91fff8ef1083babf((0, 0, 0), 1, 1, 1, "icon_waypoint_overlay_marker_special", 1);
  wait 0.5;
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(2);
  level dialogue::say_team("dx_sp_jsgs_rtwr_snav_konnismaneuveringnea");
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(4, "sam_site_dead", level.marker_locations["location_radioTower"], 3);
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_rtwr_grav_gunnergeteyesonthatt");
  utility::flag_wait("sam_site_ready");
  utility::flag_set("sam_site_start");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_rtwr_ssig_gotasamsiteneartheto");
  wait 0.2;
  var_91b920aeeee2cc6a = utility::getStructArray("radio_tower_structs", "targetname");

  if(function_c4951a4784954657(var_91b920aeeee2cc6a, 0.984808, 100) && !isDefined(level.var_d6d3568761e946c5)) {
    thread utility::display_hint("weapon_swap", 10, 1, level, "sam_site_dead");
  }

  level dialogue::say_team("dx_sp_jsgs_rtwr_grav_gunnerdropamissileon");
  thread function_b93a3675736f6b7f();
}

function function_589f3cbe544df6a1() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(350, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_02");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_push_2", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_push_2", level.farah, level.var_7ea643c0d786d48);
  utility::activate_trigger_with_noteworthy("allies_push_trigger_03");
}

function function_1db6a285e59d682() {
  utility::flag_wait("push_2_flank");
  var_4840591f7129561e = namespace_6393a86f2fcda776::function_de001f4d27208780("base_group_05_backup", 1, 1);

  foreach(guy in var_4840591f7129561e) {
    guy.ignoreme = 1;
    guy.ignoreall = 1;
  }

  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(var_4840591f7129561e, 0, 8);
  var_4840591f7129561e = utility::array_removedead_or_dying(var_4840591f7129561e);

  if(var_4840591f7129561e.size > 3) {
    utility::activate_trigger_with_noteworthy("allies_push_trigger_04");
    delaythread(1, &function_92b79f29b8902c80, level.price, "boneyard_lasso_03", 10, "base_group_05_fallback");
    thread function_772888901841b15f(var_4840591f7129561e, 4);
    var_4840591f7129561e = utility::array_removedead_or_dying(var_4840591f7129561e);
  }

  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(var_4840591f7129561e, 0, 2);
  var_4840591f7129561e = utility::array_removedead_or_dying(var_4840591f7129561e);

  foreach(guy in var_4840591f7129561e) {
    guy.ignoreme = 0;
    guy.ignoreall = 0;
  }

  namespace_6393a86f2fcda776::function_c2ace64053c30140(var_4840591f7129561e);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50(var_4840591f7129561e, 3, 90, undefined, 3);
  utility::flag_set("base_group_05_fallback");
  var_4840591f7129561e = utility::array_removedead_or_dying(var_4840591f7129561e);

  if(var_4840591f7129561e.size > 0) {
    wait 2;
  }

  utility::flag_set("push_3");
  utility::flag_set("stop_boneyard_nag");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  utility::activate_trigger_with_noteworthy("allies_tents_trigger_01");
  entcleanup("cleanup_boneyard");
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(2);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  thread function_6ccc5f00f37c2d8a();
  wait 6;
  namespace_6393a86f2fcda776::function_de001f4d27208780("tents_group_01", 1);
  wait 0.1;
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  thread function_b5762ed07f2dd744();
  guys = getaiarray("axis");
  namespace_6393a86f2fcda776::function_c2ace64053c30140(guys);
  utility::flag_wait_or_timeout("tents_start", 90);
  delaythread(1, &function_92b79f29b8902c80, level.farah, "tents_lasso_01", 10, "fallback_tents");
  guys = array_removedead_or_dying(guys);

  if(guys.size > 3) {
    namespace_6393a86f2fcda776::function_a44e35e2dc63be50(guys, 3, 90);
    wait 3;
    utility::flag_set("fallback_tents");
  } else {
    utility::flag_set("fallback_tents");
  }

  thread function_ceac4bf3862cfc29();
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  utility::activate_trigger_with_noteworthy("allies_push_trigger_05");
  utility::flag_wait_any("tents_end", "tents_skipped");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_4c814142720b3d53() {
  entcleanup("cleanup_boneyard");
  utility::flag_set("push_2_flank");
  utility::flag_set("push_3");
  utility::flag_set("fallback_02");
  utility::flag_set("fallback_03");
}

function function_6ccc5f00f37c2d8a() {
  level endon("tents_start");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  level thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_rtwr_grav_groundteamtheresyour");
  level.farah dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_rtwr_fara_copythatweremovingup");
  level thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_shep_keepemcoveredshadow");
  level dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_lote_grav_copyactual");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_772888901841b15f(threats, count) {
  level endon("push_3");
  wait 2.5;
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  level.gaz dialogue::say_team("dx_sp_jsgs_psh1_gazz_contact", 0, [level, "push_3"]);
  level.price thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh1_pric_shadowtroopsincontac", 0, [level, "push_3"]);
  level dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_psh1_grav_shadowcopieswereonit", 0, [level, "push_3"]);

  if(!flag("push_3")) {
    thread function_d55bbf2b7185096c(threats, count);
  }

  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_b5762ed07f2dd744() {
  level endon("fallback_tents");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_hngr_snav_enemiespushinginfrom");
  wait 0.2;
  level dialogue::say_team("dx_sp_jsgs_psh2_ssig_marking");
  wait 0.5;
  level endon("gunship_weapon_fired");
  level endon("hellfire_missile_alive");

  if(getaiarray("axis").size > 3 && isDefined(level.gunship.last_fired) && time_has_passed(level.gunship.last_fired, 2)) {
    guys = getaiarray("axis");
    waittill_any_ents_array(guys, "weapon_fired");
    level.alex dialogue::say_team("dx_sp_jsgs_psh1_alex_31incontact");
    level.farah thread dialogue::say_team("dx_sp_jsgs_psh1_fara_shadow1weretakingeff");
    level dialogue::say_team("dx_sp_jsgs_psh1_grav_copykilowereworkingo");
    level dialogue::say_team("dx_sp_jsgs_psh1_grav_gunnerfocusfireonene");
    function_4baa23b08c0e17a();
  }
}

function function_4baa23b08c0e17a() {
  level endon("fallback_tents");

  if(utility::flag("fallback_tents")) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh1_ssig_targetsintheopen"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh1_grav_gunnercovertheground"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh1_ssig_multipleenemiesmovin"];
  level.player thread nag_wait("fallback_tents", aliases, growing_delay(10, 20, 3));
}

function function_ceac4bf3862cfc29() {
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);

  if(getaiarray("axis").size == 0) {
    level.gaz dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_psh1_gazz_clear");
  } else {
    wait 1;
  }

  level.farah thread dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_jsgs_psh1_fara_shadow1goodhits");
  level.farah thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh1_fara_keepthemcomingground");
  level dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_grav_wegotyougroundteam");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_55798db8d4ab92d4() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(90, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_03");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_hangar", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_hangar", level.farah, level.var_7ea643c0d786d48);
  utility::activate_trigger_with_noteworthy("allies_push_trigger_05");
}

function function_cf5ed05c525a5385() {
  entcleanup("cleanup_tents");
  jeta();
  guys = getaiarray("axis");

  if(guys.size >= 10) {
    thread function_103fc444c0543d31();
  }

  level utility::delaythreadendon(2, "hangar_a_start", &namespace_6393a86f2fcda776::function_c2ace64053c30140);
  level.var_9e1ae3102c095174 = 1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 6, 180);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
  utility::flag_set("fallback_04");
  utility::flag_set("stop_tarmac_nag");
  thread utility::flag_set_delayed("push_4", 0.5);
  utility::delaythread(0.5, &activate_trigger_with_noteworthy, "allies_push_trigger_06");
  thread function_5e126b1dab9d8226();

  foreach(guy in getaiarray("axis")) {
    guy notify("stop_stinger_system");
  }

  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 36, 45);
  wait 15;
  thread function_ebd582a6d43c90a0();
  namespace_6393a86f2fcda776::function_de001f4d27208780("barracks_group_01", 1);
  namespace_6393a86f2fcda776::function_de001f4d27208780("barracks_group_02", 1);
  function_a1e89aec1859886a("barracks_tower_01_guys", "barracks_tower_01");
  level.var_ce37247e494d0064["barracks_tower_01"] thread function_fd7de9398f529402("hangar1_rpg_targets", undefined, "fallback_05", "dx_sp_jsgs_hngr_sgun_tookouttheirrpg");
  utility::flag_wait("hangar_a_start");
  var_f37e1dfdd520e065 = [];
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_ssig_enemiesclosinginonha";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_snav_threatsadvancingonha";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_pric_enemiespushingintoha";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_pric_groundteamstakingcon";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_pric_shadowweneedcloseair";
  function_e2dda65613b9fe4f("hangar_a_threat_warning", var_f37e1dfdd520e065);
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
  utility::autosave_by_name("hangar_a_start");
  wait 0.5;

  foreach(ally in getaiarray("allies")) {
    ally.accuracy = 0;
    ally.baseaccuracy = 0;
  }

  namespace_6393a86f2fcda776::function_d8fbd5fda6bc8171("hangar_a_threat_fail");
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 19, 45);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
  namespace_6393a86f2fcda776::function_de001f4d27208780("barracks_group_02", 1);
  var_c11475a64e25b066 = getEnt("hangar_1_doorClip", "targetname");

  if(isDefined(var_c11475a64e25b066)) {
    var_c11475a64e25b066 disconnectPaths();
  }

  wait 0.1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 4, 90);
  guys = level.var_ce37247e494d0064["barracks_tower_01"].guys;
  guys = array_removedead_or_dying(guys);

  if(guys.size < 1) {
    utility::flag_set("fallback_05");
    start = gettime();

    for(;;) {
      guys = level.var_ce37247e494d0064["barracks_tower_01"].guys;
      guys = array_removedead_or_dying(guys);

      if(guys.size < 1 || time_has_passed(start, 20)) {
        break;
      }

      waitframe();
    }
  }

  utility::flag_set("fallback_05_rpg");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  flag_wait("hanagr1_main_vo_done");
  level notify("stop_threatWarningWatcher");
  function_d2193a499376c47d();
  wait 2;
  thread function_c28cd7d1c847837d();
  var_c11475a64e25b066 = getEnt("hangar_1_doorClip", "targetname");

  if(isDefined(var_c11475a64e25b066)) {
    var_c11475a64e25b066 connectpaths();
  }

  utility::autosave_by_name("hangar_a_end");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_04", 60);
  function_ef1928c930407fff();
  utility::flag_set("hangar_a_clear");
  utility::activate_trigger_with_noteworthy("allies_push_trigger_07");
  namespace_6393a86f2fcda776::function_de001f4d27208780("hangar_group_03", 1);
  aliases = ["dx_sp_jsgs_hngr_snav_rpgfirecomingfromeas", "dx_sp_jsgs_hngr_grav_hitthoserpgs"];
  function_a1e89aec1859886a("barracks_tower_02_guys", "barracks_tower_02");
  level.var_ce37247e494d0064["barracks_tower_02"] function_fd7de9398f529402("hangar2_rpg_targets", aliases, "hangar_b_end", "dx_sp_jsgs_hngr_grav_rpgsdestroyed");
  utility::flag_wait("hangar_b_start");
  var_f37e1dfdd520e065 = [];
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_alex_enemiespushingintoth";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_ssig_threatsoutsidethehan";
  function_e2dda65613b9fe4f("hangar_fail_1", var_f37e1dfdd520e065);
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  utility::autosave_by_name("hangar_b_start");
  sequence = [level.farah, "dx_sp_jsgs_hngr_fara_allstationshangar2is", level, 0.3, "dx_sp_jsgs_hngr_shep_makarov", level.price, 0.2, "dx_sp_jsgs_hngr_pric_negativehesnothere", level, 0.2, "dx_sp_jsgs_hngr_shep_hecouldbeclose", level, 0.3, "dx_sp_jsgs_hngr_shep_groundteamapplythere", level, 0.2, "dx_sp_jsgs_hngr_grav_copythat"];
  dialogue::function_c9a09b3ba9c68f8d(0.3, sequence);
  thread hangar_music();
  utility::autosave_by_name("hangar_b_end");
  utility::flag_set("hangar_b_end");
  level thread dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_jsgs_veha_shep_allstationsbeadvised");
  level thread dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_psh1_grav_copythatactual");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  wait 1;
  entcleanup("cleanup_hangar_01");
  var_c11474a64e25ae33 = getEnt("hangar_2_doorClip", "targetname");

  if(isDefined(var_c11474a64e25ae33)) {
    var_c11474a64e25ae33 disconnectPaths();
  }
}

function function_49a1951324d6bd1a() {
  utility::activate_trigger_with_noteworthy("allies_push_trigger_07");
  utility::flag_set("tents_skipped");
  utility::flag_set("tents_start");
  utility::flag_set("tents_end");
  utility::flag_set("jet_a_start");
  utility::flag_set("jet_1_dead");
  utility::flag_set("jet_a_end");
  utility::flag_set("push_4");
  utility::flag_set("fallback_04");
  utility::flag_set("hanagr1_main_vo_done");
  level.var_9e1ae3102c095174 = 1;
  thread function_d095d7859e66b5c6();
  thread function_d2193a499376c47d();
  entcleanup("cleanup_tents");
  entcleanup("cleanup_hangar_01");
  utility::flag_set("hangar_a_clear");
  var_f37e1dfdd520e065 = [];
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_alex_enemiespushingintoth";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_ssig_threatsoutsidethehan";
  thread function_e2dda65613b9fe4f("hangar_fail_1", var_f37e1dfdd520e065);
}

function function_103fc444c0543d31() {
  level endon("fallback_04");
  level dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_snav_enemiespushingacross");
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh2_grav_groundteammultipleko");
  delaythread(5, &function_92b79f29b8902c80, level.price, "tarmac_lasso_01", 10, "push_4");
  thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(20, "push_4", level.marker_locations["location_tarmac"], 1);
  level.farah dialogue::say_team("dx_sp_jsgs_psh2_fara_copygroundteamishold");
  level dialogue::say_team("dx_sp_jsgs_psh2_grav_keepthegroundteamsec");
  childthread function_6b6ca11a15479fdc();
}

function function_6b6ca11a15479fdc() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_hngr_snav_enemiesincoming";
  aliases[aliases.size] = "dx_sp_jsgs_veha_grav_takeemoutgunner";
  aliases[aliases.size] = "dx_sp_jsgs_vehb_grav_gunnerkeepthepressur";
  level thread dialogue::nag_wait("stop_tarmac_nag", aliases, growing_delay(10, 20, 3));
  guys = getaiarray("axis");
  namespace_6393a86f2fcda776::function_65d3632dd282d98a(guys, 0.999848, 100, undefined, "stop_tarmac_nag");

  for(;;) {
    guys = array_removedead_or_dying(guys);

    if(guys.size <= 13) {
      break;
    }

    waitframe();
  }

  utility::flag_set("stop_tarmac_nag");
}

function function_ef1928c930407fff() {
  vol = getEnt("hangar_a_threat_fail", "targetname");

  if(isDefined(vol)) {
    threats = vol utility::get_ai_touching_volume("axis");
    threats = array_removedead_or_dying(threats);

    foreach(threat in threats) {
      threat kill();
    }
  }

  thread function_9cf20b763abbbdcf("mortar_1_animnode", "mortar_1", "mortar_1_guys", "mortar_a");
  thread function_89e293116e82e620();
  start = gettime();

  while(!flag("mortar_guys_dead") && level.mortar_impacts < 1 && !utility::time_has_passed(start, 20)) {
    waitframe();
  }

  wait 0.5;
  utility::flag_set("mortar_guys_vo");
}

function function_ef1929c930408232() {
  thread function_9cf20b763abbbdcf("mortar_2_animnode", "mortar_2", "mortar_2_guys", "mortar_a");
  start = gettime();

  while(!flag("mortar_guys_dead") && level.mortar_impacts < 1 && !utility::time_has_passed(start, 20)) {
    waitframe();
  }

  thread function_969bbc11772f239d();
  utility::flag_set("fallback_06");

  foreach(guy in getaiarray("axis")) {
    guy.attackeraccuracy = 10;
    guy notify("stop_stinger_system");
  }

  thread utility::flag_set_delayed("mortar_guys_timeout", 30);
}

function function_5e126b1dab9d8226() {
  level endon("hangar_a_start");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  wait 0.6;
  level thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_psh2_grav_groundteamyoureclear");
  level.farah dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh2_fara_copygroundteamispush");
  wait 1;
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh2_grav_gunnercoverthemintot");
  wait 0.5;
  level dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_psh2_grav_donotfireonthehangar");
  hangar_doorway = (-49481, 13705, 580);
  distthresholdsq = squared(500);

  while(!isalive(level.alex) || distance2dsquared(level.alex.origin, hangar_doorway) > distthresholdsq) {
    if(utility::flag("hangar_a_start")) {
      break;
    }

    wait 0.1;
  }

  level.alex dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_psh2_alex_groundteamsreachedha");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_ebd582a6d43c90a0() {
  wait 1;
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  level thread dialogue::say_team("dx_sp_jsgs_hngr_snav_gotthreatscomingouto");
  level thread dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_psh2_ssig_marking");
  level thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_grav_gunnerdonotletkonnig");
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh2_sgun_igotemcovered");
  utility::flag_wait("hangar_a_start");
  level.farah namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hngr_fara_shadow1firsthangaris");
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hbss_grav_copythat");

  if(flag("tower_rpg_dead") || level.var_ce37247e494d0064["barracks_tower_01"] getscriptablepartstate("base", 1) == "dead") {
    utility::flag_set("first_rocket_vo_started");
    utility::flag_set("first_rocket_vo_played");
    utility::flag_set("first_rocket_vo_finished");
    namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 20, 10);
  } else {
    start = gettime();
    function_2cf8d9055fdb957d();
    utility::flag_set("first_rocket_vo_started");
    utility::flag_set("first_rocket_vo_played");
    utility::flag_set("first_rocket_vo_finished");

    if(!time_has_passed(start, 10)) {
      namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 20, 0.3);
    }
  }

  level thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_shep_actualtogroundteamgi");
  level.alex thread dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hngr_alex_hangar1isadryholeact");
  level thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_shep_ourintelssolidmakaro");
  level.farah thread dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hngr_fara_copywellkeepsearchin");
  level.farah thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_fara_shadow1keepuscovered");
  level dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hngr_grav_werenotgoinanywherek");
  utility::flag_set("hanagr1_main_vo_done");
  wait 4;
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_2cf8d9055fdb957d() {
  level endon("tower_rpg_dead");
  utility::flag_wait("first_rocket_impact");
  level.price dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_pric_weretakingrpgfire", 0, [level, "tower_rpg_dead"]);
  level dialogue::function_fc0eb6b81c66c661(0.1, "dx_sp_jsgs_hngr_snav_rpglocatedtowersouth", 0, [level, "tower_rpg_dead"]);
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_shep_shadow1neutralizetho", 0, [level, "tower_rpg_dead"]);
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hbss_grav_copythat", 0, [level, "tower_rpg_dead"]);
  utility::flag_set("first_rocket_vo_finished");
}

function function_c28cd7d1c847837d() {
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  wait 1;
  sequence = [level.alex, "dx_sp_jsgs_hngr_alex_allstationsnegativeo", level, 0.4, "dx_sp_jsgs_hngr_shep_groundteampushtohang", level, 0.2, "dx_sp_jsgs_hngr_grav_rogergoldeaglewegoty", level.farah, 0.3, "dx_sp_jsgs_hngr_fara_copymovingtohangar2"];
  level dialogue::function_c9a09b3ba9c68f8d(0.3, sequence);
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_89e293116e82e620() {
  thread function_c0b5d552709a6c33();
  level endon("mortar_guys_dead");
  utility::flag_wait("mortar_guys_vo");
  level thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_snav_mortarfiresincomingf", 0, [level, "mortar_guys_dead"]);
  level thread dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_grav_gunnertargetthosemor", 0, [level, "mortar_guys_dead"]);

  while(level.mortar_impacts < 3) {
    level waittill("mortar_impact");
  }

  level.gaz dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_psh1_gazz_receivingfire", 0, [level, "mortar_guys_dead"]);
  level.farah dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_fara_shadow1takeoutthosem", 0, [level, "mortar_guys_dead"]);
  level.price dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_pric_nextonesgonnabeonus", 0, [level, "mortar_guys_dead"]);
}

function function_c0b5d552709a6c33() {
  flag_wait("mortar_guys_dead");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  level function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hngr_sgun_tookouttheirmortarte");
  level function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_shep_fuckingmakarovheddes");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_969bbc11772f239d() {
  level endon("mortar_guys_dead");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hngr_snav_enemymortarteamsonth");
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_veha_grav_trackthatfirewheresi");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function hangar_music() {
  setmusicstate("mx_gunship_hangar");
}

function function_d095d7859e66b5c6() {
  while(!isDefined(level.bunker_doors)) {
    waitframe();
  }

  level.bunker_doors[0].origin = level.bunker_doors[0].var_ea0acb97ce270747;
  level.bunker_doors[1].origin = level.bunker_doors[1].var_ea0acb97ce270747;
}

function jeta() {
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  namespace_6393a86f2fcda776::function_df5cd54ba46346ff(1);
  level.jet_01 thread function_460c5b37986f585a();
  utility::flag_set("jet_a_start");
  var_dcd7ef48218c479e = 7;
  utility::autosave_by_name("jetA");
  thread function_123fafbcd0712ff8();
  thread function_5927f144d926e354();
  wait 1;

  if(level.gameskill < 2) {
    utility::flag("player_boosted");
  }

  thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(16 + level.gameskill, "jet_1_dead", level.marker_locations["location_airstrip"], 3);
  level thread namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_psh1_grav_hitthatjetbeforeitsa", var_dcd7ef48218c479e + 1, "jet_1_dead");
  thread function_7105e88ec9181dc(var_dcd7ef48218c479e + 2.7, "jet_1_dead");
  namespace_6393a86f2fcda776::function_16c7809d73f2a8c6([level.bunker_doors[0], level.bunker_doors[1]], level.jet_01, var_dcd7ef48218c479e);
  namespace_6393a86f2fcda776::function_de001f4d27208780("hangar_group_01", 1);
  utility::flag_wait("jet_1_dead");
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  utility::flag_set("jet_a_end");
  utility::autosave_by_name("jet_a_end");
  namespace_6393a86f2fcda776::function_de001f4d27208780("jet_group_01", 1);
  wait 1;
  level thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh1_ssig_enemyjetdestroyed");
  level dialogue::function_fc0eb6b81c66c661(0.5, "dx_sp_jsgs_psh1_grav_weowntheskyshadows");
  wait 0.5;
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_123fafbcd0712ff8() {
  level endon("jet_1_dead");
  level.farah dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_psh1_fara_shadow1konniislaunch");
  level dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_psh1_grav_copykonnijet");
  level dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_psh1_ssig_markingtarget");
}

function function_7105e88ec9181dc(delay, ender) {
  level endon(ender);
  wait delay + 4;

  if(utility::flag(ender)) {
    return;
  }

  level dialogue::say_team("dx_sp_jsgs_psh1_grav_crewletsgetonit");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_oncehesintheairweret");
  wait 2;
  level dialogue::say_team("dx_sp_jsgs_psh1_snav_jetstakingoff");
  wait 0.8;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_gunnertakeoutthejet");
  wait 0.3;
  level dialogue::say_team("dx_sp_jsgs_psh1_snav_shootinfrontofhim");
  wait 2.5;
  level dialogue::say_team("dx_sp_jsgs_psh1_snav_enemyjetsintheair");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_prepforcontact");
  utility::flag_wait("jet_shot");
  level dialogue::say_team("dx_sp_jsgs_psh1_ssig_toolateenemymissiles");
  utility::flag_wait("jet_fail");
  level dialogue::say_team("dx_sp_jsgs_psh1_splt_werehitwerehitshadow");
}

function function_9cf20b763abbbdcf(var_702109be09e88feb, var_80985ee59a692443, var_c3146db58778226b, var_a5b30b656a1de824) {
  level.mortar_impacts = 0;
  utility::flag_clear("mortar_guy_breakout_watcher");
  utility::flag_clear("mortar_guys_run");
  utility::flag_clear("mortar_guys_dead");
  mortar_launcher = namespace_6393a86f2fcda776::function_14a55d42fe182d62(var_80985ee59a692443);
  var_45417c518154ec18 = utility::getStruct(var_702109be09e88feb, "targetname");
  guys = namespace_6393a86f2fcda776::function_de001f4d27208780(var_c3146db58778226b, 1, 1);
  guys[0].script_noteworthy = var_a5b30b656a1de824;
  thread function_e363bada0311c902(guys[0], guys[0].script_noteworthy, "mortar_guys_dead", 2);
  var_45417c518154ec18 function_b94de176af0d64ee(guys, mortar_launcher);
  var_45417c518154ec18 notify("stop_idle");
  guys = utility::array_removedead_or_dying(guys);
  utility::array_thread(guys, &anim_stopanimscripted);

  if(isDefined(var_45417c518154ec18.anim_props)) {
    foreach(prop in var_45417c518154ec18.anim_props) {
      if(isDefined(prop)) {
        prop anim_stopanimScripted();
      }
    }
  }

  if(isDefined(mortar_launcher)) {
    mortar_launcher delete();
  }

  utility::flag_set("mortar_guy_breakout_watcher");
  utility::flag_set("mortar_guys_run");
  utility::flag_set("mortar_guys_dead");
}

function function_4868dfa9a5d5ea06() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(337, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_05");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_hangar_b", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_hangar_b", level.farah, level.var_7ea643c0d786d48);
}

function function_dd509c2a4f4d7f4f() {
  namespace_6393a86f2fcda776::function_d8fbd5fda6bc8171("hangar_fail_2");
  spawner = getvehiclespawner("tower_tank", "targetname");
  start = gettime();

  while(function_62b8bb40735c58a2(ter_op(level.player utility::isads(), 0.992546, 0.965926), spawner.origin + (0, 0, 100), [spawner])) {
    if(utility::time_has_passed(start, 20)) {
      break;
    }

    wait 0.1;
  }

  thread function_628f39901439da1b();
  tank = vehicle::spawn_vehicle_from_targetname_and_drive("tower_tank");
  thread function_dc116d9569c8f46b(tank, "vehicles_a", "vehicle_a_end", 2, "tower_tank_start_shooting");
  utility::flag_wait_any_timeout(20, "tower_tank_intro_shots", "tower_tank_dead");
  utility::wait_for_flag_or_timeout("tower_tank_dead", 40);
  wait 0.1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 25, 90);
  utility::flag_set("vehicle_a_start");
  thread namespace_6393a86f2fcda776::opendoors([level.bunker_doors[4], level.bunker_doors[5]], 3, "vehicle_a_door_01_ready");
  vehicle_1 = vehicle::spawn_vehicle_from_targetname_and_drive("base_veh_01");
  vehicle_2 = vehicle::spawn_vehicle_from_targetname_and_drive("base_veh_02");
  wait 0.1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 25, 90);
  thread namespace_6393a86f2fcda776::opendoors([level.bunker_doors[6], level.bunker_doors[7]], 3, "vehicle_a_door_02_ready");
  vehicle_3 = vehicle::spawn_vehicle_from_targetname_and_drive("base_veh_03");
  vehicle_4 = vehicle::spawn_vehicle_from_targetname_and_drive("base_veh_04");
  wait 0.1;
  utility::flag_set("flares_enabled");
  thread function_b2dda853004dd7c0();
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_05", 60);
  wait 0.1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 22, 90);
  wait 1;
  thread function_5b6c1253866cb406();
  heli_1 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("heli_01");
  heli_2 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("heli_02");
  utility::flag_set("heli_wave_1_spawn");
  utility::autosave_by_name("heli_wave_1_spawn");
  thread stingergroup1(heli_1, heli_2);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 10, 300);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
  utility::flag_set("vehicle_a_end");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
  threats = getaiarray("axis");

  foreach(threat in threats) {
    threat.attackeraccuracy = 10;
  }

  if(isDefined(level.marker_locations["stingers_a"])) {
    level.marker_locations["stingers_a"].var_caa61c143b86da98 = 1;
  }

  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(2);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  utility::autosave_by_name("vehicles_b_start");
}

function function_5b6c1253866cb406() {
  level waittill("heli_killed");
  level waittill("heli_killed");
  level dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_psh1_grav_iceinyourdamnveinsgu");
}

function function_aecf12ea5f4057fc() {
  utility::flag_set("vehicle_a_start");
  utility::flag_set("flares_enabled");
}

function function_628f39901439da1b() {
  level endon("vehicle_a_end");
  utility::wait_for_flag_or_timeout("tower_tank_intro_shots", 20);
  wait 3;
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);

  if(!utility::flag("tower_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_snav_enemytanknorthsideof", 1, "tower_tank_dead");
  }

  if(!utility::flag("tower_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_shep_shadow1donotletthatt", 1, "tower_tank_dead");
  }

  if(!utility::flag("tower_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_gunneryouheardtheman", 1, "tower_tank_dead");
  }

  if(!utility::flag("tower_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_dropamissileonthatfu", 1, "tower_tank_dead");
  }

  if(!utility::flag("tower_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_snav_itswheretheradiotowe", 1, "tower_tank_dead");
  }

  utility::flag_wait("tower_tank_dead");
  wait 0.5;
  level dialogue::say_team("dx_sp_jsgs_veha_ssig_enemytanksdestroyed");
  wait 0.4;
  level dialogue::say_team("dx_sp_jsgs_veha_grav_itneverhadachancegoo");
  wait 2;
  level dialogue::say_team("dx_sp_jsgs_veha_snav_enemyvehiclestotheno");
  wait 0.5;
  level dialogue::say_team("dx_sp_jsgs_veha_ssig_copymarking");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_veha_grav_gunnertargetthoseveh");
  wait 0.5;
  level dialogue::say_team("dx_sp_jsgs_veha_snav_theyrepushingtohanga");
  utility::flag_wait("heli_wave_1_spawn");
  level dialogue::say_team("dx_sp_jsgs_veha_snav_enemyhelostakingofff");
  wait 0.5;
  level dialogue::say_team("dx_sp_jsgs_veha_ssig_igotemhelosmarked");
  wait 0.4;
  level dialogue::say_team("dx_sp_jsgs_veha_grav_gunnerknockthosebird");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function stingergroup1(heli_1, heli_2) {
  level endon("vehicle_a_end");

  if(isDefined(heli_1) && isDefined(heli_2)) {
    function_f5e6e44d950cdf06(heli_1, heli_2);
  }

  utility::wait_for_flag_or_timeout("tower_tank_dead", 30);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 32, 300);
  callouts[0] = "dx_sp_jsgs_rtwr_snav_missilesincoming";
  callouts[1] = "dx_sp_jsgs_veha_ssig_stingersbytheatctowe";
  callouts[2] = "dx_sp_jsgs_veha_ssig_stingerthreatsstilla";
  callouts[3] = "dx_sp_jsgs_rtwr_snav_incoming";
  callouts[4] = "dx_sp_jsgs_veha_ssig_justacrossfromhangar";
  guys = function_de001f4d27208780("veh_stinger_01_guys", 1, 1);
  guy = namespace_6393a86f2fcda776::function_ccf479c366a9220a("veh_stinger_01", 1, callouts, guys);
  thread function_53b36d5d0e930e1d(guy, "stingers_a", "vehicle_a_end", 3);
  guy waittill("death");
  level thread namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_goodhitstingerdown", 0.5);
  wait 3;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 32, 300);
  callouts[0] = "dx_sp_jsgs_rtwr_ssig_enemymissile";
  callouts[1] = "dx_sp_jsgs_veha_ssig_stingerthreatisstill";
  callouts[2] = "dx_sp_jsgs_veha_ssig_itsbythetents";
  callouts[3] = "dx_sp_jsgs_hngr_grav_incoming";
  callouts[4] = "dx_sp_jsgs_veha_ssig_westsideofthebase";
  guys = function_de001f4d27208780("veh_stinger_02_guys", 1, 1);
  guy = namespace_6393a86f2fcda776::function_ccf479c366a9220a("veh_stinger_02", 1, callouts, guys);
  thread function_53b36d5d0e930e1d(guy, "stingers_a", "vehicle_a_end", 3);
  guy waittill("death");

  if(isDefined(level.marker_locations["stingers_a"])) {
    level.marker_locations["stingers_a"].var_caa61c143b86da98 = 1;
  }

  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_goodhitstingerdown", 0.5);
}

function function_f5e6e44d950cdf06(heli_1, heli_2) {
  heli_1 endon("death");
  heli_2 endon("death");
  self endon("stingerGroup1_timeout");
  childthread utility::notify_delay("stingerGroup1_timeout", 15);
  utility::waittill_any_ents_return(heli_1, "unloading", heli_2, "unloading", heli_1, "unloaded", heli_2, "unloaded");
}

function function_b2dda853004dd7c0() {
  level endon("vehicle_a_end");
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 21, 45);
  namespace_6393a86f2fcda776::function_de001f4d27208780("reinforcement_group_02", 1);
}

function function_d2193a499376c47d() {
  wait 0.1;

  if(!isDefined(level.heros)) {
    return;
  }

  allies = getaiarray("allies");
  guys = utility::array_remove_array(allies, level.heros);

  foreach(guy in guys) {
    guy delete();
  }
}

function function_74ceee896d6a0e13() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(250, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_05");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_hangar_b", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_hangar_b", level.farah, level.var_7ea643c0d786d48);
  thread namespace_6393a86f2fcda776::function_d8fbd5fda6bc8171("hangar_fail_2");
}

function function_26c8449412809784() {
  while(!isDefined(level.bunker_doors)) {
    waitframe();
  }

  thread function_aab539ade098a8a8();
  thread namespace_6393a86f2fcda776::opendoors([level.bunker_doors[14], level.bunker_doors[15]], 3, "tank_b_door_ready");
  tank = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_tank");
  thread function_dc116d9569c8f46b(tank, "vehicles_b", "vehicle_b_end", 2, "bunker_tank_start_shooting");
  utility::flag_wait_any_timeout(20, "bunker_tank_intro_shots", "bunker_tank_dead");
  wait 0.1;
  utility::wait_for_flag_or_timeout("bunker_tank_dead", 7);
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 25, 90);
  utility::flag_set("vehicle_b_start");
  thread namespace_6393a86f2fcda776::opendoors([level.bunker_doors[8], level.bunker_doors[9]], 3, "vehicle_b_door_01_ready");
  vehicle_1 = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_a_veh_01");
  vehicle_2 = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_a_veh_02");
  wait 0.1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 25, 90);
  thread namespace_6393a86f2fcda776::opendoors([level.bunker_doors[10], level.bunker_doors[11]], 3, "vehicle_b_door_02_ready");
  vehicle_3 = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_a_veh_03");
  vehicle_4 = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_a_veh_04");
  wait 0.1;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 23, 90);
  thread namespace_6393a86f2fcda776::opendoors([level.bunker_doors[12], level.bunker_doors[13]], 3, "vehicle_b_door_03_ready");
  vehicle_5 = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_a_veh_05");
  vehicle_6 = vehicle::spawn_vehicle_from_targetname_and_drive("bunker_a_veh_06");
  wait 0.1;
  thread function_d4d89695a66db22b();
  wait 5;
  thread function_d175f9d8365a64();
  thread jetb();
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 5, 300);
  utility::flag_set("vehicle_b_end");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);

  if(isDefined(level.marker_locations["stingers_b"])) {
    level.marker_locations["stingers_b"].var_caa61c143b86da98 = 1;
  }

  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(2);
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  function_f57f7be04dc8a0d9();
  utility::autosave_by_name("vehicles_a_end");
}

function function_53e174eafac9d865() {
  utility::flag_set("jet_2_dead");
  utility::flag_set("vehicle_b_start");
  utility::flag_set("vehicle_b_end");
}

function function_aab539ade098a8a8() {
  level endon("vehicle_b_end");
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  function_f6977ee2e5f11d22();
  wait 0.5;
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_grav_quicktriggeriloveit", 0.2, "bunker_tank_dead");
  utility::flag_wait("vehicle_b_start");
  level.farah namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_fara_gravesenemyvehiclesi", 0.5);
  level.gaz namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_gazz_theyrepushinginthrou", 0.5);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_grav_konnismountingupforr", 1);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_lote_shep_thisiskonnisfoothold", 0.3);
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_f6977ee2e5f11d22() {
  level endon("bunker_tank_dead");
  utility::wait_for_flag_or_timeout("bunker_tank_intro_shots", 20);

  if(!utility::flag("bunker_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_gazz_enemytanksdirectlyto", 0.5, "bunker_tank_dead");
  }

  if(!utility::flag("bunker_tank_dead")) {
    level.farah namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_fara_shadowdontletthattan", 0.5, "bunker_tank_dead");
  }

  wait 2;

  if(!utility::flag("bunker_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_grav_youknowwhattodogunne", 0.6, "bunker_tank_dead");
  }

  wait 3;

  if(!utility::flag("bunker_tank_dead")) {
    level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_grav_hitemwithamissile", 0.5, "bunker_tank_dead");
  }

  utility::flag_wait("bunker_tank_dead");
}

function function_d175f9d8365a64() {
  level endon("vehicle_b_end");
  utility::flag_wait("jet_2_dead");
  wait 8;
  callouts[0] = "dx_sp_jsgs_veha_ssig_shitmissileincoming";
  callouts[1] = ["dx_sp_jsgs_vehb_fara_gravesenemystingersi", level, 0.3, "dx_sp_jsgs_rtwr_grav_gunnergetonit"];
  callouts[2] = "dx_sp_jsgs_vehb_snav_incomingmissile";
  callouts[3] = "dx_sp_jsgs_vehb_fara_northwestcorner";
  callouts[4] = "dx_sp_jsgs_veha_fara_shadowhitthosefuckin";
  callouts[5] = "dx_sp_jsgs_vehb_ssig_wherethefuckdidthatc";
  guys = function_de001f4d27208780("veh_stinger_03_guys", 1, 1);
  guy = namespace_6393a86f2fcda776::function_ccf479c366a9220a("veh_stinger_03", 1, callouts, guys);
  thread function_53b36d5d0e930e1d(guy, "stingers_b", "vehicle_b_end", 3);

  if(isDefined(guy)) {
    guy waittill("death");
  }

  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_goodhitstingerdown", 0.2);
  wait 4;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 32, 300);
  callouts[0] = "dx_sp_jsgs_vehb_snav_incomingmissile";
  callouts[1] = "dx_sp_jsgs_vehb_grav_gunnerenemymissileso";
  callouts[2] = "dx_sp_jsgs_veha_ssig_westsideofthebase";
  callouts[3] = "dx_sp_jsgs_vehb_grav_putthatmissileintheg";
  callouts[4] = "dx_sp_jsgs_veha_grav_gunnertakeoutthatmis";
  guys = function_de001f4d27208780("veh_stinger_04_guys", 1, 1);
  guy = namespace_6393a86f2fcda776::function_ccf479c366a9220a("veh_stinger_04", 1, callouts, guys);
  thread function_53b36d5d0e930e1d(guy, "stingers_b", "vehicle_b_end", 3);

  if(isDefined(guy)) {
    guy waittill("death");
  }

  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_goodhitstingerdown", 0.2);
  wait 2;
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 32, 300);
  guy = function_efbac3fa68600dca();

  if(isDefined(guy)) {
    thread function_53b36d5d0e930e1d(guy, "stingers_b", "vehicle_b_end", 3);
    guy waittill("death");
  }

  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_veha_grav_goodhitstingerdown", 0.2);

  if(isDefined(level.marker_locations["stingers_b"])) {
    level.marker_locations["stingers_b"].var_caa61c143b86da98 = 1;
  }

  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
}

function function_efbac3fa68600dca(callouts) {
  callouts[0] = "dx_sp_jsgs_vehb_alex_enemystingerfiringfr";
  callouts[2] = "dx_sp_jsgs_vehb_snav_stingermissilesincom";
  callouts[4] = "dx_sp_jsgs_vehb_grav_focusfireonthatmissi";
  var_dc4c4c1f1d8f39["tank_1"] = "veh_stinger_05_a";
  var_dc4c4c1f1d8f39["tank_2"] = "veh_stinger_05_b";
  var_dc4c4c1f1d8f39["tank_3"] = "veh_stinger_05_c";
  var_dc4c4c1f1d8f39["tank_4"] = "veh_stinger_05_d";
  var_dc4c4c1f1d8f39["tank_5"] = "veh_stinger_05_e";

  foreach(i, tank in level.fueltanks) {
    if(tank getscriptablepartstate("base", 1) == "pristine") {
      guys = namespace_6393a86f2fcda776::function_de001f4d27208780(var_dc4c4c1f1d8f39[i] + "_guys", 1, 1);
      guy = namespace_6393a86f2fcda776::function_ccf479c366a9220a(var_dc4c4c1f1d8f39[i], 1, callouts, guys);
      tank.guys = utility::array_add(guys, guy);

      foreach(guy in tank.guys) {
        guy.var_7811134668469758 = 1;
        guy.var_e169a98f19389f0d = 1;
      }

      return guy;
    }
  }
}

function function_d4d89695a66db22b() {
  level endon("vehicle_b_end");
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 23, 45);
  namespace_6393a86f2fcda776::function_de001f4d27208780("reinforcement_group_02", 1);
}

function jetb() {
  wait 16;
  utility::wait_for_flag_or_timeout("bunker_tank_dead", 90);
  volume = getEnt("runway_2_volume", "targetname");

  if(isDefined(volume)) {
    start = gettime();

    while(volume utility::get_ai_touching_volume("axis").size > 2 && !utility::time_has_passed(start, 5)) {
      waitframe();
    }
  }

  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  utility::autosave_by_name("jetB");
  namespace_6393a86f2fcda776::function_df5cd54ba46346ff(0);
  wait 3;
  level.jet_02 thread function_460c5b37986f585a();
  level.alex thread namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_vehb_alex_shadow1beadviseddoor");
  level thread namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_psh1_snav_enemyjetscominfromth", 2);
  utility::flag_set("jet_b_start");
  var_dcd7ef48218c479e = 7;
  level.marker_locations["location_airstrip"].marker_ent.origin = level.jet_02.origin;
  thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(16 + level.gameskill, "jet_2_dead", level.marker_locations["location_airstrip"], 3);
  thread function_8d9dc7cdc03ea9ed(var_dcd7ef48218c479e + 2.7, "jet_2_dead");
  namespace_6393a86f2fcda776::function_16c7809d73f2a8c6([level.bunker_doors[2], level.bunker_doors[3]], level.jet_02, var_dcd7ef48218c479e);
  thread function_b48196c0c5ad68();
  utility::flag_wait("jet_2_dead");
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(3);
  utility::flag_set("jet_b_end");
  utility::autosave_by_name("jet_b_end");
  sequence = [level, "dx_sp_jsgs_vehb_grav_thatsrightmotherfuck", level, 0.3, "dx_sp_jsgs_vehb_snav_jetnumbertwoisdown"];
  wait 0.6;
  function_c9a09b3ba9c68f8d(0.4, sequence);
  namespace_6393a86f2fcda776::function_b8133e9adfa151db(0);
}

function function_5927f144d926e354() {
  setmusicstate("mx_gunship_shootdown");
}

function function_460c5b37986f585a() {
  soundent = spawn_tag_origin();
  soundent playSound("scn_jup_gunship_radio_hangar_air_siren", "sounddone");
  soundent waittill("sounddone");
  soundent delete();
}

function function_8d9dc7cdc03ea9ed(delay, ender) {
  level endon(ender);
  wait delay + 1;

  if(utility::flag(ender)) {
    return;
  }

  level dialogue::say_team("dx_sp_jsgs_psh1_grav_crewletsgetonit");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_oncehesintheairweret");
  wait 2;
  level dialogue::say_team("dx_sp_jsgs_psh1_snav_jetstakingoff");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_gunnertakeoutthejet");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_psh1_snav_shootinfrontofhim");
  wait 6.5;
  level dialogue::say_team("dx_sp_jsgs_psh1_snav_enemyjetsintheair");
  wait 1;
  level dialogue::say_team("dx_sp_jsgs_psh1_grav_prepforcontact");
  utility::flag_wait("jet_shot");
  level dialogue::say_team("dx_sp_jsgs_psh1_ssig_toolateenemymissiles");
  utility::flag_wait("jet_fail");
  level dialogue::say_team("dx_sp_jsgs_psh1_splt_werehitwerehitshadow");
}

function function_b48196c0c5ad68() {
  level endon("fallback_07");
  namespace_6393a86f2fcda776::function_a44e35e2dc63be50("axis", 23, 45);
  namespace_6393a86f2fcda776::function_de001f4d27208780("jet_group_02", 1);
}

function function_f57f7be04dc8a0d9(var_219f0ffcf6134e3f) {
  utility::flag_set("hangar_fallback");
  structs = utility::getStructArray("final_fallback", "targetname");

  if(!isDefined(structs) || structs.size < 1) {
    return;
  }

  guys = getaiarray("axis");

  foreach(guy in guys) {
    if(istrue(guy.var_1037ba191c5d4b5f) || istrue(var_219f0ffcf6134e3f) && guy scripts\vehicle\vehicle_common::hasvehicle()) {
      continue;
    }

    guy.attackeraccuracy = 10;
    guy notify("stop_stinger_system");
    guy.var_1037ba191c5d4b5f = 1;
    structs = sortbydistance(structs, guy.origin);
    guy thread spawner::go_to_node(structs[0]);
  }
}

function function_439b3c3f9f86bda6() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(70, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_05");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_hangar_b", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_hangar_b", level.farah, level.var_7ea643c0d786d48);
  allies = getaiarray("allies");

  foreach(guy in allies) {
    guy.ignoreall = 1;
  }
}

function function_a2baed273d36862c() {
  wait 2;
  setmusicstate("mx_gunship_heli");
}

function function_ff6d0826f03fca6f() {
  var_c11474a64e25ae33 = getEnt("hangar_2_doorClip", "targetname");

  if(isDefined(var_c11474a64e25ae33)) {
    var_c11474a64e25ae33 connectpaths();
  }

  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  function_e591c181cc8bbe15();
  function_f57f7be04dc8a0d9(1);
  spawner = getvehiclespawner("boss_heli", "targetname");
  start = gettime();

  while(function_62b8bb40735c58a2(ter_op(level.player utility::isads(), 0.992546, 0.965926), spawner.origin + (0, 0, 100), [spawner])) {
    if(utility::time_has_passed(start, 20)) {
      break;
    }

    wait 0.1;
  }

  thread function_c62fe3ea81a1c129();
  thread function_a2baed273d36862c();
  function_68e133f68de59880();
  level notify("stop_hangarB_evn_fail");
  level notify("stop_threatFailWatcher");
  level notify("stop_threatWarningWatcher");
  thread outro_music();

  foreach(hangar in level.hangar_b) {
    hangar namespace_6393a86f2fcda776::function_89470cfc7215663d();

    if(!issubstr(hangar.model, "jup_urz_building_airstrip_hangar_01_top")) {
      continue;
    }

    hangar thread function_274ae6b56829365e();
  }

  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hbss_grav_gothisassthatswhatim");
  level dialogue::function_fc0eb6b81c66c661(0.4, "dx_sp_jsgs_hbss_grav_allstationsenemybird");
  utility::flag_set("hangar_b_end");
  utility::activate_trigger_with_noteworthy("allies_push_trigger_08");
  level.farah dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hbss_fara_copythatchemicalsren");
  thread utility::flag_set_delayed("hangar_b_clear_enough", 2);

  if(!flag("hangar_b_death")) {
    wait 0.5;

    if(!flag("hangar_b_death")) {
      level.player say_team("dx_sp_jsgs_hbss_shep_gravesoncegroundteam");
    }
  }

  function_cfe79a1b99902de3();
  utility::flag_set("hangar_clear");
  utility::flag_set("hangar_b_clear");

  if(!flag("hangar_b_death")) {
    level.farah thread namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_fara_shadow1groundteamisc", 0.3);
    level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hbss_grav_copythat");

    if(!isDefined(level.cruise_missile) && !flag("hangar_b_death")) {
      level thread dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hbss_grav_gunnersendit");
    }

    thread namespace_6393a86f2fcda776::function_a0c8c1ef427bbe93(15, "hangar_b_death", level.marker_locations["location_hangar_b"], 1, 1);
    thread utility::display_hint("weapon_swap", 10, 1);
    utility::flag_wait("hangar_b_death");
  }

  thread function_6baf3cf5ee6efba0();
  sequence = [level, 0.5, "dx_sp_jsgs_hbss_ssig_goodeffecthangarsdow", level, "dx_sp_jsgs_hbss_grav_thatshowwegetitdones", level, 0.7, "dx_sp_jsgs_hbss_grav_dosvidonyavladimir"];
  thread dialogue::function_c9a09b3ba9c68f8d(0.5, sequence);
  wait 4;
  namespace_6393a86f2fcda776::function_e57fc58ce189fa88(1);
}

function outro_music() {
  setmusicstate("mx_gunship_outro");
}

function function_3bbc2c6c7f9c419c() {
  utility::flag_set("clear_hangar_timeout");
  utility::flag_set("heli_dead");
  utility::flag_set("hangar_clear");
  utility::flag_set("hangar_b_death");
  level notify("stop_hangarB_evn_fail");
  level notify("stop_threatFailWatcher");
  level notify("stop_threatWarningWatcher");
}

function function_e591c181cc8bbe15() {
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_shep_allstationsthisisact");
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_shep_groundteamareyouread", 0.2);
  level.farah dialogue("dx_sp_jsgs_hbss_fara_negativechemicalsare", 0.3);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_shep_copythatkeepemsecure", 0.2);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_shep_gravesmaintainoverwa", 0.3);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_grav_checkshadow1sreadyan", 0.2);
}

function function_c62fe3ea81a1c129() {
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_snav_enemyhelosincomingfr", 4);
  utility::flag_set("heli_boss_marked");
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_shep_thatsmakarov", 0.3);
  level dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_jsgs_hbss_shep_shadowgunthatsonofab");
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_grav_copythathesnotgoinan", 0.2);
  level namespace_6393a86f2fcda776::dialogue("dx_sp_jsgs_hbss_grav_timetofinishthisshad", 0.4);
  level dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hbss_snav_copythat");
  level.player dialogue::function_fc0eb6b81c66c661(0.2, "dx_sp_jsgs_hbss_sgun_gunsready");
}

function function_cfe79a1b99902de3() {
  thread utility::flag_set_delayed("clear_hangar_timeout", 30);
  level endon("clear_hangar_timeout");
  level endon("hangar_b_death");
  utility::flag_wait_all("hangar_b_exit_a", "hangar_b_exit_b");
}

function function_68e133f68de59880() {
  level.var_9e1ae3102c095174 = 0;
  namespace_6393a86f2fcda776::function_d7b6d94ded0800b6();
  level.var_9e1ae3102c095174 = 1;
}

function function_274ae6b56829365e() {
  for(;;) {
    state = self getscriptablepartstate("base", 1);

    if(state == "dead") {
      break;
    }

    waitframe();
  }

  thread utility::flag_set_delayed("hangar_b_death", 1);
}

function function_ca7d885d7ba14570() {
  namespace_6393a86f2fcda776::setup_gunship(150, 18000, 26000, 205);
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
}

function function_eac54160d832c929() {
  threats = getaiarray("axis");

  foreach(threat in threats) {
    if(istrue(threat.magic_bullet_shield)) {
      threat scripts\common\ai::stop_magic_bullet_shield();
    }

    threat delete();
  }

  level.stinger_missiles = utility::array_removeundefined(level.stinger_missiles);

  foreach(missile in level.stinger_missiles) {
    missile utility::ent_flag_init("missile_pairedWithFlare");
    missile delete();
  }

  namespace_6393a86f2fcda776::function_b8133e9adfa151db(1);
  level.var_a94a30a9834279af = 1;
  wait 1;
  hud_util::fade_out(2);
  utility::flag_set("igc_start");

  if(level.start_point == "<dev string:x3e>") {
    wait 0.5;
  }

  level.player scripts\sp\player::focusdisable();
  stopallrumbles();

  if(isDefined(level.cruise_missile)) {
    level notify("kill_cruise_missile_scripts");
    level.cruise_missile thread function_dd9dedb2a8fcfb6f();
    level.cruise_missile delete();
  }

  function_7d25e483cf645ef9(1);
  level.player lerpfovscalefactor(1, 0);
  level.player modifybasefov(65, 0);
  level.player lerpfov(65, 0);
  level notify("stopPlayerAdsForMarkers");
  setsaveddvar(@ "waypointtweaky", -17);
  wait 1;
  flag_set("igc_start");
  level.player setsoundsubmix("sp_mix_plr_vo_mute", 0.05);
  level.player setsoundsubmix("sp_mix_scripted1_mute", 0.05);
  level.gunship namespace_fd9c6daa1372e62b::gunship_returnplayer(level.player);
  level.gunship namespace_fd9c6daa1372e62b::gunship_removeplane(0);
  delaythread(0.2, &hud_util::fade_in, 0);
  level utility::play_skippable_cinematic("sp_jup_gunship_cine_outro", undefined, undefined, 0, 1);
  level.player clearsoundsubmix("sp_mix_plr_vo_mute", 0.05);
  level.player clearsoundsubmix("sp_mix_scripted1_mute", 0.05);
  level.player clearsoundsubmix("sp_mix_plr_foley_mute", 0.05);
  level.player clearsoundsubmix("sp_jup_gunship_mix", 0.05);
  utility::nextmission();
  level waittill("hfo");
}

function function_6baf3cf5ee6efba0() {
  setmusicstate("mx_gunship_outro_end");
}

function function_c11d92f684da2ca6() {}

function function_7d25e483cf645ef9(toggle) {
  if(istrue(toggle)) {
    level.player setclientomnvar("ui_hide_hud", 1);
    level.player setclientomnvar("ui_killstreak_controls", 0);
    level.player setclientomnvar("ui_predator_missile", 0);
    setomnvar("ui_out_of_bounds_countdown", 0);
    level.player hidehud();
    return;
  }

  level.player setclientomnvar("ui_hide_hud", 0);
  level.player setclientomnvar("ui_killstreak_controls", 9);
  level.player showhud();
}

function function_700130a517ceae37() {
  namespace_6393a86f2fcda776::spawnallies();
  namespace_6393a86f2fcda776::setup_gunship(300, 18000, 26000, 205, 1);
  focus_struct = utility::getStruct("gunship_focus_2", "targetname");
  level.var_dc44706239201a43 = focus_struct.origin;
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_02");
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_price_hangar_b", level.price, level.var_2641282ffbf1363d);
  namespace_6393a86f2fcda776::function_5953613468fbd36d("team_farah_hangar_b", level.farah, level.var_7ea643c0d786d48);
  function_d2193a499376c47d();
  allies = getaiarray("allies");

  foreach(guy in allies) {
    guy.ignoreall = 0;
    guy.ignoreme = 0;
  }

  level.var_9e1ae3102c095174 = 1;
  function_ef1928c930407fff();
  level waittill("hfo");
}

function function_76e4b531d9548ef() {
  namespace_6393a86f2fcda776::setup_gunship(110, 18000, 26000, 205);
  level.var_c944986665da028e = 0;
  utility::flag_set("hangar_a_clear");
  utility::flag_set("heli_dead");
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_05");
}

function function_7c03766c30329d11() {
  hud_util::fade_out(0);
  level.player freezecontrols(1);
  level.player hidehud();
  thread intro_vfx();
  wait 1;
  level.player freezecontrols(0);
  delaythread(0.2, &hud_util::fade_in, 0);
  namespace_6393a86f2fcda776::setup_gunship(280, 18000, 26000, 205, 0, 0);
  level.var_5a3f504f0ddbd74f = 0;
  focus_struct = utility::getStruct("gunship_focus_1", "targetname");
  level.var_dc44706239201a43 = focus_struct.origin;
  namespace_6393a86f2fcda776::spawn_gunship("gunship_airstrip");
  thread namespace_6393a86f2fcda776::function_64c1adb77a60445c("gunship_spot_01");
}