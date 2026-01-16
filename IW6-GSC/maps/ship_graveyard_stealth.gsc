/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_stealth.gsc
*******************************************/

stealth_init() {
  common_scripts\utility::flag_init("stealth_spawn");
  common_scripts\utility::flag_init("_stealth_spotted");
  common_scripts\utility::flag_init("_stealth_spotted_punishment");
  common_scripts\utility::flag_init("_stealth_enabled");
  level.stealth_ally_accu = 5;
  level.global_callbacks["_autosave_stealthcheck"] = ::_autosave_stealthcheck;
  level.underwater_visible_dist["hidden"] = 600;
  level.underwater_visible_dist["spotted"] = 2000;
  level.underwater_visible_dist["trigger"] = undefined;
  common_scripts\utility::flag_set("stealth_spawn");
  common_scripts\utility::array_thread(getEntArray("sight_adjust_trigger", "targetname"), ::sight_trigger_think);
  thread stealth_logic_loop();
}

stealth_disable() {
  common_scripts\utility::flag_clear("stealth_spawn");
  common_scripts\utility::flag_set("_stealth_spotted");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(var_2 maps\_utility::ent_flag_exist("_stealth_spotted"))
      var_2 maps\_utility::ent_flag_set("_stealth_spotted");
  }

  common_scripts\utility::waitframe();
  level notify("disable_stealth");
  common_scripts\utility::flag_set("_stealth_spotted");
  common_scripts\utility::flag_clear("_stealth_enabled");
}

ai_stealth_init() {
  if(!isai(self)) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  self.baseaccuracy = 0.85;
  maps\_utility::set_battlechatter(0);

  if(!common_scripts\utility::flag("stealth_spawn")) {
    self.moveplaybackrate = 1.25;
    self.movetransitionrate = self.moveplaybackrate;
    return;
  }

  self clearenemy();

  switch (self.team) {
    case "axis":
      thread enemy_stealth();
      break;
    case "allies":
      thread friendly_stealth();
      break;
  }
}

stealth_logic_loop() {
  level endon("disable_stealth");

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_spotted");

    for(;;) {
      if(enemies_alerted() || common_scripts\utility::flag("_stealth_spotted_punishment")) {
        wait 0.2;
        continue;
      }

      break;
    }

    wait 0.5;
    common_scripts\utility::flag_waitopen("_stealth_spotted_punishment");
    common_scripts\utility::flag_clear("_stealth_spotted");
  }
}

enemies_alerted() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(var_2 maps\_utility::ent_flag_exist("_stealth_spotted") && var_2 maps\_utility::ent_flag("_stealth_spotted"))
      return 1;
  }

  return 0;
}

enemy_stealth() {
  level endon("disable_stealth");
  self endon("death");
  self endon("disable_stealth");

  if(isDefined(self.script_stealthgroup))
    self.script_stealthgroup = 0;

  childthread ai_alert_loop();
  maps\_utility::ent_flag_init("_stealth_spotted");
  self.dontattackme = 1;
  self.combatmode = "no_cover";
  self.diequietly = 1;
  self.fovcosine = 0.5;
  self.fovcosinebusy = 0.1;
  self stopanimscripted();

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    maps\_utility::ent_flag_wait("_stealth_spotted");
    wait(randomfloatrange(1.5, 2.5));
  } else
    maps\_utility::ent_flag_set("_stealth_spotted");

  self notify("stop_path");
  self.dontattackme = undefined;
  self.combatmode = "cover";
  self.fovcosine = 0.01;
  self.diequietly = 0;
  self.goalradius = 800;
  self.goalheight = 256;
  self.moveplaybackrate = 1.25;
  self.movetransitionrate = self.moveplaybackrate;
  self notify("stealth_change_values");
  var_0 = self findbestcovernode();

  if(isDefined(var_0)) {
    self.goalradius = 32;
    self.goalheight = 96;
    self setgoalnode(var_0);
    self waittill("goal");
    self.goalradius = 800;
  }
}

ai_alert_loop() {
  self endon("_stealth_spotted");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self clearenemy();
  var_0 = common_scripts\utility::waittill_any_return("ai_event", "damage", "corpse", "enemy");
  wait 1;
  thread alert_team();
}

alert_team() {
  maps\_utility::ent_flag_set("_stealth_spotted");
  common_scripts\utility::flag_set("_stealth_spotted");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2) && var_2.script_stealthgroup == self.script_stealthgroup && !var_2 maps\_utility::ent_flag("_stealth_spotted")) {
      var_2 maps\_utility::ent_flag_set("_stealth_spotted");

      if(common_scripts\utility::cointoss())
        wait(randomfloatrange(0.1, 0.3));
    }
  }
}

friendly_stealth() {
  level endon("disable_stealth");
  self endon("death");

  for(;;) {
    maps\_utility::set_battlechatter(0);
    self.ignoreme = 1;
    self.alertlevel = "noncombat";
    self.moveplaybackrate = 1;
    self.movetransitionrate = self.moveplaybackrate;
    common_scripts\utility::flag_wait("_stealth_spotted");
    self.baseaccuracy = level.stealth_ally_accu;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.moveplaybackrate = 1.25;
    self.movetransitionrate = self.moveplaybackrate;
    common_scripts\utility::flag_waitopen("_stealth_spotted");
  }
}

player_stealth() {
  level endon("disable_stealth");
  self endon("death");
  common_scripts\utility::flag_set("_stealth_enabled");
  childthread player_flashlight_toggle();

  for(;;) {
    self.maxvisibledist = level.underwater_visible_dist["hidden"];
    common_scripts\utility::flag_wait("_stealth_spotted");
    self.maxvisibledist = level.underwater_visible_dist["spotted"];
    common_scripts\utility::flag_waitopen("_stealth_spotted");
  }
}

player_flashlight_toggle() {
  while(!maps\_utility::ent_flag_exist("flashlight_on"))
    wait 0.05;

  for(;;) {
    maps\_utility::ent_flag_wait("flashlight_on");
    self.maxvisibledist = level.underwater_visible_dist["spotted"];
    maps\_utility::ent_flag_waitopen("flashlight_on");

    if(common_scripts\utility::flag("_stealth_spotted")) {
      self.maxvisibledist = level.underwater_visible_dist["spotted"];
      continue;
    }

    if(isDefined(level.underwater_visible_dist["trigger"])) {
      self.maxvisibledist = level.underwater_visible_dist["trigger"];
      continue;
    }

    self.maxvisibledist = level.underwater_visible_dist["hidden"];
  }
}

sight_trigger_think() {
  level endon("disable_stealth");
  self endon("death ");

  while(!level.player maps\_utility::ent_flag_exist("flashlight_on"))
    wait 0.05;

  for(;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("_stealth_spotted") || level.player maps\_utility::ent_flag("flashlight_on")) {
      continue;
    }
    level.player.maxvisibledist = self.script_faceenemydist;
    level.underwater_visible_dist["trigger"] = self.script_faceenemydist;

    while(level.player istouching(self) && !common_scripts\utility::flag("_stealth_spotted") && !level.player maps\_utility::ent_flag("flashlight_on"))
      wait 0.05;

    if(common_scripts\utility::flag("_stealth_spotted") || level.player maps\_utility::ent_flag("flashlight_on"))
      level.player.maxvisibledist = level.underwater_visible_dist["spotted"];
    else
      level.player.maxvisibledist = level.underwater_visible_dist["hidden"];

    if(isDefined(level.underwater_visible_dist["trigger"]) && level.underwater_visible_dist["trigger"] == self.script_faceenemydist)
      level.underwater_visible_dist["trigger"] = undefined;
  }
}

_autosave_stealthcheck() {
  if(common_scripts\utility::flag("_stealth_spotted") && common_scripts\utility::flag("stealth_spawn"))
    return 0;

  if(common_scripts\utility::flag("shark_eating_player"))
    return 0;

  var_0 = getEntArray("destructible", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.healthdrain))
      return 0;
  }

  return 1;
}

stealth_idle(var_0, var_1) {
  self endon("death");
  self endon("damage");
  self endon("_stealth_spotted");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  var_2["weld"] = "torch";
  var_2["bangstick"] = "bangstick";
  var_3 = isDefined(var_2[var_1]);
  self.animname = "generic";
  var_4 = var_0 common_scripts\utility::spawn_tag_origin();
  var_4 maps\_anim::anim_reach_and_approach_solo(self, var_1, undefined, "Exposed 3D");
  var_4 delete();
  var_5 = [self];

  if(var_3) {
    var_6 = var_2[var_1];
    self.prop = maps\_utility::spawn_anim_model(var_6, self.origin);

    if(isDefined(level.scr_anim[var_6]) && isDefined(level.scr_anim[var_6][var_1 + "_idle"]))
      var_5 = common_scripts\utility::array_add(var_5, self.prop);
    else
      self.prop linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  }

  thread stealth_idle_ender(var_0, var_1, self.prop);
  self.allowdeath = 1;
  self.allowpain = 1;
  self.anim_blend_time_override = 1;

  foreach(var_8 in var_5)
  var_0 thread maps\_anim::anim_loop_solo(var_8, var_1 + "_idle");
}

stealth_idle_ender(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::waittill_any_return("_stealth_stop_idle", "_stealth_spotted", "death", "damage");

  if(isDefined(var_2))
    thread prop_drop(var_2);

  var_0 notify("stop_loop");
  self stopanimscripted();
  var_2 stopanimscripted();
}

prop_drop(var_0) {
  var_0 unlink();
  var_1 = 1;
  var_0 moveto(var_0.origin - (0, 0, 1000), 60, 0, 60);

  if(var_0.animname == "bangstick")
    var_0 thread bang_stick_rotate();
  else if(var_0.animname == "torch") {
    var_0 thread torch_rotate();

    if(var_0.welding)
      thread maps\ship_graveyard_anim::weld_fx_off(var_0);
  }

  while(var_1) {
    var_1 = bullettracepassed(var_0.origin, var_0.origin - (0, 0, 10), 1, self);
    wait 0.05;
  }

  var_0 notify("stopped_dropping");
  var_0 moveto(var_0.origin - (0, 0, 1), 1, 0, 1);
  wait 100;

  while(level.player maps\_utility::can_see_origin(var_0.origin))
    wait 1;

  var_0 delete();
}

bang_stick_rotate() {
  self waittill("stopped_dropping");
  var_0 = 7;
  var_1 = 7;

  if(self.animname == "bangstick") {
    self moveto((342, -63295, -53), var_1, var_1 / 2, var_1 / 2);
    self rotateto((354.461, 26.61, 160.045), var_0, var_0 - 0.1, 0.1);
  }
}

torch_rotate() {
  var_0 = 10;
  self rotateby((randomintrange(1, 180), randomintrange(1, 180), randomintrange(1, 180)), var_0, 0, var_0);
  self waittill("stopped_dropping");
  self rotateto(self.angles, 0.1);
}

stealth_melee() {
  self.melee_trigger = spawn("trigger_radius", self.origin - (0, 0, 32), 0, 96, 64);
  self.melee_trigger enablelinkto();
  self.melee_trigger linkto(self);
  thread common_scripts\utility::delete_on_death(self.melee_trigger);
  self.melee_trigger endon("death");

  for(;;) {
    self.melee_trigger waittill("trigger");
    self notify("player_too_far");

    if(maps\ship_graveyard_util::player_is_behind_me(-0.6) && maps\_utility::player_looking_at(self.origin, 0.9, 1)) {
      thread waittill_player_out_of_trigger();
      thread waittill_player_not_behind_me();
      thread waittill_player_not_lookat_me();
      thread waittill_my_death();
      player_wait_for_melee_command();
      level.player allowmelee(1);
    }

    wait 0.05;
  }
}

player_wait_for_melee_command() {
  self endon("player_too_far");
  self endon("death");
  level.player waittill("melee_button_pressed");

  if(maps\ship_graveyard_util::player_is_behind_me(-0.6) && maps\_utility::player_looking_at(self.origin, 0.9, 1)) {
    self.ignoreall = 1;
    self notify("started_player_melee");
    self notify("disable_stealth");
    self unlink();
    self notify("stop_loop");

    if(isDefined(self.anim_node))
      self.anim_node notify("stop_loop");

    var_0 = spawnStruct();
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_1 = level.player.origin;
    var_2 = anglesToForward(level.player.angles);
    var_3 = anglestoright(level.player.angles);
    var_4 = (0, 0, 48);
    var_5 = maps\_player_rig::get_player_rig();
    var_5.origin = level.player.origin - var_4;
    var_5.angles = level.player.angles;
    var_5 hide();
    var_5 attach("viewmodel_knife", "TAG_WEAPON_RIGHT", 0);
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.origin = var_5.origin;
    var_6.angles = var_5.angles;
    var_6 linkto(var_5, "tag_player", var_4, (0, 0, 0));
    thread melee_death_fx();
    var_0 thread maps\_anim::anim_generic(self, "stealth_kill");
    level.player disableweapons();
    var_7 = 0.3;
    level.player playerlinktoblend(var_6, "tag_origin", var_7, var_7, 0);
    var_5 common_scripts\utility::delaycall(var_7, ::show);
    var_0 maps\_anim::anim_single_solo(var_5, "stealth_kill");
    level.player unlink();
    level.player enableweapons();
    level.player allowmelee(1);
    var_5 delete();
    var_6 delete();
    wait 0.3;
    self.health = 1;
    self.allowdeath = 1;
    self kill();
  }

  level.player allowmelee(1);
}

waittill_player_out_of_trigger() {
  self endon("death");
  self endon("player_too_far");
  self endon("started_player_melee");

  while(level.player istouching(self.melee_trigger)) {
    level.player allowmelee(0);
    wait 0.05;
  }

  self notify("player_too_far");
}

waittill_player_not_behind_me() {
  self endon("death");
  self endon("player_too_far");
  self endon("started_player_melee");

  while(maps\ship_graveyard_util::player_is_behind_me(-0.6)) {
    level.player allowmelee(0);
    wait 0.05;
  }

  self notify("player_too_far");
}

waittill_player_not_lookat_me() {
  self endon("death");
  self endon("player_too_far");
  self endon("started_player_melee");

  while(maps\_utility::player_looking_at(self.origin, 0.9, 1)) {
    level.player allowmelee(0);
    wait 0.05;
  }

  self notify("player_too_far");
}

waittill_my_death() {
  self endon("player_too_far");
  self endon("started_player_melee");
  self waittill("death");
  level.player allowmelee(1);
}

melee_death_fx() {
  wait 1.4;
  playFXOnTag(common_scripts\utility::getfx("shpg_enm_death_bubbles_a"), self, "tag_eye");
  thread maps\_utility::play_sound_on_entity("generic_death_enemy_3");
}