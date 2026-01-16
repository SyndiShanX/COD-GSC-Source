/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_horse_ride.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_driving_fx;
#include clientscripts\_footsteps;

autoexec init() {
  println("*** Client : _horse_ride running...");

  clientscripts\_driving_fx::add_vehicletype_callback("horse_player", ::horse_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("horse_player_low", ::horse_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("horse", ::horse_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("horse_low", ::horse_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("horse_axis", ::horse_setup);
  clientscripts\_footsteps::registervehiclefootstepcallback("horse_player", ::horse_feet);
  clientscripts\_footsteps::registervehiclefootstepcallback("horse_player_low", ::horse_feet);
  clientscripts\_footsteps::registervehiclefootstepcallback("horse", ::horse_feet);
  clientscripts\_footsteps::registervehiclefootstepcallback("horse_low", ::horse_feet);
  clientscripts\_footsteps::registervehiclefootstepcallback("horse_axis", ::horse_feet);
  level.horsefootstepbones = [];
  level.horsefootstepbones["step_front_left_idle"] = "Bone_H_HandEnd_L";
  level.horsefootstepbones["step_front_right_idle"] = "Bone_H_HandEnd_R";
  level.horsefootstepbones["step_rear_left_idle"] = "Bone_H_FootEnd_L";
  level.horsefootstepbones["step_rear_right_idle"] = "Bone_H_FootEnd_R";
  level.horsefootstepbones["step_front_left_walk"] = "Bone_H_HandEnd_L";
  level.horsefootstepbones["step_front_right_walk"] = "Bone_H_HandEnd_R";
  level.horsefootstepbones["step_rear_left_walk"] = "Bone_H_FootEnd_L";
  level.horsefootstepbones["step_rear_right_walk"] = "Bone_H_FootEnd_R";
  level.horsefootstepbones["step_front_left_trot"] = "Bone_H_HandEnd_L";
  level.horsefootstepbones["step_front_right_trot"] = "Bone_H_HandEnd_R";
  level.horsefootstepbones["step_rear_left_trot"] = "Bone_H_FootEnd_L";
  level.horsefootstepbones["step_rear_right_trot"] = "Bone_H_FootEnd_R";
  level.horsefootstepbones["step_front_left_canter"] = "Bone_H_HandEnd_L";
  level.horsefootstepbones["step_front_right_canter"] = "Bone_H_HandEnd_R";
  level.horsefootstepbones["step_rear_left_canter"] = "Bone_H_FootEnd_L";
  level.horsefootstepbones["step_rear_right_canter"] = "Bone_H_FootEnd_R";
  level.horsefootstepbones["step_front_left_sprint"] = "Bone_H_HandEnd_L";
  level.horsefootstepbones["step_front_right_sprint"] = "Bone_H_HandEnd_R";
  level.horsefootstepbones["step_rear_left_sprint"] = "Bone_H_FootEnd_L";
  level.horsefootstepbones["step_rear_right_sprint"] = "Bone_H_FootEnd_R";
  level._effect["horse_step"] = loadfx("vehicle/treadfx/fx_afgh_treadfx_horse_hoof_impact");
}

horse_setup(localclientnum) {
  self thread clientscripts\_driving_fx::collision_thread(localclientnum);
}

getfootorigin(note) {
  assert(isDefined(level.horsefootstepbones));
  boneorigin = (0, 0, 0);
  bonename = level.horsefootstepbones[note];

  if(isDefined(bonename))
    boneorigin = self gettagorigin(bonename);

  if(!isDefined(boneorigin))
    boneorigin = self.origin;
  else
    boneorigin = boneorigin - vectorscale((0, 0, 1), 2.0);

  return boneorigin;
}

getfooteffect(ground_type) {
  return level._effect["horse_step"];
}

horse_feet(localclientnum, note, ground_type) {
  origin = getfootorigin(note);
  sound_alias = "fly_" + note;

  if(self islocalclientdriver(localclientnum))
    sound_alias = sound_alias + "_plr";
  else
    sound_alias = sound_alias + "_npc";

  sound_alias = sound_alias + "_" + ground_type;
  playsound(localclientnum, sound_alias, origin);
  effect = getfooteffect(ground_type);

  if(isDefined(effect))
    playfx(localclientnum, effect, origin, (0, 0, 1));

  if(self islocalclientdriver(localclientnum)) {
    if(note == "step_front_left_walk" || note == "step_rear_left_walk" || note == "step_front_left_trot" || note == "step_rear_left_trot" || note == "step_front_left_run" || note == "step_rear_left_run" || note == "step_front_left_canter" || note == "step_rear_left_canter" || note == "step_front_left_sprint" || note == "step_rear_left_sprint") {
      player = getlocalplayer(localclientnum);
      player playrumbleonentity(localclientnum, "pullout_small");
      speed = self getspeed() / 17.6;
      speed = abs(speed) / 25.0;
      intensity = 0.065 + 0.065 * speed;
      player earthquake(intensity, 0.3, self.origin, 200);
    }
  }
}