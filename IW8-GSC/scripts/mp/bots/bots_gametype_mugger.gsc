/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_mugger.gsc
****************************************************/

function main() {
  level.bot_tag_obj_radius = 200;
  setup_callbacks();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_mugger_think;
  level.bot_funcs["gametype_loadout_modify"] = &bot_mugger_loadout_modify;
}

function bot_mugger_think() {
  self notify("bot_mugger_think");
  self endon("bot_mugger_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.last_killtag_tactical_goal_pos = (0, 0, 0);
  self.tag_getting = undefined;
  self.heading_for_tag_pile = 0;
  self.hiding_until_bank = 0;
  self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");
  GscBinSkip4(0x35);
}

function enemy_watcher() {
  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") < 2) {
      wait 0.5;
    } else {
      wait 0.2;
    }

    if(isDefined(self.enemy) && isPlayer(self.enemy) && isDefined(self.enemy.tags_carried) && self.enemy.tags_carried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin, self.enemy.origin) <= 500) {
      self botsetdifficultysetting("meleeChargeDist", 500);
      self botsetflag("prefer_melee", 1);
      self botsetflag("throw_knife_melee", level.mugger_throwing_knife_mug_frac > 0);
      continue;
    }

    self botsetdifficultysetting("meleeChargeDist", self.default_meleechargedist);
    self botsetflag("prefer_melee", 0);
    self botsetflag("throw_knife_melee", 0);
  }
}

function tag_pile_watcher() {
  for(;;) {
    level waittill("mugger_tag_pile", var0);

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

    if(!isDefined(self.last_tag_pile_location) || distancesquared(self.origin, self.last_tag_pile_location) > distancesquared(self.origin, var0)) {
      self.last_tag_pile_time = gettime();
      self.last_tag_pile_location = var0;
    }
  }
}

function bot_find_closest_tag() {
  var0 = self getnearestnode();
  var1 = undefined;

  if(isDefined(var0)) {
    var2 = 1000000;
    var3 = scripts\engine\utility::array_combine(level.dogtags, level.mugger_extra_tags);

    foreach(var5 in var3) {
      if(var5 scripts\mp\gameobjects::caninteractwith(self.team)) {
        var6 = distancesquared(self.origin, var5.curorigin);

        if(!isDefined(var1) || var6 < var2) {
          if(self botgetdifficultysetting("strategyLevel") > 0 && var6 < 122500 || var6 < 1000000 && scripts\mp\bots\bots_gametype_conf::bot_is_tag_visible(var5, var0, self botgetfovdot())) {
            var2 = var6;
            var1 = var5;
          }
        }
      }
    }
  }

  return var1;
}

function bot_find_visible_tags_mugger(var0, var1) {
  var2 = [];

  if(isDefined(var0)) {
    var3 = scripts\engine\utility::array_combine(level.dogtags, level.mugger_extra_tags);

    foreach(var5 in var3) {
      if(var5 scripts\mp\gameobjects::caninteractwith(self.team)) {
        if(isPlayer(self) || distancesquared(self.origin, var5.curorigin) < 1000000) {
          if(scripts\mp\bots\bots_gametype_conf::bot_is_tag_visible(var5, var0, var1)) {
            var6 = spawnStruct();
            var6.origin = var5.curorigin;
            var6.tag = var5;
            var2 = var6;
          }
        }
      }
    }
  }

  return var2;
}

function tag_watcher() {
  wait randomfloatrange(0, 0.5);

  for(;;) {
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      wait 3;
    } else if(self botgetdifficultysetting("strategyLevel") == 1) {
      wait 1.5;
    } else {
      wait 0.5;
    }

    if(self.health <= 0) {
      continue;
    }

    if(self.hiding_until_bank) {
      continue;
    }

    if(isDefined(self.enemy) && isPlayer(self.enemy) && self botcanseeentity(self.enemy)) {
      continue;
    }

    var0 = bot_find_closest_tag();

    if(isDefined(var0)) {
      mugger_pick_up_tag(var0);
      continue;
    }

    if(!self.heading_for_tag_pile) {
      if(isDefined(self.last_tag_pile_location) && isDefined(self.last_tag_pile_time) && gettime() - self.last_tag_pile_time <= 7500) {
        thread mugger_go_to_tag_pile(self.last_tag_pile_location);
      }
    }
  }
}

function mugger_go_to_tag_pile(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self.heading_for_tag_pile = 1;
  var1 = spawnStruct();
  var1.script_goal_type = "objective";
  var1.objective_radius = level.bot_tag_obj_radius;
  scripts\mp\bots\bots_strategy::bot_new_tactical_goal("kill_tag_pile", var0, 25, var1);
  var2 = scripts\engine\utility::ref_143ad("death", "tag_spotted");
  self botclearscriptgoal();
  self.heading_for_tag_pile = 0;
  scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("kill_tag_pile");
}

function mugger_pick_up_tag(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self.tag_getting = var0;
  self notify("tag_spotted");
  GscBinSkip4(0x35, var0, "tag_picked_up");
}

function notify_when_tag_aborted(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");

  while(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("kill_tag")) {
    wait 0.05;
  }

  self notify(var0);
}

function notify_when_tag_picked_up(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");

  while(var0 scripts\mp\gameobjects::caninteractwith(self.team)) {
    wait 0.05;
  }

  self notify(var1);
}

function bot_mugger_loadout_modify(var0) {
  var1 = 0;
  var2 = self botgetdifficulty();

  if(var2 == "recruit") {
    var1 = 0.1;
  } else if(var2 == "regular") {
    var1 = 0.25;
  } else if(var2 == "hardened") {
    var1 = 0.6;
  } else if(var2 == "veteran") {
    var1 = 0.9;
  }

  var3 = var0["loadoutEquipment"] == "throwingknife_mp";

  if(!var3) {
    if(var1 >= randomfloat(1)) {
      var0 = "throwingknife_mp";
      var3 = 1;
    }
  }

  if(var1 >= randomfloat(1)) {
    if(var0["loadoutOffhand"] != "concussion_grenade_mp") {
      var0 = "concussion_grenade_mp";
    }
  }

  if(var1 >= randomfloat(1)) {
    if(var0["loadoutPrimaryAttachment"] != "tactical" && var0["loadoutPrimaryAttachment2"] != "tactical") {
      var4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var0["loadoutPrimary"], var0["loadoutPrimaryAttachment"], "tactical");

      if(var4) {
        var0 = "tactical";
      } else {
        var4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var0["loadoutPrimary"], "tactical", var0["loadoutPrimaryAttachment2"]);

        if(var4) {
          var0 = "tactical";
        }
      }
    }
  }

  if(var1 >= randomfloat(1)) {
    if(var0["loadoutSecondaryAttachment"] != "tactical" && var0["loadoutSecondaryAttachment2"] != "tactical") {
      var4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var0["loadoutSecondary"], var0["loadoutSecondaryAttachment"], "tactical");

      if(var4) {
        var0 = "tactical";
      } else {
        var4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var0["loadoutSecondary"], "tactical", var0["loadoutSecondaryAttachment2"]);

        if(var4) {
          var0 = "tactical";
        }
      }
    }
  }

  var5 = [];
  var6 = [];
  var7 = [];
  var8 = [];

  if(var3) {
    GscBinSkip0(0x2e, var8.size, "specialty_extra_deadly");
  }

  GscBinSkip0(0x2e, var8.size, "specialty_lightweight");
}