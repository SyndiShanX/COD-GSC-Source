/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_conf.gsc
***********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["player"]["think"] = ::agent_player_conf_think;
}

agent_player_conf_think() {
  thread _id_3CBFA0CC4EEBCC73::bot_conf_think();
}

agent_squadmember_conf_think() {
  if(!isDefined(self.tags_seen_by_owner))
    self.tags_seen_by_owner = [];

  if(!isDefined(self.next_time_check_tags))
    self.next_time_check_tags = gettime() + 500;

  if(gettime() > self.next_time_check_tags) {
    self.next_time_check_tags = gettime() + 500;
    _id_A2A0DF6E53502476 = 0.78;
    _id_700708E8E4A826A6 = self.owner getnearestnode();

    if(isDefined(_id_700708E8E4A826A6)) {
      _id_78A5FA87CED302E4 = self.owner _id_3CBFA0CC4EEBCC73::bot_find_visible_tags(1, _id_700708E8E4A826A6, _id_A2A0DF6E53502476);
      self.tags_seen_by_owner = _id_3CBFA0CC4EEBCC73::bot_combine_tag_seen_arrays(_id_78A5FA87CED302E4, self.tags_seen_by_owner);
    }
  }

  self.tags_seen_by_owner = _id_3CBFA0CC4EEBCC73::bot_remove_invalid_tags(self.tags_seen_by_owner);
  _id_CCF8545877C9624C = _id_3CBFA0CC4EEBCC73::bot_find_best_tag_from_array(self.tags_seen_by_owner, 0);

  if(isDefined(_id_CCF8545877C9624C)) {
    if(!isDefined(self.tag_getting) || distancesquared(_id_CCF8545877C9624C.curorigin, self.tag_getting.curorigin) > 1) {
      self.tag_getting = _id_CCF8545877C9624C;
      scripts\mp\bots\bots_strategy::bot_defend_stop();
      self botsetscriptgoal(self.tag_getting.curorigin, 0, "objective", undefined, level.bot_tag_obj_radius);
    }

    return 1;
  } else if(isDefined(self.tag_getting)) {
    self botclearscriptgoal();
    self.tag_getting = undefined;
  }

  return 0;
}