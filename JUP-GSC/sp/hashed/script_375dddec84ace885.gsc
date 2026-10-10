/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_375dddec84ace885.gsc
*************************************************/

#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\bunkerbuster;
#namespace namespace_afda4b8e83f2f71f;

function function_9b277eeff7fe104a(origin, angles, var_f8f2ebf05b9af55a) {
  dc = magicgrenademanual("bunkerbuster_mp", origin + (0, 0, 10), (0, 0, 10));
  waitframe();
  dc.owner = spawnStruct();
  dc.owner.angles = angles;
  dc.owner.team = "neutral";
  dc.team = "neutral";
  dc.headiconid = dc scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  level.players[0] function_3d78dd516c25ef77(dc);
  return dc;
}

function spawn_script_model_at_pos(tag, animname, model) {
  spawnorg = self gettagorigin(tag);
  spawnang = self gettagangles(tag);
  startorg = spawnorg;
  startangles = spawnang;
  spawned = spawn("script_model", startorg);
  spawned.angles = startangles;
  spawned setModel(model);
  spawned linkTo(self);

  if(isDefined(animname)) {
    spawned scriptmodelplayanim(animname);
  }

  return spawned;
}