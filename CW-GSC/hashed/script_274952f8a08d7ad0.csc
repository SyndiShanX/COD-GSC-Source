/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_274952f8a08d7ad0.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#namespace cinematicmotion;

function private autoexec __init__system__() {
  system::register(#"cinematicmotion", &preinit, undefined, undefined, undefined);
}

function preinit(localclientnum) {
  n_bits = getminbitcountfornum(11);
  clientfield::register("toplayer", "cinematicMotion", 1, n_bits, "int", &function_877ad7c4, 0, 1);
}

function function_877ad7c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname != bwastimejump) {
    self function_c64b5405(bwastimejump);
  }
}

function function_c64b5405(newval) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  switch (newval) {
    case 0:
      self function_eadd0084();
      break;
    case 1:
      self function_7aa6104();
      break;
    case 2:
      self function_19690481();
      break;
    case 3:
      self function_7f56196();
      break;
    case 4:
      self function_19a404f3();
      break;
    case 5:
      self function_f27b36a2();
      break;
    case 6:
      self function_4887c796();
      break;
    case 7:
      self function_22441ab3();
      break;
    case 8:
      self function_5a740afe();
      break;
    case 9:
      self function_681e2652();
      break;
    case 10:
      self function_bd015017();
      break;
    case 11:
      self function_ccb26f79();
      break;
    default:
      break;
  }
}

function function_8152b11(param) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(param != "") {
    self setcinematicmotionoverride(param);
    return;
  }

  self setcinematicmotionoverride();
}

function function_bd8097ae(duration, endval) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(!isDefined(endval)) {
    return;
  }

  var_9a52780d = float(endval);

  if(isDefined(duration)) {
    var_48f70e07 = float(duration);
  }

  if(!isDefined(var_48f70e07)) {
    var_48f70e07 = 0;
  }

  if(!isDefined(var_9a52780d)) {
    var_9a52780d = 0;
  }

  if(var_48f70e07 > 0) {
    var_6f465937 = self function_d40e85f();
    self function_6757d9a1(var_6f465937, var_9a52780d, var_48f70e07);
    return;
  }

  self function_97c2dab8(var_9a52780d);
}

function function_6757d9a1(startval, endval, duration) {
  self notify("571c05ff9137e8da");
  self endon("571c05ff9137e8da");
  self endon(#"death_or_disconnect");
  currenttime = gettime();
  duration *= 1000;
  endtime = int(currenttime + duration);
  diff = abs(startval - endval);

  while(true) {
    currenttime = gettime();
    t = math::clamp(1 - (endtime - currenttime) / duration, 0, 1);
    frac = lerpfloat(startval, endval, t);
    self function_97c2dab8(frac);

    if(t == 1) {
      break;
    }

    waitframe(1);
  }
}

function function_4887c796() {
  self function_97c2dab8(1);
}

function function_22441ab3() {
  self thread function_6757d9a1(0, 1, 1);
}

function function_5a740afe() {
  self thread function_6757d9a1(0, 1, 2);
}

function function_681e2652() {
  self thread function_6757d9a1(0, 1, 3);
}

function function_bd015017() {
  self thread function_6757d9a1(0, 1, 4);
}

function function_ccb26f79() {
  self thread function_6757d9a1(0, 1, 5);
}

function function_eadd0084() {
  self function_97c2dab8(0);
}

function function_7aa6104() {
  self thread function_6757d9a1(1, 0, 1);
}

function function_19690481() {
  self thread function_6757d9a1(1, 0, 2);
}

function function_7f56196() {
  self thread function_6757d9a1(1, 0, 3);
}

function function_19a404f3() {
  self thread function_6757d9a1(1, 0, 4);
}

function function_f27b36a2() {
  self thread function_6757d9a1(1, 0, 5);
}