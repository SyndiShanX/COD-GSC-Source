/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\codcaster_utils.gsc
*************************************************/

sendcodcasternotification(var_0, var_1, var_2) {
  if(!isDefined(level.codcasternotificationqueuethreadexist) || level.codcasternotificationqueuethreadexist == 0) {
    level thread processenqueuednotifications();
  }

  enqueuenotification(encodenotification(var_0, var_1, var_2));
  level notify("codcasterNotificationEnqueued");
}

processenqueuednotifications() {
  level endon("game_ended");
  level.codcasternotificationqueuethreadexist = 1;

  for(;;) {
    if(!isDefined(game["codcasterEncodedNotificationQueue"]) || !_func_0107(game["codcasterEncodedNotificationQueue"])) {
      game["codcasterEncodedNotificationQueue"] = [];
    }

    while(game["codcasterEncodedNotificationQueue"].size > 0) {
      setcodcasternotificationomnvar(game["codcasterEncodedNotificationQueue"][0]);
      game["codcasterEncodedNotificationQueue"] = ::scripts\engine\utility::array_remove_index(game["codcasterEncodedNotificationQueue"], 0, 0);
      _id_10839(getdvarint("#x360e9a852dbf24c6b", 3));
    }

    level waittill("codcasterNotificationEnqueued");
  }
}

enqueuenotification(var_0) {
  game["codcasterEncodedNotificationQueue"] = ::scripts\engine\utility::_id_1B8D(game["codcasterEncodedNotificationQueue"], var_0);
}

setcodcasternotificationomnvar(var_0) {
  if(isDefined(var_0)) {
    setomnvar("ui_codcaster_notification", var_0);
  }
}

encodenotification(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_1)) {
    var_3 = var_3 + (var_1 + 1) * 100;
  }

  if(isDefined(var_2)) {
    if(_func_02B7(var_2)) {
      var_3 = var_3 + var_2 * 100 * 100;
    } else {
      scripts\engine\utility::_id_5598("codcaster notification extra data supports numbers only. Invalid extra data: " + var_2);
    }
  }

  return var_3;
}

totalgametimelogic() {
  level endon("game_ended");

  if(!isDefined(game["total_game_time"])) {
    game["total_game_time"] = 0;
  }

  level waittill("prematch_over");

  for(;;) {
    if(!isDefined(level.isesportstimerpaused) || !level.isesportstimerpaused) {
      var_0 = game["total_game_time"];
      game["total_game_time"] = game["total_game_time"] + level._id_01E2;

      if(floor(var_0 / 1000) != floor(game["total_game_time"] / 1000)) {
        foreach(var_2 in level.players) {
          if(var_2 _meth_81D3()) {
            var_2 setclientomnvar("ui_total_game_time", game["total_game_time"]);
          }
        }
      }
    }

    waitframe();
  }
}

esportshandletimeout(var_0, var_1) {
  if(getdvarint("#x33897ccb203dd1dbc", 0) == 1 && level.gametype != "koth") {
    if(getdvarint("#x383e0c5b0ec26c0cf", 0) == 0) {
      setDvar("#x383e0c5b0ec26c0cf", 1);
    }

    if(var_0) {
      esportspausetimer(var_1);
    }

    while(getdvarint("#x33897ccb203dd1dbc", 0) == 1) {
      waitframe();
    }

    setDvar("#x383e0c5b0ec26c0cf", 0);
    return 5;
  }

  return -1;
}

esportspausetimer(var_0) {
  if(!isDefined(level.isesportstimerpaused) || !level.isesportstimerpaused) {
    level.isesportstimerpaused = 1;
    level.esportstimerdiscardtime = var_0;
    scripts\mp\gamelogic::pausetimer();
  }
}

esportsresumetimer() {
  if(isDefined(level.isesportstimerpaused) && level.isesportstimerpaused) {
    level.isesportstimerpaused = 0;
    scripts\mp\gamelogic::resumetimer();
  }
}

_id_10839(var_0) {
  var_1 = var_0;

  while(var_1 > 0) {
    var_1 = var_1 - 1;
    waitframe();
  }
}