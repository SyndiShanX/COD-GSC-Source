/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\ja_mining\ja_mining.gsc
***************************************************/

main() {
  scripts\sp\utility::_id_116CB("ja_mining");
  _id_10AE::_id_A0AB();
  scripts\sp\maps\ja_mining\gen\ja_mining_art::main();
  scripts\sp\maps\ja_mining\ja_mining_fx::main();
  scripts\sp\maps\ja_mining\ja_mining_precache::main();
  scripts\sp\maps\ja_mining\ja_mining_anim::main();
  scripts\engine\utility::flag_init("heat_death_dmg1");
  scripts\engine\utility::flag_init("heat_death_dmg2");
  scripts\engine\utility::flag_init("heat_death_dmg3");
  scripts\engine\utility::flag_init("start_heat_death_timer");
  scripts\engine\utility::flag_init("show_rally_point");
  scripts\engine\utility::flag_init("launch_area_clear");
  scripts\engine\utility::flag_init("launch_started");
  scripts\engine\utility::flag_init("launch_boost");
  scripts\engine\utility::flag_init("flag_heatfx_triggered");
  scripts\engine\utility::flag_init("heat_death_started");
  scripts\sp\utility::_id_F343("equipment_select");
  scripts\sp\utility::_id_1749("launch", ::_id_10C98, "launch", ::_id_B209);
  scripts\sp\utility::_id_1749("mission_complete", ::_id_10CAE, "mission_complete", ::_id_B20F);
  scripts\sp\utility::_id_1749("test_death", ::_id_10C98, "test_death", ::_id_B209);
  scripts\sp\load::main();
  scripts\sp\utility::_id_241F(0);
  _id_10AE::_id_9637();
  _id_10AE::_id_1C44();
  _id_A045();
  scripts\engine\utility::delaythread(0.05, _id_10AE::_id_F2D3, ::_id_A046);
  setsaveddvar("r_transShadowEnable", 1);
  setsaveddvar("r_heightfieldSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 29.6);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
  setsaveddvar("r_sunShadowParams", "0 0 160 0");
  level._id_118CF = [[480, 45, 8, 6, 3.6], [360, 45, 10, 8, 4.8], [300, 45, 10, 8, 4.8], [260, 45, 10, 8, 4.8], [45, 45, 10, 8, 4.8]];
  scripts\sp\utility::_id_16EB("start_launch", &"JACKAL_LAUNCH_ATMO_PRIME", ::_id_900C);
  scripts\sp\utility::_id_16EB("move_clear", &"JACKAL_LAUNCH_ATMO_NOT_CLEAR", ::_id_9006);
  _id_1DE7();
  setglobalsoundcontext("atmosphere", "space", 1);
}

_id_A046() {
  var_0 = 100;
  var_1 = 20;
  var_2 = 34;
  level._id_11912 = level._id_7683;
  var_3 = level._id_118CF[level._id_11912][0] * 1000;
  var_4 = 2.0;
  var_5 = 1.0;
  var_6 = var_3 / (10 * var_5 + 5 * var_4);
  var_7 = var_6 * (var_4 / var_5);
  var_8 = 0;

  for(;;) {
    var_9 = ["player_completed_objective", "player_killed_enemyskelter", "player_killed_enemyace"];
    var_10 = scripts\engine\utility::waittill_any_in_array_return(var_9);
    var_11 = 0;

    if(var_10 == "player_completed_objective")
      var_11 = 1;
    else if(var_10 == "player_killed_enemyskelter")
      var_8 = var_8 + var_1;
    else if(var_10 == "player_killed_enemyace")
      var_8 = var_8 + var_2;

    if(var_8 >= var_0)
      var_11 = 1;

    if(var_11) {
      level._id_A3A8["skelters"]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8["skelters"]._id_FE2D);
      level._id_A3A8["aces"]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8["aces"]._id_FE2D);
      var_12 = level._id_A3A8["skelters"]._id_FE2D.size;
      var_13 = level._id_A3A8["aces"]._id_FE2D.size;
      var_14 = var_12 * var_6 + var_13 * var_7;

      if(var_12 == 0 && var_13 == 0) {
        return;
      }
      if(_id_7A01() >= var_14) {
        thread scripts\sp\utility::_id_2669("ja_autosave");
        var_8 = 0;
      }
    }
  }
}

_id_A045() {
  var_0 = spawnStruct();
  var_0.origin = (0, 0, -300000);
  playFX(scripts\engine\utility::getfx("sun_sprite"), var_0.origin, (-1, 0, 0), (0, 0, -1));
  thread scripts\engine\utility::play_loopsound_in_space("emt_ja_asteroid_sun", (2925, -1020, -100451));
  thread _id_10AE::_id_104D0("debris_cloud_struct", "vfx_space_debris_field_embers");
  thread _id_10AE::_id_104D0("asteroid_debris_struct", "vfx_ja_space_asteroid_debris");
}

_id_900C() {
  if(scripts\engine\utility::flag("launch_started") || !scripts\engine\utility::flag("launch_area_clear"))
    return 1;

  return 0;
}

_id_9006() {
  if(scripts\engine\utility::flag("launch_started") || scripts\engine\utility::flag("launch_area_clear"))
    return 1;

  return 0;
}

_id_10C98() {}

_id_B209() {
  _id_10AE::_id_D7C9();
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  var_0 thread _id_10AE::_id_57C4("player_spline_intro", 300, 8, 2.3);
  scripts\engine\utility::flag_wait("intro_start");
  enable_player_jackal_ignoreme(1);
  thread _id_111D3();
  scripts\engine\utility::delaythread(0.5, _id_10AE::_id_CE81, ::_id_AAA1);
  scripts\engine\utility::noself_delaycall(3.4, ::setmusicstate, "mx_237_ja_mining");
  scripts\engine\utility::flag_wait("intro_hold_on_black_done");
  thread _id_10626();
  thread _id_10AE::_id_57A7("aces", "sdf_ace", 5, undefined, ::_id_155F);
  thread _id_10AE::_id_57AA("skelters", "axis_arena_jackals", 10, undefined, ::_id_10237);
  thread _id_10AE::_id_56B3("aces", "jackal_objective_aces", 1, &"JACKAL_OBJECTIVE_ACES_MENU");
  thread _id_10AE::_id_56B3("skelters", "jackal_objective_skelters", 0, &"JACKAL_OBJECTIVE_SKELTERS_MENU");
  scripts\engine\utility::flag_wait("intro_done");
  scripts\engine\utility::delaythread(0.5, ::enable_player_jackal_ignoreme, 0);
  thread _id_1562();
  thread _id_C505();
  thread _id_12E24();
  scripts\engine\utility::flag_wait("acescomplete");
  scripts\engine\utility::flag_wait("skelterscomplete");

  if(scripts\engine\utility::flag("heat_death_started"))
    scripts\engine\utility::flag_waitopen("heat_death_started");
  else
    _id_F3FE(40);

  level notify("stop_heat_nags");
  scripts\engine\utility::flag_wait("acescomplete_vo_finished");
  scripts\engine\utility::flag_wait("skelterscomplete_vo_finished");
}

enable_player_jackal_ignoreme(var_0) {
  level._id_D127.ignoreme = var_0;
}

_id_10626() {
  _id_10AE::_id_5768("intro_jackals", "intro_jackal", 5, 1);
  _id_10AE::_id_5768("salter_jackal", "salter_jackal", 1, 1);
  level._id_EAD6 = level._id_A3A8["salter_jackal"].jackals._id_FE2D[0];
  level._id_EAD6 _id_0BDC::_id_1998();
}

_id_118D6() {
  level.player notifyonplayercommand("dpadup", "+actionslot 1");
  level.player waittill("dpadup");
  iprintlnbold("heat time padding 400");
  _id_F3FE(400);
}

_id_C505() {
  for(;;) {
    var_0 = ["skelterscomplete_vo_finished", "acescomplete_vo_finished"];
    var_1 = level scripts\engine\utility::waittill_any_return(var_0[0], var_0[1]);
    var_2 = [];

    foreach(var_4 in var_0) {
      if(!scripts\engine\utility::flag_exist(var_4) || !scripts\engine\utility::flag(var_4))
        var_2[var_2.size] = var_4;
    }

    if(var_2.size == 1) {
      var_6 = 0.7;

      if(var_2[0] == "skelterscomplete_vo_finished")
        thread _id_10AE::_id_CE80(::_id_10238, 0, var_6);
      else
        thread _id_10AE::_id_CE80(::_id_1561, 0, var_6);

      break;
    }

    wait 0.05;
  }
}

_id_12E24() {
  level endon("dont_care_about_skillchange");
  var_0 = level._id_7683;

  for(;;) {
    if(var_0 != level._id_7683) {
      var_1 = var_0;
      var_0 = level._id_7683;
      _id_B32A(var_1);
    }

    wait 0.05;
  }
}

_id_B32A(var_0) {
  level notify("skill_change");
  level._id_11912 = level._id_7683;
  scripts\sp\utility::_id_46AB();
  wait 0.1;
  _id_12E42();
  thread _id_8CD2();
  thread _id_4151();
}

_id_10CAE() {
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  _id_10AE::_id_5768("salter_jackal", "salter_jackal", 1, 1);
  level._id_EAD6 = level._id_A3A8["salter_jackal"].jackals._id_FE2D[0];
  level._id_EAD6 _id_0BDC::_id_1998();
}

_id_B20F() {
  thread scripts\sp\utility::_id_2669("ja_autosave");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_6EEA();
  thread mining_music_end();
  thread _id_0BDC::_id_A1A9(1);
  level notify("stop_heat_nags");
  wait 1.0;
  thread _id_10AE::_id_CE81(::_id_B8BD);
  scripts\engine\utility::flag_wait("show_rally_point");
  thread _id_AA95();
  thread _id_AA57();

  while(!(scripts\engine\utility::flag("launch_area_clear") && level.player useButtonPressed()))
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_set("launch_started");
  level._id_D299 = _id_D2A6("player_sled", undefined, 0);
  level._id_D2A1 = _id_D2A6("player_sled_launch", 1, 0);
  thread _id_CFDE();
  scripts\engine\utility::flag_wait("launch_boost");
  wait 1.5;
  _id_10AE::_id_CE81(::_id_AAB1);
  wait 1.5;
  var_0 = 2.0;
  var_1 = 1.0;
  var_2 = scripts\sp\hud_util::_id_48B7("black", 0);
  var_2 fadeovertime(var_0);
  var_2.alpha = 1;
  wait(var_0);
  wait(var_1);
  scripts\sp\utility::_id_BF95();
}

mining_music_end() {
  setmusicstate("");
  wait 1;
  setmusicstate("mx_mining_victory");
}

_id_AA95() {
  var_0 = 0;
  scripts\sp\utility::_id_56BA("move_clear");

  while(!scripts\engine\utility::flag("launch_started")) {
    if(scripts\engine\utility::flag("launch_area_clear") && !var_0) {
      var_0 = 1;
      scripts\sp\utility::_id_56BA("start_launch");
    } else if(!scripts\engine\utility::flag("launch_area_clear") && var_0) {
      var_0 = 0;
      scripts\sp\utility::_id_56BA("move_clear");
    }

    wait 0.1;
  }
}

_id_AA57() {
  level endon("started_transition");
  var_0 = [];
  var_0[0] = [0, 9400, 625];
  var_0[1] = [0, 18600, 1500];
  var_0[2] = [0, 26000, 2700];
  var_0[3] = [0, 31600, 4200];
  var_0[4] = [0, 37500, 6500];
  var_0[5] = [0, 44000, 9300];
  var_0[6] = [0, 49400, 12000];

  for(;;) {
    var_1 = level._id_D127.origin;
    var_2 = anglesToForward(level._id_D127.angles);
    var_3 = level._id_D127.origin + 10000 * var_2;
    var_4 = var_3 - level._id_D127.origin;
    var_4 = vectorNormalize(var_4);
    var_4 = scripts\sp\math::_id_13198(var_4, (0, 0, 1));
    var_5 = vectortoangles(var_4);
    var_2 = anglesToForward(var_5);
    var_6 = anglestoup(var_5);
    var_7 = anglestoright(var_5);
    var_8 = 1;

    foreach(var_10 in var_0) {
      var_11 = level._id_D127.origin + var_7 * var_10[0] + var_2 * var_10[1] + var_6 * var_10[2];
      var_12 = bullettracepassed(var_1, var_11, 0, level._id_D127);

      if(!var_12)
        var_8 = 0;
      else {}

      var_1 = var_11;
    }

    if(var_8)
      scripts\engine\utility::flag_set("launch_area_clear");
    else
      scripts\engine\utility::flag_clear("launch_area_clear");

    wait 0.1;
  }
}

_id_AAA1() {
  scripts\sp\utility::_id_1034D("ja_mining_plr_wedonthavealoto");
  scripts\engine\utility::flag_wait("intro_hold_on_black_done");
  wait 0.7;
  scripts\sp\utility::_id_10350("ja_mining_eth_startingcountdo");

  if(!scripts\sp\utility::_id_93A6())
    _id_0BDC::_id_A228();

  scripts\engine\utility::flag_set("start_heat_death_timer");
  scripts\sp\utility::_id_10350("ja_mining_slt_eyesonenemyskel");
  scripts\sp\utility::_id_1034D("ja_mining_plr_showthemwhatyou");
  scripts\sp\utility::_id_10350("ja_mining_slt_holyshitthatsa");
  scripts\sp\utility::_id_10350("ja_mining_eth_tracking45aces");
  scripts\sp\utility::_id_1034D("ja_mining_plr_wellhavetoearnthis");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
}

_id_1562() {
  scripts\engine\utility::flag_wait("aces4_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_mining_plr_oneacedown");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_wait("aces3_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_mining_plr_secondaceelimin");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_wait("aces2_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_mining_slt_igotonejust2mor");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_wait("aces1_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_mining_plr_splashonemore");
  scripts\sp\utility::_id_10350("ja_mining_slt_hustleraiderclocks");
  _id_10AE::_id_134D1();
}

_id_155F() {
  scripts\sp\utility::_id_1034D("ja_mining_plr_fiveaces");
  scripts\sp\utility::_id_10350("ja_mining_slt_whodecidedtocallthese");
  scripts\sp\utility::_id_1034D("ja_mining_plr_notimpressed");
  scripts\sp\utility::_id_10350("ja_mining_slt_hardly");
}

_id_10237() {}

_id_1561() {
  if(scripts\engine\utility::flag_exist("acescomplete") && scripts\engine\utility::flag("acescomplete")) {
    return;
  }
  scripts\sp\utility::_id_10350("ja_all_eth_sirstillseeingmultiple");
}

_id_10238() {
  scripts\sp\utility::_id_1034D("ja_mining_plr_gotmoreskeltersinrange");
  scripts\sp\utility::_id_10350("ja_mining_eth_notmuchsand");
}

_id_B8BD() {
  scripts\sp\utility::_id_1034D("ja_mining_slt_thatsallofthem");
  scripts\sp\utility::_id_10350("ja_mining_eth_heatlevelsstill");
  scripts\engine\utility::flag_set_delayed("show_rally_point", 1.0);
  scripts\sp\utility::_id_1034D("ja_mining_plr_scarsregroupand");
}

_id_AAB1() {
  scripts\sp\utility::_id_1034D("ja_mining_plr_thanksfortheassist");
  scripts\sp\utility::_id_10350("ja_mining_eth_justdoinmyjobsir");
  scripts\sp\utility::_id_10350("ja_mining_slt_letsgetbacktotheret");
}

_id_1DE7() {
  var_0 = getEntArray("ambient_rotate_object", "script_noteworthy");
  level._id_E736 = [];

  foreach(var_2 in var_0) {
    if(!issubstr(var_2.classname, "script_brushmodel")) {
      var_3 = getEntArray(var_2.target, "targetname");

      if(isDefined(var_2.target))
        scripts\engine\utility::array_call(var_3, ::linkto, var_2);

      level._id_E736[level._id_E736.size] = var_2;
      var_2 thread _id_1DE6();
    }
  }
}

_id_1DE6() {
  var_0 = 1;
  var_1 = 10;
  var_2 = 2;
  var_3 = [];

  if(isDefined(self.script_parameters))
    var_3 = strtok(self.script_parameters, " ");

  var_4 = [];
  var_5 = [];
  var_2 = clamp(var_2, 2, 3);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    if(!isDefined(var_3[var_6])) {
      if(var_3.size == 1)
        var_4[var_6] = float(var_3[0]);
      else
        var_4[var_6] = randomintrange(var_0, var_1);
    } else
      var_4[var_6] = float(var_3[var_6]);

    var_5[var_6] = scripts\engine\utility::random([-1, 1]);
  }

  for(;;) {
    var_7 = [];
    var_8 = "";

    for(var_6 = 0; var_6 < var_2; var_6++) {
      var_7[var_6] = self.angles[var_6] + var_4[var_6] / 20 * var_5[var_6];
      var_8 = var_8 + (var_4[var_6] + " ");
    }

    self.angles = (var_7[0], var_7[1], self.angles[2]);

    if(getdvarint("debug_rotate") == 1)
      thread scripts\engine\utility::draw_ent_axis((1, 0, 0), 2, 1000);

    scripts\engine\utility::waitframe();
  }
}

_id_111D3() {
  level endon("stop_heat_timer");
  scripts\engine\utility::flag_wait("start_heat_death_timer");

  if(level._id_10CDA != "test_death")
    level._id_11912 = level._id_7683;
  else
    level._id_11912 = 4;

  level._id_DF63 = level._id_118CF[level._id_11912][0] * 1000;
  level._id_8CE3 = 0;
  wait 0.3;
  thread _id_8CDB();
  thread _id_8CD6();
  thread _id_12DC5();
  thread _id_8CD2();
}

_id_8CD2() {
  level endon("skill_change");
  level endon("heat_time_padding_changed");
  _id_13787(level._id_118CF[level._id_11912][2]);
  level._id_D127 thread _id_CA27(1, 20, 0.8);
  _id_13787(level._id_118CF[level._id_11912][3]);
  level._id_D127 thread _id_CA27(0.5, 40, 0.2);
  _id_13787(level._id_118CF[level._id_11912][4]);
  level._id_D127 thread _id_CA27(0.1, 50, undefined);
  _id_13787(0);
  scripts\engine\utility::flag_set("heat_death_started");
  level notify("dont_care_about_skillchange");
  _id_0BDC::_id_A162(1);
  _id_10AE::_id_CE81(::_id_8CD3);
}

_id_8CD3() {
  scripts\sp\utility::_id_1034D("ja_mining_plr_blackingout");
  scripts\sp\utility::_id_1034D("ja_mining_eth_captaincanyouhe");
  level._id_D127 notify("script_death");
  scripts\sp\utility::_id_1034D("ja_mining_slt_reyes");
}

_id_D0CD() {
  level._id_D127 endon("scripted_death");

  for(;;) {
    level._id_D127._id_B154 = 10;
    wait 0.05;
  }
}

_id_8CD6() {
  level._id_8CE1 = scripts\engine\utility::spawn_tag_origin();
  level._id_8CE1 _meth_8278(0, 0);
  level._id_8CDD = scripts\engine\utility::spawn_tag_origin();
  level._id_8CE0 = scripts\engine\utility::spawn_tag_origin();
  level._id_8CDD _id_0BDC::_id_F2FF();
  level._id_8CE0 _id_0BDC::_id_F2FF();
  level._id_8CE1 _id_0BDC::_id_A25B(0, "j_mainroot_ship", (0, 0, 0), (0, 0, 0), undefined, 1);
  thread _id_8CD7();
  var_0 = 0;

  for(;;) {
    var_0 = 1 - scripts\sp\math::_id_C097(0, level._id_118CF[level._id_11912][1], _id_7A01() / 1000);
    var_1 = scripts\sp\math::_id_6A8E(0, 0.25, var_0);
    var_2 = scripts\sp\math::_id_6A8E(-300, 0, scripts\sp\math::_id_C09A(var_0));
    var_3 = scripts\sp\math::_id_6A8E(-1500, -250, scripts\sp\math::_id_C09A(var_0));
    var_4 = scripts\sp\math::_id_6A8E(0, 2, var_0);

    if(var_1 > 0)
      earthquake(var_1, randomfloatrange(0.1, 0.25), level._id_D127.origin, 20000);

    level._id_8CE1 _meth_8278(var_4, 0.05);
    var_5 = level._id_D127 gettagorigin("j_mainroot_ship");
    var_6 = level._id_D127 gettagangles("j_mainroot_ship");
    level._id_8CDD.angles = var_6;
    level._id_8CDD.origin = var_5 + anglestoup(var_6) * var_2;
    level._id_8CE0.origin = var_5 + anglestoup(var_6) * var_3;
    level.player waittill("on_player_update");
  }
}

_id_8CD7() {
  _id_13787(level._id_118CF[level._id_11912][1]);
  scripts\engine\utility::flag_set("flag_heatfx_triggered");
  _id_0BDC::jackal_disable_damage_vision_distortion();
  wait 2;
  visionsetnaked("ja_mining_heat", _id_7A01() / 1000 - level._id_118CF[level._id_11912][4] + 5);
  playFXOnTag(scripts\engine\utility::getfx("vfx_ja_deathfire"), level._id_8CDD, "tag_origin");
  level._id_8CE0 _meth_8244("steady_rumble");
  level._id_8CE1 playLoopSound("jackal_burning_lp");
}

_id_4151() {
  if(!scripts\engine\utility::flag("flag_heatfx_triggered")) {
    return;
  }
  scripts\engine\utility::flag_clear("flag_heatfx_triggered");
  _id_0BDC::jackal_disable_damage_vision_distortion(0);
  visionsetnaked("ja_mining", level._id_118CF[level._id_11912][1] - level._id_118CF[level._id_11912][4] + 5);
  killfxontag(scripts\engine\utility::getfx("vfx_ja_deathfire"), level._id_8CDD, "tag_origin");
  level._id_8CE0 stoprumble("steady_rumble");
  level._id_8CE1 stoploopsound("jackal_burning_lp");
  wait 0.05;
  thread _id_8CD7();
}

_id_7A00() {
  return level._id_DF63 + level._id_8CE3;
}

_id_7A01() {
  return level._id_DF63;
}

_id_F3FE(var_0) {
  if(scripts\engine\utility::flag("heat_death_started")) {
    return;
  }
  level._id_8CE3 = var_0 * 1000;
  level notify("heat_time_padding_changed");
  wait 0.1;
  thread _id_8CD2();
}

_id_8CDB() {
  level endon("heat_death_started");
  level endon("stop_heat_nags");

  if(level._id_118CF[level._id_11912][0] > 320) {
    _id_13788(300);
    thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_eth_keepfightingsir");
  }

  if(level._id_118CF[level._id_11912][0] > 260) {
    _id_13788(240);
    thread _id_10AE::_id_CE80(::four_minutes_line);
  } else {
    _id_13788(220);
    thread _id_10AE::_id_CE80(::four_minutes_line);
  }

  _id_13788(180);
  var_0 = randomint(2);

  if(var_0 == 0) {
    var_1 = 1;
    thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_slt_keepaneyeonthat");
  } else if(var_0 == 1) {
    var_1 = 1;
    thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_slt_letsstepituptimes");
  } else
    thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_eth_runningshortont");

  _id_13788(120);
  thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_eth_youvegotlesstha");
  _id_13788(90);
  thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_slt_shitweneedtowra");
  _id_13788(60);
  thread _id_10AE::_id_CE80(::sixty_seconds_line);
  _id_13788(30);
  thread _id_10AE::_id_CE80(::thirty_seconds_line);
  _id_13788(15);
  thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_slt_damnitraiderthe");
  _id_13787(level._id_118CF[level._id_11912][2]);
  thread _id_10AE::_id_CE87(scripts\sp\utility::_id_10350, "ja_mining_eth_heatlevelsstill");
}

four_minutes_line() {
  scripts\sp\utility::_id_10350("ja_mining_eth_watchtheclock");
  scripts\sp\utility::_id_1034D("ja_mining_plr_copyethan");
}

sixty_seconds_line() {
  scripts\sp\utility::_id_10350("ja_mining_eth_1minuteyourjack");
  wait 0.5;
  scripts\sp\utility::_id_1034D("ja_mining_plr_gettheleadoutsc");
}

thirty_seconds_line() {
  scripts\sp\utility::_id_10350("ja_mining_eth_30seconds");
  scripts\sp\utility::_id_10350("ja_mining_eth_siryouneedtoget");
}

_id_12DC5() {
  _id_12E42();
  var_0 = gettime();

  for(;;) {
    level._id_DF63 = level._id_118CF[level._id_11912][0] * 1000 - (gettime() - var_0);
    wait 0.05;
  }
}

_id_12E42() {
  var_0 = int(_id_7A01() / 1000);
  thread scripts\sp\utility::_id_46AD(var_0, "jackal_heat_countdown");
}

_id_13787(var_0) {
  while(_id_7A00() / 1000 > var_0)
    wait 0.2;
}

_id_13788(var_0) {
  while(_id_7A01() / 1000 > var_0)
    wait 0.2;
}

_id_CA27(var_0, var_1, var_2) {
  level notify("periodic_heat_damage");
  level endon("periodic_heat_damage");
  level endon("skill_change");
  level endon("heat_time_padding_changed");
  var_3 = 5;

  for(;;) {
    var_4 = randomfloatrange(var_3 * -1, var_3);

    if(level._id_D127._id_B154 > var_1 + var_4)
      self dodamage(var_1 + var_4, self.origin + (0, 0, 0), undefined, undefined, "MOD_GRENADE_SPLASH");

    var_4 = 0;

    if(isDefined(var_2))
      var_4 = randomfloatrange(var_2 * -1, var_2);

    wait(var_0 + var_4);
  }
}

_id_CFDE() {
  var_0 = "moon_launch";
  var_1 = "moon_launch_boost";
  _id_0BDC::_id_A14C(1);
  _id_0BDC::_id_A1DD("hover");
  var_2 = anglesToForward(level._id_D127.angles);
  var_3 = level._id_D127.origin + 10000 * var_2;
  var_4 = var_3 - level._id_D127.origin;
  var_4 = vectorNormalize(var_4);
  var_4 = scripts\sp\math::_id_13198(var_4, (0, 0, 1));
  var_5 = vectortoangles(var_4);
  level._id_D299 vehicle_teleport(level._id_D127.origin, var_5);
  level._id_D2A1 vehicle_teleport(level._id_D127.origin, var_5);
  wait 0.05;
  level._id_EAD6._id_1FBB = "salter_jackal";
  level._id_EAD6 _id_0BDC::_id_19A2();
  level._id_EAD6 _id_0BDC::_id_6B4C("hover", 1);
  wait 0.05;

  if(!scripts\engine\utility::is_true(level._id_12658)) {
    var_6 = 3;
    var_7 = scripts\engine\utility::spawn_tag_origin(level._id_D299.origin + anglesToForward(level._id_D299.angles) * 50000);
    var_7.angles = level._id_D299.angles;
    var_7 linkTo(level._id_D299);
    thread _id_0BDC::_id_D165(var_7, 0.5, 0, var_6, 1);
    wait(var_6);
  } else
    wait 0.1;

  level._id_D299 vehicle_teleport(level._id_D127.origin, var_5);
  level._id_D2A1 vehicle_teleport(level._id_D127.origin, var_5);
  wait 0.05;
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_D299, var_0);
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_D2A1, var_0);
  level._id_D299 thread scripts\sp\anim::_id_1EC3(level._id_EAD6, var_0);
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_EAD6, var_0);
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A160(1);
  earthquake(0.22, 1.1, level._id_D127.origin, 5000);
  setomnvar("ui_jackal_autopilot", 1);
  _id_0BDC::_id_D164(level._id_D2A1._id_BD0D, 1);
  _id_0BDC::_id_A1DD("hover");
  thread _id_D2D8();
  level._id_D127 thread _id_0BDB::_id_11479();
  _id_0BDB::_id_1147B(8);
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_D299, var_1);
  var_8 = 14;

  if(scripts\engine\utility::is_true(level._id_12658))
    var_8 = 0;

  thread _id_0BDB::_id_CFE0(var_8);

  if(!scripts\engine\utility::is_true(level._id_12658))
    level._id_D127 waittill("notify_player_launch");

  scripts\engine\utility::flag_set("launch_boost");
  _id_0BDC::_id_A38E(16, 0.7, 0.7, 1.5);
  thread _id_D27B();
  _id_0BDC::_id_A0BE(1);
  _id_0BDC::_id_A1DD("fly");
  level._id_D2A1 thread scripts\sp\anim::_id_1F35(level._id_D2A1, var_1);
}

#using_animtree("jackal");

_id_D2D8() {
  thread _id_0BDC::_id_A2B0(%jackal_pilot_launch_button, %jackal_vehicle_launch_button, 1.1, 0.5);
  wait 2.1;
  earthquake(0.25, 0.75, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
  thread _id_104EB();
  level._id_D127 notify("notify_player_can_launch");
}

_id_104EB() {
  _id_0BDC::_id_A250();
  setomnvar("ui_jackal_autopilot", 0);
  thread _id_104EC();
  thread _id_104EE();
  thread _id_104F1();
  thread _id_104F0();
  thread _id_104F2();
  thread _id_104ED();
}

_id_104EF() {
  level notify("launch_hud_off");
  _id_0BDC::_id_A250(0);
}

_id_104EC() {
  level endon("launch_hud_off");
  level._id_1161E = 0;

  for(;;) {
    var_0 = level._id_D127.origin[2];
    var_0 = var_0 - level._id_1161E;
    var_1 = scripts\sp\math::_id_C097(-109728, 80000, var_0);
    var_2 = scripts\sp\math::_id_6A8E(0, 310000, var_1);
    setomnvar("ui_jackal_launch_alt", int(var_2));
    wait 0.05;
  }
}

_id_104EE() {
  setomnvar("ui_jackal_launch_gforce", 0.0);
  level._id_D127 waittill("notify_player_launch");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 2, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 9.5, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 0, 15);
}

_id_104F1() {
  setomnvar("ui_jackal_launch_speed", 0);
  level._id_D127 waittill("notify_player_launch");
  scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 235, 2);
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 500, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 40500, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 0, 15);
}

_id_104F0() {
  level endon("launch_hud_off");

  for(;;) {
    var_0 = level._id_D127 gettagangles("tag_body");
    var_1 = anglesToForward(var_0);
    var_2 = vectortoangles(var_1);
    setomnvar("ui_jackal_launch_pitch", abs(360 - var_2[0]));
    wait 0.05;
  }
}

_id_104F2() {
  wait 2;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  level._id_D127 waittill("notify_player_launch");
  wait 10.5;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 2);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  _id_1379D("stop_booster", -0.1);
  setomnvar("ui_jackal_launch_state", 3);
  _id_1379D("stop_booster", 1.9);
  setomnvar("ui_jackal_launch_state", 4);
  _id_1379D("stop_booster", 10);
  setomnvar("ui_jackal_launch_state", 5);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
}

_id_104ED() {
  level endon("launch_hud_off");
  setomnvar("ui_jackal_launch_fuel", 100);
  level._id_D127 waittill("notify_player_launch");
  var_0 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_1 = 0.7;

  for(;;) {
    var_2 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
    var_3 = 1 - scripts\sp\math::_id_C097(var_0, var_1, var_2);
    var_4 = scripts\sp\math::_id_6A8E(0, 100, var_3);
    var_4 = scripts\sp\utility::_id_E753(var_4, 2);
    setomnvar("ui_jackal_launch_fuel", var_4);
    wait 0.05;
  }
}

_id_1379D(var_0, var_1) {
  var_2 = getanimlength(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_3 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level._id_EC85["sled_jackal"]["moon_launch_boost"], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = var_4 - var_3 + var_1;
  wait(var_5);
}

_id_D2A6(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_4 = scripts\sp\vehicle::_id_13237(var_3);
  var_4._id_4074 = [];
  var_4._id_1FBB = "sled_jackal";

  if(isDefined(var_1) && var_1) {
    var_4._id_AFEB = scripts\engine\utility::spawn_tag_origin();
    var_4._id_AFEB.origin = var_4.origin + anglesToForward(var_4.angles) * 2500;
    var_4._id_AFEB linkTo(var_4);
    var_4._id_BD0D = scripts\engine\utility::spawn_tag_origin();
    var_4._id_BD0D linkTo(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_4._id_B025 = scripts\engine\utility::spawn_tag_origin();
    var_4._id_B025 linkTo(var_4._id_AFEB, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_4._id_4074 = scripts\engine\utility::array_add(var_4._id_4074, var_4._id_AFEB);
    var_4._id_4074 = scripts\engine\utility::array_add(var_4._id_4074, var_4._id_BD0D);
    var_4._id_4074 = scripts\engine\utility::array_add(var_4._id_4074, var_4._id_B025);
  }

  var_4 setvehicleteam("allies");
  var_4 notsolid();
  var_4 thread _id_0BDC::_id_D29D();

  if(scripts\engine\utility::is_true(var_2))
    var_4 setModel("veh_mil_air_un_jackal_02");

  return var_4;
}

_id_D27B() {
  level endon("player_booster_drop");
  earthquake(0.48, 1.5, level._id_D127.origin, 5000);
  level._id_AA94 = 0.16;
  wait 0.75;

  for(;;) {
    var_0 = randomfloatrange(0.1, 0.15);
    var_1 = randomfloatrange(level._id_AA94, level._id_AA94 + 0.02);
    earthquake(var_1, var_0, level._id_D127.origin, 5000);
    wait(var_0 * 0.4);
  }
}

_id_16BD(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_4EC3))
    level._id_4EC3 = [];

  var_3 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_3 = "^1";
        break;
      case "green":
      case "g":
        var_3 = "^2";
        break;
      case "yellow":
      case "y":
        var_3 = "^3";
        break;
      case "blue":
      case "b":
        var_3 = "^4";
        break;
      case "cyan":
      case "c":
        var_3 = "^5";
        break;
      case "purple":
      case "p":
        var_3 = "^6";
        break;
      case "white":
      case "w":
        var_3 = "^7";
        break;
      case "bl":
      case "black":
        var_3 = "^8";
        break;
    }
  }

  var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_4 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4.label = " " + var_3 + "< " + var_0 + " > ^7" + var_1;
  var_4.color = (1, 1, 1);
  level._id_4EC3 = scripts\engine\utility::array_insert(level._id_4EC3, var_4, 0);

  foreach(var_7, var_6 in level._id_4EC3) {
    if(var_7 == 0) {
      continue;
    }
    if(isDefined(var_6))
      var_6.y = 325 - var_7 * 18;
  }

  wait 2;
  var_8 = 40;
  var_4 fadeovertime(3);
  var_4.alpha = 0;

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_4.color = (1, 1, 0 / (var_8 - var_7));
    wait 0.05;
  }

  wait 4;
  var_4 destroy();
  scripts\engine\utility::array_removeundefined(level._id_4EC3);
}