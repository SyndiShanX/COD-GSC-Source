/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\vision_utility.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace vision_utility;

function function_27a921508cb04613(visionset, transitionduration) {
  assertex(isDefined(visionset) || visionset == "<dev string:x1c>", "<dev string:x20>");

  if(!isDefined(transitionduration)) {
    transitionduration = 0;
  }

  if(!isDefined(self.activevisionsetlist)) {
    self.activevisionsetlist = [];
  }

  if(!isDefined(self.activevisionsetlist[visionset])) {
    self.activevisionsetlist[visionset] = 1;
  } else {
    self.activevisionsetlist[visionset]++;
  }

  if(self.activevisionsetlist[visionset] == 1) {
    thread function_47c42aba7e6b41e3(visionset, transitionduration);
  }
}

function function_9a92ae402e209ecc(visionset, removeduration) {
  if(!isDefined(self.activevisionsetlist)) {
    return;
  }

  if(!isDefined(self.activevisionsetlist[visionset])) {
    return;
  }

  self.activevisionsetlist[visionset]--;

  if(self.activevisionsetlist[visionset] == 0) {
    var_bfd32f432f9daccf = [];

    foreach(visionindex, visionsetcount in self.activevisionsetlist) {
      if(visionindex == visionset) {
        continue;
      }

      var_bfd32f432f9daccf[visionindex] = visionsetcount;
    }

    self.activevisionsetlist = var_bfd32f432f9daccf;
    thread function_5936afcd0e190a3b(removeduration);
  }
}

function function_cb1caaf18300a508() {
  thread function_47c42aba7e6b41e3("", 0);

  if(isDefined(self.activevisionsetlist)) {
    self.activevisionsetlist = undefined;
  }
}

function function_8e888e08a6ab22d3(visionset) {
  if(!isDefined(self.activevisionsetlist) || !isDefined(self.activevisionsetlist[visionset])) {
    return false;
  }

  if(self.activevisionsetlist[visionset] > 0) {
    return true;
  }

  return false;
}

function private function_5936afcd0e190a3b(removeduration) {
  self endon("disconnect");
  level endon("game_ended");
  dur = 0;

  if(isDefined(removeduration)) {
    dur = removeduration;
  }

  thread function_47c42aba7e6b41e3("", dur);

  if(dur > 0) {
    wait dur;
    waitframe();
  }

  foreach(visionindex, visionsetcount in self.activevisionsetlist) {
    thread function_47c42aba7e6b41e3(visionindex, dur);
    waitframe();
  }
}

function private function_47c42aba7e6b41e3(visionset, transitionduration) {
  self endon("disconnect");
  level endon("game_ended");

  while(istrue(self.var_679f06b0517f5168)) {
    waitframe();
  }

  self.var_679f06b0517f5168 = 1;
  self visionsetnakedforplayer(visionset, transitionduration);

  if(transitionduration > 0) {
    wait transitionduration;
  }

  waitframe();
  self.var_679f06b0517f5168 = undefined;
}