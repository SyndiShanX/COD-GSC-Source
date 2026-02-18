/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_68732f44626820ed.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_207ea311;

function private autoexec __init__system__() {
  system::register(#"hash_684573a459d68beb", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "" + # "hash_63af42145e260fb5", 1, 2, "int", &function_4fd00e1f, 0, 0);
}

function private postinit() {}

function function_4fd00e1f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(level.var_3630f9c0)) {
    level.var_3630f9c0 = [];
  }

  if(!isDefined(level.var_3630f9c0[fieldname])) {
    level.var_3630f9c0[fieldname] = [];
  }

  var_47c85523 = self getentitynumber();
  var_e534cbe9 = 0;

  if(isDefined(level.var_3630f9c0[fieldname][var_47c85523])) {
    killfx(fieldname, level.var_3630f9c0[fieldname][var_47c85523]);
    level.var_3630f9c0[fieldname][var_47c85523] = undefined;
    var_e534cbe9 = 1;
  }

  if(bwastimejump > 0) {
    if(!var_e534cbe9) {
      self playSound(fieldname, #"hash_79a78504d4dbaf3f");
    }

    if(self zm_utility::function_f8796df3(fieldname)) {
      switch (bwastimejump) {
        case 1:
          str_fx = # "hash_679d39e5fd4eae19";
          break;
        case 2:
          str_fx = # "hash_462352157053fa4a";
          break;
        case 3:
          str_fx = # "hash_30b9d79f8b24fca";
          break;
      }

      if(viewmodelhastag(fieldname, "tag_flashlight")) {
        level.var_3630f9c0[fieldname][var_47c85523] = playviewmodelfx(fieldname, str_fx, "tag_flashlight");
      }

      if(!isDefined(level.var_3630f9c0[fieldname][var_47c85523])) {
        level.var_3630f9c0[fieldname][var_47c85523] = playviewmodelfx(fieldname, str_fx, "<dev string:x38>");
      }
    } else {
      switch (bwastimejump) {
        case 1:
          str_fx = # "hash_153f56ac9d13a399";
          break;
        case 2:
          str_fx = # "hash_64e79a7456f58dec";
          break;
        case 3:
          str_fx = # "hash_6d4cbc5e2d4daa6c";
          break;
      }

      level.var_3630f9c0[fieldname][var_47c85523] = util::playFXOnTag(fieldname, str_fx, self, "tag_flashlight");
    }

    if(self == function_5c10bd79(fieldname) && !is_true(level.var_6663d08b)) {
      util::function_8eb5d4b0(isDefined(level.var_59815895) ? level.var_59815895 : 3500, isDefined(level.var_40753b66) ? level.var_40753b66 : 0);
    }

    return;
  }

  if(var_e534cbe9) {
    self playSound(fieldname, #"hash_13715035b161a0c3");
  }

  if(self == function_5c10bd79(fieldname) && !is_true(level.var_6663d08b)) {
    util::function_8eb5d4b0(isDefined(level.var_49ba13b2) ? level.var_49ba13b2 : 3500, isDefined(level.var_674a073f) ? level.var_674a073f : 2.5);
  }
}