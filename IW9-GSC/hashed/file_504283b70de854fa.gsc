/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_504283b70de854fa.gsc
***********************************************/

load_fx() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_flare_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw9/cp/vfx_cp_mortar_trail.vfx");
  level._effect["alarm_light_flash"] = loadfx("vfx/iw8_cp/level/cp_millbase/vfx_alarm_light.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
  script_model_anims();
  level.next_mortar_vo = gettime();
  level.mortars = [];
}

run_to_and_launch_flare(_id_DA16A810CED24CCD, _id_68EE057779A106C1) {
  self endon("death");
  self endon("teleport_to_nearby_spawner");
  _id_DA16A810CED24CCD.fired = 0;
  thread handle_ai_launcher_death(_id_DA16A810CED24CCD);
  self.going_to_object = _id_DA16A810CED24CCD;
  _id_327190E5347A2645 = self.goalradius;
  scripts\common\utility::demeanor_override("sprint");
  self.never_kill_off_old = self.never_kill_off;
  self.never_kill_off = 1;
  self.dont_kill_off_old = self.dont_kill_off;
  self.dont_kill_off = 1;
  run_to_launcher(_id_DA16A810CED24CCD);
  enter_launcher(_id_DA16A810CED24CCD);
  fire_launcher(_id_DA16A810CED24CCD);
  exit_launcher(_id_DA16A810CED24CCD);
  self.goalradius = _id_327190E5347A2645;
  self.going_to_object = undefined;

  if(isDefined(_id_68EE057779A106C1)) {
    self.goalradius = 128;
    _id_DA16A810CED24CCD.operator = self;
    thread mortar_cooldown(_id_DA16A810CED24CCD);
  }

  clear_custom_anim();
  scripts\common\utility::clear_demeanor_override();

  if(isDefined(self.never_kill_off_old))
    self.never_kill_off = self.never_kill_off_old;

  if(isDefined(self.dont_kill_off_old))
    self.dont_kill_off = self.dont_kill_off_old;
}

mortar_cooldown(_id_DA16A810CED24CCD) {
  scripts\engine\utility::waittill_any_2("death", "teleport_to_nearby_spawner");

  if(isDefined(_id_DA16A810CED24CCD) && isent(_id_DA16A810CED24CCD)) {
    _id_DA16A810CED24CCD.operator = undefined;
    _id_DA16A810CED24CCD.oncooldown = gettime() + 45000;
  }
}

enter_launcher(_id_DA16A810CED24CCD) {
  ai_anim("sdr_mortar_enter", 0.7);
  _id_DA16A810CED24CCD scriptmodelplayanimdeltamotion("emb_vm_mortar_mortar", "mortar", 0.7);
  wait 0.5;
  _id_DA16A810CED24CCD showpart("j_mortar_shell", "misc_wm_mortar");
  wait 0.2;
}

fire_launcher(_id_DA16A810CED24CCD) {
  ai_anim("sdr_mortar_launch", 0.4);

  if(_id_DA16A810CED24CCD.script_noteworthy == "flare")
    _id_DA16A810CED24CCD thread launch_illumination_flare();
  else
    _id_DA16A810CED24CCD thread launch_mortar(undefined, undefined, self);

  _id_DA16A810CED24CCD hidepart("j_mortar_shell", "misc_wm_mortar");
  wait 0.4;
  self notify("launch_done");
  _id_DA16A810CED24CCD.fired = 1;
}

exit_launcher(_id_DA16A810CED24CCD) {
  ai_anim("sdr_mortar_exit");
}

reload_launcher(_id_DA16A810CED24CCD) {
  _id_DA16A810CED24CCD scriptmodelplayanimdeltamotion("emb_wm_mortar_reload_mortar");
  ai_anim("sdr_mortar_reload");
}

run_to_launcher(_id_DA16A810CED24CCD) {
  goal = get_flare_launch_entrance(self, _id_DA16A810CED24CCD);
  goto_anim_pos(goal, 0);
}

get_flare_launch_entrance(agent, _id_DA16A810CED24CCD) {
  if(getDvar("ui_mapname") == "cp_observatory" || getDvar("ui_mapname") == "cp_lone") {
    org = _id_DA16A810CED24CCD gettagorigin("tag_origin");
    _id_8BC14603A27FA3E7 = _id_DA16A810CED24CCD gettagangles("tag_origin");
    pos = spawnStruct();
    pos.origin = org + anglesToForward(_id_DA16A810CED24CCD.angles) * 5;
    pos.angles = _id_8BC14603A27FA3E7;
    return pos;
  }

  animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_mortar_enter");
  xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
  org = _id_DA16A810CED24CCD gettagorigin("tag_origin");
  _id_8BC14603A27FA3E7 = _id_DA16A810CED24CCD gettagangles("tag_origin");
  pos = spawnStruct();
  pos.origin = getstartorigin(org, _id_8BC14603A27FA3E7, xanim) + anglesToForward(_id_DA16A810CED24CCD.angles) * 5;
  pos.angles = getstartangles(org, _id_8BC14603A27FA3E7, xanim);
  pos.animindex = animindex;
  pos.xanim = xanim;
  return pos;
}

ai_anim(animalias, early_return) {
  if(getDvar("ui_mapname") == "cp_observatory") {
    return;
  }
  take_ai_weapon();

  if(isDefined(early_return))
    scripts\asm\shared\mp\utility::animscripted_single_earlyend(animalias, early_return);
  else
    scripts\asm\shared\mp\utility::animscripted_single(animalias);

  restore_ai_weapon();
}

ai_anim_relative(animalias, ent) {
  take_ai_weapon();
  scripts\asm\shared\mp\utility::animscripted_single_relative(animalias, ent);
  restore_ai_weapon();
}

goto_anim_pos(goal, _id_EE91862B850C90E5) {
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

  if(!isDefined(goal.angles))
    goal.angles = (0, 0, 0);

  self setplayerangles(goal.angles);
  self forceteleport(goal.origin, goal.angles);

  if(istrue(_id_EE91862B850C90E5)) {
    self.anchor = spawn("script_origin", goal.origin);
    self.anchor.angles = goal.angles;
    self linkTo(self.anchor);
  }
}

launch_illumination_flare(start, end) {
  if(!isDefined(start))
    start = self gettagorigin("j_shaft_top");

  if(!isDefined(end))
    end = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);

  flare = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  flare show();
  time = 2.25;
  thread movemortar(flare, start, end, time, 400);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), flare, "tag_origin");
  flare playsoundonmovingent("weap_mortar_flare_whistle");
  wait(time);
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare"), flare, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), flare, "tag_origin");
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

launch_mortar(start, end, agent, _id_C02451AC9545F97D) {
  if(!isDefined(start))
    start = self gettagorigin("j_shaft_top");

  if(isDefined(level.get_mortar_impact_pos))
    end = agent[[level.get_mortar_impact_pos]](self);

  if(!isDefined(end))
    end = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);

  thread vo_incoming_mortar(end);
  _id_92753DA39919F200 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_fire_dist");
  _id_92753DA39919F200 show();
  level.mortars = scripts\engine\utility::array_add(level.mortars, _id_92753DA39919F200);
  time = 5;
  _id_C67BC51788C0EB65 = 1200;

  if(isDefined(_id_C02451AC9545F97D))
    _id_C67BC51788C0EB65 = _id_C02451AC9545F97D;

  thread movemortar(_id_92753DA39919F200, start, end, time, _id_C67BC51788C0EB65);
  wait_until_impact(_id_92753DA39919F200, time);

  if(isDefined(_id_92753DA39919F200)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), _id_92753DA39919F200, "tag_origin");
    _id_92753DA39919F200 stoploopsound();
    end = _id_92753DA39919F200.origin;
    _id_29B6333B64DE3FFD = (0, 0, 40);

    if(isalive(agent))
      radiusdamage(end + _id_29B6333B64DE3FFD, 256, 200, 150, agent, "MOD_EXPLOSIVE", "c4_mp");
    else
      radiusdamage(end + _id_29B6333B64DE3FFD, 256, 200, 150, _id_92753DA39919F200, "MOD_EXPLOSIVE", "c4_mp");

    playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), end);
    earthquake(0.25, 3, end, 2048);
    playrumbleonposition("cp_chopper_rumble", end);
    magicgrenademanual("mortar_mp", end + (0, 0, 5), (0, 0, 0), 0.05);
    level.mortars = scripts\engine\utility::array_remove(level.mortars, _id_92753DA39919F200);
    _id_92753DA39919F200 delete();
  } else
    level.mortars = scripts\engine\utility::array_removeundefined(level.mortars);
}

wait_until_impact(_id_92753DA39919F200, time) {
  _id_92753DA39919F200 endon("early_impact");
  _id_92753DA39919F200 endon("death");
  _id_92753DA39919F200 setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), _id_92753DA39919F200, "tag_origin");
  _id_92753DA39919F200 playLoopSound("weap_mortar_fly_lp");
  wait(time - 1.7);
  _id_92753DA39919F200 playSound("weap_mortar_incoming");
  wait 1.7;
}

flare_mover(end) {
  self endon("death");

  while(isDefined(self)) {
    x = self.origin[0] + randomintrange(-5, 5);
    y = self.origin[1] + randomintrange(-5, 5);
    z = self.origin[2] - 15;
    self moveTo((x, y, z), 1);
    wait 1;
  }
}

movemortar(model, start, end, time, height) {
  model endon("death");
  _id_2555CAFD1E701BA5 = 1200;

  if(isDefined(height))
    _id_2555CAFD1E701BA5 = height;

  _id_9D9BCB154A71E0E6 = 1 / (time / 0.05);
  frac = 0;
  _id_E1EC1ADE6AFDBB7A = undefined;

  while(frac < 1) {
    if(isDefined(_id_E1EC1ADE6AFDBB7A)) {
      if(frac + _id_9D9BCB154A71E0E6 < 1) {
        model.origin = _id_E1EC1ADE6AFDBB7A;
        model notify("early_impact");
        return;
      }
    }

    model.origin = scripts\engine\math::get_point_on_parabola(start, end, _id_2555CAFD1E701BA5, frac);
    _id_630782B398951805 = frac + _id_9D9BCB154A71E0E6;
    _id_BE27B40782202CF5 = scripts\engine\math::get_point_on_parabola(start, end, _id_2555CAFD1E701BA5, _id_630782B398951805);
    _id_E1EC1ADE6AFDBB7A = check_for_early_impact(model, _id_BE27B40782202CF5);
    model anglemortar();
    frac = frac + _id_9D9BCB154A71E0E6;
    wait 0.05;
  }

  model.origin = end;
}

check_for_early_impact(_id_92753DA39919F200, _id_04830B28D31D6219) {
  _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  _id_214D77BB9D513C28 = scripts\engine\trace::ray_trace(_id_92753DA39919F200.origin, _id_04830B28D31D6219, _id_92753DA39919F200, _id_1BFA180C6FDD09DD);

  if(_id_214D77BB9D513C28["hittype"] != "hittype_none")
    return _id_04830B28D31D6219;
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

handle_ai_launcher_death(_id_DA16A810CED24CCD) {
  self waittill("death");
  self endon("launch_done");

  if(isent(_id_DA16A810CED24CCD))
    _id_DA16A810CED24CCD hidepart("j_mortar_shell", "misc_wm_mortar");
}

run_to_and_set_alarm(_id_DEB561F66CA63D05) {
  self endon("death");
  _id_327190E5347A2645 = self.goalradius;

  if(!isDefined(_id_DEB561F66CA63D05.angles))
    _id_DEB561F66CA63D05.angles = (0, 0, 0);

  alarm_box = getEnt(_id_DEB561F66CA63D05.target, "targetname");

  if(istrue(alarm_box.alarm_on)) {
    return;
  }
  self.going_to_object = _id_DEB561F66CA63D05;
  goto_anim_pos(_id_DEB561F66CA63D05, 1);
  ai_turnon_alarm(alarm_box);
  self.goalradius = _id_327190E5347A2645;
  self.going_to_object = undefined;
  self.script_radius = self.goalradius;
  clear_custom_anim();
}

ai_turnon_alarm(alarm_box) {
  alarm_box scriptmodelplayanim("wm_eq_fusebox_turn_on_prop");
  ai_anim("sdr_fusebox_on");
  alarm_fx_on(alarm_box);
  alarm_box scripts\engine\utility::ent_flag_set("switch_on");
  alarm_box thread auto_alarm_turnoff(60);
}

auto_alarm_turnoff(timeout) {
  self endon("turned_off");
  wait(timeout);
  self makeunusable();
  self scriptmodelplayanim("wm_eq_fusebox_prop");
  alarm_fx_off(self);
  scripts\engine\utility::ent_flag_clear("switch_on");
  wait 1;
  self makeusable();
}

ai_turnoff_alarm(alarm_box) {
  alarm_box scriptmodelplayanim("wm_eq_fusebox_prop");
  ai_anim("sdr_fusebox_off");
  alarm_fx_off(alarm_box);
}

alarm_box_player_interaction(alarm_box, _id_2F65B66ED6D6CFF4) {
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
  alarm_box thread alarmbox2_logic(alarm_box, _id_2F65B66ED6D6CFF4);
}

toggle_alarm(alarm_box) {
  alarm_box.alarm_on = 0;

  for(;;) {
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

attract_agent_to_alarm(_id_268A5232CA0D0C8F, alarm_box) {
  _id_268A5232CA0D0C8F endon("stop_attracting");
  _id_92753DA39919F200 = scripts\engine\utility::getclosest(_id_268A5232CA0D0C8F.origin, getEntArray("ai_flare", "targetname"), 512);

  if(isDefined(_id_92753DA39919F200)) {
    _id_92753DA39919F200.attracting = 0;
    _id_92753DA39919F200.fired = 0;
  }

  for(;;) {
    if(istrue(alarm_box.alarm_on)) {
      while(istrue(alarm_box.alarm_on))
        wait 1;

      if(isDefined(_id_92753DA39919F200)) {
        _id_92753DA39919F200 notify("stop_attracting");
        _id_92753DA39919F200.attracting = 0;
      }
    } else {
      if(isDefined(_id_92753DA39919F200) && !_id_92753DA39919F200.attracting && !_id_92753DA39919F200.fired) {
        _id_92753DA39919F200 thread attract_agent_to_mortar(_id_92753DA39919F200);
        _id_92753DA39919F200.attracting = 1;
      }

      runner = attract_an_agent(_id_268A5232CA0D0C8F, 2048);

      if(isDefined(runner)) {
        runner run_to_and_set_alarm(_id_268A5232CA0D0C8F);

        if(!alarm_box.alarm_on)
          wait 2;
        else
          return;
      }
    }

    wait 1;
  }
}

attract_agent_to_mortar(_id_92753DA39919F200, _id_68EE057779A106C1, _id_921B9D1AB6394420) {
  _id_92753DA39919F200 endon("stop_attracting");

  for(;;) {
    runner = undefined;

    if(isDefined(_id_92753DA39919F200.operator) && isalive(_id_92753DA39919F200.operator))
      runner = _id_92753DA39919F200.operator;
    else {
      if(isDefined(_id_92753DA39919F200.oncooldown) && gettime() < _id_92753DA39919F200.oncooldown) {
        wait 1;
        continue;
      }

      _id_92753DA39919F200.operator = undefined;
      _id_CB920E03144E9344 = 1024;

      if(isDefined(_id_921B9D1AB6394420))
        _id_CB920E03144E9344 = _id_921B9D1AB6394420;

      runner = attract_an_agent(_id_92753DA39919F200, _id_CB920E03144E9344);
    }

    if(isDefined(runner)) {
      runner run_to_and_launch_flare(_id_92753DA39919F200, _id_68EE057779A106C1);

      if(istrue(_id_92753DA39919F200.fired)) {
        level notify("flare_launched");
        _id_92753DA39919F200.attracting = 0;
        return;
      } else
        wait 5;
    }

    wait 1;
  }
}

initialize_alarm_box(_id_DEB561F66CA63D05, _id_2F65B66ED6D6CFF4) {
  if(!isDefined(_id_2F65B66ED6D6CFF4))
    _id_2F65B66ED6D6CFF4 = 1;

  alarm_box = getEnt(_id_DEB561F66CA63D05.target, "targetname");
  alarm_box_player_interaction(alarm_box, _id_2F65B66ED6D6CFF4);
  _id_DEB561F66CA63D05.alarm_box = alarm_box;
  alarm_box scripts\engine\utility::ent_flag_init("switch_on");
  alarm_box.scenenode = _id_DEB561F66CA63D05;
}

attract_an_agent(object, _id_CC320710D7E6088D) {
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  _id_7DD0D3D7980CE362 = !istrue(object.ignoreplayers) && scripts\cp\utility::any_player_nearby(object.origin, squared(384));

  if(!_id_CCC9F9C05ABCFDE9.size || _id_7DD0D3D7980CE362)
    return undefined;

  _id_4CF33B57655A86C3 = scripts\engine\utility::get_array_of_closest(object.origin, _id_CCC9F9C05ABCFDE9, undefined, 4, _id_CC320710D7E6088D);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4CF33B57655A86C3.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].going_to_object)) {
      continue;
    }
    if(isDefined(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].spawnpoint) && isDefined(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].spawnpoint.script_aigroup) && _id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].spawnpoint.script_aigroup == "nomortars") {
      continue;
    }
    if(!istrue(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].entered_combat)) {
      continue;
    }
    if(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8] scripts\cp\utility::isjuggernaut()) {
      continue;
    }
    if(isDefined(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].unittype) && _id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].unittype == "suicidebomber") {
      continue;
    }
    if(istrue(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].playing_skit)) {
      continue;
    }
    if(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::is_riding_vehicle()) {
      continue;
    }
    if(istrue(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].attempting_teleport)) {
      continue;
    }
    _id_38548703EA2BDADC = undefined;

    if(isDefined(_id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].animationarchetype))
      _id_38548703EA2BDADC = _id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8].animationarchetype;
    else
      _id_38548703EA2BDADC = _id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8]._id_AE3EA15396B65C1F;

    if(!isDefined(_id_38548703EA2BDADC)) {
      continue;
    }
    if(_id_38548703EA2BDADC != "soldier" && _id_38548703EA2BDADC != "soldier_cp") {
      continue;
    }
    return _id_4CF33B57655A86C3[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

clear_custom_anim() {
  self allowedstances("stand", "prone", "crouch");
  scripts\asm\shared\mp\utility::animscripted_clear();

  if(!istrue(self.dont_enter_combat))
    self.ignoreall = 0;

  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

alarm_fx_off(alarm_box) {
  light = getEnt(alarm_box.target, "targetname");
  _id_7D2852D02216C876 = getEnt(light.target, "targetname");
  light setModel("ee_light_mounted_exterior_industrial_caged_02");
  stopFXOnTag(level._effect["alarm_light_flash"], light, "tag_origin");
  _id_7D2852D02216C876 stoploopsound();
  self.alarm_on = 0;
  self setHintString(&"CP_STRIKE/TURN_ON_ALARM");
  alarm_box notify("turned_off");
}

alarm_fx_on(alarm_box) {
  light = getEnt(alarm_box.target, "targetname");
  _id_7D2852D02216C876 = getEnt(light.target, "targetname");
  light setModel("ee_light_mounted_exterior_industrial_caged_02_on");
  playFXOnTag(level._effect["alarm_light_flash"], light, "tag_origin");
  _id_7D2852D02216C876 playLoopSound("milbase_alarm");
  alarm_box setHintString(&"CP_STRIKE/TURN_OFF_ALARM");
  alarm_box.alarm_on = 1;
  level notify("alarm_on");
  level notify("weapons_free");
}

run_to_and_plant_bomb(_id_DE1467AC3ED1D213) {
  self endon("death");
  _id_DE1467AC3ED1D213.planted = 0;
  self.going_to_object = _id_DE1467AC3ED1D213;
  _id_327190E5347A2645 = self.goalradius;
  run_to_bomb_location(self, _id_DE1467AC3ED1D213);
  plant_bomb(_id_DE1467AC3ED1D213);
  _id_DE1467AC3ED1D213.planted = 1;
  self.goalradius = _id_327190E5347A2645;
  self.going_to_object = undefined;
  clear_custom_anim();
}

run_to_bomb_location(agent, _id_DE1467AC3ED1D213) {
  animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_plant_bomb");
  xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
  org = _id_DE1467AC3ED1D213 gettagorigin("tag_origin");
  _id_8BC14603A27FA3E7 = _id_DE1467AC3ED1D213 gettagangles("tag_origin");
  pos = spawnStruct();
  pos.origin = getstartorigin(org, _id_8BC14603A27FA3E7, xanim);
  pos.angles = getstartangles(org, _id_8BC14603A27FA3E7, xanim);
  pos.animindex = animindex;
  pos.xanim = xanim;
  agent.ignoreall = 1;
  agent goto_anim_pos(pos, 0);
}

plant_bomb(_id_DE1467AC3ED1D213) {
  charge = spawn("script_model", self.origin);
  charge.angles = self.angles;
  charge setModel("offhand_wm_c4");
  charge scriptmodelplayanimdeltamotion("wm_equip_c4_attach_c4");
  _id_DE1467AC3ED1D213.charge = charge;
  thread plant_bomb_cleanup_on_death(_id_DE1467AC3ED1D213, charge);
  charge thread show_charge();
  ai_anim_relative("sdr_plant_bomb", _id_DE1467AC3ED1D213);
  self notify("bomb_planted");
}

show_charge() {
  self endon("death");
  self hide();
  wait 0.5;
  self show();
}

plant_bomb_cleanup_on_death(_id_DE1467AC3ED1D213, charge) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(charge))
    charge delete();
}

attract_agent_to_bomb_plant(_id_1B3A8AF37328E37B) {
  _id_1B3A8AF37328E37B endon("stop_attracting");

  for(;;) {
    runner = attract_an_agent(_id_1B3A8AF37328E37B, 1024);

    if(isDefined(runner)) {
      runner run_to_and_plant_bomb(_id_1B3A8AF37328E37B);

      if(istrue(_id_1B3A8AF37328E37B.planted)) {
        _id_1B3A8AF37328E37B.attracting = 0;
        return;
      } else
        wait(randomintrange(5, 10));
    }

    wait 1;
  }
}

alarmbox2_logic(alarm_box, _id_2F65B66ED6D6CFF4) {
  level endon("game_ended");
  alarm_box.alarm_on = 0;

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    alarm_box makeunusable();
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig", 1);
    _id_3A5CD5B61D43290C = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "fusebox_prop");

    if(!scripts\engine\utility::ent_flag("switch_on")) {
      _id_3A5CD5B61D43290C scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact_on", 1);
      result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([_id_3A5CD5B61D43290C], "interact_on");
      scripts\engine\utility::ent_flag_set("switch_on");
      alarm_box.alarm_on = 1;

      if(result && istrue(_id_2F65B66ED6D6CFF4))
        alarm_fx_on(alarm_box);
    } else {
      _id_3A5CD5B61D43290C scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "interact", 1);
      result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([_id_3A5CD5B61D43290C], "interact");
      scripts\engine\utility::ent_flag_clear("switch_on");
      alarm_box.alarm_on = 0;

      if(result && istrue(_id_2F65B66ED6D6CFF4))
        alarm_fx_off(alarm_box);
    }

    alarm_box makeusable();
    actorplayer = undefined;
    _id_3A5CD5B61D43290C = undefined;
  }
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["interact"] = % wm_eq_fusebox_plr;
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

vo_incoming_mortar(pos) {
  _id_3FE46CB10BD07785 = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  players = scripts\cp\utility::give_all_players_nearby(pos, squared(512));
  _id_BE3605030AEF1714 = scripts\engine\utility::random(_id_3FE46CB10BD07785);

  foreach(player in players) {
    if(!isDefined(player.next_mortar_vo))
      player.next_mortar_vo = gettime() + 30000;
    else if(gettime() < player.next_mortar_vo) {
      continue;
    }
    player.next_mortar_vo = gettime() + 30000;
    thread _id_166B4F052DA169A7::try_to_play_vo_for_one_player(_id_BE3605030AEF1714, player);
  }
}

take_ai_weapon() {
  self.old_weapon = self.weapon;
  self.anim_weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(self.anim_weapon);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.anim_weapon);
}

restore_ai_weapon() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.anim_weapon);
  self setspawnweapon(self.old_weapon);
}

waittill_near_goal(origin, radius) {
  if(!isDefined(origin)) {
    return;
  }
  while(distancesquared(self.origin, origin) > radius)
    wait 0.1;
}

clear_mortar_settings(_id_DA16A810CED24CCD) {
  _id_DA16A810CED24CCD notify("stop_attracting");
  clear_custom_anim();
  scripts\common\utility::clear_demeanor_override();

  if(isDefined(self.never_kill_off_old))
    self.never_kill_off = self.never_kill_off_old;

  if(isDefined(self.dont_kill_off_old))
    self.dont_kill_off = self.dont_kill_off_old;
}