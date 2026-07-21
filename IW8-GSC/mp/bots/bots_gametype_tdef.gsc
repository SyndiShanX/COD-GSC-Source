/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_tdef.gsc
***********************************************/

main() {
  setup_callbacks();
  _id_131DE();
  thread _id_11CDD();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::debug_bunkerpuzzledebugdraw;
}

_id_131DE() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread damage_per_second();
  level.bot_gametype_precaching_done = 1;
}

dangernotifyplayer() {
  return level.keeprightdooropen;
}

damageskipburndownhigh() {
  if(isDefined(level.keeprightdooropen.carrier))
    return level.keeprightdooropen.carrier;

  return undefined;
}

bot_get_enemy_team() {
  if(self.team == "_encstr_9A8507BA4040188D08")
    return "_encstr_8E8405EA382B2A";

  return "_encstr_9A8507BA4040188D08";
}

debug_bunkerpuzzledebugdraw() {
  self notify("_encstr_A5790FBDC73BD0B0E4D67976BBD8F0F062");
  self endon("_encstr_A5790FBDC73BD0B0E4D67976BBD8F0F062");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.role)) {
      thirdpersonheightoffset();
      var_0 = undefined;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      var_0 = undefined;
      continue;
    }

    if(self.role != "_encstr_933B08D82C93934BCA39" && isDefined(self.carryobject)) {
      var_0 = undefined;
      player_has_minigun("_encstr_933B08D82C93934BCA39");
    }

    if(self.role == "_encstr_933B08D82C93934BCA39") {
      if(isDefined(self.carryobject)) {
        var_2 = 0;

        if(isDefined(self.enemy))
          var_2 = distancesquared(self.enemy.origin, self.origin);

        if(isDefined(self.enemy) && var_2 < 9216) {} else {}

        self botclearscriptgoal();

        if(!isDefined(var_1))
          var_1 = gettime() + randomintrange(500, 1000);

        if(gettime() > var_1)
          var_1 = gettime() + randomintrange(500, 1000);
      } else {
        var_3 = dangernotifyplayer();

        if(!isDefined(var_3)) {
          var_4 = damageskipburndownhigh();

          if(isDefined(var_4) && var_4 != self)
            thirdpersonheightoffset();
        } else {
          self botsetscriptgoal(var_3.curorigin, 16, "_encstr_9A2B0A12F03587575B7BBEA5");
          continue;
        }
      }
    } else
      var_0 = undefined;

    if(self.role == "_encstr_AA7B09475984AF0F6F0F0B") {
      var_3 = dangernotifyplayer();

      if(!isDefined(var_3)) {
        var_4 = damageskipburndownhigh();

        if(isDefined(var_4)) {
          if(!scripts\mp\bots\bots_util::bot_is_guarding_player(var_4))
            scripts\mp\bots\bots_strategy::bot_guard_player(var_4, level.bodyguard_radius);
        }
      } else if(!istrue(var_3.isresetting) && !istrue(var_3.in_goal)) {
        var_5 = getclosestpointonnavmesh(var_3.curorigin);

        if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_5))
          scripts\mp\bots\bots_strategy::bot_protect_point(var_5, level.protect_radius);
      }

      continue;
    }

    if(self.role == "_encstr_8E460991ACCC59378C56C9") {
      var_6 = level.keeprightdooropen.carrier;
      var_7 = var_6.origin;

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_7))
        scripts\mp\bots\bots_strategy::bot_protect_point(var_7, level.protect_radius);
    }
  }
}

thirdpersonheightoffset() {
  var_0 = get_allied_attackers_for_team(self.team);
  var_1 = get_allied_defenders_for_team(self.team);
  var_2 = player_grenade_fire_monitor(self.team);
  var_3 = player_gun_game_next_weapon_think(self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "_encstr_930B07BB1B6B3854FF") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        player_has_minigun("_encstr_AA7B09475984AF0F6F0F0B");
        return;
      }

      player_has_minigun("_encstr_8E460991ACCC59378C56C9");
      return;
    } else
      player_has_minigun("_encstr_AA7B09475984AF0F6F0F0B");
  } else if(var_4 == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "_encstr_930B07BB1B6B3854FF") {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        player_has_minigun("_encstr_8E460991ACCC59378C56C9");
        return;
      }

      player_has_minigun("_encstr_AA7B09475984AF0F6F0F0B");
      return;
    } else
      player_has_minigun("_encstr_8E460991ACCC59378C56C9");
  }
}

damage_per_second() {
  level notify("_encstr_8D031C98DBD1FA991BB09DD7C296FAC85A279536A3DE93D7AB1CC82C3A95");
  level endon("_encstr_8D031C98DBD1FA991BB09DD7C296FAC85A279536A3DE93D7AB1CC82C3A95");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0[0] = "_encstr_9A8507BA4040188D08";
  var_0[1] = "_encstr_8E8405EA382B2A";
  var_1 = [];

  for(;;) {
    foreach(var_3 in var_0) {
      var_4 = player_grenade_fire_monitor(var_3);
      var_5 = player_gun_game_next_weapon_think(var_3);
      var_6 = get_allied_attackers_for_team(var_3);
      var_7 = get_allied_defenders_for_team(var_3);

      if(var_6.size > var_4) {
        var_8 = [];
        var_9 = 0;

        foreach(var_11 in var_6) {
          if(isai(var_11)) {
            if(level.bot_personality_type[var_11.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
              var_11 player_has_minigun("_encstr_8E460991ACCC59378C56C9");
              var_9 = 1;
              break;
            } else
              var_8 = scripts\engine\utility::array_add(var_8, var_11);
          }
        }

        if(!var_9 && var_8.size > 0)
          scripts\engine\utility::random(var_8) player_has_minigun("_encstr_8E460991ACCC59378C56C9");
      }

      if(var_7.size > var_5) {
        var_13 = [];
        var_14 = 0;

        foreach(var_16 in var_7) {
          if(isai(var_16)) {
            if(level.bot_personality_type[var_16.personality] == "_encstr_930B07BB1B6B3854FF") {
              var_16 player_has_minigun("_encstr_AA7B09475984AF0F6F0F0B");
              var_14 = 1;
              break;
            } else
              var_13 = scripts\engine\utility::array_add(var_13, var_16);
          }
        }

        if(!var_14 && var_13.size > 0)
          scripts\engine\utility::random(var_13) player_has_minigun("_encstr_AA7B09475984AF0F6F0F0B");
      }

      var_18 = dangernotifyplayer();

      if(isDefined(var_18)) {
        var_19 = _id_12335(var_3, var_18);

        if(isDefined(var_19) && isDefined(var_19.role) && var_19.role != "_encstr_933B08D82C93934BCA39") {
          if(!isDefined(var_19.carryobject)) {
            var_20 = var_1[var_3];

            if(isDefined(var_20))
              var_20 player_has_minigun(undefined);

            var_19 player_has_minigun("_encstr_933B08D82C93934BCA39");
            var_1[var_19.team] = var_19;
          }
        }
      }
    }

    wait 1.0;
  }
}

player_grenade_fire_monitor(var_0) {
  var_1 = player_gun_game_randomize_weapon_list_think(var_0);
  return var_1;
}

player_gun_game_next_weapon_think(var_0) {
  return 0;
}

player_gun_game_randomize_weapon_list_think(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0)
      var_1++;
  }

  return var_1;
}

_id_12335(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(var_5.team != var_0) {
      continue;
    }
    if(!isalive(var_5)) {
      continue;
    }
    if(!isai(var_5)) {
      continue;
    }
    if(isDefined(var_5.role) && var_5.role == "_encstr_8E460991ACCC59378C56C9") {
      continue;
    }
    var_6 = distancesquared(var_5.origin, var_1.curorigin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2))
    return var_2;

  return undefined;
}

get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("_encstr_AA7B09475984AF0F6F0F0B", var_0);
  return var_1;
}

get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("_encstr_8E460991ACCC59378C56C9", var_0);
  return var_1;
}

player_has_minigun(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

get_players_by_role(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_11CDD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;

  for(;;) {
    var_1 = damageskipburndownhigh();

    if(!isDefined(var_0) || !isDefined(var_1) || var_1 != var_0) {
      if(isDefined(var_0) && var_0.threatbias == 505)
        var_0.threatbias = 0;

      var_0 = var_1;
    }

    if(isDefined(var_1) && var_1.threatbias == 0)
      var_1.threatbias = 505;

    wait 0.05;
  }
}