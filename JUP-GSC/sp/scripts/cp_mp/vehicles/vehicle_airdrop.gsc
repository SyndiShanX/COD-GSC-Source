/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\vehicles\vehicle_airdrop.gsc
*********************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#namespace vehicle_airdrop;

function function_ccdcf48542c8a5b7(vehicleref) {
  vehicledata = function_29b4292c92443328(vehicleref);
  return isDefined(vehicledata) && isDefined(vehicledata.airdrop);
}

function vehicle_airdrop(vehicleref, spawndata, faildata) {
  vehicledata = function_29b4292c92443328(vehicleref);
  airdropdata = vehicledata.airdrop;

  if(!isDefined(spawndata.spawnmethod)) {
    spawndata.spawnmethod = "airdrop_at_position";
  }

  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, 0, 0);
  }

  if(!isDefined(airdropdata)) {
    assertmsg("Tried to airdrop a vehicle which doesn't support it");

    if(scripts\engine\utility::issharedfuncdefined(vehicleref, "spawnPostAirdrop")) {
      return [[scripts\engine\utility::getsharedfunc(vehicleref, "spawnPostAirdrop")]](spawndata, faildata);
    }

    return vehicle_spawn(vehicleref, spawndata, faildata);
  }

  scenenode = spawn("script_model", spawndata.origin);
  scenenode.angles = spawndata.angles;
  scenenode setModel("tag_origin");
  parachute = spawn("script_model", spawndata.origin);
  parachute.angles = spawndata.angles;
  parachute.animname = "parachute";
  parachute setModel(airdropdata.parachutemodel);
  parachute scripts\common\anim::setanimtree();
  parachute forcenetfieldhighlod(1);
  parachute hide();
  carrier = spawn("script_model", spawndata.origin);
  carrier.angles = spawndata.angles;
  carrier.animname = "ac130";
  carrier setModel(airdropdata.planemodel);
  carrier scripts\common\anim::setanimtree();
  carrier hide();
  fakevehicle = spawn("script_model", spawndata.origin);
  fakevehicle.angles = spawndata.angles;
  fakevehicle.animname = vehicleref;
  model = vehicledata.model;

  if(isDefined(spawndata.skinoverride)) {
    model = spawndata.skinoverride + "::" + model;
  }

  fakevehicle setModel(model);
  fakevehicle scripts\common\anim::setanimtree();
  fakevehicle hide();
  scenenode.vehicle = fakevehicle;
  scenenode.parachute = parachute;
  scenenode.carrier = carrier;
  scenenode.starttime = gettime() + level.frameduration;
  scenenode.endtime = gettime();
  scenenode.vehicleendtime = scenenode.starttime + getanimlength(level.scr_anim[vehicleref][airdropdata.scenename]) * 1000;

  if(scenenode.vehicleendtime > scenenode.endtime) {
    scenenode.endtime = scenenode.vehicleendtime;
  }

  scenenode.parachuteendtime = scenenode.starttime + getanimlength(level.scr_anim["parachute"][airdropdata.scenename]) * 1000;

  if(scenenode.parachuteendtime > scenenode.endtime) {
    scenenode.endtime = scenenode.parachuteendtime;
  }

  scenenode.carrierendtime = scenenode.starttime + getanimlength(level.scr_anim["ac130"][airdropdata.scenename]) * 1000;

  if(scenenode.carrierendtime > scenenode.endtime) {
    scenenode.endtime = scenenode.carrierendtime;
  }

  scenenode thread function_c4f85850fb179639(vehicleref, spawndata, faildata, airdropdata);
  spawndata waittill("spawn", vehicle);
  return vehicle;
}

function private function_c4f85850fb179639(vehicleref, spawndata, faildata, airdropdata) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, airdropdata.scenename);
  scripts\common\anim::anim_first_frame_solo(self.parachute, airdropdata.scenename);
  scripts\common\anim::anim_first_frame_solo(self.carrier, airdropdata.scenename);
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    thread scripts\common\anim::anim_single_solo(self.vehicle, airdropdata.scenename);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, airdropdata.scenename);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound(airdropdata.planesound);

    foreach(part in airdropdata.planeparts) {
      self.carrier setscriptablepartstate(part.scriptablepart, "on", 0);
    }

    thread scripts\common\anim::anim_single_solo(self.carrier, airdropdata.scenename);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || gettime() >= self.vehicleendtime) {
      thread function_b708213b1c5dc2a8(vehicleref, self.vehicle, spawndata, faildata, airdropdata);
    }

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime) {
      self.parachute delete();
    }

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime) {
      self.carrier delete();
    }

    waitframe();
  }

  function_b708213b1c5dc2a8(vehicleref, self.vehicle, spawndata, faildata, airdropdata);

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  if(isDefined(self.carrier)) {
    self.carrier delete();
  }

  self delete();
}

function private function_b708213b1c5dc2a8(vehicleref, fakevehicle, spawndata, faildata, airdropdata) {
  self.vehicle = undefined;

  if(!isDefined(fakevehicle)) {
    return;
  }

  originalorigin = spawndata.origin;
  originalangles = spawndata.angles;
  spawndata.origin = fakevehicle.origin;
  spawndata.angles = fakevehicle.angles;
  fakevehicle delete();

  if(scripts\engine\utility::issharedfuncdefined(vehicleref, "spawnPostAirdrop")) {
    vehicle = [[scripts\engine\utility::getsharedfunc(vehicleref, "spawnPostAirdrop")]](spawndata, faildata);
  } else {
    vehicle = vehicle_spawn(vehicleref, spawndata, faildata);
  }

  spawndata.origin = originalorigin;
  spawndata.angles = originalangles;
  spawndata notify("spawn", vehicle);

  if(isDefined(airdropdata.var_150b11a4da8461bc)) {
    endtime = gettime() + getanimlength(level.scr_anim[vehicleref][airdropdata.var_150b11a4da8461bc]) * 1000;

    if(endtime > self.endtime) {
      self.endtime = endtime;
    }

    vehicle.var_9882cd795c6bfaa = 1;
    vehicle.animname = vehicleref;
    vehicle vehphys_forcekeyframedmotion();
    thread scripts\common\anim::anim_single_solo(vehicle, airdropdata.var_150b11a4da8461bc);

    while(gettime() <= endtime) {
      waitframe();
    }

    vehicle vehphys_setdefaultmotion();
  }

  vehicle thread function_f694f53c094603a(airdropdata);
}

function private function_f694f53c094603a(airdropdata) {
  self endon("death");
  self notify("freefall");
  self.var_9882cd795c6bfaa = 1;
  playsoundatpos(self.origin, airdropdata.var_98cf00a549d2c206);
  waitframe();
  endtime = gettime() + 3000;

  while(gettime() < endtime && !self vehicle_isonground()) {
    waitframe();
  }

  origin = self.origin;

  if(self tagexists("tag_origin_static")) {
    origin = self gettagorigin("tag_origin_static");
  }

  airdrop_land(airdropdata, origin, self.angles);
  self.var_9882cd795c6bfaa = undefined;
}

function private airdrop_land(airdropdata, position, angles) {
  playFX(airdropdata.effect, position, anglesToForward(angles));
  playsoundatpos(position, airdropdata.var_5c73f15ed471884d);
  earthquake(airdropdata.earthquakescale, airdropdata.earthquakeduration, position, airdropdata.earthquakeradius);
  playrumbleonposition("grenade_rumble", position);
  physicsexplosionsphere(position, airdropdata.physicsouterradius, airdropdata.physicsinnerradius, airdropdata.physicsscale);
  self vehphys_parkingbrake(1);
  self.landed = 1;
  self notify("landed");
}