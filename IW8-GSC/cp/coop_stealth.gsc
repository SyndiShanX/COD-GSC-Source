/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\coop_stealth.gsc
***********************************************/

coop_stealth_init() {
  if(!scripts\engine\utility::flag_exist("_encstr_81FC0C3D5F4AED1989367BD09B75"))
    scripts\engine\utility::flag_init("_encstr_81FC0C3D5F4AED1989367BD09B75");

  scripts\engine\utility::flag_init("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA");
  register_stealth_state_funcs();
  _id_129FD();
  _id_129FE();
  level thread _id_134E4();
  level.bonusdeathplunderot = [];
  level.stealth_soundaliases = ["_encstr_B160199BD781CED8E5DE8D1B84F7108BEB4F2B1177DA98F807758B", "_encstr_843C191F1B68F3B49099B5BB9069FCFA56ABD7938FA95A9C1940AA", "_encstr_976A1AE5091F0B81376218200A4149A073AD67DDA7AB30FF5CA91008"];
}

_id_12C57() {
  level.bonusdeathplunderot = [];
  level.global_stealth_broken = 0;
}

register_stealth_state_funcs() {
  level.enter_stealth_state_func = [];
  level.exit_stealth_state_func = [];
  register_stealth_state_func("_encstr_A7C5056BD931D1", ::enter_casual, ::exit_casual);
  register_stealth_state_func("_encstr_914B078DB09BAB0BB1", ::enter_casual, ::exit_casual);
  register_stealth_state_func("_encstr_85BB067A08A3FAB3", ::enter_alert, ::exit_alert);
  register_stealth_state_func("_encstr_AA7C07466F9DA30713", ::enter_combat, ::exit_combat);
}

register_stealth_state_func(var_0, var_1, var_2) {
  level.enter_stealth_state_func[var_0] = var_1;
  level.exit_stealth_state_func[var_0] = var_2;
}

start_coop_stealth() {
  level thread flash_crate_update_hint_logic_alt();
}

ai_sight_monitor(var_0) {
  self.sightlastactivetime = 0;
  self.sightstate = 0;
  updateaisightonplayer(self.sightstate);
}

getaisightdirection(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388)
    return 2;
  else if(var_5 >= 0.382683)
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  else if(var_5 >= -0.382683)
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  else if(var_5 >= -0.92388)
    return scripts\engine\utility::ter_op(isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  else
    return 16;
}

isleft2d(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

regular_enemy_death_func() {
  var_0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  if(isDefined(level.bonusdeathplunderot) && scripts\engine\utility::array_contains(level.bonusdeathplunderot, self))
    scripts\engine\utility::array_remove(level.bonusdeathplunderot, self);

  var_0 leave_corpse_for_others_to_see();
  var_0 delete_stealth_meter(var_0);
  var_0 delete_combat_icon(var_0);
}

leave_corpse_for_others_to_see() {
  if(!isDefined(level.enemy_ai_corpse_locations))
    level.enemy_ai_corpse_locations = [];

  if(!istrue(self.died_poorly)) {
    var_0 = spawnStruct();
    var_0.loc = self.origin + (0, 0, 120);
    var_0.time_stamp = gettime();
    var_0.index = self getentitynumber() + randomint(100);
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_add(level.enemy_ai_corpse_locations, var_0);
  }
}

weapon_xp_iw8_sn_kilo98() {
  if(scripts\cp\utility::coop_mode_has("_encstr_B87D0B7F2B9FDE9BDA2F64EC18"))
    return 1;

  return getdvarint("_encstr_AD9C0EF02BB78B01290AF575E6724190", 0);
}

_id_132D7() {
  if(level.script == "_encstr_8B82108D07AF93585A237D6CB7D60E1B951E")
    return weapon_xp_iw8_sn_kilo98() && (self.unittype == "_encstr_958C08CDDBD8325A959C" || self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
  else
    return weapon_xp_iw8_sn_kilo98() && self.unittype == "_encstr_958C08CDDBD8325A959C";
}

run_common_functions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\engine\utility::flag("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA")) {
    setdvarifuninitialized("_encstr_AD9C0EF02BB78B01290AF575E6724190", 0);
    attachdrill();
  }

  if(istrue(level.global_stealth_broken))
    var_0 thread scripts\cp\cp_modular_spawning::enter_combat();
  else {
    if(var_0 _id_132D7()) {
      if(isDefined(var_0.group) && isDefined(var_0.group.group_name))
        var_0.script_stealthgroup = var_0.group.group_name;
      else
        var_0.script_stealthgroup = "_encstr_852906B39CBD5D38";

      if(isDefined(var_0.spawnpoint) && isDefined(var_0.spawnpoint.script_sightrange))
        var_0.stealth.override_damage_auto_range = int(var_0.script_sightrange);

      var_0 thread scripts\stealth\enemy::main();
      var_0 thread scripts\mp\vehicles\cargo_truck_mg_mp::_id_11CD7(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
      var_0 thread seeing_player_time_tracker(var_0);
      var_0 thread _id_14458();
      var_0 thread stealth_meter_display_think(var_0);
      var_0.stealth.console_being_hacked = 1;
      var_0.stealth.funcs["_encstr_AA150DAC679537A3FAD87B5B3116A3"] = ::nuke_stoptheclock;
      var_0.fnstealthgotonode = ::select_bunker_server_two_spawners;
      var_0.pacifist_override = 1;
      return;
    }

    if(!isDefined(var_3))
      var_3 = 0.34202;
    else
      var_3 = cos(var_3);

    if(!isDefined(var_4))
      var_4 = 250000;

    var_0 addaieventlistener("_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001");
    var_0 enablestatelookat(1);
    var_0 enablescriptedlookat(1);
    var_0.pacifist_override = 1;
    var_0 set_current_stealth_state(var_0, "_encstr_914B078DB09BAB0BB1");
    var_0 enter_current_stealth_state(var_0);

    if(!istrue(var_5))
      var_0 thread open_scriptable_door_monitor(var_0);

    var_0 thread watch_for_ai_events();
    var_0 thread i_see_player_watcher(var_0, var_2, var_3, var_4, var_6);
    var_0 thread i_see_friendly_corpse_watcher(var_0, var_1);
    var_0 thread delay_enter_combat_after_stealth(var_0);
    var_0 thread watch_for_alarm_triggered();
    var_0 thread spotlight_min_dist_sq_from_node(var_3, var_4);
    var_0 thread spotlight_goal_node(var_3, var_4);
    var_0 thread spotlight_max_dist_sq_from_node(var_3, var_4);
    var_0 thread spotlight_angles_offset(var_3, var_4);
    var_0 thread _id_119D0(var_0);
    var_0 thread blueprint_chancebase(var_0);
    var_0 thread bomb_count_down_end_time_stamp_ms(var_0);
  }
}

blueprint_chancebase(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  level thread play_enemy_radio_chat(propwatchcleanupondisconnect(), var_0);
  var_0 notify("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");
  var_0 getbestintersectionpt(var_0, var_2.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
}

bomb_count_down_end_time_stamp_ms(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 waittill("_encstr_8E5B0734D28EFA854B", var_1);
  level thread play_enemy_radio_chat(propwatchcleanupondisconnect(), var_0);
  var_0 notify("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");
  var_0 getbestintersectionpt(var_0, var_1.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
}

_id_119D0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.a.disablelongdeath = 1;
  var_1 = scripts\engine\utility::waittill_any_ents_return(level, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0", var_0, "_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0.a.disablelongdeath = 0;
}

nuke_stoptheclock(var_0) {
  thread scripts\cp\cp_modular_spawning::enter_combat();
  return 0;
}

select_bunker_server_two_spawners(var_0, var_1, var_2) {
  if(istrue(self.using_goto_node)) {
    if(isDefined(self.currentnode))
      thread scripts\cp\cp_modular_spawning::go_to_node(self.currentnode);
  } else
    scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

_id_139BF() {
  self notify("_encstr_BA8E1C37EAB90ED2D84BB7BADCFA19DEED4ED7B6DECD96D1BD4EFAB27391");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BA8E1C37EAB90ED2D84BB7BADCFA19DEED4ED7B6DECD96D1BD4EFAB27391");
  var_0 = 384;
  var_1 = 80;
}

_id_13B3A() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(isDefined(self.stealth.maxthreat)) {
      if(self.stealth.maxthreat > 0.2 && isDefined(self.stealth.maxthreat_enemy)) {
        var_0 = self.stealth.maxthreat_enemy;
        mark_seen_this_player_this_frame(var_0, self);
        var_0 notify("_encstr_AB8119E2881E6BB5B84B9FBB39F0BE43C50DE9FA9175F7EA7149D7", self);
      }
    }

    waitframe();
  }
}

spotlight_max_dist_sq_from_node(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_2 = self;
  var_3 = 3000;
  var_4 = var_3 * var_3;
  var_5 = 0.1;
  var_6 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var_1 = var_1 * 6.25;

  for(;;) {
    wait 0.4;

    if(!isDefined(level.taccovers)) {
      continue;
    }
    var_7 = self getapproxeyepos();

    foreach(var_9 in level.taccovers) {
      if(isDefined(var_9)) {
        var_10 = lengthsquared(var_9.origin - self.origin);
        var_11 = raritycamsmall(var_2, var_9, var_0, var_3, var_5);

        if(var_10 < var_11 * var_11) {
          var_12 = self cansee(var_9);

          if(!var_12)
            var_12 = scripts\engine\trace::ray_trace_passed(var_7, var_9.origin, [self, var_9], var_6);

          if(var_12) {
            if(var_10 <= var_1)
              getbestintersectionpt(self, var_9.owner.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
            else if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
              enemy_ai_enter_alert(self, var_9, 1);
            else
              i_saw_player(self, var_9.owner, 0);

            break;
          }
        }
      }
    }
  }
}

raritycamsmall(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_5 = 0.34202;
  else
    var_5 = cos(var_2);

  if(!scripts\engine\utility::within_fov(var_0.origin, var_0.angles, var_1.origin, var_2))
    var_3 = var_3 * var_4;

  return var_3;
}

spotlight_goal_node(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_2 = self;
  var_3 = 3000;
  var_4 = 200;
  var_5 = 1500;
  var_6 = 0.6;
  var_7 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var_1 = var_1 * 6.25;

  for(;;) {
    var_8 = self getapproxeyepos();

    foreach(var_10 in level.players) {
      var_11 = quickdropnewitem(var_10);

      if(isDefined(var_11)) {
        var_12 = lengthsquared(var_11.origin - self.origin);
        var_13 = raritycamwatch(self, var_11, var_0, var_3, var_5, var_4, var_6);

        if(var_12 < var_13 * var_13) {
          var_14 = self cansee(var_11);

          if(!var_14)
            var_14 = scripts\engine\trace::ray_trace_passed(var_8, var_11.origin, [self, var_11], var_7);

          if(var_14) {
            if(var_12 <= var_1)
              getbestintersectionpt(self, var_10.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
            else if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
              enemy_ai_enter_alert(self, var_11, 1);
            else
              i_saw_player(self, var_10, 0);

            break;
          }
        }
      }
    }

    wait 0.1;
  }
}

quickdropnewitem(var_0) {
  if(isDefined(var_0._id_12F15))
    return var_0._id_12F15;

  if(isDefined(var_0.monitorhotfoot))
    return var_0.monitorhotfoot;

  return undefined;
}

spotlight_min_dist_sq_from_node(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_2 = 3000;
  var_3 = 200;
  var_4 = 1500;
  var_5 = 0.6;
  var_6 = scripts\engine\trace::init_ground_vehicle(1, 0);

  for(;;) {
    var_7 = self getapproxeyepos();

    foreach(var_9 in level.players) {
      if(var_9 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        var_10 = lengthsquared(var_9.origin - self.origin);
        var_11 = raritycamwatch(self, var_9.vehicle, var_0, var_2, var_4, var_3, var_5);

        if(var_10 < var_11 * var_11) {
          var_12 = self cansee(var_9);

          if(!var_12)
            var_12 = scripts\engine\trace::ray_trace_passed(var_7, var_9 getEye(), [self, var_9, var_9.vehicle], var_6);

          if(var_12) {
            if(var_10 <= var_1)
              getbestintersectionpt(self, var_9.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
            else if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
              enemy_ai_enter_alert(self, var_9, 0);
            else
              i_saw_player(self, var_9, 0);

            break;
          }
        }
      }
    }

    wait 0.1;
  }
}

spotlight_angles_offset(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_2 = 2000;
  var_3 = 0.6;
  var_4 = scripts\engine\trace::init_ground_vehicle(1, 0);

  for(;;) {
    var_5 = self getapproxeyepos();

    foreach(var_7 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_7)) {
        var_8 = lengthsquared(var_7.origin - self.origin);
        var_9 = raritycammedium(self, var_7, var_2, var_0, var_3);

        if(var_8 < var_9 * var_9) {
          var_10 = self cansee(var_7);

          if(!var_10)
            var_10 = scripts\engine\trace::ray_trace_passed(var_5, var_7 getEye(), [self, var_7], var_4);

          if(var_10) {
            if(var_8 <= var_1)
              getbestintersectionpt(self, var_7.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
            else if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
              enemy_ai_enter_alert(self, var_7, 0);
            else
              i_saw_player(self, var_7, 0);

            break;
          }
        }
      }
    }

    wait 0.1;
  }
}

raritycammedium(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_5 = 0.34202;
  else
    var_5 = cos(var_3);

  var_6 = anglesToForward(var_0.angles);
  var_7 = var_1.origin - var_0.origin;
  var_7 = vectorNormalize(var_7);

  if(vectordot(var_6, var_7) < var_5)
    var_2 = var_2 * var_4;

  return var_2;
}

raritycamwatch(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2))
    var_7 = 0.34202;
  else
    var_7 = cos(var_2);

  var_8 = anglesToForward(var_0.angles);
  var_9 = length(var_1 vehicle_getvelocity());
  var_10 = var_4 + (var_3 - var_4) * min(1, 1 - (var_5 - var_9) / var_5);
  var_11 = var_1.origin - var_0.origin;
  var_12 = lengthsquared(var_11);
  var_11 = vectorNormalize(var_11);

  if(vectordot(var_8, var_11) < var_7)
    var_10 = var_10 * var_6;

  return var_10;
}

watch_for_alarm_triggered() {
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self notify("_encstr_8D041ADD58D11BA1D733BD9CBE1663C29CD67D4793D23BD92B9CCA8C");
  self endon("_encstr_8D041ADD58D11BA1D733BD9CBE1663C29CD67D4793D23BD92B9CCA8C");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  level waittill("_encstr_91B909B0D858935BD77BE6");
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

delay_enter_combat_after_stealth(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_93530B91C713410FAFEAC86852");

  if(!istrue(var_0._id_11E50)) {
    var_0.never_kill_off = 0;
    var_0.dontkilloff = 0;
  }

  var_0 scripts\cp\cp_modular_spawning::_id_12BC9();
  var_0 thread scripts\cp\cp_modular_spawning::enter_combat_after_stealth();
}

open_scriptable_door_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_A95D145DB9ACEBE636935A1C4785C48D567D237BB739", var_1, var_0, var_2, var_3);

    if(var_2 == "_encstr_B16705D9AFE22E" && (var_3 == "_encstr_854209D27398BC7BAF92BF" || var_3 == "_encstr_A9E508C0A02E73CFA35A")) {
      var_4 = scripts\engine\utility::getclosest(var_1.origin, scripts\engine\utility::getStructArray("_encstr_811A15036D6F6F3317C7B84ED06A5373967229314B2818", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));

      if(isDefined(var_4))
        scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
    }
  }
}

change_stealth_state_to(var_0, var_1) {
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 notify("_encstr_8D861849D34EDBB82D08BBC0325B1BEB78BFABFBB723722F98BD", var_1);
  var_0 endon("_encstr_8D861849D34EDBB82D08BBC0325B1BEB78BFABFBB723722F98BD");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  exit_current_stealth_state(var_0);
  set_current_stealth_state(var_0, var_1);
  enter_current_stealth_state(var_0);
}

exit_current_stealth_state(var_0) {
  var_0[[level.exit_stealth_state_func[get_current_stealth_state(var_0)]]](var_0);
}

enter_current_stealth_state(var_0) {
  var_0[[level.enter_stealth_state_func[get_current_stealth_state(var_0)]]](var_0);
}

set_current_stealth_state(var_0, var_1) {
  var_0.current_stealth_state = var_1;
}

get_current_stealth_state(var_0) {
  return var_0.current_stealth_state;
}

trial_trigger_think(var_0) {
  return isDefined(get_current_stealth_state(var_0));
}

enter_casual(var_0) {
  var_0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_96080730D8534E0A28");
  var_0 scripts\engine\utility::set_movement_speed(25);
}

exit_casual(var_0) {}

enter_alert(var_0) {
  var_0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_85BB067A08A3FAB3");
  var_0 scripts\engine\utility::set_movement_speed(25);
  var_0 thread stealth_meter_display_think(var_0);
  var_0 thread stealth_meter_degree_think(var_0);
}

stealth_meter_display_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 endon("_encstr_A1AC132511D183E9A65BC7EF891BF29671982753A7");

  for(;;) {
    var_0 waittill("_encstr_AB8119E2881E6BB5B84B9FBB39F0BE43C50DE9FA9175F7EA7149D7", var_1);
    var_0.spawnposition = var_1;
    show_stealth_meter_to(var_1, var_0);
    var_1 thread ping_enemy_and_player_for_duration(var_0, var_1, 1);
  }
}

ping_enemy_and_player_for_duration(var_0, var_1, var_2) {
  var_1 notify("_encstr_AD50237854DEF7597B68D8E7E87FBFC801015B297F2B684BC924C788176A4B3A6ADBFC4750");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD50237854DEF7597B68D8E7E87FBFC801015B297F2B684BC924C788176A4B3A6ADBFC4750");

  if(!isDefined(var_2))
    var_2 = 3;

  var_1 thread _id_123C4(var_1);
  var_1 setscriptablepartstate("_encstr_8A9D0B574BABD3F81029E5AAC1", "_encstr_BDAD05B9557A69");
  wait(var_2);
  var_1 setscriptablepartstate("_encstr_8A9D0B574BABD3F81029E5AAC1", "_encstr_A7A408B9CA5D1D4E2C63");
}

stopsoundoncompletion(var_0) {
  wait(lookupsoundlength(var_0));
  self.bplayingspecificstealthsound = undefined;
}

increase_stealth_meter(var_0, var_1) {
  if(get_current_stealth_state(var_0) == "_encstr_85BB067A08A3FAB3") {
    var_2 = max(distancesquared(var_0.origin, var_1.origin), 1);
    var_3 = 1 / var_2 * 110889;

    if(var_0.stealth_meter_state == "_encstr_A1B20B69355EAED99A8BAF5BF2")
      var_0.target_stealth_meter_progress = clamp(var_0.current_stealth_meter_progress + var_3, 0, 1);
    else
      var_0.target_stealth_meter_progress = clamp(var_0.target_stealth_meter_progress + var_3, 0, 1);

    var_0 notify("_encstr_86AB17A5E6B193ACB0E695BE9B8EB22C36D11AEBB6ACE856C9");
  }
}

decrease_stealth_meter(var_0, var_1) {
  if(get_current_stealth_state(var_0) == "_encstr_85BB067A08A3FAB3") {
    if(var_0.stealth_meter_state == "_encstr_88EE0B2DCD8DE4B216B996379D")
      var_0.target_stealth_meter_progress = clamp(var_0.current_stealth_meter_progress + var_1, 0, 1);
    else
      var_0.target_stealth_meter_progress = clamp(var_0.target_stealth_meter_progress + var_1, 0, 1);

    var_0 notify("_encstr_B2D5171AF1EEAB3F60971DDF6F30C72F814B521158B5CB77D0");
  }
}

stop_stealth_meter(var_0) {
  var_0.target_stealth_meter_progress = var_0.current_stealth_meter_progress;
  var_0 notify("_encstr_8B3A135A0BF8F089CE99FFE78175C26740B113A7A3");
}

stealth_meter_degree_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 endon("_encstr_A1AC132511D183E9A65BC7EF891BF29671982753A7");
  var_0.current_stealth_meter_progress = 0;
  var_0.target_stealth_meter_progress = 0;
  var_0.stealth_meter_state = "_encstr_8F79084EEB0211E38D73";

  for(;;) {
    if(var_0.current_stealth_meter_progress == var_0.target_stealth_meter_progress)
      var_0.stealth_meter_state = "_encstr_8F79084EEB0211E38D73";
    else {
      var_1 = min(0.2, abs(var_0.target_stealth_meter_progress - var_0.current_stealth_meter_progress));

      if(var_0.target_stealth_meter_progress > var_0.current_stealth_meter_progress)
        var_0.stealth_meter_state = "_encstr_88EE0B2DCD8DE4B216B996379D";
      else {
        var_0.stealth_meter_state = "_encstr_A1B20B69355EAED99A8BAF5BF2";
        var_1 = var_1 * -1;
      }

      var_0.current_stealth_meter_progress = clamp(var_0.current_stealth_meter_progress + var_1, 0, 0.99);

      if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) == 0)
        objective_setprogress(var_0.stealth_meter_objective_id, var_0.current_stealth_meter_progress);

      check_stealth_state_change(var_0);
    }

    var_2 = var_0 scripts\engine\utility::_id_143B9(0.1, "_encstr_8B3A135A0BF8F089CE99FFE78175C26740B113A7A3");

    if(var_2 == "_encstr_8B3A135A0BF8F089CE99FFE78175C26740B113A7A3")
      var_0.target_stealth_meter_progress = var_0.current_stealth_meter_progress;
  }
}

check_stealth_state_change(var_0) {
  if(var_0.current_stealth_meter_progress >= 0.99) {
    var_1 = var_0.spawnposition.name;
    wait 0.1;
    var_0 getbestintersectionpt(var_0, var_1, "_encstr_B2910FCBB0E22BEA7310AFB3EFDB7B7F1D");
  }
}

exit_alert(var_0) {
  delete_stealth_meter(var_0);
}

enter_combat(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");

  if(!istrue(level.global_stealth_broken)) {
    stop_patrol(0);

    if(!_id_132C1(var_0))
      friendly_exit(var_0);

    if(_id_132C5(var_0))
      var_0 thread logevent_spawnviaplayer(var_0);

    level thread global_stealth_broken(var_0);
  }
}

_id_1215D(var_0) {
  var_1 = 5;
  scripts\cp\cp_outline::enable_outline_for_players(var_0, level.players, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_9ACC05B41B7F32");
  var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["_encstr_AD75063D571AE108"], var_1);
  scripts\cp\cp_outline::disable_outline_for_players(var_0, level.players);
}

_id_132C1(var_0) {
  if(bomber_damage_thread(var_0))
    return 1;

  if(istrue(var_0._id_133B9))
    return 1;

  if(isDefined(var_0._id_132C2))
    return [[var_0._id_132C2]](var_0);

  if(!isDefined(level.bonusdeathplunderot))
    level.bonusdeathplunderot = [];

  if(level.bonusdeathplunderot.size > max(2, level.players.size))
    return 1;

  return 0;
}

logevent_spawnviaplayer(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 3;
  waittillframeend;

  if(isDefined(var_0._id_11BD5))
    logevent_challengeitemunlocked(var_0, var_0._id_11BD5, ::keypadscriptableused_altbunker);
  else
    logevent_challengeitemunlocked(var_0, "_encstr_B6D80AD859C6C6C10DDBE62B", ::keypadscriptableused_altbunker);

  wait(var_1);
  var_0 notify("_encstr_93191A0775E24753F969567FCC7393A545BE17475FABF3EFF0985AB2");
}

_id_132C5(var_0) {
  return 1;
}

bomber_damage_thread(var_0) {
  return var_0.agent_type == "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC";
}

friendly_exit(var_0) {
  var_0.bcallingreinforcements = 1;
  level.ai_going_to_alarm = var_0;
  var_0 notify("_encstr_BA22087EA808525BA5D9");
  var_0 childthread goto_alarm_or_nearest_cover();
  var_0 waittill("_encstr_9ABC16497E44489D7247A583F7BA5408F25631ADE7BE404E");
  var_0.bcallingreinforcements = undefined;
  level.ai_going_to_alarm = undefined;
  level.bonusdeathplunderot = [];
}

modified_enter_combat(var_0) {
  if(istrue(self.aggressive) || istrue(self.dont_enter_combat)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");
  scripts\cp\cp_outline::enable_outline_for_players(self, level.players, "_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40", "_encstr_9ACC05B41B7F32");
  self.pacifist_override = undefined;
  self.scripted_mode = 0;
  self.entered_combat = 1;

  if(isDefined(self.script_radius))
    scripts\cp\cp_modular_spawning::set_goal_radius(self.script_radius);
  else if(!istrue(self.is_on_platform))
    scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  else
    scripts\cp\cp_modular_spawning::set_goal_radius(512);

  if(isDefined(self.script_goalheight))
    self.goalheight = self.script_goalheight;
  else
    self.goalheight = 256;

  if(!scripts\cp\cp_modular_spawning::is_specified_unittype("_encstr_8EF60E63FBE3D70440A312175B98CF6B") && !scripts\cp\cp_modular_spawning::is_specified_unittype("_encstr_83E8094727E333E8F9CE50")) {
    self.script_pacifist = undefined;
    self.pacifist = 0;
    thread scripts\cp\cp_modular_spawning::get_enemy_info_loop();
  }

  scripts\cp\cp_modular_spawning::run_combat_func();
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
}

goto_alarm_or_nearest_cover() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = undefined;

  if(isDefined(level.alarm_box_structs))
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, level.alarm_box_structs, undefined, 1, 666);

  if(!isDefined(level.ai_going_to_alarm)) {
    if(isDefined(var_0) && isarray(var_0) && var_0.size > 0) {
      logevent_challengeitemunlocked(self, "_encstr_85BB067A08A3FAB3", ::keypadscriptableused);
      self._id_11BD6 = "_encstr_85BB067A08ABFAD7";
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");
      self.scripted_mode = 1;
      thread _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::run_to_and_set_alarm(var_0[0]);
      level waittill("_encstr_91B909B0D858935BD77BE6");
      self.scripted_mode = 0;
      self notify("_encstr_9ABC16497E44489D7247A583F7BA5408F25631ADE7BE404E");

      foreach(var_2 in var_0)
      var_2 notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");

      foreach(var_5 in getaiarray("_encstr_8E8405EA382B2A")) {
        if(isDefined(var_5.going_to_object)) {
          var_5.going_to_object = undefined;
          var_5.goalradius = 2048;
          var_5 _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::clear_custom_anim();
        }
      }
    }
  } else {
    logevent_challengeitemunlocked(self, "_encstr_85BB067A08A3FAB3", ::keypadscriptableused);

    if(!isDefined(level.bonusdeathplunderot))
      level.bonusdeathplunderot = [];

    level.bonusdeathplunderot[level.bonusdeathplunderot.size] = self;
    var_7 = self findbestcovernode("_encstr_B23B0E52885CFFF289B1E5EE5330BD63", 1, self.origin, 1);

    if(isDefined(var_7)) {
      var_8 = var_7.angles;
      var_9 = var_7.origin;

      if(!issubstr(var_7.type, "_encstr_922406B1A6FD5E05")) {
        if(issubstr(var_7.type, "_encstr_A5AD0568019C63"))
          var_8 = var_8 + (0, 90, 0);
        else if(issubstr(var_7.type, "_encstr_8253061E2B5FE330") || issubstr(var_7.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_7.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_7.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
          var_8 = var_8 - (0, 90, 0);
      }

      scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
      self setgoalnode(var_7);
      self waittill("_encstr_8B7205D9ED5958");
      self setgoalpos(self.origin);
      wait 3;
      scripts\cp\utility::array_notify(getaiarray("_encstr_8E8405EA382B2A"), "_encstr_9ABC16497E44489D7247A583F7BA5408F25631ADE7BE404E");
    } else {
      var_7 = getclosestnodeinsight(self.origin);

      if(isDefined(var_7)) {
        scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
        self.scripted_mode = 1;
        scripts\cp\cp_modular_spawning::set_goal_pos(var_7.origin);
        wait 1;
        self usecovernode(var_7, 1);
        self setgoalnode(var_7);
        wait 3;
        self.scripted_mode = 0;
        scripts\cp\utility::array_notify(getaiarray("_encstr_8E8405EA382B2A"), "_encstr_9ABC16497E44489D7247A583F7BA5408F25631ADE7BE404E");
      } else {
        wait 3;
        scripts\cp\utility::array_notify(getaiarray("_encstr_8E8405EA382B2A"), "_encstr_9ABC16497E44489D7247A583F7BA5408F25631ADE7BE404E");
      }
    }
  }
}

exit_combat(var_0) {}

global_stealth_broken(var_0) {
  if(istrue(level.global_stealth_broken)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  level.global_stealth_broken = 1;
  level.battlechatterenabled = 1;
  level._id_139B5 = 0;
  isenemyteamplayer();

  if(isDefined(level.select_boss_two_spawners))
    [[level.select_boss_two_spawners]](var_0);

  level thread play_combat_music_to_players();
}

i_see_friendly_corpse_watcher(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_93530B91C713410FAFEAC86852");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");

  if(!isDefined(level.enemy_ai_corpse_locations))
    level.enemy_ai_corpse_locations = [];

  var_2 = physics_createcontents(["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);

  for(;;) {
    if(istrue(self.bcallingreinforcements)) {
      wait 1;
      continue;
    }

    foreach(var_4 in level.enemy_ai_corpse_locations) {
      if(distance(var_0.origin, var_4.loc) > var_0.sightmaxdistance) {
        wait 1;
        continue;
      }

      if(!var_0 scripts\engine\math::point_in_fov(var_4.loc, cos(50), 1)) {
        wait 1;
        continue;
      }

      var_5 = angleclamp180(vectortopitch(var_4.loc - var_0.origin));

      if(var_5 < var_0.upaimlimit || var_5 > var_0.downaimlimit) {
        wait 1;
        continue;
      }

      var_6 = scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_4.loc, [var_0], var_2);

      if(var_6) {
        if(istrue(var_1) && allow_to_get_to_corpse(var_4) && corpse_is_too_far_away(var_0, var_4.loc)) {
          level.num_time_getting_to_corpse[var_4.index]++;
          go_check_out_corpse(var_0, var_4, 1);
        }
      }

      wait 1;
    }

    wait 1;
  }
}

go_check_out_corpse(var_0, var_1, var_2) {
  var_0 notify("_encstr_BD9D19BFD3DA068F52DE78F6FB58F078B8225BF1D15E0F604A6B2A");
  var_0.investigating_friendly_corpse = 1;
  var_0 thread change_stealth_state_to(var_0, "_encstr_85BB067A08A3FAB3");
  var_0 show_stealth_meter_to_all_players(var_0);

  if(istrue(var_2)) {
    var_0 stop_patrol(1);
    var_3 = vectorNormalize(var_0.origin - var_1.loc);
    var_4 = getclosestpointonnavmesh(var_1.loc + var_3 * 15);
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_4);
    var_0 scripts\engine\utility::_id_143B9(15, "_encstr_ABA008615A631510C7EA");
    level.enemy_ai_corpse_locations = scripts\engine\utility::array_remove(level.enemy_ai_corpse_locations, var_1);
    check_around_the_area(var_0);
  } else {
    var_0 thread increase_stealth_meter_when_approaching_corpse(var_0, var_1);
    var_0 stop_patrol(1);
    var_0 scripts\engine\utility::set_movement_speed(100);
    var_3 = vectorNormalize(var_0.origin - var_1.loc);
    var_4 = getclosestpointonnavmesh(var_1.loc + var_3 * 15);
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_4);
    var_0 waittill("_encstr_ABA008615A631510C7EA");
  }
}

stop_patrol(var_0) {
  var_1 = self;
  var_1 notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  var_1 notify("_encstr_954F19D3F9ED13058057858BD378CF5F9ED02B0A23D02B7D981B9B");

  if(istrue(var_0))
    var_1 scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
}

show_stealth_meter_to_all_players(var_0) {
  if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) != 0) {
    return;
  }
  foreach(var_2 in level.players)
  show_stealth_meter_to(var_2, var_0);
}

increase_stealth_meter_when_approaching_corpse(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_2 = distancesquared(var_0.origin, var_1.loc) - 40000;
  var_3 = 0;

  for(;;) {
    waitframe();
    var_4 = distancesquared(var_0.origin, var_1.loc);
    var_5 = clamp(1 - var_4 / var_2, 0, 1);
    var_6 = max(var_5, var_3 + 0.05);
    set_stealth_meter_progress(var_0, var_6);
    var_3 = var_6;
  }
}

allow_to_get_to_corpse(var_0) {
  if(!isDefined(level.num_time_getting_to_corpse))
    level.num_time_getting_to_corpse = [];

  if(!isDefined(level.num_time_getting_to_corpse[var_0.index]))
    level.num_time_getting_to_corpse[var_0.index] = 0;

  return level.num_time_getting_to_corpse[var_0.index] < 1;
}

corpse_is_too_far_away(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1) >= 90000;
}

updateaisightonplayer(var_0) {
  self setclientomnvar("_encstr_8F090D605A191B594785485C94BFE3", var_0);
}

sendout_notify_of_vehicle_kill(var_0, var_1) {
  foreach(var_3 in getaiarray("_encstr_8E8405EA382B2A")) {
    if(isDefined(var_0) && var_3 == var_0) {
      continue;
    }
    var_3 notify("_encstr_B4580A0740984DFBF2C57BEB", var_1);
    waitframe();
  }
}

turn_off_hours_later_chyron_text(var_0) {
  return 1;
}

watch_for_ai_events(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  waitframe();
  self notify("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");
  self endon("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");
  var_1 = 2000;

  if(isDefined(self.sightmaxdistance))
    var_1 = self.sightmaxdistance;

  for(;;) {
    self waittill("_encstr_B4580A0740984DFBF2C57BEB", var_2);

    if(istrue(self.bcallingreinforcements)) {
      waitframe();
      continue;
    }

    var_3 = self getapproxeyepos();

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(!turn_off_hours_later_chyron_text(var_5)) {
        waitframe();
        continue;
      }

      if(scripts\cp\cp_modular_spawning::has_func_for_aievent(var_5.type))
        scripts\cp\cp_modular_spawning::run_aievent_func(var_5.type, var_2);

      if(var_5.type == "_encstr_88BF06FD784A6393") {
        if(isDefined(var_5.entity) && isPlayer(var_5.entity)) {
          var_7 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);

          if(var_7) {
            if(istrue(var_5.entity.disguised)) {
              if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                waitframe();
                continue;
              }
            } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
              waitframe();
              continue;
            }

            var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

            if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
              waitframe();
              continue;
            }

            var_5.type = "_encstr_92610E68A21F93622F2EEBDE19F3085B";
          } else {
            waitframe();
            continue;
          }
        } else {
          waitframe();
          continue;
        }
      }

      if(var_5.type == "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C") {
        var_7 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);

        if(var_7) {
          if(istrue(var_5.entity.disguised)) {
            if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
              waitframe();
              continue;
            }
          } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
            waitframe();
            continue;
          }

          var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

          if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
            waitframe();
            continue;
          }
        }

        self setlookat(var_5.entity.origin, 1);
      } else if(var_5.type == "_encstr_A5490D5E05C3F8B363F3C8D83B3E43" || var_5.type == "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA" || var_5.type == "_encstr_92FD082A30066B713094" || var_5.type == "_encstr_A6DC0F7BB12B87FE48FB67289BF089DFC5") {
        if(isPlayer(var_5.entity)) {
          if(var_5.type == "_encstr_A5490D5E05C3F8B363F3C8D83B3E43") {
            if(!scripts\cp\killstreaks\init_cp::gastrap_dmg_trig(var_5.entity getcurrentweapon()))
              continue;
          }

          if(var_5.type == "_encstr_A6DC0F7BB12B87FE48FB67289BF089DFC5") {
            var_9 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);
            var_10 = isDefined(var_5.entity.vehicle) && self cansee(var_5.entity.vehicle) && sighttracepassed(var_3, var_5.entity.vehicle.origin, 0, self);

            if(var_9 || var_10) {
              if(istrue(var_5.entity.disguised)) {
                if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                  waitframe();
                  continue;
                }
              } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
                waitframe();
                continue;
              }

              var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

              if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
                waitframe();
                continue;
              }

              var_5.type = "_encstr_A6DC0F7BB12B87FE48FB67289BF089DFC5";
            }
          } else if(!istrue(self.stack_patch_waittill_context_patch) && var_5.entity scripts\cp\cp_weapon::player_has_silencer(var_5.entity getcurrentweapon())) {
            var_7 = self cansee(var_5.entity) && sighttracepassed(var_3, var_5.entity getEye(), 0, self);

            if(var_7) {
              if(istrue(var_5.entity.disguised)) {
                if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                  waitframe();
                  continue;
                }
              } else if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance) {
                waitframe();
                continue;
              }

              var_8 = angleclamp180(vectortopitch(var_5.entity.origin - self.origin));

              if(var_8 < self.upaimlimit || var_8 > self.downaimlimit) {
                waitframe();
                continue;
              }

              var_5.type = "_encstr_91F710B9A1BDA3AF664BC92B8CFADCB256CD";
            } else
              var_5.type = "_encstr_AA300EBF415D43B0F85A6159731058AB";
          }
        }
      }

      switch (var_5.type) {
        case "_encstr_92610E68A21F93622F2EEBDE19F3085B":
          if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          else
            i_saw_player(self, var_5.entity, var_0);

          break;
        case "_encstr_86B313706A35191E63693EBD7C5FE0E75B63485862":
          if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          else
            i_saw_player(self, var_5.entity, var_0);

          break;
        case "_encstr_91F710B9A1BDA3AF664BC92B8CFADCB256CD":
          if(distancesquared(self.origin, var_5.entity.origin) <= 10000) {
            level thread play_enemy_radio_chat(processassist_regularcp(), self);
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          } else if(did_anyone_see_this(self, var_5.entity.origin, var_1, 1, var_5.entity.origin)) {
            level thread play_enemy_radio_chat(receivingampeddamage(), self);
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          } else if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          else
            i_saw_player(self, var_5.entity, var_0);

          break;
        case "_encstr_AA300EBF415D43B0F85A6159731058AB":
        case "_encstr_A6DC0F7BB12B87FE48FB67289BF089DFC5":
          if(did_anyone_see_this(self, var_5.origin, var_1, 1, var_5.origin)) {
            level thread play_enemy_radio_chat(receivingampeddamage(), self);
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          } else if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3")
            enemy_ai_enter_alert(self, var_5.entity, var_0, var_5.type);
          else
            i_saw_player(self, var_5.entity, var_0);

          break;
        case "_encstr_AA140ECCF6BD3A9BA35983D7BB1663DA":
        case "_encstr_8C8E09632740B3834849C2":
        case "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C":
          var_9 = self cansee(var_5.entity) && sighttracepassed(self getEye(), var_5.entity getEye(), 0, self);

          if(var_9) {
            if(istrue(var_5.entity.disguised)) {
              if(distance(self.origin, var_5.entity.origin) > self.sightmaxdistance / 6) {
                waitframe();
                break;
              }
            }

            level thread play_enemy_radio_chat(receivingampeddamage(), self);
            thread delay_enter_combat(self, var_5.type, var_5.entity);
          }

          break;
        case "_encstr_9A211D31C9B2165BEBB9D1AC1663A3A1BEBBA51D1AEB737BFAC8B0AD0BECB2":
        case "_encstr_928E112F37025EA89FEB168B577948992A9B93":
        case "_encstr_92FD082A30066B713094":
        case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
        case "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001":
        case "_encstr_860808CB78E2984063BA":
          if(istrue(self.compare_higher_score)) {
            waitframe();
            break;
          }

          level thread play_enemy_radio_chat(processassist_regularcp(), self);
          thread delay_enter_combat(self, var_5.type, var_5.entity);
          break;
        default:
          break;
      }
    }
  }
}

vehicle_hit_event(var_0, var_1) {
  if(did_anyone_see_this(var_0, var_1, 2000, 1, var_1))
    return;
}

delay_enter_combat(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  self notify("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");

  if(!(isDefined(var_2) && isPlayer(var_2)))
    var_2 = quickdropremoveselfrevivetokenfrominventory(var_0.origin, ::quickdropremoveweaponfrominventory);

  wait 0.75;
  var_0 getbestintersectionpt(var_0, var_2.name, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
}

i_see_player_watcher(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_93530B91C713410FAFEAC86852");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 thread seeing_player_time_tracker(var_0);

  if(!isDefined(var_4))
    var_4 = 1024;

  for(;;) {
    var_0 waittill("_encstr_A9980CD206D783ADA12A30A07283", var_5, var_6, var_7, var_8);

    if(istrue(var_0.bcallingreinforcements)) {
      waitframe();
      continue;
    }

    if(!isent(var_5) || !isPlayer(var_5)) {
      continue;
    }
    if(player_in_concealment_area(var_5)) {
      continue;
    }
    var_9 = var_0.sightmaxdistance;
    var_9 = var_9 * var_5.perk_data["_encstr_995214C2933079D235D97F6B235E9B8F58D9FE8DA9E0"];

    if(istrue(var_5.disguised))
      var_9 = var_9 / 6;

    if(distance(var_0.origin, var_5.origin) > var_9) {
      waitframe();
      continue;
    }

    if(var_5.origin[2] - var_0.origin[2] > var_4) {
      waitframe();
      continue;
    }

    var_10 = angleclamp180(vectortopitch(var_5.origin - var_0.origin));

    if(var_10 < var_0.upaimlimit || var_10 > var_0.downaimlimit) {
      waitframe();
      continue;
    }

    var_11 = var_0 getapproxeyepos();
    var_12 = var_5 getEye();
    var_13 = anglesToForward(var_0.angles);
    var_14 = vectorNormalize(var_12 - var_11);
    var_15 = vectordot(var_14, var_13);

    if(var_15 < var_2) {
      waitframe();
      continue;
    }

    var_16 = 0;

    if(var_5 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      if(scripts\engine\trace::ray_trace_passed(var_11, var_5.vehicle.origin, var_0, scripts\engine\trace::create_vehicle_contents()))
        var_16 = 1;
    } else
      var_16 = var_0 cansee(var_5) && sighttracepassed(var_11, var_12, 0, var_0);

    if(var_16) {
      if(distancesquared(var_0.origin, var_5.origin) <= var_3) {
        var_0 getbestintersectionpt(var_0, var_5.name, "_encstr_B2910FCBB0E22BEA7310AFB3EFDB7B7F1D");
        continue;
      }

      if(get_current_stealth_state(self) != "_encstr_85BB067A08A3FAB3") {
        enemy_ai_enter_alert(var_0, var_5, var_1);
        continue;
      }

      i_saw_player(var_0, var_5, var_1);
    }
  }
}

i_saw_player(var_0, var_1, var_2) {
  var_0 notify("_encstr_AB8119E2881E6BB5B84B9FBB39F0BE43C50DE9FA9175F7EA7149D7", var_1);
  mark_seen_this_player_this_frame(var_0, var_1);

  if(has_seen_any_player_long_enough_to_trigger_alert(var_0))
    enemy_ai_enter_alert(var_0, var_1, var_2);

  increase_stealth_meter(var_0, var_1);
}

display_combat_icon_to_player(var_0) {
  var_0 thread delay_delete_combat_icon(var_0);

  foreach(var_2 in level.players)
  show_combat_icon_to(var_2, var_0);
}

logevent_challengeitemunlocked(var_0, var_1, var_2) {
  var_0._id_12B4C = var_1;

  foreach(var_4 in level.players)
  _id_13336(var_4, var_0, var_2);
}

keypadscriptableused(var_0, var_1, var_2) {
  var_3 = var_2 getentitynumber();
  var_4 = var_2 scripts\engine\utility::waittill_any_ents_return(var_2, "_encstr_AD75063D571AE108", var_2, "_encstr_9ABC16497E44489D7247A583F7BA5408F25631ADE7BE404E", level, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  laser_func(var_0, var_1, var_2, var_3);
}

keypadscriptableused_altbunker(var_0, var_1, var_2) {
  var_3 = var_2 getentitynumber();
  var_4 = var_2 scripts\engine\utility::waittill_any_ents_return(var_2, "_encstr_AD75063D571AE108", var_2, "_encstr_93191A0775E24753F969567FCC7393A545BE17475FABF3EFF0985AB2");
  laser_func(var_0, var_1, var_2, var_3);
}

delay_delete_combat_icon(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 3;
  delete_combat_icon(var_0);
}

get_player_with_player_id(var_0) {
  foreach(var_2 in level.players) {
    var_3 = var_2 getentitynumber();

    if(var_3 == var_0)
      return var_2;
  }
}

enemy_ai_enter_alert(var_0, var_1, var_2, var_3, var_4) {
  if(get_current_stealth_state(var_0) != "_encstr_85BB067A08A3FAB3") {
    if(isDefined(var_1) && isPlayer(var_1))
      display_warning_message_to_player(var_1, var_3);

    var_0 thread change_stealth_state_to(var_0, "_encstr_85BB067A08A3FAB3");

    if(istrue(var_2))
      var_0 thread select_bunker_interior_one_spawners(var_0, var_1, var_4, propwaitminigamerun(var_1));
  }
}

propwaitminigamerun(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0))
    var_1 = var_0.name;
  else
    var_1 = var_0.owner.name;
}

select_bunker_interior_one_spawners(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  level thread play_enemy_radio_chat(processlobbydataforclient(), var_0);
  var_0 notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");
  waitframe();
  var_0.goalradius = 128;
  var_0 stop_patrol(1);
  var_0 scripts\engine\utility::set_movement_speed(75);
  var_0 scripts\cp\cp_modular_spawning::set_goal_pos(get_investigate_loc(var_0, var_1.origin));
  var_0 waittill("_encstr_8B7205D9ED5958");

  if(isDefined(var_2) && [[var_2]](var_1))
    var_0 thread kickplayersatcircleedge(var_0, var_3);

  check_around_the_area(var_0);
  level thread play_enemy_radio_chat(prevbrbonusxp(), var_0);
  var_0 thread change_stealth_state_to(var_0, "_encstr_914B078DB09BAB0BB1");
  var_0 scripts\cp\cp_modular_spawning::start_patrol();
}

kickplayersatcircleedge(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  logevent_challengeitemunlocked(var_0, "_encstr_85BB067A08A3FAB3", ::keypadscriptableused);
  wait 3;
  var_0 getbestintersectionpt(var_0, var_1, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
}

play_enemy_radio_chat(var_0, var_1) {
  if(isDefined(var_1) && isai(var_1) && isalive(var_1)) {
    var_1 notify("_encstr_B19C161CD8C25EFACAB9955BE5FA2785324BB77DD81AB0D1");
    var_1 endon("_encstr_B19C161CD8C25EFACAB9955BE5FA2785324BB77DD81AB0D1");
    var_1 endon("_encstr_AD75063D571AE108");
    var_1.trucks_intel_sequence = 1;
    var_1 playsoundonmovingent(var_0);
    wait(lookupsoundlength(var_0) / 1000);
    var_1.trucks_intel_sequence = 0;
  } else {
    scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08");
    wait(lookupsoundlength(var_0) / 1000);
    play_enemy_radio_beep();
  }
}

play_enemy_radio_beep() {
  foreach(var_1 in level.players)
  var_1 playlocalsound("_encstr_8F1F1D2FCDFBE391CDB94E0FD5A1B118C02156033173D8D0882EC87FC8E783");

  wait(lookupsoundlength("_encstr_8F1F1D2FCDFBE391CDB94E0FD5A1B118C02156033173D8D0882EC87FC8E783") / 1000);
}

get_investigate_loc(var_0, var_1) {
  var_2 = vectorNormalize(var_0.origin - var_1);
  var_3 = var_1 + var_2 * randomfloatrange(75, 125);
  return getclosestpointonnavmesh(var_3);
}

check_around_the_area(var_0) {
  wait(randomfloatrange(0.75, 1.5));

  if(istrue(var_0.using_goto_node)) {
    if(isDefined(var_0.currentnode))
      var_0 thread scripts\cp\cp_modular_spawning::go_to_node(var_0.currentnode);
  } else {
    var_1 = randomintrange(2, 4);
    var_0 scripts\cp\cp_modular_spawning::set_goal_radius(36);
    var_0 scripts\engine\utility::set_movement_speed(25);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
      var_4 = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
      var_5 = (var_0.origin[0] + var_3, var_0.origin[1] + var_4, var_0.origin[2]);
      var_0 scripts\cp\cp_modular_spawning::set_goal_pos(getclosestpointonnavmesh(var_5));
      var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_8B7205D9ED5958", 5);
      wait(randomfloatrange(0.75, 1.5));
    }

    var_0 scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
  }
}

display_warning_message_to_player(var_0, var_1) {
  if(!isDefined(var_0.next_warning_message_time))
    var_0.next_warning_message_time = 0;

  var_2 = gettime();

  if(var_2 > var_0.next_warning_message_time)
    var_0.next_warning_message_time = var_2 + 1000;
}

has_seen_any_player_long_enough_to_trigger_alert(var_0) {
  return has_seen_any_player_long_enough(var_0, 0.1);
}

has_seen_any_player_long_enough(var_0, var_1) {
  foreach(var_4, var_3 in var_0.time_seeing_players) {
    if(var_3 >= var_1)
      return 1;
  }

  return 0;
}

mark_seen_this_player_this_frame(var_0, var_1) {
  var_0.player_most_recently_saw = var_1;
  var_2 = var_1 getentitynumber();

  if(!isDefined(var_0.time_seeing_players))
    var_0 thread seeing_player_time_tracker(var_0);

  if(!isDefined(var_0.time_seeing_players[var_2]))
    var_0.time_seeing_players[var_2] = 0;
}

_id_14458() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_97821DBB2CE8B143BE66BD93F563593B95B1D7DDAC58837BDCDC7DCC9356CA");
  self endon("_encstr_97821DBB2CE8B143BE66BD93F563593B95B1D7DDAC58837BDCDC7DCC9356CA");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_93530B91C713410FAFEAC86852");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  self aieventlistenerevent("_encstr_AA7C07466F9DA30713", self, self.origin);
}

seeing_player_time_tracker(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 notify("_encstr_8D8C1BF877A98F7D7A79E368718F416A51FB3B312111B448EE377F957B");
  var_0 endon("_encstr_8D8C1BF877A98F7D7A79E368718F416A51FB3B312111B448EE377F957B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_93530B91C713410FAFEAC86852");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0.player_most_recently_saw = undefined;
  var_0.time_seeing_players = [];
  var_1 = 0;

  for(;;) {
    if(isDefined(var_0.player_most_recently_saw))
      var_1 = 0;
    else
      var_1 = var_1 + 0.1;

    foreach(var_4, var_3 in var_0.time_seeing_players) {
      if(isDefined(var_0.player_most_recently_saw) && var_4 == var_0.player_most_recently_saw getentitynumber()) {
        var_0.time_seeing_players[var_4] = var_0.time_seeing_players[var_4] + 0.1;
        var_0.player_most_recently_saw = undefined;
        continue;
      }

      var_0.time_seeing_players[var_4] = max(var_0.time_seeing_players[var_4] - 0.05, 0);
    }

    foreach(var_6 in level.players) {
      var_4 = var_6 getentitynumber();

      if(isDefined(var_0.time_seeing_players[var_4]) && var_0.time_seeing_players[var_4] == 0)
        hide_stealth_meter_from(var_6, var_0);
    }

    if(var_1 >= 0.5)
      stop_stealth_meter(var_0);

    wait 0.1;
  }
}

player_in_concealment_area(var_0) {
  return istrue(var_0.tracking_munitions_purchase);
}

_id_11A86(var_0, var_1) {
  if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) != 0) {
    return;
  }
  if(sg_respawn(var_0)) {
    return;
  }
  var_2 = ragdoll_on_vehicle_death(var_0);
  var_3 = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_3, var_2);
  addclienttoheadiconmask(var_3, 10);
  setheadicondrawthroughgeo(var_3, 0);
  setheadiconzoffset(var_3, 1);
  setheadiconsnaptoedges(var_3, 5000);
  setheadiconmaxdistance(var_3, 500);
  var_4 = scripts\cp\cp_objectives::requestworldid("_encstr_874C143A18A33D87B6F719178ED89F86D3A00170F17F" + var_0 getentitynumber(), 22);
  objective_state(var_4, "_encstr_930B07BB1B6B3854FF");
  objective_icon(var_4, var_2);
  objective_setbackground(var_4, 1);
  objective_removeallfrommask(var_4);
  objective_setplayoutro(var_4, 0);
  objective_setshowdistance(var_4, 0);
  objective_setshowprogress(var_4, 0);
  objective_setfadedisabled(var_4, 1);
  objective_sethot(var_4, 1);
  objective_setpulsate(var_4, 1);
  objective_setshowoncompass(var_4, 1);
  objective_onentity(var_4, var_0);
  var_0 thread[[var_1]](var_4, var_3, var_0);
  var_0._id_12B4A = var_4;
}

ragdoll_on_vehicle_death(var_0) {
  switch (var_0._id_12B4C) {
    case "_encstr_85BB067A08A3FAB3":
      return "_encstr_BA200A3C8B237F0A21DBC3D3";
    case "_encstr_85BB067A08ABFAD7":
      return "_encstr_86941BE38B926FE0AB7FC8490BC5B9418973EFFEE52BFFEE916BC83827";
    case "_encstr_B6D80AD859C6C6C10DDBE62B":
      return "_encstr_BA981F39F5F01F50FBA090BF83508B12F183BB93A2790A892F60CC09BB8AA2EDC8";
    case "_encstr_87780C7A5D1908C8BDD1AE70F7C2":
      return "_encstr_8ADF1B80A0B99F1B38B71EB93B9FF151D66783087BB3599DB6E2E04D88";
  }
}

_id_11A7B(var_0) {
  if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) != 0) {
    return;
  }
  if(has_combat_icon(var_0)) {
    return;
  }
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_874C143A18A33D87B6F719178ED89F86D3A00170F17F" + var_0 getentitynumber(), 22);
  objective_state(var_1, "_encstr_930B07BB1B6B3854FF");
  objective_icon(var_1, "_encstr_8D6B11D0AEC8BE4B6CBDB9EBB9D1950BD8470D");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 90);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 0);
  objective_setshowprogress(var_1, 1);
  objective_setfadedisabled(var_1, 1);
  objective_sethot(var_1, 1);
  objective_setpulsate(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  var_0.combat_icon_objective_id = var_1;
}

make_stealth_meter_on_ai(var_0) {
  if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) != 0) {
    return;
  }
  if(has_stealth_meter(var_0)) {
    return;
  }
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_8F5C15753DD7275B3F865CD71E217729F8132B4F89F93F" + var_0 getentitynumber(), 21);
  objective_state(var_1, "_encstr_930B07BB1B6B3854FF");
  objective_icon(var_1, "_encstr_8D6B11D0AEC8BE4B6CBDB9EBB9D1950BD8470D");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 90);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 0);
  objective_setshowprogress(var_1, 1);
  objective_setprogress(var_1, 0);
  objective_setfadedisabled(var_1, 1);
  objective_sethot(var_1, 1);
  objective_setpulsate(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  var_0.showing_the_stealth_meter_to_players = [];
  var_0.stealth_meter_objective_id = var_1;
  var_0 thread clear_up_stealth_meter_when_enter_combat(var_0);
}

clear_up_stealth_meter_when_enter_combat(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_92600D68A25B83032F3BE8D112FF0B");
  delete_stealth_meter(var_0);
}

show_stealth_meter_to(var_0, var_1) {
  if(!has_stealth_meter(var_1))
    make_stealth_meter_on_ai(var_1);

  if(is_showing_stealth_meter_to(var_0, var_1)) {
    return;
  }
  var_1.showing_the_stealth_meter_to_players[var_1.showing_the_stealth_meter_to_players.size] = var_0;
  objective_addclienttomask(var_1.stealth_meter_objective_id, var_0);
}

show_combat_icon_to(var_0, var_1) {
  if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) != 0) {
    return;
  }
  if(!has_combat_icon(var_1))
    _id_11A7B(var_1);

  objective_addclienttomask(var_1.combat_icon_objective_id, var_0);
}

_id_13336(var_0, var_1, var_2) {
  if(istrue(level.little_bird_mg_handleflarerecharge)) {
    return;
  }
  if(getdvarint("_encstr_83CC16DC36397D0734A9F5915A6E2C313656F5D21BEDDCE6", 0) != 0) {
    return;
  }
  if(!sg_respawn(var_1))
    _id_11A86(var_1, var_2);

  objective_addclienttomask(var_1._id_12B4A, var_0);
}

set_stealth_meter_progress(var_0, var_1) {
  if(get_current_stealth_state(var_0) == "_encstr_85BB067A08A3FAB3")
    var_0.target_stealth_meter_progress = var_1;
}

hide_stealth_meter_from(var_0, var_1) {
  if(!has_stealth_meter(var_1)) {
    return;
  }
  if(!is_showing_stealth_meter_to(var_0, var_1)) {
    return;
  }
  var_1.showing_the_stealth_meter_to_players = scripts\engine\utility::array_remove(var_1.showing_the_stealth_meter_to_players, var_0);
  objective_removeclientfrommask(var_1.stealth_meter_objective_id, var_0);

  if(var_1.showing_the_stealth_meter_to_players.size == 0)
    var_1.spawnposition = undefined;
}

is_showing_stealth_meter_to(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.showing_the_stealth_meter_to_players, var_0);
}

has_stealth_meter(var_0) {
  return isDefined(var_0.stealth_meter_objective_id);
}

has_combat_icon(var_0) {
  return isDefined(var_0.combat_icon_objective_id);
}

sg_respawn(var_0) {
  return isDefined(var_0._id_12B4A);
}

delete_stealth_meter(var_0) {
  if(has_stealth_meter(var_0)) {
    scripts\cp\cp_objectives::freeworldid("_encstr_8F5C15753DD7275B3F865CD71E217729F8132B4F89F93F" + var_0 getentitynumber());
    objective_delete(var_0.stealth_meter_objective_id);
    var_0.stealth_meter_objective_id = undefined;
    var_0 notify("_encstr_A1AC132511D183E9A65BC7EF891BF29671982753A7");
  }
}

delete_combat_icon(var_0) {
  if(has_combat_icon(var_0)) {
    scripts\cp\cp_objectives::freeworldid("_encstr_874C143A18A33D87B6F719178ED89F86D3A00170F17F" + var_0 getentitynumber());
    objective_delete(var_0.combat_icon_objective_id);
    var_0.combat_icon_objective_id = undefined;
    var_0 notify("_encstr_A1AC132511D183E9A65BC7EF891BF29671982753A7");
  }
}

laser_func(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_objectives::freeworldid("_encstr_A3741B56E62B6B97EBA092FA9C564BB9CCEDC9C656B695DC8EF59444EB" + var_3);
  objective_delete(var_0);
  var_2._id_12B4A = undefined;
  setheadiconimage(var_1);
  var_2 notify("_encstr_A1AC132511D183E9A65BC7EF891BF29671982753A7");
}

did_anyone_see_this(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getaiarray("_encstr_8E8405EA382B2A");
  var_7 = var_2 * var_2;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = var_1;

  var_8 = 3;
  var_9 = 0;

  foreach(var_11 in var_6) {
    if(var_0 == var_11) {
      if(!isDefined(var_0.times_hit))
        var_0.times_hit = 1;
      else
        var_0.times_hit++;

      if(var_0.times_hit > 1)
        return 1;
      else
        continue;
    }

    if(!isalive(var_11)) {
      continue;
    }
    var_12 = distancesquared(var_11.origin, var_1);

    if(var_12 > var_7) {
      continue;
    }
    if(isDefined(var_5) && var_12 <= var_5 * var_5) {
      continue;
    }
    if(!var_11 hastacvis(var_4, var_3)) {
      if(var_3 && !var_11 aipointinfov(var_1)) {
        continue;
      }
      var_9++;

      if(var_9 > var_8) {
        waitframe();
        var_9 = 0;
      }

      if(!sighttracepassed(var_11 getEye(), var_1, 0, var_0))
        continue;
    }

    return 1;
  }

  return 0;
}

increase_script_maxdist(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\cp_modular_spawning::process_module_var(var_0, var_0.spawn_points);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_6.script_maxdist = 20000;
  }
}

flash_crate_update_hint_logic_alt() {
  level.flash_icon_extraction = 0;
  var_0 = 2;
  level.flash_group = getEnt("_encstr_A3DC0A26BA6ED0BE47E42DEC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.flashbang_ai = [];
  var_1 = scripts\engine\utility::getStructArray("_encstr_92520AC457371AEBE9BDCD56", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray("_encstr_A1E50CAD8DB3307F8008CDD7DB6B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.flash_group)) {
    return;
  }
  var_3 = gettime();

  foreach(var_5 in var_1) {
    var_6 = [];
    var_7 = var_5.origin;
    var_8 = var_5.radius * var_5.radius;

    foreach(var_10 in var_2) {
      if(!isDefined(var_10) || istrue(var_10.should_break_stealth_immediately_func)) {
        continue;
      }
      if(scripts\engine\utility::distance_2d_squared(var_10.origin, var_7) < var_8) {
        var_6[var_6.size] = [var_10.origin, (var_10.radius + var_0) * (var_10.radius + var_0)];
        var_10.should_break_stealth_immediately_func = 1;
      }
    }

    level.flashbang_ai[level.flashbang_ai.size] = [var_7, var_8, var_6];
  }

  scripts\engine\utility::deletestructarray("_encstr_92520AC457371AEBE9BDCD56", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::deletestructarray("_encstr_A1E50CAD8DB3307F8008CDD7DB6B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread _id_124B6();
}

_id_124B6() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players)
  var_1 thread _id_11CD6(var_1);

  level thread flash_crate_use();
}

flash_crate_use() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread _id_11CD6(var_0);
  }
}

_id_11CD6(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 100;
  var_2 = 0.1;

  for(;;) {
    wait(var_2);
    var_0.tracking_munitions_purchase = 0;

    if(var_0 istouching(level.flash_group)) {
      var_0.tracking_munitions_purchase = 1;
      continue;
    }

    var_3 = propcircleindex(var_0);

    if(!isDefined(var_3)) {
      continue;
    }
    foreach(var_5 in var_3[2]) {
      var_6 = var_5[0];
      var_7 = var_5[1];

      if(scripts\engine\utility::distance_2d_squared(var_6, var_0.origin) < var_7 && abs(var_6[2] - var_0.origin[2]) < var_1) {
        var_0.tracking_munitions_purchase = 1;
        continue;
      }
    }
  }
}

propcircleindex(var_0) {
  foreach(var_2 in level.flashbang_ai) {
    if(scripts\engine\utility::distance_2d_squared(var_0.origin, var_2[0]) < var_2[1])
      return var_2;
  }

  return undefined;
}

tryspawnscriptableparenting() {
  if(!scripts\engine\utility::flag_exist("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA"))
    return 0;

  return scripts\engine\utility::flag("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA");
}

attachdrill() {
  setDvar("_encstr_83C0162C4BFA2BCEAC733A88966EA315F00E1BB7B92DBDB9", 2048);
  setDvar("_encstr_8B4C142CB4F5AC6759E6D111969B4774D5E6A9A1EDD1", 1024);
  setDvar("_encstr_ABC015C2967D2B9D59DC3A222DE6D191F67B47B93AAC0E", 128);
  setDvar("_encstr_966619F184BFC8DCBA4B1189AF232519579DDB0B6BED1804D26B27", 64);
  setDvar("_encstr_8AE11B8940CF772508B50461239F13C0506781867B72200EF2E290C888", 200);
  scripts\engine\utility::flag_set("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA");
  level thread serverroomtvs();
  level thread _id_12665();
  level thread _id_12655();
}

_id_12655() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  level notify("_encstr_AD771D37151AFBA9723709D02BBDCD03F2FF38B42C439BD645AF88A81BDFDB");
  level endon("_encstr_AD771D37151AFBA9723709D02BBDCD03F2FF38B42C439BD645AF88A81BDFDB");

  foreach(var_1 in level.players)
  var_1 thread _id_124A7(var_1);

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 thread killstreak_createobjective_engineer(var_1);
  }
}

killstreak_createobjective_engineer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 scripts\engine\utility::_id_143A5("_encstr_B4C40E582257FDB09BB4077FC103B8B0", "_encstr_97C91ADBABD92885316B0F314B1A43707985C1D6D3097828AA76AF81");
  var_0 thread _id_124A7(var_0);
}

_id_124A7(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 notify("_encstr_B89D1C1CC6585E5993EBD993B2738591ACBE99A5E459EBD6DBCDB43AED27");
  var_0 endon("_encstr_B89D1C1CC6585E5993EBD993B2738591ACBE99A5E459EBD6DBCDB43AED27");

  for(;;) {
    var_0 waittill("_encstr_9B620D8F0DC07577C551F16A3826BF");
    var_0.waittill_any_timeout_no_endon_death_2 = gettime();
  }
}

quit_game_in() {
  var_0 = undefined;
  var_1 = -1;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(isDefined(var_3.waittill_any_timeout_no_endon_death_2) && var_3.waittill_any_timeout_no_endon_death_2 > var_1) {
      var_0 = var_3;
      var_1 = var_3.waittill_any_timeout_no_endon_death_2;
    }
  }

  return var_0;
}

_id_12665() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  level notify("_encstr_88811D076385E5599337F577598507EDE67D33A52795C87DB5B7DC9647B793");
  level endon("_encstr_88811D076385E5599337F577598507EDE67D33A52795C87DB5B7DC9647B793");

  foreach(var_1 in level.players)
  var_1 thread _id_12506(var_1);

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 thread killstreak_loadout_state(var_1);
  }
}

killstreak_loadout_state(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 scripts\engine\utility::_id_143A5("_encstr_B4C40E582257FDB09BB4077FC103B8B0", "_encstr_97C91ADBABD92885316B0F314B1A43707985C1D6D3097828AA76AF81");
  var_0 thread _id_12506(var_0);
}

_id_12506(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 notify("_encstr_A2241C821090E1C2B6375FEFB35FAA3EB9F97C8AA9D0BF1AB77D2FA38706");
  var_0 endon("_encstr_A2241C821090E1C2B6375FEFB35FAA3EB9F97C8AA9D0BF1AB77D2FA38706");

  for(;;) {
    var_0 waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    var_0.waittill_player_dropkit_crate_used = gettime();
  }
}

quickdropremoveselfrevivetokenfrominventory(var_0, var_1) {
  var_2 = [[var_1]]();

  if(isDefined(var_2))
    return var_2;

  return projectiledeleteonnote(var_0);
}

projectiledeleteonnote(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::getclosest(var_0, var_1);
}

quickdropremoveweaponfrominventory() {
  var_0 = undefined;
  var_1 = -1;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(isDefined(var_3.waittill_player_dropkit_crate_used) && var_3.waittill_player_dropkit_crate_used > var_1) {
      var_0 = var_3;
      var_1 = var_3.waittill_player_dropkit_crate_used;
    }
  }

  return var_0;
}

isenemyteamplayer() {
  setDvar("_encstr_83C0162C4BFA2BCEAC733A88966EA315F00E1BB7B92DBDB9", 1024);
  setDvar("_encstr_8B4C142CB4F5AC6759E6D111969B4774D5E6A9A1EDD1", 1024);
  setDvar("_encstr_92681B6F27989783B7D823C5C3FF7177C0930BF6DC0D280BC6FFBA1F30", 384);
  setDvar("_encstr_ABC015C2967D2B9D59DC3A222DE6D191F67B47B93AAC0E", 256);
  setDvar("_encstr_966619F184BFC8DCBA4B1189AF232519579DDB0B6BED1804D26B27", 128);
  setDvar("_encstr_8AE11B8940CF772508B50461239F13C0506781867B72200EF2E290C888", 400);
  scripts\engine\utility::flag_clear("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA");
}

serverroomtvs() {
  level endon("_encstr_86061BE774A7F0C1236A0EB3821B85F83DFF6FC7098EE09BC3126379FA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_0, var_1, var_2);

    switch (var_1) {
      case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
        level thread _id_11E31(4194304, 2, var_0, 1, var_2);
        break;
      case "_encstr_B6AA0DDCAEB4C64B46B27DD9599B1D":
        level thread _id_11E31(4194304, 2, var_0, 1, var_2);
        break;
      case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
        level thread _id_11E31(4194304, 2, var_0, 1, var_2);
        break;
      case "_encstr_BA730BF8AFF178988293F158B9":
        level thread _id_11E31(4194304, 2, var_0, 1, var_2);
        break;
      case "_encstr_9AAE0876FCB7603101DB":
        level thread _id_11E31(4194304, 2, var_0, 1, var_2);
        break;
      case "_encstr_92A70ABB8267F5E0D89F6351":
        level thread _id_11E31(4194304, 2, var_0, 1.8, var_2);
        break;
      case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
        _id_11E32(1048576, 1, var_0, var_1, ::_id_132D1, var_2);
        break;
      case "_encstr_81430B218B3F7018458997D78A":
        level thread _id_11E31(4194304, 2, var_0, 0.6, var_2);
        break;
      case "_encstr_99410C4B48C39AB7D0CD95B769DB":
        level thread _id_11E31(4194304, 2, var_0, 0.6, var_2);
        break;
      case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
        level thread _id_11E31(4194304, 2, var_0, 0.6, var_2);
        break;
      case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        level thread _id_11E31(4194304, 2, var_0, 0.75, var_2);
        break;
      case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
        _id_11E32(4194304, 2, var_0, var_1, ::_id_132CF, var_2);
        break;
      case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
        _id_11E32(4194304, 2, var_0, var_1, ::_id_132D0, var_2);
        break;
      case "_encstr_B8D30758E3EE7827BA":
        _id_11E32(4194304, 2, var_0, var_1, ::_id_132CE, var_2);
        break;
      case "_encstr_BE8B116725FA28FB5178B2CF85017912618763":
        _id_11E32(9437184, 2, var_0, var_1, ::_id_132CD, var_2);
        break;
      default:
        return;
    }
  }
}

_id_11E31(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    if(isvector(var_2))
      var_5 = quickdropremoveselfrevivetokenfrominventory(var_2, ::quit_game_in);
    else
      var_5 = quickdropremoveselfrevivetokenfrominventory(var_2.origin, ::quit_game_in);

    var_4 = var_5.name;
  }

  wait(var_3);

  if(isvector(var_2))
    var_6 = prematchloadoutindex(var_2, var_0, var_1);
  else
    var_6 = prematchloadoutindex(var_2.origin, var_0, var_1);

  foreach(var_8 in var_6) {
    if(isDefined(get_current_stealth_state(var_8)))
      var_8 getbestintersectionpt(var_8, var_4, "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646");
  }
}

_id_11E32(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = prematchloadoutindex(var_2.origin, var_0, var_1);

  foreach(var_8 in var_6) {
    if(trial_trigger_think(var_8))
      next_mortar_vo(var_8, var_2, var_3, var_4, var_5);
  }
}

next_mortar_vo(var_0, var_1, var_2, var_3, var_4) {
  if(get_current_stealth_state(var_0) != "_encstr_85BB067A08A3FAB3")
    var_0 thread change_stealth_state_to(var_0, "_encstr_85BB067A08A3FAB3");

  var_0 thread select_bunker_interior_one_spawners(var_0, var_1, var_3, var_4);
}

prematchloadoutindex(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_7 in var_5) {
    if(distancesquared(var_0, var_7.origin) <= var_1)
      var_4[var_4.size] = var_7;
  }

  var_4 = sortbydistance(var_4, var_0);
  var_9 = int(min(var_4.size, var_2));

  for(var_10 = 0; var_10 < var_9; var_10++)
    var_3[var_10] = var_4[var_10];

  return var_3;
}

_id_132D1(var_0) {
  return 0;
}

_id_132D0(var_0) {
  return 0;
}

_id_132CF(var_0) {
  return isDefined(var_0);
}

_id_132CE(var_0) {
  return isDefined(var_0);
}

_id_132CD(var_0) {
  return isDefined(var_0);
}

_id_129FD() {
  var_0 = ["_encstr_8C75116593A067021797EFCBDBB73A84A03E8A", "_encstr_9A7511B65DCDD78D38FACD4756C2D81D34FA8C", "_encstr_AF751105BD9B579AE3A97FE54D8078FC8049BB", "_encstr_95751138C35F20909ADF9F990D06307D9BD99B", "_encstr_A275116BBADCEB8D0ED7373A59B01BA3D0D7D4", "_encstr_B175117768AB97FA317802FB5D3BC26410D1E2"];

  for(var_1 = 0; var_1 < 5; var_1++)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  level._id_13894 = var_0;
  level._id_13895 = 0;
}

rear_spawn_type_adjuster() {
  var_0 = level._id_13894[level._id_13895];
  level._id_13895++;

  if(level._id_13895 == level._id_13894.size - 1)
    _id_129FD();

  return var_0;
}

_id_129FE() {
  var_0 = ["_encstr_8D3A1839D3BB37E9F007E8C8F739C0A9B2F1263E2D521B70F756", "_encstr_A53A18B7EB46099B70063AC379C0ACF3932703B3B7E2125EE143", "_encstr_863A18939F7BE04828890BE32FE1E8AD22CF05355F42B5686F8A", "_encstr_8B3A18DD2B18DF4A4FCFA7B393FF824C68F69662ED80AD5230E1", "_encstr_833A1810AF0B9EB76BB1E66D1752E1A3486F10605FBB11756133", "_encstr_9B3A1829C3AB27F9E0F718D8E709D0B9C2E1162EDD422BCDE77A"];

  for(var_1 = 0; var_1 < 5; var_1++)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  level._id_13896 = var_0;
  level._id_13897 = 0;
}

rear_spotlight_angles_offset() {
  var_0 = level._id_13896[level._id_13897];
  level._id_13897++;

  if(level._id_13897 == level._id_13896.size - 1)
    _id_129FE();

  return var_0;
}

_id_123C4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_834E1BFFA24A7107B1335243F1095DD31F4B91C9FB18D723AB964AFFE5");
  var_0 endon("_encstr_834E1BFFA24A7107B1335243F1095DD31F4B91C9FB18D723AB964AFFE5");
  var_1 = 3;

  if(!isDefined(var_0._id_1273E)) {
    var_2 = rear_spawn_type_adjuster();
    var_0._id_1273E = var_2;
    scripts\cp\utility::_id_123FE(var_2, var_0);
  }

  var_3 = level scripts\engine\utility::_id_143B9(var_1, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0._id_1273E = undefined;
  var_0 setplayermusicstate("_encstr_B40101");
}

play_combat_music_to_players() {
  scripts\cp\utility::_id_123FE(rear_spotlight_angles_offset(), level.players);
}

getbestintersectionpt(var_0, var_1, var_2) {
  var_0._id_124D1 = var_1;
  var_0._id_12A6E = var_2;
  var_0 thread change_stealth_state_to(var_0, "_encstr_AA7C07466F9DA30713");
}

logloadoutcopy(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.name == var_0._id_124D1) {
      logevent_playerregen(var_2, var_0._id_12A6E);
      continue;
    }

    logevent_servermatchend(var_2, var_0._id_124D1, var_0._id_12A6E);
  }
}

logevent_playerregen(var_0, var_1) {
  switch (var_1) {
    case "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646":
      var_0 iprintlnbold("_encstr_8EE3212F622BEDAE80CB9B430B6759102C8DAC27A39519103A0DCA10CADCB2B5A5959B");
      break;
    case "_encstr_B2910FCBB0E22BEA7310AFB3EFDB7B7F1D":
      var_0 iprintlnbold("_encstr_AD1929CE4A5170B516634FF9B75BF5520237D14096C34060ABD3D3F9CA42C39ACCCC59116F365029527FF7");
      break;
  }
}

logevent_servermatchend(var_0, var_1, var_2) {
  switch (var_2) {
    case "_encstr_A37E14CACDAC6B5A59B9D72C9C59FA581B5939E85646":
      var_0 iprintlnbold("_encstr_B40703A9CB" + var_1 + "_encstr_BD371BB93F4681799740D7591D4B0353BFB66090B2FEC3D0A725EBC5E3");
      break;
    case "_encstr_B2910FCBB0E22BEA7310AFB3EFDB7B7F1D":
      var_0 iprintlnbold("_encstr_B40703A9CB" + var_1 + "_encstr_A6162345CFFEB05F27E691799A7BA73082FF699905573A16F7FE6BC0E21ACD101F45DB23BB");
      break;
  }
}

_id_134E4() {
  level notify("_encstr_ACB91B43435952EC9819DD137A1E123BD7C79DF07042A9480B0A681AB3");
  level endon("_encstr_ACB91B43435952EC9819DD137A1E123BD7C79DF07042A9480B0A681AB3");

  if(weapon_xp_iw8_sn_kilo98()) {
    while(!(isDefined(level.stealth) && isDefined(level.stealth.groupdata)))
      wait 0.25;

    for(;;) {
      if(scripts\stealth\manager::anyone_in_combat()) {
        level thread global_stealth_broken();
        return;
      }

      wait 0.25;
    }
  }
}

prevbrbonusxp() {
  return scripts\engine\utility::random(["_encstr_86FF1BB4F326471A2941A2BB2A27D633D95E2C178609A3E53BA049B70A", "_encstr_A9761B012B397E48AC09C9C37A5F0B2172FBA9EFEF62B1F8D95D36D302", "_encstr_A1D01B19F0F58D6E3AEB0BB899EBB036564E1DBE1BB0D836D237D798C0", "_encstr_BE5E1BE5281976135BA7B2EBC9D97F62C5C3F511F08882F853DA5E1B62"]);
}

processlobbydataforclient() {
  return scripts\engine\utility::random(["_encstr_8AE421913CBE6CDCD1F585C5627DB4E69DB26ED1D2D985A3957D8DC23636B437F5620C", "_encstr_B23821226AC8E7B2D0C7E1F9F561FC0B8461EBABD0BCA72B60DF1BF171A08443B81357", "_encstr_9A8D2191E1BE36DC3AEB858B99BEB49BB3CA37E82D76588E59F56CC28D1B4B9BD71306", "_encstr_928721CA82201F4A381FC9C1D1399463DC5933530884CF435837C3D909885C9B907B7F"]);
}

raid_objective_cleanup_func() {
  return scripts\engine\utility::random(["_encstr_B46B1A0A5216AF6FFB28ABBBEFFF0750B558C96E1F399FCF91D93E11", "_encstr_ADBA1A98D06943F3439721BB87017F6A813207D1D9EA30B5EBE16E59", "_encstr_ADC81A61F0AFE84EBB7FCBF3D6D196102D8C8E39DEFBF005D3976379", "_encstr_AF381A391301466074D1213B1377A88D1AF7D7BD0FAA1A68A839231B"]);
}

processassist_regularcp() {
  return scripts\engine\utility::random(["_encstr_86672319F0BE36DC8EF52C8B26AF4CD563B159D1DD342DA7C4CBEBB32B3759C95AD8D76218", "_encstr_8103238C1EBEB1DCA37D582E46AF89BA1BC65947DDA196F498E5BEECB2E62B93D2C6AF9803", "_encstr_B8C3232ABB7F6F4BA3A75722EF49DE1318C94A236B438FFA85A3C067099DC78BF22F3733AF", "_encstr_87592332F0D76C378EEB85C543F513AED8C695E8BB86D23D26BCBE9DB2DC59C92D8DD79818"]);
}

receivingampeddamage() {
  return scripts\engine\utility::random(["_encstr_B66021CB89AE67066C1FCFAF87892AC08867F325351097A0595F30C82A7BDFF6F65971", "_encstr_B633219D2877CFD71DF0AF40F521763F20430216F830581221D25778C908AA7EA9DF87", "_encstr_B83C218FB389B668A4F71EF93E460FCFBCB28DFED07BE86D67743316A9309B9376C2CA", "_encstr_87F72119F0AF6CE6A37D0BB8A17D1BF6675627C436B7BB737D9DCA37599CD21BFA13C0"]);
}

prematchmusic() {
  var_0 = ["_encstr_B1731A53C32EABFB397886BA7747127CB1B8EB37C8C1F3C241109AE2", "_encstr_A2501AC3A1E07A3BE0D66E7263E171C2450D0BB75D15A3E5C8BE722A", "_encstr_B6FE1A8C1E7DD89B1DF558B866BE2CC6CA39A37DC956B956D1BE9818", "_encstr_96BE1A4943BF0E20ABEF6B43AC598841FF7BC3D60B8FBED8C397D3F9"];
  return var_0[randomint(var_0.size)];
}

puddle_structs() {
  var_0 = ["_encstr_B29B2260A31F51DF73F997A75AF9D3389E4F50180FFFA9990A919CA565B22D80F30FDAB2", "_encstr_ABF222E3B09E1B4B6928D6CA861722AE03F0272B40F1510393C05FC7801BCB6149B9A642", "_encstr_AF8922C0930FDF1FF90E1F42C2B938AD406F0AD0830FCB51356F77D59DC78EC0612F7392", "_encstr_911A2254D321E6AA3349A353D3E9A9D0135337010BF2596B0D570A55AA23DB103F09336F"];
  return var_0[randomint(var_0.size)];
}

propane_detonate_fiery_drips() {
  var_0 = ["_encstr_B66021CB89AE67066C1FCFAF87892AC08867F325351097A0595F30C82A7BDFF6F65971", "_encstr_B633219D2877CFD71DF0AF40F521763F20430216F830581221D25778C908AA7EA9DF87", "_encstr_B83C218FB389B668A4F71EF93E460FCFBCB28DFED07BE86D67743316A9309B9376C2CA", "_encstr_87F72119F0AF6CE6A37D0BB8A17D1BF6675627C436B7BB737D9DCA37599CD21BFA13C0"];
  return var_0[randomint(var_0.size)];
}

projectileimpactthermite() {
  var_0 = ["_encstr_A6FB1DE2F05FA217BBB1719FF3B6C682B118871B5FDF8DE01A62ACE1A827EA", "_encstr_A3341D78DB89A70BBB2FC7C7BAEFF177EDE2D84001DFD3E0D72ADB36FF7ED3", "_encstr_B16F1D6772811B4355D7E79F37E80A5F48595EEB0EE8A54A2565CFDF878707", "_encstr_B4CD1DC8E1FAC66E47BE85B8A1D76CEDDA98C2D17D9D56B9AC4E5A1BBE9818"];
  return var_0[randomint(var_0.size)];
}

raritycamlarge() {
  var_0 = ["_encstr_82DC1C4DD071BED644B8DBAB270753281CAB05DF905095EF624BBE576713", "_encstr_A1D51CC8F0EBC66E3AAF2C17C8F5DC2D764347AFD9AC7395394B36EB6218", "_encstr_969C1C4687FAC69B8EF52C2E99F59B969D341DAFEC56CD2B27D236BE1303", "_encstr_9A1B1C230FAFD8E647AF58B8687DDC4B3BD08EAFCEACCD2B392D8DFA6281"];
  return var_0[randomint(var_0.size)];
}

propnumclones() {
  var_0 = ["_encstr_9ACA20A102B0FB674329296B09A995D387E0409AFCEF93A76F9785FDE5D0EFAF7739", "_encstr_846B2047F92EF3DA5D1FEFFB0F098D2BD2B07D2338676046CFEDC66502B41617BB02", "_encstr_84B320193CF5C637D1AF85B8CCF55987388DDEB9A5ED737D3BAC7395E4B4D8FA620C", "_encstr_ACB52032425956EB10DE9E43BF1E157AC8DB977E6B72AE29690A681AB3B1FE88526B"];
  return var_0[randomint(var_0.size)];
}

propwaitminigamehudsetpoint() {
  var_0 = ["_encstr_8F7E1DA58B3981A344DE9817EBE84FF6D0267B2251170C114049F5F33F87BA", "_encstr_8C471D911E7D6C371DD70BB8917D7627CAB92C3259BE230B9BB3ACC9EB4C0C", "_encstr_A2101DABC998024388CE464A6BF99FCB6D0D47236B203A0920D17F921E52F0", "_encstr_B2061DE44396F7AA9991724BF2F7E7FB8920699C553E53F645B83A73C1430A"];
  return var_0[randomint(var_0.size)];
}

ray_trace_trigger_radius_2d() {
  var_0 = ["_encstr_95BE1C460FFAC6378E7D162E26F537D2C65673B1AC917D371AF6E8F5C40C", "_encstr_84F51CB118A9DE1B93B9AF078B1F3B72710FAA33F7579943F97765D87A12", "_encstr_818D1C32E1EB8D378ED7168B99F5E62DD8B2CDD82B91FAE634F63A7DC481", "_encstr_97471C7F6A99036B6DEFCF8751801371685175066198F7A34BB78347431F"];
  return var_0[randomint(var_0.size)];
}

propwatchcleanupondisconnect() {
  var_0 = ["_encstr_93C51EAF8B078AB34B31571F6A069F53CDA634E575DF02ED50980347E0FE014F", "_encstr_8BD21E3CA9A186AF5D86626BC32007FBC027B88F19F9CFBF08F94B12F11816E2", "_encstr_A28F1E23F0D78DCD3AFAB0C5CCBEB3BAE6CDD0B7D1FAEC95DC569C5AC67DC481", "_encstr_B12D1E983B6907AB1B8F6767DC8F11E38D13703813B1B7211BDDF65363671331"];
  return var_0[randomint(var_0.size)];
}

propwatchcleanuponroundend() {
  var_0 = ["_encstr_B1E81F193C7DB1378EEB58E289F5CE5D379B1ADB8EEBA3562C5BD61647957D4C06", "_encstr_A90F1FC80FAFB1DC47AF858BC87DCE57B96E43DE8EAF3A59165B6B16A3B2EB1306", "_encstr_9A821F0A612FD176FCE793A053D64C272302E3FD9B5FDB9DF7B13FF62CAA579657", "_encstr_A6581FC81EEB1BE6A3EBC2C568EBB3ABCD3743DE8EAF472B2CB66BB047CAD71303"];
  return var_0[randomint(var_0.size)];
}

pressure_timeout() {
  var_0 = ["_encstr_AA7F1A5C23F6BF3A9BB1FB2F0F7162D1F1C820F2B09B3C47A9490ED7", "_encstr_85B11A2F3AC9531B1D9F9FD76D50E284B8E26974B0E814327D87E6CA", "_encstr_8FA61A7953410620B411E1FB12B7F8C9CAFF97EFEF9A59A8FC79E3DB", "_encstr_97471A7F6A99036B6DEFCF875180327468D23904E0D8C4C24DD796FA"];
  return var_0[randomint(var_0.size)];
}

race_set_player_safe() {
  var_0 = ["_encstr_853C207762910B5365E7D78F23982B52680AACBDF860C96934BBE3D7CDBBC287329B", "_encstr_AD85201F0240512B132FFFBB351958DDC808E2A009D39B795F9BC8BA05B08646BE22", "_encstr_A2052040E3B1AF03A327CF3FA3E7AB55654B90806A13D3DED705403DDA67B1475A37", "_encstr_BA7420B08168F9A033370BB831E1A81B5898315013AB5871293312AF1074EBC7325A"];
  return var_0[randomint(var_0.size)];
}

propsizetext() {
  var_0 = ["_encstr_83941F7CE9E1C6EF1DC6222B63E0C3BD0869E3D47B4001774DD87A6370C6EFE24A", "_encstr_AF701F7DBBB9B79260FF8E2B7AF90CB7C05516A19223512FCBCD35A03B87195F7F", "_encstr_95371FC1F01033078B5FA77822E6A01850EBF284713BE1070995CB1D081E91EE5B", "_encstr_A5301F82C37F66773BAFC9D18D661BADB7F87B7B2BF9D16F71F0D5EACB09376271"];
  return var_0[randomint(var_0.size)];
}

propspawnorigin() {
  var_0 = ["_encstr_9AD71EFCAB7E1F5261796A63E2DFCFF7D01553644DE3A71A5108128AF08752C2", "_encstr_AFA51EE9B2EFD158DBB9DAF78AD74538FFA9CF83213320529BAB44FE9B0839E7", "_encstr_B1FE1E9908471BA66357F3DB8EB964181F63E313F7B0295EFBDBFB9D8B81172A", "_encstr_BD9A1E230FD7C6371DEBB05CD0AF33DEB7D19BD1B20ED7CD83392D9BA3D7980C"];
  return var_0[randomint(var_0.size)];
}

recent_spawn_threshold() {
  var_0 = ["_encstr_A5961BB1201F58FE0B2F9B83AE8145A0F9FD5EE84D9950BB03DFEF0B42", "_encstr_91721B65C8D8B8F391E021B782E70BC84F7B09401558EB830DE8EF97DF", "_encstr_8EDF1B32F0EB6C6ED1EBB08B99F51DB22CADEB9673C55DB4392FBE9860", "_encstr_AF291B18BBE9872B9B0FE7E75C0FF343CE72498832BA1320EB41E0FFB0"];
  return var_0[randomint(var_0.size)];
}

put_passenger_in_truck() {
  var_0 = ["_encstr_91EF198CC3F51B9B8E7D2C8B62F536F6B93AD7CD2D3B34E87D1381", "_encstr_BDCE1932E1BEC66E1DF50BB88CFA367B9B3A7DCD963B1A3A7D6260", "_encstr_AD8E19AC0BA96EC3A537FAB01F3FC58F5FA509BFFAC7F0D5092F91", "_encstr_A6AF1985580F862EC8FFF91B6CE770B74F9BF9A3D8F71455A9DF52"];
  return var_0[randomint(var_0.size)];
}

proximity_explode() {
  var_0 = ["_encstr_8A131D0C5B8EEF82B1A95A53B28F3CCFC0C5AF867BF3678B5910637BD96BE2", "_encstr_86B91D49D897D07693A7230B3A0933B84E33D681040218AD6A7F3F19773727", "_encstr_824F1D0509BFCF08053759FB02E169DB78E39143235EFBABAC6F3F03E9DEB7", "_encstr_BDBA1D46877D36E6477D2C5C86EB34AB738E7D995A93E6A3D8EDB98EF5260C"];
  return var_0[randomint(var_0.size)];
}