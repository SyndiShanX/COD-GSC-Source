/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_hangar.gsc
**************************************************/

_id_BABE() {
  scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_F5AF, "start_mons_landed", [level.player]);

  if(!getdvarint("debug_cranes", 0)) {
    thread _id_5D72();
    thread _id_D392();
  }
}

_id_D392() {
  var_0 = scripts\engine\utility::getStruct("dropship_arrive", "targetname");
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  scripts\sp\maps\heist\heist_flytomons::_id_D85C();
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 10, 10, 10, 10, 1);
  level.player _meth_8392(0, 5, 5);
  thread scripts\sp\maps\heist\heist_flytomons::_id_BA86();
  scripts\sp\maps\heist\heist_flytomons::_id_D09F(var_0);
}

vehicle_clearpreventcollisiondamagefortimeafterexit() {
  var_0 = vehicle_getarray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      if(issubstr(var_3.classname, "missileboat")) {
        var_1[var_1.size] = var_3;
        continue;
      }

      if(issubstr(var_3.classname, "destroyer")) {
        var_1[var_1.size] = var_3;
        continue;
      }

      if(issubstr(var_3.classname, "jackal")) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 notify("death");
      var_3 delete();
      wait 0.05;
    }
  }
}

_id_BABD() {
  setsuncolorandintensity(3);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 6);
  scripts\sp\maps\heist\heist_util::_id_968E();
  scripts\sp\maps\heist\heist_util::_id_9686();
  thread vehicle_clearpreventcollisiondamagefortimeafterexit();
  scripts\engine\utility::flag_set("hangar_shiplist_fx_enabled");
  _id_9616();
  _id_9613();
  _id_9612();
  scripts\sp\maps\heist\heist_lift::_id_3A73();
  thread scripts\sp\maps\heist\heist_util::_id_968F("hangar_shift_1", "start_hangar_shift_1", 4);
  thread scripts\sp\maps\heist\heist_util::_id_968F("hangar_shift_2", "start_hangar_shift_2", 4);
  thread scripts\sp\maps\heist\heist_util::_id_FD33("hangar");
  thread scripts\sp\maps\heist\heist_util::_id_10D16();

  if(getdvarint("debug_cranes", 0)) {
    wait 3;

    for(;;) {
      if(level.player meleeButtonPressed()) {
        _id_684A();
      } else if(level.player _meth_8439()) {
        _id_684B();
      }

      scripts\engine\utility::waitframe();
    }

    level waittill("forever");
  }

  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_lower_left", "door_lift_lower_right", 0.05);
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_lower_outer_left", "door_lift_lower_outer_right", 0.05);
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_22C8("hangar_sdf", ::_id_108C1);
  scripts\sp\utility::_id_22C9("delayed_retreat", ::_id_1089A);
  scripts\sp\utility::_id_22C9("ignore_to_goal", ::_id_108C2);
  scripts\sp\utility::_id_22C9("hangar_runners", ::_id_108C5);
  scripts\sp\utility::_id_22CA("enemy_small_crate_01", ::_id_10897);
  scripts\sp\utility::_id_22CA("hangar_wave_one_door_two", ::_id_108C0);
  scripts\engine\utility::flag_wait("allies_spawned");
  scripts\engine\utility::array_thread(getEntArray("trigger_multiple_friendly", "classname"), scripts\sp\maps\heist\heist_util::_id_1CC5);
  level._id_EA2C thread scripts\sp\maps\heist\heist_util::_id_127B1("allytrig_saltersnipe", scripts\sp\utility::_id_F416, 1);
  level._id_6754 thread scripts\sp\maps\heist\heist_util::_id_127B1("allytrig_color_ethanred", scripts\sp\utility::_id_F3B5, "r");
  level._id_EA2C thread scripts\sp\maps\heist\heist_util::_id_127B1("allytrig_color_salterred", scripts\sp\utility::_id_F3B5, "r");
  level._id_EA2C thread scripts\sp\maps\heist\heist_util::_id_127B1("allytrig_color_salterred", scripts\sp\utility::_id_F416, 0);
  getEnt("hangar_lift_1", "script_noteworthy") thread _id_1072C("hanger_elevator_01");
  getEnt("hangar_lift_2b", "script_noteworthy") thread _id_1072C("hanger_elevator_02");
  thread scripts\sp\maps\heist\heist_util::_id_127B1("hangar_lift_2b", ::_id_E582, ["hangar_robot_distro_2", [2, 3, 5]]);
  level thread scripts\sp\maps\heist\heist_util::_id_127B1("hangar_lift_2b", scripts\sp\utility::_id_F225, "robocrate_light_02");
  thread scripts\sp\utility::_id_F3AB(getEnt("hangar_lift_end_big", "script_noteworthy"), "retreat_to_c12");

  foreach(var_1 in getEntArray("trig_stop_listing", "targetname")) {
    thread scripts\sp\maps\heist\heist_util::_id_127B1(var_1, scripts\sp\maps\heist\heist_util::_id_1103D);
  }

  thread scripts\sp\maps\heist\heist_util::_id_6E55("hangar_shift_1", ::_id_684A);
  thread scripts\sp\maps\heist\heist_util::_id_6E55("hangar_shift_2", ::_id_684B);

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  wait 5;
  scripts\sp\utility::_id_22CD("hangar_wave_one");
  scripts\engine\utility::delaythread(2, ::_id_E582, "hangar_robot_distro_1", [2, 4, 5]);
  level scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_F225, "robocrate_light_01");
  thread _id_684E();
  thread _id_684C();
  thread _id_684D();
  scripts\sp\utility::_id_127B3("hangar_door_2_spawn");
  scripts\sp\utility::_id_2669("end_of_first_hangar");
  scripts\engine\utility::flag_wait_either("retreat_to_middle", "hangar_lift_1_triggered");

  if(!scripts\engine\utility::flag("hangar_lift_1_triggered")) {
    scripts\sp\utility::_id_15F3("hangar_lift_1");
  }

  scripts\engine\utility::delaythread(1, ::_id_5464);
  level.respawn = 0;
  scripts\sp\utility::_id_2669("middle");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("hangar_lift_2b_triggered");
  scripts\engine\utility::flag_wait("retreat_to_back2");
  thread _id_5FB2();
  thread _id_4274();
}

_id_4084() {
  thread scripts\sp\maps\heist\heist::_id_F04F();
  _id_0B77::_id_A67F(1);
  scripts\sp\utility::_id_15F3("hangar_lift_1");
  scripts\sp\utility::_id_15F3("hangar_lift_2b");

  foreach(var_1 in getEntArray("trigger_multiple_friendly", "classname")) {
    if(isDefined(var_1._id_EE52) && var_1._id_EE52 == "allytrig_hangar") {
      var_1 scripts\engine\utility::trigger_off();
    }
  }

  setsuncolorandintensity(0);
}

_id_4085() {
  if(isDefined(level._id_8A35)) {
    foreach(var_1 in level._id_8A35) {
      if(isDefined(var_1.front_right._id_4348)) {
        var_1.front_right._id_4348 delete();
      }

      var_1.front_right delete();

      if(isDefined(var_1.front_right._id_4348)) {
        var_1.front_right._id_4348 delete();
      }

      var_1.front_left delete();

      if(isDefined(var_1._id_005A._id_4348)) {
        var_1._id_005A._id_4348 delete();
      }

      var_1._id_005A delete();

      if(isDefined(var_1._id_0057._id_4348)) {
        var_1._id_0057._id_4348 delete();
      }

      var_1._id_0057 delete();

      if(isDefined(var_1._id_101AD)) {
        if(isDefined(var_1._id_101AD._id_4348)) {
          var_1._id_101AD._id_4348 delete();
        }

        var_1._id_101AD delete();
      }

      scripts\sp\utility::_id_228A(var_1._id_C743);
    }
  }

  foreach(var_4 in getEntArray("trigger_multiple_friendly", "classname")) {
    if(isDefined(var_4._id_EE52) && var_4._id_EE52 == "allytrig_hangar_c12") {
      var_4 scripts\engine\utility::trigger_off();
    }
  }

  level._id_FD4C = undefined;

  if(isDefined(level._id_8A34)) {
    foreach(var_7 in level._id_8A34) {
      var_7 scripts\sp\utility::anim_stopanimScripted();
      scripts\sp\utility::_id_228A(var_7.partnerheli);
      var_7 delete();
    }
  }

  scripts\engine\utility::flag_clear("hangar_shiplist_fx_enabled");
}

_id_108C0() {
  self endon("death");
  var_0 = self.maxfaceenemydist;
  self.ignoreall = 1;
  self.maxfaceenemydist = 128;
  self waittill("goal");
  self.ignoreall = 0;
  self.maxfaceenemydist = var_0;
}

_id_1089A() {
  self._id_D6EE = ::_id_50F7;
}

_id_50F7() {
  wait(randomfloatrange(4, 6));
}

_id_108C2() {
  self endon("death");
  self.maxfaceenemydist = 128;
  self.ignoreall = 0;
}

_id_108C1() {
  self.maxfaceenemydist = 128;
}

_id_108C5() {
  self endon("death");
  thread _id_108C2();
  scripts\sp\utility::_id_51E1("frantic");
  wait 5;
  thread scripts\sp\utility::_id_1938([self], 1000);
  self waittill("reached_path_end");
  self delete();
}

_id_684E() {
  wait 4;
  var_0 = scripts\sp\utility::_id_77DA("hangar_runners_pit");
  scripts\engine\utility::array_thread(var_0, ::_id_108C5);
  scripts\engine\utility::flag_set("hangar_runners_pit");
}

_id_684A() {
  scripts\engine\utility::flag_waitopen("ship_list_stopping");
  var_0 = scripts\engine\utility::getStruct("lift_01", "script_noteworthy");

  while((!level.player scripts\sp\utility::_id_D1DF(var_0.origin + (0, 0, 256), 0.5) || isDefined(level.player.melee)) && distance(level.player.origin, var_0.origin) > 600) {
    wait 0.5;
  }

  _id_0E29::_id_87A1();
  level._id_AD4F = -15;
  level._id_AD51 = 2;
  scripts\sp\maps\heist\heist_util::_id_CB09(1, 2000);
  level.player playSound("heist_mons_quakes");
  level.player playSound("pnr_elm_metalstress01");
  scripts\engine\utility::delaythread(2, ::_id_543C);
  thread _id_47E1();
  level._id_8632 rotateTo((0, 0, level._id_AD4F), level._id_AD51, 0.75, 0.75);
  level.player _meth_8291(0.25, 0.25, 0.25, level._id_AD51, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
  var_1 = vectorNormalize((0, -150, 0));
  var_1 = var_1 * 10;
  thread scripts\sp\maps\heist\heist_util::_id_4D77(var_1, 2);
  scripts\engine\utility::flag_set("start_hangar_shift_1");
  thread _id_C5E9("large_crate_01", "front", [135, 112], undefined, [130, 110]);
  wait(level._id_AD51);
  level._id_AD51 = 2;
  level._id_AD4F = -5;
  level._id_8632 rotateTo((0, 0, level._id_AD4F), level._id_AD51, level._id_AD51);
  wait(level._id_AD51);

  foreach(var_3 in getEntArray("pathblocker_hangar_shift_1", "targetname")) {
    var_3 connectpaths();
    var_3 delete();
  }

  foreach(var_6 in getEntArray("pathblocker_hangar_shift_1_player", "targetname")) {
    var_6 delete();
  }

  foreach(var_6 in getEntArray("pathblocker_hangar_shift_1_main", "targetname")) {
    var_6 solid();
  }

  thread scripts\sp\maps\heist\heist_util::_id_1103D();
  scripts\engine\utility::flag_set("event_hangar_bank_left_done");
}

_id_684B() {
  scripts\engine\utility::flag_wait("event_hangar_bank_left_done");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_waitopen("ship_list_stopping");
  var_0 = scripts\engine\utility::getStruct("big_lift", "script_noteworthy");

  while((!level.player scripts\sp\utility::_id_D1DF(var_0.origin + (0, 0, 256), 0.5) || distance(level.player.origin, var_0.origin) > 1100 || isDefined(level.player.melee)) && !scripts\engine\utility::flag("hangar_lift_2b_triggered")) {
    wait 0.1;
  }

  _id_0E29::_id_87A1();
  level._id_AD4F = 15;
  level._id_AD51 = 2;
  scripts\sp\maps\heist\heist_util::_id_CB09(-1, 2000);
  level.player playSound("heist_mons_quakes");
  level.player playSound("pnr_elm_metalstress01");
  scripts\engine\utility::delaythread(2, ::_id_543D);
  thread _id_47E2();
  level._id_8632 rotateTo((0, 0, level._id_AD4F), level._id_AD51, 0.75, 0.75);
  level.player _meth_8291(0.25, 0.25, 0.25, level._id_AD51, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
  var_1 = vectorNormalize((0, 150, 0));
  var_1 = var_1 * 10;
  thread scripts\sp\maps\heist\heist_util::_id_4D77(var_1, 2);
  scripts\engine\utility::flag_set("start_hangar_shift_2");
  wait(level._id_AD51);
  level._id_AD51 = 2;
  level._id_AD4F = 5;
  level._id_8632 rotateTo((0, 0, level._id_AD4F), level._id_AD51, level._id_AD51);
  wait(level._id_AD51);

  foreach(var_3 in getEntArray("pathblocker_hangar_shift_2", "targetname")) {
    var_3 connectpaths();
    var_3 delete();
  }

  foreach(var_6 in getEntArray("pathblocker_hangar_shift_2_player", "targetname")) {
    var_6 delete();
  }

  foreach(var_6 in getEntArray("pathblocker_hangar_shift_2_main", "targetname")) {
    var_6 solid();
  }

  thread scripts\sp\maps\heist\heist_util::_id_10D16();
}

_id_684C() {
  var_0 = scripts\sp\utility::_id_22CD("hangar_wave_one_door_one");
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_hangar_1_left", "door_hangar_1_right", 1);
  scripts\engine\utility::waitframe();

  for(var_1 = 0; var_1 < 5; var_1 = var_1 + 0.05) {
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    if(scripts\engine\utility::flag("hangar_door_one_close") || var_0.size == 0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  thread scripts\sp\maps\heist\heist_util::_id_4264("door_hangar_1_left", "door_hangar_1_right", 1);
}

_id_684D() {
  scripts\sp\utility::_id_127B3("hangar_door_2_spawn");
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_hangar_2_left", "door_hangar_2_right", 1);
  scripts\engine\utility::waitframe();
  var_0 = getEntArray("hangar_wave_one_door_two", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isspawner(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  for(var_5 = 0; var_5 < 5; var_5 = var_5 + 0.05) {
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
    var_1 = scripts\sp\utility::_id_22B9(var_1);

    if(scripts\engine\utility::flag("hangar_door_two_close") || var_1.size == 0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  thread scripts\sp\maps\heist\heist_util::_id_4264("door_hangar_2_left", "door_hangar_2_right", 1);
}

_id_5D72() {
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_EAFA();
  scripts\engine\utility::flag_set("allies_spawned");
  thread _id_5452();
  var_0 = scripts\engine\utility::getStruct("dropship_arrive", "targetname");
  scripts\engine\utility::array_thread([level._id_30F6, level._id_A54E], scripts\sp\utility::_id_F3B5, "r");
  level._id_6754 scripts\sp\utility::_id_F3B5("b");
  level._id_EA2C scripts\sp\utility::_id_F3B5("y");
  var_1 = _id_0BBF::_id_106B8(undefined, "helistruct_ally_dropship_land");
  var_1._id_1FBB = "dropship";
  var_1 scripts\sp\utility::_id_23B7();
  level._id_EA2C._id_FC6C = scripts\sp\utility::_id_10639("shield", var_0.origin);
  level._id_EA2C._id_FC6C hide();
  level._id_EA2C._id_FC6C thread scripts\sp\maps\heist\heist_flytomons::_id_5134();
  var_2 = [level._id_30F6, level._id_A54E, level._id_EA2C, level._id_EA2C._id_FC6C, level._id_6754, var_1];
  var_1 _id_0BBF::_id_F457();
  wait 1.25;
  var_1 scripts\engine\utility::delaycall(0.1, ::playsound, "scn_heist_dropship_dropping_off_allys");
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "mons_dropoff");
  scripts\engine\utility::delaythread(3, ::_id_426F);
  var_1 waittillmatch("single anim", "end");
  var_1 delete();
  level._id_EA2C scripts\sp\maps\heist\heist_util::_id_EAF9();
}

_id_C603() {
  thread scripts\sp\maps\heist\heist_util::_id_59B0("door_hangarbay_1_top", "up", 0.05, 244);
  thread scripts\sp\maps\heist\heist_util::_id_59B0("door_hangarbay_1_bottom", "down", 0.05, 244);
  var_0 = getEntArray("door_hangarbay_col", "targetname");

  foreach(var_2 in var_0) {
    var_2 notsolid();
  }
}

_id_426F(var_0) {
  if(scripts\engine\utility::flag("hangar_bay_doors_closed")) {
    return;
  }
  getEnt("door_hangarbay_col", "targetname") solid();
  var_1 = spawn("script_origin", (-10336, 16634, -86142));
  thread _id_111E4();
  var_2 = 5;

  if(isDefined(var_0) && var_0) {
    var_2 = 0.05;
  }

  thread scripts\sp\maps\heist\heist_util::_id_59B0("door_hangarbay_1_top", "down", var_2, 244);
  thread scripts\sp\maps\heist\heist_util::_id_59B0("door_hangarbay_1_bottom", "up", var_2, 244);
  var_1 playSound("scn_heist_hangar_door_close");
  var_1 playLoopSound("scn_heist_hangar_door_lp");
  wait(var_2);
  var_1 playSound("scn_heist_hangar_door_stop", "sounddone");
  scripts\engine\utility::flag_set("hangar_bay_doors_closed");
  var_1 stoploopsound("scn_heist_hangar_door_lp");
  var_1 waittill("sounddone");
  var_1 delete();
}

_id_111E4() {
  var_0 = 3;
  var_1 = 3;
  var_2 = int(var_0 * 20);
  var_3 = var_1 / var_2;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_1 = scripts\sp\utility::_id_E753(var_1 - var_3, 2);
    setsuncolorandintensity(var_1);
    wait 0.05;
  }

  setsuncolorandintensity(0);
}

_id_8A50() {
  scripts\sp\vehicle::_id_1080D("hangar_enemy_dropship_1");
  scripts\sp\vehicle::_id_1080D("hangar_enemy_dropship_2");
  scripts\engine\utility::flag_wait("enemy_dropship_2_unloading");
  scripts\sp\utility::_id_22CD("hangar_end_front_spawn");
}

_id_8A51() {}

_id_4274() {
  level endon("closing_lift_doors_player");
  var_0 = scripts\sp\utility::_id_22CB("enemy_hangar_c12_runners");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_5550);
  thread _id_C1A1(var_0);
  scripts\engine\utility::flag_wait("retreat_to_c12");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\sp\utility::_id_22B9(var_0);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F492, 1.3);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F415, 1);
  scripts\sp\maps\heist\heist_util::_id_1378F("trig_use_lift", var_0);
  level notify("closing_lift_doors");
  thread scripts\sp\maps\heist\heist_util::_id_4264("door_lift_lower_outer_left", "door_lift_lower_outer_right", 1);
  wait 0.5;
  scripts\sp\maps\heist\heist_util::_id_4264("door_lift_lower_left", "door_lift_lower_right", 1);
  scripts\sp\utility::_id_228A(var_0);
}

_id_C1A1(var_0) {
  level endon("closing_lift_doors");
  var_1 = getnode("node_retreat_final", "targetname");
  var_2 = squared(1024);

  while(distancesquared(level.player.origin, var_1.origin) > var_2) {
    wait 0.1;
  }

  level notify("closing_lift_doors_player");
  thread scripts\sp\maps\heist\heist_util::_id_4264("door_lift_lower_outer_left", "door_lift_lower_outer_right", 1);
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\sp\utility::_id_22B9(var_0);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_D282);
}

_id_9616() {
  var_0 = getEnt("hangar_lift_1", "script_noteworthy");
  thread scripts\sp\utility::_id_F3AB(var_0, "hangar_lift_1_triggered");
  var_0 = getEnt("hangar_lift_2b", "script_noteworthy");
  thread scripts\sp\utility::_id_F3AB(var_0, "hangar_lift_2b_triggered");
}

_id_1072C(var_0) {
  var_1 = getEnt(self.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = getEntArray(self.script_linkto, "script_linkname");
  var_4 = scripts\engine\utility::getStructArray(self.script_linkto, "script_linkname");
  var_5 = getnodearray(self.script_linkto, "script_linkname");
  var_6 = scripts\engine\utility::array_combine(var_3, var_4, var_5);
  var_7 = [];
  var_8 = undefined;
  var_9 = undefined;
  var_10 = [];
  var_0 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;

  foreach(var_16 in var_6) {
    if(isDefined(var_16.classname) && scripts\engine\utility::string_starts_with(var_16.classname, "actor_enemy")) {
      var_7 = scripts\engine\utility::array_add(var_7, var_16);
    }

    if(isDefined(var_16._id_EE52)) {
      switch (var_16._id_EE52) {
        case "start":
          var_12 = var_16;
          break;
        case "end":
          var_13 = var_16;
          break;
        case "platform":
          if(var_16.classname == "script_model") {
            break;
          }

          var_11 = var_16;
          break;
        case "obstacle":
          var_14 = var_16;
          break;
      }
    }
  }

  if(issubstr(var_11.targetname, "big_lift")) {
    var_18 = var_11.origin + (0, 0, 8);

    foreach(var_20 in var_7) {
      var_20.origin = (var_20.origin[0], var_20.origin[1], var_18[2]);
      var_20.linkpoint = var_20 scripts\engine\utility::spawn_tag_origin();
      var_20.linkpoint linkTo(var_11);
    }
  }

  if(isDefined(var_0)) {
    var_10 = getEntArray("light_mons_" + var_0, "script_noteworthy");
    var_0 = var_0;

    foreach(var_23 in var_10) {
      var_23.origin = var_23.origin - (0, 0, var_13.origin[2] - var_11.origin[2]);
      var_23 scripts\engine\utility::delaycall(0.05, ::linkto, var_11);
    }
  }

  self waittill("trigger");

  if(isDefined(var_0)) {
    level notify(var_0);
  }

  if(issubstr(var_11.targetname, "big_lift")) {
    scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "retreat_to_c12");
  }

  if(var_7.size > 0) {
    var_8 = [];

    foreach(var_20 in var_7) {
      var_26 = var_20 scripts\sp\utility::_id_10619(1);

      if(issubstr(var_11.targetname, "big_lift")) {
        var_26 linkTo(var_20.linkpoint, "tag_origin", (0, 0, 0), (0, 0, 0));
      }

      var_8[var_8.size] = var_26;
    }

    foreach(var_26 in var_8) {
      if(!isalive(var_26)) {
        continue;
      }
      if(isDefined(var_26.classname) && var_26.classname == "actor_enemy_c12") {
        level._id_8A26 = var_26;
        var_9 = scripts\engine\utility::spawn_tag_origin((-12640.1, 15810.6, -86344), (1.9995, 359.998, 0));
        var_9 linkTo(var_26, "tag_origin");
        playFXOnTag(scripts\engine\utility::getfx("vfx_heist_steam_vent_elevator_lrg_01"), var_9, "tag_origin");
        playFXOnTag(scripts\engine\utility::getfx("vfx_heist_steam_vent_elevator_sml_01"), var_9, "tag_origin");
      }
    }
  }

  wait(var_2._id_ED75 + 0.1);

  if(isDefined(var_14)) {
    var_14 connectpaths();
    var_14 delete();
  }

  if(isDefined(var_9) && var_11.targetname == "big_lift") {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_heist_steam_vent_elevator_lrg_01"), var_9, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_heist_steam_vent_elevator_sml_01"), var_9, "tag_origin");
    var_9 delete();
  }

  foreach(var_31 in var_6) {
    if(isDefined(var_31.classname) && var_31.classname == "script_brushmodel") {
      if(isDefined(var_31.targetname) && !issubstr(var_31.targetname, "big_lift")) {
        var_31 _meth_80AF(undefined);
      }
    }
  }

  if(isDefined(var_8)) {
    foreach(var_26 in var_8) {
      if(!isalive(var_26)) {
        continue;
      }
      var_26 scripts\sp\utility::_id_F415(0);

      if(issubstr(var_11.targetname, "big_lift")) {
        var_26 unlink();
      }

      if(isDefined(var_26.classname) && var_26.classname == "actor_enemy_c12") {
        var_26 thread scripts\sp\utility::_id_F2DA(0);
        var_26 scripts\engine\utility::delaythread(2.4, _id_0A05::_id_3551, 1);
      }

      if(isDefined(var_26.target)) {
        var_26 setgoalpos(var_26.origin);
        var_34 = getnode(var_26.target, "targetname");

        if(!isDefined(var_34)) {
          var_34 = getEnt(var_26.target, "targetname");
        }

        var_26 thread scripts\sp\utility::_id_7226(var_34);
      }
    }
  }
}

_id_10896(var_0, var_1, var_2, var_3) {
  var_0 = scripts\sp\maps\heist\heist_util::_id_2289(var_0);
  var_1 = scripts\sp\maps\heist\heist_util::_id_2289(var_1);
  var_2 = scripts\sp\maps\heist\heist_util::_id_2289(var_2);
  var_3 = scripts\sp\maps\heist\heist_util::_id_2289(var_3);

  if(!isDefined(var_3)) {
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_3[var_4] = 0;
    }
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(isDefined(var_2) && isDefined(var_2[var_4])) {
      self thread[[var_2[var_4]]]();
    }

    scripts\engine\utility::delaythread(var_3[var_4], ::_id_C5E9, var_0[var_4], var_1[var_4]);
  }
}

_id_10897() {
  self endon("death");
  thread _id_C5E9("small_crate_01", "front", [220, 200], [0.65, 0.75]);
  var_0 = scripts\engine\utility::getStruct("struct_small_crate_01", "targetname");
  self._id_1FBB = "c6";
  self.allowdeath = 1;
  scripts\sp\utility::_id_5504();
  scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [self], "crate_kick", 0.65);
  var_0 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F27, [self], "crate_kick", 1.2);
  scripts\engine\utility::delaythread(1, scripts\sp\utility::anim_stopanimscripted);
  scripts\engine\utility::delaythread(1, scripts\sp\utility::play_sound_on_entity, "metal_door_kick");
  var_0 scripts\sp\anim::_id_1F35(self, "crate_kick");
  scripts\engine\utility::flag_wait("retreat_to_initial");
  scripts\sp\utility::_id_61DB();
}

_id_10898() {}

_id_9613() {
  _id_317F("small_crate_01", "back", undefined, [70, 120]);
  var_0 = _id_317F("large_crate_01", "back", undefined, [90, 90]);
  var_0._id_005A _id_52A4(1);
  var_0 = _id_317F("c12_fight_trick_crate01", "front", [150, 0], undefined);
  var_0.front_right _id_52A4(1);
  _id_317F("c12_fight_trick_crate02", "back", undefined, [0, 90]);
  _id_52A3("c12_fight_trick_crate02", "back", 1);
  _id_317F("c12_fight_trick_crate03", "back", undefined, undefined);
  _id_52A3("c12_fight_trick_crate03", "back", 1);
}

_id_317F(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_8A35)) {
    level._id_8A35 = [];
  }

  if(isDefined(level._id_8A35[var_0])) {
    return level._id_8A35[var_0];
  }

  var_4 = spawnStruct();
  var_4._id_C743 = [];
  var_4.spawners = [];
  var_4._id_571C = [];

  foreach(var_6 in getEntArray(var_0, "script_noteworthy")) {
    if(isspawner(var_6)) {
      var_4.spawners[var_4.spawners.size] = var_6;
      continue;
    }

    if(issubstr(var_6.classname, "script_model") && isDefined(var_6.script_parameters)) {
      if(isDefined(var_6.target)) {
        var_6._id_4348 = getEnt(var_6.target, "targetname");
        var_6._id_4348 disconnectPaths();
      }

      if(var_6.script_parameters == "front_right") {
        var_4.front_right = var_6;
      } else if(var_6.script_parameters == "front_left") {
        var_4.front_left = var_6;
      } else if(var_6.script_parameters == "back_right") {
        var_4._id_005A = var_6;
      } else if(var_6.script_parameters == "back_left") {
        var_4._id_0057 = var_6;
      } else if(var_6.script_parameters == "side") {
        var_4._id_101AD = var_6;
      }

      continue;
    }

    var_4._id_C743[var_4._id_C743.size] = var_6;
  }

  if(isDefined(var_4._id_101AD)) {
    var_4._id_101AD._id_4348 linkTo(var_4._id_101AD);
  }

  foreach(var_9 in scripts\engine\utility::getStructArray(var_0, "script_noteworthy")) {
    if(isDefined(var_9.targetname) && var_9.targetname == "robot_distro") {
      var_4._id_571C[var_9.script_index] = var_9;
    }
  }

  level._id_8A35[var_0] = var_4;
  var_11 = 0;
  var_1 = scripts\sp\maps\heist\heist_util::_id_2289(var_1);

  if(isDefined(var_1)) {
    foreach(var_13 in var_1) {
      if(var_13 == "front") {
        thread _id_C5E9(var_0, var_13, var_2, 0.05);
      } else {
        thread _id_C5E9(var_0, var_13, var_3, 0.05);
      }

      var_11 = 2;
    }
  }

  return var_4;
}

_id_C5E9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_317F(var_0);

  if(!isDefined(var_5)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = [120, 120];
  } else {
    var_2 = scripts\sp\maps\heist\heist_util::_id_2289(var_2);
  }

  if(!isDefined(var_2[1])) {
    var_2[1] = var_2[0];
  }

  var_6 = [0, 0];

  if(!isDefined(var_4)) {
    var_4 = [180, 180];
  }

  for(var_7 = 0; var_7 < 2; var_7++) {
    if(var_2[var_7] > var_4[var_7]) {
      var_6[var_7] = clamp((var_2[var_7] - var_4[var_7]) * 2, 0, 70);
      var_2[var_7] = var_4[var_7];
    }
  }

  if(!isDefined(var_3)) {
    var_3 = [0.65, 0.65];
  } else {
    var_3 = scripts\sp\maps\heist\heist_util::_id_2289(var_3);
  }

  if(!isDefined(var_3[1])) {
    var_3[1] = var_3[0];
  }

  var_8 = [0, 0];

  for(var_7 = 0; var_7 < 2; var_7++) {
    var_8[var_7] = var_6[var_7] / var_4[var_7] * var_3[var_7];
  }

  if(var_1 == "front") {
    var_5.front_left thread _id_C5EA(var_2[0] * -1, var_3[0], var_6[0], var_8[0]);
    var_5.front_right thread _id_C5EA(var_2[1], var_3[1], var_6[1], var_8[1]);
  } else if(var_1 == "back") {
    var_5._id_0057 thread _id_C5EA(var_2[0] * -1, var_3[0], var_6[0], var_8[0]);
    var_5._id_005A thread _id_C5EA(var_2[1], var_3[1], var_6[1], var_8[1]);
  } else if(var_1 == "side")
    var_5._id_101AD rotateroll(-90, 1.75, 0.05, 0.05);
}

_id_C5EA(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;

  if(var_2 == 0) {
    var_5 = var_1 * 0.25;
  }

  self rotateYaw(var_0, var_1, var_4, var_5);
  self._id_4348 rotateYaw(var_0, var_1, var_4, var_5);
  var_6 = var_1;
  self._id_4348 scripts\engine\utility::delaycall(var_6, ::connectpaths);

  if(var_2 != 0) {
    if(var_0 > 0) {
      var_2 = var_2 * -1;
    }

    scripts\engine\utility::delaycall(var_1, ::rotateyaw, var_2, var_1 * 2, 0, var_1 * 2);
    self._id_4348 scripts\engine\utility::delaycall(var_1, ::rotateyaw, var_2, var_1 * 2, 0, var_1 * 2);
    var_6 = var_6 + var_1 * 2;
  }

  self._id_4348 scripts\engine\utility::delaycall(var_6, ::disconnectpaths);
}

_id_52A3(var_0, var_1, var_2) {
  var_3 = _id_317F(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  switch (var_1) {
    case "front":
      var_3.front_left _id_52A4(var_2, 1);
      var_3.front_right _id_52A4(var_2, -1);
      break;
    case "back":
      var_3._id_0057 _id_52A4(var_2, 1);
      var_3._id_005A _id_52A4(var_2, -1);
      break;
  }
}

_id_52A4(var_0, var_1) {
  self._id_4348 connectpaths();
  self._id_4348 delete();
  self unlink();

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = anglesToForward(self.angles) * 64;
  var_2 = var_2 + anglestoright(self.angles) * 128 * var_1;
  var_3 = (128, 128 * var_1 * -1, 0);
  self rotatevelocity(var_3, 5);
  self movegravity(var_2, 5);
}

_id_E582(var_0, var_1) {
  var_2 = _id_317F(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = [1, 2, 3, 4, 5];
  }

  if(var_2.spawners.size < var_1.size) {
    return;
  }
  foreach(var_4 in var_1) {
    var_5 = var_2._id_571C[var_4];
    var_6 = var_5 scripts\engine\utility::spawn_tag_origin();
    var_6._id_215D = scripts\sp\utility::_id_10639("locker_arm", var_5.origin, var_5.angles);
    var_7 = scripts\engine\utility::random(var_2.spawners);
    var_2.spawners = scripts\engine\utility::array_remove(var_2.spawners, var_7);
    var_7.count = 1;
    var_6._id_1912 = var_7 scripts\sp\utility::_id_10619(1);
    var_6._id_1912._id_1FBB = "c6";
    var_6 scripts\sp\anim::_id_1EC1([var_6._id_1912, var_6._id_215D], "locker_deploy");
    var_8 = randomfloatrange(0, 0.5);
    var_6._id_215D scripts\engine\utility::delaycall(var_8, ::linkto, var_6);
    var_6 scripts\engine\utility::delaythread(var_8, ::_id_E583);
    var_6 scripts\engine\utility::delaythread(var_8 + 0.1, scripts\sp\anim::_id_1F2C, [var_6._id_1912, var_6._id_215D], "locker_deploy");
    var_6 scripts\engine\utility::delaythread(var_8 + 0.1, ::_id_E584);
    var_2._id_C743[var_2._id_C743.size] = var_6._id_215D;
  }

  thread _id_C5E9(var_0, "side");
}

_id_E583() {
  self._id_1912._id_BCDA = self._id_1912 scripts\engine\utility::spawn_tag_origin();
  self._id_1912 linkTo(self._id_1912._id_BCDA, "tag_origin", (0, 0, 0), (0, 0, 0));
  self._id_1912._id_BCDA linkTo(self);
}

_id_E584() {
  var_0 = 256;
  var_1 = self.origin;
  var_2 = anglesToForward(self.angles);
  self moveTo(self.origin + var_2 * 64, 1.2);
  wait 1.2;
  self._id_1912._id_BCDA unlink();
  scripts\engine\utility::delaycall(1, ::moveto, var_1, 1);
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_F1DE);
  var_3 = getgroundposition(self._id_1912.origin, 1);
  var_4 = distance(self._id_1912.origin, var_3) / var_0;
  var_5 = self._id_1912._id_BCDA.origin - (0, 0, self._id_1912.origin[2] - var_3[2]);
  self._id_1912._id_BCDA moveTo(var_5, var_4, var_4, 0);
  self._id_1912._id_BCDA scripts\engine\utility::delaythread(var_4 + 1, scripts\sp\utility::_id_F1DE);
}

_id_9612() {
  level._id_8A34 = [];

  foreach(var_1 in scripts\engine\utility::getStructArray("model_hangar_cranes", "script_noteworthy")) {
    var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_3 = scripts\sp\utility::_id_10639("hangar_crane", var_1.origin, var_1.angles);
    var_4 = scripts\sp\utility::_id_10639("hangar_crane_gun", var_2.origin, var_2.angles);
    var_5 = getEnt(var_1.target, "targetname");
    var_6 = var_1.script_delay;
    var_3.partnerheli = [];
    var_3.partnerheli[var_3.partnerheli.size] = var_4;
    var_3.partnerheli[var_3.partnerheli.size] = var_5;
    var_4 linkTo(var_3, "tag_hook");
    var_5 linkTo(var_3, "tag_hook");
    level._id_8A34[level._id_8A34.size] = var_3;
  }

  level._id_FD4C = ::_id_47E0;
}

_id_47E0() {
  foreach(var_1 in level._id_8A34) {
    var_1 endon("death");

    if(!isDefined(var_1._id_11360)) {
      var_1._id_11360 = randomfloatrange(2, 2.05);
    }

    wait(var_1._id_11360);
    var_2 = "crane_left";

    if(level._id_AD4F < 0) {
      var_2 = "crane_right";
    }

    level._id_4B5F = var_2;
    var_1 thread scripts\sp\anim::_id_1F35(var_1, var_2);
  }
}

_id_47E1() {
  var_0 = "crane_left_hard_10";

  if(issubstr(level._id_4B5F, "left")) {
    var_0 = "crane_right_hard_20";
  }

  if(getdvarint("debug_cranes", 0)) {
    iprintln(level._id_4B5F);
    iprintln(var_0);
  }

  foreach(var_2 in level._id_8A34) {
    var_2 thread scripts\sp\anim::_id_1F35(var_2, var_0);
  }
}

_id_47E2() {
  var_0 = "crane_right_hard_10";

  if(issubstr(level._id_4B5F, "right")) {
    var_0 = "crane_left_hard_20";
  }

  if(getdvarint("debug_cranes", 0)) {
    iprintln(level._id_4B5F);
    iprintln(var_0);
  }

  foreach(var_2 in level._id_8A34) {
    var_2 thread scripts\sp\anim::_id_1F35(var_2, var_0);
  }
}

_id_5ACB(var_0) {
  self endon("death");
  var_1 = var_0.origin - self gettagorigin("tag_hook");
  var_2 = self gettagangles("tag_hook");

  for(;;) {
    var_0.origin = self gettagorigin("tag_hook") + var_1;
    var_3 = self gettagangles("tag_hook");
    var_0 rotateroll(var_3[0] - var_2[0], 0.05);
    scripts\engine\utility::waitframe();
    var_2 = var_3;
  }
}

_id_E287() {
  level.respawn = 1;
  thread respawn_test();
  scripts\sp\utility::_id_22CD("hangar_filler_wave");
  wait 0.05;

  while(level.respawn == 1) {
    var_0 = scripts\sp\utility::_id_77DA("aigroup_hangar_filler_wave");

    if(var_0.size < 3) {
      var_1 = getEnt("hangar_middle_respawn", "targetname");
      var_1.count = 1;
      var_1 thread _id_0B77::_id_1A17(level._id_1162["aigroup_hangar_filler_wave"]);
      var_1 scripts\sp\utility::_id_10619(1);
    }

    wait 3;
  }

  level notify("stop_respawn_runners");
  var_2 = getnode("delete_node_hangar3", "targetname");
  var_0 = scripts\sp\utility::_id_77DA("aigroup_hangar_filler_wave");

  foreach(var_4 in var_0) {
    var_4.ignoreall = 1;
    var_4.goalradius = 32;
    var_4 scripts\sp\utility::_id_F3D9(var_2);
    var_4 thread respawn_test_trig_setup();
  }
}

respawn_test_trig_setup() {
  self endon("death");
  self waittill("reached_path_end");

  if(isDefined(self)) {
    self delete();
  }
}

respawn_test() {
  level endon("stop_respawn_runners");

  for(;;) {
    wait(randomfloatrange(6, 14));

    if(scripts\engine\utility::cointoss()) {
      var_0 = getspawnerarray("respawn_runners_into_hangar2");

      foreach(var_2 in var_0) {
        if(scripts\engine\utility::cointoss()) {
          var_2.count = 1;
          var_2 scripts\sp\utility::_id_10619(1);
        }
      }

      continue;
    }

    var_0 = getspawnerarray("respawn_runners_exit_hangar2");

    foreach(var_2 in var_0) {
      if(scripts\engine\utility::cointoss()) {
        var_2.count = 1;
        var_2 scripts\sp\utility::_id_10619(1);
      }
    }
  }
}

_id_157B(var_0, var_1, var_2) {
  self notify("stop_action_on_endpath");
  self endon("stop_action_on_endpath");
  self endon("death");

  if(isDefined(var_2)) {
    for(;;) {
      var_3 = _id_13777();

      if(var_3 == var_2) {
        break;
      }

      self waittill("go_to_node_new_goal");
    }
  }

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self waittill("reached_path_end");

  if(isDefined(var_0)) {
    self thread[[var_0]]();
  }
}

_id_13777() {
  self endon("death");

  for(;;) {
    if(isDefined(self._id_A906)) {
      return self._id_A906;
    }

    if(isDefined(self._id_A905)) {
      return self._id_A905;
    }

    self waittill("go_to_node_new_goal");
  }
}

_id_E351() {
  thread scripts\sp\utility::_id_1938([self], 1500);
}

_id_5FB2() {
  var_0 = 2;
  var_1 = getEnt("vol_final_retreat_check", "targetname");
  level endon("retreat_to_c12");
  wait 5;

  for(;;) {
    scripts\engine\utility::waitframe();
    var_2 = var_1 scripts\sp\utility::_id_77E3("axis");

    if(var_2.size <= var_0) {
      scripts\engine\utility::flag_set("retreat_to_final");
      scripts\engine\utility::flag_set("early_final_retreat");
    }
  }
}

_id_5452() {
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  wait 1;
  scripts\sp\utility::_id_10350("heist_plt_bravoteamisonth");
  scripts\engine\utility::flag_wait("player_on_mons_getup");
  level.player scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\sp\utility::_id_1034D("heist_plr_oneonein");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio");
  level._id_6754 scripts\sp\utility::_id_10346("prisoner_eth_dropblastcutthe");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
}

_id_543C() {
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_stillunstablefr");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
}

_id_543D() {
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_shesrollinghard");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
}

_id_5464() {
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_mechsontheeleva");
  level._id_A54E scripts\sp\utility::_id_10346("heist_ksh_notgood");
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_tightenupkash");
  level._id_A54E scripts\sp\utility::_id_10346("heist_ksh_yesmaam");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
}

_id_5465() {}