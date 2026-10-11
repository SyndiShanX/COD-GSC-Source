/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_489bc5ff08558a82.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\damagefeedback;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_1fcffdd06e4267a7;

function init() {
  if(!isDefined(level.sentrysettings)) {
    level.sentrysettings = [];
  }

  level.sentrysettings["auto_turret"] = spawnStruct();
  level.sentrysettings["auto_turret"].health = 999999;
  level.sentrysettings["auto_turret"].maxhealth = 300;
  level.sentrysettings["auto_turret"].burstmin = 20;
  level.sentrysettings["auto_turret"].burstmax = 40;
  level.sentrysettings["auto_turret"].pausemin = 0.15;
  level.sentrysettings["auto_turret"].pausemax = 0.25;
  level.sentrysettings["auto_turret"].sentrymodeon = "auto_nonai";
  level.sentrysettings["auto_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["auto_turret"].timeout = 90;
  level.sentrysettings["auto_turret"].spinuptime = 1;
  level.sentrysettings["auto_turret"].overheattime = 15;
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
  level.turretarray = getStructArray("turret_spawn_point", "script_noteworthy");
  level.floor_turrets_11 = [];
  flag_wait("strike_init_done");
  flag_wait("introscreen_over");
  flag_wait("infil_complete");

  foreach(index, struct in level.turretarray) {
    if(!isDefined(struct.script_label)) {
      continue;
    }

    if(isDefined(struct.script_label) && struct.script_label == "floor_11_defense") {
      continue;
    }

    struct.model = undefined;

    if(struct.script_label == "dd_proto" || struct.script_label == "turret_trigger") {
      struct.model = spawn("script_model", struct.origin);
    } else {
      struct.model = spawnturret("misc_turret", struct.origin, "sentry_minigun_mp");
    }

    if(isDefined(struct.angles)) {
      struct.model.angles = struct.angles;
    } else {
      struct.model.angles = (0, 270, 0);
    }

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
    struct.model setdefaultdroppitch(-75);
    struct.model.storedtarget = undefined;
    struct.model.health = 99999;
    struct.model.burstmin = 200;
    struct.model.burstmax = 800;
    struct.model.pausemin = 0.15;
    struct.model.pausemax = 0.25;
    struct.model.timeout = 90;
    struct.model.spinuptime = 1;
    struct.model.overheattime = 15;
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
        case #"hash_9d01334379510ffe":
        case #"hash_f849fc56d3b60038":
          break;
        default:
          break;
      }
    }
  }

  assignlevelstoturrets(level.bulletdrop.ignoreents);
}

function wait_for_sentry_acquire_target(turret) {
  turret endon("death");
  turret endon("carried");
  level endon("game_ended");
  turret.airlookatent = spawn_tag_origin(turret.origin, turret.angles);
  turret.airlookatent linkTo(turret, "tag_flash");

  while(true) {
    result = turret waittill_any_timeout_1(1, "turret_on_target");

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

function shocktarget(target) {
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

  while(isDefined(target) && target is_valid_player(target) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == target) {
    self shootturret();
    wait firetime;
  }

  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("done_firing");
}

function marktargetlaser(target) {
  self endon("death");
  self laseron();
  self.laser_on = 1;
  waittill_any_2("done_firing", "carried");
  self laseroff();
  self.laser_on = 0;
}

function sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

function sentry_spindown() {
  self.momentum = 0;
}

function assignlevelstoturrets(turrets) {
  array = sortbydistance(turrets, (-625, -821, 2326));

  for(i = 0; i < array.size; i++) {
    array[i].active_level = i + 1;
  }
}

function renderlasertargetting() {
  level endon("game_ended");

  while(true) {
    if(isDefined(self.trapactive) && self.trapactive) {
      startpos = self.model gettagorigin("tag_flash");
      endpos = startpos + anglesToForward(self.model.angles) * 400;
      playfxbetweenpoints(level._effect["vfx_laser_pointer"], startpos, vectortoangles(endpos - startpos), endpos);
    }

    wait 0.5;
  }
}

function isplayertargettedbyotherturrets(player) {
  foreach(turret in level.turretarray) {
    if(self == turret.model) {
      continue;
    }

    if(isDefined(turret.model.storedtarget) && turret.model.storedtarget == player) {
      return true;
    }
  }

  return false;
}

function detectplayersinvicinity() {
  self endon("delete_thread_since_player_not_on_my_floor");
  nplayerview = cos(75);

  while(!isDefined(level.players) || level.players.size < 1) {
    waitframe();
  }

  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1);

  while(true) {
    wait 0.1;
    playernear = scripts\cp\utility::give_closest_player_nearby(self.origin, 443556);
    eplayer = playernear;

    if(!isDefined(eplayer)) {
      if(isDefined(self.storedtarget)) {
        self.storedtarget = undefined;
        self notify("cleanup_target");
        self.suppressedturret = 1;
      }

      continue;
    }

    if(!isDefined(self.storedtarget)) {
      if(istrue(eplayer.inlaststand)) {
        continue;
      }

      if(isplayertargettedbyotherturrets(eplayer)) {
        continue;
      }

      self.suppressedturret = undefined;
      self.storedtarget = eplayer;
    }

    if(self.storedtarget == playernear) {
      if(istrue(self.suppressedturret)) {
        continue;
      }

      if(istrue(self.firingbullet)) {
        continue;
      }

      thread faceplayer();
    }

    if(self.storedtarget != eplayer) {
      if(istrue(self.suppressedturret)) {
        continue;
      }

      if(istrue(eplayer.inlaststand)) {
        continue;
      }

      self.storedtarget = eplayer;
      self.suppressedturret = undefined;
      thread faceplayer();
    }

    wait 0.3;
  }
}

function faceplayer() {
  self notify("one_instance_of_facePlayer");
  self endon("one_instance_of_facePlayer");
  self endon("delete_thread_since_player_not_on_my_floor");

  while(true) {
    if(!isDefined(self.storedtarget)) {
      waitframe();
      continue;
    }

    originalangles = self.angles;
    var_7896d923a061d043 = self.storedtarget.origin - self gettagorigin("tag_flash");
    var_66ce0e9199aa4b3f = vectortoangles(var_7896d923a061d043);
    rotatetoangles = anglelerpquat(originalangles, var_66ce0e9199aa4b3f, 360);
    self.angles = rotatetoangles;

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

function get_lookat_angles(camera, target, var_49ae7c7fe02b6a60) {
  originalangles = camera.angles;
  var_7896d923a061d043 = undefined;

  if(isDefined(var_49ae7c7fe02b6a60)) {
    var_7896d923a061d043 = target.origin - var_49ae7c7fe02b6a60;
  } else {
    var_7896d923a061d043 = target.origin - camera.origin;
  }

  var_66ce0e9199aa4b3f = vectortoangles(var_7896d923a061d043);
  rotatetoangles = anglelerpquat(originalangles, var_66ce0e9199aa4b3f, 360);
  return rotatetoangles;
}

function doidlemovement() {
  level endon("game_ended");
  self notify("one_instance_of_idlemovement");
  self endon("one_instance_of_idlemovement");

  if(!isDefined(self.model.angles)) {
    self.model.angles = (0, 0, 0);
  }

  idletarget = (0, 0, 0);

  while(true) {
    if(isDefined(self.storedtarget)) {
      waitframe();
      continue;
    }

    idletarget = ter_op(randomint(2) > 0, self.model.angles + (0, 45, 0), self.model.angles - (0, 45, 0));
    var_278f6f130d46fd99 = 1;
    self.model rotateTo(idletarget, 5);
    wait 5;
  }
}

function dodirectionalswivelmove() {
  level endon("game_ended");
  self notify("one_instance_of_swivelmovement");
  self endon("one_instance_of_swivelmovement");

  if(!isDefined(self.model.angles)) {
    self.model.angles = (0, 0, 0);
  }

  var_788da813bbc5ff = 0;
  var_3505be78c15f1300 = self.model.angles;
  var_21e3d2777900c004 = (0, 0, 0);
  var_5026931961bc3a5a = 1;
  var_63cb3409d8dcea3e = self.script_parameters == "vertical_swipe";

  while(true) {
    if(var_63cb3409d8dcea3e) {
      var_21e3d2777900c004 = var_3505be78c15f1300 + (45 * var_5026931961bc3a5a, 0, 0);
    } else {
      var_21e3d2777900c004 = var_3505be78c15f1300 + (0, 45 * var_5026931961bc3a5a, 0);
    }

    var_788da813bbc5ff = 1;
    self.model rotateTo(var_21e3d2777900c004, 5);
    var_5026931961bc3a5a *= -1;
    wait 5;
  }
}

function doswivelfiring() {
  while(true) {
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

function draw_lines_based_on_delay(delay, start, end) {
  counter = 0;

  while(counter < delay) {
    switch (counter) {
      case 0:
        line(start, end, (0, 0, 1), 1, 0, 3);
        break;
      case 1:
        line(start, end, (0, 1, 0), 1, 0, 3);
        break;
      case 2:
        line(start, end, (1, 0, 0), 1, 0, 3);
        break;
    }

    counter++;
    wait 1;
  }
}

function calculaterotationmatrixaroundx(var_1c36976f30623512, theta, var_3d0b3618ba9f1949, var_3d0b3518ba9f1716, onlyz) {
  x = vectordot(var_1c36976f30623512, (1, 0, 0));
  y = vectordot(var_1c36976f30623512, (0, 1, 0));
  z = vectordot(var_1c36976f30623512, (0, 0, 1));
  var_24b3f0bde46c805d = x;
  var_24b3efbde46c7e2a = y * cos(theta) - z * sin(theta);
  var_24b3eebde46c7bf7 = y * sin(theta) + z * cos(theta);

  if(istrue(var_3d0b3618ba9f1949)) {
    return (var_24b3f0bde46c805d, 0, 0);
  }

  if(istrue(var_3d0b3518ba9f1716)) {
    return (0, var_24b3efbde46c7e2a, 0);
  }

  if(istrue(onlyz)) {
    return (0, 0, var_24b3eebde46c7bf7);
  }

  return (var_24b3f0bde46c805d, var_24b3efbde46c7e2a, var_24b3eebde46c7bf7);
}

function calculaterotationmatrixaroundy(var_1c36976f30623512, theta, var_3d0b3618ba9f1949, var_3d0b3518ba9f1716, onlyz) {
  x = vectordot(var_1c36976f30623512, (1, 0, 0));
  y = vectordot(var_1c36976f30623512, (0, 1, 0));
  z = vectordot(var_1c36976f30623512, (0, 0, 1));
  var_24b3f0bde46c805d = x * cos(theta) + z * sin(theta);
  var_24b3efbde46c7e2a = y;
  var_24b3eebde46c7bf7 = -1 * x * sin(theta) + z * cos(theta);

  if(istrue(var_3d0b3618ba9f1949)) {
    return (var_24b3f0bde46c805d, 0, 0);
  }

  if(istrue(var_3d0b3518ba9f1716)) {
    return (0, var_24b3efbde46c7e2a, 0);
  }

  if(istrue(onlyz)) {
    return (0, 0, var_24b3eebde46c7bf7);
  }

  return (var_24b3f0bde46c805d, var_24b3efbde46c7e2a, var_24b3eebde46c7bf7);
}

function calculaterotationmatrixaroundz(var_1c36976f30623512, theta, var_3d0b3618ba9f1949, var_3d0b3518ba9f1716, onlyz) {
  x = vectordot(var_1c36976f30623512, (1, 0, 0));
  y = vectordot(var_1c36976f30623512, (0, 1, 0));
  z = vectordot(var_1c36976f30623512, (0, 0, 1));
  var_24b3f0bde46c805d = x * cos(theta) - y * sin(theta);
  var_24b3efbde46c7e2a = x * sin(theta) + y * cos(theta);
  var_24b3eebde46c7bf7 = z;

  if(istrue(var_3d0b3618ba9f1949)) {
    return (var_24b3f0bde46c805d, 0, 0);
  }

  if(istrue(var_3d0b3518ba9f1716)) {
    return (0, var_24b3efbde46c7e2a, 0);
  }

  if(istrue(onlyz)) {
    return (0, 0, var_24b3eebde46c7bf7);
  }

  return (var_24b3f0bde46c805d, var_24b3efbde46c7e2a, var_24b3eebde46c7bf7);
}

function fire_bullets_and_tracers(player) {
  origin = self gettagorigin("tag_flash") + (0, 0, 0);
  angles = self.angles;

  if(self.firetype == "fusion_rifle") {
    thread firebulletTrace(origin, angles, 50000, player);
    return;
  }

  thread firebullet(origin, angles, 1500, 200);
}

function createbullet(origin, angles) {
  bullet = spawn("script_model", origin);
  bullet setModel("ui_bullet_armor_piercing");
  bullet.angles = angles;
  bullet hide();
  bullet.vfxtag = spawn_tag_origin(bullet.origin, bullet.angles);
  bullet.vfxtag linkTo(bullet);
  bullet thread delaybulletvfx();
  bullet thread delaybulletshow();
  return bullet;
}

function delaybulletvfx() {
  self endon("entitydeleted");
  self.vfxtag endon("entitydeleted");

  if(true) {
    wait 0.079;
  }
}

function delaybulletshow() {
  self endon("entitydeleted");

  if(true) {
    wait 0.1;
  }

  self show();
}

function watchforsuppressiondelete(model) {
  self endon("death");
  model waittill("stop_fire_due_to_suppression");
  iprintln(" ^5 TURRET FIRE STOPPED!! ");
}

function firebulletTrace(origin, angles, dist, player) {
  player dodamage(50, player.origin, undefined, undefined, "MOD_UNKNOWN");
  player iprintlnbold("^1Taking turret damage!");
  wait 0.5;
  self.firingbullet = undefined;
}

function firebullet(origin, angles, dist, var_dc1ab01f03316243) {
  worldup = (0, 0, 1);
  v0 = anglesToForward(angles) * var_dc1ab01f03316243;
  a = (0, 0, 0) + (0, 0, 0);
  max_t = 0;
  max_t = dist / var_dc1ab01f03316243;
  t = 0;
  r = origin;

  if(!isDefined(level.bullets)) {
    level.bullets = [];
  }

  bullet = createbullet(origin, angles);
  level.bullets[level.bullets.size] = bullet;
  bullet thread watchforsuppressiondelete(self);
  var_e6ad177ff55e26c1 = [];
  var_fba2e3ad41033620 = 0;
  var_242a6d26cfa4f8ff = 0.2;

  while(t < max_t && !istrue(var_fba2e3ad41033620)) {
    old_r = r;
    r = origin + v0 * t + 0.5 * a * squared(t);
    forward = vectorNormalize(r - old_r);
    var_9cd84d753a49efac = distance(r, old_r);
    bullet.origin = r;
    contents = create_contents(1, 1, 1, 1, 1, 1);
    ignoreents = array_merge(level.bulletdrop.ignoreents, var_e6ad177ff55e26c1);
    var_8a592fbfa1086de3 = ray_trace(old_r, r, ignoreents, contents, 0, 1);
    traces = [var_8a592fbfa1086de3];

    if(self.firetype == "doom_proj") {
      color = ter_op(var_fba2e3ad41033620, (1, 1, 0), (1, 0, 0));
    }

    impactposition = undefined;
    impactnormal = undefined;
    var_fbfe68887f79d14c = undefined;

    foreach(trace in traces) {
      if(trace["fraction"] < 1) {
        if(isDefined(trace["entity"])) {
          ignoreents = array_add(ignoreents, trace["entity"]);
        }

        impactposition = trace["position"];
        impactnormal = trace["normal"];
        var_fbfe68887f79d14c = trace["entity"];
        break;
      }
    }

    if(isDefined(impactposition)) {
      if(!var_fba2e3ad41033620) {
        level notify("ballisticBulletImpact", impactposition);
        r = old_r;
        var_fba2e3ad41033620 = 1;
      }

      if(isDefined(var_fbfe68887f79d14c)) {
        var_fbfe68887f79d14c notify("ballisticBulletDamage", impactposition);
        thread impactvfxentitylogic(var_fbfe68887f79d14c, impactposition, impactnormal);

        if(istrue(var_fbfe68887f79d14c.ballisticdontpenetrate)) {
          break;
        }
      } else {
        playFX(level._effect["vfx_bullet_impact"], impactposition + forward * 0.5, impactnormal);
        physicsexplosionsphere(impactposition, 128, 128, 75);
        self radiusdamage(impactposition, 250, 66, 30, undefined, "MOD_EXPLOSIVE");
      }
    }

    if(self.firetype == "fusion_rifle") {
      t += 1;
    } else {
      t += 0.05;
    }

    wait 0.05;
  }

  self.firingbullet = undefined;
  bullet delaythread(0.05, &deletebullet);
}

function impactvfxentitylogic(var_fbfe68887f79d14c, position, normal) {
  physicsexplosionsphere(position, 128, 128, 75);
  forward = normal;
  position += forward * 0.5;
  worldup = (0, 0, 1);
  right = vectorcross(forward, worldup);
  down = vectorcross(forward, right);
  up = down * -1;
  angles = axistoangles(forward, right, up);
  vfxtag = spawn_tag_origin(position, angles);
  playFXOnTag(level._effect["vfx_bullet_impact"], vfxtag, "tag_origin");
  thread impactvfxentityparentlogic(var_fbfe68887f79d14c, vfxtag);
  var_fbfe68887f79d14c endon("death");
  var_fbfe68887f79d14c endon("entitydeleted");
  wait 3;
  killfxontag(level._effect["vfx_bullet_impact"], vfxtag, "tag_origin");
  vfxtag delete();
}

function impactvfxentityparentlogic(var_fbfe68887f79d14c, vfxtag) {
  vfxtag endon("death");
  vfxtag endon("entitydeleted");
  var_fbfe68887f79d14c waittill_any_2("death", "entitydeleted");
  killfxontag(level._effect["vfx_bullet_impact"], vfxtag, "tag_origin");
  vfxtag delete();
}

function deletebullet() {
  level.bullets = array_remove(level.bullets, self);

  if(!isDefined(self)) {
    return;
  }

  self.vfxtag delete();
  self delete();
}

function isenemyinfrontofme(enemy, var_3b37ca6ec4d56e75) {
  dir = vectorNormalize((enemy.origin - self.origin) * (1, 1, 0));
  dir = vectorNormalize((enemy.origin - self gettagorigin("tag_flash")) * (1, 1, 0));
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);

  if(!isDefined(var_3b37ca6ec4d56e75)) {
    return (dot > 0);
  }

  return dot > var_3b37ca6ec4d56e75;
}

function isenemyrightofme(enemy, ang_offset) {
  dir = vectorNormalize((enemy.origin - self gettagorigin("tag_flash")) * (1, 1, 0));
  right = vectorNormalize(anglestoright(self.angles));
  dot = vectordot(dir, right);
  var_f25f65666bab9bcd = ter_op(dot > 0, right, right * -1);
  var_d8bd7d9a61d3c70a = vectortoangles(var_f25f65666bab9bcd);
  return dot > 0;
}

function detectplayerdamage() {
  self.health = 666;
  self.maxhealth = 666;

  while(true) {
    self waittill("damage", dmg, attacker, dir, point, type);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(istrue(self.suppressedturret)) {
      continue;
    }

    if(self.health - dmg <= 0) {
      self.health += dmg;
    }

    self notify("stop_fire_due_to_suppression");
    self.suppressedturret = 1;
    attacker thread scripts\cp\damagefeedback::updatedamagefeedback("hitturret", undefined, dmg, 1);
    thread removesuppressioneffectsaftertimeout(5);
  }
}

function removesuppressioneffectsaftertimeout(timeout) {
  wait timeout;
  self.suppressedturret = undefined;
}