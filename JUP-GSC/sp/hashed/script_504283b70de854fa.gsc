/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_504283b70de854fa.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\utility;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vo;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace ai_flare;

function load_fx() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_flare_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw9/cp/vfx_cp_mortar_trail.vfx");
  level._effect["alarm_light_flash"] = loadfx("vfx/iw8_cp/level/cp_millbase/vfx_alarm_light.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
  script_model_anims();
  level.next_mortar_vo = gettime();
  level.mortars = [];
}

function run_to_and_launch_flare(launcher, var_68ee057779a106c1) {
  self endon("death");
  self endon("teleport_to_nearby_spawner");
  launcher.fired = 0;
  thread handle_ai_launcher_death(launcher);
  self.going_to_object = launcher;
  old_radius = self.goalradius;
  utility::demeanor_override("sprint");
  self.never_kill_off_old = self.never_kill_off;
  self.never_kill_off = 1;
  self.dont_kill_off_old = self.dont_kill_off;
  self.dont_kill_off = 1;
  run_to_launcher(launcher);
  enter_launcher(launcher);
  fire_launcher(launcher);
  exit_launcher(launcher);
  self.goalradius = old_radius;
  self.going_to_object = undefined;

  if(isDefined(var_68ee057779a106c1)) {
    self.goalradius = 128;
    launcher.operator = self;
    thread mortar_cooldown(launcher);
  }

  clear_custom_anim();
  utility::clear_demeanor_override();

  if(isDefined(self.never_kill_off_old)) {
    self.never_kill_off = self.never_kill_off_old;
  }

  if(isDefined(self.dont_kill_off_old)) {
    self.dont_kill_off = self.dont_kill_off_old;
  }
}

function mortar_cooldown(launcher) {
  waittill_any_2("death", "teleport_to_nearby_spawner");

  if(isDefined(launcher) && isent(launcher)) {
    launcher.operator = undefined;
    launcher.oncooldown = gettime() + 45000;
  }
}

function enter_launcher(launcher) {
  ai_anim("sdr_mortar_enter", 0.7);
  launcher scriptmodelplayanimdeltamotion("emb_vm_mortar_mortar", "mortar", 0.7);
  wait 0.5;
  launcher showpart("j_mortar_shell", "misc_wm_mortar");
  wait 0.2;
}

function fire_launcher(launcher) {
  ai_anim("sdr_mortar_launch", 0.4);

  if(launcher.script_noteworthy == "flare") {
    launcher thread launch_illumination_flare();
  } else {
    launcher thread launch_mortar(undefined, undefined, self);
  }

  launcher hidepart("j_mortar_shell", "misc_wm_mortar");
  wait 0.4;
  self notify("launch_done");
  launcher.fired = 1;
}

function exit_launcher(launcher) {
  ai_anim("sdr_mortar_exit");
}

function reload_launcher(launcher) {
  launcher scriptmodelplayanimdeltamotion("emb_wm_mortar_reload_mortar");
  ai_anim("sdr_mortar_reload");
}

function run_to_launcher(launcher) {
  goal = get_flare_launch_entrance(self, launcher);
  goto_anim_pos(goal, 0);
}

function get_flare_launch_entrance(agent, launcher) {
  if(getDvar(@ "ui_mapname") == "cp_observatory" || getDvar(@ "ui_mapname") == "cp_lone") {
    org = launcher gettagorigin("tag_origin");
    ang = launcher gettagangles("tag_origin");
    pos = spawnStruct();
    pos.origin = org + anglesToForward(launcher.angles) * 5;
    pos.angles = ang;
    return pos;
  }

  animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_mortar_enter");
  xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
  org = launcher gettagorigin("tag_origin");
  ang = launcher gettagangles("tag_origin");
  pos = spawnStruct();
  pos.origin = getstartorigin(org, ang, xanim) + anglesToForward(launcher.angles) * 5;
  pos.angles = getstartangles(org, ang, xanim);
  pos.animindex = animindex;
  pos.xanim = xanim;
  return pos;
}

function ai_anim(animalias, early_return) {
  if(getDvar(@ "ui_mapname") == "cp_observatory") {
    return;
  }

  take_ai_weapon();

  if(isDefined(early_return)) {
    scripts\asm\shared\mp\utility::animscripted_single_earlyend(animalias, early_return);
  } else {
    scripts\asm\shared\mp\utility::animscripted_single(animalias);
  }

  restore_ai_weapon();
}

function ai_anim_relative(animalias, ent) {
  take_ai_weapon();
  scripts\asm\shared\mp\utility::animscripted_single_relative(animalias, ent);
  restore_ai_weapon();
}

function goto_anim_pos(goal, link) {
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.goalradius = 8;
  self.script_radius = 8;
  self setgoalpos(self getclosestreachablepointonnavmesh(goal.origin));
  waittill_near_goal(goal.origin, squared(384));
  self.goalradius = 8;
  self.script_radius = 8;
  self.ignoreall = 1;
  self.allowpain = 0;
  self waittill("goal");

  if(!isDefined(goal.angles)) {
    goal.angles = (0, 0, 0);
  }

  self setplayerangles(goal.angles);
  self forceteleport(goal.origin, goal.angles);

  if(istrue(link)) {
    self.anchor = spawn("script_origin", goal.origin);
    self.anchor.angles = goal.angles;
    self linkTo(self.anchor);
  }
}

function launch_illumination_flare(start, end) {
  if(!isDefined(start)) {
    start = self gettagorigin("j_shaft_top");
  }

  if(!isDefined(end)) {
    end = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);
  }

  flare = spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  flare show();
  time = 2.25;
  thread movemortar(flare, start, end, time, 400);
  wait 0.1;
  playFXOnTag(getfx("vfx_flare_trail"), flare, "tag_origin");
  flare playsoundonmovingent("weap_mortar_flare_whistle");
  wait time;
  playFXOnTag(getfx("vfx_flare"), flare, "tag_origin");
  stopFXOnTag(getfx("vfx_flare_trail"), flare, "tag_origin");
  flare thread flare_mover(end);
  flare playSound("weap_mortar_flare_burst");
  flare playSound("weap_mortar_flare_phosphorus_start");
  wait 0.1;
  flare playLoopSound("weap_mortar_flare_phosphorus_lp");
  wait 8;
  flare playSound("weap_mortar_flare_phosphorus_end");
  wait 2;
  flare delete();
}

function launch_mortar(start, end, agent, optional_height) {
  if(!isDefined(start)) {
    start = self gettagorigin("j_shaft_top");
  }

  if(isDefined(level.get_mortar_impact_pos)) {
    end = agent[[level.get_mortar_impact_pos]](self);
  }

  if(!isDefined(end)) {
    end = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
  }

  thread vo_incoming_mortar(end);
  mortar = spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_fire_dist");
  mortar show();
  level.mortars = array_add(level.mortars, mortar);
  time = 5;
  apex_height = 1200;

  if(isDefined(optional_height)) {
    apex_height = optional_height;
  }

  thread movemortar(mortar, start, end, time, apex_height);
  wait_until_impact(mortar, time);

  if(isDefined(mortar)) {
    stopFXOnTag(getfx("vfx_mortar_trail"), mortar, "tag_origin");
    mortar stoploopsound();
    end = mortar.origin;
    z_offset = (0, 0, 40);

    if(isalive(agent)) {
      radiusdamage(end + z_offset, 256, 200, 150, agent, "MOD_EXPLOSIVE", "c4_mp");
    } else {
      radiusdamage(end + z_offset, 256, 200, 150, mortar, "MOD_EXPLOSIVE", "c4_mp");
    }

    playFX(getfx("vfx_mortar_explosion"), end);
    earthquake(0.25, 3, end, 2048);
    playrumbleonposition("cp_chopper_rumble", end);
    magicgrenademanual("mortar_mp", end + (0, 0, 5), (0, 0, 0), 0.05);
    level.mortars = array_remove(level.mortars, mortar);
    mortar delete();
    return;
  }

  level.mortars = scripts\engine\utility::array_removeundefined(level.mortars);
}

function wait_until_impact(mortar, time) {
  mortar endon("early_impact");
  mortar endon("death");
  mortar setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(getfx("vfx_mortar_trail"), mortar, "tag_origin");
  mortar playLoopSound("weap_mortar_fly_lp");
  wait time - 1.7;
  mortar playSound("weap_mortar_incoming");
  wait 1.7;
}

function flare_mover(end) {
  self endon("death");

  while(isDefined(self)) {
    x = self.origin[0] + randomintrange(-5, 5);
    y = self.origin[1] + randomintrange(-5, 5);
    z = self.origin[2] - 15;
    self moveTo((x, y, z), 1);
    wait 1;
  }
}

function movemortar(model, start, end, time, height) {
  model endon("death");
  apex = 1200;

  if(isDefined(height)) {
    apex = height;
  }

  framefrac = 1 / time / 0.05;
  frac = 0;
  impact_point = undefined;

  while(frac < 1) {
    if(isDefined(impact_point)) {
      if(frac + framefrac < 1) {
        model.origin = impact_point;
        model notify("early_impact");
        return;
      }
    }

    model.origin = math::get_point_on_parabola(start, end, apex, frac);
    next_frac = frac + framefrac;
    next_point = math::get_point_on_parabola(start, end, apex, next_frac);
    impact_point = check_for_early_impact(model, next_point);
    model anglemortar();

    if(istrue(level.mortar_debug)) {
      thread draw_line_for_time(model.origin, model.origin + (0, 0, 128), 1, 1, 1, 0.05);
    }

    frac += framefrac;
    wait 0.05;
  }

  model.origin = end;

  if(istrue(level.mortar_debug)) {
    thread draw_line_for_time(model.origin, model.origin + (0, 0, 128), 1, 1, 1, 5);
  }
}

function check_for_early_impact(mortar, next_loc) {
  collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  raytrace = scripts\engine\trace::ray_trace(mortar.origin, next_loc, mortar, collisioncontents);

  if(raytrace["hittype"] != "hittype_none") {
    return next_loc;
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

function handle_ai_launcher_death(launcher) {
  self waittill("death");
  self endon("launch_done");

  if(isent(launcher)) {
    launcher hidepart("j_mortar_shell", "misc_wm_mortar");
  }
}

function run_to_and_set_alarm(var_deb561f66ca63d05) {
  self endon("death");
  old_radius = self.goalradius;

  if(!isDefined(var_deb561f66ca63d05.angles)) {
    var_deb561f66ca63d05.angles = (0, 0, 0);
  }

  alarm_box = getEnt(var_deb561f66ca63d05.target, "targetname");

  if(istrue(alarm_box.alarm_on)) {
    return;
  }

  self.going_to_object = var_deb561f66ca63d05;
  goto_anim_pos(var_deb561f66ca63d05, 1);
  ai_turnon_alarm(alarm_box);
  self.goalradius = old_radius;
  self.going_to_object = undefined;
  self.script_radius = self.goalradius;
  clear_custom_anim();
}

function ai_turnon_alarm(alarm_box) {
  alarm_box scriptmodelplayanim("wm_eq_fusebox_turn_on_prop");
  ai_anim("sdr_fusebox_on");
  alarm_fx_on(alarm_box);
  alarm_box ent_flag_set("switch_on");
  alarm_box thread auto_alarm_turnoff(60);
}

function auto_alarm_turnoff(timeout) {
  self endon("turned_off");
  wait timeout;
  self makeunusable();
  self scriptmodelplayanim("wm_eq_fusebox_prop");
  alarm_fx_off(self);
  ent_flag_clear("switch_on");
  wait 1;
  self makeusable();
}

function ai_turnoff_alarm(alarm_box) {
  alarm_box scriptmodelplayanim("wm_eq_fusebox_prop");
  ai_anim("sdr_fusebox_off");
  alarm_fx_off(alarm_box);
}

function alarm_box_player_interaction(alarm_box, toggle_fx) {
  alarm_box makeusable();
  alarm_box setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  alarm_box sethinttag("j_handle");
  alarm_box sethintdisplayrange(128);
  alarm_box setCursorHint("HINT_BUTTON");
  alarm_box sethinticon("icon_electrical_box");
  alarm_box sethintdisplayfov(120);
  alarm_box sethintonobstruction("hide");
  alarm_box sethintrequiresholding(0);
  alarm_box setuseholdduration("duration_short");
  alarm_box thread alarmbox2_logic(alarm_box, toggle_fx);
}

function toggle_alarm(alarm_box) {
  alarm_box.alarm_on = 0;

  while(true) {
    alarm_box waittill("trigger");
    alarm_box makeunusable();

    if(alarm_box.alarm_on) {
      alarm_box scriptmodelplayanim("wm_eq_fusebox_prop");
      alarm_fx_off(alarm_box);
    } else {
      scripts\asm\shared\mp\utility::animscripted_single("sdr_fusebox_on");
      alarm_fx_on(alarm_box);
      alarm_box thread auto_alarm_turnoff(60);
    }

    wait 3;
    alarm_box makeusable();
  }
}

function attract_agent_to_alarm(attract_pos, alarm_box) {
  attract_pos endon("stop_attracting");
  mortar = getclosest(attract_pos.origin, getEntArray("ai_flare", "targetname"), 512);

  if(isDefined(mortar)) {
    mortar.attracting = 0;
    mortar.fired = 0;
  }

  while(true) {
    if(istrue(alarm_box.alarm_on)) {
      while(istrue(alarm_box.alarm_on)) {
        wait 1;
      }

      if(isDefined(mortar)) {
        mortar notify("stop_attracting");
        mortar.attracting = 0;
      }
    } else {
      if(isDefined(mortar) && !mortar.attracting && !mortar.fired) {
        mortar thread attract_agent_to_mortar(mortar);
        mortar.attracting = 1;
      }

      runner = attract_an_agent(attract_pos, 2048);

      if(isDefined(runner)) {
        runner run_to_and_set_alarm(attract_pos);

        if(!alarm_box.alarm_on) {
          wait 2;
        } else {
          return;
        }
      }
    }

    wait 1;
  }
}

function attract_agent_to_mortar(mortar, var_68ee057779a106c1, radius_override) {
  mortar endon("stop_attracting");

  while(true) {
    runner = undefined;

    if(isDefined(mortar.operator) && isalive(mortar.operator)) {
      runner = mortar.operator;
    } else {
      if(isDefined(mortar.oncooldown) && gettime() < mortar.oncooldown) {
        wait 1;
        continue;
      }

      mortar.operator = undefined;
      rad = 1024;

      if(isDefined(radius_override)) {
        rad = radius_override;
      }

      runner = attract_an_agent(mortar, rad);
    }

    if(isDefined(runner)) {
      runner run_to_and_launch_flare(mortar, var_68ee057779a106c1);

      if(istrue(mortar.fired)) {
        level notify("flare_launched");
        mortar.attracting = 0;
        return;
      } else {
        wait 5;
      }
    }

    wait 1;
  }
}

function initialize_alarm_box(var_deb561f66ca63d05, toggle_fx) {
  if(!isDefined(toggle_fx)) {
    toggle_fx = 1;
  }

  alarm_box = getEnt(var_deb561f66ca63d05.target, "targetname");
  alarm_box_player_interaction(alarm_box, toggle_fx);
  var_deb561f66ca63d05.alarm_box = alarm_box;
  alarm_box ent_flag_init("switch_on");
  alarm_box.scenenode = var_deb561f66ca63d05;
}

function attract_an_agent(object, attract_radius) {
  alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  players_close = !istrue(object.ignoreplayers) && any_player_nearby(object.origin, squared(384));

  if(!alive_enemies.size || players_close) {
    return undefined;
  }

  closest_enemies = get_array_of_closest(object.origin, alive_enemies, undefined, 4, attract_radius);

  for(i = 0; i < closest_enemies.size; i++) {
    if(isDefined(closest_enemies[i].going_to_object)) {
      continue;
    }

    if(isDefined(closest_enemies[i].spawnpoint) && isDefined(closest_enemies[i].spawnpoint.script_aigroup) && closest_enemies[i].spawnpoint.script_aigroup == "nomortars") {
      continue;
    }

    if(!istrue(closest_enemies[i].entered_combat)) {
      continue;
    }

    if(closest_enemies[i] isjuggernaut()) {
      continue;
    }

    if(isDefined(closest_enemies[i].unittype) && closest_enemies[i].unittype == "suicidebomber") {
      continue;
    }

    if(istrue(closest_enemies[i].playing_skit)) {
      continue;
    }

    if(closest_enemies[i] scripts\cp\spawning::is_riding_vehicle()) {
      continue;
    }

    if(istrue(closest_enemies[i].attempting_teleport)) {
      continue;
    }

    arcname = undefined;

    if(isDefined(closest_enemies[i].animationarchetype)) {
      arcname = closest_enemies[i].animationarchetype;
    } else {
      arcname = closest_enemies[i].animsetname;
    }

    if(!isDefined(arcname)) {
      continue;
    }

    if(arcname != "soldier" && arcname != "soldier_cp") {
      continue;
    }

    return closest_enemies[i];
  }

  return undefined;
}

function clear_custom_anim() {
  self allowedstances("stand", "prone", "crouch");
  scripts\asm\shared\mp\utility::animscripted_clear();

  if(!istrue(self.dont_enter_combat)) {
    self.ignoreall = 0;
  }

  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

function alarm_fx_off(alarm_box) {
  light = getEnt(alarm_box.target, "targetname");
  speaker = getEnt(light.target, "targetname");
  light setModel("ee_light_mounted_exterior_industrial_caged_02");
  stopFXOnTag(level._effect["alarm_light_flash"], light, "tag_origin");
  speaker stoploopsound();
  self.alarm_on = 0;
  self setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  alarm_box notify("turned_off");
}

function alarm_fx_on(alarm_box) {
  light = getEnt(alarm_box.target, "targetname");
  speaker = getEnt(light.target, "targetname");
  light setModel("ee_light_mounted_exterior_industrial_caged_02_on");
  playFXOnTag(level._effect["alarm_light_flash"], light, "tag_origin");
  speaker playLoopSound("milbase_alarm");
  alarm_box setHintString(&"CP_STRIKE/TURN_OFF_ALARM");
  alarm_box.alarm_on = 1;
  level notify("alarm_on");
  level notify("weapons_free");
}

function run_to_and_plant_bomb(bomb_ent) {
  self endon("death");
  bomb_ent.planted = 0;
  self.going_to_object = bomb_ent;
  old_radius = self.goalradius;
  run_to_bomb_location(self, bomb_ent);
  plant_bomb(bomb_ent);
  bomb_ent.planted = 1;
  self.goalradius = old_radius;
  self.going_to_object = undefined;
  clear_custom_anim();
}

function run_to_bomb_location(agent, bomb_ent) {
  animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_plant_bomb");
  xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
  org = bomb_ent gettagorigin("tag_origin");
  ang = bomb_ent gettagangles("tag_origin");
  pos = spawnStruct();
  pos.origin = getstartorigin(org, ang, xanim);
  pos.angles = getstartangles(org, ang, xanim);
  pos.animindex = animindex;
  pos.xanim = xanim;
  agent.ignoreall = 1;
  agent goto_anim_pos(pos, 0);
}

function plant_bomb(bomb_ent) {
  charge = spawn("script_model", self.origin);
  charge.angles = self.angles;
  charge setModel("offhand_wm_c4");
  charge scriptmodelplayanimdeltamotion("wm_equip_c4_attach_c4");
  bomb_ent.charge = charge;
  thread plant_bomb_cleanup_on_death(bomb_ent, charge);
  charge thread show_charge();
  ai_anim_relative("sdr_plant_bomb", bomb_ent);
  self notify("bomb_planted");
}

function show_charge() {
  self endon("death");
  self hide();
  wait 0.5;
  self show();
}

function plant_bomb_cleanup_on_death(bomb_ent, charge) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(charge)) {
    charge delete();
  }
}

function attract_agent_to_bomb_plant(bomb_plant) {
  bomb_plant endon("stop_attracting");

  while(true) {
    runner = attract_an_agent(bomb_plant, 1024);

    if(isDefined(runner)) {
      runner run_to_and_plant_bomb(bomb_plant);

      if(istrue(bomb_plant.planted)) {
        bomb_plant.attracting = 0;
        return;
      } else {
        wait randomintrange(5, 10);
      }
    }

    wait 1;
  }
}

function alarmbox2_logic(alarm_box, toggle_fx) {
  level endon("game_ended");
  alarm_box.alarm_on = 0;

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    alarm_box makeunusable();
    actorplayer = anim_scene_create_actor(player, "player_rig", 1);
    var_3a5cd5b61d43290c = anim_scene_create_actor(self, "fusebox_prop");

    if(!ent_flag("switch_on")) {
      var_3a5cd5b61d43290c anim_scene_set_actor_interruptable(1, "interact_on", 1);
      result = self.scenenode anim_scene([var_3a5cd5b61d43290c], "interact_on");
      ent_flag_set("switch_on");
      alarm_box.alarm_on = 1;

      if(result && istrue(toggle_fx)) {
        alarm_fx_on(alarm_box);
      }
    } else {
      var_3a5cd5b61d43290c anim_scene_set_actor_interruptable(1, "interact", 1);
      result = self.scenenode anim_scene([var_3a5cd5b61d43290c], "interact");
      ent_flag_clear("switch_on");
      alarm_box.alarm_on = 0;

      if(result && istrue(toggle_fx)) {
        alarm_fx_off(alarm_box);
      }
    }

    alarm_box makeusable();
    actorplayer = undefined;
    var_3a5cd5b61d43290c = undefined;
  }
}

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["interact"] = % wm_eq_fusebox_plr;
  level.scr_eventanim["player_rig"]["interact"] = % "wm_eq_fusebox_plr";
  level.scr_anim["player_rig"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_eventanim["player_rig"]["interact_on"] = % "wm_eq_fusebox_turn_on_plr";
  level.scr_animtree["fusebox_prop"] = #animtree;
  level.scr_anim["fusebox_prop"]["interact"] = % wm_eq_fusebox_prop;
  level.scr_anim["fusebox_prop"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
}

function vo_incoming_mortar(pos) {
  snds = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  players = give_all_players_nearby(pos, squared(512));
  snd = random(snds);

  foreach(player in players) {
    if(!isDefined(player.next_mortar_vo)) {
      player.next_mortar_vo = gettime() + 30000;
    } else if(gettime() < player.next_mortar_vo) {
      continue;
    }

    player.next_mortar_vo = gettime() + 30000;
    thread scripts\cp\vo::try_to_play_vo_for_one_player(snd, player);
  }
}

function take_ai_weapon() {
  self.old_weapon = self.weapon;
  self.anim_weapon = scripts\cp_mp\weapon::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(self.anim_weapon);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.anim_weapon);
}

function restore_ai_weapon() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.anim_weapon);
  self setspawnweapon(self.old_weapon);
}

function waittill_near_goal(origin, radius) {
  if(!isDefined(origin)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  while(distancesquared(self.origin, origin) > radius) {
    wait 0.1;
  }
}

function clear_mortar_settings(launcher) {
  launcher notify("stop_attracting");
  clear_custom_anim();
  utility::clear_demeanor_override();

  if(isDefined(self.never_kill_off_old)) {
    self.never_kill_off = self.never_kill_off_old;
  }

  if(isDefined(self.dont_kill_off_old)) {
    self.dont_kill_off = self.dont_kill_off_old;
  }
}