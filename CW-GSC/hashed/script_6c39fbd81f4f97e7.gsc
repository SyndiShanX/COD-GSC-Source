/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6c39fbd81f4f97e7.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\snd;
#namespace namespace_9205a0df;

function private autoexec __init__system__() {
  system::register(#"hash_6460ff5d340f6751", undefined, &postload, undefined, undefined);
}

function postload() {
  level.overrideactordamage = &actor_damage_override;
  callback::on_actor_killed(&on_actor_killed);
}

function actor_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex) {
  if(timeoffset === getweapon(#"hash_6460ff5d340f6751") && shitloc == "MOD_PISTOL_BULLET") {
    self thread function_df0660b4(vpoint, boneindex, var_fd90b0bb, weapon, modelindex, vdir, timeoffset);
    return 0;
  }

  return vpoint;
}

function function_df0660b4(idamage, vpoint, eattacker, einflictor, shitloc, idflags, weapon) {
  self endon(#"death");
  wait 0.2;
  self dodamage(idamage, vpoint, eattacker, einflictor, shitloc, "MOD_BURNED", idflags, weapon);
}

function on_actor_killed(params) {
  if(params.weapon === getweapon(#"hash_6460ff5d340f6751")) {
    var_e05a6ec8 = snd::play("evt_firestarter_ai_fire_lp", self gettagorigin("j_spine4"));
    wait 3;
    wait 2;
    snd::stop(var_e05a6ec8, 0.75);
  }
}