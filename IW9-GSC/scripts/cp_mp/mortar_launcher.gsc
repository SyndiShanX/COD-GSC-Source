/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\mortar_launcher.gsc
***********************************************/

mortar_launcher_init() {
  load_fx();
  mortars = getEntArray("player_mortar", "targetname");

  if(isDefined(mortars) && mortars.size > 0) {
    setupmortarmodelanimscripts();
    setupmortarplayeranimscripts();
  } else
    return;

  foreach(_id_92753DA39919F200 in mortars) {
    if(istrue(level.ismp)) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(_id_92753DA39919F200.script_noteworthy) && _id_92753DA39919F200.script_noteworthy != level.localeid) {
        _id_92753DA39919F200 delete();
        continue;
      }
    }

    _id_92753DA39919F200 thread mortar_test(_id_92753DA39919F200);
  }
}

load_fx() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
}

#using_animtree("script_model");

setupmortarplayeranimscripts() {
  level.scr_animtree["player_mortar"] = #animtree;
  level.scr_anim["player_mortar"]["player_mortar_fire"] = % emb_vm_mortar_player;
  level.scr_animname["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
  level.scr_eventanim["player_mortar"]["player_mortar_fire"] = "player_mortar_fire";
  level.scr_viewmodelanim["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
}

setupmortarmodelanimscripts() {
  level.scr_animtree["mortar"] = #animtree;
  level.scr_model["mortar"] = "misc_wm_mortar";
  level.scr_anim["mortar"]["player_mortar_fire"] = % emb_vm_mortar_mortar;
  level.scr_animname["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
  level.scr_viewmodelanim["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
}

create_player_rig(player, animname, _id_486DB5FA512A3B6B, _id_CE4AF45F8FFF86B7) {
  if(!isDefined(player)) {
    return;
  }
  player.animname = animname;
  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
}

put_player_into_rig(rig, _id_D180B535A33B044D, right, left, top, _id_8A925332BA34F25E, player) {
  player _id_3B64EB40368C1450::set("put_player_into_rig", "ads", 0);
  player _id_3B64EB40368C1450::set("put_player_into_rig", "prone", 0);
  player _id_3B64EB40368C1450::set("put_player_into_rig", "crouch", 0);
  player _id_3B64EB40368C1450::set("put_player_into_rig", "weapon_switch", 0);

  if(_id_D180B535A33B044D > 0.0) {
    player playerlinktoblend(rig, "tag_player", _id_D180B535A33B044D, 0, 0);
    wait(_id_D180B535A33B044D);
  }

  player playerlinktodelta(rig, "tag_player", 1, right, left, top, _id_8A925332BA34F25E, 1);
}

take_player_out_of_rig(player) {
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("mortar");
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("put_player_into_rig");
  player unlink();
  player.player_rig delete();
}

mortar_launch_player_effect(player, _id_92753DA39919F200) {
  if(!istrue(level.ismp))
    _id_92753DA39919F200 playSound("weap_mortar_load");

  wait 2.2;
  player playRumbleOnEntity("damage_bullet");
  earthquake(0.24, 1, _id_92753DA39919F200.origin, 256);
  _id_92753DA39919F200 hidepart(_id_92753DA39919F200.shell, "misc_wm_mortar");
}

movemortar(model, start, end, time, height) {
  setdvarifuninitialized("dvar_7A0D2F4714304D2B", "0 ");

  if(getdvarint("dvar_7A0D2F4714304D2B")) {
    model.origin = start;
    gravity = getdvarint("bg_gravity");
    dist = distance(start, end);
    _id_3777ECE6A73EADA5 = end - start;
    _id_920F4173513EB6B8 = 0.5 * gravity * squared(time) * -1;
    vel = (_id_3777ECE6A73EADA5[0] / time, _id_3777ECE6A73EADA5[1] / time, (_id_3777ECE6A73EADA5[2] - _id_920F4173513EB6B8) / time);
    model movegravity(vel, time);
    endtime = gettime() + time * 1000;

    while(gettime() < endtime) {
      model anglemortar();
      waitframe();
    }
  } else {
    _id_2555CAFD1E701BA5 = 1200;

    if(isDefined(height))
      _id_2555CAFD1E701BA5 = height;

    _id_9D9BCB154A71E0E6 = 1 / (time / 0.05);
    frac = 0;

    while(frac < 1) {
      model.origin = scripts\engine\math::get_point_on_parabola(start, end, _id_2555CAFD1E701BA5, frac);
      model anglemortar();
      frac = frac + _id_9D9BCB154A71E0E6;
      wait 0.05;
    }

    model.origin = end;
  }
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

mortar_test(_id_92753DA39919F200) {
  if(!istrue(level.ismp))
    _id_92753DA39919F200.interact = mortarlauncher_createhintobject(_id_92753DA39919F200.origin + (0, 0, 40), "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/ROOF_DEFEND", undefined, undefined, "show", 50, 160, 32, 120);
  else
    _id_92753DA39919F200.interact = mortarlauncher_createhintobject(_id_92753DA39919F200.origin + (0, 0, 40), "HINT_BUTTON", undefined, &"MP_INGAME_ONLY/USE_MORTAR", undefined, undefined, "show", 256, 160, 128, 160);

  _id_92753DA39919F200.flash = "j_shaft_top";
  _id_92753DA39919F200.shell = "j_mortar_shell";
  _id_92753DA39919F200 hidepart(_id_92753DA39919F200.shell, "misc_wm_mortar");
  _id_92753DA39919F200.animname = "mortar";
  _id_92753DA39919F200 useanimtree(#animtree);
  _id_92753DA39919F200.og_angles = _id_92753DA39919F200.angles;

  for(;;) {
    _id_92753DA39919F200.interact makeusable();
    _id_92753DA39919F200.interact waittill("trigger", player);
    player _id_3B64EB40368C1450::set("mortar_test", "usability", 0);
    _id_92753DA39919F200.interact makeunusable();
    player_launch_mortar(player, _id_92753DA39919F200);
    wait 5;
    _id_92753DA39919F200 rotateTo(_id_92753DA39919F200.og_angles, 0.1);
    wait 1;
  }
}

player_launch_mortar(player, _id_92753DA39919F200) {
  self endon("death_or_disconnect");
  player setOrigin(_id_92753DA39919F200.origin);
  player setplayerangles(_id_92753DA39919F200.angles);
  player create_player_rig(player, "player_mortar");
  player.player_rig.angles = _id_92753DA39919F200.angles;
  put_player_into_rig(player.player_rig, 0.5, 0, 0, 0, 0, player);
  player _id_3B64EB40368C1450::set("mortar", "weapon", 0);
  result = player mortar_targetting(_id_92753DA39919F200);

  if(isDefined(result)) {
    player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
    angles = vectortoangles(result - _id_92753DA39919F200.origin);
    _id_92753DA39919F200.angles = (0, angles[1], 0);
    _id_92753DA39919F200 showpart(_id_92753DA39919F200.shell, "misc_wm_mortar");
    player.player_rig show();
    _id_92753DA39919F200 scripts\engine\utility::delaythread(2.25, ::launch_mortar, result, player);
    thread mortar_launch_player_effect(player, _id_92753DA39919F200);
    _id_92753DA39919F200 thread scripts\common\anim::anim_single([_id_92753DA39919F200, player.player_rig], "player_mortar_fire");
    player.player_rig waittillmatch("single anim", "end");
    _id_92753DA39919F200 notify("mortar_fired");
  }

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("mortar_test");
  _id_92753DA39919F200 hidepart(_id_92753DA39919F200.shell, "misc_wm_mortar");
  take_player_out_of_rig(player);

  if(isDefined(_id_92753DA39919F200.previs_model))
    _id_92753DA39919F200.previs_model delete();
}

mortar_targetting(_id_92753DA39919F200) {
  self endon("death_or_disconnect");
  thread mortar_ondeathcleanup(_id_92753DA39919F200);
  pos = undefined;
  self playerlinktodelta(self.player_rig, "tag_player", 0, 45, 45, 60, 60, 1);

  if(isDefined(_id_92753DA39919F200.previs_model))
    _id_92753DA39919F200.previs_model setscriptablepartstate("target", "active");

  for(;;) {
    if(self stancebuttonPressed() || self attackButtonPressed()) {
      if(self attackButtonPressed()) {
        while(self attackButtonPressed())
          wait 0.05;

        return pos;
      }

      while(self stancebuttonPressed())
        wait 0.05;

      return undefined;
    }

    trace = scripts\engine\trace::ray_trace(self getEye() + (0, 0, 128), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    pos = getgroundposition(trace["position"], 8, 0, 1500);
    angles = vectortoangles(pos - _id_92753DA39919F200.origin);
    _id_92753DA39919F200.angles = (0, angles[1], 0);

    if(!isDefined(_id_92753DA39919F200.previs_model)) {
      _id_92753DA39919F200.previs_model = spawn("script_model", pos);
      _id_92753DA39919F200.previs_model setModel("mortar_target");
      _id_92753DA39919F200.previs_model.angles = (-90, 0, 0);
      _id_92753DA39919F200.previs_model setscriptablepartstate("target", "active");

      foreach(player in level.players)
      _id_92753DA39919F200.previs_model hidefromplayer(player);

      _id_92753DA39919F200.previs_model showtoplayer(self);
    }

    _id_92753DA39919F200.previs_model moveTo(pos + (0, 0, 10), 0.1);
    wait 0.05;
  }
}

mortar_ondeathcleanup(_id_92753DA39919F200) {
  _id_92753DA39919F200 endon("mortar_fired");
  self waittill("death_or_disconnect");

  if(isDefined(_id_92753DA39919F200.previs_model))
    _id_92753DA39919F200.previs_model delete();
}

launch_mortar(endpos, player) {
  start = self gettagorigin("j_shaft_top");
  end = getgroundposition(self.origin + anglesToForward(self.angles) * 8000, 8, 1000);

  if(isDefined(endpos))
    end = endpos;

  _id_92753DA39919F200 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  _id_92753DA39919F200 setModel("equipment_mortar_shell_improvised_01_mp");
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));

  if(!istrue(level.ismp))
    playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  else
    playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");

  _id_92753DA39919F200 show();
  time = 5;
  thread movemortar(_id_92753DA39919F200, start, end, time, 1200);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), _id_92753DA39919F200, "tag_origin");

  if(!istrue(level.ismp))
    _id_92753DA39919F200 playLoopSound("weap_mortar_fly_lp");
  else
    _id_92753DA39919F200 playLoopSound("weap_mortar_fly_lp");

  wait(time - 1.7);

  if(!istrue(level.ismp))
    _id_92753DA39919F200 playSound("weap_mortar_incoming");

  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), _id_92753DA39919F200, "tag_origin");
  _id_92753DA39919F200 stoploopsound();
  playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), end);
  earthquake(0.25, 3, end, 2048);

  if(!istrue(level.ismp))
    playrumbleonposition("cp_chopper_rumble", end);
  else {
    playrumbleonposition("grenade_rumble", end);
    playsoundatpos(end, "weap_mortar_expl_trans");
  }

  magicgrenademanual("mortar_mp", end + (0, 0, 5), (0, 0, 0), 0.05);

  if(!istrue(level.ismp))
    radiusdamage(end + (0, 0, 5), 512, 250, 250, player, "MOD_EXPLOSIVE", "c4_mp");
  else
    radiusdamage(end + (0, 0, 5), 512, 1000, 250, player, "MOD_EXPLOSIVE", "c4_mp");

  _id_92753DA39919F200 delete();
}

kill_mortar_target() {
  self.previs_model setscriptablepartstate("target", "neutral");
}

mortarlauncher_createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, _id_DBCE45A33308630D) {
  hintobj = undefined;

  if(isDefined(_id_DBCE45A33308630D))
    hintobj = _id_DBCE45A33308630D;
  else
    hintobj = spawn("script_model", org);

  hintobj makeusable();

  if(isDefined(_id_DBCE45A33308630D) && isDefined(org))
    hintobj sethinttag(org);

  if(isDefined(type))
    hintobj setCursorHint(type);
  else
    hintobj setCursorHint("HINT_NOICON");

  if(isDefined(icon))
    hintobj sethinticon(icon);

  if(isDefined(hintstring))
    hintobj setHintString(hintstring);

  if(isDefined(priority))
    hintobj setusepriority(priority);
  else
    hintobj setusepriority(0);

  if(isDefined(duration))
    hintobj setuseholdduration(duration);
  else
    hintobj setuseholdduration("duration_short");

  if(isDefined(onobstruction))
    hintobj sethintonobstruction(onobstruction);
  else
    hintobj sethintonobstruction("hide");

  if(isDefined(hintdist))
    hintobj sethintdisplayrange(hintdist);
  else
    hintobj sethintdisplayrange(200);

  if(isDefined(hintfov))
    hintobj sethintdisplayfov(hintfov);
  else
    hintobj sethintdisplayfov(160);

  if(isDefined(usedist))
    hintobj setuserange(usedist);
  else
    hintobj setuserange(50);

  if(isDefined(usefov))
    hintobj setusefov(usefov);
  else
    hintobj setusefov(120);

  if(!isDefined(_id_DBCE45A33308630D))
    return hintobj;
}