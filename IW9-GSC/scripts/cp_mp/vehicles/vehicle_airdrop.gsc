/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_airdrop.gsc
******************************************************/

_id_CCDCF48542C8A5B7(_id_7731ADEF63E19B0C) {
  vehicledata = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);
  return isDefined(vehicledata) && isDefined(vehicledata._id_03EF9B41093F5752);
}

_id_66C684FEA143FBFD(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89) {
  vehicledata = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);
  _id_E99460BC50772002 = vehicledata._id_03EF9B41093F5752;

  if(!isDefined(spawndata.spawnmethod))
    spawndata.spawnmethod = "airdrop_at_position";

  if(!isDefined(spawndata.angles))
    spawndata.angles = (0, 0, 0);

  if(!isDefined(_id_E99460BC50772002)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "spawnPostAirdrop"))
      return [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "spawnPostAirdrop")]](spawndata, _id_EE8DA5624236DC89);

    return scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89);
  }

  scenenode = spawn("script_model", spawndata.origin);
  scenenode.angles = spawndata.angles;
  scenenode setModel("tag_origin");
  parachute = spawn("script_model", spawndata.origin);
  parachute.angles = spawndata.angles;
  parachute.animname = "parachute";
  parachute setModel(_id_E99460BC50772002._id_D87440189700E505);
  parachute scripts\common\anim::setanimtree();
  parachute forcenetfieldhighlod(1);
  parachute hide();
  carrier = spawn("script_model", spawndata.origin);
  carrier.angles = spawndata.angles;
  carrier.animname = "ac130";
  carrier setModel(_id_E99460BC50772002.planemodel);
  carrier scripts\common\anim::setanimtree();
  carrier hide();
  _id_D41B7D5F40F6A360 = spawn("script_model", spawndata.origin);
  _id_D41B7D5F40F6A360.angles = spawndata.angles;
  _id_D41B7D5F40F6A360.animname = _id_7731ADEF63E19B0C;
  model = vehicledata.model;

  if(isDefined(spawndata._id_14CDE247AC3313A4))
    model = spawndata._id_14CDE247AC3313A4 + "::" + model;

  _id_D41B7D5F40F6A360 setModel(model);
  _id_D41B7D5F40F6A360 scripts\common\anim::setanimtree();
  _id_D41B7D5F40F6A360 hide();
  scenenode.vehicle = _id_D41B7D5F40F6A360;
  scenenode.parachute = parachute;
  scenenode.carrier = carrier;
  scenenode.starttime = gettime() + level.frameduration;
  scenenode.endtime = gettime();
  scenenode.vehicleendtime = scenenode.starttime + getanimlength(level.scr_anim[_id_7731ADEF63E19B0C][_id_E99460BC50772002._id_0E25D1D189177A7C]) * 1000;

  if(scenenode.vehicleendtime > scenenode.endtime)
    scenenode.endtime = scenenode.vehicleendtime;

  scenenode.parachuteendtime = scenenode.starttime + getanimlength(level.scr_anim["parachute"][_id_E99460BC50772002._id_0E25D1D189177A7C]) * 1000;

  if(scenenode.parachuteendtime > scenenode.endtime)
    scenenode.endtime = scenenode.parachuteendtime;

  scenenode.carrierendtime = scenenode.starttime + getanimlength(level.scr_anim["ac130"][_id_E99460BC50772002._id_0E25D1D189177A7C]) * 1000;

  if(scenenode.carrierendtime > scenenode.endtime)
    scenenode.endtime = scenenode.carrierendtime;

  scenenode thread _id_C4F85850FB179639(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89, _id_E99460BC50772002);
  spawndata waittill("spawn", vehicle);
  return vehicle;
}

_id_C4F85850FB179639(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89, _id_E99460BC50772002) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, _id_E99460BC50772002._id_0E25D1D189177A7C);
  scripts\common\anim::anim_first_frame_solo(self.parachute, _id_E99460BC50772002._id_0E25D1D189177A7C);
  scripts\common\anim::anim_first_frame_solo(self.carrier, _id_E99460BC50772002._id_0E25D1D189177A7C);
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    thread scripts\common\anim::anim_single_solo(self.vehicle, _id_E99460BC50772002._id_0E25D1D189177A7C);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, _id_E99460BC50772002._id_0E25D1D189177A7C);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound(_id_E99460BC50772002._id_79C326E53691E2D8);

    foreach(part in _id_E99460BC50772002._id_3B720FF2A50CA7B1)
    self.carrier setscriptablepartstate(part._id_8A46C62F0A756DD3, "on", 0);

    thread scripts\common\anim::anim_single_solo(self.carrier, _id_E99460BC50772002._id_0E25D1D189177A7C);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || gettime() >= self.vehicleendtime)
      thread _id_B708213B1C5DC2A8(_id_7731ADEF63E19B0C, self.vehicle, spawndata, _id_EE8DA5624236DC89, _id_E99460BC50772002);

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime)
      self.parachute delete();

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime)
      self.carrier delete();

    waitframe();
  }

  _id_B708213B1C5DC2A8(_id_7731ADEF63E19B0C, self.vehicle, spawndata, _id_EE8DA5624236DC89, _id_E99460BC50772002);

  if(isDefined(self.parachute))
    self.parachute delete();

  if(isDefined(self.carrier))
    self.carrier delete();

  self delete();
}

_id_B708213B1C5DC2A8(_id_7731ADEF63E19B0C, _id_D41B7D5F40F6A360, spawndata, _id_EE8DA5624236DC89, _id_E99460BC50772002) {
  self.vehicle = undefined;

  if(!isDefined(_id_D41B7D5F40F6A360)) {
    return;
  }
  originalorigin = spawndata.origin;
  originalangles = spawndata.angles;
  spawndata.origin = _id_D41B7D5F40F6A360.origin;
  spawndata.angles = _id_D41B7D5F40F6A360.angles;
  _id_D41B7D5F40F6A360 delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "spawnPostAirdrop"))
    vehicle = [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "spawnPostAirdrop")]](spawndata, _id_EE8DA5624236DC89);
  else
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89);

  spawndata.origin = originalorigin;
  spawndata.angles = originalangles;
  spawndata notify("spawn", vehicle);

  if(isDefined(_id_E99460BC50772002._id_150B11A4DA8461BC)) {
    endtime = gettime() + getanimlength(level.scr_anim[_id_7731ADEF63E19B0C][_id_E99460BC50772002._id_150B11A4DA8461BC]) * 1000;

    if(endtime > self.endtime)
      self.endtime = endtime;

    vehicle._id_09882CD795C6BFAA = 1;
    vehicle.animname = _id_7731ADEF63E19B0C;
    vehicle vehphys_forcekeyframedmotion();
    thread scripts\common\anim::anim_single_solo(vehicle, _id_E99460BC50772002._id_150B11A4DA8461BC);

    while(gettime() <= endtime)
      waitframe();

    vehicle vehphys_setdefaultmotion();
  }

  vehicle thread _id_0F694F53C094603A(_id_E99460BC50772002);
}

_id_0F694F53C094603A(_id_E99460BC50772002) {
  self endon("death");
  self._id_09882CD795C6BFAA = 1;
  playsoundatpos(self.origin, _id_E99460BC50772002._id_98CF00A549D2C206);
  waitframe();
  endtime = gettime() + 3000;

  while(gettime() < endtime && !self vehicle_isonground())
    waitframe();

  origin = self.origin;

  if(self tagexists("tag_origin_static"))
    origin = self gettagorigin("tag_origin_static");

  _id_1FD2DCE85778A06A(_id_E99460BC50772002, origin, self.angles);
  self._id_09882CD795C6BFAA = undefined;
}

_id_1FD2DCE85778A06A(_id_E99460BC50772002, position, angles) {
  playFX(_id_E99460BC50772002.effect, position, anglesToForward(angles));
  playsoundatpos(position, _id_E99460BC50772002._id_5C73F15ED471884D);
  earthquake(_id_E99460BC50772002._id_2904DF1BE79620B6, _id_E99460BC50772002._id_0BDA0B1D6CCE0914, position, _id_E99460BC50772002._id_1CCED33303F26D02);
  playrumbleonposition("grenade_rumble", position);
  physicsexplosionsphere(position, _id_E99460BC50772002._id_A1939E49D568612B, _id_E99460BC50772002._id_9ED85C24DBCF8DA4, _id_E99460BC50772002._id_FDDF5FE707F47E54);
  self _meth_65AA053C077C003A(1);
  self.landed = 1;
  self notify("landed");
}