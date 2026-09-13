/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_25c7a5935190c3f0.gsc
***********************************************/

init() {
  if(!isDefined(level.loot_choppers))
    _id_271667045665E514::init();
}

_id_3DDB1DE0C470A2B2(_id_9CA5B7427AE3D1F2, _id_77A5F517FA4DAB82, _id_F16D407674809F11, _id_D18E96E93660D7D0) {
  level.averagealliesz = 0;
  _id_A5639D6F3F95033A = _id_F16D407674809F11;
  startingangles = (0, 0, 0);
  _id_6EA44339B53B31BC = "veh_chopper_support_dmz_mp";
  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, _id_A5639D6F3F95033A, startingangles, _id_6EA44339B53B31BC, "veh8_mil_air_palfa_east");

  if(!isDefined(chopper)) {
    return;
  }
  chopper.speed = _id_D18E96E93660D7D0.speed;
  chopper.accel = _id_D18E96E93660D7D0.accel;
  chopper.lifetime = getdvarint("dvar_C9BF362F07C0B844", 9999);
  chopper.team = _id_D18E96E93660D7D0.team;
  chopper.angles = startingangles;
  chopper.flaresreservecount = getdvarint("dvar_8BB2D173674D701A", 0);
  chopper.pathstart = _id_A5639D6F3F95033A;
  chopper.pathgoal = _id_9CA5B7427AE3D1F2.origin;
  chopper.currentaction = undefined;
  chopper.currenttarget = _id_9CA5B7427AE3D1F2;
  chopper.heightoffset = (0, 0, getdvarint("dvar_5E4F7A1DFFAD4BD0", 750));
  chopper.patrolzone = undefined;
  chopper.patrollocation = undefined;
  chopper.patrolradius = undefined;
  chopper.stage3accradius = 35;
  chopper.crashoffset = chopper.heightoffset[2] - 250;
  chopper._id_4EA882F848E90349 = chopper _id_08AE9611B3C0AFE3(_id_77A5F517FA4DAB82);
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(_id_D18E96E93660D7D0.speed, _id_D18E96E93660D7D0.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setvehicleteam(chopper.team);
  chopper.currenthealth = getdvarint("dvar_BB80E65B55C98289", _id_D18E96E93660D7D0.health);
  chopper.health = _id_D18E96E93660D7D0.health;
  chopper.maxhealth = getdvarint("dvar_BB80E65B55C98289", _id_D18E96E93660D7D0.health);
  chopper scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", chopper.team);
  chopper _id_271667045665E514::lootchopper_setupdamagefunctionality();
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  chopper._id_D52330F9070D8F9A = spawnStruct();
  chopper._id_D52330F9070D8F9A.ammo = 16;
  chopper._id_D52330F9070D8F9A.cooldown = 3;
  chopper._id_D52330F9070D8F9A._id_62C8F81FFF6AA072 = 0.1;
  chopper._id_D52330F9070D8F9A.accuracy = 40;
  chopper._id_D52330F9070D8F9A._id_49D076A82A5DC908 = 4000000;
  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  chopper.frontturret setModel("veh9_mil_air_heli_ahotel64_turret");
  chopper.frontturret.team = chopper.team;
  chopper.frontturret.angles = chopper.angles;
  chopper.frontturret.turreton = 1;
  chopper.frontturret.name = "front_turret";
  chopper.frontturret.attackingtarget = _id_9CA5B7427AE3D1F2;
  chopper.frontturret.vehicleparent = "loot_chopper";
  chopper.frontturret linkTo(chopper);
  chopper.frontturret setturretteam(chopper.team);
  chopper.frontturret setturretmodechangewait(0);
  chopper.frontturret setmode("manual");
  chopper.frontturret setdefaultdroppitch(45);
  chopper.frontturret.owner = chopper;
  chopper.frontturret.groundtargetent = spawn("script_model", chopper.origin);
  chopper.frontturret.groundtargetent setModel("tag_origin");
  chopper.frontturret.groundtargetent dontinterpolate();
  chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  chopper.rearturret setModel("veh9_mil_air_heli_ahotel64_turret");
  chopper.rearturret.team = chopper.team;
  chopper.rearturret.angles = chopper.angles;
  chopper.rearturret.turreton = 1;
  chopper.rearturret.name = "rear_turret";
  chopper.rearturret.attackingtarget = _id_9CA5B7427AE3D1F2;
  chopper.rearturret.vehicleparent = "loot_chopper";
  chopper.rearturret linkTo(chopper);
  chopper.rearturret setturretteam(chopper.team);
  chopper.rearturret setturretmodechangewait(0);
  chopper.rearturret setmode("manual");
  chopper.rearturret setdefaultdroppitch(45);
  chopper.rearturret.owner = chopper;
  chopper.rearturret.groundtargetent = spawn("script_model", chopper.origin);
  chopper.rearturret.groundtargetent setModel("tag_origin");
  chopper.rearturret.groundtargetent dontinterpolate();
  chopper.frontturret thread _id_506066D551CC9D40();
  chopper.frontturret thread _id_3D32E37BDC6F2A62();
  chopper.rearturret thread _id_506066D551CC9D40();
  chopper.rearturret thread _id_3D32E37BDC6F2A62();
  chopper thread _id_D1A7902563AC0855();
  chopper notify("change_movement_type", ::_id_411442F3099D02EF);
  chopper thread _id_2BF53245395DE26D();
  level.loot_choppers[level.loot_choppers.size] = chopper;
  chopper.patrolfunc = ::_id_D1A7902563AC0855;
  chopper.cleanupfunc = ::_id_F385485BF0B04ED1;
  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    chopper thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);

  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(chopper.pathgoal, 1);
  return chopper;
}

_id_08AE9611B3C0AFE3(player) {
  _id_607DA387F3617ED1 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team);

  if(!isDefined(_id_607DA387F3617ED1)) {
    if(isPlayer(player))
      return player;

    return undefined;
  }

  return _id_607DA387F3617ED1;
}

_id_042DADB2852B23AB() {
  _id_2909ED8B5CAE5917 = undefined;

  if(!isDefined(self._id_4EA882F848E90349) || self._id_4EA882F848E90349.size <= 0)
    return undefined;

  foreach(target in self._id_4EA882F848E90349) {
    if(isDefined(target) && target != self.currenttarget)
      _id_2909ED8B5CAE5917 = target;
  }

  return _id_2909ED8B5CAE5917;
}

_id_FBF24CB95DBAC64D() {
  _id_413171B8B9E8BEE0 = self._id_4EA882F848E90349;

  foreach(target in self._id_4EA882F848E90349) {
    if(isDefined(target)) {
      if(distance2dsquared(self.origin, target.origin) > self._id_D52330F9070D8F9A._id_49D076A82A5DC908)
        _id_413171B8B9E8BEE0 = scripts\engine\utility::array_remove(_id_413171B8B9E8BEE0, target);
    }
  }

  return scripts\engine\utility::random(_id_413171B8B9E8BEE0);
}

_id_D1A7902563AC0855(_id_0CE938A4EA8A54D5) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("change_movement_type", _id_3A876AA70B6F8585);
    self thread[[_id_3A876AA70B6F8585]]();
  }
}

_id_411442F3099D02EF() {
  level endon("game_ended");
  self endon("death");
  self endon("change_movement_type");
  self endon("leaving");

  for(;;) {
    wait 4;

    if(!isDefined(self.currenttarget))
      self notify("change_target", _id_042DADB2852B23AB());

    if(!isDefined(self._id_4EA882F848E90349) || self._id_4EA882F848E90349.size <= 0) {
      return;
    }
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(self.currenttarget, 1);
  }
}

_id_2DAA88EA0F1F76CC() {
  level endon("game_ended");
  self endon("death");
  self endon("change_movement_type");

  for(;;)
    wait(randomfloat(1.0));
}

_id_3D32E37BDC6F2A62() {
  level endon("game_ended");
  self.owner endon("death");
  self.owner endon("leaving");
  waitframe();
  self.oncooldown = 0;
  self.ammo = self.owner._id_D52330F9070D8F9A.ammo;

  if(!isDefined(self.owner._id_4EA882F848E90349) || self.owner._id_4EA882F848E90349.size <= 0) {
    return;
  }
  self.owner scripts\cp_mp\killstreaks\chopper_support::choppersupport_setcurrenttarget(self, self.owner._id_4EA882F848E90349[0]);

  for(;;) {
    if(!isDefined(self.owner.currenttarget)) {
      self.attackingtarget = self.owner _id_FBF24CB95DBAC64D();

      if(!isDefined(self.attackingtarget)) {
        break;
      }
    }

    if(!self.oncooldown && distance2dsquared(self.owner.currenttarget.origin, self.origin) < self.owner._id_D52330F9070D8F9A._id_49D076A82A5DC908) {
      self.oncooldown = 1;
      thread _id_C143E844E211D111(self.ammo, self.owner._id_D52330F9070D8F9A._id_62C8F81FFF6AA072);
    }

    waitframe();
  }
}

_id_C143E844E211D111(_id_2719D06ACDA987D7, _id_50980DD85D7F48FA) {
  level endon("game_ended");
  self.owner endon("death");
  self.owner endon("leaving");
  shotsfired = 0;

  while(shotsfired < _id_2719D06ACDA987D7) {
    self.attackingtarget = self.owner _id_FBF24CB95DBAC64D();

    if(!isDefined(self.attackingtarget)) {
      return;
    }
    self.groundtargetent.origin = self.attackingtarget.origin;
    x = self.groundtargetent.origin[0];
    y = self.groundtargetent.origin[1];
    z = self.groundtargetent.origin[2];
    _id_4D47B039A2F83B87 = scripts\engine\utility::ter_op(randomint(10) > 5, -1, 1);
    _id_4D47AF39A2F83954 = scripts\engine\utility::ter_op(randomint(10) > 5, -1, 1);
    _id_6C05446634714247 = randomfloat(1) * self.owner._id_D52330F9070D8F9A.accuracy * _id_4D47B039A2F83B87 + x;
    _id_827F335C2225D1EA = randomfloat(1) * self.owner._id_D52330F9070D8F9A.accuracy * _id_4D47AF39A2F83954 + y;
    self.groundtargetent.origin = self.groundtargetent.origin + (_id_6C05446634714247, _id_827F335C2225D1EA, z);
    self shootturret("tag_flash");
    shotsfired = shotsfired + 1;
    wait(_id_50980DD85D7F48FA);
  }

  wait(self.owner._id_D52330F9070D8F9A.cooldown);
  self.oncooldown = 0;
}

_id_506066D551CC9D40(_id_E33E3A821C447E2B) {
  level endon("game_ended");
  self.owner endon("death");
  self.owner endon("leaving");
  self.attackingtarget = self.owner._id_4EA882F848E90349[0];
  self.owner setlookatent(self.attackingtarget);

  for(;;) {
    if(!isDefined(self.owner._id_4EA882F848E90349) || self.owner._id_4EA882F848E90349.size <= 0) {
      return;
    }
    self.groundtargetent.origin = self.owner.currenttarget.origin + (0, 0, 32);
    waitframe();
  }
}

_id_2BF53245395DE26D() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("change_target", _id_2909ED8B5CAE5917);

    if(!isDefined(_id_2909ED8B5CAE5917)) {
      self notify("change_movement_behavior", ::_id_2DAA88EA0F1F76CC);
      continue;
    }

    self.currenttarget = _id_2909ED8B5CAE5917;
  }
}

_id_F385485BF0B04ED1() {
  _id_271667045665E514::lootchopper_cleanup();
}