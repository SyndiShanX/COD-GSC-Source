/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\wildcards\wildcards.gsc
**********************************************/

#using scripts\common\callbacks;
#using scripts\cp_mp\challenges;
#using scripts\mp\perks\perks;
#namespace wildcards;

function autoexec preinit() {
  function_c9e23ef0cfb78673();
  level callback::add(#"register_perk", &registerwildcards);
}

function registerwildcards(params) {
  if(!isDefined(level.wildcardbundles)) {
    return;
  }

  perks::registerscriptperk("wildcard_danger_close", undefined, undefined, ["specialty_extra_deadly"]);
  perks::registerscriptperk("wildcard_tactical_expert", undefined, undefined, ["specialty_extraoffhandammo"]);
  perks::registerscriptperk("wildcard_overkill", undefined, undefined, undefined);
  perks::registerscriptperk("wildcard_gunfighter", undefined, undefined, undefined);
  perks::registerscriptperk("wildcard_field_captain", undefined, undefined, undefined);
  perks::registerscriptperk("wildcard_perk_greed", undefined, undefined, undefined);
  perks::registerscriptperk("wildcard_equipment_expert", undefined, undefined, ["specialty_bandolier"]);
  perks::registerscriptperk("wildcard_master_tactician", undefined, undefined, ["specialty_battle_ready"]);
  callback::add(#"hash_f873effec093bd7d", &function_72068572f6a5f816);
}

function function_c9e23ef0cfb78673() {
  str_list = level.gamemodebundle.wildcard_list;

  if(!isDefined(str_list)) {
    return;
  }

  if(!isDefined(level.wildcardbundles)) {
    level.wildcardbundles = [];
  }

  var_364b566f13cd8b14 = getscriptbundle(str_list);
  assert(isDefined(var_364b566f13cd8b14), "<dev string:x24>");
  assert(isDefined(var_364b566f13cd8b14.wildcard_list));

  if(!isDefined(var_364b566f13cd8b14.wildcard_list)) {
    return;
  }

  foreach(wildcardlistentry in var_364b566f13cd8b14.wildcard_list) {
    if(!isDefined(wildcardlistentry)) {
      continue;
    }

    wildcardref = wildcardlistentry.ref;

    if(!isDefined(wildcardref)) {
      continue;
    }

    wildcardbundlename = wildcardlistentry.bundle;

    if(!isDefined(wildcardbundlename)) {
      continue;
    }

    bundle = getscriptbundle(wildcardbundlename);

    if(!isDefined(bundle)) {
      continue;
    }

    level.wildcardbundles[wildcardref] = bundle;
  }
}

function function_64efa89a8031a2a5(wildcardref) {
  return level.wildcardbundles[wildcardref].var_a362c1b75ace930f;
}

function function_56215609cd11b947(wildcardref) {
  return level.wildcardbundles[wildcardref].var_a5109ca42cf62f91;
}

function function_72068572f6a5f816(params) {
  var_78b8e4a13e63bc01 = params.var_78b8e4a13e63bc01;
  var_86c674a64c35ed94 = params.var_86c674a64c35ed94;
  var_b1c3134299e971f7 = [];

  foreach(perk in var_78b8e4a13e63bc01) {
    wildcardbit = function_64efa89a8031a2a5(perk);
    wildcardbitfield = function_56215609cd11b947(perk);

    if(isDefined(wildcardbit) && isDefined(wildcardbitfield)) {
      switch (wildcardbitfield) {
        case 1:
          var_86c674a64c35ed94.var_ec7be02dd7cc6d7d = challenges::function_a23641f33e985edb(var_86c674a64c35ed94.var_ec7be02dd7cc6d7d, wildcardbit);
          break;
        case 2:
          var_86c674a64c35ed94.var_7111292ef37e4f97 = challenges::function_a23641f33e985edb(var_86c674a64c35ed94.var_7111292ef37e4f97, wildcardbit);
          break;
        default:
          break;
      }

      continue;
    }

    var_b1c3134299e971f7[var_b1c3134299e971f7.size] = perk;
  }

  params.var_78b8e4a13e63bc01 = var_b1c3134299e971f7;
  params.var_86c674a64c35ed94 = var_86c674a64c35ed94;
}