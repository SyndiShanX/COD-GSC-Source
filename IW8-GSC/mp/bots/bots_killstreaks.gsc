/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_killstreaks.gsc
***********************************************/

bot_killstreak_setup() {
  if(!isDefined(level.killstreak_botfunc)) {
    if(!isDefined(level.killstreak_botfunc))
      level.killstreak_botfunc = [];

    if(!isDefined(level.killstreak_botcanuse))
      level.killstreak_botcanuse = [];

    if(!isDefined(level.killstreak_botparm))
      level.killstreak_botparm = [];

    if(!isDefined(level.bot_supported_killstreaks))
      level.bot_supported_killstreaks = [];

    if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
      return;
    }
    bot_register_killstreak_func("_encstr_851904B59B34", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950", ::bot_killstreak_simple_use);

    if(isDefined(level.mapcustombotkillstreakfunc))
      [[level.mapcustombotkillstreakfunc]]();
  }
}

bot_register_killstreak_func(var_0, var_1, var_2, var_3) {
  level.killstreak_botfunc[var_0] = var_1;
  level.killstreak_botcanuse[var_0] = var_2;
  level.killstreak_botparm[var_0] = var_3;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

bot_killstreak_valid_for_specific_streaktype(var_0, var_1, var_2) {
  if(bot_killstreak_is_valid_internal(var_0, "_encstr_9B9B05A21F601A", undefined, var_1))
    return 1;
  else if(var_2) {}

  return 0;
}

bot_killstreak_is_valid_internal(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(var_0 == "_encstr_BAAE0B0FF9C056F999C9F4D008")
    return 1;

  if(!bot_killstreak_is_valid_single(var_0, var_1))
    return 0;

  if(isDefined(var_3)) {
    var_4 = getsubstr(var_3, 11);

    switch (var_4) {
      case "_encstr_AB3508737F830710ACDB":
        if(!scripts\mp\utility\killstreak::isassaultkillstreak(var_0))
          return 0;

        break;
      case "_encstr_B29108FB78F3394A7385":
        if(!scripts\mp\utility\killstreak::issupportkillstreak(var_0))
          return 0;

        break;
      case "_encstr_BAAE0B0FF9C056F999C9F4D008":
        if(!scripts\mp\utility\killstreak::isspecialistkillstreak(var_0))
          return 0;

        break;
    }
  }

  return 1;
}

bot_killstreak_is_valid_single(var_0, var_1) {
  if(var_1 == "_encstr_8B44074A6379574D40")
    return isDefined(level.killstreaksetups[var_0]) && scripts\mp\utility\killstreak::getkillstreakindex(var_0) != -1;
  else if(var_1 == "_encstr_9B9B05A21F601A")
    return isDefined(level.killstreak_botfunc[var_0]);
}

bot_watch_for_killstreak_use() {
  self notify("_encstr_939E1D13807460BB53ACA752C617BFFB4F1BA018356B81CD05D1D73F175BE5");
  self endon("_encstr_939E1D13807460BB53ACA752C617BFFB4F1BA018356B81CD05D1D73F175BE5");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_ACCB18D6968D63373AC95916DAEBEA9BB2F533D2DC5ADCA1AC91");
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("_encstr_8BBA05185F8B99");
  }
}

bot_is_killstreak_supported(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(level.killstreak_botfunc[var_0]))
    return 0;

  return 1;
}

bot_can_use_killstreak(var_0) {
  var_1 = level.killstreak_botcanuse[var_0];

  if(!isDefined(var_1))
    return 0;

  if(isDefined(var_1) && !self[[var_1]]())
    return 0;

  return 1;
}

bot_think_killstreak() {}

bot_can_use_aa_launcher() {
  return 0;
}

bot_start_aa_launcher_tracking() {}

bot_killstreak_never_use() {}

bot_can_use_air_superiority() {
  return 0;
}

aerial_vehicle_allowed() {
  if(scripts\mp\utility\game::isairdenied())
    return 0;

  if(vehicle_would_exceed_limit())
    return 0;

  return 1;
}

vehicle_would_exceed_limit() {
  return scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\killstreak::maxvehiclesallowed();
}

bot_can_use_emp() {
  if(isDefined(level.empplayer))
    return 0;

  var_0 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(var_2 in var_0) {
    if(isDefined(level.teamemped) && !istrue(level.teamemped[var_2]))
      return 1;
  }

  return 0;
}

bot_can_use_ball_drone() {
  return 0;
}

bot_killstreak_simple_use(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks())
    return 1;

  if(isDefined(var_2) && !self[[var_2]]())
    return 0;

  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  return 1;
}

bot_killstreak_drop_anywhere(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "_encstr_9A8A0985B9F2771AB24E95");
}

bot_killstreak_drop_outside(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "_encstr_B6FB08520849423F193D");
}

bot_killstreak_drop_hidden(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "_encstr_95DF070DD22319CA9B");
}

bot_killstreak_drop(var_0, var_1, var_2, var_3, var_4) {
  wait(randomintrange(2, 4));

  if(!isDefined(var_4))
    var_4 = "_encstr_9A8A0985B9F2771AB24E95";

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks())
    return 1;

  if(isDefined(var_2) && !self[[var_2]]())
    return 0;

  var_5 = self getweaponammoclip(var_0.weapon) + self getweaponammostock(var_0.weapon);

  if(var_5 == 0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.streakname) && var_7.streakname == var_0.streakname)
        var_7.available = 0;
    }

    return 1;
  }

  var_9 = undefined;

  if(var_4 == "_encstr_B6FB08520849423F193D") {
    var_10 = [];
    var_11 = scripts\mp\bots\bots_util::bot_get_nodes_in_cone(0, 750, 0.6, 1);

    foreach(var_13 in var_11) {
      if(nodeexposedtosky(var_13))
        var_10 = scripts\engine\utility::array_add(var_10, var_13);
    }

    if(var_11.size > 5 && var_10.size > var_11.size * 0.6) {
      var_15 = scripts\engine\utility::get_array_of_closest(self.origin, var_10, undefined, undefined, undefined, 150);

      if(var_15.size > 0)
        var_9 = scripts\engine\utility::random(var_15);
      else
        var_9 = scripts\engine\utility::random(var_10);
    }
  } else if(var_4 == "_encstr_95DF070DD22319CA9B") {
    var_16 = getnodesinradius(self.origin, 256, 0, 40);
    var_17 = self getnearestnode();

    if(isDefined(var_17)) {
      var_18 = [];

      foreach(var_13 in var_16) {
        if(nodesvisible(var_17, var_13, 1))
          var_18 = scripts\engine\utility::array_add(var_18, var_13);
      }

      var_9 = self botnodepick(var_18, 1, "_encstr_8E210AB9ED8C56F51AA53259");
    }
  }

  if(isDefined(var_9) || var_4 == "_encstr_9A8A0985B9F2771AB24E95") {
    self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);

    if(isDefined(var_9))
      self botlookatpoint(var_9.origin, 2.45, "_encstr_A7300E08584D77DBA497CF3FC5432757");

    bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
    wait 2.0;
    self botpressbutton("_encstr_999A07C61338F9A23A");
    wait 1.5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("_encstr_8BBA05185F8B99");
    self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  }

  return 1;
}

bot_switch_to_killstreak_weapon(var_0, var_1, var_2) {
  bot_notify_streak_used(var_0, var_1);
}

bot_notify_streak_used(var_0, var_1) {
  if(isDefined(var_0.isgimme) && var_0.isgimme) {
    self notify("_encstr_BA5E0CB6E6FAC28D3A4BBD73D71B");
    return;
  }

  for(var_2 = 1; var_2 < 4; var_2++) {
    if(isDefined(var_1[var_2])) {
      if(isDefined(var_1[var_2].streakname)) {
        if(var_1[var_2].streakname == var_0.streakname) {
          var_3 = var_2 + 2;
          self notify("_encstr_83480BDA6EBE0BC6A35AB773D7" + var_3);
          return;
        }
      }
    }
  }
}

bot_killstreak_choose_loc_enemies(var_0, var_1, var_2, var_3) {
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }
  var_4 = getzonenearest(self.origin);

  if(!isDefined(var_4)) {
    return;
  }
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);
  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  wait 2;
  var_5 = level.zonecount;
  var_6 = -1;
  var_7 = 0;
  var_8 = [];
  var_9 = randomfloat(100) > 50;

  for(var_10 = 0; var_10 < var_5; var_10++) {
    if(var_9)
      var_11 = var_5 - 1 - var_10;
    else
      var_11 = var_10;

    if(var_11 != var_4 && botzonegetindoorpercent(var_11) < 0.25) {
      var_12 = botzonegetcount(var_11, self.team, "_encstr_B2620E4878194F72EE030A77E3BA5EB4");

      if(var_12 > var_7) {
        var_6 = var_11;
        var_7 = var_12;
      }

      var_8 = scripts\engine\utility::array_add(var_8, var_11);
    }
  }

  if(var_6 >= 0)
    var_13 = getzoneorigin(var_6);
  else if(var_8.size > 0)
    var_13 = getzoneorigin(scripts\engine\utility::random(var_8));
  else
    var_13 = getzoneorigin(randomint(level.zonecount));

  var_14 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", var_13 + var_14, randomintrange(0, 360));
  wait 1.0;
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
}

bot_think_watch_aerial_killstreak() {
  self notify("_encstr_8FFA22F37BF3DFC3593B0D44085FAABCB9A08F87386B515AB9D854FC8901C3646360EF27");
  self endon("_encstr_8FFA22F37BF3DFC3593B0D44085FAABCB9A08F87386B515AB9D854FC8901C3646360EF27");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.last_global_badplace_time))
    level.last_global_badplace_time = -10000;

  level.killstreak_global_bp_exists_for["_encstr_9A8507BA4040188D08"] = [];
  level.killstreak_global_bp_exists_for["_encstr_8E8405EA382B2A"] = [];
  var_0 = 0;
  var_1 = randomfloatrange(0.05, 4.0);

  for(;;) {
    wait(var_1);
    var_1 = randomfloatrange(0.05, 4.0);

    if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 0) {
      continue;
    }
    var_2 = 0;

    if(isDefined(level.chopper) && level.chopper.team != self.team)
      var_2 = 1;

    if(isDefined(level.lbsniper) && level.lbsniper.team != self.team)
      var_2 = 1;

    if(enemy_mortar_strike_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("_encstr_A6670E6B9AF29959B3DF3EB5EA07C073", ::enemy_mortar_strike_exists);
    }

    if(enemy_switchblade_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("_encstr_A61B0C88232D200139F213A7B79F", ::enemy_switchblade_exists);
    }

    if(enemy_odin_assault_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("_encstr_96B30D67CDC2C06FB60B1F216F8863", ::enemy_odin_assault_exists);
    }

    var_3 = get_enemy_vanguard();

    if(isDefined(var_3)) {
      var_4 = self getEye();

      if(scripts\engine\utility::within_fov(var_4, self getplayerangles(), var_3.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(var_4, var_3.attackarrow.origin, 0, self, var_3.attackarrow))
          badplace_cylinder("_encstr_A3770A6716733B572C39C8FA" + var_3 getentitynumber(), var_1 + 0.5, var_3.attackarrow.origin, 200, 100, self.team);
      }
    }

    if(!var_0 && var_2) {
      var_0 = 1;
      self botsetflag("_encstr_A6AD0D04BF8FCFC0820B8A578A73A2", 1);
    }

    if(var_0 && !var_2) {
      var_0 = 0;
      self botsetflag("_encstr_A6AD0D04BF8FCFC0820B8A578A73A2", 0);
    }
  }
}

try_place_global_badplace(var_0, var_1) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][var_0]))
    level.killstreak_global_bp_exists_for[self.team][var_0] = 0;

  if(!level.killstreak_global_bp_exists_for[self.team][var_0]) {
    level.killstreak_global_bp_exists_for[self.team][var_0] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, var_0, var_1);
  }
}

monitor_enemy_dangerous_killstreak(var_0, var_1, var_2) {
  var_3 = 0.5;

  while([[var_2]](var_0)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("_encstr_B40101", 5.0, var_0, "_encstr_8AE2098778A90777B8BF09");
      level.last_global_badplace_time = gettime();
    }

    wait(var_3);
  }

  level.killstreak_global_bp_exists_for[var_0][var_1] = 0;
}

enemy_mortar_strike_exists(var_0) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(var_0 != level.air_raid_team_called)
      return 1;
  }

  return 0;
}

enemy_switchblade_exists(var_0) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var_2 in level.rockets) {
      if(isDefined(var_2.type) && var_2.type == "_encstr_A1530723371D084D2A" && var_2.team != var_0)
        return 1;
    }
  }

  return 0;
}

enemy_odin_assault_exists(var_0) {
  foreach(var_2 in level.players) {
    if(!level.teambased || isDefined(var_2.team) && var_0 != var_2.team) {
      if(isDefined(var_2.odin) && var_2.odin.odintype == "_encstr_96B30D67CDC2C06FB60B1F216F8863" && gettime() - var_2.odin.birthtime > 3000)
        return 1;
    }
  }

  return 0;
}

get_enemy_vanguard() {
  foreach(var_1 in level.players) {
    if(!level.teambased || isDefined(var_1.team) && self.team != var_1.team) {
      if(isDefined(var_1.remoteuav) && var_1.remoteuav.helitype == "_encstr_A54E0BF3EA0FB710F7F74B5BE6")
        return var_1.remoteuav;
    }
  }

  return undefined;
}

iskillstreakblockedforbots(var_0) {
  return isDefined(level.botblockedkillstreaks) && isDefined(level.botblockedkillstreaks[var_0]) && level.botblockedkillstreaks[var_0];
}

blockkillstreakforbots(var_0) {
  level.botblockedkillstreaks[var_0] = 1;
}