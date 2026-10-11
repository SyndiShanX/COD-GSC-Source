/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\anim_notetrack.gsc
***********************************************/

#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#using scripts\stealth\callbacks;
#namespace anim_notetrack;

function entity_handle_notetrack(guy, notetrack) {
  if(isDefined(level.customnotetrackhandler)) {
    guy[[level.customnotetrackhandler]](notetrack);
  }

  if(guy scripts\anim\notetracks::notetrack_prefix_handler(notetrack)) {
    return;
  }

  general_notetrack_handler(guy, notetrack);
}

function general_notetrack_handler(guy, notetrack) {
  switch (notetrack) {
    case #"hash_2742a9c94193a8ee":
      guy.ignoreall = 1;
      break;
    case #"hash_2270e5f1abf0abe9":
      guy.ignoreall = 0;
      break;
    case #"hash_b189c5593491717b":
      guy.ignoreme = 1;
      break;
    case #"hash_16b8d08c0bdf34e6":
      guy.ignoreme = 0;
      break;
    case #"hash_87f7e10ad1c9d3d8":
      guy.allowdeath = 1;
      break;
    case #"hash_f061490bc0cc0db3":
      guy.allowdeath = 0;
      break;
    case #"hash_15f82edb036e4bd5":
      guy.followoff = 1;
      break;
    case #"hash_b5e8c4af3bb870f9":
      guy.followoff = 0;
      break;
    case #"hash_20bdd8e5807eba93":
      assertmsg("Notetrack lookat_plr_head_on is no longer supported, please switch to ht_on");
      break;
    case #"hash_232c697758706fa7":
      guy thread gesture_follow_eyes(level.player, 4, 0.1);
      break;
    case #"hash_7be27fbe5eb455d8":
      guy thread gesture_stop(0.7);
      break;
    case #"hash_cf40d7e038ec7e4b":
      guy thread gesture_eyes_stop(0.1);
      break;
    case #"hash_9b056494793be37":
      assertmsg("Notetrack lookat_plr_head_off is no longer supported, please switch to ht_off");
      break;
    case #"hash_8306154af16b0943":
      guy notify("bc_vochat_start");
      break;
    case #"hash_3f80c02caeb2ec99":
      self.gunposeoverride_internal = undefined;
      break;
    case #"hash_a323759a335e5427":
      break;
    case #"hash_20abdd92e0ae9282":
      break;
  }
}

function sp_anim_handle_notetrack(scr_notetrack, guy, dialogue_array, tag_owner) {
  anim_handle_notetrack(scr_notetrack, guy, dialogue_array, tag_owner);

  if(isDefined(scr_notetrack["flag"])) {
    flag_set(scr_notetrack["flag"]);
  }

  if(isDefined(scr_notetrack["flag_clear"])) {
    flag_clear(scr_notetrack["flag_clear"]);
  }

  if(isDefined(scr_notetrack["attach gun left"])) {
    guy gun_pickup_left();
    return;
  }

  if(isDefined(scr_notetrack["attach gun right"])) {
    guy gun_pickup_right();
    return;
  }

  if(isDefined(scr_notetrack["detach gun"])) {
    guy gun_leave_behind(scr_notetrack);
    return;
  }

  if(isDefined(scr_notetrack["mayhem_start"])) {
    mayhem_start(scr_notetrack["mayhem_start"], scr_notetrack["use_hat_model"]);
  }

  if(isDefined(scr_notetrack["mayhem_end"])) {
    mayhem_end(scr_notetrack["mayhem_end"], scr_notetrack["use_hat_model"]);
  }

  if(isDefined(scr_notetrack["sound"])) {
    var_a38dc1947e93b08d = undefined;

    if(!isDefined(scr_notetrack["sound_stays_death"])) {
      var_a38dc1947e93b08d = 1;
    }

    tag = undefined;

    if(isDefined(scr_notetrack["sound_on_tag"])) {
      tag = scr_notetrack["sound_on_tag"];
    }

    guy thread play_sound_on_tag(scr_notetrack["sound"], tag, var_a38dc1947e93b08d);
  }

  if(isDefined(scr_notetrack["playersound"])) {
    level.player playSound(scr_notetrack["playersound"]);
  }

  if(isDefined(scr_notetrack["playerdialogue"])) {
    level.player thread smart_player_dialogue(scr_notetrack["playerdialogue"]);
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

function gun_leave_behind(scr_notetrack) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }

  suspend = undefined;

  if(isDefined(scr_notetrack["suspend"])) {
    suspend = scr_notetrack["suspend"];
  }

  scripts\sp\anim::primaryweapon_leave_behind(scr_notetrack["tag"], suspend);
}

function mayhem_start(animation, usehatmodel) {
  self.notetrackmayhemstarted = 1;
  self detach(self.headmodel);

  if(!istrue(usehatmodel) && isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
  }

  self setanim(animation, 1, 0, 1);
}

function mayhem_end(animation, usehatmodel) {
  if(!istrue(self.notetrackmayhemstarted)) {
    return;
  }

  self.notetrackmayhemstarted = undefined;
  self setanim(animation, 0, 0, 1);
  self attach(self.headmodel);

  if(!istrue(usehatmodel) && isDefined(self.hatmodel)) {
    self attach(self.hatmodel);
  }
}