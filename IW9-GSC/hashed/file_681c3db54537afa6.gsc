/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_681c3db54537afa6.gsc
***********************************************/

_id_7B988E1BB56CA747(grenade) {
  grenade endon("death");

  if(!isDefined(level._id_4405E76242D7CB8E))
    level._id_4405E76242D7CB8E = 0;

  grenade scripts\cp_mp\ent_manager::registerspawn(1, _id_45C10CA5CB8409BF::_id_558D562EB33EA61D);
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto) && stuckto scripts\cp_mp\vehicles\vehicle::isvehicle())
    grenade._id_37A6165D55074798 = 1;

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      grenade delete();
      return;
    }
  }

  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade setnonstick(1);
  grenade.usedcount = 0;
  grenade.deployingplayer = self;
  grenade._id_89EE7EBA7B1862CF = [];
  trigger = spawn("trigger_rotatable_radius", grenade.origin, 0, 80, 300);
  trigger.angles = grenade.angles;
  grenade.trigger = trigger;
  trigger enablelinkTo();
  trigger linkTo(grenade);
  scripts\mp\weapons::onequipmentplanted(grenade, "equip_sound_veil", _id_45C10CA5CB8409BF::_id_558D562EB33EA61D, 1);
  grenade scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  maxhealth = 100;
  grenade thread scripts\mp\damage::monitordamage(maxhealth, "hitequip", _id_45C10CA5CB8409BF::_id_F313405D166290BE, _id_45C10CA5CB8409BF::_id_50B1D2352A6A686A, 0);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(_id_45C10CA5CB8409BF::_id_B434EA15774ED770);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(_id_45C10CA5CB8409BF::_id_391EBDDE9E0EEC71);
  grenade _id_45C10CA5CB8409BF::_id_49197CD063A740EA(_id_45C10CA5CB8409BF::_id_558D562EB33EA61D);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
  }

  grenade _id_45C10CA5CB8409BF::_id_74844A68121C9B36();
}