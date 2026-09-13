/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\deployablebox_vest.gsc
*********************************************************/

init() {
  _id_86280FEFB94B6B28 = spawnStruct();
  _id_86280FEFB94B6B28.id = "deployable_vest";
  _id_86280FEFB94B6B28.weaponinfo = "deployable_vest_marker_mp";
  _id_86280FEFB94B6B28.modelbase = "prop_ballistic_vest_iw6";
  _id_86280FEFB94B6B28.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
  _id_86280FEFB94B6B28.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  _id_86280FEFB94B6B28.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
  _id_86280FEFB94B6B28.event = "deployable_vest_taken";
  _id_86280FEFB94B6B28.streakname = "deployable_vest";
  _id_86280FEFB94B6B28.splashname = "used_deployable_vest";
  _id_86280FEFB94B6B28.shadername = "compass_objpoint_deploy_friendly";
  _id_86280FEFB94B6B28.headiconoffset = 20;
  _id_86280FEFB94B6B28.lifespan = 90.0;
  _id_86280FEFB94B6B28.usexp = 50;
  _id_86280FEFB94B6B28.scorepopup = "destroyed_vest";
  _id_86280FEFB94B6B28.vodestroyed = "ballistic_vest_destroyed";
  _id_86280FEFB94B6B28.deployedsfx = "mp_vest_deployed_ui";
  _id_86280FEFB94B6B28.onusesfx = "ammo_crate_use";
  _id_86280FEFB94B6B28.onusecallback = ::onusedeployable;
  _id_86280FEFB94B6B28.canusecallback = ::canusedeployable;
  _id_86280FEFB94B6B28.usetime = 1000;
  _id_86280FEFB94B6B28.maxhealth = 220;
  _id_86280FEFB94B6B28.damagefeedback = "deployable_bag";
  _id_86280FEFB94B6B28.deathvfx = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  _id_86280FEFB94B6B28.allowmeleedamage = 1;
  _id_86280FEFB94B6B28.allowgrenadedamage = 0;
  _id_86280FEFB94B6B28.maxuses = 4;
  _id_86280FEFB94B6B28.canuseotherboxes = 0;
  level.boxsettings["deployable_vest"] = _id_86280FEFB94B6B28;
  level.deployable_box["deployable_vest"] = [];
}

tryusedeployablevest(lifeid, streakname) {
  result = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(lifeid, "deployable_vest");

  if(!isDefined(result) || !result)
    return 0;

  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "deployable_vest", self.origin);
  return 1;
}

canusedeployable(_id_FBBAB18B5A41C7CB) {
  return !scripts\mp\lightarmor::haslightarmor(self);
}

onusedeployable(_id_FBBAB18B5A41C7CB) {
  scripts\mp\perks\perkfunctions::setlightarmor();
}

get_adjusted_armor(_id_F6415502BDC3AC54, _id_00AE17C5A8B1BC1B) {
  if(_id_F6415502BDC3AC54 + level.deployablebox_vest_rank[_id_00AE17C5A8B1BC1B] > level.deployablebox_vest_max)
    return level.deployablebox_vest_max;

  return _id_F6415502BDC3AC54 + level.deployablebox_vest_rank[_id_00AE17C5A8B1BC1B];
}