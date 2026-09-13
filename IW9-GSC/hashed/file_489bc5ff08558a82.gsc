/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_489bc5ff08558a82.gsc
***********************************************/

init() {
  if(!isDefined(level.sentrysettings))
    level.sentrysettings = [];

  level.sentrysettings["auto_turret"] = spawnStruct();
  level.sentrysettings["auto_turret"].health = 999999;
  level.sentrysettings["auto_turret"].maxhealth = 300;
  level.sentrysettings["auto_turret"].burstmin = 20;
  level.sentrysettings["auto_turret"].burstmax = 40;
  level.sentrysettings["auto_turret"].pausemin = 0.15;
  level.sentrysettings["auto_turret"].pausemax = 0.25;
  level.sentrysettings["auto_turret"].sentrymodeon = "auto_nonai";
  level.sentrysettings["auto_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["auto_turret"].timeout = 90.0;
  level.sentrysettings["auto_turret"].spinuptime = 1.0;
  level.sentrysettings["auto_turret"].overheattime = 15.0;
  level.sentrysettings["auto_turret"].cooldowntime = 0.2;
  level.sentrysettings["auto_turret"].fxtime = 0.3;
  level.sentrysettings["auto_turret"].weaponinfo = "sentry_minigun_mp";
  level.sentrysettings["auto_turret"].modelbase = "veh8_mil_air_ahotel64_turret_wm_cp";
  level.sentrysettings["auto_turret"].modelplacement = "veh8_mil_air_ahotel64_turret_wm_cp";
  level.sentrysettings["auto_turret"].hintstring = &"COOP_CRAFTABLES/PICKUP";
  level.sentrysettings["auto_turret"].headicon = 1;
  level.sentrysettings["auto_turret"].vodestroyed = "sentry_destroyed";
  level.sentrysettings["auto_turret"].issentient = 0;
  level.bulletdrop = spawnStruct();
  level.bulletdrop.wind = (0, 0, 0);
  level.bulletdrop.ignoreents = [];
  level.turretarray = scripts\engine\utility::getStructArray("turret_spawn_point", "script_noteworthy");
  level.floor_turrets_11 = [];
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");

  foreach(index, struct in level.turretarray) {
    if(!isDefined(struct.script_label)) {
      continue;
    }
    if(isDefined(struct.script_label) && struct.script_label == "floor_11_defense") {
      continue;
    }
    struct.model = undefined;

    if(struct.script_label == "dd_proto" || struct.script_label == "turret_trigger")
      struct.model = spawn("script_model", struct.origin);
    else
      struct.model = spawnturret("misc_turret", struct.origin, "sentry_minigun_mp");

    if(isDefined(struct.angles))
      struct.model.angles = struct.angles;
    else
      struct.model.angles = (0, 270, 0);

    struct.model setModel("veh8_mil_air_ahotel64_turret_wm_cp");

    if(struct.script_label == "turret_trigger") {
      struct.model setCanDamage(1);
      struct.model thread detectplayerdamage();
      struct.model.firetype = "doom_proj";
      continue;
    }

    if(struct.script_label == "dd_proto") {
      struct.model setCanDamage(1);
      struct.model thread detectplayerdamage();
      struct.model.firetype = "doom_proj";
      struct.model thread detectplayersinvicinity();
      continue;
    }

    struct.model.sentrytype = "auto_turret";
    struct.model.muzzlepoint = struct.model gettagorigin("tag_aim_pivot");
    struct.model maketurretinoperable();
    struct.model setmode("sentry");
    struct.model setsentryowner(level.players[0]);
    struct.model setturretteam("axis");
    struct.model setleftarc(180);
    struct.model setrightarc(180);
    struct.model setbottomarc(135);
    struct.model settoparc(135);
    struct.model setconvergencetime(0.3, "pitch");
    struct.model setconvergencetime(0.3, "yaw");
    struct.model setconvergenceheightpercent(0.65);
    struct.model setdefaultdroppitch(-75.0);
    struct.model.storedtarget = undefined;
    struct.model.health = 99999;
    struct.model.burstmin = 200;
    struct.model.burstmax = 800;
    struct.model.pausemin = 0.15;
    struct.model.pausemax = 0.25;
    struct.model.timeout = 90.0;
    struct.model.spinuptime = 1.0;
    struct.model.overheattime = 15.0;
    struct.model.cooldowntime = 0.2;
    struct.model.fxtime = 0.3;
    struct.name = "turret_" + index;
    struct.model laseron();
    struct.model.name = "turret_" + index;
    struct.model.firetype = "doom_proj";
    struct.model.momentum = 0;
    struct.model.heatlevel = 0;
    struct.model.overheated = 0;
    struct.model thread wait_for_sentry_acquire_target(struct.model);
    level.bulletdrop.ignoreents[level.bulletdrop.ignoreents.size] = struct.model;

    if(isDefined(struct.script_label)) {
      if(struct.script_label == "floor_12_defense") {
        level.twelfthfloorturret = struct;
        struct.model.firetype = "fusion_rifle";
      } else if(struct.script_label == "floor_11_defense") {
        struct.model setCanDamage(1);
        level.floor_turrets_11[level.floor_turrets_11.size] = struct;
        struct.model thread detectplayerdamage();
        struct.model.firetype = "doom_proj";
      }
    }

    level.bulletdrop.ignoreents[level.bulletdrop.ignoreents.size] = struct.model;

    if(isDefined(struct.script_parameters)) {
      switch (struct.script_parameters) {
        case "vertical_swipe":
        case "horizontal_swipe":
          break;
        default:
      }

      continue;
    }
  }

  assignlevelstoturrets(level.bulletdrop.ignoreents);
}

wait_for_sentry_acquire_target(turret) {
  turret endon("death");
  turret endon("carried");
  level endon("game_ended");
  turret.airlookatent = scripts\engine\utility::spawn_tag_origin(turret.origin, turret.angles);
  turret.airlookatent linkTo(turret, "tag_flash");

  for(;;) {
    result = turret scripts\engine\utility::waittill_any_timeout_1(1, "turret_on_target");

    if(result == "timeout") {
      continue;
    }
    turret.sentryshocktargetent = turret getturrettarget(1);

    if(isDefined(turret.sentryshocktargetent) && turret.sentryshocktargetent scripts\cp_mp\utility\player_utility::_isalive()) {
      turret thread shocktarget(turret.sentryshocktargetent);
      turret waittill("done_firing");
    }
  }
}

shocktarget(target) {
  self endon("death");
  self endon("carried");

  if(!isDefined(target)) {
    return;
  }
  thread marktargetlaser(target);
  self playSound("shock_sentry_charge_up");
  sentry_spinup();
  self notify("start_firing");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);

  while(isDefined(target) && target scripts\cp\utility::is_valid_player(target) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == target) {
    self shootturret();
    wait(firetime);
  }

  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("done_firing");
}

marktargetlaser(target) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::waittill_any_2("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

sentry_spindown() {
  self.momentum = 0;
}

assignlevelstoturrets(turrets) {
  array = sortbydistance(turrets, (-625, -821, 2326));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    array[_id_AC0E594AC96AA3A8].active_level = _id_AC0E594AC96AA3A8 + 1;
}

renderlasertargetting() {
  level endon("game_ended");

  for(;;) {
    if(isDefined(self.trapactive) && self.trapactive) {
      startpos = self.model gettagorigin("tag_flash");
      endpos = startpos + anglesToForward(self.model.angles) * 400;
      playfxbetweenpoints(level._effect["vfx_laser_pointer"], startpos, vectortoangles(endpos - startpos), endpos);
    }

    wait 0.5;
  }
}

isplayertargettedbyotherturrets(player) {
  foreach(turret in level.turretarray) {
    if(self == turret.model) {
      continue;
    }
    if(isDefined(turret.model.storedtarget) && turret.model.storedtarget == player)
      return 1;
  }

  return 0;
}

detectplayersinvicinity() {
  self endon("delete_thread_since_player_not_on_my_floor");
  _id_AAE9B1C541E97449 = cos(75);

  while(!isDefined(level.players) || level.players.size < 1)
    waitframe();

  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1);

  for(;;) {
    wait 0.1;
    _id_49BE45F83BE0135E = scripts\cp\utility::give_closest_player_nearby(self.origin, 443556);
    _id_678A0776298909D1 = _id_49BE45F83BE0135E;

    if(!isDefined(_id_678A0776298909D1)) {
      if(isDefined(self.storedtarget)) {
        self.storedtarget = undefined;
        self notify("cleanup_target");
        self.suppressedturret = 1;
      }

      continue;
    }

    if(!isDefined(self.storedtarget)) {
      if(istrue(_id_678A0776298909D1.inlaststand)) {
        continue;
      }
      if(isplayertargettedbyotherturrets(_id_678A0776298909D1)) {
        continue;
      }
      self.suppressedturret = undefined;
      self.storedtarget = _id_678A0776298909D1;
    }

    if(self.storedtarget == _id_49BE45F83BE0135E) {
      if(istrue(self.suppressedturret)) {
        continue;
      }
      if(istrue(self.firingbullet)) {
        continue;
      }
      thread faceplayer();
    }

    if(self.storedtarget != _id_678A0776298909D1) {
      if(istrue(self.suppressedturret)) {
        continue;
      }
      if(istrue(_id_678A0776298909D1.inlaststand)) {
        continue;
      }
      self.storedtarget = _id_678A0776298909D1;
      self.suppressedturret = undefined;
      thread faceplayer();
    }

    wait 0.3;
  }
}

faceplayer() {
  self notify("one_instance_of_facePlayer");
  self endon("one_instance_of_facePlayer");
  self endon("delete_thread_since_player_not_on_my_floor");

  for(;;) {
    if(!isDefined(self.storedtarget)) {
      waitframe();
      continue;
    }

    originalangles = self.angles;
    _id_7896D923A061D043 = self.storedtarget.origin - self gettagorigin("tag_flash");
    _id_66CE0E9199AA4B3F = vectortoangles(_id_7896D923A061D043);
    _id_6F60BBBC177C23EB = anglelerpquat(originalangles, _id_66CE0E9199AA4B3F, 360);
    self.angles = _id_6F60BBBC177C23EB;

    if(istrue(self.suppressedturret)) {
      waitframe();
      continue;
    }

    if(istrue(self.firingbullet)) {
      waitframe();
      continue;
    }

    if(istrue(self.storedtarget.inlaststand)) {
      waitframe();
      continue;
    }

    self.firingbullet = 1;
    fire_bullets_and_tracers(self.storedtarget);
    waitframe();
  }
}

get_lookat_angles(camera, target, _id_49AE7C7FE02B6A60) {
  originalangles = camera.angles;
  _id_7896D923A061D043 = undefined;

  if(isDefined(_id_49AE7C7FE02B6A60))
    _id_7896D923A061D043 = target.origin - _id_49AE7C7FE02B6A60;
  else
    _id_7896D923A061D043 = target.origin - camera.origin;

  _id_66CE0E9199AA4B3F = vectortoangles(_id_7896D923A061D043);
  _id_6F60BBBC177C23EB = anglelerpquat(originalangles, _id_66CE0E9199AA4B3F, 360);
  return _id_6F60BBBC177C23EB;
}

doidlemovement() {
  level endon("game_ended");
  self notify("one_instance_of_idlemovement");
  self endon("one_instance_of_idlemovement");

  if(!isDefined(self.model.angles))
    self.model.angles = (0, 0, 0);

  _id_87177C53DEE5138A = (0, 0, 0);

  for(;;) {
    if(isDefined(self.storedtarget)) {
      waitframe();
      continue;
    }

    _id_87177C53DEE5138A = scripts\engine\utility::ter_op(randomint(2) > 0, self.model.angles + (0, 45, 0), self.model.angles - (0, 45, 0));
    _id_278F6F130D46FD99 = 1;
    self.model rotateTo(_id_87177C53DEE5138A, 5);
    wait 5;
  }
}

dodirectionalswivelmove() {
  level endon("game_ended");
  self notify("one_instance_of_swivelmovement");
  self endon("one_instance_of_swivelmovement");

  if(!isDefined(self.model.angles))
    self.model.angles = (0, 0, 0);

  _id_00788DA813BBC5FF = 0;
  _id_3505BE78C15F1300 = self.model.angles;
  _id_21E3D2777900C004 = (0, 0, 0);
  _id_5026931961BC3A5A = 1;
  _id_63CB3409D8DCEA3E = self.script_parameters == "vertical_swipe";

  for(;;) {
    if(_id_63CB3409D8DCEA3E)
      _id_21E3D2777900C004 = _id_3505BE78C15F1300 + (45 * _id_5026931961BC3A5A, 0, 0);
    else
      _id_21E3D2777900C004 = _id_3505BE78C15F1300 + (0, 45 * _id_5026931961BC3A5A, 0);

    _id_00788DA813BBC5FF = 1;
    self.model rotateTo(_id_21E3D2777900C004, 5);
    _id_5026931961BC3A5A = _id_5026931961BC3A5A * -1;
    wait 5;
  }
}

doswivelfiring() {
  for(;;) {
    if(istrue(self.model.suppressedturret)) {
      waitframe();
      continue;
    }

    if(istrue(self.model.firingbullet)) {
      waitframe();
      continue;
    }

    self.model.firingbullet = 1;
    origin = self.model gettagorigin("tag_flash") + (0, 0, 0);
    angles = self.model.angles;
    self.model thread firebullet(origin, angles, 1500, 200);
    wait 1;
  }
}

draw_lines_based_on_delay(delay, start, end) {
  counter = 0;

  while(counter < delay) {
    switch (counter) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }

    counter++;
    wait 1;
  }
}

calculaterotationmatrixaroundx(_id_1C36976F30623512, _id_F157E2C858DD6237, _id_3D0B3618BA9F1949, _id_3D0B3518BA9F1716, _id_3D0B3418BA9F14E3) {
  x = vectordot(_id_1C36976F30623512, (1, 0, 0));
  y = vectordot(_id_1C36976F30623512, (0, 1, 0));
  z = vectordot(_id_1C36976F30623512, (0, 0, 1));
  _id_24B3F0BDE46C805D = x;
  _id_24B3EFBDE46C7E2A = y * cos(_id_F157E2C858DD6237) - z * sin(_id_F157E2C858DD6237);
  _id_24B3EEBDE46C7BF7 = y * sin(_id_F157E2C858DD6237) + z * cos(_id_F157E2C858DD6237);

  if(istrue(_id_3D0B3618BA9F1949))
    return (_id_24B3F0BDE46C805D, 0, 0);

  if(istrue(_id_3D0B3518BA9F1716))
    return (0, _id_24B3EFBDE46C7E2A, 0);

  if(istrue(_id_3D0B3418BA9F14E3))
    return (0, 0, _id_24B3EEBDE46C7BF7);

  return (_id_24B3F0BDE46C805D, _id_24B3EFBDE46C7E2A, _id_24B3EEBDE46C7BF7);
}

calculaterotationmatrixaroundy(_id_1C36976F30623512, _id_F157E2C858DD6237, _id_3D0B3618BA9F1949, _id_3D0B3518BA9F1716, _id_3D0B3418BA9F14E3) {
  x = vectordot(_id_1C36976F30623512, (1, 0, 0));
  y = vectordot(_id_1C36976F30623512, (0, 1, 0));
  z = vectordot(_id_1C36976F30623512, (0, 0, 1));
  _id_24B3F0BDE46C805D = x * cos(_id_F157E2C858DD6237) + z * sin(_id_F157E2C858DD6237);
  _id_24B3EFBDE46C7E2A = y;
  _id_24B3EEBDE46C7BF7 = -1 * x * sin(_id_F157E2C858DD6237) + z * cos(_id_F157E2C858DD6237);

  if(istrue(_id_3D0B3618BA9F1949))
    return (_id_24B3F0BDE46C805D, 0, 0);

  if(istrue(_id_3D0B3518BA9F1716))
    return (0, _id_24B3EFBDE46C7E2A, 0);

  if(istrue(_id_3D0B3418BA9F14E3))
    return (0, 0, _id_24B3EEBDE46C7BF7);

  return (_id_24B3F0BDE46C805D, _id_24B3EFBDE46C7E2A, _id_24B3EEBDE46C7BF7);
}

calculaterotationmatrixaroundz(_id_1C36976F30623512, _id_F157E2C858DD6237, _id_3D0B3618BA9F1949, _id_3D0B3518BA9F1716, _id_3D0B3418BA9F14E3) {
  x = vectordot(_id_1C36976F30623512, (1, 0, 0));
  y = vectordot(_id_1C36976F30623512, (0, 1, 0));
  z = vectordot(_id_1C36976F30623512, (0, 0, 1));
  _id_24B3F0BDE46C805D = x * cos(_id_F157E2C858DD6237) - y * sin(_id_F157E2C858DD6237);
  _id_24B3EFBDE46C7E2A = x * sin(_id_F157E2C858DD6237) + y * cos(_id_F157E2C858DD6237);
  _id_24B3EEBDE46C7BF7 = z;

  if(istrue(_id_3D0B3618BA9F1949))
    return (_id_24B3F0BDE46C805D, 0, 0);

  if(istrue(_id_3D0B3518BA9F1716))
    return (0, _id_24B3EFBDE46C7E2A, 0);

  if(istrue(_id_3D0B3418BA9F14E3))
    return (0, 0, _id_24B3EEBDE46C7BF7);

  return (_id_24B3F0BDE46C805D, _id_24B3EFBDE46C7E2A, _id_24B3EEBDE46C7BF7);
}

fire_bullets_and_tracers(player) {
  origin = self gettagorigin("tag_flash") + (0, 0, 0);
  angles = self.angles;

  if(self.firetype == "fusion_rifle")
    thread firebulletTrace(origin, angles, 50000, player);
  else
    thread firebullet(origin, angles, 1500, 200);
}

createbullet(origin, angles) {
  bullet = spawn("script_model", origin);
  bullet setModel("ui_bullet_armor_piercing");
  bullet.angles = angles;
  bullet hide();
  bullet.vfxtag = scripts\engine\utility::spawn_tag_origin(bullet.origin, bullet.angles);
  bullet.vfxtag linkTo(bullet);
  bullet thread delaybulletvfx();
  bullet thread delaybulletshow();
  return bullet;
}

delaybulletvfx() {
  self endon("entitydeleted");
  self.vfxtag endon("entitydeleted");

  if(0.079)
    wait 0.079;
}

delaybulletshow() {
  self endon("entitydeleted");

  if(0.1)
    wait 0.1;

  self show();
}

watchforsuppressiondelete(model) {
  self endon("death");
  model waittill("stop_fire_due_to_suppression");
  iprintln(" ^5 TURRET FIRE STOPPED!! ");
}

firebulletTrace(origin, angles, dist, player) {
  player dodamage(50, player.origin, undefined, undefined, "MOD_UNKNOWN");
  player iprintlnbold("^1Taking turret damage!");
  wait 0.5;
  self.firingbullet = undefined;
}

firebullet(origin, angles, dist, _id_DC1AB01F03316243) {
  _id_303D9FA226476812 = (0, 0, 1);
  _id_CDE77178F5341B4F = anglesToForward(angles) * _id_DC1AB01F03316243;
  a = (0, 0, 0);
  _id_6EB9BC0310CB1B7E = 0;
  _id_6EB9BC0310CB1B7E = dist / _id_DC1AB01F03316243;
  t = 0;
  r = origin;

  if(!isDefined(level.bullets))
    level.bullets = [];

  bullet = createbullet(origin, angles);
  level.bullets[level.bullets.size] = bullet;
  bullet thread watchforsuppressiondelete(self);
  _id_E6AD177FF55E26C1 = [];
  _id_FBA2E3AD41033620 = 0;
  _id_242A6D26CFA4F8FF = 0.2;

  while(t < _id_6EB9BC0310CB1B7E && !istrue(_id_FBA2E3AD41033620)) {
    _id_3C9070482D1F3BDF = r;
    r = origin + _id_CDE77178F5341B4F * t + 0.5 * a * squared(t);
    forward = vectorNormalize(r - _id_3C9070482D1F3BDF);
    _id_9CD84D753A49EFAC = distance(r, _id_3C9070482D1F3BDF);
    bullet.origin = r;
    contents = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1);
    ignoreents = scripts\cp\utility::array_merge(level.bulletdrop.ignoreents, _id_E6AD177FF55E26C1);
    _id_8A592FBFA1086DE3 = scripts\engine\trace::ray_trace(_id_3C9070482D1F3BDF, r, ignoreents, contents, 0, 1);
    traces = [_id_8A592FBFA1086DE3];

    if(self.firetype == "doom_proj")
      color = scripts\engine\utility::ter_op(_id_FBA2E3AD41033620, (1, 1, 0), (1, 0, 0));

    _id_5F6EFFB5FFEB0640 = undefined;
    _id_DA984FE90CC9723C = undefined;
    _id_FBFE68887F79D14C = undefined;

    foreach(trace in traces) {
      if(trace["fraction"] < 1) {
        if(isDefined(trace["entity"]))
          ignoreents = scripts\engine\utility::array_add(ignoreents, trace["entity"]);

        _id_5F6EFFB5FFEB0640 = trace["position"];
        _id_DA984FE90CC9723C = trace["normal"];
        _id_FBFE68887F79D14C = trace["entity"];
        break;
      }
    }

    if(isDefined(_id_5F6EFFB5FFEB0640)) {
      if(!_id_FBA2E3AD41033620) {
        level notify("ballisticBulletImpact", _id_5F6EFFB5FFEB0640);
        r = _id_3C9070482D1F3BDF;
        _id_FBA2E3AD41033620 = 1;
      }

      if(isDefined(_id_FBFE68887F79D14C)) {
        _id_FBFE68887F79D14C notify("ballisticBulletDamage", _id_5F6EFFB5FFEB0640);
        thread impactvfxentitylogic(_id_FBFE68887F79D14C, _id_5F6EFFB5FFEB0640, _id_DA984FE90CC9723C);

        if(istrue(_id_FBFE68887F79D14C.ballisticdontpenetrate)) {
          break;
        }
      } else {
        playFX(level._effect["vfx_bullet_impact"], _id_5F6EFFB5FFEB0640 + forward * 0.5, _id_DA984FE90CC9723C);
        physicsexplosionsphere(_id_5F6EFFB5FFEB0640, 128, 128, 75);
        self radiusdamage(_id_5F6EFFB5FFEB0640, 250, 66, 30, undefined, "MOD_EXPLOSIVE");
      }
    }

    if(self.firetype == "fusion_rifle")
      t = t + 1;
    else
      t = t + 0.05;

    wait 0.05;
  }

  self.firingbullet = undefined;
  bullet scripts\engine\utility::delaythread(0.05, ::deletebullet);
}

impactvfxentitylogic(_id_FBFE68887F79D14C, position, normal) {
  physicsexplosionsphere(position, 128, 128, 75);
  forward = normal;
  position = position + forward * 0.5;
  _id_303D9FA226476812 = (0, 0, 1);
  right = vectorcross(forward, _id_303D9FA226476812);
  down = vectorcross(forward, right);
  up = down * -1;
  angles = axistoangles(forward, right, up);
  vfxtag = scripts\engine\utility::spawn_tag_origin(position, angles);
  playFXOnTag(level._effect["vfx_bullet_impact"], vfxtag, "tag_origin");
  thread impactvfxentityparentlogic(_id_FBFE68887F79D14C, vfxtag);
  _id_FBFE68887F79D14C endon("death");
  _id_FBFE68887F79D14C endon("entitydeleted");
  wait 3.0;
  killfxontag(level._effect["vfx_bullet_impact"], vfxtag, "tag_origin");
  vfxtag delete();
}

impactvfxentityparentlogic(_id_FBFE68887F79D14C, vfxtag) {
  vfxtag endon("death");
  vfxtag endon("entitydeleted");
  _id_FBFE68887F79D14C scripts\engine\utility::waittill_any_2("death", "entitydeleted");
  killfxontag(level._effect["vfx_bullet_impact"], vfxtag, "tag_origin");
  vfxtag delete();
}

deletebullet() {
  level.bullets = scripts\engine\utility::array_remove(level.bullets, self);

  if(!isDefined(self)) {
    return;
  }
  self.vfxtag delete();
  self delete();
}

isenemyinfrontofme(enemy, _id_3B37CA6EC4D56E75) {
  dir = vectorNormalize((enemy.origin - self.origin) * (1, 1, 0));
  dir = vectorNormalize((enemy.origin - self gettagorigin("tag_flash")) * (1, 1, 0));
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);

  if(!isDefined(_id_3B37CA6EC4D56E75))
    return dot > 0;

  return dot > _id_3B37CA6EC4D56E75;
}

isenemyrightofme(enemy, _id_7595128B0DFBCB5B) {
  dir = vectorNormalize((enemy.origin - self gettagorigin("tag_flash")) * (1, 1, 0));
  right = vectorNormalize(anglestoright(self.angles));
  dot = vectordot(dir, right);
  _id_F25F65666BAB9BCD = scripts\engine\utility::ter_op(dot > 0, right, right * -1);
  _id_D8BD7D9A61D3C70A = vectortoangles(_id_F25F65666BAB9BCD);
  return dot > 0;
}

detectplayerdamage() {
  self.health = 666;
  self.maxhealth = 666;

  for(;;) {
    self waittill("damage", dmg, attacker, dir, point, type);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(istrue(self.suppressedturret)) {
      continue;
    }
    if(self.health - dmg <= 0)
      self.health = self.health + dmg;

    self notify("stop_fire_due_to_suppression");
    self.suppressedturret = 1;
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitturret", undefined, dmg, 1);
    thread removesuppressioneffectsaftertimeout(5);
  }
}

removesuppressioneffectsaftertimeout(timeout) {
  wait(timeout);
  self.suppressedturret = undefined;
}