/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\dev.gsc
***********************************************/



#using scripts\engine\utility;
#namespace dev;

function devcommandwatcher(dvarname, commandhandlerfunc) {
  setdevdvar(dvarname, "<dev string:x1c>");

  while(true) {
    waitframe();
    dvarvalue = getDvar(dvarname);

    if(dvarvalue == "<dev string:x1c>") {
      continue;
    }

    setdevdvar(dvarname, "<dev string:x1c>");
    tokens = strtok(dvarvalue, "<dev string:x1d>");

    if(!isDefined(tokens) || tokens.size < 1) {
      continue;
    }

    command = tokens[0];
    arglist = array_slice(tokens, 1);
    [[commandhandlerfunc]](command, arglist);
  }
}

# /