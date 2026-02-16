/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_util.gsc
*****************************************************/

player_move_to_checkpoint_start(var_0) {
  var_1 = getent(var_0, "targetname");
  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

allies_move_to_checkpoint_start(var_0, var_1) {
  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = var_0 + "_ally_" + var_2;
    var_4 = common_scripts\utility::getstruct(var_3, "targetname");
    level.allies[var_2] forceteleport(var_4.origin, var_4.angles);

    if(isDefined(var_1)) {
      level.allies[var_2] maps\_utility::clear_force_color();
      level.allies[var_2] setgoalpos(var_4.origin);
    }
  }
}

spawn_allies() {
  level.allies = [];
  level.allies[level.allies.size] = spawn_ally("ally_0");
  level.allies[level.allies.size] = spawn_ally("ally_1");
  level.allies[level.allies.size] = spawn_ally("ally_2");
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = spawn_targetname_at_struct_targetname(var_0, var_2);

  if(!isDefined(var_3))
    return undefined;

  var_3 maps\_utility::make_hero();

  if(!isDefined(var_3.magic_bullet_shield)) {
    var_3 maps\_utility::magic_bullet_shield();
    var_3.animname = var_0;
  }

  return var_3;
}

spawn_targetname_at_struct_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2.origin = var_3.origin;

    if(isDefined(var_3.angles))
      var_2.angles = var_3.angles;

    var_4 = var_2 maps\_utility::spawn_ai();
    return var_4;
  }

  if(isDefined(var_2)) {
    var_4 = var_2 maps\_utility::spawn_ai();
    iprintlnbold("Add a script struct called: " + var_1 + " to spawn him in the correct location.");
    var_4 teleport(level.player.origin, level.player.angles);
    return var_4;
  }

  iprintlnbold("failed to spawn " + var_0 + " at " + var_1);
  return undefined;
}

kill_allies() {
  foreach(var_1 in level.allies) {
    var_1 maps\_utility::stop_magic_bullet_shield();
    var_1.diequietly = 1;
    var_1 kill();
  }
}

reassign_goal_volume(var_0, var_1) {
  if(!isarray(var_0))
    var_0 = maps\_utility::make_array(var_0);

  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  var_2 = getent(var_1, "targetname");

  foreach(var_4 in var_0)
  var_4 setgoalvolumeauto(var_2);
}

spawn_group_staggered(var_0, var_1) {
  spawn_group(var_0, var_1, 1);
}

spawn_group(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_0 = common_scripts\utility::array_randomize(var_0);
  var_4 = [];

  foreach(var_8, var_6 in var_0) {
    var_7 = var_6 maps\_utility::spawn_ai();
    var_4[var_4.size] = var_7;

    if(var_2) {
      if(var_8 != var_0.size - 1)
        wait(randomfloatrange(0.25, 1));
    }
  }

  if(var_1) {}

  return var_4;
}

friendly_adjust_movement_speed() {
  self notify("stop_adjust_movement_speed");
  self endon("death");
  self endon("stop_adjust_movement_speed");

  while(isalive(self)) {
    wait(randomfloatrange(0.5, 1.5));

    while(friendly_should_speed_up()) {
      iprintlnbold("friendlies speeding up");
      self.moveplaybackrate = 3.5;
      wait 0.05;
    }

    self.moveplaybackrate = 1.0;
  }
}

friendly_should_speed_up() {
  self endon("death");

  if(!isDefined(self.goalpos))
    return 0;

  if(distancesquared(self.origin, self.goalpos) <= level.goodfriendlydistancefromplayersquared)
    return 0;

  if(common_scripts\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, level.cosine["90"]))
    return 0;

  return 1;
}

waittill_aigroupcount_or_trigger_targetname(var_0, var_1, var_2) {
  var_3 = getent(var_2, "targetname");
  var_3 endon("trigger");
  level endon("aigroup_count_triggered");
  maps\_utility::waittill_aigroupcount(var_0, var_1);
  level notify("aigroup_count_triggered");
}

hide_scriptmodel_by_targetname(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 hide();
  var_1 notsolid();

  if(var_1.classname == "script_brushmodel")
    var_1 connectpaths();
}

hide_scriptmodel_by_targetname_array(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3 hide();
    var_3 notsolid();

    if(var_3.classname == "script_brushmodel")
      var_3 connectpaths();
  }
}

hide_models_by_targetname(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_4 hide();
    var_4 notsolid();

    if(isDefined(var_1) && var_1) {
      if(var_4.classname == "script_brushmodel")
        var_4 connectpaths();
    }
  }
}

show_models_by_targetname(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_4 show();
    var_4 solid();

    if(isDefined(var_1) && var_1) {
      if(var_4.classname == "script_brushmodel")
        var_4 disconnectpaths();
    }
  }
}

submerging_bubble_effects() {
  for(var_0 = 0; var_0 < 4; var_0++) {
    playFX(common_scripts\utility::getfx("flooded_player_bubbles"), level.player_view_water_fx_source.origin);
    wait 0.1;
  }
}

setup_default_weapons(var_0) {
  if(!isDefined(var_0)) {
    level.player giveweapon("r5rgp+reflex_sp");
    level.player giveweapon("m9a1");
    level.player switchtoweapon("r5rgp");
  }

  level.player giveweapon("fraggrenade");
  level.player giveweapon("flash_grenade");
  level.player setoffhandsecondaryclass("flash");
}

update_goal_vol_from_trigger(var_0, var_1) {
  self endon("death");
  self endon("stop_goal_volume_updates");
  var_2 = getent(var_0, "targetname");

  if(!isDefined(var_2)) {
    var_2 = getent(var_0, "script_noteworthy");

    if(!isDefined(var_2)) {}
  }

  self endon("death");
  var_2 endon("death");

  while(isalive(self)) {
    var_2 waittill("trigger");
    reassign_goal_volume(self, var_1);

    while(level.player istouching(var_2))
      wait 1.0;
  }
}

cleanup_triggers(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 delete();
}

notify_on_aigroup_count(var_0, var_1, var_2) {
  maps\_utility::waittill_aigroupcount(var_0, var_1);
  self notify(var_2);
}

notify_on_enemy_count(var_0, var_1, var_2) {
  for(;;) {
    var_3 = 0;
    var_4 = getaiarray("axis");

    foreach(var_6 in var_4) {
      if(isalive(var_6))
        var_3++;
    }

    if(var_0 >= var_3) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(var_1))
    self notify(var_1);

  if(isDefined(var_2))
    common_scripts\utility::flag_set(var_2);
}

waittill_aigroup_count_or_timeout(var_0, var_1, var_2) {
  thread notify_on_aigroup_count(var_0, var_1, "count_reached");
  common_scripts\utility::waittill_notify_or_timeout("count_reached", var_2);
}

waittill_aigroup_count_or_trigger(var_0, var_1, var_2) {
  var_3 = getent(var_2, "targetname");

  if(!isDefined(var_3)) {
    var_3 = getent(var_2, "script_noteworthy");

    if(!isDefined(var_3)) {}
  }

  var_3 thread notify_on_aigroup_count(var_0, var_1, "count_reached");
  var_3 common_scripts\utility::waittill_any("trigger", "count_reached");
}

waittill_enemy_count_or_trigger(var_0, var_1) {
  var_2 = getent(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = getent(var_1, "script_noteworthy");

    if(!isDefined(var_2)) {}
  }

  var_2 thread notify_on_enemy_count(var_0, "count_reached");
  var_2 common_scripts\utility::waittill_any("trigger", "count_reached");
}

waittill_enemy_count_or_flag(var_0, var_1) {
  level endon("count_reached");

  if(!common_scripts\utility::flag(var_1)) {
    level thread notify_on_enemy_count(var_0, "count_reached");
    common_scripts\utility::flag_wait(var_1);
  }
}

add_actor_danger_listeners() {
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("grenade danger");
  self addaieventlistener("explode");
  self addaieventlistener("gunshot_teammate");
}

waittill_danger() {
  add_actor_danger_listeners();
  self waittill("ai_event");
}

waittill_danger_or_trigger(var_0) {
  add_actor_danger_listeners();
  self endon("ai_event");
  maps\_utility::wait_for_targetname_trigger(var_0);
  return 1;
}

apply_deathtime(var_0) {
  self endon("death");
  wait(var_0);
  wait(randomfloat(10));
  self kill();
}

wait_incremental_nag_timer(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = [];

    if(isDefined(var_1))
      var_0[var_0.size] = 0.0;
    else
      var_0[var_0.size] = 5.0;

    var_0[var_0.size] = 5.0;
    var_0[var_0.size] = 10.0;
    var_0[var_0.size] = 15.0;
    var_0[var_0.size] = 20.0;
    var_0[var_0.size] = 25.0;
  }

  wait(var_0[0]);

  if(1 < var_0.size)
    return maps\_utility::array_remove_index(var_0, 0);
  else
    return var_0;
}

kill_all_enemies() {
  var_0 = getaiarray("axis");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isalive(var_2))
        var_2 kill();
    }
  }
}

get_enemies_touching_volume(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "script_noteworthy");

    if(!isDefined(var_1)) {}
  }

  var_2 = getaiarray("axis");
  var_2 = maps\_utility::array_removedead_or_dying(var_2);
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 istouching(var_1))
      var_3 = common_scripts\utility::array_add(var_3, var_5);
  }

  return var_3;
}

get_enemy_count_touching_volume(var_0) {
  return get_enemies_touching_volume(var_0).size;
}

notify_on_enemy_count_touching_volume(var_0, var_1, var_2) {
  self endon("stop_checking_volume");

  for(;;) {
    if(var_1 >= get_enemies_touching_volume(var_0).size) {
      break;
    }

    wait 0.05;
  }

  self notify(var_2);
}

stop_enemy_dialogue() {
  self waittill("death");
  maps\_utility::anim_stopanimscripted();
}

stop_enemy_dialogue_on_death_or_trigger(var_0) {
  self endon("death");
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "script_noteworthy");

    if(!isDefined(var_1)) {}
  }

  thread stop_enemy_dialogue();
  var_1 waittill("trigger");
  maps\_utility::anim_stopanimscripted();
}

smart_get_nag_line(var_0, var_1, var_2) {
  if(1 < var_0.size)
    var_3 = common_scripts\utility::array_remove(var_0, var_0[var_2]);
  else
    var_3 = var_1;

  return var_3;
}

nag_end_on_notify(var_0, var_1, var_2) {
  self endon(var_1);
  var_3 = [];

  if(!isarray(var_0))
    var_0 = maps\_utility::make_array(var_0);

  var_4 = var_0.size;
  var_5 = 0;
  var_6 = 0;
  var_7 = wait_incremental_nag_timer(undefined, var_2);

  for(;;) {
    var_3 = smart_get_nag_line(var_3, var_0, var_6);

    if(var_5 < var_4)
      var_6 = 0;
    else
      var_6 = randomintrange(0, var_3.size);

    maps\_utility::smart_dialogue(var_3[var_6]);
    var_5++;
    var_7 = wait_incremental_nag_timer(var_7);
  }
}

nag_multiple_end_on_notify(var_0, var_1, var_2) {
  self endon(var_2);

  if(!isarray(var_0))
    var_0 = maps\_utility::make_array(var_0);

  if(!isarray(var_1))
    var_1 = maps\_utility::make_array(var_1);

  var_3 = wait_incremental_nag_timer();

  for(;;) {
    var_4 = randomint(var_1.size);
    var_0[var_4] maps\_utility::smart_dialogue(var_1[var_4]);
    var_3 = wait_incremental_nag_timer(var_3);
  }
}

notify_on_flag_set(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  self notify(var_1);
}

notify_on_flag_open(var_0, var_1) {
  common_scripts\utility::flag_waitopen(var_0);
  self notify(var_1);
}

notify_on_function_finish(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    self[[var_1]]();
  else if(!isDefined(var_3))
    self[[var_1]](var_2);
  else if(!isDefined(var_4))
    self[[var_1]](var_2, var_3);
  else
    self[[var_1]](var_2, var_3, var_4);

  self notify(var_0);
}

setup_bokehdot_volume(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 thread do_bokehdot_volume();
}

do_bokehdot_volume() {
  level endon("swept_away");
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = distance2d(var_1.origin, var_0.origin);
  maps\flood_fx::fx_create_bokehdots_source();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "splash") {
    var_3 = 0.5;

    for(;;) {
      common_scripts\utility::flag_wait("do_bokehdot");

      if(!common_scripts\utility::flag("cw_player_underwater") && level.player istouching(self)) {}

      while(common_scripts\utility::flag("do_bokehdot") && level.player istouching(self)) {
        if(distance2d(level.player.origin, var_0) < var_3 * var_2)
          thread maps\flood_fx::fx_turn_on_bokehdots_64_player();
        else
          thread maps\flood_fx::fx_turn_on_bokehdots_16_player();

        wait(randomfloatrange(1.5, 2.5));
      }

      common_scripts\utility::waitframe();
    }
  } else {
    var_3 = 0.33;

    for(;;) {
      common_scripts\utility::flag_wait("do_bokehdot");

      if(!common_scripts\utility::flag("cw_player_underwater") && level.player istouching(self)) {}

      if(!isDefined(self.waterdrops_once) && level.player istouching(self)) {
        self.waterdrops_once = 1;
        thread maps\flood_fx::fx_waterdrops_20_inst();
      }

      while(common_scripts\utility::flag("do_bokehdot") && level.player istouching(self)) {
        if(distance2d(level.player.origin, var_0.origin) < var_3 * var_2) {
          thread maps\flood_fx::fx_bokehdots_close();
          wait(randomfloatrange(0.25, 0.5));
        } else if(distance2d(level.player.origin, var_0.origin) < var_3 * 2 * var_2) {
          thread maps\flood_fx::fx_bokehdots_close();
          wait(randomfloatrange(0.25, 0.5));
        } else {
          thread maps\flood_fx::fx_bokehdots_far();
          wait(randomfloatrange(0.5, 1));
        }

        common_scripts\utility::waitframe();
      }

      self.waterdrops_once = undefined;
      common_scripts\utility::waitframe();
    }
  }
}

earthquake_w_fade(var_0, var_1, var_2, var_3) {
  self notify("earthquake_end");
  self endon("earthquake_end");

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = var_1 * 10;
  var_5 = var_2 * 10;

  if(var_5 > 0)
    var_6 = var_0 / var_5;
  else
    var_6 = var_0;

  var_7 = var_3 * 10;
  var_8 = var_4 - var_7;

  if(var_7 > 0)
    var_9 = var_0 / var_7;
  else
    var_9 = var_0;

  var_10 = 0.1;
  var_0 = 0;

  for(var_11 = 0; var_11 < var_4; var_11++) {
    if(var_11 <= var_5)
      var_0 = var_0 + var_6;

    if(var_11 > var_8)
      var_0 = var_0 - var_9;

    earthquake(var_0, var_10, self.origin, 500);
    wait(var_10);
  }
}

notify_on_actor_distance_to_goal(var_0, var_1, var_2) {
  self endon("death");

  for(;;) {
    if(var_1 > distance2d(var_0, self.origin)) {
      self notify(var_2);
      break;
    }

    wait 0.05;
  }
}

play_nag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop nags");

  if(isDefined(var_6))
    self endon(var_6);

  var_8 = var_2;

  if(!isDefined(var_3))
    var_3 = 30;

  var_9 = 0;
  var_10 = 1;
  var_11 = 0;

  while(!common_scripts\utility::flag(var_1)) {
    var_9 = randomint(var_0.size);

    if(var_0.size > 1) {
      while(var_10 == var_9) {
        var_9 = randomint(var_0.size);
        wait 0.05;
      }
    }

    var_10 = var_9;
    var_12 = var_0[var_9];

    if(isDefined(var_7)) {
      var_13 = var_7[randomint(var_7.size)];
      thread maps\_anim::anim_single_solo(self, var_13);
    }

    if(!common_scripts\utility::flag(var_1)) {
      level notify("nagging");
      maps\_utility::smart_dialogue(var_12);
    } else
      break;

    wait(randomfloatrange(var_8 * 0.8, var_8 * 1.2));

    if(var_3 > var_8) {
      var_11 = var_11 + 1;

      if(var_11 == var_4) {
        var_11 = 0;
        var_8 = var_8 * var_5;

        if(var_3 < var_8)
          var_8 = var_3;
      }
    }
  }
}

push_player(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self pushplayer(var_0);
}

flag_set_delayed(var_0, var_1) {
  maps\_utility::delaythread(var_1, common_scripts\utility::flag_set, var_0, undefined);
}

block_until_at_struct(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    if(var_1 == 666)
      self.goalradius = 88;
    else
      self.goalradius = var_1;
  }

  self setgoalpos(var_0.origin);
  self.flood_current_goalnode = var_0.targetname;
  self waittill("goal");
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  return var_0;
}

bullet_trace_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = "white";

  if(!isDefined(var_4))
    var_4 = 1000;

  switch (var_3) {
    case "white":
      var_3 = (255, 255, 255);
      break;
    case "red":
      var_3 = (255, 0, 0);
      break;
    case "green":
      var_3 = (0, 255, 0);
      break;
    case "blue":
      var_3 = (0, 0, 255);
      break;
    default:
      break;
  }

  if(var_5) {}

  var_6 = bulletTrace(var_0, var_1, var_2);
  return var_6;
}

spawn_and_link_models_to_tags(var_0, var_1) {
  var_2 = getnumparts(self.model);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = getpartname(self.model, var_3);

    if(getsubstr(var_4, 0, 4) == "mdl_") {
      var_5 = getsubstr(var_4, 4, var_4.size - 4);
      var_6 = spawn("script_model", self gettagorigin(var_4));

      if(var_5 == "pb_weaponscase")
        var_6 setModel("com_plasticcase_beige_big_iw6");
      else
        var_6 setModel(var_5);

      var_6.angles = self gettagangles(var_4);
      var_6 linkto(self, var_4);

      if(isDefined(var_0))
        var_6.targetname = var_0;

      if(isDefined(var_1))
        var_6 retargetscriptmodellighting(var_1);
    }

    common_scripts\utility::waitframe();
  }
}

setup_water_death() {
  var_0 = getEntArray("trigger_water_death", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread grenade_kill();
    var_2 thread fell_in_water_fail();
  }
}

fell_in_water_fail(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    self waittill("trigger");

    if(level.player maps\_utility::ent_flag("player_in_swept")) {
      level.player maps\_utility::ent_flag_waitopen("player_in_swept");
      self waittill("trigger");
    }
  }

  level.player enableinvulnerability();
  maps\flood_fx::water_death_fx();
  level.player enableslowaim();
  level.player disableweapons();
  level.player hideviewmodel();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level.player shellshock("dog_bite", 0.75);
  level.player playrumbleonentity("damage_heavy");
  level.player stunplayer(1.0);
  level.player playSound("scn_flood_swept_away_splash_ss");
  var_1 = level.player common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_1.origin + (0, 0, -128);

  if(!isDefined(var_0)) {
    var_2 = maps\_utility::spawn_anim_model("player_rig", level.player.origin + (0, 0, -128));
    var_2.angles = level.player.angles;
    var_2 linkto(var_1);
    var_3["player_rig"] = var_2;
    var_4 = 15;
    level.player playerlinktodelta(var_2, "tag_player", 0, var_4, var_4, var_4, var_4);
    var_2 thread maps\_anim::anim_single(var_3, "flood_sweptaway");
  }

  if(!isDefined(self.script_noteworthy))
    self.script_noteworthy = "no_movement";

  switch (self.script_noteworthy) {
    case "no_movement":
      break;
    case "gap_jump":
      var_1 movey(-3000, 5, 1);
      break;
    case "debris_bridge":
      var_1 movey(-100, 10, 1);
      break;
    case "ending":
      var_1 movey(-500, 5, 1);
      break;
  }

  var_1 rotateto((0, 270, 0), 3);

  if(!common_scripts\utility::flag("missionfailed"))
    setDvar("ui_deadquote", "");

  level thread maps\_utility::missionfailedwrapper();
}

grenade_kill() {
  for(;;) {
    var_0 = getEntArray("grenade", "classname");

    foreach(var_2 in var_0) {
      if(var_2 istouching(self)) {
        jkuprint("grenade killed");
        var_2 delete();
        break;
      }
    }

    common_scripts\utility::waitframe();
  }
}

synctransients_safe(var_0) {
  if(!istransientqueued(var_0)) {
    unloadalltransients();
    loadtransient(var_0);

    while(!synctransients())
      wait 0.05;
  }
}

setup_palm_trees_in_rushing_water() {
  common_scripts\utility::waitframe();
  var_0 = getEntArray("palm_tree_in_rushing_water", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = 1 + randomfloat(0.4);
    var_2 setanimknobrestart(level.anim_prop_models[var_2.model]["flood"], 1, 0, var_3);
  }
}

player_water_movement(var_0, var_1) {
  maps\_utility::player_speed_percent(var_0, var_1);
  maps\_utility::player_bob_scale_set(1.0 / (var_0 * 0.01), var_1);
}

play_fullscreen_splash_cinematic(var_0) {
  level.player thread play_splash_on_activate();

  for(;;) {
    common_scripts\utility::flag_wait("pip_flag");
    var_1 = newhudelem();
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1.sort = -1;
    var_1 setshader("cinematic", 512, 512);
    var_1.alpha = 0.0;
    cinematicingame(var_0);

    while(iscinematicplaying())
      wait 0.05;

    var_1 destroy();
    common_scripts\utility::flag_clear("pip_flag");
  }
}

play_splash_on_activate() {
  for(;;) {
    while(!self useButtonPressed())
      wait 0.05;

    common_scripts\utility::flag_set("pip_flag");
    common_scripts\utility::flag_waitopen("pip_flag");
  }
}

jkuline(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.jkudebug) && level.jkudebug) {
    if(!isDefined(var_2)) {
      return;
    }
    if(!isDefined(var_3)) {
      return;
    }
    if(!isDefined(var_4)) {
      return;
    }
    if(!isDefined(var_5)) {
      return;
    }
    return;
    return;
    return;
    return;
  }
}

jkupoint(var_0, var_1, var_2, var_3) {
  if(isDefined(level.jkudebug) && level.jkudebug) {
    if(!isDefined(var_1))
      var_1 = 6;

    if(!isDefined(var_2))
      var_2 = (1, 1, 1);

    if(!isDefined(var_3))
      var_3 = 9999;
  }
}

jkuprint(var_0) {
  if(isDefined(level.jkudebug) && level.jkudebug)
    iprintln(var_0);
}

set_water_fog(var_0) {
  var_1 = maps\_utility::get_vision_set_fog(var_0);

  if(isDefined(var_1.sunfogenabled) && var_1.sunfogenabled)
    self playersetwaterfog(var_1.startdist, var_1.halfwaydist, var_1.red, var_1.green, var_1.blue, var_1.hdrcolorintensity, var_1.maxopacity, 0, var_1.sunred, var_1.sungreen, var_1.sunblue, var_1.hdrsuncolorintensity, var_1.sundir, var_1.sunbeginfadeangle, var_1.sunendfadeangle, var_1.normalfogscale, var_1.skyfogintensity, var_1.skyfogminangle, var_1.skyfogmaxangle);
  else
    self playersetwaterfog(var_1.startdist, var_1.halfwaydist, var_1.red, var_1.green, var_1.blue, var_1.hdrcolorintensity, var_1.maxopacity, 0, var_1.skyfogintensity, var_1.skyfogminangle, var_1.skyfogmaxangle);
}

type_spawn_trigger() {
  if(!isDefined(self.classname))
    return 0;

  if(self.classname == "trigger_multiple_spawn")
    return 1;

  if(self.classname == "trigger_multiple_spawn_reinforcement")
    return 1;

  if(self.classname == "trigger_multiple_friendly_respawn")
    return 1;

  if(isDefined(self.targetname) && self.targetname == "flood_spawner")
    return 1;

  if(isDefined(self.targetname) && self.targetname == "friendly_respawn_trigger")
    return 1;

  if(isDefined(self.spawnflags) && self.spawnflags & 32)
    return 1;

  return 0;
}

delete_all_triggers() {
  delete_all_by_type(::type_trigger, ::type_spawn_trigger, ::type_flag_trigger, ::type_killspawner_trigger);
  animscripts\battlechatter::update_bcs_locations();
}

delete_all_by_type(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = [var_0, var_1, var_2, var_3, var_4];
  var_6 = common_scripts\utility::array_removeundefined(var_6);
  var_7 = getEntArray();

  foreach(var_9 in var_7) {
    if(!isDefined(var_9.code_classname)) {
      continue;
    }
    var_10 = isDefined(var_9.targetname) && var_9.targetname == "intelligence_item";

    if(var_10) {
      continue;
    }
    foreach(var_12 in var_6) {
      if(var_9[[var_12]]()) {
        if(var_5)
          var_9 notify("delete");

        var_9 delete();
      }
    }
  }
}

type_trigger() {
  if(!isDefined(self.code_classname))
    return 0;

  var_0 = [];
  var_0["trigger_multiple"] = 1;
  var_0["trigger_once"] = 1;
  var_0["trigger_use"] = 1;
  var_0["trigger_radius"] = 1;
  var_0["trigger_lookat"] = 1;
  var_0["trigger_disk"] = 1;
  var_0["trigger_damage"] = 1;
  return isDefined(var_0[self.code_classname]);
}

type_flag_trigger() {
  if(!isDefined(self.classname))
    return 0;

  var_0 = [];
  var_0["trigger_multiple_flag_set"] = 1;
  var_0["trigger_multiple_flag_set_touching"] = 1;
  var_0["trigger_multiple_flag_clear"] = 1;
  var_0["trigger_multiple_flag_looking"] = 1;
  var_0["trigger_multiple_flag_lookat"] = 1;
  return isDefined(var_0[self.classname]);
}

type_killspawner_trigger() {
  if(!type_trigger())
    return 0;

  if(isDefined(self.script_killspawner))
    return 1;

  return 0;
}

type_goalvolume() {
  if(!isDefined(self.classname))
    return 0;

  if(self.classname == "info_volume" && isDefined(self.script_goalvolume))
    return 1;

  return 0;
}

type_infovolume() {
  if(!isDefined(self.classname))
    return 0;

  return self.classname == "info_volume";
}

flood_battlechatter_on(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");

  if(var_0)
    maps\_utility::flavorbursts_on("allies");
}

create_world_model_from_ent_weapon(var_0) {
  if(!isDefined(var_0))
    var_0 = self getcurrentweapon();

  var_1 = getweaponmodel(var_0);
  var_2 = getweaponattachments(var_0);
  var_3 = spawn("script_model", (0, 0, -10000));
  var_3 setModel(var_1);
  jkuprint("drop weapon model: " + var_1);
  jkuprint(var_1 + " attachment number: " + var_2.size);

  foreach(var_5 in var_2) {
    var_6 = getsubstr(var_5, 0, 4);

    switch (var_6) {
      case "acog":
        jkuprint(var_1 + ": " + var_5);
        var_3 hidepart("tag_sight_on", var_1);
        var_3 attach("weapon_acog_iw6", "tag_acog_2", 1);
        break;
      case "eote":
        jkuprint(var_1 + ": " + var_5);
        var_3 hidepart("tag_sight_on", var_1);
        var_3 attach("weapon_eotech_iw6", "tag_eotech", 1);
        break;
      case "refl":
        jkuprint(var_1 + ": " + var_5);
        var_3 hidepart("tag_sight_on", var_1);
        var_3 attach("weapon_reflex_reddot", "tag_red_dot", 1);
        break;
      case "sile":
        jkuprint(var_1 + ": " + var_5);
        var_3 attach("weapon_silencer_01", "tag_silencer", 1);
        break;
      default:
        jkuprint("attachment failed: " + var_5);
        break;
    }
  }

  return var_3;
}

create_rumble_ent(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = self.origin + (0, 0, var_0);
  var_3 linkto(self);

  if(isDefined(var_1))
    var_3.script_noteworthy = var_1;

  if(isDefined(var_2))
    var_3 common_scripts\utility::delaycall(var_2, ::delete);

  return var_3;
}

play_rumble_light(var_0) {
  jkuprint("playing play_rumble_light");
  var_0 playrumbleonentity("light_1s");
}

play_rumble_light_3s(var_0) {
  jkuprint("playing play_rumble_light 3s");
  var_0 playrumbleonentity("light_3s");
}

play_rumble_heavy(var_0) {
  jkuprint("playing play_rumble_heavy");
  var_0 playrumbleonentity("heavy_1s");
}

registeractionbinding(var_0, var_1, var_2) {
  if(!isDefined(level.actionbinds))
    level.actionbinds = [];

  if(!isDefined(level.actionbinds[var_0]))
    level.actionbinds[var_0] = [];

  var_3 = spawnStruct();
  var_3.binding = var_1;
  var_3.hint = var_2;
  var_3.keytext = undefined;
  var_3.hinttext = undefined;
  level.actionbinds[var_0][level.actionbinds[var_0].size] = var_3;
}

getactionbind(var_0) {
  for(var_1 = 0; var_1 < level.actionbinds[var_0].size; var_1++) {
    var_2 = level.actionbinds[var_0][var_1];
    var_3 = getkeybinding(var_2.binding);

    if(!var_3["count"]) {
      continue;
    }
    return level.actionbinds[var_0][var_1];
  }

  return level.actionbinds[var_0][0];
}

game_is_pc() {
  if(level.xenon)
    return 0;

  if(level.ps3)
    return 0;

  if(level.ps4)
    return 0;

  if(level.xb3)
    return 0;

  return 1;
}