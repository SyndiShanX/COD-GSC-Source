/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\motiondetectors.gsc
***********************************************/

init() {
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

script_model_anims() {
  level.scr_animtree["lightswitch"] = #animtree;
  level.scr_anim["lightswitch"]["interact"] = % wm_eq_fusebox_plr;
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

motiondetectors() {
  wait 5;
  volumes = getEntArray("md_volume", "script_noteworthy");

  foreach(volume in volumes) {
    _id_5C72A7D5A67CF248 = volume scripts\engine\utility::get_target_array();
    volume thread motiondetectionproc(_id_5C72A7D5A67CF248);
  }
}

lightonroutine(_id_28F2010AF77C3D08, nvglights) {
  wait(_id_28F2010AF77C3D08);

  if(self.code_classname == "light") {
    if(!isDefined(self.savedintensity))
      _id_C7A32A54C0084820 = 50;
    else
      _id_C7A32A54C0084820 = self.savedintensity;

    self setlightintensity(_id_C7A32A54C0084820 * 0.7);
    thread scripts\engine\utility::play_sound_in_space("mp_lights_int_on", self.origin);
    wait 0.1;
    thread scripts\engine\utility::play_loop_sound_on_entity("mp_lights_int_on_loop");
    self setlightintensity(_id_C7A32A54C0084820 * 0.1);
    wait 0.05;
    self setlightintensity(_id_C7A32A54C0084820 * 0.4);
    wait 0.1;
    self setlightintensity(_id_C7A32A54C0084820 * 0.2);
    wait 0.15;
    self setlightintensity(_id_C7A32A54C0084820);
  } else if(self.code_classname == "scriptable")
    self setscriptablepartstate("light", "light_on");
}

lightoffroutine(lights, nvglights) {
  foreach(light in lights) {
    if(light.code_classname == "light") {
      light setlightintensity(0);
      light thread scripts\engine\utility::play_sound_in_space("mp_lights_int_off", light.origin);
      light notify("stop soundmp_lights_int_on_loop");
      continue;
    }

    if(light.code_classname == "scriptable")
      light setscriptablepartstate("light", "power_off");
  }
}

motiondetectionproc(_id_3E9ADE67F66C4B2D) {
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

  foreach(_id_4E9992C16F62DD6C in _id_3E9ADE67F66C4B2D) {
    if(_id_4E9992C16F62DD6C.code_classname == "light") {
      struct.lights[struct.lights.size] = _id_4E9992C16F62DD6C;
      continue;
    }

    if(isDefined(_id_4E9992C16F62DD6C.script_noteworthy) && _id_4E9992C16F62DD6C.script_noteworthy == "masterSwitch") {
      struct.masterswitches[struct.masterswitches.size] = _id_4E9992C16F62DD6C;
      continue;
    }

    if(_id_4E9992C16F62DD6C.code_classname == "script_model" && !isDefined(_id_4E9992C16F62DD6C.script_parameters)) {
      struct.models[struct.models.size] = _id_4E9992C16F62DD6C;
      continue;
    }

    if(_id_4E9992C16F62DD6C.code_classname == "script_origin") {
      struct.nvglights[struct.nvglights.size] = _id_4E9992C16F62DD6C;
      continue;
    }

    if(isDefined(_id_4E9992C16F62DD6C.script_label) && _id_4E9992C16F62DD6C.script_label == "blinding_volume")
      struct.triggerblind = _id_4E9992C16F62DD6C;
  }

  _id_552A8545BA4FD95F = getscriptablearray(self.target, "targetname");
  struct.lights = scripts\engine\utility::array_combine(struct.lights, _id_552A8545BA4FD95F);

  foreach(light in struct.lights) {
    if(light.code_classname == "light") {
      light.savedintensity = light getlightintensity();
      light setlightintensity(0);
      continue;
    }

    if(light.code_classname == "scriptable")
      light setscriptablepartstate("light", "power_off");
  }

  foreach(_id_75A9C89CD4A6FB0B in struct.masterswitches)
  _id_75A9C89CD4A6FB0B thread runlightswitch(self, struct);

  foreach(model in struct.models)
  model.modelname = model.model;

  if(scripts\mp\utility\game::getgametype() == "cyber") {
    if(!isDefined(level.emplights))
      level.emplights = [];

    level.emplights = scripts\engine\utility::array_add(level.emplights, struct);

    if(isDefined(level.emplightsoff))
      level thread[[level.emplightsoff]]();
  }

  thread onoffmodelswap(struct.models, "off");
  thread motiondetectionstatus(struct);

  for(;;) {
    if(struct.switchstatus == "on") {
      self notify("masterSwitch_on");

      if(!struct.lightson) {
        thread blindplayers(struct);

        foreach(light in struct.lights)
        light thread lightonroutine(randomfloat(0.2), struct.nvglights);

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

      if(isDefined(self.script_parameters) && self.script_parameters == "motion")
        struct.switchstatus = "motion";

      self notify("lights_off");
    }

    wait 0.05;
  }
}

blindplayers(struct) {
  if(isDefined(struct.triggerblind)) {
    wait 0.4;

    foreach(player in level.players) {
      if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
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

nameplatemanagement(struct) {
  level endon("game_ended");

  for(;;) {
    if(struct.lightson == 0) {
      foreach(player in level.players) {
        if(player istouching(self))
          player thread manageplayerindarkvolume(self, struct);
      }
    }

    wait 0.1;
  }
}

manageplayerindarkvolume(volume, struct) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(self.indarkvolume)) {
    return;
  }
  scripts\mp\utility\perk::giveperk("specialty_spygame");
  self.indarkvolume = 1;

  while(self istouching(volume) && struct.lightson == 0)
    wait 0.1;

  scripts\mp\utility\perk::removeperk("specialty_spygame");
  self.indarkvolume = undefined;
}

motiondetectionstatus(struct) {
  level endon("game_ended");

  for(;;) {
    struct.detection = 0;

    foreach(player in level.players) {
      if(player istouching(self)) {
        if(player getstance() == "stand" && length2d(player getvelocity()) > 40) {
          struct.detection = 1;
          struct.cooldown = 4;
        }

        if(struct.lightson)
          player.inmotionlight = 1;
      }
    }

    wait 0.05;
  }
}

motiondetectioncooldown(struct) {
  level endon("game_ended");
  self endon("lights_off");
  self endon("masterSwitch_on");

  if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
    while(struct.cooldown > 0) {
      wait 0.1;
      struct.cooldown = struct.cooldown - 0.1;
    }
  }

  struct.switchstatus = "off";
}

runlightswitch(volume, struct) {
  level endon("game_ended");
  _id_75A9C89CD4A6FB0B = createlightswitchtrigger(volume, struct);

  if(isDefined(_id_75A9C89CD4A6FB0B))
    _id_75A9C89CD4A6FB0B thread watchlightswitchuse(struct);
}

createlightswitchtrigger(volume, struct) {
  _id_49181284B44D5AFB = spawn("script_model", self.origin, 40, 0, 60);
  _id_49181284B44D5AFB setModel("uk_electrical_box_medium_02_animated");
  _id_49181284B44D5AFB.angles = self.angles;

  if(self.script_parameters == "motion") {
    return;
  }
  _id_4CF9285C14BE6131 = scripts\engine\utility::get_target_array();

  foreach(part in _id_4CF9285C14BE6131) {
    if(part.code_classname == "script_origin") {
      if(isDefined(part.script_noteworthy) && part.script_noteworthy == "sceneNode")
        _id_49181284B44D5AFB.scenenode = part;
      else {
        _id_49181284B44D5AFB.hintlightmodel = spawn("script_model", part.origin);
        _id_49181284B44D5AFB.hintlightmodel.angles = part.angles;
        _id_49181284B44D5AFB.hintlightmodel setModel(part.script_noteworthy);
        _id_49181284B44D5AFB.hintlightmodel.modelname = part.script_noteworthy;
      }

      continue;
    }

    if(part.code_classname == "light") {
      _id_49181284B44D5AFB.hintlight = part;
      continue;
    }
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    _id_49181284B44D5AFB makeusable();
    _id_49181284B44D5AFB setusepriority(0);
    _id_49181284B44D5AFB setuserange(80);
    _id_49181284B44D5AFB sethintdisplayrange(200);
    _id_49181284B44D5AFB setusefov(120);
    _id_49181284B44D5AFB sethintdisplayfov(120);
    _id_49181284B44D5AFB setCursorHint("HINT_BUTTON");

    if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
      _id_49181284B44D5AFB setHintString(&"MP/LIGHT_SWITCH");
      _id_49181284B44D5AFB sethinticon("icon_electrical_box");
    }
  }

  if(isDefined(volume.script_parameters) && volume.script_parameters == "motion")
    struct.switchstatus = "motion";
  else
    struct.switchstatus = "off";

  foreach(player in level.players)
  _id_49181284B44D5AFB enableplayeruse(player);

  if(isDefined(_id_49181284B44D5AFB.hintlightmodel) && isDefined(_id_49181284B44D5AFB.hintlight)) {
    _id_49181284B44D5AFB.hintlightcolor = _id_49181284B44D5AFB.hintlight getlightintensity();
    _id_49181284B44D5AFB thread manageswitchhintlight(struct);
  }

  return _id_49181284B44D5AFB;
}

watchlightswitchuse(struct) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(isDefined(struct.switchstatus) && struct.switchstatus == "on")
      playsoundatpos(self.origin, "mp_fusebox_lever_off_npc");
    else
      playsoundatpos(self.origin, "mp_fusebox_lever_on_npc");

    thread swapswitchstatus(getanimlength(level.scr_anim["lightswitch"]["interact"]) - 0.15, struct);
    success = lightswitchinteraction(player, struct);

    if(!success)
      self notify("interactionCancelled");
  }
}

swapswitchstatus(waittime, struct) {
  self endon("interactionCancelled");
  wait(waittime);

  if(struct.switchstatus == "motion" || struct.switchstatus == "off") {
    struct.switchstatus = "on";
    self notify("masterSwitch_on");
  } else
    struct.switchstatus = "off";
}

manageswitchhintlight(struct) {
  level endon("game_ended");

  for(;;) {
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

getlightswitchstatus(_id_F9CEC8EB8DD4E701) {
  foreach(_id_75A9C89CD4A6FB0B in _id_F9CEC8EB8DD4E701) {
    if(isDefined(_id_75A9C89CD4A6FB0B.switchstatus) && _id_75A9C89CD4A6FB0B.switchstatus == "on")
      return "on";
  }

  return "motion";
}

onoffmodelswap(models, state) {
  foreach(model in models) {
    if(state == "on") {
      model setModel(model.modelname + "_on");
      continue;
    }

    model setModel(model.modelname);

    if(isDefined(model.flare))
      model.flare delete();
  }
}

lightswitchinteraction(player, struct) {
  animname = scripts\engine\utility::ter_op(struct.switchstatus == "on", "interact", "interact_on");
  self.animname = "switch";
  self useanimtree(#animtree);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, animname);
  animlength = getanimlength(level.scr_anim["lightswitch"][animname]);
  wait(animlength);
  setDvar("depthSortViewmodel", 0);
  self notify("interaction_complete");
  return 1;
}

watchplayerdeath(player) {
  self endon("interaction_complete");
  self.cancelinteraction = 0;

  for(;;) {
    if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
      self.cancelinteraction = 1;
      break;
    }

    waitframe();
  }
}

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player.player_rig = spawn("script_model", player.origin);
  player.player_rig setModel(_id_486DB5FA512A3B6B);
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  player watch_remove_rig();
  remove_player_rig(player);
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  _id_5BF3E22BDB650432 = player getdroptofloorposition(player.origin);

  if(isDefined(_id_5BF3E22BDB650432))
    player setOrigin(_id_5BF3E22BDB650432);
  else
    player setOrigin(player.origin + (0, 0, 100));

  player.player_rig delete();
  player.player_rig = undefined;
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_2("remove_rig", "death_or_disconnect");
}