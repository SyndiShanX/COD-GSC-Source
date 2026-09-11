/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grind.gsc
***************************************************/

function main() {
  setup_callbacks();
  scripts\mp\bots\bots_gametype_conf::setup_bot_conf();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_grind_think;
}

function bot_grind_think() {
  self notify("bot_grind_think");
  self endon("bot_grind_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.grind_waiting_to_bank = 0;
  self.goal_zone = undefined;
  self.conf_camping_zone = 0;
  self.additional_tactical_logic_func = &bot_grind_extra_think;

  if(self botgetdifficultysetting("strategyLevel") > 0) {
    GscBinSkip4(0x35);
  }

  scripts\mp\bots\bots_gametype_conf::bot_conf_think();
}

function bot_grind_extra_think() {
  if(!isDefined(self.tag_getting)) {
    if(self.tagscarried > 0) {
      var0 = squared(500 + self.tagscarried * 250);

      if(game["teamScores"][self.team] + self.tagscarried >= level.roundscorelimit) {
        var0 = squared(5000);
      } else if(!isDefined(self.enemy) && !scripts\mp\bots\bots_util::bot_in_combat()) {
        var0 = squared(1500 + self.tagscarried * 250);
      }

      var1 = undefined;

      foreach(var3 in level.objectives) {
        var4 = distancesquared(self.origin, var3.trigger.origin);

        if(var4 < var0) {
          var0 = var4;
          var1 = var3;
        }
      }

      if(isDefined(var1)) {
        var6 = 1;

        if(self.grind_waiting_to_bank) {
          if(isDefined(self.goal_zone) && self.goal_zone == var1) {
            var6 = 0;
          }
        }

        if(var6) {
          self.grind_waiting_to_bank = 1;
          self.goal_zone = var1;
          self botclearscriptgoal();
          self notify("stop_going_to_zone");
          self notify("stop_camping_zone");
          self.conf_camping_zone = 0;
          scripts\mp\bots\bots_personality::clear_camper_data();
          scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("kill_tag");
          GscBinSkip4(0x35, var1, "tactical");
        }
      }

      if(self.grind_waiting_to_bank) {
        if(game["teamScores"][self.team] + self.tagscarried >= level.roundscorelimit) {
          self botsetflag("force_sprint", 1);
        }
      }
    } else if(self.grind_waiting_to_bank) {
      self.grind_waiting_to_bank = 0;
      self.goal_zone = undefined;
      self notify("stop_going_to_zone");
      self botclearscriptgoal();
    }

    if(self.personality == "camper" && !self.conf_camping_tag && !self.grind_waiting_to_bank) {
      var0 = undefined;
      var1 = undefined;

      foreach(var3 in level.objectives) {
        var4 = distancesquared(self.origin, var3.trigger.origin);

        if(!isDefined(var0) || var4 < var0) {
          var0 = var4;
          var1 = var3;
        }
      }

      if(isDefined(var1)) {
        if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
          if(scripts\mp\bots\bots_personality::find_ambush_node(var1.trigger.origin)) {
            self.conf_camping_zone = 1;
            self notify("stop_going_to_zone");
            self.grind_waiting_to_bank = 0;
            self botclearscriptgoal();
            GscBinSkip4(0x35, var1, "camp");
          }

          self notify("stop_camping_zone");
          self.conf_camping_zone = 0;
          scripts\mp\bots\bots_personality::clear_camper_data();
        }
      } else {
        self.conf_camping_zone = 1;
      }
    }
  } else {
    self notify("stop_going_to_zone");
    self.grind_waiting_to_bank = 0;
    self.goal_zone = undefined;
    self notify("stop_camping_zone");
    self.conf_camping_zone = 0;
  }

  return self.grind_waiting_to_bank || self.conf_camping_zone;
}

function bot_goto_zone(var0, var1) {
  self endon("stop_going_to_zone");

  if(!isDefined(var0.calculated_nearest_node)) {
    var0.nearest_node = getclosestnodeinsight(var0.trigger.origin);
    var0.calculated_nearest_node = 1;
  }

  var2 = var0.nearest_node;
  self botsetscriptgoal(var2.origin, 32, var1);
  var3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

function bot_camp_zone(var0, var1) {
  self endon("stop_camping_zone");
  self botsetscriptgoalnode(self.node_ambushing_from, var1, self.ambush_yaw);
  var2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var2 == "goal") {
    if(!isDefined(var0.calculated_nearest_node)) {
      var0.nearest_node = getclosestnodeinsight(var0.trigger.origin);
      var0.calculated_nearest_node = 1;
    }

    var3 = var0.nearest_node;

    if(isDefined(var3)) {
      var4 = findentrances(self.origin);
      var4 = scripts\engine\utility::array_add(var4, var3);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(var4);
      return;
    }

    return;
  }
}

function enemy_watcher() {
  self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");

  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") < 2) {
      wait 0.5;
    } else {
      wait 0.2;
    }

    if(isDefined(self.enemy) && isPlayer(self.enemy) && isDefined(self.enemy.tagscarried) && self.enemy.tagscarried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin, self.enemy.origin) <= 500) {
      self botsetdifficultysetting("meleeChargeDist", 500);
      self botsetflag("prefer_melee", 1);
      continue;
    }

    self botsetdifficultysetting("meleeChargeDist", self.default_meleechargedist);
    self botsetflag("prefer_melee", 0);
  }
}