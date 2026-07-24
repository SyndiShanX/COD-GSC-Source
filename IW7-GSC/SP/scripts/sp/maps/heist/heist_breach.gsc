/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_breach.gsc
**************************************************/

_id_10BBD() {
  scripts\sp\maps\heist\heist_util::_id_968E();
  scripts\sp\maps\heist\heist_util::_id_9686();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  var_0 = getEnt("door_upper_deck", "targetname");
  var_0.clip = getEnt("upper_deck_clip", "targetname");
  var_0.clip linkTo(var_0);
  var_0 movez(-130, 0.05);
  thread scripts\sp\maps\heist\heist_util::_id_FD33("breach");
  scripts\sp\utility::_id_F5AF("start_mons_breach", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
  scripts\engine\utility::flag_set("close_deck_door");
  var_1 = getEntArray("mons_gundeck_door", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, scripts\sp\lights::_id_AB83, 0, 0.05);
}

_id_B194() {
  _id_9684();

  while(level.allies.size < 4)
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_2669("breach_scene");
  level._id_2F8B = scripts\engine\utility::getStruct("scene_mons_breach", "targetname");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_F3E6(0);

    if(var_1 == level._id_EA2C || var_1 == level._id_30F6) {
      var_1 scripts\sp\utility::_id_51E1("cqb");
      var_1.moveplaybackrate = 1.2;
    } else
      var_1 scripts\sp\utility::_id_51E1("combat");

    level._id_2F8B scripts\engine\utility::delaythread(1, ::_id_D7ED, var_1);
  }

  waitforalltransients();
  thread _id_5412();
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_E505 hide();
  level._id_2F8B scripts\sp\anim::_id_1EC3(level.player._id_E505, "plant_breach");
  scripts\engine\utility::flag_wait("breach_ready");
  setmusicstate("");
  var_3 = scripts\sp\utility::_id_10639("charge", (0, 0, 0), (0, 0, 0));
  var_3 hide();
  level._id_2F8B scripts\sp\anim::_id_1EE0(var_3, "plant_breach");
  var_3 show();
  var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  var_3 thread scripts\sp\utility::_id_918B("ar_callouts_breachcharge", 0, (0, 0, 0));
  var_3 _id_0E46::_id_48C4(undefined, (0, 0, 0), "", undefined, 10000, 128, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_3 waittill("trigger");
  var_3 _id_0E46::_id_DFE3();
  level.player _meth_8562();
  scripts\engine\utility::flag_set("disable_autosaves");

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  level notify("breach_started");
  scripts\engine\utility::flag_set("breach_started");
  level.player playSound("scn_heist_breach_plant");
  thread _id_5834();
  setsaveddvar("r_mbEnable", 2);
  scripts\sp\maps\heist\heist_util::_id_5569();
  level.player disableweaponpickup();
  var_5 = 0.45;

  if(length(level.player getvelocity()) > 200)
    var_5 = 0.25;

  level.player setvelocity((0, 0, 0));
  level.player _meth_823C(level.player._id_E505, "tag_player", var_5, var_5 * 0.5, 0);
  level.player scripts\engine\utility::delaycall(var_5, ::playerlinktodelta, level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  thread _id_2F81();
  level._id_F113 = 0;
  level._id_F14F = 0;
  wait(var_5);
  level.player._id_E505 show();
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);
  scripts\engine\utility::delaythread(3.65, scripts\sp\maps\heist\heist_util::_id_CD1B, scripts\engine\utility::getfx("vfx_exp_breach_start"), var_6, "tag_origin");
  scripts\engine\utility::delaythread(3.65, scripts\sp\maps\heist\heist_util::_id_CD1B, scripts\engine\utility::getfx("vfx_exp_breach_piston"), var_6, "tag_origin");
  level._id_2F8B thread scripts\sp\anim::_id_1F2C([level.player._id_E505, level._id_EA2C, level._id_30F6], "plant_breach");
  var_3 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_918C);
  var_3 scripts\engine\utility::delaycall(0.55, ::delete);
  var_7 = scripts\sp\utility::_id_10639("charge", var_4.origin, var_4.angles);
  var_7 scripts\engine\utility::delaythread(3.65, scripts\engine\utility::play_loop_sound_on_entity, "breach_cut_lp");
  level._id_2F8B scripts\sp\anim::_id_1F35(var_7, "plant_breach");
  level.player._id_E505 hide();
  thread _id_2F98(var_7, var_4, var_6);
  wait 0.45;
  var_8 = level.player scripts\engine\utility::spawn_tag_origin();
  var_8 thread scripts\sp\utility::play_sound_on_entity("slomo_whoosh_heist");
  scripts\sp\utility::_id_10326(1);
  scripts\sp\utility::_id_10327(0.5);
  scripts\sp\utility::_id_10324(1);
  scripts\sp\utility::_id_10321();
  wait 0.5;
  thread _id_2F52();
  soundsettimescalefactor("foley_npc_mvmt_unres_3d_lim", 0.25);
  scripts\sp\utility::_id_22CA("breach_seeker_thrower", ::_id_2F8D);
  scripts\sp\utility::_id_22CD("breach_seeker_thrower", 1);
  var_9 = scripts\sp\vehicle::_id_1080E("seeker_breacher_spawner");
  level._id_2F8E = var_9;
  scripts\engine\utility::array_thread(var_9, ::_id_F162);
  thread _id_2F7C();
  thread _id_2F56();
  wait 1.1;
  level.player scripts\sp\utility::_id_D2CD(25, 0.05);
  var_9 = scripts\engine\utility::array_removeundefined(var_9);
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_13753, var_9);
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "seeker_breach_player_grabbed");
  scripts\sp\utility::_id_57D6();
  level notify("breach_over");
  var_8 delete();
  level.player thread scripts\sp\utility::play_sound_on_entity("slomo_whoosh_heist_end");
  scripts\sp\utility::_id_10325(0.5);
  scripts\sp\utility::_id_10322();
  level.player scripts\sp\utility::_id_D2CA(0.05);

  while(isDefined(level._id_2F7E))
    scripts\engine\utility::waitframe();

  if(level._id_2F8E.size == 0) {
    var_10 = getaiarray("axis");

    foreach(var_12 in var_10) {
      if(isDefined(var_12._id_B14F))
        var_12 scripts\sp\utility::_id_1101B();

      var_12 scripts\sp\utility::_id_54C6();
    }
  }

  thread _id_CF4F();
  _id_583B(4);
  setsaveddvar("r_mbEnable", 0);
  level._id_2F8B notify("stop_pre_breach_loop");
  scripts\engine\utility::array_thread(level.allies, ::_id_1CD0, level._id_2F8B);
  wait 0.5;

  if(isalive(level.player)) {
    level.player unlink();
    level.player._id_E505 delete();
    level.player _meth_80DB();
    level.player allowmovement(1);
    scripts\sp\maps\heist\heist_util::_id_6229();
  }

  foreach(var_1 in level.allies) {
    var_1.moveplaybackrate = 1.0;
    var_1 scripts\sp\utility::_id_51E1("combat");
  }

  scripts\engine\utility::flag_set("mons_breach_end");
  scripts\engine\utility::flag_clear("disable_autosaves");
}

_id_2F98(var_0, var_1, var_2) {
  wait 0.45;
  level._id_C475 show();
  level._id_C475._id_1389B connectpaths();
  level._id_C475._id_1389B delete();
  var_3 = scripts\engine\utility::getStruct("breach_explosion", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_3.angles = var_3.angles + (0, 180, 0);
  playFXOnTag(scripts\engine\utility::getfx("breach_explosion"), var_3, "tag_origin");
  screenshake(var_3.origin, 1.2, 1.2, 1.2, 0.15, 0, 0.125, 1000, 8, 8, 8);
  var_1 thread scripts\sp\utility::play_sound_on_entity("frag_grenade_explode");
  killfxontag(scripts\engine\utility::getfx("vfx_exp_breach_start"), var_2, "tag_origin");
  killfxontag(scripts\engine\utility::getfx("vfx_exp_breach_piston"), var_2, "tag_origin");
  var_0 delete();
  var_1 delete();
  level waittill("breach_over");
  var_3 delete();
}

_id_2F81() {
  level.player allowmovement(0);
  level.player _meth_84AF(1);
  wait 4.5;
  level.player enableweapons();
  level.player scripts\sp\utility::_id_F526("safe");
  wait 2;
  level.player lerpviewangleclamp(0.25, 0, 0, 30, 55, 45, 45);
  level.player freezecontrols(0);
  level.player scripts\sp\utility::_id_F526("normal");
}

_id_2F7C() {
  level.player _meth_80CB(1);
  scripts\sp\utility::_id_13753(level._id_2F8E);
  level.player _meth_80CB(0);
}

#using_animtree("seeker");

_id_F162() {
  self _meth_83D0(#animtree);
  self makevehiclenotcollidewithplayers(1);
  self setCanDamage(1);
  self.health = 25;
  thread _id_F12E();
  thread _id_F133();
  thread _id_F132();
  thread _id_F134();
  scripts\sp\utility::_id_9196(1, 0, 1);

  if(!isDefined(level._id_F15E))
    level._id_F15E = 0;
  else
    level._id_F15E = level._id_F15E + randomfloatrange(0.15, 0.25);

  scripts\engine\utility::delaythread(level._id_F15E, scripts\engine\utility::play_loop_sound_on_entity, "seeker_target_acquire_lp");
  var_0 = 0.25;

  if(self.script_index == 3)
    var_0 = var_0 + 0.15;

  scripts\engine\utility::delaythread(var_0, scripts\sp\vehicle_paths::_id_845A);
  playFXOnTag(level._id_7649["seeker_axis"], self, "tag_fx");
  self waittill("death");

  if(!isDefined(level._id_2F7D)) {
    playFX(level._id_7649["seeker_sparks"], self.origin);
    playFX(level._id_7649["seeker_explosion"], self.origin);
    earthquake(0.25, 0.25, self.origin, 5000);
    playworldsound("seeker_explode", self.origin);
    level.player playRumbleOnEntity("damage_heavy");
  }

  level._id_2F8E = scripts\engine\utility::array_remove(level._id_2F8E, self);
  self delete();
}

_id_F132() {
  self endon("death");
  self _meth_82A2(%equip_seeker_walk_forward);
  self waittill("jump");
  playFXOnTag(level._id_7649["seeker_thruster"], self, "tag_origin");
  self clearanim(%equip_seeker_walk_forward, 0.05);
  self _meth_82A2(%equip_seeker_traverse_jumpup);

  while(distance(self.origin, level.player.origin) > 135)
    wait 0.05;

  self clearanim(%equip_seeker_traverse_jumpup, 0.05);
  self _meth_82A2(%equip_seeker_traverse_jumpdown, 1, 0.25);
}

_id_F12E() {
  self endon("death");
  self endon("stop_fov_damage_watcher");
  var_0 = cos(3);

  for(;;) {
    var_1 = self.health;
    level.player waittill("weapon_fired");

    if(self.health - var_1) {
      continue;
    }
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_0)) {
      continue;
    }
    playFX(level._id_7649["seeker_sparks"], self.origin);

    if(isDefined(self._id_5957)) {
      continue;
    }
    var_2 = level.player getcurrentweapon();
    var_3 = distance(level.player getEye(), self.origin);
    var_4 = weapongetdamagemax(var_2);
    var_5 = weapongetdamagemin(var_2);
    var_6 = weaponmaxdist(var_2);
    var_7 = var_6 / var_3;
    var_8 = var_4 * var_7;

    if(var_8 > var_4)
      var_8 = var_4;
    else if(var_8 < var_5)
      var_8 = var_5;

    var_9 = self.health - var_8;

    if(var_9 <= 0)
      self notify("death");

    self.health = var_9;
  }
}

_id_2F8D() {
  var_0 = self.spawner;
  var_0 thread scripts\sp\anim::_id_1ECB(self, var_0.animation);
  self.health = 50;
  scripts\sp\utility::_id_F2A8(1);
  self setCanDamage(1);
}

_id_F133() {
  self endon("death");

  for(;;) {
    wait 0.05;

    if(distance(level.player.origin, self.origin) > 56) {
      continue;
    }
    break;
  }

  if(level._id_F113) {
    radiusdamage(level.player.origin, 1, 50, 100);
    level._id_F14F++;

    if(level._id_F14F == _id_F12F()) {
      if(isDefined(level._id_2F7E)) {
        var_0 = level._id_2F7E;
        level._id_2F7E = undefined;
        var_0 _id_0E26::_id_E084();
      }

      level.player scripts\sp\utility::_id_54C6();
      wait 0.2;
      _id_0B60::_id_F32D("SCRIPT_SEEKER_DEATH");
      scripts\sp\utility::_id_B8D1();
      level waittill("forever");
    }

    self notify("death");
    return;
  }

  level._id_F113 = 1;
  level._id_2F7D = self;
  level notify("seeker_breach_player_grabbed");
  var_1 = getspawner("actor_ally_equipment_seeker", "classname");
  var_1.origin = level.player.origin;
  var_0 = _id_0E26::_id_107D2(level.player.origin, level.player.angles, "axis", level.player, 1);
  level._id_2F7E = var_0;
  var_0._id_B5DA = 1;
  var_0 scripts\sp\utility::_id_B14F(1);
  var_0 thread _id_F128();
  self notify("death");
}

_id_F12F() {
  var_0 = scripts\sp\utility::_id_7E72();

  switch (var_0) {
    case "easy":
      return 9999;
    case "medium":
      return 3;
    case "hard":
      return 2;
    case "fu":
      return 1;
  }
}

_id_F134() {
  self endon("death");

  while(level._id_2F8E.size != 1)
    wait 0.05;

  while(distance(level.player.origin, self.origin) > 150)
    wait 0.05;

  level notify("seeker_breach_player_grabbed");
  self vehicle_setspeedimmediate(25, 25);

  foreach(var_1 in getaiarray("axis")) {
    if(!isDefined(var_1._id_B14F))
      var_1 scripts\sp\utility::_id_B14F();
  }

  self._id_5957 = 1;
  self setCanDamage(0);
}

_id_F128() {
  self waittill("seeker_detonate_finish", var_0);

  if(isDefined(var_0) && distance2d(var_0, level.player.origin) < 64) {
    level.player scripts\sp\utility::_id_54C6();
    wait 0.2;
    _id_0B60::_id_F32D("SCRIPT_SEEKER_DEATH");
    scripts\sp\utility::_id_B8D1();
    return;
  }

  level.player unlink();
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_B14F))
      var_3 scripts\sp\utility::_id_1101B();

    radiusdamage(var_3.origin, 75, 9999, 9999, undefined, "MOD_EXPLOSIVE");
  }
}

_id_2F56() {
  level endon("breach_over");

  for(;;) {
    wait(randomfloatrange(0.05, 0.15));

    if(!level._id_2F8E.size) {
      return;
    }
    var_0 = scripts\engine\utility::random(level._id_2F8E);
    var_1 = scripts\engine\utility::random(level.allies);
    var_2 = level.player.origin + (0, 0, 56);
    var_3 = anglestoright(level.player.angles);

    if(scripts\engine\utility::cointoss())
      var_3 = var_3 * -1;

    var_2 = var_2 + var_3 * randomintrange(10, 30);
    bullettracer(var_2, var_0.origin, var_1.weapon, 1);
    var_1 shootblank();
  }
}

_id_1C20() {
  level endon("fake_seekers_dead");
  var_0 = randomfloatrange(0.3, 0.5);
  var_1 = 2;
  var_2 = [];

  foreach(var_4 in level.allies)
  var_2 = scripts\engine\utility::add_to_array(var_2, var_4.weapon);

  var_6 = [];
  var_6[0] = scripts\engine\utility::getStruct("breach_struct_01", "targetname");
  var_6[1] = scripts\engine\utility::getStruct("breach_struct_02", "targetname");
  wait 2;
  thread _id_6A44(var_2, var_6);
  wait 0.5;

  while(level._id_6B02.size + level._id_2F8E.size > var_1) {
    var_7 = _id_77E2(level._id_6B02);

    if(!isDefined(var_7))
      var_7 = _id_77E2(level._id_2F8E);

    var_8 = scripts\engine\utility::random(var_2);
    var_9 = scripts\engine\utility::random(var_6);
    var_10 = var_7.origin - var_9.origin;
    var_11 = vectortoangles(var_10);
    var_12 = anglesToForward(var_11);
    var_13 = anglestoup(var_11);
    playFX(level._effect["vfx_breach_bullet_tracer"], var_9.origin, var_12, var_13);
    magicbullet(var_8, var_9.origin, var_7.origin);
    var_7 dodamage(var_7.health + 999, var_7.origin);
    thread _id_6ADD(var_8, var_9.origin, var_7.origin);
    wait(var_0);
  }
}

_id_77E2(var_0) {
  var_1 = scripts\sp\utility::_id_79B3(level.player.origin, var_0);

  while(isDefined(var_1) && _id_D10D(var_1)) {
    var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    var_1 = scripts\sp\utility::_id_79B3(level.player.origin, var_0);
    wait 0.05;
  }

  return var_1;
}

_id_D10D(var_0) {
  var_1 = 2500;
  var_2 = level.player getEye();
  var_3 = var_0.origin;
  var_4 = anglesToForward(level.player getplayerangles());
  var_5 = distance(var_2, var_3);
  var_6 = var_2 + var_4 * var_5;

  if(distancesquared(var_3, var_6) < var_1)
    return 1;

  return 0;
}

_id_6A44(var_0, var_1) {
  level endon("breach_over");

  for(;;) {
    var_2 = scripts\engine\utility::random(var_1);
    var_3 = var_2.origin + anglesToForward(var_2.angles) * 500;
    var_3 = var_3 + (randomint(150), randomint(150), randomint(150));
    thread _id_6ADD(scripts\engine\utility::random(var_0), var_2.origin, var_3);
    wait(randomfloatrange(0.7, 0.9));
  }
}

_id_6ADD(var_0, var_1, var_2) {
  level endon("breach_over");

  for(var_3 = 0; var_3 < 7; var_3++) {
    var_4 = var_2 - var_1;
    var_4 = var_4 + scripts\engine\utility::randomvector(15);
    var_5 = vectortoangles(var_4);
    var_6 = anglesToForward(var_5);
    var_7 = anglestoup(var_5);
    playFX(level._effect["vfx_breach_bullet_tracer"], var_1, var_6, var_7);
    magicbullet(var_0, var_1, var_2);
    wait(randomfloatrange(0.1, 0.15));
  }
}

_id_F97B() {
  level._id_6B02 = [];
  scripts\sp\utility::_id_9187("default_seeker", 1);
  var_0 = scripts\engine\utility::getStructArray("fake_seeker_spawn", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_106F2();

  wait 1;
  var_4 = 1;

  while(var_4) {
    if(level._id_6B02.size == 0) {
      level notify("fake_seekers_dead");
      var_4 = 0;
    }

    wait 0.05;
  }
}

_id_106F2() {
  var_0 = 1;
  var_1 = spawn("script_model", self.origin);
  var_1 setCanDamage(1);
  var_1.health = var_0;
  var_1 setModel("seeker_grenade_heist_breach_wm");
  var_1 scripts\sp\utility::_id_9196(1, 0, 0, "default_seeker");
  var_1._id_1FBB = "seeker";
  playFXOnTag(level._id_7649["seeker_axis"], var_1, "tag_fx");
  var_1 _meth_83D0(#animtree);
  level._id_6B02 = scripts\engine\utility::add_to_array(level._id_6B02, var_1);
  var_1 thread _id_F13D(self);
  var_1 waittill("death");
  level._id_6B02 = scripts\engine\utility::array_remove(level._id_6B02, var_1);
  screenshake(var_1.origin, 1.2, 1.2, 1.2, 0.35, 0, 0.125, 1000, 8, 8, 8);
  playFX(scripts\engine\utility::getfx("breach_seeker_explosion"), var_1.origin + (0, 0, 7));
  var_1 delete();
}

_id_F13D(var_0) {
  self endon("death");
  wait(randomfloatrange(1.25, 1.65));
  var_1 = 0.05;

  for(;;) {
    if(!isDefined(var_0.target)) {
      break;
    }

    thread _id_F13C();
    self waittill("jumping");
    var_2 = var_0.origin;
    var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_5 = var_4.origin;
    var_6 = var_5 - var_2;
    var_7 = vectorNormalize(var_6);

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "use_fall_height")
      var_8 = var_3.origin[2] - var_5[2];
    else
      var_8 = var_3.origin[2] - var_2[2];

    var_9 = self.angles;
    var_10 = var_4.angles - self.angles;
    var_11 = 0;
    playFXOnTag(level._id_7649["seeker_thruster"], self, "tag_origin");

    while(var_11 <= 1 + var_1) {
      if(var_11 == 0.5) {
        self notify("jump_down");
        stopFXOnTag(level._id_7649["seeker_thruster"], self, "tag_origin");
      } else if(var_11 == 0.9)
        self notify("next_jump");

      var_12 = scripts\sp\math::_id_7BC5(var_2, var_5, var_8, var_11);
      self.origin = var_12;
      self.angles = var_9 + var_10 * var_11;
      var_11 = var_11 + var_1;
      wait 0.05;
    }

    var_0 = var_4;
  }

  _id_F157();
}

_id_F13C() {
  self endon("death");
  self _meth_83A1();
  self clearanim(%equip_seeker_traverse_jumpdown, 0.05);
  self _meth_82A2(%equip_seeker_traverse_jumpup);
  wait 0.15;
  self notify("jumping");
  self waittill("jump_down");
  self _meth_83A1();
  self clearanim(%equip_seeker_traverse_jumpup, 0.05);
  self _meth_82A2(%equip_seeker_traverse_jumpdown);
  self _meth_82B1(%equip_seeker_traverse_jumpdown, 0.5);
}

_id_F157() {
  self endon("death");
  var_0 = 0.7;
  var_1 = level.player.origin - self.origin;
  var_2 = vectortoangles(var_1);
  self.angles = var_2;
  self _meth_82A2(%equip_seeker_walk_forward, 0.2);
  self _meth_82B1(%equip_seeker_walk_forward, var_0);
}

_id_9684() {
  if(isDefined(level._id_C475)) {
    return;
  }
  level._id_C475 = getEnt("om_breach_hole", "targetname");
  level._id_C475._id_1389B = getEnt("om_breach_wall", "targetname");
  level._id_C475 hide();
}

_id_D7ED(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7DC1("prebreach_idle");
  var_2 = getstartorigin(self.origin, self.angles, var_1[0]);
  var_0 thread _id_3B1C(var_2);
  scripts\sp\anim::_id_1F0D(var_0, "prebreach_idle");
  scripts\sp\anim::_id_1EEA(var_0, "prebreach_idle", "stop_pre_breach_loop");
}

_id_3B1C(var_0) {
  var_1 = distance2dsquared(self.origin, var_0);
  var_2 = squared(200);

  while(var_1 > var_2) {
    var_1 = distance2dsquared(self.origin, var_0);
    wait 0.05;
  }

  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_1CD0(var_0, var_1) {
  level endon("stop_ally_postbreach_idle");
  self _meth_83A1();
  self _meth_8250(0);

  if(isalive(level.player)) {
    if(!isDefined(var_1) || !var_1)
      var_0 scripts\sp\anim::_id_1F35(self, "breach_entry");

    scripts\engine\utility::waitframe();
    var_2 = "stop_loop";

    if(self == level._id_6754)
      var_2 = "ethan_stop_loop";

    var_0 thread scripts\sp\anim::_id_1EEA(self, "postbreach_idle", var_2);

    if(self == level._id_EA2C || self == level._id_30F6) {
      scripts\sp\utility::_id_7799(level.player);
      wait 0.05;
      scripts\sp\utility::_id_7798(level.player);
    }
  }
}

_id_10658() {
  var_0 = scripts\sp\utility::_id_107EA("breach_guy_01", 1);
  var_1 = scripts\sp\utility::_id_107EA("breach_guy_02", 1);
  var_1._id_1FBB = "generic";
  var_1._id_4E2A = var_1 scripts\sp\utility::_id_7DC1("explode_b_01");
  scripts\engine\utility::waitframe();
  level._id_2F65 = [var_0, var_1];

  foreach(var_3 in level._id_2F65) {
    if(isalive(var_3)) {
      var_3 thread scripts\sp\anim::_id_1EC7(var_3, "breach_stun_v5");
      var_3 scripts\sp\utility::_id_B14F();
      var_3.allowdeath = 1;
      var_3.health = 1;
      var_3._id_2894 = 0.01;
    }
  }

  level._id_2F65[0]._id_1FBB = "generic";
  wait 0.1;
  scripts\sp\anim::_id_1F29(var_1, "breach_stun_v5", 1.5);
  scripts\engine\utility::array_thread(level._id_2F65, scripts\sp\utility::_id_1101B);
  wait 2.0;
  var_0 _meth_83A1();
  wait 0.5;
  var_1 _meth_83A1();
}

_id_CF4F() {
  level endon("mons_breach_end");
  var_0 = 1;

  while(var_0) {
    if(!isalive(level.player)) {
      foreach(var_2 in level.allies)
      var_2 _meth_83A1();

      var_0 = 0;
    }

    wait 0.05;
  }
}

_id_F119() {
  level._id_F11A = 0;
  level._id_2F8E = [];
  thread _id_D65A("seeker_crate_inst_2");
  thread _id_D65A("seeker_crate_inst_1");
  var_0 = 1;
  level waittill("all_seekers_spawned");

  while(var_0) {
    var_1 = getaicount("axis", "all");

    if(var_1 <= 5)
      var_0 = 0;

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("breach_room_success");
}

_id_D65A(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = getEntArray(var_0, "targetname");

  foreach(var_9 in var_7) {
    if(isDefined(var_9) && isDefined(var_9.script_noteworthy)) {
      var_10 = var_9.script_noteworthy;

      switch (var_10) {
        case "lid_open":
          var_1 = var_9;
          break;
        case "lid":
          var_2 = var_9;
          break;
        case "base":
          var_3 = var_9;
          break;
        case "seeker_1":
          var_4 = var_9;
          break;
        case "seeker_2":
          var_5 = var_9;
          break;
        case "seeker_3":
          var_6 = var_9;
          break;
      }
    }
  }

  var_1 hide();
  scripts\engine\utility::flag_wait("breach_started");
  var_12 = [level.player, level._id_EA2C, level._id_30F6];
  var_13 = 1;
  var_14 = 6.6;

  if(var_0 == "seeker_crate_inst_1") {
    var_12 = [level._id_30F6, level._id_6754, level._id_A54E];
    var_13 = 1.0;
    var_14 = var_14 + 0.4;
  }

  wait(var_14);
  var_4 thread _id_F15B(var_12[0]);
  var_15 = 0.5 * var_13;
  var_2 moveTo(var_1.origin, 1.4);
  var_2 rotateTo(var_1.angles, 1.4);
  var_1 delete();
  wait(var_15 + 0.1);
  var_5 thread _id_F15B(var_12[1]);
  var_15 = randomfloatrange(0.1, 0.5) * var_13;
  wait(var_15 + 0.2);
  var_6 thread _id_F15B(var_12[2]);

  if(var_0 == "seeker_crate_inst_1") {
    wait 0.05;
    level notify("all_seekers_spawned");
  }
}

_id_F15B(var_0) {
  var_1 = _id_0E26::_id_107D2(self.origin, self.angles, "axis", var_0);
  self delete();
  level._id_2F8E = scripts\engine\utility::add_to_array(level._id_2F8E, var_1);
  var_1.health = 500;
  var_1.moveplaybackrate = 0.7;
  var_1._id_2A4B = 0;
  var_1 _meth_84AD();
  wait 0.1;
  var_1 waittill("damage");
  var_1 hide();
  thread scripts\engine\utility::play_sound_in_space("seeker_explode", var_1.origin);
  playFXOnTag(scripts\engine\utility::getfx("breach_seeker_explosion"), var_1, "tag_origin");
  scripts\engine\utility::waitframe();
  screenshake(var_1.origin, 1.2, 1.2, 1.2, 0.15, 0, 0.125, 1000, 8, 8, 8);
  level._id_2F8E = scripts\engine\utility::array_remove(level._id_2F8E, var_1);
  scripts\engine\utility::waitframe();
  radiusdamage(var_1.origin, 30, 5, 5);
  var_1 delete();
  level._id_F11A = level._id_F11A + 1;
}

_id_63E8() {
  if(level._id_F11A > 3 || scripts\engine\utility::flag("breach_room_success")) {
    scripts\engine\utility::flag_set("breach_room_success");
    level.player._id_51E6 = 1;
    wait 0.1;

    foreach(var_1 in level._id_F10A._id_1633) {
      if(isalive(var_1)) {
        var_2 = sortbydistance(level.allies, var_1.origin);
        var_2[0] scripts\anim\notetracks::shootnotetrack();
        var_1.allowdeath = 1;
        var_1 _id_0C25::_id_EA0E();
        wait 0.3;
      }
    }

    foreach(var_5 in level._id_2F65) {
      if(isalive(var_5)) {
        var_2 = sortbydistance(level.allies, var_5.origin);
        var_2[0] scripts\anim\notetracks::shootnotetrack();
        var_5 _meth_81D0();
      }
    }

    foreach(var_1 in level._id_6B02) {
      var_2 = sortbydistance(level.allies, var_1.origin);
      var_1 dodamage(var_1.health + 100, var_1.origin);
      wait 0.3;
    }

    wait 2;
    level.player._id_51E6 = 0;
  }
}

_id_2F52() {
  var_0 = level.player getcurrentweapon();
  var_1 = weaponclipsize(var_0);
  level.player setweaponammoclip(var_0, var_1);
  level.player _meth_80D8(0.5, 0.5);
  level.player _id_0E42::giveperk("specialty_quickdraw");
  level.player scripts\sp\utility::_id_65E1("player_no_auto_blur");
  var_2 = getdvarfloat("perk_quickDrawSpeedScaleSP", 1);
  var_3 = getdvarfloat("perk_quickDrawSpeedScaleSniperSP", 1);
  var_4 = getdvarfloat("bg_quickWeaponSwitchSpeedScaleSP", 1);
  var_5 = _id_7D71(var_0);
  setsaveddvar("perk_quickDrawSpeedScaleSP", var_2 * var_5);
  setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_3 * var_5);
  setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_4 / var_5);
  level waittill("breach_over");
  level.player _meth_80A6();
  setsaveddvar("perk_quickDrawSpeedScaleSP", var_2);
  setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_3);
  setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_4);
  level.player scripts\sp\utility::_id_65DD("player_no_auto_blur");
  level.player _id_0E42::removeperk("specialty_quickdraw");
}

_id_7D71(var_0) {
  var_1 = weaponclass(var_0);

  switch (var_1) {
    case "smg":
    case "rifle":
    case "pistol":
      return 1;
    case "spread":
      return 1;
    case "mg":
      return 2.0;
    case "sniper":
      return 1.5;
    case "rocketlauncher":
      return 1.5;
    default:
      return 1;
  }
}

_id_445F(var_0, var_1) {
  return _id_7D6D(var_0) > _id_7D6D(var_1);
}

_id_7D6D(var_0) {
  var_1 = weaponclass(var_0);

  switch (var_1) {
    case "rifle":
    case "pistol":
      return 2;
    case "smg":
      return 4;
    case "spread":
      return 5;
    case "mg":
      return 0;
    case "sniper":
      return 0;
    case "rocketlauncher":
      return 3;
    default:
      return 1;
  }
}

_id_108A2() {}

_id_5412() {
  wait 1;
  scripts\engine\utility::flag_set("breach_ready");
  thread _id_2F60();
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_bridgeisontheot");

  if(!scripts\engine\utility::flag("breach_started"))
    level.player scripts\sp\utility::_id_1034D("heist_plr_wellhavetobreac");

  if(!scripts\engine\utility::flag("breach_started"))
    level._id_6754 scripts\sp\utility::_id_10346("heist_eth_gotasoftpointri");

  if(!scripts\engine\utility::flag("breach_started"))
    level.player thread scripts\sp\utility::_id_1034D("heist_plr_copyiseeit");

  thread _id_2F7A();
  scripts\engine\utility::flag_wait("breach_started");
  wait 2.1;
  level.player scripts\sp\utility::_id_1034D("heist_plr_chargeisset");
}

_id_2F60() {
  level._id_EA2C thread scripts\sp\utility::_id_7799(level.player);
  wait 0.05;
  level._id_EA2C thread scripts\sp\utility::_id_7798(level.player);
  level._id_30F6 thread scripts\sp\utility::_id_7799(level.player);
  wait 0.05;
  level._id_30F6 thread scripts\sp\utility::_id_7798(level.player);
}

_id_2F7A() {
  level endon("breach_started");
  wait 8;

  if(!scripts\engine\utility::flag("breach_started")) {
    level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_plantyourcharge");
    wait 10;
    level._id_6754 scripts\sp\utility::_id_10346("heist_eth_settheexplosive");
  }
}

_id_5834() {
  var_0 = 1;
  var_1 = "Breach";

  if(var_0) {}

  _id_0B0A::_id_583F(0, 14, 18, 14, 26, 6, 7.33);
  wait 4;

  if(var_0) {}

  _id_0B0A::_id_583F(50, 110, 12, 110, 160, 3, 2);
  wait 2;

  if(var_0) {}

  _id_0B0A::_id_583F(80, 150, 0, 150, 350, 3, 0.66);
}

_id_583B(var_0) {
  _id_0B0A::_id_583D(var_0);
}