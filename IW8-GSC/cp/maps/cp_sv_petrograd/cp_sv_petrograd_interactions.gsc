/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_petrograd\cp_sv_petrograd_interactions.gsc
********************************************************************/

register_interactions() {
  if(isDefined(level.escape_interaction_registration_func))
    [[level.escape_interaction_registration_func]]();

  level thread _id_1230D();

  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_set("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
}

wallbuyinteractions() {
  var_0 = 0;

  if(isDefined(level.cp_weapontable))
    var_1 = level.cp_weapontable;
  else
    var_1 = "_encstr_A34A16F19B26261059FF4BBB70BD2875C712A8B9E67F6678";

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 2);

    if(issubstr(var_3, "_encstr_AFF605A3F9E16B")) {
      var_4 = tablelookupbyrow(var_1, var_0, 1);
      var_5 = int(tablelookupbyrow(var_1, var_0, 3));
      level.interaction_hintstrings[var_4] = &"_encstr_B24A1F2FA1CE72F8B5986CD565D341311529BF97C9A7CFD0A3B3E19BC50399F71C";
      scripts\cp\cp_interaction::register_interaction(var_4, "_encstr_ABDD094B1109F39158BB21", undefined, scripts\cp\cp_wall_buys::get_wall_buy_hint_func, scripts\cp\cp_wall_buys::interaction_purchase_weapon, var_5);
    }

    var_0++;
  }
}

level_specific_wait_for_interaction_triggered(var_0) {
  self notify("_encstr_A24D1ABB18955F0333D79BB88F50A9192DB1179109DBD3A60BCC398B");
  self endon("_encstr_A24D1ABB18955F0333D79BB88F50A9192DB1179109DBD3A60BCC398B");
  self endon("_encstr_A3F4170B23DF67A10C3EA18B4A76382DAF0A20360A0714D8A6");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self.interaction_trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\cp\cp_interaction::interaction_is_valid(var_0, var_1)) {
      wait 0.1;
      continue;
    }

    var_0.triggered = 1;
    var_0 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    var_2 = level.interactions[var_0.script_noteworthy].cost;

    if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type))
      level.interactions[var_0.script_noteworthy].spend_type = "_encstr_A3BA05E0735C50";

    if(isDefined(level.interactions[var_0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var_0.script_noteworthy].can_use_override_func]](var_0, var_1)) {
        wait 0.1;
        continue;
      }
    } else if(var_0.script_noteworthy == "_encstr_8BF90F08C8309309F9B85B07F270807D78") {
      if(!istrue(self.have_things_in_lost_and_found)) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != var_0) {
        wait 0.1;
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || istrue(level.only_one_player))
        var_2 = 0;
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(var_0)) {
      if(scripts\cp\utility::is_codxp()) {
        wait 0.1;
        continue;
      }

      var_3 = var_1 getcurrentweapon();
      level.prevweapon = var_1 getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);

      if(istrue(var_1.has_zis_soul_key) || istrue(level.placed_alien_fuses)) {
        if(var_4 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_8659206615306156F18B0989D3D1EDD1F88D6896E549A91DB2CF91B1FF25658140E7");
          wait 0.1;
          continue;
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_B63B288682FA969A21AF9493A8514A0586A829F49C4D79550AA3290A11A2FAAB8A28057A93BE320A2513");
          wait 0.1;
          continue;
        }
      } else if(var_4 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_8659206615306156F18B0989D3D1EDD1F88D6896E549A91DB2CF91B1FF25658140E7");
        wait 0.1;
        continue;
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_B63B288682FA969A21AF9493A8514A0586A829F49C4D79550AA3290A11A2FAAB8A28057A93BE320A2513");
        wait 0.1;
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait 0.1;
        continue;
      }

      var_5 = var_1 getcurrentweapon();
      var_6 = scripts\cp\utility::getbaseweaponname(var_5);

      if(scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(var_0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_854D18D07AE941D7740AA9A2FA41260A655E50359AF4D7350A16");
          wait 0.1;
          continue;
        } else {
          var_7 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
          var_4 = scripts\cp\cp_weapon::get_weapon_level(var_7);

          if(var_4 > 1)
            var_2 = 4500;
          else
            var_2 = var_2 * 0.5;
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(var_0)) {
      if(!var_1 scripts\cp\cp_interaction::can_use_perk(var_0))
        var_2 = 0;
      else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0.perk_type == "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863" && var_1.self_revives_purchased <= var_1.max_self_revive_machine_use) {
        var_2 = 500;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("_encstr_BA3A1A79E7E2FF696F2290B7208340EAEF408A155F2BCA319BFF9560", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_BE19041BDEDD", 10, 0, 1, 0, 40);
      } else
        var_2 = scripts\cp\cp_interaction::get_perk_machine_cost(var_0);
    } else if(scripts\cp\cp_interaction::interaction_is_crafting_station(var_0)) {
      if(!isDefined(var_1.current_crafting_struct) && var_0.available_ingredient_slots > 0) {
        level notify("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_82011013D3A0A7DBC123AD58912708537DF9", level.interactions[var_0.script_noteworthy], self);
        wait 0.1;
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(var_0)) {
      if(var_1.card_refills == 2) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_965126A1E97A28AF9472A851495034A292D39335F272D3D7A9E9942A7D345094116AF57AD5C9A211");
        wait 0.1;
        continue;
      }

      if(self.card_refills == 1)
        var_2 = level.fortune_visit_cost_2;
      else
        var_2 = level.fortune_visit_cost_1;
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var_0, var_2, level.interactions[var_0.script_noteworthy].spend_type)) {
      level notify("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_82011013D3A0A7DBC123AD58912708537DF9", level.interactions[var_0.script_noteworthy], self);

      if(var_0.script_parameters == "_encstr_AD0D0879F956D035534B") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_9AFB217519673A799E579365A4B7496FCFF18C7C603FC8396765814F8CECB9227F0947");
        thread scripts\cp\cp_vo::try_to_play_vo("_encstr_97430BFD889914CAE687DF93DF", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var_0) && var_0.perk_type == "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863" && var_1.self_revives_purchased >= var_1.max_self_revive_machine_use)
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_BEC929853DBF7158683BA19B53308E990185AC1F4DDBA19830D7A9A73B19CB79F3EF5435C91249AC388B73");
      else {
        thread scripts\cp\cp_vo::try_to_play_vo("_encstr_81D808B9EDAF36853786", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_971E1D9B5F7759C991AD01CFDA5B4D732CD8312E6A46B98F71B7218F709DD9");
      }

      wait 0.1;
      continue;
    }

    if(var_0.script_noteworthy == "_encstr_91E90FB08EDA7D772D8E4319E42CBB58D8") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"_encstr_971E1D9B5F7759C991AD01CFDA5B4D732CD8312E6A46B98F71B7218F709DD9");
          wait 0.1;
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(var_0);

    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0))
      level notify("_encstr_81010C2D9BE8B29C0B8D1D2DED37", var_0.name, undefined, self);
    else
      level notify("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_A36F09E0AEE4C634B06EB2", level.interactions[var_0.script_noteworthy], self);

    var_8 = level.interactions[var_0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_2, var_8);
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
    var_0.triggered = undefined;
    return;
  }
}

level_specific_player_interaction_monitor() {
  self notify("_encstr_82991BC39DB8B81960CF9B2853EB7079BFA47095051120D2E0B35B370B");
  self endon("_encstr_82991BC39DB8B81960CF9B2853EB7079BFA47095051120D2E0B35B370B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 5184;
  var_1 = 9216;
  var_2 = 2304;

  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("_encstr_A5731E79C8C9074E1B5654AB6FA8F31F238B3F13F67272BBC905486204D05F1A");
      continue;
    }

    var_4 = undefined;
    var_5 = sortbydistance(level.current_interaction_structs, self.origin);

    foreach(var_7 in self.disabled_interactions)
    var_5 = scripts\engine\utility::array_remove(var_5, var_7);

    if(var_5.size == 0) {
      self notify("_encstr_83CB1C1B33F756C83C0E97EF21A59095D31A91634A778059521DA3AD530C");
      wait 0.05;
      continue;
    }

    if(istrue(self.delay_hint)) {
      self notify("_encstr_83CB1C1B33F756C83C0E97EF21A59095D31A91634A778059521DA3AD530C");
      wait 0.05;
      continue;
    }

    var_9 = var_5[0];

    if(!isDefined(var_9)) {
      self notify("_encstr_83CB1C1B33F756C83C0E97EF21A59095D31A91634A778059521DA3AD530C");
      wait 0.05;
      continue;
    }

    if(!isDefined(var_4) && distancesquared(var_9.origin, self.origin) <= var_0)
      var_4 = var_9;

    if(!isDefined(var_4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_9.origin, self.origin) <= var_1)
        var_4 = var_9;

      if(isDefined(var_4) && ![[level.should_allow_far_search_dist_func]](var_4))
        var_4 = undefined;
    } else if(!isDefined(var_4) && isDefined(var_9.custom_search_dist)) {
      if(distance(var_9.origin, self.origin) <= var_9.custom_search_dist)
        var_4 = var_9;
    }

    if(!isDefined(var_4) || !scripts\engine\utility::array_contains(level.current_interaction_structs, var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!isDefined(self.last_interaction_point) || self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_button_mash(var_4) || self.last_interaction_point != var_4)
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    else if(self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_4) && !istrue(self.delay_hint))
      scripts\cp\cp_interaction::set_interaction_point(var_4, 0);

    wait 0.05;
  }
}

_id_1230D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 5;

  for(;;) {
    level waittill("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");

    if(level.logfriendlyfire >= 15) {
      break;
    }
  }

  level._id_1230E = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-77.25, 2759, 303.75));
  level._id_1230E setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level._id_1230E.angles = (0, 0, 0);
  waitframe();
  level._id_1230E setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  level._id_1230E sethintdisplayrange(60);
  level._id_1230E sethintdisplayfov(40);
  level._id_1230E setuserange(60);
  level._id_1230E setusefov(35);
  level._id_1230E setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  level._id_1230E makeusable();
  level._id_1230E thread _id_1230C();
}

_id_1230C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(var_0.isdeploying)) {
        continue;
      }
      self hide();
      self makeunusable();

      if(var_0 getclantag() == "_encstr_A30703AF1F" || var_0 getclantag() == "_encstr_A307032F9F")
        var_0 thread _id_1230B();
    }
  }
}

_id_1230B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 15;

  for(;;) {
    if(self getstance() == "_encstr_922406F1A6FD5E05") {
      break;
    }

    wait 1;
  }

  wait 4;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AD5E26321EFAD8E06EFA2D9BCC9CD71DABD9D7ED99D7DD58937D995DD847B773FA0E39560EEB46C0", "_encstr_9A8507BA4040188D08");
  wait 1.5;
  _calloutmarkerping_handleluinotify_acknowledged::tryusenuke();
  level thread _id_12877();
}

_id_12877() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B65E2623F0AFB1386EBE5ACD999CEBA3EA9DEB7B66D7EE0B9CFACCD51B8EF673AF0793951CAF9960", "_encstr_9A8507BA4040188D08");
  wait 9.3;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_87BC25E471795E4B367E0A42618EBFD37027A767D5D1E3D75E96C22B4BE67FCE90831FFE0F42FA", "_encstr_9A8507BA4040188D08");
  wait 11;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8EBC25461EEB36C137FAB4379939F5D15776EBF6CCAFDD85C97D2BF0D1270B6C8E96DE37D79906", "_encstr_9A8507BA4040188D08");
  level waittill("_encstr_BE250FC643F0F7CF8511833A186F3BAF20");
  wait 5;
  var_0 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");

  foreach(var_2 in var_0)
  var_2 suicide();

  foreach(var_5 in level.players)
  var_5 dodamage(var_5.health + 1000, var_5.origin, var_5);

  wait 4;
  var_7 = 0;

  foreach(var_5 in level.players) {
    if(var_5 scripts\cp_mp\utility\player_utility::_isalive())
      var_7 = 1;
  }

  if(var_7)
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}