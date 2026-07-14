/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\dev.gsc
**************************************/

#using scripts\engine\utility;
#namespace dev;

function devcommandwatcher(dvarname, commandhandlerfunc) {
  setdevdvar(dvarname, "<dev string:x24>");

  while(true) {
    waitframe();
    dvarvalue = getDvar(dvarname);

    if(dvarvalue == "<dev string:x24>") {
      continue;
    }

    setdevdvar(dvarname, "<dev string:x24>");
    tokens = strtok(dvarvalue, "<dev string:x28>");

    if(!isDefined(tokens) || tokens.size < 1) {
      continue;
    }

    command = tokens[0];
    arglist = utility::array_slice(tokens, 1);
    [[commandhandlerfunc]](command, arglist);
  }
}

# /