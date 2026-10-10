/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\samsite.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace samsite;

function function_4390cfb8004a4e9c(turret) {
  turret endon("death");
  turret.target_entity = spawn("script_model", turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 750);
  leftpos = anglestoleft(turret.angles) * 500;
  rightpos = anglestoright(turret.angles) * 500;
  turret settargetentity(turret.target_entity);
  turret.target_entity moveTo(turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 750 + rightpos, 5);
  turret setscriptablepartstate("audio", "rotate_start");
  wait 5;
  turret setscriptablepartstate("audio", "rotate_stop");
  pos = "right";

  while(true) {
    wait 1;
    turret thread function_44e4433ebac52609();
    wait 10;
    turret thread function_44e4433ebac52609();
    wait 10;
    turret thread function_44e4433ebac52609();
    wait 5;
    function_f7c5fc38fdc4df8c(turret);
    wait 1;

    if(pos == "right") {
      turret.target_entity moveTo(turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 1000 + leftpos, 5);
      pos = "left";
    } else if(pos == "left") {
      turret.target_entity moveTo(turret.origin + (0, 0, 750) + anglesToForward(turret.angles) * 1000 + rightpos, 5);
      pos = "right";
    }

    turret setscriptablepartstate("audio", "rotate_start");
    wait 5;
    turret setscriptablepartstate("audio", "rotate_stop");
  }
}

function function_fefa23bed4e70fb2(struct, model, turretweapon) {
  if(!isDefined(turretweapon)) {
    turretweapon = "iw9_tur_samsite_cp";
  }

  turret = spawnturret("misc_turret", struct.origin, turretweapon);

  if(!isDefined(struct.angles)) {
    struct.angles = (0, 0, 0);
  }

  turret.angles = struct.angles;

  if(!isDefined(model)) {
    model = "military_samsite_01_rig_skeleton";
  }

  turret.team = "axis";
  turret setModel(model);
  turret settoparc(75);
  turret setbottomarc(0);
  turret setleftarc(360);
  turret setrightarc(360);
  turret makeunusable();
  turret setscriptablepartstate("rocket1", "hidden");
  turret setscriptablepartstate("rocket2", "hidden");
  turret setscriptablepartstate("rocket3", "hidden");

  if(utility::iscp() || getDvar(@ "ui_gametype", "") == "wm" || getDvar(@ "ui_gametype", "") == "ob") {
    turret setscriptablepartstate("usable_left", "usable");
    turret setscriptablepartstate("usable_right", "usable");
    turret setscriptablepartstate("usable_front", "usable");
  } else {
    useent = spawn("script_model", turret.origin + (0, 0, 40));
    useent setModel("tag_origin");
    useent thread function_d8ca43a821bdfe1a();
    turret.useent = useent;
  }

  return turret;
}

function function_f7c5fc38fdc4df8c(turret, sam_modelname) {
  if(!isDefined(turret)) {
    return;
  }

  turret.missile1 = turret function_5970ddc4fd448e37(1, sam_modelname);
  turret.missile2 = turret function_5970ddc4fd448e37(2, sam_modelname);
  turret.missile3 = turret function_5970ddc4fd448e37(3, sam_modelname);
}

function function_5970ddc4fd448e37(num, sam_modelname) {
  missile = spawn("script_model", self gettagorigin("mg0" + num));

  if(isDefined(sam_modelname)) {
    missile setModel(sam_modelname);
  } else {
    missile setModel("military_missile_rig_skeleton");
  }

  missile.angles = self gettagangles("mg0" + num);
  missile linkTo(self, "mg0" + num);
  missile thread function_e6142ecc1a9ce89(self);
  return missile;
}

function function_44e4433ebac52609(istest) {
  self endon("death");
  missile = undefined;

  if(isDefined(self.missile1)) {
    missile = self.missile1;
    self.missile1 notify("launched");
    self.missile1 = undefined;

    if(!self isnearanyplayer(5000) || istrue(istest)) {
      self.missile1 = function_5970ddc4fd448e37(1);
    }
  } else if(isDefined(self.missile2)) {
    missile = self.missile2;
    self.missile2 notify("launched");
    self.missile2 = undefined;

    if(!self isnearanyplayer(5000) || istrue(istest)) {
      self.missile2 = function_5970ddc4fd448e37(2);
    }
  } else if(isDefined(self.missile3)) {
    missile = self.missile3;
    self.missile3 notify("launched");
    self.missile3 = undefined;

    if(!self isnearanyplayer(5000) || istrue(istest)) {
      self.missile3 = function_5970ddc4fd448e37(3);
    } else {
      delaythread(5, &function_ad922931d55b782b);
    }
  }

  self setscriptablepartstate("launch", "on");

  if(!isDefined(missile)) {
    return;
  }

  self.var_da525e753988f579 = missile;
  missile.launched = 1;
  fakefireweapon = makeweapon("iw9_la_samsite_cp");
  magicbullet(fakefireweapon, missile.origin, missile.origin);

  if(scripts\cp_mp\utility\game_utility::getgametype() == "wm") {
    playsoundatpos(missile.origin + (0, 30, 0), "jup_samsite_fire_npc");
  } else {
    playsoundatpos(missile.origin + (0, 30, 0), "weap_samsite_fire_npc");
  }

  missile setscriptablepartstate("military_samsite_missile", "on");
  missile unlink();
  wait 0.5;
  earthquake(0.4, 1, missile.origin, 1200);
  missile moveTo(missile.origin + anglesToForward(missile.angles) * 40000, 15);
  wait 15;

  if(isDefined(missile)) {
    missile delete();
  }
}

function sam_spawn(struct) {
  turret = function_fefa23bed4e70fb2(struct);
  function_f7c5fc38fdc4df8c(turret);
  turret.target_entity = spawn("script_model", turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 1000);
  leftpos = anglestoleft(turret.angles) * 1000;
  rightpos = anglestoright(turret.angles) * 1000;
  turret settargetentity(turret.target_entity);
  turret thread function_fc364b4fcc0d2051();
  return turret;
}

function sam_idle() {
  self endon("launching");
  self endon("death");
  idle_points = function_37cc51487b6e95dc(self.origin + (0, 0, 800), 12, 512);
  startingpoint = getclosest(self.target_entity.origin, idle_points);
  var_741f5a182dd662c0 = 0;
  thread function_2add68d4c86e555b();

  while(true) {
    foreach(point in idle_points) {
      if(startingpoint != point && !var_741f5a182dd662c0) {
        continue;
      } else if(!var_741f5a182dd662c0) {
        var_741f5a182dd662c0 = 1;
        continue;
      }

      self.target_entity moveTo(point.origin, 5);
      wait 5;
    }

    waitframe();
  }
}

function function_71cf043af949590c() {
  idle_points = function_37cc51487b6e95dc(self.origin + (0, 0, 800), 12, 512);
  startingpoint = getclosest(self.target_entity.origin, idle_points);
  var_741f5a182dd662c0 = 0;
  thread function_2add68d4c86e555b();
  count = 0;

  foreach(point in idle_points) {
    if(startingpoint != point && !var_741f5a182dd662c0) {
      continue;
    }

    self.target_entity moveTo(point.origin, 1.5);
    wait 1.5;
    count++;

    if(count > 2) {
      break;
    }
  }

  self notify("launching");
  wait 1.5;
}

function function_2add68d4c86e555b() {
  self endon("death");
  self setscriptablepartstate("audio", "rotate_start");
  self waittill("launching");
  self setscriptablepartstate("audio", "rotate_stop");
}

function function_37cc51487b6e95dc(point, num_positions, path_radius) {
  degs_per_pos = 360 / num_positions;
  positions = [];
  fwd = (1, 0, 0);
  i = 0;

  while(i < 360) {
    altforward = fwd * path_radius;
    rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
    pos = point + rotated_forward;
    position = spawnStruct();
    position.origin = pos;
    positions[positions.size] = position;
    i += degs_per_pos;
  }

  return positions;
}

function function_e6142ecc1a9ce89(sam_site) {
  self endon("death");
  self.health = 999999;
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self.dmgtaken = 0;
  self.var_59a09303493e759d = 750;
  self.var_689d46e1e37cc5ad = &function_a00baa7c74f5f04d;
  attacker = undefined;

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon);

    if(!isPlayer(attacker) || !isexplosivedamagemod(meansofdeath) && meansofdeath != "MOD_IMPACT") {
      if(isPlayer(attacker) && isbulletdamage(meansofdeath)) {
        if(issharedfuncdefined("damage", "updateDamageFeedback")) {
          var_f56fb412974c87c8 = getsharedfunc("damage", "updateDamageFeedback");
          attacker thread[[var_f56fb412974c87c8]]("hitnobulletdamage");
        }
      }

      self.health += amount;
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      self.health += amount;
      continue;
    }

    if(isDefined(objweapon) && objweapon.basename == "c4_mp") {
      amount = 350;
    }

    self.dmgtaken += amount;

    if(self.dmgtaken > self.var_59a09303493e759d) {
      break;
    }
  }

  self.health = 0;
  playFX(level._effect["c4_explosion_convoy"], self.origin);
  earthquake(0.35, 1, self.origin, 1024);
  org = self.origin;

  if(isDefined(self)) {
    self delete();
  }

  radiusdamage(org, 350, 300, 300, attacker, "MOD_EXPLOSIVE");
}

function function_fc364b4fcc0d2051(sam_site) {
  self endon("stop_dmgmonitor");
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self.dmgtaken = 0;
  self.var_59a09303493e759d = 750;
  self.var_689d46e1e37cc5ad = &function_a00baa7c74f5f04d;
  attacker = undefined;
  self.health = 9999999;

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon);

    if(isDefined(objweapon) && (objweapon.basename == "c4_mp" || objweapon.basename == "c4_cp_noproj")) {
      amount = 1000;
    } else if(!isPlayer(attacker) || !isexplosivedamagemod(meansofdeath) && meansofdeath != "MOD_IMPACT") {
      if(isPlayer(attacker) && isbulletdamage(meansofdeath)) {
        if(issharedfuncdefined("damage", "updateDamageFeedback")) {
          var_f56fb412974c87c8 = getsharedfunc("damage", "updateDamageFeedback");
          attacker thread[[var_f56fb412974c87c8]]("hitnobulletdamage");
        }
      }

      self.health += amount;
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      self.health += amount;
      continue;
    }

    if(isDefined(objweapon)) {
      weaponrootname = getweaponrootstring(objweapon);

      switch (weaponrootname) {
        case #"hash_fa1e80f6bd5b8e72":
          amount = 755;
          break;
        case #"hash_5d11ac1131cddab1":
        case #"hash_607145e68712971c":
        case #"hash_7c03088193266bc4":
        case #"hash_c9a436974fe60919":
        case #"hash_d2d2f2854b7d8b7d":
        case #"hash_ff28a6c5cf8f547f":
          amount = int(225);
          break;
        case #"hash_326dc2026394652a":
        case #"hash_572e39c5466a5575":
          amount = 380;
          break;
      }
    }

    self.health += amount;

    if(isbulletdamage(meansofdeath)) {
      amount = min(10, amount);
    }

    self.dmgtaken += amount;

    if(self.dmgtaken > self.var_59a09303493e759d) {
      break;
    }
  }

  if(issharedfuncdefined("challenges", "destroySamSiteNoPlant")) {
    [[getsharedfunc("challenges", "destroySamSiteNoPlant")]](level.script, objweapon, attacker);
  }

  sam_explode(attacker);
}

function sam_explode(attacker, part, var_a69a18b6e859e6b4) {
  if(!isDefined(part)) {
    part = "base";
  }

  self.health = 0;
  self setscriptablepartstate(part, "destroyed");
  thread play_loopsound_in_space("dst_sam_site_fire_lp", self.origin);
  radiusdamage(self.origin, 350, 300, 85);

  if(isDefined(self.missile1) && !istrue(self.missile1.launched)) {
    if(isDefined(level._effect["c4_explosion_convoy"])) {
      playFX(level._effect["c4_explosion_convoy"], self.missile1.origin);
    }

    self.missile1 hide();
  }

  if(isDefined(self.missile2) && !istrue(self.missile2.launched)) {
    if(isDefined(level._effect["c4_explosion_convoy"])) {
      playFX(level._effect["c4_explosion_convoy"], self.missile2.origin);
    }

    self.missile2 hide();
  }

  if(isDefined(self.missile3) && !istrue(self.missile3.launched)) {
    if(isDefined(level._effect["c4_explosion_convoy"])) {
      playFX(level._effect["c4_explosion_convoy"], self.missile3.origin);
    }

    self.missile3 hide();
  }

  if(isDefined(self.soundent)) {
    self.soundent delete();
  }

  if(isDefined(self.useent)) {
    self.useent delete();
  }

  destroyed_model = spawn("script_model", self.origin);
  destroyed_model.angles = self.angles;

  if(isDefined(var_a69a18b6e859e6b4)) {
    destroyed_model setModel(var_a69a18b6e859e6b4);
  } else {
    destroyed_model setModel("military_samsite_01_damaged_rig_skeleton");
  }

  destroyed_model setscriptablepartstate("base", "destroyed");

  if(istrue(level.var_82e220e37dee38e)) {
    destroyed_model.dmgtrig = spawn("trigger_radius", self.origin, 0, 96, 512);
    destroyed_model.dmgtrig.targetname = "sam_dmg";
    destroyed_model.dmgtrig thread function_bc293ec7591c985();
  }

  if(!isDefined(level.var_f7f6cf2225966394)) {
    level.var_f7f6cf2225966394 = [];
  }

  level.var_f7f6cf2225966394[level.var_f7f6cf2225966394.size] = destroyed_model;
  level notify("samsite_destroyed", attacker);
  self notify("samsite_dead", attacker);
  wait 10;

  if(isDefined(self)) {
    self delete();
  }
}

function function_bc293ec7591c985() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("trigger", ent);

    if(isPlayer(ent)) {
      thread sam_playerdamage(ent);
    }
  }
}

function sam_playerdamage(player) {
  player endon("disconnect");

  if(!istrue(player.onfire)) {
    player.onfire = 1;
    player dodamage(45, player.origin, undefined, undefined, "MOD_TRIGGER_HURT");
    wait 0.5;
    player.onfire = 0;
  }
}

function function_e864db8a259b11d0() {
  if(istrue(self.var_2551d467a1f595b3)) {
    return;
  }

  self.var_2551d467a1f595b3 = 1;
  self thread[[level.showerrormessagefunc]]("MP/EXPLOSVE_DAMAGE_ONLY");
  wait 3;
  self.var_2551d467a1f595b3 = undefined;
}

function function_a00baa7c74f5f04d(idamage) {
  if(idamage + self.dmgtaken > self.var_59a09303493e759d) {
    return true;
  }

  return false;
}

function function_ad922931d55b782b() {
  self endon("death");

  while(self isnearanyplayer(5000)) {
    wait 1;
  }

  function_f7c5fc38fdc4df8c(self);
}

function function_d8ca43a821bdfe1a() {
  self makeusable();
  self endon("death");
  function_3e95edbf2a19f0a1();
  player = undefined;

  while(true) {
    self waittill("trigger", player);

    if(!player isvalidplayer()) {
      continue;
    }

    break;
  }

  player giveandfireoffhand("c4_mp");
  self makeunusable();
  wait 5;

  if(isDefined(self)) {
    self delete();
  }
}

function function_7647015ee3137876() {
  if(!isDefined(level.scr_animtree["samsite"])) {
    if(utility::iscp()) {
      function_14c8eb2e0b67d409();
    } else {
      function_3c11327e37345bb2();
    }
  }

  self.animname = "samsite";
  self useanimtree(level.scr_animtree["samsite"]);
  scripts\common\anim::anim_single([self], "fire");
}

#using_animtree("script_model");

function function_3c11327e37345bb2() {
  level.scr_animtree["samsite"] = #animtree;
  level.scr_anim["samsite"]["fire"] = level.br_anim["iw9_mp_prop_samsite_launch"];
}

function function_14c8eb2e0b67d409() {
  level.scr_animtree["samsite"] = #animtree;
  level.scr_anim["samsite"]["fire"] = % iw9_mp_prop_samsite_launch;
}

function isvalidplayer() {
  if(!isPlayer(self)) {
    return false;
  }

  if(!isDefined(self)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self.sessionstate == "spectator") {
    return false;
  }

  return true;
}

function function_3e95edbf2a19f0a1() {
  self setHintString(&"CP_MISSION_ESC/PLANT_CHARGE");
  self sethinticon("hud_icon_c4_plant");
  self sethintdisplayrange(512);
  self setuserange(150);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayfov(65);
  self sethintonobstruction("show");
  self sethintrequiresholding(1);
  self setuseholdduration("duration_short");
}