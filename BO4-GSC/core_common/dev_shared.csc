/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\dev_shared.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\util_shared;

#namespace dev_shared;

autoexec init() {
  callback::on_localclient_connect(&function_b49b1b6b);
}

function_b49b1b6b(localclientnum) {
  var_39073e7a = undefined;
  var_b49b1b6b = undefined;
  a_effects = array("<dev string:x38>", "<dev string:x5f>", "<dev string:x8c>");
  var_767a6d22 = 0;

  while(true) {
    n_dist = getdvarint(#"hash_4348ec71a8b13ef1", 0);
    var_114d05f = int(min(getdvarint(#"hash_4ead99200e3cc72c", 0), a_effects.size - 1));

    if(n_dist > 0) {
      if(var_114d05f != var_767a6d22 && isDefined(var_b49b1b6b)) {
        killfx(localclientnum, var_b49b1b6b);
        var_b49b1b6b = undefined;
      }

      if(!isDefined(var_39073e7a)) {
        var_39073e7a = util::spawn_model(localclientnum, "<dev string:xbc>");
      }

      if(!isDefined(var_b49b1b6b)) {
        var_b49b1b6b = util::playFXOnTag(localclientnum, a_effects[var_114d05f], var_39073e7a, "<dev string:xbc>");
      }

      v_pos = getcamposbylocalclientnum(localclientnum);
      v_ang = getcamanglesbylocalclientnum(localclientnum);
      v_forward = anglesToForward(v_ang);
      var_39073e7a.origin = v_pos + v_forward * n_dist;
      var_39073e7a.angles = v_ang;
    } else if(isDefined(var_39073e7a)) {
      killfx(localclientnum, var_b49b1b6b);
      var_39073e7a delete();
      var_b49b1b6b = undefined;
    }

    var_767a6d22 = var_114d05f;
    waitframe(1);
  }
}

