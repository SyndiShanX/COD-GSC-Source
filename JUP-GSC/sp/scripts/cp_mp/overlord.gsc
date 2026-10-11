/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\overlord.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace overlord;

function init() {
  if(!function_1ad4a4e87bd92ba8()) {
    return;
  }

  level.overlord = spawnStruct();
  level.overlord.events = [];
  level.overlord.conversations = [];
  level.setoverlordlockedpriority = &setoverlordlockedpriority;
  level thread function_2b7b925f1037e020();
  level.overlord.var_f122d73bb796754c = getdvarint(@ "hash_99ee36f514cfdc16", 3);

  if(getdvarint(@ "hash_b1dbb741da6aa657", 0) == 1) {
    level thread testqueue();
  }

  if(getdvarint(@ "hash_859fb74d1557c0b1", 1) && utility::ismp()) {
    level thread function_b0c21eabffce3fd4();
  }
}

function function_1ad4a4e87bd92ba8() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_21499b682c5b3a47)) {
    return true;
  }

  if(utility::ismp()) {
    if(getDvar(@ "hash_7611a2790a0bf7fe", "") != "dmz") {
      return false;
    }
  }

  return true;
}

function function_2b7b925f1037e020() {
  csv = function_6c9808b9b419ed7e();
  scripts\mp\flags::levelflaginit("overlord_csv_init", 0);

  for(row = 0; true; row++) {
    ref = tablelookupbyrow(csv, row, 0);

    if(ref == "") {
      break;
    }

    alias = tablelookupbyrow(csv, row, 1);
    priority = int(tablelookupbyrow(csv, row, 2));
    cooldown = int(tablelookupbyrow(csv, row, 3));
    timeout = lookupsoundlength(alias, 1) / 1000 + 2;
    registerevent(ref, alias, priority, cooldown, timeout);
  }

  str_bundle = function_867b48f5536f373e();

  if(isDefined(str_bundle)) {
    s_bundle = getscriptbundle("dialogueoverlord:" + str_bundle);

    if(isDefined(s_bundle)) {
      foreach(var_87fc95d97eb08ba9 in s_bundle.var_423f1766afe848b9) {
        if(isDefined(var_87fc95d97eb08ba9.alias)) {
          timeout = lookupsoundlength(var_87fc95d97eb08ba9.alias, 1) / 1000 + 2;
          registerevent(var_87fc95d97eb08ba9.ref, var_87fc95d97eb08ba9.alias, var_87fc95d97eb08ba9.priority, var_87fc95d97eb08ba9.cooldown, timeout, var_87fc95d97eb08ba9.speakerasset, var_87fc95d97eb08ba9.delaybefore, var_87fc95d97eb08ba9.delayafter);
        }
      }

      foreach(s_conversation in s_bundle.conversations) {
        level.overlord.conversations[s_conversation.conversationname] = s_conversation;

        foreach(var_84e41716d3779c0e in s_conversation.soundevents) {
          if(isDefined(var_84e41716d3779c0e.alias)) {
            eventref = default_to(var_84e41716d3779c0e.ref, var_84e41716d3779c0e.alias);

            if(!isDefined(level.overlord.events[eventref])) {
              registerevent(eventref, var_84e41716d3779c0e.alias, var_84e41716d3779c0e.priority, var_84e41716d3779c0e.cooldown, function_c89ed1840c8d0f0f(lookupsoundlength(var_84e41716d3779c0e.alias, 1)), var_84e41716d3779c0e.speakerasset, var_84e41716d3779c0e.delaybefore, var_84e41716d3779c0e.delayafter);
            }
          }
        }
      }
    }
  }

  scripts\mp\flags::levelflagset("overlord_csv_init");
}

function function_6c9808b9b419ed7e() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_21499b682c5b3a47)) {
    if(isDefined(level.gamemodebundle.var_4def6c2024945408)) {
      return level.gamemodebundle.var_4def6c2024945408;
    } else if(!isDefined(function_867b48f5536f373e())) {
      assertmsg("overlord::getOverlordCSV: gameModeBundle or level.str_overlord_event_bundle override missing definition for 'Overlord Events', using '" + "mp_cp/overlord_dmz.csv" + "' as a default.");
      return "mp_cp/overlord_dmz.csv";
    }
  }

  return getDvar(@ "hash_97efde55df4bcccd", "mp_cp/overlord_dmz.csv");
}

function function_867b48f5536f373e() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_21499b682c5b3a47)) {
    return default_to(level.var_af35f8ccfc5f7a70, level.gamemodebundle.var_74ff2a0df7caa848);
  }
}

function testqueue() {
  scripts\mp\flags::levelflagwait("overlord_csv_init");

  while(true) {
    scripts\cp_mp\overlord::playevent("player_civ_kill_third_warning", [level.players[0]]);
    wait 1;
    scripts\cp_mp\overlord::playevent("player_civ_kill_frst_warning", [level.players[0]]);
    wait 1;
    scripts\cp_mp\overlord::playevent("player_civ_kill_second_warning", [level.players[0]]);
    wait 5;
  }
}

function registerevent(ref, alias, priority, cooldown, timeout, speakerasset, delaybefore, delayafter) {
  event = spawnStruct();
  event.ref = ref;
  event.alias = alias;
  event.priority = isDefined(priority) ? priority : 75;
  event.cooldown = cooldown * 1000;
  event.timeout = timeout;
  event.speakerasset = speakerasset;
  event.delaybefore = delaybefore;
  event.delayafter = delayafter;
  level.overlord.events[ref] = event;
}

function function_9b411de07c46bddc(eventref, players, includedeadplayers, var_f84decb7822f8442) {
  if(!isDefined(level.overlord)) {
    return 0;
  }

  if(!isDefined(eventref) || !isDefined(var_f84decb7822f8442)) {
    return 0;
  }

  event = level.overlord.events[eventref];

  if(!isDefined(event)) {
    return 0;
  }

  if(!isDefined(event.playhistory)) {
    event.playhistory = [];
  }

  if(istrue(event.playhistory[var_f84decb7822f8442])) {
    return 0;
  }

  eventplayed = playevent(eventref, players, 0, includedeadplayers, 0);

  if(istrue(eventplayed)) {
    event.playhistory[var_f84decb7822f8442] = 1;
  }
}

function playevent(eventref, players, delay, includedeadplayers, var_fe8102d7751b9184) {
  if(!isDefined(level.overlord)) {
    return false;
  }

  if(isDefined(delay)) {
    wait delay;
  }

  event = level.overlord.events[eventref];

  if(!isDefined(event)) {
    return false;
  }

  if(!soundexists(event.alias)) {
    return false;
  }

  if(isDefined(event.delaybefore) && event.delaybefore > 0) {
    wait event.delaybefore;
  }

  foreach(player in players) {
    if(!isalive(player) && !istrue(includedeadplayers)) {
      continue;
    }

    player function_d453707f6b8f2c6d();

    if(!player function_8c3011dccace47c4(eventref)) {
      continue;
    }

    interruptcurrent = player shouldinterrupt(event);
    var_6313cac4d3f01dab = event.timeout;

    if(!interruptcurrent) {
      foreach(n_start_time in player.var_5a2916f745d4389a) {
        var_6313cac4d3f01dab += level.overlord.events[var_f1ded4f36c028507].timeout;
      }
    }

    player queuedialogforplayer(event.alias, event.alias, var_6313cac4d3f01dab, "overlord", interruptcurrent, undefined, event.timeout);
    player.var_5a2916f745d4389a[eventref] = gettime();

    if(isDefined(event.speakerasset)) {
      player val::set(event.alias, "overlord_speaker", event.speakerasset);
      player delaythreadendon(event.timeout, ["disconnect"], &val::reset, event.alias, "overlord_speaker");
    }
  }

  if(istrue(var_fe8102d7751b9184) && isDefined(event.timeout)) {
    wait event.timeout;
  }

  if(isDefined(event.delayafter) && event.delayafter > 0) {
    wait event.delayafter;
  }

  return true;
}

function playconversation(conversationname, players, var_7b76e64b846c00d, var_8b6798cc35c82e07, location, group) {
  players = default_to(players, level.players);
  var_8b6798cc35c82e07 = default_to(var_8b6798cc35c82e07, 1);
  group = default_to(group, "overlord_conversation");

  if(isDefined(var_7b76e64b846c00d)) {
    wait var_7b76e64b846c00d;
  }

  s_conversation = level.overlord.conversations[conversationname];

  if(isDefined(s_conversation)) {
    foreach(var_84e41716d3779c0e in s_conversation.soundevents) {
      if(isDefined(var_84e41716d3779c0e.alias)) {
        eventref = default_to(var_84e41716d3779c0e.ref, var_84e41716d3779c0e.alias);

        if(!isDefined(level.overlord.events[eventref])) {
          registerevent(eventref, var_84e41716d3779c0e.alias, var_84e41716d3779c0e.priority, var_84e41716d3779c0e.cooldown, function_c89ed1840c8d0f0f(lookupsoundlength(var_84e41716d3779c0e.alias, 1)), var_84e41716d3779c0e.speakerasset, var_84e41716d3779c0e.delaybefore, var_84e41716d3779c0e.delayafter);
        }

        if(isDefined(var_84e41716d3779c0e.delaybefore)) {
          wait var_84e41716d3779c0e.delaybefore;
        }

        n_wait = level.overlord.events[eventref].timeout;

        if(group != "overlord_intel") {
          foreach(player in players) {
            if(isalive(player)) {
              player function_d453707f6b8f2c6d();

              if(!player function_8c3011dccace47c4(eventref)) {
                continue;
              }

              if(isDefined(var_84e41716d3779c0e.speakerasset)) {
                player val::set(level.overlord.events[eventref].alias, "overlord_speaker", level.overlord.events[eventref].speakerasset);
                player delaythreadendon(level.overlord.events[eventref].timeout, ["disconnect"], &val::reset, level.overlord.events[eventref].alias, "overlord_speaker");
              }

              interruptcurrent = player shouldinterrupt(level.overlord.events[eventref]) || var_8b6798cc35c82e07;
              var_6313cac4d3f01dab = level.overlord.events[eventref].timeout;

              if(!interruptcurrent) {
                foreach(n_start_time in player.var_5a2916f745d4389a) {
                  var_6313cac4d3f01dab += level.overlord.events[var_f1ded4f36c028507].timeout;
                }
              }

              player queuedialogforplayer(var_84e41716d3779c0e.alias, var_84e41716d3779c0e.alias, var_6313cac4d3f01dab, group, var_8b6798cc35c82e07, location, level.overlord.events[eventref].timeout);
              player.var_5a2916f745d4389a[eventref] = gettime();
            }
          }
        } else if(isDefined(location)) {
          playsoundatpos(location, var_84e41716d3779c0e.alias);
        }

        wait n_wait;

        if(isDefined(var_84e41716d3779c0e.delayafter)) {
          wait var_84e41716d3779c0e.delayafter;
        }
      }
    }
  }
}

function private function_b0920556607fb961(var_cf8b5ceaf91df155) {
  if(isDefined(level.var_237eaf521a80c304) && isDefined(var_cf8b5ceaf91df155) && var_cf8b5ceaf91df155 != "") {
    self[[level.var_237eaf521a80c304]](var_cf8b5ceaf91df155);
  }
}

function private function_53af491c63c9d78e() {
  if(isDefined(level.var_673320093d434d55)) {
    self[[level.var_673320093d434d55]]();
  }
}

function function_9793a81bc3bc19e9(eventref, team, delay) {
  if(isDefined(delay)) {
    wait delay;
  }

  players = level.players;

  if(isDefined(team)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "getTeamData")) {
      players = [[scripts\engine\utility::getsharedfunc("game", "getTeamData")]](team, "players");
    }
  }

  playevent(eventref, players);
}

function function_8c3011dccace47c4(eventref) {
  if(isDefined(self.overlordlockedpriority) && level.overlord.events[eventref].priority < self.overlordlockedpriority) {
    return false;
  }

  return !scripts\engine\utility::array_contains_key(self.var_5a2916f745d4389a, eventref);
}

function function_d453707f6b8f2c6d() {
  if(!isDefined(self.var_5a2916f745d4389a)) {
    self.var_5a2916f745d4389a = [];
    return;
  }

  var_8685876230b8771d = [];
  currenttime = gettime();

  foreach(eventref, n_start_time in self.var_5a2916f745d4389a) {
    if(!isDefined(level.overlord.events[eventref])) {
      continue;
    }

    var_d2154b40b980d7d6 = n_start_time + function_a5b14435e3229bed(level.overlord.events[eventref].timeout) + level.overlord.events[eventref].cooldown;

    if(var_d2154b40b980d7d6 < currenttime) {
      var_8685876230b8771d[eventref] = n_start_time;
    }
  }

  foreach(eventref, n_start_time in var_8685876230b8771d) {
    self.var_5a2916f745d4389a[eventref] = undefined;
  }
}

function function_50ebf0029301be3f(player, eventref) {
  if(!isDefined(player.var_5a2916f745d4389a)) {
    return false;
  }

  if(!isDefined(player.var_5a2916f745d4389a[eventref])) {
    return false;
  }

  if(!isDefined(level.overlord.events[eventref])) {
    return false;
  }

  if(!isDefined(level.overlord.events[eventref].cooldown)) {
    return false;
  }

  lasttime = player.var_5a2916f745d4389a[eventref];
  cooldowntime = level.overlord.events[eventref].cooldown;
  currenttime = gettime();
  return lasttime + cooldowntime >= currenttime;
}

function shouldinterrupt(event) {
  foreach(n_start_time in self.var_5a2916f745d4389a) {
    if(event.priority <= level.overlord.events[eventref].priority) {
      return false;
    }
  }

  return true;
}

function private function_4831c2aa1655ce23(player) {
  var_d90809392748e640 = player namespace_2b1145f62aa835b8::hasperksharedfunc("specialty_pc_stealth");
  return !istrue(var_d90809392748e640);
}

function private isvalidplayer(player) {
  additionalchecks = 1;

  if(isDefined(level.var_76eba5facacd254b) && isfunction(level.var_76eba5facacd254b)) {
    additionalchecks = [[level.var_76eba5facacd254b]](player);
  }

  return isDefined(player) && isDefined(player.team) && isDefined(player.origin) && isalive(player) && !isDefined(player.fauxdead) && !istrue(player.delayedspawnedplayernotify) && istrue(additionalchecks);
}

function function_b0c21eabffce3fd4() {
  proximitydistancesq = getdvarint(@ "scr_overlord_enemy_proximity_radius", 4096);
  proximitydistancesq *= proximitydistancesq;
  ignoretime = getdvarfloat(@ "hash_32244d6acf101808", 60);
  trackedteams = [];

  foreach(team in level.teamnamelist) {
    trackedteams[team] = [];
  }

  while(true) {
    validplayers = [];

    foreach(player in level.players) {
      if(isvalidplayer(player)) {
        validplayers[validplayers.size] = player;
      }
    }

    partition = create_partition(validplayers, 2500);

    foreach(player in validplayers) {
      if(!isvalidplayer(player)) {
        continue;
      }

      foreach(playerarray in partition function_df633f460888a47(player.origin)) {
        foreach(testplayer in playerarray) {
          if(!isvalidplayer(testplayer) || !function_4831c2aa1655ce23(testplayer)) {
            continue;
          }

          if(player.team == testplayer.team || distancesquared(player.origin, testplayer.origin) > proximitydistancesq) {
            continue;
          }

          var_ba24b605d8b9c100 = function_f240c299b9341e8f(player, testplayer, trackedteams, ignoretime);

          if(var_ba24b605d8b9c100) {
            testplayers = namespace_2b1145f62aa835b8::getteamdatasharedfunc(testplayer.team, "players");
            eventplayers = namespace_2b1145f62aa835b8::getteamdatasharedfunc(player.team, "players");
            var_571aeaf27dbb7e22 = [];

            foreach(player in eventplayers) {
              if(getdvarint(@ "hash_c53afaea3f55391a", 0) && player namespace_2b1145f62aa835b8::hasperksharedfunc("specialty_pc_comms")) {
                continue;
              }

              var_571aeaf27dbb7e22[var_571aeaf27dbb7e22.size] = player;
            }

            playevent(ter_op(testplayers.size > level.overlord.var_f122d73bb796754c, "nearby_big_team", "player_enemy_player_nearby"), var_571aeaf27dbb7e22);
            trackedteams[player.team][testplayer.team] = gettime();
          }
        }
      }

      waitframe();
    }

    wait 3;
  }
}

function function_aea00c3815b226da(player) {
  player notify("monitor_enemy_prox");
  player endon("disconnect");
  player endon("death");
  level endon("game_ended");
  player endon("monitor_enemy_prox");
  proximitydistancesq = getdvarint(@ "scr_overlord_enemy_proximity_radius", 4096);
  proximitydistancesq *= proximitydistancesq;
  ignoretime = getdvarfloat(@ "hash_32244d6acf101808", 60);
  trackedteams = [];

  foreach(team in level.teamnamelist) {
    trackedteams[team] = [];
  }

  while(true) {
    validplayers = [];

    foreach(validplayer in level.players) {
      if(isvalidplayer(validplayer)) {
        validplayers[validplayers.size] = validplayer;
      }
    }

    partition = create_partition(validplayers, 2500);

    foreach(playerarray in partition function_df633f460888a47(player.origin)) {
      foreach(testplayer in playerarray) {
        if(!isvalidplayer(testplayer) || !function_4831c2aa1655ce23(testplayer)) {
          continue;
        }

        if(player.team == testplayer.team || distancesquared(player.origin, testplayer.origin) > proximitydistancesq) {
          continue;
        }

        var_ba24b605d8b9c100 = !isDefined(trackedteams[player.team][testplayer.team]) || (gettime() - trackedteams[player.team][testplayer.team]) / 1000 > ignoretime;

        if(var_ba24b605d8b9c100) {
          testplayers = namespace_53fc9ddbb516e6e1::getteamdatasharedfunc(testplayer.team, "players");
          playevent(ter_op(testplayers.size > level.overlord.var_f122d73bb796754c, "nearby_big_team", "player_enemy_player_nearby"), [player]);
          trackedteams[player.team][testplayer.team] = gettime();
        }
      }
    }

    wait 3;
  }
}

function setoverlordlockedpriority(val) {
  self.overlordlockedpriority = val;
}

function function_2c722a2ef9574e87(players, tag, priority) {
  foreach(player in players) {
    player val::set(tag, "overlord_locked_priority", priority);
  }
}

function function_70979c1eabf04180(players, tag) {
  foreach(player in players) {
    player val::reset(tag, "overlord_locked_priority");
  }
}

function function_f240c299b9341e8f(player, testplayer, trackedteams, ignoretime) {
  var_ba24b605d8b9c100 = !isDefined(trackedteams[player.team][testplayer.team]) || (gettime() - trackedteams[player.team][testplayer.team]) / 1000 > ignoretime;

  if(getdvarint(@ "hash_c53afaea3f55391a", 0)) {
    testplayers = namespace_2b1145f62aa835b8::getteamdatasharedfunc(testplayer.team, "players");
    return (var_ba24b605d8b9c100 && testplayers.size > level.overlord.var_f122d73bb796754c);
  }

  return var_ba24b605d8b9c100;
}