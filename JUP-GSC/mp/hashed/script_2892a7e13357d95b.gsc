/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2892a7e13357d95b.gsc
*************************************************/

#using script_4a6760982b403bad;
#namespace namespace_a9be6690006809fc;

function function_c43f9411e4146fbd() {
  lpconlevel = #"undefined";

  if(isDefined(level.var_a7b62649c81b481a) && isDefined(level.var_a7b62649c81b481a.var_acc161de36707de2)) {
    var_cb6979b637e87c98 = level.var_a7b62649c81b481a.var_acc161de36707de2;

    switch (var_cb6979b637e87c98) {
      case 0:
        lpconlevel = #"hash_c6851a6deebc5413";
        break;
      case 1:
        lpconlevel = #"hash_7d305d057fa7b947";
        break;
      case 2:
        lpconlevel = #"hash_c63664e808c01db2";
        break;
      case 3:
        lpconlevel = #"hash_3c2f470545de38d3";
        break;
      case 4:
        lpconlevel = #"hash_69645756fbedb0a2";
        break;
      case 5:
        lpconlevel = #"hash_b75819a959589344";
        break;
    }
  }

  return lpconlevel;
}