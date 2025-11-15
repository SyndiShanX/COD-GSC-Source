/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_sr.gsc
*******************************************/

main() {
  scripts\mp\bots\gametype_sd::setup_callbacks();
  setup_callbacks();
  scripts\mp\bots\gametype_conf::setup_bot_conf();
  scripts\mp\bots\gametype_sd::bot_sd_start();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_sr_think;
}

bot_sr_think() {
  self notify("bot_sr_think");
  self endon("bot_sr_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.has_started_thinking = undefined;
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self.suspend_sd_role = undefined;
  childthread tag_watcher();
  scripts\mp\bots\gametype_sd::bot_sd_think();
}

tag_watcher() {
  for(;;) {
    wait(0.05);
    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      continue;
    }

    var_00 = scripts\mp\bots\gametype_conf::bot_find_visible_tags(0);
    if(var_00.size > 0) {
      var_01 = scripts\engine\utility::random(var_00);
      if(distancesquared(self.origin, var_01.physics_setgravitydynentscalar.curorigin) < 10000) {
        sr_pick_up_tag(var_01.physics_setgravitydynentscalar);
      } else if(self.team == game["attackers"]) {
        if(self.role != "atk_bomber") {
          sr_pick_up_tag(var_01.physics_setgravitydynentscalar);
        }
      } else if(self.role != "bomb_defuser") {
        sr_pick_up_tag(var_01.physics_setgravitydynentscalar);
      }
    }
  }
}

sr_pick_up_tag(param_00) {
  if(isDefined(param_00.bot_picking_up) && isDefined(param_00.bot_picking_up[self.team]) && isalive(param_00.bot_picking_up[self.team]) && param_00.bot_picking_up[self.team] != self) {
    return;
  }

  if(sr_ally_near_tag(param_00)) {
    return;
  }

  if(!isDefined(self.role)) {
    return;
  }

  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  param_00.bot_picking_up[self.team] = self;
  param_00 thread clear_bot_on_reset();
  param_00 thread clear_bot_on_bot_death(self);
  self.suspend_sd_role = 1;
  childthread notify_when_tag_picked_up_or_unavailable(param_00, "tag_picked_up");
  var_01 = param_00.curorigin;
  self botsetscriptgoal(var_01, 0, "tactical");
  childthread watch_tag_destination(param_00);
  var_02 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
  self notify("stop_watch_tag_destination");
  if(var_02 == "no_path") {
    var_01 = var_01 + (16 * rand_pos_or_neg(), 16 * rand_pos_or_neg(), 0);
    self botsetscriptgoal(var_01, 0, "tactical");
    var_02 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
    if(var_02 == "no_path") {
      var_01 = scripts\mp\bots\_bots_util::bot_queued_process("BotGetClosestNavigablePoint", ::scripts\mp\bots\_bots_util::func_bot_get_closest_navigable_point, param_00.curorigin, 32, self);
      if(isDefined(var_01)) {
        self botsetscriptgoal(var_01, 0, "tactical");
        var_02 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
      }
    }
  } else if(var_02 == "bad_path") {
    var_03 = getnodesinradiussorted(param_00.curorigin, 256, 0, level.bot_tag_allowable_jump_height + 55);
    if(var_03.size > 0) {
      var_04 = (param_00.curorigin[0], param_00.curorigin[1], var_03[0].origin[2] + param_00.curorigin[2] * 0.5);
      self botsetscriptgoal(var_04, 0, "tactical");
      var_02 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
    }
  }

  if(var_02 == "goal" && param_00 scripts\mp\gameobjects::caninteractwith(self.team)) {
    wait(3);
  }

  if(self bothasscriptgoal() && isDefined(var_01)) {
    var_05 = self botgetscriptgoal();
    if(scripts\mp\bots\_bots_util::bot_vectors_are_equal(var_05, var_01)) {
      self botclearscriptgoal();
    }
  }

  self notify("stop_tag_watcher");
  param_00.bot_picking_up[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

watch_tag_destination(param_00) {
  self endon("stop_watch_tag_destination");
  for(;;) {
    if(!param_00 scripts\mp\gameobjects::caninteractwith(self.team)) {
      wait(0.05);
    }

    var_01 = self botgetscriptgoal();
    wait(0.05);
  }
}

sr_ally_near_tag(param_00) {
  var_01 = distance(self.origin, param_00.curorigin);
  var_02 = scripts\mp\bots\gametype_sd::get_living_players_on_team(self.team, 1);
  foreach(var_04 in var_02) {
    if(var_04 != self && isDefined(var_04.role) && var_04.role != "atk_bomber" && var_04.role != "bomb_defuser") {
      var_05 = distance(var_04.origin, param_00.curorigin);
      if(var_05 < var_01 * 0.5) {
        return 1;
      }
    }
  }

  return 0;
}

rand_pos_or_neg() {
  return randomintrange(0, 2) * 2 - 1;
}

clear_bot_on_reset() {
  self waittill("reset");
  self.bot_picking_up = [];
}

clear_bot_on_bot_death(param_00) {
  self endon("reset");
  var_01 = param_00.team;
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self.bot_picking_up[var_01] = undefined;
}

notify_when_tag_picked_up_or_unavailable(param_00, param_01) {
  self endon("stop_tag_watcher");
  while(param_00 scripts\mp\gameobjects::caninteractwith(self.team) && !scripts\mp\bots\gametype_conf::func_2D2E(param_00)) {
    wait(0.05);
  }

  self notify(param_01);
}

sr_camp_tag(param_00) {
  if(isDefined(param_00.bot_camping) && isDefined(param_00.bot_camping[self.team]) && isalive(param_00.bot_camping[self.team]) && param_00.bot_camping[self.team] != self) {
    return;
  }

  if(!isDefined(self.role)) {
    return;
  }

  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  param_00.bot_camping[self.team] = self;
  param_00 thread clear_bot_camping_on_reset();
  param_00 thread clear_bot_camping_on_bot_death(self);
  self.suspend_sd_role = 1;
  scripts\mp\bots\_bots_personality::clear_camper_data();
  var_01 = self.role;
  while(param_00 scripts\mp\gameobjects::caninteractwith(self.team) && self.role == var_01) {
    if(scripts\mp\bots\_bots_personality::should_select_new_ambush_point()) {
      if(scripts\mp\bots\_bots_personality::find_ambush_node(param_00.curorigin, 1000)) {
        childthread scripts\mp\bots\gametype_conf::bot_camp_tag(param_00, "tactical", "new_role");
      }
    }

    wait(0.05);
  }

  self notify("stop_camping_tag");
  self botclearscriptgoal();
  param_00.bot_camping[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

clear_bot_camping_on_reset() {
  self waittill("reset");
  self.bot_camping = [];
}

clear_bot_camping_on_bot_death(param_00) {
  self endon("reset");
  var_01 = param_00.team;
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self.bot_camping[var_01] = undefined;
}