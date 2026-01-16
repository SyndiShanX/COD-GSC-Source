/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_props.gsc
********************************/

prop_notetrack_exist(var_0, var_1) {
  if(!isdefined(level.prop_notetracks))
    level.prop_notetracks = [];

  if(!isdefined(level.prop_notetracks[var_0]))
    level.prop_notetracks[var_0] = [];

  if(isdefined(level.prop_notetracks[var_0][var_1]))
    return 1;

  level.prop_notetracks[var_0][var_1] = 1;
  return 0;
}

add_smoking_notetracks(var_0) {
  if(prop_notetrack_exist(var_0, "add_smoking_notetracks")) {
    return;
  }
  maps\_anim::addnotetrack_customfunction(var_0, "attach cig", ::attach_cig);
  maps\_anim::addnotetrack_customfunction(var_0, "detach cig", ::detach_cig);
  maps\_anim::addnotetrack_customfunction(var_0, "puff", ::smoke_puff);
  maps\_anim::addnotetrack_customfunction(var_0, "exhale", ::smoke_exhale);
  level._effect["cigar_glow"] = loadfx("fx\fire\cigar_glow_far");
  level._effect["cigar_glow_puff"] = loadfx("fx\fire\cigar_glow_puff");
  level._effect["cigar_smoke_puff"] = loadfx("fx\smoke\cigarsmoke_puff_far");
  level._effect["cigar_exhale"] = loadfx("fx\smoke\cigarsmoke_exhale_far");
  level.scr_model["cigar"] = "prop_price_cigar";
}

detach_idle_clip(var_0) {
  if(isdefined(var_0.clip))
    var_0.clip delete();
}

add_sit_load_ak_notetracks(var_0) {
  if(prop_notetrack_exist(var_0, "add_cellphone_notetracks")) {
    return;
  }
  maps\_anim::addnotetrack_customfunction(var_0, "attach clip left", ::attach_clip);
  maps\_anim::addnotetrack_customfunction(var_0, "detach clip left", ::detach_idle_clip);
  level.scr_model["clip"] = "weapon_ak47_clip";
}

attach_clip(var_0) {
  var_0 notify("new_prop_rotation");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 setmodel(maps\_utility::getmodel("clip"));
  var_0.clip = var_1;
  thread prop_delete(var_1, var_0);
}

add_cellphone_notetracks(var_0) {
  if(prop_notetrack_exist(var_0, "add_cellphone_notetracks")) {
    return;
  }
  maps\_anim::addnotetrack_customfunction(var_0, "attach phone", ::attach_phone);
  maps\_anim::addnotetrack_customfunction(var_0, "detach phone", ::detach_phone);
  level.scr_model["cellphone"] = "com_cellphone_off";
}

attach_phone(var_0) {
  var_0 notify("new_phone_rotation");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 setmodel(maps\_utility::getmodel("cellphone"));
  var_0.phone = var_1;
  thread prop_delete(var_1, var_0);
}

detach_phone(var_0) {
  if(isdefined(var_0.phone))
    var_0.phone delete();
}

attach_cig(var_0) {
  var_0 notify("new_cigar_rotation");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_1 setmodel(maps\_utility::getmodel("cigar"));
  playfxontag(common_scripts\utility::getfx("cigar_glow"), var_1, "tag_cigarglow");
  var_0.cigar = var_1;
  thread prop_delete_cig(var_1, var_0);
}

detach_cig(var_0) {
  if(isdefined(var_0.cigar))
    var_0.cigar thread prop_cig_throw();
}

prop_delete(var_0, var_1) {
  var_1 notify("new_prop_rotation" + var_0.model);
  var_1 endon("new_prop_rotation" + var_0.model);
  var_0 endon("death");
  var_1 maps\_utility::add_endon("new_prop_rotation" + var_0.model);
  var_0 maps\_utility::add_endon("death");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "stop_loop");
  var_1 maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::do_wait_any();
  var_0 delete();
}

prop_delete_cig(var_0, var_1) {
  var_1 notify("new_prop_rotation" + var_0.model);
  var_1 endon("new_prop_rotation" + var_0.model);
  var_0 endon("death");
  var_1 maps\_utility::add_endon("new_prop_rotation" + var_0.model);
  var_0 maps\_utility::add_endon("death");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "stop_loop");
  var_1 maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::do_wait_any();
  var_0 thread prop_cig_throw();
}

prop_cig_throw() {
  self endon("death");

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.cig_throwing) && self.cig_throwing) {
    return;
  }
  self.cig_throwing = 1;
  stopfxontag(common_scripts\utility::getfx("cigar_glow"), self, "tag_cigarglow");
  var_0 = 3;
  var_1 = anglestoforward(self.angles);
  self unlink();
  self movegravity(var_1 * 100, var_0);
  self rotatevelocity((400, 0, 0), var_0, 0, var_0);
  wait(var_0);
  self delete();
}

smoke_puff(var_0) {
  if(!isdefined(var_0.cigar)) {
    return;
  }
  var_0 endon("death");
  var_0.cigar endon("death");
  playfxontag(common_scripts\utility::getfx("cigar_glow_puff"), var_0.cigar, "tag_cigarglow");
  wait 1;
  playfxontag(common_scripts\utility::getfx("cigar_smoke_puff"), var_0, "tag_eye");
}

smoke_exhale(var_0) {
  if(!isdefined(var_0.cigar)) {
    return;
  }
  playfxontag(common_scripts\utility::getfx("cigar_exhale"), var_0, "tag_eye");
}

ghillie_leaves() {
  var_0 = [];
  var_0[var_0.size] = "J_MainRoot";
  var_0[var_0.size] = "J_Hip_LE";
  var_0[var_0.size] = "J_Shoulder_RI";
  var_0[var_0.size] = "J_Head";
  var_0[var_0.size] = "J_Neck";
  var_0[var_0.size] = "J_Clavicle_RI";
  var_0[var_0.size] = "J_Ball_LE";
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

  for (;;) {
    while (self.movemode != "run") {
      wait 0.2;
      continue;
    }

    playfxontag(level._effect["ghillie_leaves"], self, common_scripts\utility::random(var_0));
    wait(randomfloatrange(0.1, 2.5));
  }
}

attach_cig_self() {
  attach_cig(self);
}