/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_sr.gsc
***********************************************/

main() {
  _encstr_B228252B9FC804A35D0386AA8B18137D1027FF822FA0CA578C79BAD2130B13B7F1CF2C46473016::setup_callbacks();
  setup_callbacks();
  _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::setup_bot_conf();
  _encstr_B228252B9FC804A35D0386AA8B18137D1027FF822FA0CA578C79BAD2130B13B7F1CF2C46473016::bot_sd_start();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_sr_think;
}

bot_sr_think() {
  self notify("_encstr_871E0D7E50011983BB01D3AB58D043");
  self endon("_encstr_871E0D7E50011983BB01D3AB58D043");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.has_started_thinking = undefined;

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.suspend_sd_role = undefined;
  childthread tag_watcher();
  _encstr_B228252B9FC804A35D0386AA8B18137D1027FF822FA0CA578C79BAD2130B13B7F1CF2C46473016::bot_sd_think();
}

tag_watcher() {
  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self.role)) {
      continue;
    }
    var_0 = _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::bot_find_visible_tags(0);

    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::random(var_0);

      if(distancesquared(self.origin, var_1.tag.curorigin) < 10000)
        sr_pick_up_tag(var_1.tag);
      else if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        if(self.role != "_encstr_86350B2290E7F9A3C8A97A753E")
          sr_pick_up_tag(var_1.tag);
      } else if(self.role != "_encstr_887B0891B2CCD59BB293")
        sr_pick_up_tag(var_1.tag);
    }
  }
}

sr_pick_up_tag(var_0) {
  if(isDefined(var_0.bot_picking_up) && isDefined(var_0.bot_picking_up[self.team]) && isalive(var_0.bot_picking_up[self.team]) && var_0.bot_picking_up[self.team] != self) {
    return;
  }
  if(sr_ally_near_tag(var_0)) {
    return;
  }
  if(!isDefined(self.role)) {
    return;
  }
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  var_0.bot_picking_up[self.team] = self;
  var_0 thread clear_bot_on_reset();
  var_0 thread clear_bot_on_bot_death(self);
  self.suspend_sd_role = 1;
  childthread notify_when_tag_picked_up_or_unavailable(var_0, "_encstr_85AB0EF8D18F6792EA97475BE247E3C9");
  var_1 = var_0.curorigin;
  self botsetscriptgoal(var_1, 0, "_encstr_99C209E34FC743616118AB");
  childthread watch_tag_destination(var_0);
  var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_85AB0EF8D18F6792EA97475BE247E3C9", "_encstr_854209CE6B1871631838EA");
  self notify("_encstr_A6221B4F2068F8797F27837E9B0783B131116B9F80A329B2AB45CC75F0");

  if(var_2 == "_encstr_866D08B0C561870B03FB") {
    var_1 = var_1 + (16 * rand_pos_or_neg(), 16 * rand_pos_or_neg(), 0);
    self botsetscriptgoal(var_1, 0, "_encstr_99C209E34FC743616118AB");
    var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_85AB0EF8D18F6792EA97475BE247E3C9", "_encstr_854209CE6B1871631838EA");

    if(var_2 == "_encstr_866D08B0C561870B03FB") {
      var_1 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_B8D91C321703FF17891F78A2525B18637DC74BF027E6D2C1F94B8FC170A3", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var_0.curorigin, 32, self);

      if(isDefined(var_1)) {
        self botsetscriptgoal(var_1, 0, "_encstr_99C209E34FC743616118AB");
        var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_85AB0EF8D18F6792EA97475BE247E3C9", "_encstr_854209CE6B1871631838EA");
      }
    }
  } else if(var_2 == "_encstr_86E5092BA829F7AB738DA4") {
    var_3 = getnodesinradiussorted(var_0.curorigin, 256, 0, level.bot_tag_allowable_jump_height + 55);

    if(var_3.size > 0) {
      var_4 = (var_0.curorigin[0], var_0.curorigin[1], (var_3[0].origin[2] + var_0.curorigin[2]) * 0.5);
      self botsetscriptgoal(var_4, 0, "_encstr_99C209E34FC743616118AB");
      var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_85AB0EF8D18F6792EA97475BE247E3C9", "_encstr_854209CE6B1871631838EA");
    }
  }

  if(var_2 == "_encstr_8B7205D9ED5958" && var_0 _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::custom_death_func(self.team))
    wait 3.0;

  if(self bothasscriptgoal() && isDefined(var_1)) {
    var_5 = self botgetscriptgoal();

    if(scripts\mp\bots\bots_util::bot_vectors_are_equal(var_5, var_1))
      self botclearscriptgoal();
  }

  self notify("_encstr_8B2911B3C38F6048AB7737BFD7022530501F1B");
  var_0.bot_picking_up[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

watch_tag_destination(var_0) {
  self endon("_encstr_A6221B4F2068F8797F27837E9B0783B131116B9F80A329B2AB45CC75F0");

  for(;;) {
    if(!var_0 _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::custom_death_func(self.team))
      wait 0.05;

    var_1 = self botgetscriptgoal();
    wait 0.05;
  }
}

sr_ally_near_tag(var_0) {
  var_1 = distance(self.origin, var_0.curorigin);
  var_2 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(self.team, 1);

  foreach(var_4 in var_2) {
    if(var_4 != self && isDefined(var_4.role) && var_4.role != "_encstr_86350B2290E7F9A3C8A97A753E" && var_4.role != "_encstr_887B0891B2CCD59BB293") {
      var_5 = distance(var_4.origin, var_0.curorigin);

      if(var_5 < var_1 * 0.5)
        return 1;
    }
  }

  return 0;
}

rand_pos_or_neg() {
  return randomintrange(0, 2) * 2 - 1;
}

clear_bot_on_reset() {
  self waittill("_encstr_88F20627959BCAE8");
  self.bot_picking_up = [];
}

clear_bot_on_bot_death(var_0) {
  self endon("_encstr_88F20627959BCAE8");
  var_1 = var_0.team;
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.bot_picking_up[var_1] = undefined;
}

notify_when_tag_picked_up_or_unavailable(var_0, var_1) {
  self endon("_encstr_8B2911B3C38F6048AB7737BFD7022530501F1B");

  while(var_0 _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::custom_death_func(self.team) && !_encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::bot_check_tag_above_head(var_0))
    wait 0.05;

  self notify(var_1);
}

sr_camp_tag(var_0) {
  if(isDefined(var_0.bot_camping) && isDefined(var_0.bot_camping[self.team]) && isalive(var_0.bot_camping[self.team]) && var_0.bot_camping[self.team] != self) {
    return;
  }
  if(!isDefined(self.role)) {
    return;
  }
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  var_0.bot_camping[self.team] = self;
  var_0 thread clear_bot_camping_on_reset();
  var_0 thread clear_bot_camping_on_bot_death(self);
  self.suspend_sd_role = 1;
  scripts\mp\bots\bots_personality::clear_camper_data();
  var_1 = self.role;

  while(var_0 _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::custom_death_func(self.team) && self.role == var_1) {
    if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
      if(scripts\mp\bots\bots_personality::find_ambush_node(var_0.curorigin, 1000))
        childthread _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::bot_camp_tag(var_0, "_encstr_99C209E34FC743616118AB", "_encstr_854209CE6B1871631838EA");
    }

    wait 0.05;
  }

  self notify("_encstr_9B93116E8EF683FA8D16DAC1A5B93BEB8EB0EC");
  self botclearscriptgoal();
  var_0.bot_camping[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

clear_bot_camping_on_reset() {
  self waittill("_encstr_88F20627959BCAE8");
  self.bot_camping = [];
}

clear_bot_camping_on_bot_death(var_0) {
  self endon("_encstr_88F20627959BCAE8");
  var_1 = var_0.team;
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.bot_camping[var_1] = undefined;
}