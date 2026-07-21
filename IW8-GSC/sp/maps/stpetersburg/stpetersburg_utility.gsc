/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_utility.gsc
*********************************************************/

setup_named_ai(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\sp\utility::spawn_targetname(var_0, 1);
  var_6.name = var_1;
  var_6.callsign = "Bravo 0-6";
  var_6.animname = var_0;
  var_6.script_parameters = var_0;
  var_6.disableplayeradsloscheck = 1;
  var_6.script_pushable = 1;
  var_6.disablebulletwhizbyreaction = 1;
  var_6.dontchangepushplayer = 1;
  var_6 pushplayer(0);
  var_6.dontmeleeme = 1;
  var_6 scripts\engine\sp\utility::set_battlechatter(0);
  var_6.script_forcegoal = 1;
  var_6 scripts\engine\sp\utility::set_attackeraccuracy(0.5);
  var_6.colornode_func = ::color_node_arrive;

  if(!isDefined(var_5))
    var_5 = 1;

  if(var_5 == 1)
    var_6 thread scripts\engine\sp\utility::deletable_magic_bullet_shield();

  if(isDefined(var_3))
    scripts\engine\sp\utility::activate_trigger_with_targetname(var_3);

  if(isDefined(var_4)) {
    if(var_4 == "clear")
      var_6 scripts\common\utility::clear_demeanor_override();
    else
      var_6 scripts\common\utility::demeanor_override(var_4);
  }

  if(isDefined(var_2)) {
    var_7 = scripts\engine\utility::getStruct(var_2, "targetname");

    if(isDefined(var_7)) {
      var_6 forceteleport(var_7.origin, var_7.angles);
      var_6 setgoalpos(var_7.origin);
    }
  }

  return var_6;
}

price_push_on() {
  level.price.dontavoidplayer = 1;
  level.price.disablebulletwhizbyreaction = 1;
  level.price.script_pushable = 0;
  level.price enableavoidance(0);
  level.price.doavoidanceblocking = 0;
  level.price.dontchangepushplayer = undefined;
  level.price pushplayer(1);
  level.price.disableplayeradsloscheck = 1;
}

price_push_off() {
  level.price.dontavoidplayer = 0;
  level.price.disablebulletwhizbyreaction = 0;
  level.price.script_pushable = 1;
  level.price enableavoidance(1);
  level.price.doavoidanceblocking = 1;
  level.price.dontchangepushplayer = 1;
  level.price pushplayer(0);
  level.price.disableplayeradsloscheck = 0;
}

enforcer_safe_run() {
  level.enforcer scripts\engine\utility::disable_pain();
  level.enforcer scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  level.enforcer scripts\engine\sp\utility::set_ignoreall(1);
  level.enforcer scripts\engine\sp\utility::set_ignoreme(1);
  level.enforcer.script_pushable = 0;
  level.enforcer enableavoidance(0, 1);
  level.enforcer.doavoidanceblocking = 0;
  level.enforcer.grenadeawareness = 0;
  level.enforcer.disableplayeradsloscheck = 1;
}

spawn_enforcer(var_0) {
  if(isalive(level.enforcer)) {
    enforcer_reset_fake_health();
    return;
  }

  var_1 = getspawner("enforcer", "targetname");
  var_1.count = 1;
  level.enforcer = var_1 scripts\engine\sp\utility::spawn_ai(1);
  level.enforcer.animname = "enforcer";
  level.enforcer.name = "The Butcher";
  level.enforcer.callsign = "Jamal Rahar";
  level.enforcer scripts\engine\sp\utility::set_ignoresuppression(1);
  level.enforcer scripts\common\ai::magic_bullet_shield(1);
  var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.enforcer scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  level.enforcer.ignoreall = 1;
  level.enforcer.ignoreme = 1;
  level.enforcer.grenadeammo = 0;
  level.enforcer.dontgrenademe = 1;
  level.enforcer scripts\engine\sp\utility::set_goalRadius(8);
  level.enforcer actoraimassistoff();
  level.enforcer.script_pushable = 0;
  level.enforcer pushplayer(1);
  level.enforcer.script_forcegoal = 1;
  level.enforcer scripts\engine\sp\utility::set_battlechatter(0);
  level.enforcer scripts\sp\utility::context_melee_allow(0);
  thread enforcer_monitor_health_handler();

  if(isDefined(var_0)) {
    var_3 = getnode(var_0, "targetname");

    if(isnode(var_3))
      level.enforcer scripts\engine\sp\utility::teleport_ai(var_3);
    else {
      var_3 = scripts\engine\utility::getStruct(var_0, "targetname");

      if(isstruct(var_3))
        level.enforcer forceteleport(var_3.origin, var_3.angles);
    }
  }
}

spawn_nikolai() {
  scripts\engine\sp\utility::array_spawn_function_targetname("nikolai", scripts\common\utility::demeanor_override, "casual");
  level.nikolai = scripts\engine\sp\utility::spawn_targetname("nikolai", 1);
  level.nikolai.name = "Nikolai";
  level.nikolai.animname = "nikolai";
  level.nikolai.script_friendname = "Nikolai";
  level.nikolai.script_parameters = "Nikolai";
  level.nikolai.disableplayeradsloscheck = 1;
  level.nikolai.script_pushable = 0;
  level.nikolai.disablebulletwhizbyreaction = 1;
  level.nikolai.dontavoidplayer = 1;
  level.nikolai pushplayer(1);
  level.nikolai thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  level.nikolai scripts\engine\sp\utility::name_hide();
  level.nikolai scripts\engine\sp\utility::set_ignoreme(1);
  level.nikolai scripts\engine\sp\utility::set_ignoreall(1);
}

pursuit_timer(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("missionfailed");
  level.player endon("death");
  level notify("pursuit_timer_reset");
  level endon("pursuit_timer_reset");

  if(getdvarint("debug_disable_pursuit_timer") >= 1) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = 0;
  level.player clearhudtutorialmessage();
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");
  thread pursuit_autosave(var_0, var_3);
  var_7 = scripts\common\utility::getdifficulty();

  if(var_7 == "medium")
    var_1 = int(var_1 * 0.95);
  else if(var_7 == "hard")
    var_1 = int(var_1 * 0.9);
  else if(var_7 == "fu")
    var_1 = int(var_1 * 0.85);

  var_8 = scripts\sp\hud_util::createfontstring("objective", 1);

  if(istrue(var_6)) {
    var_8 scripts\sp\hud_util::setpoint("LEFT", "CENTER", 250, -20);
    var_8 settext("Pursuit Timer: " + var_1);
    var_8 thread pursuit_hud_cleanup();
  } else
    var_6 = 0;

  if(isDefined(var_2) && scripts\engine\utility::flag_exist(var_2)) {
    if(scripts\engine\utility::flag(var_2)) {} else
      scripts\engine\utility::flag_wait(var_2);
  }

  if(isDefined(var_4) && (var_7 == "easy" || var_7 == "medium")) {
    var_9 = getEnt(var_4 + "_vol", "targetname");

    if(isDefined(var_9))
      thread pursuit_death_flag_save(var_4, var_9);
  }

  var_10 = 10;
  var_11 = 7;
  var_12 = 10;

  if(var_7 == "hard" || var_7 == "fu") {
    var_10 = 8;
    var_11 = 5;
  }

  if(var_1 < 10) {
    var_10 = -10;
    var_11 = -10;
  }

  while(var_1 > 0) {
    if(getdvarint("debug_disable_pursuit_timer") >= 1) {
      return;
    }
    var_13 = level scripts\engine\utility::waittill_notify_or_timeout_return("pursuit_early_autosave", 1);

    if(var_13 == "pursuit_early_autosave" && var_1 > var_12) {
      if(var_7 != "fu")
        pursuit_early_autosave();

      if(var_7 == "easy")
        var_1 = int(var_1 * 1.2);

      wait 1;
    }

    var_1 = var_1 - 1;

    if(var_1 <= var_10 && var_5 == 0) {
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_pursuit_target_escaping_nag();
      var_10 = -10;
    }

    if(var_6)
      var_8 settext("Pursuit Timer: " + var_1);

    if(scripts\engine\utility::flag(var_0)) {
      if(var_6) {}

      var_8 scripts\sp\hud_util::destroyelem();
      scripts\engine\utility::flag_set("can_save");
      scripts\engine\utility::flag_clear("disable_autosaves");
      level.player clearhudtutorialmessage();
      level notify("pursuit_timer_reset");
      continue;
    }

    if(var_1 == var_11) {
      level.player sethudtutorialmessage(&"STPETERSBURG/PURSUIT_WARNING");
      level.player scripts\engine\utility::delaycall(6, ::clearhudtutorialmessage);
      scripts\engine\utility::flag_clear("can_save");
      scripts\engine\utility::flag_set("disable_autosaves");
    }
  }

  var_8 scripts\sp\hud_util::destroyelem();
  thread pursuit_timer_fail();
}

pursuit_timer_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_pursuit_target_escaped_fail();
  wait 1;
  scripts\sp\player_death::set_custom_death_quote(76);
  thread scripts\sp\utility::missionfailedwrapper();
}

pursuit_death_flag_save(var_0, var_1) {
  level endon("disable_autosaves");
  level endon("pursuit_timer_reset");
  scripts\engine\utility::flag_wait(var_0);
  wait 1;

  if(level.player istouching(var_1))
    level notify("pursuit_early_autosave");
}

pursuit_early_autosave() {
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");
  scripts\engine\sp\utility::autosave_or_timeout("pursuit_early_autosave", 3.0);
}

pursuit_autosave(var_0, var_1) {
  level endon("disable_autosaves");
  scripts\engine\utility::flag_wait(var_0);
  level notify("pursuit_timer_reset");
  level.player clearhudtutorialmessage();
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");

  if(var_1 == 1)
    scripts\engine\sp\utility::autosave_or_timeout("pursuit_autosave", 3.0);
}

pursuit_hud_cleanup() {
  level waittill("pursuit_timer_reset");

  if(isDefined(self))
    scripts\sp\hud_util::destroyelem();
}

enforcer_monitor_health_handler(var_0) {
  level notify("end_enforcer_monitor_health");
  level endon("missionfailed");
  level endon("escort_engage");
  level endon("interrogation_start");
  level.player endon("death");
  waitframe();
  level endon("end_enforcer_monitor_health");

  if(!isDefined(level.enforcer)) {
    return;
  }
  level.enforcer endon("death");
  level.enforcer scripts\engine\sp\utility::set_allowdeath(0);
  var_1 = 200;

  if(isDefined(var_0))
    var_1 = var_0;

  level.enforcer.fake_health = var_1;

  while(isalive(level.enforcer) && level.enforcer.fake_health > 0) {
    level.enforcer waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_6) && var_6 == "MOD_EXPLOSIVE") {
      continue;
    }
    if(isDefined(var_3) && var_3 != level.player) {
      continue;
    }
    level.enforcer.fake_health = level.enforcer.fake_health - var_2;

    if(level.enforcer.fake_health <= 0) {
      break;
    } else
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_pursuit_target_hurt_nag();

    waitframe();
  }

  if(isDefined(level.enforcer.magic_bullet_shield) && level.enforcer.magic_bullet_shield == 1)
    level.enforcer scripts\common\ai::stop_magic_bullet_shield();

  scripts\engine\utility::flag_clear("can_save");
  scripts\engine\utility::flag_set("disable_autosaves");
  scripts\engine\utility::flag_set("flag_enforcer_killed");
  thread enforcer_death_fail();

  if(scripts\engine\utility::flag("flag_enforcer_custom_death"))
    level.enforcer.skipdeathanim = undefined;
  else
    level.enforcer.skipdeathanim = 1;

  if(!scripts\engine\utility::flag("flag_enforcer_anim_death")) {
    level.enforcer scripts\engine\sp\utility::anim_stopanimScripted();
    level.enforcer.diequietly = 1;
    level.enforcer scripts\engine\sp\utility::set_allowdeath(1);
    level.enforcer kill();
  }
}

enforcer_reset_fake_health() {
  while(!isDefined(level.enforcer))
    waitframe();

  level.enforcer.fake_health = 200;
}

enforcer_set_low_fake_health() {
  while(!isDefined(level.enforcer))
    waitframe();

  level.enforcer.fake_health = 10;
}

enforcer_death_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");

  if(!scripts\engine\utility::flag("flag_gauntlet_nikolai_carrying_enforcer")) {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_pursuit_target_killed_fail();
    wait 2;
  }

  scripts\sp\player_death::set_custom_death_quote(84);
  thread scripts\sp\utility::missionfailedwrapper();
}

objective_enforcer_los(var_0, var_1, var_2, var_3) {
  level.enforcer endon("death");
  level.player endon("death");
  level endon("objective_enforcer_los_end");

  if(!isalive(level.enforcer)) {
    return;
  }
  scripts\engine\sp\utility::delaychildthread(1, ::enforcer_los_handler);
  thread objective_trigger_handler(var_0, var_2);
  var_4 = "";

  if(isDefined(var_3) && var_3 == 1)
    thread ping_current_objective();

  for(;;) {
    var_5 = scripts\engine\utility::waittill_any_return("objective_enforcer_los_true", "objective_enforcer_los_false");

    if(var_5 == "objective_enforcer_los_true") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var_0);
      scripts\engine\sp\objectives::objective_set_on_entity(var_0, &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER", level.enforcer);
      scripts\engine\sp\objectives::objective_set_show_distance(var_0, 0);
      scripts\engine\sp\objectives::objective_set_z_offset(var_0, 80);
      scripts\engine\sp\objectives::objective_set_label(var_0, &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");
      continue;
    }

    if(var_5 == "objective_enforcer_los_false") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var_0);
      var_6 = scripts\engine\utility::getStruct(var_1, "targetname");
      scripts\engine\sp\objectives::objective_add_location_position(var_0, var_1, var_6.origin);
      scripts\engine\sp\objectives::objective_set_label(var_0, &"STPETERSBURG/OBJ_ICON_NAME_PURSUE");
    }
  }
}

enforcer_los_handler() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 2;

  if(!isalive(level.enforcer)) {
    return;
  }
  for(;;) {
    var_3 = level.player getEye();
    var_4 = level.enforcer getEye();
    var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_ainosight"]);
    var_6 = physics_raycast(var_3, var_4, var_5, level.player, 0, "physicsquery_any", 1);

    if(!var_6 && !var_0) {
      var_0 = 1;
      var_1 = 0;
      level notify("objective_enforcer_los_true");
      wait(var_2);
    } else if(var_6 && !var_1) {
      var_1 = 1;
      var_0 = 0;
      level notify("objective_enforcer_los_false");
      wait(var_2);
    }

    waitframe();
  }
}

objective_trigger_handler(var_0, var_1) {
  scripts\engine\sp\utility::trigger_wait_targetname(var_1);
  level notify("objective_enforcer_los_end");
  scripts\engine\sp\objectives::objective_remove_all_locations(var_0);
}

enforcer_blindfire(var_0, var_1, var_2, var_3) {
  level.enforcer endon("death");
  level.enforcer endon("end_fake_fire");

  if(!isDefined(var_3))
    var_3 = 10;

  var_4 = getcompleteweaponname("iw8_sm_mpapa7");
  var_5 = weaponfiretime(var_4) * 2;

  while(!scripts\engine\utility::flag(var_2)) {
    for(var_6 = 0; var_6 <= randomintrange(3, 5); var_6++) {
      magicbullet(var_4, var_0, var_1 + scripts\engine\utility::randomvectorrange(0, var_3), level.enforcer);
      wait(var_5);
    }

    wait(randomfloatrange(0.5, 1.5));
  }
}

color_node_arrive(var_0) {
  self endon("death");
  waitframe();
  self.oldgoalradius = self.goalradius;
  self.goalradius = 1;
  self waittill("goal");

  if(isDefined(var_0.script_gesture))
    thread scripts\engine\sp\utility::gesture_simple(var_0.script_gesture);

  if(isDefined(var_0.script_flag))
    scripts\engine\utility::flag_set(var_0.script_flag);

  if(isDefined(var_0.script_sound))
    thread scripts\engine\sp\utility::smart_dialogue(var_0.script_sound);

  self.goalradius = self.oldgoalradius;
}

price_adjust_accuracy_over_time(var_0) {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }
  level endon(var_0);

  for(level.price.baseaccuracy = 0.3; level.price.baseaccuracy < 1.0; level.price.baseaccuracy = level.price.baseaccuracy + 0.1)
    wait 10;
}

price_set_accuracy_low() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }
  level.price.baseaccuracy = 0.3;
}

price_set_accuracy_average() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }
  level.price.baseaccuracy = 0.5;
}

price_set_accuracy_high() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }
  level.price.baseaccuracy = 0.8;
}

price_set_accuracy_max() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }
  level.price.baseaccuracy = 10.0;
}

display_ai_count() {
  level.player endon("death");
  level endon("nextmission");
  setdvarifuninitialized("debug_ai_count", -1);
  var_0 = undefined;
  var_1 = (1, 1, 1);
  var_2 = (1, 1, 0);
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_5 = [];

  for(;;) {
    var_6 = getDvar("debug_ai_count", -1);

    switch (var_6) {
      case "all":
      case "0":
        var_0 = "all";
        break;
      case "1":
      case "axis":
        var_0 = "axis";
        break;
      case "2":
      case "allies":
        var_0 = "allies";
        break;
      case "3":
      case "team3":
        var_0 = "team3";
        break;
      case "4":
      case "neutral":
        var_0 = "neutral";
        break;
      default:
        var_0 = undefined;
        break;
    }

    if(isDefined(var_0)) {
      if(var_0 != "all") {
        var_5 = [];
        var_5[0] = getaiarray(var_0).size;
      } else {
        var_5[0] = getaiarray("axis").size;
        var_5[1] = getaiarray("allies").size;
        var_5[2] = getaiarray("team3").size;
        var_5[3] = getaiarray("neutral").size;
      }
    } else {
      var_5 = [];
      wait 0.5;
      continue;
    }

    var_7 = 0;

    foreach(var_9 in var_5)
    var_7 = var_7 + var_9;

    var_11 = var_1;

    if(var_7 < 10)
      var_11 = var_3;
    else if(var_7 < 20)
      var_11 = var_2;
    else
      var_11 = var_4;

    var_12 = 700;
    var_13 = 30;

    if(isDefined(var_0)) {
      if(var_0 == "all") {}

      foreach(var_16, var_9 in var_5) {
        var_15 = " AI";

        if(isDefined(var_0)) {
          if(var_0 == "all") {
            switch (var_16) {
              case 0:
                var_15 = " enemies";
                break;
              case 1:
                var_15 = " allies";
                break;
              case 2:
                var_15 = " police";
                break;
              case 3:
                var_15 = " civilians";
                break;
            }
          } else
            var_15 = " " + var_0;
        }

        var_13 = var_13 + 20;
      }
    }

    waitframe();
  }
}

weapon_empty(var_0) {
  if(!isDefined(var_0))
    return 0;

  return scripts\engine\utility::is_equal(var_0.basename, "none");
}

enable_blindfire_behavior() {
  self.aggressiveblindfire = 1;
  self.neverenablecqb = 1;
  self.maxfaceenemydist = 256;
  self.disable_blindfire = undefined;
  self.favor_blindfire = 1;
  self.rambochance = 1.0;
  self.ramboaccuracymult = 1.0;
  self.baseaccuracy = 0.75;
  self.neversprintforvariation = undefined;
}

disable_blindfire_behavior() {
  self.aggressiveblindfire = 0;
  self.favor_blindfire = undefined;
  self.rambochance = undefined;
  self.neverenablecqb = 0;
  self.maxfaceenemydist = 512;
  self.ramboaccuracymult = undefined;
}

scared_civs_notice_player() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_looking");

  for(;;) {
    if(scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(45)) && scripts\engine\sp\utility::players_within_distance(200, self.origin)) {
      if(scripts\engine\utility::cointoss())
        self setlookatentity(level.player);

      self glanceatentity(level.player, randomintrange(1200, 2000));
      wait(randomintrange(4, 8));
    }

    wait 0.3;
  }
}

scared_civs_player_looking(var_0) {
  self endon("death");
  var_1 = cos(35);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(distance(level.player.origin, var_0.origin) < 100) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_1)) {
        if(isDefined(self))
          scared_civs_cower(var_0);
      }
    }

    wait 0.25;
  }
}

scared_civs_trigger_grenade(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
  wait 2;
  scared_civs_cower(var_0);
}

scared_civs_cower(var_0) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(!self.cowering) {
    self.cowering = 1;
    var_0 notify("stop_loop");
    var_0 scripts\common\anim::anim_single_solo(self, "apt_stairs_block_react");

    if(isDefined(self))
      var_0 scripts\common\anim::anim_loop_solo(self, "apt_stairs_block_react_idle");
  }
}

set_walking_speed(var_0) {
  if(!isDefined(var_0))
    var_0 = 20;

  scripts\asm\asm_bb::bb_setcivilianstate("casual");
  scripts\asm\asm_bb::bb_civilianrequestspeed(var_0);
}

populate_civs_looping(var_0, var_1) {
  var_2 = getspawner(var_0, "targetname");
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_4 = [];

  foreach(var_6 in var_3) {
    var_2.count = 1;
    var_7 = var_2 scripts\engine\sp\utility::spawn_ai(1);
    var_4 = scripts\engine\utility::array_add(var_4, var_7);
    var_7 forceteleport(var_6.origin, var_6.angles);
    wait 0.5;
    var_7 thread addloopinganimation(var_6);
    var_7.animstruct = var_6;
    var_7.location = var_7;
  }

  return var_4;
}

addloopinganimation(var_0) {
  self.animname = "generic";
  var_1 = var_0.animation;
  var_0 thread scripts\common\anim::anim_generic_loop(self, var_1, "stop_loop");
}

populate_civs_no_loop(var_0, var_1) {
  var_2 = getspawner(var_0, "targetname");
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_4 = [];

  foreach(var_6 in var_3) {
    var_2.count = 1;
    var_7 = var_2 scripts\engine\sp\utility::spawn_ai(1);
    var_4 = scripts\engine\utility::array_add(var_4, var_7);
    var_7 forceteleport(var_6.origin, var_6.angles);
    wait 0.5;
    var_7 thread addanimation(var_6);
    var_7.animstruct = var_6;
    var_7.location = var_7;
  }

  return var_4;
}

addanimation(var_0) {
  self.animname = "generic";
  var_1 = var_0.animation;
  var_0 thread scripts\common\anim::anim_generic(self, var_1);
}

put_player_into_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_6))
    var_0 setModel("viewhands_base_fullbody_iw8");
  else
    level.player hidelegsandshadow();

  level.player freezecontrols(0);
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var_1 > 0.0) {
    level.player playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait(var_1);
  }

  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
  var_0 show();
  var_0 castshadows();
}

pull_player_out_of_rig_hide_rig(var_0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowmelee(1);
  var_0 hide();
  var_0 dontcastshadows();
  var_0 setModel("viewhands_hero_kyle_urban_fullbody");
  level.player enableweapons();
  level.player unlink();
}

put_player_into_cam_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_6))
    var_0 setModel("viewhands_base_fullbody_iw8");
  else
    level.player hidelegsandshadow();

  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var_1 > 0.0) {
    level.player playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait(var_1);
  }

  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
}

aq_override_pistol_silenced() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["silencerpstl_west01"]);
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

aq_override_ar_lasersight() {
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["laser_bar"]);
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  self laserforceon();
}

player_holdingpistolweapon() {
  if(player_holdingemptyweapon())
    return 0;

  if(player_weapon_holstered())
    return 0;

  return 1;
}

player_holdingemptyweapon() {
  return weapon_empty(level.player.currentweapon);
}

player_takeawaygunlessweapon() {
  if(scripts\engine\sp\utility::player_has_weapon("iw8_gunless"))
    level.player takeweapon("iw8_gunless");

  return 1;
}

give_player_max_ammo_on_pickup() {
  level.player endon("death");

  for(;;) {
    level.player waittill("pickup");
    level.player waittill("weapon_change");
    level.player givemaxammo(level.player getcurrentweapon());
    wait 1;
  }
}

interrogation_room_door_close(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 3);
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_0 + "_close", "targetname");
  var_2 thread warehouse_garage_door_open_audio(var_1);
  var_2 moveTo(var_3.origin, var_1);
}

warehouse_garage_door_open_audio(var_0) {
  wait 1.0;
  self playSound("stp_garage_open_start");
  self playLoopSound("stp_garage_open_lp");
  wait(var_0 - 1.0);
  self playSound("stp_garage_open_stop");
  wait 0.25;
  self stoploopsound();
}

interrogation_room_door_open(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 3);
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_0 + "_open", "targetname");
  var_2 moveTo(var_3.origin, var_1);
}

price_clean_up_last_enemy(var_0, var_1) {
  waitframe();

  if(!isDefined(var_1))
    var_1 = 0;

  while(var_0.size > 1) {
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
    wait 0.1;
  }

  wait(var_1);
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  if(var_0.size > 0)
    scripts\engine\sp\utility::array_notify(var_0, "begin_price_cleanup");
}

setup_enemy_for_price_clean_up() {
  self endon("death");
  scripts\engine\utility::waittill_either("damage", "begin_price_cleanup");

  if(isalive(self)) {
    price_set_accuracy_max();
    var_0 = self;
    var_1 = sighttracepassed(level.price getEye(), self getEye(), 0, undefined);

    if(isDefined(var_1) && var_1 == 1)
      var_0 = self getEye();

    scripts\engine\sp\utility::set_attackeraccuracy(10);
    self.health = 10;
    level.price shoot(100, var_0);
  }
}

price_get_los_enemy(var_0) {
  foreach(var_2 in var_0) {
    var_3 = sighttracepassed(level.price getEye(), var_2 getEye(), 1, undefined);

    if(var_3 == 1)
      return var_2;
  }

  var_2 = scripts\engine\utility::getclosest(level.price.origin, var_0);
  return var_2;
}

trigger_safe_function(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size == 0) {
    return;
  }
  foreach(var_5 in var_3) {
    switch (var_2) {
      case "activate":
        var_5 scripts\engine\utility::trigger_on();
        var_5 scripts\engine\sp\utility::activate_trigger();
        break;
      case "disable":
        var_5 scripts\engine\utility::trigger_off();
        break;
      case "enable":
        var_5 scripts\engine\utility::trigger_on();
        break;
      default:
        break;
    }
  }
}

player_wander_fail_handler(var_0) {
  level notify("end_wander_fail");
  level endon("end_wander_fail");
  level endon("missionfailed");
  level.player endon("death");

  if(!isDefined(level.player_wander_struct))
    level.player_wander_struct = spawnStruct();

  scripts\engine\utility::flag_clear("flag_end_player_wander_fail");
  level.player_wander_nag = 0;

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = 1;
  var_2 = 90;
  var_3 = 90;
  var_4 = 20;

  if(var_0) {
    var_2 = 30;
    var_3 = 30;
    var_4 = 10;
  }

  var_1 = 0;

  while(!scripts\engine\utility::flag("flag_end_player_wander_fail")) {
    if(var_2 <= 0) {
      thread player_wander_fail();
      return;
    }

    var_5 = level.player_wander_struct.array;
    var_6 = level.player_wander_struct.array_hardfail;

    if(isDefined(var_6) && var_6.size > 0) {
      if(level.player scripts\engine\sp\utility::is_touching_any(var_6)) {
        var_2 = -1;
        continue;
      }
    }

    if(isDefined(var_5) && var_5.size > 0) {
      var_7 = var_1;

      if(level.player scripts\engine\sp\utility::is_touching_any(var_5))
        var_1 = 1;
      else
        var_1 = 0;

      if(var_7 != var_1) {
        if(var_1) {
          setomnvar("ui_out_of_bounds_countdown", 0);
          var_2 = var_3;

          if(level.player_wander_nag == 1)
            thread delay_reset_player_wander_nag(4);
        } else {
          setomnvar("ui_out_of_bounds_countdown", 1);

          if(level.player_wander_nag == 0) {
            thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_player_wander_nag();
            level.player_wander_nag = 1;
            thread delay_reset_player_wander_nag(8);
          }
        }
      } else if(!var_1)
        var_2--;
    }

    wait 0.1;
  }

  waitframe();
  level.player_wander_struct.array = [];
  level.player_wander_struct.array_hardfail = [];
}

player_wander_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_player_wander_fail();
  wait 2.0;
  scripts\sp\player_death::set_custom_death_quote(429);
  thread scripts\sp\utility::missionfailedwrapper();
}

delay_reset_player_wander_nag(var_0) {
  level.player notify("delay_reset_player_wander_nag");
  level.player endon("delay_reset_player_wander_nag");
  wait(var_0);
  level.player_wander_nag = 0;
}

set_wander_fail_volume(var_0) {
  if(getdvarint("debug_disable_wander_fail") >= 1) {
    return;
  }
  if(!isDefined(level.player_wander_struct)) {
    thread player_wander_fail_handler();
    waitframe();
  }

  level.player_wander_struct.array = getEntArray(var_0, "targetname");
  level.player_wander_struct.array_hardfail = getEntArray(var_0 + "_hardfail", "targetname");
}

transient_unload_load(var_0, var_1) {
  waitframe();

  if(isDefined(var_0)) {
    var_2 = [];

    if(isarray(var_0))
      var_2 = var_0;
    else
      var_2[0] = var_0;

    scripts\engine\sp\utility::transient_unload_array(var_2);
  }

  if(isDefined(var_1)) {
    var_3 = [];

    if(isarray(var_1))
      var_3 = var_1;
    else
      var_3[0] = var_1;

    scripts\engine\sp\utility::transient_load_array(var_3);
  }
}

transient_waittill(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_0);
  thread transient_unload_load(var_1, var_2);
}

waittill_array_alive_count_or_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 childthread waittill_alive_count(var_0, var_1);
  var_3 scripts\engine\utility::waittill_notify_or_timeout("alive_count", var_2);
}

waittill_alive_count(var_0, var_1) {
  while(var_0.size > var_1) {
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
    waitframe();
  }

  self notify("alive_count");
}

price_advance_trigger(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = getEnt(var_0, "targetname");

  if(isDefined(var_4)) {
    var_5 = var_4.script_color_allies;

    if(isDefined(var_1))
      var_4 scripts\engine\utility::waittill_any_timeout(var_1, "trigger");
  } else
    return;

  level.price endon("cancel_advance_trigger");

  while(isDefined(var_4)) {
    if(getdvarint("debug_disable_wander_fail") >= 1) {
      return;
    }
    var_6 = var_4 scripts\engine\sp\utility::get_ai_touching_volume("axis");
    var_7 = var_4 scripts\engine\sp\utility::get_ai_touching_volume("team3");
    var_8 = scripts\engine\utility::array_combine(var_6, var_7);

    if(var_2 == 1) {
      foreach(var_10 in var_8) {
        if(var_10 != level.enforcer)
          var_10.health = 1;
      }

      break;
    }

    if(var_8.size > var_3) {
      var_12 = getpriceenemytarget(var_8);
      var_13 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.price getEye(), cos(75));

      if(isDefined(var_12) && !var_13)
        level.price shoot(100, var_12);
      else {
        var_12 = scripts\engine\utility::random(var_8);
        level.price getenemyinfo(var_12);
      }
    } else
      break;

    wait 0.1;
  }

  thread trigger_safe_function(var_0, "targetname", "activate");
  level.price notify("cancel_advance_trigger");
}

getpriceenemytarget(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(level.enforcer) && scripts\engine\utility::is_equal(var_2, level.enforcer)) {
      continue;
    }
    var_3 = sighttracepassed(level.price getEye(), var_2 getEye(), 0, undefined);

    if(var_3 == 1)
      return var_2;
  }
}

setup_dead_bodies(var_0, var_1) {
  var_2 = getspawnerarray(var_0);

  foreach(var_4 in var_2)
  var_4 thread dead_body_create(var_1);
}

dead_body_create(var_0) {
  self.script_bodyonly = undefined;
  var_1 = scripts\engine\sp\utility::spawn_ai(1);
  var_1 endon("entitydeleted");
  var_1 endon("death");
  var_1.animname = "dead_body";
  var_1.team = "neutral";
  var_1 scripts\common\anim::anim_single_solo(var_1, var_1.animation);
  var_1 scripts\common\anim::anim_last_frame_solo(var_1, var_1.animation);
  wait 1;
  var_1.forceragdollimmediate = 1;
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 scripts\engine\sp\utility::die();
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_1))
    var_1 delete();
}

periph_vehicle_loop_new(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  while(!scripts\engine\utility::flag(var_0)) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
    var_4 = randomintrange(1, var_1.size - 1);
    var_5 = 2;
    var_6 = 4;
    var_7 = randomfloatrange(var_5, var_6);

    for(var_8 = 0; var_8 < var_4; var_8++) {
      var_9 = scripts\common\utility::getvehiclespawner(var_1[var_8][0], "targetname");
      var_10 = var_9 scripts\common\utility::spawn_vehicle();
      var_10 vehicle_turnengineoff();
      var_10.script_vehicle_selfremove = 1;
      var_11 = randomintrange(2, var_1[var_8].size);
      var_10 setModel(var_1[var_8][var_11]);
      waitframe();
      var_12 = var_10 periph_vehicle_driver(var_2);
      var_13 = var_1[var_8][1];
      var_10 thread scripts\common\anim::anim_loop_solo(var_12, var_13, "end_loop");
      var_12 linkTo(var_10);
      var_12 thread periph_vehicle_driver_delete_handler(var_10);
      waitframe();
      var_14 = scripts\engine\utility::random(var_3);
      var_10 scripts\common\vehicle::attach_vehicle_and_gopath(var_14);
      wait(randomfloatrange(0.5, 1.5));
    }

    wait(var_7);
  }
}

periph_vehicle_driver(var_0) {
  var_1 = scripts\engine\utility::random(var_0);
  var_2 = scripts\engine\sp\utility::fakeactorspawn(var_1);
  var_2.animname = "generic";
  var_2.animnode = self;
  var_2.current_state = "idle";
  var_2.ignoreme = 1;
  var_2.no_breath_fx = 1;
  var_2.diequietly = 1;
  var_2 notsolid();
  var_2 scripts\engine\sp\utility::set_allowdeath(0);
  var_2.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.5);
  var_2 notify("stop_civilian_fail_wrapper");
  return var_2;
}

periph_vehicle_driver_delete_handler(var_0) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(var_0))
    wait 0.1;

  self delete();
}

vehicle_loop(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waitframe();

  if(scripts\engine\utility::flag(var_1)) {
    return;
  }
  while(!scripts\engine\utility::flag(var_1)) {
    if(isDefined(var_0.size))
      var_0 = scripts\engine\utility::array_randomize(var_0);

    spawn_cluster(var_0, var_2, var_3, var_4, var_5, var_6);
  }
}

spawn_cluster(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = var_1;

  if(var_1 == var_2)
    var_6 = var_1;
  else
    var_6 = randomintrange(var_1, var_2);

  if(!isDefined(var_3))
    var_3 = 10;

  if(!isDefined(var_4))
    var_4 = var_3;

  if(var_3 == var_4)
    var_7 = var_3;
  else
    var_7 = randomfloatrange(var_3, var_4);

  for(var_8 = 0; var_8 < var_6; var_8++) {
    var_9 = 0;
    var_10 = "";

    if(isDefined(var_0.size))
      var_10 = var_0[var_9 + var_8];
    else
      var_10 = var_0;

    var_11 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var_10);
    var_11 vehicle_turnengineoff();
    var_11.script_vehicle_selfremove = 1;

    if(isDefined(var_5)) {
      if(isDefined(var_5[var_9].size))
        var_11 setModel(var_5[var_9][randomintrange(0, var_5[var_9].size)]);
      else
        var_11 setModel(var_5[randomintrange(0, var_5.size)]);
    }

    waitframe();
    wait(randomfloatrange(2, 3));
  }

  wait(var_7);
}

spawn_driver() {
  var_0 = getspawnerarray("traffic_driver");
  var_1 = var_0[randomintrange(0, var_0.size + 1)];
  var_1.count = 1;
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1, 0);
  var_1.count = 1;
  self.driver = var_2;
  var_2 link_driver(self);
}

link_driver(var_0) {
  scripts\engine\sp\utility::teleport_to_ent_tag(var_0, "TAG_DRIVER");
  self linkTo(var_0, "Tag_Driver", (0, 0, 0), (0, 0, 0));
  self.animname = "trafficdriver";
  thread scripts\common\anim::anim_loop_solo(self, "stp_street_traffic");
}

delete_on_flag(var_0) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(self.driver))
    self.driver delete();

  self delete();
}

manage_oscillation(var_0) {
  self vehicle_setspeedimmediate(var_0, 1, 1);
  var_1 = gettime();

  while(isDefined(self)) {
    var_2 = gettime() - var_1;
    var_3 = var_0;
    var_3 = var_3 + sin(var_2 * (2.5 / (var_0 + 5))) * var_0 * 0.15;
    iprintlnbold(var_3 + " - " + var_0);
    self vehicle_setspeed(var_3, 5, 5);
    wait 0.073;
  }
}

wait_player_not_looking(var_0, var_1, var_2) {
  var_3 = cos(50);
  var_4 = gettime();

  for(;;) {
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0, var_3)) {
      if(isDefined(var_2)) {
        if(distance(level.player.origin, var_0) > var_2) {
          break;
        }
      } else
        break;
    }

    if(isDefined(var_1) && var_1 > -1) {
      var_5 = gettime();
      var_6 = (var_5 - var_4) * 0.001;

      if(var_6 > var_1) {
        break;
      }
    }

    wait 0.2;
  }
}

animation_exists(var_0, var_1) {
  return isDefined(level.scr_anim[var_0][var_1]);
}

animation_stoploop(var_0, var_1) {
  var_0 notify("stop_loop" + var_1.animname);
}

animation_stopreach(var_0, var_1) {
  var_0 notify("stop_reach" + var_1.animname);
}

animation_reachtosingleintoidle(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  animation_singleintoidle(var_0, var_1, var_2, var_3);
}

animation_reachtosingle(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
}

animation_singleintoidle(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 endon("stop_loop" + var_1.animname);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  animation_idle(var_0, var_1, var_3);
}

animation_reachintofirstframe(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_reach" + var_1.animname);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, var_2);
}

animation_singleintolastframe(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_last_frame_solo(var_1, var_2);
}

animation_reachtoidle(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_reach" + var_1.animname);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  animation_idle(var_0, var_1, var_2);
}

animation_idle(var_0, var_1, var_2) {
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, var_2, "stop_loop" + var_1.animname);
}

init_dialog_structs() {
  level.flags = 0;
  level.kyle_dialog_struct = create_dialog_struct("Kyle", "allies");
  level.price_dialog_struct = create_dialog_struct("Price", "allies");
  level.nikolai_dialog_struct = create_dialog_struct("Nikolai", "allies");
  level.civilian_dialog_struct = create_dialog_struct("Civilian", "neutral");
  level.aq_soldier_dialog_struct = create_dialog_struct("Al Qatala", "axis");
  level.police_dialog_struct = create_dialog_struct("Police", "team3");
  level.butcher_dialog_struct = create_dialog_struct("Butcher", "axis");
  level.butcher_wife_dialog_struct = create_dialog_struct("Ousa", "neutral");
  level.butcher_son_dialog_struct = create_dialog_struct("Amon", "neutral");
  level.yegor_dialog_struct = create_dialog_struct("Yegor", "allies");
}

create_dialog_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.team = var_1;
  return var_2;
}

add_dialogue_line_kyle(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.player)) {
    level.player.name = "Kyle";
    level.player.team = "allies";
    level.player dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.kyle_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_price(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_6))
    scripts\engine\utility::flag_waitopen("pause_price_vo");

  if(isDefined(level.price)) {
    if(!scripts\engine\utility::flag("flag_bink_active"))
      level.price.name = "Captain Price";

    level.price.team = "allies";
    level.price dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.price_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_nikolai(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_6))
    scripts\engine\utility::flag_waitopen("pause_nikolai_vo");

  if(isDefined(level.nikolai)) {
    if(!scripts\engine\utility::flag("flag_bink_active"))
      level.nikolai.name = "Nikolai";

    level.nikolai.team = "allies";
    level.nikolai dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.nikolai_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_civilian(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "Civilian";
    scripts\engine\sp\utility::name_hide();
    self.team = "neutral";

    if(!isDefined(self.animname))
      self.animname = "generic";

    self.og_name = "Civilian";
    dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.civilian_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_police(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "Police";
    scripts\engine\sp\utility::name_hide();
    self.team = "team3";

    if(!isDefined(self.animname))
      self.animname = "generic";

    self.og_name = "Police";
    dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.police_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_aq_soldier(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "Al Qatala";
    scripts\engine\sp\utility::name_hide();
    self.team = "axis";

    if(!isDefined(self.animname))
      self.animname = "generic";

    self.og_name = "Al Qatala";
    dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.aq_soldier_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_butcher(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_6))
    scripts\engine\utility::flag_waitopen("pause_butcher_vo");

  if(isDefined(level.enforcer) && !scripts\engine\utility::flag("enforcer_dead")) {
    level.enforcer.name = "The Butcher";
    level.enforcer.team = "axis";
    level.enforcer dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else if(isDefined(level.escorttargetdrone)) {
    level.escorttargetdrone.name = "The Butcher";
    level.escorttargetdrone.team = "axis";
    level.escorttargetdrone dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.butcher_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_butcher_wife(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_6))
    scripts\engine\utility::flag_waitopen("pause_family_vo");

  if(isDefined(level.enforcerwife) || isDefined(level.escortdrones[0])) {
    if(isDefined(level.enforcerwife)) {
      level.enforcerwife.name = scripts\engine\utility::ter_op(scripts\engine\utility::flag("interrogation_escort_done"), "Ousa", "Woman");
      level.enforcerwife.team = scripts\engine\utility::ter_op(scripts\engine\utility::flag("intel_revealed"), "allies", "neutral");
      level.enforcerwife stoploopsound();
      level.enforcerwife dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
    } else if(isDefined(level.escortdrones[0]))
      level.escortdrones[0] dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.butcher_wife_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_butcher_son(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_6))
    scripts\engine\utility::flag_waitopen("pause_family_vo");

  if(isDefined(level.enforcerson) || isDefined(level.escortdrones[1])) {
    var_7 = undefined;

    if(isDefined(level.enforcerson))
      var_7 = level.enforcerson;
    else if(isDefined(level.escortdrones[1]))
      var_7 = level.escortdrones[1];

    var_7.name = scripts\engine\utility::ter_op(scripts\engine\utility::flag("interrogation_escort_done"), "Amon", "Boy");
    var_7.team = scripts\engine\utility::ter_op(scripts\engine\utility::flag("intel_revealed"), "allies", "neutral");
    var_7 dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.butcher_son_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

add_dialogue_line_yegor(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.yegor)) {
    level.yegor.name = "Yegor";
    level.yegor.team = "allies";
    level.yegor dialogue(var_0, var_1, var_2, var_3, var_4, var_5);
  } else
    level.yegor_dialog_struct dialogue(var_0, undefined, var_2, var_3, var_4, var_5);
}

dialogue(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(isDefined(var_3) && isDefined(var_4)) {
    if(!isarray(var_3))
      var_3 = [var_3];

    if(!isarray(var_4))
      var_4 = [var_4];

    foreach(var_7 in var_3) {
      foreach(var_9 in var_4)
      var_7 endon(var_9);
    }
  }

  if(isDefined(var_2) && var_2)
    wait(var_2);

  if(isDefined(var_1)) {
    if(!soundexists(var_1))
      iprintln("Cound not find dialogue line " + var_1 + " - please check stpetersburg_vo.csv");
    else {
      if(isPlayer(self))
        scripts\engine\sp\utility::smart_player_dialogue(var_1);
      else if(istrue(var_5))
        scripts\engine\sp\utility::smart_radio_dialogue(var_1);
      else
        scripts\engine\sp\utility::smart_dialogue(var_1);

      self notify("dialogue_finished");
    }
  }

  if(!isDefined(var_1) || getdvarint("scr_show_temp_dialogue")) {
    if(scripts\engine\utility::is_equal(self.team, "axis"))
      var_12 = "^1";
    else if(scripts\engine\utility::is_equal(self.team, "allies"))
      var_12 = "^2";
    else
      var_12 = "^3";

    if(!isDefined(self.name))
      var_13 = self.og_name;
    else
      var_13 = self.name;

    if(istrue(var_5))
      var_14 = var_12 + var_13 + " (Over Radio)" + ": " + "^7" + var_0;
    else
      var_14 = var_12 + var_13 + ": " + "^7" + var_0;

    thread dialogue_proc(var_14, var_2);
  }
}

dialogue_proc(var_0, var_1) {
  level notify("new_dialogue");
  var_2 = 0.3;
  var_3 = 3.0;
  var_4 = 2.0;
  var_5 = 1.2;
  var_6 = int(5.9 * var_5);
  var_7 = int(24 * var_5);
  var_8 = 300;
  var_9 = newhudelem();
  var_10 = newhudelem();
  var_11 = 350;
  var_12 = int(max(var_0.size * var_6, var_11));
  var_13 = [var_9, var_10];
  scripts\engine\utility::array_thread(var_13, ::dialog_new_line_monitor);

  foreach(var_15 in var_13) {
    var_15.alignx = "center";
    var_15.aligny = "middle";
    var_15.x = 320;
    var_15.y = var_8;
    var_15.sort = 5;
  }

  var_9.alpha = 0.5;
  var_9 setshader("black", var_12, var_7);
  var_10 settext(var_0);
  var_10.fontscale = var_5;
  wait(var_3);

  foreach(var_15 in var_13) {
    var_15 fadeovertime(var_4);
    var_15.alpha = 0;
  }

  wait(var_4);

  foreach(var_15 in var_13)
  var_15 destroy();
}

dialog_new_line_monitor() {
  self endon("death");

  for(;;) {
    level waittill("new_dialogue");
    self moveovertime(0.35);
    self.y = self.y + 30;
    waitframe();
  }
}

dialogue_naglogic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self endon("death");
  self endon("entitydeleted");
  var_11 = spawnStruct();
  var_11 endon("dialogue_endNag");
  thread dialogue_nagendonlogic(var_11, var_3, var_4);
  childthread dialogue_naglogic_proc(var_11, var_5, var_0, var_1, var_2, var_6, var_7, var_8, var_9, var_10);
}

dialogue_naglogic_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(var_1))
    wait(var_1);

  var_10 = 0;
  var_11 = 0;

  for(;;) {
    if(isDefined(var_7) && isDefined(var_8) && isDefined(var_9))
      childthread dialogue_naganimationlogic(var_7, var_8, var_9);

    var_12 = 0;

    if(isDefined(var_6) && ![[var_6]]()) {
      var_13 = var_5[var_11];
      var_14 = var_5[var_11];
      var_11++;
      var_12 = var_11 >= var_5.size;
    } else {
      var_13 = var_3[var_10];
      var_14 = var_2[var_10];
      var_10++;
      var_12 = var_10 >= var_3.size;
    }

    thread dialogue(var_14, var_13);

    if(soundexists(var_13)) {
      var_15 = lookupsoundlength(var_13) * 0.001;

      if(self.animname == "price")
        thread dialogue_glanceatentity(level.player, lookupsoundlength(var_13), 1);

      thread dialogue_nagflaglogic(var_0, var_15);
      wait(var_15);
    }

    if(var_12) {
      break;
    }

    wait(var_4);
  }
}

dialogue_nagflaglogic(var_0, var_1) {
  level_setflag(256, 1);
  var_2 = gettime() + var_1 * 0.001;
  var_3 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_1, self, "death", var_0, "dialogue_endNag");

  if(!isDefined(var_3) || var_3 == "death")
    dialogue_stop();
  else if(var_3 == "dialogue_endNag")
    waittill_time(var_2);

  level_setflag(256, 0);
}

dialogue_naganimationlogic(var_0, var_1, var_2) {
  animation_stoploop(var_2, self);
  animation_singleintoidle(var_2, self, var_0, var_1);
}

dialogue_nagendonlogic(var_0, var_1, var_2) {
  var_0 endon("dialogue_endNag");

  if(isarray(var_1)) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2)
      childthread dialogue_nagendonnotifies_proc(var_0, var_1, var_4);
    } else {
      scripts\engine\utility::array_wait(var_1, var_2);
      var_0 notify("dialogue_endNag");
    }
  } else if(isarray(var_2)) {
    foreach(var_4 in var_2)
    childthread dialogue_nagendonnotifies_proc(var_0, var_1, var_4);
  } else {
    var_1 waittill(var_2);
    var_0 notify("dialogue_endNag");
  }
}

dialogue_nagendonnotifies_proc(var_0, var_1, var_2) {
  if(isarray(var_1))
    scripts\engine\utility::array_wait(var_1, var_2);
  else
    var_1 waittill(var_2);

  var_0 notify("dialogue_endNag");
}

dialogue_stop() {
  self stopsounds();
}

dialogue_stop_and_clear_stack() {
  self stopsounds();
  self stoploopsound();

  if(isDefined(self.function_stack) && isDefined(self.function_stack[0])) {
    self.function_stack[0].function_stack_func_begun = 0;
    scripts\engine\sp\utility::function_stack_clear();
  }
}

waittill_time(var_0) {
  while(gettime() < var_0)
    waitframe();
}

level_getflag(var_0) {
  return level.flags &var_0;
}

level_setflag(var_0, var_1) {
  if(var_1)
    level.flags = level.flags | var_0;
  else
    level.flags = level.flags &var_0;
}

dialogue_glanceatentity(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_0)) {}

  if(!isDefined(var_1))
    var_1 = 2.0;

  if(isDefined(var_2))
    var_2 = 0;

  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.poiauto)) {
    var_4 = self.poiauto;
    scripts\asm\shared\utility::toggle_poiauto(0);
    var_3 = 1;
  } else if(isDefined(self.currentpoi)) {
    var_5 = self.currentpoi;
    scripts\common\ai::poi_enable(0);
  }

  self glanceatentity(var_0, int(var_1 * 1000), var_2);
  wait(var_1);

  if(var_3) {
    scripts\common\ai::set_gunpose("ready", 1);
    scripts\asm\shared\utility::toggle_poiauto(1, var_4.yawmin, var_4.yawmax, var_4.pitchmin, var_4.pitchmax);
  } else if(isDefined(var_5))
    scripts\common\ai::poi_enable(1, var_5);
}

swap_vehicle_for_scriptable(var_0) {
  if(!isDefined(self)) {
    iprintlnbold("Self is null!");
    return;
  }

  if(!isDefined(var_0)) {
    iprintlnbold("Scriptable is null!");
    return;
  }

  var_0.origin = self.origin;
  var_0.angles = self.angles;
  waitframe();
  self delete();
}

ping_current_objective() {
  if(level.player.focus.objectivesupdatedisplay == 1) {
    return;
  }
  level.player scripts\sp\player::set_focus_objectives_update_display(1);
  level.player scripts\sp\player::set_focus_infinite_hold(1);
  wait 2.5;
  level.player scripts\sp\player::set_focus_objectives_update_display(0);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
}

butcher_stayahead_chase_speeds() {
  scripts\sp\utility::set_stayahead_values(1, 300, -50, 0.1);
  scripts\sp\utility::set_stayahead_values(2, 250, -150, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 200, -200, 0.1);
  scripts\sp\utility::set_stayahead_values(4, 180, -250, 0.15);
  scripts\sp\utility::enable_stayahead(level.player);
}

get_closest_living_ai(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  var_3 = scripts\engine\utility::array_removedead_or_dying(var_3);

  if(isDefined(var_2))
    var_3 = scripts\engine\utility::array_remove_array(var_3, var_2);

  if(var_3.size == 0)
    return undefined;

  return scripts\engine\utility::getclosest(var_0, var_3);
}

breath_fx_thread() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEntArray("stp_indoors", "targetname");
  var_1 = "slow";
  var_2 = scripts\engine\utility::getfx("cold_breath");

  for(;;) {
    if(isDefined(self.animname) && self.animname == "dead_body") {
      return;
    }
    var_3 = self.origin;
    wait 0.5;
    var_4 = randomintrange(3000, 5000);
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(self istouching(var_7))
        var_5 = 1;
    }

    if(var_5 == 1) {
      continue;
    }
    if(isDefined(self.isindoor) && self.isindoor == 1) {
      continue;
    }
    if(isDefined(self.vehicle_position)) {
      continue;
    }
    if(istrue(self.no_breath_fx)) {
      continue;
    }
    if(gettime() > var_4) {
      var_9 = length(self.origin - var_3);
      var_10 = randomintrange(3000, 5000);

      if(var_9 > 70) {
        var_10 = randomintrange(1000, 2000);
        var_2 = scripts\engine\utility::getfx("cold_breath_run");
      } else
        var_2 = scripts\engine\utility::getfx("cold_breath");

      var_4 = gettime() + var_10;
      playFXOnTag(var_2, self, "j_head");
    }
  }
}

enable_breath_fx(var_0) {
  if(isDefined(var_0))
    var_0.no_breath_fx = 0;
  else
    self.no_breath_fx = 0;
}

disable_breath_fx(var_0) {
  if(isDefined(var_0))
    var_0.no_breath_fx = 1;
  else
    self.no_breath_fx = 1;
}

civ_stationary_ff_penalty_think() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_civ_stationary_ff_penalty");
  var_0 = 0;
  wait 0.1;

  if(isDefined(self.animname) && self.animname == "dead_body") {
    return;
  }
  if(isDefined(self.script_animname) && self.script_animname == "child") {
    return;
  }
  for(;;) {
    var_1 = self.origin;
    wait 0.5;

    if(istrue(self.no_civ_ff_penalty)) {
      continue;
    }
    if(istrue(self.civ_ff_idle)) {
      thread scripts\sp\utility::civilianfailwrapper(undefined, undefined, 500, 1);
      return;
    }

    var_2 = length(self.origin - var_1);

    if(var_2 < 20) {
      if(var_0 == 0) {
        thread scripts\sp\utility::civilianfailwrapper(undefined, undefined, 500, 1);
        var_0 = 1;
      }

      continue;
    }

    if(var_0 == 1) {
      self notify("stop_civilian_fail_wrapper");
      var_0 = 0;
    }
  }
}

debug_display_rule_of_thirds() {
  level.player endon("death");
  precacheshader("c12_hud_verticalscanlines");
  setdvarifuninitialized("debug_rule_of_thirds", "1");
  var_0 = "c12_hud_verticalscanlines";
  var_1 = [];
  var_1[0] = create_debug_hud_line(213, 0, 1, 480, var_0);
  var_1[1] = create_debug_hud_line(426, 0, 1, 480, var_0);
  var_1[2] = create_debug_hud_line(0, 160, 640, 1, var_0);
  var_1[3] = create_debug_hud_line(0, 320, 640, 1, var_0);

  for(;;) {
    var_2 = getdvarint("debug_rule_of_thirds");

    if(var_2 != 1) {
      foreach(var_4 in var_1)
      var_4.alpha = 0;
    } else if(var_2 == 1) {
      foreach(var_4 in var_1)
      var_4.alpha = 1;
    }

    wait 0.05;
  }
}

create_debug_hud_line(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = newclienthudelem(level.player);
  var_7.x = var_0;
  var_7.y = var_1;
  var_7.sort = 1;
  var_7.horzalign = "fullscreen";
  var_7.vertalign = "fullscreen";
  var_7.alpha = 1;
  var_7 setshader(var_4, var_2, var_3);
  return var_7;
}

background_fakeciv_setup(var_0, var_1, var_2) {
  if(!isDefined(level.background_fakecivs))
    level.background_fakecivs = [];

  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  level.background_fakecivs = scripts\engine\utility::array_removedead(level.background_fakecivs);
  level.background_fakecivs = scripts\engine\utility::array_removeundefined(level.background_fakecivs);
  scripts\engine\utility::array_thread(var_3, ::background_fakeciv_idle, var_2);
  scripts\engine\utility::array_thread(level.background_fakecivs, ::background_fakeciv_scatter, var_1);
}

background_fakeciv_idle(var_0) {
  var_1 = getspawnerarray("background_fakeciv");
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = scripts\engine\sp\utility::fakeactorspawn(var_2);
  var_3.animname = "generic";
  var_3.animnode = self;
  var_3.current_state = "idle";
  var_3.ignoreme = 1;
  var_3 endon("death");
  var_3 endon("entitydeleted");
  var_4 = randomfloatrange(0, 1.5);
  var_3 scripts\engine\utility::delaythread(var_4, ::background_fakeciv_loop, self);
  level.background_fakecivs[level.background_fakecivs.size] = var_3;
  scripts\engine\utility::flag_wait(var_0);
  var_3 delete();
}

background_fakeciv_loop(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("civ_stop_background_loop");

  for(;;) {
    var_1 = randomintrange(1, 5);
    var_0 scripts\common\anim::anim_single_solo(self, "background_idle" + var_1);
  }
}

background_fakeciv_scatter(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.animnode.node_claimed = [];
  self.current_node = self.animnode;
  var_1 = scripts\engine\utility::getStruct(self.animnode.target, "targetname");
  var_2 = 0;

  if(isDefined(self.current_node.script_delay))
    var_2 = self.current_node.script_delay;

  if(isDefined(self.current_node.script_noteworthy) && self.current_node.script_noteworthy == "flee_on_player_look") {
    for(;;) {
      var_3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(35));

      if(var_3 == 1) {
        break;
      }

      wait 0.2;
    }

    wait(randomfloatrange(0, 1) + var_2);
  } else if(isDefined(self.current_node.script_noteworthy) && self.current_node.script_noteworthy == "flee_on_look_or_flag") {
    while(!scripts\engine\utility::flag(var_0)) {
      var_3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(35));

      if(var_3 == 1) {
        break;
      }

      wait 0.2;
    }

    wait(randomfloatrange(0, 1) + var_2);
  } else {
    scripts\engine\utility::flag_wait(var_0);
    wait(randomfloatrange(1, 3) + var_2);
  }

  self notify("civ_stop_background_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_4 = vectorNormalize(var_1.origin - self.origin);
  var_5 = anglesToForward(self.angles);
  var_6 = anglestoright(self.angles);
  var_7 = vectordot(var_4, var_5);
  var_8 = vectordot(var_4, var_6);
  var_9 = undefined;

  if(var_7 > 0.6) {
    if(var_8 > 0.6)
      var_9 = "background_exit_front_right";
    else if(var_8 < -0.6)
      var_9 = "background_exit_front_left";
    else
      var_9 = "background_exit_front";
  } else if(var_7 < -0.6) {
    if(var_8 > 0.6)
      var_9 = "background_exit_back_right";
    else if(var_8 < -0.6)
      var_9 = "background_exit_back_left";
    else
      var_9 = "background_exit_back";
  } else if(var_8 > 0.6)
    var_9 = "background_exit_right";
  else if(var_8 < -0.6)
    var_9 = "background_exit_left";

  if(isDefined(var_9)) {
    self.animname = "generic";
    scripts\common\anim::anim_single_solo_run(self, var_9);
  }

  var_10 = scripts\sp\fakeactor_node::fakeactor_node_get_path(var_1, self.origin, 1, 1);
  self.forced_node_path = var_10;
}

holster_logic() {
  level endon("interrogation_start");
  level.player notifyonplayercommand("actionslot 1", "+actionslot 1");
  childthread holster_cleanup_manager();
  childthread holster_inventory_manager();
  var_0 = undefined;

  for(;;) {
    level.player waittill("actionslot 1");
    var_0 = level.player.currentweapon;
    level.player giveweapon("iw8_holstered");
    level.player switchtoweapon("iw8_holstered");
    level.player notify("player_holsterWeapon");
    level.player scripts\common\utility::allow_weapon_switch(0);
    var_1 = scripts\engine\utility::waittill_any_ents_return(level.player, "actionslot 1", level.player, "weapon_switch_pressed", level.player, "pickup", level.player, "ads_pressed");
    level.player notify("player_weaponDrawn");
    level.player scripts\common\utility::allow_weapon_switch(1);
    level.player takeweapon("iw8_holstered");

    if(var_1 == "actionslot 1" || var_1 == "weapon_switch_pressed" || var_1 == "ads_pressed") {
      var_2 = var_0;

      if(weapon_empty(var_2)) {
        var_3 = level.player.primaryweapons;

        foreach(var_5 in level.player.primaryweapons) {
          if(!weapon_empty(var_5)) {
            continue;
          }
          var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        }

        var_2 = scripts\engine\utility::random(var_3);
      }

      level.player switchtoweapon(var_2);
    }
  }
}

holster_cleanup_manager() {
  for(;;) {
    level.player waittill("pickup", var_0, var_1);

    if(isDefined(var_1) && scripts\engine\utility::is_equal(var_1.classname, "weapon_iw8_holstered"))
      var_1 delete();
  }
}

holster_inventory_manager() {
  for(;;) {
    var_0 = level.player.primaryweapons;
    var_1 = level.player.currentweapon;
    waitframe();
    var_2 = level.player.primaryweapons;

    foreach(var_4 in var_2) {
      if(!weapon_empty(var_4)) {
        continue;
      }
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    }

    if(var_2.size <= 2) {
      continue;
    }
    if(scripts\engine\sp\utility::player_has_weapon("iw8_holstered")) {
      continue;
    }
    var_6 = undefined;

    foreach(var_8 in var_2) {
      if(scripts\engine\utility::array_contains(var_0, var_8)) {
        continue;
      }
      var_6 = var_8;
      break;
    }

    var_10 = scripts\engine\utility::array_remove(var_2, var_6);
    var_11 = scripts\engine\utility::random(var_10);
    var_12 = level.player.origin + anglesToForward(level.player.angles) * 10;
    spawn("weapon_" + createheadicon(var_11), var_12 + (0, 0, 3));
    level.player takeweapon(var_11);
  }
}

player_weapon_holstered() {
  return level.player.currentweapon.basename == "iw8_holstered";
}

set_enemy_low_health() {
  var_0 = scripts\common\utility::getdifficulty();

  if(var_0 == "easy")
    self.health = 1;
  else if(var_0 == "medium")
    self.health = int(self.health * 0.1);
  else if(var_0 == "hard")
    self.health = int(self.health * 0.5);
}

create_blood_decal() {
  var_0 = [];
  var_0[0] = "j_head";
  var_0[1] = "j_spine4";
  var_0[1] = "j_shoulder_le";
  var_0[1] = "j_shoulder_ri";
  var_0[2] = "j_knee_le";
  var_0[3] = "j_knee_ri";
  var_1 = self gettagorigin(scripts\engine\utility::random(var_0));
  var_2 = var_1 + (0, 0, -64);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, [self]);
  playFX(scripts\engine\utility::getfx("vfx_stpburg_blood_splat_light"), var_3["position"]);
}

cointoss_variable(var_0) {
  return randomint(100) >= var_0;
}

set_attackeraccuracy_handler(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_attackeraccuracy(var_0);

  if(isDefined(var_2)) {
    if(isarray(var_2))
      var_4 = level scripts\engine\utility::waittill_any_in_array_return(var_2);
    else
      scripts\engine\utility::flag_wait(var_2);
  }

  if(isDefined(var_3))
    wait(var_3);

  scripts\engine\sp\utility::set_attackeraccuracy(var_1);
}

array_rotate(var_0) {
  if(!isarray(var_0))
    return var_0;

  var_1 = [];
  var_2 = undefined;

  foreach(var_5, var_4 in var_0) {
    if(var_5 == 0) {
      var_2 = var_4;
      continue;
    }

    var_1[var_1.size] = var_4;
  }

  var_1[var_1.size] = var_2;
  return var_1;
}