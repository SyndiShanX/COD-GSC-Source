/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_spectate.gsc
************************************************/

function spectate_init() {
  thread updateactivespectatorcounts();
}

function initplayer() {
  ref_1252a();
}

function regive_killstreak_after_use(var0, var1) {
  var2 = undefined;

  if(isDefined(var0.ref_11e80)) {
    var2 = reset_use_puzzle_effects(var0.ref_11e80);
    var0.ref_11e80 = undefined;
  }

  if(!isDefined(var2)) {
    var2 = var0 scripts\mp\gametypes\br_gulag::ref_12568(undefined, undefined, 1);
  }

  if(!isDefined(var2)) {
    var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);
    var2 = registeruniquelootcallback(var0, var3);
  }

  if(!isDefined(var2) && scripts\mp\menus::ref_13733()) {
    var3 = scripts\mp\utility\teams::getteamdata(var0.team, "players");
    var2 = registeruniquelootcallback(var0, var3);
  }

  if(!isDefined(var2)) {
    if(isDefined(var1) && isPlayer(var1) && var1.team != var0.team) {
      if(isalive(var1) && !istrue(var1.gulag) && !istrue(var1.inlaststand) && !var1 scripts\mp\gametypes\br_public::ref_125f3()) {
        var2 = var1;
      } else {
        var4 = scripts\mp\utility\teams::getfriendlyplayers(var1.team);
        var2 = registeruniquelootcallback(var0, var4, 1);
      }
    }
  }

  if(!isDefined(var2) && isPlayer(var1) && var1 != var0) {
    var2 = reset_use_puzzle_effects(var1);

    if(isDefined(var2) && var2 scripts\mp\gametypes\br_public::ref_125f3()) {
      var2 = undefined;
    }
  }

  if(!isDefined(var2)) {
    var2 = registeruniquelootcallback(var0, level.players);
  }

  if(!isDefined(var2) && level.players.size > 1 && !istrue(level.gameended) && !istrue(level.‚kò·° F© ÝÇ - wá3Åû¸ "N|¸”%CÁPÙŠÅ ) ) {
      var5 = 0;

      foreach(var7 in level.players) {
        if(istrue(var7.delay_enter_combat_after_investigating_grenade)) {
          var5++;
        }
      }

      scripts\mp\utility\script::laststand_dogtags("getBestSpectateCandidate - no valid players found (" + var5 + " of " + level.players.size + ") eliminated");
    }

    return var2;
  }

  function issubgametype(var0, var1, var2) {
    var3 = "player: " + var0.name + ", candidate: " + var1.name + ", playersChecked.size: " + var2.size;
    scripts\mp\utility\script::laststand_dogtags(var3);
    var3 = "";
    var4 = int(min(var2.size, 3));
    var5 = 0;

    foreach(var7 in var2) {
      var3 += " - player: " + var7.name + ", eliminated: " + istrue(var7.delay_enter_combat_after_investigating_grenade);
      var5++;

      if(var5 > var4) {
        break;
      }
    }

    scripts\mp\utility\script::laststand_dogtags(var3);
  }

  function reset_use_puzzle_effects(var0) {
    var1 = [];
    var2 = 0;

    for(var3 = var0; isDefined(var3) && !vandalize_target_think(var3); var3 = ref_12580(var3)) {
      var2++;
      var4 = var3 getentitynumber();

      if(var2 >= 150 || isDefined(var1[var4])) {
        issubgametype(var0, var3, var1);
        return;
      }

      var1 = var3;
    }

    return var3;
  }

  function registeruniquelootcallback(var0, var1, var2) {
    var3 = undefined;
    var4 = [];
    var5 = [];
    var6 = [];
    var7 = [];

    foreach(var9 in var1) {
      if(!isDefined(var9) || !vandalize_target_think(var9) || var9 == var0) {
        continue;
      }

      if(istrue(var9.gulag)) {
        var5 = var9;
        continue;
      }

      if(istrue(var9.inlaststand)) {
        var6 = var9;
        continue;
      }

      if(var9 scripts\mp\gametypes\br_public::ref_125f3()) {
        var7 = var9;
        continue;
      }

      var4 = var9;
    }

    if(var4.size > 0) {
      var11 = randomint(var4.size);
      var3 = var4[var11];
    }

    if(!isDefined(var3) && var5.size > 0) {
      var11 = randomint(var5.size);
      var3 = var5[var11];
    }

    if(!isDefined(var3) && var6.size > 0) {
      var11 = randomint(var6.size);
      var3 = var6[var11];
    }

    if(!isDefined(var3) && var7.size > 0 && !istrue(var2)) {
      var11 = randomint(var7.size);
      var3 = var7[var11];
    }

    return var3;
  }

  function vandalize_target_think(var0) {
    if(!isDefined(var0)) {
      return 0;
    }

    if(istrue(scripts\mp\gametypes\br_gametypes::tutorial_showtext("isValidSpectateTarget"))) {
      return scripts\mp\gametypes\br_gametypes::ref_12e05("isValidSpectateTarget", var0);
    }

    if(!isalive(var0) && !istrue(var0.respawningfromtoken) && (istrue(var0.gulagarena) || !istrue(var0.gulag))) {
      return 0;
    }

    return !istrue(var0.delay_enter_combat_after_investigating_grenade);
  }

  function ref_13668(var0) {
    var1 = spawnStruct();

    if(istrue(level.ref_14603) && level.ref_14603 == 6 && getdvarint("scr_br_x1_intermission_location_enabled", 1)) {
      var1.origin = getdvarvector("scr_br_x1_intermission_origin", (29247, 1991, 6334));
      var1.angles = getdvarvector("scr_br_x1_intermission_angles", (85, 135, 0));
    } else if(isDefined(level.ref_12d05) && level.ref_12d05 == 2 && getdvarint("scr_br_dov1_intermission_location_enabled", 1)) {
      var1.origin = getdvarvector("scr_br_dov1_intermission_origin", (29247, 1991, 6334));
      var1.angles = getdvarvector("scr_br_dov1_intermission_angles", (85, 135, 0));
    } else if(isDefined(var0.ref_136dc)) {
      var1 = var0.ref_136dc;
      var0.ref_136dc = undefined;
    } else {
      var1.origin = var0.origin + (0, 0, 100);
      var1.angles = var0.angles;
    }

    scripts\mp\playerlogic::spawnintermission(var1, undefined, 0);
  }

  function spawnspectator(var0, var1, var2) {
    if(scripts\mp\gametypes\br_public::validtousesticker()) {
      return;
    }

    var3 = self;
    ref_13668(var3, var3);

    if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
      return;
    }

    thread scripts\mp\gametypes\br_gulag::ref_126aa();

    if(!istrue(var2)) {
      thread ref_13dc2();
    }

    var4 = undefined;

    if(isDefined(var0.attacker)) {
      var4 = var0.attacker;
    }

    var5 = regive_killstreak_after_use(var3, var4);

    if(isDefined(var5) || !istrue(level.‚kò·° F© ÝÇ - wá3Åû¸ "N|¸”%CÁPÙŠÅ ) ) {
        assignspectatortospectateplayer(var3, var5);
      }

      if(!istrue(var3.br_spectatorinitialized)) {
        var3 notify("br_spectatorInitialized");
        var3.br_spectatorinitialized = 1;
        return;
      }
    }

    function ref_13dc2() {
      self endon("disconnect");
      self endon("br_team_fully_eliminated");
      var0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

      if(var0.size > 0) {
        var1 = 1;

        switch (scripts\mp\utility\game::round_vehicle_logic()) {
          case "gold_war":
          case "risk":
          case "rat_race":
          case "dmz":
          case "rumble":
            var1 = 0;
            break;
          case "truckwar":
            var1 = !isDefined(level.ref_13ace) || !isDefined(level.ref_13ace[self.team]);
            break;
        }

        if(var1) {
          thread ref_13132();
          wait 0.25;
          self setclientomnvar("ui_br_end_game_splash_type", 5);
          wait 1;
          self setclientomnvar("ui_br_end_game_splash_type", 0);
          return;
        }

        return;
      }
    }

    function ref_125c9() {
      var0 = 0;
      var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

      foreach(var3 in var1) {
        if(isDefined(var3) && self != var3 && isalive(var3) && !var3 scripts\mp\gametypes\br_public::ref_125f3()) {
          var0 = 1;
          break;
        }
      }

      return var0;
    }

    function ref_13132() {
      self endon("disconnect");
      self endon("br_team_fully_eliminated");
      self endon("started_spawnPlayer");
      self endon("gulag_auto_win");

      if(!istrue(level.br_plunder_enabled)) {
        return;
      }

      var0 = istrue(getdvarint("scr_br_resurgence_respawn_enable", 0)) && level.disable_super_in_turret.ref_12ca4;

      if(scripts\mp\utility\game::getgametype() != "dmz" && scripts\mp\utility\game::getgametype() != "rat_race" && scripts\mp\utility\game::getgametype() != "gold_war" && !var0) {
        ref_143fa(self);

        if(scripts\mp\gametypes\br_public::use_csm(self)) {
          return;
        }

        scripts\mp\utility\lower_message::setlowermessageomnvar(75);

        for(;;) {
          waittillframeend();

          if(isDefined(self.ref_126cc) && istrue(self.ref_126cc.gulag)) {
            scripts\mp\utility\lower_message::setlowermessageomnvar(0);
            waitframe();
            continue;
          }

          scripts\mp\utility\lower_message::setlowermessageomnvar(75);

          if(!ref_125c9()) {
            scripts\mp\utility\lower_message::setlowermessageomnvar(0);
            waitframe();
          }

          var1 = scripts\engine\utility::ref_143af("buybackRequested", "br_spectator_end_forced_spectator", "playertospectate_set", "spectating_cycle");

          if(isDefined(self) && isDefined(var1) && var1 == "buybackRequested") {
            scripts\mp\utility\lower_message::setlowermessageomnvar(0);
            wait 10;
          }
        }

        return;
      }
    }

    function istacticalbc(var0, var1) {
      var2 = "player: " + var0.name;

      if(isDefined(var1)) {
        var2 += ", playerToSpectate: " + var1.name + ", alive: " + isalive(var1) + ", eliminated: " + istrue(var1.delay_enter_combat_after_investigating_grenade) + ", gulag: " + istrue(var1.gulag);
      }

      scripts\mp\utility\script::laststand_dogtags(var2);
      waitframe();
      var2 = "waitframe - playerToSpectate: " + var1.name + ", alive: " + isalive(var1) + ", eliminated: " + istrue(var1.delay_enter_combat_after_investigating_grenade) + ", gulag: " + istrue(var1.gulag);
      scripts\mp\utility\script::laststand_dogtags(var2);
    }

    function ref_1252a() {
      self.ref_12876 = undefined;
      self.ref_11e80 = undefined;
      self.ref_126cc = undefined;
      self setclientomnvar("ui_show_spectateHud", -1);
      self notify("forcePlayerSpectateTarget");
      self notify("playerMonitorSpectatorCycle");
    }

    function ref_126ab() {
      var0 = self;

      if(var0.sessionstate != "intermission") {
        var1 = ref_12580(var0);

        if(istrue(var1.ref_14439)) {
          var0 scripts\mp\gametypes\br_gulag::ref_1268e(1);
          level notify("update_circle_hide");
        }

        ref_13668(var0, var1);
        return;
      }
    }

    function forceplayerspectatetarget(var0) {
      if(istrue(level.endmatchcameratransitions)) {
        return;
      }

      var1 = self;
      level endon("brSpawnPlayersEnding");
      var1 endon("disconnect");
      var1 notify("forcePlayerSpectateTarget");
      var1 endon("forcePlayerSpectateTarget");
      var1.ref_12876 = 1;
      ref_126ab(var1);

      if(!isDefined(var0) || !isPlayer(var0) || !isalive(var0) && !ref_125ed(var0)) {
        if(level.gameended || level.players.size == 1) {
          var1 setclientomnvar("ui_show_spectateHud", var1 getentitynumber());
          var1.ref_12876 = undefined;
          return;
        }

        thread istacticalbc(var1, var0);
        var0 = regive_killstreak_after_use(var1);

        if(!isDefined(var0)) {
          var1 setclientomnvar("ui_show_spectateHud", var1 getentitynumber());
          var1.ref_12876 = undefined;
          return;
        }
      }

      var0 endon("disconnect");
      var2 = var0 getentitynumber();
      var1.ref_126cc = var0;
      var1 setclientomnvar("ui_show_spectateHud", var2);

      if(!var1 isadditionalstreamposready()) {
        var1 clearadditionalstreampos();
      }

      var1 calloutmarkerping_getorigin(0);
      var3 = var0.origin;

      if(istrue(var0.respawningfromtoken) && isDefined(var0.forcespawnorigin)) {
        if(!var0 scripts\mp\gametypes\br_gulag::ref_125ea()) {
          if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
            logstring("bnk_forcePlayerSpectateTarget()");
          }

          var1 thread scripts\mp\gametypes\br_gulag::ref_12523();
        } else if(!var1 scripts\mp\gametypes\br_gulag::ref_125ea()) {
          var1 scripts\mp\gametypes\br_gulag::ref_12522();
        }

        var3 = var0.forcespawnorigin;
        var1 setadditionalstreampos(var3, 1);
      } else if(isDefined(var0.ref_1391a)) {
        var3 = var0.ref_1391a.origin;
        var1 setadditionalstreampos(var3, 1);
      } else {
        var1 setadditionalstreampos(var3, 1, 0, var0);
      }

      var1 loadcustomizationplayerview(var0);
      var4 = var0 getweaponslistprimaries();
      var1 loadweaponsforplayer(var4, 1);
      waitframe();
      var5 = getdvarint("spectate_stream_update_distsq", 2500);
      var6 = getdvarint("spectate_stream_update_time", 500);
      var7 = getdvarint("spectate_stream_timeout", 9000);
      var8 = gettime() + var6;
      var9 = gettime() + var7;

      while((!var1 isadditionalstreamposready() || isDefined(var0) && !var1 hasloadedcustomizationplayerview(var0) || !var1 hasloadedviewweapons(var4)) && gettime() < var9) {
        if(isDefined(var0) && !isDefined(var0.ref_1391a) && gettime() > var8) {
          var10 = distance2dsquared(var0.origin, var3);

          if(var10 > var5) {
            var3 = var0.origin;
            var1 setadditionalstreampos(var3, 1, 0, var0);
            var8 = gettime() + var6;
          }
        }

        waitframe();
      }

      var12 = getdvarint("spectate_stream_update_time", 2000);
      var9 = gettime() + var7;
      var13 = 0;

      while((isDefined(var0.ref_1391a) || !isalive(var0)) && gettime() < var9) {
        if(gettime() > var13) {
          var1 setadditionalstreampos(var3, 1);
          var13 = gettime() + var12;
        }

        waitframe();
      }

      if(isDefined(var0)) {
        ref_12563(var1, var0);
      }

      thread ref_12603();
      var1 clearadditionalstreampos();

      if(istrue(var1.ref_14439)) {
        var1 scripts\mp\gametypes\br_gulag::ref_1268e(0);
        level notify("update_circle_hide");
        return;
      }
    }

    function ref_12563(var0) {
      var1 = self;

      if(!istrue(var1.multieventdisabled)) {
        if(!var0 scripts\mp\gametypes\br_gulag::ref_125ea()) {
          if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
            logstring("bnk_playerForceSpectatorClientWait()");
          }

          var1 thread scripts\mp\gametypes\br_gulag::ref_12523();
        } else if(!var1 scripts\mp\gametypes\br_gulag::ref_125ea()) {
          var1 scripts\mp\gametypes\br_gulag::ref_12522();
          wait 0.5;
        }
      }

      var2 = var0 getentitynumber();
      var1 scripts\mp\utility\player::updatesessionstate("spectator");
      var1.forcespectatorclient = var2;
      var1 scripts\mp\utility\player::_freezecontrols(0, undefined, "spawnIntermission");
      var1 calloutmarkerping_getcreatedtime(0);
      var1 setclientomnvar("ui_show_spectateHud", -1);
      var3 = var1 getspectatingplayer();

      while(!isDefined(var3) || var2 != var3 getentitynumber()) {
        waitframe();
        var3 = var1 getspectatingplayer();

        if(!isDefined(var0) || !vandalize_target_think(var0)) {
          break;
        }
      }

      var1 notify("br_spectator_end_forced_spectator");
      var1.forcespectatorclient = -1;

      if(isDefined(var0) && vandalize_target_think(var0)) {
        var1 spectateclientnum(var2, 1);
      }

      var1.ref_12876 = undefined;
    }

    function assignspectatortospectateplayer(var0, var1) {
      var2 = scripts\mp\gametypes\br_gametypes::ref_12e05("assignSpectatorToSpectatePlayer", var0, var1);

      if(istrue(var2)) {
        return;
      }

      var0 allowspectateteam("freelook", 0);
      var0 allowspectateteam("none", 0);
      var0 setmlgmessagesent(0);

      if(level.teambased && isDefined(var1)) {
        var0 allowspectateteam(var1.team, 1);
      }

      thread forceplayerspectatetarget(var0);
      self notify("playertospectate_set");
    }

    function ref_12603() {
      self notify("playerMonitorSpectatorCycle");
      self endon("playerMonitorSpectatorCycle");
      self endon("forcePlayerSpectateTarget");
      self endon("disconnect");
      self endon("started_spawnPlayer");
      level endon("br_ending_start");

      for(;;) {
        self waittill("spectating_cycle_start", var0);

        if(!isDefined(var0)) {
          continue;
        }

        if(var0 scripts\mp\gametypes\br_gulag::ref_125ea()) {
          scripts\mp\gametypes\br_gulag::ref_12522();
        }

        var1 = ref_126ec(var0);
        var2 = self getspectatingplayer();

        if(!istrue(var1) || !isDefined(var2)) {
          stopspectateplayer(self getentitynumber(), 1);

          if(vandalize_target_think(self.ref_126cc)) {
            ref_12563(self.ref_126cc);
          } else {
            var0 = regive_killstreak_after_use(self);

            if(isDefined(var0) && !var0 scripts\mp\gametypes\br_gulag::ref_125ea()) {
              if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
                logstring("bnk_playerMonitorSpectatorCycle()");
              }

              thread scripts\mp\gametypes\br_gulag::ref_12523();
            }

            assignspectatortospectateplayer(self, var0);
          }

          continue;
        }

        self.ref_126cc = var0;

        if(var2 != var0) {
          self.ref_126cc = var2;
        }

        if(self.ref_126cc scripts\mp\gametypes\br_gulag::ref_125ea()) {
          if(!scripts\mp\gametypes\br_gulag::ref_125ea()) {
            scripts\mp\gametypes\br_gulag::ref_12522();
          }

          continue;
        }

        if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
          logstring("bnk_playerMonitorSpectatorCycle()");
        }

        thread scripts\mp\gametypes\br_gulag::ref_12523();
      }
    }

    function ref_126ec(var0) {
      var0 endon("death_or_disconnect");
      self waittill("spectating_cycle");
      return true;
    }

    function ref_12580() {
      var0 = undefined;

      if(!istrue(self.spectatekillcam)) {
        var0 = self getspectatingplayer();
      }

      if(!isDefined(var0) && isDefined(self.ref_11e80)) {
        var0 = self.ref_11e80;
      }

      if(!isDefined(var0) && isDefined(self.ref_126cc)) {
        var0 = self.ref_126cc;
      }

      return var0;
    }

    function rotatetocurrentangles(var0) {
      var1 = [];

      foreach(var3 in level.players) {
        if(!isDefined(var3)) {
          continue;
        }

        if(vandalize_target_think(var3)) {
          continue;
        }

        if(!istrue(var3.br_spectatorinitialized)) {
          continue;
        }

        var4 = ref_12580(var3);

        if(!isDefined(var4)) {
          continue;
        }

        if(var4 == var0) {
          var1 = var3;
        }
      }

      return var1;
    }

    function ref_11be2(var0, var1, var2) {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        return;
      }

      var3 = regive_killstreak_after_use(var0, var1);

      if(var2 && !istrue(var0.gulag)) {
        var0.ref_11e80 = var3;
      }

      if(isDefined(var3) || !istrue(level.‚kò·° F© ÝÇ - wá3Åû¸ "N|¸”%CÁPÙŠÅ ) ) {
          updateexistingspectatorsofvictim(var0, var3);
          return;
        }
      }

      function ref_125ed() {
        return isDefined(self.ref_1391a) || scripts\mp\gametypes\br_public::ref_125f3() || istrue(self.tut_popup_listener) || istrue(self.respawningfromtoken);
      }

      function updateexistingspectatorsofvictim(var0, var1) {
        var2 = rotatetocurrentangles(var0);

        foreach(var4 in var2) {
          if(isDefined(var1) && var0.team == var4.team && var1.team != var0.team && ref_125ed(var0)) {
            assignspectatortospectateplayer(var4, var0);
            continue;
          }

          if(isDefined(var4.ref_11e80)) {
            var4.ref_11e80 = var1;
            continue;
          }

          assignspectatortospectateplayer(var4, var1);
        }
      }

      function updateactivespectatorcounts() {
        level endon("game_ended");
        scripts\mp\flags::gameflagwait("prematch_done");

        for(;;) {
          var0 = [];

          foreach(var2 in level.players) {
            if(isDefined(var2)) {
              var3 = var2 getspectatingplayer();

              if(isDefined(var3)) {
                var4 = var3 getentitynumber();
                var0 = scripts\mp\gametypes\br::get_int_or_0(var0[var4]) + 1;
              }
            }
          }

          var6 = 0;

          foreach(var2 in level.players) {
            if(isDefined(var2)) {
              var8 = var2 getentitynumber();
              var9 = scripts\mp\gametypes\br::get_int_or_0(var0[var8]);
              var10 = var2 calloutmarkerping_entityzoffset("ui_br_active_spectators");

              if(var9 != var10) {
                var2 setclientomnvar("ui_br_active_spectators", var9);
              }

              var6++;

              if(var6 % 10 == 0) {
                waitframe();
              }
            }
          }

          wait 1;
        }
      }

      function ref_143fa(var0) {
        while(var0.sessionstate != "intermission") {
          waitframe();
        }

        while(var0.sessionstate == "intermission") {
          waitframe();
        }

        while(var0.sessionstate != "spectator") {
          waitframe();
        }
      }