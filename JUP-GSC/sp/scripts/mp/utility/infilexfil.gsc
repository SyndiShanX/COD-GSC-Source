/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\infilexfil.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace infilexfil;

function getinfilpath(targetname) {
  paths = getStructArray(targetname, "targetname");

  if(!isDefined(paths)) {
    assertmsg("No infil paths were found.");
    return;
  }

  foreach(path in paths) {
    if(istrue(level.interactiveinfil)) {
      if(isDefined(path.script_noteworthy) && path.script_noteworthy == "interactive") {
        return path;
      }

      continue;
    }

    if(!isDefined(path.script_noteworthy) || path.script_noteworthy != "interactive") {
      return path;
    }
  }
}

function player_unlink(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  if(player islinked()) {
    player unlink();
  }
}

function player_free_look(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  if(player islinked()) {
    player lerpviewangleclamp(0, 0, 0, 45, 45, 45, 45);
  }
}

function player_fov_80_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player lerpfovbypreset("80_instant");
}

function player_fov_default_1(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player lerpfovbypreset("zombiearcade");
}

function player_fov_default_2(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player lerpfovbypreset("default_2seconds");
}

function player_lock_look_1_second(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  if(player islinked()) {
    player lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  }
}

function player_lock_look_2_second(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  if(player islinked()) {
    player lerpviewangleclamp(2, 0.5, 0.5, 0, 0, 0, 0);
  }
}

function player_lock_look_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  if(player islinked()) {
    player lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
  }
}

function rumble_low(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread updateshakeonplayer(undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05, 0.1);
}

function cam_shake_low(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread updateshakeonplayer(0.06, 0.075, 2, player.origin, 8000, "mig_rumble", 0.05, 0.1);
}

function cam_shake_running(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread updateshakeonplayer(0.09, 0.115, 2, player.origin, 8000, undefined, 0.15, 0.5);
}

function cam_shake_parked(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread updateshakeonplayer(0.065, 0.09, 0.5, player.origin, 8000, undefined, 0.15, 0.5);
}

function cam_shake_off(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player notify("stop_cam_shake");
}

function updateshakeonplayer(var_7ac5f1f9205ac776, var_7ae8e3f92080f064, var_fa5a6ef8c302a935, var_5c7fa8f909b33748, quakeradius, rumblename, waitmin, waitmax) {
  if(istrue(level.interactiveinfil) && istrue(self.interactivecombat)) {
    return;
  }

  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  level endon("prematch_over");
  level endon("infil_done");
  self endon("death_or_disconnect");

  while(isDefined(self)) {
    if(isDefined(var_7ac5f1f9205ac776) && isDefined(var_7ae8e3f92080f064)) {
      self earthquakeforplayer(randomfloatrange(var_7ac5f1f9205ac776, var_7ae8e3f92080f064), var_fa5a6ef8c302a935, var_5c7fa8f909b33748, quakeradius);
    }

    if(isDefined(rumblename)) {
      self playrumbleonpositionforclient(rumblename, self.origin);
    }

    wait randomfloatrange(waitmin, waitmax);
  }
}

function hideactors() {
  if(!isDefined(self.actors)) {
    return;
  }

  foreach(actor in self.actors) {
    actor hide();
  }
}

function showactors() {
  if(!isDefined(self.actors)) {
    return;
  }

  foreach(actor in self.actors) {
    actor show();
  }
}

function setcinematicmotion_heli(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player setcinematicmotionoverride("player_heli_ride");
}

function setcinematicmotion_playermotion(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player setcinematicmotionoverride("iw9_playermotion");
}

function setcinematicmotion_disabled(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player setcinematicmotionoverride("disabled");
}

function set_cinematicmotionomnvaroverrides(value) {
  self setclientomnvar("handheld_camera_rotation_move_mod_override", value);
  self setclientomnvar("handheld_camera_rotation_view_mod_override", value);
  self setclientomnvar("handheld_camera_translation_move_mod_override", value);
  self setclientomnvar("handheld_camera_translation_view_mod_override", value);
}

function set_cinematicmotionomnvarovertime(startval, endval, duration) {
  self endon("death_or_disconnect");
  currenttime = gettime();
  duration *= 1000;
  endtime = int(currenttime + duration);
  diff = abs(startval - endval);

  while(true) {
    currenttime = gettime();
    t = clamp(1 - (endtime - currenttime) / duration, 0, 1);
    frac = ter_op(startval < endval, diff * t + startval, startval - diff * t);
    set_cinematicmotionomnvaroverrides(frac);

    if(t == 1) {
      break;
    }

    waitframe();
  }
}

function setcinematicmotion_omnvaroverride_max_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player set_cinematicmotionomnvaroverrides(1);
}

function setcinematicmotion_omnvaroverride_max_1(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(0, 1, 1);
}

function setcinematicmotion_omnvaroverride_max_2(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(0, 1, 2);
}

function setcinematicmotion_omnvaroverride_max_3(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(0, 1, 3);
}

function setcinematicmotion_omnvaroverride_max_4(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(0, 1, 4);
}

function setcinematicmotion_omnvaroverride_max_5(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(0, 1, 5);
}

function setcinematicmotion_omnvaroverride_min_instant(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player set_cinematicmotionomnvaroverrides(0);
}

function setcinematicmotion_omnvaroverride_min_1(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(1, 0, 1);
}

function setcinematicmotion_omnvaroverride_min_2(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(1, 0, 2);
}

function setcinematicmotion_omnvaroverride_min_3(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(1, 0, 3);
}

function setcinematicmotion_omnvaroverride_min_4(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(1, 0, 4);
}

function setcinematicmotion_omnvaroverride_min_5(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread set_cinematicmotionomnvarovertime(1, 0, 5);
}

function player_equip_nvg(guy) {
  if(!scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    return;
  }

  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player nightvisionviewon();
}

function getgroundcompensationheight(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  currentz = player.origin[2];
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  startpos = player.origin + 12 * (0, 0, 1);
  endpos = player.origin - 24 * (0, 0, 1);
  groundpos = scripts\engine\trace::player_trace(startpos, endpos, player.angles, [player, player.infil.linktoent], contents)["position"];
  groundz = groundpos[2];
  player.infilheightcompensation = groundz - currentz;
}

function compensatetoground() {
  level endon("prematch_over");
  self endon("death_or_disconnect");
  var_58c3c94616b8d44a = 0;
  self.personalscenenode unlink();

  while(isDefined(self.personalscenenode)) {
    getgroundcompensationheight(self.player_rig);
    var_71f0e8415130fa4e = (self.personalscenenode.origin[0], self.personalscenenode.origin[1], self.personalscenenode.origin[2] + self.infilheightcompensation);

    if(abs(var_58c3c94616b8d44a - self.infilheightcompensation) > 0.01) {
      var_58c3c94616b8d44a = self.infilheightcompensation;
      self.personalscenenode moveTo(var_71f0e8415130fa4e, 0.25, 0.05, 0.2);
    }

    waitframe();
  }
}

#using_animtree("script_model");

function infil_player_rig_updated(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  self function_b88c89bb7cd1ab8e(spawnpos);
  player_rig = spawn("script_arms", spawnpos, 0, 0, self);
  player_rig.angles = spawnang;
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = &handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &handledofnotetrack;
  var_4b9d74e8e109d11e = self.player_rig gettagangles("tag_camera_scripted");

  if(getdvarint(@ "hash_7b07a2b6dabbfd16", 1) == 1) {
    var_4b9d74e8e109d11e = (var_4b9d74e8e109d11e[0], var_4b9d74e8e109d11e[1], 0);
  }

  self setplayerangles(var_4b9d74e8e109d11e);
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  println("<dev string:x1c>" + self.name + "<dev string:x4e>" + animname + "<dev string:x5b>" + isDefined(self.player_rig));
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    println("<dev string:x63>" + self.name + "<dev string:x4e>" + animname + "<dev string:x5b>" + isDefined(self.player_rig));
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
  }

  if(isDefined(player_rig)) {
    if(isDefined(player_rig.var_a898e429efa25958)) {
      player_rig.var_a898e429efa25958 delete();
    }

    player_rig delete();
  }

  if(isDefined(self)) {
    self notify("rig_cleanup");
  }
}

function handledofnotetrack(type) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }

  switch (type) {
    case #"hash_4ec2c14f2118f275":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case #"hash_9f02a28a98823bce":
          self.player setphysicaldepthoffield(1.9, 50, 20, 20);
          break;
        case #"hash_9f02a38a98823d61":
          self.player setphysicaldepthoffield(1.9, 50, 20, 20);
          break;
        case #"hash_9f02a08a988238a8":
          self.player setphysicaldepthoffield(2.2, 70, 20, 20);
          break;
        case #"hash_9f02a18a98823a3b":
          self.player setphysicaldepthoffield(2.2, 70, 20, 20);
          break;
        case #"hash_9f02a68a9882421a":
          self.player setphysicaldepthoffield(2.2, 60, 20, 20);
          break;
        case #"hash_9f02a78a988243ad":
          self.player setphysicaldepthoffield(2.2, 60, 20, 20);
          break;
      }

      break;
    case #"hash_411d0bd57be3a71d":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case #"hash_76a3cb4c3b753bf":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case #"hash_9f02a28a98823bce":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case #"hash_9f02a38a98823d61":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case #"hash_9f02a08a988238a8":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case #"hash_9f02a18a98823a3b":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case #"hash_9f02a68a9882421a":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
        case #"hash_9f02a78a988243ad":
          self.player setphysicaldepthoffield(2.4, 50, 20, 20);
          break;
      }

      break;
    case #"hash_47f397a041d6f287":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case #"hash_cf5920097f34bf5f":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case #"hash_9f02a28a98823bce":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case #"hash_9f02a38a98823d61":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case #"hash_9f02a08a988238a8":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case #"hash_9f02a18a98823a3b":
          self.player setphysicaldepthoffield(2.1, 40, 20, 20);
          break;
        case #"hash_9f02a68a9882421a":
          self.player setphysicaldepthoffield(2.3, 60, 20, 20);
          break;
        case #"hash_9f02a78a988243ad":
          self.player setphysicaldepthoffield(2.3, 60, 20, 20);
          break;
      }

      break;
    case #"hash_2ae5939ed559cf27":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case #"hash_517726d59c8d65d8":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case #"hash_9f02a28a98823bce":
          self.player setphysicaldepthoffield(4, 100, 20, 20);
          break;
        case #"hash_9f02a38a98823d61":
          self.player setphysicaldepthoffield(4, 100, 20, 20);
          break;
        case #"hash_9f02a08a988238a8":
          self.player setphysicaldepthoffield(4.8, 70, 20, 20);
          break;
        case #"hash_9f02a18a98823a3b":
          self.player setphysicaldepthoffield(4.8, 70, 20, 20);
          break;
        case #"hash_9f02a68a9882421a":
          self.player setphysicaldepthoffield(4.8, 80, 20, 20);
          break;
        case #"hash_9f02a78a988243ad":
          self.player setphysicaldepthoffield(4.8, 80, 20, 20);
          break;
        case #"hash_9f02a48a98823ef4":
          self.player setphysicaldepthoffield(4.8, 90, 20, 20);
          break;
        case #"hash_9f02a58a98824087":
          self.player setphysicaldepthoffield(4.8, 90, 20, 20);
          break;
        case #"hash_9f029a8a98822f36":
          self.player setphysicaldepthoffield(5.6, 100, 20, 20);
          break;
        case #"hash_9f029b8a988230c9":
          self.player setphysicaldepthoffield(5.6, 100, 20, 20);
          break;
        case #"hash_d364c42e15068683":
          self.player setphysicaldepthoffield(5.6, 60, 20, 20);
          break;
        case #"hash_d364c32e150684f0":
          self.player setphysicaldepthoffield(5.6, 60, 20, 20);
          break;
        case #"hash_d364c62e150689a9":
          self.player setphysicaldepthoffield(5.6, 70, 20, 20);
          break;
        case #"hash_d364c52e15068816":
          self.player setphysicaldepthoffield(5.6, 70, 20, 20);
          break;
        case #"hash_d364c82e15068ccf":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case #"hash_d364c72e15068b3c":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case #"hash_d364ca2e15068ff5":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case #"hash_d364c92e15068e62":
          self.player setphysicaldepthoffield(5.6, 80, 20, 20);
          break;
        case #"hash_d364cc2e1506931b":
          self.player setphysicaldepthoffield(5.6, 90, 20, 20);
          break;
        case #"hash_d364cb2e15069188":
          self.player setphysicaldepthoffield(5.6, 90, 20, 20);
          break;
      }

      break;
    case #"hash_e32097fc4efa5138":
      self.player enablephysicaldepthoffieldscripting();
      self.player setphysicaldepthoffield(2.8, 500, 4, 4);
      break;
    case #"hash_a65609faf77c04b7":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case #"hash_9f02a28a98823bce":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case #"hash_9f02a38a98823d61":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case #"hash_9f02a08a988238a8":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case #"hash_9f02a18a98823a3b":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case #"hash_9f02a68a9882421a":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
        case #"hash_9f02a78a988243ad":
          self.player setphysicaldepthoffield(2.2, 500, 50, 50);
          break;
      }

      break;
    case #"hash_625d6429b07451ec":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case #"hash_9f02a28a98823bce":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case #"hash_9f02a38a98823d61":
          self.player setphysicaldepthoffield(2.2, 40, 50, 50);
          break;
        case #"hash_9f02a08a988238a8":
          self.player setphysicaldepthoffield(2.2, 40, 50, 50);
          break;
        case #"hash_9f02a18a98823a3b":
          self.player setphysicaldepthoffield(2.2, 45, 50, 50);
          break;
        case #"hash_9f02a68a9882421a":
          self.player setphysicaldepthoffield(2.2, 45, 50, 50);
          break;
        case #"hash_9f02a78a988243ad":
          self.player setphysicaldepthoffield(2.2, 40, 50, 50);
          break;
        case #"hash_9f02a48a98823ef4":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case #"hash_9f02a58a98824087":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case #"hash_9f029a8a98822f36":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case #"hash_9f029b8a988230c9":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
        case #"hash_d364c42e15068683":
          self.player setphysicaldepthoffield(2.2, 50, 50, 50);
          break;
      }

      break;
    case #"hash_23d3b48a2fabf145":
      self.player disablephysicaldepthoffieldscripting();
      break;
  }
}

function handlecinematicmotionnotetrack(var_d8958445ed7ab829) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }

  prefix = getsubstr(var_d8958445ed7ab829, 0, 4);

  if(prefix == "set_") {
    override = getsubstr(var_d8958445ed7ab829, 4);
    self.player setcinematicmotionoverride(override);
    return;
  }

  switch (var_d8958445ed7ab829) {
    case #"hash_a6c78cbbbff2556b":
      setcinematicmotion_omnvaroverride_max_instant(self);
      break;
    case #"hash_299b5843a6ce39d9":
      setcinematicmotion_omnvaroverride_max_1(self);
      break;
    case #"hash_299b5543a6ce3520":
      setcinematicmotion_omnvaroverride_max_2(self);
      break;
    case #"hash_299b5643a6ce36b3":
      setcinematicmotion_omnvaroverride_max_3(self);
      break;
    case #"hash_299b5b43a6ce3e92":
      setcinematicmotion_omnvaroverride_max_4(self);
      break;
    case #"hash_299b5c43a6ce4025":
      setcinematicmotion_omnvaroverride_max_5(self);
      break;
    case #"hash_68b242ebbe127151":
      setcinematicmotion_omnvaroverride_min_instant(self);
      break;
    case #"hash_519726130b56caab":
      setcinematicmotion_omnvaroverride_min_1(self);
      break;
    case #"hash_519727130b56cc3e":
      setcinematicmotion_omnvaroverride_min_2(self);
      break;
    case #"hash_519728130b56cdd1":
      setcinematicmotion_omnvaroverride_min_3(self);
      break;
    case #"hash_519729130b56cf64":
      setcinematicmotion_omnvaroverride_min_4(self);
      break;
    case #"hash_51972a130b56d0f7":
      setcinematicmotion_omnvaroverride_min_5(self);
      break;
  }
}

function handleweaponstatenotetrack(state) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }

  self.player endon("death_or_disconnect");

  switch (state) {
    case #"hash_30b20a099c3735ec":
      self.player setdemeanorviewmodel("normal");
      self.player ent_flag_init("swapLoadout_blocked");
      self.player ent_flag_init("swapLoadout_pending");
      self.player ent_flag_init("swapLoadout_complete");
      self.player ent_flag_set("swapLoadout_blocked");
      self.player thread cleanupswaploadoutflags();

      if(!isai(self.player) && isDefined(self) && isDefined(self.player) && isalive(self.player)) {
        self.player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
      }

      if(istrue(self.updatedversion)) {
        self showonlytoplayer(self.player);
      }

      if(isDefined(self.player)) {
        self.player val::set("notetrack_drop", "reload", 0);
      }

      break;
    case #"hash_5281b0cd075003":
      if(isDefined(self.player.infilweapon) && self.player hasweapon(self.player.infilweapon)) {
        self.player scripts\cp_mp\utility\inventory_utility::_takeweapon(self.player.infilweapon);
      }

      self.player.infilweaponraise = 1;

      if(self.player ent_flag_exist("swapLoadout_blocked") && self.player ent_flag("swapLoadout_blocked")) {
        self.player ent_flag_clear("swapLoadout_blocked");
      }

      self.player setdemeanorviewmodel("normal");

      if(!istrue(self.updatedversion)) {
        self.player stopviewmodelanim();
      }

      if(issharedfuncdefined("player", "loadout_finalizeWeapons")) {
        self.player[[getsharedfunc("player", "loadout_finalizeWeapons")]]();
      }

      if(!isai(self.player)) {
        self.player scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
      }

      if(istrue(self.updatedversion) && self.player islinked()) {
        self.player playerlinkedsetforceparentvisible(0);
      }

      self.player val::reset_all("notetrack_drop");
      break;
    case #"hash_9682e089e580b4b8":
      if(isDefined(self.var_953281e4198e2ff7)) {
        self.player setdemeanorviewmodel("normal");
        wait 0.05;
        self.player setdemeanorviewmodel("safe", self.var_953281e4198e2ff7);
      } else {
        self.player setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
      }

      break;
    case #"hash_9c964a6cbaac0576":
      if(!isai(self)) {
        self showonlytoplayer(self.player);
      }

      self.player setdemeanorviewmodel("normal");
      wait 0.05;
      self.player setdemeanorviewmodel("safe", "iw9_ges_demeanor_safe_van_gundown");
      self.var_953281e4198e2ff7 = "iw8_ges_demeanor_safe_van";
      break;
    case #"hash_14c87da9a703f912":
      if(!isai(self)) {
        self showonlytoplayer(self.player);
      }

      self.player setdemeanorviewmodel("relaxed", "iw9_ges_demeanor_safe_van_gundown");
      self.var_953281e4198e2ff7 = "iw8_ges_demeanor_safe_van";
      break;
    case #"hash_84fcf5e68d7230b2":
      self.player setdemeanorviewmodel("normal");
      break;
    case #"hash_a8f0b714fb0cb53b":
      self.player val::reset_all("notetrack_hold");
      break;
    case #"hash_dd93195493d0c818":
      self.player val::set("notetrack_hold", "fire", 0);
      self.player val::set("notetrack_hold", "ads", 0);
      self.player val::set("notetrack_hold", "reload", 0);
      break;
    case #"hash_1e3d8afe88d3b4f":
      if(!isai(self.player)) {
        self showonlytoplayer(self.player);

        if(isDefined(self.player.infilweapon)) {
          self.var_a898e429efa25958 = self.player dropitem(self.player.infilweapon);
        } else {
          self.var_a898e429efa25958 = self.player dropitem(self.player.lastdroppableweaponobj);
        }

        self.var_a898e429efa25958 showonlytoplayer(self.player);
        self.var_a898e429efa25958 linkTo(self.player, "j_gun", (0, 0, 0), (0, 0, 0));
      }

      break;
    case #"hash_dd0c557fa98ca956":
      if(!isai(self.player)) {
        if(isDefined(self.var_a898e429efa25958)) {
          self.var_a898e429efa25958 delete();
        }
      }

      break;
  }
}

function cleanupswaploadoutflags() {
  self endon("disconnect");
  waittill_any_ents(self, "death", level, "prematch_over");
  ent_flag_clear("swapLoadout_blocked", 1);
  ent_flag_clear("swapLoadout_pending", 1);
  ent_flag_clear("swapLoadout_complete", 1);
}

function function_c96464f39952b78a(vehicle) {
  if(isDefined(vehicle.infil.type)) {
    switch (vehicle.infil.type) {
      case #"hash_84cf3499469c73f9":
      case #"hash_ffbece8c8ed62d87":
        return "heli";
      case #"hash_3147dc8dc0e0168e":
      case #"hash_6acd072bc2514d60":
        return "bigheli";
      case #"hash_9cca7c109971cb":
      case #"hash_7fc07a30c0958e55":
        return "truck";
      case #"hash_216654e0e29260df":
      case #"hash_34c49a3fbd94f043":
      case #"hash_a1ff4c2b58ee2047":
      case #"hash_ab94c4e0a50be6d3":
        return "car";
      default:
        return "generic";
    }
  }

  return "generic";
}