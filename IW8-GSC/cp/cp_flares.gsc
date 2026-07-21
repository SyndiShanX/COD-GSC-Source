/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_flares.gsc
***********************************************/

flares_monitor(var_0) {
  self.flaresreservecount = var_0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
}

flares_playFX(var_0) {
  var_1 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(isDefined(var_0))
    var_1 = var_0;

  playsoundatpos(self gettagorigin(var_1), "_encstr_B1F41110871769A12AEE1B95C972D1D1827748");
  playFXOnTag(level._effect["_encstr_91940F1BD14B275EE85BC7C671B8225F6E"], self, var_1);
}

flares_deploy() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin + (0, 0, -256));
  var_0.angles = self.angles;
  var_0 movegravity((0, 0, -1), 5.0);
  self.flareslive[self.flareslive.size] = var_0;
  var_0 thread flares_deleteaftertime(5.0, 2.0, self);
  playsoundatpos(var_0.origin, "_encstr_85C01038632FFF500A73598F4E05183E6FDB");
  return var_0;
}

flares_deleteaftertime(var_0, var_1, var_2) {
  if(isDefined(var_1) && isDefined(var_2)) {
    var_0 = var_0 - var_1;
    wait(var_1);

    if(isDefined(var_2))
      var_2.flareslive = scripts\engine\utility::array_remove(var_2.flareslive, self);
  }

  wait(var_0);
  self delete();
}

flares_getnumleft(var_0) {
  return var_0.flaresreservecount;
}

flares_areavailable(var_0) {
  flares_cleanflareslivearray(var_0);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

flares_getflarereserve(var_0) {
  flares_reducereserves(var_0);
  var_0 thread flares_playFX();
  var_1 = var_0 flares_deploy();
  return var_1;
}

flares_cleanflareslivearray(var_0) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

flares_getflarelive(var_0) {
  flares_cleanflareslivearray(var_0);
  var_1 = undefined;

  if(var_0.flareslive.size > 0)
    var_1 = var_0.flareslive[var_0.flareslive.size - 1];

  return var_1;
}

ks_laserguidedmissile_handleincoming() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  while(flares_areavailable(self)) {
    level waittill("_encstr_BA531D9D376FDAE27D30073B983185420756A415ADD7B131A0982707802867", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_4 in var_1) {
      if(isvalidmissile(var_4))
        level thread ks_laserguidedmissile_monitorproximity(var_4, var_0, var_0.team, var_2);
    }
  }
}

ks_laserguidedmissile_monitorproximity(var_0, var_1, var_2, var_3) {
  var_3 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A968165BB4376EB4B1ACEB8E58939D564768D0859BCE5623");

  while(flares_areavailable(var_3)) {
    if(!isDefined(var_3) || !isvalidmissile(var_0)) {
      break;
    }

    var_4 = var_3 getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_4) < 4000000) {
      var_5 = flares_getflarelive(var_3);

      if(!isDefined(var_5))
        var_5 = flares_getflarereserve(var_3);

      var_0 missile_settargetEnt(var_5);
      var_0 notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      break;
    }

    waitframe();
  }
}

flares_handleincomingsam(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  for(;;) {
    level waittill("_encstr_B4340A9BA073713BB0AEF5EC", var_1, var_2, var_3);

    if(!isDefined(var_3) || var_3 != self) {
      continue;
    }
    if(isDefined(var_0)) {
      level thread[[var_0]](var_1, var_1.team, var_3, var_2);
      continue;
    }

    level thread flares_watchsamproximity(var_1, var_1.team, var_3, var_2);
  }
}

flares_watchsamproximity(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = [];

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_3[var_6]))
        var_5[var_6] = distance(var_3[var_6].origin, var_4);
    }

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(isDefined(var_5[var_6])) {
        if(var_5[var_6] < 4000 && var_2.flaresreservecount > 0) {
          flares_reducereserves(var_2);
          var_2 thread flares_playFX();
          var_7 = var_2 flares_deploy();

          for(var_8 = 0; var_8 < var_3.size; var_8++) {
            if(isDefined(var_3[var_8])) {
              var_3[var_8] missile_settargetEnt(var_7);
              var_3[var_8] notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
            }
          }

          return;
        }
      }
    }

    waitframe();
  }
}

flares_handleincomingstinger(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  for(;;) {
    level waittill("_encstr_A1B90EC33B80328870DB219DE446B39B", var_2, var_3, var_4);

    if(!isDefined(var_4) || var_4 != self) {
      continue;
    }
    if(isDefined(var_0)) {
      var_3 thread[[var_0]](var_2, var_2.team, var_4, var_1);
      continue;
    }

    var_3 thread flares_watchstingerproximity(var_2, var_2.team, var_4, var_1);
  }
}

flares_watchstingerproximity(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      flares_reducereserves(var_2);
      var_2 thread flares_playFX(var_3);
      var_6 = var_2 flares_deploy();
      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    }

    waitframe();
  }
}

flares_reducereserves(var_0) {
  var_0.flaresreservecount--;

  if(isDefined(var_0.owner) && isPlayer(var_0.owner))
    var_0.owner setclientomnvar("_encstr_B1D115D55AAF5BA5B1C69B47E4562C5BAF998DC293959B", var_0.flaresreservecount);
}

ks_setup_manual_flares(var_0, var_1, var_2, var_3) {
  self.flaresreservecount = var_0;
  self.flareslive = [];

  if(isDefined(var_2) && isPlayer(self.owner))
    self.owner setclientomnvar(var_2, var_0);

  thread ks_manualflares_watchuse(var_1, var_2);
  thread ks_manualflares_handleincoming(var_3);
}

ks_manualflares_watchuse(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  if(!isai(self.owner))
    self.owner notifyonplayercommand("_encstr_B2B2140111C0C3F971990434EE3DC716409F98CADFCD", var_0);

  while(flares_getnumleft(self)) {
    self.owner waittill("_encstr_B2B2140111C0C3F971990434EE3DC716409F98CADFCD");
    var_2 = flares_getflarereserve(self);

    if(isDefined(var_2) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("_encstr_85C01038632FFF500A73598F4E05183E6FDB");

      if(isDefined(var_1))
        self.owner setclientomnvar(var_1, flares_getnumleft(self));
    }
  }
}

ks_manualflares_handleincoming(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A697107822C3DB70BD10B19B3AE91090A35A");

  while(flares_areavailable(self)) {
    self waittill("_encstr_84521DB9D773E470143FE19EE6F1692B4A3717034F1ABCD955140B13CCDCE0", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(self.owner) && isPlayer(self.owner)) {
      self.owner thread ks_watch_death_stop_sound(self, "_encstr_977B11658A62420AACBFF928F8799F79070A48");

      if(isDefined(var_0)) {
        var_2 = vectorNormalize(var_1[0].origin - self.origin);
        var_3 = vectorNormalize(anglestoright(self.angles));
        var_4 = vectordot(var_2, var_3);
        var_5 = 1;

        if(var_4 > 0)
          var_5 = 2;
        else if(var_4 < 0)
          var_5 = 3;

        self.owner setclientomnvar(var_0, var_5);
      }
    }

    foreach(var_7 in var_1) {
      if(isvalidmissile(var_7))
        thread ks_manualflares_monitorproximity(var_7);
    }
  }
}

ks_manualflares_monitorproximity(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var_0)) {
      break;
    }

    var_1 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_1) < 4000000) {
      var_2 = flares_getflarelive(self);

      if(isDefined(var_2)) {
        var_0 missile_settargetEnt(var_2);
        var_0 notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");

        if(isDefined(self.owner) && isPlayer(self.owner))
          self.owner stoplocalsound("_encstr_977B11658A62420AACBFF928F8799F79070A48");

        break;
      }
    }

    waitframe();
  }
}

ks_watch_death_stop_sound(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_AD75063D571AE108");
  self stoplocalsound(var_1);
}