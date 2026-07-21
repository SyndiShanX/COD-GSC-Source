/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate_util.gsc
***********************************************/

price_line(var_0) {
  level.price.speaking = 1;

  if(soundexists(var_0))
    level.price scripts\engine\sp\utility::smart_dialogue(var_0);
  else {
    var_1 = "^5Price:^7 " + var_0;
    iprintlnbold(var_1);
  }

  level.price.speaking = undefined;
}

hadir_line(var_0) {
  if(soundexists(var_0))
    level.hadir scripts\engine\sp\utility::smart_dialogue(var_0);
  else {
    var_1 = "^3Hadir:^7 " + var_0;
    iprintlnbold(var_1);
  }
}

kyle_line(var_0) {
  if(soundexists(var_0))
    level.player scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else {
    var_1 = "^2Kyle:^7 " + var_0;
    iprintlnbold(var_1);
  }
}

indoor_monitor() {
  scripts\engine\utility::ent_flag_init("indoors");

  for(;;) {
    while(!scripts\engine\sp\utility::is_touching_any(level.interior_volumes))
      waitframe();

    scripts\engine\utility::ent_flag_set("indoors");
    var_0 = self getistouchingentities(level.interior_volumes)[0];

    while(self istouching(var_0))
      waitframe();

    scripts\engine\utility::ent_flag_clear("indoors");
  }
}

post_grounds_cleanup() {
  if(level.start_point == "spawn_test" || level.start_point == "technical_test") {
    return;
  }
  if(scripts\engine\utility::flag("stealth_enabled"))
    scripts\stealth\utility::disable_stealth_system();

  scripts\engine\utility::array_delete(getEntArray("trigger_multiple_zone_spawn", "classname"));
  scripts\engine\utility::array_delete(getEntArray("interrogator_spawn_trigger", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("info_volume_stealth_all", "classname"));
  scripts\engine\utility::array_delete(getEntArray("info_volume_stealth_investigate", "classname"));
  scripts\engine\utility::array_delete(getEntArray("info_volume_stealth_hunt", "classname"));
  scripts\engine\utility::array_delete(getEntArray("info_volume_stealth_clear", "classname"));
  scripts\engine\utility::array_delete(getEntArray("info_volume_stealth_combat", "classname"));
  scripts\engine\utility::array_delete(getEntArray("church_spawn_volume", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("courtyard_spawn_volume", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("mansion_spawn_volume", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("pool_spawn_volume", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("dynolight_area", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("church_escalation_patrol_trig", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("courtyard_escalation_patrol_trig", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("pool_escalation_patrol_trig", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("dead_body", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("waypoint_volume", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("technical_circle_volume", "targetname"));
  scripts\engine\utility::array_delete(getEntArray("extra_patrol_spawn_trigger", "targetname"));

  foreach(var_1 in getspawnerteamarray("axis")) {
    if(isstartstr(var_1.classname, "actor_enemy_alq") && !scripts\engine\utility::is_equal(var_1.targetname, "getup_aq"))
      var_1 delete();
  }

  if(isDefined(level.hvts)) {
    foreach(var_4 in level.hvts) {
      if(isDefined(var_4)) {
        destroynavobstacle(var_4.obstacle_id);
        var_4 delete();
      }
    }
  }

  if(isDefined(level.og_advancetoenemysettings)) {
    scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(level.og_advancetoenemysettings[0], level.og_advancetoenemysettings[1]);
    level.og_advancetoenemysettings = undefined;
  }

  if(scripts\engine\sp\utility::exists_global_spawn_function("axis", scripts\sp\maps\estate\estate_grounds.gsc::grounds_axis_spawnfunc))
    scripts\engine\sp\utility::remove_global_spawn_function("axis", scripts\sp\maps\estate\estate_grounds.gsc::grounds_axis_spawnfunc);

  if(isDefined(level.alias_groups) && level.alias_groups.size) {
    foreach(var_7 in getarraykeys(level.alias_groups))
    clear_alias_group(var_7);
  }

  level.player notify("stop_tracking_dynolights");
  level.player.maxvisibledist = 8192;
  level.player scripts\engine\utility::ent_flag_clear("in_the_dark");
  level.player scripts\sp\player::set_player_max_health(level.player.maxhealth);
  level.player scripts\sp\player::scale_player_death_shield_duration(1);
  stealth_combat_music_cleanup();
  level.special_autosavecondition = undefined;
  scripts\engine\utility::flag_set("grounds_cleared");
}

greenhouse_misters() {
  for(;;) {
    scripts\engine\utility::exploder("misters");
    wait 90;
  }
}

door_interact_presentation() {
  self endon("hint_destroyed");
  self waittill("trigger");
  playworldsound("door_locked", level.player.origin);
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.17, 0.2, level.player.origin, 200);
  level notify("player_tried_door");
}

hide_ents(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = undefined;
  var_4 = [];

  foreach(var_6 in var_2) {
    if(scripts\engine\utility::is_equal(var_6.script_noteworthy, var_1)) {
      continue;
    }
    if(var_6.classname == "script_brushmodel") {
      var_6 notsolid();

      if(var_6.spawnflags & 1)
        var_6 connectpaths();

      var_3 = var_6;
    }

    if(var_6.classname == "script_model") {
      var_4[var_4.size] = var_6;
      var_6 hide();
    }
  }

  if(isDefined(var_3) && isDefined(var_3.target)) {
    if(var_4.size)
      scripts\engine\utility::array_call(var_4, ::linkto, var_3);

    var_8 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_3 dontinterpolate();
    var_3.origin = var_8.origin - (0, 0, 20000);
  }
}

show_ents(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, var_1)) {
      continue;
    }
    if(var_4.classname == "script_model") {
      var_4 show();
      continue;
    }

    if(var_4.classname == "script_brushmodel") {
      if(isDefined(var_4.target)) {
        var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");
        var_4 dontinterpolate();
        var_4.origin = var_5.origin;
      }

      var_4 solid();

      if(var_4.spawnflags & 1)
        var_4 disconnectPaths();
    }
  }

  hide_ents(var_0 + "_pristine");
}

stealth_init() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  level.stealth.threatsightratescale = 3.0;
  level.special_autosavecondition = ::stealth_cansave;
  level.og_advancetoenemysettings = [level.advancetoenemyinterval, level.advancetoenemygroupmax];
  scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(2000, 1);
  level.player scripts\engine\utility::ent_flag_wait("stealth_enabled");
  level.player endon("stealth_enabled");
  childthread stealth_combat_music_init();
  childthread stealth_death_hints();
  childthread stealth_offhand_monitor();
}

stealth_cansave() {
  if(anyone_in_combat())
    return 0;

  if(level.player.lastgrenadetime > 0 && gettime() - level.player.lastgrenadetime < 3500)
    return 0;

  if(isDefined(level.technical) && level.technical.combating)
    return 0;

  return 1;
}

axis_stealth_spawnfunc() {
  if(!isDefined(self.stealth) || scripts\engine\utility::flag("escape_begin")) {
    return;
  }
  self.baseaccuracy = 3;
  self.maxfaceenemydist = 700;
  self.maxfacenewenemydist = 1000;

  if(!scripts\engine\utility::is_equal(self.script_noteworthy, "interrogator"))
    thread axis_stealth_cqb_think();

  if(!isDefined(self.stealth.funcs["event_cover_blown"]))
    scripts\stealth\utility::set_stealth_func("event_cover_blown", ::axis_stealth_filter);

  if(!isDefined(self.stealth.funcs["event_combat"]))
    scripts\stealth\utility::set_stealth_func("event_combat", ::axis_stealth_filter);

  if(getdvarint("greenlight"))
    scripts\engine\sp\utility::disable_long_death();
}

axis_stealth_cqb_think() {
  self endon("death");

  for(;;) {
    self waittill("stealth_combat");
    cqb_when_in_range();
    scripts\common\utility::disable_cqbwalk();
  }
}

cqb_when_in_range() {
  self endon("stealth_hunt");

  for(;;) {
    while(distancesquared(self.origin, level.player.origin) > 490000)
      waitframe();

    scripts\common\utility::enable_cqbwalk();

    while(distancesquared(self.origin, level.player.origin) <= 490000)
      waitframe();

    scripts\common\utility::disable_cqbwalk();
  }
}

axis_stealth_filter(var_0) {
  switch (var_0.typeorig) {
    case "explode":
      if(scripts\engine\utility::is_equal(var_0.entity.script_parameters, "service"))
        return 1;

      if(scripts\engine\utility::is_equal(var_0.entity, level.tut_fusebox))
        return 1;

      var_1 = undefined;

      if(var_0.entity == level.player) {
        if(isDefined(level.last_molotov_explode_time) && gettime() - level.last_molotov_explode_time <= 50)
          var_1 = "molotov";
        else if(isDefined(level.last_flash_explode_time) && gettime() - level.last_flash_explode_time <= 50)
          var_1 = "flash";
      } else if(isai(var_0.entity))
        var_1 = var_0.entity.grenadeweapon.basename;

      if(isDefined(var_1)) {
        if(var_1 == "molotov") {
          if(self hastacvis(var_0.origin, 1))
            return 0;

          var_2 = 1024;
        } else
          var_2 = 2048;

        if(distancesquared(self.origin, var_0.origin) > var_2 * var_2)
          return 1;

        return 0;
      }

      break;
    case "light_killed":
      if(var_0.entity getscriptablepartstate("onoff") == "off") {
        if(scripts\engine\utility::is_equal(var_0.entity.targetname, "lights_bld_service"))
          return 1;

        if(var_0.type == "combat")
          var_0.type = "cover_blown";
      }

      break;
  }

  return 0;
}

stealth_combat_music_init() {
  scripts\engine\utility::flag_wait("rappel_end");
  level.music_array[0] = "a";
  level.music_array[1] = "b";
  level.music_array[2] = "c";
  level.music_last_stealth_cue = "";
  level.player thread scripts\stealth\player::combatstate_thread();
  level.player scripts\stealth\player::combatstate_addupdatefunc("music", ::stealth_combat_music_updatefunc);
  level.player.stealth.combatstate.maxcombatdist = 2000;
  level.stealth_combat_music_state = level.player.stealth.combatstate.name;
  level.stealth_combat_music_state_type = level.player.stealth.combatstate.type;
}

stealth_combat_music_cleanup() {
  if(!isDefined(level.player.stealth)) {
    return;
  }
  if(!isDefined(level.player.stealth.combatstate)) {
    return;
  }
  level.player scripts\stealth\player::combatstate_removeupdatefunc("music");
  level.player scripts\stealth\player::combatstate_thread(0);
}

stealth_combat_music_updatefunc(var_0, var_1) {
  level notify("stealth_combat_music_state_updated");
  level endon("stealth_combat_music_state_updated");

  if(var_0 == "combat")
    scripts\engine\utility::flag_set("player_in_combat");

  wait 1.5;

  if(var_0 == "stealth" && scripts\engine\utility::flag("player_in_combat"))
    thread scripts\engine\sp\utility::flag_clear_delayed_endonset("player_in_combat", 0.5);

  var_2 = level.stealth_combat_music_state;
  var_3 = level.stealth_combat_music_state_type;
  level.stealth_combat_music_state = var_0;
  level.stealth_combat_music_state_type = var_1;
  var_4 = undefined;

  switch (var_0) {
    case "combat":
      if(var_2 != "combat")
        self notify("entered_combat");
      else if(var_3 != "unaware") {
        return;
      }
      if(var_1 == "aware")
        var_4 = "";
      else
        var_4 = "mx_tmp_estate_combat_alert";

      break;
    case "stealth":
      self notify("stop_disengage_nag_think");

      if(var_2 != "combat") {
        return;
      }
      if(!scripts\engine\utility::flag("player_in_combat")) {
        return;
      }
      thread stealth_music_thread();
      break;
  }

  if(!isDefined(var_4)) {
    return;
  }
  setmusicstate(var_4);
}

stealth_music_thread() {
  self endon("entered_combat");

  for(;;) {
    level.music_array = scripts\engine\utility::array_randomize(level.music_array);
    var_0 = level.music_array[0];

    if(isDefined(level.music_last_stealth_cue) && level.music_last_stealth_cue == var_0)
      var_0 = level.music_array[1];

    if(isDefined(level.music_last_stealth_cue) && isDefined(level.hvts_identified)) {
      level.music_hvt_num = level.hvts_identified + 1;

      if(level.music_hvt_num < 1)
        level.music_hvt_num = 1;

      if(level.music_hvt_num > 3)
        level.music_hvt_num = 3;

      var_1 = "mx_tmp_estate_stealth_" + level.music_hvt_num + var_0;
      level.music_last_stealth_cue = var_0;
    } else
      var_1 = "mx_tmp_estate_stealth_1a";

    if(isDefined(var_1))
      setmusicstate(var_1);

    wait 60;
    setmusicstate("");
    wait 40;
  }
}

stealth_death_hints() {
  level.player waittill("death", var_0);

  if(!isai(var_0)) {
    return;
  }
  if(isDefined(level.player.stealth.hints.causeofdeath)) {
    return;
  }
  if(isDefined(level.custom_death_quote)) {
    return;
  }
  var_1 = level.player getcurrentweapon();

  if((!isDefined(var_1.extra) || !issubstr(var_1.extra, "laser")) && var_1.classname != "pistol" && level.player scripts\sp\nvg\nvg_player::is_nvg_on()) {
    scripts\sp\player_death::set_custom_death_quote(43);
    return;
  }

  var_2 = [33, 35, 36, 37, 38, 40, 41, 42];

  if(level.player getstance() == "stand")
    var_2[var_2.size] = 34;

  if(level.player scripts\engine\utility::ent_flag("indoors"))
    var_2[var_2.size] = 39;

  if(level.player getplayerlightlevel() >= 0.5)
    var_2[var_2.size] = 44;

  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::random(var_2));
}

stealth_offhand_monitor() {
  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);
    var_0 thread offhand_explode_monitor(var_1.basename);
  }
}

offhand_explode_monitor(var_0) {
  self waittill("explode");

  if(var_0 == "molotov")
    level.last_molotov_explode_time = gettime();
  else
    level.last_flash_explode_time = gettime();
}

stealth_visibility_in_darkness() {
  for(;;) {
    var_0["prone"] = 130;
    var_0["crouch"] = 300;
    var_0["stand"] = 500;
    var_1["prone"] = 300;
    var_1["crouch"] = 500;
    var_1["stand"] = 900;
    scripts\stealth\utility::set_min_detect_range_darkness(var_0, var_1);
    level.player scripts\engine\utility::ent_flag_wait("indoors");
    var_0["prone"] = 130;
    var_0["crouch"] = 215;
    var_0["stand"] = 300;
    var_1["prone"] = 300;
    var_1["crouch"] = 375;
    var_1["stand"] = 450;
    scripts\stealth\utility::set_min_detect_range_darkness(var_0, var_1);
    level.player scripts\engine\utility::ent_flag_waitopen("indoors");
  }
}

waittill_player_hidden() {
  for(;;) {
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    scripts\engine\utility::flag_waitopen("player_in_combat");

    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }
    if(istrue(level.spawning_backup)) {
      waitframe();
      continue;
    }

    return;
  }
}

fusebox_init(var_0) {
  self.script_model = scripts\engine\utility::get_linked_ent();
  self.animnode = scripts\engine\sp\utility::get_linked_struct();
  self.script_model.animname = "fusebox";
  self.script_model scripts\engine\sp\utility::assign_animtree();
  self.interact_offset = self.script_model.origin + rotatevector((7, 4, 7), self.script_model.angles) - self.origin;
  self.use_dist_override = 50;

  if(issubstr(self.target, "church"))
    self.location = "church";
  else if(issubstr(self.target, "courtyard"))
    self.location = "courtyard";
  else if(issubstr(self.target, "pool"))
    self.location = "pool";

  self.animnode thread scripts\common\anim::anim_first_frame_solo(self.script_model, "fusebox_interact");
  thread disable_fuseboxes_on_grid();
  thread fusebox_damage_think(var_0);
  thread lightsout_achievement_think();
}

fusebox_damage_think(var_0) {
  self.script_model.health = 50;
  self.script_model setCanDamage(1);

  while(self.script_model.health > 0) {
    self.script_model waittill("damage", var_1, var_2);

    if(istrue(var_0) && var_2 != level.player)
      self.script_model.health = self.script_model.health + var_1;
  }

  self.destroyed = 1;

  if(self.script_light_switch_state)
    scripts\sp\interactables\dynolight::lightswitch_toggle();

  scripts\sp\interactables\dynolight::lightswitch_disable(1);

  if(isDefined(self.runner))
    self.runner notify("stop_turn_on_fusebox");

  self stoploopsound(self.script_light_idle_sfx);
  playFX(scripts\engine\utility::getfx("vfx_electrical_control_box"), self.origin);
  playworldsound("fusebox_explosion", self.origin);
  self.script_model setModel("uk_electrical_box_medium_01_open");

  foreach(var_4 in getscriptablearray(self.target, "targetname")) {
    if(var_4.model == "dynlt_fusebox_light_led_01_off" && distancesquared(self.origin, var_4.origin) < 10000) {
      var_4 hide();
      break;
    }
  }

  radiusdamage(self.origin, 100, 100, 30, self);

  if(!scripts\engine\utility::flag("rappel_end") && self.target == "lights_bld_courtyard") {
    var_6 = getEnt("vistawindows_courtyard", "targetname");

    if(isDefined(var_6))
      var_6 delete();
  }
}

disable_fuseboxes_on_grid() {
  self waittill("lightswitch_toggle");

  foreach(var_1 in level.fuseboxes) {
    if(!scripts\engine\utility::is_equal(var_1.target, self.target)) {
      continue;
    }
    if(var_1.script_light_switch_state)
      var_1 scripts\sp\interactables\dynolight::lightswitch_toggle();

    var_1 scripts\sp\interactables\dynolight::lightswitch_disable(1);
  }
}

fusebox_interact_anim() {
  if(!isDefined(self.animnode)) {
    return;
  }
  level.player.fusebox = self;
  level.player scripts\engine\utility::delaycall(0.2, ::lerpfovscalefactor, 0, 0.5);
  level.player scripts\engine\utility::delaycall(0.2, ::playsound, "scn_estate_fusebox_lever_off_plr");
  self.animnode scripts\sp\player_rig::link_player_to_rig("fusebox_interact", "stand", 1, 0.2, 0, 45, 45, 15, 15, 0, undefined, 1);
  self.animnode thread scripts\common\anim::anim_single([level.player_rig, self.script_model], "fusebox_interact");
  thread fusebox_interact_anim_unlink_player(level.player_rig);
  self.script_model waittill("handle_down");
  level.player lerpfovscalefactor(1, 0.5);
  wait 0.25;
}

fusebox_interact_anim_unlink_player(var_0) {
  var_0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_end");
  scripts\engine\utility::waittill_any_ents(var_0, "anim_end", level.player, "damage");
  scripts\sp\player_rig::unlink_player_from_rig(1);
  level.player.fusebox = undefined;
}

fusebox_handle_down(var_0) {
  var_0 notify("handle_down");
}

floodlights_init() {
  level.floodlight_controllers = scripts\engine\utility::getStructArray("floodlights_controller", "script_noteworthy");
  scripts\engine\utility::array_thread(level.floodlight_controllers, scripts\engine\utility::delaythread, 0.1, ::floodlight_controller_init);
  wait 0.15;
  var_0 = getscriptablearray("mansionfloodlights", "targetname");
  level.floodlights = scripts\engine\utility::array_combine(level.floodlights, var_0);
}

floodlight_controller_init() {
  self.floodlights = [];
  var_0 = scripts\engine\utility::get_linked_ents();

  foreach(var_2 in var_0) {
    switch (var_2.script_noteworthy) {
      case "floodlight":
        self.floodlights[self.floodlights.size] = var_2;
        var_3 = spawnStruct();
        var_3.script_radius = 1000;
        var_3.script_type = "light_spot";
        var_3.script_fov_inner = 50;
        var_3.script_percent = 0.9;
        var_3.angles = var_2.angles;
        var_2.data = var_3;
        var_2.alive = 1;
        var_2.lightpos = var_2 gettagorigin("tag_fx_bulb");
        var_2.intensity = 1;
        var_2.timeoflaststatechange = gettime();
        break;
      case "lightsource":
        self.lightsource = var_2;
        break;
    }
  }

  self.lightsource setlightintensity(0);

  if(!isDefined(level.floodlights))
    level.floodlights = [];

  level.floodlights = scripts\engine\utility::array_combine(level.floodlights, self.floodlights);
  level.castingdynolights = scripts\engine\utility::array_combine(level.castingdynolights, self.floodlights);
  self.baseintensity = self.lightsource.script_intensity;
  self.intensity = self.baseintensity;
  self.active = 0;
  scripts\engine\utility::array_thread(self.floodlights, ::floodlight_death_watcher, self);
}

floodlight_death_watcher(var_0) {
  var_0 endon("floodlights_off");
  self waittill("death");
  self.alive = 0;
  var_0.floodlights = scripts\engine\utility::array_remove(var_0.floodlights, self);

  if(var_0.floodlights.size)
    var_0.intensity = var_0.intensity * 0.35;
  else
    var_0.intensity = 0;

  if(!var_0.active) {
    return;
  }
  var_0.lightsource setlightintensity(var_0.intensity);
  var_1 = scripts\engine\utility::drop_to_ground(self.origin, 24, -256);
  var_2 = scripts\engine\utility::get_array_of_closest(var_1, getaiarray("axis"), undefined, undefined, 800);
  scripts\engine\utility::array_call(var_2, ::aieventlistenerevent, "light_killed", self, var_1);
  level.floodlights = scripts\engine\utility::array_remove(level.floodlights, self);
}

floodlight_blowout_think() {
  self.blowout = 0;
  wait(0.05 * (self getentitynumber() % 5 + 1));
  var_0 = 0;
  var_1 = 1;

  if(!isDefined(self.fwd))
    self.fwd = anglesToForward(self.angles);

  while(self getscriptablepartstate("onoff") == "on") {
    self.blowout = var_0;

    if(!var_1)
      wait 0.2;

    if(self getscriptablepartstate("onoff") != "on") {
      break;
    }

    var_1 = 0;
    var_0 = 0;
    var_2 = level.player getEye();
    var_3 = distancesquared(self.origin, var_2);

    if(var_3 > squared(1000)) {
      continue;
    }
    var_4 = vectordot(self.fwd, vectorNormalize(var_2 - self.origin));

    if(var_4 < cos(50)) {
      continue;
    }
    var_5 = (var_4 - cos(50)) / (cos(10) - cos(50));

    if(!sighttracepassed(self.origin + self.fwd * 15, var_2, 0, [self, level.player], 1)) {
      continue;
    }
    var_6 = sqrt(var_3);
    var_7 = (var_6 - 100) / 900;
    var_7 = 1 - var_7;
    var_0 = var_7 + var_5;
    var_0 = clamp(var_0, 0, 0.99);
  }

  self.blowout = 0;
}

floodlights_on() {
  foreach(var_1 in self.floodlights) {
    if(var_1 getscriptablepartstate("onoff") == "off")
      var_1 setscriptablepartstate("onoff", "on");
  }

  self.lightsource setlightintensity(self.intensity);
  self.active = 1;
}

floodlights_off() {
  self notify("floodlights_off");

  foreach(var_1 in self.floodlights) {
    if(var_1 getscriptablepartstate("onoff") == "on")
      var_1 setscriptablepartstate("onoff", "off");
  }

  self.lightsource setlightintensity(0);
  self.active = 0;
}

turn_on_floodlights() {
  var_0 = getEnt("floodlightfusebox", "script_noteworthy");
  var_0 scripts\sp\interactables\dynolight::lightswitch_toggle();
  scripts\engine\utility::array_thread(level.floodlight_controllers, ::floodlights_on);
  scripts\engine\utility::array_thread(level.floodlights, ::floodlight_blowout_think);
  thread floodlights_vision_think();
}

turn_off_floodlights() {
  if(!isDefined(level.floodlights)) {
    level.floodlight_controllers = undefined;
    return;
  }

  var_0 = getEnt("floodlightfusebox", "script_noteworthy");
  var_0 scripts\sp\interactables\dynolight::lightswitch_toggle();
  var_0 scripts\sp\interactables\dynolight::lightswitch_disable(1);
  scripts\engine\utility::array_thread(level.floodlight_controllers, ::floodlights_off);
  level.floodlight_controllers = undefined;
  level.floodlights = undefined;
}

floodlights_vision_think() {
  level.player.blowout = 0;

  while(isDefined(level.floodlights)) {
    var_0 = scripts\engine\utility::get_array_of_closest(level.player getEye(), level.floodlights, undefined, undefined, 1000);
    var_1 = 0;

    foreach(var_3 in var_0) {
      var_1 = var_1 + var_3.blowout;

      if(var_1 >= 1) {
        break;
      }
    }

    var_1 = min(level.player getplayerlightlevel(), var_1);
    level.player setnightvisionblindweight(var_1);
    level.player.blowout = var_1;
    waitframe();
  }

  level.player.blowout = undefined;
  level.player setnightvisionblindweight(0);
}

anyone_in_combat(var_0) {
  if(!scripts\engine\utility::flag("stealth_enabled"))
    return 0;

  foreach(var_2 in level.stealth.groupdata.groups) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_2.name)) {
      continue;
    }
    if(scripts\stealth\group::group_anyoneincombat(var_2.name))
      return 1;
  }

  return 0;
}

anyone_in_hunt(var_0) {
  if(!scripts\engine\utility::flag("stealth_enabled"))
    return 0;

  foreach(var_2 in level.stealth.groupdata.groups) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_2.name)) {
      continue;
    }
    if(scripts\stealth\group::group_anyoneincombat(var_2.name))
      return 0;

    foreach(var_4 in var_2.members) {
      if(var_4[[var_4.fnisinstealthhunt]]())
        return 1;
    }
  }

  return 0;
}

anyone_has_known_player_since_time(var_0, var_1) {
  if(!scripts\engine\utility::flag("stealth_enabled"))
    return 0;

  foreach(var_3 in level.stealth.groupdata.groups) {
    if(isDefined(var_1) && !scripts\engine\utility::array_contains(var_1, var_3.name)) {
      continue;
    }
    if(!scripts\stealth\group::group_anyoneincombat(var_3.name)) {
      continue;
    }
    foreach(var_5 in var_3.members) {
      if(!var_5[[var_5.fnisinstealthcombat]]()) {
        continue;
      }
      if(!scripts\engine\utility::is_equal(var_5.enemy, level.player)) {
        continue;
      }
      if(var_5 lastknowntime(level.player) <= var_0) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

spawn_friendlies() {
  if(isDefined(level.friendlies))
    iprintln("Respawning all friendlies!");

  level.friendlies = [];
  spawn_price();
  spawn_hadir();
}

spawn_price() {
  if(isDefined(level.price))
    iprintln("Respawning Price!");

  level.price = scripts\engine\sp\utility::spawn_script_noteworthy("price", 1);
  level.price.animname = "price";
  level.price.deathfunction = ::friendly_death_func;

  if(!isDefined(level.friendlies))
    level.friendlies = [];

  level.friendlies[level.friendlies.size] = level.price;
  level.price.name = "Captain Price";
  var_0 = make_price_ar();
  level.price scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  level.cutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters", level.price.origin);
  level.price scripts\engine\sp\utility::set_grenadeweapon("flash");
  level.price scripts\engine\sp\utility::set_grenadeammo(4);
  level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
}

make_price_rifle() {
  return scripts\sp\utility::make_weapon("iw8_ar_falima", ["barshort_falima", "laserir_bar", "silencer_east01", "snprscope_mike14_ar"]);
}

make_price_ar() {
  return scripts\sp\utility::make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|0", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
}

make_price_pistol(var_0) {
  var_1 = ["rec_papa320|1", "mag_papa320|1", "slide_papa320|1"];

  if(istrue(var_0))
    var_1[var_1.size] = "silencerpstl_west01";

  return scripts\sp\utility::make_weapon("iw8_pi_papa320", var_1);
}

spawn_hadir() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("hadir", 1);
  level.friendlies[level.friendlies.size] = var_0;
  var_0.deathfunction = ::friendly_death_func;
  var_0 scripts\common\ai::magic_bullet_shield(1);
  var_0.animname = "ally1";
  var_0.maxvisibledist = 8192;
  var_0.team = "allies";
  level.hadir = var_0;
  level.price scripts\engine\sp\utility::set_grenadeweapon("molotov");
  level.price scripts\engine\sp\utility::set_grenadeammo(4);
}

#using_animtree("generic_human");

gesture_nvgs(var_0) {
  var_1 = % sdr_ges_nvg_raise_nvg;
  var_2 = % sdr_ges_nvg_lower_nvg;
  self.visor_down = var_0;

  if(var_0) {
    if(!istrue(self.nvg_on)) {
      self.nvg_on = 1;
      thread ai_nvg_down(var_1, var_2);
    }
  } else if(istrue(self.nvg_on)) {
    self.nvg_on = 0;
    thread ai_nvg_up(var_1, var_2);
  }
}

ai_nvg_up(var_0, var_1) {
  var_2 = self getanimweight(var_1);

  if(var_2 > 0)
    self clearanim(var_1, 0);

  self setanim(var_0, 1, 0, 1.0);
}

ai_nvg_down(var_0, var_1) {
  var_2 = self getanimweight(var_0);

  if(var_2 > 0)
    self clearanim(var_0, 0);

  self setanim(var_1, 1, 0, 1.0);
}

friendly_death_func() {
  level.friendlies = scripts\engine\utility::array_remove(level.friendlies, self);

  if(isDefined(self.origin))
    playworldsound("generic_death_falling", self.origin);

  return 0;
}

spawn_dead_body() {
  var_0 = getspawner("dead_body_male", "targetname");
  var_0.count++;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var_1 notsolid();
  var_1.origin = self.origin;
  var_1.targetname = "dead_body";
  var_1 scriptmoverdistancefade();
  var_1.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  return var_1;
}

get_closest_guy_by_path(var_0, var_1) {
  var_2 = undefined;
  var_3 = 1048576;
  var_4 = [];

  foreach(var_6 in var_1) {
    if(isDefined(var_6) && isalive(var_6)) {
      if(distancesquared(var_6.origin, var_0) < var_3)
        var_4[var_4.size] = var_6;
    }
  }

  if(var_4.size > 0)
    var_2 = findclosestnonlospointwithinvolume(var_4, var_0);

  return var_2;
}

try_indoor_save() {
  if(!level.player scripts\engine\utility::ent_flag("indoors")) {
    return;
  }
  level.player endon("indoors");
  wait 2;

  for(;;) {
    if(isDefined(level.lastsavetime)) {
      if(gettime() - level.lastsavetime < 5000)
        wait 5;
    }

    scripts\engine\sp\utility::autosave_by_name("escape_indoors");
    wait 10;
  }
}

has_ceiling() {
  var_0 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 0, 1, 0);
  return !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 1000), self, var_0);
}

delete_at_distance_to_player(var_0, var_1, var_2) {
  var_3 = squared(var_1);

  while(distance2dsquared(level.player.origin, var_0) < var_3)
    waitframe();

  foreach(var_5 in var_2)
  var_5 delete();
}

waittill_player_stops_rotating_or_timeout(var_0) {
  var_1 = gettime();

  while(gettime() - var_1 < var_0 * 1000) {
    if(abs(level.player getnormalizedcameramovement()[1]) < 0.2) {
      return;
    }
    waitframe();
  }
}

waittill_player_stops_rotating() {
  for(;;) {
    if(abs(level.player getnormalizedcameramovement()[1]) < 0.2) {
      return;
    }
    waitframe();
  }
}

weapon_switch_monitor() {
  level.player endon("death");
  var_0 = "MTSOPQRMRT";
  var_1 = getdvarint(var_0);
  var_2 = ["none", "iw8_melee"];
  make_alias_group("nonsuppressed", ["dx_vom_pri_warning_silence_10", "dx_vom_pri_warning_silence_20", "dx_vom_pri_warning_silence_30"]);
  level.last_warned_weapon = "none";
  var_3 = [];

  for(;;) {
    var_4 = waittill_player_switched_weapons(var_2);

    if(player_has_silencer(var_4)) {
      if(var_1) {
        setsaveddvar(var_0, 0);
        var_1 = 0;
      }
    } else {
      if(!var_1) {
        setsaveddvar(var_0, 1);
        var_1 = 1;
      }

      if(should_warn_nonsuppressed(var_4, var_3))
        thread vo_warn_nonsuppressed(var_4);
    }

    var_3 = level.player getweaponslistprimaries();
    level.player scripts\engine\utility::waittill_any("weapon_taken", "weapon_switch_started", "turret_mount", "turret_dismount");
  }
}

should_warn_nonsuppressed(var_0, var_1) {
  if(!level.player scripts\engine\utility::ent_flag_exist("stealth_enabled"))
    return 0;

  if(!level.player scripts\engine\utility::ent_flag("stealth_enabled"))
    return 0;

  if(scripts\engine\utility::flag("stealth_spotted"))
    return 0;

  if(isDefined(level.last_nonsuppressed_warning_time) && !scripts\engine\utility::time_has_passed(level.last_nonsuppressed_warning_time, 10))
    return 0;

  if(createheadicon(var_0) == level.last_warned_weapon)
    return 0;

  if(scripts\engine\utility::array_contains(var_1, var_0))
    return 0;

  return 1;
}

vo_warn_nonsuppressed(var_0) {
  level.player endon("weapon_taken");
  level.player endon("weapon_switch_started");
  level.player endon("turret_mount");
  level.player endon("turret_dismount");
  var_1 = get_next_alias_in_group("nonsuppressed", 1);

  if(isDefined(level.price) && isalive(level.price)) {
    while(istrue(level.price.speaking))
      wait 0.5;

    thread price_line(var_1);
  } else if(isDefined(level.overwatch_requests)) {
    var_2 = 0;

    for(;;) {
      var_2 = scripts\sp\maps\estate\estate_grounds.gsc::request_overwatch_vo("weapon", var_1, 1, 0);

      if(var_2) {
        break;
      }

      waitframe();
    }
  } else
    level thread scripts\engine\sp\utility::smart_radio_dialogue(var_1);

  increment_alias_group_index("nonsuppressed");
  level.last_warned_weapon = createheadicon(var_0);
  level.last_nonsuppressed_warning_time = gettime();
}

waittill_player_switched_weapons(var_0) {
  if(level.player isusingturret()) {
    level.player.was_using_turret = 1;
    return level.technical.mgturret[0] getturretweaponinfo();
  }

  if(istrue(level.player.was_using_turret)) {
    level.player.was_using_turret = undefined;
    return level.player getcurrentweapon();
  }

  var_1 = level.player getcurrentweapon();

  for(var_2 = var_1; var_2 == var_1 || scripts\engine\utility::array_contains(var_0, var_2.basename); var_2 = level.player getcurrentweapon())
    waitframe();

  return var_2;
}

player_has_silencer(var_0) {
  if(!isDefined(var_0))
    var_0 = level.player getcurrentweapon();

  return var_0 hasattachment("silenc", 1);
}

nvg_exterior_monitor() {
  level.player endon("death");
  var_0 = "indoors";

  while(!level.player scripts\engine\utility::ent_flag_exist(var_0))
    waitframe();

  for(;;) {
    if(level.player scripts\engine\utility::ent_flag(var_0)) {
      setomnvar("ai_fulllight", 0.001);
      setomnvar("ai_nolight", 0.0005);
    } else {
      setomnvar("ai_fulllight", 0.0015);
      setomnvar("ai_nolight", 0.001);
    }

    level.player waittill(var_0);
  }
}

friendly_stealth_off() {
  scripts\engine\utility::ent_flag_clear("stealth_enabled");
  self.stealth = undefined;
  self.dontevershoot = 0;
  self.dontattackme = 0;
  self.maxvisibledist = 8192;
}

sprint_when_needed() {
  self endon("death");

  for(;;) {
    self waittill("path_set");
    waittillframeend;
    thread sprint_to_goal();
  }
}

sprint_to_goal() {
  self notify("check_should_sprint");
  self endon("check_should_sprint");
  var_0 = self pathdisttogoal();

  if(var_0 > 450 && !istrue(self.sprint))
    scripts\engine\sp\utility::enable_sprint();
  else if(var_0 < 450 && istrue(self.sprint))
    scripts\engine\sp\utility::disable_sprint();

  self waittill("goal");
  scripts\engine\sp\utility::disable_sprint();
}

stop_fighting_with_player() {
  self notify("stop_fight_with_player");
  self.fighting_with_player = undefined;
}

fight_with_player(var_0, var_1) {
  self endon("death");
  self endon("stop_fight_with_player");
  self.fighting_with_player = 1;
  self.fixednode = 0;

  if(!isDefined(var_0))
    var_0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname");

  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 350);

  for(;;) {
    self.goalradius = 350;
    var_2 = var_0.origin;

    while(distancesquared(self.origin, var_2) > squared(200)) {
      var_3 = scripts\engine\sp\utility::get_closest_to_player_view(getaiarray("axis"));

      if(!isDefined(var_3))
        var_3 = var_0;

      var_4 = vectortoangles(var_3.origin - level.player.origin);
      var_4 = var_4 + (0, randomfloatrange(-30, 30), 0);
      var_2 = level.player.origin + anglesToForward(var_4) * var_1;
      var_5 = getclosestpointonnavmesh(var_2);
      self setgoalpos(var_5);
      waitframe();
      var_6 = self findbestcovernode(undefined, 0, var_3.origin, 0);

      if(isDefined(var_6))
        self setgoalnode(var_6);

      wait 2;
    }

    self.goalradius = 600;
    level.player scripts\engine\sp\utility::waittill_out_of_range(level.player.origin, 150, 0.25);
    waitframe();
  }
}

color_trig_touching() {
  if(self.classname == "info_volume") {
    return;
  }
  self endon("stop_color_trig_touching");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_1 = 0;

    if(!isDefined(var_0.current_color_trig))
      var_1 = 1;
    else if(isDefined(var_0.current_color_trig)) {
      if(var_0.current_color_trig != self)
        var_1 = 1;
    }

    if(!var_1) {
      continue;
    }
    var_0.current_color_trig = self;
    var_0 notify("new_color_trig");

    foreach(var_3 in level.friendlies) {
      if(isDefined(var_3.fighting_with_player)) {
        if(!istrue(var_3.move_override)) {
          var_3 stop_fighting_with_player();
          var_3 scripts\engine\sp\utility::enable_ai_color();
        }
      }
    }

    var_0 thread monitor_no_colors(self);
  }
}

monitor_no_colors(var_0) {
  self endon("new_color_trig");
  var_0 endon("death");

  while(self istouching(var_0))
    wait 0.05;

  while(self getnormalizedmovement() == (0, 0, 0))
    wait 0.05;

  wait 5;
  scripts\engine\utility::array_thread(level.friendlies, ::ai_use_scripted_navigation);
}

ai_clear_all_navigation() {
  self notify("stop_color_trig_touching");
  stop_fighting_with_player();
  scripts\engine\sp\utility::clear_force_color();
  self.move_override = undefined;
}

ai_use_scripted_navigation() {
  if(istrue(self.move_override)) {
    return;
  }
  scripts\engine\sp\utility::clear_force_color();
  thread fight_with_player();
}

notetrack_nag(var_0, var_1) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_3 in var_1)
  level endon(var_3);

  for(;;) {
    foreach(var_6 in var_0) {
      level waittill("nag");
      thread price_line(var_6);
    }
  }
}

nags_til_notify(var_0, var_1, var_2, var_3) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_5 in var_1)
  level endon(var_5);

  if(!istrue(var_2) && var_0.size > 1)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  if(isDefined(var_3))
    wait(var_3);

  for(;;) {
    foreach(var_8 in var_0) {
      scripts\engine\sp\utility::smart_dialogue(var_8);
      wait(randomintrange(8, 13));
    }
  }
}

delete_noteworthy_ents(var_0) {
  wait 1;
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(var_1.size)
    scripts\engine\utility::array_call(var_1, ::delete);
}

cleanup_all_dropped_loot() {
  if(isDefined(level.loot) && isDefined(isDefined(level.loot.items)) && istrue(level.loot.items.size)) {
    foreach(var_1 in level.loot.items) {
      if(scripts\sp\loot::itemworldplaced(var_1)) {
        continue;
      }
      var_1 scripts\sp\loot::cleanuplootitem();
    }
  }
}

reactive_foliage_low() {
  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.reactivefoliagestate = "low";
  level.lerpingreactivefoliage = 1;
  var_0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.6, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 0.3, var_0);
  wait(var_0);
  level.lerpingreactivefoliage = undefined;
}

reactive_foliage_med() {
  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.lerpingreactivefoliage = 1;
  level.reactivefoliagestate = "med";
  var_0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.6, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 0.7, var_0);
  wait(var_0);
  level.lerpingreactivefoliage = undefined;
}

reactive_foliage_high() {
  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.lerpingreactivefoliage = 1;
  level.reactivefoliagestate = "high";
  var_0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.6, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 1.3, var_0);
  wait(var_0);
  level.lerpingreactivefoliage = undefined;
}

laser_discipline() {
  self endon("death");
  self endon("stop_laser_discipline");
  waitframe();

  if(isDefined(self.ridingvehicle))
    self waittill("jumpedout");

  var_0 = 0;
  var_1 = cos(10);
  self.a.laseron = 0;
  var_2 = 0.6;

  for(;;) {
    while(nullweapon(self.weapon) || !isDefined(self.enemy))
      wait 0.25;

    var_0 = is_aimed_at_enemy(var_1);

    if(var_0) {
      if(!self.a.laseron) {
        self.a.laseron = 1;
        self laseralton();
        wait(0.5 + randomfloat(1));
        self.a.laseron = 0;
        self laseraltoff();
        wait(5 + randomfloat(2));
      }
    }

    wait(var_2);
  }
}

is_aimed_at_enemy(var_0) {
  if(isDefined(self.enemy) && isalive(self.enemy)) {
    var_1 = ["j_mainroot", "j_spine4", "tag_eye"];

    foreach(var_3 in var_1) {
      if(!nullweapon(self.weapon) && isalive(self.enemy) && scripts\engine\utility::within_fov(self.origin, self gettagangles("tag_flash"), self.enemy gettagorigin(var_3), var_0))
        return 1;
    }
  }

  return 0;
}

can_i_see_an_enemy_or_can_enemies_see_me() {
  foreach(var_1 in getaiarray("axis")) {
    if(self cansee(var_1))
      return 1;

    if(var_1 cansee(self))
      return 1;
  }

  return 0;
}

abs_int(var_0) {
  return int(abs(var_0));
}

make_alias_group(var_0, var_1) {
  if(isDefined(level.alias_groups)) {}

  var_2 = spawnStruct();
  var_2.aliases = var_1;
  var_2.index = 0;
  level.alias_groups[var_0] = var_2;
}

alias_group_exists(var_0) {
  return isDefined(level.alias_groups[var_0]);
}

clear_alias_group(var_0) {
  level.alias_groups[var_0] = undefined;
}

get_next_alias_in_group(var_0, var_1) {
  var_2 = level.alias_groups[var_0];
  var_3 = var_2.aliases[var_2.index];

  if(!istrue(var_1))
    increment_alias_group_index(var_2);

  return var_3;
}

increment_alias_group_index(var_0) {
  if(isstring(var_0))
    var_0 = level.alias_groups[var_0];

  var_0.index++;

  if(var_0.index >= var_0.aliases.size)
    var_0.index = 0;
}

lightsout_achievement_think() {
  level endon("obj_scene_started");
  level endon("lightsout_achievement_get");
  self waittill("lightswitch_toggle");

  if(istrue(self.noachievement)) {
    return;
  }
  if(isDefined(level.lightsout_targets) && scripts\engine\utility::array_contains(level.lightsout_targets, self.target)) {
    return;
  }
  if(!isDefined(level.lightsout_targets))
    level.lightsout_targets = [];

  level.lightsout_targets[level.lightsout_targets.size] = self.target;

  if(level.lightsout_targets.size >= 4) {
    scripts\sp\utility::giveachievement_wrapper("lightsout");
    level notify("lightsout_achievement_get");
  }
}

ownthenight_achievement_think() {
  level endon("obj_scene_started");
  level endon("backup_spawned");
  var_0 = ["church_east_spawner", "church_west_spawner", "church_interior_spawner", "church_interrogator_spawner", "courtyard_north_spawner", "courtyard_south_spawner", "courtyard_east_spawner", "courtyard_east_upper_spawner", "courtyard_west_spawner", "courtyard_west_upper_spawner", "courtyard_interrogator_spawner", "pool_east_spawner", "pool_west_spawner", "pool_interior_spawner", "pool_interrogator_spawner"];
  level.ownthenight_spawners = [];

  foreach(var_2 in var_0) {
    var_3 = getspawnerarray(var_2);

    foreach(var_5 in var_3)
    var_5 childthread ownthenight_spawner_think();

    level.ownthenight_spawners = scripts\engine\utility::array_combine(level.ownthenight_spawners, var_3);
  }

  level.ownthenight_deathcount = 0;
  level waittill("we_own_the_night");
  scripts\sp\utility::giveachievement_wrapper("ownthenight");
  level.ownthenight_deathcount = undefined;
  level.ownthenight_spawners = undefined;
}

ownthenight_spawner_think(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in var_0)
    level endon(var_2);
  }

  for(;;) {
    var_4 = waittill_spawned();

    if(!isDefined(var_4)) {
      level.ownthenight_spawners = scripts\engine\utility::array_remove(level.ownthenight_spawners, self);

      if(level.ownthenight_deathcount >= level.ownthenight_spawners.size)
        level notify("we_own_the_night");

      return;
    }

    var_4 waittill("death");
    waitframe();

    if(!isDefined(self.suspended_ai)) {
      break;
    }
  }

  level.ownthenight_deathcount++;

  if(level.ownthenight_deathcount >= level.ownthenight_spawners.size)
    level notify("we_own_the_night");
}

waittill_spawned() {
  if(scripts\engine\utility::is_equal(self.script_parameters, "stealth_spawn_only")) {
    var_0 = strtok(self.script_stealthgroup, "_")[0];

    if(scripts\engine\utility::flag(var_0 + "_gone_hot"))
      return undefined;

    level endon(var_0 + "_gone_hot");
  }

  self waittill("spawned", var_1);
  return var_1;
}

lerp_fov_over_distance_trigger() {
  var_0 = strtok(self.script_parameters, " ");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = scripts\engine\utility::getStruct(var_3, "targetname");

  var_5 = float(var_1[0].script_parameters);
  var_6 = float(var_1[1].script_parameters);
  var_7 = distance(var_1[0].origin, var_1[1].origin);

  for(;;) {
    if(!level.player istouching(self))
      self waittill("trigger");

    while(level.player istouching(self)) {
      var_8 = pointonsegmentnearesttopoint(var_1[0].origin, var_1[1].origin, level.player.origin);
      var_9 = scripts\engine\math::normalize_value(0, var_7, distance(var_1[0].origin, var_8));
      var_10 = scripts\engine\math::factor_value(var_5, var_6, var_9);
      level.player modifybasefov(var_10, 0.05);

      if(level.player adsButtonPressed())
        wait 0.3;
      else
        level.player modifybasefov(var_10, 0.05);

      waitframe();
    }
  }
}