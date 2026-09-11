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

function run_to_and_launch_flare(var0, var1) {
  self endon("death");
  self endon("teleport_to_nearby_spawner");
  var0.fired = 0;
  thread handle_ai_launcher_death(var0);
  self.going_to_object = var0;
  var2 = self.goalradius;
  scripts\common\utility::demeanor_override("sprint");
  self.ref_11e51 = self.never_kill_off;
  self.never_kill_off = 1;
  self.matchdata_logattackerkillevent = self.dont_kill_off;
  self.dont_kill_off = 1;
  run_to_launcher(var0);
  enter_launcher(var0);
  fire_launcher(var0);
  exit_launcher(var0);
  self.goalradius = var2;
  self.going_to_object = undefined;

  if(isDefined(var1)) {
    self.goalradius = 128;
    var0.operator = self;
    thread ref_11d2b(var0);
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

function ref_11d2b(var0) {
  scripts\engine\utility::ref_143a5("death", "teleport_to_nearby_spawner");
  var0.operator = undefined;
  var0.ref_1200b = gettime() + 45000;
}

function enter_launcher(var0) {
  ai_anim("sdr_mortar_enter", 0.7);
  var0 scriptmodelplayanimdeltamotion("emb_vm_mortar_mortar", "mortar", 0.7);
  wait 0.5;
  var0 showpart("j_mortar_shell", "misc_wm_mortar");
  wait 0.2;
}

function fire_launcher(var0) {
  ai_anim("sdr_mortar_launch", 0.4);

  if(var0.script_noteworthy == "flare") {
    thread launch_illumination_flare();
  } else {
    thread launch_mortar(var0, undefined, undefined);
  }

  var0 hidepart("j_mortar_shell", "misc_wm_mortar");
  wait 0.4;
  self notify("launch_done");
  var0.fired = 1;
}

function exit_launcher(var0) {
  ai_anim("sdr_mortar_exit");
}

function reload_launcher(var0) {
  var0 scriptmodelplayanimdeltamotion("emb_wm_mortar_reload_mortar");
  ai_anim("sdr_mortar_reload");
}

function run_to_launcher(var0) {
  var1 = get_flare_launch_entrance(self, var0);
  goto_anim_pos(var1, 0);
}

function get_flare_launch_entrance(var0, var1) {
  var2 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_mortar_enter");
  var3 = var0 scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = var1 gettagorigin("tag_origin");
  var5 = var1 gettagangles("tag_origin");
  var6 = spawnStruct();
  var6.origin = getstartorigin(var4, var5, var3) + anglesToForward(var1.angles) * 5;
  var6.angles = getstartangles(var4, var5, var3);
  var6.animindex = var2;
  var6.xanim = var3;
  return var6;
}

function ai_anim(var0, var1) {
  ref_13a2b();

  if(isDefined(var1)) {
    scripts\asm\shared\mp\utility::burningdown(var0, var1);
  } else {
    scripts\asm\shared\mp\utility::burndowntime(var0);
  }

  ref_12cc2();
}

function bleedout_logic(var0, var1) {
  ref_13a2b();
  scripts\asm\shared\mp\utility::burningpartlogic(var0, var1);
  ref_12cc2();
}

function goto_anim_pos(var0, var1) {
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.goalradius = 8;
  self.script_radius = 8;
  self setgoalpos(self getclosestreachablepointonnavmesh(var0.origin));
  ref_143cb(var0.origin, squared(384));
  self.goalradius = 8;
  self.script_radius = 8;
  self.ignoreall = 1;
  self.allowpain = 0;
  self waittill("goal");

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  self setplayerangles(var0.angles);
  self forceteleport(var0.origin, var0.angles);

  if(istrue(var1)) {
    self.anchor = spawn("script_origin", var0.origin);
    self.anchor.angles = var0.angles;
    self linkTo(self.anchor);
    return;
  }
}

function launch_illumination_flare(var0, var1) {
  if(!isDefined(var0)) {
    var0 = self gettagorigin("j_shaft_top");
  }

  if(!isDefined(var1)) {
    var1 = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);
  }

  var2 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  var2 show();
  var3 = 2.25;
  thread movemortar(var2, var0, var1, var3, 400);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var2, "tag_origin");
  var2 playsoundonmovingent("weap_mortar_flare_whistle");
  wait var3;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare"), var2, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var2, "tag_origin");
  thread flare_mover(var2);
  var2 playSound("weap_mortar_flare_burst");
  var2 playSound("weap_mortar_flare_phosphorus_start");
  wait 0.1;
  var2 playLoopSound("weap_mortar_flare_phosphorus_lp");
  wait 8;
  var2 playSound("weap_mortar_flare_phosphorus_end");
  wait 2;
  var2 delete();
}

function launch_mortar(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = self gettagorigin("j_shaft_top");
  }

  if(isDefined(level.get_mortar_impact_pos)) {
    var1 = var2[[level.get_mortar_impact_pos]](self);
  }

  if(!isDefined(var1)) {
    var1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
  }

  thread ref_142e2(var1);
  var4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_fire_dist");
  var4 show();
  level.ref_11d34 = scripts\engine\utility::array_add(level.ref_11d34, var4);
  var5 = 5;
  var6 = 1200;

  if(isDefined(var3)) {
    var6 = var3;
  }

  thread movemortar(var4, var0, var1, var5, var6);
  ref_14358(var4, var5);

  if(isDefined(var4)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var4, "tag_origin");
    var4 stoploopsound();
    var1 = var4.origin;
    var7 = (0, 0, 40);

    if(isalive(var2)) {
      radiusdamage(var1 + var7, 256, 200, 150, var2, "MOD_EXPLOSIVE", "c4_mp_p");
    } else {
      radiusdamage(var1 + var7, 256, 200, 150, var4, "MOD_EXPLOSIVE", "c4_mp_p");
    }

    playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var1);
    earthquake(0.25, 3, var1, 2048);
    playrumbleonposition("cp_chopper_rumble", var1);
    magicgrenademanual("mortar_mp", var1 + (0, 0, 5), (0, 0, 0), 0.05);
    level.ref_11d34 = scripts\engine\utility::array_remove(level.ref_11d34, var4);
    var4 delete();
    return;
  }

  level.ref_11d34 = scripts\engine\utility::array_removeundefined(level.ref_11d34);
}

function ref_14358(var0, var1) {
  var0 endon("early_impact");
  var0 endon("death");
  var0 setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var0, "tag_origin");
  var0 playLoopSound("weap_mortar_fly_lp");
  wait var1 - 1.7;
  var0 playSound("weap_mortar_incoming");
  wait 1.7;
}

function flare_mover(var0) {
  self endon("death");

  while(isDefined(self)) {
    var1 = self.origin[0] + randomintrange(-5, 5);
    var2 = self.origin[1] + randomintrange(-5, 5);
    var3 = self.origin[2] - 15;
    self moveTo((var1, var2, var3), 1);
    wait 1;
  }
}

function movemortar(var0, var1, var2, var3, var4) {
  var0 endon("death");
  var5 = 1200;

  if(isDefined(var4)) {
    var5 = var4;
  }

  var6 = 1 / var3 / 0.05;
  var7 = 0;
  var8 = undefined;

  while(var7 < 1) {
    if(isDefined(var8)) {
      if(var7 + var6 < 1) {
        var0.origin = var8;
        var0 notify("early_impact");
        return;
      }
    }

    var0.origin = scripts\engine\math::get_point_on_parabola(var1, var2, var5, var7);
    var9 = var7 + var6;
    var10 = scripts\engine\math::get_point_on_parabola(var1, var2, var5, var9);
    var8 = getcombatrecordsupermisc(var0, var10);
    anglemortar(var0);
    var7 += var6;
    wait 0.05;
  }

  var0.origin = var2;
}

function getcombatrecordsupermisc(var0, var1) {
  var2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var3 = scripts\engine\trace::ray_trace(var0.origin, var1, var0, var2);

  if(var3["hittype"] != "hittype_none") {
    return var1;
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

function handle_ai_launcher_death(var0) {
  self waittill("death");
  self endon("launch_done");
  var0 hidepart("j_mortar_shell", "misc_wm_mortar");
}

function run_to_and_set_alarm(var0) {
  self endon("death");
  var1 = self.goalradius;

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2 = getEnt(var0.target, "targetname");

  if(istrue(var2.alarm_on)) {
    return;
  }

  self.going_to_object = var0;
  goto_anim_pos(var0, 1);
  ai_turnon_alarm(var2);
  self.goalradius = var1;
  self.going_to_object = undefined;
  self.script_radius = self.goalradius;
  clear_custom_anim();
}

function ai_turnon_alarm(var0) {
  var0 scriptmodelplayanim("wm_eq_fusebox_turn_on_prop");
  ai_anim("sdr_fusebox_on");
  alarm_fx_on(var0);
  var0 scripts\engine\utility::ent_flag_set("switch_on");
  thread auto_alarm_turnoff(var0);
}

function auto_alarm_turnoff(var0) {
  self endon("turned_off");
  wait var0;
  self makeunusable();
  self scriptmodelplayanim("wm_eq_fusebox_prop");
  alarm_fx_off(self);
  scripts\engine\utility::ent_flag_clear("switch_on");
  wait 1;
  self makeusable();
}

function ai_turnoff_alarm(var0) {
  var0 scriptmodelplayanim("wm_eq_fusebox_prop");
  ai_anim("sdr_fusebox_off");
  alarm_fx_off(var0);
}

function alarm_box_player_interaction(var0, var1) {
  var0 makeusable();
  var0 setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  var0 sethinttag("j_handle");
  var0 sethintdisplayrange(128);
  var0 setCursorHint("HINT_BUTTON");
  var0 sethinticon("icon_electrical_box");
  var0 sethintdisplayfov(120);
  var0 sethintonobstruction("hide");
  var0 sethintrequiresholding(0);
  var0 setuseholdduration("duration_short");
  thread alarmbox2_logic(var0, var0);
}

function toggle_alarm(var0) {
  var0.alarm_on = 0;

  for(;;) {
    var0 waittill("trigger");
    var0 makeunusable();

    if(var0.alarm_on) {
      var0 scriptmodelplayanim("wm_eq_fusebox_prop");
      alarm_fx_off(var0);
    } else {
      scripts\asm\shared\mp\utility::burndowntime("sdr_fusebox_on");
      alarm_fx_on(var0);
      thread auto_alarm_turnoff(var0);
    }

    wait 3;
    var0 makeusable();
  }
}

function attract_agent_to_alarm(var0, var1) {
  var0 endon("stop_attracting");
  var2 = scripts\engine\utility::getclosest(var0.origin, getEntArray("ai_flare", "targetname"), 512);

  if(isDefined(var2)) {
    var2.attracting = 0;
    var2.fired = 0;
  }

  for(;;) {
    if(istrue(var1.alarm_on)) {
      while(istrue(var1.alarm_on)) {
        wait 1;
      }

      if(isDefined(var2)) {
        var2 notify("stop_attracting");
        var2.attracting = 0;
      }
    } else {
      if(isDefined(var2) && !var2.attracting && !var2.fired) {
        thread attract_agent_to_mortar(var2);
        var2.attracting = 1;
      }

      var3 = attract_an_agent(var0, 2048);

      if(isDefined(var3)) {
        run_to_and_set_alarm(var3, var0);

        if(!var1.alarm_on) {
          wait 2;
        } else {
          return;
        }
      }
    }

    wait 1;
  }
}

function attract_agent_to_mortar(var0, var1, var2) {
  var0 endon("stop_attracting");

  for(;;) {
    var3 = undefined;

    if(isDefined(var0.operator) && isalive(var0.operator)) {
      var3 = var0.operator;
    } else {
      if(isDefined(var0.ref_1200b) && gettime() < var0.ref_1200b) {
        wait 1;
        continue;
      }

      var0.operator = undefined;
      var4 = 1024;

      if(isDefined(var2)) {
        var4 = var2;
      }

      var3 = attract_an_agent(var0, var4);
    }

    if(isDefined(var3)) {
      run_to_and_launch_flare(var3, var0, var1);

      if(istrue(var0.fired)) {
        level notify("flare_launched");
        var0.attracting = 0;
        return;
      } else {
        wait 5;
      }
    }

    wait 1;
  }
}

function initialize_alarm_box(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = getEnt(var0.target, "targetname");
  alarm_box_player_interaction(var2, var1);
  var0.alarm_box = var2;
  var2 scripts\engine\utility::ent_flag_init("switch_on");
  var2.scenenode = var0;
}

function attract_an_agent(var0, var1) {
  var2 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  var3 = !istrue(var0.ignoreplayers) && scripts\cp\utility::any_player_nearby(var0.origin, squared(384));

  if(!var2.size || var3) {
    return undefined;
  }

  var4 = scripts\engine\utility::get_array_of_closest(var0.origin, var2, undefined, 4, var1);

  for(var5 = 0; var5 < var4.size; var5++) {
    if(isDefined(var4[var5].going_to_object)) {
      continue;
    }

    if(isDefined(var4[var5].spawnpoint) && isDefined(var4[var5].spawnpoint.script_aigroup) && var4[var5].spawnpoint.script_aigroup == "nomortars") {
      continue;
    }

    if(!istrue(var4[var5].entered_combat)) {
      continue;
    }

    if(var4[var5] scripts\cp\utility::isjuggernaut()) {
      continue;
    }

    if(isDefined(var4[var5].unittype) && var4[var5].unittype == "suicidebomber") {
      continue;
    }

    if(istrue(var4[var5].playing_skit)) {
      continue;
    }

    if(var4[var5] scripts\cp\cp_modular_spawning::is_riding_vehicle()) {
      continue;
    }

    if(istrue(var4[var5].attempting_teleport)) {
      continue;
    }

    var6 = undefined;

    if(isDefined(var4[var5].animationarchetype)) {
      var6 = var4[var5].animationarchetype;
    } else {
      var6 = var4[var5].asm.archetype;
    }

    if(!isDefined(var6)) {
      continue;
    }

    if(var6 != "soldier" && var6 != "soldier_cp") {
      continue;
    }

    return var4[var5];
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

function alarm_fx_off(var0) {
  var1 = getEnt(var0.target, "targetname");
  var2 = getEnt(var1.target, "targetname");
  var1 setModel("ee_light_mounted_exterior_industrial_caged_02");
  stopFXOnTag(level._effect["alarm_light_flash"], var1, "tag_origin");
  var2 stoploopsound();
  self.alarm_on = 0;
  self setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  var0 notify("turned_off");
}

function alarm_fx_on(var0) {
  var1 = getEnt(var0.target, "targetname");
  var2 = getEnt(var1.target, "targetname");
  var1 setModel("ee_light_mounted_exterior_industrial_caged_02_on");
  playFXOnTag(level._effect["alarm_light_flash"], var1, "tag_origin");
  var2 playLoopSound("milbase_alarm");
  var0 setHintString(&"CP_STRIKE/TURN_OFF_ALARM");
  var0.alarm_on = 1;
  level notify("alarm_on");
  level notify("weapons_free");
}

function run_to_and_plant_bomb(var0) {
  self endon("death");
  var0.planted = 0;
  self.going_to_object = var0;
  var1 = self.goalradius;
  run_to_bomb_location(self, var0);
  plant_bomb(var0);
  var0.planted = 1;
  self.goalradius = var1;
  self.going_to_object = undefined;
  clear_custom_anim();
}

function run_to_bomb_location(var0, var1) {
  var2 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_plant_bomb");
  var3 = var0 scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = var1 gettagorigin("tag_origin");
  var5 = var1 gettagangles("tag_origin");
  var6 = spawnStruct();
  var6.origin = getstartorigin(var4, var5, var3);
  var6.angles = getstartangles(var4, var5, var3);
  var6.animindex = var2;
  var6.xanim = var3;
  var0.ignoreall = 1;
  goto_anim_pos(var0, var6, 0);
}

function plant_bomb(var0) {
  var1 = spawn("script_model", self.origin);
  var1.angles = self.angles;
  var1 setModel("offhand_wm_c4");
  var1 scriptmodelplayanimdeltamotion("wm_equip_c4_attach_c4");
  var0.charge = var1;
  thread ref_123b1(var0, var1);
  thread ref_13331();
  bleedout_logic("sdr_plant_bomb", var0);
  self notify("bomb_planted");
}

function ref_13331() {
  self endon("death");
  self hide();
  wait 0.5;
  self show();
}

function ref_123b1(var0, var1) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function attract_agent_to_bomb_plant(var0) {
  var0 endon("stop_attracting");

  for(;;) {
    var1 = attract_an_agent(var0, 1024);

    if(isDefined(var1)) {
      run_to_and_plant_bomb(var1, var0);

      if(istrue(var0.planted)) {
        var0.attracting = 0;
        return;
      } else {
        wait randomintrange(5, 10);
      }
    }

    wait 1;
  }
}

function alarmbox2_logic(var0, var1) {
  level endon("game_ended");
  var0.alarm_on = 0;

  for(;;) {
    self waittill("trigger", var2);

    if(!isPlayer(var2)) {
      continue;
    }

    var0 makeunusable();
    var3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var2, "player_rig", 1);
    var4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "fusebox_prop");

    if(!scripts\engine\utility::ent_flag("switch_on")) {
      var4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact_on", 1);
      var5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var4], "interact_on");
      scripts\engine\utility::ent_flag_set("switch_on");
      var0.alarm_on = 1;

      if(var5 && istrue(var1)) {
        alarm_fx_on(var0);
      }
    } else {
      var4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact", 1);
      var5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var4], "interact");
      scripts\engine\utility::ent_flag_clear("switch_on");
      var0.alarm_on = 0;

      if(var5 && istrue(var1)) {
        alarm_fx_off(var0);
      }
    }

    var0 makeusable();
    var3 = undefined;
    var4 = undefined;
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

function ref_142e2(var0) {
  var1 = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  var2 = scripts\cp\utility::give_all_players_nearby(var0, squared(512));
  var3 = scripts\engine\utility::random(var1);

  foreach(var5 in var2) {
    if(!isDefined(var5.ref_11e67)) {
      var5.ref_11e67 = gettime() + 30000;
    } else if(gettime() < var5.ref_11e67) {
      continue;
    }

    var5.ref_11e67 = gettime() + 30000;
    thread scripts\cp\cp_vo::try_to_play_vo_for_one_player(var3, var5);
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

function ref_143cb(var0, var1) {
  while(distancesquared(self.origin, var0) > var1) {
    wait 0.1;
  }
}

function haspackage(var0) {
  var0 notify("stop_attracting");
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