/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_conf.gsc
**************************************************/

main() {
  setup_callbacks();
  setup_bot_conf();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_conf_think;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    level.bot_funcs["player_spawned_gamemode"] = _id_27FDECE778E999D8::_id_5F51C5C13FD2911B;
    level.modifyplayerdamage = _id_27FDECE778E999D8::modifyplayerdamage;
  }
}

setup_bot_conf() {
  level.bot_tag_obj_radius = 200;
  level.bot_tag_allowable_jump_height = 38;
}

bot_conf_think() {
  self notify("bot_conf_think");
  self endon("bot_conf_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.next_time_check_tags = gettime() + 500;
  self.tags_seen = [];
  childthread bot_watch_new_tags();

  if(self.personality == "camper") {
    self.conf_camper_camp_tags = 0;

    if(!isDefined(self.conf_camping_tag))
      self.conf_camping_tag = 0;
  }

  for(;;) {
    _id_F83D156646E96C13 = isDefined(self.tag_getting);
    _id_E837092CD1910147 = 0;

    if(_id_F83D156646E96C13 && self bothasscriptgoal()) {
      _id_4CBD8AE83804749C = self botgetscriptgoal();

      if(scripts\mp\bots\bots_util::bot_vectors_are_equal(self.tag_getting.ground_pos, _id_4CBD8AE83804749C)) {
        if(self botpursuingscriptgoal())
          _id_E837092CD1910147 = 1;
      } else if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("kill_tag") && self.tag_getting bot_can_tag_interact_with(self.team)) {
        self.tag_getting = undefined;
        _id_F83D156646E96C13 = 0;
      }
    }

    self botsetflag("force_sprint", _id_E837092CD1910147);
    self.tags_seen = bot_remove_invalid_tags(self.tags_seen);
    _id_CCF8545877C9624C = bot_find_best_tag_from_array(self.tags_seen, 1);
    _id_AE54FAFD5CD89C6F = isDefined(_id_CCF8545877C9624C);

    if(_id_F83D156646E96C13 && !_id_AE54FAFD5CD89C6F || !_id_F83D156646E96C13 && _id_AE54FAFD5CD89C6F || _id_F83D156646E96C13 && _id_AE54FAFD5CD89C6F && self.tag_getting != _id_CCF8545877C9624C) {
      self.tag_getting = _id_CCF8545877C9624C;
      self botclearscriptgoal();
      self notify("stop_camping_tag");
      scripts\mp\bots\bots_personality::clear_camper_data();
      scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("kill_tag");
    }

    if(isDefined(self.tag_getting)) {
      self.conf_camping_tag = 0;

      if(self.personality == "camper" && self.conf_camper_camp_tags) {
        self.conf_camping_tag = 1;

        if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
          if(scripts\mp\bots\bots_personality::find_ambush_node(self.tag_getting.ground_pos, 1000))
            childthread bot_camp_tag(self.tag_getting, "camp");
          else
            self.conf_camping_tag = 0;
        }
      }

      if(!self.conf_camping_tag) {
        if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal("kill_tag")) {
          _id_4F3B05E382BB8C7C = spawnStruct();
          _id_4F3B05E382BB8C7C.script_goal_type = "objective";
          _id_4F3B05E382BB8C7C.objective_radius = level.bot_tag_obj_radius;
          _id_4F3B05E382BB8C7C.short_term_goal = 1;
          scripts\mp\bots\bots_strategy::bot_new_tactical_goal("kill_tag", self.tag_getting.ground_pos, 25, _id_4F3B05E382BB8C7C);
        }
      }
    }

    _id_D59062EEFB2AA6C7 = 0;

    if(isDefined(self.additional_tactical_logic_func))
      _id_D59062EEFB2AA6C7 = self[[self.additional_tactical_logic_func]]();

    if(!isDefined(self.tag_getting)) {
      if(!_id_D59062EEFB2AA6C7)
        self[[self.personality_update_function]]();
    }

    if(gettime() > self.next_time_check_tags) {
      self.next_time_check_tags = gettime() + 500;
      _id_0633DF63ACC65980 = bot_find_visible_tags(1);
      self.tags_seen = bot_combine_tag_seen_arrays(_id_0633DF63ACC65980, self.tags_seen);
    }

    wait 0.05;
  }
}

bot_can_tag_interact_with(team) {
  return scripts\mp\gameobjects::caninteractwith(team);
}

bot_check_tag_above_head(tag) {
  if(isDefined(tag.on_path_grid) && tag.on_path_grid) {
    _id_2C356F94BA57B868 = self.origin + (0, 0, 55);

    if(distance2dsquared(tag.curorigin, _id_2C356F94BA57B868) < 144) {
      _id_1B3D39D8C4D20E13 = tag.curorigin[2] - _id_2C356F94BA57B868[2];

      if(_id_1B3D39D8C4D20E13 > 0) {
        if(_id_1B3D39D8C4D20E13 < level.bot_tag_allowable_jump_height) {
          if(!isDefined(self.last_time_jumped_for_tag))
            self.last_time_jumped_for_tag = 0;

          if(gettime() - self.last_time_jumped_for_tag > 3000) {
            self.last_time_jumped_for_tag = gettime();
            thread bot_jump_for_tag();
          }
        } else {
          tag.on_path_grid = 0;
          return 1;
        }
      }
    }
  }

  return 0;
}

bot_jump_for_tag() {
  self endon("death_or_disconnect");
  self botsetstance("stand");
  wait 1.0;
  self botpressbutton("jump");
  wait 1.0;
  self botsetstance("none");
}

bot_watch_new_tags() {
  for(;;) {
    level waittill("new_tag_spawned", _id_34744859AD58739B);
    level thread _id_03CFDF1926A55423(self, _id_34744859AD58739B);
  }
}

_id_50335C9C24555A07(_id_33250BFCEE56A30C) {
  if(isDefined(_id_33250BFCEE56A30C.on_path_grid))
    return 0;

  if(istrue(_id_33250BFCEE56A30C.calculations_in_progress))
    return 0;

  if(istrue(_id_33250BFCEE56A30C._id_7454869824E72AAE))
    return 0;

  return 1;
}

_id_03CFDF1926A55423(bot, _id_34744859AD58739B) {
  bot.next_time_check_tags = -1;

  if(isDefined(_id_34744859AD58739B)) {
    if(isDefined(_id_34744859AD58739B.victim) && _id_34744859AD58739B.victim == bot || isDefined(_id_34744859AD58739B.attacker) && _id_34744859AD58739B.attacker == bot) {
      if(_id_50335C9C24555A07(_id_34744859AD58739B)) {
        thread calculate_tag_on_path_grid(_id_34744859AD58739B);
        waittill_tag_calculated_on_path_grid(_id_34744859AD58739B);

        if(_id_34744859AD58739B.on_path_grid) {
          _id_3B8D413A4FF237F2 = spawnStruct();
          _id_3B8D413A4FF237F2.origin = _id_34744859AD58739B.curorigin;
          _id_3B8D413A4FF237F2.tag = _id_34744859AD58739B;
          _id_7F1569AB4F7F444C[0] = _id_3B8D413A4FF237F2;
          bot.tags_seen = bot_combine_tag_seen_arrays(_id_7F1569AB4F7F444C, bot.tags_seen);
        }
      }
    }
  }
}

bot_combine_tag_seen_arrays(_id_E4246E2D10D3E0F6, _id_6E63B48E5D296BCF) {
  _id_055F75D9F16D814F = _id_6E63B48E5D296BCF;

  foreach(_id_1A50868191B289F6 in _id_E4246E2D10D3E0F6) {
    _id_61C41E18E75C6639 = 0;

    foreach(_id_74C62AC42E6DABDD in _id_6E63B48E5D296BCF) {
      if(_id_1A50868191B289F6.tag == _id_74C62AC42E6DABDD.tag && scripts\mp\bots\bots_util::bot_vectors_are_equal(_id_1A50868191B289F6.origin, _id_74C62AC42E6DABDD.origin)) {
        _id_61C41E18E75C6639 = 1;
        break;
      }
    }

    if(!_id_61C41E18E75C6639)
      _id_055F75D9F16D814F = scripts\engine\utility::array_add(_id_055F75D9F16D814F, _id_1A50868191B289F6);
  }

  return _id_055F75D9F16D814F;
}

bot_is_tag_visible(tag, _id_6006B119331919F9, _id_DCFEB62751BA5687) {
  if(_id_50335C9C24555A07(tag))
    thread calculate_tag_on_path_grid(tag);

  if(isDefined(tag.calculations_in_progress))
    return 0;

  if(!istrue(tag.on_path_grid))
    return 0;

  if(!tag.calculated_nearest_node) {
    tag.nearest_node = getclosestnodeinsight(tag.curorigin);
    tag.calculated_nearest_node = 1;
  }

  _id_BC2D0E37A05C27AD = tag.nearest_node;
  _id_87E39AA5A218A99F = !isDefined(tag.on_path_grid);

  if(isDefined(_id_BC2D0E37A05C27AD) && (_id_87E39AA5A218A99F || tag.on_path_grid)) {
    _id_CA35F8FFD9993B54 = _id_BC2D0E37A05C27AD == _id_6006B119331919F9 || nodesvisible(_id_BC2D0E37A05C27AD, _id_6006B119331919F9, 1);

    if(_id_CA35F8FFD9993B54) {
      node_within_fov = scripts\engine\utility::within_fov(self.origin, self getplayerangles(), tag.curorigin, _id_DCFEB62751BA5687);

      if(node_within_fov)
        return 1;
    }
  }

  return 0;
}

bot_find_visible_tags(_id_0F7589B807692205, _id_900C3A9D222406B8, _id_3C558339662942BC) {
  _id_6006B119331919F9 = undefined;

  if(isDefined(_id_900C3A9D222406B8))
    _id_6006B119331919F9 = _id_900C3A9D222406B8;
  else
    _id_6006B119331919F9 = self getnearestnode();

  _id_DCFEB62751BA5687 = undefined;

  if(isDefined(_id_3C558339662942BC))
    _id_DCFEB62751BA5687 = _id_3C558339662942BC;
  else
    _id_DCFEB62751BA5687 = self botgetfovdot();

  _id_4945A57591980FBF = [];

  if(isDefined(_id_6006B119331919F9) && isDefined(level.dogtags)) {
    foreach(tag in level.dogtags) {
      if(tag bot_can_tag_interact_with(self.team)) {
        _id_D09A5313B6DDB5C3 = 0;

        if(!_id_0F7589B807692205 || isDefined(tag.attacker) && tag.attacker == self || isDefined(tag.victim) && tag.victim == self) {
          if(_id_50335C9C24555A07(tag)) {
            level thread calculate_tag_on_path_grid(tag);
            waittill_tag_calculated_on_path_grid(tag);
            _id_D09A5313B6DDB5C3 = tag.on_path_grid;
          }
        } else if(bot_is_tag_visible(tag, _id_6006B119331919F9, _id_DCFEB62751BA5687))
          _id_D09A5313B6DDB5C3 = 1;

        if(_id_D09A5313B6DDB5C3) {
          _id_3B8D413A4FF237F2 = spawnStruct();
          _id_3B8D413A4FF237F2.origin = tag.curorigin;
          _id_3B8D413A4FF237F2.tag = tag;
          _id_4945A57591980FBF = scripts\engine\utility::array_add(_id_4945A57591980FBF, _id_3B8D413A4FF237F2);
        }
      }
    }
  }

  return _id_4945A57591980FBF;
}

calculate_tag_on_path_grid(tag) {
  tag endon("reset");
  tag.calculations_in_progress = 1;
  tag.on_path_grid = scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(tag.curorigin, 16, level.bot_tag_allowable_jump_height + 55);

  if(tag.on_path_grid) {
    tag.ground_pos = getgroundposition(tag.curorigin, 0, 256, 32);

    if(!isDefined(tag.ground_pos))
      tag.on_path_grid = 0;
  }

  tag.calculations_in_progress = undefined;
}

waittill_tag_calculated_on_path_grid(tag) {
  while(!isDefined(tag.on_path_grid))
    wait 0.05;
}

bot_find_best_tag_from_array(_id_7E8D29067DADEE25, _id_FCB9461BB8ED3B2A) {
  _id_CCF8545877C9624C = undefined;

  if(_id_7E8D29067DADEE25.size > 0) {
    _id_7E67551412C990AA = 9999800001;

    foreach(_id_056D33A84C0B53E1 in _id_7E8D29067DADEE25) {
      _id_93B8FC938F87C60E = get_num_allies_getting_tag(_id_056D33A84C0B53E1.tag);

      if(!_id_FCB9461BB8ED3B2A || _id_93B8FC938F87C60E < 2) {
        _id_F8A769E6C932E890 = distancesquared(_id_056D33A84C0B53E1.tag.ground_pos, self.origin);

        if(_id_F8A769E6C932E890 < _id_7E67551412C990AA) {
          _id_CCF8545877C9624C = _id_056D33A84C0B53E1.tag;
          _id_7E67551412C990AA = _id_F8A769E6C932E890;
        }
      }
    }
  }

  return _id_CCF8545877C9624C;
}

bot_remove_invalid_tags(tags) {
  _id_FBE22143F559F27F = [];

  foreach(_id_056D33A84C0B53E1 in tags) {
    if(!isDefined(_id_056D33A84C0B53E1.tag.on_path_grid)) {
      continue;
    }
    if(_id_056D33A84C0B53E1.tag bot_can_tag_interact_with(self.team) && scripts\mp\bots\bots_util::bot_vectors_are_equal(_id_056D33A84C0B53E1.tag.curorigin, _id_056D33A84C0B53E1.origin)) {
      if(!bot_check_tag_above_head(_id_056D33A84C0B53E1.tag))
        _id_FBE22143F559F27F = scripts\engine\utility::array_add(_id_FBE22143F559F27F, _id_056D33A84C0B53E1);
    }
  }

  return _id_FBE22143F559F27F;
}

get_num_allies_getting_tag(tag) {
  num = 0;

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(player.team == self.team && player != self) {
      if(isai(player)) {
        if(isDefined(player.tag_getting) && player.tag_getting == tag)
          num++;

        continue;
      }

      if(distancesquared(player.origin, tag.curorigin) < 160000)
        num++;
    }
  }

  return num;
}

bot_camp_tag(tag, goal_type, _id_93EE2CC09F74798E) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");

  if(isDefined(_id_93EE2CC09F74798E))
    self endon(_id_93EE2CC09F74798E);

  self botsetscriptgoalnode(self.node_ambushing_from, goal_type, self.ambush_yaw);
  result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(result == "goal") {
    _id_BC2D0E37A05C27AD = tag.nearest_node;

    if(isDefined(_id_BC2D0E37A05C27AD)) {
      _id_6E99C9C93E0D0552 = findentrances(self.origin);
      _id_6E99C9C93E0D0552 = scripts\engine\utility::array_add(_id_6E99C9C93E0D0552, _id_BC2D0E37A05C27AD);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(_id_6E99C9C93E0D0552);
    }
  }
}