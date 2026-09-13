/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_65ca1841764c00ca.gsc
***********************************************/

register_interactions() {
  level.interaction_hintstrings["cash_bag"] = &"CP_WEAPON_BUY/PICKUP_CASH";
  _id_71332A5B74214116::registerinteraction("cash_bag", undefined, ::_id_6D4710562E44DABF, ::_id_77682E14F54F8036);
  level thread _id_780514F14B1134ED::_id_2C4DA055F354E414();
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

    if(_id_71332A5B74214116::interaction_is_weapon_buy(_id_DF071553D0996FF9)) {
      _id_DE88CD14114C1E24 = _id_DF071553D0996FF9.weapon;
      _id_27E046998BAC14DC = 0;
      _id_BC002676438672C9 = self.primaryweapons;

      foreach(weapon in _id_BC002676438672C9) {
        if(issubstr(weapon.basename, _id_DF071553D0996FF9.weapon))
          _id_27E046998BAC14DC = 1;
      }

      if(self hasweapon(_id_DE88CD14114C1E24) || _id_27E046998BAC14DC) {
        _id_8529009219E1AD48 = scripts\cp\utility::_id_ED18A118C6FA5C4F(_id_DF071553D0996FF9.weapon);
        _id_629F6083F99F1D29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
        _id_DB6891EE5A14D7AA = int(_id_629F6083F99F1D29 * _id_8529009219E1AD48);
        _id_0DE8A9EAD75A0581 = self getweaponammostock(_id_DE88CD14114C1E24);

        if(_id_0DE8A9EAD75A0581 >= _id_DB6891EE5A14D7AA) {
          level notify("interaction", "purchase_denied", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
          _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/AMMO_MAXED");
          continue;
        }

        cost = 400;
      }
    }

    if(interaction_is_perk(_id_DF071553D0996FF9)) {
      if(_id_4C99D5F08C48ED71::_id_8F03ACC557E2B610(_id_DF071553D0996FF9.perk)) {
        _id_4C99D5F08C48ED71::_id_7175C0FBCE3FED06(_id_DF071553D0996FF9.perk);
        scripts\engine\utility::delaythread(1, _id_71332A5B74214116::refresh_interaction);
        continue;
      }
    }

    if(_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) && _id_DF071553D0996FF9.equipment == "ammo") {
      _id_88B230F00C4A879C = 0;
      _id_FC926ACE38663F0F = 1;

      foreach(weapon in self.weaponlist) {
        if(!issubstr(weapon.basename, "fists")) {
          _id_7FC9076882EE98FF = weaponclipsize(weapon);
          _id_D7732D0238EAE9FF = scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon);
          clip_ammo = self getweaponammoclip(weapon);
          stock_ammo = self getweaponammostock(weapon);

          if(clip_ammo < _id_7FC9076882EE98FF || stock_ammo < _id_D7732D0238EAE9FF)
            _id_88B230F00C4A879C = 1;

          _id_FC926ACE38663F0F = 0;
        }
      }

      if(_id_FC926ACE38663F0F) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/AMMO_NO_WEAPON");
        continue;
      }

      if(!_id_88B230F00C4A879C) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/AMMO_FULL");
        continue;
      }
    }

    if(_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) && _id_DF071553D0996FF9.equipment == "self_revive") {
      if(istrue(self.has_auto_revive)) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/ALREADY_EQUIPPED");
        continue;
      }
    }

    if(_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) && _id_DF071553D0996FF9.equipment == "halligan") {
      if(istrue(self._id_1FD57894D3F63B70)) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/ALREADY_EQUIPPED");
        continue;
      }
    }

    if(_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) && _id_DF071553D0996FF9.equipment == "armor") {
      if(!player _id_780514F14B1134ED::_id_E5E0E7F1B9395A63()) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/ALREADY_EQUIPPED");
        continue;
      }
    }

    if(_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) && _id_DF071553D0996FF9.equipment == "gasmask") {
      if(isDefined(self.gasmaskhealth) && self.gasmaskhealth > 0) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/ALREADY_EQUIPPED");
        continue;
      }
    }

    if(_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) && _id_DF071553D0996FF9.equipment == "c4_inc_breach") {
      if(isDefined(self._id_ECDAD53F119BE384) && self._id_ECDAD53F119BE384 > 0) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/ALREADY_EQUIPPED");
        continue;
      }
    }

    if(_id_97A4F62DD622262F(_id_DF071553D0996FF9)) {
      _id_7BADD061F9CA39AB = 0;

      foreach(player in level.players) {
        if(isDefined(player._id_2A376311C6E39314))
          _id_7BADD061F9CA39AB = _id_7BADD061F9CA39AB + 1;
      }

      if(_id_7BADD061F9CA39AB == 0) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"CP_WEAPON_BUY/RESPAWN_NOT_AVAILABLE");
        continue;
      }
    }

    if(_id_82E1EFAD16F5EB93(_id_DF071553D0996FF9)) {
      if(!isDefined(level._id_E9922F45DB5AE222)) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/CANNOT_BUY");
        continue;
      } else if(!istrue(level._id_CC94777AC6E61971)) {
        _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/CANNOT_BUY");
        continue;
      } else {
        amount = level._id_E9922F45DB5AE222 * 25;

        foreach(_id_5ECABDFE40A96663 in level.players)
        _id_5ECABDFE40A96663 thread _id_3BCAA2CBAF54ABDD::give_player_currency(amount, "large");

        level notify("interaction_skiptimer");
        self.interaction_trigger setHintString(&"CP_WEAPON_BUY/SKIPTIMER_DISPLAY");
      }

      continue;
    }

    if(!_id_71332A5B74214116::can_purchase_interaction(_id_DF071553D0996FF9, cost, level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
      thread _id_166B4F052DA169A7::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/NEED_MONEY");
      continue;
    }

    if(interaction_is_perk(_id_DF071553D0996FF9)) {
      if(_id_DF071553D0996FF9.perk != "perk_pack_double" && _id_DF071553D0996FF9.perk != "recon_drone") {
        if(_id_4C99D5F08C48ED71::_id_F82E41138806E225()) {
          _id_B8237431C9AA7E36 = 1;
          _id_4C99D5F08C48ED71::_id_47AE9E67FAFC2FC4(_id_B8237431C9AA7E36, _id_DF071553D0996FF9.perk);
        }
      } else if(_id_4C99D5F08C48ED71::_id_3CF76F4DAB9DC93C() && _id_DF071553D0996FF9.perk != "recon_drone") {
        _id_B8237431C9AA7E36 = 1;
        _id_4C99D5F08C48ED71::_id_47AE9E67FAFC2FC4(_id_B8237431C9AA7E36, _id_DF071553D0996FF9.perk);
      }
    }

    level thread[[level.interactions[_id_DF071553D0996FF9.script_noteworthy].activation_func]](_id_DF071553D0996FF9, self);

    if(!_id_71332A5B74214116::interaction_is_weapon_buy(_id_DF071553D0996FF9))
      thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");

    thread _id_71332A5B74214116::interaction_post_activate_delay(_id_DF071553D0996FF9);
    return;
  }
}

interaction_is_perk(_id_DF071553D0996FF9) {
  return isDefined(_id_DF071553D0996FF9.perk);
}

_id_97A4F62DD622262F(_id_DF071553D0996FF9, player) {
  return isDefined(_id_DF071553D0996FF9.respawn);
}

_id_0D04BB26C07C5F07(_id_DF071553D0996FF9) {
  return isDefined(_id_DF071553D0996FF9.equipment);
}

_id_82E1EFAD16F5EB93(_id_DF071553D0996FF9) {
  return isDefined(_id_DF071553D0996FF9._id_5C1D52079171649F);
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
      _id_7F0C6C1DA2C42B0B();
      waitframe();
      continue;
    }

    if(!_id_71332A5B74214116::no_previous_interaction_point() || !_id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576) && _id_71332A5B74214116::interaction_is_button_mash(_id_AC3DC6CF8564E576) || _id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576)) {
      if(isDefined(_id_AC3DC6CF8564E576.crate) && isDefined(_id_AC3DC6CF8564E576.crate._id_9226858A27AFACED) && _id_AC3DC6CF8564E576.crate._id_9226858A27AFACED > 0) {
        self setclientomnvar("ui_cp_interaction_card", 0);
        waitframe();
        continue;
      }

      _id_3D03E6F305E67AF6(_id_AC3DC6CF8564E576);
      _id_71332A5B74214116::set_interaction_point(_id_AC3DC6CF8564E576);
    }

    waitframe();
  }
}

_id_7F0C6C1DA2C42B0B() {
  _id_71332A5B74214116::reset_interaction();
  self setclientomnvar("ui_cp_interaction_card", 0);
}

_id_3D03E6F305E67AF6(_id_DF071553D0996FF9) {
  self setclientomnvar("ui_cp_interaction_card", 0);
  omnvar = 0;
  ref = _id_780514F14B1134ED::_id_E5C72EB75BED9EB9(_id_DF071553D0996FF9);

  if(isDefined(ref) && ref != "" && isDefined(level._id_DD1B9D6AEC9585D7[ref]) && isDefined(level._id_DD1B9D6AEC9585D7[ref].omnvar))
    omnvar = level._id_DD1B9D6AEC9585D7[ref].omnvar;

  self setclientomnvar("ui_cp_interaction_card", omnvar);
}

_id_77682E14F54F8036(interaction, player) {
  if(interaction.size > 0)
    level.interactions[interaction[0].script_noteworthy].cost = 0;
}

_id_6D4710562E44DABF(interaction, player) {
  amount = int(getEnt(interaction.target, "targetname").struct.amount);
  player _id_3BCAA2CBAF54ABDD::set_player_currency(amount);
  player playlocalsound("weap_pickup");
  _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);
}