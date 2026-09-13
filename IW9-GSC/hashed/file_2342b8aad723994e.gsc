/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2342b8aad723994e.gsc
***********************************************/

onplayerjoinsquad(player) {
  if(!isDefined(level.onjoinsquadcallbacks))
    level.onjoinsquadcallbacks = [];

  foreach(callback in level.onjoinsquadcallbacks)
  self[[callback]](player);
}

registeronplayerjoinsquadcallback(callback) {
  if(!isDefined(level.onjoinsquadcallbacks))
    level.onjoinsquadcallbacks = [];

  level.onjoinsquadcallbacks[level.onjoinsquadcallbacks.size] = callback;
}

_id_2A1E4811621FDCDE(player) {
  if(!isDefined(level._id_DFE31F42A61AED79))
    level._id_DFE31F42A61AED79 = [];

  foreach(callback in level._id_DFE31F42A61AED79)
  self[[callback]](player);
}

_id_A99987C7BF114DA4(callback) {
  if(!isDefined(level._id_DFE31F42A61AED79))
    level._id_DFE31F42A61AED79 = [];

  level._id_DFE31F42A61AED79[level._id_DFE31F42A61AED79.size] = callback;
}