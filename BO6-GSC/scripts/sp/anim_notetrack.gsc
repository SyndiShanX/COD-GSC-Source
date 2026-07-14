/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\anim_notetrack.gsc
*****************************************/

#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\common\notetrack;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#namespace anim_notetrack;

function entity_handle_notetrack(guy, notetrack) {
  if(isDefined(level.customnotetrackhandler)) {
    guy[[level.customnotetrackhandler]](notetrack);
  }

  if(guy notetracks::notetrack_prefix_handler(notetrack)) {
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
      assertmsg("<dev string:x24>");
      break;
    case #"hash_232c697758706fa7":
      guy thread utility_sp::gesture_follow_eyes(level.player, 4, 0.1);
      break;
    case #"hash_7be27fbe5eb455d8":
      guy thread utility_sp::gesture_stop(0.7);
      break;
    case #"hash_cf40d7e038ec7e4b":
      guy thread utility_sp::gesture_eyes_stop(0.1);
      break;
    case #"hash_9b056494793be37":
      assertmsg("<dev string:x73>");
      break;
    case #"hash_8306154af16b0943":
      guy notify("\xbe1\xf2m/C\xb8#M\xd2\x89\xd61iJ");
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
  notetrack::anim_handle_notetrack(scr_notetrack, guy, dialogue_array, tag_owner);

  if(isDefined(scr_notetrack["9\x7f\xbb\xbd"])) {
    utility::flag_set(scr_notetrack["9\x7f\xbb\xbd"]);
  }

  if(isDefined(scr_notetrack["\x1b\\A\xe7W\xdfJ\xd3\xd3a"])) {
    utility::flag_clear(scr_notetrack["\x1b\\A\xe7W\xdfJ\xd3\xd3a"]);
  }

  if(isDefined(scr_notetrack["\x9ddM9\xfe\xa7:,`z\xa6\x8d3\x04$"])) {
    guy gun_pickup_left();
    return;
  }

  if(isDefined(scr_notetrack["\xbfY\xd1\xe0UGt\\\xd5-\xdf\rL\xc1\x183"])) {
    guy gun_pickup_right();
    return;
  }

  if(isDefined(scr_notetrack["\"\xa9\xce!\xe8q(\x989\xe1"])) {
    guy gun_leave_behind(scr_notetrack);
    return;
  }

  if(isDefined(scr_notetrack["6;\xac-\x16\x90\x88\xcf\x95\x80\rc"])) {
    mayhem_start(scr_notetrack["6;\xac-\x16\x90\x88\xcf\x95\x80\rc"], scr_notetrack["\xd5\xa6ZW\xa9\x1514\x01\x18\xbd\xa5\xb4"]);
  }

  if(isDefined(scr_notetrack["w}\xce\x1d\xbf\xae\x04\xb2*g"])) {
    mayhem_end(scr_notetrack["w}\xce\x1d\xbf\xae\x04\xb2*g"], scr_notetrack["\xd5\xa6ZW\xa9\x1514\x01\x18\xbd\xa5\xb4"]);
  }

  if(isDefined(scr_notetrack["4\xacz\xed|"])) {
    var_641c35d6fba0c240 = undefined;

    if(!isDefined(scr_notetrack["\xff\xef\x86\x7f\xe1\xa3\x9du\x95{\x17q1oEF\x05"])) {
      var_641c35d6fba0c240 = 1;
    }

    tag = undefined;

    if(isDefined(scr_notetrack["\xf1%\xcem\x1e<qB\x05\x93\xf8\x92"])) {
      tag = scr_notetrack["\xf1%\xcem\x1e<qB\x05\x93\xf8\x92"];
    }

    guy thread utility_sp::play_sound_on_tag(scr_notetrack["4\xacz\xed|"], tag, var_641c35d6fba0c240);
  }

  if(isDefined(scr_notetrack["wP\xa2\x98y\xeb\xffVf\x8d\x92"])) {
    level.player playSound(scr_notetrack["wP\xa2\x98y\xeb\xffVf\x8d\x92"]);
  }

  if(isDefined(scr_notetrack["\xe0\xa0\xc5f\xf5\x10j\xedP\x91\xb6\x90\vd"])) {
    level.player thread utility_sp::smart_player_dialogue(scr_notetrack["\xe0\xa0\xc5f\xf5\x10j\xedP\x91\xb6\x90\vd"]);
  }
}

function gun_pickup_left() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }

  self.gun_on_ground delete();
  self.dropweapon = 1;
  shared::placeweaponon(self.weapon, "=\xff0b");
}

function gun_pickup_right() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }

  self.gun_on_ground delete();
  self.dropweapon = 1;
  shared::placeweaponon(self.weapon, "o0\xee\xc1\x8c");
}

function gun_leave_behind(scr_notetrack) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }

  suspend = undefined;

  if(isDefined(scr_notetrack["W\xbdNpd\x02\xf7"])) {
    suspend = scr_notetrack["W\xbdNpd\x02\xf7"];
  }

  anim_sp::primaryweapon_leave_behind(scr_notetrack["\xa9\xa1\x03"], suspend);
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