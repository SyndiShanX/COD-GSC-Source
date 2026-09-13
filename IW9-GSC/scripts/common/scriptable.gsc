/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\scriptable.gsc
***********************************************/

scriptable_initialize() {
  scripts\engine\scriptable::scriptable_engineinitialize();
}

scriptable_post_initialize() {
  scripts\engine\scriptable::scriptable_enginepostinitialize();
}

scriptable_used(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  scripts\engine\scriptable::scriptable_engineused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_944D769DE0E6D4CB(instance, player) {
  return scripts\engine\scriptable::_id_43F2DE646836802D(instance, player);
}

riotshield_damaged(_id_A234A65C378F3289, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  scripts\engine\scriptable::scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

scriptable_touched(instance, part, state, player) {
  scripts\engine\scriptable::scriptable_enginetouched(instance, part, state, player);
}

scriptable_notify_callback(_id_A234A65C378F3289, param, ent) {
  scripts\engine\scriptable::scriptable_enginenotifycallback(_id_A234A65C378F3289, param, ent);
}