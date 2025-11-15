/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_grind.gsc
**********************************************/

main() {
  setup_callbacks();
  scripts\mp\bots\gametype_conf::setup_bot_conf();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_grind_think;
}

bot_grind_think() {
  self notify("bot_grind_think");
  self endon("bot_grind_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.grind_waiting_to_bank = 0;
  self.goal_zone = undefined;
  self.conf_camping_zone = 0;
  self.additional_tactical_logic_func = ::bot_grind_extra_think;
  if(self botgetdifficultysetting("strategyLevel") > 0) {
    childthread enemy_watcher();
  }

  scripts\mp\bots\gametype_conf::bot_conf_think();
}

bot_grind_extra_think() {
  if(!isDefined(self.tag_getting)) {
    if(self.tagscarried > 0) {
      var_00 = squared(500 + self.tagscarried * 250);
      if(game["teamScores"][self.team] + self.tagscarried >= level.roundscorelimit) {
        var_00 = squared(5000);
      } else if(!isDefined(self.isnodeoccupied) && !scripts\mp\bots\_bots_util::bot_in_combat()) {
        var_00 = squared(1500 + self.tagscarried * 250);
      }

      var_01 = undefined;
      foreach(var_03 in level.var_13FC1) {
        var_04 = distancesquared(self.origin, var_03.origin);
        if(var_04 < var_00) {
          var_00 = var_04;
          var_01 = var_03;
        }
      }

      if(isDefined(var_01)) {
        var_06 = 1;
        if(self.grind_waiting_to_bank) {
          if(isDefined(self.goal_zone) && self.goal_zone == var_01) {
            var_06 = 0;
          }
        }

        if(var_06) {
          self.grind_waiting_to_bank = 1;
          self.goal_zone = var_01;
          self botclearscriptgoal();
          self notify("stop_going_to_zone");
          self notify("stop_camping_zone");
          self.conf_camping_zone = 0;
          scripts\mp\bots\_bots_personality::clear_camper_data();
          scripts\mp\bots\_bots_strategy::bot_abort_tactical_goal("kill_tag");
          childthread bot_goto_zone(var_01, "tactical");
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
      var_00 = undefined;
      var_01 = undefined;
      foreach(var_03 in level.var_13FC1) {
        var_04 = distancesquared(self.origin, var_03.origin);
        if(!isDefined(var_00) || var_04 < var_00) {
          var_00 = var_04;
          var_01 = var_03;
        }
      }

      if(isDefined(var_01)) {
        if(scripts\mp\bots\_bots_personality::should_select_new_ambush_point()) {
          if(scripts\mp\bots\_bots_personality::find_ambush_node(var_01.origin)) {
            self.conf_camping_zone = 1;
            self notify("stop_going_to_zone");
            self.grind_waiting_to_bank = 0;
            self botclearscriptgoal();
            childthread bot_camp_zone(var_01, "camp");
          } else {
            self notify("stop_camping_zone");
            self.conf_camping_zone = 0;
            scripts\mp\bots\_bots_personality::clear_camper_data();
          }
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

bot_goto_zone(param_00, param_01) {
  self endon("stop_going_to_zone");
  if(!isDefined(param_00.calculated_nearest_node)) {
    param_00.nearest_node = getclosestnodeinsight(param_00.origin);
    param_00.calculated_nearest_node = 1;
  }

  var_02 = param_00.nearest_node;
  self botsetscriptgoal(var_02.origin, 32, param_01);
  var_03 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
}

bot_camp_zone(param_00, param_01) {
  self endon("stop_camping_zone");
  self botsetscriptgoalnode(self.node_ambushing_from, param_01, self.ambush_yaw);
  var_02 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
  if(var_02 == "goal") {
    if(!isDefined(param_00.calculated_nearest_node)) {
      param_00.nearest_node = getclosestnodeinsight(param_00.origin);
      param_00.calculated_nearest_node = 1;
    }

    var_03 = param_00.nearest_node;
    if(isDefined(var_03)) {
      var_04 = findentrances(self.origin);
      var_04 = scripts\engine\utility::array_add(var_04, var_03);
      childthread scripts\mp\bots\_bots_util::bot_watch_nodes(var_04);
    }
  }
}

enemy_watcher() {
  self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");
  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") < 2) {
      wait(0.5);
    } else {
      wait(0.2);
    }

    if(isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied) && isDefined(self.isnodeoccupied.tagscarried) && self.isnodeoccupied.tagscarried >= 3 && self botcanseeentity(self.isnodeoccupied) && distance(self.origin, self.isnodeoccupied.origin) <= 500) {
      self getpassivestruct("meleeChargeDist", 500);
      self botsetflag("prefer_melee", 1);
      continue;
    }

    self getpassivestruct("meleeChargeDist", self.default_meleechargedist);
    self botsetflag("prefer_melee", 0);
  }
}