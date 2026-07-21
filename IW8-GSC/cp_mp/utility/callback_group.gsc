/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\callback_group.gsc
***********************************************/

init() {
  level._id_12312 = spawnStruct();
  level._id_12312._id_12308 = [(-289, -1790, 58), (-2055, -2255, 73), (152, 3486, 110)];
  level._id_12312.petconsts = [];
  level._id_12312._id_12311 = [];
  level._id_12312._id_126A3 = [];
  level._id_12312.players = [];
  level._id_12312.modular_spawning_vehicles = [(1902, -2401, 58)];
  level._id_12312.modsforvehicle = [3, 2, 1];
  level._id_12312.module_call_counter = [];
  var_0 = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 1);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_2 = int(var_2);
    var_3 = spawnStruct();
    var_3.rarity = int(tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 2));
    var_3._id_11E79 = int(tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 3));
    var_3._id_14679 = int(tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 4));
    var_3.getcargotruckspawns = int(tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 5));
    var_3.showsplashtoall = int(tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 8));
    var_3.change_goal_radius_weapons_free_internal = int(tablelookupbyrow("_encstr_86F817B5C1F21C2BD1BA0BD1B11A8E7B451613D8CAB8D8CDB3", var_1, 8));
    level._id_12312.petconsts[var_2] = var_3;

    for(var_4 = 0; var_4 < var_3.rarity; var_4++)
      var_0[var_0.size] = var_2;

    var_1++;
  }

  var_5 = 3;

  for(var_1 = 0; var_1 < var_5; var_1++) {
    var_6 = level._id_12312._id_12308[var_1];
    var_7 = randomintrange(0, var_0.size);
    var_8 = var_0[var_7];
    level._id_12312._id_12311[var_1] = var_8;
    level._id_12312._id_126A3[var_1] = [];
  }

  level thread select_patrol_eight_spawners();
}

initpet(var_0) {
  if(!isDefined(self._id_12313)) {
    self._id_12313 = spawnStruct();
    self._id_12313.nuke_core_tug_of_war = [];
    self._id_12313._id_1230F = [1, 2, 3];
    self._id_12313.insidecuavbunker = 0;
    self._id_12313._id_12310 = self._id_12313._id_1230F[self._id_12313.insidecuavbunker];
    level._id_12312.players[level._id_12312.players.size] = self;
  }

  thread select_stadium_two_spawners();
  self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", self._id_12313._id_12310);
  self setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BAA40A47A8F79F0BD748F01A");
}

select_patrol_eight_spawners() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_2 = level._id_12312._id_12308[var_0];
    var_3 = level._id_12312._id_12311[var_0];

    if(var_3 > 0) {
      var_4 = scripts\common\utility::playersnear(var_2, 1500);

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_6 = var_4[var_5];

        if(isDefined(var_6) && isalive(var_6) && isDefined(var_6._id_12313)) {
          var_1 = level._id_12312._id_126A3[var_0].size;
          level._id_12312._id_126A3[var_0][var_1] = var_6;
          var_6 _id_12605(var_3, var_0, var_2);
        }
      }
    }

    var_0++;

    if(var_0 >= level._id_12312._id_12308.size)
      var_0 = 0;

    var_7 = level._id_12312.players[var_1];

    if(isDefined(var_7) && isalive(var_7)) {
      if(var_7._id_12313.nuke_core_tug_of_war.size == 0) {
        for(var_5 = 0; var_5 < level._id_12312.players.size; var_5++) {
          var_10 = level._id_12312.players[var_5];

          if(var_7 != var_10 && isalive(var_10) && isDefined(var_10._id_12313)) {
            var_9 = distancesquared(var_7.origin, var_10.origin);

            if(var_9 < 1000000) {
              var_7 nuke_killplayer(var_10);
              break;
            }
          }
        }
      } else {
        for(var_5 = 0; var_5 < var_7._id_12313.nuke_core_tug_of_war.size; var_5++) {
          var_11 = var_7._id_12313.nuke_core_tug_of_war[var_5];
          var_9 = distancesquared(var_7.origin, var_11.origin);

          if(var_9 > 4000000) {
            var_7 lock_player_stance(var_11);
            break;
          }
        }
      }
    }

    var_1++;

    if(var_1 >= level._id_12312.players.size)
      var_1 = 0;

    waitframe();
  }
}

onplayerkilled(var_0) {
  for(var_1 = 0; var_1 < self._id_12313.nuke_core_tug_of_war.size; var_1++) {
    var_2 = self._id_12313.nuke_core_tug_of_war[var_1];
    var_2 _id_12F13(self);
  }

  self._id_12313.nuke_core_tug_of_war = [];
}

_id_12F13(var_0) {
  self._id_12313.nuke_core_tug_of_war = scripts\engine\utility::array_remove(self._id_12313.nuke_core_tug_of_war, var_0);
  self iprintlnbold("_encstr_A2CC1010A72841D39354E415014452514410");
  self setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", 16);
  var_0 setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", 17);
}

lock_player_stance(var_0) {
  self._id_12313.nuke_core_tug_of_war = scripts\engine\utility::array_remove(self._id_12313.nuke_core_tug_of_war, var_0);

  if(self._id_12313.nuke_core_tug_of_war.size > 0) {
    for(var_1 = 0; var_1 < self._id_12313.nuke_core_tug_of_war.size; var_1++) {
      var_2 = self._id_12313.nuke_core_tug_of_war[var_1];

      if(isDefined(var_2) && isalive(var_2)) {
        nuke_killplayer(var_2);
        return;
      }
    }
  }

  self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 1);
}

nuke_killplayer(var_0) {
  self._id_12313.nuke_core_tug_of_war[self._id_12313.nuke_core_tug_of_war.size] = var_0;
  self iprintlnbold("_encstr_A547130FB99706C12941A77B8BEBB2D9867D0F86D2");
  self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", var_0._id_12313._id_12310 + 100);
  self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 2);
}

nuke_hostmigration_waittillhostmigrationdone(var_0) {
  var_1 = level._id_12312.modular_spawning_vehicles[var_0];
  var_2 = level._id_12312.modsforvehicle[var_0];
  var_3 = level._id_12312.module_call_counter[var_0];
  self._id_12313.nuke_core_tug_of_war[self._id_12313.nuke_core_tug_of_war.size] = var_3;
  self iprintlnbold("_encstr_AC7F13D1182F83ED1F30BCBB7C1339C103B0194996");
  self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", var_2 + 100);
  self setclientomnvar("_encstr_97921C8B0989D8E583B9AB1173A72BE99E973533BB61883FB382E1B9E9C6", 2);
}

_id_144E1() {
  if(self._id_12313.nuke_core_tug_of_war.size > 0) {
    self._id_12313.insidecuavbunker++;

    if(self._id_12313.insidecuavbunker >= self._id_12313._id_1230F.size)
      self._id_12313.insidecuavbunker = 0;

    self._id_12313._id_12310 = self._id_12313._id_1230F[self._id_12313.insidecuavbunker];
    level._id_12312.players[level._id_12312.players.size] = self;
    self setclientomnvar("_encstr_AD921C272340EB8D40360B964BA0D851A657C3BFBFE86241983887DF4612", self._id_12313._id_12310);
  } else if(isDefined(self._id_12313.wam_pointer)) {
    var_0 = level._id_12312._id_12311[self._id_12313.wam_pointer];

    if(var_0 > 0)
      lower_door_coll(self._id_12313.wam_pointer);
  }
}

lower_door_coll(var_0) {
  var_1 = level._id_12312._id_12311[var_0];
  level._id_12312._id_12311[var_0] = 0;
  self setclientomnvar("_encstr_A75B142DF1E7936BBB5908B08316090E776335AB5FFB", var_1);
}

_id_12605(var_0, var_1, var_2) {
  var_3 = int(distance(self.origin, var_2)) * 100;
  var_4 = int(min(var_3, 900000));
  var_5 = vectorNormalize(var_2 - self.origin);
  var_6 = vectortoangles(var_5);
  var_7 = var_6[1] - self.angles[1];

  if(var_7 < 0)
    var_7 = var_7 + 360;
  else if(var_7 > 360)
    var_7 = var_7 - 360;

  self._id_12313.wam_pointer = var_1;
  var_8 = int(var_7 / 10) + var_4;
  self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", var_8);
}

level_create_timer() {}

select_stadium_two_spawners() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_850D187F0FB1051883DCE158C58D804C5A47EBD1C7DADD10B0E4");
  self endon("_encstr_850D187F0FB1051883DCE158C58D804C5A47EBD1C7DADD10B0E4");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_92981207B23ABB2CD1361AD776BDF5D8A1B0C9D6") {
      switch (var_1) {}

      continue;
    }

    if(var_0 == "_encstr_8FD2156AC09BAFE00307D886A8E322F67FA1282336794D") {}
  }
}