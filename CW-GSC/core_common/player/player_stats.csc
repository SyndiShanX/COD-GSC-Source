/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_stats.csc
***********************************************/

#namespace stats;

function function_d92cb558(result, vararg) {
  if(!isDefined(result)) {
    pathstr = ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0];

    if(!isDefined(pathstr)) {
      return;
    }

    for(i = 1; i < vararg.size; i++) {
      pathstr = pathstr + "<dev string:x38>" + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
    }

    println("<dev string:x3d>" + pathstr);
  }
}

function get_stat(localclientnum, ...) {
  result = readstat(localclientnum, currentsessionmode(), vararg);

  function_d92cb558(result, vararg);

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}

function function_842e069e(localclientnum, sessionmode, ...) {
  result = readstat(localclientnum, sessionmode, vararg);

  function_d92cb558(result, vararg);

  return result;
}

function get_stat_global(localclientnum, statname) {
  return get_stat(localclientnum, #"playerstatslist", statname, #"statvalue");
}

function get_match_stat(localclientnum, var_648fa3eb, ...) {
  result = readmatchstat(localclientnum, var_648fa3eb, vararg);

  function_d92cb558(result, vararg);

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}

function function_7f413ae3(localclientnum, sessionmode, ...) {
  result = function_fd428712(localclientnum, sessionmode, vararg);

  function_d92cb558(result, vararg);

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}