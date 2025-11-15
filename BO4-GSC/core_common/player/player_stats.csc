/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_stats.csc
***********************************************/

#namespace stats;

function_d92cb558(result, vararg) {
  if(!isDefined(result)) {
    pathstr = ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0];

    if(!isDefined(pathstr)) {
      return;
    }

    for(i = 1; i < vararg.size; i++) {
      pathstr = pathstr + "<dev string:x38>" + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
    }

    println("<dev string:x3c>" + pathstr);
  }
}

  function get_stat(localclientnum, ...) {
    result = readstat(localclientnum, currentsessionmode(), vararg);

    function_d92cb558(result, vararg);

      return result;
  }

function_842e069e(localclientnum, sessionmode, ...) {
  result = readstat(localclientnum, sessionmode, vararg);

  function_d92cb558(result, vararg);

    return result;
}

get_stat_global(localclientnum, statname) {
  return get_stat(localclientnum, #"playerstatslist", statname, #"statvalue");
}