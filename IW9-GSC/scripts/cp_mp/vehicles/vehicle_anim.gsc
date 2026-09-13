/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_anim.gsc
***************************************************/

init_vehicles() {
  scripts\engine\utility::create_func_ref("fastrope_anim", ::fastrope_anim);
  scripts\engine\utility::create_func_ref("vehicle_door_anim", ::_id_93EECC7204143FA9);
}

fastrope_anim(model, animation, flag) {
  model dontinterpolate();
  model scriptmodelclearanim();
  model scriptmodelplayanimdeltamotionfrompos(getanimname(animation), model.origin, model.angles, flag);
}

#using_animtree("mp_vehicles_always_loaded");

_id_93EECC7204143FA9(vehicle, animation) {
  if(isDefined(vehicle)) {
    if(istrue(vehicle._id_7B349DC60A25D9FE)) {
      if(!istrue(vehicle._id_28140F53A0386F0E)) {
        vehicle._id_28140F53A0386F0E = 1;
        vehicle animScripted("placeholder", vehicle.scenenode.origin, vehicle.scenenode.angles, animation);
      }
    } else {
      vehicle animScripted("placeholder", vehicle.origin, vehicle.angles, %iw9_veh_blank_5_seconds);
      vehicle vehicleplayanim(animation, 0);
    }
  }
}

vehicleaniminit() {
  scripts\engine\utility::create_func_ref("use_turret", ::use_vehicle_turret);
}

set_vehicle_anims_mkilo23_ai_infil(_id_E4B7E99A96C8829F) {
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims_umike(_id_E4B7E99A96C8829F) {
  return _id_E4B7E99A96C8829F;
}

use_vehicle_turret(turret, _id_5CAA9F9F456B4040) {
  scripts\asm\asm_bb::bb_requestturret(turret);
  scripts\asm\asm_bb::bb_requestturretpose(_id_5CAA9F9F456B4040);
  origin = turret gettagorigin("tag_gunner");
  angles = turret gettagangles("tag_gunner");

  if(self islinked())
    self unlink();

  self forceteleport(origin, angles);
  self linktoblendtotag(turret, "tag_gunner", 0);
}