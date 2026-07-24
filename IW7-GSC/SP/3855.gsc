/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3855.gsc
**************************************/

_id_A343() {
  level._effect["sa_flashlight_jackal"] = loadfx("vfx/iw7/core/light/vfx_flashlight_jackal");
  level._effect["sa_flashlight_flare"] = loadfx("vfx/iw7/core/light/vfx_flashlight_npc_nolight.vfx");
  precacheturret("fighter_spotlight");
  precachemodel("veh_mil_air_ca_jackal_01_spotlight");
}

_id_E801(var_0) {
  self endon("death");
  self._id_10A5F = spawnturret("misc_turret", self.origin, "fighter_spotlight");
  self._id_10A5F setModel("veh_mil_air_ca_jackal_01_spotlight");
  self._id_10A5F setmode("manual");
  self._id_10A5F makeunusable();
  self._id_10A5F _meth_82C9(3, "yaw");
  self._id_10A5F _meth_82C9(3, "pitch");
  self._id_10A5F setleftarc(180);
  self._id_10A5F setrightarc(180);
  self._id_10A5F setbottomarc(180);
  self._id_10A5F linkTo(self, "tag_spotlight", (0, 0, 0), (0, 0, 0));
  self waittill("spotlight_moment");
  _id_0BDC::_id_19B0("hover");
  wait 1;
  thread _id_E81E(scripts\engine\utility::getclosest(self.origin, var_0));
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_jackal"), self._id_10A5F, "tag_flash");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self._id_10A5F, "tag_flash");
  self waittill("spotlight_moment_end");
  self._id_10A5F._id_12707 delete();
  self._id_10A5F delete();
  wait 1;
  _id_0BDC::_id_19B0("fly");
}

_id_E81E(var_0) {
  self._id_10A5F endon("death");

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "proximity") {
    self._id_10A5F thread _id_DAC7(var_0);
  } else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "trigger") {
    self._id_10A5F thread _id_127A0(var_0, self);
  } else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "trigger_drag") {
    self._id_10A5F thread _id_1154A(var_0, self);
  } else {
    self._id_10A5F thread _id_118E8(var_0);
  }
}

_id_118E8(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  self._id_12707 = spawn("script_origin", var_1.origin);
  self settargetentity(self._id_12707);
  wait 1;

  for(;;) {
    self._id_12707.origin = var_1.origin;
    wait 0.75;

    if(!isDefined(var_1.target)) {
      break;
    }

    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  }
}

_id_DAC7(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  self._id_12707 = spawn("script_origin", var_1.origin);
  self settargetentity(self._id_12707);
  wait 1;

  while(isDefined(var_1.target)) {
    self._id_12707.origin = var_1.origin;

    while(1600 < distance(self._id_12707.origin, var_1.origin) && vectordot(self.forward, self.origin - self._id_12707.origin) < 0) {
      wait 0.5;
    }

    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  }
}

_id_127A0(var_0, var_1) {
  self endon("death");
  var_2 = getEnt(var_0.target, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  self._id_12707 = spawn("script_origin", self.origin + anglesToForward(self.angles) * 2000);
  self settargetentity(self._id_12707);
  self._id_12707 thread _id_5B62();

  for(;;) {
    var_2 waittill("trigger", var_4);

    if(var_4 != var_1) {
      continue;
    }
    self._id_12707.origin = var_3.origin;
    var_2 = getEnt(var_2.target, "targetname");
    thread _id_118EA(var_3, var_2);

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }
}

_id_118EA(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 endon("trigger");
  }

  for(;;) {
    wait 1.25;

    if(isDefined(var_0.target)) {
      var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
      self._id_12707.origin = var_0.origin;
      continue;
    }

    break;
  }
}

_id_1154A(var_0, var_1) {
  self endon("death");
  var_2 = getEnt(var_0.target, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  self._id_12707 = spawn("script_origin", self.origin + anglesToForward(self.angles) * 2000);
  self._id_12707 linkTo(self, "tag_origin", scripts\sp\utility::_id_13DCC(var_3.origin), (0, 0, 0));
  self settargetentity(self._id_12707);

  for(;;) {
    var_2 waittill("trigger", var_4);

    if(var_4 != var_1 || !isalive(self)) {
      continue;
    }
    self._id_12707 linkTo(self, "tag_origin", scripts\sp\utility::_id_13DCC(var_3.origin), (0, 0, 0));
    var_2 = getEnt(var_2.target, "targetname");
    thread _id_118EB(var_3, var_2);

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }
}

_id_118EB(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    var_1 endon("trigger");
  }

  for(;;) {
    if(isDefined(level._id_A344)) {
      wait(level._id_A344);
    } else {
      wait 1.25;
    }

    if(isDefined(var_0.target)) {
      var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
      self._id_12707 linkTo(self, "tag_origin", scripts\sp\utility::_id_13DCC(var_0.origin), (0, 0, 0));
      continue;
    }

    break;
  }
}

_id_5B62() {
  self endon("death");

  for(;;) {
    scripts\sp\debug::_id_5B24(self.origin, (1, 0, 0), self.angles, 32);
    scripts\engine\utility::waitframe();
  }
}