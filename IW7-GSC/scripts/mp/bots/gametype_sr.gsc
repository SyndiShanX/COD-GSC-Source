/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_sr.gsc
*********************************************/

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

    var_0 = scripts\mp\bots\gametype_conf::bot_find_visible_tags(0);
    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::random(var_0);
      if(distancesquared(self.origin, var_1.physics_setgravitydynentscalar.curorigin) < 10000) {
        sr_pick_up_tag(var_1.physics_setgravitydynentscalar);
      } else if(self.team == game["attackers"]) {
        if(self.role != "atk_bomber") {
          sr_pick_up_tag(var_1.physics_setgravitydynentscalar);
        }
      } else if(self.role != "bomb_defuser") {
        sr_pick_up_tag(var_1.physics_setgravitydynentscalar);
      }
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

  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  var_0.bot_picking_up[self.team] = self;
  var_0 thread clear_bot_on_reset();
  var_0 thread clear_bot_on_bot_death(self);
  self.suspend_sd_role = 1;
  childthread notify_when_tag_picked_up_or_unavailable(var_0, "tag_picked_up");
  var_1 = var_0.curorigin;
  self botsetscriptgoal(var_1, 0, "tactical");
  childthread watch_tag_destination(var_0);
  var_2 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
  self notify("stop_watch_tag_destination");
  if(var_2 == "no_path") {
    var_1 = var_1 + (16 * rand_pos_or_neg(), 16 * rand_pos_or_neg(), 0);
    self botsetscriptgoal(var_1, 0, "tactical");
    var_2 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
    if(var_2 == "no_path") {
      var_1 = scripts\mp\bots\_bots_util::bot_queued_process("BotGetClosestNavigablePoint", ::scripts\mp\bots\_bots_util::func_bot_get_closest_navigable_point, var_0.curorigin, 32, self);
      if(isDefined(var_1)) {
        self botsetscriptgoal(var_1, 0, "tactical");
        var_2 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
      }
    }
  } else if(var_2 == "bad_path") {
    var_3 = getnodesinradiussorted(var_0.curorigin, 256, 0, level.bot_tag_allowable_jump_height + 55);
    if(var_3.size > 0) {
      var_4 = (var_0.curorigin[0], var_0.curorigin[1], var_3[0].origin[2] + var_0.curorigin[2] * 0.5);
      self botsetscriptgoal(var_4, 0, "tactical");
      var_2 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "tag_picked_up", "new_role");
    }
  }

  if(var_2 == "goal" && var_0 scripts\mp\gameobjects::caninteractwith(self.team)) {
    wait(3);
  }

  if(self bothasscriptgoal() && isDefined(var_1)) {
    var_5 = self botgetscriptgoal();
    if(scripts\mp\bots\_bots_util::bot_vectors_are_equal(var_5, var_1)) {
      self botclearscriptgoal();
    }
  }

  self notify("stop_tag_watcher");
  var_0.bot_picking_up[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

watch_tag_destination(var_0) {
  self endon("stop_watch_tag_destination");
  for(;;) {
    if(!var_0 scripts\mp\gameobjects::caninteractwith(self.team)) {
      wait(0.05);
    }

    var_1 = self botgetscriptgoal();
    wait(0.05);
  }
}

sr_ally_near_tag(var_0) {
  var_1 = distance(self.origin, var_0.curorigin);
  var_2 = scripts\mp\bots\gametype_sd::get_living_players_on_team(self.team, 1);
  foreach(var_4 in var_2) {
    if(var_4 != self && isDefined(var_4.role) && var_4.role != "atk_bomber" && var_4.role != "bomb_defuser") {
      var_5 = distance(var_4.origin, var_0.curorigin);
      if(var_5 < var_1 * 0.5) {
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

clear_bot_on_bot_death(var_0) {
  self endon("reset");
  var_1 = var_0.team;
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self.bot_picking_up[var_1] = undefined;
}

notify_when_tag_picked_up_or_unavailable(var_0, var_1) {
  self endon("stop_tag_watcher");
  while(var_0 scripts\mp\gameobjects::caninteractwith(self.team) && !scripts\mp\bots\gametype_conf::func_2D2E(var_0)) {
    wait(0.05);
  }

  self notify(var_1);
}

sr_camp_tag(var_0) {
  if(isDefined(var_0.bot_camping) && isDefined(var_0.bot_camping[self.team]) && isalive(var_0.bot_camping[self.team]) && var_0.bot_camping[self.team] != self) {
    return;
  }

  if(!isDefined(self.role)) {
    return;
  }

  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  var_0.bot_camping[self.team] = self;
  var_0 thread clear_bot_camping_on_reset();
  var_0 thread clear_bot_camping_on_bot_death(self);
  self.suspend_sd_role = 1;
  scripts\mp\bots\_bots_personality::clear_camper_data();
  var_1 = self.role;
  while(var_0 scripts\mp\gameobjects::caninteractwith(self.team) && self.role == var_1) {
    if(scripts\mp\bots\_bots_personality::should_select_new_ambush_point()) {
      if(scripts\mp\bots\_bots_personality::find_ambush_node(var_0.curorigin, 1000)) {
        childthread scripts\mp\bots\gametype_conf::bot_camp_tag(var_0, "tactical", "new_role");
      }
    }

    wait(0.05);
  }

  self notify("stop_camping_tag");
  self botclearscriptgoal();
  var_0.bot_camping[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

clear_bot_camping_on_reset() {
  self waittill("reset");
  self.bot_camping = [];
}

clear_bot_camping_on_bot_death(var_0) {
  self endon("reset");
  var_1 = var_0.team;
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self.bot_camping[var_1] = undefined;
}