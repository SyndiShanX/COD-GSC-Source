/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4cdabcd91a92977.gsc
************************************************/

#using script_4cdabcd91a92977;
#using scripts\common\ae_utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\playerachievements;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace namespace_bd89c4c41be78d43;

function main() {
  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  level.lobbyid = function_4f9373a1227db35c();
  level.var_73e946a3eadc84be = function_8345f2ac499e5ab();
  level.var_f60ab21fbeb423c = undefined;
  level.var_37767375d12e7150 = [];
  level.var_3da7cf812433fd50 = getdvarint(@ "hash_35fe3b926d86a034", 1);
  level.var_e20af527a1d336f6 = getdvarint(@ "hash_d5ff0d8a153049ed", 1);
  level.var_93535d58322394f6 = getdvarint(@ "hash_52278a2e894c7b5b", 5);
  level.var_41a1383064b06b78 = getdvarint(@ "hash_730841e9076cb2d7", 1) == 1;
  level.var_a92efeef2c4f6e45 = getdvarint(@ "hash_5d13c057b0e9cc7b", 0) == 1;
  level.var_8c4a1a7b619d8e7c = getdvarint(@ "hash_ae52a11cd305ab26", 1) == 1;
  level.var_bcd757fb7c2137b1 = getdvarfloat(@ "hash_522795feb86c7c2a", 1);
  level.var_83b8cf86ae62e3da = undefined;

  if(!isDefined(game["rejoinedPlayers"])) {
    game["rejoinedPlayers"] = [];
  }

  level thread function_860ade42d09bcc50();
  level thread function_990e6e94fef53e1a();
}

function function_e3bd94413509bc25() {
  return getdvarint(@ "hash_925f7dceb8e6205e", 0) && getdvarint(@ "hash_22eddf44003baf9", 0);
}

function function_8ce5b106fbba9e9f(callbackfn) {
  level.var_f60ab21fbeb423c = callbackfn;
}

function function_8fe6d6539ed31a88(callbackfn) {
  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  if(!isDefined(level.var_37767375d12e7150)) {
    level.var_37767375d12e7150 = [];
  }

  level.var_37767375d12e7150[level.var_37767375d12e7150.size] = callbackfn;
}

function function_ead10448a780a58(callbackfn) {
  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  level.var_83b8cf86ae62e3da = callbackfn;
}

function function_884994e73914ee32(aeeventname) {
  if(isDefined(level.var_f60ab21fbeb423c)) {
    return [[level.var_f60ab21fbeb423c]](self, aeeventname);
  }

  return [];
}

function function_19f146e8ffa78ff9(disconnectreason) {
  if(isDefined(level.var_83b8cf86ae62e3da)) {
    return [[level.var_83b8cf86ae62e3da]](self, disconnectreason);
  }

  return 1;
}

function function_71fbbbf19edcef28() {
  if(istrue(level.var_e20af527a1d336f6)) {
    teammates = level.teamdata[self.team]["alivePlayers"];
    var_ffc368c1d2a95b7b = 0;

    if(isDefined(teammates) && teammates.size > 0) {
      foreach(teammate in teammates) {
        if(self == teammate) {
          continue;
        }

        var_ffc368c1d2a95b7b++;
      }
    }

    if(var_ffc368c1d2a95b7b > 0) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function function_c9b26cfb4d93ae50() {
  if(isDefined(level.var_93535d58322394f6) && level.var_93535d58322394f6 >= 1) {
    teamsremaining = 0;

    foreach(entry in level.teamnamelist) {
      alivecount = level.teamdata[entry]["aliveCount"];

      if(alivecount > 0) {
        teamsremaining++;
      }

      if(teamsremaining >= level.var_93535d58322394f6) {
        return true;
      }
    }

    return false;
  }

  return true;
}

function function_87fc9992c0b60276(var_c4f3e9732aa81389) {
  var_9642449afa2ebf37 = 0;

  switch (var_c4f3e9732aa81389) {
    case 0:
      var_9642449afa2ebf37 = 0;
      break;
    case 1:
    case 2:
      var_9642449afa2ebf37 = getdvarint(@ "hash_1839b10b70a97d91", 0);
      break;
    case 3:
      var_9642449afa2ebf37 = getdvarint(@ "hash_f690f29f47f7a379", 0);
      break;
    case 6:
      var_9642449afa2ebf37 = getdvarint(@ "hash_b37dbaa903c45ccd", 1);
      break;
    case 7:
      var_9642449afa2ebf37 = getdvarint(@ "online_rejoin_allow_inactivity", 0);
      break;
    case 14:
      var_9642449afa2ebf37 = getdvarint(@ "online_rejoin_allow_force_disconnect", 0);
      break;
    default:
      var_9642449afa2ebf37 = 1;
      break;
  }

  if(!var_9642449afa2ebf37) {
    return false;
  }

  var_9642449afa2ebf37 = function_19f146e8ffa78ff9(var_c4f3e9732aa81389);

  if(!var_9642449afa2ebf37) {
    return false;
  }

  var_9642449afa2ebf37 = function_c9b26cfb4d93ae50();

  if(!var_9642449afa2ebf37) {
    return false;
  }

  var_9642449afa2ebf37 = function_71fbbbf19edcef28();

  if(!var_9642449afa2ebf37) {
    return false;
  }

  return true;
}

function function_69359e69555329ac(disconnectreason) {
  player = self;
  level endon("game_ended");
  player notify("rejoin_analytics_start");
  player endon("rejoin_analytics_start");
  isplayeronground = player isonground();
  isplayerinvehicle = player scripts\cp_mp\utility\player_utility::isinvehicle();
  isplayerinwater = player isswimming();
  var_15ad7f4a17476a54 = player ispcplayer();
  var_7d723d78c14b4a78 = player usinggamepad();
  playerorigin = player.origin;
  var_79544f8fc581743a = gettime();
  playerteam = player.team;
  var_3ee23976deb888b9 = player waittill_any_return_2("successfully_disconnect_rejoin", "rejected_disconnect_rejoin");

  if(!isDefined(player)) {
    return;
  }

  eventparams = [];
  eventparams[eventparams.size] = "is_rejoin_successful";
  isrejoinsuccessful = 0;

  if(isDefined(var_3ee23976deb888b9)) {
    isrejoinsuccessful = ter_op(var_3ee23976deb888b9 == "successfully_disconnect_rejoin", 1, 0);
  }

  eventparams[eventparams.size] = isrejoinsuccessful;
  eventparams[eventparams.size] = "rejoin_type";
  eventparams[eventparams.size] = disconnectreason;
  eventparams[eventparams.size] = "rejoin_duration";
  rejoinduration = -1;

  if(isDefined(var_79544f8fc581743a)) {
    rejoinduration = (gettime() - var_79544f8fc581743a) / 1000;
  }

  eventparams[eventparams.size] = rejoinduration;
  eventparams[eventparams.size] = "player_x";
  eventparams[eventparams.size] = playerorigin[0];
  eventparams[eventparams.size] = "player_y";
  eventparams[eventparams.size] = playerorigin[1];
  eventparams[eventparams.size] = "player_z";
  eventparams[eventparams.size] = playerorigin[2];
  eventparams[eventparams.size] = "squad_size";
  numteammates = -1;

  if(isDefined(level.teamdata)) {
    numteammates = int(level.teamdata[playerteam]["players"].size);
  }

  eventparams[eventparams.size] = numteammates;
  eventparams[eventparams.size] = "player_platform";
  eventparams[eventparams.size] = var_15ad7f4a17476a54;
  eventparams[eventparams.size] = "player_input";
  eventparams[eventparams.size] = var_7d723d78c14b4a78;
  eventparams[eventparams.size] = "match_alive_players_left";
  alivecounttotal = -1;

  if(isDefined(level.teamnamelist) && isDefined(level.teamdata)) {
    foreach(entry in level.teamnamelist) {
      alivecounttotal += level.teamdata[entry]["aliveCount"];
    }

    alivecounttotal++;
  }

  eventparams[eventparams.size] = alivecounttotal;
  eventparams[eventparams.size] = "is_player_swimming";
  eventparams[eventparams.size] = isplayerinwater;
  eventparams[eventparams.size] = "is_player_in_vehicle";
  eventparams[eventparams.size] = isplayerinvehicle;
  eventparams[eventparams.size] = "is_player_on_ground";
  eventparams[eventparams.size] = isplayeronground;
  player dlog_recordplayerevent("dlog_event_br_disconnect_rejoin", eventparams);
}

function function_2e8537357f01a56b(var_1e904d14a41d4385, key) {
  i = 0;

  while(i < var_1e904d14a41d4385.size - 1) {
    if(var_1e904d14a41d4385[i] == key) {
      return i;
    }

    i += 2;
  }

  return undefined;
}

function function_2fcdc8c12f068abb(array1, array2, var_e1e0e4a54c3d275c) {
  combined = [];

  if(!isarray(array1) || array1.size % 2 != 0 || !isarray(array2) || array2.size % 2 != 0) {
    scripts\engine\utility::error("called rejoin_utility::combineKVPArrays with invalid array");
    return combined;
  }

  keys = [];
  values = [];
  i = 0;
  j = 0;

  while(i < array1.size - 1 || j < array2.size - 1) {
    if(i < array1.size - 1 && !scripts\engine\utility::array_contains(keys, array1[i])) {
      keys[keys.size] = array1[i];
      values[values.size] = array1[i + 1];
    }

    if(j < array2.size - 1 && !scripts\engine\utility::array_contains(keys, array2[j])) {
      keys[keys.size] = array2[j];
      values[values.size] = array2[j + 1];
    }

    i += 2;
    j += 2;
  }

  var_71eb150f91b3456b = scripts\engine\utility::ter_op(istrue(var_e1e0e4a54c3d275c), array2, array1);
  i = 0;

  while(i < var_71eb150f91b3456b.size - 1) {
    key = var_71eb150f91b3456b[i];
    var_2172db62590952ae = scripts\engine\utility::array_find(keys, key);

    if(isDefined(var_2172db62590952ae)) {
      values[var_2172db62590952ae] = var_71eb150f91b3456b[i + 1];
    }

    i += 2;
  }

  for(i = 0; i < keys.size; i++) {
    combined[combined.size] = keys[i];
    combined[combined.size] = values[i];
  }

  return combined;
}

function function_dc60e20e9216b5b2() {
  if(!level.onlinegame) {
    println("<dev string:x1c>");
    return;
  }

  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  var_ba664f53dea8a25c = getdvarint(@ "hash_925f7dceb8e6205e", 0);
  function_c5728699e6b79552(var_ba664f53dea8a25c);
}

function function_4064a2271de12b97() {
  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  function_c5728699e6b79552(0);
  setDvar(@ "hash_925f7dceb8e6205e", 0);
}

function function_342af7ea8a120b16() {
  if(!level.onlinegame) {
    println("<dev string:x58>");
    return;
  }

  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  var_ba664f53dea8a25c = getdvarint(@ "hash_925f7dceb8e6205e", 0);
  aeeventname = #"connection_update";

  if(var_ba664f53dea8a25c) {
    function_74b707898164ed78(0, 0, aeeventname, []);
    return;
  }

  function_e90d7800fb5eec03(0, aeeventname, []);
}

function function_59121677f31f75a5() {
  self endon("disconnect");
  level endon("game_ended");

  if(!getdvarint(@ "hash_22eddf44003baf9", 0)) {
    return;
  }

  xuid = self getxuid();

  if(getdvarint(@ "online_rejoin_wait_for_streaming", 0)) {
    if(isDefined(level.var_67a646dc2b984dac)) {
      self thread[[level.var_67a646dc2b984dac]]();
    }

    if(isDefined(level.var_62a7b43f2b60646d)) {
      self[[level.var_62a7b43f2b60646d]]();
    }
  }

  if(!array_contains(game["rejoinedPlayers"], xuid)) {
    println("<dev string:x9b>" + self.name + "<dev string:xc6>" + xuid + "<dev string:xcc>");
    game["rejoinedPlayers"] = array_add_safe(game["rejoinedPlayers"], xuid);
  } else {
    println("<dev string:xe9>" + self.name + "<dev string:xc6>" + xuid + "<dev string:x10d>");
  }

  self.var_632bad3edb4e449e = 0;
  self notify("successfully_disconnect_rejoin");
  self notify("afk_tracking_resume");
  self.var_cbece90c5beea82 = 0;

  if(isDefined(level.var_2f60d02380cd603d)) {
    self[[level.var_2f60d02380cd603d]]();
  }

  if(isDefined(level.var_37767375d12e7150)) {
    foreach(callback in level.var_37767375d12e7150) {
      [[callback]](self);
    }
  }
}

function function_8cf8ff669ac52156(disconnectreason, var_cf51d5a9282df88b) {
  aeeventname = #"connection_update";
  additionalkvps = function_884994e73914ee32(aeeventname);
  var_ba664f53dea8a25c = getdvarint(@ "hash_925f7dceb8e6205e", 0);

  if(getdvarint(@ "hash_22eddf44003baf9", 0) != 0 && var_ba664f53dea8a25c) {
    var_c4f3e9732aa81389 = function_4f6df967144e2cb4(disconnectreason);

    if(isDefined(var_cf51d5a9282df88b) && var_cf51d5a9282df88b) {
      self.var_632bad3edb4e449e = 1;
    }

    var_38968ef355b4d2ec = 0;

    if(var_c4f3e9732aa81389 != 0) {
      var_38968ef355b4d2ec = function_87fc9992c0b60276(var_c4f3e9732aa81389);

      if(var_38968ef355b4d2ec) {
        xuid = self getxuid();

        if(array_contains(game["rejoinedPlayers"], xuid)) {
          var_c4f3e9732aa81389 = 5;
          var_38968ef355b4d2ec = getdvarint(@ "online_rejoin_allow_repeated_disconnect", 0);
        }
      }
    }

    if(!istrue(var_cf51d5a9282df88b)) {
      var_38968ef355b4d2ec = 0;
    }

    if(var_38968ef355b4d2ec) {
      function_74b707898164ed78(var_c4f3e9732aa81389, 1, aeeventname, additionalkvps);
      thread function_69359e69555329ac(var_c4f3e9732aa81389);
      self.var_cbece90c5beea82 = 1;

      if(istrue(level.var_41a1383064b06b78)) {
        wait level.var_bcd757fb7c2137b1;
        vehicle = self.vehicle;

        if(isDefined(vehicle)) {
          driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

          if(isDefined(driver) && driver == self) {
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(vehicle, undefined, self, undefined, 1);
          }
        }
      }

      if(istrue(level.var_a92efeef2c4f6e45)) {
        wait level.var_bcd757fb7c2137b1;
        self suicide();
      }
    } else {
      function_e90d7800fb5eec03(var_c4f3e9732aa81389, aeeventname, additionalkvps);
      self notify("rejected_disconnect_rejoin");
    }

    return;
  }

  function_13399aa20634edce(aeeventname, additionalkvps);
}

function private function_860ade42d09bcc50() {
  level endon("game_ended");

  while(true) {
    waitdelayseconds = getdvarint(@ "hash_cb027608b7396745", 30);

    if(waitdelayseconds <= 10) {
      waitdelayseconds = 10;
    }

    wait waitdelayseconds;
    var_a1e7045e3e4ca353 = [];

    if(!isDefined(level.players) || level.players.size == 0) {
      continue;
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.var_632bad3edb4e449e) && player.var_632bad3edb4e449e == 1) {
        if(isDefined(player.var_2ff6825157b156e) && player.var_2ff6825157b156e == 1) {
          var_a1e7045e3e4ca353[var_a1e7045e3e4ca353.size] = player;
        }
      }
    }

    var_f0fa8d0645074b69 = getdvarint(@ "hash_3c26c38af324c343", 7446);
    function_10a17a516d1e84ed(var_a1e7045e3e4ca353, var_f0fa8d0645074b69);
  }
}

function private function_990e6e94fef53e1a() {
  level endon("game_ended");

  while(true) {
    waitdelayseconds = getdvarint(@ "hash_e1b1c0bfb40859f", 1);

    if(waitdelayseconds <= 1) {
      waitdelayseconds = 1;
    }

    wait waitdelayseconds;

    if(!isDefined(level.players) || level.players.size == 0) {
      continue;
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.var_97ca959a561f976e) && player.var_97ca959a561f976e == 1) {
        kick(player getentitynumber(), "EXE/PLAYERKICKED_REJOIN");
        continue;
      }

      if(isDefined(player.var_632bad3edb4e449e) && player.var_632bad3edb4e449e == 1) {
        if(isDefined(player.var_2ff6825157b156e) && player.var_2ff6825157b156e == 0) {
          logstring("<dev string:x141>" + player getxuid() + "<dev string:x190>");

          kick(player getentitynumber(), "EXE/PLAYERKICKED_REJOIN");
        }
      }
    }
  }
}

function function_a1b2dc3090437789(achievementid, progressdata) {
  var_f0fa8d0645074b69 = getdvarint(@ "hash_3c26c38af324c343", 7446);

  if(achievementid == var_f0fa8d0645074b69) {
    var_2a7a539b9d1d9972 = scripts\cp_mp\playerachievements::function_691880160b33d133("sub_progress");
    subprogress = 0;

    for(index = 0; index < progressdata.progress_values.size; index++) {
      progress_id = progressdata.progress_values[index].progress_id;

      if(var_2a7a539b9d1d9972 == progress_id) {
        subprogress = progressdata.progress_values[index].progress;
        break;
      }
    }

    println("<dev string:x1b7>" + self.name + "<dev string:x1fb>" + achievementid + "<dev string:x208>" + subprogress);

    if(subprogress == 10) {
      logstring("<dev string:x21a>" + self getxuid() + "<dev string:x25d>");

      self.var_97ca959a561f976e = 1;
      return;
    }

    if(subprogress == 11) {
      logstring("<dev string:x21a>" + self getxuid() + "<dev string:x27d>");

      self.var_97ca959a561f976e = 1;
      self.var_5bf9e082ad798489 = 1;
    }
  }
}

function function_c5728699e6b79552(var_38968ef355b4d2ec) {
  var_ba664f53dea8a25c = getdvarint(@ "hash_925f7dceb8e6205e", 0);
  aeeventname = #"connection_update";

  foreach(player in level.players) {
    if(var_ba664f53dea8a25c && var_38968ef355b4d2ec) {
      player function_74b707898164ed78(0, 0, aeeventname, []);
      continue;
    }

    player function_e90d7800fb5eec03(0, aeeventname, []);
  }
}

function function_fb67b62bbd718b34() {
  now = getsystemtime();
  rejoin_duration = getdvarint(@ "online_rejoin_expiry_time_s", 0);
  var_1517a9cfb1f4de62 = scripts\engine\utility::ter_op(rejoin_duration == 0, 0, now + rejoin_duration);
  return var_1517a9cfb1f4de62;
}

function function_74b707898164ed78(reason, var_21907994a349f164, aeeventname, additionalkvps) {
  if(!level.onlinegame) {
    println("<dev string:x2a0>");
    return;
  }

  if(!getdvarint(@ "hash_925f7dceb8e6205e", 0)) {
    println("<dev string:x2e2>" + self.name + "<dev string:x318>");
    return;
  }

  if(!isDefined(reason)) {
    println("<dev string:x2e2>" + self.name + "<dev string:x337>");
    return;
  }

  if(!isint(reason)) {
    println("<dev string:x2e2>" + self.name + "<dev string:x356>");
    return;
  }

  self.var_2ff6825157b156e = 1;
  gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
  var_1517a9cfb1f4de62 = 0;

  if(var_21907994a349f164) {
    var_1517a9cfb1f4de62 = namespace_bf9ffd2b22c7d819::function_fb67b62bbd718b34();
    println("<dev string:x373>" + self.name + "<dev string:x3aa>" + reason + "<dev string:x3b8>" + level.var_73e946a3eadc84be + "<dev string:x3c8>" + level.lobbyid + "<dev string:x3d7>" + var_1517a9cfb1f4de62);
  }

  var_bd15d7d46de8f2de = [function_d6f771aedba70ce7(aeeventname, #"hash_b212dbb46f19de20"), 1, function_d6f771aedba70ce7(aeeventname, #"disconnect_reason"), reason, function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_73e946a3eadc84be, function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, function_d6f771aedba70ce7(aeeventname, #"hash_d8d873c978f56981"), level.lobbyid, function_d6f771aedba70ce7(aeeventname, #"hash_ab984d923d5f2c96"), var_1517a9cfb1f4de62, function_d6f771aedba70ce7(aeeventname, #"playlist_version"), getplaylistversion()];

  if(isDefined(additionalkvps) && additionalkvps.size > 0) {
    var_bd15d7d46de8f2de = function_2fcdc8c12f068abb(var_bd15d7d46de8f2de, additionalkvps, 1);
  }

  function_13399aa20634edce(aeeventname, var_bd15d7d46de8f2de);
  self function_10f8291e7ffed82c(1, var_1517a9cfb1f4de62);
}

function function_e90d7800fb5eec03(reason, aeeventname, additionalkvps) {
  if(!level.onlinegame) {
    println("<dev string:x3ea>");
    return;
  }

  if(!isDefined(reason)) {
    println("<dev string:x427>" + self.name + "<dev string:x337>");
    return;
  }

  if(!isint(reason)) {
    println("<dev string:x427>" + self.name + "<dev string:x356>");
    return;
  }

  println("<dev string:x464>" + self.name + "<dev string:x3aa>" + reason + "<dev string:x3b8>" + level.var_73e946a3eadc84be + "<dev string:x3c8>" + level.lobbyid + "<dev string:x4a2>");
  self.var_2ff6825157b156e = 0;
  gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
  var_bd15d7d46de8f2de = [function_d6f771aedba70ce7(aeeventname, #"hash_b212dbb46f19de20"), 0, function_d6f771aedba70ce7(aeeventname, #"disconnect_reason"), reason, function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_73e946a3eadc84be, function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, function_d6f771aedba70ce7(aeeventname, #"hash_d8d873c978f56981"), level.lobbyid, function_d6f771aedba70ce7(aeeventname, #"playlist_version"), getplaylistversion()];

  if(isDefined(additionalkvps) && additionalkvps.size > 0) {
    var_bd15d7d46de8f2de = function_2fcdc8c12f068abb(var_bd15d7d46de8f2de, additionalkvps, 1);
  }

  function_13399aa20634edce(aeeventname, var_bd15d7d46de8f2de);
  self function_10f8291e7ffed82c(0);
}

function function_13399aa20634edce(aeeventname, var_1e904d14a41d4385) {
  if(!isDefined(var_1e904d14a41d4385) || !isDefined(var_1e904d14a41d4385.size) || var_1e904d14a41d4385.size < 2) {
    return;
  }

  if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
    function_f3bb4f4911a1beb2("challenges", "reportChallengeUserSerializedEventWrapper", function_6e2deb013c9ca85e(aeeventname), var_1e904d14a41d4385);
  }
}

function function_4f6df967144e2cb4(disconnectreason) {
  if(disconnectreason == % "EXE/PLAYERKICKED_TEAMKILLS") {
    return 3;
  } else if(disconnectreason == % "exe/disconnected") {
    return 14;
  } else if(disconnectreason == % "hash_7ca98f63b2722011") {
    return 2;
  } else if(disconnectreason == % "hash_7194ffe36169ca7") {
    return 2;
  } else if(disconnectreason == % "hash_5b309dc0bff1f44d") {
    return 2;
  } else if(disconnectreason == % "exe/timedout") {
    return 6;
  } else if(disconnectreason == % "EXE/PLAYERKICKED_INACTIVE") {
    return 7;
  }

  return 0;
}