/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_36fcbbe3d561c895.gsc
*************************************************/

#using script_7b8639f512d4cfe4;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\samsite;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\teams;
#namespace namespace_ae057c3bf5e89076;

function function_b0154b5bd3ac71d5() {
  level.var_5c9a3961728ac52f = 1;
  level.var_2179c46fc54fd9ce = "offhand_2h_c4_prop_mp";
  namespace_82f05772526a4798::main();
  level.var_3f4534fb14cca909 = &function_151037a96443f076;
}

function spawn_samsite(var_f3a69ef1f5cbb40d) {
  turret = scripts\cp_mp\samsite::function_fefa23bed4e70fb2(var_f3a69ef1f5cbb40d, "military_samsite_01_rig_skeleton_ob", "iw9_tur_samsite_ob");
  function_f7c5fc38fdc4df8c(turret);
  turret.target_entity = spawn("script_model", turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 1000);
  turret settargetentity(turret.target_entity);
  turret setscriptablepartstate("usable_left", "usable");
  turret setscriptablepartstate("usable_front", "usable");
  turret setscriptablepartstate("usable_right", "usable");
  return turret;
}

function function_151037a96443f076(c4, samsite, player) {
  if(!istrue(c4.var_7b0e1793e94cafb4)) {
    samsite function_e70d07a164d078c2("plant");
    return false;
  }

  level notify("planted_bomb_on_sam_site");
  samsite.entity notify("samsite_bomb_planted");
  samsite.entity function_af9898234bbdbb22();
  samsite endon("samsite_cancel_bomb_countdown");
  samsite setscriptablepartstate("danger_indicator", "danger");
  currenttime = gettime();
  totaltime = 15000;
  bombendtime = int(currenttime + totaltime);
  var_c301d652d9a73075 = bombendtime - currenttime;
  samsite function_e70d07a164d078c2("defuse");

  while(var_c301d652d9a73075 > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;

    if(var_c301d652d9a73075 < 1500) {
      if(var_c301d652d9a73075 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          c4 playSound("breach_warning_beep_05");
        }
      } else if(var_c301d652d9a73075 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          c4 playSound("breach_warning_beep_04");
        }
      } else if(var_c301d652d9a73075 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          c4 playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_c301d652d9a73075 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        c4 playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var_c301d652d9a73075 < 0) {
      break;
    }
  }

  samsite notify("samsite_bomb_detonated");
  samsite.entity notify("samsite_bomb_detonated");
  samsite.entity thread scripts\cp_mp\samsite::sam_explode(player, "samsite_base_ob", "military_samsite_01_damaged_rig_skeleton_ob");
  earthquake(0.6, 0.7, samsite.origin, 1000);
  playrumbleonposition("grenade_rumble", samsite.origin);
  radiusdamage(samsite.origin, 256, 100, 50, undefined, "MOD_EXPLOSIVE");
  samsite setscriptablepartstate("danger_indicator", "safe");
  return true;
}

function function_e70d07a164d078c2(state) {
  turret = self;
  ent = function_fb532e39e9edebf5(turret);
  ent.var_f236a45969f96bb4 = state;

  if(state == "plant") {
    turret setscriptablepartstate("usable_left", "usable");
    turret setscriptablepartstate("usable_front", "usable");
    turret setscriptablepartstate("usable_right", "usable");
  } else {
    turret setscriptablepartstate("usable_left", "unusable");
    turret setscriptablepartstate("usable_front", "unusable");
    turret setscriptablepartstate("usable_right", "unusable");
  }

  turret setscriptablepartstate("usable_front", "unusable");
}

function function_fb532e39e9edebf5(turret) {
  if(is_equal(turret.classname, "misc_turret")) {
    return turret;
  }

  return turret.entity;
}

function function_f7c5fc38fdc4df8c(turret) {
  if(!isDefined(turret)) {
    return;
  }

  turret.missile1 = turret function_5970ddc4fd448e37(1);
  turret.missile2 = turret function_5970ddc4fd448e37(2);
  turret.missile3 = turret function_5970ddc4fd448e37(3);
}

function function_5970ddc4fd448e37(num) {
  missile = spawn("script_model", self gettagorigin("mg0" + num));
  missile setModel("military_missile_rig_skeleton");
  missile.angles = self gettagangles("mg0" + num);
  missile linkTo(self, "mg0" + num);
  return missile;
}

function function_44e4433ebac52609(target_location, target_ent) {
  self endon("death");
  self.target_entity.origin = target_location;
  missile = undefined;

  if(isDefined(self.missile1)) {
    missile = self.missile1;
    self.missile1 notify("launched");
    self.missile1 = undefined;
  } else if(isDefined(self.missile2)) {
    missile = self.missile2;
    self.missile2 notify("launched");
    self.missile2 = undefined;
  } else if(isDefined(self.missile3)) {
    missile = self.missile3;
    self.missile3 notify("launched");
    self.missile3 = undefined;
  }

  self setscriptablepartstate("launch", "on");

  if(!isDefined(missile)) {
    return;
  }

  missile unlink();
  missile.launched = 1;
  fakefireweapon = makeweapon("iw9_la_samsite_ob");
  magicbullet(fakefireweapon, missile.origin, missile.origin);
  playsoundatpos(missile.origin + (0, 30, 0), "weap_samsite_fire_npc");
  missile setscriptablepartstate("military_samsite_missile", "on");
  wait 0.5;
  earthquake(0.4, 1, missile.origin, 1200);
  thread function_553d6a4e19405e47(missile, target_ent);
  thread missile_watcher(missile, target_ent);
}

function function_553d6a4e19405e47(missile, target_ent) {
  self endon("death");
  missile endon("death");

  if(!isDefined(target_ent)) {
    return;
  }

  launch_time = gettime();
  var_fb8c2b90b2beb9c4 = vectorNormalize(missile.angles) * (0, 0, 600);
  rotating = 0;
  rotate_step = 0;
  var_2a449b1405c42b63 = 0;
  var_3a0916f1986edcdc = 0;
  var_c4f320df999cb4f5 = 0;

  while(true) {
    if(!isDefined(target_ent)) {
      return;
    }

    current_time = gettime();

    if(current_time - launch_time < 20) {
      dir = vectorNormalize(anglesToForward(missile.angles));
      missile.origin += dir * 175;
    } else {
      if(!is_equal(rotate_step, 3)) {
        if(is_equal(rotate_step, 0)) {
          rotating = 1;
          var_e8a5fecb73de77d4 = gettime();
          rotate_step = 1;
          var_2a449b1405c42b63 = gettime();
          missile rotateTo(vectortoangles(target_ent.origin - missile.origin), 0.25, 0, 0);
        } else if(is_equal(rotate_step, 1) && gettime() - var_2a449b1405c42b63 > 250) {
          rotate_step = 2;
          var_3a0916f1986edcdc = gettime();
          missile rotateTo(vectortoangles(target_ent.origin - missile.origin), 0.25, 0, 0);
        } else if(is_equal(rotate_step, 2) && gettime() - var_c4f320df999cb4f5 > 250) {
          rotate_step = 3;
          var_c4f320df999cb4f5 = gettime();
          missile rotateTo(vectortoangles(target_ent.origin - missile.origin), 0.25, 0, 0);
        }
      } else if(gettime() - var_e8a5fecb73de77d4 > 750) {
        missile.angles = vectortoangles(target_ent.origin - missile.origin);
      }

      dir = vectorNormalize(anglesToForward(missile.angles));
      missile.origin += dir * 175;
    }

    wait 0.05;
  }
}

function missile_watcher(missile, target_ent) {
  self endon("death");
  start_time = gettime();

  while(true) {
    if(!isDefined(target_ent)) {
      break;
    }

    dist = distancesquared(missile.origin, target_ent.origin);

    if(dist < 90000) {
      target_ent notify("sam_missile_explode");
      break;
    }

    if((gettime() - start_time) / 1000 > 15) {
      target_ent notify("sam_missile_explode");
      break;
    }

    wait 0.1;
  }

  if(isDefined(missile)) {
    missile delete();
  }
}

function function_f72a6146b33f7d1(markericon, instance_ref) {
  self.var_6434265aea7ab063 = objidpoolmanager::requestobjectiveid(0);
  waitframe();
  icon = default_to(markericon, "ui_map_icon_obj_sam_site");
  objidpoolmanager::objective_set_play_intro(self.var_6434265aea7ab063, 1);
  objidpoolmanager::objective_set_play_outro(self.var_6434265aea7ab063, 0);
  objidpoolmanager::objective_add_objective(self.var_6434265aea7ab063, "current");
  objidpoolmanager::update_objective_position(self.var_6434265aea7ab063, self.origin + (0, 0, 64));
  objidpoolmanager::update_objective_icon(self.var_6434265aea7ab063, icon);
  objidpoolmanager::objective_playermask_showtoall(self.var_6434265aea7ab063);
  objidpoolmanager::update_objective_setbackground(self.var_6434265aea7ab063, 1);

  if(isDefined(instance_ref)) {
    instance_ref.var_79c8996a40bba4ae = default_to(instance_ref.var_79c8996a40bba4ae, []);
    instance_ref.var_79c8996a40bba4ae = array_add(instance_ref.var_79c8996a40bba4ae, self.var_6434265aea7ab063);
  }

  return self.var_6434265aea7ab063;
}

function function_af9898234bbdbb22() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.var_6434265aea7ab063);
}