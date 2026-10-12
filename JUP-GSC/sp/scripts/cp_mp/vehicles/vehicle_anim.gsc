/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_anim.gsc
***************************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace vehicle_anim;

function init_vehicles() {
  create_func_ref("fastrope_anim", &fastrope_anim);
  create_func_ref("vehicle_door_anim", &vehicle_anim);
}

function fastrope_anim(model, animation, flag) {
  model dontinterpolate();
  model scriptmodelclearanim();
  model scriptmodelplayanimdeltamotionfrompos(getanimname(animation), model.origin, model.angles, flag);
}

#using_animtree("mp_vehicles_always_loaded");

function vehicle_anim(vehicle, animation) {
  if(isDefined(vehicle)) {
    if(istrue(vehicle.animintro)) {
      if(!istrue(vehicle.var_28140f53a0386f0e)) {
        vehicle.var_28140f53a0386f0e = 1;
        vehicle animScripted("placeholder", vehicle.scenenode.origin, vehicle.scenenode.angles, animation);
      }

      return;
    }

    vehicle animScripted("placeholder", vehicle.origin, vehicle.angles, %iw9_veh_blank_5_seconds);
    vehicle vehicleplayanim(animation, 0);
  }
}

function vehicleaniminit() {
  scripts\engine\utility::create_func_ref("use_turret", &utility::use_turret);
}

function set_vehicle_anims_mkilo23_ai_infil(positions) {
  return positions;
}

function set_vehicle_anims_umike(positions) {
  return positions;
}