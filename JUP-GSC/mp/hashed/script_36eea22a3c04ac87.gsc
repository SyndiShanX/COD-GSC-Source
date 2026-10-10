/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_36eea22a3c04ac87.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_3390b73ac3318fe;
#using script_6f65366f542f6627;
#using script_7f9409b703dad400;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#namespace namespace_d392c741e67a9c64;

function function_b7cec7edca510b6b() {
  utility::flag_wait("ob_objectives_registered");

  if(utility::flag("unstable_rift_portal_initialized")) {
    return;
  }

  level.var_3299d293d9648d99 = [];
  level.var_a92054ea19f4dde6 = getStructArray("unstable_rift_portal", "targetname");
  level.var_47d7af4af68768cc = getdvarint(@ "hash_f75948e899e0557f", 3);
  level.var_d3b2f54fbf60a672 = getdvarint(@ "hash_607b24b853748a3", 300);
  level.var_fbe305fce9dd0c4e = getdvarint(@ "hash_9c272f94f0c1b2b5", 30);
  callback::add("obelisk_completed", &function_dd77015bf987370f);

  thread function_10bf015102ee77c8();

  if(getdvarint(@ "hash_4755982af79a423", 0)) {
    thread function_63907ede6a32277b();
  }

  utility::flag_set("unstable_rift_portal_initialized");
}

function function_352dbffd61878ee8(params) {
  player = params.player;
  oldsquadid = params.oldsquadindex;
  newsquadid = params.newsquadindex;
  oldteam = params.oldteam;
  newteam = params.newteam;

  if(!(isDefined(player) && isDefined(level.squaddata))) {
    return;
  }

  player setclientomnvar("unstable_portal", newsquadid);

  if(isDefined(level.squaddata[newteam][newsquadid]) && isDefined(level.squaddata[newteam]) && isDefined(level.squaddata[newteam][newsquadid].properties)) {
    var_bc776bad78da2fa6 = function_73792ac28beea75c(newteam, newsquadid);

    if(isDefined(var_bc776bad78da2fa6)) {
      if(isDefined(var_bc776bad78da2fa6.var_4508b5699da014a7)) {
        if(!istrue(var_bc776bad78da2fa6.var_4508b5699da014a7.var_2000b018dbdd1257)) {
          state = var_bc776bad78da2fa6.var_4508b5699da014a7 getscriptablepartstate("entrance_vfx", 1);

          if(isDefined(state)) {
            if(state == "on" || state == "on_complete") {
              var_bc776bad78da2fa6.var_4508b5699da014a7 enablescriptableplayeruse(player);
            }

            if(isDefined(var_bc776bad78da2fa6.var_4508b5699da014a7.var_13f72b3f3ada7a07)) {
              scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_bc776bad78da2fa6.var_4508b5699da014a7.var_13f72b3f3ada7a07, player);
            }
          }
        }
      }
    } else {
      var_44292203d0288c9 = level.squaddata[newteam][newsquadid];
      function_807f302767132a69(var_44292203d0288c9);
    }
  } else {
    println("<dev string:x1c>" + newsquadid);
  }

  if(isDefined(level.squaddata[oldteam][oldsquadid]) && isDefined(level.squaddata[oldteam]) && isDefined(level.squaddata[oldteam][oldsquadid].properties)) {
    var_6bd30ad0f5c29d33 = function_73792ac28beea75c(oldteam, oldsquadid);

    if(isDefined(var_6bd30ad0f5c29d33)) {
      if(isDefined(var_6bd30ad0f5c29d33.var_4508b5699da014a7)) {
        if(!istrue(var_6bd30ad0f5c29d33.var_4508b5699da014a7.var_2000b018dbdd1257)) {
          var_6bd30ad0f5c29d33.var_4508b5699da014a7 disablescriptableplayeruse(player);

          if(isDefined(var_6bd30ad0f5c29d33.var_4508b5699da014a7.var_13f72b3f3ada7a07)) {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6bd30ad0f5c29d33.var_4508b5699da014a7.var_13f72b3f3ada7a07, player);
          }
        }
      }

      return;
    }

    var_3f544337aa64eadc = level.squaddata[oldteam][oldsquadid];
    function_807f302767132a69(var_3f544337aa64eadc);
  }
}

function private function_73792ac28beea75c(playerteam, var_4b814e821394cbbb) {
  var_27961239d204205c = undefined;

  if(scripts\cp_mp\squads::function_be6ce63a202791c5(playerteam, var_4b814e821394cbbb, "unstableRiftPortal")) {
    var_27961239d204205c = scripts\cp_mp\squads::getsquaddata(playerteam, var_4b814e821394cbbb, "unstableRiftPortal");
  }

  return var_27961239d204205c;
}

function function_63907ede6a32277b() {
  level endon("game_ended");
  level utility::flag_wait("ob_infil_completed");

  foreach(var_70643c8580524236 in level.squaddata) {
    var_e89a9a6a3475bd0a = undefined;

    foreach(squad in var_70643c8580524236) {
      function_807f302767132a69(squad);
    }
  }

  callback::add("player_assimilated", &function_352dbffd61878ee8);
}

function function_807f302767132a69(squaddata) {
  if(squaddata.index < 10) {
    var_e89a9a6a3475bd0a = function_40fd49171fad19d3("jup_ob_unstable_rift_squad_portal_" + "0" + squaddata.index);
  } else {
    var_e89a9a6a3475bd0a = function_40fd49171fad19d3("jup_ob_unstable_rift_squad_portal_" + squaddata.index);
  }

  squaddata.properties["unstableRiftPortal"] = spawnStruct();
  squaddata.properties["unstableRiftPortal"].var_1e0c6a258e1768cb = var_e89a9a6a3475bd0a;
  squaddata.properties["unstableRiftPortal"].var_4508b5699da014a7 = undefined;
  squaddata.properties["unstableRiftPortal"].var_833c19ce35f0fdc0 = 0;
}

function function_dd77015bf987370f(params) {
  if(!isDefined(level.var_c5c53b345aa6ebc2)) {
    level.var_c5c53b345aa6ebc2 = 0;
  }

  if(!isDefined(level.var_cf55125362980498)) {
    level.var_cf55125362980498 = 0;
  }

  level.var_c5c53b345aa6ebc2++;
  level.var_cf55125362980498++;

  if(getdvarint(@ "hash_4755982af79a423", 0)) {
    var_65da4599fb7e7834 = [];

    if(!isDefined(params.var_7c5e1244d0e9acfa)) {
      params.var_7c5e1244d0e9acfa = [];
    }

    foreach(player in params.var_7c5e1244d0e9acfa) {
      playersquad = level.squaddata[player.team][player.sessionsquadid];
      var_65da4599fb7e7834 = function_6d6af8144a5131f1(var_65da4599fb7e7834, playersquad);
    }

    var_6151a6df2803ad78 = [];

    foreach(squad in var_65da4599fb7e7834) {
      if(isDefined(squad) && isDefined(squad.properties)) {
        if(isDefined(squad.properties["unstableRiftPortal"])) {
          squad.properties["unstableRiftPortal"].var_833c19ce35f0fdc0++;
        } else {
          function_807f302767132a69(squad);
        }

        if(squad.properties["unstableRiftPortal"].var_833c19ce35f0fdc0 >= level.var_47d7af4af68768cc) {
          squad.properties["unstableRiftPortal"].var_833c19ce35f0fdc0 = 0;
          var_6151a6df2803ad78 = function_6d6af8144a5131f1(var_6151a6df2803ad78, squad);
        }
      }
    }

    foreach(var_8322be329942d99b in var_6151a6df2803ad78) {
      function_315a51a2c55aa1f(params.obelisk, var_8322be329942d99b);
    }

    return;
  }

  if(level.var_cf55125362980498 >= level.var_47d7af4af68768cc) {
    level.var_cf55125362980498 = 0;
    function_de6cae07e4e01728(params.obelisk, params.var_7c5e1244d0e9acfa);
  }
}

function function_e79724107132683e(var_bec531bec2de2460, var_4d1875416188467e, squadindex, var_2232b9604f2bde27) {
  foreach(var_cd1b2eae3618a04d in level.players) {
    var_bec531bec2de2460 disablescriptableplayeruse(var_cd1b2eae3618a04d);
  }

  foreach(squadmate in var_4d1875416188467e) {
    if(isDefined(squadindex)) {
      squadmate setclientomnvar("unstable_portal", squadindex);
    }

    var_bec531bec2de2460 enablescriptableplayeruse(squadmate);

    if(istrue(var_2232b9604f2bde27)) {
      if(isDefined(var_bec531bec2de2460.var_13f72b3f3ada7a07)) {
        var_2a0b0c03c66902f = var_bec531bec2de2460.origin + (0, 0, 20);
        squadmate scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, var_2a0b0c03c66902f, var_bec531bec2de2460.var_13f72b3f3ada7a07);
      }

      squadmate thread hud_message::showsplash("jup_ob_unstable_rift_portal_spawned", undefined, undefined, undefined, 1, "splash_list_jup_ob");
    }
  }
}

function function_315a51a2c55aa1f(last_obelisk, squaddata) {
  s_portal = function_d96703e7edd5c880(last_obelisk);

  if(!(isDefined(squaddata) && isDefined(s_portal) && isDefined(squaddata.properties))) {
    return;
  }

  if(!isDefined(squaddata.properties["unstableRiftPortal"])) {
    function_807f302767132a69(squaddata);
  }

  level.var_a92054ea19f4dde6 = array_remove(level.var_a92054ea19f4dde6, s_portal);

  if(isDefined(squaddata.properties["unstableRiftPortal"].var_4508b5699da014a7)) {
    portal = squaddata.properties["unstableRiftPortal"].var_4508b5699da014a7;
  } else {
    portal = spawnscriptable(squaddata.properties["unstableRiftPortal"].var_1e0c6a258e1768cb, s_portal.origin, s_portal.angles);
  }

  portal.s_portal = s_portal;
  scripts\cp_mp\interaction::function_32645103f7520635(portal, &portal_used);
  function_346b846cbf6cfc50(portal, squaddata);
  function_e79724107132683e(portal, squaddata.players, squaddata.index, 1);
  portal setscriptablepartstate("entrance_vfx", "on");
  squaddata.properties["unstableRiftPortal"].var_4508b5699da014a7 = portal;
  thread overlord::playevent("unstable_rift_portal_open_opening_team", squaddata.players);
  thread function_7c68612d9cd9a45(portal, squaddata);
  portal thread function_64ffd734230070ac();

  if(!isDefined(squaddata.properties["unstableRiftPortal"].var_4508b5699da014a7)) {
    squaddata.properties["unstableRiftPortal"].var_4508b5699da014a7 = portal;
  }
}

function private function_346b846cbf6cfc50(portal, squaddata) {
  if(isDefined(portal) && isDefined(squaddata)) {
    var_13f72b3f3ada7a07 = scripts\mp\objidpoolmanager::requestobjectiveid();
    objpos = portal.origin + (0, 0, 20);

    if(isDefined(var_13f72b3f3ada7a07)) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_13f72b3f3ada7a07, "active", objpos, "difficulty_4_darkaether_icon");
      scripts\mp\objidpoolmanager::function_846c2acd91309cd8(var_13f72b3f3ada7a07, 255, 37, 37);

      if(isDefined(squaddata.players) && isarray(squaddata.players) && squaddata.players.size > 0) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_13f72b3f3ada7a07);

        foreach(squadmember in squaddata.players) {
          if(isDefined(squadmember)) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_13f72b3f3ada7a07, squadmember);
          }
        }
      }

      portal.var_13f72b3f3ada7a07 = var_13f72b3f3ada7a07;
    }
  }
}

function function_7c68612d9cd9a45(portal, var_f2880b91b6f59a) {
  level endon("game_ended");
  portal endon("portal_used");
  portal endon("death");
  n_wait = level.var_fbe305fce9dd0c4e;
  wait n_wait;

  if(isDefined(portal)) {
    portal.var_2000b018dbdd1257 = 1;

    if(isDefined(portal.var_13f72b3f3ada7a07)) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(portal.var_13f72b3f3ada7a07);
    }

    portal setscriptablepartstate("entrance_vfx", "visible_all_squads");
    var_b32fdba42bd8e094 = [];

    foreach(player in level.players) {
      if(player.sessionsquadid != var_f2880b91b6f59a.index) {
        if(isDefined(portal.var_13f72b3f3ada7a07)) {
          var_2a0b0c03c66902f = portal.origin + (0, 0, 20);
          player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, var_2a0b0c03c66902f, portal.var_13f72b3f3ada7a07);
        }

        player thread hud_message::showsplash("jup_ob_unstable_rift_portal_spawned", undefined, undefined, undefined, 1, "splash_list_jup_ob");
        var_b32fdba42bd8e094[var_b32fdba42bd8e094.size] = player;
      }

      portal enablescriptableplayeruse(player);
    }

    thread overlord::playevent("unstable_rift_portal_open_other_teams", var_b32fdba42bd8e094);
  }
}

function function_de6cae07e4e01728(last_obelisk, var_7c5e1244d0e9acfa) {
  s_portal = function_d96703e7edd5c880(last_obelisk);

  if(!isDefined(s_portal)) {
    return;
  }

  level.var_a92054ea19f4dde6 = array_remove(level.var_a92054ea19f4dde6, s_portal);
  portal = spawnscriptable(%"hash_4b1a475882042d49", s_portal.origin, s_portal.angles);
  portal.s_portal = s_portal;
  level.var_3299d293d9648d99[level.var_3299d293d9648d99.size] = portal;
  scripts\cp_mp\interaction::function_32645103f7520635(portal, &portal_used);
  portal setscriptablepartstate("entrance_vfx", "on");
  a_valid_players = [];

  if(!isDefined(var_7c5e1244d0e9acfa)) {
    var_7c5e1244d0e9acfa = [];
  }

  foreach(player in var_7c5e1244d0e9acfa) {
    a_squad = player getsquadmembers(undefined, 0);

    foreach(squad_player in a_squad) {
      a_valid_players = function_6d6af8144a5131f1(a_valid_players, squad_player);
    }
  }

  foreach(player in a_valid_players) {
    player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(18, portal.origin, portal.index);
    player thread hud_message::showsplash("jup_ob_unstable_rift_portal_spawned", undefined, undefined, undefined, 1, "splash_list_jup_ob");
  }

  thread overlord::playevent("unstable_rift_portal_open_opening_team", a_valid_players);
  thread function_dca9bb8b801c62cf(a_valid_players, portal);
  portal thread function_64ffd734230070ac();
}

function function_dca9bb8b801c62cf(a_valid_players, portal) {
  level endon("game_ended");
  portal endon("portal_used");
  portal endon("death");
  n_wait = level.var_fbe305fce9dd0c4e;
  wait n_wait;

  if(isDefined(portal)) {
    var_b32fdba42bd8e094 = [];

    foreach(player in level.players) {
      if(!arraycontains(a_valid_players, player)) {
        player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(18, portal.origin, portal.index);
        player thread hud_message::showsplash("jup_ob_unstable_rift_portal_spawned", undefined, undefined, undefined, 1, "splash_list_jup_ob");
        var_b32fdba42bd8e094[var_b32fdba42bd8e094.size] = player;
      }
    }

    thread overlord::playevent("unstable_rift_portal_open_other_teams", var_b32fdba42bd8e094);
  }
}

function function_d96703e7edd5c880(last_obelisk) {
  if(level.var_a92054ea19f4dde6.size <= 0) {
    return undefined;
  }

  level.var_a92054ea19f4dde6 = sortbydistance(level.var_a92054ea19f4dde6, last_obelisk.origin);
  s_portal = level.var_a92054ea19f4dde6[0];
  return s_portal;
}

function function_64ffd734230070ac() {
  self endon("death");
  wait level.var_d3b2f54fbf60a672;

  if(!isDefined(self) || istrue(self.var_18c9cb5bab048538)) {
    return;
  }

  thread overlord::playevent("unstable_rift_portal_close_timeout", level.players);
  self.timed_out = 1;
  destroy_portal(self);
}

function private destroy_portal(portal) {
  level endon("game_ended");

  if(!isDefined(portal)) {
    return;
  }

  var_3f648f04669ec32d = "closing";

  if(getdvarint(@ "hash_4755982af79a423", 0) && istrue(portal.var_2000b018dbdd1257)) {
    var_3f648f04669ec32d = "closing_all_squads";
  }

  portal setscriptablepartstate("entrance_vfx", var_3f648f04669ec32d);

  if(isDefined(portal.var_13f72b3f3ada7a07)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(portal.var_13f72b3f3ada7a07);
    scripts\mp\objidpoolmanager::returnobjectiveid(portal.var_13f72b3f3ada7a07);
  }

  wait 3;
  level.var_3299d293d9648d99 = array_remove(level.var_3299d293d9648d99, portal);
  level.var_a92054ea19f4dde6 = function_6d6af8144a5131f1(level.var_a92054ea19f4dde6, portal.s_portal);
  portal freescriptable();
  portal notify("death");
}

function portal_used(player) {
  if(!(isDefined(player.team) && isDefined(player) && isDefined(player.sessionsquadid))) {
    return;
  }

  var_9ca4ec4b55d55b88 = player.team;
  var_19cd1c635198bd2b = player.sessionsquadid;
  var_5d38232b8838ff8b = getsquadmembersbyid(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b, 0);

  foreach(var_3329887886bd6a4b in var_5d38232b8838ff8b) {
    var_3329887886bd6a4b setclientomnvar("ui_ob_unstable_rift_vote", 1);
    self disableplayeruse(var_3329887886bd6a4b);
  }

  self setscriptablepartstate("usable_state", "unusable");
  var_8e3e3673432e9a12 = namespace_6c57c664b4288f88::function_93c8f90c3bd798c6(player, 30, undefined);
  var_5d38232b8838ff8b = getsquadmembersbyid(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b, 0);

  foreach(var_3329887886bd6a4b in var_5d38232b8838ff8b) {
    var_3329887886bd6a4b setclientomnvar("ui_ob_unstable_rift_vote", 0);
  }

  if(!isDefined(self) || istrue(self.timed_out)) {
    return;
  }

  var_5d38232b8838ff8b = getsquadmembersbyid(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b, 0);

  foreach(var_3329887886bd6a4b in var_5d38232b8838ff8b) {
    self enableplayeruse(var_3329887886bd6a4b);
  }

  if(istrue(var_8e3e3673432e9a12)) {
    self.var_18c9cb5bab048538 = 1;
    level thread function_a629ae912e5ea368(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b);
    level thread function_3dece423c8f443c9(self, var_9ca4ec4b55d55b88, var_19cd1c635198bd2b);
    return;
  }

  self setscriptablepartstate("usable_state", "usable");
}

function function_3dece423c8f443c9(portal, var_9ca4ec4b55d55b88, var_19cd1c635198bd2b) {
  portal notify("portal_used");
  portal setscriptablepartstate("usable_state", "unusable");
  wait 10;
  entering_players = getsquadmembersbyid(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b, 1);

  if(entering_players.size > 0) {
    var_fa976459b24e975f = utility::array_remove_array(level.players, entering_players);
    utility::delaythread(3, &overlord::playevent, "unstable_rift_portal_close_squad_entered", var_fa976459b24e975f);
  }

  destroy_portal(portal);
}

function function_a629ae912e5ea368(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b) {
  a_squad = getsquadmembersbyid(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b, 1);
  n_time_limit = 10;
  timer = namespace_26c5a699d7cb84a2::function_3eec8a169e8a0936(n_time_limit);
  waitframe();

  while(timer.progresscomplete != 1) {
    n_time_remaining = int(timer.var_621cb2c0d9b1cdae);

    foreach(squaddie in a_squad) {
      squaddie setclientomnvar("ui_is_exfil_countdown", 1);
      squaddie setclientomnvar("ui_match_start_countdown", n_time_remaining);
    }

    wait 0.5;
  }

  a_squad = getsquadmembersbyid(var_9ca4ec4b55d55b88, var_19cd1c635198bd2b, 1);

  foreach(player in a_squad) {
    player scripts\common\values::set("rift_gate_teleport", "ignoreme", 1);
    player scripts\common\values::set("rift_gate_teleport", "damage", 0);
    player scripts\common\values::set("rift_gate_teleport", "fire", 0);
    player playerhide();
    player thread namespace_cc781f142d33c074::function_2241b80779e319a0();
  }

  wait 5;
  namespace_cddd3ad399b210ff::function_e229d89e0c38206d(a_squad, 1016);
}

function function_10bf015102ee77c8() {
  level endon("<dev string:x85>");
  wait 5;
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x93>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xc4>", "<dev string:xdd>", &function_6a4bb8a62f619584, 1);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xfc>", "<dev string:x11a>", &function_9c5c4acc471ac380, 1);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x13e>", "<dev string:x162>", &function_cea3d1d8853780c7, 1);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x18c>", "<dev string:x1a5>", &function_a2b8e3e26381cbc5, 1);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x1c3>", "<dev string:x1f0>", &debug_announcement);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x22d>", "<dev string:x259>", &debug_announcement);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x295>", "<dev string:x2c4>", &debug_announcement);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x303>", "<dev string:x32c>", &debug_announcement);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_6a4bb8a62f619584(params) {
  s_params = spawnStruct();
  s_params.obelisk = level.players[0];
  callback("<dev string:x365>", s_params);
}

function function_9c5c4acc471ac380(params) {
  function_de6cae07e4e01728(level.players[0]);
}

function function_cea3d1d8853780c7(params) {
  playersquad = level.squaddata[level.players[0].team][level.players[0].sessionsquadid];
  function_315a51a2c55aa1f(level.players[0], playersquad);
}

function function_a2b8e3e26381cbc5() {
  while(true) {
    foreach(portal in level.var_a92054ea19f4dde6) {
      sphere(portal.origin, 500, (1, 0, 0), 0, int(1 / level.framedurationseconds) + 1);
    }

    wait 1;
  }
}

function debug_announcement(params) {
  switch (params[0]) {
    case #"hash_884a3ea31b587282":
      thread overlord::playevent("<dev string:x38f>", level.players);
      break;
    case #"hash_a415c6b118258795":
      thread overlord::playevent("<dev string:x3cd>", level.players);
      break;
    case #"hash_f5e8be1ceff41f16":
      thread overlord::playevent("<dev string:x40d>", level.players);
      break;
    case #"hash_bf91fb35faa9902f":
      thread overlord::playevent("<dev string:x44a>", level.players);
      break;
  }
}

# /