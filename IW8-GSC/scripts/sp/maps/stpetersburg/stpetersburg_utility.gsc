/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc
*****************************************************************/

function setup_named_ai(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\sp\utility::spawn_targetname(var0, 1);
  var6.name = var1;
  var6.callsign = "Bravo 0-6";
  var6.animname = var0;
  var6.script_parameters = var0;
  var6.disableplayeradsloscheck = 1;
  var6.script_pushable = 1;
  var6.disablebulletwhizbyreaction = 1;
  var6.dontchangepushplayer = 1;
  var6 pushplayer(0);
  var6.dontmeleeme = 1;
  var6 scripts\engine\sp\utility::set_battlechatter(0);
  var6.script_forcegoal = 1;
  var6 scripts\engine\sp\utility::set_attackeraccuracy(0.5);
  var6.colornode_func = &color_node_arrive;

  if(!isDefined(var5)) {
    var5 = 1;
  }

  if(var5 == 1) {
    var6 thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  }

  if(isDefined(var3)) {
    scripts\engine\sp\utility::activate_trigger_with_targetname(var3);
  }

  if(isDefined(var4)) {
    if(var4 == "clear") {
      var6 scripts\common\utility::clear_demeanor_override();
    } else {
      var6 scripts\common\utility::demeanor_override(var4);
    }
  }

  if(isDefined(var2)) {
    var7 = scripts\engine\utility::getStruct(var2, "targetname");

    if(isDefined(var7)) {
      var6 forceteleport(var7.origin, var7.angles);
      var6 setgoalpos(var7.origin);
    }
  }

  return var6;
}

function price_push_on() {
  level.price.dontavoidplayer = 1;
  level.price.disablebulletwhizbyreaction = 1;
  level.price.script_pushable = 0;
  level.price enableavoidance(0);
  level.price.doavoidanceblocking = 0;
  level.price.dontchangepushplayer = undefined;
  level.price pushplayer(1);
  level.price.disableplayeradsloscheck = 1;
}

function price_push_off() {
  level.price.dontavoidplayer = 0;
  level.price.disablebulletwhizbyreaction = 0;
  level.price.script_pushable = 1;
  level.price enableavoidance(1);
  level.price.doavoidanceblocking = 1;
  level.price.dontchangepushplayer = 1;
  level.price pushplayer(0);
  level.price.disableplayeradsloscheck = 0;
}

function enforcer_safe_run() {
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

function spawn_enforcer(var0) {
  if(isalive(level.enforcer)) {
    enforcer_reset_fake_health();
    return;
  }

  var1 = getspawner("enforcer", "targetname");
  var1.count = 1;
  level.enforcer = var1 scripts\engine\sp\utility::spawn_ai(1);
  level.enforcer.animname = "enforcer";
  level.enforcer.name = "The Butcher";
  level.enforcer.callsign = "Jamal Rahar";
  level.enforcer scripts\engine\sp\utility::set_ignoresuppression(1);
  level.enforcer scripts\common\ai::magic_bullet_shield(1);
  var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.enforcer scripts\anim\shared::forceuseweapon(var2, "primary");
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

  if(isDefined(var0)) {
    var3 = getnode(var0, "targetname");

    if(isnode(var3)) {
      level.enforcer scripts\engine\sp\utility::teleport_ai(var3);
      return;
    }

    var3 = scripts\engine\utility::getStruct(var0, "targetname");

    if(isstruct(var3)) {
      level.enforcer forceteleport(var3.origin, var3.angles);
      return;
    }

    return;
  }
}

function spawn_nikolai() {
  scripts\engine\sp\utility::array_spawn_function_targetname("nikolai", &scripts\common\utility::demeanor_override, "casual");
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

function pursuit_timer(var0, var1, var2, var3, var4, var5) {
  level endon("missionfailed");
  level.player endon("death");
  level notify("pursuit_timer_reset");
  level endon("pursuit_timer_reset");

  if(getdvarint("debug_disable_pursuit_timer") >= 1) {
    return;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  var6 = 0;
  level.player clearhudtutorialmessage();
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");
  thread pursuit_autosave(var0, var3);
  var7 = scripts\common\utility::getdifficulty();

  if(var7 == "medium") {
    var1 = int(var1 * 0.95);
  } else if(var7 == "hard") {
    var1 = int(var1 * 0.9);
  } else if(var7 == "fu") {
    var1 = int(var1 * 0.85);
  }

  var8 = scripts\sp\hud_util::createfontstring("objective", 1);

  if(istrue(var6)) {
    var8 scripts\sp\hud_util::setpoint("LEFT", "CENTER", 250, -20);
    var8 settext("Pursuit Timer: " + var1);
    thread pursuit_hud_cleanup();
  } else {
    var6 = 0;
  }

  if(isDefined(var2) && scripts\engine\utility::flag_exist(var2)) {
    scripts\engine\utility::flag_wait(var2);
    LOC_00000134:
  }

  LOC_00000134:
    if(isDefined(var4) && (var7 == "easy" || var7 == "medium")) {
      var9 = getEnt(var4 + "_vol", "targetname");

      if(isDefined(var9)) {
        thread pursuit_death_flag_save(var4, var9);
      }
    }

  var10 = 10;
  var11 = 7;
  var12 = 10;

  if(var7 == "hard" || var7 == "fu") {
    var10 = 8;
    var11 = 5;
  }

  jumpiffalse(var1 < 10) LOC_000001a5;
  var10 = -10;
  var11 = -10;

  while(var1 > 0) {
    if(getdvarint("debug_disable_pursuit_timer") >= 1) {
      return;
    }

    var13 = level scripts\engine\utility::waittill_notify_or_timeout_return("pursuit_early_autosave", 1);

    if(var13 == "pursuit_early_autosave" && var1 > var12) {
      if(var7 != "fu") {
        pursuit_early_autosave();
      }

      if(var7 == "easy") {
        var1 = int(var1 * 1.2);
      }

      wait 1;
    }

    var1 -= 1;

    if(var1 <= var10 && var5 == 0) {
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_pursuit_target_escaping_nag();
      var10 = -10;
    }

    if(var6) {
      var8 settext("Pursuit Timer: " + var1);
    }

    if(scripts\engine\utility::flag(var0)) {
      if(var6) {}

      var8 scripts\sp\hud_util::destroyelem();
      scripts\engine\utility::flag_set("can_save");
      scripts\engine\utility::flag_clear("disable_autosaves");
      level.player clearhudtutorialmessage();
      level notify("pursuit_timer_reset");
      continue;
    }

    if(var1 == var11) {
      level.player sethudtutorialmessage(&"STPETERSBURG/PURSUIT_WARNING");
      level.player scripts\engine\utility::delaycall(6, &clearhudtutorialmessage);
      scripts\engine\utility::flag_clear("can_save");
      scripts\engine\utility::flag_set("disable_autosaves");
    }
  }

  var8 scripts\sp\hud_util::destroyelem();
  thread pursuit_timer_fail();
}

function pursuit_timer_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_pursuit_target_escaped_fail();
  wait 1;
  scripts\sp\player_death::set_custom_death_quote(76);
  thread scripts\sp\utility::missionfailedwrapper();
}

function pursuit_death_flag_save(var0, var1) {
  level endon("disable_autosaves");
  level endon("pursuit_timer_reset");
  scripts\engine\utility::flag_wait(var0);
  wait 1;

  if(level.player istouching(var1)) {
    level notify("pursuit_early_autosave");
    return;
  }
}

function pursuit_early_autosave() {
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");
  scripts\engine\sp\utility::autosave_or_timeout("pursuit_early_autosave", 3);
}

function pursuit_autosave(var0, var1) {
  level endon("disable_autosaves");
  scripts\engine\utility::flag_wait(var0);
  level notify("pursuit_timer_reset");
  level.player clearhudtutorialmessage();
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");

  if(var1 == 1) {
    scripts\engine\sp\utility::autosave_or_timeout("pursuit_autosave", 3);
    return;
  }
}

function pursuit_hud_cleanup() {
  level waittill("pursuit_timer_reset");

  if(isDefined(self)) {
    scripts\sp\hud_util::destroyelem();
    return;
  }
}

function enforcer_monitor_health_handler(var0) {
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
  var1 = 200;

  if(isDefined(var0)) {
    var1 = var0;
  }

  level.enforcer.fake_health = var1;

  while(isalive(level.enforcer) && level.enforcer.fake_health > 0) {
    level.enforcer waittill("damage", var2, var3, var4, var5, var6);

    if(isDefined(var6) && var6 == "MOD_EXPLOSIVE") {
      continue;
    }

    if(isDefined(var3) && var3 != level.player) {
      continue;
    }

    level.enforcer.fake_health -= var2;

    if(level.enforcer.fake_health <= 0) {
      break;
    } else {
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_pursuit_target_hurt_nag();
    }

    waitframe();
  }

  if(isDefined(level.enforcer.magic_bullet_shield) && level.enforcer.magic_bullet_shield == 1) {
    level.enforcer scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\engine\utility::flag_clear("can_save");
  scripts\engine\utility::flag_set("disable_autosaves");
  scripts\engine\utility::flag_set("flag_enforcer_killed");
  thread enforcer_death_fail();

  if(scripts\engine\utility::flag("flag_enforcer_custom_death")) {
    level.enforcer.skipdeathanim = undefined;
  } else {
    level.enforcer.skipdeathanim = 1;
  }

  if(!scripts\engine\utility::flag("flag_enforcer_anim_death")) {
    level.enforcer scripts\engine\sp\utility::anim_stopanimScripted();
    level.enforcer.diequietly = 1;
    level.enforcer scripts\engine\sp\utility::set_allowdeath(1);
    level.enforcer kill();
    return;
  }
}

function enforcer_reset_fake_health() {
  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  level.enforcer.fake_health = 200;
}

function enforcer_set_low_fake_health() {
  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  level.enforcer.fake_health = 10;
}

function enforcer_death_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");

  if(!scripts\engine\utility::flag("flag_gauntlet_nikolai_carrying_enforcer")) {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_pursuit_target_killed_fail();
    wait 2;
  }

  scripts\sp\player_death::set_custom_death_quote(84);
  thread scripts\sp\utility::missionfailedwrapper();
}

function objective_enforcer_los(var0, var1, var2, var3) {
  level.enforcer endon("death");
  level.player endon("death");
  level endon("objective_enforcer_los_end");

  if(!isalive(level.enforcer)) {
    return;
  }

  scripts\engine\sp\utility::delaychildthread(1, &enforcer_los_handler);
  thread objective_trigger_handler(var0, var2);
  var4 = "";
  jumpiffalse(isDefined(var3) && var3 == 1) LOC_0000005c;
  thread ping_current_objective();

  for(;;) {
    var5 = scripts\engine\utility::waittill_any_return("objective_enforcer_los_true", "objective_enforcer_los_false");

    if(var5 == "objective_enforcer_los_true") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var0);
      scripts\engine\sp\objectives::objective_set_on_entity(var0, &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER", level.enforcer);
      scripts\engine\sp\objectives::objective_set_show_distance(var0, 0);
      scripts\engine\sp\objectives::objective_set_z_offset(var0, 80);
      scripts\engine\sp\objectives::objective_set_label(var0, &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");
      continue;
    }

    if(var5 == "objective_enforcer_los_false") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var0);
      var6 = scripts\engine\utility::getStruct(var1, "targetname");
      scripts\engine\sp\objectives::objective_add_location_position(var0, var1, var6.origin);
      scripts\engine\sp\objectives::objective_set_label(var0, &"STPETERSBURG/OBJ_ICON_NAME_PURSUE");
    }
  }
}

function enforcer_los_handler() {
  var0 = 0;
  var1 = 0;
  var2 = 2;
  jumpiftrue(isalive(level.enforcer)) LOC_00000017;
  return;
}

function objective_trigger_handler(var0, var1) {
  scripts\engine\sp\utility::trigger_wait_targetname(var1);
  level notify("objective_enforcer_los_end");
  scripts\engine\sp\objectives::objective_remove_all_locations(var0);
}

function enforcer_blindfire(var0, var1, var2, var3) {
  level.enforcer endon("death");
  level.enforcer endon("end_fake_fire");

  if(!isDefined(var3)) {
    var3 = 10;
  }

  var4 = getcompleteweaponname("iw8_sm_mpapa7");
  var5 = weaponfiretime(var4) * 2;

  while(!scripts\engine\utility::flag(var2)) {
    for(var6 = 0; var6 <= randomintrange(3, 5); var6++) {
      magicbullet(var4, var0, var1 + scripts\engine\utility::randomvectorrange(0, var3), level.enforcer);
      wait var5;
    }

    wait randomfloatrange(0.5, 1.5);
  }
}

function color_node_arrive(var0) {
  self endon("death");
  waitframe();
  self.oldgoalradius = self.goalradius;
  self.goalradius = 1;
  self waittill("goal");

  if(isDefined(var0.script_gesture)) {
    thread scripts\engine\sp\utility::gesture_simple(var0.script_gesture);
  }

  if(isDefined(var0.script_flag)) {
    scripts\engine\utility::flag_set(var0.script_flag);
  }

  if(isDefined(var0.script_sound)) {
    thread scripts\engine\sp\utility::smart_dialogue(var0.script_sound);
  }

  self.goalradius = self.oldgoalradius;
}

function price_adjust_accuracy_over_time(var0) {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }

  level endon(var0);
  level.price.baseaccuracy = 0.3;

  while(level.price.baseaccuracy < 1) {
    wait 10;
    level.price.baseaccuracy += 0.1;
  }
}

function price_set_accuracy_low() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }

  level.price.baseaccuracy = 0.3;
}

function price_set_accuracy_average() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }

  level.price.baseaccuracy = 0.5;
}

function price_set_accuracy_high() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }

  level.price.baseaccuracy = 0.8;
}

function price_set_accuracy_max() {
  if(!getdvarint("scr_price_accuracy_adjust")) {
    return;
  }

  level.price.baseaccuracy = 10;
}

function display_ai_count() {
  level.player endon("death");
  level endon("nextmission");
  setdvarifuninitialized("debug_ai_count", -1);
  var0 = undefined;
  var1 = (1, 1, 1);
  var2 = (1, 1, 0);
  var3 = (0, 1, 0);
  var4 = (1, 0, 0);
  var5 = [];

  for(;;) {
    var6 = getDvar("debug_ai_count", -1);

    switch (var6) {
      case "all":
      case "0":
        var0 = "all";
        break;
      case "1":
      case "axis":
        var0 = "axis";
        break;
      case "2":
      case "allies":
        var0 = "allies";
        break;
      case "3":
      case "team3":
        var0 = "team3";
        break;
      case "4":
      case "neutral":
        var0 = "neutral";
        break;
      default:
        var0 = undefined;
        break;
    }

    if(isDefined(var0)) {
      if(var0 != "all") {
        var5 = [];
        var5 = getaiarray(var0).size;
      } else {
        var5 = getaiarray("axis").size;
        var5 = getaiarray("allies").size;
        var5 = getaiarray("team3").size;
        var5 = getaiarray("neutral").size;
      }
    } else {
      var5 = [];
      wait 0.5;
      continue;
    }

    var7 = 0;

    foreach(var9 in var5) {
      var7 += var9;
    }

    var11 = var1;

    if(var7 < 10) {
      var11 = var3;
    } else if(var7 < 20) {
      var11 = var2;
    } else {
      var11 = var4;
    }

    var12 = 700;
    var13 = 30;

    if(isDefined(var0)) {
      if(var0 == "all") {}

      foreach(var9 in var5) {
        var15 = " AI";

        if(isDefined(var0)) {
          if(var0 == "all") {
            switch (var16) {
              case 0:
                var15 = " enemies";
                break;
              case 1:
                var15 = " allies";
                break;
              case 2:
                var15 = " police";
                break;
              case 3:
                var15 = " civilians";
                break;
            }
          } else {
            var15 = " " + var0;
          }
        }

        var13 += 20;
      }
    }

    waitframe();
  }
}

function weapon_empty(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  return scripts\engine\utility::is_equal(var0.basename, "none");
}

function enable_blindfire_behavior() {
  self.aggressiveblindfire = 1;
  self.neverenablecqb = 1;
  self.maxfaceenemydist = 256;
  self.disable_blindfire = undefined;
  self.favor_blindfire = 1;
  self.rambochance = 1;
  self.ramboaccuracymult = 1;
  self.baseaccuracy = 0.75;
  self.neversprintforvariation = undefined;
}

function disable_blindfire_behavior() {
  self.aggressiveblindfire = 0;
  self.favor_blindfire = undefined;
  self.rambochance = undefined;
  self.neverenablecqb = 0;
  self.maxfaceenemydist = 512;
  self.ramboaccuracymult = undefined;
}

function scared_civs_notice_player() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_looking");

  for(;;) {
    if(scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(45)) && scripts\engine\sp\utility::players_within_distance(200, self.origin)) {
      if(scripts\engine\utility::cointoss()) {
        self setlookatentity(level.player);
      }

      self glanceatentity(level.player, randomintrange(1200, 2000));
      wait randomintrange(4, 8);
    }

    wait 0.3;
  }
}

function scared_civs_player_looking(var0) {
  self endon("death");
  var1 = cos(35);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(distance(level.player.origin, var0.origin) < 100) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var1)) {
        if(isDefined(self)) {
          scared_civs_cower(var0);
        }
      }
    }

    wait 0.25;
  }
}

function scared_civs_trigger_grenade(var0) {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
  wait 2;
  scared_civs_cower(var0);
}

function scared_civs_cower(var0) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  if(!self.cowering) {
    self.cowering = 1;
    var0 notify("stop_loop");
    var0 scripts\common\anim::anim_single_solo(self, "apt_stairs_block_react");

    if(isDefined(self)) {
      var0 scripts\common\anim::anim_loop_solo(self, "apt_stairs_block_react_idle");
      return;
    }

    return;
  }
}

function set_walking_speed(var0) {
  if(!isDefined(var0)) {
    var0 = 20;
  }

  scripts\asm\asm_bb::bb_setcivilianstate("casual");
  scripts\asm\asm_bb::bb_civilianrequestspeed(var0);
}

function populate_civs_looping(var0, var1) {
  var2 = getspawner(var0, "targetname");
  var3 = scripts\engine\utility::getStructArray(var1, "targetname");
  var4 = [];

  foreach(var6 in var3) {
    var2.count = 1;
    var7 = var2 scripts\engine\sp\utility::spawn_ai(1);
    var4 = scripts\engine\utility::array_add(var4, var7);
    var7 forceteleport(var6.origin, var6.angles);
    wait 0.5;
    thread addloopinganimation(var7);
    var7.animstruct = var6;
    var7.location = var7;
  }

  return var4;
}

function addloopinganimation(var0) {
  self.animname = "generic";
  var1 = var0.animation;
  var0 thread scripts\common\anim::anim_generic_loop(self, var1, "stop_loop");
}

function populate_civs_no_loop(var0, var1) {
  var2 = getspawner(var0, "targetname");
  var3 = scripts\engine\utility::getStructArray(var1, "targetname");
  var4 = [];

  foreach(var6 in var3) {
    var2.count = 1;
    var7 = var2 scripts\engine\sp\utility::spawn_ai(1);
    var4 = scripts\engine\utility::array_add(var4, var7);
    var7 forceteleport(var6.origin, var6.angles);
    wait 0.5;
    thread addanimation(var7);
    var7.animstruct = var6;
    var7.location = var7;
  }

  return var4;
}

function addanimation(var0) {
  self.animname = "generic";
  var1 = var0.animation;
  var0 thread scripts\common\anim::anim_generic(self, var1);
}

function put_player_into_rig(var0, var1, var2, var3, var4, var5, var6) {
  if(istrue(var6)) {
    var0 setModel("viewhands_base_fullbody_iw8");
  } else {
    level.player hidelegsandshadow();
  }

  level.player freezecontrols(0);
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var1 > 0) {
    level.player playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  var0 show();
  var0 castshadows();
}

function pull_player_out_of_rig_hide_rig(var0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowmelee(1);
  var0 hide();
  var0 dontcastshadows();
  var0 setModel("viewhands_hero_kyle_urban_fullbody");
  level.player enableweapons();
  level.player unlink();
}

function put_player_into_cam_rig(var0, var1, var2, var3, var4, var5, var6) {
  if(istrue(var6)) {
    var0 setModel("viewhands_base_fullbody_iw8");
  } else {
    level.player hidelegsandshadow();
  }

  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var1 > 0) {
    level.player playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
}

function aq_override_pistol_silenced() {
  var0 = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["silencerpstl_west01"]);
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function aq_override_ar_lasersight() {
  var0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["laser_bar"]);
  scripts\anim\shared::forceuseweapon(var0, "primary");
  self laserforceon();
}

function player_holdingpistolweapon() {
  if(player_holdingemptyweapon()) {
    return false;
  }

  if(player_weapon_holstered()) {
    return false;
  }

  return true;
}

function player_holdingemptyweapon() {
  return weapon_empty(level.player.currentweapon);
}

function player_takeawaygunlessweapon() {
  if(scripts\engine\sp\utility::player_has_weapon("iw8_gunless")) {
    level.player takeweapon("iw8_gunless");
  }

  return true;
}

function give_player_max_ammo_on_pickup() {
  level.player endon("death");

  for(;;) {
    level.player waittill("pickup");
    level.player waittill("weapon_change");
    level.player givemaxammo(level.player getcurrentweapon());
    wait 1;
  }
}

function interrogation_room_door_close(var0, var1) {
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 3);
  var2 = getEnt(var0, "targetname");
  var3 = scripts\engine\utility::getStruct(var0 + "_close", "targetname");
  thread warehouse_garage_door_open_audio(var2);
  var2 moveTo(var3.origin, var1);
}

function warehouse_garage_door_open_audio(var0) {
  wait 1;
  self playSound("stp_garage_open_start");
  self playLoopSound("stp_garage_open_lp");
  wait var0 - 1;
  self playSound("stp_garage_open_stop");
  wait 0.25;
  self stoploopsound();
}

function interrogation_room_door_open(var0, var1) {
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 3);
  var2 = getEnt(var0, "targetname");
  var3 = scripts\engine\utility::getStruct(var0 + "_open", "targetname");
  var2 moveTo(var3.origin, var1);
}

function price_clean_up_last_enemy(var0, var1) {
  waitframe();

  if(!isDefined(var1)) {
    var1 = 0;
  }

  while(var0.size > 1) {
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);
    wait 0.1;
  }

  wait var1;
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);

  if(var0.size > 0) {
    scripts\engine\sp\utility::array_notify(var0, "begin_price_cleanup");
    return;
  }
}

function setup_enemy_for_price_clean_up() {
  self endon("death");
  scripts\engine\utility::waittill_either("damage", "begin_price_cleanup");

  if(isalive(self)) {
    price_set_accuracy_max();
    var0 = self;
    var1 = sighttracepassed(level.price getEye(), self getEye(), 0, undefined);

    if(isDefined(var1) && var1 == 1) {
      var0 = self getEye();
    }

    scripts\engine\sp\utility::set_attackeraccuracy(10);
    self.health = 10;
    level.price shoot(100, var0);
    return;
  }
}

function price_get_los_enemy(var0) {
  foreach(var2 in var0) {
    var3 = sighttracepassed(level.price getEye(), var2 getEye(), 1, undefined);

    if(var3 == 1) {
      return var2;
    }
  }

  var2 = scripts\engine\utility::getclosest(level.price.origin, var0);
  return var2;
}

function trigger_safe_function(var0, var1, var2) {
  var3 = getEntArray(var0, var1);

  if(var3.size == 0) {
    return;
  }

  foreach(var5 in var3) {
    switch (var2) {
      case "activate":
        var5 scripts\engine\utility::trigger_on();
        var5 scripts\engine\sp\utility::activate_trigger();
        break;
      case "disable":
        var5 scripts\engine\utility::trigger_off();
        break;
      case "enable":
        var5 scripts\engine\utility::trigger_on();
        break;
      default:
        break;
    }
  }
}

function player_wander_fail_handler(var0) {
  level notify("end_wander_fail");
  level endon("end_wander_fail");
  level endon("missionfailed");
  level.player endon("death");

  if(!isDefined(level.player_wander_struct)) {
    level.player_wander_struct = spawnStruct();
  }

  scripts\engine\utility::flag_clear("flag_end_player_wander_fail");
  level.player_wander_nag = 0;

  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = 1;
  var2 = 90;
  var3 = 90;
  var4 = 20;

  if(var0) {
    var2 = 30;
    var3 = 30;
    var4 = 10;
  }

  var1 = 0;

  while(!scripts\engine\utility::flag("flag_end_player_wander_fail")) {
    if(var2 <= 0) {
      thread player_wander_fail();
      return;
    }

    var5 = level.player_wander_struct.array;
    var6 = level.player_wander_struct.array_hardfail;

    if(isDefined(var6) && var6.size > 0) {
      if(level.player scripts\engine\sp\utility::is_touching_any(var6)) {
        var2 = -1;
        continue;
      }
    }

    if(isDefined(var5) && var5.size > 0) {
      var7 = var1;

      if(level.player scripts\engine\sp\utility::is_touching_any(var5)) {
        var1 = 1;
      } else {
        var1 = 0;
      }

      if(var7 != var1) {
        if(var1) {
          setomnvar("ui_out_of_bounds_countdown", 0);
          var2 = var3;

          if(level.player_wander_nag == 1) {
            thread delay_reset_player_wander_nag(4);
          }
        } else {
          setomnvar("ui_out_of_bounds_countdown", 1);

          if(level.player_wander_nag == 0) {
            thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_player_wander_nag();
            level.player_wander_nag = 1;
            thread delay_reset_player_wander_nag(8);
          }
        }
      } else if(!var1) {
        var2--;
      }
    }

    wait 0.1;
  }

  waitframe();
  level.player_wander_struct.array = [];
  level.player_wander_struct.array_hardfail = [];
}

function player_wander_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_player_wander_fail();
  wait 2;
  scripts\sp\player_death::set_custom_death_quote(429);
  thread scripts\sp\utility::missionfailedwrapper();
}

function delay_reset_player_wander_nag(var0) {
  level.player notify("delay_reset_player_wander_nag");
  level.player endon("delay_reset_player_wander_nag");
  wait var0;
  level.player_wander_nag = 0;
}

function set_wander_fail_volume(var0) {
  if(getdvarint("debug_disable_wander_fail") >= 1) {
    return;
  }

  if(!isDefined(level.player_wander_struct)) {
    thread player_wander_fail_handler();
    waitframe();
  }

  level.player_wander_struct.array = getEntArray(var0, "targetname");
  level.player_wander_struct.array_hardfail = getEntArray(var0 + "_hardfail", "targetname");
}

function transient_unload_load(var0, var1) {
  waitframe();

  if(isDefined(var0)) {
    var2 = [];

    if(isarray(var0)) {
      var2 = var0;
    } else {
      GscBinSkip0(0x2e, 0, var0);
    }

    scripts\engine\sp\utility::transient_unload_array(var2);
  }

  if(isDefined(var1)) {
    var3 = [];

    if(isarray(var1)) {
      var3 = var1;
    } else {
      GscBinSkip0(0x2e, 0, var1);
    }

    scripts\engine\sp\utility::transient_load_array(var3);
    return;
  }
}

function transient_waittill(var0, var1, var2) {
  scripts\engine\utility::flag_wait(var0);
  thread transient_unload_load(var1, var2);
}

function waittill_array_alive_count_or_timeout(var0, var1, var2) {
  var3 = spawnStruct();
  GscBinSkip4(0x6e, var3, var0, var1);
}

function waittill_alive_count(var0, var1) {
  while(var0.size > var1) {
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);
    waitframe();
  }

  self notify("alive_count");
}

function price_advance_trigger(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = getEnt(var0, "targetname");

  if(isDefined(var4)) {
    var5 = var4.script_color_allies;

    if(isDefined(var1)) {
      var4 scripts\engine\utility::waittill_any_timeout(var1, "trigger");
    }
  } else {
    return;
  }

  level.price endon("cancel_advance_trigger");

  while(isDefined(var4)) {
    if(getdvarint("debug_disable_wander_fail") >= 1) {
      return;
    }

    var6 = var4 scripts\engine\sp\utility::get_ai_touching_volume("axis");
    var7 = var4 scripts\engine\sp\utility::get_ai_touching_volume("team3");
    var8 = scripts\engine\utility::array_combine(var6, var7);

    if(var2 == 1) {
      foreach(var10 in var8) {
        if(var10 != level.enforcer) {
          var10.health = 1;
        }
      }

      break;
    }

    if(var8.size > var3) {
      var12 = getpriceenemytarget(var8);
      var13 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.price getEye(), cos(75));

      if(isDefined(var12) && !var13) {
        level.price shoot(100, var12);
      } else {
        var12 = scripts\engine\utility::random(var8);
        level.price getenemyinfo(var12);
      }
    } else {
      break;
    }

    wait 0.1;
  }

  thread trigger_safe_function(var0, "targetname", "activate");
  level.price notify("cancel_advance_trigger");
}

function getpriceenemytarget(var0) {
  foreach(var2 in var0) {
    if(isDefined(level.enforcer) && scripts\engine\utility::is_equal(var2, level.enforcer)) {
      continue;
    }

    var3 = sighttracepassed(level.price getEye(), var2 getEye(), 0, undefined);

    if(var3 == 1) {
      return var2;
    }
  }
}

function setup_dead_bodies(var0, var1) {
  var2 = getspawnerarray(var0);

  foreach(var4 in var2) {
    thread dead_body_create(var4);
  }
}

function dead_body_create(var0) {
  self.script_bodyonly = undefined;
  var1 = scripts\engine\sp\utility::spawn_ai(1);
  var1 endon("entitydeleted");
  var1 endon("death");
  var1.animname = "dead_body";
  var1.team = "neutral";
  var1 scripts\common\anim::anim_single_solo(var1, var1.animation);
  var1 scripts\common\anim::anim_last_frame_solo(var1, var1.animation);
  wait 1;
  var1.forceragdollimmediate = 1;
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 scripts\engine\sp\utility::die();
  scripts\engine\utility::flag_wait(var0);

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function periph_vehicle_loop_new(var0, var1, var2, var3) {
  jumpiffalse(scripts\engine\utility::flag(var0)) LOC_00000010;
  return;
}

function periph_vehicle_driver(var0) {
  var1 = scripts\engine\utility::random(var0);
  var2 = scripts\engine\sp\utility::fakeactorspawn(var1);
  var2.animname = "generic";
  var2.animnode = self;
  var2.current_state = "idle";
  var2.ignoreme = 1;
  var2.no_breath_fx = 1;
  var2.diequietly = 1;
  var2 notsolid();
  var2 scripts\engine\sp\utility::set_allowdeath(0);
  var2.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.5);
  var2 notify("stop_civilian_fail_wrapper");
  return var2;
}

function periph_vehicle_driver_delete_handler(var0) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(var0)) {
    wait 0.1;
  }

  self delete();
}

function vehicle_loop(var0, var1, var2, var3, var4, var5, var6) {
  waitframe();

  if(scripts\engine\utility::flag(var1)) {
    return;
  }

  while(!scripts\engine\utility::flag(var1)) {
    if(isDefined(var0.size)) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }

    spawn_cluster(var0, var2, var3, var4, var5, var6);
  }
}

function spawn_cluster(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = var1;
  }

  if(var1 == var2) {
    var6 = var1;
  } else {
    var6 = randomintrange(var2, var3);
  }

  if(!isDefined(var4)) {
    var4 = 10;
  }

  if(!isDefined(var5)) {
    var5 = var4;
  }

  if(var4 == var5) {
    var7 = var4;
  } else {
    var7 = randomfloatrange(var5, var6);
  }

  for(var8 = 0; var8 < var7; var8++) {
    var9 = 0;
    var10 = "";

    if(isDefined(var2.size)) {
      var10 = var2[var9 + var8];
    } else {
      var10 = var2;
    }

    var11 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var10);
    var11 vehicle_turnengineoff();
    var11.script_vehicle_selfremove = 1;

    if(isDefined(var6)) {
      if(isDefined(var6[var9].size)) {
        var11 setModel(var6[var9][randomintrange(0, var6[var9].size)]);
      } else {
        var11 setModel(var6[randomintrange(0, var6.size)]);
      }
    }

    waitframe();
    wait randomfloatrange(2, 3);
  }

  wait var7;
}

function spawn_driver() {
  var0 = getspawnerarray("traffic_driver");
  var1 = var0[randomintrange(0, var0.size + 1)];
  var1.count = 1;
  var2 = var1 scripts\engine\sp\utility::spawn_ai(1, 0);
  var1.count = 1;
  self.driver = var2;
  link_driver(var2, self);
}

function link_driver(var0) {
  scripts\engine\sp\utility::teleport_to_ent_tag(var0, "TAG_DRIVER");
  self linkTo(var0, "Tag_Driver", (0, 0, 0), (0, 0, 0));
  self.animname = "trafficdriver";
  thread scripts\common\anim::anim_loop_solo(self, "stp_street_traffic");
}

function delete_on_flag(var0) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait(var0);

  if(isDefined(self.driver)) {
    self.driver delete();
  }

  self delete();
}

function manage_oscillation(var0) {
  self vehicle_setspeedimmediate(var0, 1, 1);
  var1 = gettime();

  while(isDefined(self)) {
    var2 = gettime() - var1;
    var3 = var0;
    var3 += sin(var2 * 2.5 / (var0 + 5)) * var0 * 0.15;
    iprintlnbold(var3 + " - " + var0);
    self vehicle_setspeed(var3, 5, 5);
    wait 0.073;
  }
}

function wait_player_not_looking(var0, var1, var2) {
  var3 = cos(50);
  var4 = gettime();

  for(;;) {
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0, var3)) {
      if(isDefined(var2)) {
        if(distance(level.player.origin, var0) > var2) {
          break;
        }
      } else {
        break;
      }
    }

    if(isDefined(var1) && var1 > -1) {
      var5 = gettime();
      var6 = (var5 - var4) * 0.001;

      if(var6 > var1) {
        break;
      }
    }

    wait 0.2;
  }
}

function animation_exists(var0, var1) {
  return isDefined(level.scr_anim[var0][var1]);
}

function animation_stoploop(var0, var1) {
  var0 notify("stop_loop" + var1.animname);
}

function animation_stopreach(var0, var1) {
  var0 notify("stop_reach" + var1.animname);
}

function animation_reachtosingleintoidle(var0, var1, var2, var3) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  animation_singleintoidle(var0, var1, var2, var3);
}

function animation_reachtosingle(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
}

function animation_singleintoidle(var0, var1, var2, var3) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 endon("stop_loop" + var1.animname);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  animation_idle(var0, var1, var3);
}

function animation_reachintofirstframe(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("stop_reach" + var1.animname);
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  var0 thread scripts\common\anim::anim_first_frame_solo(var1, var2);
}

function animation_singleintolastframe(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  var0 thread scripts\common\anim::anim_last_frame_solo(var1, var2);
}

function animation_reachtoidle(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("stop_reach" + var1.animname);
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  animation_idle(var0, var1, var2);
}

function animation_idle(var0, var1, var2) {
  var0 thread scripts\common\anim::anim_loop_solo(var1, var2, "stop_loop" + var1.animname);
}

function init_dialog_structs() {
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

function create_dialog_struct(var0, var1) {
  var2 = spawnStruct();
  var2.name = var0;
  var2.team = var1;
  return var2;
}

function add_dialogue_line_kyle(var0, var1, var2, var3, var4, var5) {
  if(isDefined(level.player)) {
    level.player.name = "Kyle";
    level.player.team = "allies";
    dialogue(level.player, var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.kyle_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_price(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var6)) {
    scripts\engine\utility::flag_waitopen("pause_price_vo");
  }

  if(isDefined(level.price)) {
    if(!scripts\engine\utility::flag("flag_bink_active")) {
      level.price.name = "Captain Price";
    }

    level.price.team = "allies";
    dialogue(level.price, var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.price_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_nikolai(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var6)) {
    scripts\engine\utility::flag_waitopen("pause_nikolai_vo");
  }

  if(isDefined(level.nikolai)) {
    if(!scripts\engine\utility::flag("flag_bink_active")) {
      level.nikolai.name = "Nikolai";
    }

    level.nikolai.team = "allies";
    dialogue(level.nikolai, var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.nikolai_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_civilian(var0, var1, var2, var3, var4, var5) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "Civilian";
    scripts\engine\sp\utility::name_hide();
    self.team = "neutral";

    if(!isDefined(self.animname)) {
      self.animname = "generic";
    }

    self.og_name = "Civilian";
    dialogue(var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.civilian_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_police(var0, var1, var2, var3, var4, var5) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "Police";
    scripts\engine\sp\utility::name_hide();
    self.team = "team3";

    if(!isDefined(self.animname)) {
      self.animname = "generic";
    }

    self.og_name = "Police";
    dialogue(var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.police_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_aq_soldier(var0, var1, var2, var3, var4, var5) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "Al Qatala";
    scripts\engine\sp\utility::name_hide();
    self.team = "axis";

    if(!isDefined(self.animname)) {
      self.animname = "generic";
    }

    self.og_name = "Al Qatala";
    dialogue(var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.aq_soldier_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_butcher(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var6)) {
    scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  }

  if(isDefined(level.enforcer) && !scripts\engine\utility::flag("enforcer_dead")) {
    level.enforcer.name = "The Butcher";
    level.enforcer.team = "axis";
    dialogue(level.enforcer, var0, var1, var2, var3, var4, var5);
    return;
  }

  if(isDefined(level.escorttargetdrone)) {
    level.escorttargetdrone.name = "The Butcher";
    level.escorttargetdrone.team = "axis";
    dialogue(level.escorttargetdrone, var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.butcher_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_butcher_wife(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var6)) {
    scripts\engine\utility::flag_waitopen("pause_family_vo");
  }

  if(isDefined(level.enforcerwife) || isDefined(level.escortdrones[0])) {
    if(isDefined(level.enforcerwife)) {
      level.enforcerwife.name = scripts\engine\utility::ter_op(scripts\engine\utility::flag("interrogation_escort_done"), "Ousa", "Woman");
      level.enforcerwife.team = scripts\engine\utility::ter_op(scripts\engine\utility::flag("intel_revealed"), "allies", "neutral");
      level.enforcerwife stoploopsound();
      dialogue(level.enforcerwife, var0, var1, var2, var3, var4, var5);
      return;
    }

    if(isDefined(level.escortdrones[0])) {
      dialogue(level.escortdrones[0], var0, var1, var2, var3, var4, var5);
      return;
    }

    return;
  }

  dialogue(level.butcher_wife_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_butcher_son(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var6)) {
    scripts\engine\utility::flag_waitopen("pause_family_vo");
  }

  if(isDefined(level.enforcerson) || isDefined(level.escortdrones[1])) {
    var7 = undefined;

    if(isDefined(level.enforcerson)) {
      var7 = level.enforcerson;
    } else if(isDefined(level.escortdrones[1])) {
      var7 = level.escortdrones[1];
    }

    var7.name = scripts\engine\utility::ter_op(scripts\engine\utility::flag("interrogation_escort_done"), "Amon", "Boy");
    var7.team = scripts\engine\utility::ter_op(scripts\engine\utility::flag("intel_revealed"), "allies", "neutral");
    dialogue(var7, var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.butcher_son_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function add_dialogue_line_yegor(var0, var1, var2, var3, var4, var5) {
  if(isDefined(level.yegor)) {
    level.yegor.name = "Yegor";
    level.yegor.team = "allies";
    dialogue(level.yegor, var0, var1, var2, var3, var4, var5);
    return;
  }

  dialogue(level.yegor_dialog_struct, var0, undefined, var2, var3, var4, var5);
}

function dialogue(var0, var1, var2, var3, var4, var5) {
  self endon("death");

  if(isDefined(var3) && isDefined(var4)) {
    if(!isarray(var3)) {
      var3 = [var3];
    }

    if(!isarray(var4)) {
      var4 = [var4];
    }

    foreach(var7 in var3) {
      foreach(var9 in var4) {
        var7 endon(var9);
      }
    }
  }

  if(isDefined(var2) && var2) {
    wait var2;
  }

  if(isDefined(var1)) {
    if(!soundexists(var1)) {
      iprintln("Cound not find dialogue line " + var1 + " - please check stpetersburg_vo.csv");
    } else {
      if(isPlayer(self)) {
        scripts\engine\sp\utility::smart_player_dialogue(var1);
      } else if(istrue(var5)) {
        scripts\engine\sp\utility::smart_radio_dialogue(var1);
      } else {
        scripts\engine\sp\utility::smart_dialogue(var1);
      }

      self notify("dialogue_finished");
    }
  }

  if(!isDefined(var1) || getdvarint("scr_show_temp_dialogue")) {
    if(scripts\engine\utility::is_equal(self.team, "axis")) {
      var12 = "^1";
    } else if(scripts\engine\utility::is_equal(self.team, "allies")) {
      var12 = "^2";
    } else {
      var12 = "^3";
    }

    if(!isDefined(self.name)) {
      var13 = self.og_name;
    } else {
      var13 = self.name;
    }

    if(istrue(var12)) {
      var14 = var13 + var13 + " (Over Radio)" + ": " + "^7" + var3;
    } else {
      var14 = var13 + var14 + ": " + "^7" + var4;
    }

    thread dialogue_proc(var14, var12);
    return;
  }
}

function dialogue_proc(var0, var1) {
  level notify("new_dialogue");
  var2 = 0.3;
  var3 = 3;
  var4 = 2;
  var5 = 1.2;
  var6 = int(5.9 * var5);
  var7 = int(24 * var5);
  var8 = 300;
  var9 = newhudelem();
  var10 = newhudelem();
  var11 = 350;
  var12 = int(max(var0.size * var6, var11));
  var13 = [var9, var10];
  scripts\engine\utility::array_thread(var13, &dialog_new_line_monitor);

  foreach(var15 in var13) {
    var15.alignx = "center";
    var15.aligny = "middle";
    var15.x = 320;
    var15.y = var8;
    var15.sort = 5;
  }

  var9.alpha = 0.5;
  var9 setshader("black", var12, var7);
  var10 settext(var0);
  var10.fontscale = var5;
  wait var3;

  foreach(var15 in var13) {
    var15 fadeovertime(var4);
    var15.alpha = 0;
  }

  wait var4;

  foreach(var15 in var13) {
    var15 destroy();
  }
}

function dialog_new_line_monitor() {
  self endon("death");

  for(;;) {
    level waittill("new_dialogue");
    self moveovertime(0.35);
    self.y += 30;
    waitframe();
  }
}

function dialogue_naglogic(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  self endon("death");
  self endon("entitydeleted");
  var11 = spawnStruct();
  var11 endon("dialogue_endNag");
  thread dialogue_nagendonlogic(var11, var3, var4);
  GscBinSkip4(0x35, var11, var5, var0, var1, var2, var6, var7, var8, var9, var10);
}

function dialogue_naglogic_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(istrue(var1)) {
    wait var1;
  }

  var10 = 0;
  var11 = 0;

  for(;;) {
    if(isDefined(var7) && isDefined(var8) && isDefined(var9)) {
      GscBinSkip4(0x35, var7, var8, var9);
    }

    var12 = 0;

    if(isDefined(var6) && ![[var6]]()) {
      var13 = var5[var11];
      var14 = var5[var11];
      var11++;
      var12 = var11 >= var5.size;
    } else {
      var13 = var3[var10];
      var14 = var2[var10];
      var10++;
      var12 = var10 >= var3.size;
    }

    thread dialogue(var14, var13);

    if(soundexists(var13)) {
      var15 = lookupsoundlength(var13) * 0.001;

      if(self.animname == "price") {
        thread dialogue_glanceatentity(level.player, lookupsoundlength(var13), 1);
      }

      thread dialogue_nagflaglogic(var0, var15);
      wait var15;
    }

    if(var12) {
      break;
    }

    wait var4;
  }
}

function dialogue_nagflaglogic(var0, var1) {
  level_setflag(256, 1);
  var2 = gettime() + var1 * 0.001;
  var3 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var1, self, "death", var0, "dialogue_endNag");

  if(!isDefined(var3) || var3 == "death") {
    dialogue_stop();
  } else if(var3 == "dialogue_endNag") {
    waittill_time(var2);
  }

  level_setflag(256, 0);
}

function dialogue_naganimationlogic(var0, var1, var2) {
  animation_stoploop(var2, self);
  animation_singleintoidle(var2, self, var0, var1);
}

function dialogue_nagendonlogic(var0, var1, var2) {
  var0 endon("dialogue_endNag");

  if(isarray(var1)) {
    if(isarray(var2)) {
      var3 = var2;
      var5 = getfirstarraykey(var3);

      if(isDefined(var5)) {
        var4 = var3[var5];
        GscBinSkip4(0x35, var0, var1, var4);
      }

      var3 = undefined;
      var5 = undefined;
      return;
    }

    scripts\engine\utility::array_wait(var1, var2);
    var0 notify("dialogue_endNag");
    return;
  }

  if(isarray(var2)) {
    var6 = var2;
    var7 = getfirstarraykey(var6);

    if(isDefined(var7)) {
      var4 = var6[var7];
      GscBinSkip4(0x35, var0, var1, var4);
    }

    var6 = undefined;
    var7 = undefined;
    return;
  }

  var1 waittill(var2);
  var0 notify("dialogue_endNag");
}

function dialogue_nagendonnotifies_proc(var0, var1, var2) {
  if(isarray(var1)) {
    scripts\engine\utility::array_wait(var1, var2);
  } else {
    var1 waittill(var2);
  }

  var0 notify("dialogue_endNag");
}

function dialogue_stop() {
  self stopsounds();
}

function dialogue_stop_and_clear_stack() {
  self stopsounds();
  self stoploopsound();

  if(isDefined(self.function_stack) && isDefined(self.function_stack[0])) {
    self.function_stack[0].function_stack_func_begun = 0;
    scripts\engine\sp\utility::function_stack_clear();
    return;
  }
}

function waittill_time(var0) {
  while(gettime() < var0) {
    waitframe();
  }
}

function level_getflag(var0) {
  return level.flags &var0;
}

function level_setflag(var0, var1) {
  if(var1) {
    level.flags |= var0;
    return;
  }

  level.flags &= var0;
}

function dialogue_glanceatentity(var0, var1, var2) {
  self endon("death");

  if(isDefined(var0)) {}

  if(!isDefined(var1)) {
    var1 = 2;
  }

  if(isDefined(var2)) {
    var2 = 0;
  }

  var3 = 0;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(self.poiauto)) {
    var4 = self.poiauto;
    scripts\asm\shared\utility::toggle_poiauto(0);
    var3 = 1;
  } else if(isDefined(self.currentpoi)) {
    var5 = self.currentpoi;
    scripts\common\ai::poi_enable(0);
  }

  self glanceatentity(var0, int(var1 * 1000), var2);
  wait var1;

  if(var3) {
    scripts\common\ai::set_gunpose("ready", 1);
    scripts\asm\shared\utility::toggle_poiauto(1, var4.yawmin, var4.yawmax, var4.pitchmin, var4.pitchmax);
    return;
  }

  if(isDefined(var5)) {
    scripts\common\ai::poi_enable(1, var5);
    return;
  }
}

function swap_vehicle_for_scriptable(var0) {
  if(!isDefined(self)) {
    iprintlnbold("Self is null!");
    return;
  }

  if(!isDefined(var0)) {
    iprintlnbold("Scriptable is null!");
    return;
  }

  var0.origin = self.origin;
  var0.angles = self.angles;
  waitframe();
  self delete();
}

function ping_current_objective() {
  if(level.player.focus.objectivesupdatedisplay == 1) {
    return;
  }

  level.player scripts\sp\player::set_focus_objectives_update_display(1);
  level.player scripts\sp\player::set_focus_infinite_hold(1);
  wait 2.5;
  level.player scripts\sp\player::set_focus_objectives_update_display(0);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
}

function butcher_stayahead_chase_speeds() {
  scripts\sp\utility::set_stayahead_values(1, 300, -50, 0.1);
  scripts\sp\utility::set_stayahead_values(2, 250, -150, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 200, -200, 0.1);
  scripts\sp\utility::set_stayahead_values(4, 180, -250, 0.15);
  scripts\sp\utility::enable_stayahead(level.player);
}

function get_closest_living_ai(var0, var1, var2) {
  if(isDefined(var1)) {
    var3 = getaiarray(var1);
  } else {
    var3 = getaiarray();
  }

  var3 = scripts\engine\utility::array_removedead_or_dying(var3);

  if(isDefined(var3)) {
    var3 = scripts\engine\utility::array_remove_array(var3, var3);
  }

  if(var3.size == 0) {
    return undefined;
  }

  return scripts\engine\utility::getclosest(var1, var3);
}

function breath_fx_thread() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEntArray("stp_indoors", "targetname");
  var1 = "slow";
  var2 = scripts\engine\utility::getfx("cold_breath");

  for(;;) {
    if(isDefined(self.animname) && self.animname == "dead_body") {
      return;
    }

    var3 = self.origin;
    wait 0.5;
    var4 = randomintrange(3000, 5000);
    var5 = 0;

    foreach(var7 in var0) {
      if(self istouching(var7)) {
        var5 = 1;
      }
    }

    if(var5 == 1) {
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

    if(gettime() > var4) {
      var9 = length(self.origin - var3);
      var10 = randomintrange(3000, 5000);

      if(var9 > 70) {
        var10 = randomintrange(1000, 2000);
        var2 = scripts\engine\utility::getfx("cold_breath_run");
      } else {
        var2 = scripts\engine\utility::getfx("cold_breath");
      }

      var4 = gettime() + var10;
      playFXOnTag(var2, self, "j_head");
    }
  }
}

function enable_breath_fx(var0) {
  if(isDefined(var0)) {
    var0.no_breath_fx = 0;
    return;
  }

  self.no_breath_fx = 0;
}

function disable_breath_fx(var0) {
  if(isDefined(var0)) {
    var0.no_breath_fx = 1;
    return;
  }

  self.no_breath_fx = 1;
}

function civ_stationary_ff_penalty_think() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_civ_stationary_ff_penalty");
  var0 = 0;
  wait 0.1;

  if(isDefined(self.animname) && self.animname == "dead_body") {
    return;
  }

  jumpiffalse(isDefined(self.script_animname) && self.script_animname == "child") LOC_0000004f;
  return;
}

function debug_display_rule_of_thirds() {
  level.player endon("death");
  precacheshader("c12_hud_verticalscanlines");
  setdvarifuninitialized("debug_rule_of_thirds", "1");
  var0 = "c12_hud_verticalscanlines";
  var1 = [];
  GscBinSkip0(0x2e, 0, create_debug_hud_line(213, 0, 1, 480, var0));
}

function create_debug_hud_line(var0, var1, var2, var3, var4, var5, var6) {
  var7 = newclienthudelem(level.player);
  var7.x = var0;
  var7.y = var1;
  var7.sort = 1;
  var7.horzalign = "fullscreen";
  var7.vertalign = "fullscreen";
  var7.alpha = 1;
  var7 setshader(var4, var2, var3);
  return var7;
}

function background_fakeciv_setup(var0, var1, var2) {
  if(!isDefined(level.background_fakecivs)) {
    level.background_fakecivs = [];
  }

  var3 = scripts\engine\utility::getStructArray(var0, "targetname");
  level.background_fakecivs = scripts\engine\utility::array_removedead(level.background_fakecivs);
  level.background_fakecivs = scripts\engine\utility::array_removeundefined(level.background_fakecivs);
  scripts\engine\utility::array_thread(var3, &background_fakeciv_idle, var2);
  scripts\engine\utility::array_thread(level.background_fakecivs, &background_fakeciv_scatter, var1);
}

function background_fakeciv_idle(var0) {
  var1 = getspawnerarray("background_fakeciv");
  var2 = scripts\engine\utility::random(var1);
  var3 = scripts\engine\sp\utility::fakeactorspawn(var2);
  var3.animname = "generic";
  var3.animnode = self;
  var3.current_state = "idle";
  var3.ignoreme = 1;
  var3 endon("death");
  var3 endon("entitydeleted");
  var4 = randomfloatrange(0, 1.5);
  var3 scripts\engine\utility::delaythread(var4, &background_fakeciv_loop, self);
  level.background_fakecivs[level.background_fakecivs.size] = var3;
  scripts\engine\utility::flag_wait(var0);
  var3 delete();
}

function background_fakeciv_loop(var0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("civ_stop_background_loop");

  for(;;) {
    var1 = randomintrange(1, 5);
    var0 scripts\common\anim::anim_single_solo(self, "background_idle" + var1);
  }
}

function background_fakeciv_scatter(var0) {
  self endon("death");
  self endon("entitydeleted");
  self.animnode.node_claimed = [];
  self.current_node = self.animnode;
  var1 = scripts\engine\utility::getStruct(self.animnode.target, "targetname");
  var2 = 0;

  if(isDefined(self.current_node.script_delay)) {
    var2 = self.current_node.script_delay;
  }

  if(isDefined(self.current_node.script_noteworthy) && self.current_node.script_noteworthy == "flee_on_player_look") {
    for(;;) {
      var3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(35));

      if(var3 == 1) {
        break;
      }

      wait 0.2;
    }

    wait randomfloatrange(0, 1) + var2;
  } else if(isDefined(self.current_node.script_noteworthy) && self.current_node.script_noteworthy == "flee_on_look_or_flag") {
    while(!scripts\engine\utility::flag(var0)) {
      var3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(35));

      if(var3 == 1) {
        break;
      }

      wait 0.2;
    }

    wait randomfloatrange(0, 1) + var2;
  } else {
    scripts\engine\utility::flag_wait(var0);
    wait randomfloatrange(1, 3) + var2;
  }

  self notify("civ_stop_background_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  var4 = vectorNormalize(var1.origin - self.origin);
  var5 = anglesToForward(self.angles);
  var6 = anglestoright(self.angles);
  var7 = vectordot(var4, var5);
  var8 = vectordot(var4, var6);
  var9 = undefined;

  if(var7 > 0.6) {
    if(var8 > 0.6) {
      var9 = "background_exit_front_right";
    } else if(var8 < -0.6) {
      var9 = "background_exit_front_left";
    } else {
      var9 = "background_exit_front";
    }
  } else if(var7 < -0.6) {
    if(var8 > 0.6) {
      var9 = "background_exit_back_right";
    } else if(var8 < -0.6) {
      var9 = "background_exit_back_left";
    } else {
      var9 = "background_exit_back";
    }
  } else if(var8 > 0.6) {
    var9 = "background_exit_right";
  } else if(var8 < -0.6) {
    var9 = "background_exit_left";
  }

  if(isDefined(var9)) {
    self.animname = "generic";
    scripts\common\anim::anim_single_solo_run(self, var9);
  }

  var10 = scripts\sp\fakeactor_node::fakeactor_node_get_path(var1, self.origin, 1, 1);
  self.forced_node_path = var10;
}

function holster_logic() {
  level endon("interrogation_start");
  level.player notifyonplayercommand("actionslot 1", "+actionslot 1");
  GscBinSkip4(0x35);
}

function holster_cleanup_manager() {
  for(;;) {
    level.player waittill("pickup", var0, var1);

    if(isDefined(var1) && scripts\engine\utility::is_equal(var1.classname, "weapon_iw8_holstered")) {
      var1 delete();
    }
  }
}

function holster_inventory_manager() {
  for(;;) {
    var0 = level.player.primaryweapons;
    var1 = level.player.currentweapon;
    waitframe();
    var2 = level.player.primaryweapons;

    foreach(var4 in var2) {
      if(!weapon_empty(var4)) {
        continue;
      }

      var2 = scripts\engine\utility::array_remove(var2, var4);
    }

    if(var2.size <= 2) {
      continue;
    }

    if(scripts\engine\sp\utility::player_has_weapon("iw8_holstered")) {
      continue;
    }

    var6 = undefined;

    foreach(var8 in var2) {
      if(scripts\engine\utility::array_contains(var0, var8)) {
        continue;
      }

      var6 = var8;
      break;
    }

    var10 = scripts\engine\utility::array_remove(var2, var6);
    var11 = scripts\engine\utility::random(var10);
    var12 = level.player.origin + anglesToForward(level.player.angles) * 10;
    spawn("weapon_" + createheadicon(var11), var12 + (0, 0, 3));
    level.player takeweapon(var11);
  }
}

function player_weapon_holstered() {
  return level.player.currentweapon.basename == "iw8_holstered";
}

function set_enemy_low_health() {
  var0 = scripts\common\utility::getdifficulty();

  if(var0 == "easy") {
    self.health = 1;
    return;
  }

  if(var0 == "medium") {
    self.health = int(self.health * 0.1);
    return;
  }

  if(var0 == "hard") {
    self.health = int(self.health * 0.5);
    return;
  }
}

function create_blood_decal() {
  var0 = [];
  GscBinSkip0(0x2e, 0, "j_head");
}

function cointoss_variable(var0) {
  return randomint(100) >= var0;
}

function set_attackeraccuracy_handler(var0, var1, var2, var3) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_attackeraccuracy(var0);

  if(isDefined(var2)) {
    if(isarray(var2)) {
      var4 = level scripts\engine\utility::waittill_any_in_array_return(var2);
    } else {
      scripts\engine\utility::flag_wait(var2);
    }
  }

  if(isDefined(var3)) {
    wait var3;
  }

  scripts\engine\sp\utility::set_attackeraccuracy(var1);
}

function array_rotate(var0) {
  if(!isarray(var0)) {
    return var0;
  }

  var1 = [];
  var2 = undefined;

  foreach(var4 in var0) {
    if(var5 == 0) {
      var2 = var4;
      continue;
    }

    var1 = var4;
  }

  var1 = var2;
  return var1;
}