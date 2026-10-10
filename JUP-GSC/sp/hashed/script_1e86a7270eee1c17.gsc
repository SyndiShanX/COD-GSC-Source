/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1e86a7270eee1c17.gsc
*************************************************/

#using script_1e86a7270eee1c17;
#using scripts\common\utility;
#using scripts\cp\cp_vo;
#using scripts\cp\interaction;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_65ccffd1a40e12a6;

function function_b04f37f19c6631e0() {
  level.map_interaction_func = &namespace_515a97f7d4a4053d::register_interactions;
  level.player_interaction_monitor = &namespace_515a97f7d4a4053d::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &namespace_515a97f7d4a4053d::function_fe7243424d42cd4b;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;
}

function register_interactions() {
  if(flag_exist("interactions_initialized")) {
    flag_set("interactions_initialized");
  }
}

function function_fe7243424d42cd4b(interaction_struct) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  while(true) {
    interaction_struct.triggered = undefined;
    self.interaction_trigger waittill("trigger", player);

    if(!interaction_is_valid(interaction_struct, player)) {
      continue;
    }

    interaction_struct.triggered = 1;
    cost = interaction_struct interaction_get_cost();

    if(!isDefined(level.interactions[interaction_struct.script_noteworthy].spend_type)) {
      level.interactions[interaction_struct.script_noteworthy].spend_type = "null";
    }

    if(!can_purchase_interaction(interaction_struct, cost, level.interactions[interaction_struct.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[interaction_struct.script_noteworthy], self);
      thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      interaction_show_fail_reason(interaction_struct, &"COOP_INTERACTIONS/NEED_MONEY");
      continue;
    }

    thread interaction_post_activate_delay(interaction_struct);
    level notify("interaction", "purchase", level.interactions[interaction_struct.script_noteworthy], self);
    spending_type = level.interactions[interaction_struct.script_noteworthy].spend_type;
    thread take_player_money(cost, spending_type);
    level thread[[level.interactions[interaction_struct.script_noteworthy].activation_func]](interaction_struct, self);
    interaction_post_activate_update(interaction_struct);
    return;
  }
}

function level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  searchdistance = 5184;
  var_925ab147f36bb977 = 9216;

  while(true) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("interactions_disabled_toggled");
      continue;
    }

    var_cb861e8059c8d5bd = getdvarint(@ "hash_994279ff7ef9febf", 0);

    if(var_cb861e8059c8d5bd != 0) {
      searchdistance = 48 + var_cb861e8059c8d5bd;
      var_925ab147f36bb977 = 72 + var_cb861e8059c8d5bd;
    }

    player_origin = self.origin;
    interaction_point = undefined;
    var_717fb99add9a6834 = sortbydistancecullbyradius(level.current_interaction_structs, player_origin, 512);

    for(i = 0; i < self.disabled_interactions.size; i++) {
      var_717fb99add9a6834 = array_remove(var_717fb99add9a6834, self.disabled_interactions[i]);
    }

    if(var_717fb99add9a6834.size == 0 || istrue(self.delay_hint)) {
      self notify("starting_interaction_search");
      waitframe();
      continue;
    }

    var_4403360414478511 = var_717fb99add9a6834[0];
    var_581aed15f31bbe01 = distancesquared(var_4403360414478511.origin, player_origin);

    if(!isDefined(interaction_point) && var_581aed15f31bbe01 <= searchdistance) {
      interaction_point = var_4403360414478511;
    } else if(!isDefined(interaction_point) && isDefined(level.should_allow_far_search_dist_func)) {
      if(var_581aed15f31bbe01 <= var_925ab147f36bb977) {
        interaction_point = var_4403360414478511;
      }

      if(isDefined(interaction_point) && ![[level.should_allow_far_search_dist_func]](interaction_point)) {
        interaction_point = undefined;
      }
    } else if(!isDefined(interaction_point) && isDefined(var_4403360414478511.custom_search_dist)) {
      if(var_581aed15f31bbe01 <= var_4403360414478511.custom_search_dist) {
        interaction_point = var_4403360414478511;
      }
    }

    if(!isDefined(interaction_point) || !array_contains(level.current_interaction_structs, interaction_point) || !can_use_interaction(interaction_point)) {
      reset_interaction();
      continue;
    }

    if(!no_previous_interaction_point() || !interaction_point_has_changed(interaction_point) && interaction_is_button_mash(interaction_point) || interaction_point_has_changed(interaction_point)) {
      set_interaction_point(interaction_point);
    }

    waitframe();
  }
}

function interaction_trigger_properties(interaction_trigger, interaction_struct, hintstring) {
  self.interaction_trigger setusefov(360);
  self.interaction_trigger sethintrequiresholding(0);

  if(isDefined(interaction_struct.useduration)) {
    self.interaction_trigger setuseholdduration(interaction_struct.useduration);
  }
}