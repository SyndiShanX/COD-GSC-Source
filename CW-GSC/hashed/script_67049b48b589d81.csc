/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_67049b48b589d81.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_ec06fe4a;

function function_73d79e7d(parent, offset = (0, 0, 0)) {
  self endon(#"entityshutdown", #"death");

  while(isDefined(parent)) {
    self.origin = parent.origin + offset;
    waitframe(1);
  }

  self delete();
}

function function_d55f042c(other, note) {
  if(!isDefined(other)) {
    return;
  }

  self endon(#"entityshutdown", #"death");

  if(isPlayer(other)) {
    if(note == "disconnect") {
      other waittill(note);
    } else {
      other waittill(note, #"disconnect");
    }
  } else {
    other waittill(note);
  }

  if(isDefined(self)) {
    self delete();
  }
}

function spawnmodel(localclientnum, origin, modelname = "tag_origin", angles, targetname) {
  if(!validateorigin(origin)) {
    return;
  }

  if(getnumfreeentities(localclientnum) <= 0) {
    return;
  }

  mdl = util::spawn_model(localclientnum, modelname, origin, angles);

  if(isDefined(mdl) && isDefined(targetname)) {
    mdl.targetname = targetname;
  }

  return mdl;
}