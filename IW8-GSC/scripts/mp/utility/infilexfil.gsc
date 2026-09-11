/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\infilexfil.gsc
***********************************************/

function getinfilpath(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  if(!isDefined(var1)) {
    return;
  }

  foreach(var3 in var1) {
    if(istrue(level.interactiveinfil)) {
      if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "interactive") {
        return var3;
      }

      continue;
    }

    if(!isDefined(var3.script_noteworthy) || var3.script_noteworthy != "interactive") {
      return var3;
    }
  }
}

function player_unlink(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  if(var1 islinked()) {
    var1 unlink();
    return;
  }
}

function player_free_look(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  if(var1 islinked()) {
    var1 lerpviewangleclamp(0, 0, 0, 45, 45, 45, 45);
    return;
  }
}

function player_fov_80_instant(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 lerpfovbypreset("80_instant");
}

function ref_12497(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 lerpfovbypreset("zombiearcade");
}

function player_fov_default_2(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 lerpfovbypreset("default_2seconds");
}

function player_lock_look_1_second(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  if(var1 islinked()) {
    var1 lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
    return;
  }
}

function player_lock_look_2_second(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  if(var1 islinked()) {
    var1 lerpviewangleclamp(2, 0.5, 0.5, 0, 0, 0, 0);
    return;
  }
}

function player_lock_look_instant(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  if(var1 islinked()) {
    var1 lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
    return;
  }
}

function rumble_low(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread updateshakeonplayer(var1, undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05);
}

function cam_shake_low(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread updateshakeonplayer(var1, 0.06, 0.075, 2, var1.origin, 8000, "mig_rumble", 0.05);
}

function cam_shake_running(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread updateshakeonplayer(var1, 0.09, 0.115, 2, var1.origin, 8000, undefined, 0.15);
}

function cam_shake_parked(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread updateshakeonplayer(var1, 0.065, 0.09, 0.5, var1.origin, 8000, undefined, 0.15);
}

function cam_shake_off(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 notify("stop_cam_shake");
}

function updateshakeonplayer(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(istrue(level.interactiveinfil) && istrue(self.interactivecombat)) {
    return;
  }

  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  level endon("prematch_over");
  level endon("infil_done");
  self endon("death_or_disconnect");

  while(isDefined(self)) {
    if(isDefined(var0) && isDefined(var1)) {
      self earthquakeforplayer(randomfloatrange(var0, var1), var2, var3, var4);
    }

    if(isDefined(var5)) {
      self playrumbleonpositionforclient(var5, self.origin);
    }

    wait randomfloatrange(var6, var7);
  }
}

function hideactors() {
  if(!isDefined(self.actors)) {
    return;
  }

  foreach(var1 in self.actors) {
    var1 hide();
  }
}

function showactors() {
  if(!isDefined(self.actors)) {
    return;
  }

  foreach(var1 in self.actors) {
    var1 show();
  }
}

function setcinematicmotion_heli(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 setcinematicmotionoverride("player_heli_ride");
}

function setcinematicmotion_playermotion(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 setcinematicmotionoverride("iw8_playermotion_mp");
}

function setcinematicmotion_disabled(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 setcinematicmotionoverride("disabled");
}

function set_cinematicmotionomnvaroverrides(var0) {
  self setclientomnvar("handheld_camera_rotation_move_mod_override", var0);
  self setclientomnvar("handheld_camera_rotation_view_mod_override", var0);
  self setclientomnvar("handheld_camera_translation_move_mod_override", var0);
  self setclientomnvar("handheld_camera_translation_view_mod_override", var0);
}

function set_cinematicmotionomnvarovertime(var0, var1, var2) {
  self endon("death_or_disconnect");
  var3 = gettime();
  var2 *= 1000;
  var4 = int(var3 + var2);
  var5 = abs(var0 - var1);

  for(;;) {
    var3 = gettime();
    var6 = clamp(1 - (var4 - var3) / var2, 0, 1);
    var7 = scripts\engine\utility::ter_op(var0 < var1, var5 * var6 + var0, var0 - var5 * var6);
    set_cinematicmotionomnvaroverrides(var7);

    if(var6 == 1) {
      break;
    }

    waitframe();
  }
}

function setcinematicmotion_omnvaroverride_max_instant(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  set_cinematicmotionomnvaroverrides(var1, 1);
}

function setcinematicmotion_omnvaroverride_max_1(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 0, 1);
}

function setcinematicmotion_omnvaroverride_max_2(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 0, 1);
}

function setcinematicmotion_omnvaroverride_max_3(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 0, 1);
}

function setcinematicmotion_omnvaroverride_max_4(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 0, 1);
}

function setcinematicmotion_omnvaroverride_max_5(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 0, 1);
}

function setcinematicmotion_omnvaroverride_min_instant(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  set_cinematicmotionomnvaroverrides(var1, 0);
}

function setcinematicmotion_omnvaroverride_min_1(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 1, 0);
}

function setcinematicmotion_omnvaroverride_min_2(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 1, 0);
}

function setcinematicmotion_omnvaroverride_min_3(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 1, 0);
}

function setcinematicmotion_omnvaroverride_min_4(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 1, 0);
}

function setcinematicmotion_omnvaroverride_min_5(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  thread set_cinematicmotionomnvarovertime(var1, 1, 0);
}

function player_equip_nvg(var0) {
  if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var1 nightvisionviewon();
}

function getgroundcompensationheight(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.player)) {
    var1 = var0.player;
  } else {
    var1 = var1;
  }

  var2 = var1.origin[2];
  var3 = scripts\engine\trace::create_solid_ai_contents(1);
  var4 = var1.origin + (0, 0, 12);
  var5 = var1.origin - (0, 0, 24);
  var6 = scripts\engine\trace::player_trace(var4, var5, var1.angles, [var1, var1.infil.linktoent], var3)["position"];
  var7 = var6[2];
  var1.infilheightcompensation = var7 - var2;
}

function compensatetoground() {
  level endon("prematch_over");
  self endon("death_or_disconnect");
  var0 = 0;
  self.personalscenenode unlink();

  while(isDefined(self.personalscenenode)) {
    getgroundcompensationheight(self.player_rig);
    var1 = (self.personalscenenode.origin[0], self.personalscenenode.origin[1], self.personalscenenode.origin[2] + self.infilheightcompensation);

    if(abs(var0 - self.infilheightcompensation) > 0.01) {
      var0 = self.infilheightcompensation;
      self.personalscenenode moveTo(var1, 0.25, 0.05, 0.2);
    }

    waitframe();
  }
}

#using_animtree("script_model");

function infil_player_rig_updated(var0, var1, var2) {
  self.animname = var0;

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  self predictstreampos(var1);
  var3 = spawn("script_arms", var1, 0, 0, self);
  var3.angles = var2;
  var3.player = self;
  self.player_rig = var3;
  self.player_rig hide(1);
  self.player_rig.animname = var0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = &handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &handledofnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::ref_143a5("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    thread takegunless();
  }

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function handledofnotetrack(var0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }

  switch (var0) {
    case "blima_interior":
      self.player enablephysicaldepthoffieldscripting();

      switch (self.animname) {
        case "slot_0":
          self.player setphysicaldepthoffield(1.8, 40, 20, 20);
          break;
        case "slot_1":
          self.player setphysicaldepthoffield(1.8, 60, 20, 20);
          break;
        case "slot_2":
          self.player setphysicaldepthoffield(1.9, 50, 20, 20);
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
  }
}

function handlecinematicmotionnotetrack(var0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }

  var1 = getsubstr(var0, 0, 4);

  if(var1 == "set_") {
    var2 = getsubstr(var0, 4);
    self.player setcinematicmotionoverride(var2);
    return;
  }

  switch (var1) {
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

function handleweaponstatenotetrack(var0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }

  switch (var0) {
    case "drop":
      self.player setdemeanorviewmodel("normal");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_blocked");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_pending");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_complete");
      self.player scripts\engine\utility::ent_flag_set("swapLoadout_blocked");
      thread has_relic_amped_victim_survived_time();

      if(!isai(self.player)) {
        givegunless(self.player);
      }

      if(istrue(self.updatedversion)) {
        self showonlytoplayer(self.player);
      }

      self.player scripts\common\utility::allow_reload(0);
      break;
    case "raise":
      if(isDefined(self.player.infilweapon) && self.player hasweapon(self.player.infilweapon)) {
        self.player scripts\cp_mp\utility\inventory_utility::_takeweapon(self.player.infilweapon);
      }

      self.player.stopchallengetimers = 1;

      if(self.player scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && self.player scripts\engine\utility::ent_flag("swapLoadout_blocked")) {
        self.player scripts\engine\utility::ent_flag_clear("swapLoadout_blocked");
      }

      self.player setdemeanorviewmodel("normal");

      if(!istrue(self.updatedversion)) {
        self.player stopviewmodelanim();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "loadout_finalizeWeapons")) {
        self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "loadout_finalizeWeapons")]]();
      }

      if(!isai(self.player)) {
        takegunless(self.player);
      }

      if(istrue(self.updatedversion) && self.player islinked()) {
        self.player playerlinkedsetforceparentvisible(0);
      }

      if(!self.player scripts\common\utility::is_reload_allowed()) {
        self.player scripts\common\utility::allow_reload(1);
      }

      break;
    case "safe":
      self.player setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
      break;
    case "normal":
      self.player setdemeanorviewmodel("normal");
      break;
    case "free":
      self.player scripts\common\utility::allow_fire(1);
      self.player scripts\common\utility::allow_ads(1);

      if(!self.player scripts\common\utility::is_reload_allowed()) {
        self.player scripts\common\utility::allow_reload(1);
      }

      break;
    case "hold":
      self.player scripts\common\utility::allow_fire(0);
      self.player scripts\common\utility::allow_ads(0);

      if(!self.player scripts\common\utility::is_reload_allowed()) {
        self.player scripts\common\utility::allow_reload(0);
      }

      break;
  }
}

function has_relic_amped_victim_survived_time() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(self, "death", level, "prematch_over");
  scripts\engine\utility::ent_flag_clear("swapLoadout_blocked", 1);
  scripts\engine\utility::ent_flag_clear("swapLoadout_pending", 1);
  scripts\engine\utility::ent_flag_clear("swapLoadout_complete", 1);
}

function takegunless() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }

  if(scripts\engine\utility::ent_flag_exist("swapLoadout_pending") && scripts\engine\utility::ent_flag("swapLoadout_pending")) {
    scripts\engine\utility::ent_flag_wait("swapLoadout_complete");
  }

  if(!scripts\common\utility::is_script_weapon_switch_allowed()) {
    scripts\common\utility::allow_script_weapon_switch(1);
  }

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_script_weapon_switch(0);
}

function givegunless() {
  self endon("death_or_disconnect");

  if(isDefined(self.gunnlessweapon)) {
    return;
  }

  var0 = getcompleteweaponname("iw8_gunless_infil");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed()) {
    scripts\common\utility::allow_script_weapon_switch(1);
  }

  var1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 0);

  if(var1) {
    self.gunnlessweapon = var0;
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  scripts\common\utility::allow_script_weapon_switch(0);
  return var1;
}