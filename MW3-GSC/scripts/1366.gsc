/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1366.gsc
**************************************/

_id_417C(var_0, var_1) {
  if(!isDefined(level._id_417D)) {
    level._id_417D = [];
  }
  if(!isDefined(level._id_417D[var_0])) {
    level._id_417D[var_0] = [];
  }
  if(isDefined(level._id_417D[var_0][var_1])) {
    return 1;
  }
  level._id_417D[var_0][var_1] = 1;
  return 0;
}

_id_417E(var_0) {
  if(_id_417C(var_0, "add_smoking_notetracks")) {
    return;
  }
  maps\_anim::_id_1264(var_0, "attach cig", ::_id_4187);
  maps\_anim::_id_1264(var_0, "detach cig", ::_id_4189);
  maps\_anim::_id_1264(var_0, "puff", ::_id_418E);
  maps\_anim::_id_1264(var_0, "exhale", ::_id_418F);
  level._effect["cigar_glow"] = loadfx("fire/cigar_glow_far");
  level._effect["cigar_glow_puff"] = loadfx("fire/cigar_glow_puff");
  level._effect["cigar_smoke_puff"] = loadfx("smoke/cigarsmoke_puff_far");
  level._effect["cigar_exhale"] = loadfx("smoke/cigarsmoke_exhale_far");
  level._id_1F90["cigar"] = "prop_price_cigar";
}

_id_417F(var_0) {
  if(isDefined(var_0._id_4180)) {
    var_0._id_4180 delete();
  }
}

_id_4181(var_0) {
  if(_id_417C(var_0, "add_cellphone_notetracks")) {
    return;
  }
  maps\_anim::_id_1264(var_0, "attach clip left", ::_id_4182);
  maps\_anim::_id_1264(var_0, "detach clip left", ::_id_417F);
  level._id_1F90["clip"] = "weapon_ak47_clip";
}

_id_4182(var_0) {
  var_0 notify("new_prop_rotation");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 setModel(maps\_utility::_id_274A("clip"));
  var_0._id_4180 = var_1;
  thread _id_418A(var_1, var_0);
}

_id_4183(var_0) {
  if(_id_417C(var_0, "add_cellphone_notetracks")) {
    return;
  }
  maps\_anim::_id_1264(var_0, "attach phone", ::_id_4184);
  maps\_anim::_id_1264(var_0, "detach phone", ::_id_4186);
  level._id_1F90["cellphone"] = "com_cellphone_off";
}

_id_4184(var_0) {
  var_0 notify("new_phone_rotation");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 setModel(maps\_utility::_id_274A("cellphone"));
  var_0._id_4185 = var_1;
  thread _id_418A(var_1, var_0);
}

_id_4186(var_0) {
  if(isDefined(var_0._id_4185)) {
    var_0._id_4185 delete();
  }
}

_id_4187(var_0) {
  var_0 notify("new_cigar_rotation");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 setModel(maps\_utility::_id_274A("cigar"));
  playFXOnTag(common_scripts\utility::getfx("cigar_glow"), var_1, "tag_cigarglow");
  var_0._id_4188 = var_1;
  thread _id_418B(var_1, var_0);
}

_id_4189(var_0) {
  if(isDefined(var_0._id_4188)) {
    var_0._id_4188 thread _id_418C();
  }
}

_id_418A(var_0, var_1) {
  var_1 notify("new_prop_rotation" + var_0.model);
  var_1 endon("new_prop_rotation" + var_0.model);
  var_0 endon("death");
  var_1 maps\_utility::_id_275A("new_prop_rotation" + var_0.model);
  var_0 maps\_utility::_id_275A("death");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "stop_loop");
  var_1 maps\_utility::_id_09C9(maps\_utility::_id_09CA, "death");
  maps\_utility::_id_09CB();
  var_0 delete();
}

_id_418B(var_0, var_1) {
  var_1 notify("new_prop_rotation" + var_0.model);
  var_1 endon("new_prop_rotation" + var_0.model);
  var_0 endon("death");
  var_1 maps\_utility::_id_275A("new_prop_rotation" + var_0.model);
  var_0 maps\_utility::_id_275A("death");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "stop_loop");
  var_1 maps\_utility::_id_09C9(maps\_utility::_id_09CA, "death");
  maps\_utility::_id_09CB();
  var_0 thread _id_418C();
}

_id_418C() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_418D) && self._id_418D) {
    return;
  }
  self._id_418D = 1;
  stopFXOnTag(common_scripts\utility::getfx("cigar_glow"), self, "tag_cigarglow");
  var_0 = 3;
  var_1 = anglesToForward(self.angles);
  self unlink();
  self movegravity(var_1 * 100, var_0);
  self rotatevelocity((400, 0, 0), var_0, 0, var_0);
  wait(var_0);
  self delete();
}

_id_418E(var_0) {
  if(!isDefined(var_0._id_4188)) {
    return;
  }
  var_0 endon("death");
  var_0._id_4188 endon("death");
  playFXOnTag(common_scripts\utility::getfx("cigar_glow_puff"), var_0._id_4188, "tag_cigarglow");
  wait 1;
  playFXOnTag(common_scripts\utility::getfx("cigar_smoke_puff"), var_0, "tag_eye");
}

_id_418F(var_0) {
  if(!isDefined(var_0._id_4188)) {
    return;
  }
  playFXOnTag(common_scripts\utility::getfx("cigar_exhale"), var_0, "tag_eye");
}

_id_4190() {
  var_0 = [];
  var_0[var_0.size] = "J_MainRoot";
  var_0[var_0.size] = "J_CoatFront_LE";
  var_0[var_0.size] = "J_Hip_LE";
  var_0[var_0.size] = "J_CoatRear_RI";
  var_0[var_0.size] = "J_CoatRear_LE";
  var_0[var_0.size] = "J_CoatFront_RI";
  var_0[var_0.size] = "J_Cheek_RI";
  var_0[var_0.size] = "J_Brow_LE";
  var_0[var_0.size] = "J_Shoulder_RI";
  var_0[var_0.size] = "J_Head";
  var_0[var_0.size] = "J_ShoulderRaise_LE";
  var_0[var_0.size] = "J_Neck";
  var_0[var_0.size] = "J_Clavicle_RI";
  var_0[var_0.size] = "J_Ball_LE";
  var_0[var_0.size] = "J_Knee_Bulge_LE";
  var_0[var_0.size] = "J_Ankle_RI";
  var_0[var_0.size] = "J_Ankle_LE";
  var_0[var_0.size] = "J_SpineUpper";
  var_0[var_0.size] = "J_Knee_RI";
  var_0[var_0.size] = "J_Knee_LE";
  var_0[var_0.size] = "J_HipTwist_RI";
  var_0[var_0.size] = "J_HipTwist_LE";
  var_0[var_0.size] = "J_SpineLower";
  var_0[var_0.size] = "J_Hip_RI";
  var_0[var_0.size] = "J_Elbow_LE";
  var_0[var_0.size] = "J_Wrist_RI";
  self endon("death");

  for(;;) {
    while(self.movemode != "run") {
      wait 0.2;
      continue;
    }

    playFXOnTag(level._effect["ghillie_leaves"], self, common_scripts\utility::random(var_0));
    wait(randomfloatrange(0.1, 2.5));
  }
}

_id_4191() {
  _id_4187(self);
}