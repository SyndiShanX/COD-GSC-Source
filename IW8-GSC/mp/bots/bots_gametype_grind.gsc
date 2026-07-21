/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_grind.gsc
***********************************************/

main() {
  setup_callbacks();
  _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::setup_bot_conf();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_grind_think;
}

bot_grind_think() {
  self notify("_encstr_A63210F81AF34F193369303D47F320EBDDE2");
  self endon("_encstr_A63210F81AF34F193369303D47F320EBDDE2");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.grind_waiting_to_bank = 0;
  self.goal_zone = undefined;
  self.conf_camping_zone = 0;
  self.additional_tactical_logic_func = ::bot_grind_extra_think;

  if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
    childthread enemy_watcher();

  _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::bot_conf_think();
}

bot_grind_extra_think() {
  if(!isDefined(self.tag_getting)) {
    if(self.tagscarried > 0) {
      var_0 = squared(500 + self.tagscarried * 250);

      if(game["_encstr_96040B1D59B0AD35B1F64E599B"][self.team] + self.tagscarried >= level.roundscorelimit)
        var_0 = squared(5000);
      else if(!isDefined(self.enemy) && !scripts\mp\bots\bots_util::bot_in_combat())
        var_0 = squared(1500 + self.tagscarried * 250);

      var_1 = undefined;

      foreach(var_3 in level.objectives) {
        var_4 = distancesquared(self.origin, var_3.trigger.origin);

        if(var_4 < var_0) {
          var_0 = var_4;
          var_1 = var_3;
        }
      }

      if(isDefined(var_1)) {
        var_6 = 1;

        if(self.grind_waiting_to_bank) {
          if(isDefined(self.goal_zone) && self.goal_zone == var_1)
            var_6 = 0;
        }

        if(var_6) {
          self.grind_waiting_to_bank = 1;
          self.goal_zone = var_1;
          self botclearscriptgoal();
          self notify("_encstr_919B130F9C3D60704722E008CACF9DE059FAAFBD35");
          self notify("_encstr_96A212D36B502B39E83B6D78C368FF4F02A0BA3A");
          self.conf_camping_zone = 0;
          scripts\mp\bots\bots_personality::clear_camper_data();
          scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("_encstr_99D509CBFC59B01903E199");
          childthread bot_goto_zone(var_1, "_encstr_99C209E34FC743616118AB");
        }
      }

      if(self.grind_waiting_to_bank) {
        if(game["_encstr_96040B1D59B0AD35B1F64E599B"][self.team] + self.tagscarried >= level.roundscorelimit)
          self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", 1);
      }
    } else if(self.grind_waiting_to_bank) {
      self.grind_waiting_to_bank = 0;
      self.goal_zone = undefined;
      self notify("_encstr_919B130F9C3D60704722E008CACF9DE059FAAFBD35");
      self botclearscriptgoal();
    }

    if(self.personality == "_encstr_B892078D2C5BE05927" && !self.conf_camping_tag && !self.grind_waiting_to_bank) {
      var_0 = undefined;
      var_1 = undefined;

      foreach(var_3 in level.objectives) {
        var_4 = distancesquared(self.origin, var_3.trigger.origin);

        if(!isDefined(var_0) || var_4 < var_0) {
          var_0 = var_4;
          var_1 = var_3;
        }
      }

      if(isDefined(var_1)) {
        if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
          if(scripts\mp\bots\bots_personality::find_ambush_node(var_1.trigger.origin)) {
            self.conf_camping_zone = 1;
            self notify("_encstr_919B130F9C3D60704722E008CACF9DE059FAAFBD35");
            self.grind_waiting_to_bank = 0;
            self botclearscriptgoal();
            childthread bot_camp_zone(var_1, "_encstr_8F9005D80B6B38");
          } else {
            self notify("_encstr_96A212D36B502B39E83B6D78C368FF4F02A0BA3A");
            self.conf_camping_zone = 0;
            scripts\mp\bots\bots_personality::clear_camper_data();
          }
        }
      } else
        self.conf_camping_zone = 1;
    }
  } else {
    self notify("_encstr_919B130F9C3D60704722E008CACF9DE059FAAFBD35");
    self.grind_waiting_to_bank = 0;
    self.goal_zone = undefined;
    self notify("_encstr_96A212D36B502B39E83B6D78C368FF4F02A0BA3A");
    self.conf_camping_zone = 0;
  }

  return self.grind_waiting_to_bank || self.conf_camping_zone;
}

bot_goto_zone(var_0, var_1) {
  self endon("_encstr_919B130F9C3D60704722E008CACF9DE059FAAFBD35");

  if(!isDefined(var_0.calculated_nearest_node)) {
    var_0.nearest_node = getclosestnodeinsight(var_0.trigger.origin);
    var_0.calculated_nearest_node = 1;
  }

  var_2 = var_0.nearest_node;
  self botsetscriptgoal(var_2.origin, 32, var_1);
  var_3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

bot_camp_zone(var_0, var_1) {
  self endon("_encstr_96A212D36B502B39E83B6D78C368FF4F02A0BA3A");
  self botsetscriptgoalnode(self.node_ambushing_from, var_1, self.ambush_yaw);
  var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_2 == "_encstr_8B7205D9ED5958") {
    if(!isDefined(var_0.calculated_nearest_node)) {
      var_0.nearest_node = getclosestnodeinsight(var_0.trigger.origin);
      var_0.calculated_nearest_node = 1;
    }

    var_3 = var_0.nearest_node;

    if(isDefined(var_3)) {
      var_4 = findentrances(self.origin);
      var_4 = scripts\engine\utility::array_add(var_4, var_3);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_4);
    }
  }
}

enemy_watcher() {
  self.default_meleechargedist = self botgetdifficultysetting("_encstr_AA0A10ADB26359CAA1432C277695112D373A");

  for(;;) {
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") < 2)
      wait 0.5;
    else
      wait 0.2;

    if(isDefined(self.enemy) && isPlayer(self.enemy) && isDefined(self.enemy.tagscarried) && self.enemy.tagscarried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin, self.enemy.origin) <= 500) {
      self botsetdifficultysetting("_encstr_AA0A10ADB26359CAA1432C277695112D373A", 500);
      self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 1);
      continue;
    }

    self botsetdifficultysetting("_encstr_AA0A10ADB26359CAA1432C277695112D373A", self.default_meleechargedist);
    self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 0);
  }
}