/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_animatedmodels.gsc
***********************************************/

main() {
  if(!isDefined(level._id_0E2F)) {
    level._id_0E2F = [];
  }

  var_0 = getarraykeys(level._id_0E2F);

  foreach(var_2 in var_0) {
    var_3 = getarraykeys(level._id_0E2F[var_2]);

    foreach(var_5 in var_3) {
      _precachempanim(level._id_0E2F[var_2][var_5]);
    }
  }

  waittillframeend;
  level._id_515E = [];
  var_8 = getEntArray("animated_model", "targetname");
  common_scripts\utility::_id_0FB2(var_8, ::_id_0E9F);
  level._id_515E = undefined;
}

_id_0E9F() {
  if(isDefined(self.animation)) {
    var_0 = self.animation;
  } else {
    var_1 = getarraykeys(level._id_0E2F[self.model]);
    var_2 = var_1[randomint(var_1.size)];
    var_0 = level._id_0E2F[self.model][var_2];
  }

  self scriptmodelplayanim(var_0);
  self willneverchange();
}