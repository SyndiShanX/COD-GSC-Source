/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\anim_notetrack.gsc
***********************************************/

function entity_handle_notetrack(var0, var1) {
  if(isDefined(level.customnotetrackhandler)) {
    var0[[level.customnotetrackhandler]](var1);
  }

  if(var0 scripts\anim\notetracks::notetrack_prefix_handler(var1)) {
    return;
  }

  general_notetrack_handler(var0, var1);
}

function general_notetrack_handler(var0, var1) {
  switch (var1) {
    case "ignoreall true":
      var0.ignoreall = 1;
      break;
    case "ignoreall false":
      var0.ignoreall = 0;
      break;
    case "ignoreme true":
      var0.ignoreme = 1;
      break;
    case "ignoreme false":
      var0.ignoreme = 0;
      break;
    case "allowdeath true":
      var0.allowdeath = 1;
      break;
    case "allowdeath false":
      var0.allowdeath = 0;
      break;
    case "follow off":
      var0.followoff = 1;
      break;
    case "follow on":
      var0.followoff = 0;
      break;
    case "lookat_plr_head_on":
      break;
    case "lookat_plr_eyes_on":
      var0 thread scripts\engine\sp\utility::gesture_follow_eyes(level.player, 4, 0.1);
      break;
    case "lookat_plr_off":
      var0 thread scripts\engine\sp\utility::gesture_stop(0.7);
      break;
    case "lookat_plr_eyes_off":
      var0 thread scripts\engine\sp\utility::gesture_eyes_stop(0.1);
      break;
    case "lookat_plr_head_off":
      break;
    case "bc_vo_start":
      var0 notify("bc_vochat_start");
      break;
    case "blind_on":
      var0 scripts\stealth\callbacks::stealth_call("set_blind", 1);
      break;
    case "blind_off":
      var0 scripts\stealth\callbacks::stealth_call("set_blind", 0);
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

function sp_anim_handle_notetrack(var0, var1, var2, var3) {
  scripts\common\notetrack::anim_handle_notetrack(var0, var1, var2, var3);

  if(isDefined(var0["flag"])) {
    scripts\engine\utility::flag_set(var0["flag"]);
  }

  if(isDefined(var0["flag_clear"])) {
    scripts\engine\utility::flag_clear(var0["flag_clear"]);
  }

  if(isDefined(var0["attach gun left"])) {
    gun_pickup_left(var1);
    return;
  }

  if(isDefined(var0["attach gun right"])) {
    gun_pickup_right(var1);
    return;
  }

  if(isDefined(var0["detach gun"])) {
    gun_leave_behind(var1, var0);
    return;
  }

  if(isDefined(var0["mayhem_start"])) {
    mayhem_start(var0["mayhem_start"], var0["use_hat_model"]);
  }

  if(isDefined(var0["mayhem_end"])) {
    mayhem_end(var0["mayhem_end"], var0["use_hat_model"]);
  }

  if(isDefined(var0["sound"])) {
    var4 = undefined;

    if(!isDefined(var0["sound_stays_death"])) {
      var4 = 1;
    }

    var5 = undefined;

    if(isDefined(var0["sound_on_tag"])) {
      var5 = var0["sound_on_tag"];
    }

    var1 thread scripts\engine\sp\utility::play_sound_on_tag(var0["sound"], var5, var4);
  }

  if(isDefined(var0["playersound"])) {
    level.player playSound(var0["playersound"]);
  }

  if(isDefined(var0["playerdialogue"])) {
    level.player thread scripts\engine\sp\utility::smart_player_dialogue(var0["playerdialogue"]);
    return;
  }
}

function gun_pickup_left() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }

  self.gun_on_ground delete();
  self.dropweapon = 1;
  scripts\anim\shared::placeweaponon(self.weapon, "left");
}

function gun_pickup_right() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }

  self.gun_on_ground delete();
  self.dropweapon = 1;
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

function gun_leave_behind(var0) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }

  var1 = undefined;

  if(isDefined(var0["suspend"])) {
    var1 = var0["suspend"];
  }

  scripts\sp\anim::primaryweapon_leave_behind(var0["tag"], var1);
}

function mayhem_start(var0, var1) {
  self.notetrackmayhemstarted = 1;
  self detach(self.headmodel);

  if(!istrue(var1) && isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
  }

  self setanim(var0, 1, 0, 1);
}

function mayhem_end(var0, var1) {
  if(!istrue(self.notetrackmayhemstarted)) {
    return;
  }

  self.notetrackmayhemstarted = undefined;
  self setanim(var0, 0, 0, 1);
  self attach(self.headmodel);

  if(!istrue(var1) && isDefined(self.hatmodel)) {
    self attach(self.hatmodel);
    return;
  }
}