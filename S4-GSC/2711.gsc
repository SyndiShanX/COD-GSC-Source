/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2711.gsc
*************************************************/

_id_AB6B(var_0) {
  thread _id_AB6D(var_0);

  if(isDefined(level._id_AB09)) {
    foreach(var_2 in level._id_AB09) {
      self[[var_2]](var_0);
    }
  }
}

_id_C28A(var_0) {
  if(!isDefined(level._id_AB09)) {
    level._id_AB09 = [];
  }

  level._id_AB09[level._id_AB09.size] = var_0;
}

_id_AB6D(var_0) {
  var_0 notify("onPlayerJoinTeamNoSpectator");

  if(var_0.sessionstate == "spectator") {
    var_0 endon("death_or_disconnect");
    var_0 endon("onPlayerJoinTeamNoSpectator");

    while(var_0.sessionstate == "spectator") {
      waitframe();
    }
  }

  if(isDefined(level._id_AB0A)) {
    foreach(var_2 in level._id_AB0A) {
      self[[var_2]](var_0);
    }
  }
}

_id_C28B(var_0) {
  if(!isDefined(level._id_AB0A)) {
    level._id_AB0A = [];
  }

  level._id_AB0A[level._id_AB0A.size] = var_0;
}