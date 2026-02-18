/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_18910f59cc847b42.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_1b2f6ef7778cf920;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_ac2a80f5;

function init() {
  function_32d5e898();
}

function function_32d5e898(localclientnum) {
  var_634814ee = 1;

  if(is_true(level.doa.var_318aa67a)) {
    var_634814ee = 6;
  }

  if(getlocalplayers().size > 1) {
    namespace_4dae815d::function_e1887b0f(1);
    var_634814ee = 4;
  }

  foreach(player in getlocalplayers()) {
    if(isDefined(player) && isDefined(player.doa)) {
      player.doa.cameramode = var_634814ee;
    }

    player function_278f20a3((75, 0, 0), function_ccf8a968(1));
  }
}

function function_57ce3201(localclientnum) {
  if(isbot(self)) {
    return;
  }

  self endon(#"disconnect");
  self notify("2862be11436776eb");
  self endon("2862be11436776eb");

  while(true) {
    level waittill(#"hash_743e9066181c346e");

    if(isDefined(localclientnum) && isDefined(self.doa)) {
      if(isDefined(self.doa.cameramode)) {
        if(self.doa.cameramode == 2 && !function_32cb6463(localclientnum)) {
          var_69c3bd16 = self function_1d5dc8d2(localclientnum, self.doa.cameramode);
          self changecamera(var_69c3bd16);
        }

        if(self.doa.cameramode == 3 && !function_32cb6463(localclientnum)) {
          var_69c3bd16 = self function_1d5dc8d2(localclientnum, self.doa.cameramode);
          self changecamera(var_69c3bd16);
        }
      }

      self namespace_7f5aeb59::function_4d692cc4(localclientnum, self.var_88a2ff29);
    }
  }
}

function function_278f20a3(angles, min_dist, max_dist = 0) {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }

  if(isDefined(self.doa.var_67c3a8db)) {
    angles = self.doa.var_67c3a8db;
  }

  if(isDefined(angles)) {
    vectornormalize(angles);
    self.doa.camera_angles = angles;
    self.doa.var_be529a4e = anglesToForward(angles) * -1;
    self.doa.var_7dd1941e = anglestoup(angles);
  }

  if(min_dist < 1) {
    min_dist = 1;
  }

  self.doa.var_f793b3d3 = min_dist;
  self.doa.var_878bf427 = max_dist;

  if(!isDefined(self.var_2d592f5b)) {
    self.var_2d592f5b = self.doa.camera_angles;
  }

  namespace_1e25ad94::debugmsg("++++++++++++++++++++++++ Player " + self getentitynumber() + " camera yaw angles are: " + self.doa.camera_angles);
}

function function_7dd474a0(localclientnum, delta_time) {
  player = level.localplayers[0];
  cam_pos = player.origin + (0, 0, 600);
  player camerasetposition(cam_pos);
  player camerasetlookat(player.doa.camera_angles);
}

function function_14f1aa2b(localclientnum, delta_time) {
  if(!isDefined(level.localplayers) || level.localplayers.size == 0) {
    return;
  }

  localplayer = function_5c10bd79(localclientnum);

  if(!isDefined(localplayer) || !isDefined(localplayer.doa)) {
    return;
  }

  if(level.localplayers.size > 1) {
    if(level.doa.r_splitscreenexpandfull == 1 && localclientnum > 0) {
      var_b2b025b1 = level.localplayers[0];

      if(isDefined(var_b2b025b1) && isDefined(var_b2b025b1.doa) && isDefined(var_b2b025b1.var_45c6f27d)) {
        cam_pos = var_b2b025b1.var_45c6f27d;
        angles = var_b2b025b1.var_2d592f5b;
        zoffset = 0;

        if(isDefined(var_b2b025b1.doa.var_c544c883)) {
          zoffset = var_b2b025b1.doa.var_c544c883;
        }

        localplayer camerasetposition(cam_pos + (0, 0, zoffset));
        localplayer camerasetlookat(angles);
        localplayer.var_45c6f27d = cam_pos;
        localplayer.var_2d592f5b = angles;
      }

      return;
    }
  }

  if(level.localplayers.size > 1) {
    if(level.doa.r_splitscreenexpandfull == 1 && localplayer.doa.cameramode != 4 && localplayer.doa.cameramode != 7) {
      localplayer.doa.cameramode = 4;
    }
  }

  cameramode = localplayer.doa.cameramode;

  if(cameramode == 7) {
    assert(isDefined(level.doa.var_b73cc08));
    cam_pos = level.doa.var_b73cc08.origin;
    angles = level.doa.var_b73cc08.angles;
    localplayer camerasetposition(cam_pos);
    localplayer camerasetlookat(angles);
    localplayer.var_45c6f27d = cam_pos;
    localplayer.var_2d592f5b = angles;
    return;
  }

  players = level.localplayers;
  angles = localplayer.doa.camera_angles;
  var_be529a4e = localplayer.doa.var_be529a4e;
  var_7dd1941e = localplayer.doa.var_7dd1941e;
  playercenter = localplayer.origin;
  vehicle = getplayervehicle(localplayer);

  if(isDefined(vehicle)) {
    playercenter = vehicle.origin;
  }

  if(cameramode == 4) {
    if(level.localplayers.size > 1) {
      mins = (1e+06, 1e+06, 1e+06);
      maxs = (-1e+06, -1e+06, -1e+06);

      if(level.doa.world_state == 0 && isDefined(level.doa.var_72b899ad)) {
        mins = function_2d9b1c4e(level.doa.var_72b899ad.origin, mins);
        maxs = function_663f7227(level.doa.var_72b899ad.origin, maxs);
      }

      foreach(player in getlocalplayers()) {
        mins = function_2d9b1c4e(player.origin, mins);
        maxs = function_663f7227(player.origin, maxs);
      }

      dims = maxs - mins;
      playercenter = (mins + maxs) * 0.5;
    } else if(isDefined(level.doa.var_72b899ad)) {
      dirtocenter = level.doa.var_72b899ad.origin - localplayer.origin;
      playercenter = localplayer.origin + dirtocenter * 0.25;
    }
  }

  if(is_true(level.var_fb0679ad)) {
    center = playercenter;
    cam_pos = center;
    var_91e98520 = center;
    cam_pos = (localplayer.origin[0], localplayer.origin[1], localplayer.origin[2]);
    facing = anglesToForward(localplayer getplayerangles());
    var_91e98520 = cam_pos + facing * (130 + abs(facing[0] * 30)) + localplayer getvelocity() * 0.5;

    if(isDefined(level.var_145dec4f)) {
      lerp_rate = 3;
      dir = var_91e98520 - level.var_145dec4f;

      if(lengthsquared(dir) < 1000000) {
        var_91e98520 = level.var_145dec4f + dir * lerp_rate * delta_time;
        cam_pos = var_91e98520;
      }
    }

    level.var_145dec4f = var_91e98520;
  }

  cam_pos = playercenter;
  cam_pos += var_be529a4e * localplayer.doa.var_f793b3d3;
  cam_pos += var_7dd1941e * -20;

  if(level.localplayers.size > 1 && cameramode == 4 && isDefined(level.doa.var_72b899ad)) {
    var_8172ec08 = 200;
    var_cfa24a5 = 1800;
    var_8d932466 = 450;
    var_5bdd9694 = abs(dims[1]);
    var_189a34e8 = 0;

    if(var_5bdd9694 > var_8172ec08) {
      var_189a34e8 = (var_5bdd9694 - var_8172ec08) / (var_cfa24a5 - var_8172ec08);
    }

    var_5c03fa4 = 50;
    var_d946d37e = 500;
    var_49a6f227 = abs(dims[0]);
    var_2280804 = 0;

    if(var_49a6f227 > var_5c03fa4) {
      var_2280804 = (var_49a6f227 - var_5c03fa4) / (var_d946d37e - var_5c03fa4);
      frac = math::clamp(var_2280804, 0, 1);
      center_y = level.doa.var_72b899ad.origin[1];
      var_9fe93364 = cam_pos[1] + (center_y - cam_pos[1]) * frac;
      cam_pos = (cam_pos[0], var_9fe93364, cam_pos[2]);
    }

    t = var_189a34e8;

    if(var_2280804 > t) {
      t = var_2280804;
    }

    var_fa5416a8 = var_8d932466;
    var_c9fdfd75 = 200;

    if(!isDefined(level.var_6a822745)) {
      level.var_6a822745 = var_c9fdfd75;
    }

    var_fa5416a8 -= var_c9fdfd75;

    if(t > 1) {
      var_c9fdfd75 *= t;
    }

    level.var_6a822745 += (var_c9fdfd75 - level.var_6a822745) * 3 * delta_time;
    cam_pos += var_be529a4e * var_c9fdfd75;
    var_fa5416a8 *= t;
    var_fa5416a8 = math::clamp(var_fa5416a8, 0, var_8d932466);

    if(!isDefined(level.var_fa5416a8)) {
      level.var_fa5416a8 = var_fa5416a8;
    }

    level.var_fa5416a8 += (var_fa5416a8 - level.var_fa5416a8) * 2 * delta_time;
    cam_pos += var_be529a4e * level.var_fa5416a8;
  }

  if(isDefined(localplayer.var_45c6f27d)) {
    lerp_rate = 2;
    dir = cam_pos - localplayer.var_45c6f27d;

    if(lengthsquared(dir) < 1000000) {
      cam_pos = localplayer.var_45c6f27d + dir * lerp_rate * delta_time;
    }
  }

  localplayer.var_ca14ee83 = angles;

  if(isDefined(localplayer.var_2d592f5b)) {
    lerp_rate = 3;
    dir = angles - localplayer.var_2d592f5b;
    angles = localplayer.var_2d592f5b + dir * lerp_rate * delta_time;
  }

  zoffset = 0;

  if(isDefined(localplayer.doa.var_c544c883)) {
    zoffset = localplayer.doa.var_c544c883;
  }

  if(cam_pos[2] > 3800) {
    cam_pos = (cam_pos[0], cam_pos[1], 3800);
  }

  localplayer camerasetposition(cam_pos + (0, 0, zoffset));
  localplayer camerasetlookat(angles);
  localplayer.var_45c6f27d = cam_pos;
  localplayer.var_2d592f5b = angles;
}

function function_2d9b1c4e(vec, mins) {
  if(vec[0] < mins[0]) {
    mins = (vec[0], mins[1], mins[2]);
  }

  if(vec[1] < mins[1]) {
    mins = (mins[0], vec[1], mins[2]);
  }

  if(vec[2] < mins[2]) {
    mins = (mins[0], mins[1], vec[2]);
  }

  return mins;
}

function function_663f7227(vec, maxs) {
  if(vec[0] > maxs[0]) {
    maxs = (vec[0], maxs[1], maxs[2]);
  }

  if(vec[1] > maxs[1]) {
    maxs = (maxs[0], vec[1], maxs[2]);
  }

  if(vec[2] > maxs[2]) {
    maxs = (maxs[0], maxs[1], vec[2]);
  }

  return maxs;
}

function changecamera(mode) {
  if(!isDefined(self.doa)) {
    return;
  }

  self.doa.cameramode = mode;
  assert(isDefined(self.doa.cameramode));

  if(is_true(level.doa.var_318aa67a)) {
    self.doa.cameramode = 6;
    self.topdowncamera = 0;
    self.doa.infps = 1;
  }

  self cameraforcedisablescriptcam(0);

  if(is_true(level.doa.var_dec041f5)) {
    self.doa.cameramode = 7;
  } else if(level.localplayers.size > 1) {
    if(self.doa.cameramode == 4 && level.doa.r_splitscreenexpandfull != 1) {
      namespace_4dae815d::function_e1887b0f(1);
    }

    if(self.doa.cameramode == 5 && level.doa.r_splitscreenexpandfull != 0) {
      namespace_4dae815d::function_e1887b0f(0);
    }

    namespace_4dae815d::function_b6e8ef46();
    return;
  } else if(self.doa.cameramode == 6) {
    self cameraforcedisablescriptcam(1);
  }

  height = function_ccf8a968(self.doa.cameramode);

  if(isDefined(level.doa.var_72b899ad) && isDefined(level.doa.var_72b899ad.camera_max_height)) {
    if(height > level.doa.var_72b899ad.camera_max_height) {
      height = level.doa.var_72b899ad.camera_max_height;
    }
  }

  if(level.doa.world_state == 0) {
    assert(isDefined(isDefined(level.doa.var_72b899ad)));
    normalangle = level.doa.var_72b899ad.var_13ea8aea;
    var_1d83376c = level.doa.var_72b899ad.var_46f3a17d;
  } else {
    normalangle = (75, 0, 0);
    var_1d83376c = (75, 180, 0);
  }

  if(is_true(self.doa.var_71122e79)) {
    self function_278f20a3(var_1d83376c, height);
  } else {
    self function_278f20a3(normalangle, height);
  }

  namespace_1e25ad94::debugmsg("<dev string:x38>" + self getentitynumber() + "<dev string:x43>" + self.doa.cameramode);
}

function function_1d5dc8d2(localclientnum, var_545466e8 = 1) {
  if(isDefined(level.doa.var_dbdc241e)) {
    return level.doa.var_dbdc241e;
  }

  if(level.localplayers.size > 1) {
    if(level.doa.r_splitscreenexpandfull == 0 && namespace_4dae815d::function_abcdf17f()) {
      return 5;
    }

    if(level.doa.r_splitscreenexpandfull == 1) {
      return 5;
    } else {
      return 4;
    }
  }

  var_545466e8++;
  var_c0547bf3 = 3;

  if(level.doa.world_state == 0) {
    var_c0547bf3 = 4;
  }

  if(isDefined(level.doa.var_182fb75a) || isDefined(level.doa.var_938e4f08) && level.doa.var_938e4f08 != 0) {
    var_c0547bf3 = 2;
  }

  if(var_545466e8 > var_c0547bf3) {
    var_545466e8 = 0;
  }

  if(var_545466e8 == 2 && !function_32cb6463(localclientnum)) {
    if(var_545466e8 < var_c0547bf3) {
      var_545466e8++;
    } else {
      var_545466e8 = 0;
    }
  }

  if(var_545466e8 == 3 && !function_32cb6463(localclientnum)) {
    if(var_545466e8 < var_c0547bf3) {
      var_545466e8++;
    } else {
      var_545466e8 = 0;
    }
  }

  return var_545466e8;
}

function function_ccf8a968(var_545466e8) {
  if(!isDefined(var_545466e8)) {
    return 650;
  }

  switch (var_545466e8) {
    case 0:
      return 400;
    case 1:
    case 4:
      return 650;
    case 2:
      return 900;
    case 3:
      return 1200;
    case 8:
      return 800;
    default:
      return 650;
  }
}

function function_f7736714(localclientnum, cameramode) {
  if(cameramode == 2 && !function_32cb6463(localclientnum)) {
    cameramode = self function_1d5dc8d2(localclientnum, cameramode);
  }

  if(cameramode == 3 && !function_32cb6463(localclientnum)) {
    cameramode = self function_1d5dc8d2(localclientnum, cameramode);
  }

  return cameramode;
}