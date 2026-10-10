/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\scriptable.gsc
***********************************************/

#using scripts\engine\scriptable;
#namespace scriptable;

function scriptable_initialize() {
  scripts\engine\scriptable::scriptable_engineinitialize();
}

function scriptable_post_initialize() {
  scripts\engine\scriptable::scriptable_enginepostinitialize();
}

function scriptable_used(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  scripts\engine\scriptable::scriptable_engineused(instance, part, state, player, var_a5b2c541413aa895, usestring);
}

function function_9ea56c6edd53918(instance, part, state, player, useduration) {
  scripts\engine\scriptable::function_2cdeacfad7141a8d(instance, part, state, player, useduration);
}

function function_944d769de0e6d4cb(instance, player) {
  return scripts\engine\scriptable::function_43f2de646836802d(instance, player);
}

function function_4a7afd1c05864574(note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  scripts\engine\scriptable::scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function riotshield_damaged(note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  scripts\engine\scriptable::scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function scriptable_touched(instance, part, state, player) {
  scripts\engine\scriptable::scriptable_enginetouched(instance, part, state, player);
}

function scriptable_notify_callback(instance, note, param, ent, var_535d9c3fdddab5a9) {
  scripts\engine\scriptable::scriptable_enginenotifycallback(instance, note, param, ent, var_535d9c3fdddab5a9);
}