/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grind.gsc
***************************************************/

main() {
  setup_callbacks();
  _id_3CBFA0CC4EEBCC73::setup_bot_conf();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_grind_think;
}

bot_grind_think() {
  self notify("bot_grind_think");
  self endon("bot_grind_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.grind_waiting_to_bank = 0;
  self.goal_zone = undefined;
  self.conf_camping_zone = 0;
  self.additional_tactical_logic_func = ::bot_grind_extra_think;

  if(self botgetdifficultysetting("strategyLevel") > 0)
    childthread enemy_watcher();

  _id_3CBFA0CC4EEBCC73::bot_conf_think();
}

_id_3EC615A6536F891F(team) {
  return scripts\mp\gameobjects::caninteractwith(team);
}

_id_EB22FB5239067420() {
  if(self.grind_waiting_to_bank && isDefined(self.goal_zone) && !self.goal_zone _id_3EC615A6536F891F(self.team)) {
    self.grind_waiting_to_bank = 0;
    self.goal_zone = undefined;
    self notify("stop_going_to_zone");
    self botclearscriptgoal();
    return 0;
  }

  if(self.conf_camping_zone && isDefined(self._id_12E47B0891F8E76E) && !self._id_12E47B0891F8E76E _id_3EC615A6536F891F(self.team)) {
    self.conf_camping_zone = 0;
    self._id_12E47B0891F8E76E = undefined;
    self notify("stop_camping_zone");
    self botclearscriptgoal();
    scripts\mp\bots\bots_personality::clear_camper_data();
    return 0;
  }

  return 1;
}

bot_grind_extra_think() {
  if(!_id_EB22FB5239067420())
    return 1;

  if(!isDefined(self.tag_getting)) {
    if(self.tagscarried > 0) {
      _id_A52892DFFB2F5A53 = squared(500 + self.tagscarried * 250);

      if(game["teamScores"][self.team] + self.tagscarried >= level.roundscorelimit)
        _id_A52892DFFB2F5A53 = squared(5000);
      else if(!isDefined(self.enemy) && !scripts\mp\bots\bots_util::bot_in_combat())
        _id_A52892DFFB2F5A53 = squared(1500 + self.tagscarried * 250);

      _id_53388BF8BDF40A79 = undefined;

      foreach(objective in level.objectives) {
        if(!objective _id_3EC615A6536F891F(self.team)) {
          continue;
        }
        distsq = distancesquared(self.origin, objective.trigger.origin);

        if(distsq < _id_A52892DFFB2F5A53) {
          _id_A52892DFFB2F5A53 = distsq;
          _id_53388BF8BDF40A79 = objective;
        }
      }

      if(isDefined(_id_53388BF8BDF40A79)) {
        _id_52D6C7E049076154 = 1;

        if(self.grind_waiting_to_bank) {
          if(isDefined(self.goal_zone) && self.goal_zone == _id_53388BF8BDF40A79)
            _id_52D6C7E049076154 = 0;
        }

        if(_id_52D6C7E049076154) {
          self.grind_waiting_to_bank = 1;
          self.goal_zone = _id_53388BF8BDF40A79;
          self botclearscriptgoal();
          self notify("stop_going_to_zone");
          self notify("stop_camping_zone");
          self.conf_camping_zone = 0;
          scripts\mp\bots\bots_personality::clear_camper_data();
          scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("kill_tag");
          childthread bot_goto_zone(_id_53388BF8BDF40A79, "tactical");
        }
      }

      if(self.grind_waiting_to_bank) {
        if(game["teamScores"][self.team] + self.tagscarried >= level.roundscorelimit)
          self botsetflag("force_sprint", 1);

        if(self.tagscarried >= 4)
          self botsetflag("force_sprint", 1);
      }
    } else if(self.grind_waiting_to_bank) {
      self.grind_waiting_to_bank = 0;
      self.goal_zone = undefined;
      self notify("stop_going_to_zone");
      self botclearscriptgoal();
    }

    if(self.personality == "camper" && !self.conf_camping_tag && !self.grind_waiting_to_bank) {
      _id_A52892DFFB2F5A53 = undefined;
      _id_53388BF8BDF40A79 = undefined;

      foreach(objective in level.objectives) {
        if(!objective _id_3EC615A6536F891F(self.team)) {
          continue;
        }
        distsq = distancesquared(self.origin, objective.trigger.origin);

        if(!isDefined(_id_A52892DFFB2F5A53) || distsq < _id_A52892DFFB2F5A53) {
          _id_A52892DFFB2F5A53 = distsq;
          _id_53388BF8BDF40A79 = objective;
        }
      }

      if(isDefined(_id_53388BF8BDF40A79)) {
        if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
          if(scripts\mp\bots\bots_personality::find_ambush_node(_id_53388BF8BDF40A79.trigger.origin)) {
            self.conf_camping_zone = 1;
            self._id_12E47B0891F8E76E = _id_53388BF8BDF40A79;
            self notify("stop_going_to_zone");
            self.grind_waiting_to_bank = 0;
            self botclearscriptgoal();
            childthread bot_camp_zone(_id_53388BF8BDF40A79, "camp");
          } else {
            self notify("stop_camping_zone");
            self.conf_camping_zone = 0;
            scripts\mp\bots\bots_personality::clear_camper_data();
          }
        }
      } else
        self.conf_camping_zone = 1;
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

bot_goto_zone(zone, goal_type) {
  self endon("stop_going_to_zone");

  if(!isDefined(zone.calculated_nearest_node)) {
    zone.nearest_node = getclosestnodeinsight(zone.trigger.origin);
    zone.calculated_nearest_node = 1;
  }

  _id_C781AF3FAC2AA3E5 = zone.nearest_node;
  self botsetscriptgoal(_id_C781AF3FAC2AA3E5.origin, 32, goal_type);
  result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

bot_camp_zone(zone, goal_type) {
  self endon("stop_camping_zone");
  self botsetscriptgoalnode(self.node_ambushing_from, goal_type, self.ambush_yaw);
  result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(result == "goal") {
    if(!isDefined(zone.calculated_nearest_node)) {
      zone.nearest_node = getclosestnodeinsight(zone.trigger.origin);
      zone.calculated_nearest_node = 1;
    }

    _id_C781AF3FAC2AA3E5 = zone.nearest_node;

    if(isDefined(_id_C781AF3FAC2AA3E5)) {
      _id_6E99C9C93E0D0552 = findentrances(self.origin);
      _id_6E99C9C93E0D0552 = scripts\engine\utility::array_add(_id_6E99C9C93E0D0552, _id_C781AF3FAC2AA3E5);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(_id_6E99C9C93E0D0552);
    }
  }
}

enemy_watcher() {
  self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");

  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") < 2)
      wait 0.5;
    else
      wait 0.2;

    if(isDefined(self.enemy) && isPlayer(self.enemy) && isDefined(self.enemy.tagscarried) && self.enemy.tagscarried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin, self.enemy.origin) <= 500) {
      self botsetdifficultysetting("meleeChargeDist", 500);
      self botsetflag("prefer_melee", 1);
      continue;
    }

    self botsetdifficultysetting("meleeChargeDist", self.default_meleechargedist);
    self botsetflag("prefer_melee", 0);
  }
}