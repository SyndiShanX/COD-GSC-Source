/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2ecf1dd833850f15.gsc
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

_id_2C4DA055F354E414() {
  _id_A45552BF18418A18 = scripts\engine\utility::getStructArray("interact_perkbuy", "script_noteworthy");
  level._id_5ACB531A144EE0EA = [];

  foreach(struct in _id_A45552BF18418A18) {
    struct._id_53503CE20921551D = spawnscriptable("brloot_killstreak_recondrone", struct.origin, struct.angles);
    _id_66122A002AFF5D57::registerscriptableinstance(struct._id_53503CE20921551D);
    level._id_5ACB531A144EE0EA = scripts\engine\utility::array_add(level._id_5ACB531A144EE0EA, struct._id_53503CE20921551D);
  }
}

_id_FA8EF88C236732F9(interaction, player) {
  if(istrue(player.super_activated)) {
    return;
  }
  iprintln(" you got a recon drone! ");
  player.disable_super = 0;
  player.super_progress = 997;
  player _id_56EF8D52FE1B48A1::update_super_icon("role_hunter");

  if(isDefined(level._id_37BFBB27CF46666C)) {
    if(scripts\engine\utility::array_contains(level._id_37BFBB27CF46666C, interaction.crate))
      level._id_37BFBB27CF46666C = scripts\engine\utility::array_remove(level._id_37BFBB27CF46666C, interaction.crate);
  }

  if(isDefined(level.current_interaction_structs)) {
    if(scripts\engine\utility::array_contains(level.current_interaction_structs, interaction))
      level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, interaction);
  }

  if(isDefined(interaction.crate))
    interaction.crate delete();

  _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
}

_id_2300EBC51B20945A(interactions) {
  foreach(item in interactions) {
    item._id_EAECDF56E917C0A5 = 1;

    if(isDefined(item.disabled) && item.disabled == "true") {
      continue;
    }
    if(isDefined(item.perk)) {
      switch (item.perk) {
        case "perk_pack_double":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_7C8031276F931C9D", 0);
          break;
        case "perk_pack_medic":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_EE1AB6B7EFB0D21A", 0);
          break;
        case "perk_pack_mule":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_C92A1E5590157831", 0);
          break;
        case "perk_pack_buff":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_CF211C4DAC473CF1", 0);
          break;
        case "recon_drone":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_2DCCB50B405FD552", 0);
          break;
        case "perk_pack_speedy":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_1DA0785590840686", 0);
          break;
        case "perk_pack_ammo_buff":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_86854A9B1D965BDE", 0);
          break;
        case "perk_pack_armor_buff":
          item.cost = _id_780514F14B1134ED::_id_BA0EF3640498C7A4("dvar_7126EDA128806E19", 0);
          break;
      }

      item.cost = 0;
    }

    item.cost = 0;
    level thread _id_780514F14B1134ED::_id_F4C0B1158E535932(item);
  }
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
    case "snakecam_interaction":
      self.interaction_trigger setCursorHint("HINT_BUTTON");
      self.interaction_trigger sethintdisplayrange(148);
      self.interaction_trigger sethintdisplayfov(120);
      self.interaction_trigger setuserange(120);
      self.interaction_trigger setusefov(45);
      self.interaction_trigger sethintrequiresholding(1);

      if(isDefined(_id_DF071553D0996FF9.useduration))
        self.interaction_trigger setuseholdduration(_id_DF071553D0996FF9.useduration);

      break;
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(_id_DF071553D0996FF9.useduration))
        self.interaction_trigger setuseholdduration(_id_DF071553D0996FF9.useduration);

      break;
  }
}