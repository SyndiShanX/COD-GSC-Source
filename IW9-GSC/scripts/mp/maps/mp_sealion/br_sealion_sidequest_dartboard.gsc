/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_dartboard.gsc
*************************************************************************/

main() {
  thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  init();
}

init() {
  if(!getdvarint("dvar_E84210930027B00A", 0)) {
    return;
  }
  level._id_6B9684E8B0851453 = spawnStruct();
  level._id_6B9684E8B0851453 _id_618A1163576C3819();
  level._id_6B9684E8B0851453 init_locations();
  level._id_6B9684E8B0851453 thread _id_9D99A6B3C18A711C();
  game["dialog"]["sealion_dartboard_target_hit"] = "drtb_wzan_dart";
}

_id_618A1163576C3819() {
  self._id_419857B4D4243689 = [];
  self._id_9CFC042C590E583F = [];
  self._id_548C8C64ED03AB26 = 0;
  self._id_52A8FDCD5374A475 = 0;
  self._id_BAE569B46299E003 = [];
  self._id_ACE05E86D7EFF2E9 = 1;
  self._id_E1E5950284801A8D = [];
  self._id_CB0907FAE9E7EA09 = 0;
  self._id_5E5EC51FB71BB134 = 0;
  self._id_AD0F544DDD26BF39 = getdvarint("dvar_FBACD955A641EF2A", 1);
  self._id_2D2C96BC96397D72 = getdvarint("dvar_1E4DDD08E076AD78", 1);
  self._id_D8BCC77D1017838C = getdvarint("dvar_5A3460694F0A1D41", 4);
  self._id_47072D6CAF2C1E69 = getdvarfloat("dvar_33215AD3882F92B5", 30);
  self._id_F184AA141896B907 = getdvarfloat("dvar_B4D04A01E396BA1E", 10);
  self._id_EBC9068497C85C3F = getdvarint("dvar_15D3802D5CCD112D", 1);
  self._id_BAD648FC0C0DC52F = getdvarint("dvar_356B8EB5ACE15953", 1);
  self._id_9B8BF766DFA0FA44 = getdvarint("dvar_3943AF5802A3196A", 1);
  self._id_42FBB20395FE8531 = getdvarint("dvar_4AD369A09C60EF45", 1);
  self._id_F072EFD23750AA73 = getdvarfloat("dvar_95E7ECD81ABFFFE1", 5);
  self._id_ADB17B34A82CF7DB = getdvarfloat("dvar_86D52CC322F3360A", 3) * (getdvarint("dvar_4838B7C39021124C", 1) - 1);
  self._id_DE0A5AECDB6B2D2D = getdvarfloat("dvar_772170DDF5093B15", 12) - self._id_ADB17B34A82CF7DB;
}

init_locations() {
  if(getdvarint("dvar_A05C884A84B25C54", 1))
    scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(level.mapname == "mp_br_hms_mechanics") {} else if(level.mapname == "mp_sealion") {
    _id_E0EF3E1AC0CD4C9E((-10724, -2985, 668), (0, 125, 0), 1, "A", "AB");
    _id_E0EF3E1AC0CD4C9E((-11038, -2510, 676), (0, 120, 0), 1, "B", "ABC");
    _id_E0EF3E1AC0CD4C9E((-11386, -2440, 676), (0, 70, 0), 1, "C", "BC");
    _id_E0EF3E1AC0CD4C9E((-11237, -3169, 668), (0, 100, 0), 2, "A", "BC", "AB");
    _id_E0EF3E1AC0CD4C9E((-11194, -2960, 676), (0, 160, 0), 2, "B", "AB", "ABC");
    _id_E0EF3E1AC0CD4C9E((-11638, -2832, 676), (0, 0, 0), 2, "C", "AC", "BC");
    _id_E0EF3E1AC0CD4C9E((-11586, -3494, 764), (0, 130, 0), 3, "A", "AB", "BC");
    _id_E0EF3E1AC0CD4C9E((-11630, -3108, 859.8), (0, 0, 0), 3, "B", "AB", "AB");
    _id_E0EF3E1AC0CD4C9E((-12147, -2660, 668.594), (0, -20, 0), 3, "C", "BC", "AC");
    _id_E0EF3E1AC0CD4C9E((-11228, -3252, 860), (0, 200, 0), 4, "A", undefined, "AB");
    _id_E0EF3E1AC0CD4C9E((-12024, -3074, 860), (0, 180, 0), 4, "B", undefined, "ABC");
    _id_E0EF3E1AC0CD4C9E((-12392, -2938, 691.557), (0, 60, 0), 4, "C", undefined, "C");
    _id_9912E4BCF9B94D95((-10942, -3047, 724.89), (0, 0, 0), 1);
    _id_9912E4BCF9B94D95((-11381.5, -2292, 712), (25, 20, 90), 1);
    _id_9912E4BCF9B94D95((-12412, -2903, 735), (0, 45, 90), 4);
    _id_9912E4BCF9B94D95((-11856, -3119, 899), (-85, 90, 90), 4);
    _id_9912E4BCF9B94D95((-11468.5, -3299.5, 895), (10, 40, 0), 4);
    _id_9912E4BCF9B94D95((-11182, -2698, 723), (0, 30, 0), 1);
    _id_9912E4BCF9B94D95((-11700, -2731, 722), (10, 45, 90), 0);
    _id_9912E4BCF9B94D95((-11190.7, -3201.3, 686), (-5, 105, 0), 0);
  } else
    return;

  if(self._id_2D2C96BC96397D72)
    self._id_9CFC042C590E583F = scripts\engine\utility::array_randomize(self._id_9CFC042C590E583F);

  _id_5F1DBCED0C232DD4();
  thread _id_13DFC77A3B639E6C();
}

_id_E0EF3E1AC0CD4C9E(_id_A7555EA95FCD5118, _id_A28D598FBFC8E73F, _id_FD9BFC46CAE637DC, _id_7B3C98EBDAE58941, _id_A6E295F0D73110CC, _id_ABCCCB3F9EB0ED50) {
  location = spawnStruct();
  location.origin = _id_A7555EA95FCD5118;
  location.angles = _id_A28D598FBFC8E73F;
  location._id_FD9BFC46CAE637DC = _id_FD9BFC46CAE637DC;
  location._id_7B3C98EBDAE58941 = _id_7B3C98EBDAE58941;
  location._id_A6E295F0D73110CC = undefined;
  location._id_ABCCCB3F9EB0ED50 = undefined;

  if(isDefined(_id_A6E295F0D73110CC))
    location._id_A6E295F0D73110CC = _id_A6E295F0D73110CC;

  if(isDefined(_id_ABCCCB3F9EB0ED50))
    location._id_ABCCCB3F9EB0ED50 = _id_ABCCCB3F9EB0ED50;

  self._id_9CFC042C590E583F = scripts\engine\utility::array_add(self._id_9CFC042C590E583F, location);
}

_id_9912E4BCF9B94D95(_id_9D4ADBE2BB0EA6E0, _id_7B10DC8DF6A56B37, _id_FD9BFC46CAE637DC) {
  _id_CB4FAD49263E20C4 = spawnStruct();
  _id_CB4FAD49263E20C4.payload = 0;
  _id_CB4FAD49263E20C4.origin = _id_9D4ADBE2BB0EA6E0;
  _id_CB4FAD49263E20C4.angles = _id_7B10DC8DF6A56B37;
  knife = _id_7E52B56769FA7774::spawnpickup("brloot_offhand_throwstar", _id_CB4FAD49263E20C4, 1, 0, undefined, 0, undefined, undefined);

  if(_id_7B10DC8DF6A56B37[2] > 0)
    knife setscriptablepartstate("brloot_offhand_throwstar", "usable_in_wall");

  knife._id_DA95CDC88D9497C8 = _id_FD9BFC46CAE637DC;
  self._id_BAE569B46299E003[self._id_BAE569B46299E003.size] = knife;
}

_id_5F1DBCED0C232DD4(_id_63A53BBFB0A66E0B, _id_A5C00A0DFBA3CE40) {
  _id_0876FABDCF4FBC1B = undefined;
  _id_BB5D3E5A37D88F6A = undefined;
  _id_C6F350F3E821A421 = [];
  _id_98EF6233794C2FB9 = [];

  if(self._id_AD0F544DDD26BF39) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_D8BCC77D1017838C; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 == 0) {
        foreach(location in self._id_9CFC042C590E583F) {
          if(location._id_FD9BFC46CAE637DC == 1) {
            _id_98EF6233794C2FB9[_id_98EF6233794C2FB9.size] = location;
            break;
          }
        }

        continue;
      }

      _id_0876FABDCF4FBC1B = _id_AC0E594AC96AA3A8 + 1;
      _id_BB5D3E5A37D88F6A = _id_98EF6233794C2FB9[_id_AC0E594AC96AA3A8 - 1]._id_A6E295F0D73110CC;
      _id_C6F350F3E821A421 = [];

      foreach(location in self._id_9CFC042C590E583F) {
        if(location._id_FD9BFC46CAE637DC == _id_0876FABDCF4FBC1B)
          _id_C6F350F3E821A421[_id_C6F350F3E821A421.size] = location;
      }

      foreach(location in _id_C6F350F3E821A421) {
        _id_CAAF67369BCA7ACE = 0;

        switch (_id_BB5D3E5A37D88F6A) {
          case "AB":
            if(location._id_7B3C98EBDAE58941 == "A" || location._id_7B3C98EBDAE58941 == "B")
              _id_CAAF67369BCA7ACE = 1;

            break;
          case "AC":
            if(location._id_7B3C98EBDAE58941 == "A" || location._id_7B3C98EBDAE58941 == "C")
              _id_CAAF67369BCA7ACE = 1;

            break;
          case "BC":
            if(location._id_7B3C98EBDAE58941 == "B" || location._id_7B3C98EBDAE58941 == "C")
              _id_CAAF67369BCA7ACE = 1;

            break;
          case "ABC":
            if(location._id_7B3C98EBDAE58941 == "A" || location._id_7B3C98EBDAE58941 == "B" || location._id_7B3C98EBDAE58941 == "C")
              _id_CAAF67369BCA7ACE = 1;

            break;
          case "C":
            if(location._id_7B3C98EBDAE58941 == "C")
              _id_CAAF67369BCA7ACE = 1;

            break;
        }

        if(_id_CAAF67369BCA7ACE) {
          _id_98EF6233794C2FB9[_id_98EF6233794C2FB9.size] = location;

          if(_id_98EF6233794C2FB9.size == _id_0876FABDCF4FBC1B) {
            break;
          }
        }
      }
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= self._id_D8BCC77D1017838C; _id_AC0E594AC96AA3A8++) {
      foreach(location in self._id_9CFC042C590E583F) {
        if(location._id_FD9BFC46CAE637DC == _id_AC0E594AC96AA3A8) {
          _id_98EF6233794C2FB9[_id_98EF6233794C2FB9.size] = location;
          break;
        }
      }
    }
  }

  if(self._id_EBC9068497C85C3F) {
    self._id_4FD9F6BDE6202AC5 = [];

    foreach(location in _id_98EF6233794C2FB9) {
      location.mine = spawnscriptable("sealion_sidequest_dartboard_decoy_mine", location.origin + (0, 0, 1), location.angles);
      self._id_4FD9F6BDE6202AC5 = scripts\engine\utility::array_add(self._id_4FD9F6BDE6202AC5, location.mine);
    }
  }

  self._id_E1E5950284801A8D = _id_98EF6233794C2FB9;

  foreach(location in self._id_E1E5950284801A8D)
  location._id_C8E1C7F7E983B016 = 0;
}

_id_9D99A6B3C18A711C() {
  self._id_3D84C51577B4B672 = [];
  self._id_027F78377463668B = [];
  self._id_7F44C962BE7501F8 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    item = _id_6AFF3948CF4CCA03::getplundernamebyamount(scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 50, 80));
    self._id_3D84C51577B4B672[self._id_3D84C51577B4B672.size] = item;
  }

  self._id_3D84C51577B4B672[self._id_3D84C51577B4B672.size] = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");
  self._id_3D84C51577B4B672[self._id_3D84C51577B4B672.size] = "brloot_offhand_deployed_decoy";
  self._id_027F78377463668B[self._id_027F78377463668B.size] = _id_14183DF6F9AF8737::_id_53382489FF523151();
  self._id_7F44C962BE7501F8[self._id_7F44C962BE7501F8.size] = "brloot_super_munitionsbox";
  self._id_7F44C962BE7501F8[self._id_7F44C962BE7501F8.size] = "brloot_super_armorbox";
}

_id_13DFC77A3B639E6C() {
  self notify("darboard_knife_pickup");
  self endon("dartboard_knife_pickup");
  level endon("game_ended");
  _id_2DAE57CDA35EC200 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_BAE569B46299E003.size; _id_AC0E594AC96AA3A8++)
    _id_2DAE57CDA35EC200[_id_AC0E594AC96AA3A8] = self._id_BAE569B46299E003[_id_AC0E594AC96AA3A8]._id_DA95CDC88D9497C8;

  _id_016B0B990FFED5AA = 0;
  _id_63A53BBFB0A66E0B = undefined;

  if(self._id_42FBB20395FE8531) {
    for(;;) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2DAE57CDA35EC200.size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(self._id_BAE569B46299E003[_id_AC0E594AC96AA3A8])) {
          _id_63A53BBFB0A66E0B = _id_2DAE57CDA35EC200[_id_AC0E594AC96AA3A8];
          _id_016B0B990FFED5AA = 1;
          break;
        }
      }

      if(_id_016B0B990FFED5AA) {
        break;
      }

      wait 1;
    }
  }

  _id_305E1DA47E8CB5B6(_id_63A53BBFB0A66E0B);
  thread _id_D1DE22434F8E91D3();
}

_id_BC87B609E8D62026() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", amount, attacker, direction, point, _id_0E86180E07331051, modelname, tagname, partname, idflags, objweapon);

    if(!self._id_4E18A7BC3821EF73 && isDefined(objweapon) && isDefined(attacker)) {
      self._id_4E18A7BC3821EF73 = 1;
      thread _id_319C261E53D61AEF();

      if(objweapon.basename == "throwstar_mp") {
        level notify("dartboard_hit", attacker, self);

        if(scripts\engine\utility::cointoss())
          thread _id_05C607EF7F46F361::_id_4E9ADC9D9FEB74EA("sealion_dartboard_target_hit", attacker, 1, 0, 0.5);

        foreach(_id_FE8F7703F6313ED4, _id_D19D92635664DDDC in level._id_6B9684E8B0851453._id_419857B4D4243689) {
          if(self == _id_D19D92635664DDDC) {
            location = level._id_6B9684E8B0851453._id_E1E5950284801A8D[_id_FE8F7703F6313ED4];

            if(!location._id_C8E1C7F7E983B016) {
              location._id_C8E1C7F7E983B016 = 1;
              _id_F0FA3B7B27926553 = _func_1823FF50BB28148D("sealion_sq_dartboard_dummy");
              attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_F0FA3B7B27926553);
            }

            break;
          }
        }
      } else {
        foreach(_id_D19D92635664DDDC in level._id_6B9684E8B0851453._id_419857B4D4243689) {
          if(isDefined(_id_D19D92635664DDDC) && isDefined(_id_D19D92635664DDDC._id_4E18A7BC3821EF73) && !_id_D19D92635664DDDC._id_4E18A7BC3821EF73) {
            _id_D19D92635664DDDC._id_4E18A7BC3821EF73 = 1;
            _id_D19D92635664DDDC thread _id_319C261E53D61AEF();
          }
        }

        if(level._id_6B9684E8B0851453._id_9B8BF766DFA0FA44)
          _id_6611CC0DE34A2402();
        else
          level notify("dartboard_timer");
      }
    }
  }
}

_id_D1DE22434F8E91D3() {
  level endon("game_ended");
  level notify("dartboard_watcher");
  level endon("dartboard_watcher");
  self._id_52A8FDCD5374A475 = 0;
  _id_1E0F4AC4E3B1AAA0 = undefined;
  _id_9EE3A167C8498F2F = undefined;

  for(;;) {
    level waittill("dartboard_hit", attacker, _id_D19D92635664DDDC);

    if(!isDefined(self._id_7AD57A5B90753ECB))
      thread _id_ACB42729F4797107();

    if(self._id_AD0F544DDD26BF39) {
      self._id_548C8C64ED03AB26++;

      if(self._id_52A8FDCD5374A475 == self._id_D8BCC77D1017838C - 1) {
        _id_9EE3A167C8498F2F = _id_D19D92635664DDDC;
        _id_1E0F4AC4E3B1AAA0 = attacker;
        break;
      }

      self._id_52A8FDCD5374A475++;
      _id_305E1DA47E8CB5B6();
    } else {
      self._id_548C8C64ED03AB26++;

      if(self._id_548C8C64ED03AB26 == self._id_D8BCC77D1017838C) {
        _id_9EE3A167C8498F2F = _id_D19D92635664DDDC;
        _id_1E0F4AC4E3B1AAA0 = attacker;
        break;
      }
    }

    waitframe();
  }

  self._id_CB0907FAE9E7EA09 = 1;
  wait 0.2;
  level notify("dartboard_timer");
  _id_D63D40719037A5F5(_id_1E0F4AC4E3B1AAA0, _id_9EE3A167C8498F2F);
}

_id_ACB42729F4797107() {
  level endon("game_ended");
  level notify("dartboard_timer");
  level endon("dartboard_timer");
  self._id_7AD57A5B90753ECB = 1;
  currenttime = gettime();
  endtime = currenttime + self._id_47072D6CAF2C1E69 * 1000;
  _id_06ADFB3026C57F48 = endtime;
  nexthittime = self._id_F184AA141896B907 * 1000;
  _id_5A67FF43286EDDDA = currenttime + self._id_DE0A5AECDB6B2D2D * 1000;

  for(_id_548C8C64ED03AB26 = 0; !self._id_CB0907FAE9E7EA09; currenttime = gettime()) {
    if(self._id_AD0F544DDD26BF39 && self._id_548C8C64ED03AB26 != _id_548C8C64ED03AB26 && currenttime < _id_06ADFB3026C57F48) {
      _id_548C8C64ED03AB26++;
      _id_06ADFB3026C57F48 = currenttime + nexthittime;
    } else if(self._id_AD0F544DDD26BF39 && currenttime >= _id_06ADFB3026C57F48 || !self._id_AD0F544DDD26BF39 && currenttime >= endtime)
      _id_6611CC0DE34A2402();

    waitframe();
  }

  if(currenttime <= _id_5A67FF43286EDDDA)
    self._id_5E5EC51FB71BB134 = 1;
}

_id_D63D40719037A5F5(player, dummy) {
  _id_18706B9B8539C08A = "sealion_sq_dartboard_complete";

  if(self._id_5E5EC51FB71BB134) {
    self._id_F8C903F8D6D4E353 = scripts\engine\utility::array_combine(self._id_3D84C51577B4B672, self._id_027F78377463668B);
    _id_18706B9B8539C08A = "sealion_sq_dartboard_hard";

    if(getdvarint("dvar_4838B7C39021124C", 1) == 4)
      self._id_F8C903F8D6D4E353 = scripts\engine\utility::array_combine(self._id_F8C903F8D6D4E353, self._id_7F44C962BE7501F8);
  } else
    self._id_F8C903F8D6D4E353 = self._id_3D84C51577B4B672;

  _id_BAB0D10E51188531 = scripts\mp\utility\teams::getteamdata(player.team, "players");
  _id_05C607EF7F46F361::_id_467F8B6E641DC16C(self._id_F8C903F8D6D4E353, dummy.origin, dummy.angles, _id_BAB0D10E51188531, 0, _id_18706B9B8539C08A, 1, 2, player);
}

_id_305E1DA47E8CB5B6(_id_63A53BBFB0A66E0B) {
  if(isDefined(_id_63A53BBFB0A66E0B)) {
    switch (_id_63A53BBFB0A66E0B) {
      case 1:
        self._id_ACE05E86D7EFF2E9 = 1;
        break;
      case 4:
        self._id_ACE05E86D7EFF2E9 = 0;
        break;
      case 0:
        _id_510E41AFAD57494B = scripts\engine\utility::cointoss();

        if(_id_510E41AFAD57494B == 0)
          self._id_ACE05E86D7EFF2E9 = 0;
        else
          self._id_ACE05E86D7EFF2E9 = 1;

        break;
    }
  }

  for(_id_AC0E594AC96AA3A8 = self._id_419857B4D4243689.size; _id_AC0E594AC96AA3A8 < self._id_D8BCC77D1017838C; _id_AC0E594AC96AA3A8++) {
    location = undefined;

    if(self._id_ACE05E86D7EFF2E9)
      location = self._id_E1E5950284801A8D[_id_AC0E594AC96AA3A8];
    else
      location = self._id_E1E5950284801A8D[3 - _id_AC0E594AC96AA3A8];

    _id_D19D92635664DDDC = spawn("script_model", location.origin);
    _id_D19D92635664DDDC.angles = location.angles;
    _id_D19D92635664DDDC.location = location;
    _id_D19D92635664DDDC setModel("offhand_2h_wm_decoy_mine_dummy01_v0_mp");
    _id_D19D92635664DDDC setCanDamage(1);
    _id_D19D92635664DDDC._id_4E18A7BC3821EF73 = 0;
    _id_D19D92635664DDDC thread _id_94F37C675BE9BA6F();
    self._id_419857B4D4243689 = scripts\engine\utility::array_add(self._id_419857B4D4243689, _id_D19D92635664DDDC);

    if(self._id_AD0F544DDD26BF39) {
      break;
    }
  }

  foreach(_id_D19D92635664DDDC in self._id_419857B4D4243689) {
    if(isDefined(_id_D19D92635664DDDC) && isDefined(_id_D19D92635664DDDC._id_4E18A7BC3821EF73) && !_id_D19D92635664DDDC._id_4E18A7BC3821EF73)
      _id_D19D92635664DDDC thread _id_BC87B609E8D62026();
  }
}

_id_6611CC0DE34A2402() {
  foreach(_id_D19D92635664DDDC in level._id_6B9684E8B0851453._id_419857B4D4243689) {
    if(isDefined(_id_D19D92635664DDDC) && isDefined(_id_D19D92635664DDDC._id_4E18A7BC3821EF73) && !_id_D19D92635664DDDC._id_4E18A7BC3821EF73) {
      _id_D19D92635664DDDC._id_4E18A7BC3821EF73 = 1;
      _id_D19D92635664DDDC thread _id_DAFB84EA0E5319E3();
    }
  }

  wait(level._id_6B9684E8B0851453._id_F072EFD23750AA73);

  if(level._id_6B9684E8B0851453._id_BAD648FC0C0DC52F) {
    level._id_6B9684E8B0851453._id_548C8C64ED03AB26 = 0;
    level._id_6B9684E8B0851453._id_52A8FDCD5374A475 = 0;
    level._id_6B9684E8B0851453._id_419857B4D4243689 = [];

    foreach(mine in level._id_6B9684E8B0851453._id_4FD9F6BDE6202AC5)
    mine setscriptablepartstate("decoy_mine", "inactive");

    waitframe();
    level._id_6B9684E8B0851453 _id_305E1DA47E8CB5B6();
    level._id_6B9684E8B0851453 thread _id_D1DE22434F8E91D3();
    level._id_6B9684E8B0851453._id_7AD57A5B90753ECB = undefined;
    level notify("dartboard_timer");
  }
}

#using_animtree("scriptables");

_id_94F37C675BE9BA6F() {
  self.location.mine setscriptablepartstate("decoy_mine", "triggered");
  self setscriptablepartstate("inflate", "iw9_mp_decoymine_inflate");
  wait(getanimlength(%iw9_mp_decoymine_inflate));
  self setscriptablepartstate("idle", "iw9_mp_decoymine_idle");
  self setscriptablepartstate("inflate", "neutral");
}

_id_DAFB84EA0E5319E3() {
  self setscriptablepartstate("deflate", "iw9_mp_decoymine_deflate");
  wait(getanimlength(%iw9_mp_decoymine_deflate));
  self setscriptablepartstate("dummy_vis", "dummy_vis_hide");
  self setscriptablepartstate("deflate", "neutral");
  self delete();
}

_id_319C261E53D61AEF() {
  self setscriptablepartstate("deflate", "iw9_mp_decoymine_pop");
  wait(getanimlength(%iw9_mp_decoymine_pop));
  self setscriptablepartstate("dummy_vis", "dummy_vis_hide");
  self setscriptablepartstate("deflate", "neutral");
  wait 1;
  self delete();
}