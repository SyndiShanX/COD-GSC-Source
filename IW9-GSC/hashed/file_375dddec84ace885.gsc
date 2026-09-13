/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_375dddec84ace885.gsc
***********************************************/

_id_9B277EEFF7FE104A(origin, angles, _id_F8F2EBF05B9AF55A) {
  _id_CE253278F5783484 = magicgrenademanual("bunkerbuster_mp", origin + (0, 0, 10), (0, 0, 10));
  waitframe();
  _id_CE253278F5783484.owner = spawnStruct();
  _id_CE253278F5783484.owner.angles = angles;
  _id_CE253278F5783484.owner.team = "neutral";
  _id_CE253278F5783484.team = "neutral";
  _id_CE253278F5783484.headiconid = _id_CE253278F5783484 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  level.players[0] _id_130B90141EB30189::_id_3D78DD516C25EF77(_id_CE253278F5783484);
  return _id_CE253278F5783484;
}

spawn_script_model_at_pos(tag, animname, model) {
  _id_2626560098D08682 = self gettagorigin(tag);
  _id_B7850001037AA074 = self gettagangles(tag);
  _id_D917428537562C1F = _id_2626560098D08682;
  startangles = _id_B7850001037AA074;
  spawned = spawn("script_model", _id_D917428537562C1F);
  spawned.angles = startangles;
  spawned setModel(model);
  spawned linkTo(self);

  if(isDefined(animname))
    spawned scriptmodelplayanim(animname);

  return spawned;
}