/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_20a226c24f1585bf.gsc
*************************************************/

#using script_2304453c69e996e2;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#namespace namespace_adca7bd47b8c5e04;

function function_403ee60da9709c3d(var_da9f2b894ff73151, turret_team, var_93e8e9bf1e00cacc, var_d553022aa7804f03, check_los) {
  if(isDefined(var_d553022aa7804f03)) {
    target_callback = var_d553022aa7804f03;
  } else {
    target_callback = &function_1742ecf6da004355;
  }

  vehicle_ref = scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();
  turret_tags = [];

  switch (vehicle_ref) {
    case #"hash_66c8846b85d8c948":
      turret_tags = ["tag_turret_front", "tag_turret_rear"];
      break;
    case #"hash_174ce9a6344b18a4":
      turret_tags = ["tag_turret"];
      break;
    case #"hash_343a0ff44c1e5130":
      turret_tags = ["tag_turret"];
      break;
    default:
      return;
  }

  if(!isDefined(level._effect["turret_muzflash"])) {
    level._effect["turret_muzflash"] = loadfx("vfx/core/muzflash/minigun_flash_cheap.vfx");
  }

  self.turrets = [];

  foreach(index, turret_tag in turret_tags) {
    self.turrets[index] = spawnturret("misc_turret", self gettagorigin(turret_tag), "chopper_support_turret_mp");

    if(isDefined(self.turrets[index])) {
      self.turrets[index] setModel("veh9_mil_air_heli_hind_turret_mp");
      self.turrets[index].team = self.team;
      self.turrets[index].angles = self.angles;

      if(self.is_landed) {
        self.turrets[index].turreton = 0;
      } else {
        self.turrets[index].turreton = 1;
      }

      self.turrets[index].name = "heli_turret";
      self.turrets[index].current_target = undefined;
      self.turrets[index].turret_tag = turret_tag;
      self.turrets[index] linkTo(self, turret_tag, (0, 0, 0), (0, 0, 0));
      self.turrets[index] setturretteam(turret_team);
      self.turrets[index] setturretmodechangewait(0);
      self.turrets[index] setmode("manual");
      self.turrets[index] maketurretinoperable();
      self.turrets[index] makeunusable();
      var_da9f2b894ff73151 = "magicturretsettings:" + var_da9f2b894ff73151;
      settings_bundle = getscriptbundle(var_da9f2b894ff73151);
      var_323c60a9fe03ff28 = getscriptbundlenames("magicturretsettings");
      self.turrets[index] function_9e96cdf67b925aa0(settings_bundle);
      self.turrets[index].team = turret_team;
      self.turrets[index].var_93e8e9bf1e00cacc = var_93e8e9bf1e00cacc;
      self.turrets[index].target_callback = target_callback;
      self.turrets[index] function_a03f94132845002a(self, check_los);
    }
  }
}

function function_ed737153dc8baac7(target_callback) {
  foreach(turret in self.turrets) {
    turret.target_callback = target_callback;
  }
}

function private function_a03f94132845002a(vehicle, check_los) {
  vehicle endon("death");
  vehicle endon("crashing");
  vehicle endon("entitydeleted");
  childthread function_de3fc172a25ca50b();
  childthread function_be442ba784aa304a(vehicle, check_los);
  childthread function_8e6c75e710d28c52(vehicle);
}

function private function_8e6c75e710d28c52(vehicle) {
  vehicle endon("death");
  vehicle endon("crashing");
  vehicle endon("entitydeleted");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 1000;
  self.health = 1000;

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(attacker) && !array_contains(level.players, attacker)) {
      self.health += amount;
      waitframe();
      continue;
    }

    waitframe();
  }
}

function private function_be442ba784aa304a(vehicle, check_los, los_buffer) {
  vehicle endon("death");
  vehicle endon("crashing");
  vehicle endon("entitydeleted");
  self endon("death");
  los_buffer = default_to(los_buffer, 3);
  self.groundtargetent = spawn("script_model", self.origin);
  self.groundtargetent setModel("tag_origin");
  self.groundtargetent dontinterpolate();
  self settargetentity(self.groundtargetent);
  wait randomfloatrange(1, 3);

  while(true) {
    if(istrue(self.turreton)) {
      current_target = [[self.target_callback]](vehicle);

      if(isDefined(current_target)) {
        if(istrue(check_los)) {
          if(!vehicle namespace_c908de38bcdbd93d::function_618e0f50b9b8b310(current_target)) {
            wait los_buffer;
            continue;
          }
        }

        vehicle notify("target_acquired");
        vehicle.current_target = current_target;

        if(function_93ff5e5ba263fc6d(vehicle, current_target) < self.var_cc99a14e60508d29) {
          waitframe();
          continue;
        }

        childthread function_f2ad42531b9ae44c(vehicle, current_target, self.var_d2e7d6658b0a045a, self.minscaledistance, self.maxscaledistance, self.var_433171aa24dce75e, self.var_cc3cb55a3ae27b6c, self.var_60fce4cc4f6acabc, self.var_35635307ee241aae);
        function_f6c09d12e004b5ab(vehicle, current_target);
      }
    }

    wait randomfloatrange(self.var_22724a721b4b206e, self.var_224f3c721b24b9ec);
  }
}

function private function_1742ecf6da004355(vehicle) {
  vehicle endon("death");
  vehicle endon("crashing");
  vehicle endon("entitydeleted");
  self endon("death");
  canseetarget = 0;
  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_b9d5783a4f34efbc = [vehicle, self];
  sorted_players = sortbydistancecullbyradius(level.players, self.origin, self.fire_range);

  if(sorted_players.size > 0) {
    foreach(player in sorted_players) {
      if(isinlaststand(player) || istrue(player.ignoreme) || istrue(player.notarget)) {
        continue;
      }

      target_direction = player.origin - vehicle.origin;
      dot = vectordot2(target_direction, anglesToForward(vehicle.angles), 1);

      if(dot < self.var_cc99a14e60508d29) {
        continue;
      }

      if(istrue(player scripts\cp_mp\utility\player_utility::isinvehicle())) {
        occupiedvehicle = player scripts\cp_mp\utility\player_utility::getvehicle();
        var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = occupiedvehicle;
        linkedmodels = occupiedvehicle getlinkedchildren();

        if(isDefined(linkedmodels) && linkedmodels.size > 0) {
          var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
        }
      }

      if(player tagexists("j_head")) {
        canseetarget = scripts\engine\trace::ray_trace_passed(vehicle gettagorigin(self.turret_tag), player gettagorigin("j_head"), var_b9d5783a4f34efbc, contentsoverride);
      }

      if(istrue(canseetarget)) {
        return player;
      }
    }
  }

  non_players = [];

  foreach(ai_team in self.var_93e8e9bf1e00cacc) {
    non_players = array_combine(non_players, getaiarray(ai_team));
  }

  if(non_players.size > 0) {
    var_a82fef516b506159 = sortbydistancecullbyradius(non_players, self.origin, self.fire_range);

    if(var_a82fef516b506159.size > 0) {
      foreach(non_player in var_a82fef516b506159) {
        target_direction = non_player.origin - vehicle.origin;
        dot = vectordot2(target_direction, anglesToForward(vehicle.angles), 1);

        if(dot < self.var_cc99a14e60508d29) {
          continue;
        }

        if(isDefined(non_player.vehicle) && isDefined(non_player.vehicle_position)) {
          var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = non_player.vehicle;
          linkedmodels = non_player.vehicle getlinkedchildren();

          if(isDefined(linkedmodels) && linkedmodels.size > 0) {
            var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
          }
        }

        canseetarget = scripts\engine\trace::ray_trace_passed(vehicle gettagorigin(self.turret_tag), non_player getEye(), var_b9d5783a4f34efbc, contentsoverride);

        if(istrue(canseetarget)) {
          return non_player;
        }
      }
    }
  }

  return undefined;
}

function private function_f2ad42531b9ae44c(vehicle, current_target, var_d2e7d6658b0a045a, minscaledistance, maxscaledistance, var_433171aa24dce75e, var_cc3cb55a3ae27b6c, var_60fce4cc4f6acabc, var_35635307ee241aae) {
  self endon("stop_turret_burst");
  var_3dcdf4612dca3c06 = randomintrange(self.var_a9b3f28f2a95607c, self.var_a990e08f2a6ef12e);

  if(var_d2e7d6658b0a045a == "scaleByTime") {
    burst_length = var_3dcdf4612dca3c06 * self.fire_delay * 1000;
    end_time = gettime() + burst_length;
  }

  for(i = 0; i < var_3dcdf4612dca3c06; i++) {
    if(!isDefined(current_target) || isPlayer(current_target) && isinlaststand(current_target)) {
      break;
    }

    turretposition = vehicle gettagorigin(self.turret_tag);
    targetposition = current_target getcentroid();
    targetdirection = targetposition - turretposition;
    targetdistance = length(targetdirection);
    targetdirection /= targetdistance;
    targetleft = vectorcross((0, 0, 1), targetdirection);
    targetup = vectorcross(targetdirection, targetleft);
    var_d8b5bab86498e0a7 = randomfloatrange(0, 360);
    var_3e36f65cdc207066 = axistoangles(targetdirection, targetleft * -1, targetup);
    randomdirection = vectorNormalize((0, randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
    targetoffset = rotatevector(randomdirection, var_3e36f65cdc207066);

    switch (var_d2e7d6658b0a045a) {
      case #"hash_34770b8adabe2feb":
        assert(maxscaledistance);
        distancenormalized = clamp((targetdistance - minscaledistance) / maxscaledistance, 0, 1);
        minspread = math::lerp(var_433171aa24dce75e, var_cc3cb55a3ae27b6c, distancenormalized);
        maxspread = math::lerp(var_60fce4cc4f6acabc, var_35635307ee241aae, distancenormalized);
        var_c9b00e5616b7a312 = randomfloatrange(minspread, maxspread);
        targetpositionoffset = targetposition + targetoffset * var_c9b00e5616b7a312;
        break;
      case #"hash_c088e0bbec822829":
        timenormalized = clamp((end_time - gettime()) / burst_length, 0, 1);
        minspread = math::lerp(var_433171aa24dce75e, var_cc3cb55a3ae27b6c, timenormalized);
        maxspread = math::lerp(var_60fce4cc4f6acabc, var_35635307ee241aae, timenormalized);
        var_c9b00e5616b7a312 = randomfloatrange(minspread, maxspread);
        targetpositionoffset = targetposition + targetoffset * var_c9b00e5616b7a312;
        break;
      default:
        var_c9b00e5616b7a312 = randomfloatrange(var_433171aa24dce75e, var_60fce4cc4f6acabc);
        targetpositionoffset = targetposition + targetoffset * var_c9b00e5616b7a312;
        break;
    }

    var_d16fa005c2c5291d = getdvarint(@ "hash_a5451df7c00d0400", 0);

    if(var_d16fa005c2c5291d) {
      duration = 800;
      line(targetposition, targetposition + targetleft * 30, (1, 0, 0), 1, 0, duration);
      line(targetposition, targetposition + targetdirection * 30, (0, 1, 0), 1, 0, duration);
      line(targetposition, targetposition + targetup * 30, (0, 0, 1), 1, 0, duration);
      line(targetposition, targetpositionoffset, (1, 1, 0), 1, 0, duration);
      sphere(targetposition, minspread, (0.17, 1, 1), 0, duration);
      sphere(targetposition, maxspread, (0, 0, 1), 0, duration);
    }

    self.groundtargetent dontinterpolate();
    self.groundtargetent.origin = targetpositionoffset;
    self shootturret("tag_flash", 6);
    playFXOnTag(getfx("turret_muzflash"), self, "tag_flash");
    wait self.fire_delay;
  }

  self notify("turret_burst_complete");
}

function private function_f6c09d12e004b5ab(vehicle, current_target) {
  self endon("turret_burst_complete");

  while(true) {
    if(function_93ff5e5ba263fc6d(vehicle, current_target) < self.var_cc99a14e60508d29) {
      self notify("stop_turret_burst");
      return;
    }

    wait self.fire_delay;
  }
}

function function_9e96cdf67b925aa0(settings_bundle) {
  hasturret = default_to(settings_bundle.hasturret, 0);
  fire_range = default_to(settings_bundle.firerange, 2560);
  var_c8e4f9c808bc6727 = default_to(settings_bundle.var_1677a5799ea2d883, 45);
  fire_delay = default_to(settings_bundle.firedelay, 0.1);
  var_5e757e98f6d8d75d = default_to(settings_bundle.var_39457beebb58fd74, 12);
  var_5e528898f6b2a5a3 = default_to(settings_bundle.var_396869eebb7f1d96, 16);
  var_22724a721b4b206e = default_to(settings_bundle.var_f355db9e56c3e274, 2);
  var_224f3c721b24b9ec = default_to(settings_bundle.var_f378c99e56ea0296, 4);
  var_d2e7d6658b0a045a = default_to(settings_bundle.var_d2e7d6658b0a045a, "None");
  minscaledistance = default_to(settings_bundle.minscaledistance, 1500);
  maxscaledistance = default_to(settings_bundle.maxscaledistance, 4000);
  var_433171aa24dce75e = default_to(settings_bundle.var_433171aa24dce75e, 20);
  var_60fce4cc4f6acabc = default_to(settings_bundle.var_60fce4cc4f6acabc, 25);
  var_cc3cb55a3ae27b6c = default_to(settings_bundle.var_cc3cb55a3ae27b6c, 50);
  var_35635307ee241aae = default_to(settings_bundle.var_35635307ee241aae, 60);
  self.hasturret = hasturret;
  self.fire_range = fire_range;
  self.var_b115239d8d69db01 = fire_range;
  self.var_c8e4f9c808bc6727 = var_c8e4f9c808bc6727;
  self.var_cc99a14e60508d29 = cos(var_c8e4f9c808bc6727);
  self.fire_delay = fire_delay;
  self.var_a9b3f28f2a95607c = var_5e757e98f6d8d75d;
  self.var_a990e08f2a6ef12e = var_5e528898f6b2a5a3;
  self.var_d2e7d6658b0a045a = var_d2e7d6658b0a045a;
  self.var_22724a721b4b206e = var_22724a721b4b206e;
  self.var_224f3c721b24b9ec = var_224f3c721b24b9ec;
  self.minscaledistance = minscaledistance;
  self.maxscaledistance = maxscaledistance;
  self.var_433171aa24dce75e = var_433171aa24dce75e;
  self.var_60fce4cc4f6acabc = var_60fce4cc4f6acabc;
  self.var_cc3cb55a3ae27b6c = var_cc3cb55a3ae27b6c;
  self.var_35635307ee241aae = var_35635307ee241aae;
}

function function_bfab431f8bd39c4e(range) {
  self.fire_range = range;
}

function function_1b48b098cbce981() {
  self.fire_range = self.var_b115239d8d69db01;
}

function function_917a46654478df92() {
  self.turreton = 0;
}

function function_f50612d93c098113() {
  self.turreton = 1;
}

function function_de3fc172a25ca50b() {
  while(true) {
    var_22724a721b4b206e = getdvarfloat(@ "hash_26a1c7b26c4d5065", -1);

    if(var_22724a721b4b206e != -1 && self.var_22724a721b4b206e != var_22724a721b4b206e) {
      self.var_22724a721b4b206e = var_22724a721b4b206e;

      if(self.var_224f3c721b24b9ec < self.var_22724a721b4b206e) {
        setDvar(@ "hash_34f933a0fc55b25f", self.var_22724a721b4b206e + 1);
      }
    }

    var_224f3c721b24b9ec = getdvarfloat(@ "hash_34f933a0fc55b25f", -1);

    if(var_224f3c721b24b9ec != -1 && self.var_224f3c721b24b9ec != var_224f3c721b24b9ec && var_224f3c721b24b9ec > self.var_22724a721b4b206e) {
      self.var_224f3c721b24b9ec = var_224f3c721b24b9ec;
    }

    var_c8e4f9c808bc6727 = getdvarfloat(@ "hash_b59235a8286b8e3d", -1);

    if(var_c8e4f9c808bc6727 != -1 && self.var_c8e4f9c808bc6727 != var_c8e4f9c808bc6727) {
      self.var_c8e4f9c808bc6727 = var_c8e4f9c808bc6727;
      self.var_cc99a14e60508d29 = cos(var_c8e4f9c808bc6727);
    }

    waitframe();
  }
}

function private function_93ff5e5ba263fc6d(attacker, targ) {
  target_direction = targ.origin - attacker.origin;
  return vectordot2(target_direction, anglesToForward(attacker.angles), 1);
}