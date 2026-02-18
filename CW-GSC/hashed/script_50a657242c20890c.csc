/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_50a657242c20890c.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_2a67e53;

function init() {
  clientfield::register("scriptmover", "" + # "hash_4545e81f76244b", 16000, 1, "int", &function_2810997c, 0, 0);
  clientfield::register("world", "" + # "hash_5c8a1cf9b543c223", 16000, getminbitcountfornum(5), "int", &function_114cfee9, 0, 0);
}

function function_114cfee9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(level.var_47807d96)) {
    assert(isint(level.var_47807d96));
    stopforcestreamingxmodel(#"hash_3bc4ed2f30d82d31" + level.var_47807d96);
  }

  if(bwasdemojump) {
    level.var_47807d96 = bwasdemojump;
    forcestreamxmodel(#"hash_3bc4ed2f30d82d31" + level.var_47807d96);
    forcestreamxmodel(#"hash_104dd148b019e861");
    forcestreamxmodel(#"hash_104dce48b019e348");
    forcestreamxmodel(#"hash_104dcf48b019e4fb");
    return;
  }

  level.var_47807d96 = undefined;
  stopforcestreamingxmodel(#"hash_104dd148b019e861");
  stopforcestreamingxmodel(#"hash_104dce48b019e348");
  stopforcestreamingxmodel(#"hash_104dcf48b019e4fb");
}

function function_2810997c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    var_8edcbb0e = struct::get("computer_cursor", "targetname");

    if(!isDefined(level.var_3c9f8e0b)) {
      level.var_3c9f8e0b = var_8edcbb0e.origin;
    }

    if(!isDefined(self.cursor)) {
      self.cursor = util::spawn_model(fieldname, "tag_origin", level.var_3c9f8e0b);
      self.cursor.fx = util::playFXOnTag(fieldname, #"hash_1be599238c15bbdf", self.cursor, "tag_origin");
    }

    self thread function_718ef5ea(self.cursor, var_8edcbb0e.origin);
    return;
  }

  if(isDefined(self.cursor)) {
    level.var_3c9f8e0b = self.cursor.origin;
    killfx(fieldname, self.cursor.fx);
    self.cursor delete();
    self.cursor = undefined;
  }
}

function function_718ef5ea(var_a7dcc4c7, v_center) {
  self endon(#"death");
  var_a7dcc4c7 endon(#"death");

  while(true) {
    v_target = var_a7dcc4c7.origin;

    if(self.origin[2] == 1) {
      v_target = v_center + (0, 60, -20) + self.origin[0] / 10000 * (0, cos(self.angles[0]) * -1, sin(self.angles[0]));
    } else if(self.origin[2] == 2) {
      v_target = v_center + (0, -40, -80) + self.origin[1] / 10000 * (0, sin(self.angles[1]), cos(self.angles[1]));
    }

    if(var_a7dcc4c7.origin != v_target) {
      if(!isDefined(var_a7dcc4c7.var_28cc73f6)) {
        var_a7dcc4c7.var_28cc73f6 = var_a7dcc4c7 playLoopSound(#"hash_7f519f5efb38d2ba");
      }

      var_a7dcc4c7 moveto(v_target, 0.05);
      var_a7dcc4c7 waittill(#"movedone");
      continue;
    }

    if(isDefined(var_a7dcc4c7.var_28cc73f6)) {
      var_a7dcc4c7 stoploopsound(var_a7dcc4c7.var_28cc73f6);
      var_a7dcc4c7.var_28cc73f6 = undefined;
    }

    waitframe(1);
  }
}