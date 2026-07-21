/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_mugger.gsc
***********************************************/

main() {
  level.bot_tag_obj_radius = 200;
  setup_callbacks();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_mugger_think;
  level.bot_funcs["_encstr_9BA8189D166B59D1F23895AF8D7BC2467BD58EEBADDE465A33E5"] = ::bot_mugger_loadout_modify;
}

bot_mugger_think() {
  self notify("_encstr_B2111165D034C9652330129D9E6825225858F3");
  self endon("_encstr_B2111165D034C9652330129D9E6825225858F3");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.last_killtag_tactical_goal_pos = (0, 0, 0);
  self.tag_getting = undefined;
  self.heading_for_tag_pile = 0;
  self.hiding_until_bank = 0;
  self.default_meleechargedist = self botgetdifficultysetting("_encstr_AA0A10ADB26359CAA1432C277695112D373A");
  childthread tag_watcher();

  if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
    childthread tag_pile_watcher();

  if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
    childthread enemy_watcher();

  for(;;) {
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 1) {
      if(isDefined(self.tags_carried) && level.mugger_bank_limit <= self.tags_carried) {
        if(!self.hiding_until_bank) {
          var_0 = getnodesinradius(self.origin, 1000, 0, 500, "_encstr_8E210AB9ED8C56F51AA53259");
          var_1 = self botnodepick(var_0, 3, "_encstr_8E210AB9ED8C56F51AA53259");

          if(isDefined(var_1)) {
            self botsetscriptgoalnode(var_1, "_encstr_99CC09DA9020C4ECD149AD");
            self.hiding_until_bank = 1;
          }
        }
      } else if(self.hiding_until_bank) {
        self botclearscriptgoal();
        self.hiding_until_bank = 0;
      }
    }

    if(!self.hiding_until_bank) {
      if(!isDefined(self.tag_getting) && !self.heading_for_tag_pile)
        self[[self.personality_update_function]]();
    }

    wait 0.05;
  }
}

enemy_watcher() {
  for(;;) {
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") < 2)
      wait 0.5;
    else
      wait 0.2;

    if(isDefined(self.enemy) && isPlayer(self.enemy) && isDefined(self.enemy.tags_carried) && self.enemy.tags_carried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin, self.enemy.origin) <= 500) {
      self botsetdifficultysetting("_encstr_AA0A10ADB26359CAA1432C277695112D373A", 500);
      self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 1);
      self botsetflag("_encstr_843C121B19FE32B741D835FC51B8D7AADDB9C7D7", level.mugger_throwing_knife_mug_frac > 0);
      continue;
    }

    self botsetdifficultysetting("_encstr_AA0A10ADB26359CAA1432C277695112D373A", self.default_meleechargedist);
    self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 0);
    self botsetflag("_encstr_843C121B19FE32B741D835FC51B8D7AADDB9C7D7", 0);
  }
}

tag_pile_watcher() {
  for(;;) {
    level waittill("_encstr_824E1081135FDFB806374CDBA0E1595879C1", var_0);

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
          if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0 && var_6 < 122500 || var_6 < 1000000 && _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::bot_is_tag_visible(var_5, var_0, self botgetfovdot())) {
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
        if(isPlayer(self) || distancesquared(self.origin, var_5.curorigin) < 1000000) {
          if(_encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::bot_is_tag_visible(var_5, var_0, var_1)) {
            var_6 = spawnStruct();
            var_6.origin = var_5.curorigin;
            var_6.tag = var_5;
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
    if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 0)
      wait 3.0;
    else if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 1)
      wait 1.5;
    else
      wait 0.5;

    if(self.health <= 0) {
      continue;
    }
    if(self.hiding_until_bank) {
      continue;
    }
    if(isDefined(self.enemy) && isPlayer(self.enemy) && self botcanseeentity(self.enemy)) {
      continue;
    }
    var_0 = bot_find_closest_tag();

    if(isDefined(var_0)) {
      mugger_pick_up_tag(var_0);
      continue;
    }

    if(!self.heading_for_tag_pile) {
      if(isDefined(self.last_tag_pile_location) && isDefined(self.last_tag_pile_time) && gettime() - self.last_tag_pile_time <= 7500)
        thread mugger_go_to_tag_pile(self.last_tag_pile_location);
    }
  }
}

mugger_go_to_tag_pile(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.heading_for_tag_pile = 1;
  var_1 = spawnStruct();
  var_1.script_goal_type = "_encstr_9A2B0A12F03587575B7BBEA5";
  var_1.objective_radius = level.bot_tag_obj_radius;
  scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_9A050ED8129D516643F92C08C01F481B", var_0, 25, var_1);
  var_2 = scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_B6390CE80B3BD7E638B7471DCA19");
  self botclearscriptgoal();
  self.heading_for_tag_pile = 0;
  scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("_encstr_9A050ED8129D516643F92C08C01F481B");
}

mugger_pick_up_tag(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.tag_getting = var_0;
  self notify("_encstr_B6390CE80B3BD7E638B7471DCA19");
  childthread notify_when_tag_picked_up(var_0, "_encstr_85AB0EF8D18F6792EA97475BE247E3C9");
  scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("_encstr_99D509CBFC59B01903E199");
  var_1 = var_0.curorigin;

  if(scripts\mp\bots\bots_util::bot_vectors_are_equal(self.last_killtag_tactical_goal_pos, var_0.curorigin)) {
    var_2 = var_0.nearest_node;

    if(isDefined(var_2)) {
      var_3 = var_2.origin - var_1;
      var_1 = var_1 + vectorNormalize(var_3) * length(var_3) * 0.5;
    }
  }

  self.last_killtag_tactical_goal_pos = var_0.curorigin;
  var_4 = spawnStruct();
  var_4.script_goal_type = "_encstr_9A2B0A12F03587575B7BBEA5";
  var_4.objective_radius = level.bot_tag_obj_radius;
  scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_99D509CBFC59B01903E199", var_1, 25, var_4);
  thread notify_when_tag_aborted("_encstr_BDC10C8EB0D9BE1613F6398E2B23");
  var_5 = scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_85AB0EF8D18F6792EA97475BE247E3C9");
  self notify("_encstr_B2E60F88AF4FCECF0A0BBE3329C30130A0");
  self.tag_getting = undefined;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("_encstr_99D509CBFC59B01903E199");
}

notify_when_tag_aborted(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B2E60F88AF4FCECF0A0BBE3329C30130A0");

  while(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_99D509CBFC59B01903E199"))
    wait 0.05;

  self notify(var_0);
}

notify_when_tag_picked_up(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B2E60F88AF4FCECF0A0BBE3329C30130A0");

  while(var_0 scripts\mp\gameobjects::caninteractwith(self.team))
    wait 0.05;

  self notify(var_1);
}

bot_mugger_loadout_modify(var_0) {
  var_1 = 0;
  var_2 = self botgetdifficulty();

  if(var_2 == "_encstr_889F0893CA6CC9BA2D8E")
    var_1 = 0.1;
  else if(var_2 == "_encstr_813008928DA89D31A8CA")
    var_1 = 0.25;
  else if(var_2 == "_encstr_A7D409342C272359DC59C8")
    var_1 = 0.6;
  else if(var_2 == "_encstr_BAAF081BD348D7E299C8")
    var_1 = 0.9;

  var_3 = var_0["_encstr_83BC1124F069D3E5D3907833B0C31A4F41E8A4"] == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83";

  if(!var_3) {
    if(var_1 >= randomfloat(1)) {
      var_0["_encstr_83BC1124F069D3E5D3907833B0C31A4F41E8A4"] = "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83";
      var_3 = 1;
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["_encstr_A9C30F63DE858CDB57E8F499991A2CDCC8"] != "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B")
      var_0["_encstr_A9C30F63DE858CDB57E8F499991A2CDCC8"] = "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B";
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] != "_encstr_99C209E34FC743616118AB" && var_0["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] != "_encstr_99C209E34FC743616118AB") {
      var_4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_0["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"], "_encstr_99C209E34FC743616118AB");

      if(var_4)
        var_0["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_99C209E34FC743616118AB";
      else {
        var_4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], "_encstr_99C209E34FC743616118AB", var_0["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"]);

        if(var_4)
          var_0["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_99C209E34FC743616118AB";
      }
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] != "_encstr_99C209E34FC743616118AB" && var_0["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] != "_encstr_99C209E34FC743616118AB") {
      var_4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_0["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"], "_encstr_99C209E34FC743616118AB");

      if(var_4)
        var_0["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_99C209E34FC743616118AB";
      else {
        var_4 = scripts\mp\bots\bots_loadout::bot_validate_weapon(var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], "_encstr_99C209E34FC743616118AB", var_0["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"]);

        if(var_4)
          var_0["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_99C209E34FC743616118AB";
      }
    }
  }

  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];

  if(var_3)
    var_8[var_8.size] = "_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953";

  var_8[var_8.size] = "_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8";
  var_8[var_8.size] = "_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218";
  var_8[var_8.size] = "_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858";
  var_8[var_8.size] = "_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA";

  for(var_9 = 1; var_9 < 9; var_9++) {
    if(isDefined(var_0["_encstr_AD0E0C49FFD6A830573B7FC143F7" + var_9])) {
      if(var_0["_encstr_AD0E0C49FFD6A830573B7FC143F7" + var_9] != "_encstr_8BBA05185F8B99") {
        var_5[var_5.size] = var_0["_encstr_AD0E0C49FFD6A830573B7FC143F7" + var_9];
        var_6[var_6.size] = var_9;
        continue;
      }

      var_7[var_7.size] = var_9;
    }
  }

  foreach(var_11 in var_8) {
    if(var_1 >= randomfloat(1)) {
      if(!scripts\engine\utility::array_contains(var_5, var_11)) {
        var_12 = -1;

        if(var_7.size) {
          var_12 = var_7[0];
          var_7 = scripts\engine\utility::array_remove(var_7, var_12);
        } else if(var_6.size) {
          var_12 = scripts\engine\utility::random(var_6);
          var_6 = scripts\engine\utility::array_remove(var_6, var_12);
        }

        if(var_12 != -1)
          var_0["_encstr_AD0E0C49FFD6A830573B7FC143F7" + var_12] = var_11;
      }
    }
  }

  return var_0;
}