/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\dialogue.gsc
**************************************/

#using scripts\anim\dialogue;
#using scripts\sp\anim;
#namespace dialogue;

function init() {
  level.vo_playsoundfunc = &function_8ddb33b98e21921b;
  level.var_6d0c2d172e9d53b8 = &function_ce31467a39393f72;
  level.var_32967d1c9bb79138 = &function_1e3834a89cff8bf2;
  setdvarifuninitialized(@ "hash_863010f158bacdd1", 0);
  setdvarifuninitialized(@ "vo_silenced", 0);
  level.var_6d5c2539933e4064 = &function_44d8ef3c3e159629;
}

function function_44d8ef3c3e159629(maxdist = level.bcs_maxdist) {
  return getcorpsearrayinradius(level.player.origin, maxdist);
}

function private function_ce31467a39393f72(player, sound_emitter, alias) {
  assert(isPlayer(player));
  assert(isstruct(sound_emitter) || isent(sound_emitter));
  assert(isstring(alias) || isxhash(alias));
  context = "";

  if(istrue(self.isradioemitter)) {
    context = "\x94J\xd7\xf6\x9f\xee\x9a\nK\xb8\x8d";
  } else {
    if(isDefined(level.var_ae6466efd97ba73b) && isDefined(level.var_ae6466efd97ba73b[alias])) {
      radio_dist = level.var_ae6466efd97ba73b[alias];
    } else {
      radio_dist = function_5eb9f109964cd0fb(alias) * 0.33;
    }

    player_distsq = distancesquared(player getEye(), sound_emitter.origin);
    context = player_distsq < squared(radio_dist) ? "\xce6V\x80\xbb\x7f\x92d\x95\x9c\x9d" : "2x\xfa\xc9,\x19\x96\xf6_\x19\x8c";
  }

  return context;
}

function private function_1e3834a89cff8bf2(sound_emitter, alias, contexttype, contextvalue, notification_string, var_f0e999956b095703) {
  var_a6277a1b5340fc20 = isstring(notification_string);
  var_e88333203a0ee75a = isint(var_f0e999956b095703);

  if(istrue(var_e88333203a0ee75a)) {
    sound_emitter playcontextsound(alias, contexttype, contextvalue, notification_string, var_f0e999956b095703);
    return;
  }

  if(istrue(var_a6277a1b5340fc20) && !istrue(var_e88333203a0ee75a)) {
    sound_emitter playcontextsound(alias, contexttype, contextvalue, notification_string);
    return;
  }

  sound_emitter playcontextsound(alias, contexttype, contextvalue);
}

function function_8ddb33b98e21921b(alias, tag, skip_face, temp_emitter) {
  speaker = self;

  if(isstruct(self) && isDefined(self.vo_parent)) {
    speaker = self.vo_parent;
  }

  is2demitter = istrue(self.is2demitter);
  assert(!is2demitter || !issound3d(alias), "<dev string:x24>" + alias + "<dev string:x46>");

  if(istrue(self.isradioemitter)) {
    if(!isDefined(tag)) {
      tag = "\xa7>4.\x83\x91\xac\x10";
    }
  } else if(!isDefined(tag)) {
    tag = "\xa6\xeb\x1ae\x85#";
  }

  if(!isDefined(temp_emitter)) {
    temp_emitter = 1;
  }

  emitter = self;

  if(isDefined(self.vo_parent)) {
    emitter = self.vo_parent function_f80299218aaf3c73(tag, (0, 0, 0), (0, 0, 0), temp_emitter);
  } else if(isPlayer(self) || isstruct(self) || isDefined(self.vo_emitter)) {
    emitter = function_f80299218aaf3c73();
  } else if(isDefined(tag) && !istrue(self.is2demitter) && !istrue(self.var_567eb9ced13bf08d) && self tagexists(tag)) {
    emitter = function_f80299218aaf3c73(tag, (-0.35, -3.5, 0), (0, 0, 0), temp_emitter);
  }

  emitter stopsounds();

  if(isDefined(speaker) && isent(speaker)) {
    speaker stopsoundchannel(";\xbdZ6\x95\xf5bc\x86a\xd1\x8eY\xc9_&\xebf\x19", 1);
  }

  self notify("p]\xd4\x92\x97\xe9y\xb2\xfb\xcc\x94g\x86");

  if(!function_78f0ecc00b3acd4e()) {
    assert(isfunction(level.var_6d0c2d172e9d53b8));
    assert(isfunction(level.var_32967d1c9bb79138));
    context = self[[level.var_6d0c2d172e9d53b8]](level.player, emitter, alias);
    assert(isstring(context));
    speaker[[level.var_32967d1c9bb79138]](emitter, alias, "\x80\x8f\xe03N\xfe\xfd", context);

    if(!istrue(self.skip_face) && !istrue(skip_face) && !istrue(function_c074b0461ffe5917(alias)) && (isai(self) || istrue(self.fakeactor_face_anim))) {
      face_anim = function_18ce72e5dd6c0f1e(alias);

      if(isDefined(face_anim)) {
        thread anim_sp::anim_facialanim(self, alias, face_anim);
      } else {
        thread anim_sp::anim_facialfiller("\xb6F\xb7\xa7|d?\xcc\x84>\\3\x88'\x81\x15x", undefined, 0, undefined, get_intensity(alias));
      }
    }
  }

  if(getdvarint(@ "hash_863010f158bacdd1")) {
    emitter thread function_8b015d6d3ca4a6a9();
  }

  if(emitter != self) {
    emitter.shoulddelete = 0;
  }

  result = function_483d7c45662405d1(alias);
  self notify("\xb6F\xb7\xa7|d?\xcc\x84>\\3\x88'\x81\x15x");
  thread function_b9f5e2c58d6479af(emitter);
  return istrue(result);
}

function function_483d7c45662405d1(alias) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("p]\xd4\x92\x97\xe9y\xb2\xfb\xcc\x94g\x86");
  duration = lookupsoundlength(alias) / 1000;
  wait duration;
  return true;
}

function function_78f0ecc00b3acd4e() {
  if(isDefined(self.team) && self.team == "O\x15\x1b\xad\x9ff" && !istrue(level.var_37d0f5fd64b73166) && !isalive(level.player)) {
    return true;
  }

  return istrue(self.vo_silenced) || istrue(level.vo_silenced) || getdvarint(@ "vo_silenced");
}

function get_intensity(alias) {
  if(isDefined(self.var_9608c6c40b1ddc05)) {
    return self.var_9608c6c40b1ddc05;
  }

  var_d0edcd6732ebb12b = ["\at", "\at", "E\x87", "G\xb7"];
  intensity = function_ce026cb48c8de954(alias) ?? 0;
  return var_d0edcd6732ebb12b[intensity];
}

function function_8b015d6d3ca4a6a9() {
  self endon("<dev string:x5c>");
  endscale = 0.65;
  depthtest = 0;

  while(true) {
    forward = anglesToForward(self.angles) * 2;
    up = forward + anglestoup(self.angles) * endscale;
    down = forward - anglestoup(self.angles) * endscale;
    left = forward + anglestoleft(self.angles) * endscale;
    right = forward + anglestoright(self.angles) * endscale;
    sphere(self.origin, 0.2, (1, 1, 1), depthtest, 1);
    sphere(self.origin + forward, endscale, (1, 0, 1), depthtest, 1);
    line(self.origin, self.origin + up, (1, 0, 1), 1, depthtest, 1);
    line(self.origin, self.origin + down, (1, 0, 1), 1, depthtest, 1);
    line(self.origin, self.origin + left, (1, 0, 1), 1, depthtest, 1);
    line(self.origin, self.origin + right, (1, 0, 1), 1, depthtest, 1);
    waitframe();
  }
}

# /