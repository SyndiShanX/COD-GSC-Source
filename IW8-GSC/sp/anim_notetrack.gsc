/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\anim_notetrack.gsc
***********************************************/

entity_handle_notetrack(var_0, var_1) {
  if(isDefined(level.customnotetrackhandler))
    var_0[[level.customnotetrackhandler]](var_1);

  if(var_0 scripts\anim\notetracks.gsc::notetrack_prefix_handler(var_1)) {
    return;
  }
  general_notetrack_handler(var_0, var_1);
}

general_notetrack_handler(var_0, var_1) {
  switch (var_1) {
    case "ignoreall true":
      var_0.ignoreall = 1;
      break;
    case "ignoreall false":
      var_0.ignoreall = 0;
      break;
    case "ignoreme true":
      var_0.ignoreme = 1;
      break;
    case "ignoreme false":
      var_0.ignoreme = 0;
      break;
    case "allowdeath true":
      var_0.allowdeath = 1;
      break;
    case "allowdeath false":
      var_0.allowdeath = 0;
      break;
    case "follow off":
      var_0.followoff = 1;
      break;
    case "follow on":
      var_0.followoff = 0;
      break;
    case "lookat_plr_head_on":
      break;
    case "lookat_plr_eyes_on":
      var_0 thread scripts\engine\sp\utility::gesture_follow_eyes(level.player, 4.0, 0.1);
      break;
    case "lookat_plr_off":
      var_0 thread scripts\engine\sp\utility::gesture_stop(0.7);
      break;
    case "lookat_plr_eyes_off":
      var_0 thread scripts\engine\sp\utility::gesture_eyes_stop(0.1);
      break;
    case "lookat_plr_head_off":
      break;
    case "bc_vo_start":
      var_0 notify("bc_vochat_start");
      break;
    case "blind_on":
      var_0 scripts\stealth\callbacks::stealth_call("set_blind", 1);
      break;
    case "blind_off":
      var_0 scripts\stealth\callbacks::stealth_call("set_blind", 0);
      break;
    case "start_aim":
      self.gunposeoverride_internal = undefined;
      break;
    case "mayhem_start":
      break;
    case "mayhem_end":
      break;
  }
}

sp_anim_handle_notetrack(var_0, var_1, var_2, var_3) {
  scripts\common\notetrack::anim_handle_notetrack(var_0, var_1, var_2, var_3);

  if(isDefined(var_0["flag"]))
    scripts\engine\utility::flag_set(var_0["flag"]);

  if(isDefined(var_0["flag_clear"]))
    scripts\engine\utility::flag_clear(var_0["flag_clear"]);

  if(isDefined(var_0["attach gun left"])) {
    var_1 gun_pickup_left();
    return;
  }

  if(isDefined(var_0["attach gun right"])) {
    var_1 gun_pickup_right();
    return;
  }

  if(isDefined(var_0["detach gun"])) {
    var_1 gun_leave_behind(var_0);
    return;
  }

  if(isDefined(var_0["mayhem_start"]))
    mayhem_start(var_0["mayhem_start"], var_0["use_hat_model"]);

  if(isDefined(var_0["mayhem_end"]))
    mayhem_end(var_0["mayhem_end"], var_0["use_hat_model"]);

  if(isDefined(var_0["sound"])) {
    var_4 = undefined;

    if(!isDefined(var_0["sound_stays_death"]))
      var_4 = 1;

    var_5 = undefined;

    if(isDefined(var_0["sound_on_tag"]))
      var_5 = var_0["sound_on_tag"];

    var_1 thread scripts\engine\sp\utility::play_sound_on_tag(var_0["sound"], var_5, var_4);
  }

  if(isDefined(var_0["playersound"]))
    level.player playSound(var_0["playersound"]);

  if(isDefined(var_0["playerdialogue"]))
    level.player thread scripts\engine\sp\utility::smart_player_dialogue(var_0["playerdialogue"]);
}

gun_pickup_left() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }
  self.gun_on_ground delete();
  self.dropweapon = 1;
  scripts\anim\shared.gsc::placeweaponon(self.weapon, "left");
}

gun_pickup_right() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }
  self.gun_on_ground delete();
  self.dropweapon = 1;
  scripts\anim\shared.gsc::placeweaponon(self.weapon, "right");
}

gun_leave_behind(var_0) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }
  var_1 = undefined;

  if(isDefined(var_0["suspend"]))
    var_1 = var_0["suspend"];

  scripts\sp\anim::primaryweapon_leave_behind(var_0["tag"], var_1);
}

mayhem_start(var_0, var_1) {
  self.notetrackmayhemstarted = 1;
  self detach(self.headmodel);

  if(!istrue(var_1) && isDefined(self.hatmodel))
    self detach(self.hatmodel);

  self setanim(var_0, 1.0, 0.0, 1.0);
}

mayhem_end(var_0, var_1) {
  if(!istrue(self.notetrackmayhemstarted)) {
    return;
  }
  self.notetrackmayhemstarted = undefined;
  self setanim(var_0, 0.0, 0.0, 1.0);
  self attach(self.headmodel);

  if(!istrue(var_1) && isDefined(self.hatmodel))
    self attach(self.hatmodel);
}