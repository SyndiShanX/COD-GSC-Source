/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\estate\estate_util.gsc
**************************************************/

function price_line(var0) {
  level.price.speaking = 1;

  if(soundexists(var0)) {
    level.price scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    var1 = "^5Price:^7 " + var0;
    iprintlnbold(var1);
  }

  level.price.speaking = undefined;
}

function hadir_line(var0) {
  if(soundexists(var0)) {
    level.hadir scripts\engine\sp\utility::smart_dialogue(var0);
    return;
  }

  var1 = "^3Hadir:^7 " + var0;
  iprintlnbold(var1);
}

function kyle_line(var0) {
  if(soundexists(var0)) {
    level.player scripts\engine\sp\utility::smart_player_dialogue(var0);
    return;
  }

  var1 = "^2Kyle:^7 " + var0;
  iprintlnbold(var1);
}

function indoor_monitor() {
  scripts\engine\utility::ent_flag_init("indoors");

  for(;;) {
    while(!scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
      waitframe();
    }

    scripts\engine\utility::ent_flag_set("indoors");
    var0 = self getistouchingentities(level.interior_volumes)[0];

    while(self istouching(var0)) {
      waitframe();
    }

    scripts\engine\utility::ent_flag_clear("indoors");
  }
}

function post_grounds_cleanup() {
  if(level.start_point == "spawn_test" || level.start_point == "technical_test") {
    return;
  }

  if(scripts\engine\utility::flag("stealth_enabled")) {
    scripts\stealth\utility::disable_stealth_system();
  }

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

  foreach(var1 in getspawnerteamarray("axis")) {
    if(isstartstr(var1.classname, "actor_enemy_alq") && !scripts\engine\utility::is_equal(var1.targetname, "getup_aq")) {
      var1 delete();
    }
  }

  if(isDefined(level.hvts)) {
    foreach(var4 in level.hvts) {
      if(isDefined(var4)) {
        destroynavobstacle(var4.obstacle_id);
        var4 delete();
      }
    }
  }

  if(isDefined(level.og_advancetoenemysettings)) {
    scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(level.og_advancetoenemysettings[0], level.og_advancetoenemysettings[1]);
    level.og_advancetoenemysettings = undefined;
  }

  if(scripts\engine\sp\utility::exists_global_spawn_function("axis", &scripts\sp\maps\estate\estate_grounds::grounds_axis_spawnfunc)) {
    scripts\engine\sp\utility::remove_global_spawn_function("axis", &scripts\sp\maps\estate\estate_grounds::grounds_axis_spawnfunc);
  }

  if(isDefined(level.alias_groups) && level.alias_groups.size) {
    foreach(var7 in getarraykeys(level.alias_groups)) {
      clear_alias_group(var7);
    }
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

function greenhouse_misters() {
  for(;;) {
    scripts\engine\utility::exploder("misters");
    wait 90;
  }
}

function door_interact_presentation() {
  self endon("hint_destroyed");
  self waittill("trigger");
  playworldsound("door_locked", level.player.origin);
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.17, 0.2, level.player.origin, 200);
  level notify("player_tried_door");
}

function hide_ents(var0, var1) {
  var2 = getEntArray(var0, "targetname");
  var3 = undefined;
  var4 = [];

  foreach(var6 in var2) {
    if(scripts\engine\utility::is_equal(var6.script_noteworthy, var1)) {
      continue;
    }

    if(var6.classname == "script_brushmodel") {
      var6 notsolid();

      if(var6.spawnflags & 1) {
        var6 connectpaths();
      }

      var3 = var6;
    }

    if(var6.classname == "script_model") {
      var4 = var6;
      var6 hide();
    }
  }

  if(isDefined(var3) && isDefined(var3.target)) {
    if(var4.size) {
      scripts\engine\utility::array_call(var4, &linkto, var3);
    }

    var8 = scripts\engine\utility::getStruct(var3.target, "targetname");
    var3 dontinterpolate();
    var3.origin = var8.origin - (0, 0, 20000);
    return;
  }
}

function show_ents(var0, var1) {
  var2 = getEntArray(var0, "targetname");

  foreach(var4 in var2) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, var1)) {
      continue;
    }

    if(var4.classname == "script_model") {
      var4 show();
      continue;
    }

    if(var4.classname == "script_brushmodel") {
      if(isDefined(var4.target)) {
        var5 = scripts\engine\utility::getStruct(var4.target, "targetname");
        var4 dontinterpolate();
        var4.origin = var5.origin;
      }

      var4 solid();

      if(var4.spawnflags & 1) {
        var4 disconnectPaths();
      }
    }
  }

  hide_ents(var0 + "_pristine");
}

function stealth_init() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  level.stealth.threatsightratescale = 3;
  level.special_autosavecondition = &stealth_cansave;
  level.og_advancetoenemysettings = [level.advancetoenemyinterval, level.advancetoenemygroupmax];
  scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(2000, 1);
  level.player scripts\engine\utility::ent_flag_wait("stealth_enabled");
  level.player endon("stealth_enabled");
  GscBinSkip4(0x35);
}

function stealth_cansave() {
  if(anyone_in_combat()) {
    return false;
  }

  if(level.player.lastgrenadetime > 0 && gettime() - level.player.lastgrenadetime < 3500) {
    return false;
  }

  if(isDefined(level.technical) && level.technical.combating) {
    return false;
  }

  return true;
}

function axis_stealth_spawnfunc() {
  if(!isDefined(self.stealth) || scripts\engine\utility::flag("escape_begin")) {
    return;
  }

  self.baseaccuracy = 3;
  self.maxfaceenemydist = 700;
  self.maxfacenewenemydist = 1000;

  if(!scripts\engine\utility::is_equal(self.script_noteworthy, "interrogator")) {
    thread axis_stealth_cqb_think();
  }

  if(!isDefined(self.stealth.funcs["event_cover_blown"])) {
    scripts\stealth\utility::set_stealth_func("event_cover_blown", &axis_stealth_filter);
  }

  if(!isDefined(self.stealth.funcs["event_combat"])) {
    scripts\stealth\utility::set_stealth_func("event_combat", &axis_stealth_filter);
  }

  if(getdvarint("greenlight")) {
    scripts\engine\sp\utility::disable_long_death();
    return;
  }
}

function axis_stealth_cqb_think() {
  self endon("death");

  for(;;) {
    self waittill("stealth_combat");
    cqb_when_in_range();
    scripts\common\utility::disable_cqbwalk();
  }
}

function cqb_when_in_range() {
  self endon("stealth_hunt");

  for(;;) {
    while(distancesquared(self.origin, level.player.origin) > 490000) {
      waitframe();
    }

    scripts\common\utility::enable_cqbwalk();

    while(distancesquared(self.origin, level.player.origin) <= 490000) {
      waitframe();
    }

    scripts\common\utility::disable_cqbwalk();
  }
}

function axis_stealth_filter(var0) {
  switch (var0.typeorig) {
    case "explode":
      if(scripts\engine\utility::is_equal(var0.entity.script_parameters, "service")) {
        return true;
      }

      if(scripts\engine\utility::is_equal(var0.entity, level.tut_fusebox)) {
        return true;
      }

      var1 = undefined;

      if(var0.entity == level.player) {
        if(isDefined(level.last_molotov_explode_time) && gettime() - level.last_molotov_explode_time <= 50) {
          var1 = "molotov";
        } else if(isDefined(level.last_flash_explode_time) && gettime() - level.last_flash_explode_time <= 50) {
          var1 = "flash";
        }
      } else if(isai(var0.entity)) {
        var1 = var0.entity.grenadeweapon.basename;
      }

      if(isDefined(var1)) {
        if(var1 == "molotov") {
          if(self hastacvis(var0.origin, 1)) {
            return false;
          }

          var2 = 1024;
        } else {
          var2 = 2048;
        }

        if(distancesquared(self.origin, var1.origin) > var2 * var2) {
          return true;
        }

        return false;
      }

      break;
    case "light_killed":
      if(var2.entity getscriptablepartstate("onoff") == "off") {
        if(scripts\engine\utility::is_equal(var2.entity.targetname, "lights_bld_service")) {
          return true;
        }

        if(var2.type == "combat") {
          var2.type = "cover_blown";
        }
      }

      break;
  }

  return false;
}

function stealth_combat_music_init() {
  scripts\engine\utility::flag_wait("rappel_end");
  level.music_array[0] = "a";
  level.music_array[1] = "b";
  level.music_array[2] = "c";
  level.music_last_stealth_cue = "";
  level.player thread scripts\stealth\player::combatstate_thread();
  level.player scripts\stealth\player::combatstate_addupdatefunc("music", &stealth_combat_music_updatefunc);
  level.player.stealth.combatstate.maxcombatdist = 2000;
  level.stealth_combat_music_state = level.player.stealth.combatstate.name;
  level.stealth_combat_music_state_type = level.player.stealth.combatstate.type;
}

function stealth_combat_music_cleanup() {
  if(!isDefined(level.player.stealth)) {
    return;
  }

  if(!isDefined(level.player.stealth.combatstate)) {
    return;
  }

  level.player scripts\stealth\player::combatstate_removeupdatefunc("music");
  level.player scripts\stealth\player::combatstate_thread(0);
}

function stealth_combat_music_updatefunc(var0, var1) {
  level notify("stealth_combat_music_state_updated");
  level endon("stealth_combat_music_state_updated");

  if(var0 == "combat") {
    scripts\engine\utility::flag_set("player_in_combat");
  }

  wait 1.5;

  if(var0 == "stealth" && scripts\engine\utility::flag("player_in_combat")) {
    thread scripts\engine\sp\utility::flag_clear_delayed_endonset("player_in_combat", 0.5);
  }

  var2 = level.stealth_combat_music_state;
  var3 = level.stealth_combat_music_state_type;
  level.stealth_combat_music_state = var0;
  level.stealth_combat_music_state_type = var1;
  var4 = undefined;

  switch (var0) {
    case "combat":
      if(var2 != "combat") {
        self notify("entered_combat");
      } else if(var3 != "unaware") {
        return;
      }

      if(var1 == "aware") {
        var4 = "";
      } else {
        var4 = "mx_tmp_estate_combat_alert";
      }

      break;
    case "stealth":
      self notify("stop_disengage_nag_think");

      if(var2 != "combat") {
        return;
      }

      if(!scripts\engine\utility::flag("player_in_combat")) {
        return;
      }

      thread stealth_music_thread();
      break;
  }

  if(!isDefined(var4)) {
    return;
  }

  setmusicstate(var4);
}

function stealth_music_thread() {
  self endon("entered_combat");

  for(;;) {
    level.music_array = scripts\engine\utility::array_randomize(level.music_array);
    var0 = level.music_array[0];

    if(isDefined(level.music_last_stealth_cue) && level.music_last_stealth_cue == var0) {
      var0 = level.music_array[1];
    }

    if(isDefined(level.music_last_stealth_cue) && isDefined(level.hvts_identified)) {
      level.music_hvt_num = level.hvts_identified + 1;

      if(level.music_hvt_num < 1) {
        level.music_hvt_num = 1;
      }

      if(level.music_hvt_num > 3) {
        level.music_hvt_num = 3;
      }

      var1 = "mx_tmp_estate_stealth_" + level.music_hvt_num + var0;
      level.music_last_stealth_cue = var0;
    } else {
      var1 = "mx_tmp_estate_stealth_1a";
    }

    if(isDefined(var1)) {
      setmusicstate(var1);
    }

    wait 60;
    setmusicstate("");
    wait 40;
  }
}

function stealth_death_hints() {
  level.player waittill("death", var0);

  if(!isai(var0)) {
    return;
  }

  if(isDefined(level.player.stealth.hints.causeofdeath)) {
    return;
  }

  if(isDefined(level.custom_death_quote)) {
    return;
  }

  var1 = level.player getcurrentweapon();

  if((!isDefined(var1.extra) || !issubstr(var1.extra, "laser")) && var1.classname != "pistol" && level.player scripts\sp\nvg\nvg_player::is_nvg_on()) {
    scripts\sp\player_death::set_custom_death_quote(43);
    return;
  }

  var2 = [33, 35, 36, 37, 38, 40, 41, 42];

  if(level.player getstance() == "stand") {
    GscBinSkip0(0x2e, var2.size, 34);
  }

  if(level.player scripts\engine\utility::ent_flag("indoors")) {
    GscBinSkip0(0x2e, var2.size, 39);
  }

  if(level.player getplayerlightlevel() >= 0.5) {
    GscBinSkip0(0x2e, var2.size, 44);
  }

  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::random(var2));
}

function stealth_offhand_monitor() {
  for(;;) {
    level.player waittill("grenade_fire", var0, var1);
    thread offhand_explode_monitor(var0);
  }
}

function offhand_explode_monitor(var0) {
  self waittill("explode");

  if(var0 == "molotov") {
    level.last_molotov_explode_time = gettime();
    return;
  }

  level.last_flash_explode_time = gettime();
}

function stealth_visibility_in_darkness() {
  var0 = 130;
  var0 = 300;
  var0 = 500;
  GscBinSkip0(0x2e, "prone", 300);
}

function waittill_player_hidden() {
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

function fusebox_init(var0) {
  self.script_model = scripts\engine\utility::get_linked_ent();
  self.animnode = scripts\engine\sp\utility::get_linked_struct();
  self.script_model.animname = "fusebox";
  self.script_model scripts\engine\sp\utility::assign_animtree();
  self.interact_offset = self.script_model.origin + rotatevector((7, 4, 7), self.script_model.angles) - self.origin;
  self.use_dist_override = 50;

  if(issubstr(self.target, "church")) {
    self.location = "church";
  } else if(issubstr(self.target, "courtyard")) {
    self.location = "courtyard";
  } else if(issubstr(self.target, "pool")) {
    self.location = "pool";
  }

  self.animnode thread scripts\common\anim::anim_first_frame_solo(self.script_model, "fusebox_interact");
  thread disable_fuseboxes_on_grid();
  thread fusebox_damage_think(var0);
  thread lightsout_achievement_think();
}

function fusebox_damage_think(var0) {
  self.script_model.health = 50;
  self.script_model setCanDamage(1);

  while(self.script_model.health > 0) {
    self.script_model waittill("damage", var1, var2);

    if(istrue(var0) && var2 != level.player) {
      self.script_model.health += var1;
    }
  }

  self.destroyed = 1;

  if(self.script_light_switch_state) {
    scripts\sp\interactables\dynolight::lightswitch_toggle();
  }

  scripts\sp\interactables\dynolight::lightswitch_disable(1);

  if(isDefined(self.runner)) {
    self.runner notify("stop_turn_on_fusebox");
  }

  self stoploopsound(self.script_light_idle_sfx);
  playFX(scripts\engine\utility::getfx("vfx_electrical_control_box"), self.origin);
  playworldsound("fusebox_explosion", self.origin);
  self.script_model setModel("uk_electrical_box_medium_01_open");

  foreach(var4 in getscriptablearray(self.target, "targetname")) {
    if(var4.model == "dynlt_fusebox_light_led_01_off" && distancesquared(self.origin, var4.origin) < 10000) {
      var4 hide();
      break;
    }
  }

  radiusdamage(self.origin, 100, 100, 30, self);

  if(!scripts\engine\utility::flag("rappel_end") && self.target == "lights_bld_courtyard") {
    var6 = getEnt("vistawindows_courtyard", "targetname");

    if(isDefined(var6)) {
      var6 delete();
      return;
    }

    return;
  }
}

function disable_fuseboxes_on_grid() {
  self waittill("lightswitch_toggle");

  foreach(var1 in level.fuseboxes) {
    if(!scripts\engine\utility::is_equal(var1.target, self.target)) {
      continue;
    }

    if(var1.script_light_switch_state) {
      var1 scripts\sp\interactables\dynolight::lightswitch_toggle();
    }

    var1 scripts\sp\interactables\dynolight::lightswitch_disable(1);
  }
}

function fusebox_interact_anim() {
  if(!isDefined(self.animnode)) {
    return;
  }

  level.player.fusebox = self;
  level.player scripts\engine\utility::delaycall(0.2, &lerpfovscalefactor, 0, 0.5);
  level.player scripts\engine\utility::delaycall(0.2, &playsound, "scn_estate_fusebox_lever_off_plr");
  self.animnode scripts\sp\player_rig::link_player_to_rig("fusebox_interact", "stand", 1, 0.2, 0, 45, 45, 15, 15, 0, undefined, 1);
  self.animnode thread scripts\common\anim::anim_single([level.player_rig, self.script_model], "fusebox_interact");
  thread fusebox_interact_anim_unlink_player(level.player_rig);
  self.script_model waittill("handle_down");
  level.player lerpfovscalefactor(1, 0.5);
  wait 0.25;
}

function fusebox_interact_anim_unlink_player(var0) {
  var0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_end");
  scripts\engine\utility::waittill_any_ents(var0, "anim_end", level.player, "damage");
  scripts\sp\player_rig::unlink_player_from_rig(1);
  level.player.fusebox = undefined;
}

function fusebox_handle_down(var0) {
  var0 notify("handle_down");
}

function floodlights_init() {
  level.floodlight_controllers = scripts\engine\utility::getStructArray("floodlights_controller", "script_noteworthy");
  scripts\engine\utility::array_thread(level.floodlight_controllers, &scripts\engine\utility::delaythread, 0.1, &floodlight_controller_init);
  wait 0.15;
  var0 = getscriptablearray("mansionfloodlights", "targetname");
  level.floodlights = scripts\engine\utility::array_combine(level.floodlights, var0);
}

function floodlight_controller_init() {
  self.floodlights = [];
  var0 = scripts\engine\utility::get_linked_ents();

  foreach(var2 in var0) {
    switch (var2.script_noteworthy) {
      case "floodlight":
        self.floodlights[self.floodlights.size] = var2;
        var3 = spawnStruct();
        var3.script_radius = 1000;
        var3.script_type = "light_spot";
        var3.script_fov_inner = 50;
        var3.script_percent = 0.9;
        var3.angles = var2.angles;
        var2.data = var3;
        var2.alive = 1;
        var2.lightpos = var2 gettagorigin("tag_fx_bulb");
        var2.intensity = 1;
        var2.timeoflaststatechange = gettime();
        break;
      case "lightsource":
        self.lightsource = var2;
        break;
    }
  }

  self.lightsource setlightintensity(0);

  if(!isDefined(level.floodlights)) {
    level.floodlights = [];
  }

  level.floodlights = scripts\engine\utility::array_combine(level.floodlights, self.floodlights);
  level.castingdynolights = scripts\engine\utility::array_combine(level.castingdynolights, self.floodlights);
  self.baseintensity = self.lightsource.script_intensity;
  self.intensity = self.baseintensity;
  self.active = 0;
  scripts\engine\utility::array_thread(self.floodlights, &floodlight_death_watcher, self);
}

function floodlight_death_watcher(var0) {
  var0 endon("floodlights_off");
  self waittill("death");
  self.alive = 0;
  var0.floodlights = scripts\engine\utility::array_remove(var0.floodlights, self);

  if(var0.floodlights.size) {
    var0.intensity *= 0.35;
  } else {
    var0.intensity = 0;
  }

  if(!var0.active) {
    return;
  }

  var0.lightsource setlightintensity(var0.intensity);
  var1 = scripts\engine\utility::drop_to_ground(self.origin, 24, -256);
  var2 = scripts\engine\utility::get_array_of_closest(var1, getaiarray("axis"), undefined, undefined, 800);
  scripts\engine\utility::array_call(var2, &aieventlistenerevent, "light_killed", self, var1);
  level.floodlights = scripts\engine\utility::array_remove(level.floodlights, self);
}

function floodlight_blowout_think() {
  self.blowout = 0;
  wait 0.05 * (self getentitynumber() % 5 + 1);
  var0 = 0;
  var1 = 1;
  jumpiftrue(isDefined(self.fwd)) LOC_00000035;
  self.fwd = anglesToForward(self.angles);

  while(self getscriptablepartstate("onoff") == "on") {
    self.blowout = var0;

    if(!var1) {
      wait 0.2;
    }

    if(self getscriptablepartstate("onoff") != "on") {
      break;
    }

    var1 = 0;
    var0 = 0;
    var2 = level.player getEye();
    var3 = distancesquared(self.origin, var2);

    if(var3 > squared(1000)) {
      continue;
    }

    var4 = vectordot(self.fwd, vectorNormalize(var2 - self.origin));

    if(var4 < cos(50)) {
      continue;
    }

    var5 = (var4 - cos(50)) / (cos(10) - cos(50));

    if(!sighttracepassed(self.origin + self.fwd * 15, var2, 0, [self, level.player], 1)) {
      continue;
    }

    var6 = sqrt(var3);
    var7 = (var6 - 100) / 900;
    var7 = 1 - var7;
    var0 = var7 + var5;
    var0 = clamp(var0, 0, 0.99);
  }

  self.blowout = 0;
}

function floodlights_on() {
  foreach(var1 in self.floodlights) {
    if(var1 getscriptablepartstate("onoff") == "off") {
      var1 setscriptablepartstate("onoff", "on");
    }
  }

  self.lightsource setlightintensity(self.intensity);
  self.active = 1;
}

function floodlights_off() {
  self notify("floodlights_off");

  foreach(var1 in self.floodlights) {
    if(var1 getscriptablepartstate("onoff") == "on") {
      var1 setscriptablepartstate("onoff", "off");
    }
  }

  self.lightsource setlightintensity(0);
  self.active = 0;
}

function turn_on_floodlights() {
  var0 = getEnt("floodlightfusebox", "script_noteworthy");
  var0 scripts\sp\interactables\dynolight::lightswitch_toggle();
  scripts\engine\utility::array_thread(level.floodlight_controllers, &floodlights_on);
  scripts\engine\utility::array_thread(level.floodlights, &floodlight_blowout_think);
  thread floodlights_vision_think();
}

function turn_off_floodlights() {
  if(!isDefined(level.floodlights)) {
    level.floodlight_controllers = undefined;
    return;
  }

  var0 = getEnt("floodlightfusebox", "script_noteworthy");
  var0 scripts\sp\interactables\dynolight::lightswitch_toggle();
  var0 scripts\sp\interactables\dynolight::lightswitch_disable(1);
  scripts\engine\utility::array_thread(level.floodlight_controllers, &floodlights_off);
  level.floodlight_controllers = undefined;
  level.floodlights = undefined;
}

function floodlights_vision_think() {
  level.player.blowout = 0;

  while(isDefined(level.floodlights)) {
    var0 = scripts\engine\utility::get_array_of_closest(level.player getEye(), level.floodlights, undefined, undefined, 1000);
    var1 = 0;

    foreach(var3 in var0) {
      var1 += var3.blowout;

      if(var1 >= 1) {
        break;
      }
    }

    var1 = min(level.player getplayerlightlevel(), var1);
    level.player setnightvisionblindweight(var1);
    level.player.blowout = var1;
    waitframe();
  }

  level.player.blowout = undefined;
  level.player setnightvisionblindweight(0);
}

function anyone_in_combat(var0) {
  if(!scripts\engine\utility::flag("stealth_enabled")) {
    return false;
  }

  foreach(var2 in level.stealth.groupdata.groups) {
    if(isDefined(var0) && !scripts\engine\utility::array_contains(var0, var2.name)) {
      continue;
    }

    if(scripts\stealth\group::group_anyoneincombat(var2.name)) {
      return true;
    }
  }

  return false;
}

function anyone_in_hunt(var0) {
  if(!scripts\engine\utility::flag("stealth_enabled")) {
    return false;
  }

  foreach(var2 in level.stealth.groupdata.groups) {
    if(isDefined(var0) && !scripts\engine\utility::array_contains(var0, var2.name)) {
      continue;
    }

    if(scripts\stealth\group::group_anyoneincombat(var2.name)) {
      return false;
    }

    foreach(var4 in var2.members) {
      if(var4[[var4.fnisinstealthhunt]]()) {
        return true;
      }
    }
  }

  return false;
}

function anyone_has_known_player_since_time(var0, var1) {
  if(!scripts\engine\utility::flag("stealth_enabled")) {
    return false;
  }

  foreach(var3 in level.stealth.groupdata.groups) {
    if(isDefined(var1) && !scripts\engine\utility::array_contains(var1, var3.name)) {
      continue;
    }

    if(!scripts\stealth\group::group_anyoneincombat(var3.name)) {
      continue;
    }

    foreach(var5 in var3.members) {
      if(!var5[[var5.fnisinstealthcombat]]()) {
        continue;
      }

      if(!scripts\engine\utility::is_equal(var5.enemy, level.player)) {
        continue;
      }

      if(var5 lastknowntime(level.player) <= var0) {
        continue;
      }

      return true;
    }
  }

  return false;
}

function spawn_friendlies() {
  if(isDefined(level.friendlies)) {
    iprintln("Respawning all friendlies!");
  }

  level.friendlies = [];
  spawn_price();
  spawn_hadir();
}

function spawn_price() {
  if(isDefined(level.price)) {
    iprintln("Respawning Price!");
  }

  level.price = scripts\engine\sp\utility::spawn_script_noteworthy("price", 1);
  level.price.animname = "price";
  level.price.deathfunction = &friendly_death_func;

  if(!isDefined(level.friendlies)) {
    level.friendlies = [];
  }

  level.friendlies[level.friendlies.size] = level.price;
  level.price.name = "Captain Price";
  var0 = make_price_ar();
  level.price scripts\anim\shared::forceuseweapon(var0, "primary");
  level.cutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters", level.price.origin);
  level.price scripts\engine\sp\utility::set_grenadeweapon("flash");
  level.price scripts\engine\sp\utility::set_grenadeammo(4);
  level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
}

function make_price_rifle() {
  return scripts\sp\utility::make_weapon("iw8_ar_falima", ["barshort_falima", "laserir_bar", "silencer_east01", "snprscope_mike14_ar"]);
}

function make_price_ar() {
  return scripts\sp\utility::make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|0", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
}

function make_price_pistol(var0) {
  var1 = ["rec_papa320|1", "mag_papa320|1", "slide_papa320|1"];

  if(istrue(var0)) {
    GscBinSkip0(0x2e, var1.size, "silencerpstl_west01");
  }

  return scripts\sp\utility::make_weapon("iw8_pi_papa320", var1);
}

function spawn_hadir() {
  var0 = scripts\engine\sp\utility::spawn_targetname("hadir", 1);
  level.friendlies[level.friendlies.size] = var0;
  var0.deathfunction = &friendly_death_func;
  var0 scripts\common\ai::magic_bullet_shield(1);
  var0.animname = "ally1";
  var0.maxvisibledist = 8192;
  var0.team = "allies";
  level.hadir = var0;
  level.price scripts\engine\sp\utility::set_grenadeweapon("molotov");
  level.price scripts\engine\sp\utility::set_grenadeammo(4);
}

#using_animtree("");

function gesture_nvgs(var0) {
  var1 = % sdr_ges_nvg_raise_nvg;
  var2 = $sdr_ges_nvg_lower_nvg;
  self.visor_down = var0;

  if(var0) {
    if(!istrue(self.nvg_on)) {
      self.nvg_on = 1;
      thread ai_nvg_down(var1, var2);
      return;
    }

    return;
  }

  if(istrue(self.nvg_on)) {
    self.nvg_on = 0;
    thread ai_nvg_up(var1, var2);
    return;
  }
}

function ai_nvg_up(var0, var1) {
  var2 = self getanimweight(var1);

  if(var2 > 0) {
    self clearanim(var1, 0);
  }

  self setanim(var0, 1, 0, 1);
}

function ai_nvg_down(var0, var1) {
  var2 = self getanimweight(var0);

  if(var2 > 0) {
    self clearanim(var0, 0);
  }

  self setanim(var1, 1, 0, 1);
}

function friendly_death_func() {
  level.friendlies = scripts\engine\utility::array_remove(level.friendlies, self);

  if(isDefined(self.origin)) {
    playworldsound("generic_death_falling", self.origin);
  }

  return false;
}

function spawn_dead_body() {
  var0 = getspawner("dead_body_male", "targetname");
  var0.count++;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var1 notsolid();
  var1.origin = self.origin;
  var1.targetname = "dead_body";
  var1 scriptmoverdistancefade();
  var1.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
  return var1;
}

function get_closest_guy_by_path(var0, var1) {
  var2 = undefined;
  var3 = 1048576;
  var4 = [];

  foreach(var6 in var1) {
    if(isDefined(var6) && isalive(var6)) {
      if(distancesquared(var6.origin, var0) < var3) {
        var4 = var6;
      }
    }
  }

  if(var4.size > 0) {
    var2 = findclosestnonlospointwithinvolume(var4, var0);
  }

  return var2;
}

function try_indoor_save() {
  if(!level.player scripts\engine\utility::ent_flag("indoors")) {
    return;
  }

  level.player endon("indoors");
  wait 2;

  for(;;) {
    if(isDefined(level.lastsavetime)) {
      if(gettime() - level.lastsavetime < 5000) {
        wait 5;
      }
    }

    scripts\engine\sp\utility::autosave_by_name("escape_indoors");
    wait 10;
  }
}

function has_ceiling() {
  var0 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 0, 1, 0);
  return !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 1000), self, var0);
}

function delete_at_distance_to_player(var0, var1, var2) {
  var3 = squared(var1);

  while(distance2dsquared(level.player.origin, var0) < var3) {
    waitframe();
  }

  foreach(var5 in var2) {
    var5 delete();
  }
}

function waittill_player_stops_rotating_or_timeout(var0) {
  var1 = gettime();

  while(gettime() - var1 < var0 * 1000) {
    if(abs(level.player getnormalizedcameramovement()[1]) < 0.2) {
      return;
    }

    waitframe();
  }
}

function waittill_player_stops_rotating() {
  for(;;) {
    if(abs(level.player getnormalizedcameramovement()[1]) < 0.2) {
      return;
    }

    waitframe();
  }
}

function weapon_switch_monitor() {
  level.player endon("death");
  var0 = "MTSOPQRMRT";
  var1 = getdvarint(var0);
  var2 = ["none", "iw8_melee"];
  make_alias_group("nonsuppressed", ["dx_vom_pri_warning_silence_10", "dx_vom_pri_warning_silence_20", "dx_vom_pri_warning_silence_30"]);
  level.last_warned_weapon = "none";
  var3 = [];

  for(;;) {
    var4 = waittill_player_switched_weapons(var2);

    if(player_has_silencer(var4)) {
      if(var1) {
        setsaveddvar(var0, 0);
        var1 = 0;
      }
    } else {
      if(!var1) {
        setsaveddvar(var0, 1);
        var1 = 1;
      }

      if(should_warn_nonsuppressed(var4, var3)) {
        thread vo_warn_nonsuppressed(var4);
      }
    }

    var3 = level.player getweaponslistprimaries();
    level.player scripts\engine\utility::waittill_any("weapon_taken", "weapon_switch_started", "turret_mount", "turret_dismount");
  }
}

function should_warn_nonsuppressed(var0, var1) {
  if(!level.player scripts\engine\utility::ent_flag_exist("stealth_enabled")) {
    return false;
  }

  if(!level.player scripts\engine\utility::ent_flag("stealth_enabled")) {
    return false;
  }

  if(scripts\engine\utility::flag("stealth_spotted")) {
    return false;
  }

  if(isDefined(level.last_nonsuppressed_warning_time) && !scripts\engine\utility::time_has_passed(level.last_nonsuppressed_warning_time, 10)) {
    return false;
  }

  if(createheadicon(var0) == level.last_warned_weapon) {
    return false;
  }

  if(scripts\engine\utility::array_contains(var1, var0)) {
    return false;
  }

  return true;
}

function vo_warn_nonsuppressed(var0) {
  level.player endon("weapon_taken");
  level.player endon("weapon_switch_started");
  level.player endon("turret_mount");
  level.player endon("turret_dismount");
  var1 = get_next_alias_in_group("nonsuppressed", 1);

  if(isDefined(level.price) && isalive(level.price)) {
    while(istrue(level.price.speaking)) {
      wait 0.5;
    }

    thread price_line(var1);
  } else if(isDefined(level.overwatch_requests)) {
    var2 = 0;

    for(;;) {
      var2 = scripts\sp\maps\estate\estate_grounds::request_overwatch_vo("weapon", var1, 1, 0);

      if(var2) {
        break;
      }

      waitframe();
    }
  } else {
    level thread scripts\engine\sp\utility::smart_radio_dialogue(var1);
  }

  increment_alias_group_index("nonsuppressed");
  level.last_warned_weapon = createheadicon(var0);
  level.last_nonsuppressed_warning_time = gettime();
}

function waittill_player_switched_weapons(var0) {
  if(level.player isusingturret()) {
    level.player.was_using_turret = 1;
    return level.technical.mgturret[0] getturretweaponinfo();
  }

  if(istrue(level.player.was_using_turret)) {
    level.player.was_using_turret = undefined;
    return level.player getcurrentweapon();
  }

  var1 = level.player getcurrentweapon();

  for(var2 = var1; var2 == var1 || scripts\engine\utility::array_contains(var0, var2.basename); var2 = level.player getcurrentweapon()) {
    waitframe();
  }

  return var2;
}

function player_has_silencer(var0) {
  if(!isDefined(var0)) {
    var0 = level.player getcurrentweapon();
  }

  return var0 hasattachment("silenc", 1);
}

function nvg_exterior_monitor() {
  level.player endon("death");
  var0 = "indoors";

  while(!level.player scripts\engine\utility::ent_flag_exist(var0)) {
    waitframe();
  }

  for(;;) {
    if(level.player scripts\engine\utility::ent_flag(var0)) {
      setomnvar("ai_fulllight", 0.001);
      setomnvar("ai_nolight", 0.0005);
    } else {
      setomnvar("ai_fulllight", 0.0015);
      setomnvar("ai_nolight", 0.001);
    }

    level.player waittill(var0);
  }
}

function friendly_stealth_off() {
  scripts\engine\utility::ent_flag_clear("stealth_enabled");
  self.stealth = undefined;
  self.dontevershoot = 0;
  self.dontattackme = 0;
  self.maxvisibledist = 8192;
}

function sprint_when_needed() {
  self endon("death");

  for(;;) {
    self waittill("path_set");
    waittillframeend();
    thread sprint_to_goal();
  }
}

function sprint_to_goal() {
  self notify("check_should_sprint");
  self endon("check_should_sprint");
  var0 = self pathdisttogoal();

  if(var0 > 450 && !istrue(self.sprint)) {
    scripts\engine\sp\utility::enable_sprint();
  } else if(var0 < 450 && istrue(self.sprint)) {
    scripts\engine\sp\utility::disable_sprint();
  }

  self waittill("goal");
  scripts\engine\sp\utility::disable_sprint();
}

function stop_fighting_with_player() {
  self notify("stop_fight_with_player");
  self.fighting_with_player = undefined;
}

function fight_with_player(var0, var1) {
  self endon("death");
  self endon("stop_fight_with_player");
  self.fighting_with_player = 1;
  self.fixednode = 0;

  if(!isDefined(var0)) {
    var0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname");
  }

  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 350);

  for(;;) {
    self.goalradius = 350;
    var2 = var0.origin;

    while(distancesquared(self.origin, var2) > squared(200)) {
      var3 = scripts\engine\sp\utility::get_closest_to_player_view(getaiarray("axis"));

      if(!isDefined(var3)) {
        var3 = var0;
      }

      var4 = vectortoangles(var3.origin - level.player.origin);
      var4 += (0, randomfloatrange(-30, 30), 0);
      var2 = level.player.origin + anglesToForward(var4) * var1;
      var5 = getclosestpointonnavmesh(var2);
      self setgoalpos(var5);
      waitframe();
      var6 = self findbestcovernode(undefined, 0, var3.origin, 0);

      if(isDefined(var6)) {
        self setgoalnode(var6);
      }

      wait 2;
    }

    self.goalradius = 600;
    level.player scripts\engine\sp\utility::waittill_out_of_range(level.player.origin, 150, 0.25);
    waitframe();
  }
}

function color_trig_touching() {
  if(self.classname == "info_volume") {
    return;
  }

  self endon("stop_color_trig_touching");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);
    var1 = 0;

    if(!isDefined(var0.current_color_trig)) {
      var1 = 1;
    } else if(isDefined(var0.current_color_trig)) {
      if(var0.current_color_trig != self) {
        var1 = 1;
      }
    }

    if(!var1) {
      continue;
    }

    var0.current_color_trig = self;
    var0 notify("new_color_trig");

    foreach(var3 in level.friendlies) {
      if(isDefined(var3.fighting_with_player)) {
        if(!istrue(var3.move_override)) {
          stop_fighting_with_player(var3);
          var3 scripts\engine\sp\utility::enable_ai_color();
        }
      }
    }

    thread monitor_no_colors(var0);
  }
}

function monitor_no_colors(var0) {
  self endon("new_color_trig");
  var0 endon("death");

  while(self istouching(var0)) {
    wait 0.05;
  }

  while(self getnormalizedmovement() == (0, 0, 0)) {
    wait 0.05;
  }

  wait 5;
  scripts\engine\utility::array_thread(level.friendlies, &ai_use_scripted_navigation);
}

function ai_clear_all_navigation() {
  self notify("stop_color_trig_touching");
  stop_fighting_with_player();
  scripts\engine\sp\utility::clear_force_color();
  self.move_override = undefined;
}

function ai_use_scripted_navigation() {
  if(istrue(self.move_override)) {
    return;
  }

  scripts\engine\sp\utility::clear_force_color();
  thread fight_with_player();
}

function notetrack_nag(var0, var1) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var3 in var1) {
    level endon(var3);
  }

  for(;;) {
    foreach(var6 in var0) {
      level waittill("nag");
      thread price_line(var6);
    }
  }
}

function nags_til_notify(var0, var1, var2, var3) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var5 in var1) {
    level endon(var5);
  }

  if(!istrue(var2) && var0.size > 1) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  jumpiffalse(isDefined(var3)) LOC_00000055;
  wait var3;

  for(;;) {
    foreach(var8 in var0) {
      scripts\engine\sp\utility::smart_dialogue(var8);
      wait randomintrange(8, 13);
    }
  }
}

function delete_noteworthy_ents(var0) {
  wait 1;
  var1 = getEntArray(var0, "script_noteworthy");

  if(var1.size) {
    scripts\engine\utility::array_call(var1, &delete);
    return;
  }
}

function cleanup_all_dropped_loot() {
  if(isDefined(level.loot) && isDefined(isDefined(level.loot.items)) && istrue(level.loot.items.size)) {
    foreach(var1 in level.loot.items) {
      if(scripts\sp\loot::itemworldplaced(var1)) {
        continue;
      }

      var1 scripts\sp\loot::cleanuplootitem();
    }

    return;
  }
}

function reactive_foliage_low() {
  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.reactivefoliagestate = "low";
  level.lerpingreactivefoliage = 1;
  var0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.6, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 0.3, var0);
  wait var0;
  level.lerpingreactivefoliage = undefined;
}

function reactive_foliage_med() {
  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.lerpingreactivefoliage = 1;
  level.reactivefoliagestate = "med";
  var0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.6, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 0.7, var0);
  wait var0;
  level.lerpingreactivefoliage = undefined;
}

function reactive_foliage_high() {
  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.lerpingreactivefoliage = 1;
  level.reactivefoliagestate = "high";
  var0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.6, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 1.3, var0);
  wait var0;
  level.lerpingreactivefoliage = undefined;
}

function laser_discipline() {
  self endon("death");
  self endon("stop_laser_discipline");
  waitframe();

  if(isDefined(self.ridingvehicle)) {
    self waittill("jumpedout");
  }

  var0 = 0;
  var1 = cos(10);
  self.a.laseron = 0;
  var2 = 0.6;

  for(;;) {
    while(nullweapon(self.weapon) || !isDefined(self.enemy)) {
      wait 0.25;
    }

    var0 = is_aimed_at_enemy(var1);

    if(var0) {
      if(!self.a.laseron) {
        self.a.laseron = 1;
        self laseralton();
        wait 0.5 + randomfloat(1);
        self.a.laseron = 0;
        self laseraltoff();
        wait 5 + randomfloat(2);
      }
    }

    wait var2;
  }
}

function is_aimed_at_enemy(var0) {
  if(isDefined(self.enemy) && isalive(self.enemy)) {
    var1 = ["j_mainroot", "j_spine4", "tag_eye"];

    foreach(var3 in var1) {
      if(!nullweapon(self.weapon) && isalive(self.enemy) && scripts\engine\utility::within_fov(self.origin, self gettagangles("tag_flash"), self.enemy gettagorigin(var3), var0)) {
        return true;
      }
    }
  }

  return false;
}

function can_i_see_an_enemy_or_can_enemies_see_me() {
  foreach(var1 in getaiarray("axis")) {
    if(self cansee(var1)) {
      return true;
    }

    if(var1 cansee(self)) {
      return true;
    }
  }

  return false;
}

function abs_int(var0) {
  return int(abs(var0));
}

function make_alias_group(var0, var1) {
  if(isDefined(level.alias_groups)) {}

  var2 = spawnStruct();
  var2.aliases = var1;
  var2.index = 0;
  level.alias_groups[var0] = var2;
}

function alias_group_exists(var0) {
  return isDefined(level.alias_groups[var0]);
}

function clear_alias_group(var0) {
  level.alias_groups[var0] = undefined;
}

function get_next_alias_in_group(var0, var1) {
  var2 = level.alias_groups[var0];
  var3 = var2.aliases[var2.index];

  if(!istrue(var1)) {
    increment_alias_group_index(var2);
  }

  return var3;
}

function increment_alias_group_index(var0) {
  if(isstring(var0)) {
    var0 = level.alias_groups[var0];
  }

  var0.index++;

  if(var0.index >= var0.aliases.size) {
    var0.index = 0;
    return;
  }
}

function lightsout_achievement_think() {
  level endon("obj_scene_started");
  level endon("lightsout_achievement_get");
  self waittill("lightswitch_toggle");

  if(istrue(self.noachievement)) {
    return;
  }

  if(isDefined(level.lightsout_targets) && scripts\engine\utility::array_contains(level.lightsout_targets, self.target)) {
    return;
  }

  if(!isDefined(level.lightsout_targets)) {
    level.lightsout_targets = [];
  }

  level.lightsout_targets[level.lightsout_targets.size] = self.target;

  if(level.lightsout_targets.size >= 4) {
    scripts\sp\utility::giveachievement_wrapper("lightsout");
    level notify("lightsout_achievement_get");
    return;
  }
}

function ownthenight_achievement_think() {
  level endon("obj_scene_started");
  level endon("backup_spawned");
  var0 = ["church_east_spawner", "church_west_spawner", "church_interior_spawner", "church_interrogator_spawner", "courtyard_north_spawner", "courtyard_south_spawner", "courtyard_east_spawner", "courtyard_east_upper_spawner", "courtyard_west_spawner", "courtyard_west_upper_spawner", "courtyard_interrogator_spawner", "pool_east_spawner", "pool_west_spawner", "pool_interior_spawner", "pool_interrogator_spawner"];
  level.ownthenight_spawners = [];

  foreach(var2 in var0) {
    var3 = getspawnerarray(var2);
    var4 = var3;
    var6 = getfirstarraykey(var4);

    if(isDefined(var6)) {
      var5 = var4[var6];
      GscBinSkip4(0x6e, var5);
    }

    var4 = undefined;
    var6 = undefined;
    level.ownthenight_spawners = scripts\engine\utility::array_combine(level.ownthenight_spawners, var3);
  }

  level.ownthenight_deathcount = 0;
  level waittill("we_own_the_night");
  scripts\sp\utility::giveachievement_wrapper("ownthenight");
  level.ownthenight_deathcount = undefined;
  level.ownthenight_spawners = undefined;
}

function ownthenight_spawner_think(var0) {
  jumpiffalse(isDefined(var0)) LOC_0000002e;

  foreach(var2 in var0) {
    level endon(var2);
  }

  for(;;) {
    var4 = waittill_spawned();

    if(!isDefined(var4)) {
      level.ownthenight_spawners = scripts\engine\utility::array_remove(level.ownthenight_spawners, self);

      if(level.ownthenight_deathcount >= level.ownthenight_spawners.size) {
        level notify("we_own_the_night");
      }

      return;
    }

    var4 waittill("death");
    waitframe();

    if(!isDefined(self.suspended_ai)) {
      break;
    }
  }

  level.ownthenight_deathcount++;

  if(level.ownthenight_deathcount >= level.ownthenight_spawners.size) {
    level notify("we_own_the_night");
    return;
  }
}

function waittill_spawned() {
  jumpiffalse(scripts\engine\utility::is_equal(self.script_parameters, "stealth_spawn_only")) LOC_00000040;
  var0 = strtok(self.script_stealthgroup, "_")[0];

  if(scripts\engine\utility::flag(var0 + "_gone_hot")) {
    return undefined;
  }

  level endon(var0 + "_gone_hot");
  self waittill("spawned", var1);
  return var1;
}

function lerp_fov_over_distance_trigger() {
  var0 = strtok(self.script_parameters, " ");
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\utility::getStruct(var3, "targetname");
  }

  var5 = float(var1[0].script_parameters);
  var6 = float(var1[1].script_parameters);
  var7 = distance(var1[0].origin, var1[1].origin);

  for(;;) {
    if(!level.player istouching(self)) {
      self waittill("trigger");
    }

    while(level.player istouching(self)) {
      var8 = pointonsegmentnearesttopoint(var1[0].origin, var1[1].origin, level.player.origin);
      var9 = scripts\engine\math::normalize_value(0, var7, distance(var1[0].origin, var8));
      var10 = scripts\engine\math::factor_value(var5, var6, var9);
      level.player modifybasefov(var10, 0.05);

      if(level.player adsButtonPressed()) {
        wait 0.3;
      } else {
        level.player modifybasefov(var10, 0.05);
      }

      waitframe();
    }
  }
}