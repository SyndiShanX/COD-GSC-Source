/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\motiondetectors.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace motiondetectors;

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

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["lightswitch"] = #animtree;
  level.scr_anim["lightswitch"]["interact"] = % wm_eq_fusebox_plr;
  level.scr_eventanim["lightswitch"]["interact"] = % "eq_fusebox_plr";
  level.scr_anim["lightswitch"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_eventanim["lightswitch"]["interact_on"] = % "eq_fusebox_turn_on_plr";
  level.scr_animtree["switch"] = #animtree;
  level.scr_anim["switch"]["interact"] = % wm_eq_fusebox_prop;
  level.scr_anim["switch"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level.interactionanimlength = getanimlength(level.scr_anim["lightswitch"]["interact"]);
}

function motiondetectors() {
  wait 5;
  volumes = getEntArray("md_volume", "script_noteworthy");

  foreach(volume in volumes) {
    linkedcomponents = volume get_target_array();
    volume thread motiondetectionproc(linkedcomponents);
  }
}

function lightonroutine(delaystart, nvglights) {
  wait delaystart;

  if(self.code_classname == "light") {
    if(!isDefined(self.savedintensity)) {
      finalintensity = 50;
    } else {
      finalintensity = self.savedintensity;
    }

    self setlightintensity(finalintensity * 0.7);
    thread play_sound_in_space("mp_lights_int_on", self.origin);
    wait 0.1;
    thread play_loop_sound_on_entity("mp_lights_int_on_loop");
    self setlightintensity(finalintensity * 0.1);
    wait 0.05;
    self setlightintensity(finalintensity * 0.4);
    wait 0.1;
    self setlightintensity(finalintensity * 0.2);
    wait 0.15;
    self setlightintensity(finalintensity);
    return;
  }

  if(self.code_classname == "scriptable") {
    self setscriptablepartstate("light", "light_on");
  }
}

function lightoffroutine(lights, nvglights) {
  foreach(light in lights) {
    if(light.code_classname == "light") {
      light setlightintensity(0);
      light thread play_sound_in_space("mp_lights_int_off", light.origin);
      light notify("stop sound" + "mp_lights_int_on_loop");
      continue;
    }

    if(light.code_classname == "scriptable") {
      light setscriptablepartstate("light", "power_off");
    }
  }
}

function motiondetectionproc(components) {
  level endon("game_ended");
  struct = spawnStruct();
  struct.active = undefined;
  struct.masterswitches = [];
  struct.lights = [];
  struct.models = [];
  struct.nvglights = [];
  struct.switchstatus = "motion";
  struct.lightson = 0;
  struct.detection = 0;
  struct.triggerblind = undefined;

  foreach(component in components) {
    if(component.code_classname == "light") {
      struct.lights[struct.lights.size] = component;
      continue;
    }

    if(isDefined(component.script_noteworthy) && component.script_noteworthy == "masterSwitch") {
      struct.masterswitches[struct.masterswitches.size] = component;
      continue;
    }

    if(component.code_classname == "script_model" && !isDefined(component.script_parameters)) {
      struct.models[struct.models.size] = component;
      continue;
    }

    if(component.code_classname == "script_origin") {
      struct.nvglights[struct.nvglights.size] = component;
      continue;
    }

    if(isDefined(component.script_label) && component.script_label == "blinding_volume") {
      struct.triggerblind = component;
    }
  }

  var_552a8545ba4fd95f = getscriptablearray(self.target, "targetname");
  struct.lights = array_combine(struct.lights, var_552a8545ba4fd95f);

  foreach(light in struct.lights) {
    if(light.code_classname == "light") {
      light.savedintensity = light getlightintensity();
      light setlightintensity(0);
      continue;
    }

    if(light.code_classname == "scriptable") {
      light setscriptablepartstate("light", "power_off");
    }
  }

  foreach(lightswitch in struct.masterswitches) {
    lightswitch thread runlightswitch(self, struct);
  }

  foreach(model in struct.models) {
    model.modelname = model.model;
  }

  if(getgametype() == "cyber") {
    if(!isDefined(level.emplights)) {
      level.emplights = [];
    }

    level.emplights = array_add(level.emplights, struct);

    if(isDefined(level.emplightsoff)) {
      level thread[[level.emplightsoff]]();
    }
  }

  thread onoffmodelswap(struct.models, "off");
  thread motiondetectionstatus(struct);

  while(true) {
    if(struct.switchstatus == "on") {
      self notify("masterSwitch_on");

      if(!struct.lightson) {
        thread blindplayers(struct);

        foreach(light in struct.lights) {
          light thread lightonroutine(randomfloat(0.2), struct.nvglights);
        }

        thread onoffmodelswap(struct.models, "on");
        struct.lightson = 1;
      }
    } else if(struct.switchstatus == "motion") {
      if(struct.detection && !struct.lightson) {
        thread blindplayers(struct);

        foreach(light in struct.lights) {
          light thread lightonroutine(randomfloat(0.2), struct.nvglights);
          struct.lightson = 1;
        }

        thread onoffmodelswap(struct.models, "on");
        thread motiondetectioncooldown(struct);
      }
    } else if(struct.switchstatus == "off") {
      if(struct.lightson) {
        level lightoffroutine(struct.lights, struct.nvglights);
        thread onoffmodelswap(struct.models, "off");
        struct.lightson = 0;
      }

      if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
        struct.switchstatus = "motion";
      }

      self notify("lights_off");
    }

    wait 0.05;
  }
}

function blindplayers(struct) {
  if(isDefined(struct.triggerblind)) {
    wait 0.4;

    foreach(player in level.players) {
      if(!isDefined(player) || !isreallyalive(player)) {
        continue;
      }

      if(player istouching(struct.triggerblind)) {
        player activatenightvisionblind();
        continue;
      }

      foreach(light in struct.lights) {
        if(distancesquared(light.origin, player.origin) > 230400) {
          continue;
        }

        if(!scripts\engine\utility::within_fov(player getEye(), player getplayerangles(), light.origin, 0.707106)) {
          continue;
        }

        trace = scripts\engine\trace::ray_trace(player getEye(), light.origin, undefined, scripts\engine\trace::create_default_contents(1));

        if(distancesquared(trace["position"], light.origin) <= 324) {
          player activatenightvisionblind();
          break;
        }
      }
    }
  }
}

function nameplatemanagement(struct) {
  level endon("game_ended");

  while(true) {
    if(struct.lightson == 0) {
      foreach(player in level.players) {
        if(player istouching(self)) {
          player thread manageplayerindarkvolume(self, struct);
        }
      }
    }

    wait 0.1;
  }
}

function manageplayerindarkvolume(volume, struct) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(self.indarkvolume)) {
    return;
  }

  giveperk("specialty_spygame");
  self.indarkvolume = 1;

  while(self istouching(volume) && struct.lightson == 0) {
    wait 0.1;
  }

  removeperk("specialty_spygame");
  self.indarkvolume = undefined;
}

function motiondetectionstatus(struct) {
  level endon("game_ended");

  while(true) {
    struct.detection = 0;

    foreach(player in level.players) {
      if(player istouching(self)) {
        if(player getstance() == "stand" && length2d(player getvelocity()) > 40) {
          struct.detection = 1;
          struct.cooldown = 4;
        }

        if(struct.lightson) {
          player.inmotionlight = 1;
        }
      }
    }

    wait 0.05;
  }
}

function motiondetectioncooldown(struct) {
  level endon("game_ended");
  self endon("lights_off");
  self endon("masterSwitch_on");

  if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
    while(struct.cooldown > 0) {
      wait 0.1;
      struct.cooldown -= 0.1;
    }
  }

  struct.switchstatus = "off";
}

function runlightswitch(volume, struct) {
  level endon("game_ended");
  lightswitch = createlightswitchtrigger(volume, struct);

  if(isDefined(lightswitch)) {
    lightswitch thread watchlightswitchuse(struct);
  }
}

function createlightswitchtrigger(volume, struct) {
  switchtrigger = spawn("script_model", self.origin, 40, 0, 60);
  switchtrigger setModel("uk_electrical_box_medium_02_animated");
  switchtrigger.angles = self.angles;

  if(self.script_parameters == "motion") {
    return;
  }

  childparts = get_target_array();

  foreach(part in childparts) {
    if(part.code_classname == "script_origin") {
      if(isDefined(part.script_noteworthy) && part.script_noteworthy == "sceneNode") {
        switchtrigger.scenenode = part;
      } else {
        switchtrigger.hintlightmodel = spawn("script_model", part.origin);
        switchtrigger.hintlightmodel.angles = part.angles;
        switchtrigger.hintlightmodel setModel(part.script_noteworthy);
        switchtrigger.hintlightmodel.modelname = part.script_noteworthy;
      }

      continue;
    }

    if(part.code_classname == "light") {
      switchtrigger.hintlight = part;
    }
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    switchtrigger makeusable();
    switchtrigger setusepriority(0);
    switchtrigger setuserange(80);
    switchtrigger sethintdisplayrange(200);
    switchtrigger setusefov(120);
    switchtrigger sethintdisplayfov(120);
    switchtrigger setCursorHint("HINT_BUTTON");

    if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
      switchtrigger setHintString(&"MP/LIGHT_SWITCH");
      switchtrigger sethinticon("icon_electrical_box");
    }
  }

  if(isDefined(volume.script_parameters) && volume.script_parameters == "motion") {
    struct.switchstatus = "motion";
  } else {
    struct.switchstatus = "off";
  }

  foreach(player in level.players) {
    switchtrigger enableplayeruse(player);
  }

  if(isDefined(switchtrigger.hintlightmodel) && isDefined(switchtrigger.hintlight)) {
    switchtrigger.hintlightcolor = switchtrigger.hintlight getlightintensity();
    switchtrigger thread manageswitchhintlight(struct);
  }

  return switchtrigger;
}

function watchlightswitchuse(struct) {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(isDefined(struct.switchstatus) && struct.switchstatus == "on") {
      playsoundatpos(self.origin, "mp_fusebox_lever_off_npc");
    } else {
      playsoundatpos(self.origin, "mp_fusebox_lever_on_npc");
    }

    thread swapswitchstatus(getanimlength(level.scr_anim["lightswitch"]["interact"]) - 0.15, struct);
    success = lightswitchinteraction(player, struct);

    if(!success) {
      self notify("interactionCancelled");
    }
  }
}

function swapswitchstatus(waittime, struct) {
  self endon("interactionCancelled");
  wait waittime;

  if(struct.switchstatus == "motion" || struct.switchstatus == "off") {
    struct.switchstatus = "on";
    self notify("masterSwitch_on");
    return;
  }

  struct.switchstatus = "off";
}

function manageswitchhintlight(struct) {
  level endon("game_ended");

  while(true) {
    if(struct.switchstatus == "on") {
      self.hintlight setlightintensity(0);
      self.hintlightmodel setModel(self.hintlightmodel.modelname);
    } else {
      self.hintlight setlightintensity(self.hintlightcolor);
      self.hintlightmodel setModel(self.hintlightmodel.modelname + "_on");
    }

    waitframe();
  }
}

function getlightswitchstatus(switches) {
  foreach(lightswitch in switches) {
    if(isDefined(lightswitch.switchstatus) && lightswitch.switchstatus == "on") {
      return "on";
    }
  }

  return "motion";
}

function onoffmodelswap(models, state) {
  foreach(model in models) {
    if(state == "on") {
      model setModel(model.modelname + "_on");
      continue;
    }

    model setModel(model.modelname);

    if(isDefined(model.flare)) {
      model.flare delete();
    }
  }
}

function lightswitchinteraction(player, struct) {
  animname = ter_op(struct.switchstatus == "on", "interact", "interact_on");
  self.animname = "switch";
  self useanimtree(#animtree);
  self.scenenode thread anim_single_solo(self, animname);
  animlength = getanimlength(level.scr_anim["lightswitch"][animname]);
  wait animlength;
  setDvar(@ "hash_7eb1641737ab83b7", 0);
  self notify("interaction_complete");
  return true;
}

function watchplayerdeath(player) {
  self endon("interaction_complete");
  self.cancelinteraction = 0;

  while(true) {
    if(!isDefined(player) || !isreallyalive(player)) {
      self.cancelinteraction = 1;
      break;
    }

    waitframe();
  }
}

function create_player_rig(player, animname, rig_model) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }

  player.animname = animname;

  if(!isDefined(rig_model)) {
    rig_model = "viewhands_base_iw8";
  }

  player.player_rig = spawn("script_model", player.origin);
  player.player_rig setModel(rig_model);
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  player watch_remove_rig();
  remove_player_rig(player);
}

function remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  player unlink();
  droppos = player getdroptofloorposition(player.origin);

  if(isDefined(droppos)) {
    player setOrigin(droppos);
  } else {
    player setOrigin(player.origin + (0, 0, 100));
  }

  player.player_rig delete();
  player.player_rig = undefined;
}

function watch_remove_rig(struct) {
  waittill_any_2("remove_rig", "death_or_disconnect");
}