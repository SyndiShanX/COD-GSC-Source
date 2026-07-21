/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_personality.gsc
***********************************************/

setup_personalities() {
  level.bot_personality = [];
  level.bot_personality_list = [];
  level.bot_personality["_encstr_930B07BB1B6B3854FF"][0] = "_encstr_BD560C63E89DE9BFF81D7747ADC0";
  level.bot_personality["_encstr_930B07BB1B6B3854FF"][1] = "_encstr_931904C66102";
  level.bot_personality["_encstr_88FA0B7271CF407FE86D0FEBE3"][0] = "_encstr_B892078D2C5BE05927";
  level.bot_personality_type = [];

  foreach(var_5, var_1 in level.bot_personality) {
    foreach(var_3 in var_1) {
      level.bot_personality_type[var_3] = var_5;
      level.bot_personality_list[level.bot_personality_list.size] = var_3;
    }
  }

  level.bot_personality_types_desired = [];
  level.bot_personality_types_desired["_encstr_930B07BB1B6B3854FF"] = 4;
  level.bot_personality_types_desired["_encstr_88FA0B7271CF407FE86D0FEBE3"] = 1;
  level.bot_pers_init = [];
  level.bot_pers_init["_encstr_BD560C63E89DE9BFF81D7747ADC0"] = ::init_personality_default;
  level.bot_pers_init["_encstr_B892078D2C5BE05927"] = ::init_personality_camper;
  level.bot_pers_update["_encstr_BD560C63E89DE9BFF81D7747ADC0"] = ::update_personality_default;
  level.bot_pers_update["_encstr_B892078D2C5BE05927"] = ::update_personality_camper;
}

bot_assign_personality_functions() {
  self.personality = self botgetpersonality();
  self.pers["_encstr_8CAE0C6705AB0BB7F56218C8CBC8"] = self.personality;
  self.personality_init_function = level.bot_pers_init[self.personality];

  if(!isDefined(self.personality_init_function))
    self.personality_init_function = level.bot_pers_init["_encstr_BD560C63E89DE9BFF81D7747ADC0"];

  self[[self.personality_init_function]]();
  self.personality_update_function = level.bot_pers_update[self.personality];

  if(!isDefined(self.personality_update_function))
    self.personality_update_function = level.bot_pers_update["_encstr_BD560C63E89DE9BFF81D7747ADC0"];
}

bot_balance_personality() {
  if(isDefined(self.personalitymanuallyset) && self.personalitymanuallyset) {
    return;
  }
  if(isDefined(self.pers["_encstr_8CAE0C6705AB0BB7F56218C8CBC8"])) {
    self botsetpersonality(self.pers["_encstr_8CAE0C6705AB0BB7F56218C8CBC8"]);
    return;
  }

  var_0 = self.team;

  if(!isDefined(var_0) && !isDefined(self.bot_team))
    var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  var_1 = getarraykeys(level.bot_personality_types_desired);
  var_2 = [];
  var_3 = [];

  foreach(var_9, var_5 in level.bot_personality) {
    var_3[var_9] = 0;

    foreach(var_7 in var_5)
    var_2[var_7] = 0;
  }

  foreach(var_11 in level.participants) {
    if(var_11 == self) {
      continue;
    }
    if(!scripts\mp\utility\entity::isteamparticipant(var_11) || !isDefined(var_11.has_balanced_personality)) {
      continue;
    }
    if(isDefined(var_11.team) && var_11.team == var_0 || !level.teambased) {
      var_7 = var_11 botgetpersonality();
      var_9 = level.bot_personality_type[var_7];
      var_2[var_7] = var_2[var_7] + 1;
      var_3[var_9] = var_3[var_9] + 1;
    }
  }

  var_13 = [];

  foreach(var_15 in var_1)
  var_13[var_15] = int(var_3[var_15] / level.bot_personality_types_desired[var_15]);

  var_17 = undefined;

  for(var_18 = 0; var_18 < var_1.size && !isDefined(var_17); var_18++) {
    var_19 = var_1[var_18];
    var_20 = 1;

    for(var_21 = 0; var_21 < var_1.size; var_21++) {
      var_22 = var_1[var_21];

      if(var_19 != var_22) {
        if(var_13[var_19] >= var_13[var_22])
          var_20 = 0;
      }
    }

    if(var_20)
      var_17 = var_19;
  }

  if(!isDefined(var_17)) {
    var_23 = [];

    foreach(var_15 in var_1)
    var_23[var_15] = level.bot_personality_types_desired[var_15] - var_3[var_15] % level.bot_personality_types_desired[var_15];

    var_26 = 0;

    foreach(var_15 in var_1)
    var_26 = var_26 + var_23[var_15];

    var_29 = randomfloat(var_26);

    foreach(var_15 in var_1) {
      if(var_29 < var_23[var_15]) {
        var_17 = var_15;
        break;
      }

      var_29 = var_29 - var_23[var_15];
    }
  }

  var_32 = undefined;
  var_33 = undefined;
  var_34 = 9999;
  var_35 = undefined;
  var_36 = -9999;
  var_37 = scripts\engine\utility::array_randomize(level.bot_personality[var_17]);

  foreach(var_7 in var_37) {
    if(var_2[var_7] < var_34) {
      var_33 = var_7;
      var_34 = var_2[var_7];
    }

    if(var_2[var_7] > var_36) {
      var_35 = var_7;
      var_36 = var_2[var_7];
    }
  }

  if(var_36 - var_34 >= 2)
    var_32 = var_33;
  else
    var_32 = scripts\engine\utility::random(level.bot_personality[var_17]);

  if(self botgetpersonality() != var_32)
    self botsetpersonality(var_32);

  self.has_balanced_personality = 1;
}

init_personality_camper() {
  clear_camper_data();
}

init_personality_default() {
  clear_camper_data();
}

update_personality_camper() {
  if(should_select_new_ambush_point() && !scripts\mp\bots\bots_util::bot_is_defending() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    var_0 = self botgetscriptgoaltype();
    var_1 = 0;

    if(!isDefined(self.camper_time_started_hunting))
      self.camper_time_started_hunting = 0;

    var_2 = var_0 == "_encstr_9ACC05B4156DF3";
    var_3 = gettime() > self.camper_time_started_hunting + 10000;

    if((!var_2 || var_3) && !scripts\mp\bots\bots_util::bot_out_of_ammo()) {
      if(!self bothasscriptgoal())
        bot_random_path();

      if(isDefined(level.override_find_camp_node))
        var_1 = [[level.override_find_camp_node]]();

      if(!var_1) {
        var_1 = find_camp_node();

        if(!var_1)
          self.camper_time_started_hunting = gettime();
      }
    }

    if(isDefined(var_1) && var_1) {
      self.ambush_entrances = scripts\mp\bots\bots_util::bot_queued_process("_encstr_84E01A6AA0752FCF10BD0C2FBBE8164F1EB8318228CDC346408F050B", ::bot_find_ambush_entrances, self.node_ambushing_from, 1);
      var_4 = scripts\mp\bots\bots_strategy::bot_get_ambush_trap_item("_encstr_ADE71199DB51118FEA4A767BAAA4AB852D2E44", "_encstr_85EF050C9D7062", "_encstr_8B07036CD0");

      if(isDefined(var_4)) {
        var_5 = gettime();
        scripts\mp\bots\bots_strategy::bot_set_ambush_trap(var_4, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw);
        var_5 = gettime() - var_5;

        if(var_5 > 0 && isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
          self.ambush_end = self.ambush_end + var_5;
          self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
        }
      }

      if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_defending() && isDefined(self.node_ambushing_from)) {
        var_6 = self botsetscriptgoalnode(self.node_ambushing_from, "_encstr_8F9005D80B6B38", self.ambush_yaw);

        if(var_6) {
          thread clear_script_goal_on("_encstr_86E5092BA829F7AB738DA4", "_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939", "_encstr_8DFB0CE2B8F9D9B7C950999D5130");
          thread watch_out_of_ammo();
          thread bot_add_ambush_time_delayed("_encstr_A98512D8029F0B83AFBB6F51806F4BAF073A9840", "_encstr_8B7205D9ED5958");
          thread bot_watch_entrances_delayed("_encstr_A98512D8029F0B83AFBB6F51806F4BAF073A9840", "_encstr_AFCB1C4A80550F2E5849D7F143B0F377F33EA362A8A5572778B1E1E17BE8", self.ambush_entrances, self.ambush_yaw);
          childthread bot_try_trap_follower("_encstr_A98512D8029F0B83AFBB6F51806F4BAF073A9840", "_encstr_8B7205D9ED5958");
          return;
        }

        clear_camper_data();
        return;
        return;
      }
    } else {
      if(var_0 == "_encstr_8F9005D80B6B38")
        self botclearscriptgoal();

      update_personality_default();
    }
  }
}

update_personality_default() {
  var_0 = undefined;
  var_1 = self bothasscriptgoal();

  if(var_1)
    var_0 = self botgetscriptgoal();

  if(gettime() - self.lastspawntime > 5000)
    bot_try_trap_follower();

  if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
    var_2 = undefined;
    var_3 = undefined;

    if(var_1) {
      var_2 = distancesquared(self.origin, var_0);
      var_3 = self botgetscriptgoalRadius();
      var_4 = var_3 * 2;

      if(isDefined(self.bot_memory_goal) && var_2 < var_4 * var_4) {
        var_5 = botmemoryflags("_encstr_969E0D96E6B3CA9B8E96EC2C3A5623");
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "_encstr_ABD70578F3D02C", var_5, self);
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_4, "_encstr_AD75063D571AE108", var_5, self);
        self.bot_memory_goal = undefined;
        self.bot_memory_goal_time = undefined;
      }
    }

    if(!var_1 || var_2 < var_3 * var_3) {
      var_6 = bot_random_path();
      var_7 = undefined;
      var_8 = undefined;

      if(var_6) {
        var_7 = self botgetscriptgoal();
        var_8 = self botgetscriptgoaltype();
      }

      var_9 = 25;

      if(istrue(self.encourage_explosive_use))
        var_9 = 50;

      if(var_6 && randomfloat(100) < var_9) {
        var_10 = scripts\mp\bots\bots_strategy::bot_get_ambush_trap_item("_encstr_ADE71199DB51118FEA4A767BAAA4AB852D2E44", "_encstr_85EF050C9D7062");

        if(isDefined(var_10)) {
          var_11 = self botgetscriptgoal();

          if(isDefined(var_11)) {
            var_12 = getclosestnodeinsight(var_11);

            if(isDefined(var_12) && getlinkednodes(var_12).size > 0) {
              var_13 = bot_find_ambush_entrances(var_12, 0);
              var_14 = scripts\mp\bots\bots_strategy::bot_set_ambush_trap(var_10, var_13, var_12);

              if(!isDefined(var_14) || var_14) {
                self botclearscriptgoal();
                var_6 = bot_random_path();

                if(var_6) {
                  var_7 = self botgetscriptgoal();
                  var_8 = self botgetscriptgoaltype();
                }
              }
            }
          }
        }
      }

      if(var_6 && self bothasscriptgoal()) {
        var_15 = self botgetscriptgoal();
        var_16 = self botgetscriptgoaltype();
        var_17 = scripts\mp\bots\bots_util::bot_vectors_are_equal(var_7, var_15);
        var_18 = var_8 == var_16;

        if(var_17 && var_18)
          thread clear_script_goal_on("_encstr_88BF06FD784A6393", "_encstr_86E5092BA829F7AB738DA4", "_encstr_8B7205D9ED5958", "_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939", "_encstr_BD870BCD59C24E3634FAB2738C");
      }
    }
  }
}

bot_try_trap_follower(var_0, var_1) {}

clear_script_goal_on(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_ADA115F05B8DC905290A7EFEE4B34176F73F78632F2FE0");
  self endon("_encstr_ADA115F05B8DC905290A7EFEE4B34176F73F78632F2FE0");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_917A149B3AC239A3BED1C2D81D968DB01BAF3BDEB08D");
  var_5 = self botgetscriptgoal();
  var_6 = 1;

  while(var_6) {
    var_7 = scripts\engine\utility::_id_143B1(var_0, var_1, var_2, var_3, var_4, "_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C");
    var_6 = 0;
    var_8 = 1;

    if(var_7 == "_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939" || var_7 == "_encstr_8B7205D9ED5958" || var_7 == "_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C") {
      if(!self bothasscriptgoal())
        var_8 = 0;
      else {
        var_9 = self botgetscriptgoal();
        var_8 = scripts\mp\bots\bots_util::bot_vectors_are_equal(var_5, var_9);
      }
    }

    if(var_7 == "_encstr_88BF06FD784A6393" && isDefined(self.enemy)) {
      var_8 = 0;
      var_6 = 1;
    }

    if(var_8)
      self botclearscriptgoal();
  }
}

watch_out_of_ammo() {
  self notify("_encstr_A1781250FAF337F8876FBD35479FE1871E820808");
  self endon("_encstr_A1781250FAF337F8876FBD35479FE1871E820808");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(!scripts\mp\bots\bots_util::bot_out_of_ammo())
    wait 0.5;

  self notify("_encstr_8DFB0CE2B8F9D9B7C950999D5130");
}

bot_add_ambush_time_delayed(var_0, var_1) {
  self notify("_encstr_AFCB1C4A80550F2E5849D7F143B0F377F33EA362A8A5572778B1E1E17BE8");
  self endon("_encstr_AFCB1C4A80550F2E5849D7F143B0F377F33EA362A8A5572778B1E1E17BE8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0))
    self endon(var_0);

  self endon("_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939");
  self endon("_encstr_86E5092BA829F7AB738DA4");
  var_2 = gettime();

  if(isDefined(var_1))
    self waittill(var_1);

  if(isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
    self.ambush_end = self.ambush_end + (gettime() - var_2);
    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
  }

  self notify("_encstr_AFCB1C4A80550F2E5849D7F143B0F377F33EA362A8A5572778B1E1E17BE8");
}

bot_watch_entrances_delayed(var_0, var_1, var_2, var_3) {
  self notify("_encstr_88A01C13DE8E7DBB2C8EB143AF95E61D4E85E68D59B9FA2395B1B0F25646");

  if(var_2.size > 0) {
    self endon("_encstr_88A01C13DE8E7DBB2C8EB143AF95E61D4E85E68D59B9FA2395B1B0F25646");
    self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    self endon(var_0);
    self endon("_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939");
    self endon("_encstr_86E5092BA829F7AB738DA4");

    if(isDefined(var_1))
      self waittill(var_1);

    self endon("_encstr_8F600B38AAA3112E5FBE656991");
    childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_2, var_3, 0, self.ambush_end);
    childthread bot_monitor_watch_entrances_camp();
  }
}

bot_monitor_watch_entrances_camp() {
  self notify("_encstr_952B216E851BE7F83FF308988F5AF6FF12EB56E311E27D030AE738288F730E0FBAD557");
  self endon("_encstr_952B216E851BE7F83FF308988F5AF6FF12EB56E311E27D030AE738288F730E0FBAD557");
  self notify("_encstr_BE8C1CE6208B30D35230A98BC5631E3382E352CB09DA65E3A3389013AF7B");
  self endon("_encstr_BE8C1CE6208B30D35230A98BC5631E3382E352CB09DA65E3A3389013AF7B");
  self endon("_encstr_95F2151237532153F0848E30710542EC27074146CB70DA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(!isDefined(self.watch_nodes))
    wait 0.05;

  while(isDefined(self.watch_nodes)) {
    foreach(var_1 in self.watch_nodes)
    var_1.watch_node_chance[self.entity_number] = var_1.watch_node_base_chance[self.entity_number];

    scripts\mp\bots\bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
    wait(randomfloatrange(0.5, 0.75));
  }
}

bot_find_ambush_entrances(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = [];
  var_3 = findentrances(var_0.origin);

  if(isDefined(var_3) && var_3.size > 0) {
    wait 0.05;
    var_4 = var_0.type != "_encstr_AFFF0C6E8FE899DDE6174B068510" && var_0.type != "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8";

    if(var_4 && var_1)
      var_3 = self botnodescoremultiple(var_3, "_encstr_8F0412DCDB192BF5B2C31CF69B573959AFCE4BCD", var_0.origin, "_encstr_B13D076BED70539F23");

    foreach(var_6 in var_3) {
      if(distancesquared(self.origin, var_6.origin) < 90000) {
        continue;
      }
      if(var_4 && var_1) {
        wait 0.05;

        if(!scripts\mp\bots\bots_util::entrance_visible_from(var_6.origin, var_0.origin, "_encstr_B13D076BED70539F23"))
          continue;
      }

      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

bot_filter_ambush_inuse(var_0) {
  var_1 = [];
  var_2 = gettime();
  var_3 = var_0.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_0[var_4];

    if(!isDefined(var_5.bot_ambush_end) || var_2 > var_5.bot_ambush_end)
      var_1[var_1.size] = var_5;
  }

  return var_1;
}

bot_filter_ambush_vicinity(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = var_2 * var_2;

  if(level.teambased) {
    foreach(var_7 in level.participants) {
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(var_7.team)) {
        continue;
      }
      if(var_7.team == var_1.team && var_7 != var_1 && isDefined(var_7.node_ambushing_from))
        var_4[var_4.size] = var_7.node_ambushing_from.origin;
    }
  }

  var_9 = var_4.size;
  var_10 = var_0.size;

  for(var_11 = 0; var_11 < var_10; var_11++) {
    var_12 = 0;
    var_13 = var_0[var_11];

    for(var_14 = 0; !var_12 && var_14 < var_9; var_14++) {
      var_15 = distancesquared(var_4[var_14], var_13.origin);
      var_12 = var_15 < var_5;
    }

    if(!var_12)
      var_3[var_3.size] = var_13;
  }

  return var_3;
}

clear_camper_data() {
  self notify("_encstr_A98512D8029F0B83AFBB6F51806F4BAF073A9840");

  if(isDefined(self.node_ambushing_from) && isDefined(self.node_ambushing_from.bot_ambush_end))
    self.node_ambushing_from.bot_ambush_end = undefined;

  self.node_ambushing_from = undefined;
  self.point_to_ambush = undefined;
  self.ambush_yaw = undefined;
  self.ambush_entrances = undefined;
  self.ambush_duration = randomintrange(20000, 30000);
  self.ambush_end = -1;
}

should_select_new_ambush_point() {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal())
    return 0;

  if(gettime() > self.ambush_end)
    return 1;

  if(!self bothasscriptgoal())
    return 1;

  return 0;
}

find_camp_node() {
  self notify("_encstr_ABF00FEB38B81C894737D58A307542A461");
  self endon("_encstr_ABF00FEB38B81C894737D58A307542A461");
  return scripts\mp\bots\bots_util::bot_queued_process("_encstr_A31A16CC4B9B91FAC62CDA1CD79BED19ACBEBBDB935B959C", ::find_camp_node_worker);
}

find_camp_node_worker() {
  self notify("_encstr_A31A16CC4B9B91FAC62CDA1CD79BED19ACBEBBDB935B959C");
  self endon("_encstr_A31A16CC4B9B91FAC62CDA1CD79BED19ACBEBBDB935B959C");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  clear_camper_data();

  if(level.zonecount <= 0)
    return 0;

  var_0 = getzonenearest(self.origin);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self getplayerangles();

  if(isDefined(var_0)) {
    var_4 = botzonenearestcount(var_0, self.team, -1, "_encstr_B2620E4878194F72EE030A77E3BA5EB4", "_encstr_834C028F", 0, "_encstr_AD830516C68DE5", "_encstr_994C02EF", 1);

    if(!isDefined(var_4))
      var_4 = botzonenearestcount(var_0, self.team, -1, "_encstr_B2620E4878194F72EE030A77E3BA5EB4", "_encstr_834C028F", 0);

    if(isDefined(var_4)) {
      var_5 = getzonenodeforindex(var_4);
      var_6 = getlinkednodes(var_5);

      if(var_6.size == 0)
        var_4 = undefined;
    }

    if(!isDefined(var_4)) {
      var_7 = -1;
      var_8 = -1;

      for(var_9 = 0; var_9 < level.zonecount; var_9++) {
        var_5 = getzonenodeforindex(var_9);
        var_6 = getlinkednodes(var_5);

        if(var_6.size > 0) {
          var_10 = scripts\engine\utility::random(getzonenodes(var_9));
          var_11 = isDefined(var_10.targetname) && var_10.targetname == "_encstr_BEAB133880DF63D834B8C31FDB713D3DA768F74870";

          if(!var_11) {
            var_12 = distance2dsquared(getzoneorigin(var_9), self.origin);

            if(var_12 > var_7) {
              var_7 = var_12;
              var_8 = var_9;
            }
          }
        }
      }

      var_4 = var_8;
    }

    var_13 = getzonepath(var_0, var_4);

    if(!isDefined(var_13) || var_13.size == 0)
      return 0;

    for(var_14 = 0; var_14 <= int(var_13.size / 2); var_14++) {
      var_1 = var_13[var_14];
      var_2 = var_13[int(min(var_14 + 1, var_13.size - 1))];

      if(botzonegetcount(var_2, self.team, "_encstr_B2620E4878194F72EE030A77E3BA5EB4") != 0) {
        break;
      }
    }

    if(isDefined(var_1) && isDefined(var_2) && var_1 != var_2) {
      var_3 = getzoneorigin(var_2) - getzoneorigin(var_1);
      var_3 = vectortoangles(var_3);
    }
  }

  var_15 = undefined;

  if(isDefined(var_1)) {
    var_16 = 1;
    var_17 = 1;
    var_18 = 0;

    while(var_16) {
      var_19 = getzonenodesbydist(var_1, 800 * var_17, 1);

      if(var_19.size > 1024)
        var_19 = getzonenodes(var_1, 0);

      wait 0.05;
      var_20 = randomint(100);

      if(var_20 < 66 && var_20 >= 33)
        var_3 = (var_3[0], var_3[1] + 45, 0);
      else if(var_20 < 33)
        var_3 = (var_3[0], var_3[1] - 45, 0);

      if(var_19.size > 0) {
        while(var_19.size > 1024)
          var_19[var_19.size - 1] = undefined;

        var_21 = int(clamp(var_19.size * 0.15, 1, 10));

        if(var_18)
          var_19 = self botnodepickmultiple(var_19, var_21, var_21, "_encstr_93D40A304FAB4F7E1810A063", anglesToForward(var_3), "_encstr_88060859378ABBC90E8B");
        else
          var_19 = self botnodepickmultiple(var_19, var_21, var_21, "_encstr_93D40A304FAB4F7E1810A063", anglesToForward(var_3));

        var_19 = bot_filter_ambush_inuse(var_19);

        if(!isDefined(self.can_camp_near_others) || !self.can_camp_near_others) {
          var_22 = 800;
          var_19 = bot_filter_ambush_vicinity(var_19, self, var_22);
        }

        if(var_19.size > 0)
          var_15 = scripts\engine\utility::random_weight_sorted(var_19);
      }

      if(isDefined(var_15))
        var_16 = 0;
      else if(isDefined(self.camping_needs_fallback_camp_location)) {
        if(var_17 == 1 && !var_18)
          var_17 = 3;
        else if(var_17 == 3 && !var_18)
          var_18 = 1;
        else if(var_17 == 3 && var_18)
          var_16 = 0;
      } else
        var_16 = 0;

      if(var_16)
        wait 0.05;
    }
  }

  if(!isDefined(var_15) || !self botnodeavailable(var_15))
    return 0;

  self.node_ambushing_from = var_15;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  self.ambush_yaw = var_3[1];
  return 1;
}

find_ambush_node(var_0, var_1) {
  clear_camper_data();

  if(isDefined(var_0))
    self.point_to_ambush = var_0;
  else {
    var_2 = undefined;
    var_3 = getnodesinradius(self.origin, 5000, 0, 2000);

    if(var_3.size > 0)
      var_2 = self botnodepick(var_3, var_3.size * 0.25, "_encstr_BE280DC67788F7CF8DF3D2AA196B67");

    if(isDefined(var_2))
      self.point_to_ambush = var_2.origin;
    else
      return 0;
  }

  var_4 = 2000;

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = getnodesinradius(self.point_to_ambush, var_4, 0, 1000);
  var_6 = undefined;

  if(var_5.size > 0) {
    var_7 = int(max(1, int(var_5.size * 0.15)));
    var_5 = self botnodepickmultiple(var_5, var_7, var_7, "_encstr_B4D90C95B8D942473148A3E7A048", self.point_to_ambush);
  }

  var_5 = bot_filter_ambush_inuse(var_5);

  if(var_5.size > 0)
    var_6 = scripts\engine\utility::random_weight_sorted(var_5);

  if(!isDefined(var_6) || !self botnodeavailable(var_6))
    return 0;

  self.node_ambushing_from = var_6;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  var_8 = vectorNormalize(self.point_to_ambush - self.node_ambushing_from.origin);
  var_9 = vectortoangles(var_8);
  self.ambush_yaw = var_9[1];
  return 1;
}

bot_random_path() {
  if(scripts\mp\bots\bots_util::bot_is_remote_or_linked())
    return 0;

  return self[[level.bot_random_path_function]]();
}

bot_random_path_default() {
  var_0 = 0;
  var_1 = 50;

  if(self.personality == "_encstr_B892078D2C5BE05927")
    var_1 = 0;

  var_2 = undefined;

  if(randomint(100) < var_1)
    var_2 = scripts\mp\bots\bots_util::bot_recent_point_of_interest();

  if(!isDefined(var_2))
    var_2 = self botfindrandomgoal();

  if(isDefined(var_2))
    var_0 = self botsetscriptgoal(var_2, 128, "_encstr_9ACC05B4156DF3");

  return var_0;
}

bot_setup_callback_class() {
  if(scripts\mp\bots\bots_loadout::bot_setup_loadout_callback())
    return "_encstr_A7AA09C616D81B26586CB5";
  else
    return "_encstr_AB8007922817677232";
}