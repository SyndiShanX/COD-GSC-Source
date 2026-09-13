/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_25fe7f095b976329.gsc
***********************************************/

_id_B182EF8398A23949(_id_3777ECE6A73EADA5, maxdist, callback) {
  level endon("game_ended");
  self endon("disconnect");
  crate = undefined;

  for(;;) {
    crate = _id_AF8D4A24D632C42A(_id_3777ECE6A73EADA5, maxdist);

    if(crate != undefined) {
      break;
    }

    waitframe();
  }

  self[[callback]](crate);
}

_id_06ACECD6FBF30866(_id_3777ECE6A73EADA5, maxdist) {
  return isDefined(_id_AF8D4A24D632C42A(_id_3777ECE6A73EADA5, maxdist));
}

_id_0D7CBF1E3A78FCDC(params) {
  angle = params.angle;
  maxdistance = params.maxdistance;
  return _id_06ACECD6FBF30866(angle, maxdistance);
}

_id_AF8D4A24D632C42A(_id_3777ECE6A73EADA5, maxdist) {
  _id_7FB8E975ADD38476 = ["br_loot_cache", "br_loot_cache_lege"];

  foreach(_id_44844F47E6571A59 in _id_7FB8E975ADD38476) {
    lootcaches = getlootscriptablearrayinradius(_id_44844F47E6571A59, undefined, self.origin, maxdist);

    if(lootcaches.size > 0) {
      foreach(_id_36B81911E31BB387 in lootcaches) {
        if(!isDefined(_id_36B81911E31BB387.itemsdropped) && _id_67E2C9BD89ED9289::_id_ED838558EF4E4E91(_id_36B81911E31BB387, _id_3777ECE6A73EADA5))
          return _id_36B81911E31BB387;
      }
    }
  }

  return undefined;
}

_id_F3BE9FA4B21EAFC2(maxdist) {
  _id_7FB8E975ADD38476 = ["br_loot_cache", "br_loot_cache_lege"];
  _id_C110377A69278429 = [];

  foreach(_id_44844F47E6571A59 in _id_7FB8E975ADD38476) {
    lootcaches = [];
    lootcaches = getlootscriptablearrayinradius(_id_44844F47E6571A59, undefined, self.origin, maxdist);
    _id_C110377A69278429 = scripts\engine\utility::array_combine(lootcaches, _id_C110377A69278429);
  }

  return _id_C110377A69278429;
}