/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3181.gsc
**************************************/

_id_13EBB(var_0, var_1, var_2, var_3) {
  if(var_0 == "zero_gravity") {}

  _id_0C68::_id_51E8(var_0, var_1, var_2, var_3);
  self.space = 1;
  self.combatmode = "cover3d";
  self.sharpturnlookaheaddist = 64;
  self.turnrate = 0.2;
}

_id_13ED1(var_0, var_1, var_2, var_3) {
  _id_0C68::_id_51E8(var_0, var_1, var_2, var_3);
  self.space = 1;
  self.sharpturnlookaheaddist = 8;
  self.turnrate = 0.1;
  self._id_5042 = 45;
  self.dontmelee = 1;
  self._id_C009 = 1;
  self._id_C062 = 1;
  self.grenadeammo = 0;
  self.grenadeawareness = 0;
  self.nogrenadereturnthrow = 1;
  self.combatmode = "cover3d";
  self.usechokepoints = 0;
  self.disablebulletwhizbyreaction = 1;
  self._id_55DA = 1;
  self._id_C09F = 1;

  if(self.team == "allies")
    self._id_C554 = 1;

  self._id_4E52 = 1;
  self._id_4E46 = ::_id_104CD;
  self._id_C733 = self.team;
  self._id_13887 = 250;
  self.maxfaceenemydist = 4000;
  self._id_8E19 = _id_0C60::_id_8E17;
  self._id_72D0 = ::_id_72CF;
  self._id_41AF = ::_id_41AE;
  self._id_9E8E = ::_id_9E8D;
  self._id_10DFE = ::_id_10D48;
  self._id_11093 = ::_id_1104E;
  thread _id_104BB();
  thread _id_E738();
  thread _id_10D48();
}

_id_10D48() {
  self notify("stop_thruster_thread");
  self endon("death");
  self endon("stop_thruster_thread");
  thread _id_11859();

  while(!isDefined(level._id_13EEB))
    wait 0.25;

  if(!isDefined(self._id_7608))
    self._id_7608 = self[[level._id_13EEB]]("tag_fx_back");

  while(!isDefined(level._id_13EEA))
    wait 0.25;

  if(!isDefined(self._id_7607)) {
    wait 0.1;
    self._id_7607 = self[[level._id_13EEA]]("tag_fx_bottom");
  }
}

_id_11859() {
  self endon("stop_thruster_thread");
  self waittill("death");

  if(isDefined(self) && isDefined(self._id_11093))
    self[[self._id_11093]]();
}

_id_1104E() {
  if(isDefined(self._id_7608)) {
    var_0 = self._id_7608[0];
    var_1 = self._id_7608[1];
    stopFXOnTag(var_0, self, var_1);
  }

  if(isDefined(self._id_7607)) {
    var_0 = self._id_7607[0];
    var_1 = self._id_7607[1];
    stopFXOnTag(var_0, self, var_1);
  }

  self._id_7608 = undefined;
  self._id_7607 = undefined;
  self notify("stop_thruster_thread");
}

_id_72CF(var_0) {
  self._id_72CF = var_0;
  self orientmode("face angle 3d", var_0);
}

_id_41AE() {
  self._id_72CF = undefined;
}

_id_4E4B() {
  if(!isDefined(self._id_A969))
    return 0;

  if(self._id_A969 == "")
    return 0;

  if(self._id_A969 == "j_head" || self._id_A969 == "j_helmet")
    return 0;

  return 1;
}

_id_104CD() {
  if(_id_4E4B()) {
    var_0 = self gettagorigin(self._id_A969);
    var_1 = vectortoangles(self._id_A967);
    var_2 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
    var_2 linkTo(self, self._id_A969);
    playFXOnTag(scripts\engine\utility::getfx("spacesuit_leak"), var_2, "tag_origin");
    var_2 thread _id_5185(self);
  }

  playFXOnTag(scripts\engine\utility::getfx("spacesuit_burst"), self, "j_spineupper");
  return 0;
}

_id_5185(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

_id_104BB() {
  while(self.health > 0) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self._id_A967 = undefined;
    self._id_A969 = undefined;

    if(var_4 != "MOD_EXPLOSIVE" && var_4 != "MOD_MELEE") {
      self._id_A967 = -1 * var_2;
      self._id_A969 = var_7;
    }
  }
}

_id_E738() {
  self endon("death");
  var_0 = 25;
  var_1 = 25;
  var_2 = 25;
  var_3 = 0.25;
  var_4 = var_0 * var_3;
  var_5 = var_1 * var_3;
  var_6 = var_2 * var_3;
  var_7 = min(min(var_4, var_5), var_6);
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 500;
  var_13 = self.angles;

  for(;;) {
    var_14 = combineangles(invertangles(var_13), self.angles);
    var_14 = (angleclamp180(var_14[0]), angleclamp180(var_14[1]), angleclamp180(var_14[2]));

    if(length(var_14) > var_7 && !_id_9E8D() && !scripts\asm\asm_bb::bb_isanimScripted()) {
      var_15 = gettime();

      if(var_14[0] > var_4) {
        if(var_15 > var_9 + var_12) {
          _id_CE14("down");
          var_9 = var_15;
        }
      } else if(var_14[0] < -1 * var_4) {
        if(var_15 > var_8 + var_12) {
          _id_CE14("up");
          var_8 = var_15;
        }
      }

      if(var_14[1] > var_5) {
        if(var_15 > var_10 + var_12) {
          _id_CE14("left");
          var_10 = var_15;
        }
      } else if(var_14[1] < -1 * var_5) {
        if(var_15 > var_11 + var_12) {
          _id_CE14("right");
          var_11 = var_15;
        }
      }

      if(var_14[2] > var_6) {
        if(var_15 > var_8 + var_12) {
          _id_CE14("up");
          var_8 = var_15;
        }

        if(var_15 > var_10 + var_12) {
          _id_CE14("left");
          var_10 = var_15;
        }
      } else if(var_14[2] < -1 * var_6) {
        if(var_15 > var_9 + var_12) {
          _id_CE14("down");
          var_9 = var_15;
        }

        if(var_15 > var_11 + var_12) {
          _id_CE14("right");
          var_11 = var_15;
        }
      }
    }

    var_13 = self.angles;
    wait(var_3);
  }
}

_id_9E8D() {
  var_0 = self gettagorigin("j_spineupper");
  var_1 = distance(self.origin, var_0);
  return var_1 > 20;
}

_id_CE14(var_0) {
  var_1 = undefined;

  if(var_0 == "up")
    var_1 = "tag_fx_top";
  else if(var_0 == "down")
    var_1 = "tag_fx_bottom";
  else if(var_0 == "left")
    var_1 = "tag_fx_left";
  else if(var_0 == "right")
    var_1 = "tag_fx_right";

  self[[level._id_13EE9]](var_1);
}