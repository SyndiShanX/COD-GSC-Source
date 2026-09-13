/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\infilexfil.gsc
***********************************************/

getinfilpath(targetname) {
  paths = scripts\engine\utility::getStructArray(targetname, "targetname");

  if(!isDefined(paths)) {
    return;
  }
  foreach(path in paths) {
    if(istrue(level.interactiveinfil)) {
      if(isDefined(path.script_noteworthy) && path.script_noteworthy == "interactive")
        return path;
    } else if(!isDefined(path.script_noteworthy) || path.script_noteworthy != "interactive")
      return path;
  }
}

player_unlink(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  if(player islinked())
    player unlink();
}

player_free_look(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  if(player islinked())
    player lerpviewangleclamp(0, 0, 0, 45, 45, 45, 45);
}

player_fov_80_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player lerpfovbypreset("80_instant");
}

player_fov_default_1(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player lerpfovbypreset("zombiearcade");
}

player_fov_default_2(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player lerpfovbypreset("default_2seconds");
}

player_lock_look_1_second(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  if(player islinked())
    player lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
}

player_lock_look_2_second(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  if(player islinked())
    player lerpviewangleclamp(2, 0.5, 0.5, 0, 0, 0, 0);
}

player_lock_look_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  if(player islinked())
    player lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
}

rumble_low(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread updateshakeonplayer(undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05, 0.1);
}

cam_shake_low(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread updateshakeonplayer(0.06, 0.075, 2, player.origin, 8000, "mig_rumble", 0.05, 0.1);
}

cam_shake_running(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread updateshakeonplayer(0.09, 0.115, 2, player.origin, 8000, undefined, 0.15, 0.5);
}

cam_shake_parked(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread updateshakeonplayer(0.065, 0.09, 0.5, player.origin, 8000, undefined, 0.15, 0.5);
}

cam_shake_off(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player notify("stop_cam_shake");
}

updateshakeonplayer(_id_7AC5F1F9205AC776, _id_7AE8E3F92080F064, _id_FA5A6EF8C302A935, _id_5C7FA8F909B33748, _id_019067C8C80AFB50, _id_21F510057C7BF283, _id_30F2848645468450, _id_30CF7A864520269A) {
  if(istrue(level.interactiveinfil) && istrue(self.interactivecombat)) {
    return;
  }
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  level endon("prematch_over");
  level endon("infil_done");
  self endon("death_or_disconnect");

  while(isDefined(self)) {
    if(isDefined(_id_7AC5F1F9205AC776) && isDefined(_id_7AE8E3F92080F064))
      self earthquakeforplayer(randomfloatrange(_id_7AC5F1F9205AC776, _id_7AE8E3F92080F064), _id_FA5A6EF8C302A935, _id_5C7FA8F909B33748, _id_019067C8C80AFB50);

    if(isDefined(_id_21F510057C7BF283))
      self playrumbleonpositionforclient(_id_21F510057C7BF283, self.origin);

    wait(randomfloatrange(_id_30F2848645468450, _id_30CF7A864520269A));
  }
}

hideactors() {
  if(!isDefined(self.actors)) {
    return;
  }
  foreach(actor in self.actors)
  actor hide();
}

showactors() {
  if(!isDefined(self.actors)) {
    return;
  }
  foreach(actor in self.actors)
  actor show();
}

setcinematicmotion_heli(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player setcinematicmotionoverride("player_heli_ride");
}

setcinematicmotion_playermotion(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player setcinematicmotionoverride("iw9_playermotion");
}

setcinematicmotion_disabled(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player setcinematicmotionoverride("disabled");
}

set_cinematicmotionomnvaroverrides(value) {
  self setclientomnvar("handheld_camera_rotation_move_mod_override", value);
  self setclientomnvar("handheld_camera_rotation_view_mod_override", value);
  self setclientomnvar("handheld_camera_translation_move_mod_override", value);
  self setclientomnvar("handheld_camera_translation_view_mod_override", value);
}

set_cinematicmotionomnvarovertime(_id_5926BC85944973F2, _id_4EC590D17B901A2D, duration) {
  self endon("death_or_disconnect");
  currenttime = gettime();
  duration = duration * 1000;
  endtime = int(currenttime + duration);
  _id_4573A8725DD3748E = abs(_id_5926BC85944973F2 - _id_4EC590D17B901A2D);

  for(;;) {
    currenttime = gettime();
    t = clamp(1.0 - (endtime - currenttime) / duration, 0.0, 1.0);
    frac = scripts\engine\utility::ter_op(_id_5926BC85944973F2 < _id_4EC590D17B901A2D, _id_4573A8725DD3748E * t + _id_5926BC85944973F2, _id_5926BC85944973F2 - _id_4573A8725DD3748E * t);
    set_cinematicmotionomnvaroverrides(frac);

    if(t == 1.0) {
      break;
    }

    waitframe();
  }
}

setcinematicmotion_omnvaroverride_max_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player set_cinematicmotionomnvaroverrides(1.0);
}

setcinematicmotion_omnvaroverride_max_1(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(0.0, 1.0, 1.0);
}

setcinematicmotion_omnvaroverride_max_2(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(0.0, 1.0, 2.0);
}

setcinematicmotion_omnvaroverride_max_3(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(0.0, 1.0, 3.0);
}

setcinematicmotion_omnvaroverride_max_4(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(0.0, 1.0, 4.0);
}

setcinematicmotion_omnvaroverride_max_5(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(0.0, 1.0, 5.0);
}

setcinematicmotion_omnvaroverride_min_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player set_cinematicmotionomnvaroverrides(0.0);
}

setcinematicmotion_omnvaroverride_min_1(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(1.0, 0.0, 1.0);
}

setcinematicmotion_omnvaroverride_min_2(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(1.0, 0.0, 2.0);
}

setcinematicmotion_omnvaroverride_min_3(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(1.0, 0.0, 3.0);
}

setcinematicmotion_omnvaroverride_min_4(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(1.0, 0.0, 4.0);
}

setcinematicmotion_omnvaroverride_min_5(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread set_cinematicmotionomnvarovertime(1.0, 0.0, 5.0);
}

player_equip_nvg(guy) {
  if(!scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4()) {
    return;
  }
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player nightvisionviewon();
}

getgroundcompensationheight(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  _id_31C17768C4ABA01C = player.origin[2];
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  startpos = player.origin + (0, 0, 12);
  endpos = player.origin - (0, 0, 24);
  groundpos = scripts\engine\trace::player_trace(startpos, endpos, player.angles, [player, player.infil.linktoent], contents)["position"];
  groundz = groundpos[2];
  player.infilheightcompensation = groundz - _id_31C17768C4ABA01C;
}

compensatetoground() {
  level endon("prematch_over");
  self endon("death_or_disconnect");
  _id_58C3C94616B8D44A = 0.0;
  self.personalscenenode unlink();

  while(isDefined(self.personalscenenode)) {
    getgroundcompensationheight(self.player_rig);
    _id_71F0E8415130FA4E = (self.personalscenenode.origin[0], self.personalscenenode.origin[1], self.personalscenenode.origin[2] + self.infilheightcompensation);

    if(abs(_id_58C3C94616B8D44A - self.infilheightcompensation) > 0.01) {
      _id_58C3C94616B8D44A = self.infilheightcompensation;
      self.personalscenenode moveTo(_id_71F0E8415130FA4E, 0.25, 0.05, 0.2);
    }

    waitframe();
  }
}

#using_animtree("script_model");

infil_player_rig_updated(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  self _meth_B88C89BB7CD1AB8E(spawnpos);
  player_rig = spawn("script_arms", spawnpos, 0, 0, self);
  player_rig.angles = _id_B7850001037AA074;
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.weapon_state_func = ::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = ::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = ::handledofnotetrack;
  _id_4B9D74E8E109D11E = self.player_rig gettagangles("tag_camera_scripted");

  if(getdvarint("dvar_7B07A2B6DABBFD16", 1) == 1)
    _id_4B9D74E8E109D11E = (_id_4B9D74E8E109D11E[0], _id_4B9D74E8E109D11E[1], 0.0);

  self setplayerangles(_id_4B9D74E8E109D11E);
  self playerlinktodelta(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(player_rig)) {
    if(isDefined(player_rig._id_A898E429EFA25958))
      player_rig._id_A898E429EFA25958 delete();

    player_rig delete();
  }
}

handledofnotetrack(type) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  switch (type) {
    case "blima_interior":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(1.9, 50, 20, 20);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(1.9, 50, 20, 20);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(2.2, 70, 20, 20);
          break;
        case "slot_3":
          self.player setphysicaldepthoffield(2.2, 70, 20, 20);
          break;
        case "slot_4":
          self.player setphysicaldepthoffield(2.2, 60, 20, 20);
          break;
        case "slot_5":
          self.player setphysicaldepthoffield(2.2, 60, 20, 20);
          break;
      }

      break;
    case "blima_exit":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case "umike_interior":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "slot_3":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "slot_4":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case "slot_5":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
      }

      break;
    case "umike_exit":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case "van_interior":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "slot_3":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case "slot_4":
          self.player setphysicaldepthoffield(2.3, 60, 20, 20);
          break;
        case "slot_5":
          self.player setphysicaldepthoffield(2.3, 60, 20, 20);
          break;
      }

      break;
    case "van_exit":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case "palfa_interior":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(4.0, 100, 20, 20);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(4.0, 100, 20, 20);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(4.8, 70, 20, 20);
          break;
        case "slot_3":
          self.player setphysicaldepthoffield(4.8, 70, 20, 20);
          break;
        case "slot_4":
          self.player setphysicaldepthoffield(4.8, 80, 20, 20);
          break;
        case "slot_5":
          self.player setphysicaldepthoffield(4.8, 80, 20, 20);
          break;
        case "slot_6":
          self.player setphysicaldepthoffield(4.8, 90, 20, 20);
          break;
        case "slot_7":
          self.player setphysicaldepthoffield(4.8, 90, 20, 20);
          break;
        case "slot_8":
          self.player setphysicaldepthoffield(5.6, 100, 20, 20);
          break;
        case "slot_9":
          self.player setphysicaldepthoffield(5.6, 100, 20, 20);
          break;
        case "slot_10":
          self.player setphysicaldepthoffield(5.6, 60, 20, 20);
          break;
        case "slot_11":
          self.player setphysicaldepthoffield(5.6, 60, 20, 20);
          break;
        case "slot_12":
          self.player setphysicaldepthoffield(5.6, 70, 20, 20);
          break;
        case "slot_13":
          self.player setphysicaldepthoffield(5.6, 70, 20, 20);
          break;
        case "slot_14":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case "slot_15":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case "slot_16":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case "slot_17":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case "slot_18":
          self.player setphysicaldepthoffield(5.6, 90, 20, 20);
          break;
        case "slot_19":
          self.player setphysicaldepthoffield(5.6, 90, 20, 20);
          break;
      }

      break;
    case "palfa_exit":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case "defender_interior":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case "slot_3":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case "slot_4":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case "slot_5":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
      }

      break;
    case "skerries_infil":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(2.2, 40, 50, 50);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(2.2, 40, 50, 50);
          break;
        case "slot_3":
          self.player setphysicaldepthoffield(2.2, 45, 50, 50);
          break;
        case "slot_4":
          self.player setphysicaldepthoffield(2.2, 45, 50, 50);
          break;
        case "slot_5":
          self.player setphysicaldepthoffield(2.2, 40, 50, 50);
          break;
        case "slot_6":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case "slot_7":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case "slot_8":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case "slot_9":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case "slot_10":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
      }

      break;
    case "stop":
      self.player disablephysicaldepthoffieldscripting();
      break;
  }
}

handlecinematicmotionnotetrack(_id_D8958445ED7AB829) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  _id_DEC9BCCE93873125 = getsubstr(_id_D8958445ED7AB829, 0, 4);

  if(_id_DEC9BCCE93873125 == "set_") {
    override = getsubstr(_id_D8958445ED7AB829, 4);
    self.player setcinematicmotionoverride(override);
    return;
  }

  switch (_id_D8958445ED7AB829) {
    case "max_instant":
      setcinematicmotion_omnvaroverride_max_instant(self);
      break;
    case "max_1":
      setcinematicmotion_omnvaroverride_max_1(self);
      break;
    case "max_2":
      setcinematicmotion_omnvaroverride_max_2(self);
      break;
    case "max_3":
      setcinematicmotion_omnvaroverride_max_3(self);
      break;
    case "max_4":
      setcinematicmotion_omnvaroverride_max_4(self);
      break;
    case "max_5":
      setcinematicmotion_omnvaroverride_max_5(self);
      break;
    case "min_instant":
      setcinematicmotion_omnvaroverride_min_instant(self);
      break;
    case "min_1":
      setcinematicmotion_omnvaroverride_min_1(self);
      break;
    case "min_2":
      setcinematicmotion_omnvaroverride_min_2(self);
      break;
    case "min_3":
      setcinematicmotion_omnvaroverride_min_3(self);
      break;
    case "min_4":
      setcinematicmotion_omnvaroverride_min_4(self);
      break;
    case "min_5":
      setcinematicmotion_omnvaroverride_min_5(self);
      break;
  }
}

handleweaponstatenotetrack(state) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  self.player endon("death_or_disconnect");

  switch (state) {
    case "drop":
      self.player setdemeanorviewmodel("normal");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_blocked");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_pending");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_complete");
      self.player scripts\engine\utility::ent_flag_set("swapLoadout_blocked");
      self.player thread cleanupswaploadoutflags();

      if(!isai(self.player) && isDefined(self) && isDefined(self.player) && isalive(self.player))
        self.player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();

      if(istrue(self.updatedversion))
        self showonlytoplayer(self.player);

      if(isDefined(self.player))
        self.player _id_3B64EB40368C1450::set("notetrack_drop", "reload", 0);

      break;
    case "raise":
      if(isDefined(self.player.infilweapon) && self.player hasweapon(self.player.infilweapon))
        self.player scripts\cp_mp\utility\inventory_utility::_takeweapon(self.player.infilweapon);

      self.player.infilweaponraise = 1;

      if(self.player scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && self.player scripts\engine\utility::ent_flag("swapLoadout_blocked"))
        self.player scripts\engine\utility::ent_flag_clear("swapLoadout_blocked");

      self.player setdemeanorviewmodel("normal");

      if(!istrue(self.updatedversion))
        self.player stopviewmodelanim();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "loadout_finalizeWeapons"))
        self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "loadout_finalizeWeapons")]]();

      if(!isai(self.player))
        self.player scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();

      if(istrue(self.updatedversion) && self.player islinked())
        self.player playerlinkedsetforceparentvisible(0);

      self.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("notetrack_drop");
      break;
    case "safe":
      if(isDefined(self._id_953281E4198E2FF7)) {
        self.player setdemeanorviewmodel("normal");
        wait 0.05;
        self.player setdemeanorviewmodel("safe", self._id_953281E4198E2FF7);
      } else
        self.player setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");

      break;
    case "safe_offscreen":
      if(!isai(self))
        self showonlytoplayer(self.player);

      self.player setdemeanorviewmodel("normal");
      wait 0.05;
      self.player setdemeanorviewmodel("safe", "iw9_ges_demeanor_safe_van_gundown");
      self._id_953281E4198E2FF7 = "iw8_ges_demeanor_safe_van";
      break;
    case "show_3p_weapon":
      if(!isai(self)) {
        self._id_A898E429EFA25958 = self.player dropitem(self.player.lastdroppableweaponobj);
        self._id_A898E429EFA25958 showonlytoplayer(self.player);
        self._id_A898E429EFA25958 linkTo(self, "j_gun", (0, 0, 0), (0, 0, 0));
      }

      break;
    case "hide_3p_weapon":
      if(!isai(self)) {
        if(isDefined(self._id_A898E429EFA25958))
          self._id_A898E429EFA25958 delete();
      }

      break;
    case "normal":
      self.player setdemeanorviewmodel("normal");
      break;
    case "free":
      self.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("notetrack_hold");
      break;
    case "hold":
      self.player _id_3B64EB40368C1450::set("notetrack_hold", "fire", 0);
      self.player _id_3B64EB40368C1450::set("notetrack_hold", "ads", 0);
      self.player _id_3B64EB40368C1450::set("notetrack_hold", "reload", 0);
      break;
  }
}

cleanupswaploadoutflags() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(self, "death", level, "prematch_over");
  scripts\engine\utility::ent_flag_clear("swapLoadout_blocked", 1);
  scripts\engine\utility::ent_flag_clear("swapLoadout_pending", 1);
  scripts\engine\utility::ent_flag_clear("swapLoadout_complete", 1);
}

_id_C96464F39952B78A(vehicle) {
  if(isDefined(vehicle.infil.type)) {
    switch (vehicle.infil.type) {
      case "infil_blima":
      case "infil_mbravo":
        return "heli";
      case "infil_palfa":
      case "infil_mi8":
        return "bigheli";
      case "infil_umike":
      case "infil_defender":
        return "truck";
      case "infil_crossing_civ":
      case "infil_crossing_suv":
      case "infil_van_hackney":
      case "infil_van":
        return "car";
      default:
        return "generic";
    }
  }

  return "generic";
}