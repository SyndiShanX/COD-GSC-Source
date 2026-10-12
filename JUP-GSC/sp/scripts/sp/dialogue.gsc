/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\dialogue.gsc
***********************************************/



#using scripts\anim\dialogue;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#namespace dialogue;

function init() {
  level.vo_playsoundfunc = &function_7bd4fbf21584d46e;
  setdvarifuninitialized(@ "hash_863010f158bacdd1", 0);
  setdvarifuninitialized(@ "hash_a1e2ee2c6fe41007", 0);
  level.var_621af16ef0684a11 = &function_168830b0663bc9f4;
}

function function_168830b0663bc9f4(maxdist) {
  maxdist = default_to(maxdist, level.bcs_maxdist);
  return getcorpsearrayinradius(level.player.origin, maxdist);
}

function function_7bd4fbf21584d46e(alias, tag, skip_face, temp_emitter) {
  speaker = self;

  if(isstruct(self) && isDefined(self.vo_parent)) {
    speaker = self.vo_parent;
  }

  is2demitter = istrue(self.is2demitter);
  assertex(!is2demitter || !issound3d(alias), "Tried to play non-radio line '" + alias + "' on level/struct.");

  if(istrue(self.isradioemitter)) {
    tag = default_to(tag, "j_hip_ri");
  } else {
    tag = default_to(tag, "j_head");
  }

  temp_emitter = default_to(temp_emitter, 1);
  emitter = self;

  if(isDefined(self.vo_parent)) {
    emitter = self.vo_parent function_f5eb5b4d0e6714aa(tag, (0, 0, 0), (0, 0, 0), temp_emitter);
  } else if(isPlayer(self) || isstruct(self) || isDefined(self.vo_emitter)) {
    emitter = function_f5eb5b4d0e6714aa();
  } else if(!istrue(self.is2demitter) && !istrue(self.var_b05aad42f8a13a4) && self tagexists(tag)) {
    emitter = function_f5eb5b4d0e6714aa(tag, (-0.35, -3.5, 0), (0, 0, 0), temp_emitter);
  }

  emitter stopsounds();

  if(isDefined(speaker) && isent(speaker)) {
    speaker stopsoundchannel("voice_bchatter_1_3d", 1);
  }

  self notify("stop_dialogue");

  if(!function_8ff454339557a41b()) {
    if(istrue(self.isradioemitter)) {
      context = "dx_radio_3d";
    } else {
      if(isDefined(level.var_cb329546ed01d21a) && isDefined(level.var_cb329546ed01d21a[alias])) {
        radio_dist = level.var_cb329546ed01d21a[alias];
      } else {
        radio_dist = function_405ca75fc1a4ec12(alias) * 0.33;
      }

      player_distsq = distancesquared(level.player.origin + (0, 0, 60), emitter.origin);
      context = ter_op(player_distsq < squared(radio_dist), "dx_open_air", "dx_radio_2d");
    }

    emitter playcontextsound(alias, "dx_type", context);

    if(!istrue(self.skip_face) && !istrue(skip_face) && (isai(self) || istrue(self.fakeactor_face_anim))) {
      face_anim = function_6d4c7d2bd5969057(alias);

      if(isDefined(face_anim)) {
        thread scripts\sp\anim::anim_facialanim(self, alias, face_anim);
      } else {
        thread scripts\sp\anim::anim_facialfiller("stop_facialFiller", undefined, 0, undefined, get_intensity(alias));
      }
    }
  }

  if(getdvarint(@ "hash_863010f158bacdd1")) {
    emitter thread function_14aeae4cd83bd734();
  }

  if(emitter != self) {
    emitter.shoulddelete = 0;
  }

  function_ea5c0accfc20ea48(alias);
  self notify("stop_facialFiller");
  thread function_690ccae4e694f51e(emitter);
  return true;
}

function function_ea5c0accfc20ea48(alias) {
  self endon("death");
  self endon("stop_dialogue");
  duration = lookupsoundlength(alias) / 1000;
  wait duration;
}

function function_8ff454339557a41b() {
  if(isDefined(self.team) && self.team == "allies" && !istrue(level.var_ea3abe68a9130a0f) && !isalive(level.player)) {
    return true;
  }

  return istrue(self.vo_silenced) || istrue(level.vo_silenced) || getdvarint(@ "hash_a1e2ee2c6fe41007");
}

function get_intensity(alias) {
  if(isDefined(self.var_9af882a4ef5986c0)) {
    return self.var_9af882a4ef5986c0;
  }

  intensities = ["sm", "sm", "md", "lg"];
  intensity = default_to(function_d159656d2b07f8a5(alias), 0);
  return intensities[intensity];
}

function function_14aeae4cd83bd734() {
  self endon("<dev string:x1c>");
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