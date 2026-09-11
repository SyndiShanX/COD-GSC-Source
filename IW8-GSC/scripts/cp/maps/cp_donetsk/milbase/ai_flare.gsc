/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\milbase\ai_flare.gsc
***********************************************************/

function load_fx() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_flare_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail.vfx");
  level._effect["alarm_light_flash"] = loadfx("vfx/iw8_cp/level/cp_millbase/vfx_alarm_light.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
  script_model_anims();
  level.ref_11e67 = gettime();
  level.ref_11d34 = [];
}

function run_to_and_launch_flare(var_0, var_1) {
  self endon("death");
  self endon("teleport_to_nearby_spawner");
  var_0.fired = 0;
  thread handle_ai_launcher_death(var_0);
  self.going_to_object = var_0;
  var_2 = self.goalradius;
  scripts\common\utility::demeanor_override("sprint");
  self.ref_11e51 = self.never_kill_off;
  self.never_kill_off = 1;
  self.matchdata_logattackerkillevent = self.dont_kill_off;
  self.dont_kill_off = 1;
  run_to_launcher(var_0);
  enter_launcher(var_0);
  fire_launcher(var_0);
  exit_launcher(var_0);
  self.goalradius = var_2;
  self.going_to_object = undefined;

  if(isDefined(var_1)) {
    self.goalradius = 128;
    var_0.operator = self;
    thread ref_11d2b(var_0);
  }

  clear_custom_anim();
  scripts\common\utility::clear_demeanor_override();

  if(isDefined(self.ref_11e51)) {
    self.never_kill_off = self.ref_11e51;
  }

  if(isDefined(self.matchdata_logattackerkillevent)) {
    self.dont_kill_off = self.matchdata_logattackerkillevent;
    return;
  }
}

function ref_11d2b(var_0) {
  scripts\engine\utility::ref_143a5("death", "teleport_to_nearby_spawner");
  var_0.operator = undefined;
  var_0.ref_1200b = gettime() + 45000;
}

function enter_launcher(var_0) {
  ai_anim("sdr_mortar_enter", 0.7);
  var_0 scriptmodelplayanimdeltamotion("emb_vm_mortar_mortar", "mortar", 0.7);
  wait 0.5;
  var_0 showpart("j_mortar_shell", "misc_wm_mortar");
  wait 0.2;
}

function fire_launcher(var_0) {
  ai_anim("sdr_mortar_launch", 0.4);

  if(var_0.script_noteworthy == "flare") {
    thread launch_illumination_flare();
  } else {
    thread launch_mortar(var_0, undefined, undefined);
  }

  var_0 hidepart("j_mortar_shell", "misc_wm_mortar");
  wait 0.4;
  self notify("launch_done");
  var_0.fired = 1;
}

function exit_launcher(var_0) {
  ai_anim("sdr_mortar_exit");
}

function reload_launcher(var_0) {
  var_0 scriptmodelplayanimdeltamotion("emb_wm_mortar_reload_mortar");
  ai_anim("sdr_mortar_reload");
}

function run_to_launcher(var_0) {
  var_1 = get_flare_launch_entrance(self, var_0);
  goto_anim_pos(var_1, 0);
}

function get_flare_launch_entrance(var_0, var_1) {
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_mortar_enter");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = var_1 gettagorigin("tag_origin");
  var_5 = var_1 gettagangles("tag_origin");
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_4, var_5, var_3) + anglesToForward(var_1.angles) * 5;
  var_6.angles = getstartangles(var_4, var_5, var_3);
  var_6.animindex = var_2;
  var_6.xanim = var_3;
  return var_6;
}

function ai_anim(var_0, var_1) {
  ref_13a2b();

  if(isDefined(var_1)) {
    scripts\asm\shared\mp\utility::burningdown(var_0, var_1);
  } else {
    scripts\asm\shared\mp\utility::burndowntime(var_0);
  }

  ref_12cc2();
}

function bleedout_logic(var_0, var_1) {
  ref_13a2b();
  scripts\asm\shared\mp\utility::burningpartlogic(var_0, var_1);
  ref_12cc2();
}

function goto_anim_pos(var_0, var_1) {
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.goalradius = 8;
  self.script_radius = 8;
  self setgoalpos(self getclosestreachablepointonnavmesh(var_0.origin));
  ref_143cb(var_0.origin, squared(384));
  self.goalradius = 8;
  self.script_radius = 8;
  self.ignoreall = 1;
  self.allowpain = 0;
  self waittill("goal");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  self setplayerangles(var_0.angles);
  self forceteleport(var_0.origin, var_0.angles);

  if(istrue(var_1)) {
    self.anchor = spawn("script_origin", var_0.origin);
    self.anchor.angles = var_0.angles;
    self linkTo(self.anchor);
    return;
  }
}

function launch_illumination_flare(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self gettagorigin("j_shaft_top");
  }

  if(!isDefined(var_1)) {
    var_1 = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);
  }

  var_2 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  var_2 show();
  var_3 = 2.25;
  thread movemortar(var_2, var_0, var_1, var_3, 400);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var_2, "tag_origin");
  var_2 playsoundonmovingent("weap_mortar_flare_whistle");
  wait var_3;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare"), var_2, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var_2, "tag_origin");
  thread flare_mover(var_2);
  var_2 playSound("weap_mortar_flare_burst");
  var_2 playSound("weap_mortar_flare_phosphorus_start");
  wait 0.1;
  var_2 playLoopSound("weap_mortar_flare_phosphorus_lp");
  wait 8;
  var_2 playSound("weap_mortar_flare_phosphorus_end");
  wait 2;
  var_2 delete();
}

function launch_mortar(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = self gettagorigin("j_shaft_top");
  }

  if(isDefined(level.get_mortar_impact_pos)) {
    var_1 = var_2[[level.get_mortar_impact_pos]](self);
  }

  if(!isDefined(var_1)) {
    var_1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
  }

  thread ref_142e2(var_1);
  var_4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_fire_dist");
  var_4 show();
  level.ref_11d34 = scripts\engine\utility::array_add(level.ref_11d34, var_4);
  var_5 = 5;
  var_6 = 1200;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  thread movemortar(var_4, var_0, var_1, var_5, var_6);
  ref_14358(var_4, var_5);

  if(isDefined(var_4)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_4, "tag_origin");
    var_4 stoploopsound();
    var_1 = var_4.origin;
    var_7 = (0, 0, 40);

    if(isalive(var_2)) {
      radiusdamage(var_1 + var_7, 256, 200, 150, var_2, "MOD_EXPLOSIVE", "c4_mp_p");
    } else {
      radiusdamage(var_1 + var_7, 256, 200, 150, var_4, "MOD_EXPLOSIVE", "c4_mp_p");
    }

    playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var_1);
    earthquake(0.25, 3, var_1, 2048);
    playrumbleonposition("cp_chopper_rumble", var_1);
    magicgrenademanual("mortar_mp", var_1 + (0, 0, 5), (0, 0, 0), 0.05);
    level.ref_11d34 = scripts\engine\utility::array_remove(level.ref_11d34, var_4);
    var_4 delete();
    return;
  }

  level.ref_11d34 = scripts\engine\utility::array_removeundefined(level.ref_11d34);
}

function ref_14358(var_0, var_1) {
  var_0 endon("early_impact");
  var_0 endon("death");
  var_0 setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_0, "tag_origin");
  var_0 playLoopSound("weap_mortar_fly_lp");
  wait var_1 - 1.7;
  var_0 playSound("weap_mortar_incoming");
  wait 1.7;
}

function flare_mover(var_0) {
  self endon("death");

  while(isDefined(self)) {
    var_1 = self.origin[0] + randomintrange(-5, 5);
    var_2 = self.origin[1] + randomintrange(-5, 5);
    var_3 = self.origin[2] - 15;
    self moveTo((var_1, var_2, var_3), 1);
    wait 1;
  }
}

function movemortar(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_5 = 1200;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  var_6 = 1 / var_3 / 0.05;
  var_7 = 0;
  var_8 = undefined;

  while(var_7 < 1) {
    if(isDefined(var_8)) {
      if(var_7 + var_6 < 1) {
        var_0.origin = var_8;
        var_0 notify("early_impact");
        return;
      }
    }

    var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_5, var_7);
    var_9 = var_7 + var_6;
    var_10 = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_5, var_9);
    var_8 = getcombatrecordsupermisc(var_0, var_10);
    anglemortar(var_0);
    var_7 += var_6;
    wait 0.05;
  }

  var_0.origin = var_2;
}

function getcombatrecordsupermisc(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_1, var_0, var_2);

  if(var_3["hittype"] != "hittype_none") {
    return var_1;
  }
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function handle_ai_launcher_death(var_0) {
  self waittill("death");
  self endon("launch_done");
  var_0 hidepart("j_mortar_shell", "misc_wm_mortar");
}

function run_to_and_set_alarm(var_0) {
  self endon("death");
  var_1 = self.goalradius;

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = getEnt(var_0.target, "targetname");

  if(istrue(var_2.alarm_on)) {
    return;
  }

  self.going_to_object = var_0;
  goto_anim_pos(var_0, 1);
  ai_turnon_alarm(var_2);
  self.goalradius = var_1;
  self.going_to_object = undefined;
  self.script_radius = self.goalradius;
  clear_custom_anim();
}

function ai_turnon_alarm(var_0) {
  var_0 scriptmodelplayanim("wm_eq_fusebox_turn_on_prop");
  ai_anim("sdr_fusebox_on");
  alarm_fx_on(var_0);
  var_0 scripts\engine\utility::ent_flag_set("switch_on");
  thread auto_alarm_turnoff(var_0);
}

function auto_alarm_turnoff(var_0) {
  self endon("turned_off");
  wait var_0;
  self makeunusable();
  self scriptmodelplayanim("wm_eq_fusebox_prop");
  alarm_fx_off(self);
  scripts\engine\utility::ent_flag_clear("switch_on");
  wait 1;
  self makeusable();
}

function ai_turnoff_alarm(var_0) {
  var_0 scriptmodelplayanim("wm_eq_fusebox_prop");
  ai_anim("sdr_fusebox_off");
  alarm_fx_off(var_0);
}

function alarm_box_player_interaction(var_0, var_1) {
  var_0 makeusable();
  var_0 setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  var_0 sethinttag("j_handle");
  var_0 sethintdisplayrange(128);
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethinticon("icon_electrical_box");
  var_0 sethintdisplayfov(120);
  var_0 sethintonobstruction("hide");
  var_0 sethintrequiresholding(0);
  var_0 setuseholdduration("duration_short");
  thread alarmbox2_logic(var_0, var_0);
}

function toggle_alarm(var_0) {
  var_0.alarm_on = 0;

  for(;;) {
    var_0 waittill("trigger");
    var_0 makeunusable();

    if(var_0.alarm_on) {
      var_0 scriptmodelplayanim("wm_eq_fusebox_prop");
      alarm_fx_off(var_0);
    } else {
      scripts\asm\shared\mp\utility::burndowntime("sdr_fusebox_on");
      alarm_fx_on(var_0);
      thread auto_alarm_turnoff(var_0);
    }

    wait 3;
    var_0 makeusable();
  }
}

function attract_agent_to_alarm(var_0, var_1) {
  var_0 endon("stop_attracting");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, getEntArray("ai_flare", "targetname"), 512);

  if(isDefined(var_2)) {
    var_2.attracting = 0;
    var_2.fired = 0;
  }

  for(;;) {
    if(istrue(var_1.alarm_on)) {
      while(istrue(var_1.alarm_on)) {
        wait 1;
      }

      if(isDefined(var_2)) {
        var_2 notify("stop_attracting");
        var_2.attracting = 0;
      }
    } else {
      if(isDefined(var_2) && !var_2.attracting && !var_2.fired) {
        thread attract_agent_to_mortar(var_2);
        var_2.attracting = 1;
      }

      var_3 = attract_an_agent(var_0, 2048);

      if(isDefined(var_3)) {
        run_to_and_set_alarm(var_3, var_0);

        if(!var_1.alarm_on) {
          wait 2;
        } else {
          return;
        }
      }
    }

    wait 1;
  }
}

function attract_agent_to_mortar(var_0, var_1, var_2) {
  var_0 endon("stop_attracting");

  for(;;) {
    var_3 = undefined;

    if(isDefined(var_0.operator) && isalive(var_0.operator)) {
      var_3 = var_0.operator;
    } else {
      if(isDefined(var_0.ref_1200b) && gettime() < var_0.ref_1200b) {
        wait 1;
        continue;
      }

      var_0.operator = undefined;
      var_4 = 1024;

      if(isDefined(var_2)) {
        var_4 = var_2;
      }

      var_3 = attract_an_agent(var_0, var_4);
    }

    if(isDefined(var_3)) {
      run_to_and_launch_flare(var_3, var_0, var_1);

      if(istrue(var_0.fired)) {
        level notify("flare_launched");
        var_0.attracting = 0;
        return;
      } else {
        wait 5;
      }
    }

    wait 1;
  }
}

function initialize_alarm_box(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = getEnt(var_0.target, "targetname");
  alarm_box_player_interaction(var_2, var_1);
  var_0.alarm_box = var_2;
  var_2 scripts\engine\utility::ent_flag_init("switch_on");
  var_2.scenenode = var_0;
}

function attract_an_agent(var_0, var_1) {
  var_2 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  var_3 = !istrue(var_0.ignoreplayers) && scripts\cp\utility::any_player_nearby(var_0.origin, squared(384));

  if(!var_2.size || var_3) {
    return undefined;
  }

  var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 4, var_1);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isDefined(var_4[var_5].going_to_object)) {
      continue;
    }

    if(isDefined(var_4[var_5].spawnpoint) && isDefined(var_4[var_5].spawnpoint.script_aigroup) && var_4[var_5].spawnpoint.script_aigroup == "nomortars") {
      continue;
    }

    if(!istrue(var_4[var_5].entered_combat)) {
      continue;
    }

    if(var_4[var_5] scripts\cp\utility::isjuggernaut()) {
      continue;
    }

    if(isDefined(var_4[var_5].unittype) && var_4[var_5].unittype == "suicidebomber") {
      continue;
    }

    if(istrue(var_4[var_5].playing_skit)) {
      continue;
    }

    if(var_4[var_5] scripts\cp\cp_modular_spawning::is_riding_vehicle()) {
      continue;
    }

    if(istrue(var_4[var_5].attempting_teleport)) {
      continue;
    }

    var_6 = undefined;

    if(isDefined(var_4[var_5].animationarchetype)) {
      var_6 = var_4[var_5].animationarchetype;
    } else {
      var_6 = var_4[var_5].asm.archetype;
    }

    if(!isDefined(var_6)) {
      continue;
    }

    if(var_6 != "soldier" && var_6 != "soldier_cp") {
      continue;
    }

    return var_4[var_5];
  }

  return undefined;
}

function clear_custom_anim() {
  self allowedstances("stand", "prone", "crouch");
  scripts\asm\shared\mp\utility::bunkercounteruav();

  if(!istrue(self.dont_enter_combat)) {
    self.ignoreall = 0;
  }

  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
    return;
  }
}

function alarm_fx_off(var_0) {
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_1 setModel("ee_light_mounted_exterior_industrial_caged_02");
  stopFXOnTag(level._effect["alarm_light_flash"], var_1, "tag_origin");
  var_2 stoploopsound();
  self.alarm_on = 0;
  self setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  var_0 notify("turned_off");
}

function alarm_fx_on(var_0) {
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_1 setModel("ee_light_mounted_exterior_industrial_caged_02_on");
  playFXOnTag(level._effect["alarm_light_flash"], var_1, "tag_origin");
  var_2 playLoopSound("milbase_alarm");
  var_0 setHintString(&"CP_STRIKE/TURN_OFF_ALARM");
  var_0.alarm_on = 1;
  level notify("alarm_on");
  level notify("weapons_free");
}

function run_to_and_plant_bomb(var_0) {
  self endon("death");
  var_0.planted = 0;
  self.going_to_object = var_0;
  var_1 = self.goalradius;
  run_to_bomb_location(self, var_0);
  plant_bomb(var_0);
  var_0.planted = 1;
  self.goalradius = var_1;
  self.going_to_object = undefined;
  clear_custom_anim();
}

function run_to_bomb_location(var_0, var_1) {
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_plant_bomb");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = var_1 gettagorigin("tag_origin");
  var_5 = var_1 gettagangles("tag_origin");
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_4, var_5, var_3);
  var_6.angles = getstartangles(var_4, var_5, var_3);
  var_6.animindex = var_2;
  var_6.xanim = var_3;
  var_0.ignoreall = 1;
  goto_anim_pos(var_0, var_6, 0);
}

function plant_bomb(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("offhand_wm_c4");
  var_1 scriptmodelplayanimdeltamotion("wm_equip_c4_attach_c4");
  var_0.charge = var_1;
  thread ref_123b1(var_0, var_1);
  thread ref_13331();
  bleedout_logic("sdr_plant_bomb", var_0);
  self notify("bomb_planted");
}

function ref_13331() {
  self endon("death");
  self hide();
  wait 0.5;
  self show();
}

function ref_123b1(var_0, var_1) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(var_1)) {
    var_1 delete();
    return;
  }
}

function attract_agent_to_bomb_plant(var_0) {
  var_0 endon("stop_attracting");

  for(;;) {
    var_1 = attract_an_agent(var_0, 1024);

    if(isDefined(var_1)) {
      run_to_and_plant_bomb(var_1, var_0);

      if(istrue(var_0.planted)) {
        var_0.attracting = 0;
        return;
      } else {
        wait randomintrange(5, 10);
      }
    }

    wait 1;
  }
}

function alarmbox2_logic(var_0, var_1) {
  level endon("game_ended");
  var_0.alarm_on = 0;

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }

    var_0 makeunusable();
    var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_2, "player_rig", 1);
    var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "fusebox_prop");

    if(!scripts\engine\utility::ent_flag("switch_on")) {
      var_4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact_on", 1);
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_4], "interact_on");
      scripts\engine\utility::ent_flag_set("switch_on");
      var_0.alarm_on = 1;

      if(var_5 && istrue(var_1)) {
        alarm_fx_on(var_0);
      }
    } else {
      var_4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact", 1);
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_4], "interact");
      scripts\engine\utility::ent_flag_clear("switch_on");
      var_0.alarm_on = 0;

      if(var_5 && istrue(var_1)) {
        alarm_fx_off(var_0);
      }
    }

    var_0 makeusable();
    var_3 = undefined;
    var_4 = undefined;
  }
}

#using_animtree("");

function script_model_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["interact"] = $wm_eq_fusebox_plr;
  level.scr_animname["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level.scr_eventanim["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level.scr_anim["player_rig"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_animname["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level.scr_eventanim["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level.scr_animtree["fusebox_prop"] = #animtree;
  level.scr_anim["fusebox_prop"]["interact"] = % wm_eq_fusebox_prop;
  level.scr_animname["fusebox_prop"]["interact"] = "wm_eq_fusebox_prop";
  level.scr_anim["fusebox_prop"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level.scr_animname["fusebox_prop"]["interact_on"] = "wm_eq_fusebox_turn_on_prop";
}

function ref_142e2(var_0) {
  var_1 = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  var_2 = scripts\cp\utility::give_all_players_nearby(var_0, squared(512));
  var_3 = scripts\engine\utility::random(var_1);

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.ref_11e67)) {
      var_5.ref_11e67 = gettime() + 30000;
    } else if(gettime() < var_5.ref_11e67) {
      continue;
    }

    var_5.ref_11e67 = gettime() + 30000;
    thread scripts\cp\cp_vo::try_to_play_vo_for_one_player(var_3, var_5);
  }
}

function ref_13a2b() {
  self.old_weapon = self.weapon;
  self.bunker_loot_vaults = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(self.bunker_loot_vaults);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.bunker_loot_vaults);
}

function ref_12cc2() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.bunker_loot_vaults);
  self setspawnweapon(self.old_weapon);
}

function ref_143cb(var_0, var_1) {
  while(distancesquared(self.origin, var_0) > var_1) {
    wait 0.1;
  }
}

function haspackage(var_0) {
  var_0 notify("stop_attracting");
  clear_custom_anim();
  scripts\common\utility::clear_demeanor_override();

  if(isDefined(self.ref_11e51)) {
    self.never_kill_off = self.ref_11e51;
  }

  if(isDefined(self.matchdata_logattackerkillevent)) {
    self.dont_kill_off = self.matchdata_logattackerkillevent;
    return;
  }
}