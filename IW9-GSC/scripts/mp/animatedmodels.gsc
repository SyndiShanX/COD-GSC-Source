/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animatedmodels.gsc
***********************************************/

main() {
  if(!isDefined(level.anim_prop_models))
    level.anim_prop_models = [];

  _id_51A20B6FD58CAE03 = getarraykeys(level.anim_prop_models);

  foreach(_id_31CF32F960C6F482 in _id_51A20B6FD58CAE03) {
    _id_6D561966D417CD69 = getarraykeys(level.anim_prop_models[_id_31CF32F960C6F482]);

    foreach(_id_11CF4DD2B6426D80 in _id_6D561966D417CD69)
    precachempanim(level.anim_prop_models[_id_31CF32F960C6F482][_id_11CF4DD2B6426D80]);
  }

  waittillframeend;
  level.init_animatedmodels = [];
  _id_AC87F2FCC1FCC893 = getEntArray("animated_model", "targetname");
  scripts\engine\utility::array_thread_amortized(_id_AC87F2FCC1FCC893, ::animatemodel, 0.05);
  level.init_animatedmodels = undefined;
}

animatemodel() {
  if(isDefined(self.animation))
    animation = self.animation;
  else {
    keys = getarraykeys(level.anim_prop_models[self.model]);
    _id_948996ABB8726D7B = keys[randomint(keys.size)];
    animation = level.anim_prop_models[self.model][_id_948996ABB8726D7B];
  }

  self scriptmodelplayanim(animation);
  self willneverchange();
}