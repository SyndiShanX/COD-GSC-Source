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
  var0 = getEntArray("md_volume", "script_noteworthy");

  foreach(var2 in var0) {
    var3 = var2 scripts\engine\utility::get_target_array();
    thread motiondetectionproc(var2);
  }
}

function lightonroutine(var0, var1) {
  wait var0;

  if(self.code_classname == "light") {
    if(!isDefined(self.savedintensity)) {
      var2 = 50;
    } else {
      var2 = self.savedintensity;
    }

    self setlightintensity(var2 * 0.7);
    thread scripts\engine\utility::play_sound_in_space("mp_lights_int_on", self.origin);
    wait 0.1;
    thread scripts\engine\utility::play_loop_sound_on_entity("mp_lights_int_on_loop");
    self setlightintensity(var2 * 0.1);
    wait 0.05;
    self setlightintensity(var2 * 0.4);
    wait 0.1;
    self setlightintensity(var2 * 0.2);
    wait 0.15;
    self setlightintensity(var2);
    return;
  }

  if(self.code_classname == "scriptable") {
    self setscriptablepartstate("light", "light_on");
    return;
  }
}

function lightoffroutine(var0, var1) {
  foreach(var3 in var0) {
    if(var3.code_classname == "light") {
      var3 setlightintensity(0);
      var3 thread scripts\engine\utility::play_sound_in_space("mp_lights_int_off", var3.origin);
      var3 notify("stop soundmp_lights_int_on_loop");
      continue;
    }

    if(var3.code_classname == "scriptable") {
      var3 setscriptablepartstate("light", "power_off");
    }
  }
}

function motiondetectionproc(var0) {
  level endon("game_ended");
  var1 = spawnStruct();
  var1.active = undefined;
  var1.masterswitches = [];
  var1.lights = [];
  var1.models = [];
  var1.nvglights = [];
  var1.switchstatus = "motion";
  var1.lightson = 0;
  var1.detection = 0;
  var1.triggerblind = undefined;

  foreach(var3 in var0) {
    if(var3.code_classname == "light") {
      var1.lights[var1.lights.size] = var3;
      continue;
    }

    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "masterSwitch") {
      var1.masterswitches[var1.masterswitches.size] = var3;
      continue;
    }

    if(var3.code_classname == "script_model" && !isDefined(var3.script_parameters)) {
      var1.models[var1.models.size] = var3;
      continue;
    }

    if(var3.code_classname == "script_origin") {
      var1.nvglights[var1.nvglights.size] = var3;
      continue;
    }

    if(isDefined(var3.script_label) && var3.script_label == "blinding_volume") {
      var1.triggerblind = var3;
    }
  }

  var5 = getscriptablearray(self.target, "targetname");
  var1.lights = scripts\engine\utility::array_combine(var1.lights, var5);

  foreach(var7 in var1.lights) {
    if(var7.code_classname == "light") {
      var7.savedintensity = var7 getlightintensity();
      var7 setlightintensity(0);
      continue;
    }

    if(var7.code_classname == "scriptable") {
      var7 setscriptablepartstate("light", "power_off");
    }
  }

  foreach(var10 in var1.masterswitches) {
    thread runlightswitch(var10, self);
  }

  foreach(var13 in var1.models) {
    var13.modelname = var13.model;
  }

  if(scripts\mp\utility\game::getgametype() == "cyber") {
    if(!isDefined(level.emplights)) {
      level.emplights = [];
    }

    level.emplights = scripts\engine\utility::array_add(level.emplights, var1);

    if(isDefined(level.emplightsoff)) {
      level thread[[level.emplightsoff]]();
    }
  }

  thread onoffmodelswap(var1.models, "off");
  thread motiondetectionstatus(var1);

  for(;;) {
    if(var1.switchstatus == "on") {
      self notify("masterSwitch_on");

      if(!var1.lightson) {
        thread blindplayers(var1);

        foreach(var7 in var1.lights) {
          thread lightonroutine(var7, randomfloat(0.2));
        }

        thread onoffmodelswap(var1.models, "on");
        var1.lightson = 1;
      }
    } else if(var1.switchstatus == "motion") {
      if(var1.detection && !var1.lightson) {
        thread blindplayers(var1);

        foreach(var7 in var1.lights) {
          thread lightonroutine(var7, randomfloat(0.2));
          var1.lightson = 1;
        }

        thread onoffmodelswap(var1.models, "on");
        thread motiondetectioncooldown(var1);
      }
    } else if(var1.switchstatus == "off") {
      if(var1.lightson) {
        lightoffroutine(level, var1.lights, var1.nvglights);
        thread onoffmodelswap(var1.models, "off");
        var1.lightson = 0;
      }

      if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
        var1.switchstatus = "motion";
      }

      self notify("lights_off");
    }

    wait 0.05;
  }
}

function blindplayers(var0) {
  if(isDefined(var0.triggerblind)) {
    wait 0.4;

    foreach(var2 in level.players) {
      if(!isDefined(var2) || !scripts\mp\utility\player::isreallyalive(var2)) {
        continue;
      }

      if(var2 istouching(var0.triggerblind)) {
        var2 activatenightvisionblind();
        continue;
      }

      foreach(var4 in var0.lights) {
        if(distancesquared(var4.origin, var2.origin) > 230400) {
          continue;
        }

        if(!scripts\engine\utility::within_fov(var2 getEye(), var2 getplayerangles(), var4.origin, 0.707106)) {
          continue;
        }

        var5 = scripts\engine\trace::ray_trace(var2 getEye(), var4.origin, undefined, scripts\engine\trace::create_default_contents(1));

        if(distancesquared(var5["position"], var4.origin) <= 324) {
          var2 activatenightvisionblind();
          break;
        }
      }
    }

    return;
  }
}

function nameplatemanagement(var0) {
  level endon("game_ended");

  for(;;) {
    if(var0.lightson == 0) {
      foreach(var2 in level.players) {
        if(var2 istouching(self)) {
          thread manageplayerindarkvolume(var2, self);
        }
      }
    }

    wait 0.1;
  }
}

function manageplayerindarkvolume(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(self.indarkvolume)) {
    return;
  }

  scripts\mp\utility\perk::giveperk("specialty_spygame");
  self.indarkvolume = 1;

  while(self istouching(var0) && var1.lightson == 0) {
    wait 0.1;
  }

  scripts\mp\utility\perk::removeperk("specialty_spygame");
  self.indarkvolume = undefined;
}

function motiondetectionstatus(var0) {
  level endon("game_ended");

  for(;;) {
    var0.detection = 0;

    foreach(var2 in level.players) {
      if(var2 istouching(self)) {
        if(var2 getstance() == "stand" && length2d(var2 getvelocity()) > 40) {
          var0.detection = 1;
          var0.cooldown = 4;
        }

        if(var0.lightson) {
          var2.inmotionlight = 1;
        }
      }
    }

    wait 0.05;
  }
}

function motiondetectioncooldown(var0) {
  level endon("game_ended");
  self endon("lights_off");
  self endon("masterSwitch_on");

  if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
    while(var0.cooldown > 0) {
      wait 0.1;
      var0.cooldown -= 0.1;
    }
  }

  var0.switchstatus = "off";
}

function runlightswitch(var0, var1) {
  level endon("game_ended");
  var2 = createlightswitchtrigger(var0, var1);

  if(isDefined(var2)) {
    thread watchlightswitchuse(var2);
    return;
  }
}

function createlightswitchtrigger(var0, var1) {
  var2 = spawn("script_model", self.origin, 40, 0, 60);
  var2 setModel("uk_electrical_box_medium_02_animated");
  var2.angles = self.angles;

  if(self.script_parameters == "motion") {
    return;
  }

  var3 = scripts\engine\utility::get_target_array();

  foreach(var5 in var3) {
    if(var5.code_classname == "script_origin") {
      if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == "sceneNode") {
        var2.scenenode = var5;
      } else {
        var2.hintlightmodel = spawn("script_model", var5.origin);
        var2.hintlightmodel.angles = var5.angles;
        var2.hintlightmodel setModel(var5.script_noteworthy);
        var2.hintlightmodel.modelname = var5.script_noteworthy;
      }

      continue;
    }

    if(var5.code_classname == "light") {
      var2.hintlight = var5;
    }
  }

  var2 setuserange(80);
  var2 sethintdisplayrange(200);
  var2 setusefov(120);
  var2 sethintdisplayfov(120);
  var2 setCursorHint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var2 setHintString(&"MP/LIGHT_SWITCH");
    var2 sethinticon("icon_electrical_box");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var2 setusepriority(0);
    var2 makeusable();
  }

  if(isDefined(var0.script_parameters) && var0.script_parameters == "motion") {
    var1.switchstatus = "motion";
  } else {
    var1.switchstatus = "off";
  }

  foreach(var8 in level.players) {
    var2 enableplayeruse(var8);
  }

  if(isDefined(var2.hintlightmodel) && isDefined(var2.hintlight)) {
    var2.hintlightcolor = var2.hintlight getlightintensity();
    thread manageswitchhintlight(var2);
  }

  return var2;
}

function watchlightswitchuse(var0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(isDefined(var0.switchstatus) && var0.switchstatus == "on") {
      playsoundatpos(self.origin, "mp_fusebox_lever_off_npc");
    } else {
      playsoundatpos(self.origin, "mp_fusebox_lever_on_npc");
    }

    thread swapswitchstatus(getanimlength(level.scr_anim["lightswitch"]["interact"]) - 0.15, var0);
    var2 = lightswitchinteraction(var1, var0);

    if(!var2) {
      self notify("interactionCancelled");
    }
  }
}

function swapswitchstatus(var0, var1) {
  self endon("interactionCancelled");
  wait var0;

  if(var1.switchstatus == "motion" || var1.switchstatus == "off") {
    var1.switchstatus = "on";
    self notify("masterSwitch_on");
    return;
  }

  var1.switchstatus = "off";
}

function manageswitchhintlight(var0) {
  level endon("game_ended");

  for(;;) {
    if(var0.switchstatus == "on") {
      self.hintlight setlightintensity(0);
      self.hintlightmodel setModel(self.hintlightmodel.modelname);
    } else {
      self.hintlight setlightintensity(self.hintlightcolor);
      self.hintlightmodel setModel(self.hintlightmodel.modelname + "_on");
    }

    waitframe();
  }
}

function getlightswitchstatus(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2.switchstatus) && var2.switchstatus == "on") {
      return "on";
    }
  }

  return "motion";
}

function onoffmodelswap(var0, var1) {
  foreach(var3 in var0) {
    if(var1 == "on") {
      var3 setModel(var3.modelname + "_on");
      continue;
    }

    var3 setModel(var3.modelname);

    if(isDefined(var3.flare)) {
      var3.flare delete();
    }
  }
}

function lightswitchinteraction(var0, var1) {
  var2 = scripts\engine\utility::ter_op(var1.switchstatus == "on", "interact", "interact_on");
  var3 = scripts\engine\utility::ter_op(var1.switchstatus == "on", "lights_on", "lights_off");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, var3);
  self.animname = "switch";
  self useanimtree(#animtree);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, var2);
  var4 = getanimlength(level.scr_anim["lightswitch"][var2]);
  wait var4;
  setDvar("NMLOKNMRSK", 0);
  self notify("interaction_complete");
  return true;
}

function watchplayerdeath(var0) {
  self endon("interaction_complete");
  self.cancelinteraction = 0;

  for(;;) {
    if(!isDefined(var0) || !scripts\mp\utility\player::isreallyalive(var0)) {
      self.cancelinteraction = 1;
      break;
    }

    waitframe();
  }
}

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0.player_rig = spawn("script_model", var0.origin);
  var0.player_rig setModel(var2);
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var1 = var0 getdroptofloorposition(var0.origin);

  if(isDefined(var1)) {
    var0 setOrigin(var1);
  } else {
    var0 setOrigin(var0.origin + (0, 0, 100));
  }

  var0.player_rig delete();
  var0.player_rig = undefined;
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a5("remove_rig", "death_or_disconnect");
}