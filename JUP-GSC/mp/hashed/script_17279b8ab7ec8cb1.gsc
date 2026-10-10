/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_17279b8ab7ec8cb1.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace namespace_1b0f1390bc5ade38;

function autoexec main() {
  function_c0b3ddc9a6bdcc46("veh_jup_ob_tank_escort", &function_666e94a4d2565651);
}

function private function_666e94a4d2565651() {
  if(!function_9697379150687859("veh_jup_ob_tank_escort")) {
    return;
  }

  callbacks = [];
  callbacks["spawnPostAirdrop"] = &function_2219f2ce2638836f;
  level callback::add("on_zombie_ai_damaged", &function_c78cc3de6029da95);
  function_8497e7e46b5e397("veh_jup_ob_tank_escort", callbacks);
}

function private function_2219f2ce2638836f(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh_jup_ob_tank_escort", spawndata, faildata);
  spawndata thread function_9ab88fc150ee805b();
  v_payload = vehicle gettagorigin("tag_attach_rocket");
  vehicle.payload = spawn("script_model", v_payload);
  linktooriginoffset = (0, 0, 0);

  if(isDefined(spawndata.str_payload)) {
    switch (spawndata.str_payload) {
      case #"hash_8b48887639da2db5":
        vehicle.payload setModel("veh_jup_zm_tank_escort_rocket_scriptable");
        break;
      case #"hash_748800eb74151258":
        vehicle.payload setModel("veh_jup_zm_tank_escort_act_2_neutralizer_scriptable");
        linktooriginoffset = (0, 0, 32);
        break;
      default:
        vehicle.payload delete();
        break;
    }
  } else {
    vehicle.payload delete();
  }

  if(isDefined(vehicle.payload)) {
    vehicle.payload linkTo(vehicle, "tag_attach_rocket", linktooriginoffset, (0, 0, 0));
  }

  vehicle thread function_c805554fd02a8515(spawndata.activity_instance);

  if(istrue(spawndata.is_usable)) {
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeusable(vehicle);
  } else {
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vehicle);
  }

  return vehicle;
}

function private function_c78cc3de6029da95(params) {
  if(params.objweapon.basename == "ob_tank_escort_mp" && params.idamage >= self.health && params.smeansofdeath == "MOD_CRUSH") {
    vehspeed = params.eattacker vehicle_getspeed();

    if(vehspeed >= 3) {
      self.forceannihilate = 1;
    }
  }
}

function private function_c805554fd02a8515(activity_instance) {
  self endon("death");
  self waittill("freefall");
  wait 2;

  if(isDefined(activity_instance) && istrue(activity_instance.was_cancelled)) {
    if(isDefined(self.payload)) {
      self.payload delete();
    }

    if(isDefined(self)) {
      self dodamage(self.health + 99999, self.origin);
    }
  }
}

function private function_9ab88fc150ee805b() {
  self waittill("husk_spawn", vehicle_husk);
  wait 30;

  if(isDefined(vehicle_husk) && vehicle_husk isvehiclehusk()) {
    vehicle_husk function_e3ff0a92ad2bf58d();
  }
}