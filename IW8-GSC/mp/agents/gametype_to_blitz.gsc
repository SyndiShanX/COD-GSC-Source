/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\gametype_to_blitz.gsc
***********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_B672066D30FF90B7"] = ::agent_player_blitz_think;
}

agent_player_blitz_think() {
  thread _encstr_BA972B0FFE402973EC409A77E3028DA243F32792A2710A892740CD8DAB9B53FB19C5CFBF1BB19BA313F251C746::bot_blitz_think();
}

agent_squadmember_blitz_think() {
  if(!isDefined(self.tags_seen_by_owner))
    self.tags_seen_by_owner = [];

  if(!isDefined(self.next_time_check_tags))
    self.next_time_check_tags = gettime() + 500;

  if(gettime() > self.next_time_check_tags) {
    self.next_time_check_tags = gettime() + 500;
    var_0 = 0.78;
    var_1 = self.owner getnearestnode();

    if(isDefined(var_1)) {
      var_2 = self.owner _encstr_BA972B0FFE402973EC409A77E3028DA243F32792A2710A892740CD8DAB9B53FB19C5CFBF1BB19BA313F251C746::bot_find_visible_tags(1, var_1, var_0);
      self.tags_seen_by_owner = _encstr_BA972B0FFE402973EC409A77E3028DA243F32792A2710A892740CD8DAB9B53FB19C5CFBF1BB19BA313F251C746::bot_combine_tag_seen_arrays(var_2, self.tags_seen_by_owner);
    }
  }

  self.tags_seen_by_owner = _encstr_BA972B0FFE402973EC409A77E3028DA243F32792A2710A892740CD8DAB9B53FB19C5CFBF1BB19BA313F251C746::bot_remove_invalid_tags(self.tags_seen_by_owner);
  var_3 = _encstr_BA972B0FFE402973EC409A77E3028DA243F32792A2710A892740CD8DAB9B53FB19C5CFBF1BB19BA313F251C746::bot_find_best_tag_from_array(self.tags_seen_by_owner, 0);

  if(isDefined(var_3)) {
    if(!isDefined(self.tag_getting) || distancesquared(var_3.curorigin, self.tag_getting.curorigin) > 1) {
      self.tag_getting = var_3;
      scripts\mp\bots\bots_strategy::bot_defend_stop();
      self botsetscriptgoal(self.tag_getting.curorigin, 0, "_encstr_9A2B0A12F03587575B7BBEA5", undefined, level.bot_tag_obj_radius);
    }

    return 1;
  } else if(isDefined(self.tag_getting)) {
    self botclearscriptgoal();
    self.tag_getting = undefined;
  }

  return 0;
}