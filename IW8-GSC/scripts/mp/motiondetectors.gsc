/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\motiondetectors.gsc
***********************************************/

function init() {
  precachemodel("uk_electrical_box_medium_02_animated");
  precachemodel("uk_storage_wall_light_01");
  precachemodel("uk_storage_wall_light_01_on");
  precachemodel("uk_industrial_light_01");
  precachemodel("uk_industrial_light_01_on");
  precachemodel("p7_lights_cagelight02");
  precachemodel("p7_lights_cagelight02_on");
  precachemodel("uk_lighting_interior_office_ceiling_tile_01");
  precachemodel("uk_lighting_interior_office_ceiling_tile_01_on");
  precachemodel("uk_industrial_light_01_runner_pm");
  precachemodel("uk_industrial_light_01_runner_pm_on");
  precachemodel("ind_flood_light_standing_tall");
  precachemodel("ind_flood_light_standing_tall_on");
  precachemodel("rogue_dormitory_lobby_ceiling_light_01");
  precachemodel("rogue_dormitory_lobby_ceiling_light_01_on");
  precachemodel("light_ceiling_bulb_02_spear_pm");
  precachemodel("light_ceiling_bulb_02_spear_pm_on");
  precachemodel("me_light_ceiling_fluorescent_tube_strong_runner_pm");
  precachemodel("me_light_ceiling_fluorescent_tube_strong_runner_pm_on");
  precachemodel("me_light_ceiling_fluorescent_tube_spear_pm");
  precachemodel("me_light_ceiling_fluorescent_tube_spear_pm_on");
  precachemodel("lighting_fixtures_security_lamp_withcage_01_spear_pm");
  precachemodel("lighting_fixtures_security_lamp_withcage_01_spear_pm_on");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_spear_pm");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_spear_pm_on");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_on_green_rnr_pm");
  precachemodel("building_cable_post_light_pole_off_spear_pm");
  precachemodel("building_cable_post_light_pole_on_spear_pm");
  precachemodel("ee_electronics_television_wall_mounted_large_runner_pm");
  precachemodel("ee_electronics_television_wall_mounted_large_runner_pm_on");
  level._effect["vfx_nvg_flare"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_nvg_flare.vfx");
  level._effect["vfx_nvg_flare_light_250"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_nvg_flare_light_250.vfx");
  thread motiondetectors();
  script_model_anims();
}

#using_animtree("");

function script_model_anims() {
  level.scr_animtree["lightswitch"] = #animtree;
  level.scr_anim["lightswitch"]["interact"] = $wm_eq_fusebox_plr;
  level.scr_animname["lightswitch"]["interact"] = "wm_eq_fusebox_plr";
  level.scr_eventanim["lightswitch"]["interact"] = "eq_fusebox_plr";
  level.scr_anim["lightswitch"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_animname["lightswitch"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level.scr_eventanim["lightswitch"]["interact_on"] = "eq_fusebox_turn_on_plr";
  level.scr_animtree["switch"] = #animtree;
  level.scr_anim["switch"]["interact"] = % wm_eq_fusebox_prop;
  level.scr_animname["switch"]["interact"] = "wm_eq_fusebox_prop";
  level.scr_anim["switch"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level.scr_animname["switch"]["interact_on"] = "wm_eq_fusebox_turn_on_prop";
  level.interactionanimlength = getanimlength(level.scr_anim["lightswitch"]["interact"]);
}

function motiondetectors() {
  wait 5;
  var_0 = getEntArray("md_volume", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::get_target_array();
    thread motiondetectionproc(var_2);
  }
}

function lightonroutine(var_0, var_1) {
  wait var_0;

  if(self.code_classname == "light") {
    if(!isDefined(self.savedintensity)) {
      var_2 = 50;
    } else {
      var_2 = self.savedintensity;
    }

    self setlightintensity(var_2 * 0.7);
    thread scripts\engine\utility::play_sound_in_space("mp_lights_int_on", self.origin);
    wait 0.1;
    thread scripts\engine\utility::play_loop_sound_on_entity("mp_lights_int_on_loop");
    self setlightintensity(var_2 * 0.1);
    wait 0.05;
    self setlightintensity(var_2 * 0.4);
    wait 0.1;
    self setlightintensity(var_2 * 0.2);
    wait 0.15;
    self setlightintensity(var_2);
    return;
  }

  if(self.code_classname == "scriptable") {
    self setscriptablepartstate("light", "light_on");
    return;
  }
}

function lightoffroutine(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.code_classname == "light") {
      var_3 setlightintensity(0);
      var_3 thread scripts\engine\utility::play_sound_in_space("mp_lights_int_off", var_3.origin);
      var_3 notify("stop soundmp_lights_int_on_loop");
      continue;
    }

    if(var_3.code_classname == "scriptable") {
      var_3 setscriptablepartstate("light", "power_off");
    }
  }
}

function motiondetectionproc(var_0) {
  level endon("game_ended");
  var_1 = spawnStruct();
  var_1.active = undefined;
  var_1.masterswitches = [];
  var_1.lights = [];
  var_1.models = [];
  var_1.nvglights = [];
  var_1.switchstatus = "motion";
  var_1.lightson = 0;
  var_1.detection = 0;
  var_1.triggerblind = undefined;

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "light") {
      var_1.lights[var_1.lights.size] = var_3;
      continue;
    }

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "masterSwitch") {
      var_1.masterswitches[var_1.masterswitches.size] = var_3;
      continue;
    }

    if(var_3.code_classname == "script_model" && !isDefined(var_3.script_parameters)) {
      var_1.models[var_1.models.size] = var_3;
      continue;
    }

    if(var_3.code_classname == "script_origin") {
      var_1.nvglights[var_1.nvglights.size] = var_3;
      continue;
    }

    if(isDefined(var_3.script_label) && var_3.script_label == "blinding_volume") {
      var_1.triggerblind = var_3;
    }
  }

  var_5 = getscriptablearray(self.target, "targetname");
  var_1.lights = scripts\engine\utility::array_combine(var_1.lights, var_5);

  foreach(var_7 in var_1.lights) {
    if(var_7.code_classname == "light") {
      var_7.savedintensity = var_7 getlightintensity();
      var_7 setlightintensity(0);
      continue;
    }

    if(var_7.code_classname == "scriptable") {
      var_7 setscriptablepartstate("light", "power_off");
    }
  }

  foreach(var_10 in var_1.masterswitches) {
    thread runlightswitch(var_10, self);
  }

  foreach(var_13 in var_1.models) {
    var_13.modelname = var_13.model;
  }

  if(scripts\mp\utility\game::getgametype() == "cyber") {
    if(!isDefined(level.emplights)) {
      level.emplights = [];
    }

    level.emplights = scripts\engine\utility::array_add(level.emplights, var_1);

    if(isDefined(level.emplightsoff)) {
      level thread[[level.emplightsoff]]();
    }
  }

  thread onoffmodelswap(var_1.models, "off");
  thread motiondetectionstatus(var_1);

  for(;;) {
    if(var_1.switchstatus == "on") {
      self notify("masterSwitch_on");

      if(!var_1.lightson) {
        thread blindplayers(var_1);

        foreach(var_7 in var_1.lights) {
          thread lightonroutine(var_7, randomfloat(0.2));
        }

        thread onoffmodelswap(var_1.models, "on");
        var_1.lightson = 1;
      }
    } else if(var_1.switchstatus == "motion") {
      if(var_1.detection && !var_1.lightson) {
        thread blindplayers(var_1);

        foreach(var_7 in var_1.lights) {
          thread lightonroutine(var_7, randomfloat(0.2));
          var_1.lightson = 1;
        }

        thread onoffmodelswap(var_1.models, "on");
        thread motiondetectioncooldown(var_1);
      }
    } else if(var_1.switchstatus == "off") {
      if(var_1.lightson) {
        lightoffroutine(level, var_1.lights, var_1.nvglights);
        thread onoffmodelswap(var_1.models, "off");
        var_1.lightson = 0;
      }

      if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
        var_1.switchstatus = "motion";
      }

      self notify("lights_off");
    }

    wait 0.05;
  }
}

function blindplayers(var_0) {
  if(isDefined(var_0.triggerblind)) {
    wait 0.4;

    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !scripts\mp\utility\player::isreallyalive(var_2)) {
        continue;
      }

      if(var_2 istouching(var_0.triggerblind)) {
        var_2 activatenightvisionblind();
        continue;
      }

      foreach(var_4 in var_0.lights) {
        if(distancesquared(var_4.origin, var_2.origin) > 230400) {
          continue;
        }

        if(!scripts\engine\utility::within_fov(var_2 getEye(), var_2 getplayerangles(), var_4.origin, 0.707106)) {
          continue;
        }

        var_5 = scripts\engine\trace::ray_trace(var_2 getEye(), var_4.origin, undefined, scripts\engine\trace::create_default_contents(1));

        if(distancesquared(var_5["position"], var_4.origin) <= 324) {
          var_2 activatenightvisionblind();
          break;
        }
      }
    }

    return;
  }
}

function nameplatemanagement(var_0) {
  level endon("game_ended");

  for(;;) {
    if(var_0.lightson == 0) {
      foreach(var_2 in level.players) {
        if(var_2 istouching(self)) {
          thread manageplayerindarkvolume(var_2, self);
        }
      }
    }

    wait 0.1;
  }
}

function manageplayerindarkvolume(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(self.indarkvolume)) {
    return;
  }

  scripts\mp\utility\perk::giveperk("specialty_spygame");
  self.indarkvolume = 1;

  while(self istouching(var_0) && var_1.lightson == 0) {
    wait 0.1;
  }

  scripts\mp\utility\perk::removeperk("specialty_spygame");
  self.indarkvolume = undefined;
}

function motiondetectionstatus(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0.detection = 0;

    foreach(var_2 in level.players) {
      if(var_2 istouching(self)) {
        if(var_2 getstance() == "stand" && length2d(var_2 getvelocity()) > 40) {
          var_0.detection = 1;
          var_0.cooldown = 4;
        }

        if(var_0.lightson) {
          var_2.inmotionlight = 1;
        }
      }
    }

    wait 0.05;
  }
}

function motiondetectioncooldown(var_0) {
  level endon("game_ended");
  self endon("lights_off");
  self endon("masterSwitch_on");

  if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
    while(var_0.cooldown > 0) {
      wait 0.1;
      var_0.cooldown -= 0.1;
    }
  }

  var_0.switchstatus = "off";
}

function runlightswitch(var_0, var_1) {
  level endon("game_ended");
  var_2 = createlightswitchtrigger(var_0, var_1);

  if(isDefined(var_2)) {
    thread watchlightswitchuse(var_2);
    return;
  }
}

function createlightswitchtrigger(var_0, var_1) {
  var_2 = spawn("script_model", self.origin, 40, 0, 60);
  var_2 setModel("uk_electrical_box_medium_02_animated");
  var_2.angles = self.angles;

  if(self.script_parameters == "motion") {
    return;
  }

  var_3 = scripts\engine\utility::get_target_array();

  foreach(var_5 in var_3) {
    if(var_5.code_classname == "script_origin") {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "sceneNode") {
        var_2.scenenode = var_5;
      } else {
        var_2.hintlightmodel = spawn("script_model", var_5.origin);
        var_2.hintlightmodel.angles = var_5.angles;
        var_2.hintlightmodel setModel(var_5.script_noteworthy);
        var_2.hintlightmodel.modelname = var_5.script_noteworthy;
      }

      continue;
    }

    if(var_5.code_classname == "light") {
      var_2.hintlight = var_5;
    }
  }

  var_2 setuserange(80);
  var_2 sethintdisplayrange(200);
  var_2 setusefov(120);
  var_2 sethintdisplayfov(120);
  var_2 setCursorHint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_2 setHintString(&"MP/LIGHT_SWITCH");
    var_2 sethinticon("icon_electrical_box");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_2 setusepriority(0);
    var_2 makeusable();
  }

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "motion") {
    var_1.switchstatus = "motion";
  } else {
    var_1.switchstatus = "off";
  }

  foreach(var_8 in level.players) {
    var_2 enableplayeruse(var_8);
  }

  if(isDefined(var_2.hintlightmodel) && isDefined(var_2.hintlight)) {
    var_2.hintlightcolor = var_2.hintlight getlightintensity();
    thread manageswitchhintlight(var_2);
  }

  return var_2;
}

function watchlightswitchuse(var_0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(isDefined(var_0.switchstatus) && var_0.switchstatus == "on") {
      playsoundatpos(self.origin, "mp_fusebox_lever_off_npc");
    } else {
      playsoundatpos(self.origin, "mp_fusebox_lever_on_npc");
    }

    thread swapswitchstatus(getanimlength(level.scr_anim["lightswitch"]["interact"]) - 0.15, var_0);
    var_2 = lightswitchinteraction(var_1, var_0);

    if(!var_2) {
      self notify("interactionCancelled");
    }
  }
}

function swapswitchstatus(var_0, var_1) {
  self endon("interactionCancelled");
  wait var_0;

  if(var_1.switchstatus == "motion" || var_1.switchstatus == "off") {
    var_1.switchstatus = "on";
    self notify("masterSwitch_on");
    return;
  }

  var_1.switchstatus = "off";
}

function manageswitchhintlight(var_0) {
  level endon("game_ended");

  for(;;) {
    if(var_0.switchstatus == "on") {
      self.hintlight setlightintensity(0);
      self.hintlightmodel setModel(self.hintlightmodel.modelname);
    } else {
      self.hintlight setlightintensity(self.hintlightcolor);
      self.hintlightmodel setModel(self.hintlightmodel.modelname + "_on");
    }

    waitframe();
  }
}

function getlightswitchstatus(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.switchstatus) && var_2.switchstatus == "on") {
      return "on";
    }
  }

  return "motion";
}

function onoffmodelswap(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_1 == "on") {
      var_3 setModel(var_3.modelname + "_on");
      continue;
    }

    var_3 setModel(var_3.modelname);

    if(isDefined(var_3.flare)) {
      var_3.flare delete();
    }
  }
}

function lightswitchinteraction(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1.switchstatus == "on", "interact", "interact_on");
  var_3 = scripts\engine\utility::ter_op(var_1.switchstatus == "on", "lights_on", "lights_off");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, var_3);
  self.animname = "switch";
  self useanimtree(#animtree);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, var_2);
  var_4 = getanimlength(level.scr_anim["lightswitch"][var_2]);
  wait var_4;
  setDvar("NMLOKNMRSK", 0);
  self notify("interaction_complete");
  return true;
}

function watchplayerdeath(var_0) {
  self endon("interaction_complete");
  self.cancelinteraction = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      self.cancelinteraction = 1;
      break;
    }

    waitframe();
  }
}

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0.player_rig = spawn("script_model", var_0.origin);
  var_0.player_rig setModel(var_2);
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143a5("remove_rig", "death_or_disconnect");
}