/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sr.gsc
************************************************/

function main() {
  scripts\mp\bots\bots_gametype_sd::setup_callbacks();
  setup_callbacks();
  scripts\mp\bots\bots_gametype_conf::setup_bot_conf();
  scripts\mp\bots\bots_gametype_sd::bot_sd_start();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_sr_think;
}

function bot_sr_think() {
  self notify("bot_sr_think");
  self endon("bot_sr_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.has_started_thinking = undefined;

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self.suspend_sd_role = undefined;
  GscBinSkip4(0x35);
}

function tag_watcher() {
  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      continue;
    }

    var0 = scripts\mp\bots\bots_gametype_conf::bot_find_visible_tags(0);

    if(var0.size > 0) {
      var1 = scripts\engine\utility::random(var0);

      if(distancesquared(self.origin, var1.tag.curorigin) < 10000) {
        sr_pick_up_tag(var1.tag);
      } else if(self.team == game["attackers"]) {
        if(self.role != "atk_bomber") {
          sr_pick_up_tag(var1.tag);
        }
      } else if(self.role != "defuser") {
        sr_pick_up_tag(var1.tag);
      }
    }
  }
}

function sr_pick_up_tag(var0) {
  if(isDefined(var0.bot_picking_up) && isDefined(var0.bot_picking_up[self.team]) && isalive(var0.bot_picking_up[self.team]) && var0.bot_picking_up[self.team] != self) {
    return;
  }

  if(sr_ally_near_tag(var0)) {
    return;
  }

  if(!isDefined(self.role)) {
    return;
  }

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  var0.bot_picking_up[self.team] = self;
  thread clear_bot_on_reset();
  thread clear_bot_on_bot_death(var0);
  self.suspend_sd_role = 1;
  GscBinSkip4(0x35, var0, "tag_picked_up", self, var0);
}

function watch_tag_destination(var0) {
  self endon("stop_watch_tag_destination");

  for(;;) {
    if(!var0 scripts\mp\bots\bots_gametype_conf::custom_death_func(self.team)) {
      wait 0.05;
    }

    var1 = self botgetscriptgoal();
    wait 0.05;
  }
}

function sr_ally_near_tag(var0) {
  var1 = distance(self.origin, var0.curorigin);
  var2 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(self.team, 1);

  foreach(var4 in var2) {
    if(var4 != self && isDefined(var4.role) && var4.role != "atk_bomber" && var4.role != "defuser") {
      var5 = distance(var4.origin, var0.curorigin);

      if(var5 < var1 * 0.5) {
        return true;
      }
    }
  }

  return false;
}

function rand_pos_or_neg() {
  return randomintrange(0, 2) * 2 - 1;
}

function clear_bot_on_reset() {
  self waittill("reset");
  self.bot_picking_up = [];
}

function clear_bot_on_bot_death(var0) {
  self endon("reset");
  var1 = var0.team;
  var0 waittill("death_or_disconnect");
  self.bot_picking_up[var1] = undefined;
}

function notify_when_tag_picked_up_or_unavailable(var0, var1) {
  self endon("stop_tag_watcher");

  while(var0 scripts\mp\bots\bots_gametype_conf::custom_death_func(self.team) && !scripts\mp\bots\bots_gametype_conf::bot_check_tag_above_head(var0)) {
    wait 0.05;
  }

  self notify(var1);
}

function sr_camp_tag(var0) {
  if(isDefined(var0.bot_camping) && isDefined(var0.bot_camping[self.team]) && isalive(var0.bot_camping[self.team]) && var0.bot_camping[self.team] != self) {
    return;
  }

  if(!isDefined(self.role)) {
    return;
  }

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  var0.bot_camping[self.team] = self;
  thread clear_bot_camping_on_reset();
  thread clear_bot_camping_on_bot_death(var0);
  self.suspend_sd_role = 1;
  scripts\mp\bots\bots_personality::clear_camper_data();
  var1 = self.role;

  while(var0 scripts\mp\bots\bots_gametype_conf::custom_death_func(self.team) && self.role == var1) {
    if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
      if(scripts\mp\bots\bots_personality::find_ambush_node(var0.curorigin, 1000)) {
        childthread scripts\mp\bots\bots_gametype_conf::bot_camp_tag(var0, "tactical", "new_role");
      }
    }

    wait 0.05;
  }

  self notify("stop_camping_tag");
  self botclearscriptgoal();
  var0.bot_camping[self.team] = undefined;
  self.suspend_sd_role = undefined;
}

function clear_bot_camping_on_reset() {
  self waittill("reset");
  self.bot_camping = [];
}

function clear_bot_camping_on_bot_death(var0) {
  self endon("reset");
  var1 = var0.team;
  var0 waittill("death_or_disconnect");
  self.bot_camping[var1] = undefined;
}