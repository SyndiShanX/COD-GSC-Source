/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4bfced04a831cd7.gsc
***********************************************/

_id_B04F37F19C6631E0() {
  level.map_interaction_func = ::register_interactions;
  level.player_interaction_monitor = ::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = ::_id_FE7243424D42CD4B;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
}

register_interactions() {
  if(scripts\engine\utility::flag_exist("interactions_initialized"))
    scripts\engine\utility::flag_set("interactions_initialized");
}

_id_FE7243424D42CD4B(_id_DF071553D0996FF9) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  for(;;) {
    _id_DF071553D0996FF9.triggered = undefined;
    self.interaction_trigger waittill("trigger", player);

    if(!_id_71332A5B74214116::interaction_is_valid(_id_DF071553D0996FF9, player)) {
      continue;
    }
    _id_DF071553D0996FF9.triggered = 1;
    cost = _id_DF071553D0996FF9 _id_71332A5B74214116::interaction_get_cost();

    if(!isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type))
      level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type = "null";

    if(!_id_71332A5B74214116::can_purchase_interaction(_id_DF071553D0996FF9, cost, level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
      thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/NEED_MONEY");
      continue;
    }

    thread _id_71332A5B74214116::interaction_post_activate_delay(_id_DF071553D0996FF9);
    level notify("interaction", "purchase", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
    _id_E42F7EB456B932F2 = level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type;
    thread _id_71332A5B74214116::take_player_money(cost, _id_E42F7EB456B932F2);
    level thread[[level.interactions[_id_DF071553D0996FF9.script_noteworthy].activation_func]](_id_DF071553D0996FF9, self);
    _id_71332A5B74214116::interaction_post_activate_update(_id_DF071553D0996FF9);
    return;
  }
}

level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  _id_B755813C92F9BD4A = 5184;
  _id_925AB147F36BB977 = 9216;

  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("interactions_disabled_toggled");
      continue;
    }

    _id_A00884ED3A6D8B4B = self.origin;
    _id_AC3DC6CF8564E576 = undefined;
    _id_717FB99ADD9A6834 = sortbydistancecullbyradius(level.current_interaction_structs, _id_A00884ED3A6D8B4B, 512);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.disabled_interactions.size; _id_AC0E594AC96AA3A8++)
      _id_717FB99ADD9A6834 = scripts\engine\utility::array_remove(_id_717FB99ADD9A6834, self.disabled_interactions[_id_AC0E594AC96AA3A8]);

    if(_id_717FB99ADD9A6834.size == 0 || istrue(self.delay_hint)) {
      self notify("starting_interaction_search");
      waitframe();
      continue;
    }

    _id_4403360414478511 = _id_717FB99ADD9A6834[0];
    _id_581AED15F31BBE01 = distancesquared(_id_4403360414478511.origin, _id_A00884ED3A6D8B4B);

    if(!isDefined(_id_AC3DC6CF8564E576) && _id_581AED15F31BBE01 <= _id_B755813C92F9BD4A)
      _id_AC3DC6CF8564E576 = _id_4403360414478511;
    else if(!isDefined(_id_AC3DC6CF8564E576) && isDefined(level.should_allow_far_search_dist_func)) {
      if(_id_581AED15F31BBE01 <= _id_925AB147F36BB977)
        _id_AC3DC6CF8564E576 = _id_4403360414478511;

      if(isDefined(_id_AC3DC6CF8564E576) && ![[level.should_allow_far_search_dist_func]](_id_AC3DC6CF8564E576))
        _id_AC3DC6CF8564E576 = undefined;
    } else if(!isDefined(_id_AC3DC6CF8564E576) && isDefined(_id_4403360414478511.custom_search_dist)) {
      if(_id_581AED15F31BBE01 <= _id_4403360414478511.custom_search_dist)
        _id_AC3DC6CF8564E576 = _id_4403360414478511;
    }

    if(!isDefined(_id_AC3DC6CF8564E576) || !scripts\engine\utility::array_contains(level.current_interaction_structs, _id_AC3DC6CF8564E576) || !_id_71332A5B74214116::can_use_interaction(_id_AC3DC6CF8564E576)) {
      _id_71332A5B74214116::reset_interaction();
      continue;
    }

    if(!_id_71332A5B74214116::no_previous_interaction_point() || !_id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576) && _id_71332A5B74214116::interaction_is_button_mash(_id_AC3DC6CF8564E576) || _id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576))
      _id_71332A5B74214116::set_interaction_point(_id_AC3DC6CF8564E576);

    waitframe();
  }
}

interaction_trigger_properties(interaction_trigger, _id_DF071553D0996FF9, hintstring) {
  switch (_id_DF071553D0996FF9.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(_id_DF071553D0996FF9.useduration))
        self.interaction_trigger setuseholdduration(_id_DF071553D0996FF9.useduration);

      break;
  }
}