/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\airsupport.csc
***********************************************/

#namespace namespace_bf7415ae;

function function_fc85e1a(killstreaktype, var_68f473e3, var_5be6ed28, var_56d8a98d, var_d8860ecf) {
  var_512049f7 = {};

  if(!isDefined(var_512049f7.markers)) {
    var_512049f7.markers = [];
  } else if(!isarray(var_512049f7.markers)) {
    var_512049f7.markers = array(var_512049f7.markers);
  }

  var_512049f7.var_bcc0d9a6 = var_68f473e3;
  var_512049f7.var_20549f15 = var_5be6ed28;
  var_512049f7.var_d19a1a47 = var_56d8a98d;
  var_512049f7.var_51d53d4d = var_d8860ecf;
  level.var_872c2ff[killstreaktype] = var_512049f7;
}

function function_9cb260fd(localclientnum, killstreaktype, marker) {
  var_512049f7 = level.var_872c2ff[killstreaktype];

  if(!isDefined(var_512049f7)) {
    return false;
  }

  for(i = 0; i < 4; i++) {
    if(!isDefined(var_512049f7.markers[i])) {
      if(var_512049f7.markers.size == 0) {
        level[[var_512049f7.var_bcc0d9a6]](localclientnum);
      }

      marker.var_595cc3a1 = i;
      var_512049f7.markers[i] = marker;
      level[[var_512049f7.var_d19a1a47]](localclientnum, marker);
      return true;
    }
  }

  return false;
}

function function_f06fadf2(localclientnum, killstreaktype, marker) {
  var_512049f7 = level.var_872c2ff[killstreaktype];

  if(!isDefined(var_512049f7) || !isDefined(marker.var_595cc3a1)) {
    return;
  }

  level[[var_512049f7.var_51d53d4d]](localclientnum, marker);
  var_512049f7.markers[marker.var_595cc3a1] = undefined;
  marker.var_595cc3a1 = undefined;

  if(var_512049f7.markers.size == 0) {
    level[[var_512049f7.var_20549f15]](localclientnum);
  }
}