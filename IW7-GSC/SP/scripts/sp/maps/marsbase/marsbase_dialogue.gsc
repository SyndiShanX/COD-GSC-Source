/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_dialogue.gsc
**********************************************************/

_id_5462() {
  level.player endon("death");
  scripts\sp\utility::_id_10350("marsbase_bgs_settinusdown");
  scripts\sp\utility::_id_10350("marsbase_bgs_beadviseditsa");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_copyboggs");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_everyoneready");
  wait 9;
  scripts\sp\utility::_id_10350("marsbase_bgs_10feet");
  scripts\sp\utility::_id_10350("marsbase_bgs_touchdown");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_gogo");
}

_id_542E() {
  level.player endon("death");
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_multiplefriendlykias");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_justgettocover");
  thread _id_5430();
}

_id_5430() {
  level._id_76FB scripts\sp\utility::_id_10346("marsbase_brk_droppodscominin");
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_ma2_copy");
}

_id_545E(var_0) {
  if(isDefined(var_0)) {
    var_0 scripts\sp\utility::_id_10346("marsbase_plt1_aagunsarecuttin");
  } else {
    scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("mars_jackal_pip", "marsbase_plt1_aagunsarecuttin");
  }
}

_id_5411() {}

_id_542F() {
  level.player endon("death");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_reyesfirstaagun");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_copyethanletsta");
  level thread _id_542B();
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_copydroneisover");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_rog");
  scripts\engine\utility::flag_set("mars_killstreak_activate");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_takeoutthatgun");
}

_id_542B() {
  level.player endon("death");
  var_0 = ["marsbase_plt1_aagunsareengaging", "marsbase_plt1_antiairshittingushard", "marsbase_plt1_jackalarenegativefor", "marsbase_plt1_weregettinrippedup", "marsbase_plt1_thoseaaswontlet", "marsbase_plt1_jackalsaretakingheavy", "marsbase_plt1_aafiresstitchingus", "marsbase_plt1_aagunsareburnin"];
  level thread _id_10349(var_0, "flag_aa1_end");
  level waittill("aa_gun_1_targeted");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_targetmarked");
  scripts\engine\utility::flag_wait("flag_aa1_end");
}

_id_5406() {
  level endon("flag_aa1_end");
  level._id_6754 endon("death");
  level.player endon("death");
  var_0 = ["marsbase_eth_nosplashdronestrike", "marsbase_eth_dronestrikeisa"];
  var_1 = [level._id_6754, level._id_6754];
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    level.player waittill("mars_killstreak_missiles_done");
    wait 1.5;

    if(!var_3 && (scripts\engine\utility::flag("aa_gun_1_1_destroyed") || scripts\engine\utility::flag("aa_gun_1_2_destroyed"))) {
      var_3 = 1;
      var_4 = 1;
      level thread _id_543B();
    }

    if(!var_4) {
      if(isPlayer(var_1[var_2])) {
        level.player scripts\sp\utility::_id_1034D(var_0[var_2]);
      } else {
        var_1[var_2] scripts\sp\utility::_id_10346(var_0[var_2]);
      }

      var_2++;

      if(var_2 >= var_0.size) {
        break;
      }
    }

    if(var_3) {
      var_4 = 0;
    }
  }
}

_id_543B() {
  level endon("flag_aa1_end");
  wait(randomintrange(13, 16));
}

_id_5431() {
  level.player endon("death");
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_goodeffectontar");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_chieffirstgunis");
  thread _id_B39A();
  _id_5433();
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_echoisonstation");
  level._id_76FB thread scripts\sp\utility::_id_10346("marsbase_gtr_engineerscutusa");
  wait 1;
  scripts\engine\utility::flag_set("flag_start_engineer_gate_open");
}

_id_B39A() {
  setmusicstate("");
  wait 9;
  setmusicstate("engineers_arrive");
}

_id_5432() {}

_id_5433() {
  scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("mars_mccallum_pip");
}

_id_CBAF() {
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("mccallum_pip_temp_spawn_player", "targetname"));
  var_0 = scripts\engine\utility::getStruct("mccallum_pip_temp_spawn", "targetname");
  scripts\sp\maps\marsbase\marsbase_util::_id_10626("mccallum");
  level._id_B4F1.name = "";
  level._id_B4F1 _meth_80F1(var_0.origin + (-100, -40, 0), var_0.angles + (0, -40, 0));
  level._id_B4F1 setgoalpos(level._id_B4F1.origin);
  level._id_B4F1 scripts\sp\utility::_id_51E1("combat");
  wait 4;

  for(;;) {
    level._id_B4F1 scripts\sp\anim::_id_1F35(level._id_B4F1, "ihaveasupport");
    wait 3;
  }
}

_id_CBAD() {
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("jackal_pilot_pip_temp_spawn_player", "targetname"));
  thread scripts\sp\utility::_id_C12D("stop_ambient_jackals_intro", 0.5);
  thread scripts\sp\utility::_id_C12D("stop_ambient_jackals", 0.5);
  thread scripts\sp\utility::_id_C12D("hill_battle_jackals_stop", 0.5);
  thread scripts\sp\utility::_id_C12D("aa2_jackals_stop", 0.5);
  var_0 = getEnt("pip_jackal", "targetname");
  var_1 = scripts\sp\utility::_id_107EA("sp_jackal_pilot_pip", 1);
  var_1._id_1FBB = "jackal_pilot_pip";
  var_1 scripts\sp\utility::_id_86E4();
  var_2 = (-12, 0, 0);
  var_1 _meth_80F1(var_0 gettagorigin("j_cockpit") + var_2, var_0 gettagangles("j_cockpit"));
  var_1 thread scripts\sp\anim::_id_1EEA(var_1, "jackal_pilot_idle");

  for(;;) {
    _id_545E(var_1);
    wait 5;
  }
}

_id_CBAE() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("jackal_pilot_pip_temp_spawn_player", "targetname"));
  level.player thread scripts\sp\maps\marsbase\marsbase_killstreak::_id_1143D();
  thread scripts\sp\utility::_id_C12D("stop_ambient_jackals_intro", 0.5);
  thread scripts\sp\utility::_id_C12D("stop_ambient_jackals", 0.5);
  thread scripts\sp\utility::_id_C12D("hill_battle_jackals_stop", 0.5);
  thread scripts\sp\utility::_id_C12D("aa2_jackals_stop", 0.5);
  var_0 = getEnt("pip_jackal", "targetname");
  var_1 = getEnt("sp_jackal_pilot_pip_2", "targetname");
  var_2 = scripts\sp\utility::_id_2C17(var_1);
  var_2._id_1FBB = "jackal_pilot_pip";
  scripts\engine\utility::waitframe();
  var_0 scripts\sp\anim::_id_1EC3(var_2, "inboundforgun");
  thread _id_BD39();
  wait 5;

  for(;;) {
    var_0 scripts\sp\anim::_id_1EC3(var_2, "inboundforgun");
    wait 1;
    var_0 scripts\sp\anim::_id_1F35(var_2, "inboundforgun");
    var_0 scripts\sp\anim::_id_1EC3(var_2, "timetotarget5");
    wait 3;
    var_0 scripts\sp\anim::_id_1F35(var_2, "timetotarget5");
    var_0 scripts\sp\anim::_id_1EC3(var_2, "jackalsareweaponsloose");
    wait 2;
    var_0 scripts\sp\anim::_id_1F35(var_2, "jackalsareweaponsloose");
    var_0 scripts\sp\anim::_id_1EC3(var_2, "captainbeadvisedaa");
    wait 2;
    var_0 scripts\sp\anim::_id_1F35(var_2, "captainbeadvisedaa");
    var_0 scripts\sp\anim::_id_1EC3(var_2, "negativetwo-fiveisweapons");
    wait 2;
    var_0 scripts\sp\anim::_id_1F35(var_2, "negativetwo-fiveisweapons");
    var_0 scripts\sp\anim::_id_1EC3(var_2, "understoodcommanderillram");
    wait 2;
    var_0 scripts\sp\anim::_id_1F35(var_2, "understoodcommanderillram");
    var_0 scripts\sp\anim::_id_1EC3(var_2, "kamikaze");
    wait 2;
    var_0 scripts\sp\anim::_id_1F35(var_2, "kamikaze");
  }
}

_id_BD39() {
  var_0 = getEnt("pip_pilot_light", "targetname");

  for(;;) {
    var_1 = randomintrange(70, 100);
    var_0 movez(var_1, 2, 0.5, 0.5);
    wait 2;
    var_2 = var_1 * -1;
    var_0 movez(var_2, 2, 0.5, 0.5);
    wait 2;
  }
}

_id_5410() {
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_gatesopenwerepushing");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_entranceiscrawlingwith");
}

_id_53FD(var_0) {
  level._id_8604 thread scripts\sp\utility::_id_10346("marsbase_brk_enemydroppodsincoming");
  level endon("greenhouse_battle_done");

  if(!scripts\engine\utility::is_true(var_0)) {
    wait 2;
  }

  level._id_8604 scripts\sp\utility::_id_10346("marsbase_grf_clearthosepositionsup");
  scripts\engine\utility::flag_wait("greenhouse_center_droppods");
  wait 1.5;
}

_id_53FF() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_bravodeploytomy");
  wait 1.5;
  scripts\sp\utility::_id_10350("marsbase_plt2_raven3approachingwithreinforcements");
  level thread _id_53F6();
  wait 1;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_copyfriendliesapproaching");
  wait 0.75;
  level waittill("dropship_3_go");

  if(!scripts\engine\utility::flag("flag_greenhouse_near_door")) {
    scripts\sp\utility::_id_1034D("marsbase_plr_areasecuremoveup");
  }

  setmusicstate("");
  scripts\sp\utility::_id_10350("marsbase_plt2_raven3insertingmarines");
  level waittill("dropship3_marines_spawned");
  wait 0.5;
  level._id_30F6 thread scripts\sp\utility::_id_10346("marsbase_brk_letsgomarinesstack");
  wait 5;
  scripts\sp\utility::_id_10350("marsbase_plt1_jackalsaretakingheavy");
}

_id_544A() {
  if(randomint(2)) {
    level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_theyreholdingtheentry");
  } else {
    level.player scripts\sp\utility::_id_1034D("marsbase_plr_gotsetdefonthe");
  }
}

_id_53F6() {
  level endon("exitdoor_cleared");
  level waittill("dropship3_hit");
  scripts\sp\utility::_id_10350("marsbase_plt2_incoming");
  scripts\sp\utility::_id_10350("marsbase_plt2_werehitabandonship");
}

_id_53FA() {
  level endon("buddydoor_pry_open_success");
  thread _id_53FC();
  scripts\sp\utility::_id_127B3("trig_exitdoor");
  scripts\engine\utility::flag_set("flag_greenhouse_near_door");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_doorisyouandgat");
  wait 0.5;
  level.player waittill("player_attached_to_door");
  wait 0.5;

  if(!scripts\engine\utility::flag("gator_effort_vo")) {
    level._id_76FB scripts\sp\utility::_id_10346("marsbase_nav_itsgoodtobeinthefight");
  }
}

_id_53FC() {
  level endon("buddydoor_pry_open_success");
  scripts\engine\utility::flag_init("gator_effort_vo");

  for(;;) {
    level waittill("buddydoor_pry_open_start");
    scripts\engine\utility::flag_set("gator_effort_vo");
    level._id_76FB scripts\sp\utility::_id_10346("marsbase_nav_effort1");
    scripts\engine\utility::flag_clear("gator_effort_vo");
    wait 30;
  }
}

_id_53FB() {}

_id_546D() {
  level endon("exitdoor_boss_dropship_exited");
  level waittill("nag_player_open_exitdoor_0");
  wait 3;
  level waittill("nag_player_open_exitdoor_1");
  wait 3;
  level waittill("nag_player_open_exitdoor_2");
  wait 3;
  level waittill("nag_player_open_exitdoor_3");
  wait 3;
}

_id_541B() {}

_id_540C() {
  level.player endon("death");
  level._id_76FB scripts\sp\utility::_id_10346("marsbase_kls_captain");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_kloos");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_mandown");
}

_id_542C() {
  scripts\sp\utility::_id_10350("marsbase_plt1_42406toraiderwere");
  level thread _id_53F5();

  while(!scripts\engine\utility::is_true(level._id_B3B7)) {
    wait 1;
  }

  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_ordnancedroneisready");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_takethatgunout");
  level thread _id_5408();
  level thread _id_53F4();
  level thread _id_5400();
}

_id_5400() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("aa2_destroyed");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_boom");
  wait 1;
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_targetdestroyed");
  wait 1;
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_grf_welldonecommand");
  level waittill("aa2_safe_to_cross");
  wait 0.75;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_letsgo");
}

_id_53F5() {
  level endon("aa2_destroyed");
  level.player endon("death");
  level.player waittill("mars_killstreak_start");
  wait 1;
  level._id_6754 thread scripts\sp\utility::_id_10346("marsbase_eth_setdefscorruptedourdrone");
  level.player waittill("mars_killstreak_fire");
  wait 0.5;
  level.player scripts\engine\utility::delaycall(0.05, ::_meth_80D1);
  level.player scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_D091, "ges_point", level.gun["aa_gun_2"]._id_38D6);
  level.player scripts\engine\utility::delaycall(1, ::_meth_80A1);
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_targetmarked");
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_copyfiring");
}

_id_5408() {
  level endon("flag_aa2_end");
  level._id_6754 endon("death");
  level.player endon("death");
  var_0 = ["marsbase_eth_nosplashdronestrike", "marsbase_eth_dronestrikeisa"];
  var_1 = [level._id_6754, level._id_6754];
  var_2 = 0;

  while(!scripts\engine\utility::flag("aa2_destroyed")) {
    level.player waittill("mars_killstreak_missiles_done");
    wait 2;

    if(!scripts\engine\utility::flag("aa_gun_2_destroyed")) {
      if(isPlayer(var_1[var_2])) {
        level.player scripts\sp\utility::_id_1034D(var_0[var_2]);
      } else {
        var_1[var_2] scripts\sp\utility::_id_10346(var_0[var_2]);
      }

      var_2++;

      if(var_2 >= var_0.size) {
        break;
      }
    }
  }
}

_id_53F4() {
  level endon("aa2_gun_destroyed");
  level.player endon("death");
  var_0 = ["marsbase_slt_takeoutthatcannon", "marsbase_slt_takeoutthatgun"];
  var_1 = [level._id_EA2C, level._id_EA2C];
  var_2 = 0;

  while(!scripts\engine\utility::flag("aa2_destroyed")) {
    wait 20;

    while(!scripts\engine\utility::is_true(level._id_B3B7)) {
      wait 1;
    }

    if(!scripts\engine\utility::flag("player_in_mars_killstreak") && !scripts\engine\utility::flag("aa2_destroyed")) {
      var_3 = var_0[var_2];
      var_4 = var_1[var_2];

      if(!isPlayer(var_4)) {
        var_4 thread scripts\sp\utility::_id_10346(var_3);
      } else {
        level.player thread scripts\sp\utility::_id_1034D(var_3);
      }

      var_2++;

      if(var_2 >= var_0.size) {
        var_2 = 0;
      }
    }
  }
}

_id_5407() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_21secondgunis");
  scripts\sp\utility::_id_10350("marsbase_s21_rogerflightoftwo");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_fiveseconds");
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_standclearofthe");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_goodhits21");
  scripts\sp\utility::_id_10350("marsbase_s21_copyimbugginout");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_letsgo");
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_myguyswereoscar");
}

_id_53F9() {
  scripts\engine\utility::flag_wait("flag_gate_support_2_end");
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_mainentranceisblocked");
  setmusicstate("flaming_corridor");
  scripts\engine\utility::flag_wait("flag_burning_man_cave_entrance_reached");

  while(!isDefined(level._id_3297)) {
    scripts\engine\utility::waitframe();
  }

  level._id_3297 thread scripts\sp\utility::_id_10346("marsbase_sdf3_aghhhh");
  scripts\engine\utility::flag_wait("flag_burning_man_airlock_seen");
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_doortotheorbital");
}

_id_5458() {
  scripts\engine\utility::flag_wait("flag_hill_allies_intro");
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_sdfc12staysharp");
  level waittill("fspar_land");
  wait 0.4;
}

_id_5459() {
  level.player endon("flag_hill_intro_player_pickup_steeldragon");
  var_0 = ["marsbase_slt_grabthatfsparraider", "marsbase_slt_reyespickupthat"];

  foreach(var_3, var_2 in var_0) {
    level._id_EA2C scripts\sp\utility::_id_10346(var_2);
    wait 8.0;
  }
}

_id_5455() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_hill_battle_lower_push");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_griffshadowthem");
  wait 0.2;
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_myguyswereoscar");
  level notify("marsbase_brk_myguyswereoscar");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_pushforward");
  scripts\engine\utility::flag_wait("flag_hill_battle_elevator_started");
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_keepmoving");
}

_id_5457() {
  scripts\engine\utility::flag_wait("flag_hill_c8_spawn");
  level waittill("hill_c8_down");
  scripts\sp\utility::_id_10350("marsbase_plt1_thoseaaswontlet");
}

_id_541E() {
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_gtr_enemybirdinbound");
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_mega");
}

_id_541D() {}

_id_8F7D() {
  level.player endon("death");
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_hellbloodyyes");
  wait 0.2;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_wereclear");
  wait 0.2;
  scripts\engine\utility::flag_wait("flag_hill_gate_reached");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_thisisourpinchp");
  wait 0.2;
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_grf_theresthelastaa");
  scripts\engine\utility::flag_wait("mars_killstreak_offline");
  level.player thread scripts\sp\maps\marsbase\marsbase_killstreak::_id_1143D();
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_droneisdowncaptain");
  wait 0.2;
  scripts\engine\utility::flag_set("flag_hill_gate_no_strike");
  scripts\engine\utility::flag_wait("flag_hill_gate_aa_call_for_fire");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_squadroncallforfire");
  wait 0.2;
  scripts\engine\utility::flag_set("flag_hill_gate_jackal_copy");
  scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("marsbase_plt1_25_130");
  wait 0.2;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_thatc12sgotyour");
  scripts\engine\utility::flag_wait("flag_hill_gate_jackal_intial_flyby");
  scripts\engine\utility::flag_set("flag_hill_gate_c12_dropship_ready");
  scripts\engine\utility::flag_wait("flag_hill_c12_dropped");
  wait 0.1;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_anothermega");
  wait 0.2;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_iseeit");
  wait 0.2;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_keephittinit");
  wait 0.2;
  scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("marsbase_plt1_115_50");
  wait 2.4;
  scripts\engine\utility::flag_set("flag_hill_jackals_on_task");
  scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("marsbase_plt1_115_140");
  wait 2;
  scripts\engine\utility::flag_wait("flag_hill_gate_jackals_weapons_loose");
  wait 5.2;
  scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("marsbase_plt1_25_130_2");
  wait 0.2;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_jackaltwo-fiveineed");
  setmusicstate("missiles_not_available");
  wait 0.2;
  scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("marsbase_plt1_115_170");
  wait 0.2;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_42405yougottahit");
  wait 0.3;
  thread scripts\sp\maps\marsbase\marsbase_util::_id_CB9E("marsbase_plt1_115_190");
  wait 4;
  scripts\engine\utility::flag_set("flag_hill_gate_jackal_final_run");
  wait 1.25;
  scripts\engine\utility::flag_set("flag_hill_gate_jackal_final_words");
  scripts\engine\utility::flag_wait_all("flag_hill_gate_jackal_final_run", "flag_hill_gate_aa_call_for_kamikazi");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_fairwinds");
  wait 8;
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_gogogo");
}

_id_542D() {
  level._id_6754 scripts\sp\utility::_id_10346("marsbase_eth_theresthelastgun");
  wait 1;
  level._id_EA2C thread scripts\sp\utility::_id_10346("marsbase_slt_wereclear");
  level._id_30F6 thread _id_10349("marsbase_brk_weneedthatgun", "flag_aa3_end");
}

_id_5409() {
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_21lastgunis");
  wait 1;
  scripts\sp\utility::_id_10350("marsbase_s21_rogertargetinsight");
}

_id_5414() {
  scripts\engine\utility::flag_wait("flag_hill_gate_sdf_retreat");
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_rhinoteamiwant");
  wait 0.2;
  scripts\sp\utility::_id_10350("marsbase_plt2_copyrhinoteaminbound");
  wait 0.2;
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_un2_rhinoteamonstation");
  wait 0.1;
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_checktrenchinon");
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_ma2_copy");
}

_id_541A() {
  level.player endon("death");
  level.player scripts\sp\utility::_id_1034D("marsbase_plr_allstationsbead");
  wait 0.25;
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_wecrossthisbrid");
}

_id_5419() {
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_grf_goodworkcommand");
}

_id_5436() {
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_grabthedoorcommander");
}

_id_5467() {
  level._id_30F6 scripts\sp\utility::_id_10346("marsbase_brk_meandmymarines");
  level._id_8604 scripts\sp\utility::_id_10346("marsbase_grf_noyougowith");
  level notify("dialogue_marines_defend_done");
}

_id_53F8() {
  var_0 = ["marsbase_slt_nowwejusthave", "marsbase_slt_gogo"];
  var_1 = [level._id_EA2C, level._id_EA2C, level._id_EA2C];
  var_2 = 0;

  while(!scripts\engine\utility::is_true(level._id_270B)) {
    level waittill("xo_nag");
    var_3 = var_0[var_2];
    var_4 = var_1[var_2];
    var_4 thread scripts\sp\utility::_id_10346(var_3);
    var_2++;

    if(var_2 >= var_0.size) {
      var_2 = 0;
    }
  }
}

_id_5435() {
  level.player endon("death");
  wait 17;
  wait 3.0;
}

_id_10349(var_0, var_1, var_2, var_3) {
  level notify("notify_stop_dialogue_nag");
  level endon("notify_stop_dialogue_nag");

  if(isDefined(var_1)) {
    level endon(var_1);
  }

  if(!scripts\engine\utility::flag_exist("flag_dialogue_nag_active")) {
    scripts\engine\utility::flag_init("flag_dialogue_nag_active");
  }

  scripts\engine\utility::flag_clear("flag_dialogue_nag_active");
  var_0 = scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);

  if(isDefined(var_2)) {}

  var_4 = [];
  var_5 = 0;
  var_6 = 8;
  var_7 = 12;
  var_8 = randomfloatrange(var_6, var_7);
  var_4 = var_0;
  var_9 = 1;

  for(;;) {
    scripts\engine\utility::waitframe();
    var_10 = undefined;

    if(var_5 >= var_8) {
      if(var_4.size == 0) {
        if(!isDefined(var_3) || !var_3) {
          return;
        }
        var_4 = var_0;
        var_6 = 10;
        var_7 = 20;
      }

      if(var_9 && var_4.size == var_0.size) {
        var_10 = var_4[0];
        var_9 = 0;
      } else
        var_10 = scripts\engine\utility::random(var_4);

      var_11 = scripts\engine\utility::array_find(var_4, var_10);
      var_4 = scripts\engine\utility::array_remove(var_4, var_10);
      var_5 = 0;
      var_8 = randomfloatrange(var_6, var_7);
      var_12 = self;

      if(isDefined(var_2)) {
        var_12 = var_2[var_11];
      }

      if(isDefined(var_10)) {
        var_12 childthread _id_1407(var_10);
      }
    }

    if(!scripts\engine\utility::flag("flag_dialogue_nag_active")) {
      var_5 = var_5 + 0.05;
    }
  }
}

_id_1407(var_0) {
  scripts\engine\utility::flag_set("flag_dialogue_nag_active");

  if(issubstr(var_0, "tmp")) {
    _id_0B6A::_id_EC0E(var_0);
  } else if(self == level.player) {
    scripts\sp\utility::_id_1034D(var_0);
  } else if(self == level) {
    scripts\sp\utility::_id_10350(var_0);
  } else {
    scripts\sp\utility::_id_10346(var_0);
  }

  scripts\engine\utility::flag_clear("flag_dialogue_nag_active");
}