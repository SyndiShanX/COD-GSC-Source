/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_mugger.gsc
***********************************************/

main() {
  level.bot_tag_obj_radius = 200;
  setup_callbacks();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_mugger_think;
  level.bot_funcs["gametype_loadout_modify"] = ::bot_mugger_loadout_modify;
}

bot_mugger_think() {
  self notify("bot_mugger_think");
  self endon("bot_mugger_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.last_killtag_tactical_goal_pos = (0, 0, 0);
  self.tag_getting = undefined;
  self.heading_for_tag_pile = 0;
  self.hiding_until_bank = 0;
  self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");
  childthread tag_watcher();
  if(self botgetdifficultysetting("strategyLevel") > 0) {
    childthread tag_pile_watcher();
  }

  if(self botgetdifficultysetting("strategyLevel") > 0) {
    childthread enemy_watcher();
  }

  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") > 1) {
      if(isDefined(self.tags_carried) && level.mugger_bank_limit <= self.tags_carried) {
        if(!self.hiding_until_bank) {
          var_0 = getnodesinradius(self.origin, 1000, 0, 500, "node_hide");
          var_1 = self botnodepick(var_0, 3, "node_hide");
          if(isDefined(var_1)) {
            self botsetscriptgoalnode(var_1, "critical");
            self.hiding_until_bank = 1;
          }
        }
      } else if(self.hiding_until_bank) {
        self botclearscriptgoal();
        self.hiding_until_bank = 0;
      }
    }

    if(!self.hiding_until_bank) {
      if(!isDefined(self.tag_getting) && !self.heading_for_tag_pile) {
        self[[self.personality_update_function]]();
      }
    }

    wait(0.05);
  }
}

enemy_watcher() {
  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") < 2) {
      wait(0.5);
    } else {
      wait(0.2);
    }

    if(isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied) && isDefined(self.isnodeoccupied.tags_carried) && self.isnodeoccupied.tags_carried >= 3 && self botcanseeentity(self.isnodeoccupied) && distance(self.origin, self.isnodeoccupied.origin) <= 500) {
      self getpassivestruct("meleeChargeDist", 500);
      self botsetflag("prefer_melee", 1);
      self botsetflag("throw_knife_melee", level.mugger_throwing_knife_mug_frac > 0);
      continue;
    }

    self getpassivestruct("meleeChargeDist", self.default_meleechargedist);
    self botsetflag("prefer_melee", 0);
    self botsetflag("throw_knife_melee", 0);
  }
}

tag_pile_watcher() {
  for(;;) {
    level waittill("mugger_tag_pile", var_0);
    if(self.health <= 0) {
      continue;
    }

    if(self.hiding_until_bank) {
      continue;
    }

    if(!isDefined(self.last_tag_pile_time) || gettime() - self.last_tag_pile_time > 7500) {
      self.last_tag_pile_time = undefined;
      self.last_tag_pile_location = undefined;
      self.heading_for_tag_pile = 0;
    }

    if(!isDefined(self.last_tag_pile_location) || distancesquared(self.origin, self.last_tag_pile_location) > distancesquared(self.origin, var_0)) {
      self.last_tag_pile_time = gettime();
      self.last_tag_pile_location = var_0;
    }
  }
}

bot_find_closest_tag() {
  var_0 = self getnearestnode();
  var_1 = undefined;
  if(isDefined(var_0)) {
    var_2 = 1000000;
    var_3 = scripts\engine\utility::array_combine(level.dogtags, level.mugger_extra_tags);
    foreach(var_5 in var_3) {
      if(var_5 scripts\mp\gameobjects::caninteractwith(self.team)) {
        var_6 = distancesquared(self.origin, var_5.curorigin);
        if(!isDefined(var_1) || var_6 < var_2) {
          if((self botgetdifficultysetting("strategyLevel") > 0 && var_6 < 122500) || var_6 < 1000000 && scripts\mp\bots\gametype_conf::bot_is_tag_visible(var_5, var_0, self botgetfovdot())) {
            var_2 = var_6;
            var_1 = var_5;
          }
        }
      }
    }
  }

  return var_1;
}

bot_find_visible_tags_mugger(var_0, var_1) {
  var_2 = [];
  if(isDefined(var_0)) {
    var_3 = scripts\engine\utility::array_combine(level.dogtags, level.mugger_extra_tags);
    foreach(var_5 in var_3) {
      if(var_5 scripts\mp\gameobjects::caninteractwith(self.team)) {
        if(isplayer(self) || distancesquared(self.origin, var_5.curorigin) < 1000000) {
          if(scripts\mp\bots\gametype_conf::bot_is_tag_visible(var_5, var_0, var_1)) {
            var_6 = spawnStruct();
            var_6.origin = var_5.curorigin;
            var_6.physics_setgravitydynentscalar = var_5;
            var_2[var_2.size] = var_6;
          }
        }
      }
    }
  }

  return var_2;
}

tag_watcher() {
  wait(randomfloatrange(0, 0.5));
  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      wait(3);
    } else if(self botgetdifficultysetting("strategyLevel") == 1) {
      wait(1.5);
    } else {
      wait(0.5);
    }

    if(self.health <= 0) {
      continue;
    }

    if(self.hiding_until_bank) {
      continue;
    }

    if(isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied) && self botcanseeentity(self.isnodeoccupied)) {
      continue;
    }

    var_0 = bot_find_closest_tag();
    if(isDefined(var_0)) {
      mugger_pick_up_tag(var_0);
      continue;
    }

    if(!self.heading_for_tag_pile) {
      if(isDefined(self.last_tag_pile_location) && isDefined(self.last_tag_pile_time) && gettime() - self.last_tag_pile_time <= 7500) {
        thread mugger_go_to_tag_pile(self.last_tag_pile_location);
      }
    }
  }
}

mugger_go_to_tag_pile(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self.heading_for_tag_pile = 1;
  var_1 = spawnStruct();
  var_1.script_goal_type = "objective";
  var_1.objective_radius = level.bot_tag_obj_radius;
  scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("kill_tag_pile", var_0, 25, var_1);
  var_2 = scripts\engine\utility::waittill_any_return("death", "tag_spotted");
  self botclearscriptgoal();
  self.heading_for_tag_pile = 0;
  scripts\mp\bots\_bots_strategy::bot_abort_tactical_goal("kill_tag_pile");
}

mugger_pick_up_tag(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self.tag_getting = var_0;
  self notify("tag_spotted");
  childthread notify_when_tag_picked_up(var_0, "tag_picked_up");
  scripts\mp\bots\_bots_strategy::bot_abort_tactical_goal("kill_tag");
  var_1 = var_0.curorigin;
  if(scripts\mp\bots\_bots_util::bot_vectors_are_equal(self.last_killtag_tactical_goal_pos, var_0.curorigin)) {
    var_2 = var_0.nearest_node;
    if(isDefined(var_2)) {
      var_3 = var_2.origin - var_1;
      var_1 = var_1 + vectornormalize(var_3) * length(var_3) * 0.5;
    }
  }

  self.last_killtag_tactical_goal_pos = var_0.curorigin;
  var_4 = spawnStruct();
  var_4.script_goal_type = "objective";
  var_4.objective_radius = level.bot_tag_obj_radius;
  scripts\mp\bots\_bots_strategy::bot_new_tactical_goal("kill_tag", var_1, 25, var_4);
  thread notify_when_tag_aborted("tag_aborted");
  var_5 = scripts\engine\utility::waittill_any_return("death", "tag_picked_up");
  self notify("tag_watch_stop");
  self.tag_getting = undefined;
  self botclearscriptgoal();
  scripts\mp\bots\_bots_strategy::bot_abort_tactical_goal("kill_tag");
}

notify_when_tag_aborted(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");
  while(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal("kill_tag")) {
    wait(0.05);
  }

  self notify(var_0);
}

notify_when_tag_picked_up(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");
  while(var_0 scripts\mp\gameobjects::caninteractwith(self.team)) {
    wait(0.05);
  }

  self notify(var_1);
}

bot_mugger_loadout_modify(var_0) {
  var_1 = 0;
  var_2 = self botgetdifficulty();
  if(var_2 == "recruit") {
    var_1 = 0.1;
  } else if(var_2 == "regular") {
    var_1 = 0.25;
  } else if(var_2 == "hardened") {
    var_1 = 0.6;
  } else if(var_2 == "veteran") {
    var_1 = 0.9;
  }

  var_3 = var_0["loadoutEquipment"] == "throwingknife_mp";
  if(!var_3) {
    if(var_1 >= randomfloat(1)) {
      var_0["loadoutEquipment"] = "throwingknife_mp";
      var_3 = 1;
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutOffhand"] != "concussion_grenade_mp") {
      var_0["loadoutOffhand"] = "concussion_grenade_mp";
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutPrimaryAttachment"] != "tactical" && var_0["loadoutPrimaryAttachment2"] != "tactical") {
      var_4 = scripts\mp\bots\_bots_loadout::bot_validate_weapon(var_0["loadoutPrimary"], var_0["loadoutPrimaryAttachment"], "tactical");
      if(var_4) {
        var_0["loadoutPrimaryAttachment2"] = "tactical";
      } else {
        var_4 = scripts\mp\bots\_bots_loadout::bot_validate_weapon(var_0["loadoutPrimary"], "tactical", var_0["loadoutPrimaryAttachment2"]);
        if(var_4) {
          var_0["loadoutPrimaryAttachment"] = "tactical";
        }
      }
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutSecondaryAttachment"] != "tactical" && var_0["loadoutSecondaryAttachment2"] != "tactical") {
      var_4 = scripts\mp\bots\_bots_loadout::bot_validate_weapon(var_0["loadoutSecondary"], var_0["loadoutSecondaryAttachment"], "tactical");
      if(var_4) {
        var_0["loadoutSecondaryAttachment2"] = "tactical";
      } else {
        var_4 = scripts\mp\bots\_bots_loadout::bot_validate_weapon(var_0["loadoutSecondary"], "tactical", var_0["loadoutSecondaryAttachment2"]);
        if(var_4) {
          var_0["loadoutSecondaryAttachment"] = "tactical";
        }
      }
    }
  }

  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  if(var_3) {
    var_8[var_8.size] = "specialty_extra_deadly";
  }

  var_8[var_8.size] = "specialty_lightweight";
  var_8[var_8.size] = "specialty_marathon";
  var_8[var_8.size] = "specialty_fastsprintrecovery";
  var_8[var_8.size] = "specialty_stun_resistance";
  for(var_9 = 1; var_9 < 9; var_9++) {
    if(isDefined(var_0["loadoutPerk" + var_9])) {
      if(var_0["loadoutPerk" + var_9] != "none") {
        var_5[var_5.size] = var_0["loadoutPerk" + var_9];
        var_6[var_6.size] = var_9;
        continue;
      }

      var_7[var_7.size] = var_9;
    }
  }

  foreach(var_0B in var_8) {
    if(var_1 >= randomfloat(1)) {
      if(!scripts\engine\utility::array_contains(var_5, var_0B)) {
        var_0C = -1;
        if(var_7.size) {
          var_0C = var_7[0];
          var_7 = scripts\engine\utility::array_remove(var_7, var_0C);
        } else if(var_6.size) {
          var_0C = scripts\engine\utility::random(var_6);
          var_6 = scripts\engine\utility::array_remove(var_6, var_0C);
        }

        if(var_0C != -1) {
          var_0["loadoutPerk" + var_0C] = var_0B;
        }
      }
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutStreakType"] == "streaktype_assault" && var_0["loadoutStreak1"] != "airdrop_juggernaut_maniac" && var_0["loadoutStreak2"] != "airdrop_juggernaut_maniac" && var_0["loadoutStreak3"] != "airdrop_juggernaut_maniac") {
      var_0["loadoutStreak3"] = "airdrop_juggernaut_maniac";
    }
  }

  return var_0;
}