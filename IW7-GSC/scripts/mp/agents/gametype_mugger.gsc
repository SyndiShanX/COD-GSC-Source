/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_mugger.gsc
*************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["squadmate"]["gametype_update"] = ::agent_squadmember_mugger_think;
  level.agent_funcs["player"]["think"] = ::agent_player_mugger_think;
}

agent_player_mugger_think() {
  thread scripts\mp\bots\gametype_mugger::bot_mugger_think();
}

agent_squadmember_mugger_think() {
  if(!isDefined(self.tags_seen_by_owner)) {
    self.tags_seen_by_owner = [];
  }

  if(!isDefined(self.next_time_check_tags)) {
    self.next_time_check_tags = gettime() + 500;
  }

  if(gettime() > self.next_time_check_tags) {
    self.next_time_check_tags = gettime() + 500;
    var_0 = 0.78;
    if(isbot(self.owner)) {
      var_0 = self botgetfovdot();
    }

    var_1 = self.owner getnearestnode();
    if(isDefined(var_1)) {
      var_2 = self.owner scripts\mp\bots\gametype_mugger::bot_find_visible_tags_mugger(var_1, var_0);
      self.tags_seen_by_owner = scripts\mp\bots\gametype_conf::bot_combine_tag_seen_arrays(var_2, self.tags_seen_by_owner);
    }
  }

  self.tags_seen_by_owner = scripts\mp\bots\gametype_conf::bot_remove_invalid_tags(self.tags_seen_by_owner);
  var_3 = scripts\mp\bots\gametype_conf::bot_find_best_tag_from_array(self.tags_seen_by_owner, 0);
  if(isDefined(var_3)) {
    if(!isDefined(self.tag_getting) || distancesquared(var_3.curorigin, self.tag_getting.curorigin) > 1) {
      self.tag_getting = var_3;
      scripts\mp\bots\_bots_strategy::bot_defend_stop();
      self botsetscriptgoal(self.tag_getting.curorigin, 0, "objective", undefined, level.bot_tag_obj_radius);
    }

    return 1;
  } else if(isDefined(self.tag_getting)) {
    self botclearscriptgoal();
    self.tag_getting = undefined;
  }

  return 0;
}