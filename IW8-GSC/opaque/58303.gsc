/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58303.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_A7B70BDA8379AF0EA00B9A8333"] = ::init;
}

init() {
  _tablethide::trial_ui_set_subscore(0);
  dialog_init();
  setDvar("_encstr_85F6186F966321C7B788A810A5332B2B8053CC380BD9E150DDC5", 1);
  setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", -1);
  level._id_13D73 = ::_id_12F00;
  level._id_13D71 = ::_id_12EFF;
  level._id_13D76 = ::_id_12F02;
  level._id_13D7A = ::_id_13A60;
  level._id_13D7B = ::_id_13A5B;
  level._id_13D84 = ::_id_12F05;
  level._id_13D85 = ::turret_think;
  level.civilian_targets = [];
  level.enemy_targets = [];

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_triggers = getEntArray("_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.course_targets = _stop_spawn_modules::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("_encstr_8D6A0CDAEDECCA93EBCDD12C39D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level._id_13D92 = scripts\engine\utility::getStructArray("_encstr_B8C1102B93A767A8595FDDE3298B5A3B7BC8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_12F06();
  build_vehicle_drop_off_list();
  set_wave_num();

  foreach(var_1 in level._id_13D92)
  var_1 thread _id_1418E();

  foreach(var_4 in level.course_triggers)
  var_4 thread _stop_spawn_modules::_id_13D82();

  foreach(var_4 in level.course_targets)
  var_4 thread _stop_spawn_modules::_id_13D79();

  level._id_13A94 = 1;
  thread _id_124D9();
  thread progression();
}

set_wave_num() {
  _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::seticonnames();

  if(level.trial["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
    level._id_13D56 = "_encstr_8E8405EA382B2A";
    level.startingfobnames_allies = [];
    level.startingfobnames_axis = ["_encstr_84790A3BE767F9EF0AF1078F", "_encstr_8A790ADC87B90C78B8366A32", "_encstr_85790AFFD88E0E9AB5D8724A", "_encstr_95790A27CFC727EA2891A293", "_encstr_B4790A3F7337CA8F9687DA83"];
    level.startingfobnames_neutral = [];
  } else {
    level._id_13D56 = "_encstr_9A8507BA4040188D08";
    level.startingfobnames_allies = ["_encstr_84790A3BE767F9EF0AF1078F", "_encstr_8A790ADC87B90C78B8366A32", "_encstr_85790AFFD88E0E9AB5D8724A", "_encstr_95790A27CFC727EA2891A293", "_encstr_B4790A3F7337CA8F9687DA83"];
    level.startingfobnames_axis = [];
    level.startingfobnames_neutral = [];
  }

  level.gw_objstruct = spawnStruct();
  _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::setupobjectives();

  if(level.trial["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08")
    var_0 = level.gw_objstruct.startingfobs_axis;
  else
    var_0 = level.gw_objstruct.startingfobs_allies;

  level.allfobs = [];
  level.bridge_one_death_func = [];

  foreach(var_2 in var_0)
  var_2 thread playerfadeobjdelete();

  thread audio_enablepa();
}

playerfadeobjdelete() {
  level.allfobs[level.allfobs.size] = self;
  level.bridge_one_death_func[level.bridge_one_death_func.size] = self.trigger;
  self.trigger.playerexitsafearea = self;
  self.activated = 0;

  while(!istrue(level._id_13A94))
    waitframe();

  self.targets = getEntArray("_encstr_A90B0B7EC708C9F39763426ACB" + self.trigger.objkey, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in self.targets) {
    if(istrue(var_1.is_civilian))
      self.targets = scripts\engine\utility::array_remove(self.targets, var_1);
  }

  if(self.targets.size == 0) {
    return;
  }
  self.objective = scripts\mp\gameobjects::createobjidobject(self.trigger.origin, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 100), undefined, "_encstr_9A19040BCDBC");
  var_3 = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A" + self.trigger.objkey;
  scripts\mp\objidpoolmanager::update_objective_icon(self.objective.objidnum, scripts\mp\gameobjects::getwaypointshader(var_3));
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objective.objidnum, scripts\mp\gameobjects::getwaypointbackgroundtype(var_3));
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level._id_13D56);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 1);

  for(;;) {
    if(isDefined(level._id_13D21) && self == level._id_13D21) {
      objective_state(self.objective.objidnum, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 0);
    } else
      objective_state(self.objective.objidnum, "_encstr_AF5A081BBAC993AC73A3");

    var_4 = 0;

    foreach(var_1 in self.targets) {
      if(var_1.activated && !istrue(var_1.is_civilian)) {
        scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 1);
        var_4++;
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(self.objective.objidnum, var_4 / self.targets.size);

    if(var_4 >= self.targets.size) {
      break;
    }

    waitframe();
  }

  self.activated = 1;
  scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.trial["_encstr_8AEF05472BC2D6"]);
  wait 1;
  _id_12F01();
}

audio_enablepa() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

  for(;;) {
    var_0 = scripts\engine\utility::getclosest(level.player.origin, level.enemy_targets, 1000);

    if(isDefined(var_0))
      level._id_13D21 = var_0.playerexitsafearea;
    else
      level._id_13D21 = undefined;

    waitframe();
  }
}

_id_13A5B() {
  for(;;) {
    if(!self.activated && isDefined(level._id_13D21) && self.playerexitsafearea == level._id_13D21) {
      var_0 = scripts\mp\gameobjects::createobjidobject(self.origin, level._id_13D56, (0, 0, 0), undefined, "_encstr_9A19040BCDBC");
      objective_state(var_0.objidnum, "_encstr_930B07BB1B6B3854FF");
      objective_setplayintro(var_0.objidnum, 0);

      if(!istrue(self.is_civilian))
        objective_icon(var_0.objidnum, "_encstr_88EE132D6CBDDCAFD6B4E6B4B5B0E0BECAB9955BBC");

      objective_setbackground(var_0.objidnum, 1);
      objective_setfadedisabled(var_0.objidnum, 0);
      objective_setshowoncompass(var_0.objidnum, 1);
      objective_setminimapiconsize(var_0.objidnum, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
      objective_setshowdistance(var_0.objidnum, 0);
      objective_setownerteam(var_0.objidnum, level._id_13D56);

      if(!istrue(self.is_civilian))
        thread _id_13A66();

      while(!self.activated && isDefined(level._id_13D21) && self.playerexitsafearea == level._id_13D21)
        waitframe();

      scripts\mp\objidpoolmanager::returnobjectiveid(var_0.objidnum);
    }

    waitframe();
  }
}

_id_13A66() {
  self notify("_encstr_A52B1153D023F82F4D6358D2C307EB659FA0E8");
  self endon("_encstr_A52B1153D023F82F4D6358D2C307EB659FA0E8");
  self._id_12383 = gettime() + 40000;

  while(gettime() < self._id_12383)
    waitframe();

  var_0 = scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "_encstr_9A3B1AFFCD1B5A04FD5F023BF499B1EB3FF24AA3F33B11A3F0DA7D19", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  while(!self.activated && isDefined(level._id_13D21) && self.playerexitsafearea == level._id_13D21)
    waitframe();

  scripts\mp\utility\outline::outlinedisable(var_0, self.plate);
}

_id_13A60() {
  var_0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);
  self.targetname = "_encstr_A90B0B7EC708C9F39763426ACB" + var_0.objkey;
  self.playerexitsafearea = var_0.playerexitsafearea;
}

_id_13E6A() {
  while(!isDefined(level.bridge_one_death_func))
    waitframe();

  var_0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);
  self.playerexitsafearea = var_0.playerexitsafearea;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
  self turretfiredisable();

  for(;;) {
    if(isalive(self) && isDefined(level._id_13D21) && self.playerexitsafearea == level._id_13D21) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.minimapid);

      if(isDefined(level._id_13D3D))
        self turretfireenable();

      while(isalive(self) && isDefined(level._id_13D21) && self.playerexitsafearea == level._id_13D21)
        waitframe();

      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
      self turretfiredisable();
    }

    waitframe();
  }
}

_id_1418E() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  var_0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);

  while(!var_0.playerexitsafearea.activated)
    waitframe();

  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", self);
  var_1.playerexitsafearea = var_0.playerexitsafearea;
  var_1 thread _id_141FE();
}

progression() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  var_0 = gettime();

  while(gettime() > var_0 + 8000 && !level.player isonground())
    waitframe();

  _tablethide::trial_ui_freeze_secondary_timer(1);
  var_1 = gettime() + 180000 + 500;
  _tablethide::trial_ui_set_secondary_timer(-1);

  while(!level.player isonground())
    waitframe();

  level notify("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  level._id_13D3D = gettime() + 180000;
  _tablethide::trial_ui_set_secondary_timer(level._id_13D3D);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  level._id_13D6A = 1;
  thread _id_12CBC();
  thread _id_1246C();
  _tablethide::_id_13D88();
  _tablethide::_id_13D89(0);
  _id_143C7();
  score_event_time_remaining();
}

_id_124D9() {
  _tablethide::waittill_player_isDefined();
  scripts\mp\outofbounds::enableoobimmunity(level.player);

  while(!isalive(level.player))
    waitframe();

  while(!level.player isskydiving()) {
    level.player skydive_beginfreefall();
    waitframe();
  }

  while(level.player scripts\mp\outofbounds::istouchingoobtrigger())
    waitframe();

  level.player skydive_deployparachute();
  scripts\mp\outofbounds::disableoobimmunity(level.player);
  level.player skydive_cutautodeployon();
  level.player getclientomnvar();

  while(!level.player isparachuting())
    waitframe();

  while(!level.player isonground())
    waitframe();
}

_id_143C7() {
  level.player_died_during_course = 1;
  level.player endon("_encstr_AD75063D571AE108");

  while(isalive(level.player)) {
    var_0 = 1;
    var_1 = 1;

    foreach(var_3 in level.enemy_targets) {
      if(!var_3.activated)
        var_0 = 0;
    }

    if(gettime() < level._id_13D3D)
      var_1 = 0;

    if(var_0 || var_1) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

_id_12CBC() {
  _tablethide::trial_ui_waittill_retry();
  _tablethide::_id_13D5E();
}

turret_think() {
  thread _id_13E75();
  thread _id_13E6A();
  thread _id_13E69();
}

_id_13E75() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8FCA0D31D5D8C656E8BE664B4E2B19");
    var_0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "_encstr_847E18A5C56942E140B80307C8389F2A07D5AF1A2DF9C922C958", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

    while(isalive(self) && isDefined(level._id_13D21) && self.playerexitsafearea == level._id_13D21)
      waitframe();

    scripts\mp\utility\outline::outlinedisable(var_0, self);
    waitframe();
  }
}

_id_13E69() {
  self endon("_encstr_AD75063D571AE108");

  while(!isDefined(self.playerexitsafearea))
    waitframe();

  while(!self.playerexitsafearea.activated)
    waitframe();

  while(isalive(self)) {
    self dodamage(99999, self.origin);
    waitframe();
  }
}

_id_141FE() {
  var_0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  var_1 = 0;

  for(;;) {
    var_2 = distance(level.player.origin, self.origin);

    foreach(var_4 in level.allfobs) {
      if(var_4 == self.playerexitsafearea) {
        continue;
      }
      if(distance(level.player.origin, var_4.trigger.origin) < var_2) {
        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      break;
    }

    if(isDefined(level.player.vehicle)) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

_id_1246C() {
  var_0 = scripts\engine\utility::array_removeundefined(level.ammorestocklocs);

  for(;;) {
    for(;;) {
      var_1 = 0;
      var_2 = level.player getweaponslistprimaries();

      foreach(var_4 in var_2) {
        if(level.player getweaponammostock(var_4) < weaponclipsize(var_4)) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }

      waitframe();
    }

    var_6 = scripts\engine\utility::getclosest(level.player.origin, var_0, 1000);

    if(isDefined(var_6)) {
      var_7 = getEntArray(var_6.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_8 = undefined;

      foreach(var_10 in var_7) {
        if(var_10.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
          var_8 = var_10;
          break;
        }
      }

      var_12 = scripts\mp\utility\outline::outlineenableforplayer(var_8, level.player, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

      for(;;) {
        var_13 = 0;
        var_14 = scripts\engine\utility::getclosest(level.player.origin, var_0, 1000);

        if(!isDefined(var_14) || var_14 != var_6) {
          break;
        }

        var_2 = level.player getweaponslistprimaries();

        foreach(var_4 in var_2) {
          if(level.player getweaponammostock(var_4) >= weaponclipsize(var_4)) {
            var_13 = 1;
            break;
          }
        }

        if(var_13) {
          break;
        }

        waitframe();
      }

      scripts\mp\utility\outline::outlinedisable(var_12, var_8);
    }

    waitframe();
  }
}

_id_12F06() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["_encstr_AF9B051E1D0B0C"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
    level.score_initialized_once = 1;
  }

  level.score["_encstr_BE7D0633C08849E2"] = 0;
  level.score["_encstr_AAAC09701B829B88093F5B"] = 0;
  level.score["_encstr_87C60F1B1B71929F2819F5FEB0E0E19ADC"] = 0;
  level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"] = 0;
  level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"] = 0;
  level.score["_encstr_848909BBD3A7526348E8E3"] = 0;
  level.score["_encstr_8A0C0D9D304932A7516A1AD6664AF1"] = 0;
  level.score["_encstr_81290F84FB48022A046BE92A43F451D011"] = 0;
  level._id_13D80 = 180000;
  level._id_13D3E = 0;
  level._id_13D2B = 0;
  level._id_13D46 = 0;
  level._id_13D86 = 0;
  score_calculate();
}

score_calculate(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.score["_encstr_AAAC09701B829B88093F5B"] = level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"] + level.score["_encstr_848909BBD3A7526348E8E3"] + level.score["_encstr_8A0C0D9D304932A7516A1AD6664AF1"] + level.score["_encstr_81290F84FB48022A046BE92A43F451D011"];
  level.score["_encstr_BE7D0633C08849E2"] = level.score["_encstr_AAAC09701B829B88093F5B"] + level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"] + level.score["_encstr_87C60F1B1B71929F2819F5FEB0E0E19ADC"];

  if(istrue(level._id_13022))
    _id_12F0B(var_0);
  else
    thread _id_12F0B(var_0);

  _tablethide::trial_ui_set_subscore(level.score["_encstr_AAAC09701B829B88093F5B"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    _tablethide::_id_13D89(1);
    wait 1;

    if(level.score["_encstr_BE7D0633C08849E2"] < 0)
      level.score["_encstr_BE7D0633C08849E2"] = 0;

    _tablethide::trial_ui_set_main_score(level.score["_encstr_BE7D0633C08849E2"]);

    if(level.score["_encstr_AF9B051E1D0B0C"] < level.score["_encstr_BE7D0633C08849E2"]) {
      level.score["_encstr_AF9B051E1D0B0C"] = level.score["_encstr_BE7D0633C08849E2"];
      _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_8E8D0697EB01F243"] = level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"] = level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_850B08EBD30E1355884B"] = level.score["_encstr_81290F84FB48022A046BE92A43F451D011"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_AC790540CF1203"] = level.score["_encstr_8A0C0D9D304932A7516A1AD6664AF1"];
    }

    hud_set_reward_tier(1);
    thread _tablethide::trial_ui_open_results_screen();
  }
}

_id_12F0B(var_0) {
  level notify("_encstr_88461377E4D628284B8A9B0391C7FD306F5ADBE19D");
  level endon("_encstr_88461377E4D628284B8A9B0391C7FD306F5ADBE19D");

  while(!istrue(level._id_13022))
    waitframe();

  var_1 = 1;
  _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "_encstr_8B4F1847C22776CA3A37F5D6B48D8D59C8EB37B77D9C581D2D7B", level._id_13D3E, 0);
  var_1++;

  if(level._id_13D65.size) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "_encstr_8C82122358BB8AAAE9BED90FADCF7332A090FFEB", level._id_13D86, 0);
    var_1++;
  }

  if(level.civilian_targets.size) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", level._id_13D2B, level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"]);
    var_1++;
  }

  _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "_encstr_8A0C0D9D304932A7516A1AD6664AF1", level._id_13D46, 0);
  var_1++;

  if(var_0 && !level.player_died_during_course)
    _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "_encstr_87C60F1B1B71929F2819F5FEB0E0E19ADC", level._id_13D80, level.score["_encstr_87C60F1B1B71929F2819F5FEB0E0E19ADC"]);
}

hud_set_reward_tier(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    var_1 = level.score["_encstr_AF9B051E1D0B0C"];
  else
    var_1 = level.score["_encstr_AAAC09701B829B88093F5B"];

  if(var_1 >= level.trial["_encstr_966C066BF011B2F7"])
    var_2 = 3;
  else if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
    var_3 = level.trial["_encstr_966C066BF011B2F7"] - level.trial["_encstr_876C06B1FF0A66F2"];
    var_4 = var_1 - level.trial["_encstr_876C06B1FF0A66F2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
    var_3 = level.trial["_encstr_876C06B1FF0A66F2"] - level.trial["_encstr_816C069599555DA7"];
    var_4 = var_1 - level.trial["_encstr_816C069599555DA7"];
    var_2 = 1 + var_4 / var_3;
  } else
    var_2 = var_1 / level.trial["_encstr_816C069599555DA7"];

  if(var_0) {
    _tablethide::trial_ui_set_reward_tier(var_2);

    if(var_1 >= level.trial["_encstr_966C066BF011B2F7"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_6]);
      return;
    }

    if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"][var_6]);
      return;
    }

    if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"][var_6]);
      return;
    }

    var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
    var_6 = randomint(var_5);
    level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_6]);
    return;
    return;
    return;
  } else
    _tablethide::trial_ui_set_reward_tier_preview(var_2);
}

_id_12F00() {
  level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"] = level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"] + 50;
  level._id_13D3E++;
  level.player thread scripts\mp\rank::scorepointspopup(50);
  waitframe();
  score_calculate();
}

_id_12EFF() {
  level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"] = level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"] + -500;
  level._id_13D2B++;
  level.player playSound("_encstr_9B2017BDC63A5785BED74D9A778A753260F5CBEF2BF1D2F81B");
  waitframe();
  score_calculate();
}

_id_12F02() {
  level.score["_encstr_848909BBD3A7526348E8E3"] = level.score["_encstr_848909BBD3A7526348E8E3"] + 25;
  level.player thread scripts\mp\rank::scorepointspopup(25);
  waitframe();
  score_calculate();
}

_id_12F01() {
  level.score["_encstr_8A0C0D9D304932A7516A1AD6664AF1"] = level.score["_encstr_8A0C0D9D304932A7516A1AD6664AF1"] + 1000;
  level._id_13D46++;
  level.player thread scripts\mp\rank::scorepointspopup(1000);
  level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD");
  waitframe();
  score_calculate();
}

score_event_time_remaining() {
  _tablethide::trial_ui_freeze_secondary_timer(1);

  if(!level.player_died_during_course) {
    var_0 = level._id_13D3D - gettime();
    level._id_13D80 = clamp(var_0, 0, pow(2, 31) - 2);
    level.score["_encstr_87C60F1B1B71929F2819F5FEB0E0E19ADC"] = scripts\mp\utility\script::limitdecimalplaces(level._id_13D80 / 1000, 1) * 10;
  }

  waitframe();
  score_calculate(1);
}

_id_12F05() {
  level.score["_encstr_81290F84FB48022A046BE92A43F451D011"] = level.score["_encstr_81290F84FB48022A046BE92A43F451D011"] + 100;
  level._id_13D86++;
  level.player thread scripts\mp\rank::scorepointspopup(100);
  level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD");
  waitframe();
  score_calculate();
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_AD8017B686EB9DAB736CF65DE4B9CA7DB437A34E7BF50B1BA3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_8C631DB6D0F5D9BACDB1B7579CDC597D4B731D4EDEBE37D0DE27A3EB58C6A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_A7D313B50DF53B5DDCD8DEBA9CB9597D9BE858E481";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_A1D313D6D0EBCEAE37B1ED57C93759EB37A316394C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_93D313184147473B701BE0C382BB4DC730DC17C842";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_A3D3135BD0FAB35DCD8DDBBAC9CD2BAF6EA3B04ECC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_975B13FAF1370743231E2890FDD8DD8728B00BC268";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AC60D1BA7D0E24F3566A3DB89966B"] = "_encstr_AAD313D6D0D7ECBA37D8DE5D9CE6597DB91DB027D1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD"] = "_encstr_A5451684888F8F507029D70302079809AF57872148696278";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB"] = "_encstr_A2F217BFCB99DCD816A668230AD38018F2732B37AF7293A835";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF441079205DE317CF69485362FEEBF78B8B"] = "_encstr_880715DA7499A7CB0ED728E08B4B819F925BCEDE889351";
  thread dialog_kill_watcher();
}

dialog_kill_watcher() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime();
  var_3 = gettime();
  var_4 = 5000;

  for(;;) {
    if(level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"] < level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"] && gettime() > var_3 + var_4) {
      level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB");
      var_5 = gettime();
    } else if(level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"] > level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"] + 1 && gettime() > var_2 + var_4) {
      level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD");
      var_5 = gettime();
    }

    var_1 = level.score["_encstr_84BE11C04A4333684F91C04657BF30F12D1270"];
    var_0 = level.score["_encstr_8E070F8556AF90931F7BA95BF275A12903"];
    waitframe();
  }
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D30;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_8E8D0697EB01F243"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_850B08EBD30E1355884B"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_AC790540CF1203"] = 0;
  }
}

_id_13D30() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B");
  var_3 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_8E8D0697EB01F243"]);
  var_4 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"]);
  var_5 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_850B08EBD30E1355884B"]);
  var_6 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_AC790540CF1203"]);
  level.player dlog_recordplayerevent("_encstr_84C325D534026F81881BA0B8F53EB39B50A112AFF76F95E2E012F818D80B42E3EF5FFD9FD6A2C7", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_82FB06EB26785BD7", var_2, "_encstr_8E8D0697EB01F243", var_3, "_encstr_A7980A6E84BB0B58B94FB020", var_4, "_encstr_850B08EBD30E1355884B", var_5, "_encstr_AC790540CF1203", var_6]);
}