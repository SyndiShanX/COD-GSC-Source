/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_110cdbd677355ddb.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#namespace namespace_2b049a09;

function private autoexec __init__system__() {
  system::register(#"hash_635ff968b6476f85", &preload, undefined, undefined, undefined);
}

function private preload() {
  clientfield::register("toplayer", "get_anagram_solution", 1, 1, "int", &get_anagram_solution, 0, 0);
  serverfield::register("anagram_solution_index", 1, int(ceil(log2(60))), "int");
}

function private get_anagram_solution(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    var_9487875 = getscriptbundle("operation_chaos_anagrams");
    anagrams = [];

    foreach(idx, var_d0354c50 in var_9487875.anagrams) {
      anagrams[idx] = var_d0354c50.var_d0354c50;
    }

    var_e33f731b = function_e9a1119d(var_9487875.message, anagrams);

    if(var_e33f731b.size > 0) {
      var_8a11569b = array::random(var_e33f731b);
      serverfield::set("anagram_solution_index", var_8a11569b + 1);
    } else {
      serverfield::set("anagram_solution_index", 61);
    }

    wait 0.5;
    serverfield::set("anagram_solution_index", 0);
  }
}