/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\scriptable.gsc
*****************************************/

#using scripts\engine\scriptable;
#namespace scriptable;

function event_handler[scriptable_init] scriptable_initialize() {
  scriptable_engineinitialize();
}

function event_handler[scriptable_postinit] scriptable_post_initialize() {
  scriptable_enginepostinitialize();
}

function event_handler[scriptable_used] scriptable_used(instance, part, state, player, bautouse, usestring) {
  scriptable_engineused(instance, part, state, player, bautouse, usestring);
}

function event_handler[event_29dd481f3803ceb8] function_9e50a452d3f2500c(instance, part, state, player) {
  return function_904787b1a7ed4f61(instance, part, state, player);
}

function event_handler[event_750d33ea094cd662] function_3f1e5be32aa9e0e3(instance, part, state, player, useduration) {
  function_190abcbcb4f3a47c(instance, part, state, player, useduration);
}

function event_handler[event_fab19dbfa32508bc] function_fab19dbfa32508bc(instance, player) {
  return function_1e33a4f0f19aa3a(instance, player);
}

function event_handler[scriptable_damage] function_dc8eae0479686591(note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function riotshield_damaged(note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  scriptable_enginedamaged(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function event_handler[scriptable_touched] scriptable_touched(instance, part, state, player) {
  scriptable_enginetouched(instance, part, state, player);
}

function event_handler[event_90b3dac3d776d2f6] function_b4f2f1e43208be2d(id, scriptables) {
  function_ce0492ba57130ca4(id, scriptables);
}

function event_handler[event_c26bb161f32a8f79] function_e238758bb6d06ce2(event, scriptables) {
  function_f9851d1984d0205c(event, scriptables);
}

function event_handler[scriptable_notify] scriptable_notify_callback(instance, note, param, ent, var_64ffacba090c91be) {
  scriptable_enginenotifycallback(instance, note, param, ent, var_64ffacba090c91be);
}