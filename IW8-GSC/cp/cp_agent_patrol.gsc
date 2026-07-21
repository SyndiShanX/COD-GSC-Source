/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_agent_patrol.gsc
***********************************************/

initpatrolpoints() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  wait 1;
  level.bestpatrolpoint = undefined;
  level.previouspatrolpoint = undefined;
  var_0 = scripts\engine\utility::getStructArray("_encstr_A36E0FE6EDD8C8B4B24EAF3816A339F6C6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.allspatrolpoints = var_0;
  var_1 = 1;
  level.last_player_seen = 0;

  foreach(var_3 in var_0) {
    var_3.patrolscore = 0;
    var_3.id = var_1;
    var_3.personalscore = 0;
    var_1++;
  }

  if(scripts\engine\utility::flag_exist("_encstr_8BF119737899F2D7E877373970B3FFF1CB786AAB900BAD07C2C504"))
    scripts\engine\utility::flag_set("_encstr_8BF119737899F2D7E877373970B3FFF1CB786AAB900BAD07C2C504");

  level thread spatrolpointscoring();
}

set_default_soldier_values() {
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.damaged = undefined;
  thread exit_patrol_mode();
  thread soldier_player_listener();
  self.stealth_initialized = 1;
}

set_default_patrol_values() {
  self notify("_encstr_BDA012F357CB8E8702EFF031D36090C820537FFC");
  setpatrolstate("_encstr_96080730D8534E0A28", "_encstr_96080730D8534E0A28", 0, 0, 0, undefined, 0, 1);
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.damaged = undefined;
  thread exit_patrol_mode();
  thread soldier_player_listener();
  self.stealth_initialized = 1;
}

watchfornotifies(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_AA9E119451E359E9AFB2D821AA7BA3B12FFD1E");
  var_0 endon("_encstr_AA9E119451E359E9AFB2D821AA7BA3B12FFD1E");
  var_0.notifycounter = [];
  var_1 = ["_encstr_AD75063D571AE108", "_encstr_BA22087EA808525BA5D9", "_encstr_AF4C0CA32B1EE81A16B98C639539", "_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_833608E0AB19F8A93A7F", "_encstr_A2D60CA20F29E3A740291B6748F8", "_encstr_812D12A3D3BF5078DB67011547C2A07847EF6839", "_encstr_9763150FBBD8A623A460B3B80B990B9F704F9869E53068", "_encstr_9BB4110F8BF731319A43AB28C7E2AF78ADF342", "_encstr_9375163807F411A910B55EF68D8A89184DD351B05BB46979", "_encstr_82B21DB109F84A0BF849FAD3B1BB07852BE3213D8F7117730583A0AA989FAF", "_encstr_8D7F132BD2130EF827DF4D0FFDD683C0D33860737A", "_encstr_861F109BB10388C0C4597A7E639090E82F92", "_encstr_A9EB14D2306A7121D532A7E3C6C620A683E03789C10B", "_encstr_A33912EBB2678DABC5A1F7A88B2BEBF78898D7AF", "_encstr_88620CCAE0955B3F33015151AD5B", "_encstr_82CA0D07613BCBD718F32F36E8F838", "_encstr_929018AB88296973B85266097027AA101E3FF58A2B38535ED0CB", "_encstr_BDA012F357CB8E8702EFF031D36090C820537FFC", "_encstr_8B7205D9ED5958"];

  foreach(var_3 in var_1)
  var_0.notifycounter[var_3] = 0;

  for(;;) {
    var_5 = var_0 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_1);
    var_0.notifycounter[var_5]++;
  }
}

patrol_state_text_handler(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_AF4C0CA32B1EE81A16B98C639539");
  var_0 endon("_encstr_AF4C0CA32B1EE81A16B98C639539");
  var_1 = var_0 getentitynumber();

  for(;;) {
    if(getDvar("_encstr_857814AFC0C909AA9943A95ABB47D3EFD3685F3BD063") == "_encstr_B40101")
      level waittill("_encstr_A2E4141B2098EFE1A0A92D3181C074073E1BB2F3696E");

    if(isDefined(var_0.patrol_state) && isDefined(var_0._blackboard.movetype)) {} else if(isDefined(var_0.patrol_state)) {}

    wait 0.05;
  }
}

target_patrol_path(var_0) {
  self endon("_encstr_812D12A3D3BF5078DB67011547C2A07847EF6839");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[randomint(var_1.size)];

  for(;;) {
    var_2 thread setcooldown(var_2, 20);
    setgoalandtimeout(var_2.origin);
    var_2 thread unsetcooldown(var_2);

    if(isDefined(var_2.target)) {
      var_1 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2 = var_1[randomint(var_1.size)];
      continue;
    }

    break;
  }
}

spatrolpointscoring() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.allspatrolpoints) || level.allspatrolpoints.size < 1) {
    return;
  }
  var_0 = 12;
  level.excludedpatrolpoints = [];
  var_1 = level.allspatrolpoints;
  var_2 = [];
  var_3 = 9 / var_0;
  var_4 = 3 / var_0;
  var_5 = 5;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      var_9 = 0;

      if(istrue(var_8.cooldown) && isDefined(var_8.startingcooldown)) {
        var_10 = var_3 * 500;
        var_9 = var_10 * (var_8.cooldown / var_8.startingcooldown);
      }

      var_9 = clamp(var_9, 0, 500);
      var_8.patrolscore = int(var_9);
      var_6++;

      if(var_6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

zpatrolpointscoring() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.allzpatrolpoints) || level.allzpatrolpoints.size < 1) {
    return;
  }
  var_0 = 12;
  level.excludedpatrolpoints = [];
  var_1 = level.allzpatrolpoints;
  var_2 = [];
  var_3 = 9 / var_0;
  var_4 = 3 / var_0;
  var_5 = 5;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      var_9 = 0;

      if(istrue(var_8.cooldown) && isDefined(var_8.startingcooldown)) {
        var_10 = var_3 * 500;
        var_9 = var_10 * (var_8.cooldown / var_8.startingcooldown);
      }

      var_9 = clamp(var_9, 0, 500);
      var_8.patrolscore = int(var_9);
      var_6++;

      if(var_6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

getscoredpatrolpoint2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = level.allspatrolpoints;

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = scripts\engine\utility::array_removeundefined(var_2);

  if(!isDefined(var_3))
    var_3 = "_encstr_A7E80E1818902B623DBA872BD4C1184C";

  var_4 = 25;
  var_5 = scripts\cp\cp_agent_utils::getactiveagentsoftype(var_3);
  var_6 = sortbydistance(scripts\engine\utility::array_remove_array(var_1, var_2), var_0.origin);
  var_7 = [];
  var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_5, undefined, 4, 256).size >= 3;
  var_9 = 5 / var_4;
  var_10 = 20 / var_4;

  foreach(var_12 in var_6) {
    var_13 = var_12.patrolscore;
    var_12.personalscore = 0;
    var_14 = 250;

    if(var_8 && distance(var_0.origin, var_12.origin) <= 500)
      var_14 = 500;
    else {
      var_15 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_12.origin);

      if(isDefined(var_12.target)) {
        var_16 = scripts\engine\utility::getStructArray(var_12.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(var_16.size > 1) {
          var_17 = var_10 * 500;
          var_14 = var_14 - var_17;
        }

        var_18 = var_9 * 500;
        var_14 = var_18 * var_15;
      } else
        var_14 = 500 * var_15;
    }

    var_14 = clamp(var_14, 0, 500);
    var_14 = clamp(var_14 + var_13, 0, 999);
    var_12.personalscore = int(var_14);
    var_7[var_7.size] = var_12;

    if(var_14 <= 50)
      return var_12;
  }

  var_20 = scripts\cp\utility::array_sort_by_handler(var_7, ::getpersonalpatrolscore)[0];
  return var_20;
}

getpersonalpatrolscore() {
  if(isDefined(self.personalscore))
    return self.personalscore;
  else
    return 999;
}

getpatrolscore() {
  if(isDefined(self.patrolscore))
    return self.patrolscore;
  else
    return 0;
}

setcooldown(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_ABDF0CC7B76386505F2DB1A89336");
  var_0 endon("_encstr_ABDF0CC7B76386505F2DB1A89336");
  var_0 endon("_encstr_A5560EAE73B995A386DBB7B191ED77CD");
  var_2 = 0.5 * var_1;
  var_2 = clamp(var_2, 0.1, var_2);
  var_3 = gettime() + var_2 * 1000;
  var_4 = var_1 / 20;
  var_4 = clamp(var_4, 0.05, var_4);
  var_5 = 0;
  var_0.patrolscore = 500;
  var_0.startingcooldown = var_1;

  while(gettime() < var_3) {
    var_0.cooldown = 20 - var_5;
    var_5++;
    wait(var_4);
  }
}

unsetcooldown(var_0) {
  var_0 notify("_encstr_A5560EAE73B995A386DBB7B191ED77CD");
  var_0.cooldown = undefined;
  var_0.startingcooldown = undefined;
}

watchforstalledpos(var_0) {
  self notify("_encstr_815213675BDB7EFB5EDF2B5BFD0FC3F8B505EF18D7");
  self endon("_encstr_815213675BDB7EFB5EDF2B5BFD0FC3F8B505EF18D7");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_8B7205D9ED5958");
  self endon("_encstr_A3130D9AF069D2310E87C1D9C03A82");

  if(isDefined(var_0))
    self endon(var_0);

  var_1 = self.origin;
  var_2 = 0;
  var_3 = 10;

  for(;;) {
    if(self.origin == var_1)
      var_2++;

    if(var_2 >= var_3) {
      break;
    }

    wait 0.25;
  }

  self notify("_encstr_833608E0AB19F8A93A7F");
}

setgoalandtimeout(var_0, var_1, var_2) {
  self notify("_encstr_812112C8C724A597522597183F59C3A89D577068");
  self endon("_encstr_812112C8C724A597522597183F59C3A89D577068");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_0)) {
    var_3 = getclosestpointonnavmesh(var_0);
    thread watchforstalledpos(var_2);
    _setgoalpos(self, var_3, var_1);
  } else
    wait 0.25;
}

_setgoalpos(var_0, var_1, var_2) {
  var_0 notify("_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD");
  var_0 endon("_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_833608E0AB19F8A93A7F");

  if(isDefined(var_2))
    var_0.goalradius = var_2;
  else
    var_0.goalradius = 32;

  var_3 = 0;

  foreach(var_5 in level.nearbyposarray) {
    if(distance(var_5, var_1) <= var_0.goalradius) {
      var_3 = 1;
      break;
    }
  }

  var_7 = 1;

  if(var_3) {
    var_8 = getrandomnavpoints(var_1, 50, 10, undefined, getrandomnavpoint(var_1, 32), 25);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_7 = 0;

      foreach(var_5 in level.nearbyposarray) {
        if(distance(var_5, var_11) <= 32) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = var_11;
        break;
      }
    }
  }

  thread manageposarray(var_0, var_1);
  var_0 setbtgoalpos(0, var_1);
  var_15 = var_0 scripts\engine\utility::_id_143AD("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
}

manageposarray(var_0, var_1) {
  if(isDefined(var_1)) {
    level.nearbyposarray[level.nearbyposarray.size] = var_1;
    var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return(["_encstr_AD75063D571AE108", "_encstr_81A4177BC3A8D98FA031E2D93B888781F0BBF1E56B28DB4FDD", "_encstr_BA22087EA808525BA5D9", "_encstr_82CA0D07613BCBD718F32F36E8F838", "_encstr_ADE909AD87474FB75ACA79", "_encstr_BD420EB0C6ACC98ECA46BE13E5D785B4"]);

    if(scripts\engine\utility::array_contains(level.nearbyposarray, var_1))
      level.nearbyposarray = scripts\engine\utility::array_remove(level.nearbyposarray, var_1);
  }
}

patrol_path(var_0, var_1) {
  self notify("_encstr_A2D60CA20F29E3A740291B6748F8");
  self endon("_encstr_A2D60CA20F29E3A740291B6748F8");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_812D12A3D3BF5078DB67011547C2A07847EF6839");

  if(!isDefined(level.allspatrolpoints) || level.allspatrolpoints.size < 1) {
    return;
  }
  if(isDefined(level.allspatrolpoints) || level.allspatrolpoints.size > 1) {
    var_2 = level.allspatrolpoints;
    var_3 = scripts\engine\utility::array_combine([var_0], level.excludedpatrolpoints);
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, var_3, 10);

    if(var_4.size < 1) {
      var_2 = scripts\engine\utility::getStructArray(var_0.targetname, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray(var_0.targetname, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), var_3, 5);
    }

    var_5 = scripts\engine\utility::getclosest(var_0.origin, var_4, 256);

    if(isDefined(var_5))
      var_6 = var_5;
    else
      var_6 = getscoredpatrolpoint2(self, var_4);

    var_7 = var_6;
    var_3 = scripts\engine\utility::array_combine([var_6, var_7], level.excludedpatrolpoints);

    for(;;) {
      var_6 thread setcooldown(var_6, 20);
      thread removeifalerted(self, var_6);
      setgoalandtimeout(var_6.origin);
      self.onpatrolpath = undefined;
      unsetcooldown(var_6);

      if(scripts\engine\utility::cointoss())
        wait(randomfloatrange(2.5, 5));

      var_2 = level.allspatrolpoints;

      if(istrue(var_1)) {
        break;
      }

      if(isDefined(var_6))
        var_7 = var_6;

      var_3 = scripts\engine\utility::array_combine([var_7, var_6], level.excludedpatrolpoints);
      var_4 = scripts\engine\utility::get_array_of_closest(self.origin, var_2, var_3, 5);
      var_6 = getscoredpatrolpoint2(self, var_4, var_3);
    }
  } else {}
}

removeifalerted(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_A3130D9AF069D2310E87C1D9C03A82");
  var_0 endon("_encstr_8B7205D9ED5958");
  var_0 endon("_encstr_833608E0AB19F8A93A7F");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_BA22087EA808525BA5D9");
  addtopatrolexclusion(0, var_1);
}

addtopatrolexclusion(var_0, var_1) {
  if(istrue(var_0) && !scripts\engine\utility::array_contains(level.excludedpatrolpoints, var_1))
    level.excludedpatrolpoints = scripts\engine\utility::array_add(level.excludedpatrolpoints, var_1);
  else if(scripts\engine\utility::array_contains(level.excludedpatrolpoints, var_1))
    level.excludedpatrolpoints = scripts\engine\utility::array_remove(level.excludedpatrolpoints, var_1);
}

watchforbulletwhizby() {
  self notify("_encstr_9763150FBBD8A623A460B3B80B990B9F704F9869E53068");
  self endon("_encstr_9763150FBBD8A623A460B3B80B990B9F704F9869E53068");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");

  for(;;) {
    self waittill("_encstr_A5490D5E05C3F8B363F3C8D83B3E43", var_0, var_1, var_2, var_3);

    if(isPlayer(var_0)) {
      self notify("_encstr_812D12A3D3BF5078DB67011547C2A07847EF6839");
      setpatrolstate("_encstr_AC53154A10E4773A48239F61E15885B798ABD2F23AB67F", "_encstr_931904C66102", 0, 1, 0, var_2);
      break;
    }
  }
}

exit_patrol_mode() {
  self notify("_encstr_9BB4110F8BF731319A43AB28C7E2AF78ADF342");
  self endon("_encstr_9BB4110F8BF731319A43AB28C7E2AF78ADF342");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  thread watchforweaponfire();
  thread watchforbulletwhizby();
  thread watchforsoldierkilled(self);
  thread scripts\cp\cp_trigger_spawn::soldier_player_listener();

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_ents_return(self, "_encstr_B2BE0788BAF573592F", self, "_encstr_860808CB78E2984063BA", self, "_encstr_AD171358D85693D1B219EB26CBF59BF61B32D2B2E4", level, "_encstr_BD471036164E9DACBE56F083B1DBCDB4F69B");

    if(!isDefined(var_0)) {
      continue;
    }
    if(istrue(self.posted)) {
      if(var_0 != "_encstr_B2BE0788BAF573592F") {
        break;
      } else
        continue;

      continue;
    }

    break;
  }

  var_1 = 2;
  var_2 = 1;
  var_3 = 1;
  var_4 = 0;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_AD171358D85693D1B219EB26CBF59BF61B32D2B2E4":
        setpatrolstate("_encstr_AD171358D85693D1B219EB26CBF59BF61B32D2B2E4", "_encstr_AA7C07466F9DA30713", 1, 0, 0, undefined);
        var_2 = 1;
        var_3 = 0;
        var_4 = 0;
        break;
      case "_encstr_B2BE0788BAF573592F":
        setpatrolstate("_encstr_93C508AF0763AAA769E8", "_encstr_AA7C07466F9DA30713", 1, 0, 0, undefined, 1);
        self.damaged = 1;
        var_3 = 1;
        var_4 = 1;
        break;
    }
  }
}

watchforsoldierkilled(var_0) {
  var_0 notify("_encstr_9375163807F411A910B55EF68D8A89184DD351B05BB46979");
  var_0 endon("_encstr_9375163807F411A910B55EF68D8A89184DD351B05BB46979");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA22087EA808525BA5D9");

  for(;;) {
    var_1 = 0;
    level waittill("_encstr_A2300A73174102F0ACDD6159", var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_7 != var_0.team) {
      continue;
    }
    if(istrue(var_0.posted)) {
      continue;
    }
    var_1 = isPlayer(var_5);
    var_8 = scripts\engine\math::get_dot(var_0.origin, var_0 getplayerangles(1), var_2);

    if(var_8 >= 0.573576 && sighttracepassed(var_0 getEye(), var_2, 0, var_0, 1)) {
      var_0 setpatrolstate("_encstr_93F719BB5AD1CD956EDCB28CAFCCE42DAC37468DBCEB4695164734", "_encstr_92100762872552A643", 0, 1, 0, var_2, 0);
      break;
    }
  }
}

setpatrolstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    if(var_1 == "_encstr_931904C66102") {
      scripts\common\utility::demeanor_override("_encstr_931904C66102");
      var_1 = "_encstr_AA7C07466F9DA30713";
    } else if(var_1 == "_encstr_AA7C07466F9DA30713")
      scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");

    scripts\asm\asm_bb::bb_requestmovetype(var_1);
  }

  self notify(var_0);
  self.patrol_state = var_0;
  var_9 = istrue(self.behinddoors);

  if(istrue(var_6))
    thread alertnearbyenemiesafterdelay(undefined, undefined, 1, 1);

  if(istrue(var_7)) {
    if(isDefined(self.spawnpoint.target))
      thread target_patrol_path(self.spawnpoint);
    else
      thread _startsoldierpatrol(self);
  } else if(istrue(var_4))
    thread alerted_hunt_mode(self);
  else if(istrue(var_3)) {
    if(isDefined(var_5))
      thread soldier_investigate(self, var_5);
    else {
      var_10 = scripts\cp\utility::get_closest_living_player();

      if(isDefined(var_10))
        thread soldier_investigate(self, var_10.origin);
      else
        thread soldier_investigate(self, getrandomnavpoint(self.origin, 256));
    }
  } else if(istrue(var_2))
    thread enter_combat();
}

alertnearbyenemiesafterdelay(var_0, var_1, var_2, var_3) {
  self notify("_encstr_82B21DB109F84A0BF849FAD3B1BB07852BE3213D8F7117730583A0AA989FAF");
  self endon("_encstr_82B21DB109F84A0BF849FAD3B1BB07852BE3213D8F7117730583A0AA989FAF");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = 3;

  wait(var_1);
  thread alert_all_nearby_enemies(var_0, var_2, undefined, var_3);
}

watchforweaponfire() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8D7F132BD2130EF827DF4D0FFDD683C0D33860737A");
  self endon("_encstr_8D7F132BD2130EF827DF4D0FFDD683C0D33860737A");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 1500;

  for(;;) {
    level waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_1, var_2, var_3);

    if(istrue(self.posted)) {
      continue;
    }
    if(isagent(var_3) && var_3.team == self.team) {
      continue;
    }
    var_0 = 1500;

    if(isPlayer(var_3))
      var_0 = var_0 * var_3.perk_data["_encstr_87951CB9A3CA85B1E843EBEECA16C1DE37EBE6EDB4CD567DCDC62CB158C9"];

    var_4 = 0;

    foreach(var_6 in var_2.attachments) {
      if(issubstr(var_6, "_encstr_AD3E09B95A632BDC6CCA27")) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      continue;
    }
    if(istrue(self.damaged))
      var_0 = int(var_0 * 1.5);

    if(distance(var_1, self.origin) > var_0)
      continue;
    else {
      setpatrolstate("_encstr_AFC91AFAA054E7AAD853EFF171E83527683BB2E20BA093E960BBF2FD", "_encstr_92100762872552A643", 0, 1, 0, var_1, 0);
      break;
    }
  }
}

canpathtotarget(var_0, var_1) {
  var_2 = var_0 findpath(var_0.origin, var_1, 0, 0);

  if(var_2.size >= 1 && distance(var_2[var_2.size - 1], var_1) <= 64)
    return 1;
  else
    return 0;
}

alertnearbyloop(var_0) {
  var_0 notify("_encstr_861F109BB10388C0C4597A7E639090E82F92");
  var_0 endon("_encstr_861F109BB10388C0C4597A7E639090E82F92");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BDA012F357CB8E8702EFF031D36090C820537FFC");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_143AC("_encstr_938C091AC8B8AFFB036D37");
    var_0 thread alertnearbyenemiesafterdelay();

    if(var_1 == "_encstr_938C091AC8B8AFFB036D37")
      wait 0.5;
  }
}

enter_combat() {
  self notify("_encstr_BA22087EA808525BA5D9");
  self notify("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self.goalradius = 64;
  self.nocorpse = undefined;
  self.ignoreall = 0;
  self.scripted_mode = 0;
  self.entered_combat = 1;
  scripts\common\utility::demeanor_override("_encstr_965108334E0B373A961B");
  thread get_enemy_info_loop(5);
}

get_enemy_info_loop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8BCB143FF560013B7D6DF9139163F8B527B9F44F95DB");
  self endon("_encstr_8BCB143FF560013B7D6DF9139163F8B527B9F44F95DB");
  self endon("_encstr_AD75063D571AE108");
  var_1 = get_closest_available_player();

  if(!isDefined(var_1)) {
    level notify("_encstr_B1EA17A5B2C10B88ABAAD351114AF83EDB73A0D1BF3FED5D79");
    return;
  } else {
    self clearentitytarget();
    self getenemyinfo(var_1);
    self.favoriteenemy = var_1;

    if(!isDefined(var_1.enemy_list))
      var_1.enemy_list = [];

    if(!isDefined(self.target_enemy) || self.target_enemy != var_1) {
      self notify("_encstr_88560F9158FB9D9F1D3A572C101370373D");
      thread scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_88560F9158FB9D9F1D3A572C101370373D", ::clear_enemy_flags, var_1);
      thread scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::clear_enemy_flags, var_1);

      if(!scripts\engine\utility::array_contains(var_1.enemy_list, self))
        var_1.enemy_list[var_1.enemy_list.size] = self;
    }

    self.target_enemy = var_1;
  }

  if(isDefined(self.script_goalvolume))
    self setgoalvolumeauto(self.script_goalvolume);
}

movetocovernode(var_0) {
  self setbtgoalnode(1, var_0);
  self setbtgoalRadius(1, self.goalradius);
  self setbtgoalheight(1, self.goalheight);
  self setbtgoalpos(0, var_0.origin);
  self.movetocovernodestarttime = gettime();
  self.movetocovernode = var_0;
  thread clearbtgoalonarrival();
}

clearbtgoalonarrival() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_9A4119B76105A2C2B92F4F4DA1E0394B66839BB7F9A0DB8D4811BB");
  self endon("_encstr_9A4119B76105A2C2B92F4F4DA1E0394B66839BB7F9A0DB8D4811BB");
  self waittill("_encstr_A3130D9AF069D2310E87C1D9C03A82");
  self clearbtgoal(1);
}

get_closest_available_player() {
  var_0 = sortbydistance(level.players, self.origin);

  foreach(var_2 in var_0) {
    if(var_2 scripts\cp\utility::is_valid_player()) {
      if(!isDefined(var_2.hunted_count) || var_2.hunted_count.size < 3)
        return var_2;

      if(!isDefined(var_2.enemy_list) || var_2.enemy_list.size < int(24 / level.players.size))
        return var_2;
    }
  }

  if(isDefined(self.enemy))
    return self.enemy;
  else
    return undefined;
}

clear_enemy_flags(var_0) {
  if(isDefined(var_0))
    var_0.enemy_list = scripts\engine\utility::array_remove(var_0.enemy_list, self);
}

clear_hunted_flags(var_0) {
  if(isDefined(var_0))
    var_0.hunted_count = scripts\engine\utility::array_remove(var_0.hunted_count, self);
}

clear_pos_from_hunt_pos_array(var_0) {
  if(isDefined(var_0))
    var_0.hunted_count = scripts\engine\utility::array_remove(var_0.hunted_count, self);
}

hunt_player_delayed() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = randomintrange(25, 60);
  var_1 = randomintrange(10, 15);
  hunt_player(var_0, var_1);
}

soldier_investigate(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_A9EB14D2306A7121D532A7E3C6C620A683E03789C10B");
  var_0 endon("_encstr_A9EB14D2306A7121D532A7E3C6C620A683E03789C10B");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setgoalandtimeout(var_1);

  if(var_0 scripts\cp\cp_trigger_spawn::trigger_temp_stealth_meter(2.6, undefined, "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2")) {
    wait 5;

    foreach(var_3 in scripts\cp\cp_agent_utils::getactiveagentsoftype("_encstr_A7E80E1818902B623DBA872BD4C1184C"))
    var_3 thread setalertedhuntmode(var_3);
  }

  wait 5;
  var_0 thread setalertedhuntmode(var_0);
}

alerted_hunt_mode(var_0) {
  var_0 notify("_encstr_812D12A3D3BF5078DB67011547C2A07847EF6839");
  var_0 notify("_encstr_A33912EBB2678DABC5A1F7A88B2BEBF78898D7AF");
  var_0 endon("_encstr_A33912EBB2678DABC5A1F7A88B2BEBF78898D7AF");
  var_0 endon("_encstr_88620CCAE0955B3F33015151AD5B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BDA012F357CB8E8702EFF031D36090C820537FFC");
  var_0 endon("_encstr_BA22087EA808525BA5D9");
  var_0.soldierhuntmode = undefined;
  var_0.alertedhuntmode = undefined;
  var_0.alerted_hunt_mode = 1;
  var_0.no_fallback = 1;

  for(;;) {
    if(istrue(var_0.behinddoors)) {
      var_1 = getnodesinradiussorted(var_0.origin, 512, 0, 24, "_encstr_B68E06D0F6B3CA27");
      var_0 setgoalandtimeout(var_1[0].origin);
      continue;
    }

    var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_0 scripts\cp\utility::get_closest_living_player(), var_0);

    if(!isDefined(var_2))
      var_2 = var_0;

    var_3 = getrandomnavpoint(var_2.origin, 1024);

    if(isDefined(var_3))
      var_0 setgoalandtimeout(var_3);
    else {
      var_3 = getrandomnavpoint(var_0.origin, 256);
      var_0 setgoalandtimeout(var_3);
    }
  }
}

hunt_player(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_88620CCAE0955B3F33015151AD5B");
  self endon("_encstr_88620CCAE0955B3F33015151AD5B");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    wait(var_0);

  while(!should_hunt_player())
    wait 1;

  self.hunting_player = 1;
  self.no_fallback = 1;

  for(;;) {
    var_2 = scripts\cp\utility::get_closest_living_player();

    if(isalive(var_2)) {
      self getenemyinfo(var_2);
      self setgoalentity(var_2, 3);
    }

    wait 3;
  }
}

should_hunt_player() {
  var_0 = 0;
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.hunting_player))
      var_0++;
  }

  if(var_0 > level.players.size * 2)
    return 0;
  else
    return 1;
}

reduce_goalradius_over_time(var_0) {
  self notify("_encstr_BE831C43A001E5A253307F750719EBB969B8D7DFD9D83E0A952883EC7923");
  self endon("_encstr_BE831C43A001E5A253307F750719EBB969B8D7DFD9D83E0A952883EC7923");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BDA012F357CB8E8702EFF031D36090C820537FFC");

  if(!isDefined(var_0))
    var_0 = 2;

  for(;;) {
    var_1 = self.goalradius - 100;

    if(self.goalradius < 250)
      self.goalradius = 250;
    else
      self.goalradius = var_1;

    wait(var_0);
  }
}

setweaponsfree(var_0) {
  var_0 notify("_encstr_AF7D0F604B5CC492A14895FEAE497AA2CD");
  var_0 endon("_encstr_AF7D0F604B5CC492A14895FEAE497AA2CD");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_8B3C117FF1C5F3E5D16529BB526A2B30C29DAD");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_143BA(5, "_encstr_938C091AC8B8AFFB036D37", "_encstr_84C80FD3603FC30B79FD97B0818147CF6D");

    if(isDefined(var_1)) {
      if(var_1 != "_encstr_995408F398012F656821")
        continue;
      else {
        var_0 thread setalertedhuntmode(var_0);
        return;
      }
    }
  }
}

toggleweaponsfree(var_0) {
  if(istrue(var_0))
    scripts\engine\utility::flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  else
    scripts\engine\utility::flag_clear("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

clearweaponsfree() {
  level notify("_encstr_8B3C117FF1C5F3E5D16529BB526A2B30C29DAD");

  foreach(var_1 in scripts\cp\cp_agent_utils::getactiveagentsoftype("_encstr_A7E80E1818902B623DBA872BD4C1184C"))
  var_1 thread setalertedhuntmode(var_1);
}

setalertedhuntmode(var_0) {
  var_0 set_default_soldier_values();

  if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
    var_0 setpatrolstate("_encstr_A33912EBB2678DABC5A1F7A88B2BEBF78898D7AF", "_encstr_931904C66102", 0, 0, 1, undefined, 0);
  else
    var_0 setpatrolstate("_encstr_84C80FD3603FC30B79FD97B0818147CF6D", "_encstr_AA7C07466F9DA30713", 1, 0, 0, undefined, 1);
}

_startsoldierpatrol(var_0) {
  var_0 set_default_soldier_values();
  var_0 thread patrol_path(var_0.spawnpoint, istrue(var_0.posted));
}

soldier_player_listener() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_929018AB88296973B85266097027AA101E3FF58A2B38535ED0CB");
  self endon("_encstr_929018AB88296973B85266097027AA101E3FF58A2B38535ED0CB");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 = ["_encstr_AAB014E1EB17D0C0C507BBAF2D7AD1ADF303188B8253", "_encstr_ABBA1D32E1F5ED479BF5AEDC6B13FAB2C307EDCD5691FA894E2B2CB5A5CDB3", "_encstr_93BA190A42E0EF4B28DF1D03A30A590F9BBB32E349C577C5B0830E", "_encstr_88F41D46E1FADEE8B9AFD5375B89EB593C1CDB9BCA91EBD6F667B2B5CA73D1", "_encstr_9BDF1DFD69E1109C2EFFAB5BF5EFBF1FC2E087F38765A1980E6B535F3B0FAB"];

  for(;;) {
    foreach(var_2 in level.players) {
      if(isplayernearme(self, var_2)) {
        if(isDefined(level.last_player_seen) && gettime() >= level.last_player_seen + 5000) {
          level.last_player_seen = gettime();
          scripts\cp\utility::playsoundatpos_safe(self.origin, scripts\engine\utility::random(var_0));
        }

        setpatrolstate("_encstr_84C80FD3603FC30B79FD97B0818147CF6D", "_encstr_AA7C07466F9DA30713", 1, 0, 0, undefined, 1);
        return;
      }
    }

    wait 0.1;
  }
}

isplayernearme(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(istrue(var_1.ignoreme))
    return 0;

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0.damaged);

  if(var_3 < 96) {
    if(vectordot(anglesToForward(var_0.angles), vectorNormalize(var_1.origin - var_0.origin)) > 0)
      return 1;
  }

  var_5 = 1;
  var_6 = var_1 getvelocity();
  var_7 = length(var_6);

  if(var_7 < 128)
    var_5 = 0.75;
  else if(var_7 < 200 || var_2 && var_1.perk_data["_encstr_BAB41A1F8CAFF8D93B62361B9A73B7B0C4E473CF0FD3101EDB6A6961"])
    var_5 = 1;
  else
    var_5 = 1.25;

  if(var_3 > 1500 * var_5)
    return 0;

  var_8 = var_0 cansee(var_1);

  if(var_8) {
    var_9 = cos(75);
    var_10 = scripts\engine\utility::within_fov(var_0 getEye(), var_0 getplayerangles(1), var_1.origin + (0, 0, 40), var_9);

    if(!var_10)
      return 0;

    var_11 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

    if(!var_11)
      return 0;

    var_12 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_12))
      return 0;

    var_13 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_1.origin);
    var_5 = 1;

    if(var_13 >= 0.573576)
      var_5 = var_5 - 0.34;

    if(var_4)
      var_5 = var_5 - 0.34;

    var_14 = var_1 getstance();

    if(var_3 <= int(350 / var_5)) {
      if(var_14 == "_encstr_922406F1A6FD5E05")
        return 0;

      return 1;
    } else if(var_3 <= int(500 / var_5)) {
      if(var_14 == "_encstr_922406F1A6FD5E05")
        return 0;

      return 1;
    } else if(var_3 <= int(950 / var_5)) {
      if(var_14 == "_encstr_922406F1A6FD5E05" || var_14 == "_encstr_B13D076BED70539F23")
        return 0;

      return 1;
    }
  }

  return 0;
}

alert_all_nearby_enemies(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && !scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    toggleweaponsfree(1);

  var_4 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");
  var_3 = istrue(var_3);

  foreach(var_6 in var_4) {
    if(!isDefined(var_6) || var_6 == self) {
      continue;
    }
    if(!isDefined(var_6.agent_type) || isDefined(var_6.agent_type) && var_6.agent_type != "_encstr_A7E80E1818902B623DBA872BD4C1184C") {
      continue;
    }
    if(!var_3 && isDefined(var_0) && distance2dsquared(self.origin, var_6.origin) > var_0) {
      continue;
    }
    if(!istrue(var_6.scripted_mode)) {
      continue;
    }
    if(var_6.team != self.team) {
      continue;
    }
    if(!istrue(var_2) && istrue(var_6.posted)) {
      continue;
    }
    var_6 notify("_encstr_AD171358D85693D1B219EB26CBF59BF61B32D2B2E4");
  }
}

debug_patrol_point_score_loop() {
  if(!scripts\engine\utility::flag_exist("_encstr_8BF119737899F2D7E877373970B3FFF1CB786AAB900BAD07C2C504")) {
    return;
  }
  scripts\engine\utility::flag_wait("_encstr_8BF119737899F2D7E877373970B3FFF1CB786AAB900BAD07C2C504");

  for(;;) {
    var_0 = getdvarint("_encstr_8EEF1727A322418F37EBEB7052F747083C36A1874C4F105547", 0);
    var_1 = getdvarint("_encstr_A9021B87EF43C8E8116B336895C720182A7331575F3BA8C92C0739237F", 0);

    if(var_0 != 0 && isDefined(level.players[0])) {
      var_2 = [];

      if(var_0 == 1)
        var_2 = level.allzpatrolpoints;
      else if(var_0 == 2)
        var_2 = level.allspatrolpoints;

      var_3 = sortbydistance(var_2, level.players[0].origin);
      var_4 = 0;

      foreach(var_6 in var_3) {
        if(var_1 > 0) {
          if(var_6.id != var_1)
            continue;
        }

        if(isDefined(var_6.patrolscore)) {
          if(isDefined(var_6.target)) {
            var_7 = scripts\engine\utility::getStructArray(var_6.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

            if(var_7.size >= 1) {
              foreach(var_9 in var_7)
              thread scripts\engine\utility::draw_line_for_time(var_6.origin, var_9.origin, 1, 0, 0, 0.1);
            } else
              thread scripts\engine\utility::draw_line_for_time(var_6.origin, var_6.origin + (0, 0, 128), 1, 1, 0, 0.1);
          }

          level thread debug_patrol_point_score(var_6, 0.1);
          var_4++;
        }

        if(var_4 >= 30) {
          break;
        }
      }
    }

    wait 0.1;
  }
}

debug_patrol_point_score(var_0, var_1) {
  var_2 = 0;
  var_3 = 125;
  var_4 = 300;
  var_5 = 500;
  var_6 = var_0.patrolscore;

  if(var_6 <= 0)
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 1, 1));
  else if(var_6 <= var_3)
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (0, 1, 0));
  else if(var_6 <= var_4)
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 1, 0));
  else
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 0, 0));
}