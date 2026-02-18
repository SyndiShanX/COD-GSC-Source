/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_71b355b2496e3c6d.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_cc411409;

function preinit() {
  if(!isDefined(level.var_38bf45dc)) {
    clientfield::register("scriptmover", "ragdoll_launcher_id", 1, getminbitcountfornum(7), "int", &function_5f224893, 0, 0);
    clientfield::register("scriptmover", "ragdoll_launcher_mag", 1, getminbitcountfornum(4), "int", &function_338ef91c, 0, 0);
    clientfield::register("actor", "ragdoll_launcher_id", 1, getminbitcountfornum(7), "int", &function_e83889f9, 0, 0);
    level.var_38bf45dc = [undefined, 64, 128, 250];
  }
}

function function_5f224893(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_30858358)) {
    level.var_30858358 = [];
  }

  if(!isDefined(level.var_30858358[fieldname])) {
    level.var_30858358[fieldname] = [];
  }

  level.var_30858358[fieldname][bwastimejump] = {
    #ent: self, #time: getservertime(fieldname)
  };
  self.var_2011737d = bwastimejump;
}

function function_338ef91c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!(isDefined(self.var_2011737d) && isDefined(level.var_30858358[fieldname][self.var_2011737d])) || level.var_30858358[fieldname][self.var_2011737d].ent !== self) {
    println("<dev string:x38>");
    return;
  }

  level.var_30858358[fieldname][self.var_2011737d].var_3934e676 = bwastimejump;
}

function function_e83889f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  waittillframeend();

  if(!(isDefined(self) && isDefined(level.var_30858358[fieldname][bwastimejump].ent)) || getservertime(fieldname) - level.var_30858358[fieldname][bwastimejump].time > 500) {
    return;
  }

  zombieorigin = (self.origin[0], self.origin[1], self.origin[2] + 64);
  var_3f57677f = zombieorigin - level.var_30858358[fieldname][bwastimejump].ent.origin;
  dist = length(var_3f57677f);
  var_3f57677f /= dist;
  var_3f57677f *= level.var_38bf45dc[level.var_30858358[fieldname][bwastimejump].var_3934e676];
  self launchragdoll(var_3f57677f);
}