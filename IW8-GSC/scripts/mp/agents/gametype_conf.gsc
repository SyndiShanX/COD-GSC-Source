/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_conf.gsc
***********************************************/

function main() {
  setup_callbacks();
}

function setup_callbacks() {
  level.agent_funcs["player"]["think"] = &agent_player_conf_think;
}

function agent_player_conf_think() {
  thread scripts\mp\bots\bots_gametype_conf::bot_conf_think();
}

function agent_squadmember_conf_think() {
  if(!isDefined(self.tags_seen_by_owner)) {
    self.tags_seen_by_owner = [];
  }

  if(!isDefined(self.next_time_check_tags)) {
    self.next_time_check_tags = gettime() + 500;
  }

  if(gettime() > self.next_time_check_tags) {
    self.next_time_check_tags = gettime() + 500;
    var0 = 0.78;
    var1 = self.owner getnearestnode();

    if(isDefined(var1)) {
      var2 = self.owner scripts\mp\bots\bots_gametype_conf::bot_find_visible_tags(1, var1, var0);
      self.tags_seen_by_owner = scripts\mp\bots\bots_gametype_conf::bot_combine_tag_seen_arrays(var2, self.tags_seen_by_owner);
    }
  }

  self.tags_seen_by_owner = scripts\mp\bots\bots_gametype_conf::bot_remove_invalid_tags(self.tags_seen_by_owner);
  var3 = scripts\mp\bots\bots_gametype_conf::bot_find_best_tag_from_array(self.tags_seen_by_owner, 0);

  if(isDefined(var3)) {
    if(!isDefined(self.tag_getting) || distancesquared(var3.curorigin, self.tag_getting.curorigin) > 1) {
      self.tag_getting = var3;
      scripts\mp\bots\bots_strategy::bot_defend_stop();
      self botsetscriptgoal(self.tag_getting.curorigin, 0, "objective", undefined, level.bot_tag_obj_radius);
    }

    return true;
  } else if(isDefined(self.tag_getting)) {
    self botclearscriptgoal();
    self.tag_getting = undefined;
  }

  return false;
}