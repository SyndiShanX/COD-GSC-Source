/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\player.gsc
***********************************************/

main() {
  if(isDefined(self.stealth)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_995711833B053FA560198FBC3370AE8B39B16A");
  self.stealth = spawnStruct();
  scripts\stealth\utility::group_flag_init("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
  scripts\engine\utility::ent_flag_init("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::ent_flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::ent_flag_init("_encstr_B2D4126BD3EDE77DC8A127E95569420B07492293");
  scripts\engine\utility::ent_flag_init("_encstr_A6BF1A4EB9F57032F362EF5BC3396E8057499811F9B081E9A97135C7");
  scripts\engine\utility::ent_flag_set("_encstr_A6BF1A4EB9F57032F362EF5BC3396E8057499811F9B081E9A97135C7");
  self.stealth.spotted_list = [];
  scripts\stealth\utility::group_add();
  thread maxvisibility_thread();

  if(scripts\common\utility::issp())
    thread stealthhints_thread();
}

maxvisibility_thread() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(maxvisibility_shouldupdate())
      self.maxvisibledist = get_detect_range();

    waitframe();
  }
}

maxvisibility_shouldupdate() {
  if(istrue(self.maxvisibiltyupdate_disabled))
    return 0;

  if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46"))
    return 0;

  if(scripts\engine\utility::ent_flag("_encstr_B2D4126BD3EDE77DC8A127E95569420B07492293"))
    return 1;

  if(isDefined(self.lightmeterdelay) && gettime() < self.lightmeterdelay)
    return 0;

  return 1;
}

get_detect_range() {
  var_0 = self getstance();

  if(scripts\stealth\utility::group_spotted_flag())
    var_1 = "_encstr_8ADA089BC1B78EE8B246";
  else
    var_1 = "_encstr_95DF070DD22319CA9B";

  var_2 = level.stealth.detect.range[var_1][var_0];
  var_3 = 0;

  if(scripts\engine\utility::ent_flag("_encstr_B2D4126BD3EDE77DC8A127E95569420B07492293")) {
    var_2 = var_2 * level.stealth.detect.range[var_1]["_encstr_9B6E07DC34168CF6BB"];
    var_3 = 1;
  } else if(scripts\engine\utility::ent_flag("_encstr_A6BF1A4EB9F57032F362EF5BC3396E8057499811F9B081E9A97135C7")) {
    var_2 = var_2 * self getplayerlightlevel();
    var_3 = 1;
  }

  if(var_3)
    var_2 = max(var_2, level.stealth.detect.minrangedarkness[var_1][var_0]);

  return var_2;
}

combatstate_thread(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!var_0) {
    self notify("_encstr_B436209BE8B70ED7C1B10B2F59E47DD8DB6B260B3AFA37A3B01D95F5A3349C562C19");
    self.stealth.combatstate = undefined;
    return;
  } else if(isDefined(self.stealth.combatstate)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_995711833B053FA560198FBC3370AE8B39B16A");
  self endon("_encstr_B436209BE8B70ED7C1B10B2F59E47DD8DB6B260B3AFA37A3B01D95F5A3349C562C19");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  childthread playerattackedmonitor();
  childthread combatstate_updatethread();
  self.stealth.combatstate = spawnStruct();
  self.stealth.combatstate.name = "_encstr_830E086EE82B0B361D86";
  self.stealth.combatstate.type = "_encstr_A7C5056BD931D1";
  self.stealth.combatstate.updatefuncs = [];
  var_1 = [];
  var_2 = [];

  for(;;) {
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
    var_1 = scripts\engine\utility::array_removedead(var_1);
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
    var_2 = scripts\engine\utility::array_removedead(var_2);
    var_3 = [];
    var_4 = [];
    var_5 = 0;

    if(isDefined(self.lastattackedtime) && !scripts\engine\utility::time_has_passed(self.lastattackedtime, 10))
      var_5 = 1;

    foreach(var_7 in getaiarray("_encstr_8E8405EA382B2A")) {
      if(!isalive(var_7)) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(var_1, var_7)) {
        if(var_7 scripts\engine\utility::doinglongdeath()) {
          continue;
        }
        if(scripts\engine\utility::is_equal(var_7.script, "_encstr_B60D055B0E3128"))
          continue;
      }

      if(var_7[[var_7.fnisinstealthcombat]]()) {
        if(isDefined(self.stealth.combatstate.maxcombatdist)) {
          var_8 = self.stealth.combatstate.maxcombatdist;

          if(distancesquared(self.origin, var_7.origin) > squared(var_8)) {
            var_4[var_4.size] = var_7;
            continue;
          }
        }

        var_3[var_3.size] = var_7;

        if(var_5) {
          continue;
        }
        if(!scripts\engine\utility::is_equal(var_7.enemy, self)) {
          continue;
        }
        if(var_7 cansee(self))
          var_5 = 1;

        continue;
      }

      if(var_7[[var_7.fnisinstealthhunt]]())
        var_4[var_4.size] = var_7;
    }

    var_10 = self.stealth.combatstate.name;
    var_11 = self.stealth.combatstate.type;
    var_12 = var_10;
    var_13 = undefined;

    if(var_10 == "_encstr_AA7C07466F9DA30713") {
      if(var_3.size == 0) {
        var_12 = "_encstr_830E086EE82B0B361D86";

        if(scripts\engine\utility::array_intersection(var_1, var_4).size > 0)
          var_13 = "_encstr_9ACC05B4156DF3";
        else if(var_4.size == 0)
          var_13 = "_encstr_A2F80A1A80396FCE78EB4942";
        else
          var_13 = "_encstr_8DFE0D67904092E21150DE15A5E30B";
      } else if(scripts\engine\utility::is_equal(var_11, "_encstr_97C8081B2DD9BB0FE35F") && var_5)
        var_13 = "_encstr_9B9D061F7727B3F5";
    } else if(var_3.size > 0) {
      var_12 = "_encstr_AA7C07466F9DA30713";

      if(var_5)
        var_13 = "_encstr_9B9D061F7727B3F5";
      else
        var_13 = "_encstr_97C8081B2DD9BB0FE35F";
    } else if(scripts\engine\utility::is_equal(var_11, "_encstr_9ACC05B4156DF3") && var_4.size == 0)
      var_13 = "_encstr_A2F80A1A80396FCE78EB4942";

    if(var_12 != var_10 || isDefined(var_13) && !scripts\engine\utility::is_equal(var_13, var_11)) {
      self.stealth.combatstate.name = var_12;
      self.stealth.combatstate.type = var_13;
      self notify("_encstr_83A31C83C6C2BCAC93FA1BDBB5C4B0A3BE9B8E16472BAF5D0E192CD12BC8", var_12, var_13);
    }

    var_1 = var_3;
    var_2 = var_4;
    waitframe();
  }
}

combatstate_updatethread() {
  for(;;) {
    self waittill("_encstr_83A31C83C6C2BCAC93FA1BDBB5C4B0A3BE9B8E16472BAF5D0E192CD12BC8", var_0, var_1);

    foreach(var_3 in self.stealth.combatstate.updatefuncs)
    self thread[[var_3]](var_0, var_1);
  }
}

combatstate_addupdatefunc(var_0, var_1) {
  self.stealth.combatstate.updatefuncs[var_0] = var_1;
}

combatstate_removeupdatefunc(var_0) {
  self.stealth.combatstate.updatefuncs = scripts\engine\utility::array_remove_key(self.stealth.combatstate.updatefuncs, var_0);
}

playerattackedmonitor() {
  for(;;) {
    level scripts\engine\utility::_id_143A5("_encstr_BDAF0E16DCF52B73955B2FFAE60DED47", "_encstr_9AFA13B1FA8FA1D8D96FE5339EBEF87DBFD288DBD2");
    self.lastattackedtime = gettime();
  }
}

stealthhints_thread() {
  self endon("_encstr_995711833B053FA560198FBC3370AE8B39B16A");
  self.stealth.hints = spawnStruct();
  self.stealth.hints.causeofdeath = undefined;
  self.stealth.hints.investigators = [];
  self.stealth.hints.deathhints["_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C"] = 6;
  self.stealth.hints.deathhints["_encstr_92FD082A30066B713094"] = 8;
  self.stealth.hints.deathhints["_encstr_819110B322AFC3731A77311397C3C7207D3F"] = 16;
  self.stealth.hints.deathhints["_encstr_91F60FB9A59D433AF59BD10BCD235A3776"] = 19;
  childthread stealthhints_eventmonitor();
  childthread stealthhints_deathmonitor();
  childthread stealthhints_combatmonitor();
}

stealthhints_eventmonitor() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    level waittill("_encstr_9A560E4FDCFFA8A94B1266291BE750F8", var_0, var_1);

    if(!isalive(var_1)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(var_0.entity, level.player)) {
      continue;
    }
    if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      self.stealth.hints.causeofdeath = undefined;
      self.stealth.hints.investigators = [];
      continue;
    }

    if(scripts\stealth\utility::any_groups_in_combat()) {
      if(var_0.type != "_encstr_AA7C07466F9DA30713") {
        continue;
      }
      var_2 = 0;

      foreach(var_4 in getaiarray(var_1.team)) {
        if(var_4 == var_1) {
          continue;
        }
        if(var_4[[var_4.fnisinstealthcombat]]()) {
          var_2 = 1;
          break;
        }
      }

      if(var_2)
        continue;
    }

    var_6 = var_0.typeorig;

    if(var_6 == "_encstr_92FD082A30066B713094" && !istrue(level.hassuppressedweapons)) {
      continue;
    }
    if((var_6 == "_encstr_B84F06CBD04CA31B" || var_6 == "_encstr_83650AB19BA26B100D3CE35A") && self issprinting())
      var_6 = "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C";
    else if(var_6 == "_encstr_83650AB19BA26B100D3CE35A" && length2dsquared(level.player getvelocity()) > 11025)
      var_6 = "_encstr_819110B322AFC3731A77311397C3C7207D3F";
    else if(var_6 == "_encstr_B84F06CBD04CA31B" && self getstance() == "_encstr_A5AD069B231F0BAF")
      var_6 = "_encstr_91F60FB9A59D433AF59BD10BCD235A3776";

    if(!isDefined(self.stealth.hints.deathhints[var_6])) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self.stealth.hints.investigators, var_1)) {
      continue;
    }
    childthread stealthhints_aimonitor(var_1, var_6);
  }
}

stealthhints_aimonitor(var_0, var_1) {
  self endon("_encstr_9B4E0F53EF58AEBF05AE7B13715EA327A8");
  self endon("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  self.stealth.hints.investigators[self.stealth.hints.investigators.size] = var_0;

  if(var_0[[var_0.fnisinstealthhunt]]()) {
    var_0 scripts\engine\utility::delaythread(10, scripts\engine\utility::send_notify, "_encstr_BE7F15472821F15271ABB4F48029FB876BB8B787589B3C");
    var_0 scripts\engine\utility::_id_143A6("_encstr_99A30FCD3ACAB0D8471AAF6CB76B89853A", "_encstr_AD75063D571AE108", "_encstr_BE7F15472821F15271ABB4F48029FB876BB8B787589B3C");
  } else if(var_0[[var_0.fnisinstealthinvestigate]]())
    var_0 scripts\engine\utility::_id_143A6("_encstr_92D60D7FECCF98B95B0296582AD3E5", "_encstr_99A30FCD3ACAB0D8471AAF6CB76B89853A", "_encstr_AD75063D571AE108");

  self.stealth.hints.investigators = scripts\engine\utility::array_remove(self.stealth.hints.investigators, var_0);

  if(!isalive(var_0) || !var_0[[var_0.fnisinstealthcombat]]()) {
    return;
  }
  self.stealth.hints.causeofdeath = var_1;
  self.stealth.hints.investigators = [];
  self notify("_encstr_9B4E0F53EF58AEBF05AE7B13715EA327A8");
}

stealthhints_deathmonitor() {
  self waittill("_encstr_AD75063D571AE108");

  if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
    return;
  }
  if(isDefined(level.custom_death_quote)) {
    return;
  }
  if(!isDefined(self.stealth.hints.causeofdeath)) {
    return;
  }
  level.custom_death_quote = self.stealth.hints.deathhints[self.stealth.hints.causeofdeath];
}

stealthhints_combatmonitor() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");

    while(!isDefined(self.stealth.hints.causeofdeath))
      waitframe();

    while(scripts\stealth\utility::any_groups_in_combat())
      waitframe();

    self.stealth.hints.causeofdeath = undefined;
  }
}